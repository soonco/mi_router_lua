--[[
  小米路由器WiFi配置同步模块 (XQExWifiConfSync)
  功能: 管理扩展器与主路由器之间的WiFi配置同步
  
  主要功能:
  - WiFi配置同步
  - 扩展器配置管理
  - Mesh网络配置同步
]]

module("xiaoqiang.module.XQExWifiConfSync", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- 同步状态常量
SYNC_STATUS_IDLE = 0         -- 空闲
SYNC_STATUS_SYNCING = 1      -- 同步中
SYNC_STATUS_SUCCESS = 2      -- 同步成功
SYNC_STATUS_FAILED = 3       -- 同步失败

--[[
  获取WiFi配置同步状态
  @return 同步状态信息
]]
function getSyncStatus()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local result = {}
    
    -- 获取同步状态
    local status = cursor:get("xiaoqiang", "common", "WIFI_SYNC_STATUS") or "0"
    result.status = tonumber(status)
    
    -- 获取最后同步时间
    result.last_sync_time = cursor:get("xiaoqiang", "common", "WIFI_LAST_SYNC_TIME") or ""
    
    -- 获取同步错误信息
    result.error_message = cursor:get("xiaoqiang", "common", "WIFI_SYNC_ERROR") or ""
    
    return result
end

--[[
  获取当前WiFi配置
  用于同步到扩展器
  @return WiFi配置信息
]]
function getWifiConfig()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    
    -- 获取2.4G WiFi配置
    result.wifi_24g = {}
    result.wifi_24g.ssid = cursor:get("wireless", "default_radio0", "ssid") or ""
    result.wifi_24g.encryption = cursor:get("wireless", "default_radio0", "encryption") or ""
    result.wifi_24g.key = cursor:get("wireless", "default_radio0", "key") or ""
    result.wifi_24g.hidden = cursor:get("wireless", "default_radio0", "hidden") or "0"
    result.wifi_24g.disabled = cursor:get("wireless", "default_radio0", "disabled") or "0"
    
    -- 获取5G WiFi配置
    result.wifi_5g = {}
    result.wifi_5g.ssid = cursor:get("wireless", "default_radio1", "ssid") or ""
    result.wifi_5g.encryption = cursor:get("wireless", "default_radio1", "encryption") or ""
    result.wifi_5g.key = cursor:get("wireless", "default_radio1", "key") or ""
    result.wifi_5g.hidden = cursor:get("wireless", "default_radio1", "hidden") or "0"
    result.wifi_5g.disabled = cursor:get("wireless", "default_radio1", "disabled") or "0"
    
    -- 获取访客WiFi配置
    result.guest_wifi = {}
    result.guest_wifi.ssid = cursor:get("wireless", "guest", "ssid") or ""
    result.guest_wifi.encryption = cursor:get("wireless", "guest", "encryption") or ""
    result.guest_wifi.key = cursor:get("wireless", "guest", "key") or ""
    result.guest_wifi.disabled = cursor:get("wireless", "guest", "disabled") or "1"
    
    return result
end

--[[
  同步WiFi配置到扩展器
  @param extenderIp 扩展器IP地址
  @param config WiFi配置(可选，不提供则使用当前配置)
  @return 0=成功, 1=参数错误, 2=连接失败, 3=同步失败
]]
function syncToExtender(extenderIp, config)
    local luciUtil = require("luci.util")
    local json = require("luci.jsonc")
    
    -- 参数校验
    if XQFunction.isStrNil(extenderIp) then
        return 1
    end
    
    -- 获取配置
    local wifiConfig = config or getWifiConfig()
    
    -- 设置同步状态为同步中
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    cursor:set("xiaoqiang", "common", "WIFI_SYNC_STATUS", tostring(SYNC_STATUS_SYNCING))
    cursor:commit("xiaoqiang")
    
    -- 构建同步请求
    local configJson = json.stringify(wifiConfig)
    local syncUrl = string.format("http://%s/cgi-bin/luci/api/xqsystem/wifi_sync", extenderIp)
    
    -- 发送同步请求
    local curlCmd = string.format(
        "curl -s -X POST -H 'Content-Type: application/json' -d '%s' '%s' 2>/dev/null",
        configJson,
        syncUrl
    )
    
    local response = luciUtil.exec(curlCmd)
    
    -- 解析响应
    if response and #response > 0 then
        local result = json.parse(response)
        if result and result.code == 0 then
            -- 同步成功
            cursor:set("xiaoqiang", "common", "WIFI_SYNC_STATUS", tostring(SYNC_STATUS_SUCCESS))
            cursor:set("xiaoqiang", "common", "WIFI_LAST_SYNC_TIME", tostring(os.time()))
            cursor:set("xiaoqiang", "common", "WIFI_SYNC_ERROR", "")
            cursor:commit("xiaoqiang")
            return 0
        else
            -- 同步失败
            cursor:set("xiaoqiang", "common", "WIFI_SYNC_STATUS", tostring(SYNC_STATUS_FAILED))
            cursor:set("xiaoqiang", "common", "WIFI_SYNC_ERROR", result and result.msg or "Unknown error")
            cursor:commit("xiaoqiang")
            return 3
        end
    else
        -- 连接失败
        cursor:set("xiaoqiang", "common", "WIFI_SYNC_STATUS", tostring(SYNC_STATUS_FAILED))
        cursor:set("xiaoqiang", "common", "WIFI_SYNC_ERROR", "Connection failed")
        cursor:commit("xiaoqiang")
        return 2
    end
end

--[[
  同步WiFi配置到所有扩展器
  @return 同步结果列表
]]
function syncToAllExtenders()
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    local results = {}
    
    -- 获取扩展器列表
    local extenders = XQExtendWifi.getExtenderList()
    
    -- 获取当前WiFi配置
    local wifiConfig = getWifiConfig()
    
    -- 遍历同步
    for _, extender in ipairs(extenders) do
        if extender.online == 1 and not XQFunction.isStrNil(extender.ip) then
            local result = {
                ip = extender.ip,
                name = extender.name,
                code = syncToExtender(extender.ip, wifiConfig)
            }
            table.insert(results, result)
        end
    end
    
    return results
end

--[[
  接收并应用WiFi配置(扩展器端)
  @param config WiFi配置
  @return 0=成功, 1=参数错误, 2=应用失败
]]
function applyWifiConfig(config)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if not config or type(config) ~= "table" then
        return 1
    end
    
    -- 应用2.4G WiFi配置
    if config.wifi_24g then
        local wifi24g = config.wifi_24g
        if wifi24g.ssid then
            cursor:set("wireless", "default_radio0", "ssid", wifi24g.ssid)
        end
        if wifi24g.encryption then
            cursor:set("wireless", "default_radio0", "encryption", wifi24g.encryption)
        end
        if wifi24g.key then
            cursor:set("wireless", "default_radio0", "key", wifi24g.key)
        end
        if wifi24g.hidden then
            cursor:set("wireless", "default_radio0", "hidden", wifi24g.hidden)
        end
    end
    
    -- 应用5G WiFi配置
    if config.wifi_5g then
        local wifi5g = config.wifi_5g
        if wifi5g.ssid then
            cursor:set("wireless", "default_radio1", "ssid", wifi5g.ssid)
        end
        if wifi5g.encryption then
            cursor:set("wireless", "default_radio1", "encryption", wifi5g.encryption)
        end
        if wifi5g.key then
            cursor:set("wireless", "default_radio1", "key", wifi5g.key)
        end
        if wifi5g.hidden then
            cursor:set("wireless", "default_radio1", "hidden", wifi5g.hidden)
        end
    end
    
    -- 应用访客WiFi配置
    if config.guest_wifi then
        local guest = config.guest_wifi
        if guest.ssid then
            cursor:set("wireless", "guest", "ssid", guest.ssid)
        end
        if guest.encryption then
            cursor:set("wireless", "guest", "encryption", guest.encryption)
        end
        if guest.key then
            cursor:set("wireless", "guest", "key", guest.key)
        end
        if guest.disabled then
            cursor:set("wireless", "guest", "disabled", guest.disabled)
        end
    end
    
    -- 提交配置
    cursor:commit("wireless")
    
    -- 重启无线
    XQFunction.forkExec("wifi reload")
    
    return 0
end

--[[
  检查扩展器是否在线
  @param extenderIp 扩展器IP地址
  @return true/false
]]
function isExtenderOnline(extenderIp)
    local luciUtil = require("luci.util")
    
    if XQFunction.isStrNil(extenderIp) then
        return false
    end
    
    -- ping检测
    local pingCmd = string.format("ping -c 1 -W 2 %s >/dev/null 2>&1 && echo 1 || echo 0", extenderIp)
    local result = luciUtil.exec(pingCmd)
    
    if result and result:match("1") then
        return true
    else
        return false
    end
end

--[[
  获取扩展器WiFi配置
  @param extenderIp 扩展器IP地址
  @return WiFi配置信息
]]
function getExtenderWifiConfig(extenderIp)
    local luciUtil = require("luci.util")
    local json = require("luci.jsonc")
    
    if XQFunction.isStrNil(extenderIp) then
        return nil
    end
    
    -- 请求扩展器配置
    local url = string.format("http://%s/cgi-bin/luci/api/xqsystem/wifi_config", extenderIp)
    local curlCmd = string.format("curl -s '%s' 2>/dev/null", url)
    
    local response = luciUtil.exec(curlCmd)
    
    if response and #response > 0 then
        local result = json.parse(response)
        if result and result.code == 0 then
            return result.data
        end
    end
    
    return nil
end
