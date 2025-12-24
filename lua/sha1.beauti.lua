--[[
  SHA-1 哈希算法模块
  
  功能说明:
  - SHA-1 (Secure Hash Algorithm 1) 实现
  - 生成160位(20字节)的消息摘要
  - 纯Lua实现，使用位操作模拟
  
  使用示例:
  local sha1 = require("sha1")
  local hash = sha1.sha1("Hello World")
  -- 返回40字符的十六进制字符串
  
  注意:
  - SHA-1已不再被认为是安全的哈希算法
  - 仅用于兼容性目的，新项目应使用SHA-256或更强的算法
]]

local string = require("string")
local table = require("table")
local math = require("math")
local _G = _G

module("sha1")

local function new_word()
    local word = {}
    for i = 1, 32 do
        word[i] = false
    end
    return word
end

local hex_to_bits = {
    ["0"] = {false, false, false, false},
    ["1"] = {false, false, false, true},
    ["2"] = {false, false, true, false},
    ["3"] = {false, false, true, true},
    ["4"] = {false, true, false, false},
    ["5"] = {false, true, false, true},
    ["6"] = {false, true, true, false},
    ["7"] = {false, true, true, true},
    ["8"] = {true, false, false, false},
    ["9"] = {true, false, false, true},
    ["A"] = {true, false, true, false},
    ["B"] = {true, false, true, true},
    ["C"] = {true, true, false, false},
    ["D"] = {true, true, false, true},
    ["E"] = {true, true, true, false},
    ["F"] = {true, true, true, true},
    ["a"] = {true, false, true, false},
    ["b"] = {true, false, true, true},
    ["c"] = {true, true, false, false},
    ["d"] = {true, true, false, true},
    ["e"] = {true, true, true, false},
    ["f"] = {true, true, true, true}
}

local function hex_to_word(hex_str)
    _G.assert(type(hex_str) == "string")
    _G.assert(#hex_str == 8)
    
    local word = {}
    for char in string.gmatch(hex_str, ".") do
        local bits = hex_to_bits[char]
        _G.assert(bits)
        table.insert(word, 1, bits[1])
        table.insert(word, 1, bits[2])
        table.insert(word, 1, bits[3])
        table.insert(word, 1, bits[4])
    end
    return word
end

local function copy_word(word)
    local result = {}
    for i, v in ipairs(word) do
        result[i] = v
    end
    return result
end

local function add_words(a, ...)
    local result = copy_word(a)
    local carry = 0
    
    for _, b in ipairs({...}) do
        for i = 1, 32 do
            local bit_a = result[i] and 1 or 0
            local bit_b = b[i] and 1 or 0
            local sum = bit_a + bit_b + carry
            
            if sum == 0 then
                result[i] = false
                carry = 0
            elseif sum == 1 then
                result[i] = true
                carry = 0
            elseif sum == 2 then
                result[i] = false
                carry = 1
            else
                result[i] = true
                carry = 1
            end
        end
    end
    
    return result
end

local function xor_words(a, ...)
    local result = copy_word(a)
    
    for _, b in ipairs({...}) do
        for i = 1, 32 do
            result[i] = result[i] ~= b[i]
        end
    end
    
    return result
end

local function and_words(a, b)
    local result = new_word()
    for i = 1, 32 do
        if a[i] and b[i] then
            result[i] = true
        end
    end
    return result
end

local function or_words(a, b)
    local result = new_word()
    for i = 1, 32 do
        if a[i] or b[i] then
            result[i] = true
        end
    end
    return result
end

local function or3_words(a, b, c)
    local result = new_word()
    for i = 1, 32 do
        if a[i] or b[i] or c[i] then
            result[i] = true
        end
    end
    return result
end

local function not_word(a)
    local result = new_word()
    for i = 1, 32 do
        if not a[i] then
            result[i] = true
        end
    end
    return result
end

local function left_rotate(n, word)
    local result = copy_word(word)
    while n > 0 do
        n = n - 1
        local bit = result[32]
        for i = 32, 2, -1 do
            result[i] = result[i - 1]
        end
        result[1] = bit
    end
    return result
end

local function word_to_hex(word)
    local hex = ""
    for i = 32, 1, -4 do
        local value = 0
        if word[i] then value = value + 8 end
        if word[i - 1] then value = value + 4 end
        if word[i - 2] then value = value + 2 end
        if word[i - 3] then value = value + 1 end
        hex = hex .. string.format("%x", value)
    end
    return hex
end

local function byte_to_word(byte)
    local word = new_word()
    for i = 1, 8 do
        if byte % 2 == 1 then
            word[i] = true
        end
        byte = math.floor(byte / 2)
    end
    return word
end

local function string_to_words(str)
    local words = {}
    local len = #str
    
    for i = 1, len, 4 do
        local word = new_word()
        for j = 0, 3 do
            if i + j <= len then
                local byte = string.byte(str, i + j)
                for k = 1, 8 do
                    if byte % 2 == 1 then
                        word[32 - j * 8 - k + 1] = true
                    end
                    byte = math.floor(byte / 2)
                end
            end
        end
        table.insert(words, word)
    end
    
    return words
end

local H0 = hex_to_word("67452301")
local H1 = hex_to_word("EFCDAB89")
local H2 = hex_to_word("98BADCFE")
local H3 = hex_to_word("10325476")
local H4 = hex_to_word("C3D2E1F0")

local K1 = hex_to_word("5A827999")
local K2 = hex_to_word("6ED9EBA1")
local K3 = hex_to_word("8F1BBCDC")
local K4 = hex_to_word("CA62C1D6")

function sha1(message)
    local h0 = copy_word(H0)
    local h1 = copy_word(H1)
    local h2 = copy_word(H2)
    local h3 = copy_word(H3)
    local h4 = copy_word(H4)
    
    local msg_len = #message * 8
    
    message = message .. string.char(0x80)
    
    while (#message % 64) ~= 56 do
        message = message .. string.char(0)
    end
    
    for i = 7, 0, -1 do
        local byte = math.floor(msg_len / (256 ^ i)) % 256
        message = message .. string.char(byte)
    end
    
    for chunk_start = 1, #message, 64 do
        local chunk = string.sub(message, chunk_start, chunk_start + 63)
        local w = string_to_words(chunk)
        
        for i = 17, 80 do
            w[i] = left_rotate(1, xor_words(w[i - 3], w[i - 8], w[i - 14], w[i - 16]))
        end
        
        local a = copy_word(h0)
        local b = copy_word(h1)
        local c = copy_word(h2)
        local d = copy_word(h3)
        local e = copy_word(h4)
        
        for i = 1, 80 do
            local f, k
            
            if i <= 20 then
                f = or_words(and_words(b, c), and_words(not_word(b), d))
                k = K1
            elseif i <= 40 then
                f = xor_words(b, c, d)
                k = K2
            elseif i <= 60 then
                f = or3_words(and_words(b, c), and_words(b, d), and_words(c, d))
                k = K3
            else
                f = xor_words(b, c, d)
                k = K4
            end
            
            local temp = add_words(left_rotate(5, a), f, e, k, w[i])
            e = d
            d = c
            c = left_rotate(30, b)
            b = a
            a = temp
        end
        
        h0 = add_words(h0, a)
        h1 = add_words(h1, b)
        h2 = add_words(h2, c)
        h3 = add_words(h3, d)
        h4 = add_words(h4, e)
    end
    
    return word_to_hex(h0) .. word_to_hex(h1) .. word_to_hex(h2) .. word_to_hex(h3) .. word_to_hex(h4)
end
