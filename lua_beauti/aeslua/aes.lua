-- ============================================================================
-- AES 核心加密算法模块
-- 实现 AES (Advanced Encryption Standard) 对称加密算法
-- 包含 S-Box、轮密钥扩展、轮函数等核心组件
-- ============================================================================

module("aeslua.aes", package.seeall)

-- 加载依赖模块
local bit = require("bit")           -- 位操作库
local gf = require("aeslua.gf")      -- 伽罗瓦域运算
local util = require("aeslua.util")  -- 工具函数

-- ============================================================================
-- 模块初始化
-- ============================================================================

-- AES 模块表
local aes = {}
aeslua.aes = aes

-- 密钥类型常量
aes.ROUNDS = "rounds"           -- 轮数键名
aes.KEY_TYPE = "type"           -- 密钥类型键名
aes.ENCRYPTION_KEY = 1          -- 加密密钥类型
aes.DECRYPTION_KEY = 2          -- 解密密钥类型

-- ============================================================================
-- 内部查找表（预计算表，用于加速加密/解密）
-- ============================================================================

local internal = {}

-- S-Box（替换盒）：用于字节替换操作
internal.SBox = {}

-- 逆 S-Box：用于解密时的字节替换
internal.iSBox = {}

-- 加密轮函数查找表（T-Tables）
-- 这些表将 SubBytes、ShiftRows、MixColumns 合并为单次查表操作
internal.table0 = {}
internal.table1 = {}
internal.table2 = {}
internal.table3 = {}

-- 解密轮函数查找表（逆 T-Tables）
internal.tableInv0 = {}
internal.tableInv1 = {}
internal.tableInv2 = {}
internal.tableInv3 = {}

-- 轮常量（Round Constants）
-- 用于密钥扩展算法
internal.rCon = {
    0x01000000, 0x02000000, 0x04000000, 0x08000000,
    0x10000000, 0x20000000, 0x40000000, 0x80000000,
    0x1b000000, 0x36000000, 0x6c000000, 0xd8000000,
    0xab000000, 0x4d000000, 0x9a000000, 0x2f000000
}

-- ============================================================================
-- S-Box 计算函数
-- ============================================================================

-- 仿射变换映射
-- AES S-Box 的构造：先求 GF(2^8) 上的乘法逆元，再进行仿射变换
-- @param byte number - 输入字节
-- @return number - 变换后的字节
function internal.affinMap(byte)
    local mask = 0xf8  -- 初始掩码
    local result = 0
    
    for i = 1, 8 do
        -- 左移结果
        result = bit.lshift(result, 1)
        
        -- 计算奇偶校验位
        local parity = util.byteParity(bit.band(byte, mask))
        result = result + parity
        
        -- 右旋转掩码
        local lastbit = bit.band(mask, 1)
        mask = bit.band(bit.rshift(mask, 1), 0x7f)
        if lastbit ~= 0 then
            mask = bit.bor(mask, 0x80)
        else
            mask = bit.band(mask, 0x7f)
        end
    end
    
    -- 与常量 0x63 异或
    return bit.bxor(result, 0x63)
end

-- 计算 S-Box 和逆 S-Box
-- S-Box[x] = affine(x^(-1))，其中 x^(-1) 是 GF(2^8) 上的乘法逆元
function internal.calcSBox()
    for i = 0, 255 do
        local inverse
        if i ~= 0 then
            -- 计算 GF(2^8) 上的乘法逆元
            inverse = gf.invert(i)
        else
            -- 0 的逆元定义为 0
            inverse = 0
        end
        
        -- 应用仿射变换
        local mapped = internal.affinMap(inverse)
        
        -- 存储 S-Box 和逆 S-Box
        internal.SBox[i] = mapped
        internal.iSBox[mapped] = i
    end
end

-- ============================================================================
-- T-Tables 计算函数（加密用）
-- ============================================================================

