--[[
小米社交网络分享API控制器模块 (Mi SNS API Controller)
提供WiFi共享和社交网络相关的API接口，包括：
- WiFi共享开关控制
- WiFi共享信息获取
- 社交网络列表管理
- 访客WiFi黑名单管理
- 授权状态查询

路径: /api/misns/*
认证: jsonauth (需要admin权限)
]]

module("luci.controller.api.misns", package.seeall)

local http = require("luci.http")
local datatypes = require("luci.cbi.datatypes")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")
local XQWifiShare = require("xiaoqiang.module.XQWifiShare")
local XQLog = require("xiaoqiang.XQLog")
local luciUtil = require("luci.util")

--[[
参数安全检查
检查参数是否包含危险字符

@param param string 待检查的参数
@return boolean true表示安全，false表示包含危险字符
]]
function check_para(param)
    local dangerPattern = "[`;'|$&{} ]"
    
    if XQFunction.isStrNil(param) then
        return true
    end
    
    if string.find(param, dangerPattern) then
        return false
    end
    
    return true
end

--[[
路由注册入口函数
注册所有misns相关的API端点
]]
function index()
    local apiNode = node("api", "misns")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 200
    apiNode.sysauth = "admin"
    apiNode.sysauth_authenticator = "jsonauth"
    apiNode.index = true
    
    -- 根节点
    entry({"api", "misns"}, firstchild(), "", 200)
    
    -- WiFi共享准备API
    entry({"api", "misns", "prepare"}, call("prepare"), "", 201, 1)
    entry({"api", "misns", "prepare_bytype"}, call("prepare"), "", 201, 1)
    entry({"api", "misns", "prepare_status"}, call("prepareStatus"), "", 213, 1)
    
    -- WiFi共享控制API
    entry({"api", "misns", "wifi_share_switch"}, call("wifiShare"), "", 202)
    entry({"api", "misns", "wifi_access"}, call("wifiAccess"), "", 203)
    entry({"api", "misns", "wifi_share_info"}, call("wifiShareInfo"), "", 204)
    entry({"api", "misns", "wifi_share_info_web"}, call("wifiShareInfoWeb"), "", 211, 1)
    entry({"api", "misns", "wifi_share_clear"}, call("wifiShareClearAll"), "", 207)
    entry({"api", "misns", "wifi_share_rent_switch"}, call("wifiShareRentSwitch"), "", 212)
    
    -- 社交网络API
    entry({"api", "misns", "sns_list"}, call("snsList"), "", 205)
    entry({"api", "misns", "sns_init"}, call("snsInit"), "", 206, 1)
    
    -- 黑名单管理API
    entry({"api", "misns", "wifi_share_blist"}, call("wifiShareBlacklist"), "", 208)
    entry({"api", "misns", "wifi_share_blist_edit"}, call("wifiShareBlacklistEdit"), "", 209)
    
    -- 授权状态API
    entry({"api", "misns", "authorization_status"}, call("authorizationStatus"), "", 210, 1)
    
    -- iOS就绪API
    entry({"api", "misns", "ios_ready"}, call("iosReady"), "", 214, 1)
end

--[[
获取访客WiFi SSID
生成基于MAC地址的访客WiFi名称

@return string 访客WiFi SSID
]]
function getGuestWifi_ssid_guest()
    local uci = require("luci.model.uci").cursor()
    
    -- 获取WAN接口名称
    local wanIfname = uci:get("network", "wan", "ifname")
    
    -- 获取WAN接口MAC地址
    local macOutput = luciUtil.exec(string.format(
        "ifconfig %s | grep HWaddr |awk -F ' ' '{print $5}'",
        wanIfname
    ))
    
    -- 提取MAC地址后4位
    local macSuffix = string.upper(string.sub(string.gsub(macOutput, ":", ""), -5, -2))
    
    -- 获取国家代码
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local countryCode = XQCountryCode.getCurrentCountryCode()
    
    -- 获取系统信息
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 根据国家和设备类型生成SSID前缀
    local ssidPrefix = "  MiShareWiFi_"
    if countryCode == "CN" then
        local isRedmi = XQSysUtil.isRedmi()
        if isRedmi == 1 then
            ssidPrefix = "  Redmi共享WiFi_"
        else
            ssidPrefix = "  小米共享WiFi_"
        end
    end
    
    return ssidPrefix .. macSuffix
end

--[[
获取Web端WiFi共享信息
API: /api/misns/wifi_share_info_web

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP WiFi共享信息
]]
function wifiShareInfoWeb()
    local result = { code = 0 }
    local callback = http.formvalue("callback")
    
    -- 获取WiFi共享信息
    result.info = XQWifiShare.wifi_share_info_web()
    
    http.write_jsonp(result, callback)
end

--[[
获取WiFi共享信息
API: /api/misns/wifi_share_info

@param guest_index number 访客网络索引(可选，默认1)
@return JSON WiFi共享信息和关闭时间
]]
function wifiShareInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = { code = 0 }
    
    local guestIndex = http.formvalue("guest_index") or 1
    
    -- 获取访客WiFi信息
    local guestWifi = XQWifiUtil.getGuestWifi(guestIndex)
    
    -- 获取WiFi共享信息
    result.info = XQWifiShare.wifi_share_info(guestIndex)
    result.closingTime = tonumber(guestWifi.closingTime)
    
    http.write_json(result)
end

--[[
社交网络初始化
API: /api/misns/sns_init
获取客户端信息用于社交网络分享初始化

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 客户端信息和设备ID
]]
function snsInit()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    
    local result = {
        code = 0,
        clientinfo = "",
        ssid = "",
        deviceid = ""
    }
    
    local callback = http.formvalue("callback")
    
    -- 获取客户端MAC地址
    local remoteMac = luci.dispatcher.getremotemac()
    
    -- 生成访客WiFi SSID
    local guestSsid = getGuestWifi_ssid_guest()
    
    -- 获取DHCP信息
    local dhcpDict = XQDeviceUtil.getDHCPDict()
    local dhcpInfo = dhcpDict[remoteMac] or {}
    local dhcpName = dhcpInfo.name or ""
    
    -- 加密客户端信息
    local encCmd = string.format(
        "matool --method enc --params \"{\\\"mac\\\":\\\"%s\\\",\\\"dhcp\\\":\\\"%s\\\"}\"",
        remoteMac,
        dhcpName
    )
    local clientInfo = luciUtil.trim(luciUtil.exec(encCmd))
    
    result.clientinfo = clientInfo
    result.ssid = guestSsid
    result.deviceid = XQNetUtil.getDeviceId()
    
    http.write_jsonp(result, callback)
end

--[[
WiFi共享准备
API: /api/misns/prepare, /api/misns/prepare_bytype
当前功能未支持

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 状态码
]]
function prepare()
    local result = { code = 0 }
    local callback = http.formvalue("callback")
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_jsonp(result, callback)
end

--[[
获取WiFi共享准备状态
API: /api/misns/prepare_status
当前功能未支持

@return JSON/JSONP 状态码
]]
function prepareStatus()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_jsonp(result, callback)
end

--[[
WiFi共享租赁开关
API: /api/misns/wifi_share_rent_switch
当前功能未支持

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 状态码
]]
function wifiShareRentSwitch()
    local callback = http.formvalue("callback")
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_jsonp(result, callback)
end

--[[
WiFi共享开关控制
API: /api/misns/wifi_share_switch

@param info string JSON格式的共享配置信息
@return JSON 操作结果
]]
function wifiShare()
    local json = require("json")
    local result = { code = 0 }
    
    -- 获取并解析配置信息
    local info = http.formvalue("info", nil, "json")
    
    if XQFunction.isStrNil(info) then
        result.code = 1523
    else
        local success, config = pcall(json.decode, info)
        if not success then
            result.code = 1523
        else
            -- 设置默认访客网络索引
            if config.guest_index == nil or config.guest_index == "" then
                config.guest_index = 1
            end
            
            -- 设置WiFi共享
            XQWifiShare.set_wifi_share(config)
        end
    end
    
    -- 添加错误信息
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    
    http.write_json(result)
end

--[[
WiFi访问控制
API: /api/misns/wifi_access
当前功能未支持

@return JSON 状态码
]]
function wifiAccess()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_json(result)
end

--[[
获取社交网络列表
API: /api/misns/sns_list
当前功能未支持

@return JSON 状态码
]]
function snsList()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_json(result)
end

--[[
清除所有WiFi共享
API: /api/misns/wifi_share_clear
当前功能未支持

@return JSON 状态码
]]
function wifiShareClearAll()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_json(result)
end

--[[
获取WiFi共享黑名单
API: /api/misns/wifi_share_blist
当前功能未支持

@return JSON 状态码
]]
function wifiShareBlacklist()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_json(result)
end

--[[
编辑WiFi共享黑名单
API: /api/misns/wifi_share_blist_edit
当前功能未支持

@return JSON 状态码
]]
function wifiShareBlacklistEdit()
    local result = { code = 0 }
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_json(result)
end

--[[
获取授权状态
API: /api/misns/authorization_status
当前功能未支持

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 状态码
]]
function authorizationStatus()
    local result = { code = 0 }
    local callback = http.formvalue("callback")
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_jsonp(result, callback)
end

--[[
iOS就绪状态
API: /api/misns/ios_ready
当前功能未支持

@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 状态码
]]
function iosReady()
    local result = { code = 0 }
    local callback = http.formvalue("callback")
    
    XQLog.log(6, "Not Supported Now!!! ")
    
    http.write_jsonp(result, callback)
end
