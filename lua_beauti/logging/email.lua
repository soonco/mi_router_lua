--[[
    邮件日志输出模块 (Email Logging Appender)
    
    功能说明:
    - 通过SMTP协议发送日志消息到指定邮箱
    - 支持自定义邮件头和主题
    - 适合发送重要告警通知
    
    使用示例:
    local logging = require("logging")
    require("logging.email")
    local logger = logging.email({
        from = "sender@example.com",
        rcpt = "receiver@example.com",
        server = "smtp.example.com",
        headers = {
            subject = "[Alert] %level - %message"
        }
    })
    logger:error("系统发生严重错误")
    
    依赖模块:
    - logging: 日志框架主模块
    - socket.smtp: LuaSocket SMTP模块
]]

local logging = require("logging")
local smtp = require("socket.smtp")

--[[
    创建邮件日志器
    
    @param params table 配置参数
        - from: string 发件人地址(必需)
        - rcpt: string|table 收件人地址(必需)
        - server: string SMTP服务器地址
        - user: string SMTP用户名
        - password: string SMTP密码
        - headers: table 邮件头
            - subject: string 邮件主题(支持格式化)
        - logPattern: string 日志格式模板
    @return table|nil 日志器对象，失败返回nil和错误信息
]]
function logging.email(params)
    -- 初始化默认参数
    if not params then
        params = {}
    end
    
    -- 初始化邮件头
    params.headers = params.headers or {}
    
    -- 验证必需参数
    if params.from == nil then
        return nil, "'from' parameter is required"
    end
    
    if params.rcpt == nil then
        return nil, "'rcpt' parameter is required"
    end
    
    return logging.new(function(self, level, message)
        -- 格式化日志消息作为邮件正文
        local body = logging.prepareLogMsg(
            params.logPattern,
            os.date(),
            level,
            message
        )
        
        -- 处理邮件主题(如果包含格式化占位符)
        if params.headers.subject then
            params.headers.subject = logging.prepareLogMsg(
                params.headers.subject,
                os.date(),
                level,
                message
            )
        end
        
        -- 构建邮件消息
        local mail_message = {
            headers = params.headers,
            body = body
        }
        
        -- 设置消息源
        params.source = smtp.message(mail_message)
        
        -- 发送邮件
        local ok, err = smtp.send(params)
        if not ok then
            return nil, err
        end
        
        return true
    end)
end

return logging.email
