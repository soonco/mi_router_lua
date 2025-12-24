# XQTimeMachine.lua - Time Machine模块

## 概述

`XQTimeMachine` 模块提供 macOS Time Machine 备份服务的管理功能。该模块允许用户配置 Time Machine 备份服务，包括设置备份存储路径、备份空间大小、访问密码等，并能检测存储设备的在线状态。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                  Time Machine 服务架构                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   UCI配置    │───▶│ timemachine  │───▶│   AFP/SMB    │  │
│  │ timemachine  │    │   服务脚本   │    │   备份服务   │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│         │                                       │          │
│         ▼                                       ▼          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    绑定状态说明                        │  │
│  │  • 0: 无存储设备，未绑定                              │  │
│  │  • 1: 有存储设备，未绑定                              │  │
│  │  • 2: 无存储设备，已绑定(配置存在但设备不在)          │  │
│  │  • 3: 有存储设备，已绑定且设备在线                    │  │
│  │  • 4: 有存储设备，已绑定但设备不在                    │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### getTimeMachineInfo()

获取 Time Machine 配置信息和状态。

**参数:** 无

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| bindStatus | string | 绑定状态 (0-4，见上图说明) |
| enabled | string | 服务启用状态 ("0"/"1") |
| path | string | 备份存储路径 |
| size | string | 备份空间大小 |
| password | string | 访问密码 |

---

### setTimeMachineInfo(enabled, path, size, password)

设置 Time Machine 配置。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| enabled | number/string | 启用状态 (0=禁用, 1=启用) |
| path | string | 备份存储路径 |
| size | string/number | 备份空间大小 |
| password | string | 访问密码 |

**返回值:**
| 值 | 说明 |
|------|------|
| 0 | 成功 |
| 1523 | 参数错误 (enabled 无效) |
| 1589 | 存储路径无效 (无法获取 UUID) |

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.module.XQStorage | 存储管理模块 |
| xiaoqiang.XQLog | 日志模块 |
| luci.util | LuCI 工具函数 |
| luci.model.uci | UCI 配置管理 |
| /usr/sbin/timemachine.sh | Time Machine 服务脚本 |
| /etc/config/timemachine | Time Machine 配置文件 |

## 被引用情况

- Time Machine 管理 API 控制器
- 存储管理页面的 Time Machine 配置
- macOS 备份功能集成

## 关键代码说明

### 设备存在性检测

```lua
local function hasStorageDevice()
    local blockInfo = LuciUtil.exec("block info")
    if not XQFunction.isStrNil(blockInfo) then
        return 1
    end
    return 0
end

local function isUuidDevicePresent(uuid)
    local blockInfo = LuciUtil.exec("block info | grep " .. uuid)
    if not XQFunction.isStrNil(blockInfo) then
        return 1
    end
    return 0
end
```

通过 `block info` 命令检测存储设备是否存在，并通过 UUID 匹配确认特定设备是否在线。

### 绑定状态判断逻辑

```lua
if XQFunction.isStrNil(configUuid) then
    -- 未配置 UUID
    if hasStorage == 0 then
        result.bindStatus = "0"  -- 无设备，未绑定
    else
        result.bindStatus = "1"  -- 有设备，未绑定
    end
else
    -- 已配置 UUID
    local uuidPresent = isUuidDevicePresent(configUuid)
    if hasStorage == 0 then
        result.bindStatus = "2"  -- 无设备，已绑定
    elseif uuidPresent == 0 then
        result.bindStatus = "4"  -- 有设备，但绑定的设备不在
    else
        result.bindStatus = "3"  -- 有设备，绑定的设备在线
    end
end
```

### 配置变更检测

```lua
if currentEnabled ~= enabled or currentSize ~= size or 
   currentUuid ~= newUuid or currentPassword ~= password then
    -- 配置有变化，更新并重启服务
end
```

模块会比较新旧配置，仅在配置实际变化时才更新 UCI 配置并重启服务，避免不必要的服务中断。

### 日志级别

模块使用日志级别 7 (LOG_LEVEL = 7) 记录 Time Machine 服务的启动和停止操作。
