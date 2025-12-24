--[[
  小米路由器 MiQoS 命令处理模块
  
  功能说明:
  - 处理 QoS 相关的各种命令
  - 包括开关控制、带宽设置、限速管理、游戏模式等
  - 与 UCI 配置系统交互
  
  主要命令:
  - on/off: 开启/关闭 QoS
  - shutdown: 完全关闭 QoS 系统
  - change_band: 修改带宽设置
  - on_limit/set_limit/off_limit: 限速控制
  - game_mode_on/off: 游戏模式控制
  - wangzhe_plug_on/off: 王者荣耀加速插件控制
]]

local json = require("json")
require("miqos.common")

local command_handlers = {}

-- 提交配置并保存到持久存储
-- @param uci_cursor UCI游标对象
local function commit_and_save(uci_cursor)
    uci_cursor:commit("miqos")
    local success = tmp2cfg()
    if not success then
        logger(1, "copy tmp cfg to /etc/config/ failed.")
    end
end

-- 更新 QoS 启用状态
-- @param enable 是否启用 (true/false)
local function update_qos_enabled(enable)
    local cursor = get_cursor()
    local current_state = cursor:get("miqos", "settings", "enabled")
    
    if enable then
        if current_state == "1" then
            return
        end
        cursor:set("miqos", "settings", "enabled", "1")
        logger(3, "update_qos_enabled enable miqos.")
    else
        if current_state == "0" then
            return
        end
        cursor:set("miqos", "settings", "enabled", "0")
        logger(3, "update_qos_enabled disable miqos.")
    end
    
    commit_and_save(cursor)
end

-- 设置设备重定向开关
-- @param enable 1启用 0禁用
local function set_dev_redirect(enable)
    if enable == 1 then
        logger(3, "enable dev_redirect caused by qos on.")
        os.execute("[ -f /proc/sys/net/dev_redirect_enable ] && echo 1 > /proc/sys/net/dev_redirect_enable")
    else
        logger(3, "disable dev_redirect caused by qos off.")
        os.execute("[ -f /proc/sys/net/dev_redirect_enable ] && echo 0 > /proc/sys/net/dev_redirect_enable")
    end
end

-- 开启 QoS
-- @return 结果表, 是否需要应用规则
function command_handlers.on()
    update_qos_enabled(true)
    
    if not cfg.enabled.started then
        cfg.enabled.changed = true
    end
    cfg.enabled.started = true
    
    local success = read_network_conf()
    if not success then
        logger(3, "failed to read network config when `qos on`!")
    end
    
    set_dev_redirect(1)
    
    return { status = 0, data = "ok" }, true
end

-- 关闭 QoS
-- @return 结果表, 是否需要应用规则
function command_handlers.off()
    update_qos_enabled(false)
    cfg.enabled.started = true
    
    local success = read_network_conf()
    if not success then
        logger(3, "failed to read network config when `qos off`!")
    end
    
    set_dev_redirect(0)
    
    return { status = 0, data = "ok" }, true
end

-- 完全关闭 QoS 系统
-- @return 结果表, 是否需要应用规则
function command_handlers.shutdown()
    cleanup_system()
    logger(3, "QOS_VER: " .. QOS_VER .. " shutdown!")
    
    set_dev_redirect(0)
    cfg.enabled.started = false
    
    if QOS_VER and (QOS_VER == "FIX" or QOS_VER == "NOIFB") then
        return { status = 0, data = "ok" }, false
    end
    
    return { status = 0, data = "ok" }, true
end

-- 设置特殊主机优先级
-- @param action 操作类型 (add/del)
-- @param ip IP地址
-- @param priority 优先级
-- @return 结果表, 是否需要应用规则
function command_handlers.nprio(action, ip, priority)
    if not action or not ip or not priority then
        logger(3, "ERROR: parameter lost for cmd `nprio`")
        return { status = 1, data = "unkown error." }, false
    end
    
    if g_debug then
        logger(3, "nprio " .. action .. "," .. ip .. "," .. priority)
    end
    
    if action == "add" then
        if special_host_list.host[ip] and special_host_list.host[ip] == priority then
            return { status = 0, data = "already in list." }, false
        end
        
        special_host_list.host[ip] = priority
        special_host_list.changed = true
        return { status = 0, data = "ok" }, false
        
    elseif action == "del" then
        if special_host_list.host[ip] then
            special_host_list.host[ip] = nil
            special_host_list.changed = true
            return { status = 0, data = "ok" }, false
        else
            return { status = 0, data = "not exist in list." }, false
        end
    else
        return { status = 1, data = "not supported action for cmd `nprio`." }, false
    end
