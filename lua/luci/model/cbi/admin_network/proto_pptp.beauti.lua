--[[
    PPTP VPN协议配置表单
    
    功能说明:
    - 为网络接口提供PPTP (Point-to-Point Tunneling Protocol) VPN配置界面
    - PPTP是一种较老的VPN协议，配置简单但安全性较低
    - 支持Windows内置VPN客户端兼容
    - 基于GRE隧道封装PPP流量
    
    安全提示:
    - PPTP的MS-CHAPv2认证已被证明存在安全漏洞
    - 建议在安全要求高的场景使用OpenVPN或WireGuard
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 包含PPTP特有配置和PPP通用配置
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- PPTP服务器地址
-- 必填项，可以是IP地址或域名
local serverOption = formSection.taboption(
    "general",
    Value,
    "server",
    translate("VPN Server")
)
serverOption.datatype = "or(host,hostport)"  -- 支持主机名、IP或带端口格式

-- 用户名
-- PPTP认证用户名
local usernameOption = formSection.taboption(
    "general",
    Value,
    "username",
    translate("PAP/CHAP username")
)

-- 密码
-- PPTP认证密码
local passwordOption = formSection.taboption(
    "general",
    Value,
    "password",
    translate("PAP/CHAP password")
)
passwordOption.password = true

-- ============================================================
-- 高级设置标签页 (Advanced Settings)
-- ============================================================

-- IPv6支持
-- 启用PPTP隧道上的IPv6流量传输
local ipv6Option = formSection.taboption(
    "advanced",
    Flag,
    "ipv6",
    translate("Obtain IPv6-Address"),
    translate("Enable IPv6 negotiation on the PPP link")
)

-- 默认网关开关
-- 是否将VPN作为默认路由出口
local defaultRouteOption = formSection.taboption(
    "advanced",
    Flag,
    "defaultroute",
    translate("Use default gateway"),
    translate("If unchecked, no default route is configured")
)
defaultRouteOption.default = defaultRouteOption.enabled

-- 路由度量值
local metricOption = formSection.taboption(
    "advanced",
    Value,
    "metric",
    translate("Use gateway metric")
)
metricOption.placeholder = "0"
metricOption.datatype = "uinteger"

-- 对端DNS开关
local peerDnsOption = formSection.taboption(
    "advanced",
    Flag,
    "peerdns",
    translate("Use DNS servers advertised by peer"),
    translate("If unchecked, the advertised DNS server addresses are ignored")
)
peerDnsOption.default = peerDnsOption.enabled

-- 自定义DNS服务器列表
local dnsOption = formSection.taboption(
    "advanced",
    DynamicList,
    "dns",
    translate("Use custom DNS servers")
)
dnsOption:depends("peerdns", "")
dnsOption.datatype = "ipaddr"
dnsOption.cast = "string"

-- ============================================================
-- LCP Echo保活设置 (Keepalive)
-- ============================================================

-- LCP Echo失败次数阈值
local lcpFailureOption = formSection.taboption(
    "advanced",
    Value,
    "_keepalive_failure",
    translate("LCP echo failure threshold"),
    translate("Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures")
)

function lcpFailureOption.cfgvalue(self, sectionName)
    local keepaliveValue = configMap:get(sectionName, "keepalive")
    if keepaliveValue and #keepaliveValue > 0 then
        local failureCount = keepaliveValue:match("^(%d+)")
        return failureCount
    end
    return "0"
end

function lcpFailureOption.write() end
function lcpFailureOption.remove() end

lcpFailureOption.placeholder = "0"
lcpFailureOption.datatype = "uinteger"

-- LCP Echo发送间隔
local lcpIntervalOption = formSection.taboption(
    "advanced",
    Value,
    "_keepalive_interval",
    translate("LCP echo interval"),
    translate("Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold")
)

function lcpIntervalOption.cfgvalue(self, sectionName)
    local keepaliveValue = configMap:get(sectionName, "keepalive")
    if keepaliveValue and #keepaliveValue > 0 then
        local interval = keepaliveValue:match("^%d+ (%d+)")
        if interval then
            return interval
        end
    end
    return "1"
end

function lcpIntervalOption.write(self, sectionName, value)
    local failureValue = lcpFailureOption:formvalue(sectionName)
    if failureValue and tonumber(failureValue) ~= 0 and value and tonumber(value) ~= 0 then
        configMap:set(sectionName, "keepalive", "%s %s" % {failureValue, value})
    else
        configMap:del(sectionName, "keepalive")
    end
end

function lcpIntervalOption.remove() end

lcpIntervalOption.placeholder = "1"
lcpIntervalOption.datatype = "min(1)"

-- 按需拨号
local demandOption = formSection.taboption(
    "advanced",
    Value,
    "demand",
    translate("Inactivity timeout"),
    translate("Close inactive connection after the given amount of seconds, use 0 to persist connection")
)
demandOption.placeholder = "0"
demandOption.datatype = "uinteger"

-- MTU设置
-- PPTP隧道开销较大，通常需要较小的MTU
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"
