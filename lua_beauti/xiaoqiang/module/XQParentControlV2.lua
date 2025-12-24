--[[
  家长控制模块 V2 (Parent Control Module V2)
  提供基于 mipctl 服务的家长控制功能
  支持用户管理、设备绑定、时间限制、应用控制等功能
]]
module("xiaoqiang.module.XQParentControlV2", package.seeall)

local MAX_TIME_QUOTA = 10080

local xqFunction = require("xiaoqiang.common.XQFunction")
local cjson = require("cjson")
local uci = require("luci.model.uci").cursor()
local mipctlUci = require("luci.model.uci").cursor("/etc/mipctl")

local deletedUserIds = {}
local deviceMacSet = nil

local MIPCTL_USER_CONFIG = "mipctl_user"
local MIPCTL_APP_CONFIG = "mipctl_app"
local MIPCTL_UPG_INFO = "mipctl_upg_info"

local MAX_USER_NAME_WIDTH = 5
local MAX_ICON_NAME_WIDTH = 12
local PCTL_DB_PATH = "/etc/xqDb"
local PCTL_USER_STAT = "pctl_user_stat"
local PCTL_APPCLASS_STAT = "pctl_appclass_stat"

function get_timezone_offset()
    local utcTime = os.date("!*t")
    local localTime = os.date("*t")
    localTime.isdst = false
    return os.difftime(os.time(localTime), os.time(utcTime))
end

function isInt(value)
    return type(value) == "number"
end

function setList(config, section, option, list)
    if #list == 0 then
        mipctlUci:delete(config, section, option)
        return true
    else
        return mipctlUci:set_list(config, section, option, list)
    end
end

function isTempBan(user)
    return user.temp_ban ~= nil and "1" == user.temp_ban
end

function isOnline(devices)
    if devices == nil then
        return false
    end
    
    local luciUtil = require("luci.util")
    local onlineMacs = {}
    local hwList = luciUtil.exec("ubus call trafficd hw")
    
    if not hwList then
        return false
    end
    
    local hwData = cjson.decode(hwList)
    for _, hw in ipairs(hwData or {}) do
        onlineMacs[hw] = true
    end
    
    for _, device in ipairs(devices or {}) do
        if onlineMacs[device.hw] and device.assoc == 1 then
            return true
        end
    end
    
    return false
end

function allowAccess(userId)
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local result = conn:call("mipctl", "is_allow_access", { user_id = userId })
        conn:close()
        
        if result then
            return result.result
        end
    end
    
    return true
end

function cal_nxt_permit_time(userId)
    local result = {}
    local dateStr = os.date("h%Hm%Mu%us%s")
    
    local hourStr = dateStr:sub(dateStr:find("h[0-9]+"))
    local hour = tonumber(hourStr:sub(2))
    local currentMins = hour * 60
    
    local minStr = dateStr:sub(dateStr:find("m[0-9]+"))
    local mins = tonumber(minStr:sub(2))
    currentMins = currentMins + mins
    
    local secStr = dateStr:sub(dateStr:find("u[0-9]+"))
    local secs = tonumber(secStr:sub(2))
    
    local timestampStr = dateStr:sub(dateStr:find("s[0-9]+"))
    local timestamp = tonumber(timestampStr:sub(2))
    
    local tzOffset = get_timezone_offset()
    local dayCount = 0
    local currentDay = math.floor((timestamp + tzOffset) / 86400)
    local banCount = 0
    local remainMins = 1440 - currentMins
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_time_ban", function(section)
        if tonumber(section.user_id) == userId then
            local enable = section.enable
            for day = 1, 7 do
                local dayEnabled = enable:sub(day, day)
                if dayEnabled == "1" then
                    local dayOffset = day - currentDay
                    local baseOffset = 1440 * dayOffset - currentMins
                    
                    local startMins = baseOffset + tonumber(section.start)
                    startMins = math.fmod(startMins + MAX_TIME_QUOTA, MAX_TIME_QUOTA)
                    
                    local endMins = baseOffset + tonumber(section["end"])
                    endMins = math.fmod(endMins + MAX_TIME_QUOTA, MAX_TIME_QUOTA)
                    
                    if startMins > endMins then
                        banCount = banCount + 1
                    end
                    
                    table.insert(result, { delta = 1, offst = startMins })
                    table.insert(result, { delta = -1, offst = endMins })
                end
            end
        end
    end)
    
    table.sort(result, function(a, b) return a.offst < b.offst end)
    
    local activeCount = 0
    local lastOffset = 0
    
    for _, item in ipairs(result) do
        if lastOffset <= remainMins and item.offst > remainMins and activeCount == 0 then
            return os.date("%m/%d/%Y-%R-1", remainMins * 60 + timestamp)
        end
        
        lastOffset = item.offst
        activeCount = activeCount + item.delta
        
        if activeCount == 0 then
            local permitTime = item.offst * 60 + timestamp
            local permitDay = math.floor((permitTime + tzOffset) / 86400)
            local dayDiff = tostring(permitDay - currentDay)
            return os.date("%m/%d/%Y-%R-", permitTime) .. dayDiff
        end
    end
    
    return nil