end

-- 设置带宽保留主机
-- @param action 操作类型 (add/del)
-- @param ip IP地址
-- @param reserve_type 保留类型
-- @return 结果表, 是否需要应用规则
function command_handlers.reserve(action, ip, reserve_type)
    if not action or not ip or not reserve_type then
        logger(3, "ERROR: parameter lost for cmd `reserve`")
        return { status = 1, data = "unkown error." }, false
    end
    
    if g_debug then
        logger(3, "update_reserved_hosts, act:" .. action .. ", ip:" .. ip .. ", type:" .. reserve_type)
    end
    
    if action == "add" then
        if not band_reserve_hosts[reserve_type] then
            band_reserve_hosts[reserve_type] = {}
        end
        
        if band_reserve_hosts[reserve_type] and band_reserve_hosts[reserve_type][ip] then
            return { status = 0, data = "already reserved." }, false
        end
        
        band_reserve_hosts[reserve_type][ip] = reserve_type
        
    elseif action == "del" then
        if band_reserve_hosts[reserve_type] and band_reserve_hosts[reserve_type][ip] then
            band_reserve_hosts[reserve_type][ip] = nil
        else
            return { status = 0, data = "already delted." }, false
        end
    else
        logger(3, "do not support act: " .. action)
        return { status = 1, data = "not supported." }, false
    end
    
    band_reserve_hosts.changed = true
    return { status = 0, data = "ok" }, false
end

-- 更新带宽设置 (内部函数)
-- @param upload 上传带宽
-- @param download 下载带宽
-- @return 是否成功
local function update_bandwidth(upload, download)
    if tonumber(upload) < 0 or tonumber(download) < 0 then
        return false
    end
    
    local cursor = get_cursor()
    local current_upload = cursor:get("miqos", "settings", "upload")
    local current_download = cursor:get("miqos", "settings", "download")
    
    if current_upload == upload and current_download == download then
        return true
    end
    
    cursor:set("miqos", "settings", "upload", upload)
    cursor:set("miqos", "settings", "download", download)
    commit_and_save(cursor)
    
    return true
end

-- 修改带宽设置
-- @param upload 上传带宽
-- @param download 下载带宽
-- @return 结果表, 是否需要应用规则
function command_handlers.change_band(upload, download)
    -- 检查当前带宽是否为0，如果从0变为非0需要清理系统
    local current_up = tonumber(cfg.bands.UP)
    local current_down = tonumber(cfg.bands.DOWN)
    
    if current_up <= 0 or current_down <= 0 then
        if tonumber(upload) > 0 and tonumber(download) > 0 then
            logger(3, "bands from zero to non zero, do cleanup_system")
            cleanup_system()
        end
    end
    
    if upload and download then
        if update_bandwidth(upload, download) then
            return { status = 0, data = "ok" }, true
        end
    end
    
    return { status = 1, data = "update bandwidth failed." }, false
end

-- 获取当前带宽设置 (内部函数)
-- @return 上传带宽, 下载带宽
local function get_current_bandwidth()
    local cursor = get_cursor()
    local upload = cursor:get("miqos", "settings", "upload") or "0"
    local download = cursor:get("miqos", "settings", "download") or "0"
    return upload, download
end

-- 显示当前带宽设置
-- @return 结果表, 是否需要应用规则
function command_handlers.show_band()
    local upload, download = get_current_bandwidth()
    return {
        status = 0,
        data = {
            uplink = upload,
            downlink = download
        }
    }, false
end

-- 更新访客网络限速 (内部函数)
-- @param up_percent 上传百分比
-- @param down_percent 下载百分比
-- @return 是否成功
local function update_guest_limit(up_percent, down_percent)
    local cursor = get_cursor()
    local current_up = cursor:get("miqos", "guest", "up_per")
    local current_down = cursor:get("miqos", "guest", "down_per")
    
    if current_up == up_percent and current_down == down_percent then
        return true
    end
    
    cursor:set("miqos", "guest", "up_per", up_percent)
    cursor:set("miqos", "guest", "down_per", down_percent)
    commit_and_save(cursor)
    
    return true
