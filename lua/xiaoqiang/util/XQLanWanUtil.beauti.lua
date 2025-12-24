---
--- XQLanWanUtil - 小米路由器 LAN/WAN 网络配置工具模块
--- 提供完整的网络接口配置、DHCP管理、IPv6配置、VPN设置等功能
--- 这是路由器网络配置的核心模块，功能非常全面
---

module("xiaoqiang.util.XQLanWanUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--------------------------------------------------------------------------------
-- MAC地址获取函数
--------------------------------------------------------------------------------

--- 获取默认MAC地址
--- 根据网络模式和功能特性返回适当的MAC地址
--- @return string MAC地址（大写格式）或 "null"
function getDefaultMacAddress()
    local LuciUtil = require("luci.util")
    local netMode = nil
    local macAddress = nil
    
    local bridgeWanMac = XQFunction.getFeature("0", "system", "BridgeWanMac")
    if "1" == bridgeWanMac then
        macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_WAN_MACADDRESS)
    else
        netMode = XQFunction.getNetMode()
        if netMode == "wifiapmode" or netMode == "lanapmode" or netMode == "whc_re" then
            macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_LAN_MACADDRESS)
        else
            macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_WAN_MACADDRESS)
        end
    end
    
    if XQFunction.isStrNil(macAddress) then
        return "null"
    else
        macAddress = LuciUtil.trim(macAddress)
        return string.upper(macAddress)
    end
end

--- 获取默认WAN口MAC地址
--- @return string MAC地址（大写格式）或 "null"
function getDefaultWanMacAddress()
    local LuciUtil = require("luci.util")
    local macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_WAN_MACADDRESS)
    
    if XQFunction.isStrNil(macAddress) then
        return "null"
    else
        macAddress = LuciUtil.trim(macAddress)
        return string.upper(macAddress)
    end
end

--- 获取默认WAN2口MAC地址（双WAN设备）
--- @return string MAC地址（大写格式）或 "null"
function getDefaultWan2MacAddress()
    local LuciUtil = require("luci.util")
    local macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_WAN2_MACADDRESS)
    
    if XQFunction.isStrNil(macAddress) then
        return "null"
    else
        macAddress = LuciUtil.trim(macAddress)
        return string.upper(macAddress)
    end
end

--- 获取LAN口MAC地址
--- 优先从UCI配置获取，否则从系统命令获取
--- @return string MAC地址（大写格式）或 "null"
function getLanMac()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local macAddress = cursor:get("network", "lan", "macaddr")
    if not XQFunction.isStrNil(macAddress) then
        return string.upper(macAddress)
    end
    
    local LuciUtil = require("luci.util")
    macAddress = LuciUtil.exec(XQConfigs.GET_DEFAULT_LAN_MACADDRESS)
    
    if XQFunction.isStrNil(macAddress) then
        return "null"
    else
        macAddress = LuciUtil.trim(macAddress)
        return string.upper(macAddress)
    end
end

--------------------------------------------------------------------------------
-- LAN端口链路状态
--------------------------------------------------------------------------------

--- 获取LAN口链路状态列表
--- @return table 端口号到链路状态的映射 {端口号: 1/0}
function getLanLinkList()
    local LuciUtil = require("luci.util")
    local linkList = {}
    
    for line in LuciUtil.execi("/sbin/phyhelper link service lan") do
        local portNum, linkStatus = line:match("port:(%d) link:(%S+)")
        if portNum and linkStatus then
            local portIndex = tonumber(portNum)
            linkList[portIndex] = (linkStatus == "up") and 1 or 0
        end
    end
    
    return linkList
end

--------------------------------------------------------------------------------
-- LAN IP配置
--------------------------------------------------------------------------------

--- 获取LAN口IP地址
--- @return string LAN IP地址
function getLanIp()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    return cursor:get("network", "lan", "ipaddr")
end

--- 获取LAN口子网掩码
--- @return string 子网掩码
function getLanMask()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    return cursor:get("network", "lan", "netmask")
end

--- 获取LAN IP前缀（网段部分）
--- @return string IP前缀或nil
function getLanIpPre()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local lanIp = cursor:get("network", "lan", "ipaddr")
    if XQFunction.isStrNil(lanIp) then
        return nil
    end
    
    local netmask = cursor:get("network", "lan", "netmask")
    local pattern = ".%d+$"
    if netmask ~= "255.255.255.0" then
        pattern = ".%d+.%d+$"
    end
    
    return lanIp:gsub(pattern, "")
end

--- 获取LAN网关地址
--- @return string 网关地址（通常为空字符串）
function getLanGwaddr()
    local ubus = require("ubus")
    local conn = ubus.connect()
    local lanStatus = conn:call("network.interface.lan", "status", {})
    
    if lanStatus and lanStatus.route and #lanStatus.route > 0 then
        -- 从路由表获取网关
    end
    
    conn:close()
    return ""
end

--- 检查IP地址是否为有效的公网IP
--- @param ipAddr string IP地址
--- @return boolean 是否为有效公网IP
function _checkIP(ipAddr)
    if XQFunction.isStrNil(ipAddr) then
        return false
    end
    
    local LuciIP = require("luci.ip")
    local ipNum = LuciIP.iptonl(ipAddr)
    
    -- 检查A类地址范围 1.0.0.0 - 126.0.0.0
    if ipNum >= LuciIP.iptonl("1.0.0.0") and ipNum <= LuciIP.iptonl("126.0.0.0") then
        return true
    end
    
    -- 检查B/C类地址范围 128.0.0.0 - 223.255.255.255
    if ipNum >= LuciIP.iptonl("128.0.0.0") and ipNum <= LuciIP.iptonl("223.255.255.255") then
        return true
    end
    
    return false
end

--- 检查LAN IP和掩码的有效性
--- @param ipAddr string IP地址
--- @param netmask string 子网掩码
--- @return number 0=成功, 1527=错误
function checkLanIpMask(ipAddr, netmask)
    local LuciIP = require("luci.ip")
    local ipNum = LuciIP.iptonl(ipAddr)
    
    -- 检查是否在私有地址范围内
    -- 10.0.0.0 - 10.255.255.255
    if ipNum >= LuciIP.iptonl("10.0.0.0") and ipNum <= LuciIP.iptonl("10.255.255.255") then
        return 0
    end
    
    -- 172.16.0.0 - 172.31.255.255
    if ipNum >= LuciIP.iptonl("172.16.0.0") and ipNum <= LuciIP.iptonl("172.31.255.255") then
        return 0
    end
    
    -- 192.168.0.0 - 192.168.255.255
    if ipNum >= LuciIP.iptonl("192.168.0.0") and ipNum <= LuciIP.iptonl("192.168.255.255") then
        -- 192.168网段需要255.255.255.0掩码
        if ipNum >= LuciIP.iptonl("192.168.0.0") and netmask ~= "255.255.255.0" then
            return 1527
        end
        return 0
    end
    
    return 1527
end

--- 设置LAN IP地址
--- @param ipAddr string 新IP地址
--- @param netmask string 新子网掩码
--- @return boolean 是否成功
function setLanIp(ipAddr, netmask)
    local XQEvent = require("xiaoqiang.XQEvent")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local oldMask = getLanMask()
    
    cursor:set("network", "lan", "ipaddr", ipAddr)
    cursor:set("network", "lan", "netmask", netmask)
    cursor:commit("network")
    
    XQEvent.lanIPChange(ipAddr, oldMask, netmask)
    
    return true
end

--- LAN IP变更事件钩子
--- 更新MAC绑定和DHCP配置
--- @param ipAddr string 新IP地址
--- @param oldMask string 旧子网掩码
--- @param newMask string 新子网掩码
function hookLanIPChangeEvent(ipAddr, oldMask, newMask)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local pattern = ".%d+$"
    if newMask == "255.255.0.0" then
        pattern = ".%d+.%d+$"
    end
    
    local ipPrefix = ipAddr:gsub(pattern, "")
    
    -- 更新MAC绑定的IP地址
    cursor:foreach("macbind", "host", function(section)
        local oldIp = section.ip
        local suffix = oldIp:match(pattern)
        local newIp = ipPrefix .. suffix
        cursor:set("macbind", section[".name"], "ip", newIp)
    end)
    cursor:commit("macbind")
    
    setDhcpCfg(ipAddr, oldMask, newMask)
end

--------------------------------------------------------------------------------
-- DHCP配置
--------------------------------------------------------------------------------

--- 检查DHCP IP池参数
--- @param poolType number 1=数字范围, 其他=IP地址范围
--- @param startVal string 起始值
--- @param endVal string 结束值
--- @return number 0=成功, 错误码
function checkDhcpIpPool(poolType, startVal, endVal)
    local DataTypes = require("luci.cbi.datatypes")
    
    if poolType == 1 then
        local startNum = tonumber(startVal)
        local endNum = tonumber(endVal)
        
        if not DataTypes.uinteger(startNum) or not DataTypes.integer(endNum) then
            return 1537
        end
        
        if startNum > endNum then
            return 1534
        elseif startNum <= 1 or endNum > 254 then
            return 1535
        end
        
        return 0
    end
    
    -- IP地址范围检查
    if not DataTypes.ipaddr(startVal) or not DataTypes.ipaddr(endVal) then
        return 1525
    end
    
    local LuciIP = require("luci.ip")
    if LuciIP.iptonl(startVal) > LuciIP.iptonl(endVal) then
        return 1534
    end
    
    return 0
end

