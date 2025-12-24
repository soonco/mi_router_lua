# cURL 模块

Lua-cURL 库的高级封装模块，提供对 libcurl 的完整 Lua 接口支持。

## 版本信息

| 属性 | 值 |
|------|-----|
| 库名称 | Lua-cURL |
| 版本 | 0.3.13 |
| 许可证 | MIT |
| 版权 | Copyright (c) 2014-2021 Alexey Melnichuk |

## 目录结构

```
cURL/
├── Readme.md           # 本文档
├── safe.lua            # 安全模式入口
├── utils.lua           # 工具函数模块
└── impl/
    └── cURL.lua        # 核心实现模块
```

## 模块概述

### 核心实现 (`impl/cURL.lua`)

核心实现模块提供了四种主要的 cURL 对象类型：

| 类型 | 说明 | 用途 |
|------|------|------|
| **Easy** | 单个 HTTP 请求处理 | 执行单个 HTTP/HTTPS 请求 |
| **Multi** | 多个并发请求处理 | 同时执行多个请求，提高效率 |
| **Form** | HTTP 表单数据构建 | 构建 multipart/form-data 表单 |
| **Share** | 多个 Easy 之间共享数据 | 共享 Cookie、DNS 缓存、SSL 会话 |

### 安全模式 (`safe.lua`)

安全模式封装模块，与标准 cURL 模块的区别：

| 模式 | 错误处理方式 | 适用场景 |
|------|-------------|----------|
| 标准模式 (`cURL`) | 抛出异常 | 简单脚本、快速开发 |
| 安全模式 (`cURL.safe`) | 返回 `nil` + 错误信息 | 生产环境、需要优雅处理错误 |

### 工具函数 (`utils.lua`)

提供辅助工具函数，主要用于查找系统 CA 证书包（用于 HTTPS 验证）。

## 主要功能

- HTTP/HTTPS 请求（GET、POST、PUT、DELETE 等）
- 文件上传/下载
- 表单数据提交（multipart/form-data）
- Cookie 管理
- 代理支持（HTTP、SOCKS4、SOCKS5）
- 多路复用并发请求
- SSL/TLS 安全连接
- HTTP 认证（Basic、Digest、NTLM 等）
- SSH 认证

## 使用示例

### 基本 GET 请求

```lua
local cURL = require("cURL")

local easy = cURL.easy()
easy:setopt_url("http://example.com")
easy:setopt_writefunction(function(data)
    print(data)
end)
easy:perform()
```

### 安全模式使用

```lua
local cURL = require("cURL.safe")

local easy, err = cURL.easy()
if not easy then
    print("创建失败:", err)
    return
end

local ok, err = easy:setopt_url("http://example.com")
if not ok then
    print("设置 URL 失败:", err)
    return
end

local result, err = easy:perform()
if not result then
    print("请求失败:", err)
end
```

### POST 表单数据

```lua
local cURL = require("cURL")

local easy = cURL.easy()
easy:setopt_url("http://example.com/api")
easy:post({
    username = "user",
    password = "pass",
    file = { file = "/path/to/file.txt", type = "text/plain" }
})
easy:perform()
```

### 并发请求

```lua
local cURL = require("cURL")

local multi = cURL.multi()

local easy1 = cURL.easy()
easy1:setopt_url("http://example.com/api1")

local easy2 = cURL.easy()
easy2:setopt_url("http://example.com/api2")

multi:add_handle(easy1)
multi:add_handle(easy2)

for data, type, easy in multi:perform() do
    if type == "data" then
        print("收到数据:", data)
    elseif type == "done" then
        print("请求完成:", data)
    elseif type == "error" then
        print("请求错误:", data)
    end
end
```

### 查找 CA 证书

```lua
local utils = require("cURL.utils")

local ca_path = utils.find_ca_bundle()
if ca_path then
    print("找到 CA 证书:", ca_path)
    easy:setopt_cainfo(ca_path)
end
```

## API 参考

### 工厂函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cURL.easy(options)` | options: 选项表（可选） | Easy 对象 | 创建 Easy 请求对象 |
| `cURL.multi(options)` | options: 选项表（可选） | Multi 对象 | 创建 Multi 并发对象 |
| `cURL.form(fields)` | fields: 表单字段（可选） | Form 对象 | 创建表单对象 |

### Easy 类主要方法

