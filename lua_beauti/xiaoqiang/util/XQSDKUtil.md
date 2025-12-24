# XQSDKUtil.lua - SDK权限管理工具模块

## 概述

XQSDKUtil 是小米路由器的 SDK 权限管理工具模块，提供基于 MAC 地址的 SDK 设备过滤和权限控制功能。该模块用于管理哪些设备可以通过 SDK 接口访问路由器功能。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    SDK 权限管理流程                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐                                               │
│  │  SDK 请求    │                                               │
│  │  (设备MAC)   │                                               │
│  └──────┬───────┘                                               │
│         │                                                        │
│         ▼                                                        │
│  ┌──────────────────────────────────────┐                       │
│  │         checkPermission()            │                       │
│  │  ┌────────────────────────────────┐  │                       │
│  │  │  1. 格式化 MAC 地址            │  │                       │
│  │  │  2. 移除冒号 (AA:BB -> AABB)   │  │                       │
│  │  │  3. 查询 sdkfilter 配置        │  │                       │
│  │  └────────────────────────────────┘  │                       │
│  └──────────────┬───────────────────────┘                       │
│                 │                                                │
│         ┌───────┴───────┐                                       │
│         │               │                                        │
│         ▼               ▼                                        │
│  ┌──────────────┐ ┌──────────────┐                              │
│  │ permission=1 │ │ permission≠1 │                              │
│  │   允许访问   │ │   拒绝访问   │                              │
│  └──────────────┘ └──────────────┘                              │
│                                                                  │
│  配置存储:                                                       │
│  ┌─────────────────────────────────────────────┐                │
│  │  /etc/config/sdkfilter                      │                │
│  │  ┌─────────────────────────────────────┐   │                │
│  │  │  AABBCCDDEEFF = "1"  (允许)         │   │                │
│  │  │  112233445566 = "0"  (禁止)         │   │                │
│  │  └─────────────────────────────────────┘   │                │
│  └─────────────────────────────────────────────┘                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `checkPermission(macAddr)` | macAddr: string - 设备 MAC 地址 | boolean - 是否有权限 | 检查指定设备的 SDK 访问权限 |
| `setPermission(macAddr, allowed)` | macAddr: string - 设备 MAC 地址, allowed: boolean - 是否允许 | 无 | 设置指定设备的 SDK 访问权限 |

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_formatMac(macAddr)` | macAddr: string | string | 格式化 MAC 地址（移除冒号） |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.XQPreference` | 偏好设置存储 |
| `xiaoqiang.common.XQConfigs` | 系统配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具 |

## 被引用情况

- SDK 相关 API 控制器
- 第三方应用接口验证

## 关键代码说明

### MAC 地址格式化

```lua
-- 移除 MAC 地址中的冒号分隔符
local function _formatMac(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return nil
    end
    return macAddr:gsub(":", "")
    -- 示例: "AA:BB:CC:DD:EE:FF" -> "AABBCCDDEEFF"
end
```

### 权限检查流程

```lua
function checkPermission(macAddr)
    -- 1. 参数验证
    if XQFunction.isStrNil(macAddr) then
        return false
    end
    
    -- 2. 格式化 MAC 地址
    macAddr = XQFunction.macFormat(macAddr)
    
    -- 3. 从配置中读取权限
    local permission = XQPreference.get(_formatMac(macAddr), nil, CONFIG_MACFILTER)
    
    -- 4. 检查权限值
    if permission and permission == "1" then
        XQLog.log(6, "SDK filter. mac:" .. macAddr .. " OK!")
        return true
    else
        XQLog.log(6, "SDK filter. mac:" .. macAddr .. " not allowed")
        return false
    end
end
```

### 配置存储结构

```
# /etc/config/sdkfilter
# 配置节名为 MAC 地址（无冒号）
# 值为 "1" 表示允许，"0" 表示禁止

config sdkfilter
    option AABBCCDDEEFF '1'
    option 112233445566 '0'
```

## 使用示例

```lua
local XQSDKUtil = require("xiaoqiang.util.XQSDKUtil")

-- 检查设备是否有 SDK 访问权限
local hasPermission = XQSDKUtil.checkPermission("AA:BB:CC:DD:EE:FF")
if hasPermission then
    -- 允许 SDK 操作
else
    -- 拒绝访问
end

-- 授予设备 SDK 访问权限
XQSDKUtil.setPermission("AA:BB:CC:DD:EE:FF", true)

-- 撤销设备 SDK 访问权限
XQSDKUtil.setPermission("AA:BB:CC:DD:EE:FF", false)
```
