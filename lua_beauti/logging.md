# logging.lua - LuaLogging 日志框架主模块

## 工作原理

本模块提供简单的日志 API 用于 Lua 应用程序，定义标准日志级别并提供日志器工厂函数和消息格式化功能。

日志级别（按优先级排序）：
1. `DEBUG` - 调试信息
2. `INFO` - 一般信息
3. `WARN` - 警告信息
4. `ERROR` - 错误信息
5. `FATAL` - 致命错误

工作流程：
1. 使用 `logging.new(append_func)` 创建日志器
2. 设置日志级别（默认 DEBUG）
3. 调用日志方法记录消息
4. 只有级别 >= 当前级别的消息才会被记录

## 接口

### 模块属性

| 属性 | 说明 |
|------|------|
| `logging._VERSION` | "LuaLogging 1.3.0" |
| `logging._COPYRIGHT` | 版权信息 |
| `logging._DESCRIPTION` | 模块描述 |

### 日志级别常量

| 常量 | 说明 |
|------|------|
| `logging.DEBUG` | 调试级别 |
| `logging.INFO` | 信息级别 |
| `logging.WARN` | 警告级别 |
| `logging.ERROR` | 错误级别 |
| `logging.FATAL` | 致命错误级别 |

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.new(append_func)` | append_func: 日志写入函数 | logger 对象 | 创建日志器实例 |
| `logging.prepareLogMsg(pattern, date, level, message)` | 格式化参数 | 格式化后的消息 | 准备日志消息格式 |
| `logging.tostring(value)` | value: 任意值 | 字符串表示 | 值转字符串（支持表递归） |

### 日志器方法

| 方法 | 参数 | 说明 |
|------|------|------|
| `logger:debug(message)` | 消息 | 记录调试日志 |
| `logger:info(message)` | 消息 | 记录信息日志 |
| `logger:warn(message)` | 消息 | 记录警告日志 |
| `logger:error(message)` | 消息 | 记录错误日志 |
| `logger:fatal(message)` | 消息 | 记录致命错误日志 |
| `logger:log(level, message)` | 级别, 消息 | 记录指定级别日志 |
| `logger:setLevel(level)` | 级别 | 设置日志级别 |

## 外部引用

本模块为纯 Lua 实现，仅使用 Lua 标准库：

| 模块 | 说明 |
|------|------|
| `string` | 字符串操作 |
| `table` | 表操作 |
