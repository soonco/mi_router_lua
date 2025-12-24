# proto_pppoe.lua - PPPoE协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 PPPoE (PPP over Ethernet) 宽带拨号配置界面。

**核心特点:**
- PPPoE 是最常用的家庭宽带接入协议
- 支持中国电信、联通、移动等 ISP 的宽带拨号
- 基于以太网的 PPP 封装，无需 ATM 配置
- 包含 LCP Echo 保活机制

**典型应用场景:**
- ADSL/VDSL 宽带拨号
- 光纤入户 (FTTH) 拨号
- 小区宽带拨号

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 用户名 | username | Value | PPPoE认证用户名（宽带账号） |
| 密码 | password | Value | PPPoE认证密码（宽带密码） |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| AC名称 | ac | Value | 指定PPPoE接入集中器名称，通常留空 |
| 服务名称 | service | Value | PPPoE服务名称，通常留空 |
| IPv6支持 | ipv6 | Flag | 启用PPP链路上的IPv6协商 |
| 默认网关 | defaultroute | Flag | 是否将此接口作为默认路由出口（默认启用） |
| 路由度量值 | metric | Value | 数值越小优先级越高 |
| 对端DNS | peerdns | Flag | 是否使用对端分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| LCP Echo失败阈值 | _keepalive_failure | Value | 连续多少次Echo无响应后断开 |
| LCP Echo间隔 | _keepalive_interval | Value | 每隔多少秒发送一次Echo请求 |
| 按需拨号 | demand | Value | 空闲多少秒后断开连接，0表示保持连接 |
| MTU | mtu | Value | 最大传输单元，PPPoE标准为1492 |

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
