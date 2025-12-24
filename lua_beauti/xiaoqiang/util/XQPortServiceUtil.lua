--[[
  XQPortServiceUtil 端口服务工具模块
  
  功能说明：
  - 路由器物理端口服务管理
  - WAN/LAN端口模式切换
  - IPTV端口配置
  - 链路聚合(LAG)配置
  - 多WAN策略配置
  - 游戏端口配置
  - WAN VLAN标签配置
  
  端口服务类型：
  - wan: WAN口服务
  - lan: LAN口服务
  - iptv: IPTV服务
  - lag: 链路聚合服务
  - game: 游戏网口服务
  - multiwan: 多WAN服务
  
  WAN模式：
  - WAN_MODE_FIXED(1): 固定WAN口
  - WAN_MODE_WANDT(2): 自动检测WAN口
  - WAN_MODE_LAN(3): LAN口模式（无WAN）
]]

module("xiaoqiang.util.XQPortServiceUtil", package.seeall)

local luciUtil = require("luci.util")
local uci = require("luci.model.uci")
local uciCursor = uci.cursor()
local XQLog = require("xiaoqiang.XQLog")
local XQFunction = require("xiaoqiang.common.XQFunction")

local PORT_MAP_CONFIG = "port_map"
local PORT_SERVICE_CONFIG = "port_service"

PS_WAN_SERVICE_NAME_MAP = {}
PS_WAN_SERVICE_NAME_MAP.WAN1 = "wan"
PS_WAN_SERVICE_NAME_MAP.WAN2 = "wan_2"

-- ==================== 端口映射查询 ====================

-- 获取端口映射信息
-- @return table 端口映射表 {index => {port, index, speed, service, label}}
function psGetMap()
    local portMap = {}
    
    local serviceNameMap = {}
    serviceNameMap.wan = "WAN"
    serviceNameMap.wan_2 = "WAN2"
    serviceNameMap.lan = "LAN"
    serviceNameMap.lag = "聚合口"
    serviceNameMap.iptv = "IPTV"
    serviceNameMap.game = "游戏网口"
    
    uciCursor:foreach(PORT_MAP_CONFIG, "port", function(section)
        local portInfo = {}
        
        if section.type == "cpe" then
            return
        end
        
        portInfo.port = section[".name"]
        portInfo.index = portInfo.port
        portInfo.speed = section.speed
        portInfo.service = section.service
        portInfo.label = section.label
        
        if not XQFunction.isStrNil(portInfo.service) then
            portInfo.service = serviceNameMap[portInfo.service]
        end
        
        portMap[tonumber(portInfo.index)] = portInfo
    end)
    
    return portMap
end

-- 获取端口映射描述
-- @return string 描述信息
function psGetMapDesc()
    local desc = uciCursor:get(PORT_MAP_CONFIG, "settings", "description")
    if desc then
        return desc
    else
        return ""
    end
end

-- 重建端口映射（占位函数）
-- @return boolean 始终返回true
function psRebuildMap()
    return true
end

-- 重新加载端口服务
-- @return boolean 是否成功
function psReload()
    XQFunction.forkExec("/usr/sbin/port_service restart")
    return true
end

-- 重启端口服务
-- @param serviceName 服务名称（可选）
-- @return boolean 是否成功
function psRestart(serviceName)
    if XQFunction.isStrNil(serviceName) then
        serviceName = ""
    end
    
    XQFunction.forkExec("/usr/sbin/port_service restart " .. tostring(serviceName))
    return true
end

-- ==================== 冲突检测 ====================

-- 检查VID是否冲突
-- @param vid 待检查的VID
-- @param excludeVid 排除的VID（当前服务的VID）
-- @return boolean 是否冲突
function psIsVidConflict(vid, excludeVid)
    local serviceVids = uciCursor:get(PORT_SERVICE_CONFIG, "settings", "service_vids")
    
    if not serviceVids then
        return false
    end
    
    for _, vidStr in ipairs(serviceVids) do
        local currentVid = tonumber(vidStr) or 0
        if currentVid ~= excludeVid and currentVid == vid then
            return true
        end
    end
    
    return false
end

