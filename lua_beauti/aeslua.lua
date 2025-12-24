-- ============================================================================
-- AES 加密库模块
-- 提供 AES 对称加密和解密功能
-- 支持 AES-128、AES-192、AES-256 三种密钥长度
-- 支持 ECB、CBC、OFB、CFB 四种加密模式
-- ============================================================================

module("aeslua", package.seeall)

-- 加载依赖模块
local ciphermode = require("aeslua.ciphermode")
local util = require("aeslua.util")

-- ============================================================================
-- 常量定义
-- ============================================================================

-- AES 密钥长度常量（字节数）
aeslua = {}
aeslua.AES128 = 16    -- AES-128: 128位密钥 = 16字节
aeslua.AES192 = 24    -- AES-192: 192位密钥 = 24字节
aeslua.AES256 = 32    -- AES-256: 256位密钥 = 32字节

-- 加密模式常量
aeslua.ECBMODE = 1    -- ECB 模式：电子密码本模式（不推荐，相同明文产生相同密文）
aeslua.CBCMODE = 2    -- CBC 模式：密码块链接模式（推荐，需要初始化向量 IV）
aeslua.OFBMODE = 3    -- OFB 模式：输出反馈模式（流密码模式）
aeslua.CFBMODE = 4    -- CFB 模式：密码反馈模式（流密码模式）

-- 内部使用的模块引用
local internal = {}

-- ============================================================================
-- 密码转密钥函数
-- ============================================================================

-- 将密码字符串转换为 AES 密钥
-- 使用 AES-CBC 模式对密码进行加密处理，生成固定长度的密钥
-- @param password string - 用户密码
-- @param keyLength number - 目标密钥长度（16/24/32）
-- @return table - 密钥字节数组
function internal.pwToKey(password, keyLength)
    local targetLength = keyLength
    
    -- AES-192 需要 32 字节的中间密钥
    if keyLength == aeslua.AES192 then
        targetLength = 32
    end
    
    -- 密码长度调整
    local pwLength = #password
    if targetLength > pwLength then
        -- 密码太短，用 0x00 填充
        local padding = ""
        for i = 1, targetLength - pwLength do
            padding = padding .. string.char(0)
        end
        password = password .. padding
    else
        -- 密码太长，截断
        password = string.sub(password, 1, targetLength)
    end
    
    -- 将密码转换为字节数组
    local keyBytes = {}
    local len = #password
    for i = 1, len do
        keyBytes[i] = string.byte(password, i)
    end
    
    -- 使用 CBC 模式加密密码，生成密钥
    -- 这是一种密钥派生方法
    local encryptedKey = ciphermode.encryptCBC(keyBytes, keyBytes, nil, 1, #password)
    
    -- 取加密结果作为最终密钥
    local result = {}
    for i = 1, keyLength do
        result[i] = encryptedKey[i]
    end
    
    return result
end

-- ============================================================================
-- 加密函数
-- ============================================================================

-- AES 加密函数
-- @param password string - 加密密码
-- @param data string - 要加密的数据
-- @param keyLength number - 可选，密钥长度（默认 AES128）
-- @param mode number - 可选，加密模式（默认 CBCMODE）
-- @return string - 加密后的数据
function aeslua.encrypt(password, data, keyLength, mode)
    -- 参数验证
    assert(password ~= nil, "Empty password.")
    assert(data ~= nil, "Empty data.")
    
    -- 设置默认值
    local encryptMode = mode or aeslua.CBCMODE
    local keyLen = keyLength or aeslua.AES128
    
    -- 从密码生成密钥
    local key = internal.pwToKey(password, keyLen)
    
    -- 对数据进行填充（PKCS7 填充）
    local paddedData = util.padByteString(data)
    
    -- 根据模式选择加密函数
    if encryptMode == aeslua.ECBMODE then
        -- ECB 模式加密
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptECB)
        
    elseif encryptMode == aeslua.CBCMODE then
        -- CBC 模式加密
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptCBC)
        
    elseif encryptMode == aeslua.OFBMODE then
        -- OFB 模式加密
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptOFB)
        
    elseif encryptMode == aeslua.CFBMODE then
        -- CFB 模式加密
        return ciphermode.encryptString(key, paddedData, ciphermode.encryptCFB)
        
    else
        -- 未知模式
        return nil
    end
end

-- ============================================================================
-- 解密函数
-- ============================================================================

-- AES 解密函数
-- @param password string - 解密密码
-- @param data string - 要解密的数据
-- @param keyLength number - 可选，密钥长度（默认 AES128）
-- @param mode number - 可选，加密模式（默认 CBCMODE）
-- @return string - 解密后的数据，失败返回 nil
function aeslua.decrypt(password, data, keyLength, mode)
    -- 设置默认值
    local decryptMode = mode or aeslua.CBCMODE
    local keyLen = keyLength or aeslua.AES128
    
    -- 从密码生成密钥
    local key = internal.pwToKey(password, keyLen)
    
    -- 解密数据
    local decrypted = nil
    
    if decryptMode == aeslua.ECBMODE then
        -- ECB 模式解密
        decrypted = ciphermode.decryptString(key, data, ciphermode.decryptECB)
        
    elseif decryptMode == aeslua.CBCMODE then
        -- CBC 模式解密
        decrypted = ciphermode.decryptString(key, data, ciphermode.decryptCBC)
        
    elseif decryptMode == aeslua.OFBMODE then
        -- OFB 模式解密
        decrypted = ciphermode.decryptString(key, data, ciphermode.decryptOFB)
        
    elseif decryptMode == aeslua.CFBMODE then
        -- CFB 模式解密
        decrypted = ciphermode.decryptString(key, data, ciphermode.decryptCFB)
    end
    
    -- 移除填充
    local result = util.unpadByteString(decrypted)
    
    -- 返回结果
    if result == nil then
        return nil
    end
    
    return result
end

-- 返回模块
return aeslua
