--[[
  小米路由器 - 访客WiFi模块
  功能: 管理访客WiFi网络的开启、关闭和配置
  模块名: xiaoqiang.module.XQGuestWifi
]]

module("xiaoqiang.module.XQGuestWifi", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")  -- 通用函数库
local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")    -- WiFi工具库

--[[
  检查访客WiFi是否已配置
  @return boolean 如果访客网络已存在返回true，否则返回false
]]
function _checkGuestWifi()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 检查network配置中是否存在guest网络
    local guestNetwork = cursor:get_all("network", "guest")
    
    if guestNetwork then
        return true
    end
    return false
end

--[[
  LAN IP变更事件钩子函数
  @param oldIP 旧的IP地址
  @param newIP 新的IP地址
  注: 此函数为空实现，预留接口
]]
function hookLanIPChangeEvent(oldIP, newIP)
    -- 空实现，预留接口
end

--[[
  设置访客WiFi
  @param enable        是否启用 (1=启用, 0=禁用)
  @param ssid          WiFi名称
  @param encryption    加密方式
  @param password      WiFi密码
  @param timeout       超时时间
  @param limitSpeed    是否限速
  @param speedLimit    限速值
  @param callback      可选的回调函数
  @return boolean      设置成功返回true，失败返回false
]]
function setGuestWifi(enable, ssid, encryption, password, timeout, limitSpeed, speedLimit, callback)
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    -- 调用WiFi工具库设置访客WiFi
    local result = XQWifiUtil.setGuestWifi(enable, ssid, encryption, password, timeout, limitSpeed, speedLimit)
    
    if not result then
        return false
    end
    
    -- 检查是否需要首次创建访客网络
    local needCreateNetwork = true
    local guestExists = _checkGuestWifi()
    if guestExists then
        needCreateNetwork = false
    end
    
    -- 处理回调或执行默认操作
    if callback then
        if type(callback) == "function" then
            callback(needCreateNetwork)
        end
    elseif needCreateNetwork then
        -- 首次创建: 等待4秒后开启访客WiFi并同步BSSID
        XQFunction.forkExec("sleep 4; /usr/sbin/guestwifi.sh open; lua /usr/sbin/sync_guest_bssid.lua >/dev/null 2>/dev/null")
    else
        -- 已存在: 重启WiFi并同步BSSID
        XQFunction.forkRestartWifi("lua /usr/sbin/sync_guest_bssid.lua")
    end
    
    return true
end

--[[
  删除访客WiFi
  @param wifiIndex WiFi索引 (2.4G或5G)
]]
function delGuestWifi(wifiIndex)
    -- 调用WiFi工具库删除访客WiFi配置
    XQWifiUtil.delGuestWifi(wifiIndex)
    
    -- 等待4秒后执行关闭访客WiFi脚本
    XQFunction.forkExec("sleep 4; /usr/sbin/guestwifi.sh close >/dev/null 2>/dev/null")
end
