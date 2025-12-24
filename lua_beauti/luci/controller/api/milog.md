# milog.lua - 小米日志控制器模块

## 概述

小米日志控制器模块（Mi Log Controller Module），提供路由器安全日志相关的 API 接口，支持日志开关、概览、删除和获取功能。日志类型包括风险日志(risk)、系统日志(sys)、网卡日志(nic)。

**文件路径**: `luci/controller/api/milog.lua`  
**模块名称**: `luci.controller.api.milog`  
**API 路径**: `/api/mi_log/*`

## 工作原理

1. **配置存储**: 日志开关状态存储在 UCI 配置 `milog.global.enable`
2. **日志分类**: 按前缀分类存储（sec_risk_、sec_sys_、sec_nic_）
3. **分页查询**: 支持按时间范围和分页获取日志
4. **日志分组**: 查询结果按日期分组返回

## 接口/函数列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_overview()` | 无 | table, boolean | 获取日志概览和启用状态 |

### API 端点

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/mi_log/get_onoff` | `getOnOff()` | 获取日志开关状态 |
| `/api/mi_log/set_onoff` | `setOnOff()` | 设置日志开关 |
| `/api/mi_log/overview` | `overview()` | 获取日志概览 |
| `/api/mi_log/del_logs` | `delLogs()` | 删除日志 |
| `/api/mi_log/get_logs` | `getLogs()` | 获取日志列表 |

### 详细接口说明

#### getOnOff - 获取日志开关状态

**请求参数**: 无

**返回值**:
```json
{
    "code": 0,
    "msg": "success",
    "info": {
        "on": 1
    }
}
```

#### setOnOff - 设置日志开关

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| on | string | 否 | "1" 开启，"0" 关闭，默认 "1" |

**返回值**:
```json
{
    "code": 0,
    "msg": "success"
}
```

#### overview - 获取日志概览

**请求参数**: 无

**返回值**:
```json
{
    "code": 0,
    "msg": "success",
    "info": {
        "risk_cnt": 10,
        "sys_cnt": 25,
        "nic_cnt": 5
    }
}
```

#### delLogs - 删除日志

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| type | string | 是 | 删除类型："duration" 按时间删除，其他按 ID 删除 |
| value | string | 是 | 当 type="duration" 时为天数，否则为日志 ID 列表 |
| filter | string | 否 | 日志类型过滤（risk/sys/nic） |

**返回值**:
```json
{
    "code": 0,
    "msg": "success"
}
```

#### getLogs - 获取日志列表

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| type | string | 否 | 日志类型（risk/sys/nic），默认 "sys" |
| tsclient | string | 是 | 客户端时间戳 |
| duration | string | 是 | 时间范围（天数） |
| offset | string | 否 | 偏移量，默认 "0" |
| limit | string | 否 | 每页数量，默认 "10" |

**返回值**:
```json
{
    "code": 0,
    "msg": "success",
    "total": 100,
    "count": 10,
    "info": [
        {
            "date": "2024-01-15",
            "data": [
                {
                    "id": "xxx",
                    "mac": "AA:BB:CC:DD:EE:FF",
                    "dev": "iPhone",
                    "time": "10:30:25",
                    "content": "日志内容"
                }
            ]
        }
    ]
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.module.XQMiwifiLog` | 日志模块核心功能 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.XQLog` | 日志工具 |
| `luci.model.uci` | UCI 配置读写 |

### 系统依赖

- `/etc/init.d/miwifi-logd`: 日志服务守护进程

## 被引用情况

- 由 LuCI dispatcher 在 `/api/mi_log/*` 路径下自动加载
- 小米路由器 APP 调用进行安全日志管理
- Web 管理界面的安全中心模块

## UCI 配置

配置文件: `/etc/config/milog`

```
config global 'global'
    option enable '1'
```

## 日志类型说明

| 前缀 | 类型 | 说明 |
|------|------|------|
| `sec_risk_` | risk | 风险日志，记录安全威胁事件 |
| `sec_sys_` | sys | 系统日志，记录系统操作事件 |
| `sec_nic_` | nic | 网卡日志，记录网络接口事件 |

## 关键代码说明

### 日志分组查询

```lua
function getLogs()
    local logs = XQMiwifiLog.get_logs(duration, tsclient, prefix, offset, limit)
    
    local current_group = nil
    local last_date = nil
    
    for _, log in ipairs(logs) do
        local date = log.date
        
        -- 获取设备名称映射
        local device_map = XQMiwifiLog.get_device_map()
        log.dev = device_map[log.mac] or ""
        
        -- 按日期分组
        if date ~= last_date then
            current_group = { date = date, data = {} }
            table.insert(result.info, current_group)
            last_date = date
        end
        
        table.insert(current_group.data, log)
    end
end
```

### 开关设置与服务重载

```lua
function setOnOff()
    uci:set("milog", "global", "enable", on)
    uci:commit("milog")
    
    -- 重载日志服务
    os.execute("/etc/init.d/miwifi-logd reload")
end
```
