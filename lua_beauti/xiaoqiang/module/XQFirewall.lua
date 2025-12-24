--[[
  防火墙模块 (Firewall Module)
  提供防火墙配置管理，包括 DoS 防护、WAN Ping、MAC/IP 过滤、端口转发、DMZ 等功能
  支持黑白名单管理和 ALG 应用层网关配置
]]
module("xiaoqiang.module.XQFirewall", package.seeall)

local xqFunction = require("xiaoqiang.common.XQFunction")
local xqConfigs = require("xiaoqiang.common.XQConfigs")
local dmzModule = require("xiaoqiang.module.XQDMZModule")
local portForward = require("xiaoqiang.module.XQPortForward")

function FirewallWANPing()
    local xqLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    local result = {}
    local ignorewanpingv4, ignorewanpingv6
    
    uci:foreach("firewall", "rule", function(section)
        if section.name == "Allow-IPv4-Ping" then
            if section.target == "DROP" then
                ignorewanpingv4 = 0
            else
                ignorewanpingv4 = 1
            end
        elseif section.name == "Allow-IPv6-Ping" then
            if section.target == "DROP" then
                ignorewanpingv6 = 0
            else
                ignorewanpingv6 = 1
            end
        else
            xqLog.log(1, "s.name=" .. section.name)
        end
    end)
    
    local ignorewanping = ignorewanpingv4 and ignorewanpingv4
    result.wanping_firewall = ignorewanping
end

function FirewallInfo()
    local uci = require("luci.model.uci").cursor()
    local info = {}
    
    info.firewall_enable = uci:get("firewall", "@defaults[0]", "fw_enable")
    info.spi_firewall = uci:get("firewall", "@defaults[0]", "spi_rule")
    info.dos_firewall = uci:get("firewall", "@defaults[0]", "dos_enable") or "0"
    info.wanping_firewall = uci:get("firewall", "@defaults[0]", "ignore_wan_ping")
    
    return info
end

function setDoSFirewall(enabled)
    local uci = require("luci.model.uci").cursor()
    setDoSFirewallFw(enabled)
    uci:set("firewall", "@defaults[0]", "dos_enable", enabled)
    uci:commit("firewall")
end

function setDoSFirewallFw(enabled)
    local xqLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    
    if enabled == 1 then
        uci:set("firewall", "@defaults[0]", "syn_flood", "1")
        uci:set("firewall", "@defaults[0]", "rst_flood", "1")
        uci:set("firewall", "@defaults[0]", "icmp_flood", "1")
        uci:set("firewall", "@defaults[0]", "udp_flood", "1")
    elseif enabled == 0 then
        uci:set("firewall", "@defaults[0]", "syn_flood", "0")
        uci:set("firewall", "@defaults[0]", "rst_flood", "0")
        uci:set("firewall", "@defaults[0]", "icmp_flood", "0")
        uci:set("firewall", "@defaults[0]", "udp_flood", "0")
    else
        xqLog.log(1, "dos=" .. enabled)
    end
    
    uci:commit("firewall")
end

function setWANPingFirewallFw(ignorewanping)
    local xqLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    
    uci:foreach("firewall", "rule", function(section)
        if section.name == "Allow-IPv4-Ping" or section.name == "Allow-IPv6-Ping" then
            if ignorewanping == 1 then
                uci:set("firewall", section[".name"], "target", "DROP")
            elseif ignorewanping == 0 then
                uci:set("firewall", section[".name"], "target", "ACCEPT")
            else
                xqLog.log(1, "ignorewanping=" .. ignorewanping)
            end
        end
    end)
    
    uci:commit("firewall")
end

function setWANPingFirewall(ignorewanping)
    local xqLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    
    if ignorewanping == 1 then
        uci:set("firewall", "@defaults[0]", "ignore_wan_ping", "1")
    elseif ignorewanping == 0 then
        uci:set("firewall", "@defaults[0]", "ignore_wan_ping", "0")
    else
        xqLog.log(1, "ignorewanping=" .. ignorewanping)
    end
    
    uci:commit("firewall")
    setWANPingFirewallFw(ignorewanping)
