--[[
================================================================================
AES 加密库 - 工具函数模块 (Utility Module)
================================================================================

功能说明：
  本模块提供 AES 加密库所需的各种工具函数，包括：
  - 位运算辅助函数
  - 字节与整数转换
  - 十六进制格式化
  - 数据填充（Padding）
  - 异或操作

主要接口：
  - util.byteParity(byte)           : 计算字节奇偶校验
  - util.getByte(word, index)       : 从 32 位字中提取字节
  - util.putByte(byte, index)       : 将字节放入 32 位字的指定位置
  - util.bytesToInts(bytes, start)  : 字节数组转整数数组
  - util.intsToBytes(ints, bytes)   : 整数数组转字节数组
  - util.toHexString(data)          : 转换为十六进制字符串
  - util.padByteString(str)         : 填充字符串到 16 字节对齐
  - util.unpadByteString(str)       : 移除填充
  - util.xorIV(block, iv)           : 数据块与 IV 异或

================================================================================
--]]

-- 声明模块
module("aeslua.util", package.seeall)

-- 加载位运算库
local bit = require("bit")

-- 创建工具函数表
local util = {}
local private = {}

-- 将 util 对象挂载到 aeslua 命名空间
aeslua.util = util

--[[
--------------------------------------------------------------------------------
函数: util.byteParity(byte)
--------------------------------------------------------------------------------
功能: 计算一个字节的奇偶校验位

参数:
  byte - 要计算的字节值（0-255）

返回值:
  number - 0 或 1，表示字节中 1 的个数的奇偶性

说明:
  使用位折叠算法快速计算：
  1. 将高 4 位与低 4 位异或
  2. 将结果的高 2 位与低 2 位异或
  3. 将结果的高 1 位与低 1 位异或
  4. 取最低位作为结果
--------------------------------------------------------------------------------
--]]
function util.byteParity(byte)
    -- 折叠：高 4 位与低 4 位异或
    byte = bit.bxor(byte, bit.rshift(byte, 4))
    -- 折叠：高 2 位与低 2 位异或
    byte = bit.bxor(byte, bit.rshift(byte, 2))
    -- 折叠：高 1 位与低 1 位异或
    byte = bit.bxor(byte, bit.rshift(byte, 1))
    -- 取最低位
    return bit.band(byte, 1)
end

--[[
--------------------------------------------------------------------------------
函数: util.getByte(word, index)
--------------------------------------------------------------------------------
功能: 从 32 位字中提取指定位置的字节

参数:
  word  - 32 位整数
  index - 字节位置（0-3，0 是最低字节，3 是最高字节）

返回值:
  number - 提取的字节值（0-255）

说明:
  index = 0: 返回 bits 0-7   (最低字节)
  index = 1: 返回 bits 8-15
  index = 2: 返回 bits 16-23
  index = 3: 返回 bits 24-31 (最高字节)
--------------------------------------------------------------------------------
--]]
function util.getByte(word, index)
    if index == 0 then
        return bit.band(word, 0xFF)
    else
        return bit.band(bit.rshift(word, index * 8), 0xFF)
    end
end

--[[
--------------------------------------------------------------------------------
函数: util.putByte(byte, index)
--------------------------------------------------------------------------------
功能: 将字节放入 32 位字的指定位置

参数:
  byte  - 字节值（0-255）
  index - 目标位置（0-3）

返回值:
  number - 字节移位后的 32 位值

说明:
  index = 0: 字节在 bits 0-7
  index = 1: 字节在 bits 8-15
  index = 2: 字节在 bits 16-23
  index = 3: 字节在 bits 24-31
--------------------------------------------------------------------------------
--]]
function util.putByte(byte, index)
    if index == 0 then
        return bit.band(byte, 0xFF)
    else
        return bit.lshift(bit.band(byte, 0xFF), index * 8)
    end
end

--[[
--------------------------------------------------------------------------------
函数: util.bytesToInts(bytes, start, count)
--------------------------------------------------------------------------------
功能: 将字节数组转换为 32 位整数数组

参数:
  bytes - 字节数组
  start - 起始索引
  count - 要转换的整数数量（每个整数 4 字节）

返回值:
  table - 32 位整数数组

说明:
  采用大端序（Big-Endian）：第一个字节是最高位。
  例如：bytes[0], bytes[1], bytes[2], bytes[3] -> int[0]
  其中 bytes[0] 是最高字节。
--------------------------------------------------------------------------------
--]]
function util.bytesToInts(bytes, start, count)
    local result = {}
    
    for i = 0, count - 1 do
        local baseIndex = start + i * 4
        
        -- 大端序组装：第一个字节是最高位
        local value = util.putByte(bytes[baseIndex], 3)
                    + util.putByte(bytes[baseIndex + 1], 2)
                    + util.putByte(bytes[baseIndex + 2], 1)
                    + util.putByte(bytes[baseIndex + 3], 0)
        
        result[i] = value
    end
    
    return result
end

--[[
--------------------------------------------------------------------------------
函数: util.intsToBytes(ints, bytes, start, count)
--------------------------------------------------------------------------------
功能: 将 32 位整数数组转换为字节数组

参数:
  ints  - 32 位整数数组
  bytes - 目标字节数组
  start - 目标起始索引
  count - 要转换的整数数量

返回值:
  table - 更新后的字节数组

说明:
  采用大端序（Big-Endian）：最高字节放在前面。
--------------------------------------------------------------------------------
--]]
function util.intsToBytes(ints, bytes, start, count)
    bytes = bytes or {}
    
    for i = 0, count - 1 do
        for j = 0, 3 do
            local byteIndex = start + i * 4 + (3 - j)
            bytes[byteIndex] = util.getByte(ints[i], j)
        end
    end
    
    return bytes
