---
--- XQQoSUtil QoS服务质量工具模块
--- 小米路由器QoS流量控制和带宽管理工具
--- 功能：应用限速、设备限速、QoS模式设置、带宽管理、王者荣耀加速
---

module("xiaoqiang.util.XQQoSUtil", package.seeall)

local uci = require("luci.model.uci").cursor()
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")

--- 获取应用限速配置
--- @return table 应用限速配置 {enable, xunlei, kuaipan}
local function _application()
    local config = uci:get_all("app-tc", "config")
    local xunlei = uci:get_all("app-tc", "xunlei")
    local kuaipan = uci:get_all("app-tc", "kuaipan")
    
    local result = {}
    
    if config then
        result.enable = config.enable
    end
    
    if xunlei then
        result.xunlei = xunlei
    end
    
    if kuaipan then
        result.kuaipan = kuaipan
    end
    
    return result
end

--- 设置应用限速配置项
--- @param section string 配置节名
--- @param option string 配置项名
--- @param value string 配置值
local function _set(section, option, value)
    uci:set("app-tc", section, option, value)
end

--- 应用并保存配置
local function _apply()
    uci:save("app-tc")
    uci:commit("app-tc")
end

--- 设置应用速度限制
--- @param appName string 应用名称
--- @param downloadSpeed number 下载速度限制
--- @param uploadSpeed number 上传速度限制
local function _appSpeedlimit(appName, downloadSpeed, uploadSpeed)
    if downloadSpeed then
        _set(appName, "max_download_speed", tostring(downloadSpeed))
    end
    
    if uploadSpeed then
        _set(appName, "max_upload_speed", tostring(uploadSpeed))
    end
    
    _apply()
end

--- 应用限速开关
--- @param enable boolean 是否启用
--- @return boolean 操作是否成功
function appSpeedlimitSwitch(enable)
    local cmd = enable and XQConfigs.QOS_APPSL_ENABLE or XQConfigs.QOS_APPSL_DISABLE
    local enableValue = enable and "1" or "0"
    
    _set("config", "enable", enableValue)
    _apply()
    
    local result = os.execute(cmd)
    return result == 0
end

--- 获取应用限速信息
--- @return table 应用限速详情
function appInfo()
    local result = {}
    local xunleiInfo = {}
    local kuaipanInfo = {}
    
    local appConfig = _application()
    
    local xunleiData = XQFunction.thrift_tunnel_to_datacenter("{\"api\":45,\"appCode\":1}")
    local kuaipanData = XQFunction.thrift_tunnel_to_datacenter("{\"api\":45,\"appCode\":0}")
    
    if xunleiData then
        if xunleiData.code == 0 then
            xunleiInfo.download = tonumber(xunleiData.downloadSpeed)
            xunleiInfo.upload = tonumber(xunleiData.uploadSpeed)
        end
    else
        xunleiInfo.download = 0
        xunleiInfo.upload = 0
    end
    
    if kuaipanData then
        if kuaipanData.code == 0 then
            kuaipanInfo.download = tonumber(kuaipanData.downloadSpeed)
            kuaipanInfo.upload = tonumber(kuaipanData.uploadSpeed)
        end
    else
        kuaipanInfo.download = 0
        kuaipanInfo.upload = 0
    end
    
    result.enable = appConfig.enable
    xunleiInfo.enable = appConfig.xunlei.enable
    xunleiInfo.maxdownload = tonumber(appConfig.xunlei.max_download_speed)
    xunleiInfo.maxupload = tonumber(appConfig.xunlei.max_upload_speed)
    
    kuaipanInfo.enable = appConfig.kuaipan.enable
    kuaipanInfo.maxdownload = tonumber(appConfig.kuaipan.max_download_speed)
    kuaipanInfo.maxupload = tonumber(appConfig.kuaipan.max_upload_speed)
    
    result.xunlei = xunleiInfo
    result.kuaipan = kuaipanInfo
    
    return result
end