end

function setFirewallEnable(enabled)
    local uci = require("luci.model.uci").cursor()
    
    if enabled == 1 then
        local ignorewanping = tonumber(uci:get("firewall", "@defaults[0]", "ignore_wan_ping") or "0")
        local dosEnable = tonumber(uci:get("firewall", "@defaults[0]", "dos_enable") or "0")
        setWANPingFirewallFw(ignorewanping)
        setDoSFirewallFw(dosEnable)
    else
        setWANPingFirewallFw(enabled)
        setDoSFirewallFw(enabled)
    end
    
    uci:set("firewall", "@defaults[0]", "fw_enable", enabled)
    uci:commit("firewall")
end

function setSPIFirewall(enabled)
    local xqLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    
    if enabled == 1 then
        uci:set("firewall", "@defaults[0]", "spi_rule", "1")
    elseif enabled == 0 then
        uci:set("firewall", "@defaults[0]", "spi_rule", "0")
    else
        xqLog.log(1, "spi=" .. enabled)
    end
    
    uci:commit("firewall")
end

function numberToProto(protoNum)
    if protoNum then
        if type(protoNum) == "number" then
            if protoNum == 1 then
                return "tcp"
            elseif protoNum == 2 then
                return "udp"
            elseif protoNum == 3 then
                return "tcpudp"
            else
                return "tcp"
            end
        end
    end
    return nil
end

function reload()
    local cmd = " /etc/init.d/firewall reload; "
    xqFunction.forkExec(cmd)
end

function restart()
    local uci = require("luci.model.uci").cursor()
    local features = require("xiaoqiang.XQFeatures").FEATURES
    
    local upnpEnabled = uci:get("upnpd", "config", "enable_upnp") or "0"
    local cmd = " /etc/init.d/firewall restart; "
    
    if features.system.multiwan and features.system.multiwan == "1" then
        local mwan3Cmd = " /usr/sbin/mwan3 restart; "
        local mwan3Enabled = uci:get("mwan3", "globals", "enabled") or "0"
        if mwan3Enabled == "1" then
            cmd = cmd .. mwan3Cmd
        end
    end
    
    if upnpEnabled == "1" then
        cmd = cmd .. xqConfigs.UPNP_DISABLE .. xqConfigs.UPNP_ENABLE
    end
    
    xqFunction.forkExec(cmd)
end

function getDMZInfo()
    return dmzModule.getDMZInfo()
end

function setDMZ(enabled, ipaddr, lanIp)
    return dmzModule.setDMZ(enabled, ipaddr, lanIp)
end

function unsetDMZ(ipaddr)
    dmzModule.unsetDMZ(ipaddr)
end

function dmzReload(async)
    dmzModule.dmzReload(async)
end

function hookDMZLanIPChangeEvent(oldIp, newIp)
    dmzModule.hookLanIPChangeEvent(oldIp, newIp)
end

function VSInfo()
    return portForward.VSInfo()
end

function setVSRules(name, proto, extPort, intPort, intIp, enabled)
    return portForward.setVSRules(name, proto, extPort, intPort, intIp, enabled)
end

function setVSRangeRules(name, proto, extPortRange, intIp, enabled)
    return portForward.setVSRangeRules(name, proto, extPortRange, intIp, enabled)
end

function deleteVSRule(name, proto, extPort, intPort, intIp, enabled)
    return portForward.deleteVSRule(name, proto, extPort, intPort, intIp, enabled)
end

function PTInfo()
    return portForward.PTInfo()
end

function setPTRules(name, proto, extPort, intPortRange, enabled)
    return portForward.setPTRules(name, proto, extPort, intPortRange, enabled)
end

function trigger_add(name, proto, extPort, intPortRange, enabled)
    portForward.trigger_add(name, proto, extPort, intPortRange, enabled)
