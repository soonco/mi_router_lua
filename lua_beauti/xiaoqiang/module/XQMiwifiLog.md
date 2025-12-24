# XQMiwifiLog.lua - 日志管理模块

## 概述

`MiwifiLog` 是小米路由器的安全日志管理模块，提供安全事件日志的查询、解析、删除等功能。该模块通过ubus与`miwifi-logd`服务通信，使用SQLite数据库存储日志，支持多种安全事件类型的记录和展示。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    日志管理系统架构                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    安全事件来源                          │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐   │   │
│  │  │ 网关攻击  │ │ 设备连接  │ │ 系统事件  │ │ 网络状态  │   │   │
│  │  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘   │   │
│  └───────┼────────────┼────────────┼────────────┼─────────┘   │
│          │            │            │            │              │
│          └────────────┴─────┬──────┴────────────┘              │
│                             ▼                                   │
│                    ┌─────────────────┐                         │
│                    │  miwifi-logd    │                         │
│                    │  (日志服务)      │                         │
│                    └────────┬────────┘                         │
│                             │                                   │
│                             ▼                                   │
│                    ┌─────────────────┐                         │
│                    │  SQLite数据库    │                         │
│                    │  ┌───────────┐  │                         │
│                    │  │ LOG表     │  │                         │
│                    │  │ TAG表     │  │                         │
│                    │  └───────────┘  │                         │
│                    └────────┬────────┘                         │
│                             │                                   │
│                             ▼                                   │
│                    ┌─────────────────┐                         │
│                    │  MiwifiLog      │                         │
│                    │  (查询/解析)     │                         │
│                    └─────────────────┘                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 日志类型

```
安全事件类型 (LOG_TYPE_CONFIG)
├── 攻击防护
│   ├── sec_risk_gw        -- 网关安全风险
│   ├── sec_risk_flood     -- 泛洪攻击
│   ├── sec_risk_portscan  -- 端口扫描
│   ├── sec_risk_ipscan    -- IP扫描
│   └── sec_risk_web       -- 网页安全风险
│
├── 系统事件
│   ├── sec_sys_restart    -- 系统重启
│   ├── sec_sys_internet   -- 网络连接状态
│   ├── sec_sys_addre      -- 加入Mesh网络
│   └── sec_sys_wlanpwd    -- WiFi密码修改
│
└── 设备事件
    ├── sec_nic_internet   -- 设备联网限制
    ├── sec_nic_connect    -- 设备连接状态
    ├── sec_nic_blacklist  -- 设备黑名单
    └── sec_nic_whitelist  -- 设备白名单
```

### 数据库结构

```
LOG表:
├── ID         -- 日志ID
├── TIMESTAMP  -- 时间戳
└── MSG        -- JSON格式消息

TAG表:
├── LOG_ID     -- 关联日志ID
└── NAME       -- 标签名称(用于分类)
```

## 接口列表

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_device_map()` | 无 | table | 获取设备名称映射表 |
| `exec_sql(sql)` | sql: string | table | 执行SQL查询 |
| `get_stat_from_sql(sql, expectedCount)` | sql: string, expectedCount: number | ... | 从SQL获取统计值 |
| `get_cnt_by_prefix(prefix)` | prefix: string | number | 按前缀统计日志数量 |
| `get_ids_from_str(idStr)` | idStr: string | table | 解析ID字符串 |
| `del_by_ids(idStr)` | idStr: string | 无 | 按ID删除日志 |
| `del_by_days(days, prefix)` | days: number, prefix: string | 无 | 按天数删除日志 |
| `format_display_str(config, data)` | config: table, data: table | string | 格式化显示字符串 |
| `parse_json_msg(timestamp, jsonMsg)` | timestamp: number, jsonMsg: string | tag, msg, ext, mac | 解析JSON日志消息 |
| `get_logs_cnt(days, timestamp, prefix)` | days, timestamp: number, prefix: string | number | 获取日志数量 |
| `get_logs(days, timestamp, prefix, limit, offset)` | 见下表 | table | 获取日志列表 |

### 参数说明

**get_logs 参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| days | number | 查询天数 |
| timestamp | number | 截止时间戳 |
| prefix | string | 标签前缀 |
| limit | number | 返回数量限制 |
| offset | number | 偏移量 |

### 返回值说明

**日志列表项结构:**
```lua
{
    date = "2024-01-15",     -- 日期
    time = "14:30",          -- 时间
    ts = "1705301400",       -- 时间戳
    id = 123,                -- 日志ID
    type = "sec_nic_connect",-- 日志类型
    msg = "已上线",           -- 主消息
    ext = "",                -- 扩展信息
    mac = "AA:BB:CC:DD:EE:FF",-- MAC地址
    dev = "AA:BB:CC:DD:EE:FF" -- 设备标识
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `cjson` | JSON解析 |
| `ubus` | 与miwifi-logd服务通信 |
| `xiaoqiang.util.XQDeviceUtil` | 获取设备列表和名称 |

### 系统依赖

| 服务 | 用途 |
|------|------|
| `miwifi-logd` | 日志存储服务(ubus接口) |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 安全日志查询接口 |
| 安全中心 | 安全事件展示 |
| 小米WiFi App | 安全日志查看 |

## 关键代码说明

### SQL查询执行

```lua
function MiwifiLog.exec_sql(sql)
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    -- 通过ubus调用miwifi-logd服务
    local response = conn:call("miwifi-logd", "query", {sql = sql})
    if response.code == 0 then
        return response.result
    end
    return {}
end
```

### 日志类型配置

```lua
local LOG_TYPE_CONFIG = {
    -- 设备连接状态
    sec_nic_connect = {
        msg = {
            tpl = _("已%s"),
            arg = {"connected"},
            map = {
                connected = {
                    ["false"] = _("断开"),
                    ["true"] = _("上线")
                }
            }
        }
    },
    -- 泛洪攻击
    sec_risk_flood = {
        msg = { tpl = _("已拦截 网络拒绝访问攻击") },
        ext = {
            tpl = _("%s在%s对%s发起了泛洪攻击"),
            arg = {"mac", "timestamp", "dstmac"},
            map = {
                mac = get_dev_name,      -- 函数映射
                timestamp = get_time,
                dstmac = get_dev_name
            }
        }
    }
}
```

### 消息格式化

```lua
function MiwifiLog.format_display_str(config, data)
    local args = {}
    
    for _, argName in ipairs(config.arg or {}) do
        local value = data[argName]
        local mapType = type(config.map[argName])
        
        if mapType == "table" then
            -- 表映射: 根据值查找显示文本
            value = config.map[argName][tostring(value)] or value
        elseif mapType == "function" then
            -- 函数映射: 调用函数转换值
            value = config.map[argName](value) or value
        end
        
        table.insert(args, value)
    end
    
    return string.format(config.tpl, unpack(args))
end
```

### SQL注入防护

```lua
local function is_sql_hack(str)
    return string.find(str, "'") ~= nil
end

function MiwifiLog.get_logs(days, timestamp, prefix, limit, offset)
    -- 检查SQL注入
    if is_sql_hack(prefix) then
        return {}
    end
    -- ... 执行查询
end
```

### 设备名称缓存

```lua
local deviceNameCache = nil

function MiwifiLog.get_device_map()
    if deviceNameCache == nil then
        local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
        local _, deviceList = XQDeviceUtil.getDeviceListV2()
        deviceNameCache = {}
        
        for _, device in ipairs(deviceList) do
            if device.name ~= "" then
                deviceNameCache[device.mac] = device.name
            end
        end
    end
    return deviceNameCache
end
```
