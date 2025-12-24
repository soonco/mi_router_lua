--[[
    小米路由器流量解码与设备管理模块
    功能：设备识别、主机名获取、网络接口管理、WiFi配对验证等
    
    主要函数说明：
    - cmdfmt: 命令格式化，转义特殊字符
    - get_hostname_init: 初始化主机名获取所需的模块和数据
    - get_hostname: 根据MAC地址获取设备主机名
    - get_wan_dev_name: 获取WAN口设备名称
    - get_lan_dev_name: 获取LAN口设备名称
    - get_ap_hw: 获取AP模式下的硬件地址
    - trafficd_lua_done: 通知trafficd完成处理
    - get_description: 获取路由器描述信息
    - get_version: 获取ROM版本号
    - trafficd_lua_ecos_pair_verify: ECOS配对验证
--]]

-- 模块级变量声明
local deviceUtil      -- 设备工具模块 (XQDeviceUtil)
local equipmentUtil   -- 设备信息模块 (XQEquipment)  
local deviceInfoDB    -- 设备信息数据库
local dhcpDict        -- DHCP字典

--[[
    命令格式化函数
    对字符串中的特殊字符进行转义，防止shell命令注入
    @param inputStr 输入字符串
    @return 转义后的字符串
--]]
function cmdfmt(inputStr)
    local result
    
    -- 转义反斜杠 \ -> \\
    result = inputStr:gsub("\\", "\\\\")
    
    -- 转义反引号 ` -> \`
    result = result:gsub("`", "\\`")
    
    -- 转义双引号 " -> \"
    result = result:gsub("\"", "\\\"")
    
    -- 转义美元符号 $ -> \$
    result = result:gsub("%$", "\\$")
    
    return result
end

--[[
    初始化主机名获取功能
    加载必要的模块并获取设备信息数据
--]]
function get_hostname_init()
    -- 加载小米设备工具模块
    deviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 加载设备信息模块
    equipmentUtil = require("xiaoqiang.XQEquipment")
    
    -- 从数据库获取设备信息
    deviceInfoDB = deviceUtil.getDeviceInfoFromDB()
    
    -- 获取DHCP分配记录
    dhcpDict = deviceUtil.getDHCPDict()
end

--[[
    根据MAC地址获取设备主机名
    优先级：用户设置的昵称 > 设备识别名称 > DHCP名称 > MAC地址
    @param macAddress 设备MAC地址
    @return 设备主机名或MAC地址
--]]
function get_hostname(macAddress)
    local hostname
    local deviceName
    
    -- 首先检查设备信息数据库中是否有该设备
    if deviceInfoDB[macAddress] then
        -- 检查是否有用户设置的昵称
        if deviceInfoDB[macAddress].nickname ~= "" then
            hostname = deviceInfoDB[macAddress].nickname
        end
    else
        -- 从DHCP字典中获取设备名称
        if dhcpDict[macAddress] then
            deviceName = dhcpDict[macAddress].name
        end
        
        if not deviceName then
            deviceName = ""
        end
        
        if deviceName == "" then
            -- 没有DHCP名称，尝试通过设备识别获取
            local identifyResult = equipmentUtil.identifyDevice(macAddress, "")
            hostname = identifyResult.name
        else
            -- 有DHCP名称，进行设备识别
            local identifyResult = equipmentUtil.identifyDevice(macAddress, deviceName)
            local typeScore = identifyResult.type.p + identifyResult.type.c
            
            -- 如果识别得分大于0，使用识别结果；否则使用DHCP名称
            if typeScore > 0 then
                hostname = identifyResult.name
            else
                hostname = deviceName
            end
        end
    end
    
    -- 如果没有获取到主机名，返回MAC地址
    local result = macAddress
    if hostname ~= "" or not macAddress then
        result = hostname
    end
    
    return result
end

--[[
    获取WAN口网络设备名称
    通过ubus调用获取WAN接口状态
    @return WAN口设备名称（如 eth0, pppoe-wan 等）
--]]
function get_wan_dev_name()
    local ubus = require("ubus")
    
    -- 连接到ubus
    local ubusConn = ubus.connect()
    if not ubusConn then
        elog("Failed to connect to ubusd")
    end
    
    -- 调用ubus获取WAN接口状态
    local wanStatus = ubusConn:call("network.interface.wan", "status", {})
    
    -- 关闭ubus连接
    ubusConn:close()
    
    -- 优先返回l3_device，如果不存在则返回device
    local deviceName
    if wanStatus.l3_device then
        deviceName = wanStatus.l3_device
    else
        deviceName = wanStatus.device
    end
    
    return deviceName
end

--[[
    获取LAN口网络设备名称
    通过ubus调用获取LAN接口状态
    @return LAN口设备名称（如 br-lan 等）
--]]
function get_lan_dev_name()
    local ubus = require("ubus")
    
    -- 连接到ubus
    local ubusConn = ubus.connect()
    if not ubusConn then
        elog("Failed to connect to ubusd")
    end
    
    -- 调用ubus获取LAN接口状态
    local lanStatus = ubusConn:call("network.interface.lan", "status", {})
    
    -- 关闭ubus连接
    ubusConn:close()
    
    -- 优先返回l3_device，如果不存在则返回device
    local deviceName
    if lanStatus.l3_device then
        deviceName = lanStatus.l3_device
    else
        deviceName = lanStatus.device
    end
    
    return deviceName
end

--[[
    获取AP模式下的硬件MAC地址
    根据网络模式（wifiapmode/lanapmode）获取对应接口的MAC地址
    @return MAC地址字符串，如果不是AP模式则返回nil
--]]
function get_ap_hw()
    -- 读取当前网络模式
    local pipeHandle = io.popen("uci get xiaoqiang.common.NETMODE")
    local netMode = pipeHandle:read("*line")
    pipeHandle:close()
    
    -- WiFi AP模式：获取apcli0接口的MAC地址
    if netMode == "wifiapmode" then
        pipeHandle = io.popen("ifconfig apcli0 | grep HWaddr")
        local ifconfigOutput = pipeHandle:read("*line")
        local _, _, macAddress = string.find(ifconfigOutput, "HWaddr%s+([0-9A-F:]+)%s*$")
        pipeHandle:close()
        return macAddress
    end
    
    -- 有线AP模式：获取br-lan接口的MAC地址
    if netMode == "lanapmode" then
        pipeHandle = io.popen("ifconfig br-lan | grep HWaddr")
        local ifconfigOutput = pipeHandle:read("*line")
        local _, _, macAddress = string.find(ifconfigOutput, "HWaddr%s+([0-9A-F:]+)%s*$")
        pipeHandle:close()
        return macAddress
    end
    
    -- 非AP模式返回nil
    return nil
end

--[[
    通知trafficd守护进程Lua处理完成
    发送SIGUSR1信号(10)给noflushd进程
--]]
function trafficd_lua_done()
    os.execute("killall -q -s 10 noflushd")
end

--[[
    获取路由器描述信息
    用于trafficd流量统计
    @return 路由器信息表
--]]
function get_description()
    local sysUtil = require("xiaoqiang.util.XQSysUtil")
    return sysUtil.getRouterInfo4Trafficd()
end

--[[
    获取路由器ROM版本号
    @return 版本号字符串
--]]
function get_version()
    local sysUtil = require("xiaoqiang.util.XQSysUtil")
    return sysUtil.getRomVersion()
end

--[[
    ECOS配对验证函数
    处理WiFi配对验证请求，解析JSON数据并记录日志
    
    注意：此函数的反编译代码存在部分缺失（L16、L17、L18等变量未定义）
    以下为根据上下文推测的功能实现
    
    @param requestData 请求数据
    @return 多个返回值：ssid密码、ssid类型、ssid隐藏状态、bssid、设备ID等
--]]
function trafficd_lua_ecos_pair_verify(requestData)
    local json = require("json")
    
    -- 解析后的配对信息变量
    local code          -- 响应码
    local token         -- 认证令牌
    local ssid          -- WiFi名称
    local ssidPassword  -- WiFi密码
    local ssidType      -- WiFi类型
    local ssidHidden    -- 是否隐藏SSID
    local bssid         -- 基站MAC地址
    local deviceId      -- 设备ID
    
    local wifiIfaceIndex = 1  -- WiFi接口索引
    local pipeHandle
    local ifaceName
    
    -- 注意：以下代码在原始反编译中存在变量未定义的问题
    -- 原始逻辑似乎是：
    -- 1. 获取某个WiFi接口名称
    -- 2. 遍历所有wifi-iface配置找到匹配的索引
    -- 3. 执行某个命令处理配对请求
    -- 4. 解析返回的JSON数据
    
    --[[
    -- 伪代码示意（原始代码不完整）：
    if wifiIfaceName ~= nil and someCondition then
        for i = startIndex, endIndex, step do
            pipeHandle = io.popen(string.format("uci get wireless.@wifi-iface[%d].ifname", i))
            ifaceName = pipeHandle:read("*line")
            pipeHandle:close()
            
            if ifaceName == targetIfaceName then
                wifiIfaceIndex = i
                break
            end
        end
    end
    --]]
    
    -- 格式化命令参数
    -- local formattedIfaceName = cmdfmt(wifiIfaceName)
    -- local formattedRequestData = cmdfmt(requestData)
    
    -- 执行配对验证命令并处理响应
    --[[
    -- 伪代码示意：
    for line in responseLines do
        local decoded = json.decode(line)
        code = decoded.code
        token = decoded.token
        ssid = decoded.ssid
        ssidPassword = decoded.ssid_pwd
        ssidType = decoded.ssid_type
        ssidHidden = decoded.ssid_hidden
        bssid = decoded.bssid
        deviceId = decoded.device_id
        
        -- 记录日志
        os.execute(string.format("logger \"%s\"", cmdfmt(code)))
        os.execute(string.format("logger \"%s\"", cmdfmt(token)))
        os.execute(string.format("logger \"%s\"", cmdfmt(ssid)))
        os.execute(string.format("logger \"%s\"", cmdfmt(ssidPassword)))
        os.execute(string.format("logger \"%s\"", cmdfmt(ssidType)))
        os.execute(string.format("logger \"%s\"", cmdfmt(ssidHidden)))
        os.execute(string.format("logger \"%s\"", cmdfmt(bssid)))
        os.execute(string.format("logger \"%s\"", cmdfmt(deviceId)))
    end
    --]]
    
    -- 返回配对信息
    -- 注意：由于原始代码不完整，返回值可能不准确
    return nil, nil, nil, ssidPassword, ssidType, ssidHidden, bssid, deviceId
end
