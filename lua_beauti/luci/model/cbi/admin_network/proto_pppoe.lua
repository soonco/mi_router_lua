--[[
    PPPoE协议配置表单 (PPP over Ethernet)
    
    功能说明:
    - 为网络接口提供PPPoE宽带拨号配置界面
    - PPPoE是最常用的家庭宽带接入协议
    - 支持中国电信、联通、移动等ISP的宽带拨号
    - 基于以太网的PPP封装，无需ATM配置
    
    典型应用场景:
    - ADSL/VDSL宽带拨号
    - 光纤入户(FTTH)拨号
    - 小区宽带拨号
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 包含PPPoE特有配置(AC/Service)和PPP通用配置
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- 用户名
-- PPPoE认证用户名，即宽带账号
-- 格式通常为: 手机号@区号 或 固话号码
local usernameOption = formSection.taboption(
    "general",
    Value,
    "username",
    translate("PAP/CHAP username")
)

-- 密码
-- PPPoE认证密码，即宽带密码
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

-- Access Concentrator名称
-- 指定要连接的PPPoE接入集中器名称
-- 通常留空，由系统自动选择
local acOption = formSection.taboption(
    "advanced",
    Value,
    "ac",
    translate("Access Concentrator"),
    translate("Leave empty to autodetect")
)

-- 服务名称
-- PPPoE服务名称，某些ISP要求指定
-- 通常留空即可
local serviceOption = formSection.taboption(
    "advanced",
    Value,
    "service",
    translate("Service Name"),
    translate("Leave empty to autodetect")
)

-- IPv6支持
-- 启用PPP链路上的IPv6协商
local ipv6Option = formSection.taboption(
    "advanced",
    Flag,
    "ipv6",
    translate("Obtain IPv6-Address"),
    translate("Enable IPv6 negotiation on the PPP link")
)

-- 默认网关开关
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
-- 启用后仅在有流量时才建立连接
-- 适合按时长计费的宽带
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
-- PPPoE标准MTU为1492 (1500 - 8字节PPPoE头)
-- 某些ISP可能需要更小的值
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"
