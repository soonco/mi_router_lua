--[[
  小米路由器设备识别模块
  
  功能说明:
  - 根据MAC地址OUI识别设备厂商
  - 根据DHCP名称识别设备类型
  - 支持小米生态链设备识别
  - 提供设备图标和类型信息
  
  设备类型分类 (c=category, p=product):
  - c=1: 智能家居
    - p=1: 智能红外
    - p=2: 智能插座
  - c=2: 影音设备
    - p=6: 摄像机
  - c=3: 小米设备
    - p=4: 小米电视
    - p=5: 小米盒子
    - p=7: 智能红外
    - p=8: 小米路由器
    - p=9: 小米路由器mini
    - p=10: 小米路由器mini2
    - p=11: 小米随身WiFi / 空气净化器
    - p=12: 小米Wi-Fi放大器
  - c=4: 其他设备
    - p=1: 迅雷矿机
  
  OUI数据库:
  - 使用IEEE OUI数据库识别设备厂商
  - 支持自定义OUI规则（如Broadlink设备）
]]

module("xiaoqiang.XQEquipment", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local luci_util = require("luci.util")

-- OUI数据库解压标志
local oui_extracted = false

-- 基于MAC地址OUI的设备识别规则
-- key: MAC地址前6位（OUI）
-- value: 设备识别规则列表
local OUI_RULES = {
    ["B4430D"] = {
        {
            from = "300000",
            to = "3FFFFF",
            company = "Broadlink Pty Ltd",
            icon = "device_list_intelligent.png",
            type = { c = 1, p = 1, n = "智能红外" },
            priority = 2
        },
        {
            from = "100000",
            to = "1FFFFF",
            company = "Broadlink Pty Ltd",
            icon = "device_list_intelligent_plugin.png",
            type = { c = 1, p = 2, n = "智能插座" },
            priority = 2
        }
    }
}

-- 基于DHCP名称的设备识别规则
local DHCP_RULES = {
    {
        rule = "^mitv",
        company = "Xiaomi",
        icon = "device_mitv.png",
        type = { c = 3, p = 4, n = "小米电视" },
        priority = 1
    },
    {
        rule = "^mibox",
        company = "Xiaomi",
        icon = "device_mibox.png",
        type = { c = 3, p = 5, n = "小米盒子" },
        priority = 1
    },
    {
        rule = "^miwifi%-r1d",
        company = "Xiaomi",
        icon = "device_miwifi_r1d.png",
        type = { c = 3, p = 8, n = "小米路由器" },
        priority = 1
    },
    {
        rule = "^miwifi%-r1cm",
        company = "Xiaomi",
        icon = "device_miwifi_r1c.png",
        type = { c = 3, p = 9, n = "小米路由器mini" },
        priority = 1
    },
    {
        rule = "^miwifi%-r1cq",
        company = "Xiaomi",
        icon = "device_miwifi_r1c.png",
        type = { c = 3, p = 10, n = "小米路由器mini2" },
        priority = 1
    },
    {
        rule = "^miwifi%-tiny",
        company = "Xiaomi",
        icon = "device_mirouter_wifi.png",
        type = { c = 3, p = 11, n = "小米随身WiFi" },
        priority = 1
    },
    {
        rule = "^xiaomirepeater",
        company = "Xiaomi",
        icon = "device_list_miwifi_repeater.png",
        type = { c = 3, p = 12, n = "小米Wi-Fi放大器" },
        priority = 1
    },
    {
        rule = "^broadlink_sp2",
        company = "Broadlink Pty Ltd",
        icon = "device_list_intelligent_plugin.png",
        type = { c = 1, p = 2, n = "智能插座" },
        priority = 1
    },
    {
        rule = "^broadlink_rm2",
        company = "Broadlink Pty Ltd",
        icon = "device_list_intelligent.png",
        type = { c = 1, p = 1, n = "智能红外" },
        priority = 1
    },
    {
        rule = "^antscam",
        company = "云蚁",
        icon = "device_list_intelligent_camera.png",
        type = { c = 2, p = 6, n = "小蚁智能摄像机" },
        priority = 1
    },
    {
        rule = "^xiaomi%.ir",
        company = "Xiaomi",
        icon = "device_list_lq.png",
        type = { c = 3, p = 7, n = "智能红外" },
        priority = 1
    },
    {
        rule = "chuangmi%-plug",
        company = "Chuangmi",
        icon = "device_list_intelligent_plugin.png",
        type = { c = 3, p = 2, n = "智能插座" },
        priority = 1
    },
    {
        rule = "^zhimi%-airpurifier",
        company = "zhimi",
        icon = "device_list_airpurifier.png",
        type = { c = 3, p = 11, n = "空气净化器" },
        priority = 1
    },
    {
        rule = "^xl_miner",
        company = "xunlei",
        icon = "device_list_xlminer.png",
        type = { c = 4, p = 1, n = "迅雷矿机" },
        priority = 1
    }
}

-- 识别设备（简化版本）
-- @param mac MAC地址
-- @param dhcpname DHCP名称
-- @return table 设备信息 {name, icon, type, priority}
function identifyDevice(mac, dhcpname)
    return {
        name = "",
        icon = "",
        type = { c = 0, p = 0, n = "" },
        priority = 2
    }
end

-- 识别设备（完整版本）
-- @param mac MAC地址
-- @param dhcpname DHCP名称
-- @return table 设备信息 {name, icon, type, priority}
function identifyDeviceOld(mac, dhcpname)
    local oui_result = nil
    local dhcp_result = nil
    
    -- 基于MAC地址OUI识别
    if mac then
        local mac_upper = string.upper(mac:gsub(":", ""))
        local oui = string.sub(mac_upper, 1, 6)
        local device_suffix = string.sub(mac_upper, 7, 12)
        local device_num = tonumber(device_suffix, 16)
        
        -- 检查自定义OUI规则
        local oui_rules = OUI_RULES[oui]
        if oui_rules and type(oui_rules) == "table" then
            for _, rule in ipairs(oui_rules) do
                local from_num = tonumber(rule.from, 16)
                local to_num = tonumber(rule.to, 16)
                
                if device_num >= from_num and device_num <= to_num then
                    oui_result = {
                        name = rule.company,
                        icon = rule.icon,
                        type = rule.type or { c = 0, p = 0, n = "" },
                        priority = tonumber(rule.priority) or 2
                    }
                    break
                end
            end
        else
            -- 从OUI数据库查询
            if not oui_extracted then
                os.execute("tar -xzf " .. XQConfigs.OUI_ZIP_FILEPATH .. " -C /tmp >/dev/null 2>/dev/null")
                oui_extracted = true
            end
            
            local mac_formatted = mac:gsub(":", "-")
            local oui_prefix = string.sub(mac_formatted, 1, 8)
            
            local cmd = "sed -n '/" .. oui_prefix .. "/p' " .. XQConfigs.OUI_FILEPATH
            local oui_line = luci_util.exec(cmd)
            
            if oui_line and oui_line ~= "" then
                local parts = luci_util.split(oui_line, oui_prefix)
                local company_info = parts[2]
                
                if company_info then
                    local icon = company_info:match("ICON:(%S+)")
                    
                    oui_result = {
                        type = { c = 0, p = 0, n = "" },
                        priority = 2
                    }
                    
                    if icon then
                        local company_name = company_info:match("(.+)ICON:%S+") or company_info
                        oui_result.name = company_name
                        oui_result.icon = icon
                    else
                        oui_result.name = company_info
                        oui_result.icon = ""
                    end
                end
            end
        end
    end
    
    -- 基于DHCP名称识别
    if dhcpname then
        local dhcpname_lower = string.lower(dhcpname)
        
        for _, rule in ipairs(DHCP_RULES) do
            if dhcpname_lower:match(rule.rule) then
                dhcp_result = {
                    name = rule.company,
                    icon = rule.icon,
                    type = rule.type or { c = 0, p = 0, n = "" },
                    priority = tonumber(rule.priority) or 2
                }
                break
            end
        end
    end
    
    -- 返回优先级更高的结果
    if oui_result and dhcp_result then
        if oui_result.priority < dhcp_result.priority then
            return oui_result
        else
            return dhcp_result
        end
    elseif oui_result then
        return oui_result
    elseif dhcp_result then
        return dhcp_result
    else
        return {
            name = "",
            icon = "",
            type = { c = 0, p = 0, n = "" },
            priority = 2
        }
    end
end
