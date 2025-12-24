--[[
    小米路由器 AP模式管理模块
    XQAPModule - 用于管理路由器的AP模式(接入点模式)配置
    
    主要功能:
    - 有线AP模式(LAN AP Mode)的启用和禁用
    - 无线AP模式(WiFi AP Mode)的启用和禁用
    - 网络配置的备份和恢复
    - 扩展WiFi连接管理
]]

-- 声明模块
module("xiaoqiang.module.XQAPModule", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")  -- 通用函数库
local XQConfigs = require("xiaoqiang.common.XQConfigs")    -- 配置常量
local LuciUtil = require("luci.util")                       -- LuCI工具库
local uci = require("luci.model.uci").cursor()              -- UCI配置接口

--[[
    快速设置有线AP模式
    用于快速AP模式功能，获取AP模式下的访问地址
    @return string 返回路由器的访问URL地址
]]
function QuickSetLanAPMode()
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    
    -- 移除消息类型4的通知
    XQMessageBox.removeMessage(4)
    
    -- 获取默认主机地址
    local XQVersion = require("xiaoqiang.XQVersion")
    local defaultHost = XQVersion.webDefaultHost
    local defaultUrl = "http://" .. defaultHost
    
    -- 获取别名IP地址
    local aliasIp = LuciUtil.trim(LuciUtil.exec("get_alias_ip 2>/dev/null"))
    
    -- 获取WAN口IPv4信息
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local wanInfo = XQLanWanUtil.getIpv4Info("wan")
    
    -- 判断返回哪个地址
    if not XQFunction.isStrNil(aliasIp) then
        if wanInfo then
            local gateway = wanInfo.gw
            if gateway == aliasIp then
                return defaultUrl
            end
        else
            return aliasIp
        end
    end
    
    return defaultUrl
end

--[[
    快速禁用有线AP模式
    获取禁用AP模式后的访问地址
    @return string 返回路由器的访问URL地址
]]
function QuickDisableLanAP()
    local XQVersion = require("xiaoqiang.XQVersion")
    local defaultHost = XQVersion.webDefaultHost
    local defaultUrl = "http://" .. defaultHost
    
    -- 获取备份的LAN IP地址
    local backupIp = uci:get("network", "lan", "ipaddr_back")
    
    if not XQFunction.isStrNil(backupIp) then
        return backupIp
    end
    
    return defaultUrl
end

--[[
    快速有线AP服务重启
    @param enable boolean 是否启用AP模式
    @param async boolean 是否异步执行
]]
function QuickLanApServiceRestart(enable, async)
    local enableCmd = [[
        /usr/sbin/set_apmode_quick.sh enable
    ]]
    local disableCmd = [[
        /usr/sbin/set_apmode_quick.sh disable
    ]]
    
    if async then
        -- 异步执行
        if enable then
            XQFunction.forkExec(enableCmd)
        else
            XQFunction.forkExec(disableCmd)
        end
    else
        -- 同步执行
        if enable then
            os.execute(enableCmd)
        else
            os.execute(disableCmd)
        end
    end
end

--[[
    设置有线AP模式
    将路由器切换到有线AP模式(中继模式)
    @return string|nil 返回新的LAN IP地址，如果IP未变化则返回nil
]]
function setLanAPMode()
    -- 检查是否支持快速AP模式
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    if features.system.QuickApMode and features.system.QuickApMode == "1" then
        return QuickSetLanAPMode()
    end
    
    -- 加载必要模块
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    
    -- 获取当前网络模式
    local netMode = XQFunction.getNetMode()
    
    -- 获取当前LAN IP
    local oldLanIp = XQLanWanUtil.getLanIp()
    
    -- 如果不是AP模式，备份当前LAN配置
    if netMode ~= "wifiapmode" and netMode ~= "lanapmode" then
        local cursor = require("luci.model.uci").cursor()
        local lanConfig = cursor:get_all("network", "lan")
        cursor:section("backup", "backup", "lan", lanConfig)
        cursor:commit("backup")
    end
    
    -- 执行有线AP模式连接脚本
    os.execute("/usr/sbin/lanap_mode.sh connect >/dev/null 2>/dev/null")
    
    -- 获取新的LAN IP
    local newLanIp = XQLanWanUtil.getLanIp()
    
    -- 如果IP发生变化，进行相关配置
    if oldLanIp ~= newLanIp then
        local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
        
        -- 移除消息通知
        XQMessageBox.removeMessage(4)
        
        -- 禁用MAC过滤
        XQWifiUtil.setWiFiMacfilterModel(false)
        
        -- 关闭访客WiFi
        XQWifiUtil.closeGuestWifi(1)
        XQWifiUtil.closeGuestWifi(2)
        
        -- 设置网络模式为有线AP模式
        XQFunction.setNetMode("lanapmode")
        
        -- 如果之前是WHC CAP模式，设置CAP模式为AP
        if netMode == "whc_cap" then
            XQFunction.setCAPMode("ap")
        end
        
        -- 同步AP的LAN IP
        XQSynchrodata.syncApLanIp(newLanIp)
        
        return newLanIp
    end
    
    return nil
end

--[[
    强制设置有线AP模式
    无论当前状态如何，强制切换到有线AP模式
    @return string|nil 返回新的LAN IP地址
]]
function setLanAPModeForce()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    local cursor = require("luci.model.uci").cursor()
    
    -- 获取当前网络模式和LAN IP
    local netMode = XQFunction.getNetMode()
    local oldLanIp = XQLanWanUtil.getLanIp()
    
    -- 备份当前网络配置
    os.execute("cp /etc/config/network /etc/config/.network.mode.router")
    
    -- 如果不是AP模式，备份LAN配置
    if netMode ~= "wifiapmode" and netMode ~= "lanapmode" then
        local lanConfig = cursor:get_all("network", "lan")
        cursor:section("backup", "backup", "lan", lanConfig)
        cursor:commit("backup")
    end
    
    -- 执行有线AP模式连接脚本
    os.execute("/usr/sbin/lanap_mode.sh connect >/dev/null 2>/dev/null")
    
    -- 获取新的LAN IP
    local newLanIp = XQLanWanUtil.getLanIp()
    
    -- 移除消息通知
    XQMessageBox.removeMessage(4)
    
    -- 禁用MAC过滤
    XQWifiUtil.setWiFiMacfilterModel(false)
    
    -- 设置网络模式为有线AP模式
    XQFunction.setNetMode("lanapmode")
    
    -- 如果IP发生变化，同步配置
    if oldLanIp ~= newLanIp then
        local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
        XQSynchrodata.syncApLanIp(newLanIp)
        return newLanIp
    else
        -- IP未变化，设置LAN为DHCP模式
        cursor:set("network", "lan", "proto", "dhcp")
        cursor:commit("network")
    end
    
    return nil
end

--[[
    禁用有线AP模式
    将路由器从AP模式恢复到普通路由器模式
    @return string|nil 返回恢复后的LAN IP地址
]]
function disableLanAP()
    -- 检查是否支持快速AP模式
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    if features.system.QuickApMode and features.system.QuickApMode == "1" then
        return QuickDisableLanAP()
    end
    
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local cursor = require("luci.model.uci").cursor()
    
    -- 获取备份的LAN IP地址
    local backupLanIp = cursor:get("backup", "lan", "ipaddr")
    
    -- 获取CAP模式状态
    local capMode = XQFunction.getCAPMode()
    
    -- 恢复网络模式
    if capMode == 1 then
        XQFunction.setNetMode("whc_cap")
        XQFunction.setCAPMode("router")
    else
        XQFunction.setNetMode(nil)
    end
    
    -- 从备份恢复LAN配置
    local backupLanConfig = cursor:get_all("backup", "lan")
    cursor:delete("network", "lan")
    cursor:section("network", "interface", "lan", backupLanConfig)
    
    -- 启用VPN
    cursor:set("network", "vpn", "disabled", "0")
    os.execute(XQConfigs.SET_VPN_USER_OPTION .. "1")
    cursor:commit("network")
    
    -- 禁用MAC过滤
    XQWifiUtil.setWiFiMacfilterModel(false)
    
    return backupLanIp
end

--[[
    有线AP服务重启
    @param enable boolean 是否启用AP模式
    @param async boolean 是否异步执行
    @param delay boolean 是否延迟执行
]]
function lanApServiceRestart(enable, async, delay)
    -- 检查是否支持快速AP模式
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    if features.system.QuickApMode and features.system.QuickApMode == "1" then
        return QuickLanApServiceRestart(enable, async)
    end
    
    -- 定义命令
    local shareUpdateCmd = " /usr/sbin/shareUpdate -b >/dev/null 2>/dev/null; "
    local openCmd = " /usr/sbin/lanap_mode.sh open; "
    local closeCmd = " /usr/sbin/lanap_mode.sh close; "
    local sleepCmd = " sleep 7; "
    
    -- 参数检查
    if enable == nil or async == nil or delay == nil then
        return
    end
    
    -- 构建执行命令
    local cmd
    if delay then
        if enable then
            cmd = sleepCmd .. openCmd .. shareUpdateCmd
        else
            cmd = sleepCmd .. closeCmd .. shareUpdateCmd
        end
    else
        if enable then
            cmd = openCmd .. shareUpdateCmd
        else
            cmd = closeCmd .. shareUpdateCmd
        end
    end
    
    -- 执行命令
    if async then
        XQFunction.forkExec(cmd)
    else
        os.execute(cmd)
    end
end

--[[
    备份配置
    备份当前的网络、DHCP和WiFi配置，用于AP模式切换时恢复
]]
function backupConfigs()
    local cursor = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 获取国家代码
    local countryCode = XQFunction.bdataGet("CountryCode", "CN")
    
    -- 获取当前DHCP配置
    local dhcpLanConfig = cursor:get_all("dhcp", "lan")
    local dhcpWanConfig = cursor:get_all("dhcp", "wan")
    
    -- 删除旧的备份
    cursor:delete("backup", "lan")
    cursor:delete("backup", "wifi1")
    cursor:delete("backup", "wifi2")
    cursor:delete("backup", "dhcplan")
    cursor:delete("backup", "dhcpwan")
    
    -- 中国区域删除VPN备份
    if countryCode == "CN" then
        cursor:delete("backup", "vpn")
    end
    
    -- 备份DHCP配置
    cursor:section("backup", "backup", "dhcplan", dhcpLanConfig)
    cursor:section("backup", "backup", "dhcpwan", dhcpWanConfig)
    
    -- 备份网络LAN配置
    local networkLanConfig = cursor:get_all("network", "lan")
    cursor:delete("backup", "networklan")
    cursor:section("backup", "backup", "networklan", networkLanConfig)
    cursor:commit("backup")
    
    -- 备份WiFi信息
    local initInfo = XQSysUtil.getInitInfo()
    if initInfo then
        XQWifiUtil.backupWifiInfo(1)
        XQWifiUtil.backupWifiInfo(2)
    end
end

--[[
    恢复配置
    从备份中恢复网络和DHCP配置
]]
function recoveryConfigs()
    local cursor = require("luci.model.uci").cursor()
    
    -- 获取备份的DHCP配置
    local dhcpLanBackup = cursor:get_all("backup", "dhcplan")
    local dhcpWanBackup = cursor:get_all("backup", "dhcpwan")
    
    -- 恢复DHCP LAN配置
    if dhcpLanBackup then
        cursor:section("dhcp", "dhcp", "lan", dhcpLanBackup)
    end
    
    -- 恢复DHCP WAN配置
    if dhcpWanBackup then
        cursor:section("dhcp", "dhcp", "wan", dhcpWanBackup)
    end
    
    -- 恢复网络LAN配置
    local networkLanBackup = cursor:get_all("backup", "networklan")
    cursor:delete("network", "lan")
    cursor:section("network", "interface", "lan", networkLanBackup)
    
    -- 提交配置
    cursor:commit("dhcp")
    cursor:commit("network")
end

--[[
    设置WAN自动连接
    @param auto boolean|nil 是否自动连接
]]
function setWanAuto(auto)
    local network = require("luci.model.network").init()
    
    -- 获取WAN和WAN6网络接口
    local wan = network:get_network("wan")
    local wan6 = network:get_network("wan6")
    
    -- 设置自动连接属性
    if wan then
        wan:set("auto", auto)
    end
    
    if wan6 then
        wan6:set("auto", auto)
    end
    
    -- 提交配置
    network:commit("network")
end

--[[
    禁用无线AP模式
    将路由器从无线AP模式恢复到普通路由器模式
    @param immediate boolean 是否立即执行
    @return string, string 返回LAN IP地址和WiFi SSID
]]
function disableWifiAPMode(immediate)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local lanIp, wifiSsid = nil, nil
    
    -- 恢复配置
    recoveryConfigs()
    
    -- 获取LAN IP地址
    lanIp = uci:get("network", "lan", "ipaddr")
    
    -- 获取WiFi SSID
    wifiSsid = XQWifiUtil.getWifissid()
    
    -- 启用VPN
    uci:set("network", "vpn", "disabled", "0")
    os.execute(XQConfigs.SET_VPN_USER_OPTION .. "1")
    uci:commit("network")
    
    -- 设置WAN自动连接
    setWanAuto(nil)
    
    -- 启用回程AP
    XQWifiUtil.bh_ap_enable()
    
    -- 禁用AP客户端
    XQWifiUtil.apcli_disable(immediate)
    
    -- 清除网络模式
    XQFunction.setNetMode(nil)
    
    -- 清除活动AP客户端
    XQWifiUtil.apcli_set_active(nil)
    
    -- 禁用MAC过滤
    XQWifiUtil.setWiFiMacfilterModel(false)
    
    -- 执行禁用WiFi AP的后续操作
    actionForDisableWifiAP()
    
    return lanIp, wifiSsid
end

--[[
    启用WiFi AP模式的后续操作
    @param immediate boolean 是否立即执行
]]
function actionForEnableWifiAP(immediate)
    local cmd
    if immediate then
        cmd = [[
		wifiap_mode.sh open;
        ]]
    else
        cmd = [[
            sleep 10;
			wifiap_mode.sh open;
        ]]
    end
    
    XQFunction.forkExec(cmd)
end

--[[
    禁用WiFi AP模式的后续操作
]]
function actionForDisableWifiAP()
    local cmd = [[
    sleep 3;
	wifiap_mode.sh close;
    ]]
    
    XQFunction.forkExec(cmd)
end

--[[
    解析命令行参数
    对字符串进行转义处理，用于安全执行shell命令
    @param str string 输入字符串
    @return string 转义后的字符串
]]
function parseCmdline(str)
    if XQFunction.isStrNil(str) then
        return ""
    end
    
    -- 转义特殊字符
    local result = str
    result = result:gsub("\\", "\\\\")   -- 转义反斜杠
    result = result:gsub("`", "\\`")     -- 转义反引号
    result = result:gsub("\"", "\\\"")   -- 转义双引号
    result = result:gsub("%$", "\\$")    -- 转义美元符号
    
    return result
end

--[[
    设置无线AP模式
    将路由器配置为无线中继/AP模式，连接到上级路由器
    
    @param ssid string 上级WiFi的SSID
    @param password string 上级WiFi的密码
    @param enctype string 加密类型
    @param encryption string 加密方式
    @param band string 频段(2g/5g)
    @param channel number 信道
    @param bandwidth string 带宽
    @param newSsid string 新的2.4G WiFi SSID
    @param newEncryption string 新的加密方式
    @param newPassword string 新的WiFi密码
    @param newSsid5G string 新的5G WiFi SSID
    @param newSsid6G string 新的6G WiFi SSID (如果支持)
    @return table 返回连接结果信息
]]
function setWifiAPMode(ssid, password, enctype, encryption, band, channel, bandwidth, newSsid, newEncryption, newPassword, newSsid5G, newSsid6G)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 构建AP客户端配置
    local apcliConfig = {
        ifname = "",
        ssid = ssid,
        cmdssid = ssid,
        password = password,
        cmdpassword = password,
        encryption = encryption,
        enctype = enctype,
        band = band,
        channel = channel,
        bw = bandwidth,
        reconnect = nil
    }
    
    -- 返回结果结构
    local result = {
        connected = false,
        conerrmsg = "",
        scan = true,
        ip = ""
    }
    
    -- 获取当前网络模式
    local netMode = XQFunction.getNetMode()
    
    if apcliConfig.ssid then
        apcliConfig.cmdssid = apcliConfig.ssid
        apcliConfig.cmdpassword = apcliConfig.password
        
        -- 检查AP客户端配置项
        local needScan = XQWifiUtil.apcli_check_apcliitem(apcliConfig)
        
        if needScan then
            -- 扫描WiFi列表
            local scanList = XQWifiUtil.apcli_get_scanlist(apcliConfig)
            local targetAp = nil
            
            -- 查找目标AP
            for _, ap in ipairs(scanList or {}) do
                if ap and ap.ssid == ssid then
                    targetAp = ap
                    break
                end
            end
            
            -- 未找到目标AP
            if not targetAp then
                result.scan = false
                return result
            end
            
            -- 从扫描结果更新配置
            apcliConfig.enctype = targetAp.enctype
            apcliConfig.channel = targetAp.channel
            apcliConfig.encryption = targetAp.encryption
            apcliConfig.band = targetAp.band
            apcliConfig.ifname = targetAp.ifname
        end
        
        -- 如果接口名为空，根据频段获取
        if XQFunction.isStrNil(apcliConfig.ifname) then
            apcliConfig.ifname = XQWifiUtil.apcli_get_ifname_form_band(apcliConfig.band)
        end
        
        -- 获取所有AP客户端接口
        local ifnames = XQWifiUtil.apcli_get_ifnames()
        
        -- 禁用其他接口
        for _, ifname in ipairs(ifnames or {}) do
            if ifname ~= apcliConfig.ifname then
                local wifinet = XQWifiUtil.apcli_get_wifinet(ifname)
                if wifinet then
                    XQWifiUtil.apcli_set_inactive(ifname)
                end
            end
        end
        
        -- 设置连接
        XQWifiUtil.apcli_set_connect(apcliConfig)
        
        -- 等待连接建立
        local connected = false
        for i = 1, 10 do
            connected = XQWifiUtil.apcli_get_connect(apcliConfig.ifname)
            if connected then
                break
            end
            os.execute("sleep 3")
        end
        
        result.connected = connected
    end
    
    -- 连接成功后的配置
    if result.connected then
        local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
        
        -- 如果不是AP模式，备份配置
        if netMode ~= "wifiapmode" and netMode ~= "lanapmode" then
            backupConfigs()
        end
        
        -- 设置WAN自动连接
        setWanAuto(false)
        
        -- 获取DHCP IP地址
        local dhcpResult = XQLanWanUtil.getDhcpLanIp(apcliConfig.ifname)
        
        -- DHCP失败时重试
        if dhcpResult ~= 0 then
            os.execute("sleep 2;dhcp_apclient.sh start br-lan")
            dhcpResult = XQLanWanUtil.getDhcpLanIp(apcliConfig.ifname)
        end
        
        -- DHCP成功
        if dhcpResult and dhcpResult == 0 then
            local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
            local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
            
            -- 移除消息通知
            XQMessageBox.removeMessage(4)
            
            -- 设置网络模式为无线AP模式
            XQFunction.setNetMode("wifiapmode")
            
            -- 同步AP的LAN IP
            local newLanIp = XQLanWanUtil.getLanIp()
            XQSynchrodata.syncApLanIp(newLanIp)
            result.ip = newLanIp
            
            -- 删除DHCP配置
            local cursor = require("luci.model.uci").cursor()
            cursor:delete("dhcp", "lan")
            cursor:delete("dhcp", "wan")
            cursor:commit("dhcp")
            
            -- 处理5G SSID
            if newSsid5G == nil or #newSsid5G == 0 then
                newSsid5G = newSsid
            end
            
            -- 处理6G SSID (如果支持3频)
            local wlanCount = XQWifiUtil.get_wlan_count()
            if wlanCount > 2 then
                if newSsid6G == nil or #newSsid6G == 0 then
                    newSsid6G = newSsid
                end
            end
            
            -- 设置WiFi基本信息
            XQWifiUtil.setWifiBasicInfo(1, newSsid, newPassword, newEncryption)
            XQWifiUtil.setWifiBasicInfo(2, newSsid5G, newPassword, newEncryption, nil, nil, nil, nil, "0")
            
            -- 设置第三频段(如果存在)
            if wlanCount > 2 then
                XQWifiUtil.setWifiBasicInfo(3, newSsid6G, newPassword, newEncryption, nil, nil, nil, nil, "0")
            end
            
            -- 禁用MLO热点(如果有新SSID)
            if newSsid then
                XQWifiUtil.mlo_hostap_disable()
            end
            
            -- 禁用回程AP
            XQWifiUtil.bh_ap_disable()
            
            -- 禁用MiWiFi Mesh
            XQWifiUtil.miwifi_mesh_disable()
            
            -- 启用AP客户端
            XQWifiUtil.apcli_enable(apcliConfig)
            
            -- 禁用MAC过滤
            XQWifiUtil.setWiFiMacfilterModel(false)
            
            -- 关闭访客WiFi
            XQWifiUtil.closeGuestWifi(1)
            XQWifiUtil.closeGuestWifi(2)
        else
            -- DHCP失败，回滚配置
            XQWifiUtil.apcli_set_inactive(apcliConfig.ifname)
            recoveryConfigs()
        end
    end
    
    -- 连接失败处理
    if not result.connected or result.ip == "" then
        -- 如果没有重连标记，尝试恢复旧配置
        if apcliConfig.reconnect == nil then
            local ifnames = XQWifiUtil.apcli_get_ifnames()
            
            -- 禁用所有AP客户端接口
            for _, ifname in ipairs(ifnames or {}) do
                XQWifiUtil.apcli_set_inactive(ifname)
            end
            
            -- 如果之前有AP模式配置，尝试恢复
            if netMode then
                local oldConfig = XQWifiUtil.apcli_get_config()
                if oldConfig then
                    oldConfig.reconnect = true
                    XQWifiUtil.apcli_set_connect(oldConfig)
                end
            end
        end
        
        result.conerrmsg = "Connect faild!"
    else
        -- 连接成功，如果是5G频段，启用雷达检测
        if apcliConfig.band and apcliConfig.band:match("5g") then
            os.execute("radartool -i wifi1 enable")
        end
    end
    
    return result
end

--[[
    APP设置无线AP模式
    简化版的无线AP模式设置，用于APP调用
    
    @param ssid string 上级WiFi的SSID
    @param password string 上级WiFi的密码
    @param enctype string 加密类型
    @param encryption string 加密方式
    @param band string 频段
    @param channel number 信道
    @param bandwidth string 带宽
    @param newSsid string 新的WiFi SSID
    @param newEncryption string 新的加密方式
    @param newPassword string 新的WiFi密码
    @param newSsid5G string 新的5G WiFi SSID
    @return table 返回连接结果信息
]]
function appSetWifiAPMode(ssid, password, enctype, encryption, band, channel, bandwidth, newSsid, newEncryption, newPassword, newSsid5G)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 构建AP客户端配置
    local apcliConfig = {
        ifname = "",
        ssid = ssid,
        cmdssid = ssid,
        password = password,
        cmdpassword = password,
        encryption = encryption,
        enctype = enctype,
        band = band,
        channel = channel,
        bw = bandwidth
    }
    
    -- 返回结果结构
    local result = {
        connected = false,
        conerrmsg = "",
        scan = true
    }
    
    -- 获取当前网络模式
    local isApMode = XQFunction.getNetMode() ~= nil
    
    if apcliConfig.ssid then
        apcliConfig.cmdssid = apcliConfig.ssid
        apcliConfig.cmdpassword = apcliConfig.password
        
        -- 检查是否需要扫描
        local needScan = XQWifiUtil.apcli_check_apcliitem(apcliConfig)
        
        if needScan then
            -- 扫描WiFi列表
            local scanList = XQWifiUtil.apcli_get_scanlist(apcliConfig)
            local targetAp = nil
            
            -- 查找目标AP
            for _, ap in ipairs(scanList or {}) do
                if ap and ap.ssid == ssid then
                    targetAp = ap
                    break
                end
            end
            
            -- 未找到目标AP
            if not targetAp then
                result.scan = false
                return result
            end
            
            -- 从扫描结果更新配置
            apcliConfig.enctype = targetAp.enctype
            apcliConfig.channel = targetAp.channel
            apcliConfig.encryption = targetAp.encryption
            apcliConfig.band = targetAp.band
            apcliConfig.ifname = targetAp.ifname
        end
        
        -- 如果接口名为空，根据频段获取
        if XQFunction.isStrNil(apcliConfig.ifname) then
            apcliConfig.ifname = XQWifiUtil.apcli_get_ifname_form_band(apcliConfig.band)
        end
        
        -- 获取所有AP客户端接口并禁用其他接口
        local ifnames = XQWifiUtil.apcli_get_ifnames()
        for _, ifname in ipairs(ifnames or {}) do
            if ifname ~= apcliConfig.ifname then
                XQWifiUtil.apcli_set_inactive(ifname)
            end
        end
        
        -- 设置连接
        XQWifiUtil.apcli_set_connect(apcliConfig)
        
        -- 等待连接建立
        local connected = false
        for i = 1, 10 do
            connected = XQWifiUtil.apcli_get_connect(apcliConfig.ifname)
            if connected then
                break
            end
            os.execute("sleep 2")
        end
        
        result.connected = connected
    end
    
    -- 连接成功后备份旧的LAN IP
    if result.connected then
        local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
        
        if not isApMode then
            backupConfigs()
        end
        
        result.oldlan = XQLanWanUtil.getLanIp()
    end
    
    -- 获取UCI配置并复制到结果
    local cursor = require("luci.model.uci").cursor()
    for key, value in pairs(apcliConfig) do
        result[key] = value
    end
    
    return result
end

--[[
    设置无线AP模式配置
    从临时文件读取配置并应用无线AP模式设置
]]
function setWifiAPModeConfig()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 获取当前网络模式
    local isApMode = XQFunction.getNetMode() ~= nil
    
    -- 读取配置文件
    local file = io.open("/tmp/luci_set_wifi_ap_mode_result", "r")
    
    if file ~= nil then
        local content = file:read("*a")
        local json = require("json")
        local config = json.decode(content)
        file:close()
        
        -- 检查配置是否有效
        if config.code and config.code == 0 then
            local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
            
            -- 设置WAN自动连接
            setWanAuto(false)
            
            -- 如果有IP地址，进行网络配置
            if config.ipaddr ~= nil then
                local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
                local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
                
                -- 移除消息通知
                XQMessageBox.removeMessage(4)
                
                -- 设置网络模式
                XQFunction.setNetMode("wifiapmode")
                
                -- 同步AP的LAN IP
                XQSynchrodata.syncApLanIp(config.ipaddr)
                
                -- 获取UCI配置
                local cursor = require("luci.model.uci").cursor()
                
                -- 设置小米配置
                cursor:set("xiaoqiang", "common", "ap_hostname", config.hostname)
                cursor:set("xiaoqiang", "common", "vendorinfo", config.vendorinfo)
                cursor:commit("xiaoqiang")
                
                -- 删除LAN DNS配置
                cursor:delete("network", "lan", "dns")
                
                -- 获取国家代码
                local countryCode = XQFunction.bdataGet("CountryCode", "CN")
                
                -- 中国区域删除VPN配置
                if countryCode == "CN" then
                    cursor:delete("network", "vpn")
                end
                
                -- 设置LAN网络配置
                cursor:set("network", "lan", "proto", "static")
                cursor:set("network", "lan", "type", "bridge")
                cursor:set("network", "lan", "ipaddr", config.ipaddr)
                cursor:set("network", "lan", "netmask", config.netmask)
                cursor:set("network", "lan", "gateway", config.gateway)
                cursor:set("network", "lan", "mtu", config.mtu)
                cursor:set("network", "lan", "dns", config.dns1)
                cursor:commit("network")
                
                -- 删除DHCP配置
                cursor:delete("dhcp", "lan")
                cursor:delete("dhcp", "wan")
                cursor:commit("dhcp")
                
                -- 处理新的WiFi配置
                local newSsid, newSsid5G, newPassword, newEncryption = nil, nil, nil, nil
                
                -- 检查是否有新的SSID配置
                if not XQFunction.isStrNil(config.nssid) then
                    if config.nencryption then
                        if config.npassword or config.nencryption == "none" then
                            newSsid = config.nssid
                            newSsid5G = config.nssid
                            newPassword = config.npassword
                            newEncryption = config.nencryption
                        end
                    end
                end
                
                -- 检查5G SSID
                if not XQFunction.isStrNil(config.nssid5G) then
                    newSsid5G = config.nssid5G
                end
                
                -- 根据频段设置WiFi
                if not XQFunction.isStrNil(config.band) then
                    if config.band:match("2g") then
                        -- 2.4G频段使用最大带宽
                        XQWifiUtil.setWifiBasicInfo(1, newSsid, newPassword, newEncryption, nil, "max")
                        XQWifiUtil.setWifiBasicInfo(2, newSsid5G, newPassword, newEncryption)
                    else
                        -- 5G频段使用最大带宽
                        XQWifiUtil.setWifiBasicInfo(1, newSsid, newPassword, newEncryption)
                        XQWifiUtil.setWifiBasicInfo(2, newSsid5G, newPassword, newEncryption, nil, "max")
                    end
                else
                    XQWifiUtil.setWifiBasicInfo(1, newSsid, newPassword, newEncryption)
                    XQWifiUtil.setWifiBasicInfo(2, newSsid5G, newPassword, newEncryption)
                end
                
                -- 启用AP客户端
                XQWifiUtil.apcli_enable(config)
                
                -- 禁用MAC过滤
                XQWifiUtil.setWiFiMacfilterModel(false)
                
                -- 关闭访客WiFi
                XQWifiUtil.closeGuestWifi(1)
                XQWifiUtil.closeGuestWifi(2)
                
                -- 更新配置中的SSID信息
                if XQFunction.isStrNil(newSsid) then
                    local wifiInfo = XQWifiUtil.getWifiBasicInfo(1)
                    if wifiInfo ~= nil then
                        config.ssid = wifiInfo.ssid
                    end
                else
                    config.ssid = newSsid
                end
                
                if XQFunction.isStrNil(newSsid5G) then
                    local wifiInfo5G = XQWifiUtil.getWifiBasicInfo(2)
                    if wifiInfo5G ~= nil then
                        config.ssid5G = wifiInfo5G.ssid
                    end
                else
                    config.ssid5G = newSsid5G
                end
            end
        end
        
        -- 连接失败处理
        if config.code ~= 0 or config.ipaddr == nil then
            -- 禁用所有AP客户端接口
            local ifnames = XQWifiUtil.apcli_get_ifnames()
            for _, ifname in ipairs(ifnames or {}) do
                XQWifiUtil.apcli_set_inactive(ifname)
            end
            
            -- 如果之前是AP模式，尝试恢复旧配置
            if isApMode then
                local oldConfig = XQWifiUtil.apcli_get_config()
                if oldConfig then
                    XQWifiUtil.apcli_set_connect(oldConfig)
                end
            end
            
            config.conerrmsg = "Connect faild!"
        end
    end
end

--[[
    扩展WiFi断开连接
    断开指定频段的扩展WiFi连接
    @param band string 频段(2g/5g)，默认为2g
]]
function extednwifi_disconnect(band)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 默认使用2.4G频段
    if XQFunction.isStrNil(band) then
        band = "2g"
    end
    
    -- 获取接口名称
    local ifname = XQWifiUtil.apcli_get_ifname_form_band(band)
    
    -- 设置接口为非活动状态
    XQWifiUtil.apcli_set_inactive(ifname)
end

--[[
    扩展WiFi设置连接
    连接到指定的上级WiFi网络
    
    @param ssid string 上级WiFi的SSID
    @param password string 上级WiFi的密码
    @param enctype string 加密类型
    @param encryption string 加密方式
    @param band string 频段
    @param channel number 信道
    @return table 返回连接结果信息
]]
function extendwifi_set_connect(ssid, password, enctype, encryption, band, channel)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 构建AP客户端配置
    local apcliConfig = {
        ifname = "",
        ssid = ssid,
        cmdssid = ssid,
        password = password,
        cmdpassword = password,
        encryption = encryption,
        enctype = enctype,
        band = band,
        channel = channel
    }
    
    -- 返回结果结构
    local result = {
        connected = false,
        dhcpcode = -1,
        ip = ""
    }
    
    -- 获取当前网络模式
    local isApMode = XQFunction.getNetMode() ~= nil
    
    if apcliConfig.ssid then
        apcliConfig.cmdssid = apcliConfig.ssid
        apcliConfig.cmdpassword = apcliConfig.password
        
        -- 检查是否需要扫描
        local needScan = XQWifiUtil.apcli_check_apcliitem(apcliConfig)
        
        if needScan then
            -- 扫描WiFi列表
            local scanList = XQWifiUtil.apcli_get_scanlist(apcliConfig)
            local targetAp = nil
            
            -- 查找目标AP
            for _, ap in ipairs(scanList or {}) do
                if ap and ap.ssid == ssid then
                    targetAp = ap
                    break
                end
            end
            
            -- 未找到目标AP
            if not targetAp then
                return result
            end
            
            -- 从扫描结果更新配置
            apcliConfig.enctype = targetAp.enctype
            apcliConfig.channel = targetAp.channel
            apcliConfig.encryption = targetAp.encryption
            apcliConfig.band = targetAp.band
            apcliConfig.ifname = targetAp.ifname
        end
        
        -- 如果接口名为空，根据频段获取
        if XQFunction.isStrNil(apcliConfig.ifname) then
            apcliConfig.ifname = XQWifiUtil.apcli_get_ifname_form_band(apcliConfig.band)
        end
        
        -- 多次尝试连接
        for retry = 1, 3 do
            -- 设置连接
            XQWifiUtil.apcli_set_connect(apcliConfig)
            
            -- 等待连接建立
            local connected = false
            for i = 1, 10 do
                connected = XQWifiUtil.apcli_get_connect(apcliConfig.ifname)
                if connected then
                    break
                end
                os.execute("sleep 2")
            end
            
            result.connected = connected
            
            if connected then
                break
            end
        end
    end
    
    -- 连接成功后获取DHCP IP
    if result.connected then
        local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
        local dhcpResult, newIp = XQLanWanUtil.getDhcpLanIp(apcliConfig.ifname)
        
        result.dhcpcode = dhcpResult
        if dhcpResult == 0 then
            result.ip = newIp
        end
    end
    
    -- 连接失败或IP为空时的处理
    if not result.connected or result.ip == "" then
        -- 禁用AP客户端接口
        XQWifiUtil.apcli_set_inactive(apcliConfig.ifname)
        
        -- 如果之前是AP模式，尝试恢复旧配置
        if isApMode then
            local oldConfig = XQWifiUtil.apcli_get_config()
            if oldConfig then
                if oldConfig.encryption ~= "0" then
                    XQWifiUtil.apcli_set_connect(oldConfig)
                end
            end
        end
    end
    
    return result
end
