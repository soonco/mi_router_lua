--[[
  小米路由器统计打点模块
  
  功能说明:
  - 提供系统日志记录功能
  - 支持syslog方式记录统计信息
  - 支持文件方式记录统计信息
  
  主要函数:
  - Log(key, value): 通过syslog记录键值对
  - LogToFile(key, message, file, level): 记录到文件
  
  使用场景:
  - 用户行为统计
  - 系统运行状态监控
  - 错误日志记录
]]

module("xiaoqiang.XQStatPoints", package.seeall)

local posix = require("posix")

-- 通过syslog记录统计信息
-- @param key 统计键名
-- @param value 统计值
function Log(key, value)
    -- 打开syslog连接
    -- 使用 LOG_LOCAL1 设施，LOG_NDELAY 标志
    posix.openlog("sp_lib", posix.LOG_NDELAY, posix.LOG_LOCAL1)
    
    -- 记录信息级别的日志，格式为 "key=value"
    posix.syslog(posix.LOG_INFO, tostring(key) .. "=" .. tostring(value))
    
    -- 关闭syslog连接
    posix.closelog()
end

-- 通过脚本记录统计信息到文件
-- @param key 统计键名
-- @param message 统计消息
-- @param file 目标文件路径（可选）
-- @param level 日志级别（可选）
function LogToFile(key, message, file, level)
    local cmd = "/usr/bin/sp_log_info.sh"
    
    if key and message then
        -- 构建命令行参数
        cmd = cmd .. " -k " .. key .. " -m " .. string.format("\"%s\"", message)
        
        -- 如果指定了文件路径
        if file then
            cmd = cmd .. " -f " .. file
            
            -- 如果指定了日志级别
            if level then
                cmd = cmd .. " -l " .. level
            end
        end
        
        -- 执行记录命令
        luci.util.exec(cmd)
    end
end
