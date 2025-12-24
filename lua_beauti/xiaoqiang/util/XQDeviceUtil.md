# XQDeviceUtil.lua - 设备工具模块

## 概述

`XQDeviceUtil` 模块是路由器设备管理的核心工具，提供设备信息获取、设备列表管理、网络统计、DHCP 租约查询等功能。该模块通过 trafficd 服务获取实时设备数据，并整合数据库、DHCP、设备识别等多个数据源。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    设备管理数据流                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   数据源层                            │  │
│  │  trafficd  │  DHCP租约  │  数据库  │  设备识别库     │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                 │
│                           ▼                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  XQDeviceUtil                         │  │
│  │  数据聚合 + 设备识别 + 权限查询 + 统计计算           │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                 │
│            ┌──────────────┼──────────────┐                  │
│            ▼              ▼              ▼                  │
│     ┌──────────┐   ┌──────────┐   ┌──────────┐             │
│     │ 设备列表 │   │ 网络统计 │   │ 设备详情 │             │
│     │  V1/V2   │   │ WAN/LAN  │   │ 权限信息 │             │
│     └──────────┘   └──────────┘   └──────────┘             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 设备列表

#### getDeviceList(onlineOnly, wifiOnly)

获取设备列表（V1 版本）。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| onlineOnly | boolean | 是否只获取在线设备 |
| wifiOnly | boolean | 是否只获取 WiFi 设备 |

**返回值:** 设备列表，包含 IP、MAC、名称、类型、权限、统计等信息

---

#### getDeviceListV2(onlineOnly, includeOffline, mloEnabled)

获取设备列表（V2 增强版）。

---

#### getDeviceListV3(deviceId)

获取设备列表（V3 带 QoS 信息）。

---

### 设备信息

#### getDeviceInfo(mac, withAuthority)

获取单个设备详细信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| mac | string | MAC 地址 |
| name | string | 设备名称 |
| dhcpname | string | DHCP 名称 |
| type | table | 设备类型 {c, p, n} |
| owner | string | 设备所有者 |
| authority | table | 权限信息（如果 withAuthority=true） |
| push | number | 推送状态 |
| times | number | 认证失败次数 |

---

#### getDeviceCompany(mac)

根据 MAC 地址获取设备厂商信息。

---

#### getDevicesName(macList)

批量获取设备名称。

---

### DHCP 租约

#### getDHCPList()

获取 DHCP 租约列表。

**返回值:** `[{mac, ip, name}, ...]`

---

#### getDHCPDict() / getDHCPIpDict()

获取 DHCP 字典（以 MAC 或 IP 为键）。

---

### 网络统计

#### getWanLanNetworkStatistics(interface)

获取 WAN/LAN 网络统计信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| upload | string | 上传总量 |
| upspeed | string | 上传速度 |
| download | string | 下载总量 |
| downspeed | string | 下载速度 |
| maxuploadspeed | string | 最大上传速度 |
| maxdownloadspeed | string | 最大下载速度 |

---

#### getDevNetStatisticsList() / getDevNetStatisticsDict()

获取设备网络统计列表/字典。

---

### 设备计数

#### getDeviceCount()

获取设备总数。

**返回值:** 在线数, 历史数, 在线非 AP 数, 历史非 AP 数

---

#### get2g5gDeviceCount()

获取 2.4G 和 5G 设备数量。

---

#### getMeshDeviceCount()

获取 Mesh 设备数量。

---

#### getConnectDeviceCount()

获取已连接设备数量。

---

### 权限管理

#### getDevicesPermissions(macList)

获取设备权限信息。

**返回值:** 以 MAC 为键的权限字典 `{wan, lan, admin, pridisk}`

---

### 数据库操作

#### saveDeviceName(mac, nickname, owner, device)

保存设备名称。

---

#### saveDeviceInfo(mac, owner, device)

保存设备信息到 UCI 配置。

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.XQEquipment | 设备识别库 |
| xiaoqiang.util.XQDBUtil | 数据库工具 |
| xiaoqiang.util.XQWifiUtil | WiFi 工具 |
| xiaoqiang.util.XQLanWanUtil | LAN/WAN 工具 |
| xiaoqiang.util.XQPushUtil | 推送工具 |
| xiaoqiang.module.XQFirewall | 防火墙模块 |
| luci.model.uci | UCI 配置管理 |
| cjson | JSON 解析 |
| trafficd | 流量控制服务（通过 ubus） |
| miqos | QoS 模块 |

## 被引用情况

- 设备管理 API 控制器
- 路由器状态模块 (`XQRouterStatus`)
- 网络拓扑模块 (`XQTopology`)
- 家长控制模块
- 移动端 APP 设备管理

## 关键代码说明

### trafficd 数据获取

```lua
local output = LuciUtil.exec("ubus call trafficd hw")
local trafficData = cjson.decode(output)
```

通过 ubus 调用 trafficd 服务获取实时设备流量和连接状态。

### 设备识别流程

```lua
local identified = XQEquipment.identifyDevice(mac, dhcpName)
local deviceType = identified.type
-- type.c: 设备类别
-- type.p: 设备平台
-- type.n: 设备名称
```

### 设备名称优先级

1. 用户设置的昵称 (nickname)
2. 设备类型名称 (type.n)
3. DHCP 名称 (dhcpname)
4. 厂商识别名称 (identified.name)
5. MAC 地址

### 连接类型判断

```lua
if ifname:match("eth") then
    connectionType = "line"  -- 有线连接
elseif wlanIfname[1] and ifname == wlanIfname[1] then
    connectionType = "wifi"
    port = 1  -- 2.4G
elseif wlanIfname[2] and ifname == wlanIfname[2] then
    connectionType = "wifi"
    port = 2  -- 5G
end
```
