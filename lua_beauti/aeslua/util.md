# util.lua - AES 加密库工具函数模块

## 工作原理

本模块提供 AES 加密库所需的各种工具函数，包括位运算辅助、字节与整数转换、十六进制格式化、数据填充和异或操作。

### 数据填充格式

填充后的数据结构：
```
| 2 字节随机数 | 4 字节原始长度 | 原始数据 | 随机填充 |
|-------------|---------------|---------|---------|
|   rand1,2   |   big-endian  |  data   | padding |
```

- 总长度为 16 字节的倍数
- 随机数增加安全性
- 长度字段用于解密后恢复原始数据

### 字节序

本模块使用大端序（Big-Endian）：
- 高位字节在前，低位字节在后
- 例如：0x12345678 -> [0x12, 0x34, 0x56, 0x78]

## 接口

### 位运算函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `util.byteParity(byte)` | 字节值 | 0 或 1 | 计算奇偶校验位 |
| `util.getByte(word, index)` | 32位字, 索引(0-3) | 字节值 | 从字中提取字节 |
| `util.putByte(byte, index)` | 字节值, 索引(0-3) | 32位值 | 将字节放入字的指定位置 |

### 转换函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `util.bytesToInts(bytes, start, count)` | 字节数组, 起始, 数量 | 整数数组 | 字节转整数 |
| `util.intsToBytes(ints, bytes, start, count)` | 整数数组, 目标, 起始, 数量 | 字节数组 | 整数转字节 |
| `util.toHexString(data)` | 数字/表/字符串 | 十六进制字符串 | 转换为十六进制 |

### 填充函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `util.padByteString(str)` | 原始字符串 | 填充后字符串 | 填充到 16 字节对齐 |
| `util.unpadByteString(str)` | 填充后字符串 | 原始字符串或 nil | 移除填充 |

### 异或函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `util.xorIV(block, iv)` | 16字节块, 16字节IV | 无（原地修改） | 数据块与 IV 异或 |

### 使用示例

```lua
local util = require("aeslua.util")

-- 字节提取
local byte = util.getByte(0x12345678, 3)  -- = 0x12

-- 填充字符串
local padded = util.padByteString("Hello")
-- padded 长度为 16 的倍数

-- 移除填充
local original = util.unpadByteString(padded)
-- original = "Hello"

-- 转十六进制
local hex = util.toHexString({0x12, 0x34})  -- = "12 34 "
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `bit` | 位运算库 |
| `math` | Lua 数学库（random） |
| `string` | Lua 字符串库 |