-- 检查端口是否冲突
-- @param ports 待检查的端口字符串
-- @param serviceName 当前服务名称
-- @return boolean 是否冲突
function psIsPortConflict(ports, serviceName)
    local json = require("json")
    local portUsage = {}
    local portIndex = nil
    
    local allPorts = uciCursor:get(PORT_SERVICE_CONFIG, "settings", "ports") or ""
    
    local usedPorts = ""
    
    for i = 1, string.len(allPorts) do
        portIndex = tonumber(string.sub(allPorts, i, i))
        if portIndex ~= nil then
            portUsage[portIndex + 1] = 0
        end
    end
    
    uciCursor:foreach(PORT_SERVICE_CONFIG, "service", function(section)
        if serviceName == section[".name"] then
            return
        end
        
        if serviceName == "wan" or serviceName == "wan_2" then
            if section[".name"] == "wan" or section[".name"] == "wan_2" then
                return
            end
        end
        
        local sectionPorts = nil
        if section.enable == "1" then
            sectionPorts = section.ports
        end
        
        if not XQFunction.isStrNil(sectionPorts) then
            usedPorts = usedPorts .. string.gsub(sectionPorts, "%s+", "")
        end
    end)
    
    for i = 1, string.len(usedPorts) do
        portIndex = tonumber(string.sub(usedPorts, i, i))
        if portIndex ~= nil then
            portUsage[portIndex + 1] = 1
        end
    end
    
    for i = 1, string.len(ports) do
        portIndex = tonumber(string.sub(ports, i, i))
        if portIndex ~= nil then
            if portUsage[portIndex + 1] ~= 0 then
                XQLog.log(5, "check fail: " .. json.encode(portUsage))
                return true
            end
            portUsage[portIndex + 1] = 1
        end
    end
    
    return false
end

-- ==================== WAN链路模式 ====================

-- 设置WAN链路模式
-- @param serviceName 服务名称
-- @param linkMode 链路模式
-- @return boolean 是否成功
function psSetWanLinkMode(serviceName, linkMode)
    local physicalPort = ""
    local currentEnable = ""
    
    if serviceName == nil or linkMode == nil then
        return false
    end
    
    local wandtEnabled = psWandtEnable()
    if wandtEnabled == 1 then
        return false
    end
    
    currentEnable = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "enable")
    
    if currentEnable == nil or tostring(currentEnable) ~= "1" then
        return false
    end
    
    physicalPort = luciUtil.exec("port_map port service " .. serviceName)
    
    if physicalPort == nil then
        return false
    else
        uciCursor:set(PORT_SERVICE_CONFIG, serviceName, "link_mode", linkMode)
        uciCursor:commit(PORT_SERVICE_CONFIG)
        
        os.execute("/sbin/phyhelper mode set " .. tostring(physicalPort) .. " " .. tostring(linkMode) .. " &")
        return true
    end
end

-- 重新链接端口
-- @param serviceName 服务名称
-- @return boolean 是否成功
function psPortReLink(serviceName)
    if serviceName == nil then
        return false
    end
    
    os.execute("/sbin/phyhelper restart " .. tostring(serviceName) .. " > /dev/console")
    return true
end

-- 获取WAN链路模式
-- @param serviceName 服务名称
-- @return number 链路模式（0=自动）
function psGetWanLinkMode(serviceName)
    local linkMode = nil
    local result = 0
    
    if serviceName ~= nil then
        linkMode = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "link_mode")
    end
    
    if linkMode ~= nil then
        result = tonumber(linkMode) or 0
    end
    
    return result
end

-- 获取WAN端口速度
-- @param serviceName 服务名称
-- @return string 端口速度（如"1G", "2.5G"）
function psGetWanSpeed(serviceName)
    local speed = nil
    local ports = nil
    local result = "0G"
    
    if serviceName ~= nil then
        ports = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "ports")
    end
    
    if ports ~= nil then
        speed = uciCursor:get(PORT_MAP_CONFIG, ports, "speed")
    end
    
    if speed ~= nil then
        result = tostring(speed)
    end
    
    return result
end

-- 获取端口标签
-- @param serviceName 服务名称
-- @return string 端口标签
function psGetLabel(serviceName)
    local label = nil
    local ports = nil
    local result = "No Port"
    
    if serviceName ~= nil then
        ports = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "ports")
    end
    
    if ports ~= nil then
        label = uciCursor:get(PORT_MAP_CONFIG, ports, "label")
    end
    
    if label ~= nil then
        result = tostring(label)
    end
    
    return result
end

-- 获取端口类型
-- @param serviceName 服务名称
-- @return string 端口类型
function psGetType(serviceName)
    local portType = nil
    local ports = nil
    local result = "No Port"
    
    if serviceName ~= nil then
        ports = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "ports")
    end
    
    if ports ~= nil then
        portType = uciCursor:get(PORT_MAP_CONFIG, ports, "type")
    end
    
    if portType ~= nil then
        result = tostring(portType)
    end
    
    return result
end

-- ==================== 功能启用状态查询 ====================

-- 检查WAN自动检测是否启用
-- @return number 0=禁用, 1=启用
function psWandtEnable()
    local wandt = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "wandt")
    
    if wandt and tonumber(wandt) then
        return tonumber(wandt)
    end
    
    return 0
end

