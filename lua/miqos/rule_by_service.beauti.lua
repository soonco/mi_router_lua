--[[
  小米路由器 MiQoS 基于服务的QoS规则模块
  
  功能说明:
  - 基于服务类型(游戏/网页/视频/下载)的流量控制
  - 使用HTB(Hierarchical Token Bucket)队列算法
  - 支持主机/访客/小米设备的带宽分配
  - 动态检测在线主机并应用QoS规则
  
  HTB类层级结构:
  - root (0x1000): 根类，总带宽
  - special (0x2000): 特殊流量类(ARP/SYN/FIN/RST/ICMP)
  - host (0x3000): 主网络主机类
  - guest (0x4000): 访客网络类
  - xq (0x5000): 小米设备类
  
  服务子类(在host类下):
  - game: 游戏流量 (fwmark: 0x00130000)
  - web: 网页流量 (fwmark: 0x00230000)
  - video: 视频流量 (fwmark: 0x00330000)
  - download: 下载流量 (fwmark: 0x00430000)
]]

require("miqos.common")

local MODULE_NAME = "service"
qdisc[MODULE_NAME] = {}

local luci_ip = require("luci.ip")

local service_config = {
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
        id = 0x1000,
        quan = 2,
        fwmark = "0x00010000/0x000f0000",
        fprio = "5"
    },
    child = {
        special = {
            id = 0x2000,
            prio = "1",
            quan = 2,
            fwmark = "0x00020000/0x000f0000",
            fprio = "5",
            rate = 0.1,
            ceil = 0.5,
            highest_prio = apply_arp_small_filter
        },
        host = {
            id = 0x3000,
            prio = "4",
            quan = 2,
            fwmark = "0x00030000/0x000f0000",
            fprio = "5",
            rate = 0.7,
            ceil = 0.98,
            supress = 2048
        },
        guest = {
            id = 0x4000,
            prio = "6",
            quan = 1,
            fwmark = "0x00040000/0x000f0000",
            fprio = "5",
            rate = 0.1,
            ceil = 0,
            limit = cfg.guest
        },
        xq = {
            id = 0x5000,
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
local host_qos_data = {}

local function clear_offline_hosts()
    for ip, host_data in pairs(host_qos_data) do
        host_qos_data[ip].net = nil
        host_qos_data[ip].limit = nil
        host_qos_data[ip] = nil
    end
end

local function clean_service_qdisc(interfaces)
    local tc_commands = {}
    
    for _, iface in pairs(interfaces) do
        local cmd = string.format("%s del dev %s root ", const_tc_qdisc, iface.dev)
        table.insert(tc_commands, cmd)
    end
    
    if tc_commands then
        exec_tc_commands(tc_commands)
    end
    
    clear_offline_hosts()
    cfg.changed = true
end

qdisc[MODULE_NAME].clean = clean_service_qdisc

local function is_same_subnet(ip1, ip2, mask)
    if ip1 == nil or ip2 == nil or mask == nil then
        return false
    end
    
    local addr1 = luci_ip.IPv4(ip1)
    local addr2 = luci_ip.IPv4(ip2)
    
    if addr1 and addr2 then
        local net1 = luci_ip.cidr.network(addr1, mask)
        local net2 = luci_ip.cidr.network(addr2, mask)
        
        if net1 and net2 then
            return luci_ip.cidr.equal(net1, net2)
        end
    end
    
    return false
end

local function update_host_status()
    for ip, host_data in pairs(host_qos_data) do
        if host_data.net.new == "" then
            host_qos_data[ip].net = nil
            host_qos_data[ip].limit = nil
            host_qos_data[ip] = nil
        else
            host_data.net.old = host_data.net.new
            host_data.net.new = ""
            host_data.limit.changed = 0
        end
    end
end

local function scan_online_hosts()
    local device_list = g_ubus.call("trafficd", "hw", {})
    online_hosts = device_list or {}
    
    for _, device in pairs(device_list or {}) do
        local mac = device.hw
        local is_wireless = device.wifi ~= nil
        
        for _, entry in pairs(device.assoclist or {}) do
            local is_online = false
            
            if is_wireless then
                if device.assoc == 1 then
                    is_online = true
                end
            else
                if entry.ageing_timer <= service_config.online_timeout.wi then
                    is_online = true
                end
            end
            
            if is_online then
                local network_type = "guest"
                local ip = entry.ip
                local ip_suffix = string.split(entry.ip, ".")[4]
                
                if cfg.lan.ip and cfg.lan.mask then
                    if is_same_subnet(ip, cfg.lan.ip, tonumber(cfg.lan.mask)) then
                        network_type = "host"
                    end
                end
                
                online_hosts[ip] = {
                    mac = mac,
                    UP = {},
                    DOWN = {}
                }
                
                local up_limit = 0
                local down_limit = 0
                
                local group_config = g_group_def[mac]
                if group_config then
                    up_limit = math.ceil(group_config.max_grp_uplink or 0)
                    down_limit = math.ceil(group_config.max_grp_downlink or 0)
                    online_hosts[ip].UP.max_per = up_limit
                    online_hosts[ip].DOWN.max_per = down_limit
                end
                
                local skip_host = false
                if up_limit < 8 then
                    if up_limit > math.ceil(cfg.bands.UP) then
                        skip_host = true
                    end
                end
                
                if not skip_host and down_limit < 8 then
                    if down_limit > math.ceil(cfg.bands.DOWN) then
                        skip_host = true
                    end
                end
                
                if skip_host then
                    if host_qos_data[ip] then
                        host_qos_data[ip].net.new = ""
                    end
                else
                    if up_limit < 8 then
                        up_limit = cfg.bands.UP
                    end
                    if down_limit < 8 then
                        down_limit = cfg.bands.DOWN
                    end
                    
                    if not host_qos_data[ip] then
                        host_qos_data[ip] = {
                            mac = mac,
                            id = ip_suffix,
                            ip = ip,
                            net = {
                                old = "",
                                new = network_type
                            },
                            limit = {
                                UP = up_limit,
                                DOWN = down_limit,
                                changed = 1
                            }
                        }
                    else
                        host_qos_data[ip].net.new = network_type
                        
                        if host_qos_data[ip].limit.UP ~= up_limit or 
                           host_qos_data[ip].limit.DOWN ~= down_limit then
                            logger(3, "limit changed, mac: " .. mac .. ",ip: " .. ip ..
                                   ",UP:" .. host_qos_data[ip].limit.UP .. "->" .. up_limit ..
                                   ",DOWN:" .. host_qos_data[ip].limit.DOWN .. "->" .. down_limit)
                            host_qos_data[ip].limit = {
                                UP = up_limit,
                                DOWN = down_limit,
                                changed = 1
                            }
                        end
                    end
                end
            end
        end
    end
end

local function get_service_priority(flow_seq, service_type)
    local prio_table = seq_prio[flow_seq]
    if not prio_table then
        prio_table = seq_prio.auto
    end
    return prio_table[service_type] or 4
end

local function generate_host_class_rules(tc_commands, interfaces, action, parent_id, host_data)
    local host_count = #online_hosts
    local tc_cmd = ""
    local host_id = host_data.id
    local class_id = parent_id + host_id * 16
    local limit = host_data.limit
    
    local max_bands = {
        UP = math.ceil(cfg.bands.UP),
        DOWN = math.ceil(cfg.bands.DOWN)
    }
    
    if math.ceil(limit.UP) > max_bands.UP then
        limit.UP = cfg.bands.UP
    end
    if math.ceil(limit.DOWN) > max_bands.DOWN then
        limit.DOWN = cfg.bands.DOWN
    end
    
    local action_symbol = "*"
    if action == "add" then
        action_symbol = "+"
    elseif action == "del" then
        action_symbol = "-"
    end
    
    logger(3, action_symbol .. " host: " .. host_data.ip .. ",mac:" .. host_data.mac ..
           ", UP:" .. host_data.limit.UP .. ", DOWN:" .. host_data.limit.DOWN)
    
    local prio_suffix = ""
    if QOS_VER == "FIX" then
        prio_suffix = " prio 4 "
    end
    
    for direction, iface in pairs(interfaces) do
        local dev = iface.dev
        local dev_id = iface.id
        local max_rate = htb_class_config[direction]
        local rate = math.ceil(limit[direction])
        local burst, cburst = get_burst(rate)
        local quantum = htb_class_config.quan_v * 2
        
        if max_rate > rate then
            max_rate = rate
        end
        
        if action == "del" then
            tc_cmd = string.format("%s %s dev %s classid %s:%s ",
                const_tc_class, action, dev, dev_id, dec2hexstr(class_id))
            table.insert(tc_commands, 1, tc_cmd)
        elseif action == "change" then
            tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %squantum %s burst %d cburst %d ",
                const_tc_class, action, dev, dev_id, dec2hexstr(parent_id), dev_id, dec2hexstr(class_id),
                max_rate, UNIT, rate, UNIT, prio_suffix, burst, cburst, quantum)
            table.insert(tc_commands, 1, tc_cmd)
        else
            tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %squantum %s burst %d cburst %d ",
                const_tc_class, action, dev, dev_id, dec2hexstr(parent_id), dev_id, dec2hexstr(class_id),
                max_rate, UNIT, rate, UNIT, prio_suffix, burst, cburst, quantum)
            table.insert(tc_commands, tc_cmd)
        end
        
        if QOS_VER == "FIX" then
            apply_leaf_qdisc(tc_commands, dev, dev_id, dec2hexstr(class_id), rate, true)
            
            local filter_prio = "2"
            tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle 0x%s00000/0xfff00000 fw classid %s:%s ",
                const_tc_filter, action, dev, dev_id, filter_prio, dec2hexstr(host_id * 16), dev_id, dec2hexstr(class_id))
            
            if action == "del" then
                table.insert(tc_commands, 1, tc_cmd)
            elseif action ~= "change" then
                table.insert(tc_commands, tc_cmd)
            end
        else
            local default_class_id = 0
            
            for service_name, service_config in pairs(service_subclass) do
                local service_mark_id = host_id * 16 + service_config.id
                local service_class_id = parent_id + service_mark_id
                
                if action == "del" then
                    tc_cmd = string.format("%s %s dev %s classid %s:%s ",
                        const_tc_class, action, dev, dev_id, dec2hexstr(service_class_id))
                    table.insert(tc_commands, 1, tc_cmd)
                else
                    local service_rate = math.ceil(max_rate * service_config.rate)
                    local service_ceil = math.ceil(rate * service_config.ceil)
                    local service_burst, service_cburst = get_burst(service_ceil)
                    local service_prio = get_service_priority(cfg.flow.seq, service_name)
                    
                    tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s quantum %s burst %d cburst %d ",
                        const_tc_class, action, dev, dev_id, dec2hexstr(class_id), dev_id, dec2hexstr(service_class_id),
                        service_rate, UNIT, service_ceil, UNIT, service_prio, quantum, service_burst, service_cburst)
                    
                    if action == "change" then
                        table.insert(tc_commands, 1, tc_cmd)
                    else
                        table.insert(tc_commands, tc_cmd)
                        apply_leaf_qdisc(tc_commands, dev, dev_id, dec2hexstr(service_class_id), service_ceil, true)
                    end
                end
                
                local filter_prio = "2"
                tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle 0x%s00000/0xfff00000 fw classid %s:%s ",
                    const_tc_filter, action, dev, dev_id, filter_prio, dec2hexstr(service_mark_id), dev_id, dec2hexstr(service_class_id))
                
                if action == "del" then
                    table.insert(tc_commands, 1, tc_cmd)
                elseif action ~= "change" then
                    table.insert(tc_commands, tc_cmd)
                end
                
                if service_config.default then
                    default_class_id = service_class_id
                    
                    if default_class_id ~= 0 then
                        local default_filter_prio = "3"
                        tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle 0x%s000000/0xff000000 fw classid %s:%s ",
                            const_tc_filter, action, dev, dev_id, default_filter_prio, dec2hexstr(host_id), dev_id, dec2hexstr(default_class_id))
                        
                        if action == "del" then
                            table.insert(tc_commands, 1, tc_cmd)
                        elseif action ~= "change" then
                            table.insert(tc_commands, tc_cmd)
                        end
                    end
                end
            end
        end
    end
    
    return tc_commands