-- 计算加密轮函数查找表
-- T-Tables 将 SubBytes、ShiftRows、MixColumns 三个操作合并
-- 这是一种空间换时间的优化技术
function internal.calcRoundTables()
    for i = 0, 255 do
        local byte = internal.SBox[i]
        
        -- table0: 用于第一行
        -- MixColumns 矩阵第一列: [2, 1, 1, 3]
        internal.table0[i] = util.putByte(gf.mul(3, byte), 0) +
                             util.putByte(byte, 1) +
                             util.putByte(byte, 2) +
                             util.putByte(gf.mul(2, byte), 3)
        
        -- table1: 用于第二行（循环移位）
        internal.table1[i] = util.putByte(byte, 0) +
                             util.putByte(byte, 1) +
                             util.putByte(gf.mul(2, byte), 2) +
                             util.putByte(gf.mul(3, byte), 3)
        
        -- table2: 用于第三行（循环移位）
        internal.table2[i] = util.putByte(byte, 0) +
                             util.putByte(gf.mul(2, byte), 1) +
                             util.putByte(gf.mul(3, byte), 2) +
                             util.putByte(byte, 3)
        
        -- table3: 用于第四行（循环移位）
        internal.table3[i] = util.putByte(gf.mul(2, byte), 0) +
                             util.putByte(gf.mul(3, byte), 1) +
                             util.putByte(byte, 2) +
                             util.putByte(byte, 3)
    end
end

-- ============================================================================
-- 逆 T-Tables 计算函数（解密用）
-- ============================================================================

-- 计算解密轮函数查找表
-- 逆 MixColumns 矩阵: [14, 11, 13, 9] (循环)
function internal.calcInvRoundTables()
    for i = 0, 255 do
        local byte = internal.iSBox[i]
        
        -- tableInv0: 用于第一行
        internal.tableInv0[i] = util.putByte(gf.mul(11, byte), 0) +
                                util.putByte(gf.mul(13, byte), 1) +
                                util.putByte(gf.mul(9, byte), 2) +
                                util.putByte(gf.mul(14, byte), 3)
        
        -- tableInv1: 用于第二行
        internal.tableInv1[i] = util.putByte(gf.mul(13, byte), 0) +
                                util.putByte(gf.mul(9, byte), 1) +
                                util.putByte(gf.mul(14, byte), 2) +
                                util.putByte(gf.mul(11, byte), 3)
        
        -- tableInv2: 用于第三行
        internal.tableInv2[i] = util.putByte(gf.mul(9, byte), 0) +
                                util.putByte(gf.mul(14, byte), 1) +
                                util.putByte(gf.mul(11, byte), 2) +
                                util.putByte(gf.mul(13, byte), 3)
        
        -- tableInv3: 用于第四行
        internal.tableInv3[i] = util.putByte(gf.mul(14, byte), 0) +
                                util.putByte(gf.mul(11, byte), 1) +
                                util.putByte(gf.mul(13, byte), 2) +
                                util.putByte(gf.mul(9, byte), 3)
    end
end

-- ============================================================================
-- 密钥扩展辅助函数
-- ============================================================================

-- 循环左移一个字（32位）
-- @param word number - 32位字
-- @return number - 循环左移8位后的结果
function internal.rotWord(word)
    local highByte = bit.band(word, 0xff000000)
    return bit.lshift(word, 8) + bit.rshift(highByte, 24)
end

-- 对一个字进行 S-Box 替换
-- @param word number - 32位字
-- @return number - 每个字节经过 S-Box 替换后的结果
function internal.subWord(word)
    return util.putByte(internal.SBox[util.getByte(word, 0)], 0) +
           util.putByte(internal.SBox[util.getByte(word, 1)], 1) +
           util.putByte(internal.SBox[util.getByte(word, 2)], 2) +
           util.putByte(internal.SBox[util.getByte(word, 3)], 3)
end

-- ============================================================================
-- 密钥扩展函数
-- ============================================================================

