--[[
  小米路由器 MiQoS 王者荣耀游戏加速模块
  
  功能说明:
  - 专门针对王者荣耀(Honor of Kings)游戏的QoS优化
  - 使用HTB(Hierarchical Token Bucket)队列算法
  - 为游戏设备提供专用带宽保障
  - 支持动态检测王者荣耀游戏设备
  
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
  
  特殊配置:
  - 使用 cfg.wangzhe.devbands 配置游戏设备带宽
  - 通过 is_wangzhe_dev 检测王者荣耀游戏设备
]]

require("miqos.common")

local MODULE_NAME = "wangzhe"
qdisc[MODULE_NAME] = {}

local luci_ip = require("luci.ip")

local wangzhe_config = {
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

local wangzhe_devices = {}
local host_qos_data = {}

local function clear_offline_hosts()
    for ip, host_data in pairs(host_qos_data) do
        host_qos_data[ip].net = nil
        host_qos_data[ip].limit = nil
        host_qos_data[ip] = nil
    end
end

local function clean_wangzhe_qdisc(interfaces)
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

qdisc[MODULE_NAME].clean = clean_wangzhe_qdisc

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

local function is_wangzhe_dev(ip)
    for _, dev_info in pairs(wangzhe_devices) do
        logger(3, "devip: " .. dev_info.devip .. " ip: " .. ip)
        if dev_info.devip == ip then
            logger(3, "not wangzhe dev false ")
            return false
        end
    end
    return true
end

local function scan_online_hosts()
    local device_list = g_ubus.call("trafficd", "hw", {})
    
    if not device_list then
        return
    end
    
    for _, device in pairs(device_list) do
        local mac = device.hw
        local is_wireless = device.wifi ~= nil
        
        for _, entry in pairs(device.assoclist or {}) do
            local is_online = false
            
            if is_wireless then
                if device.assoc == 1 then
                    is_online = true
                end
            else
                if entry.ageing_timer <= wangzhe_config.online_timeout.wi then
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
                
                local up_limit = 0
                local down_limit = 0
                
                if is_wangzhe_dev(ip) then
                    up_limit = cfg.wangzhe.devbands.UP
                    down_limit = cfg.wangzhe.devbands.DOWN
                end
                
                if up_limit == 0 or down_limit == 0 then
                    if host_qos_data[ip] then
                        host_qos_data[ip].net.new = ""
                    end
                else
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
    local host_count = #wangzhe_devices
    local tc_cmd = ""
    local host_id = host_data.id
    local class_id = parent_id + host_id * 16
    local limit = host_data.limit
    
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
        local rate = limit[direction]
        local ceil = limit[direction]
        
        logger(3, "rate: " .. rate .. ", ceil: " .. ceil)
        
        local burst, cburst = get_burst(ceil)
        
        logger(3, "burst: " .. burst .. ", cburst: " .. cburst)
        
        local quantum = htb_class_config.quan_v * 2
        
        if rate > ceil then
            rate = ceil
        end
        
        if action == "del" then
            tc_cmd = string.format("%s %s dev %s classid %s:%s ",
                const_tc_class, action, dev, dev_id, dec2hexstr(class_id))
            table.insert(tc_commands, 1, tc_cmd)
        elseif action == "change" then
            tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %squantum %s burst %d cburst %d ",
                const_tc_class, action, dev, dev_id, dec2hexstr(parent_id), dev_id, dec2hexstr(class_id),
                rate, UNIT, ceil, UNIT, prio_suffix, burst, cburst, quantum)
            table.insert(tc_commands, 1, tc_cmd)
        else
            tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s %squantum %s burst %d cburst %d ",
                const_tc_class, action, dev, dev_id, dec2hexstr(parent_id), dev_id, dec2hexstr(class_id),
                rate, UNIT, ceil, UNIT, prio_suffix, burst, cburst, quantum)
            table.insert(tc_commands, tc_cmd)
        end
        
        local default_class_id = 0
        
        for service_name, service_config in pairs(service_subclass) do
            local service_mark_id = host_id * 16 + service_config.id
            local service_class_id = parent_id + service_mark_id
            
            if action == "del" then
                tc_cmd = string.format("%s %s dev %s classid %s:%s ",
                    const_tc_class, action, dev, dev_id, dec2hexstr(service_class_id))
                table.insert(tc_commands, 1, tc_cmd)
            else
                local service_rate = math.ceil(rate * service_config.rate)
                local service_ceil = math.ceil(ceil * service_config.ceil)
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
    
    return tc_commands
end

local function process_host_changes(interfaces, host_class_id)
    local tc_commands = {}
    
    scan_online_hosts()
    update_host_status()
    
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

local function check_wangzhe_changed()
    local changed = false
    local change_log = ""
    
    if cfg.wangzhe.changed then
        change_log = change_log .. "/wangzhe"
        changed = true
    end
    
    return changed
end

qdisc[MODULE_NAME].changed = check_wangzhe_changed

local function generate_wangzhe_qdisc(interfaces, bands)
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
            
            if child_name == "host" then
                child_ceil = get_supressed_ceil(child_ceil, child_config.supress)
            end
            
            if child_rate > child_ceil then
                child_rate = child_ceil
            end
            
            if child_ceil ~= 0 then
                local child_burst, child_cburst = get_burst(child_ceil)
                local child_quantum = child_config.quan * htb_class_config.quan_v
                
                tc_cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s quantum %s burst %d cburst %d ",
                    const_tc_class, action, dev, dev_id, parent_class_hex, dev_id, dec2hexstr(child_id),
                    child_rate, UNIT, child_ceil, UNIT, child_prio, child_quantum, child_burst, child_cburst)
                table.insert(tc_commands, tc_cmd)
                
                if child_name == "special" then
                    if wangzhe_config.qos.small and child_config.highest_prio then
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

local function update_wangzhe_mainframe(interfaces, bands)
    local updated = true
    
    logger(3, "CHANGE: wangzhe")
    logger(3, "===================  wangzhe update mainframe ==============")
    
    qdisc[MODULE_NAME].clean(interfaces)
    generate_wangzhe_qdisc(interfaces, bands)
    
    return updated
end

local function read_qos_config()
    return true
end

qdisc[MODULE_NAME].read_qos_config = read_qos_config

local function apply(interfaces, force_rebuild)
    logger(3, "===================  wangzhe apply =================")
    
    if force_rebuild or cfg.wangzhe.bandchanged then
        generate_wangzhe_qdisc(interfaces, cfg.wangzhe.bands)
        cfg.wangzhe.cleanflag = false
        cfg.wangzhe.bandchanged = false
    end
    
    process_host_changes(interfaces, htb_class_config.child.host.id, htb_class_config.child.guest.id)
    
    return true
end

qdisc[MODULE_NAME].apply = apply
