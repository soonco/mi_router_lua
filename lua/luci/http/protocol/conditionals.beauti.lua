--[[
    LuCI HTTP 条件请求处理模块
    用于处理 HTTP 条件请求头，如 If-Match、If-Modified-Since 等
    
    主要功能:
    - ETag 生成
    - If-Match 验证
    - If-Modified-Since 验证
    - If-None-Match 验证
    - If-Range 验证
    - If-Unmodified-Since 验证
]]

module("luci.http.protocol.conditionals", package.seeall)

local date = require("luci.http.protocol.date")

--[[
    根据文件状态信息生成 ETag
    ETag 格式: "inode-size-mtime"
    
    @param stat_info 文件状态信息表，包含 ino、size、mtime 字段
    @return ETag 字符串，如 '"abc123-1024-1234567890"'
]]
function mk_etag(stat_info)
    if stat_info ~= nil then
        return string.format('"%x-%x-%x"', stat_info.ino, stat_info.size, stat_info.mtime)
    end
end

--[[
    验证 If-Match 请求头
    用于确保资源未被修改（用于 PUT/PATCH 操作）
    
    @param request 请求对象，包含 headers 表
    @param stat_info 文件状态信息
    @return true 表示条件满足，false 表示条件不满足
]]
function if_match(request, stat_info)
    local headers = request.headers
    local etag = mk_etag(stat_info)
    local if_match_header = headers["If-Match"]
    
    if type(if_match_header) == "string" then
        for value in if_match_header:gmatch("[^,%s]+") do
            if (value == "*" or value == etag) and stat_info ~= nil then
                return true
            end
        end
        return false, 412  -- Precondition Failed
    end
    
    return true
end

--[[
    验证 If-Modified-Since 请求头
    用于缓存验证，检查资源是否在指定时间后被修改
    
    @param request 请求对象，包含 headers 表
    @param stat_info 文件状态信息
    @return true 表示资源已修改需要返回新内容
    @return false, 304, headers 表示资源未修改，返回 304 响应
]]
function if_modified_since(request, stat_info)
    local headers = request.headers
    local if_modified_header = headers["If-Modified-Since"]
    
    if type(if_modified_header) == "string" then
        local since_time = date.to_unix(if_modified_header)
        
        -- 检查文件修改时间是否晚于 If-Modified-Since 时间
        if stat_info ~= nil then
            local file_mtime = stat_info.mtime
            if since_time < file_mtime then
                return true  -- 资源已修改，需要返回新内容
            end
        end
        
        -- 资源未修改，返回 304 Not Modified
        local response_headers = {
            ETag = mk_etag(stat_info),
            Date = date.to_http(os.time()),
            ["Last-Modified"] = date.to_http(stat_info.mtime)
        }
        return false, 304, response_headers
    end
    
    return true
end

--[[
    验证 If-None-Match 请求头
    用于缓存验证，检查 ETag 是否匹配
    
    @param request 请求对象，包含 headers 和 env 表
    @param stat_info 文件状态信息
    @return true 表示 ETag 不匹配，需要返回新内容
    @return false, 304, headers 表示 ETag 匹配，返回 304 响应（GET/HEAD）
    @return false, 412 表示 ETag 匹配，返回 412 响应（其他方法）
]]
function if_none_match(request, stat_info)
    local headers = request.headers
    local etag = mk_etag(stat_info)
    
    -- 获取请求方法
    local request_method
    if request.env and request.env.REQUEST_METHOD then
        request_method = request.env.REQUEST_METHOD
    else
        request_method = "GET"
    end
    
    local if_none_match_header = headers["If-None-Match"]
    
    if type(if_none_match_header) == "string" then
        for value in if_none_match_header:gmatch("[^,%s]+") do
            if (value == "*" or value == etag) and stat_info ~= nil then
                -- ETag 匹配
                if request_method == "GET" or request_method == "HEAD" then
                    -- GET/HEAD 请求返回 304 Not Modified
                    local response_headers = {
                        ETag = etag,
                        Date = date.to_http(os.time()),
                        ["Last-Modified"] = date.to_http(stat_info.mtime)
                    }
                    return false, 304, response_headers
                else
                    -- 其他请求返回 412 Precondition Failed
                    return false, 412
                end
            end
        end
    end
    
    return true
end

--[[
    验证 If-Range 请求头
    用于断点续传，检查资源是否可以进行范围请求
    
    @param request 请求对象
    @param stat_info 文件状态信息
    @return false, 412 表示条件不满足
]]
function if_range(request, stat_info)
    return false, 412
end

--[[
    验证 If-Unmodified-Since 请求头
    用于确保资源在指定时间后未被修改
    
    @param request 请求对象，包含 headers 表
    @param stat_info 文件状态信息
    @return true 表示条件满足（资源未修改）
    @return false, 412 表示条件不满足（资源已修改）
]]
function if_unmodified_since(request, stat_info)
    local headers = request.headers
    local if_unmodified_header = headers["If-Unmodified-Since"]
    
    if type(if_unmodified_header) == "string" then
        local since_time = date.to_unix(if_unmodified_header)
        
        -- 检查文件修改时间是否晚于 If-Unmodified-Since 时间
        if stat_info ~= nil then
            local file_mtime = stat_info.mtime
            if since_time <= file_mtime then
                -- 资源已修改，返回 412 Precondition Failed
                return false, 412
            end
        end
    end
    
    return true
end
