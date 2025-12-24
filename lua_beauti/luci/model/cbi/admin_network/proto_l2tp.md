# proto_l2tp.lua - L2TP VPN协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 L2TP (Layer 2 Tunneling Protocol) VPN 配置界面。

**核心特点:**
- L2TP 常用于企业 VPN 和某些 ISP 的宽带接入
- 支持用户名密码认证 (PAP/CHAP)
- 支持 IPv6 隧道
- 通过 `...` 接收父级 Map 和 Section 对象

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| L2TP服务器 | server | Value | 必填，支持主机名、IP或带端口格式 |
| 用户名 | username | Value | PAP/CHAP认证用户名 |
| 密码 | password | Value | PAP/CHAP认证密码（密码框模式） |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| IPv6支持 | ipv6 | Flag | 启用PPP链路上的IPv6协商 |
| 默认网关 | defaultroute | Flag | 是否将此VPN作为默认路由出口（默认启用） |
| 路由度量值 | metric | Value | 数值越小优先级越高，默认0 |
| 对端DNS | peerdns | Flag | 是否使用VPN服务器分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| MTU | mtu | Value | 最大传输单元，默认1500 |

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- LuCI CBI 框架组件: Value, Flag, DynamicList
- translate() 国际化函数