-- 检查多WAN是否启用
-- @return number 0=禁用, 1=启用
function psMultiwanEnable()
    local enable = uciCursor:get(PORT_SERVICE_CONFIG, "wan_2", "enable")
    
    if enable and tonumber(enable) then
        return tonumber(enable)
    end
    
    return 0
end

-- 检查IPTV桥接模式是否启用
-- @return number 0=禁用, 1=启用
function psIptvBridgeEnable()
    local iptvEnable = uciCursor:get(PORT_SERVICE_CONFIG, "iptv", "enable")
    local iptvVid = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "vid")
    
    if iptvEnable and tonumber(iptvEnable) == 1 then
        if iptvVid and tonumber(iptvVid) == 0 then
            return 1
        end
    end
    
    return 0
end

-- ==================== WAN自动检测配置 ====================

-- 获取WAN自动检测配置
-- @return table 配置信息 {enable, wan_port, index}
function wandtGetConfig()
    local config = {}
    
    local wandt = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "wandt")
    if wandt and tonumber(wandt) then
        config.enable = tonumber(wandt)
    else
        config.enable = 0
    end
    
    local wanPort = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "ports")
    if wanPort and tonumber(wanPort) then
        config.wan_port = tonumber(wanPort)
    else
        config.wan_port = -1
    end
    
    config.index = config.wan_port
    
    return config
end

-- 设置WAN自动检测配置
-- @param config 配置信息 {enable, wan_port}
-- @return boolean, number 是否成功, 错误码
function wandtSetConfig(config)
    if config == nil then
        return false, 0
    end
    
    local multiwanEnabled = psMultiwanEnable()
    if multiwanEnabled == 1 then
        if config.enable == 1 then
            return true, 0
        end
    end
    
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "wandt", config.enable)
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "ports", config.wan_port)
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("wan")
    
    return true, 0
end

-- 解析WAN自动检测配置请求
-- @param request HTTP请求对象
-- @return table|nil 配置信息或nil
function wandtAnalyConfig(request)
    local config = {}
    
    if request == nil then
        return nil
    end
    
    local enable = tonumber(request.formvalue("enable"))
    if enable == nil or enable < 0 or enable > 1 then
        return nil
    end
    config.enable = enable
    
    local wanPort = request.formvalue("wan_port")
    
    if enable == 0 then
        if not XQFunction.isStrNil(wanPort) then
            if psIsPortConflict(wanPort, "wan") then
                return nil
            end
        end
    else
        wanPort = ""
    end
    
    config.wan_port = wanPort
    
    return config
end

-- 检查WAN自动检测是否启用（指定服务）
-- @param serviceName 服务名称
-- @return boolean 是否启用
function wandtEnable(serviceName)
    if serviceName == nil then
        return false
    end
    
    local wandt = uciCursor:get(PORT_SERVICE_CONFIG, serviceName, "wandt")
    
    if wandt ~= nil and tonumber(wandt) == 1 then
        return true
    end
    
    return false
end

-- 强制重新检测WAN
function wanRedetect()
    os.execute(" /usr/sbin/port_service redetect force > /dev/console 2>&1; ")
end

-- ==================== 链路聚合(LAG)配置 ====================

-- 获取LAG配置
-- @return table 配置信息 {enable, ports, mode, status, info}
function lagGetConfig()
    local json = require("json")
    local config = {}
    local lagStatus = nil
    
    local ports = uciCursor:get(PORT_SERVICE_CONFIG, "lag", "ports") or ""
    config.ports = ports
    
    local enable = uciCursor:get(PORT_SERVICE_CONFIG, "lag", "enable")
    if enable and tonumber(enable) then
        config.enable = tonumber(enable)
    else
        config.enable = 0
    end
    
    local mode = uciCursor:get(PORT_SERVICE_CONFIG, "lag_attr", "mode")
    if mode and tonumber(mode) then
        config.mode = tonumber(mode)
    else
        config.mode = 0
    end
    
    lagStatus = json.decode(luciUtil.trim(luciUtil.exec("lag.sh status")) or "")
    
    if lagStatus ~= nil then
        config.status = lagStatus.code
        config.info = lagStatus.info
    end
    
    return config
end

-- 设置LAG配置
-- @param config 配置信息 {enable, ports, mode}
-- @return boolean, number 是否成功, 错误码
function lagSetConfig(config)
    if config == nil then
        return false, 0
    end
    
    uciCursor:set(PORT_SERVICE_CONFIG, "lag", "enable", config.enable)
    
    if config.enable == 1 then
        uciCursor:set(PORT_SERVICE_CONFIG, "lag", "ports", config.ports)
        uciCursor:set(PORT_SERVICE_CONFIG, "lag_attr", "mode", config.mode)
    end
    
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("lag")
    
    return true, 1
end

