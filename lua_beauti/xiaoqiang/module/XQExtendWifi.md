# XQExtendWifi.lua - 扩展WiFi模块

## 概述

XQExtendWifi 是小米路由器的扩展WiFi管理模块，用于管理WiFi扩展和中继功能。该模块支持多种扩展模式（中继、桥接、WISP），提供WiFi网络扫描、扩展模式配置、连接状态查询等功能，同时支持Mesh网络中的扩展器列表管理。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       XQExtendWifi 扩展WiFi模块                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        扩展模式                                   │   │
│  │                                                                   │   │
│  │   ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │   │
│  │   │  DISABLED  │  │  REPEATER  │  │   BRIDGE   │  │    WISP    │ │   │
│  │   │    (0)     │  │    (1)     │  │    (2)     │  │    (3)     │ │   │
│  │   │            │  │            │  │            │  │            │ │   │
│  │   │   禁用     │  │  中继模式  │  │  桥接模式  │  │  WISP模式  │ │   │
│  │   └────────────┘  └────────────┘  └────────────┘  └────────────┘ │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        网络拓扑                                   │   │
│  │                                                                   │   │
│  │   ┌──────────────┐                    ┌──────────────┐           │   │
│  │   │   上级路由器  │                    │   本机路由器  │           │   │
│  │   │              │    WiFi连接        │              │           │   │
│  │   │  (Internet)  │ ◄────────────────► │  (apcli0)    │           │   │
│  │   │              │                    │              │           │   │
│  │   └──────────────┘                    └──────────────┘           │   │
│  │                                              │                    │   │
│  │                                              │ 本地WiFi           │   │
│  │                                              ▼                    │   │
│  │                                       ┌──────────────┐           │   │
│  │                                       │   客户端     │           │   │
│  │                                       └──────────────┘           │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### WiFi扫描与连接流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    WiFi扫描与连接流程                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   1. 扫描可用网络                                               │
│      scanWifiNetworks(band)                                     │
│      ├─ iwlist wl0 scan (2.4G)                                 │
│      └─ iwlist wl1 scan (5G)                                   │
│                                                                  │
│   2. 解析扫描结果                                               │
│      ├─ SSID                                                    │
│      ├─ Signal level                                            │
│      ├─ Encryption                                              │
│      ├─ Channel                                                 │
│      └─ BSSID                                                   │
│                                                                  │
│   3. 设置扩展模式                                               │
│      setExtendMode(mode, ssid, password, encryption, bssid)    │
│      ├─ 配置 apcli0 接口                                       │
│      └─ 重启网络服务                                            │
│                                                                  │
│   4. 检查连接状态                                               │
│      getConnectionStatus()                                       │
│      └─ iwconfig apcli0                                         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### 信息查询

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getExtendWifiInfo()` | 无 | `info:table` 扩展WiFi配置信息 | 获取扩展WiFi信息 |
| `getConnectionStatus()` | 无 | `status:table` 连接状态信息 | 获取扩展器连接状态 |
| `getExtenderList()` | 无 | `list:table` 扩展器列表 | 获取Mesh网络中的扩展器列表 |

### 网络扫描

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `scanWifiNetworks(band)` | `band:string` 频段("2.4"或"5") | `networks:table` WiFi网络列表 | 扫描可用的WiFi网络 |

### 模式配置

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setExtendMode(mode, ssid, password, encryption, bssid)` | `mode:number` 扩展模式, `ssid:string`, `password:string`, `encryption:string`, `bssid:string` 可选 | `errorCode:number` 0=成功 | 设置WiFi扩展模式 |

### 连接控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `disconnectExtendWifi()` | 无 | `errorCode:number` 0=成功 | 断开扩展WiFi连接 |
| `reconnectExtendWifi()` | 无 | `errorCode:number` 0=成功 | 重新连接扩展WiFi |

## 扩展模式常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `EXTEND_MODE_DISABLED` | 0 | 禁用扩展模式 |
| `EXTEND_MODE_REPEATER` | 1 | 中继模式 |
| `EXTEND_MODE_BRIDGE` | 2 | 桥接模式 |
| `EXTEND_MODE_WISP` | 3 | WISP模式 |

## 数据结构

### 扩展WiFi信息

```lua
{
    mode = 1,                          -- 扩展模式
    uplink_ssid = "UpperRouter",       -- 上级WiFi SSID
    uplink_encryption = "psk2",        -- 上级WiFi加密方式
    connected = 1,                     -- 连接状态 (0/1)
    uplink_ip = "192.168.1.1"          -- 上级路由器IP
}
```

### WiFi网络扫描结果

```lua
{
    {
        ssid = "NetworkName",          -- 网络名称
        signal = -55,                  -- 信号强度 (dBm)
        encrypted = true,              -- 是否加密
        channel = 6,                   -- 频道
        bssid = "AA:BB:CC:DD:EE:FF"    -- BSSID
    },
    -- ...
}
```

### 连接状态

