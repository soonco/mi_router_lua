--[[
================================================================================
配置扫描模块 - 固件更新检测 (Newest ROM Scanner)
================================================================================

功能说明：
  本模块用于检测路由器是否运行最新版本的固件。
  保持固件更新是保障路由器安全的重要措施。

安全重要性：
  - 新固件通常包含安全漏洞修复
  - 可能包含性能优化和新功能
  - 过时的固件可能存在已知漏洞

安全建议：
  - 定期检查固件更新
  - 及时安装安全更新
  - 备份配置后再更新

扫描结果：
  - 0: 需要更新（有新固件可用）
  - 1: 已是最新（无需更新）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.newest_rom", package.seeall)

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
    local ignored = cursor:get("config_scan", "newest_rom", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取固件更新扫描的概览信息

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
功能: 执行固件更新检查

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  调用 XQNetUtil.checkUpgrade() 检查是否有新固件：
  - needUpdate == 0: 已是最新，返回 1
  - needUpdate != 0: 需要更新，返回 0
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
        
        local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
        local upgradeInfo = XQNetUtil.checkUpgrade()
        
        if upgradeInfo.needUpdate == 0 then
            return 1
        else
            return 0
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
