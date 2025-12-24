# conditionals.lua - HTTP 条件请求处理模块

## 工作原理

处理 HTTP 条件请求头，用于缓存验证和并发控制。支持 If-Match、If-Modified-Since、If-None-Match、If-Range、If-Unmodified-Since 等条件头的验证。

### ETag 生成

ETag 格式为 `"inode-size-mtime"`，基于文件的 inode 号、大小和修改时间生成唯一标识。

### 条件验证流程

1. 检查请求头中的条件字段
2. 与服务器资源状态比较
3. 返回验证结果和适当的 HTTP 状态码

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `mk_etag(stat_info)` | 文件状态信息 | ETag 字符串 | 生成 ETag |
| `if_match(request, stat_info)` | 请求对象, 文件状态 | boolean, [status] | 验证 If-Match |
| `if_modified_since(request, stat_info)` | 请求对象, 文件状态 | boolean, [status, headers] | 验证 If-Modified-Since |
| `if_none_match(request, stat_info)` | 请求对象, 文件状态 | boolean, [status, headers] | 验证 If-None-Match |
| `if_range(request, stat_info)` | 请求对象, 文件状态 | boolean, status | 验证 If-Range |
| `if_unmodified_since(request, stat_info)` | 请求对象, 文件状态 | boolean, [status] | 验证 If-Unmodified-Since |

### 条件头说明

| 条件头 | 用途 | 成功返回 | 失败返回 |
|--------|------|----------|----------|
| `If-Match` | 确保资源未被修改（PUT/PATCH） | true | false, 412 |
| `If-Modified-Since` | 缓存验证 | true（已修改） | false, 304（未修改） |
| `If-None-Match` | 缓存验证（ETag） | true（不匹配） | false, 304/412（匹配） |
| `If-Range` | 断点续传验证 | - | false, 412 |
| `If-Unmodified-Since` | 确保资源未修改 | true（未修改） | false, 412（已修改） |

### 文件状态信息 (stat_info)

| 字段 | 类型 | 说明 |
|------|------|------|
| `ino` | number | inode 号 |
| `size` | number | 文件大小 |
| `mtime` | number | 修改时间（Unix 时间戳） |

### 返回的响应头

当返回 304 状态码时，包含以下响应头：

| 头部 | 说明 |
|------|------|
| `ETag` | 资源 ETag |
| `Date` | 当前时间 |
| `Last-Modified` | 资源最后修改时间 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http.protocol.date` | HTTP 日期格式处理 |