-- 解析LAG配置请求
-- @param request HTTP请求对象
-- @return table|nil 配置信息或nil
function lagAnalyConfig(request)
    local config = {}
    
    if request == nil then
        return nil
    end
    
    local enable = tonumber(request.formvalue("enable"))
    if enable == nil or enable < 0 or enable > 1 then
        return nil
    end
    config.enable = enable
    
    local mode = tonumber(request.formvalue("mode"))
    if mode == nil or mode < 0 then
        return nil
    end
    config.mode = mode
    
    local ports = request.formvalue("ports")
    
    if enable == 1 then
        if XQFunction.isStrNil(ports) or psIsPortConflict(ports, "lag") then
            return nil
        end
    else
        ports = ""
    end
    
    config.ports = ports
    
    return config
end

-- ==================== IPTV配置 ====================

-- 获取IPTV配置
-- @return table 配置信息 {enable, ports, profile, vid, priority, forbid_vid, permit_vid}
function iptvGetConfig()
    local config = {}
    
    local enable = uciCursor:get(PORT_SERVICE_CONFIG, "iptv", "enable")
    if enable and tonumber(enable) then
        config.enable = tonumber(enable)
    else
        config.enable = 0
    end
    
    local ports = uciCursor:get(PORT_SERVICE_CONFIG, "iptv", "ports") or ""
    config.ports = ports
    
    local profile = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "profile")
    if profile and tonumber(profile) then
        config.profile = tonumber(profile)
    else
        config.profile = 0
    end
    
    local vid = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "vid")
    if vid and tonumber(vid) then
        config.vid = tonumber(vid)
    else
        config.vid = -1
    end
    
    local priority = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "priority")
    if priority and tonumber(priority) then
        config.priority = tonumber(priority)
    else
        config.priority = -1
    end
    
    local forbidVids = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "forbid_vid")
    config.forbid_vid = ""
    
    if forbidVids then
        for _, vidStr in ipairs(forbidVids) do
            if vidStr then
                local vidNum = tonumber(vidStr)
                if vidNum ~= nil then
                    if config.forbid_vid ~= "" then
                        config.forbid_vid = config.forbid_vid .. ","
                    end
                    config.forbid_vid = config.forbid_vid .. vidStr
                end
            end
        end
    end
    
    local permitVid = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "permit_vid")
    config.permit_vid = permitVid
    
    return config
end

-- 获取IPTV允许的VID范围
-- @return string VID范围（如"1~4094"）
function psGetIPTVPermitVid()
    local permitVid = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "permit_vid")
    return permitVid or "1~4094"
end

-- 设置IPTV配置
-- @param config 配置信息 {enable, ports, profile, vid, priority}
-- @return boolean, number 是否成功, 错误码
function iptvSetConfig(config)
    if config == nil then
        return false, 0
    end
    
    uciCursor:set(PORT_SERVICE_CONFIG, "iptv", "ports", config.ports)
    uciCursor:set(PORT_SERVICE_CONFIG, "iptv", "enable", config.enable)
    uciCursor:set(PORT_SERVICE_CONFIG, "iptv_attr", "profile", config.profile)
    uciCursor:set(PORT_SERVICE_CONFIG, "iptv_attr", "vid", config.vid)
    uciCursor:set(PORT_SERVICE_CONFIG, "iptv_attr", "priority", config.priority)
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("iptv")
    
    return true, 5
end

-- 解析IPTV配置请求
-- @param request HTTP请求对象
-- @return table|nil, number|nil 配置信息或nil, 错误码
function iptvAnalyConfig(request)
    local currentConfig = iptvGetConfig()
    
    if request == nil then
        return nil
    end
    
    local enable = tonumber(request.formvalue("enable"))
    if enable == nil or enable < 0 or enable > 1 then
        return nil
    end
    currentConfig.enable = enable
    
    if enable == 0 then
        return currentConfig
    end
    
    local profile = tonumber(request.formvalue("profile"))
    if profile == nil or profile < 0 then
        return nil
    end
    currentConfig.profile = profile
    
    local vid = tonumber(request.formvalue("vid"))
    if vid == nil or vid < -1 or vid > 4094 then
        return nil
    end
    
    local iptvBridgeEnabled = psIptvBridgeEnable()
    if enable == 1 and vid == 0 and iptvBridgeEnabled == 1 then
        return nil, 1611
    end
    
    local currentVid = nil
    local iptvEnabled = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, "iptv", "enable"))
    if iptvEnabled == 1 then
        currentVid = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "vid"))
    end
    
    if enable == 1 then
        if psIsVidConflict(vid, currentVid) then
            return nil, 1610
        end
    end
    
    local forbidVids = uciCursor:get(PORT_SERVICE_CONFIG, "iptv_attr", "forbid_vid")
    if forbidVids then
        for _, forbidVid in ipairs(forbidVids) do
            if vid == tonumber(forbidVid) then
                return nil, 1805
            end
        end
    end
    
    currentConfig.vid = vid
    
    local priority = tonumber(request.formvalue("priority"))
    if priority == nil or priority < -1 or priority > 7 then
        return nil
    end
    currentConfig.priority = priority
    
    if enable == 1 then
        local ports = request.formvalue("ports")
        if XQFunction.isStrNil(ports) or psIsPortConflict(ports, "iptv") then
            return nil
        end
        currentConfig.ports = ports
    end
    
    return currentConfig
