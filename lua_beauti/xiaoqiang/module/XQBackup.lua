--[[
配置备份恢复模块 (XQBackup)
小米路由器配置备份和恢复功能模块

功能说明:
- 备份路由器配置到文件
- 从备份文件恢复配置
- 支持多种配置项备份:
  * 基本信息(路由器名称、密码)
  * WiFi设置
  * 网络设置(WAN/LAN)
  * DHCP设置
  * MAC过滤设置
  * 蜂窝网络设置
  * 短信信息

备份文件格式:
- 使用AES加密保护配置数据
- 打包为tar.gz格式
- 包含.des(加密数据)和.mbu(元数据)文件

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.util.XQWifiUtil: WiFi工具
- xiaoqiang.util.XQPushUtil: 推送工具
- xiaoqiang.util.XQDeviceUtil: 设备工具
- xiaoqiang.util.XQSysUtil: 系统工具
- xiaoqiang.util.XQSMSUtil: 短信工具
- xiaoqiang.XQFeatures: 功能特性
- luci.model.uci: UCI配置管理
- nixio.fs: 文件系统操作
- aeslua: AES加密库
- json: JSON编解码
]]

module("xiaoqiang.module.XQBackup", package.seeall)

TMP_DIR = "/tmp"
TMP_TARGET_DIR = "bkcfg_tmp"
BACKUP_PATH = "/tmp/syslogbackup/"
TAR_FILE_NAME = "cfgbackup.tar.gz"
DES_FILE_NAME = "cfg_backup.des"
MBU_FILE_NAME = "cfg_backup.mbu"

local TMP_FULL_PATH = TMP_DIR .. "/" .. TMP_TARGET_DIR
local TAR_FULL_PATH = TMP_DIR .. "/" .. TAR_FILE_NAME
local DES_FULL_PATH = TMP_DIR .. "/" .. DES_FILE_NAME
local MBU_FULL_PATH = TMP_DIR .. "/" .. MBU_FILE_NAME

local XQFeatures = require("xiaoqiang.XQFeatures").FEATURES
local DES_TMP_PATH = "/tmp/cfg_backup.des"
local MBU_TMP_PATH = "/tmp/cfg_backup.mbu"

local function generateEncryptionKey()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local LuciUtil = require("luci.util")
    
    local defaultKey = "7kl4n23mnm678m890s9dfklnmdqmwenq"
    
    local sn = string.sub(XQFunction.bdataGet("SN", "0529486"), 1, 5)
    local color = string.sub(XQFunction.bdataGet("color", "1000"), 1, 3)
    local mac1 = LuciUtil.trim(string.lower(LuciUtil.exec("getmac|awk -F ',' '{print $1}'|sed 's/://g'")))
    local mac2 = LuciUtil.trim(string.lower(LuciUtil.exec("getmac|awk -F ',' '{print $2}'|sed 's/://g'")))
    
    if sn ~= nil and color ~= nil and mac1 ~= nil and mac2 ~= nil then
        defaultKey = sn .. mac1 .. mac2 .. color
    end
    
    return defaultKey
end

local function getBasicInfo()
    local uci = require("luci.model.uci").cursor()
    
    local info = {
        name = "",
        location = "",
        password = ""
    }
    
    info.name = uci:get("xiaoqiang", "common", "ROUTER_NAME") or ""
    info.location = uci:get("xiaoqiang", "common", "ROUTER_LOCALE") or ""
    info.password = uci:get("account", "common", "admin") or ""
    
    if uci:get("account", "legacy", "admin") then
        info.legacy_password = uci:get("account", "legacy", "admin")
    end
    
    return info
end

