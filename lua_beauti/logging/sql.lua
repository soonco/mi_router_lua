--[[
    SQL数据库日志输出模块 (SQL Database Logging Appender)
    
    功能说明:
    - 将日志消息存储到SQL数据库
    - 支持自定义表名和字段名
    - 支持连接保持(keepalive)模式以提高性能
    - 自动处理SQL注入(转义单引号)
    
    使用示例:
    local logging = require("logging")
    require("logging.sql")
    
    -- 使用LuaSQL连接MySQL
    local luasql = require("luasql.mysql")
    local env = luasql.mysql()
    
    local logger = logging.sql({
        connectionfactory = function()
            return env:connect("database", "user", "password", "host")
        end,
        tablename = "logs",
        keepalive = true
    })
    logger:info("应用程序启动")
    
    依赖模块:
    - logging: 日志框架主模块
    - 需要用户提供数据库连接工厂函数
]]

local logging = require("logging")

--[[
    创建SQL日志器
    
    @param params table 配置参数
        - connectionfactory: function 数据库连接工厂函数(必需)
        - tablename: string 日志表名(默认"LogTable")
        - logdatefield: string 日期字段名(默认"LogDate")
        - loglevelfield: string 级别字段名(默认"LogLevel")
        - logmessagefield: string 消息字段名(默认"LogMessage")
        - keepalive: boolean 是否保持连接(默认false)
    @return table|nil 日志器对象，失败返回nil和错误信息
]]
function logging.sql(params)
    -- 初始化默认参数
    if not params then
        params = {}
    end
    
    -- 设置默认表名和字段名
    params.tablename = params.tablename or "LogTable"
    params.logdatefield = params.logdatefield or "LogDate"
    params.loglevelfield = params.loglevelfield or "LogLevel"
    params.logmessagefield = params.logmessagefield or "LogMessage"
    
    -- 验证连接工厂函数
    if params.connectionfactory == nil or type(params.connectionfactory) ~= "function" then
        return nil, "No specified connection factory function"
    end
    
    -- 数据库连接和错误信息
    local connection = nil
    local connection_error = nil
    
    -- 如果启用keepalive，预先建立连接
    if params.keepalive then
        connection, connection_error = params.connectionfactory()
    end
    
    return logging.new(function(self, level, message)
        -- 如果未启用keepalive或连接不存在，创建新连接
        if not params.keepalive or connection == nil then
            connection, connection_error = params.connectionfactory()
            
            if not connection then
                return nil, connection_error
            end
        end
        
        -- 获取当前时间
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        
        -- 转义消息中的单引号，防止SQL注入
        local escaped_message = string.gsub(message, "'", "''")
        
        -- 构建INSERT语句
        local sql = string.format(
            "INSERT INTO %s (%s, %s, %s) VALUES ('%s', '%s', '%s')",
            params.tablename,
            params.logdatefield,
            params.loglevelfield,
            params.logmessagefield,
            timestamp,
            level,
            escaped_message
        )
        
        -- 尝试执行SQL
        local ok, err = pcall(connection.execute, connection, sql)
        
        if not ok then
            -- 执行失败，尝试重新连接
            connection, err = params.connectionfactory()
            
            if not connection then
                return nil, err
            end
            
            -- 重试执行
            ok, err = connection:execute(sql)
            
            if not ok then
                return nil, err
            end
        end
        
        -- 如果未启用keepalive，关闭连接
        if not params.keepalive then
            connection:close()
        end
        
        return true
    end)
end

return logging.sql