-- 扩展加密密钥
-- 根据原始密钥生成所有轮密钥
-- @param key table - 原始密钥字节数组
-- @return table - 扩展后的密钥表
function aes.expandEncryptionKey(key)
    local expandedKey = {}
    
    -- 根据密钥长度确定参数
    local keyLength = #key
    local nk = math.floor(keyLength / 4)  -- 密钥字数
    
    -- 验证密钥长度（4/6/8 字 = 128/192/256 位）
    if nk ~= 4 and nk ~= 6 and nk ~= 8 then
        print("Invalid key length: " .. keyLength)
        return nil
    end
    
    -- 根据密钥长度确定轮数
    local rounds
    if nk == 4 then
        rounds = 10  -- AES-128
    elseif nk == 6 then
        rounds = 12  -- AES-192
    else
        rounds = 14  -- AES-256
    end
    
    -- 存储轮数和密钥类型
    expandedKey[aes.ROUNDS] = rounds
    expandedKey[aes.KEY_TYPE] = aes.ENCRYPTION_KEY
    
    -- 复制原始密钥到扩展密钥的前 nk 个字
    for i = 0, nk - 1 do
        expandedKey[i] = util.putByte(key[i * 4 + 1], 3) +
                         util.putByte(key[i * 4 + 2], 2) +
                         util.putByte(key[i * 4 + 3], 1) +
                         util.putByte(key[i * 4 + 4], 0)
    end
    
    -- 生成剩余的轮密钥
    for i = nk, (rounds + 1) * 4 - 1 do
        local temp = expandedKey[i - 1]
        
        if i % nk == 0 then
            -- 每 nk 个字进行一次特殊处理
            temp = internal.rotWord(temp)
            temp = internal.subWord(temp)
            local rconIndex = math.floor(i / nk)
            temp = bit.bxor(temp, internal.rCon[rconIndex])
        elseif nk > 6 and i % nk == 4 then
            -- AES-256 额外的 SubWord 操作
            temp = internal.subWord(temp)
        end
        
        expandedKey[i] = bit.bxor(expandedKey[i - nk], temp)
    end
    
    return expandedKey
end

-- 逆 MixColumn 变换（用于生成解密密钥）
-- @param word number - 32位字
-- @return number - 变换后的字
function internal.invMixColumnOld(word)
    local b0 = util.getByte(word, 3)
    local b1 = util.getByte(word, 2)
    local b2 = util.getByte(word, 1)
    local b3 = util.getByte(word, 0)
    
    -- 应用逆 MixColumns 矩阵 [14, 11, 13, 9]
    return util.putByte(gf.add(gf.add(gf.add(gf.mul(14, b0), gf.mul(11, b1)), gf.mul(13, b2)), gf.mul(9, b3)), 3) +
           util.putByte(gf.add(gf.add(gf.add(gf.mul(14, b1), gf.mul(11, b2)), gf.mul(13, b3)), gf.mul(9, b0)), 2) +
           util.putByte(gf.add(gf.add(gf.add(gf.mul(14, b2), gf.mul(11, b3)), gf.mul(13, b0)), gf.mul(9, b1)), 1) +
           util.putByte(gf.add(gf.add(gf.add(gf.mul(14, b3), gf.mul(11, b0)), gf.mul(13, b1)), gf.mul(9, b2)), 0)
end

-- 优化版逆 MixColumn 变换
function internal.invMixColumn(word)
    local b0 = util.getByte(word, 3)
    local b1 = util.getByte(word, 2)
    local b2 = util.getByte(word, 1)
    local b3 = util.getByte(word, 0)
    
    local s0 = bit.bxor(b3, b2)
    local s1 = bit.bxor(b1, b0)
    local s2 = bit.bxor(s0, s1)
    
    s2 = bit.bxor(s2, gf.mul(8, s2))
    local w = bit.bxor(s2, gf.mul(4, bit.bxor(b2, b0)))
    s2 = bit.bxor(s2, gf.mul(4, bit.bxor(b3, b1)))
    
    return util.putByte(bit.bxor(bit.bxor(b3, s2), gf.mul(2, bit.bxor(b0, b3))), 0) +
           util.putByte(bit.bxor(bit.bxor(b2, w), gf.mul(2, s0)), 1) +
           util.putByte(bit.bxor(bit.bxor(b1, s2), gf.mul(2, bit.bxor(b0, b3))), 2) +
           util.putByte(bit.bxor(bit.bxor(b0, w), gf.mul(2, s1)), 3)
