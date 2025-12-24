--[[
  小米路由器 QoS 基于主机的规则模块
  MiQoS Host-based Rules Module
  
  功能说明:
  - 基于主机(MAC/IP)的QoS流量控制
  - 支持HTB队列规则，实现分层带宽分配
  - 支持特殊主机、访客网络、小米设备的差异化处理
  - 支持带宽预留和动态调整
  - 支持4种服务类型子类: game, web, video, download
]]

require("miqos.common")

local luci_ip = require("luci.ip")

-- 注册 host qdisc 类型
qdisc["host"] = {}

-- TC 命令模板: 查询指定设备的 level 5 类
local TC_CLASS_QUERY_TEMPLATE = " tc -d class show dev %s |grep \"level 5\" "

-- 主机 QoS 配置参数
local host_config = {
    rate_score = 0.5,           -- 基础速率评分系数
    ceil_score = 1,             -- 上限速率评分系数
    htb_buffer_factor = 1.5,    -- HTB 缓冲因子
    
    -- 小包优先配置
    qos = {
        ack = false,    -- ACK 包优先
        syn = true,     -- SYN 包优先
        fin = true,     -- FIN 包优先
        rst = true,     -- RST 包优先
        icmp = true,    -- ICMP 包优先
        small = false   -- 小包优先
    },
    
    -- 在线检测超时配置
    online_timeout = {
        wl = 5,         -- 无线设备超时(秒)
        wi = 300        -- 有线设备超时(秒)
    }
}

-- 带宽抑制比例
local supress_ratio = {
    UP = 0.85,      -- 上行抑制比例
    DOWN = 0.85     -- 下行抑制比例
}

-- HTB 类结构配置
local htb_class_config = {
    dft = 16384,        -- 默认类 ID
    quan_v = 1500,      -- 量子值(MTU)
    
    -- 根类配置
    root = {
        id = 4096,                          -- 根类 ID (0x1000)
        quan = 8,                           -- 量子倍数
        fwmark = "0x00010000/0x000f0000",   -- 防火墙标记
        fprio = "4"                         -- 过滤器优先级
    },
    
    -- 子类配置
    child = {
        -- [1] 特殊主机类 (高优先级)
        {
            id = 8192,                          -- 类 ID (0x2000)
            prio = "1",                         -- 优先级
            quan = 4,                           -- 量子倍数
            fwmark = "0x00020000/0x000f0000",   -- 防火墙标记
            fprio = "4",                        -- 过滤器优先级
            rate = 0.35,                        -- 保证速率比例
            ceil = 0.8,                         -- 上限速率比例
            highest_prio = "1"                  -- 最高优先级标记
        },
        -- [2] 普通主机类
        {
            id = 12288,                         -- 类 ID (0x3000)
            prio = "4",                         -- 优先级
            quan = 4,                           -- 量子倍数
            fwmark = "",                        -- 无防火墙标记(使用IP过滤)
            fprio = "",                         -- 无过滤器优先级
            rate = 0.6,                         -- 保证速率比例
            ceil = 0.98,                        -- 上限速率比例
            supress = 2048                      -- 抑制阈值(kbps)
        },
        -- [3] 访客网络类
        {
            id = 16384,                         -- 类 ID (0x4000)
            prio = "6",                         -- 优先级(较低)
            quan = 2,                           -- 量子倍数
            fwmark = "0x00040000/0x000f0000",   -- 防火墙标记
            fprio = "4",                        -- 过滤器优先级
            rate = 0.05,                        -- 保证速率比例
            ceil = 0,                           -- 上限(从配置读取)
            limit = cfg.guest                   -- 限速配置引用
        },
        -- [4] 小米设备类 (XQ)
        {
            id = 20480,                         -- 类 ID (0x5000)
            prio = "7",                         -- 优先级(最低)
            quan = 1,                           -- 量子倍数
            fwmark = "0x00050000/0x000f0000",   -- 防火墙标记
            fprio = "4",                        -- 过滤器优先级
            rate = 0.05,                        -- 保证速率比例
            ceil = 0,                           -- 上限(从配置读取)
            limit = supress_ratio               -- 限速配置引用
        }
    }
}

-- 服务类型子类配置 (用于主机内部流量分类)
local service_subclass = {
    -- [1] 游戏流量
    {
        id = 1,
        prio = 2,
        rate = 0.15,
        ceil = 0.6
    },
    -- [2] 网页流量
    {
        id = 2,
        prio = 3,
        rate = 0.4,
        ceil = 1
    },
    -- [3] 视频流量
    {
        id = 3,
        prio = 4,
        rate = 0.4,
        ceil = 1
    },
    -- [4] 下载流量 (默认)
    {
        id = 4,
        prio = 5,
        rate = 0.05,
        ceil = 0.95,
        default = true
    }
}

