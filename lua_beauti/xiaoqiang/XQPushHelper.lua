--[[
  小米路由器推送助手模块
  
  功能说明:
  - 设备连接/断开推送通知
  - 系统升级推送通知
  - WiFi认证失败推送通知
  - 特殊设备(小米设备)识别
  - 通过matool和eventservice发送推送
  
  推送类型:
  - type=1: 系统升级完成
  - type=3: 陌生设备上线
  - type=23: 小米路由器中继成功
  - type=27: 访客网络设备上线
  - type=56: 小米中继器连接
  
  特殊设备匹配规则:
  - chuangmi-plug: 创米智能插座
  - antscam: 蚂蚁摄像头
  - yeelink-light: Yeelight灯具
  - lumi-gateway: 绿米网关
  - zhimi-airpurifier: 智米空气净化器
  - yunmi-waterpurifier: 云米净水器
  - midea-aircondition: 美的空调
  - xiaomirepeater: 小米中继器
]]

module("xiaoqiang.XQPushHelper", package.seeall)

local json = require("json")
local XQLog = require("xiaoqiang.XQLog")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQPushUtil = require("xiaoqiang.util.XQPushUtil")

-- 特殊设备匹配模式列表（这些设备不触发陌生设备上线通知）
local EXCEPTION_DEVICE_PATTERNS = {
    "^chuangmi%-plug",      -- 创米智能插座
    "^antscam",             -- 蚂蚁摄像头
    "^yeelink%-light",      -- Yeelight灯具
    "^lumi%-gateway",       -- 绿米网关
    "^zhimi%-airpurifier",  -- 智米空气净化器
    "^yunmi%-waterpurifier", -- 云米净水器
    "^midea%-aircondition", -- 美的空调
    "^xiaomirepeater"       -- 小米中继器
}

-- 检查是否为特殊设备（不需要推送通知的设备）
-- @param dhcpname 设备DHCP名称
-- @return boolean 是否为特殊设备
function _exception(dhcpname)
    if dhcpname then
        for _, pattern in ipairs(EXCEPTION_DEVICE_PATTERNS) do
            if dhcpname:match(pattern) then
                return true
            end
        end
    end
    return false
end

-- 执行推送通知
-- @param payload JSON格式的推送内容
-- @param title 推送标题
-- @param content 推送内容
-- @param priority 优先级（可选）
-- @param async 是否异步执行（可选）
function _doPush(payload, title, content, priority, async)
    if not (payload and title) or not content then
        return
    end
    
    -- 格式化推送内容
    payload = XQFunction._cmdformat(payload)
    
    -- 默认优先级为1
    local prio = "1"
    if priority then
        prio = tostring(priority)
    end
    
    -- 构建matool命令
    local cmd = string.format("matool --method notify --params \"%s\"", payload)
    
    -- 执行命令（异步或同步）
    if async then
        XQFunction.forkExec(cmd)
    else
        os.execute(cmd)
    end
    
    XQLog.log(6, "matool notify:", payload)
end

-- 通过eventservice发送推送
-- @param event_type 事件类型
-- @param mac 设备MAC地址
-- @param name 设备名称
-- @param count 计数
function _doEventServicePush(event_type, mac, name, count)
    local service_name = "eventservice"
    local params = {
        type = event_type,
        mac = mac,
        name = name,
        count = count
    }
    
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        conn:call(service_name, "fcw_notify", params)
        conn:close()
        XQLog.log(6, "eventservice notify:", params)
    end
end

-- 通过matool上报事件
-- @param events 事件JSON字符串
-- @param async 是否异步执行
function _matool(events, async)
    if XQFunction.isStrNil(events) then
        return
    end
    
    local cmd = string.format("matool --method reportEvents --params '[%s]'", events)
    XQLog.log(4, cmd)
    
    if async then
        XQFunction.forkExec(cmd)
    else
        os.execute(cmd)
    end
    
    XQLog.log(4, "WiFi/LOGIN Authen failed: " .. events)
end

-- 系统升级完成推送钩子
function _hookSysUpgraded()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local rom_version = XQSysUtil.getRomVersion()
    
    local push_data = {
        type = 1,           -- 系统升级类型
        ver = rom_version   -- 当前ROM版本
    }
    
    _doPush(json.encode(push_data), "系统升级", "系统升级")
end

