--[[
  MAC 绑定模块
  提供设备 MAC 地址与 IP 地址的绑定管理功能
  支持 IP-MAC 绑定检查、添加、删除等操作
]]

module("xiaoqiang.module.XQMacBind", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local logger = require("xiaoqiang.XQLog")
local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
local uciCursor = require("luci.model.uci").cursor()
local XQIPMacBind = require("xiaoqiang.module.XQIPMacBind")
local datatypes = require("luci.cbi.datatypes")
local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
local luciUtil = require("luci.util")
local cjson = require("cjson")

local features = require("xiaoqiang.XQFeatures").FEATURES
local ipMacCheckFeature = features.system and features.system.ipmaccheck
local ipMacCheckEnabled = (ipMacCheckFeature and ipMacCheckFeature == "1") and 1 or 0

function _checkIP(ip)
    if XQFunction.isStrNil(ip) then
        return false
    end
    
    local luciIp = require("luci.ip")
    local ipNum = luciIp.iptonl(ip)
    local classAStart = luciIp.iptonl("1.0.0.0")
    
    if ipNum >= classAStart then
        local classAEnd = luciIp.iptonl("126.0.0.0")
        if ipNum <= classAEnd then
            return true
        end
    end
    
    local classBStart = luciIp.iptonl("128.0.0.0")
    if ipNum >= classBStart then
        local classCEnd = luciIp.iptonl("223.255.255.255")
        if ipNum <= classCEnd then
            return true
        end
    end
    
    return false
end

local function _checkMacFormat(mac)
    if XQFunction.isStrNil(mac) then
        return false
    end
    
    local datatypes = require("luci.cbi.datatypes")
    if datatypes.macaddr(mac) then
        local firstByte = tonumber(mac:sub(1, 2), 16)
        local isUnicast = firstByte % 2 == 0
        return isUnicast
    else
        return false
    end
end

function _checkMac(mac)
    if XQFunction.isStrNil(mac) then
        return false
    end
    
    if _checkMacFormat(mac) == false then
        return false
    end
    
    local datatypes = require("luci.cbi.datatypes")
    if datatypes.macaddr(mac) and mac ~= "ff:ff:ff:ff:ff:ff" and mac ~= "00:00:00:00:00:00" then
        return true
    else
        return false
    end
end

function _parseMac(mac)
    if mac then
        return string.lower(string.gsub(mac, "[:-]", ""))
    else
        return nil
    end
end

function _parseDhcpLeases()
    local nixioFs = require("nixio.fs")
    local uci = require("luci.model.uci").cursor()
    local leaseList = {}
    local leaseFilePath = XQConfigs.DHCP_LEASE_FILEPATH
    
    uci:foreach("dhcp", "dnsmasq", function(section)
        if section.leasefile then
            if nixioFs.access(section.leasefile) then
                leaseFilePath = section.leasefile
                return false
            end
        end
    end)
    
    local leaseFile = io.open(leaseFilePath, "r")
    if leaseFile then
        for line in leaseFile:lines() do
            if line then
                local timestamp, mac, ip, hostname = line:match("^(%d+) (%S+) (%S+) (%S+)")
                if hostname == "*" then
                    hostname = ""
                end
                if timestamp and mac and ip and hostname then
                    local entry = {}
                    entry.mac = string.lower(XQFunction.macFormat(mac))
                    entry.ip = ip
                    entry.name = hostname
                    leaseList[ip] = entry
                end
            end
        end
        leaseFile:close()
    end
    
    return leaseList
end

function hookLanIPChangeEvent(newLanIp)
    if XQFunction.isStrNil(newLanIp) then
        return
    end
    
    local ipPrefix = newLanIp:gsub(".%d+$", "")
    
    uciCursor:foreach("macbind", "host", function(section)
        local oldIp = section.ip
        local lastOctet = oldIp:match(".(%d+)$")
        local newIp = ipPrefix .. "." .. lastOctet
        uciCursor:set("macbind", section[".name"], "ip", newIp)
    end)
    
    uciCursor:foreach("dhcp", "host", function(section)
        local oldIp = section.ip
        local lastOctet = oldIp:match(".(%d+)$")
        local newIp = ipPrefix .. "." .. lastOctet
        uciCursor:set("dhcp", section[".name"], "ip", newIp)
    end)
    
    uciCursor:commit("dhcp")
    uciCursor:commit("macbind")
end

function macBindInfo()
    local bindList = {}
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQEquipment = require("xiaoqiang.XQEquipment")
    
    uciCursor:foreach("dhcp", "host", function(section)
        local entry = {}
        entry.name = ""
        entry.mac = section.mac
        entry.ip = section.ip
        entry.tag = 2
        entry.instance = section.cwmp_LANDHCPStaticAddress_instance
        
        local macUpper = string.upper(section.mac)
        local displayName = ""
        local deviceInfo = XQDBUtil.fetchDeviceInfo(macUpper)
        
        if deviceInfo then
            local originalName = deviceInfo.oName
            local nickname = deviceInfo.nickname
            
            if not XQFunction.isStrNil(nickname) then
                displayName = nickname
            else
                local identified = XQEquipment.identifyDevice(macUpper, originalName)
                local deviceType = identified.type
                
                if XQFunction.isStrNil(displayName) then
                    if not XQFunction.isStrNil(deviceType.n) then
                        displayName = deviceType.n
                    end
                end
                
                if XQFunction.isStrNil(displayName) then
                    if not XQFunction.isStrNil(originalName) then
                        displayName = originalName
                    end
                end
                
                if XQFunction.isStrNil(displayName) then
                    if not XQFunction.isStrNil(identified.name) then
                        displayName = identified.name
                    end
                end
                
                if XQFunction.isStrNil(displayName) then
                    displayName = macUpper
                end
                
                if deviceType.c == 3 then
                    if XQFunction.isStrNil(nickname) then
                        displayName = deviceType.n
                    end
                end
            end
            entry.name = displayName
        end
        
        bindList[section.mac] = entry
    end)
    
    return bindList
end

function changeBindInfo(mac, ip, name)
    if not _checkIP(ip) then
        return false
    end
    
    if not _checkMac(mac) then
        return false
    end
    
    local parsedMac = _parseMac(mac)
    local entry = {}
    entry.name = parsedMac
    entry.mac = mac
    entry.ip = ip
    
    XQDBUtil.saveDeviceInfo(string.upper(mac), name, name, "", "")
    
    uciCursor:section("macbind", "host", parsedMac, entry)
    entry.name = ""
    uciCursor:section("dhcp", "host", parsedMac, entry)
    
    uciCursor:commit("macbind")
    uciCursor:commit("dhcp")
    
    return true
end

function setIPMACCheckEnable(enable)
    if ipMacCheckEnabled == 0 then
        return 0
    end
    
    if enable == nil then
        return 1523
    end
    
    if enable ~= 0 and enable ~= 1 then
        return 1523
    end
    
    if enable == 1 then
        uciCursor:set("firewall", "ipmacBind", "status", "on")
    else
        uciCursor:set("firewall", "ipmacBind", "status", "off")
    end
    
    uciCursor:commit("firewall")
    XQIPMacBind.reloadIPMacBindingList()
    
    return 0
end

function getIPMACCheckEnable()
    if ipMacCheckEnabled == 0 then
        return 0
    end
    
    local status = uciCursor:get("firewall", "ipmacBind", "status")
    if status and status == "on" then
        return 1
    end
    
    return 0
end

function addBind(mac, ip, name)
    if not _checkIP(ip) then
        return 2
    end
    
    if not _checkMac(mac) then
        return 2
    end
    
    local dhcpLeases = _parseDhcpLeases()
    local formattedMac = string.lower(XQFunction.macFormat(mac))
    mac = formattedMac
    
    local existingLease = dhcpLeases[ip]
    if existingLease then
        if existingLease.mac ~= mac then
            local arpResult = os.execute("arping -f -q -c 2 -w 2 -I br-lan " .. ip)
            if arpResult == 0 then
                return 1
            end
        end
    end
    
    local isBound = getMacbindStatus(mac)
    
    if isBound == true then
        local boundIp = getMacBindedIPInfo(mac)
        if boundIp == ip then
            XQDBUtil.saveDeviceInfo(string.upper(mac), name, name, "", "")
            return 0
        end
        
        if ipMacCheckEnabled then
            local delResult = XQIPMacBind.delIPMacBindingEntry(mac, boundIp)
            if true == delResult then
                local clearResult = XQIPMacBind.ipMacBindclearOldSession(mac, boundIp)
                if true == clearResult then
                    local addResult = XQIPMacBind.addIPMacBindEntry(mac, ip)
                    if true == addResult then
                        changeBindInfo(mac, ip, name)
                        return 0
                    end
                end
            else
                XQIPMacBind.reloadIPMacBindingList()
                return 4
            end
        end
    else
        if ipMacCheckEnabled then
            local addResult = XQIPMacBind.addIPMacBindEntry(mac, ip)
            if false == addResult then
                return 4
            end
        end
    end
    
    local parsedMac = _parseMac(mac)
    local entry = {}
    entry.name = parsedMac
    entry.mac = mac
    entry.ip = ip
    
    XQDBUtil.saveDeviceInfo(string.upper(mac), name, name, "", "")
    
    uciCursor:section("macbind", "host", parsedMac, entry)
    entry.name = ""
    uciCursor:section("dhcp", "host", parsedMac, entry)
    
    uciCursor:commit("macbind")
    uciCursor:commit("dhcp")
    
    return 0
end

function getMacbindStatus(mac)
    local bindList = macBindInfo()
    local macLower = string.lower(mac)
    local entry = bindList[macLower]
    
    if entry then
        return true
    end
    
    return false
end

function getMacBindList(deviceList)
    local result = {}
    local bindList = macBindInfo()
    
    for _, device in pairs(deviceList) do
        local macLower = string.lower(device.mac)
        local entry = bindList[macLower]
        
        if entry then
            local bindEntry = {}
            bindEntry.mac = entry.mac
            bindEntry.ip = entry.ip
            result[string.lower(host.mac)] = bindEntry
        end
    end
    
    return result
end

function getMacBindedIPInfo(mac)
    local bindList = macBindInfo()
    local macLower = string.lower(mac)
    local entry = bindList[macLower]
    
    if entry then
        return entry.ip
    end
    
    return 0
end

function addBinds(bindEntries)
    local ipUsed = {}
    local dhcpLeases = _parseDhcpLeases()
    
    if type(bindEntries) ~= "table" then
        return nil
    end
    
    for _, entry in pairs(bindEntries) do
        local mac = string.lower(XQFunction.macFormat(entry.mac))
        local ip = entry.ip
        
        if not _checkIP(ip) or not _checkMac(mac) then
            return 2
        end
        
        if ipUsed[ip] == 1 then
            return 3
        end
        ipUsed[ip] = 1
        
        local existingLease = dhcpLeases[ip]
        if existingLease then
            if existingLease.mac ~= mac then
                local arpResult = os.execute("arping -f -q -c 2 -w 2 -I br-lan " .. ip)
                if arpResult == 0 then
                    return 1
                end
            end
        end
    end
    
    for _, entry in pairs(bindEntries) do
        local mac = string.lower(XQFunction.macFormat(entry.mac))
        local ip = entry.ip
        local isBound = getMacbindStatus(mac)
        
        if ipMacCheckEnabled then
            if isBound == true then
                local boundIp = getMacBindedIPInfo(mac)
                if boundIp ~= ip then
                    local delResult = XQIPMacBind.delIPMacBindingEntry(mac, boundIp)
                    if false ~= delResult then
                        local addResult = XQIPMacBind.addIPMacBindEntry(mac, ip)
                    end
                    if false == addResult then
                        XQIPMacBind.reloadIPMacBindingList()
                        return 4
                    end
                end
            else
                local addResult = XQIPMacBind.addIPMacBindEntry(mac, ip)
                if false == addResult then
                    XQIPMacBind.reloadIPMacBindingList()
                    return 4
                end
            end
        end
    end
    
    for _, entry in pairs(bindEntries) do
        local mac = string.lower(XQFunction.macFormat(entry.mac))
        local ip = entry.ip
        local instance = entry.instance
        local deviceName = entry.name
        
        local parsedMac = _parseMac(mac)
        local bindEntry = {}
        bindEntry.name = parsedMac
        bindEntry.mac = mac
        bindEntry.ip = ip
        bindEntry.cwmp_LANDHCPStaticAddress_instance = instance
        
        XQDBUtil.saveDeviceInfo(string.upper(mac), deviceName, deviceName, "", "")
        
        uciCursor:section("macbind", "host", parsedMac, bindEntry)
        bindEntry.name = ""
        uciCursor:section("dhcp", "host", parsedMac, bindEntry)
    end
    
    uciCursor:commit("macbind")
    uciCursor:commit("dhcp")
    
    return 0
end

function removeBind(mac)
    if not _checkMac(mac) then
        return false
    end
    
    local parsedMac = _parseMac(mac)
    local boundIp = getMacBindedIPInfo(mac)
    
    if boundIp ~= 0 then
        if ipMacCheckEnabled then
            local delResult = XQIPMacBind.delIPMacBindingEntry(mac, boundIp)
            if delResult == false then
                return false
            end
        end
    end
    
    uciCursor:delete("dhcp", parsedMac)
    uciCursor:commit("dhcp")
    
    return true
end

function removeBinds(macList)
    if type(macList) ~= "table" then
        return nil
    end
    
    for _, mac in pairs(macList) do
        if not _checkMac(mac) then
            return false
        end
    end
    
    if ipMacCheckEnabled then
        for _, mac in pairs(macList) do
            local boundIp = getMacBindedIPInfo(mac)
            if boundIp ~= 0 then
                local delResult = XQIPMacBind.delIPMacBindingEntry(mac, boundIp)
                if delResult == false then
                    return false
                end
            end
        end
    end
    
    for _, mac in pairs(macList) do
        local parsedMac = _parseMac(mac)
        uciCursor:delete("dhcp", parsedMac)
    end
    
    uciCursor:commit("dhcp")
    
    return true
end

function unbindAll()
    uciCursor:delete_all("dhcp", "host")
    uciCursor:commit("dhcp")
    
    if ipMacCheckEnabled then
        XQIPMacBind.flushIPMacBindingList()
    end
end

function reload()
    os.execute("killall -s 10 noflushd ; /etc/init.d/dnsmasq restart")
end
