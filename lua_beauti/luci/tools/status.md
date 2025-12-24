# status.lua - 状态工具模块

## 工作原理

LuCI 状态工具模块，提供系统状态信息获取功能，包括 DHCP 租约、WiFi 网络状态、交换机端口状态等。

核心功能：
1. **DHCP 租约** - 读取 DHCPv4 和 DHCPv6 租约信息
2. **WiFi 状态** - 获取无线网络设备和网络状态
3. **交换机状态** - 获取交换机端口连接状态

## 接口

### DHCP 租约函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `dhcp_leases()` | 无 | 租约数组 | 获取 DHCPv4 租约列表 |
| `dhcp6_leases()` | 无 | 租约数组 | 获取 DHCPv6 租约列表 |

### DHCPv4 租约结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `expires` | number | 剩余有效时间（秒） |
| `macaddr` | string | MAC 地址 |
| `ipaddr` | string | IPv4 地址 |
| `hostname` | string/nil | 主机名 |

### DHCPv6 租约结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `expires` | number | 剩余有效时间（秒） |
| `ip6addr` | string | IPv6 地址 |
| `duid` | string/nil | DHCP 唯一标识符 |
| `hostname` | string/nil | 主机名 |

### WiFi 状态函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `wifi_networks()` | 无 | 设备数组 | 获取所有 WiFi 网络状态 |
| `wifi_network(network_id)` | network_id: 网络 ID | 网络信息 | 获取指定 WiFi 网络状态 |

### WiFi 设备信息结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `up` | boolean | 设备是否启用 |
| `device` | string | 设备名称 |
| `name` | string | 设备显示名称 |
| `networks` | array | 网络列表 |

### WiFi 网络信息结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `name` | string | 网络短名称 |
| `link` | string | 管理链接 |
| `up` | boolean | 网络是否启用 |
| `mode` | string | 工作模式 |
| `ssid` | string | SSID |
| `bssid` | string | BSSID |
| `encryption` | string | 加密方式 |
| `frequency` | number | 频率 |
| `channel` | number | 信道 |
| `signal` | number | 信号强度 (dBm) |
| `quality` | number | 信号质量 (%) |
| `noise` | number | 噪声 (dBm) |
| `bitrate` | number | 比特率 |
| `ifname` | string | 接口名称 |
| `assoclist` | table | 关联客户端列表 |
| `country` | string | 国家代码 |
| `txpower` | number | 发射功率 |
| `txpoweroff` | number | 功率偏移 |

### 交换机状态函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `switch_status(switch_name)` | switch_name: 交换机名称（可选） | 状态表 | 获取交换机端口状态 |

### 交换机端口信息结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `port` | number | 端口号 |
| `speed` | number | 速度 (Mbps) |
| `link` | boolean | 是否连接 |
| `duplex` | boolean | 是否全双工 |
| `rxflow` | boolean | 接收流控 |
| `txflow` | boolean | 发送流控 |
| `auto` | boolean | 自动协商 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读取 |
| `luci.model.network` | 网络模型 |
| `luci.sys` | 系统函数 |
| `nixio.fs` | 文件系统访问 |
