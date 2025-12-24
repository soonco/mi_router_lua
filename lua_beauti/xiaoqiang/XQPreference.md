# XQPreference.lua - 偏好设置模块

## 概述

`XQPreference.lua` 是小米路由器的偏好设置模块，提供 UCI 配置的读写封装，支持默认值设置和扩展配置文件访问。

**模块路径**: `xiaoqiang.XQPreference`

## 工作原理

该模块封装了 UCI (Unified Configuration Interface) 的读写操作，提供简洁的 API 用于存取路由器配置。

## 默认配置

| 配置项 | 值 | 说明 |
|-------|-----|------|
| 配置文件 | xiaoqiang | 默认 UCI 配置文件 |
| 配置节点 | common | 默认配置节点 |

## 接口列表

### get(key, default, config)
**功能**: 获取配置值

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| key | string | 是 | 配置键名 |
| default | any | 否 | 默认值（配置不存在时返回）|
| config | string | 否 | 配置文件名（默认为 xiaoqiang）|

**返回值**: 
| 类型 | 说明 |
|-----|------|
| string | 配置值或默认值 |

**示例**:
```lua
local XQPreference = require("xiaoqiang.XQPreference")

-- 读取配置，不存在时返回默认值
local value = XQPreference.get("ROUTER_NAME", "MiWiFi")

-- 指定配置文件
local value2 = XQPreference.get("key", "default", "network")
```

---

### set(key, value, config)
**功能**: 设置配置值

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| key | string | 是 | 配置键名 |
| value | any | 是 | 配置值 |
| config | string | 否 | 配置文件名（默认为 xiaoqiang）|

**返回值**: 
| 类型 | 说明 |
|-----|------|
| boolean | 是否设置成功 |

**示例**:
```lua
-- 设置配置
XQPreference.set("ROUTER_NAME", "MyRouter")

-- 设置到指定配置文件
XQPreference.set("key", "value", "network")
```

---

### get_ext(key, default, config, section)
**功能**: 获取扩展配置值（指定配置文件和节点）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| key | string | 是 | 配置键名 |
| default | any | 否 | 默认值 |
| config | string | 否 | 配置文件名（默认为 xiaoqiang）|
| section | string | 否 | 配置节点名（默认为 common）|

**返回值**: 
| 类型 | 说明 |
|-----|------|
| string | 配置值或默认值 |

**示例**:
```lua
-- 从 network 配置文件的 wan 节点读取
local proto = XQPreference.get_ext("proto", "dhcp", "network", "wan")
```

---

### set_ext(key, value, config, section)
**功能**: 设置扩展配置值（指定配置文件和节点）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| key | string | 是 | 配置键名 |
| value | any | 是 | 配置值 |
| config | string | 否 | 配置文件名（默认为 xiaoqiang）|
| section | string | 否 | 配置节点名（默认为 common）|

**返回值**: 
| 类型 | 说明 |
|-----|------|
| boolean | 是否设置成功 |

**示例**:
```lua
-- 设置到 network 配置文件的 wan 节点
XQPreference.set_ext("proto", "pppoe", "network", "wan")
```

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `luci.util` | LuCI 工具函数 |
| `luci.model.uci` | UCI 配置管理 |

## 被引用情况

该模块被广泛用于：
- 系统配置存取
- 用户偏好设置
- 功能开关状态保存
- 临时数据缓存

## 关键代码说明

### 配置读取实现
```lua
function get(key, default, config)
    config = config or DEFAULT_CONFIG
    
    local uci = luci.model.uci.cursor()
    local value = uci:get(config, DEFAULT_SECTION, key)
    
    if not value then
        return default
    end
    
    return value
end
```

### 配置写入实现
```lua
function set(key, value, config)
    config = config or DEFAULT_CONFIG
    
    local uci = luci.model.uci.cursor()
    
    if value == nil then
        value = ""
    end
    
    uci:set(config, DEFAULT_SECTION, key, value)
    uci:save(config)
    return uci:commit(config)
end
```
