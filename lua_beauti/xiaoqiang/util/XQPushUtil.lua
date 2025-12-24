---
--- XQPushUtil 推送工具模块
--- 小米路由器推送通知和设备认证管理工具
--- 功能：推送设置、时间戳管理、认证失败记录、管理设备管理
---

module("xiaoqiang.util.XQPushUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")

--- 获取推送设置
--- @return table 推送设置信息 {auth=是否需要认证, quiet=静默模式, level=级别, count=设备数量}
function pushSettings()
    local uci = require("luci.model.uci").cursor()
    local settings = {
        auth = true,
        quiet = false,
        level = 2
    }
    
    local deviceSettings = uci:get_all("devicelist", "settings")
    local deviceList = uci:get_all("devicelist")
    local deviceList2 = uci:get_all()
    
    local deviceCount = 0
    
    if deviceList then
        for key, value in pairs(deviceList) do
            if key then
                local numValue = tonumber(value)
                if numValue then
                    local isHidden = key:match("^%.")
                    if not isHidden then
                        deviceCount = deviceCount + tonumber(value)
                    end
                end
            end
        end
    end
    
    if deviceList2 then
        for key, value in pairs(deviceList2) do
            if key then
                local numValue = tonumber(value)
                if numValue then
                    local isHidden = key:match("^%.")
                    if not isHidden then
                        deviceCount = deviceCount + tonumber(value)
                    end
                end
            end
        end
    end
    
    settings.count = deviceCount
    
    if deviceSettings then
        if deviceSettings.auth == 0 then
            settings.auth = false
        else
            settings.auth = true
        end
        settings.quiet = deviceSettings.quiet
        settings.level = deviceSettings.level
    end
    
    return settings
end

--- 设置推送配置
--- @param key string 配置键名
--- @param value any 配置值
function pushConfig(key, value)
    local uci = require("luci.model.uci").cursor()
    local settings = uci:get_all("devicelist", "settings")
    
    if settings then
        settings[key] = value
    else
        settings = {}
        settings[key] = value
    end
    
    uci:section("devicelist", "core", "settings", settings)
    uci:commit("devicelist")
end

--- 获取时间戳
--- @param key string 时间戳键名
--- @return number 时间戳值
function getTimestamp(key)
    local uci = require("luci.model.uci").cursor()
    local timestamp = uci:get("devicelist", "timestamp", key)
    return tonumber(timestamp) or 0
end

--- 设置时间戳
--- @param key string 时间戳键名
--- @param value number 时间戳值
--- @return boolean 是否设置成功
function setTimestamp(key, value)
    if not key or not value then
        return
    end
    
    local uci = require("luci.model.uci").cursor()
    local timestamps = uci:get_all("devicelist", "timestamp")
    
    if not timestamps then
        timestamps = {}
    end
    
    timestamps[key] = value
    uci:section("devicelist", "record", "timestamp", timestamps)
    
    if not uci:commit("devicelist") then
        return false
    end
    
    return true
end

--- 获取认证失败次数字典
--- @return table MAC地址到失败次数的映射
function getAuthenFailedTimesDict()
    local uci = require("luci.model.uci").cursor()
    local authFailDict = uci:get_all("devicelist", "authfail")
    return authFailDict or {}
end

