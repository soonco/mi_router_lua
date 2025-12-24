# XQVPNUtil.lua - VPN工具模块

## 概述

`XQVPNUtil.lua` 是小米路由器的VPN连接配置和管理模块，支持PPTP和L2TP协议的VPN连接。提供VPN配置的增删改查、连接控制、智能VPN分流等功能，允许路由器作为VPN客户端连接到远程VPN服务器。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                      XQVPNUtil 模块                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   VPN 配置管理                           │    │
│  ├─────────────┬─────────────┬─────────────┬──────────────┤    │
│  │   addVPN    │   editVPN   │   delVPN    │  getVPNList  │    │
│  │   添加配置   │   编辑配置   │   删除配置   │   获取列表    │    │
│  └──────┬──────┴──────┬──────┴──────┬──────┴──────┬───────┘    │
│         │             │             │             │             │
│         ▼             ▼             ▼             ▼             │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              UCI 配置存储                                │    │
│  │  vpnlist: VPN配置列表 | network: 网络接口配置            │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   VPN 连接控制                           │    │
│  ├─────────────────────┬───────────────────────────────────┤    │
│  │     vpnSwitch       │           vpnStatus               │    │
│  │   开启/关闭连接      │          获取连接状态              │    │
│  └──────────┬──────────┴──────────────┬────────────────────┘    │
│             │                         │                         │
│             ▼                         ▼                         │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │           PPTP / L2TP 客户端服务                         │    │
│  │           (pppd / xl2tpd)                                │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   智能 VPN 分流                          │    │
│  ├─────────────────────┬───────────────────────────────────┤    │
│  │   域名/IP分流        │         设备分流                   │    │
│  │  proxy.txt列表       │        MAC地址列表                 │    │
│  └─────────────────────┴───────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘

VPN 连接流程:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 选择配置  │───▶│ 建立连接  │───▶│ 认证验证  │───▶│ 隧道建立  │
│ vpnSwitch│    │ PPTP/L2TP│    │ 用户名密码 │    │ 路由配置  │
└──────────┘    └──────────┘    └──────────┘    └──────────┘

智能VPN分流:
┌──────────┐    ┌──────────┐    ┌──────────┐
│ 流量请求  │───▶│ 规则匹配  │───▶│ 路由选择  │
│          │    │ 域名/设备 │    │ VPN/直连  │
└──────────┘    └──────────┘    └──────────┘
```

## 接口列表

### VPN配置管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `addVPN(oname, server, username, password, proto, auth, old_id)` | 见下 | `boolean` | 添加VPN配置 |
| `editVPN(vpn_id, oname, server, username, password, proto)` | 见下 | `boolean` | 编辑VPN配置 |
| `delVPN(vpn_id)` | `vpn_id: string` | `boolean` | 删除VPN配置 |
| `getVPNList()` | 无 | `table` | 获取VPN配置列表 |
| `getVPNInfo(vpn_name)` | `vpn_name: string` | `table` | 获取VPN配置信息 |
| `setVpn(name, server, username, password, proto, vpn_id, auto, auth)` | 见下 | `boolean` | 设置VPN配置到网络接口 |
| `setVpnAuto(auto)` | `auto: number` | `boolean` | 设置VPN自动连接 |

### VPN连接控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `vpnSwitch(enable, vpn_id)` | `enable: boolean, vpn_id: string` | `number` | VPN开关控制 |
| `vpnStatus()` | 无 | `table\|nil` | 获取VPN连接状态 |
| `checkVPNServerIp(ip, netmask)` | `ip, netmask: string` | `boolean` | 检查VPN服务器IP有效性 |
| `getVpnBindWan()` | 无 | `string` | 获取VPN绑定的WAN接口 |

### 智能VPN

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getSmartVPNInfo()` | 无 | `table` | 获取智能VPN信息 |
| `setSmartVPN(switch_on, mode)` | `switch_on, mode: number` | 无 | 设置智能VPN |
| `getProxyList()` | 无 | `table\|nil` | 获取代理列表（域名/IP） |
| `updateProxyList(proxy_list)` | `proxy_list: table\|string` | 无 | 更新代理列表 |
| `getDeviceList()` | 无 | `table` | 获取设备列表（MAC地址） |

