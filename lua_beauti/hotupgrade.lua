--[[
    热升级模块 (Hot Upgrade Module)
    
    功能说明:
    - 提供路由器固件热升级功能
    - 支持增量补丁下载和应用
    - 无需完整刷机即可更新系统组件
    
    主要功能:
    - hotupgrade_log: 记录热升级日志到syslog
    - hotupgrade_download: 下载并验证补丁文件
    - hotupgrade_upgrade: 执行热升级流程
    
    依赖模块:
    - luci.fs: 文件系统操作
    - luci.util: 工具函数
    - json: JSON编解码
    - posix: POSIX系统调用
    - xiaoqiang.util.XQDownloadUtil: 下载工具
    - xiaoqiang.common.XQFunction: 通用函数
]]

module("hotupgrade", package.seeall)

local fs = require("luci.fs")
local util = require("luci.util")
local json = require("json")
local posix = require("posix")
local XQDownloadUtil = require("xiaoqiang.util.XQDownloadUtil")
local XQFunction = require("xiaoqiang.common.XQFunction")

--[[
    记录热升级日志
    
    将日志消息写入系统日志(syslog)，级别为WARNING(4)
    
    @param ... 可变参数，所有参数都会被序列化后记录
]]
function hotupgrade_log(...)
    -- 打开syslog连接
    posix.openlog("hotupgrade", posix.LOG_USER)
    
    -- 收集所有参数
    local args = {...}
    
    -- 遍历并记录每个参数
    for _, arg in ipairs(args) do
        -- 序列化数据后写入syslog
        posix.syslog(4, util.serialize_data(arg))
    end
    
    -- 关闭syslog连接
    posix.closelog()
end

--[[
    下载热升级补丁文件
    
    从指定URL下载补丁文件，并验证其哈希值
    
    @param url string 补丁文件下载地址
    @param expected_hash string 期望的文件哈希值
    @return string|nil 成功返回本地文件路径，失败返回nil
]]
function hotupgrade_download(url, expected_hash)
    -- 参数验证
    if url == nil then
        return nil
    end
    
    -- 执行同步下载
    local actual_hash, local_path = XQDownloadUtil.syncDownloadV2(url)
    
    -- 检查下载是否成功
    if not actual_hash or not local_path then
        hotupgrade_log("Download patch file failed")
        return nil
    end
    
    -- 验证哈希值
    if actual_hash ~= expected_hash then
        return nil
    end
    
    -- 验证文件是否存在
    if not fs.access(local_path) then
        -- 文件不存在，清理并返回失败
        fs.unlink(local_path)
        return nil
    end
    
    return local_path
end

--[[
    执行热升级
    
    处理热升级任务列表，依次检查和应用每个补丁
    
    升级流程:
    1. 检查补丁是否已应用 (hotupgrade.sh check)
    2. 如果未应用，下载补丁文件
    3. 执行补丁应用 (hotupgrade.sh)
    4. 清理临时文件
    
    @param upgrade_list table 热升级任务列表，每个元素包含:
        - hotupgradeName: string 补丁名称
        - link: string 下载链接
        - hash: string 文件哈希值
]]
function hotupgrade_upgrade(upgrade_list)
    -- 参数验证
    if not upgrade_list then
        return
    end
    
    -- 验证列表有效性
    if type(upgrade_list) ~= "table" or #upgrade_list == 0 then
        return
    end
    
    -- 遍历处理每个升级任务
    for _, upgrade_info in ipairs(upgrade_list) do
        local patch_name = upgrade_info.hotupgradeName
        local patch_file = nil
        local exit_code = nil
        local skip_download = false
        
        -- 验证必需字段
        if upgrade_info.hotupgradeName and upgrade_info.link and upgrade_info.hash then
            -- 将升级信息编码为JSON
            local json_info = json.encode(upgrade_info)
            
            -- 记录检查日志
            hotupgrade_log("Execute /usr/sbin/hotupgrade.sh check " .. patch_name .. " " .. json_info)
            
            -- 检查补丁是否已应用
            local result, exit_code = XQFunction.waitExec(
                "/usr/sbin/hotupgrade.sh",
                "check",
                patch_name,
                json_info
            )
            
            -- 如果检查返回非0，说明补丁已应用，跳过下载
            if exit_code ~= 0 then
                skip_download = true
            end
            
            -- 如果需要下载补丁
            if skip_download == false then
                -- 下载补丁文件
                patch_file = hotupgrade_download(upgrade_info.link, upgrade_info.hash)
                
                if patch_file then
                    -- 记录执行日志
                    hotupgrade_log("Execute /usr/sbin/hotupgrade.sh")
                    
                    -- 执行热升级脚本
                    result, exit_code = XQFunction.waitExec(
                        "/usr/sbin/hotupgrade.sh",
                        patch_file
                    )
                    
                    -- 如果执行失败，清理补丁文件
                    if exit_code ~= 0 then
                        fs.unlink(patch_file)
                    end
                end
            end
        end
    end
end