--- 设置迅雷限速
--- @param downloadSpeed number 下载速度限制
--- @param uploadSpeed number 上传速度限制
function setXunlei(downloadSpeed, uploadSpeed)
    _appSpeedlimit("xunlei", downloadSpeed, uploadSpeed)
end

--- 设置快盘限速
--- @param downloadSpeed number 下载速度限制
--- @param uploadSpeed number 上传速度限制
function setKuaipan(downloadSpeed, uploadSpeed)
    _appSpeedlimit("kuaipan", downloadSpeed, uploadSpeed)
end

--- 重新加载应用限速配置
function reload()
    os.execute(XQConfigs.QOS_APPSL_RELOAD)
end

--- 比特率格式转换（转换为KB/s）
--- @param speedStr string|number 速度字符串或数值
--- @return number 转换后的KB/s值
local function _bitFormat(speedStr)
    if XQFunction.isStrNil(speedStr) then
        return 0
    end
    
    if type(speedStr) == "number" then
        return tonumber(string.format("%0.2f", speedStr / 8192))
    end
    
    if speedStr:match("Gbit") then
        local value = tonumber(speedStr:match("(%S+)Gbit"))
        return value * 131072
    elseif speedStr:match("Mbit") then
        local value = tonumber(speedStr:match("(%S+)Mbit"))
        return value * 128
    elseif speedStr:match("Kbit") then
        local value = tonumber(speedStr:match("(%S+)Kbit"))
        return tonumber(string.format("%0.2f", value / 8))
    elseif speedStr:match("bit") then
        local value = tonumber(speedStr:match("(%S+)bit"))
        return tonumber(string.format("%0.2f", value / 8192))
    else
        return 0
    end
end

--- 权重辅助函数（根据级别返回权重值）
--- @param level number 级别 (1-3)
--- @return number 权重值
local function _weightHelper(level)
    if level == 1 then
        return 0.25
    elseif level == 2 then
        return 0.5
    elseif level == 3 then
        return 0.75
    else
        return 0.1
    end
end

--- 级别辅助函数（根据百分比返回级别）
--- @param percent number 百分比值
--- @return number 级别 (0-3)
local function _levelHelper(percent)
    if percent == 0 then
        return 2
    elseif percent > 0 and percent <= 0.25 then
        return 1
    elseif percent > 0.25 and percent <= 0.5 then
        return 2
    elseif percent > 0.5 then
        return 3
    end
    return 0
end

--- QoS开关
--- @param enable boolean 是否启用QoS
--- @return boolean 始终返回true
function qosSwitch(enable)
    if enable then
        XQFunction.forkExec("/etc/init.d/miqos on")
    else
        XQFunction.forkExec("/etc/init.d/miqos off")
    end
    return true
end

--- 设置QoS模式
--- @param mode number 模式编号 (0-6)
--- @return number 错误码 (0=成功, 1523=参数错误)
function setQoSMode(mode)
    local uciCursor = require("luci.model.uci").cursor()
    
    local modeTypes = {"auto", "min", "max", "service", "service", "service", "service"}
    local seqPrios = {"auto", "auto", "auto", "auto", "game", "web", "video"}
    
    local changed = false
    local errorCode = 0
    
    if not tonumber(mode) then
        return 1523
    end
    mode = tonumber(mode)
    
    if mode >= 0 and mode <= 6 then
        local currentAuto = uciCursor:get("miqos", "settings", "qos_auto") or ""
        local currentPrio = uciCursor:get("miqos", "param", "seq_prio") or ""
        
        local newAuto = modeTypes[mode + 1]
        if currentAuto ~= newAuto then
            changed = true
            uciCursor:set("miqos", "settings", "qos_auto", modeTypes[mode + 1])
        end
        
        local newPrio = seqPrios[mode + 1]
        if currentPrio ~= newPrio then
            changed = true
            uciCursor:set("miqos", "param", "seq_prio", seqPrios[mode + 1])
        end
    end
    
    if changed then
        uciCursor:commit("miqos")
        XQFunction.forkExec("/etc/init.d/miqos apply")
    end
    
    return errorCode
