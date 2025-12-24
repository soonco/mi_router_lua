# mime.lua - MIME 编码/解码模块

## 工作原理

本模块提供 MIME（Multipurpose Internet Mail Extensions）相关的编码和解码功能，主要用于邮件和 HTTP 协议中的数据编码。

支持的功能：
- **Base64 编码/解码**: 将二进制数据转换为 ASCII 文本
- **Quoted-Printable 编码/解码**: 用于可打印字符的编码
- **文本换行处理**: 按指定长度换行
- **SMTP 点填充**: 处理邮件协议中的点字符

模块使用 LTN12 过滤器链机制，支持流式数据处理。

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `mime.encode(type, data)` | type: 编码类型<br>data: 数据 | 编码后的数据 | 编码数据 |
| `mime.decode(type, data)` | type: 编码类型<br>data: 数据 | 解码后的数据 | 解码数据 |
| `mime.wrap(type, data)` | type: 换行类型<br>data: 数据 | 换行后的数据 | 文本换行 |
| `mime.normalize(marker)` | marker: 行结束标记 | 过滤器函数 | 规范化行结束符 |
| `mime.stuff()` | 无 | 过滤器函数 | SMTP 点填充 |

### 编码类型

| 类型 | 说明 |
|------|------|
| `"base64"` | Base64 编码 |
| `"quoted-printable"` | Quoted-Printable 编码 |

### 过滤器表

| 表 | 说明 |
|------|------|
| `mime.encodet` | 编码过滤器表 |
| `mime.decodet` | 解码过滤器表 |
| `mime.wrapt` | 换行过滤器表 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `ltn12` | LTN12 数据传输库 |
| `mime.core` | MIME 核心 C 模块 |
| `io` | Lua IO 库 |
| `string` | Lua 字符串库 |
