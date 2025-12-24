--[[
WiFi配置同步UCI模块 (XQExWifiConfSyncUci)
小米路由器WiFi配置同步的UCI操作模块

功能说明:
- 合并网络配置(network)
- 合并DHCP配置
- 合并防火墙配置(firewall)
- 合并无线配置(wireless)
- 获取热点信息
- 获取硬件信息

配置合并说明:
- 支持从主路由器同步配置到子路由器
- 处理接口、VLAN、防火墙规则等配置
- 支持2.4G/5G/5GH多频段WiFi配置

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.util.XQWifiUtil: WiFi工具
- xiaoqiang.XQLog: 日志模块
- luci.model.uci: UCI配置管理
- luci.util: LuCI工具函数
- nixio.fs: 文件系统操作
]]

module("xiaoqiang.module.XQExWifiConfSyncUci", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local LuciUtil = require("luci.util")
local XQLog = require("xiaoqiang.XQLog")
local uci = require("luci.model.uci").cursor()

local NETWORK_INTERFACE_TYPES = {
    "interface"
}

local NETWORK_DEVICE_TYPES = {
    "device",
    "bridge-vlan"
}

local DHCP_SECTION_TYPES = {
    "dhcp",
    "host"
}

local FIREWALL_SECTION_TYPES = {
    "zone",
    "forwarding",
    "rule",
    "redirect",
    "include",
    "ipset",
    "defaults"
}

local WIRELESS_SECTION_TYPES = {
    "wifi-device",
    "wifi-iface"
}

local function trim(str)
    if str then
        return str:gsub("^%s*(.-)%s*$", "%1")
    end
    return str
end

local function getInterfaceList(configData)
    local interfaces = {}
    
    for sectionName, sectionData in pairs(configData) do
        if sectionData[".type"] == "interface" then
            interfaces[sectionName] = true
        end
    end
    
    return interfaces
end

local function getDeviceList(configData)
    local devices = {}
    
    for sectionName, sectionData in pairs(configData) do
        if sectionData[".type"] == "device" or sectionData[".type"] == "bridge-vlan" then
            if sectionData.name then
                devices[sectionData.name] = sectionName
            end
        end
    end
    
    return devices
end

local function getWifiIfaceList(configData)
    local wifiIfaces = {}
    
    for sectionName, sectionData in pairs(configData) do
        if sectionData[".type"] == "wifi-iface" then
            wifiIfaces[sectionName] = true
        end
    end
    
    return wifiIfaces
end

local function filterNetworkConfig(srcConfig, dstConfig)
    local srcInterfaces = getInterfaceList(srcConfig)
    local dstInterfaces = getInterfaceList(dstConfig)
    local srcDevices = getDeviceList(srcConfig)
    local dstDevices = getDeviceList(dstConfig)
    
    local filteredConfig = {}
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "interface" then
            if not dstInterfaces[sectionName] then
                filteredConfig[sectionName] = sectionData
            end
        elseif sectionType == "device" or sectionType == "bridge-vlan" then
            local deviceName = sectionData.name
            if deviceName and not dstDevices[deviceName] then
                filteredConfig[sectionName] = sectionData
            end
        end
    end
    
    return filteredConfig
end

local function filterDhcpConfig(srcConfig, dstConfig, networkInterfaces)
    local filteredConfig = {}
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "dhcp" then
            local interface = sectionData.interface
            if interface and networkInterfaces[interface] then
                filteredConfig[sectionName] = sectionData
            end
        elseif sectionType == "host" then
            filteredConfig[sectionName] = sectionData
        end
    end
    
    return filteredConfig
end

local function filterFirewallConfig(srcConfig, dstConfig, networkInterfaces)
    local filteredConfig = {}
    local zoneNames = {}
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "zone" then
            local network = sectionData.network
            local shouldInclude = false
            
            if network then
                if type(network) == "table" then
                    for _, iface in ipairs(network) do
                        if networkInterfaces[iface] then
                            shouldInclude = true
                            break
                        end
                    end
                elseif networkInterfaces[network] then
                    shouldInclude = true
                end
            end
            
            if shouldInclude then
                filteredConfig[sectionName] = sectionData
                if sectionData.name then
                    zoneNames[sectionData.name] = true
                end
            end
        end
    end
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "forwarding" then
            local src = sectionData.src
            local dest = sectionData.dest
            if (src and zoneNames[src]) or (dest and zoneNames[dest]) then
                filteredConfig[sectionName] = sectionData
            end
        elseif sectionType == "rule" then
            local src = sectionData.src
            local dest = sectionData.dest
            if (src and zoneNames[src]) or (dest and zoneNames[dest]) then
                filteredConfig[sectionName] = sectionData
            end
        elseif sectionType == "redirect" then
            local src = sectionData.src
            local dest = sectionData.dest
            if (src and zoneNames[src]) or (dest and zoneNames[dest]) then
                filteredConfig[sectionName] = sectionData
            end
        end
    end
    
    return filteredConfig
end

local function filterWirelessConfig(srcConfig, dstConfig)
    local filteredConfig = {}
    local srcWifiIfaces = getWifiIfaceList(srcConfig)
    local dstWifiIfaces = getWifiIfaceList(dstConfig)
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "wifi-iface" then
            if not dstWifiIfaces[sectionName] then
                filteredConfig[sectionName] = sectionData
            end
        end
    end
    
    return filteredConfig
end

local function applyConfigSection(configName, sectionName, sectionData)
    local sectionType = sectionData[".type"]
    
    local cleanData = {}
    for key, value in pairs(sectionData) do
        if not key:match("^%.") then
            cleanData[key] = value
        end
    end
    
    uci:section(configName, sectionType, sectionName, cleanData)
end

function network_merge(srcConfig, dstConfig)
    if not srcConfig or not dstConfig then
        return false
    end
    
    local filteredConfig = filterNetworkConfig(srcConfig, dstConfig)
    local newInterfaces = {}
    
    for sectionName, sectionData in pairs(filteredConfig) do
        applyConfigSection("network", sectionName, sectionData)
        
        if sectionData[".type"] == "interface" then
            newInterfaces[sectionName] = true
        end
    end
    
    uci:commit("network")
    
    return newInterfaces
end

function dhcp_merge(srcConfig, dstConfig, networkInterfaces)
    if not srcConfig or not dstConfig then
        return false
    end
    
    local filteredConfig = filterDhcpConfig(srcConfig, dstConfig, networkInterfaces)
    
    for sectionName, sectionData in pairs(filteredConfig) do
        applyConfigSection("dhcp", sectionName, sectionData)
    end
    
    uci:commit("dhcp")
    
    return true
end

function firewall_merge(srcConfig, dstConfig, networkInterfaces)
    if not srcConfig or not dstConfig then
        return false
    end
    
    local filteredConfig = filterFirewallConfig(srcConfig, dstConfig, networkInterfaces)
    
    for sectionName, sectionData in pairs(filteredConfig) do
        applyConfigSection("firewall", sectionName, sectionData)
    end
    
    uci:commit("firewall")
    
    return true
end

function wireless_merge(srcConfig, dstConfig)
    if not srcConfig or not dstConfig then
        return false
    end
    
    local filteredConfig = filterWirelessConfig(srcConfig, dstConfig)
    
    for sectionName, sectionData in pairs(filteredConfig) do
        applyConfigSection("wireless", sectionName, sectionData)
    end
    
    uci:commit("wireless")
    
    return true
end

function config_merge(srcConfigs, dstConfigs)
    if not srcConfigs or not dstConfigs then
        return false
    end
    
    local networkInterfaces = {}
    
    if srcConfigs.network and dstConfigs.network then
        networkInterfaces = network_merge(srcConfigs.network, dstConfigs.network)
    end
    
    if srcConfigs.dhcp and dstConfigs.dhcp then
        dhcp_merge(srcConfigs.dhcp, dstConfigs.dhcp, networkInterfaces)
    end
    
    if srcConfigs.firewall and dstConfigs.firewall then
        firewall_merge(srcConfigs.firewall, dstConfigs.firewall, networkInterfaces)
    end
    
    if srcConfigs.wireless and dstConfigs.wireless then
        wireless_merge(srcConfigs.wireless, dstConfigs.wireless)
    end
    
    return true
end

function hotspot_info()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local result = {
        wifi = {}
    }
    
    local wifiInfo24g = XQWifiUtil.getWifiBasicInfo(1)
    local wifiInfo5g = XQWifiUtil.getWifiBasicInfo(2)
    
    result.wifi["24g"] = {
        ssid = wifiInfo24g.ssid,
        password = wifiInfo24g.password,
        encryption = wifiInfo24g.encryption,
        channel = wifiInfo24g.channel,
        bandwidth = wifiInfo24g.bandwidth,
        hidden = wifiInfo24g.hidden,
        on = wifiInfo24g.on
    }
    
    result.wifi["5g"] = {
        ssid = wifiInfo5g.ssid,
        password = wifiInfo5g.password,
        encryption = wifiInfo5g.encryption,
        channel = wifiInfo5g.channel,
        bandwidth = wifiInfo5g.bandwidth,
        hidden = wifiInfo5g.hidden,
        on = wifiInfo5g.on
    }
    
    local wlanCount = XQWifiUtil.get_wlan_count()
    if wlanCount == 3 then
        local wifiInfo5gh = XQWifiUtil.getWifiBasicInfo(3)
        result.wifi["5gh"] = {
            ssid = wifiInfo5gh.ssid,
            password = wifiInfo5gh.password,
            encryption = wifiInfo5gh.encryption,
            channel = wifiInfo5gh.channel,
            bandwidth = wifiInfo5gh.bandwidth,
            hidden = wifiInfo5gh.hidden,
            on = wifiInfo5gh.on
        }
    end
    
    return result
end

function hardware_info()
    local result = {}
    
    result.model = trim(LuciUtil.exec("nvram get model"))
    result.hardware = trim(LuciUtil.exec("getbdata hw_ver"))
    result.romversion = trim(LuciUtil.exec("uname -r"))
    result.channel = trim(LuciUtil.exec("getbdata CountryCode"))
    
    local sn = trim(LuciUtil.exec("getbdata SN"))
    if sn then
        result.sn = sn:sub(1, 12)
    end
    
    local mac = trim(LuciUtil.exec("getmac"))
    if mac then
        result.mac = mac:upper()
    end
    
    return result
end

function get_all_config(configName)
    local config = uci:get_all(configName)
    return config
end

function get_local_configs()
    local configs = {
        network = get_all_config("network"),
        dhcp = get_all_config("dhcp"),
        firewall = get_all_config("firewall"),
        wireless = get_all_config("wireless")
    }
    
    return configs
end
