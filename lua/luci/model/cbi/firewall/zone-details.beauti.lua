--[[
    防火墙区域详细配置页面
    
    功能说明:
    - 提供防火墙区域的详细配置界面
    - 配置区域的入站、出站、转发策略
    - 配置区域关联的网络接口
    - 配置区域间的转发规则
    - 高级选项: 地址族限制、伪装子网限制、日志等
    
    区域(Zone)概念:
    - 区域是网络接口的逻辑分组
    - 定义该组接口的默认流量策略
    - 区域间转发需要明确配置
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 编辑 /etc/config/firewall 中的 zone 和 forwarding 配置段
    
    配置存储: /etc/config/firewall
]]

local networkModel = require("luci.model.network")
local firewallModel = require("luci.model.firewall")
local dispatcher = require("luci.dispatcher")
local util = require("luci.util")

-- ============================================================
-- 获取URL参数中的区域ID
-- ============================================================
local zoneId = arg[1]

-- ============================================================
-- 创建配置映射 (Map)
-- ============================================================
local firewallMap = Map("firewall")

-- 设置返回URL
firewallMap.redirect = dispatcher.build_url("admin/network/firewall/zones")

-- 初始化模型
firewallModel.init(firewallMap.uci)
networkModel.init(firewallMap.uci)

-- ============================================================
-- 获取区域对象
-- ============================================================
local zoneObject = firewallModel.get_zone(zoneId)

if not zoneObject then
    -- 区域不存在，重定向回列表页
    luci.http.redirect(firewallMap.redirect)
    return
end

-- 设置页面标题
firewallMap.title = translatef("Zone %q", zoneObject:name() or "?")

-- ============================================================
-- 创建区域配置段 (NamedSection)
-- ============================================================
local zoneSection = firewallMap:section(
    NamedSection,
    zoneObject.sid,
    "zone",
    translatef("Zone %q", zoneObject:name()),
    translatef(
        "This section defines common properties of %q. " ..
        "The <em>input</em> and <em>output</em> options set the default " ..
        "policies for traffic entering and leaving this zone while the " ..
        "<em>forward</em> option describes the policy for forwarded traffic " ..
        "between different networks within the zone. " ..
        "<em>Covered networks</em> specifies which available networks are " ..
        "member of this zone.",
        zoneObject:name()
    )
)

zoneSection.anonymous = true
zoneSection.addremove = false

-- 提交时刷新防火墙状态
firewallMap.on_commit = function(self)
    firewallModel.init(self.uci)
end

-- ============================================================
-- 标签页定义
-- ============================================================
zoneSection:tab("general", translate("General Settings"))
zoneSection:tab("advanced", translate("Advanced Settings"))

-- ============================================================
-- 基本设置标签页
-- ============================================================

-- 区域名称
local nameOption = zoneSection:taboption(
    "general",
    Value,
    "name",
    translate("Name")
)
nameOption.optional = false
nameOption.forcewrite = true
nameOption.datatype = "uciname"

-- 自定义写入函数处理区域重命名
function nameOption.write(self, section, value)
    if value ~= zoneObject:name() then
        -- 重命名区域需要更新所有引用
        firewallModel.rename_zone(zoneObject:name(), value)
    end
    return Value.write(self, section, value)
end

-- 入站策略
local inputOption = zoneSection:taboption(
    "general",
    ListValue,
    "input",
    translate("Input")
)

-- 出站策略
local outputOption = zoneSection:taboption(
    "general",
    ListValue,
    "output",
    translate("Output")
)

-- 转发策略
local forwardOption = zoneSection:taboption(
    "general",
    ListValue,
    "forward",
    translate("Forward")
)

-- 为所有策略选项添加可选值
local policyOptions = {inputOption, outputOption, forwardOption}
for _, option in ipairs(policyOptions) do
    option:value("REJECT", translate("reject"))
    option:value("DROP", translate("drop"))
    option:value("ACCEPT", translate("accept"))
end

-- 伪装(Masquerading)开关
local masqOption = zoneSection:taboption(
    "general",
    Flag,
    "masq",
    translate("Masquerading")
)

-- MSS钳制开关
local mtuFixOption = zoneSection:taboption(
    "general",
    Flag,
    "mtu_fix",
    translate("MSS clamping")
)

-- 关联网络接口
local networkOption = zoneSection:taboption(
    "general",
    Value,
    "network",
    translate("Covered networks")
)
networkOption.template = "cbi/network_netlist"
networkOption.widget = "checkbox"
networkOption.cast = "string"

