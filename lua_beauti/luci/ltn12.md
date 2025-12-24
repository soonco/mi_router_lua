# luci/ltn12.lua

## 概述

LTN12 数据流处理模块，基于 Lua Technical Note 12 的数据流抽象。提供数据源（Source）、数据槽（Sink）、过滤器（Filter）和数据泵（Pump）的抽象，用于处理数据流。

## 工作原理

1. **数据源 (Source)**: 数据的生产者，每次调用返回一块数据或 nil 表示结束
2. **数据槽 (Sink)**: 数据的消费者，接收数据块并处理
3. **过滤器 (Filter)**: 数据转换器，对数据块进行转换
4. **数据泵 (Pump)**: 连接数据源和数据槽，驱动数据流动

## 接口/函数列表

### 常量

| 常量 | 值 | 描述 |
|------|-----|------|
| `BLOCKSIZE` | 2048 | 默认数据块大小 |
| `_VERSION` | "LTN12 1.0.1" | 模块版本 |

### 过滤器 (filter.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `filter.chain(...)` | 多个过滤器 | function | 串联多个过滤器 |
| `filter.cycle(func, ctx, extra)` | 底层函数、上下文、额外参数 | function | 创建循环过滤器 |

### 数据源 (source.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `source.empty(err)` | 错误信息 | function | 创建空数据源 |
| `source.error(err)` | 错误信息 | function | 创建错误数据源 |
| `source.file(handle, err)` | 文件句柄、错误 | function | 创建文件数据源 |
| `source.string(data)` | 字符串 | function | 创建字符串数据源 |
| `source.table(tbl)` | 表 | function | 创建表数据源 |
| `source.simplify(src)` | 数据源 | function | 简化数据源 |
| `source.chain(src, flt)` | 数据源、过滤器 | function | 为数据源添加过滤器 |
| `source.cat(...)` | 多个数据源 | function | 连接多个数据源 |

### 数据槽 (sink.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `sink.table(tbl)` | 目标表 | function, table | 创建表数据槽 |
| `sink.file(handle, err)` | 文件句柄、错误 | function | 创建文件数据槽 |
| `sink.null()` | 无 | function | 创建空数据槽（丢弃数据） |
| `sink.error(err)` | 错误信息 | function | 创建错误数据槽 |
| `sink.simplify(snk)` | 数据槽 | function | 简化数据槽 |
| `sink.chain(flt, snk)` | 过滤器、数据槽 | function | 为数据槽添加过滤器 |

### 数据泵 (pump.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `pump.step(src, snk)` | 数据源、数据槽 | 1/nil, err | 单步数据传输 |
| `pump.all(src, snk, step)` | 数据源、数据槽、步进函数 | 1/nil, err | 完整数据传输 |

## 外部依赖

- `string` - 字符串操作
- `table` - 表操作

## 被引用情况

- `luci/http.lua` - HTTP 请求体处理
- `luci/http/protocol.lua` - HTTP 协议解析
- `luci/fs.lua` - 文件操作

## 关键代码说明

### 过滤器链
```lua
function filter.chain(...)
    local filters = { ... }
    return function(chunk)
        local result = chunk
        for i = 1, #filters do
            result = filters[i](result)
        end
        return result
    end
end
```

### 文件数据源
```lua
function source.file(file_handle, io_err)
    if file_handle then
        return function()
            local chunk = file_handle:read(BLOCKSIZE)
            if not chunk then
                file_handle:close()
            end
            return chunk
        end
    end
end
```

### 数据泵
```lua
function pump.all(src, snk, step_func)
    step_func = step_func or pump.step
    while true do
        local result, err = step_func(src, snk)
        if not result then
            return err and nil or 1, err
        end
    end
end
```

## 使用示例

```lua
local ltn12 = require("luci.ltn12")

-- 从文件读取到表
local result = {}
local src = ltn12.source.file(io.open("input.txt"))
local snk = ltn12.sink.table(result)
ltn12.pump.all(src, snk)

-- 从字符串到文件
local src = ltn12.source.string("Hello World")
local snk = ltn12.sink.file(io.open("output.txt", "w"))
ltn12.pump.all(src, snk)

-- 使用过滤器
local src = ltn12.source.string("data")
local flt = function(chunk) return chunk and chunk:upper() end
local filtered_src = ltn12.source.chain(src, flt)
```
