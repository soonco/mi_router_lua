--[[
    无线配置扫描父模块 (Wireless Configuration Scanner Parent Module)
    
    功能说明:
    - 作为无线相关安全扫描的父模块
    - 协调三个子扫描器: wifi_passwd_security, wifi_encryption, anti_squatter
    - 提供统一的概览、准备和扫描接口
    
    子模块说明:
    - wifi_passwd_security: WiFi密码安全性检查
    - wifi_encryption: WiFi加密方式检查
    - anti_squatter: 防蹭网检查
]]

module("config_scan.wireless", package.seeall)

-- 子模块配置列表
-- 定义需要扫描的子模块及其权重
local submodules = {
    [1] = {
        name = "wifi_passwd_security",  -- WiFi密码安全扫描
        weight = 1                       -- 权重值
    },
    [2] = {
        name = "wifi_encryption",        -- WiFi加密方式扫描
        weight = 1
    },
    [3] = {
        name = "anti_squatter",          -- 防蹭网扫描
        weight = 1
    }
}

--[[
    获取所有子模块的概览信息
    
    @return table 包含所有子模块概览结果的表
        - key: 子模块名称
        - value: 子模块的overview()返回值
]]
function overview()
    local results = {}
    
    for _, submod_config in ipairs(submodules) do
        -- 动态加载子模块
        local submod = require("config_scan." .. submod_config.name)
        -- 获取子模块概览并存储
        results[submod_config.name] = submod.overview()
    end
    
    return results
end

--[[
    准备扫描状态
    
    @param status table 状态对象，用于存储准备结果
]]
function prepare(status)
    local common = require("config_scan.common")
    common.prepare_status(status, submodules)
end

--[[
    执行无线配置扫描
    
    @param status table 状态对象，包含扫描上下文
    @return mixed 扫描结果
]]
function scan(status)
    local common = require("config_scan.common")
    return common.scan_submod(status, submodules)
end
