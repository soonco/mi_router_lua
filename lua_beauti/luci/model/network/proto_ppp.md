# proto_ppp.lua - PPP协议族注册模块

## 工作原理

本模块向网络模型注册 PPP (Point-to-Point Protocol) 系列协议，包括多种基于 PPP 的网络连接协议。

**注册的协议:**
- `ppp`: 基础 PPP 拨号协议
- `pptp`: PPTP VPN 协议
- `pppoe`: PPPoE 宽带拨号协议
- `pppoa`: PPPoA (ATM上的PPP) 协议
- `3g`: 3G/UMTS/GPRS/EV-DO 移动网络协议
- `l2tp`: L2TP VPN 协议

**协议类继承:**
每个协议类继承自 `network.protocol` 基类，并重写特定方法以实现协议特有的行为。

## 接口

### 协议类方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| get_i18n(self) | - | string | 获取协议的国际化显示名称 |
| ifname(self) | - | string | 获取虚拟接口名称，格式: 协议名-配置节名 |
| opkg_package(self) | - | string | 获取协议所需的软件包名称 |
| is_installed(self) | - | boolean | 检查协议是否已安装 |
| is_floating(self) | - | boolean | 是否是浮动协议（不绑定物理接口） |
| is_virtual(self) | - | boolean | 是否是虚拟协议（所有PPP协议都是） |
| get_interfaces(self) | - | table/nil | 获取关联的物理接口列表 |
| contains_interface(self, interface) | interface: 接口对象 | boolean | 检查是否包含指定接口 |

### 协议显示名称映射

| 协议 | 显示名称 |
|------|---------|
| ppp | PPP |
| pptp | PPtP |
| pppoe | PPPoE |
| pppoa | PPPoATM |
| 3g | UMTS/GPRS/EV-DO |
| l2tp | L2TP |

### 协议软件包依赖

| 协议 | 软件包 |
|------|--------|
| ppp | ppp |
| pptp | ppp-mod-pptp |
| pppoe | ppp-mod-pppoe |
| pppoa | ppp-mod-pppoa |
| 3g | comgt |
| l2tp | xl2tpd |

### 安装检测方式

| 协议 | 检测文件 |
|------|---------|
| pppoa | /usr/lib/pppd/*/pppoatm.so |
| pppoe | /usr/lib/pppd/*/rp-pppoe.so |
| pptp | /usr/lib/pppd/*/pptp.so |
| 3g | /lib/netifd/proto/3g.sh |
| l2tp | /lib/netifd/proto/l2tp.sh |
| ppp | /lib/netifd/proto/ppp.sh |

### 浮动协议说明

- **浮动协议**: 不绑定到特定物理接口
- **非浮动协议**: PPPoE 是唯一非浮动的 PPP 协议（需要绑定以太网接口）

### 虚拟接口模式注册

每个协议都注册了虚拟接口名称模式: `^协议名-%w`

用于识别 PPP 虚拟接口名称，如 `pppoe-wan`、`l2tp-vpn` 等。

## 外部引用

- `luci.model.network`: 网络模型核心模块
- `nixio.fs`: 文件系统操作（检测协议安装状态）
- `luci.i18n`: 国际化模块