end

--[[
--------------------------------------------------------------------------------
函数: private.bytesToHex(bytes)
--------------------------------------------------------------------------------
功能: 将字节数组转换为十六进制字符串（内部函数）

参数:
  bytes - 字节数组

返回值:
  string - 十六进制字符串，每个字节用空格分隔
--------------------------------------------------------------------------------
--]]
function private.bytesToHex(bytes)
    local result = ""
    for _, byte in ipairs(bytes) do
        result = result .. string.format("%02x ", byte)
    end
    return result
end

--[[
--------------------------------------------------------------------------------
函数: util.toHexString(data)
--------------------------------------------------------------------------------
功能: 将各种类型的数据转换为十六进制字符串

参数:
  data - 数字、表或字符串

返回值:
  string - 十六进制表示

说明:
  - 数字：转换为 8 位十六进制
  - 表：调用 bytesToHex
  - 字符串：先转换为字节数组再转换
--------------------------------------------------------------------------------
--]]
function util.toHexString(data)
    local dataType = type(data)
    
    if dataType == "number" then
        return string.format("%08x", data)
    elseif dataType == "table" then
        return private.bytesToHex(data)
    elseif dataType == "string" then
        local bytes = {}
        bytes[1], bytes[2], bytes[3], bytes[4] = string.byte(data, 1, #data)
        return private.bytesToHex(bytes)
    else
        return data
    end
end

--[[
--------------------------------------------------------------------------------
函数: util.padByteString(str)
--------------------------------------------------------------------------------
功能: 填充字符串使其长度为 16 字节的倍数

参数:
  str - 原始字符串

返回值:
  string - 填充后的字符串

说明:
  填充格式：
  - 2 字节随机数（用于增加随机性）
  - 4 字节原始长度（大端序）
  - 原始数据
  - 随机填充字节（使总长度为 16 的倍数）
  
  这种填充方式可以在解密后验证数据完整性。
--------------------------------------------------------------------------------
--]]
function util.padByteString(str)
    local originalLength = #str
    
    -- 生成 2 字节随机数
    local rand1 = math.random(0, 255)
    local rand2 = math.random(0, 255)
    
    -- 构建头部：2 字节随机 + 4 字节长度（大端序）
    local header = string.char(
        rand1, rand2,
        util.getByte(originalLength, 3),
        util.getByte(originalLength, 2),
        util.getByte(originalLength, 1),
        util.getByte(originalLength, 0)
    )
    
    -- 拼接头部和原始数据
    str = header .. str
    
    -- 计算需要填充的字节数
    local paddedLength = math.ceil(#str / 16) * 16
    local paddingNeeded = paddedLength - #str
    
    -- 添加随机填充字节
    local padding = ""
    for i = 1, paddingNeeded do
        padding = padding .. string.char(math.random(0, 255))
    end
    
    return str .. padding
end

--[[
--------------------------------------------------------------------------------
函数: private.properlyDecrypted(str)
--------------------------------------------------------------------------------
功能: 检查解密后的数据是否有效（内部函数）

参数:
  str - 解密后的字符串

返回值:
  boolean - true 表示数据有效

说明:
  通过检查头部的随机字节对来验证：
  第 1 字节应等于第 3 字节，第 2 字节应等于第 4 字节。
  （注：这是一种简单的校验方式）
--------------------------------------------------------------------------------
--]]
function private.properlyDecrypted(str)
    local bytes = {}
    bytes[1], bytes[2], bytes[3], bytes[4] = string.byte(str, 1, 4)
    
    -- 检查随机字节对是否匹配
    if bytes[1] == bytes[3] and bytes[2] == bytes[4] then
        return true
    end
    return false
end

--[[
--------------------------------------------------------------------------------
函数: util.unpadByteString(str)
--------------------------------------------------------------------------------
功能: 移除填充，恢复原始字符串

参数:
  str - 填充后的字符串

返回值:
  string - 原始字符串，如果校验失败返回 nil

说明:
  1. 首先验证数据完整性
  2. 从头部提取原始长度
  3. 截取原始数据部分
--------------------------------------------------------------------------------
--]]
function util.unpadByteString(str)
    -- 验证数据完整性
    if not private.properlyDecrypted(str) then
        return nil
    end
    
    -- 从头部提取原始长度（字节 5-8，大端序）
    local length = util.putByte(string.byte(str, 5), 3)
                 + util.putByte(string.byte(str, 6), 2)
                 + util.putByte(string.byte(str, 7), 1)
                 + util.putByte(string.byte(str, 8), 0)
    
    -- 截取原始数据（从第 9 字节开始）
    return string.sub(str, 9, 8 + length)
end

--[[
--------------------------------------------------------------------------------
函数: util.xorIV(block, iv)
--------------------------------------------------------------------------------
功能: 将数据块与初始化向量 (IV) 进行异或

参数:
  block - 16 字节数据块（会被原地修改）
  iv    - 16 字节初始化向量

说明:
  这是 CBC、OFB、CFB 等加密模式的核心操作。
  block[i] = block[i] XOR iv[i]，对于 i = 1 到 16。
--------------------------------------------------------------------------------
--]]
function util.xorIV(block, iv)
    for i = 1, 16 do
        block[i] = bit.bxor(block[i], iv[i])
    end
end

-- 返回工具函数模块
return util
