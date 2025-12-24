--[[
LuCI 网络模型核心模块 (luci.model.network)

本模块是LuCI网络配置的核心，提供网络接口、协议、无线设备等的
Lua对象模型封装。通过UCI和ubus与系统交互。

主要类:
- protocol: 网络协议基类
- interface: 网络接口类
- wifidev: 无线设备类
- wifinet: 无线网络类

主要功能:
- init(): 初始化网络模型
- get_network(): 获取网络配置
- get_networks(): 获取所有网络
- add_network(): 添加网络
- del_network(): 删除网络
- get_interface(): 获取接口
- get_interfaces(): 获取所有接口
- get_wifidev(): 获取无线设备
- get_wifidevs(): 获取所有无线设备
- get_wifinet(): 获取无线网络
- get_wannet(): 获取WAN网络
- get_wandev(): 获取WAN设备

接口模式常量:
- IFACE_PATTERNS_VIRTUAL: 虚拟接口模式
- IFACE_PATTERNS_IGNORE: 忽略的接口模式
- IFACE_PATTERNS_WIRELESS: 无线接口模式

依赖模块:
- ubus: ubus通信
- nixio: 底层IO
- nixio.fs: 文件系统
- luci.ip: IP地址处理
- luci.sys: 系统信息
- luci.util: 工具函数
- luci.dispatcher: URL调度
- luci.model.uci: UCI配置
- luci.i18n: 国际化

作者: LuCI开发团队
]]--

local type = type
local next = next
local pairs = pairs
local ipairs = ipairs
local loadfile = loadfile
local table = table
local tonumber = tonumber
local tostring = tostring
local math = math

local ubus = require("ubus")
local nixio = require("nixio")
local nixio_fs = require("nixio.fs")
local luci_ip = require("luci.ip")
local luci_sys = require("luci.sys")
local util = require("luci.util")
local dispatcher = require("luci.dispatcher")
local uci_model = require("luci.model.uci")
local i18n = require("luci.i18n")

module("luci.model.network")

-- 虚拟接口模式列表
-- 匹配这些模式的接口被视为虚拟接口
IFACE_PATTERNS_VIRTUAL = {}

-- 忽略的接口模式列表
-- 匹配这些模式的接口不会显示在界面中
IFACE_PATTERNS_IGNORE = {
    "^wmaster%d",       -- 无线主控接口
    "^wifi%d",          -- WiFi接口
    "^hwsim%d",         -- 硬件模拟接口
    "^imq%d",           -- 中间队列接口
    "^ifb%d",           -- 中间功能块接口
    "^mon%.wlan%d",     -- 监控接口
    "^sit%d",           -- IPv6隧道接口
    "^gre%d",           -- GRE隧道接口
    "^lo$"              -- 回环接口
}

-- 无线接口模式列表
IFACE_PATTERNS_WIRELESS = {
    "^wlan%d",          -- 标准无线接口
    "^wl%d",            -- Broadcom无线接口
    "^ath%d",           -- Atheros无线接口
    "^%w+%.network%d"   -- 虚拟无线网络接口
}

-- 协议基类
protocol = util.class()

-- 模块私有变量
local uci_cursor = nil          -- UCI cursor
local uci_state = nil           -- UCI状态cursor
local interfaces_cache = {}     -- 接口信息缓存
local bridges_cache = {}        -- 网桥信息缓存
local switches_cache = {}       -- 交换机信息缓存
local tunnels_cache = {}        -- 隧道信息缓存
local ubus_conn = nil           -- ubus连接
local network_status = {}       -- 网络状态缓存
local device_status = {}        -- 设备状态缓存
local protocols_registry = {}   -- 注册的协议

--------------------------------------------------------------------------------
-- 内部辅助函数
--------------------------------------------------------------------------------