end

function deletePTRule(name, proto, extPort, intPortRange, enabled)
    return portForward.deletePTRule(name, proto, extPort, intPortRange, enabled)
end

function trigger_del(name, proto, extPort, intPortRange, enabled)
    portForward.trigger_del(name, proto, extPort, intPortRange, enabled)
end

function setALGFirewall(ftp, tftp, pptp, h323, sip, rtsp, irc, amanda)
    return portForward.setALGFirewall(ftp, tftp, pptp, h323, sip, rtsp, irc, amanda)
end

function ALGInfo()
    return portForward.ALGInfo()
end

function getMacfilterInfoList(filterType)
    local luciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    local result = {}
    local item = {}
    
    local mode = uci:get("macfilter", filterType, "mode")
    local enabled = uci:get("macfilter", filterType, "enable")
    
    if mode == nil or enabled == "0" then
        return result
    end
    
    uci:foreach("macfilter", mode, function(section)
        local mac = string.gsub(section[".name"], "_", ":")
        mac = string.sub(mac, 1, 17)
        
        if string.match(mode, "black") then
            item[mac] = false
        else
            item[mac] = true
        end
        
        item.mac = string.upper(mac)
        table.insert(result, item)
        item = {}
    end)
    
    return result
end

function getMacfilterInfoDict(filterList)
    local uci = require("luci.model.uci").cursor()
    local result = {}
    local list = {}
    
    if filterList then
        list = filterList
        for _, item in ipairs(list) do
            result[item.mac] = item
        end
    else
        uci:foreach("macfilter", "filter", function(section)
            if section[".type"] == "filter" then
                for _, item in ipairs(list) do
                    result[item.mac] = item
                end
            end
        end)
    end
    
    return result
end

function getBlackMacfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local result = {}
    
    uci:foreach("macfilter", "black", function(section)
        local mac = string.gsub(section[".name"], "_", ":")
        mac = string.sub(mac, 1, 17)
        
        local item = {}
        item.mac = mac
        item.rulename = section.name or ""
        item.web_del = (section.web_del == "0") and "0" or "1"
        
        table.insert(result, item)
    end)
    
    return result
end

function getWhiteMacfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local result = {}
    
    uci:foreach("macfilter", "white", function(section)
        local mac = string.gsub(section[".name"], "_", ":")
        mac = string.sub(mac, 1, 17)
        
        if section.ismesh ~= "1" then
            local item = {}
            item.mac = mac
            item.rulename = section.name or ""
            item.web_del = (section.web_del == "0") and "0" or "1"
            
            table.insert(result, item)
        end
    end)
    
    return result
end

function getMacfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local mode = {}
    local blacklist = {}
    local whitelist = {}
    
    mode.wanenable = uci:get("macfilter", "wan", "enable")
    mode.wan = uci:get("macfilter", "wan", "mode")
    
    whitelist = getWhiteMacfilterInfo()
    blacklist = getBlackMacfilterInfo()
    
    return {
        mode = mode,
        blacklist = blacklist,
        whitelist = whitelist
    }
end

function setmacfilterenablemode(enabled, filterMode, filterType)
    local uci = require("luci.model.uci").cursor()
    local xqLog = require("xiaoqiang.XQLog")
    local result = 0
    
    if filterMode == nil or enabled == nil or filterType == nil then
        return 1523
    end
    
    local mode = (filterMode == "0") and "white" or "black"
    
    local oldEnable = uci:get("macfilter", filterType, "enable")
    local oldMode = uci:get("macfilter", filterType, "mode")
    
    if oldEnable == enabled and oldMode == mode then
        return 0
    end
    
    uci:set("macfilter", filterType, "enable", enabled)
    uci:set("macfilter", filterType, "mode", mode)
    uci:commit("macfilter")
    
    xqLog.log(4, "uci commit macfilter enable=" .. enabled .. " filter=" .. filterType .. " mode=" .. mode)
    
    local cmd = "/usr/sbin/macfilter enable " .. enabled .. " " .. mode .. " " .. filterType
    xqLog.log(4, "set macfilter enable: " .. cmd)
    
    if cmd then
        result = os.execute(cmd)
    end
    
    return result
