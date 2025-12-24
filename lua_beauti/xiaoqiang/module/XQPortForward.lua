--[[
  小米路由器端口转发模块 (XQPortForward)
  功能: 管理端口转发规则、虚拟服务器(VS)、端口触发(PT)和ALG设置
  
  主要功能:
  - 端口转发规则的增删改查
  - 虚拟服务器规则管理
  - 端口触发规则管理
  - ALG (应用层网关) 配置
]]

module("xiaoqiang.module.XQPortForward", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- 错误码常量定义
ALL_NORMAL = 0           -- 正常
ERR_EMPTY = 1            -- 参数为空
ERR_CHECK_FAILED = 2     -- 检查失败
ERR_DMZ_ON = 3           -- DMZ已开启
ERR_RELATIVE = 4         -- 端口范围错误

--[[
  当LAN IP变更时更新端口转发规则中的目标IP
  @param newLanIp 新的LAN IP地址
  @param netmask 子网掩码
]]
function hookLanIPChangeEvent(newLanIp, netmask)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 根据子网掩码确定匹配模式
    local matchPattern = ".%d+$"
    if netmask == "255.255.0.0" then
        matchPattern = ".%d+.%d+$"
    end
    
    -- 提取新IP的网段前缀
    local newPrefix = newLanIp:gsub(matchPattern, "")
    
    -- 遍历所有redirect规则并更新目标IP
    cursor:foreach("firewall", "redirect", function(section)
        local forwardType = tonumber(section.ftype)
        if forwardType then
            local destIp = section.dest_ip
            local suffix = destIp:match(matchPattern)
            local newDestIp = newPrefix .. suffix
            cursor:set("firewall", section[".name"], "dest_ip", newDestIp)
        end
    end)
    
    cursor:commit("firewall")
end

--[[
  协议类型转换辅助函数
  数字转字符串: 1->tcp, 2->udp, 3->tcpudp
  字符串转数字: tcp->1, udp->2, tcpudp->3
  @param proto 协议(数字或字符串)
  @return 转换后的协议值
]]
function _protoHelper(proto)
    if proto then
        if type(proto) == "number" then
            if proto == 1 then
                return "tcp"
            elseif proto == 2 then
                return "udp"
            elseif proto == 3 then
                return "tcpudp"
            else
                return "tcp"
            end
        end
    end
    
    if proto then
        if type("proto") == "string" then
            if proto == "tcp" then
                return 1
            elseif proto == "udp" then
                return 2
            elseif proto == "tcpudp" then
                return 3
            else
                return 1
            end
        end
    end
    
    return nil
end

--[[
  检查端口是否有效(大于0的数字)
  @param port 端口号
  @return true/false
]]
function _portCheck(port)
    if port then
        if type(port) == "number" and port > 0 then
            return true
        end
    else
        return false
    end
end

--[[
  检查两个端口范围是否重叠
  @param portRange1 端口范围1 (如 "80" 或 "80-90")
  @param portRange2 端口范围2
  @return true表示重叠, false表示不重叠
]]
function _portRangeOverlap(portRange1, portRange2)
    local luciUtil = require("luci.util")
    
    if portRange1 and portRange2 then
        portRange1 = tostring(portRange1)
        portRange2 = tostring(portRange2)
        
        local range1 = {}
        local range2 = {}
        
        -- 解析第一个端口范围
        if portRange1:match("-") then
            local parts = luciUtil.split(portRange1, "-")
            range1.f = tonumber(parts[1])
            range1.t = tonumber(parts[2])
        else
            range1.f = tonumber(portRange1)
            range1.t = tonumber(portRange1)
        end
        
        -- 解析第二个端口范围
        if portRange2:match("-") then
            local parts = luciUtil.split(portRange2, "-")
            range2.f = tonumber(parts[1])
            range2.t = tonumber(parts[2])
        else
            range2.f = tonumber(portRange2)
            range2.t = tonumber(portRange2)
        end
        
        -- 检查是否重叠
        if (range1.f >= range2.f and range1.f <= range2.t) or
           (range1.t >= range2.f and range1.t <= range2.t) or
           (range1.t >= range2.t and range1.f <= range2.f) then
            return true
        end
    end
    
    return false
end

--[[
  检查端口是否与现有规则冲突
  @param srcPort 源端口
  @return true表示冲突
]]
function _portConflictCheck(srcPort)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local hasConflict = false
    
    cursor:foreach("firewall", "redirect", function(section)
        if _portRangeOverlap(srcPort, section.src_dport) then
            hasConflict = true
        end
    end)
    
    return hasConflict
end

--[[
  检查端口是否与现有规则冲突(考虑协议)
  @param srcPort 源端口
  @param proto 协议类型
  @return true表示冲突
]]
function _portConflictCheckWithProto(srcPort, proto)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local hasConflict = false
    
    cursor:foreach("firewall", "redirect", function(section)
        local sectionProto = _protoHelper(section.proto)
        -- 如果协议相同或任一方为tcpudp(3)则需要检查端口冲突
        if sectionProto == proto or proto == 3 or sectionProto == 3 then
            if _portRangeOverlap(srcPort, section.src_dport) then
                hasConflict = true
            end
        end
    end)
    
    return hasConflict
end

--[[
  检查端口转发模块是否已启用
  @return true/false
]]
function moduleOn()
    local rules = portForwards(0)
    return #rules > 0
end

--[[
  获取端口转发模块信息
  @return 状态信息表 {status: 0=关闭, 1=开启, 2=DMZ已开启}
]]
function portForwardInfo()
    local XQDMZModule = require("xiaoqiang.module.XQDMZModule")
    local result = {}
    
    if XQDMZModule.moduleOn() then
        result.status = 2
    else
        if moduleOn() then
            result.status = 1
        else
            result.status = 0
        end
    end
    
    return result
end

--[[
  获取端口转发规则列表
  @param filterType 过滤类型 (0=全部, 1=单端口, 2=端口范围)
  @return 规则列表
]]
function portForwards(filterType)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local rules = {}
    local typeFilter = tonumber(filterType) or 0
    
    cursor:foreach("firewall", "redirect", function(section)
        local ftype = tonumber(section.ftype)
        
        -- 如果filterType为0则显示所有,否则按类型过滤
        if typeFilter == 0 or typeFilter == ftype then
            local rule = {}
            rule.name = section.name
            rule.destip = section.dest_ip
            rule.proto = _protoHelper(section.proto) or 1
            
            if ftype == 1 then
                -- 单端口转发
                rule.srcport = tonumber(section.src_dport)
                rule.destport = section.dest_port
                rule.ftype = 1
            elseif ftype == 2 then
                -- 端口范围转发
                rule.ftype = 2
                local luciUtil = require("luci.util")
                local parts = luciUtil.split(section.src_dport, "-")
                rule.srcport = {
                    f = tonumber(parts[1]),
                    t = tonumber(parts[2])
                }
            end
            
            table.insert(rules, rule)
        end
    end)
    
    return rules
end

--[[
  设置单端口转发规则
  @param name 规则名称
  @param destIp 目标IP
  @param srcPort 源端口
  @param destPort 目标端口
  @param proto 协议类型
  @return 错误码 (0=成功, 1=参数错误, 2=端口冲突, 3=DMZ已开启)
]]
function setPortForward(name, destIp, srcPort, destPort, proto)
    -- 参数校验
    if XQFunction.isStrNil(destIp) then
        return 1
    end
    
    if not _portCheck(tonumber(srcPort)) then
        return 1
    end
    
    if not _portCheck(tonumber(destPort)) then
        return 1
    end
    
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 检查DMZ是否开启
    local info = portForwardInfo()
    if info.status == 2 then
        return 3
    end
    
    -- 检查端口冲突
    if _portConflictCheckWithProto(srcPort, proto) then
        return 2
    end
    
    -- 生成规则名称
    local sectionName = string.format("wan%srdr%s", tostring(srcPort), tostring(proto))
    
    -- 构建规则配置
    local config = {
        src = "wan",
        src_dport = srcPort,
        proto = _protoHelper(tonumber(proto)) or "tcp",
        target = "DNAT",
        dest = "lan",
        dest_port = destPort,
        dest_ip = destIp,
        ftype = 1,
        name = name or ""
    }
    
    -- 保存配置
    cursor:section("firewall", "redirect", sectionName, config)
    cursor:commit("firewall")
    
    return 0
end

--[[
  设置端口范围转发规则
  @param name 规则名称
  @param destIp 目标IP
  @param startPort 起始端口
  @param endPort 结束端口
  @param proto 协议类型
  @return 错误码
]]
function setRangePortForward(name, destIp, startPort, endPort, proto)
    -- 参数校验
    if XQFunction.isStrNil(destIp) then
        return 1
    end
    
    if not _portCheck(tonumber(startPort)) or not _portCheck(tonumber(endPort)) then
        return 1
    end
    
    -- 检查端口范围有效性
    if tonumber(startPort) > tonumber(endPort) then
        return 1
    end
    
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 构建端口范围字符串
    local portRange = tostring(startPort) .. "-" .. tostring(endPort)
    
    -- 检查DMZ是否开启
    local info = portForwardInfo()
    if info.status == 2 then
        return 3
    end
    
    -- 检查端口冲突
    if _portConflictCheckWithProto(portRange, proto) then
        return 2
    end
    
    -- 生成规则名称
    local sectionName = string.format("wan%srdr%s", tostring(startPort), tostring(proto))
    
    -- 构建规则配置
    local config = {
        src = "wan",
        src_dport = portRange,
        proto = _protoHelper(tonumber(proto)) or "tcp",
        target = "DNAT",
        dest = "lan",
        dest_ip = destIp,
        ftype = 2,
        name = name or ""
    }
    
    -- 保存配置
    cursor:section("firewall", "redirect", sectionName, config)
    cursor:commit("firewall")
    
    return 0
end

--[[
  删除端口转发规则
  @param srcPort 源端口
  @param proto 协议类型
  @return true/false
]]
function deletePortForward(srcPort, proto)
    if not _portCheck(tonumber(srcPort)) then
        return false
    end
    
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local sectionName = string.format("wan%srdr%s", tostring(srcPort), tostring(proto))
    cursor:delete("firewall", sectionName)
    cursor:commit("firewall")
    
    return true
end

--[[
  删除所有端口转发规则
  @return true
]]
function deleteAllPortForward()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    cursor:delete_all("firewall", "redirect", function(section)
        if section.ftype then
            return true
        else
            return false
        end
    end)
    
    cursor:commit("firewall")
    return true
end

--[[
  获取虚拟服务器(VS)规则列表
  @return 规则列表
]]
function VSInfo()
    local rules = {}
    local XQLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    cursor:foreach("firewall", "redirect", function(section)
        if section.app_name == "Virtual Server" then
            local rule = {}
            rule.name = section.name
            rule.service = section.service
            rule.protocol = protoToUpper(section.proto)
            rule.export = section.src_dport
            rule.inport = section.dest_port or section.dest_port
            rule.ip = section.dest_ip
            rule.web_del = (section.web_del == "0") and "0" or "1"
            table.insert(rules, rule)
        end
    end)
    
    return rules
end

--[[
  数字协议转字符串
  @param proto 协议数字
  @return 协议字符串
]]
function numberToProto(proto)
    if proto and type(proto) == "number" then
        if proto == 1 then
            return "tcp"
        elseif proto == 2 then
            return "udp"
        elseif proto == 3 then
            return "tcpudp"
        else
            return "tcp"
        end
    end
    return nil
end

--[[
  大写协议转小写
  @param proto 大写协议字符串
  @return 小写协议字符串
]]
function protoToLower(proto)
    if proto and type("proto") == "string" then
        if proto == "TCP" then
            return "tcp"
        elseif proto == "UDP" then
            return "udp"
        elseif proto == "ALL" then
            return "tcpudp"
        else
            return "tcp"
        end
    end
    return nil
end

--[[
  小写协议转大写
  @param proto 小写协议字符串
  @return 大写协议字符串
]]
function protoToUpper(proto)
    if proto and type("proto") == "string" then
        if proto == "tcp" then
            return "TCP"
        elseif proto == "udp" then
            return "UDP"
        elseif proto == "tcpudp" then
            return "ALL"
        else
            return "TCP"
        end
    end
    return nil
end

--[[
  虚拟服务器端口范围重叠检查
  @param portRange1 端口范围1
  @param portRange2 端口范围2
  @return true表示重叠
]]
function VS_portRangeOverlap(portRange1, portRange2)
    local luciUtil = require("luci.util")
    
    if portRange1 and portRange2 then
        portRange1 = tostring(portRange1)
        portRange2 = tostring(portRange2)
        
        local range1 = {}
        local range2 = {}
        
        -- 解析端口范围
        if portRange1:match("-") then
            local parts = luciUtil.split(portRange1, "-")
            range1.f = tonumber(parts[1])
            range1.t = tonumber(parts[2])
        else
            range1.f = tonumber(portRange1)
            range1.t = tonumber(portRange1)
        end
        
        if portRange2:match("-") then
            local parts = luciUtil.split(portRange2, "-")
            range2.f = tonumber(parts[1])
            range2.t = tonumber(parts[2])
        else
            range2.f = tonumber(portRange2)
            range2.t = tonumber(portRange2)
        end
        
        -- 检查重叠
        if (range1.f >= range2.f and range1.f <= range2.t) or
           (range1.t >= range2.f and range1.t <= range2.t) or
           (range1.t >= range2.t and range1.f <= range2.f) then
            return true
        end
    end
    
    return false
end

--[[
  虚拟服务器端口冲突检查(考虑协议)
  @param srcPort 源端口
  @param proto 协议
  @return true表示冲突
]]
function VSportConflictCheckWithProto(srcPort, proto)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local hasConflict = false
    
    cursor:foreach("firewall", "redirect", function(section)
        local sectionProto = section.proto
        local protoLower = protoToLower(proto)
        
        if sectionProto == protoLower or proto == "ALL" or sectionProto == "tcpudp" then
            if VS_portRangeOverlap(srcPort, section.src_dport) then
                hasConflict = true
            end
        end
    end)
    
    return hasConflict
end

--[[
  端口触发端口冲突检查(考虑协议)
  @param srcPort 源端口
  @param proto 协议
  @return true表示冲突
]]
function PTportConflictCheckWithProto(srcPort, proto)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local hasConflict = false
    
    cursor:foreach("firewall", "porttrigger", function(section)
        local sectionProto = section.proto
        local protoLower = protoToLower(proto)
        
        if sectionProto == protoLower or proto == "ALL" or sectionProto == "tcpudp" then
            if VS_portRangeOverlap(srcPort, section.src_dport) then
                hasConflict = true
            end
        end
    end)
    
    return hasConflict
end

--[[
  检查单个端口是否有效
  @param port 端口
  @return 错误码
]]
function checkOnePort(port)
    local datatypes = require("luci.cbi.datatypes")
    
    if XQFunction.isStrNil(port) then
        return ERR_EMPTY
    end
    
    if datatypes.port(port) then
        return ALL_NORMAL
    end
    
    return ERR_CHECK_FAILED
end

--[[
  检查端口或端口范围是否有效
  @param port 端口或端口范围
  @return 错误码
]]
function checkPort(port)
    local result = checkOnePort(port)
    
    if result < ERR_CHECK_FAILED then
        return result
    end
    
    -- 尝试解析端口范围
    local startPort, endPort = port:match("^(%d+)-(%d+)$")
    local startCheck = checkOnePort(startPort)
    local endCheck = checkOnePort(endPort)
    
    if startCheck == 0 and endCheck == 0 then
        if tonumber(startPort) >= tonumber(endPort) then
            return ERR_RELATIVE
        else
            return ALL_NORMAL
        end
    end
    
    return (startCheck > endCheck) and startCheck or endCheck
end

--[[
  设置虚拟服务器规则
  @param name 规则名称
  @param service 服务名称
  @param proto 协议
  @param exportPort 外部端口
  @param inportPort 内部端口
  @param destIp 目标IP
  @return 错误码
]]
function setVSRules(name, service, proto, exportPort, inportPort, destIp)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQDMZModule = require("xiaoqiang.module.XQDMZModule")
    
    -- 获取当前规则数量
    local ruleNum = tonumber(cursor:get("firewall", "vs", "rule_num") or "0")
    
    -- 检查DMZ是否开启
    if XQDMZModule.moduleOn() then
        return ERR_DMZ_ON
    end
    
    -- 检查端口有效性
    local portCheck = checkPort(exportPort)
    if portCheck ~= ALL_NORMAL then
        return portCheck
    end
    
    -- 参数校验
    if XQFunction.isStrNil(destIp) then
        return ERR_EMPTY
    end
    
    if not XQFirewall.checkPort(inportPort) then
        return ERR_EMPTY
    end
    
    -- 检查端口冲突
    if VSportConflictCheckWithProto(exportPort, proto) then
        return ERR_CHECK_FAILED
    end
    
    -- 生成规则名称
    local sectionName = string.format("vs%s_%s_%s", tostring(exportPort), tostring(inportPort), proto)
    sectionName = sectionName:gsub("-", "_")
    
    -- 构建规则配置
    local config = {
        src = "wan",
        target = "DNAT",
        dest = "lan",
        app_name = "Virtual Server",
        service = service or "",
        enabled = 1,
        name = name or "",
        proto = protoToLower(proto) or "tcp",
        src_dport = exportPort,
        dest_port = inportPort,
        dest_ip = destIp
    }
    
    -- 保存配置
    cursor:section("firewall", "redirect", sectionName, config)
    cursor:set("firewall", "vs", "rule_num", ruleNum + 1)
    cursor:commit("firewall")
    
    return ALL_NORMAL
end

--[[
  删除虚拟服务器规则
  @param sectionName 规则名称(可选)
  @param service 服务名称
  @param proto 协议
  @param exportPort 外部端口
  @param inportPort 内部端口
  @param destIp 目标IP
  @return true/false
]]
function deleteVSRule(sectionName, service, proto, exportPort, inportPort, destIp)
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local deleted = false
    
    local ruleNum = tonumber(cursor:get("firewall", "vs", "rule_num") or "0")
    
    -- 如果提供了section名称,直接删除
    local result = cursor:delete("firewall", sectionName)
    if result then
        cursor:set("firewall", "vs", "rule_num", ruleNum - 1)
        cursor:commit("firewall")
        deleted = true
    else
        -- 否则根据端口信息构建名称删除
        if XQFirewall.checkPort(exportPort) and XQFirewall.checkPort(inportPort) then
            local ruleName = string.format("vs%s_%s_%s", tostring(exportPort), tostring(inportPort), tostring(proto))
            ruleName = ruleName:gsub("-", "_")
            
            result = cursor:delete("firewall", ruleName)
            if result then
                cursor:set("firewall", "vs", "rule_num", ruleNum - 1)
                cursor:commit("firewall")
            end
            deleted = true
        end
    end
    
    return deleted
end

--[[
  检查虚拟服务器是否开启
  @return true/false
]]
function VSOn()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local ruleNum = cursor:get("firewall", "vs", "rule_num") or "0"
    ruleNum = tonumber(ruleNum)
    
    if ruleNum > 0 then
        local enabledCount = 0
        cursor:foreach("firewall", "redirect", function(section)
            if section[".name"] ~= "dmz" and section[".name"] ~= "dmzudp" then
                if section.enabled ~= "0" then
                    enabledCount = enabledCount + 1
                end
            end
        end)
        return enabledCount > 0
    else
        return false
    end
end

--[[
  检查端口触发是否开启
  @return true/false
]]
function PTOn()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local ruleNum = cursor:get("firewall", "pt", "rule_num") or "0"
    ruleNum = tonumber(ruleNum)
    
    return ruleNum > 0
end

--[[
  虚拟服务器端口检查(0-65535)
  @param port 端口号
  @return true/false
]]
function VS_portCheck(port)
    if port and type(port) == "number" and port > 0 and port < 65536 then
        return true
    else
        return false
    end
end

--[[
  检查是否超过最大虚拟服务器规则数量
  @param count 要添加的数量
  @return 0=未超过, 1=已超过
]]
function checkAddMaxVSNumItem(count)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local luciUtil = require("luci.util")
    
    local maxRuleNum = tonumber(cursor:get("firewall", "vs", "maxrulenum")) or 0
    local currentNum = tonumber(cursor:get("firewall", "vs", "rule_num") or "0")
    
    if maxRuleNum < currentNum then
        return 1
    end
    
    return 0
end

--[[
  检查是否超过最大端口触发规则数量
  @param data 规则数据
  @return 错误码
]]
function checkAddMaxPTNumItem(data)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local luciUtil = require("luci.util")
    
    local existingPorts = {}
    local dataLength = #data
    local newPorts = {}
    
    local maxRuleNum = tonumber(cursor:get("firewall", "pt", "maxrulenum")) or 0
    
    cursor:foreach("firewall", "porttrigger", function(section)
        if section.app_name == "Port Trigger" then
            table.insert(existingPorts, section.tgport)
        end
    end)
    
    if dataLength > 0 then
        local parts = luciUtil.split(data, ";")
        for _, part in ipairs(parts) do
            if #part > 0 then
                table.insert(newPorts, part)
            end
        end
    end
    
    local totalCount = #existingPorts + #newPorts
    if maxRuleNum < totalCount then
        return totalCount
    end
    
    return totalCount
end

--[[
  获取端口触发规则列表
  @return 规则列表
]]
function PTInfo()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local rules = {}
    
    cursor:foreach("firewall", "porttrigger", function(section)
        if section.app_name == "Port Trigger" then
            local rule = {}
            rule.name = section.name
            rule.tgprotocol = protoToUpper(section.tgprotocol)
            rule.exprotocol = protoToUpper(section.exprotocol)
            rule.tgport = tonumber(section.tgport)
            rule.export = tonumber(section.export)
            table.insert(rules, rule)
        end
    end)
    
    return rules
end

--[[
  设置端口触发规则
  @param name 规则名称
  @param tgProtocol 触发协议
  @param tgPort 触发端口
  @param exProtocol 外部协议
  @param exPort 外部端口
  @return 错误码 (0=成功, 1=参数错误, 2=端口冲突, 3=DMZ已开启)
]]
function setPTRules(name, tgProtocol, tgPort, exProtocol, exPort)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQDMZModule = require("xiaoqiang.module.XQDMZModule")
    
    local ruleNum = tonumber(cursor:get("firewall", "pt", "rule_num") or "0")
    
    -- 检查DMZ是否开启
    if XQDMZModule.moduleOn() then
        return 3
    end
    
    -- 参数校验
    if not XQFirewall.checkPort(tgPort) or not XQFirewall.checkPort(exPort) then
        return 1
    end
    
    -- 检查端口冲突
    if PTportConflictCheckWithProto(tgPort, tgProtocol) or PTportConflictCheckWithProto(exPort, exProtocol) then
        return 2
    end
    
    -- 生成规则名称
    local sectionName = string.format("pt%s_%s_%s_%s", tostring(tgPort), tostring(tgProtocol), tostring(exPort), tostring(exProtocol))
    sectionName = sectionName:gsub("-", "_")
    
    -- 构建规则配置
    local config = {
        src = "wan",
        target = "TRIGGER",
        dest = "lan",
        app_name = "Port Trigger",
        enabled = 1,
        name = name or "",
        tgprotocol = protoToLower(tgProtocol) or "tcp",
        exprotocol = protoToLower(exProtocol) or "tcp",
        export = exPort,
        tgport = tgPort
    }
    
    ruleNum = ruleNum + 1
    
    -- 保存配置
    cursor:section("firewall", "porttrigger", sectionName, config)
    cursor:set("firewall", "@defaults[0]", "port_trigger", "1")
    cursor:set("firewall", "pt", "rule_num", ruleNum)
    cursor:commit("firewall")
    
    return 0
end

--[[
  删除端口触发规则
  @param name 规则名称
  @param tgProtocol 触发协议
  @param tgPort 触发端口
  @param exProtocol 外部协议
  @param exPort 外部端口
  @return true/false
]]
function deletePTRule(name, tgProtocol, tgPort, exProtocol, exPort)
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local ruleNum = tonumber(cursor:get("firewall", "pt", "rule_num") or "0")
    
    if not XQFirewall.checkPort(exPort) or not XQFirewall.checkPort(tgPort) then
        return false
    end
    
    -- 生成规则名称
    local sectionName = string.format("pt%s_%s_%s_%s", tostring(tgPort), tostring(tgProtocol), tostring(exPort), tostring(exProtocol))
    sectionName = sectionName:gsub("-", "_")
    
    -- 删除规则
    cursor:delete("firewall", sectionName)
    ruleNum = ruleNum - 1
    cursor:set("firewall", "pt", "rule_num", ruleNum)
    cursor:commit("firewall")
    
    return true
end

--[[
  添加端口触发器规则到防火墙
  @param name 规则名称
  @param tgProtocol 触发协议
  @param tgPort 触发端口
  @param exProtocol 外部协议
  @param exPort 外部端口
]]
function trigger_add(name, tgProtocol, tgPort, exProtocol, exPort)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local sectionName = string.format("pt%s_%s_%s_%s", tostring(tgPort), tostring(tgProtocol), tostring(exPort), tostring(exProtocol))
    sectionName = sectionName:gsub("-", "_")
    
    local cmd = "/etc/firewall.d/firewall.trigger add" .. sectionName
    XQFunction.forkExec(cmd)
end

--[[
  从防火墙删除端口触发器规则
  @param name 规则名称
  @param tgProtocol 触发协议
  @param tgPort 触发端口
  @param exProtocol 外部协议
  @param exPort 外部端口
]]
function trigger_del(name, tgProtocol, tgPort, exProtocol, exPort)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local sectionName = string.format("pt%s_%s_%s_%s", tostring(tgPort), tostring(tgProtocol), tostring(exPort), tostring(exProtocol))
    sectionName = sectionName:gsub("-", "_")
    
    local cmd = "/etc/firewall.d/firewall.trigger del" .. sectionName
    XQFunction.forkExec(cmd)
end

--[[
  设置ALG(应用层网关)防火墙配置
  @param pptp PPTP穿透 (1=启用, 0=禁用)
  @param l2tp L2TP穿透
  @param ipsec IPSec穿透
  @param sip SIP穿透
  @param ftp FTP穿透
  @param tftp TFTP穿透
  @param rtsp RTSP穿透
  @param h323 H323穿透
]]
function setALGFirewall(pptp, l2tp, ipsec, sip, ftp, tftp, rtsp, h323)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 设置fw3_helper配置
    cursor:set("fw3_helper", "pptp", "enabled", pptp == 1 and "1" or "0")
    cursor:set("fw3_helper", "sip", "enabled", sip == 1 and "1" or "0")
    cursor:set("fw3_helper", "ftp", "enabled", ftp == 1 and "1" or "0")
    cursor:set("fw3_helper", "tftp", "enabled", tftp == 1 and "1" or "0")
    cursor:set("fw3_helper", "rtsp", "enabled", rtsp == 1 and "1" or "0")
    cursor:set("fw3_helper", "h323_ras", "enabled", h323 == 1 and "1" or "0")
    cursor:set("fw3_helper", "h323_Q931", "enabled", h323 == 1 and "1" or "0")
    cursor:commit("fw3_helper")
    
    -- 设置firewall basicset配置
    cursor:set("firewall", "basicset", "alg_pptp", pptp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_l2tp", l2tp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_ipsec", ipsec == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_sip", sip == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_ftp", ftp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_tftp", tftp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_rtsp", rtsp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_h323", h323 == 1 and "1" or "0")
    cursor:commit("firewall")
end

--[[
  获取ALG配置信息
  @return ALG配置表
]]
function ALGInfo()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local info = {}
    
    info.pptp = cursor:get("firewall", "basicset", "alg_pptp")
    info.l2tp = cursor:get("firewall", "basicset", "alg_l2tp")
    info.ipsec = cursor:get("firewall", "basicset", "alg_ipsec")
    info.sip = cursor:get("firewall", "basicset", "alg_sip")
    info.ftp = cursor:get("firewall", "basicset", "alg_ftp")
    info.tftp = cursor:get("firewall", "basicset", "alg_tftp")
    info.rtsp = cursor:get("firewall", "basicset", "alg_rtsp")
    info.h323 = cursor:get("firewall", "basicset", "alg_h323")
    
    return info
end
