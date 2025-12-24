---
--- 小米路由器缓存中心服务模块
--- 模块路径: luci.controller.service.cachecenter
---
--- 功能概述:
---   提供缓存中心服务的API接口
---   通过Thrift隧道与缓存中心服务通信
---
--- API端点:
---   /service/cachecenter/report_key - 上报缓存键
---
--- 依赖模块:
---   - luci.http: HTTP请求处理
---   - xiaoqiang.common.XQConfigs: 配置常量
---   - xiaoqiang.util.XQCryptoUtil: 加密工具
---   - service.util.ServiceErrorUtil: 服务错误处理
---   - cjson: JSON编解码
---

module("luci.controller.service.cachecenter", package.seeall)

local http = require("luci.http")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local ServiceErrorUtil = require("service.util.ServiceErrorUtil")

--- 模块路由注册入口
function index()
    --- 创建缓存中心服务节点
    local cacheNode = node("service", "cachecenter")
    cacheNode.target = firstchild()
    cacheNode.title = ""
    cacheNode.order = nil
    cacheNode.sysauth = "admin"                   -- 需要管理员认证
    cacheNode.sysauth_authenticator = "jsonauth"  -- JSON认证方式
    cacheNode.index = true

    --- 注册上报缓存键API
    entry({"service", "cachecenter", "report_key"}, call("reportKey"), _(""), nil, 1)
end

--- 通过隧道发送请求到缓存中心(异步)
--- 将请求JSON编码后通过Thrift隧道发送
--- @param requestData: 请求数据表
function tunnelRequestCachecenter(requestData)
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    --- JSON编码请求数据
    local jsonData = cjson.encode(requestData)
    
    --- Base64编码
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonData)
    
    --- 构建Thrift隧道命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_CACHECENTER % encodedData
    
    --- 执行命令并返回结果
    http.write(LuciUtil.exec(command))
end

--- 通过隧道发送请求到缓存中心(同步)
--- 返回执行结果而不是直接写入HTTP响应
--- @param requestData: 请求数据表
--- @return string: 命令执行结果
function requestCachecenter(requestData)
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    --- JSON编码请求数据
    local jsonData = cjson.encode(requestData)
    
    --- Base64编码
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonData)
    
    --- 构建Thrift隧道命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_CACHECENTER % encodedData
    
    --- 执行命令并返回结果
    return LuciUtil.exec(command)
end

--- API: 上报缓存键
--- 向缓存中心上报指定的缓存键
--- @param key: 缓存键名称
function reportKey()
    local requestData = {}
    requestData.api = 1  -- API编号: 上报缓存键
    requestData.key = http.formvalue("key")
    
    tunnelRequestCachecenter(requestData)
end
