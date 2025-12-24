--[[
  LuaSocket FTP 客户端模块
  
  功能说明:
  - FTP文件传输客户端实现
  - 支持主动模式(PORT)和被动模式(PASV)
  - 支持文件上传和下载
  - 支持目录列表
  - 支持ASCII和二进制传输模式
  
  主要函数:
  - get(url): 下载文件
  - put(url, content): 上传文件
  - command(request_table): 执行FTP命令
  
  请求表格式:
  {
    host = "ftp.example.com",
    port = 21,
    user = "username",
    password = "password",
    path = "/path/to/file",
    type = "i",  -- "a" for ASCII, "i" for binary
    sink = ltn12.sink.file(io.open("local_file", "wb")),
    source = ltn12.source.file(io.open("local_file", "rb")),
    command = "retr"  -- or "stor", "nlst", etc.
  }
]]

local _G = _G
local socket = require("socket")
local tp = require("socket.tp")
local ltn12 = require("ltn12")
local url = require("socket.url")
local string = require("string")

socket.ftp = {}

local ftp = socket.ftp

ftp.TIMEOUT = 60
ftp.PORT = 21
ftp.USER = "ftp"
ftp.PASSWORD = "anonymous@anonymous.org"

local metat = { __index = {} }

function metat.__index:greet()
    local code, reply = self.tp:check("2..")
    
    if not code then
        return nil, reply
    end
    
    return 1
end

function metat.__index:login(user, password)
    self.tp:command("USER", user or ftp.USER)
    
    local code, reply = self.tp:check({ "2..", "3.." })
    
    if not code then
        return nil, reply
    end
    
    if code == 331 then
        self.tp:command("PASS", password or ftp.PASSWORD)
        code, reply = self.tp:check("2..")
        
        if not code then
            return nil, reply
        end
    end
    
    return 1
end

function metat.__index:pasv()
    self.tp:command("PASV")
    
    local code, reply = self.tp:check("2..")
    
    if not code then
        return nil, reply
    end
    
    local pattern = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
    local a, b, c, d, p1, p2 = socket.skip(2, string.find(reply, pattern))
    
    if not a then
        return nil, "invalid PASV reply"
    end
    
    local host = string.format("%s.%s.%s.%s", a, b, c, d)
    local port = tonumber(p1) * 256 + tonumber(p2)
    
    return host, port
end

function metat.__index:port(host, port)
    local a, b, c, d = string.match(host, "(%d+)%.(%d+)%.(%d+)%.(%d+)")
    local p1 = math.floor(port / 256)
    local p2 = port % 256
    
    local arg = string.format("%s,%s,%s,%s,%d,%d", a, b, c, d, p1, p2)
    
    self.tp:command("PORT", arg)
    
    return self.tp:check("2..")
end

function metat.__index:type(transfer_type)
    self.tp:command("TYPE", transfer_type)
    return self.tp:check("2..")
end

function metat.__index:cwd(path)
    self.tp:command("CWD", path)
    return self.tp:check("2..")
end

function metat.__index:pwd()
    self.tp:command("PWD")
    
    local code, reply = self.tp:check("2..")
    
    if not code then
        return nil, reply
    end
    
    local path = string.match(reply, '"(.+)"')
    
    return path or reply
end

function metat.__index:quit()
    self.tp:command("QUIT")
    return self.tp:check("2..")
end

function metat.__index:close()
    return self.tp:close()
end

local function open_data_connection(ftp_conn, request_t)
    if request_t.passive ~= false then
        local host, port = ftp_conn:pasv()
        
        if not host then
            return nil, port
        end
        
        local data_conn, err = socket.tcp()
        
        if not data_conn then
            return nil, err
        end
        
        data_conn:settimeout(ftp.TIMEOUT)
        
        local ok
        ok, err = data_conn:connect(host, port)
        
        if not ok then
            data_conn:close()
            return nil, err
        end
        
        return data_conn
    else
        local server, err = socket.tcp()
        
        if not server then
            return nil, err
        end
        
        server:settimeout(ftp.TIMEOUT)
        server:setoption("reuseaddr", true)
        
        local ok
        ok, err = server:bind("*", 0)
        
        if not ok then
            server:close()
            return nil, err
        end
        
        local host, port = server:getsockname()
        
        ok, err = ftp_conn:port(request_t.host, port)
        
        if not ok then
            server:close()
            return nil, err
        end
        
        ok, err = server:listen(1)
        
        if not ok then
            server:close()
            return nil, err
        end
        
        return server, "server"
    end
