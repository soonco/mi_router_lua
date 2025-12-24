--[[
    静态IP协议配置表单
    
    功能说明:
    - 为网络接口提供静态IP地址配置界面
    - 支持IPv4和IPv6双栈配置
    - 适用于固定IP宽带或内网接口配置
    - 提供完整的网络参数手动配置
    
    典型应用场景:
    - 企业固定IP宽带接入
    - 服务器网络配置
    - 路由器LAN口配置
    - 内网VLAN接口配置
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 通过 ... 接收父级Map和Section对象
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- IPv4地址
-- 接口的IPv4地址，必填项
local ipAddrOption = formSection.taboption(
    "general",
    Value,
    "ipaddr",
    translate("IPv4 address")
)
ipAddrOption.datatype = "ip4addr"  -- 验证为IPv4地址格式

-- 子网掩码
-- 网络掩码，如255.255.255.0
local netmaskOption = formSection.taboption(
    "general",
    Value,
    "netmask",
    translate("IPv4 netmask")
)
netmaskOption.datatype = "ip4addr"
netmaskOption:value("255.255.255.0")    -- /24
netmaskOption:value("255.255.0.0")      -- /16
netmaskOption:value("255.0.0.0")        -- /8

-- 默认网关
-- IPv4默认路由的下一跳地址
local gatewayOption = formSection.taboption(
    "general",
    Value,
    "gateway",
    translate("IPv4 gateway")
)
gatewayOption.datatype = "ip4addr"

-- 广播地址
-- 通常自动计算，特殊情况可手动指定
local broadcastOption = formSection.taboption(
    "general",
    Value,
    "broadcast",
    translate("IPv4 broadcast")
)
broadcastOption.datatype = "ip4addr"

-- DNS服务器列表
-- 可添加多个DNS服务器
local dnsOption = formSection.taboption(
    "general",
    DynamicList,
    "dns",
    translate("Use custom DNS servers")
)
dnsOption.datatype = "ipaddr"  -- 支持IPv4和IPv6 DNS
dnsOption.cast = "string"

-- ============================================================
-- 高级设置标签页 (Advanced Settings)
-- ============================================================

-- IPv6路由通告接受开关
-- 启用后接受上游路由器的IPv6 RA
local acceptRaOption = formSection.taboption(
    "advanced",
    Flag,
    "accept_ra",
    translate("Accept router advertisements")
)
acceptRaOption.default = acceptRaOption.disabled  -- 静态配置默认不接受RA

-- IPv6路由请求发送开关
local sendRsOption = formSection.taboption(
    "advanced",
    Flag,
    "send_rs",
    translate("Send router solicitations")
)
sendRsOption.default = sendRsOption.disabled

-- IPv6地址
-- 手动配置的IPv6地址，格式: 地址/前缀长度
local ip6AddrOption = formSection.taboption(
    "advanced",
    Value,
    "ip6addr",
    translate("IPv6 address")
)
ip6AddrOption.datatype = "ip6addr"  -- 验证为IPv6地址格式

-- IPv6网关
-- IPv6默认路由的下一跳地址
local ip6GatewayOption = formSection.taboption(
    "advanced",
    Value,
    "ip6gw",
    translate("IPv6 gateway")
)
ip6GatewayOption.datatype = "ip6addr"

-- MAC地址克隆
-- 用于替代接口真实MAC地址
local macAddrOption = formSection.taboption(
    "advanced",
    Value,
    "macaddr",
    translate("Override MAC address")
)
macAddrOption.placeholder = translate("xx:xx:xx:xx:xx:xx")
macAddrOption.datatype = "macaddr"

-- MTU设置
-- 最大传输单元，默认1500
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"

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
