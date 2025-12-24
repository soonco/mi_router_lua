# fs.lua - Nixio 文件系统操作模块

## 工作原理

本模块扩展了 nixio.fs 模块，提供高级文件系统操作功能。包括文件读写、复制、移动、删除等操作，支持递归处理目录。模块继承了 nixio.fs 的所有方法，并添加了更便捷的高级函数。

主要特点：
- 提供完整的文件读写操作
- 支持文件/目录的复制、移动、删除
- 支持递归操作（递归复制、移动、删除目录）
- 保留文件属性（时间戳、权限、所有者）
- 处理跨文件系统的移动操作

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `readfile(path, limit)` | path: 文件路径; limit: 读取字节数限制(可选) | 文件内容, 错误信息, 错误码 | 读取文件全部内容 |
| `writefile(path, data)` | path: 文件路径; data: 要写入的数据 | 写入字节数, 错误信息, 错误码 | 写入内容到文件 |
| `datacopy(srcPath, destPath, size)` | srcPath: 源文件; destPath: 目标文件; size: 复制字节数(可选) | 成功标志, 错误信息, 错误码 | 复制文件数据（仅内容） |
| `copy(srcPath, destPath)` | srcPath: 源路径; destPath: 目标路径 | 成功标志, 错误信息, 错误码 | 复制文件或目录（包括属性） |
| `move(srcPath, destPath)` | srcPath: 源路径; destPath: 目标路径 | 成功标志, 错误信息, 错误码 | 移动文件或目录 |
| `mkdirr(path, mode)` | path: 目录路径; mode: 权限模式(可选) | 成功标志, 错误信息, 错误码 | 递归创建目录 |
| `copyr(srcPath, destPath)` | srcPath: 源目录; destPath: 目标目录 | 成功标志, 错误信息, 错误码 | 递归复制目录 |
| `mover(srcPath, destPath)` | srcPath: 源目录; destPath: 目标目录 | 成功标志, 错误信息, 错误码 | 递归移动目录 |
| `remover(path)` | path: 要删除的目录 | 成功标志, 错误信息, 错误码 | 递归删除目录 |

### 文件类型处理

| 类型 | 处理方式 |
|------|----------|
| `dir` | 创建目标目录 |
| `lnk` | 读取链接目标并创建新链接 |
| `reg` | 复制文件数据 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `table` | 表操作 |
| `nixio` | 底层文件系统操作 |
| `nixio.util` | Nixio 工具函数 |
