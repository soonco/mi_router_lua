--[[
================================================================================
AES 加密库 - 密码模式模块 (Cipher Mode Module)
================================================================================

功能说明：
  本模块实现了 AES 分组密码的四种标准工作模式：
  
  1. ECB (Electronic Codebook) - 电子密码本模式
     - 最简单的模式，每个块独立加密
     - 相同明文块产生相同密文块，安全性较低
     - 不推荐用于加密大量数据
  
  2. CBC (Cipher Block Chaining) - 密码块链接模式
     - 每个明文块与前一个密文块异或后再加密
     - 需要初始化向量 (IV)
     - 相同明文产生不同密文，安全性较高
  
  3. OFB (Output Feedback) - 输出反馈模式
     - 将块密码转换为流密码
     - 加密和解密使用相同操作
     - 错误不会传播
  
  4. CFB (Cipher Feedback) - 密码反馈模式
     - 也将块密码转换为流密码
     - 加密使用加密函数，解密也使用加密函数
     - 错误会传播到下一个块

初始化向量 (IV)：
  除 ECB 模式外，其他模式都需要 IV。
  如果未提供 IV，默认使用全零向量（不推荐用于生产环境）。

================================================================================
--]]

-- 声明模块
module("aeslua.ciphermode", package.seeall)

-- 加载依赖模块
local aes = require("aeslua.aes")       -- AES 核心加密/解密函数
local util = require("aeslua.util")     -- 工具函数（异或等）
local buffer = require("aeslua.buffer") -- 字符串缓冲区

-- 创建密码模式对象表
local ciphermode = {}

-- 将密码模式对象挂载到 aeslua 命名空间
aeslua.ciphermode = ciphermode

--[[
================================================================================
                              加密函数
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: ciphermode.encryptString(key, data, modeFunction)
--------------------------------------------------------------------------------
功能: 使用指定的加密模式加密字符串

参数:
  key          - 加密密钥（字节数组）
  data         - 待加密的字符串数据
  modeFunction - 加密模式函数（encryptECB/encryptCBC/encryptOFB/encryptCFB）

返回值:
  string - 加密后的密文字符串

说明:
  这是加密的主入口函数，负责：
  1. 初始化 IV（如果未提供则使用全零向量）
  2. 扩展加密密钥
  3. 将输入数据分成 16 字节的块
  4. 对每个块调用指定的模式函数进行加密
  5. 将加密结果拼接成字符串返回
--------------------------------------------------------------------------------
--]]
function ciphermode.encryptString(key, data, modeFunction)
    -- 初始化向量 (IV)
    -- 如果未提供，使用 16 字节全零向量
    local iv = iv  -- 尝试使用外部提供的 iv
    if not iv then
        iv = {
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        }
    end
    
    -- 扩展加密密钥（生成轮密钥）
    local keySchedule = aes.expandEncryptionKey(key)
    
    -- 创建输出缓冲区
    local outputBuffer = buffer.new()
    
    -- 计算数据块数量（每块 16 字节）
    local blockCount = #data / 16
    
    -- 逐块加密
    for blockIndex = 1, blockCount do
        -- 计算当前块的起始位置
        local startPos = (blockIndex - 1) * 16 + 1
        
        -- 将当前块的 16 个字节提取到数组中
        local block = {}
        block[1], block[2], block[3], block[4],
        block[5], block[6], block[7], block[8],
        block[9], block[10], block[11], block[12],
        block[13], block[14], block[15], block[16] = string.byte(data, startPos, startPos + 15)
        
        -- 调用指定的加密模式函数
        -- 参数：轮密钥、数据块、IV
        -- IV 会在模式函数中被更新
        modeFunction(keySchedule, block, iv)
        
        -- 将加密后的块转换为字符串并添加到缓冲区
        buffer.addString(outputBuffer, string.char(unpack(block)))
    end
    
    -- 返回完整的加密字符串
    return buffer.toString(outputBuffer)
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.encryptECB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: ECB 模式加密单个数据块

参数:
  keySchedule - 扩展后的轮密钥
  block       - 16 字节数据块（会被原地修改）
  iv          - 初始化向量（ECB 模式不使用，忽略）

说明:
  ECB 模式直接对数据块进行加密，不使用 IV，
  每个块独立加密，相同明文产生相同密文。
