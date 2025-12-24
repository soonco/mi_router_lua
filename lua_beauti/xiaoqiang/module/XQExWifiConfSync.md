# XQExWifiConfSync.lua - WiFi配置同步模块

## 概述

XQExWifiConfSync 是小米路由器的WiFi配置同步模块，用于管理主路由器与扩展器之间的WiFi配置同步。该模块支持将主路由器的WiFi设置（包括2.4G、5G和访客网络）同步到所有在线的扩展器设备，实现Mesh网络的统一配置管理。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     XQExWifiConfSync WiFi配置同步模块                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        主路由器                                   │   │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐                  │   │
│  │  │ 2.4G WiFi  │  │  5G WiFi   │  │ 访客WiFi   │                  │   │
│  │  │ 配置       │  │  配置      │  │ 配置       │                  │   │
│  │  └────────────┘  └────────────┘  └────────────┘                  │   │
│  │         │               │               │                         │   │
│  │         └───────────────┼───────────────┘                         │   │
│  │                         │                                         │   │
│  │                         ▼                                         │   │
│  │                  ┌────────────┐                                   │   │
│  │                  │ 配置打包   │                                   │   │
│  │                  │ JSON格式   │                                   │   │
│  │                  └────────────┘                                   │   │
│  └──────────────────────────┬───────────────────────────────────────┘   │
│                              │                                           │
│                              │ HTTP POST                                 │
│                              │ /cgi-bin/luci/api/xqsystem/wifi_sync     │
│                              ▼                                           │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        扩展器集群                                 │   │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐                  │   │
│  │  │ 扩展器 1   │  │ 扩展器 2   │  │ 扩展器 N   │                  │   │
│  │  │ 192.168.x.1│  │ 192.168.x.2│  │ 192.168.x.N│                  │   │
│  │  └────────────┘  └────────────┘  └────────────┘                  │   │
│  │         │               │               │                         │   │
│  │         └───────────────┼───────────────┘                         │   │
│  │                         │                                         │   │
│  │                         ▼                                         │   │
│  │                  ┌────────────┐                                   │   │
│  │                  │ 应用配置   │                                   │   │
│  │                  │ wifi reload│                                   │   │
│  │                  └────────────┘                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 同步状态流转

```
┌─────────────────────────────────────────────────────────────────┐
│                       同步状态流转图                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   ┌─────────┐                                                   │
│   │  IDLE   │ ◄─────────────────────────────────────┐          │
│   │   (0)   │                                        │          │
│   └────┬────┘                                        │          │
│        │                                             │          │
│        │ 开始同步                                    │          │
│        ▼                                             │          │
│   ┌─────────┐                                        │          │
│   │ SYNCING │                                        │          │
│   │   (1)   │                                        │          │
│   └────┬────┘                                        │          │
│        │                                             │          │
│        ├─────────────────┬───────────────────┐      │          │
│        │                 │                   │      │          │
│        ▼                 ▼                   │      │          │
│   ┌─────────┐      ┌─────────┐               │      │          │
│   │ SUCCESS │      │ FAILED  │               │      │          │
│   │   (2)   │      │   (3)   │               │      │          │
│   └────┬────┘      └────┬────┘               │      │          │
│        │                │                    │      │          │
│        └────────────────┴────────────────────┘      │          │
│                         │                           │          │
│                         │ 重新同步                  │          │
│                         └───────────────────────────┘          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### 状态查询

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getSyncStatus()` | 无 | `result:table` 包含status, last_sync_time, error_message | 获取WiFi配置同步状态 |

### 配置获取

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getWifiConfig()` | 无 | `config:table` WiFi配置信息 | 获取当前WiFi配置 |
| `getExtenderWifiConfig(extenderIp)` | `extenderIp:string` 扩展器IP | `config:table` 或 nil | 获取扩展器WiFi配置 |

### 同步操作

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `syncToExtender(extenderIp, config)` | `extenderIp:string`, `config:table` 可选 | `errorCode:number` 0=成功 | 同步配置到指定扩展器 |
| `syncToAllExtenders()` | 无 | `results:table` 同步结果列表 | 同步配置到所有扩展器 |

### 配置应用(扩展器端)

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `applyWifiConfig(config)` | `config:table` WiFi配置 | `errorCode:number` 0=成功 | 接收并应用WiFi配置 |

### 工具函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `isExtenderOnline(extenderIp)` | `extenderIp:string` 扩展器IP | `online:boolean` | 检查扩展器是否在线 |

## 同步状态常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `SYNC_STATUS_IDLE` | 0 | 空闲状态 |
| `SYNC_STATUS_SYNCING` | 1 | 同步中 |
| `SYNC_STATUS_SUCCESS` | 2 | 同步成功 |
| `SYNC_STATUS_FAILED` | 3 | 同步失败 |

## 错误码

| 错误码 | 说明 |
|--------|------|
| 0 | 操作成功 |
| 1 | 参数错误 |
| 2 | 连接失败 |
| 3 | 同步失败 |

## 数据结构

### WiFi配置结构

```lua
{
    wifi_24g = {
        ssid = "MyWiFi",           -- 网络名称
        encryption = "psk2",        -- 加密方式
        key = "password123",        -- 密码
        hidden = "0",               -- 是否隐藏 (0/1)
        disabled = "0"              -- 是否禁用 (0/1)
    },
    wifi_5g = {
        ssid = "MyWiFi_5G",
        encryption = "psk2",
        key = "password123",
        hidden = "0",
        disabled = "0"
    },
    guest_wifi = {
        ssid = "Guest",
        encryption = "psk2",
        key = "guestpass",
        disabled = "1"              -- 默认禁用
    }
}
```

### 同步状态结构

```lua
{
    status = 0,                     -- 同步状态码
    last_sync_time = "1703404800",  -- 最后同步时间戳
    error_message = ""              -- 错误信息
}
```

### 同步结果结构

```lua
{
    {
        ip = "192.168.31.100",
        name = "扩展器1",
        code = 0                    -- 同步结果码
    },
    {
        ip = "192.168.31.101",
        name = "扩展器2",
        code = 2                    -- 连接失败
    }
}
```

## 外部依赖

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI配置读写 |
| `luci.util` | 命令执行 |
| `luci.jsonc` | JSON编解码 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.module.XQExtendWifi` | 扩展器列表获取 |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具函数 |

