# XQLog.lua - 日志模块

## 概述

`XQLog.lua` 是小米路由器的日志记录模块，提供系统日志记录和统计打点功能。该模块基于 POSIX syslog 实现，支持不同日志级别和统计数据收集。

**模块路径**: `xiaoqiang.XQLog`

## 工作原理

1. **日志记录**: 使用 POSIX syslog 接口记录日志，支持 0-7 共 8 个日志级别
2. **级别控制**: 通过 UCI 配置 `luci.debuglevel` 控制日志输出级别
3. **统计打点**: 通过特定格式的 syslog 消息实现统计数据收集

## 日志级别

| 级别 | 常量 | 说明 |
|-----|------|------|
| 0 | LOG_EMERG | 紧急 |
| 1 | LOG_ALERT | 警报 |
| 2 | LOG_CRIT | 严重 |
| 3 | LOG_ERR | 错误 |
| 4 | LOG_WARNING | 警告 |
| 5 | LOG_NOTICE | 通知 |
| 6 | LOG_INFO | 信息 |
| 7 | LOG_DEBUG | 调试 |

## 接口列表

### log(level, ...)
**功能**: 记录日志

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| level | number | 是 | 日志级别 (0-7) |
| ... | any | 是 | 日志内容（可以是多个参数）|

**示例**:
```lua
local XQLog = require("xiaoqiang.XQLog")
XQLog.log(6, "This is an info message", {key = "value"})
```

---

### check(mode, key, value)
**功能**: 统计打点记录

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| mode | number | 是 | 模式 (0=无统计, 其他=即时统计) |
| key | string | 是 | 统计键名 |
| value | any | 是 | 统计值 |

**示例**:
```lua
XQLog.check(0, "function_qos", 1)
```

## 统计键名常量

### 基础统计
| 常量 | 值 | 说明 |
|-----|-----|------|
| KEY_GEL_USE | "gel_use" | 凝胶使用 |
| KEY_REBOOT | "gel_restart_soft_count" | 软重启次数 |

### 网络检测
| 常量 | 值 | 说明 |
|-----|-----|------|
| KEY_DETECT_ERROR | "network_detect_error" | 网络检测错误 |

### 网络连接方式
| 常量 | 值 | 说明 |
|-----|-----|------|
| KEY_VALUE_NETWORK_PPPOE | "network_method_pppoe" | PPPoE 拨号 |
| KEY_VALUE_NETWORK_DHCP | "network_method_dhcp" | DHCP 自动获取 |
| KEY_VALUE_NETWORK_STATIC | "network_method_static" | 静态 IP |
| KEY_VALUE_NETWORK_VPN | "network_method_vpn" | VPN 连接 |

### 初始化来源
| 常量 | 值 | 说明 |
|-----|-----|------|
| KEY_GEL_INIT_ANDROID | "gel_init_android" | Android 初始化 |
| KEY_GEL_INIT_IOS | "gel_init_ios" | iOS 初始化 |
| KEY_GEL_INIT_OTHER | "gel_init_other" | 其他方式初始化 |
| KEY_GEL_INIT_APP | "gel_init_app" | App 初始化 |

### 功能使用统计
| 常量 | 值 | 说明 |
|-----|-----|------|
| KEY_FUNC_QOS | "function_qos" | QoS 功能 |
| KEY_FUNC_UPNP | "function_upnp" | UPnP 功能 |
| KEY_FUNC_DMZ | "function_dmz" | DMZ 功能 |
| KEY_FUNC_FIREWALL | "function_firewall" | 防火墙功能 |
| KEY_FUNC_PLUGIN | "function_plugin" | 插件功能 |
| KEY_FUNC_WIFI_BSD | "function_wifi_bsd" | WiFi 双频合一 |
| KEY_FUNC_WIFI_RELAY | "function_relay" | WiFi 中继 |

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `posix` | POSIX 系统调用（syslog）|
| `luci.model.uci` | UCI 配置读取 |
| `json` | JSON 序列化 |

## 被引用情况

该模块被广泛用于：
- API 控制器中的操作日志记录
- 功能使用统计
- 错误和异常记录
- 调试信息输出

## 关键代码说明

### 日志记录实现
```lua
function log(level, ...)
    local debug_level = run_cmd("uci -q get luci.debuglevel")
    
    if level_num >= 0 and level_num <= tonumber(debug_level) then
        posix.openlog("luci", posix.LOG_NDELAY, posix.LOG_USER)
        
        for i = 2, #arg do
            local data = json.serialize_data(arg[i])
            posix.syslog(log_level, data)
        end
        
        posix.closelog()
    end
end
```

### 统计打点实现
```lua
function check(mode, key, value)
    local log_type = (mode == 0) and "stat_points_none" or "stat_points_instant"
    
    posix.openlog("luci", posix.LOG_NDELAY, posix.LOG_USER)
    posix.syslog(6, log_type .. " " .. key .. "=" .. tostring(value))
    posix.closelog()
end
```
