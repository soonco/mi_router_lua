# XQExWifiConfSyncUci.lua - WiFi配置同步UCI模块

## 概述

XQExWifiConfSyncUci 是小米路由器WiFi配置同步的UCI操作模块。该模块负责处理主路由器与子路由器之间的配置合并，包括网络配置(network)、DHCP配置、防火墙配置(firewall)和无线配置(wireless)的智能合并，以及热点信息和硬件信息的获取。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    XQExWifiConfSyncUci UCI配置合并模块                   │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                     配置合并流程                                  │   │
│  │                                                                   │   │
│  │   源配置 (主路由器)              目标配置 (子路由器)              │   │
│  │   ┌────────────────┐            ┌────────────────┐               │   │
│  │   │  network       │            │  network       │               │   │
│  │   │  dhcp          │    ───►    │  dhcp          │               │   │
│  │   │  firewall      │   合并     │  firewall      │               │   │
│  │   │  wireless      │            │  wireless      │               │   │
│  │   └────────────────┘            └────────────────┘               │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                     合并策略                                      │   │
│  │                                                                   │   │
│  │   ┌────────────┐  ┌────────────┐  ┌────────────┐                 │   │
│  │   │ 接口过滤   │  │ 设备过滤   │  │ Zone过滤   │                 │   │
│  │   │ interface  │  │ device     │  │ zone       │                 │   │
│  │   │            │  │ bridge-vlan│  │ forwarding │                 │   │
│  │   └────────────┘  └────────────┘  └────────────┘                 │   │
│  │         │               │               │                         │   │
│  │         └───────────────┼───────────────┘                         │   │
│  │                         │                                         │   │
│  │                         ▼                                         │   │
│  │                  ┌────────────┐                                   │   │
│  │                  │ 去重合并   │                                   │   │
│  │                  │ 只添加新项 │                                   │   │
│  │                  └────────────┘                                   │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 配置合并依赖关系

```
┌─────────────────────────────────────────────────────────────────┐
│                    配置合并依赖关系图                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   ┌──────────────┐                                              │
│   │   network    │                                              │
│   │   合并       │                                              │
│   └──────┬───────┘                                              │
│          │                                                       │
│          │ 产生 newInterfaces                                   │
│          │                                                       │
│          ├─────────────────┬───────────────────┐                │
│          │                 │                   │                │
│          ▼                 ▼                   │                │
│   ┌──────────────┐  ┌──────────────┐          │                │
│   │    dhcp      │  │  firewall    │          │                │
│   │    合并      │  │    合并      │          │                │
│   │              │  │              │          │                │
│   │ 按interface  │  │ 按zone.network│         │                │
│   │ 过滤         │  │ 过滤         │          │                │
│   └──────────────┘  └──────────────┘          │                │
│                                                │                │
│                                                ▼                │
│                                         ┌──────────────┐       │
│                                         │  wireless    │       │
│                                         │    合并      │       │
│                                         │              │       │
│                                         │ 按wifi-iface│       │
│                                         │ 去重         │       │
│                                         └──────────────┘       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### 配置合并

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `network_merge(srcConfig, dstConfig)` | `srcConfig:table` 源配置, `dstConfig:table` 目标配置 | `newInterfaces:table` 新增接口列表 | 合并网络配置 |
| `dhcp_merge(srcConfig, dstConfig, networkInterfaces)` | `srcConfig:table`, `dstConfig:table`, `networkInterfaces:table` 网络接口列表 | `success:boolean` | 合并DHCP配置 |
| `firewall_merge(srcConfig, dstConfig, networkInterfaces)` | `srcConfig:table`, `dstConfig:table`, `networkInterfaces:table` | `success:boolean` | 合并防火墙配置 |
| `wireless_merge(srcConfig, dstConfig)` | `srcConfig:table`, `dstConfig:table` | `success:boolean` | 合并无线配置 |
| `config_merge(srcConfigs, dstConfigs)` | `srcConfigs:table` 所有源配置, `dstConfigs:table` 所有目标配置 | `success:boolean` | 合并所有配置 |

### 配置获取

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_all_config(configName)` | `configName:string` 配置名称 | `config:table` | 获取指定UCI配置 |
| `get_local_configs()` | 无 | `configs:table` 包含network/dhcp/firewall/wireless | 获取本地所有配置 |

### 信息获取

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `hotspot_info()` | 无 | `result:table` WiFi热点信息 | 获取热点信息 |
| `hardware_info()` | 无 | `result:table` 硬件信息 | 获取硬件信息 |

## 配置类型常量

### 网络配置类型

```lua
NETWORK_INTERFACE_TYPES = {"interface"}
NETWORK_DEVICE_TYPES = {"device", "bridge-vlan"}
```

### DHCP配置类型

```lua
DHCP_SECTION_TYPES = {"dhcp", "host"}
```

### 防火墙配置类型

```lua
FIREWALL_SECTION_TYPES = {
    "zone", "forwarding", "rule", 
    "redirect", "include", "ipset", "defaults"
}
```

### 无线配置类型

```lua
WIRELESS_SECTION_TYPES = {"wifi-device", "wifi-iface"}
```

