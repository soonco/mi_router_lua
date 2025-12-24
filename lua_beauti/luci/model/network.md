# network.lua - 网络模型核心模块

## 工作原理

LuCI 网络配置的核心模块，提供网络接口、协议、无线设备等的 Lua 对象模型封装。通过 UCI 和 ubus 与系统交互，支持协议注册和扩展机制。

### 类层次结构

- `protocol`: 网络协议基类
- `interface`: 网络接口类
- `wifidev`: 无线设备类
- `wifinet`: 无线网络类

### 初始化流程

1. 创建 UCI cursor
2. 收集系统接口信息（nixio.getifaddrs）
3. 收集网桥信息（brctl show）
4. 建立 ubus 连接
5. 加载额外协议模块

## 接口

### 模块级函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `init(cursor)` | UCI cursor | 模块自身 | 初始化网络模型 |
| `save(...)` | 配置文件名 | 无 | 保存配置 |
| `commit(...)` | 配置文件名 | 无 | 提交配置 |
| `ifnameof(iface)` | 接口对象/字符串 | string | 获取接口名称 |
| `get_protocol(name, netname)` | 协议名, 网络名 | protocol | 获取协议实例 |
| `get_protocols()` | 无 | protocol[] | 获取所有协议 |
| `register_protocol(name)` | 协议名 | class | 注册新协议 |
| `register_pattern_virtual(pattern)` | 正则模式 | 无 | 注册虚拟接口模式 |
| `has_ipv6()` | 无 | boolean | 检查 IPv6 支持 |
| `add_network(name, options)` | 网络名, 选项 | network | 添加网络 |
| `get_network(name)` | 网络名 | network | 获取网络 |
| `get_networks()` | 无 | network[] | 获取所有网络 |
| `del_network(name)` | 网络名 | boolean | 删除网络 |
| `get_interface(ifname)` | 接口名 | interface | 获取接口 |
| `get_interfaces()` | 无 | interface[] | 获取所有接口 |
| `ignore_interface(ifname)` | 接口名 | boolean | 检查是否忽略接口 |
| `get_wifidev(devname)` | 设备名 | wifidev | 获取无线设备 |
| `get_wifidevs()` | 无 | wifidev[] | 获取所有无线设备 |
| `get_wifinet(netname)` | 网络名 | wifinet | 获取无线网络 |
| `add_wifinet(options)` | 配置选项 | wifinet | 添加无线网络 |
| `del_wifinet(netname)` | 网络名 | boolean | 删除无线网络 |
| `get_wannet()` | 无 | network | 获取 WAN 网络 |
| `get_wandev()` | 无 | interface | 获取 WAN 设备 |
| `get_wan6net()` | 无 | network | 获取 WAN6 网络 |
| `get_wan6dev()` | 无 | interface | 获取 WAN6 设备 |

### protocol 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `ifname()` | 无 | string | 获取接口名称 |
| `proto()` | 无 | string | 获取协议名称 |
| `get_i18n()` | 无 | string | 获取国际化名称 |
| `type()` | 无 | string | 获取接口类型 |
| `name()` | 无 | string | 获取网络名称 |
| `uptime()` | 无 | number | 获取运行时间 |
| `expires()` | 无 | number | 获取 DHCP 租约剩余时间 |
| `metric()` | 无 | number | 获取路由度量值 |
| `ipaddr()` | 无 | table | 获取 IPv4 地址 |
| `netmask()` | 无 | string | 获取子网掩码 |
| `gwaddr()` | 无 | string | 获取网关地址 |
| `dnsaddrs()` | 无 | string[] | 获取 DNS 服务器列表 |
| `ip6addr()` | 无 | string | 获取 IPv6 地址 |
| `gw6addr()` | 无 | string | 获取 IPv6 网关 |
| `dns6addrs()` | 无 | string[] | 获取 IPv6 DNS 列表 |
| `is_bridge()` | 无 | boolean | 检查是否是网桥 |
| `is_virtual()` | 无 | boolean | 检查是否是虚拟协议 |
| `is_floating()` | 无 | boolean | 检查是否是浮动协议 |
| `is_empty()` | 无 | boolean | 检查网络是否为空 |
| `add_interface(iface)` | 接口 | 无 | 添加接口到网络 |
| `del_interface(iface)` | 接口 | 无 | 从网络删除接口 |
| `get_interface()` | 无 | interface | 获取主接口 |
| `get_interfaces()` | 无 | interface[] | 获取所有接口 |
| `contains_interface(iface)` | 接口 | boolean | 检查是否包含接口 |
| `adminlink()` | 无 | string | 获取管理链接 |
| `status()` | 无 | string | 获取网络状态 |