end

--- 重启QoS服务
--- @return number 命令执行结果
function qosRestart()
    return os.execute("/etc/init.d/miqos restart")
end

--- 获取QoS状态
--- @return table QoS状态 {on=是否开启, mode=当前模式}
function qosStatus()
    local uciCursor = require("luci.model.uci").cursor()
    local status = {}
    
    local isRunning = os.execute("/etc/init.d/miqos status")
    
    if isRunning == 0 then
        status.on = 1
        status.mode = 3
        
        local qosAuto = uciCursor:get("miqos", "settings", "qos_auto") or ""
        local modeMap = {auto = 3, game = 4, web = 5, video = 6}
        
        if qosAuto == "auto" then
            status.mode = 0
        elseif qosAuto == "min" then
            status.mode = 1
        elseif qosAuto == "max" then
            status.mode = 2
        elseif qosAuto == "service" or qosAuto == "noifb" then
            local seqPrio = uciCursor:get("miqos", "param", "seq_prio") or ""
            status.mode = modeMap[seqPrio]
        else
            status.mode = modeMap.auto
        end
    else
        status.on = 0
        status.mode = 0
    end
    
    return status
end

--- 获取QoS带宽配置
--- @return table 带宽配置 {download=下载带宽MB, upload=上传带宽MB}
function qosBand()
    local uciCursor = require("luci.model.uci").cursor()
    local band = {download = 0, upload = 0}
    
    local download = tonumber(uciCursor:get("miqos", "settings", "download") or "0")
    local upload = tonumber(uciCursor:get("miqos", "settings", "upload") or "0")
    
    band.download = tonumber(string.format("%0.2f", download / 1024))
    band.upload = tonumber(string.format("%0.2f", upload / 1024))
    
    return band
end

--- 获取王者荣耀加速信息
--- @return table 加速状态 {switch=开关状态}
function wangzheInfo()
    local miqos = require("miqos")
    local info = {switch = 0}
    
    local result = miqos.cmd("show_wangzhe")
    
    if result then
        if result.status == 0 then
            if result.data then
                info.switch = result.data.switch
            end
        end
    end
    
    return info
end

--- 设置QoS带宽
--- @param download number 下载带宽(MB)
--- @param upload number 上传带宽(MB)
--- @return boolean 是否设置成功
function setQosBand(download, upload)
    local miqos = require("miqos")
    
    if download and upload then
        local downloadKb = tostring(math.floor(1024 * download))
        local uploadKb = tostring(math.floor(1024 * upload))
        
        local result = miqos.cmd(string.format("change_band %s %s", downloadKb, uploadKb))
        
        if result then
            if result.status == 0 then
                return true
            end
        end
    end
    
    return false
end

--- 获取QoS分组配置（内部函数）
--- @return table 分组配置字典
local function _getQosGroups()
    local uciCursor = require("luci.model.uci").cursor()
    local groups = {}
    
    pcall(function()
        uciCursor:foreach("miqos", "group", function(section)
            if section.name ~= XQConfigs.QOS_DEFAULT_GROUP then
                groups[section.name] = section
            end
        end)
    end)
    
    for name, group in pairs(groups) do
        if not group.flag then
            local maxUp = tonumber(groups[name].max_grp_uplink or "0")
            if maxUp <= 0 then
                local maxDown = tonumber(groups[name].max_grp_downlink or "0")
                if maxDown <= 0 then
                    groups[name].flag = "off"
                end
            end
        else
            if group.flag == "off" then
                groups[name].max_grp_uplink = 0
                groups[name].max_grp_downlink = 0
            end
        end
    end
    
    return groups
end

--- 获取QoS配置
--- @return table QoS配置 {status=状态码, data=分组数据, mode=模式}
function getQosCfg()
    local uciCursor = require("luci.model.uci").cursor()
    local config = {}
    
    config.status = 0
    config.data = _getQosGroups()
    config.mode = uciCursor:get("miqos", "settings", "qos_auto") or ""
    
    return config
