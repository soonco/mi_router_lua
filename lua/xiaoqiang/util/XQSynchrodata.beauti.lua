---
--- XQSynchrodata 数据同步工具模块
--- 小米路由器配置数据同步工具
--- 功能：路由器名称、WiFi SSID、QoS配置、OTA信息、设备信息同步到云端
---

module("xiaoqiang.util.XQSynchrodata", package.seeall)

local json = require("json")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

local messageClientLoaded, messageClient = pcall(require, "messageclient")

--- 发送数据到云端（备用方案）
--- @param key string 数据键名
--- @param value string 数据值
local function _sendData(key, value)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    if not XQFunction.isStrNil(key) and not XQFunction.isStrNil(value) then
        os.execute(string.format(
            "matool --method setKVB64 --params \"%s\" \"%s\"",
            key,
            XQCryptoUtil.binaryBase64Enc(value)
        ))
    end
end

if not messageClientLoaded then
    messageClient = {}
    messageClient.send = _sendData
end

--- 同步路由器名称
--- @param routerName string 路由器名称
function syncRouterName(routerName)
    if not XQFunction.isStrNil(routerName) then
        messageClient.send("router_name", routerName)
    end
end

--- 同步路由器语言区域设置
--- @param locale string 语言区域代码
function syncRouterLocale(locale)
    local localeStr = tostring(locale)
    
    if not XQFunction.isStrNil(localeStr) then
        messageClient.send("router_locale", localeStr)
    end
end

--- 同步WiFi SSID
--- @param ssid24g string 2.4GHz WiFi SSID
--- @param ssid5g string 5GHz WiFi SSID
function syncWiFiSSID(ssid24g, ssid5g)
    if ssid24g then
        messageClient.send("ssid_24G", ssid24g)
    end
    
    if ssid5g then
        messageClient.send("ssid_5G", ssid5g)
    end
end

--- 上传配置到云端
--- @param config table 配置数据表
function uploadConf(config)
    if config then
        if type(config) == "table" then
            local jsonLib = require("json")
            XQFunction.forkExec(string.format(
                "matool --method api_call_post --params /device/router_conf/upload \"%s\"",
                XQFunction._cmdformat(jsonLib.encode(config))
            ))
        end
    end
end

--- 同步工作模式
--- @param workMode number 工作模式编号
function syncWorkMode(workMode)
    if workMode then
        messageClient.send("work_mode", tostring(workMode))
    end
end

--- 同步主动AP客户端模式
--- @param apcliMode number AP客户端模式
function syncActiveApcliMode(apcliMode)
    if apcliMode then
        messageClient.send("active_apcli_mode", tostring(apcliMode))
    end
end

--- 同步AP模式下的LAN IP
--- @param lanIp string LAN IP地址
function syncApLanIp(lanIp)
    if lanIp then
        messageClient.send("ap_lan_ip", tostring(lanIp))
    end
end

--- 同步安全保护状态
--- @param enabled boolean 是否启用保护
--- @param mode number 保护模式
function syncProtectionStatus(enabled, mode)
    if enabled then
        messageClient.send("protection_enabled", tostring(enabled))
        messageClient.send("protection_mode", tostring(mode))
    end
end

--- 同步QoS信息
function syncQosInfo()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    local macList = XQDeviceUtil.getDeviceMacsFromDB()
    local qosHistory = XQQoSUtil.qosHistory(macList)
    
    qosHistory.guest = XQQoSUtil.guestQoSInfo()
    qosHistory["local"] = XQQoSUtil.xqQoSInfo()
    
    messageClient.send("qos_info", json.encode(qosHistory))
end

--- 同步OTA自动更新信息
function syncOTAInfo()
    local XQPredownload = require("xiaoqiang.module.XQPredownload")
    
    local predownloadInfo = XQPredownload.predownloadInfo()
    
    messageClient.send("auto_ota_rom", tostring(predownloadInfo.auto))
    messageClient.send("auto_ota_plugin", tostring(predownloadInfo.plugin))
end

