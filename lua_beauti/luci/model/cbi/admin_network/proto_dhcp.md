# proto_dhcp.lua - DHCP客户端协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供 DHCP 客户端协议的配置界面。

**核心特点:**
- 支持 IPv4 DHCP 自动获取 IP 地址
- 支持 IPv6 相关配置 (RA/RS)
- 提供高级选项如 MTU、Metric、MAC 地址克隆等
- 通过 `...` 接收父级 Map 和 Section 对象

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 主机名 | hostname | Value | 发送给DHCP服务器的主机名，用于动态DNS注册 |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 接受RA | accept_ra | Flag | 接受上游路由器的IPv6路由通告（默认启用） |
| 发送RS | send_rs | Flag | 主动发送路由请求以快速获取IPv6配置（默认启用） |
| 广播标志 | broadcast | Flag | 某些ISP要求客户端设置广播标志 |
| 默认网关 | defaultroute | Flag | 是否将此接口作为默认路由出口（默认启用） |
| 对端DNS | peerdns | Flag | 是否使用DHCP服务器分配的DNS（默认启用） |
| 自定义DNS | dns | DynamicList | 仅当peerdns未启用时显示 |
| 路由度量值 | metric | Value | 数值越小优先级越高，用于多WAN负载均衡 |
| 客户端ID | clientid | Value | 某些ISP要求特定的客户端标识符 |
| 厂商类标识 | vendorid | Value | DHCP Option 60，某些ISP用于识别设备类型 |
| MAC地址克隆 | macaddr | Value | 用于替代WAN口真实MAC地址 |
| MTU | mtu | Value | 最大传输单元，默认1500 |

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- `luci.sys`: 系统工具模块（获取当前主机名）
- LuCI CBI 框架组件: Value, Flag, DynamicList
- translate() 国际化函数
