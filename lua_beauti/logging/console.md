# console.lua - 控制台日志输出模块

## 工作原理

本模块是 LuaLogging 框架的控制台输出适配器（Appender），将日志消息输出到标准输出（stdout）。

这是最简单的日志输出方式，适合开发调试阶段使用。

工作流程：
1. 接收日志级别和消息
2. 使用 `logging.prepareLogMsg` 格式化消息
3. 写入 `io.stdout`

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.console(log_pattern)` | log_pattern: 日志格式模板（可选） | logger 对象 | 创建控制台日志器 |

### 使用示例

```lua
local logging = require("logging")
require("logging.console")

-- 创建控制台日志器
local logger = logging.console()

-- 或使用自定义格式
local logger = logging.console("%date %level %message\n")

-- 记录日志
logger:debug("调试信息")
logger:info("一般信息")
logger:warn("警告信息")
logger:error("错误信息")
```

### 格式化占位符

| 占位符 | 说明 |
|--------|------|
| `%date` | 日期时间 |
| `%level` | 日志级别 |
| `%message` | 日志消息 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| `io` | Lua IO 库 |
| `os` | Lua OS 库（日期） |
