--[[
WiFi工具模块 (XQWifiUtil)
小米路由器WiFi管理核心模块

功能概述:
=========
1. WiFi接口管理
   - 多频段支持: 2.4G, 5G, 5GH(高频5G), 6G
   - 接口名称获取和配置
   - WiFi设备计数和状态

2. 频道管理
   - 各国家/地区频道列表配置
   - 支持国家: CN, TW, HK, EU, UK, AS, JP, KR, US, ID, IN, DE, GB, MY, RU, UA, EG, IL, MA, AZ, KZ, UZ, NG, TN
   - 频道验证和格式化
   - 带宽配置: 20MHz, 40MHz, 80MHz, 160MHz

3. WiFi网络操作
   - 获取/设置WiFi状态
   - SSID和密码管理
   - 加密方式配置 (none, psk, psk2, mixed-psk, wep-open, ccmp, psk2+ccmp)
   - 隐藏网络设置
   - 信号强度和质量

4. 设备管理
   - 连接设备列表
   - 设备信号强度
   - MAC地址格式化
   - BSD(频段切换)配置

5. 访客网络
   - 访客WiFi配置
   - IoT设备网络

6. 高级功能
   - WPS配置
   - WiFi中继(APCLI)
   - Mesh网络支持
   - MLO(多链路操作)
   - TWT(目标唤醒时间)
   - WiFi 6(802.11ax)支持
   - 游戏WiFi模式

依赖模块:
- xiaoqiang.common.XQFunction
- xiaoqiang.common.XQConfigs
- luci.model.network
- luci.util
- xiaoqiang.XQLog

@module xiaoqiang.util.XQWifiUtil
@author Xiaomi
--]]

