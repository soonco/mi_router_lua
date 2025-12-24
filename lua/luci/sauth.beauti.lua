--[[
LuCI 会话认证模块
luci.sauth - Session Authentication Module

该模块提供基于文件系统的会话管理功能：
- 会话创建、读取、写入、删除
- 会话过期检测与清理
- 会话安全性验证（路径安全、ID格式验证）
]]--

module("luci.sauth", package.seeall)

require("luci.util")
require("luci.sys")
require("luci.config")

local nixio = require("nixio")
require("nixio.util")
local nixioFs = require("nixio.fs")
local xqLog = require("xiaoqiang.XQLog")

luci.config.sauth = luci.config.sauth or {}
sessionpath = luci.config.sauth.sessionpath
sessiontime = tonumber(luci.config.sauth.sessiontime) or 3600

function prepare()
    nixioFs.mkdir(sessionpath, 700)
    if not sane() then
        error("Security Exception: Session path is not sane!")
    end
end

local function readSessionFile(sessionId)
    return nixioFs.readfile(sessionpath .. "/" .. sessionId)
end

local function writeSessionFile(sessionId, data)
    local uniqueId = luci.sys.uniqueid(16)
    local tempPath = sessionpath .. "/" .. uniqueId
    local finalPath = sessionpath .. "/" .. sessionId
    
    local file = nixioFs.open(tempPath, "w", 600)
    file:writeall(data)
    file:close()
    
    nixio.rename(tempPath, finalPath)
end

local function isInvalidSessionId(sessionId)
    return sessionId and not sessionId:match("^[a-fA-F0-9]+$")
end

function write(sessionId, sessionData)
    if not sane() then
        prepare()
    end
    
    if isInvalidSessionId(sessionId) then
        xqLog.log(3, "Security Exception: Session ID is invalid! sauth.write")
        return
    end
    
    if type(sessionData) ~= "table" then
        xqLog.log(3, "Security Exception: Session data invalid! sauth.write")
        return
    end
    
    sessionData.atime = luci.sys.uptime()
    writeSessionFile(sessionId, luci.util.get_bytecode(sessionData))
end

function read(sessionId)
    if not sessionId or #sessionId == 0 then
        return nil
    end
    
    if isInvalidSessionId(sessionId) then
        xqLog.log(3, "Security Exception: Session ID is invalid! sauth.read")
        return nil
    end
    
    if not sane(sessionpath .. "/" .. sessionId) then
        return nil
    end
    
    local rawData = readSessionFile(sessionId)
    local loader = loadstring(rawData)
    setfenv(loader, {})
    local sessionData = loader()
    
    if type(sessionData) ~= "table" then
        xqLog.log(3, "Security Exception: Session data invalid! sauth.read")
        return nil
    end
    
    if sessionData.atime then
        local expireTime = sessionData.atime + sessiontime
        local currentTime = luci.sys.uptime()
        if expireTime < currentTime then
            kill(sessionId)
            return nil
        end
    end
    
    write(sessionId, sessionData)
    return sessionData
end

function sane(path)
    local processUid = luci.sys.process.info("uid")
    local fileUid = nixioFs.stat(path or sessionpath, "uid")
    return processUid == fileUid
end

function kill(sessionId)
    if isInvalidSessionId(sessionId) then
        xqLog.log(3, "Security Exception: Session ID is invalid! sauth.kill")
    else
        nixioFs.unlink(sessionpath .. "/" .. sessionId)
    end
end

function reap()
    if sane() then
        for filename in nixioFs.dir(sessionpath) do
            if not isInvalidSessionId(filename) then
                read(filename)
            end
        end
    end
end

function available(clientIp)
    if sane() then
        for filename in nixioFs.dir(sessionpath) do
            if not isInvalidSessionId(filename) then
                local sessionData = read(filename)
                if clientIp then
                    if sessionData and sessionData.ip == clientIp then
                        return sessionData
                    end
                else
                    if sessionData and not sessionData.ip then
                        return sessionData
                    end
                end
            end
        end
    end
    return nil
end

function killall()
    os.execute(string.format("rm -rf %s", sessionpath))
end
