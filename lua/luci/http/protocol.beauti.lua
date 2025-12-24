--[[
    LuCI HTTP 协议核心模块
    用于处理 HTTP 协议的编解码、消息解析等功能
    
    主要功能:
    - URL 编解码
    - 查询参数解析
    - HTTP 消息头解析
    - 消息体解析（支持 multipart/form-data 和 application/x-www-form-urlencoded）
    - HTTP 状态码映射
]]

module("luci.http.protocol", package.seeall)

local util = require("luci.util")
local ltn12 = require("luci.ltn12")

-- HTTP 请求体最大长度限制（64KB）
HTTP_MAX_CONTENT = 65536

--[[
    URL 解码
    将 URL 编码的字符串转换为原始字符串
    
    @param str 要解码的字符串
    @param no_plus 是否不将 + 转换为空格
    @return 解码后的字符串
]]
function urldecode(str, no_plus)
    local function hex_to_char(hex)
        return string.char(tonumber(hex, 16))
    end
    
    if type(str) == "string" then
        -- 将 + 转换为空格（除非指定不转换）
        if not no_plus then
            str = str:gsub("+", " ")
        end
        
        -- 将 %XX 格式的编码转换为对应字符
        str = str:gsub("%%([a-fA-F0-9][a-fA-F0-9])", hex_to_char)
    end
    
    return str
end

--[[
    解析 URL 编码的查询参数
    
    @param query_string URL 编码的查询字符串
    @param params 可选的参数表，用于存储解析结果
    @return 参数表
]]
function urldecode_params(query_string, params)
    params = params or {}
    
    if not query_string then
        return params
    end
    
    -- 遍历每个 key=value 对
    for pair in query_string:gmatch("[^&;]+") do
        -- 提取键和值
        local key = urldecode(pair:match("^([^=]+)"))
        local value = urldecode(pair:match("^[^=]+=(.+)$"))
        
        if type(key) == "string" and key:len() > 0 then
            -- 如果值不是字符串，设为空字符串
            if type(value) ~= "string" then
                value = ""
            end
            
            -- 处理同名参数（转换为数组）
            if not params[key] then
                params[key] = value
            elseif type(params[key]) ~= "table" then
                params[key] = { params[key], value }
            else
                table.insert(params[key], value)
            end
        end
    end
    
    return params
end

--[[
    URL 编码
    将特殊字符转换为 %XX 格式
    
    @param str 要编码的字符串
    @return 编码后的字符串
]]
function urlencode(str)
    local function char_to_hex(char)
        return string.format("%%%02x", string.byte(char))
    end
    
    if type(str) == "string" then
        -- 对非安全字符进行编码
        str = str:gsub("([^a-zA-Z0-9$_%-%.%+!*'(),])", char_to_hex)
    end
    
    return str
end

--[[
    小米定制的 URL 编码
    符合 RFC 3986 规范，空格编码为 +
    
    @param str 要编码的字符串
    @return 编码后的字符串
]]
function xqurlencode(str)
    if str then
        -- 统一换行符为 CRLF
        str = string.gsub(str, "\r?\n", "\r\n")
        
        -- 对非安全字符进行编码（保留 - . _ ~ 和空格）
        str = string.gsub(str, "([^%w%-%.%_%~ ])", function(char)
            return string.format("%%%02X", string.byte(char))
        end)
        
        -- 空格编码为 +
        str = string.gsub(str, " ", "+")
    end
    
    return str
end