module("xiaoqiang.util.XQWifiUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local LuciNetwork = require("luci.model.network")
local LuciUtil = require("luci.util")
local XQLog = require("xiaoqiang.XQLog")

local uciCursor
local wifiIface2G
local wifiIface5G
local wifiIface5GH
local wifiIface6G
local wifiIfaceCount
local wifiIfname2G
local wifiIfname5G
local wifiIfnameBk2G
local wifiIfnameBk5G
local wifiIfname5GH
local wifiIfname6G
local wifiIfnameGame
local wifiIfnameGuest2G
local wifiIfnameGuest5G
local wifiIfaceList
local wifiIfaceListAll
local wifiNetworkList
local wifiIfnameList
local wifiIfnameBkList
local wifiGuestIfnameList
local wifiIotIfnameList
local wifiGuestNameList

local CHANNEL_LIST_2G_5G = {}
local CHANNEL_LIST_TRIBAND = {}
local CHANNEL_LIST_TRIBAND_ALT = {}
local CHANNEL_LIST_MESH = {}
local BANDWIDTH_OPTIONS = {}

--[[
初始化WiFi接口配置
从UCI配置读取所有WiFi接口名称和参数
--]]
function init()
    local uci = require("luci.model.uci")
    uciCursor = uci.cursor()
    
    wifiIface2G = uciCursor:get("misc", "wireless", "if_2G") or wifiIface2G
    wifiIface5G = uciCursor:get("misc", "wireless", "if_5G") or wifiIface5G
    wifiIface5GH = uciCursor:get("misc", "wireless", "if_5GH") or wifiIface5GH
    wifiIface6G = uciCursor:get("misc", "wireless", "if_6G") or wifiIface6G
    wifiIfaceCount = tonumber(uciCursor:get("misc", "wireless", "wl_if_count") or wifiIfaceCount)
    wifiIfname2G = uciCursor:get("misc", "wireless", "ifname_2G") or wifiIfname2G
    wifiIfname5G = uciCursor:get("misc", "wireless", "ifname_5G") or wifiIfname5G
    wifiIfnameBk2G = uciCursor:get("misc", "wireless", "wifi5_bk_2G") or wifiIfnameBk2G
    wifiIfnameBk5G = uciCursor:get("misc", "wireless", "wifi5_bk_5G") or wifiIfnameBk5G
    wifiIfname5GH = uciCursor:get("misc", "wireless", "ifname_5GH") or wifiIfname5GH
    wifiIfname6G = uciCursor:get("misc", "wireless", "ifname_6G") or wifiIfname6G
    wifiIfnameGame = uciCursor:get("misc", "wireless", "ifname_game")
    wifiIfnameGuest2G = uciCursor:get("misc", "wireless", "ifname_guest_2G") or wifiIfnameGuest2G
    wifiIfnameGuest5G = uciCursor:get("misc", "wireless", "ifname_guest_5G") or wifiIfnameGuest5G
    
    local iotIfname2g = uciCursor:get("misc", "wireless", "wifi5_bk_2G") or iotIfname2g
    local iotIfname5g = uciCursor:get("misc", "wireless", "wifi5_bk_5G") or iotIfname5g
    
    wifiIfaceList = {wifiIface2G, wifiIface5G}
    wifiIfaceListAll = {wifiIface2G, wifiIface5G}
    wifiNetworkList = {wifiIface2G .. ".network1", wifiIface5G .. ".network1"}
    wifiIfnameList = {wifiIfname2G, wifiIfname5G}
    wifiIfnameBkList = {wifiIfnameBk2G, wifiIfnameBk5G}
    wifiGuestIfnameList = {wifiIfnameGuest2G, wifiIfnameGuest5G}
    wifiIotIfnameList = {iotIfname2g, iotIfname5g}
    wifiGuestNameList = {"guest_2G", "guest_5G"}
    
    CHANNEL_LIST_2G_5G = {
        CN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 149 153 157 161 165"},
        TW = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        HK = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 149 153 157 161 165"},
        EU = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        UK = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        AS = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        JP = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        KR = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        US = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        ID = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 149 153 157 161 165"},
        IN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        DE = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        GB = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        MY = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        RU = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        UA = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
        EG = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        IL = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        MA = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        AZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        KZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
        UZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        NG = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"},
        TN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64"}
    }
    
    CHANNEL_LIST_TRIBAND = {
        CN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64", "0 149 153 157 161 165"}
    }
    
    CHANNEL_LIST_TRIBAND_ALT = {
        CN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48", "0 149 153 157 161 165"}
    }
    
    CHANNEL_LIST_MESH = {
        CN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 149 153 157 161 165"},
        TW = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 36 40 44 48"},
        HK = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        EU = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        UK = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        AS = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        JP = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        KR = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        US = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 36 40 44 48"},
        ID = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        IN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        DE = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        GB = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        MY = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        RU = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        UA = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 149 153 157 161 165"},
        EG = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        IL = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        MA = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        AZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        KZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        UZ = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        NG = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"},
        TN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48"}
    }
    
    BANDWIDTH_OPTIONS = {
        {"20"},
        {"20", "40"},
        {"20", "40", "80"},
        {"20", "40", "80", "160"}
    }
    
    if wifiIfaceCount == 3 then
        if string.len(wifiIface5GH) > 0 then
            local insertPos = wifiIfnameGame and 2 or 3
            table.insert(wifiIfaceList, insertPos, wifiIface5GH)
            table.insert(wifiNetworkList, insertPos, wifiIface5GH .. ".network1")
        else
            if string.len(wifiIface6G) > 0 then
                table.insert(wifiIfaceList, wifiIface6G)
                table.insert(wifiNetworkList, wifiIface6G .. ".network1")
            end
        end
    end
    
    if wifiIfaceCount == 3 then
        if string.len(wifiIfname5GH) > 0 then
            local insertPos = wifiIfnameGame and 2 or 3
            table.insert(wifiIfnameList, insertPos, wifiIfname5GH)
            CHANNEL_LIST_2G_5G = CHANNEL_LIST_TRIBAND
            CHANNEL_LIST_MESH = CHANNEL_LIST_TRIBAND_ALT
        else
            if string.len(wifiIfname6G) > 0 then
                table.insert(wifiIfnameList, wifiIfname6G)
            end
        end
    end
end

--[[
获取WiFi接口名称
@return wifiIface2G 2.4G接口名
@return wifiIface5G 5G接口名
--]]
function getWifiNames()
    return uciCursor, wifiIface2G
end

--[[
获取WiFi设备名称列表
@return wifiIfaceList WiFi接口列表
--]]
function getWifiDevNames()
    return wifiIfaceList
end

--[[
根据索引获取WiFi接口名称
@param index WiFi索引(1=2.4G, 2=5G, 3=5GH/6G)
@return string WiFi接口名称
--]]
function _wifiNameForIndex(index)
    return wifiIfaceList[index]
end

--[[
获取无线接口数量
@return number 接口数量
--]]
function get_wlan_count()
    return wifiIfaceCount
end

--[[
获取无线接口名称列表
@return table 接口名称列表
--]]
function get_wlan_ifname()
    return wifiIfnameList
end

--[[
获取WiFi5备用接口名称列表
@return table 备用接口名称列表
--]]
function get_wlan_wifi5_ifname()
    return wifiIfnameBkList
end

--[[
获取访客网络接口名称列表
@return table 访客接口名称列表
--]]
function get_wlan_guest_ifname()
    return wifiGuestIfnameList
end

--[[
获取第二个5G频段后缀名
@return string 后缀名 "_5G_Game" 或 "_5G2"
--]]
function get5G2BandSuffix()
    if wifiIfnameGame then
        return "_5G_Game"
    end
    return "_5G2"
end

--[[
检查是否支持游戏WiFi
@return boolean 是否支持
--]]
function getGameWifiSupport()
    if wifiIfaceCount > 2 then
        if wifiIfnameGame then
            return true
        end
    else
        return false
    end
end

--[[
获取所有WiFi网络信息
@return table WiFi网络详细信息列表
--]]
function wifiNetworks()
    local result = {}
    local network = LuciNetwork.init()
    local wifiDev = nil
    
    for _, dev in ipairs(network:get_wifidevs()) do
        local devInfo = {}
        devInfo.up = dev:is_up()
        devInfo.device = dev:name()
        devInfo.networks = {}
        
        for _, net in ipairs(dev:get_wifinets()) do
            local netInfo = {}
            netInfo.name = net:shortname()
            netInfo.up = net:is_up()
            netInfo.mode = net:active_mode()
            netInfo.ssid = net:active_ssid()
            netInfo.bssid = net:active_bssid()
            netInfo.cssid = net:ssid()
            netInfo.encryption = net:active_encryption()
            netInfo.frequency = net:frequency()
            netInfo.channel = net:channel()
            netInfo.cchannel = net:confchannel()
            netInfo.bw = net:bw()
            netInfo.cbw = net:confbw()
            netInfo.signal = net:signal()
            netInfo.quality = net:signal_percent()
            netInfo.noise = net:noise()
            netInfo.bitrate = net:bitrate()
            netInfo.ifname = net:ifname()
            netInfo.assoclist = net:assoclist()
            netInfo.country = net:country()
            netInfo.txpower = net:txpower()
            netInfo.txpoweroff = net:txpower_offset()
            netInfo.key = net:get("key")
            netInfo.key1 = net:get("key1")
            netInfo.encryption_src = net:get("encryption")
            netInfo.hidden = net:get("hidden")
            netInfo.txpwr = net:txpwr()
            netInfo.bsd = net:get("bsd")
            netInfo.txbf = dev:get("txbf") or netInfo.txbf
            netInfo.ax = dev:get("ax") or netInfo.ax
            netInfo.weakenable = net:get("weakenable") or netInfo.weakenable
            netInfo.weakthreshold = net:get("weakthreshold") or netInfo.weakthreshold
            netInfo.kickthreshold = net:get("kickthreshold") or netInfo.kickthreshold
            netInfo.apcliband = net:get("apcliband")
            netInfo.disabled = net:disabled() or netInfo.disabled
            netInfo.sae = net:get("sae") or netInfo.sae
            netInfo.sae_password = net:get("sae_password")
            
            table.insert(devInfo.networks, netInfo)
            
            if net:disabled() == nil then
                net:set("disabled", "0")
                XQLog.log(6, "init disabled =0 ifname: " .. net:ifname())
                network:save("wireless")
                network:commit("wireless")
            end
        end
        table.insert(result, devInfo)
    end
    
    return result
end

--[[
获取单个WiFi网络信息
@param wifiName WiFi网络名称
@return table WiFi网络详细信息
--]]
function wifiNetwork(wifiName)
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(wifiName)
    
    if wifiNet then
        local wifiDev = wifiNet:get_device()
        if wifiDev then
            local info = {}
            info.id = wifiName
            info.name = wifiNet:shortname()
            info.up = wifiNet:is_up()
            info.mode = wifiNet:active_mode()
            info.ssid = wifiNet:active_ssid()
            info.bssid = wifiNet:active_bssid()
            info.cssid = wifiNet:ssid()
            info.encryption = wifiNet:active_encryption()
            info.encryption_src = wifiNet:get("encryption")
            info.frequency = wifiNet:frequency()
            info.channel = wifiNet:channel()
            info.cchannel = wifiNet:confchannel()
            info.bw = wifiNet:bw()
            info.cbw = wifiNet:confbw()
            info.signal = wifiNet:signal()
            info.quality = wifiNet:signal_percent()
            info.noise = wifiNet:noise()
            info.bitrate = wifiNet:bitrate()
            info.ifname = wifiNet:ifname()
            info.assoclist = wifiNet:assoclist()
            info.country = wifiNet:country()
            info.txpower = wifiNet:txpower()
            info.txpoweroff = wifiNet:txpower_offset()
            info.key = wifiNet:get("key")
            info.key1 = wifiNet:get("key1")
            info.hidden = wifiNet:get("hidden")
            info.txpwr = wifiNet:txpwr()
            info.bsd = wifiNet:get("bsd")
            info.disabled = wifiNet:disabled()
            info.txbf = wifiDev:get("txbf") or info.txbf
            info.ax = wifiDev:get("ax") or info.ax
            info.sae = wifiNet:get("sae") or info.sae
            info.sae_password = wifiNet:get("sae_password")
            
            info.device = {
                up = wifiDev:is_up(),
                device = wifiDev:name(),
                name = wifiDev:get_i18n()
            }
            
            return info
        end
    end
    
    return {}
end

--[[
获取WiFi SSID列表
@return table SSID列表
--]]
function getWifissid()
    local result = {}
    local network = LuciNetwork.init()
    
    for index, ifaceName in ipairs(wifiIfaceList) do
        local wifiNet = network:get_wifinet(ifaceName)
        if wifiNet then
            result[index] = wifiNet:ssid()
        end
    end
    
    return unpack(result)
end

--[[
获取WiFi BSSID(MAC地址)
@return string... 各频段的BSSID
--]]
function getWifiBssid()
    local util = require("luci.util")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    local bssid5G = util.exec("getmac wl1")
    local bssid2G = util.exec("getmac wl0")
    
    if wifiIfaceCount >= 3 then
        local bssid5GH = util.exec("getmac wl2")
        return util.trim(bssid5G), util.trim(bssid2G), util.trim(bssid5GH)
    else
        return util.trim(bssid5G), util.trim(bssid2G)
    end
end

--[[
获取访客WiFi的BSSID
@return string 访客WiFi的MAC地址
--]]
function getGuestWifiBssid()
    if not XQFunction.isStrNil(WIFIGUEST) then
        local util = require("luci.util")
        local cmd = "cat /sys/class/net/" .. WIFIGUEST .. "/address 2>/dev/null"
        local mac = util.exec(cmd)
        
        if not XQFunction.isStrNil(mac) then
            mac = util.trim(mac)
            return XQFunction.macFormat(mac)
        end
    end
    return nil
end

--[[
获取指定WiFi索引的可用频道列表
@param wifiIndex WiFi索引
@return table 频道列表
--]]
function getChannels(wifiIndex)
    local ok, iwinfo = pcall(require, "iwinfo")
    local ifname = _wifiNameForIndex(wifiIndex)
    local channels = nil
    
    if ok then
        local iwType = iwinfo.type(ifname or "")
        if ifname and iwType then
            local driver = iwinfo[iwType]
            if driver then
                channels = driver.freqlist(ifname)
            end
        end
    end
    
    return channels
end

local CHANNEL_2G_MAP = {
    ["1"] = {["20"] = "1", ["40"] = "1l"},
    ["2"] = {["20"] = "2", ["40"] = "2l"},
    ["3"] = {["20"] = "3", ["40"] = "3l"},
    ["4"] = {["20"] = "4", ["40"] = "4l"},
    ["5"] = {["20"] = "5", ["40"] = "5l"},
    ["6"] = {["20"] = "6", ["40"] = "6l"},
    ["7"] = {["20"] = "7", ["40"] = "7l"},
    ["8"] = {["20"] = "8", ["40"] = "8u"},
    ["9"] = {["20"] = "9", ["40"] = "9u"},
    ["10"] = {["20"] = "10", ["40"] = "10u"},
    ["11"] = {["20"] = "11", ["40"] = "11u"},
    ["12"] = {["20"] = "12", ["40"] = "12u"},
    ["13"] = {["20"] = "13", ["40"] = "13u"}
}

local CHANNEL_5G_MAP = {
    ["36"] = {["20"] = "36", ["40"] = "36l", ["80"] = "36/80"},
    ["40"] = {["20"] = "40", ["40"] = "40u", ["80"] = "40/80"},
    ["44"] = {["20"] = "44", ["40"] = "44l", ["80"] = "44/80"},
    ["48"] = {["20"] = "48", ["40"] = "48u", ["80"] = "48/80"},
    ["52"] = {["20"] = "52", ["40"] = "52l", ["80"] = "52/80"},
    ["56"] = {["20"] = "56", ["40"] = "56u", ["80"] = "56/80"},
    ["60"] = {["20"] = "60", ["40"] = "60l", ["80"] = "60/80"},
    ["64"] = {["20"] = "64", ["40"] = "64u", ["80"] = "64/80"},
    ["149"] = {["20"] = "149", ["40"] = "149l", ["80"] = "149/80"},
    ["153"] = {["20"] = "153", ["40"] = "153u", ["80"] = "153/80"},
    ["157"] = {["20"] = "157", ["40"] = "157l", ["80"] = "157/80"},
    ["161"] = {["20"] = "161", ["40"] = "161u", ["80"] = "161/80"},
    ["165"] = {["20"] = "165"}
}

--[[
验证指定WiFi索引的频道是否有效
@param wifiIndex WiFi索引
@param channel 频道号
@return boolean 是否有效
--]]
function verfiyChannelByWlIndex(wifiIndex, channel)
    local channelList = CHANNEL_LIST_2G_5G
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local supportDFS = XQSysUtil.isMeshSupportDFS()
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local countryCode = XQCountryCode.getBDataCountryCode()
    local isMesh = XQFunction.isMeshMode()
    
    if isMesh and not supportDFS then
        channelList = CHANNEL_LIST_MESH
    end
    
    channelList = channelList[countryCode]
    
    if getGameWifiSupport() and wifiIndex > 1 then
        if wifiIndex == 3 then
            wifiIndex = 2
        else
            wifiIndex = 3
        end
    end
    
    if not channelList or not channelList[wifiIndex] then
        return false
    end
    
    local found = nil
    for idx, ch in ipairs(string.split(channelList[wifiIndex], " ")) do
        if ch == channel then
            found = idx
            break
        end
    end
    
    if found ~= nil then
        return true
    else
        return false
    end
end

--[[
获取默认WiFi频道列表
@param wifiIndex WiFi索引
@return table 频道列表,包含频道号和带宽选项
--]]
function getDefaultWifiChannels(wifiIndex)
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local countryCode = XQCountryCode.getBDataCountryCode()
    local result = {}
    local channelList = nil
    
    channelList = CHANNEL_LIST_2G_5G[countryCode]
    
    if getGameWifiSupport() and wifiIndex > 1 then
        if wifiIndex == 3 then
            wifiIndex = 2
        else
            wifiIndex = 3
        end
    end
    
    if channelList == nil or channelList[wifiIndex] == nil then
        return result
    end
    
    local channels = channelList[wifiIndex]
    for _, chStr in ipairs(string.split(channels, " ")) do
        local ch = tonumber(chStr)
        local item = {c = ch}
        
        if ch == 0 then
            if wifiIndex == 1 then
                item.b = BANDWIDTH_OPTIONS[2]
            elseif wifiIndex == 2 then
                item.b = BANDWIDTH_OPTIONS[4]
            elseif wifiIndex == 3 then
                item.b = BANDWIDTH_OPTIONS[3]
            end
        elseif ch <= 13 then
            item.b = BANDWIDTH_OPTIONS[2]
        elseif ch == 165 then
            item.b = BANDWIDTH_OPTIONS[1]
        elseif ch >= 149 and ch <= 161 then
            item.b = BANDWIDTH_OPTIONS[3]
        elseif ch >= 140 and ch <= 144 then
            item.b = BANDWIDTH_OPTIONS[1]
        elseif ch >= 132 and ch <= 136 then
            item.b = BANDWIDTH_OPTIONS[2]
        elseif ch >= 36 and ch <= 128 then
            item.b = BANDWIDTH_OPTIONS[4]
        else
            item.b = BANDWIDTH_OPTIONS[4]
        end
        
        table.insert(result, item)
    end
    
    return result
end

--[[
获取所有WiFi设备的MAC地址列表
@return table MAC地址列表
--]]
function getWifiAllDeviceMacList()
    local uci = require("luci.model.uci").cursor()
    local util = require("luci.util")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local ifnames = {}
    
    local ifname2G = uci:get("misc", "wireless", "ifname_2G") or ifname2G
    local ifname5G = uci:get("misc", "wireless", "ifname_5G") or ifname5G
    local ifname5GH = uci:get("misc", "wireless", "ifname_5GH") or ifname5GH
    
    if string.len(ifname2G) > 0 then
        table.insert(ifnames, ifname2G)
    end
    if string.len(ifname5G) > 0 then
        table.insert(ifnames, ifname5G)
    end
    if string.len(ifname5GH) > 0 then
        table.insert(ifnames, ifname5GH)
    end
    
    local ok, iwinfo = pcall(require, "iwinfo")
    if not ok then
        return result
    end
    
    for _, ifname in ipairs(ifnames) do
        local iwType = iwinfo.type(ifname or "")
        if ifname and iwType then
            local driver = iwinfo[iwType]
            if driver then
                for mac, _ in pairs(driver.assoclist(ifname) or {}) do
                    local item = {}
                    item.mac = string.lower(tostring(mac))
                    table.insert(result, item)
                end
            end
        end
    end
    
    return result
end

--[[
获取指定WiFi的连接设备列表
@param wifiIndex WiFi索引
@return table 设备MAC地址列表
--]]
function getWifiConnectDeviceList(wifiIndex)
    local assoclist = {}
    local isUp = false
    
    if tonumber(wifiIndex) == 1 then
        local status = getWifiStatus(wifiIndex)
        isUp = status.up == 1
        local netInfo = wifiNetwork(_wifiNameForIndex(wifiIndex))
        assoclist = netInfo.assoclist or {}
    else
        local status = getWifiStatus(wifiIndex)
        isUp = status.up == 1
        local netInfo = wifiNetwork(_wifiNameForIndex(wifiIndex))
        assoclist = netInfo.assoclist or {}
    end
    
    local result = {}
    if isUp then
        for mac, _ in pairs(assoclist) do
            table.insert(result, XQFunction.macFormat(mac))
        end
    end
    
    return result
end

--[[
获取指定WiFi的连接设备数量
@param wifiIndex WiFi索引
@return number 设备数量
--]]
function get_wl_con_dev_num(wifiIndex)
    local network = LuciNetwork.init()
    local ifaceName = wifiIfaceList[wifiIndex]
    
    if not ifaceName then
        return 0
    end
    
    local wifiNet = network:get_wifinet(ifaceName)
    if not wifiNet then
        return 0
    end
    
    local count = 0
    local assoclist = wifiNet.assoclist() or assoclist
    
    for _, _ in pairs(assoclist) do
        count = count + 1
    end
    
    return count
end

--[[
解析频道字符串,添加带宽标识
@param channel 频道字符串
@return string 带带宽标识的频道描述
--]]
function _pauseChannel(channel)
    if XQFunction.isStrNil(channel) then
        return ""
    end
    
    if channel:match("l") then
        return channel:gsub("l", "") .. "(40M)"
    end
    
    if channel:match("u") then
        return channel:gsub("u", "") .. "(40M)"
    end
    
    if channel:match("/80") then
        return channel:gsub("/80", "") .. "(80M)"
    end
    
    return channel .. "(20M)"
end

--[[
获取WiFi工作频道
@param wifiIndex WiFi索引
@return string 工作频道描述
--]]
function getWifiWorkChannel(wifiIndex)
    local channel = ""
    
    if tonumber(wifiIndex) == 1 then
        channel = LuciUtil.trim(LuciUtil.exec("iwlist wl1 channel | awk -F '[ )]+' '/Current Frequency/{print $6}'"))
    else
        channel = LuciUtil.trim(LuciUtil.exec("iwlist wl0 channel | awk -F '[ )]+' '/Current Frequency/{print $6}'"))
    end
    
    return _pauseChannel(channel)
end

--[[
根据MAC地址获取设备所连接的WiFi索引
@param mac 设备MAC地址
@return number WiFi索引
--]]
function getDeviceWifiIndex(mac)
    mac = string.lower(mac)
    local network = LuciNetwork.init()
    
    for index, ifaceName in ipairs(wifiIfaceList) do
        local wifiNet = network:get_wifinet(ifaceName)
        if wifiNet then
            local assoclist = wifiNet:assoclist()
            for deviceMac, _ in pairs(assoclist) do
                if mac == string.lower(deviceMac) then
                    return index
                end
            end
        end
    end
    
    return nil
end

--[[
获取WiFi设备信号强度字典
@param wifiIndex WiFi索引
@return table MAC地址到信号强度的映射
--]]
function getWifiDeviceSignalDict(wifiIndex)
    local result = {}
    local assoclist = {}
    local isUp = false
    
    local status = getWifiStatus(wifiIndex)
    if status.up ~= 1 then
        return result
    end
    
    local netInfo = wifiNetwork(_wifiNameForIndex(wifiIndex))
    assoclist = netInfo.assoclist or {}
    
    for mac, info in pairs(assoclist) do
        if mac then
            local formattedMac = XQFunction.macFormat(mac)
            local signal = tonumber(info.signal) - tonumber(info.noise)
            signal = math.abs(signal) * 2
            result[formattedMac] = signal
        end
    end
    
    return result
end

--[[
获取指定设备的WiFi信号强度
@param mac 设备MAC地址
@return number 信号强度
--]]
function getWifiDeviceSignal(mac)
    if XQFunction.isStrNil(mac) then
        return nil
    end
    
    local netInfo = wifiNetwork(_wifiNameForIndex(1))
    local assoclist = netInfo.assoclist or {}
    
    for deviceMac, info in pairs(assoclist) do
        if mac == deviceMac then
            return info.signal
        end
    end
    
    netInfo = wifiNetwork(_wifiNameForIndex(2))
    assoclist = netInfo.assoclist or {}
    
    for deviceMac, info in pairs(assoclist) do
        if mac == deviceMac then
            return info.signal
        end
    end
    
    return nil
end

--[[
获取指定设备的WiFi速度
@param mac 设备MAC地址
@return table 包含upspeed和downspeed
--]]
function getWifiDeviceSpeed(mac)
    local result = {}
    
    if XQFunction.isStrNil(mac) then
        return nil
    end
    
    local netInfo = wifiNetwork(_wifiNameForIndex(1))
    local assoclist = netInfo.assoclist or {}
    
    for deviceMac, info in pairs(assoclist) do
        if mac == deviceMac then
            result.upspeed = info.rx_rate
            result.downspeed = info.tx_rate
            return result
        end
    end
    
    netInfo = wifiNetwork(_wifiNameForIndex(2))
    assoclist = netInfo.assoclist or {}
    
    for deviceMac, info in pairs(assoclist) do
        if mac == deviceMac then
            result.upspeed = info.rx_rate
            result.downspeed = info.tx_rate
            return result
        end
    end
    
    return nil
end

--[[
获取所有WiFi连接设备列表
@return table 设备列表,包含mac、signal、wifiIndex
--]]
function getAllWifiConnetDeviceList()
    local result = {}
    
    for wifiIndex = 1, 2 do
        local signalDict = getWifiDeviceSignalDict(wifiIndex)
        local deviceList = getWifiConnectDeviceList(wifiIndex)
        
        for _, mac in ipairs(deviceList) do
            table.insert(result, {
                mac = XQFunction.macFormat(mac),
                signal = signalDict[mac],
                wifiIndex = wifiIndex
            })
        end
    end
    
    return result
end

--[[
获取所有WiFi连接设备字典
@return table MAC地址到设备信息的映射
--]]
function getAllWifiConnetDeviceDict()
    local result = {}
    
    for wifiIndex = 1, 2 do
        local signalDict = getWifiDeviceSignalDict(wifiIndex)
        local deviceList = getWifiConnectDeviceList(wifiIndex)
        
        for _, mac in ipairs(deviceList) do
            result[XQFunction.macFormat(mac)] = {
                signal = signalDict[mac],
                wifiIndex = wifiIndex
            }
        end
    end
    
    return result
end

--[[
获取WiFi状态
@param wifiIndex WiFi索引
@return table 包含ssid和up状态
--]]
function getWifiStatus(wifiIndex)
    local netInfo = wifiNetwork(_wifiNameForIndex(wifiIndex))
    local result = {}
    result.ssid = netInfo.ssid
    result.up = netInfo.up and 1 or 0
    return result
end

--[[
频道辅助函数,解析频道和带宽信息
@param channel 频道字符串
@return table 包含channel、bandwidth、bandList
--]]
function channelHelper(channel)
    local result = {channel = "", bandwidth = ""}
    
    if XQFunction.isStrNil(channel) then
        return result
    end
    
    if string.find(channel, "l") ~= nil then
        result.channel = channel:match("(%d+)")
        result.bandwidth = "40"
    elseif string.find(channel, "u") ~= nil then
        result.channel = channel:match("(%d+)")
        result.bandwidth = "40"
    elseif string.find(channel, "/80") ~= nil then
        result.channel = channel:match("(%d+)")
        result.bandwidth = "80"
    else
        result.channel = tostring(channel)
        result.bandwidth = "20"
    end
    
    local bandList = {}
    if result.channel then
        local channelMap = CHANNEL_2G_MAP[result.channel]
        if not channelMap then
            channelMap = CHANNEL_5G_MAP[result.channel]
        end
        if channelMap then
            if type(channelMap) == "table" then
                for bw, _ in pairs(channelMap) do
                    table.insert(bandList, bw)
                end
            end
        end
    end
    result.bandList = bandList
    
    return result
end

--[[
获取指定频道的可用带宽列表
@param channel 频道号
@param ifname 接口名称
@return table 带宽列表
--]]
function getBandList(channel, ifname)
    local result = {channel = "", bandwidth = ""}
    
    if XQFunction.isStrNil(channel) then
        return result
    end
    
    local bandList = {}
    local channelInfo = nil
    
    for idx, name in ipairs(wifiIfnameList) do
        if name == ifname then
            channelInfo = getDefaultWifiChannels(idx)
        end
    end
    
    if channelInfo then
        for _, info in ipairs(channelInfo) do
            if info then
                if tonumber(info.c) == tonumber(channel) then
                    bandList = info.b
                    break
                end
            end
        end
    end
    
    result.bandList = bandList
    return result
end

--[[
修复频道字符串,移除带宽标识
@param channel 频道字符串
@return string 纯频道号
--]]
function _channelFix(channel)
    if XQFunction.isStrNil(channel) then
        return ""
    end
    
    channel = string.gsub(channel, "l", "")
    channel = string.gsub(channel, "u", "")
    channel = string.gsub(channel, "/80", "")
    
    return channel
end

--[[
格式化频道配置
@param wifiIndex WiFi索引
@param channel 频道号
@param bandwidth 带宽
@return string 格式化后的频道配置
--]]
function channelFormat(wifiIndex, channel, bandwidth)
    local channelMap = {}
    
    if tonumber(wifiIndex) == 1 then
        channelMap = CHANNEL_2G_MAP[tostring(channel)]
    else
        channelMap = CHANNEL_5G_MAP[tostring(channel)]
    end
    
    if channelMap then
        if type(channelMap) == "table" then
            local result = channelMap[tostring(bandwidth)]
            if not XQFunction.isStrNil(result) then
                return result
            end
        end
    end
    
    return false
end

--[[
生成随机密码
@param length 密码长度
@return string 随机密码
--]]
local function generateRandomPassword(length)
    local chars = {}
    local specialChars = "`~!@#$%^&*()_-+={}[]:;\"<>?/.,"
    local charLen = length - 2
    
    for i = 0, 9 do
        table.insert(chars, tostring(i))
    end
    
    for i = 65, 90 do
        table.insert(chars, string.char(i))
    end
    
    for i = 97, 122 do
        table.insert(chars, string.char(i))
    end
    
    for i = 1, #specialChars do
        table.insert(chars, string.sub(specialChars, i, i))
    end
    
    math.randomseed(os.time())
    local result = ""
    
    for i = 1, charLen do
        local idx = math.random(1, #chars)
        result = result .. chars[idx]
    end
    
    local sp1 = string.sub(specialChars, math.random(1, #specialChars), math.random(1, #specialChars))
    local sp2 = string.sub(specialChars, math.random(1, #specialChars), math.random(1, #specialChars))
    
    return result
end

--[[
检查字符串是否包含非ASCII字符
@param str 字符串
@return boolean 是否包含非ASCII字符
--]]
local function hasNonAscii(str)
    for i = 1, string.len(str) do
        if string.byte(str, i) > 127 then
            return true
        end
    end
    return false
end

--[[
获取IoT WiFi的默认SSID和密码
@param band 频段 "2G" 或 "5G"
@return string, string SSID和密码
--]]
local function getIotWifiDefault(band)
    local uci = require("luci.model.uci").cursor()
    local ssid, encryption, password, ifname = nil, nil, nil, nil
    
    if band == "2G" then
        ifname = uci:get("misc", "wireless", "ifname_2G")
    elseif band == "5G" then
        ifname = uci:get("misc", "wireless", "ifname_5G")
    else
        return nil, nil
    end
    
    uci:foreach("wireless", "wifi-iface", function(s)
        if s.ifname == ifname then
            ssid = s.ssid
            encryption = s.encryption
            if encryption == "ccmp" or encryption == "psk2+ccmp" then
                password = s.sae_password
            elseif encryption ~= "none" then
                password = s.key
            end
        end
    end)
    
    local baseSsid = ssid
    if hasNonAscii(ssid) then
        baseSsid = uci:get("misc", "hardware", "model")
    end
    
    local iotSsid
    if band == "2G" then
        iotSsid = baseSsid .. "_IoT"
        if string.len(iotSsid) > 31 then
            baseSsid = string.sub(baseSsid, 1, #baseSsid - (string.len(baseSsid) - 27))
            iotSsid = baseSsid .. "_IoT"
        end
    elseif band == "5G" then
        iotSsid = baseSsid .. "_IoT_5G"
        if string.len(iotSsid) > 31 then
            baseSsid = string.sub(baseSsid, 1, #baseSsid - (string.len(baseSsid) - 24))
            iotSsid = baseSsid .. "_IoT_5G"
        end
    end
    
    local iotPassword
    if encryption == "none" then
        iotPassword = generateRandomPassword(8)
    else
        iotPassword = password .. "iot"
        if string.len(iotPassword) > 63 then
            password = string.sub(password, 1, #password - (string.len(password) - 60))
            iotPassword = password .. "iot"
        end
    end
    
    return iotSsid, iotPassword
end

--[[
获取IoT WiFi设备信息
@return table IoT WiFi配置信息
--]]
function getIotWifiDeviceInfo()
    local uci = require("luci.model.uci").cursor()
    local iotDevFeature = uci:get("misc", "features", "iot_dev") or iotDevFeature
    local result = {}
    local basicInfo = {}
    local advanceInfo = {}
    local info2G = {}
    local info5G = {}
    
    if tonumber(iotDevFeature) == 1 then
        local ssid2G = uci:get("wireless", "iot_2g", "ssid") or ssid2G
        local disabled2G = uci:get("wireless", "iot_2g", "disabled") or disabled2G
        info2G.encryption = uci:get("wireless", "iot_2g", "encryption")
        
        if ssid2G == nil then
            local defaultSsid, defaultPwd = getIotWifiDefault("2G")
            info2G.ssid = XQFunction.encode4HtmlValue(defaultSsid)
            info2G.password = defaultPwd
        else
            info2G.ssid = XQFunction.encode4HtmlValue(ssid2G)
            if info2G.encryption == "none" then
                local _, defaultPwd = getIotWifiDefault("2G")
                info2G.password = defaultPwd
            elseif info2G.encryption == "ccmp" or info2G.encryption == "psk2+ccmp" then
                info2G.password = uci:get("wireless", "iot_2g", "sae_password")
            else
                info2G.password = uci:get("wireless", "iot_2g", "key")
            end
        end
        info2G.ssidHtmlEncode = 1
        
        local ssid5G = uci:get("wireless", "iot_5g", "ssid") or ssid5G
        info5G.encryption = uci:get("wireless", "iot_5g", "encryption")
        
        if ssid5G == nil then
            local defaultSsid, defaultPwd = getIotWifiDefault("5G")
            info5G.ssid = XQFunction.encode4HtmlValue(defaultSsid)
            info5G.password = defaultPwd
        else
            info5G.ssid = XQFunction.encode4HtmlValue(ssid5G)
            if info5G.encryption == "none" then
                local _, defaultPwd = getIotWifiDefault("5G")
                info5G.password = defaultPwd
            elseif info5G.encryption == "ccmp" or info5G.encryption == "psk2+ccmp" then
                info5G.password = uci:get("wireless", "iot_5g", "sae_password")
            else
                info5G.password = uci:get("wireless", "iot_5g", "key")
            end
        end
        info5G.ssidHtmlEncode = 1
        
        table.insert(basicInfo, info2G)
        table.insert(basicInfo, info5G)
        result.basicInfo = basicInfo
        
        advanceInfo.wifi5mode = tonumber(uci:get("wireless", "iot_2g", "iotwifi5mode"))
        advanceInfo.high_priority_access = uci:get("wireless", "miot_2G", "miot_access_iotdev") or advanceInfo.high_priority_access
        advanceInfo.ax = tonumber(uci:get("wireless", "wifi0", "ax")) or advanceInfo.ax
        
        if tonumber(disabled2G) == 1 then
            advanceInfo.enable = 0
        else
            advanceInfo.enable = 1
        end
        
        result.advanceInfo = advanceInfo
        return result
    else
        return nil
    end
end

--[[
获取所有WiFi信息
@return table 所有WiFi的详细配置信息
--]]
function getAllWifiInfo()
    local result = {}
    local wifiDict = {}
    local networks = wifiNetworks()
    
    for _, dev in ipairs(networks) do
        local info = {}
        local netIndex = 1
        local network = dev.networks[netIndex]
        
        local channel = network.cchannel
        if channel == "auto" then
            channel = "0"
        end
        info.channel = channel
        info.bandwidth = network.cbw
        info.channelInfo = getBandList(channel, network.ifname)
        
        for idx, ifname in ipairs(wifiIfnameList) do
            if ifname == dev.device then
                info.available_channels = getDefaultWifiChannels(idx)
            end
        end
        
        info.ssid = XQFunction.encode4HtmlValue(network.ssid)
        info.ssidHtmlEncode = 1
        
        if network.disabled == "1" then
            info.status = "0"
        else
            info.status = "1"
        end
        
        local encryption = network.encryption_src
        local password = network.key
        
        if encryption == "wep-open" then
            password = network.key1
            if password and password:len() > 4 then
                if password:sub(0, 2) == "s:" then
                    password = password:sub(3)
                end
            end
        elseif encryption == "ccmp" then
            password = network.sae_password
        end
        
        info.ifname = network.ifname
        info.device = dev.device .. ".network" .. netIndex
        info.mode = network.mode
        info.hidden = network.hidden or "0"
        info.signal = network.signal
        info.password = XQFunction.encode4HtmlValue(password)
        info.encryption = encryption
        
        if network.txpwr == "nil" then
            info.txpwr = "max"
        else
            info.txpwr = network.txpwr or "max"
        end
        
        info.bsd = network.bsd
        info.txbf = network.txbf
        info.ax = network.ax
        info.weakenable = network.weakenable
        info.weakthreshold = network.weakthreshold
        info.kickthreshold = network.kickthreshold
        
        wifiDict[dev.device] = info
    end
    
    for _, ifname in ipairs(wifiIfnameList) do
        table.insert(result, wifiDict[ifname])
    end
    
    return result
end

--[[
获取诊断用的所有WiFi信息
@return table WiFi诊断信息
--]]
function getDiagAllWifiInfo()
    local result = {}
    local wifiDict = {}
    local networks = wifiNetworks()
    
    for _, dev in ipairs(networks) do
        local info = {}
        local netIndex = 1
        local network = dev.networks[netIndex]
        
        info.channel = network.cchannel
        info.bandwidth = network.cbw
        info.channelInfo = getBandList(network.cchannel, network.ifname)
        
        if dev.up then
            info.status = "1"
            info.ssid = XQFunction.encode4HtmlValue(network.ssid)
            info.channelInfo.channel = network.channel
            info.channelInfo.bandwidth = network.bw
        else
            info.status = "0"
            info.ssid = XQFunction.encode4HtmlValue(network.cssid)
            info.channelInfo.channel = network.cchannel
            info.channelInfo.bandwidth = network.cbw
        end
        info.ssidHtmlEncode = 1
        
        local encryption = network.encryption_src
        local password = network.key
        
        if encryption == "wep-open" then
            password = network.key1
            if password and password:len() > 4 then
                if password:sub(0, 2) == "s:" then
                    password = password:sub(3)
                end
            end
        elseif encryption == "ccmp" then
            password = network.sae_password
        end
        
        info.ifname = network.ifname
        info.device = dev.device .. ".network" .. netIndex
        info.mode = network.mode
        info.hidden = network.hidden or "0"
        info.signal = network.signal
        info.password = XQFunction.encode4HtmlValue(password)
        info.encryption = encryption
        
        if network.txpwr == "nil" then
            info.txpwr = "max"
        else
            info.txpwr = network.txpwr or "max"
        end
        
        info.bsd = network.bsd
        info.txbf = network.txbf
        info.ax = network.ax
        
        wifiDict[dev.device] = info
    end
    
    if wifiDict[wifiIfnameList[1]] then
        wifiDict[wifiIfnameList[1]].iftype = 1
        table.insert(result, wifiDict[wifiIfnameList[1]])
    end
    
    if wifiDict[wifiIfnameList[2]] then
        wifiDict[wifiIfnameList[2]].iftype = 2
        table.insert(result, wifiDict[wifiIfnameList[2]])
    end
    
    if wifiDict[wifiIfnameList[3]] then
        if wifiIfnameGame == 0 then
            wifiDict[wifiIfnameList[3]].iftype = 3
            table.insert(result, wifiDict[wifiIfnameList[3]])
        end
    end
    
    return result
end

--[[
获取WiFi发射功率
@param wifiIndex WiFi索引
@return string 发射功率
--]]
function getWifiTxpwr(wifiIndex)
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(_wifiNameForIndex(wifiIndex))
    
    if wifiNet then
        return tostring(wifiNet:txpwr())
    else
        return nil
    end
end

--[[
获取WiFi频道
@param wifiIndex WiFi索引
@return string 频道号
--]]
function getWifiChannel(wifiIndex)
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(_wifiNameForIndex(wifiIndex))
    
    if wifiNet then
        return tostring(wifiNet:channel())
    else
        return nil
    end
end

--[[
获取所有WiFi的发射功率列表
@return table 发射功率列表
--]]
function getWifiTxpwrList()
    local result = {}
    local network = LuciNetwork.init()
    
    local wifiNet1 = network:get_wifinet(_wifiNameForIndex(1))
    local wifiNet2 = network:get_wifinet(_wifiNameForIndex(2))
    
    if wifiNet1 then
        table.insert(result, tostring(wifiNet1:txpwr()))
    end
    
    if wifiNet2 then
        table.insert(result, tostring(wifiNet2:txpwr()))
    end
    
    return result
end

--[[
获取所有WiFi的频道列表
@return table 频道列表
--]]
function getWifiChannelList()
    local result = {}
    local network = LuciNetwork.init()
    
    local wifiNet1 = network:get_wifinet(_wifiNameForIndex(1))
    local wifiNet2 = network:get_wifinet(_wifiNameForIndex(2))
    
    if wifiNet1 then
        table.insert(result, tostring(wifiNet1:channel()))
    end
    
    if wifiNet2 then
        table.insert(result, tostring(wifiNet2:channel()))
    end
    
    return result
end

--[[
获取所有WiFi的频道和发射功率列表
@return table 频道和发射功率信息列表
--]]
function getWifiChannelTxpwrList()
    local result = {}
    local network = LuciNetwork.init()
    
    local wifiNet1 = network:get_wifinet(_wifiNameForIndex(1))
    local wifiNet2 = network:get_wifinet(_wifiNameForIndex(2))
    
    if wifiNet1 then
        table.insert(result, {
            channel = tostring(wifiNet1:channel()),
            txpwr = tostring(wifiNet1:txpwr())
        })
    else
        table.insert(result, {})
    end
    
    if wifiNet2 then
        table.insert(result, {
            channel = tostring(wifiNet2:channel()),
            txpwr = tostring(wifiNet2:txpwr())
        })
    else
        table.insert(result, {})
    end
    
    return result
end

--[[
设置WiFi频道和发射功率
@param channel1 2.4G频道
@param txpwr1 2.4G发射功率
@param channel2 5G频道
@param txpwr2 5G发射功率
@return boolean 是否成功
--]]
function setWifiChannelTxpwr(channel1, txpwr1, channel2, txpwr2)
    local network = LuciNetwork.init()
    
    local wifiDev1 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(1), ".")[1])
    local wifiDev2 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(2), ".")[1])
    
    if wifiDev1 then
        if tonumber(channel1) then
            wifiDev1:set("channel", channel1)
        end
        if not XQFunction.isStrNil(txpwr1) then
            wifiDev1:set("txpwr", txpwr1)
        end
    end
    
    if wifiDev2 then
        if tonumber(channel2) then
            wifiDev2:set("channel", channel2)
        end
        if not XQFunction.isStrNil(txpwr2) then
            wifiDev2:set("txpwr", txpwr2)
        end
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
设置WiFi发射功率
@param txpwr 发射功率
@return boolean 是否成功
--]]
function setWifiTxpwr(txpwr)
    local network = LuciNetwork.init()
    
    local wifiDev1 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(1), ".")[1])
    local wifiDev2 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(2), ".")[1])
    
    if wifiDev1 and not XQFunction.isStrNil(txpwr) then
        wifiDev1:set("txpwr", txpwr)
    end
    
    if wifiDev2 and not XQFunction.isStrNil(txpwr) then
        wifiDev2:set("txpwr", txpwr)
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
设置WiFi波束成形(TxBF)
@param txbf 波束成形设置值
@return boolean 是否成功
--]]
function setWifiTxbf(txbf)
    local network = LuciNetwork.init()
    
    if txbf then
        return txbf
    end
    
    for _, devName in ipairs(wifiIfnameList) do
        local wifiDev = network:get_wifidev(devName)
        if wifiDev then
            wifiDev:set("txbf", txbf)
        end
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
设置WiFi 6(802.11ax)
@param ax ax设置值 (0=关闭, 1=开启)
@return boolean 是否成功
--]]
function setWifiAx(ax)
    local network = LuciNetwork.init()
    
    if ax then
        return ax
    end
    
    if ax ~= nil then
        if ax == 1 then
            -- 启用ax时的额外处理
        end
    else
        -- ax为nil时的处理
    end
    
    for _, devName in ipairs(wifiIfnameList) do
        local wifiDev = network:get_wifidev(devName)
        if wifiDev then
            wifiDev:set("ax", ax)
        end
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
检查WiFi密码有效性
@param password 密码
@param encryption 加密方式
@return number 错误码 (0=有效, 1502=密码为空, 1520=密码太短, 1521=密码太长, 1522=WEP密码长度错误, 1523=密码包含中文)
--]]
function checkWifiPasswd(password, encryption)
    if not XQFunction.isStrNil(encryption) then
        if not encryption or encryption == "none" then
            -- 无加密不需要密码
        elseif XQFunction.isStrNil(password) then
            return 1502
        end
    else
        return 1502
    end
    
    if XQFunction.checkChineseChar(password) then
        return 1523
    end
    
    if encryption == "psk" or encryption == "psk2" then
        if password:len() < 8 then
            return 1520
        end
    elseif encryption == "mixed-psk" then
        if password:len() < 8 or password:len() > 63 then
            return 1521
        end
    elseif encryption == "wep-open" then
        if password:len() ~= 5 and password:len() ~= 13 then
            return 1522
        end
    end
    
    return 0
