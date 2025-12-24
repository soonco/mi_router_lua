---
--- 小米路由器智能家居控制API模块
--- 模块路径: luci.controller.api.xqsmarthome
---
--- 功能概述:
---   提供智能家居设备控制的API接口，支持多种小米生态设备
---
--- 支持的设备类型:
---   - 智能家居设备 (SmartHome) - 通过Thrift隧道通信
---   - 智能控制器 (SmartController) - Mesh网络下的智能设备控制
---   - MIIO设备 - 小米IoT平台设备
---   - Yeelink设备 - 易来智能灯具
---   - 小米电视 (MiTV)
---   - 小米摄像头 (Camera)
---
--- API端点:
---   /api/xqsmarthome/request           - 智能家居请求隧道
---   /api/xqsmarthome/request_smartcontroller - 智能控制器请求
---   /api/xqsmarthome/request_miio      - MIIO设备请求
---   /api/xqsmarthome/request_yeelink   - Yeelink设备请求
---   /api/xqsmarthome/request_mitv      - 小米电视请求
---   /api/xqsmarthome/request_camera    - 摄像头请求
---   /api/xqsmarthome/request_miiolist  - 获取MIIO设备列表
---
--- 依赖模块:
---   - luci.http: HTTP请求处理
---   - xiaoqiang.common.XQConfigs: 配置常量
---   - xiaoqiang.common.XQFunction: 通用工具函数
---   - xiaoqiang.util.XQCryptoUtil: 加密工具(Base64编码)
---   - xiaoqiang.util.XQMitvUtil: 小米电视工具
---   - xiaoqiang.util.XQCameraUtil: 摄像头工具
---   - xiaoqiang.XQLog: 日志模块
---

module("luci.controller.api.xqsmarthome", package.seeall)

local http = require("luci.http")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")

--- 模块路由注册入口
--- 配置智能家居API的所有路由端点
function index()
    --- 创建智能家居API节点
    local apiNode = node("api", "xqsmarthome")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 500
    apiNode.sysauth = "admin"                   -- 需要管理员认证
    apiNode.sysauth_authenticator = "jsonauth"  -- JSON认证方式
    apiNode.index = true

    --- 注册API路由
    --- 智能家居请求隧道
    entry({"api", "xqsmarthome", "request"}, call("tunnelSmartHomeRequest"), _(""), 501)
    --- 智能控制器请求(Mesh网络)
    entry({"api", "xqsmarthome", "request_smartcontroller"}, call("tunnelSmartControllerRequest"), _(""), 502)
    --- MIIO设备请求
    entry({"api", "xqsmarthome", "request_miio"}, call("tunnelMiioRequest"), _(""), 503)
    --- 小米电视请求
    entry({"api", "xqsmarthome", "request_mitv"}, call("requestMitv"), _(""), 504)
    --- Yeelink智能灯请求
    entry({"api", "xqsmarthome", "request_yeelink"}, call("tunnelYeelink"), _(""), 505)
    --- 摄像头请求
    entry({"api", "xqsmarthome", "request_camera"}, call("requestCamera"), _(""), 506)
    --- 获取MIIO设备列表
    entry({"api", "xqsmarthome", "request_miiolist"}, call("requestMiioList"), _(""), 507)
end

