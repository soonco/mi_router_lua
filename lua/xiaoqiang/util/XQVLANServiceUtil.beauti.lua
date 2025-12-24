--[[
  VLAN 服务工具模块
  提供 VLAN 服务配置管理功能，用于 IPTV、VoIP 等服务的 VLAN 配置
  支持 Internet、IPTV、VoIP、Bridge 四种类型的 VLAN 配置
]]

module("xiaoqiang.util.XQVLANServiceUtil", package.seeall)

local uciCursor = require("luci.model.uci").cursor()
local logger = require("xiaoqiang.XQLog")

function validate_vlanid(vlanId)
    if nil == vlanId then
        return false
    end
    if -1 <= vlanId and vlanId <= 4095 then
        return true
    end
    return false
end

function validate_priority(priority)
    if nil == priority then
        return false
    end
    if -1 <= priority and priority <= 7 then
        return true
    end
    return false
end

function check_vid_conflict(config)
    if nil == config then
        return false
    end
    
    local internetVid = config.type.internet.vid
    local iptvVid = config.type.iptv.vid
    local voipVid = config.type.voip.vid
    
    local internetEnable = config.service.Internet.enable
    local multimediaEnable = config.service.Multimedia.enable
    local totalEnabled = internetEnable + multimediaEnable
    
    if 2 == totalEnabled then
        local sumVid = internetVid + iptvVid
        if -2 == sumVid or internetVid ~= iptvVid then
            sumVid = internetVid + voipVid
            if -2 == sumVid or internetVid ~= voipVid then
                sumVid = iptvVid + voipVid
            end
        end
        if -2 ~= sumVid and iptvVid == voipVid then
            return true
        end
    elseif 1 == multimediaEnable then
        local sumVid = iptvVid + voipVid
        if -2 ~= sumVid and iptvVid == voipVid then
            return true
        end
    end
    
    return false
end

function vlan_service_changed(config)
    local changed = false
    local currentConfig = getVlanService()
    
    if nil == currentConfig then
        return nil
    end
    
    for interfaceName, interfaceType in pairs(currentConfig.interface) do
        if not changed then
            local newType = config.interface[interfaceName]
            changed = newType ~= interfaceType
        end
    end
    
    logger.log(6, "VLAN service changed:", changed)
    return changed
end

function setVlanService(config, async)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    logger.log(6, config, async)
    
    local changed = vlan_service_changed(config)
    if not changed then
        return true
    end
    
    if check_vid_conflict(config) then
        return false
    end
    
    if not validate_vlanid(config.type.internet.vid) then
        return false
    end
    
    if not validate_vlanid(config.type.iptv.vid) then
        return false
    end
    
    if not validate_vlanid(config.type.voip.vid) then
        return false
    end
    
    if not validate_vlanid(config.type.bridge.vid) then
        return false
    end
    
    if not validate_priority(config.type.internet.priority) then
        return false
    end
    
    if not validate_priority(config.type.iptv.priority) then
        return false
    end
    
    if not validate_priority(config.type.voip.priority) then
        return false
    end
    
    if not validate_priority(config.type.bridge.priority) then
        return false
    end
    
    uciCursor:set("vlan_service", "Internet", "enable", config.service.Internet.enable)
    uciCursor:set("vlan_service", "Internet", "profile", config.service.Internet.profile)
    uciCursor:set("vlan_service", "Multimedia", "enable", config.service.Multimedia.enable)
    uciCursor:set("vlan_service", "Multimedia", "profile", config.service.Multimedia.profile)
    
    uciCursor:set("vlan_service", "iptv", "vid", config.type.iptv.vid)
    uciCursor:set("vlan_service", "iptv", "priority", config.type.iptv.priority)
    uciCursor:set("vlan_service", "iptv", "wan_egress_tag", config.type.iptv.wan_egress_tag)
    uciCursor:set("vlan_service", "iptv", "lan_egress_tag", config.type.iptv.lan_egress_tag)
    
    uciCursor:set("vlan_service", "voip", "vid", config.type.voip.vid)
    uciCursor:set("vlan_service", "voip", "priority", config.type.voip.priority)
    uciCursor:set("vlan_service", "voip", "wan_egress_tag", config.type.voip.wan_egress_tag)
    uciCursor:set("vlan_service", "voip", "lan_egress_tag", config.type.voip.lan_egress_tag)
    
    uciCursor:set("vlan_service", "internet", "vid", config.type.internet.vid)
    uciCursor:set("vlan_service", "internet", "priority", config.type.internet.priority)
    uciCursor:set("vlan_service", "internet", "wan_egress_tag", config.type.internet.wan_egress_tag)
    uciCursor:set("vlan_service", "internet", "lan_egress_tag", config.type.internet.lan_egress_tag)
    
    uciCursor:set("vlan_service", "bridge", "vid", config.type.bridge.vid)
    uciCursor:set("vlan_service", "bridge", "priority", config.type.bridge.priority)
    uciCursor:set("vlan_service", "bridge", "wan_egress_tag", config.type.bridge.wan_egress_tag)
    uciCursor:set("vlan_service", "bridge", "lan_egress_tag", config.type.bridge.lan_egress_tag)
    
    uciCursor:foreach("vlan_service", "interface", function(section)
        uciCursor:set("vlan_service", section[".name"], "type", config.interface[section[".name"]])
    end)
    
    uciCursor:save("vlan_service")
    uciCursor:commit("vlan_service")
    
    if async then
        XQFunction.forkExec("vlan_service.sh restart true")
    else
        os.execute("vlan_service.sh restart false")
    end
    
    return true