end

local function process_host_changes(interfaces, host_class_id)
    local tc_commands = {}
    
    scan_online_hosts()
    
    for ip, host_data in pairs(host_qos_data) do
        local old_net = host_data.net.old
        local new_net = host_data.net.new
        
        if old_net == "" then
            if new_net == "host" then
                local has_limit = host_data.limit.UP ~= 0 or host_data.limit.DOWN ~= 0
                if has_limit then
                    generate_host_class_rules(tc_commands, interfaces, "add", host_class_id, host_data)
                end
            end
        elseif old_net == "host" then
            if new_net == "guest" then
                generate_host_class_rules(tc_commands, interfaces, "del", host_class_id, host_data)
            elseif new_net == "host" then
                if host_data.limit.changed == 1 then
                    generate_host_class_rules(tc_commands, interfaces, "change", host_class_id, host_data)
                end
            else
                generate_host_class_rules(tc_commands, interfaces, "del", host_class_id, host_data)
            end
        else
            if new_net == "host" then
                generate_host_class_rules(tc_commands, interfaces, "add", host_class_id, host_data)
            end
        end
    end
    
    update_host_status()
    
    if tc_commands then
        exec_tc_commands(tc_commands)
    end
    
    return tc_commands
end

local function check_config_changed()
    return true
