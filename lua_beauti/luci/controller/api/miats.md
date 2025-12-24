# miats.lua - 小米 ATS 服务 API 控制器模块

## 概述

小米 ATS 服务 API 控制器模块（Mi ATS Service API Controller），提供小米增值服务相关的 API 接口，包括 Token 验证、WiFi MAC 过滤管理、危险设备检测、网络加速服务、广告拦截、远程调用、游戏加速和 IPv6 加速等功能。

**文件路径**: `luci/controller/api/miats.lua`  
**模块名称**: `luci.controller.api.miats`  
**API 路径**: `/api/miats/*`

## 工作原理

1. **Token 验证**: 所有 API 调用需要通过 token 验证，通过 ubus 调用 `eventservice` 服务验证
2. **ubus 通信**: 大部分功能通过 ubus 与系统服务通信
3. **数据中心**: 加速服务通过数据中心 API 实现
4. **JSONP 支持**: 所有接口支持 JSONP 回调格式

## 接口/函数列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `is_valid_token(token)` | token: string | table {code=0/1} | 验证 token 是否有效 |

### API 端点

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/miats/validate_token_v2` | `validate_token()` | Token 验证接口 |
| `/api/miats/wifi_macfilter_info` | `getWifiMacfilterInfo()` | 获取 WiFi MAC 过滤信息 |
| `/api/miats/set_wifi_blist` | `set_wifi_black_device()` | 设置 WiFi 黑名单设备 |
| `/api/miats/get_wifi_danger_device` | `get_wifi_danger_device()` | 获取 WiFi 危险设备列表 |
| `/api/miats/get_wifi_new_block` | `get_wifi_new_block()` | 获取 WiFi 新拦截设备列表 |
| `/api/miats/get_new_access` | `get_new_access()` | 获取新接入设备列表 |
| `/api/miats/get_cw_event_info` | `get_cw_event_info()` | 获取 CW 事件信息 |
| `/api/miats/remote_call` | `remote_call()` | 远程 API 调用接口 |
| `/api/miats/get_free_speed_up_info` | `get_free_speed_up_info()` | 获取免费加速信息 |
| `/api/miats/free_speed_up` | `free_speed_up()` | 执行免费加速 |
| `/api/miats/vip_speed_up` | `vip_speed_up()` | 执行 VIP 加速 |
| `/api/miats/get_vip_pay_info` | `get_vip_pay_info()` | 获取 VIP 支付信息 |
| `/api/miats/get_speed_up_total_info` | `get_speed_up_total_info()` | 获取加速总计信息 |
| `/api/miats/get_gg_block_info` | `get_ad_block_info()` | 获取广告拦截信息 |
| `/api/miats/valid_show_cb` | `valid_show_cb()` | 验证用户显示回调 |
| `/api/miats/web_enable_show` | `web_enable_show()` | Web 启用显示接口 |
| `/api/miats/uplink_free_speed_up` | `uplink_free_speed_up()` | 上行免费加速 |
| `/api/miats/uplink_get_free_speed_up_info` | `uplink_get_free_speed_up_info()` | 获取上行免费加速信息 |
| `/api/miats/uplink_vip_speed_up` | `uplink_vip_speed_up()` | 上行 VIP 加速 |
| `/api/miats/general_event_get` | `general_event_get()` | 获取通用事件信息 |
| `/api/miats/ccgame` | `turbo_ccgame_call()` | 游戏加速调用接口 |
| `/api/miats/ipv6` | `turbo_ipv6_call()` | IPv6 加速调用接口 |

### 详细接口说明

#### validate_token - Token 验证

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| token | string | 是 | 待验证的 token |
| callback | string | 否 | JSONP 回调函数名 |

**返回值**:
```json
{
    "error": 0,
    "msg": "OK",
    "result": { "code": 0 }
}
```

#### getWifiMacfilterInfo - 获取 MAC 过滤信息

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| token | string | 是 | 验证 token |
| model | number | 否 | WiFi 模式 |
| callback | string | 否 | JSONP 回调函数名 |

#### turbo_ccgame_call - 游戏加速

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| token | string | 是 | 验证 token |
| cmd | number | 是 | 命令 ID (0-9) |
| ip | string | 否 | IP 列表 |
| byvpn | string | 否 | 是否通过 VPN |
| game | string | 否 | 游戏 ID |
| region | string | 否 | 区域 ID |
| ubus | string | 否 | ubus 命令 |

#### turbo_ipv6_call - IPv6 加速

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| token | string | 是 | 验证 token |
| cmd | number | 是 | 命令 ID (0=自定义, 1=启动, 2=停止, 3=状态) |
| ubus | string | 否 | ubus 命令 (cmd=0 时使用) |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.controller.service.datacenter` | 数据中心请求 |
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `cjson` | JSON 编解码 |
| `ubus` | 系统服务通信 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `turbo.ccgame.ccgame_interface` | 游戏加速接口 |

### ubus 服务依赖

- `eventservice`: 事件服务，用于 token 验证和事件获取
- `turbo_ipv6`: IPv6 加速服务

## 被引用情况

- 由 LuCI dispatcher 在 `/api/miats/*` 路径下自动加载
- 小米路由器 APP 调用进行增值服务管理
- Web 管理界面调用进行设备安全管理

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 1 | 无效的参数 |
| 2 | token 已过期 |
| 3 | ubus 错误 |

## 关键代码说明

### Token 验证流程

```lua
function is_valid_token(token)
    local params = { token = token }
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "verify_token", params)
        conn:close()
        return ubusResult or { code = 1 }
    end
    
    return { code = 1 }
end
```

### 数据中心加速请求

```lua
local datacenterRequest = {
    api = 634,
    pluginID = "2882303761517410304",  -- 天翼加速插件 ID
    info = "{\"api\":1002}"             -- 免费加速 API
}
local response = datacenter.requestDatacenter(datacenterRequest)
```
