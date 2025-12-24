--[[
    LuCI 防火墙规则详情页面
    用于配置防火墙规则和 SNAT 规则的详细参数
    
    支持的规则类型:
    - 普通防火墙规则（rule）
    - SNAT 规则（redirect with target=SNAT）
    
    配置项包括:
    - 协议选择
    - 源/目标区域
    - 源/目标地址和端口
    - MAC 地址过滤
    - ICMP 类型匹配
    - 动作选择（接受/拒绝/丢弃）
]]

local sys = require("luci.sys")
local dispatcher = require("luci.dispatcher")
local nixio = require("nixio")
local firewall_tools = require("luci.tools.firewall")
local network_model = require("luci.model.network")

-- 局部变量声明
local map, section, option, wan_zone

-- 获取规则 ID（从 URL 参数）
arg[1] = arg[1] or ""

-- 创建防火墙配置映射
map = Map("firewall", translate("Firewall - Traffic Rules"))
map.redirect = dispatcher.build_url("admin/network/firewall/rules")

-- 初始化网络模型
network_model.init(map.uci)

-- 获取规则类型
local rule_type = map.uci:get("firewall", arg[1], ".type")

-- 检查是否为 SNAT 规则
if rule_type == "redirect" then
    local target = map:get(arg[1], "target")
    if target ~= "SNAT" then
        rule_type = nil
    end
end

-- 无效规则，重定向回规则列表
if not rule_type then
    luci.http.redirect(map.redirect)
    return
end

-- ========================================
-- SNAT 规则配置
-- ========================================
if rule_type == "redirect" then
    -- 获取规则名称
    local rule_name = map:get(arg[1], "name") or map:get(arg[1], "_name")
    if not rule_name or #rule_name == 0 then
        rule_name = translate("(Unnamed SNAT)")
    else
        rule_name = "SNAT %s" % rule_name
    end
    
    map.title = "%s - %s" % { translate("Firewall - Traffic Rules"), rule_name }
    
    -- 查找 WAN 区域
    wan_zone = nil
    map.uci:foreach("firewall", "zone", function(zone_config)
        local networks = zone_config.network or {}
        for _, net in ipairs(networks) do
            if net == "wan" then
                wan_zone = zone_config.name
                return false
            end
        end
    end)
    
    -- 创建规则配置节
    section = map:section(NamedSection, arg[1], "redirect", "")
    section.anonymous = true
    section.addremove = false
    
    -- 规则名称
    option = section:option(Value, "name", translate("Name"))
    
    -- 协议选择
    option = section:option(ListValue, "proto", translate("Protocol"))
    option:value("all", "All protocols")
    option:value("tcp udp", "TCP+UDP")
    option:value("tcp", "TCP")
    option:value("udp", "UDP")
    option:value("icmp", "ICMP")
    
    function option:cfgvalue(section_id)
        local value = Value.cfgvalue(self, section_id)
        if not value or value == "tcpudp" then
            return "tcp udp"
        end
        return value
    end
    
    -- 源区域
    option = section:option(ListValue, "src", translate("Source zone"))
    option.nocreate = true
    option.default = "wan"
    option.template = "cbi/firewall_zonelist"
    
    -- 源 MAC 地址
    option = section:option(Value, "src_mac", translate("Source MAC address"))
    option.rmempty = true
    option.datatype = "neg(macaddr)"
    option.placeholder = translate("any")
    
    -- 源 IP 地址
    option = section:option(Value, "src_ip", translate("Source IP address"))
    option.rmempty = true
    option.datatype = "neg(ipaddr)"
    option.placeholder = translate("any")
    
    -- 源端口
    option = section:option(Value, "src_port", translate("Source port"))
    option.rmempty = true
    option.datatype = "neg(portrange)"
    option.placeholder = translate("any")
    
    -- 目标区域
    option = section:option(ListValue, "dest", translate("Destination zone"))
    option.nocreate = true
    option.default = "lan"
    option.template = "cbi/firewall_zonelist"
    
    -- 目标 IP 地址
    option = section:option(Value, "dest_ip", translate("Destination IP address"))
    option.datatype = "neg(ip4addr)"
    option.placeholder = translate("any")
    
    -- 目标端口
    option = section:option(Value, "dest_port", translate("Destination port"))
    option.rmempty = true
    option.placeholder = translate("any")
    option.datatype = "neg(portrange)"
    
    -- SNAT IP 地址
    option = section:option(Value, "src_dip", translate("SNAT IP address"))
    option.rmempty = false
    option.datatype = "ip4addr"
    
    -- 添加可用 IP 地址选项
    for _, zone in ipairs(firewall_tools.zones()) do
        for _, iface in ipairs(zone:get_interfaces()) do
            local host = iface:host()
            if host then
                local ip_str = host:string()
                local zone_name = zone:shortname()
                option:value(ip_str, "%s (%s)" % { ip_str, zone_name })
            end
        end
    end
    
    -- SNAT 端口
    option = section:option(Value, "src_dport", translate("SNAT port"))
    option.datatype = "portrange"
    option.rmempty = true
    option.placeholder = translate("any")
    
    -- 额外参数
    option = section:option(Value, "extra", translate("Extra arguments"))