end

qdisc[MODULE_NAME].changed = check_config_changed

local function calculate_min_bandwidth(bands)
    local up_min = math.ceil(bands.UP / 15)
    local down_min = math.ceil(bands.DOWN / 15)
    
    if up_min < 40 then
        up_min = 40
    end
    if down_min < 80 then
        down_min = 80
    end
    
    return {
        UP = up_min,
        DOWN = down_min
    }
end

local function generate_service_qdisc(interfaces, bands)
    local tc_commands = {}
    local tc_cmd = ""
    local action = "add"
    
    for direction, iface in pairs(interfaces) do
        local dev = iface.dev
        local dev_id = iface.id
        local bandwidth = bands[direction]
        
        local root_quantum = math.ceil(htb_class_config.quan_v * htb_class_config.root.quan)
        local root_class_hex = dec2hexstr(htb_class_config.root.id)
        local burst, cburst = get_burst(bandwidth)
        
        tc_cmd = string.format("%s add dev %s root handle %s: htb default %s %s",
            const_tc_qdisc, dev, dev_id, dec2hexstr(htb_class_config.dft), get_stab_string(dev))
        table.insert(tc_commands, tc_cmd)
        
        tc_cmd = string.format("%s add dev %s parent %s: classid %s:%s htb rate %s%s quantum %s burst %d cburst %d ",
            const_tc_class, dev, dev_id, dev_id, root_class_hex, bandwidth, UNIT, root_quantum, burst, cburst)
        table.insert(tc_commands, tc_cmd)
        
        tc_cmd = string.format("%s add dev %s parent %s: prio %s handle %s fw classid %s:0",
            const_tc_filter, dev, dev_id, htb_class_config.root.fprio, htb_class_config.root.fwmark, dev_id)
        table.insert(tc_commands, tc_cmd)
        
        apply_ppp_qdisc(tc_commands, dev, dev_id)
        
        local parent_class_hex = root_class_hex
        
        for child_name, child_config in pairs(htb_class_config.child) do
            local child_id = child_config.id
            local child_prio = child_config.prio
            local child_rate = math.ceil(bandwidth * child_config.rate)
            local child_ceil = child_config.ceil
            
            if child_config.limit then
                child_ceil = math.ceil(child_config.limit[direction])
                if child_ceil <= 1 then
                    child_ceil = math.ceil(bandwidth * child_ceil)
                end
            end
            
            if child_ceil == 0 then
                child_ceil = bandwidth
            elseif child_ceil <= 1 then
                child_ceil = math.ceil(bandwidth * child_ceil)
            end
            
            if child_ceil <= 8 then
                child_ceil = 8
            end
            
            if child_rate > child_ceil then
                child_rate = child_ceil
            end
            
            if child_name == "host" then
                child_ceil = get_supressed_ceil(child_ceil, child_config.supress)
            end
            
            if child_ceil ~= 0 then
                local child_burst, child_cburst = get_burst(child_ceil)
                local child_quantum = child_config.quan * htb_class_config.quan_v
                
                tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s quantum %s burst %d cburst %d ",
                    const_tc_class, action, dev, dev_id, parent_class_hex, dev_id, dec2hexstr(child_id),
                    child_rate, UNIT, child_ceil, UNIT, child_prio, child_quantum, child_burst, child_cburst)
                table.insert(tc_commands, tc_cmd)
                
                if child_name == "special" then
                    if service_config.qos.small and child_config.highest_prio then
                        child_config.highest_prio(tc_commands, dev, dev_id, dec2hexstr(child_id))
                    end
                elseif child_name == "host" then
                    local host_parent_id = child_id
                    
                    for service_name, service_config in pairs(service_subclass) do
                        local service_id = host_parent_id + service_config.id
                        local service_rate = math.ceil(child_rate * service_config.rate)
                        local service_ceil = math.ceil(child_ceil * service_config.ceil)
                        
                        if service_rate > service_ceil then
                            service_rate = service_ceil
                        end
                        
                        local service_prio = get_service_priority(cfg.flow.seq, service_name)
                        
                        tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s quantum %s burst %d cburst %d ",
                            const_tc_class, action, dev, dev_id, dec2hexstr(host_parent_id), dev_id, dec2hexstr(service_id),
                            service_rate, UNIT, service_ceil, UNIT, service_prio, child_quantum, child_burst, child_cburst)
                        table.insert(tc_commands, tc_cmd)
                        
                        apply_leaf_qdisc(tc_commands, dev, dev_id, dec2hexstr(service_id), service_ceil, true)
                        
                        if service_config.mark.fwmark and service_config.mark.fwmark ~= "" then
                            tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                                const_tc_filter, action, dev, dev_id, service_config.mark.fprio, service_config.mark.fwmark, dev_id, dec2hexstr(service_id))
                            table.insert(tc_commands, tc_cmd)
                        end
                        
                        if service_config.default then
                            tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                                const_tc_filter, action, dev, dev_id, child_config.fprio, child_config.fwmark, dev_id, dec2hexstr(service_id))
                            table.insert(tc_commands, tc_cmd)
                        end
                    end
                end
                
                if child_name ~= "host" and child_name ~= "leteng" then
                    if child_config.fwmark and child_config.fwmark ~= "" then
                        tc_cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                            const_tc_filter, action, dev, dev_id, child_config.fprio, child_config.fwmark, dev_id, dec2hexstr(child_id))
                        table.insert(tc_commands, tc_cmd)
                        
                        apply_leaf_qdisc(tc_commands, dev, dev_id, dec2hexstr(child_id), child_ceil, true)
                    end
                end
            end
        end
    end
    
    if tc_commands then
        exec_tc_commands(tc_commands)
    end
    
    return tc_commands
