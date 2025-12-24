--[[
  防蹭网模块 (Anti-Rub Network Module)
  提供 WiFi 认证失败、登录认证失败等安全事件的追踪和缓存管理
  用于检测和防止未授权设备尝试连接网络
]]
module("xiaoqiang.module.XQAntiRubNetwork", package.seeall)

local nixio = require("nixio")
local nixioFs = require("nixio.fs")
local luciSys = require("luci.sys")
local xqFunction = require("xiaoqiang.common.XQFunction")

local CACHE_PATH = "/tmp/authenfailed-cache"

local DEFAULT_CONFIG = {
    interval = 60,
    blackltd = 30,
    wifi = 30,
    wifib = 5,
    llogin = 5,
    hlogin = 5
}

function _sane(path)
    local currentUid = nixio.process.info("uid")
    local fileUid = nixioFs.stat(path or CACHE_PATH, "uid")
    return currentUid == fileUid
end

function _prepare()
    nixioFs.mkdir(CACHE_PATH, 700)
    if not _sane() then
        return false
    end
end

function _read(filename)
    local content = nixioFs.readfile(CACHE_PATH .. "/" .. filename)
    return content
end

function read(filename, interval)
    if not filename or #filename == 0 then
        return nil
    end
    
    interval = interval or DEFAULT_CONFIG.interval
    
    local fullPath = CACHE_PATH .. "/" .. filename
    if not _sane(fullPath) then
        return nil
    end
    
    local content = _read(filename)
    local loadFunc = loadstring(content)
    setfenv(loadFunc, {})
    local data = loadFunc()
    
    if type(data) ~= "table" then
        return nil
    end
    
    local uptime = luciSys.uptime()
    local elapsed = uptime - data.atime
    elapsed = elapsed or 0
    
    if interval < elapsed then
        local doubleInterval = interval * 2
        if elapsed < doubleInterval then
            data.expired = true
            data.old = false
            kill(filename)
        end
    else
        local doubleInterval = interval * 2
        if elapsed > doubleInterval then
            data.expired = true
            data.old = true
            kill(filename)
        else
            data.expired = false
            data.old = false
        end
    end
    
    return data
end

function _write(filename, content)
    local uniqueId = xqFunction.uniqueid(16)
    local tempPath = CACHE_PATH .. "/" .. uniqueId
    local targetPath = CACHE_PATH .. "/" .. filename
    
    local file = nixio.open(tempPath, "w", 600)
    file:writeall(content)
    file:close()
    
    nixioFs.rename(tempPath, targetPath)
end

function write(filename, data)
    if not _sane() then
        _prepare()
    end
    
    if type(data) ~= "table" then
        return
    end
    
    local bytecode = luci.util.get_bytecode(data)
    _write(filename, bytecode)
end

function kill(filename)
    if filename then
        nixioFs.unlink(CACHE_PATH .. "/" .. filename)
    end
end

function reap()
    if _sane() then
        for filename in nixioFs.dir(CACHE_PATH) do
            read(filename)
        end
    end
end

function isIgnored(mac, authType)
    if xqFunction.isStrNil(mac) or xqFunction.isStrNil(authType) then
        return
    end
    
    mac = xqFunction.macFormat(mac)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = mac:gsub(":", "")
    
    if authType == "login" then
        local loginIgnore = uci:get_all("devicelist", "login_ignore")
        if not loginIgnore then
            uci:section("devicelist", "record", "login_ignore", {})
            uci:commit("devicelist")
            return false
        else
            local ignored = uci:get("devicelist", "login_ignore", macKey)
            return ignored and true or false
        end
    elseif authType == "wifi" then
        local wifiIgnore = uci:get_all("devicelist", "wifi_ignore")
        if not wifiIgnore then
            uci:section("devicelist", "record", "wifi_ignore", {})
            uci:commit("devicelist")
            return false
        else
            local ignored = uci:get("devicelist", "wifi_ignore", macKey)
            return ignored and true or false
        end
    end
end

