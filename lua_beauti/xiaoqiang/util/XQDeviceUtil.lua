--[[
  设备工具模块 (XQDeviceUtil)
  提供设备信息获取、设备列表管理、网络统计等功能
  主要用于管理连接到路由器的客户端设备
]]--

module("xiaoqiang.util.XQDeviceUtil", package.seeall)

local cjson = require("cjson")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQEquipment = require("xiaoqiang.XQEquipment")
local datatypes = require("luci.cbi.datatypes")

--[[
  根据MAC地址获取设备厂商信息
  @param mac MAC地址
  @return 设备厂商信息表 {name="", icon=""}
]]--
function getDeviceCompany(mac)
    local result = {
        name = "",
        icon = ""
    }
    
    if XQFunction.isStrNil(mac) then
        return result
    end
    
    if string.len(mac) < 8 then
        return result
    end
    
    return XQEquipment.identifyDevice(mac, nil)
end

--[[
  从数据库获取所有设备信息
  @return 以MAC为键的设备信息字典
]]--
function getDeviceInfoFromDB()
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local deviceDict = {}
    local devices, count = XQDBUtil.fetchAllDeviceInfo()
    
    if count > 0 then
        for _, device in ipairs(devices) do
            deviceDict[device.mac] = device
        end
    end
    
    return deviceDict
end

--[[
  从数据库获取所有设备MAC地址列表
  @return MAC地址列表
]]--
function getDeviceMacsFromDB()
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local macList = {}
    local devices, count = XQDBUtil.fetchAllDeviceInfo()
    
    if count > 0 then
        for _, device in ipairs(devices) do
            table.insert(macList, device.mac)
        end
    end
    
    return macList
end

--[[
  从UCI配置获取设备信息
  @return 以MAC为键的设备信息字典
]]--
function getDeviceInfoFromConfig()
    local uci = require("luci.model.uci").cursor()
    local deviceDict = {}
    
    uci:foreach("deviceinfo", "device", function(section)
        local info = {
            mac = XQFunction.macFormat(section.mac),
            owner = section.owner,
            device = section.device
        }
        deviceDict[info.mac] = info
    end)
    
    return deviceDict
end

--[[
  从UCI配置获取单个设备信息
  @param mac MAC地址
  @return 设备信息表 {owner="", device=""}
]]--
function fetchDeviceInfoFromConfig(mac)
    local result = {
        owner = "",
        device = ""
    }
    
    if XQFunction.isStrNil(mac) then
        return result
    end
    
    mac = XQFunction.macFormat(mac)
    local sectionName = string.lower(mac:gsub(":", ""))
    
    local uci = require("luci.model.uci").cursor()
    local section = uci:get_all("deviceinfo", sectionName)
    
    if section then
        result.owner = section.owner or ""
        result.device = section.device or ""
    end
    
    return result
end

--[[
  保存设备信息到UCI配置
  @param mac MAC地址
  @param owner 设备所有者
  @param device 设备类型
]]--
function saveDeviceInfo(mac, owner, device)
    if XQFunction.isStrNil(mac) then
        return
    end
    
    local uci = require("luci.model.uci").cursor()
    local formattedMac = XQFunction.macFormat(mac)
    local sectionName = string.lower(formattedMac:gsub(":", ""))
    
    local existing = uci:get_all("deviceinfo", sectionName)
    
    if existing then
        if owner then
            uci:set("deviceinfo", sectionName, "owner", owner)
        end
        if device then
            uci:set("deviceinfo", sectionName, "device", device)
        end
    else
        local newSection = {
            mac = formattedMac,
            owner = owner or "",
            device = device or ""
        }
        uci:section("deviceinfo", "device", sectionName, newSection)
    end
    
    uci:commit("deviceinfo")
end

--[[
  保存设备名称（同时更新数据库和配置）
  @param mac MAC地址
  @param nickname 设备昵称
  @param owner 设备所有者
  @param device 设备类型
  @return 是否成功
]]--
function saveDeviceName(mac, nickname, owner, device)
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    
    local formattedMac = XQFunction.macFormat(mac)
    
    XQSynchrodata.syncDeviceInfo({
        mac = formattedMac,
        nickname = nickname,
        owner = owner,
        device = device
    })
    
    local result = XQDBUtil.updateDeviceNickname(formattedMac, nickname)
    
    if result == 0 then
        saveDeviceInfo(formattedMac, owner, device)
        return true
    else
        return false
    end
end

--[[
  获取DHCP租约列表
  @return DHCP设备列表 [{mac, ip, name}, ...]
]]--
function getDHCPList()
    local nixio = require("nixio.fs")
    local uci = require("luci.model.uci").cursor()
    local dhcpList = {}
    local leaseFile = XQConfigs.DHCP_LEASE_FILEPATH
    
    uci:foreach("dhcp", "dnsmasq", function(section)
        if section.leasefile then
            if nixio.access(section.leasefile) then
                leaseFile = section.leasefile
                return false
            end
        end
    end)
    
    local file = io.open(leaseFile, "r")
    if file then
        for line in file:lines() do
            if line then
                local timestamp, mac, ip, name = line:match("^(%d+) (%S+) (%S+) (%S+)")
                if name == "*" then
                    name = ""
                end
                if timestamp and mac and ip and name then
                    table.insert(dhcpList, {
                        mac = XQFunction.macFormat(mac),
                        ip = ip,
                        name = name
                    })
                end
            end
        end
        file:close()
    end
    
    return dhcpList