end

local function update_child_class(child_name, interfaces, bands)
    local tc_commands = {}
    local action = "change"
    local tc_cmd = ""
    
    local child_config = htb_class_config.child[child_name]
    if not child_config then
        logger(3, "ERROR: child class '" .. child_name .. "' not found in mainframe.")
        return false
    end
    
    for direction, iface in pairs(interfaces) do
        local dev = iface.dev
        local dev_id = iface.id
        local child_id = child_config.id
        local root_id = htb_class_config.root.id
        local bandwidth = bands[direction]
        
        local child_rate = math.ceil(child_config.rate * bandwidth)
        local child_ceil = child_config.ceil
        
        if child_ceil == 0 then
            child_ceil = child_config.limit[direction]
        end
        
        if child_ceil == 0 then
            child_ceil = bandwidth
        elseif child_ceil <= 1 then
            child_ceil = math.ceil(bandwidth * child_ceil)
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
        
        tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s quantum %s burst %d cburst %d",
            const_tc_class, action, dev, dev_id, dec2hexstr(root_id), dev_id, dec2hexstr(child_id),
            child_rate, UNIT, child_ceil, UNIT, child_prio, child_quantum, child_burst, child_cburst)
        table.insert(tc_commands, tc_cmd)
        table.insert(tc_commands, tc_cmd)
    end
    
    if tc_commands then
        exec_tc_commands(tc_commands)
    end
