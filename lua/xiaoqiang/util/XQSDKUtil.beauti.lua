---
--- XQSDKUtil SDK工具模块
--- 小米路由器SDK权限管理工具
--- 功能：SDK设备MAC地址过滤和权限控制
---

module("xiaoqiang.util.XQSDKUtil", package.seeall)

local XQLog = require("xiaoqiang.XQLog")
local XQPreference = require("xiaoqiang.XQPreference")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

CONFIG_MACFILTER = "sdkfilter"

--- 格式化MAC地址（移除冒号）
--- @param macAddr string MAC地址
--- @return string 格式化后的MAC地址（无冒号）
local function _formatMac(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return nil
    end
    return macAddr:gsub(":", "")
end

--- 检查SDK权限
--- @param macAddr string 设备MAC地址
--- @return boolean 是否有权限
function checkPermission(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return false
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local permission = XQPreference.get(_formatMac(macAddr), nil, CONFIG_MACFILTER)
    
    if permission then
        if permission == "1" then
            XQLog.log(6, "SDK filter. mac:" .. macAddr .. " OK!")
            return true
        else
            XQLog.log(6, "SDK filter. mac:" .. macAddr .. " not allowed")
            return false
        end
    end
    
    return false
end

--- 设置SDK权限
--- @param macAddr string 设备MAC地址
--- @param allowed boolean 是否允许
function setPermission(macAddr, allowed)
    if XQFunction.isStrNil(macAddr) then
        return false
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local value = allowed and "1" or "0"
    XQPreference.set(_formatMac(macAddr), value, CONFIG_MACFILTER)
end