-- 从配置中过滤指定值
-- @param config 配置文件名
-- @param section 配置节名
-- @param option 配置选项名
-- @param value 要过滤的值
local function _filter(config, section, option, value)
    local current = uci_cursor:get(config, section, option)
    
    if current then
        local new_values = {}
        local current_type = type(current)
        
        if current_type == "string" then
            for item in util.imatch(current) do
                if item ~= value then
                    new_values[#new_values + 1] = item
                end
            end
            if #new_values > 0 then
                uci_cursor:set(config, section, option, table.concat(new_values, " "))
            else
                uci_cursor:delete(config, section, option)
            end
        elseif current_type == "table" then
            for _, item in ipairs(current) do
                if item ~= value then
                    new_values[#new_values + 1] = item
                end
            end
            if #new_values > 0 then
                uci_cursor:set(config, section, option, new_values)
            else
                uci_cursor:delete(config, section, option)
            end
        end
    end
end

-- 向配置追加值
-- @param config 配置文件名
-- @param section 配置节名
-- @param option 配置选项名
-- @param value 要追加的值
local function _append(config, section, option, value)
    local current = uci_cursor:get(config, section, option) or ""
    local current_type = type(current)
    
    if current_type == "string" then
        local new_values = {}
        for item in util.imatch(current) do
            if item ~= value then
                new_values[#new_values + 1] = item
            end
        end
        new_values[#new_values + 1] = value
        uci_cursor:set(config, section, option, table.concat(new_values, " "))
    elseif current_type == "table" then
        local new_values = {}
        for _, item in ipairs(current) do
            if item ~= value then
                new_values[#new_values + 1] = item
            end
        end
        new_values[#new_values + 1] = value
        uci_cursor:set(config, section, option, new_values)
    end
end

-- 返回第一个非空字符串
-- @param a 第一个字符串
-- @param b 第二个字符串
-- @return 第一个非空字符串
local function _stror(a, b)
    if a and #a ~= 0 then
        return a
    end
    if b and #b > 0 then
        return b
    end
    return nil
end

-- 获取UCI配置值
local function _get(config, section, option)
    return uci_cursor:get(config, section, option)
end

-- 设置UCI配置值
local function _set(config, section, option, value)
    if value ~= nil then
        if type(value) == "boolean" then
            value = value and "1" or "0"
        end
        return uci_cursor:set(config, section, option, value)
    else
        return uci_cursor:delete(config, section, option)
    end
end

-- 检查是否是无线接口
local function _wifi_iface(ifname)
    for _, pattern in ipairs(IFACE_PATTERNS_WIRELESS) do
        if ifname:match(pattern) then
            return true
        end
    end
    return false
end

-- 查找无线接口的配置节名
local function _wifi_lookup(ifname)
    -- 检查虚拟无线网络格式: device.networkN
    local device, index = ifname:match("^(%w+)%.network(%d+)$")
    if device and index then
        local found = nil
        local counter = 0
        index = tonumber(index)
        
        uci_cursor:foreach("wireless", "wifi-iface", function(section)
            if section.device == device then
                counter = counter + 1
                if counter == index then
                    found = section[".name"]
                    return false
                end
            end
        end)
        return found
    else
        -- 检查是否是无线接口
        if _wifi_iface(ifname) then
            local found = nil
            uci_cursor:foreach("wireless", "wifi-iface", function(section)
                if section.ifname == ifname then
                    found = section[".name"]
                    return false
                end
            end)
            return found
        end
    end
    return nil
end

-- 检查是否是虚拟接口
local function _iface_virtual(ifname)
    for _, pattern in ipairs(IFACE_PATTERNS_VIRTUAL) do
        if ifname:match(pattern) then
            return true
        end
    end
    return false
end

-- 检查是否应该忽略该接口
local function _iface_ignore(ifname)
    for _, pattern in ipairs(IFACE_PATTERNS_IGNORE) do
        if ifname:match(pattern) then
            return true
        end
    end
    return _iface_virtual(ifname)
end

--------------------------------------------------------------------------------
-- 模块级函数
--------------------------------------------------------------------------------

-- 初始化网络模型
-- 收集系统接口信息、网桥信息等
-- @param cursor UCI cursor实例(可选)
-- @return 模块自身
function init(cursor)
    uci_cursor = cursor or uci_cursor
    if not uci_cursor then
        uci_cursor = uci_model.cursor()
    end
    
    uci_state = uci_cursor:substate()
    
    -- 清空缓存
    interfaces_cache = {}
    bridges_cache = {}
    switches_cache = {}
    tunnels_cache = {}
    
    -- 建立ubus连接
    ubus_conn = ubus.connect()
    
    -- 清空状态缓存
    network_status = {}
    device_status = {}
    
    -- 收集接口信息
    for _, iface in ipairs(nixio.getifaddrs()) do
        local ifname = iface.name:match("[^:]+")
        local base_ifname = ifname:match("^([^%.]+)%.")
        
        -- 标记虚拟接口
        if _iface_virtual(ifname) then
            tunnels_cache[ifname] = true
        end
        
        -- 跳过虚拟和忽略的接口
        if tunnels_cache[ifname] or _iface_ignore(ifname) then
            goto continue
        end
        
        -- 初始化接口缓存
        if not interfaces_cache[ifname] then
            interfaces_cache[ifname] = {
                idx = iface.ifindex or 0,
                name = ifname,
                rawname = iface.name,
                flags = {},
                ipaddrs = {},
                ip6addrs = {}
            }
        end
        
        -- 标记VLAN接口
        if base_ifname then
            switches_cache[ifname] = true
            switches_cache[base_ifname] = true
        end
        
        -- 收集地址信息
        if iface.family == "packet" then
            interfaces_cache[ifname].flags = iface.flags
            interfaces_cache[ifname].stats = iface.data
            interfaces_cache[ifname].macaddr = iface.addr
        elseif iface.family == "inet" then
            local addr = luci_ip.IPv4(iface.addr, iface.netmask)
            interfaces_cache[ifname].ipaddrs[#interfaces_cache[ifname].ipaddrs + 1] = addr
        elseif iface.family == "inet6" then
            local addr = luci_ip.IPv6(iface.addr, iface.netmask)
            interfaces_cache[ifname].ip6addrs[#interfaces_cache[ifname].ip6addrs + 1] = addr
        end
        
        ::continue::
    end
    
    -- 收集网桥信息
    local bridge_info = nil
    for line in util.execi("brctl show 2>/dev/null") do
        if not line:match("STP") then
            local fields = util.split(line, "%s+", nil, true)
            if #fields == 4 then
                bridge_info = {
                    name = fields[1],
                    id = fields[2],
                    stp = fields[3] == "yes",
                    ifnames = { interfaces_cache[fields[4]] }
                }
                if bridge_info.ifnames[1] then
                    bridge_info.ifnames[1].bridge = bridge_info
                end
                bridges_cache[fields[1]] = bridge_info
            elseif bridge_info then
                bridge_info.ifnames[#bridge_info.ifnames + 1] = interfaces_cache[fields[2]]
                if bridge_info.ifnames[#bridge_info.ifnames] then
                    bridge_info.ifnames[#bridge_info.ifnames].bridge = bridge_info
                end
            end
        end
    end
    
    return _M
end

-- 保存配置
function save(...)
    uci_cursor:save(...)
    uci_cursor:load(...)
end

-- 提交配置
function commit(...)
    uci_cursor:commit(...)
    uci_cursor:load(...)
end

-- 获取接口名称
-- @param iface 接口对象或字符串
-- @return 接口名称字符串
function ifnameof(self, iface)
    if util.instanceof(iface, interface) then
        return iface:name()
    elseif util.instanceof(iface, protocol) then
        return iface:ifname()
    elseif type(iface) == "string" then
        return iface:match("^[^:]+")
    end
end

-- 获取指定协议
-- @param proto_name 协议名称
-- @param netname 网络名称
-- @return 协议实例
function get_protocol(self, proto_name, netname)
    local proto_class = protocols_registry[proto_name]
    if proto_class then
        return proto_class(netname or "__dummy__")
    end
end

-- 获取所有已注册的协议
-- @return 协议实例数组
function get_protocols(self)
    local result = {}
    for _, proto_class in pairs(protocols_registry) do
        result[#result + 1] = proto_class("__dummy__")
    end
    return result
end

-- 注册新协议
-- @param proto_name 协议名称
-- @return 协议类
function register_protocol(self, proto_name)
    local proto_class = util.class(protocol)
    
    function proto_class:__init__(sid)
        self.sid = sid
    end
    
    function proto_class:proto()
        return proto_name
    end
    
    protocols_registry[#protocols_registry + 1] = proto_class
    protocols_registry[proto_name] = proto_class
    
    return proto_class
end

-- 注册虚拟接口模式
-- @param pattern 正则模式
function register_pattern_virtual(self, pattern)
    IFACE_PATTERNS_VIRTUAL[#IFACE_PATTERNS_VIRTUAL + 1] = pattern
end

-- 检查是否支持IPv6
function has_ipv6(self)
    return nixio_fs.access("/proc/net/ipv6_route")
end

-- 添加网络
-- @param name 网络名称
-- @param options 配置选项(可选)
-- @return network实例或nil
function add_network(self, name, options)
    local existing = self:get_network(name)
    
    if name and #name > 0 and name:match("^[a-zA-Z0-9_]+$") and not existing then
        local sid = uci_cursor:section("network", "interface", name, options or {})
        if sid then
            return network(name)
        end
    elseif existing then
        if existing:is_empty() then
            if options then
                for key, value in pairs(options) do
                    existing:set(key, value)
                end
            end
            return existing
        end
    end
    return nil
end

-- 获取网络
-- @param name 网络名称
-- @return network实例或nil
function get_network(self, name)
    if name then
        local section_type = uci_cursor:get("network", name)
        if section_type == "interface" then
            return network(name)
        end
    end
    return nil
end

-- 获取所有网络
-- @return network实例数组
function get_networks(self)
    local result = {}
    local networks_map = {}
    
    uci_cursor:foreach("network", "interface", function(section)
        networks_map[section[".name"]] = network(section[".name"])
    end)
    
    -- 按名称排序
    local sorted = {}
    for name in pairs(networks_map) do
        sorted[#sorted + 1] = name
    end
    table.sort(sorted)
    
    for _, name in ipairs(sorted) do
        result[#result + 1] = networks_map[name]
    end
    
    return result
end

-- 删除网络
-- @param name 网络名称
-- @return 成功返回true
function del_network(self, name)
    local deleted = uci_cursor:delete("network", name)
    
    if deleted then
        -- 删除相关的别名
        uci_cursor:delete_all("network", "alias", function(section)
            return section.interface == name
        end)
        
        -- 删除相关的路由
        uci_cursor:delete_all("network", "route", function(section)
            return section.interface == name
        end)
        
        uci_cursor:delete_all("network", "route6", function(section)
            return section.interface == name
        end)
        
        -- 从无线接口中移除网络引用
        uci_cursor:foreach("wireless", "wifi-iface", function(section)
            local networks = {}
            for net in util.imatch(section.network) do
                if net ~= name then
                    networks[#networks + 1] = net
                end
            end
            if #networks > 0 then
                uci_cursor:set("wireless", section[".name"], "network", table.concat(networks, " "))
            else
                uci_cursor:delete("wireless", section[".name"], "network")
            end
        end)
    end
    
    return deleted
end

-- 获取接口
-- @param ifname 接口名称
-- @return interface实例或nil
function get_interface(self, ifname)
    if interfaces_cache[ifname] or _wifi_iface(ifname) then
        return interface(ifname)
    end
    
    -- 查找无线接口
    local wifi_count = {}
    local found = nil
    
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device then
            wifi_count[section.device] = (wifi_count[section.device] or 0) + 1
            
            if section[".name"] == ifname then
                local netid = "%s.network%d" % { section.device, wifi_count[section.device] }
                found = interface(netid)
                return false
            end
        end
    end)
    
    return found
end

-- 获取所有接口
-- @return interface实例数组
function get_interfaces(self)
    local result = {}
    local seen = {}
    local wifi_count = {}
    
    -- 收集物理接口
    for ifname, _ in pairs(interfaces_cache) do
        if not seen[ifname] then
            seen[ifname] = interface(ifname)
        end
    end
    
    -- 收集无线接口
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device then
            wifi_count[section.device] = (wifi_count[section.device] or 0) + 1
            local netid = "%s.network%d" % { section.device, wifi_count[section.device] }
            seen[netid] = interface(netid)
        end
    end)
    
    -- 排序
    local sorted = {}
    for name in pairs(seen) do
        sorted[#sorted + 1] = name
    end
    table.sort(sorted)
    
    for _, name in ipairs(sorted) do
        result[#result + 1] = seen[name]
    end
    
    return result
end

-- 检查是否应该忽略接口
function ignore_interface(self, ifname)
    return _iface_ignore(ifname)
end

-- 获取无线设备
-- @param devname 设备名称
-- @return wifidev实例或nil
function get_wifidev(self, devname)
    local section_type = uci_cursor:get("wireless", devname)
    if section_type == "wifi-device" then
        return wifidev(devname)
    end
    return nil
end

-- 获取所有无线设备
-- @return wifidev实例数组
function get_wifidevs(self)
    local result = {}
    local devices = {}
    
    uci_cursor:foreach("wireless", "wifi-device", function(section)
        devices[#devices + 1] = section[".name"]
    end)
    
    for _, devname in ipairs(devices) do
        result[#result + 1] = wifidev(devname)
    end
    
    return result
end

-- 获取无线网络
-- @param netname 网络名称或接口名
-- @return wifinet实例或nil
function get_wifinet(self, netname)
    if netname == nil then
        return nil
    end
    
    local sid = _wifi_lookup(netname)
    if sid then
        return wifinet(sid)
    end
    return nil
end

-- 添加无线网络
-- @param options 配置选项
-- @return wifinet实例或nil
function add_wifinet(self, options)
    if type(options) == "table" then
        if options.device then
            local section_type = uci_cursor:get("wireless", options.device)
            if section_type == "wifi-device" then
                local sid = uci_cursor:section("wireless", "wifi-iface", nil, options)
                return wifinet(sid)
            end
        end
    end
    return nil
end

-- 删除无线网络
-- @param netname 网络名称
-- @return 成功返回true
function del_wifinet(self, netname)
    local sid = _wifi_lookup(netname)
    if sid then
        uci_cursor:delete("wireless", sid)
        return true
    end
    return false
end

-- 根据路由获取网络状态
-- @param target 目标地址
-- @param mask 掩码
-- @return 网络名称和状态
function get_status_by_route(self, target, mask)
    for _, obj in pairs(ubus_conn:objects()) do
        local netname = obj:match("^network%.interface%.(.+)")
        if netname then
            local status = ubus_conn:call(obj, "status", {})
            if status and status.route then
                for _, route in ipairs(status.route) do
                    if route.target == target and route.mask == mask then
                        return netname, status
                    end
                end
            end
        end
    end
end

-- 根据地址获取网络状态
function get_status_by_address(self, address)
    for _, obj in pairs(ubus_conn:objects()) do
        local netname = obj:match("^network%.interface%.(.+)")
        if netname then
            local status = ubus_conn:call(obj, "status", {})
            if status then
                if status["ipv4-address"] then
                    for _, addr in ipairs(status["ipv4-address"]) do
                        if addr.address == address then
                            return netname, status
                        end
                    end
                end
                if status["ipv6-address"] then
                    for _, addr in ipairs(status["ipv6-address"]) do
                        if addr.address == address then
                            return netname, status
                        end
                    end
                end
            end
        end
    end
end

-- 获取WAN网络
function get_wannet(self)
    local name = self:get_status_by_route("0.0.0.0", 0)
    if name then
        return network(name)
    end
    return nil
end

-- 获取WAN设备
function get_wandev(self)
    local name, status = self:get_status_by_route("0.0.0.0", 0)
    if status then
        return interface(status.l3_device or status.device)
    end
    return nil
end

-- 获取WAN6网络
function get_wan6net(self)
    local name = self:get_status_by_route("::", 0)
    if name then
        return network(name)
    end
    return nil
end

-- 获取WAN6设备
function get_wan6dev(self)
    local name, status = self:get_status_by_route("::", 0)
    if status then
        return interface(status.l3_device or status.device)
    end
    return nil
end

-- 创建network实例(内部函数)
-- @param name 网络名称
-- @param proto_name 协议名称(可选)
-- @return protocol派生类实例
local function network(name, proto_name)
    if name then
        proto_name = proto_name or uci_cursor:get("network", name, "proto")
        local proto_class = protocols_registry[proto_name] or protocol
        return proto_class(name)
    end
end

--------------------------------------------------------------------------------
-- protocol类: 网络协议基类
--------------------------------------------------------------------------------

function protocol:__init__(sid)
    self.sid = sid
end

-- 获取配置值(内部)
function protocol:_get(option)
    local value = uci_cursor:get("network", self.sid, option)
    if type(value) == "table" then
        return table.concat(value, " ")
    end
    return value or ""
end

-- 获取ubus状态
function protocol:_ubus(key)
    if not network_status[self.sid] then
        network_status[self.sid] = ubus_conn:call(
            "network.interface.%s" % self.sid,
            "status",
            {}
        )
    end
    
    if network_status[self.sid] and key then
        return network_status[self.sid][key]
    end
    return network_status[self.sid]
end

-- 获取配置值
function protocol:get(option)
    return _get("network", self.sid, option)
end

-- 设置配置值
function protocol:set(option, value)
    return _set("network", self.sid, option, value)
end

-- 获取接口名称
function protocol:ifname()
    if self:is_floating() then
        return self:_ubus("l3_device")
    else
        return self:_ubus("device")
    end
end

-- 获取协议名称
function protocol:proto()
    return "none"
end

-- 获取协议的国际化名称
function protocol:get_i18n()
    local proto = self:proto()
    if proto == "none" then
        return i18n.translate("Unmanaged")
    elseif proto == "static" then
        return i18n.translate("Static address")
    elseif proto == "dhcp" then
        return i18n.translate("DHCP client")
    else
        return i18n.translate("Unknown")
    end
end

-- 获取接口类型
function protocol:type()
    return self:_get("type")
end

-- 获取网络名称
function protocol:name()
    return self.sid
end

-- 获取运行时间
function protocol:uptime()
    return self:_ubus("uptime") or 0
end

-- 获取DHCP租约剩余时间
function protocol:expires()
    local acquired = tonumber(uci_cursor:get("network", self.sid, "lease_acquired"))
    local lifetime = tonumber(uci_cursor:get("network", self.sid, "lease_lifetime"))
    
    if acquired and lifetime then
        local uptime = luci_sys.sysinfo().uptime
        local elapsed = uptime - acquired
        local remaining = lifetime - elapsed
        return remaining > 0 and remaining or 0
    end
    return -1
end

-- 获取路由度量值
function protocol:metric()
    return tonumber(uci_cursor:get("network", self.sid, "metric")) or 0
end

-- 获取IPv4地址
function protocol:ipaddr()
    local addrs = self:_ubus("ipv4-address")
    if addrs and #addrs > 0 then
        return addrs[1]
    end
    return nil
end

-- 获取子网掩码
function protocol:netmask()
    local addrs = self:_ubus("ipv4-address")
    if addrs and #addrs > 0 then
        local mask_cidr = addrs[1].mask
        local ip = luci_ip.IPv4("0.0.0.0/%d" % mask_cidr)
        return ip:mask():string()
    end
    return nil
end

-- 获取网关地址
function protocol:gwaddr()
    local routes = self:_ubus("route")
    if routes then
        for _, route in ipairs(routes) do
            if route.target == "0.0.0.0" and route.mask == 0 then
                return route.nexthop
            end
        end
    end
    return nil
end

-- 获取DNS服务器列表
function protocol:dnsaddrs()
    local result = {}
    local servers = self:_ubus("dns-server")
    if servers then
        for _, server in ipairs(servers) do
            if not server:match(":") then
                result[#result + 1] = server
            end
        end
    end
    return result
end

-- 获取IPv6地址
function protocol:ip6addr()
    local addrs = self:_ubus("ipv6-address")
    if addrs and #addrs > 0 then
        return "%s/%d" % { addrs[1].address, addrs[1].mask }
    end
    
    local prefix = self:_ubus("ipv6-prefix-assignment")
    if prefix and #prefix > 0 then
        return "%s/%d" % { prefix[1].address, prefix[1].mask }
    end
    return nil
end

-- 获取IPv6网关
function protocol:gw6addr()
    local routes = self:_ubus("route")
    if routes then
        for _, route in ipairs(routes) do
            if route.target == "::" and route.mask == 0 then
                local ip = luci_ip.IPv6(route.nexthop)
                return ip:string()
            end
        end
    end
    return nil
end

-- 获取IPv6 DNS服务器列表
function protocol:dns6addrs()
    local result = {}
    local servers = self:_ubus("dns-server")
    if servers then
        for _, server in ipairs(servers) do
            if server:match(":") then
                result[#result + 1] = server
            end
        end
    end
    return result
end

-- 检查是否是网桥
function protocol:is_bridge()
    return not self:is_virtual()
end

-- 获取所需的软件包
function protocol:opkg_package()
    return nil
end

-- 检查协议是否已安装
function protocol:is_installed()
    return true
end

-- 检查是否是虚拟协议
function protocol:is_virtual()
    return false
end

-- 检查是否是浮动协议
function protocol:is_floating()
    return false
end

-- 检查网络是否为空(无接口)
function protocol:is_empty()
    if self:is_floating() then
        return false
    end
    
    local has_iface = true
    local ifname = self:_get("ifname") or ""
    
    if ifname:match("%S+") then
        has_iface = false
    end
    
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        for net in util.imatch(section.network) do
            if net == self.sid then
                has_iface = false
                return false
            end
        end
    end)
    
    return has_iface
end

-- 添加接口到网络
function protocol:add_interface(iface)
    local ifname = _M:ifnameof(iface)
    
    if ifname then
        if not self:is_floating() then
            local wifi_sid = _wifi_lookup(ifname)
            if wifi_sid then
                _append("wireless", wifi_sid, "network", self.sid)
            else
                _append("network", self.sid, "ifname", ifname)
            end
        end
    end
end

-- 从网络删除接口
function protocol:del_interface(iface)
    local ifname = _M:ifnameof(iface)
    
    if ifname then
        if not self:is_floating() then
            local wifi_sid = _wifi_lookup(ifname)
            if wifi_sid then
                _filter("wireless", wifi_sid, "network", self.sid)
            end
            _filter("network", self.sid, "ifname", ifname)
        end
    end
end

-- 获取网络的主接口
function protocol:get_interface()
    if self:is_virtual() then
        tunnels_cache[self:proto() .. "-" .. self.sid] = true
        return interface(self:proto() .. "-" .. self.sid, self)
    elseif self:is_bridge() then
        tunnels_cache["br-" .. self.sid] = true
        return interface("br-" .. self.sid, self)
    else
        -- 返回第一个物理接口
        for ifname in util.imatch(self:_get("ifname")) do
            ifname = ifname:match("^[^:/]+")
            if ifname then
                return interface(ifname, self)
            end
        end
        
        -- 查找无线接口
        local wifi_count = {}
        local found = nil
        
        uci_cursor:foreach("wireless", "wifi-iface", function(section)
            if section.device then
                wifi_count[section.device] = (wifi_count[section.device] or 0) + 1
                
                for net in util.imatch(section.network) do
                    if net == self.sid then
                        local netid = "%s.network%d" % { section.device, wifi_count[section.device] }
                        found = netid
                        return false
                    end
                end
            end
        end)
        
        if found then
            return interface(found, self)
        end
    end
    return nil
end

-- 获取网络的所有接口
function protocol:get_interfaces()
    if not self:is_bridge() and not (self:is_virtual() and not self:is_floating()) then
        return nil
    end
    
    local result = {}
    local seen = {}
    local wifi_count = {}
    
    -- 收集物理接口
    for ifname in util.imatch(self:_get("ifname")) do
        ifname = ifname:match("^[^:/]+")
        if ifname and not seen[ifname] then
            seen[ifname] = interface(ifname, self)
        end
    end
    
    -- 收集无线接口
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device then
            wifi_count[section.device] = (wifi_count[section.device] or 0) + 1
            
            for net in util.imatch(section.network) do
                if net == self.sid then
                    local netid = "%s.network%d" % { section.device, wifi_count[section.device] }
                    seen[netid] = interface(netid, self)
                end
            end
        end
    end)
    
    -- 排序
    local sorted = {}
    for name in pairs(seen) do
        sorted[#sorted + 1] = name
    end
    table.sort(sorted)
    
    for _, name in ipairs(sorted) do
        result[#result + 1] = seen[name]
    end
    
    return result
end

-- 检查网络是否包含指定接口
function protocol:contains_interface(iface)
    local ifname = _M:ifnameof(iface)
    
    if not ifname then
        return false
    end
    
    if self:is_virtual() then
        return (self:proto() .. "-" .. self.sid) == ifname
    elseif self:is_bridge() then
        return ("br-" .. self.sid) == ifname
    else
        -- 检查物理接口
        for name in util.imatch(self:_get("ifname")) do
            name = name:match("[^:]+")
            if name == ifname then
                return true
            end
        end
        
        -- 检查无线接口
        local wifi_sid = _wifi_lookup(ifname)
        if wifi_sid then
            for net in util.imatch(uci_cursor:get("wireless", wifi_sid, "network")) do
                if net == self.sid then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 获取管理链接
function protocol:adminlink()
    return dispatcher.build_url("admin", "network", "network", self.sid)
end

-- 获取配置选项值
function protocol:get_option_value(option)
    return self:_get(option)
end

-- 获取网络状态
function protocol:status()
    local state = uci_model.cursor_state()
    local data = state:get_all("network", self.sid)
    
    local proto = data.proto
    local ifname = data.ifname
    local device = data.device
    local up = tonumber(data.up)
    
    if proto == "pppoe" then
        if device == nil then
            return "down"
        end
        if up == nil then
            return "connection"
        end
        if up == 1 then
            return "up"
        end
    elseif proto == "3g" then
        if device ~= ifname and up == nil then
            return "down"
        end
        if device == ifname and up == nil then
            return "connection"
        end
        if up == 1 then
            return "up"
        end
    elseif proto == "static" then
        if up == nil then
            return "down"
        end
        if up == 1 then
            return "up"
        end
    elseif proto == "dhcp" then
        if up == nil then
            return "down"
        end
        if up == 1 then
            return "up"
        end
    end
    
    return "unknown"
end

--------------------------------------------------------------------------------
-- interface类: 网络接口
--------------------------------------------------------------------------------

interface = util.class()

function interface:__init__(ifname, network_obj)
    local wifi_sid = _wifi_lookup(ifname)
    
    if wifi_sid then
        self.wif = wifinet(wifi_sid)
        self.ifname = uci_cursor:get("wireless", wifi_sid, "ifname")
    end
    
    self.ifname = self.ifname or ifname
    self.dev = interfaces_cache[self.ifname]
    self.network = network_obj
end

-- 获取ubus状态
function interface:_ubus(key)
    if not device_status[self.ifname] then
        device_status[self.ifname] = ubus_conn:call(
            "network.device",
            "status",
            { name = self.ifname }
        )
    end
    
    if device_status[self.ifname] and key then
        return device_status[self.ifname][key]
    end
    return device_status[self.ifname]
end

-- 获取接口名称
function interface:name()
    if self.wif then
        return self.wif:ifname() or self.ifname
    end
    return self.ifname
end

-- 获取MAC地址
function interface:mac()
    local mac = self:_ubus("macaddr") or "00:00:00:00:00:00"
    return mac:upper()
end

-- 获取IPv4地址列表
function interface:ipaddrs()
    return self.dev and self.dev.ipaddrs or {}
end

-- 获取IPv6地址列表
function interface:ip6addrs()
    return self.dev and self.dev.ip6addrs or {}
end

-- 获取接口类型
function interface:type()
    if self.wif or _wifi_iface(self.ifname) then
        return "wifi"
    elseif bridges_cache[self.ifname] then
        return "bridge"
    elseif tunnels_cache[self.ifname] then
        return "tunnel"
    elseif self.ifname:match("%.") then
        return "vlan"
    elseif switches_cache[self.ifname] then
        return "switch"
    else
        return "ethernet"
    end
end

-- 获取简短名称
function interface:shortname()
    if self.wif then
        local mode = self.wif:active_mode()
        local ssid = self.wif:active_ssid() or self.wif:active_bssid()
        return '%s %q' % { mode, ssid }
    else
        return self.ifname
    end
end

-- 获取国际化名称
function interface:get_i18n()
    if self.wif then
        local mode = self.wif:active_mode()
        local ssid = self.wif:active_ssid() or self.wif:active_bssid()
        return "%s: %s %q" % { i18n.translate("Wireless Network"), mode, ssid }
    else
        return "%s: %q" % { self:get_type_i18n(), self:name() }
    end
end

-- 获取类型的国际化名称
function interface:get_type_i18n()
    local itype = self:type()
    if itype == "wifi" then
        return i18n.translate("Wireless Adapter")
    elseif itype == "bridge" then
        return i18n.translate("Bridge")
    elseif itype == "switch" then
        return i18n.translate("Ethernet Switch")
    elseif itype == "vlan" then
        return i18n.translate("VLAN Interface")
    elseif itype == "tunnel" then
        return i18n.translate("Tunnel Interface")
    else
        return i18n.translate("Ethernet Adapter")
    end
end

-- 获取管理链接
function interface:adminlink()
    if self.wif then
        return self.wif:adminlink()
    end
    return nil
end

-- 获取网桥端口
function interface:ports()
    local members = self:_ubus("bridge-members")
    if members then
        local result = {}
        for _, member in ipairs(members) do
            result[#result + 1] = interface(member)
        end
        return result
    end
    return nil
end

-- 获取网桥ID
function interface:bridge_id()
    if self.br then
        return self.br.id
    end
    return nil
end

-- 获取网桥STP状态
function interface:bridge_stp()
    if self.br then
        return self.br.stp
    end
    return false
end

-- 检查接口是否启用
function interface:is_up()
    if self.wif then
        return self.wif:is_up()
    else
        return self:_ubus("up") or false
    end
end

-- 检查是否是网桥
function interface:is_bridge()
    return self:type() == "bridge"
end

-- 检查是否是网桥端口
function interface:is_bridgeport()
    return self.dev and self.dev.bridge and true or false
end

-- 获取发送字节数
function interface:tx_bytes()
    local stats = self:_ubus("statistics")
    return stats and stats.tx_bytes or 0
end

-- 获取接收字节数
function interface:rx_bytes()
    local stats = self:_ubus("statistics")
    return stats and stats.rx_bytes or 0
end

-- 获取发送包数
function interface:tx_packets()
    local stats = self:_ubus("statistics")
    return stats and stats.tx_packets or 0
end

-- 获取接收包数
function interface:rx_packets()
    local stats = self:_ubus("statistics")
    return stats and stats.rx_packets or 0
end

-- 获取关联的网络
function interface:get_network()
    return self:get_networks()[1]
end

-- 获取所有关联的网络
function interface:get_networks()
    if not self.networks then
        self.networks = {}
        
        for _, net in ipairs(_M:get_networks()) do
            if net:contains_interface(self.ifname) or net:ifname() == self.ifname then
                self.networks[#self.networks + 1] = net
            end
        end
        
        table.sort(self.networks, function(a, b)
            return a:name() < b:name()
        end)
    end
    return self.networks
end

-- 获取关联的无线网络
function interface:get_wifinet()
    return self.wif
end

--------------------------------------------------------------------------------
-- wifidev类: 无线设备
--------------------------------------------------------------------------------

wifidev = util.class()

function wifidev:__init__(devname)
    self.sid = devname
    
    if devname then
        self.iwinfo = luci_sys.wifi.getiwinfo(devname) or {}
    else
        self.iwinfo = {}
    end
end

-- 获取配置值
function wifidev:get(option)
    return _get("wireless", self.sid, option)
end

-- 设置配置值
function wifidev:set(option, value)
    return _set("wireless", self.sid, option, value)
end

-- 获取设备名称
function wifidev:name()
    return self.sid
end

-- 获取支持的硬件模式
function wifidev:hwmodes()
    local modes = self.iwinfo.hwmodelist
    if modes and next(modes) then
        return modes
    else
        return { b = true, g = true }
    end
end

-- 获取国际化名称
function wifidev:get_i18n()
    local vendor = "Generic"
    
    if self.iwinfo.type == "wl" then
        vendor = "Broadcom"
    elseif self.iwinfo.type == "madwifi" then
        vendor = "Atheros"
    end
    
    local modes = ""
    local hwmodes = self:hwmodes()
    
    if hwmodes.a then modes = modes .. "a" end
    if hwmodes.b then modes = modes .. "b" end
    if hwmodes.g then modes = modes .. "g" end
    if hwmodes.n then modes = modes .. "n" end
    
    return "%s 802.11%s Wireless Controller (%s)" % { vendor, modes, self:name() }
end

-- 检查设备是否启用
function wifidev:is_up()
    local up = false
    
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device == self.sid then
            if section.up == "1" then
                up = true
                return false
            end
        end
    end)
    
    return up
end

-- 获取无线网络
function wifidev:get_wifinet(netname)
    local section_type = uci_cursor:get("wireless", netname)
    if section_type == "wifi-iface" then
        return wifinet(netname)
    else
        local sid = _wifi_lookup(netname)
        if sid then
            return wifinet(sid)
        end
    end
    return nil
end

-- 获取所有无线网络
function wifidev:get_wifinets()
    local result = {}
    
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device == self.sid then
            result[#result + 1] = wifinet(section[".name"])
        end
    end)
    
    return result
end

-- 添加无线网络
function wifidev:add_wifinet(options)
    if not options then
        options = {}
    end
    
    options.device = self.sid
    
    local sid = uci_cursor:section("wireless", "wifi-iface", nil, options)
    if sid then
        return wifinet(sid, options)
    end
    return nil
end

-- 添加命名无线网络
function wifidev:add_wifinet_s(name, options)
    if not options then
        options = {}
    end
    
    options.device = self.sid
    
    local sid = uci_cursor:section("wireless", "wifi-iface", name, options)
    if sid then
        return wifinet(sid, options)
    end
    return nil
end

-- 删除无线网络
function wifidev:del_wifinet(net)
    local sid
    
    if util.instanceof(net, wifinet) then
        sid = net.sid
    else
        local section_type = uci_cursor:get("wireless", net)
        if section_type ~= "wifi-iface" then
            sid = _wifi_lookup(net)
        else
            sid = net
        end
    end
    
    if sid then
        local device = uci_cursor:get("wireless", sid, "device")
        if device == self.sid then
            uci_cursor:delete("wireless", sid)
            return true
        end
    end
    
    return false
end

--------------------------------------------------------------------------------
-- wifinet类: 无线网络
--------------------------------------------------------------------------------

wifinet = util.class()

function wifinet:__init__(sid, data)
    self.sid = sid
    
    local wifi_count = {}
    local netid = nil
    
    uci_cursor:foreach("wireless", "wifi-iface", function(section)
        if section.device then
            wifi_count[section.device] = (wifi_count[section.device] or 0) + 1
            
            if section[".name"] == self.sid then
                netid = "%s.network%d" % { section.device, wifi_count[section.device] }
                return false
            end
        end
    end)
    
    local ifname = uci_cursor:get("wireless", self.sid, "ifname") or netid
    
    self.netid = netid
    self.wdev = ifname
    
    if ifname then
        self.iwinfo = luci_sys.wifi.getiwinfo(ifname) or {}
    else
        self.iwinfo = {}
    end
    
    self.iwdata = data or uci_cursor:get_all("wireless", self.sid) or uci_state:get_all("wireless", self.sid) or {}
end

-- 获取配置值
function wifinet:get(option)
    return _get("wireless", self.sid, option)
end

-- 设置配置值
function wifinet:set(option, value)
    return _set("wireless", self.sid, option, value)
end

-- 设置列表值
function wifinet:set_list(option, value)
    if value then
        if type(value) == "table" and #value > 0 then
            return uci_cursor:set_list("wireless", self.sid, option, value)
        end
    else
        return uci_cursor:delete("wireless", self.sid, option)
    end
end

-- 获取模式
function wifinet:mode()
    return uci_cursor:get("wireless", self.sid, "mode") or "ap"
end

-- 获取禁用状态
function wifinet:disabled()
    return uci_cursor:get("wireless", self.sid, "disabled")
end

-- 获取SSID
function wifinet:ssid()
    return uci_cursor:get("wireless", self.sid, "ssid")
end

-- 获取BSSID
function wifinet:bssid()
    return uci_cursor:get("wireless", self.sid, "bssid")
end

-- 获取关联的网络
function wifinet:network()
    return uci_cursor:get("wireless", self.sid, "network")
end

-- 获取网络ID
function wifinet:id()
    return self.netid
end

-- 获取配置节名
function wifinet:name()
    return self.sid
end

-- 获取接口名称
function wifinet:ifname()
    local ifname = self.iwinfo.ifname
    
    if ifname then
        if not ifname:match("^wifi%d") and not ifname:match("^radio%d") then
            return ifname
        end
    end
    
    return self.wdev
end

-- 获取无线设备
function wifinet:get_device()
    if self.iwdata.device then
        return wifidev(self.iwdata.device)
    end
    return nil
end

-- 检查是否启用
function wifinet:is_up()
    return self.iwdata.up == "1"
end

-- 获取当前模式
function wifinet:active_mode()
    local mode = _stror(self.iwinfo.mode, self.iwdata.mode) or "ap"
    
    if mode == "ap" then
        return "Master"
    elseif mode == "sta" then
        return "Client"
    elseif mode == "adhoc" then
        return "Ad-Hoc"
    elseif mode == "mesh" then
        return "Mesh"
    elseif mode == "monitor" then
        return "Monitor"
    end
    
    return mode
end

-- 获取当前模式的国际化名称
function wifinet:active_mode_i18n()
    return i18n.translate(self:active_mode())
end

-- 获取当前SSID
function wifinet:active_ssid()
    return _stror(self.iwinfo.ssid, self.iwdata.ssid)
end

-- 获取当前BSSID
function wifinet:active_bssid()
    return _stror(self.iwinfo.bssid, self.iwdata.bssid) or "00:00:00:00:00:00"
end

-- 获取当前加密方式
function wifinet:active_encryption()
    local enc = self.iwinfo and self.iwinfo.encryption
    if enc and enc.description then
        return enc.description
    end
    return "-"
end

-- 获取关联列表
function wifinet:assoclist()
    return self.iwinfo.assoclist or {}
end

-- 获取频率
function wifinet:frequency()
    local freq = self.iwinfo.frequency
    if freq and freq > 0 then
        return "%.03f" % (freq / 1000)
    end
    return nil
end

-- 获取比特率
function wifinet:bitrate()
    local rate = self.iwinfo.bitrate
    if rate and rate > 0 then
        return rate / 1000
    end
    return nil
end

-- 获取信道
function wifinet:channel()
    local channel = self.iwinfo.channel
    if not channel then
        channel = tonumber(uci_cursor:get("wireless", self.iwdata.device, "channel"))
    end
    return channel
end

-- 获取配置的信道
function wifinet:confchannel()
    return tonumber(uci_cursor:get("wireless", self.iwdata.device, "channel"))
end

-- 获取带宽
function wifinet:bw()
    local bw = self.iwinfo.bw
    if not bw then
        bw = tonumber(uci_cursor:get("wireless", self.iwdata.device, "bw"))
    end
    return bw
end

-- 获取配置的带宽
function wifinet:confbw()
    return tonumber(uci_cursor:get("wireless", self.iwdata.device, "bw"))
end

-- 获取发射功率
function wifinet:txpwr()
    local txpwr = self.iwinfo.txpwr
    if not txpwr then
        txpwr = tonumber(uci_cursor:get("wireless", self.iwdata.device, "txpwr"))
    end
    return txpwr
end

-- 获取信号强度
function wifinet:signal()
    return self.iwinfo.signal or 0
end

-- 获取噪声
function wifinet:noise()
    return self.iwinfo.noise or 0
end

-- 获取国家代码
function wifinet:country()
    return self.iwinfo.country or "00"
end

-- 获取扫描列表
function wifinet:scanlist()
    return self.iwinfo.scanlist or {}
end

-- 获取发射功率(含偏移)
function wifinet:txpower()
    local power = self.iwinfo.txpower or 0
    return power + self:txpower_offset()
end

-- 获取发射功率偏移
function wifinet:txpower_offset()
    return self.iwinfo.txpower_offset or 0
end

-- 获取信号等级
function wifinet:signal_level(signal, noise)
    if self:active_bssid() ~= "00:00:00:00:00:00" then
        signal = signal or self:signal()
        noise = noise or self:noise()
        
        if signal < 0 and noise < 0 then
            local snr = -1 * (noise - signal)
            return math.floor(snr / 5)
        else
            return 0
        end
    else
        return -1
    end
end

-- 获取信号百分比
function wifinet:signal_percent()
    local quality = self.iwinfo.quality or 0
    local quality_max = self.iwinfo.quality_max or 0
    
    if quality > 0 and quality_max > 0 then
        return math.floor((100 / quality_max) * quality)
    else
        return 0
    end
end

-- 获取简短名称
function wifinet:shortname()
    local mode = i18n.translate(self:active_mode())
    local ssid = self:active_ssid() or self:active_bssid()
    return "%s %q" % { mode, ssid }
end

-- 获取国际化名称
function wifinet:get_i18n()
    local mode = i18n.translate(self:active_mode())
    local ssid = self:active_ssid() or self:active_bssid()
    local ifname = self:ifname()
    return "%s: %s %q (%s)" % { i18n.translate("Wireless Network"), mode, ssid, ifname }
end

-- 获取管理链接
function wifinet:adminlink()
    return dispatcher.build_url("admin", "network", "wireless", self.netid)
end

-- 获取关联的网络
function wifinet:get_network()
    return self:get_networks()[1]
end

-- 获取所有关联的网络
function wifinet:get_networks()
    local result = {}
    
    for net in util.imatch(self:network()) do
        local section_type = uci_cursor:get("network", net)
        if section_type == "interface" then
            result[#result + 1] = network(net)
        end
    end
    
    table.sort(result, function(a, b)
        return a:name() < b:name()
    end)
    
    return result
end

-- 获取接口对象
function wifinet:get_interface()
    return interface(self:ifname())
end

--------------------------------------------------------------------------------
-- 注册默认协议
--------------------------------------------------------------------------------

_M:register_protocol("static")
_M:register_protocol("dhcp")
_M:register_protocol("none")

-- 加载额外的协议模块
local proto_dir = nixio_fs.dir(util.libpath() .. "/model/network")
if proto_dir then
    for file in proto_dir do
        if file:match("%.lua$") then
            require("luci.model.network." .. file:gsub("%.lua$", ""))
        end
    end
end