end

-- ==================== WAN端口配置 ====================

WAN_MODE_FIXED = 1
WAN_MODE_WANDT = 2
WAN_MODE_LAN = 3

-- 获取WAN配置
-- @return table 配置信息 {wan_port, wan_label, mode}
function wanGetConfig()
    local config = {}
    local wanLabel = "-1"
    
    local wanPort = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "ports")
    if wanPort and tonumber(wanPort) then
        config.wan_port = tonumber(wanPort)
    else
        config.wan_port = -1
    end
    
    local wanEnable = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "enable")
    local wandt = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "wandt")
    
    if wanPort then
        wanLabel = uciCursor:get(PORT_MAP_CONFIG, wanPort, "label")
    end
    config.wan_label = wanLabel
    
    if wanEnable and tonumber(wanEnable) == 1 then
        if wandt and tonumber(wandt) == 1 then
            config.mode = WAN_MODE_WANDT
        else
            config.mode = WAN_MODE_FIXED
        end
    else
        config.mode = WAN_MODE_LAN
    end
    
    return config
end

-- 设置WAN配置
-- @param config 配置信息 {enable, wandt, ports, mode}
-- @return boolean, number 是否成功, 错误码
function wanSetConfig(config)
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    if config == nil then
        return false, 0
    end
    
    local wan2Enable = uciCursor:get(PORT_SERVICE_CONFIG, "wan_2", "enable")
    if wan2Enable == nil then
        wan2Enable = 0
    else
        wan2Enable = tonumber(wan2Enable)
    end
    
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "enable", config.enable)
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "wandt", config.wandt)
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "ports", config.ports)
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "mode", config.mode)
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("wan")
    
    if features.system and features.system.multiwan == "1" then
        local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
        
        if config.enable == 0 then
            if features.system.cpe and features.system.cpe == "1" then
                if features.system.dt_spec == "1" then
                    XQMultiWanPolicy.setEnable("0")
                else
                    XQMultiWanPolicy.setPolicy(4)
                end
            else
                XQMultiWanPolicy.setEnable("0")
            end
        elseif wan2Enable == 0 then
            XQMultiWanPolicy.setEnable("0")
        else
            XQMultiWanPolicy.setEnable("1")
        end
    end
    
    if features.system and features.system.tr069 == "1" then
        if config.mode == WAN_MODE_LAN then
            local XQCwmpUtil = require("xiaoqiang.util.XQCwmpUtil")
            XQCwmpUtil.modifyWan("br-lan")
        end
    end
    
    return true, 0
end

-- 解析WAN配置请求
-- @param request HTTP请求对象
-- @return table|nil 配置信息或nil
function wanAnalyConfig(request)
    if request == nil then
        return nil
    end
    
    local mode = tonumber(request.formvalue("mode"))
    local wanPort = request.formvalue("wan_port")
    
    if mode == nil then
        return nil
    end
    
    if mode == WAN_MODE_FIXED and wanPort == nil then
        return nil
    end
    
    local modeHandlers = {}
    
    modeHandlers[WAN_MODE_FIXED] = function(port)
        if psIsPortConflict(port, "wan") then
            return nil
        end
        return {
            enable = 1,
            wandt = 0,
            ports = port,
            mode = WAN_MODE_FIXED
        }
    end
    
    modeHandlers[WAN_MODE_WANDT] = function()
        return {
            enable = 1,
            wandt = 1,
            ports = "",
            mode = WAN_MODE_WANDT
        }
    end
    
    modeHandlers[WAN_MODE_LAN] = function()
        return {
            enable = 0,
            wandt = 0,
            ports = "",
            mode = WAN_MODE_LAN
        }
    end
    
    local handler = modeHandlers[mode]
    if handler then
        return handler(wanPort)
    else
        return nil
    end
end

-- ==================== 多WAN配置 ====================