-- WiFi设备连接推送钩子
-- @param mac 设备MAC地址
-- @param interface 连接的网络接口
function _hookWifiConnect(mac, interface)
    if XQFunction.isStrNil(mac) then
        return
    end
    
    -- 格式化MAC地址
    mac = XQFunction.macFormat(mac)
    local mac_key = mac:gsub(":", "")
    
    -- 获取UCI配置
    local uci = require("luci.model.uci").cursor()
    local guest_interface = uci:get("misc", "wireless", "guest_2G") or ""
    local current_time = tonumber(os.time())
    
    -- 检查设备历史记录
    local device_history = uci:get("devicelist", "history", mac_key)
    local is_new_device = false
    local is_special_device = false
    local device_count = 0
    
    if not device_history then
        is_new_device = true
        
        -- 检查历史记录数量限制
        local history_count = 0
        uci:foreach("devicelist", "history", function(s)
            history_count = history_count + 1
        end)
        
        -- 最多保存512条历史记录
        if history_count >= 512 then
            return
        end
        
        -- 保存新设备到历史记录
        uci:set("devicelist", "history", mac_key, current_time)
        uci:commit("devicelist")
    end
    
    -- 检查是否为特殊关注设备
    local special_device = uci:get("devicelist", "special", mac_key)
    if special_device then
        is_special_device = true
    end
    
    -- 处理新设备或特殊设备
    if is_new_device or is_special_device then
        local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
        local device_info = XQDeviceUtil.getDeviceInfo(mac)
        local device_name = device_info.dhcpname
        
        -- 检查是否为小米路由器中继
        if device_name and device_name:match("^miwifi") then
            local push_data = {
                type = 23,
                name = "小米路由器"
            }
            _doPush(json.encode(push_data), "中继成功", "中继成功")
            return
        end
        
        -- 检查是否为小米中继器
        if device_name and device_name:match("^xiaomirepeater") then
            local push_data = {
                type = 56,
                name = "小米中继器",
                mac = mac
            }
            _doPush(json.encode(push_data), "中继成功", "中继成功")
            return
        end
        
        -- 检查是否为特殊设备（不推送）
        local dhcpname_lower = string.lower(device_info.dhcpname or "")
        if is_new_device and _exception(dhcpname_lower) then
            return
        end
        
        -- 处理Android设备名称（截断过长的名称）
        if device_name then
            local name_lower = string.lower(device_name)
            if name_lower:match("android-%S+") then
                if #device_name > 12 then
                    device_name = device_name:sub(1, 12)
                end
            end
        end
        
        -- 跳过特定设备类型（如电视、游戏机等）
        local device_type = device_info.type
        if device_type then
            -- 跳过电视设备 (c=2, p=6) 或游戏机 (c=3, p=2) 或 (c=3, p=7)
            if (device_type.c == 2 and device_type.p == 6) or
               (device_type.c == 3 and device_type.p == 2) or
               (device_type.c == 3 and device_type.p == 7) then
                return
            end
        end
        
        -- 新设备上线推送
        if is_new_device then
            local push_settings = XQPushUtil.pushSettings()
            
            if push_settings.auth and push_settings.level and push_settings.level >= 2 then
                -- 如果设备名称为空，等待4秒后重新获取
                if XQFunction.isStrNil(device_info.dhcpname) then
                    os.execute("sleep 4")
                    device_info = XQDeviceUtil.getDeviceInfo(mac)
                    dhcpname_lower = string.lower(device_info.dhcpname or "")
                    
                    if _exception(dhcpname_lower) then
                        return
                    end
                end
                
                local push_data = {
                    type = 3,           -- 陌生设备上线
                    mac = mac,
                    name = device_name
                }
                
                -- 访客网络设备使用不同的推送类型
                if interface == guest_interface then
                    push_data.type = 27
                end
                
                _doPush(json.encode(push_data), "陌生设备上线", "陌生设备上线")
                
                -- 保存设备信息到数据库
                if device_info.flag == 0 then
                    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
                    XQDBUtil.saveDeviceInfo(mac, device_info.dhcpname, "", "", "")
                end
                
                XQLog.log(6, "New Device Connect.", device_info)
            end
        elseif is_special_device then
            -- 特殊关注设备上线
            XQLog.log(6, "Special Device Connect.", device_info)
            
            local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
            XQDBUtil.vip_device_pre_push(mac, device_name, "online")
        end
    end
end

-- WiFi设备断开推送钩子
-- @param mac 设备MAC地址
-- @param interface 断开的网络接口
-- @param reason 断开原因
function _hookWifiDisconnect(mac, interface, reason)
    if XQFunction.isStrNil(mac) then
        return
    end
    
    mac = XQFunction.macFormat(mac)
    
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local device_info = XQDeviceUtil.getDeviceInfo(mac)
    local device_name = reason
    local dhcpname_lower = string.lower(device_info.dhcpname or "")
    
    -- 检查是否为特殊关注设备
    local uci = require("luci.model.uci").cursor()
    local mac_key = mac:gsub(":", "")
    local special_device = uci:get("devicelist", "special", mac_key)
    
    if special_device then
        XQLog.log(6, "Special Device Disconnect.", device_info)
        
        local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
        XQDBUtil.vip_device_pre_push(mac, device_name, "offline")
    end
end
