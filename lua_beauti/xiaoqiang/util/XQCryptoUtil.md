# XQCryptoUtil.lua - 加密工具模块

## 概述

`XQCryptoUtil` 模块提供各种加密和编码功能，包括 Base64 编码/解码、MD5/SHA1/SHA256 哈希计算、二进制与十六进制转换等。该模块是路由器安全功能的基础组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                      加密工具功能                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    编码/解码                          │  │
│  │  • binaryBase64Enc(): 二进制 → Base64                │  │
│  │  • binaryBase64Dec(): Base64 → 二进制                │  │
│  │  • binToHex(): 二进制 → 十六进制                     │  │
│  │  • hextobin(): 十六进制 → 二进制                     │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    哈希计算                           │  │
│  │  • md5Str(): 字符串 MD5 (32位十六进制)               │  │
│  │  • md5File(): 文件 MD5                               │  │
│  │  • sha1(): SHA1 哈希 (40位十六进制)                  │  │
│  │  • sha256(): SHA256 哈希 (64位十六进制)              │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    组合函数                           │  │
│  │  • md5Base64Str(): MD5 + Base64                      │  │
│  │  • hash4SHA1(): SHA1 + Base64                        │  │
│  │  • sha256Binary(): SHA256 二进制结果                 │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### Base64 编码/解码

#### binaryBase64Enc(data)

二进制数据 Base64 编码。

**参数:** data - 二进制数据

**返回值:** string - Base64 编码字符串

---

#### binaryBase64Dec(data)

Base64 解码。

**参数:** data - Base64 编码字符串

**返回值:** string - 解码后的二进制数据

---

### 哈希计算

#### md5Str(str)

计算字符串的 MD5 哈希。

**返回值:** string - 32 位十六进制 MD5 值

---

#### md5File(filepath)

计算文件的 MD5 哈希。

**返回值:** string - 32 位十六进制 MD5 值

---

#### sha1(str)

计算字符串的 SHA1 哈希。

**返回值:** string - 40 位十六进制 SHA1 值

---

#### sha256(str)

计算字符串的 SHA256 哈希。

**返回值:** string - 64 位十六进制 SHA256 值

---

### 二进制/十六进制转换

#### binToHex(bin)

二进制数据转十六进制字符串。

---

#### hextobin(hex)

十六进制字符串转二进制数据。

---

### 组合函数

#### md5Base64Str(str)

计算字符串 MD5 的 Base64 编码。

---

#### hash4SHA1(str)

计算 SHA1 的 Base64 编码。

---

#### sha256Binary(str) / sha256_binary(str)

计算 SHA256 并返回二进制结果。

---

#### sha1Binary(str)

计算 SHA1 并返回二进制结果。

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| sha1 | SHA1 库 |
| mime | MIME 编码库 |
| luci.util | LuCI 工具函数 |
| /usr/bin/md5sum | MD5 计算命令 |
| openssl | SHA256 计算命令 |

## 被引用情况

- 固件校验 (`XQDownloadUtil`)
- 认证签名
- 数据完整性校验
- 网络拓扑模块 (`XQTopology`)
- WiFi 分享模块 (`XQWifiShare`)

## 关键代码说明

### 纯 Lua Base64 实现

```lua
local BASE64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- 编码：每3字节转4个Base64字符
-- 解码：每4个Base64字符转3字节
```

模块实现了纯 Lua 的 Base64 编解码，不依赖外部库。

### 命令行哈希计算

```lua
-- MD5
local cmd = "/bin/echo -n \"%s\"|/usr/bin/md5sum|/usr/bin/cut -d' ' -f1"

-- SHA256
local cmd = "/bin/echo -n \"%s\"|openssl dgst -r -sha256|/usr/bin/cut -d' ' -f1"
```

MD5 和 SHA256 通过调用系统命令实现，SHA1 使用 Lua 库。

### 安全注意事项

使用 `XQFunction._cmdformat` 对输入进行转义，防止命令注入攻击。
