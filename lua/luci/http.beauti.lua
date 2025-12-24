--[[
    LuCI HTTP 请求处理模块
    提供 HTTP 请求/响应处理、表单数据解析、Cookie 操作等功能
    
    主要功能:
    - HTTP 请求对象封装
    - 表单数据获取和验证
    - Cookie 读写
    - HTTP 响应输出
    - JSON/JSONP 响应
    - 文件下载
    - URL 重定向
]]

local ltn12 = require("luci.ltn12")
local protocol = require("luci.http.protocol")
local util = require("luci.util")
local string = require("string")
local coroutine = require("coroutine")
local table = require("table")
local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
local XQParam = require("xiaoqiang.util.XQParam")
local XQLog = require("xiaoqiang.XQLog")

local ipairs = ipairs
local pairs = pairs
local next = next
local type = type
local tostring = tostring
local error = error

module("luci.http", package.seeall)

context = util.threadlocal()

Request = util.class()

function Request:__init__(env, input_source, error_handler)
    self.input = input_source
    self.error = error_handler
    
    self.filehandler = function() end
    
    self.message = {
        env = env,
        headers = {},
        params = protocol.urldecode_params(env.QUERY_STRING or "")
    }
    
    self.parsed_input = false
end

function Request:formvalue(name, noparse)
    if not noparse then
        if not self.parsed_input then
            self:_parse_input()
        end
    end
    
    if name then
        return self.message.params[name]
    else
        return self.message.params
    end
end