end

function getPctlUserList()
    local result = {}
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        local user = {}
        user.user_id = tonumber(section.user_id)
        user.user_name = section.user_name
        user.icon = section.icon_id
        
        if isTempBan(section) then
            user.status = -1
        else
            if not allowAccess(tonumber(section.user_id)) then
                user.status = -1
            else
                if isOnline(section.device) then
                    user.status = 1
                else
                    user.status = 0
                end
            end
        end
        
        table.insert(result, user)
    end)
    
    return result
end

function calStrWidth(str)
    local width = 0
    local isMultiByte = true
    
    for i = 1, #str do
        local byte = string.byte(str, i, i)
        if byte < 128 then
            if not isMultiByte then
                width = width + 2
            end
            width = width + 1
            isMultiByte = true
        elseif byte >= 192 then
            if not isMultiByte then
                width = width + 2
            end
            isMultiByte = false
        end
    end
    
    if not isMultiByte then
        width = width + 2
    end
    
    return width
end

function checkUserName(userName)
    if type(userName) ~= "string" then
        return -1672
    end
    
    if calStrWidth(userName) > 12 then
        return -1668
    end
    
    local matched = string.match(userName, "[^\n]+")
    if matched ~= userName then
        return -1663
    end
    
    return 0
end

function checkName(name)
    if type(name) ~= "string" then
        return -1672
    end
    
    local matched = string.match(name, "[^<>:/\\|?*%%&^\n]+")
    if matched ~= name then
        return -1672
    end
    
    return 0
end

function addUser(params)
    local result = {}
    local userCount = 0
    local maxUsers = tonumber(mipctlUci:get(MIPCTL_USER_CONFIG, "meta", "user_max"))
    local existingIds = {}
    local newUserId = nil
    local errorCode = 0
    
    if errorCode == 0 then
        local nameCheck = checkUserName(params.user_name)
        errorCode = nameCheck ~= 0 and nameCheck or errorCode
    end
    
    if errorCode == 0 then
        local iconCheck = checkName(params.icon)
        errorCode = iconCheck ~= 0 and iconCheck or errorCode
    end
    
    if errorCode ~= 0 then
        return errorCode
    end
    
    local userName = params.user_name
    local iconId = params.icon
    
    if maxUsers == nil then
        return -1673
    end
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        table.insert(existingIds, tonumber(section.user_id))
        userCount = userCount + 1
    end)
    
    if userCount == maxUsers then
        return -1662
    end
    
    table.sort(existingIds)
    newUserId = userCount + 1
    
    for i, id in ipairs(existingIds) do
        if i ~= id then
            newUserId = i
            break
        end
    end
    
    local sectionName = mipctlUci:add(MIPCTL_USER_CONFIG, "user")
    if sectionName then
        mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "user_id", newUserId)
        mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "user_name", userName)
        mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "icon_id", iconId)
    else
        return -1673
    end
    
    result.user_id = newUserId
    return 0, result
end

function findUser(userId)
    local sectionName = nil
    local userData = nil
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        if tonumber(section.user_id) == userId then
            sectionName = section[".name"]
            userData = section
        end
    end)
    
    return sectionName, userData
end

function delUser(params)
    local result = 0
    local userId = params.user_id or 0
    
    if not isInt(userId) then
        return -1672
    end
    
    local sectionName = findUser(userId)
    if not sectionName then
        return -1664
    end
    
    result = mipctlUci:delete(MIPCTL_USER_CONFIG, sectionName) and 0 or -1673
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_time_ban", function(section)
        if tonumber(section.user_id) == userId then
            if result == 0 then
                result = mipctlUci:delete(MIPCTL_USER_CONFIG, section[".name"]) and 0 or -1673
            end
        end
    end)
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_class_config", function(section)
        if tonumber(section.user_id) == userId then
            if result == 0 then
                result = mipctlUci:delete(MIPCTL_USER_CONFIG, section[".name"]) and 0 or -1673
            end
        end
    end)
    
    if result ~= 0 then
        return -1673
    end
    
    table.insert(deletedUserIds, userId)
    return 0