end

--[[
  获取DHCP字典（以MAC为键）
  @return DHCP设备字典
]]--
function getDHCPDict()
    local dhcpDict = {}
    local dhcpList = getDHCPList()
    
    for _, device in ipairs(dhcpList) do
        dhcpDict[device.mac] = device
    end
    
    return dhcpDict
end

--[[
  获取DHCP字典（以IP为键）
  @return DHCP设备字典
]]--
function getDHCPIpDict()
    local dhcpDict = {}
    local dhcpList = getDHCPList()
    
    for _, device in ipairs(dhcpList) do
        dhcpDict[device.ip] = device
    end
    
    return dhcpDict
end

--[[
  获取设备名称列表
  @param macList MAC地址列表
  @return 以MAC为键的设备名称字典
]]--
function getDevicesName(macList)
    if not macList then
        return nil
    end
    
    if type(macList) ~= "table" then
        return {}
    end
    
    local nameDict = {}
    local deviceInfoDB = getDeviceInfoFromDB()
    local dhcpDict = getDHCPDict()
    
    for _, mac in ipairs(macList) do
        mac = XQFunction.macFormat(mac)
        local dbInfo = deviceInfoDB[mac]
        local dhcpInfo = dhcpDict[mac]
        
        if dbInfo then
            if not XQFunction.isStrNil(dbInfo.nickname) then
                nameDict[mac] = dbInfo.nickname
            end
        else
            local dhcpName = nil
            if dhcpInfo and not XQFunction.isStrNil(dhcpInfo.name) then
                dhcpName = dhcpInfo.name
                nameDict[mac] = dhcpInfo.name
            end
            
            local identified = XQEquipment.identifyDevice(mac, dhcpName)
            
            if XQFunction.isStrNil(nameDict[mac]) then
                if identified and not XQFunction.isStrNil(identified.type.n) then
                    nameDict[mac] = identified.type.n
                elseif identified and not XQFunction.isStrNil(identified.name) then
                    nameDict[mac] = identified.name
                else
                    nameDict[mac] = mac
                end
            end
        end
    end
    
    return nameDict
end

--[[
  获取设备权限信息
  @param macList MAC地址列表（可选）
  @return 以MAC为键的权限字典 {wan, lan, admin, pridisk}
]]--
function getDevicesPermissions(macList)
    local LuciUtil = require("luci.util")
    local cjson = require("json")
    local permissionDict = {}
    local allDevices = {}
    
    local macfilterOutput = LuciUtil.execl("/usr/sbin/sysapi macfilter get")
    local inputMacs = {}
    local lanPermissions = {}
    
    if macList and type(macList) == "table" then
        inputMacs = macList
    else
        for _, line in ipairs(macfilterOutput) do
            local mac = line:match("mac=(%S-);")
            if mac and mac ~= "" then
                table.insert(inputMacs, XQFunction.macFormat(mac))
            end
        end
    end
    
    local request = {
        api = 70,
        macs = inputMacs
    }
    local response = XQFunction.thrift_tunnel_to_datacenter(cjson.encode(request))
    
    if response and response.code == 0 then
        for i, canAccess in ipairs(response.canAccessAllDisk) do
            local mac = inputMacs[i]
            lanPermissions[mac] = canAccess
        end
    end
    
    for _, line in ipairs(macfilterOutput) do
        line = line .. ";"
        local mac = line:match("mac=(%S-);") or ""
        local wan = line:match("wan=(%S-);") or ""
        local lan = line:match("lan=(%S-);") or ""
        local admin = line:match("admin=(%S-);") or ""
        local pridisk = line:match("pridisk=(%S-);") or ""
        
        local permission = {}
        
        if mac then
            mac = XQFunction.macFormat(mac)
            permission.wan = (tostring(wan) == "0") and 0 or 1
            permission.lan = (string.upper(lan) == "YES") and 1 or 0
            permission.admin = (string.upper(admin) == "YES") and 1 or 0
            permission.pridisk = (string.upper(pridisk) == "YES") and 1 or 0
            
            if lanPermissions[mac] ~= nil then
                permission.lan = lanPermissions[mac] and 1 or 0
            end
            
            allDevices[mac] = permission
        end
    end
    
    for _, mac in ipairs(inputMacs) do
        if allDevices[mac] then
            permissionDict[mac] = allDevices[mac]
        else
            permissionDict[mac] = {
                wan = 1,
                lan = lanPermissions[mac] and 1 or 0,
                admin = 1,
                pridisk = 0
            }
        end
    end
    
    return permissionDict
end