-- 视频带宽预留配置
local video_reserve_config = {
    video = {
        { id = 0, band = 0 },
        { id = 512, band = 480 },
        { id = 2048, band = 800 },
        { id = 5120, band = 1600 },
        { id = 10249, band = 2400 }
    },
    other = {}
}

-- 带宽预留主机列表
local band_reserve_hosts = {
    changed = false
}

-- 特殊主机列表
local special_host_list = {
    changed = false
}

-- 当前在线主机表
local current_hosts = {}

-- 上一次在线主机表
local previous_hosts = {}

-- MAC 到 IP 列表的映射
local mac_to_ips = {}

--[[
  计算带宽评分
  @param host_info 主机信息表
  @param config 配置参数
  @return 评分值, 配置信息
]]
local function calculate_bandwidth_score(host_info, config)
    local total_score = 0
    
    for category, category_config in pairs(config) do
        if category ~= "changed" then
            local match_count = 0
            for ip, _ in pairs(category_config) do
                if host_info[ip] then
                    match_count = match_count + 1
                end
            end
            
            if match_count > 0 then
                local band = category_config.band
                if band then
                    total_score = total_score + band
                end
            end
        end
    end
    
    if total_score <= 0 or total_score > config.max then
        return config.default, config.default_info
    end
    
    return total_score, config.score_info
end

--[[
  清理 host qdisc 规则
  删除所有与 host qdisc 相关的 TC 规则
  @param dev_list 设备列表
]]
local function clean_host_qdisc(dev_list)
    local commands = {}
    
    for _, dev_info in pairs(dev_list) do
        local cmd = string.format("%s del dev %s root ", const_tc_qdisc, dev_info.dev)
        table.insert(commands, cmd)
    end
    
    if #commands > 0 then
        exec_cmd(commands, nil)
    end
    
    current_hosts = {}
    previous_hosts = {}
    mac_to_ips = {}
end

qdisc["host"].clean = clean_host_qdisc

--[[
  更新计数器信息
  获取当前 TC 类的速率和上限信息
  @param dev_list 设备列表
  @return 主机状态信息表
]]
local function update_counters(dev_list)
    if cfg.enabled.flag == "0" then
        return
    end
    
    local up_id = dev_list[UP].id
    local down_id = dev_list[DOWN].id
    
    -- 存储 TC 类信息
    local class_info = {}
    class_info[up_id] = {}
    class_info[down_id] = {}
    
    -- 解析 TC 类输出
    for _, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local tc_output = {}
        
        local cmd = string.format(TC_CLASS_QUERY_TEMPLATE, dev)
        local handle = io.popen(cmd)
        local line = handle:read("*line")
        
        while line do
            local _, _, qdisc_id, class_id, rate, ceil = 
                string.find(line, "class htb (%d+):(%w+).*rate (%w+) ceil (%w+)")
            
            if qdisc_id then
                if not class_info[qdisc_id][class_id] then
                    class_info[qdisc_id][class_id] = {}
                end
                class_info[qdisc_id][class_id].r = rate
                class_info[qdisc_id][class_id].c = ceil
            end
            
            line = handle:read("*line")
        end
        handle:close()
    end
    
    -- 构建主机状态信息
    local host_class_id = htb_class_config.child[2].id
    local result = {}
    
    for idx, host_info in ipairs(current_hosts) do
        local class_hex = dec2hexstr(host_info.id * 16 + host_class_id)
        local up_rate = 0
        local down_rate = 0
        
        if class_info[up_id][class_hex] then
            up_rate = class_info[up_id][class_hex].r
        end
        
        if class_info[down_id][class_hex] then
            down_rate = class_info[down_id][class_hex].r
        end
        
        local up_info, down_info = nil, nil
        local mac = host_info.mac
        local flag = "on"
        
        if mac and g_group_def[mac] then
            -- 从分组配置获取限速信息
            local max_up = tonumber(g_group_def[mac].max_grp_uplink)
            local max_down = tonumber(g_group_def[mac].max_grp_downlink)
            
            -- 处理上行限速
            if max_up < 1 then
                max_up = math.ceil(cfg.bands.UP * max_up)
            elseif max_up == 1 then
                max_up = 0
            end
            
            -- 处理下行限速
            if max_down < 1 then
                max_down = math.ceil(cfg.bands.DOWN * max_down)
            elseif max_down == 1 then
                max_down = 0
            end
            
            up_info = {
                max_per = max_up,
                min_per = g_group_def[mac].min_grp_uplink,
                max_cfg = math.ceil(g_group_def[mac].max_grp_uplink),
                max = dev_info.max_up,
                min_cfg = math.ceil(g_group_def[mac].min_grp_uplink),
                min = up_rate
            }
            
            down_info = {
                max_per = max_down,
                min_per = g_group_def[mac].min_grp_downlink,
                max_cfg = math.ceil(g_group_def[mac].max_grp_downlink),
                max = dev_info.max_down,
                min_cfg = math.ceil(g_group_def[mac].min_grp_downlink),
                min = down_rate
            }
            
            flag = g_group_def[mac].flag or flag
            if not g_group_def[mac].flag then
                flag = "on"
            end
        else
            -- 使用默认配置
            up_info = {
                max_per = 0,
                min_per = 0.5,
                max_cfg = 0,
                max = dev_info.max_up,
                min_cfg = 0,
                min = up_rate
            }
            
            down_info = {
                max_per = 0,
                min_per = 0.5,
                max_cfg = 0,
                max = dev_info.max_down,
                min_cfg = 0,
                min = down_rate
            }
        end
        
        result[idx] = {
            MAC = mac,
            UP = up_info,
            DOWN = down_info,
            flag = flag
        }
    end
    
    return result
