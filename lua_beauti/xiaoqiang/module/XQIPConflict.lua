--[[
IP冲突检测模块 (XQIPConflict)
小米路由器IP地址冲突检测和解决模块

功能说明:
- 检测WAN口IP地址冲突
- 解决LAN口IP冲突
- 解决WAN口IP冲突
- 检查LAN和WAN之间的IP冲突

工作原理:
- 通过 /usr/sbin/ip_conflict.sh 脚本执行实际检测
- 检测到冲突时自动修改IP地址
- 触发lanIPChange事件通知系统

依赖模块:
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.module.XQMessageBox: 消息盒子模块
- xiaoqiang.XQEvent: 事件系统
- xiaoqiang.XQLog: 日志模块
- luci.util: LuCI工具函数
- luci.model.uci: UCI配置管理
]]

module("xiaoqiang.module.XQIPConflict", package.seeall)

function ip_conflict_detection()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local netModeType = XQFunction.getNetModeType()
    if netModeType ~= 0 then
        return false
    end
    
    local LuciUtil = require("luci.util")
    
    local conflictIp = string.gsub(
        LuciUtil.exec("/usr/sbin/ip_conflict.sh wan"),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",
        "%1"
    )
    
    if XQFunction.isStrNil(conflictIp) or conflictIp == "0.0.0.0" then
        return false
    end
    
    return conflictIp
end

function lan_ip_conflict_resolution()
    os.execute("/usr/sbin/ip_conflict.sh br-lan")
end

function ip_conflict_resolution()
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    local XQEvent = require("xiaoqiang.XQEvent")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local LuciUtil = require("luci.util")
    
    local newLanIp = string.gsub(
        LuciUtil.exec("/usr/sbin/ip_conflict.sh wan modify"),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",
        "%1"
    )
    
    if not XQFunction.isStrNil(newLanIp) and newLanIp ~= "0.0.0.0" then
        XQMessageBox.removeMessage(4)
        
        local uci = require("luci.model.uci").cursor()
        local netmask = uci:get("network", "lan", "netmask") or "255.255.255.0"
        
        XQEvent.lanIPChange(newLanIp, netmask, netmask)
        
        return true
    end
    
    return false
end

function lan_wan_ip_conflict_chk(lanIp, wanIp)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQLog = require("xiaoqiang.XQLog")
    local LuciUtil = require("luci.util")
    
    local checkCmd = "/usr/sbin/ip_conflict.sh br-lan check"
    local formattedLanIp = XQFunction._strformat(lanIp)
    local formattedWanIp = XQFunction._strformat(wanIp)
    
    checkCmd = checkCmd .. " " .. formattedLanIp .. " " .. formattedWanIp
    
    local result = string.gsub(
        LuciUtil.exec(checkCmd),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",
        "%1"
    )
    
    if not XQFunction.isStrNil(result) then
        XQLog.log(6, "lan_wan_ip_conflict_chk: " .. result)
    end
    
    if XQFunction.isStrNil(result) or result == "0" then
        return false
    end
    
    return true
end
