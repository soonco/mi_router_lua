--[[
================================================================================
配置扫描模块 - 系统配置扫描 (System Configuration Scanner)
================================================================================

功能说明：
  本模块是系统配置安全扫描的父模块，负责协调以下子扫描项：
  - newest_rom      : 固件版本检查
  - rom_auto_updating : 自动更新检查
  - DMZ             : DMZ 配置检查
  - UPnP            : UPnP 配置检查
  - port_mapping    : 端口映射检查

扫描权重：
  所有子项权重相同（weight = 1），最终分数为各项的平均值。

主要接口：
  - overview()     : 获取所有子项的概览
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行系统配置扫描

================================================================================
--]]

-- 声明模块
module("config_scan.system", package.seeall)

-- 子模块配置
local SUBMODS = {
    { name = "newest_rom", weight = 1 },       -- 固件更新检查
    { name = "rom_auto_updating", weight = 1 }, -- 自动更新检查
    { name = "DMZ", weight = 1 },              -- DMZ 配置检查
    { name = "UPnP", weight = 1 },             -- UPnP 配置检查
    { name = "port_mapping", weight = 1 }      -- 端口映射检查
}

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取所有系统配置扫描项的概览信息

返回值:
  table - 包含各子模块的概览信息，键为模块名称

说明:
  遍历所有子模块，调用各自的 overview() 函数收集状态。
--------------------------------------------------------------------------------
--]]
function overview()
    local result = {}
    
    for _, submod in ipairs(SUBMODS) do
        local modName = "config_scan." .. submod.name
        local mod = require(modName)
        
        result[submod.name] = mod.overview()
    end
    
    return result
end

--[[
--------------------------------------------------------------------------------
函数: prepare(statusPath)
--------------------------------------------------------------------------------
功能: 准备扫描环境

参数:
  statusPath - 状态文件存储路径

说明:
  调用公共模块的 prepare_status 函数，
  为所有子模块创建必要的目录结构。
--------------------------------------------------------------------------------
--]]
function prepare(statusPath)
    local common = require("config_scan.common")
    common.prepare_status(statusPath, SUBMODS)
end

--[[
--------------------------------------------------------------------------------
函数: scan(statusPath)
--------------------------------------------------------------------------------
功能: 执行系统配置安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 总分数（0-1 之间的小数）

说明:
  调用公共模块的 scan_submod 函数执行所有子模块扫描，
  返回加权平均分数。
--------------------------------------------------------------------------------
--]]
function scan(statusPath)
    local common = require("config_scan.common")
    return common.scan_submod(statusPath, SUBMODS)
end