end

qdisc["host"].update_counters = update_counters

--[[
  检查 IP 是否在同一子网
  @param ip1 第一个 IP 地址
  @param ip2 第二个 IP 地址
  @param mask 子网掩码
  @return 是否在同一子网
]]
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

--[[
  获取网络接口的 IP 地址和掩码
  @param interface 接口名称
  @return IP地址, 子网掩码
]]
local function get_interface_address(interface)
    local status = g_ubus:call("network.interface", "status", { interface = interface })
    
    if status then
        local addr_count = table.getn(status["ipv4-address"])
        if addr_count > 0 then
            local addr_info = table.remove(status["ipv4-address"])
            return addr_info.address, addr_info.mask
        end
    end
    
    return nil
end

--[[
  扫描在线主机
  从 trafficd 获取当前在线设备列表
]]
local function scan_online_hosts()
    local devices = g_ubus.call(g_ubus, "trafficd", "hw", {})
    
    if not devices then
        return
    end
    
    for _, device in pairs(devices) do
        local mac = device.hw
        local connection_type = "0"  -- 0=有线, 1=无线, 2=其他
        
        -- 判断连接类型
        if device.ifname == "wl0" or device.ifname == "wl1" then
            connection_type = "1"
        elseif string.find(device.ifname, "wl", 1) then
            connection_type = "2"
        end
        
        -- 遍历设备的 IP 地址
        for _, ip_info in pairs(device.ip_list) do
            local ip = ip_info.ip
            local is_online = false
            
            -- 获取 IP 最后一段作为 ID
            local ip_parts = string.split(ip, ".")
            local host_id = ip_parts[4]
            
            -- 检查是否在 LAN 子网内
            if cfg.lan.ip and cfg.lan.mask then
                local in_subnet = is_same_subnet(ip, cfg.lan.ip, tonumber(cfg.lan.mask))
                
                if in_subnet then
                    -- 根据连接类型判断在线状态
                    if connection_type == "1" then
                        -- 无线设备: 检查关联状态
                        if device.assoc == 1 then
                            is_online = true
                        end
                    elseif connection_type == "0" then
                        -- 有线设备: 检查老化时间
                        if ip_info.ageing_timer <= host_config.online_timeout.wi then
                            is_online = true
                        end
                    end
                end
            end
            
            -- 添加到在线主机列表
            if is_online and host_id then
                current_hosts[ip] = {
                    mac = mac,
                    st = "S_NEW",
                    id = host_id,
                    idle = ip_info.ageing_timer
                }
                
                -- 更新 MAC 到 IP 的映射
                if not mac_to_ips[mac] then
                    mac_to_ips[mac] = {}
                end
                table.insert(mac_to_ips[mac], ip)
            end
        end
    end
end

