# XQWifiUtil.lua - WiFi工具模块

## 概述

`XQWifiUtil.lua` 是小米路由器WiFi管理的核心模块，提供全面的无线网络管理功能。支持多频段WiFi（2.4G、5G、5GH、6G）、频道管理、加密配置、设备管理、访客网络、WPS、WiFi中继、Mesh网络、WiFi 6等高级功能。这是整个系统中最复杂的工具模块之一。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────┐
│                       XQWifiUtil WiFi工具模块                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │                      多频段WiFi支持                             │  │
│  ├───────────┬───────────┬───────────┬───────────┬──────────────┤  │
│  │   2.4GHz  │   5GHz    │  5GHz-H   │   6GHz    │   Game WiFi  │  │
│  │  wifi0    │   wifi1   │   wifi2   │   wifi3   │  (游戏加速)   │  │
│  └─────┬─────┴─────┬─────┴─────┬─────┴─────┬─────┴──────┬───────┘  │
│        │           │           │           │            │           │
│        ▼           ▼           ▼           ▼            ▼           │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │                    UCI wireless 配置                           │  │
│  │  wifi-device: 物理设备配置 | wifi-iface: 接口配置              │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │                      功能模块                                   │  │
│  ├─────────────┬─────────────┬─────────────┬────────────────────┤  │
│  │  频道管理    │  加密配置    │  设备管理    │   高级功能          │  │
│  │ 各国频道表   │ PSK/WPA3    │ 连接设备列表 │ BSD/WPS/Mesh/TWT   │  │
│  └─────────────┴─────────────┴─────────────┴────────────────────┘  │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘

WiFi 配置层次:
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ wifi-device  │───▶│ wifi-iface   │───▶│   网络接口    │
│ 物理无线设备  │    │ 虚拟WiFi接口  │    │  lan/guest   │
│ channel/txpwr│    │ ssid/key/enc │    │              │
└──────────────┘    └──────────────┘    └──────────────┘

频道与带宽配置:
┌──────────────────────────────────────────────────────────────┐
│  2.4GHz: 1-13频道 | 20/40MHz带宽                              │
│  5GHz:   36-165频道 | 20/40/80/160MHz带宽                     │
│  6GHz:   WiFi 6E专用频段                                      │
└──────────────────────────────────────────────────────────────┘
```

## 接口列表

### 初始化与基础信息

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `init()` | 无 | 无 | 初始化WiFi接口配置 |
| `getWifiNames()` | 无 | `uciCursor, wifiIface2G` | 获取WiFi接口名称 |
| `getWifiDevNames()` | 无 | `table` | 获取WiFi设备名称列表 |
| `get_wlan_count()` | 无 | `number` | 获取无线接口数量 |
| `get_wlan_ifname()` | 无 | `table` | 获取无线接口名称列表 |
| `get_wlan_wifi5_ifname()` | 无 | `table` | 获取WiFi5备用接口名称列表 |
| `get_wlan_guest_ifname()` | 无 | `table` | 获取访客网络接口名称列表 |
| `getGameWifiSupport()` | 无 | `boolean` | 检查是否支持游戏WiFi |
| `get5G2BandSuffix()` | 无 | `string` | 获取第二个5G频段后缀名 |

### WiFi网络信息

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `wifiNetworks()` | 无 | `table` | 获取所有WiFi网络信息 |
| `wifiNetwork(wifiName)` | `wifiName: string` | `table` | 获取单个WiFi网络信息 |
| `getWifissid()` | 无 | `string...` | 获取WiFi SSID列表 |
| `getWifiBssid()` | 无 | `string...` | 获取WiFi BSSID(MAC地址) |
| `getGuestWifiBssid()` | 无 | `string\|nil` | 获取访客WiFi的BSSID |
| `getAllWifiInfo()` | 无 | `table` | 获取所有WiFi信息 |
| `getDiagAllWifiInfo()` | 无 | `table` | 获取诊断用的所有WiFi信息 |
| `getWifiStatus(wifiIndex)` | `wifiIndex: number` | `table` | 获取WiFi状态 |
| `getWifiTxpwr(wifiIndex)` | `wifiIndex: number` | `string` | 获取WiFi发射功率 |
| `getWifiChannel(wifiIndex)` | `wifiIndex: number` | `string` | 获取WiFi频道 |
| `getWifiWorkChannel(wifiIndex)` | `wifiIndex: number` | `string` | 获取WiFi工作频道 |

### 频道管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getChannels(wifiIndex)` | `wifiIndex: number` | `table` | 获取可用频道列表 |
| `getDefaultWifiChannels(wifiIndex)` | `wifiIndex: number` | `table` | 获取默认WiFi频道列表 |
| `verfiyChannelByWlIndex(wifiIndex, channel)` | `wifiIndex: number, channel: string` | `boolean` | 验证频道是否有效 |
| `channelHelper(channel)` | `channel: string` | `table` | 频道辅助函数，解析频道和带宽 |
| `channelFormat(wifiIndex, channel, bandwidth)` | `wifiIndex, channel, bandwidth` | `string\|false` | 格式化频道配置 |
| `getBandList(channel, ifname)` | `channel, ifname: string` | `table` | 获取指定频道的可用带宽列表 |

### 设备管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getWifiAllDeviceMacList()` | 无 | `table` | 获取所有WiFi设备的MAC地址列表 |
| `getWifiConnectDeviceList(wifiIndex)` | `wifiIndex: number` | `table` | 获取指定WiFi的连接设备列表 |
| `get_wl_con_dev_num(wifiIndex)` | `wifiIndex: number` | `number` | 获取指定WiFi的连接设备数量 |
| `getAllWifiConnetDeviceList()` | 无 | `table` | 获取所有WiFi连接设备列表 |
| `getAllWifiConnetDeviceDict()` | 无 | `table` | 获取所有WiFi连接设备字典 |
| `getDeviceWifiIndex(mac)` | `mac: string` | `number\|nil` | 根据MAC地址获取设备所连接的WiFi索引 |

