--[[
  预下载模块
  提供 OTA 预下载功能的配置管理
  支持自动下载、定时下载、优先级设置等功能
]]

module("xiaoqiang.module.XQPredownload", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

function predownloadInfo()
    local uciCursor = require("luci.model.uci").cursor()
    local info = {}
    
    local autoValue = uciCursor:get("otapred", "settings", "auto") or "0"
    info.auto = tonumber(autoValue)
    
    local timeValue = uciCursor:get("otapred", "settings", "time") or "0"
    info.time = tonumber(timeValue)
    
    local priorityValue = uciCursor:get("otapred", "settings", "priority") or "0"
    info.priority = tonumber(priorityValue)
    
    local pluginValue = uciCursor:get("otapred", "settings", "plugin") or "0"
    info.plugin = tonumber(pluginValue)
    
    return info
end

function setPredownload(priority, auto, time, plugin)
    local uciCursor = require("luci.model.uci").cursor()
    
    if tonumber(priority) then
        uciCursor:set("otapred", "settings", "priority", priority)
    end
    
    if tonumber(auto) then
        uciCursor:set("otapred", "settings", "auto", auto)
    end
    
    if tonumber(time) then
        local timeNum = tonumber(time)
        if 0 <= timeNum and timeNum < 24 then
            uciCursor:set("otapred", "settings", "time", time)
        end
    end
    
    if tonumber(plugin) then
        uciCursor:set("otapred", "settings", "plugin", plugin)
    end
    
    uciCursor:commit("otapred")
end

function switch(enable)
    local uciCursor = require("luci.model.uci").cursor()
    
    if enable then
        local result = os.execute("/etc/init.d/predownload-ota start")
        return result == 0
    else
        local result = os.execute("/etc/init.d/predownload-ota stop")
        return result == 0
    end
end

function reload()
    os.execute("/etc/init.d/predownload-ota restart")
end