end

--[[
检查SSID有效性
@param ssid SSID名称
@param maxLen 最大长度
@return number 错误码 (0=有效, 1572=超长, 1573=包含非法字符)
--]]
function checkSSID(ssid, maxLen)
    if XQFunction.isStrNil(ssid) then
        return 0
    end
    
    if string.len(ssid) > tonumber(maxLen) then
        return 1572
    end
    
    if not XQFunction.checkSSID(ssid) then
        return 1573
    end
    
    return 0
end

--[[
获取WiFi基本信息
@param wifiIndex WiFi索引
@return table WiFi基本配置信息
--]]
function getWifiBasicInfo(wifiIndex)
    local network = LuciNetwork.init()
    local ifaceName = wifiIfaceList[wifiIndex]
    
    if not ifaceName then
        return nil
    end
    
    local wifiNet = network:get_wifinet(ifaceName)
    if not wifiNet then
        return nil
    end
    
    local wifiDev = wifiNet:get_device()
    if not wifiDev then
        return nil
    end
    
    local info = {}
    info.wifiIndex = wifiIndex
    info.channel = wifiDev:get("channel") or info.channel
    info.bandwidth = wifiDev:get("bw") or info.bandwidth
    info.txpwr = wifiDev:get("txpwr") or info.txpwr
    info.on = wifiNet:get("disabled") or info.on
    info.ssid = wifiNet:get("ssid")
    info.encryption = wifiNet:get("encryption")
    info.password = wifiNet:get("key")
    info.hidden = wifiNet:get("hidden") or info.hidden
    info.bsd = wifiNet:get("bsd") or info.bsd
    info.txbf = wifiDev:get("txbf") or info.txbf
    info.ax = wifiNet:get("ax") or info.ax
    info.bsd = wifiNet:get("bsd") or info.bsd
    info.ssidHtmlEncode = 1
    
    if info.encryption == "ccmp" then
        info.password = wifiNet:get("sae_password")
    end
    
    return info
