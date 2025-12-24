--[[
  存储模块 (Storage Module)
  提供外部存储设备管理、Samba 服务配置、Swap 交换空间管理等功能
  支持 USB 存储设备的挂载、卸载和信息查询
]]
module("xiaoqiang.module.XQStorage", package.seeall)

local xqFunction = require("xiaoqiang.common.XQFunction")
local luciUtil = require("luci.util")
local xqLog = require("xiaoqiang.XQLog")
local uci = require("luci.model.uci").cursor()

local STORAGE_CONFIG_PATH = "/tmp/etc/storage"
local SAMBA_INIT_PATH = "/etc/init.d/samba"
local STORAGE_CMD = "/usr/sbin/storage"
local SWAP_CMD = "/usr/sbin/swap"

local function restartStorage()
    xqFunction.forkExec(STORAGE_CMD .. " restart")
end

local function restartSamba()
    xqFunction.forkExec(SAMBA_INIT_PATH .. " restart")
end

local function stopSamba()
    xqFunction.forkExec(SAMBA_INIT_PATH .. " stop")
end

local function startSamba()
    xqFunction.forkExec(SAMBA_INIT_PATH .. " start")
end

local function deleteSwap(path)
    xqFunction.forkExec(SWAP_CMD .. " del_swap " .. path)
end

local function addSwap(path)
    xqFunction.forkExec(SWAP_CMD .. " add_swap " .. path)
end

local function umountDevice(deviceName)
    return luciUtil.exec(STORAGE_CMD .. " umount " .. deviceName)
end

local function getSwapTotal()
    local total = math.ceil(tonumber(luciUtil.exec("free|grep Swap|awk '{print $2}'")) / 1024)
    return total or 0
end

local function getSwapUsed()
    local used = math.modf(tonumber(luciUtil.exec("free|grep Swap|awk '{print $3}'")) / 1024)
    return used or 0
end

local function getMemUsed()
    local used = math.modf(tonumber(luciUtil.exec("free|grep Mem|awk '{print $3}'")) / 1024)
    return used or 0
end

local function getMemAvailable()
    local available = math.modf(tonumber(luciUtil.exec("free|grep Mem|awk '{print $7}'")) / 1024)
    return available or 0
end