end

local function check_guest_changed(interfaces, bands)
    local change_log = ""
    local need_update = false
    
    if cfg.guest.changed == 1 then
        change_log = change_log .. "/guest"
        cfg.guest.changed = 0
        need_update = true
    end
    
    if change_log ~= "" then
        logger(3, "CHANGE: " .. change_log)
    end
    
    if need_update then
        update_child_class("guest", interfaces, bands)
    end
end

local function check_xq_changed(interfaces, bands)
    local change_log = ""
    local need_update = false
    
    if cfg.xq.changed == 1 then
        change_log = change_log .. "/xq"
        cfg.xq.changed = 0
        need_update = true
    end
    
    if change_log ~= "" then
        logger(3, "CHANGE: " .. change_log)
    end
    
    if need_update then
        update_child_class("xq", interfaces, bands)
    end
end

local function apply_service_qdisc(force_rebuild, origin_disc, interfaces, bands)
    local change_log = ""
    local need_rebuild = false
    
    if cfg.qos_type.changed then
        change_log = change_log .. "/qos type"
        cfg.qos_type.changed = false
        need_rebuild = true
    end
    
    if cfg.bands.changed then
        change_log = change_log .. "/bandwidth"
        cfg.bands.changed = false
        need_rebuild = true
    end
    
    if cfg.supress_host.changed then
        change_log = change_log .. "/supress switch"
        cfg.supress_host.changed = false
        need_rebuild = true
    end
    
    local min_bands = calculate_min_bandwidth(bands)
    
    if cfg.flow.changed then
        change_log = change_log .. "/service_prio"
        cfg.flow.changed = false
        need_rebuild = true
    end
    
    if change_log ~= "" then
        logger(3, "CHANGE: " .. change_log)
    end
    
    if force_rebuild or need_rebuild then
        qdisc[MODULE_NAME].clean(interfaces)
        generate_service_qdisc(interfaces, bands)
    end
    
    check_guest_changed(interfaces, bands)
    check_xq_changed(interfaces, bands)
    
    return need_rebuild