--- 获取WiFi认证连续失败次数
--- @param macAddr string MAC地址
--- @return number 连续失败次数
function getwifiauthfailedserialtimes(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local serialData = uci:get_all("devicelist", "authfailserial")
    
    if not serialData then
        uci:section("devicelist", "record", "authfailserial", {})
        uci:commit("devicelist")
        return 0
    else
        local times = uci:get("devicelist", "authfailserial", macKey)
        if times then
            if tonumber(times) then
                return tonumber(times)
            end
        else
            return 0
        end
    end
end

--- 设置WiFi认证连续失败次数
--- @param macAddr string MAC地址
--- @param times number 失败次数
function setwifiauthfailedserialtimes(macAddr, times)
    if XQFunction.isStrNil(macAddr) or not tonumber(times) then
        return
    end
    
    macAddr = XQFunction.macFormat(macAddr)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local serialData = uci:get_all("devicelist", "authfailserial")
    
    if not serialData then
        serialData = {}
    end
    
    serialData[macKey] = times
    uci:section("devicelist", "record", "authfailserial", serialData)
    uci:commit("devicelist")
end

--- 获取认证失败次数
--- @param macAddr string MAC地址
--- @return number 失败次数
function getAuthenFailedTimes(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local authFailData = uci:get_all("devicelist", "authfail")
    
    if not authFailData then
        uci:section("devicelist", "record", "authfail", {})
        uci:commit("devicelist")
        return 0
    else
        local times = uci:get("devicelist", "authfail", macKey)
        if times then
            if tonumber(times) then
                return tonumber(times)
            end
        else
            return 0
        end
    end
end

--- 设置认证失败次数
--- @param macAddr string MAC地址
--- @param times number 失败次数
function setAuthenFailedTimes(macAddr, times)
    if XQFunction.isStrNil(macAddr) or not tonumber(times) then
        return
    end
    
    macAddr = XQFunction.macFormat(macAddr)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local authFailData = uci:get_all("devicelist", "authfail")
    
    if not authFailData then
        authFailData = {}
    end
    
    authFailData[macKey] = times
    uci:section("devicelist", "record", "authfail", authFailData)
    uci:commit("devicelist")
end

--- 获取WiFi认证失败频率字典
--- @return table MAC地址到失败频率的映射
function getWifiAuthenFailedFrequencyDict()
    local uci = require("luci.model.uci").cursor()
    local freqDict = uci:get_all("devicelist", "wififrequency")
    return freqDict or {}
end

--- 获取WiFi认证失败频率
--- @param macAddr string MAC地址
--- @return number 失败频率
function getWifiAuthenFailedFrequency(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local freqData = uci:get_all("devicelist", "wififrequency")
    
    if not freqData then
        uci:section("devicelist", "record", "wififrequency", {})
        uci:commit("devicelist")
        return 0
    else
        local freq = uci:get("devicelist", "wififrequency", macKey)
        if freq then
            if tonumber(freq) then
                return tonumber(freq)
            end
        else
            return 0
        end
    end
end

--- 设置WiFi认证失败频率
--- @param macAddr string MAC地址
--- @param freq number 失败频率
function setWifiAuthenFailedFrequency(macAddr, freq)
    if XQFunction.isStrNil(macAddr) or not tonumber(freq) then
        return
    end
    
    macAddr = XQFunction.macFormat(macAddr)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local freqData = uci:get_all("devicelist", "wififrequency")
    
    if not freqData then
        freqData = {}
    end
    
    freqData[macKey] = freq
    uci:section("devicelist", "record", "wififrequency", freqData)
    uci:commit("devicelist")
end

--- 获取登录认证失败次数
--- @param macAddr string MAC地址
--- @return number 失败次数
function getLoginAuthenFailedTimes(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local loginFailData = uci:get_all("devicelist", "loginauthfail")
    
    if not loginFailData then
        uci:section("devicelist", "record", "loginauthfail", {})
        uci:commit("devicelist")
        return 0
    else
        local times = uci:get("devicelist", "loginauthfail", macKey)
        if times then
            if tonumber(times) then
                return tonumber(times)
            end
        else
            return 0
        end
    end
end

--- 设置登录认证失败次数
--- @param macAddr string MAC地址
--- @param times number 失败次数
function setLoginAuthenFailedTimes(macAddr, times)
    if XQFunction.isStrNil(macAddr) or not tonumber(times) then
        return
    end
    
    macAddr = XQFunction.macFormat(macAddr)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local loginFailData = uci:get_all("devicelist", "loginauthfail")
    
    if not loginFailData then
        loginFailData = {}
    end
    
    loginFailData[macKey] = times
    uci:section("devicelist", "record", "loginauthfail", loginFailData)
    uci:commit("devicelist")
end

--- 获取登录认证失败频率
--- @param macAddr string MAC地址
--- @return number 失败频率
function getLoginAuthenFailedFrequency(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local loginFreqData = uci:get_all("devicelist", "loginfrequency")
    
    if not loginFreqData then
        uci:section("devicelist", "record", "loginfrequency", {})
        uci:commit("devicelist")
        return 0
    else
        local freq = uci:get("devicelist", "loginfrequency", macKey)
        if freq then
            if tonumber(freq) then
                return tonumber(freq)
            end
        else
            return 0
        end
    end
end

--- 设置登录认证失败频率
--- @param macAddr string MAC地址
--- @param freq number 失败频率
function setLoginAuthenFailedFrequency(macAddr, freq)
    if XQFunction.isStrNil(macAddr) or not tonumber(freq) then
        return
    end
    
    macAddr = XQFunction.macFormat(macAddr)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local loginFreqData = uci:get_all("devicelist", "loginfrequency")
    
    if not loginFreqData then
        loginFreqData = {}
    end
    
    loginFreqData[macKey] = freq
    uci:section("devicelist", "record", "loginfrequency", loginFreqData)
    uci:commit("devicelist")
end

--- 检查特殊通知状态
--- @param macAddr string MAC地址
--- @return boolean 是否有通知
--- @return number 通知级别
function specialNotify(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return false, 0
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local notifyLevel = uci:get("devicelist", "notify", macKey)
    
    if notifyLevel then
        if tonumber(notifyLevel) then
            return true, tonumber(notifyLevel)
        end
    end
    
    return false, 0
end

--- 设置特殊通知
--- @param macAddr string MAC地址
--- @param enable boolean 是否启用
--- @param level number 通知级别
--- @return boolean 是否设置成功
function setSpecialNotify(macAddr, enable, level)
    if XQFunction.isStrNil(macAddr) then
        if tonumber(level) then
            return false
        end
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local uci = require("luci.model.uci").cursor()
    local macKey = macAddr:gsub(":", "")
    local notifyData = uci:get_all("devicelist", "notify")
    
    if not notifyData then
        uci:section("devicelist", "record", "notify", {})
        if not uci:commit("devicelist") then
            return false
        end
    end
    
    if enable then
        local existingNotify = uci:get("devicelist", "notify", macKey)
        if not existingNotify then
            uci:set("devicelist", "notify", macKey, 1)
            if not uci:commit("devicelist") then
                return false
            end
        else
            uci:set("devicelist", "notify", macKey, level)
            if not uci:commit("devicelist") then
                return false
            end
        end
    else
        uci:delete("devicelist", "notify", macKey)
        if not uci:commit("devicelist") then
            return false
        end
    end
    
    return true
end

--- 获取通知字典
--- @return table MAC地址到通知状态的映射
function notifyDict()
    local result = {}
    local uci = require("luci.model.uci").cursor()
    local notifyData = uci:get_all("devicelist", "notify")
    
    if notifyData then
        for mac, value in pairs(notifyData) do
            if tonumber(value) then
                result[mac] = 1
            end
        end
    end
    
    return result
end

--- 获取管理设备信息
--- @param deviceId string 设备ID
--- @return number 管理设备状态
function getAdminDevice(deviceId)
    local uci = require("luci.model.uci").cursor()
    
    if deviceId then
        return tonumber(uci:get("devicelist", "admin", deviceId))
    end
    
    return nil
end

--- 获取所有管理设备
--- @return table 设备ID到状态的映射
function getAdminDevices()
    local result = {}
    local uci = require("luci.model.uci").cursor()
    local adminData = uci:get_all("devicelist", "admin")
    
    if adminData then
        for deviceId, value in pairs(adminData) do
            if tonumber(value) then
                result[deviceId] = tonumber(value)
            end
        end
    end
    
    return result
end

--- 设置管理设备
--- @param deviceId string 设备ID
--- @param status string 设备状态
function setAdminDevice(deviceId, status)
    local uci = require("luci.model.uci").cursor()
    local adminData = uci:get_all("devicelist", "admin")
    
    if not adminData then
        uci:section("devicelist", "record", "admin", {})
        uci:commit("devicelist")
    end
    
    local existingStatus = uci:get("devicelist", "admin", deviceId)
    
    if existingStatus then
        if tonumber(status) then
            uci:set("devicelist", "admin", deviceId, status)
        end
    else
        local newStatus = status or "0"
        uci:set("devicelist", "admin", deviceId, newStatus)
    end
    
    uci:commit("devicelist")
end
