# XQPushUtil.lua - 推送工具模块

## 概述

小米路由器推送通知和设备认证管理工具模块，提供推送设置、时间戳管理、认证失败记录、管理设备管理等功能。用于设备接入通知、安全告警等场景。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   事件触发       | --> |   XQPushUtil     | --> |   UCI配置        |
|  (设备接入等)    |     |  (推送管理)      |     |  (devicelist)    |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    检测新设备             记录认证状态            持久化存储
         |                       |                       |
         v                       v                       v
    触发推送通知           更新失败计数            通知用户
```

### 认证失败追踪

```
+------------------+     +------------------+     +------------------+
|   WiFi认证失败   | --> |   记录失败次数   | --> |   触发告警       |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
+------------------+     +------------------+     +------------------+
|   登录认证失败   | --> |   记录失败频率   | --> |   安全通知       |
+------------------+     +------------------+     +------------------+
```

### 数据存储结构

```
devicelist (UCI配置)
├── settings (core)
│   ├── auth: 是否需要认证
│   ├── quiet: 静默模式
│   └── level: 通知级别
├── timestamp (record)
│   └── {key}: 时间戳值
├── authfail (record)
│   └── {mac}: 认证失败次数
├── authfailserial (record)
│   └── {mac}: 连续失败次数
├── wififrequency (record)
│   └── {mac}: WiFi失败频率
├── loginauthfail (record)
│   └── {mac}: 登录失败次数
├── loginfrequency (record)
│   └── {mac}: 登录失败频率
├── notify (record)
│   └── {mac}: 特殊通知状态
└── admin (record)
    └── {deviceId}: 管理设备状态
```

## 接口列表

### 推送设置

#### pushSettings()
获取推送设置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| auth | boolean | 是否需要认证 |
| quiet | boolean | 静默模式 |
| level | number | 通知级别 |
| count | number | 设备数量 |

---

#### pushConfig(key, value)
设置推送配置。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| key | string | 配置键名 |
| value | any | 配置值 |

---

### 时间戳管理

#### getTimestamp(key)
获取时间戳。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| key | string | 时间戳键名 |

**返回值：** `number` - 时间戳值

---

#### setTimestamp(key, value)
设置时间戳。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| key | string | 时间戳键名 |
| value | number | 时间戳值 |

**返回值：** `boolean` - 是否设置成功

---

### WiFi认证失败记录

#### getAuthenFailedTimesDict()
获取认证失败次数字典。

**返回值：** `table` - MAC地址到失败次数的映射

---

#### getAuthenFailedTimes(macAddr)
获取认证失败次数。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| macAddr | string | MAC地址 |

**返回值：** `number` - 失败次数

---

#### setAuthenFailedTimes(macAddr, times)
设置认证失败次数。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| macAddr | string | MAC地址 |
| times | number | 失败次数 |

---

#### getwifiauthfailedserialtimes(macAddr)
获取WiFi认证连续失败次数。

**返回值：** `number` - 连续失败次数

---

#### setwifiauthfailedserialtimes(macAddr, times)
设置WiFi认证连续失败次数。

---

#### getWifiAuthenFailedFrequencyDict()
获取WiFi认证失败频率字典。

**返回值：** `table` - MAC地址到失败频率的映射

---

#### getWifiAuthenFailedFrequency(macAddr)
获取WiFi认证失败频率。

**返回值：** `number` - 失败频率

---

#### setWifiAuthenFailedFrequency(macAddr, freq)
设置WiFi认证失败频率。

---

### 登录认证失败记录

#### getLoginAuthenFailedTimes(macAddr)
获取登录认证失败次数。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| macAddr | string | MAC地址 |

**返回值：** `number` - 失败次数

---

#### setLoginAuthenFailedTimes(macAddr, times)
设置登录认证失败次数。

---

#### getLoginAuthenFailedFrequency(macAddr)
获取登录认证失败频率。

**返回值：** `number` - 失败频率

---

#### setLoginAuthenFailedFrequency(macAddr, freq)
设置登录认证失败频率。

---

### 特殊通知

#### specialNotify(macAddr)
检查特殊通知状态。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| macAddr | string | MAC地址 |

**返回值：** 
- `boolean` - 是否有通知
- `number` - 通知级别

---

#### setSpecialNotify(macAddr, enable, level)
设置特殊通知。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| macAddr | string | MAC地址 |
| enable | boolean | 是否启用 |
| level | number | 通知级别 |

**返回值：** `boolean` - 是否设置成功

---

#### notifyDict()
获取通知字典。

**返回值：** `table` - MAC地址到通知状态的映射

---

### 管理设备管理

#### getAdminDevice(deviceId)
获取管理设备信息。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| deviceId | string | 设备ID |

**返回值：** `number` - 管理设备状态

---

#### getAdminDevices()
获取所有管理设备。

**返回值：** `table` - 设备ID到状态的映射

---

#### setAdminDevice(deviceId, status)
设置管理设备。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| deviceId | string | 设备ID |
| status | string | 设备状态 |

---

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| luci.model.uci | UCI配置接口 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API控制器
- `xiaoqiang/module/XQAntiRubNetwork.lua` - 防蹭网模块
- `xiaoqiang/util/XQDeviceUtil.lua` - 设备工具

## 关键代码说明

### MAC地址格式化

```lua
function getAuthenFailedTimes(macAddr)
    if XQFunction.isStrNil(macAddr) then
        return
    else
        macAddr = XQFunction.macFormat(macAddr)
    end
    
    local macKey = macAddr:gsub(":", "")
    local authFailData = uci:get_all("devicelist", "authfail")
    
    if not authFailData then
        uci:section("devicelist", "record", "authfail", {})
        uci:commit("devicelist")
        return 0
    else
        local times = uci:get("devicelist", "authfail", macKey)
        return tonumber(times) or 0
    end
end
```

MAC地址去除冒号后作为UCI配置的键名，确保键名合法。

### 配置节自动创建

```lua
function setAuthenFailedTimes(macAddr, times)
    local authFailData = uci:get_all("devicelist", "authfail")
    
    if not authFailData then
        authFailData = {}
    end
    
    authFailData[macKey] = times
    uci:section("devicelist", "record", "authfail", authFailData)
    uci:commit("devicelist")
end
```

如果配置节不存在，自动创建后再设置值。

### 特殊通知管理

```lua
function setSpecialNotify(macAddr, enable, level)
    local notifyData = uci:get_all("devicelist", "notify")
    
    if not notifyData then
        uci:section("devicelist", "record", "notify", {})
        uci:commit("devicelist")
    end
    
    if enable then
        local existingNotify = uci:get("devicelist", "notify", macKey)
        if not existingNotify then
            uci:set("devicelist", "notify", macKey, 1)
        else
            uci:set("devicelist", "notify", macKey, level)
        end
    else
        uci:delete("devicelist", "notify", macKey)
    end
    
    uci:commit("devicelist")
    return true
end
```

支持启用/禁用特殊通知，以及设置通知级别。

### 推送设置获取

```lua
function pushSettings()
    local settings = {
        auth = true,
        quiet = false,
        level = 2
    }
    
    local deviceSettings = uci:get_all("devicelist", "settings")
    
    if deviceSettings then
        if deviceSettings.auth == 0 then
            settings.auth = false
        else
            settings.auth = true
        end
        settings.quiet = deviceSettings.quiet
        settings.level = deviceSettings.level
    end
    
    return settings
end
```

提供默认值，确保即使配置不存在也能返回有效的设置。