local function getWifiInfo()
    local uci = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local supportSplit5g = XQFunction.getFeature("0", "wifi", "split5g") == "1"
    local supportMlo = XQFunction.getFeature("0", "wifi", "mlo") == "1"
    
    local wifiInfo = {
        ["24g"] = {},
        ["5g"] = {}
    }
    
    wifiInfo["24g"] = XQWifiUtil.getWifiBasicInfo(1)
    wifiInfo["5g"] = XQWifiUtil.getWifiBasicInfo(2)
    
    local wlanCount = XQWifiUtil.get_wlan_count()
    if wlanCount == 3 then
        wifiInfo["5gh"] = XQWifiUtil.getWifiBasicInfo(3)
    end
    
    if DWBUtil then
        if DWBUtil.is_supported() then
            wifiInfo.dwb_status = DWBUtil.mesh_get_dwb_status() or "0"
        end
    end
    
    if supportSplit5g then
        wifiInfo.split5g = XQWifiUtil.get_wifi_split_status()
    end
    
    if supportMlo then
        local mldHostap = uci:get("misc", "mld", "hostap")
        if mldHostap then
            wifiInfo.mlo = tonumber(uci:get("wireless", mldHostap, "mlo_enable")) or 0
        else
            wifiInfo.mlo = 0
        end
    end
    
    return wifiInfo
end

local function getVlanServiceInfo()
    local nixio = require("nixio.fs")
    local uci = require("luci.model.uci").cursor()
    
    local configPath = "/etc/config/vlan_service"
    if nixio.stat(configPath) then
        return uci:get_all("vlan_service")
    end
    
    return nil
end

local function getPortServiceInfo()
    local nixio = require("nixio.fs")
    local uci = require("luci.model.uci").cursor()
    
    local configPath = "/etc/config/port_service"
    if nixio.stat(configPath) then
        return uci:get_all("port_service")
    end
    
    return nil
end

local function getNetworkInfo()
    local uci = require("luci.model.uci").cursor()
    
    local vlanService = getVlanServiceInfo()
    local portService = getPortServiceInfo()
    
    local networkInfo = {
        wan = {}
    }
    
    uci:foreach("network", "interface", function(section)
        local sectionName = section[".name"]
        if string.sub(sectionName, 1, 3) == "wan" then
            local wanEntry = {
                wansec = sectionName,
                waninfo = uci:get_all("network", sectionName)
            }
            table.insert(networkInfo.wan, wanEntry)
        end
    end)
    
    if vlanService then
        networkInfo.vlan_service = vlanService
    end
    
    if portService then
        networkInfo.port_service = portService
    end
    
    if XQFeatures.system and XQFeatures.system.multiwan and XQFeatures.system.multiwan == "1" then
        networkInfo.multiwan = uci:get_all("mwan3")
    end
    
    return networkInfo
end

local function getLanInfo()
    local uci = require("luci.model.uci").cursor()
    
    local lanInfo = {
        network = {},
        dhcp = {}
    }
    
    lanInfo.network = uci:get_all("network", "lan")
    lanInfo.dhcp = uci:get_all("dhcp", "lan")
    
    if XQFeatures.system and XQFeatures.system.cpe and XQFeatures.system.cpe == "1" then
        lanInfo.lan6 = uci:get_all("ipv6", "lan6")
    end
    
    return lanInfo
end

local function getMacfilterInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    
    local pushSettings = XQPushUtil.pushSettings()
    
    local macfilterInfo = {
        enable = pushSettings.auth and 1 or 0,
        mode = 0
    }
    
    macfilterInfo.mode = XQWifiUtil.getWiFiMacfilterModel()
    macfilterInfo.list = XQWifiUtil.getCurrentMacfilterList()
    
    return macfilterInfo
end

local function getAccessInfo()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local DataTypes = require("luci.cbi.datatypes")
    
    local accessList = {}
    local deviceMacs = XQDeviceUtil.getDeviceMacsFromDB()
    
    for index, mac in ipairs(deviceMacs) do
        if index > 50 then
            break
        end
        if DataTypes.macaddr(mac) then
            table.insert(accessList, mac)
        end
    end
    
    return accessList
end

local function getSmsInfo()
    local XQSMSUtil = require("xiaoqiang.util.XQSMSUtil")
    
    return {
        sms = XQSMSUtil.dbBackupSelectAllMsg()
    }
end

local function getMobileInfo()
    local nixio = require("nixio.fs")
    local uci = require("luci.model.uci").cursor()
    
    if nixio.stat("/etc/config/mobile") then
        return {
            mobile = uci:get_all("mobile")
        }
    end
    
    return nil