function Request:formvaluetable(prefix)
    local result = {}
    
    if prefix then
        prefix = prefix .. "."
    else
        prefix = "."
    end
    
    if not self.parsed_input then
        self:_parse_input()
    end
    
    for key, value in pairs(self.message.params) do
        if key:find(prefix, 1, true) == 1 then
            local subkey = key:sub(#prefix + 1)
            result[subkey] = tostring(value)
        end
    end
    
    return result
end

function Request:content()
    if not self.parsed_input then
        self:_parse_input()
    end
    
    return self.message.content, self.message.content_length
end

function Request:getcookie(name)
    local cookie_str = ";" .. (self:getenv("HTTP_COOKIE") or "") .. ";"
    cookie_str = cookie_str:gsub("%s*;%s*", ";")
    
    local pattern = ";" .. name .. "=(.-);"
    local _, _, value = cookie_str:find(pattern)
    
    if value then
        return urldecode(value)
    end
    
    return nil
end

function Request:getenv(name)
    if name then
        return self.message.env[name]
    else
        return self.message.env
    end
end

function Request:setfilehandler(handler)
    self.filehandler = handler
end

function Request:_parse_input()
    protocol.parse_message_body(self.input, self.message, self.filehandler)
    self.parsed_input = true
end

function close()
    if not context.eoh then
        context.eoh = true
        coroutine.yield(3)
    end
    
    if not context.closed then
        context.closed = true
        coroutine.yield(5)
    end
end

function content()
    return context.request:content()
end

function formvalue_unsafe(name, noparse)
    return context.request:formvalue(name, noparse)
end

function formvalue(name, noparse, verify_type)
    local value = context.request:formvalue(name, noparse)
    
    if verify_type then
        local verified = XQParam.verify(value, verify_type)
        if verified == false then
            XQLog.log(3, "verify false key:" .. name .. " val:", value)
            return nil
        end
        return value
    else
        return XQSecureUtil.hackCheck(name, value)
    end
end

function xqformvalue(name, noparse)
    local value = context.request:formvalue(name, noparse)
    return XQSecureUtil.xssCheck(value)
end

function formvaluetable(prefix)
    return context.request:formvaluetable(prefix)
end

function getcookie(name)
    return context.request:getcookie(name)
end

function getenv(name)
    return context.request:getenv(name)
end

function setfilehandler(handler)
    return context.request:setfilehandler(handler)
end

function header(name, value)
    if not context.headers then
        context.headers = {}
    end
    
    context.headers[name:lower()] = value
    coroutine.yield(2, name, value)
end

function prepare_content(content_type)
    if context.headers and context.headers["content-type"] then
        return
    end
    
    if content_type == "application/xhtml+xml" then
        local accept = getenv("HTTP_ACCEPT")
        if accept and accept:find("application/xhtml+xml", nil, true) then
        else
            content_type = "text/html; charset=UTF-8"
        end
        header("Vary", "Accept")
    end
    
    header("Content-Type", content_type)
end

function source()
    return context.request.input
end

function status(code, message)
    code = code or 200
    message = message or "OK"
    
    context.status = code
    coroutine.yield(1, code, message)
end

function write(content, callback, is_json, set_content_length)
    if not content then
        if callback then
            callback(content)
        else
            close()
        end
        return true
    end
    
    if #content == 0 then
        return true
    end
    
    if not context.eoh then
        if not context.status then
            status()
        end
        
        if not (context.headers and context.headers["content-type"]) then
            if is_json then
                header("Content-Type", "text/javascript; charset=utf-8")
            else
                header("Content-Type", "text/html; charset=utf-8")
            end
        end
        
        if not context.headers["cache-control"] then
            header("Cache-Control", "no-cache")
            header("Expires", "0")
        end
        
        if set_content_length then
            if not context.headers["Content-Length"] then
                header("Content-Length", tostring(string.len(content)))
            end
        end
        
        context.eoh = true
        coroutine.yield(3)
    end
    
    coroutine.yield(4, content)
    return true
end

function write_file(filepath)
    local CHUNK_SIZE = 4194304
    
    local file = io.open(filepath, "r")
    if not file then
        status(404, "Not Found")
        close()
        return
    end
    
    local file_size = file:seek("end")
    file:seek("set")
    
    if not context.status then
        status()
    end
    
    header("Content-Type", "text/plain; charset=utf-8")
    header("Content-Length", tostring(file_size))
    header("Cache-Control", "no-cache")
    header("Expires", "0")
    
    context.eoh = true
    coroutine.yield(3)
    
    while file:read(0) do
        coroutine.yield(4, file:read(CHUNK_SIZE))
    end
    
    file:close()
    close()
end

function splice(fd, size)
    coroutine.yield(6, fd, size)
end

function redirect(url)
    status(302, "Found")
    header("Location", url)
    close()
end

function build_querystring(params)
    local parts = { "" }
    
    for key, value in pairs(params) do
        if #parts > 1 then
            parts[#parts + 1] = "&"
        end
        parts[#parts + 1] = urldecode(key)
        parts[#parts + 1] = "="
        parts[#parts + 1] = urldecode(value)
    end
    
    return table.concat(parts)
end

urldecode = protocol.urldecode
urlencode = protocol.urlencode

function writeJsonNoLog(data)
    if data == nil then
        write("null")
    elseif type(data) == "table" then
        local json = require("luci.json")
        write(json.encode(data), nil, false, true)
    elseif type(data) == "number" or type(data) == "boolean" then
        if data ~= data then
            write("Number.NaN")
        else
            write(tostring(data))
        end
    else
        local str = tostring(data)
        str = str:gsub('[\"%z\001-\031]', function(char)
            return "\\u%04x" % char:byte(1)
        end)
        write('"%s"' % str)
    end
end

function write_json(data)
    local log = require("xiaoqiang.XQLog")
    log.log(7, data)
    writeJsonNoLog(data)
end

function write_jsonp(data, callback)
    if data == nil then
        write("null")
    elseif type(data) == "table" then
        local json = require("luci.json")
        if callback then
            write(callback .. "(" .. json.encode(data) .. ");", nil, true)
        else
            write("jsonpHandler(" .. json.encode(data) .. ");", nil, true)
        end
    elseif type(data) == "number" or type(data) == "boolean" then
        if data ~= data then
            write("Number.NaN")
        else
            write(tostring(data))
        end
    else
        local str = tostring(data)
        str = str:gsub('[\"%z\001-\031]', function(char)
            return "\\u%04x" % char:byte(1)
        end)
        if callback then
            write(callback .. '("%s");' % str, nil, true)
        else
            write('jsonpHandler("%s");' % str, nil, true)
        end
    end
end
