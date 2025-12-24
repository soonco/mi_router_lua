# url.lua - URL 解析模块

## 工作原理

LuaSocket URL 解析模块，提供完整的 URL 处理功能，符合 RFC 3986 规范。

核心功能：
1. **URL 编码/解码** - 处理特殊字符的百分号编码
2. **URL 解析** - 将 URL 字符串分解为组件
3. **URL 构建** - 从组件表构建 URL 字符串
4. **相对 URL 解析** - 将相对 URL 转换为绝对 URL
5. **路径规范化** - 处理 `.` 和 `..` 路径段

URL 组件结构：
```
scheme://[user:password@]host[:port]/path[;params][?query][#fragment]
```

路径规范化规则：
- `./` 被移除
- `path/../` 被移除
- 处理多层 `..` 引用

## 接口

### 模块常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `url._VERSION` | "URL 1.0.3" | 模块版本 |

### 编码函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `url.escape(s)` | s: 原始字符串 | 编码后的字符串 | URL 编码（除字母数字外全部编码） |
| `url.escape_segment(s)` | s: 原始字符串 | 编码后的字符串 | 路径段编码（保留部分特殊字符） |
| `url.unescape(s)` | s: 编码字符串 | 解码后的字符串 | URL 解码 |

### escape_segment 保留字符

```
- _ . ! ~ * ' ( ) : @ & = + $ ,
```

### 解析函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `url.parse(url_string, default)` | url_string: URL 字符串<br>default: 默认值表 | 组件表 | 解析 URL |
| `url.build(parsed)` | parsed: 组件表 | URL 字符串 | 构建 URL |
| `url.absolute(base, relative)` | base: 基础 URL<br>relative: 相对 URL | 绝对 URL | 解析相对 URL |

### 路径函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `url.parse_path(path)` | path: 路径字符串 | 路径段表 | 解析路径 |
| `url.build_path(parsed, unsafe)` | parsed: 路径段表<br>unsafe: 是否跳过编码 | 路径字符串 | 构建路径 |

### 解析结果组件表

| 字段 | 示例 | 说明 |
|------|------|------|
| `scheme` | "http" | 协议 |
| `authority` | "user:pass@host:80" | 授权部分 |
| `host` | "example.com" | 主机名 |
| `port` | "80" | 端口号 |
| `userinfo` | "user:pass" | 用户信息 |
| `user` | "user" | 用户名 |
| `password` | "pass" | 密码 |
| `path` | "/path/to/resource" | 路径 |
| `params` | "type=a" | 路径参数 |
| `query` | "key=value" | 查询字符串 |
| `fragment` | "section1" | 片段标识符 |

### 路径段表结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `[1], [2], ...` | string | 路径段 |
| `is_absolute` | 1/nil | 是否以 `/` 开头 |
| `is_directory` | 1/nil | 是否以 `/` 结尾 |

### 使用示例

```lua
-- 解析 URL
local parsed = url.parse("http://user:pass@example.com:8080/path?query#frag")
-- parsed.scheme = "http"
-- parsed.host = "example.com"
-- parsed.port = "8080"
-- parsed.path = "/path"
-- parsed.query = "query"
-- parsed.fragment = "frag"

-- 构建 URL
local url_string = url.build(parsed)

-- 相对 URL 转绝对
local abs = url.absolute("http://example.com/a/b/c", "../d")
-- 结果: "http://example.com/a/d"

-- URL 编码
local encoded = url.escape("hello world")  -- "hello%20world"
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `socket` | 注册到 socket 命名空间 |
| `string` | 字符串处理 |
| `table` | 表操作 |
