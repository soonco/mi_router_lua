# Logging 模块 - LuaLogging 日志输出适配器集合

## 概述

本目录包含 LuaLogging 框架的各种日志输出适配器（Appender），提供多种日志输出方式以满足不同场景的需求。

## 模块列表

| 模块 | 文件 | 说明 |
|------|------|------|
| 控制台输出 | `console.lua` | 将日志输出到标准输出（stdout） |
| 文件输出 | `file.lua` | 将日志写入文件，支持动态文件名 |
| 滚动文件输出 | `rolling_file.lua` | 按文件大小自动滚动的文件日志 |
| 邮件输出 | `email.lua` | 通过 SMTP 发送日志邮件 |
| Socket 输出 | `socket.lua` | 通过 TCP Socket 发送日志到远程服务器 |
| SQL 数据库输出 | `sql.lua` | 将日志存储到 SQL 数据库 |

## 模块详情

### 1. console.lua - 控制台日志输出

最简单的日志输出方式，适合开发调试阶段使用。

```lua
local logging = require("logging")
require("logging.console")

local logger = logging.console("%date %level %message\n")
logger:info("一般信息")
```

### 2. file.lua - 文件日志输出

将日志写入文件，支持按日期动态生成文件名。

```lua
local logging = require("logging")
require("logging.file")

-- 按日期分文件
local logger = logging.file(
    "app_%Y-%m-%d.log",       -- 文件名模板
    "%date %level %message\n", -- 日志格式
    "%Y-%m-%d"                 -- 日期格式
)
```

**特点：**
- 支持 strftime 格式的日期占位符
- 使用行缓冲模式确保日志及时写入
- 自动处理文件切换

### 3. rolling_file.lua - 滚动文件日志输出

当日志文件达到指定大小时自动滚动，保留指定数量的历史文件。

```lua
local logging = require("logging")
require("logging.rolling_file")

-- 最大10MB, 保留5个历史文件
local logger = logging.rolling_file(
    "app.log",
    10 * 1024 * 1024,  -- 10MB
    5,                  -- 保留5个历史文件
    "%date %level %message\n"
)
```

**滚动后的文件命名：**
```
app.log      <- 当前日志
app.log.1    <- 上一个日志
app.log.2    <- 更早的日志
...
app.log.N    <- 最旧的日志（会被覆盖）
```

### 4. email.lua - 邮件日志输出

通过 SMTP 协议发送日志消息到指定邮箱，适用于重要告警通知。

```lua
local logging = require("logging")
require("logging.email")

local logger = logging.email({
    from = "alert@example.com",
    rcpt = "admin@example.com",
    server = "smtp.example.com",
    user = "alert@example.com",
    password = "password",
    headers = {
        subject = "[Alert] %level - %message"
    }
})

logger:error("系统发生严重错误")
```

**注意事项：**
- 邮件发送较慢，不适合高频日志
- 建议仅用于 ERROR 和 FATAL 级别

### 5. socket.lua - Socket 日志输出

通过 TCP Socket 将日志消息发送到远程服务器，适合集中日志收集。

```lua
local logging = require("logging")
require("logging.socket")

local logger = logging.socket(
    "logserver.example.com",  -- 日志服务器地址
    514,                       -- 端口号
    "%date %level %message\n"
)
```

**典型应用场景：**
- 发送到 Logstash、Fluentd 等日志收集系统
- 发送到远程 syslog 服务器
- 发送到自建日志服务

### 6. sql.lua - SQL 数据库日志输出

将日志消息存储到 SQL 数据库，支持多种数据库。

```lua
local logging = require("logging")
require("logging.sql")
local luasql = require("luasql.mysql")
local env = luasql.mysql()

local logger = logging.sql({
    connectionfactory = function()
        return env:connect("database", "user", "password", "host")
    end,
    tablename = "app_logs",
    logdatefield = "log_time",
    loglevelfield = "log_level",
    logmessagefield = "log_message",
    keepalive = true
})
```

**建议的数据库表结构：**
```sql
CREATE TABLE app_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_time DATETIME NOT NULL,
    log_level VARCHAR(10) NOT NULL,
    log_message TEXT NOT NULL
);
```

## 通用日志格式占位符

所有模块都支持以下格式化占位符：

| 占位符 | 说明 |
|--------|------|
| `%date` | 日期时间 |
| `%level` | 日志级别 |
| `%message` | 日志消息 |

## 日志级别

LuaLogging 支持以下日志级别（从低到高）：

| 级别 | 方法 | 说明 |
|------|------|------|
| DEBUG | `logger:debug()` | 调试信息 |
| INFO | `logger:info()` | 一般信息 |
| WARN | `logger:warn()` | 警告信息 |
| ERROR | `logger:error()` | 错误信息 |
| FATAL | `logger:fatal()` | 致命错误 |

## 外部依赖

| 模块 | 依赖 |
|------|------|
| console.lua | logging, io, os |
| file.lua | logging, io, os |
| rolling_file.lua | logging, io, os |
| email.lua | logging, socket.smtp, os |
| socket.lua | logging, socket, os |
| sql.lua | logging, 用户提供的数据库驱动, os |

## 使用建议

1. **开发环境**：使用 `console.lua` 快速查看日志
2. **生产环境**：使用 `file.lua` 或 `rolling_file.lua` 持久化日志
3. **分布式系统**：使用 `socket.lua` 集中收集日志
4. **告警通知**：使用 `email.lua` 发送重要告警
5. **日志分析**：使用 `sql.lua` 存储日志便于查询分析

## 文件结构

```
logging/
├── Readme.md           # 本文档
├── console.lua         # 控制台输出模块
├── console.lua.md      # 控制台模块说明
├── email.lua           # 邮件输出模块
├── email.lua.md        # 邮件模块说明
├── file.lua            # 文件输出模块
├── file.lua.md         # 文件模块说明
├── rolling_file.lua    # 滚动文件输出模块
├── rolling_file.lua.md # 滚动文件模块说明
├── socket.lua          # Socket 输出模块
├── socket.lua.md       # Socket 模块说明
├── sql.lua             # SQL 数据库输出模块
└── sql.lua.md          # SQL 模块说明
```
