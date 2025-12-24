# luci/json.lua

## 概述

LuCI JSON 编解码模块，提供 JSON 数据的编码和解码功能。支持流式解码和自定义 null 值处理。

## 工作原理

1. **解码器**: `Decoder` 类逐字符解析 JSON 字符串，构建 Lua 数据结构
2. **编码器**: `Encoder` 类递归遍历 Lua 数据，生成 JSON 字符串
3. **流式处理**: 支持数据源函数，可处理大型 JSON 数据
4. **类型映射**: JSON 类型自动映射到 Lua 类型

## 接口/函数列表

### 便捷函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `decode(json_str)` | JSON 字符串 | any | 解码 JSON 字符串为 Lua 值 |
| `encode(value)` | Lua 值 | string | 编码 Lua 值为 JSON 字符串 |
| `null()` | 无 | nil | 返回 JSON null 值表示 |
| `ActiveDecoder(source, custom_null)` | 数据源、自定义null | Decoder | 创建流式解码器 |

### Decoder 类

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `Decoder:__init__(source, custom_null)` | 数据源函数、自定义null | void | 初始化解码器 |
| `Decoder:get()` | 无 | any | 获取解码后的值 |

### Encoder 类

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `Encoder:__init__(data, is_array)` | 数据、是否强制数组 | void | 初始化编码器 |
| `Encoder:source()` | 无 | string | 获取编码后的 JSON |

## 类型映射

### JSON → Lua

| JSON 类型 | Lua 类型 |
|-----------|----------|
| object | table |
| array | table (数组) |
| string | string |
| number | number |
| true | true |
| false | false |
| null | nil 或 custom_null |

### Lua → JSON

| Lua 类型 | JSON 类型 |
|----------|-----------|
| table (数组) | array |
| table (哈希) | object |
| string | string |
| number | number |
| boolean | true/false |
| nil | null |
| NaN/Inf | null |
| 其他 | null |

## 外部依赖

- `math` - 数学函数
- `string` - 字符串操作
- `table` - 表操作
- `luci.util` - 工具函数（class）

## 被引用情况

- `luci/http.lua` - JSON 响应输出
- 所有 API 控制器 - JSON 数据处理
- `xiaoqiang` 模块 - 配置数据处理

## 关键代码说明

### 字符串转义处理
```lua
local escape_map = {
    ['"'] = '"',
    ['\\'] = '\\',
    ['/'] = '/',
    ['b'] = '\b',
    ['f'] = '\f',
    ['n'] = '\n',
    ['r'] = '\r',
    ['t'] = '\t'
}
-- Unicode 转义: \uXXXX
```

### 数组检测
```lua
-- 检查表是否为数组
-- 条件: 所有键都是正整数，且连续
local max_index = 0
local count = 0
for key, _ in pairs(tbl) do
    count = count + 1
    if type(key) == "number" and key > 0 and math.floor(key) == key then
        if key > max_index then
            max_index = key
        end
    else
        is_array = false
        break
    end
end
is_array = (max_index == count)
```

### 特殊数值处理
```lua
-- NaN 和无穷大转换为 null
if value ~= value then  -- NaN 检测
    return "null"
elseif value == math.huge or value == -math.huge then
    return "null"
end
```

### Unicode 编码
```lua
-- UTF-8 编码
if codepoint < 128 then
    -- 单字节
elseif codepoint < 2048 then
    -- 双字节
else
    -- 三字节
end
```
