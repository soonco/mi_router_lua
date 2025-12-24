--[[
================================================================================
配置扫描模块 - 端口映射检测 (Port Mapping Scanner)
================================================================================

功能说明：
  本模块用于检测路由器的端口映射（端口转发）配置。
  端口映射会将内网服务暴露到公网，存在安全风险。

安全风险：
  - 暴露的服务可能被攻击者扫描和利用
  - 如果服务存在漏洞，可能被远程攻击
  - 可能导致内网数据泄露

安全建议：
  - 仅在必要时启用端口映射
  - 定期审查端口映射规则
  - 确保映射的服务已更新到最新版本
  - 使用强密码保护映射的服务

扫描结果：
  - 0: 不安全（存在端口映射规则）
  - 1: 安全（无端口映射或已忽略此检查）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.port_mapping", package.seeall)

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
    local ignored = cursor:get("config_scan", "port_mapping", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取端口映射扫描的概览信息

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
功能: 执行端口映射安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查端口转发功能是否启用：
  - 如果存在端口映射规则（status == 1），返回 0（不安全）
  - 如果无端口映射规则，返回 1（安全）
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
        local portForwardInfo = XQFirewall.portForwardInfo()
        
        if portForwardInfo.status == 1 then
            return 0
        else
            return 1
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