end

-- 扩展解密密钥
-- 从加密密钥生成解密密钥（需要对中间轮密钥进行逆 MixColumns）
-- @param key table - 原始密钥字节数组
-- @return table - 解密密钥表
function aes.expandDecryptionKey(key)
    local encKey = aes.expandEncryptionKey(key)
    if encKey == nil then
        return nil
    end
    
    -- 修改密钥类型
    encKey[aes.KEY_TYPE] = aes.DECRYPTION_KEY
    
    -- 对中间轮密钥应用逆 MixColumns
    local rounds = encKey[aes.ROUNDS]
    for i = 4, rounds * 4 - 1 do
        encKey[i] = internal.invMixColumnOld(encKey[i])
    end
    
    return encKey
end

-- ============================================================================
-- 轮函数
-- ============================================================================

-- 添加轮密钥（AddRoundKey）
-- 将状态与轮密钥进行异或
-- @param state table - 状态数组（4个32位字）
-- @param key table - 扩展密钥
-- @param round number - 当前轮数
function internal.addRoundKey(state, key, round)
    for i = 0, 3 do
        state[i] = bit.bxor(state[i], key[round * 4 + i])
    end
end

-- 执行一轮加密（SubBytes + ShiftRows + MixColumns）
-- 使用 T-Tables 优化
-- @param input table - 输入状态
-- @param output table - 输出状态
function internal.doRound(input, output)
    -- 使用 T-Tables 进行加密轮操作
    -- 每个输出字是4个表查找结果的异或
    output[0] = bit.bxor(bit.bxor(bit.bxor(
        internal.table0[util.getByte(input[0], 3)],
        internal.table1[util.getByte(input[1], 2)]),
        internal.table2[util.getByte(input[2], 1)]),
        internal.table3[util.getByte(input[3], 0)])
    
    output[1] = bit.bxor(bit.bxor(bit.bxor(
        internal.table0[util.getByte(input[1], 3)],
        internal.table1[util.getByte(input[2], 2)]),
        internal.table2[util.getByte(input[3], 1)]),
        internal.table3[util.getByte(input[0], 0)])
    
    output[2] = bit.bxor(bit.bxor(bit.bxor(
        internal.table0[util.getByte(input[2], 3)],
        internal.table1[util.getByte(input[3], 2)]),
        internal.table2[util.getByte(input[0], 1)]),
        internal.table3[util.getByte(input[1], 0)])
    
    output[3] = bit.bxor(bit.bxor(bit.bxor(
        internal.table0[util.getByte(input[3], 3)],
        internal.table1[util.getByte(input[0], 2)]),
        internal.table2[util.getByte(input[1], 1)]),
        internal.table3[util.getByte(input[2], 0)])
end

