# buffer.lua - AES 加密库字符串缓冲区模块

## 工作原理

本模块实现高效的字符串缓冲区，用于优化大量字符串连接操作。

在 Lua 中，直接使用 `..` 运算符连接大量字符串会导致性能问题，因为每次连接都会创建新的字符串对象。本模块采用类似于"绳索"(rope) 的数据结构来优化这一操作。

优化策略：
1. 使用数组存储待连接的字符串片段
2. 添加新字符串时，检查相邻元素的长度
3. 如果前一个元素长度大于后一个元素，则进行合并
4. 这种策略类似于"二项堆"的合并策略

复杂度优化：
- 原始方式：O(n²) - 每次连接都复制所有已有内容
- 本模块：O(n log n) - 通过延迟合并减少内存分配

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `buffer.new()` | 无 | 空缓冲区表 | 创建新的缓冲区对象 |
| `buffer.addString(buf, str)` | buf: 缓冲区<br>str: 字符串 | 无 | 向缓冲区添加字符串 |
| `buffer.toString(buf)` | buf: 缓冲区 | 合并后的字符串 | 将缓冲区转换为字符串 |

### 使用示例

```lua
local buffer = require("aeslua.buffer")

-- 创建缓冲区
local buf = buffer.new()

-- 添加字符串
buffer.addString(buf, "Hello")
buffer.addString(buf, " ")
buffer.addString(buf, "World")

-- 获取结果
local result = buffer.toString(buf)  -- "Hello World"
```

### 工作流程图

```
添加 "A" -> ["A"]
添加 "B" -> ["A", "B"] -> 比较长度 -> ["AB"]
添加 "C" -> ["AB", "C"] -> 比较长度 -> 保持 ["AB", "C"]
添加 "D" -> ["AB", "C", "D"] -> 合并 -> ["AB", "CD"]
...
toString() -> 从后向前合并所有 -> "ABCD..."
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `table` | Lua 表操作库 |
| `string` | Lua 字符串库 |
