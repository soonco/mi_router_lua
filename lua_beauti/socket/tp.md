# tp.lua - 文本协议通信模块

## 工作原理

LuaSocket TP (Text Protocol) 模块，提供基于文本的网络协议支持，用于 SMTP、FTP 等协议的底层通信。

核心功能：
1. **连接管理** - 建立和关闭 TCP 连接
2. **命令发送** - 发送协议命令（如 USER、PASS、QUIT 等）
3. **响应解析** - 接收并解析多行响应，提取状态码
4. **状态码检查** - 支持精确匹配、模式匹配和回调函数检查
5. **数据传输** - 使用 ltn12 过滤器链进行数据源传输

响应解析机制：
- 单行响应：`200 OK`
- 多行响应：以 `200-` 开始，以 `200 ` 结束（注意空格）

## 接口

### 模块常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `tp.TIMEOUT` | 60 | 默认超时时间（秒） |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `tp.connect(host, port, timeout, create_func)` | host: 主机地址<br>port: 端口号<br>timeout: 超时时间（可选）<br>create_func: socket 创建函数（可选） | connection 对象, 或 nil + 错误信息 | 建立 TCP 连接 |

### 连接对象方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `conn:check(expected)` | expected: 期望的状态码（字符串/表/函数） | code, reply 或 nil, error | 检查响应状态码 |
| `conn:command(cmd, arg)` | cmd: 命令名<br>arg: 参数（可选） | 发送字节数, 或 nil + 错误 | 发送协议命令 |
| `conn:send(data)` | data: 数据 | 发送字节数 | 发送原始数据 |
| `conn:receive(pattern)` | pattern: 接收模式 | 数据, 或 nil + 错误 | 接收数据 |
| `conn:source(source, step)` | source: ltn12 数据源<br>step: 泵步进函数 | 1 或 nil + 错误 | 传输数据源 |
| `conn:getfd()` | 无 | 文件描述符 | 获取底层文件描述符 |
| `conn:dirty()` | 无 | boolean | 检查是否有未读数据 |
| `conn:getcontrol()` | 无 | socket 对象 | 获取底层控制连接 |
| `conn:close()` | 无 | 1 | 关闭连接 |

### check 方法的 expected 参数

| 类型 | 示例 | 说明 |
|------|------|------|
| 字符串 | `"2.."` | 正则模式匹配状态码 |
| 表 | `{"2..", "3.."}` | 多个模式任一匹配即可 |
| 函数 | `function(code, reply) end` | 自定义检查逻辑 |
| nil | 无 | 返回任意状态码 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | TCP 连接创建 |
| `ltn12` | 数据源/接收器传输 |
| `string` | 字符串处理 |
