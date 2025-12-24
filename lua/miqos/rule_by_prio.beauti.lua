--[[
  小米路由器 MiQoS 优先级规则模块
  
  功能说明:
  - 基于流量优先级的 QoS 规则管理
  - 使用 prio qdisc 实现简单的优先级队列
  - 支持高优先级、游戏、网页、视频、其他、访客、小米设备等分类
  
  队列结构:
  - 使用 prio qdisc 作为根队列
  - 通过 fw 过滤器根据 fwmark 分类流量
  - 支持 TBF (Token Bucket Filter) 限速
]]

require("miqos.common")

if not qdisc then
    qdisc = {}
end

local QDISC_TYPE = "prio"

local fwmark_rules = {
    high = {
        { fwmark = "0x00010000/0x000f0000", fprio = "4" }
    },
    game = {
        { fwmark = "0x00020000/0x000f0000", fprio = "4" },
        { fwmark = "0x00130000/0x00ff0000", fprio = "5" }
    },
    web = {
        { fwmark = "0x00230000/0x00ff0000", fprio = "5" }
    },
    video = {
        { fwmark = "0x00330000/0x00ff0000", fprio = "5" }
    },
    other = {
        { fwmark = "0x00430000/0x00ff0000", fprio = "5" }
    },
    guest = {
        { fwmark = "0x00040000/0x000f0000", fprio = "4" }
    },
    xq = {
        { fwmark = "0x00050000/0x000f0000", fprio = "4" }
    }
}

local qos_config = {
    small = false
}

local prio_config = {
    dft = 28672,
    quan_v = 1500,
    root = {
        id = 4096,
        quan = 8
    },
    child = {
        { id = 1, prio = "1", type = "high", cid = 1 },
        { id = 2, prio = "2", type = "game", cid = 2 },
        { id = 3, prio = "3", type = "web", cid = 3 },
        { id = 4, prio = "4", type = "video", cid = 4 },
        { id = 5, prio = "5", type = "other", cid = 5 },
        { id = 6, prio = "6", type = "guest", limit = cfg.guest, cid = 11 },
        { id = 7, prio = "7", type = "xq", limit = cfg.xq, cid = 12 }
    }
}

local special_filter_types = {
    HIGH_PRIO_WITHOUT_LIMIT = { ftprio = "1", flow = "1" },
    HIGH_PRIO_WITH_BANDLIMIT = { ftprio = "2", flow = "2" }
}

qdisc[QDISC_TYPE] = {}

-- 清理 prio qdisc 规则
-- @param devs 设备列表
function qdisc[QDISC_TYPE].clean(devs)
    local cmds = {}
    
    if not devs then
        return
    end
    
    for _, dev_info in pairs(devs) do
        local cmd = string.format("%s del dev %s root ", const_tc_qdisc, dev_info.dev)
        table.insert(cmds, cmd)
    end
    
    exec_cmd(cmds, 1)
end

-- 检查配置是否有变化
-- @return 是否有变化
function qdisc[QDISC_TYPE].changed()
    local has_changed = false
    local change_log = ""
    
    if cfg.bands.changed then
        change_log = change_log .. "/band"
        cfg.bands.changed = false
        has_changed = true
    end
    
    if cfg.guest.changed == 1 then
        change_log = change_log .. "/guest"
        cfg.guest.changed = 0
        has_changed = true
    end
    
    if special_host_list.changed then
        change_log = change_log .. "/speical host list"
        special_host_list.changed = false
        has_changed = true
    end
    
    if change_log ~= "" then
        logger(3, "CHANGE: " .. change_log)
    end
    
    return has_changed
end

-- 读取 QoS 配置
-- @return 是否成功
function qdisc[QDISC_TYPE].read_qos_config()
    local config = read_qos_guest_xq_config(true)
    if not config then
        logger(3, "read_qos_config failed.")
        return false
    end
end

-- 生成特殊主机过滤规则
-- @param cmd_list 命令列表
-- @param devs 设备列表
-- @return 是否成功
local function gen_special_host_filters(cmd_list, devs)
    local del_cmds = {}
    
    for _, dev_info in pairs(devs) do
        local dev = dev_info.dev
        local parent_id = dev_info.id
        
        for _, filter_type in pairs(special_filter_types) do
            local del_cmd = string.format("%s del dev %s parent %s: prio %s ",
                const_tc_filter, dev, parent_id, filter_type.ftprio)
            table.insert(del_cmds, del_cmd)
        end
        
        for ip, filter_name in pairs(special_host_list.host or {}) do
            local filter_info = special_filter_types[filter_name]
            if filter_info then
                local ftprio = filter_info.ftprio
                local flow_id = filter_info.flow
                
                local ip_parts = string.split(ip, ".")
                local last_octet = tonumber(ip_parts[4])
                local fwmark = "0x" .. dec2hexstr(last_octet) .. "000000/0xff000000"
                
                local filter_cmd = string.format(" %s replace dev %s parent %s: prio %s handle %s fw classid %s:%s ",
                    const_tc_filter, dev, parent_id, ftprio, fwmark, parent_id, flow_id)
                table.insert(cmd_list, filter_cmd)
            end
        end
    end
    
    exec_cmd(del_cmds, 1)
    return true
