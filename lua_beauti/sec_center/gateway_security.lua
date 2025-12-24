--[[
  小米路由器安全中心 - 网关安全模块
  
  功能说明:
  - 提供网关/路由器安全防护接口
  - 委托给 luci.controller.anti_attack.index 模块处理
  - 包含防攻击、入侵检测等功能
  
  接口:
  - _overview(): 获取网关安全概览信息
]]

module("sec_center.gateway_security", package.seeall)

function _overview()
    local anti_attack = require("luci.controller.anti_attack.index")
    return anti_attack._overview()
end