## 数据结构

### 热点信息结构

```lua
{
    wifi = {
        ["24g"] = {
            ssid = "MyWiFi",
            password = "password123",
            encryption = "psk2",
            channel = 6,
            bandwidth = "20",
            hidden = 0,
            on = 1
        },
        ["5g"] = {
            ssid = "MyWiFi_5G",
            password = "password123",
            encryption = "psk2",
            channel = 36,
            bandwidth = "80",
            hidden = 0,
            on = 1
        },
        ["5gh"] = {  -- 三频设备
            -- 同上结构
        }
    }
}
```

### 硬件信息结构

```lua
{
    model = "R3600",           -- 设备型号
    hardware = "1.0",          -- 硬件版本
    romversion = "4.14.24",    -- 内核版本
    channel = "CN",            -- 国家代码
    sn = "123456789012",       -- 序列号(前12位)
    mac = "AA:BB:CC:DD:EE:FF"  -- MAC地址
}
```

## 外部依赖

| 模块 | 用途 |
|------|------|
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQWifiUtil` | WiFi信息获取 |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.model.uci` | UCI配置管理 |
| `luci.util` | 命令执行 |

## 被引用情况

该模块主要被以下组件引用：
- XQExWifiConfSync WiFi配置同步模块
- Mesh网络配置同步
- 扩展器配置管理

## 关键代码说明

### 网络配置过滤

```lua
local function filterNetworkConfig(srcConfig, dstConfig)
    local srcInterfaces = getInterfaceList(srcConfig)
    local dstInterfaces = getInterfaceList(dstConfig)
    local srcDevices = getDeviceList(srcConfig)
    local dstDevices = getDeviceList(dstConfig)
    
    local filteredConfig = {}
    
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "interface" then
            -- 只添加目标中不存在的接口
            if not dstInterfaces[sectionName] then
                filteredConfig[sectionName] = sectionData
            end
        elseif sectionType == "device" or sectionType == "bridge-vlan" then
            local deviceName = sectionData.name
            -- 只添加目标中不存在的设备
            if deviceName and not dstDevices[deviceName] then
                filteredConfig[sectionName] = sectionData
            end
        end
    end
    
    return filteredConfig
end
```

### 防火墙配置过滤

```lua
local function filterFirewallConfig(srcConfig, dstConfig, networkInterfaces)
    local filteredConfig = {}
    local zoneNames = {}
    
    -- 第一遍: 过滤zone，只保留与新增网络接口相关的zone
    for sectionName, sectionData in pairs(srcConfig) do
        if sectionData[".type"] == "zone" then
            local network = sectionData.network
            local shouldInclude = false
            
            if network then
                if type(network) == "table" then
                    for _, iface in ipairs(network) do
                        if networkInterfaces[iface] then
                            shouldInclude = true
                            break
                        end
                    end
                elseif networkInterfaces[network] then
                    shouldInclude = true
                end
            end
            
            if shouldInclude then
                filteredConfig[sectionName] = sectionData
                zoneNames[sectionData.name] = true
            end
        end
    end
    
    -- 第二遍: 过滤forwarding/rule/redirect，只保留与已选zone相关的规则
    for sectionName, sectionData in pairs(srcConfig) do
        local sectionType = sectionData[".type"]
        
        if sectionType == "forwarding" or sectionType == "rule" or sectionType == "redirect" then
            local src = sectionData.src
            local dest = sectionData.dest
            if (src and zoneNames[src]) or (dest and zoneNames[dest]) then
                filteredConfig[sectionName] = sectionData
            end
        end
    end
    
    return filteredConfig
end
```

### 配置应用

```lua
local function applyConfigSection(configName, sectionName, sectionData)
    local sectionType = sectionData[".type"]
    
    -- 清理元数据字段(以.开头的字段)
    local cleanData = {}
    for key, value in pairs(sectionData) do
        if not key:match("^%.") then
            cleanData[key] = value
        end
    end
    
    -- 写入UCI配置
    uci:section(configName, sectionType, sectionName, cleanData)
end
```

### 硬件信息获取

```lua
function hardware_info()
    local result = {}
    
    result.model = trim(LuciUtil.exec("nvram get model"))
    result.hardware = trim(LuciUtil.exec("getbdata hw_ver"))
    result.romversion = trim(LuciUtil.exec("uname -r"))
    result.channel = trim(LuciUtil.exec("getbdata CountryCode"))
    
    local sn = trim(LuciUtil.exec("getbdata SN"))
    if sn then
        result.sn = sn:sub(1, 12)  -- 只取前12位
    end
    
    local mac = trim(LuciUtil.exec("getmac"))
    if mac then
        result.mac = mac:upper()
    end
    
    return result
end
```

## 合并流程

1. **network_merge**: 合并网络接口和设备配置，返回新增的接口列表
2. **dhcp_merge**: 根据新增接口列表，合并相关的DHCP配置
3. **firewall_merge**: 根据新增接口列表，合并相关的防火墙zone和规则
4. **wireless_merge**: 合并无线接口配置(wifi-iface)