-- 执行最后一轮加密（SubBytes + ShiftRows，无 MixColumns）
-- @param input table - 输入状态
-- @param output table - 输出状态
function internal.doLastRound(input, output)
    output[0] = util.putByte(internal.SBox[util.getByte(input[0], 3)], 3) +
                util.putByte(internal.SBox[util.getByte(input[1], 2)], 2) +
                util.putByte(internal.SBox[util.getByte(input[2], 1)], 1) +
                util.putByte(internal.SBox[util.getByte(input[3], 0)], 0)
    
    output[1] = util.putByte(internal.SBox[util.getByte(input[1], 3)], 3) +
                util.putByte(internal.SBox[util.getByte(input[2], 2)], 2) +
                util.putByte(internal.SBox[util.getByte(input[3], 1)], 1) +
                util.putByte(internal.SBox[util.getByte(input[0], 0)], 0)
    
    output[2] = util.putByte(internal.SBox[util.getByte(input[2], 3)], 3) +
                util.putByte(internal.SBox[util.getByte(input[3], 2)], 2) +
                util.putByte(internal.SBox[util.getByte(input[0], 1)], 1) +
                util.putByte(internal.SBox[util.getByte(input[1], 0)], 0)
    
    output[3] = util.putByte(internal.SBox[util.getByte(input[3], 3)], 3) +
                util.putByte(internal.SBox[util.getByte(input[0], 2)], 2) +
                util.putByte(internal.SBox[util.getByte(input[1], 1)], 1) +
                util.putByte(internal.SBox[util.getByte(input[2], 0)], 0)
end

-- 执行一轮解密（逆 SubBytes + 逆 ShiftRows + 逆 MixColumns）
-- 使用逆 T-Tables 优化
-- @param input table - 输入状态
-- @param output table - 输出状态
function internal.doInvRound(input, output)
    output[0] = bit.bxor(bit.bxor(bit.bxor(
        internal.tableInv0[util.getByte(input[0], 3)],
        internal.tableInv1[util.getByte(input[3], 2)]),
        internal.tableInv2[util.getByte(input[2], 1)]),
        internal.tableInv3[util.getByte(input[1], 0)])
    
    output[1] = bit.bxor(bit.bxor(bit.bxor(
        internal.tableInv0[util.getByte(input[1], 3)],
        internal.tableInv1[util.getByte(input[0], 2)]),
        internal.tableInv2[util.getByte(input[3], 1)]),
        internal.tableInv3[util.getByte(input[2], 0)])
    
    output[2] = bit.bxor(bit.bxor(bit.bxor(
        internal.tableInv0[util.getByte(input[2], 3)],
        internal.tableInv1[util.getByte(input[1], 2)]),
        internal.tableInv2[util.getByte(input[0], 1)]),
        internal.tableInv3[util.getByte(input[3], 0)])
    
    output[3] = bit.bxor(bit.bxor(bit.bxor(
        internal.tableInv0[util.getByte(input[3], 3)],
        internal.tableInv1[util.getByte(input[2], 2)]),
        internal.tableInv2[util.getByte(input[1], 1)]),
        internal.tableInv3[util.getByte(input[0], 0)])
end

-- 执行最后一轮解密（逆 SubBytes + 逆 ShiftRows，无逆 MixColumns）
-- @param input table - 输入状态
-- @param output table - 输出状态
function internal.doInvLastRound(input, output)
    output[0] = util.putByte(internal.iSBox[util.getByte(input[0], 3)], 3) +
                util.putByte(internal.iSBox[util.getByte(input[3], 2)], 2) +
                util.putByte(internal.iSBox[util.getByte(input[2], 1)], 1) +
                util.putByte(internal.iSBox[util.getByte(input[1], 0)], 0)
    
    output[1] = util.putByte(internal.iSBox[util.getByte(input[1], 3)], 3) +
                util.putByte(internal.iSBox[util.getByte(input[0], 2)], 2) +
                util.putByte(internal.iSBox[util.getByte(input[3], 1)], 1) +
                util.putByte(internal.iSBox[util.getByte(input[2], 0)], 0)
    
    output[2] = util.putByte(internal.iSBox[util.getByte(input[2], 3)], 3) +
                util.putByte(internal.iSBox[util.getByte(input[1], 2)], 2) +
                util.putByte(internal.iSBox[util.getByte(input[0], 1)], 1) +
                util.putByte(internal.iSBox[util.getByte(input[3], 0)], 0)
    
    output[3] = util.putByte(internal.iSBox[util.getByte(input[3], 3)], 3) +
                util.putByte(internal.iSBox[util.getByte(input[2], 2)], 2) +
                util.putByte(internal.iSBox[util.getByte(input[1], 1)], 1) +
                util.putByte(internal.iSBox[util.getByte(input[0], 0)], 0)
