--[[
    DHCP客户端协议配置表单
    
    功能说明:
    - 为网络接口提供DHCP客户端协议的配置界面
    - 支持IPv4 DHCP自动获取IP地址
    - 支持IPv6相关配置(RA/RS)
    - 提供高级选项如MTU、Metric、MAC地址克隆等
    
    CBI框架说明:
    - 本文件是LuCI CBI (Configuration Binding Interface) 模块
    - 通过 ... 接收父级Map和Section对象
    - 使用 taboption() 在指定标签页添加配置项
    
    配置存储: /etc/config/network
]]

-- 接收父级传入的参数
local configMap, formSection, networkInterface = ...

-- ============================================================
-- 基本设置标签页 (General Settings)
-- ============================================================

-- 主机名设置
-- 发送给DHCP服务器的主机名，用于动态DNS注册
local hostnameOption = formSection.taboption(
    "general",
    Value,
    "hostname",
    translate("Hostname to send when requesting DHCP")
)
hostnameOption.placeholder = luci.sys.hostname()  -- 默认显示当前系统主机名
hostnameOption.datatype = "hostname"              -- 验证为合法主机名格式

-- ============================================================
-- 高级设置标签页 (Advanced Settings)
-- ============================================================

-- IPv6路由通告接受开关
-- 启用后接受来自上游路由器的IPv6路由通告(Router Advertisement)
local acceptRaOption = formSection.taboption(
    "advanced",
    Flag,
    "accept_ra",
    translate("Accept router advertisements")
)
acceptRaOption.default = acceptRaOption.enabled

-- IPv6路由请求发送开关
-- 启用后主动发送路由请求(Router Solicitation)以快速获取IPv6配置
local sendRsOption = formSection.taboption(
    "advanced",
    Flag,
    "send_rs",
    translate("Send router solicitations")
)
sendRsOption.default = sendRsOption.enabled

-- 广播标志开关
-- 某些DHCP服务器要求客户端设置广播标志才能正确响应
local broadcastOption = formSection.taboption(
    "advanced",
    Flag,
    "broadcast",
    translate("Use broadcast flag"),
    translate("Required for certain ISPs, e.g. Charter with different equipment")
)

-- 默认网关开关
-- 是否将此接口作为默认路由出口
local defaultRouteOption = formSection.taboption(
    "advanced",
    Flag,
    "defaultroute",
    translate("Use default gateway"),
    translate("If unchecked, no default route is configured")
)
defaultRouteOption.default = defaultRouteOption.enabled

-- 对端DNS开关
-- 是否使用DHCP服务器分配的DNS服务器
local peerDnsOption = formSection.taboption(
    "advanced",
    Flag,
    "peerdns",
    translate("Use DNS servers advertised by peer"),
    translate("If unchecked, the advertised DNS server addresses are ignored")
)
peerDnsOption.default = peerDnsOption.enabled

-- 自定义DNS服务器列表
-- 当不使用对端DNS时，可手动指定DNS服务器
local dnsOption = formSection.taboption(
    "advanced",
    DynamicList,
    "dns",
    translate("Use custom DNS servers")
)
dnsOption:depends("peerdns", "")  -- 仅当peerdns未启用时显示
dnsOption.datatype = "ipaddr"     -- 验证为IP地址格式
dnsOption.cast = "string"         -- 存储为字符串

-- 路由度量值
-- 数值越小优先级越高，用于多WAN负载均衡场景
local metricOption = formSection.taboption(
    "advanced",
    Value,
    "metric",
    translate("Use gateway metric")
)
metricOption.placeholder = "0"
metricOption.datatype = "uinteger"  -- 无符号整数

-- DHCP客户端ID
-- 某些ISP要求特定的客户端标识符
local clientIdOption = formSection.taboption(
    "advanced",
    Value,
    "clientid",
    translate("Client ID to send when requesting DHCP")
)

-- 厂商类标识
-- DHCP Option 60，某些ISP用于识别设备类型
local vendorIdOption = formSection.taboption(
    "advanced",
    Value,
    "vendorid",
    translate("Vendor Class to send when requesting DHCP")
)

-- MAC地址克隆
-- 用于替代WAN口真实MAC地址，解决ISP绑定MAC的问题
local macAddrOption = formSection.taboption(
    "advanced",
    Value,
    "macaddr",
    translate("Override MAC address")
)
macAddrOption.placeholder = translate("xx:xx:xx:xx:xx:xx")
macAddrOption.datatype = "macaddr"  -- 验证为MAC地址格式

-- MTU设置
-- 最大传输单元，默认1500，PPPoE环境通常需要调低
local mtuOption = formSection.taboption(
    "advanced",
    Value,
    "mtu",
    translate("Override MTU")
)
mtuOption.placeholder = "1500"
mtuOption.datatype = "max(1500)"  -- 最大值1500
