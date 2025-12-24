# proto_pppoa.lua - PPPoA协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 PPPoA (PPP over ATM) 宽带拨号配置界面。

**核心特点:**
- PPPoA 是基于 ATM 网络的 PPP 封装协议
- 主要用于 ADSL 调制解调器的桥接模式
- 需要配置 ATM 虚电路参数 (VPI/VCI)
- 包含 LCP Echo 保活机制

**ATM 参数说明:**
- VPI (Virtual Path Identifier): 虚路径标识符，通常为 0 或 8
- VCI (Virtual Channel Identifier): 虚通道标识符，通常为 35
- 封装类型: VC-Mux 或 LLC，由 ISP 指定

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| ATM封装类型 | encaps | ListValue | VC-Mux(效率更高) 或 LLC(兼容性更好) |
| ATM设备编号 | atmdev | Value | 多个ADSL调制解调器时需要指定，默认0 |
| VCI | vci | Value | 虚通道标识符，常见值35(中国电信) |
| VPI | vpi | Value | 虚路径标识符，常见值0或8 |
| 用户名 | username | Value | PPP认证用户名（宽带账号） |
| 密码 | password | Value | PPP认证密码（宽带密码） |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| IPv6支持 | ipv6 | Flag | 启用PPP链路上的IPv6协商 |
| 默认网关 | defaultroute | Flag | 是否将此接口作为默认路由出口（默认启用） |
| 路由度量值 | metric | Value | 数值越小优先级越高 |
| 对端DNS | peerdns | Flag | 是否使用对端分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| LCP Echo失败阈值 | _keepalive_failure | Value | 连续多少次Echo无响应后断开 |
| LCP Echo间隔 | _keepalive_interval | Value | 每隔多少秒发送一次Echo请求 |
| 按需拨号 | demand | Value | 空闲多少秒后断开连接 |
| MTU | mtu | Value | 最大传输单元，PPPoA典型为1492或更小 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| lcpFailureOption.cfgvalue() | 从keepalive字段解析失败次数 |
| lcpIntervalOption.cfgvalue() | 从keepalive字段解析间隔时间 |
| lcpIntervalOption.write() | 组合failure和interval写入keepalive字段 |

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- LuCI CBI 框架组件: Value, Flag, ListValue, DynamicList
- translate() 国际化函数
