--[[
  小米路由器专用无线回程工具模块 (DWB - Dedicated Wireless Backhaul)
  
  功能说明:
  - Mesh网络专用无线回程管理
  - DWB频段配置和状态管理
  - 支持Mesh主节点和子节点
  - SSID同步管理
  
  DWB概念:
  - 专用无线回程是Mesh网络中用于节点间通信的专用WiFi频段
  - 与用户连接的WiFi频段分离，提高网络性能
  - 通常使用5GHz高频段作为回程通道
  
  主要函数:
  - is_supported(): 检查是否支持DWB
  - mesh_get_dwb_band(): 获取DWB使用的频段
  - mesh_get_dwb_status(): 获取DWB状态
  - mesh_set_dwb_status(): 设置DWB状态
  - mesh_get_dwb_type(): 获取DWB连接类型
]]

module("xiaoqiang.util.DedicatedWirelessBackhaulUtil", package.seeall)

local uci = require("luci.model.uci").cursor()
local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
local network = require("luci.model.network")

local wlan_ifnames = XQWifiUtil.get_wlan_ifname()
local dwb_ifname = uci:get("misc", "wireless", "ifname_dwb")

-- 检查是否支持专用无线回程
-- @return boolean 是否支持DWB
function is_supported()
    if dwb_ifname then
        return true
    else
        return false
    end
end

-- 获取DWB使用的频段编号
-- @return number 频段编号 (2=5GHz, 3=5GHz高频), 0表示未找到
function mesh_get_dwb_band()
    if wlan_ifnames == nil or #wlan_ifnames == 0 then
        return 0
    end
    
    for i = 1, #wlan_ifnames do
        if wlan_ifnames[i] == dwb_ifname then
            return i
        end
    end
    
    return 0
end

-- 获取DWB的WiFi网络接口对象
-- @return wifinet DWB网络接口对象，失败返回nil
function get_dwb_wifinet()
    if dwb_ifname == nil or string.len(dwb_ifname) == 0 then
        return nil
    end
    
    local ntm = network.init()
    local wifinet = ntm:get_wifinet(dwb_ifname)
    
    return wifinet
end

-- 设置DWB状态
-- @param status 状态值 ("0"=禁用, "1"=启用)
-- @return number -1表示失败
function mesh_set_dwb_status(status)
    if status == nil then
        return -1
    end
    
    local wifinet = get_dwb_wifinet()
    if wifinet == nil then
        return -1
    end
    
    wifinet:set("dwb_status", status)
    uci:save("wireless")
    uci:commit("wireless")
end

-- 获取DWB状态
-- @return string "0"=禁用, "1"=启用, nil表示不支持
function mesh_get_dwb_status()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local wifinet = get_dwb_wifinet()
    local status = "0"
    
    if wifinet == nil then
        return nil
    end
    
    -- Mesh子节点(RE)的DWB状态取决于接口是否禁用
    if XQFunction.isMeshRe() then
        local disabled = wifinet:get("disabled") or disabled
        if disabled ~= "1" then
            status = "1"
        else
            status = "0"
        end
    else
        -- Mesh主节点直接读取dwb_status配置
        status = wifinet:get("dwb_status")
    end
    
    return status
end

-- 设置DWB SSID变更标志
-- @param flag 标志值 ("0"=未变更, "1"=已变更)
function mesh_set_dwb_ssid_channge(flag)
    local wifinet = get_dwb_wifinet()
    
    if wifinet == nil then
        return nil
    end
    
    wifinet:set("dwb_ssid", flag)
    uci:save("wireless")
    uci:commit("wireless")
end

-- 获取DWB SSID变更标志
-- @return string 变更标志
function mesh_get_dwb_bsd_channge()
    local wifinet = get_dwb_wifinet()
    
    if wifinet == nil then
        return nil
    end
    
    return wifinet:get("dwb_ssid")
end

-- 获取DWB连接类型
-- @return number 0=无连接, 1=有线回程, 2=无线回程
function mesh_get_dwb_type()
    local ubus = require("ubus")
    local wired_count = 0
    
    if dwb_ifname == nil or dwb_ifname == "" then
        return 0
    end
    
    local conn = ubus.connect(nil)
    if not conn then
        return 0
    end
    
    -- 调用xq_info_sync_mesh获取Mesh节点信息
    local mesh_info = conn:call("xq_info_sync_mesh", "get_mesh_info", {})
    conn:close()
    
    if not mesh_info then
        return 0
    end
    
    -- 遍历节点检查连接类型
    for _, node in pairs(mesh_info) do
        if node.link_type ~= nil then
            if node.link_type == "wired" then
                wired_count = wired_count + 1
            else
                -- 存在无线连接的节点
                return 2
            end
        end
    end
    
    if wired_count == 0 then
        return 0
    else
        return 1
    end
end

-- 同步DWB SSID配置
-- 当主WiFi SSID变更时，同步更新DWB配置
-- @param old_config 旧的WiFi配置
-- @param new_config 新的WiFi配置
-- @param bsd_status 双频合一状态
function mesh_sync_dwb_ssid(old_config, new_config, bsd_status)
    if dwb_ifname == nil then
        return
    end
    
    local dwb_band = mesh_get_dwb_band()
    local dwb_status = mesh_get_dwb_status()
    
    -- 确定前端频段（与DWB频段不同的频段）
    local front_band = 2
    if dwb_band == 3 then
        front_band = 2
    elseif dwb_band == 2 then
        front_band = 3
    end
    
    -- 如果DWB频段配置存在且已启用，但新配置中关闭了该频段
    if new_config[dwb_band] then
        if new_config[dwb_band].on == 1 and dwb_status ~= "1" then
            new_config[dwb_band].on = 0
        end
    end
    
    -- 检查双频合一状态变化
    if old_config[1].bsd ~= bsd_status then
        mesh_set_dwb_ssid_channge("0")
        return
    end
    
    -- 如果双频合一已启用，不需要同步
    if old_config[1].bsd ~= "0" or bsd_status ~= "0" then
        return
    end
    
    -- 检查SSID是否变更
    if new_config[front_band] then
        if old_config[front_band].ssid ~= new_config[front_band].ssid then
            mesh_set_dwb_ssid_channge("1")
        end
    end
    
    if new_config[dwb_band] then
        if old_config[dwb_band].ssid ~= new_config[dwb_band].ssid then
            mesh_set_dwb_ssid_channge("1")
        end
    end
end
