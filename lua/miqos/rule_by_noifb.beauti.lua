--[[
  小米路由器 QoS 无 IFB 设备规则模块
  MiQoS No-IFB Rules Module
  
  功能说明:
  - 不使用 IFB (Intermediate Functional Block) 设备的 QoS 实现
  - 直接在物理接口上进行流量控制
  - 支持 HTB 队列规则和服务类型分类
  - 支持主机级别的带宽限制
  - 支持访客网络和小米设备的独立限速
]]

require("miqos.common")

local luci_ip = require("luci.ip")

qdisc["noifb"] = {}

local noifb_config = {
    qos = {
        ack = false,
        syn = true,
        fin = true,
        rst = true,
        icmp = true,
        small = false
    },
    
    online_timeout = {
        wl = 5,
        wi = 300
    }
}

local htb_class_config = {
    dft = 20480,
    quan_v = 1600,
    
    root = {
        id = 4096,
        quan = 2,
        fwmark = "0x00010000/0x000f0000",
        fprio = "5"
    },
    
    child = {
        special = {
            id = 8192,
            prio = "1",
            quan = 2,
            fwmark = "0x00020000/0x000f0000",
            fprio = "5",
            rate = 0.1,
            ceil = 0.5,
            highest_prio = apply_arp_small_filter
        },
        host = {
            id = 12288,
            prio = "4",
            quan = 2,
            fwmark = "0x00030000/0x000f0000",
            fprio = "5",
            rate = 0.7,
            ceil = 0.98,
            supress = 2048
        },
        guest = {
            id = 16384,
            prio = "6",
            quan = 1,
            fwmark = "0x00040000/0x000f0000",
            fprio = "5",
            rate = 0.1,
            ceil = 0,
            limit = cfg.guest
        },
        xq = {
            id = 20480,
            prio = "7",
            quan = 1,
            fwmark = "0x00050000/0x000f0000",
            fprio = "5",
            rate = 0.05,
            ceil = 0,
            limit = cfg.xq
        }
    }
}

local service_subclass = {
    game = {
        id = 1,
        type = "game",
        rate = 0.1,
        ceil = 0.6,
        mark = {
            fwmark = "0x00130000/0x00ff0000",
            fprio = "4"
        }
    },
    web = {
        id = 2,
        type = "web",
        rate = 0.35,
        ceil = 1,
        mark = {
            fwmark = "0x00230000/0x00ff0000",
            fprio = "4"
        }
    },
    video = {
        id = 3,
        type = "video",
        rate = 0.45,
        ceil = 1,
        mark = {
            fwmark = "0x00330000/0x00ff0000",
            fprio = "4"
        }
    },
    download = {
        id = 4,
        type = "download",
        rate = 0.1,
        ceil = 0.95,
        mark = {
            fwmark = "0x00430000/0x00ff0000",
            fprio = "4"
        },
        default = true
    }
}

local online_hosts = {}
local host_limit_info = {}
local host_status = {}

local function clear_host_status()
    for ip, info in pairs(host_status) do
        host_status[ip].net = nil
        host_status[ip].limit = nil
        host_status[ip] = nil
    end
end

local function clean_noifb_qdisc(dev_list)
    local commands = {}
    
    for _, dev_info in pairs(dev_list) do
        local cmd = string.format("%s del dev %s root ", const_tc_qdisc, dev_info.dev)
        table.insert(commands, cmd)
    end
    
    if #commands > 0 then
        exec_cmd(commands, nil)
    end
    
    clear_host_status()
    host_status.changed = true
end

qdisc["noifb"].clean = clean_noifb_qdisc

local function is_same_subnet(ip1, ip2, mask)
    if ip1 == nil or ip2 == nil or mask == nil then
        return false
    end
    
    local ipv4_1 = luci_ip.IPv4(ip1)
    local ipv4_2 = luci_ip.IPv4(ip2)
    
    if ipv4_1 and ipv4_2 then
        local network1 = luci_ip.cidr.network(ipv4_1, mask)
        local network2 = luci_ip.cidr.network(ipv4_2, mask)
        
        if network1 and network2 then
            return luci_ip.cidr.equal(network1, network2)
        end
    end
    
    return false
end

