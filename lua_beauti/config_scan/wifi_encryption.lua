--[[
================================================================================
配置扫描模块 - WiFi 加密检测 (WiFi Encryption Scanner)
================================================================================

功能说明：
  本模块用于检测路由器 WiFi 的加密方式是否安全。
  使用强加密是保护无线网络安全的基础。

加密方式安全等级：
  - WPA3       : 最安全（推荐）
  - WPA2/PSK2  : 安全（推荐）
  - WPA/PSK    : 较弱（不推荐）
  - WEP        : 不安全（已被破解）
  - 无加密     : 极不安全

安全建议：
  - 使用 WPA2 或 WPA3 加密
  - 避免使用 WEP 或无加密
  - 使用 CCMP (AES) 而非 TKIP

扫描结果：
  - 0: 不安全（使用弱加密或无加密）
  - 1: 安全（使用 WPA2/PSK2 + CCMP）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.wifi_encryption", package.seeall)

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
    local ignored = cursor:get("config_scan", "wifi_encryption", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取 WiFi 加密扫描的概览信息

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
内部函数: isSecureEncryption(encryption)
--------------------------------------------------------------------------------
功能: 检查加密方式是否安全

参数:
  encryption - 加密方式字符串

返回值:
  boolean - true 表示安全

说明:
  以下加密方式被认为是安全的：
  - psk2      : WPA2-PSK
  - psk2+ccmp : WPA2-PSK with AES
  - ccmp      : AES 加密
--------------------------------------------------------------------------------
--]]
local function isSecureEncryption(encryption)
    return encryption == "psk2" or encryption == "psk2+ccmp" or encryption == "ccmp"
end

--[[
--------------------------------------------------------------------------------
函数: scan(statusPath)
--------------------------------------------------------------------------------
功能: 执行 WiFi 加密安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查所有 WiFi 接口的加密方式：
  - 如果所有接口都使用安全加密，返回 1
  - 如果任一接口使用不安全加密，返回 0
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
        
        local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
        local wifiList = XQWifiUtil.getAllWifiInfo()
        
        local allSecure = true
        
        for _, wifi in ipairs(wifiList) do
            if allSecure then
                local encryption = wifi.encryption
                if encryption then
                    allSecure = isSecureEncryption(encryption)
                end
            end
        end
        
        if allSecure then
            return 1
        else
            return 0
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
