# XQController.lua - 控制器工具模块

## 概述

`XQController` 模块通过 ubus 与 trafficd 服务通信，管理设备的网络访问权限。支持基于 IP 地址和 MAC 地址的权限控制，以及 WiFi MAC 地址过滤功能。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    设备权限控制架构                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │ XQController │───▶│    ubus      │───▶│  trafficd    │  │
│  │   权限设置   │    │   send      │    │   服务      │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│         │                                       │          │
│         ▼                                       ▼          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    权限类型说明                        │  │
│  │  • lan: LAN网络访问权限                               │  │
│  │  • wan: WAN网络访问权限 (上网权限)                    │  │
│  │  • admin: 管理后台访问权限                            │  │
│  │  • pridisk: 私有磁盘访问权限                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### ippermission(ipaddr, lan, wan, admin, pridisk)

基于 IP 地址设置网络访问权限。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| ipaddr | string | IP 地址 |
| lan | number | LAN 访问权限 (0=禁止, 1=允许) |
| wan | number | WAN 访问权限 (0=禁止, 1=允许) |
| admin | number | 管理后台访问权限 (0=禁止, 1=允许) |
| pridisk | number | 私有磁盘访问权限 (0=禁止, 1=允许) |

**返回值:** 无

---

### permission(mac, lan, wan, admin, pridisk)

基于 MAC 地址设置网络访问权限。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| mac | string | MAC 地址 |
| lan | number | LAN 访问权限 (0=禁止, 1=允许) |
| wan | number | WAN 访问权限 (0=禁止, 1=允许) |
| admin | number | 管理后台访问权限 (0=禁止, 1=允许) |
| pridisk | number | 私有磁盘访问权限 (0=禁止, 1=允许) |

**返回值:** 无

---

### wifimacfilter(mac, enable, model, option)

WiFi MAC 地址过滤控制。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| mac | string/nil | MAC 地址（nil 时为全局控制） |
| enable | boolean | 是否启用过滤（当 mac 为 nil 时使用） |
| model | string | 过滤模式 ("whitelist"=白名单, "blacklist"=黑名单) |
| option | string | 操作选项 ("add"=添加, "del"=删除) |

**返回值:** 无

**说明:** 此函数可能未完成实现，内部未调用 `_ubusSend`。

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| json | JSON 编码 |
| trafficd | 流量控制服务（通过 ubus） |

## 被引用情况

- 设备管理 API
- 访问控制功能
- 家长控制模块

## 关键代码说明

### ubus 消息发送

```lua
local function _ubusSend(data)
    local json_str = json.encode(data)
    local cmd = "ubus send trafficd \"" .. XQFunction._cmdformat(json_str) .. "\""
    os.execute(cmd)
end
```

通过 `ubus send` 命令向 trafficd 服务发送 JSON 格式的控制消息。

### API 版本

- `api = 1`: IP/MAC 权限控制接口
- `api = 2`: WiFi MAC 过滤接口

### 权限值说明

| 值 | 含义 |
|---|------|
| 0 | 禁止访问 |
| 1 | 允许访问 |