-- 自定义表单值处理
function networkOption.formvalue(self, section)
    return self:cfgvalue(section)
end

function networkOption.cfgvalue(self, section)
    return zoneObject:get_networks()
end

function networkOption.write(self, section, value)
    zoneObject:set_networks(value)
end

-- ============================================================
-- 高级设置标签页
-- ============================================================

-- 地址族限制
local familyOption = zoneSection:taboption(
    "advanced",
    ListValue,
    "family",
    translate("Restrict to address family")
)
familyOption.rmempty = true
familyOption:value("", translate("IPv4 and IPv6"))
familyOption:value("ipv4", translate("IPv4 only"))
familyOption:value("ipv6", translate("IPv6 only"))

-- 伪装源子网限制
local masqSrcOption = zoneSection:taboption(
    "advanced",
    DynamicList,
    "masq_src",
    translate("Restrict Masquerading to given source subnets")
)
masqSrcOption.optional = true
masqSrcOption.datatype = "list(neg(or(uciname,hostname,ip4addr)))"
masqSrcOption.placeholder = "0.0.0.0/0"
masqSrcOption:depends("masq", "1")
masqSrcOption:depends("family", "")
masqSrcOption:depends("family", "ipv4")

-- 伪装目标子网限制
local masqDestOption = zoneSection:taboption(
    "advanced",
    DynamicList,
    "masq_dest",
    translate("Restrict Masquerading to given destination subnets")
)
masqDestOption.optional = true
masqDestOption.datatype = "list(neg(or(uciname,hostname,ip4addr)))"
masqDestOption.placeholder = "0.0.0.0/0"
masqDestOption:depends("masq", "1")
masqDestOption:depends("family", "")
masqDestOption:depends("family", "ipv4")

-- 强制连接跟踪
local conntrackOption = zoneSection:taboption(
    "advanced",
    Flag,
    "conntrack",
    translate("Force connection tracking")
)

-- 启用日志
local logOption = zoneSection:taboption(
    "advanced",
    Flag,
    "log",
    translate("Enable logging on this zone")
)
logOption.rmempty = true
logOption.enabled = "1"

-- 日志速率限制
local logLimitOption = zoneSection:taboption(
    "advanced",
    Value,
    "log_limit",
    translate("Limit log messages")
)
logLimitOption.placeholder = "10/minute"
logLimitOption:depends("log", "1")

-- ============================================================
-- 区域间转发配置段
-- ============================================================
local forwardingSection = firewallMap:section(
    NamedSection,
    zoneObject.sid,
    "fwd_out",
    translate("Inter-Zone Forwarding"),
    translatef(
        "The options below control the forwarding policies between " ..
        "this zone (%s) and other zones. <em>Destination zones</em> cover " ..
        "forwarded traffic <strong>originating from %q</strong>. " ..
        "<em>Source zones</em> match forwarded traffic from other zones " ..
        "<strong>targeted at %q</strong>. The forwarding rule is " ..
        "<em>unidirectional</em>, e.g. a forward from lan to wan does " ..
        "<em>not</em> imply a permission to forward from wan to lan as well.",
        zoneObject:name(),
        zoneObject:name(),
        zoneObject:name()
    )
)

-- 允许转发到的目标区域
local destZonesOption = forwardingSection:option(
    Value,
    "out",
    translate("Allow forward to <em>destination zones</em>:")
)
destZonesOption.nocreate = true
destZonesOption.widget = "checkbox"
destZonesOption.exclude = zoneObject:name()
destZonesOption.template = "cbi/firewall_zonelist"

-- 允许从哪些源区域转发过来
local srcZonesOption = forwardingSection:option(
    Value,
    "in",
    translate("Allow forward from <em>source zones</em>:")
)
srcZonesOption.nocreate = true
srcZonesOption.widget = "checkbox"
srcZonesOption.exclude = zoneObject:name()
srcZonesOption.template = "cbi/firewall_zonelist"

-- 自定义读取和写入函数处理转发规则
function destZonesOption.cfgvalue(self, section)
    return zoneObject:get_forwardings("out")
end

function srcZonesOption.cfgvalue(self, section)
    return zoneObject:get_forwardings("in")
end

function destZonesOption.formvalue(self, section)
    return self:cfgvalue(section)
end

function srcZonesOption.formvalue(self, section)
    return self:cfgvalue(section)
end

function destZonesOption.write(self, section, value)
    zoneObject:set_forwardings("out", value)
end

function srcZonesOption.write(self, section, value)
    zoneObject:set_forwardings("in", value)
end

return firewallMap