end

--- 获取QoS设备列表
--- @param bandInfo table 带宽信息
--- @return table 设备QoS列表
function qosList(bandInfo)
    local LuciUtil = require("luci.util")
    local miqos = require("miqos")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    local result = {}
    local deviceMap = {}
    
    local deviceList = XQDeviceUtil.getDeviceList(true)
    local qosData = miqos.cmd("show")
    
    if deviceList then
        if type(deviceList) == "table" then
            if #deviceList > 0 then
                for _, device in ipairs(deviceList) do
                    deviceMap[device.ip] = device
                end
            end
        end
    end
    
    if deviceMap and qosData then
        if qosData.status == 0 then
            if qosData.data then
                for ip, qos in pairs(qosData.data) do
                    local device = deviceMap[ip]
                    if device then
                        local deviceInfo = LuciUtil.clone(device, true)
                        deviceInfo.ip = ip
                        
                        local qosInfo = {}
                        qosInfo.downmax = tonumber(qos.DOWN.max_per) / 8
                        qosInfo.downmin = tonumber(qos.DOWN.min_per) / 8
                        
                        local maxDownPer, level = nil, nil
                        
                        if bandInfo then
                            if bandInfo.download > 0 then
                                local maxPer = tonumber(qos.DOWN.max_per) or 0
                                maxDownPer = 100 * maxPer
                                local minPer = tonumber(qos.DOWN.min_per) or 0
                                level = _levelHelper(minPer)
                            end
                        else
                            level = 2
                            maxDownPer = 100
                        end
                        
                        qosInfo.maxdownper = maxDownPer
                        qosInfo.upmax = tonumber(qos.UP.max_per) / 8
                        qosInfo.upmin = tonumber(qos.UP.min_per) / 8
                        
                        local maxUpPer = nil
                        if bandInfo.upload > 0 then
                            local maxPer = tonumber(qos.UP.max_per) or 0
                            maxUpPer = 100 * maxPer
                        else
                            maxUpPer = 100
                        end
                        
                        qosInfo.level = level
                        qosInfo.upmaxper = maxUpPer
                        deviceInfo.qos = qosInfo
                        
                        if deviceInfo.isap == 0 then
                            table.insert(result, deviceInfo)
                        end
                        
                        if deviceInfo.statistics then
                            if math.floor(qosInfo.upmax) ~= 0 then
                                local maxUpBytes = math.floor(qosInfo.upmax * 1024)
                                deviceInfo.statistics.upspeed = math.min(maxUpBytes, deviceInfo.statistics.upspeed)
                            end
                            
                            if math.floor(qosInfo.downmax) ~= 0 then
                                local maxDownBytes = math.floor(qosInfo.downmax * 1024)
                                deviceInfo.statistics.downspeed = math.min(maxDownBytes, deviceInfo.statistics.downspeed)
                            end
                        end
                    end
                end
            end
        end
    end
    
    return result
end

--- 获取MAC地址的QoS信息
--- @param macAddr string MAC地址
--- @return table QoS信息 {upmax, downmax, flag}
function macQosInfo(macAddr)
    local qosCfg = getQosCfg()
    local info = {upmax = 0, downmax = 0, flag = "off"}
    
    if qosCfg.status ~= 0 then
        return nil
    end
    
    if qosCfg.data then
        if qosCfg.data[macAddr] then
            info.upmax = tonumber(qosCfg.data[macAddr].max_grp_uplink) / 8
            info.downmax = tonumber(qosCfg.data[macAddr].max_grp_downlink) / 8
            info.flag = qosCfg.data[macAddr].flag
            
            if not qosCfg.data[macAddr].flag then
                if info.upmax > 0 or info.downmax > 0 then
                    info.flag = "on"
                else
                    info.flag = "off"
                end
            end
        end
    end
    
    return info
end