end

local function restoreBasicInfo(info)
    local uci = require("luci.model.uci").cursor()
    
    if info then
        if info.name then
            uci:set("xiaoqiang", "common", "ROUTER_NAME", info.name)
        end
        if info.location then
            uci:set("xiaoqiang", "common", "ROUTER_LOCALE", info.location)
        end
        uci:commit("xiaoqiang")
        
        if info.password then
            uci:set("account", "common", "admin", info.password)
        end
        if info.legacy_password then
            uci:set("account", "legacy", "admin", info.legacy_password)
        end
        uci:commit("account")
    end
end

local function restoreWifiInfo(info)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local supportSplit5g = XQFunction.getFeature("0", "wifi", "split5g") == "1"
    local supportMlo = XQFunction.getFeature("0", "wifi", "mlo") == "1"
    
    if info then
        if supportSplit5g then
            local split5gStatus = info.split5g or "0"
            local currentStatus = tonumber(XQWifiUtil.get_wifi_split_status())
            if tonumber(split5gStatus) ~= currentStatus then
                XQWifiUtil.set_wifi_split_status(tonumber(split5gStatus))
            end
        end
        
        if supportMlo then
            local mloStatus = info.mlo or 0
            if mloStatus == 1 then
                XQWifiUtil.mlo_hostap_enable()
            else
                XQWifiUtil.mlo_hostap_disable()
            end
        end
        
        local wifi24g = info["24g"]
        local wifi5g = info["5g"]
        local wifi5gh = info["5gh"]
        local dwbStatus = info.dwb_status or "0"
        
        XQWifiUtil.init()
        
        if wifi24g then
            local disabled = tonumber(wifi24g.on) == 0 and 1 or 0
            local hidden = tostring(wifi24g.hidden) == "1" and "1" or "0"
            XQWifiUtil.setWifiBasicInfo(1, wifi24g.ssid, wifi24g.password, wifi24g.encryption,
                wifi24g.channel, wifi24g.txpwr, hidden, disabled, wifi24g.bandwidth, wifi24g.bsd, wifi24g.txbf)
        end
        
        if wifi5g then
            local disabled = tonumber(wifi5g.on) == 0 and 1 or 0
            local hidden = tostring(wifi5g.hidden) == "1" and "1" or "0"
            XQWifiUtil.setWifiBasicInfo(2, wifi5g.ssid, wifi5g.password, wifi5g.encryption,
                wifi5g.channel, wifi5g.txpwr, hidden, disabled, wifi5g.bandwidth, wifi5g.bsd, wifi5g.txbf)
        end
        
        if DWBUtil then
            if DWBUtil.is_supported() then
                DWBUtil.mesh_set_dwb_status(dwbStatus)
            end
        end
        
        local wlanCount = XQWifiUtil.get_wlan_count()
        if wlanCount == 3 then
            if wifi5gh and dwbStatus == "1" then
                local disabled = tonumber(wifi5gh.on) == 0 and 1 or 0
                local hidden = tostring(wifi5gh.hidden) == "1" and "1" or "0"
                XQWifiUtil.setWifiBasicInfo(3, wifi5gh.ssid, wifi5gh.password, wifi5gh.encryption,
                    wifi5gh.channel, wifi5gh.txpwr, hidden, disabled, wifi5gh.bandwidth, wifi5gh.bsd, wifi5gh.txbf)
            else
                XQWifiUtil.setWifiBasicInfo(3, nil, nil, nil, "0", "max", nil, 0, "0")
            end
        end
    end
end

