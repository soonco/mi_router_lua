--[[
  小米路由器安全中心 - 日志模块
  
  功能说明:
  - 提供安全日志概览接口
  - 委托给 luci.controller.api.milog 模块处理
  
  接口:
  - _overview(): 获取日志概览信息
]]

module("sec_center.log", package.seeall)

function _overview()
    local milog = require("luci.controller.api.milog")
    return milog._overview()
end
