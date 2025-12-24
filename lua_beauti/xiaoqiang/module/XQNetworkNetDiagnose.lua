--[[
网络诊断模块 (XQNetworkNetDiagnose)
小米路由器网络故障诊断模块

功能说明:
- 执行网络诊断检测
- 获取诊断结果
- 获取DNS服务器IP
- 获取WAN口连接模式
- 异步网络诊断

错误码说明:
- 0: 网络正常
- 1: WAN口未插网线
- 2: DHCP无服务器响应
- 3: PPPoE无响应
- 4: DHCP上游冲突
- 5: 网关不可达
- 6: DNS解析失败
- 7: 自定义DNS设置问题
- 8: WiFi AP网关不可达
- 9: 有线AP网关不可达
- 10: 链路断开
- 11: WHC RE网关不可达
- 31: PPPoE会话数超限
- 32: PPPoE密码错误
- 33: PPPoE账号无效
- 34: PPPoE需要重置MAC
- 35: PPPoE被用户停止
- 99: 正在检测中

依赖模块:
- luci.util: LuCI工具函数
- xiaoqiang.common.XQFunction: 通用工具函数
- xiaoqiang.XQPreference: 偏好设置存储
]]

module("xiaoqiang.module.XQNetworkNetDiagnose", package.seeall)

local LuciUtil = require("luci.util")
local XQFunction = require("xiaoqiang.common.XQFunction")

NETTB = {
    ["1"] = "wan port unplug",
    ["2"] = "dhcp no server",
    ["3"] = "pppoe no reaponse",
    ["4"] = "dhcp upstream conflict",
    ["5"] = "gateway unreachable",
    ["6"] = "dns resolve failed",
    ["7"] = "dns custom set",
    ["8"] = "wifi_ap gateway unreachable",
    ["9"] = "wired_ap gateway unreachable",
    ["10"] = "link broken",
    ["11"] = "whc_re gateway unreachable",
    ["31"] = "pppoe no more sesson",
    ["32"] = "pppoe password error",
    ["33"] = "pppoe account not valid",
    ["34"] = "pppoe need reset mac",
    ["35"] = "pppoe stop by user"
}

function execl2(command)
    local pipe = io.popen(command)
    local line = ""
    local result = {}
    
    while true do
        line = pipe:read()
        if line == nil then
            break
        end
        result[#result + 1] = line
    end
    
    pipe:close()
    return result
end

function saveNettb(errorCode)
    local XQPreference = require("xiaoqiang.XQPreference")
    if errorCode then
        XQPreference.set("NETTB", errorCode)
    end
end

function getWanMode()
    local pipe = io.popen("uci -q get network.wan.proto")
    local wanProto = pipe:read("*line")
    pipe:close()
    return wanProto
end

function getDnsIp()
    local lines = execl2("cat /tmp/resolv.conf.auto")
    local dnsServers = nil
    
    if lines then
        if next(lines) ~= nil then
            local count = 0
            for _, line in ipairs(lines) do
                if count >= 2 then
                    break
                end
                
                local _, _, dnsIp = string.find(line, "nameserver ([0-9]+%.[0-9]+%.[0-9]+%.[0-9]+)")
                if dnsIp then
                    count = count + 1
                    if dnsServers then
                        dnsServers = dnsServers .. " " .. dnsIp
                    else
                        dnsServers = dnsIp
                    end
                end
            end
            
            if dnsServers then
                return dnsServers
            else
                return nil
            end
        end
    else
        return "0"
    end
end

function getNetDiagResult()
    local XQPreference = require("xiaoqiang.XQPreference")
    local errorCode = tonumber(XQPreference.get("NETTB"))
    
    if errorCode then
        if errorCode == 99 then
            return errorCode, "detecting..."
        elseif errorCode == 0 then
            return errorCode, "network ok!"
        else
            local errorMsg = NETTB[tostring(errorCode)]
            if errorMsg then
                return errorCode, errorMsg
            end
            return -1, "unknown nettb code!"
        end
    else
        return -2, "no diag result!"
    end
end

function asyncNetDiag()
    saveNettb("99")
    XQFunction.forkExec("lua /usr/sbin/do_net_diagose.lua")
end
