# Nixio 扩展模块

## 概述

本目录包含 LuCI 框架中 nixio 库的扩展模块，提供高级文件系统操作和 I/O 工具函数。nixio 是 LuCI 的底层 I/O 库，这些扩展模块在其基础上提供了更便捷的高级功能。

## 模块列表

| 文件 | 说明 |
|------|------|
| `fs.lua` | 文件系统操作模块，提供文件读写、复制、移动、删除等功能 |
| `util.lua` | 工具函数模块，提供数据消费、I/O 操作等实用功能 |

## 模块详情

### fs.lua - 文件系统操作模块

扩展 `nixio.fs` 模块，提供高级文件系统操作功能。

#### 主要功能

- **文件读写**：`readfile()` / `writefile()` - 便捷的文件内容读写
- **文件复制**：`datacopy()` / `copy()` - 支持仅复制数据或包含属性
- **文件移动**：`move()` - 自动处理跨文件系统移动
- **目录创建**：`mkdirr()` - 递归创建目录
- **递归操作**：`copyr()` / `mover()` / `remover()` - 递归处理目录

#### 函数接口

| 函数 | 说明 |
|------|------|
| `readfile(path, limit)` | 读取文件全部内容 |
| `writefile(path, data)` | 写入内容到文件 |
| `datacopy(srcPath, destPath, size)` | 复制文件数据（仅内容） |
| `copy(srcPath, destPath)` | 复制文件或目录（包括属性） |
| `move(srcPath, destPath)` | 移动文件或目录 |
| `mkdirr(path, mode)` | 递归创建目录 |
| `copyr(srcPath, destPath)` | 递归复制目录 |
| `mover(srcPath, destPath)` | 递归移动目录 |
| `remover(path)` | 递归删除目录 |

#### 特性

- 保留文件属性（时间戳、权限、所有者）
- 正确处理符号链接
- 自动处理跨文件系统的移动操作（EXDEV 错误）
- 递归操作时继续处理所有条目，记录第一个错误

---

### util.lua - 工具函数模块

为 nixio 库提供扩展工具函数，通过扩展元表为 socket、TLS socket 和文件对象添加便捷方法。

#### 主要功能

- **数据消费**：`consume()` - 将迭代器数据收集到表中
- **完整读写**：`readall()` / `writeall()` / `recvall()` / `sendall()`
- **数据源迭代器**：`linesource()` / `blocksource()` - 按行或按块读取
- **数据复制**：`copy()` / `copyz()` - 支持 Linux 零拷贝传输
- **TLS 支持**：为 TLS socket 添加额外的便捷方法

#### 全局函数

| 函数 | 说明 |
|------|------|
| `consume(iterator, resultTable)` | 消费迭代器数据到表中 |

#### 元表方法（适用于 socket/file/tls_socket）

| 方法 | 说明 |
|------|------|
| `is_socket()` | 检查是否为 socket |
| `is_tls_socket()` | 检查是否为 TLS socket |
| `is_file()` | 检查是否为文件 |
| `readall()` | 读取所有数据 |
| `recvall()` | 接收所有数据 |
| `writeall(data)` | 写入所有数据 |
| `sendall(data)` | 发送所有数据 |
| `linesource(limit)` | 创建按行读取的迭代器 |
| `blocksource(blockSize)` | 创建按块读取的迭代器 |
| `sink()` | 创建数据接收器函数 |
| `copy(source, target)` | 复制数据 |
| `copyz(source, count)` | 零拷贝复制（仅 Linux） |

#### TLS Socket 专用方法

| 方法 | 说明 |
|------|------|
| `close()` | 关闭 TLS 连接 |
| `getsockname()` | 获取本地地址 |
| `getpeername()` | 获取对端地址 |
| `getsockopt(...)` | 获取 socket 选项 |
| `setsockopt(...)` | 设置 socket 选项 |

## 依赖关系

```
nixio.fs ──依赖──> nixio.util
    │                  │
    └──────────────────┴──> nixio (底层库)
```

## 使用示例

### 文件操作

```lua
local fs = require("nixio.fs")

-- 读取文件
local content = fs.readfile("/etc/config/network")

-- 写入文件
fs.writefile("/tmp/test.txt", "Hello World")

-- 复制文件（保留属性）
fs.copy("/etc/passwd", "/tmp/passwd.bak")

-- 递归复制目录
fs.copyr("/etc/config", "/tmp/config_backup")

-- 递归删除目录
fs.remover("/tmp/old_backup")
```

### I/O 操作

```lua
local nixio = require("nixio")
require("nixio.util")

-- 读取所有数据
local file = nixio.open("/etc/hosts", "r")
local content = file:readall()
file:close()

-- 按行读取
local sock = nixio.connect("example.com", 80)
for line in sock:linesource() do
    print(line)
end
```

## 平台兼容性

- **通用功能**：所有 POSIX 兼容系统
- **零拷贝传输** (`copyz`)：仅 Linux（使用 sendfile 系统调用）
- **lchown 支持**：取决于系统是否支持

## 错误处理

所有函数遵循统一的错误返回模式：

```lua
local result, errMsg, errCode = fs.readfile("/nonexistent")
if not result then
    print("Error:", errMsg, "Code:", errCode)
end
```

## 相关文档

- `fs.lua.md` - fs.lua 的详细说明文档
- `util.lua.md` - util.lua 的详细说明文档
