--[[
  LuaSocket SMTP 客户端模块
  
  功能说明:
  - SMTP邮件发送客户端实现
  - 支持PLAIN和LOGIN认证
  - 支持多收件人
  - 支持附件(通过MIME)
  - 支持TLS/SSL(需要luasec)
  
  主要函数:
  - send(message_table): 发送邮件
  - message(message_source): 创建邮件消息源
  
  消息表格式:
  {
    from = "sender@example.com",
    rcpt = { "recipient@example.com" },
    source = ltn12.source.string(message_body),
    server = "smtp.example.com",
    port = 25,
    user = "username",
    password = "password"
  }
]]

local _G = _G
local socket = require("socket")
local tp = require("socket.tp")
local ltn12 = require("ltn12")
local headers = require("socket.headers")
local mime = require("mime")
local string = require("string")
local table = require("table")

socket.smtp = {}

local smtp = socket.smtp

smtp.TIMEOUT = 60
smtp.PORT = 25
smtp.DOMAIN = socket.dns.gethostname() or "localhost"
smtp.SERVER = "localhost"

local metat = { __index = {} }

function metat.__index:greet(domain)
    self.tp:check("2..")
    self.tp:command("EHLO", domain or smtp.DOMAIN)
    return socket.skip(1, self.tp:check("2.."))
end

function metat.__index:mail(from)
    self.tp:command("MAIL", "FROM:<" .. from .. ">")
    return self.tp:check("2..")
end

function metat.__index:rcpt(to)
    self.tp:command("RCPT", "TO:<" .. to .. ">")
    return self.tp:check("2..")
end

function metat.__index:data(src, step)
    self.tp:command("DATA")
    self.tp:check("3..")
    self.tp:source(src, step)
    self.tp:send("\r\n.\r\n")
    return self.tp:check("2..")
end

function metat.__index:quit()
    self.tp:command("QUIT")
    return self.tp:check("2..")
end

function metat.__index:close()
    return self.tp:close()
end

function metat.__index:login(user, password)
    self.tp:command("AUTH", "LOGIN")
    self.tp:check("3..")
    self.tp:send(mime.b64(user) .. "\r\n")
    self.tp:check("3..")
    self.tp:send(mime.b64(password) .. "\r\n")
    return self.tp:check("2..")
end

function metat.__index:plain(user, password)
    local auth_string = "\0" .. user .. "\0" .. password
    self.tp:command("AUTH", "PLAIN " .. mime.b64(auth_string))
    return self.tp:check("2..")
end

function metat.__index:auth(user, password, ext)
    if not user or not password then
        return 1
    end
    
    if string.find(ext, "AUTH[^\n]+LOGIN") then
        return self:login(user, password)
    elseif string.find(ext, "AUTH[^\n]+PLAIN") then
        return self:plain(user, password)
    else
        return nil, "authentication not supported"
    end
end

function metat.__index:send(message_t)
    self:mail(message_t.from)
    
    local rcpt = message_t.rcpt
    
    if type(rcpt) == "table" then
        for _, recipient in ipairs(rcpt) do
            self:rcpt(recipient)
        end
    else
        self:rcpt(rcpt)
    end
    
    self:data(message_t.source, message_t.step)
    
    return 1
end

local function split_message(message_source)
    local current = ""
    
    local function get_chunk()
        local data, err = message_source()
        
        if err then
            return nil, err
        end
        
        if not data then
            return nil
        end
        
        current = current .. data
        
        local line, rest = string.match(current, "^(.-\r\n)(.*)")
        
        if line then
            current = rest
            return line
        end
        
        return ""
    end
    
    return get_chunk
end

local function send_headers(headers_t)
    local result = ""
    
    for name, value in pairs(headers_t) do
        local canonical = headers.canonic[string.lower(name)] or name
        result = result .. canonical .. ": " .. value .. "\r\n"
    end
    
    return result
end

function smtp.message(message_source)
    local headers_done = false
    local current = ""
    
    local function get_chunk()
        if not headers_done then
            headers_done = true
            return send_headers(message_source.headers or {}) .. "\r\n"
        end
        
        local body_source = message_source.body
        
        if type(body_source) == "string" then
            message_source.body = nil
            return body_source
        elseif type(body_source) == "function" then
            return body_source()
        elseif type(body_source) == "table" then
            if body_source.source then
                return body_source.source()
            end
        end
        
        return nil
    end
    
    return get_chunk
end

function smtp.send(message_t)
    local server = message_t.server or smtp.SERVER
    local port = message_t.port or smtp.PORT
    local domain = message_t.domain or smtp.DOMAIN
    
    local conn, err = tp.connect(server, port, smtp.TIMEOUT)
    
    if not conn then
        return nil, err
    end
    
    local smtp_conn = setmetatable({ tp = conn }, metat)
    
    local ext
    ext, err = smtp_conn:greet(domain)
    
    if not ext then
        smtp_conn:close()
        return nil, err
    end
    
    local ok
    ok, err = smtp_conn:auth(message_t.user, message_t.password, ext)
    
    if not ok then
        smtp_conn:close()
        return nil, err
    end
    
    ok, err = smtp_conn:send(message_t)
    
    if not ok then
        smtp_conn:close()
        return nil, err
    end
    
    smtp_conn:quit()
    smtp_conn:close()
    
    return 1
end

return smtp
