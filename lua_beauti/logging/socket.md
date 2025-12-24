# socket.lua - Socket 日志输出模块

## 工作原理

本模块是 LuaLogging 框架的 Socket 输出适配器（Appender），通过 TCP Socket 将日志消息发送到远程服务器。

特点：
- 每条日志消息建立一次 TCP 连接
- 发送后立即关闭连接
- 适合将日志集中发送到日志收集服务器

工作流程：
1. 格式化日志消息
2. 建立 TCP 连接到目标服务器
3. 发送日志消息
4. 关闭连接

## 接口

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `logging.socket(host, port, log_pattern)` | host: 服务器地址<br>port: 端口号<br>log_pattern: 日志格式 | logger 对象 | 创建 Socket 日志器 |

### 使用示例

```lua
local logging = require("logging")
require("logging.socket")

-- 创建 Socket 日志器
local logger = logging.socket(
    "logserver.example.com",  -- 日志服务器地址
    514,                       -- 端口号（syslog 默认端口）
    "%date %level %message\n"  -- 日志格式
)

-- 记录日志
logger:info("应用程序启动")
logger:error("发生错误")
```

### 典型应用场景

| 场景 | 说明 |
|------|------|
| 集中日志收集 | 发送到 Logstash、Fluentd 等 |
| Syslog 服务器 | 发送到远程 syslog |
| 自定义日志服务 | 发送到自建日志服务 |

### 注意事项

- 每条日志都会建立新连接，高频日志可能影响性能
- 网络故障会导致日志丢失
- 建议配合本地日志一起使用

## 外部引用

| 模块 | 说明 |
|------|------|
| `logging` | 日志框架主模块 |
| `socket` | LuaSocket 网络库 |
| `os` | Lua OS 库 |