-- 获取多WAN配置
-- @return table 配置信息 {enable, port_map, policy}
local function multiwanGetConfig()
    local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
    
    local bandwidth1, bandwidth2 = XQMultiWanPolicy.getBandwidth()
    local weight1, weight2 = XQMultiWanPolicy.getWeight()
    
    local config = {}
    config.port_map = {{}, {}}
    config.policy = {}
    
    config.enable = XQMultiWanPolicy.getStatus()
    
    config.port_map[1].name = "WAN1"
    config.port_map[1].port = uciCursor:get(PORT_SERVICE_CONFIG, "wan", "ports") or ""
    
    config.port_map[2].name = "WAN2"
    config.port_map[2].port = uciCursor:get(PORT_SERVICE_CONFIG, "wan_2", "ports") or ""
    
    config.policy.mode = XQMultiWanPolicy.getPolicy()
    config.policy.currwan = XQMultiWanPolicy.getCurrentWan("ipv4") or ""
    config.policy.weight1 = weight1
    config.policy.weight2 = weight2
    config.policy.bandwidth_wan1 = bandwidth1
    config.policy.bandwidth_wan2 = bandwidth2
    
    XQLog.log(5, "multiwanGetConfig: ", config)
    
    return config
end

-- 设置多WAN配置
-- @param config 配置信息 {enable, port_map, policy}
-- @return boolean, number 是否成功, 错误码
local function multiwanSetConfig(config)
    if config == nil then
        return false, 0
    end
    
    local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
    
    local currentStatus = XQMultiWanPolicy.getStatus()
    local needRestart = false
    
    if config.enable ~= currentStatus then
        needRestart = true
        uciCursor:set(PORT_SERVICE_CONFIG, "wan_2", "enable", config.enable)
        
        if config.enable == 1 then
            uciCursor:set(PORT_SERVICE_CONFIG, "wan", "wandt", 0)
        else
            uciCursor:commit(PORT_SERVICE_CONFIG)
            psRestart()
            return true, 0
        end
    end
    
    if config.port_map then
        needRestart = true
        for _, portConfig in ipairs(config.port_map) do
            if portConfig.name and portConfig.port then
                local serviceName = PS_WAN_SERVICE_NAME_MAP[portConfig.name]
                if serviceName then
                    uciCursor:set(PORT_SERVICE_CONFIG, serviceName, "ports", portConfig.port)
                end
            end
        end
    end
    
    if config.policy then
        XQMultiWanPolicy.setPolicy(config.policy.mode)
        if config.policy.mode == 0 then
            XQMultiWanPolicy.setBandwidth(config.policy.bandwidth_wan1, config.policy.bandwidth_wan2, true)
        end
    end
    
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    if needRestart then
        psRestart()
    end
    
    return true, 0
end