end

function editUser(params)
    local result = 0
    local userId = params.user_id or 0
    
    if result == 0 then
        local nameCheck = checkUserName(params.user_name)
        result = nameCheck ~= 0 and nameCheck or result
    end
    
    if result == 0 then
        local iconCheck = checkName(params.icon)
        result = iconCheck ~= 0 and iconCheck or result
    end
    
    if result ~= 0 then
        return result
    end
    
    local userName = params.user_name
    local iconName = params.icon
    
    if not isInt(userId) then
        return -1672
    end
    
    local sectionName = findUser(userId)
    if not sectionName then
        return -1664
    end
    
    result = mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "user_name", userName) and 0 or -1673
    if result == 0 then
        result = mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "icon_id", iconName) and 0 or -1673
    end
    
    return result == 0 and 0 or -1673
end

function getDev()
    local result = {}
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        local user = {}
        user.user_id = tonumber(section.user_id)
        user.devices = section.device or {}
        table.insert(result, user)
    end)
    
    return result
end

function checkDevListFormat(devices)
    local luciUtil = require("luci.util")
    
    if type(devices) ~= "table" then
        return nil
    end
    
    if devices then
        for i, mac in ipairs(devices) do
            if not luciUtil.macaddr(mac) then
                return nil
            end
            devices[i] = mac:upper()
        end
    end
    
    return devices
end

function setDev(params)
    local result = 0
    local userId = params.user_id or 0
    local devices = checkDevListFormat(params.devices)
    
    if not isInt(userId) or not devices then
        return -1672
    end
    
    local sectionName = nil
    local deviceExists = false
    local existingDevices = {}
    local maxDevPerUser = tonumber(mipctlUci:get(MIPCTL_USER_CONFIG, "meta", "dev_per_user"))
    
    if not maxDevPerUser then
        return -1673
    end
    
    for _, mac in ipairs(devices) do
        existingDevices[mac] = true
    end
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        local userDevices = section.device or {}
        if tonumber(section.user_id) == userId then
            sectionName = section[".name"]
        else
            for _, mac in ipairs(userDevices) do
                if existingDevices[mac] then
                    deviceExists = true
                end
            end
        end
    end)
    
    if deviceExists then
        return -1672
    end
    
    if not sectionName then
        return -1664
    end
    
    if #devices > maxDevPerUser then
        return -1665
    end
    
    result = mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "device", devices) and 0 or -1673
    
    if result ~= 0 then
        return -1673
    end
    
    if deviceMacSet == nil then
        deviceMacSet = {}
    end
    
    for _, mac in ipairs(devices) do
        deviceMacSet[mac] = true
    end
    
    return 0
end

function getTimeList(userId)
    local result = {}
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_time_ban", function(section)
        local enableList = {}
        section.enable:gsub(".", function(c)
            table.insert(enableList, tonumber(c))
            return c
        end)
        
        if tonumber(section.user_id) == userId then
            local item = {}
            item.id = section.user_id .. "_" .. section.start .. "_" .. section["end"] .. "_" .. estr2num(section.enable)
            item.start = tonumber(section.start)
            item["end"] = tonumber(section["end"])
            item.enable = enableList
            table.insert(result, item)
        end
    end)
    
    return result
end

function checkMins(mins)
    return isInt(mins) and mins >= 0 and mins <= 2880
end

function toEnableStr(enableList)
    local result = ""
    
    if type(enableList) ~= "table" then
        return nil
    end
    
    for _, val in ipairs(enableList) do
        if val == 0 or val == 1 then
            result = result .. tostring(val)
        else
            return nil
        end
    end
    
    return result
end

function estr2num(enableStr)
    local result = 0
    local multiplier = 1
    
    for i = 1, #enableStr do
        if enableStr:sub(i, i) == "1" then
            result = result + multiplier
        end
        multiplier = multiplier * 2
    end
    
    return result
end

function genBanKey(userId, timeItem)
    local enableStr = toEnableStr(timeItem.enable)
    
    if not enableStr then
        return nil
    end
    
    if not checkMins(timeItem.start) or not checkMins(timeItem["end"]) then
        return nil
    end
    
    return tostring(userId) .. "_" .. tostring(timeItem.start) .. "_" .. tostring(timeItem["end"]) .. "_" .. estr2num(enableStr)