end

function getVlanService()
    local config = {}
    
    local service = {}
    service.Internet = {
        enable = 0,
        profile = 0
    }
    service.Multimedia = {
        enable = 0,
        profile = 0
    }
    config.service = service
    
    local vlanType = {}
    vlanType.iptv = {
        vid = -1,
        priority = -1,
        wan_egress_tag = 1,
        lan_egress_tag = 0
    }
    vlanType.voip = {
        vid = -1,
        priority = -1,
        wan_egress_tag = 1,
        lan_egress_tag = 0
    }
    vlanType.bridge = {
        vid = -1,
        priority = -1,
        wan_egress_tag = 1,
        lan_egress_tag = 0
    }
    vlanType.internet = {
        vid = -1,
        priority = -1,
        wan_egress_tag = 1,
        lan_egress_tag = 0
    }
    config.type = vlanType
    
    config.interface = {}
    
    local multimediaEnable = uciCursor:get("vlan_service", "Multimedia", "enable")
    config.service.Multimedia.enable = (multimediaEnable and tonumber(multimediaEnable)) or 0
    
    local multimediaProfile = uciCursor:get("vlan_service", "Multimedia", "profile")
    config.service.Multimedia.profile = (multimediaProfile and tonumber(multimediaProfile)) or 0
    
    local internetEnable = uciCursor:get("vlan_service", "Internet", "enable")
    config.service.Internet.enable = (internetEnable and tonumber(internetEnable)) or 0
    
    local internetProfile = uciCursor:get("vlan_service", "Internet", "profile")
    config.service.Internet.profile = (internetProfile and tonumber(internetProfile)) or 0
    
    local iptvVid = uciCursor:get("vlan_service", "iptv", "vid")
    config.type.iptv.vid = (iptvVid and tonumber(iptvVid)) or -1
    
    local iptvPriority = uciCursor:get("vlan_service", "iptv", "priority")
    config.type.iptv.priority = (iptvPriority and tonumber(iptvPriority)) or -1
    
    local iptvWanEgressTag = uciCursor:get("vlan_service", "iptv", "wan_egress_tag")
    config.type.iptv.wan_egress_tag = (iptvWanEgressTag and tonumber(iptvWanEgressTag)) or 1
    
    local iptvLanEgressTag = uciCursor:get("vlan_service", "iptv", "lan_egress_tag")
    config.type.iptv.lan_egress_tag = (iptvLanEgressTag and tonumber(iptvLanEgressTag)) or 0
    
    local voipVid = uciCursor:get("vlan_service", "voip", "vid")
    config.type.voip.vid = (voipVid and tonumber(voipVid)) or -1
    
    local voipPriority = uciCursor:get("vlan_service", "voip", "priority")
    config.type.voip.priority = (voipPriority and tonumber(voipPriority)) or -1
    
    local voipWanEgressTag = uciCursor:get("vlan_service", "voip", "wan_egress_tag")
    config.type.voip.wan_egress_tag = (voipWanEgressTag and tonumber(voipWanEgressTag)) or 1
    
    local voipLanEgressTag = uciCursor:get("vlan_service", "voip", "lan_egress_tag")
    config.type.voip.lan_egress_tag = (voipLanEgressTag and tonumber(voipLanEgressTag)) or 0
    
    local internetVid = uciCursor:get("vlan_service", "internet", "vid")
    config.type.internet.vid = (internetVid and tonumber(internetVid)) or -1
    
    local internetPriority = uciCursor:get("vlan_service", "internet", "priority")
    config.type.internet.priority = (internetPriority and tonumber(internetPriority)) or -1
    
    local internetWanEgressTag = uciCursor:get("vlan_service", "internet", "wan_egress_tag")
    config.type.internet.wan_egress_tag = (internetWanEgressTag and tonumber(internetWanEgressTag)) or 1
    
    local internetLanEgressTag = uciCursor:get("vlan_service", "internet", "lan_egress_tag")
    config.type.internet.lan_egress_tag = (internetLanEgressTag and tonumber(internetLanEgressTag)) or 0
    
    local bridgeVid = uciCursor:get("vlan_service", "bridge", "vid")
    config.type.bridge.vid = (bridgeVid and tonumber(bridgeVid)) or -1
    
    local bridgePriority = uciCursor:get("vlan_service", "bridge", "priority")
    config.type.bridge.priority = (bridgePriority and tonumber(bridgePriority)) or -1
    
    local bridgeWanEgressTag = uciCursor:get("vlan_service", "bridge", "wan_egress_tag")
    config.type.bridge.wan_egress_tag = (bridgeWanEgressTag and tonumber(bridgeWanEgressTag)) or 1
    
    local bridgeLanEgressTag = uciCursor:get("vlan_service", "bridge", "lan_egress_tag")
    config.type.bridge.lan_egress_tag = (bridgeLanEgressTag and tonumber(bridgeLanEgressTag)) or 0
    
    uciCursor:foreach("vlan_service", "interface", function(section)
        config.interface[section[".name"]] = section.type
    end)
    
    logger.log(6, config)
    return config
end
