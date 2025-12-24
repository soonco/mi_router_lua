--[[
  小米路由器Ecos子设备管理模块 (XQEcos)
  
  功能说明:
  - 管理小米生态链(Ecos)子设备
  - 支持子设备信息查询、升级、漫游切换
  - 通过trafficd服务获取硬件信息
  - 支持的设备型号: R01, R02, R03
  
  Ecos设备:
  - 小米WiFi放大器等扩展设备
  - 通过主路由器进行管理和配置
  - 支持固件升级和无线漫游
  
  信号强度等级:
  - 1: 信号强 (> -60dBm)
  - 2: 信号中等 (-70dBm ~ -60dBm)
  - 3: 信号弱 (< -70dBm)
--]]

-- 定义模块
module("xiaoqiang.module.XQEcos", package.seeall)

-- 引入JSON处理模块
local json = require("json")

-- 引入LuCI工具模块
local util = require("luci.util")

-- 引入通用函数模块
local XQFunction = require("xiaoqiang.common.XQFunction")

-- 支持的Ecos硬件型号列表
local SUPPORTED_HARDWARE = {
    R01 = 1,  -- 小米WiFi放大器第一代
    R02 = 1,  -- 小米WiFi放大器第二代
    R03 = 1   -- 小米WiFi放大器Pro
}

--[[
  获取所有Ecos子设备列表
  
  通过trafficd服务获取连接的硬件设备信息
  筛选出支持的Ecos设备
  
  @return table 设备列表，key为MAC地址
--]]
function _getEcosDevices()
    -- 调用trafficd获取硬件信息
    local output = util.exec("ubus call trafficd hw")
    
    -- 检查输出是否为空
    if XQFunction.isStrNil(output) then
        return {}
    end
    
    local devices = {}
    local hwInfo = json.decode(output)
    
    -- 遍历所有设备
    for mac, device in pairs(hwInfo) do
        local parseOk, description = nil, nil
        
        -- 解析设备描述信息
        if device.description then
            parseOk, description = pcall(json.decode, device.description)
        end
        
        if parseOk and description then
            -- 检查是否为支持的硬件型号
            if description.hardware then
                if SUPPORTED_HARDWARE[description.hardware] then
                    -- 检查设备是否有版本信息
                    if device.version then
                        -- 检查是否为AP模式且已关联
                        local isAp = tonumber(device.is_ap)
                        if isAp ~= 0 then
                            local assoc = tonumber(device.assoc)
                            if assoc == 1 then
                                -- 构建设备信息
                                local deviceInfo = {}
                                deviceInfo.mac = mac
                                deviceInfo.version = device.version
                                deviceInfo.channel = "current"
                                
                                -- 设备颜色
                                deviceInfo.color = description.color or ""
                                
                                -- 设备序列号
                                deviceInfo.sn = description.sn or ""
                                
                                -- 国家代码
                                deviceInfo.ctycode = description.country_code or ""
                                
                                -- 获取设备IP地址
                                local ipList = device.ip_list
                                if #ipList > 0 then
                                    deviceInfo.ip = ipList[1].ip
                                end
                                
                                -- 更新频道信息
                                deviceInfo.channel = description.channel or ""
                                
                                -- 只有获取到IP的设备才添加到列表
                                if deviceInfo.ip then
                                    devices[mac] = deviceInfo
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return devices
end

--[[
  获取Ecos设备的信号强度等级
  
  @param mac string 设备MAC地址
  @return number 信号等级: 1=强, 2=中, 3=弱, nil=获取失败
--]]
function _getEcosSignal(mac)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 获取设备信号强度
    local signal = tonumber(XQWifiUtil.getWifiDeviceSignal(mac))
    
    if signal then
        if signal < -70 then
            return 3  -- 信号弱
        elseif signal > -60 then
            return 1  -- 信号强
        else
            return 2  -- 信号中等
        end
    end
    
    return nil
end

--[[
  获取Ecos设备的信号强度值 (dBm)
  
  @param mac string 设备MAC地址
  @return number 信号强度值 (dBm)，获取失败返回0
--]]
function _getEcosSignalDB(mac)
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 获取设备信号强度
    local signal = tonumber(XQWifiUtil.getWifiDeviceSignal(mac))
    
    return signal or 0
end

