# webadmin.lua - Web 管理工具模块

## 工作原理

LuCI Web 管理工具模块，提供 Web 管理界面的辅助函数，包括字节格式化、时间格式化、网络配置获取等功能。

核心功能：
1. **格式化函数** - 字节数和时间的人类可读格式化
2. **网络信息** - 获取网络接口的 IP 地址和防火墙区域
3. **CBI 辅助** - 向表单添加网络接口和 IP 地址选项

## 接口

### 格式化函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `byte_format(bytes)` | bytes: 字节数 | 格式化字符串 | 格式化字节数 |
| `date_format(seconds)` | seconds: 秒数 | 格式化字符串 | 格式化时间 |

### byte_format 输出示例

| 输入 | 输出 |
|------|------|
| 512 | "512.00 B" |
| 1536 | "1.50 KB" |
| 1572864 | "1.50 MB" |
| 1610612736 | "1.50 GB" |

### date_format 输出示例

| 输入 | 输出 |
|------|------|
| 3661 | "01h 01min 01s" |
| 90061 | "1d 01h 01min 01s" |

### 网络信息函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `network_get_addresses(interface_name)` | interface_name: 接口名 | IP 地址数组 | 获取接口 IP 地址 |
| `network_get_zones(interface_name)` | interface_name: 接口名 | 区域名数组 | 获取接口所属防火墙区域 |
| `iface_get_network(ifname)` | ifname: 接口名 | 网络名 | 根据接口名获取网络 |
| `firewall_find_zone(zone_name)` | zone_name: 区域名 | 配置节名 | 查找防火墙区域配置节 |

### network_get_addresses 返回值

返回数组包含：
- 主接口的 IPv4 地址（CIDR 格式）
- 主接口的 IPv6 地址
- 所有别名接口的 IPv4 地址
- 所有别名接口的 IPv6 地址

### CBI 辅助函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cbi_add_networks(widget)` | widget: CBI 控件 | 无 | 添加网络接口选项 |
| `cbi_add_knownips(widget)` | widget: CBI 控件 | 无 | 添加已知 IP 地址选项 |

### cbi_add_networks 行为

- 遍历所有网络接口
- 排除 loopback 接口
- 添加接口名称作为选项值
- 设置 titleref 链接到网络配置页面

### cbi_add_knownips 行为

- 读取 ARP 表
- 将所有已知 IP 地址添加为选项值

### 使用示例

```lua
local webadmin = require("luci.tools.webadmin")

-- 格式化字节
local size = webadmin.byte_format(1024 * 1024)  -- "1.00 MB"

-- 格式化运行时间
local uptime = webadmin.date_format(86400 + 3600)  -- "1d 01h 00min 00s"

-- 获取接口 IP
local ips = webadmin.network_get_addresses("lan")

-- 获取接口所属区域
local zones = webadmin.network_get_zones("lan")
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读取 |
| `luci.sys` | 系统函数（ARP 表） |
| `luci.ip` | IP 地址处理 |
| `luci.util` | 工具函数 |
| `luci.dispatcher` | URL 构建 |
