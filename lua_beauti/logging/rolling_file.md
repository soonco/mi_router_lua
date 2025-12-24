# rolling_file.lua - 滚动文件日志输出模块

## 工作原理

本模块是 LuaLogging 框架的滚动文件输出适配器（Appender），当日志文件达到指定大小时自动滚动。

滚动逻辑：
1. 检查当前文件大小
2. 如果超过最大大小，执行滚动：
   - 将 `filename.N-1` 重命名为 `filename.N`（从最大索引开始）
   - 将 `filename` 重命名为 `filename.1`
   - 创建新的 `filename` 文件

文件命名示例：
```
app.log      <- 当前日志
app.log.1    <- 上一个日志
app.log.2    <- 更早的日志
...
app.log.N    <- 最旧的日志（会被覆盖）
```

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.rolling_file(filename, max_size, max_index, log_pattern)` | filename: 文件名<br>max_size: 最大字节数<br>max_index: 保留文件数<br>log_pattern: 日志格式 | logger 对象 | 创建滚动文件日志器 |

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `filename` | string | "lualogging.log" | 日志文件名 |
| `max_size` | number | - | 单个文件最大字节数 |
| `max_index` | number | 1 | 保留的历史文件数量 |
| `log_pattern` | string | - | 日志消息格式模板 |

### 使用示例

```lua
local logging = require("logging")
require("logging.rolling_file")

-- 创建滚动日志器: 最大10MB, 保留5个历史文件
local logger = logging.rolling_file(
    "app.log",
    10 * 1024 * 1024,  -- 10MB
    5,                  -- 保留5个历史文件
    "%date %level %message\n"
)

-- 记录日志
logger:info("应用程序启动")
logger:error("发生错误")
```

### 内部函数

| 函数 | 说明 |
|------|------|
| `open_file(config)` | 打开日志文件 |
| `rollover(config)` | 执行文件滚动 |
| `get_writable_file(config)` | 获取可写的文件句柄 |

### 配置对象结构

```lua
{
    filename = "app.log",    -- 文件名
    maxSize = 10485760,      -- 最大大小（字节）
    maxIndex = 5,            -- 最大索引
    file = nil               -- 当前文件句柄
}
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| `io` | Lua IO 库 |
| `os` | Lua OS 库 |