end

function setTimeList(params)
    local result = 0
    local newBans = {}
    local existingIds = {}
    local deleteCount = 0
    local userId = params.user_id or 0
    local timeList = params.time_list
    
    if not isInt(userId) or not timeList then
        return -1672
    end
    
    local maxBanPerUser = tonumber(mipctlUci:get(MIPCTL_USER_CONFIG, "meta", "ban_per_user"))
    if not maxBanPerUser then
        return -1673
    end
    
    local sectionName = findUser(userId)
    if not sectionName then
        return -1664
    end
    
    for _, item in ipairs(timeList) do
        if type(item) ~= "table" then
            return -1672
        end
        
        local banKey = genBanKey(userId, item)
        if type(item.id) == "string" then
            existingIds[item.id] = true
        end
        
        if banKey then
            newBans[banKey] = item
            deleteCount = deleteCount + 1
        end
    end
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_time_ban", function(section)
        local key = section.user_id .. "_" .. section.start .. "_" .. section["end"] .. "_" .. estr2num(section.enable)
        
        if newBans[key] then
            if result == 0 then
                result = mipctlUci:delete(MIPCTL_USER_CONFIG, section[".name"]) and 0 or -1673
            end
        elseif not existingIds[key] then
            if tostring(section.user_id) == tostring(userId) then
                deleteCount = deleteCount + 1
            end
        end
    end)
    
    if result ~= 0 then
        return result
    end
    
    if deleteCount > maxBanPerUser then
        return -1666
    end
    
    for _, item in ipairs(timeList) do
        local enableStr = toEnableStr(item.enable)
        
        if checkMins(item.start) and checkMins(item["end"]) and enableStr then
            local newSection = mipctlUci:add(MIPCTL_USER_CONFIG, "user_time_ban")
            result = newSection and 0 or -1673
            
            if result == 0 then
                result = mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "user_id", userId) and 0 or -1673
            end
            if result == 0 then
                result = mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "start", item.start) and 0 or -1673
            end
            if result == 0 then
                result = mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "end", item["end"]) and 0 or -1673
            end
            if result == 0 then
                result = mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "enable", enableStr) and 0 or -1673
            end
        end
        
        if not enableStr or result ~= 0 then
            return -1672
        end
    end
    
    return 0
end

function appCfgTplt(version)
    local meta = mipctlUci:get_all(MIPCTL_APP_CONFIG, "meta")
    local appVersion = meta and meta.appinfo_version
    local result = {}
    
    if not appVersion or appVersion ~= version then
        return nil
    end
    
    mipctlUci:foreach(MIPCTL_APP_CONFIG, "app_class", function(section)
        local classConfig = {}
        local appList = {}
        
        for _, app in ipairs(section.app or {}) do
            local colonPos = app:find(":")
            local appName = app:sub(1, colonPos - 1)
            local prefix = appName:sub(1, 1)
            
            if prefix == "_" then
                table.insert(appList, { name = appName, enable = false })
            else
                table.insert(appList, { name = appName, enable = true })
            end
        end
        
        classConfig.enable = false
        classConfig.time_quota = 120
        classConfig.app_list = appList
        result[section[".name"]] = classConfig
    end)
    
    return result
end

function shallowcopy(orig)
    local copy
    
    if type(orig) == "table" then
        copy = {}
        for k, v in pairs(orig) do
            copy[k] = v
        end
    else
        copy = orig
    end
    
    return copy
end

function getApp(userId)
    local version = mipctlUci:get(MIPCTL_APP_CONFIG, "meta", "appinfo_version")
    local template = appCfgTplt(version)
    local result = {}
    
    if template then
        mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_class_config", function(section)
            if tonumber(section.user_id) == userId then
                local classConfig = template[section.class_name]
                if classConfig then
                    classConfig.enable = section.enable == "true"
                    classConfig.time_quota = tonumber(section.time_quota) or 120
                    
                    local bitmask = section.app_bitmask or ""
                    for i = 1, #classConfig.app_list do
                        local bit = bitmask:sub(i, i)
                        classConfig.app_list[i].enable = (bit ~= "0")
                    end
                end
            end
        end)
        
        for className, config in pairs(template) do
            config.class_name = className
            local prefix = className:sub(1, 1)
            
            if prefix ~= "_" then
                local filteredConfig = shallowcopy(config)
                filteredConfig.app_list = {}
                
                for _, app in ipairs(config.app_list) do
                    local appPrefix = app.name:sub(1, 1)
                    if appPrefix ~= "_" then
                        table.insert(filteredConfig.app_list, app)
                    end
                end
                
                table.insert(result, filteredConfig)
            end
        end
    end
    
    return result, version
