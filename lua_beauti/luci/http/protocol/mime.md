# mime.lua - HTTP MIME 类型模块

## 工作原理

处理文件扩展名与 MIME 类型的映射。根据文件名或路径获取对应的 MIME 类型，或根据 MIME 类型获取对应的文件扩展名。

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `to_mime(filename)` | 文件名或路径 | MIME 类型字符串 | 获取文件的 MIME 类型 |
| `to_ext(mime_type)` | MIME 类型 | 文件扩展名 | 获取 MIME 类型对应的扩展名 |

### MIME 类型映射表

#### 文本类型

| 扩展名 | MIME 类型 |
|--------|-----------|
| txt | text/plain |
| js | text/javascript |
| css | text/css |
| htm, html | text/html |
| patch | text/x-patch |
| c | text/x-csrc |
| h | text/x-chdr |
| o, ko | text/x-object |

#### 图片类型

| 扩展名 | MIME 类型 |
|--------|-----------|
| bmp | image/bmp |
| gif | image/gif |
| png | image/png |
| jpg, jpeg | image/jpeg |
| svg | image/svg+xml |

#### 应用类型

| 扩展名 | MIME 类型 |
|--------|-----------|
| zip | application/zip |
| pdf | application/pdf |
| xml, xsl | application/xml |
| doc | application/msword |
| ppt | application/vnd.ms-powerpoint |
| xls | application/vnd.ms-excel |
| odt | application/vnd.oasis.opendocument.text |
| odp | application/vnd.oasis.opendocument.presentation |
| pl | application/x-perl |
| sh | application/x-shellscript |
| php | application/x-php |
| deb | application/x-deb |
| iso | application/x-cd-image |
| tgz | application/x-compressed-tar |

#### 音频类型

| 扩展名 | MIME 类型 |
|--------|-----------|
| mp3 | audio/mpeg |
| ogg | audio/x-vorbis+ogg |
| wav | audio/x-wav |

#### 视频类型

| 扩展名 | MIME 类型 |
|--------|-----------|
| mpg, mpeg | video/mpeg |
| avi | video/x-msvideo |

### 默认 MIME 类型

未知文件类型返回 `application/octet-stream`

### 使用示例

```lua
-- 获取文件 MIME 类型
local mime = mime.to_mime("document.pdf")  -- "application/pdf"
local mime = mime.to_mime("/path/to/image.png")  -- "image/png"
local mime = mime.to_mime("unknown.xyz")  -- "application/octet-stream"

-- 获取 MIME 类型对应的扩展名
local ext = mime.to_ext("image/png")  -- "png"
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.util` | 工具函数 |
