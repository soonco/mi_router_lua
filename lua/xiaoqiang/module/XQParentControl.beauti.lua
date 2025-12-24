--[[
家长控制模块 (XQParentControl)
小米路由器家长控制功能模块

功能说明:
- 设备上网时间控制
- URL黑白名单过滤
- 设备网络访问权限管理
- 定时上网规则配置

控制模式说明:
- none: 无限制
- limited: 禁止上网
- time: 按时间段控制

星期映射:
- Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6, Sun=7

配置文件:
- /etc/config/parentalctl: 家长控制配置
- /etc/parentalctl/: URL过滤规则目录

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.common.XQConfigs: 配置常量
- xiaoqiang.module.XQFirewall: 防火墙模块
- xiaoqiang.util.XQSynchrodata: 数据同步工具
- xiaoqiang.util.XQController: 控制器工具
- luci.model.uci: UCI配置管理
- luci.util: LuCI工具函数
- luci.cbi.datatypes: 数据类型验证
- nixio.fs: 文件系统操作
- bit: 位运算库
- math: 数学库
]]

module("xiaoqiang.module.XQParentControl", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local bit = require("bit")
local math = require("math")
local nixio = require("nixio.fs")
local uci = require("luci.model.uci").cursor()
local LuciUtil = require("luci.util")
local DataTypes = require("luci.cbi.datatypes")

local MAX_DEVICE_RULES = 5

local WEEKDAY_TO_NUM = {
    Mon = 1,
    Tue = 2,
    Wed = 3,
    Thu = 4,
    Fri = 5,
    Sat = 6,
    Sun = 7
}

local NUM_TO_WEEKDAY = {
    [1] = "Mon",
    [2] = "Tue",
    [3] = "Wed",
    [4] = "Thu",
    [5] = "Fri",
    [6] = "Sat",
    [7] = "Sun"
}

function get_global_info()
    local globalConfig = uci:get_all("parentalctl", "global")
    
    local result = {
        on = 1
    }
    
    if globalConfig then
        if globalConfig.disabled then
            if tonumber(globalConfig.disabled) == 1 then
                result.on = 0
            end
        end
    end
    
    return result
end

function get_macfilter_wan(mac)
    local wanAllowed = true
    
    local output = LuciUtil.exec("/usr/sbin/sysapi macfilter get | grep \"" .. string.lower(mac) .. "\"")
    
    if output then
        output = LuciUtil.trim(output)
        output = output .. ";"
        
        local wanStatus = output:match("wan=(%S-);")
        if wanStatus and wanStatus ~= "yes" then
            wanAllowed = false
        end
    end
    
    return wanAllowed
end

function macfilter_wan_changed(mac, wanAllowed)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    local macKey = mac:gsub(":", "")
    
    local summary = {
        mac = mac,
        disabled = "0",
        mark = "1",
        mode = wanAllowed and "none" or "limited"
    }
    
    uci:section("parentalctl", "summary", macKey, summary)
    uci:commit("parentalctl")
    
    apply()
end

function _generate_key(mac)
    local macKey = mac:gsub(":", "")
    local maxSlots = math.pow(2, MAX_DEVICE_RULES) - 1
    
    uci:foreach("parentalctl", "device", function(section)
        local sectionName = section[".name"]
        if sectionName:match("^" .. macKey .. "_") then
            local slotStr = sectionName:gsub(macKey .. "_", "")
            local slotNum = tonumber(slotStr)
            if slotNum and slotNum <= MAX_DEVICE_RULES then
                maxSlots = bit.bxor(maxSlots, math.pow(2, slotNum - 1))
            end
        end
    end)
    
    for i = 1, MAX_DEVICE_RULES do
        if bit.band(maxSlots, math.pow(2, i - 1)) > 0 then
            return macKey .. "_" .. tostring(i)
        end
    end
    
    return nil
end

function _parse_frequency(weekdays, timeSeg)
    local weekdayList = {}
    local startDate, stopDate = nil, nil
    
    for _, day in ipairs(weekdays) do
        if tonumber(day) == 0 then
            weekdayList = nil
            break
        end
        
        local dayName = NUM_TO_WEEKDAY[tonumber(day)]
        if dayName then
            table.insert(weekdayList, dayName)
        end
    end
    
    if weekdayList then
        return weekdayList, nil, nil
    else
        local currentTime = os.time()
        startDate = currentTime
        stopDate = startDate + 86400
        
        if timeSeg then
            local fromTime, toTime = timeSeg:match("([%d:]+)%-([%d:]+)")
            if fromTime and toTime then
                if fromTime > toTime then
                    startDate = startDate + 86400
                end
                if toTime < fromTime then
                    stopDate = startDate + 86400
                else
                    stopDate = startDate + 172800
                end
            end
        end
        
        return nil, startDate, stopDate
    end
end

function apply(async)
    if async then
        XQFunction.forkExec("/usr/sbin/parentalctl.sh 2>/dev/null >/dev/null")
    else
        os.execute("/usr/sbin/parentalctl.sh 2>/dev/null >/dev/null")
    end
end

function get_device_mode_info(mac)
    if XQFunction.isStrNil(mac) or not DataTypes.macaddr(mac) then
        return nil
    end
    
    mac = XQFunction.macFormat(mac)
    
    local wanAllowed = get_macfilter_wan(mac)
    local result = {}
    local macKey = mac:gsub(":", "")
    
    local summaryConfig = uci:get_all("parentalctl", macKey)
    
    if summaryConfig then
        if tonumber(summaryConfig.mark) and tonumber(summaryConfig.mark) == 1 then
            result.enable = tonumber(summaryConfig.disabled) == 0 and 1 or 0
            result.mode = summaryConfig.mode or "none"
            
            if not wanAllowed then
                result.mode = "limited"
                result.enable = 1
                uci:set("parentalctl", macKey, "disabled", "0")
                uci:set("parentalctl", macKey, "mode", "limited")
                uci:commit("parentalctl")
            end
        end
    else
        result.enable = 1
        if wanAllowed then
            result.mode = "none"
        else
            result.mode = "limited"
        end
        
        local newSummary = {
            disabled = "0",
            mode = result.mode,
            mac = mac
        }
        
        local rules = parentctl_rules({[mac] = 1})
        if rules then
            local macRules = rules[mac]
            if macRules and macRules.enabled > 0 then
                result.mode = "time"
                os.execute("/usr/sbin/sysapi macfilter set mac=" .. mac .. " wan=yes; /usr/sbin/sysapi macfilter commit")
            end
        end
        
        if summaryConfig and not summaryConfig.mark then
            uci:delete("parentalctl", macKey)
            uci:commit("parentalctl")
        end
    end
    
    local urlfilterInfo = get_parentctl_url_filter(mac)
    result.urlfilter = {
        mode = urlfilterInfo.mode,
        count = urlfilterInfo.count
    }
    
    return result
end

function check_mode(mode)
    if mode and mode ~= "time" and mode ~= "limited" and mode ~= "none" then
        return false
    end
    return true
end

function set_device_mode_info(mac, enable, mode)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQController = require("xiaoqiang.util.XQController")
    
    local result = {}
    local macKey = mac:gsub(":", "")
    
    local summaryConfig = uci:get_all("parentalctl", macKey)
    local wanStatus = "1"
    
    if summaryConfig then
        if enable then
            summaryConfig.disabled = enable == 1 and "0" or "1"
        end
        if mode then
            summaryConfig.mode = mode
        end
    else
        summaryConfig = {
            disabled = "0",
            mode = "time",
            mac = mac
        }
        if enable then
            summaryConfig.disabled = enable == 1 and "0" or "1"
        end
        if mode then
            summaryConfig.mode = mode
        end
    end
    
    summaryConfig.mark = 1
    
    result.enable = tonumber(summaryConfig.disabled) == 0 and 1 or 0
    result.mode = summaryConfig.mode
    
    if result.mode == "limited" and result.enable == 1 then
        wanStatus = "0"
    end
    
    uci:section("parentalctl", "summary", macKey, summaryConfig)
    uci:commit("parentalctl")
    
    XQFirewall.setMacFilter(string.upper(mac), "", 0, wanStatus)
    XQController.permission(mac, nil, wanStatus, nil, nil)
    
    XQSynchrodata.syncDeviceInfo({mac = mac})
    
    return result
end

function get_device_info(mac)
    if XQFunction.isStrNil(mac) or not DataTypes.macaddr(mac) then
        return nil
    end
    
    mac = XQFunction.macFormat(mac)
    
    local result = {}
    local ruleList = {}
    local macKey = mac:gsub(":", "")
    
    local currentTime = os.date("%H:%M")
    local currentDate = os.date("%Y-%m-%d")
    local currentWeekday = os.date("%a")
    
    uci:foreach("parentalctl", "device", function(section)
        local sectionName = section[".name"]
        if sectionName:match("^" .. macKey .. "_") then
            local rule = {
                id = sectionName,
                mac = section.mac,
                enable = tonumber(section.disabled) == 0 and 1 or 0,
                active = 0
            }
            
            if section.time_seg then
                local fromTime, toTime = section.time_seg:match("([%d:]+)%-([%d:]+)")
                if fromTime and toTime then
                    rule.timeseg = {
                        from = fromTime,
                        to = toTime
                    }
                end
            end
            
            if section.weekdays then
                local frequency = {}
                for _, day in ipairs(section.weekdays) do
                    table.insert(frequency, WEEKDAY_TO_NUM[day])
                end
                rule.frequency = frequency
                
                if rule.enable == 1 and section.weekdays then
                    for _, day in ipairs(section.weekdays) do
                        local dayNum = WEEKDAY_TO_NUM[currentWeekday]
                        if day == currentWeekday or tonumber(day) == 0 then
                            if rule.timeseg then
                                local fromTime = rule.timeseg.from
                                local toTime = rule.timeseg.to
                                
                                if fromTime > toTime then
                                    if currentTime >= fromTime then
                                        rule.active = 1
                                        break
                                    elseif currentDate > section.start_date and currentTime >= fromTime then
                                        rule.active = 1
                                        break
                                    elseif currentDate == section.start_date and currentTime >= fromTime then
                                        rule.active = 1
                                        break
                                    end
                                else
                                    if currentTime >= fromTime and currentTime <= toTime then
                                        if currentDate == section.start_date then
                                            rule.active = 1
                                            break
                                        end
                                    end
                                end
                            else
                                rule.active = 1
                                break
                            end
                        end
                    end
                end
            end
            
            table.insert(ruleList, rule)
        end
    end)
    
    uci:commit("parentalctl")
    result.rules = ruleList
    
    return result
end

function add_device_info(mac, enable, weekdays, timeSeg)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    if XQFunction.isStrNil(mac) or not weekdays or type(weekdays) ~= "table" then
        return false
    end
    
    if XQFunction.isStrNil(timeSeg) or not timeSeg:match("[%d:]+%-[%d:]+") then
        return false
    end
    
    mac = XQFunction.macFormat(mac)
    
    local ruleKey = _generate_key(mac)
    if not ruleKey then
        return false
    end
    
    local parsedWeekdays, startDate, stopDate = _parse_frequency(weekdays, timeSeg)
    
    local deviceRule = {
        mac = mac,
        weekdays = parsedWeekdays,
        start_date = startDate,
        stop_date = stopDate,
        disabled = enable == 1 and 0 or 1,
        time_seg = timeSeg
    }
    
    uci:section("parentalctl", "device", ruleKey, deviceRule)
    uci:commit("parentalctl")
    
    XQSynchrodata.syncDeviceInfo({mac = mac})
    
    return ruleKey
end

function update_device_info(ruleId, mac, enable, weekdays, timeSeg)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    if XQFunction.isStrNil(ruleId) then
        return false
    end
    
    local ruleConfig = uci:get_all("parentalctl", ruleId)
    if not ruleConfig then
        return false
    end
    
    if enable then
        ruleConfig.disabled = enable == 1 and 0 or 1
    end
    
    if weekdays then
        local parsedWeekdays, startDate, stopDate = _parse_frequency(weekdays, timeSeg or ruleConfig.time_seg)
        
        if parsedWeekdays then
            ruleConfig.weekdays = parsedWeekdays
            ruleConfig.start_date = nil
            ruleConfig.stop_date = nil
            uci:delete("parentalctl", ruleId, "start_date")
            uci:delete("parentalctl", ruleId, "stop_date")
        end
        
        if startDate then
            ruleConfig.start_date = startDate
        end
        if stopDate then
            ruleConfig.stop_date = stopDate
        end
        
        if startDate or stopDate then
            ruleConfig.weekdays = nil
            uci:delete("parentalctl", ruleId, "weekdays")
        end
    elseif enable and enable == 1 then
        if ruleConfig.start_date and ruleConfig.stop_date then
            local _, startDate, stopDate = _parse_frequency({0}, timeSeg or ruleConfig.time_seg)
            if startDate then
                ruleConfig.start_date = startDate
            end
            if stopDate then
                ruleConfig.stop_date = stopDate
            end
        end
    end
    
    if timeSeg then
        if timeSeg:match("[%d:]+%-[%d:]+") then
            ruleConfig.time_seg = timeSeg
        end
    end
    
    uci:section("parentalctl", "device", ruleId, ruleConfig)
    uci:commit("parentalctl")
    
    XQSynchrodata.syncDeviceInfo({mac = mac})
    
    return true
end

function delete_device_info(ruleId)
    if XQFunction.isStrNil(ruleId) then
        return false
    end
    
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    local ruleConfig = uci:get_all("parentalctl", ruleId)
    local mac = nil
    
    if ruleConfig then
        mac = ruleConfig.mac
    end
    
    uci:delete("parentalctl", ruleId)
    uci:commit("parentalctl")
    
    XQSynchrodata.syncDeviceInfo({mac = mac})
    
    return true
end

function parentctl_rules(macList)
    local result = {}
    
    uci:foreach("parentalctl", "device", function(section)
        if section.mac then
            local sectionName = section[".name"]
            if sectionName:match("_") then
                if macList then
                    if not macList[section.mac] then
                        return
                    end
                end
                
                local macRules = result[section.mac]
                if macRules then
                    macRules.total = macRules.total + 1
                    if section.disabled and tonumber(section.disabled) == 0 then
                        macRules.enabled = macRules.enabled + 1
                    end
                else
                    macRules = {
                        total = 1,
                        enabled = 0
                    }
                    if section.disabled and tonumber(section.disabled) == 0 then
                        macRules.enabled = 1
                    end
                end
                result[section.mac] = macRules
            end
        end
    end)
    
    if macList then
        for mac, _ in pairs(macList) do
            if not result[mac] then
                result[mac] = {
                    total = 0,
                    enabled = 0
                }
            end
        end
    end
    
    return result
end

function netacctl_status(macList)
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    
    local result = {}
    local macfilterDict = XQFirewall.getMacfilterInfoDict()
    
    if macList and type(macList) == "table" then
        for mac, _ in pairs(macList) do
            local wanAllowed = true
            
            if macfilterDict[mac] then
                wanAllowed = macfilterDict[mac].wan
            end
            
            local status = {}
            local macKey = mac:gsub(":", "")
            
            local summaryConfig = uci:get_all("parentalctl", macKey)
            
            if summaryConfig then
                if tonumber(summaryConfig.mark) and tonumber(summaryConfig.mark) == 1 then
                    status.enable = tonumber(summaryConfig.disabled) == 0 and 1 or 0
                    status.mode = summaryConfig.mode or "none"
                    
                    if not wanAllowed then
                        status.mode = "limited"
                        status.enable = 1
                    end
                end
            else
                status.enable = 1
                if wanAllowed then
                    status.mode = "none"
                else
                    status.mode = "limited"
                end
                
                local newSummary = {
                    disabled = "0",
                    mode = status.mode,
                    mac = mac
                }
                
                local rules = parentctl_rules({[mac] = 1})
                if rules then
                    local macRules = rules[mac]
                    if macRules and macRules.enabled > 0 then
                        status.mode = "time"
                    end
                end
            end
            
            result[mac] = status
        end
    end
    
    return result
end

function get_url_info(filePath)
    if XQFunction.isStrNil(filePath) then
        return nil
    end
    
    if not nixio.access(filePath) then
        return nil
    end
    
    local file = io.open(filePath)
    local urlList = {}
    
    if file then
        for line in file:lines() do
            if not XQFunction.isStrNil(line) then
                local url = line:match("(%S+)%s%S+")
                table.insert(urlList, url)
            end
        end
    end
    
    return urlList
end

function set_url_info(filePath, urlList)
    if XQFunction.isStrNil(filePath) then
        return false
    end
    
    if urlList and type(urlList) == "table" then
        local file = io.open(filePath, "w")
        
        for _, url in ipairs(urlList) do
            if not XQFunction.isStrNil(url) then
                local cleanUrl = url:gsub("http://", ""):gsub("^www.", "")
                
                if not DataTypes.ipaddr(cleanUrl) then
                    if not cleanUrl:match("^%.") then
                        cleanUrl = "." .. cleanUrl
                    end
                end
                
                file:write(url .. " " .. cleanUrl .. "\n")
            end
        end
        
        file:close()
    end
    
    return true
end

function get_parentctl_url_filter(mac)
    if XQFunction.isStrNil(mac) or not DataTypes.macaddr(mac) then
        return nil
    end
    
    mac = XQFunction.macFormat(mac)
    
    local result = {
        mode = "none",
        count = 0
    }
    
    local macKey = mac:gsub(":", "") .. "_RULE"
    local ruleConfig = uci:get_all("parentalctl", macKey)
    
    if ruleConfig then
        result.mode = ruleConfig.mode or "none"
        
        if tonumber(ruleConfig.disabled) == 0 then
            local hostfile = ruleConfig.hostfile
            if hostfile then
                if type(hostfile) == "table" and #hostfile > 0 then
                    local urlList = get_url_info(hostfile[1]) or {}
                    result.count = #urlList
                    result.urls = urlList
                end
            end
        end
    end
    
    return result
end

function get_parentctl_url_list(mac, filterMode)
    local filePath = nil
    
    if filterMode == "white" then
        filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_WHITE.url"
    elseif filterMode == "black" then
        filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_BLACK.url"
    end
    
    if filePath then
        return get_url_info(filePath) or {}
    end
    
    return {}
end

function set_parentctl_url_filter(mac, filterMode, name)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    if XQFunction.isStrNil(mac) or not DataTypes.macaddr(mac) or XQFunction.isStrNil(filterMode) then
        return nil
    end
    
    mac = XQFunction.macFormat(mac)
    
    local macKey = mac:gsub(":", "") .. "_RULE"
    local ruleConfig = uci:get_all("parentalctl", macKey)
    
    if not ruleConfig then
        ruleConfig = {}
    end
    
    ruleConfig.mac = mac
    
    local filePath = nil
    if filterMode == "white" then
        filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_WHITE.url"
    elseif filterMode == "black" then
        filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_BLACK.url"
    end
    
    ruleConfig.disabled = filterMode ~= "none" and "0" or "1"
    
    if filePath then
        ruleConfig.hostfile = {filePath}
    end
    
    if name then
        ruleConfig.name = name
    end
    
    ruleConfig.mode = filterMode
    
    uci:section("parentalctl", "rule", macKey, ruleConfig)
    uci:commit("parentalctl")
    
    XQSynchrodata.syncDeviceInfo({mac = mac})
end

function disable_all_parentctl_url_filter()
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    uci:foreach("parentalctl", "rule", function(section)
        if next(section) then
            if section.disabled ~= "1" and section.mode ~= "none" then
                uci:set("parentalctl", section[".name"], "disabled", "1")
                uci:set("parentalctl", section[".name"], "mode", "none")
                XQSynchrodata.syncDeviceInfo({mac = section.mac})
            end
        end
    end)
    
    uci:commit("parentalctl")
end

function edit_parentctl_url_list(mac, action, filterMode, url, newUrl)
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    if XQFunction.isStrNil(mac) or not DataTypes.macaddr(mac) then
        return false
    end
    
    if not filterMode or not url then
        return false
    end
    
    mac = XQFunction.macFormat(mac)
    
    if filterMode == "none" then
        return false
    end
    
    local filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_BLACK.url"
    if filterMode == "white" then
        filePath = "/etc/parentalctl/" .. mac:gsub(":", "") .. "_WHITE.url"
    end
    
    local urlList = get_url_info(filePath)
    
    if type(url) == "table" and #url > 1 and action == 1 then
        local urlSet = {}
        for _, u in ipairs(url) do
            if not XQFunction.isStrNil(u) then
                urlSet[u] = true
            end
        end
        
        if urlList then
            for i = #urlList, 1, -1 do
                if urlSet[urlList[i]] then
                    table.remove(urlList, i)
                end
            end
            set_url_info(filePath, urlList)
            return true
        end
    end
    
    if urlList then
        local foundIndex = nil
        for i, u in ipairs(urlList) do
            if u == url then
                foundIndex = i
            end
        end
        
        if action == 0 then
            if not foundIndex then
                table.insert(urlList, url)
            end
        elseif action == 1 then
            if foundIndex then
                table.remove(urlList, foundIndex)
            end
        elseif action == 2 and newUrl then
            if foundIndex then
                urlList[foundIndex] = newUrl
            else
                table.insert(urlList, newUrl)
            end
        end
    else
        urlList = {}
        if action == 0 then
            table.insert(urlList, url)
        end
        if action == 2 and newUrl then
            table.insert(urlList, newUrl)
        end
    end
    
    set_url_info(filePath, urlList)
    XQSynchrodata.syncDeviceInfo({mac = mac})
    
    return true
end

function _get_file_line_count(filePath)
    if XQFunction.isStrNil(filePath) then
        return 0
    end
    
    if not nixio.access(filePath) then
        return 0
    end
    
    local cmd = "wc -l \"" .. XQFunction._cmdformat(filePath) .. "\" | awk '{print $1}'"
    return tonumber(LuciUtil.trim(LuciUtil.exec(cmd)))
end

function get_urlfilter_info(macList)
    local result = {}
    local ruleInfo = {}
    
    if macList and type(macList) == "table" then
        uci:foreach("parentalctl", "rule", function(section)
            if section.mac then
                local mode = section.mode
                local hostfile = section.hostfile
                
                if hostfile then
                    if type(hostfile) == "table" and #hostfile == 1 then
                        hostfile = hostfile[1]
                    end
                else
                    hostfile = nil
                end
                
                if section.disabled and tonumber(section.disabled) == 1 then
                    mode = "none"
                end
                
                ruleInfo[section.mac] = {
                    count = _get_file_line_count(hostfile),
                    mode = mode
                }
            end
        end)
        
        for mac, _ in pairs(macList) do
            local info = ruleInfo[mac]
            if not info then
                info = {
                    count = 0,
                    mode = "none"
                }
            end
            result[mac] = info
        end
    end
    
    return result
end
