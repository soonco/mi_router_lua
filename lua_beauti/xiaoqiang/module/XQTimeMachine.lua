--[[
Time Machine模块 (XQTimeMachine)
小米路由器macOS Time Machine备份服务管理模块

功能说明:
- 配置Time Machine备份服务
- 管理备份存储路径和大小
- 设置备份访问密码
- 检测存储设备状态

绑定状态说明:
- 0: 无存储设备，未绑定
- 1: 有存储设备，未绑定
- 2: 无存储设备，已绑定(配置存在但设备不在)
- 3: 有存储设备，已绑定且设备在线
- 4: 有存储设备，已绑定但设备不在

配置文件:
- /etc/config/timemachine: Time Machine配置
- /tmp/etc/storage: 存储设备临时目录

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.module.XQStorage: 存储管理模块
- xiaoqiang.XQLog: 日志模块
- luci.util: LuCI工具函数
- luci.model.uci: UCI配置管理
]]

module("xiaoqiang.module.XQTimeMachine", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local LuciUtil = require("luci.util")
local XQLog = require("xiaoqiang.XQLog")
local uci = require("luci.model.uci").cursor()

local STORAGE_PATH = "/tmp/etc/storage"
local CONFIG_FILE = "/etc/config/timemachine"
local SERVICE_SCRIPT = "/usr/sbin/timemachine.sh"
local LOG_LEVEL = 7

local function startTimeMachineService()
    XQFunction.forkExec(SERVICE_SCRIPT .. " start")
end

local function stopTimeMachineService()
    XQFunction.forkExec(SERVICE_SCRIPT .. " stop")
end

local function getDeviceNameByUuid(uuid)
    local cmd = string.format(
        "block info | grep '%s' | awk -F ':' '{print $1}' | awk -F '/' '{print $3}'",
        uuid
    )
    return LuciUtil.trim(LuciUtil.exec(cmd))
end

local function hasStorageDevice()
    local blockInfo = LuciUtil.exec("block info")
    if not XQFunction.isStrNil(blockInfo) then
        return 1
    end
    return 0
end

local function isUuidDevicePresent(uuid)
    local blockInfo = LuciUtil.exec("block info | grep " .. uuid)
    if not XQFunction.isStrNil(blockInfo) then
        return 1
    end
    return 0
end

function setTimeMachineInfo(enabled, path, size, password)
    local errorCode = 0
    local XQStorage = require("xiaoqiang.module.XQStorage")
    
    local currentEnabled = uci:get("timemachine", "config", "enabled") or "0"
    local currentUuid = uci:get("timemachine", "config", "uuid") or ""
    local currentSize = uci:get("timemachine", "config", "size") or "0"
    local currentPassword = uci:get("timemachine", "config", "password") or ""
    
    local newUuid = XQStorage.getStorageUuidByMountPath(path)
    
    if tonumber(enabled) then
        if tonumber(enabled) == 0 then
            uci:set("timemachine", "config", "enabled", enabled)
            uci:commit("timemachine")
            XQLog.log(LOG_LEVEL, "TimeMachine stopTimeMachineServic")
            stopTimeMachineService()
        elseif currentEnabled ~= enabled or currentSize ~= size or currentUuid ~= newUuid or currentPassword ~= password then
            if XQFunction.isStrNil(newUuid) then
                return 1589
            end
            
            uci:set("timemachine", "config", "uuid", newUuid)
            uci:set("timemachine", "config", "enabled", enabled)
            uci:set("timemachine", "config", "path", path)
            uci:set("timemachine", "config", "size", size)
            uci:set("timemachine", "config", "password", password)
            uci:commit("timemachine")
            
            XQLog.log(LOG_LEVEL, "TimeMachine startTimeMachineService")
            startTimeMachineService()
        end
    else
        errorCode = 1523
    end
    
    return errorCode
end

function getTimeMachineInfo()
    local result = {}
    
    local configUuid = uci:get("timemachine", "config", "uuid") or ""
    local hasStorage = hasStorageDevice()
    
    if XQFunction.isStrNil(configUuid) then
        if hasStorage == 0 then
            result.bindStatus = "0"
        else
            result.bindStatus = "1"
        end
    else
        local uuidPresent = isUuidDevicePresent(configUuid)
        if hasStorage == 0 then
            result.bindStatus = "2"
        elseif uuidPresent == 0 then
            result.bindStatus = "4"
        else
            result.bindStatus = "3"
        end
    end
    
    result.enabled = uci:get("timemachine", "config", "enabled") or "0"
    result.path = uci:get("timemachine", "config", "path") or ""
    result.size = uci:get("timemachine", "config", "size") or "0"
    result.password = uci:get("timemachine", "config", "password") or ""
    
    return result
end