local function restoreNetworkInfo(info)
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    if not info then
        return
    end
    
    local wanList = info.wan
    if wanList then
        uci:foreach("network", "interface", function(section)
            if string.sub(section[".name"], 1, 3) == "wan" then
                uci:delete("network", section[".name"])
            end
        end)
        
        for _, wanEntry in ipairs(wanList) do
            uci:section("network", "interface", wanEntry.wansec, wanEntry.waninfo)
        end
        uci:commit("network")
    end
    
    local vlanService = info.vlan_service
    if vlanService then
        for name, section in pairs(vlanService) do
            XQLog.log(7, name, section)
            uci:delete("vlan_service", name)
            uci:section("vlan_service", section[".type"], name, section)
        end
        uci:commit("vlan_service")
    end
    
    local portService = info.port_service
    if portService then
        for name, section in pairs(portService) do
            XQLog.log(7, name, section)
            uci:delete("port_service", name)
            uci:section("port_service", section[".type"], name, section)
        end
        uci:commit("port_service")
    end
    
    local multiwan = info.multiwan
    if XQFeatures.system and XQFeatures.system.multiwan == "1" and multiwan then
        uci:delete_all("mwan3")
        for name, section in pairs(multiwan) do
            XQLog.log(7, name, section)
            uci:section("mwan3", section[".type"], name, section)
        end
        uci:commit("mwan3")
    end
end

local function restoreLanInfo(info)
    local uci = require("luci.model.uci").cursor()
    
    if info then
        local networkLan = info.network
        local dhcpLan = info.dhcp
        
        if networkLan then
            uci:delete("network", "lan")
            uci:section("network", "interface", "lan", networkLan)
            uci:commit("network")
        end
        
        if dhcpLan then
            uci:delete("dhcp", "lan")
            uci:section("dhcp", "dhcp", "lan", dhcpLan)
            uci:commit("dhcp")
        end
        
        if XQFeatures.system and XQFeatures.system.cpe == "1" then
            local lan6 = info.lan6
            if lan6 then
                uci:delete("ipv6", "lan6")
                uci:section("ipv6", "lan", "lan6", lan6)
                uci:commit("ipv6")
            end
        end
    end
end

local function restoreMacfilterInfo(info)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    
    if info then
        local mode = info.mode
        local macList = info.list
        local enable = info.enable
        
        local currentList = XQWifiUtil.getCurrentMacfilterList()
        local currentMode = XQWifiUtil.getWiFiMacfilterModel()
        
        if currentList then
            XQWifiUtil.editWiFiMacfilterList(currentMode - 1, currentList, 1)
        end
        
        XQPushUtil.pushConfig("auth", enable)
        XQWifiUtil.setWiFiMacfilterModel(enable, mode - 1)
        
        if macList then
            XQWifiUtil.editWiFiMacfilterList(mode - 1, macList, 0)
        end
    end
end

local function restoreAccessInfo(info)
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local DataTypes = require("luci.cbi.datatypes")
    
    if info and type(info) == "table" then
        for mac, permissions in pairs(info) do
            if DataTypes.macaddr(mac) then
                XQSysUtil.setMacFilter(mac, tostring(permissions.lan), tostring(permissions.wan),
                    tostring(permissions.admin), tostring(permissions.pridisk))
            end
        end
    end
end

local function restoreSmsInfo(info)
    local XQSMSUtil = require("xiaoqiang.util.XQSMSUtil")
    
    if info then
        local smsList = info.sms
        if smsList then
            XQSMSUtil.dbBackupDeleteAllMsg()
            for _, sms in ipairs(smsList) do
                XQSMSUtil.dbBackupInsertMsg(sms.msg_id, sms.state, sms.timestamp, sms.contact_phone, sms.content)
            end
        end
    end
end

local function restoreMobileInfo(info)
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    if info then
        local mobileConfig = info.mobile
        if mobileConfig then
            uci:delete_all("mobile")
            for name, section in pairs(mobileConfig) do
                XQLog.log(7, name, section)
                uci:section("mobile", section[".type"], name, section)
            end
            uci:commit("mobile")
        end
    end
end

local function getBackupItemList(customList)
    local uci = require("luci.model.uci").cursor()
    
    if not customList then
        return uci:get_list("cfgbackup", "backup", "item")
    end
    
    return customList
end

local BACKUP_ITEM_NAMES = {
    mi_basic_info = "路由器名称和路由器管理密码",
    mi_wifi_info = "Wi-Fi设置(Wi-Fi名称、Wi-Fi密码)",
    mi_network_info = "上网设置(拨号方式和宽带账号密码)",
    mi_lan_info = "DHCP服务和局域网IP设置",
    mi_mobile_info = "蜂窝设置(网络设置,PIN码设置,流量监控)",
    mi_sms_info = "短信信息"
}

