--[[
IP-MAC绑定模块 (XQIPMacBind)
小米路由器IP与MAC地址绑定管理模块

功能概述:
=========
1. IP-MAC绑定管理
   - 添加IP-MAC绑定条目
   - 删除IP-MAC绑定条目
   - 批量添加/删除绑定
   - 清空所有绑定
   - 重新加载绑定配置

2. 地址验证
   - IP地址有效性检查
   - MAC地址格式验证
   - 单播MAC地址验证

依赖模块:
- xiaoqiang.common.XQFunction
- xiaoqiang.module.XQMacBind
- xiaoqiang.XQLog
- luci.cbi.datatypes
- luci.ip
- cjson

@module xiaoqiang.module.XQIPMacBind
@author Xiaomi
--]]

module("xiaoqiang.module.XQIPMacBind", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local DataTypes = require("luci.cbi.datatypes")
local XQLog = require("xiaoqiang.XQLog")
local cjson = require("cjson")

--[[
检查IP地址是否有效
验证IP是否在有效的公网/私网IP范围内
@param ip IP地址字符串
@return boolean 是否有效
--]]
local function checkIP(ip)
    local LuciIP = require("luci.ip")
    
    if XQFunction.isStrNil(ip) then
        return false
    end
    
    local ipNum = LuciIP.iptonl(ip)
    local rangeAStart = LuciIP.iptonl("1.0.0.0")
    local rangeAEnd = LuciIP.iptonl("126.0.0.0")
    local rangeBStart = LuciIP.iptonl("128.0.0.0")
    local rangeBEnd = LuciIP.iptonl("223.255.255.255")
    
    if ipNum >= rangeAStart and ipNum <= rangeAEnd then
        return true
    end
    
    if ipNum >= rangeBStart and ipNum <= rangeBEnd then
        return true
    end
    
    return false
end

--[[
检查MAC地址是否为单播地址
单播MAC地址的第一个字节最低位为0
@param mac MAC地址字符串
@return boolean 是否为有效的单播MAC地址
--]]
local function isUnicastMac(mac)
    if XQFunction.isStrNil(mac) then
        return false
    end
    
    local DataTypes = require("luci.cbi.datatypes")
    
    if DataTypes.macaddr(mac) then
        local firstByte = tonumber(mac:sub(1, 2), 16)
        local isUnicast = (firstByte % 2) == 0
        return isUnicast
    else
        return false
    end
end

--[[
检查MAC地址有效性
验证MAC地址格式且不是广播/全零地址
@param mac MAC地址字符串
@return boolean 是否有效
--]]
function _checkMac(mac)
    if XQFunction.isStrNil(mac) then
        return false
    end
    
    if isUnicastMac(mac) == false then
        return false
    end
    
    local DataTypes = require("luci.cbi.datatypes")
    
    if DataTypes.macaddr(mac) and mac ~= "ff:ff:ff:ff:ff:ff" and mac ~= "00:00:00:00:00:00" then
        return true
    else
        return false
    end
end

--[[
批量添加IP-MAC绑定
@param bindList 绑定列表,每项包含mac和ip字段
@return boolean 是否成功
--]]
function addIPMacBindList(bindList)
    for _, entry in ipairs(bindList) do
        local mac = string.lower(XQFunction.macFormat(entry.mac))
        local ip = entry.ip
        
        if checkIP(ip) and _checkMac(mac) then
            -- 验证通过,继续处理
        else
            XQLog.log(1, "illegal ip address")
            return false
        end
    end
    
    for _, entry in ipairs(bindList) do
        local mac = string.lower(XQFunction.macFormat(entry.mac))
        local ip = entry.ip
        local cmd = "/usr/sbin/ipmac_binding add " .. mac .. " " .. ip .. " > /dev/console"
        
        XQLog.log(6, "add ipmac cmd:" .. cmd)
        os.execute(cmd)
    end
    
    return true
end

--[[
添加单条IP-MAC绑定
@param mac MAC地址
@param ip IP地址
@return boolean 是否成功
--]]
function addIPMacBindEntry(mac, ip)
    local formattedMac = string.lower(XQFunction.macFormat(mac))
    
    if not checkIP(ip) or not _checkMac(formattedMac) then
        return false
    end
    
    local cmd = "/usr/sbin/ipmac_binding add " .. formattedMac .. " " .. ip .. " > /dev/console"
    
    XQLog.log(6, "add ipmac cmd:" .. cmd)
    os.execute(cmd)
    
    return true
end

--[[
批量删除IP-MAC绑定
@param macList MAC地址列表
@return boolean 是否成功
--]]
function delIPMacBindingList(macList)
    local LuciUtil = require("luci.util")
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    
    local bindInfo = XQMacBind.macBindInfo()
    
    for _, mac in ipairs(macList) do
        local lowerMac = string.lower(mac)
        local entry = bindInfo[lowerMac]
        
        if entry then
            local ip = entry.ip
            local cmd = "/usr/sbin/ipmac_binding del " .. string.lower(mac) .. " " .. ip .. " > /dev/console"
            
            XQLog.log(6, "del ipmac cmd:" .. cmd)
            os.execute(cmd)
        end
    end
    
    return true
end

--[[
清除旧的IP-MAC绑定会话
用于更新绑定时清理旧的连接会话
@param mac MAC地址
@param ip IP地址
@return boolean 是否成功
--]]
function ipMacBindclearOldSession(mac, ip)
    local formattedMac = string.lower(XQFunction.macFormat(mac))
    
    if not checkIP(ip) or not _checkMac(formattedMac) then
        return false
    end
    
    local cmd = "/usr/sbin/ipmac_binding clearSession " .. formattedMac .. " " .. ip .. " > /dev/console"
    
    XQLog.log(6, "add ipmac cmd:" .. cmd)
    os.execute(cmd)
    
    return true
end

--[[
删除单条IP-MAC绑定
@param mac MAC地址
@param ip IP地址
@return boolean 是否成功
--]]
function delIPMacBindingEntry(mac, ip)
    if not checkIP(ip) or not _checkMac(mac) then
        XQLog.log(1, "illegal ip address")
        return false
    end
    
    local cmd = "/usr/sbin/ipmac_binding del " .. string.lower(mac) .. " " .. ip .. " > /dev/console"
    
    XQLog.log(6, "del ipmac cmd:" .. cmd)
    os.execute(cmd)
    
    return true
end

--[[
清空所有IP-MAC绑定
@return boolean 是否成功
--]]
function flushIPMacBindingList()
    local cmd = "/usr/sbin/ipmac_binding flush > /dev/console"
    
    XQLog.log(6, "clean ipmac binding entry cmd:" .. cmd)
    os.execute(cmd)
    
    return true
end

--[[
重新加载IP-MAC绑定配置
从配置文件重新加载所有绑定规则
@return boolean 是否成功
--]]
function reloadIPMacBindingList()
    local cmd = "/usr/sbin/ipmac_binding reload > /dev/console"
    
    XQLog.log(6, "clean ipmac binding entry cmd:" .. cmd)
    os.execute(cmd)
    
    return true
end