### 信号与速度

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getWifiDeviceSignalDict(wifiIndex)` | `wifiIndex: number` | `table` | 获取WiFi设备信号强度字典 |
| `getWifiDeviceSignal(mac)` | `mac: string` | `number\|nil` | 获取指定设备的WiFi信号强度 |
| `getWifiDeviceSpeed(mac)` | `mac: string` | `table\|nil` | 获取指定设备的WiFi速度 |

### IoT WiFi

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getIotWifiDeviceInfo()` | 无 | `table\|nil` | 获取IoT WiFi设备信息 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.XQCountryCode` | 国家代码处理 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `luci.model.network` | 网络模型 |
| `luci.model.uci` | UCI配置接口 |
| `luci.util` | LuCI工具函数 |
| `iwinfo` | 无线信息接口 |

## 被引用情况

该模块被以下模块引用：
- `luci/controller/api/xqnetwork.lua` - 网络API控制器
- `luci/controller/api/misystem.lua` - 系统API接口
- `xiaoqiang/util/XQSysUtil.lua` - 系统工具
- `xiaoqiang/util/XQDeviceUtil.lua` - 设备工具
- `xiaoqiang/module/XQWifiShare.lua` - WiFi分享模块
- 其他多个控制器和模块

## 关键代码说明

### 各国频道列表
```lua
CHANNEL_LIST_2G_5G = {
    CN = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 149 153 157 161 165"},
    TW = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
    US = {"0 1 2 3 4 5 6 7 8 9 10 11", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"},
    EU = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
    JP = {"0 1 2 3 4 5 6 7 8 9 10 11 12 13", "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"},
    -- ... 更多国家
}
```

### 频道带宽映射
```lua
-- 2.4GHz 频道映射
CHANNEL_2G_MAP = {
    ["1"] = {["20"] = "1", ["40"] = "1l"},  -- l=lower, u=upper
    ["6"] = {["20"] = "6", ["40"] = "6l"},
    ["11"] = {["20"] = "11", ["40"] = "11u"},
    -- ...
}

-- 5GHz 频道映射
CHANNEL_5G_MAP = {
    ["36"] = {["20"] = "36", ["40"] = "36l", ["80"] = "36/80"},
    ["149"] = {["20"] = "149", ["40"] = "149l", ["80"] = "149/80"},
    ["165"] = {["20"] = "165"},  -- 165只支持20MHz
    -- ...
}
```

### 带宽选项
```lua
BANDWIDTH_OPTIONS = {
    {"20"},                    -- 仅20MHz
    {"20", "40"},              -- 20/40MHz
    {"20", "40", "80"},        -- 20/40/80MHz
    {"20", "40", "80", "160"}  -- 20/40/80/160MHz
}
```

### WiFi网络信息结构
```lua
-- wifiNetwork() 返回结构
{
    id = "wifi0.network1",
    name = "wlan0",
    up = true,
    mode = "Master",
    ssid = "MiWiFi",
    bssid = "AA:BB:CC:DD:EE:FF",
    encryption = "psk2+ccmp",
    frequency = "2.4GHz",
    channel = 6,
    bw = "40",
    signal = -50,
    quality = 80,
    noise = -95,
    bitrate = 300000,
    ifname = "wlan0",
    assoclist = {...},  -- 连接设备列表
    country = "CN",
    txpower = 20,
    key = "password",
    hidden = "0",
    txpwr = "max",
    bsd = "1",          -- 双频合一
    txbf = "1",         -- 波束成形
    ax = "1",           -- WiFi 6
    sae = "1",          -- WPA3
    -- ...
}
```

### 加密方式
```lua
-- 支持的加密方式
-- "none"       - 无加密
-- "psk"        - WPA-PSK (TKIP)
-- "psk2"       - WPA2-PSK (AES)
-- "mixed-psk"  - WPA/WPA2混合
-- "wep-open"   - WEP开放
-- "ccmp"       - WPA3-SAE
-- "psk2+ccmp"  - WPA2/WPA3混合
```

### IoT WiFi配置
```lua
-- IoT WiFi用于智能设备连接
-- 自动生成SSID: 主WiFi名称 + "_IoT" 或 "_IoT_5G"
-- 密码: 主WiFi密码 + "iot"
```

## 使用示例

```lua
local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
XQWifiUtil.init()

-- 获取所有WiFi信息
local allWifi = XQWifiUtil.getAllWifiInfo()
for i, wifi in ipairs(allWifi) do
    print(string.format("WiFi %d: %s, Channel: %s, Status: %s",
        i, wifi.ssid, wifi.channel, wifi.status))
end

-- 获取连接设备
local devices = XQWifiUtil.getAllWifiConnetDeviceList()
for _, device in ipairs(devices) do
    print(string.format("MAC: %s, Signal: %d, Band: %d",
        device.mac, device.signal or 0, device.wifiIndex))
end

-- 获取可用频道
local channels = XQWifiUtil.getDefaultWifiChannels(1)  -- 2.4GHz
for _, ch in ipairs(channels) do
    print(string.format("Channel: %d, Bandwidth: %s",
        ch.c, table.concat(ch.b, "/")))
end
```

## 支持的国家/地区代码

CN, TW, HK, EU, UK, AS, JP, KR, US, ID, IN, DE, GB, MY, RU, UA, EG, IL, MA, AZ, KZ, UZ, NG, TN
