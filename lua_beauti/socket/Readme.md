# LuaSocket 网络通信模块库

LuaSocket 是一个功能完整的 Lua 网络通信库，提供 TCP/UDP 套接字操作以及常用网络协议的客户端实现。

## 目录结构

```
socket/
├── core.so          # LuaSocket 核心 C 模块（TCP/UDP 套接字）
├── unix.so          # Unix 域套接字支持
├── tp.lua           # 文本协议通信基础模块
├── url.lua          # URL 解析与构建
├── headers.lua      # HTTP 头部规范化
├── http.lua         # HTTP 客户端
├── ftp.lua          # FTP 客户端
├── smtp.lua         # SMTP 邮件发送
└── Readme.md        # 本文档
```

## 模块概览

| 模块 | 文件 | 功能描述 |
|------|------|----------|
| **核心模块** | `core.so` | TCP/UDP 套接字操作、DNS 解析 |
| **Unix 套接字** | `unix.so` | Unix 域套接字支持 |
| **文本协议** | `tp.lua` | 基于文本的协议通信基础设施 |
| **URL 处理** | `url.lua` | URL 解析、构建、编码解码 |
| **HTTP 头部** | `headers.lua` | HTTP 头部字段名规范化 |
| **HTTP 客户端** | `http.lua` | HTTP/1.1 客户端实现 |
| **FTP 客户端** | `ftp.lua` | FTP 文件传输协议客户端 |
| **SMTP 客户端** | `smtp.lua` | SMTP 邮件发送协议客户端 |

## 模块依赖关系

```
                    ┌─────────┐
                    │ core.so │
                    └────┬────┘
                         │
              ┌──────────┼──────────┐
              │          │          │
         ┌────▼────┐ ┌───▼───┐ ┌────▼────┐
         │ tp.lua  │ │url.lua│ │headers  │
         └────┬────┘ └───┬───┘ └────┬────┘
              │          │          │
    ┌─────────┼──────────┼──────────┤
    │         │          │          │
┌───▼───┐ ┌───▼───┐  ┌───▼───┐  ┌───▼───┐
│ftp.lua│ │smtp   │  │http   │  │  ...  │
└───────┘ └───────┘  └───────┘  └───────┘
```

## 各模块详细说明

### 1. tp.lua - 文本协议通信模块

提供基于文本的网络协议支持，是 SMTP、FTP 等协议的底层通信基础。

**核心功能：**
- 连接管理（建立/关闭 TCP 连接）
- 命令发送（USER、PASS、QUIT 等）
- 响应解析（支持多行响应，提取状态码）
- 状态码检查（精确匹配、模式匹配、回调函数）
- 数据传输（ltn12 过滤器链）

**主要接口：**
```lua
-- 建立连接
local conn = tp.connect(host, port, timeout)

-- 发送命令并检查响应
conn:command("USER", "username")
conn:check("2..")  -- 期望 2xx 响应

-- 关闭连接
conn:close()
```

### 2. url.lua - URL 解析模块

完整的 URL 处理功能，符合 RFC 3986 规范。

**核心功能：**
- URL 编码/解码（百分号编码）
- URL 解析（分解为组件）
- URL 构建（从组件表构建）
- 相对 URL 解析
- 路径规范化（处理 `.` 和 `..`）

**主要接口：**
```lua
-- 解析 URL
local parsed = url.parse("http://user:pass@example.com:8080/path?query#frag")
-- parsed.scheme = "http"
-- parsed.host = "example.com"
-- parsed.port = "8080"

-- 构建 URL
local url_string = url.build(parsed)

-- 相对 URL 转绝对
local abs = url.absolute("http://example.com/a/b/c", "../d")
-- 结果: "http://example.com/a/d"

-- URL 编码
local encoded = url.escape("hello world")  -- "hello%20world"
```

### 3. headers.lua - HTTP 头部规范化模块

提供 HTTP 头部字段名称的规范化映射，将小写头部字段名转换为标准驼峰式命名。

**支持的头部类别：**
- 通用头部：Cache-Control, Connection, Date, Transfer-Encoding 等
- 请求头部：Accept, Authorization, Cookie, Host, User-Agent 等
- 响应头部：ETag, Location, Server, WWW-Authenticate 等
- 实体头部：Content-Type, Content-Length, Expires 等
- 邮件头部：From, To, Subject, MIME-Version 等

### 4. http.lua - HTTP 客户端模块

实现 HTTP/1.1 协议的客户端功能。

**核心特性：**
- 请求方法：GET、POST、HEAD 等
- 分块传输：支持 Chunked Transfer-Encoding
- 代理支持：HTTP 代理服务器
- 重定向：自动跟随 301/302/303/307（最多 5 次）

**主要接口：**
```lua
-- 简单 GET 请求
local body, code, headers = http.request("http://example.com/")

-- POST 请求
local body, code = http.request("http://example.com/api", "data=value")

-- 高级请求
local response = {}
http.request({
    url = "http://example.com/api",
    method = "POST",
    headers = { ["Content-Type"] = "application/json" },
    source = ltn12.source.string('{"key":"value"}'),
    sink = ltn12.sink.table(response)
})

-- 设置代理
http.setproxy("http://proxy.example.com:8080")
```

