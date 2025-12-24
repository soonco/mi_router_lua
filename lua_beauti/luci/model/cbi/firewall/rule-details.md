# rule-details.lua - 防火墙规则详情页面模块

## 工作原理

本模块是 LuCI CBI 框架的防火墙规则详情配置页面，用于配置防火墙规则和 SNAT 规则的详细参数。

**支持的规则类型:**
- 普通防火墙规则 (rule)
- SNAT 规则 (redirect with target=SNAT)

**配置存储:** `/etc/config/firewall`

## 接口

### SNAT 规则配置选项

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 规则名称 | name | Value | SNAT规则名称 |
| 协议 | proto | ListValue | all/TCP+UDP/TCP/UDP/ICMP |
| 源区域 | src | ListValue | 默认wan |
| 源MAC地址 | src_mac | Value | 支持取反(neg) |
| 源IP地址 | src_ip | Value | 支持取反(neg) |
| 源端口 | src_port | Value | 支持端口范围 |
| 目标区域 | dest | ListValue | 默认lan |
| 目标IP地址 | dest_ip | Value | IPv4地址 |
| 目标端口 | dest_port | Value | 支持端口范围 |
| SNAT IP地址 | src_dip | Value | 必填，重写的源IP |
| SNAT端口 | src_dport | Value | 重写的源端口 |
| 额外参数 | extra | Value | 额外iptables参数 |

### 普通防火墙规则配置选项

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 启用/禁用 | - | Button | 规则开关 |
| 规则名称 | name | Value | 规则名称 |
| 地址族限制 | family | ListValue | IPv4和IPv6/仅IPv4/仅IPv6 |
| 协议 | proto | MultiValue | Any/TCP+UDP/TCP/UDP/ICMP |
| ICMP类型 | icmp_type | MultiValue | 30+种ICMP类型 |
| 源区域 | src | ListValue | 默认wan |
| 源MAC地址 | src_mac | DynamicList | 支持多个MAC |
| 源IP地址 | src_ip | DynamicList | 支持取反(neg) |
| 源端口 | src_port | Value | 支持端口范围列表 |
| 目标区域 | dest | ListValue | 支持any和local |
| 目标IP地址 | dest_ip | DynamicList | 支持取反(neg) |
| 目标端口 | dest_port | Value | 支持端口范围列表 |
| 动作 | target | ListValue | DROP/ACCEPT/REJECT/NOTRACK |
| 额外参数 | extra | Value | 额外iptables参数 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| proto.cfgvalue() | 处理tcpudp到"tcp udp"的转换 |

## 外部引用

- `luci.sys`: 系统工具模块（MAC/IP提示）
- `luci.dispatcher`: 路由调度器
- `nixio`: 底层I/O库
- `luci.tools.firewall`: 防火墙工具函数
- `luci.model.network`: 网络模型