### 小米VPN

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `mivpnInfo()` | 无 | `number` | 获取小米VPN信息 |
| `mivpnSwitch(enable)` | `enable: boolean` | `boolean` | 小米VPN开关 |
| `setMiVPN(enable)` | `enable: number` | 无 | 设置小米VPN |

### 工具函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `merge(list1, list2, operation)` | `list1, list2: table, operation: string` | `table` | 合并列表 |
| `urlFormat(url)` | `url: string` | `string` | 格式化URL |

### 参数说明

#### addVPN / setVpn 参数
- `oname` - VPN配置名称
- `server` - VPN服务器地址
- `username` - 用户名
- `password` - 密码
- `proto` - 协议类型 ("PPTP" / "L2TP")
- `auth` - 认证方式 ("auto" / "pap" / "chap" / "mschap" / "mschap-v2")
- `vpn_id` - VPN配置ID（MD5哈希）
- `auto` - 是否自动连接 ("0" / "1")

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量（VPN命令路径） |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（MD5生成VPN ID） |
| `xiaoqiang.XQFeatures` | 功能特性检测 |
| `xiaoqiang.module.XQMultiWanPolicy` | 多WAN策略 |
| `luci.model.uci` | UCI配置接口 |
| `luci.model.firewall` | 防火墙配置 |
| `luci.ip` | IP地址处理 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `nixio.fs` | 文件系统操作 |
| `ubus` | ubus通信 |
| `json` | JSON处理 |

### XQConfigs 中使用的常量
- `VPN_ENABLE` - VPN启用命令
- `VPN_DISABLE` - VPN禁用命令
- `VPN_STATUS` - VPN状态查询命令
- `RM_VPNSTATUS_FILE` - 删除VPN状态文件
- `SET_VPN_USER_OPTION` - 设置VPN用户选项

## 被引用情况

该模块被以下模块引用：
- `luci/controller/api/xqnetwork.lua` - 网络API控制器
- VPN配置Web界面

## 关键代码说明

### VPN ID生成
```lua
-- VPN ID通过服务器、用户名、协议的MD5哈希生成
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
vpn_id = XQCryptoUtil.md5Str(server .. username .. proto)
```

### VPN配置结构
```lua
local vpn_config = {
    proto = string.lower(proto),  -- "pptp" 或 "l2tp"
    server = server,               -- VPN服务器地址
    username = username,           -- 用户名
    password = password,           -- 密码
    auth = auth,                   -- 认证方式
    id = vpn_id,                   -- VPN配置ID
    auto = auto,                   -- 自动连接
    trafficall = trafficall,       -- 是否所有流量走VPN
    checkup_interval = "5"         -- 连接检查间隔
}
```

### 智能VPN模式
```lua
-- mode = 1: 域名/IP分流模式
-- 根据proxy.txt中的域名和IP列表决定是否走VPN
-- mode = 2: 设备分流模式
-- 根据MAC地址列表决定哪些设备的流量走VPN
```

### 代理列表格式
```lua
-- /etc/smartvpn/proxy.txt 文件格式
-- 域名以.开头: .google.com
-- IP地址直接写: 8.8.8.8
```

### VPN服务器IP验证
```lua
function checkVPNServerIp(ip, netmask)
    -- 排除链路本地地址 169.254.x.x
    -- 排除回环地址 127.0.0.1
    -- 排除广播和多播地址
    local link_local_start = luci_ip.iptonl("169.254.0.0")
    local link_local_end = luci_ip.iptonl("169.254.255.255")
    ...
end
```

## 使用示例

```lua
local XQVPNUtil = require("xiaoqiang.util.XQVPNUtil")

-- 添加VPN配置
XQVPNUtil.addVPN(
    "公司VPN",           -- 名称
    "vpn.company.com",   -- 服务器
    "user",              -- 用户名
    "password",          -- 密码
    "L2TP",              -- 协议
    "auto"               -- 认证方式
)

-- 获取VPN列表
local vpnList = XQVPNUtil.getVPNList()

-- 连接VPN
XQVPNUtil.vpnSwitch(true, vpnList[1].id)

-- 检查连接状态
local status = XQVPNUtil.vpnStatus()
if status then
    print("VPN已连接")
end

-- 启用智能VPN（域名分流模式）
XQVPNUtil.setSmartVPN(1, 1)

-- 更新代理列表
XQVPNUtil.updateProxyList({".google.com", ".youtube.com", "8.8.8.8"})
```