--[[
  获取WAN/LAN网络统计信息
  @param interface 接口类型 "lan" 或 "wan"
  @return 网络统计信息表
]]--
function getWanLanNetworkStatistics(interface)
    local LuciUtil = require("luci.util")
    local cmd = ""
    
    if interface == "lan" then
        cmd = "ubus call trafficd lan"
    elseif interface == "wan" then
        cmd = "ubus call trafficd wan"
    end
    
    local result = {
        upload = "0",
        upspeed = "0",
        download = "0",
        downspeed = "0",
        devname = "",
        maxuploadspeed = "0",
        maxdownloadspeed = "0"
    }
    
    local output = LuciUtil.exec(cmd)
    if XQFunction.isStrNil(output) then
        return result
    end
    
    local data = cjson.decode(output)
    if not data then
        return result
    end
    
    result.devname = tostring(data.devname or "")
    result.upload = tostring(data.tx_bytes or 0)
    result.download = tostring(data.rx_bytes or 0)
    result.upspeed = tostring(data.tx_rate or 0)
    result.downspeed = tostring(data.rx_rate or 0)
    result.maxuploadspeed = tostring(data.max_tx_rate or 0)
    result.maxdownloadspeed = tostring(data.max_rx_rate or 0)
    
    return result
end

--[[
  获取设备网络统计列表
  @return 设备网络统计列表
]]--
function getDevNetStatisticsList()
    local LuciUtil = require("luci.util")
    local deviceList = {}
    local dhcpDict = getDHCPDict()
    local deviceInfoDB = getDeviceInfoFromDB()
    
    local output = LuciUtil.exec("ubus call trafficd hw")
    if XQFunction.isStrNil(output) then
        return deviceList
    end
    
    local data = cjson.decode(output)
    if not data then
        return deviceList
    end
    
    for mac, info in pairs(data) do
        if info then
            local device = {}
            local formattedMac = XQFunction.macFormat(mac)
            local dhcpName, nickname, deviceName = nil, nil, nil
            
            local dhcpInfo = dhcpDict[formattedMac]
            if dhcpInfo then
                dhcpName = dhcpInfo.name
            end
            
            local dbInfo = deviceInfoDB[formattedMac]
            if dbInfo then
                if XQFunction.isStrNil(dhcpName) then
                    dhcpName = dbInfo.oName
                end
                nickname = dbInfo.nickname
            end
            
            local identified = XQEquipment.identifyDevice(formattedMac, dhcpName)
            local deviceType = identified.type
            
            if not XQFunction.isStrNil(nickname) then
                deviceName = nickname
            end
            
            if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(deviceType.n) then
                deviceName = deviceType.n
            end
            
            if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(dhcpName) then
                deviceName = dhcpName
            end
            
            if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(identified.name) then
                deviceName = identified.name
            end
            
            if XQFunction.isStrNil(deviceName) then
                deviceName = formattedMac
            end
            
            local upload, upspeed, download, downspeed = 0, 0, 0, 0
            local maxUploadSpeed, maxDownloadSpeed = 0, 0
            
            local ipList = info.ip_list
            if ipList and #ipList > 0 then
                for _, ipInfo in ipairs(ipList) do
                    upload = upload + (ipInfo.tx_bytes or 0)
                    download = download + (ipInfo.rx_bytes or 0)
                    upspeed = upspeed + (ipInfo.tx_rate or 0)
                    downspeed = downspeed + (ipInfo.rx_rate or 0)
                    maxUploadSpeed = maxUploadSpeed + (ipInfo.max_tx_rate or 0)
                    maxDownloadSpeed = maxDownloadSpeed + (ipInfo.max_rx_rate or 0)
                end
            end
            
            device.mac = formattedMac
            device.upload = tostring(upload)
            device.upspeed = tostring(upspeed)
            device.download = tostring(download)
            device.downspeed = tostring(downspeed)
            device.online = tostring(info.online_timer or 0)
            device.devname = deviceName
            device.isap = info.is_ap or 0
            device.maxuploadspeed = tostring(maxUploadSpeed)
            device.maxdownloadspeed = tostring(maxDownloadSpeed)
            
            table.insert(deviceList, device)
        end
    end
    
    return deviceList
end

--[[
  获取设备网络统计字典（以MAC为键）
  @return 设备网络统计字典
]]--
function getDevNetStatisticsDict()
    local deviceDict = {}
    local deviceList = getDevNetStatisticsList()
    
    for _, device in ipairs(deviceList) do
        if device then
            deviceDict[device.mac] = device
        end
    end
    
    return deviceDict
end

--[[
  获取2.4G和5G设备数量
  @return 2.4G设备数, 5G设备数
]]--
function get2g5gDeviceCount()
    local LuciUtil = require("luci.util")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local totalCount = 0
    local output = LuciUtil.exec("ubus call trafficd hw 2>/dev/null")
    
    local wlanCount = XQWifiUtil.get_wlan_count()
    local wlanIfname = XQWifiUtil.get_wlan_ifname()
    local wlan5gIfname = XQWifiUtil.get_wlan_wifi5_ifname()
    
    local bandCount = {}
    local connectedCount = 0
    
    for i = 1, wlanCount do
        bandCount[i] = 0
    end
    
    if XQFunction.isStrNil(output) then
        local hwCount = XQWifiUtil.get_wl_con_dev_num(1)
        bandCount[1] = hwCount
        connectedCount = connectedCount + hwCount
        return bandCount, connectedCount
    end
    
    local data = cjson.decode(output)
    if not data then
        return bandCount, connectedCount
    end
    
    for _, info in pairs(data) do
        if info.is_ap == 1 then
            local ifname = info.ifname
            if ifname then
                for i, wlIf in ipairs(wlanIfname) do
                    if ifname == wlIf then
                        local ipCount = #(info.ip_list or {})
                        bandCount[i] = bandCount[i] + ipCount
                    end
                end
                
                for i, wl5If in ipairs(wlan5gIfname) do
                    if ifname == wl5If then
                        local ipCount = #(info.ip_list or {})
                        bandCount[i] = bandCount[i] + ipCount
                    end
                end
                
                totalCount = totalCount + 1
            end
        end
    end
    
    return bandCount, totalCount
