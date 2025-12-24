--[[
  小米路由器 - 网络拓扑模块
  功能: 获取和管理Mesh网络拓扑结构，包括主路由和子节点信息
  模块名: xiaoqiang.module.XQTopology
]]

module("xiaoqiang.module.XQTopology", package.seeall)

-- 引入依赖模块
local cjson = require("cjson")                                  -- JSON解析
local XQFunction = require("xiaoqiang.common.XQFunction")       -- 通用函数库
local XQConfigs = require("xiaoqiang.common.XQConfigs")         -- 配置模块
local luciUtil = require("luci.util")                           -- Luci工具库

--[[
  递归解析子节点信息
  @param nodeData 节点原始数据
  @return table 解析后的节点信息
]]
function _recursive(nodeData)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 构建节点信息表
    local nodeInfo = {}
    nodeInfo.ip = ""
    
    -- 获取路由器名称(优先使用router_name，其次hostname)
    local routerName = nodeData.router_name
    if not routerName then
        routerName = nodeData.hostname or ""
    end
    nodeInfo.name = routerName
    
    -- 地区信息
    nodeInfo.locale = nodeData.locale or ""
    
    -- 硬件和渠道信息
    nodeInfo.hardware = ""
    nodeInfo.channel = ""
    
    -- 工作模式(0=路由模式, 1=AP模式)
    nodeInfo.mode = tonumber(nodeData.is_ap or "0")
    
    -- 固件版本
    nodeInfo.version = nodeData.version or ""
    
    -- WiFi SSID
    nodeInfo.ssid = ""
    
    -- 信号强度颜色指示(默认100)
    nodeInfo.color = 100
    
    -- 检查是否支持新版拓扑
    local supportNewTopo = XQSysUtil.isSupportNewTopo()
    if supportNewTopo == 1 then
        -- 新版拓扑额外字段
        nodeInfo.signal = nodeData.signal or ""           -- 信号强度
        nodeInfo.link_type = nodeData.link_type or ""     -- 连接类型
        nodeInfo.internet = nodeData.internet or ""       -- 网络状态
        
        -- 如果有在线设备数，解码路由器名称
        if nodeData.onlines ~= nil then
            local decodedName = XQCryptoUtil.binaryBase64Dec(nodeData.router_name)
            nodeInfo.name = decodedName or ""
            nodeInfo.onlines = nodeData.onlines
        end
    end
    
    -- 处理小米中继器名称
    local lowerName = string.lower(nodeInfo.name)
    if lowerName:match("^xiaomirepeater") then
        nodeInfo.name = "小米中继器"
    end
    
    -- 解析description字段中的详细信息
    local description = nodeData.description
    local descData = nil
    
    local function parseDescription(descStr)
        descData = cjson.decode(descStr)
    end
    
    if not XQFunction.isStrNil(nodeData.description) then
        local success = pcall(parseDescription, nodeData.description)
        if success and descData then
            nodeInfo.hardware = descData.hardware
            nodeInfo.channel = descData.channel
            nodeInfo.color = descData.color
            nodeInfo.ssid = descData.ssid
            nodeInfo.ip = descData.ip
            nodeInfo.locale = descData.locale
        end
    end
    
    -- 解析IP地址列表
    local childNodes = {}
    
    if XQFunction.isStrNil(nodeInfo.ip) then
        if nodeData.ip_list then
            if #nodeData.ip_list > 0 then
                local ifname = nodeData.ifname or ""
                
                for _, ipInfo in ipairs(nodeData.ip_list) do
                    -- 检查无线连接状态
                    if ifname:match("wl") then
                        if not ifname:match("wl") then
                            goto continue
                        end
                        if tonumber(nodeData.assoc) ~= 1 then
                            goto continue
                        end
                    end
                    
                    -- 检查老化时间和流量
                    if ipInfo.ageing_timer <= 300 then
                        if ipInfo.tx_bytes == 0 and ipInfo.rx_bytes == 0 then
                            goto continue
                        end
                        nodeInfo.ip = ipInfo.ip
                        break
                    end
                    
                    ::continue::
                end
            end
        end
    end
    
    -- 递归处理子节点
    if nodeData.child then
        if #nodeData.child > 0 then
            local onlineDeviceCount = 0
            
            for _, childData in ipairs(nodeData.child) do
                if childData.is_ap ~= nil then
                    -- 子节点是AP设备
                    if childData.is_ap ~= 0 then
                        local childInfo = _recursive(childData)
                        table.insert(childNodes, childInfo)
                    end
                else
                    -- 子节点是普通设备
                    if childData.assoc ~= nil and childData.assoc ~= 0 then
                        onlineDeviceCount = onlineDeviceCount + 1
                    end
                end
            end
            
            -- 设置在线设备数(仅当没有子AP时)
            if #childNodes == 0 then
                nodeInfo.onlines = onlineDeviceCount
            end
            
            -- 设置子节点列表
            if #childNodes > 0 then
                nodeInfo.leafs = childNodes
            end
        end
    end
    
    return nodeInfo
