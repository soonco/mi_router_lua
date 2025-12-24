--[[
  小米路由器加密工具模块
  
  功能说明:
  - Base64编码/解码
  - MD5哈希计算
  - SHA1哈希计算
  - SHA256哈希计算
  - 二进制与十六进制转换
  
  主要函数:
  - binaryBase64Enc(): 二进制Base64编码
  - binaryBase64Dec(): Base64解码
  - md5File(): 计算文件MD5
  - md5Str(): 计算字符串MD5
  - sha1(): 计算SHA1哈希
  - sha256(): 计算SHA256哈希
  - binToHex(): 二进制转十六进制
  - hextobin(): 十六进制转二进制
]]

module("xiaoqiang.util.XQCryptoUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")

-- Base64字符表
local BASE64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- 二进制数据Base64编码
-- @param data 二进制数据
-- @return string Base64编码字符串
function binaryBase64Enc(data)
    -- 将每个字节转换为8位二进制字符串
    local binary_str = data:gsub(".", function(char)
        local result = ""
        local byte = char:byte()
        
        for i = 8, 1, -1 do
            local bit = byte % (2 ^ i) - byte % (2 ^ (i - 1))
            if bit > 0 then
                result = result .. "1"
            else
                result = result .. "0"
            end
        end
        
        return result
    end)
    
    -- 补齐到6的倍数
    binary_str = binary_str .. "0000"
    
    -- 每6位转换为一个Base64字符
    local encoded = binary_str:gsub("%d%d%d?%d?%d?%d?", function(bits)
        if #bits < 6 then
            return ""
        end
        
        local value = 0
        for i = 1, 6 do
            local bit = bits:sub(i, i)
            if bit == "1" then
                value = value + (2 ^ (6 - i))
            end
        end
        
        return BASE64_CHARS:sub(value + 1, value + 1)
    end)
    
    -- 添加填充字符
    local padding = {"", "==", "="}
    local padding_idx = (#data % 3) + 1
    encoded = encoded .. padding[padding_idx]
    
    return encoded
end

-- Base64解码
-- @param data Base64编码字符串
-- @return string 解码后的二进制数据
function binaryBase64Dec(data)
    -- 移除非Base64字符
    data = string.gsub(data, "[^" .. BASE64_CHARS .. "=]", "")
    
    -- 将每个Base64字符转换为6位二进制
    local binary_str = data:gsub(".", function(char)
        if char == "=" then
            return ""
        end
        
        local result = ""
        local value = BASE64_CHARS:find(char) - 1
        
        for i = 6, 1, -1 do
            local bit = value % (2 ^ i) - value % (2 ^ (i - 1))
            if bit > 0 then
                result = result .. "1"
            else
                result = result .. "0"
            end
        end
        
        return result
    end)
    
    -- 每8位转换为一个字节
    local decoded = binary_str:gsub("%d%d%d?%d?%d?%d?%d?%d?", function(bits)
        if #bits ~= 8 then
            return ""
        end
        
        local value = 0
        for i = 1, 8 do
            local bit = bits:sub(i, i)
            if bit == "1" then
                value = value + (2 ^ (8 - i))
            end
        end
        
        return string.char(value)
    end)
    
    return decoded
end

-- 计算文件的MD5哈希
-- @param filepath 文件路径
-- @return string MD5哈希值（32位十六进制）
function md5File(filepath)
    local luci_util = require("luci.util")
    
    local cmd = "/usr/bin/md5sum \"%s\"|/usr/bin/cut -d' ' -f1" % XQFunction._cmdformat(filepath)
    return luci_util.trim(luci_util.exec(cmd))
end

-- 计算字符串的MD5哈希
-- @param str 输入字符串
-- @return string MD5哈希值（32位十六进制）
function md5Str(str)
    local luci_util = require("luci.util")
    
    local cmd = "/bin/echo -n \"%s\"|/usr/bin/md5sum|/usr/bin/cut -d' ' -f1" % XQFunction._cmdformat(str)
    return luci_util.trim(luci_util.exec(cmd))
end

-- 计算字符串的SHA256哈希
-- @param str 输入字符串
-- @return string SHA256哈希值（64位十六进制）
function sha256(str)
    local luci_util = require("luci.util")
    
    local cmd = "/bin/echo -n \"%s\"|openssl dgst -r -sha256|/usr/bin/cut -d' ' -f1" % XQFunction._cmdformat(str)
    return luci_util.trim(luci_util.exec(cmd))
end

-- 十六进制字符串转二进制
-- @param hex_str 十六进制字符串
-- @return string 二进制数据
local function hex_to_binary(hex_str)
    return hex_str:gsub("..", function(hex)
        return string.char(base.tonumber(hex, 16))
    end)
end

-- 计算SHA256并返回二进制结果
-- @param str 输入字符串
-- @return string SHA256二进制结果
function sha256_binary(str)
    return hex_to_binary(sha256(str))
end

-- sha256Binary的别名
function sha256Binary(str)
    return sha256_binary(str)
end

-- 计算字符串MD5的Base64编码
-- @param str 输入字符串
-- @return string MD5的Base64编码
function md5Base64Str(str)
    local mime = require("mime")
    return md5Str(mime.b64(str))
end

-- 计算字符串的SHA1哈希
-- @param str 输入字符串
-- @return string SHA1哈希值（40位十六进制）
function sha1(str)
    local sha1_lib = require("sha1")
    return sha1_lib.sha1(str)
end

-- 计算SHA1并返回二进制结果
-- @param str 输入字符串
-- @return string SHA1二进制结果
function sha1Binary(str)
    local sha1_lib = require("sha1")
    return sha1_lib.sha1_binary(str)
end

-- 计算SHA1的Base64编码
-- @param str 输入字符串
-- @return string SHA1的Base64编码
function hash4SHA1(str)
    return binaryBase64Enc(sha1Binary(str))
end

-- 二进制数据转十六进制字符串
-- @param bin 二进制数据
-- @return string 十六进制字符串
function binToHex(bin)
    return bin:gsub("(.)", function(char)
        return string.format("%02x", string.byte(char))
    end)
end

-- 十六进制字符串转二进制数据
-- @param hex 十六进制字符串
-- @return string 二进制数据
function hextobin(hex)
    return hex:gsub("(%x%x)", function(hex_byte)
        return string.char(tonumber(hex_byte, 16))
    end)
end