end

--[[
  获取Mesh设备数量
  @return Mesh主设备数, Mesh从设备数
]]--
function getMeshDeviceCount()
    local LuciUtil = require("luci.util")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local masterCount = 0
    local slaveCount = 0
    
    local output = LuciUtil.exec("ubus call trafficd hw")
    if XQFunction.isStrNil(output) then
        return 0, 0
    end
    
    local data = cjson.decode(output)
    if not data then
        return 0, 0
    end
    
    local lanIpPre = XQLanWanUtil.getLanIpPre()
    
    for _, info in pairs(data) do
        local ifname = info.ifname
        if info.ip_list then
            for _, ipInfo in ipairs(info.ip_list) do
                local ignore = false
                
                if ifname ~= "wl1.2" and ifname ~= "wl3" and ifname ~= "wl14" and ifname ~= "wl15" and lanIpPre then
                    if ipInfo.ip then
                        if not ipInfo.ip:match("^" .. lanIpPre) then
                            if ipInfo.ip ~= "0.0.0.0" then
                                ignore = true
                            end
                        end
                    end
                end
                
                if not ignore then
                    local isAp = info.is_ap
                    if isAp == 8 or isAp == 4 then
                        local assoc = tonumber(info.assoc)
                        if assoc == 1 then
                            if isAp == 8 then
                                slaveCount = slaveCount + 1
                            end
                            if isAp == 4 then
                                masterCount = masterCount + 1
                            end
                        end
                    end
                end
            end
        end
    end
    
    return masterCount, slaveCount
end

--[[
  获取设备总数（在线和历史）
  @return 在线设备数, 历史设备数, 在线非AP设备数, 历史非AP设备数
]]--
function getDeviceCount()
    local LuciUtil = require("luci.util")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local onlineCount = 0
    local historyCount = 0
    local onlineNonApCount = 0
    local historyNonApCount = 0
    
    local output = LuciUtil.exec("ubus call trafficd hw")
    if XQFunction.isStrNil(output) then
        return 0, 0, 0, 0
    end
    
    local data = cjson.decode(output)
    if not data then
        return 0, 0, 0, 0
    end
    
    local dbDevices = XQDBUtil.fetchAllDeviceInfo()
    local lanIpPre = XQLanWanUtil.getLanIpPre()
    
    if dbDevices then
        for _, dbDevice in ipairs(dbDevices) do
            if dbDevice then
                local mac = dbDevice.mac
                local trafficInfo = data[mac]
                
                if not trafficInfo then
                    if not XQFunction.isStrNil(dbDevice.oName) or not XQFunction.isStrNil(dbDevice.nickname) then
                        historyCount = historyCount + 1
                        historyNonApCount = historyNonApCount + 1
                    end
                end
            end
        end
    end
    
    for _, info in pairs(data) do
        local ifname = info.ifname
        if info.ip_list then
            for _, ipInfo in ipairs(info.ip_list) do
                local ignore = false
                
                if ifname ~= "wl1.2" and ifname ~= "wl3" and ifname ~= "wl14" and lanIpPre then
                    if ipInfo.ip then
                        if not ipInfo.ip:match("^" .. lanIpPre) then
                            if ipInfo.ip ~= "0.0.0.0" then
                                ignore = true
                            end
                        end
                    end
                end
                
                if not ignore then
                    if ifname:match("wl") then
                        local isAp = info.is_ap
                        if isAp ~= 8 and isAp ~= 4 then
                            if ifname:match("wl") then
                                local assoc = tonumber(info.assoc)
                                if assoc == 1 then
                                    if ipInfo.ageing_timer <= 300 then
                                        onlineCount = onlineCount + 1
                                        if isAp ~= 4 and isAp ~= 8 then
                                            onlineNonApCount = onlineNonApCount + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    historyCount = historyCount + 1
                    local isAp = info.is_ap
                    if isAp ~= 4 and isAp ~= 8 then
                        historyNonApCount = historyNonApCount + 1
                    end
                end
            end
        end
    end
    
    return onlineCount, historyCount, onlineNonApCount, historyNonApCount
end

--[[
  获取已连接设备数量
  @return 已连接设备数量
]]--
function getConnectDeviceCount()
    local LuciUtil = require("luci.util")
    local count = 0
    
    local output = LuciUtil.exec("ubus call trafficd hw")
    if XQFunction.isStrNil(output) then
        return count
    end
    
    local data = cjson.decode(output)
    if not data then
        return count
    end
    
    for _, info in pairs(data) do
        if info and info.ip_list and #info.ip_list > 0 then
            local ifname = info.ifname
            if ifname and ifname:match("wl") then
                local assoc = tonumber(info.assoc)
                if assoc == 1 then
                    for _, ipInfo in ipairs(info.ip_list) do
                        if ipInfo.ageing_timer <= 300 then
                            if ipInfo.tx_bytes ~= 0 or ipInfo.rx_bytes ~= 0 then
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
    end
    
    return count