--[[
    使用小米定制编码方式编码参数表
    
    @param params 参数表
    @return URL 编码的查询字符串
]]
function xq_urlencode_params(params)
    local result = ""
    
    for key, value in pairs(params) do
        if type(value) == "table" then
            -- 处理数组值
            for _, item in ipairs(value) do
                local separator = (#result > 0) and "&" or ""
                result = result .. separator .. urlencode(key) .. "=" .. xqurlencode(item)
            end
        else
            local separator = (#result > 0) and "&" or ""
            result = result .. separator .. urlencode(key) .. "=" .. xqurlencode(value)
        end
    end
    
    return result
end

--[[
    编码参数表为 URL 查询字符串
    
    @param params 参数表
    @return URL 编码的查询字符串
]]
function urlencode_params(params)
    local result = ""
    
    for key, value in pairs(params) do
        if type(value) == "table" then
            -- 处理数组值
            for _, item in ipairs(value) do
                local separator = (#result > 0) and "&" or ""
                result = result .. separator .. urlencode(key) .. "=" .. urlencode(item)
            end
        else
            local separator = (#result > 0) and "&" or ""
            result = result .. separator .. urlencode(key) .. "=" .. urlencode(value)
        end
    end
    
    return result
end

-- 内部辅助函数：初始化参数值
local function init_param(params, key)
    if params[key] == nil then
        params[key] = ""
    elseif type(params[key]) == "string" then
        params[key] = { params[key], "" }
    else
        table.insert(params[key], "")
    end
end

-- 内部辅助函数：追加参数值
local function append_param(params, key, chunk)
    if type(params[key]) == "table" then
        local last_index = #params[key]
        params[key][last_index] = params[key][last_index] .. chunk
    else
        params[key] = params[key] .. chunk
    end
end

-- 内部辅助函数：完成参数值（应用转换函数）
local function finalize_param(params, key, transform_func)
    if transform_func then
        if type(params[key]) == "table" then
            local last_index = #params[key]
            params[key][last_index] = transform_func(params[key][last_index])
        else
            params[key] = transform_func(params[key])
        end
    end
end

-- HTTP 消息解析状态机
local message_parsers = {}

--[[
    解析 HTTP 请求/响应起始行
    
    @param message 消息对象
    @param line 起始行内容
    @return 成功返回 true 和下一个解析函数，失败返回 nil 和错误信息
]]
function message_parsers.magic(message, line)
    if line ~= nil then
        if #line == 0 then
            return true, nil
        end
        
        -- 尝试解析 HTTP 请求行
        local method, uri, version = line:match("^([A-Z]+) ([^ ]+) HTTP/([01]%.[019])$")
        
        if method then
            message.type = "request"
            message.request_method = method:lower()
            message.request_uri = uri
            message.http_version = tonumber(version)
            message.headers = {}
            
            return true, function(next_line)
                return message_parsers.headers(message, next_line)
            end
        else
            -- 尝试解析 HTTP 响应行
            local resp_version, status_code, status_msg = line:match("^HTTP/([01]%.[019]) ([0-9]+) ([^\r\n]+)$")
            
            if status_code then
                message.type = "response"
                message.status_code = status_code
                message.status_message = status_msg
                message.http_version = tonumber(resp_version)
                message.headers = {}
                
                return true, function(next_line)
                    return message_parsers.headers(message, next_line)
                end
            end
        end
    end
    
    return nil, "Invalid HTTP message magic"
end

--[[
    解析 HTTP 消息头
    
    @param message 消息对象
    @param line 头部行内容
    @return 成功返回 true，头部结束返回 false，失败返回 nil 和错误信息
]]
function message_parsers.headers(message, line)
    if line ~= nil then
        -- 解析头部字段
        local header_name, header_value = line:match("^([A-Za-z][A-Za-z0-9%-_]+): +(.+)$")
        
        if type(header_name) == "string" and header_name:len() > 0 then
            if type(header_value) == "string" and header_value:len() > 0 then
                message.headers[header_name] = header_value
                return true, nil
            end
        else
            -- 空行表示头部结束
            if #line == 0 then
                return false, nil
            else
                return nil, "Invalid HTTP header received"
            end
        end
    else
        return nil, "Unexpected EOF"
    end
end

--[[
    创建 HTTP 头部数据源
    从套接字读取头部行
    
    @param socket 网络套接字
    @return LTN12 数据源
]]
function header_source(socket)
    return ltn12.source.simplify(function()
        local line, err, partial = socket:receive("*l")
        
        if line == nil then
            if err ~= "timeout" then
                local error_msg
                if partial then
                    error_msg = "Line exceeds maximum allowed length"
                else
                    error_msg = "Unexpected EOF"
                end
                return nil, error_msg
            else
                return nil, err
            end
        elseif line ~= nil then
            -- 移除行尾的 CR
            line = line:gsub("\r$", "")
            return line, nil
        end
    end)
end

--[[
    解析 multipart/form-data 格式的消息体
    用于处理文件上传等场景
    
    @param source 数据源
    @param message 消息对象
    @param file_callback 文件数据回调函数
    @return 成功返回 true，失败返回 nil 和错误信息
]]
function mimedecode_message_body(source, message, file_callback)
    -- 提取 MIME boundary
    if message and message.env and message.env.CONTENT_TYPE then
        local boundary = message.env.CONTENT_TYPE:match("^multipart/form%-data; boundary=(.+)$")
        message.mime_boundary = boundary
    end
    
    if not message.mime_boundary then
        return nil, "Invalid Content-Type found"
    end
    
    local content_length = 0
    local in_headers = false
    local buffer = nil
    local current_part = { headers = {} }
    local data_callback = nil
    
    -- 解析 MIME 部分头部
    local function parse_part_headers(data, part)
        -- 解析头部字段
        repeat
            local count
            data, count = data:gsub("^([A-Z][A-Za-z0-9%-_]+): +([^\r\n]+)\r\n", function(name, value)
                part.headers[name] = value
                return ""
            end)
        until count == 0
        
        -- 检查头部结束（空行）
        local header_end_count
        data, header_end_count = data:gsub("^\r\n", "")
        
        if header_end_count > 0 then
            -- 解析 Content-Disposition
            local content_disp = part.headers["Content-Disposition"]
            if content_disp and content_disp:match("^form%-data; ") then
                part.name = content_disp:match('name="(.-)"')
                part.file = content_disp:match('filename="(.+)"$')
            end
            
            -- 设置默认 Content-Type
            if not part.headers["Content-Type"] then
                part.headers["Content-Type"] = "text/plain"
            end
            
            -- 设置数据回调
            if part.name then
                if part.file then
                    -- 文件上传
                    if file_callback then
                        init_param(message.params, part.name)
                        append_param(message.params, part.name, part.file)
                        data_callback = file_callback
                    end
                else
                    -- 普通表单字段
                    init_param(message.params, part.name)
                    data_callback = function(part_info, chunk, eof)
                        append_param(message.params, part_info.name, chunk)
                    end
                end
            else
                data_callback = nil
            end
            
            return data, true
        end
        
        return data, false
    end
    
    -- 数据接收处理函数
    local function receive_data(chunk)
        -- 更新内容长度
        local chunk_len = chunk and #chunk or 0
        content_length = content_length + chunk_len
        
        -- 检查内容长度限制
        if message.env.CONTENT_LENGTH then
            local max_len = tonumber(message.env.CONTENT_LENGTH) + 2
            if content_length > max_len then
                return nil, "Message body size exceeds Content-Length"
            end
        end
        
        -- 处理数据
        if chunk then
            if not buffer then
                buffer = "\r\n" .. chunk
            end
        else
            if buffer then
                buffer = buffer .. (chunk or "")
                
                -- 查找 MIME boundary
                local boundary_pattern = "\r\n--" .. message.mime_boundary .. "\r\n"
                local end_boundary_pattern = "\r\n--" .. message.mime_boundary .. "--\r\n"
                
                repeat
                    local start_pos, end_pos = buffer:find(boundary_pattern, 1, true)
                    
                    if not start_pos then
                        start_pos, end_pos = buffer:find(end_boundary_pattern, 1, true)
                    end
                    
                    if start_pos then
                        -- 提取当前部分的数据
                        local part_data = buffer:sub(1, start_pos - 1)
                        
                        if in_headers then
                            local eof
                            part_data, eof = parse_part_headers(part_data, current_part)
                            
                            if not eof then
                                return nil, "Invalid MIME section header"
                            elseif not current_part.name then
                                return nil, "Invalid Content-Disposition header"
                            end
                        end
                        
                        -- 调用数据回调
                        if data_callback then
                            data_callback(current_part, part_data, true)
                        end
                        
                        -- 准备下一个部分
                        current_part = { headers = {} }
                        
                        -- 解析下一个部分的头部
                        local remaining = buffer:sub(end_pos + 1)
                        local eof
                        remaining, eof = parse_part_headers(remaining, current_part)
                        buffer = remaining
                        in_headers = not eof
                    end
                until not start_pos
                
                -- 处理剩余数据
                if in_headers then
                    local eof
                    buffer, eof = parse_part_headers(buffer, current_part)
                    in_headers = not eof
                else
                    if data_callback then
                        data_callback(current_part, buffer, false)
                    end
                    buffer = chunk
                end
            end
        end
        
        return true
    end
    
    return ltn12.pump.all(source, receive_data)
end

--[[
    解析 application/x-www-form-urlencoded 格式的消息体
    
    @param source 数据源
    @param message 消息对象
    @return 成功返回 true，失败返回 nil 和错误信息
]]
function urldecode_message_body(source, message)
    local content_length = 0
    local buffer = nil
    
    local function receive_data(chunk)
        -- 更新内容长度
        local chunk_len = chunk and #chunk or 0
        content_length = content_length + chunk_len
        
        -- 检查内容长度限制
        if message.env.CONTENT_LENGTH then
            local max_len = tonumber(message.env.CONTENT_LENGTH) + 2
            if content_length > max_len then
                return nil, "Message body size exceeds Content-Length"
            end
        else
            if content_length > HTTP_MAX_CONTENT then
                return nil, "Message body size exceeds maximum allowed length"
            end
        end
        
        -- 处理数据
        if not buffer and chunk then
            buffer = chunk
        elseif buffer then
            buffer = buffer .. (chunk or "&")
            
            -- 解析参数对
            repeat
                local start_pos, end_pos = buffer:find("^.-[;&]")
                
                if start_pos then
                    local pair = buffer:sub(start_pos, end_pos - 1)
                    local key = pair:match("^(.-)=")
                    local value = pair:match("=([^%s]*)%s*$")
                    
                    if key and #key > 0 then
                        init_param(message.params, key)
                        append_param(message.params, key, value)
                        finalize_param(message.params, key, urldecode)
                    else
                        -- 无效参数
                        key = "invalid_param"
                        init_param(message.params, key)
                        append_param(message.params, key, pair)
                        finalize_param(message.params, key, urldecode)
                    end
                    
                    buffer = buffer:sub(end_pos + 1)
                end
            until not start_pos
        end
        
        return true
    end
    
    return ltn12.pump.all(source, receive_data)
end

--[[
    解析 HTTP 消息头部
    
    @param source 数据源
    @return 解析后的消息对象，失败返回 nil 和错误信息
]]
function parse_message_header(source)
    local continue_parsing = true
    local message = {}
    local sink = ltn12.sink.simplify(nil)
    
    while continue_parsing do
        local chunk, err = source()
        
        if not chunk then
            if err then
                return chunk, err
            end
        elseif not continue_parsing then
            -- 设置请求方法对应的参数表
            local method = message.request_method
            if method == "get" or method == "post" then
                message.params = message.params or {}
            else
                message.params = {}
            end
            
            -- 构建 CGI 环境变量
            local env = {}
            env.CONTENT_LENGTH = message.headers["Content-Length"]
            env.CONTENT_TYPE = message.headers["Content-Type"]
            env.REQUEST_METHOD = message.request_method:upper()
            env.REQUEST_URI = message.request_uri
            env.SCRIPT_NAME = message.request_uri:gsub("?.+$", "")
            env.SCRIPT_FILENAME = ""
            env.SERVER_PROTOCOL = string.format("HTTP/%.1f", message.http_version)
            
            -- 提取查询字符串
            if message.request_uri:find("?") then
                env.QUERY_STRING = message.request_uri:gsub("^.+?", "")
            else
                env.QUERY_STRING = ""
            end
            
            message.env = env
            
            -- 转换常用头部为 HTTP_* 环境变量
            local common_headers = {
                "Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language",
                "Connection", "Cookie", "Host", "Referer", "User-Agent", "X-Forwarded-For"
            }
            
            for _, header_name in ipairs(common_headers) do
                local env_name = "HTTP_" .. header_name:upper():gsub("%-", "_")
                message.env[env_name] = message.headers[header_name]
            end
        end
    end
    
    return message
end

--[[
    解析 HTTP 消息体
    根据 Content-Type 自动选择解析方式
    
    @param source 数据源
    @param message 消息对象
    @param file_callback 文件数据回调函数（用于 multipart/form-data）
    @return 成功返回 true，失败返回 nil 和错误信息
]]
function parse_message_body(source, message, file_callback)
    local request_method = message.env.REQUEST_METHOD
    
    if request_method == "POST" then
        local content_type = message.env.CONTENT_TYPE
        
        if content_type then
            -- multipart/form-data（文件上传）
            if content_type:match("^multipart/form%-data") then
                return mimedecode_message_body(source, message, file_callback)
            end
            
            -- application/x-www-form-urlencoded（表单提交）
            if content_type:match("^application/x%-www%-form%-urlencoded") then
                return urldecode_message_body(source, message)
            end
        end
    end
    
    -- 其他情况：读取原始内容
    local sink
    if type(file_callback) == "function" then
        sink = file_callback
    else
        message.content = ""
        message.content_length = 0
        
        sink = function(chunk)
            if chunk then
                local new_length = message.content_length + #chunk
                
                if new_length <= HTTP_MAX_CONTENT then
                    message.content = message.content .. chunk
                    message.content_length = message.content_length + #chunk
                    return true
                else
                    return nil, "POST data exceeds maximum allowed length"
                end
            end
            return true
        end
    end
    
    -- 使用 pump 读取数据
    while true do
        local ok, err = ltn12.pump.step(source, sink)
        
        if not ok and err then
            return nil, err
        elseif not err then
            return true
        end
    end
    
    return true
end

-- HTTP 状态码与状态消息映射表
statusmsg = {
    [200] = "OK",
    [206] = "Partial Content",
    [301] = "Moved Permanently",
    [302] = "Found",
    [304] = "Not Modified",
    [400] = "Bad Request",
    [403] = "Forbidden",
    [404] = "Not Found",
    [405] = "Method Not Allowed",
    [408] = "Request Time-out",
    [411] = "Length Required",
    [412] = "Precondition Failed",
    [416] = "Requested range not satisfiable",
    [500] = "Internal Server Error",
    [503] = "Server Unavailable"
}