end

--[[
备份WiFi信息
@param wifiIndex WiFi索引
--]]
function backupWifiInfo(wifiIndex)
    local uci = require("luci.model.uci").cursor()
    local info = getWifiBasicInfo(wifiIndex)
    
    if info then
        uci:section("backup", "backup", "wifi" .. tostring(wifiIndex), info)
        uci:commit("backup")
    end
end

--[[
设置WiFi基本信息
@param wifiIndex WiFi索引
@param ssid SSID名称
@param password 密码
@param encryption 加密方式
@param channel 频道
@param txpwr 发射功率
@param hidden 是否隐藏
@param on 是否开启
@param bandwidth 带宽
@param bsd BSD设置
@param txbf 波束成形
@param weakenable 弱信号踢出启用
@param weakthreshold 弱信号阈值
@param kickthreshold 踢出阈值
@param ax WiFi 6设置
@return boolean 是否成功
--]]
function setWifiBasicInfo(wifiIndex, ssid, password, encryption, channel, txpwr, hidden, on, bandwidth, bsd, txbf, weakenable, weakthreshold, kickthreshold, ax)
    local uci = require("luci.model.uci").cursor()
    local network = LuciNetwork.init()
    local ifaceName = wifiIfaceList[wifiIndex]
    
    if not ifaceName then
        return false
    end
    
    local wifiNet = network:get_wifinet(ifaceName)
    if wifiNet == nil then
        return false
    end
    
    local wifiDev = wifiNet:get_device()
    
    if wifiDev then
        if not XQFunction.isStrNil(channel) then
            wifiDev:set("channel", channel)
        end
        if not XQFunction.isStrNil(bandwidth) then
            wifiDev:set("bw", bandwidth)
        end
        if not XQFunction.isStrNil(txpwr) then
            wifiDev:set("txpwr", txpwr)
        end
        if on == 1 then
            wifiDev:set("disabled", "0")
        end
        if not XQFunction.isStrNil(txbf) then
            if tonumber(txbf) == 3 then
                wifiDev:set("txbf", "3")
            elseif tonumber(txbf) == 0 then
                wifiDev:set("txbf", "0")
            end
        end
        if not XQFunction.isStrNil(ax) then
            if tonumber(ax) == 0 then
                wifiDev:set("ax", "0")
            else
                wifiDev:set("ax", "1")
            end
        end
    end
    
    if on == 1 then
        wifiNet:set("disabled", "0")
    elseif on == 0 then
        wifiNet:set("disabled", "1")
    end
    
    if bsd ~= nil then
        wifiNet:set("bsd", bsd)
        if not XQFunction.isMeshMode() then
            wifiNet:set("rrm", bsd)
            wifiNet:set("wnm", bsd)
        end
    end
    
    if not XQFunction.isStrNil(weakenable) then
        wifiNet:set("weakenable", weakenable)
    end
    if not XQFunction.isStrNil(weakthreshold) then
        wifiNet:set("weakthreshold", weakthreshold)
    end
    if not XQFunction.isStrNil(kickthreshold) then
        wifiNet:set("kickthreshold", kickthreshold)
    end
    
    if not XQFunction.isStrNil(ssid) then
        wifiNet:set("ssid", ssid)
    end
    
    if encryption then
        local checkResult = checkWifiPasswd(password, encryption)
        if checkResult == 0 then
            wifiNet:set("encryption", encryption)
            wifiNet:set("key", password)
            
            if encryption == "none" then
                wifiNet:set("key", "")
                wifiNet:set("sae", "")
                wifiNet:set("sae_password", "")
                wifiNet:set("ieee80211w", "")
            elseif encryption == "wep-open" then
                wifiNet:set("key1", "s:" .. password)
                wifiNet:set("key", 1)
                wifiNet:set("sae", "")
                wifiNet:set("sae_password", "")
                wifiNet:set("ieee80211w", "")
            elseif encryption == "ccmp" then
                wifiNet:set("sae", "1")
                wifiNet:set("key", "")
                wifiNet:set("sae_password", password)
                wifiNet:set("ieee80211w", "2")
            elseif encryption == "psk2+ccmp" then
                wifiNet:set("sae", "1")
                wifiNet:set("key", password)
                wifiNet:set("sae_password", password)
                wifiNet:set("ieee80211w", "1")
            elseif encryption == "psk2" or encryption == "mixed-psk" then
                wifiNet:set("sae", "")
                wifiNet:set("sae_password", "")
                wifiNet:set("ieee80211w", "")
            end
        elseif checkResult > 1502 then
            return false
        end
    end
    
    if hidden == "1" then
        wifiNet:set("hidden", "1")
    end
    if hidden == "0" then
        wifiNet:set("hidden", "0")
    end
    
    network:save("wireless")
    network:commit("wireless")
    
    if wifiIndex == 1 then
        if on == 1 then
            uci:set("wireless", "miot_2G", "disabled", "0")
        elseif on == 0 then
            uci:set("wireless", "miot_2G", "disabled", "1")
        end
        uci:commit("wireless")
    end
    
    return true