--- 智能家居请求隧道
--- 将请求通过Thrift隧道转发到智能家居服务
--- @param payload: 请求载荷(JSON格式)
--- 处理流程:
---   1. 获取HTTP请求中的payload参数
---   2. 使用Base64编码payload
---   3. 通过Thrift隧道命令发送到智能家居服务
---   4. 返回执行结果
function tunnelSmartHomeRequest()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    --- 获取请求载荷并进行Base64编码
    local payload = http.formvalue("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)
    
    --- 构建Thrift隧道命令
    --- XQConfigs.THRIFT_TUNNEL_TO_SMARTHOME 是命令模板，使用%s占位符
    local command = XQConfigs.THRIFT_TUNNEL_TO_SMARTHOME % encodedPayload
    
    --- 执行命令并返回结果
    local LuciUtil = require("luci.util")
    http.write(LuciUtil.exec(command))
end

--- 智能控制器请求隧道
--- 用于Mesh网络环境下的智能设备控制
--- 特殊处理: 对于重启和WiFi关闭操作，需要同步到MQTT
--- @param payload: 请求载荷(JSON格式)，包含command字段
--- 处理流程:
---   1. 解析payload中的command字段
---   2. 检查是否为Mesh模式
---   3. 对于特殊操作(重启/WiFi关闭)，通过MQTT同步
---   4. 通过Thrift隧道发送请求
function tunnelSmartControllerRequest()
    local XQLog = require("xiaoqiang.XQLog")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    local json = require("json")
    
    --- 解析请求载荷
    local rawPayload = http.formvalue("payload") or ""
    local payloadData = json.decode(rawPayload)
    
    --- 验证并提取command字段
    --- validJsonParam(data, field, type, required)
    --- type=2 表示字符串类型, required=1 表示必填
    local commandData = XQFunction.validJsonParam(payloadData, "command", 2, 1)
    
    --- 对command进行Base64编码
    local encodedCommand = XQCryptoUtil.binaryBase64Enc(json.encode(commandData))
    
    local LuciUtil = require("luci.util")
    local mqttCommand = nil
    
    --- 检查是否为Mesh模式
    --- 在Mesh模式下，某些操作需要通过MQTT同步到其他节点
    if XQFunction.isMeshMode() then
        local actionList = commandData.action_list
        if actionList then
            local actionType = actionList[1].type
            XQLog.log(6, "http_data.action_list.type: " .. actionType)
            
            --- 对于重启和WiFi关闭操作，需要MQTT同步
            --- normal_reboot: 正常重启
            --- normal_wifi_down: 关闭WiFi
            if actionType == "normal_reboot" or actionType == "normal_wifi_down" then
                --- 构建MQTT同步命令
                --- 1. 发送智能家居消息到MQTT
                --- 2. 等待2秒确保消息发送
                --- 3. 通知状态变更
                mqttCommand = "ubus call xq_info_sync_mqtt send_smart '{\"msg\":\"" 
                    .. encodedCommand 
                    .. "\"}';sleep 2;ubus call xq_info_sync_mqtt smart_changed"
                
                XQLog.log(6, "trafficd: " .. mqttCommand)
                
                --- 异步执行MQTT同步命令
                XQFunction.forkExec(mqttCommand)
            end
        end
    end
    
    --- 构建Thrift隧道命令发送到智能控制器
    local command = XQConfigs.THRIFT_TUNNEL_TO_SMARTHOME_CONTROLLER % encodedCommand
    
    --- 执行命令并返回结果
    http.write(LuciUtil.exec(command))
end

--- 访客模式下的智能控制器请求
--- 内部函数，不通过HTTP暴露
--- @param encodedPayload: 已编码的请求载荷
function guest_tunnelSmartControllerRequest(encodedPayload)
    local XQLog = require("xiaoqiang.XQLog")
    local LuciUtil = require("luci.util")
    
    --- 构建并执行Thrift隧道命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_SMARTHOME_CONTROLLER % encodedPayload
    LuciUtil.exec(command)
end

--- MIIO设备请求隧道
--- 将请求转发到MIIO(小米IoT)设备
--- @param payload: 请求载荷
--- MIIO协议用于与小米IoT平台设备通信
function tunnelMiioRequest()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    --- 获取请求载荷并进行Base64编码
    local payload = http.formvalue("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)
    
    --- 构建MIIO隧道命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_MIIO % encodedPayload
    
    --- 执行命令并返回结果
    local LuciUtil = require("luci.util")
    http.write(LuciUtil.exec(command))
end

--- Yeelink设备请求隧道
--- 将请求转发到Yeelink(易来)智能灯设备
--- @param payload: 请求载荷
--- Yeelink是小米生态链的智能照明品牌
--- 注意: 实际使用与MIIO相同的隧道
function tunnelYeelink()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    --- 获取请求载荷并进行Base64编码
    local payload = http.formvalue("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)
    
    --- 构建MIIO隧道命令(Yeelink使用MIIO协议)
    local command = XQConfigs.THRIFT_TUNNEL_TO_MIIO % encodedPayload
    
    --- 执行命令并返回结果
    local LuciUtil = require("luci.util")
    http.write(LuciUtil.exec(command))
end

--- 小米电视请求
--- 将请求转发到小米电视设备
--- @param payload: 请求载荷
function requestMitv()
    --- 获取请求载荷
    local payload = http.formvalue("payload")
    
    --- 使用小米电视工具模块处理请求
    local XQMitvUtil = require("xiaoqiang.util.XQMitvUtil")
    
    --- 发送请求并返回结果
    http.write(XQMitvUtil.request(payload))
end

--- 获取MIIO设备列表
--- 返回路由器已发现的所有MIIO设备及其token
--- 使用matool工具调用设备API
function requestMiioList()
    local LuciUtil = require("luci.util")
    
    --- 调用matool获取设备token列表
    --- matool是小米路由器的设备管理工具
    --- /device/miot_get_device_tokens 接口返回所有已发现设备
    local result = LuciUtil.exec("/usr/bin/matool --method api_call --params /device/miot_get_device_tokens")
    
    http.write(result)
end

--- 摄像头请求
--- 将请求转发到小米摄像头设备
--- @param payload: 请求载荷
function requestCamera()
    --- 获取请求载荷
    local payload = http.formvalue("payload")
    
    --- 使用摄像头工具模块处理请求
    local XQCameraUtil = require("xiaoqiang.util.XQCameraUtil")
    
    --- 发送请求并返回结果
    http.write(XQCameraUtil.request(payload))
end
