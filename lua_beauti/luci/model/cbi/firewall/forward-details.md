# forward-details.lua - 端口转发详细配置页面模块

## 工作原理

本模块是 LuCI CBI 框架的端口转发详细配置页面，提供端口转发规则的完整配置界面。

**核心功能:**
- 提供端口转发规则的详细配置界面
- 支持 DNAT (目标地址转换) 规则配置
- 可配置协议、源/目标地址、端口等参数
- 支持 NAT 回流 (Reflection) 功能

**端口转发原理:**
- 将外网访问路由器特定端口的流量转发到内网主机
- 例如: 外网访问 WAN_IP:8080 -> 转发到 192.168.1.100:80

**配置存储:** `/etc/config/firewall`

## 接口

### 基本设置

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 规则名称 | name | Value | 规则名称，可选 |
| 协议 | proto | ListValue | TCP+UDP/TCP/UDP/ICMP，默认TCP+UDP |
| 源区域 | src | ListValue | 默认wan |
| 源MAC地址 | src_mac | Value | 只匹配指定MAC的流量 |
| 源IP地址 | src_ip | Value | 只匹配指定IP/子网的流量 |
| 源端口 | src_port | Value | 只匹配指定源端口的流量 |

### 外部(WAN侧)设置

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 外部IP地址 | src_dip | Value | 匹配访问此IP的流量（通常是WAN IP） |
| 外部端口 | src_dport | Value | WAN侧监听端口，支持端口范围 |

### 内部(LAN侧)设置

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 内部区域 | dest | ListValue | 默认lan |
| 内部IP地址 | dest_ip | Value | 转发目标主机IP，带已知主机下拉列表 |
| 内部端口 | dest_port | Value | 转发目标端口，默认与外部端口相同 |

### 高级设置

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| NAT回流 | reflection | Flag | 允许内网设备通过外网IP访问内网服务（默认启用） |
| 额外参数 | extra | Value | 额外iptables参数，谨慎使用 |
| 启用 | - | Flag | 规则启用开关 |

### 数据类型验证

| 字段 | datatype | 说明 |
|------|----------|------|
| src_mac | macaddr | MAC地址格式 |
| src_ip | neg(ipaddr) | IP地址，支持取反 |
| src_port | portrange | 端口范围 |
| src_dip | ip4addr | IPv4地址 |
| src_dport | portrange | 端口范围 |
| dest_ip | ip4addr | IPv4地址 |
| dest_port | portrange | 端口范围 |

## 外部引用

- `luci.sys`: 系统工具模块（IP提示）
- `luci.dispatcher`: 路由调度器
- `luci.tools.firewall`: 防火墙工具函数
