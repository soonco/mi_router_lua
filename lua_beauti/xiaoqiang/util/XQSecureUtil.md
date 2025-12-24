# XQSecureUtil.lua - 安全工具模块

## 概述

XQSecureUtil 是小米路由器的核心安全工具模块，提供全面的安全验证和密码管理功能。包括 XSS 过滤、密码加密验证、Nonce 管理、命令安全检查、密码强度检测、Passport 登录集成等功能。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                      安全验证架构                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    输入安全层                            │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │    │
│  │  │  XSS过滤    │  │ 命令注入检查│  │ 黑客字符检查│     │    │
│  │  │ xssCheck()  │  │cmdSafeCheck │  │ hackCheck() │     │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │    │
│  └─────────────────────────────────────────────────────────┘    │
│                              │                                   │
│                              ▼                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    认证验证层                            │    │
│  │  ┌─────────────────────────────────────────────────┐   │    │
│  │  │              密码验证流程                        │   │    │
│  │  │  password + SALT ──► SHA256/SHA1 ──► 比对存储值 │   │    │
│  │  └─────────────────────────────────────────────────┘   │    │
│  │  ┌─────────────────────────────────────────────────┐   │    │
│  │  │              Nonce 验证流程                      │   │    │
│  │  │  type_deviceId_mark_xxx ──► 解析验证 ──► 更新   │   │    │
│  │  └─────────────────────────────────────────────────┘   │    │
│  └─────────────────────────────────────────────────────────┘    │
│                              │                                   │
│                              ▼                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    加密存储层                            │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │    │
│  │  │ AES-128-CBC │  │  SHA256     │  │  SHA1       │     │    │
│  │  │ 密文解密    │  │ 新加密模式  │  │ 旧加密模式  │     │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  密码强度评估:                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  评分项目:                                               │    │
│  │  • 长度 > 6: +0.5 * sqrt((len-6)/2)                     │    │
│  │  • 包含数字: +1                                          │    │
│  │  • 包含小写: +1                                          │    │
│  │  • 包含大写: +1                                          │    │
│  │  • 包含特殊: +1                                          │    │
│  │  ────────────────────────────────────────────────────   │    │
│  │  score < 2: 弱(1)  |  score < 3: 中(2)  |  else: 强(3)  │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### XSS 和输入安全

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `xssCheck(input)` | input: string | string/nil | XSS 安全检查，返回过滤后字符串 |
| `cmdSafeCheck(cmd)` | cmd: string | string/false | 命令安全检查，过滤危险关键词 |
| `hackCheck(key, value)` | key: string, value: string | string/nil | 黑客攻击检查 |
| `hackCharsCheck(input)` | input: string | string | 黑客字符检查 |
| `parseCmdline(input)` | input: string | string | 解析命令行参数（转义特殊字符） |

### 密码管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `savePlaintextPwd(account, password)` | account, password: string | boolean | 保存明文密码（哈希后存储） |
| `savePlaintextPwdEx(account, password)` | account, password: string | boolean | 保存密码扩展版（同时保存新旧格式） |
| `saveCiphertextPwd(account, ciphertext)` | account, ciphertext: string | boolean | 保存密文密码 |
| `saveCiphertextLegacyPwd(account, ciphertext)` | account, ciphertext: string | boolean | 保存密文遗留密码 |
| `checkPlaintextPwd(account, password)` | account, password: string | boolean | 检查明文密码 |
| `checkUser(account, nonce, hash)` | account, nonce, hash: string | boolean | 检查用户认证 |
| `checkStrong(password)` | password: string | number(1-3) | 检查密码强度 |

### Nonce 管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `prepare()` | 无 | 无 | 准备 Nonce 存储目录 |
| `sane(path)` | path: string (可选) | boolean | 检查路径安全性 |
| `readNonce(nonceId)` | nonceId: string | table/nil | 读取 Nonce 数据 |
| `writeNonce(nonceId, data)` | nonceId: string, data: table | 无 | 写入 Nonce 数据 |
| `checkNonce(nonceStr, macAddr)` | nonceStr, macAddr: string | boolean | 检查 Nonce 有效性 |
| `checkid(id)` | id: string | boolean | 检查 ID 格式（十六进制） |

