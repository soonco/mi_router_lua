--[[
================================================================================
配置扫描模块 - UPnP 检测 (UPnP Configuration Scanner)
================================================================================

功能说明：
  本模块用于检测路由器的 UPnP（通用即插即用）配置安全性。
  UPnP 允许应用程序自动配置端口转发，可能被恶意软件利用。

安全风险：
  - 恶意软件可能利用 UPnP 自动打开端口
  - 可能导致内网服务意外暴露到公网
  - 难以追踪哪些应用程序打开了端口

安全建议：
  - 如非必要，建议关闭 UPnP 功能
  - 如需使用，定期检查 UPnP 映射列表
  - 使用手动端口转发替代 UPnP

扫描结果：
  - 0: 不安全（UPnP 已启用）
  - 1: 安全（UPnP 已关闭或已忽略此检查）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.UPnP", package.seeall)

--[[
--------------------------------------------------------------------------------
内部函数: isEnabled()
--------------------------------------------------------------------------------
功能: 检查此扫描项是否启用

返回值:
  boolean - true 表示启用扫描，false 表示用户已忽略此检查

说明:
  通过 UCI 配置检查用户是否选择忽略此安全检查项。
  配置路径：config_scan.UPnP.ignored
--------------------------------------------------------------------------------
--]]
local function isEnabled()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local ignored = cursor:get("config_scan", "UPnP", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取 UPnP 扫描的概览信息

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
功能: 执行 UPnP 安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查 UPnP 功能是否启用：
  - 如果 UPnP 已启用（getUPnPStatus 返回 true），返回 0（不安全）
  - 如果 UPnP 已关闭，返回 1（安全）
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
        
        local XQUPnPUtil = require("xiaoqiang.util.XQUPnPUtil")
        local upnpStatus = XQUPnPUtil.getUPnPStatus()
        
        local statusValue = upnpStatus and 1 or 0
        
        if statusValue == 0 then
            return 1
        else
            return 0
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
