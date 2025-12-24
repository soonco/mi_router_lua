# XQAntiRubNetwork.lua - 防蹭网模块

## 概述

`XQAntiRubNetwork.lua` 是小米路由器的防蹭网安全模块，负责追踪和缓存WiFi认证失败、登录认证失败等安全事件。该模块用于检测和防止未授权设备尝试连接网络，并在检测到异常时触发推送通知。

**文件位置**: `xiaoqiang/module/XQAntiRubNetwork.lua`  
**模块名**: `xiaoqiang.module.XQAntiRubNetwork`  
**代码行数**: ~452行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    防蹭网检测流程                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  认证失败事件                                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ WiFi认证失败 │  │ 黑名单尝试   │  │ 登录认证失败 │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                 │                 │               │
│         ▼                 ▼                 ▼               │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              缓存管理 (Cache Management)             │   │
│  │  路径: /tmp/authenfailed-cache/                      │   │
│  │  格式: WIFI-{MAC}, BLACKLISTED-{MAC}, LOGIN-{MAC}    │   │
│  │  数据: {mac, count, warning, atime}                  │   │
│  └─────────────────────────────────────────────────────┘   │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              阈值判断 (Threshold Check)              │   │
│  │  WiFi失败: 30次/60秒 → 触发警告                      │   │
│  │  黑名单尝试: 5次/15秒 → 触发警告                     │   │
│  │  登录失败: 5次/60秒 → 触发警告                       │   │
│  └─────────────────────────────────────────────────────┘   │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              推送通知 (Push Notification)            │   │
│  │  通过 XQPushUtil 发送安全警告                        │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 默认配置

| 配置项 | 值 | 说明 |
|--------|-----|------|
| `interval` | 60秒 | 缓存检查间隔 |
| `blackltd` | 30 | 黑名单阈值 |
| `wifi` | 30 | WiFi认证失败阈值 |
| `wifib` | 5 | 黑名单尝试阈值 |
| `llogin` | 5 | 低级别登录失败阈值 |
| `hlogin` | 5 | 高级别登录失败阈值 |

## 接口列表

### 缓存管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `read(filename, interval)` | filename: string, interval: number | table/nil | 读取缓存数据 |
| `write(filename, data)` | filename: string, data: table | 无 | 写入缓存数据 |
| `kill(filename)` | filename: string | 无 | 删除缓存文件 |
| `reap()` | 无 | 无 | 清理过期缓存 |

### 设备忽略管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `isIgnored(mac, authType)` | mac: string, authType: string | boolean | 检查设备是否在忽略列表 |
| `ignoreDevice(mac, authType)` | mac: string, authType: string | 无 | 将设备添加到忽略列表 |

### WiFi认证失败处理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setWifiAuthenFailedCache(mac)` | mac: string | boolean | 设置WiFi认证失败缓存 |
| `getWifiAuthenFailedCache(mac)` | mac: string | table/nil | 获取WiFi认证失败缓存 |
| `wifiAuthenFailedAction(mac)` | mac: string | number/nil | 处理WiFi认证失败事件 |

### 黑名单尝试处理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setWifiBlacklistedCache(mac)` | mac: string | boolean | 设置黑名单尝试缓存 |
| `getWifiBlacklistedCache(mac)` | mac: string | table/nil | 获取黑名单尝试缓存 |
| `wifiBlacklistedAction(mac)` | mac: string | number/nil | 处理黑名单尝试事件 |

### 登录认证失败处理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setLoginAuthenFailedCache(mac)` | mac: string | boolean | 设置登录认证失败缓存 |
| `getLoginAuthenFailedCache(mac)` | mac: string | table/nil | 获取登录认证失败缓存 |
| `LoginAuthenFailedAction(mac)` | mac: string | number/nil | 处理登录认证失败事件 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `nixio` | 进程信息获取 |
| `nixio.fs` | 文件系统操作 |
| `luci.sys` | 系统工具（uptime） |
| `luci.util` | 工具函数（get_bytecode） |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQPushUtil` | 推送工具 |
| `luci.model.uci` | UCI配置管理 |

## 被引用情况

该模块被以下模块引用：
- WiFi驱动层 - 认证失败事件触发
- `luci.controller.api.xqsystem` - 登录失败处理
- `xiaoqiang.XQPushHelper` - 推送通知集成

## 关键代码说明

### 1. 缓存数据结构

```lua
local cacheData = {
    mac = mac,          -- 设备MAC地址
    count = 1,          -- 失败次数
    warning = false,    -- 是否触发警告
    atime = luciSys.uptime()  -- 访问时间（系统启动后秒数）
}
```

### 2. 缓存读取与过期判断

```lua
function read(filename, interval)
    interval = interval or DEFAULT_CONFIG.interval
    
    local data = loadFunc()  -- 从文件加载数据
    local uptime = luciSys.uptime()
    local elapsed = uptime - data.atime
    
    if interval < elapsed then
        -- 超过单倍间隔
        if elapsed < interval * 2 then
            data.expired = true
            data.old = false
            kill(filename)  -- 删除缓存
        end
    else
        if elapsed > interval * 2 then
            data.expired = true
            data.old = true
            kill(filename)
        else
            data.expired = false
            data.old = false
        end
    end
    
    return data
end
```

### 3. WiFi认证失败处理流程

```lua
function wifiAuthenFailedAction(mac)
    -- 检查是否在忽略列表
    if isIgnored(mac, "wifi") then
        return nil
    end
    
    local pushSettings = pushUtil.pushSettings()
    
    if pushSettings.auth then
        local cacheData = getWifiAuthenFailedCache(mac)
        if not cacheData then
            setWifiAuthenFailedCache(mac)
        else
            local frequency = math.floor(cacheData.count / 6)
            if cacheData.expired and cacheData.warning then
                -- 触发推送通知
                pushUtil.setAuthenFailedTimes(mac, failedTimes + frequency)
                pushUtil.setWifiAuthenFailedFrequency(mac, frequency)
                return frequency
            end
        end
    end
    
    return nil
end
```

### 4. 设备忽略列表管理

```lua
function ignoreDevice(mac, authType)
    mac = xqFunction.macFormat(mac)
    local macKey = mac:gsub(":", "")
    
    if authType == "login" then
        uci:set("devicelist", "login_ignore", macKey, "1")
        uci:commit("devicelist")
    elseif authType == "wifi" then
        uci:set("devicelist", "wifi_ignore", macKey, "1")
        uci:commit("devicelist")
    end
end
```

## 缓存文件说明

| 缓存键前缀 | 说明 | 检查间隔 |
|------------|------|----------|
| `WIFI-{MAC}` | WiFi认证失败记录 | 60秒 |
| `BLACKLISTED-{MAC}` | 黑名单尝试记录 | 15秒 |
| `LOGIN-{MAC}` | 登录认证失败记录 | 60秒 |

## 安全特性

1. **UID验证**: 缓存文件必须与当前进程UID匹配
2. **权限控制**: 缓存目录权限设置为700
3. **忽略列表**: 支持将特定设备加入忽略列表
4. **推送级别**: 根据用户设置的推送级别决定是否通知

## 注意事项

1. **缓存路径**: 所有缓存存储在 `/tmp/authenfailed-cache/`
2. **时间基准**: 使用系统uptime而非绝对时间，避免时间同步问题
3. **字节码存储**: 缓存数据使用Lua字节码格式存储
4. **自动清理**: `reap()` 函数可清理所有过期缓存