end

--[[
  获取特殊设备数量（小米电视、小米盒子）
  @return {mitv=数量, mibox=数量}
]]--
function getSpecialDevCount()
    local XQEquipment = require("xiaoqiang.XQEquipment")
    local result = {
        mitv = 0,
        mibox = 0
    }
    
    local deviceInfoDB = getDeviceInfoFromDB()
    
    for mac, info in pairs(deviceInfoDB) do
        if info and not XQFunction.isStrNil(info.oName) then
            local formattedMac = XQFunction.macFormat(mac)
            local oName = info.oName
            
            if oName:match("^mitv") then
                result.mitv = result.mitv + 1
            end
            
            if oName:match("^mibox") then
                result.mibox = result.mibox + 1
            end
        end
    end
    
    return result
end

--[[
  获取单个设备详细信息
  @param mac MAC地址
  @param withAuthority 是否包含权限信息
  @return 设备详细信息表
]]--
function getDeviceInfo(mac, withAuthority)
    local result = {
        flag = 0,
        name = "",
        mac = "",
        dhcpname = "",
        type = {
            c = 0,
            p = 0,
            n = ""
        }
    }
    
    if XQFunction.isStrNil(mac) then
        return result
    end
    
    mac = XQFunction.macFormat(mac)
    
    local XQEquipment = require("xiaoqiang.XQEquipment")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    
    local dhcpDict = getDHCPDict()
    local dhcpInfo = dhcpDict[mac]
    local dbInfo = XQDBUtil.fetchDeviceInfo(mac)
    
    local deviceName, dhcpName, nickname = nil, nil, nil
    
    if dhcpInfo and dhcpInfo.name then
        dhcpName = dhcpInfo.name
    end
    
    if dbInfo then
        if not XQFunction.isStrNil(dbInfo.mac) then
            result.flag = 1
        end
        
        if not XQFunction.isStrNil(dbInfo.nickname) then
            nickname = dbInfo.nickname
            deviceName = nickname
        end
        
        if not XQFunction.isStrNil(dbInfo.oName) then
            if XQFunction.isStrNil(dhcpName) then
                dhcpName = dbInfo.oName
            end
        end
    end
    
    local identified = XQEquipment.identifyDevice(mac, dhcpName)
    local deviceType = identified.type
    
    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(deviceType.n) then
        deviceName = deviceType.n
    end
    
    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(dhcpName) then
        deviceName = dhcpName
    end
    
    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(identified.name) then
        deviceName = identified.name
    end
    
    if XQFunction.isStrNil(deviceName) then
        deviceName = mac
    end
    
    if deviceType.c == 3 and XQFunction.isStrNil(nickname) then
        deviceName = deviceType.n
    end
    
    local configInfo = fetchDeviceInfoFromConfig(mac)
    
    result.mac = mac
    result.name = deviceName
    result.owner = configInfo.owner or ""
    result.device = configInfo.device or ""
    result.dhcpname = dhcpName or ""
    result.type = deviceType
    
    if withAuthority then
        local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
        local macfilterDict = XQFirewall.getMacfilterInfoDict()
        
        local lanPermission = nil
        local request = {
            api = 70,
            macs = {mac}
        }
        local response = XQFunction.thrift_tunnel_to_datacenter(cjson.encode(request))
        
        if response and response.code == 0 then
            lanPermission = response.canAccessAllDisk[1]
        end
        
        local authority = {}
        local macfilterInfo = macfilterDict[mac]
        
        if macfilterInfo then
            authority.wan = macfilterInfo.wan and 1 or 0
            authority.lan = macfilterInfo.lan and 1 or 0
            authority.admin = macfilterInfo.admin and 1 or 0
            authority.pridisk = macfilterInfo.pridisk and 1 or 0
        else
            authority.wan = 1
            authority.lan = 1
            authority.admin = 1
            authority.pridisk = 0
        end
        
        if lanPermission ~= nil then
            authority.lan = lanPermission and 1 or 0
        end
        
        local notifyDict = XQPushUtil.notifyDict()
        local push = 0
        local macNoColon = mac:gsub(":", "")
        
        if notifyDict[macNoColon] then
            push = 1
        end
        
        local authenFailedTimes = XQPushUtil.getAuthenFailedTimes(mac) or 0
        
        result.push = push
        result.times = authenFailedTimes
        result.authority = authority
    end
    
    return result
end

