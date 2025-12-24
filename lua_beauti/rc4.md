# rc4.lua - RC4 流密码加密模块

## 工作原理

本模块实现 RC4（Rivest Cipher 4）对称流加密算法，支持加密和解密操作。

RC4 算法原理：
1. **KSA（Key-Scheduling Algorithm）**: 根据密钥初始化 256 字节的 S 盒
2. **PRGA（Pseudo-Random Generation Algorithm）**: 生成伪随机字节流
3. **加密/解密**: 将明文/密文与伪随机流进行异或

特点：
- 密钥长度: 1-256 字节
- 流密码: 加密和解密使用相同的操作
- 简单高效，但已不再被认为是安全的

## 接口

### 构造函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `rc4.new(key, is_encrypt)` | key: 密钥字符串<br>is_encrypt: 是否为加密模式 | cipher 对象 | 创建 RC4 加密/解密器 |

### cipher 对象方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cipher.encrypt(data)` | data: 明文数据 | 密文数据 | 加密（仅加密模式） |
| `cipher.decrypt(data)` | data: 密文数据 | 明文数据 | 解密（仅解密模式） |

### 使用示例

```lua
local rc4 = require("rc4")

-- 加密
local cipher = rc4.new("secret_key", true)
local encrypted = cipher.encrypt("plaintext")

-- 解密
local decipher = rc4.new("secret_key", false)
local decrypted = decipher.decrypt(encrypted)
```

### 内部函数

| 函数 | 说明 |
|------|------|
| `key_schedule(key)` | 密钥调度，初始化 S 盒 |
| `generate_keystream(state, length)` | 生成伪随机字节流 |
| `crypt(plaintext, state)` | 执行加密/解密操作 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `string` | Lua 字符串库 |
| `bit` | 位运算模块（用于异或操作） |
