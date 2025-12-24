--[[
    滚动文件日志输出模块 (Rolling File Logging Appender)
    
    功能说明:
    - 将日志消息写入文件，当文件达到指定大小时自动滚动
    - 支持设置最大文件大小和保留的历史文件数量
    - 滚动时会将旧文件重命名为 filename.1, filename.2 等
    
    使用示例:
    local logging = require("logging")
    require("logging.rolling_file")
    -- 创建滚动日志器: 文件名, 最大10MB, 保留5个历史文件
    local logger = logging.rolling_file("app.log", 10*1024*1024, 5)
    logger:info("应用程序启动")
    
    依赖模块:
    - logging: 日志框架主模块
]]

local logging = require("logging")

--[[
    打开日志文件(内部函数)
    
    @param config table 日志配置对象
    @return file|nil 文件句柄，失败返回nil和错误信息
]]
local function open_file(config)
    -- 以追加模式打开文件
    config.file = io.open(config.filename, "a")
    
    if not config.file then
        return nil, string.format("file `%s' could not be opened for writing", config.filename)
    end
    
    -- 设置行缓冲模式
    config.file:setvbuf("line")
    
    return config.file
end

--[[
    执行日志文件滚动(内部函数)
    
    滚动逻辑:
    1. 将 filename.N-1 重命名为 filename.N (从最大索引开始)
    2. 将 filename 重命名为 filename.1
    3. 创建新的 filename 文件
    
    @param config table 日志配置对象
    @return file|nil 新文件句柄，失败返回nil和错误信息
]]
local function rollover(config)
    -- 从最大索引向下滚动文件
    for i = config.maxIndex - 1, 1, -1 do
        os.rename(
            config.filename .. "." .. i,
            config.filename .. "." .. (i + 1)
        )
    end
    
    -- 关闭当前文件
    if config.file then
        config.file:close()
    end
    config.file = nil
    
    -- 将当前文件重命名为 .1
    local ok, err = os.rename(config.filename, config.filename .. ".1")
    if err then
        return nil, string.format("error %s on log rollover", err)
    end
    
    -- 打开新文件
    return open_file(config)
end

--[[
    获取可写的日志文件(内部函数)
    
    检查当前文件大小，如果超过限制则执行滚动
    
    @param config table 日志配置对象
    @return file|nil 文件句柄，失败返回nil和错误信息
]]
local function get_writable_file(config)
    -- 如果文件未打开，先打开
    if not config.file then
        return open_file(config)
    end
    
    -- 检查当前文件大小
    local current_size = config.file:seek("end", 0)
    
    -- 如果未超过最大大小，直接返回当前文件
    if current_size < config.maxSize then
        return config.file
    end
    
    -- 执行滚动
    return rollover(config)
end

--[[
    创建滚动文件日志器
    
    @param filename string 日志文件名
    @param max_size number 单个文件最大字节数
    @param max_index number 保留的历史文件数量(默认1)
    @param log_pattern string 日志消息格式模板
    @return table 日志器对象
]]
function logging.rolling_file(filename, max_size, max_index, log_pattern)
    -- 默认文件名
    if type(filename) ~= "string" then
        filename = "lualogging.log"
    end
    
    -- 创建配置对象
    local config = {
        filename = filename,
        maxSize = max_size,
        maxIndex = max_index or 1,
        file = nil
    }
    
    return logging.new(function(self, level, message)
        -- 获取可写的文件句柄
        local file, err = get_writable_file(config)
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

return logging.rolling_file
