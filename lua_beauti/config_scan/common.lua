--[[
================================================================================
配置扫描模块 - 公共函数库 (Common Utilities for Config Scanner)
================================================================================

功能说明：
  本模块提供配置扫描系统的公共函数和常量，包括：
  - 扫描状态管理
  - 进度报告
  - 文件操作辅助
  - 子模块扫描协调

工作状态常量：
  - WORK_STATUS_WAIT    (0): 等待扫描
  - WORK_STATUS_RUNNING (1): 正在扫描
  - WORK_STATUS_DONE    (2): 扫描完成

主要接口：
  - prepare_status(path, submods) : 准备扫描状态目录
  - scan_submod(path, submods)    : 扫描子模块
  - scan_leaf(path, scanFunc)     : 执行叶子节点扫描

================================================================================
--]]

-- 声明模块
module("config_scan.common", package.seeall)

-- 扫描脚本目录
SCAN_SCRIPTS_DIR = "/usr/lib/lua/config_scan"

-- 工作状态常量
WORK_STATUS_WAIT = 0      -- 等待扫描
WORK_STATUS_RUNNING = 1   -- 正在扫描
WORK_STATUS_DONE = 2      -- 扫描完成

--[[
--------------------------------------------------------------------------------
内部函数: sleep(milliseconds)
--------------------------------------------------------------------------------
功能: 休眠指定的毫秒数

参数:
  milliseconds - 休眠时间（毫秒）

说明:
  使用 POSIX nanosleep 实现精确的休眠。
--------------------------------------------------------------------------------
--]]
local function sleep(milliseconds)
    local posix = require("posix")
    local seconds = milliseconds / 1000
    local timespec = {
        tv_sec = seconds,
        tv_nsec = (seconds % 1) * 1000000000
    }
    posix.nanosleep(timespec)
end

--[[
--------------------------------------------------------------------------------
函数: prepare_status(statusPath, submods)
--------------------------------------------------------------------------------
功能: 准备扫描状态目录结构

参数:
  statusPath - 状态文件根目录
  submods    - 子模块列表（可选）

说明:
  创建 meta 目录和 status 文件，
  如果提供了子模块列表，还会为每个子模块创建目录并调用其 prepare 函数。
--------------------------------------------------------------------------------
--]]
function prepare_status(statusPath, submods)
    local metaPath = statusPath .. "/meta"
    local nixio = require("nixio")
    
    nixio.fs.mkdir(metaPath)
    
    local statusFile = nixio.open(metaPath .. "/status", "w")
    statusFile:write(WORK_STATUS_WAIT)
    statusFile:close()
    
    if not submods then
        return
    end
    
    for _, submod in ipairs(submods) do
        local modName = "config_scan." .. submod.name
        local mod = require(modName)
        
        local submodPath = statusPath .. "/" .. submod.name
        nixio.fs.mkdir(submodPath)
        
        mod.prepare(submodPath)
    end
end

--[[
--------------------------------------------------------------------------------
内部函数: writeScore(metaPath, score)
--------------------------------------------------------------------------------
功能: 写入扫描分数

参数:
  metaPath - meta 目录路径
  score    - 分数值
--------------------------------------------------------------------------------
--]]
local function writeScore(metaPath, score)
    local scoreFile = nixio.open(metaPath .. "/score", "w")
    scoreFile:write(score)
    scoreFile:close()
end

--[[
--------------------------------------------------------------------------------
函数: scan_submod(statusPath, submods)
--------------------------------------------------------------------------------
功能: 扫描所有子模块

参数:
  statusPath - 状态文件根目录
  submods    - 子模块列表，每个元素包含：
               - name: 模块名称
               - weight: 权重

返回值:
  number - 总分数（0-1 之间的小数）

说明:
  使用协程并发执行各子模块的扫描，
  根据权重计算加权平均分数，
  实时更新进度到 score 文件。
--------------------------------------------------------------------------------
--]]
function scan_submod(statusPath, submods)
    local metaPath = statusPath .. "/meta"
    local nixio = require("nixio")
    
    local totalScore = 0
    local totalWeight = 0
    
    for _, submod in ipairs(submods) do
        totalWeight = totalWeight + submod.weight
    end
    
    local statusFile = nixio.open(metaPath .. "/status", "w")
    statusFile:write(WORK_STATUS_RUNNING)
    
    local scoreFile = nixio.open(metaPath .. "/score", "w")
    scoreFile:write(0)
    
    for _, submod in ipairs(submods) do
        local modName = "config_scan." .. submod.name
        local mod = require(modName)
        
        local submodPath = statusPath .. "/" .. submod.name
        nixio.fs.mkdir(submodPath)
        
        local co = coroutine.create(function()
            return mod.scan(submodPath)
        end)
        
        local weightRatio = submod.weight / totalWeight
        local currentScore = 0
        
        while coroutine.status(co) ~= "dead" do
            local ok, result = coroutine.resume(co)
            currentScore = weightRatio * result
            
            writeScore(metaPath, totalScore + currentScore)
            coroutine.yield(totalScore + currentScore)
        end
        
        totalScore = totalScore + currentScore
    end
    
    scoreFile:seek(0, "set")
    scoreFile:write(totalScore)
    scoreFile:close()
    
    statusFile:seek(0, "set")
    statusFile:write(WORK_STATUS_DONE)
    statusFile:close()
    
    return totalScore
end

--[[
--------------------------------------------------------------------------------
函数: scan_leaf(statusPath, scanFunc)
--------------------------------------------------------------------------------
功能: 执行叶子节点扫描

参数:
  statusPath - 状态文件目录
  scanFunc   - 扫描函数，返回分数

返回值:
  number - 扫描分数

说明:
  叶子节点是扫描树的最底层，执行实际的安全检查。
  此函数负责：
  1. 设置状态为 RUNNING
  2. 添加随机延迟（模拟扫描过程）
  3. 调用扫描函数获取分数
  4. 设置状态为 DONE
--------------------------------------------------------------------------------
--]]
function scan_leaf(statusPath, scanFunc)
    local metaPath = statusPath .. "/meta"
    local nixio = require("nixio")
    
    local score = 0
    
    nixio.fs.mkdir(metaPath)
    
    local statusFile = nixio.open(metaPath .. "/status", "w")
    statusFile:write(WORK_STATUS_RUNNING)
    
    local scoreFile = nixio.open(metaPath .. "/score", "w")
    scoreFile:write(score)
    
    sleep(200 + math.random(200))
    
    score = scanFunc()
    
    scoreFile:seek(0, "set")
    scoreFile:write(score)
    scoreFile:close()
    
    statusFile:seek(0, "set")
    statusFile:write(WORK_STATUS_DONE)
    statusFile:close()
    
    return score
end
