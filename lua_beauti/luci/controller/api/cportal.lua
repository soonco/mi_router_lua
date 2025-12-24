--[[
    强制门户控制器模块 (Captive Portal Controller Module)
    
    功能说明:
    - 提供强制门户(Captive Portal)相关的API接口
    - 用于处理网络认证和访客放行
    
    API端点:
    - /api/cportal/allow: 允许设备通过强制门户
    
    依赖模块:
    - luci.http: HTTP处理
    - xiaoqiang.XQLog: 日志模块
]]

module("luci.controller.api.cportal", package.seeall)

local http = require("luci.http")
local XQLog = require("xiaoqiang.XQLog")

--[[
    路由索引函数
    
    注册所有API路由
]]
function index()
    local api_node = node("api", "cportal")
    api_node.target = firstchild()
    api_node.title = ""
    api_node.order = 200
    api_node.index = true
    
    entry({"api", "cportal"}, firstchild(), "", 200)
    entry({"api", "cportal", "allow"}, call("captivePortalAllow"), "", 201, 1)
end

--[[
    允许设备通过强制门户
    
    获取请求设备的MAC地址，执行放行脚本
    支持设置放行时间间隔
]]
function captivePortalAllow()
    local result = {
        code = 0
    }
    
    local callback = http.formvalue("callback")
    
    local remote_mac = luci.dispatcher.getremotemac()
    
    local interval = http.formvalue("interval")
    if tonumber(interval) == nil then
        interval = ""
    end
    
    os.execute("/usr/sbin/captive_portal.sh allow " .. remote_mac .. " " .. interval)
    
    http.write_jsonp(result, callback)
end
