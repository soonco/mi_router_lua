--[[
    LuCI 文件系统操作模块
    提供文件和目录操作的封装函数
    
    主要功能:
    - 文件/目录检测
    - 文件读写
    - 目录遍历
    - 文件属性操作
    - 符号链接操作
]]

local io = require("io")
local os = require("os")
local ltn12 = require("luci.ltn12")
local nixio_fs = require("nixio.fs")
local nixio_util = require("nixio.util")

module("luci.fs")

-- 直接导出 nixio.fs 的 access 函数
access = nixio_fs.access

--[[
    使用 glob 模式匹配文件
    
    @param ... glob 模式参数
    @return 匹配的文件列表，失败返回 nil 和错误信息
]]
function glob(...)
    local iterator, err, code = nixio_fs.glob(...)
    
    if iterator then
        return nixio_util.consume(iterator)
    else
        return nil, err, code
    end
end

--[[
    检查路径是否为普通文件
    
    @param path 文件路径
    @return true 表示是普通文件，false 表示不是
]]
function isfile(path)
    return nixio_fs.stat(path, "type") == "reg"
end

--[[
    检查路径是否为目录
    
    @param path 目录路径
    @return true 表示是目录，false 表示不是
]]
function isdirectory(path)
    return nixio_fs.stat(path, "type") == "dir"
end

-- 直接导出 nixio.fs 的文件读写函数
readfile = nixio_fs.readfile
writefile = nixio_fs.writefile

-- 文件复制和重命名
copy = nixio_fs.datacopy
rename = nixio_fs.move

--[[
    获取文件的修改时间
    
    @param path 文件路径
    @return 修改时间戳（Unix 时间）
]]
function mtime(path)
    return nixio_fs.stat(path, "mtime")
end

--[[
    设置文件的访问和修改时间
    
    @param path 文件路径
    @param atime 访问时间（可选）
    @param mtime 修改时间（可选）
    @return 成功返回 true
]]
function utime(path, atime, mtime)
    return nixio_fs.utimes(path, mtime, atime)
end

-- 路径处理函数
basename = nixio_fs.basename
dirname = nixio_fs.dirname

--[[
    列出目录内容
    
    @param ... 目录路径参数
    @return 文件名列表（包含 "." 和 ".."），失败返回 nil 和错误信息
]]
function dir(...)
    local iterator, err, code = nixio_fs.dir(...)
    
    if iterator then
        local entries = nixio_util.consume(iterator)
        -- 添加 . 和 .. 目录项
        entries[#entries + 1] = "."
        entries[#entries + 1] = ".."
        return entries
    else
        return nil, err, code
    end
end

--[[
    创建目录
    
    @param path 目录路径
    @param recursive 是否递归创建父目录
    @return 成功返回 true
]]
function mkdir(path, recursive)
    if recursive then
        local result = nixio_fs.mkdirr(path)
        if result then
            return result
        end
    end
    
    return nixio_fs.mkdir(path)
end

-- 删除目录
rmdir = nixio_fs.rmdir

-- 文件类型名称映射表
local FILE_TYPE_NAMES = {
    reg  = "regular",
    dir  = "directory",
    lnk  = "link",
    chr  = "character device",
    blk  = "block device",
    fifo = "fifo",
    sock = "socket"
}

--[[
    获取文件状态信息
    
    @param path 文件路径
    @param field 可选，指定要获取的单个字段
    @return 文件状态表或指定字段的值，失败返回 nil 和错误信息
]]
function stat(path, field)
    local stat_info, err, code = nixio_fs.stat(path)
    
    if stat_info then
        -- 将 modestr 复制到 mode 字段（兼容性）
        stat_info.mode = stat_info.modestr
        
        -- 将文件类型转换为可读名称
        local type_name = FILE_TYPE_NAMES[stat_info.type]
        stat_info.type = type_name or stat_info.type
    end
    
    -- 如果指定了字段且状态信息存在，返回该字段的值
    if field and stat_info then
        if stat_info[field] then
            return stat_info[field], err, code
        end
    end
    
    return stat_info, err, code
end

-- 修改文件权限
chmod = nixio_fs.chmod

--[[
    创建链接
    
    @param source 源文件路径
    @param target 目标链接路径
    @param symbolic 是否创建符号链接
    @return 成功返回 true
]]
function link(source, target, symbolic)
    if symbolic then
        local result = nixio_fs.symlink(source, target)
        if result then
            return result
        end
    end
    
    return nixio_fs.link(source, target)
end

-- 删除文件
unlink = nixio_fs.unlink

-- 读取符号链接目标
readlink = nixio_fs.readlink