end

function setSingleClass(classConfigs, className, classConfig)
    local appNameMap = {}
    
    if classConfig.time_quota and (type(classConfig.time_quota) ~= "number" or classConfig.time_quota < 0) then
        return false
    end
    
    if classConfig.app_list and type(classConfig.app_list) ~= "table" then
        return false
    end
    
    if classConfig.enable and type(classConfig.enable) ~= "boolean" then
        return false
    end
    
    if type(classConfig.enable) == "boolean" then
        classConfig.enable = classConfig.enable
    end
    
    if classConfig.time_quota then
        classConfig.time_quota = classConfig.time_quota
    end
    
    if classConfig.app_list then
        for _, app in ipairs(classConfig.app_list) do
            if type(app.enable) ~= "boolean" then
                return false
            end
            if not app.name then
                return false
            end
            appNameMap[app.name] = app
        end
        
        for _, existingApp in ipairs(classConfig.app_list) do
            if existingApp.name and appNameMap[existingApp.name] then
                existingApp.enable = appNameMap[existingApp.name].enable
            end
        end
    end
    
    classConfigs[className] = classConfig
    return true
end

function toEnableStrV2(appList)
    local result = ""
    
    for _, app in ipairs(appList) do
        result = result .. (app.enable and "1" or "0")
    end
    
    return result
end

function setApp(params)
    local result = 0
    local userId = params.user_id
    local classList = params.class_list
    
    if not isInt(userId) or type(classList) ~= "table" then
        return -1672
    end
    
    local sectionName = findUser(userId)
    if not sectionName then
        return -1664
    end
    
    local version = mipctlUci:get(MIPCTL_APP_CONFIG, "meta", "appinfo_version")
    local template = appCfgTplt(version)
    
    if not template then
        return -1673
    end
    
    for _, classItem in ipairs(classList) do
        if type(classItem) ~= "table" or not classItem.class_name then
            return -1672
        end
        
        local templateClass = template[classItem.class_name]
        if not templateClass then
            return -1672
        end
        
        if not setSingleClass(template, classItem.class_name, classItem) then
            return -1672
        end
    end
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user_class_config", function(section)
        if tonumber(section.user_id) == userId then
            mipctlUci:delete(MIPCTL_USER_CONFIG, section[".name"])
        end
    end)
    
    for className, config in pairs(template) do
        local newSection = mipctlUci:add(MIPCTL_USER_CONFIG, "user_class_config")
        if newSection then
            mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "user_id", userId)
            mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "class_name", className)
            mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "enable", config.enable and "true" or "false")
            mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "time_quota", config.time_quota or 120)
            mipctlUci:set(MIPCTL_USER_CONFIG, newSection, "app_bitmask", toEnableStrV2(config.app_list))
        else
            return -1673
        end
    end
    
    return 0
end

function setTempBan(params)
    local userId = params.user_id
    local tempBan = params.temp_ban
    
    if not isInt(userId) or type(tempBan) ~= "boolean" then
        return -1672
    end
    
    local sectionName = findUser(userId)
    if not sectionName then
        return -1664
    end
    
    local result = mipctlUci:set(MIPCTL_USER_CONFIG, sectionName, "temp_ban", tempBan and "1" or "0")
    return result and 0 or -1673
end

function commit()
    mipctlUci:commit(MIPCTL_USER_CONFIG)
    
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        conn:call("mipctl", "reload", {})
        conn:close()
    end
end

function getUserStat(userId)
    local result = {}
    local dbUci = require("luci.model.uci").cursor(PCTL_DB_PATH)
    
    dbUci:foreach(PCTL_USER_STAT, "stat", function(section)
        if tonumber(section.user_id) == userId then
            result.online_time = tonumber(section.online_time) or 0
            result.app_time = tonumber(section.app_time) or 0
        end
    end)
    
    return result
end

function getAppClassStat(userId)
    local result = {}
    local dbUci = require("luci.model.uci").cursor(PCTL_DB_PATH)
    
    dbUci:foreach(PCTL_APPCLASS_STAT, "stat", function(section)
        if tonumber(section.user_id) == userId then
            local stat = {}
            stat.class_name = section.class_name
            stat.time_used = tonumber(section.time_used) or 0
            table.insert(result, stat)
        end
    end)
    
    return result
end