--[[
  获取设备列表
  @param onlineOnly 是否只获取在线设备
  @param wifiOnly 是否只获取WiFi设备
  @return 设备列表
]]--
function getDeviceList(onlineOnly, wifiOnly)
    local datatypes = require("luci.cbi.datatypes")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQEquipment = require("xiaoqiang.XQEquipment")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local LuciUtil = require("luci.util")
    
    local deviceList = {}
    
    local isMeshRe = XQFunction.isMeshRe()
    if isMeshRe then
        deviceList = XQWifiUtil.getWifiAllDeviceMacList()
        return deviceList
    end
    
    local cmd = "ubus call trafficd hw"
    local output = LuciUtil.exec(cmd)
    
    if XQFunction.isStrNil(output) then
        return deviceList
    end
    
    local trafficData = cjson.decode(output)
    if not trafficData then
        return deviceList
    end
    
    local macfilterDict = XQFirewall.getMacfilterInfoDict()
    local dhcpIpDict = getDHCPIpDict()
    local deviceInfoDB = getDeviceInfoFromDB()
    local notifyDict = XQPushUtil.notifyDict()
    local authenTimesDict = XQPushUtil.getAuthenFailedTimesDict()
    local wifiMacfilterModel = XQWifiUtil.getWiFiMacfilterModel()
    
    local wlanIfname = XQWifiUtil.get_wlan_ifname()
    local guestIfname2g = XQWifiUtil.get_wlan_guest_ifname()
    local guestIfname5g = XQWifiUtil.get_wlan_wifi5_ifname()
    
    local lanIpPre = XQLanWanUtil.getLanIpPre()
    local netMode = XQFunction.getNetMode()
    
    for mac, info in pairs(trafficData) do
        local isValid = true
        local ifname = info.ifname
        local formattedMac = XQFunction.macFormat(mac)
        
        local connectionType, port = nil, nil
        
        if ifname:match("eth") then
            connectionType = "line"
            port = 0
        elseif ifname == "" then
            local assoc = tonumber(info.assoc)
            if assoc == 1 then
                ifname = "eth"
                connectionType = "line"
                port = 0
            end
        else
            if wlanIfname[2] and ifname == wlanIfname[2] then
                connectionType = "wifi"
                port = 2
            elseif wlanIfname[1] and ifname == wlanIfname[1] then
                connectionType = "wifi"
                port = 1
            elseif wlanIfname[3] and ifname == wlanIfname[3] then
                connectionType = "wifi"
                local gameSupport = XQWifiUtil.getGameWifiSupport()
                port = gameSupport and 6 or 7
            elseif ifname == guestIfname2g or ifname == guestIfname5g then
                connectionType = "wifi"
                port = 3
            end
        end
        
        if not XQFunction.isStrNil(ifname) then
            for _, ipInfo in ipairs(info.ip_list or {}) do
                local ignore = false
                
                if ifname ~= "wl1.2" and ifname ~= "wl3" and ifname ~= "wl14" and ifname ~= "wl15" and lanIpPre then
                    if ipInfo.ip then
                        if not ipInfo.ip:match("^" .. lanIpPre) then
                            if ipInfo.ip ~= "0.0.0.0" then
                                ignore = true
                            end
                        end
                    end
                end
                
                if not ignore then
                    local dhcpName, nickname = nil, nil
                    local dhcpInfo = dhcpIpDict[ipInfo.ip]
                    
                    if dhcpInfo then
                        dhcpName = dhcpInfo.name
                    end
                    
                    local dbInfo = deviceInfoDB[formattedMac]
                    if dbInfo then
                        if XQFunction.isStrNil(dhcpName) then
                            dhcpName = dbInfo.oName
                        end
                        nickname = dbInfo.nickname
                    end
                    
                    local deviceName = nil
                    if not XQFunction.isStrNil(nickname) then
                        deviceName = nickname
                    end
                    
                    local identified = XQEquipment.identifyDevice(formattedMac, dhcpName)
                    local deviceType = identified.type
                    
                    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(deviceType.n) then
                        deviceName = deviceType.n
                    end
                    
                    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(dhcpName) then
                        deviceName = dhcpName
                    end
                    
                    if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(identified.name) then
                        deviceName = identified.name
                    end
                    
                    if XQFunction.isStrNil(deviceName) then
                        deviceName = formattedMac
                    end
                    
                    local push = 0
                    local macNoColon = formattedMac:gsub(":", "")
                    if notifyDict[macNoColon] then
                        push = 1
                    end
                    
                    local authenTimes = tonumber(authenTimesDict[macNoColon]) or 0
                    
                    local authority = {}
                    local macfilterInfo = macfilterDict[formattedMac]
                    
                    if macfilterInfo then
                        authority.wan = macfilterInfo.wan and 1 or 0
                        authority.lan = macfilterInfo.lan and 1 or 0
                        authority.admin = macfilterInfo.admin and 1 or 0
                        authority.pridisk = macfilterInfo.pridisk and 1 or 0
                    else
                        authority.wan = 1
                        authority.lan = 1
                        authority.admin = 1
                        authority.pridisk = 0
                    end
                    
                    local online = 0
                    local assoc = tonumber(info.assoc)
                    if assoc == 1 then
                        online = 1
                    end
                    
                    local device = {
                        ip = ipInfo.ip,
                        mac = formattedMac,
                        online = online,
                        type = connectionType,
                        port = port,
                        ctype = deviceType.c,
                        ptype = deviceType.p,
                        origin_name = dhcpName or "",
                        name = deviceName,
                        push = push,
                        company = identified,
                        times = authenTimes,
                        authority = authority,
                        parent = info.parent or "",
                        isap = tonumber(info.is_ap) or 0,
                        hostname = info.hostname or "",
                        statistics = {
                            dev = ifname,
                            mac = formattedMac,
                            ip = ipInfo.ip,
                            upload = tostring(ipInfo.tx_bytes or 0),
                            upspeed = tostring(math.floor(ipInfo.tx_rate or 0)),
                            download = tostring(ipInfo.rx_bytes or 0),
                            downspeed = tostring(math.floor(ipInfo.rx_rate or 0)),
                            online = tostring(info.online_timer or 0),
                            maxuploadspeed = tostring(math.floor(ipInfo.max_tx_rate or 0)),
                            maxdownloadspeed = tostring(math.floor(ipInfo.max_rx_rate or 0))
                        }
                    }
                    
                    if onlineOnly and online == 1 then
                        table.insert(deviceList, device)
                    elseif not onlineOnly then
                        table.insert(deviceList, device)
                    end
                end
            end
        end
    end
    
    return deviceList
