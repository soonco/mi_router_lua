# https.lua - LuaSec HTTPS 模块

## 工作原理

本模块基于 LuaSec 库提供 HTTPS 请求功能。它封装了 SSL/TLS 加密连接的创建过程，允许通过 HTTPS 协议安全地发送 HTTP 请求。模块支持简单的 URL 字符串请求和完整的请求配置表两种方式。

主要特点：
- 基于 LuaSocket 和 LuaSec 实现
- 默认禁用 SSLv2/SSLv3/TLSv1 等不安全协议
- 支持 GET 和 POST 请求
- 使用 LTN12 数据过滤器处理请求/响应数据

## 接口

### 常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `_VERSION` | "0.9" | 模块版本 |
| `PORT` | 443 | HTTPS 默认端口 |
| `TIMEOUT` | 60 | 默认超时时间（秒） |

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `tcp(userConfig)` | userConfig: SSL配置表(可选) | SSL配置表 | 创建 TCP 连接配置，合并默认 SSL 配置 |
| `request(requestUrlOrConfig, requestBody)` | requestUrlOrConfig: URL字符串或请求配置表; requestBody: 请求体(可选) | 响应体, 状态码, 响应头, 状态描述 | 发起 HTTPS 请求 |

### 默认 SSL 配置

```lua
{
    protocol = "any",      -- 支持任意 SSL/TLS 协议版本
    options = {
        "all",             -- 启用所有选项
        "no_sslv2",        -- 禁用 SSLv2
        "no_sslv3",        -- 禁用 SSLv3
        "no_tlsv1"         -- 禁用 TLSv1
    },
    verify = "none"        -- 不验证服务器证书
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | Socket 基础库 |
| `ssl` | SSL/TLS 加密库 |
| `ltn12` | LTN12 数据过滤器 |
| `socket.http` | HTTP 协议实现 |
| `socket.url` | URL 解析工具 |
