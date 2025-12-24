# XQSynchrodata.lua - 数据同步工具模块

## 概述

XQSynchrodata 是小米路由器的配置数据同步工具模块，负责将路由器本地配置数据同步到小米云端服务器。支持同步路由器名称、WiFi SSID、QoS 配置、OTA 信息、设备信息等多种数据类型。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                      数据同步架构                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    本地配置数据                          │    │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐    │    │
│  │  │路由名称 │  │WiFi SSID│  │QoS配置  │  │设备信息 │    │    │
│  │  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘    │    │
│  └───────┼────────────┼────────────┼────────────┼──────────┘    │
│          │            │            │            │                │
│          ▼            ▼            ▼            ▼                │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                  messageClient                           │    │
│  │  ┌─────────────────────────────────────────────────┐   │    │
│  │  │  messageClient.send(key, value)                  │   │    │
│  │  │  • router_name      - 路由器名称                 │   │    │
│  │  │  • router_locale    - 语言区域                   │   │    │
│  │  │  • ssid_24G/5G      - WiFi SSID                  │   │    │
│  │  │  • work_mode        - 工作模式                   │   │    │
│  │  │  • qos_info         - QoS 配置                   │   │    │
│  │  │  • auto_ota_rom     - OTA 自动更新               │   │    │
│  │  │  • device_info      - 设备信息                   │   │    │
│  │  └─────────────────────────────────────────────────┘   │    │
│  └────────────────────────┬────────────────────────────────┘    │
│                           │                                      │
│                           ▼                                      │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    备用方案                              │    │
│  │  matool --method setKVB64 --params "key" "base64_value" │    │
│  └─────────────────────────────────────────────────────────┘    │
│                           │                                      │
│                           ▼                                      │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    小米云端服务                          │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### 基础同步接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `syncRouterName(routerName)` | routerName: string | 无 | 同步路由器名称 |
| `syncRouterLocale(locale)` | locale: string | 无 | 同步路由器语言区域设置 |
| `syncWiFiSSID(ssid24g, ssid5g)` | ssid24g, ssid5g: string | 无 | 同步 WiFi SSID |
| `syncWorkMode(workMode)` | workMode: number | 无 | 同步工作模式 |
| `syncActiveApcliMode(apcliMode)` | apcliMode: number | 无 | 同步主动 AP 客户端模式 |
| `syncApLanIp(lanIp)` | lanIp: string | 无 | 同步 AP 模式下的 LAN IP |
| `syncProtectionStatus(enabled, mode)` | enabled: boolean, mode: number | 无 | 同步安全保护状态 |

### 复杂数据同步

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `uploadConf(config)` | config: table | 无 | 上传配置到云端 |
| `syncQosInfo()` | 无 | 无 | 同步 QoS 信息 |
| `syncOTAInfo()` | 无 | 无 | 同步 OTA 自动更新信息 |
| `syncDeviceInfo(deviceInfo)` | deviceInfo: table | 无 | 同步设备信息 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `json` | JSON 编解码 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.common.XQConfigs` | 系统配置常量 |
| `messageclient` | 消息客户端（可选） |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（备用方案） |
| `xiaoqiang.util.XQQoSUtil` | QoS 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQPushUtil` | 推送工具 |
| `xiaoqiang.util.XQDBUtil` | 数据库工具 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `xiaoqiang.module.XQParentControl` | 家长控制模块 |
| `xiaoqiang.module.XQPredownload` | 预下载模块 |

## 被引用情况

- `xiaoqiang/util/XQSysUtil.lua` - 系统工具（配置上传）
- `luci/controller/api/xqsystem.lua` - 系统 API
- `luci/controller/api/xqnetwork.lua` - 网络 API

## 关键代码说明

### 消息客户端初始化

```lua
-- 尝试加载 messageclient 模块
local messageClientLoaded, messageClient = pcall(require, "messageclient")

-- 如果加载失败，使用备用方案
if not messageClientLoaded then
    messageClient = {}
    messageClient.send = _sendData  -- 使用 matool 命令
end
```

### 备用发送方案

```lua
local function _sendData(key, value)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    if not XQFunction.isStrNil(key) and not XQFunction.isStrNil(value) then
        -- 使用 matool 命令，值进行 Base64 编码
        os.execute(string.format(
            "matool --method setKVB64 --params \"%s\" \"%s\"",
            key,
            XQCryptoUtil.binaryBase64Enc(value)
        ))
    end
end
```

### 设备信息同步数据结构

```lua
-- syncDeviceInfo 同步的数据结构
local syncData = {
    mac = "AA:BB:CC:DD:EE:FF",  -- MAC 地址
    lan = 1,                     -- LAN 访问权限
    wan = 1,                     -- WAN 访问权限
    admin = 1,                   -- 管理权限
    limited = 0,                 -- 是否受限
    nickname = "设备昵称",       -- 设备昵称
    pridisk = 0,                 -- 私有磁盘访问
    owner = "用户ID",            -- 所有者
    device = "设备类型",         -- 设备类型
    push = 0,                    -- 推送级别
    pcontrol = {},               -- 家长控制规则
    netacctl = {},               -- 网络访问控制
    urlfilter = {}               -- URL 过滤信息
}
```

### QoS 信息同步

```lua
function syncQosInfo()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取所有设备 MAC 列表
    local macList = XQDeviceUtil.getDeviceMacsFromDB()
    
    -- 获取 QoS 历史记录
    local qosHistory = XQQoSUtil.qosHistory(macList)
    
    -- 添加访客和本地设备 QoS 信息
    qosHistory.guest = XQQoSUtil.guestQoSInfo()
    qosHistory["local"] = XQQoSUtil.xqQoSInfo()
    
    -- 发送到云端
    messageClient.send("qos_info", json.encode(qosHistory))
end
```

### 同步键值对照表

| 同步键 | 数据类型 | 说明 |
|--------|----------|------|
| `router_name` | string | 路由器名称 |
| `router_locale` | string | 语言区域代码 |
| `ssid_24G` | string | 2.4GHz WiFi SSID |
| `ssid_5G` | string | 5GHz WiFi SSID |
| `work_mode` | string | 工作模式编号 |
| `active_apcli_mode` | string | AP 客户端模式 |
| `ap_lan_ip` | string | AP 模式 LAN IP |
| `protection_enabled` | string | 安全保护开关 |
| `protection_mode` | string | 安全保护模式 |
| `qos_info` | JSON | QoS 配置信息 |
| `auto_ota_rom` | string | ROM 自动更新 |
| `auto_ota_plugin` | string | 插件自动更新 |
| `device_info` | JSON | 设备详细信息 |
