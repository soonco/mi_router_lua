# proto_pptp.lua - PPTP VPN协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 PPTP (Point-to-Point Tunneling Protocol) VPN 配置界面。

**核心特点:**
- PPTP 是一种较老的 VPN 协议，配置简单但安全性较低
- 支持 Windows 内置 VPN 客户端兼容
- 基于 GRE 隧道封装 PPP 流量
- 包含 LCP Echo 保活机制

**安全提示:**
- PPTP 的 MS-CHAPv2 认证已被证明存在安全漏洞
- 建议在安全要求高的场景使用 OpenVPN 或 WireGuard

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| VPN服务器 | server | Value | 必填，支持主机名、IP或带端口格式 |
| 用户名 | username | Value | PPTP认证用户名 |
| 密码 | password | Value | PPTP认证密码 |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| IPv6支持 | ipv6 | Flag | 启用PPTP隧道上的IPv6流量传输 |
| 默认网关 | defaultroute | Flag | 是否将VPN作为默认路由出口（默认启用） |
| 路由度量值 | metric | Value | 数值越小优先级越高 |
| 对端DNS | peerdns | Flag | 是否使用VPN服务器分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| LCP Echo失败阈值 | _keepalive_failure | Value | 连续多少次Echo无响应后断开 |
| LCP Echo间隔 | _keepalive_interval | Value | 每隔多少秒发送一次Echo请求 |
| 按需拨号 | demand | Value | 空闲多少秒后断开连接 |
| MTU | mtu | Value | 最大传输单元，PPTP隧道开销较大 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| lcpFailureOption.cfgvalue() | 从keepalive字段解析失败次数 |
| lcpIntervalOption.cfgvalue() | 从keepalive字段解析间隔时间 |
| lcpIntervalOption.write() | 组合failure和interval写入keepalive字段 |

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- LuCI CBI 框架组件: Value, Flag, DynamicList
- translate() 国际化函数
