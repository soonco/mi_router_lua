--[[
================================================================================
配置扫描模块 - DMZ 检测 (DMZ Configuration Scanner)
================================================================================

功能说明：
  本模块用于检测路由器的 DMZ（非军事区）配置安全性。
  DMZ 功能会将内网设备完全暴露到公网，存在安全风险。

安全建议：
  - 除非必要，不要启用 DMZ 功能
  - 如果必须使用，确保 DMZ 主机有足够的安全防护
  - 定期检查 DMZ 配置状态

扫描结果：
  - 0: 不安全（DMZ 已启用）
  - 1: 安全（DMZ 未启用或已忽略此检查）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.DMZ", package.seeall)

--[[
--------------------------------------------------------------------------------
内部函数: isEnabled()
--------------------------------------------------------------------------------
功能: 检查此扫描项是否启用

返回值:
  boolean - true 表示启用扫描，false 表示用户已忽略此检查

说明:
  通过 UCI 配置检查用户是否选择忽略此安全检查项。
  配置路径：config_scan.DMZ.ignored
--------------------------------------------------------------------------------
--]]
local function isEnabled()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local ignored = cursor:get("config_scan", "DMZ", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取 DMZ 扫描的概览信息

返回值:
  table - 包含以下字段：
    - enable_scan: 1 表示启用扫描，0 表示已忽略

说明:
  用于在扫描列表中显示此检查项的状态。
--------------------------------------------------------------------------------
--]]
function overview()
    local result = {}
    result.enable_scan = isEnabled() and 1 or 0
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
  创建必要的状态目录和文件，为扫描做准备。
--------------------------------------------------------------------------------
--]]
function prepare(statusPath)
    local common = require("config_scan.common")
    common.prepare_status(statusPath)
    
    local displayFile = io.open(statusPath .. "/meta/display", "a")
    displayFile:close()
end

--[[
--------------------------------------------------------------------------------
函数: scan(statusPath)
--------------------------------------------------------------------------------
功能: 执行 DMZ 安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查 DMZ 功能是否启用：
  - 如果 DMZ 已启用（status == 1），返回 0（不安全）
  - 如果 DMZ 未启用，返回 1（安全）
--------------------------------------------------------------------------------
--]]
function scan(statusPath)
    local common = require("config_scan.common")
    
    local function doScan()
        if not isEnabled() then
            return 0
        end
        
        local enableScanFile = io.open(statusPath .. "/meta/enable_scan", "a")
        enableScanFile:close()
        
        local XQFirewall = require("xiaoqiang.module.XQFirewall")
        local dmzInfo = XQFirewall.getDMZInfo()
        
        if dmzInfo.status == 1 then
            return 0
        else
            return 1
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
