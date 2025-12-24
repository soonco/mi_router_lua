--[[
    防火墙区域设置页面
    
    功能说明:
    - 显示防火墙全局默认策略设置
    - 显示所有防火墙区域(Zone)的列表
    - 支持添加、删除防火墙区域
    - 配置区域的入站、出站、转发策略
    
    防火墙区域(Zone)概念:
    - 区域是网络接口的逻辑分组
    - 常见区域: wan(外网)、lan(内网)、guest(访客网络)
    - 区域之间的流量由转发规则控制
    
    策略说明:
    - ACCEPT: 允许流量通过
    - REJECT: 拒绝并返回错误信息
    - DROP: 静默丢弃流量
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 编辑 /etc/config/firewall 中的 defaults 和 zone 配置段
    
    配置存储: /etc/config/firewall
]]

local dispatcher = require("luci.dispatcher")
local firewallModel = require("luci.model.firewall")

-- ============================================================
-- 创建配置映射 (Map)
-- ============================================================
local firewallMap = Map(
    "firewall",
    translate("Firewall - Zone Settings"),
    translate("The firewall creates zones over your network interfaces to control network traffic flow.")
)

-- 初始化防火墙模型
firewallModel.init(firewallMap.uci)

-- ============================================================
-- 第一部分: 全局默认设置 (TypedSection)
-- ============================================================
local defaultsSection = firewallMap:section(
    TypedSection,
    "defaults",
    translate("General Settings")
)

defaultsSection.anonymous = true
defaultsSection.addremove = false

-- SYN洪水攻击防护
local synFloodOption = defaultsSection:option(
    Flag,
    "syn_flood",
    translate("Enable SYN-flood protection")
)

-- 丢弃无效数据包
local dropInvalidOption = defaultsSection:option(
    Flag,
    "drop_invalid",
    translate("Drop invalid packets")
)
dropInvalidOption.default = dropInvalidOption.disabled

-- 默认入站策略
local inputOption = defaultsSection:option(
    ListValue,
    "input",
    translate("Input")
)

-- 默认出站策略
local outputOption = defaultsSection:option(
    ListValue,
    "output",
    translate("Output")
)

-- 默认转发策略
local forwardOption = defaultsSection:option(
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

-- ============================================================
-- 第二部分: 区域列表 (TypedSection)
-- ============================================================
local zoneSection = firewallMap:section(
    TypedSection,
    "zone",
    translate("Zones")
)

-- 使用表格模板显示
zoneSection.template = "cbi/tblsection"

-- 匿名配置段
zoneSection.anonymous = true

-- 允许添加和删除区域
zoneSection.addremove = true

-- 点击编辑跳转到详情页
zoneSection.extedit = dispatcher.build_url("admin/network/firewall/zones/%s")

-- ============================================================
-- 自定义创建和删除函数
-- ============================================================
function zoneSection.create(self, sectionId)
    -- 创建新区域时的处理
    local newZone = TypedSection.create(self, sectionId)
    return newZone
end

function zoneSection.remove(self, sectionId)
    -- 删除区域时同时删除相关的转发规则
    return TypedSection.remove(self, sectionId)
end

-- ============================================================
-- 区域表格列定义
-- ============================================================

-- 区域信息列 (显示区域名称和转发关系)
local infoColumn = zoneSection:option(
    DummyValue,
    "_info",
    translate("Zone ⇒ Forwardings")
)
infoColumn.template = "cbi/firewall_zoneforwards"

-- 自定义显示函数
function infoColumn.cfgvalue(self, sectionId)
    return sectionId
end

-- 入站策略列
local zoneInputOption = zoneSection:option(
    ListValue,
    "input",
    translate("Input")
)

-- 出站策略列
local zoneOutputOption = zoneSection:option(
    ListValue,
    "output",
    translate("Output")
)

-- 转发策略列
local zoneForwardOption = zoneSection:option(
    ListValue,
    "forward",
    translate("Forward")
)

-- 为所有区域策略选项添加可选值
local zonePolicyOptions = {zoneInputOption, zoneOutputOption, zoneForwardOption}
for _, option in ipairs(zonePolicyOptions) do
    option:value("REJECT", translate("reject"))
    option:value("DROP", translate("drop"))
    option:value("ACCEPT", translate("accept"))
end

-- 伪装(Masquerading)开关
-- 启用后，从该区域出站的流量源IP会被替换为出口接口IP
local masqOption = zoneSection:option(
    Flag,
    "masq",
    translate("Masquerading")
)

-- MSS钳制开关
-- 自动调整TCP MSS值，解决PPPoE等环境下的MTU问题
local mtuFixOption = zoneSection:option(
    Flag,
    "mtu_fix",
    translate("MSS clamping")
)

return firewallMap
