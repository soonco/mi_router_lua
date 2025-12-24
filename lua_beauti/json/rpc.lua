-- JSON-RPC 客户端模块
-- 用于通过 HTTP 发送 JSON-RPC 请求

local json = require("json")
local http = require("socket.http")

-- 初始化 json.rpc 命名空间
json.rpc = {}

local rpc = json.rpc

-- 创建 JSON-RPC 代理对象
-- @param url string - RPC 服务端地址
-- @return table - 代理对象，可以直接调用远程方法
function rpc.proxy(url)
    local proxy = {}
    local metatable = {}
    
    -- 元方法：当访问代理对象的任意属性时，返回一个可调用的函数
    -- 这样可以实现 proxy.methodName(...) 的调用方式
    function metatable.__index(self, methodName)
        local function remoteCall(...)
            return json.rpc.call(url, methodName, ...)
        end
        return remoteCall
    end
    
    setmetatable(proxy, metatable)
    return proxy
end

-- 执行 JSON-RPC 远程调用
-- @param url string - RPC 服务端地址
-- @param method string - 要调用的远程方法名
-- @param ... - 传递给远程方法的参数
-- @return any, string - 成功时返回结果和nil，失败时返回nil和错误信息
function rpc.call(url, method, ...)
    -- 构建 JSON-RPC 请求对象
    local request = {}
    
    -- 生成随机请求ID，用于匹配请求和响应
    request.id = tostring(math.random())
    
    -- 设置要调用的方法名
    request.method = method
    
    -- 设置方法参数
    request.params = (...)
    
    -- 将请求对象编码为 JSON 字符串
    local requestBody = json.encode(request)
    
    -- 加载 ltn12 库用于处理 HTTP 请求/响应的数据流
    local ltn12 = require("ltn12")
    
    -- 用于存储响应数据的表
    local responseTable = {}
    
    -- 发送 HTTP POST 请求
    local success, statusCode = http.request({
        url = url,
        -- 设置响应数据接收器，将响应写入 responseTable
        sink = ltn12.sink.table(responseTable),
        method = "POST",
        headers = {
            ["content-type"] = "application/json-rpc",
            ["content-length"] = string.len(requestBody)
        },
        -- 设置请求体数据源
        source = ltn12.source.string(requestBody)
    })
    
    -- 将响应表合并为字符串
    local responseBody = table.concat(responseTable)
    
    -- 检查 HTTP 状态码
    if statusCode ~= 200 then
        return nil, "HTTP ERROR: " .. statusCode
    end
    
    -- 解析 JSON 响应
    local response = json.decode(responseBody)
    
    -- 根据响应内容返回结果或错误
    if response.result then
        return response.result, nil
    else
        return nil, response.error
    end
end