end

--[[
设置WiFi区域
@param country 国家代码
@param region 区域代码
@param aregion A区域代码
@return boolean 是否成功
--]]
function setWifiRegion(country, region, aregion)
    if XQFunction.isStrNil(country) or not tonumber(region) or not tonumber(aregion) then
        return false
    end
    
    local network = LuciNetwork.init()
    
    local wifiDev1 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(1), ".")[1])
    local wifiDev2 = network:get_wifidev(LuciUtil.split(_wifiNameForIndex(2), ".")[1])
    
    if wifiDev1 then
        wifiDev1:set("country", country)
        wifiDev1:set("region", region)
        wifiDev1:set("aregion", aregion)
        wifiDev1:set("channel", "0")
        wifiDev1:set("bw", "0")
        wifiDev1:set("autoch", "2")
    end
    
    if wifiDev2 then
        wifiDev2:set("country", country)
        wifiDev2:set("region", region)
        wifiDev2:set("aregion", aregion)
        wifiDev2:set("channel", "0")
        wifiDev2:set("bw", "0")
        wifiDev2:set("autoch", "2")
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
获取BSD(频段切换)信息
@param mac 设备MAC地址
@return table BSD信息
--]]
function getBsdInfo(mac)
    if XQFunction.isStrNil(mac) then
        return nil
    end
    
    local result = {bsd = 0, mode = 0}
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(_wifiNameForIndex(1))
    
    local bsdEnabled = tonumber(wifiNet:get("bsd") or "0")
    local bsdMode = tonumber(wifiNet:get("bsd_maclist_mode") or "0")
    
    if bsdEnabled == 1 then
        result.bsd = 1
        if bsdMode == 0 then
            result.mode = 0
        else
            local bsd2gList = wifiNet:get("bsd_2g")
            local bsd5gList = wifiNet:get("bsd_5g")
            
            if bsd2gList and type(bsd2gList) == "table" then
                for _, listMac in ipairs(bsd2gList) do
                    if string.lower(mac) == string.lower(listMac) then
                        result.mode = 1
                        break
                    end
                end
            end
            
            if bsd5gList and type(bsd5gList) == "table" then
                for _, listMac in ipairs(bsd5gList) do
                    if string.lower(mac) == string.lower(listMac) then
                        result.mode = 2
                        break
                    end
                end
            end
        end
    end
    
    return result