-- ========================================
-- 普通防火墙规则配置
-- ========================================
else
    -- 获取规则名称
    local rule_name = map:get(arg[1], "name") or map:get(arg[1], "_name")
    if not rule_name or #rule_name == 0 then
        rule_name = translate("(Unnamed Rule)")
    end
    
    map.title = "%s - %s" % { translate("Firewall - Traffic Rules"), rule_name }
    
    -- 创建规则配置节
    section = map:section(NamedSection, arg[1], "rule", "")
    section.anonymous = true
    section.addremove = false
    
    -- 启用/禁用规则
    firewall_tools.opt_enabled(section, Button)
    
    -- 规则名称
    firewall_tools.opt_name(section, Value, translate("Name"))
    
    -- 地址族限制
    option = section:option(ListValue, "family", translate("Restrict to address family"))
    option.rmempty = true
    option:value("", translate("IPv4 and IPv6"))
    option:value("ipv4", translate("IPv4 only"))
    option:value("ipv6", translate("IPv6 only"))
    
    -- 协议选择
    option = section:option(MultiValue, "proto", translate("Protocol"))
    option:value("all", translate("Any"))
    option:value("tcp udp", "TCP+UDP")
    option:value("tcp", "TCP")
    option:value("udp", "UDP")
    option:value("icmp", "ICMP")
    
    function option:cfgvalue(...)
        local value = Value.cfgvalue(...)
        if not value or value == "tcpudp" then
            return "tcp udp"
        end
        return value
    end
    
    -- ICMP 类型匹配
    option = section:option(MultiValue, "icmp_type", translate("Match ICMP type"))
    option:value("", translate("any"))
    option:value("echo-reply")
    option:value("destination-unreachable")
    option:value("network-unreachable")
    option:value("host-unreachable")
    option:value("protocol-unreachable")
    option:value("port-unreachable")
    option:value("fragmentation-needed")
    option:value("source-route-failed")
    option:value("network-unknown")
    option:value("host-unknown")
    option:value("network-prohibited")
    option:value("host-prohibited")
    option:value("TOS-network-unreachable")
    option:value("TOS-host-unreachable")
    option:value("communication-prohibited")
    option:value("host-precedence-violation")
    option:value("precedence-cutoff")
    option:value("source-quench")
    option:value("redirect")
    option:value("network-redirect")
    option:value("host-redirect")
    option:value("TOS-network-redirect")
    option:value("TOS-host-redirect")
    option:value("echo-request")
    option:value("router-advertisement")
    option:value("router-solicitation")
    option:value("time-exceeded")
    option:value("ttl-zero-during-transit")
    option:value("ttl-zero-during-reassembly")
    option:value("parameter-problem")
    option:value("ip-header-bad")
    option:value("required-option-missing")
    option:value("timestamp-request")
    option:value("timestamp-reply")
    option:value("address-mask-request")
    option:value("address-mask-reply")
    
    -- 源区域
    option = section:option(ListValue, "src", translate("Source zone"))
    option.nocreate = true
    option.allowany = true
    option.default = "wan"
    option.template = "cbi/firewall_zonelist"
    
    -- 源 MAC 地址
    option = section:option(DynamicList, "src_mac", translate("Source MAC address"))
    option.datatype = "list(macaddr)"
    option.placeholder = translate("any")
    luci.sys.net.mac_hints(function(mac, name)
        option:value(mac, "%s (%s)" % { mac, name })
    end)
    
    -- 源 IP 地址
    option = section:option(DynamicList, "src_ip", translate("Source address"))
    option.datatype = "neg(ipaddr)"
    option.placeholder = translate("any")
    luci.sys.net.ipv4_hints(function(ip, name)
        option:value(ip, "%s (%s)" % { ip, name })
    end)
    
    -- 源端口
    option = section:option(Value, "src_port", translate("Source port"))
    option.datatype = "list(neg(portrange))"
    option.placeholder = translate("any")
    
    -- 目标区域
    option = section:option(ListValue, "dest", translate("Destination zone"))
    option.nocreate = true
    option.allowany = true
    option.allowlocal = true
    option.template = "cbi/firewall_zonelist"
    
    -- 目标 IP 地址
    option = section:option(DynamicList, "dest_ip", translate("Destination address"))
    option.datatype = "neg(ipaddr)"
    option.placeholder = translate("any")
    luci.sys.net.ipv4_hints(function(ip, name)
        option:value(ip, "%s (%s)" % { ip, name })
    end)
    
    -- 目标端口
    option = section:option(Value, "dest_port", translate("Destination port"))
    option.datatype = "list(neg(portrange))"
    option.placeholder = translate("any")
    
    -- 动作选择
    option = section:option(ListValue, "target", translate("Action"))
    option.default = "ACCEPT"
    option:value("DROP", translate("drop"))
    option:value("ACCEPT", translate("accept"))
    option:value("REJECT", translate("reject"))
    option:value("NOTRACK", translate("don't track"))
    
    -- 额外参数
    option = section:option(Value, "extra", 
        translate("Extra arguments"),
        translate("Passes additional arguments to iptables. Use with care!"))
end

return map
