# LuCI Tools 工具模块目录

## 概述

本目录包含 LuCI Web 管理界面的工具模块集合，提供防火墙规则格式化、网络协议处理、系统状态获取、Web 管理辅助等核心功能。这些模块主要用于 CBI（Configuration Bind Interface）表单构建和状态信息展示。

## 模块列表

| 模块 | 文件 | 功能简介 |
|------|------|----------|
| 防火墙工具 | `firewall.lua` | 防火墙规则格式化显示和 CBI 表单辅助 |
| 协议工具 | `proto.lua` | 网络协议相关的 CBI 表单选项辅助 |
| 状态工具 | `status.lua` | 系统状态信息获取（DHCP、WiFi、交换机） |
| Web管理工具 | `webadmin.lua` | Web 界面辅助函数（格式化、网络信息） |

---

## 模块详解

### 1. firewall.lua - 防火墙工具模块

提供防火墙规则的格式化显示和 CBI 表单选项辅助函数，用于在 Web 界面中美化显示防火墙规则的各种参数。

#### 核心功能

- **格式化函数** - 将防火墙参数格式化为 HTML 显示格式
- **否定处理** - 处理以 `!` 开头的否定规则
- **CBI 辅助** - 提供启用/禁用和名称选项的 CBI 表单集成

#### 主要接口

| 函数 | 说明 |
|------|------|
| `fmt_neg(value)` | 处理否定前缀，返回去除 `!` 后的值和前缀 |
| `fmt_mac(mac_list)` | 格式化 MAC 地址列表为 HTML |
| `fmt_port(port_list, default)` | 格式化端口列表为 HTML |
| `fmt_ip(ip_list, default)` | 格式化 IP 地址列表为 HTML |
| `fmt_zone(zone, default)` | 格式化防火墙区域为 HTML |
| `fmt_icmp_type(icmp_list)` | 格式化 ICMP 类型列表 |
| `fmt_proto(proto_list, icmp_types)` | 格式化协议列表 |
| `fmt_limit(limit, burst)` | 格式化速率限制为可读字符串 |
| `fmt_target(action, dest_list)` | 格式化动作目标 |
| `opt_enabled(map, widget_type, ...)` | 添加启用/禁用 CBI 选项 |
| `opt_name(map, widget_type, ...)` | 添加名称 CBI 选项 |

#### 外部依赖

`luci.util`, `luci.ip`, `nixio`, `luci.i18n`

---

### 2. proto.lua - 协议工具模块

提供网络协议相关的 CBI 表单选项辅助函数，主要用于处理网络接口的 MAC 地址配置。

#### 核心功能

- **MAC 地址选项** - 为 CBI 表单添加 MAC 地址配置选项
- **WiFi 网络支持** - 自动检测并处理 WiFi 网络的 MAC 地址
- **占位符显示** - 显示当前接口的实际 MAC 地址作为占位符

#### 主要接口

| 函数 | 说明 |
|------|------|
| `opt_macaddr(section, iface, ...)` | 添加 MAC 地址配置选项到 CBI 表单 |

#### 使用示例

```lua
local proto = require("luci.tools.proto")

function m.on_init(self)
    local iface = network_model:get_interface("eth0")
    proto.opt_macaddr(s, iface, translate("Override MAC address"))
end
```

#### 外部依赖

`luci.cbi`

---

### 3. status.lua - 状态工具模块

提供系统状态信息获取功能，包括 DHCP 租约、WiFi 网络状态、交换机端口状态等。

#### 核心功能

- **DHCP 租约** - 读取 DHCPv4 和 DHCPv6 租约信息
- **WiFi 状态** - 获取无线网络设备和网络状态
- **交换机状态** - 获取交换机端口连接状态

#### 主要接口

| 函数 | 说明 |
|------|------|
| `dhcp_leases()` | 获取 DHCPv4 租约列表 |
| `dhcp6_leases()` | 获取 DHCPv6 租约列表 |
| `wifi_networks()` | 获取所有 WiFi 网络状态 |
| `wifi_network(network_id)` | 获取指定 WiFi 网络状态 |
| `switch_status(switch_name)` | 获取交换机端口状态 |

#### 数据结构

**DHCPv4 租约**
| 字段 | 类型 | 说明 |
|------|------|------|
| `expires` | number | 剩余有效时间（秒） |
| `macaddr` | string | MAC 地址 |
| `ipaddr` | string | IPv4 地址 |
| `hostname` | string/nil | 主机名 |

