--[[
  小米路由器网络测速模块 (XQNetworkSpeedTest)
  功能: 提供网络上传/下载速度测试功能
  
  主要功能:
  - 上传速度测试
  - 下载速度测试
  - 异步/同步测速
  - 测速结果保存和获取
]]

module("xiaoqiang.module.XQNetworkSpeedTest", package.seeall)

-- 引入依赖模块
local luciUtil = require("luci.util")
local XQFunction = require("xiaoqiang.common.XQFunction")

--[[
  执行上传速度测试
  @return 上传速度(MB/s)，失败返回nil
]]
function uploadSpeedTest()
    local uploadCmd = "/usr/bin/upload_speedtest"
    local uploadSpeed = nil
    
    -- 执行测速命令并解析结果
    local result = luciUtil.exec(uploadCmd)
    for line in result:gmatch("[^\r\n]+") do
        if not XQFunction.isStrNil(line) then
            -- 匹配上传速度行: "avg tx: xxx"
            if line:match("^avg tx:") then
                uploadSpeed = line:match("^avg tx:(%S+)")
                if uploadSpeed then
                    -- 将bps转换为MB/s (除以8)
                    uploadSpeed = tonumber(string.format("%.2f", uploadSpeed / 8))
                end
                break
            end
        end
    end
    
    return uploadSpeed
end

--[[
  执行下载速度测试
  @return 下载速度(MB/s)，失败返回nil
]]
function downloadSpeedTest()
    local downloadCmd = "/usr/bin/download_speedtest"
    local downloadSpeed = nil
    
    -- 执行测速命令并解析结果
    local result = luciUtil.exec(downloadCmd)
    for line in result:gmatch("[^\r\n]+") do
        if not XQFunction.isStrNil(line) then
            -- 匹配下载速度行: "avg rx: xxx"
            if line:match("^avg rx:") then
                downloadSpeed = line:match("^avg rx:(%S+)")
                if downloadSpeed then
                    -- 将bps转换为MB/s (除以8)
                    downloadSpeed = tonumber(string.format("%.2f", downloadSpeed / 8))
                end
                break
            end
        end
    end
    
    return downloadSpeed
end

--[[
  保存测速结果到配置
  @param uploadSpeed 上传速度
  @param downloadSpeed 下载速度
]]
function saveSpeedTestResult(uploadSpeed, downloadSpeed)
    local XQPreference = require("xiaoqiang.XQPreference")
    
    if uploadSpeed and downloadSpeed then
        -- 验证参数有效性
        if tonumber(uploadSpeed) and tonumber(downloadSpeed) then
            XQPreference.set("UPLOAD_SPEED", tostring(uploadSpeed))
            XQPreference.set("DOWNLOAD_SPEED", tostring(downloadSpeed))
        end
    end
end

--[[
  获取保存的测速结果
  @return uploadSpeed, downloadSpeed 上传速度和下载速度
]]
function getSpeedTestResult()
    local XQPreference = require("xiaoqiang.XQPreference")
    
    local uploadSpeed = tonumber(XQPreference.get("UPLOAD_SPEED"))
    local downloadSpeed = tonumber(XQPreference.get("DOWNLOAD_SPEED"))
    
    if uploadSpeed and downloadSpeed then
        if uploadSpeed > 0 and downloadSpeed > 0 then
            return uploadSpeed, downloadSpeed
        elseif uploadSpeed == 0 or downloadSpeed == 0 then
            return 0, 0
        else
            return nil, nil
        end
    else
        return nil, nil
    end
end

--[[
  执行完整的速度测试(上传+下载)
  @return downloadSpeed, uploadSpeed 下载速度和上传速度
]]
function speedTest()
    local results = {}
    local speedTestCmd = "/usr/bin/speedtest"
    
    -- 执行测速命令
    local output = luciUtil.exec(speedTestCmd)
    
    -- 解析下载速度结果
    for line in output:gmatch("[^\r\n]+") do
        if line then
            local rxSpeed = tonumber(line:match("rx:(%S+)"))
            if rxSpeed then
                table.insert(results, rxSpeed)
            end
        end
    end
    
    -- 计算平均速度
    local count = #results
    if count > 0 then
        local total = 0
        for _, speed in ipairs(results) do
            total = total + tonumber(speed)
        end
        local avgDownload = total / count
        
        -- 转换单位
        local downloadMbps = avgDownload / 1024 / 1024 * 8
        local uploadMbps = avgDownload / 1024 / 1024 * 8
        
        return downloadMbps, uploadMbps
    end
    
    return nil, nil
end

--[[
  异步执行速度测试
  在后台启动测速脚本
]]
function asyncSpeedTest()
    -- 先将结果重置为0
    saveSpeedTestResult(0, 0)
    
    -- 异步执行测速脚本
    XQFunction.forkExec("lua /usr/sbin/speed_test.lua")
end

--[[
  同步执行速度测试
  @return uploadSpeed, downloadSpeed 上传速度和下载速度
]]
function syncSpeedTest()
    local uploadSpeed = uploadSpeedTest()
    local downloadSpeed = downloadSpeedTest()
    
    return uploadSpeed, downloadSpeed
end