--[[
  检查Ecos设备是否有可用升级
  
  @param version string 当前版本
  @param channel string 升级通道
  @param sn string 设备序列号
  @param ctycode string 国家代码
  @return table 升级信息，无升级返回nil
--]]
function _getEcosUpgrade(version, channel, sn, ctycode)
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    
    -- 检查升级
    local upgradeInfo = XQNetUtil.checkEcosUpgrade(version, channel, sn, ctycode)
    
    if upgradeInfo then
        -- 检查是否需要更新
        if upgradeInfo.needUpdate == 1 then
            return upgradeInfo
        end
    else
        return nil
    end
end

--[[
  获取Ecos设备的无线漫游状态
  
  @param ip string 设备IP地址
  @return number 漫游状态: 0=关闭, 1=开启
--]]
function _getEcosWRoamingStatus(ip)
    if not ip then
        return nil
    end
    
    -- 通过tbus调用设备获取描述信息
    local cmd = "tbus call " .. ip .. " desc \"{\\\"desc\\\":1}\" 2>/dev/null"
    local output = util.exec(cmd)
    
    if output then
        local ok, result = pcall(json.decode, output)
        if ok then
            -- 返回无线漫游开关状态
            return result.switch_wifi_explorer or 0
        end
    end
    
    return 0
end

--[[
  获取指定Ecos设备的详细信息
  
  @param mac string 设备MAC地址
  @return table 设备详细信息，设备不存在返回nil
--]]
function getEcosInfo(mac)
    -- 检查MAC地址是否有效
    if XQFunction.isStrNil(mac) then
        return nil
    end
    
    local info = {}
    
    -- 获取所有Ecos设备
    local devices = _getEcosDevices()
    local device = devices[mac]
    
    if device then
        -- 检查是否有可用升级
        local upgradeInfo = _getEcosUpgrade(device.version, device.channel, device.sn, device.ctycode)
        if upgradeInfo then
            info.upgrade = true
            info.upgradeinfo = upgradeInfo
        else
            info.upgrade = false
        end
        
        -- 获取信号强度等级
        local signal = _getEcosSignal(mac)
        info.signal = signal or 0
        
        -- 获取信号强度值
        local signalDB = _getEcosSignalDB(mac)
        info.signalDB = signalDB
        
        -- 获取无线漫游状态
        local roaming = _getEcosWRoamingStatus(device.ip)
        info.roaming = roaming or 0
        
        -- 复制设备基本信息
        info.version = device.version
        info.channel = device.channel
        info.color = device.color
        info.ip = device.ip
        
        return info
    else
        return nil
    end
end

--[[
  切换Ecos设备的无线漫游功能
  
  @param mac string 设备MAC地址
  @param enable boolean 是否开启漫游
  @return boolean 操作是否成功
--]]
function ecosWirelessRoamingSwitch(mac, enable)
    -- 获取所有Ecos设备
    local devices = _getEcosDevices()
    local device = devices[mac]
    
    if device then
        -- 构建tbus命令
        local enableStr
        if enable then
            enableStr = "1"
        else
            enableStr = "0"
        end
        
        local cmd = "tbus call " .. device.ip .. " switch \"{\\\"wifi_explorer\\\":" .. enableStr .. "}\" >/dev/null 2>/dev/null"
        
        -- 执行命令
        local result = os.execute(cmd)
        
        return result == 0
    end
    
    return false
end

--[[
  触发Ecos设备固件升级
  
  @param mac string 设备MAC地址
--]]
function ecosUpgrade(mac)
    if mac then
        -- 创建升级状态标记文件
        os.execute("echo 1 > /tmp/" .. mac)
        
        -- 构建升级命令
        local cmd = "lua /usr/sbin/ecos_upgrade.lua " .. mac .. " 2>/dev/null"
        
        -- 异步执行升级脚本
        XQFunction.forkExec(cmd)
    end
end

--[[
  获取Ecos设备升级状态
  
  状态值说明:
  - 0: 未开始/已完成
  - 1: 正在升级
  - 其他: 升级进度百分比
  
  @param mac string 设备MAC地址
  @return number 升级状态
--]]
function ecosUpgradeStatus(mac)
    if mac then
        local fs = require("nixio.fs")
        
        -- 读取状态文件
        local statusFile = "/tmp/" .. mac
        local content = fs.readfile(statusFile)
        
        local status = tonumber(content)
        if status then
            return tonumber(content)
        end
    end
    
    return 0
end
