-- nixio.fs 文件系统操作模块
-- 提供文件读写、复制、移动、删除等文件系统操作功能

local table = require("table")
local nixio = require("nixio")
local type = type
local ipairs = ipairs
local setmetatable = setmetatable

require("nixio.util")

-- 定义 nixio.fs 模块，继承 nixio.fs 的方法
module("nixio.fs", function(env)
    setmetatable(env, { __index = nixio.fs })
end)

-- 读取文件全部内容
-- @param path string - 文件路径
-- @param limit number - 可选，读取字节数限制
-- @return string|nil - 成功返回文件内容，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function readfile(path, limit)
    local file, errMsg, errCode = nixio.open(path, "r")
    local content = nil
    
    if not file then
        return nil, errMsg, errCode
    end
    
    content, errMsg, errCode = file:readall(limit)
    file:close()
    
    return content, errMsg, errCode
end

-- 写入内容到文件
-- @param path string - 文件路径
-- @param data string - 要写入的数据
-- @return boolean|nil - 成功返回写入字节数，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function writefile(path, data)
    local file, errMsg, errCode = nixio.open(path, "w")
    
    if not file then
        return nil, errMsg, errCode
    end
    
    local result
    result, errMsg, errCode = file:writeall(data)
    file:close()
    
    return result, errMsg, errCode
end

-- 复制文件数据（仅复制内容，不复制属性）
-- @param srcPath string - 源文件路径
-- @param destPath string - 目标文件路径
-- @param size number - 可选，复制字节数限制
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function datacopy(srcPath, destPath, size)
    local srcFile, errMsg, errCode = nixio.open(srcPath, "r")
    
    if not srcFile then
        return nil, errMsg, errCode
    end
    
    local destFile
    destFile, errMsg, errCode = nixio.open(destPath, "w")
    
    if not destFile then
        return nil, errMsg, errCode
    end
    
    local result, copied, readErr, writeErr = srcFile:copy(destFile, size)
    
    srcFile:close()
    destFile:close()
    
    return result, copied, readErr, writeErr
end

-- 复制文件或目录（包括属性）
-- @param srcPath string - 源路径
-- @param destPath string - 目标路径
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function copy(srcPath, destPath)
    -- 获取源文件/目录的状态信息
    local stat, errMsg, errCode = nixio.fs.lstat(srcPath)
    
    if not stat then
        return nil, errMsg, errCode
    end
    
    local result
    local fileType = stat.type
    
    if fileType == "dir" then
        -- 处理目录：检查目标是否已是目录，否则创建
        local destType = nixio.fs.stat(destPath, "type")
        if destType ~= "dir" then
            result, errMsg, errCode = nixio.fs.mkdir(destPath)
        else
            result = true
        end
    elseif fileType == "lnk" then
        -- 处理符号链接：读取链接目标并创建新链接
        local linkTarget = nixio.fs.readlink(srcPath)
        result, errMsg, errCode = nixio.fs.symlink(linkTarget, destPath)
    elseif fileType == "reg" then
        -- 处理普通文件：复制文件数据
        result, errMsg, errCode = datacopy(srcPath, destPath)
    end
    
    if not result then
        return nil, errMsg, errCode
    end
    
    -- 复制时间戳（访问时间和修改时间）
    nixio.fs.utimes(destPath, stat.atime, stat.mtime)
    
    -- 复制所有者信息（如果系统支持 lchown）
    if nixio.fs.lchown then
        nixio.fs.lchown(destPath, stat.uid, stat.gid)
    end
    
    -- 复制权限（符号链接除外）
    if fileType ~= "lnk" then
        nixio.fs.chmod(destPath, stat.modedec)
    end
    
    return true
end

-- 移动文件或目录
-- @param srcPath string - 源路径
-- @param destPath string - 目标路径
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function move(srcPath, destPath)
    -- 首先尝试直接重命名（同一文件系统内最高效）
    local result, errMsg, errCode = nixio.fs.rename(srcPath, destPath)
    
    if not result then
        -- 如果失败且错误是跨设备（EXDEV），则先复制再删除
        if errMsg == nixio.const.EXDEV then
            result, errMsg, errCode = copy(srcPath, destPath)
            if result then
                result, errMsg, errCode = nixio.fs.unlink(srcPath)
            end
        end
    end
    
    return result, errMsg, errCode