--- 解析DHCP租约文件
--- @return table IP地址到设备信息的映射
function _parseDhcpLeases()
    local NixioFS = require("nixio.fs")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local leases = {}
    local leaseFile = XQConfigs.DHCP_LEASE_FILEPATH
    
    -- 查找租约文件路径
    cursor:foreach("dhcp", "dnsmasq", function(section)
        if section.leasefile and NixioFS.access(section.leasefile) then
            leaseFile = section.leasefile
            return false
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
                    local entry = {}
                    entry.mac = string.lower(XQFunction.macFormat(mac))
                    entry.ip = ip
                    entry.name = name
                    leases[ip] = entry
                end
            end
        end
        file:close()
    end
    
    return leases
end

--- 设置DHCP配置
--- 根据子网掩码变化更新DHCP设置
--- @param ipAddr string LAN IP地址
--- @param oldMask string 旧子网掩码
--- @param newMask string 新子网掩码
function setDhcpCfg(ipAddr, oldMask, newMask)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local pattern = ".%d+$"
    if newMask ~= "255.255.255.0" then
        pattern = ".%d+.%d+$"
    end
    
    local ipPrefix = ipAddr:gsub(pattern, "")
    
    -- 更新DHCP静态绑定的IP
    cursor:foreach("dhcp", "host", function(section)
        local oldIp = section.ip
        local suffix = oldIp:match(pattern)
        local newIp = ipPrefix .. suffix
        cursor:set("dhcp", section[".name"], "ip", newIp)
    end)
    
    -- 如果掩码相同，只更新startip/endip
    if oldMask == newMask then
        if newMask ~= "255.255.255.0" then
            local startIp = cursor:get("dhcp", "lan", "startip")
            local endIp = cursor:get("dhcp", "lan", "endip")
            
            if startIp == nil or endIp == nil then
                startIp = ipPrefix .. ".0.5"
                endIp = ipPrefix .. ".3.237"
            else
                startIp = ipPrefix .. startIp:match(pattern)
                endIp = ipPrefix .. endIp:match(pattern)
            end
            
            cursor:set("dhcp", "lan", "startip", startIp)
            cursor:set("dhcp", "lan", "endip", endIp)
        end
        cursor:commit("dhcp")
        return
    end
    
    -- 根据新掩码设置DHCP范围
    if newMask == "255.255.255.0" then
        cursor:set("dhcp", "lan", "start", "5")
        cursor:set("dhcp", "lan", "limit", "250")
        cursor:delete("dhcp", "lan", "startip")
        cursor:delete("dhcp", "lan", "endip")
        cursor:delete("dhcp", "lan", "router")
    elseif newMask == "255.255.0.0" then
        cursor:set("dhcp", "lan", "startip", ipPrefix .. ".0.5")
        cursor:set("dhcp", "lan", "endip", ipPrefix .. ".3.237")
        cursor:delete("dhcp", "lan", "router")
    end
    
    cursor:commit("dhcp")
end

--- 获取LAN DHCP服务配置
--- @return table DHCP配置信息
function getLanDHCPService()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local config = {}
    
    local ignore = cursor:get("dhcp", "lan", "miwifi_force_ignore")
    local leasetime = cursor:get("dhcp", "lan", "leasetime")
    
    if ignore ~= "1" then
        ignore = "0"
    end
    
    local leaseNum, leaseUnit = leasetime:match("^(%d+)([^%d]+)")
    
    config.lanIp = getLanWanIp("lan")
    config.start = cursor:get("dhcp", "lan", "start")
    config.startip = cursor:get("dhcp", "lan", "startip")
    config.endip = cursor:get("dhcp", "lan", "endip")
    config.limit = cursor:get("dhcp", "lan", "limit")
    config.leasetime = leasetime
    config.leasetimeNum = leaseNum
    config.leasetimeUnit = leaseUnit
    config.ignore = ignore
    config.router = cursor:get("dhcp", "lan", "router")
    config.dns1 = cursor:get("dhcp", "lan", "dns1")
    config.dns2 = cursor:get("dhcp", "lan", "dns2")
    
    return config
end

--- 设置LAN DHCP服务
--- @param startVal string 起始地址
--- @param endVal string 结束地址
--- @param startIp string 起始IP（可选）
--- @param endIp string 结束IP（可选）
--- @param leasetime string 租约时间
--- @param ignore string 是否禁用 "1"=禁用
--- @param router string 网关地址（可选）
--- @param dns1 string DNS1（可选）
--- @param dns2 string DNS2（可选）
function setLanDHCPService(startVal, endVal, startIp, endIp, leasetime, ignore, router, dns1, dns2)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local LuciUtil = require("luci.util")
    
    if ignore == "1" then
        cursor:set("dhcp", "lan", "miwifi_force_ignore", tonumber(ignore))
        cursor:set("dhcp", "lan", "ignore", tonumber(ignore))
    else
        if startIp and endIp then
            cursor:set("dhcp", "lan", "startip", startIp)
            cursor:set("dhcp", "lan", "endip", endIp)
        else
            cursor:set("dhcp", "lan", "start", tonumber(startVal))
            local limit = tonumber(endVal) - tonumber(startVal) + 1
            cursor:set("dhcp", "lan", "limit", limit)
        end
        
        cursor:set("dhcp", "lan", "leasetime", leasetime)
        
        if router then
            cursor:set("dhcp", "lan", "router", router)
        end
        if dns1 then
            cursor:set("dhcp", "lan", "dns1", dns1)
        end
        if dns2 then
            cursor:set("dhcp", "lan", "dns2", dns2)
        end
        
        cursor:delete("dhcp", "lan", "miwifi_force_ignore")
        cursor:delete("dhcp", "lan", "ignore")
    end
    
    cursor:save("dhcp")
    cursor:commit("dhcp")
    
    LuciUtil.exec("/etc/init.d/dnsmasq restart > /dev/null")
end

--------------------------------------------------------------------------------
-- MAC绑定管理
--------------------------------------------------------------------------------

--- 获取MAC绑定信息
--- @return table MAC地址到绑定信息的映射
function macBindInfo()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local bindings = {}
    
    -- 从macbind配置获取
    cursor:foreach("macbind", "host", function(section)
        local entry = {}
        entry.name = section.name
        entry.mac = section.mac
        entry.ip = section.ip
        entry.tag = 1  -- macbind来源
        bindings[section.mac] = entry
    end)
    
    -- 从dhcp配置获取
    cursor:foreach("dhcp", "host", function(section)
        local entry = {}
        entry.name = section.name
        entry.mac = section.mac
        entry.ip = section.ip
        entry.tag = 2  -- dhcp来源
        bindings[section.mac] = entry
    end)
    
    return bindings
end

--- 添加MAC-IP绑定
--- @param macAddr string MAC地址
--- @param ipAddr string IP地址
--- @return number 0=成功, 1=IP已被其他MAC使用, 2=参数无效
function addBind(macAddr, ipAddr)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    if not _checkIP(ipAddr) then
        return 2
    end
    
    if not _checkMac(macAddr) then
        return 2
    end
    
    local leases = _parseDhcpLeases()
    macAddr = string.lower(XQFunction.macFormat(macAddr))
    
    -- 检查IP是否已被其他MAC使用
    local existing = leases[ipAddr]
    if existing and existing.mac ~= macAddr then
        return 1
    end
    
    local sectionName = _parseMac(macAddr)
    local bindInfo = {
        name = sectionName,
        mac = macAddr,
        ip = ipAddr
    }
    
    cursor:section("macbind", "host", sectionName, bindInfo)
    cursor:commit("macbind")
    
    return 0
end

--- 删除MAC绑定
--- @param macAddr string MAC地址
--- @return boolean 是否成功
function removeBind(macAddr)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    if not _checkMac(macAddr) then
        return false
    end
    
    local sectionName = _parseMac(macAddr)
    cursor:delete("macbind", sectionName)
    cursor:delete("dhcp", sectionName)
    cursor:commit("macbind")
    cursor:commit("dhcp")
    
    return true
end

--- 解除所有MAC绑定
function unbindAll()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    cursor:delete_all("dhcp", "host")
    cursor:delete_all("macbind", "host")
    cursor:commit("dhcp")
    cursor:commit("macbind")
end

--- 保存绑定信息（从macbind同步到dhcp）
function saveBindInfo()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    cursor:delete_all("dhcp", "host")
    
    cursor:foreach("macbind", "host", function(section)
        local entry = {
            name = section.name,
            mac = section.mac,
            ip = section.ip
        }
        cursor:section("dhcp", "host", section.name, entry)
    end)
    
    cursor:commit("dhcp")
end

--------------------------------------------------------------------------------
-- WAN状态监控
--------------------------------------------------------------------------------

--- 获取WAN监控状态
--- @return table 状态键值对
function getWanMonitorStat()
    local NixioFS = require("nixio.fs")
    local content = NixioFS.readfile(XQConfigs.WAN_MONITOR_STAT_FILEPATH)
    local stats = {}
    
    if content ~= nil then
        for line in content:gmatch("[^\r\n]+") do
            local key, value = line:match("(%S+)=(%S+)")
            if key and value then
                stats[key] = value
            end
        end
    end
    
    return stats
end

--- 自动检测WAN类型
--- @return string WAN类型 "pppoe"/"dhcp"/"static"
function getAutoWanType()
    local LuciUtil = require("luci.util")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local initted = cursor:get("xiaoqiang", "common", "INITTED") or ""
    
    local linkStatus, pppoeStatus, dhcpStatus, staticStatus = nil, nil, nil, nil
    
    for line in LuciUtil.execi("/usr/sbin/wanlinkprobe 7 WAN pppoe dhcp") do
        local link = line:match("^LINK=(%S+)")
        if link then linkStatus = link end
        
        local pppoe = line:match("^PPPOE=(%S+)")
        if pppoe then pppoeStatus = pppoe end
        
        local dhcp = line:match("^DHCP=(%S+)")
        if dhcp then dhcpStatus = dhcp end
        
        local static = line:match("^STATIC=(%S+)")
        if static then staticStatus = static end
    end
    
    if pppoeStatus == "YES" then
        return "pppoe"
    elseif dhcpStatus == "YES" then
        return "dhcp"
    elseif staticStatus == "YES" then
        return "static"
    elseif linkStatus ~= "YES" then
        return "nolink"
    else
        return "unknown"
    end
end

--- 获取WAN链路状态
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @param retryCount number 重试次数（可选，默认1）
--- @return boolean 链路是否连接
function getWanLink(wanIface, retryCount)
    local Nixio = require("nixio")
    retryCount = retryCount or 1
    
    for i = 1, retryCount * 10 do
        local output = XQFunction.waitExec("/sbin/phyhelper", "link")
        
        if not XQFunction.isStrNil(output) then
            local port, status = output:match("port:(%d) link:(%S+)")
            if status and status == "up" then
                return true
            end
        end
        
        Nixio.nanosleep(0, 100000000)  -- 100ms
    end
    
    return false
end

--------------------------------------------------------------------------------
-- WAN状态获取
--------------------------------------------------------------------------------

--- 通过ubus获取WAN状态
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @return table WAN状态信息或nil
function ubusWanStatus(wanIface)
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    wanIface = wanIface or "wan"
    local status = conn:call("network.interface." .. wanIface, "status", {})
    local result = {}
    
    if not status then
        conn:close()
        return nil
    end
    
    -- 解析IPv4地址
    if status["ipv4-address"] and #status["ipv4-address"] > 0 then
        local LuciUtil = require("luci.util")
        local ipv4List = {}
        
        for _, addr in ipairs(status["ipv4-address"]) do
            local entry = {}
            entry.ip = addr.address
            local maskOutput = LuciUtil.exec("ipcalc.sh 255.255.255.255/" .. addr.mask .. " | grep \"NETWORK\" | cut -d '=' -f 2")
            entry.mask = string.trim(maskOutput)
            table.insert(ipv4List, entry)
        end
        result.ipv4 = ipv4List
    else
        result.ipv4 = {{ip = "", mask = ""}}
    end
    
    -- 网关
    if status.route and #status.route > 0 then
        result.gw = status.route[1].nexthop
    else
        result.gw = ""
    end
    
    -- DNS
    result.dns = status["dns-server"] or {}
    result.proto = string.lower(status.proto or "")
    result.up = status.up
    result.uptime = status.uptime or 0
    result.pending = status.pending
    result.autostart = status.autostart
    
    conn:close()
    return result
end

--------------------------------------------------------------------------------
-- PPPoE状态和控制
--------------------------------------------------------------------------------

--- 检查PPPoE状态
--- @param wanIface string WAN接口名
--- @return table|false 状态信息或false
function _pppoeStatusCheck(wanIface)
    local JSON = require("json")
    local LuciUtil = require("luci.util")
    
    local cmd = "lua /usr/sbin/pppoe.lua status " .. wanIface
    local output = LuciUtil.exec(cmd)
    
    if output then
        output = LuciUtil.trim(output)
        if XQFunction.isStrNil(output) then
            return false
        end
        return JSON.decode(output)
    else
        return false
    end
end

--- PPPoE错误码分类
--- @param errorCode number 错误码
--- @return number 错误类型 1=认证错误, 2=协议错误, 3=其他错误
function _pppoeErrorCodeHelper(errorCode)
    -- 认证相关错误
    local authErrors = {
        ["507"] = 1, ["691"] = 1, ["509"] = 1, ["514"] = 1,
        ["520"] = 1, ["646"] = 1, ["647"] = 1, ["648"] = 1,
        ["649"] = 1, ["678"] = 1
    }
    
    -- 协议相关错误
    local protoErrors = {
        ["516"] = 1, ["650"] = 1, ["601"] = 1, ["510"] = 1,
        ["530"] = 1, ["531"] = 1
    }
    
    -- 其他错误
    local otherErrors = {
        ["501"] = 1, ["502"] = 1, ["503"] = 1, ["504"] = 1,
        ["505"] = 1, ["506"] = 1, ["507"] = 1, ["508"] = 1,
        ["511"] = 1, ["512"] = 1, ["515"] = 1, ["517"] = 1,
        ["518"] = 1, ["519"] = 1
    }
    
    local codeStr = tostring(errorCode)
    if authErrors[codeStr] then
        return 1
    elseif protoErrors[codeStr] then
        return 2
    elseif otherErrors[codeStr] then
        return 3
    end
    
    return 1
end

--- PPPoE错误处理
--- @param errorCode number 错误码
--- @return number|nil 详细错误码
function _pppoeError(errorCode)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local username = cursor:get("network", "wan", "username")
    local password = cursor:get("network", "wan", "password")
    local lastSucceed = tonumber(cursor:get("network", "wan", "last_succeed")) or 0
    
    if username and password then
        if errorCode == 691 then
            return (lastSucceed == 0) and 33 or 34
        elseif errorCode == 678 then
            return (lastSucceed == 0) and 35 or 36
        end
    end
    
    return nil
end

--- 获取物理层WAN速度
--- @param wanIface string WAN接口名
--- @return string 速度信息
function getPhyhelperWanSpeed(wanIface)
    local LuciUtil = require("luci.util")
    local port = LuciUtil.exec("port_map port service " .. wanIface)
    local speed = ""
    
    if not XQFunction.isStrNil(port) then
        speed = LuciUtil.exec("phyhelper speed port " .. port)
    end
    
    return speed
end

--- 获取PPPoE连接状态（综合信息）
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @return table 连接状态信息
function getPPPoEStatus(wanIface)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local LuciUtil = require("luci.util")
    local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")
    
    local result = {}
    
    if XQFunction.isStrNil(wanIface) then
        wanIface = "wan"
    end
    
    local proto = cursor:get("network", wanIface, "proto")
    local linkUp = getWanLink(wanIface, 3)
    local ubusStatus = ubusWanStatus(wanIface)
    
    result.proto = proto
    result.status = 0  -- 0=断开, 1=连接中, 2=已连接, 3=错误, 4=已停止
    
    if proto == "pppoe" then
        if not linkUp then
            result.status = 3
            result.errcode = 678
            result.errtype = 2
            result.perror = 35
        elseif ubusStatus then
            if ubusStatus.up then
                result.status = 2
            else
                local pppoeStatus = _pppoeStatusCheck(wanIface)
                if pppoeStatus then
                    if pppoeStatus.process == "down" then
                        result.status = 4
                        if pppoeStatus.code and pppoeStatus.code ~= 0 then
                            result.errcode = pppoeStatus.msg or ""
                            result.errtype = _pppoeErrorCodeHelper(tostring(pppoeStatus.code))
                            result.perror = _pppoeError(pppoeStatus.msg)
                        else
                            result.errtype = 0
                            result.errcode = ""
                        end
                    elseif pppoeStatus.process == "up" then
                        result.status = 2
                    elseif pppoeStatus.process == "connecting" then
                        if pppoeStatus.code and pppoeStatus.code ~= 0 then
                            result.status = 3
                            result.errcode = pppoeStatus.msg or ""
                            result.errtype = _pppoeErrorCodeHelper(tostring(pppoeStatus.code))
                            result.perror = _pppoeError(pppoeStatus.msg)
                        else
                            result.status = 1
                        end
                    end
                end
            end
            
            -- 获取自定义DNS
            local dns = cursor:get("network", wanIface, "dns")
            if not XQFunction.isStrNil(dns) then
                if type(dns) == "table" then
                    result.cdns = dns
                elseif type(dns) == "string" then
                    result.cdns = LuciUtil.split(dns, " ")
                end
            end
            
            result.pppoename = cursor:get("network", wanIface, "username")
            result.password = cursor:get("network", wanIface, "password")
            result.peerdns = cursor:get("network", wanIface, "peerdns")
        end
    elseif ubusStatus and ubusStatus.up then
        result.status = 2
    end
    
    -- IP信息
    result.ip = {}
    if ubusStatus and ubusStatus.up then
        result.ip.address = ubusStatus.ipv4[1].ip
        result.ip.mask = ubusStatus.ipv4[1].mask
        result.dns = ubusStatus.dns
        result.gw = ubusStatus.gw
        result.wanSpeed = getPhyhelperWanSpeed(wanIface)
    else
        result.ip.address = ""
        result.ip.mask = ""
        result.dns = {}
        result.gw = ""
        result.wanSpeed = ""
    end
    
    -- 国际版VPN支持
    local international = XQFunction.getFeature("0", "system", "international")
    if "1" == international then
        if chkWan4VPNEnable() then
            local XQVPNUtil = require("xiaoqiang.util.XQVPNUtil")
            local vpnStatus = XQVPNUtil.vpnStatus()
            -- ... VPN状态处理
        end
    end
    
    return result
end

--- 停止PPPoE连接
--- @param wanIface string WAN接口名
function pppoeStop(wanIface)
    os.execute("lua /usr/sbin/pppoe.lua down " .. wanIface)
end

--- 启动PPPoE连接
--- @param wanIface string WAN接口名
function pppoeStart(wanIface)
    XQFunction.forkExec("lua /usr/sbin/pppoe.lua up " .. wanIface)
end

--- PPPoE账号捕获（从ISP获取）
--- @param wanIface string WAN接口名
--- @return table 捕获结果
function pppoeCatch(wanIface)
    local LuciUtil = require("luci.util")
    local result = {
        code = 0,
        service = "",
        pppoename = "",
        pppoepasswd = ""
    }
    
    local lines = LuciUtil.execl("pppoe-discovery -I " .. wanIface)
    if lines and type(lines) == "table" then
        for i, line in ipairs(lines) do
            if not XQFunction.isStrNil(line) then
                line = LuciUtil.trim(line)
                
                local service = line:match("^Service%-Name:%s(.+)")
                if not XQFunction.isStrNil(service) then
                    result.service = service
                end
                
                if line:match("PPPoE:") then
                    local username = lines[i + 1]
                    local password = lines[i + 2]
                    
                    if not XQFunction.isStrNil(username) then
                        result.pppoename = LuciUtil.trim(username)
                    end
                    if not XQFunction.isStrNil(password) then
                        result.pppoepasswd = LuciUtil.trim(password)
                    end
                    break
                end
            end
        end
    end
    
    return result
end

--------------------------------------------------------------------------------
-- WAN信息获取
--------------------------------------------------------------------------------

--- 检查有线链路状态
--- @return number 0=无链路, 1=有链路
function checkWiredLink()
    local LuciUtil = require("luci.util")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    
    local wanConfig = XQPortServiceUtil.wanGetConfig()
    local linkStatus = 0
    
    if wanConfig.mode == "single" then
        linkStatus = 0
    elseif wanConfig.mode == "wan" then
        if getWanLink() then
            linkStatus = 1
        end
    elseif wanConfig.mode == "multi" then
        for line in LuciUtil.execi("/sbin/phyhelper link type eth") do
            local port, status = line:match("port:(%d) link:(%S+)")
            if status and status == "up" then
                linkStatus = 1
                break
            end
        end
    end
    
    return linkStatus
end

--- 获取LAN/WAN信息
--- @param iface string 接口类型 "lan" 或 "wan"
--- @return table 接口信息
function getLanWanInfo(iface)
    if iface == "lan" then
        return getLanInfo(iface)
    else
        return getWanInfo(iface)
    end
end

--- 获取LAN接口信息
--- @param iface string 接口名
--- @return table|nil LAN信息
function getLanInfo(iface)
    local status = ubusWanStatus(iface)
    
    if status then
        local result = {}
        result.ipv4 = status.ipv4
        result.uptime = status.uptime
        result.status = status.up and 1 or 0
        result.mac = getLanMac()
        return result
    end
    
    return nil
end

--- 获取WAN接口信息
--- @param wanIface string WAN接口名
--- @return table WAN信息
function getWanInfo(wanIface)
    local result = {}
    
    result.link = getWanLink(wanIface, 1) and 1 or 0
    result.details = getWanDetails(wanIface)
    
    if result.details then
        result.mtu = result.details.mtu
        result.special = result.details.special
    end
    
    result.mac = getWanMac(wanIface)
    
    local ubusStatus = ubusWanStatus(wanIface)
    if ubusStatus then
        result.ipv4 = ubusStatus.ipv4
        result.gateWay = ubusStatus.gw
        result.dnsAddrs = ubusStatus.dns[1] or ""
        result.dnsAddrs1 = ubusStatus.dns[2] or ""
        result.uptime = ubusStatus.uptime
        
        if ubusStatus.up then
            result.status = 1
            if result.details and result.details.wanType == "pppoe" then
                local wanMonitor = getWanMonitorStat()
                if wanMonitor.WANLINKSTAT ~= "UP" then
                    result.status = 0
                end
            end
        else
            result.status = 0
        end
    end
    
    -- IPv6信息
    local wan6Sec = getWan6Sec(wanIface)
    result.ipv6_info = getIp6Details("all", wan6Sec)
    result.ipv6_show = 1
    
    -- 国际版VPN信息
    local international = XQFunction.getFeature("0", "system", "international")
    if "1" == international and wanIface == "wan" then
        local XQVPNUtil = require("xiaoqiang.util.XQVPNUtil")
        local vpnInfo = XQVPNUtil.getVPNInfo("vpn")
        
        if vpnInfo then
            result.vpnInfo = {
                username = vpnInfo.username,
                password = vpnInfo.password,
                server = vpnInfo.server,
                proto = vpnInfo.proto
            }
            
            if chkWan4VPNEnable() then
                result.details.baseWanType = result.details.wanType
                result.details.wanType = vpnInfo.proto
            end
        end
    end
    
    return result
end

--- 获取WAN详细配置
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @return table|nil WAN配置详情
function getWanDetails(wanIface)
    local cursor = luci.model.uci.cursor()
    wanIface = wanIface or "wan"
    
    local wanCfg = cursor:get_all("network", wanIface)
    if not wanCfg then
        return nil
    end
    
    local details = {}
    local proto = wanCfg.proto
    
    if proto == "3g" then
        proto = "mobile"
        details.mtu = wanCfg.mtu
    elseif proto == "static" then
        details.ipaddr = wanCfg.ipaddr
        details.netmask = wanCfg.netmask
        details.gateway = wanCfg.gateway
        details.mtu = wanCfg.mtu
    elseif proto == "pppoe" then
        details.username = wanCfg.username
        details.password = wanCfg.password
        details.peerdns = wanCfg.peerdns
        details.service = wanCfg.service
        details.special = wanCfg.special
        details.mtu = wanCfg.mru
        if XQFunction.isStrNil(details.mtu) then
            details.mtu = "1480"
        end
    elseif proto == "dhcp" then
        details.peerdns = wanCfg.peerdns
        details.mtu = wanCfg.mtu
    end
    
    -- DNS配置
    if wanCfg.dns then
        if type(wanCfg.dns) == "table" and next(wanCfg.dns) ~= nil then
            details.dns = wanCfg.dns
        elseif type(wanCfg.dns) == "string" and wanCfg.dns ~= "" then
            details.dns = luci.util.split(wanCfg.dns, " ")
        end
    end
    
    details.wanType = proto
    details.ifname = wanCfg.ifname
    
    return details
end

--- 获取IPv4信息
--- @param wanIface string WAN接口名
--- @return table IPv4信息
function getIpv4Info(wanIface)
    local status = ubusWanStatus(wanIface)
    local result = {}
    
    if status then
        result.ipv4 = status.ipv4
        result.gw = status.gw
        result.dns = status.dns
    end
    
    return result
end

--------------------------------------------------------------------------------
-- MAC地址验证和处理
--------------------------------------------------------------------------------

--- 检查MAC地址有效性
--- @param macAddr string MAC地址
--- @return boolean 是否有效
function _checkMac(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return false
    end
    
    local DataTypes = require("luci.cbi.datatypes")
    
    if DataTypes.macaddr(macAddr) and 
       macAddr ~= "ff:ff:ff:ff:ff:ff" and 
       macAddr ~= "00:00:00:00:00:00" then
        return true
    end
    
    return false
end

--- 解析MAC地址（去除分隔符并转小写）
--- @param macAddr string MAC地址
--- @return string|nil 处理后的MAC地址
function _parseMac(macAddr)
    if macAddr then
        return string.lower(string.gsub(macAddr, "[:-]", ""))
    end
    return nil
end

--- 获取WAN口MAC地址
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @return string|nil MAC地址
function getWanMac(wanIface)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    wanIface = wanIface or "wan"
    local macAddr = cursor:get("network", wanIface, "macaddr")
    
    if not XQFunction.isStrNil(macAddr) then
        return string.upper(macAddr)
    end
    
    -- 从接口获取MAC
    local ifname = cursor:get("network", wanIface, "ifname")
    if not ifname then
        return nil
    end
    
    local LuciUtil = require("luci.util")
    local output = LuciUtil.exec("ifconfig " .. ifname)
    
    if not XQFunction.isStrNil(output) then
        local mac = output:match("HWaddr (%S+)")
        return mac or nil
    end
    
    return nil
end

--- 设置WAN口MAC地址
--- @param macAddr string 新MAC地址
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @return boolean 是否成功
function setWanMac(macAddr, wanIface)
    local LuciUtil = require("luci.util")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local DataTypes = require("luci.cbi.datatypes")
    
    wanIface = wanIface or "wan"
    local currentMac = cursor:get("network", wanIface, "macaddr")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    local newMac = nil
    
    if currentMac ~= macAddr then
        if XQFunction.isStrNil(macAddr) then
            -- 恢复默认MAC
            local defaultMac = getDefaultWanMacAddress()
            if currentMac ~= defaultMac and defaultMac ~= "null" then
                newMac = defaultMac
            end
        else
            -- 设置新MAC
            if DataTypes.macaddr(macAddr) and 
               macAddr ~= "ff:ff:ff:ff:ff:ff" and 
               macAddr ~= "00:00:00:00:00:00" then
                newMac = macAddr
            end
        end
        
        if newMac then
            cursor:set("network", wanIface, "macaddr", newMac)
            cursor:commit("network")
            
            -- 更新设备配置
            local ifname = cursor:get("network", wanIface, "ifname")
            if ifname then
                -- 更新device配置
            end
            
            -- 重启相关服务
            if XQPortServiceUtil.psIptvBridgeEnable() == 1 then
                XQPortServiceUtil.psRestart("iptv")
            else
                wanRestart()
            end
            
            -- 处理IPv6
            local wanSuffix = LuciUtil.split(wanIface, "_")[2]
            local wan6Iface = "wan6" .. (wanSuffix and ("_" .. wanSuffix) or "")
            local wan6Mode = cursor:get("ipv6", wan6Iface, "mode") or ""
            
            if wan6Mode == "passthrough" then
                wan6Restart(wan6Iface)
            end
            
            return true
        end
    end
    
    return false
end

--------------------------------------------------------------------------------
-- WAN速度设置
--------------------------------------------------------------------------------

--- 获取WAN速度设置
--- @return number 速度值
function getWanSpeed()
    local LuciUtil = require("luci.util")
    local XQPreference = require("xiaoqiang.XQPreference")
    
    local speed = tonumber(XQPreference.get("WAN_SPEED", 0)) or 0
    return speed
end

--- 设置WAN速度
--- @param speed number 速度值
--- @param wanIface string WAN接口名（可选）
--- @return boolean 是否成功
function setWanSpeed(speed, wanIface)
    local LuciUtil = require("luci.util")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    local XQPreference = require("xiaoqiang.XQPreference")
    
    if not speed then
        return false
    end
    
    if XQPortServiceUtil == nil then
        -- 旧版本兼容
        XQPreference.set("WAN_SPEED", speed)
        
        if speed == 10 then
            os.execute("/usr/bin/longloopd stop > /dev/null 2>&1")
        else
            os.execute("/usr/bin/longloopd start > /dev/null 2>&1")
        end
        
        local port = LuciUtil.exec("port_map port service wan")
        os.execute("phyhelper mode set " .. tostring(port) .. " " .. tostring(speed) .. " > /dev/null 2>&1")
    else
        if wanIface then
            XQPreference.set(string.upper(wanIface) .. "_SPEED", speed)
            XQPortServiceUtil.psSetWanLinkMode(wanIface, speed)
        else
            XQPreference.set("WAN_SPEED", speed)
            XQPortServiceUtil.psSetWanLinkMode("wan", speed)
        end
    end
    
    return true
end

--------------------------------------------------------------------------------
-- WAN端口状态
--------------------------------------------------------------------------------

--- 获取WAN端口状态
--- @param portType string 端口类型 "2.5G" 或其他
--- @return number 0=无链路, 1=链路断开, 2=链路正常, 1523=错误
function getWanPortStatus(portType)
    local XQLog = require("xiaoqiang.XQLog")
    local LuciUtil = require("luci.util")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local status = 0
    local linkUp = "1"
    
    if portType then
        if portType == "2.5G" then
            linkUp = LuciUtil.exec("swconfig dev switch0 port 2 get link | grep 'link:up' | wc -l")
        else
            linkUp = LuciUtil.exec("swconfig dev switch1 port 1 get link | grep 'link:up' | wc -l")
        end
        
        linkUp = string.gsub(linkUp, "^[%s\n\r\t]*(.-)[%s\n\r\t]*$", "%1")
        
        if linkUp == "1" then
            local wanUp = LuciUtil.exec("/sbin/ifstatus wan | grep up | awk 'NR==1 {print $2}' | sed -e 's/,//'")
            wanUp = string.gsub(wanUp, "^[%s\n\r\t]*(.-)[%s\n\r\t]*$", "%1")
            
            XQLog.log(6, "getWanPortStatus status  " .. wanUp)
            
            if wanUp == "true" then
                status = 2
            elseif wanUp == "false" then
                status = 1
            else
                status = 1523
            end
        else
            status = 0
        end
    end
    
    XQLog.log(6, "getWanPortStatus result  " .. tostring(status))
    return status
end

--- 获取WAN/LAN模式
--- @return string 端口类型
function getWanLanMode()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local portType = cursor:get("xiaoqiang", "common", "wan_port_type") or ""
    return portType
end

--- 获取WAN接口名
--- @param portType string 端口类型
--- @return string 接口名
function getWanIfname(portType)
    if portType == "2.5G" then
        return "eth1"
    else
        return "eth0.2"
    end
end

--- 获取接口链路状态
--- @param portType string 端口类型
--- @return string "YES" 或 "NO"
function getIntfLink(portType)
    local LuciUtil = require("luci.util")
    local linkUp = "0"
    
    if portType == "2.5G" then
        linkUp = LuciUtil.exec("swconfig dev switch0 port 2 get link | grep 'link:up' | wc -l")
    else
        linkUp = LuciUtil.exec("swconfig dev switch1 port 1 get link | grep 'link:up' | wc -l")
    end
    
    linkUp = string.gsub(linkUp, "^[%s\n\r\t]*(.-)[%s\n\r\t]*$", "%1")
    
    return (linkUp == "1") and "YES" or "NO"
end

--------------------------------------------------------------------------------
-- WAN/LAN端口切换
--------------------------------------------------------------------------------

--- 设置WAN/LAN端口配置
--- @param portType string 目标端口类型
--- @return boolean 是否成功
function setWanLanPort(portType)
    local XQLog = require("xiaoqiang.XQLog")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local currentType = cursor:get("xiaoqiang", "common", "wan_port_type") or ""
    
    XQLog.log(6, "setWanLanPort  " .. currentType .. "-->" .. portType)
    
    if portType then
        if portType == "2.5G" and currentType ~= "2.5G" then
            os.execute("/usr/sbin/switch2.5Gwan.sh ToWanCfg > /dev/null 2>&1")
        elseif portType ~= "2.5G" and currentType == "2.5G" then
            os.execute("/usr/sbin/switch2.5Gwan.sh ToLanCfg > /dev/null 2>&1")
        end
        return true
    end
    
    return false
end

--- 交换WAN/LAN端口
--- @param portType string 目标端口类型
--- @param keepConfig string "0"=不保留配置
--- @return boolean 是否成功
function setWanLanSwap(portType, keepConfig)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local currentType = cursor:get("xiaoqiang", "common", "wan_port_type") or ""
    local configFlag = "1"
    
    if portType then
        if keepConfig ~= "0" then
            configFlag = "0"
        end
        
        if portType == "2.5G" and currentType ~= "2.5G" then
            os.execute("/usr/sbin/switch2.5Gwan.sh toWan " .. configFlag .. " > /dev/null 2>&1")
        elseif portType ~= "2.5G" and currentType == "2.5G" then
            os.execute("/usr/sbin/switch2.5Gwan.sh toLan " .. configFlag .. " > /dev/null 2>&1")
        end
        return true
    end
    
    return false
end

--------------------------------------------------------------------------------
-- 多WAN配置
--------------------------------------------------------------------------------

--- 获取CPE WAN配置
--- @param ipVersion number IP版本 4 或 6
--- @return table WAN配置
function get_cpeWan(ipVersion)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local config = {}
    
    config.wanSection = (ipVersion == 6) and "wan6_2" or "wan_2"
    config.wanIfname = cursor:get("network", config.wanSection, "ifname")
    config.oldWanType = cursor:get("network", config.wanSection, "proto")
    
    return config
end

--- 获取路由器WAN配置
--- @param ipVersion number IP版本
--- @param wanSection string WAN配置节名（可选）
--- @return table WAN配置
function get_routerWan(ipVersion, wanSection)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local config = {}
    
    config.wanSection = (ipVersion == 6) and "wan6" or "wan"
    config.wanIfname = cursor:get("network", config.wanSection, "ifname") or ""
    config.oldWanType = cursor:get("network", config.wanSection, "proto") or ""
    config.wantype = cursor:get("network", config.wanSection, "wantype") or ""
    
    return config
end

--- 获取多WAN配置
--- @param ipVersion number IP版本
--- @param wanType string WAN类型
--- @param wanSection string WAN配置节名（可选）
--- @param maxWan number 最大WAN数量
--- @return table|nil WAN配置
function get_routerMultiWan(ipVersion, wanType, wanSection, maxWan)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    local wanCount = 0
    local instanceId = 0
    local config = {}
    
    if not XQFunction.isStrNil(wanSection) then
        local wanCfg = cursor:get_all("network", wanSection)
        if wanCfg then
            config.wanIfname = wanCfg.ifname
            config.wanSection = wanSection
            config.oldWanType = wanCfg.proto
            config.wantype = wanCfg.wantype
            return config
        end
        return nil
    end
    
    -- 统计现有WAN数量
    cursor:foreach("network", "interface", function(section)
        local name = section[".name"]
        if string.sub(name, 1, 4) == "wan_" or name == "wan" then
            wanCount = wanCount + 1
        end
    end)
    
    if wanCount >= tonumber(maxWan) then
        return nil
    end
    
    if ipVersion == 4 then
        config.oldWanType = wanType
        instanceId = calc_conn_instanceid(wanType, maxWan)
        
        if instanceId < 1 then
            return nil
        end
        
        config.wanIfname = "macv_" .. tostring(instanceId)
        config.wanSection = "wan_" .. tostring(instanceId)
        return config
    end
    
    return nil
end

--- 计算连接实例ID
--- @param wanType string WAN类型
--- @param maxWan number 最大WAN数量
--- @return number 实例ID
function calc_conn_instanceid(wanType, maxWan)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    local excludeId = tonumber(cursor:get("network", "wan", "instance_id"))
    
    for i = 1, tonumber(maxWan) do
        local existingId = cursor:get("network", "wan_" .. tostring(i), "instance_id")
        if not existingId and (excludeId == 0 or excludeId ~= i) then
            XQLog.log(6, "calc_wan_instanceid:  found  idx= " .. tostring(i))
            return i
        end
    end
    
    return 0
end

--- 获取WAN设备配置
--- @param wanSection string WAN配置节名
--- @param deviceType string 设备类型 "CPE" 或 "Router"
--- @param wanType string WAN类型（可选）
--- @param ipVersion number IP版本
--- @return table|nil WAN设备配置
function get_wanDevCfg(wanSection, deviceType, wanType, ipVersion)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local multiwan = tonumber(cursor:get("misc", "features", "multiwan") or "0")
    
    if deviceType == "CPE" then
        return get_cpeWan(ipVersion)
    elseif deviceType == "Router" then
        if multiwan == 0 then
            return get_routerWan(ipVersion, wanType)
        else
            return get_routerMultiWan(ipVersion, wanType, wanSection, multiwan)
        end
    end
    
    return nil
end

--------------------------------------------------------------------------------
-- 网络服务控制
--------------------------------------------------------------------------------

--- 关闭WAN接口
--- @param wanIface string WAN接口名（可选，默认"wan"）
function wanDown(wanIface)
    local LuciUtil = require("luci.util")
    wanIface = wanIface or "wan"
    LuciUtil.exec("env -i /sbin/ifdown " .. wanIface)
end

--- 重启dnsmasq服务
--- @param needRestart boolean 是否需要重启
function dnsmsqRestart(needRestart)
    if needRestart then
        XQFunction.forkExec("ubus call network reload; sleep 1; /etc/init.d/dnsmasq restart > /dev/null")
    end
end

--- 重启VLAN
--- @param vlanEnable string VLAN启用状态
function vlanRestart(vlanEnable)
    if "0" ~= vlanEnable then
        XQFunction.forkExec(". /lib/functions.sh;. /lib/network/switch.sh; setup_switch")
    end
end

--- 重新配置IPv6
--- @param wan6Iface string WAN6接口名
--- @param wan6IfaceID string WAN6接口ID（可选）
function wan6Reconf(wan6Iface, wan6IfaceID)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local ipv6Ver = cursor:get("ipv6", "globals", "ver")
    local wanIface = "wan" .. (wan6IfaceID and ("_" .. wan6IfaceID) or "")
    
    if ipv6Ver == "2" then
        local mode = cursor:get("ipv6", wan6Iface, "mode")
        local automode = cursor:get("ipv6", wan6Iface, "automode")
        
        if automode == "1" then
            XQFunction.forkExec("/usr/sbin/ipv6.sh autocheck " .. wan6Iface .. " clear_result")
            
            if mode == "passthrough" then
                local wan6Cfg = {
                    peerdns = 1,
                    wanIface = wanIface,
                    wan6Iface = wan6Iface,
                    wan6IfaceID = tonumber(wan6IfaceID) or 0,
                    wan6Ifame = cursor:get("network", wanIface, "ifname") or "",
                    wantype = cursor:get("network", wanIface, "wantype")
                }
                
                setWan6Cfg("native", wan6Cfg, false, false)
                setLan6Cfg(0, nil)
            end
        end
    else
        local enabled = cursor:get("ipv6", "settings", "enabled") or ""
        local mode = cursor:get("ipv6", "settings", "mode") or ""
        
        if enabled ~= "0" and mode ~= "off" then
            os.execute("/etc/init.d/ipv6 start_ipv6 " .. mode .. " " .. mode .. " reconfig > /dev/null 2>&1")
        end
    end
end

--- 重启IPv6
--- @param wan6Iface string WAN6接口名
function wan6Restart(wan6Iface)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local ipv6Ver = cursor:get("ipv6", "globals", "ver")
    
    if ipv6Ver == "2" then
        XQFunction.forkExec("/usr/sbin/ipv6.sh reload " .. wan6Iface)
    else
        local enabled = cursor:get("ipv6", "settings", "enabled") or ""
        local mode = cursor:get("ipv6", "settings", "mode") or ""
        
        if enabled == "0" or mode == "off" then
            XQFunction.forkExec("/etc/init.d/ipv6 off")
        else
            XQFunction.forkExec("/etc/init.d/ipv6 start_ipv6 " .. mode)
        end
    end
end

--- 重启WAN接口
--- @param wanIface string WAN接口名（可选，默认"wan"）
--- @param async boolean 是否异步执行
--- @param delay number 延迟秒数（可选）
function wanRestart(wanIface, async, delay)
    wanIface = wanIface or "wan"
    local cmd = "/sbin/ifup " .. wanIface .. ";"
    
    if async then
        if delay then
            cmd = "sleep " .. tostring(delay) .. "; " .. cmd
        end
        XQFunction.forkExec(cmd)
    else
        local LuciUtil = require("luci.util")
        LuciUtil.exec(cmd)
    end
end

--- 重启多WAN服务
function multiwanRestart()
    local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
    local multiwan = XQFunction.getFeature("0", "system", "multiwan")
    
    if "1" == multiwan then
        XQMultiWanPolicy.restartService()
    end
end

--- 重启相关服务
function serviceRestart()
    local cmd = [[
        /etc/init.d/dnsmasq restart;
        /etc/init.d/miqos restart;
        /etc/init.d/wan_check restart;
    ]]
    XQFunction.forkExec(cmd)
end

--- WAN服务重启（综合）
--- @param wanIface string WAN接口名
--- @param proto string 协议类型
--- @param needRestart boolean 是否需要重启WAN
--- @param dnsChanged boolean DNS是否变化
--- @param vlanEnable string VLAN启用状态
--- @param protoChanged boolean 协议是否变化
function wanServiceRestart(wanIface, proto, needRestart, dnsChanged, vlanEnable, protoChanged)
    local LuciUtil = require("luci.util")
    
    local wanSuffix = LuciUtil.split(wanIface, "_")[2]
    local wan6Iface = "wan6" .. (wanSuffix and ("_" .. wanSuffix) or "")
    
    wan6Reconf(wan6Iface, wanSuffix)
    
    if protoChanged then
        local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
        if XQPortServiceUtil ~= nil then
            if XQPortServiceUtil.wandtEnable("wan") then
                wan6Restart(wan6Iface)
                XQFunction.forkExec("ubus call network reload")
                XQPortServiceUtil.wanRedetect()
                return
            end
        end
    end
    
    if needRestart then
        wanRestart(wanIface)
    else
        dnsmsqRestart(dnsChanged)
        if proto == "pppoe" then
            local pppoeStatus = getPPPoEStatus(wanIface)
            if pppoeStatus and pppoeStatus.status == 4 then
                pppoeStart(wanIface)
            end
        end
    end
    
    wan6Restart(wan6Iface)
    vlanRestart(vlanEnable)
    multiwanRestart()
    serviceRestart()
end

--------------------------------------------------------------------------------
-- MTU和DNS检查
--------------------------------------------------------------------------------

--- 检查MTU值有效性
--- @param mtu number MTU值
--- @param proto string 协议类型（可选）
--- @param vlanEnable string VLAN启用状态（可选）
--- @return boolean 是否有效
function checkMTU(mtu, proto, vlanEnable)
    local mtuNum = tonumber(mtu)
    local maxMtu = 1500
    
    if proto and proto == "pppoe" then
        maxMtu = 1492
    end
    
    if vlanEnable == "1" then
        maxMtu = maxMtu - 4
    end
    
    if mtuNum and mtuNum >= 576 and mtuNum <= maxMtu then
        return true
    end
    
    return false
end

--- 计算MTU值
--- @param mtu number 原始MTU值
--- @param vlanEnable string VLAN启用状态
--- @return number 计算后的MTU值
function calcMtu(mtu, vlanEnable)
    local result = 1500
    
    if mtu then
        result = tonumber(mtu)
    end
    
    if result == 1500 and vlanEnable and "0" ~= vlanEnable then
        result = 1496
    end
    
    return result
end

--- 检查WAN DNS配置
--- @param peerdns string 是否使用ISP DNS "1"=是
--- @param dns1 string DNS1
--- @param dns2 string DNS2
--- @return number 0=成功, 错误码
function chkWanDns(peerdns, dns1, dns2)
    if peerdns == "1" then
        return 0
    end
    
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
        return 1502
    end
    
    if not XQFunction.isStrNil(dns1) then
        if not XQFunction.checkDns(dns1) then
            return 1537
        end
    end
    
    if not XQFunction.isStrNil(dns2) then
        if not XQFunction.checkDns(dns2) then
            return 1537
        end
    end
    
    return 0
end

--- 检查DNS是否变化
--- @param oldDns table|string 旧DNS
--- @param newDns1 string 新DNS1
--- @param newDns2 string 新DNS2
--- @return boolean 是否变化
function chkDnsChg(oldDns, newDns1, newDns2)
    local newDnsList = {}
    local oldDnsList = {}
    
    if oldDns then
        if type(oldDns) == "string" then
            oldDnsList = {oldDns}
        elseif type(oldDns) == "table" then
            oldDnsList = oldDns
        end
    end
    
    if not XQFunction.isStrNil(newDns1) then
        table.insert(newDnsList, newDns1)
    end
    if not XQFunction.isStrNil(newDns2) then
        table.insert(newDnsList, newDns2)
    end
    
    if #newDnsList == #oldDnsList then
        if #newDnsList == 0 then
            return false
        end
        
        local dnsMap = {}
        local matchCount = 0
        
        for _, dns in ipairs(newDnsList) do
            dnsMap[dns] = 1
        end
        
        for _, dns in ipairs(oldDnsList) do
            if dnsMap[dns] == 1 then
                matchCount = matchCount + 1
            end
        end
        
        if matchCount == #newDnsList then
            return false
        end
    end
    
    return true
end

--- 生成DNS配置
--- @param dns1 string DNS1
--- @param dns2 string DNS2
--- @return table|string|nil DNS配置
function generateDns(dns1, dns2)
    local result = nil
    
    if not XQFunction.isStrNil(dns1) and not XQFunction.isStrNil(dns2) then
        result = {dns1, dns2}
    elseif not XQFunction.isStrNil(dns1) then
        result = dns1
    elseif not XQFunction.isStrNil(dns2) then
        result = dns2
    end
    
    return result
end

--------------------------------------------------------------------------------
-- WAN类型设置
--------------------------------------------------------------------------------

--- 检查PPPoE参数
--- @param peerdns string 是否使用ISP DNS
--- @param username string 用户名
--- @param password string 密码
--- @param mtu string MTU值（可选）
--- @param dns1 string DNS1（可选）
--- @param dns2 string DNS2（可选）
--- @param service string 服务名（可选）
--- @return number 0=成功, 错误码
function chkWan4PPPoE(peerdns, username, password, mtu, dns1, dns2, service)
    if not XQFunction.isStrNil(peerdns) and peerdns == 0 then
        if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            return 1502
        end
    end
    
    if XQFunction.isStrNil(username) or XQFunction.isStrNil(password) then
        return 1528
    end
    
    if mtu then
        if not checkMTU(mtu, "pppoe") then
            return 1590
        end
    else
        if not XQFunction.isStrNil(dns1) or not XQFunction.isStrNil(dns2) then
            return chkWanDns(peerdns, dns1, dns2)
        end
    end
    
    return 0
end

--- 设置WAN为PPPoE模式
--- @param config table 配置参数
--- @return number 0=成功
function setWan4PPPoE(config)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local vlanEnable = cursor:get("vlan_service", "Internet", "enable") or ""
    local oldCfg = cursor:get_all("network", config.wanDevCfg.wanSection) or {}
    
    local dnsChanged = chkDnsChg(oldCfg.dns, config.dns1, config.dns2)
    local protoChanged = (oldCfg.proto ~= "pppoe")
    
    local mru = 1480
    local mtu = 1500
    
    if config.mtu then
        mru = tonumber(config.mtu) or 1480
    end
    
    if "1" == vlanEnable and mtu > 1496 then
        mtu = 1496
        if mru >= 1492 then
            mru = 1488
        end
    end
    
    -- 检查是否需要重启
    local needRestart = true
    if oldCfg.username == config.username and
       oldCfg.password == config.password and
       tonumber(oldCfg.mru) == mru and
       oldCfg.service == config.service then
        if oldCfg.special == config.special or (not oldCfg.special and config.special == "0") then
            needRestart = false
        end
    end
    
    -- 构建新配置
    local newCfg = {
        proto = "pppoe",
        ifname = oldCfg.ifname,
        username = config.username,
        password = config.password,
        dns = generateDns(config.dns1, config.dns2),
        peerdns = config.autoset,
        macaddr = oldCfg.macaddr,
        service = config.service,
        mru = mru,
        mtu = mtu,
        special = config.special,
        ipv6 = getIpv6Opt(config.wanDevCfg.wanSection, "pppoe", oldCfg.ipv6),
        wantype = oldCfg.wantype,
        disabled = oldCfg.disabled,
        force_disable_ipv6 = getForceDisableIpv6Opt("pppoe", oldCfg.force_disable_ipv6)
    }
    
    cursor:delete("network", config.wanDevCfg.wanSection)
    cursor:section("network", "interface", config.wanDevCfg.wanSection, newCfg)
    cursor:commit("network")
    
    -- 上传配置
    if config.username and config.password then
        local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
        XQSysUtil.doConfUpload({
            pppoe_name = config.username,
            pppoe_password = config.password
        })
    end
    
    wanServiceRestart(config.wanDevCfg.wanSection, "pppoe", needRestart, dnsChanged, vlanEnable, protoChanged)
    
    return 0
end

--- 检查DHCP参数
--- @param peerdns string 是否使用ISP DNS
--- @param dns1 string DNS1（可选）
--- @param dns2 string DNS2（可选）
--- @return number 0=成功, 错误码
function chkWan4Dhcp(peerdns, dns1, dns2)
    if not XQFunction.isStrNil(peerdns) and peerdns == 0 then
        if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            return 1502
        end
    end
    
    return chkWanDns(peerdns, dns1, dns2)
end

--- 设置WAN为DHCP模式
--- @param config table 配置参数
--- @return number 0=成功
function setWan4Dhcp(config)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local vlanEnable = cursor:get("vlan_service", "Internet", "enable") or ""
    local mtu = calcMtu(config.mtu, vlanEnable)
    local oldCfg = cursor:get_all("network", config.wanDevCfg.wanSection) or {}
    
    local dnsChanged = chkDnsChg(oldCfg.dns, config.dns1, config.dns2)
    local protoChanged = (oldCfg.proto ~= "dhcp")
    
    local newCfg = {
        proto = "dhcp",
        ifname = oldCfg.ifname,
        dns = generateDns(config.dns1, config.dns2),
        macaddr = oldCfg.macaddr,
        peerdns = config.autoset,
        mtu = mtu,
        ipv6 = getIpv6Opt(config.wanDevCfg.wanSection, "dhcp", oldCfg.ipv6),
        wantype = oldCfg.wantype,
        disabled = oldCfg.disabled,
        force_disable_ipv6 = oldCfg.force_disable_ipv6
    }
    
    cursor:delete("network", config.wanDevCfg.wanSection)
    cursor:section("network", "interface", config.wanDevCfg.wanSection, newCfg)
    cursor:commit("network")
    
    wanServiceRestart(config.wanDevCfg.wanSection, "dhcp", protoChanged, dnsChanged, vlanEnable, protoChanged)
    
    return 0
end

--- 检查WAN IP地址有效性
--- @param ipAddr string IP地址
--- @param netmask string 子网掩码
--- @return number 0=成功, 错误码
function checkWanIp(ipAddr, netmask)
    local LuciIP = require("luci.ip")
    local ipNum = LuciIP.iptonl(ipAddr)
    
    -- 检查有效IP范围
    if (ipNum >= LuciIP.iptonl("1.0.0.0") and ipNum <= LuciIP.iptonl("126.255.255.255")) or
       (ipNum >= LuciIP.iptonl("128.0.0.0") and ipNum < LuciIP.iptonl("169.254.0.0")) or
       (ipNum > LuciIP.iptonl("169.254.255.255") and ipNum <= LuciIP.iptonl("223.255.255.255")) then
        -- 有效范围
    else
        return 1533
    end
    
    -- 检查是否为广播或多播地址
    if XQFunction.isBroadcastOrMulticast(ipAddr, netmask) then
        return 1530
    end
    
    return 0
end

--- 检查子网是否匹配
--- @param ip1 string IP地址1
--- @param ip2 string IP地址2
--- @param netmask string 子网掩码
--- @return number 0=匹配, 1531=不匹配
function checkSubnet(ip1, ip2, netmask)
    local LuciIP = require("luci.ip")
    local LuciUtil = require("luci.util")
    local bit = require("bit")
    
    local maskParts = LuciUtil.split(netmask, ".")
    local ip1Parts = LuciUtil.split(ip1, ".")
    local ip2Parts = LuciUtil.split(ip2, ".")
    
    -- 计算IP和掩码的数值
    local ip1Num = bit.lshift(tonumber(ip1Parts[1]), 24) +
                   bit.lshift(tonumber(ip1Parts[2]), 16) +
                   bit.lshift(tonumber(ip1Parts[3]), 8) +
                   tonumber(ip1Parts[4])
    
    local ip2Num = bit.lshift(tonumber(ip2Parts[1]), 24) +
                   bit.lshift(tonumber(ip2Parts[2]), 16) +
                   bit.lshift(tonumber(ip2Parts[3]), 8) +
                   tonumber(ip2Parts[4])
    
    local maskNum = bit.lshift(tonumber(maskParts[1]), 24) +
                    bit.lshift(tonumber(maskParts[2]), 16) +
                    bit.lshift(tonumber(maskParts[3]), 8) +
                    tonumber(maskParts[4])
    
    local net1 = bit.band(ip1Num, maskNum)
    local net2 = bit.band(ip2Num, maskNum)
    
    if tonumber(net1) ~= tonumber(net2) then
        return 1531
    end
    
    return 0
end

--- 检查静态IP参数
--- @param peerdns string 是否使用ISP DNS
--- @param ipAddr string IP地址
--- @param netmask string 子网掩码
--- @param gateway string 网关
--- @param dns1 string DNS1（可选）
--- @param dns2 string DNS2（可选）
--- @return number 0=成功, 错误码
function chkWan4StaticIP(peerdns, ipAddr, netmask, gateway, dns1, dns2)
    local DataTypes = require("luci.cbi.datatypes")
    
    if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
        return 1502
    end
    
    if not DataTypes.ipaddr(ipAddr) then
        return 1530
    end
    
    if not XQFunction.checkMask(netmask) then
        return 1531
    end
    
    if not DataTypes.ipaddr(gateway) then
        return 1532
    end
    
    -- 检查是否与LAN网段冲突
    if peerdns ~= "0" then
        local LuciIP = require("luci.ip")
        local lanIp = getLanWanIp("lan")[1]
        
        local lanIpNum = LuciIP.iptonl(lanIp.ip)
        local lanMaskNum = LuciIP.iptonl(lanIp.mask)
        local wanIpNum = LuciIP.iptonl(ipAddr)
        local wanMaskNum = LuciIP.iptonl(netmask)
        
        local lanNet = bit.band(lanIpNum, lanMaskNum)
        local wanNet1 = bit.band(wanIpNum, lanMaskNum)
        local wanNet2 = bit.band(wanIpNum, wanMaskNum)
        
        if lanNet == wanNet1 or bit.band(lanIpNum, wanMaskNum) == wanNet2 then
            return 1526
        end
    end
    
    local result = checkWanIp(ipAddr, netmask)
    if result ~= 0 then
        return result
    end
    
    result = checkWanIp(gateway, netmask)
    if result ~= 0 then
        return 1532
    end
    
    result = checkSubnet(ipAddr, gateway, netmask)
    if result ~= 0 then
        return result
    end
    
    return chkWanDns(0, dns1, dns2)
end

--- 设置WAN为静态IP模式
--- @param config table 配置参数
--- @return number 0=成功
function setWan4StaticIP(config)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local vlanEnable = cursor:get("vlan_service", "Internet", "enable") or ""
    local needRestart = true
    local mtu = calcMtu(config.mtu, vlanEnable)
    local oldCfg = cursor:get_all("network", config.wanDevCfg.wanSection) or {}
    
    local dnsChanged = chkDnsChg(oldCfg.dns, config.dns1, config.dns2)
    
    -- 检查是否需要重启
    if oldCfg.proto == "static" and
       oldCfg.ipaddr == config.ip and
       oldCfg.netmask == config.mask and
       oldCfg.gateway == config.gw and
       oldCfg.mtu == mtu then
        needRestart = false
    end
    
    local newCfg = {
        proto = "static",
        ipaddr = config.ip,
        netmask = config.mask,
        gateway = config.gw,
        dns = generateDns(config.dns1, config.dns2),
        macaddr = oldCfg.macaddr,
        ifname = oldCfg.ifname,
        mtu = mtu,
        ipv6 = getIpv6Opt(config.wanDevCfg.wanSection, "static", oldCfg.ipv6),
        wantype = oldCfg.wantype,
        disabled = oldCfg.disabled,
        force_disable_ipv6 = oldCfg.force_disable_ipv6
    }
    
    cursor:delete("network", config.wanDevCfg.wanSection)
    cursor:section("network", "interface", config.wanDevCfg.wanSection, newCfg)
    cursor:commit("network")
    
    wanServiceRestart(config.wanDevCfg.wanSection, "static", needRestart, dnsChanged, vlanEnable, needRestart)
    
    return 0
end

--------------------------------------------------------------------------------
-- IPv6配置辅助函数
--------------------------------------------------------------------------------

--- 获取IPv6选项
--- @param wanIface string WAN接口名
--- @param proto string 协议类型
--- @param oldIpv6 string 旧IPv6配置（可选）
--- @return string IPv6配置值
function getIpv6Opt(wanIface, proto, oldIpv6)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local ipv6Ver = cursor:get("ipv6", "globals", "ver")
    
    if ipv6Ver == "2" then
        local result = setWan4AssocWan6cfg(wanIface, proto)
        if result then
            return result
        end
    end
    
    return oldIpv6 or "0"
end

--- 获取强制禁用IPv6选项
--- @param proto string 协议类型
--- @param oldValue string 旧配置值
--- @return string 配置值
function getForceDisableIpv6Opt(proto, oldValue)
    local cpe = XQFunction.getFeature("0", "system", "cpe")
    
    if "1" == cpe and proto == "pppoe" then
        local multiwan = XQFunction.getFeature("0", "system", "multiwan")
        if "1" == multiwan then
            local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
            local enable = XQMultiWanPolicy.getEnable()
            
            if enable ~= 0 then
                local policy = XQMultiWanPolicy.getPolicy()
                if policy == 0 then
                    return "1"
                end
            end
        end
    end
    
    return oldValue
end

--- 设置WAN4关联的WAN6配置
--- @param wanIface string WAN接口名
--- @param proto string 协议类型
--- @return string|nil IPv6配置值
function setWan4AssocWan6cfg(wanIface, proto)
    local LuciUtil = require("luci.util")
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local disabled = ""
    local wanSuffix = LuciUtil.split(wanIface, "_")[2]
    local wan6Iface = "wan6" .. (wanSuffix and ("_" .. wanSuffix) or "")
    
    if not cursor:get("network", wan6Iface) then
        return nil
    end
    
    local autoMode = "1"
    local wan6IfaceReal = wan6Iface
    local mode = cursor:get("ipv6", wan6Iface, "mode")
    
    if proto == "pppoe" and mode ~= "dhcpv6" then
        disabled = 1
        autoMode = "auto"
        wan6IfaceReal = wanIface
    end
    
    if mode == "native" or mode == "static" or mode == "relay" or mode == "pi_relay" then
        cursor:set("network", wan6Iface, "disabled", disabled)
        cursor:commit("network")
    end
    
    if mode == "relay" or mode == "pi_relay" then
        cursor:set("dhcp", wan6Iface, "interface", wan6IfaceReal)
        cursor:commit("dhcp")
    end
    
    return autoMode
end

--------------------------------------------------------------------------------
-- IPv6 WAN配置（旧版本兼容）
--------------------------------------------------------------------------------

--- 设置IPv6 WAN（旧版本）
--- @param mode string IPv6模式
--- @param dns1 string DNS1（可选）
--- @param dns2 string DNS2（可选）
--- @param ip6addr string IPv6地址（可选）
--- @param ip6gw string IPv6网关（可选）
--- @param ip6prefix string IPv6前缀（可选）
--- @param ip6prefixlen string IPv6前缀长度（可选）
function setWan6(mode, dns1, dns2, ip6addr, ip6gw, ip6prefix, ip6prefixlen)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local cmd = nil
    dns1 = XQFunction._strformat(dns1)
    dns2 = XQFunction._strformat(dns2)
    
    if mode == "native" or mode == "nat" then
        if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 %s", mode)
        elseif not XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 %s '%s'", mode, dns1)
        elseif XQFunction.isStrNil(dns1) and not XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 %s '%s'", mode, dns2)
        else
            cmd = string.format("sleep 1; /etc/init.d/ipv6 %s '%s','%s'", mode, dns1, dns2)
        end
    elseif mode == "static" then
        ip6addr = XQFunction._strformat(ip6addr)
        ip6gw = XQFunction._strformat(ip6gw)
        ip6prefix = XQFunction._strformat(ip6prefix)
        ip6prefixlen = XQFunction._strformat(ip6prefixlen)
        
        if XQFunction.isStrNil(ip6prefixlen) then
            ip6prefixlen = "64"
        end
        
        ip6prefix = ip6prefix .. "1/" .. ip6prefixlen
        
        if XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s'", ip6addr, ip6gw, ip6prefix, ip6prefixlen)
        elseif not XQFunction.isStrNil(dns1) and XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s'", ip6addr, ip6gw, ip6prefix, ip6prefixlen, dns1)
        elseif XQFunction.isStrNil(dns1) and not XQFunction.isStrNil(dns2) then
            cmd = string.format("sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s'", ip6addr, ip6gw, ip6prefix, ip6prefixlen, dns2)
        else
            cmd = string.format("sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s','%s'", ip6addr, ip6gw, ip6prefix, ip6prefixlen, dns1, dns2)
        end
    elseif mode == "off" then
        cmd = "sleep 1; /etc/init.d/ipv6 off"
    end
    
    if not XQFunction.isStrNil(cmd) then
        XQFunction.forkExec(cmd)
    end
    
    if mode ~= "off" then
        cursor:set("ipv6", "settings", "ipv6_show", "1")
        cursor:commit("ipv6")
        cursor:delete("network", "vpn6")
        cursor:commit("network")
    end
end

--------------------------------------------------------------------------------
-- IPv6防火墙设置
--------------------------------------------------------------------------------

--- 设置IPv6防火墙（旧版本）
--- @param enable string "0"=关闭, "1"=开启
function setIpv6Firewall(enable)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local current = cursor:get("ipv6", "settings", "firewall")
    local mode = cursor:get("ipv6", "settings", "mode")
    
    if enable ~= "0" then
        enable = "1"
    end
    
    if current and current == enable then
        return
    end
    
    cursor:set("ipv6", "settings", "firewall", enable)
    cursor:commit("ipv6")
    
    if mode == "native" then
        XQFunction.forkExec("/etc/init.d/ipv6 set_firewall " .. enable)
    end
end

--- 获取IPv6防火墙状态（旧版本）
--- @return string 防火墙状态
function getIpv6Firewall()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    return cursor:get("ipv6", "settings", "firewall") or ""
end

--- 设置IPv6防火墙（V2版本）
--- @param enable string "0"=关闭, "1"=开启
function setIpv6FirewallV2(enable)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local current = cursor:get("ipv6", "globals", "firewall")
    
    if enable ~= "0" then
        enable = "1"
    end
    
    if current and current == enable then
        return
    end
    
    cursor:set("ipv6", "globals", "firewall", enable)
    cursor:commit("ipv6")
    
    XQFunction.forkExec("/usr/sbin/ipv6.sh set_firewall " .. enable)
end

--- 获取IPv6防火墙状态（V2版本）
--- @return string 防火墙状态
function getIpv6FirewallV2()
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    return cursor:get("ipv6", "globals", "firewall") or ""
end

--------------------------------------------------------------------------------
-- IPv6 WAN信息获取
--------------------------------------------------------------------------------

--- 获取WAN6信息
--- @param wan6Iface string WAN6接口名（可选，默认"wan6"）
--- @return table IPv6信息
function getWan6Info(wan6Iface)
    local result = {}
    
    result.ipv6_info = getIp6Details("status", wan6Iface or "wan6")
    result.ipv6_show = 1
    
    return result
end

--- 获取WAN6配置节名
--- @param wanIface string WAN接口名
--- @return string WAN6配置节名
function getWan6Sec(wanIface)
    if not wanIface then
        return "wan6"
    end
    
    local pos = string.find(wanIface, "_")
    if pos and pos > 1 then
        local prefix = string.sub(wanIface, 1, pos - 1)
        local suffix = string.sub(wanIface, pos)
        return prefix .. "6" .. suffix
    end
    
    return "wan6"
end

--------------------------------------------------------------------------------
-- IPv6 WAN配置（V2版本）
--------------------------------------------------------------------------------

--- 检查WAN6模式支持
--- @param wan6Iface string WAN6接口名
--- @param mode string IPv6模式
--- @return number 0=支持, 1=不支持
function chkWan6Mode(wan6Iface, mode)
    local UCI = require("luci.model.uci")
    local cursor = UCI.cursor()
    
    local supportModes = cursor:get_list("ipv6", wan6Iface, "support_modes") or {}
    
    if #supportModes == 0 then
        return 0
    end
    
    for _, m in ipairs(supportModes) do
        if mode == m then
            return 0
        end
    end
    
    return 1
end

--- 检查DHCPv6配置参数
--- @param nat6Enabled number NAT6是否启用
--- @param ip6prefix string IPv6前缀
--- @param ip6prefixlen string IPv6前缀长度
--- @return number 0=成功, 错误码
function chkWan6CfgDHCPv6(nat6Enabled, ip6prefix, ip6prefixlen)
    local DataTypes = require("luci.cbi.datatypes")
    
    if not nat6Enabled and nat6Enabled ~= 0 then
        if not XQFunction.isStrNil(ip6prefix) then
            if DataTypes.ip6addr(ip6prefix) and string.sub(ip6prefix, -2) == "::" then
                -- 有效
            else
                return 2602
            end
        else
            return 2602
        end
        
        if not DataTypes.ip6prefix(ip6prefixlen) then
            return 2603
        end
    end
    
    return 0
end

--- 检查PPPoEv6配置参数
--- @param nat6Enabled number NAT6是否启用
--- @param ip6prefix string IPv6前缀
--- @param ip6prefixlen string IPv6前缀长度
--- @param usePPPoEv4 number 是否使用PPPoEv4
--- @param username string 用户名
--- @param password string 密码
--- @return number 0=成功, 错误码
function chkWan6CfgPPPoEv6(nat6Enabled, ip6prefix, ip6prefixlen, usePPPoEv4, username, password)
    local DataTypes = require("luci.cbi.datatypes")
    
    if not nat6Enabled and nat6Enabled ~= 0 then
        if not XQFunction.isStrNil(ip6prefix) then
            if DataTypes.ip6addr(ip6prefix) and string.sub(ip6prefix, -2) == "::" then
                -- 有效
            else
                return 2602
            end
        else
            return 2602
        end
        
        if not DataTypes.ip6prefix(ip6prefixlen) then
            return 2603
        end
    end
    
    if not usePPPoEv4 and usePPPoEv4 == 0 then
        if XQFunction.isStrNil(username) or XQFunction.isStrNil(password) then
            return 1528
        end
    end
    
    return 0
end

--- 检查静态IPv6配置参数
--- @param ip6addr string IPv6地址
--- @param ip6gw string IPv6网关
--- @param ip6prefix string IPv6前缀
--- @param ip6prefixlen string IPv6前缀长度
--- @return number 0=成功, 错误码
function chkWan6CfgStatic(ip6addr, ip6gw, ip6prefix, ip6prefixlen)
    local DataTypes = require("luci.cbi.datatypes")
    
    if XQFunction.isStrNil(ip6addr) or not DataTypes.ip6addr(ip6addr) then
        return 2600
    end
    
    if XQFunction.isStrNil(ip6gw) or not DataTypes.ip6addr(ip6gw) then
        return 2601
    end
    
    if XQFunction.isStrNil(ip6prefix) or not DataTypes.ip6addr(ip6prefix) or string.sub(ip6prefix, -2) ~= "::" then
        return 2602
    end
    
    if not DataTypes.ip6prefix(ip6prefixlen) then
        return 2603
    end
    
    return 0
end

--- 检查6in4隧道配置参数
--- @param peeraddr string 对端IPv4地址
--- @param ip6addr string IPv6地址
--- @param ip6prefix string IPv6前缀
--- @param ip6prefixlen string IPv6前缀长度
--- @param tunnelid string 隧道ID（可选）
--- @param username string 用户名（可选）
--- @param password string 密码（可选）
--- @return number 0=成功, 错误码
function chkWan6Cfg6in4(peeraddr, ip6addr, ip6prefix, ip6prefixlen, tunnelid, username, password)
    local DataTypes = require("luci.cbi.datatypes")
    
    if XQFunction.isStrNil(peeraddr) or not DataTypes.ip4addr(peeraddr) then
        return 2605
    end
    
    if XQFunction.isStrNil(ip6addr) or not DataTypes.ip6addr(ip6addr) then
        return 2600
    end
    
    if XQFunction.isStrNil(ip6prefix) or not DataTypes.ip6addr(ip6prefix) or string.sub(ip6prefix, -2) ~= "::" then
        return 2602
    end
    
    if not DataTypes.ip6prefix(ip6prefixlen) then
        return 2603
    end
    
    if not XQFunction.isStrNil(tunnelid) then
        if XQFunction.isStrNil(username) or XQFunction.isStrNil(password) then
            return 1528
        end
    end
    
    return 0
end

--- 检查6to4隧道配置参数
--- @param peeraddr string 对端IPv4地址
--- @return number 0=成功, 错误码
function chkWan6Cfg6to4(peeraddr)
    local DataTypes = require("luci.cbi.datatypes")
    
    if XQFunction.isStrNil(peeraddr) or not DataTypes.ip4addr(peeraddr) then
        return 2605
    end
    
    return 0
end

--- 检查6rd隧道配置参数
--- @param useDHCP number 是否使用DHCP
--- @param peeraddr string 对端IPv4地址
--- @param ip6prefix string IPv6前缀
--- @param ip6prefixlen string IPv6前缀长度
--- @return