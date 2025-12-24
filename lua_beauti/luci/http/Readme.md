# LuCI HTTP 模块

HTTP 协议处理模块集，提供完整的 HTTP 协议支持，包括消息解析、URL 编解码、条件请求处理、日期格式转换和 MIME 类型映射等功能。

## 目录结构

```
luci/http/
├── protocol.lua              # HTTP 协议核心模块
├── protocol/
│   ├── conditionals.lua      # HTTP 条件请求处理
│   ├── date.lua              # HTTP 日期格式处理
│   └── mime.lua              # MIME 类型映射
└── Readme.md                 # 本文档
```

## 模块概览

| 模块 | 文件 | 功能描述 |
|------|------|----------|
| protocol | protocol.lua | HTTP 协议编解码、消息解析、URL 处理 |
| conditionals | protocol/conditionals.lua | HTTP 条件请求验证（缓存控制） |
| date | protocol/date.lua | HTTP 日期格式转换 |
| mime | protocol/mime.lua | 文件扩展名与 MIME 类型映射 |

## 模块详情

### 1. protocol.lua - HTTP 协议核心模块

处理 HTTP 协议的编解码、消息解析等核心功能。

#### 主要功能

- **URL 编解码**：支持标准 URL 编码和小米定制的 RFC 3986 编码
- **参数解析**：解析查询字符串和表单数据
- **消息解析**：解析 HTTP 请求/响应的头部和消息体
- **CGI 环境构建**：生成标准 CGI 环境变量

#### 核心接口

| 函数 | 说明 |
|------|------|
| `urldecode(str, no_plus)` | URL 解码 |
| `urlencode(str)` | URL 编码 |
| `urldecode_params(query_string, params)` | 解析 URL 编码参数 |
| `urlencode_params(params)` | 编码参数为查询字符串 |
| `parse_message_header(source)` | 解析 HTTP 消息头 |
| `parse_message_body(source, message, file_callback)` | 解析 HTTP 消息体 |

#### 支持的 Content-Type

| 类型 | 说明 |
|------|------|
| `multipart/form-data` | 文件上传表单 |
| `application/x-www-form-urlencoded` | 普通表单提交 |

#### HTTP 状态码

支持常见状态码：200, 206, 301, 302, 304, 400, 403, 404, 405, 408, 411, 412, 416, 500, 503

---

### 2. conditionals.lua - HTTP 条件请求处理模块

处理 HTTP 条件请求头，用于缓存验证和并发控制。

#### 支持的条件头

| 条件头 | 用途 | 失败状态码 |
|--------|------|------------|
| `If-Match` | 确保资源未被修改（PUT/PATCH） | 412 |
| `If-Modified-Since` | 缓存验证 | 304 |
| `If-None-Match` | 缓存验证（ETag） | 304/412 |
| `If-Range` | 断点续传验证 | 412 |
| `If-Unmodified-Since` | 确保资源未修改 | 412 |

#### 核心接口

| 函数 | 说明 |
|------|------|
| `mk_etag(stat_info)` | 生成 ETag（格式：`"inode-size-mtime"`） |
| `if_match(request, stat_info)` | 验证 If-Match 条件 |
| `if_modified_since(request, stat_info)` | 验证 If-Modified-Since 条件 |
| `if_none_match(request, stat_info)` | 验证 If-None-Match 条件 |
| `if_range(request, stat_info)` | 验证 If-Range 条件 |
| `if_unmodified_since(request, stat_info)` | 验证 If-Unmodified-Since 条件 |

---

### 3. date.lua - HTTP 日期处理模块

处理 HTTP 协议中的日期格式转换和比较。

#### HTTP 日期格式（RFC 1123）

```
Day, DD Mon YYYY HH:MM:SS TZ
```

示例：`Mon, 01 Jan 2024 12:00:00 GMT`

#### 核心接口

| 函数 | 说明 |
|------|------|
| `tz_offset(timezone)` | 计算时区偏移量（秒） |
| `to_unix(http_date)` | HTTP 日期转 Unix 时间戳 |
| `to_http(timestamp)` | Unix 时间戳转 HTTP 日期 |
| `compare(date1, date2)` | 比较两个日期（返回 -1/0/1） |

#### 使用示例

```lua
local date = require("luci.http.protocol.date")

-- HTTP 日期转 Unix 时间戳
local timestamp = date.to_unix("Mon, 01 Jan 2024 12:00:00 GMT")

-- Unix 时间戳转 HTTP 日期
local http_date = date.to_http(os.time())

-- 计算时区偏移
local offset = date.tz_offset("+0800")  -- 28800 秒
```

---

### 4. mime.lua - HTTP MIME 类型模块

处理文件扩展名与 MIME 类型的映射。

#### 核心接口

| 函数 | 说明 |
|------|------|
| `to_mime(filename)` | 获取文件的 MIME 类型 |
| `to_ext(mime_type)` | 获取 MIME 类型对应的扩展名 |

#### 支持的 MIME 类型

| 类别 | 扩展名示例 |
|------|------------|
| 文本 | txt, js, css, html, c, h |
| 图片 | bmp, gif, png, jpg, svg |
| 应用 | zip, pdf, xml, doc, ppt, xls, deb, iso |
| 音频 | mp3, ogg, wav |
| 视频 | mpg, mpeg, avi |

默认 MIME 类型：`application/octet-stream`

#### 使用示例

```lua
local mime = require("luci.http.protocol.mime")

-- 获取文件 MIME 类型
local type1 = mime.to_mime("document.pdf")      -- "application/pdf"
local type2 = mime.to_mime("/path/to/image.png") -- "image/png"

-- 获取 MIME 类型对应的扩展名
local ext = mime.to_ext("image/png")  -- "png"
```

## 模块依赖关系

```
protocol.lua
├── luci.util
└── luci.ltn12

protocol/conditionals.lua
└── luci.http.protocol.date

protocol/date.lua
└── luci.sys.zoneinfo

protocol/mime.lua
└── luci.util
```

## 典型使用场景

### 1. 解析 HTTP 请求

```lua
local protocol = require("luci.http.protocol")

-- 解析消息头
local message = protocol.parse_message_header(source)

-- 解析消息体
protocol.parse_message_body(source, message, file_callback)

-- 访问解析结果
local method = message.request_method
local uri = message.request_uri
local params = message.params
```

### 2. 处理条件请求（缓存验证）

```lua
local conditionals = require("luci.http.protocol.conditionals")

-- 检查资源是否被修改
local modified, status, headers = conditionals.if_modified_since(request, stat_info)
if not modified then
    -- 返回 304 Not Modified
end
```

### 3. 静态文件服务

```lua
local mime = require("luci.http.protocol.mime")
local date = require("luci.http.protocol.date")

-- 设置正确的 Content-Type
local content_type = mime.to_mime(filename)

-- 设置 Last-Modified 头
local last_modified = date.to_http(stat_info.mtime)
```