end

--[[
设置BSD MAC列表
@param mac 设备MAC地址
@param mode 模式 (0=自动, 1=仅2.4G, 2=仅5G)
@return table 设置结果
--]]
function setBsdMaclist(mac, mode)
    if XQFunction.isStrNil(mac) or not mode then
        return nil
    end
    
    local result = {bsd = 0, mode = 0}
    local network = LuciNetwork.init()
    local wifiNet1 = network:get_wifinet(_wifiNameForIndex(1))
    local wifiNet2 = network:get_wifinet(_wifiNameForIndex(2))
    
    local bsdEnabled = tonumber(wifiNet1:get("bsd") or "0")
    local bsdMode = tonumber(wifiNet1:get("bsd_maclist_mode") or "0")
    
    if bsdEnabled == 1 then
        result.bsd = 1
        result.mode = mode
        
        if wifiNet1 then
            wifiNet1:set("bsd_maclist_mode", "1")
        end
        if wifiNet2 then
            wifiNet2:set("bsd_maclist_mode", "1")
        end
        
        local bsd2gList = wifiNet1:get("bsd_2g") or {}
        local bsd5gList = wifiNet1:get("bsd_5g") or {}
        
        local idx2g, idx5g = nil, nil
        
        if type(bsd2gList) == "table" then
            for idx, listMac in ipairs(bsd2gList) do
                if string.lower(mac) == string.lower(listMac) then
                    idx2g = idx
                    break
                end
            end
        end
        
        if type(bsd5gList) == "table" then
            for idx, listMac in ipairs(bsd5gList) do
                if string.lower(mac) == string.lower(listMac) then
                    idx5g = idx
                    break
                end
            end
        end
        
        if mode == 0 then
            if idx2g then
                table.remove(bsd2gList, idx2g)
            end
            if idx5g then
                table.remove(bsd5gList, idx5g)
            end
        elseif mode == 1 then
            if not idx2g then
                table.insert(bsd2gList, mac)
            end
            if idx5g then
                table.remove(bsd5gList, idx5g)
            end
        elseif mode == 2 then
            if idx2g then
                table.remove(bsd2gList, idx2g)
            end
            if not idx5g then
                table.insert(bsd5gList, mac)
            end
        end
        
        if #bsd2gList > 0 then
            wifiNet1:set("bsd_2g", bsd2gList)
            if wifiNet2 then
                wifiNet2:set("bsd_2g", bsd2gList)
            end
        else
            wifiNet1:set("bsd_2g", nil)
            if wifiNet2 then
                wifiNet2:set("bsd_2g", nil)
            end
        end
        
        if #bsd5gList > 0 then
            wifiNet1:set("bsd_5g", bsd5gList)
            if wifiNet2 then
                wifiNet2:set("bsd_5g", bsd5gList)
            end
        else
            wifiNet1:set("bsd_5g", nil)
            if wifiNet2 then
                wifiNet2:set("bsd_5g", nil)
            end
        end
        
        network:commit("wireless")
    end
    
    return result
