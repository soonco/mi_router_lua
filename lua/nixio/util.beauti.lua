--[[
    Nixio 工具模块
    提供 nixio 库的扩展工具函数
    包含数据消费、I/O 操作等实用功能
]]

-- 导入依赖
local tableLib = require("table")
local nixio = require("nixio")

-- 全局函数引用
local getmetatable = getmetatable
local assert = assert
local pairs = pairs
local type = type
local tostring = tostring

-- 注册为模块
module("nixio.util")

-- 获取常量
local BUFFER_SIZE = nixio.const.buffersize or 65536

-- 获取元表引用
local metaSocket = nixio.meta_socket
local metaTlsSocket = nixio.meta_tls_socket
local metaFile = nixio.meta_file

-- 检测操作系统
local unameInfo = nixio.uname()
local isLinux = unameInfo.sysname == "Linux"

--[[
    消费迭代器数据
    将迭代器返回的所有数据收集到表中
    @param iterator 迭代器函数
    @param resultTable 结果表（可选，默认创建新表）
    @return 包含所有数据的表
]]
function consume(iterator, resultTable)
    resultTable = resultTable or {}
    
    if iterator then
        for chunk in iterator do
            resultTable[#resultTable + 1] = chunk
        end
    end
    
    return resultTable
end

-- 定义要添加到元表的方法
local methods = {}

--[[
    检查对象是否为 socket
    @return boolean
]]
methods.is_socket = function(self)
    return true
end

--[[
    检查对象是否为 TLS socket
    @return boolean
]]
methods.is_tls_socket = function(self)
    return true
end

--[[
    检查对象是否为文件
    @return boolean
]]
methods.is_file = function(self)
    return true
end

--[[
    读取所有数据
    @return 读取的数据
]]
methods.readall = function(self)
    local chunks = {}
    while true do
        local chunk = self:read(BUFFER_SIZE)
        if not chunk or #chunk == 0 then
            break
        end
        chunks[#chunks + 1] = chunk
    end
    return tableLib.concat(chunks)
end

--[[
    接收所有数据
    @return 接收的数据
]]
methods.recvall = function(self)
    local chunks = {}
    while true do
        local chunk = self:recv(BUFFER_SIZE)
        if not chunk or #chunk == 0 then
            break
        end
        chunks[#chunks + 1] = chunk
    end
    return tableLib.concat(chunks)
end

--[[
    写入所有数据
    @param data 要写入的数据
    @return 写入的字节数
]]
methods.writeall = function(self, data)
    local total = 0
    local len = #data
    
    while total < len do
        local written = self:write(data:sub(total + 1))
        if not written then
            return nil, "write error"
        end
        total = total + written
    end
    
    return total
end

--[[
    发送所有数据
    @param data 要发送的数据
    @return 发送的字节数
]]
methods.sendall = function(self, data)
    local total = 0
    local len = #data
    
    while total < len do
        local sent = self:send(data:sub(total + 1))
        if not sent then
            return nil, "send error"
        end
        total = total + sent
    end
    
    return total
end

--[[
    创建行数据源
    按行读取数据的迭代器
    @param limit 最大读取字节数（可选）
    @return 迭代器函数
]]
methods.linesource = function(self, limit)
    local buffer = ""
    
    return function()
        while true do
            local newlinePos = buffer:find("\n")
            if newlinePos then
                local line = buffer:sub(1, newlinePos - 1)
                buffer = buffer:sub(newlinePos + 1)
                return line
            end
            
            local chunk = self:recv(BUFFER_SIZE)
            if not chunk or #chunk == 0 then
                if #buffer > 0 then
                    local remaining = buffer
                    buffer = ""
                    return remaining
                end
                return nil
            end
            
            buffer = buffer .. chunk
            
            if limit and #buffer > limit then
                return nil, "line too long"
            end
        end
    end
end

--[[
    创建块数据源
    按固定大小块读取数据的迭代器
    @param blockSize 块大小（可选，默认使用 BUFFER_SIZE）
    @return 迭代器函数
]]
methods.blocksource = function(self, blockSize)
    blockSize = blockSize or BUFFER_SIZE
    
    return function()
        local chunk = self:recv(blockSize)
        if chunk and #chunk > 0 then
            return chunk
        end
        return nil
    end
end

--[[
    创建数据接收器
    将数据写入到目标
    @return 接收器函数
]]
methods.sink = function(self)
    return function(chunk)
        if chunk then
            return self:send(chunk)
        end
        return true
    end
end

--[[
    复制数据
    从源复制数据到目标
    @param source 数据源（迭代器或具有 recv 方法的对象）
    @param target 目标（具有 send 方法的对象）
    @return 复制的字节数
]]
methods.copy = function(self, source, target)
    target = target or self
    local total = 0
    
    for chunk in source do
        local sent = target:send(chunk)
        if not sent then
            return nil, "send error"
        end
        total = total + #chunk
    end
    
    return total
end

--[[
    零拷贝复制（仅 Linux）
    使用 sendfile 进行高效的文件传输
    @param source 源文件描述符
    @param count 要复制的字节数
    @return 复制的字节数
]]
methods.copyz = function(self, source, count)
    if isLinux then
        return nixio.sendfile(self, source, count)
    else
        return methods.copy(self, source:blocksource())
    end
end

-- 为 TLS socket 添加额外方法
if metaTlsSocket then
    --[[
        关闭 TLS 连接
    ]]
    metaTlsSocket.close = function(self)
        self:shutdown()
        return self:free()
    end
    
    --[[
        获取本地地址
    ]]
    metaTlsSocket.getsockname = function(self)
        return self:socket():getsockname()
    end
    
    --[[
        获取对端地址
    ]]
    metaTlsSocket.getpeername = function(self)
        return self:socket():getpeername()
    end
    
    --[[
        获取 socket 选项
    ]]
    metaTlsSocket.getsockopt = function(self, ...)
        return self:socket():getsockopt(...)
    end
    
    --[[
        获取选项（别名）
    ]]
    metaTlsSocket.getopt = function(self, ...)
        return self:socket():getopt(...)
    end
    
    --[[
        设置 socket 选项
    ]]
    metaTlsSocket.setsockopt = function(self, ...)
        return self:socket():setsockopt(...)
    end
    
    --[[
        设置选项（别名）
    ]]
    metaTlsSocket.setopt = function(self, ...)
        return self:socket():setopt(...)
    end
end

-- 将方法添加到所有元表
for methodName, methodFunc in pairs(methods) do
    metaFile[methodName] = methodFunc
    metaSocket[methodName] = methodFunc
    
    if metaTlsSocket then
        metaTlsSocket[methodName] = methodFunc
    end
end
