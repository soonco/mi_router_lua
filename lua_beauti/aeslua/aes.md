# aes.lua - AES 核心加密算法模块

## 工作原理

本模块实现 AES（Advanced Encryption Standard）对称加密算法的核心功能，包括 S-Box 构建、轮密钥扩展、加密/解密轮函数等。

AES 算法流程：
1. **密钥扩展**: 将原始密钥扩展为多轮密钥
2. **初始轮密钥加**: 明文与第一轮密钥异或
3. **主轮循环** (9/11/13 轮):
   - SubBytes: S-Box 字节替换
   - ShiftRows: 行移位
   - MixColumns: 列混合
   - AddRoundKey: 轮密钥加
4. **最终轮**: SubBytes + ShiftRows + AddRoundKey（无 MixColumns）

支持的密钥长度：
- AES-128: 16 字节密钥，10 轮
- AES-192: 24 字节密钥，12 轮
- AES-256: 32 字节密钥，14 轮

性能优化：
- 使用 T-Tables 将 SubBytes、ShiftRows、MixColumns 合并为单次查表
- 预计算 S-Box、逆 S-Box 和所有 T-Tables

## 接口

### 常量

| 常量 | 说明 |
|------|------|
| `aes.ROUNDS` | 轮数键名 |
| `aes.KEY_TYPE` | 密钥类型键名 |
| `aes.ENCRYPTION_KEY` | 加密密钥类型 (1) |
| `aes.DECRYPTION_KEY` | 解密密钥类型 (2) |

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `aes.expandEncryptionKey(key)` | key: 密钥字节数组 | 扩展密钥表 | 扩展加密密钥 |
| `aes.expandDecryptionKey(key)` | key: 密钥字节数组 | 扩展密钥表 | 扩展解密密钥 |
| `aes.encrypt(key, input, inputOffset, output, outputOffset)` | 密钥和数据参数 | 加密数据 | 加密 16 字节块 |
| `aes.decrypt(key, input, inputOffset, output, outputOffset)` | 密钥和数据参数 | 解密数据 | 解密 16 字节块 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `internal.affinMap(byte)` | S-Box 仿射变换 |
| `internal.calcSBox()` | 计算 S-Box 和逆 S-Box |
| `internal.calcRoundTables()` | 计算加密 T-Tables |
| `internal.calcInvRoundTables()` | 计算解密 T-Tables |
| `internal.rotWord(word)` | 32 位字循环左移 |
| `internal.subWord(word)` | 32 位字 S-Box 替换 |
| `internal.addRoundKey(state, key, round)` | 添加轮密钥 |
| `internal.doRound(input, output)` | 执行加密轮 |
| `internal.doLastRound(input, output)` | 执行最后加密轮 |
| `internal.doInvRound(input, output)` | 执行解密轮 |
| `internal.doInvLastRound(input, output)` | 执行最后解密轮 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `bit` | 位运算库 |
| `aeslua.gf` | 伽罗瓦域运算 |
| `aeslua.util` | 工具函数 |
