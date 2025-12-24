# ftp.lua - FTP 客户端模块

## 工作原理

LuaSocket FTP 客户端模块，实现 FTP 文件传输协议。

核心特性：
1. **传输模式** - 支持主动模式（PORT）和被动模式（PASV，默认）
2. **文件操作** - 上传（STOR）和下载（RETR）
3. **目录操作** - 列表（NLST）、切换目录（CWD）、获取当前目录（PWD）
4. **传输类型** - ASCII（a）和二进制（i）
5. **认证** - 用户名/密码认证

FTP 会话流程：
```
1. connect()  - 建立控制连接
2. greet()    - 接收服务器欢迎消息
3. login()    - USER/PASS 认证
4. type()     - 设置传输类型
5. pasv/port()- 建立数据连接
6. retr/stor()- 传输数据
7. quit()     - 发送 QUIT 命令
8. close()    - 关闭连接
```

被动模式 vs 主动模式：
- **被动模式（PASV）**：客户端连接服务器的数据端口，适合 NAT 环境
- **主动模式（PORT）**：服务器连接客户端的数据端口，需要客户端可达

## 接口

### 模块常量

| 常量 | 默认值 | 说明 |
|------|--------|------|
| `ftp.TIMEOUT` | 60 | 超时时间（秒） |
| `ftp.PORT` | 21 | 默认端口 |
| `ftp.USER` | "ftp" | 默认用户名 |
| `ftp.PASSWORD` | "anonymous@anonymous.org" | 默认密码 |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `ftp.get(url)` | url: FTP URL | 文件内容, 或 nil + 错误 | 下载文件 |
| `ftp.put(url, content)` | url: FTP URL<br>content: 内容/数据源 | 1, 或 nil + 错误 | 上传文件 |
| `ftp.command(request_t)` | request_t: 请求表 | 1, 或 nil + 错误 | 执行 FTP 命令 |

### 请求表结构

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `host` | string | 是 | FTP 服务器地址 |
| `port` | number | 否 | 端口号，默认 21 |
| `user` | string | 否 | 用户名 |
| `password` | string | 否 | 密码 |
| `command` | string | 否 | FTP 命令（RETR/STOR/NLST） |
| `argument` | string | 否 | 命令参数（文件路径） |
| `type` | string | 否 | 传输类型：a=ASCII, i=二进制 |
| `passive` | boolean | 否 | 是否使用被动模式，默认 true |
| `source` | function | 否 | ltn12 数据源（上传用） |
| `sink` | function | 否 | ltn12 接收器（下载用） |
| `step` | function | 否 | ltn12 泵步进函数 |

### FTP 连接对象方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `conn:greet()` | 无 | 1, 或 nil + 错误 | 接收欢迎消息 |
| `conn:login(user, password)` | user, password | 1, 或 nil + 错误 | 登录认证 |
| `conn:pasv()` | 无 | host, port | 进入被动模式 |
| `conn:port(host, port)` | host, port | 1, 或 nil + 错误 | 设置主动模式端口 |
| `conn:type(t)` | t: "a" 或 "i" | 1, 或 nil + 错误 | 设置传输类型 |
| `conn:cwd(path)` | path: 目录路径 | 1, 或 nil + 错误 | 切换目录 |
| `conn:pwd()` | 无 | 当前目录路径 | 获取当前目录 |
| `conn:receive(request_t)` | request_t | 1, 或 nil + 错误 | 接收数据 |
| `conn:send(request_t)` | request_t | 1, 或 nil + 错误 | 发送数据 |
| `conn:quit()` | 无 | 1, 或 nil + 错误 | 发送 QUIT |
| `conn:close()` | 无 | 1 | 关闭连接 |

### 使用示例

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
    type = "i",
    sink = ltn12.sink.table(body)
})

-- 目录列表
ftp.command({
    host = "ftp.example.com",
    command = "NLST",
    argument = "/path/",
    sink = ltn12.sink.table(listing)
})
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | TCP 连接 |
| `socket.tp` | 文本协议通信 |
| `socket.url` | URL 解析 |
| `ltn12` | 数据传输 |
