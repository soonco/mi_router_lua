---
--- 小米路由器隧道请求API模块
--- 模块路径: luci.controller.api.xqtunnel
---
--- 功能概述:
---   提供通用的隧道请求接口，用于转发Base64编码的请求到后端服务
---
--- API端点:
---   /api/xqtunnel/request - 隧道请求转发
---
--- 依赖模块:
---   - luci.http: HTTP请求处理
---   - xiaoqiang.common.XQConfigs: 配置常量(TUNNEL_TOOL命令模板)
---
--- 安全说明:
---   - 需要管理员认证(sysauth = "admin")
---   - 使用JSON认证方式
---   - 对输入进行Base64字符过滤，防止命令注入
---

module("luci.controller.api.xqtunnel", package.seeall)

local http = require("luci.http")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--- Base64合法字符表
--- 用于过滤输入，只保留有效的Base64字符
--- 包含: A-Z, a-z, 0-9, +, /, =, -, _
local BASE64_VALID_CHARS = {
    A = true, B = true, C = true, D = true, E = true, F = true, G = true,
    H = true, I = true, J = true, K = true, L = true, M = true, N = true,
    O = true, P = true, Q = true, R = true, S = true, T = true, U = true,
    V = true, W = true, X = true, Y = true, Z = true,
    a = true, b = true, c = true, d = true, e = true, f = true, g = true,
    h = true, i = true, j = true, k = true, l = true, m = true, n = true,
    o = true, p = true, q = true, r = true, s = true, t = true, u = true,
    v = true, w = true, x = true, y = true, z = true,
    ["0"] = true, ["1"] = true, ["2"] = true, ["3"] = true, ["4"] = true,
    ["5"] = true, ["6"] = true, ["7"] = true, ["8"] = true, ["9"] = true,
    ["-"] = true, ["_"] = true, ["+"] = true, ["/"] = true, ["="] = true
}

--- 模块路由注册入口
function index()
    --- 创建隧道API节点
    local apiNode = node("api", "xqtunnel")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 300
    apiNode.sysauth = "admin"                   -- 需要管理员认证
    apiNode.sysauth_authenticator = "jsonauth"  -- JSON认证方式
    apiNode.index = true

    --- 注册隧道请求路由
    entry({"api", "xqtunnel", "request"}, call("tunnelRequest"), _(""), 301)
end

--- 过滤Base64字符串
--- 只保留合法的Base64字符，移除所有非法字符
--- 用于防止命令注入攻击
--- @param input: 输入字符串
--- @return: 过滤后的字符串，只包含合法Base64字符
local function filterBase64(input)
    local result = ""
    
    --- 遍历输入字符串的每个字符
    for i = 1, #input do
        local char = input:sub(i, i)
        --- 检查字符是否在合法字符表中
        if BASE64_VALID_CHARS[char] ~= nil and BASE64_VALID_CHARS[char] then
            result = result .. char
        end
    end
    
    return result
end

--- 隧道请求处理函数
--- 将Base64编码的请求通过隧道工具转发到后端服务
--- @param payloadB64: Base64编码的请求载荷
--- 处理流程:
---   1. 获取HTTP请求中的payloadB64参数
---   2. 过滤非法字符，确保只包含有效Base64字符
---   3. 使用TUNNEL_TOOL命令模板构建执行命令
---   4. 执行命令并返回结果
function tunnelRequest()
    --- 获取Base64编码的请求载荷
    local payloadB64 = http.formvalue("payloadB64")
    
    --- 过滤输入，移除非法字符(安全措施)
    local filteredPayload = filterBase64(payloadB64)
    
    --- 构建隧道命令
    --- XQConfigs.TUNNEL_TOOL 是命令模板，使用%s占位符
    local command = XQConfigs.TUNNEL_TOOL % filteredPayload
    
    --- 执行命令并返回结果
    local LuciUtil = require("luci.util")
    http.write(LuciUtil.exec(command))
end