end

function metat.__index:receive(request_t)
    local data_conn, mode = open_data_connection(self, request_t)
    
    if not data_conn then
        return nil, mode
    end
    
    self.tp:command(request_t.command or "RETR", request_t.argument)
    
    local code, reply = self.tp:check({ "1..", "2.." })
    
    if not code then
        data_conn:close()
        return nil, reply
    end
    
    if mode == "server" then
        local client
        client, reply = data_conn:accept()
        data_conn:close()
        
        if not client then
            return nil, reply
        end
        
        data_conn = client
    end
    
    local sink = request_t.sink
    local step = request_t.step or ltn12.pump.step
    
    local ok, err = ltn12.pump.all(socket.source("until-closed", data_conn), sink, step)
    
    data_conn:close()
    
    if not ok then
        return nil, err
    end
    
    if code == 150 or code == 125 then
        code, reply = self.tp:check("2..")
        
        if not code then
            return nil, reply
        end
    end
    
    return 1
end

function metat.__index:send(request_t)
    local data_conn, mode = open_data_connection(self, request_t)
    
    if not data_conn then
        return nil, mode
    end
    
    self.tp:command(request_t.command or "STOR", request_t.argument)
    
    local code, reply = self.tp:check({ "1..", "2.." })
    
    if not code then
        data_conn:close()
        return nil, reply
    end
    
    if mode == "server" then
        local client
        client, reply = data_conn:accept()
        data_conn:close()
        
        if not client then
            return nil, reply
        end
        
        data_conn = client
    end
    
    local source = request_t.source
    local step = request_t.step or ltn12.pump.step
    
    local ok, err = ltn12.pump.all(source, socket.sink("close-when-done", data_conn), step)
    
    if not ok then
        return nil, err
    end
    
    if code == 150 or code == 125 then
        code, reply = self.tp:check("2..")
        
        if not code then
            return nil, reply
        end
    end
    
    return 1
end

local function parse_url(url_string)
    local parsed = url.parse(url_string, {
        host = "",
        user = ftp.USER,
        password = ftp.PASSWORD,
        port = ftp.PORT,
        path = "/",
        scheme = "ftp"
    })
    
    if parsed.scheme ~= "ftp" then
        return nil, "unsupported scheme '" .. tostring(parsed.scheme) .. "'"
    end
    
    return parsed
end

function ftp.command(request_t)
    local conn, err = tp.connect(request_t.host, request_t.port or ftp.PORT, ftp.TIMEOUT)
    
    if not conn then
        return nil, err
    end
    
    local ftp_conn = setmetatable({ tp = conn }, metat)
    
    local ok
    ok, err = ftp_conn:greet()
    
    if not ok then
        ftp_conn:close()
        return nil, err
    end
    
    ok, err = ftp_conn:login(request_t.user, request_t.password)
    
    if not ok then
        ftp_conn:close()
        return nil, err
    end
    
    if request_t.type then
        ok, err = ftp_conn:type(request_t.type)
        
        if not ok then
            ftp_conn:close()
            return nil, err
        end
    end
    
    if request_t.source then
        ok, err = ftp_conn:send(request_t)
    else
        ok, err = ftp_conn:receive(request_t)
    end
    
    ftp_conn:quit()
    ftp_conn:close()
    
    if not ok then
        return nil, err
    end
    
    return 1
end

function ftp.get(url_string)
    local parsed, err = parse_url(url_string)
    
    if not parsed then
        return nil, err
    end
    
    local body = {}
    
    local ok
    ok, err = ftp.command({
        host = parsed.host,
        port = parsed.port,
        user = parsed.user,
        password = parsed.password,
        command = "RETR",
        argument = parsed.path,
        type = "i",
        sink = ltn12.sink.table(body)
    })
    
    if not ok then
        return nil, err
    end
    
    return table.concat(body)
end

function ftp.put(url_string, content)
    local parsed, err = parse_url(url_string)
    
    if not parsed then
        return nil, err
    end
    
    local source
    
    if type(content) == "string" then
        source = ltn12.source.string(content)
    else
        source = content
    end
    
    return ftp.command({
        host = parsed.host,
        port = parsed.port,
        user = parsed.user,
        password = parsed.password,
        command = "STOR",
        argument = parsed.path,
        type = "i",
        source = source
    })
end

return ftp