## 被引用情况

该模块主要被以下组件引用：
- Mesh网络管理界面
- WiFi设置变更钩子
- 扩展器配置同步API

## 关键代码说明

### 配置获取

```lua
function getWifiConfig()
    local cursor = uci.cursor()
    local result = {}
    
    -- 获取2.4G WiFi配置
    result.wifi_24g = {}
    result.wifi_24g.ssid = cursor:get("wireless", "default_radio0", "ssid") or ""
    result.wifi_24g.encryption = cursor:get("wireless", "default_radio0", "encryption") or ""
    result.wifi_24g.key = cursor:get("wireless", "default_radio0", "key") or ""
    result.wifi_24g.hidden = cursor:get("wireless", "default_radio0", "hidden") or "0"
    result.wifi_24g.disabled = cursor:get("wireless", "default_radio0", "disabled") or "0"
    
    -- 5G和访客WiFi类似...
    
    return result
end
```

### 同步到扩展器

```lua
function syncToExtender(extenderIp, config)
    -- 设置同步状态为同步中
    cursor:set("xiaoqiang", "common", "WIFI_SYNC_STATUS", tostring(SYNC_STATUS_SYNCING))
    cursor:commit("xiaoqiang")
    
    -- 构建同步请求
    local configJson = json.stringify(wifiConfig)
    local syncUrl = string.format("http://%s/cgi-bin/luci/api/xqsystem/wifi_sync", extenderIp)
    
    -- 发送HTTP POST请求
    local curlCmd = string.format(
        "curl -s -X POST -H 'Content-Type: application/json' -d '%s' '%s' 2>/dev/null",
        configJson,
        syncUrl
    )
    
    local response = luciUtil.exec(curlCmd)
    
    -- 处理响应并更新状态...
end
```

### 批量同步

```lua
function syncToAllExtenders()
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    local results = {}
    
    -- 获取扩展器列表
    local extenders = XQExtendWifi.getExtenderList()
    
    -- 获取当前WiFi配置
    local wifiConfig = getWifiConfig()
    
    -- 遍历同步
    for _, extender in ipairs(extenders) do
        if extender.online == 1 and not XQFunction.isStrNil(extender.ip) then
            local result = {
                ip = extender.ip,
                name = extender.name,
                code = syncToExtender(extender.ip, wifiConfig)
            }
            table.insert(results, result)
        end
    end
    
    return results
end
```

### 配置应用(扩展器端)

```lua
function applyWifiConfig(config)
    local cursor = uci.cursor()
    
    -- 应用2.4G WiFi配置
    if config.wifi_24g then
        local wifi24g = config.wifi_24g
        if wifi24g.ssid then
            cursor:set("wireless", "default_radio0", "ssid", wifi24g.ssid)
        end
        -- 其他配置项...
    end
    
    -- 提交配置
    cursor:commit("wireless")
    
    -- 重启无线
    XQFunction.forkExec("wifi reload")
    
    return 0
end
```

### 在线检测

```lua
function isExtenderOnline(extenderIp)
    -- ping检测，超时2秒
    local pingCmd = string.format("ping -c 1 -W 2 %s >/dev/null 2>&1 && echo 1 || echo 0", extenderIp)
    local result = luciUtil.exec(pingCmd)
    
    return result and result:match("1")
end
```

## UCI配置项

| 配置路径 | 说明 |
|----------|------|
| `xiaoqiang.common.WIFI_SYNC_STATUS` | 同步状态 |
| `xiaoqiang.common.WIFI_LAST_SYNC_TIME` | 最后同步时间 |
| `xiaoqiang.common.WIFI_SYNC_ERROR` | 同步错误信息 |
| `wireless.default_radio0.*` | 2.4G WiFi配置 |
| `wireless.default_radio1.*` | 5G WiFi配置 |
| `wireless.guest.*` | 访客WiFi配置 |