**DHCPv6 租约**
| 字段 | 类型 | 说明 |
|------|------|------|
| `expires` | number | 剩余有效时间（秒） |
| `ip6addr` | string | IPv6 地址 |
| `duid` | string/nil | DHCP 唯一标识符 |
| `hostname` | string/nil | 主机名 |

**WiFi 网络信息**
| 字段 | 说明 |
|------|------|
| `name` | 网络短名称 |
| `up` | 网络是否启用 |
| `mode` | 工作模式 |
| `ssid` | SSID |
| `bssid` | BSSID |
| `encryption` | 加密方式 |
| `frequency` | 频率 |
| `channel` | 信道 |
| `signal` | 信号强度 (dBm) |
| `quality` | 信号质量 (%) |

**交换机端口信息**
| 字段 | 说明 |
|------|------|
| `port` | 端口号 |
| `speed` | 速度 (Mbps) |
| `link` | 是否连接 |
| `duplex` | 是否全双工 |

#### 外部依赖

`luci.model.uci`, `luci.model.network`, `luci.sys`, `nixio.fs`

---

### 4. webadmin.lua - Web 管理工具模块

提供 Web 管理界面的辅助函数，包括字节格式化、时间格式化、网络配置获取等功能。

#### 核心功能

- **格式化函数** - 字节数和时间的人类可读格式化
- **网络信息** - 获取网络接口的 IP 地址和防火墙区域
- **CBI 辅助** - 向表单添加网络接口和 IP 地址选项

#### 主要接口

| 函数 | 说明 |
|------|------|
| `byte_format(bytes)` | 格式化字节数为可读字符串 |
| `date_format(seconds)` | 格式化秒数为时间字符串 |
| `network_get_addresses(interface_name)` | 获取接口 IP 地址列表 |
| `network_get_zones(interface_name)` | 获取接口所属防火墙区域 |
| `iface_get_network(ifname)` | 根据接口名获取网络 |
| `firewall_find_zone(zone_name)` | 查找防火墙区域配置节 |
| `cbi_add_networks(widget)` | 添加网络接口选项到 CBI 控件 |
| `cbi_add_knownips(widget)` | 添加已知 IP 地址选项到 CBI 控件 |

#### 格式化示例

```lua
local webadmin = require("luci.tools.webadmin")

-- 字节格式化
webadmin.byte_format(512)        -- "512.00 B"
webadmin.byte_format(1536)       -- "1.50 KB"
webadmin.byte_format(1572864)    -- "1.50 MB"
webadmin.byte_format(1610612736) -- "1.50 GB"

-- 时间格式化
webadmin.date_format(3661)       -- "01h 01min 01s"
webadmin.date_format(90061)      -- "1d 01h 01min 01s"

-- 获取接口 IP
local ips = webadmin.network_get_addresses("lan")

-- 获取接口所属区域
local zones = webadmin.network_get_zones("lan")
```

#### 外部依赖

`luci.model.uci`, `luci.sys`, `luci.ip`, `luci.util`, `luci.dispatcher`

---

## 模块关系图

```
┌─────────────────────────────────────────────────────────────┐
│                      LuCI Web 界面                          │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  CBI 表单     │   │  状态页面     │   │  管理页面     │
└───────────────┘   └───────────────┘   └───────────────┘
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│ firewall.lua  │   │  status.lua   │   │ webadmin.lua  │
│  proto.lua    │   │               │   │               │
└───────────────┘   └───────────────┘   └───────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                              ▼
        ┌─────────────────────────────────────────────┐
        │           LuCI 核心模块                      │
        │  luci.model.uci / luci.sys / luci.ip / ...  │
        └─────────────────────────────────────────────┘
```

## 文件说明

| 文件 | 说明 |
|------|------|
| `firewall.lua` | 防火墙工具模块源码 |
| `firewall.lua.md` | 防火墙工具模块详细文档 |
| `proto.lua` | 协议工具模块源码 |
| `proto.lua.md` | 协议工具模块详细文档 |
| `status.lua` | 状态工具模块源码 |
| `status.lua.md` | 状态工具模块详细文档 |
| `webadmin.lua` | Web 管理工具模块源码 |
| `webadmin.lua.md` | Web 管理工具模块详细文档 |
| `Readme.md` | 本目录说明文档 |

## 使用场景

1. **防火墙配置页面** - 使用 `firewall.lua` 格式化显示防火墙规则
2. **网络接口配置** - 使用 `proto.lua` 添加 MAC 地址配置选项
3. **状态概览页面** - 使用 `status.lua` 获取 DHCP、WiFi、交换机状态
4. **通用管理页面** - 使用 `webadmin.lua` 格式化数据和获取网络信息
