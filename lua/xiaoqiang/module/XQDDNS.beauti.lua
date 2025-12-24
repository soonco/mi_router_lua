--[[
  小米路由器DDNS模块 (XQDDNS)
  功能: 管理动态域名服务(DDNS)配置
  
  主要功能:
  - DDNS服务开启/关闭
  - DDNS配置获取和设置
  - 支持多种DDNS服务提供商
]]

module("xiaoqiang.module.XQDDNS", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

--[[
  获取DDNS配置信息
  @return DDNS配置表
]]
function getDDNSInfo()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local result = {}
    
    -- 获取DDNS启用状态
    local enabled = cursor:get("ddns", "myddns", "enabled") or "0"
    result.enabled = tonumber(enabled)
    
    -- 获取DDNS服务提供商
    result.service = cursor:get("ddns", "myddns", "service_name") or ""
    
    -- 获取域名
    result.domain = cursor:get("ddns", "myddns", "domain") or ""
    
    -- 获取用户名
    result.username = cursor:get("ddns", "myddns", "username") or ""
    
    -- 获取密码(出于安全考虑，返回空字符串)
    result.password = ""
    
    -- 获取IP来源
    result.ip_source = cursor:get("ddns", "myddns", "ip_source") or "network"
    
    -- 获取检查间隔
    result.check_interval = tonumber(cursor:get("ddns", "myddns", "check_interval") or "10")
    
    -- 获取检查单位
    result.check_unit = cursor:get("ddns", "myddns", "check_unit") or "minutes"
    
    -- 获取强制更新间隔
    result.force_interval = tonumber(cursor:get("ddns", "myddns", "force_interval") or "72")
    
    -- 获取强制更新单位
    result.force_unit = cursor:get("ddns", "myddns", "force_unit") or "hours"
    
    return result
end

--[[
  设置DDNS配置
  @param enabled 是否启用 (1=启用, 0=禁用)
  @param service DDNS服务提供商名称
  @param domain 域名
  @param username 用户名
  @param password 密码
  @return 0=成功, 其他=失败
]]
function setDDNS(enabled, service, domain, username, password)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if enabled == 1 then
        if XQFunction.isStrNil(service) or
           XQFunction.isStrNil(domain) or
           XQFunction.isStrNil(username) or
           XQFunction.isStrNil(password) then
            return 1  -- 参数不完整
        end
    end
    
    -- 设置启用状态
    cursor:set("ddns", "myddns", "enabled", tostring(enabled))
    
    if enabled == 1 then
        -- 设置服务提供商
        cursor:set("ddns", "myddns", "service_name", service)
        
        -- 设置域名
        cursor:set("ddns", "myddns", "domain", domain)
        
        -- 设置用户名
        cursor:set("ddns", "myddns", "username", username)
        
        -- 设置密码
        cursor:set("ddns", "myddns", "password", password)
        
        -- 设置IP来源
        cursor:set("ddns", "myddns", "ip_source", "network")
        cursor:set("ddns", "myddns", "ip_network", "wan")
        
        -- 设置检查间隔
        cursor:set("ddns", "myddns", "check_interval", "10")
        cursor:set("ddns", "myddns", "check_unit", "minutes")
        
        -- 设置强制更新间隔
        cursor:set("ddns", "myddns", "force_interval", "72")
        cursor:set("ddns", "myddns", "force_unit", "hours")
    end
    
    -- 提交配置
    cursor:commit("ddns")
    
    -- 重启DDNS服务
    if enabled == 1 then
        XQFunction.forkExec("/etc/init.d/ddns restart")
    else
        XQFunction.forkExec("/etc/init.d/ddns stop")
    end
    
    return 0
end

--[[
  获取支持的DDNS服务提供商列表
  @return 服务提供商列表
]]
function getDDNSProviders()
    local providers = {
        {name = "dyndns.org", display = "DynDNS"},
        {name = "changeip.com", display = "ChangeIP"},
        {name = "zoneedit.com", display = "ZoneEdit"},
        {name = "free.editdns.net", display = "EditDNS"},
        {name = "freedns.afraid.org", display = "FreeDNS"},
        {name = "no-ip.com", display = "No-IP"},
        {name = "dnsomatic.com", display = "DNS-O-Matic"},
        {name = "3322.org", display = "3322.org"},
        {name = "oray.com", display = "花生壳(Oray)"},
        {name = "dnspod.cn", display = "DNSPod"},
        {name = "cloudflare.com", display = "Cloudflare"}
    }
    
    return providers
end

--[[
  检查DDNS状态
  @return 状态信息表 {status: 状态码, message: 状态消息, ip: 当前IP}
]]
function checkDDNSStatus()
    local result = {}
    local luciUtil = require("luci.util")
    
    -- 读取DDNS状态文件
    local statusFile = "/var/run/ddns/myddns.dat"
    local status = luciUtil.exec("cat " .. statusFile .. " 2>/dev/null")
    
    if status and #status > 0 then
        -- 解析状态信息
        for line in status:gmatch("[^\r\n]+") do
            local key, value = line:match("^(%w+)=(.*)$")
            if key and value then
                result[key] = value
            end
        end
    end
    
    -- 获取当前公网IP
    local ipCmd = "curl -s ifconfig.me 2>/dev/null || wget -qO- ifconfig.me 2>/dev/null"
    local currentIp = luciUtil.exec(ipCmd)
    if currentIp then
        result.current_ip = currentIp:gsub("%s+", "")
    end
    
    return result
end

--[[
  强制更新DDNS
  @return 0=成功
]]
function forceUpdateDDNS()
    XQFunction.forkExec("/etc/init.d/ddns restart")
    return 0
end