end

-- 设置访客网络限速
-- @param up_percent 上传百分比
-- @param down_percent 下载百分比
-- @return 结果表, 是否需要应用规则
function command_handlers.on_guest(up_percent, down_percent)
    if up_percent and down_percent then
        if update_guest_limit(up_percent, down_percent) then
            return { status = 0, data = "ok" }, true
        end
    end
    
    return { status = 1, data = "update guest limit failed." }, false
end

-- 显示访客网络限速配置
-- @return 结果表, 是否需要应用规则
function command_handlers.show_guest()
    return {
        status = 0,
        data = cfg.guest
    }, false
end

-- 更新小米设备限速 (内部函数)
-- @param up_percent 上传百分比
-- @param down_percent 下载百分比
-- @return 是否成功
local function update_xq_limit(up_percent, down_percent)
    local cursor = get_cursor()
    local current_up = cursor:get("miqos", "xq", "up_per")
    local current_down = cursor:get("miqos", "xq", "down_per")
    
    if current_up == up_percent and current_down == down_percent then
        return true
    end
    
    cursor:set("miqos", "xq", "up_per", up_percent)
    cursor:set("miqos", "xq", "down_per", down_percent)
    commit_and_save(cursor)
    
    return true
end

-- 设置小米设备限速
-- @param up_percent 上传百分比
-- @param down_percent 下载百分比
-- @return 结果表, 是否需要应用规则
function command_handlers.on_xq(up_percent, down_percent)
    if up_percent and down_percent then
        if update_xq_limit(up_percent, down_percent) then
            return { status = 0, data = "ok" }, true
        end
    end
    
    return { status = 1, data = "update xq limit failed." }, false
end

-- 显示小米设备限速配置
-- @return 结果表, 是否需要应用规则
function command_handlers.show_xq()
    return {
        status = 0,
        data = cfg.xq
    }, false
end

-- 显示限速状态
-- @return 结果表, 是否需要应用规则
function command_handlers.show_limit()
    if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
        update_counters(nil)
    end
    
    return {
        status = 0,
        data = g_limit,
        mode = cfg.qos_type.mode,
        arrange_bandwidth = {
            upload = cfg.bands.UP,
            download = cfg.bands.DOWN
        }
    }, false
end

-- 获取分组配置 (内部函数)
-- @return 分组配置表
local function get_group_config()
    if not g_group_def then
        read_qos_group_config()
    end
    
    local result = {}
    local fields = { "max_grp_uplink", "max_grp_downlink", "min_grp_uplink", "min_grp_downlink", "flag" }
    
    for name, group in pairs(g_group_def) do
        if name ~= "00" then
            result[name] = {}
            for _, field in ipairs(fields) do
                result[name][field] = group[field]
            end
        end
    end
    
    return result
end

-- 显示 QoS 配置
-- @return 结果表
function command_handlers.show_cfg()
    return {
        status = 0,
        data = get_group_config(),
        mode = cfg.qos_type.mode
    }
end

