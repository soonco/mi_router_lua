--[[
    LuCI 字节码缓存模块 (Bytecode Cache Module)
    
    功能说明:
    - 将Lua源文件编译为字节码并缓存，提高加载速度
    - 支持按需缓存模式，首次加载时自动编译
    - 缓存文件存储在指定目录，使用十六进制编码的文件名
    - 包含安全检查，确保缓存文件的所有者和权限正确
    
    工作原理:
    1. 替换package.loaders[2]为自定义加载器
    2. 加载模块时先检查缓存是否存在
    3. 如果缓存存在且有效，直接加载字节码
    4. 如果缓存不存在，使用原始加载器加载后缓存字节码
    
    依赖模块:
    - io: 输入输出
    - nixio.fs: 文件系统操作
    - luci.util: 工具函数
    - nixio: 系统调用
    - debug: 调试信息
    - string: 字符串操作
    - package: 包管理
]]

local io = require("io")
local nixio_fs = require("nixio.fs")
local util = require("luci.util")
local nixio = require("nixio")
local debug = require("debug")
local string = require("string")
local package = require("package")

local type = type
local loadfile = loadfile

module("luci.ccache")

--[[
    按需启用缓存
    
    仅当从实际文件加载时才启用缓存
    (排除从字符串或其他来源加载的情况)
    
    @param cache_dir string 缓存目录路径(可选)
    @param file_mode string 缓存文件权限模式(可选)
]]
function cache_ondemand(...)
    -- 获取调用者的源信息
    local info = debug.getinfo(1, "S")
    local source = info.source
    
    -- 只有从实际文件加载时才启用缓存
    -- "=?" 表示从非文件来源加载
    if source ~= "=?" then
        cache_enable(...)
    end
end

--[[
    启用字节码缓存
    
    替换默认的模块加载器，实现字节码缓存功能
    
    @param cache_dir string 缓存目录路径，默认"/tmp/luci-cache"
    @param file_mode string 缓存文件权限模式，默认"rw-------"
]]
function cache_enable(cache_dir, file_mode)
    -- 设置默认值
    cache_dir = cache_dir or "/tmp/luci-cache"
    file_mode = file_mode or "rw-------"
    
    -- 保存原始的模块加载器
    local original_loader = package.loaders[2]
    
    -- 获取当前用户ID(用于安全检查)
    local current_uid = nixio.getuid()
    
    -- 确保缓存目录存在
    if not nixio_fs.stat(cache_dir) then
        nixio_fs.mkdir(cache_dir)
    end
    
    --[[
        将模块名转换为十六进制编码的文件名
        
        @param module_name string 模块名
        @return string 十六进制编码的文件名
    ]]
    local function encode_filename(module_name)
        local result = ""
        for i = 1, #module_name do
            local byte = string.byte(module_name, i)
            result = result .. ("%2X" % byte)
        end
        return result
    end
    
    --[[
        安全加载缓存文件
        
        验证文件所有者和权限后再加载
        
        @param cache_path string 缓存文件路径
        @return function|nil 加载成功返回函数，否则返回nil
    ]]
    local function safe_load_cache(cache_path)
        local stat = nixio_fs.stat(cache_path)
        
        if stat then
            -- 验证文件所有者是当前用户
            if stat.uid == current_uid then
                -- 验证文件权限正确
                if stat.modestr == file_mode then
                    -- 安全检查通过，加载字节码
                    return loadfile(cache_path)
                end
            end
        end
        
        return nil
    end
    
    --[[
        写入缓存文件
        
        将函数的字节码写入缓存文件
        
        @param cache_path string 缓存文件路径
        @param func function 要缓存的函数
    ]]
    local function write_cache(cache_path, func)
        -- 只有当前用户是root时才写入缓存
        if nixio.getuid() == current_uid then
            local file = io.open(cache_path, "w")
            
            if file then
                -- 获取函数的字节码并写入
                file:write(util.get_bytecode(func))
                file:close()
                
                -- 设置正确的文件权限
                nixio_fs.chmod(cache_path, file_mode)
            end
        end
    end
    
    --[[
        自定义模块加载器
        
        先尝试从缓存加载，失败则使用原始加载器并缓存结果
        
        @param module_name string 模块名
        @return function|string 模块加载函数或错误信息
    ]]
    local function cached_loader(module_name)
        -- 构建缓存文件路径
        local cache_path = cache_dir .. "/" .. encode_filename(module_name)
        
        -- 尝试从缓存加载
        local cached_func = safe_load_cache(cache_path)
        if cached_func then
            return cached_func
        end
        
        -- 使用原始加载器加载模块
        local loaded = original_loader(module_name)
        
        -- 如果加载成功且返回函数，则缓存字节码
        if type(loaded) == "function" then
            write_cache(cache_path, loaded)
        end
        
        return loaded
    end
    
    -- 替换默认加载器
    package.loaders[2] = cached_loader
end