### 密文处理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `ciphertextFormat(ciphertext)` | ciphertext: string | string | 密文格式化（按64字符分割） |
| `decCiphertext(account, ciphertext, section)` | account, ciphertext: string, section: string (可选) | string/nil | 解密密文 |

### 重定向密钥

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `generateRedirectKey(redirectType)` | redirectType: string | string | 生成重定向密钥 |
| `checkRedirectKey(key)` | key: string | string/false | 检查重定向密钥有效性 |

### Passport 集成

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `passportLoginUrl()` | 无 | string | 获取 Passport 登录 URL |
| `passportLogoutUrl()` | 无 | string | 获取 Passport 登出 URL |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `luci.util` | Luci 工具函数 |
| `luci.sys` | 系统函数 |
| `nixio` | POSIX I/O 操作 |
| `nixio.fs` | 文件系统操作 |
| `bit` | 位操作 |
| `xssFilter` | XSS 过滤库 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.XQPreference` | 偏好设置 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `luci.sauth` | 会话认证 |
| `luci.http.protocol` | HTTP 协议工具 |

## 被引用情况

- `luci/dispatcher.lua` - 请求分发器（认证验证）
- `luci/controller/api/xqsystem.lua` - 系统 API（密码管理）
- `xiaoqiang/util/XQSysUtil.lua` - 系统工具（密码设置）
- `luci/sauth.lua` - 会话认证

## 关键代码说明

### 密码加盐哈希

```lua
local PASSWORD_SALT = "a2ffa5c9be07488bbb04a3a47d3c5f6a"

function savePlaintextPwd(account, password)
    local encryptMode = XQSysUtil.getEncryptMode()
    local hashedPwd
    
    if encryptMode == 1 then
        -- 新加密模式使用 SHA256
        hashedPwd = XQCryptoUtil.sha256(password .. PASSWORD_SALT)
    else
        -- 旧加密模式使用 SHA1
        hashedPwd = XQCryptoUtil.sha1(password .. PASSWORD_SALT)
    end
    
    XQPreference.set(account, hashedPwd, "account")
end
```

### 危险关键词过滤

```lua
KEY_WORDS = {"'", ";", "nvram", "dropbear", "bdata"}

local function _keyWordsFilter(input)
    for _, keyword in ipairs(KEY_WORDS) do
        if input:match(keyword) then
            XQLog.log(6, "Keyword Warning:" .. input)
            return false
        end
    end
    return input
end
```

### 黑客字符检查

```lua
local HACK_CHARS_PATTERN = "[`;|$&\n]"

-- 安全参数白名单（不检查这些参数）
local SAFE_PARAMS = {
    name = 1, password = 1, ssid = 1, username = 1, ...
}

function hackCheck(key, value)
    if SAFE_PARAMS[key] then
        return value  -- 白名单参数直接返回
    end
    
    if string.find(value, HACK_CHARS_PATTERN) then
        XQLog.log(3, "hackCheck match key:" .. key .. " val:" .. value)
        return nil
    end
    
    return value
end
```

### Nonce 验证格式

```lua
-- Nonce 格式: type_deviceId_mark_xxx
-- type: 类型(0-4)
-- deviceId: 设备标识
-- mark: 时间戳/序号（必须递增）

function checkNonce(nonceStr, macAddr)
    local parts = LuciUtil.split(nonceStr, "_")
    -- parts[1] = type
    -- parts[2] = deviceId
    -- parts[3] = mark
    -- parts[4] = xxx
    
    -- 验证 mark 必须大于存储的值（防重放攻击）
    if mark > storedMark then
        nonceData.mark = tostring(mark)
        writeNonce(nonceId, nonceData)
        return true
    end
end
```

### 命令行参数转义

```lua
function parseCmdline(input)
    local result = input:gsub("\\", "\\\\")  -- 反斜杠
    result = result:gsub("`", "\\`")          -- 反引号
    result = result:gsub("\"", "\\\"")        -- 双引号
    result = result:gsub("%$", "\\$")         -- 美元符
    result = result:gsub("%&", "\\&")         -- &符号
    result = result:gsub("%|", "\\|")         -- 管道符
    result = result:gsub("%;", "\\;")         -- 分号
    return result
end
```
