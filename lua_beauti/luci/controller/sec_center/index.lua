--[[
  小米路由器安全中心 - 控制器入口模块
  
  功能说明:
  - 安全中心API控制器
  - 聚合各安全子模块的概览信息
  - 提供统一的安全状态查询接口
  
  API路由:
  - /api/sec_center/overview: 获取安全中心总览
  
  聚合的子模块:
  - log: 安全日志
  - config_scanner: 配置扫描
  - content_filter: 内容过滤
  - gateway_security: 网关安全
]]

module("luci.controller.sec_center.index", package.seeall)

local XQFeatures = require("xiaoqiang.XQFeatures")
local FEATURES = XQFeatures.FEATURES
local SEC_CENTER_MODULE = "sec_center"

local http = require("luci.http")

function index()
    local api_node = node("api", "sec_center")
    api_node.sysauth = "admin"
    api_node.sysauth_authenticator = "htmlauth"
    api_node.index = true
    
    entry({"api", "sec_center", "overview"}, call("overview"), "")
end

function _overview()
    local result = {}
    local posix = require("posix")
    
    local module_path = "/usr/lib/lua/" .. SEC_CENTER_MODULE
    local files = posix.dir(module_path)
    
    if not files then
        return result, 0, 0
    end
    
    local insecure_count = 0
    local total_count = 0
    
    for _, filename in ipairs(files) do
        if filename ~= "." and filename ~= ".." then
            local module_name = string.gsub(filename, "%.lua", "")
            
            local sub_module = require(SEC_CENTER_MODULE .. "." .. module_name)
            local overview_data, has_insecure = sub_module._overview()
            
            if overview_data then
                result[module_name] = overview_data
                total_count = total_count + 1
                
                if has_insecure then
                    insecure_count = insecure_count + 1
                end
            end
        end
    end
    
    result.meta = {
        insecure = insecure_count,
        total = total_count
    }
    
    return result
end

function overview()
    local data = _overview()
    data.code = 0
    http.write_json(data)
end
