# smtp.lua - SMTP 邮件发送模块

## 工作原理

LuaSocket SMTP 客户端模块，实现 SMTP 邮件发送协议。

核心特性：
1. **认证方式** - 支持 PLAIN 和 LOGIN 认证
2. **多收件人** - 支持多个 RCPT TO
3. **消息构建** - 提供消息源生成器
4. **扩展支持** - 解析 EHLO 响应获取服务器能力

SMTP 会话流程：
```
1. connect()   - 建立 TCP 连接
2. greet()     - EHLO 握手，获取服务器扩展
3. auth()      - 认证（如果需要）
4. mail()      - MAIL FROM 指定发件人
5. rcpt()      - RCPT TO 指定收件人（可多次）
6. data()      - DATA 发送邮件内容
7. quit()      - QUIT 结束会话
```

认证机制：
- **LOGIN**：分两步发送 Base64 编码的用户名和密码
- **PLAIN**：一次发送 `\0user\0password` 的 Base64 编码

## 接口

### 模块常量

| 常量 | 默认值 | 说明 |
|------|--------|------|
| `smtp.TIMEOUT` | 60 | 超时时间（秒） |
| `smtp.PORT` | 25 | 默认端口 |
| `smtp.DOMAIN` | 本机主机名 | EHLO 域名 |
| `smtp.SERVER` | "localhost" | 默认服务器 |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `smtp.send(message_t)` | message_t: 消息表 | 1, 或 nil + 错误 | 发送邮件 |
| `smtp.message(message_source)` | message_source: 消息源表 | ltn12 source | 创建消息源 |

### 消息表结构（send 参数）

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `from` | string | 是 | 发件人地址 |
| `rcpt` | string/table | 是 | 收件人地址（单个或多个） |
| `source` | function | 是 | ltn12 消息数据源 |
| `server` | string | 否 | SMTP 服务器 |
| `port` | number | 否 | 端口号 |
| `domain` | string | 否 | EHLO 域名 |
| `user` | string | 否 | 认证用户名 |
| `password` | string | 否 | 认证密码 |
| `step` | function | 否 | ltn12 泵步进函数 |

### 消息源表结构（message 参数）

| 字段 | 类型 | 说明 |
|------|------|------|
| `headers` | table | 邮件头部 |
| `body` | string/function/table | 邮件正文 |

### SMTP 连接对象方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `conn:greet(domain)` | domain: EHLO 域名 | 扩展字符串, 或 nil + 错误 | EHLO 握手 |
| `conn:mail(from)` | from: 发件人 | 1, 或 nil + 错误 | MAIL FROM |
| `conn:rcpt(to)` | to: 收件人 | 1, 或 nil + 错误 | RCPT TO |
| `conn:data(src, step)` | src: 数据源<br>step: 步进函数 | 1, 或 nil + 错误 | 发送邮件数据 |
| `conn:auth(user, password, ext)` | user, password, ext | 1, 或 nil + 错误 | 自动选择认证方式 |
| `conn:login(user, password)` | user, password | 1, 或 nil + 错误 | LOGIN 认证 |
| `conn:plain(user, password)` | user, password | 1, 或 nil + 错误 | PLAIN 认证 |
| `conn:quit()` | 无 | 1, 或 nil + 错误 | QUIT 命令 |
| `conn:close()` | 无 | 1 | 关闭连接 |

### 使用示例

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

-- 使用消息构建器
local msg_source = smtp.message({
    headers = {
        ["content-type"] = "text/plain; charset=utf-8",
        from = "Sender <sender@example.com>",
        to = "Recipient <recipient@example.com>",
        subject = "=?UTF-8?B?5rWL6K+V?="
    },
    body = "邮件正文内容"
})
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | TCP 连接、DNS 查询 |
| `socket.tp` | 文本协议通信 |
| `socket.headers` | 头部规范化 |
| `ltn12` | 数据传输 |
| `mime` | Base64 编码 |
