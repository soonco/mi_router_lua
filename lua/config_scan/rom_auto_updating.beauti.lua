--[[
================================================================================
配置扫描模块 - 自动更新检测 (ROM Auto-Updating Scanner)
================================================================================

功能说明：
  本模块用于检测路由器的固件自动更新功能是否启用。
  自动更新可以确保路由器及时获得安全补丁。

功能优势：
  - 自动下载并安装安全更新
  - 无需手动检查更新
  - 减少安全漏洞暴露时间

安全建议：
  - 建议启用自动更新功能
  - 可以选择仅自动下载，手动安装
  - 定期检查更新日志

扫描结果：
  - 0: 不安全（自动更新未启用）
  - 1: 安全（自动更新已启用）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.rom_auto_updating", package.seeall)

--[[
--------------------------------------------------------------------------------
内部函数: isEnabled()
--------------------------------------------------------------------------------
功能: 检查此扫描项是否启用

返回值:
  boolean - true 表示启用扫描，false 表示用户已忽略此检查
--------------------------------------------------------------------------------
--]]
local function isEnabled()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local ignored = cursor:get("config_scan", "rom_auto_updating", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取自动更新扫描的概览信息

返回值:
  table - 包含 enable_scan 字段
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
功能: 执行自动更新检查

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查预下载（自动更新）功能是否启用：
  - auto == 1: 自动更新已启用，返回 1（安全）
  - auto != 1: 自动更新未启用，返回 0（不安全）
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
        
        local XQPredownload = require("xiaoqiang.module.XQPredownload")
        local predownloadInfo = XQPredownload.predownloadInfo()
        
        if predownloadInfo.auto == 1 then
            return 1
        else
            return 0
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
