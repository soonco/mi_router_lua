--[[
  LuaSocket TP (Text Protocol) 模块
  
  功能说明:
  - 提供基于文本的网络协议支持
  - 用于SMTP、FTP等协议的底层通信
  - 处理命令发送、响应接收和状态码检查
  
  主要功能:
  - connect(): 建立TCP连接
  - command(): 发送协议命令
  - check(): 检查响应状态码
  - source(): 数据源传输
  - close(): 关闭连接
]]

local _G = _G
local string = require("string")
local socket = require("socket")
local ltn12 = require("ltn12")

socket.tp = {}

local tp = socket.tp

tp.TIMEOUT = 60

local function receive_reply(connection)
    local line, err = connection:receive()
    local reply = line
    
    if err then
        return nil, err
    end
    
    local code, sep = socket.skip(2, string.find(line, "^(%d%d%d)(.?)"))
    
    if not code then
        return nil, "invalid server reply"
    end
    
    if sep == "-" then
        repeat
            line, err = connection:receive()
            if err then
                return nil, err
            end
            
            local next_code, next_sep = socket.skip(2, string.find(line, "^(%d%d%d)(.?)"))
            reply = reply .. "\n" .. line
        until code == next_code and next_sep == " "
    end
    
    return code, reply
end

local metat = {}
metat.__index = {}

function metat.__index:check(expected)
    local code, reply = receive_reply(self.c)
    
    if not code then
        return nil, reply
    end
    
    local expected_type = type(expected)
    
    if expected_type == "function" then
        return expected(code, reply)
    elseif expected_type == "table" then
        for _, pattern in ipairs(expected) do
            if string.find(code, pattern) then
                return tonumber(code), reply
            end
        end
        return nil, reply
    elseif expected then
        if string.find(code, expected) then
            return tonumber(code), reply
        end
        return nil, reply
    else
        return tonumber(code), reply
    end
end

function metat.__index:command(cmd, arg)
    cmd = string.upper(cmd)
    
    if arg then
        return self.c:send(cmd .. " " .. arg .. "\r\n")
    else
        return self.c:send(cmd .. "\r\n")
    end
end

function metat.__index:sink(sink, len)
    return self.c:receive(len)
end

function metat.__index:send(data)
    return self.c:send(data)
end

function metat.__index:receive(pattern)
    return self.c:receive(pattern)
end

function metat.__index:getfd()
    return self.c:getfd()
end

function metat.__index:dirty()
    return self.c:dirty()
end

function metat.__index:getcontrol()
    return self.c
end

function metat.__index:source(source, step)
    local sink = ltn12.sink("keep-open", self.c)
    step = step or ltn12.pump.step
    return ltn12.pump.all(source, sink, step)
end

function metat.__index:close()
    self.c:close()
    return 1
end

function tp.connect(host, port, timeout, create_func)
    create_func = create_func or socket.tcp
    
    local conn, err = create_func()
    if not conn then
        return nil, err
    end
    
    conn:settimeout(timeout or tp.TIMEOUT)
    
    local success, connect_err = conn:connect(host, port)
    if not success then
        conn:close()
        return nil, connect_err
    end
    
    return setmetatable({ c = conn }, metat)
end

return tp
