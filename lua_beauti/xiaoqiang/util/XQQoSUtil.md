# XQQoSUtil.lua - QoS服务质量工具模块

## 概述

XQQoSUtil 是小米路由器的 QoS (Quality of Service) 服务质量管理工具模块，提供流量控制和带宽管理功能。支持应用限速、设备限速、QoS 模式设置、带宽管理以及王者荣耀加速等功能。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                      QoS 流量控制架构                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │  应用限速    │    │  设备限速    │    │  QoS模式     │       │
│  │  (app-tc)    │    │  (miqos)     │    │  设置        │       │
│  └──────┬───────┘    └──────┬───────┘    └──────┬───────┘       │
│         │                   │                   │                │
│         ▼                   ▼                   ▼                │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    miqos 服务                            │    │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐    │    │
│  │  │  auto   │  │   min   │  │   max   │  │ service │    │    │
│  │  │ 自动模式│  │保障模式 │  │限速模式 │  │服务模式 │    │    │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘    │    │
│  └─────────────────────────────────────────────────────────┘    │
│                              │                                   │
│                              ▼                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    流量调度器                            │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │    │
│  │  │ 上传队列    │  │ 下载队列    │  │ 优先级队列  │     │    │
│  │  │ (UP)        │  │ (DOWN)      │  │ (seq_prio)  │     │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

QoS 模式说明:
┌────────┬────────────┬────────────────────────────────────┐
│ 模式号 │ 模式类型   │ 说明                               │
├────────┼────────────┼────────────────────────────────────┤
│   0    │ auto       │ 自动模式，智能分配带宽             │
│   1    │ min        │ 保障模式，保证最小带宽             │
│   2    │ max        │ 限速模式，限制最大带宽             │
│   3    │ service    │ 服务模式(auto优先)                 │
│   4    │ service    │ 服务模式(game优先)                 │
│   5    │ service    │ 服务模式(web优先)                  │
│   6    │ service    │ 服务模式(video优先)                │
└────────┴────────────┴────────────────────────────────────┘
```

## 接口列表

### 应用限速相关

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `appSpeedlimitSwitch(enable)` | enable: boolean | boolean | 应用限速总开关 |
| `appInfo()` | 无 | table | 获取应用限速信息(迅雷/快盘) |
| `setXunlei(downloadSpeed, uploadSpeed)` | downloadSpeed, uploadSpeed: number | 无 | 设置迅雷限速 |
| `setKuaipan(downloadSpeed, uploadSpeed)` | downloadSpeed, uploadSpeed: number | 无 | 设置快盘限速 |
| `reload()` | 无 | 无 | 重新加载应用限速配置 |

### QoS 控制相关

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `qosSwitch(enable)` | enable: boolean | boolean | QoS 总开关 |
| `setQoSMode(mode)` | mode: number (0-6) | number | 设置 QoS 模式，返回错误码 |
| `qosRestart()` | 无 | number | 重启 QoS 服务 |
| `qosStatus()` | 无 | table{on, mode} | 获取 QoS 状态 |
| `qosBand()` | 无 | table{download, upload} | 获取 QoS 带宽配置(MB) |
| `setQosBand(download, upload)` | download, upload: number | boolean | 设置 QoS 带宽(MB) |

### 设备限速相关

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `qosList(bandInfo)` | bandInfo: table | table | 获取设备 QoS 列表 |
| `macQosInfo(macAddr)` | macAddr: string | table | 获取指定 MAC 的 QoS 信息 |
| `setMacQosInfo(macAddr, maxUpload, maxDownload)` | macAddr: string, maxUpload/maxDownload: number | boolean | 设置设备限速(KB/s) |
| `qosOnLimit(macAddr, mode, maxUpload, maxDownload)` | macAddr: string, mode: number, maxUpload/maxDownload: number | boolean | QoS 限速设置 |
| `qosLimitFlag(macAddr, flag)` | macAddr: string, flag: "on"/"off" | boolean | 设置限速开关标志 |
| `qosOnLimits(mode, deviceList)` | mode: number, deviceList: table | boolean | 批量设备限速 |
| `qosOffLimit(macAddr)` | macAddr: string (可选) | boolean | 关闭 QoS 限速 |
| `qosHistory(macList)` | macList: table (可选) | table | 获取 QoS 历史记录 |

### 访客/小米设备 QoS

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `guestQoSInfo()` | 无 | table | 获取访客网络 QoS 信息 |
| `xqQoSInfo()` | 无 | table | 获取小米设备 QoS 信息 |
| `setQosGuestOrXQ(qosType, downPercent, upPercent)` | qosType: "guest"/"xq", downPercent/upPercent: number(0-1) | boolean | 设置访客/小米设备 QoS |

### 王者荣耀加速

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `wangzheInfo()` | 无 | table{switch} | 获取王者荣耀加速状态 |

### QoS 应用管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `qos_app(appId, lanIp, remoteIp, remotePort, operation)` | appId: number, lanIp/remoteIp: string, remotePort: number, operation: 0(添加)/1(删除) | number | QoS 应用规则管理 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读写 |
| `xiaoqiang.common.XQConfigs` | 系统配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `luci.util` | Luci 工具函数 |
| `miqos` | 小米 QoS 服务接口 |
| `xiaoqiang.util.XQDeviceUtil` | 设备信息工具 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `xqcrypto` | 加密工具(应用管理) |

## 被引用情况

- `xiaoqiang/util/XQSynchrodata.lua` - 同步 QoS 信息到云端
- `luci/controller/api/xqnetwork.lua` - 网络 API 控制器
- `luci/controller/api/misystem.lua` - 系统 API 控制器

## 关键代码说明

### 权重与级别转换

```lua
-- 权重辅助函数（用于保障模式）
local function _weightHelper(level)
    if level == 1 then return 0.25      -- 低优先级
    elseif level == 2 then return 0.5   -- 中优先级
    elseif level == 3 then return 0.75  -- 高优先级
    else return 0.1 end
end

-- 级别辅助函数（根据百分比返回级别）
local function _levelHelper(percent)
    if percent == 0 then return 2
    elseif percent > 0 and percent <= 0.25 then return 1
    elseif percent > 0.25 and percent <= 0.5 then return 2
    elseif percent > 0.5 then return 3
    end
    return 0
end
```

### 比特率格式转换

```lua
-- 将各种速度单位转换为 KB/s
local function _bitFormat(speedStr)
    if speedStr:match("Gbit") then
        return value * 131072  -- Gbit -> KB/s
    elseif speedStr:match("Mbit") then
        return value * 128     -- Mbit -> KB/s
    elseif speedStr:match("Kbit") then
        return value / 8       -- Kbit -> KB/s
    elseif speedStr:match("bit") then
        return value / 8192    -- bit -> KB/s
    end
end
```

### UCI 配置结构

```
# /etc/config/app-tc (应用限速)
config config
    option enable '0'

config xunlei
    option enable '1'
    option max_download_speed '1024'
    option max_upload_speed '512'

# /etc/config/miqos (设备QoS)
config settings
    option qos_auto 'auto'
    option download '102400'
    option upload '51200'

config group 'AABBCCDDEEFF'
    option name 'AA:BB:CC:DD:EE:FF'
    option max_grp_uplink '8192'
    option max_grp_downlink '16384'
    option flag 'on'
```
