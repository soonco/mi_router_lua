--[[
LuCI OPKG包管理模块 (luci.model.ipkg)

本模块封装了OPKG (Open Package Management) 命令行工具，
提供Lua接口用于软件包的查询、安装、卸载等操作。

主要功能:
- info(): 获取软件包详细信息
- status(): 获取已安装软件包状态
- install(): 安装软件包
- installed(): 检查软件包是否已安装
- remove(): 卸载软件包
- update(): 更新软件包列表
- upgrade(): 升级所有软件包
- list_all(): 列出所有可用软件包
- list_installed(): 列出已安装软件包
- find(): 搜索软件包
- overlay_root(): 获取overlay根目录

依赖模块:
- os: 系统操作
- io: 文件IO
- nixio.fs: 文件系统操作
- luci.util: LuCI工具函数

作者: LuCI开发团队
]]--

local os = require("os")
local io = require("io")
local nixio_fs = require("nixio.fs")
local util = require("luci.util")

local type = type
local pairs = pairs
local error = error
local table = table

-- OPKG命令行基础参数
-- --force-removal-of-dependent-packages: 强制移除依赖包
-- --force-overwrite: 强制覆盖已存在文件
-- --nocase: 搜索时忽略大小写
local OPKG_CMD = "opkg --force-removal-of-dependent-packages --force-overwrite --nocase"

-- OPKG配置文件路径
local OPKG_CONF = "/etc/opkg.conf"

module("luci.model.ipkg")

-- 执行OPKG命令(内部函数)
-- @param action OPKG动作(如install, remove等)
-- @param ... 额外参数
-- @return 返回码, 标准输出, 标准错误
local function _call(action, ...)
    local args = ""
    
    -- 构建参数字符串，转义单引号
    for _, arg in ipairs({...}) do
        local safe_arg = arg:gsub("'", "")
        args = args .. " '" .. safe_arg .. "'"
    end
    
    -- 构建完整命令
    local cmd = OPKG_CMD .. " " .. action .. args
    
    -- 执行命令，重定向输出到临时文件
    local stderr_file = "/tmp/opkg.stderr"
    local stdout_file = "/tmp/opkg.stdout"
    
    local ret = os.execute(cmd .. " >" .. stdout_file .. " 2>" .. stderr_file)
    
    -- 读取输出
    local stdout = nixio_fs.readfile(stdout_file) or ""
    local stderr = nixio_fs.readfile(stderr_file) or ""
    
    -- 清理临时文件
    nixio_fs.unlink(stderr_file)
    nixio_fs.unlink(stdout_file)
    
    return ret, stdout, stderr
end

-- 解析OPKG输出为软件包信息表
-- @param rawdata 行迭代器函数
-- @return 软件包信息表 {包名 = {Package, Version, Status, ...}, ...}
local function _parse_info(rawdata)
    if type(rawdata) ~= "function" then
        error("OPKG: Invalid rawdata given")
    end
    
    local packages = {}
    local current_pkg = {}
    local last_field = nil
    
    for line in rawdata do
        -- 检查是否是续行(以空格开头)
        local first_char = line:sub(1, 1)
        
        if first_char ~= " " then
            -- 解析 "Field: Value" 格式
            local field, value = line:match("^([^:]+):%s*(.*)$")
            
            if field and value then
                if field == "Package" then
                    -- 新软件包开始
                    current_pkg = { Package = value }
                    packages[value] = current_pkg
                elseif field == "Status" then
                    -- 状态字段特殊处理，解析为表
                    current_pkg.Status = {}
                    for status_flag in value:gmatch("%S+") do
                        current_pkg.Status[status_flag] = true
                    end
                else
                    current_pkg[field] = value
                end
                last_field = field
            end
        else
            -- 续行: 追加到上一个字段
            if last_field and current_pkg[last_field] then
                current_pkg[last_field] = current_pkg[last_field] .. "\n" .. line
            end
        end
    end
    
    return packages
end

-- 执行OPKG命令并解析输出
-- @param action OPKG动作
-- @param pkg 软件包名(可选)
-- @return 软件包信息表
local function _info_call(action, pkg)
    local cmd = OPKG_CMD .. " " .. action
    
    if pkg then
        local safe_pkg = pkg:gsub("'", "")
        cmd = cmd .. " '" .. safe_pkg .. "'"
    end
    
    -- 执行命令并获取输出
    local tmpfile = os.tmpname()
    os.execute(cmd .. " >" .. tmpfile .. " 2>/dev/null")
    
    local result = _parse_info(io.lines(tmpfile))
    os.remove(tmpfile)
    
    return result