-- 解析多WAN配置请求
-- @param request HTTP请求对象
-- @return table|nil 配置信息或nil
local function multiwanAnalyConfig(request)
    if request == nil then
        return nil
    end
    
    local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
    
    local config = {}
    local portMapTemp = {}
    local portMapList = {}
    local policy = {}
    
    config.enable = tonumber(request.formvalue("enable"))
    
    policy.mode = request.formvalue("policy%5Bmode%5D")
    policy.bandwidth_wan1 = request.formvalue("policy%5Bbandwidth_wan1%5D")
    policy.bandwidth_wan2 = request.formvalue("policy%5Bbandwidth_wan2%5D")
    
    if config.enable == nil then
        return nil
    end
    
    if config.enable == 1 then
        local i = 0
        while true do
            portMapTemp = {}
            portMapTemp.name = request.formvalue("port_map%5B" .. i .. "%5D%5Bname%5D")
            portMapTemp.port = request.formvalue("port_map%5B" .. i .. "%5D%5Bport%5D")
            
            if portMapTemp.name == nil then
                break
            end
            
            local serviceName = PS_WAN_SERVICE_NAME_MAP[portMapTemp.name]
            if serviceName then
                if XQFunction.isStrNil(portMapTemp.port) or psIsPortConflict(portMapTemp.port, serviceName) then
                    return nil
                end
            else
                return nil
            end
            
            table.insert(portMapList, portMapTemp)
            i = i + 1
        end
        
        if policy.mode then
            if XQMultiWanPolicy.isValidPolicyCode(policy.mode) then
                policy.mode = tonumber(policy.mode)
                if policy.mode == 0 then
                    if policy.bandwidth_wan1 == nil or policy.bandwidth_wan2 == nil then
                        return nil
                    end
                end
            else
                return nil
            end
        end
        
        config.port_map = (#portMapList > 0) and portMapList or nil
        config.policy = policy.mode and policy or nil
    end
    
    XQLog.log(5, "multiwanAnalyConfig: ", config)
    
    return config
end

-- ==================== 游戏端口配置 ====================

-- 获取游戏端口配置
-- @return table 配置信息 {enable, ports}
local function gameGetConfig()
    local config = {}
    
    local enable = uciCursor:get(PORT_SERVICE_CONFIG, "game", "enable")
    if enable and tonumber(enable) then
        config.enable = tonumber(enable)
    else
        config.enable = 0
    end
    
    local ports = uciCursor:get(PORT_SERVICE_CONFIG, "game", "ports")
    config.ports = ports or "-1"
    
    return config
end

-- 设置游戏端口配置
-- @param config 配置信息 {enable, ports}
-- @return boolean, number 是否成功, 错误码
local function gameSetConfig(config)
    if config == nil then
        return false, 0
    end
    
    uciCursor:set(PORT_SERVICE_CONFIG, "game", "enable", config.enable)
    
    if config.enable == 1 then
        uciCursor:set(PORT_SERVICE_CONFIG, "game", "ports", config.ports)
    end
    
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("game")
    
    return true, 0
end

-- 解析游戏端口配置请求
-- @param request HTTP请求对象
-- @return table|nil 配置信息或nil
local function gameAnalyConfig(request)
    if request == nil then
        return nil
    end
    
    local enable = tonumber(request.formvalue("enable"))
    local ports = request.formvalue("ports")
    
    if enable == nil then
        return nil
    end
    
    if enable == 1 then
        if XQFunction.isStrNil(ports) or psIsPortConflict(ports, "game") then
            return nil
        end
    end
    
    local config = {}
    config.enable = enable
    config.ports = ports or ""
    
    return config
end

-- ==================== WAN VLAN标签配置 ====================

-- 获取WAN VLAN标签配置
-- @param request HTTP请求对象（包含interface参数）
-- @return table|nil 配置信息 {interface, profile, vid, priority, forbid_vid, permit_vid}
function wantagGetConfig(request)
    local config = {}
    local attrSection = "tag_attr"
    
    if request == nil then
        return nil
    end
    
    local interface = request.formvalue("interface")
    if interface == nil then
        return nil
    end
    config.interface = interface
    
    attrSection = interface .. attrSection
    
    local profile = uciCursor:get(PORT_SERVICE_CONFIG, attrSection, "profile")
    if profile and tonumber(profile) then
        config.profile = tonumber(profile)
    else
        config.profile = 0
    end
    
    local vid = uciCursor:get(PORT_SERVICE_CONFIG, attrSection, "vid")
    if vid and tonumber(vid) then
        config.vid = tonumber(vid)
    else
        config.vid = -1
    end
    
    local priority = uciCursor:get(PORT_SERVICE_CONFIG, attrSection, "priority")
    if priority and tonumber(priority) then
        config.priority = tonumber(priority)
    else
        config.priority = -1
    end
    
    local forbidVids = uciCursor:get(PORT_SERVICE_CONFIG, attrSection, "forbid_vid")
    config.forbid_vid = ""
    
    if forbidVids then
        for _, vidStr in ipairs(forbidVids) do
            if vidStr then
                local vidNum = tonumber(vidStr)
                if vidNum ~= nil then
                    if config.forbid_vid ~= "" then
                        config.forbid_vid = config.forbid_vid .. ","
                    end
                    config.forbid_vid = config.forbid_vid .. vidStr
                end
            end
        end
    end
    
    local permitVid = uciCursor:get(PORT_SERVICE_CONFIG, attrSection, "permit_vid")
    config.permit_vid = permitVid
    
    return config
end

-- 获取WAN标签允许的VID范围
-- @param interface 接口名称
-- @return string VID范围（如"1~4094"）
function psGetWantagPermitVid(interface)
    if interface then
        local permitVid = uciCursor:get(PORT_SERVICE_CONFIG, interface .. "tag_attr", "permit_vid")
        return permitVid or "1~4094"
    else
        return "1~4094"
    end
end

-- 设置WAN VLAN标签配置
-- @param config 配置信息 {interface, enable, profile, vid, priority}
-- @return boolean 是否成功
function wantagSetConfig(config)
    local attrSection = "tag_attr"
    
    if config == nil then
        return false, 0
    end
    
    attrSection = config.interface .. attrSection
    
    uciCursor:set(PORT_SERVICE_CONFIG, config.interface, "wantag", config.enable)
    uciCursor:set(PORT_SERVICE_CONFIG, attrSection, "profile", config.profile)
    uciCursor:set(PORT_SERVICE_CONFIG, attrSection, "vid", config.vid)
    uciCursor:set(PORT_SERVICE_CONFIG, attrSection, "priority", config.priority)
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart(config.interface)
    
    return true
end

-- 解析WAN VLAN标签配置请求
-- @param request HTTP请求对象
-- @return table|nil, number|nil 配置信息或nil, 错误码
function wantagAnalyConfig(request)
    local config = {}
    config.interface = "wan"
    config.enable = 0
    config.profile = 0
    config.vid = 0
    config.priority = 0
    
    if request == nil then
        return nil
    end
    
    local interface = request.formvalue("interface")
    if interface == nil then
        return nil
    end
    config.interface = interface
    
    local profile = tonumber(request.formvalue("profile"))
    if profile == nil or profile < 0 then
        return nil
    end
    config.profile = profile
    
    if config.profile ~= 0 then
        config.enable = 1
    end
    
    if config.enable == 0 then
        return config
    end
    
    local iptvBridgeEnabled = psIptvBridgeEnable()
    if iptvBridgeEnabled == 1 then
        return nil, 1611
    end
    
    local vid = tonumber(request.formvalue("vid"))
    if vid == nil or vid <= 0 or vid > 4094 then
        return nil
    end
    
    local currentVid = nil
    local wantagEnabled = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, interface, "wantag"))
    if wantagEnabled == 1 then
        currentVid = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, interface .. "tag_attr", "vid"))
    end
    
    if psIsVidConflict(vid, currentVid) then
        return nil, 1610
    end
    
    local forbidVids = uciCursor:get(PORT_SERVICE_CONFIG, interface .. "tag_attr", "forbid_vid")
    if forbidVids then
        for _, forbidVid in ipairs(forbidVids) do
            if vid == tonumber(forbidVid) then
                return nil, 1805
            end
        end
    end
    
    config.vid = vid
    
    local priority = tonumber(request.formvalue("priority"))
    if priority == nil or priority < 0 or priority > 7 then
        return nil
    end
    config.priority = priority
    
    return config