end

--[[
开启WiFi
@param wifiIndex WiFi索引
@return boolean 是否成功
--]]
function turnWifiOn(wifiIndex)
    local status = getWifiStatus(wifiIndex)
    if status.up == 1 then
        return true
    end
    
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(_wifiNameForIndex(wifiIndex))
    local wifiDev = nil
    
    if wifiNet ~= nil then
        wifiDev = wifiNet:get_device()
    end
    
    if wifiDev and wifiNet then
        wifiDev:set("disabled", "0")
        wifiNet:set("disabled", nil)
        network:commit("wireless")
        XQFunction.forkRestartWifi()
        return true
    end
    
    return false
end

--[[
关闭WiFi
@param wifiIndex WiFi索引
@return boolean 是否成功
--]]
function turnWifiOff(wifiIndex)
    local status = getWifiStatus(wifiIndex)
    if status.up == 0 then
        return true
    end
    
    local network = LuciNetwork.init()
    local wifiNet = network:get_wifinet(_wifiNameForIndex(wifiIndex))
    local wifiDev = nil
    
    if wifiNet ~= nil then
        wifiDev = wifiNet:get_device()
    end
    
    if wifiDev and wifiNet then
        wifiDev:set("disabled", "1")
        wifiNet:set("disabled", nil)
        network:commit("wireless")
        XQFunction.forkRestartWifi()
        return true
    end
    
    return false