--[[
  计算每个分组的带宽分配
  根据在线主机数量动态计算每个分组的速率
]]
local function calculate_group_bandwidth()
    local total_min = {
        UP = 0,
        DOWN = 0
    }
    
    -- 计算所有在线主机的最小带宽总和
    for mac, ip_list in pairs(mac_to_ips) do
        for _, ip in pairs(ip_list) do
            local group_name = mac
            
            if not g_group_def[group_name] then
                group_name = cfg.group.default
            end
            
            local min_up = tonumber(g_group_def[group_name].min_grp_uplink)
            local min_down = tonumber(g_group_def[group_name].min_grp_downlink)
            
            total_min[UP] = total_min[UP] + min_up
            total_min[DOWN] = total_min[DOWN] + min_down
        end
    end
    
    -- 计算每个分组的实际速率
    for group_name, group_config in pairs(g_group_def) do
        if group_config then
            -- 计算每个主机的速率
            local host_count = 0
            if mac_to_ips[group_name] then
                host_count = #mac_to_ips[group_name]
            end
            
            if host_count > 0 then
                group_config.each_up_rate = group_config.min_grp_uplink
                group_config.each_down_rate = group_config.min_grp_downlink
                
                if host_count <= 1 then
                    group_config.each_up_ceil = group_config.max_grp_uplink
                else
                    group_config.each_up_ceil = group_config.max_grp_uplink / host_count
                end
                
                if host_count <= 1 then
                    group_config.each_down_ceil = group_config.max_grp_downlink
                else
                    group_config.each_down_ceil = group_config.max_grp_downlink / host_count
                end
                
                logger(3, group_name .. ",[UP]min=" .. g_group_def[group_name].each_up_rate ..
                    ",max=" .. g_group_def[group_name].each_up_ceil ..
                    ";[DOWN]min=" .. g_group_def[group_name].each_down_rate ..
                    ",max=" .. g_group_def[group_name].each_down_ceil)
            end
        end
    end
end

--[[
  检测主机列表变化
  比较当前和上一次的主机列表，标记变化
  @return 是否有变化
]]
local function detect_host_changes()
    local changed = false
    
    previous_hosts = current_hosts
    current_hosts = {}
    mac_to_ips = {}
    
    scan_online_hosts()
    
    -- 检查更新和新增的主机
    for ip, new_info in pairs(current_hosts) do
        local old_info = previous_hosts[ip]
        
        if old_info then
            current_hosts[ip].st = "S_UPD"
            
            -- 检查 MAC 是否变化
            if old_info.mac ~= new_info.mac then
                changed = true
            end
            
            previous_hosts[ip] = nil
        else
            changed = true
        end
    end
    
    -- 检查删除的主机
    for ip, old_info in pairs(previous_hosts) do
        if not current_hosts[ip] then
            previous_hosts[ip].st = "S_DEL"
            changed = true
            logger(3, "expired ip " .. ip .. " out triggered flush.")
        else
            logger(3, "ERROR: except case; should no any non-del records in such table.")
        end
    end
    
    return changed
end

--[[
  检查配置是否变化
  @return 是否需要重新应用规则
]]
local function check_config_changed()
    return true
end

qdisc["host"].changed = check_config_changed

--[[
  读取 QoS 配置变化
  检测各种配置项的变化并返回变化级别
  @return 变化级别 ("0"=无变化, "1"=带宽变化, "2"=配置变化)
]]
local function read_qos_config_changes()
    local change_level = "0"
    local change_desc = ""
    
    -- 检查分组配置变化
    if cfg.group.changed then
        change_desc = change_desc .. "/group"
        cfg.group.changed = false
        change_level = "2"
    end
    
    -- 检查 QoS 类型变化
    if cfg.qos_type.changed then
        change_desc = change_desc .. "/qos type"
        cfg.qos_type.changed = false
        change_level = "2"
    end
    
    -- 检查带宽预留主机变化
    if band_reserve_hosts.changed then
        change_desc = change_desc .. "/band-reserve-hosts"
        band_reserve_hosts.changed = false
        change_level = "2"
    end
    
    -- 检查特殊主机列表变化
    if special_host_list.changed then
        change_desc = change_desc .. "/special host list"
        special_host_list.changed = false
        change_level = "2"
    end
    
    -- 检查主机列表变化
    if detect_host_changes() then
        change_desc = change_desc .. "/hosts list"
        change_level = "2"
    end
    
    -- 检查带宽变化
    if cfg.bands.changed then
        change_desc = change_desc .. "/bandwidth"
        cfg.bands.changed = false
        change_level = "1"
    end
    
    -- 检查访客网络变化
    if cfg.guest.changed == 1 then
        change_desc = change_desc .. "/guest"
        cfg.guest.changed = 0
        change_level = "1"
    end
    
    -- 检查抑制开关变化
    if cfg.supress_host.changed then
        change_desc = change_desc .. "/supress switch"
        cfg.supress_host.changed = false
        change_level = "1"
    end
    
    if change_desc ~= "" then
        logger(3, "CHANGE: " .. change_desc)
    end
    
    if change_level ~= "0" then
        calculate_group_bandwidth()
    end
    
    return change_level