function ignoreDevice(mac, authType)
    if xqFunction.isStrNil(mac) or xqFunction.isStrNil(authType) then
        return
    end
    
    mac = xqFunction.macFormat(mac)
    
    local uci = require("luci.model.uci").cursor()
    local macKey = mac:gsub(":", "")
    
    if authType == "login" then
        local loginIgnore = uci:get_all("devicelist", "login_ignore")
        if not loginIgnore then
            local section = {}
            section[macKey] = "1"
            uci:section("devicelist", "record", "login_ignore", section)
            uci:commit("devicelist")
        else
            uci:set("devicelist", "login_ignore", macKey, "1")
            uci:commit("devicelist")
        end
    elseif authType == "wifi" then
        local wifiIgnore = uci:get_all("devicelist", "wifi_ignore")
        if not wifiIgnore then
            local section = {}
            section[macKey] = "1"
            uci:section("devicelist", "record", "wifi_ignore", section)
            uci:commit("devicelist")
        else
            uci:set("devicelist", "wifi_ignore", macKey, "1")
            uci:commit("devicelist")
        end
    end
end

function setWifiAuthenFailedCache(mac)
    if xqFunction.isStrNil(mac) then
        return false
    end
    
    local cacheKey = "WIFI-" .. mac:gsub(":", "")
    local cacheData = {
        mac = mac,
        count = 1,
        warning = false,
        atime = luciSys.uptime()
    }
    
    write(cacheKey, cacheData)
end

function getWifiAuthenFailedCache(mac)
    if xqFunction.isStrNil(mac) then
        return nil
    end
    
    local cacheKey = "WIFI-" .. mac:gsub(":", "")
    local cacheData = read(cacheKey)
    
    if cacheData then
        if not cacheData.expired then
            cacheData.count = cacheData.count + 1
            write(cacheKey, cacheData)
        end
    end
    
    if cacheData then
        if cacheData.expired and not cacheData.old then
            if cacheData.count >= DEFAULT_CONFIG.wifi then
                cacheData.warning = true
            end
        end
    end
    
    return cacheData
end

function wifiAuthenFailedAction(mac)
    local pushUtil = require("xiaoqiang.util.XQPushUtil")
    
    if xqFunction.isStrNil(mac) then
        return nil
    else
        mac = xqFunction.macFormat(mac)
    end
    
    if isIgnored(mac, "wifi") then
        return nil
    end
    
    local pushSettings = pushUtil.pushSettings()
    local failedTimes = pushUtil.getAuthenFailedTimes(mac)
    
    if pushSettings.auth then
        local cacheData = getWifiAuthenFailedCache(mac)
        if not cacheData then
            setWifiAuthenFailedCache(mac)
        else
            local frequency = math.floor(cacheData.count / 6)
            if cacheData.expired then
                if cacheData.warning then
                    pushUtil.setAuthenFailedTimes(mac, failedTimes + frequency)
                    pushUtil.setWifiAuthenFailedFrequency(mac, frequency)
                    pushUtil.setwifiauthfailedserialtimes(mac, pushUtil.getwifiauthfailedserialtimes(mac) + 1)
                    return frequency
                end
            else
                if cacheData.expired and not cacheData.warning then
                    pushUtil.setAuthenFailedTimes(mac, failedTimes + frequency)
                    pushUtil.setwifiauthfailedserialtimes(mac, 0)
                end
            end
        end
    end
    
    return nil
end

function setWifiBlacklistedCache(mac)
    if xqFunction.isStrNil(mac) then
        return false
    end
    
    local cacheKey = "BLACKLISTED-" .. mac:gsub(":", "")
    local cacheData = {
        mac = mac,
        count = 1,
        warning = false,
        atime = luciSys.uptime()
    }
    
    write(cacheKey, cacheData)
end