**默认配置：**
| 常量 | 默认值 | 说明 |
|------|--------|------|
| `http.TIMEOUT` | 60 | 请求超时（秒） |
| `http.PORT` | 80 | 默认端口 |

### 5. ftp.lua - FTP 客户端模块

实现 FTP 文件传输协议。

**核心特性：**
- 传输模式：主动模式（PORT）和被动模式（PASV，默认）
- 文件操作：上传（STOR）和下载（RETR）
- 目录操作：列表（NLST）、切换目录（CWD）、获取当前目录（PWD）
- 传输类型：ASCII（a）和二进制（i）
- 认证：用户名/密码认证

**主要接口：**
```lua
-- 简单下载
local content = ftp.get("ftp://user:pass@ftp.example.com/path/file.txt")

-- 简单上传
ftp.put("ftp://user:pass@ftp.example.com/path/file.txt", "file content")

-- 高级下载
local body = {}
ftp.command({
    host = "ftp.example.com",
    user = "username",
    password = "password",
    command = "RETR",
    argument = "/path/to/file",
    type = "i",  -- 二进制模式
    sink = ltn12.sink.table(body)
})

-- 目录列表
local listing = {}
ftp.command({
    host = "ftp.example.com",
    command = "NLST",
    argument = "/path/",
    sink = ltn12.sink.table(listing)
})
```

**默认配置：**
| 常量 | 默认值 | 说明 |
|------|--------|------|
| `ftp.TIMEOUT` | 60 | 超时时间（秒） |
| `ftp.PORT` | 21 | 默认端口 |
| `ftp.USER` | "ftp" | 默认用户名 |
| `ftp.PASSWORD` | "anonymous@anonymous.org" | 默认密码 |

### 6. smtp.lua - SMTP 邮件发送模块

实现 SMTP 邮件发送协议。

**核心特性：**
- 认证方式：PLAIN 和 LOGIN
- 多收件人：支持多个 RCPT TO
- 消息构建：提供消息源生成器
- 扩展支持：解析 EHLO 响应获取服务器能力

**主要接口：**
```lua
-- 简单发送
smtp.send({
    from = "sender@example.com",
    rcpt = "recipient@example.com",
    source = ltn12.source.string("Subject: Test\r\n\r\nHello!"),
    server = "smtp.example.com"
})

-- 带认证的发送
smtp.send({
    from = "sender@example.com",
    rcpt = { "user1@example.com", "user2@example.com" },
    source = smtp.message({
        headers = {
            from = "Sender <sender@example.com>",
            to = "Recipient <recipient@example.com>",
            subject = "Test Email"
        },
        body = "This is the email body."
    }),
    server = "smtp.example.com",
    port = 587,
    user = "username",
    password = "password"
})
```

**默认配置：**
| 常量 | 默认值 | 说明 |
|------|--------|------|
| `smtp.TIMEOUT` | 60 | 超时时间（秒） |
| `smtp.PORT` | 25 | 默认端口 |
| `smtp.SERVER` | "localhost" | 默认服务器 |

## 外部依赖

所有模块依赖以下外部库：

| 依赖 | 用途 |
|------|------|
| `ltn12` | 数据源/接收器传输机制 |
| `mime` | Base64 编码、MIME 处理 |

## 使用示例

### HTTP 下载文件
```lua
local http = require("socket.http")
local ltn12 = require("ltn12")

local file = io.open("output.html", "w")
http.request({
    url = "http://example.com/",
    sink = ltn12.sink.file(file)
})
```

### FTP 上传文件
```lua
local ftp = require("socket.ftp")
local ltn12 = require("ltn12")

ftp.command({
    host = "ftp.example.com",
    user = "username",
    password = "password",
    command = "STOR",
    argument = "/remote/path/file.txt",
    source = ltn12.source.file(io.open("local.txt", "r"))
})
```

### 发送邮件
```lua
local smtp = require("socket.smtp")

smtp.send({
    from = "me@example.com",
    rcpt = "you@example.com",
    source = smtp.message({
        headers = {
            from = "Me <me@example.com>",
            to = "You <you@example.com>",
            subject = "Hello"
        },
        body = "This is the message body."
    }),
    server = "smtp.example.com",
    user = "me@example.com",
    password = "secret"
})
```

## 参考资料

- [LuaSocket 官方文档](http://w3.impa.br/~diego/software/luasocket/)
- [RFC 3986 - URI 通用语法](https://tools.ietf.org/html/rfc3986)
- [RFC 2616 - HTTP/1.1](https://tools.ietf.org/html/rfc2616)
- [RFC 959 - FTP](https://tools.ietf.org/html/rfc959)
- [RFC 5321 - SMTP](https://tools.ietf.org/html/rfc5321)
