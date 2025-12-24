# luci/sauth.lua

## 概述

LuCI 会话认证模块，提供基于文件系统的会话管理功能。支持会话创建、读取、写入、删除，以及会话过期检测与清理。

## 工作原理

1. **会话存储**: 会话数据序列化后存储在文件系统中
2. **会话 ID**: 使用十六进制字符串作为会话标识符
3. **过期检测**: 基于系统运行时间（uptime）检测会话过期
4. **安全验证**: 验证会话路径所有权和会话 ID 格式
5. **原子写入**: 使用临时文件和重命名确保写入原子性

## 接口/函数列表

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `prepare()` | 无 | void | 准备会话目录 |
| `write(sessionId, sessionData)` | 会话ID、会话数据 | void | 写入会话 |
| `read(sessionId)` | 会话ID | table/nil | 读取会话 |
| `kill(sessionId)` | 会话ID | void | 删除会话 |
| `killall()` | 无 | void | 删除所有会话 |
| `reap()` | 无 | void | 清理过期会话 |
| `sane(path)` | 路径(可选) | boolean | 检查路径安全性 |
| `available(clientIp)` | 客户端IP(可选) | table/nil | 查找可用会话 |

## 模块变量

| 变量 | 类型 | 描述 |
|------|------|------|
| `sessionpath` | string | 会话文件存储路径 |
| `sessiontime` | number | 会话超时时间（秒），默认 3600 |

## 会话数据结构

```lua
{
    user = string,      -- 用户名
    token = string,     -- 会话令牌
    ltype = string,     -- 登录类型
    ip = string,        -- 客户端 IP
    secret = string,    -- 会话密钥
    atime = number      -- 最后访问时间（uptime）
}
```

## 外部依赖

- `luci.util` - 工具函数（get_bytecode）
- `luci.sys` - 系统函数（uptime、uniqueid、process.info）
- `luci.config` - 配置（sauth.sessionpath、sauth.sessiontime）
- `nixio` - 文件重命名
- `nixio.fs` - 文件系统操作
- `xiaoqiang.XQLog` - 日志记录

## 被引用情况

- `luci/dispatcher.lua` - 会话验证和创建

## 关键代码说明

### 会话 ID 验证
```lua
local function isInvalidSessionId(sessionId)
    -- 只允许十六进制字符
    return sessionId and not sessionId:match("^[a-fA-F0-9]+$")
end
```

### 原子写入
```lua
local function writeSessionFile(sessionId, data)
    local uniqueId = luci.sys.uniqueid(16)
    local tempPath = sessionpath .. "/" .. uniqueId
    local finalPath = sessionpath .. "/" .. sessionId
    
    -- 先写入临时文件
    local file = nixioFs.open(tempPath, "w", 600)
    file:writeall(data)
    file:close()
    
    -- 原子重命名
    nixio.rename(tempPath, finalPath)
end
```

### 会话过期检测
```lua
function read(sessionId)
    -- ...
    if sessionData.atime then
        local expireTime = sessionData.atime + sessiontime
        local currentTime = luci.sys.uptime()
        if expireTime < currentTime then
            kill(sessionId)
            return nil
        end
    end
    -- 更新访问时间
    write(sessionId, sessionData)
    return sessionData
end
```

### 路径安全检查
```lua
function sane(path)
    -- 检查文件所有者是否为当前进程用户
    local processUid = luci.sys.process.info("uid")
    local fileUid = nixioFs.stat(path or sessionpath, "uid")
    return processUid == fileUid
end
```

### 会话数据序列化
```lua
-- 使用 Lua 字节码存储会话数据
writeSessionFile(sessionId, luci.util.get_bytecode(sessionData))

-- 读取时加载字节码
local rawData = readSessionFile(sessionId)
local loader = loadstring(rawData)
setfenv(loader, {})  -- 安全环境
local sessionData = loader()
```

## 安全注意事项

1. **会话 ID 格式**: 严格验证只允许十六进制字符
2. **路径安全**: 验证会话目录所有权
3. **沙箱执行**: 加载会话数据时使用空环境
4. **权限设置**: 会话文件权限设为 600
5. **日志记录**: 安全异常记录到日志
