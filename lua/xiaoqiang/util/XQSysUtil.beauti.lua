---
--- 小米路由器系统工具模块 (XQSysUtil)
--- 提供系统级别的工具函数，包括：
--- - 隐私设置管理
--- - 配置上传功能
--- - 厂商信息获取
--- - 系统初始化状态
--- - 路由器名称和区域设置
--- - 系统密码管理
--- - 固件镜像验证和升级
--- - 系统信息获取
--- - MAC/IP过滤
--- - LED控制
--- - 时区管理
--- - Mesh网络支持
--- - 网络诊断
---

module("xiaoqiang.util.XQSysUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--- 获取隐私设置状态
--- @return boolean 是否启用隐私设置
function getPrivacy()
    local XQPreference = require("xiaoqiang.XQPreference")
    local privacyValue = XQPreference.get("PRIVACY")
    
    if tonumber(privacyValue) then
        if tonumber(privacyValue) == 1 then
            return true
        end
    else
        return false
    end
end

--- 设置隐私状态
--- @param enabled boolean 是否启用隐私设置
function setPrivacy(enabled)
    local value = enabled and "1" or "0"
    local hardware = getHardware()
    local XQPreference = require("xiaoqiang.XQPreference")
    XQPreference.set("PRIVACY", value)
end

--- 检查是否为MiWiFi设备
--- @return boolean 是否为MiWiFi
function isMiWiFi()
    local XQPreference = require("xiaoqiang.XQPreference")
    local hostname = XQPreference.get("ap_hostname") or ""
    local lowerHostname = string.lower(hostname)
    
    if lowerHostname:match("^miwifi") then
        return true
    end
    return false
end

--- 获取配置上传启用状态
--- @return boolean 是否启用配置上传
function getConfUploadEnable()
    local XQPreference = require("xiaoqiang.XQPreference")
    local value = XQPreference.get("CONFUPLOAD_ENABLE")
    
    if value then
        if tonumber(value) == 1 then
            return true
        end
    else
        return false
    end
end

--- 设置配置上传启用状态
--- @param enabled boolean 是否启用
function setConfUploadEnable(enabled)
    local XQPreference = require("xiaoqiang.XQPreference")
    local value = enabled and "1" or "0"
    XQPreference.set("CONFUPLOAD_ENABLE", value)
end

--- 执行配置上传
--- @param params table 可选参数，包含ssid_24G, wifi_24G_password, pppoe_name, pppoe_password
function doConfUpload(params)
    local uci = require("luci.model.uci").cursor()
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local uploadData = {}
    
    if getConfUploadEnable() then
        if params and params.ssid_24G then
            uploadData.ssid_24G = params.ssid_24G or ""
            uploadData.wifi_24G_password = params.wifi_24G_password or ""
        else
            local wifiInfo = XQWifiUtil.getWifiBasicInfo(1)
            uploadData.ssid_24G = wifiInfo.ssid
            uploadData.wifi_24G_password = wifiInfo.password
        end
        
        if params and params.pppoe_name then
            uploadData.pppoe_name = params.pppoe_name or ""
            uploadData.pppoe_password = params.pppoe_password or ""
        else
            local proto = uci:get("network", "wan", "proto")
            if proto and proto == "pppoe" then
                local username = uci:get("network", "wan", "username") or ""
                local password = uci:get("network", "wan", "password") or ""
                uploadData.pppoe_name = username
                uploadData.pppoe_password = password
            end
        end
        
        XQSynchrodata.uploadConf(uploadData)
    end
end

--- 获取厂商信息
--- @return table 厂商信息表，包含name, hardware, color, version, ip
function getVendorInfo()
    local vendorInfo = {
        name = "",
        hardware = "",
        color = "",
        version = "",
        ip = ""
    }
    
    local XQPreference = require("xiaoqiang.XQPreference")
    local vendorData = XQPreference.get("vendorinfo")
    
    if XQFunction.isStrNil(vendorData) then
        return vendorInfo
    end
    
    local LuciUtil = require("luci.util")
    local parts = LuciUtil.split(vendorData, "-")
    
    local hostname = XQPreference.get("ap_hostname") or ""
    vendorInfo.name = hostname
    vendorInfo.hardware = parts[2] or ""
    vendorInfo.version = parts[3] or ""
    vendorInfo.color = parts[4] or ""
    
    if XQFunction.isStrNil(vendorInfo.color) then
        vendorInfo.color = "101"
    end
    
    local capMode = XQPreference.get("CAP_MODE")
    local uci = require("luci.model.uci").cursor()
    local netMode = uci:get("xiaoqiang", "common", "NETMODE") or ""
    
    if capMode ~= nil then
        if capMode:match("^ap") then
            if netMode:match("^whc_re") then
                vendorInfo.ip = uci:get("xiaoqiang", "common", "CAP_IP")
                return vendorInfo
            end
        end
    end
    
    local netModeType = XQFunction.getNetModeType()
    if netModeType == 0 then
        local ubus = require("ubus")
        local conn = ubus.connect()
        local wanStatus = conn:call("network.interface.wan", "status", {})
        if wanStatus and wanStatus.route and wanStatus.route[1] and wanStatus.route[1].nexthop then
            vendorInfo.ip = wanStatus.route[1].nexthop
        end
    else
        local uci2 = require("luci.model.uci").cursor()
        local gateway = uci2:get("network", "lan", "gateway") or ""
        vendorInfo.ip = gateway
    end
    
    return vendorInfo
end

--- 获取初始化状态
--- @return boolean 是否已初始化
function getInitInfo()
    local XQPreference = require("xiaoqiang.XQPreference")
    local isInited = XQPreference.get(XQConfigs.PREF_IS_INITED)
    
    if isInited then
        return true
    else
        return false
    end
end

--- 初始化Mesh版本
function initMeshVersion()
    local uci = require("luci.model.uci").cursor()
    local versionList = uci:get_all("mesh", "version")
    local maxVersion = 0
    
    if versionList then
        for _, version in pairs(versionList) do
            local ver = tonumber(version)
            if ver and ver > maxVersion then
                maxVersion = ver
            end
        end
        uci:set("xiaoqiang", "common", "MESH_VERSION", maxVersion)
        uci:commit("xiaoqiang")
    end
end

--- 设置系统为已初始化状态
--- @return boolean 总是返回true
function setInited()
    initMeshVersion()
    
    local XQPreference = require("xiaoqiang.XQPreference")
    XQPreference.set(XQConfigs.PREF_IS_INITED, "YES")
    
    local LuciUtil = require("luci.util")
    LuciUtil.exec("/usr/sbin/sysapi webinitrdr set off")
    
    XQFunction.forkExec("[ -f /usr/sbin/wan_check.sh ] && /usr/sbin/wan_check.sh reset")
    LuciUtil.exec("[ -f /etc/init.d/meshd ] && /etc/init.d/meshd restart")
    XQFunction.forkExec("/etc/init.d/xunlei restart")
    XQFunction.forkExec("/etc/init.d/local_gw_security restart")
    XQFunction.forkExec("/usr/sbin/set_wps_state 2")
    
    return true
end

--- 设置特殊密码(从镜像获取)
function setSPwd()
    local LuciUtil = require("luci.util")
    local password = LuciUtil.exec("mkxqimage -I")
    
    if password then
        local LuciSys = require("luci.sys")
        password = LuciUtil.trim(password)
        LuciSys.user.setpasswd("root", password)
    end
end

--- 获取更新日志
--- @return string 更新日志内容
function getChangeLog()
    local LuciFs = require("luci.fs")
    local LuciUtil = require("luci.util")
    
    if LuciFs.access(XQConfigs.XQ_CHANGELOG_FILEPATH) then
        return LuciUtil.exec("cat " .. XQConfigs.XQ_CHANGELOG_FILEPATH)
    end
    return ""
end

--- 获取杂项硬件信息
--- @return table 硬件信息表
function getMiscHardwareInfo()
    local uci = require("luci.model.uci").cursor()
    local info = {}
    
    info.bbs = tostring(uci:get("misc", "hardware", "bbs"))
    info.cpufreq = tostring(uci:get("misc", "hardware", "cpufreq"))
    info.verify = tostring(uci:get("misc", "hardware", "verify"))
    info.gpio = (tonumber(uci:get("misc", "hardware", "gpio")) == 1) and 1 or 0
    info.recovery = (tonumber(uci:get("misc", "hardware", "recovery")) == 1) and 1 or 0
    info.flashpermission = (tonumber(uci:get("misc", "hardware", "flash_per")) == 1) and 1 or 0
    info.memsize = uci:get("misc", "hardware", "memsize")
    
    return info
end

--- 检查是否启用特殊区域
--- @return number 0或1
function specialRegionEnable()
    local uci = require("luci.model.uci").cursor()
    local value = uci:get("misc", "features", "special_region_en")
    
    if XQFunction.isStrNil(value) or value == "0" then
        return 0
    end
    return 1
end

--- 获取通行证绑定信息
--- @return string|boolean 绑定的UUID或false
function getPassportBindInfo()
    local XQPreference = require("xiaoqiang.XQPreference")
    local isBound = XQPreference.get(XQConfigs.PREF_IS_PASSPORT_BOUND)
    local uuid = XQPreference.get(XQConfigs.PREF_PASSPORT_BOUND_UUID, "")
    
    if not XQFunction.isStrNil(isBound) and isBound == "YES" then
        if not XQFunction.isStrNil(uuid) then
            return uuid
        end
    else
        return false
    end
end

--- 设置通行证绑定状态
--- @param bound boolean 是否绑定
--- @param uuid string 用户UUID
--- @return boolean 总是返回true
function setPassportBound(bound, uuid)
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    
    if bound then
        if not XQFunction.isStrNil(uuid) then
            XQPreference.set(XQConfigs.PREF_PASSPORT_BOUND_UUID, uuid)
        end
        XQPreference.set(XQConfigs.PREF_IS_PASSPORT_BOUND, "YES")
        XQPreference.set(XQConfigs.PREF_TIMESTAMP, "0")
    else
        if not XQFunction.isStrNil(uuid) then
            XQPreference.set(XQConfigs.PREF_PASSPORT_BOUND_UUID, "")
        end
        XQPreference.set(XQConfigs.PREF_IS_PASSPORT_BOUND, "NO")
        XQPreference.set(XQConfigs.PREF_BOUND_USERINFO, "")
    end
    
    return true
end

--- 获取品牌信息
--- @return string "Redmi" 或 "Xiaomi"
function getBrandInfo()
    local uci = require("luci.model.uci").cursor()
    local isRedmi = uci:get("misc", "features", "redmi") or ""
    
    if isRedmi == "1" then
        return "Redmi"
    else
        return "Xiaomi"
    end
end

--- 获取系统运行时间
--- @return string 运行时间(秒)
function getSysUptime()
    local LuciUtil = require("luci.util")
    local uptimeStr = LuciUtil.exec("cat /proc/uptime")
    
    if uptimeStr == nil then
        return 0
    else
        local uptime, idle = uptimeStr:match("^(%S+) (%S+)")
        return LuciUtil.trim(uptime)
    end
end

--- 获取所有配置信息
--- @return string 配置文件内容
function getConfigInfo()
    local LuciUtil = require("luci.util")
    return LuciUtil.exec("cat /etc/config/*")
end

--- 获取路由器名称
--- @return string 路由器名称
function getRouterName()
    local XQPreference = require("xiaoqiang.XQPreference")
    local routerName = XQPreference.get(XQConfigs.PREF_ROUTER_NAME, "")
    
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local safeName = XQSecureUtil.xssCheck(routerName)
    
    if not XQFunction.isStrNil(safeName) and not XQFunction.isStrNil(routerName) then
        return routerName
    end
    
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local wifiStatus = XQWifiUtil.getWifiStatus(1)
    routerName = wifiStatus.ssid or routerName
    
    if not wifiStatus.ssid then
        routerName = ""
    end
    
    return routerName
end

--- 设置路由器名称
--- @param name string 新名称
--- @return boolean 是否成功
function setRouterName(name)
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local safeName = XQSecureUtil.xssCheck(name)
    
    if safeName == nil then
        return false
    end
    
    if name then
        local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
        XQSynchrodata.syncRouterName(name)
        
        local XQPreference = require("xiaoqiang.XQPreference")
        XQPreference.set(XQConfigs.PREF_ROUTER_NAME, name)
        setRouterNamePending("1")
        return true
    else
        return false
    end
end

--- 获取路由器区域设置
--- @return string 区域代码
function getRouterLocale()
    local XQPreference = require("xiaoqiang.XQPreference")
    local locale = XQPreference.get("ROUTER_LOCALE") or ""
    return locale
end

--- 设置路由器区域
--- @param locale string 区域代码
function setRouterLocale(locale)
    local XQPreference = require("xiaoqiang.XQPreference")
    
    if locale then
        local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
        XQSynchrodata.syncRouterLocale(locale)
        XQPreference.set("ROUTER_LOCALE", locale)
    end
end

--- 获取路由器名称待处理状态
--- @return string 状态值
function getRouterNamePending()
    local XQPreference = require("xiaoqiang.XQPreference")
    return XQPreference.get(XQConfigs.PREF_ROUTER_NAME_PENDING, "0")
end

--- 设置路由器名称待处理状态
--- @param value string 状态值
function setRouterNamePending(value)
    local XQPreference = require("xiaoqiang.XQPreference")
    return XQPreference.set(XQConfigs.PREF_ROUTER_NAME_PENDING, value)
end

--- 获取绑定UUID
--- @return string UUID
function getBindUUID()
    local XQPreference = require("xiaoqiang.XQPreference")
    return XQPreference.get(XQConfigs.PREF_PASSPORT_BOUND_UUID, "")
end

--- 获取设备序列号
--- @return string|nil 序列号
function getSN()
    local LuciUtil = require("luci.util")
    local sn = LuciUtil.exec(XQConfigs.GET_NVRAM_SN)
    
    if XQFunction.isStrNil(sn) then
        return nil
    else
        return LuciUtil.trim(sn)
    end
end

--- 获取ISP版本
--- @return string ISP版本
function getIspVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_ISP_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取ROM版本
--- @return string ROM版本
function getRomVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_ROM_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取显示用ROM版本
--- @return string 显示版本
function getDisplayRomVersion()
    local isCpe = XQFunction.getFeature("0", "system", "cpe")
    
    if isCpe == "1" then
        local ispVersion = getIspVersion()
        if not XQFunction.isStrNil(ispVersion) then
            return ispVersion
        end
    end
    return getRomVersion()
end

--- 获取ROM构建时间
--- @return string 构建时间
function getRomBuildtime()
    local LuciUtil = require("luci.util")
    local buildtime = LuciUtil.exec(XQConfigs.XQ_ROM_BUILDTIME)
    
    if XQFunction.isStrNil(buildtime) then
        buildtime = ""
    else
        buildtime = os.date("%Y/%m/%d", tonumber(buildtime))
    end
    return LuciUtil.trim(buildtime)
end

--- 获取渠道信息
--- @return string 渠道
function getChannel()
    local LuciUtil = require("luci.util")
    local channel = LuciUtil.exec(XQConfigs.XQ_CHANNEL)
    
    if XQFunction.isStrNil(channel) then
        channel = ""
    end
    return LuciUtil.trim(channel)
end

--- 通过GPIO获取硬件版本
--- @return string 硬件版本
function getHardwareVersion()
    local gpio14 = XQFunction.getGpioValue(14)
    local gpio13 = XQFunction.getGpioValue(13)
    local gpio12 = XQFunction.getGpioValue(12)
    
    local version = gpio14 * 4 + gpio13 * 2 + gpio12
    local versionChar = string.char(65 + version)
    
    return "Ver." .. versionChar
end

--- 获取硬件GPIO版本
--- @return string 硬件版本
function getHardwareGPIO()
    local LuciUtil = require("luci.util")
    local hardware = LuciUtil.exec(XQConfigs.XQ_HARDWARE)
    
    if XQFunction.isStrNil(hardware) then
        hardware = ""
    else
        hardware = LuciUtil.trim(hardware)
    end
    
    local miscInfo = getMiscHardwareInfo()
    if miscInfo.gpio == 1 then
        return getHardwareVersion()
    end
    return hardware
end

--- 获取硬件型号
--- @return string 硬件型号
function getHardware()
    local LuciUtil = require("luci.util")
    local hardware = LuciUtil.exec(XQConfigs.XQ_HARDWARE)
    
    if XQFunction.isStrNil(hardware) then
        hardware = ""
    else
        hardware = LuciUtil.trim(hardware)
    end
    return hardware
end

--- 获取CFE版本
--- @return string CFE版本
function getCFEVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_CFE_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取内核版本
--- @return string 内核版本
function getKernelVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_KERNEL_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取RamFS版本
--- @return string RamFS版本
function getRamFsVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_RAMFS_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取SquashFS版本
--- @return string SquashFS版本
function getSqaFsVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_SQAFS_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取RootFS版本
--- @return string RootFS版本
function getRootFsVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_ROOTFS_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取硬件版本号
--- @return string 硬件版本
function getHWVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_HW_VERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取ISP代码
--- @return string ISP代码
function getISPCode()
    local LuciUtil = require("luci.util")
    local code = LuciUtil.exec(XQConfigs.XQ_ISP_CODE)
    
    if XQFunction.isStrNil(code) then
        code = ""
    end
    return LuciUtil.trim(code)
end

--- 获取镜像ISP代码
--- @param imagePath string 镜像路径
--- @return string ISP代码
function getImageIspcode(imagePath)
    local LuciUtil = require("luci.util")
    local code = LuciUtil.exec("mkxqimage -V " .. imagePath .. " | grep ISPCODE | awk '{print $3}' | sed \"s/'//g\"")
    
    if XQFunction.isStrNil(code) then
        code = ""
    end
    return LuciUtil.trim(code)
end

--- 获取Beta版本标识
--- @return string Beta标识
function getBeta()
    local LuciUtil = require("luci.util")
    local beta = LuciUtil.exec(XQConfigs.XQ_BETA)
    
    if XQFunction.isStrNil(beta) then
        beta = ""
    end
    return LuciUtil.trim(beta)
end

--- 获取语言列表
--- @return table 语言列表
function getLangList()
    local LuciUtil = require("luci.util")
    local LuciConfig = require("luci.config")
    local langList = {}
    
    for lang, name in pairs(LuciConfig.languages) do
        if type(name) == "string" then
            if lang:sub(1, 1) ~= "." then
                local item = {
                    lang = lang,
                    name = name
                }
                table.insert(langList, item)
            end
        end
    end
    
    return langList
end

--- 获取当前语言
--- @return string 语言代码
function getLang()
    local LuciConfig = require("luci.config")
    return LuciConfig.main.lang
end

--- 设置语言
--- @param lang string 语言代码
--- @return boolean 是否成功
function setLang(lang)
    local LuciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    local LuciConfig = require("luci.config")
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local countryCode = XQCountryCode.getCurrentCountryCode()
    
    for code, name in pairs(LuciConfig.languages) do
        if type(name) == "string" then
            if code:sub(1, 1) ~= "." and (lang == code or lang == "auto") then
                if lang == "auto" then
                    uci:set("luci", "main", "lang", "auto")
                else
                    uci:set("luci", "main", "lang", code)
                end
                uci:commit("luci")
                uci:save("luci")
                return true
            end
        end
    end
    
    if countryCode ~= "CN" then
        uci:set("luci", "main", "lang", "en")
        uci:commit("luci")
        uci:save("luci")
        return true
    else
        return false
    end
end

--- 设置位置/国家代码
--- @param countryCode string 国家代码
--- @param restartAgent boolean 是否重启消息代理
--- @param region string 区域代码
--- @return boolean 是否成功
function setLocation(countryCode, restartAgent, region)
    local uci = require("luci.model.uci").cursor()
    local bdataCountryCode = XQFunction.bdataGet("CountryCode")
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    
    local mappedRegion = uci:get("country_mapping", countryCode, "region") or ""
    
    if mappedRegion == "" then
        if XQFunction.isStrNil(region) then
            return true
        else
            region = string.upper(region)
            local mappedCode = uci:get("region_mapping", region, "CountryCode")
            countryCode = mappedCode or countryCode
            if not mappedCode then
                countryCode = ""
            end
        end
    end
    
    if XQFunction.isStrNil(countryCode) then
        return true
    end
    
    if restartAgent == nil then
        restartAgent = true
    end
    
    XQFunction.nvramSet("CountryCode", countryCode)
    XQFunction.nvramCommit()
    
    local serverName = "server_" .. mappedRegion
    local apiServer = uci:get("server_mapping", serverName, "API") or ""
    
    if apiServer == "" then
        return true
    end
    
    uci:set("miwifi", "server", "API", apiServer)
    
    local logServer = uci:get("server_mapping", serverName, "LOG") or ""
    if logServer ~= "" then
        uci:set("miwifi", "server", "LOG", logServer)
    else
        uci:delete("miwifi", "server", "LOG")
    end
    
    local sServer = uci:get("server_mapping", serverName, "S") or ""
    if sServer ~= "" then
        uci:set("miwifi", "server", "S", sServer)
    else
        uci:delete("miwifi", "server", "S")
    end
    
    local appServer = uci:get("server_mapping", serverName, "APP") or ""
    if appServer ~= "" then
        uci:set("miwifi", "server", "APP", appServer)
    else
        uci:delete("miwifi", "server", "APP")
    end
    
    local stunServer = uci:get("server_mapping", serverName, "STUN") or ""
    if stunServer ~= "" then
        uci:set("miwifi", "server", "STUN", stunServer)
    else
        uci:delete("miwifi", "server", "STUN")
    end
    
    local brokerServer = uci:get("server_mapping", serverName, "BROKER") or ""
    if brokerServer ~= "" then
        uci:set("miwifi", "server", "BROKER", brokerServer)
    else
        uci:delete("miwifi", "server", "BROKER")
    end
    
    uci:commit("miwifi")
    
    if bdataCountryCode == "UK" then
        if XQCountryCode.isCountryAS(countryCode) then
            local wifiCountry = "MY"
            uci:set("wireless", "wifi0", "country", wifiCountry)
            uci:set("wireless", "wifi1", "country", wifiCountry)
            uci:set("wireless", "wifi2", "country", wifiCountry)
            uci:commit("wireless")
        end
        if countryCode == "GB" then
            local wifiCountry = "GB"
            uci:set("wireless", "wifi0", "country", wifiCountry)
            uci:set("wireless", "wifi1", "country", wifiCountry)
            uci:set("wireless", "wifi2", "country", wifiCountry)
            uci:commit("wireless")
        end
    end
    
    if bdataCountryCode == "EU" then
        if XQCountryCode.isCountryETSI_special(countryCode) then
            local wifiCountry = countryCode
            uci:set("wireless", "wifi0", "country", wifiCountry)
            uci:set("wireless", "wifi1", "country", wifiCountry)
            uci:set("wireless", "wifi2", "country", wifiCountry)
            uci:commit("wireless")
        end
    end
    
    local LuciUtil = require("luci.util")
    if restartAgent then
        LuciUtil.exec("sleep 2;/etc/init.d/messagingagent.sh restart > /dev/null 2>&1")
    end
    LuciUtil.exec("/etc/init.d/timezone start > /dev/null 2>&1")
    
    return true
end

--- 获取当前位置/国家代码
--- @return string 国家代码
function getLocation()
    local countryCode = XQFunction.nvramGet("CountryCode", "DE")
    if countryCode == "EU" or countryCode == "" then
        countryCode = "DE"
    end
    return countryCode
end

--- 设置默认系统密码
function setSysPasswordDefault()
    local LuciSys = require("luci.sys")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    XQSecureUtil.savePlaintextPwd("admin", "admin")
end

--- 检查系统密码
--- @param password string 密码
--- @return boolean 是否正确
function checkSysPassword(password)
    local LuciSys = require("luci.sys")
    return LuciSys.user.checkpasswd("root", password)
end

--- 设置系统密码
--- @param password string 新密码
--- @return boolean 是否成功
function setSysPassword(password)
    local LuciSys = require("luci.sys")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    
    local result = LuciSys.user.setpasswd("root", password)
    XQSecureUtil.savePlaintextPwd("admin", password)
    
    if result == 0 then
        return true
    else
        local LuciUtil = require("luci.util")
        LuciUtil.exec("rm /etc/passwd+")
    end
    return false
end

--- 裁剪镜像
--- @param imagePath string 镜像路径
--- @return boolean 是否成功
function cutImage(imagePath)
    if not imagePath then
        return false
    end
    
    local result = os.execute(XQConfigs.XQ_CUT_IMAGE .. imagePath)
    if result == 0 or result == 127 then
        return true
    else
        return false
    end
end

--- CPE镜像验证
--- @param imagePath string 镜像路径
--- @return boolean 是否验证通过
function cpe_verifyImage(imagePath)
    local ispCode = getISPCode()
    local imageIspCode = getImageIspcode(imagePath)
    local XQLog = require("xiaoqiang.XQLog")
    
    if ispCode ~= imageIspCode then
        XQLog.log(6, "cpe_verifyImage failed: ispcode(" .. ispCode .. "), imageIspcode(" .. imageIspCode .. ")")
        return false
    end
    
    XQLog.log(6, "cpe_verifyImage: ispcode " .. ispCode)
    return true
end

--- OTA镜像验证
--- @param imagePath string 镜像路径
--- @return boolean 是否验证通过
function ota_verifyImage(imagePath)
    local isCpe = XQFunction.getFeature("0", "system", "cpe")
    if isCpe == "1" then
        return cpe_verifyImage(imagePath)
    end
    return true
end

--- 验证固件镜像
--- @param imagePath string 镜像路径
--- @param checkOta boolean 是否检查OTA
--- @return boolean 是否验证通过
function verifyImage(imagePath, checkOta)
    if not imagePath then
        return false
    end
    
    local miscInfo = getMiscHardwareInfo()
    local result = os.execute(miscInfo.verify .. "'" .. imagePath .. "' > /dev/null")
    
    if result == 0 then
        if checkOta then
            if not ota_verifyImage(imagePath) then
                return false
            end
        end
        
        local secbootResult = os.execute("/usr/sbin/secboot_upgrade_check.sh fail_return " .. imagePath .. " > /dev/null")
        if secbootResult ~= 0 then
            return false
        end
        return true
    end
    return false
end

--- 验证CPE镜像
--- @param header string 头文件
--- @param modem string 调制解调器文件
--- @param sign string 签名文件
--- @return boolean 是否验证通过
function verifyCPEImage(header, modem, sign)
    if not (header and modem and sign) then
        return false
    end
    
    local result = os.execute("cd /tmp;verifycpeimage -h " .. header .. " -m " .. modem .. " -s " .. sign .. " > /dev/null")
    if result == 0 then
        return true
    else
        return false
    end
end

--- 字节序交换
--- @param data string 数据
--- @return number 转换后的数值
function swapEndian(data)
    local hex = string.format("%02x%02x%02x%02x", 
        data:byte(4), data:byte(3), data:byte(2), data:byte(1))
    return tonumber(hex, 16)
end

--- 获取系统信息
--- @return table 系统信息表
function getSysInfo()
    local LuciSys = require("luci.sys")
    local LuciUtil = require("luci.util")
    local miscInfo = getMiscHardwareInfo()
    local sysInfo = {}
    
    local cpuInfo = LuciUtil.execl("cat /cpuinfo | grep processor")
    local system, loads, totalMem, cacheMem, bufferMem, freeMem, bogomips = LuciSys.sysinfo()
    
    local cpuCount = #cpuInfo
    if cpuCount > 0 then
        sysInfo.core = cpuCount
    else
        sysInfo.core = 1
    end
    
    local function roundMemory(mem)
        local value = tonumber(mem)
        if value then
            local remainder = value % 64
            if remainder >= 32 then
                return value + 64 - remainder
            else
                return value - remainder
            end
        else
            return 0
        end
    end
    
    if miscInfo.cpufreq then
        sysInfo.hz = miscInfo.cpufreq
    else
        sysInfo.hz = XQFunction.hzFormat(tonumber(bogomips) * 500000)
    end
    
    if miscInfo.memsize then
        sysInfo.memTotal = miscInfo.memsize
    else
        sysInfo.memTotal = string.format("%d M", roundMemory(totalMem / 1024))
    end
    
    sysInfo.system = system
    sysInfo.memFree = string.format("%0.2f M", freeMem / 1024)
    
    return sysInfo
end

--- 获取磁盘空间
--- @return string 磁盘空间
function getDiskSpace()
    local LuciUtil = require("luci.util")
    local space = LuciUtil.exec(XQConfigs.DISK_SPACE)
    
    if space then
        local value = tonumber(LuciUtil.trim(space))
        if value then
            return XQFunction.byteFormat(value * 1024)
        end
    else
        return "Cannot find userdisk"
    end
end

--- 获取可用内存
--- @return number|boolean 可用内存(KB)或false
function getAvailableMemery()
    local LuciUtil = require("luci.util")
    local memory = LuciUtil.exec(XQConfigs.AVAILABLE_MEMERY)
    
    if memory then
        local value = tonumber(LuciUtil.trim(memory))
        if value then
            return value
        end
    else
        return false
    end
end

--- 获取可用磁盘空间
--- @param cmd string 可选命令
--- @return number|boolean 可用空间(KB)或false
function getAvailableDisk(cmd)
    local LuciUtil = require("luci.util")
    local command = cmd or XQConfigs.AVAILABLE_DISK
    local disk = LuciUtil.exec(command)
    
    if disk then
        local value = tonumber(LuciUtil.trim(disk))
        if value then
            return value
        end
    else
        return false
    end
end

--- 获取可用空间
--- @param path string 路径
--- @return number 可用空间(KB)
function getAvailableSpace(path)
    if path then
        if path:match("/userdisk/data") then
            return getAvailableDisk("df -k | grep \\ /userdisk/data$ | awk '{print $4}' | sed -n '1p'")
        elseif path:match("/userdisk") then
            return getAvailableDisk()
        end
    end
    return getAvailableMemery()
end

--- 检查磁盘空间是否足够
--- @param size number 需要的空间(字节)
--- @return boolean 是否足够
function checkDiskSpace(size)
    local available = getAvailableDisk()
    if available then
        local remaining = available - size / 1024
        if remaining > 10240 then
            return true
        end
    end
    return false
end

--- 检查临时空间是否足够
--- @param size number 需要的空间(字节)
--- @return boolean 是否足够
function checkTmpSpace(size)
    local available = getAvailableMemery()
    if available then
        local remaining = available - size / 1024
        if remaining > 10240 then
            return true
        end
    end
    return false
end

--- 检查空间是否足够
--- @param path string 路径
--- @param size number 需要的空间(字节)
--- @return boolean 是否足够
function checkSpace(path, size)
    if path and size then
        local available = getAvailableSpace(path)
        if available then
            local remaining = available - size / 1024
            if remaining > 10240 then
                return true
            end
        end
    end
    return false
end

--- 获取上传目录
--- @return string 上传目录路径
function getUploadDir()
    return "/tmp/"
end

--- 获取上传ROM文件路径
--- @return string ROM文件路径
function getUploadRomFilePath()
    return XQConfigs.CROM_CACHE_FILEPATH
end

--- 获取CPE头文件路径
--- @return string 头文件路径
function getUploadRomCPEHeaderFilePath()
    return XQConfigs.CPE_HEADER_CACHE_FILEPATH
end

--- 获取CPE调制解调器文件路径
--- @return string 调制解调器文件路径
function getUploadRomCPEModemFilePath()
    return XQConfigs.CPE_MODEM_CACHE_FILEPATH
end

--- 获取CPE签名文件路径
--- @return string 签名文件路径
function getUploadRomCPESignFilePath()
    return XQConfigs.CPE_SIGN_CACHE_FILEPATH
end

--- 获取CPE头文件长度
--- @return number 头文件长度
function getUploadRomCPEHeaderLength()
    return XQConfigs.CPE_HEADER_LENGTH
end

--- 获取CPE签名长度
--- @return number 签名长度
function getUploadRomCPESignLength()
    return XQConfigs.CPE_SIGN_LENGTH
end

--- 获取CPE分片大小
--- @return number 分片大小
function getUploadRomCPESliceSize()
    return XQConfigs.CPE_UPLOAD_CPE_ROM_SLICE_SIZE
end

--- 获取上传插件文件路径
--- @return string 插件文件路径
function getUploadPlugFilePath()
    return XQConfigs.CPlug_CACHE_FILEPATH
end

--- 更新CPE调制解调器长度
--- @param length number 长度
function updateModemLengthForCPE(length)
    local lengthStr = tostring(length)
    os.execute("echo " .. lengthStr .. " > " .. XQConfigs.CPE_MODEM_LENGTH_FILE)
end

--- 获取CPE调制解调器长度
--- @return number 长度
function getModemLengthForCPE()
    local LuciUtil = require("luci.util")
    local length = tonumber(LuciUtil.exec(XQConfigs.GET_CPE_MODEM_LENGTH_FILE))
    if length then
        return length
    else
        return 0
    end
end

--- 更新升级状态
--- @param status number 状态码
function updateUpgradeStatus(status)
    local statusStr = tostring(status)
    os.execute("echo " .. statusStr .. " > " .. XQConfigs.UPGRADE_LOCK_FILE)
end

--- 获取升级状态
--- @return number 状态码
function getUpgradeStatus()
    local LuciUtil = require("luci.util")
    local status = tonumber(LuciUtil.exec(XQConfigs.UPGRADE_STATUS))
    if status then
        return status
    else
        return 0
    end
end

--- 获取刷写进度
--- @return number 进度百分比
function getFlashProgress()
    local LuciUtil = require("luci.util")
    local progress = tonumber(LuciUtil.exec("cat /tmp/state/upgrade_progress 2>/dev/null"))
    if progress then
        return progress
    else
        return 0
    end
end

--- 获取升级结果
--- @return number 结果码
function getUpgradeResult()
    local LuciUtil = require("luci.util")
    local NixioFs = require("nixio.fs")
    local resultFile = "/tmp/upgraded_result"
    local result = 0
    
    if NixioFs.access(resultFile) then
        result = tonumber(LuciUtil.exec("cat /tmp/upgraded_result 2>/dev/null")) or 0
    end
    return result
end

--- 获取OTA预下载设置
--- @return number 设置值
function getOtapred()
    local LuciUtil = require("luci.util")
    local value = tonumber(LuciUtil.exec("uci -q get otapred.settings.auto"))
    if value then
        return value
    else
        return 0
    end
end

--- 检查是否已升级
--- @return boolean 是否已升级
function checkBeenUpgraded()
    local LuciUtil = require("luci.util")
    local flag = tonumber(LuciUtil.trim(LuciUtil.exec("nvram get flag_ota_reboot")))
    if flag == 1 then
        return true
    else
        return false
    end
end

--- 获取刷写状态
--- @return number 状态码 (0=空闲, 1=刷写中, 2=已升级, 3=等待中)
function getFlashStatus()
    local LuciFs = require("luci.fs")
    
    if checkBeenUpgraded() then
        return 2
    end
    
    local result = os.execute(XQConfigs.FLASH_EXECUTION_CHECK)
    if result ~= 0 then
        return 1
    end
    
    if not LuciFs.access(XQConfigs.FLASH_PID_TMP) then
        return 0
    else
        return 3
    end
end

--- 检查升级状态
--- @return number 状态码
function checkUpgradeStatus()
    local LuciFs = require("luci.fs")
    
    if checkBeenUpgraded() then
        return 11
    end
    
    local upgradeStatus = getUpgradeStatus()
    local cronStatus = checkExecStatus(XQConfigs.CRONTAB_ROM_CHECK)
    
    if cronStatus == 1 then
        if upgradeStatus == 0 then
            return 1
        else
            return upgradeStatus
        end
    end
    
    local flashExecResult = os.execute(XQConfigs.FLASH_EXECUTION_CHECK)
    if flashExecResult ~= 0 then
        local flashCheck = checkExecStatus(XQConfigs.CROM_FLASH_CHECK)
        if flashCheck == 1 then
            return 12
        else
            return 5
        end
    end
    
    local flashStatus = getFlashStatus()
    
    if LuciFs.access(XQConfigs.CRONTAB_PID_TMP) then
        if upgradeStatus == 0 then
            if flashStatus == 2 then
                return 11
            elseif flashStatus == 3 then
                return 10
            end
        end
        return upgradeStatus
    elseif flashStatus == 2 then
        return 11
    elseif flashStatus == 3 then
        return 10
    end
    
    return 0
end

--- 检查是否正在升级
--- @return boolean 是否正在升级
function isUpgrading()
    local status = checkUpgradeStatus()
    if status == 1 or status == 2 or status == 3 or status == 4 or status == 5 or status == 12 then
        return true
    else
        return false
    end
end

--- 取消升级
--- @return boolean 是否成功
function cancelUpgrade()
    local LuciUtil = require("luci.util")
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQDownloadUtil = require("xiaoqiang.util.XQDownloadUtil")
    
    local flashExecResult = os.execute(XQConfigs.FLASH_EXECUTION_CHECK)
    if flashExecResult ~= 0 then
        return false
    end
    
    local upgradePid = LuciUtil.exec(XQConfigs.UPGRADE_PID)
    local upgradeLuaPid = LuciUtil.exec(XQConfigs.UPGRADE_LUA_PID)
    
    if not XQFunction.isStrNil(upgradePid) then
        upgradePid = LuciUtil.trim(upgradePid)
        os.execute("kill " .. upgradePid)
        
        if not XQFunction.isStrNil(upgradeLuaPid) then
            os.execute("kill " .. LuciUtil.trim(upgradeLuaPid))
        end
        
        XQDownloadUtil.cancelDownload(XQPreference.get(XQConfigs.PREF_ROM_DOWNLOAD_ID, ""))
        XQFunction.sysUnlock()
        return true
    else
        return false
    end
end

--- 获取CPU温度
--- @return number CPU温度
function getCpuTemperature()
    local LuciUtil = require("luci.util")
    local tempStr = LuciUtil.exec(XQConfigs.CPU_TEMPERATURE)
    
    if not XQFunction.isStrNil(tempStr) then
        local temp = tempStr:match("Temperature: (%S+)")
        if temp then
            return tonumber(LuciUtil.trim(temp))
        end
    end
    return 0
end

--- 获取网络检测信息
--- @param mode number 检测模式 (1=简单无日志, 2=简单, 其他=完整)
--- @param url string 检测URL
--- @return table|nil 检测结果
function getNetworkDetectInfo(mode, url)
    local LuciUtil = require("luci.util")
    local json = require("json")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local result = {}
    
    local targetUrl = url
    if url ~= nil then
        if XQSecureUtil.cmdSafeCheck(url) then
            targetUrl = url
        end
    end
    targetUrl = targetUrl or "http://www.baidu.com"
    
    if targetUrl then
        if targetUrl:match("http://") == nil and targetUrl:match("https://") == nil then
            targetUrl = "http://" .. targetUrl
        end
    end
    
    local detectResult = nil
    local modeNum = tonumber(mode)
    
    if modeNum == 1 then
        detectResult = LuciUtil.exec(XQConfigs.SIMPLE_NETWORK_NOLOG_DETECT .. "'" .. targetUrl .. "'")
    elseif modeNum == 2 then
        detectResult = LuciUtil.exec(XQConfigs.SIMPLE_NETWORK_DETECT .. "'" .. targetUrl .. "'")
    else
        detectResult = LuciUtil.exec(XQConfigs.FULL_NETWORK_DETECT .. "'" .. targetUrl .. "'")
    end
    
    if detectResult then
        local decoded = json.decode(LuciUtil.trim(detectResult))
        if decoded and type(decoded) == "table" then
            local checkInfo = decoded.CHECKINFO
            if checkInfo and type(checkInfo) == "table" then
                result.wanLink = (checkInfo.wanlink == "up") and 1 or 0
                result.wanType = checkInfo.wanprotocal or ""
                result.pingLost = checkInfo.ping:match("(%S+)%%")
                result.gw = checkInfo.gw:match("(%S+)%%")
                result.dns = (checkInfo.dns == "ok") and 1 or 0
                result.tracer = (checkInfo.tracer == "ok") and 1 or 0
                result.memory = tonumber(checkInfo.memory) * 100
                result.cpu = tonumber(checkInfo.cpu)
                result.disk = checkInfo.disk
                result.tcp = checkInfo.tcp
                result.http = checkInfo.http
                result.ip = checkInfo.ip
                return result
            end
        end
    end
    return nil
end

--- 检查系统状态
--- @return table 系统状态表
function checkSystemStatus()
    local LuciUtil = require("luci.util")
    local LuciSys = require("luci.sys")
    local status = {}
    
    local system, loads, totalMem, cacheMem, bufferMem, freeMem, bogomips = LuciSys.sysinfo()
    
    status.cpu = tonumber(LuciUtil.trim(LuciUtil.exec(XQConfigs.CPU_LOAD_AVG))) or 0
    status.mem = tonumber(string.format("%0.2f", 1 - (cacheMem + bufferMem + freeMem) / totalMem)) or 0
    status.link = string.upper(LuciUtil.trim(LuciUtil.exec(XQConfigs.WAN_LINK))) == "UP"
    status.wan = true
    status.tmp = getCpuTemperature()
    
    return status
end

--- 获取刷写权限
--- @return boolean 是否有权限
function getFlashPermission()
    local LuciUtil = require("luci.util")
    local permission = LuciUtil.exec(XQConfigs.GET_FLASH_PERMISSION)
    
    if XQFunction.isStrNil(permission) then
        return false
    else
        local value = tonumber(LuciUtil.trim(permission))
        if value and value == 1 then
            return true
        end
    end
    return false
end

--- 设置刷写权限
--- @param enabled boolean 是否启用
function setFlashPermission(enabled)
    local LuciUtil = require("luci.util")
    if enabled then
        LuciUtil.exec(XQConfigs.SET_FLASH_PERMISSION .. "1")
    else
        LuciUtil.exec(XQConfigs.SET_FLASH_PERMISSION .. "0")
    end
end

--- 设置MAC过滤启用模式
--- @param enable string 启用状态
--- @param mode string 模式 (0=白名单, 1=黑名单)
--- @param filter string 过滤器名称
--- @return number 结果码
function setmacfilterenablemode(enable, mode, filter)
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    if mode == nil or enable == nil or filter == nil then
        return 1523
    end
    
    local filterMode = (mode == "0") and "white" or "black"
    
    local oldEnable = uci:get("macfilter", filter, "enable")
    local oldMode = uci:get("macfilter", filter, "mode")
    
    if oldEnable == enable and oldMode == filterMode then
        return 0
    end
    
    uci:set("macfilter", filter, "enable", enable)
    uci:set("macfilter", filter, "mode", filterMode)
    uci:commit("macfilter")
    
    XQLog.log(4, "uci commit macfilter enable=" .. enable .. " filter=" .. filter .. " mode=" .. filterMode)
    
    local cmd = "/usr/sbin/macfilter enable " .. enable .. " " .. filterMode .. " " .. filter
    XQLog.log(4, "set macfilter enable: " .. cmd)
    
    local result = 0
    if cmd then
        result = os.execute(cmd)
    end
    
    return result
end

--- 设置IP过滤启用模式
--- @param enable string 启用状态
--- @param mode string 模式 (0=白名单, 1=黑名单)
--- @param filter string 过滤器名称
--- @return number 结果码
function setipfilterenablemode(enable, mode, filter)
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    if mode == nil or enable == nil or filter == nil then
        return 1523
    end
    
    local filterMode = (mode == "0") and "white" or "black"
    
    local oldEnable = uci:get("ipfilter", filter, "enable")
    local oldMode = uci:get("ipfilter", filter, "mode")
    
    if oldEnable == enable and oldMode == filterMode then
        return 0
    end
    
    uci:set("ipfilter", filter, "enable", enable)
    uci:set("ipfilter", filter, "mode", filterMode)
    uci:commit("ipfilter")
    
    XQLog.log(4, "uci commit ipfilter enable=" .. enable .. " filter=" .. filter .. " mode=" .. filterMode)
    
    local cmd = "/usr/sbin/ipfilter enable " .. enable .. " " .. filterMode .. " " .. filter
    XQLog.log(4, "set ipfilter enable: " .. cmd)
    
    local result = 0
    if cmd then
        result = os.execute(cmd)
    end
    
    return result
end

--- 获取MAC过滤启用状态
--- @param filter string 过滤器名称
--- @return string 启用状态
function getMacfilterEnable(filter)
    local uci = require("luci.model.uci").cursor()
    if filter then
        return uci:get("macfilter", filter, "enable")
    end
end

--- 获取MAC过滤模式
--- @param filter string 过滤器名称 (lan/wan/admin)
--- @return number 模式 (0=白名单, 1=黑名单)
function getMacfilterMode(filter)
    local uci = require("luci.model.uci").cursor()
    local LuciUtil = require("luci.util")
    
    local mode = uci:get("macfilter", filter, "mode")
    if mode and mode == "white" then
        return 0
    else
        return 1
    end
end

--- 设置MAC过滤模式
--- @param filter string 过滤器名称
--- @param mode string 模式
--- @return boolean 是否成功
function setMacfilterMode(filter, mode)
    local LuciUtil = require("luci.util")
    local cmd = nil
    
    if filter == "lan" then
        if tonumber(mode) == 0 then
            cmd = XQConfigs.SET_LAN_WHITELIST
        else
            cmd = XQConfigs.SET_LAN_BLACKLIST
        end
    elseif filter == "wan" then
        if tonumber(mode) == 0 then
            cmd = XQConfigs.SET_WAN_WHITELIST
        else
            cmd = XQConfigs.SET_WAN_BLACKLIST
        end
    elseif filter == "admin" then
        if tonumber(mode) == 0 then
            cmd = XQConfigs.SET_ADMIN_WHITELIST
        else
            cmd = XQConfigs.SET_ADMIN_BLACKLIST
        end
    end
    
    if cmd then
        local result = os.execute(cmd)
        if result == 0 then
            return true
        end
    else
        return false
    end
end

--- 获取检测时间戳
--- @return number 时间戳
function getDetectionTimestamp()
    local XQPreference = require("xiaoqiang.XQPreference")
    return tonumber(XQPreference.get(XQConfigs.PREF_TIMESTAMP, "0"))
end

--- 设置检测时间戳
function setDetectionTimestamp()
    local XQPreference = require("xiaoqiang.XQPreference")
    XQPreference.set(XQConfigs.PREF_TIMESTAMP, tostring(os.time()))
end

--- 收集WiFi日志
function getWifiLog()
    os.execute(XQConfigs.WIFI_LOG_COLLECTION)
end

--- 获取NVRAM配置
--- @return table NVRAM配置表
function getNvramConfigs()
    local configs = {}
    configs.rom_ver = XQFunction.nvramGet("nv_rom_ver", "")
    configs.rom_channel = XQFunction.nvramGet("nv_rom_channel", "")
    configs.hardware = XQFunction.nvramGet("nv_hardware", "")
    configs.uboot = XQFunction.nvramGet("nv_uboot", "")
    configs.linux = XQFunction.nvramGet("nv_linux", "")
    configs.ramfs = XQFunction.nvramGet("nv_ramfs", "")
    configs.sqafs = XQFunction.nvramGet("nv_sqafs", "")
    configs.rootfs = XQFunction.nvramGet("nv_rootfs", "")
    return configs
end

--- 获取noflushd状态
--- @return number 状态码
function noflushdStatus()
    return os.execute("/etc/init.d/noflushd status")
end

--- noflushd开关
--- @param enabled boolean 是否启用
--- @return boolean 是否成功
function noflushdSwitch(enabled)
    if enabled then
        return os.execute("/etc/init.d/noflushd on") == 0
    else
        return os.execute("killall -s 10 noflushd ; /etc/init.d/noflushd off") == 0
    end
end

--- 网络诊断错误描述表
NETTB = {
    ["1"] = "路由器没有检测到WAN口网线接入",
    ["2"] = "DHCP服务没有响应",
    ["3"] = "宽带拨号服务无响应",
    ["4"] = "上级网络IP与路由器局域网IP有冲突",
    ["5"] = "网关不可达",
    ["6"] = "DNS服务器无法服务，可以尝试自定义DNS解决(114.114.114.114, 114.114.115.115  国外8.8.8.8  8.8.4.4)",
    ["7"] = "自定义的DNS无法服务，请关闭自动以DNS或者重新设置",
    ["8"] = "无线中继，无法中继上级",
    ["9"] = "有线中继，无法中继上级",
    ["10"] = "静态IP，连接时连接断开",
    ["11"] = "mesh从设备，无法连接主路由",
    ["12"] = "SIM卡验证问题",
    ["13"] = "蜂窝数据未开启",
    ["14"] = "注网失败",
    ["15"] = "无蜂窝信号",
    ["16"] = "IP分配错误",
    ["17"] = "上级网络IP与路由器局域网IP有冲突",
    ["18"] = "DNS解析失败",
    ["19"] = "无法连接外网",
    ["31"] = "PPPoE服务器不允许一个账号同时登录",
    ["32"] = "PPPoE上网是用户名或者密码错误 691",
    ["33"] = "PPPoE上网是用户名或者密码错误 678"
}

--- 网络诊断
--- @return table 诊断结果
function nettb()
    local json = require("json")
    local LuciUtil = require("luci.util")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local result = {code = 0}
    local output = LuciUtil.exec("/usr/sbin/nettb")
    
    if not XQFunction.isStrNil(output) then
        output = LuciUtil.trim(output)
        local decoded = json.decode(output)
        if decoded and decoded.code then
            result.code = tonumber(decoded.code)
            
            if result.code == 32 then
                result.code = XQLanWanUtil._pppoeError(691) or result.code
            elseif result.code == 33 then
                result.code = XQLanWanUtil._pppoeError(678) or result.code
            end
        end
    end
    
    return result
end

--- 网络诊断2
--- @param param string 参数
--- @return table 诊断结果
function nettb2(param)
    local json = require("json")
    local LuciUtil = require("luci.util")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local result = {code = 0}
    local output = LuciUtil.exec("/usr/sbin/nettb2 " .. param)
    
    if not XQFunction.isStrNil(output) then
        output = LuciUtil.trim(output)
        local decoded = json.decode(output)
        if decoded and decoded.code then
            result.code = tonumber(decoded.code)
            
            if result.code == 32 then
                result.code = XQLanWanUtil._pppoeError(691) or result.code
            elseif result.code == 33 then
                result.code = XQLanWanUtil._pppoeError(678) or result.code
            end
        end
    end
    
    return result
end

--- 获取设备颜色
--- @return number 颜色代码
function getColor()
    local LuciUtil = require("luci.util")
    local color = LuciUtil.exec("nvram get color")
    
    if not XQFunction.isStrNil(color) then
        color = LuciUtil.trim(color)
        color = tonumber(color)
        if not color then
            color = 100
        end
    else
        color = 100
    end
    return color
end

--- 获取绑定信息
--- @return number 绑定状态
function getBindinfo()
    local XQLog = require("xiaoqiang.XQLog")
    local json = require("json")
    local LuciUtil = require("luci.util")
    
    local cmd = "matool --method api_call --params \"/device/minet_get_bindinfo\""
    local ret = LuciUtil.exec(cmd)
    
    if ret then
        XQLog.log(6, "ret " .. ret)
        local decoded = json.decode(ret)
        local code = decoded.code
        XQLog.log(6, "code: " .. code)
        
        if code ~= nil and code == 0 then
            local bind = decoded.data.bind
            XQLog.log(6, "bind: " .. bind)
            return bind
        else
            XQLog.log(6, "bind return 2")
            return 2
        end
    else
        return 2
    end
end

--- 获取路由器信息(JSON格式)
--- @return string JSON格式的路由器信息
function getRouterInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local cjson = require("cjson")
    
    local wifiStatus = XQWifiUtil.getWifiStatus(1) or {}
    local bssid1, bssid2 = XQWifiUtil.getWifiBssid()
    
    local info = {}
    info.hardware = getHardware()
    info.channel = getChannel()
    info.color = getColor()
    info.locale = getRouterLocale()
    info.ssid = wifiStatus.ssid or ""
    info.bssid1 = bssid1 or ""
    info.bssid2 = bssid2 or ""
    info.ip = XQLanWanUtil.getLanIp()
    
    return cjson.encode(info)
end

--- 获取路由器信息(用于trafficd)
--- @return string JSON格式的路由器信息
function getRouterInfo4Trafficd()
    local uci = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local LuciUtil = require("luci.util")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local cjson = require("cjson")
    
    local ssid = LuciUtil.exec("uci -q get wireless.@wifi-iface[0].ssid")
    local bssid1, bssid2 = XQWifiUtil.getWifiBssid()
    ssid = string.sub(ssid, 0, string.len(ssid) - 1)
    
    local info = {}
    info.hardware = getHardware()
    info.channel = getChannel()
    info.color = getColor()
    info.locale = getRouterLocale()
    info.ssid = ssid or ""
    info.bssid1 = bssid1 or ""
    info.bssid2 = bssid2 or ""
    info.ip = XQLanWanUtil.getLanIp()
    info.sn = getSN()
    info.bind_status = tonumber(uci:get("bind", "info", "status")) or 0
    info.bind_record = tonumber(uci:get("bind", "info", "record")) or 0
    
    return cjson.encode(info)
end

--- 备份系统日志
--- @return string|nil 备份文件名
function backupSysLog()
    local XQConfigs = require("xiaoqiang.common.XQConfigs")
    local uci = require("luci.model.uci").cursor()
    local NixioFs = require("nixio.fs")
    local LuciSys = require("luci.sys")
    
    local backupDir = "/tmp/syslogbackup/"
    local lanIp = uci:get("network", "lan", "ipaddr") or ""
    
    local function sane()
        return LuciSys.process.info("uid") == NixioFs.stat(backupDir, "uid")
    end
    
    local function prepare()
        NixioFs.mkdir(backupDir, 700)
    end
    
    if not sane() then
        prepare()
    else
        os.execute("rm " .. backupDir .. "*.tar.gz")
    end
    
    os.execute("/usr/sbin/log_collection.sh >/dev/null 2>/dev/null")
    
    if NixioFs.access(XQConfigs.LOG_ZIP_FILEPATH) then
        local filename = os.date("%Y-%m-%d--%X", os.time()) .. ".tar.gz"
        os.execute("cp " .. XQConfigs.LOG_ZIP_FILEPATH .. " " .. backupDir .. filename)
        os.execute("rm " .. XQConfigs.LOG_ZIP_FILEPATH)
        return filename
    end
    return nil
end

--- 设置LED状态
--- @param enabled boolean 是否开启
function setLedStatus(enabled)
    if enabled then
        XQFunction.forkExec("/usr/sbin/led_ctl led_on")
    else
        XQFunction.forkExec("/usr/sbin/led_ctl led_off")
    end
end

--- 获取LED状态
--- @return number LED状态
function getLedStatus()
    local uci = require("luci.model.uci").cursor()
    local status = uci:get("xiaoqiang", "common", "BLUE_LED") or 0
    return tonumber(status)
end

--- 禁用LED Mesh同步
function disableLedMeshSync()
    local uci = require("luci.model.uci").cursor()
    uci:set("xiaoqiang", "common", "led_mesh_sync_disabled", "1")
    uci:commit("xiaoqiang")
end

--- 设置LED定时器
--- @param enabled boolean 是否启用
--- @param openTime string 开启时间 (HH:MM)
--- @param closeTime string 关闭时间 (HH:MM)
--- @return number 结果 (0=失败, 1=成功)
function setLedTimer(enabled, openTime, closeTime)
    local XQLog = require("xiaoqiang.XQLog")
    local cmd = "/usr/sbin/led_ctl timer_off"
    local result = 0
    
    if enabled then
        local openHour, openMin = string.match(openTime, "^([0-2][0-9]):([0-5][0-9])$")
        local closeHour, closeMin = string.match(closeTime, "^([0-2][0-9]):([0-5][0-9])$")
        
        if closeHour and closeMin and openHour and openMin then
            if tonumber(closeHour) < 24 and tonumber(openHour) < 24 then
                cmd = string.format("/usr/sbin/led_ctl timer_on %s %s %s %s", 
                    openHour, openMin, closeHour, closeMin)
                result = 1
            end
        else
            XQLog.log(4, "XQSysUtil - setLedTimer : resolve timer string failed!")
        end
    end
    
    XQFunction.forkExec(cmd)
    XQLog.log(4, string.format("XQSysUtil - setLedTimer : set timer %d", result))
    
    return result
end

--- 获取LED定时器状态
--- @return table 定时器状态表
function getLedTimerStatus()
    local uci = require("luci.model.uci").cursor()
    local status = {}
    
    status.status = tonumber(uci:get("xiaoqiang", "common", "BLUE_LED_TIMER") or 0)
    status.timer_open = uci:get("xiaoqiang", "common", "BLUE_LED_TIMER_OPEN") or ""
    status.timer_close = uci:get("xiaoqiang", "common", "BLUE_LED_TIMER_CLOSE") or ""
    
    return status
end

--- 获取移动加速状态
--- @return string 状态 ("0"=不可用, "1"=可用)
function getMobileAccel()
    local uci = require("luci.model.uci").cursor()
    
    local enabled = uci:get("mobile_accel", "settings", "enabled") or ""
    if enabled == "0" then
        return "0"
    end
    
    local clientActive = uci:get("mobile_accel", "settings", "client_active") or ""
    local clientMax = uci:get("mobile_accel", "settings", "client_active_max") or ""
    
    if tonumber(clientActive) >= tonumber(clientMax) then
        return "0"
    end
    
    local netMode = uci:get("xiaoqiang", "common", "NETMODE") or ""
    if netMode == "wifiapmode" or netMode == "lanapmode" or XQFunction.isMeshRe() then
        return "0"
    end
    
    return "1"
end

--- 获取服务器区域
--- @return string 服务器区域代码
function getServer()
    local uci = require("luci.model.uci").cursor()
    local broker = uci:get("miwifi", "server", "BROKER") or ""
    local region = string.sub(broker, 1, 2)
    return string.upper(region)
end

--- 检查是否支持Mesh
--- @return number 0或1
function isSupportMesh()
    local uci = require("luci.model.uci").cursor()
    local support = uci:get("misc", "features", "supportMesh") or ""
    
    if tostring(support) == "1" then
        return 1
    end
    return 0
end

--- 获取Mesh回程信息
--- @return string 回程频段
function getMeshBackhaul()
    local LuciUtil = require("luci.util")
    local backhaul = LuciUtil.exec("mesh_cmd backhaul get band") or ""
    return tostring(backhaul)
end

--- 获取杂项功能信息
--- @return table 功能信息表
function getMiscFeaturesInfo()
    local LuciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    
    local lanWanSwitch = uci:get("misc", "features", "lanWanSwitch") or ""
    local meshSuites = "0"
    
    if isSupportMesh() then
        meshSuites = LuciUtil.trim(LuciUtil.exec("mesh_cmd mesh_suites") or "")
    end
    
    local bandNum = uci:get("misc", "wireless", "wl_if_count") or ""
    local game = uci:get("misc", "features", "game") or ""
    
    local info = {}
    info.lanWanSwitch = tostring(lanWanSwitch)
    info.meshSuites = tostring(meshSuites)
    info.bandNum = tostring(bandNum)
    info.game = tostring(game)
    
    return info
end

--- 检查是否为Redmi设备
--- @return number 0或1
function isRedmi()
    local uci = require("luci.model.uci").cursor()
    local redmi = uci:get("misc", "features", "redmi") or ""
    
    if tostring(redmi) == "1" then
        return 1
    end
    return 0
end

--- 获取显示名称
--- @return string 显示名称
function getDisplayName()
    local uci = require("luci.model.uci").cursor()
    local displayName = uci:get("misc", "hardware", "displayName") or ""
    
    local subModel = XQFunction.bdataGet("subModel")
    if not XQFunction.isStrNil(subModel) then
        local subDisplayName = uci:get("misc", subModel, "displayName")
        if not XQFunction.isStrNil(subDisplayName) then
            return tostring(subDisplayName)
        end
    end
    
    return tostring(displayName)
end

--- 检查是否支持新拓扑
--- @return number 0或1
function isSupportNewTopo()
    local uci = require("luci.model.uci").cursor()
    local support = uci:get("misc", "features", "supportNewTopo") or ""
    
    if tostring(support) == "1" then
        return 1
    end
    return 0
end

--- 获取安全加速状态
--- @return number 总是返回1
function getSecAcc()
    return 1
end

--- 获取GDPR隐私设置
--- @return number 0或1
function getGdprPrivacy()
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local gdpr = XQFeatures.FEATURES.system.GdprPrivacy
    
    if gdpr == "1" then
        return 1
    else
        return 0
    end
end

--- 检查是否支持WiFi AP模式
--- @return number 0或1
function isWifiApSupport()
    local uci = require("luci.model.uci").cursor()
    local support = uci:get("misc", "features", "supportWifiAp") or ""
    
    if tostring(support) == "1" then
        return 1
    end
    return 0
end

--- 检查是否支持指定Mesh版本
--- @param version number 版本号
--- @return boolean 是否支持
function isSupportMeshVersion(version)
    local uci = require("luci.model.uci").cursor()
    local versionList = uci:get_all("mesh", "version")
    
    if versionList then
        for _, ver in pairs(versionList) do
            if tonumber(ver) == version then
                return true
            end
        end
    end
    return false
end

--- 检查是否支持Mesh MLO
--- @return boolean 是否支持
function isMeshMLOSupport()
    local LuciUtil = require("luci.util")
    local support = LuciUtil.exec_trim("mesh_cmd mlo_support", "0")
    
    if support ~= "1" then
        return false
    end
    return true
end

--- 检查是否支持Mesh MLO 2G
--- @return boolean 是否支持
function isMeshMLOSupport_2G()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local uci = require("luci.model.uci").cursor()
    
    if not XQSysUtil.isMeshMLOSupport() then
        return false
    end
    
    local bands = uci:get("mesh", "mlo", "bands") or ""
    if bands ~= "nil" then
        local bandList = string.split(bands, ",")
        for _, band in ipairs(bandList) do
            if band ~= nil and band == "2g" then
                return true
            end
        end
    end
    
    return false
end

--- 检查Mesh是否支持DFS
--- @return boolean 是否支持
function isMeshSupportDFS()
    local uci = require("luci.model.uci").cursor()
    local support = uci:get("misc", "mesh", "support_dfs") or ""
    
    if support == "1" then
        return true
    else
        return false
    end
end

--- 获取加密模式
--- @return number 0或1
function getEncryptMode()
    local uci = require("luci.model.uci").cursor()
    local legacy = uci:get("account", "legacy") or ""
    
    if legacy == "0" then
        return 0
    else
        return 1
    end
end

--- 获取IMEI
--- @return string IMEI
function getIMEI()
    local uci = require("luci.model.uci").cursor()
    local imei = uci:get("mobile", "device", "imei") or ""
    
    if imei == "" then
        local ubus = require("ubus")
        local conn = ubus.connect()
        local result = conn:call("mobile", "device", {method = "imei"})
        if result and result.code and result.code == 0 then
            imei = result.imei
        end
    end
    
    return imei
end

--- 获取IMEISV
--- @return string IMEISV
function getIMEISV()
    local uci = require("luci.model.uci").cursor()
    local imeisv = uci:get("mobile", "device", "imeisv") or ""
    
    if imeisv == "" then
        local ubus = require("ubus")
        local conn = ubus.connect()
        local result = conn:call("mobile", "device", {method = "imei"})
        if result and result.code and result.code == 0 then
            imeisv = result.sv
        end
    end
    
    return imeisv
end

--- 获取硬件版本
--- @return string 硬件版本
function getHwVersion()
    local LuciUtil = require("luci.util")
    local version = LuciUtil.exec(XQConfigs.XQ_ROM_HWVERSION)
    
    if XQFunction.isStrNil(version) then
        version = ""
    end
    return LuciUtil.trim(version)
end

--- 获取模块软件版本
--- @return string 软件版本
function getModuleSoftwareVersion()
    local uci = require("luci.model.uci").cursor()
    local version = uci:get("mobile", "device", "version") or ""
    return version
end

--- 获取WPS启用状态
--- @return number 0或1
function getWpsEnabled()
    local uci = require("luci.model.uci").cursor()
    local enabled = uci:get("wireless", "wps", "enable") or ""
    
    if tostring(enabled) == "1" then
        return 1
    end
    return 0
end

--- 获取NTP服务器列表
--- @return table NTP服务器列表
function getNTPServerList()
    local uci = require("luci.model.uci").cursor()
    return uci:get_list("system", "ntp", "server")
end

--- 设置NTP服务器
--- @param server1 string 服务器1
--- @param server2 string 服务器2
--- @return table 服务器列表
function setNTPServer(server1, server2)
    local uci = require("luci.model.uci").cursor()
    local currentList = uci:get_list("system", "ntp", "server")
    local newList = {}
    
    if not XQFunction.isStrNil(server1) then
        table.insert(newList, server1)
    end
    if not XQFunction.isStrNil(server2) then
        table.insert(newList, server2)
    end
    
    local needUpdate = false
    for _, server in ipairs(newList) do
        local found = false
        for _, current in ipairs(currentList) do
            if server == current then
                found = true
                break
            end
        end
        if not found then
            needUpdate = true
            break
        end
    end
    
    if needUpdate then
        uci:delete("system", "ntp", "server")
        uci:set_list("system", "ntp", "server", newList)
        uci:commit("system")
        uci:save("system")
    end
    
    return newList
end

--- 时间模式设置
--- @param sync string 是否同步
--- @param mode string 模式
--- @return table 结果表
function timeMode(sync, mode)
    local LuciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    
    local currentMode = uci:get("system", "ntp", "timemode")
    local result = {}
    
    if currentMode then
        result.mode = tonumber(currentMode) or 0
    else
        result.mode = 0
    end
    result.sync = 0
    
    if mode and currentMode ~= mode then
        uci:set("system", "ntp", "timemode", mode)
        result.mode = tonumber(mode)
        
        if mode == "0" then
            uci:set("system", "ntp", "enabled", 1)
            uci:commit("system")
            
            if sync == "1" then
                LuciUtil.exec("/usr/sbin/ntpsetclock now")
                result.sync = 1
            else
                XQFunction.forkExec("/usr/sbin/ntpsetclock now")
            end
        else
            uci:set("system", "ntp", "enabled", 0)
            uci:commit("system")
        end
    end
    
    return result
end

--- 获取系统时间
--- @return table 时间信息表
function getSysTime()
    local uci = require("luci.model.uci").cursor()
    local timeInfo = {
        timezone = "CST-8",
        index = "0",
        year = 0,
        month = 0,
        day = 0,
        hour = 0,
        min = 0,
        sec = 0
    }
    
    local currentTime = os.date("*t", os.time())
    timeInfo.year = currentTime.year
    timeInfo.month = currentTime.month
    timeInfo.day = currentTime.day
    timeInfo.hour = currentTime.hour
    timeInfo.min = currentTime.min
    timeInfo.sec = currentTime.sec
    
    uci:foreach("system", "system", function(s)
        if not XQFunction.isStrNil(s.webtimezone) then
            timeInfo.timezone = s.webtimezone
            timeInfo.index = s.timezoneindex or ""
        elseif not XQFunction.isStrNil(s.timezone) then
            timeInfo.timezone = s.timezone
            timeInfo.index = s.timezoneindex or ""
        end
    end)
    
    return timeInfo
end

--- 设置系统时间
--- @param datetime string 日期时间字符串 (YYYY-MM-DD HH:MM:SS)
--- @param timezone string 时区
--- @param timezoneIndex number 时区索引
function setSysTime(datetime, timezone, timezoneIndex)
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    
    local indexStr = tostring(timezoneIndex):gsub("%.", "_")
    local tz = uci:get("timezone", indexStr, "tz")
    
    if not XQFunction.isStrNil(tz) then
        local NixioFs = require("nixio.fs")
        
        uci:foreach("system", "system", function(s)
            if not XQFunction.isStrNil(s.timezone) then
                uci:set("system", s[".name"], "timezone", tz)
                uci:set("system", s[".name"], "webtimezone", tz)
                uci:set("system", s[".name"], "timezoneindex", timezoneIndex)
            end
        end)
        
        uci:set("system", "ntp", "enabled", "1")
        uci:commit("system")
        
        XQFunction.forkExec("/etc/init.d/timezone restart")
        
        local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
        local XQLog = require("xiaoqiang.XQLog")
        
        if XQFunction.isMeshCap() then
            local syncMsg = {
                cmd = "sync_time",
                timezone = tostring(tz),
                index = tostring(timezoneIndex or 0),
                tz_value = tostring(tz)
            }
            
            local json = require("luci.json")
            local msgJson = json.encode(syncMsg)
            XQLog.log(6, " CAP call RE sync timezone msg:" .. msgJson)
            
            XQFunction.forkExec("/sbin/whc_to_re_common_api.sh action '" .. msgJson .. "'")
            XQFunction.forkExec("/sbin/whc_to_re_common_api.sh whc_sync")
        end
    end
    
    if not XQFunction.isStrNil(datetime) then
        if datetime:match("^%d+%-%d+%-%d+ %d+:%d+:%d+$") then
            local XQFeatures = require("xiaoqiang.XQFeatures")
            local features = XQFeatures.FEATURES
            
            if features.system.dt_spec and features.system.dt_spec == "1" then
                local LuciUtil = require("luci.util")
                LuciUtil.exec("echo 'ok,xiaoqiang' > /tmp/ntp.status; date -s \"" .. datetime .. "\"")
            else
                XQFunction.forkExec("echo 'ok,xiaoqiang' > /tmp/ntp.status; sleep 3; date -s \"" .. datetime .. "\"")
            end
            
            uci:set("system", "ntp", "enabled", "0")
            uci:commit("system")
        end
    end
end

--- 写入登录记录
--- @param ip string IP地址
--- @param mac string MAC地址
function writeLoginRecord(ip, mac)
    local spLib = XQFunction.getFeature("1", "system", "sp_lib")
    if spLib ~= "1" then
        return
    end
    
    local XQStatPoints = require("xiaoqiang.XQStatPoints")
    local uci = require("luci.model.uci").cursor()
    
    local recordFile = "/data/usr/log/login_records"
    local maxRecords = uci:get("system", "@system[0]", "login_records_max") or 100
    local logFile = uci:get("system", "@system[0]", "login_records_file") or recordFile
    
    local dateStr = os.date("%Y/%m/%d %H:%M:%S")
    local date, time = dateStr:match("(%S+) (%S+)")
    
    local record = "date=" .. date .. ";time=" .. time .. ";ip=" .. ip .. ";mac=" .. mac
    XQStatPoints.LogToFile("sys.ctrl", record, logFile, maxRecords)
end

--- 读取登录记录
--- @return table 登录记录列表
function readLoginRecord()
    local uci = require("luci.model.uci").cursor()
    local records = {}
    
    local recordFile = "/data/usr/log/login_records"
    local maxRecords = uci:get("system", "@system[0]", "login_records_max") or 100
    local logFile = uci:get("system", "@system[0]", "login_records_file") or recordFile
    
    local cmd = "tail -n " .. maxRecords .. " " .. logFile
    local lines = luci.util.execi(cmd)
    
    for line in lines do
        if line:match("date=(%S+);time=(%S+);ip=(%S+);mac=(%S+)") then
            local date, time, ip, mac = line:match("date=(%S+);time=(%S+);ip=(%S+);mac=(%S+)")
            table.insert(records, {
                date = date,
                time = time,
                ip = ip,
                mac = mac
            })
        end
    end
    
    return records
end

--- 清除登录记录
function clearLoginRecord()
    local uci = require("luci.model.uci").cursor()
    local recordFile = "/data/usr/log/login_records"
    local logFile = uci:get("system", "@system[0]", "login_records_file") or recordFile
    
    local file = io.open(logFile, "w")
    file:close()
end

--- 获取时区列表
--- @return string JSON格式的时区列表
function getTimeZoneList()
    local uci = require("luci.model.uci").cursor()
    local json = require("json")
    local timezones = {}
    
    uci:foreach("timezone", "timezone", function(s)
        local item = {}
        item.index = s.index
        item.timezone = s.tz
        
        local name = s.z_name or ""
        if type(s.cities) == "table" then
            for _, city in ipairs(s.cities) do
                name = name .. translate(city) .. ", "
            end
            item.name = string.sub(name, 1, -3)
        else
            item.name = name
        end
        
        table.insert(timezones, item)
    end)
    
    table.sort(timezones, function(a, b)
        local utcA = a.name:match("%(UTC(%S+)%)")
        local utcB = b.name:match("%(UTC(%S+)%)")
        
        utcA = utcA:gsub(":", ".")
        utcB = utcB:gsub(":", ".")
        utcA = utcA:gsub("UTC", "")
        utcB = utcB:gsub("UTC", "")
        
        utcA = tonumber(utcA)
        utcB = tonumber(utcB)
        
        if utcA < utcB then
            return true
        else
            return false
        end
    end)
    
    return json.encode(timezones)
end
