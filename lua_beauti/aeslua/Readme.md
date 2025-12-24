# AESLua - 纯 Lua 实现的 AES 加密库

## 概述

AESLua 是一个完全使用 Lua 语言实现的 AES（Advanced Encryption Standard）对称加密库。该库提供完整的 AES 加密/解密功能，支持多种密钥长度和加密模式，适用于需要在纯 Lua 环境中进行数据加密的场景。

## 特性

- **纯 Lua 实现**：无需外部 C 库依赖
- **多密钥长度支持**：AES-128、AES-192、AES-256
- **多加密模式**：ECB、CBC、OFB、CFB
- **性能优化**：使用 T-Tables 和预计算表加速运算
- **完整的数据填充**：自动处理任意长度数据

## 模块结构

```
aeslua/
├── aes.lua          # AES 核心加密算法
├── buffer.lua       # 高效字符串缓冲区
├── ciphermode.lua   # 加密模式实现
├── gf.lua           # 伽罗瓦域运算
├── util.lua         # 工具函数
└── Readme.md        # 本文档
```

## 模块详解

### 1. aes.lua - AES 核心加密算法

实现 AES 算法的核心功能，包括 S-Box 构建、轮密钥扩展、加密/解密轮函数。

**支持的密钥长度：**

| 类型 | 密钥长度 | 轮数 |
|------|----------|------|
| AES-128 | 16 字节 | 10 轮 |
| AES-192 | 24 字节 | 12 轮 |
| AES-256 | 32 字节 | 14 轮 |

**主要接口：**

| 函数 | 说明 |
|------|------|
| `aes.expandEncryptionKey(key)` | 扩展加密密钥 |
| `aes.expandDecryptionKey(key)` | 扩展解密密钥 |
| `aes.encrypt(key, input, inputOffset, output, outputOffset)` | 加密 16 字节块 |
| `aes.decrypt(key, input, inputOffset, output, outputOffset)` | 解密 16 字节块 |

**算法流程：**
1. 密钥扩展：将原始密钥扩展为多轮密钥
2. 初始轮密钥加：明文与第一轮密钥异或
3. 主轮循环：SubBytes → ShiftRows → MixColumns → AddRoundKey
4. 最终轮：SubBytes → ShiftRows → AddRoundKey（无 MixColumns）

---

### 2. ciphermode.lua - 加密模式

实现四种标准分组密码工作模式，将 AES 块加密扩展为可处理任意长度数据的加密方案。

**支持的加密模式：**

| 模式 | 全称 | 特点 |
|------|------|------|
| ECB | Electronic Codebook | 最简单，每块独立加密，安全性低 |
| CBC | Cipher Block Chaining | 链式加密，需要 IV，安全性高 |
| OFB | Output Feedback | 流密码模式，加解密相同 |
| CFB | Cipher Feedback | 流密码模式，错误会传播 |

**主要接口：**

```lua
-- 加密
ciphermode.encryptString(key, data, modeFunction)
ciphermode.encryptECB(keySchedule, block, iv)
ciphermode.encryptCBC(keySchedule, block, iv)
ciphermode.encryptOFB(keySchedule, block, iv)
ciphermode.encryptCFB(keySchedule, block, iv)

-- 解密
ciphermode.decryptString(key, data, modeFunction)
ciphermode.decryptECB(keySchedule, block, iv)
ciphermode.decryptCBC(keySchedule, block, iv)
ciphermode.decryptOFB(keySchedule, block, iv)
ciphermode.decryptCFB(keySchedule, block, iv)
```

---

### 3. gf.lua - 伽罗瓦域运算

实现 GF(2^8) 有限域上的数学运算，这是 AES 算法的数学基础。

**GF(2^8) 参数：**

| 属性 | 值 | 说明 |
|------|-----|------|
| 元素数量 | 256 | 0 到 255 |
| 加法 | XOR | 按位异或 |
| 不可约多项式 | x^8 + x^4 + x^3 + x + 1 | 十进制 283 |
| 生成元 | 3 (x + 1) | 用于构建对数表 |

