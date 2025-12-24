# SSL 模块目录

## 目录概述

本目录包含 SSL/TLS 安全通信相关的 Lua 模块，提供基于加密协议的网络请求功能。

## 目录结构

```
ssl/
├── Readme.md           # 本说明文档
├── https.lua           # HTTPS 请求模块
└── https.lua.md        # HTTPS 模块说明文档
```

## 模块列表

### https.lua - LuaSec HTTPS 模块

| 属性 | 说明 |
|------|------|
| **版本** | 0.9 |
| **版权** | LuaSec 0.9 - Copyright (C) 2009-2019 PUC-Rio |
| **功能** | 提供基于 SSL/TLS 的 HTTPS 请求功能 |

#### 功能特点

- 基于 LuaSocket 和 LuaSec 实现安全 HTTP 通信
- 默认禁用不安全协议（SSLv2、SSLv3、TLSv1）
- 支持 GET 和 POST 请求方法
- 使用 LTN12 数据过滤器处理请求/响应数据流
- 支持简单 URL 字符串和完整配置表两种请求方式

#### 主要接口

| 函数 | 说明 |
|------|------|
| `https.tcp(userConfig)` | 创建 TCP 连接配置，合并默认 SSL 配置 |
| `https.request(requestUrlOrConfig, requestBody)` | 发起 HTTPS 请求 |

#### 常量配置

| 常量 | 默认值 | 说明 |
|------|--------|------|
| `PORT` | 443 | HTTPS 默认端口 |
| `TIMEOUT` | 60 | 默认超时时间（秒） |

#### 使用示例

```lua
local https = require("https")

-- 简单 GET 请求
local body, code, headers = https.request("https://example.com/api")

-- 简单 POST 请求
local body, code, headers = https.request("https://example.com/api", "key=value")

-- 完整配置请求
local body, code, headers = https.request({
    url = "https://example.com/api",
    method = "POST",
    headers = {
        ["content-type"] = "application/json"
    },
    source = ltn12.source.string('{"data":"value"}')
})
```

#### 安全说明

默认 SSL 配置禁用了以下不安全协议：
- SSLv2（已知存在严重安全漏洞）
- SSLv3（POODLE 攻击漏洞）
- TLSv1（建议使用 TLSv1.2 或更高版本）

> **注意**：默认配置中 `verify = "none"` 不验证服务器证书，生产环境建议改为 `"peer"` 以启用证书验证。

## 依赖关系

本目录模块依赖以下外部库：

| 依赖库 | 用途 |
|--------|------|
| `socket` | LuaSocket 基础网络库 |
| `ssl` | LuaSec SSL/TLS 加密库 |
| `ltn12` | LTN12 数据过滤器 |
| `socket.http` | HTTP 协议实现 |
| `socket.url` | URL 解析工具 |

## 文件说明

- `.lua` 文件：Lua 源代码文件
- `.lua.md` 文件：对应 Lua 文件的详细说明文档
