# http.lua - HTTP 客户端模块

## 工作原理

LuaSocket HTTP 客户端模块，实现 HTTP/1.1 协议的客户端功能。

核心特性：
1. **请求方法** - 支持 GET、POST、HEAD 等
2. **持久连接** - 默认使用 Connection: close
3. **分块传输** - 支持 Chunked Transfer-Encoding
4. **代理支持** - 支持 HTTP 代理服务器
5. **重定向** - 自动跟随 301/302/303/307 重定向（最多 5 次）

请求处理流程：
```
1. adjust_uri()     - 解析 URL，提取 host/port/path
2. adjust_proxy()   - 处理代理设置
3. adjust_headers() - 规范化请求头
4. adjust_source()  - 处理请求体编码
5. send_request()   - 发送请求行和头部
6. receive_status() - 接收状态行
7. receive_headers()- 接收响应头
8. receive_body()   - 接收响应体
```

响应体接收策略：
- Chunked 编码：按块读取，解析块大小
- Content-Length：按指定长度读取
- 无长度信息：读取直到连接关闭

## 接口

### 模块常量

| 常量 | 默认值 | 说明 |
|------|--------|------|
| `http.TIMEOUT` | 60 | 请求超时时间（秒） |
| `http.PORT` | 80 | 默认端口 |
| `http.USERAGENT` | socket._VERSION | User-Agent 字符串 |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `http.request(url, body)` | url: 请求地址<br>body: POST 数据（可选） | 1, code, headers, status 或 nil, error | 简单请求 |
| `http.request(request_t)` | request_t: 请求表 | 1, code, headers, status 或 nil, error | 高级请求 |
| `http.setproxy(proxy)` | proxy: 代理 URL | 无 | 设置全局代理 |

### 请求表结构

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `url` | string | 是 | 请求 URL |
| `method` | string | 否 | 请求方法，默认 GET |
| `headers` | table | 否 | 请求头 |
| `source` | function | 否 | ltn12 数据源（请求体） |
| `sink` | function | 否 | ltn12 接收器（响应体） |
| `redirect` | boolean | 否 | 是否跟随重定向，默认 true |
| `proxy` | string | 否 | 代理服务器 URL |

### 自动设置的请求头

| 头部 | 条件 | 值 |
|------|------|-----|
| `Host` | 总是 | 请求主机名 |
| `Connection` | 总是 | close |
| `User-Agent` | 总是 | http.USERAGENT |
| `Transfer-Encoding` | 有 source 但无 Content-Length | chunked |

### 重定向处理

| 状态码 | 说明 |
|--------|------|
| 301 | 永久重定向 |
| 302 | 临时重定向 |
| 303 | See Other |
| 307 | 临时重定向（保持方法） |

### 使用示例

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
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | TCP 连接 |
| `socket.url` | URL 解析 |
| `socket.headers` | 头部规范化 |
| `ltn12` | 数据传输 |
| `mime` | 编码处理 |
