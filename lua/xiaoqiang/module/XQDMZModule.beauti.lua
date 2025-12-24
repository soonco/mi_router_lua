--[[
  小米路由器DMZ模块 (XQDMZModule)
  功能: 管理DMZ(非军事区)主机配置
  
  主要功能:
  - DMZ主机设置和取消
  - DMZ状态查询
  - 简单DMZ和复杂DMZ配置
  - 与端口转发模块联动
]]

module("xiaoqiang.module.XQDMZModule", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local uci = require("luci.model.uci")
local cursor = uci.cursor()

-- DMZ NVRAM配置
DMZ_NVRAM = {
    vlan1hwname = "et0",
    vlan2hwname = "et0",
    vlan3hwname = "et0",
    vlan1ports = "2 5*",
    vlan2ports = "4 5",
    vlan3ports = "0 5*"
}

-- DMZ网络配置
DMZ_NETWORK_CONFIGS = {
    eth0_1 = {
        device = "eth0",
        vlan = 1,
        ports = "2 5*"
    },
    eth0_3 = {
        device = "eth0",
        vlan = 3,
        ports = "0 5*"
    },
    dmz = {
        ifname = "eth0.3",
        proto = "static",
        ipaddr = "",
        netmask = "255.255.255.0"
    }
}

-- DMZ防火墙配置
DMZ_FIREWALL_CONFIGS = {
    zonedmz = {
        name = "dmz",
        network = "dmz",
        input = "REJECT",
        output = "ACCEPT",
        forward = "REJECT"
    },
    dmzdns = {
        src = "dmz",
        proto = "tcpudp",
        dest_port = 53,
        target = "ACCEPT"
    },
    dmzdhcp = {
        src = "dmz",
        proto = "udp",
        dest_port = 67,
        target = "ACCEPT"
    },
    dmztowan = {
        src = "dmz",
        dest = "wan"
    },
    lantodmz = {
        src = "lan",
        dest = "dmz"
    },
    dmz = {
        src = "wan",
        proto = "tcp",
        target = "DNAT",
        dest = "lan",
        dest_ip = ""
    },
    dmzudp = {
        src = "wan",
        proto = "udp",
        target = "DNAT",
        dest = "lan",
        src_port = "!67",
        dest_ip = ""
    }
}

-- DMZ DHCP配置
DMZ_DHCP_CONFIGS = {
    dmz = {
        interface = "dmz",
        start = 100,
        limit = 150,
        leasetime = "12h",
        force = 1
    }
}

--[[
  当LAN IP变更时更新DMZ目标IP
  @param newLanIp 新的LAN IP地址
  @param netmask 子网掩码
]]
function hookLanIPChangeEvent(newLanIp, netmask)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 获取当前DMZ目标IP
    local destIp = cursor:get("firewall", "dmz", "dest_ip")
    
    if not XQFunction.isStrNil(destIp) then
        -- 根据子网掩码确定匹配模式
        local matchPattern = ".%d+$"
        if netmask == "255.255.0.0" then
            matchPattern = ".%d+.%d+$"
        end
        
        -- 提取新IP的网段前缀
        local newPrefix = newLanIp:gsub(matchPattern, "")
        
        -- 提取原IP的主机部分
        local suffix = destIp:match(matchPattern)
        local newDestIp = newPrefix .. suffix
        
        -- 更新DMZ目标IP
        cursor:set("firewall", "dmz", "dest_ip", newDestIp)
        cursor:set("firewall", "dmzudp", "dest_ip", newDestIp)
        cursor:commit("firewall")
    end
end

--[[
  取消DMZ设置
  @param dmzType DMZ类型 (0=简单DMZ, 1=复杂DMZ)
]]
function unsetDMZ(dmzType)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    if dmzType == 1 then
        -- 复杂DMZ: 删除所有DMZ相关配置
        
        -- 删除防火墙配置
        cursor:delete("firewall", "zonedmz")
        cursor:delete("firewall", "dmzdns")
        cursor:delete("firewall", "dmzdhcp")
        cursor:delete("firewall", "dmztowan")
        cursor:delete("firewall", "lantodmz")
        cursor:delete("firewall", "dmz")
        cursor:commit("firewall")
        
        -- 删除DHCP配置
        cursor:delete("dhcp", "dmz")
        cursor:commit("dhcp")
        
        -- 删除网络配置
        cursor:delete("network", "dmz")
        cursor:delete("network", "eth0_3")
        cursor:commit("network")
        
        -- 清除NVRAM配置
        XQFunction.nvramSet("vlan3hwname", nil)
        XQFunction.nvramSet("vlan3ports", nil)
        XQFunction.nvramSet("vlan2ports", "4 5")
        XQFunction.nvramSet("vlan1ports", "0 2 5*")
        XQFunction.nvramCommit()
        
    elseif dmzType == 0 then
        -- 简单DMZ: 只删除重定向规则
        cursor:delete("firewall", "dmz")
        cursor:delete("firewall", "dmzudp")
        cursor:commit("firewall")
        
        -- 检查是否为Mesh模式
        if not XQFunction.isMeshMode() then
            XQFunction.setNetMode(nil)
        end
        
        XQFunction.nvramCommit()
    end
end

--[[
  设置简单DMZ
  @param destIp DMZ主机IP地址
  @param mac DMZ主机MAC地址(可选，用于IP绑定)
  @return 错误码 (0=成功, 2=IP不在同一网段)
]]
function _setSimpleDMZ(destIp, mac)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local dmzConfig = DMZ_FIREWALL_CONFIGS.dmz
    local dmzUdpConfig = DMZ_FIREWALL_CONFIGS.dmzudp
    
    -- 获取LAN IP和子网掩码
    local lanIp = cursor:get("network", "lan", "ipaddr")
    local netmask = cursor:get("network", "lan", "netmask")
    
    -- 根据子网掩码确定匹配模式
    local matchPattern = ".%d+$"
    if netmask == "255.255.0.0" then
        matchPattern = ".%d+.%d+$"
    end
    
    -- 检查IP是否在同一网段
    local lanPrefix = lanIp:gsub(matchPattern, "")
    local destPrefix = destIp:gsub(matchPattern, "")
    
    if lanPrefix ~= destPrefix or lanIp == destIp then
        return 2  -- IP不在同一网段或与LAN IP相同
    end
    
    -- 设置DMZ目标IP
    dmzConfig.dest_ip = destIp
    dmzUdpConfig.dest_ip = destIp
    
    -- 保存防火墙配置
    cursor:section("firewall", "redirect", "dmz", dmzConfig)
    cursor:section("firewall", "redirect", "dmzudp", dmzUdpConfig)
    cursor:commit("firewall")
    
    -- 如果提供了MAC地址，添加IP绑定
    if not XQFunction.isStrNil(mac) then
        local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
        local result = XQLanWanUtil.addBind(mac, destIp)
        if result == 0 then
            XQLanWanUtil.saveBindInfo()
        end
        return result
    end
    
    return 0
end

--[[
  设置复杂DMZ(带独立VLAN)
  @param destIp DMZ主机IP地址
  @param mac DMZ主机MAC地址(可选)
  @return 错误码
]]
function _setComplexDMZ(destIp, mac)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local luciUtil = require("luci.util")
    
    -- 获取LAN配置
    local lanIp = cursor:get("network", "lan", "ipaddr")
    
    -- 解析IP地址
    local ipParts = luciUtil.split(destIp, ".")
    ipParts[4] = 1
    local dmzGateway = table.concat(ipParts, ".")
    
    -- 检查IP是否在同一网段
    local lanPrefix = lanIp:gsub(".%d+$", "")
    local destPrefix = destIp:gsub(".%d+$", "")
    
    if lanPrefix == destPrefix or lanIp == destIp then
        return 2
    end
    
    -- 设置NVRAM
    for key, value in pairs(DMZ_NVRAM) do
        XQFunction.nvramSet(key, value)
    end
    XQFunction.nvramCommit()
    
    -- 设置网络配置
    local eth0_1Config = DMZ_NETWORK_CONFIGS.eth0_1
    local eth0_3Config = DMZ_NETWORK_CONFIGS.eth0_3
    local dmzNetConfig = DMZ_NETWORK_CONFIGS.dmz
    dmzNetConfig.ipaddr = dmzGateway
    
    cursor:section("network", "switch_vlan", "eth0_1", eth0_1Config)
    cursor:section("network", "switch_vlan", "eth0_3", eth0_3Config)
    cursor:section("network", "interface", "dmz", dmzNetConfig)
    cursor:commit("network")
    
    -- 设置防火墙配置
    local zonedmzConfig = DMZ_FIREWALL_CONFIGS.zonedmz
    local dmzdnsConfig = DMZ_FIREWALL_CONFIGS.dmzdns
    local dmzdhcpConfig = DMZ_FIREWALL_CONFIGS.dmzdhcp
    local dmztowanConfig = DMZ_FIREWALL_CONFIGS.dmztowan
    local lantodmzConfig = DMZ_FIREWALL_CONFIGS.lantodmz
    local dmzConfig = DMZ_FIREWALL_CONFIGS.dmz
    dmzConfig.dest_ip = destIp
    
    cursor:section("firewall", "zone", "zonedmz", zonedmzConfig)
    cursor:section("firewall", "rule", "dmzdns", dmzdnsConfig)
    cursor:section("firewall", "rule", "dmzdhcp", dmzdhcpConfig)
    cursor:section("firewall", "forwarding", "dmztowan", dmztowanConfig)
    cursor:section("firewall", "forwarding", "lantodmz", lantodmzConfig)
    cursor:section("firewall", "redirect", "dmz", dmzConfig)
    cursor:commit("firewall")
    
    -- 设置DHCP配置
    local dmzDhcpConfig = DMZ_DHCP_CONFIGS.dmz
    cursor:section("dhcp", "dhcp", "dmz", dmzDhcpConfig)
    
    -- 如果提供了MAC地址，添加IP绑定
    if not XQFunction.isStrNil(mac) then
        local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
        local result = XQLanWanUtil.addBind(mac, destIp)
        if result == 0 then
            XQLanWanUtil.saveBindInfo()
        end
        return result
    end
    
    return 0
end

--[[
  检查DMZ模块是否已启用
  @return true/false
]]
function moduleOn()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local destIp = cursor:get("firewall", "dmz", "dest_ip")
    local enabled = cursor:get("firewall", "dmz", "enabled") or "1"
    
    if enabled == "1" and destIp then
        return true
    else
        return false
    end
end

--[[
  获取DMZ信息
  @return DMZ状态信息表 {status: 0=关闭, 1=开启, 2=端口转发已开启}
]]
function getDMZInfo()
    local XQPortForward = require("xiaoqiang.module.XQPortForward")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local result = {}
    
    -- 检查端口转发是否开启
    if XQPortForward.moduleOn() then
        result.status = 2
    else
        -- 检查DMZ是否开启
        if moduleOn() then
            result.status = 1
            -- 获取DMZ主机IP
            local destIp = cursor:get("firewall", "dmz", "dest_ip") or ""
            result.ip = destIp
        else
            result.status = 0
        end
    end
    
    -- 获取LAN信息
    result.lanip = cursor:get("network", "lan", "ipaddr") or ""
    result.lanmask = cursor:get("network", "lan", "netmask") or ""
    
    return result
end

--[[
  设置DMZ
  @param dmzType DMZ类型 (0=简单DMZ, 1=复杂DMZ)
  @param destIp DMZ主机IP地址
  @param mac DMZ主机MAC地址(可选)
  @return 错误码 (0=成功, 2=IP错误, 3=类型错误, 4=端口转发已开启, 5=VS/PT已开启)
]]
function setDMZ(dmzType, destIp, mac)
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    local XQPortForward = require("xiaoqiang.module.XQPortForward")
    
    -- 参数校验
    if XQFunction.isStrNil(destIp) then
        return 2
    end
    
    -- 检查是否支持NAT专业版
    if features.apps and features.apps.natpro and features.apps.natpro == "1" then
        -- 检查虚拟服务器和端口触发是否开启
        if XQPortForward.VSOn() or XQPortForward.PTOn() then
            return 5
        end
    else
        -- 检查端口转发是否开启
        if XQPortForward.moduleOn() then
            return 4
        end
    end
    
    -- 根据类型设置DMZ
    if dmzType == 0 then
        return _setSimpleDMZ(destIp, mac)
    elseif dmzType == 1 then
        return _setComplexDMZ(destIp, mac)
    else
        return 3
    end
end

--[[
  重载DMZ配置
  @param dmzType DMZ类型
]]
function dmzReload(dmzType)
    local cmd = " /etc/init.d/firewall restart; "
    
    if dmzType == 0 then
        -- 简单DMZ: 重启防火墙和相关服务
        local upnpEnabled = cursor:get("upnpd", "config", "enable_upnp") or "0"
        
        if upnpEnabled then
            cmd = cmd .. XQConfigs.UPNP_DISABLE .. XQConfigs.UPNP_ENABLE
        end
        
        cmd = cmd .. XQConfigs.FORK_RESTART_DNSMASQ
        XQFunction.forkExec(cmd)
        
    elseif dmzType == 1 then
        -- 复杂DMZ: 需要重启路由器
        XQFunction.forkReboot()
    end
end
