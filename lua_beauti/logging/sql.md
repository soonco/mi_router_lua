# sql.lua - SQL 数据库日志输出模块

## 工作原理

本模块是 LuaLogging 框架的 SQL 数据库输出适配器（Appender），将日志消息存储到 SQL 数据库。

特点：
- 支持自定义表名和字段名
- 支持连接保持（keepalive）模式以提高性能
- 自动处理 SQL 注入（转义单引号）
- 支持连接失败自动重试

工作流程：
1. 获取或创建数据库连接
2. 格式化时间戳
3. 转义消息内容
4. 执行 INSERT 语句
5. 根据配置决定是否关闭连接

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.sql(params)` | params: 配置参数表 | logger 对象或 nil, error | 创建 SQL 日志器 |

### 配置参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `connectionfactory` | function | - | 数据库连接工厂函数（必需） |
| `tablename` | string | "LogTable" | 日志表名 |
| `logdatefield` | string | "LogDate" | 日期字段名 |
| `loglevelfield` | string | "LogLevel" | 级别字段名 |
| `logmessagefield` | string | "LogMessage" | 消息字段名 |
| `keepalive` | boolean | false | 是否保持连接 |

### 使用示例

```lua
local logging = require("logging")
require("logging.sql")

-- 使用 LuaSQL 连接 MySQL
local luasql = require("luasql.mysql")
local env = luasql.mysql()

-- 创建 SQL 日志器
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

-- 记录日志
logger:info("应用程序启动")
logger:error("发生错误")
```

### 数据库表结构

建议的表结构：

```sql
CREATE TABLE app_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_time DATETIME NOT NULL,
    log_level VARCHAR(10) NOT NULL,
    log_message TEXT NOT NULL
);
```

### 生成的 SQL 语句

```sql
INSERT INTO app_logs (log_time, log_level, log_message)
VALUES ('2024-01-15 10:30:00', 'INFO', '应用程序启动')
```

### 注意事项

- 需要用户提供数据库连接工厂函数
- 消息中的单引号会被转义为两个单引号
- keepalive 模式下连接失败会自动重试

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| 用户提供的数据库驱动 | 如 luasql.mysql、luasql.postgres 等 |
| `os` | Lua OS 库 |