end

--[[
  生成单个主机的 TC 类规则
  @param commands 命令列表
  @param dev 设备名
  @param direction 方向(UP/DOWN)
  @param qdisc_id qdisc ID
  @param action 动作(add/del/change)
  @param parent_id 父类 ID
  @param host_id 主机 ID
  @param rate 保证速率
  @param ceil 上限速率
  @param quantum 量子值
  @return 默认类 ID
]]
local function generate_host_class(commands, dev, direction, qdisc_id, action, parent_id, host_id, rate, ceil, quantum)
    local subclass_count = #service_subclass
    local cmd = ""
    local burst, cburst = get_burst(ceil)
    local class_id = parent_id + host_id * 16
    
    if action == "del" then
        -- 删除主机类
        cmd = string.format("%s %s dev %s classid %s:%s ",
            const_tc_class, action, dev, qdisc_id, dec2hexstr(class_id))
        table.insert(commands, 1, cmd)
    elseif action == "change" then
        -- 修改主机类
        cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s " ..
            "quantum %s burst %d cburst %d",
            const_tc_class, action, dev, qdisc_id, dec2hexstr(parent_id),
            qdisc_id, dec2hexstr(class_id), rate, UNIT, ceil, UNIT, burst, cburst, quantum)
        table.insert(commands, 1, cmd)
    else
        -- 添加主机类
        cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s " ..
            "quantum %s burst %d cburst %d",
            const_tc_class, action, dev, qdisc_id, dec2hexstr(parent_id),
            qdisc_id, dec2hexstr(class_id), rate, UNIT, ceil, UNIT, burst, cburst, quantum)
        table.insert(commands, cmd)
    end
    
    -- 生成服务类型子类
    local default_class_id = 0
    
    for i = 1, subclass_count do
        local subclass_offset = host_id * 16 + i
        local subclass_id = parent_id + subclass_offset
        local subclass_config = service_subclass[i]
        
        if action == "del" then
            cmd = string.format("%s %s dev %s classid %s:%s ",
                const_tc_class, action, dev, qdisc_id, dec2hexstr(subclass_id))
            table.insert(commands, 1, cmd)
        else
            local sub_rate = math.ceil(rate * subclass_config.rate)
            local sub_ceil = math.ceil(ceil * subclass_config.ceil)
            local sub_burst, sub_cburst = get_burst(sub_ceil)
            local sub_prio = subclass_config.prio
            
            cmd = string.format("%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s " ..
                "quantum %s burst %d cburst %d",
                const_tc_class, action, dev, qdisc_id, dec2hexstr(class_id),
                qdisc_id, dec2hexstr(subclass_id), sub_rate, UNIT, sub_ceil, UNIT, sub_prio,
                quantum, sub_burst, sub_cburst)
            
            if action == "change" then
                table.insert(commands, 1, cmd)
            else
                table.insert(commands, cmd)
            end
            
            -- 应用叶子 qdisc
            apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(subclass_id), sub_ceil)
        end
        
        -- 记录默认类
        if subclass_config.default then
            default_class_id = subclass_id
        end
        
        -- 生成过滤器规则
        local filter_prio = "5"
        cmd = string.format(" %s %s dev %s parent %s: prio %s handle 0x%s00000/0xfff00000 fw classid %s:%s ",
            const_tc_filter, action, dev, qdisc_id, filter_prio,
            dec2hexstr(subclass_offset), qdisc_id, dec2hexstr(subclass_id))
        
        if action == "del" then
            table.insert(commands, 1, cmd)
        elseif action ~= "change" then
            table.insert(commands, cmd)
        end
    end
    
    -- 生成默认过滤器
    if default_class_id ~= 0 then
        cmd = string.format(" %s %s dev %s parent %s: prio %s handle 0x%s00000/0xff000000 fw classid %s:%s ",
            const_tc_filter, action, dev, qdisc_id, filter_prio,
            dec2hexstr(host_id), qdisc_id, dec2hexstr(default_class_id))
        
        if action == "del" then
            table.insert(commands, 1, cmd)
        elseif action ~= "change" then
            table.insert(commands, cmd)
        end
    end
    
    return default_class_id
end

