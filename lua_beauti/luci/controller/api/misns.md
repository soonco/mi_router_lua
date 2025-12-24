# misns.lua - 小米社交网络分享 API 控制器模块

## 概述

小米社交网络分享 API 控制器模块（Mi SNS API Controller），提供 WiFi 共享和社交网络相关的 API 接口，包括 WiFi 共享开关控制、共享信息获取、社交网络列表管理、访客 WiFi 黑名单管理和授权状态查询等功能。

**文件路径**: `luci/controller/api/misns.lua`  
**模块名称**: `luci.controller.api.misns`  
**API 路径**: `/api/misns/*`

## 工作原理

1. **WiFi 共享**: 通过访客网络实现 WiFi 共享功能
2. **社交网络集成**: 支持通过社交网络分享 WiFi 密码
3. **安全控制**: 提供黑名单管理和授权状态检查
4. **设备识别**: 自动获取客户端 MAC 地址和 DHCP 信息

## 接口/函数列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `check_para(param)` | param: string | boolean | 参数安全检查，检测危险字符 |
| `getGuestWifi_ssid_guest()` | 无 | string | 生成基于 MAC 地址的访客 WiFi SSID |

### API 端点

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misns/prepare` | `prepare()` | WiFi 共享准备（未支持） |
| `/api/misns/prepare_bytype` | `prepare()` | 按类型准备 WiFi 共享（未支持） |
| `/api/misns/prepare_status` | `prepareStatus()` | 获取准备状态（未支持） |
| `/api/misns/wifi_share_switch` | `wifiShare()` | WiFi 共享开关控制 |
| `/api/misns/wifi_access` | `wifiAccess()` | WiFi 访问控制（未支持） |
| `/api/misns/wifi_share_info` | `wifiShareInfo()` | 获取 WiFi 共享信息 |
| `/api/misns/wifi_share_info_web` | `wifiShareInfoWeb()` | 获取 Web 端 WiFi 共享信息 |
| `/api/misns/wifi_share_clear` | `wifiShareClearAll()` | 清除所有 WiFi 共享（未支持） |
| `/api/misns/wifi_share_rent_switch` | `wifiShareRentSwitch()` | WiFi 共享租赁开关（未支持） |
| `/api/misns/sns_list` | `snsList()` | 获取社交网络列表（未支持） |
| `/api/misns/sns_init` | `snsInit()` | 社交网络初始化 |
| `/api/misns/wifi_share_blist` | `wifiShareBlacklist()` | 获取共享黑名单（未支持） |
| `/api/misns/wifi_share_blist_edit` | `wifiShareBlacklistEdit()` | 编辑共享黑名单（未支持） |
| `/api/misns/authorization_status` | `authorizationStatus()` | 获取授权状态（未支持） |
| `/api/misns/ios_ready` | `iosReady()` | iOS 就绪状态（未支持） |

### 详细接口说明

#### wifiShare - WiFi 共享开关

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| info | string | 是 | JSON 格式的共享配置信息 |

**配置信息结构**:
```json
{
    "guest_index": 1,
    "enable": true,
    "ssid": "GuestWiFi",
    "password": "12345678"
}
```

**返回值**:
```json
{
    "code": 0
}
```

#### wifiShareInfo - 获取 WiFi 共享信息

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| guest_index | number | 否 | 访客网络索引，默认 1 |

**返回值**:
```json
{
    "code": 0,
    "info": {
        "enable": true,
        "ssid": "GuestWiFi"
    },
    "closingTime": 3600
}
```

#### snsInit - 社交网络初始化

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| callback | string | 否 | JSONP 回调函数名 |

**返回值**:
```json
{
    "code": 0,
    "clientinfo": "encrypted_info",
    "ssid": "小米共享WiFi_XXXX",
    "deviceid": "device_id"
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `xiaoqiang.module.XQWifiShare` | WiFi 共享模块 |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.util` | LuCI 工具函数 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQNetUtil` | 网络工具 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `json` | JSON 编解码 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/misns/*` 路径下自动加载
- 小米路由器 APP 调用进行 WiFi 共享管理
- Web 管理界面的访客网络模块

## 访客 WiFi SSID 生成规则

根据国家代码和设备类型生成不同前缀的 SSID：

| 国家 | 设备类型 | SSID 前缀 |
|------|----------|-----------|
| CN | Redmi | `Redmi共享WiFi_` |
| CN | 小米 | `小米共享WiFi_` |
| 其他 | 任意 | `MiShareWiFi_` |

SSID 后缀为 WAN 口 MAC 地址的后 4 位（大写）。

## 安全检查

模块包含参数安全检查函数，检测以下危险字符：
- 反引号 (`)
- 分号 (;)
- 单引号 (')
- 管道符 (|)
- 美元符号 ($)
- 与符号 (&)
- 花括号 ({})
- 空格

## 关键代码说明

### 客户端信息加密

```lua
function snsInit()
    local remoteMac = luci.dispatcher.getremotemac()
    local dhcpInfo = dhcpDict[remoteMac] or {}
    
    -- 使用 matool 加密客户端信息
    local encCmd = string.format(
        "matool --method enc --params \"{\\\"mac\\\":\\\"%s\\\",\\\"dhcp\\\":\\\"%s\\\"}\"",
        remoteMac,
        dhcpName
    )
    local clientInfo = luciUtil.trim(luciUtil.exec(encCmd))
end
```

### WiFi 共享配置

```lua
function wifiShare()
    local info = http.formvalue("info", nil, "json")
    local success, config = pcall(json.decode, info)
    
    if config.guest_index == nil then
        config.guest_index = 1
    end
    
    XQWifiShare.set_wifi_share(config)
end
```

## 注意事项

大部分功能标记为 "Not Supported Now"，表示当前版本未实现或已废弃。主要可用功能包括：
- `wifiShare()`: WiFi 共享开关
- `wifiShareInfo()`: 获取共享信息
- `wifiShareInfoWeb()`: Web 端共享信息
- `snsInit()`: 社交网络初始化
