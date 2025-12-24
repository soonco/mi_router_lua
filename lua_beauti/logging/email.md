# email.lua - 邮件日志输出模块

## 工作原理

本模块是 LuaLogging 框架的邮件输出适配器（Appender），通过 SMTP 协议发送日志消息到指定邮箱。

适用场景：
- 发送重要告警通知
- 错误日志邮件提醒
- 关键事件通知

工作流程：
1. 格式化日志消息作为邮件正文
2. 处理邮件主题（支持格式化占位符）
3. 构建邮件消息
4. 通过 SMTP 发送

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.email(params)` | params: 配置参数表 | logger 对象或 nil, error | 创建邮件日志器 |

### 配置参数

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `from` | string | 是 | 发件人地址 |
| `rcpt` | string/table | 是 | 收件人地址 |
| `server` | string | 否 | SMTP 服务器地址 |
| `user` | string | 否 | SMTP 用户名 |
| `password` | string | 否 | SMTP 密码 |
| `headers` | table | 否 | 邮件头 |
| `headers.subject` | string | 否 | 邮件主题（支持格式化） |
| `logPattern` | string | 否 | 日志格式模板 |

### 使用示例

```lua
local logging = require("logging")
require("logging.email")

-- 创建邮件日志器
local logger = logging.email({
    from = "alert@example.com",
    rcpt = "admin@example.com",
    server = "smtp.example.com",
    user = "alert@example.com",
    password = "password",
    headers = {
        subject = "[Alert] %level - %message"
    },
    logPattern = "%date %level %message"
})

-- 发送告警邮件
logger:error("系统发生严重错误")
logger:fatal("服务已停止")
```

### 邮件主题格式化

主题支持与日志消息相同的格式化占位符：

| 占位符 | 说明 |
|--------|------|
| `%date` | 日期时间 |
| `%level` | 日志级别 |
| `%message` | 日志消息 |

### 注意事项

- 邮件发送较慢，不适合高频日志
- 建议仅用于 ERROR 和 FATAL 级别
- 需要配置正确的 SMTP 服务器

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| `socket.smtp` | LuaSocket SMTP 模块 |
| `os` | Lua OS 库 |
