--[[
    小米路由器 VPN 工具模块
    提供 VPN 连接的配置和管理功能
    
    主要功能:
    - VPN 配置的添加、编辑、删除
    - VPN 连接的开启和关闭
    - VPN 状态查询
    - 智能 VPN 配置
    - VPN 代理列表管理
]]

module("xiaoqiang.util.XQVPNUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local uci = require("luci.model.uci").cursor()

local PROXY_FILE = "/etc/smartvpn/proxy.txt"

--[[
    设置 VPN 配置
    
    @param name VPN 名称
    @param server VPN 服务器地址
    @param username 用户名
    @param password 密码
    @param proto 协议类型（PPTP/L2TP）
    @param vpn_id VPN ID
    @param auto 是否自动连接
    @param auth 认证方式
    @return 成功返回 true，参数无效返回 false
]]
function setVpn(name, server, username, password, proto, vpn_id, auto, auth)
    if XQFunction.isStrNil(name) or XQFunction.isStrNil(server) or
       XQFunction.isStrNil(username) or XQFunction.isStrNil(password) or
       XQFunction.isStrNil(proto) or XQFunction.isStrNil(auto) then
        return false
    end
    
    if XQFunction.isStrNil(vpn_id) then
        local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
        vpn_id = XQCryptoUtil.md5Str(server .. username .. proto)
    end
    
    if XQFunction.isStrNil(auth) then
        auth = "auto"
    end
    
    local trafficall = "yes"
    local smartvpn_switch = uci:get("smartvpn", "vpn", "switch")
    if smartvpn_switch and smartvpn_switch == "1" then
        trafficall = "no"
    end
    
    local vpn_config = {
        proto = string.lower(proto),
        server = server,
        username = username,
        password = password,
        auth = auth,
        id = vpn_id,
        auto = auto,
        trafficall = trafficall,
        checkup_interval = (auto == "1") and "5" or ""
    }
    
    if vpn_config then
        uci:delete("network", name)
        uci:delete("network", name .. "6")
        uci:section("network", "interface", name, vpn_config)
        uci:commit("network")
        
        local firewall = require("luci.model.firewall").init()
        local wan_zone = firewall:get_zone("wan")
        wan_zone:add_network(name)
        firewall:save("firewall")
        firewall:commit("firewall")
        
        return true
    end
    
    return false
end

--[[
    删除网络 VPN 配置（内部函数）
    
    @param vpn_id VPN ID
]]
function _delNetworkVpn(vpn_id)
    local current_id = uci:get("network", "vpn", "id") or ""
    
    if current_id == vpn_id then
        uci:delete("network", "vpn6")
        uci:delete("network", "vpn")
        uci:commit("network")
    end
end

--[[
    编辑网络 VPN 配置（内部函数）
    
    @param server 服务器地址
    @param username 用户名
    @param password 密码
    @param proto 协议类型
    @param vpn_id VPN ID
    @param auth 认证方式
]]
function _editNetworkVpn(server, username, password, proto, vpn_id, auth)
    local current_id = uci:get("network", "vpn", "id") or ""
    
    if current_id == vpn_id then
        local section = "vpn"
        local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
        local new_id = XQCryptoUtil.md5Str(server .. username .. proto)
        
        uci:set("network", section, "proto", string.lower(proto))
        uci:set("network", section, "server", server)
        uci:set("network", section, "username", username)
        uci:set("network", section, "password", password)
        uci:set("network", section, "id", new_id)
        uci:set("network", section, "auth", auth)
        uci:commit("network")
    end
end

--[[
    设置 VPN 自动连接
    
    @param auto 0 表示禁用，1 表示启用
    @return 成功返回 true
]]
function setVpnAuto(auto)
    auto = tonumber(auto)
    local section = "vpn"
    local auto_str = (auto and auto == 0) and "0" or "1"
    
    if auto_str == "1" then
        uci:set("network", section, "checkup_interval", "5")
    else
        uci:delete("network", section, "checkup_interval")
    end
    
    uci:set("network", section, "auto", auto_str)
    uci:commit("network")
    
    return true
end

--[[
    获取 VPN 绑定的 WAN 接口
    
    @return WAN 接口名称
]]
function getVpnBindWan()
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    if features.system and features.system.multiwan and features.system.multiwan == "1" then
        local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
        return XQMultiWanPolicy.getCurrentWan("ipv4")
    else
        return "wan"
    end
end

--[[
    获取 VPN 配置信息
    
    @param vpn_name VPN 名称
    @return VPN 配置信息表
]]
function getVPNInfo(vpn_name)
    local info = {
        proto = "",
        server = "",
        username = "",
        password = "",
        auto = "0",
        id = "",
        auth = "",
        netmask = "255.255.255.0"
    }
    
    if XQFunction.isStrNil(vpn_name) then
        return info
    end
    
    local vpn_config = uci:get_all("network", vpn_name)
    
    if vpn_config then
        info.proto = vpn_config.proto
        info.server = vpn_config.server
        info.username = vpn_config.username
        info.password = vpn_config.password
        info.auto = vpn_config.auto
        info.id = vpn_config.id
        info.auth = vpn_config.auth
        
        local wan_name = getVpnBindWan()
        local netmask = uci:get("network", wan_name, "netmask") or ""
        info.netmask = netmask
    end
    
    return info
end

--[[
    VPN 开关
    
    @param enable true 表示开启，false 表示关闭
    @param vpn_id VPN ID
    @return 1 表示成功
]]
function vpnSwitch(enable, vpn_id)
    if XQFunction.isStrNil(vpn_id) then
        vpn_id = uci:get("network", "vpn", "id")
        
        if XQFunction.isStrNil(vpn_id) then
            return false
        end
    end
    
    if enable then
        local ubus = require("ubus")
        local conn = ubus.connect()
        local vpn_status = conn:call("network.interface.vpn", "status", {})
        
        local current_id = uci:get("network", "vpn", "id") or ""
        local auto = uci:get("network", "vpn", "auto") or ""
        
        if current_id ~= vpn_id then
            local vpn_config = uci:get_all("vpnlist", vpn_id)
            if vpn_config then
                setVpn("vpn", vpn_config.server, vpn_config.username, 
                       vpn_config.password, vpn_config.proto, vpn_id, 
                       auto, vpn_config.auth)
            end
        end
        
        os.execute(XQConfigs.RM_VPNSTATUS_FILE)
        
        if vpn_status then
            os.execute(XQConfigs.VPN_DISABLE)
            os.execute("sleep 1")
        end
        
        XQFunction.forkExec(XQConfigs.VPN_ENABLE)
    else
        os.execute(XQConfigs.RM_VPNSTATUS_FILE)
        XQFunction.forkExec(XQConfigs.VPN_DISABLE)
    end
    
    local user_option = enable and 1 or 0
    os.execute(XQConfigs.SET_VPN_USER_OPTION .. user_option)
    
    return 1
end

--[[
    获取 VPN 状态
    
    @return VPN 状态信息表，无状态返回 nil
]]
function vpnStatus()
    local luci_util = require("luci.util")
    local status_str = luci_util.exec(XQConfigs.VPN_STATUS)
    
    if not XQFunction.isStrNil(status_str) then
        status_str = luci_util.trim(status_str)
        
        if XQFunction.isStrNil(status_str) then
            return nil
        end
        
        local json = require("json")
        local status = json.decode(status_str)
        
        if status then
            return status
        end
    end
    
    return nil
end

--[[
    添加 VPN 配置
    
    @param oname 原始名称
    @param server 服务器地址
    @param username 用户名
    @param password 密码
    @param proto 协议类型
    @param auth 认证方式
    @param old_id 旧的 VPN ID（用于替换）
    @return 成功返回 true，参数无效返回 false
]]
function addVPN(oname, server, username, password, proto, auth, old_id)
    if XQFunction.isStrNil(oname) or XQFunction.isStrNil(server) or
       XQFunction.isStrNil(username) or XQFunction.isStrNil(password) or
       XQFunction.isStrNil(proto) then
        return false
    end
    
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    local vpn_id = XQCryptoUtil.md5Str(server .. username .. proto)
    
    local vpn_config = {
        oname = oname,
        server = server,
        username = username,
        password = password,
        proto = string.lower(proto),
        id = vpn_id,
        auth = auth
    }
    
    if old_id then
        uci:delete("vpnlist", old_id)
    end
    
    uci:section("vpnlist", "vpn", vpn_id, vpn_config)
    uci:commit("vpnlist")
    
    return true
end

--[[
    编辑 VPN 配置
    
    @param vpn_id VPN ID
    @param oname 原始名称
    @param server 服务器地址
    @param username 用户名
    @param password 密码
    @param proto 协议类型
    @return 成功返回 true，参数无效返回 false
]]
function editVPN(vpn_id, oname, server, username, password, proto)
    if XQFunction.isStrNil(vpn_id) then
        return false
    end
    
    local auth = uci:get("vpnlist", vpn_id, "auth")
    if XQFunction.isStrNil(auth) then
        auth = "auto"
    end
    
    _editNetworkVpn(server, username, password, proto, vpn_id, auth)
    
    return addVPN(oname, server, username, password, proto, auth, vpn_id)
end

--[[
    删除 VPN 配置
    
    @param vpn_id VPN ID
    @return 成功返回 true，参数无效返回 false
]]
function delVPN(vpn_id)
    if XQFunction.isStrNil(vpn_id) then
        return false
    end
    
    uci:delete("vpnlist", vpn_id)
    uci:commit("vpnlist")
    
    _delNetworkVpn(vpn_id)
    
    return true
end

--[[
    检查 VPN 服务器 IP 是否有效
    
    @param ip IP 地址
    @param netmask 子网掩码
    @return true 表示有效，false 表示无效
]]
function checkVPNServerIp(ip, netmask)
    local luci_ip = require("luci.ip")
    local XQLog = require("xiaoqiang.XQLog")
    
    local ip_num = luci_ip.iptonl(ip)
    local link_local_start = luci_ip.iptonl("169.254.0.0")
    local link_local_end = luci_ip.iptonl("169.254.255.255")
    local loopback = luci_ip.iptonl("127.0.0.1")
    
    if (ip_num >= link_local_start and ip_num <= link_local_end) or
       ip_num == loopback or
       XQFunction.isBroadcastOrMulticast(ip, netmask) then
        return false
    end
    
    return true
end

--[[
    获取 VPN 列表
    
    @return VPN 配置列表
]]
function getVPNList()
    local vpn_list = {}
    
    uci:foreach("vpnlist", "vpn", function(section)
        local vpn = {
            oname = section.oname,
            server = section.server,
            username = section.username,
            password = section.password,
            proto = section.proto,
            id = section.id
        }
        table.insert(vpn_list, vpn)
    end)
    
    return vpn_list
end

--[[
    获取代理列表
    
    @return 代理地址列表，无代理返回 nil
]]
function getProxyList()
    local nixio_fs = require("nixio.fs")
    local datatypes = require("luci.cbi.datatypes")
    
    local proxy_list = {}
    
    if nixio_fs.access(PROXY_FILE) then
        local file = io.open(PROXY_FILE)
        if file then
            for line in file:lines() do
                if not XQFunction.isStrNil(line) then
                    if line:match("^%.") then
                        local domain = line:gsub("^%.", "")
                        table.insert(proxy_list, domain)
                    elseif datatypes.ipaddr(line) then
                        table.insert(proxy_list, line)
                    end
                end
            end
        end
    end
    
    if #proxy_list > 0 then
        return proxy_list
    else
        return nil
    end
end

--[[
    更新代理列表
    
    @param proxy_list 代理地址列表，"default" 表示使用默认配置
]]
function updateProxyList(proxy_list)
    if proxy_list and type(proxy_list) == "string" and proxy_list == "default" then
        proxy_list = nil
    end
    
    if proxy_list and type(proxy_list) == "table" then
        local file = io.open(PROXY_FILE, "w")
        
        for _, proxy in ipairs(proxy_list) do
            if not XQFunction.isStrNil(proxy) then
                file:write(proxy .. "\n")
            end
        end
        
        file:close()
    end
end

--[[
    获取设备列表（用于智能 VPN）
    
    @return MAC 地址列表
]]
function getDeviceList()
    local device_list = {}
    
    local device_config = uci:get_all("smartvpn", "device")
    
    if device_config then
        device_list = uci:get_list("smartvpn", "device", "mac")
    else
        device_list = nil
    end
    
    return device_list
end

--[[
    获取智能 VPN 信息
    
    @return 智能 VPN 状态信息表
]]
function getSmartVPNInfo()
    local info = {
        status = 0,
        switch = 0,
        mode = 1
    }
    
    local vpn_config = uci:get_all("smartvpn", "vpn")
    local device_config = uci:get_all("smartvpn", "device")
    
    if vpn_config then
        if vpn_config.status == "on" then
            info.status = 1
        elseif vpn_config.status == "off" then
            info.status = 0
        end
        
        if vpn_config.switch then
            if tonumber(vpn_config.switch) == 1 then
                info.switch = 1
            end
        end
        
        if device_config then
            if device_config.disabled and tonumber(device_config.disabled) == 0 then
                info.mode = 2
            end
        else
            if vpn_config.disabled then
                if tonumber(vpn_config.disabled) == 0 then
                    info.mode = 1
                end
            else
                info.mode = 0
            end
        end
    end
    
    return info
end

--[[
    设置智能 VPN
    
    @param switch_on 开关状态（0 或 1）
    @param mode 模式（1 或 2）
]]
function setSmartVPN(switch_on, mode)
    local nixio_fs = require("nixio.fs")
    
    if mode then
        if mode == 1 then
            if not nixio_fs.access(PROXY_FILE) and switch_on == 1 then
                updateProxyList("default")
            end
            
            uci:set("smartvpn", "vpn", "disabled", "0")
            uci:set_list("smartvpn", "vpn", "domain_file", { PROXY_FILE })
            
            local device_config = uci:get_all("smartvpn", "device")
            if device_config then
                uci:set("smartvpn", "device", "disabled", "1")
            end
        elseif mode == 2 then
            uci:set("smartvpn", "vpn", "disabled", "1")
            
            local device_config = uci:get_all("smartvpn", "device")
            if device_config then
                uci:set("smartvpn", "device", "disabled", "0")
            else
                uci:section("smartvpn", "record", "device", { disabled = "0" })
            end
        end
    end
    
    if switch_on then
        if switch_on == 0 then
            uci:set("smartvpn", "vpn", "switch", "0")
            uci:set("smartvpn", "vpn", "disabled", "1")
            uci:set("smartvpn", "device", "disabled", "1")
            uci:set("network", "vpn", "trafficall", "yes")
            uci:commit("network")
        elseif switch_on == 1 then
            uci:set("smartvpn", "vpn", "switch", "1")
            uci:set("network", "vpn", "trafficall", "no")
            uci:commit("network")
        end
    end
    
    uci:commit("smartvpn")
end

--[[
    设置小米 VPN
    
    @param enable 0 表示关闭
]]
function setMiVPN(enable)
    if enable and enable == 0 then
        os.execute("/usr/sbin/mivpn.sh off >/dev/null 2>/dev/null")
    end
end

--[[
    合并列表
    
    @param list1 第一个列表
    @param list2 第二个列表
    @param operation 操作类型（"+" 表示合并，"-" 表示差集）
    @return 合并后的列表
]]
function merge(list1, list2, operation)
    if not list1 and not list2 then
        return nil
    end
    
    if operation == "+" then
        if list1 then
            if not list2 then
                return list1
            end
            
            local exists = {}
            for _, item in ipairs(list1) do
                exists[item] = true
            end
            
            for _, item in ipairs(list2) do
                if not exists[item] then
                    table.insert(list1, item)
                end
            end
            
            return list1
        elseif not list2 then
            return nil
        else
            return list2
        end
    elseif operation == "-" and list1 then
        if not list2 then
            return list1
        end
        
        local to_remove = {}
        for _, item in ipairs(list2) do
            to_remove[item] = true
        end
        
        local result = {}
        for _, item in ipairs(list1) do
            if not to_remove[item] then
                table.insert(result, item)
            end
        end
        
        return result
    end
    
    return nil
end

--[[
    格式化 URL
    
    @param url URL 字符串
    @return 格式化后的 URL
]]
function urlFormat(url)
    local datatypes = require("luci.cbi.datatypes")
    
    if url then
        url = url:gsub("http://", "")
        url = url:gsub("^www", "")
        
        if not datatypes.ipaddr(url) then
            if not url:match("^%.") then
                url = "." .. url
            end
        end
        
        return url
    end
    
    return nil
end

--[[
    获取小米 VPN 信息
    
    @return 1 表示全部流量走 VPN，0 表示智能分流
]]
function mivpnInfo()
    local trafficall = uci:get("network", "vpn", "trafficall")
    
    if trafficall then
        if string.lower(trafficall) == "yes" then
            return 1
        end
    else
        return 0
    end
end

--[[
    小米 VPN 开关
    
    @param enable true 表示全部流量走 VPN，false 表示智能分流
    @return 成功返回 true，失败返回 false
]]
function mivpnSwitch(enable)
    local vpn_config = uci:get_all("network", "vpn")
    local smartvpn_switch = uci:get("smartvpn", "vpn", "switch")
    
    if enable and smartvpn_switch then
        if tonumber(smartvpn_switch) == 1 then
            setSmartVPN(0, 1)
        end
    end
    
    if vpn_config then
        uci:set("network", "vpn", "trafficall", enable and "yes" or "no")
        uci:commit("network")
        
        if not enable then
            setMiVPN(0)
        end
        
        return true
    else
        return false
    end
end
