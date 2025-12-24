--[[
  RC4 流密码加密模块
  
  功能说明:
  - RC4 (Rivest Cipher 4) 对称流加密算法实现
  - 支持加密和解密操作
  - 密钥长度: 1-256 字节
  
  使用示例:
  local rc4 = require("rc4")
  local cipher = rc4.new("secret_key", true)  -- true表示加密模式
  local encrypted = cipher.encrypt("plaintext")
  
  local decipher = rc4.new("secret_key", false)  -- false表示解密模式
  local decrypted = decipher.decrypt(encrypted)
  
  算法原理:
  1. KSA (Key-Scheduling Algorithm): 根据密钥初始化S盒
  2. PRGA (Pseudo-Random Generation Algorithm): 生成伪随机字节流
  3. 将明文与伪随机流进行异或得到密文
]]

local string = require("string")
local bit = require("bit")

module("rc4")

local function swap_state(state)
    local temp = state.schedule[state.i]
    state.schedule[state.i] = state.schedule[state.j]
    state.schedule[state.j] = temp
end

local function swap_array(arr, i, j)
    local temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

local function key_schedule(key)
    local key_len = string.len(key)
    local key_bytes = { string.byte(key, 1, 10) }
    
    if key_len < 1 or key_len > 256 then
        error("Key length must be between 1 and 256 bytes")
    end
    
    local schedule = {}
    for i = 0, 255 do
        schedule[i] = i
    end
    
    local j = 0
    for i = 0, 255 do
        j = (j + schedule[i] + key_bytes[(i % key_len) + 1]) % 256
        swap_array(schedule, i, j)
    end
    
    return schedule
end

local function generate_keystream(state, length)
    local keystream = {}
    
    for k = 1, length do
        state.i = (state.i + 1) % 256
        state.j = (state.j + state.schedule[state.i - 1]) % 256
        swap_state(state)
        
        local idx = (state.schedule[state.i - 1] + state.schedule[state.j - 1] - 1) % 256
        keystream[#keystream + 1] = state.schedule[idx]
    end
    
    return keystream
end

local function crypt(plaintext, state)
    local length = string.len(plaintext)
    local keystream = generate_keystream(state, length)
    local result = ""
    
    for i = 1, length do
        result = result .. string.char(bit.bxor(keystream[i], string.byte(plaintext, i)))
    end
    
    return result
end

function new(key, is_encrypt)
    local schedule = key_schedule(key)
    local state = {
        i = 0,
        j = 0,
        schedule = schedule
    }
    
    local cipher = {}
    local mode = is_encrypt and "encrypt" or "decrypt"
    
    cipher[mode] = function(data)
        return crypt(data, state)
    end
    
    return cipher
end
