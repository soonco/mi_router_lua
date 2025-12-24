--[[
  小米路由器 - 安全模块
  功能: 管理路由器的安全功能开关，包括隐私保护、病毒防火墙、恶意URL防护等
  模块名: xiaoqiang.module.XQSecurity
]]

module("xiaoqiang.module.XQSecurity", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")   -- 通用函数库
local XQVASModule = require("xiaoqiang.module.XQVASModule") -- 增值服务模块

--[[
  获取安全功能状态
  @return table 安全功能状态表，包含以下字段:
    - wifi_arn: WiFi接入认证 (0=关闭, 1=开启)
    - privacy_protection: 隐私保护 (0=关闭, 1=开启)
    - virus_file_firewall: 病毒文件防火墙 (0=关闭, 1=开启)
    - malicious_url_firewall: 恶意URL防火墙 (0=关闭, 1=开启)
    - app_security_v2: 应用安全V2 (如果支持)
    - open: 总开关状态 (0=有功能关闭, 1=全部开启)
    - count: 开启的功能数量
]]
function security_status()
    local uci = require("luci.model.uci").cursor()
    local XQPushUtil = require("xiaoqiang.util.XQPushUtil")
    
    -- 获取VAS服务配置的安全页面设置
    local vasSecurityPage = tonumber(uci:get("vas", "services", "security_page") or "0")
    
    -- 获取用户配置的安全页面设置
    local userSecurityPage = tonumber(uci:get("vas_user", "services", "security_page") or "0")
    
    -- 获取当前安全配置
    local currentSecurityPage = tonumber(uci:get("security", "common", "security_page") or "0")
    
    -- 如果用户配置与当前配置不同，且VAS配置不是-6(禁用)，则同步配置
    if userSecurityPage ~= currentSecurityPage and vasSecurityPage ~= -6 then
        uci:set("security", "common", "security_page", userSecurityPage)
        uci:commit("security")
        
        -- 重启安全页面服务
        XQFunction.forkExec("touch /etc/config/securitypage/enable.tag;/etc/init.d/securitypage restart")
    end
    
    -- 构建安全状态表
    local status = {}
    status.wifi_arn = 0  -- WiFi接入认证，默认关闭
    
    -- 获取隐私保护状态
    status.privacy_protection = tonumber(uci:get("security", "common", "privacy_protection") or "0")
    
    -- 获取病毒文件防火墙状态
    status.virus_file_firewall = tonumber(uci:get("security", "common", "virus_file_firewall") or "0")
    
    -- 恶意URL防火墙状态(来自用户配置)
    status.malicious_url_firewall = userSecurityPage
    
    -- 获取VAS增值服务状态
    local vasStatus = XQVASModule.get_vas()
    if vasStatus.app_security_v2 then
        status.app_security_v2 = vasStatus.app_security_v2
    end
    
    -- 获取推送设置中的WiFi认证状态
    local pushSettings = XQPushUtil.pushSettings()
    if pushSettings.auth then
        status.wifi_arn = 1
    else
        status.wifi_arn = 0
    end
    
    -- 计算总开关状态(所有功能都开启时为1)
    local allEnabled = 1
    local enabledCount = 0
    
    for _, value in pairs(status) do
        if value == 0 then
            allEnabled = 0
            break
        end
        enabledCount = enabledCount + 1
    end
    
    status.open = allEnabled
    status.count = enabledCount
    
    return status
end

--[[
  设置安全功能开关
  @param settings table 要设置的安全功能，可包含以下字段:
    - privacy_protection: 隐私保护 (0/1)
    - virus_file_firewall: 病毒文件防火墙 (0/1)
    - malicious_url_firewall: 恶意URL防火墙 (0/1)
    - app_security_v2: 应用安全V2 (0/1)
]]
function security_switch(settings)
    local uci = require("luci.model.uci").cursor()
    
    if settings then
        if type(settings) == "table" then
            for key, value in pairs(settings) do
                if key == "privacy_protection" then
                    -- 设置隐私保护
                    uci:set("security", "common", "privacy_protection", value)
                    
                elseif key == "virus_file_firewall" then
                    -- 设置病毒文件防火墙
                    uci:set("security", "common", "virus_file_firewall", value)
                    
                elseif key == "malicious_url_firewall" then
                    -- 设置恶意URL防火墙(通过VAS模块)
                    XQVASModule.set_vas({security_page = value})
                    
                elseif key == "app_security_v2" then
                    -- 设置应用安全V2(通过VAS模块)
                    XQVASModule.set_vas({app_security_v2 = value})
                end
            end
            
            -- 提交安全配置更改
            uci:commit("security")
        end
    end
end