local BACKUP_GETTERS = {
    mi_basic_info = getBasicInfo,
    mi_wifi_info = getWifiInfo,
    mi_network_info = getNetworkInfo,
    mi_lan_info = getLanInfo,
    mi_arn_info = getMacfilterInfo,
    mi_access_info = getAccessInfo,
    mi_mobile_info = getMobileInfo,
    mi_sms_info = getSmsInfo
}

local BACKUP_RESTORERS = {
    mi_basic_info = restoreBasicInfo,
    mi_wifi_info = restoreWifiInfo,
    mi_network_info = restoreNetworkInfo,
    mi_lan_info = restoreLanInfo,
    mi_arn_info = restoreMacfilterInfo,
    mi_access_info = restoreAccessInfo,
    mi_mobile_info = restoreMobileInfo,
    mi_sms_info = restoreSmsInfo
}

function getFullPath(filename)
    local match = filename:match("%d+%-%d+%-%d+%-+%d+:%d+:%d+.tar.gz")
    if match then
        return BACKUP_PATH .. match
    end
    return nil
end

function save_info(backupData, metaData)
    local uci = require("luci.model.uci").cursor()
    local json = require("json")
    local aeslua = require("aeslua")
    local nixio = require("nixio.fs")
    local luciSys = require("luci.sys")
    
    local backupPath = BACKUP_PATH
    local encryptKey = generateEncryptionKey()
    local lanIp = uci:get("network", "lan", "ipaddr") or "192.168.31.1"
    
    local function sane()
        return luciSys.process.info("uid") == nixio.stat(backupPath, "uid")
    end
    
    local function prepare()
        nixio.mkdir(backupPath, 700)
    end
    
    if not sane() then
        prepare()
    else
        os.execute("rm " .. backupPath .. "*.tar.gz >/dev/null 2>/dev/null")
    end
    
    local encryptedData = aeslua.encrypt(encryptKey, json.encode(metaData))
    local metaJson = json.encode(backupData)
    
    local timestamp = os.date("%Y-%m-%d--%X", os.time())
    local tarFileName = timestamp .. ".tar.gz"
    
    nixio.writefile(DES_TMP_PATH, encryptedData)
    nixio.writefile(MBU_TMP_PATH, metaJson)
    
    os.execute("cd /tmp; tar -czf " .. backupPath .. tarFileName .. " cfg_backup.des cfg_backup.mbu >/dev/null 2>/dev/null")
    os.execute("rm " .. DES_TMP_PATH .. " >/dev/null 2>/dev/null")
    os.execute("rm " .. MBU_TMP_PATH .. " >/dev/null 2>/dev/null")
    
    return tarFileName
end

function defaultKeys()
    local uci = require("luci.model.uci").cursor()
    
    local keys = {}
    local itemList = uci:get_list("cfgbackup", "backup", "item")
    
    if itemList then
        for _, item in ipairs(itemList) do
            if BACKUP_ITEM_NAMES[item] then
                keys[item] = BACKUP_ITEM_NAMES[item]
            end
        end
    end
    
    return keys
end

function backup(customItems)
    local itemList = getBackupItemList(customItems)
    local backupData = {}
    
    if itemList then
        for _, item in ipairs(itemList) do
            local getter = BACKUP_GETTERS[item]
            if getter then
                backupData[item] = getter()
            end
        end
        return save_info(backupData, itemList)
    end
    
    return nil
end

function check_file(filePath)
    local nixio = require("nixio.fs")
    
    local stat = nixio.lstat(filePath)
    if stat then
        if stat.type == "dir" or stat.type == "lnk" then
            return false
        end
    end
    
    return true
end

