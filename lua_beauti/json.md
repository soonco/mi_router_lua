# json.lua - JSON 编解码模块

## 工作原理

本模块提供 JSON 格式的编码（Lua 值转 JSON 字符串）和解码（JSON 字符串转 Lua 值）功能，是一个纯 Lua 实现。

支持的数据类型：
- `null` ↔ `nil` 或 `json.null()`
- `boolean` ↔ `true`/`false`
- `number` ↔ Lua number
- `string` ↔ Lua string
- `array` ↔ Lua 数组表
- `object` ↔ Lua 关联表

特性：
- 自动检测 Lua 表是数组还是对象
- 支持 JSON 注释（`/* */`）
- 支持单引号和双引号字符串
- 转义特殊字符

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `json.encode(value)` | value: Lua 值 | JSON 字符串 | 编码为 JSON |
| `json.decode(json_str, start_pos)` | json_str: JSON 字符串<br>start_pos: 起始位置（可选） | Lua 值, 结束位置 | 解码 JSON |
| `json.null()` | 无 | null 函数 | 返回 JSON null 值 |

### 使用示例

```lua
local json = require("json")

-- 编码
local str = json.encode({name = "test", value = 123})
-- 结果: {"name":"test","value":123}

-- 编码数组
local arr_str = json.encode({1, 2, 3})
-- 结果: [1,2,3]

-- 解码
local obj = json.decode('{"name":"test","value":123}')
-- 结果: {name = "test", value = 123}

-- null 值
local with_null = json.encode({value = json.null()})
-- 结果: {"value":null}
```

### 内部函数

| 函数 | 说明 |
|------|------|
| `decode_scanArray(json_str, pos)` | 扫描 JSON 数组 |
| `decode_scanObject(json_str, pos)` | 扫描 JSON 对象 |
| `decode_scanString(json_str, pos)` | 扫描 JSON 字符串 |
| `decode_scanNumber(json_str, pos)` | 扫描 JSON 数字 |
| `decode_scanConstant(json_str, pos)` | 扫描 JSON 常量 |
| `decode_scanComment(json_str, pos)` | 扫描 JSON 注释 |
| `decode_scanWhitespace(json_str, pos)` | 跳过空白字符 |
| `encodeString(str)` | 转义字符串 |
| `isArray(tbl)` | 检测表是否为数组 |
| `isEncodable(value)` | 检测值是否可编码 |

### 类型映射

| JSON 类型 | Lua 类型 |
|-----------|----------|
| `null` | `nil` 或 `json.null()` |
| `true`/`false` | `true`/`false` |
| `number` | `number` |
| `"string"` | `string` |
| `[...]` | 数组表 `{1, 2, 3}` |
| `{...}` | 关联表 `{key = value}` |

## 外部引用

| 模块 | 说明 |
|------|------|
| `math` | Lua 数学库 |
| `string` | Lua 字符串库 |
| `table` | Lua 表操作库 |