end

function checkMacfiltertable(sectionType, ruleName, mac)
    local uciLib = require("uci")
    local uci = uciLib.cursor()
    local luciUtil = require("luci.util")
    local xqLog = require("xiaoqiang.XQLog")
    local foundSection = nil
    local tr069Suffix = "0"
    
    xqLog.log(6, "@@@ section " .. sectionType .. " mac " .. mac)
    
    if ruleName then
        local prefix = string.sub(ruleName, 1, 6)
        if prefix == "tr069_" then
            local parts = luciUtil.split(ruleName, "_")
            tr069Suffix = parts[3] or "0"
        end
    end
    
    uci:foreach("macfilter", sectionType, function(section)
        if section[".type"] == sectionType then
            local sectionMac = string.gsub(section[".name"], "_", ":")
            local parts = luciUtil.split(section[".name"], "_")
            local sectionSuffix = parts[8] or ""
            
            if mac == sectionMac or tr069Suffix == sectionSuffix then
                foundSection = section[".name"]
                if ruleName and ruleName ~= "" then
                    section.name = ruleName
                    return
                end
            end
        end
    end)
    
    return foundSection
end

function setMacFilter(mac, ruleName, action, allow)
    local uci = require("luci.model.uci").cursor()
    local xqLog = require("xiaoqiang.XQLog")
    local datatypes = require("luci.cbi.datatypes")
    
    local operation = (action == "0") and "add" or "del"
    
    local mode = uci:get("macfilter", "wan", "mode")
    local modeNum = tonumber(uci:get("macfilter", "wan", mode .. "num"))
    
    if allow ~= "" and allow == "1" then
        if mode == "white" then
            operation = "add"
        else
            operation = "del"
        end
    end
    
    if allow ~= "" and allow == "0" then
        if mode == "black" then
            operation = "add"
        else
            operation = "del"
        end
    end
    
    if xqFunction.isStrNil(mac) or not datatypes.macaddr(mac) then
        return false
    end
    
    local existingSection = checkMacfiltertable(mode, ruleName, mac)
    
    if existingSection == nil and operation == "del" then
        xqLog.log(6, "del mac fail, " .. mac .. " not found")
        return false
    end
    
    if existingSection ~= nil and operation == "add" then
        xqLog.log(6, "update macfilter " .. mac .. " name " .. ruleName)
        return true
    end
    
    if existingSection == nil and operation == "add" then
        local sectionName = string.gsub(mac, "%:", "_")
        local oppositeMode = (mode == "black") and "white" or "black"
        local oppositeNum = tonumber(uci:get("macfilter", "wan", oppositeMode .. "num") or "0")
        
        local existingOpposite = uci:get_all("macfilter", sectionName)
        if existingOpposite and existingOpposite[".type"] == oppositeMode and oppositeNum > 0 then
            uci:set("macfilter", "wan", oppositeMode .. "num", oppositeNum - 1)
        end
        
        xqLog.log(6, "add macfilter rule mac " .. mac)
        uci:set("macfilter", sectionName, mode)
        
        if ruleName and ruleName ~= nil then
            uci:set("macfilter", sectionName, "name", ruleName)
        end
        
        modeNum = modeNum + 1
        uci:set("macfilter", "wan", mode .. "num", modeNum)
        uci:commit("macfilter")
    end
    
    if existingSection ~= nil and operation == "del" then
        local deleted = uci:delete("macfilter", existingSection)
        if deleted then
            modeNum = modeNum - 1
            uci:set("macfilter", "wan", mode .. "num", modeNum)
            uci:commit("macfilter")
            xqLog.log(6, "del macfilter " .. existingSection)
        end
    end
    
    local cmd = "/usr/sbin/macfilter " .. operation .. " " .. mode .. " " .. mac
    if ruleName then
        cmd = cmd .. " rulename=" .. ruleName
    end
    
    local result = os.execute(cmd)
    return result == 0