end

--[[
  获取设备列表V2版本（增强版）
  @param onlineOnly 是否只获取在线设备
  @param includeOffline 是否包含离线设备
  @param mloEnabled 是否启用MLO
  @return 设备列表
]]--
function getDeviceListV2(onlineOnly, includeOffline, mloEnabled)
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    local LuciUtil = require("luci.util")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQEquipment = require("xiaoqiang.XQEquipment")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local uci = require("luci.model.uci").cursor()
    local XQParentControl = require("xiaoqiang.module.XQParentControl")
    
    local wlanIfname = XQWifiUtil.get_wlan_ifname()
    local deviceList = {}
    
    local cmd = "ubus call trafficd hw '{\"mlo\":" .. tostring(mloEnabled or false) .. "}'"
    local output = LuciUtil.exec(cmd)
    
    if XQFunction.isStrNil(output) then
        return deviceList
    end
    
    local trafficData = cjson.decode(output)
    if not trafficData then
        return deviceList
    end
    
    local lanIpPre = XQLanWanUtil.getLanIpPre()
    local macfilterDict = XQFirewall.getMacfilterInfoDict("wan")
    local dhcpDict = getDHCPDict()
    local deviceInfoDB = getDeviceInfoFromDB()
    local notifyDict = XQPushUtil.notifyDict()
    local authenTimesDict = XQPushUtil.getAuthenFailedTimesDict()
    
    for mac, info in pairs(trafficData) do
        local formattedMac = XQFunction.macFormat(mac)
        local ifname = info.ifname
        
        local isOnline = false
        for _, ipInfo in ipairs(info.ip_list or {}) do
            local assoc = tonumber(info.assoc)
            if assoc == 1 then
                isOnline = true
                break
            end
        end
        
        local device = {
            mac = formattedMac,
            online = isOnline and 1 or 0
        }
        
        local dhcpName, nickname = nil, nil
        local dhcpInfo = dhcpDict[formattedMac]
        if dhcpInfo then
            dhcpName = dhcpInfo.name
        end
        
        local dbInfo = deviceInfoDB[formattedMac]
        if dbInfo then
            if XQFunction.isStrNil(dhcpName) then
                dhcpName = dbInfo.oName
            end
            nickname = dbInfo.nickname
        end
        
        local identified = XQEquipment.identifyDevice(formattedMac, dhcpName)
        local deviceType = identified.type
        
        local deviceName = nickname
        if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(deviceType.n) then
            deviceName = deviceType.n
        end
        if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(dhcpName) then
            deviceName = dhcpName
        end
        if XQFunction.isStrNil(deviceName) and not XQFunction.isStrNil(identified.name) then
            deviceName = identified.name
        end
        if XQFunction.isStrNil(deviceName) then
            deviceName = formattedMac
        end
        
        device.name = deviceName
        device.oname = dhcpName or ""
        device.icon = identified.icon or ""
        
        local push = 0
        local authenTimes = 0
        local macNoColon = formattedMac:gsub(":", "")
        
        if notifyDict[macNoColon] then
            push = 1
        end
        authenTimes = tonumber(authenTimesDict[macNoColon]) or 0
        
        device.push = push
        device.times = authenTimes
        
        local authority = {}
        local macfilterInfo = macfilterDict[formattedMac]
        local macfilterMode = uci:get("macfilter", "settings", "mode")
        
        if macfilterInfo then
            authority.wan = macfilterInfo.wan and 1 or 0
        elseif macfilterMode == "black" then
            authority.wan = 1
        else
            authority.wan = 0
        end
        
        device.authority = authority
        
        local ipList = {}
        local statistics = {}
        
        for _, ipInfo in ipairs(info.ip_list or {}) do
            local ignore = false
            
            if ifname ~= "wl1.2" and ifname ~= "wl3" and ifname ~= "wl14" and ifname ~= "wl15" and lanIpPre then
                if ipInfo.ip then
                    if not ipInfo.ip:match("^" .. lanIpPre) then
                        if ipInfo.ip ~= "0.0.0.0" then
                            ignore = true
                        end
                    end
                end
            end
            
            if not ignore then
                local active = 0
                local assoc = tonumber(info.assoc)
                if assoc == 1 then
                    active = 1
                end
                
                local ipEntry = {
                    ip = ipInfo.ip,
                    active = active,
                    upspeed = tostring(math.floor(ipInfo.tx_rate or 0)),
                    downspeed = tostring(math.floor(ipInfo.rx_rate or 0)),
                    online = tostring(info.online_timer or 0)
                }
                
                if active == 1 or not onlineOnly then
                    table.insert(ipList, ipEntry)
                    
                    if not statistics.online then
                        statistics.online = ipEntry.online
                    end
                    
                    statistics.upspeed = tostring(
                        (tonumber(statistics.upspeed) or 0) + tonumber(ipEntry.upspeed)
                    )
                    statistics.downspeed = tostring(
                        (tonumber(statistics.downspeed) or 0) + tonumber(ipEntry.downspeed)
                    )
                end
            end
        end
        
        device.ip = ipList
        device.statistics = statistics
        
        if (isOnline and onlineOnly) or not onlineOnly then
            table.insert(deviceList, device)
        end
    end
    
    return deviceList
