# XQGuestWifi.lua - 访客WiFi模块

## 概述

`XQGuestWifi.lua` 是小米路由器的访客WiFi管理模块，负责管理访客网络的开启、关闭和配置。访客网络是一个独立的WiFi网络，可以限制访客设备的网络访问权限和带宽。

**文件位置**: `xiaoqiang/module/XQGuestWifi.lua`  
**模块名**: `xiaoqiang.module.XQGuestWifi`  
**代码行数**: ~95行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    访客WiFi架构                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  主WiFi网络 (192.168.31.x)                                  │
│      │                                                      │
│      │  ┌─────────────────────────────────────────┐        │
│      │  │           路由器                         │        │
│      │  │  ┌─────────────────────────────────┐   │        │
│      │  │  │      访客网络隔离               │   │        │
│      │  │  │  - 独立SSID                     │   │        │
│      │  │  │  - 独立密码                     │   │        │
│      │  │  │  - 可选限速                     │   │        │
│      │  │  │  - 可选超时                     │   │        │
│      │  │  └─────────────────────────────────┘   │        │
│      │  └─────────────────────────────────────────┘        │
│      │                                                      │
│      ▼                                                      │
│  访客WiFi网络 (独立网段)                                    │
│      │                                                      │
│      ▼                                                      │
│  访客设备 (受限访问)                                        │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 主要接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setGuestWifi(enable, ssid, encryption, password, timeout, limitSpeed, speedLimit, callback)` | 多参数 | boolean | 设置访客WiFi |
| `delGuestWifi(wifiIndex)` | wifiIndex: number | 无 | 删除访客WiFi |

### 事件钩子

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `hookLanIPChangeEvent(oldIP, newIP)` | 多参数 | 无 | LAN IP变更事件钩子（预留） |

### 内部函数

| 函数名 | 说明 |
|--------|------|
| `_checkGuestWifi()` | 检查访客WiFi是否已配置 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（forkExec等） |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具库 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN工具 |
| `luci.model.uci` | UCI配置管理 |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.XQEvent` - 事件处理模块
- `luci.controller.api.xqnetwork` - 网络API访客WiFi接口
- `luci.controller.api.xqsystem` - 系统API访客WiFi接口

## 关键代码说明

### 1. 检查访客WiFi配置

```lua
function _checkGuestWifi()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 检查network配置中是否存在guest网络
    local guestNetwork = cursor:get_all("network", "guest")
    
    if guestNetwork then
        return true
    end
    return false
end
```

### 2. 设置访客WiFi

```lua
function setGuestWifi(enable, ssid, encryption, password, timeout, limitSpeed, speedLimit, callback)
    -- 调用WiFi工具库设置访客WiFi
    local result = XQWifiUtil.setGuestWifi(enable, ssid, encryption, password, 
                                           timeout, limitSpeed, speedLimit)
    
    if not result then
        return false
    end
    
    -- 检查是否需要首次创建访客网络
    local needCreateNetwork = not _checkGuestWifi()
    
    -- 处理回调或执行默认操作
    if callback then
        if type(callback) == "function" then
            callback(needCreateNetwork)
        end
    elseif needCreateNetwork then
        -- 首次创建: 等待4秒后开启访客WiFi并同步BSSID
        XQFunction.forkExec("sleep 4; /usr/sbin/guestwifi.sh open; " ..
                           "lua /usr/sbin/sync_guest_bssid.lua >/dev/null 2>/dev/null")
    else
        -- 已存在: 重启WiFi并同步BSSID
        XQFunction.forkRestartWifi("lua /usr/sbin/sync_guest_bssid.lua")
    end
    
    return true
end
```

### 3. 删除访客WiFi

```lua
function delGuestWifi(wifiIndex)
    -- 调用WiFi工具库删除访客WiFi配置
    XQWifiUtil.delGuestWifi(wifiIndex)
    
    -- 等待4秒后执行关闭访客WiFi脚本
    XQFunction.forkExec("sleep 4; /usr/sbin/guestwifi.sh close >/dev/null 2>/dev/null")
end
```

## 参数说明

### setGuestWifi 参数

| 参数 | 类型 | 说明 |
|------|------|------|
| `enable` | number | 是否启用 (1=启用, 0=禁用) |
| `ssid` | string | WiFi名称 |
| `encryption` | string | 加密方式 |
| `password` | string | WiFi密码 |
| `timeout` | number | 超时时间（分钟） |
| `limitSpeed` | number | 是否限速 (1=是, 0=否) |
| `speedLimit` | number | 限速值（Kbps） |
| `callback` | function | 可选的回调函数 |

## 相关脚本

| 脚本路径 | 说明 |
|----------|------|
| `/usr/sbin/guestwifi.sh open` | 开启访客WiFi |
| `/usr/sbin/guestwifi.sh close` | 关闭访客WiFi |
| `/usr/sbin/sync_guest_bssid.lua` | 同步访客WiFi BSSID |

## 访客网络特性

1. **网络隔离**: 访客设备与主网络设备隔离
2. **独立SSID**: 访客网络使用独立的WiFi名称
3. **限速功能**: 可限制访客网络的带宽
4. **超时功能**: 可设置访客网络的自动关闭时间
5. **BSSID同步**: 支持Mesh网络的BSSID同步

## 注意事项

1. **首次创建**: 首次创建访客网络需要额外的初始化步骤
2. **延迟执行**: 操作后需要等待4秒让配置生效
3. **BSSID同步**: 开启/关闭后需要同步BSSID信息
4. **钩子预留**: `hookLanIPChangeEvent` 为空实现，预留接口
5. **回调支持**: 支持自定义回调函数处理创建完成事件