-- 设置单个设备限速 (内部函数)
-- @param mac MAC地址
-- @param max_up 最大上传 (kbps)
-- @param max_down 最大下载 (kbps)
-- @param min_up 最小上传百分比
-- @param min_down 最小下载百分比
-- @param flag 开关标志 (on/off)
local function set_device_limit(mac, max_up, max_down, min_up, min_down, flag)
    local mac_upper = string.upper(mac)
    local mac_nocolon = string.gsub(mac_upper, ":", "")
    
    local cursor = get_cursor()
    local all_sections = cursor:get_all("miqos")
    
    -- 查找已存在的配置节
    local section_name = ""
    for name, section in pairs(all_sections) do
        if section[".type"] == "group" and section.name == mac_upper then
            section_name = name
            break
        end
    end
    
    -- 如果不存在则创建新配置节
    if section_name == "" then
        section_name = cursor:add("miqos", "group")
        cursor:set("miqos", section_name, "name", mac_upper)
        cursor:set("miqos", section_name, "min_grp_uplink", "0.5")
        cursor:set("miqos", section_name, "min_grp_downlink", "0.5")
        cursor:set("miqos", section_name, "max_grp_uplink", "0")
        cursor:set("miqos", section_name, "max_grp_downlink", "0")
        cursor:set("miqos", section_name, "mode", "general")
        cursor:set("miqos", section_name, "mac", { mac_upper })
    end
    
    -- 设置开关标志
    if not flag and max_up and max_down then
        flag = "on"
    end
    if flag and (flag == "on" or flag == "off") then
        cursor:set("miqos", section_name, "flag", flag)
    end
    
    -- 设置最小上传百分比
    if min_up then
        if min_up <= 0 or min_up > 1 then
            min_up = g_default_min_updown_factor
            if logger then
                logger(3, "setting min reserve out of range, set it to default value.")
            end
        end
        cursor:set("miqos", section_name, "min_grp_uplink", min_up)
    end
    
    -- 设置最小下载百分比
    if min_down then
        if min_down <= 0 or min_down > 1 then
            min_down = g_default_min_updown_factor
            if logger then
                logger(3, "setting min reserve out of range, set it to default value.")
            end
        end
        cursor:set("miqos", section_name, "min_grp_downlink", min_down)
    end
    
    -- 设置最大上传带宽
    if max_up then
        if max_up < 8 then
            max_up = 0
            if logger then
                logger(3, "NOTE: setting min reserve out of range, set it to default value.")
            end
        end
        cursor:set("miqos", section_name, "max_grp_uplink", max_up)
    end
    
    -- 设置最大下载带宽
    if max_down then
        if max_down < 8 then
            max_down = 0
            if logger then
                logger(3, "NOTE: setting min reserve out of range, set it to default value.")
            end
        end
        cursor:set("miqos", section_name, "max_grp_downlink", max_down)
    end
    
    cursor:commit("miqos")
end

-- 设置限速 (开启)
-- @param mode 模式 (max/min/both)
-- @param mac MAC地址
-- @param param1-4 参数 (根据模式不同含义不同)
-- @return 结果表, 是否需要应用规则
function command_handlers.on_limit(mode, mac, param1, param2, param3, param4)
    if mode == "max" then
        set_device_limit(mac, param1, param2, nil, nil, nil)
    elseif mode == "min" then
        set_device_limit(mac, nil, nil, param1, param2, nil)
    elseif mode == "both" then
        set_device_limit(mac, param1, param2, param3, param4, nil)
    else
        logger(3, "not supported on_limit mode.")
        return { status = 1, data = "not supported on_limit mode." }, false
    end
    
    cfg.group.changed = true
    return { status = 0, data = "ok" }, true
end

-- 设置限速 (不触发应用)
-- @param mode 模式 (max/min/both)
-- @param mac MAC地址
-- @param param1-4 参数
-- @return 结果表, 是否需要应用规则
function command_handlers.set_limit(mode, mac, param1, param2, param3, param4)
    if mode == "max" then
        set_device_limit(mac, param1, param2, nil, nil, nil)
    elseif mode == "min" then
        set_device_limit(mac, nil, nil, param1, param2, nil)
    elseif mode == "both" then
        set_device_limit(mac, param1, param2, param3, param4, nil)
    else
        logger(3, "not supported on_limit mode.")
        return { status = 1, data = "not supported on_limit mode." }, false
    end
    
    cfg.group.changed = true
    return { status = 0, data = "ok" }, false
end

-- 应用配置
-- @return 结果表, 是否需要应用规则
function command_handlers.apply()
    return { status = 0, data = "ok" }, true
end

-- 删除限速配置 (内部函数)
-- @param mac MAC地址 (nil表示删除所有)
local function delete_limit_config(mac)
    local cursor = get_cursor()
    local all_sections = cursor:get_all("miqos")
    local mac_upper = mac and string.upper(mac) or nil
    
    if mac_upper then
        -- 删除指定MAC的配置
        for name, section in pairs(all_sections) do
            if section[".type"] == "group" and section.name == mac_upper then
                cursor:delete("miqos", name)
                break
            end
        end
    else
        -- 删除所有非默认配置
        for name, section in pairs(all_sections) do
            if section[".type"] == "group" and section.name ~= "00" then
                cursor:delete("miqos", name)
            end
        end
    end
    
    cursor:commit("miqos")
end

-- 关闭限速
-- @param mac MAC地址 (可选)
-- @return 结果表, 是否需要应用规则
function command_handlers.off_limit(mac)
    delete_limit_config(mac)
    cfg.group.changed = true
    return { status = 0, data = "ok" }, true
end

