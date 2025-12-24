--[[
    Socket日志输出模块 (Socket Logging Appender)
    
    功能说明:
    - 通过TCP Socket将日志消息发送到远程服务器
    - 每条日志消息建立一次连接，发送后关闭
    - 适合将日志集中发送到日志收集服务器
    
    使用示例:
    local logging = require("logging")
    require("logging.socket")
    local logger = logging.socket("logserver.example.com", 514, "%date %level %message\n")
    logger:info("应用程序启动")
    
    依赖模块:
    - logging: 日志框架主模块
    - socket: LuaSocket网络库
]]

local logging = require("logging")
local socket = require("socket")

--[[
    创建Socket日志器
    
    @param host string 目标服务器地址
    @param port number 目标服务器端口
    @param log_pattern string 日志消息格式模板
    @return table 日志器对象
]]
function logging.socket(host, port, log_pattern)
    return logging.new(function(self, level, message)
        -- 格式化日志消息
        local formatted_msg = logging.prepareLogMsg(
            log_pattern,
            os.date(),
            level,
            message
        )
        
        -- 建立TCP连接
        local conn, err = socket.connect(host, port)
        if not conn then
            return nil, err
        end
        
        -- 发送日志消息
        local ok, send_err = conn:send(formatted_msg)
        if not ok then
            return nil, send_err
        end
        
        -- 关闭连接
        conn:close()
        
        return true
    end)
end

return logging.socket