end

-- 递归创建目录
-- @param path string - 目录路径
-- @param mode number - 可选，目录权限模式
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function mkdirr(path, mode)
    -- 如果目录已存在，直接返回成功
    local fileType = nixio.fs.stat(path, "type")
    if fileType == "dir" then
        return true
    end
    
    -- 尝试创建目录
    local result, errMsg, errCode = nixio.fs.mkdir(path, mode)
    
    if not result then
        -- 如果父目录不存在（ENOENT），则递归创建父目录
        if errMsg == nixio.const.ENOENT then
            local parentPath = nixio.fs.dirname(path)
            result, errMsg, errCode = mkdirr(parentPath, mode)
            if result then
                -- 父目录创建成功后，再创建当前目录
                result, errMsg, errCode = nixio.fs.mkdir(path, mode)
            end
        end
    end
    
    return result, errMsg, errCode
end

-- 递归遍历目录并执行操作的内部函数
-- @param callback function - 对每个文件/目录执行的回调函数
-- @param srcPath string - 源目录路径
-- @param destPath string - 可选，目标目录路径（用于复制/移动）
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
local function recurse(callback, srcPath, destPath)
    local fileType = nixio.fs.lstat(srcPath, "type")
    
    -- 如果不是目录，直接执行回调
    if fileType ~= "dir" then
        return callback(srcPath, destPath)
    end
    
    local result = true
    local sep = nixio.const.sep
    local lastErrMsg, lastErrCode = nil, nil
    
    -- 如果有目标路径，先对当前目录执行回调（创建目标目录）
    if destPath then
        local ok, errMsg, errCode = recurse(callback, srcPath, destPath)
        if not ok and result then
            result = false
            lastErrMsg = errMsg
            lastErrCode = errCode
        end
    end
    
    -- 遍历目录中的所有条目
    for entry in nixio.fs.dir(srcPath) do
        local srcEntry = srcPath .. sep .. entry
        local ok, errMsg, errCode
        
        if destPath then
            local destEntry = destPath .. sep .. entry
            ok, errMsg, errCode = recurse(callback, srcEntry, destEntry)
        else
            ok, errMsg, errCode = recurse(callback, srcEntry)
        end
        
        -- 记录第一个错误，但继续处理其他条目
        if not ok and result then
            result = false
            lastErrMsg = errMsg
            lastErrCode = errCode
        end
    end
    
    -- 如果没有目标路径，最后对当前目录执行回调（用于删除空目录）
    if not destPath then
        local ok, errMsg, errCode = callback(srcPath)
        if not ok and result then
            result = false
            lastErrMsg = errMsg
            lastErrCode = errCode
        end
    end
    
    return result, lastErrMsg, lastErrCode
end

-- 递归复制目录
-- @param srcPath string - 源目录路径
-- @param destPath string - 目标目录路径
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function copyr(srcPath, destPath)
    return recurse(copy, srcPath, destPath)
end

-- 递归移动目录
-- @param srcPath string - 源目录路径
-- @param destPath string - 目标目录路径
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function mover(srcPath, destPath)
    -- 首先尝试直接重命名
    local result, errMsg, errCode = nixio.fs.rename(srcPath, destPath)
    
    if not result then
        -- 如果跨设备，则递归复制后递归删除
        if errMsg == nixio.const.EXDEV then
            result, errMsg, errCode = recurse(copy, srcPath, destPath)
            if result then
                result, errMsg, errCode = recurse(nixio.fs.remove, srcPath)
            end
        end
    end
    
    return result, errMsg, errCode
end

-- 递归删除目录
-- @param path string - 要删除的目录路径
-- @return boolean|nil - 成功返回 true，失败返回 nil
-- @return string|nil - 错误信息
-- @return number|nil - 错误码
function remover(path)
    return recurse(nixio.fs.remove, path)
end
