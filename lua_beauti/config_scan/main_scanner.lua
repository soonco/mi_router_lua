--[[
================================================================================
配置扫描模块 - 主扫描器 (Main Configuration Scanner)
================================================================================

功能说明：
  本模块是配置扫描系统的主入口，负责协调所有子扫描模块。
  它将扫描任务分为两大类：系统配置和无线配置。

扫描架构：
  main_scanner
  ├── system (系统配置扫描)
  │   ├── newest_rom      - 固件更新检查
  │   ├── rom_auto_updating - 自动更新检查
  │   ├── DMZ             - DMZ 配置检查
  │   ├── UPnP            - UPnP 配置检查
  │   └── port_mapping    - 端口映射检查
  └── wireless (无线配置扫描)
      ├── wifi_encryption - WiFi 加密检查
      └── wifi_passwd_security - WiFi 密码强度检查

评分标准：
  - 总分 100 分
  - 40 分及以上为安全
  - 低于 40 分需要关注安全配置

主要接口：
  - overview()     : 获取所有扫描项的概览
  - prepare(path)  : 准备扫描环境
  - scan(path)     : 执行完整扫描

================================================================================
--]]

-- 声明模块
module("config_scan.main_scanner", package.seeall)

-- 子模块配置
local SUBMODS = {
    { name = "system", weight = 1 },    -- 系统配置扫描
    { name = "wireless", weight = 1 }   -- 无线配置扫描
}

--[[
--------------------------------------------------------------------------------
函数: overview()
--------------------------------------------------------------------------------
功能: 获取所有扫描项的概览信息

返回值:
  table - 包含所有子模块的概览信息
  boolean - 是否安全（分数 >= 40）

说明:
  遍历所有子模块，收集各项的扫描状态，
  同时从 UCI 配置中读取上次扫描的分数。
--------------------------------------------------------------------------------
--]]
function overview()
    local result = {}
    
    for _, submod in ipairs(SUBMODS) do
        local modName = "config_scan." .. submod.name
        local mod = require(modName)
        
        local subResult = mod.overview()
        for key, value in pairs(subResult) do
            result[key] = value
        end
    end
    
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local lastScore = cursor:get("config_scan", "meta", "last_score")
    
    local meta = {}
    if lastScore then
        meta.last_score = lastScore
    end
    result.meta = meta
    
    local isSafe = lastScore and (tonumber(lastScore) >= 40)
    
    return result, isSafe
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
功能: 执行完整的配置安全扫描

参数:
  statusPath - 状态文件存储路径

返回值:
  number - 总分数（0-1 之间的小数）

说明:
  1. 创建协程执行子模块扫描
  2. 实时更新扫描进度
  3. 计算最终分数并保存到 UCI 配置
  4. 分数乘以 100 后保存（显示为百分比）
--------------------------------------------------------------------------------
--]]
function scan(statusPath)
    local common = require("config_scan.common")
    
    local co = coroutine.create(function()
        return common.scan_submod(statusPath, SUBMODS)
    end)
    
    local finalScore = 1
    
    while coroutine.status(co) ~= "dead" do
        local ok, result = coroutine.resume(co)
        finalScore = result
    end
    
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    cursor:set("config_scan", "meta", "meta")
    cursor:set("config_scan", "meta", "last_score", tostring(math.floor(100 * finalScore)))
    cursor:commit("config_scan")
    
    return finalScore
end
