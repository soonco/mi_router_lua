# luci/ccache.lua

## 概述

LuCI 字节码缓存模块，将 Lua 源文件编译为字节码并缓存，提高模块加载速度。支持按需缓存模式，首次加载时自动编译。

## 工作原理

1. **替换加载器**: 替换 `package.loaders[2]` 为自定义加载器
2. **缓存检查**: 加载模块时先检查缓存是否存在且有效
3. **安全验证**: 验证缓存文件的所有者和权限
4. **字节码缓存**: 如果缓存不存在，使用原始加载器加载后缓存字节码
5. **文件名编码**: 使用十六进制编码模块名作为缓存文件名

## 接口/函数列表

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `cache_ondemand(cache_dir, file_mode)` | 缓存目录、文件权限 | void | 按需启用缓存（仅从文件加载时） |
| `cache_enable(cache_dir, file_mode)` | 缓存目录、文件权限 | void | 启用字节码缓存 |

## 参数说明

| 参数 | 默认值 | 描述 |
|------|--------|------|
| `cache_dir` | `/tmp/luci-cache` | 缓存文件存储目录 |
| `file_mode` | `rw-------` | 缓存文件权限模式 |

## 外部依赖

- `io` - 文件 I/O
- `nixio.fs` - 文件系统操作
- `luci.util` - 工具函数（get_bytecode）
- `nixio` - 系统调用（getuid）
- `debug` - 调试信息
- `string` - 字符串操作
- `package` - 包管理

## 被引用情况

- `luci/cacheloader.lua` - 缓存加载器
- `luci/dispatcher.lua` - 可选启用缓存

## 关键代码说明

### 文件名编码
```lua
local function encode_filename(module_name)
    local result = ""
    for i = 1, #module_name do
        local byte = string.byte(module_name, i)
        result = result .. ("%2X" % byte)
    end
    return result
end
-- "luci.http" -> "6C7563692E68747470"
```

### 安全检查
```lua
local function safe_load_cache(cache_path)
    local stat = nixio_fs.stat(cache_path)
    if stat then
        -- 验证文件所有者是当前用户
        if stat.uid == current_uid then
            -- 验证文件权限正确
            if stat.modestr == file_mode then
                return loadfile(cache_path)
            end
        end
    end
    return nil
end
```

### 自定义加载器
```lua
local function cached_loader(module_name)
    local cache_path = cache_dir .. "/" .. encode_filename(module_name)
    
    -- 尝试从缓存加载
    local cached_func = safe_load_cache(cache_path)
    if cached_func then
        return cached_func
    end
    
    -- 使用原始加载器
    local loaded = original_loader(module_name)
    
    -- 缓存字节码
    if type(loaded) == "function" then
        write_cache(cache_path, loaded)
    end
    
    return loaded
end
```

## 安全注意事项

1. **所有者验证**: 只加载当前用户拥有的缓存文件
2. **权限验证**: 只加载权限正确的缓存文件
3. **写入限制**: 只有 root 用户才能写入缓存
4. **目录隔离**: 缓存存储在独立目录中