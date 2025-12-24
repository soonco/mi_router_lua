--[[
LuCI 系统信息模块
luci.sys - System Information Module

该模块提供系统级别的信息获取和操作功能：
- 系统信息（CPU、内存、负载、运行时间）
- 网络信息（ARP表、路由表、接口、连接跟踪）
- 进程管理（列表、信号、用户切换）
- 用户管理（密码验证、密码设置）
- WiFi信息获取
- 初始化脚本管理
]]--

local io = require("io")
local os = require("os")
local table = require("table")
local nixio = require("nixio")
local nixioFs = require("nixio.fs")
local uci = require("luci.model.uci")

local luci = {}
luci.util = require("luci.util")
luci.ip = require("luci.ip")

local tonumber = tonumber
local ipairs = ipairs
local pairs = pairs
local pcall = pcall
local type = type
local next = next
local setmetatable = setmetatable
local require = require
local select = select

module("luci.sys")

function call(...)
    return os.execute(...) / 256
end

exec = luci.util.exec

function mounts()
    local result = {}
    local fields = { "fs", "blocks", "used", "available", "percent", "mountpoint" }
    
    local dfOutput = luci.util.execi("df")
    if not dfOutput then
        return
    end
    
    dfOutput()
    
    for line in dfOutput do
        local mount = {}
        local index = 1
        for field in line:gmatch("%S+") do
            mount[fields[index]] = field
            index = index + 1
        end
        
        if mount.fs then
            if not mount.fs:match("^/") then
                index = 2
                for field in line:gmatch("%S+") do
                    mount[fields[index]] = field
                    index = index + 1
                end
            end
            result[#result + 1] = mount
        end
    end
    
    return result
end

getenv = nixio.getenv

function hostname(newHostname)
    if type(newHostname) == "string" and #newHostname > 0 then
        nixioFs.writefile("/proc/sys/kernel/hostname", newHostname)
        return newHostname
    else
        return nixio.uname().nodename
    end
end

function httpget(url, stream, target)
    if not target then
        local execFunc = stream and io.popen or luci.util.exec
        return execFunc("wget -qO- '" .. url:gsub("'", "") .. "'")
    else
        return os.execute("wget -qO '%s' '%s'" % { target:gsub("'", ""), url:gsub("'", "") })
    end
end

function loadavg()
    local sysinfo = nixio.sysinfo()
    return sysinfo.loads[1], sysinfo.loads[2], sysinfo.loads[3]
end

function reboot()
    return os.execute("reboot >/dev/null 2>&1")
end

function sysinfo()
    local cpuinfo = nixioFs.readfile("/proc/cpuinfo")
    local meminfo = nixioFs.readfile("/proc/meminfo")
    
    local memTotal = tonumber(meminfo:match("MemTotal:%s*(%d+)"))
    local memCached = tonumber(meminfo:match("\nCached:%s*(%d+)"))
    local memFree = tonumber(meminfo:match("MemFree:%s*(%d+)"))
    local memBuffers = tonumber(meminfo:match("Buffers:%s*(%d+)"))
    local bogomips = tonumber(cpuinfo:match("[Bb]ogo[Mm][Ii][Pp][Ss].-: ([^\n]+)")) or nil
    
    local cpuModel = cpuinfo:match("\nsystem type\t+: ([^\n]+)")
    if not cpuModel then
        cpuModel = cpuinfo:match("\nProcessor\t+: ([^\n]+)")
        if not cpuModel then
            cpuModel = cpuinfo:match("\nmodel name\t+: ([^\n]+)")
        end
    end
    
    local boardModel = luci.util.pcdata(nixioFs.readfile("/tmp/sysinfo/model"))
    if not boardModel then
        boardModel = cpuinfo:match("\nmachine\t+: ([^\n]+)")
        if not boardModel then
            boardModel = cpuinfo:match("\nHardware\t+: ([^\n]+)")
            if not boardModel then
                boardModel = luci.util.pcdata(nixioFs.readfile("/proc/diag/model"))
                if not boardModel then
                    boardModel = nixio.uname().machine or nil
                end
            end
        end
    end
    
    return cpuModel, boardModel, memTotal, memCached, memBuffers, memFree, bogomips
end

function syslog()
    return luci.util.exec("logread")
end

function dmesg()
    return luci.util.exec("dmesg")
end

function uniqueid(bytes)
    local data = nixioFs.readfile("/dev/urandom", bytes)
    if data then
        return nixio.bin.hexlify(data)
    end
    return data
end

function uptime()
    return nixio.sysinfo().uptime
end

net = {}

function net.arptable(callback)
    local result
    
    for line in luci.util.execi("cat /proc/net/arp") do
        local entry = {}
        for field in line:gmatch("%S+") do
            entry[#entry + 1] = field
        end
        
        if entry[1] ~= "IP" then
            local arp = {
                ["IP address"] = entry[1],
                ["HW type"] = entry[2],
                ["Flags"] = entry[3],
                ["HW address"] = entry[4],
                ["Mask"] = entry[5],
                ["Device"] = entry[6]
            }
            
            if callback then
                callback(arp)
            else
                result = result or {}
                result[entry[1]] = arp
            end
        end
    end
    
    return result
end

function net.host_hints(callback)
    local cursor = uci.cursor()
    local ifaceData = {}
    local hostData = {}
    
    local function addHost(family, mac, ipv4, ipv6, name)
        local key = select(family, mac, ipv4, ipv6)
        if key then
            if not hostData[key] then
                hostData[key] = {}
            end
            hostData[key][1] = select(1, mac) or hostData[key][1]
            hostData[key][2] = select(2, ipv4) or hostData[key][2]
            hostData[key][3] = select(3, ipv6) or hostData[key][3]
            hostData[key][4] = select(4, name) or hostData[key][4]
        end
    end
    
    for line in luci.util.execi("cat /proc/net/arp") do
        local ip, mac = line:match("^([%d%.]+)%s+%S+%s+%S+%s+([a-fA-F0-9:]+)%s+")
        if ip and mac then
            addHost(1, mac:upper(), ip, nil, nil)
        end
    end
    
    for line in luci.util.execi("cat /tmp/dhcp.leases 2>/dev/null") do
        local mac, ip = line:match("^([a-f0-9]%S+) (%S+)")
        if mac and ip then
            addHost(1, mac:upper(), ip, nil, nil)
        end
    end
    
    for line in luci.util.execi("cat /var/dhcp6.leases 2>/dev/null") do
        local mac, ip, name = line:match("^%d+ (%S+) (%S+) (%S+)")
        if mac and ip then
            addHost(1, mac:upper(), ip, nil, (name ~= "*") and name)
        end
    end
    
    cursor:foreach("dhcp", "host", function(s)
        for mac in luci.util.imatch(s.mac) do
            addHost(1, mac:upper(), s.ip, nil, s.name)
        end
    end)
    
    for _, iface in ipairs(nixio.getifaddrs()) do
        if iface.name ~= "lo" then
            ifaceData[iface.name] = ifaceData[iface.name] or {}
            
            if iface.family == "packet" then
                if iface.addr and #iface.addr == 17 then
                    ifaceData[iface.name][1] = iface.addr:upper()
                end
            elseif iface.family == "inet" then
                ifaceData[iface.name][2] = iface.addr
            elseif iface.family == "inet6" then
                ifaceData[iface.name][3] = iface.addr
            end
        end
    end
    
    for _, data in pairs(ifaceData) do
        if data[1] and (data[2] or data[3]) then
            addHost(1, data[1], data[2], data[3], data[4])
        end
    end
    
    for _, data in pairs(hostData) do
        callback(data[1], data[2], data[3], data[4])
    end
end

function net.mac_hints(callback)
    if callback then
        net.host_hints(1, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv4 or ipv6, nil, 100) or mac
            end
            if name and name ~= mac then
                callback(mac, name)
            end
        end)
    else
        local result = {}
        net.host_hints(1, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv4 or ipv6, nil, 100) or mac
            end
            if name and name ~= mac then
                result[#result + 1] = { mac, name }
            end
        end)
        return result
    end
end

function net.ipv4_hints(callback)
    if callback then
        net.host_hints(2, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv4, nil, 100) or mac
            end
            if name and name ~= ipv4 then
                callback(ipv4, name)
            end
        end)
    else
        local result = {}
        net.host_hints(2, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv4, nil, 100) or mac
            end
            if name and name ~= ipv4 then
                result[#result + 1] = { ipv4, name }
            end
        end)
        return result
    end
