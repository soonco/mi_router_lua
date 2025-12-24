# XQPushHelper.lua - 推送助手模块

## 概述

`XQPushHelper.lua` 是小米路由器的推送通知助手模块，负责处理设备连接/断开、系统升级等事件的推送通知。该模块通过 `matool` 和 `eventservice` 发送推送消息到小米手机APP，支持小米生态链设备的智能识别和过滤。

**文件位置**: `xiaoqiang/XQPushHelper.lua`  
**模块名**: `xiaoqiang.XQPushHelper`  
**代码行数**: ~328行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    推送通知处理流程                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  事件触发                                                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │WiFi连接  │  │WiFi断开  │  │系统升级  │                  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘                  │
│       │             │             │                         │
│       ▼             ▼             ▼                         │
│  ┌─────────────────────────────────────────┐               │
│  │           特殊设备过滤                   │               │
│  │  - 创米智能插座                          │               │
│  │  - Yeelight灯具                          │               │
│  │  - 绿米网关                              │               │
│  │  - 智米空气净化器                        │               │
│  │  - 小米中继器                            │               │
│  └─────────────────────────────────────────┘               │
│       │                                                     │
│       ▼                                                     │
│  ┌─────────────────────────────────────────┐               │
│  │           推送类型判断                   │               │
│  │  type=1:  系统升级完成                   │               │
│  │  type=3:  陌生设备上线                   │               │
│  │  type=23: 小米路由器中继成功             │               │
│  │  type=27: 访客网络设备上线               │               │
│  │  type=56: 小米中继器连接                 │               │
│  └─────────────────────────────────────────┘               │
│       │                                                     │
│       ▼                                                     │
│  ┌─────────────────────────────────────────┐               │
│  │           发送推送                       │               │
│  │  matool --method notify --params "..."   │               │
│  │  或 ubus call eventservice fcw_notify    │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 内部辅助函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_exception(dhcpname)` | dhcpname: string | boolean | 检查是否为特殊设备（不推送） |
| `_doPush(payload, title, content, priority, async)` | 多参数 | 无 | 执行matool推送通知 |
| `_doEventServicePush(event_type, mac, name, count)` | 多参数 | 无 | 通过eventservice发送推送 |
| `_matool(events, async)` | events: string, async: boolean | 无 | 通过matool上报事件 |

### 钩子函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_hookSysUpgraded()` | 无 | 无 | 系统升级完成推送钩子 |
| `_hookWifiConnect(mac, interface)` | mac: string, interface: string | 无 | WiFi设备连接推送钩子 |
| `_hookWifiDisconnect(mac, interface, reason)` | mac: string, interface: string, reason: string | 无 | WiFi设备断开推送钩子 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `json` | JSON编解码 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.common.XQFunction` | 通用函数（macFormat, forkExec等） |
| `xiaoqiang.util.XQPushUtil` | 推送设置工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备信息工具 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQDBUtil` | 数据库工具 |
| `luci.model.uci` | UCI配置读取 |
| `ubus` | ubus通信 |

## 被引用情况

该模块被以下模块引用：
- WiFi驱动层 - 设备连接/断开事件触发
- 系统升级脚本 - 升级完成后触发
- `xiaoqiang.module.XQWifiShare` - WiFi分享相关推送

## 关键代码说明

### 1. 特殊设备过滤列表

```lua
local EXCEPTION_DEVICE_PATTERNS = {
    "^chuangmi%-plug",      -- 创米智能插座
    "^antscam",             -- 蚂蚁摄像头
    "^yeelink%-light",      -- Yeelight灯具
    "^lumi%-gateway",       -- 绿米网关
    "^zhimi%-airpurifier",  -- 智米空气净化器
    "^yunmi%-waterpurifier", -- 云米净水器
    "^midea%-aircondition", -- 美的空调
    "^xiaomirepeater"       -- 小米中继器
}
```

### 2. matool推送实现

```lua
function _doPush(payload, title, content, priority, async)
    -- 格式化推送内容（防止命令注入）
    payload = XQFunction._cmdformat(payload)
    
    -- 构建matool命令
    local cmd = string.format("matool --method notify --params \"%s\"", payload)
    
    -- 执行命令（异步或同步）
    if async then
        XQFunction.forkExec(cmd)
    else
        os.execute(cmd)
    end
    
    XQLog.log(6, "matool notify:", payload)
end
```

### 3. WiFi设备连接处理

```lua
function _hookWifiConnect(mac, interface)
    -- 格式化MAC地址
    mac = XQFunction.macFormat(mac)
    local mac_key = mac:gsub(":", "")
    
    -- 检查设备历史记录
    local device_history = uci:get("devicelist", "history", mac_key)
    local is_new_device = (device_history == nil)
    
    if is_new_device then
        -- 保存新设备到历史记录（最多512条）
        uci:set("devicelist", "history", mac_key, current_time)
        uci:commit("devicelist")
    end
    
    -- 检查是否为小米路由器中继
    if device_name:match("^miwifi") then
        local push_data = { type = 23, name = "小米路由器" }
        _doPush(json.encode(push_data), "中继成功", "中继成功")
        return
    end
    
    -- 检查是否为小米中继器
    if device_name:match("^xiaomirepeater") then
        local push_data = { type = 56, name = "小米中继器", mac = mac }
        _doPush(json.encode(push_data), "中继成功", "中继成功")
        return
    end
    
    -- 新设备上线推送
    if is_new_device then
        local push_data = {
            type = 3,           -- 陌生设备上线
            mac = mac,
            name = device_name
        }
        
        -- 访客网络设备使用不同的推送类型
        if interface == guest_interface then
            push_data.type = 27
        end
        
        _doPush(json.encode(push_data), "陌生设备上线", "陌生设备上线")
    end
end
```

### 4. eventservice推送

```lua
function _doEventServicePush(event_type, mac, name, count)
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        conn:call("eventservice", "fcw_notify", {
            type = event_type,
            mac = mac,
            name = name,
            count = count
        })
        conn:close()
    end
end
```

## 推送类型说明

| 类型代码 | 说明 | 触发场景 |
|----------|------|----------|
| 1 | 系统升级完成 | 固件升级完成后 |
| 3 | 陌生设备上线 | 新设备首次连接WiFi |
| 23 | 小米路由器中继成功 | 小米路由器作为中继连接 |
| 27 | 访客网络设备上线 | 设备连接访客WiFi |
| 56 | 小米中继器连接 | 小米WiFi放大器连接 |

## 设备历史记录

- **存储位置**: UCI配置 `devicelist.history`
- **存储格式**: `MAC地址(无冒号) = 首次连接时间戳`
- **最大记录数**: 512条
- **用途**: 判断设备是否为新设备

## 注意事项

1. **特殊设备过滤**: 小米生态链设备不触发陌生设备上线通知
2. **历史记录限制**: 最多保存512条设备历史记录
3. **推送设置检查**: 发送推送前会检查用户的推送设置
4. **异步执行**: 支持异步发送推送，避免阻塞主流程
5. **命令注入防护**: 使用 `_cmdformat` 格式化推送内容