### interface 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `name()` | 无 | string | 获取接口名称 |
| `mac()` | 无 | string | 获取 MAC 地址 |
| `ipaddrs()` | 无 | table[] | 获取 IPv4 地址列表 |
| `ip6addrs()` | 无 | table[] | 获取 IPv6 地址列表 |
| `type()` | 无 | string | 获取接口类型 |
| `shortname()` | 无 | string | 获取简短名称 |
| `get_i18n()` | 无 | string | 获取国际化名称 |
| `get_type_i18n()` | 无 | string | 获取类型国际化名称 |
| `adminlink()` | 无 | string | 获取管理链接 |
| `ports()` | 无 | interface[] | 获取网桥端口 |
| `bridge_id()` | 无 | string | 获取网桥 ID |
| `bridge_stp()` | 无 | boolean | 获取网桥 STP 状态 |
| `is_up()` | 无 | boolean | 检查是否启用 |
| `is_bridge()` | 无 | boolean | 检查是否是网桥 |
| `is_bridgeport()` | 无 | boolean | 检查是否是网桥端口 |
| `tx_bytes()` | 无 | number | 获取发送字节数 |
| `rx_bytes()` | 无 | number | 获取接收字节数 |
| `tx_packets()` | 无 | number | 获取发送包数 |
| `rx_packets()` | 无 | number | 获取接收包数 |
| `get_network()` | 无 | network | 获取关联网络 |
| `get_networks()` | 无 | network[] | 获取所有关联网络 |
| `get_wifinet()` | 无 | wifinet | 获取关联无线网络 |

### wifidev 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `name()` | 无 | string | 获取设备名称 |
| `hwmodes()` | 无 | table | 获取支持的硬件模式 |
| `get_i18n()` | 无 | string | 获取国际化名称 |
| `is_up()` | 无 | boolean | 检查是否启用 |
| `get_wifinet(netname)` | 网络名 | wifinet | 获取无线网络 |
| `get_wifinets()` | 无 | wifinet[] | 获取所有无线网络 |
| `add_wifinet(options)` | 配置选项 | wifinet | 添加无线网络 |
| `del_wifinet(net)` | 网络 | boolean | 删除无线网络 |

### wifinet 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `mode()` | 无 | string | 获取模式 |
| `ssid()` | 无 | string | 获取 SSID |
| `bssid()` | 无 | string | 获取 BSSID |
| `network()` | 无 | string | 获取关联网络 |
| `id()` | 无 | string | 获取网络 ID |
| `name()` | 无 | string | 获取配置节名 |
| `ifname()` | 无 | string | 获取接口名称 |
| `get_device()` | 无 | wifidev | 获取无线设备 |
| `is_up()` | 无 | boolean | 检查是否启用 |
| `active_mode()` | 无 | string | 获取当前模式 |
| `active_ssid()` | 无 | string | 获取当前 SSID |
| `active_bssid()` | 无 | string | 获取当前 BSSID |
| `active_encryption()` | 无 | string | 获取当前加密方式 |
| `assoclist()` | 无 | table | 获取关联列表 |
| `frequency()` | 无 | string | 获取频率 |
| `bitrate()` | 无 | number | 获取比特率 |
| `channel()` | 无 | number | 获取信道 |
| `signal()` | 无 | number | 获取信号强度 |
| `noise()` | 无 | number | 获取噪声 |
| `txpower()` | 无 | number | 获取发射功率 |
| `signal_level()` | 无 | number | 获取信号等级 |
| `signal_percent()` | 无 | number | 获取信号百分比 |
| `get_network()` | 无 | network | 获取关联网络 |
| `get_networks()` | 无 | network[] | 获取所有关联网络 |
| `get_interface()` | 无 | interface | 获取接口对象 |

### 接口模式常量

| 常量 | 说明 |
|------|------|
| `IFACE_PATTERNS_VIRTUAL` | 虚拟接口模式 |
| `IFACE_PATTERNS_IGNORE` | 忽略的接口模式 |
| `IFACE_PATTERNS_WIRELESS` | 无线接口模式 |

### 接口类型

| 类型 | 说明 |
|------|------|
| wifi | 无线接口 |
| bridge | 网桥 |
| tunnel | 隧道 |
| vlan | VLAN 接口 |
| switch | 交换机 |
| ethernet | 以太网 |

### 默认协议

- `static`: 静态地址
- `dhcp`: DHCP 客户端
- `none`: 未管理

## 外部引用

| 模块 | 用途 |
|------|------|
| `ubus` | ubus 通信 |
| `nixio` | 底层 IO |
| `nixio.fs` | 文件系统 |
| `luci.ip` | IP 地址处理 |
| `luci.sys` | 系统信息 |
| `luci.util` | 工具函数 |
| `luci.dispatcher` | URL 调度 |
| `luci.model.uci` | UCI 配置 |
| `luci.i18n` | 国际化 |