end

function getBlackIpfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local result = {}
    
    uci:foreach("ipfilter", "black_v4", function(section)
        local addr = string.gsub(section[".name"], "_", ".")
        local item = {}
        item.addr = addr
        item.rulename = section.name or ""
        table.insert(result, item)
    end)
    
    uci:foreach("ipfilter", "black_v6", function(section)
        local addr = string.gsub(section[".name"], "_", ":")
        local item = {}
        item.addr = addr
        item.rulename = section.name or ""
        table.insert(result, item)
    end)
    
    return result
end

function getWhiteIpfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local result = {}
    
    uci:foreach("ipfilter", "white_v4", function(section)
        local addr = string.gsub(section[".name"], "_", ".")
        local item = {}
        item.addr = addr
        item.rulename = section.name or ""
        table.insert(result, item)
    end)
    
    uci:foreach("ipfilter", "white_v6", function(section)
        local addr = string.gsub(section[".name"], "_", ":")
        local item = {}
        item.addr = addr
        item.rulename = section.name or ""
        table.insert(result, item)
    end)
    
    return result
end

function getIpfilterInfo()
    local uci = require("luci.model.uci").cursor()
    local mode = {}
    
    mode.wanenable = uci:get("ipfilter", "wan", "enable")
    mode.wan = uci:get("ipfilter", "wan", "mode")
    
    local blacklist = getBlackIpfilterInfo()
    local whitelist = getWhiteIpfilterInfo()
    
    return {
        mode = mode,
        blacklist = blacklist,
        whitelist = whitelist
    }
end

function setIpFilter(addr, ruleName, action, allow)
    local uci = require("luci.model.uci").cursor()
    local xqLog = require("xiaoqiang.XQLog")
    local datatypes = require("luci.cbi.datatypes")
    
    local operation = (action == "0") and "add" or "del"
    local mode = uci:get("ipfilter", "wan", "mode")
    local ipType = "v4"
    
    if datatypes.ip6addr(addr) then
        ipType = "v6"
    elseif not datatypes.ip4addr(addr) then
        return false
    end
    
    if allow ~= "" and allow == "1" then
        if mode == "white" then
            operation = "add"
        else
            operation = "del"
        end
    end
    
    if allow ~= "" and allow == "0" then
        if mode == "black" then
            operation = "add"
        else
            operation = "del"
        end
    end
    
    local separator = (ipType == "v4") and "." or ":"
    local sectionName = string.gsub(addr, "%" .. separator, "_")
    local sectionType = mode .. "_" .. ipType
    
    local existing = uci:get_all("ipfilter", sectionName)
    
    if existing == nil and operation == "del" then
        xqLog.log(6, "del ip fail, " .. addr .. " not found")
        return false
    end
    
    if existing ~= nil and operation == "add" then
        xqLog.log(6, "update ipfilter " .. addr .. " name " .. ruleName)
        return true
    end
    
    if existing == nil and operation == "add" then
        xqLog.log(6, "add ipfilter rule addr " .. addr)
        uci:set("ipfilter", sectionName, sectionType)
        
        if ruleName and ruleName ~= nil then
            uci:set("ipfilter", sectionName, "name", ruleName)
        end
        
        uci:commit("ipfilter")
    end
    
    if existing ~= nil and operation == "del" then
        uci:delete("ipfilter", sectionName)
        uci:commit("ipfilter")
        xqLog.log(6, "del ipfilter " .. sectionName)
    end
    
    local cmd = "/usr/sbin/ipfilter " .. operation .. " " .. mode .. " " .. addr
    if ruleName then
        cmd = cmd .. " rulename=" .. ruleName
    end
    
    local result = os.execute(cmd)
    return result == 0
end
