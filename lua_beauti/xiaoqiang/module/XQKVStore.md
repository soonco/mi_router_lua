# XQKVStore.lua - KV存储模块

## 概述

`XQKVStore` 是小米路由器的键值存储模块，主要功能是整合多个子模块的数据，返回路由器的综合状态信息。该模块作为数据聚合层，为客户端（如小米WiFi App）提供一站式的路由器状态查询接口。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    KV存储数据聚合流程                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    getRouterKV()                         │   │
│  └────────────────────────┬────────────────────────────────┘   │
│                           │                                     │
│           ┌───────────────┼───────────────┐                    │
│           ▼               ▼               ▼                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │
│  │ XQDeviceUtil│  │ XQWifiUtil  │  │ XQSysUtil   │            │
│  │ 设备信息     │  │ WiFi信息    │  │ 系统信息    │            │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘            │
│         │                │                │                    │
│         ▼                ▼                ▼                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │
│  │ XQPushUtil  │  │ XQLanWanUtil│  │ XQQoSUtil   │            │
│  │ 推送设置     │  │ 网络信息    │  │ QoS信息     │            │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘            │
│         │                │                │                    │
│         ▼                ▼                ▼                    │
│  ┌─────────────┐  ┌─────────────┐                             │
│  │ XQVASModule │  │ XQPredownload│                            │
│  │ VAS服务信息  │  │ 预下载信息   │                            │
│  └──────┬──────┘  └──────┬──────┘                             │
│         │                │                                     │
│         └────────┬───────┘                                     │
│                  ▼                                              │
│         ┌─────────────────┐                                    │
│         │  devicesInfo    │                                    │
│         │  (聚合结果)      │                                    │
│         └─────────────────┘                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 返回数据结构

```
devicesInfo = {
    ├── router_name          -- 路由器名称
    ├── router_locale        -- 区域设置
    ├── plugin_id_list       -- 插件ID列表
    ├── work_mode            -- 工作模式 (0=路由, 1=AP, 2=中继)
    ├── active_apcli_mode    -- AP客户端活动模式
    │
    ├── WiFi信息
    │   ├── bssid_24G        -- 2.4G BSSID
    │   ├── bssid_5G         -- 5G BSSID
    │   ├── bssid_5G2        -- 第二5G BSSID (如有)
    │   ├── bssid_guest      -- 访客网络BSSID
    │   ├── bssid_lan        -- LAN BSSID
    │   ├── ssid_24G         -- 2.4G SSID
    │   ├── ssid_5G          -- 5G SSID
    │   └── ssid_5G2         -- 第二5G SSID (如有)
    │
    ├── 网络信息
    │   └── ap_lan_ip        -- AP模式LAN IP
    │
    ├── 安全信息
    │   ├── protection_enabled  -- 保护功能开关
    │   └── protection_mode     -- 保护模式
    │
    ├── QoS信息
    │   └── qos_info         -- QoS配置信息
    │
    ├── OTA信息
    │   ├── auto_ota_rom     -- 自动ROM更新
    │   └── auto_ota_plugin  -- 自动插件更新
    │
    ├── guest                -- 访客网络状态
    └── [VAS信息...]         -- VAS服务相关数据
}
```

## 接口列表

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getRouterKV()` | 无 | table | 获取路由器综合状态信息 |

### 返回值字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| `router_name` | string | 路由器名称 |
| `router_locale` | string | 路由器区域设置 |
| `plugin_id_list` | string | 已安装插件ID列表 |
| `work_mode` | number | 工作模式 (0=路由器, 1=AP, 2=中继) |
| `active_apcli_mode` | number | AP客户端活动类型 |
| `bssid_24G` | string | 2.4GHz WiFi BSSID |
| `bssid_5G` | string | 5GHz WiFi BSSID |
| `bssid_5G2` | string | 第二5GHz WiFi BSSID (三频路由器) |
| `bssid_guest` | string | 访客网络BSSID |
| `bssid_lan` | string | LAN口BSSID |
| `ssid_24G` | string | 2.4GHz WiFi名称 |
| `ssid_5G` | string | 5GHz WiFi名称 |
| `ssid_5G2` | string | 第二5GHz WiFi名称 |
| `ap_lan_ip` | string | AP模式下的LAN IP |
| `protection_enabled` | number | 安全保护是否启用 |
| `protection_mode` | number | 安全保护模式 |
| `qos_info` | table | QoS配置信息 |
| `auto_ota_rom` | number | 自动ROM更新开关 |
| `auto_ota_plugin` | number | 自动插件更新开关 |
| `guest` | string | 访客网络状态 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 获取网络模式类型 |
| `xiaoqiang.util.XQPushUtil` | 获取推送设置 |
| `xiaoqiang.util.XQSysUtil` | 获取系统信息（路由器名称、区域、OTA设置等） |
| `xiaoqiang.util.XQWifiUtil` | 获取WiFi信息（BSSID、SSID、MAC过滤等） |
| `xiaoqiang.util.XQDeviceUtil` | 获取设备基础信息 |
| `xiaoqiang.util.XQLanWanUtil` | 获取LAN/WAN网络信息 |
| `xiaoqiang.util.XQQoSUtil` | 获取QoS配置信息 |
| `xiaoqiang.module.XQVASModule` | 获取VAS服务信息 |
| `xiaoqiang.module.XQPredownload` | 预下载模块 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 提供路由器状态查询接口 |
| 小米WiFi App | 获取路由器综合状态 |
| 状态同步服务 | 同步路由器信息到云端 |

## 关键代码说明

### 数据聚合流程

```lua
function getRouterKV()
    -- 1. 获取基础设备信息
    local devicesInfo = XQDeviceUtil.devicesInfo()
    
    -- 2. 合并VAS服务信息
    local vasKvInfo = XQVASModule.get_vas_kv_info()
    if type(vasKvInfo) == "table" then
        for key, value in pairs(vasKvInfo) do
            devicesInfo[key] = value
        end
    end
    
    -- 3. 添加系统信息
    devicesInfo.router_name = XQSysUtil.getRouterName()
    devicesInfo.router_locale = XQSysUtil.getRouterLocale()
    devicesInfo.plugin_id_list = XQSysUtil.getPluginIdList()
    
    -- 4. 添加网络模式信息
    devicesInfo.work_mode = XQFunction.getNetModeType()
    devicesInfo.active_apcli_mode = XQWifiUtil.apcli_get_active_type()
    
    -- 5. 添加WiFi信息
    devicesInfo.bssid_24G = bssid24G or ""
    devicesInfo.ssid_24G = ssid24G or ""
    -- ... 其他WiFi信息
    
    return devicesInfo
end
```

### 三频路由器支持

```lua
-- 获取WLAN数量
local wlanCount = XQWifiUtil.get_wlan_count()

-- 如果有第三个5G频段（三频路由器）
if wlanCount >= 3 then
    devicesInfo.bssid_5G2 = bssid5G2 or ""
    devicesInfo.ssid_5G2 = ssid5G2 or ""
end
```

### MAC过滤模式转换

```lua
-- 获取WiFi MAC过滤模式
local macfilterModel = XQWifiUtil.getWiFiMacfilterModel()
-- 转换为保护模式 (0-based)
local protectionMode = macfilterModel - 1
if protectionMode < 0 then
    protectionMode = 0
end
devicesInfo.protection_mode = protectionMode
```