--- 设置MAC地址的QoS配置（UCI方式）
--- @param deviceId string 设备ID
--- @param macAddr string MAC地址
--- @param maxUpload number 最大上传速度(Kbps)
--- @param maxDownload number 最大下载速度(Kbps)
--- @param minUpload number 最小上传带宽比例
--- @param minDownload number 最小下载带宽比例
--- @param flag string 开关标志 ("on"/"off")
--- @return boolean 是否设置成功
local function _setMacQosConfig(deviceId, macAddr, maxUpload, maxDownload, minUpload, minDownload, flag)
    local datatypes = require("luci.cbi.datatypes")
    local uciCursor = require("luci.model.uci").cursor()
    
    local macKey = string.gsub(macAddr, ":", "")
    local changed = false
    
    if XQFunction.isStrNil(deviceId) or XQFunction.isStrNil(macAddr) or not datatypes.macaddr(macAddr) then
        return false
    end
    
    local existingConfig = uciCursor:get_all("miqos", macKey)
    
    if not existingConfig or existingConfig[".type"] ~= "group" then
        uciCursor:section("miqos", "group", macKey)
        uciCursor:set("miqos", macKey, "name", macAddr)
        uciCursor:set("miqos", macKey, "min_grp_uplink", "0.5")
        uciCursor:set("miqos", macKey, "min_grp_downlink", "0.5")
        uciCursor:set("miqos", macKey, "max_grp_uplink", "0")
        uciCursor:set("miqos", macKey, "max_grp_downlink", "0")
        uciCursor:set("miqos", macKey, "mode", "general")
        uciCursor:set("miqos", macKey, "mac", {macAddr})
        changed = true
    end
    
    if XQFunction.isStrNil(flag) and maxUpload and maxDownload then
        flag = "on"
    end
    
    if flag and (flag == "on" or flag == "off") then
        local currentFlag = uciCursor:get("miqos", macKey, "flag") or "off"
        if currentFlag ~= flag then
            uciCursor:set("miqos", macKey, "flag", flag)
            changed = true
        end
    end
    
    if minUpload then
        local minUpValue = tonumber(minUpload)
        if minUpValue <= 0 or minUpValue > 1 then
            minUpload = nil
        end
        local currentMinUp = uciCursor:get("miqos", macKey, "min_grp_uplink")
        if currentMinUp ~= minUpload then
            uciCursor:set("miqos", macKey, "min_grp_uplink", minUpload)
            changed = true
        end
    end
    
    if minDownload then
        local minDownValue = tonumber(minDownload)
        if minDownValue <= 0 or minDownValue > 1 then
            minDownload = nil
        end
        local currentMinDown = uciCursor:get("miqos", macKey, "min_grp_downlink")
        if currentMinDown ~= minDownload then
            uciCursor:set("miqos", macKey, "min_grp_downlink", minDownload)
            changed = true
        end
    end
    
    if maxUpload then
        local maxUpValue = tonumber(maxUpload)
        if maxUpValue < 8 then
            maxUpload = 0
        end
        local currentMaxUp = uciCursor:get("miqos", macKey, "max_grp_uplink")
        if currentMaxUp ~= maxUpload then
            uciCursor:set("miqos", macKey, "max_grp_uplink", maxUpload)
            changed = true
        end
    end
    
    if maxDownload then
        local maxDownValue = tonumber(maxDownload)
        if maxDownValue < 8 then
            maxDownload = 0
        end
        local currentMaxDown = uciCursor:get("miqos", macKey, "max_grp_downlink")
        if currentMaxDown ~= maxDownload then
            uciCursor:set("miqos", macKey, "max_grp_downlink", maxDownload)
            changed = true
        end
    end
    
    if changed then
        uciCursor:commit("miqos")
    end
    
    return true
end

--- 设置MAC地址的QoS信息（miqos命令方式）
--- @param macAddr string MAC地址
--- @param maxUpload number 最大上传速度(KB/s)
--- @param maxDownload number 最大下载速度(KB/s)
--- @return boolean 是否设置成功
function setMacQosInfo(macAddr, maxUpload, maxDownload)
    local miqos = require("miqos")
    
    if not XQFunction.isStrNil(macAddr) then
        macAddr = XQFunction.macFormat(macAddr)
        
        if tonumber(maxUpload) and tonumber(maxDownload) then
            _setMacQosConfig("max", macAddr, 
                tostring(tonumber(maxUpload) * 8), 
                tostring(tonumber(maxDownload) * 8))
            miqos.cmd("apply")
            return true
        end
    end
    
    return false