local function update_host_net_status()
    for ip, info in pairs(host_status) do
        local new_net = info.net.new
        
        if new_net == "" then
            host_status[ip].net = nil
            host_status[ip].limit = nil
            host_status[ip] = nil
        else
            info.net.old = info.net.new
            info.net.new = ""
            info.limit.changed = 0
        end
    end
end

local function scan_online_hosts()
    local devices = g_ubus.call(g_ubus, "trafficd", "hw", {})
    online_hosts = {}
    
    if not devices then
        return
    end
    
    for _, device in pairs(devices) do
        local mac = device.hw
        local is_wireless = false
        
        if string.find(device.ifname, "wl", 1) then
            is_wireless = true
        end
        
        for _, ip_info in pairs(device.ip_list) do
            local is_online = false
            
            if is_wireless then
                if device.assoc == 1 then
                    is_online = true
                end
            elseif not is_wireless then
                if ip_info.ageing_timer <= noifb_config.online_timeout.wi then
                    is_online = true
                end
            end
            
            if is_online then
                local net_type = "guest"
                local ip = ip_info.ip
                local ip_parts = string.split(ip_info.ip, ".")
                local host_id = ip_parts[4]
                
                if cfg.lan.ip and cfg.lan.mask then
                    local in_subnet = is_same_subnet(ip, cfg.lan.ip, tonumber(cfg.lan.mask))
                    if in_subnet then
                        net_type = "host"
                    end
                end
                
                online_hosts[ip] = {
                    mac = mac,
                    UP = {},
                    DOWN = {}
                }
                
                local max_up = 0
                local max_down = 0
                
                if g_group_def[mac] then
                    max_up = math.ceil(g_group_def[mac].max_grp_uplink or 0)
                    max_down = math.ceil(g_group_def[mac].max_grp_downlink or 0)
                    online_hosts[ip][UP].max_per = max_up
                    online_hosts[ip][DOWN].max_per = max_down
                end
                
                if max_up < 8 or max_up > math.ceil(cfg.bands.UP) then
                    if max_down < 8 or max_down > math.ceil(cfg.bands.DOWN) then
                        if host_status[ip] then
                            host_status[ip].net.new = ""
                        else
                            if max_up < 8 then
                                max_up = cfg.bands.UP
                            end
                            if max_down < 8 then
                                max_down = cfg.bands.DOWN
                            end
                            
                            if not host_status[ip] then
                                host_status[ip] = {
                                    mac = mac,
                                    id = host_id,
                                    ip = ip,
                                    net = {
                                        old = "",
                                        new = net_type
                                    },
                                    limit = {
                                        UP = max_up,
                                        DOWN = max_down,
                                        changed = 1
                                    }
                                }
                            else
                                host_status[ip].net.new = net_type
                                
                                if host_status[ip].limit.UP ~= max_up or 
                                   host_status[ip].limit.DOWN ~= max_down then
                                    logger(3, "limit changed, mac: " .. mac .. ",ip: " .. ip ..
                                        ",UP:" .. host_status[ip].limit.UP .. "->" .. max_up ..
                                        ",DOWN:" .. host_status[ip].limit.DOWN .. "->" .. max_down)
                                    
                                    host_status[ip].limit = {
                                        UP = max_up,
                                        DOWN = max_down,
                                        changed = 1
                                    }
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function get_service_priority(flow_seq, service_type)
    local prio_config = seq_prio[flow_seq]
    if not prio_config then
        prio_config = seq_prio.auto
    end
    return prio_config[service_type] or 4
end