local function getStorageUsed(partitionName)
    local result = luciUtil.exec(STORAGE_CMD .. " used " .. partitionName)
    result = result:sub(1, #result - 1)
    local used = tonumber(result .. ".0")
    return used or 0
end

local function getStorageSection(sectionName)
    if xqFunction.isStrNil(sectionName) then
        return nil
    end
    local section = uci:get_all("storage", sectionName)
    return section or {}
end

local function getUuidBySection(sectionName)
    local section = getStorageSection(sectionName)
    if section and section.uuid then
        return section.uuid
    end
    return nil
end

local function getTargetBySection(sectionName)
    local section = getStorageSection(sectionName)
    if section and section.target then
        return section.target
    end
    return nil
end

function getStorageInfoByUuid(uuid)
    local sectionName = nil
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    storageUci:foreach("storage", "partition", function(section)
        if section.uuid == uuid then
            sectionName = section[".name"]
        end
    end)
    
    if sectionName then
        local info = storageUci:get_all("storage", sectionName)
        if info then
            return info
        end
    end
    
    return nil
end

function getStorageMountPathByUuid(uuid)
    if xqFunction.isStrNil(uuid) then
        return nil
    end
    
    local mountPath = nil
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    storageUci:foreach("storage", "partition", function(section)
        if section.uuid == uuid then
            mountPath = section.target
        end
    end)
    
    return mountPath
end

function getStorageUuidByMountPath(mountPath)
    if xqFunction.isStrNil(mountPath) then
        return nil
    end
    
    local uuid = nil
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    storageUci:foreach("storage", "partition", function(section)
        if section.target == mountPath then
            uuid = section.uuid
        end
    end)
    
    return uuid
end

function setSwapInfo(uuid, size)
    local granularity = tonumber(uci:get("swap", "swap0", "granularity") or "1")
    size = math.modf(tonumber(size) / granularity)
    
    local currentUuid = uci:get("swap", "swap0", "uuid")
    local currentSize = uci:get("swap", "swap0", "size")
    local currentMountPath = getStorageMountPathByUuid(currentUuid)
    
    if uuid ~= currentUuid or currentSize ~= size then
        if not xqFunction.isStrNil(currentMountPath) then
            deleteSwap(currentMountPath)
        end
        
        uci:set("swap", "swap0", "uuid", uuid)
        uci:set("swap", "swap0", "size", size)
        uci:commit("swap")
        
        restartStorage()
    end
    
    return 0
end

function delSwap(uuid)
    if xqFunction.isStrNil(uuid) then
        return 1502
    end
    
    local currentUuid = uci:get("swap", "swap0", "uuid")
    local mountPath = getStorageMountPathByUuid(uuid)
    
    if currentUuid == uuid then
        if not xqFunction.isStrNil(mountPath) then
            deleteSwap(mountPath)
            uci:delete("swap", "swap0", "uuid")
            uci:delete("swap", "swap0", "size")
            uci:commit("swap")
        end
    else
        return 1523
    end
    
    return 0
end

function getSwapInfo()
    local info = {}
    info.uuid = uci:get("swap", "swap0", "uuid") or ""
    info.size = uci:get("swap", "swap0", "size") or ""
    info.exist = 0
    
    local mountPath = getStorageMountPathByUuid(info.uuid)
    if not xqFunction.isStrNil(mountPath) then
        info.exist = 1
    end
    
    return info
end

function getMemTotal()
    local memTotal = 0
    local memSize = uci:get("misc", "hardware", "memsize") or ""
    local unit = string.upper(string.sub(memSize, string.len(memSize) - 1))
    
    if unit == "MB" then
        memTotal = tonumber(string.sub(memSize, 0, string.len(memSize) - 2))
    elseif unit == "GB" then
        memTotal = tonumber(string.sub(memSize, 0, string.len(memSize) - 2)) * 1024
    elseif unit == "KB" then
        memTotal = math.modf(tonumber(string.sub(memSize, 0, string.len(memSize) - 2)) / 1024)
    end
    
    return memTotal
end

function getMemInfo()
    local info = {}
    info.swaptotal = getSwapTotal()
    info.swapused = getSwapUsed()
    info.memtotal = getMemTotal()
    info.memused = getMemUsed() - getMemAvailable()
    return info
end

function setSambaStatus(enabled)
    enabled = tostring(enabled)
    local currentStatus = uci:get("samba", "globles", "enabled")
    
    if enabled ~= currentStatus then
        uci:set("samba", "globles", "enabled", enabled)
        uci:commit("samba")
        restartSamba()
    end
    
    return 0
end

function getSambaStatus()
    local status = uci:get("samba", "globles", "enabled") or "0"
    return status
end

function umountStorageDevice(partitionName)
    local result = 0
    
    if xqFunction.isStrNil(partitionName) then
        return 1502
    end
    
    partitionName = tostring(partitionName)
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    local partition = storageUci:get_all("storage", partitionName)
    if partition then
        umountDevice(partitionName)
    else
        result = 1523
    end
    
    return result
end

function umountAllStorageDevices()
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    storageUci:foreach("storage", "device", function(section)
        local deviceName = section[".name"]
        umountDevice(deviceName)
    end)
    
    return 0
end

function getStorageDeviceList()
    local deviceList = {}
    local storageUci = require("luci.model.uci").cursor()
    storageUci:load(STORAGE_CONFIG_PATH)
    
    storageUci:foreach("storage", "device", function(deviceSection)
        local device = {}
        local partitionList = {}
        
        local deviceName = deviceSection[".name"]
        device.sid = deviceName
        device.vendor = storageUci:get("storage", deviceName, "vendor") or ""
        device.model = storageUci:get("storage", deviceName, "model") or ""
        
        local partitions = storageUci:get("storage", deviceName, "partition") or ""
        if partitions ~= "" then
            for _, partitionName in ipairs(type(partitions) == "table" and partitions or {partitions}) do
                local partition = {}
                
                storageUci:foreach("storage", "partition", function(partSection)
                    local sectionName = partSection[".name"]
                    local target = storageUci:get("storage", sectionName, "target") or ""
                    
                    if partitionName == sectionName and target ~= "" then
                        partition.name = sectionName
                        partition.path = target
                        partition.label = storageUci:get("storage", sectionName, "label") or ""
                        partition.uuid = storageUci:get("storage", sectionName, "uuid") or ""
                        partition.fstype = string.upper(storageUci:get("storage", sectionName, "type") or "")
                        
                        local sizeKB = storageUci:get("storage", sectionName, "size") or "0"
                        local sizeBytes = tonumber(sizeKB .. ".0") / 2
                        partition.capacity = string.format("%.1f", sizeBytes / 1048576) .. "GB"
                        
                        local usedKB = getStorageUsed(sectionName)
                        partition.used = string.format("%.1f", usedKB / 1048576) .. "GB"
                        
                        local availableKB = sizeBytes - usedKB
                        partition.available = string.format("%.1f", availableKB / 1048576)
                        
                        if sizeBytes > 0 then
                            partition.width = string.format("%.0f", (usedKB / sizeBytes) * 100) .. "%"
                        end
                        
                        partition.isExtDisk = true
                        table.insert(partitionList, partition)
                    end
                end)
            end
        end
        
        device.partitionList = partitionList
        table.insert(deviceList, device)
    end)
    
    return deviceList
end

function getSambaName()
    local name = uci:get("samba", "globles", "name") or ""
    return name
end
