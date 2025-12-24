--[[
小米网络检测API控制器模块 (XQ Network Detect API Controller)
提供网络检测和诊断相关的API接口，包括：
- WAN状态检测
- 系统信息获取
- 网络连通性测试
- 系统诊断
- 网速测试
- 网络故障排查

路径: /api/xqnetdetect/*
认证: jsonauth (需要admin权限)
]]

module("luci.controller.api.xqnetdetect", package.seeall)

local http = require("luci.http")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

--[[
路由注册入口函数
注册所有网络检测相关的API端点
]]
function index()
    local apiNode = node("api", "xqnetdetect")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 350
    apiNode.sysauth = "admin"
    apiNode.sysauth_authenticator = "jsonauth"
    apiNode.index = true
    
    entry({"api", "xqnetdetect"}, firstchild(), _(""), 350)
    
    -- 网络故障排查API
    entry({"api", "xqnetdetect", "nettb"}, call("nettb"), "", 359, 1)
    entry({"api", "xqnetdetect", "nettb2"}, call("nettb2"), "", 360, 1)
end

--[[
获取WAN状态
获取WAN口连接状态、类型和监控信息

@return JSON WAN状态信息
]]
function getWanStatus()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    
    -- 获取自动检测的WAN类型
    local wanType = XQLanWanUtil.getAutoWanType()
    -- 获取WAN口详细信息
    local wanInfo = XQLanWanUtil.getLanWanInfo("wan")
    -- 获取WAN监控状态
    local wanMonitor = XQLanWanUtil.getWanMonitorStat()
    
    result.code = 0
    -- 99表示未连接
    result.wanLink = (wanType == 99) and 0 or 1
    result.wanType = wanType
    result.wanInfo = wanInfo
    result.wanMonitor = wanMonitor
    
    http.write_json(result)
end

--[[
获取系统信息
获取CPU和内存使用情况

@return JSON 系统信息
]]
function getSysInfo()
    local luciSys = require("luci.sys")
    local result = {}
    local cpuInfo = {}
    local memInfo = {}
    
    -- 获取系统信息
    local sysInfo, _, memTotal, _, _, memFree = luciSys.sysinfo()
    
    cpuInfo.info = sysInfo
    memInfo.total = memTotal
    memInfo.free = memFree
    
    result.code = 0
    result.cpuInfo = cpuInfo
    result.memInfo = memInfo
    
    http.write_json(result)
end

--[[
Ping测试
测试指定URL的网络连通性

@param url string 测试目标URL
@return JSON 测试结果 (result: 1=成功, 0=失败)
]]
function pingTest()
    local luciSys = require("luci.sys")
    
    local url = http.formvalue("url")
    local pingResult = luciSys.net.pingtest(url)
    
    local result = { code = 0 }
    -- pingtest返回0表示成功
    result.result = (pingResult == 0) and 1 or 0
    
    http.write_json(result)
end

--[[
系统诊断
执行全面的系统和网络诊断

检测项目:
- CPU温度 (>70°C 异常)
- CPU负载 (>90% 异常)
- 内存使用 (>90% 异常)
- WAN连接状态
- WAN类型
- 网关丢包率 (>80% 异常)
- DNS状态
- Ping丢包率 (>80% 异常)
- WiFi密码安全性

@param simple number 简化模式(可选)
@param target string 测试目标(可选)
@return JSON 诊断结果
]]
function systemDiagnostics()
    local XQLog = require("xiaoqiang.XQLog")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取网络流量统计
    local lanStats = XQDeviceUtil.getWanLanNetworkStatistics("lan")
    local wanStats = XQDeviceUtil.getWanLanNetworkStatistics("wan")
    
    local speedInfo = {
        lan = tonumber(lanStats.downspeed),
        wan = tonumber(wanStats.downspeed)
    }
    
    local simple = tonumber(http.formvalue("simple") or 0)
    local target = http.formvalue("target")
    
    local result = {}
    local code = 0
    local status = 0  -- 0=正常, 1=警告, 2=错误
    local errorCount = 0
    
    -- 获取CPU温度
    local cpuTemp = XQSysUtil.getCpuTemperature()
    
    -- 执行网络检测
    local detectInfo = XQSysUtil.getNetworkDetectInfo(simple, target)
    
    -- 更新检测时间戳
    XQSysUtil.setDetectionTimestamp()
    
    -- 获取所有WiFi信息
    local wifiList = XQWifiUtil.getAllWifiInfo()
    
    -- 检查WiFi密码安全性
    local sameAsAdmin = false
    local strongPassword = true
    local wifiSecurity = {}
    
    for _, wifi in ipairs(wifiList) do
        -- 检查是否与管理员密码相同
        if XQSecureUtil.checkPlaintextPwd("admin", wifi.password) then
            sameAsAdmin = true
        end
        -- 检查密码强度
        if XQSecureUtil.checkStrong(wifi.password) < 2 then
            strongPassword = false
        end
    end
    
    wifiSecurity.same = sameAsAdmin and 1 or 0
    wifiSecurity.strong = strongPassword and 1 or 0
    
    -- 处理磁盘信息
    local diskInfo = {}
    if detectInfo and detectInfo.disk then
        local diskFree = tonumber(detectInfo.disk.free)
        local diskCapacity = tonumber(detectInfo.disk.capacity)
        if diskCapacity and diskCapacity > 0 then
            diskInfo.Used = string.format("%.3fG", (diskCapacity - diskFree) / 1073741824)
            diskInfo.Available = string.format("%.3fG", diskFree / 1073741824)
        end
    end
    
    if detectInfo then
        -- CPU温度检测
        local cpuTempResult = { temperature = cpuTemp }
        if cpuTemp > 70 then
            errorCount = errorCount + 1
            status = 1
            cpuTempResult.status = 0
        else
            cpuTempResult.status = 1
        end
        
        -- CPU负载检测
        local cpuLoadResult = { loadavg = detectInfo.cpu }
        if tonumber(detectInfo.cpu) > 90 then
            errorCount = errorCount + 1
            status = 1
            cpuLoadResult.status = 0
        else
            cpuLoadResult.status = 1
        end
        
        -- 内存使用检测
        local memResult = { use = detectInfo.memory }
        if tonumber(detectInfo.memory) > 90 then
            errorCount = errorCount + 1
            status = 1
            memResult.status = 0
        else
            memResult.status = 1
        end
        
        -- WAN连接检测
        local linkResult = {}
        if detectInfo.wanLink ~= 1 then
            errorCount = errorCount + 1
            status = 2
            linkResult.status = 0
        else
            linkResult.status = 1
        end
        
        -- WAN类型检测
        local wanResult = { type = detectInfo.wanType }
        if tonumber(detectInfo.wanLink) ~= 1 then
            errorCount = errorCount + 1
            status = 2
            wanResult.status = 0
        else
            wanResult.status = 1
        end
        
        -- 网关丢包检测
        local gatewayResult = { lost = detectInfo.gw }
        if tonumber(detectInfo.gw) > 80 then
            errorCount = errorCount + 1
            status = 1
            gatewayResult.status = 0
        else
            gatewayResult.status = 1
        end
        
        -- DNS检测
        local dnsResult = {}
        if tonumber(detectInfo.dns) ~= 1 then
            errorCount = errorCount + 1
            status = 2
            dnsResult.status = 0
        else
            dnsResult.status = 1
        end
        
        -- Ping丢包检测
        local pingResult = { lost = detectInfo.pingLost }
        if tonumber(detectInfo.pingLost) > 80 then
            errorCount = errorCount + 1
            status = 2
            pingResult.status = 0
        else
            pingResult.status = 1
        end
        
        -- 组装结果
        result = detectInfo
        result.count = errorCount
        result.status = status
        result.cpuavg = cpuLoadResult
        result.memoryuse = memResult
        result.cputemp = cpuTempResult
        result.link = linkResult
        result.wan = wanResult
        result.gateway = gatewayResult
        result.dnsstatus = dnsResult
        result.ping = pingResult
        result.cpuTemperature = cpuTemp
        result.wifi = wifiSecurity
        result.speed = speedInfo
        result.disk = diskInfo
        
        -- 记录检测错误日志
        if errorCount > 0 then
            XQLog.check(0, XQLog.KEY_DETECT_ERROR, 1)
        end
    else
        code = 1567
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    else
        -- 推送网速信息
        local XQPushHelper = require("xiaoqiang.XQPushHelper")
        local pushData = {
            type = 6,
            data = {
                lan = speedInfo.lan,
                wan = speedInfo.wan
            }
        }
        XQPushHelper.push_request(require("json").encode(pushData))
    end
    
    result.code = code
    http.write_json(result)
end

--[[
系统状态快速检查
快速检查系统关键指标

@return JSON 状态信息 (status: 0=正常, 1=警告, 2=错误)
]]
function systemStatus()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    local errorCount = 0
    local result = {}
    
    local sysStatus = XQSysUtil.checkSystemStatus()
    
    result.code = 0
    result.status = 0
    
    -- CPU负载检查
    if sysStatus.cpu and sysStatus.cpu > 90 then
        errorCount = errorCount + 1
        result.status = 1
    end
    
    -- 内存使用检查
    if sysStatus.mem and sysStatus.mem > 90 then
        errorCount = errorCount + 1
        result.status = 1
    end
    
    -- CPU温度检查
    if sysStatus.tmp and sysStatus.tmp > 70 then
        errorCount = errorCount + 1
        result.status = 1
    end
    
    -- WAN连接检查
    if not sysStatus.wan or not sysStatus.link then
        errorCount = errorCount + 1
        result.status = 2
    end
    
    result.count = errorCount
    http.write_json(result)
end

--[[
网速测试
测试下载带宽

@param history boolean 是否获取历史记录
@return JSON 网速测试结果
]]
function netspeed()
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQNetworkSpeedTest = require("xiaoqiang.module.XQNetworkSpeedTest")
    
    local code = 0
    local result = {}
    
    local history = http.formvalue("history")
    
    if history then
        -- 获取历史记录
        result.bandwidth = tonumber(XQPreference.get("BANDWIDTH", 0, "xiaoqiang"))
        result.download = tonumber(string.format("%.2f", result.bandwidth * 128))
        result.bandwidth2 = tonumber(XQPreference.get("BANDWIDTH2", 0, "xiaoqiang"))
        result.upload = tonumber(string.format("%.2f", result.bandwidth2 * 128))
    else
        -- 执行实时测速
        -- 停止QoS以获得准确结果
        os.execute("/etc/init.d/miqos stop")
        
        local downloadSpeed = XQNetworkSpeedTest.downloadSpeedTest()
        
        if downloadSpeed then
            result.download = downloadSpeed
            result.bandwidth = tonumber(string.format("%.2f", downloadSpeed * 8 / 1024))
            XQPreference.set("BANDWIDTH", tostring(result.bandwidth), "xiaoqiang")
        else
            code = 1588
        end
        
        if code ~= 0 then
            result.msg = XQErrorUtil.getErrorMessage(code)
        end
        
        -- 恢复QoS
        os.execute("/etc/init.d/miqos start")
    end
    
    result.code = code
    http.write_json(result)
end

--[[
上传速度测试
测试上传带宽

@return JSON 上传速度测试结果
]]
function uploadSpeed()
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQNetworkSpeedTest = require("xiaoqiang.module.XQNetworkSpeedTest")
    
    -- 停止QoS以获得准确结果
    os.execute("/etc/init.d/miqos stop")
    
    local code = 0
    local result = {}
    
    local uploadSpeedResult = XQNetworkSpeedTest.uploadSpeedTest()
    
    if uploadSpeedResult then
        result.upload = uploadSpeedResult
        result.bandwidth = tonumber(string.format("%.2f", uploadSpeedResult * 8 / 1024))
        XQPreference.set("BANDWIDTH2", tostring(result.bandwidth), "xiaoqiang")
    else
        code = 1588
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    -- 恢复QoS
    os.execute("/etc/init.d/miqos start")
    
    result.code = code
    http.write_json(result)
end

--[[
网络故障排查(单WAN)
API: /api/xqnetdetect/nettb

@return JSON 故障排查结果
]]
function nettb()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local result = {
        code = 0,
        error = 0
    }
    
    local nettbResult = XQSysUtil.nettb()
    
    if nettbResult.code ~= 0 then
        result.error = nettbResult.code
        result.reason = nettbResult.reason
    end
    
    http.write_json(result)
end

--[[
获取IPv6接口名称
根据WAN接口名获取对应的IPv6接口

@param wanName string WAN接口名称
@return string IPv6接口名称或nil
]]
function getIPv6Name(wanName)
    local luciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    
    if not wanName then
        return nil
    end
    
    -- 解析WAN名称后缀
    local parts = luciUtil.split(wanName, "_")
    local suffix = parts[2]
    
    -- 构建IPv6接口名
    local wan6Name = "wan6"
    if suffix then
        wan6Name = wan6Name .. "_" .. suffix
    end
    
    -- 检查IPv6接口是否存在且启用
    local proto = uci:get("network", wan6Name, "proto")
    local disabled = tonumber(uci:get("network", wan6Name, "disabled") or 0)
    
    if proto and disabled == 0 then
        return wan6Name
    else
        return nil
    end
end

--[[
获取网络故障排查结果
比较IPv4和IPv6的检测结果，返回较好的一个

@param wan4Name string IPv4 WAN名称
@param wan4Result table IPv4检测结果
@param wan6Name string IPv6 WAN名称
@param wan6Result table IPv6检测结果
@return string, number 最佳WAN名称和错误码
]]
function getNettbRes(wan4Name, wan4Result, wan6Name, wan6Result)
    if not wan4Name or not wan4Result then
        return nil, nil
    end
    
    if not wan6Name or not wan6Result then
        return wan4Name, wan4Result.code
    end
    
    local bestName, bestCode
    
    if wan6Result.code == 0 then
        bestName = wan6Name
        bestCode = wan6Result.code
    else
        -- 选择错误码较小的结果
        if wan4Result.code >= wan6Result.code then
            bestName = wan4Name
            bestCode = wan4Result.code
        else
            bestName = wan6Name
            bestCode = wan6Result.code
        end
    end
    
    return bestName, bestCode
end

--[[
网络故障排查(多WAN)
API: /api/xqnetdetect/nettb2
支持多WAN口和IPv6的故障排查

@return JSON 所有WAN口的故障排查结果
]]
function nettb2()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQMultiWanPolicy = require("xiaoqiang.module.XQMultiWanPolicy")
    local uci = require("luci.model.uci").cursor()
    local luciUtil = require("luci.util")
    
    local wanResults = {}
    local result = { code = 0 }
    
    -- 获取多WAN状态
    result.on = XQMultiWanPolicy.getStatus()
    
    -- 遍历所有网络接口
    uci:foreach("network", "interface", function(section)
        local wanInfo = {}
        local ifName = section[".name"] or ""
        local wanType = section.wantype or ""
        local disabled = tonumber(section.disabled or 0)
        local prefix = string.sub(ifName, 1, 4)
        
        -- 检查WAN口专用状态
        local wandt = 0
        local wanEnable = 0
        
        if ifName == "wan" then
            wandt = tonumber(uci:get("port_service", "wan", "wandt") or 0)
            wanEnable = tonumber(uci:get("port_service", "wan", "enable") or 0)
        end
        
        -- 处理WAN接口
        if prefix == "wan_" or (ifName == "wan" and (wandt == 1 or wanEnable == 1)) then
            -- 检查是否为IPv4专用
            local dedicated = tonumber(luciUtil.exec(
                ". /lib/miwifi/miwifi_functions.sh;util_network_dedicated_get \"ipv4\" " .. ifName
            ))
            
            if dedicated == 0 then
                -- 设置WAN名称
                if ifName == "wan" then
                    wanInfo.wanname = "WAN1"
                elseif ifName == "wan_2" then
                    wanInfo.wanname = "WAN2"
                end
                
                -- 执行故障排查
                local nettbResult = XQSysUtil.nettb2(ifName)
                
                wanInfo.disabled = disabled
                wanInfo.name = ifName
                wanInfo.wantype = wanType
                wanInfo.error = nettbResult.code
                
                -- 如果IPv4检测失败，尝试IPv6
                if nettbResult.code ~= 0 then
                    local wan6Name = getIPv6Name(ifName)
                    if wan6Name then
                        local wan6Result = XQSysUtil.nettb2(wan6Name)
                        local bestName, bestCode = getNettbRes(ifName, nettbResult, wan6Name, wan6Result)
                        wanInfo.name = bestName
                        wanInfo.error = bestCode
                    end
                end
                
                table.insert(wanResults, wanInfo)
            end
        end
    end)
    
    -- 按WAN名称排序
    table.sort(wanResults, function(a, b)
        return a.wanname < b.wanname
    end)
    
    result.info = wanResults
    http.write_json(result)
end
