# utils.lua - cURL 工具函数模块

## 工作原理

本模块提供 cURL 库的辅助工具函数，主要用于查找系统 CA 证书包（用于 HTTPS 验证）。

CA 证书查找顺序：
1. 环境变量 `CURL_CA_BUNDLE`
2. 环境变量 `SSL_CERT_DIR`（目录）
3. 环境变量 `SSL_CERT_FILE`
4. Windows 系统目录（System32、SysWOW64 等）
5. `PATH` 环境变量中的目录

在 HTTPS 请求时，cURL 需要 CA 证书来验证服务器身份。

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `utils.find_ca_bundle(filename)` | filename: 证书文件名（可选） | 文件路径或 nil, 目录路径 | 查找 CA 证书文件 |

### 使用示例

```lua
local utils = require("cURL.utils")

-- 查找默认的 CA 证书包
local ca_path = utils.find_ca_bundle()
if ca_path then
    print("找到 CA 证书:", ca_path)
end

-- 查找指定名称的证书文件
local cert = utils.find_ca_bundle("cacert.pem")
```

### 返回值说明

| 返回值 | 说明 |
|--------|------|
| `string` | CA 证书文件的完整路径 |
| `nil, string` | 如果找到的是目录，返回 nil 和目录路径 |
| `nil` | 未找到证书 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `split(str, sep, plain)` | 按分隔符分割字符串 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `path` | 路径操作库 |
