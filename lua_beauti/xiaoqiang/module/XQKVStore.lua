--[[
  小米路由器KV存储模块 (XQKVStore)
  功能: 获取路由器的各种键值对信息，用于状态同步和信息展示
  
  主要功能:
  - 获取路由器综合状态信息
  - 整合设备、WiFi、推送等多模块数据
]]

module("xiaoqiang.module.XQKVStore", package.seeall)

--[[
  获取路由器KV信息
  整合多个模块的信息，返回路由器的综合状态
  @return 包含路由器各项信息的表
]]
function getRouterKV()
    -- 引入依赖模块
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local XQVASModule = require("xiaoqiang.module.XQVASModule")
    local XQPredownload = require("xiaoqiang.module.XQPredownload")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    -- 获取网络模式类型
    local netModeType = XQFunction.getNetModeType()
    
    -- 获取AP客户端活动类型
    local apcliActiveType = XQWifiUtil.apcli_get_active_type()
    
    -- 获取推送设置
    local pushSettings = XQPushUtil.pushSettings()
    
    -- 获取设备信息
    local devicesInfo = XQDeviceUtil.devicesInfo()
    
    -- 获取WiFi BSSID信息
    local bssid24G, bssid5G, bssid5G2 = XQWifiUtil.getWifiBssid()
    
    -- 获取访客WiFi BSSID
    local bssidGuest = XQWifiUtil.getGuestWifiBssid()
    
    -- 获取WiFi SSID信息
    local ssid24G, ssid5G, ssid5G2 = XQWifiUtil.getWifissid()
    
    -- 获取WLAN数量
    local wlanCount = XQWifiUtil.get_wlan_count()
    
    -- 获取WiFi MAC过滤模式
    local macfilterModel = XQWifiUtil.getWiFiMacfilterModel()
    local protectionMode = macfilterModel - 1
    if protectionMode < 0 then
        protectionMode = 0
    end
    
    -- 获取VAS KV信息
    local vasKvInfo = XQVASModule.get_vas_kv_info()
    
    -- 合并VAS信息到设备信息
    if type(vasKvInfo) == "table" then
        for key, value in pairs(vasKvInfo) do
            devicesInfo[key] = value
        end
    end
    
    -- 设置访客网络状态
    if pushSettings and pushSettings == "1" then
        if netModeType == 0 then
            -- 获取访客网络状态
        end
        devicesInfo.guest = pushSettings
    end
    
    -- 设置路由器名称
    devicesInfo.router_name = XQSysUtil.getRouterName()
    
    -- 设置插件ID列表
    devicesInfo.plugin_id_list = XQSysUtil.getPluginIdList()
    
    -- 获取路由器区域设置
    local routerLocale = XQSysUtil.getRouterLocale()
    devicesInfo.router_locale = routerLocale
    
    -- 设置工作模式
    devicesInfo.work_mode = netModeType
    
    -- 设置AP客户端活动模式
    devicesInfo.active_apcli_mode = apcliActiveType
    
    -- 设置AP LAN IP
    devicesInfo.ap_lan_ip = XQLanWanUtil.getApLanIp()
    
    -- 设置各频段BSSID
    devicesInfo.bssid_24G = bssid24G or ""
    devicesInfo.bssid_5G = bssid5G or ""
    devicesInfo.bssid_guest = bssidGuest or ""
    
    -- 设置各频段SSID
    devicesInfo.ssid_24G = ssid24G or ""
    devicesInfo.ssid_5G = ssid5G or ""
    
    -- 如果有第三个5G频段
    if wlanCount >= 3 then
        devicesInfo.bssid_5G2 = bssid5G2 or ""
        devicesInfo.ssid_5G2 = ssid5G2 or ""
    end
    
    -- 设置LAN BSSID
    devicesInfo.bssid_lan = XQLanWanUtil.getLanBssid()
    
    -- 设置保护状态
    devicesInfo.protection_enabled = XQSysUtil.getProtectionEnabled()
    devicesInfo.protection_mode = protectionMode
    
    -- 设置QoS信息
    devicesInfo.qos_info = XQQoSUtil.getQoSInfo()
    
    -- 设置自动OTA更新设置
    local otaSettings = XQSysUtil.getOtaSettings()
    devicesInfo.auto_ota_rom = otaSettings.auto
    devicesInfo.auto_ota_plugin = otaSettings.plugin
    
    return devicesInfo
end