end

--[[
获取WPS状态
@return number WPS状态码
--]]
function getWifiWpsStatus()
    local util = require("luci.util")
    local status = util.exec(XQConfigs.GET_WPS_STATUS)
    
    if not XQFunction.isStrNil(status) then
        status = util.trim(status)
        return tonumber(status)
    end
    
    return 0
end

--[[
获取WPS连接设备的MAC地址
@return string MAC地址
--]]
function getWpsConDevMac()
    local util = require("luci.util")
    local mac = util.exec(XQConfigs.GET_WPS_CONMAC)
    
    if mac then
        return XQFunction.macFormat(util.trim(mac))
    end
    
    return nil
end

--[[
停止WPS
--]]
function stopWps()
    local util = require("luci.util")
    util.exec(XQConfigs.CLOSE_WPS)
end

--[[
开启WPS
@return string 时间戳
--]]
function openWifiWps()
    local util = require("luci.util")
    local XQPreference = require("xiaoqiang.XQPreference")
    
    util.exec(XQConfigs.OPEN_WPS)
    local timestamp = tostring(os.time())
    XQPreference.set(XQConfigs.PREF_WPS_TIMESTAMP, timestamp)
    
    return timestamp
end

--[[
将RSSI值转换为信号百分比
@param rssi RSSI值
@return number 信号百分比(0-100)
--]]
function miwifiutil_rssi_to_signal(rssi)
    rssi = tonumber(rssi)
    
    if rssi >= 0 then
        rssi = 100
    elseif rssi >= -50 and rssi < 0 then
        rssi = 100
    elseif rssi >= -80 then
        rssi = 24 + (rssi + 80) * 26 / 10
    elseif rssi >= -90 then
        rssi = (rssi + 90) * 26 / 10
    else
        rssi = 0
    end
    
    return math.ceil(rssi)
end

--[[
设置APCLI扫描
@param params 扫描参数
@return string 扫描命令
--]]
function apcli_set_scan(params)
    local ifname = params.scan_ifname
    local ssid = params.ssid
    local cmd = "iwlist " .. ifname .. " scanning"
    return cmd
end

--[[
获取APCLI连接状态
@param ifname 接口名称
@return boolean, string 连接状态和状态信息
--]]
function apcli_get_connect(ifname)
    local status = LuciUtil.exec("wpa_cli -g /var/run/wpa_supplicantglobal ifname=" .. ifname .. " status | grep ^wpa_state= | cut -f2- -d=")
    
    if status:match("COMPLETED") then
        return true, status
    else
        return false, status
    end
end

--[[
设置APCLI为非活动状态
@param ifname 接口名称
--]]
function apcli_set_inactive(ifname)
    local device = apcli_get_device(ifname)
    
    os.execute("wpa_cli -g /var/run/wpa_supplicantglobal interface_remove " .. ifname)
    os.execute("ifconfig " .. ifname .. " down")
    os.execute("wlanconfig " .. ifname .. " destroy -cfg80211")
    os.execute("iw dev " .. ifname .. " del")
end

--[[
禁用Mesh网络
--]]
function miwifi_mesh_disable()
    local network = LuciNetwork.init()
    
    for _, ifaceName in ipairs(wifiIfaceList) do
        local wifiNet = network:get_wifinet(ifaceName)
        if wifiNet then
            wifiNet:set("miwifi_mesh", 0)
        end
    end
    
    network:commit("wireless")
    network:save("wireless")
end

--[[
设置TWT(目标唤醒时间)
@param enable 启用状态 (0=关闭, 1=开启)
@return boolean 是否成功
--]]
function set_twt_hostap(enable)
    local network = LuciNetwork.init()
    
    if enable == nil and (enable ~= 1 or enable ~= 0) then
        return false
    end
    
    for _, ifaceName in ipairs(wifiIfaceList) do
        local wifiNet = network:get_wifinet(ifaceName)
        if wifiNet then
            wifiNet:set("twt_responder", enable)
        end
    end
    
    network:commit("wireless")
    network:save("wireless")
    
    return true
end

--[[
获取TWT状态
@return number TWT状态 (0=关闭, 1=开启)
--]]
function get_twt_hostap()
    local network = LuciNetwork.init()
    
    for _, ifaceName in ipairs(wifiIfaceList) do
        local wifiNet = network:get_wifinet(ifaceName)
        if wifiNet then
            local twt = wifiNet:get("twt_responder")
            if twt == nil then
                return 1
            else
                return twt
            end
        end
    end
    
    return nil
end

--[[
检查WiFi 6(802.11ax)是否启用
@return number ax状态
--]]
function ax_enabled()
    local netInfo = wifiNetwork(_wifiNameForIndex(2))
    local ax = netInfo.ax or ax
    return tonumber(ax)
end

--[[
获取游戏WiFi功能状态
@return number 游戏WiFi状态
--]]
function get_wifi_game()
    local game = uciCursor:get("misc", "features", "game") or game
    return tonumber(game)
end

init()
