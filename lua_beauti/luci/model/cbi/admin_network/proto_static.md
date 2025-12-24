# proto_static.lua - 静态IP协议配置表单模块

## 工作原理

本模块是 LuCI CBI 框架的协议配置表单，为网络接口提供静态 IP 地址配置界面。

**核心特点:**
- 支持 IPv4 和 IPv6 双栈配置
- 适用于固定 IP 宽带或内网接口配置
- 提供完整的网络参数手动配置

**典型应用场景:**
- 企业固定 IP 宽带接入
- 服务器网络配置
- 路由器 LAN 口配置
- 内网 VLAN 接口配置

**配置存储:** `/etc/config/network`

## 接口

### 配置选项

#### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| IPv4地址 | ipaddr | Value | 接口的IPv4地址，必填项 |
| 子网掩码 | netmask | Value | 网络掩码，预设255.255.255.0等常用值 |
| 默认网关 | gateway | Value | IPv4默认路由的下一跳地址 |
| 广播地址 | broadcast | Value | 通常自动计算，特殊情况可手动指定 |
| DNS服务器 | dns | DynamicList | 可添加多个DNS服务器，支持IPv4和IPv6 |

#### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 接受RA | accept_ra | Flag | 接受上游路由器的IPv6 RA（静态配置默认禁用） |
| 发送RS | send_rs | Flag | 发送IPv6路由请求（默认禁用） |
| IPv6地址 | ip6addr | Value | 手动配置的IPv6地址，格式: 地址/前缀长度 |
| IPv6网关 | ip6gw | Value | IPv6默认路由的下一跳地址 |
| MAC地址克隆 | macaddr | Value | 用于替代接口真实MAC地址 |
| MTU | mtu | Value | 最大传输单元，默认1500 |
| 路由度量值 | metric | Value | 数值越小优先级越高 |

## 外部引用

- 父级 CBI Map 和 Section 对象（通过 `...` 传入）
- LuCI CBI 框架组件: Value, Flag, DynamicList
- translate() 国际化函数
