# XQStatPoints.lua - 统计打点模块

## 概述

`XQStatPoints.lua` 是小米路由器的统计打点模块，提供系统日志记录功能。该模块支持通过 POSIX syslog 和文件两种方式记录统计信息，用于用户行为统计、系统运行状态监控和错误日志记录。

**文件位置**: `xiaoqiang/XQStatPoints.lua`  
**模块名**: `xiaoqiang.XQStatPoints`  
**代码行数**: ~63行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    统计打点流程                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │              Log(key, value)             │               │
│  │                                          │               │
│  │  posix.openlog("sp_lib", LOG_NDELAY,    │               │
│  │                LOG_LOCAL1)               │               │
│  │                    │                     │               │
│  │                    ▼                     │               │
│  │  posix.syslog(LOG_INFO, "key=value")    │               │
│  │                    │                     │               │
│  │                    ▼                     │               │
│  │  posix.closelog()                        │               │
│  │                    │                     │               │
│  │                    ▼                     │               │
│  │  输出到 /var/log/messages (syslog)       │               │
│  └─────────────────────────────────────────┘               │
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │        LogToFile(key, message, ...)      │               │
│  │                                          │               │
│  │  /usr/bin/sp_log_info.sh                 │               │
│  │    -k key                                │               │
│  │    -m "message"                          │               │
│  │    -f file (可选)                        │               │
│  │    -l level (可选)                       │               │
│  │                    │                     │               │
│  │                    ▼                     │               │
│  │  输出到指定文件或默认日志文件            │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 日志记录函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `Log(key, value)` | key: any, value: any | 无 | 通过syslog记录键值对 |
| `LogToFile(key, message, file, level)` | key: string, message: string, file: string(可选), level: string(可选) | 无 | 记录统计信息到文件 |

### 参数说明

#### Log 函数

| 参数 | 类型 | 说明 |
|------|------|------|
| `key` | any | 统计键名，会转换为字符串 |
| `value` | any | 统计值，会转换为字符串 |

#### LogToFile 函数

| 参数 | 类型 | 说明 |
|------|------|------|
| `key` | string | 统计键名 |
| `message` | string | 统计消息内容 |
| `file` | string | 目标文件路径（可选） |
| `level` | string | 日志级别（可选，需要file参数） |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `posix` | POSIX系统调用（syslog） |
| `luci.util` | 工具函数（exec） |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.XQLog` - 日志模块调用统计打点
- `xiaoqiang.util.XQSysUtil` - 系统工具记录统计信息
- `luci.controller.api.xqsystem` - 系统API记录用户操作
- 各业务模块 - 记录业务统计数据

## 关键代码说明

### 1. syslog日志记录

```lua
function Log(key, value)
    -- 打开syslog连接
    -- 参数说明:
    -- "sp_lib": 日志标识符（stat points library）
    -- LOG_NDELAY: 立即打开连接，不延迟
    -- LOG_LOCAL1: 使用LOCAL1设施（自定义应用）
    posix.openlog("sp_lib", posix.LOG_NDELAY, posix.LOG_LOCAL1)
    
    -- 记录信息级别的日志
    -- 格式: "key=value"
    posix.syslog(posix.LOG_INFO, tostring(key) .. "=" .. tostring(value))
    
    -- 关闭syslog连接
    posix.closelog()
end
```

### 2. 文件日志记录

```lua
function LogToFile(key, message, file, level)
    local cmd = "/usr/bin/sp_log_info.sh"
    
    if key and message then
        -- 构建命令行参数
        cmd = cmd .. " -k " .. key .. " -m " .. string.format("\"%s\"", message)
        
        -- 如果指定了文件路径
        if file then
            cmd = cmd .. " -f " .. file
            
            -- 如果指定了日志级别
            if level then
                cmd = cmd .. " -l " .. level
            end
        end
        
        -- 执行记录命令
        luci.util.exec(cmd)
    end
end
```

## syslog设施说明

| 设施 | 说明 |
|------|------|
| `LOG_LOCAL0` - `LOG_LOCAL7` | 本地使用的设施 |
| `LOG_LOCAL1` | 本模块使用的设施 |

## syslog级别说明

| 级别 | 常量 | 说明 |
|------|------|------|
| 0 | LOG_EMERG | 系统不可用 |
| 1 | LOG_ALERT | 需要立即处理 |
| 2 | LOG_CRIT | 严重错误 |
| 3 | LOG_ERR | 错误 |
| 4 | LOG_WARNING | 警告 |
| 5 | LOG_NOTICE | 正常但重要 |
| 6 | LOG_INFO | 信息（本模块默认） |
| 7 | LOG_DEBUG | 调试信息 |

## 使用示例

### syslog记录

```lua
local XQStatPoints = require("xiaoqiang.XQStatPoints")

-- 记录用户登录事件
XQStatPoints.Log("user_login", "success")

-- 记录WiFi连接数
XQStatPoints.Log("wifi_clients", 5)

-- 记录系统启动
XQStatPoints.Log("system_boot", os.time())
```

### 文件记录

```lua
local XQStatPoints = require("xiaoqiang.XQStatPoints")

-- 记录到默认文件
XQStatPoints.LogToFile("error", "Connection timeout")

-- 记录到指定文件
XQStatPoints.LogToFile("download", "File downloaded", "/tmp/download.log")

-- 记录到指定文件并设置级别
XQStatPoints.LogToFile("critical", "Disk full", "/tmp/system.log", "error")
```

## 日志输出位置

1. **syslog方式**: 输出到系统日志 `/var/log/messages`
2. **文件方式**: 输出到指定文件或脚本默认位置

## 注意事项

1. **syslog连接**: 每次调用 `Log` 函数都会打开和关闭syslog连接
2. **类型转换**: `Log` 函数会自动将参数转换为字符串
3. **参数验证**: `LogToFile` 函数要求 `key` 和 `message` 都不为空
4. **脚本依赖**: `LogToFile` 依赖外部脚本 `/usr/bin/sp_log_info.sh`
5. **性能考虑**: 频繁调用可能影响性能，建议批量记录
