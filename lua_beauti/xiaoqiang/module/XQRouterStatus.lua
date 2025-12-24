--[[
  小米路由器状态模块 (XQRouterStatus)
  功能: 获取路由器各种状态信息
  
  主要功能:
  - USB设备状态查询
  - WAN口状态查询
  - 在线设备状态查询
]]

module("xiaoqiang.module.XQRouterStatus", package.seeall)

-- 引入依赖模块
local luciUtil = require("luci.util")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--[[
  获取USB设备状态
  包括外接磁盘的存在状态和数据迁移进度
  @return USB状态信息表
]]
local function usb_status()
    local result = {}
    
    -- 通过thrift接口检查外接磁盘
    local checkResult = XQFunction.thrift_tunnel_to_datacenter('{"api":1}')
    
    if checkResult then
        if checkResult.code == 0 then
            if checkResult.exist == 1 then
                -- 外接磁盘存在，获取迁移状态
                local migrationResult = XQFunction.thrift_tunnel_to_datacenter('{"api":62}')
                
                if migrationResult then
                    if migrationResult.code == 0 then
                        result.status = migrationResult.status
                        result.progress = migrationResult.progress
                    end
                else
                    result.status = -1
                    result.progress = 0
                end
                
                result.extdisk = 1
            else
                -- 外接磁盘不存在
                result.extdisk = 0
                result.status = 0
                result.progress = 0
            end
        end
    else
        result.status = 0
        result.progress = 0
        result.extdisk = 0
    end
    
    return result
end

--[[
  获取WAN口状态
  包括当前下载速度和最大下载速度
  @return WAN状态信息表
]]
local function wan_status()
    local result = {}
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取WAN口网络统计信息
    local wanStats = XQDeviceUtil.getWanLanNetworkStatistics("wan")
    
    if wanStats then
        result.speed = tonumber(wanStats.downspeed) or 0
        result.maxspeed = tonumber(wanStats.maxdownloadspeed) or 0
    else
        result.speed = 0
        result.maxspeed = 0
    end
    
    return result
end

--[[
  获取在线设备状态
  包括在线设备数量和总设备数量
  @return 设备状态信息表
]]
local function dev_status()
    local result = {}
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取设备数量统计
    local online, total, onlineWithoutMesh, totalWithoutMesh = XQDeviceUtil.getDeviceCount()
    
    result.online = online                           -- 在线设备数
    result.all = total                               -- 总设备数
    result.online_without_mash = onlineWithoutMesh   -- 不含Mesh的在线设备数
    result.all_without_mash = totalWithoutMesh       -- 不含Mesh的总设备数
    
    return result
end

-- 状态获取函数映射表
local STATUS_FUNCTIONS = {
    usb_status = usb_status,
    wan_status = wan_status,
    dev_status = dev_status
}

--[[
  获取路由器状态信息
  @param statusTypes 要获取的状态类型列表，为nil时获取所有状态
  @return 状态信息表
]]
function getStatus(statusTypes)
    local result = {}
    
    if statusTypes == nil then
        -- 获取所有状态
        for name, func in pairs(STATUS_FUNCTIONS) do
            result[name] = func()
        end
    elseif type(statusTypes) == "table" then
        -- 获取指定状态
        for _, statusType in ipairs(statusTypes) do
            local func = STATUS_FUNCTIONS[statusType]
            if func then
                local statusResult = func()
                if statusResult then
                    result[statusType] = statusResult
                end
            end
        end
    end
    
    return result
end
