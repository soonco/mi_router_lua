# ipkg.lua - OPKG 包管理模块

## 工作原理

封装 OPKG (Open Package Management) 命令行工具，提供 Lua 接口用于软件包的查询、安装、卸载等操作。通过执行 opkg 命令并解析输出获取软件包信息。

### OPKG 命令参数

```
opkg --force-removal-of-dependent-packages --force-overwrite --nocase
```

- `--force-removal-of-dependent-packages`: 强制移除依赖包
- `--force-overwrite`: 强制覆盖已存在文件
- `--nocase`: 搜索时忽略大小写

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `info(pkg)` | 软件包名（可选） | 软件包信息表 | 获取软件包详细信息 |
| `status(pkg)` | 软件包名（可选） | 软件包状态表 | 获取已安装软件包状态 |
| `install(...)` | 软件包名列表 | code, stdout, stderr | 安装软件包 |
| `installed(pkg)` | 软件包名 | boolean | 检查软件包是否已安装 |
| `remove(...)` | 软件包名列表 | code, stdout, stderr | 卸载软件包 |
| `update()` | 无 | code, stdout, stderr | 更新软件包列表 |
| `upgrade()` | 无 | code, stdout, stderr | 升级所有软件包 |
| `list_all(pattern, callback)` | 搜索模式, 回调函数 | 无 | 列出所有可用软件包 |
| `list_installed(pattern, callback)` | 搜索模式, 回调函数 | 无 | 列出已安装软件包 |
| `find(pattern, callback)` | 搜索模式, 回调函数 | 无 | 搜索软件包 |
| `overlay_root()` | 无 | string | 获取 overlay 根目录 |

### 软件包信息结构

```lua
{
    ["package-name"] = {
        Package = "package-name",
        Version = "1.0.0",
        Status = {
            installed = true,
            user = true,
            ok = true
        },
        Description = "...",
        Depends = "...",
        ...
    }
}
```

### 回调函数签名

```lua
function callback(name, version, description)
    -- name: 软件包名
    -- version: 版本号
    -- description: 描述
end
```

### 配置文件

| 路径 | 说明 |
|------|------|
| `/etc/opkg.conf` | OPKG 配置文件 |

### overlay_root 配置

在 `/etc/opkg.conf` 中配置：

```
option overlay_root /overlay
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `os` | 系统操作（执行命令） |
| `io` | 文件 IO |
| `nixio.fs` | 文件系统操作 |
| `luci.util` | 工具函数 |
