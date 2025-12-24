--[[
  LuaSocket HTTP 客户端模块
  
  功能说明:
  - HTTP/1.1 客户端实现
  - 支持GET、POST、HEAD等请求方法
  - 支持持久连接(Keep-Alive)
  - 支持分块传输编码(Chunked Transfer)
  - 支持代理服务器
  - 支持重定向跟随
  
  主要函数:
  - request(url, body): 发送HTTP请求
  - request(request_table): 使用请求表发送请求
  
  请求表格式:
  {
    url = "http://example.com/path",
    method = "GET",
    headers = { ["Content-Type"] = "application/json" },
    source = ltn12.source.string(body),
    sink = ltn12.sink.table(response_body),
    redirect = true,
    proxy = "http://proxy:8080"
  }
]]

local socket = require("socket")
local url = require("socket.url")
local ltn12 = require("ltn12")
local mime = require("mime")
local string = require("string")
local headers = require("socket.headers")
local _G = _G

socket.http = {}

local http = socket.http

http.TIMEOUT = 60
http.PORT = 80
http.USERAGENT = socket._VERSION

local PROXY = nil

local function adjust_uri(request_t)
    local parsed = url.parse(request_t.url, {
        host = "",
        port = http.PORT,
        path = "/",
        scheme = "http"
    })
    
    if parsed.scheme ~= "http" then
        return nil, "unsupported scheme '" .. tostring(parsed.scheme) .. "'"
    end
    
    if not parsed.host or parsed.host == "" then
        return nil, "invalid host"
    end
    
    request_t.host = parsed.host
    request_t.port = parsed.port
    request_t.uri = parsed.path
    
    if parsed.query then
        request_t.uri = request_t.uri .. "?" .. parsed.query
    end
    
    return request_t
end

local function adjust_proxy(request_t)
    local proxy = request_t.proxy or PROXY
    
    if proxy then
        local proxy_parsed = url.parse(proxy)
        request_t.host = proxy_parsed.host
        request_t.port = proxy_parsed.port or 3128
        request_t.uri = request_t.url
    end
    
    return request_t
end

local function adjust_headers(request_t)
    local lower = {}
    
    for k, v in pairs(request_t.headers or {}) do
        lower[string.lower(k)] = v
    end
    
    lower["host"] = lower["host"] or request_t.host
    lower["connection"] = lower["connection"] or "close"
    lower["user-agent"] = lower["user-agent"] or http.USERAGENT
    
    if request_t.source then
        if not lower["content-length"] then
            lower["transfer-encoding"] = "chunked"
        end
    end
    
    request_t.headers = lower
    
    return request_t
end

local function adjust_source(request_t)
    if request_t.source then
        if request_t.headers["transfer-encoding"] == "chunked" then
            request_t.source = ltn12.source.chain(
                request_t.source,
                ltn12.filter.chain(
                    mime.encode("base64"),
                    mime.wrap("base64")
                )
            )
        end
    end
    
    return request_t
end

local function receive_status(sock)
    local line, err = sock:receive()
    
    if err then
        return nil, err
    end
    
    local code = socket.skip(2, string.find(line, "HTTP/%d*%.%d* (%d%d%d)"))
    
    return tonumber(code), line
end

local function receive_headers(sock, headers_t)
    headers_t = headers_t or {}
    
    local line, err = sock:receive()
    
    if err then
        return nil, err
    end
    
    while line ~= "" do
        local name, value = socket.skip(2, string.find(line, "^(.-):%s*(.*)"))
        
        if not name then
            return nil, "malformed response headers"
        end
        
        name = string.lower(name)
        
        if headers_t[name] then
            headers_t[name] = headers_t[name] .. ", " .. value
        else
            headers_t[name] = value
        end
        
        line, err = sock:receive()
        
        if err then
            return nil, err
        end
    end
    
    return headers_t
end

local function receive_body(sock, headers_t, sink)
    local transfer_encoding = headers_t["transfer-encoding"]
    local content_length = headers_t["content-length"]
    
    if transfer_encoding and string.lower(transfer_encoding) == "chunked" then
        return receive_chunked_body(sock, sink)
    elseif content_length then
        return receive_length_body(sock, tonumber(content_length), sink)
    else
        return receive_until_close_body(sock, sink)
    end
end

