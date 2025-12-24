--[[
  小米路由器事件处理模块
  
  功能说明:
  - 处理LAN IP地址变更事件
  - 通知相关模块更新配置
  - 协调DMZ、端口转发、访客WiFi等功能
  
  事件类型:
  - lanIPChange: LAN IP地址变更事件
    - 触发DMZ配置更新
    - 触发端口转发规则更新
    - 触发访客WiFi配置更新
    - 触发LAN/WAN工具配置更新
]]

module("xiaoqiang.XQEvent", package.seeall)

-- LAN IP地址变更事件处理
-- @param old_ip 旧的LAN IP地址
-- @param old_mask 旧的子网掩码
-- @param new_ip 新的LAN IP地址
function lanIPChange(old_ip, old_mask, new_ip)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    -- 参数验证
    if XQFunction.isStrNil(old_ip) then
        return
    end
    
    -- 加载相关模块
    local XQGuestWifi = require("xiaoqiang.module.XQGuestWifi")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    -- 通知DMZ模块更新配置
    -- DMZ主机IP可能需要根据新的LAN网段调整
    XQFirewall.hookDMZLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知访客WiFi模块更新配置
    -- 访客网络的IP分配可能需要调整
    XQGuestWifi.hookLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知端口转发模块更新配置
    -- 端口转发规则中的内网IP可能需要更新
    XQFirewall.hookPortForwardLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知LAN/WAN工具模块更新配置
    XQLanWanUtil.hookLanIPChangeEvent(old_ip, old_mask, new_ip)
end
