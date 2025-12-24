--[[
  小米路由器多WAN策略模块 (XQMultiWanPolicy)
  功能: 管理多WAN口负载均衡和策略路由
  
  主要功能:
  - 多WAN负载均衡配置
  - 策略路由规则管理
  - WAN口优先级设置
  - 故障转移配置
]]

module("xiaoqiang.module.XQMultiWanPolicy", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- 负载均衡模式常量
BALANCE_MODE_WEIGHT = 1      -- 权重模式
BALANCE_MODE_FAILOVER = 2    -- 故障转移模式
BALANCE_MODE_POLICY = 3      -- 策略路由模式

--[[
  获取多WAN策略配置信息
  @return 配置信息表
]]
function getMultiWanInfo()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local result = {}
    
    -- 获取启用状态
    local enabled = cursor:get("mwan3", "globals", "enabled") or "0"
    result.enabled = tonumber(enabled)
    
    -- 获取负载均衡模式
    result.mode = tonumber(cursor:get("mwan3", "globals", "mode") or "1")
    
    -- 获取WAN接口列表
    result.interfaces = {}
    cursor:foreach("mwan3", "interface", function(section)
        local interface = {}
        interface.name = section[".name"]
        interface.enabled = section.enabled or "1"
        interface.weight = tonumber(section.weight or "1")
        interface.track_ip = section.track_ip or {}
        interface.track_method = section.track_method or "ping"
        interface.reliability = tonumber(section.reliability or "1")
        interface.count = tonumber(section.count or "1")
        interface.timeout = tonumber(section.timeout or "2")
        interface.interval = tonumber(section.interval or "5")
        interface.down = tonumber(section.down or "3")
        interface.up = tonumber(section.up or "3")
        table.insert(result.interfaces, interface)
    end)
    
    -- 获取策略规则
    result.rules = {}
    cursor:foreach("mwan3", "rule", function(section)
        local rule = {}
        rule.name = section[".name"]
        rule.src_ip = section.src_ip or ""
        rule.dest_ip = section.dest_ip or ""
        rule.proto = section.proto or "all"
        rule.src_port = section.src_port or ""
        rule.dest_port = section.dest_port or ""
        rule.use_policy = section.use_policy or ""
        table.insert(result.rules, rule)
    end)
    
    return result
end

--[[
  设置多WAN启用状态
  @param enabled 是否启用 (1=启用, 0=禁用)
  @return 0=成功
]]
function setMultiWanEnabled(enabled)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    cursor:set("mwan3", "globals", "enabled", tostring(enabled))
    cursor:commit("mwan3")
    
    -- 重启mwan3服务
    if enabled == 1 then
        XQFunction.forkExec("/etc/init.d/mwan3 restart")
    else
        XQFunction.forkExec("/etc/init.d/mwan3 stop")
    end
    
    return 0
end

--[[
  设置负载均衡模式
  @param mode 模式 (1=权重, 2=故障转移, 3=策略路由)
  @return 0=成功, 1=参数错误
]]
function setBalanceMode(mode)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    if mode < 1 or mode > 3 then
        return 1
    end
    
    cursor:set("mwan3", "globals", "mode", tostring(mode))
    cursor:commit("mwan3")
    
    -- 重启服务
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    
    return 0
end

--[[
  设置WAN接口权重
  @param interfaceName 接口名称
  @param weight 权重值 (1-100)
  @return 0=成功, 1=参数错误, 2=接口不存在
]]
function setInterfaceWeight(interfaceName, weight)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if XQFunction.isStrNil(interfaceName) then
        return 1
    end
    
    if weight < 1 or weight > 100 then
        return 1
    end
    
    -- 检查接口是否存在
    local exists = cursor:get("mwan3", interfaceName)
    if not exists then
        return 2
    end
    
    cursor:set("mwan3", interfaceName, "weight", tostring(weight))
    cursor:commit("mwan3")
    
    -- 重启服务
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    
    return 0
end

--[[
  添加策略路由规则
  @param ruleName 规则名称
  @param srcIp 源IP地址
  @param destIp 目标IP地址
  @param proto 协议 (tcp/udp/all)
  @param srcPort 源端口
  @param destPort 目标端口
  @param policy 使用的策略名称
  @return 0=成功, 1=参数错误
]]
function addPolicyRule(ruleName, srcIp, destIp, proto, srcPort, destPort, policy)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if XQFunction.isStrNil(ruleName) or XQFunction.isStrNil(policy) then
        return 1
    end
    
    -- 创建规则配置
    local config = {
        src_ip = srcIp or "",
        dest_ip = destIp or "",
        proto = proto or "all",
        src_port = srcPort or "",
        dest_port = destPort or "",
        use_policy = policy
    }
    
    cursor:section("mwan3", "rule", ruleName, config)
    cursor:commit("mwan3")
    
    -- 重启服务
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    
    return 0
end

--[[
  删除策略路由规则
  @param ruleName 规则名称
  @return 0=成功, 1=规则不存在
]]
function deletePolicyRule(ruleName)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 检查规则是否存在
    local exists = cursor:get("mwan3", ruleName)
    if not exists then
        return 1
    end
    
    cursor:delete("mwan3", ruleName)
    cursor:commit("mwan3")
    
    -- 重启服务
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    
    return 0
end

--[[
  获取WAN接口状态
  @return 接口状态列表
]]
function getInterfaceStatus()
    local luciUtil = require("luci.util")
    local result = {}
    
    -- 执行mwan3 status命令获取状态
    local statusOutput = luciUtil.exec("/usr/sbin/mwan3 status 2>/dev/null")
    
    if statusOutput and #statusOutput > 0 then
        -- 解析状态输出
        for line in statusOutput:gmatch("[^\r\n]+") do
            local interface, status = line:match("^interface (%w+) is (%w+)")
            if interface and status then
                table.insert(result, {
                    name = interface,
                    status = status
                })
            end
        end
    end
    
    return result
end

--[[
  设置接口健康检查参数
  @param interfaceName 接口名称
  @param trackIp 检测IP地址列表
  @param trackMethod 检测方法 (ping/arping/httping)
  @param interval 检测间隔(秒)
  @param timeout 超时时间(秒)
  @param reliability 可靠性阈值
  @return 0=成功, 1=参数错误, 2=接口不存在
]]
function setHealthCheck(interfaceName, trackIp, trackMethod, interval, timeout, reliability)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 参数校验
    if XQFunction.isStrNil(interfaceName) then
        return 1
    end
    
    -- 检查接口是否存在
    local exists = cursor:get("mwan3", interfaceName)
    if not exists then
        return 2
    end
    
    -- 设置检测参数
    if trackIp and type(trackIp) == "table" then
        cursor:set("mwan3", interfaceName, "track_ip", trackIp)
    end
    
    if trackMethod then
        cursor:set("mwan3", interfaceName, "track_method", trackMethod)
    end
    
    if interval then
        cursor:set("mwan3", interfaceName, "interval", tostring(interval))
    end
    
    if timeout then
        cursor:set("mwan3", interfaceName, "timeout", tostring(timeout))
    end
    
    if reliability then
        cursor:set("mwan3", interfaceName, "reliability", tostring(reliability))
    end
    
    cursor:commit("mwan3")
    
    -- 重启服务
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    
    return 0
end
