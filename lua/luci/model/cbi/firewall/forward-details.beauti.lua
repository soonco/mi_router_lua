--[[
    端口转发详细配置页面
    
    功能说明:
    - 提供端口转发规则的详细配置界面
    - 支持DNAT(目标地址转换)规则配置
    - 可配置协议、源/目标地址、端口等参数
    - 支持NAT回流(Reflection)功能
    
    端口转发原理:
    - 将外网访问路由器特定端口的流量转发到内网主机
    - 例如: 外网访问 WAN_IP:8080 -> 转发到 192.168.1.100:80
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 编辑 /etc/config/firewall 中的 redirect 配置段
    
    配置存储: /etc/config/firewall
]]

local systemUtils = require("luci.sys")
local dispatcher = require("luci.dispatcher")
local firewallTools = require("luci.tools.firewall")

-- ============================================================
-- 获取URL参数中的规则ID
-- ============================================================
local ruleId = arg[1]

-- ============================================================
-- 创建配置映射 (Map)
-- ============================================================
local firewallMap = Map(
    "firewall",
    translate("Firewall - Port Forwards"),
    translate(
        "Port forwarding allows remote computers on the Internet to " ..
        "connect to a specific computer or service within the private LAN."
    )
)

-- 设置返回URL
firewallMap.redirect = dispatcher.build_url("admin/network/firewall/forwards")

-- ============================================================
-- 创建命名配置段 (NamedSection)
-- ============================================================
local redirectSection = firewallMap:section(
    NamedSection,
    ruleId,
    "redirect",
    translate("Port Forward"),
    translate("Configure port forwarding rule details.")
)

redirectSection.anonymous = true
redirectSection.addremove = false

-- ============================================================
-- 基本设置
-- ============================================================

-- 规则名称
local nameOption = redirectSection:option(
    Value,
    "name",
    translate("Name")
)
nameOption.placeholder = translate("Unnamed forward")
nameOption.rmempty = true

-- 协议选择
local protoOption = redirectSection:option(
    ListValue,
    "proto",
    translate("Protocol")
)
protoOption:value("tcp udp", "TCP+UDP")
protoOption:value("tcp", "TCP")
protoOption:value("udp", "UDP")
protoOption:value("icmp", "ICMP")
protoOption.default = "tcp udp"

-- 源区域
local srcZoneOption = redirectSection:option(
    ListValue,
    "src",
    translate("Source zone")
)
srcZoneOption.template = "cbi/firewall_zonelist"
srcZoneOption.nocreate = true
srcZoneOption.default = "wan"

-- 源MAC地址过滤
local srcMacOption = redirectSection:option(
    Value,
    "src_mac",
    translate("Source MAC address"),
    translate("Only match traffic from this MAC address")
)
srcMacOption.rmempty = true
srcMacOption.datatype = "macaddr"
srcMacOption.placeholder = translate("any")

-- 源IP地址过滤
local srcIpOption = redirectSection:option(
    Value,
    "src_ip",
    translate("Source IP address"),
    translate("Only match traffic from this IP or subnet")
)
srcIpOption.rmempty = true
srcIpOption.datatype = "neg(ipaddr)"
srcIpOption.placeholder = translate("any")

-- 源端口过滤
local srcPortOption = redirectSection:option(
    Value,
    "src_port",
    translate("Source port"),
    translate("Only match traffic from this source port or range")
)
srcPortOption.rmempty = true
srcPortOption.datatype = "portrange"
srcPortOption.placeholder = translate("any")

-- ============================================================
-- 外部(WAN侧)设置
-- ============================================================

-- 外部IP地址(路由器WAN口IP)
local srcDipOption = redirectSection:option(
    Value,
    "src_dip",
    translate("External IP address"),
    translate("Match traffic directed to this IP address (usually WAN IP)")
)
srcDipOption.rmempty = true
srcDipOption.datatype = "ip4addr"
srcDipOption.placeholder = translate("any router IP")

-- 外部端口(WAN侧监听端口)
local srcDportOption = redirectSection:option(
    Value,
    "src_dport",
    translate("External port"),
    translate("Match incoming traffic directed at this port or range")
)
srcDportOption.rmempty = true
srcDportOption.datatype = "portrange"

-- ============================================================
-- 内部(LAN侧)设置
-- ============================================================

-- 目标区域
local destZoneOption = redirectSection:option(
    ListValue,
    "dest",
    translate("Internal zone")
)
destZoneOption.template = "cbi/firewall_zonelist"
destZoneOption.nocreate = true
destZoneOption.default = "lan"

-- 内部IP地址(转发目标主机)
local destIpOption = redirectSection:option(
    Value,
    "dest_ip",
    translate("Internal IP address"),
    translate("Redirect matched traffic to this IP address")
)
destIpOption.datatype = "ip4addr"

-- 添加已知主机到下拉列表
systemUtils.net.ipv4_hints(function(ip, name)
    destIpOption:value(ip, "%s (%s)" % {ip, name})
end)

-- 内部端口(转发目标端口)
local destPortOption = redirectSection:option(
    Value,
    "dest_port",
    translate("Internal port"),
    translate("Redirect matched traffic to this port on the internal host")
)
destPortOption.rmempty = true
destPortOption.datatype = "portrange"
destPortOption.placeholder = translate("same as external")

-- ============================================================
-- 高级设置
-- ============================================================

-- NAT回流(Reflection)
-- 允许内网设备通过外网IP访问内网服务
local reflectionOption = redirectSection:option(
    Flag,
    "reflection",
    translate("Enable NAT Loopback"),
    translate("Allow internal hosts to reach the forwarded service via external IP")
)
reflectionOption.default = reflectionOption.enabled

-- 额外iptables参数
local extraOption = redirectSection:option(
    Value,
    "extra",
    translate("Extra arguments"),
    translate("Additional iptables arguments. Use with caution!")
)
extraOption.rmempty = true

-- 启用/禁用规则
local enabledOption = firewallTools.opt_enabled(
    redirectSection,
    Flag,
    translate("Enable")
)

return firewallMap
