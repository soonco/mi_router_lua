--[[
  小米路由器增值服务模块 (XQVASModule)
  功能: 管理路由器增值服务(VAS)相关功能
  
  主要功能:
  - 增值服务信息获取
  - 服务状态管理
  - KV信息整合
]]

module("xiaoqiang.module.XQVASModule", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--[[
  获取VAS KV信息
  整合增值服务相关的键值对信息
  @return VAS信息表
]]
function get_vas_kv_info()
    local result = {}
    local XQPreference = require("xiaoqiang.XQPreference")
    
    -- 获取安全防护状态
    local securityEnabled = XQPreference.get("SECURITY_ENABLED")
    if securityEnabled then
        result.security_enabled = tonumber(securityEnabled) or 0
    else
        result.security_enabled = 0
    end
    
    -- 获取广告过滤状态
    local adFilterEnabled = XQPreference.get("AD_FILTER_ENABLED")
    if adFilterEnabled then
        result.ad_filter_enabled = tonumber(adFilterEnabled) or 0
    else
        result.ad_filter_enabled = 0
    end
    
    -- 获取游戏加速状态
    local gameAccelEnabled = XQPreference.get("GAME_ACCEL_ENABLED")
    if gameAccelEnabled then
        result.game_accel_enabled = tonumber(gameAccelEnabled) or 0
    else
        result.game_accel_enabled = 0
    end
    
    -- 获取VPN服务状态
    local vpnEnabled = XQPreference.get("VPN_ENABLED")
    if vpnEnabled then
        result.vpn_enabled = tonumber(vpnEnabled) or 0
    else
        result.vpn_enabled = 0
    end
    
    return result
end

--[[
  获取增值服务列表
  @return 服务列表
]]
function getVASList()
    local result = {}
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 遍历VAS配置
    cursor:foreach("vas", "service", function(section)
        local service = {}
        service.id = section[".name"]
        service.name = section.name or ""
        service.enabled = section.enabled or "0"
        service.status = section.status or "inactive"
        service.expire_time = section.expire_time or ""
        table.insert(result, service)
    end)
    
    return result
end

--[[
  设置增值服务状态
  @param serviceId 服务ID
  @param enabled 是否启用 (1=启用, 0=禁用)
  @return 0=成功, 1=参数错误, 2=服务不存在
]]
function setVASStatus(serviceId, enabled)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if XQFunction.isStrNil(serviceId) then
        return 1
    end
    
    -- 检查服务是否存在
    local exists = cursor:get("vas", serviceId)
    if not exists then
        return 2
    end
    
    -- 设置启用状态
    cursor:set("vas", serviceId, "enabled", tostring(enabled))
    cursor:commit("vas")
    
    return 0
end

--[[
  获取安全防护信息
  @return 安全防护状态信息
]]
function getSecurityInfo()
    local result = {}
    local XQPreference = require("xiaoqiang.XQPreference")
    
    -- 获取安全防护启用状态
    result.enabled = tonumber(XQPreference.get("SECURITY_ENABLED") or "0")
    
    -- 获取恶意网站拦截状态
    result.malware_block = tonumber(XQPreference.get("MALWARE_BLOCK_ENABLED") or "0")
    
    -- 获取钓鱼网站拦截状态
    result.phishing_block = tonumber(XQPreference.get("PHISHING_BLOCK_ENABLED") or "0")
    
    -- 获取入侵检测状态
    result.intrusion_detect = tonumber(XQPreference.get("INTRUSION_DETECT_ENABLED") or "0")
    
    -- 获取最后更新时间
    result.last_update = XQPreference.get("SECURITY_LAST_UPDATE") or ""
    
    return result
end

--[[
  设置安全防护
  @param enabled 是否启用
  @param malwareBlock 恶意网站拦截
  @param phishingBlock 钓鱼网站拦截
  @param intrusionDetect 入侵检测
  @return 0=成功
]]
function setSecurityConfig(enabled, malwareBlock, phishingBlock, intrusionDetect)
    local XQPreference = require("xiaoqiang.XQPreference")
    
    XQPreference.set("SECURITY_ENABLED", tostring(enabled))
    
    if malwareBlock ~= nil then
        XQPreference.set("MALWARE_BLOCK_ENABLED", tostring(malwareBlock))
    end
    
    if phishingBlock ~= nil then
        XQPreference.set("PHISHING_BLOCK_ENABLED", tostring(phishingBlock))
    end
    
    if intrusionDetect ~= nil then
        XQPreference.set("INTRUSION_DETECT_ENABLED", tostring(intrusionDetect))
    end
    
    return 0
end

--[[
  获取广告过滤信息
  @return 广告过滤状态信息
]]
function getAdFilterInfo()
    local result = {}
    local XQPreference = require("xiaoqiang.XQPreference")
    
    -- 获取广告过滤启用状态
    result.enabled = tonumber(XQPreference.get("AD_FILTER_ENABLED") or "0")
    
    -- 获取过滤规则数量
    result.rule_count = tonumber(XQPreference.get("AD_FILTER_RULE_COUNT") or "0")
    
    -- 获取今日拦截数量
    result.blocked_today = tonumber(XQPreference.get("AD_BLOCKED_TODAY") or "0")
    
    return result
end

--[[
  设置广告过滤
  @param enabled 是否启用
  @return 0=成功
]]
function setAdFilterEnabled(enabled)
    local XQPreference = require("xiaoqiang.XQPreference")
    
    XQPreference.set("AD_FILTER_ENABLED", tostring(enabled))
    
    -- 重启相关服务
    if enabled == 1 then
        XQFunction.forkExec("/etc/init.d/adfilter start")
    else
        XQFunction.forkExec("/etc/init.d/adfilter stop")
    end
    
    return 0
end

--[[
  获取游戏加速信息
  @return 游戏加速状态信息
]]
function getGameAccelInfo()
    local result = {}
    local XQPreference = require("xiaoqiang.XQPreference")
    
    -- 获取游戏加速启用状态
    result.enabled = tonumber(XQPreference.get("GAME_ACCEL_ENABLED") or "0")
    
    -- 获取加速模式
    result.mode = XQPreference.get("GAME_ACCEL_MODE") or "auto"
    
    -- 获取当前加速的设备数
    result.accel_devices = tonumber(XQPreference.get("GAME_ACCEL_DEVICES") or "0")
    
    return result
end

--[[
  设置游戏加速
  @param enabled 是否启用
  @param mode 加速模式 (auto/manual)
  @return 0=成功
]]
function setGameAccelConfig(enabled, mode)
    local XQPreference = require("xiaoqiang.XQPreference")
    
    XQPreference.set("GAME_ACCEL_ENABLED", tostring(enabled))
    
    if mode then
        XQPreference.set("GAME_ACCEL_MODE", mode)
    end
    
    -- 重启相关服务
    if enabled == 1 then
        XQFunction.forkExec("/etc/init.d/gameaccel start")
    else
        XQFunction.forkExec("/etc/init.d/gameaccel stop")
    end
    
    return 0
end