function extract(tarFile, targetDir)
    local nixio = require("nixio.fs")
    
    local desFile = ""
    local mbuFile = ""
    
    tarFile = tarFile or TAR_FULL_PATH
    targetDir = targetDir or TMP_FULL_PATH
    
    desFile = targetDir .. "/" .. DES_FILE_NAME
    mbuFile = targetDir .. "/" .. MBU_FILE_NAME
    
    if not nixio.access(tarFile) then
        return 1
    end
    
    local hasSymlink = os.execute("tar -tzvf " .. tarFile .. " | grep ^l >/dev/null 2>&1")
    if hasSymlink == 0 then
        os.execute("rm -rf " .. tarFile)
        return 2
    end
    
    local hasInvalidFiles = os.execute("tar -tzvf " .. tarFile .. " | grep -v '\\.des$' | grep -v '\\.mbu$' >/dev/null 2>&1")
    if hasInvalidFiles == 0 then
        os.execute("rm -rf " .. tarFile)
        return 22
    end
    
    local pipe = io.popen("tar -tzvf " .. tarFile .. " | grep -c '\\.des$'")
    local desCount = pipe:read("*a")
    pipe:close()
    
    if tonumber(desCount) ~= 1 then
        os.execute("rm -rf " .. tarFile)
        return 2
    end
    
    pipe = io.popen("tar -tzvf " .. tarFile .. " | grep -c '\\.mbu$'")
    local mbuCount = pipe:read("*a")
    pipe:close()
    
    if tonumber(mbuCount) ~= 1 then
        os.execute("rm -rf " .. tarFile)
        return 3
    end
    
    if targetDir then
        if not nixio.access(targetDir) then
            os.execute("mkdir -p " .. targetDir .. " >/dev/null 2>&1")
        end
    end
    
    os.execute("tar -xzf " .. tarFile .. " -C " .. targetDir .. " >/dev/null 2>&1")
    os.execute("rm " .. tarFile .. " >/dev/null 2>&1")
    
    if not check_file(desFile) then
        os.execute("rm -rf /tmp/" .. targetDir)
        return 2
    end
    
    if not check_file(mbuFile) then
        os.execute("rm -rf /tmp/" .. targetDir)
        return 3
    end
    
    os.execute("mv " .. desFile .. " " .. TMP_DIR)
    os.execute("mv " .. mbuFile .. " " .. TMP_DIR)
    
    return 0
end

function getdes(mbuFilePath)
    local nixio = require("nixio.fs")
    local json = require("json")
    local uci = require("luci.model.uci").cursor()
    
    mbuFilePath = mbuFilePath or MBU_TMP_PATH
    
    if not nixio.access(mbuFilePath) then
        return nil
    end
    
    local mbuContent = nixio.readfile(mbuFilePath)
    local success, backupKeys = pcall(json.decode, mbuContent)
    
    if success and backupKeys then
        local result = {
            keys = {},
            unknown = {}
        }
        
        local configItems = uci:get_list("cfgbackup", "backup", "item")
        local validItems = {}
        
        for _, item in ipairs(configItems) do
            validItems[item] = true
        end
        
        for _, key in ipairs(backupKeys) do
            if validItems[key] then
                result.keys[key] = BACKUP_ITEM_NAMES[key]
            else
                table.insert(result.unknown, key)
            end
        end
        
        return result
    end
    
    return nil
end

function restore(desFilePath, customItems)
    local json = require("json")
    local nixio = require("nixio.fs")
    local aeslua = require("aeslua")
    
    desFilePath = desFilePath or DES_TMP_PATH
    
    if not nixio.access(desFilePath) then
        return 1
    end
    
    local encryptKey = generateEncryptionKey()
    local encryptedData = nixio.readfile(desFilePath)
    
    os.execute("rm " .. desFilePath .. " >/dev/null 2>/dev/null")
    
    local decryptedData = aeslua.decrypt(encryptKey, encryptedData)
    if not decryptedData then
        return 2
    end
    
    local success, backupData = pcall(json.decode, decryptedData)
    if not success then
        return 2
    end
    
    local itemList = getBackupItemList(customItems)
    if itemList then
        for _, item in ipairs(itemList) do
            local restorer = BACKUP_RESTORERS[item]
            local data = backupData[item]
            if restorer and data then
                restorer(data)
            end
        end
    end
    
    return 0
end