local function generate_host_class_rules(commands, dev_list, action, parent_id, host_info)
    local subclass_count = #service_subclass
    local cmd = ""
    local host_id = host_info.id
    local class_id = parent_id + host_id * 16
    local limit = host_info.limit
    
    local max_up = math.ceil(limit.UP)
    if max_up > math.ceil(cfg.bands.UP) then
        limit.UP = cfg.bands.UP
    end
    
    local max_down = math.ceil(limit.DOWN)
    if max_down > math.ceil(cfg.bands.DOWN) then
        limit.DOWN = cfg.bands.DOWN
    end
    
    local action_symbol = "*"
    if action == "add" then
        action_symbol = "+"
    elseif action == "del" then
        action_symbol = "-"
    end
    
    logger(3, action_symbol .. " " .. host_info.ip .. ",mac:" .. host_info.mac ..
        ", UP:" .. host_info.limit.UP .. ", DOWN:" .. host_info.limit.DOWN)
    
    local prio_str = ""
    if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
        prio_str = " prio 4 "
    end
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        local rate_config = htb_class_config.child[direction]
        local ceil = math.ceil(limit[direction])
        local burst, cburst = get_burst(ceil)
        local quantum = htb_class_config.quan_v * 2
        local rate = rate_config
        
        if rate > ceil then
            rate = ceil
        end
        
        if action == "del" then
            cmd = string.format("%s %s dev %s classid %s:%s ",
                const_tc_class, action, dev, qdisc_id, dec2hexstr(class_id))
            table.insert(commands, 1, cmd)
        elseif action == "change" then
            cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %s burst %d cburst %d quantum %s",
                const_tc_class, action, dev, qdisc_id, dec2hexstr(parent_id),
                qdisc_id, dec2hexstr(class_id), rate, UNIT, ceil, UNIT, prio_str, burst, cburst, quantum)
            table.insert(commands, 1, cmd)
        else
            cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %s burst %d cburst %d quantum %s",
                const_tc_class, action, dev, qdisc_id, dec2hexstr(parent_id),
                qdisc_id, dec2hexstr(class_id), rate, UNIT, ceil, UNIT, prio_str, burst, cburst, quantum)
            table.insert(commands, cmd)
        end
        
        if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
            apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(class_id), ceil, true)
            
            cmd = string.format("%s %s dev %s parent %s: prio 2 handle 0x%s00000/0xff000000 fw classid %s:%s ",
                const_tc_filter, action, dev, qdisc_id, dec2hexstr(host_id), qdisc_id, dec2hexstr(class_id))
            
            if action == "del" then
                table.insert(commands, 1, cmd)
            elseif action ~= "change" then
                table.insert(commands, cmd)
            end
        else
            local default_class_id = 0
            
            for svc_name, svc_config in pairs(service_subclass) do
                local svc_offset = host_id * 16 + svc_config.id
                local svc_class_id = parent_id + svc_offset
                
                if action == "del" then
                    cmd = string.format("%s %s dev %s classid %s:%s ",
                        const_tc_class, action, dev, qdisc_id, dec2hexstr(svc_class_id))
                    table.insert(commands, 1, cmd)
                else
                    local svc_rate = math.ceil(rate * svc_config.rate)
                    local svc_ceil = math.ceil(ceil * svc_config.ceil)
                    local svc_burst, svc_cburst = get_burst(svc_ceil)
                    local svc_prio = get_service_priority(cfg.flow.seq, svc_name)
                    
                    cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s " ..
                        "quantum %s burst %d cburst %d ",
                        const_tc_class, action, dev, qdisc_id, dec2hexstr(class_id),
                        qdisc_id, dec2hexstr(svc_class_id), svc_rate, UNIT, svc_ceil, UNIT, svc_prio,
                        quantum, svc_burst, svc_cburst)
                    
                    if action == "change" then
                        table.insert(commands, 1, cmd)
                    else
                        table.insert(commands, cmd)
                        apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(svc_class_id), svc_ceil, true)
                    end
                end
                
                cmd = string.format("%s %s dev %s parent %s: prio 2 handle 0x%s00000/0xfff00000 fw classid %s:%s ",
                    const_tc_filter, action, dev, qdisc_id, dec2hexstr(svc_offset), qdisc_id, dec2hexstr(svc_class_id))
                
                if action == "del" then
                    table.insert(commands, 1, cmd)
                elseif action ~= "change" then
                    table.insert(commands, cmd)
                end
                
                if svc_config.default then
                    default_class_id = svc_class_id
                    
                    if default_class_id ~= 0 then
                        cmd = string.format("%s %s dev %s parent %s: prio 3 handle 0x%s000000/0xff000000 fw classid %s:%s ",
                            const_tc_filter, action, dev, qdisc_id, dec2hexstr(host_id), qdisc_id, dec2hexstr(default_class_id))
                        
                        if action == "del" then
                            table.insert(commands, 1, cmd)
                        elseif action ~= "change" then
                            table.insert(commands, cmd)
                        end
                    end
                end
            end
        end
    end
    
    return true
end

