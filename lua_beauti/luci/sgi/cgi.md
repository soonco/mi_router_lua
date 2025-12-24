# cgi.lua - CGI 服务器网关接口模块

## 工作原理

LuCI CGI 服务器网关接口模块，作为 Web 服务器和 LuCI 框架之间的桥梁，处理 CGI 请求。

核心功能：
1. **请求处理** - 解析 CGI 环境变量和请求体
2. **协程调度** - 使用协程处理 HTTP 调度器
3. **响应输出** - 按消息类型输出 HTTP 响应
4. **os.execute 修复** - 使用小米路由器的 waitExec 替代

请求处理流程：
```
1. fixOsExecute()     - 修复 os.execute 函数
2. 创建 HTTP Request  - 从环境变量和 stdin 构建请求对象
3. 创建调度器协程     - luci.dispatcher.httpdispatch
4. 协程循环处理       - 处理各种消息类型
5. 输出响应           - 状态码、头部、正文
```

消息类型：
| 类型 | 说明 | 参数 |
|------|------|------|
| 1 | 设置状态码 | arg1=状态码, arg2=状态描述 |
| 2 | 添加响应头 | arg1=头名称, arg2=头值 |
| 3 | 完成头部 | 无 |
| 4 | 写入正文 | arg1=内容 |
| 5 | 关闭输出 | 无 |
| 6 | 零拷贝传输 | arg1=文件句柄, arg2=大小 |

## 接口

### 模块变量

| 变量 | 类型 | 说明 |
|------|------|------|
| `exectime` | number | 脚本开始执行时间（os.clock） |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `run()` | 无 | 无 | CGI 主运行函数 |

### 内部函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `createInputSource(handle, contentLength)` | handle: 输入句柄<br>contentLength: 内容长度 | function | 创建 ltn12 兼容的数据源 |
| `fixOsExecute()` | 无 | 无 | 修复 os.execute 函数 |

### os.execute 修复说明

原始 `os.execute` 被替换为使用 `XQFunction.waitExec` 的版本：

| 状态 | 返回值 |
|------|--------|
| exited | exitCode * 256 |
| stopped | exitCode * 256 + 127 |
| 其他 | exitCode |

### 输入源行为

```lua
local source = createInputSource(io.stdin, contentLength)
-- 每次调用返回最多 BLOCKSIZE 字节
-- 读取完毕后自动关闭句柄并返回 nil
```

### 响应输出流程

```
Status: 200 OK\r\n
Header1: Value1\r\n
Header2: Value2\r\n
\r\n
Response Body Content
```

### 错误处理

协程执行出错时返回 500 错误：
```
Status: 500 Internal Server Error
Content-Type: text/plain

错误信息
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.ltn12` | 数据传输 |
| `nixio.util` | Nixio 工具函数 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统函数（getenv） |
| `luci.dispatcher` | HTTP 调度器 |
| `xiaoqiang.common.XQFunction` | 小米路由器函数（waitExec） |