end

--- QoS限速设置
--- @param macAddr string MAC地址
--- @param mode number QoS模式
--- @param maxUpload number 最大上传速度
--- @param maxDownload number 最大下载速度
--- @return boolean 是否设置成功
function qosOnLimit(macAddr, mode, maxUpload, maxDownload)
    local miqos = require("miqos")
    
    if not XQFunction.isStrNil(macAddr) and tonumber(mode) then
        macAddr = XQFunction.macFormat(macAddr)
        mode = tonumber(mode)
        
        local currentStatus = qosStatus()
        if currentStatus then
            if currentStatus.mode ~= mode then
                local result = setQoSMode(mode)
                if result ~= 0 then
                    return false
                end
            end
        end
        
        if mode == 1 then
            local upWeight = _weightHelper(tonumber(maxUpload))
            local downWeight = _weightHelper(tonumber(maxDownload))
            
            if upWeight and downWeight then
                _setMacQosConfig("min", macAddr, nil, nil, tostring(upWeight), tostring(downWeight))
                miqos.cmd("apply")
                return true
            end
        else
            if tonumber(maxUpload) and tonumber(maxDownload) then
                _setMacQosConfig("max", macAddr, 
                    tostring(tonumber(maxUpload) * 8), 
                    tostring(tonumber(maxDownload) * 8))
                miqos.cmd("apply")
                return true
            end
        end
    end
    
    return false
end

--- QoS限速标志设置
--- @param macAddr string MAC地址
--- @param flag string 开关标志 ("on"/"off")
--- @return boolean 是否设置成功
function qosLimitFlag(macAddr, flag)
    local miqos = require("miqos")
    
    if not XQFunction.isStrNil(macAddr) and (flag == "on" or flag == "off") then
        macAddr = XQFunction.macFormat(macAddr)
        _setMacQosConfig("max", macAddr, nil, nil, nil, nil, flag)
        miqos.cmd("apply")
        return true
    else
        return false
    end
end

--- 批量QoS限速设置
--- @param mode number QoS模式
--- @param deviceList table 设备列表
--- @return boolean 是否设置成功
function qosOnLimits(mode, deviceList)
    local miqos = require("miqos")
    
    if not deviceList or type(deviceList) ~= "table" or #deviceList <= 0 then
        return false
    end
    
    if mode then
        mode = tostring(mode)
        local currentStatus = qosStatus()
        
        if not currentStatus or currentStatus.on ~= 1 then
            return false
        end
        
        if currentStatus and currentStatus.mode ~= mode and currentStatus.mode ~= 0 then
            return false
        end
        
        for _, device in ipairs(deviceList) do
            local mac = XQFunction.macFormat(device.mac)
            local maxUp = tonumber(device.maxup)
            local maxDown = tonumber(device.maxdown)
            
            if mode == "1" then
                local upWeight = _weightHelper(tonumber(device.maxup))
                local downWeight = _weightHelper(tonumber(device.maxdown))
                
                if upWeight and downWeight then
                    _setMacQosConfig("min", mac, nil, nil, tostring(upWeight), tostring(downWeight))
                end
            elseif maxUp and maxDown then
                _setMacQosConfig("max", mac, tostring(maxUp * 8), tostring(maxDown * 8))
            end
        end
    else
        for _, device in ipairs(deviceList) do
            local mac = XQFunction.macFormat(device.mac)
            local maxUp = tonumber(device.maxup)
            local maxDown = tonumber(device.maxdown)
            
            if maxUp and maxDown then
                _setMacQosConfig("max", mac, tostring(maxUp * 8), tostring(maxDown * 8))
            end
        end
    end
    
    miqos.cmd("apply")
    return true