end

-- 生成 prio qdisc 规则
-- @param cmd_list 命令列表
-- @param devs 设备列表
-- @param action 操作类型 (add/change)
-- @param bands 带宽配置
-- @return 是否成功
local function gen_prio_qdisc(cmd_list, devs, action, bands)
    local cmd = ""
    
    for dir, dev_info in pairs(devs) do
        local dev = dev_info.dev
        local parent_id = dev_info.id
        local num_bands = table.getn(prio_config.child)
        local band_value = bands[dir]
        
        if action == "add" then
            cmd = string.format(" %s %s dev %s root handle %s: prio bands %d priomap 2 3 3 3 2 3 1 1 2 2 2 2 2 2 2 2 ",
                const_tc_qdisc, action, dev, parent_id, num_bands)
            table.insert(cmd_list, cmd)
        end
        
        local filter_prio, fwmark
        
        for class_id, class_info in ipairs(prio_config.child) do
            local rules = fwmark_rules[class_info.type]
            if not rules then
                logger(3, "ERROR: fwmark rules for type " .. class_info.type .. " not found.")
                return false
            end
            
            for _, rule in ipairs(rules) do
                filter_prio = rule.fprio
                fwmark = rule.fwmark
                
                cmd = string.format(" %s %s dev %s parent %s: prio %s handle %s fw classid %s:%s ",
                    const_tc_filter, action, dev, parent_id, filter_prio, fwmark, parent_id, class_id)
                table.insert(cmd_list, cmd)
                
                local rate = 0
                
                if class_info.limit then
                    local limit_value = class_info.limit[dir]
                    if limit_value <= 0 then
                        rate = band_value
                    elseif limit_value <= 1 then
                        rate = math.ceil(band_value * limit_value)
                    else
                        rate = math.ceil(limit_value)
                    end
                    
                    local tbf_action = "replace"
                    local buffer = math.ceil(rate * 1024 / g_CONFIG_HZ)
                    if buffer < 2000 then
                        buffer = 2000
                    end
                    
                    cmd = string.format(" %s %s dev %s parent %s:%s handle %d: tbf rate %s%s buffer %s latency 10ms",
                        const_tc_qdisc, tbf_action, dev, parent_id, class_id, class_info.cid, rate, UNIT, buffer)
                    table.insert(cmd_list, cmd)
                end
                
                if class_info.bandlimit then
                    local bandlimit = tonumber(class_info.bandlimit[dir])
                    if bandlimit > 0 then
                        rate = bandlimit
                        
                        local tbf_action = "replace"
                        local buffer = math.ceil(rate * 1024 / g_CONFIG_HZ)
                        if buffer < 2000 then
                            buffer = 2000
                        end
                        
                        cmd = string.format(" %s %s dev %s parent %s:%s handle %d: tbf rate %s%s buffer %s latency 10ms",
                            const_tc_qdisc, tbf_action, dev, parent_id, class_id, class_info.cid, rate, UNIT, buffer)
                        table.insert(cmd_list, cmd)
                    end
                end
            end
            
            if not class_info.limit and not class_info.bandlimit then
                apply_leaf_qdisc(cmd_list, dev, parent_id, class_info.cid, 0)
            end
        end
        
        if special_host_list then
            gen_special_host_filters(cmd_list, devs, "add", parent_id, band_value)
        end
    end
    
    return true
end

-- 应用 prio qdisc 规则
-- @param old_qdisc 旧的 qdisc 类型
-- @param bands 带宽配置
-- @param devs 设备列表
-- @param force_clean 是否强制清理
-- @return 是否成功
function qdisc[QDISC_TYPE].apply(old_qdisc, bands, devs, force_clean)
    local action = "add"
    
    if not old_qdisc then
        action = "add"
    else
        if not qdisc[old_qdisc] then
            logger(3, "ERROR: qdisc `" .. old_qdisc .. "` not found. ")
            return false
        elseif force_clean then
            qdisc[QDISC_TYPE].clean(devs)
            action = "add"
        else
            if old_qdisc == QDISC_TYPE then
                action = "change"
            else
                qdisc[QDISC_TYPE].clean(devs)
                action = "add"
            end
        end
    end
    
    local cmds = {}
    local success = gen_prio_qdisc(cmds, devs, action, bands)
    
    if not success then
        logger(3, "ERROR: generate prio qdisc failed.")
        return false
    end
    
    success = exec_cmd(cmds, nil)
    if not success then
        logger(3, "ERROR: apply prio qdisc failed.")
        return false
    end
    
    return true
end