local function generate_all_host_rules(dev_list, parent_id, bands)
    local commands = {}
    
    scan_online_hosts()
    
    for ip, host_info in pairs(host_status) do
        local old_net = host_info.net.old
        
        if old_net == "" then
            local new_net = host_info.net.new
            if new_net == "host" then
                local has_limit = host_info.limit.UP ~= 0 or host_info.limit.DOWN ~= 0
                if has_limit then
                    generate_host_class_rules(commands, dev_list, "add", parent_id, host_info)
                end
            end
        else
            if old_net == "host" then
                local new_net = host_info.net.new
                
                if new_net == "guest" then
                    generate_host_class_rules(commands, dev_list, "del", parent_id, host_info)
                elseif new_net == "host" then
                    if host_info.limit.changed == 1 then
                        generate_host_class_rules(commands, dev_list, "change", parent_id, host_info)
                    end
                else
                    generate_host_class_rules(commands, dev_list, "del", parent_id, host_info)
                end
            else
                if host_info.net.new == "host" then
                    generate_host_class_rules(commands, dev_list, "add", parent_id, host_info)
                end
            end
        end
    end
    
    update_host_net_status()
    
    if #commands > 0 then
        exec_cmd(commands, nil)
        return true
    end
    
    return true
end

local function check_config_changed()
    return true
end

qdisc["noifb"].changed = check_config_changed

local function calculate_min_bandwidth(bands)
    local min_up = math.ceil(bands[UP] / 15)
    local min_down = math.ceil(bands[DOWN] / 15)
    
    if min_up < 40 then
        min_up = 40
    end
    if min_down < 80 then
        min_down = 80
    end
    
    return {
        UP = min_up,
        DOWN = min_down
    }
end

local function generate_noifb_qdisc(dev_list, bands)
    local commands = {}
    local cmd = ""
    local action = "add"
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        local total_band = bands[direction]
        
        local root_quantum = math.ceil(htb_class_config.quan_v * htb_class_config.root.quan)
        local root_class_hex = dec2hexstr(htb_class_config.root.id)
        local root_burst, root_cburst = get_burst(total_band)
        
        cmd = string.format("%s %s dev %s root handle %s: %s htb default %s ",
            const_tc_qdisc, action, dev, qdisc_id, get_stab_string(dev), dec2hexstr(htb_class_config.dft))
        table.insert(commands, cmd)
        
        cmd = string.format("%s %s dev %s parent %s: classid %s:%s htb rate %s%s quantum %s burst %d cburst %d",
            const_tc_class, action, dev, qdisc_id, qdisc_id, root_class_hex,
            total_band, UNIT, root_quantum, root_burst, root_cburst)
        table.insert(commands, cmd)
        
        cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:0",
            const_tc_filter, action, dev, qdisc_id,
            htb_class_config.root.fprio, htb_class_config.root.fwmark, qdisc_id)
        table.insert(commands, cmd)
        
        apply_ppp_qdisc(commands, dev, qdisc_id)
        
        local parent_hex = root_class_hex
        
        for child_name, child_config in pairs(htb_class_config.child) do
            local child_id = child_config.id
            local child_prio = child_config.prio
            local child_rate = math.ceil(total_band * child_config.rate)
            local child_ceil = math.ceil(total_band * child_config.ceil)
            
            if child_config.limit then
                local limit_value = math.ceil(child_config.limit[direction])
                child_ceil = limit_value
                
                if child_ceil <= 1 then
                    child_ceil = math.ceil(total_band * child_ceil)
                end
            end
            
            if child_name == "host" then
                child_ceil = get_supressed_ceil(child_ceil, child_config.supress)
            end
            
            if child_rate > child_ceil then
                child_rate = child_ceil
            end
            
            if child_ceil ~= 0 then
                local child_burst, child_cburst = get_burst(child_ceil)
                local child_quantum = child_config.quan * htb_class_config.quan_v
                
                cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s " ..
                    "prio %s quantum %s burst %d cburst %d",
                    const_tc_class, action, dev, qdisc_id, parent_hex,
                    qdisc_id, dec2hexstr(child_id), child_rate, UNIT, child_ceil, UNIT,
                    child_prio, child_quantum, child_burst, child_cburst)
                table.insert(commands, cmd)
                
                if child_name == "special" then
                    if noifb_config.qos.small and child_config.highest_prio then
                        child_config.highest_prio(commands, dev, action, qdisc_id, dec2hexstr(child_id))
                    end
                elseif child_name == "host" then
                    local host_parent_id = child_id
                    
                    for svc_name, svc_config in pairs(service_subclass) do
                        local svc_class_id = host_parent_id + svc_config.id
                        local svc_rate = math.ceil(child_rate * svc_config.rate)
                        local svc_ceil = math.ceil(child_ceil * svc_config.ceil)
                        
                        if svc_rate > svc_ceil then
                            svc_rate = svc_ceil
                        end
                        
                        local svc_prio = get_service_priority(cfg.flow.seq, svc_name)
                        
                        cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s " ..
                            "quantum %s burst %d cburst %d ",
                            const_tc_class, action, dev, qdisc_id, dec2hexstr(host_parent_id),
                            qdisc_id, dec2hexstr(svc_class_id), svc_rate, UNIT, svc_ceil, UNIT, svc_prio,
                            child_quantum, child_burst, child_cburst)
                        table.insert(commands, cmd)
                        
                        apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(svc_class_id), svc_ceil, true)
                        
                        if svc_config.mark.fwmark and svc_config.mark.fwmark ~= "" then
                            cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                                const_tc_filter, action, dev, qdisc_id,
                                svc_config.mark.fprio, svc_config.mark.fwmark, qdisc_id, dec2hexstr(svc_class_id))
                            table.insert(commands, cmd)
                        end
                        
                        if svc_config.default then
                            cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                                const_tc_filter, action, dev, qdisc_id,
                                child_config.fprio, child_config.fwmark, qdisc_id, dec2hexstr(svc_class_id))
                            table.insert(commands, cmd)
                        end
                    end
                end
                
                if child_name ~= "host" and child_name ~= "leteng" then
                    if child_config.fwmark and child_config.fwmark ~= "" then
                        cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                            const_tc_filter, action, dev, qdisc_id,
                            child_config.fprio, child_config.fwmark, qdisc_id, dec2hexstr(child_id))
                        table.insert(commands, cmd)
                        
                        apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(child_id), child_ceil, true)
                    end
                end
            end
        end
    end
    
    if #commands > 0 then
        exec_cmd(commands, nil)
        return true
    end
    
    return true
