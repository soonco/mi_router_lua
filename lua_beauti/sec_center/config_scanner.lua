--[[
  小米路由器安全中心 - 配置扫描模块
  
  功能说明:
  - 提供路由器配置安全扫描接口
  - 委托给 luci.controller.config_scan.index 模块处理
  - 检测不安全的配置项
  
  接口:
  - _overview(): 获取配置扫描概览信息
]]

module("sec_center.config_scanner", package.seeall)

function _overview()
    local config_scan = require("luci.controller.config_scan.index")
    return config_scan._overview()
end