function getWifiBlacklistedCache(mac)
    if xqFunction.isStrNil(mac) then
        return nil
    end
    
    local cacheKey = "BLACKLISTED-" .. mac:gsub(":", "")
    local cacheData = read(cacheKey, 15)
    
    if cacheData then
        if not cacheData.expired then
            cacheData.count = cacheData.count + 1
            write(cacheKey, cacheData)
        end
    end
    
    if cacheData then
        if cacheData.expired and not cacheData.old then
            if cacheData.count >= DEFAULT_CONFIG.wifib then
                cacheData.warning = true
            end
        end
    end
    
    return cacheData
end

function wifiBlacklistedAction(mac)
    local pushUtil = require("xiaoqiang.util.XQPushUtil")
    
    if xqFunction.isStrNil(mac) then
        return nil
    else
        mac = xqFunction.macFormat(mac)
    end
    
    if isIgnored(mac, "wifi") then
        return nil
    end
    
    local pushSettings = pushUtil.pushSettings()
    local failedTimes = pushUtil.getAuthenFailedTimes(mac)
    
    if pushSettings.auth then
        local cacheData = getWifiBlacklistedCache(mac)
        if not cacheData then
            setWifiBlacklistedCache(mac)
        else
            local frequency = math.floor(cacheData.count / 4)
            if cacheData.expired then
                if cacheData.warning then
                    pushUtil.setAuthenFailedTimes(mac, failedTimes + frequency)
                    return frequency
                end
            else
                if cacheData.expired and not cacheData.warning then
                    pushUtil.setAuthenFailedTimes(mac, failedTimes + frequency)
                end
            end
        end
    end
    
    return nil
end

function setLoginAuthenFailedCache(mac)
    if xqFunction.isStrNil(mac) then
        return false
    end
    
    local cacheKey = "LOGIN-" .. mac:gsub(":", "")
    local cacheData = {
        mac = mac,
        count = 1,
        warning = false,
        atime = luciSys.uptime()
    }
    
    write(cacheKey, cacheData)
end

function getLoginAuthenFailedCache(mac)
    if xqFunction.isStrNil(mac) then
        return nil, nil
    end
    
    local pushUtil = require("xiaoqiang.util.XQPushUtil")
    local pushLevel = tonumber(pushUtil.pushSettings().level)
    
    local cacheKey = "LOGIN-" .. mac:gsub(":", "")
    local cacheData = read(cacheKey)
    
    if cacheData then
        if not cacheData.expired then
            cacheData.count = cacheData.count + 1
            write(cacheKey, cacheData)
        end
    end
    
    if cacheData then
        if cacheData.count >= DEFAULT_CONFIG.llogin then
            if not cacheData.expired then
                cacheData.warning = true
                return cacheData
            end
        end
    end
    
    if cacheData then
        if cacheData.expired and not cacheData.old then
            if pushLevel == 2 then
                if cacheData.count >= DEFAULT_CONFIG.llogin then
                    cacheData.warning = true
                end
            end
            if pushLevel == 3 then
                if cacheData.count >= DEFAULT_CONFIG.hlogin then
                    cacheData.warning = true
                end
            end
        end
    end
    
    return cacheData
end

function LoginAuthenFailedAction(mac)
    local pushUtil = require("xiaoqiang.util.XQPushUtil")
    
    if xqFunction.isStrNil(mac) then
        return nil
    else
        mac = xqFunction.macFormat(mac)
    end
    
    if isIgnored(mac, "login") then
        return nil
    end
    
    local pushSettings = pushUtil.pushSettings()
    local failedTimes = pushUtil.getLoginAuthenFailedTimes(mac)
    local cacheData = getLoginAuthenFailedCache(mac)
    
    if not cacheData then
        setLoginAuthenFailedCache(mac)
    else
        if cacheData.warning then
            pushUtil.setLoginAuthenFailedTimes(mac, failedTimes + cacheData.count)
            pushUtil.setLoginAuthenFailedFrequency(mac, cacheData.count)
            return cacheData.count
        else
            if cacheData.expired and not cacheData.warning then
                pushUtil.setLoginAuthenFailedTimes(mac, failedTimes + cacheData.count)
            end
        end
    end
    
    return nil
end
