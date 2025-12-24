--[[
    PPP拨号协议配置表单
    
    功能说明:
    - 为网络接口提供PPP (Point-to-Point Protocol) 拨号配置界面
    - 支持传统调制解调器(Modem)拨号上网
    - 支持3G/4G USB上网卡的PPP模式
    - 提供完整的PPP协议参数配置
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 通过 ... 接收父级Map和Section对象
    - 包含自定义的keepalive参数处理逻辑
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- 调制解调器设备
-- 串口设备路径，如 /dev/ttyUSB0
local deviceOption = formSection.taboption(
    "general",
    Value,
    "device",
    translate("Modem device")
)
deviceOption.placeholder = "/dev/modem"

-- 用户名
-- PPP认证用户名
local usernameOption = formSection.taboption(
    "general",
    Value,
    "username",
    translate("PAP/CHAP username")
)

-- 密码
-- PPP认证密码
local passwordOption = formSection.taboption(
    "general",
    Value,
    "password",
    translate("PAP/CHAP password")
)
passwordOption.password = true  -- 密码框模式

-- ============================================================
-- 高级设置标签页 (Advanced Settings)
-- ============================================================

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
-- keepalive格式: "failure_count interval"
-- 例如: "5 1" 表示每1秒发送一次LCP Echo，连续5次无响应则断开

-- LCP Echo失败次数阈值
-- 连续多少次Echo无响应后认为链路断开
local lcpFailureOption = formSection.taboption(
    "advanced",
    Value,
    "_keepalive_failure",
    translate("LCP echo failure threshold"),
    translate("Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures")
)

-- 自定义读取函数: 从keepalive字段解析失败次数
function lcpFailureOption.cfgvalue(self, sectionName)
    local keepaliveValue = configMap:get(sectionName, "keepalive")
    if keepaliveValue and #keepaliveValue > 0 then
        -- 格式: "failure_count interval" 或 "failure_count"
        local failureCount = keepaliveValue:match("^(%d+)")
        return failureCount
    end
    return "0"  -- 默认值
end

-- 自定义写入函数: 组合failure和interval写入keepalive字段
function lcpFailureOption.write() end  -- 由interval的write函数统一处理
function lcpFailureOption.remove() end

lcpFailureOption.placeholder = "0"
lcpFailureOption.datatype = "uinteger"

-- LCP Echo发送间隔
-- 每隔多少秒发送一次LCP Echo请求
local lcpIntervalOption = formSection.taboption(
    "advanced",
    Value,
    "_keepalive_interval",
    translate("LCP echo interval"),
    translate("Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold")
)

-- 自定义读取函数: 从keepalive字段解析间隔时间
function lcpIntervalOption.cfgvalue(self, sectionName)
    local keepaliveValue = configMap:get(sectionName, "keepalive")
    if keepaliveValue and #keepaliveValue > 0 then
        -- 格式: "failure_count interval"
        local interval = keepaliveValue:match("^%d+ (%d+)")
        if interval then
            return interval
        end
    end
    return "1"  -- 默认1秒
end

-- 自定义写入函数: 组合failure和interval写入keepalive字段
function lcpIntervalOption.write(self, sectionName, value)
    local failureValue = lcpFailureOption:formvalue(sectionName)
    if failureValue and tonumber(failureValue) ~= 0 and value and tonumber(value) ~= 0 then
        -- 两个值都有效时写入组合格式
        configMap:set(sectionName, "keepalive", "%s %s" % {failureValue, value})
    else
        -- 否则删除keepalive设置
        configMap:del(sectionName, "keepalive")
    end
end

function lcpIntervalOption.remove() end

lcpIntervalOption.placeholder = "1"
lcpIntervalOption.datatype = "min(1)"  -- 最小1秒

-- 按需拨号
-- 启用后仅在有流量时才建立PPP连接，空闲后自动断开
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
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"
