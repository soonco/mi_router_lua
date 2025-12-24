# file.lua - 文件日志输出模块

## 工作原理

本模块是 LuaLogging 框架的文件输出适配器（Appender），将日志消息写入到指定文件。

特点：
- 支持动态文件名（包含日期等）
- 使用行缓冲模式确保日志及时写入
- 自动处理文件切换

工作流程：
1. 根据日期格式化文件名
2. 如果文件名变化，打开新文件
3. 格式化日志消息
4. 写入文件

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.file(filename, log_pattern, date_pattern)` | filename: 文件名模板<br>log_pattern: 日志格式<br>date_pattern: 日期格式 | logger 对象 | 创建文件日志器 |

### 使用示例

```lua
local logging = require("logging")
require("logging.file")

-- 简单用法
local logger = logging.file("app.log")

-- 按日期分文件
local logger = logging.file(
    "app_%Y-%m-%d.log",      -- 文件名模板
    "%date %level %message\n", -- 日志格式
    "%Y-%m-%d"                -- 日期格式
)

-- 记录日志
logger:info("应用程序启动")
logger:error("发生错误")
```

### 文件名模板

支持 `strftime` 格式的日期占位符：

| 占位符 | 说明 | 示例 |
|--------|------|------|
| `%Y` | 四位年份 | 2024 |
| `%m` | 两位月份 | 01-12 |
| `%d` | 两位日期 | 01-31 |
| `%H` | 小时 | 00-23 |
| `%M` | 分钟 | 00-59 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `open_file(filename_pattern, date_pattern)` | 打开或获取日志文件 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| `io` | Lua IO 库 |
| `os` | Lua OS 库 |
