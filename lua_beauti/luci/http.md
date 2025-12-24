# luci/http.lua

## 概述

LuCI HTTP 请求处理模块，提供 HTTP 请求/响应处理、表单数据解析、Cookie 操作等功能。是 LuCI Web 框架处理 HTTP 通信的核心模块。

## 工作原理

1. **请求封装**: `Request` 类封装 HTTP 请求，包含环境变量、请求头、表单参数
2. **表单解析**: 延迟解析请求体，支持 URL 编码和 multipart 表单
3. **安全过滤**: 通过 `XQSecureUtil` 和 `XQParam` 进行 XSS 和参数验证
4. **响应输出**: 使用协程 yield 机制输出状态码、响应头和响应体
5. **JSON 支持**: 提供 JSON/JSONP 格式的响应输出

## 接口/函数列表

### Request 类

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `Request:__init__(env, input_source, error_handler)` | 环境、输入源、错误处理器 | void | 初始化请求对象 |
| `Request:formvalue(name, noparse)` | 参数名、是否跳过解析 | any | 获取表单参数值 |
| `Request:formvaluetable(prefix)` | 前缀 | table | 获取指定前缀的参数表 |
| `Request:content()` | 无 | string, number | 获取原始请求体和长度 |
| `Request:getcookie(name)` | Cookie 名 | string | 获取 Cookie 值 |
| `Request:getenv(name)` | 环境变量名 | any | 获取环境变量 |
| `Request:setfilehandler(handler)` | 处理函数 | void | 设置文件上传处理器 |

### 表单数据获取

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `formvalue(name, noparse, verify_type)` | 参数名、跳过解析、验证类型 | any | 获取表单值（带安全检查） |
| `formvalue_unsafe(name, noparse)` | 参数名、跳过解析 | any | 获取表单值（无安全检查） |
| `xqformvalue(name, noparse)` | 参数名、跳过解析 | any | 获取表单值（XSS 过滤） |
| `formvaluetable(prefix)` | 前缀 | table | 获取参数表 |
| `content()` | 无 | string, number | 获取请求体 |

### Cookie 和环境

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `getcookie(name)` | Cookie 名 | string | 获取 Cookie |
| `getenv(name)` | 环境变量名 | any | 获取环境变量 |

### 响应输出

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `status(code, message)` | 状态码、消息 | void | 设置 HTTP 状态码 |
| `header(name, value)` | 头名、值 | void | 设置响应头 |
| `prepare_content(content_type)` | 内容类型 | void | 准备内容类型头 |
| `write(content, callback, is_json, set_content_length)` | 内容、回调、是否JSON、设置长度 | boolean | 写入响应内容 |
| `write_file(filepath)` | 文件路径 | void | 输出文件内容 |
| `close()` | 无 | void | 关闭响应 |

### JSON 输出

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `write_json(data)` | 数据 | void | 输出 JSON（带日志） |
| `writeJsonNoLog(data)` | 数据 | void | 输出 JSON（无日志） |
| `write_jsonp(data, callback)` | 数据、回调函数名 | void | 输出 JSONP |

### 重定向和 URL

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `redirect(url)` | URL | void | HTTP 302 重定向 |
| `build_querystring(params)` | 参数表 | string | 构建查询字符串 |
| `urldecode(str)` | 字符串 | string | URL 解码 |
| `urlencode(str)` | 字符串 | string | URL 编码 |

### 其他

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `source()` | 无 | function | 获取输入源 |
| `setfilehandler(handler)` | 处理函数 | void | 设置文件处理器 |
| `splice(fd, size)` | 文件描述符、大小 | void | 零拷贝传输 |

## 外部依赖

### Lua 模块
- `luci.ltn12` - 数据传输过滤器
- `luci.http.protocol` - HTTP 协议解析
- `luci.util` - 工具函数
- `luci.json` - JSON 编解码

### 小米模块
- `xiaoqiang.util.XQSecureUtil` - 安全检查（hackCheck, xssCheck）
- `xiaoqiang.util.XQParam` - 参数验证
- `xiaoqiang.XQLog` - 日志记录

## 被引用情况

- `luci/dispatcher.lua` - 获取请求参数、设置响应
- `luci/sgi/cgi.lua` - 创建 Request 对象
- 所有控制器 - 获取参数、输出响应

## 关键代码说明

### 协程响应机制
```lua
-- yield 类型:
-- 1: 状态码
-- 2: 响应头
-- 3: 结束头部
-- 4: 响应体
-- 5: 关闭连接
-- 6: splice 传输
```

### 安全过滤流程
```lua
function formvalue(name, noparse, verify_type)
    local value = context.request:formvalue(name, noparse)
    if verify_type then
        -- 使用 XQParam 进行类型验证
        local verified = XQParam.verify(value, verify_type)
        if verified == false then
            return nil
        end
        return value
    else
        -- 使用 XQSecureUtil 进行安全检查
        return XQSecureUtil.hackCheck(name, value)
    end
end
```

### 文件输出
```lua
function write_file(filepath)
    local CHUNK_SIZE = 4194304  -- 4MB 分块
    -- 分块读取并输出大文件
end
```