end

--[[
  计算子节点数量(递归)
  @param nodeList 节点列表
  @return number 子节点总数
]]
local function _countLeafs(nodeList)
    local count = 0
    
    for _, node in ipairs(nodeList) do
        if node.mode == 1 then
            count = count + 1
        end
        
        if node.leafs then
            for _, leaf in ipairs(node.leafs) do
                if leaf.leafs then
                    count = count + _countLeafs(leaf.leafs)
                else
                    if leaf.mode == 1 then
                        count = count + 1
                    end
                end
            end
        end
    end
    
    return count
end

--[[
  获取Mesh子节点列表
  @return table 子节点列表
]]
function meshChildList()
    local result = {}
    
    -- 通过UBUS获取子节点列表
    local response = luciUtil.exec("ubus -t5 call xq_info_sync_mqtt child_list")
    
    if XQFunction.isStrNil(response) then
        return result
    end
    
    result = cjson.decode(response)
    return result
end

--[[
  获取完整的网络拓扑图
  @return table 拓扑信息，包含主路由和所有子节点
]]
function topologicalGraph()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取2.4G WiFi状态
    local wifiStatus = XQWifiUtil.getWifiStatus(1) or {}
    
    -- 是否为Mesh主节点
    local isMeshCap = false
    
    -- 构建主路由信息
    local mainRouter = {}
    mainRouter.ip = XQLanWanUtil.getLanIp()
    mainRouter.name = XQSysUtil.getRouterName()
    mainRouter.locale = XQSysUtil.getRouterLocale()
    mainRouter.hardware = XQSysUtil.getHardware()
    mainRouter.channel = XQSysUtil.getChannel()
    mainRouter.mode = XQFunction.getNetModeType()
    mainRouter.color = XQSysUtil.getColor()
    mainRouter.ssid = wifiStatus.ssid or ""
    
    -- 获取子节点信息
    local childListJson = ""
    local supportNewTopo = XQSysUtil.isSupportNewTopo()
    
    if supportNewTopo == 1 then
        -- 检查是否为Mesh主节点
        if XQFunction.isMeshCap() then
            -- 获取在线设备数
            local onlineCount = luciUtil.trim(luciUtil.exec("wc -l < /tmp/dhcp.leases") or "0")
            mainRouter.onlines = onlineCount
            
            -- 获取Mesh子节点列表
            childListJson = luciUtil.exec("ubus call xq_info_sync_mqtt child_list")
            isMeshCap = true
        end
    else
        -- 旧版拓扑获取方式
        childListJson = luciUtil.exec("ubus call trafficd hw '{\"tree\":true}'")
    end
    
    -- 解析子节点JSON
    if XQFunction.isStrNil(childListJson) then
        return mainRouter
    else
        childListJson = cjson.decode(childListJson)
    end
    
    -- 如果是Mesh主节点但没有子节点，尝试其他方式获取
    if isMeshCap and childListJson then
        if next(childListJson) == nil then
            childListJson = luciUtil.exec("ubus call trafficd hw '{\"tree\":true}'")
            
            if XQFunction.isStrNil(childListJson) then
                return mainRouter
            else
                childListJson = cjson.decode(childListJson)
            end
        end
    end
    
    -- 解析子节点
    local leafNodes = {}
    for _, childData in ipairs(childListJson) do
        if childData.is_ap ~= nil then
            if childData.is_ap ~= 0 then
                if childData.assoc ~= 0 then
                    local nodeInfo = _recursive(childData)
                    table.insert(leafNodes, nodeInfo)
                end
            end
        end
    end
    
    -- 设置子节点列表
    if #leafNodes > 0 then
        mainRouter.leafs = leafNodes
        
        -- 计算子节点的子节点数量
        for _, leaf in ipairs(leafNodes) do
            if leaf.mode == 1 and leaf.leafs then
                local subCount = _countLeafs(leaf.leafs)
                -- 可以在这里设置子节点数量
            end
        end
    end
    
    -- 设置重编号标记
    mainRouter.renumber = 0
    
    return mainRouter
