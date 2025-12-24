--[[
WiFi分享模块 (XQWifiShare)
小米路由器WiFi分享和访客网络管理模块

功能说明:
- 获取WiFi分享信息
- 设置访客WiFi网络
- 管理访客网络定时关闭功能
- 与智能家居控制器集成

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.common.XQConfigs: 配置常量
- xiaoqiang.util.XQSysUtil: 系统工具
- xiaoqiang.util.XQWifiUtil: WiFi工具
- xiaoqiang.util.XQCryptoUtil: 加密工具
- luci.controller.api.xqsmarthome: 智能家居API
]]

module("xiaoqiang.module.XQWifiShare", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
local LuciUtil = require("luci.util")
local XQLog = require("xiaoqiang.XQLog")
local XQSmartHome = require("luci.controller.api.xqsmarthome")
local LuciHttp = require("luci.http")

local SMART_SCENE_ID = 30020
local GUEST_WIFI_SSID_PREFIX = "XIAOMI_ROUTER_GUEST"

function wifi_share_info(wifiIndex)
    local uci = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local result = {
        guest = 0,
        share = 0,
        need = 0,
        sns = {}
    }
    
    local guestWifiInfo = XQWifiUtil.getGuestWifi(wifiIndex)
    
    result.guest = tonumber(guestWifiInfo.status)
    
    local wifiData = {
        ssid = XQFunction.encode4HtmlValue(guestWifiInfo.ssid),
        encryption = guestWifiInfo.encryption,
        hidden = guestWifiInfo.hidden,
        password = XQFunction.encode4HtmlValue(guestWifiInfo.password),
        ssidHtmlEncode = 1
    }
    result.data = wifiData
    
    if result.guest == 0 then
        result.need = 1
    end
    
    return result
end

function wifi_share_info_web()
    local result = {
        need = 1
    }
    
    local info = wifi_share_info()
    result.need = info.need
    
    return result
end

function delete_share_time()
    local cjson = require("cjson")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local sceneData = {
        command = "scene_delete",
        id = SMART_SCENE_ID,
        name = "到时定时关闭访客网络目标"
    }
    
    local jsonStr = cjson.encode(sceneData)
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonStr)
    
    XQSmartHome.guest_tunnelSmartControllerRequest(encodedData)
end

function set_share_time(hours)
    local cjson = require("cjson")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local currentTime = os.time()
    local currentTimeMs = currentTime * 1000
    local durationMs = tonumber(hours) * 60 * 60 * 1000
    local triggerTimeMs = currentTimeMs + durationMs
    
    if triggerTimeMs < currentTimeMs then
        triggerTimeMs = triggerTimeMs + 86400000
    end
    
    local actionItem = {
        block = 1,
        delay = 0,
        extra = {
            duration = durationMs,
            total_length = 0
        },
        keyName = "关闭访客网络",
        name = "小米路由器",
        thirdParty = "xmrouter",
        type = "guest_wifi_down"
    }
    
    local launchConfig = {
        timer = {
            enabled = true,
            time = "00:00:00",
            utc_time = triggerTimeMs
        }
    }
    
    local sceneData = {
        action_list = {actionItem},
        command = "scene_setting",
        id = SMART_SCENE_ID,
        name = "关闭访客网络",
        launch = launchConfig
    }
    
    local jsonStr = cjson.encode(sceneData)
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonStr)
    
    XQSmartHome.guest_tunnelSmartControllerRequest(encodedData)
end

function set_wifi_share(shareInfo)
    if not shareInfo or type(shareInfo) ~= "table" then
        return false
    end
    
    local uci = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local closingTime = nil
    
    if shareInfo.guest then
        XQLog.log(6, "info.guest " .. shareInfo.guest)
        
        local guestSsidPrefix = GUEST_WIFI_SSID_PREFIX
        
        local function applyWifiConfig(isNewGuest)
            if isNewGuest then
                XQFunction.forkExec("/usr/sbin/guestwifi.sh open; sleep 6; lua /usr/sbin/sync_guest_bssid.lua")
            else
                XQFunction.forkExec("/sbin/wifi update >/dev/null 2>/dev/null; sleep 1; lua /usr/sbin/sync_guest_bssid.lua")
            end
        end
        
        local ssid, encryption, password = nil, nil, nil
        
        if shareInfo.data and type(shareInfo.data) == "table" then
            ssid = shareInfo.data.ssid
            encryption = shareInfo.data.encryption
            password = shareInfo.data.password
        end
        
        XQLog.log(6, "ssid " .. ssid)
        XQLog.log(6, "encryption " .. encryption)
        XQLog.log(6, "key " .. password)
        
        if encryption == "none" then
            password = "12345678"
            XQLog.log(6, "set guest not share, key = " .. password)
        end
        
        if tonumber(shareInfo.guest) == 1 then
            closingTime = shareInfo.closingTime or closingTime
            if not shareInfo.closingTime then
                closingTime = "0"
            end
        else
            closingTime = "0"
        end
        
        XQLog.log(6, "closingTime " .. closingTime)
        
        XQWifiUtil.setGuestWifi(1, ssid, encryption, password, 1, shareInfo.guest, guestSsidPrefix, closingTime)
        XQWifiUtil.setGuestWifi(2, ssid, encryption, password, 1, shareInfo.guest, guestSsidPrefix, closingTime)
        
        XQWifiUtil.enableGuestWifi(applyWifiConfig)
        
        if tonumber(shareInfo.guest) == 1 and closingTime ~= nil then
            if tonumber(closingTime) ~= 0 then
                delete_share_time()
                set_share_time(closingTime)
            end
        end
        
        if tonumber(shareInfo.guest) == 1 then
            LuciUtil.forkExec("sleep 1; /usr/sbin/mipctl_public.sh add_guest_wifi_if")
        else
            LuciUtil.forkExec("sleep 1; /usr/sbin/mipctl_public.sh del_guest_wifi_if")
        end
    end
    
    return true
end