--- 同步设备信息
--- @param deviceInfo table 设备信息表
function syncDeviceInfo(deviceInfo)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQParentControl = require("xiaoqiang.module.XQParentControl")
    
    if deviceInfo then
        local macAddr = deviceInfo.mac
        
        if macAddr then
            local macDict = {}
            macDict[macAddr] = 1
            
            local parentCtlRules = XQParentControl.parentctl_rules(macDict)
            local netacctlStatus = XQParentControl.netacctl_status(macDict)
            local urlfilterInfo = XQParentControl.get_urlfilter_info(macDict)
            
            local syncData = {}
            syncData.mac = macAddr
            syncData.lan = 1
            syncData.wan = deviceInfo.wan
            syncData.admin = 1
            syncData.limited = 0
            syncData.nickname = ""
            syncData.pridisk = 0
            syncData.owner = ""
            syncData.device = ""
            syncData.push = 0
            syncData.pcontrol = parentCtlRules[macAddr]
            syncData.netacctl = netacctlStatus[macAddr]
            syncData.urlfilter = urlfilterInfo[macAddr]
            
            local apiRequest = {
                api = 70,
                macs = {macAddr}
            }
            
            local canAccessAllDisk = {}
            local macfilterDict = XQFirewall.getMacfilterInfoDict()
            local deviceConfig = XQDeviceUtil.fetchDeviceInfoFromConfig(macAddr)
            
            local apiResult = XQFunction.thrift_tunnel_to_datacenter(json.encode(apiRequest))
            
            if apiResult then
                if apiResult.code == 0 then
                    canAccessAllDisk = apiResult.canAccessAllDisk
                end
            end
            
            local macfilterInfo = macfilterDict[macAddr]
            local wifiMacfilterModel = XQWifiUtil.getWiFiMacfilterModel()
            
            if wifiMacfilterModel == 1 then
                local macfilterList = XQWifiUtil.getCurrentMacfilterList()
                if macfilterList then
                    for _, mac in ipairs(macfilterList) do
                        if mac == macAddr then
                            syncData.limited = 1
                            break
                        end
                    end
                end
            end
            
            if deviceInfo.push then
                syncData.push = deviceInfo.push
            else
                local hasNotify, notifyLevel = XQPushUtil.specialNotify(macAddr)
                syncData.push = hasNotify and notifyLevel or 0
            end
            
            if macfilterInfo then
                syncData.wan = macfilterInfo.wan and 1 or 0
                syncData.lan = macfilterInfo.lan and 1 or 0
                syncData.admin = macfilterInfo.admin and 1 or 0
                syncData.pridisk = macfilterInfo.pridisk and 1 or 0
            end
            
            if canAccessAllDisk[macAddr] ~= nil then
                syncData.lan = canAccessAllDisk[macAddr] and 1 or 0
            end
            
            if deviceConfig then
                syncData.owner = deviceConfig.owner
                syncData.device = deviceConfig.device
            end
            
            if deviceInfo.nickname then
                syncData.nickname = deviceInfo.nickname
            else
                local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
                local dbDeviceInfo = XQDBUtil.fetchDeviceInfo(macAddr)
                if dbDeviceInfo and dbDeviceInfo.nickname then
                    syncData.nickname = dbDeviceInfo.nickname
                end
            end
            
            if deviceInfo.lan then
                syncData.lan = deviceInfo.lan
            end
            
            if deviceInfo.wan then
                syncData.wan = deviceInfo.wan
            end
            
            if deviceInfo.admin then
                syncData.admin = deviceInfo.admin
            end
            
            if deviceInfo.pridisk then
                syncData.pridisk = deviceInfo.pridisk
            end
            
            if deviceInfo.owner then
                syncData.owner = deviceInfo.pridisk
            end
            
            if deviceInfo.device then
                syncData.device = deviceInfo.device
            end
            
            if deviceInfo.limited then
                syncData.limited = deviceInfo.limited
            end
            
            if deviceInfo.pcontrol then
                syncData.pcontrol = deviceInfo.pcontrol
            end
            
            messageClient.send("device_info", json.encode(syncData))
        end
    end
end
