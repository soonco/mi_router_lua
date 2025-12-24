# ltn12.lua - LTN12 数据传输库

## 工作原理

LTN12（Lua Technical Note 12）是 LuaSocket 库的核心数据传输机制，提供数据源（source）、数据槽（sink）、过滤器（filter）和泵（pump）的抽象。

核心概念：
- **Source（数据源）**: 生产数据的函数，每次调用返回一块数据，数据耗尽返回 nil
- **Sink（数据槽）**: 消费数据的函数，接收数据并处理
- **Filter（过滤器）**: 转换数据的函数，对数据进行处理后传递
- **Pump（泵）**: 连接 source 和 sink，驱动数据流动

数据流模型：
```
Source -> [Filter] -> Sink
           ^
           |
         Pump (驱动)
```

## 接口

### 模块常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `ltn12.BLOCKSIZE` | 2048 | 默认数据块大小 |
| `ltn12._VERSION` | "LTN12 1.0.3" | 版本号 |

### 数据源函数 (ltn12.source)

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `source.empty()` | 无 | 空数据源 | 创建空数据源 |
| `source.error(err)` | 错误信息 | 错误数据源 | 创建错误数据源 |
| `source.file(handle, err)` | 文件句柄 | 文件数据源 | 从文件创建数据源 |
| `source.string(str)` | 字符串 | 字符串数据源 | 从字符串创建数据源 |
| `source.rewind(src)` | 数据源 | 可回退数据源 | 创建可回退的数据源 |
| `source.chain(src, filter, ...)` | 数据源, 过滤器 | 链式数据源 | 创建带过滤器的数据源 |
| `source.cat(...)` | 多个数据源 | 连接数据源 | 连接多个数据源 |

### 数据槽函数 (ltn12.sink)

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `sink.table(tbl)` | 目标表（可选） | 数据槽, 结果表 | 创建表数据槽 |
| `sink.file(handle, err)` | 文件句柄 | 文件数据槽 | 创建文件数据槽 |
| `sink.null()` | 无 | 空数据槽 | 创建丢弃数据的数据槽 |
| `sink.error(err)` | 错误信息 | 错误数据槽 | 创建错误数据槽 |
| `sink.chain(filter, snk, ...)` | 过滤器, 数据槽 | 链式数据槽 | 创建带过滤器的数据槽 |

### 过滤器函数 (ltn12.filter)

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `filter.cycle(low, ctx, extra)` | 低级过滤器, 上下文 | 高级过滤器 | 创建循环过滤器 |
| `filter.chain(...)` | 多个过滤器 | 链式过滤器 | 串联多个过滤器 |

### 泵函数 (ltn12.pump)

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `pump.step(src, snk)` | 数据源, 数据槽 | 1 或 nil, 错误 | 单步数据传输 |
| `pump.all(src, snk, step)` | 数据源, 数据槽, 步进函数 | 1 或 nil, 错误 | 传输所有数据 |

### 使用示例

```lua
local ltn12 = require("ltn12")

-- 从字符串读取，写入表
local source = ltn12.source.string("Hello World")
local sink, result = ltn12.sink.table()
ltn12.pump.all(source, sink)
-- result = {"Hello World"}
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `string` | Lua 字符串库 |
| `table` | Lua 表操作库 |
