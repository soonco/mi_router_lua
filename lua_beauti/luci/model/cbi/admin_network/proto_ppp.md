# proto_ppp.lua - PPP拨号协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 PPP (Point-to-Point Protocol) 拨号配置界面。

**核心特点:**
- 支持传统调制解调器 (Modem) 拨号上网
- 支持 3G/4G USB 上网卡的 PPP 模式
- 提供完整的 PPP 协议参数配置
- 包含自定义的 keepalive 参数处理逻辑

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 调制解调器设备 | device | Value | 串口设备路径，如 /dev/ttyUSB0 |
| 用户名 | username | Value | PPP认证用户名 |
| 密码 | password | Value | PPP认证密码 |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| IPv6支持 | ipv6 | Flag | 启用PPP链路上的IPv6协商 |
| 默认网关 | defaultroute | Flag | 是否将此接口作为默认路由出口（默认启用） |
| 路由度量值 | metric | Value | 数值越小优先级越高 |
| 对端DNS | peerdns | Flag | 是否使用对端分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| LCP Echo失败阈值 | _keepalive_failure | Value | 连续多少次Echo无响应后断开，0表示忽略 |
| LCP Echo间隔 | _keepalive_interval | Value | 每隔多少秒发送一次Echo请求，最小1秒 |
| 按需拨号 | demand | Value | 空闲多少秒后断开连接，0表示保持连接 |
| MTU | mtu | Value | 最大传输单元，默认1500 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| lcpFailureOption.cfgvalue(self, sectionName) | 从keepalive字段解析失败次数，格式: "failure_count interval" |
| lcpIntervalOption.cfgvalue(self, sectionName) | 从keepalive字段解析间隔时间 |
| lcpIntervalOption.write(self, sectionName, value) | 组合failure和interval写入keepalive字段 |

### Keepalive 格式说明

keepalive 字段格式: `"failure_count interval"`
- 例如: `"5 1"` 表示每1秒发送一次 LCP Echo，连续5次无响应则断开

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- LuCI CBI 框架组件: Value, Flag, DynamicList
- translate() 国际化函数