**主要接口：**

| 函数 | 说明 |
|------|------|
| `gf.add(a, b)` | GF(2^8) 加法（异或） |
| `gf.sub(a, b)` | GF(2^8) 减法（与加法相同） |
| `gf.mul(a, b)` | GF(2^8) 乘法 |
| `gf.div(a, b)` | GF(2^8) 除法 |
| `gf.invert(a)` | 计算乘法逆元 |

---

### 4. buffer.lua - 字符串缓冲区

实现高效的字符串缓冲区，优化大量字符串连接操作。

**性能优化：**
- 原始方式：O(n²) - 每次连接都复制所有已有内容
- 本模块：O(n log n) - 通过延迟合并减少内存分配

**主要接口：**

| 函数 | 说明 |
|------|------|
| `buffer.new()` | 创建新的缓冲区对象 |
| `buffer.addString(buf, str)` | 向缓冲区添加字符串 |
| `buffer.toString(buf)` | 将缓冲区转换为字符串 |

---

### 5. util.lua - 工具函数

提供各种工具函数，包括位运算辅助、字节与整数转换、十六进制格式化、数据填充和异或操作。

**数据填充格式：**
```
| 2 字节随机数 | 4 字节原始长度 | 原始数据 | 随机填充 |
```
- 总长度为 16 字节的倍数
- 使用大端序（Big-Endian）

**主要接口：**

| 函数 | 说明 |
|------|------|
| `util.byteParity(byte)` | 计算奇偶校验位 |
| `util.getByte(word, index)` | 从字中提取字节 |
| `util.putByte(byte, index)` | 将字节放入字的指定位置 |
| `util.bytesToInts(bytes, start, count)` | 字节转整数 |
| `util.intsToBytes(ints, bytes, start, count)` | 整数转字节 |
| `util.toHexString(data)` | 转换为十六进制 |
| `util.padByteString(str)` | 填充到 16 字节对齐 |
| `util.unpadByteString(str)` | 移除填充 |
| `util.xorIV(block, iv)` | 数据块与 IV 异或 |

## 使用示例

### 基本加密/解密

```lua
local ciphermode = require("aeslua.ciphermode")

-- 密钥（16/24/32 字节）
local key = "1234567890123456"

-- 明文
local plaintext = "Hello, World!"

-- CBC 模式加密
local ciphertext = ciphermode.encryptString(key, plaintext, ciphermode.encryptCBC)

-- CBC 模式解密
local decrypted = ciphermode.decryptString(key, ciphertext, ciphermode.decryptCBC)
```

### 使用字符串缓冲区

```lua
local buffer = require("aeslua.buffer")

local buf = buffer.new()
buffer.addString(buf, "Hello")
buffer.addString(buf, " ")
buffer.addString(buf, "World")
local result = buffer.toString(buf)  -- "Hello World"
```

### 伽罗瓦域运算

```lua
local gf = require("aeslua.gf")

local sum = gf.add(0x57, 0x83)       -- 加法（异或）
local product = gf.mul(0x57, 0x83)  -- 乘法
local inverse = gf.invert(0x53)     -- 求逆
```

## 依赖

| 模块 | 说明 |
|------|------|
| `bit` | Lua 位运算库 |
| `math` | Lua 数学库 |
| `string` | Lua 字符串库 |
| `table` | Lua 表操作库 |

## 安全建议

1. **避免使用 ECB 模式**：ECB 模式不提供语义安全性，相同明文块会产生相同密文块
2. **使用随机 IV**：CBC、OFB、CFB 模式应使用随机生成的初始化向量
3. **密钥管理**：妥善保管加密密钥，不要硬编码在代码中
4. **推荐使用 CBC 模式**：对于大多数应用场景，CBC 模式提供较好的安全性

## 模块依赖关系

```
┌─────────────────┐
│   ciphermode    │
├─────────────────┤
│  aes  │ buffer  │
├───────┴─────────┤
│   gf   │  util  │
├────────┴────────┤
│      bit        │
└─────────────────┘
```

## 许可证

请参考项目根目录的许可证文件。
