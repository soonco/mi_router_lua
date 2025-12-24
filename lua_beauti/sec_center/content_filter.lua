--[[
  小米路由器安全中心 - 内容过滤模块
  
  功能说明:
  - 提供URL过滤/内容过滤接口
  - 委托给 luci.controller.url_fw.index 模块处理
  - 用于家长控制、网站黑名单等功能
  
  接口:
  - _overview(): 获取内容过滤概览信息
]]

module("sec_center.content_filter", package.seeall)

function _overview()
    local url_fw = require("luci.controller.url_fw.index")
    return url_fw._overview()
end