end

--- 关闭QoS限速
--- @param macAddr string MAC地址（可选，为空则关闭所有）
--- @return boolean 是否成功
function qosOffLimit(macAddr)
    local miqos = require("miqos")
    local result
    
    if not XQFunction.isStrNil(macAddr) then
        result = miqos.cmd(string.format("off_limit %s", XQFunction.macFormat(macAddr)))
    else
        result = miqos.cmd("off_limit")
    end
    
    if result then
        if result.status == 0 then
            return true
        end
    else
        return false
    end
end

--- 获取QoS历史记录
--- @param macList table MAC地址列表（可选）
--- @return table QoS历史信息
function qosHistory(macList)
    local result = {}
    
    result.status = {on = 0, mode = 0}
    result.band = {upload = 0, download = 0}
    
    local status = qosStatus()
    result.status = status
    
    local band = qosBand()
    result.band = band
    
    local qosCfg = getQosCfg()
    
    if qosCfg then
        if qosCfg.status == 0 then
            if status.mode ~= 0 then
                local dict = {}
                
                if macList then
                    if type(macList) == "table" then
                        if #macList > 0 then
                            for _, mac in ipairs(macList) do
                                local info = {}
                                local formattedMac = XQFunction.macFormat(mac)
                                info.mac = formattedMac
                                
                                local groupData = qosCfg.data[formattedMac]
                                
                                if groupData then
                                    if status.mode == 1 then
                                        info.level = _levelHelper(tonumber(groupData.min_grp_downlink))
                                    else
                                        info.upmax = tonumber(groupData.max_grp_uplink) / 8
                                        info.downmax = tonumber(groupData.max_grp_downlink) / 8
                                    end
                                    
                                    if not groupData.flag then
                                        if (info.upmax and info.upmax > 0) or (info.downmax and info.downmax > 0) then
                                            info.flag = "on"
                                        else
                                            info.flag = "off"
                                        end
                                    else
                                        info.flag = groupData.flag == "on" and "on" or "off"
                                    end
                                else
                                    if status.mode == 1 then
                                        info.level = 2
                                    else
                                        info.upmax = 0
                                        info.downmax = 0
                                    end
                                    info.flag = "off"
                                end
                                
                                dict[mac] = info
                            end
                        end
                    end
                else
                    for name, groupData in pairs(qosCfg.data) do
                        local info = {}
                        
                        if status.mode == 1 then
                            info.mac = name
                            info.level = _levelHelper(tonumber(groupData.min_grp_downlink))
                        else
                            info.mac = name
                            info.upmax = tonumber(groupData.max_grp_uplink) / 8
                            info.downmax = tonumber(groupData.max_grp_downlink) / 8
                        end
                        
                        if not groupData.flag then
                            if (info.upmax and info.upmax > 0) or (info.downmax and info.downmax > 0) then
                                info.flag = "on"
                            else
                                info.flag = "off"
                            end
                        else
                            info.flag = groupData.flag == "on" and "on" or "off"
                        end
                        
                        dict[name] = info
                    end
                end
                
                result.dict = dict
            end
        end
    end
    
    return result
end

--- 获取特定类型的QoS信息（内部函数）
--- @param qosType string QoS类型 ("guest"/"xq")
--- @return table QoS信息
local function _getQosTypeInfo(qosType)
    local defaultPercent = {guest = 0.6, xq = 0.9}
    local uciCursor = require("luci.model.uci").cursor()
    
    local result = {}
    local typeConfig = {}
    local settingsConfig = {}
    
    if qosType ~= "guest" and qosType ~= "xq" then
        return result
    end
    
    typeConfig.UP = uciCursor:get("miqos", qosType, "up_per")
    typeConfig.DOWN = uciCursor:get("miqos", qosType, "down_per")
    settingsConfig.UP = uciCursor:get("miqos", "settings", "upload")
    settingsConfig.DOWN = uciCursor:get("miqos", "settings", "download")
    
    if tonumber(settingsConfig.UP) < 8000 then
        settingsConfig.UP = "0"
        settingsConfig.DOWN = "0"
    end
    
    result.percent_up = typeConfig.UP
    result.percent = typeConfig.DOWN
    
    local directions = {"UP", "DOWN"}
    
    for _, direction in ipairs(directions) do
        local percent = tonumber(typeConfig[direction])
        local total = tonumber(settingsConfig[direction])
        
        if percent <= 0 then
            result[direction] = total
        elseif percent <= 1 then
            result[direction] = math.ceil(total * percent)
        else
            result[direction] = math.ceil(percent)
        end
    end
    
    return result