-- 设置限速开关标志
-- @param mac MAC地址
-- @param flag 开关标志 (on/off)
-- @return 结果表, 是否需要应用规则
function command_handlers.limit_flag(mac, flag)
    if not mac or not flag then
        return { status = 1, data = "parameters mac or on_flag is NULL." }, false
    end
    
    if flag ~= "on" and flag ~= "off" then
        return { status = 1, data = "parameters on_flag is not one of on/off." }, false
    end
    
    if not g_group_def then
        read_qos_group_config()
    end
    
    if g_group_def[mac] and g_group_def[mac].flag and g_group_def[mac].flag == flag then
        return { status = 0, data = "parameters on_flag with same value." }, false
    end
    
    set_device_limit(mac, nil, nil, nil, nil, flag)
    
    return { status = 0, data = "ok" }, true
end

-- 设置 QoS 自动模式 (内部函数)
-- @param mode 模式
local function set_qos_auto_mode(mode)
    local cursor = get_cursor()
    local current_mode = cursor:get("miqos", "settings", "qos_auto")
    
    if current_mode == mode then
        return
    end
    
    cursor:set("miqos", "settings", "qos_auto", mode)
    commit_and_save(cursor)
end

-- 设置 QoS 类型
-- @param mode 模式 (auto/min/max/both/service)
-- @return 结果表, 是否需要应用规则
function command_handlers.set_type(mode)
    if mode == "auto" then
        logger(3, "----->>set to auto-limit-mode.")
    elseif mode == "min" then
        logger(3, "----->>set to min-limit-mode.")
    elseif mode == "max" then
        logger(3, "----->>set to max-limit-mode.")
    elseif mode == "both" then
        logger(3, "----->>set to both-limit-mode.")
    else
        logger(3, "----->>set to service-limit-mode.")
        mode = "service"
    end
    
    set_qos_auto_mode(mode)
    return { status = 0, data = "ok" }, true
end

-- 设置流量优先级序列
-- @param seq 优先级序列
-- @return 结果表, 是否需要应用规则
function command_handlers.set_seq(seq)
    local cursor = get_cursor()
    local current_seq = cursor:get("miqos", "param", "seq_prio")
    
    if current_seq ~= seq then
        cursor:set("miqos", "param", "seq_prio", seq)
        commit_and_save(cursor)
    end
    
    return { status = 0, data = "ok" }, true
end

-- 获取流量优先级序列
-- @return 结果表, 是否需要应用规则
function command_handlers.get_seq()
    local seq = cfg.flow.seq
    if seq == "" then
        seq = cfg.flow.dft
    end
    
    return {
        status = 0,
        data = { seq_prio = seq }
    }, false
end

-- 设置主机抑制模式
-- @param mode 模式 (on/off)
-- @return 结果表, 是否需要应用规则
function command_handlers.supress_host(mode)
    if mode == "on" then
        cfg.supress_host.enabled = true
    elseif mode == "off" then
        cfg.supress_host.enabled = false
    else
        return { status = 1, data = "not supported supress command." }, false
    end
    
    cfg.supress_host.changed = true
    return { status = 0, data = "ok" }, true
end

-- 检查设备是否有限速配置 (内部函数)
-- @param mac MAC地址
-- @return 是否有限速配置
local function has_device_limit(mac)
    if not mac then
        return false
    end
    
    local mac_upper = string.upper(mac)
    
    if mac_upper == "00" then
        return true
    end
    
    if g_group_def and g_group_def[mac_upper] then
        local max_up = math.ceil(g_group_def[mac_upper].max_grp_uplink or 0)
        local max_down = math.ceil(g_group_def[mac_upper].max_grp_downlink or 0)
        if max_up > 8 or max_down > 8 then
            return true
        end
    end
    
    return false
end

-- 设备进入网络
-- @param mac MAC地址
-- @return 结果表, 是否有限速, 是否需要应用规则
function command_handlers.device_in(mac)
    local has_limit, need_apply = has_device_limit(mac)
    return { status = 0, data = "ok" }, has_limit, need_apply
end

-- 设备离开网络
-- @param mac MAC地址
-- @return 结果表, 是否有限速, 是否需要应用规则
function command_handlers.device_out(mac)
    local has_limit, need_apply = has_device_limit(mac)
    return { status = 0, data = "ok" }, has_limit, need_apply