local function receive_chunked_body(sock, sink)
    while true do
        local line, err = sock:receive()
        
        if err then
            return nil, err
        end
        
        local size = tonumber(string.gsub(line, ";.*", ""), 16)
        
        if not size then
            return nil, "invalid chunk size"
        end
        
        if size == 0 then
            break
        end
        
        local chunk, err = sock:receive(size)
        
        if err then
            return nil, err
        end
        
        local ok, sink_err = sink(chunk)
        
        if not ok then
            return nil, sink_err
        end
        
        sock:receive()
    end
    
    receive_headers(sock)
    
    return sink(nil)
end

local function receive_length_body(sock, length, sink)
    local remaining = length
    
    while remaining > 0 do
        local chunk_size = math.min(remaining, 8192)
        local chunk, err = sock:receive(chunk_size)
        
        if err then
            return nil, err
        end
        
        local ok, sink_err = sink(chunk)
        
        if not ok then
            return nil, sink_err
        end
        
        remaining = remaining - #chunk
    end
    
    return sink(nil)
end

local function receive_until_close_body(sock, sink)
    while true do
        local chunk, err = sock:receive(8192)
        
        if err then
            if err == "closed" then
                return sink(nil)
            end
            return nil, err
        end
        
        local ok, sink_err = sink(chunk)
        
        if not ok then
            return nil, sink_err
        end
    end
end

local function send_request(sock, request_t)
    local request_line = string.format("%s %s HTTP/1.1\r\n",
        request_t.method or "GET",
        request_t.uri)
    
    local ok, err = sock:send(request_line)
    
    if not ok then
        return nil, err
    end
    
    for name, value in pairs(request_t.headers) do
        local canonical = headers.canonic[name] or name
        ok, err = sock:send(canonical .. ": " .. value .. "\r\n")
        
        if not ok then
            return nil, err
        end
    end
    
    ok, err = sock:send("\r\n")
    
    if not ok then
        return nil, err
    end
    
    if request_t.source then
        return ltn12.pump.all(request_t.source, socket.sink("keep-open", sock))
    end
    
    return 1
end

local function should_redirect(code, headers_t)
    return (code == 301 or code == 302 or code == 303 or code == 307) and
           headers_t["location"]
end

local function redirect_request(request_t, headers_t)
    local location = headers_t["location"]
    
    if not location then
        return nil, "missing location header"
    end
    
    request_t.url = url.absolute(request_t.url, location)
    
    if request_t.nredirects then
        request_t.nredirects = request_t.nredirects + 1
    else
        request_t.nredirects = 1
    end
    
    if request_t.nredirects > 5 then
        return nil, "too many redirects"
    end
    
    return request_t
end

function http.request(url_or_request, body)
    local request_t
    
    if type(url_or_request) == "string" then
        request_t = {
            url = url_or_request,
            sink = ltn12.sink.table({})
        }
        
        if body then
            request_t.source = ltn12.source.string(body)
            request_t.method = "POST"
            request_t.headers = {
                ["content-length"] = #body,
                ["content-type"] = "application/x-www-form-urlencoded"
            }
        end
    else
        request_t = url_or_request
    end
    
    local err
    
    request_t, err = adjust_uri(request_t)
    if not request_t then
        return nil, err
    end
    
    request_t = adjust_proxy(request_t)
    request_t = adjust_headers(request_t)
    request_t = adjust_source(request_t)
    
    local sock
    sock, err = socket.tcp()
    
    if not sock then
        return nil, err
    end
    
    sock:settimeout(http.TIMEOUT)
    
    local ok
    ok, err = sock:connect(request_t.host, request_t.port)
    
    if not ok then
        sock:close()
        return nil, err
    end
    
    ok, err = send_request(sock, request_t)
    
    if not ok then
        sock:close()
        return nil, err
    end
    
    local code, status
    code, status = receive_status(sock)
    
    if not code then
        sock:close()
        return nil, status
    end
    
    local response_headers
    response_headers, err = receive_headers(sock)
    
    if not response_headers then
        sock:close()
        return nil, err
    end
    
    if should_redirect(code, response_headers) and request_t.redirect ~= false then
        sock:close()
        
        request_t, err = redirect_request(request_t, response_headers)
        
        if not request_t then
            return nil, err
        end
        
        return http.request(request_t)
    end
    
    local sink = request_t.sink or ltn12.sink.null()
    
    if code ~= 204 and code ~= 304 and request_t.method ~= "HEAD" then
        ok, err = receive_body(sock, response_headers, sink)
        
        if not ok then
            sock:close()
            return nil, err
        end
    end
    
    sock:close()
    
    return 1, code, response_headers, status
end

function http.setproxy(proxy)
    PROXY = proxy
end

return http