--[[
  生成所有主机的 TC 规则
  @param commands 命令列表
  @param dev 设备名
  @param direction 方向
  @param qdisc_id qdisc ID
  @param total_rate 总速率
  @param default_ceil 默认上限
  @param action 动作
  @param parent_id 父类 ID
  @return 是否成功
]]
local function generate_all_hosts_rules(commands, dev, direction, qdisc_id, total_rate, default_ceil, action, parent_id)
    local cmd = ""
    local real_action = "add"
    
    -- 处理删除操作
    if action ~= "add" then
        real_action = "del"
        
        for ip, host_info in pairs(previous_hosts) do
            if host_info.st == "S_DEL" then
                logger(3, "--- del MAC " .. host_info.mac .. ", IP " .. ip)
                
                local host_id = tonumber(host_info.id)
                local result = generate_host_class(commands, dev, direction, qdisc_id, real_action,
                    parent_id, host_id, 0, 0, 0)
                
                if not result then
                    logger(3, "gen del host:" .. host_info.id .. " failed.")
                    return false
                end
            end
        end
    end
    
    -- 调整总速率(减去特殊主机占用)
    if direction == UP then
        local special_rate = htb_class_config.child[1].rate
        if special_rate then
            total_rate = total_rate - special_rate * total_rate
        end
    end
    
    -- 处理每个在线主机
    for ip, host_info in pairs(current_hosts) do
        local host_action = "add"
        if host_info.st ~= "S_NEW" then
            host_action = "change"
        end
        
        local mac = host_info.mac
        local host_id = tonumber(host_info.id)
        
        -- 获取分组配置
        local group_config = g_group_def[mac]
        if not group_config then
            group_config = g_group_def[cfg.group.default]
        end
        
        -- 计算主机速率
        local rate, ceil, quantum
        
        if direction == UP then
            rate = total_rate * group_config.each_up_rate
            ceil = group_config.each_up_ceil or 0
            if not ceil or ceil > total_rate then
                ceil = 0
            end
            quantum = group_config.quantum_up
        else
            rate = total_rate * group_config.each_down_rate
            ceil = group_config.each_down_ceil or 0
            if not ceil or ceil > total_rate then
                ceil = 0
            end
            quantum = group_config.quantum_down
        end
        
        -- 应用默认上限
        if ceil <= 0 then
            ceil = default_ceil
        end
        if ceil < 40 then
            ceil = 40
        end
        if rate > ceil then
            rate = ceil
        end
        
        -- 限制量子值范围
        if quantum <= 0 then
            quantum = 1
        end
        if quantum > 10 then
            quantum = 10
        end
        
        -- 检查带宽预留
        if direction == UP then
            for reserve_type, reserve_hosts in pairs(band_reserve_hosts) do
                if reserve_hosts[ip] then
                    if g_debug then
                        logger(3, "reserve band " .. video_reserve_config[reserve_type].band ..
                            "kbps for " .. ip)
                    end
                    rate = rate + video_reserve_config[reserve_type].band
                    break
                end
            end
        end
        
        logger(3, mac .. ",IP " .. ip .. ", " .. direction .. "," .. rate .. "-" .. ceil ..
            ", id:" .. host_info.id .. ",action:" .. host_action)
        
        -- 生成主机类规则
        local result = generate_host_class(commands, dev, direction, qdisc_id, host_action,
            parent_id, host_id, rate, ceil, quantum)
        
        if not result then
            logger(3, host_action .. " host: " .. host_info.ip .. " failed.")
            return false
        end
    end
    
    return true
end

-- 主机类状态缓存
local host_class_state = {
    [UP] = { id = 0, ceil = 0 },
    [DOWN] = { id = 0, ceil = 0 }
}

--[[
  更新所有主机的带宽(仅修改速率)
  @param commands 命令列表
  @param dev_list 设备列表
  @param action 动作
  @param bands 带宽配置
  @param change_level 变化级别
  @return 是否成功
]]
local function update_hosts_bandwidth(commands, dev_list, action, bands, change_level)
    if action ~= "change" then
        logger(3, "update_hosts_bandwidth: invalid action")
        return false
    end
    
    local cmd = ""
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        local parent_id = host_class_state[direction].id
        local rate = host_class_state[direction].rate
        local ceil = host_class_state[direction].ceil
        
        local result = generate_all_hosts_rules(commands, dev, direction, qdisc_id,
            rate, ceil, action, parent_id)
        
        if not result then
            logger(3, "gen all hosts rules failed.")
            return false
        end
    end
    
    return true
end

