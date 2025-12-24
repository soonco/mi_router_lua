--[[
    小米路由器 Zigbee 工具模块
    提供 Zigbee 智能设备（如 Yeelink 智能灯）的管理功能
    
    主要功能:
    - 与 MIIO 通信获取 Zigbee 设备列表
    - 获取 Zigbee 设备数量
    - 将 Yeelink 设备添加到设备列表
]]

module("xiaoqiang.util.XQZigbeeUtil", package.seeall)

local json = require("luci.json")
local XQLog = require("xiaoqiang.XQLog")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")

--[[
    向 Yeelink/MIIO 发送请求
    通过 Thrift 隧道与 MIIO 通信
    
    @param command JSON 格式的命令字符串
    @return 解析后的响应数据
]]
function request_yeelink(command)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local encoded_cmd = XQCryptoUtil.binaryBase64Enc(command)
    local cmd = XQConfigs.THRIFT_TUNNEL_TO_MIIO % encoded_cmd
    
    local luci_util = require("luci.util")
    local response = luci_util.exec(cmd)
    
    return json.decode(response)
end

--[[
    获取 Zigbee 设备数量
    
    @return Zigbee 设备数量，无设备返回 0
]]
function get_zigbee_count()
    local response = request_yeelink('{"command":"device_list"}')
    
    if response ~= nil and response.list ~= nil then
        return #response.list
    end
    
    return 0
end

--[[
    将 Yeelink 设备添加到设备列表
    
    @param device_list 目标设备列表
]]
function append_yeelink_list(device_list)
    local response = request_yeelink('{"command":"device_list"}')
    
    if response == nil or response.list == nil or device_list == nil then
        return
    end
    
    for _, device in ipairs(response.list) do
        local device_info = {}
        
        device_info.mac = device.mac
        device_info.type = "zigbee"
        device_info.ctype = 4
        device_info.ptype = 3
        device_info.online = 0
        device_info.origin_name = device.type
        device_info.origin_info = device
        
        local company_info = {}
        
        if device.type == "light" then
            device_info.name = "智能灯泡"
            company_info.icon = "device_list_intelligent_lamp.png"
            company_info.name = "Yeelink"
        end
        
        device_info.company = company_info
        
        local db_devices = XQDeviceUtil.getDeviceInfoFromDB()
        local db_device = db_devices[device_info.mac]
        
        if db_device ~= nil then
            if not XQFunction.isStrNil(db_device.nickname) then
                device_info.name = db_device.nickname
            end
        end
        
        if not db_device then
            local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
            XQDBUtil.saveDeviceInfo(device_info.mac, device_info.origin_name, "", "", "")
        end
        
        table.insert(device_list, device_info)
    end
end