end

--[[
  简化的递归解析(仅获取MAC地址)
  @param nodeData 节点原始数据
  @return table|nil 节点信息或nil
]]
function _simpleRecursive(nodeData)
    local nodeInfo = {}
    
    -- 格式化MAC地址
    nodeInfo.mac = XQFunction.macFormat(nodeData.hw)
    nodeInfo.mac5G = ""
    
    -- 检查description是否存在
    if XQFunction.isStrNil(nodeData.description) then
        return nil
    end
    
    -- 解析description
    local success, descData = pcall(cjson.decode, nodeData.description)
    
    if success and descData then
        -- 检查硬件类型
        if not descData.hardware then
            goto valid
        end
        
        local hwLower = string.lower(descData.hardware)
        if hwLower == "r01" then
            goto valid
        end
        
        if not XQFunction.isStrNil(descData.bssid1) then
            goto valid
        end
    end
    
    return nil
    
    ::valid::
    
    -- 设置BSSID
    if not XQFunction.isStrNil(descData.bssid1) then
        nodeInfo.mac = descData.bssid1
    end
    
    if not XQFunction.isStrNil(descData.bssid2) then
        nodeInfo.mac5G = descData.bssid2
    end
    
    -- 处理R01型号的特殊情况
    if descData.hardware then
        local hwLower = string.lower(descData.hardware)
        if hwLower == "r01" then
            if XQFunction.isStrNil(descData.bssid1) then
                nodeInfo.needConvert = true
            else
                nodeInfo.mac = XQFunction.macFormat(descData.bssid1)
            end
        end
    end
    
    -- 解析IP列表
    local childNodes = {}
    
    if nodeData.ip_list and #nodeData.ip_list > 0 then
        local ifname = nodeData.ifname or ""
        
        for _, ipInfo in ipairs(nodeData.ip_list) do
            -- 检查无线连接
            if ifname:match("wl") then
                if not ifname:match("wl") then
                    goto skip
                end
                if tonumber(nodeData.assoc) ~= 1 then
                    goto skip
                end
            end
            
            -- 检查老化时间和流量
            if ipInfo.ageing_timer <= 300 then
                if ipInfo.tx_bytes ~= 0 or ipInfo.rx_bytes ~= 0 then
                    break
                end
            end
            
            ::skip::
        end
    end
    
    -- 递归处理子节点
    if nodeData.child and #nodeData.child > 0 then
        for _, childData in ipairs(nodeData.child) do
            if childData.is_ap ~= nil and childData.is_ap ~= 0 then
                local childInfo = _simpleRecursive(childData)
                if childInfo then
                    table.insert(childNodes, childInfo)
                end
            end
        end
        
        if #childNodes > 0 then
            nodeInfo.leafs = childNodes
        end
    end
    
    return nodeInfo
end

--[[
  获取简化的拓扑图(仅包含MAC地址信息)
  @return table 简化的拓扑信息
]]
function simpleTopoGraph()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 获取主路由的BSSID
    local bssid24G, bssid5G = XQWifiUtil.getWifiBssid()
    
    local mainRouter = {}
    mainRouter.mac = bssid24G
    mainRouter.mac5G = bssid5G or ""
    
    -- 获取子节点信息
    local childListJson = luciUtil.exec("ubus call trafficd hw '{\"tree\":true}'")
    
    if XQFunction.isStrNil(childListJson) then
        return mainRouter
    else
        childListJson = cjson.decode(childListJson)
    end
    
    -- 解析子节点
    local leafNodes = {}
    for _, childData in ipairs(childListJson) do
        if childData.is_ap ~= nil and childData.is_ap ~= 0 then
            local nodeInfo = _simpleRecursive(childData)
            if nodeInfo then
                table.insert(leafNodes, nodeInfo)
            end
        end
    end
    
    if #leafNodes > 0 then
        mainRouter.leafs = leafNodes
    end
    
    return mainRouter
end
