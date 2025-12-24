# luci/fs.lua

## 概述

LuCI 文件系统操作模块，提供文件和目录操作的封装函数。是对 `nixio.fs` 的高级封装，提供更友好的接口。

## 工作原理

1. **封装 nixio.fs**: 大部分函数直接导出或简单封装 `nixio.fs` 函数
2. **类型转换**: 将文件类型代码转换为可读名称
3. **兼容性处理**: 提供与旧版 API 兼容的接口

## 接口/函数列表

### 文件检测

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `access(path, mode)` | 路径、模式 | boolean | 检查文件访问权限 |
| `isfile(path)` | 路径 | boolean | 检查是否为普通文件 |
| `isdirectory(path)` | 路径 | boolean | 检查是否为目录 |

### 文件读写

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `readfile(path)` | 路径 | string | 读取文件内容 |
| `writefile(path, data)` | 路径、数据 | boolean | 写入文件内容 |

### 文件操作

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `copy(src, dst)` | 源、目标 | boolean | 复制文件 |
| `rename(src, dst)` | 源、目标 | boolean | 重命名/移动文件 |
| `unlink(path)` | 路径 | boolean | 删除文件 |
| `chmod(path, mode)` | 路径、模式 | boolean | 修改文件权限 |
| `link(src, dst, symbolic)` | 源、目标、是否符号链接 | boolean | 创建链接 |
| `readlink(path)` | 路径 | string | 读取符号链接目标 |

### 目录操作

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `dir(path)` | 路径 | table | 列出目录内容 |
| `glob(pattern)` | 模式 | table | 匹配文件 |
| `mkdir(path, recursive)` | 路径、是否递归 | boolean | 创建目录 |
| `rmdir(path)` | 路径 | boolean | 删除目录 |

### 文件属性

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `stat(path, field)` | 路径、字段(可选) | table/any | 获取文件状态 |
| `mtime(path)` | 路径 | number | 获取修改时间 |
| `utime(path, atime, mtime)` | 路径、访问时间、修改时间 | boolean | 设置时间戳 |

### 路径处理

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `basename(path)` | 路径 | string | 获取文件名 |
| `dirname(path)` | 路径 | string | 获取目录名 |

## stat 返回结构

```lua
{
    mode = string,      -- 权限字符串 (如 "rwxr-xr-x")
    type = string,      -- 文件类型名称
    size = number,      -- 文件大小
    mtime = number,     -- 修改时间
    atime = number,     -- 访问时间
    ctime = number,     -- 状态改变时间
    uid = number,       -- 所有者 UID
    gid = number,       -- 所有者 GID
    ino = number,       -- inode 号
    nlink = number,     -- 硬链接数
    dev = number,       -- 设备号
    ...
}
```

## 文件类型映射

| 代码 | 名称 |
|------|------|
| reg | regular |
| dir | directory |
| lnk | link |
| chr | character device |
| blk | block device |
| fifo | fifo |
| sock | socket |

## 外部依赖

- `io` - 文件 I/O
- `os` - 操作系统接口
- `luci.ltn12` - 数据传输
- `nixio.fs` - 底层文件系统操作
- `nixio.util` - nixio 工具函数

## 被引用情况

- `luci/dispatcher.lua` - 文件存在检查
- `luci/template.lua` - 模板文件加载
- `luci/sauth.lua` - 会话文件操作
- 各种模块 - 配置文件读写

## 关键代码说明

### 目录列表兼容性
```lua
function dir(...)
    local iterator, err, code = nixio_fs.dir(...)
    if iterator then
        local entries = nixio_util.consume(iterator)
        -- 添加 . 和 .. 目录项以兼容旧 API
        entries[#entries + 1] = "."
        entries[#entries + 1] = ".."
        return entries
    end
end
```

### 递归创建目录
```lua
function mkdir(path, recursive)
    if recursive then
        return nixio_fs.mkdirr(path)
    end
    return nixio_fs.mkdir(path)
end
```