end

--[[
  获取设备列表V3版本（带QoS信息）
  @param deviceId 设备ID（可选）
  @return 设备列表
]]--
function getDeviceListV3(deviceId)
    local LuciUtil = require("luci.util")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local deviceList = {}
    
    local cmd1 = "ubus call trafficd hw '{\"wlan\":true,\"port\":true}'"
    local output1 = LuciUtil.exec(cmd1)
    
    local cmd2 = "ubus call trafficd hw '{\"leaf\": false}'"
    local output2 = LuciUtil.exec(cmd2)
    
    local miqos = require("miqos")
    local qosResult = miqos.cmd("show_limit")
    local qosData = nil
    
    if qosResult and qosResult.status == 0 and qosResult.data then
        qosData = qosResult.data
    end
    
    if XQFunction.isStrNil(output1) then
        return deviceList
    end
    
    local trafficData = cjson.decode(output1)
    if not trafficData then
        return deviceList
    end
    
    local context = {
        lanipPre = XQLanWanUtil.getLanIpPre(),
        dhcpDict = getDHCPDict(),
        deviceDict = getDeviceInfoFromDB()
    }
    
    for mac, info in pairs(trafficData) do
        local formattedMac = XQFunction.macFormat(mac)
        local device = buildDeviceInfoV3(formattedMac, info, deviceId, context)
        
        if device and device.ip then
            device.qos_info = {
                mac = formattedMac
            }
            
            if qosData then
                local ipQos = qosData[device.ip]
                if ipQos then
                    device.qos_info.downmax = tonumber(ipQos.DOWN.max_per) / 8
                    device.qos_info.upmax = tonumber(ipQos.UP.max_per) / 8
                    device.qos_info.flag = ipQos.flag
                end
            else
                device.qos_info.downmax = 0
                device.qos_info.upmax = 0
                device.qos_info.flag = "off"
            end
            
            table.insert(deviceList, device)
        end
    end
    
    return deviceList
end

--[[
  获取设备信息（供MAgent使用）
  @return 设备信息字典
]]--
function devicesInfo()
    local datatypes = require("luci.cbi.datatypes")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    local XQParentControl = require("xiaoqiang.module.XQParentControl")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    
    local deviceDict = {}
    local macList = {}
    local macSet = {}
    local lanPermissions = {}
    
    local notifyDict = XQPushUtil.notifyDict()
    local deviceInfoDB = getDeviceInfoFromDB()
    local macfilterDict = XQFirewall.getMacfilterInfoDict()
    local configInfo = getDeviceInfoFromConfig()
    local wifiMacfilterModel = XQWifiUtil.getWiFiMacfilterModel()
    
    local limitedMacs = {}
    if wifiMacfilterModel == 1 then
        local blacklist = XQWifiUtil.getWiFiMacfilterList()
        if blacklist then
            for _, mac in ipairs(blacklist) do
                limitedMacs[mac] = 1
            end
        end
    end
    
    for mac, info in pairs(deviceInfoDB) do
        if datatypes.macaddr(mac) then
            deviceDict[mac] = {
                nickname = info.nickname
            }
            macSet[mac] = 1
            table.insert(macList, mac)
        end
    end
    
    local request = {
        api = 70,
        macs = macList
    }
    local response = XQFunction.thrift_tunnel_to_datacenter(cjson.encode(request))
    
    if response and response.code == 0 then
        lanPermissions = response.canAccessAllDisk
    end
    
    local urlfilterInfo = XQParentControl.get_urlfilter_info(macSet)
    local result = {}
    
    for mac, info in pairs(deviceDict) do
        local macfilterInfo = macfilterDict[mac]
        local configData = configInfo[mac]
        local notified = notifyDict[mac]
        
        if notified then
            info.push = 1
        else
            info.push = 0
        end
        
        info.pcontrol = urlfilterInfo[mac]
        info.netacctl = urlfilterInfo[mac]
        info.urlfilter = urlfilterInfo[mac]
        
        if macfilterInfo then
            info.wan = macfilterInfo.wan and 1 or 0
            info.lan = macfilterInfo.lan and 1 or 0
            info.admin = macfilterInfo.admin and 1 or 0
            info.pridisk = macfilterInfo.pridisk and 1 or 0
        else
            info.wan = 1
            info.lan = 1
            info.admin = 1
            info.pridisk = 0
        end
        
        if limitedMacs[mac] == 1 then
            info.limited = 1
        else
            info.limited = 0
        end
        
        if configData then
            info.owner = configData.owner or ""
            info.device = configData.device or ""
        else
            info.owner = ""
            info.device = ""
        end
        
        if lanPermissions[mac] ~= nil then
            info.lan = lanPermissions[mac] and 1 or 0
        end
        
        result["device/" .. mac] = info
    end
    
    return result
end
