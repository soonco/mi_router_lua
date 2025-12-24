# ciphermode.lua - AES 密码模式模块

## 工作原理

本模块实现 AES 分组密码的四种标准工作模式，将 AES 块加密扩展为可处理任意长度数据的加密方案。

### 支持的加密模式

| 模式 | 全称 | 特点 |
|------|------|------|
| ECB | Electronic Codebook | 最简单，每块独立加密，安全性低 |
| CBC | Cipher Block Chaining | 链式加密，需要 IV，安全性高 |
| OFB | Output Feedback | 流密码模式，加解密相同 |
| CFB | Cipher Feedback | 流密码模式，错误会传播 |

### 各模式工作原理

**ECB 模式**:
```
明文块 -> [AES加密] -> 密文块
```

**CBC 模式**:
```
明文块 XOR IV -> [AES加密] -> 密文块
                              |
                              v (作为下一轮 IV)
```

**OFB 模式**:
```
IV -> [AES加密] -> 密钥流 XOR 明文块 -> 密文块
         |
         v (作为下一轮 IV)
```

**CFB 模式**:
```
IV -> [AES加密] -> 密钥流 XOR 明文块 -> 密文块
                                         |
                                         v (作为下一轮 IV)
```

## 接口

### 加密函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `ciphermode.encryptString(key, data, modeFunction)` | key: 密钥<br>data: 数据<br>modeFunction: 模式函数 | 密文字符串 | 加密字符串 |
| `ciphermode.encryptECB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 无 | ECB 加密单块 |
| `ciphermode.encryptCBC(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 无 | CBC 加密单块 |
| `ciphermode.encryptOFB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 无 | OFB 加密单块 |
| `ciphermode.encryptCFB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 无 | CFB 加密单块 |

### 解密函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `ciphermode.decryptString(key, data, modeFunction)` | key: 密钥<br>data: 数据<br>modeFunction: 模式函数 | 明文字符串 | 解密字符串 |
| `ciphermode.decryptECB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | IV | ECB 解密单块 |
| `ciphermode.decryptCBC(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 新 IV | CBC 解密单块 |
| `ciphermode.decryptOFB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | IV | OFB 解密单块 |
| `ciphermode.decryptCFB(keySchedule, block, iv)` | 轮密钥, 数据块, IV | 新 IV | CFB 解密单块 |

### 使用示例

```lua
local ciphermode = require("aeslua.ciphermode")

-- CBC 模式加密
local ciphertext = ciphermode.encryptString(key, plaintext, ciphermode.encryptCBC)

-- CBC 模式解密
local plaintext = ciphermode.decryptString(key, ciphertext, ciphermode.decryptCBC)
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `aeslua.aes` | AES 核心加密/解密 |
| `aeslua.util` | 工具函数（异或等） |
| `aeslua.buffer` | 字符串缓冲区 |
