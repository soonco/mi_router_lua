# LuCI Model 模块目录

本目录包含 LuCI Web 管理界面的核心数据模型层，负责与 OpenWrt 系统配置进行交互。

## 目录结构

```
model/
├── cbi/                          # CBI 表单模块
│   ├── admin_network/            # 网络协议配置表单
│   │   ├── proto_dhcp.lua        # DHCP 客户端协议配置
│   │   ├── proto_static.lua      # 静态 IP 协议配置
│   │   ├── proto_ppp.lua         # PPP 拨号协议配置
│   │   ├── proto_pppoe.lua       # PPPoE 宽带拨号配置
│   │   ├── proto_pppoa.lua       # PPPoA (ATM) 协议配置
│   │   ├── proto_pptp.lua        # PPTP VPN 协议配置
│   │   ├── proto_l2tp.lua        # L2TP VPN 协议配置
│   │   └── proto_none.lua        # 无协议（未管理）配置
│   └── firewall/                 # 防火墙配置表单
│       ├── zones.lua             # 防火墙区域列表页面
│       ├── zone-details.lua      # 区域详细配置页面
│       ├── rules.lua             # 流量规则列表页面
│       ├── rule-details.lua      # 规则详细配置页面
│       ├── forwards.lua          # 端口转发列表页面
│       ├── forward-details.lua   # 端口转发详细配置页面
│       └── custom.lua            # 自定义 iptables 规则编辑器
├── network/                      # 网络协议注册模块
│   └── proto_ppp.lua             # PPP 协议族注册
├── firewall.lua                  # 防火墙数据模型
├── network.lua                   # 网络数据模型（核心）
├── uci.lua                       # UCI 配置接口扩展
└── ipkg.lua                      # OPKG 包管理接口
```

## 核心模块说明

### 1. uci.lua - UCI 配置接口扩展

扩展 UCI (Unified Configuration Interface) cursor 的功能，提供更便捷的配置操作方法。

**主要功能：**
- 批量配置操作（delete_all、tset）
- 类型转换（get_bool、get_list、set_list）
- 配置依赖追踪（通过 ucitrack）
- 配置应用与服务重载

**关键接口：**
| 方法 | 说明 |
|------|------|
| `cursor()` | 创建 UCI cursor |
| `apply(configlist, async)` | 应用配置更改 |
| `get_bool(...)` | 获取布尔类型配置值 |
| `get_list/set_list()` | 列表类型配置操作 |
| `delete_all(config, type, filter)` | 批量删除配置节 |

### 2. network.lua - 网络数据模型（核心）

LuCI 网络配置的核心模块，提供网络接口、协议、无线设备等的 Lua 对象模型封装。

**类层次结构：**
- `protocol` - 网络协议基类
- `interface` - 网络接口类
- `wifidev` - 无线设备类
- `wifinet` - 无线网络类

**主要功能：**
- 网络接口管理（添加、删除、查询）
- 协议注册与扩展机制
- 无线设备和网络管理
- 网桥和 VLAN 支持
- IPv4/IPv6 双栈支持

**默认协议：**
| 协议 | 说明 |
|------|------|
| static | 静态地址配置 |
| dhcp | DHCP 客户端 |
| none | 未管理接口 |

### 3. firewall.lua - 防火墙数据模型

提供防火墙配置的 Lua 对象模型，封装 UCI 防火墙配置的操作。

**类层次结构：**
- `defaults` - 防火墙默认设置
- `zone` - 防火墙区域
- `forwarding` - 区域间转发
- `rule` - 防火墙规则
- `redirect` - 端口重定向/NAT

**默认策略：**
| 策略 | 说明 |
|------|------|
| ACCEPT | 接受流量 |
| REJECT | 拒绝（返回错误） |
| DROP | 丢弃（静默） |

**区域颜色：**
| 区域 | 颜色 |
|------|------|
| lan | #90f090 (绿色) |
| wan | #f09090 (红色) |
| 其他 | 根据名称哈希生成 |

### 4. ipkg.lua - OPKG 包管理接口

封装 OPKG 命令行工具，提供 Lua 接口用于软件包的查询、安装、卸载等操作。

**主要功能：**
| 函数 | 说明 |
|------|------|
| `info(pkg)` | 获取软件包详细信息 |
| `status(pkg)` | 获取已安装软件包状态 |
| `install(...)` | 安装软件包 |
| `remove(...)` | 卸载软件包 |
| `update()` | 更新软件包列表 |
| `list_all/list_installed()` | 列出软件包 |

---

## CBI 表单模块

### 网络协议配置表单 (cbi/admin_network/)

这些模块为网络接口提供各种协议的配置界面。

#### proto_dhcp.lua - DHCP 客户端

支持 IPv4 DHCP 自动获取 IP 地址，包含高级选项如 MTU、Metric、MAC 地址克隆等。

**配置选项：**
- 主机名、广播标志
- 默认网关、对端 DNS
- 路由度量值、客户端 ID
- MAC 地址克隆、MTU

