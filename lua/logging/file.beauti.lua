--[[
    文件日志输出模块 (File Logging Appender)
    
    功能说明:
    - 将日志消息写入到指定文件
    - 支持动态文件名(包含日期等)
    - 使用行缓冲模式确保日志及时写入
    
    使用示例:
    local logging = require("logging")
    require("logging.file")
    local logger = logging.file("app_%Y-%m-%d.log", "%date %level %message\n")
    logger:info("应用程序启动")
    
    依赖模块:
    - logging: 日志框架主模块
]]

local logging = require("logging")

-- 模块级变量: 当前文件名和文件句柄
local current_filename = nil
local current_file = nil

--[[
    打开日志文件(内部函数)
    
    支持动态文件名，文件名中可包含strftime格式的日期占位符
    例如: "app_%Y-%m-%d.log" 会生成 "app_2024-01-15.log"
    
    @param filename_pattern string 文件名模板
    @param date_pattern string 日期格式(传给os.date)
    @return file|nil 文件句柄，失败返回nil和错误信息
]]
local function open_file(filename_pattern, date_pattern)
    -- 根据日期格式化文件名
    local filename = string.format(filename_pattern, os.date(date_pattern))
    
    -- 如果文件名没变，直接返回当前文件句柄
    if current_filename == filename then
        return current_file
    end
    
    -- 打开新文件(追加模式)
    local file = io.open(filename, "a")
    if file then
        -- 设置行缓冲模式，确保每行日志及时写入
        file:setvbuf("line")
        -- 更新模块级变量
        current_filename = filename
        current_file = file
        return file
    else
        return nil, string.format("file `%s' could not be opened for writing", filename)
    end
end

--[[
    创建文件日志器
    
    @param filename string 日志文件名(支持日期格式化占位符)
    @param log_pattern string 日志消息格式模板
    @param date_pattern string 文件名中日期的格式
    @return table 日志器对象
]]
function logging.file(filename, log_pattern, date_pattern)
    -- 默认文件名
    if type(filename) ~= "string" then
        filename = "lualogging.log"
    end
    
    return logging.new(function(self, level, message)
        -- 打开或获取日志文件
        local file, err = open_file(filename, date_pattern)
        if not file then
            return nil, err
        end
        
        -- 格式化并写入日志消息
        local formatted_msg = logging.prepareLogMsg(
            log_pattern,
            os.date(),
            level,
            message
        )
        
        file:write(formatted_msg)
        
        return true
    end)
end

return logging.file
