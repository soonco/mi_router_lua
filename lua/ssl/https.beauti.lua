--[[
    LuaSec HTTPS 模块
    提供基于 SSL/TLS 的 HTTPS 请求功能
    版本: 0.9
    版权: LuaSec 0.9 - Copyright (C) 2009-2019 PUC-Rio
]]

-- 导入依赖模块
local socket = require("socket")           -- Socket 基础库
local ssl = require("ssl")                 -- SSL/TLS 加密库
local ltn12 = require("ltn12")             -- LTN12 数据过滤器
local http = require("socket.http")        -- HTTP 协议实现
local url = require("socket.url")          -- URL 解析工具

-- 创建 try 函数用于错误处理
local try = socket.try

-- 模块定义
local https = {}

-- 模块版本信息
https._VERSION = "0.9"
https._COPYRIGHT = "LuaSec 0.9 - Copyright (C) 2009-2019 PUC-Rio"

-- 默认配置
https.PORT = 443        -- HTTPS 默认端口
https.TIMEOUT = 60      -- 默认超时时间（秒）

-- 默认 SSL 配置
local defaultSSLConfig = {
    protocol = "any",   -- 支持任意 SSL/TLS 协议版本
    options = {
        "all",          -- 启用所有选项
        "no_sslv2",     -- 禁用 SSLv2（不安全）
        "no_sslv3",     -- 禁用 SSLv3（不安全）
        "no_tlsv1"      -- 禁用 TLSv1（可选）
    },
    verify = "none"     -- 不验证服务器证书（生产环境建议改为 "peer"）
}

--[[
    解析并规范化 URL
    @param rawUrl 原始 URL 字符串
    @return 规范化后的 URL 字符串
]]
local function parseUrl(rawUrl)
    local parsedUrl = url.parse(rawUrl, { port = https.PORT })
    return url.build(parsedUrl)
end

--[[
    创建简单请求配置
    @param requestUrl 请求 URL
    @param requestBody 请求体（可选，如果提供则使用 POST 方法）
    @param resultTable 用于存储响应数据的表
    @return 请求配置表
]]
local function createSimpleRequest(requestUrl, requestBody, resultTable)
    local request = {}
    
    -- 设置规范化的 URL
    request.url = parseUrl(requestUrl)
    
    -- 根据是否有请求体决定请求方法
    if requestBody then
        request.method = "POST"
    else
        request.method = "GET"
    end
    
    -- 设置响应数据接收器
    request.sink = ltn12.sink.table(resultTable)
    
    -- 如果有请求体，设置请求源和相关头部
    if requestBody then
        request.source = ltn12.source.string(requestBody)
        request.headers = {
            ["content-length"] = #requestBody,
            ["content-type"] = "application/x-www-form-urlencoded"
        }
    end
    
    return request
end

--[[
    为连接对象注册方法代理
    将底层 socket 的方法代理到连接对象上
    @param connection 连接对象
]]
local function registerConnectionMethods(connection)
    local metatable = getmetatable(connection)
    local indexTable = metatable.__index
    
    for methodName, methodFunc in pairs(indexTable) do
        if type(methodFunc) == "function" then
            connection[methodName] = function(self, ...)
                return methodFunc(self.sock, ...)
            end
        end
    end
end

--[[
    创建 TCP 连接配置
    合并用户配置和默认 SSL 配置
    @param userConfig 用户提供的配置（可选）
    @return SSL 配置表
]]
function https.tcp(userConfig)
    userConfig = userConfig or {}
    
    -- 合并默认配置
    for key, value in pairs(defaultSSLConfig) do
        userConfig[key] = userConfig[key] or value
    end
    
    -- 设置为客户端模式
    userConfig.mode = "client"
    
    return userConfig
end

--[[
    发起 HTTPS 请求
    @param requestUrlOrConfig URL 字符串或请求配置表
    @param requestBody 请求体（仅当第一个参数为 URL 时使用）
    @return 响应体, HTTP 状态码, 响应头, 状态描述
]]
function https.request(requestUrlOrConfig, requestBody)
    local responseTable = {}
    local isSimpleRequest = type(requestUrlOrConfig) == "string"
    
    -- 处理简单请求（URL 字符串形式）
    if isSimpleRequest then
        requestUrlOrConfig = createSimpleRequest(requestUrlOrConfig, requestBody, responseTable)
    else
        -- 规范化配置中的 URL
        requestUrlOrConfig.url = parseUrl(requestUrlOrConfig.url)
    end
    
    -- 检查不支持的功能
    if http.PROXY or requestUrlOrConfig.proxy then
        return nil, "proxy not supported"
    end
    
    if requestUrlOrConfig.redirect then
        return nil, "redirect not supported"
    end
    
    if requestUrlOrConfig.create then
        return nil, "create function not permitted"
    end
    
    -- 设置 SSL 连接创建函数
    requestUrlOrConfig.create = https.tcp(requestUrlOrConfig)
    
    -- 执行 HTTP 请求
    local responseBody, statusCode, headers, statusLine = http.request(requestUrlOrConfig)
    
    -- 如果是简单请求且成功，合并响应表
    if responseBody and isSimpleRequest then
        return table.concat(responseTable), statusCode, headers, statusLine
    end
    
    return responseBody, statusCode, headers, statusLine
end

return https