end

-- ============================================================================
-- 加密和解密函数
-- ============================================================================

-- AES 块加密
-- 加密一个 16 字节的数据块
-- @param key table - 扩展后的加密密钥
-- @param input table - 输入数据（16字节）
-- @param inputOffset number - 输入偏移量
-- @param output table - 输出数据
-- @param outputOffset number - 输出偏移量
-- @return table - 加密后的数据
function aes.encrypt(key, input, inputOffset, output, outputOffset)
    inputOffset = inputOffset or 1
    output = output or {}
    outputOffset = outputOffset or 1
    
    local state = {}
    local temp = {}
    
    -- 验证密钥类型
    if key[aes.KEY_TYPE] ~= aes.ENCRYPTION_KEY then
        print("No encryption key: ", key[aes.KEY_TYPE])
        return
    end
    
    -- 将输入字节转换为状态（4个32位字）
    state = util.bytesToInts(input, inputOffset, 4)
    
    -- 初始轮密钥加
    internal.addRoundKey(state, key, 0)
    
    -- 执行 rounds-1 轮
    local round = 1
    while round < key[aes.ROUNDS] - 1 do
        internal.doRound(state, temp)
        internal.addRoundKey(temp, key, round)
        round = round + 1
        
        internal.doRound(temp, state)
        internal.addRoundKey(state, key, round)
        round = round + 1
    end
    
    -- 倒数第二轮
    internal.doRound(state, temp)
    internal.addRoundKey(temp, key, round)
    round = round + 1
    
    -- 最后一轮（无 MixColumns）
    internal.doLastRound(temp, state)
    internal.addRoundKey(state, key, round)
    
    -- 将状态转换回字节
    return util.intsToBytes(state, output, outputOffset)
end

-- AES 块解密
-- 解密一个 16 字节的数据块
-- @param key table - 扩展后的解密密钥
-- @param input table - 输入数据（16字节）
-- @param inputOffset number - 输入偏移量
-- @param output table - 输出数据
-- @param outputOffset number - 输出偏移量
-- @return table - 解密后的数据
function aes.decrypt(key, input, inputOffset, output, outputOffset)
    inputOffset = inputOffset or 1
    output = output or {}
    outputOffset = outputOffset or 1
    
    local state = {}
    local temp = {}
    
    -- 验证密钥类型
    if key[aes.KEY_TYPE] ~= aes.DECRYPTION_KEY then
        print("No decryption key: ", key[aes.KEY_TYPE])
        return
    end
    
    -- 将输入字节转换为状态
    state = util.bytesToInts(input, inputOffset, 4)
    
    -- 初始轮密钥加（从最后一轮密钥开始）
    internal.addRoundKey(state, key, key[aes.ROUNDS])
    
    -- 执行 rounds-1 轮（逆序）
    local round = key[aes.ROUNDS] - 1
    while round > 2 do
        internal.doInvRound(state, temp)
        internal.addRoundKey(temp, key, round)
        round = round - 1
        
        internal.doInvRound(temp, state)
        internal.addRoundKey(state, key, round)
        round = round - 1
    end
    
    -- 倒数第二轮
    internal.doInvRound(state, temp)
    internal.addRoundKey(temp, key, round)
    round = round - 1
    
    -- 最后一轮（无逆 MixColumns）
    internal.doInvLastRound(temp, state)
    internal.addRoundKey(state, key, round)
    
    -- 将状态转换回字节
    return util.intsToBytes(state, output, outputOffset)
end

-- ============================================================================
-- 模块初始化
-- ============================================================================

-- 预计算所有查找表
internal.calcSBox()           -- 计算 S-Box
internal.calcRoundTables()    -- 计算加密 T-Tables
internal.calcInvRoundTables() -- 计算解密 T-Tables

-- 返回模块
return aes
