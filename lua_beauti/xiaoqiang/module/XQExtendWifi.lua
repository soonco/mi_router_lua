--[[
  小米路由器扩展WiFi模块 (XQExtendWifi)
  功能: 管理WiFi扩展和中继功能
  
  主要功能:
  - WiFi扩展模式配置
  - 中继网络管理
  - 扩展器状态查询
]]

module("xiaoqiang.module.XQExtendWifi", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- 扩展模式常量
EXTEND_MODE_DISABLED = 0     -- 禁用
EXTEND_MODE_REPEATER = 1     -- 中继模式
EXTEND_MODE_BRIDGE = 2       -- 桥接模式
EXTEND_MODE_WISP = 3         -- WISP模式

--[[
  获取扩展WiFi信息
  @return 扩展WiFi配置信息
]]
function getExtendWifiInfo()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local result = {}
    
    -- 获取扩展模式
    local mode = cursor:get("xiaoqiang", "common", "EXTEND_MODE") or "0"
    result.mode = tonumber(mode)
    
    -- 获取上级WiFi SSID
    result.uplink_ssid = cursor:get("wireless", "apcli0", "ssid") or ""
    
    -- 获取上级WiFi加密方式
    result.uplink_encryption = cursor:get("wireless", "apcli0", "encryption") or ""
    
    -- 获取连接状态
    local connected = cursor:get("xiaoqiang", "common", "EXTEND_CONNECTED") or "0"
    result.connected = tonumber(connected)
    
    -- 获取上级路由器IP
    result.uplink_ip = cursor:get("xiaoqiang", "common", "EXTEND_UPLINK_IP") or ""
    
    return result
end

--[[
  扫描可用的WiFi网络
  @param band 频段 (2.4/5)
  @return WiFi网络列表
]]
function scanWifiNetworks(band)
    local luciUtil = require("luci.util")
    local result = {}
    
    -- 确定扫描接口
    local interface = "wl0"
    if band == "5" then
        interface = "wl1"
    end
    
    -- 执行扫描命令
    local scanCmd = string.format("iwlist %s scan 2>/dev/null", interface)
    local scanOutput = luciUtil.exec(scanCmd)
    
    if scanOutput and #scanOutput > 0 then
        -- 解析扫描结果
        local currentNetwork = nil
        
        for line in scanOutput:gmatch("[^\r\n]+") do
            -- 匹配SSID
            local ssid = line:match('ESSID:"([^"]*)"')
            if ssid then
                if currentNetwork then
                    table.insert(result, currentNetwork)
                end
                currentNetwork = {ssid = ssid}
            end
            
            -- 匹配信号强度
            local signal = line:match("Signal level[=:](-?%d+)")
            if signal and currentNetwork then
                currentNetwork.signal = tonumber(signal)
            end
            
            -- 匹配加密方式
            local encryption = line:match("Encryption key:(%w+)")
            if encryption and currentNetwork then
                currentNetwork.encrypted = (encryption == "on")
            end
            
            -- 匹配频道
            local channel = line:match("Channel:(%d+)")
            if channel and currentNetwork then
                currentNetwork.channel = tonumber(channel)
            end
            
            -- 匹配BSSID
            local bssid = line:match("Address: ([%x:]+)")
            if bssid and currentNetwork then
                currentNetwork.bssid = bssid
            end
        end
        
        -- 添加最后一个网络
        if currentNetwork then
            table.insert(result, currentNetwork)
        end
    end
    
    return result
end

--[[
  设置WiFi扩展模式
  @param mode 扩展模式
  @param ssid 上级WiFi SSID
  @param password 上级WiFi密码
  @param encryption 加密方式
  @param bssid 上级WiFi BSSID(可选)
  @return 0=成功, 1=参数错误, 2=连接失败
]]
function setExtendMode(mode, ssid, password, encryption, bssid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if mode < 0 or mode > 3 then
        return 1
    end
    
    if mode ~= EXTEND_MODE_DISABLED then
        if XQFunction.isStrNil(ssid) then
            return 1
        end
    end
    
    -- 禁用扩展模式
    if mode == EXTEND_MODE_DISABLED then
        cursor:set("xiaoqiang", "common", "EXTEND_MODE", "0")
        cursor:delete("wireless", "apcli0")
        cursor:commit("xiaoqiang")
        cursor:commit("wireless")
        
        -- 重启网络
        XQFunction.forkExec("/etc/init.d/network restart")
        return 0
    end
    
    -- 设置扩展模式
    cursor:set("xiaoqiang", "common", "EXTEND_MODE", tostring(mode))
    
    -- 配置apcli接口
    cursor:set("wireless", "apcli0", "wifi-iface")
    cursor:set("wireless", "apcli0", "device", "mt7612")
    cursor:set("wireless", "apcli0", "mode", "sta")
    cursor:set("wireless", "apcli0", "network", "lan")
    cursor:set("wireless", "apcli0", "ssid", ssid)
    
    if not XQFunction.isStrNil(password) then
        cursor:set("wireless", "apcli0", "key", password)
    end
    
    if not XQFunction.isStrNil(encryption) then
        cursor:set("wireless", "apcli0", "encryption", encryption)
    else
        cursor:set("wireless", "apcli0", "encryption", "psk2")
    end
    
    if not XQFunction.isStrNil(bssid) then
        cursor:set("wireless", "apcli0", "bssid", bssid)
    end
    
    cursor:commit("xiaoqiang")
    cursor:commit("wireless")
    
    -- 重启网络
    XQFunction.forkExec("/etc/init.d/network restart")
    
    return 0
end

--[[
  获取扩展器连接状态
  @return 连接状态信息
]]
function getConnectionStatus()
    local luciUtil = require("luci.util")
    local result = {}
    
    -- 检查apcli接口状态
    local statusCmd = "iwconfig apcli0 2>/dev/null"
    local statusOutput = luciUtil.exec(statusCmd)
    
    if statusOutput and #statusOutput > 0 then
        -- 检查是否已连接
        if statusOutput:match("Access Point: ([%x:]+)") then
            result.connected = 1
            result.ap_mac = statusOutput:match("Access Point: ([%x:]+)")
        else
            result.connected = 0
        end
        
        -- 获取信号强度
        local signal = statusOutput:match("Signal level[=:](-?%d+)")
        if signal then
            result.signal = tonumber(signal)
        end
        
        -- 获取连接速率
        local rate = statusOutput:match("Bit Rate[=:](%d+)")
        if rate then
            result.rate = tonumber(rate)
        end
    else
        result.connected = 0
    end
    
    return result
end

--[[
  断开扩展WiFi连接
  @return 0=成功
]]
function disconnectExtendWifi()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 禁用apcli接口
    cursor:set("wireless", "apcli0", "disabled", "1")
    cursor:commit("wireless")
    
    -- 重启无线
    XQFunction.forkExec("wifi reload")
    
    return 0
end

--[[
  重新连接扩展WiFi
  @return 0=成功
]]
function reconnectExtendWifi()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 启用apcli接口
    cursor:set("wireless", "apcli0", "disabled", "0")
    cursor:commit("wireless")
    
    -- 重启无线
    XQFunction.forkExec("wifi reload")
    
    return 0
end

--[[
  获取扩展器列表(Mesh网络中的子节点)
  @return 扩展器列表
]]
function getExtenderList()
    local result = {}
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取Mesh子节点列表
    local meshNodes = XQDeviceUtil.getMeshNodeList()
    
    if meshNodes and type(meshNodes) == "table" then
        for _, node in ipairs(meshNodes) do
            local extender = {}
            extender.mac = node.mac or ""
            extender.ip = node.ip or ""
            extender.name = node.name or ""
            extender.model = node.model or ""
            extender.online = node.online or 0
            extender.signal = node.signal or 0
            table.insert(result, extender)
        end
    end
    
    return result
end
