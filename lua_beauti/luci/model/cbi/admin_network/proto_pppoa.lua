--[[
    PPPoA协议配置表单 (PPP over ATM)
    
    功能说明:
    - 为网络接口提供PPPoA宽带拨号配置界面
    - PPPoA是基于ATM网络的PPP封装协议
    - 主要用于ADSL调制解调器的桥接模式
    - 需要配置ATM虚电路参数(VPI/VCI)
    
    ATM参数说明:
    - VPI (Virtual Path Identifier): 虚路径标识符，通常为0或8
    - VCI (Virtual Channel Identifier): 虚通道标识符，通常为35
    - 封装类型: VC-Mux或LLC，由ISP指定
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 包含ATM特有配置和PPP通用配置
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- ATM封装类型
-- VC-Mux: 无LLC头，效率更高
-- LLC: 带LLC/SNAP头，兼容性更好
local encapsOption = formSection.taboption(
    "general",
    ListValue,
    "encaps",
    translate("PPPoA Encapsulation")
)
encapsOption:value("vc", "VC-Mux")   -- 虚电路复用
encapsOption:value("llc", "LLC")     -- 逻辑链路控制

-- ATM设备编号
-- 多个ADSL调制解调器时需要指定
local atmDevOption = formSection.taboption(
    "general",
    Value,
    "atmdev",
    translate("ATM device number")
)
atmDevOption.placeholder = "0"
atmDevOption.datatype = "uinteger"

-- VCI (虚通道标识符)
-- 常见值: 35 (中国电信)
local vciOption = formSection.taboption(
    "general",
    Value,
    "vci",
    translate("ATM Virtual Channel Identifier (VCI)")
)
vciOption.placeholder = "35"
vciOption.datatype = "uinteger"

-- VPI (虚路径标识符)
-- 常见值: 0 或 8
local vpiOption = formSection.taboption(
    "general",
    Value,
    "vpi",
    translate("ATM Virtual Path Identifier (VPI)")
)
vpiOption.placeholder = "8"
vpiOption.datatype = "uinteger"

-- 用户名
-- PPP认证用户名，通常是宽带账号
local usernameOption = formSection.taboption(
    "general",
    Value,
    "username",
    translate("PAP/CHAP username")
)

-- 密码
-- PPP认证密码，通常是宽带密码
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
-- PPPoA典型MTU为1492或更小
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"