end

local function update_child_class(child_name, dev_list, bands)
    local commands = {}
    local action = "change"
    local cmd = ""
    
    local child_config = htb_class_config.child[child_name]
    if not child_config then
        logger(3, "child class " .. child_name .. " not found in mainframe.")
        return false
    end
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        local child_id = child_config.id
        local parent_id = htb_class_config.root.id
        local total_band = bands[direction]
        
        local child_rate = math.ceil(child_config.rate * total_band)
        local child_ceil = child_config.ceil
        
        if child_ceil == 0 then
            child_ceil = child_config.limit[direction]
        end
        
        if child_ceil == 0 then
            child_ceil = total_band
        elseif child_ceil <= 1 then
            child_ceil = math.ceil(total_band * child_ceil)
        end
        
        if child_ceil <= 8 then
            child_ceil = 8
        end
        
        if child_rate > child_ceil then
            child_rate = child_ceil
        end
        
        local child_prio = child_config.prio
        local child_burst, child_cburst = get_burst(child_ceil)
        local child_quantum = child_config.quan * htb_class_config.quan_v
        
        cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s " ..
            "prio %s quantum %s burst %d cburst %d",
            const_tc_class, action, dev, qdisc_id, dec2hexstr(parent_id),
            qdisc_id, dec2hexstr(child_id), child_rate, UNIT, child_ceil, UNIT,
            child_prio, child_quantum, child_burst, child_cburst)
        table.insert(commands, cmd)
    end
    
    if #commands > 0 then
        exec_cmd(commands, nil)
    end
end

local function check_guest_changes(dev_list, bands)
    local change_desc = ""
    local changed = false
    
    if cfg.guest.changed == 1 then
        change_desc = change_desc .. "/guest"
        cfg.guest.changed = 0
        changed = true
    end
    
    if change_desc ~= "" then
        logger(3, "CHANGE: " .. change_desc)
    end
    
    if changed then
        update_child_class("guest", dev_list, bands)
    end
end