--[[
  生成完整的 host qdisc 规则
  @param commands 命令列表
  @param dev_list 设备列表
  @param action 动作
  @param bands 带宽配置
  @param change_level 变化级别
  @return 是否成功
]]
local function generate_host_qdisc(commands, dev_list, action, bands, change_level)
    local cmd = ""
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        local total_band = bands[direction]
        
        -- 添加根 qdisc
        if action == "add" then
            cmd = string.format("%s %s dev %s root handle %s: %s htb default %s ",
                const_tc_qdisc, action, dev, qdisc_id,
                cfg.qdisc_type or "htb", dec2hexstr(htb_class_config.dft))
            table.insert(commands, cmd)
        end
        
        -- 计算根类参数
        local root_quantum = math.ceil(htb_class_config.quan_v * htb_class_config.root.quan)
        local root_class_hex = dec2hexstr(htb_class_config.root.id)
        local root_burst, root_cburst = get_burst(tonumber(total_band))
        
        -- 添加根类
        cmd = string.format("%s %s dev %s parent %s: classid %s:%s htb rate %s%s quantum %s burst %d cburst %d",
            const_tc_class, action, dev, qdisc_id, qdisc_id, root_class_hex,
            total_band, UNIT, root_quantum, root_burst, root_cburst)
        table.insert(commands, cmd)
        
        -- 添加根类过滤器
        cmd = string.format("%s %s dev %s parent %s: prio %s handle %s fw classid %s:0",
            const_tc_filter, action, dev, qdisc_id,
            htb_class_config.root.fprio, htb_class_config.root.fwmark, qdisc_id)
        table.insert(commands, cmd)
        
        -- 应用 PPPoE qdisc
        apply_ppp_qdisc(commands, dev, qdisc_id)
        
        -- 添加子类
        local parent_hex = root_class_hex
        
        for _, child_config in ipairs(htb_class_config.child) do
            local child_id = child_config.id
            local child_prio = child_config.prio
            local child_rate = math.ceil(total_band * child_config.rate)
            local child_ceil = math.ceil(total_band * child_config.ceil)
            
            -- 处理限速配置
            if child_config.limit then
                local limit_value = tonumber(child_config.limit[direction])
                child_ceil = limit_value
                
                if child_ceil <= 1 then
                    child_ceil = math.ceil(bands[direction] * child_ceil)
                end
            end
            
            -- 应用抑制
            local supressed_ceil = get_supressed_ceil(child_ceil, child_config.supress)
            if child_rate > supressed_ceil then
                child_rate = supressed_ceil
            end
            
            local child_burst, child_cburst = get_burst(supressed_ceil)
            local child_quantum = math.ceil(child_config.quan * htb_class_config.quan_v)
            
            -- 添加子类
            cmd = string.format(" %s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s " ..
                "prio %s quantum %s burst %d cburst %d",
                const_tc_class, action, dev, qdisc_id, parent_hex,
                qdisc_id, dec2hexstr(child_id), child_rate, UNIT, supressed_ceil, UNIT,
                child_prio, child_quantum, child_burst, child_cburst)
            table.insert(commands, cmd)
            
            -- 小包过滤器
            if host_config.qos.small and child_config.highest_prio then
                apply_arp_small_filter(commands, dev, "add", qdisc_id, dec2hexstr(child_id))
            end
            
            -- 添加过滤器
            if child_config.fwmark and child_config.fwmark ~= "" then
                if action == "add" then
                    cmd = string.format(" %s %s dev %s parent %s: prio %s handle %s fw classid %s:%s",
                        const_tc_filter, action, dev, qdisc_id,
                        child_config.fprio, child_config.fwmark, qdisc_id, dec2hexstr(child_id))
                    table.insert(commands, cmd)
                    
                    apply_leaf_qdisc(commands, dev, qdisc_id, dec2hexstr(child_id), supressed_ceil)
                end
            else
                -- 主机类: 保存状态并生成主机规则
                host_class_state[direction] = {
                    id = child_id,
                    rate = child_rate,
                    ceil = supressed_ceil
                }
                
                local result = generate_all_hosts_rules(commands, dev, direction, qdisc_id,
                    child_rate, supressed_ceil, action, child_id)
                
                if not result then
                    logger(3, "gen all hosts rules failed.")
                    return false
                end
            end
        end
    end
    
    return true
end

--[[
  根据变化级别应用规则
  @param commands 命令列表
  @param dev_list 设备列表
  @param action 动作
  @param bands 带宽配置
  @param change_level 变化级别
  @return 是否成功
]]
local function apply_by_change_level(commands, dev_list, action, bands, change_level)
    local result = false
    
    if change_level == "2" then
        -- 配置变化: 重新生成所有规则
        result = generate_host_qdisc(commands, dev_list, action, bands, change_level)
    elseif change_level == "1" then
        -- 带宽变化: 仅更新速率
        result = update_hosts_bandwidth(commands, dev_list, action, bands, change_level)
    else
        logger(3, "not supported changed-level.")
        return false
    end
    
    return result
end