end

-- 开启游戏模式
-- @return 结果表, 是否需要应用规则
function command_handlers.game_mode_on()
    cfg.wangzhe.changed = true
    cfg.wangzhe.modeon = true
    cfg.wangzhe.cleanflag = true
    return { status = 0, data = "ok" }, true
end

-- 关闭游戏模式
-- @return 结果表, 是否需要应用规则
function command_handlers.game_mode_off()
    cfg.wangzhe.modeon = false
    cfg.wangzhe.cleanother = true
    cfg.enabled.changed = true
    return { status = 0, data = "ok" }, true
end

-- 开启王者荣耀加速插件
-- @return 结果表, 是否需要应用规则
function command_handlers.wangzhe_plug_on()
    cfg.wangzhe.plugon = true
    return { status = 0, data = "ok" }, true
end

-- 关闭王者荣耀加速插件
-- @return 结果表, 是否需要应用规则
function command_handlers.wangzhe_plug_off()
    cfg.wangzhe.plugon = false
    return { status = 0, data = "ok" }, true
end

-- 添加游戏设备
-- @param ip 设备IP
-- @return 结果表, 是否需要应用规则
function command_handlers.game_dev_add(ip)
    cfg.wangzhe.iplist[ip] = { devip = ip }
    cfg.wangzhe.changed = true
    return { status = 0, data = "ok" }, true
end

-- 删除游戏设备
-- @param ip 设备IP
-- @return 结果表, 是否需要应用规则
function command_handlers.game_dev_del(ip)
    if cfg.wangzhe.iplist[ip] then
        cfg.wangzhe.iplist[ip].devip = nil
        cfg.wangzhe.iplist[ip] = nil
    end
    cfg.wangzhe.changed = true
    return { status = 0, data = "ok" }, true
end

-- 设置游戏设备带宽
-- @param upload 上传带宽
-- @param download 下载带宽
-- @return 结果表, 是否需要应用规则
function command_handlers.game_dev_band(upload, download)
    cfg.wangzhe.devbands.UP = tonumber(upload)
    cfg.wangzhe.devbands.DOWN = tonumber(download)
    cfg.wangzhe.bandchanged = true
    return { status = 0, data = "ok" }, true
end

-- 设置游戏模式总带宽
-- @param upload 上传带宽
-- @param download 下载带宽
-- @return 结果表, 是否需要应用规则
function command_handlers.game_mode_band(upload, download)
    cfg.wangzhe.bands.UP = tonumber(upload)
    cfg.wangzhe.bands.DOWN = tonumber(download)
    cfg.wangzhe.bandchanged = true
    return { status = 0, data = "ok" }, true
end

-- 显示游戏模式状态
-- @return 状态表, 带宽表
function command_handlers.show_game_state()
    local devices = {}
    
    for ip, dev in pairs(cfg.wangzhe.iplist) do
        devices[ip] = { IP = dev.devip }
    end
    
    local modeon = cfg.wangzhe.modeon and "True" or "False"
    local changed = cfg.wangzhe.changed and "True" or "False"
    local plugon = cfg.wangzhe.plugon and "True" or "False"
    
    local state = {
        modeon = modeon,
        changed = changed,
        devs = devices,
        plugon = plugon,
        total_bands = {
            upload = cfg.wangzhe.bands.UP,
            download = cfg.wangzhe.bands.DOWN
        },
        dev_bands = {
            upload = cfg.wangzhe.devbands.UP,
            download = cfg.wangzhe.devbands.DOWN
        }
    }
    
    return state, state.total_bands
end

-- 显示王者荣耀加速状态
-- @return 结果表, 是否需要应用规则
function command_handlers.show_wangzhe()
    local data = {}
    if cfg.wangzhe.plugon then
        data.switch = 1
    else
        data.switch = 0
    end
    
    return { status = 0, data = data }, false
end

-- 处理命令 (主入口)
-- @param cmd 命令名称
-- @param ... 命令参数
-- @return 命令执行结果
function process_cmd(cmd, ...)
    if not cmd or not command_handlers[cmd] then
        if cmd then
            logger(3, "cmd `" .. cmd .. "` is not defined.")
        else
            logger(3, "cmd is NULL. r u sure?")
        end
        return { status = 1, data = "cmd is not defined." }
    end
    
    return command_handlers[cmd](unpack(arg))
end
