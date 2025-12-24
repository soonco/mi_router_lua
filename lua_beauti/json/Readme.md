# JSON 模块目录

本目录包含 JSON 相关的 Lua 扩展模块，主要用于实现基于 JSON 的网络通信功能。

## 目录结构

```
json/
├── Readme.md          # 本说明文档
├── rpc.lua            # JSON-RPC 客户端模块
└── rpc.lua.md         # rpc.lua 的详细说明文档
```

## 模块概览

| 文件 | 类型 | 说明 |
|------|------|------|
| `rpc.lua` | 代码 | JSON-RPC 客户端实现，支持通过 HTTP 发送 JSON-RPC 请求 |
| `rpc.lua.md` | 文档 | rpc.lua 模块的详细接口说明和使用示例 |

## 模块详情

### rpc.lua - JSON-RPC 客户端

#### 功能描述

实现 JSON-RPC 协议客户端，提供两种远程调用方式：
1. **代理模式** - 创建代理对象，像调用本地方法一样调用远程方法
2. **直接调用模式** - 直接指定 URL 和方法名进行调用

#### 核心接口

| 函数 | 说明 |
|------|------|
| `json.rpc.proxy(url)` | 创建 RPC 代理对象，支持链式调用远程方法 |
| `json.rpc.call(url, method, ...)` | 直接执行 JSON-RPC 远程调用 |

#### 快速示例

```lua
local json = require("json")
require("json.rpc")

-- 代理模式
local proxy = json.rpc.proxy("http://api.example.com/rpc")
local result, err = proxy.getUserInfo(123)

-- 直接调用模式
local result, err = json.rpc.call(
    "http://api.example.com/rpc",
    "getUserInfo",
    123
)
```

#### 依赖模块

- `json` - JSON 编解码
- `socket.http` - HTTP 客户端（来自 LuaSocket）
- `ltn12` - 数据传输库（来自 LuaSocket）

## 技术特点

1. **元表机制** - 使用 Lua 元表实现透明的远程方法调用
2. **JSON-RPC 协议** - 遵循标准 JSON-RPC 请求/响应格式
3. **错误处理** - 支持 HTTP 错误和 RPC 错误的统一处理

## 文档约定

- `.lua` 文件为源代码文件
- `.lua.md` 文件为对应源代码的详细说明文档，包含接口定义、使用示例等
