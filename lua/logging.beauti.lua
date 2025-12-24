--[[
    LuaLogging 日志框架主模块 (Main Logging Module)
    
    功能说明:
    - 提供简单的日志API用于Lua应用程序
    - 定义标准日志级别: DEBUG, INFO, WARN, ERROR, FATAL
    - 提供日志器工厂函数和消息格式化功能
    - 支持多种日志输出后端(console, file, email, socket, sql等)
    
    版本信息:
    - 版权: Copyright (C) 2004-2013 Kepler Project
    - 版本: LuaLogging 1.3.0
    
    使用示例:
    local logging = require("logging")
    local logger = logging.console()
    logger:info("这是一条信息日志")
    logger:error("这是一条错误日志")
]]

local type = type
local table = table
local string = string
local tostring = tostring
local tonumber = tonumber
local select = select
local error = error
local format = string.format
local pairs = pairs
local ipairs = ipairs

-- 模块表
local logging = {}

-- 版本和版权信息
logging._COPYRIGHT = "Copyright (C) 2004-2013 Kepler Project"
logging._DESCRIPTION = "A simple API to use logging features in Lua"
logging._VERSION = "LuaLogging 1.3.0"

-- 日志级别常量
logging.DEBUG = "DEBUG"  -- 调试级别
logging.INFO = "INFO"    -- 信息级别
logging.WARN = "WARN"    -- 警告级别
logging.ERROR = "ERROR"  -- 错误级别
logging.FATAL = "FATAL"  -- 致命错误级别

-- 日志级别列表(按优先级排序)
local LEVEL_LIST = {
    [1] = "DEBUG",
    [2] = "INFO",
    [3] = "WARN",
    [4] = "ERROR",
    [5] = "FATAL"
}

-- 建立级别名称到数字的映射
local level_count = #LEVEL_LIST
for i = 1, level_count do
    LEVEL_LIST[LEVEL_LIST[i]] = i
end

--[[
    创建新的日志器实例
    
    @param append_func function 实际写入日志的函数
    @return table 日志器对象
]]
function logging.new(append_func)
    local logger = {}
    local current_level = logging.DEBUG
    
    -- 为每个日志级别创建便捷方法
    for i, level_name in ipairs(LEVEL_LIST) do
        logger[string.lower(level_name)] = function(self, ...)
            return logger:log(level_name, ...)
        end
    end
    
    --[[
        记录日志消息
        
        @param level string 日志级别
        @param message string 日志消息
        @return boolean 是否成功
    ]]
    function logger:log(level, message)
        local level_num = LEVEL_LIST[level]
        local current_num = LEVEL_LIST[current_level]
        
        if level_num >= current_num then
            return append_func(self, level, message)
        end
        return true
    end
    
    --[[
        设置日志级别
        
        @param level string 新的日志级别
    ]]
    function logger:setLevel(level)
        current_level = level
    end
    
    return logger
end

--[[
    准备日志消息格式
    
    @param pattern string 消息格式模板
    @param date string 日期字符串
    @param level string 日志级别
    @param message string 日志消息
    @return string 格式化后的日志消息
]]
function logging.prepareLogMsg(pattern, date, level, message)
    local msg = pattern or "%date %level %message\n"
    msg = string.gsub(msg, "%%date", date)
    msg = string.gsub(msg, "%%level", level)
    msg = string.gsub(msg, "%%message", tostring(message))
    return msg
end

--[[
    将值转换为字符串(支持表的递归转换)
    
    @param value any 要转换的值
    @return string 字符串表示
]]
function logging.tostring(value)
    local t = type(value)
    if t == "table" then
        local result = "{"
        local first = true
        for k, v in pairs(value) do
            if not first then
                result = result .. ", "
            end
            result = result .. tostring(k) .. "=" .. logging.tostring(v)
            first = false
        end
        return result .. "}"
    else
        return tostring(value)
    end
end

-- 兼容Lua 5.1: 注册到全局表
if _VERSION ~= "Lua 5.2" then
    _G.logging = logging
end

return logging
