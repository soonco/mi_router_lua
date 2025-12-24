--[[
================================================================================
配置扫描模块 - WiFi 密码强度检测 (WiFi Password Security Scanner)
================================================================================

功能说明：
  本模块用于检测路由器 WiFi 密码的安全强度。
  强密码是防止未授权访问的第一道防线。

密码强度评估标准：
  - 长度：至少 8 个字符
  - 复杂度：包含以下至少 2 种类型：
    * 数字 (0-9)
    * 小写字母 (a-z)
    * 大写字母 (A-Z)
    * 特殊字符

弱密码示例：
  - 12345678（纯数字）
  - password（纯小写字母）
  - abcd1234（长度够但复杂度不足）

强密码示例：
  - MyP@ssw0rd（混合大小写、数字、特殊字符）
  - Secure#2024!（长度足够，复杂度高）

扫描结果：
  - 0: 不安全（密码强度不足）
  - 1: 安全（密码强度足够）

主要接口：
  - overview()     : 获取扫描概览信息
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行安全扫描

================================================================================
--]]

-- 声明模块
module("config_scan.wifi_passwd_security", package.seeall)

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
    local ignored = cursor:get("config_scan", "wifi_passwd_security", "ignored")
    return ignored ~= "1"
end

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取 WiFi 密码强度扫描的概览信息

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
内部函数: isStrongPassword(password)
--------------------------------------------------------------------------------
功能: 检查密码强度是否足够

参数:
  password - 密码字符串

返回值:
  boolean - true 表示密码强度足够

说明:
  密码必须满足：
  1. 长度至少 8 个字符
  2. 包含以下至少 2 种字符类型：
     - 数字
     - 小写字母
     - 大写字母
     - 特殊字符
--------------------------------------------------------------------------------
--]]
local function isStrongPassword(password)
    if #password < 8 then
        return false
    end
    
    local complexity = 0
    
    if password:find("[0-9]") then
        complexity = complexity + 1
    end
    
    if password:find("[a-z]") then
        complexity = complexity + 1
    end
    
    if password:find("[A-Z]") then
        complexity = complexity + 1
    end
    
    if password:find("[^0-9a-zA-Z]") then
        complexity = complexity + 1
    end
    
    return complexity > 1
end

--[[
--------------------------------------------------------------------------------
函数: scan(statusPath)
--------------------------------------------------------------------------------
功能: 执行 WiFi 密码强度扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 安全分数（0 或 1）

说明:
  检查所有 WiFi 接口的密码强度：
  - 如果所有接口的密码都足够强，返回 1
  - 如果任一接口的密码较弱，返回 0
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
        
        local allStrong = true
        
        for _, wifi in ipairs(wifiList) do
            if allStrong then
                local password = wifi.password
                if password then
                    allStrong = isStrongPassword(password)
                end
            end
        end
        
        if allStrong then
            return 1
        else
            return 0
        end
    end
    
    return common.scan_leaf(statusPath, doScan)
end