end

-- 获取软件包详细信息
-- @param pkg 软件包名(可选，nil则返回所有)
-- @return 软件包信息表
function info(pkg)
    return _info_call("info", pkg)
end

-- 获取已安装软件包状态
-- @param pkg 软件包名(可选，nil则返回所有)
-- @return 软件包状态表
function status(pkg)
    return _info_call("status", pkg)
end

-- 安装软件包
-- @param ... 软件包名列表
-- @return 返回码, 标准输出, 标准错误
function install(...)
    return _call("install", ...)
end

-- 检查软件包是否已安装
-- @param pkg 软件包名
-- @return true表示已安装，false表示未安装
function installed(pkg)
    local pkg_status = status(pkg)
    local pkg_info = pkg_status[pkg]
    
    if pkg_info then
        if pkg_info.Status then
            return pkg_info.Status.installed
        end
    end
    
    return false
end

-- 卸载软件包
-- @param ... 软件包名列表
-- @return 返回码, 标准输出, 标准错误
function remove(...)
    return _call("remove", ...)
end

-- 更新软件包列表
-- 从配置的源下载最新的软件包索引
-- @return 返回码, 标准输出, 标准错误
function update()
    return _call("update")
end

-- 升级所有可升级的软件包
-- @return 返回码, 标准输出, 标准错误
function upgrade()
    return _call("upgrade")
end

-- 列出软件包(内部函数)
-- 解析 "包名 - 版本 - 描述" 格式的输出
-- @param action OPKG动作(list, list_installed, find)
-- @param pattern 搜索模式(可选)
-- @param callback 回调函数(name, version, description)
local function _list(action, pattern, callback)
    local cmd = OPKG_CMD .. " " .. action
    
    if pattern then
        local safe_pattern = pattern:gsub("'", "")
        cmd = cmd .. " '" .. safe_pattern .. "'"
    end
    
    local pipe = io.popen(cmd)
    
    if pipe then
        local name, version, description
        
        while true do
            local line = pipe:read("*l")
            if not line then
                break
            end
            
            -- 尝试解析 "name - version - description" 格式
            name, version, description = line:match("^(.-) %- (.-) %- (.+)")
            
            if not name then
                -- 尝试解析 "name - version" 格式(无描述)
                name, version = line:match("^(.-) %- (.+)")
                description = ""
            end
            
            -- 调用回调函数
            callback(name, version, description)
            
            name, version, description = nil, nil, nil
        end
        
        pipe:close()
    end
end

-- 列出所有可用软件包
-- @param pattern 搜索模式(可选)
-- @param callback 回调函数(name, version, description)
function list_all(pattern, callback)
    _list("list", pattern, callback)
end

-- 列出已安装软件包
-- @param pattern 搜索模式(可选)
-- @param callback 回调函数(name, version, description)
function list_installed(pattern, callback)
    _list("list_installed", pattern, callback)
end

-- 搜索软件包
-- @param pattern 搜索模式
-- @param callback 回调函数(name, version, description)
function find(pattern, callback)
    _list("find", pattern, callback)
end

-- 获取overlay根目录
-- 从opkg.conf读取overlay_root配置
-- @return overlay根目录路径，默认为"/"
function overlay_root()
    local root = "/"
    
    local conf_file = io.open(OPKG_CONF, "r")
    
    if conf_file then
        local line
        
        repeat
            line = conf_file:read("*l")
            
            if line then
                -- 检查是否是overlay_root配置行
                if line:match("^%s*option%s+overlay_root%s+") then
                    -- 提取路径值
                    root = line:match("^%s*option%s+overlay_root%s+(%S+)")
                    
                    -- 验证路径是否存在且是目录
                    local stat = nixio_fs.stat(root)
                    if stat then
                        if stat.type == "dir" then
                            break
                        end
                    end
                    
                    -- 路径无效，重置为默认值
                    root = "/"
                    break
                end
            end
        until not line
        
        conf_file:close()
    end
    
    return root
end