local function check_xq_changes(dev_list, bands)
    local change_desc = ""
    local changed = false
    
    if cfg.xq.changed == 1 then
        change_desc = change_desc .. "/xq"
        cfg.xq.changed = 0
        changed = true
    end
    
    if change_desc ~= "" then
        logger(3, "CHANGE: " .. change_desc)
    end
    
    if changed then
        update_child_class("xq", dev_list, bands)
    end
end

local function apply_noifb_changes(prev_qdisc, bands, dev_list, force)
    local min_bands = calculate_min_bandwidth(bands)
    host_limit_info = min_bands
    
    logger(3, "CHANGE: noifb")
    
    if prev_qdisc then
        qdisc["noifb"].clean(dev_list)
        generate_noifb_qdisc(dev_list, bands)
    end
    
    check_guest_changes(dev_list, bands)
    check_xq_changes(dev_list, bands)
    
    return true
end

local special_host_filter = {
    HIGH_PRIO_WITHOUT_LIMIT = {
        ftprio = "1",
        flow = "0"
    },
    HIGH_PRIO_WITH_BANDLIMIT = {
        ftprio = "2",
        flow = "2000"
    }
}

local function read_qos_config()
    local result = read_qos_group_config()
    if not result then
        logger(3, "read_qos_group_config failed.")
        return false
    end
    
    result = read_qos_guest_xq_config()
    if not result then
        logger(3, "read_qos_guest_xq_config failed.")
        return false
    end
    
    return true
end

qdisc["noifb"].read_qos_config = read_qos_config

local function apply_guest_qdisc(guest_limit)
    local commands = {}
    
    local cmd = string.format("%s del dev br-guest root ", const_tc_qdisc)
    table.insert(commands, cmd)
    
    local ceil = guest_limit.DOWN * cfg.bands.DOWN
    local burst, cburst = get_burst(ceil)
    
    cmd = string.format("%s add dev br-guest root handle 3: htb default 1000 ", const_tc_qdisc)
    table.insert(commands, cmd)
    
    cmd = string.format("%s add dev br-guest parent 3: classid 3:1000 htb rate %s%s quantum 3200 burst %d cburst %d",
        const_tc_class, ceil, UNIT, burst, cburst)
    table.insert(commands, cmd)
    
    local result = exec_cmd(commands, 1)
    if not result then
        logger(3, "ERROR: clean qdisc rules for host mode failed!")
    end
end

local function apply_noifb_qdisc(prev_qdisc, bands, dev_list, force)
    apply_noifb_changes(bands, origin_disc, dev_list, cfg.bands)
    
    generate_all_host_rules(dev_list, htb_class_config.child.host.id, htb_class_config.child.guest.id)
    
    apply_guest_qdisc(cfg.guest.inner)
    
    return true
end

qdisc["noifb"].apply = apply_noifb_qdisc

local function update_counters(dev_list)
    if cfg.enabled.flag == "0" then
        return
    end
    
    local result = {}
    
    if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
        scan_online_hosts()
    end
    
    for ip, host_info in pairs(online_hosts) do
        local flag = "on"
        
        if not g_group_def[host_info.mac] then
            flag = "off"
        else
            if g_group_def[host_info.mac].flag then
                flag = g_group_def[host_info.mac].flag
            else
                local max_up = tonumber(g_group_def[host_info.mac].max_grp_uplink or 0)
                local max_down = tonumber(g_group_def[host_info.mac].max_grp_downlink or 0)
                
                if max_up <= 0 or max_down <= 0 then
                    flag = "off"
                end
            end
        end
        
        local host_result = {
            MAC = host_info.mac,
            UP = {
                min = 0,
                min_per = 0,
                min_cfg = 0,
                max = 0 .. "Kbit",
                max_per = host_info.UP.max_per or 0,
                max_cfg = 0
            },
            DOWN = {
                min = 0,
                min_per = 0,
                min_cfg = 0,
                max = 0 .. "Kbit",
                max_per = host_info.DOWN.max_per or 0,
                max_cfg = 0
            },
            flag = flag
        }
        
        result[ip] = host_result
        
        if host_status[ip] then
            result[ip].UP.max = host_status[ip].limit.UP or (0 .. "Kbit")
            result[ip].DOWN.max = host_status[ip].limit.DOWN or (0 .. "Kbit")
        end
    end
    
    return result
end

qdisc["noifb"].update_counters = update_counters