end

local HIGH_PRIO_CONFIG = {
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
    if not read_qos_group_config() then
        logger(3, "read_qos_group_config failed.")
        return false
    end
    
    if not read_qos_guest_xq_config() then
        logger(3, "read_qos_guest_xq_config failed.")
        return false
    end
    
    return true
end

qdisc[MODULE_NAME].read_qos_config = read_qos_config

local function apply(qos_type, origin_disc, interfaces, force_rebuild)
    local action = "add"
    local default_class = "0"
    
    if qos_type then
        if not qdisc[qos_type] then
            logger(3, "ERROR: qdisc `" .. qos_type .. "` not found. ")
            return false
        end
    end
    
    local should_rebuild = force_rebuild
    if not should_rebuild and qos_type then
        if qos_type == MODULE_NAME then
            should_rebuild = false
        end
    else
        should_rebuild = true
    end
    
    apply_service_qdisc(should_rebuild, origin_disc, interfaces, cfg.bands)
    
    process_host_changes(interfaces, htb_class_config.child.host.id, htb_class_config.child.guest.id)
    
    return true
end

qdisc[MODULE_NAME].apply = apply

local function update_counters(interfaces)
    if cfg.enabled.flag == "0" then
        return
    end
    
    local counters = {}
    
    if QOS_VER == "FIX" then
        scan_online_hosts()
    end
    
    for ip, host_data in pairs(online_hosts) do
        local flag = "on"
        local group_config = g_group_def[host_data.mac]
        
        if not group_config then
            flag = "off"
        elseif group_config.flag then
            flag = group_config.flag
        else
            local up_limit = tonumber(group_config.max_grp_uplink or 0)
            local down_limit = tonumber(group_config.max_grp_downlink or 0)
            
            if up_limit <= 0 or down_limit <= 0 then
                flag = "off"
            end
        end
        
        local counter_entry = {
            MAC = host_data.mac,
            UP = {
                min = 0,
                min_per = 0,
                min_cfg = 0,
                max = 0 .. "Kbit",
                max_per = host_data.UP.max_per or 0,
                max_cfg = 0
            },
            DOWN = {
                min = 0,
                min_per = 0,
                min_cfg = 0,
                max = 0 .. "Kbit",
                max_per = host_data.DOWN.max_per or 0,
                max_cfg = 0
            },
            flag = flag
        }
        
        counters[ip] = counter_entry
        
        if host_qos_data[ip] then
            counters[ip].UP.max = host_qos_data[ip].limit.UP or (0 .. "Kbit")
            counters[ip].DOWN.max = host_qos_data[ip].limit.DOWN or (0 .. "Kbit")
        end
    end
    
    return counters
end

qdisc[MODULE_NAME].update_counters = update_counters
