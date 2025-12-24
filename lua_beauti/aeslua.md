# aeslua.lua - AES 加密库模块

## 工作原理

本模块提供 AES（Advanced Encryption Standard）对称加密和解密功能，是一个纯 Lua 实现的 AES 加密库。

支持的配置：
- **密钥长度**: AES-128 (16字节)、AES-192 (24字节)、AES-256 (32字节)
- **加密模式**: ECB、CBC、OFB、CFB

加密流程：
1. 将密码字符串转换为 AES 密钥（使用 CBC 模式进行密钥派生）
2. 对数据进行 PKCS7 填充
3. 根据选择的模式调用相应的加密函数
4. 返回加密后的数据

## 接口

### 常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `aeslua.AES128` | 16 | AES-128 密钥长度 |
| `aeslua.AES192` | 24 | AES-192 密钥长度 |
| `aeslua.AES256` | 32 | AES-256 密钥长度 |
| `aeslua.ECBMODE` | 1 | ECB 模式（不推荐） |
| `aeslua.CBCMODE` | 2 | CBC 模式（推荐） |
| `aeslua.OFBMODE` | 3 | OFB 模式 |
| `aeslua.CFBMODE` | 4 | CFB 模式 |

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `aeslua.encrypt(password, data, keyLength, mode)` | password: 加密密码<br>data: 要加密的数据<br>keyLength: 密钥长度（可选）<br>mode: 加密模式（可选） | 加密后的数据 | AES 加密 |
| `aeslua.decrypt(password, data, keyLength, mode)` | password: 解密密码<br>data: 要解密的数据<br>keyLength: 密钥长度（可选）<br>mode: 加密模式（可选） | 解密后的数据或 nil | AES 解密 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `aeslua.ciphermode` | 加密模式实现（ECB/CBC/OFB/CFB） |
| `aeslua.util` | 工具函数（填充/去填充等） |