-- 特殊主机过滤器配置
local special_host_filter = {
    HIGH_PRIO_WITHOUT_LIMIT = {
        ftprio = "2",
        flow = "0"
    },
    HIGH_PRIO_WITH_BANDLIMIT = {
        ftprio = "2",
        flow = "2000"
    }
}

--[[
  应用特殊主机过滤规则
  @param commands 命令列表
  @param dev_list 设备列表
  @return 是否成功
]]
local function apply_special_host_filter(commands, dev_list)
    local del_commands = {}
    
    for direction, dev_info in pairs(dev_list) do
        local dev = dev_info.dev
        local qdisc_id = dev_info.id
        
        -- 先删除旧的过滤器
        for _, filter_config in pairs(special_host_filter) do
            local cmd = string.format("%s del dev %s parent %s: prio %s ",
                const_tc_filter, dev, qdisc_id, filter_config.ftprio)
            table.insert(del_commands, cmd)
        end
        
        -- 添加新的过滤器
        for ip, filter_type in pairs(special_host_list) do
            local filter_config = special_host_filter[filter_type]
            
            if filter_config then
                local ftprio = filter_config.ftprio
                local flow_class = filter_config.flow
                
                -- 从 IP 获取主机 ID
                local ip_parts = string.split(ip, ".")
                local host_id = tonumber(ip_parts[4])
                local fwmark = "0x" .. dec2hexstr(host_id) .. "000000/0xff000000"
                
                local cmd = string.format(" %s replace dev %s parent %s: prio %s handle %s fw classid %s:%s ",
                    const_tc_filter, dev, qdisc_id, ftprio, fwmark, qdisc_id, flow_class)
                table.insert(commands, cmd)
            end
        end
    end
    
    exec_cmd(del_commands, nil)
    return true
end

--[[
  更新视频带宽预留配置
  根据当前带宽动态调整视频预留带宽
]]
local function update_video_reserve_config()
    for reserve_type, reserve_list in pairs(video_reserve_config) do
        if reserve_list then
            for _, config in pairs(reserve_list) do
                if config.id then
                    local current_band = tonumber(cfg.bands.DOWN)
                    
                    if current_band > config.id then
                        band_reserve_hosts[reserve_type].band = config.band
                    else
                        break
                    end
                end
            end
        end
    end
end

--[[
  读取 QoS 配置
  @return 是否成功
]]
local function read_qos_config()
    -- 更新视频预留配置
    if cfg.bands.changed then
        update_video_reserve_config()
    end
    
    -- 读取分组配置
    local result = read_qos_group_config()
    if not result then
        logger(3, "read_qos_group_config failed.")
        return false
    end
    
    -- 读取访客和小米设备配置
    result = read_qos_guest_xq_config()
    if not result then
        logger(3, "read_qos_guest_xq_config failed.")
        return false
    end
end

qdisc["host"].read_qos_config = read_qos_config

--[[
  应用 host qdisc 规则
  @param prev_qdisc 上一个 qdisc 类型
  @param bands 带宽配置
  @param dev_list 设备列表
  @param force 是否强制重新应用
  @return 是否成功
]]
local function apply_host_qdisc(prev_qdisc, bands, dev_list, force)
    local action = "add"
    local change_level = "0"
    
    if not prev_qdisc then
        -- 首次应用
        change_level = read_qos_config_changes()
        change_level = "1"
        action = "add"
    else
        local current_qdisc = qdisc[prev_qdisc]
        
        if not current_qdisc then
            logger(3, "ERROR: qdisc `" .. prev_qdisc .. "` not found. ")
            return false
        elseif force then
            -- 强制重新应用
            qdisc["host"].clean(dev_list)
            action = "add"
        else
            if prev_qdisc == "host" then
                -- 同类型: 检查变化
                change_level = read_qos_config_changes()
                
                if change_level == "0" then
                    return false
                end
                
                action = "change"
            else
                -- 不同类型: 清理后重新添加
                qdisc["host"].clean(dev_list)
                change_level = read_qos_config_changes()
                change_level = "1"
                action = "add"
            end
        end
    end
    
    -- 生成并执行命令
    local commands = {}
    
    local result = apply_by_change_level(commands, dev_list, action, bands, change_level)
    if not result then
        logger(3, "ERROR: generate host qdisc failed. ")
        return false
    end
    
    -- 应用特殊主机过滤器
    result = apply_special_host_filter(commands, dev_list)
    if not result then
        return false
    end
    
    -- 执行命令
    result = exec_cmd(commands, nil)
    if not result then
        logger(3, "ERROR: apply host qdisc failed.")
        return false
    end
    
    return true
end

qdisc["host"].apply = apply_host_qdisc