end

--- 获取访客网络QoS信息
--- @return table 访客网络QoS配置
function guestQoSInfo()
    return _getQosTypeInfo("guest")
end

--- 获取小米设备QoS信息
--- @return table 小米设备QoS配置
function xqQoSInfo()
    return _getQosTypeInfo("xq")
end

--- 设置访客或小米设备的QoS
--- @param qosType string QoS类型 ("guest"/"xq")
--- @param downPercent number 下载带宽比例 (0-1)
--- @param upPercent number 上传带宽比例 (0-1，可选)
--- @return boolean 是否设置成功
function setQosGuestOrXQ(qosType, downPercent, upPercent)
    local miqos = require("miqos")
    local cmd = nil
    
    if downPercent then
        if tonumber(downPercent) then
            if tonumber(downPercent) >= 0 and tonumber(downPercent) <= 1 then
                if upPercent then
                    if tonumber(upPercent) < 0 or tonumber(upPercent) > 1 then
                        upPercent = downPercent
                    end
                else
                    upPercent = downPercent
                end
                
                if qosType == "guest" then
                    cmd = "on_guest "
                elseif qosType == "xq" then
                    cmd = "on_xq "
                else
                    return false
                end
                
                cmd = cmd .. tostring(upPercent) .. " " .. tostring(downPercent)
                miqos.cmd(cmd)
                return true
            end
        end
    else
        return false
    end
end

--- QoS应用管理
--- @param appId number 应用ID
--- @param lanIp string 局域网IP
--- @param remoteIp string 远程IP
--- @param remotePort number 远程端口
--- @param operation number 操作类型 (0=添加, 1=删除)
--- @return number 错误码 (0=成功, 负数=失败)
function qos_app(appId, lanIp, remoteIp, remotePort, operation)
    local xqcrypto = require("xqcrypto")
    
    if not appId or not operation then
        return -1
    end
    
    local appIndex = xqcrypto.app_opt(tostring(appId), "+")
    
    if appIndex >= 0 then
        if operation == 0 then
            local lanResult = xqcrypto.lan_opt(tostring(appIndex), "+", lanIp or "0.0.0.0")
            
            if lanResult == 0 then
                if remoteIp or remotePort then
                    local remoteResult = xqcrypto.remote_opt(
                        tostring(appIndex), 
                        "+", 
                        tostring(remoteIp or "0.0.0.0"), 
                        tostring(remotePort or 0)
                    )
                    
                    if remoteResult == 0 then
                        return 0
                    else
                        return -4
                    end
                end
            else
                return -3
            end
        elseif operation == 1 then
            if not lanIp then
                local deleteResult = xqcrypto.app_opt(tostring(appId), "-")
                if deleteResult >= 0 then
                    return 0
                else
                    return -2
                end
            else
                local lanResult = xqcrypto.lan_opt(tostring(appIndex), "-", lanIp)
                
                if lanResult == 0 then
                    if remoteIp or remotePort then
                        local remoteResult = xqcrypto.remote_opt(
                            tostring(appIndex), 
                            "-", 
                            tostring(remoteIp or "0.0.0.0"), 
                            tostring(remotePort or 0)
                        )
                        
                        if remoteResult == 0 then
                            return 0
                        else
                            return -4
                        end
                    end
                    return 0
                else
                    return -3
                end
            end
        else
            return -1
        end
    else
        return -2
    end
end