end

-- 解析Internet VLAN配置请求
-- @param request HTTP请求对象
-- @return table|nil, number|nil 配置信息或nil, 错误码
function wantagAnalyInternetVlan(request)
    local config = {}
    config.interface = "wan"
    config.enable = 0
    config.profile = 0
    config.vid = 0
    config.priority = 0
    
    if request == nil then
        return nil
    end
    
    local opt = request.formvalue("opt")
    
    if opt == "init" or opt == "set" then
        local profile = tonumber(request.formvalue("internet_profile"))
        if profile == nil or profile < 0 then
            return nil
        end
        config.profile = profile
        
        if config.profile ~= 0 then
            config.enable = 1
        end
        
        if config.enable == 0 then
            return config
        end
        
        local iptvBridgeEnabled = psIptvBridgeEnable()
        if iptvBridgeEnabled == 1 then
            return nil, 1611
        end
        
        local vid = tonumber(request.formvalue("internet_vid"))
        if vid == nil or vid <= 0 or vid > 4094 then
            return nil
        end
        
        local currentVid = nil
        local wantagEnabled = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, config.interface, "wantag"))
        if wantagEnabled == 1 then
            currentVid = tonumber(uciCursor:get(PORT_SERVICE_CONFIG, config.interface .. "tag_attr", "vid"))
        end
        
        if psIsVidConflict(vid, currentVid) then
            return nil, 1610
        end
        
        local forbidVids = uciCursor:get(PORT_SERVICE_CONFIG, config.interface .. "tag_attr", "forbid_vid")
        if forbidVids then
            for _, forbidVid in ipairs(forbidVids) do
                if vid == tonumber(forbidVid) then
                    return nil, 1805
                end
            end
        end
        
        config.vid = vid
        
        local priority = tonumber(request.formvalue("internet_priority"))
        if priority == nil or priority < 0 or priority > 7 then
            return nil
        end
        config.priority = priority
        
    elseif opt == "clean" then
        config.enable = 0
        config.profile = 0
        config.vid = -1
        config.priority = -1
    else
        return nil
    end
    
    return config
end

-- ==================== 端口服务统一接口 ====================

local wandtService = {}
wandtService.getConfig = wandtGetConfig
wandtService.setConfig = wandtSetConfig
wandtService.analyConfig = wandtAnalyConfig

local lagService = {}
lagService.getConfig = lagGetConfig
lagService.setConfig = lagSetConfig
lagService.analyConfig = lagAnalyConfig

local iptvService = {}
iptvService.getConfig = iptvGetConfig
iptvService.setConfig = iptvSetConfig
iptvService.analyConfig = iptvAnalyConfig

local wanService = {}
wanService.getConfig = wanGetConfig
wanService.setConfig = wanSetConfig
wanService.analyConfig = wanAnalyConfig

local multiwanService = {}
multiwanService.getConfig = multiwanGetConfig
multiwanService.setConfig = multiwanSetConfig
multiwanService.analyConfig = multiwanAnalyConfig

local gameService = {}
gameService.getConfig = gameGetConfig
gameService.setConfig = gameSetConfig
gameService.analyConfig = gameAnalyConfig

ps = {}
ps.wandt = wandtService
ps.lag = lagService
ps.iptv = iptvService
ps.wan = wanService
ps.multiwan = multiwanService
ps.game = gameService
