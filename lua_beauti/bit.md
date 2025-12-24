# bit.lua - 位运算模块

## 工作原理

本模块是 nixio 库位运算功能的简单封装，提供标准的位运算操作，供其他模块（如 AES 加密库）使用。

模块直接返回 `nixio.bit` 表，包含所有位运算函数。

## 接口

### 位运算函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `bit.band(a, b)` | 两个整数 | 整数 | 按位与 |
| `bit.bor(a, b)` | 两个整数 | 整数 | 按位或 |
| `bit.bxor(a, b)` | 两个整数 | 整数 | 按位异或 |
| `bit.bnot(a)` | 一个整数 | 整数 | 按位取反 |
| `bit.lshift(a, n)` | 整数, 位数 | 整数 | 左移 n 位 |
| `bit.rshift(a, n)` | 整数, 位数 | 整数 | 逻辑右移 n 位 |
| `bit.arshift(a, n)` | 整数, 位数 | 整数 | 算术右移 n 位 |

### 使用示例

```lua
local bit = require("bit")

-- 异或运算
local result = bit.bxor(0xAB, 0xCD)

-- 左移运算
local shifted = bit.lshift(1, 4)  -- 结果: 16

-- 按位与
local masked = bit.band(0xFF, 0x0F)  -- 结果: 0x0F
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `nixio` | nixio 库（提供 bit 子模块） |
