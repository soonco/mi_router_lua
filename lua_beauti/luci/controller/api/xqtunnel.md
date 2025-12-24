# xqtunnel.lua - 隧道请求API模块

## 概述

`xqtunnel.lua` 是小米路由器的通用隧道请求 API 模块，提供 Base64 编码请求的转发功能。该模块实现了严格的输入过滤机制，防止命令注入攻击。

**模块路径**: `luci.controller.api.xqtunnel`  
**API 基础路径**: `/api/xqtunnel/*`  
**认证方式**: JSON 认证 (`jsonauth`)，需要管理员权限

## 工作原理

1. **请求接收**: 接收 HTTP 请求中的 Base64 编码载荷
2. **安全过滤**: 对输入进行字符过滤，只保留合法的 Base64 字符
3. **命令构建**: 使用配置的隧道工具命令模板构建执行命令
4. **请求转发**: 执行命令并返回结果

## 安全机制

### Base64 字符白名单

模块定义了严格的 Base64 合法字符表，只允许以下字符通过：
- 大写字母: `A-Z`
- 小写字母: `a-z`
- 数字: `0-9`
- 特殊字符: `+`, `/`, `=`, `-`, `_`

任何不在白名单中的字符都会被过滤掉，有效防止命令注入攻击。

## 接口列表

### index()
**功能**: 模块路由注册入口

注册以下 API 端点：
- `/api/xqtunnel/request` - 隧道请求转发

**路由配置**:
```lua
local apiNode = node("api", "xqtunnel")
apiNode.target = firstchild()
apiNode.order = 300
apiNode.sysauth = "admin"
apiNode.sysauth_authenticator = "jsonauth"
```

---

### filterBase64(input)
**功能**: 过滤 Base64 字符串（内部函数）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| input | string | 是 | 输入字符串 |

**返回值**: 
| 类型 | 说明 |
|-----|------|
| string | 过滤后的字符串，只包含合法 Base64 字符 |

**实现逻辑**:
```lua
local function filterBase64(input)
    local result = ""
    for i = 1, #input do
        local char = input:sub(i, i)
        if BASE64_VALID_CHARS[char] ~= nil and BASE64_VALID_CHARS[char] then
            result = result .. char
        end
    end
    return result
end
```

---

### tunnelRequest()
**功能**: 隧道请求处理函数

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payloadB64 | string | 是 | Base64 编码的请求载荷 |

**返回值**: 命令执行结果（原始输出）

**处理流程**:
1. 获取 HTTP 请求中的 `payloadB64` 参数
2. 调用 `filterBase64()` 过滤非法字符
3. 使用 `XQConfigs.TUNNEL_TOOL` 命令模板构建执行命令
4. 执行命令并返回结果

**示例**:
```
请求: POST /api/xqtunnel/request
参数: payloadB64=eyJhY3Rpb24iOiJ0ZXN0In0=
响应: 隧道工具执行结果
```

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `luci.http` | HTTP 请求处理 |
| `luci.util` | 工具函数（命令执行）|
| `xiaoqiang.common.XQConfigs` | 配置常量（TUNNEL_TOOL 命令模板）|

## 被引用情况

该模块作为通用隧道 API，可能被以下场景使用：
- 需要通过路由器转发请求的应用
- 内部服务间通信
- 需要 Base64 编码传输的场景

## 关键代码说明

### 安全过滤实现

```lua
local BASE64_VALID_CHARS = {
    A = true, B = true, C = true, -- ... 省略其他字母
    ["0"] = true, ["1"] = true, -- ... 省略其他数字
    ["-"] = true, ["_"] = true, ["+"] = true, ["/"] = true, ["="] = true
}

local function filterBase64(input)
    local result = ""
    for i = 1, #input do
        local char = input:sub(i, i)
        if BASE64_VALID_CHARS[char] ~= nil and BASE64_VALID_CHARS[char] then
            result = result .. char
        end
    end
    return result
end
```

使用字符白名单而非黑名单的方式，确保只有预期的字符能够通过，这是一种更安全的输入验证策略。

### 命令执行

```lua
local command = XQConfigs.TUNNEL_TOOL % filteredPayload
http.write(LuciUtil.exec(command))
```

使用 Lua 的字符串格式化操作符 `%` 将过滤后的载荷插入命令模板，然后通过 `luci.util.exec()` 执行命令。