```lua
{
    connected = 1,                     -- 连接状态 (0/1)
    ap_mac = "AA:BB:CC:DD:EE:FF",      -- 上级AP的MAC地址
    signal = -55,                      -- 信号强度 (dBm)
    rate = 300                         -- 连接速率 (Mbps)
}
```

### 扩展器列表

```lua
{
    {
        mac = "AA:BB:CC:DD:EE:FF",     -- MAC地址
        ip = "192.168.31.100",         -- IP地址
        name = "扩展器1",              -- 设备名称
        model = "R3600",               -- 设备型号
        online = 1,                    -- 在线状态 (0/1)
        signal = -55                   -- 信号强度
    },
    -- ...
}
```

## 外部依赖

| 模块 | 用途 |
|------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具(Mesh节点) |
| `luci.model.uci` | UCI配置管理 |
| `luci.util` | 命令执行 |

## 被引用情况

该模块主要被以下组件引用：
- WiFi扩展设置界面
- XQExWifiConfSync WiFi配置同步模块
- Mesh网络管理
- 小米WiFi APP

## 关键代码说明

### WiFi网络扫描

```lua
function scanWifiNetworks(band)
    local result = {}
    
    -- 确定扫描接口
    local interface = "wl0"
    if band == "5" then
        interface = "wl1"
    end
    
    -- 执行扫描命令
    local scanCmd = string.format("iwlist %s scan 2>/dev/null", interface)
    local scanOutput = luciUtil.exec(scanCmd)
    
    if scanOutput and #scanOutput > 0 then
        local currentNetwork = nil
        
        for line in scanOutput:gmatch("[^\r\n]+") do
            -- 匹配SSID
            local ssid = line:match('ESSID:"([^"]*)"')
            if ssid then
                if currentNetwork then
                    table.insert(result, currentNetwork)
                end
                currentNetwork = {ssid = ssid}
            end
            
            -- 匹配信号强度
            local signal = line:match("Signal level[=:](-?%d+)")
            if signal and currentNetwork then
                currentNetwork.signal = tonumber(signal)
            end
            
            -- 匹配加密方式、频道、BSSID...
        end
        
        if currentNetwork then
            table.insert(result, currentNetwork)
        end
    end
    
    return result
end
```

### 设置扩展模式

```lua
function setExtendMode(mode, ssid, password, encryption, bssid)
    local cursor = uci.cursor()
    
    -- 禁用扩展模式
    if mode == EXTEND_MODE_DISABLED then
        cursor:set("xiaoqiang", "common", "EXTEND_MODE", "0")
        cursor:delete("wireless", "apcli0")
        cursor:commit("xiaoqiang")
        cursor:commit("wireless")
        XQFunction.forkExec("/etc/init.d/network restart")
        return 0
    end
    
    -- 设置扩展模式
    cursor:set("xiaoqiang", "common", "EXTEND_MODE", tostring(mode))
    
    -- 配置apcli接口
    cursor:set("wireless", "apcli0", "wifi-iface")
    cursor:set("wireless", "apcli0", "device", "mt7612")
    cursor:set("wireless", "apcli0", "mode", "sta")
    cursor:set("wireless", "apcli0", "network", "lan")
    cursor:set("wireless", "apcli0", "ssid", ssid)
    
    if not XQFunction.isStrNil(password) then
        cursor:set("wireless", "apcli0", "key", password)
    end
    
    if not XQFunction.isStrNil(encryption) then
        cursor:set("wireless", "apcli0", "encryption", encryption)
    else
        cursor:set("wireless", "apcli0", "encryption", "psk2")
    end
    
    if not XQFunction.isStrNil(bssid) then
        cursor:set("wireless", "apcli0", "bssid", bssid)
    end
    
    cursor:commit("xiaoqiang")
    cursor:commit("wireless")
    
    XQFunction.forkExec("/etc/init.d/network restart")
    
    return 0
end
```

### 连接状态检查

```lua
function getConnectionStatus()
    local result = {}
    
    -- 检查apcli接口状态
    local statusCmd = "iwconfig apcli0 2>/dev/null"
    local statusOutput = luciUtil.exec(statusCmd)
    
    if statusOutput and #statusOutput > 0 then
        -- 检查是否已连接
        if statusOutput:match("Access Point: ([%x:]+)") then
            result.connected = 1
            result.ap_mac = statusOutput:match("Access Point: ([%x:]+)")
        else
            result.connected = 0
        end
        
        -- 获取信号强度
        local signal = statusOutput:match("Signal level[=:](-?%d+)")
        if signal then
            result.signal = tonumber(signal)
        end
        
        -- 获取连接速率
        local rate = statusOutput:match("Bit Rate[=:](%d+)")
        if rate then
            result.rate = tonumber(rate)
        end
    else
        result.connected = 0
    end
    
    return result
end
```

## UCI配置项

| 配置路径 | 说明 |
|----------|------|
| `xiaoqiang.common.EXTEND_MODE` | 扩展模式 |
| `xiaoqiang.common.EXTEND_CONNECTED` | 连接状态 |
| `xiaoqiang.common.EXTEND_UPLINK_IP` | 上级路由器IP |
| `wireless.apcli0.*` | apcli接口配置 |
