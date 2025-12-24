--[[
  HTTP工具模块 (XQHttpUtil)
  提供HTTP GET和POST请求功能
  基于cURL库实现
]]--

module("xiaoqiang.util.XQHttpUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQLog = require("xiaoqiang.XQLog")
local cURL = require("cURL")

--[[
  发送HTTP GET请求
  @param url 请求URL
  @param params 查询参数表（可选）
  @param cookies Cookie表（可选）
  @return 响应结果表 {code, headers, status, res}
]]--
function httpGetRequest(url, params, cookies)
    local curl = cURL.easy()
    local cookieStr = ""
    local responseHeaders = {}
    local responseBody = {}
    
    local result = {
        code = 0,
        headers = "",
        status = "",
        res = ""
    }
    
    local success = false
    local errorMsg = ""
    
    if cookies then
        if type(cookies) == "table" then
            cookieStr = ""
            for key, value in pairs(cookies) do
                cookieStr = cookieStr .. key .. "=" .. value .. ";path=/;domain=.xiaomi.com;"
            end
        end
    end
    
    if params and type(params) == "table" then
        local queryString = ""
        for key, value in pairs(params) do
            if queryString == "" then
                queryString = key .. "=" .. value
            else
                queryString = queryString .. "&" .. key .. "=" .. value
            end
        end
        
        if string.find(url, "?") then
            url = url .. "&" .. queryString
        else
            url = url .. "?" .. queryString
        end
    end
    
    curl:setopt_url(url)
    
    if cookieStr ~= "" then
        curl:setopt_cookie(cookieStr)
    end
    
    curl:setopt_writefunction(function(data)
        table.insert(responseBody, data)
        return #data
    end)
    
    curl:setopt_headerfunction(function(header)
        table.insert(responseHeaders, header)
        return #header
    end)
    
    success, errorMsg = curl:perform()
    
    if success == true then
        result.code = curl:getinfo_response_code()
        result.res = table.concat(responseBody)
        result.status = -3
        result.headers = responseHeaders
    else
        result.status = errorMsg
    end
    
    curl:close()
    
    return result
end

--[[
  发送HTTP POST请求
  @param url 请求URL
  @param postData POST数据（字符串或表）
  @param cookies Cookie表（可选）
  @param contentType 内容类型（可选）
  @return 响应结果表 {code, res, status, headers}
]]--
function httpPostRequest(url, postData, cookies, contentType)
    local curl = cURL.easy()
    local cookieStr = ""
    local responseHeaders = {}
    local responseBody = {}
    local requestHeaders = {}
    
    local result = {
        code = "",
        res = ""
    }
    
    local success = false
    local errorMsg = ""
    
    if cookies then
        if type(cookies) == "table" then
            cookieStr = ""
            for key, value in pairs(cookies) do
                cookieStr = cookieStr .. key .. "=" .. value .. ";path=/;domain=.xiaomi.com;"
            end
        end
    end
    
    curl:setopt_url(url)
    
    if contentType then
        table.insert(requestHeaders, "Content-Type: " .. contentType)
        curl:setopt_httpheader(requestHeaders)
    end
    
    curl:setopt_post(true)
    
    if type(postData) == "table" then
        local postFields = ""
        for key, value in pairs(postData) do
            if postFields == "" then
                postFields = key .. "=" .. value
            else
                postFields = postFields .. "&" .. key .. "=" .. value
            end
        end
        curl:setopt_postfields(postFields)
    else
        curl:setopt_postfields(postData)
    end
    
    if cookieStr ~= "" then
        curl:setopt_cookie(cookieStr)
    end
    
    curl:setopt_writefunction(function(data)
        table.insert(responseBody, data)
        return #data
    end)
    
    curl:setopt_headerfunction(function(header)
        table.insert(responseHeaders, header)
        return #header
    end)
    
    success, errorMsg = curl:perform()
    
    if success == true then
        result.code = curl:getinfo_response_code()
        result.res = table.concat(responseBody)
        result.status = -3
        result.headers = responseHeaders
    else
        result.status = errorMsg
    end
    
    curl:close()
    
    return result
end
