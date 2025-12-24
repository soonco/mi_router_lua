--[[
================================================================================
位运算模块 (Bit Operations Module)
================================================================================

功能说明：
  本模块是 nixio 库位运算功能的简单封装。
  提供标准的位运算操作，供其他模块（如 AES 加密库）使用。

主要接口（来自 nixio.bit）：
  - bit.band(a, b)    : 按位与
  - bit.bor(a, b)     : 按位或
  - bit.bxor(a, b)    : 按位异或
  - bit.bnot(a)       : 按位取反
  - bit.lshift(a, n)  : 左移 n 位
  - bit.rshift(a, n)  : 逻辑右移 n 位
  - bit.arshift(a, n) : 算术右移 n 位

使用示例：
  local bit = require("bit")
  local result = bit.bxor(0xAB, 0xCD)  -- 异或运算

================================================================================
--]]

-- 加载 nixio 库并返回其位运算模块
local nixio = require("nixio")
return nixio.bit