end

function net.ipv6_hints(callback)
    if callback then
        net.host_hints(3, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv6, nil, 100) or mac
            end
            if name and name ~= ipv6 then
                callback(ipv6, name)
            end
        end)
    else
        local result = {}
        net.host_hints(3, function(mac, ipv4, ipv6, name)
            if not name then
                name = nixio.getnameinfo(ipv6, nil, 100) or mac
            end
            if name and name ~= ipv6 then
                result[#result + 1] = { ipv6, name }
            end
        end)
        return result
    end
end

function net.conntrack(callback)
    local result = {}
    local conntrackFile = luci.util.execi("cat /proc/net/nf_conntrack 2>/dev/null")
    
    if conntrackFile then
        for line in conntrackFile do
            local entry = _parse_mixed_record(line:match("^[^%s]+%s+[^%s]+%s+(.*)"))
            if entry and entry[6] ~= "TIME_WAIT" then
                entry.layer3 = entry[1]
                entry.layer4 = entry[2]
                for i = 1, 6 do
                    entry[i] = nil
                end
                
                if callback then
                    callback(entry)
                else
                    result[#result + 1] = entry
                end
            end
        end
    else
        conntrackFile = luci.util.execi("cat /proc/net/ip_conntrack 2>/dev/null")
        if conntrackFile then
            for line in conntrackFile do
                local entry = _parse_mixed_record(line:match("^[^%s]+%s+(.*)"))
                if entry and entry[5] ~= "TIME_WAIT" then
                    entry.layer3 = "ipv4"
                    entry.layer4 = entry[1]
                    for i = 1, 5 do
                        entry[i] = nil
                    end
                    
                    if callback then
                        callback(entry)
                    else
                        result[#result + 1] = entry
                    end
                end
            end
        else
            return nil
        end
    end
    
    return result
end

function net.defaultroute()
    local defaultRoute
    
    net.routes(function(route)
        if route.dest:prefix() == 0 then
            if not defaultRoute or defaultRoute.metric > route.metric then
                defaultRoute = route
            end
        end
    end)
    
    return defaultRoute
end

function net.defaultroute6()
    local defaultRoute
    
    net.routes6(function(route)
        if route.dest:prefix() == 0 and route.device ~= "lo" then
            if not defaultRoute or defaultRoute.metric > route.metric then
                defaultRoute = route
            end
        end
    end)
    
    if not defaultRoute then
        local globalPrefix = luci.ip.IPv6("2000::/3")
        net.routes6(function(route)
            if route.dest:equal(globalPrefix) then
                if not defaultRoute or defaultRoute.metric > route.metric then
                    defaultRoute = route
                end
            end
        end)
    end
    
    return defaultRoute
end

function net.devices()
    local result = {}
    
    for _, iface in ipairs(nixio.getifaddrs()) do
        if iface.family == "packet" then
            result[#result + 1] = iface.name
        end
    end
    
    return result
end

function net.deviceinfo()
    local result = {}
    
    for _, iface in ipairs(nixio.getifaddrs()) do
        if iface.family == "packet" then
            local data = iface.data
            result[iface.name] = {
                data.rx_bytes,
                data.rx_packets,
                data.rx_errors,
                data.rx_dropped,
                0, 0, 0,
                data.multicast,
                data.tx_bytes,
                data.tx_packets,
                data.tx_errors,
                data.tx_dropped,
                0,
                data.collisions,
                0, 0
            }
        end
    end
    
    return result
end

function net.ip4mac(ip)
    local mac
    
    net.arptable(function(entry)
        if entry["IP address"] == ip then
            mac = entry["HW address"]
        end
    end)
    
    return mac
end

function net.ip4mac_ex(ip)
    local ubus = require("ubus")
    local conn = ubus.connect()
    local result = conn:call("trafficd", "ip", { ip = ip })
    
    if result and result.hw then
        return result.hw
    end
    return nil
end

function net.routes(callback)
    local result = {}
    
    for line in luci.util.execi("cat /proc/net/route") do
        local dev, dst, gw, flags, refcnt, use, metric, mask, mtu, window, irtt =
            line:match("([^%s]+)\t([A-F0-9]+)\t([A-F0-9]+)\t([A-F0-9]+)\t" ..
                       "(%d+)\t(%d+)\t(%d+)\t([A-F0-9]+)\t(%d+)\t(%d+)\t(%d+)")
        
        if dev then
            local destAddr = luci.ip.Hex(dst, 32, luci.ip.FAMILY_INET4)
            local gwAddr = luci.ip.Hex(gw, 32, luci.ip.FAMILY_INET4)
            local maskAddr = luci.ip.Hex(mask, 32, luci.ip.FAMILY_INET4)
            local destPrefix = luci.ip.Hex(dst, maskAddr:prefix(maskAddr), luci.ip.FAMILY_INET4)
            
            local route = {
                dest = destPrefix,
                gateway = destAddr,
                metric = tonumber(metric),
                refcount = tonumber(refcnt),
                usecount = tonumber(use),
                mtu = tonumber(mtu),
                window = tonumber(window),
                irtt = tonumber(irtt),
                flags = tonumber(flags, 16),
                device = dev
            }
            
            if callback then
                callback(route)
            else
                result[#result + 1] = route
            end
        end
    end
    
    return result
end

function net.routes6(callback)
    if not nixioFs.access("/proc/net/ipv6_route") then
        return nil
    end
    
    local result = {}
    
    for line in luci.util.execi("cat /proc/net/ipv6_route") do
        local dst, dstPlen, src, srcPlen, nexthop, metric, refcnt, use, flags, dev =
            line:match("([a-f0-9]+) ([a-f0-9]+) " ..
                       "([a-f0-9]+) ([a-f0-9]+) " ..
                       "([a-f0-9]+) ([a-f0-9]+) " ..
                       "([a-f0-9]+) ([a-f0-9]+) " ..
                       "([a-f0-9]+) +([^%s]+)")
        
        if dst and dstPlen and src and srcPlen and nexthop and metric and refcnt and use and flags and dev then
            local srcAddr = luci.ip.Hex(src, tonumber(srcPlen, 16), luci.ip.FAMILY_INET6, false)
            local dstAddr = luci.ip.Hex(dst, tonumber(dstPlen, 16), luci.ip.FAMILY_INET6, false)
            local nextAddr = luci.ip.Hex(nexthop, 128, luci.ip.FAMILY_INET6, false)
            
            local route = {
                source = srcAddr,
                dest = dstAddr,
                nexthop = nextAddr,
                metric = tonumber(metric, 16),
                refcount = tonumber(refcnt, 16),
                usecount = tonumber(use, 16),
                flags = tonumber(flags, 16),
                device = dev,
                metric_raw = metric
            }
            
            if callback then
                callback(route)
            else
                result[#result + 1] = route
            end
        end
    end
    
    return result
end

function net.pingtest(host)
    return os.execute("ping -c1 '" .. host:gsub("'", "") .. "' >/dev/null 2>&1")
end

process = {}

function process.info(key)
    local info = {
        uid = nixio.getuid(),
        gid = nixio.getgid()
    }
    
    if key then
        return info[key]
    end
    return info
end

function process.list()
    local result = {}
    
    local psOutput = luci.util.execi("ps w")
    if not psOutput then
        return
    end
    
    for line in psOutput do
        local pid, ppid, user, stat, vsz, mem, cpu, cmd =
            line:match("^ *(%d+) +(%d+) +(%S.-%S) +([RSDZTW][W ][<N ]) +(%d+) +(%d+%%) +(%d+%%) +(.+)")
        
        if tonumber(pid) then
            result[tonumber(pid)] = {
                PID = pid,
                PPID = ppid,
                USER = user,
                STAT = stat,
                VSZ = vsz,
                ["%MEM"] = mem,
                ["%CPU"] = cpu,
                COMMAND = cmd
            }
        end
    end
    
    return result
end

function process.setgroup(gid)
    return nixio.setgid(gid)
end

function process.setuser(uid)
    return nixio.setuid(uid)
end

process.signal = nixio.kill

user = {}

user.getuser = nixio.getpw

function user.getpasswd(username)
    if username then
        if username:lower() == "admin" then
            username = "root"
        end
    end
    
    local pwEntry
    if nixio.getsp then
        pwEntry = nixio.getsp(username)
        if not pwEntry then
            pwEntry = nixio.getpw(username)
        end
    else
        pwEntry = nixio.getpw(username)
    end
    
    local password = pwEntry and pwEntry.pwdp
    
    if password and #password >= 1 and password ~= "!" and password ~= "x" then
        return password, pwEntry
    else
        return nil, pwEntry
    end
end

function user.checkpasswd(username, password)
    if username then
        if username:lower() == "admin" then
            username = "root"
        end
    end
    
    local storedPwd, pwEntry = user.getpasswd(username)
    if pwEntry then
        return storedPwd == nil
    end
    return false
end

function user.setpasswd(username, password)
    if username then
        if username:lower() == "admin" then
            username = "root"
        end
    end
    
    if password then
        password = password:gsub("'", "'\"'\"'")
    end
    
    if username then
        username = username:gsub("'", "'\"'\"'")
    end
    
    return os.execute("(echo '" .. password .. "'; sleep 1; echo '" .. password .. "') | passwd '" .. username .. "' >/dev/null 2>&1")
end

wifi = {}

function wifi.getiwinfo(ifname)
    local hasIwinfo, iwinfo = pcall(require, "iwinfo")
    
    if ifname then
        local cursor = uci.cursor_state()
        local device, network = ifname:match("^(%w+)%.network(%d+)")
        
        if device and network then
            ifname = device
            network = tonumber(network)
            local count = 0
            
            cursor:foreach("wireless", "wifi-iface", function(s)
                if s.device == device then
                    count = count + 1
                    if count == network then
                        ifname = s.ifname or ifname
                        return false
                    end
                end
            end)
        else
            if cursor:get("wireless", ifname) == "wifi-device" then
                cursor:foreach("wireless", "wifi-iface", function(s)
                    if s.device == ifname then
                        if s.ifname then
                            ifname = s.ifname
                            return false
                        end
                    end
                end)
            end
        end
        
        local iwType = hasIwinfo and iwinfo.type(ifname)
        local iwDriver = iwType and iwinfo[iwType] or {}
        
        return setmetatable({}, {
            __index = function(self, key)
                if key == "ifname" then
                    return ifname
                else
                    if iwDriver[key] then
                        return iwDriver[key](ifname)
                    end
                end
            end
        })
    end
end

init = {}

init.dir = "/etc/init.d/"

function init.names()
    local result = {}
    
    for file in nixioFs.glob(init.dir .. "*") do
        result[#result + 1] = nixioFs.basename(file)
    end
    
    return result
end

function init.index(name)
    if nixioFs.access(init.dir .. name) then
        return call("env -i sh -c 'source %s%s enabled; exit ${START:-255}' >/dev/null" % { init.dir, name })
    end
end

local function initAction(action, name)
    if nixioFs.access(init.dir .. name) then
        return call("env -i %s%s %s >/dev/null" % { init.dir, name, action })
    end
end

function init.enabled(name)
    return initAction("enabled", name) == 0
end

function init.enable(name)
    return initAction("enable", name) == 1
end

function init.disable(name)
    return initAction("disable", name) == 0
end

function init.start(name)
    return initAction("start", name) == 0
end

function init.stop(name)
    return initAction("stop", name) == 0
end

function _parse_mixed_record(line, separator)
    separator = separator or " "
    local result = {}
    local flags = {}
    
    for _, part in ipairs(luci.util.split(line, "\n")) do
        for _, field in ipairs(luci.util.split(part, separator, nil, true)) do
            local key, sep, value = field:match("([^%s][^:=]*) *([:=]*) *\"*([^\n\"]*)\"*")
            if key then
                if sep == "" then
                    table.insert(flags, key)
                else
                    result[key] = value
                end
            end
        end
    end
    
    return result, flags
end
