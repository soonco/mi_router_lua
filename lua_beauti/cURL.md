# cURL.lua - cURL 库封装模块

## 工作原理

本模块是 Lua-cURL 库的主入口，提供 HTTP/HTTPS 网络请求功能。它加载底层的 `lcurl` C 语言绑定库，并使用 `cURL.impl.cURL` 模块进行高级封装，返回一个完整的 cURL 操作对象。

主要功能包括：
- HTTP GET/POST 请求
- HTTPS 安全连接
- 文件上传/下载
- Cookie 管理
- 代理支持
- 多路复用（Multi）支持

## 接口

本模块返回由 `cURL.impl.cURL` 初始化的 cURL 对象，主要接口包括：

| 方法 | 说明 |
|------|------|
| `cURL.easy()` | 创建简单请求句柄 |
| `easy:setopt_url(url)` | 设置请求 URL |
| `easy:setopt_postfields(data)` | 设置 POST 数据 |
| `easy:perform()` | 执行请求 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `lcurl` | 底层 C 语言 cURL 绑定库 |
| `cURL.impl.cURL` | Lua 层封装实现模块 |
