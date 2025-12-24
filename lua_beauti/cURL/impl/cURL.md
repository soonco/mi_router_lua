# cURL.lua - Lua-cURL 核心实现模块

## 工作原理

本模块是 Lua-cURL 库的核心实现，提供对 libcurl 的高级封装。实现了四种主要的 cURL 对象类型：

| 类型 | 说明 |
|------|------|
| Easy | 单个 HTTP 请求处理 |
| Multi | 多个并发请求处理 |
| Form | HTTP 表单数据构建 |
| Share | 多个 Easy 之间共享数据 |

### 版本信息

- 库名称: Lua-cURL
- 版本: 0.3.13
- 许可证: MIT
- 版权: Copyright (c) 2014-2021 Alexey Melnichuk

### 主要功能

- HTTP/HTTPS 请求（GET、POST、PUT 等）
- 文件上传/下载
- 表单数据提交
- Cookie 管理
- 代理支持
- 多路复用并发请求
- SSL/TLS 安全连接

## 接口

### 模块工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cURL.easy(options)` | options: 选项表（可选） | Easy 对象 | 创建 Easy 请求对象 |
| `cURL.multi(options)` | options: 选项表（可选） | Multi 对象 | 创建 Multi 并发对象 |
| `cURL.form(fields)` | fields: 表单字段（可选） | Form 对象 | 创建表单对象 |

### Easy 类方法

| 方法 | 说明 |
|------|------|
| `easy:setopt_url(url)` | 设置请求 URL |
| `easy:setopt_postfields(data)` | 设置 POST 数据 |
| `easy:setopt_writefunction(func)` | 设置响应数据回调 |
| `easy:setopt_headerfunction(func)` | 设置响应头回调 |
| `easy:setopt_readfunction(func)` | 设置请求数据读取回调 |
| `easy:setopt_httppost(form)` | 设置 HTTP POST 表单 |
| `easy:setopt_proxytype(type)` | 设置代理类型 |
| `easy:setopt_httpauth(type)` | 设置 HTTP 认证类型 |
| `easy:perform(options)` | 执行请求 |
| `easy:post(fields)` | POST 表单数据 |
| `easy:getinfo_response_code()` | 获取响应状态码 |

### Multi 类方法

| 方法 | 说明 |
|------|------|
| `multi:add_handle(easy)` | 添加 Easy 对象 |
| `multi:remove_handle(easy)` | 移除 Easy 对象 |
| `multi:perform()` | 执行所有请求（返回迭代器） |
| `multi:iperform()` | 迭代执行 |
| `multi:info_read()` | 读取完成信息 |
| `multi:wait()` | 等待活动 |

### Form 类方法

| 方法 | 说明 |
|------|------|
| `form:add_content(name, value)` | 添加普通字段 |
| `form:add_file(name, path)` | 添加文件字段 |
| `form:add_buffer(name, filename, data)` | 添加内存数据 |
| `form:add_stream(name, ...)` | 添加流式数据 |
| `form:add(fields)` | 批量添加字段 |

### 代理类型常量

| 常量 | 说明 |
|------|------|
| `HTTP` | HTTP 代理 |
| `HTTP_1_0` | HTTP/1.0 代理 |
| `SOCKS4` | SOCKS4 代理 |
| `SOCKS5` | SOCKS5 代理 |
| `HTTPS` | HTTPS 代理 |

### HTTP 认证类型

| 常量 | 说明 |
|------|------|
| `NONE` | 无认证 |
| `BASIC` | Basic 认证 |
| `DIGEST` | Digest 认证 |
| `NTLM` | NTLM 认证 |
| `ANY` | 任意认证 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `lcurl` 或 `lcurl.safe` | 底层 cURL C 绑定库 |
