--[[
小米ATS服务API控制器模块 (Mi ATS Service API Controller)
提供小米增值服务相关的API接口，包括：
- Token验证
- WiFi MAC过滤管理
- 危险设备检测
- 网络加速服务（免费/VIP）
- 广告拦截信息
- 远程调用接口
- 游戏加速服务
- IPv6加速服务

路径: /api/miats/*
认证: jsonauth (需要admin权限)
]]

module("luci.controller.api.miats", package.seeall)

local XQLog = require("xiaoqiang.XQLog")
local datacenter = require("luci.controller.service.datacenter")
local http = require("luci.http")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")
local cjson = require("cjson")

local UBUS_SERVICE = "eventservice"

-- 错误信息映射表
MIATS_ERR_STR = {
    ["1"] = _("无效的参数"),
    ["2"] = _("token已过期"),
    ["3"] = _("ubus错误")
}

--[[
路由注册入口函数
注册所有miats相关的API端点
]]
function index()
    local apiNode = node("api", "miats")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 400
    apiNode.sysauth = "admin"
    apiNode.sysauth_authenticator = "jsonauth"
    apiNode.index = true
    
    -- 根节点
    entry({"api", "miats"}, firstchild(), _(""), 400)
    
    -- WiFi MAC过滤相关API
    entry({"api", "miats", "wifi_macfilter_info"}, call("getWifiMacfilterInfo"), "", 402, 1)
    entry({"api", "miats", "set_wifi_blist"}, call("set_wifi_black_device"), "", 403, 1)
    entry({"api", "miats", "get_wifi_danger_device"}, call("get_wifi_danger_device"), "", 404, 1)
    entry({"api", "miats", "get_wifi_new_block"}, call("get_wifi_new_block"), "", 405, 1)
    entry({"api", "miats", "get_new_access"}, call("get_new_access"), "", 406, 1)
    
    -- 事件和远程调用API
    entry({"api", "miats", "get_cw_event_info"}, call("get_cw_event_info"), "", 407, 1)
    entry({"api", "miats", "remote_call"}, call("remote_call"), "", 408, 1)
    
    -- 网络加速服务API
    entry({"api", "miats", "get_free_speed_up_info"}, call("get_free_speed_up_info"), "", 409, 1)
    entry({"api", "miats", "free_speed_up"}, call("free_speed_up"), "", 410, 1)
    entry({"api", "miats", "vip_speed_up"}, call("vip_speed_up"), "", 411, 1)
    entry({"api", "miats", "get_vip_pay_info"}, call("get_vip_pay_info"), "", 412, 1)
    entry({"api", "miats", "get_speed_up_total_info"}, call("get_speed_up_total_info"), "", 413, 1)
    
    -- 广告拦截API
    entry({"api", "miats", "get_gg_block_info"}, call("get_ad_block_info"), "", 414, 1)
    
    -- 显示验证API
    entry({"api", "miats", "valid_show_cb"}, call("valid_show_cb"), "", 415, 1)
    entry({"api", "miats", "web_enable_show"}, call("web_enable_show"), "", 416, 1)
    
    -- 上行加速API
    entry({"api", "miats", "uplink_free_speed_up"}, call("uplink_free_speed_up"), "", 417, 1)
    entry({"api", "miats", "uplink_get_free_speed_up_info"}, call("uplink_get_free_speed_up_info"), "", 418, 1)
    entry({"api", "miats", "uplink_vip_speed_up"}, call("uplink_vip_speed_up"), "", 419, 1)
    
    -- Token验证API
    entry({"api", "miats", "validate_token_v2"}, call("validate_token"), "", 420, 1)
    
    -- 通用事件API
    entry({"api", "miats", "general_event_get"}, call("general_event_get"), "", 421, 1)
    
    -- 游戏加速API
    entry({"api", "miats", "ccgame"}, call("turbo_ccgame_call"), "", 422, 1)
    
    -- IPv6加速API
    entry({"api", "miats", "ipv6"}, call("turbo_ipv6_call"), "", 423, 1)
end

--[[
验证token是否有效
通过ubus调用eventservice服务验证token

@param token string 待验证的token
@return table 验证结果 {code=0表示成功}
]]
function is_valid_token(token)
    local result = { code = 1 }
    
    if XQFunction.isStrNil(token) then
        return result
    end
    
    local params = { token = token }
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "verify_token", params)
        conn:close()
        
        if ubusResult then
            return ubusResult
        else
            return result
        end
    end
    
    return result
end

--[[
验证token接口
API: /api/miats/validate_token_v2

@param token string 待验证的token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 验证结果
]]
function validate_token()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
    else
        result.result = tokenResult
    end
    
    http.write_jsonp(result, callback)
end

--[[
获取WiFi MAC过滤信息
API: /api/miats/wifi_macfilter_info

@param token string 验证token
@param model number WiFi模式(可选)
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP MAC过滤配置和设备列表
]]
function getWifiMacfilterInfo()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    local luciUtil = require("luci.util")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    local model = tonumber(http.formvalue("model"))
    local macfilterData = {}
    
    -- 获取MAC过滤配置
    local macfilterInfo = XQWifiUtil.getWiFiMacfilterInfo(model)
    
    -- 获取在线和离线设备列表
    local onlineDevices = XQDeviceUtil.getDeviceList(true)
    local offlineDevices = XQDeviceUtil.getDeviceList()
    
    -- 标记设备是否已添加到过滤列表
    if onlineDevices then
        for _, device in ipairs(onlineDevices) do
            device.added = 0
            for _, filterDevice in ipairs(macfilterInfo or {}) do
                if filterDevice.mac == device.mac then
                    device.added = 1
                    break
                end
            end
        end
    end
    
    macfilterData.enable = macfilterInfo and macfilterInfo.enable
    macfilterData.model = model
    macfilterData.macfilter = macfilterInfo
    
    result.result = macfilterData
    http.write_jsonp(result, callback)
end

--[[
设置WiFi黑名单设备
API: /api/miats/set_wifi_blist

@param token string 验证token
@param mac string 设备MAC地址
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function set_wifi_black_device()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local mac = http.formvalue("mac")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) or XQFunction.isStrNil(mac) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 格式化MAC地址
    mac = XQFunction.macFormat(mac)
    
    -- 添加到黑名单
    XQWifiUtil.editWiFiMacfilterList(0, {mac}, 0)
    
    result.error = 0
    result.mac = mac
    http.write_jsonp(result, callback)
end

--[[
获取WiFi危险设备列表
API: /api/miats/get_wifi_danger_device

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 危险设备列表
]]
function get_wifi_danger_device()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取危险设备信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "rub_network_get", params)
        if ubusResult then
            result.result = ubusResult
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
获取WiFi新拦截设备列表
API: /api/miats/get_wifi_new_block

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 新拦截设备列表
]]
function get_wifi_new_block()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取拦截信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "rub_intercept_get", params)
        if ubusResult then
            result.result = ubusResult
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
获取新接入设备列表
API: /api/miats/get_new_access

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 新接入设备列表
]]
function get_new_access()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取新设备信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "new_device_get", params)
        if ubusResult then
            result.result = ubusResult
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
获取CW事件信息
API: /api/miats/get_cw_event_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 事件信息
]]
function get_cw_event_info()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取FCW事件信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "fcw_get", params)
        if ubusResult then
            result.result = ubusResult
        else
            result.error = 3
            result.msg = MIATS_ERR_STR[tostring(result.error)]
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
远程API调用接口
API: /api/miats/remote_call

@param token string 验证token
@param api string API路径
@param data string 请求数据
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 调用结果
]]
function remote_call()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    local api = http.formvalue("api")
    local data = http.formvalue("data")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) or XQFunction.isStrNil(api) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    local datacenterRequest = {}
    
    -- 处理天翼加速查询API
    local tianyiPos = string.find(api, "/tianyi/api/user/query")
    if not XQFunction.isStrNil(tianyiPos) then
        datacenterRequest.api = 634
        datacenterRequest.pluginID = "2882303761517410304"
        datacenterRequest.info = "{\"api\":1001}"
        local response = datacenter.requestDatacenter(datacenterRequest)
        result.result = luciUtil.trim(response)
        http.write_jsonp(result, callback)
        return
    end
    
    -- 处理天翼上行加速查询API
    local tianyiUplinkPos = string.find(api, "/tianyiUplink/api/user/query")
    if not XQFunction.isStrNil(tianyiUplinkPos) then
        local uplinkRequest = {
            api = 634,
            pluginID = "2882303761517545233",
            info = "{\"api\":1001}"
        }
        local response = datacenter.requestDatacenter(uplinkRequest)
        result.result = luciUtil.trim(response)
        http.write_jsonp(result, callback)
        return
    end
    
    -- 通用API调用
    local cmd = string.format(
        "/usr/bin/matool --method api_call --params \"%s\" \"%s\"",
        XQFunction._cmdformat(api),
        XQFunction._cmdformat(data)
    )
    local response = luciUtil.exec(cmd)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
获取免费加速信息
API: /api/miats/get_free_speed_up_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 免费加速信息
]]
function get_free_speed_up_info()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心获取加速信息
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517410304",
        info = "{\"api\":1006}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
执行免费加速
API: /api/miats/free_speed_up

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function free_speed_up()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心执行免费加速
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517410304",
        info = "{\"api\":1002}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
执行VIP加速
API: /api/miats/vip_speed_up

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function vip_speed_up()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心执行VIP加速
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517410304",
        info = "{\"api\":1007}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
获取VIP支付信息
API: /api/miats/get_vip_pay_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP VIP支付信息
]]
function get_vip_pay_info()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取VIP支付信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "vip_need_repay_get", params)
        if ubusResult then
            result.result = ubusResult
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
获取加速总计信息
API: /api/miats/get_speed_up_total_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 加速总计信息
]]
function get_speed_up_total_info()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 返回固定的加速次数
    result.result = { count = 4 }
    http.write_jsonp(result, callback)
end

--[[
获取广告拦截信息
API: /api/miats/get_gg_block_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 广告拦截统计信息
]]
function get_ad_block_info()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    else
        params.token = token
    end
    
    -- 通过ubus获取广告拦截信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "ad_block_get", params)
        if ubusResult then
            result.result = ubusResult
        else
            result.error = 3
            result.msg = MIATS_ERR_STR[tostring(result.error)]
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
验证用户显示回调
API: /api/miats/valid_show_cb

@param token string 验证token
@return 无返回(内部回调)
]]
function valid_show_cb()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { token = "" }
    local token = http.formvalue("token")
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        return
    else
        -- 获取客户端IP和MAC
        local remoteIp = luci.http.getenv("REMOTE_ADDR") or ""
        local remoteMac = luci.sys.net.ip4mac(remoteIp) or ""
        
        params.token = token
        params.dev_ip = remoteIp
        params.dev_mac = remoteMac
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        return
    end
    
    -- 通过ubus验证用户显示
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "user_valid_show", params)
        if ubusResult then
            result.result = ubusResult
        else
            result.error = 3
            result.msg = MIATS_ERR_STR[tostring(result.error)]
        end
        conn:close()
    end
end

--[[
Web启用显示接口
API: /api/miats/web_enable_show

@param domain string 域名
@param eventType number 事件类型
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function web_enable_show()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local params = { domain = "" }
    local domain = http.formvalue("domain")
    local eventType = http.formvalue("eventType")
    
    -- 获取客户端信息
    local remoteIp = luci.http.getenv("REMOTE_ADDR") or ""
    local remoteMac = luci.sys.net.ip4mac(remoteIp) or ""
    
    local callback = http.formvalue("callback")
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(domain) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        return
    else
        params.domain = domain
        params.eventType = tonumber(eventType)
        params.dev_mac = remoteMac
    end
    
    -- 通过ubus调用wie2s
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "wie2s", params)
        if ubusResult then
            result.result = ubusResult
        else
            result.error = 3
            result.msg = MIATS_ERR_STR[tostring(result.error)]
        end
        conn:close()
    end
    
    http.write_jsonp(result, callback)
end

--[[
上行免费加速
API: /api/miats/uplink_free_speed_up

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function uplink_free_speed_up()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心执行上行免费加速
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517545233",
        info = "{\"api\":1002}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
获取上行免费加速信息
API: /api/miats/uplink_get_free_speed_up_info

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 上行加速信息
]]
function uplink_get_free_speed_up_info()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心获取上行加速信息
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517545233",
        info = "{\"api\":1006}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
上行VIP加速
API: /api/miats/uplink_vip_speed_up

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function uplink_vip_speed_up()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = 1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = 2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 请求数据中心执行上行VIP加速
    local datacenterRequest = {
        api = 634,
        pluginID = "2882303761517545233",
        info = "{\"api\":1007}"
    }
    local response = datacenter.requestDatacenter(datacenterRequest)
    result.result = luciUtil.trim(response)
    
    http.write_jsonp(result, callback)
end

--[[
获取通用事件信息
API: /api/miats/general_event_get

@param token string 验证token
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 事件信息
]]
function general_event_get()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = -1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = -2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    local eventResult = { code = 0 }
    local params = { token = token }
    
    -- 通过ubus获取通用事件信息
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        local ubusResult = conn:call(UBUS_SERVICE, "general_event_get", params)
        conn:close()
        
        if ubusResult then
            eventResult = ubusResult
        else
            eventResult.code = -5
            eventResult.msg = "ubus get event info failed."
        end
    end
    
    result.result = eventResult
    http.write_jsonp(result, callback)
end

--[[
游戏加速调用接口
API: /api/miats/ccgame

支持的命令(cmd):
- 0-9: 不同的游戏加速操作

@param token string 验证token
@param cmd number 命令ID
@param ip string IP列表(可选)
@param byvpn string 是否通过VPN(可选)
@param game string 游戏ID(可选)
@param region string 区域ID(可选)
@param ubus string ubus命令(可选)
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function turbo_ccgame_call()
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = -1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 验证token
    local tokenResult = is_valid_token(token)
    if tokenResult.code ~= 0 then
        result.error = -2
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    local ccgameResult = { code = 0 }
    local cmdId = tonumber(http.formvalue("cmd") or 0)
    
    -- 加载游戏加速模块
    local ccgameInterface = require("turbo.ccgame.ccgame_interface")
    
    if not ccgameInterface then
        ccgameResult.code = -1
        ccgameResult.msg = "not support ccgame."
    elseif cmdId < 0 or cmdId > 9 then
        ccgameResult.code = -1
        ccgameResult.msg = "action id is not valid"
    else
        -- 构建请求参数
        local request = {
            cmdid = cmdId,
            token = token,
            data = {}
        }
        
        local ip = http.formvalue("ip")
        local byvpn = http.formvalue("byvpn")
        local game = http.formvalue("game")
        local region = http.formvalue("region")
        local ubusCmd = http.formvalue("ubus")
        
        if ip then
            request.data.iplist = XQFunction._cmdformat(ip)
        end
        
        if byvpn and byvpn ~= "0" then
            request.data.byvpn = "0"
        else
            request.data.byvpn = "1"
        end
        
        if game and region then
            request.data.gameid = XQFunction._cmdformat(game)
            request.data.regionid = XQFunction._cmdformat(region)
        end
        
        if ubusCmd then
            request.ubus = XQFunction._cmdformat(ubusCmd)
        end
        
        -- 调用游戏加速接口
        ccgameResult = ccgameInterface.ccgame_call(request)
    end
    
    result.result = ccgameResult
    http.write_jsonp(result, callback)
end

--[[
IPv6加速调用接口
API: /api/miats/ipv6

支持的命令(cmd):
- 0: 自定义ubus命令
- 1: 启动加速
- 2: 停止加速
- 3: 获取状态

@param token string 验证token
@param cmd number 命令ID
@param ubus string ubus命令(cmd=0时使用)
@param callback string JSONP回调函数名(可选)
@return JSON/JSONP 操作结果
]]
function turbo_ipv6_call()
    local luciUtil = require("luci.util")
    local result = {
        error = 0,
        msg = "OK"
    }
    
    local token = http.formvalue("token")
    local callback = http.formvalue("callback")
    local cmdId = tonumber(http.formvalue("cmd") or 0)
    local ubusCmd = XQFunction._cmdformat(http.formvalue("ubus") or "")
    
    if XQFunction.isStrNil(callback) then
        callback = "noname"
    end
    
    -- 参数验证
    if XQFunction.isStrNil(token) then
        result.error = -1
        result.msg = MIATS_ERR_STR[tostring(result.error)]
        http.write_jsonp(result, callback)
        return
    end
    
    -- 特殊情况：获取状态或get_pass命令不需要验证token
    if not (cmdId == 3 or (cmdId == 0 and ubusCmd == "get_pass")) then
        local tokenResult = is_valid_token(token)
        if tokenResult.code ~= 0 then
            result.error = -2
            result.msg = MIATS_ERR_STR[tostring(result.error)]
            http.write_jsonp(result, callback)
            return
        end
    end
    
    local ipv6Result = { code = 0 }
    
    if cmdId < 0 or cmdId > 3 then
        ipv6Result.code = -1
        ipv6Result.msg = "action id is not valid"
    else
        local ubus = require("ubus")
        local conn = ubus.connect()
        
        if not conn then
            ipv6Result.code = -1
            ipv6Result.msg = "ubus cannot connected."
        else
            local ubusMethod = nil
            local ubusService = "turbo_ipv6"
            local ubusParams = {}
            
            if cmdId == 1 then
                -- 启动加速前需要激活账户
                local accountRequest = { provider = "sellon" }
                local accountCmd = "matool --method api_call_post --params /device/vip/account '" 
                    .. cjson.encode(accountRequest) .. "'"
                
                local success, accountResult = pcall(function()
                    return cjson.decode(luciUtil.trim(luciUtil.exec(accountCmd)))
                end)
                
                if success and accountResult and type(accountResult) == "table" and accountResult.code == 0 then
                    ubusMethod = "start"
                else
                    ipv6Result.code = -1
                    ipv6Result.msg = "active account failed. pls check if account binded or network is connected."
                    ubusMethod = nil
                end
            elseif cmdId == 2 then
                ubusMethod = "stop"
            elseif cmdId == 3 then
                ubusMethod = "status"
            elseif cmdId == 0 then
                ubusMethod = XQFunction._cmdformat(http.formvalue("ubus") or "")
            else
                ubusMethod = nil
                ipv6Result.msg = "not supported command."
            end
            
            if ubusMethod and ubusMethod ~= "" then
                local ubusResult = conn:call(ubusService, ubusMethod, ubusParams)
                conn:close()
                
                if ubusResult then
                    ipv6Result = ubusResult
                else
                    ipv6Result.code = -1
                    ipv6Result.msg = "call ubus failed."
                end
            else
                ipv6Result.code = -1
            end
        end
    end
    
    result.result = ipv6Result
    http.write_jsonp(result, callback)
end