#### proto_static.lua - 静态 IP

支持 IPv4 和 IPv6 双栈配置，适用于固定 IP 宽带或内网接口配置。

**配置选项：**
- IPv4/IPv6 地址、子网掩码
- 默认网关、DNS 服务器
- MAC 地址克隆、MTU

#### proto_pppoe.lua - PPPoE 宽带拨号

最常用的家庭宽带接入协议，支持中国电信、联通、移动等 ISP。

**配置选项：**
- 用户名、密码
- AC 名称、服务名称
- LCP Echo 保活参数
- 按需拨号、MTU (标准 1492)

#### proto_ppp.lua - PPP 拨号

支持传统调制解调器拨号和 3G/4G USB 上网卡的 PPP 模式。

**配置选项：**
- 调制解调器设备路径
- 用户名、密码
- LCP Echo 保活参数

#### proto_pppoa.lua - PPPoA (ATM)

基于 ATM 网络的 PPP 封装协议，主要用于 ADSL 调制解调器的桥接模式。

**配置选项：**
- ATM 封装类型 (VC-Mux/LLC)
- VPI/VCI 参数
- 用户名、密码

#### proto_pptp.lua - PPTP VPN

较老的 VPN 协议，配置简单但安全性较低。

**配置选项：**
- VPN 服务器地址
- 用户名、密码
- LCP Echo 保活参数

#### proto_l2tp.lua - L2TP VPN

常用于企业 VPN 和某些 ISP 的宽带接入。

**配置选项：**
- L2TP 服务器地址
- 用户名、密码
- IPv6 支持

#### proto_none.lua - 无协议

表示该网络接口不由系统管理，常用于桥接模式下的从属接口。

---

### 防火墙配置表单 (cbi/firewall/)

#### zones.lua - 区域列表

显示和管理防火墙全局设置及区域列表。

**全局默认设置：**
- SYN 洪水防护
- 丢弃无效包
- 默认入站/出站/转发策略

**区域设置：**
- 入站/出站/转发策略
- NAT 伪装
- MSS 钳制

#### zone-details.lua - 区域详情

提供防火墙区域的完整配置界面。

**配置选项：**
- 区域名称、策略设置
- 关联网络接口
- 区域间转发规则
- 地址族限制、日志设置

#### rules.lua - 流量规则列表

显示和管理所有流量规则和 SNAT 规则。

**功能：**
- 添加、删除、排序规则
- 快速添加规则表单
- 规则启用/禁用

#### rule-details.lua - 规则详情

配置防火墙规则和 SNAT 规则的详细参数。

**配置选项：**
- 协议、源/目标区域
- 源/目标 IP 和端口
- ICMP 类型
- 动作 (DROP/ACCEPT/REJECT/NOTRACK)

#### forwards.lua - 端口转发列表

显示和管理所有端口转发 (DNAT) 规则。

**功能：**
- 添加、删除、排序规则
- 快速添加端口转发

#### forward-details.lua - 端口转发详情

提供端口转发规则的完整配置界面。

**配置选项：**
- 协议、源区域/地址/端口
- 外部 IP/端口
- 内部区域/IP/端口
- NAT 回流 (Reflection)

#### custom.lua - 自定义规则

直接编辑 iptables 规则的界面。

**配置文件：** `/etc/firewall.user`

---

## 网络协议注册模块 (network/)

### proto_ppp.lua - PPP 协议族注册

向网络模型注册 PPP 系列协议。

**注册的协议：**
| 协议 | 显示名称 | 软件包依赖 |
|------|---------|-----------|
| ppp | PPP | ppp |
| pptp | PPtP | ppp-mod-pptp |
| pppoe | PPPoE | ppp-mod-pppoe |
| pppoa | PPPoATM | ppp-mod-pppoa |
| 3g | UMTS/GPRS/EV-DO | comgt |
| l2tp | L2TP | xl2tpd |

**协议特性：**
- 所有 PPP 协议都是虚拟协议
- PPPoE 是唯一非浮动的 PPP 协议（需要绑定以太网接口）
- 每个协议注册虚拟接口名称模式用于识别（如 `pppoe-wan`）

---

## 配置文件路径

| 配置 | 路径 |
|------|------|
| 网络配置 | `/etc/config/network` |
| 防火墙配置 | `/etc/config/firewall` |
| 自定义防火墙规则 | `/etc/firewall.user` |
| OPKG 配置 | `/etc/opkg.conf` |
| UCI 依赖追踪 | `/etc/config/ucitrack` |
| 运行时状态 | `/var/state` |

---

## 外部依赖

| 模块 | 用途 |
|------|------|
| `uci` | UCI 核心库 |
| `ubus` | ubus 通信 |
| `nixio` | 底层 IO 和文件系统 |
| `luci.ip` | IP 地址处理 |
| `luci.sys` | 系统信息 |
| `luci.util` | 工具函数 |
| `luci.dispatcher` | URL 调度 |
| `luci.i18n` | 国际化 |
| `luci.template.parser` | 模板解析器 |
