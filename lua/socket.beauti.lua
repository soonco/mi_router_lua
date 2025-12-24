--[[
    LuaSocket 核心模块
    提供 TCP/UDP 网络通信功能
    包含数据源（source）和数据接收器（sink）的实现
]]

-- 导入依赖
local _G = _G
local stringLib = require("string")
local mathLib = require("math")
local socketCore = require("socket.core")

-- 模块引用
local socket = socketCore

--[[
    IPv4 连接
    @param address 目标地址
    @param port 目标端口
    @param localAddr 本地地址（可选）
    @param localPort 本地端口（可选）
    @return socket 对象，或 nil 和错误信息
]]
function socket.connect4(address, port, localAddr, localPort)
    return socket.connect(address, port, localAddr, localPort, "inet")
end

--[[
    IPv6 连接
    @param address 目标地址
    @param port 目标端口
    @param localAddr 本地地址（可选）
    @param localPort 本地端口（可选）
    @return socket 对象，或 nil 和错误信息
]]
function socket.connect6(address, port, localAddr, localPort)
    return socket.connect(address, port, localAddr, localPort, "inet6")
end

--[[
    绑定并监听端口
    支持 IPv4 和 IPv6
    @param address 绑定地址（"*" 表示所有地址）
    @param port 绑定端口
    @param backlog 连接队列长度（可选）
    @return socket 对象，或 nil 和错误信息
]]
function socket.bind(address, port, backlog)
    -- 将 "*" 转换为 IPv4 通配地址
    if address == "*" then
        address = "0.0.0.0"
    end
    
    -- 解析地址信息
    local addrInfo, err = socket.dns.getaddrinfo(address)
    if not addrInfo then
        return nil, err
    end
    
    local sock, bindResult
    local errorMsg = "no info on address"
    
    -- 遍历所有地址信息，尝试绑定
    for _, info in ipairs(addrInfo) do
        -- 根据地址族创建 socket
        if info.family == "inet" then
            sock, errorMsg = socket.tcp()
        else
            sock, errorMsg = socket.tcp6()
        end
        
        if not sock then
            return nil, errorMsg
        end
        
        -- 设置地址重用选项
        sock:setoption("reuseaddr", true)
        
        -- 尝试绑定
        bindResult, errorMsg = sock:bind(info.addr, port)
        if not bindResult then
            sock:close()
        else
            -- 开始监听
            bindResult, errorMsg = sock:listen(backlog)
            if not bindResult then
                sock:close()
            else
                return sock
            end
        end
    end
    
    return nil, errorMsg
end

-- 创建 try 函数
socket.try = socket.newtry()

--[[
    创建选择器函数
    根据键名选择对应的处理函数
    @param handlers 处理函数表
    @return 选择器函数
]]
function socket.choose(handlers)
    return function(key, arg1, arg2)
        -- 如果第一个参数不是字符串，则调整参数
        if _G.type(key) ~= "string" then
            arg2 = arg1
            arg1 = key
            key = "default"
        end
        
        -- 获取处理函数
        local handler = handlers[key or "nil"]
        if not handler then
            _G.error("unknown key (" .. _G.tostring(key) .. ")", 3)
        else
            return handler(arg1, arg2)
        end
    end
end

-- 数据源表
socket.sourcet = {}

-- 数据接收器表
socket.sinkt = {}

-- 默认块大小
socket.BLOCKSIZE = 2048

--[[
    创建"完成后关闭"接收器
    发送完数据后关闭连接
    @param sock socket 对象
    @return 接收器对象
]]
socket.sinkt["close-when-done"] = function(sock)
    return _G.setmetatable({
        getfd = function()
            return sock:getfd()
        end,
        dirty = function()
            return sock:dirty()
        end
    }, {
        __call = function(self, chunk, err)
            if not chunk then
                sock:close()
                return 1
            else
                return sock:send(chunk)
            end
        end
    })
end

--[[
    创建"保持打开"接收器
    发送完数据后不关闭连接
    @param sock socket 对象
    @return 接收器对象
]]
socket.sinkt["keep-open"] = function(sock)
    return _G.setmetatable({
        getfd = function()
            return sock:getfd()
        end,
        dirty = function()
            return sock:dirty()
        end
    }, {
        __call = function(self, chunk, err)
            if chunk then
                return sock:send(chunk)
            else
                return 1
            end
        end
    })
end

-- 默认接收器为"保持打开"
socket.sinkt.default = socket.sinkt["keep-open"]

-- 创建接收器选择器
socket.sink = socket.choose(socket.sinkt)

--[[
    创建"按长度读取"数据源
    读取指定长度的数据
    @param sock socket 对象
    @param length 要读取的字节数
    @return 数据源对象
]]
socket.sourcet["by-length"] = function(sock, length)
    return _G.setmetatable({
        getfd = function()
            return sock:getfd()
        end,
        dirty = function()
            return sock:dirty()
        end
    }, {
        __call = function()
            if length <= 0 then
                return nil
            end
            
            -- 计算本次读取的大小
            local size = mathLib.min(socket.BLOCKSIZE, length)
            local chunk, err = sock:receive(size)
            
            if err then
                return nil, err
            end
            
            -- 更新剩余长度
            length = length - stringLib.len(chunk)
            return chunk
        end
    })
end

--[[
    创建"读取直到关闭"数据源
    持续读取数据直到连接关闭
    @param sock socket 对象
    @return 数据源对象
]]
socket.sourcet["until-closed"] = function(sock)
    local done = false
    
    return _G.setmetatable({
        getfd = function()
            return sock:getfd()
        end,
        dirty = function()
            return sock:dirty()
        end
    }, {
        __call = function()
            if done then
                return nil
            end
            
            local chunk, err, partial = sock:receive(socket.BLOCKSIZE)
            
            if not err then
                return chunk
            elseif err == "closed" then
                -- 连接已关闭
                sock:close()
                done = true
                return partial
            else
                return nil, err
            end
        end
    })
end

-- 默认数据源为"读取直到关闭"
socket.sourcet.default = socket.sourcet["until-closed"]

-- 创建数据源选择器
socket.source = socket.choose(socket.sourcet)

return socket
