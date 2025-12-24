--[[
    控制台日志输出模块 (Console Logging Appender)
    
    功能说明:
    - 将日志消息输出到标准输出(stdout)
    - 最简单的日志输出方式，适合开发调试
    
    使用示例:
    local logging = require("logging")
    require("logging.console")
    local logger = logging.console()
    logger:info("Hello World")
    
    依赖模块:
    - logging: 日志框架主模块
]]

local logging = require("logging")

--[[
    创建控制台日志器
    
    @param log_pattern string 可选，日志格式模板
    @return table 日志器对象
]]
function logging.console(log_pattern)
    return logging.new(function(self, level, message)
        -- 格式化日志消息
        local formatted_msg = logging.prepareLogMsg(
            log_pattern,
            os.date(),
            level,
            message
        )
        
        -- 写入标准输出
        io.stdout:write(formatted_msg)
        
        return true
    end)
end

return logging.console
