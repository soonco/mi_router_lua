--[[
    L2TP VPN协议配置表单
    
    功能说明:
    - 为网络接口提供L2TP (Layer 2 Tunneling Protocol) VPN配置界面
    - L2TP常用于企业VPN和某些ISP的宽带接入
    - 支持用户名密码认证
    - 支持IPv6隧道
    
    CBI框架说明:
    - 本文件是LuCI CBI模块，用于生成Web配置表单
    - 通过 ... 接收父级Map和Section对象
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- L2TP服务器地址
-- 必填项，可以是IP地址或域名
local serverOption = formSection.taboption(
    "general",
    Value,
    "server",
    translate("L2TP Server")
)
serverOption.datatype = "or(host,hostport)"  -- 支持主机名、IP或带端口格式

-- 用户名
-- PAP/CHAP认证用户名
local usernameOption = formSection.taboption(
    "general",
    Value,
    "username",
    translate("PAP/CHAP username")
)

-- 密码
-- PAP/CHAP认证密码
local passwordOption = formSection.taboption(
    "general",
    Value,
    "password",
    translate("PAP/CHAP password")
)
passwordOption.password = true  -- 密码框模式，隐藏输入内容

-- ============================================================
-- 高级设置标签页 (Advanced Settings)
-- ============================================================

-- IPv6隧道支持
-- 启用后L2TP隧道可传输IPv6流量
local ipv6Option = formSection.taboption(
    "advanced",
    Flag,
    "ipv6",
    translate("Obtain IPv6-Address"),
    translate("Enable IPv6 negotiation on the PPP link")
)

-- 默认网关开关
-- 是否将此VPN接口作为默认路由出口
local defaultRouteOption = formSection.taboption(
    "advanced",
    Flag,
    "defaultroute",
    translate("Use default gateway"),
    translate("If unchecked, no default route is configured")
)
defaultRouteOption.default = defaultRouteOption.enabled

-- 路由度量值
-- 数值越小优先级越高
local metricOption = formSection.taboption(
    "advanced",
    Value,
    "metric",
    translate("Use gateway metric")
)
metricOption.placeholder = "0"
metricOption.datatype = "uinteger"

-- 对端DNS开关
-- 是否使用VPN服务器分配的DNS
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
dnsOption:depends("peerdns", "")  -- 仅当peerdns未启用时显示
dnsOption.datatype = "ipaddr"
dnsOption.cast = "string"

-- MTU设置
-- L2TP隧道开销较大，通常需要比标准1500更小的MTU
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"
