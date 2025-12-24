# protocol.lua - HTTP 协议核心模块

## 工作原理

处理 HTTP 协议的编解码、消息解析等功能。支持 URL 编解码、查询参数解析、HTTP 消息头解析、消息体解析（multipart/form-data 和 application/x-www-form-urlencoded）。

### 消息解析流程

1. 解析起始行（请求行或响应行）
2. 解析消息头部（键值对格式）
3. 根据 Content-Type 解析消息体
4. 构建 CGI 环境变量

### 支持的 Content-Type

| 类型 | 说明 |
|------|------|
| `multipart/form-data` | 文件上传表单 |
| `application/x-www-form-urlencoded` | 普通表单提交 |

## 接口

### URL 编解码

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `urldecode(str, no_plus)` | str: 编码字符串, no_plus: 是否不转换+ | 解码后字符串 | URL 解码 |
| `urlencode(str)` | str: 原始字符串 | 编码后字符串 | URL 编码 |
| `xqurlencode(str)` | str: 原始字符串 | 编码后字符串 | 小米定制 URL 编码（RFC 3986） |

### 参数处理

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `urldecode_params(query_string, params)` | 查询字符串, 参数表 | 参数表 | 解析 URL 编码参数 |
| `urlencode_params(params)` | 参数表 | 查询字符串 | 编码参数为查询字符串 |
| `xq_urlencode_params(params)` | 参数表 | 查询字符串 | 小米定制参数编码 |

### 消息解析

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `header_source(socket)` | 网络套接字 | LTN12 数据源 | 创建头部数据源 |
| `parse_message_header(source)` | 数据源 | 消息对象 | 解析 HTTP 消息头 |
| `parse_message_body(source, message, file_callback)` | 数据源, 消息对象, 文件回调 | boolean | 解析 HTTP 消息体 |
| `mimedecode_message_body(source, message, file_callback)` | 数据源, 消息对象, 文件回调 | boolean | 解析 multipart/form-data |
| `urldecode_message_body(source, message)` | 数据源, 消息对象 | boolean | 解析 urlencoded 表单 |

### 常量

| 名称 | 值 | 说明 |
|------|-----|------|
| `HTTP_MAX_CONTENT` | 65536 | 请求体最大长度（64KB） |

### HTTP 状态码映射

| 状态码 | 消息 |
|--------|------|
| 200 | OK |
| 206 | Partial Content |
| 301 | Moved Permanently |
| 302 | Found |
| 304 | Not Modified |
| 400 | Bad Request |
| 403 | Forbidden |
| 404 | Not Found |
| 405 | Method Not Allowed |
| 408 | Request Time-out |
| 411 | Length Required |
| 412 | Precondition Failed |
| 416 | Requested range not satisfiable |
| 500 | Internal Server Error |
| 503 | Server Unavailable |

### 消息对象结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `type` | string | 消息类型（request/response） |
| `request_method` | string | 请求方法（小写） |
| `request_uri` | string | 请求 URI |
| `http_version` | number | HTTP 版本 |
| `headers` | table | 消息头表 |
| `params` | table | 解析后的参数 |
| `env` | table | CGI 环境变量 |
| `content` | string | 原始消息体内容 |
| `mime_boundary` | string | MIME 分隔符 |

### CGI 环境变量

| 变量 | 说明 |
|------|------|
| `CONTENT_LENGTH` | 内容长度 |
| `CONTENT_TYPE` | 内容类型 |
| `REQUEST_METHOD` | 请求方法 |
| `REQUEST_URI` | 请求 URI |
| `SCRIPT_NAME` | 脚本名称 |
| `QUERY_STRING` | 查询字符串 |
| `HTTP_*` | HTTP 头部转换 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.util` | 工具函数 |
| `luci.ltn12` | 数据流处理 |
