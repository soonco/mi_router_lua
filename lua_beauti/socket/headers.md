# headers.lua - HTTP 头部规范化模块

## 工作原理

LuaSocket HTTP Headers 规范化模块，提供 HTTP 头部字段名称的规范化映射。将小写的头部字段名转换为标准的驼峰式命名（Canonical Form）。

用途：
1. HTTP 请求/响应头部的格式化输出
2. 确保头部字段名符合 HTTP 规范
3. 统一内部使用小写存储，输出时转换为规范格式

## 接口

### 数据结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `headers.canonic` | table | 小写到规范格式的映射表 |

### 映射示例

| 小写键 | 规范值 |
|--------|--------|
| `"accept"` | `"Accept"` |
| `"content-type"` | `"Content-Type"` |
| `"content-length"` | `"Content-Length"` |
| `"user-agent"` | `"User-Agent"` |
| `"cache-control"` | `"Cache-Control"` |
| `"transfer-encoding"` | `"Transfer-Encoding"` |
| `"www-authenticate"` | `"WWW-Authenticate"` |
| `"content-id"` | `"Content-ID"` |
| `"message-id"` | `"Message-ID"` |
| `"mime-version"` | `"MIME-Version"` |
| `"etag"` | `"ETag"` |

### 支持的头部类别

| 类别 | 头部字段 |
|------|----------|
| 通用头部 | Cache-Control, Connection, Date, Pragma, Trailer, Transfer-Encoding, Upgrade, Via, Warning |
| 请求头部 | Accept, Accept-*, Authorization, Cookie, Expect, From, Host, If-*, Max-Forwards, Proxy-Authorization, Range, Referer, TE, User-Agent |
| 响应头部 | Accept-Ranges, Age, ETag, Location, Proxy-Authenticate, Retry-After, Server, Vary, WWW-Authenticate |
| 实体头部 | Allow, Content-*, Expires, Last-Modified |
| 邮件头部 | Bcc, Cc, From, In-Reply-To, Message-ID, MIME-Version, Reply-To, Sender, Subject, To, X-Mailer |
| DSN 头部 | Arrival-Date, Diagnostic-Code, DSN-Gateway, Final-*, Original-*, Received-From-MTA, Remote-MTA, Reporting-MTA, Status |

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | 注册到 socket 命名空间 |
