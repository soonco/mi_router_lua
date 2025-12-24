--[[
================================================================================
配置扫描模块 - 防蹭网检测 (Anti-Squatter Configuration Scanner)
================================================================================

功能说明：
  本模块用于检测路由器的防蹭网功能是否启用。
  防蹭网功能可以防止未授权设备连接到您的 WiFi 网络。

功能特点：
  - 检测陌生设备连接
  - 自动阻止可疑设备
  - 提供设备白名单管理

安全建议：
  - 建议启用防蹭网功能
  - 定期检查已连接设备列表
  - 及时将可信设备加入白名单

扫描结果：
  - 返回防蹭网功能的开启状态（open 字段值）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.anti_squatter", package.seeall)

--[[
--------------------------------------------------------------------------------
内部函数: isEnabled()
--------------------------------------------------------------------------------
功能: 检查此扫描项是否启用

返回值:
  boolean - true 表示启用扫描，false 表示用户已忽略此检查

说明:
  通过 UCI 配置检查用户是否选择忽略此安全检查项。
  配置路径：config_scan.anti_squatter.ignored
--------------------------------------------------------------------------------
--]]
local function isEnabled()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local ignored = cursor:get("config_scan", "anti_squatter", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取防蹭网扫描的概览信息

返回值:
  table - 包含以下字段：
    - enable_scan: 1 表示启用扫描，0 表示已忽略
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
功能: 执行防蹭网安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 防蹭网功能的开启状态

说明:
  调用 misystem API 获取防蹭网状态，
  返回 open 字段的值表示功能是否开启。
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
        
        local misystem = require("luci.controller.api.misystem")
        local antiRubStatus = misystem._getAntiRubNetworkStatus()
        
        return antiRubStatus.open
    end
    
    return common.scan_leaf(statusPath, doScan)
end