--------------------------------------------------------------------------------
--]]
function ciphermode.encryptECB(keySchedule, block, iv)
    -- 直接加密数据块
    -- 参数：轮密钥、输入块、起始索引、输出块、起始索引
    aes.encrypt(keySchedule, block, 1, block, 1)
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.encryptCBC(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: CBC 模式加密单个数据块

参数:
  keySchedule - 扩展后的轮密钥
  block       - 16 字节数据块（会被原地修改）
  iv          - 初始化向量（会被更新为当前密文块）

说明:
  CBC 模式的加密步骤：
  1. 将明文块与 IV（或前一个密文块）异或
  2. 对异或结果进行加密
  3. 将密文块保存为下一轮的 IV
--------------------------------------------------------------------------------
--]]
function ciphermode.encryptCBC(keySchedule, block, iv)
    -- 步骤 1: 明文块与 IV 异或
    util.xorIV(block, iv)
    
    -- 步骤 2: 加密异或后的数据
    aes.encrypt(keySchedule, block, 1, block, 1)
    
    -- 步骤 3: 将密文块复制到 IV，用于下一轮
    for i = 1, 16 do
        iv[i] = block[i]
    end
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.encryptOFB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: OFB 模式加密单个数据块

参数:
  keySchedule - 扩展后的轮密钥
  block       - 16 字节数据块（会被原地修改）
  iv          - 初始化向量（会被更新为加密后的 IV）

说明:
  OFB 模式的加密步骤：
  1. 加密 IV 得到密钥流
  2. 将明文块与密钥流异或得到密文
  3. 加密后的 IV 用于下一轮
  
  特点：加密和解密操作完全相同
--------------------------------------------------------------------------------
--]]
function ciphermode.encryptOFB(keySchedule, block, iv)
    -- 步骤 1: 加密 IV 生成密钥流
    aes.encrypt(keySchedule, iv, 1, iv, 1)
    
    -- 步骤 2: 明文块与密钥流异或得到密文
    util.xorIV(block, iv)
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.encryptCFB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: CFB 模式加密单个数据块

参数:
  keySchedule - 扩展后的轮密钥
  block       - 16 字节数据块（会被原地修改）
  iv          - 初始化向量（会被更新为当前密文块）

说明:
  CFB 模式的加密步骤：
  1. 加密 IV 得到密钥流
  2. 将明文块与密钥流异或得到密文
  3. 将密文块保存为下一轮的 IV
--------------------------------------------------------------------------------
--]]
function ciphermode.encryptCFB(keySchedule, block, iv)
    -- 步骤 1: 加密 IV 生成密钥流
    aes.encrypt(keySchedule, iv, 1, iv, 1)
    
    -- 步骤 2: 明文块与密钥流异或得到密文
    util.xorIV(block, iv)
    
    -- 步骤 3: 将密文块复制到 IV，用于下一轮
    for i = 1, 16 do
        iv[i] = block[i]
    end
end

--[[
================================================================================
                              解密函数
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: ciphermode.decryptString(key, data, modeFunction)
--------------------------------------------------------------------------------
功能: 使用指定的解密模式解密字符串

参数:
  key          - 解密密钥（字节数组）
  data         - 待解密的密文字符串
  modeFunction - 解密模式函数（decryptECB/decryptCBC/decryptOFB/decryptCFB）

返回值:
  string - 解密后的明文字符串

说明:
  这是解密的主入口函数，负责：
  1. 初始化 IV
  2. 根据模式选择扩展加密密钥或解密密钥
     - OFB/CFB 模式使用加密密钥（因为解密时也用加密操作）
     - ECB/CBC 模式使用解密密钥
  3. 将输入数据分成 16 字节的块
  4. 对每个块调用指定的模式函数进行解密
  5. 将解密结果拼接成字符串返回
--------------------------------------------------------------------------------
--]]
function ciphermode.decryptString(key, data, modeFunction)
    -- 初始化向量 (IV)
    local iv = iv
    if not iv then
        iv = {
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        }
    end
    
    -- 根据解密模式选择密钥扩展方式
    local keySchedule = nil
    
    -- OFB 和 CFB 模式解密时使用加密操作，所以需要加密密钥
    if modeFunction == ciphermode.decryptOFB or modeFunction == ciphermode.decryptCFB then
        keySchedule = aes.expandEncryptionKey(key)
    else
        -- ECB 和 CBC 模式使用标准解密操作，需要解密密钥
        keySchedule = aes.expandDecryptionKey(key)
    end
    
    -- 创建输出缓冲区
    local outputBuffer = buffer.new()
    
    -- 计算数据块数量
    local blockCount = #data / 16
    
    -- 逐块解密
    for blockIndex = 1, blockCount do
        -- 计算当前块的起始位置
        local startPos = (blockIndex - 1) * 16 + 1
        
        -- 将当前块的 16 个字节提取到数组中
        local block = {}
        block[1], block[2], block[3], block[4],
        block[5], block[6], block[7], block[8],
        block[9], block[10], block[11], block[12],
        block[13], block[14], block[15], block[16] = string.byte(data, startPos, startPos + 15)
        
        -- 调用指定的解密模式函数
        -- 返回值用于更新 IV（某些模式需要）
        iv = modeFunction(keySchedule, block, iv)
        
        -- 将解密后的块转换为字符串并添加到缓冲区
        buffer.addString(outputBuffer, string.char(unpack(block)))
    end
    
    -- 返回完整的解密字符串
    return buffer.toString(outputBuffer)
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.decryptECB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: ECB 模式解密单个数据块