| 方法 | 说明 |
|------|------|
| `setopt_url(url)` | 设置请求 URL |
| `setopt_postfields(data)` | 设置 POST 数据 |
| `setopt_writefunction(func)` | 设置响应数据回调 |
| `setopt_headerfunction(func)` | 设置响应头回调 |
| `setopt_readfunction(func)` | 设置请求数据读取回调 |
| `setopt_httppost(form)` | 设置 HTTP POST 表单 |
| `setopt_proxytype(type)` | 设置代理类型 |
| `setopt_httpauth(type)` | 设置 HTTP 认证类型 |
| `setopt_share(share)` | 设置共享对象 |
| `perform(options)` | 执行请求 |
| `post(fields)` | POST 表单数据 |
| `getinfo_response_code()` | 获取响应状态码 |
| `handle()` | 获取底层 handle |

### Multi 类主要方法

| 方法 | 说明 |
|------|------|
| `add_handle(easy)` | 添加 Easy 对象 |
| `remove_handle(easy)` | 移除 Easy 对象 |
| `perform()` | 执行所有请求（返回迭代器） |
| `iperform()` | 迭代执行 |
| `info_read()` | 读取完成信息 |
| `wait()` | 等待活动 |
| `setopt_socketfunction(func)` | 设置 socket 回调 |

### Form 类主要方法

| 方法 | 说明 |
|------|------|
| `add_content(name, value)` | 添加普通字段 |
| `add_file(name, path, type, filename, headers)` | 添加文件字段 |
| `add_buffer(name, filename, data, type, headers)` | 添加内存数据 |
| `add_stream(name, ...)` | 添加流式数据 |
| `add(fields)` | 批量添加字段 |

### Share 类主要方法

| 方法 | 说明 |
|------|------|
| `setopt_share(type)` | 设置共享数据类型 |

### 工具函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `utils.find_ca_bundle(filename)` | filename: 证书文件名（可选，默认 "ca-bundle.crt"） | 文件路径 或 `nil, 目录路径` | 查找 CA 证书文件 |

## 常量参考

### 代理类型

| 常量 | 说明 |
|------|------|
| `HTTP` | HTTP 代理 |
| `HTTP_1_0` | HTTP/1.0 代理 |
| `SOCKS4` | SOCKS4 代理 |
| `SOCKS4A` | SOCKS4A 代理 |
| `SOCKS5` | SOCKS5 代理 |
| `SOCKS5_HOSTNAME` | SOCKS5 主机名代理 |
| `HTTPS` | HTTPS 代理 |

### HTTP 认证类型

| 常量 | 说明 |
|------|------|
| `NONE` | 无认证 |
| `BASIC` | Basic 认证 |
| `DIGEST` | Digest 认证 |
| `GSSNEGOTIATE` | GSS-Negotiate 认证 |
| `NEGOTIATE` | Negotiate 认证 |
| `NTLM` | NTLM 认证 |
| `NTLM_WB` | NTLM_WB 认证 |
| `ANY` | 任意认证 |
| `ANYSAFE` | 任意安全认证 |
| `BEARER` | Bearer 认证 |

### SSH 认证类型

| 常量 | 说明 |
|------|------|
| `NONE` | 无认证 |
| `ANY` | 任意认证 |
| `PUBLICKEY` | 公钥认证 |
| `PASSWORD` | 密码认证 |
| `HOST` | 主机认证 |
| `GSSAPI` | GSSAPI 认证 |
| `KEYBOARD` | 键盘交互认证 |
| `AGENT` | SSH Agent 认证 |
| `DEFAULT` | 默认认证 |

### Share 数据类型

| 常量 | 说明 |
|------|------|
| `COOKIE` | 共享 Cookie |
| `DNS` | 共享 DNS 缓存 |
| `SSL_SESSION` | 共享 SSL 会话 |

## CA 证书查找顺序

`utils.find_ca_bundle()` 按以下顺序查找 CA 证书：

1. 环境变量 `CURL_CA_BUNDLE` 指定的文件
2. 环境变量 `SSL_CERT_DIR` 指定的目录
3. 环境变量 `SSL_CERT_FILE` 指定的文件
4. Windows 系统目录（System32、SysWOW64）
5. `PATH` 环境变量中的各个目录

## 依赖

| 模块 | 说明 |
|------|------|
| `lcurl` | 底层 cURL C 绑定库（标准模式） |
| `lcurl.safe` | 底层 cURL C 绑定库（安全模式） |
| `path` | 路径操作库（utils 模块使用） |