参数:
  keySchedule - 扩展后的解密轮密钥
  block       - 16 字节密文块（会被原地修改为明文）
  iv          - 初始化向量（ECB 模式不使用）

返回值:
  iv - 返回原 IV（未修改）

说明:
  ECB 模式直接对密文块进行解密，每个块独立处理。
--------------------------------------------------------------------------------
--]]
function ciphermode.decryptECB(keySchedule, block, iv)
    -- 直接解密数据块
    aes.decrypt(keySchedule, block, 1, block, 1)
    return iv
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.decryptCBC(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: CBC 模式解密单个数据块

参数:
  keySchedule - 扩展后的解密轮密钥
  block       - 16 字节密文块（会被原地修改为明文）
  iv          - 初始化向量

返回值:
  table - 当前密文块的副本（作为下一轮的 IV）

说明:
  CBC 模式的解密步骤：
  1. 保存当前密文块（用于下一轮 IV）
  2. 解密密文块
  3. 将解密结果与 IV 异或得到明文
  4. 返回保存的密文块作为新 IV
--------------------------------------------------------------------------------
--]]
function ciphermode.decryptCBC(keySchedule, block, iv)
    -- 步骤 1: 保存当前密文块（解密前）
    local cipherBlock = {}
    for i = 1, 16 do
        cipherBlock[i] = block[i]
    end
    
    -- 步骤 2: 解密密文块
    aes.decrypt(keySchedule, block, 1, block, 1)
    
    -- 步骤 3: 与 IV 异或得到明文
    util.xorIV(block, iv)
    
    -- 步骤 4: 返回保存的密文块作为下一轮 IV
    return cipherBlock
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.decryptOFB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: OFB 模式解密单个数据块

参数:
  keySchedule - 扩展后的加密轮密钥（注意：使用加密密钥）
  block       - 16 字节密文块（会被原地修改为明文）
  iv          - 初始化向量（会被更新）

返回值:
  iv - 更新后的 IV

说明:
  OFB 模式的解密与加密操作完全相同：
  1. 加密 IV 得到密钥流
  2. 将密文块与密钥流异或得到明文
--------------------------------------------------------------------------------
--]]
function ciphermode.decryptOFB(keySchedule, block, iv)
    -- 加密 IV 生成密钥流
    aes.encrypt(keySchedule, iv, 1, iv, 1)
    
    -- 密文块与密钥流异或得到明文
    util.xorIV(block, iv)
    
    return iv
end

--[[
--------------------------------------------------------------------------------
函数: ciphermode.decryptCFB(keySchedule, block, iv)
--------------------------------------------------------------------------------
功能: CFB 模式解密单个数据块

参数:
  keySchedule - 扩展后的加密轮密钥（注意：使用加密密钥）
  block       - 16 字节密文块（会被原地修改为明文）
  iv          - 初始化向量

返回值:
  table - 当前密文块的副本（作为下一轮的 IV）

说明:
  CFB 模式的解密步骤：
  1. 保存当前密文块（用于下一轮 IV）
  2. 加密 IV 得到密钥流
  3. 将密文块与密钥流异或得到明文
  4. 返回保存的密文块作为新 IV
--------------------------------------------------------------------------------
--]]
function ciphermode.decryptCFB(keySchedule, block, iv)
    -- 步骤 1: 保存当前密文块（解密前）
    local cipherBlock = {}
    for i = 1, 16 do
        cipherBlock[i] = block[i]
    end
    
    -- 步骤 2: 加密 IV 生成密钥流
    aes.encrypt(keySchedule, iv, 1, iv, 1)
    
    -- 步骤 3: 密文块与密钥流异或得到明文
    util.xorIV(block, iv)
    
    -- 步骤 4: 返回保存的密文块作为下一轮 IV
    return cipherBlock
end

-- 返回密码模式模块
return ciphermode
