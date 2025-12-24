--[[
  小米路由器下载管理模块 (XQDownload)
  
  功能说明:
  - 基于Aria2下载引擎的下载任务管理
  - 支持HTTP/FTP/BT/磁力链接等多种下载方式
  - 提供下载任务的添加、暂停、恢复、删除等操作
  - 支持下载速度限制和并发数设置
  - 支持下载任务状态查询和文件搜索
  
  Aria2 JSON-RPC接口:
  - 通过localhost:6800端口与Aria2进程通信
  - 使用JSON-RPC 2.0协议进行命令交互
  
  错误码定义:
  - 2901: 添加种子失败
  - 2903: 获取全局选项失败
  - 2904: 修改选项失败
  - 2906: 删除任务失败
  - 2907: 路径为空
  - 2908: 路径不存在
  - 2911: 任务已存在
  - 2912: 添加URI失败
  - 2913: JSON格式错误
  - 2914: 查询任务失败
  - 2915: 参数无效
  - 2916: 文件打开失败
  - 2917: 路径不在/mnt下
  - 2918: 操作类型无效
  - 2920: 暂停所有任务失败
  - 2921: 恢复所有任务失败
  - 2922: lost+found目录不允许
  - 2923: 非种子文件
  - 2924: 文件过大
  - 2925: 脚本正在运行
  - 2926: 配置文件不存在
  - 2927: 重启任务失败
--]]

-- 引入日志模块
local XQLog = require("xiaoqiang.XQLog")

-- 引入JSON处理模块
local json = require("json")

-- 引入JSON-RPC模块
require("json.rpc")

-- 定义模块
module("xiaoqiang.module.XQDownload", package.seeall)

-- Aria2 JSON-RPC服务地址
local ARIA2_RPC_URL = "http://localhost:6800/jsonrpc"

--[[
  获取Aria2全局配置选项
  
  @return table 配置信息表，包含:
    - dir: 下载目录
    - max_concurrent_downloads: 最大并发下载数
    - max_download_limit: 最大下载速度限制
    - bind: 是否绑定存储设备 (0/1)
    - autoclean_cycle: 自动清理周期
  @return number 错误码，0表示成功
--]]
function getGlobalOption()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local errorCode = 0
    
    -- 调用Aria2 RPC获取全局选项
    local method = "aria2.getGlobalOption"
    local params = {}
    local options = {}
    
    -- 获取自动清理周期配置
    local autoclean_cycle = cursor:get("aria2", "main", "autoclean_cycle")
    
    -- 调用RPC
    local result, err = json.rpc.call(ARIA2_RPC_URL, method)
    
    if err then
        XQLog.log(4, "getGlobalOption " .. err)
        errorCode = 2903
        return result, errorCode
    else
        errorCode = 0
    end
    
    -- 解析返回的选项
    for key, value in pairs(result) do
        -- 只提取需要的配置项
        if key == "dir" or key == "max-concurrent-downloads" or key == "max-download-limit" then
            -- 将配置项名称中的横线替换为下划线
            local normalizedKey = string.gsub(key, "-", "_")
            options[normalizedKey] = value
        end
    end
    
    -- 检查是否绑定了存储设备
    local file = cursor:get("aria2", "main", "dir")
    if file ~= nil then
        options.bind = 1
    else
        options.bind = 0
    end
    
    options.autoclean_cycle = autoclean_cycle
    
    return options, errorCode
end

--[[
  修改Aria2全局配置选项
  
  @param maxDownloadLimit string 最大下载速度限制 (字节/秒)
  @param maxConcurrentDownloads string 最大并发下载数
  @return number 错误码，0表示成功
--]]
function changeGlobalOption(maxDownloadLimit, maxConcurrentDownloads)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local errorCode = 0
    
    local method = "aria2.changeGlobalOption"
    local paramsStr = "[{"
    local hasParam = 0
    
    -- 设置最大下载速度限制
    if maxDownloadLimit ~= "" then
        hasParam = 1
        paramsStr = paramsStr .. "'max-download-limit':'" .. maxDownloadLimit .. "'"
        -- 保存到UCI配置
        cursor:set("aria2", "main", "max_download_limit", maxDownloadLimit)
        cursor:commit("aria2")
    end
    
    -- 设置最大并发下载数
    if maxConcurrentDownloads ~= "" then
        if hasParam == 1 then
            paramsStr = paramsStr .. ","
        end
        paramsStr = paramsStr .. "'max-concurrent-downloads':'" .. maxConcurrentDownloads .. "'"
        -- 保存到UCI配置
        cursor:set("aria2", "main", "max_concurrent_downloads", maxConcurrentDownloads)
        cursor:commit("aria2")
    end
    
    paramsStr = paramsStr .. "}]"
    
    -- 解析参数并调用RPC
    local params = json.decode(paramsStr)
    local result, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    if err and err ~= 0 then
        XQLog.log(4, "changeGlobalOption " .. err)
        errorCode = 2904
    else
        errorCode = 0
    end
    
    return errorCode
end

--[[
  获取正在下载的任务列表
  
  @return table 活动任务列表
  @return number 错误码
--]]
function tellActive()
    local method = "aria2.tellActive"
    local errorCode = 0
    
    local result, err = json.rpc.call(ARIA2_RPC_URL, method)
    
    if err then
        XQLog.log(4, "tellActive " .. err)
        errorCode = 2914
    else
        errorCode = 0
    end
    
    return result, errorCode
end

--[[
  获取等待中的任务列表
  
  @return table 等待任务列表
  @return number 错误码
--]]
function tellWaiting()
    local method = "aria2.tellWaiting"
    local paramsStr = "[0,1000]"  -- 获取前1000个等待任务
    local errorCode = 0
    
    local params = json.decode(paramsStr)
    local result, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    if err then
        XQLog.log(4, "tellWaiting " .. err)
        errorCode = 2914
    else
        errorCode = 0
    end
    
    return result, errorCode
end

--[[
  获取已停止的任务列表
  
  @return table 已停止任务列表
  @return number 错误码
--]]
function tellStopped()
    local method = "aria2.tellStopped"
    local paramsStr = "[0,1000]"  -- 获取前1000个已停止任务
    local errorCode = 0
    
    local params = json.decode(paramsStr)
    local result, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    if err then
        XQLog.log(4, "tellStopped " .. err)
        errorCode = 2914
    else
        errorCode = 0
    end
    
    return result, errorCode
end

--[[
  获取正在下载的任务 (包括活动和等待中的)
  使用multicall批量调用提高效率
  
  @return table 下载中的任务列表
  @return number 错误码
--]]
function tellOndownload()
    local method = "system.multicall"
    local errorCode = 0
    local result = nil
    
    -- 构建批量调用参数
    local paramsStr = "[[{'methodName':'aria2.tellActive'},{'methodName':'aria2.tellWaiting','params':[0,1000]}]]"
    local params = json.decode(paramsStr)
    
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    result = response
    
    if err then
        XQLog.log(4, "tellActive " .. err)
        errorCode = 2914
    else
        errorCode = 0
    end
    
    return result, errorCode
end

--[[
  将任务状态字符串转换为数字代码
  
  @param status string 状态字符串
  @return number 状态代码: 1=active, 2=paused, 3=complete, 4=waiting, 0=unknown
--]]
local function statusToCode(status)
    local statusMap = {
        active = 1,
        paused = 2,
        complete = 3,
        waiting = 4
    }
    
    local code = statusMap[status]
    if code ~= nil then
        return code
    else
        return 0
    end
end

--[[
  检查是否为有效的文件属性字段
  
  @param field string 字段名
  @return boolean 是否有效
--]]
local function isValidFileField(field)
    local validFields = {
        index = true,
        path = true,
        length = true
    }
    
    if validFields[field] ~= nil then
        return true
    else
        return false
    end
end

--[[
  从路径中提取文件名
  
  @param path string 完整路径
  @param separator string 路径分隔符
  @return string 文件名
--]]
local function extractFileName(path, separator)
    -- 反转字符串以便从后向前查找
    local reversed = string.reverse(path)
    local pos = string.find(reversed, separator)
    pos = pos or pos
    
    local pathLen = string.len(path)
    local startPos = pathLen - pos + 1
    
    -- 提取文件名部分
    local fileName = string.sub(path, startPos + 1, string.len(path))
    
    return fileName
end

--[[
  解析文件列表信息
  
  @param files table 文件列表
  @return table 解析后的文件信息列表
--]]
local function parseFileList(files)
    local result = {}
    local fileInfo = {}
    
    if type(files) ~= "table" then
        return result
    end
    
    for i = 1, #files do
        for key, value in pairs(files[i]) do
            if isValidFileField(key) then
                if key == "path" then
                    -- 从路径中提取文件名
                    fileInfo.name = extractFileName(value, "/")
                else
                    fileInfo[key] = value
                end
            end
        end
        
        if fileInfo then
            if next(fileInfo) ~= nil then
                table.insert(result, fileInfo)
                fileInfo = {}
            end
        end
    end
    
    return result
end

--[[
  检查是否为有效的任务属性字段
  
  @param field string 字段名
  @return boolean 是否有效
--]]
local function isValidTaskField(field)
    local validFields = {
        completedLength = true,
        totalLength = true,
        connections = true,
        gid = true,
        downloadSpeed = true,
        dir = true,
        status = true,
        errorCode = true,
        errorMessage = true
    }
    
    if validFields[field] ~= nil then
        return true
    else
        return false
    end
end

--[[
  解析任务详细信息
  
  @param taskData table 任务数据
  @param includeFiles boolean 是否包含文件列表
  @param parseFiles boolean 是否解析文件信息
  @return number 任务数量
--]]
local function parseTaskInfo(taskData, includeFiles, parseFiles)
    local result = {}
    local tasks = {}
    local count = 0
    
    if not taskData or type(taskData) ~= "table" then
        return count
    end
    
    for _, item in pairs(taskData) do
        if type(item) ~= "table" then
            -- 记录日志
        else
            for _, task in pairs(item) do
                count = count + 1
                
                if type(task) == "table" then
                    for key, value in pairs(task) do
                        if key == "status" then
                            result[key] = statusToCode(value)
                        elseif key == "bittorrent" then
                            -- BT下载任务
                            result.filetype = "bt"
                            for btKey, btValue in pairs(value) do
                                if btKey == "info" then
                                    if type(btValue) == "table" then
                                        for infoKey, infoValue in pairs(btValue) do
                                            if infoKey == "name" then
                                                result.filename = infoValue
                                            elseif infoKey == "creationDate" then
                                                result.creationDate = infoValue
                                            end
                                        end
                                    end
                                end
                            end
                        elseif key == "infoHash" then
                            if result.filename == nil then
                                result.filename = value
                            end
                        elseif key == "files" then
                            -- 处理文件列表
                            local uriKey = "uri"
                            if value and value ~= "" then
                                if result.filename == nil then
                                    result.filename = value
                                end
                            end
                            
                            if parseFiles then
                                if value then
                                    local parsedFiles = parseFileList(value)
                                    if parsedFiles ~= nil then
                                        result.files = parsedFiles
                                    end
                                end
                            end
                        elseif value then
                            result[key] = value
                        end
                    end
                end
                
                -- 计算完成比例
                if result.totalLength and result.completedLength then
                    if result.totalLength ~= "0" then
                        result.completedRatio = result.completedLength / result.totalLength
                    end
                else
                    result.completedRatio = 0
                end
                
                -- 设置默认错误信息
                if result.errorCode == nil then
                    result.errorCode = 0
                    result.errorMessage = ""
                end
                
                if result and next(result) ~= nil then
                    table.insert(tasks, result)
                    result = {}
                end
            end
        end
    end
    
    return count
end

--[[
  验证GID格式是否正确
  GID必须是16位十六进制字符串
  
  @param gid string 任务GID
  @return boolean 是否有效
--]]
local function isValidGid(gid)
    local len = #gid
    if len ~= 16 then
        return false
    end
    return true
end

--[[
  解析RPC调用结果
  
  @param response table RPC响应
  @return table 解析后的结果
  @return number 错误码
--]]
local function parseRpcResponse(response)
    local result = {}
    local errorCode = 0
    
    if type(response) == "table" then
        for _, item in pairs(response) do
            for key, value in pairs(item) do
                if key == "code" then
                    if value ~= 0 then
                        result.errorCode = value
                        errorCode = value
                    end
                elseif key == "message" then
                    result.errorMassage = value
                else
                    if isValidGid(value) then
                        table.insert(result, value)
                    end
                end
            end
        end
    end
    
    return result, errorCode
end

--[[
  批量获取任务信息
  
  @param gidList table GID列表
  @return table 任务信息列表
  @return number 错误码
--]]
function getTaskInfo(gidList)
    local result = {}
    local tasks = {}
    local errorCode = 0
    local method = "system.multicall"
    local paramsStr = "[["
    
    local count = #gidList
    
    -- 构建批量查询参数
    for _, gid in ipairs(gidList) do
        count = count - 1
        paramsStr = paramsStr .. "{'methodName':'aria2.tellStatus','params':['" .. gid .. "']}"
        
        if 0 < count then
            paramsStr = paramsStr .. ","
        end
    end
    
    paramsStr = paramsStr .. "]]"
    
    local params = json.decode(paramsStr)
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = response
    errorCode = err
    
    if errorCode then
        XQLog.log(4, "getTaskInfo " .. errorCode)
        errorCode = 2914
    else
        -- 解析任务信息
        parseTaskInfo(response, true, true)
        errorCode = 0
    end
    
    return result, errorCode
end

--[[
  检查是否为保留的记录文件名
  
  @param filename string 文件名
  @return boolean 是否为保留文件
--]]
local function isReservedRecordFile(filename)
    local reservedFiles = {
        complete_record_file = true,
        error_record_file = true,
        ondownload_record_file = true
    }
    
    if reservedFiles[filename] then
        return false  -- 是保留文件，不允许操作
    else
        return true
    end
end

--[[
  从记录文件读取任务信息
  
  @param taskList table 任务列表 (输出参数)
  @param recordType string 记录类型
  @return number 任务数量
  @return number 错误码
--]]
local function readRecordFile(taskList, recordType)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local count = 0
    
    -- 检查记录类型是否有效
    if not isReservedRecordFile(recordType) then
        return 0, 2915
    end
    
    -- 获取记录文件路径
    local recordFile = cursor:get("aria2", "main", recordType)
    
    if not recordFile or recordFile == "" then
        return 0, 2926
    end
    
    -- 打开并读取记录文件
    local file = io.open(recordFile, "r")
    assert(file, "read file is nil")
    
    local taskInfo = {}
    
    for line in file:lines() do
        if line and line ~= "" then
            count = count + 1
            -- 解析JSON格式的任务信息
            taskInfo = json.decode(line)
            table.insert(taskList, taskInfo)
            taskInfo = {}
        end
    end
    
    file:close()
    
    return count, 0
end

--[[
  从下载中记录读取任务信息
  
  @param taskList table 任务列表 (输出参数)
  @return number 任务数量
--]]
local function readOndownloadRecord(taskList)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 获取脚本路径
    local script = cursor:get("aria2", "main", "script")
    local count = 0
    
    -- 执行脚本获取下载中的任务
    local cmd = script .. " ondownload " .. "read"
    local pipe = io.popen(cmd)
    assert(pipe, "run cmd fail")
    
    local output = pipe:read("*all")
    local taskInfo = {}
    
    for line in output:gmatch("[^\n]+") do
        if line and line ~= "" then
            taskInfo = json.decode(line)
            table.insert(taskList, taskInfo)
            count = count + 1
        end
    end
    
    return count
end

--[[
  获取记录文件中的任务数量
  
  @param taskList table 任务列表 (输出参数)
  @param recordType string 记录类型
  @return number 任务数量
  @return number 错误码
--]]
local function getRecordCount(taskList, recordType)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local fs = require("nixio.fs")
    local count = 0
    
    -- 检查记录类型是否有效
    if not isReservedRecordFile(recordType) then
        return 0, 2915
    end
    
    -- 获取记录文件路径
    local recordFile = cursor:get("aria2", "main", recordType)
    
    if not recordFile or recordFile == "" then
        return 0, 2926
    end
    
    -- 读取记录数量
    count = readRecordFile(taskList, recordType)
    
    return count, 0
end

--[[
  同步下载记录
--]]
local function syncOndownloadRecord()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " ondownload " .. "sync"
    
    XQFunction.forkExec(cmd)
end

--[[
  检查脚本是否正在运行
  
  @return boolean 是否正在运行
--]]
local function isScriptRunning()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 获取锁文件路径
    local lockFile = cursor:get("aria2", "main", "lock")
    
    -- 检查进程数
    local cmd = "ps|grep -c " .. lockFile
    local pipe = io.popen(cmd)
    assert(pipe, "run cmd fail")
    
    local output = pipe:read("*all")
    output = string.gsub(output, "\n", "")
    local count = tonumber(output)
    
    -- 如果进程数大于2，说明脚本正在运行
    if 2 < count then
        return true
    else
        return false
    end
end

--[[
  获取所有下载任务信息
  包括下载中、已完成、出错的任务
  
  @return table 任务信息汇总
  @return number 错误码
--]]
function tellAll()
    local errorCode
    local summary = {
        ondownload_num = 0,
        complete_num = 0,
        error_num = 0
    }
    
    local ondownloadList = {}
    local completeList = {}
    local errorList = {}
    
    -- 检查脚本是否正在运行
    if isScriptRunning() then
        return summary, 2925
    else
        syncOndownloadRecord()
    end
    
    -- 读取下载中的任务
    local count, err = getRecordCount(ondownloadList, "ondownload_record_file")
    errorCode = err
    summary.ondownload_num = count
    
    if errorCode ~= 0 then
        return summary, errorCode
    end
    summary.ondownload = ondownloadList
    
    -- 读取已完成的任务
    count, err = readRecordFile(completeList, "complete_record_file")
    errorCode = err
    summary.complete_num = count
    
    if errorCode ~= 0 then
        return summary, errorCode
    end
    summary.complete = completeList
    
    -- 读取出错的任务
    count, err = readRecordFile(errorList, "error_record_file")
    errorCode = err
    summary.error_num = count
    
    if errorCode ~= 0 then
        return summary, errorCode
    end
    summary.error = errorList
    
    return summary, errorCode
end

--[[
  更新基本记录
  
  @param field1 string 字段1
  @param value1 string 值1
  @param field2 string 字段2
  @param value2 string 值2
--]]
local function updateBasicRecord(field1, value1, field2, value2)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " basic_record update " .. field1 .. " " .. value1 .. " " .. field2 .. " " .. value2
    
    XQFunction.forkExec(cmd)
end

--[[
  更新下载中记录的备份
  
  @param field1 string 字段1
  @param value1 string 值1
  @param field2 string 字段2
  @param value2 string 值2
--]]
local function updateOndownloadBackup(field1, value1, field2, value2)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " ondownload backup_update " .. field1 .. " " .. value1 .. " " .. field2 .. " " .. value2
    
    XQFunction.forkExec(cmd)
end

--[[
  从基本记录中查找关联的GID
  
  @param gid string 当前GID
  @return string 关联的GID (如果存在)
--]]
local function findFollowedByGid(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local recordFile = cursor:get("aria2", "main", "basic_file")
    local file = io.open(recordFile, "r")
    assert(file, "read file is nil")
    
    for line in file:lines() do
        if line and line ~= "" then
            local record = json.decode(line)
            for key, value in pairs(record) do
                if key == "followedby" and value == gid then
                    return record.gid
                end
            end
        end
    end
    
    return nil
end

--[[
  批量暂停任务并更新记录
  
  @param taskData table 任务数据
  @param gidList table GID列表
  @param isPause boolean 是否暂停
  @return number 处理的任务数量
--]]
local function pauseTasksWithRecord(taskData, gidList, isPause)
    local count = 0
    local pauseStr = tostring(isPause)
    local followedGid = nil
    
    if not taskData then
        return count
    end
    
    for i = 1, #taskData do
        if type(taskData[i]) == "table" then
            for _, item in pairs(taskData[i]) do
                if type(item) == "number" then
                    if type(item) == "string" then
                        if isValidGid(item) then
                            followedGid = findFollowedByGid(item)
                            
                            if followedGid then
                                if isValidGid(followedGid) then
                                    goto continue
                                end
                            end
                            
                            -- 更新记录
                            updateBasicRecord("gid", item, "pause", pauseStr)
                            updateOndownloadBackup("gid", item, "pause", pauseStr)
                            
                            ::continue::
                            count = count + 1
                        end
                    end
                end
            end
        elseif type(taskData[i]) == "string" then
            if not isValidGid(taskData[i]) then
                goto skip
            end
            
            followedGid = findFollowedByGid(taskData[i])
            
            if followedGid then
                if isValidGid(followedGid) then
                    goto skip_update
                end
            end
            
            updateBasicRecord("gid", taskData[i], "pause", pauseStr)
            updateOndownloadBackup("gid", taskData[i], "pause", pauseStr)
            
            ::skip_update::
            count = count + 1
        else
            return count
        end
        
        ::skip::
    end
    
    return count
end

--[[
  暂停指定的下载任务
  
  @param gidList table GID列表
  @return table 操作结果
  @return number 错误码
--]]
function pause(gidList)
    local method = "system.multicall"
    local paramsStr = "[["
    local count = 0
    local result, errorCode = nil, nil
    
    -- 构建批量暂停参数
    for _, gid in ipairs(gidList) do
        if isValidGid(gid) then
            count = count + 1
            paramsStr = paramsStr .. "{'methodName':'aria2.forcePause','params':['" .. gid .. "']}"
        end
    end
    
    paramsStr = paramsStr .. "]]"
    
    local params = json.decode(paramsStr)
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = response
    errorCode = err
    
    -- 更新记录
    pauseTasksWithRecord(response, gidList, true)
    
    if 0 < count then
        errorCode = 0
    else
        errorCode = 2904
    end
    
    return result, errorCode
end

--[[
  恢复指定的下载任务
  
  @param gidList table GID列表
  @return table 操作结果
  @return number 错误码
--]]
function unpause(gidList)
    local errorCode = 0
    local result = nil
    local method = "system.multicall"
    local paramsStr = "[["
    local count = 0
    
    -- 构建批量恢复参数
    for _, gid in ipairs(gidList) do
        if isValidGid(gid) then
            count = count + 1
            paramsStr = paramsStr .. "{'methodName':'aria2.unpause','params':['" .. gid .. "']}"
        end
    end
    
    paramsStr = paramsStr .. "]]"
    
    local params = json.decode(paramsStr)
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = response
    errorCode = err
    
    -- 更新记录
    pauseTasksWithRecord(response, gidList, false)
    
    if 0 < count then
        errorCode = 0
    else
        errorCode = 2904
    end
    
    return result, errorCode
end

--[[
  暂停所有下载任务
  
  @return table 操作结果
  @return number 错误码
--]]
function pauseAll()
    local method = "aria2.pauseAll"
    local errorCode = nil
    
    local result = json.rpc.call(ARIA2_RPC_URL, method)
    
    local parsed, err = parseRpcResponse(result)
    errorCode = err
    result = parsed
    
    if errorCode ~= 0 then
        XQLog.log(4, "pauseAll " .. errorCode)
        errorCode = 2920
    end
    
    return result, errorCode
end

--[[
  恢复所有下载任务
  
  @return table 操作结果
  @return number 错误码
--]]
function unpauseAll()
    local method = "aria2.unpauseAll"
    local errorCode = nil
    
    local result, err = json.rpc.call(ARIA2_RPC_URL, method)
    errorCode = err
    
    local parsed, parseErr = parseRpcResponse(result)
    errorCode = parseErr
    result = parsed
    
    if errorCode ~= 0 then
        XQLog.log(4, "unpauseAll " .. errorCode)
        errorCode = 2921
    end
    
    return result, errorCode
end

--[[
  从基本记录中删除任务
  
  @param gid string 任务GID
--]]
local function deleteFromBasicRecord(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " basic_record " .. "delete " .. gid
    
    XQFunction.forkExec(cmd)
end

--[[
  从下载中记录备份中删除任务
  
  @param gid string 任务GID
--]]
local function deleteFromOndownloadBackup(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " ondownload " .. "backup_delete " .. gid
    
    XQFunction.forkExec(cmd)
end

--[[
  删除任务及其记录
  
  @param gidList table GID列表
  @return number 删除的任务数量
--]]
local function deleteTasksWithRecord(gidList)
    local count = 0
    local followedGid = nil
    
    for i = 1, #gidList do
        if type(gidList[i]) == "string" then
            if isValidGid(gidList[i]) then
                followedGid = findFollowedByGid(gidList[i])
                
                if followedGid then
                    if isValidGid(followedGid) then
                        -- 删除关联任务的记录
                        deleteFromBasicRecord(followedGid)
                        deleteFromOndownloadBackup(followedGid)
                    end
                else
                    -- 删除当前任务的记录
                    deleteFromBasicRecord(gidList[i])
                    deleteFromOndownloadBackup(gidList[i])
                end
                
                count = count + 1
            end
        elseif type(gidList[i]) == "table" then
            for _, gid in pairs(gidList[i]) do
                if isValidGid(gid) then
                    followedGid = findFollowedByGid(gid)
                    
                    if followedGid then
                        if isValidGid(followedGid) then
                            deleteFromBasicRecord(followedGid)
                            deleteFromOndownloadBackup(followedGid)
                        end
                    else
                        deleteFromBasicRecord(gid)
                        deleteFromOndownloadBackup(gid)
                    end
                    
                    count = count + 1
                end
            end
        end
    end
    
    return count
end

--[[
  删除下载任务
  
  @param gidList table GID列表
  @return table 操作结果
  @return number 错误码
--]]
function remove(gidList)
    local errorCode = 0
    local result = nil
    local method = "system.multicall"
    local paramsStr = "[["
    
    -- 构建批量删除参数
    for _, gid in ipairs(gidList) do
        if isValidGid(gid) then
            paramsStr = paramsStr .. "{'methodName':'aria2.remove','params':['" .. gid .. "']}"
        end
    end
    
    paramsStr = paramsStr .. "]]"
    
    local params = json.decode(paramsStr)
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = response
    
    if 0 < #gidList then
        errorCode = 0
    else
        errorCode = 2906
    end
    
    return result, errorCode
end

--[[
  从RPC响应中提取GID
  
  @param response table RPC响应
  @param index number 索引
  @param taskList table 任务列表
  @return table 更新后的任务列表
--]]
local function extractGidFromResponse(response, index, taskList)
    local task = taskList[index]
    
    if not response then
        return task
    end
    
    if type(response) == "table" then
        for _, item in pairs(response) do
            if type(item) == "number" then
                if type(item) == "string" then
                    if isValidGid(item) then
                        task.gid = item
                    end
                end
            end
        end
    elseif type(response) == "string" then
        if isValidGid(response) then
            task.gid = response
        end
    else
        return task
    end
    
    return task
end

--[[
  清理无效的任务
  
  @param taskList table 任务列表
  @param count number 任务数量
  @return number 清理后的任务数量
--]]
local function cleanInvalidTasks(taskList, count)
    local newCount = count
    
    for i = 1, count do
        local task = taskList[i]
        
        if not task then
            break
        end
        
        local gid = task.gid
        
        if gid then
            if isValidGid(gid) then
                goto continue
            end
        end
        
        -- 移除无效任务
        table.remove(taskList, i)
        newCount = newCount - 1
        
        ::continue::
    end
    
    return newCount
end

--[[
  批量提取GID
  
  @param response table RPC响应
  @param count number 任务数量
  @param taskList table 任务列表
  @return number 处理的数量
--]]
local function batchExtractGid(response, count, taskList)
    local processed = 0
    
    for i = 1, count do
        extractGidFromResponse(response[i], i, taskList)
    end
    
    return processed
end

--[[
  更新BT任务的选择文件
  
  @param taskList table 任务列表
  @param count number 任务数量
  @return number 错误码
--]]
local function updateBtSelectFile(taskList, count)
    local errorCode = 0
    local task = nil
    
    if not count or count == 0 then
        return errorCode
    end
    
    for i = 1, count do
        task = taskList[i]
        
        local followingGid = findFollowedByGid(task.gid)
        
        if followingGid then
            if isValidGid(followingGid) then
                goto continue
            end
        end
        
        -- 更新选择文件记录
        updateBasicRecord("gid", task.gid, "select-file", task["select-file"])
        updateOndownloadBackup("gid", task.gid, "select-file", task["select-file"])
        
        ::continue::
    end
    
    return errorCode
end

--[[
  修改下载任务选项 (如选择文件)
  
  @param gidList table GID列表
  @param selectFile string 选择的文件索引
  @return table 操作结果
  @return number 错误码
--]]
function changeOption(gidList, selectFile)
    local method = "system.multicall"
    local result, errorCode, response = nil, nil, nil
    local count = 0
    local taskList = {}
    local taskInfo = {}
    local paramsStr = "[["
    
    -- 构建批量修改参数
    for _, gid in ipairs(gidList) do
        count = count + 1
        taskInfo.pause = false
        taskInfo["select-file"] = selectFile
        
        XQLog.log(5, "#gid=" .. gid .. " select=" .. selectFile)
        
        -- 添加changeOption和unpause调用
        paramsStr = paramsStr .. "{'methodName':'aria2.changeOption','params':['" .. gid .. "'" .. "{'select-file':'" .. selectFile .. "'}]}"
        paramsStr = paramsStr .. "{'methodName':'aria2.unpause','params':['" .. gid .. "']}"
        
        table.insert(taskList, taskInfo)
        taskInfo = {}
    end
    
    paramsStr = paramsStr .. "]]"
    
    local params = json.decode(paramsStr)
    response, errorCode = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = taskList
    
    if 0 < count then
        -- 更新记录
        updateBtSelectFile(taskList, count)
        errorCode = 0
    else
        errorCode = 2904
    end
    
    return result, errorCode
end

--[[
  清理已完成的任务记录
  
  @param gidList table GID列表
  @return number 清理的数量
--]]
function clean(gidList)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " complete_record delete "
    
    for _, gid in ipairs(gidList) do
        XQLog.log(5, "clean " .. gid)
        XQFunction.forkExec(cmd .. gid)
    end
    
    return #gidList
end

--[[
  删除出错的任务记录
  
  @param gidList table GID列表
  @return number 删除的数量
--]]
function errorDelete(gidList)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " error_record delete "
    
    for _, gid in ipairs(gidList) do
        XQLog.log(5, "error delete : " .. gid)
        
        -- 检查GID是否有效
        if isValidGid(gid) then
            local followedGid = findFollowedByGid(gid)
            
            if followedGid then
                if isValidGid(followedGid) then
                    deleteFromBasicRecord(followedGid)
                    deleteFromOndownloadBackup(followedGid)
                end
            else
                deleteFromBasicRecord(gid)
                deleteFromOndownloadBackup(gid)
            end
        end
        
        XQFunction.forkExec(cmd .. gid)
    end
    
    return #gidList
end

--[[
  获取文件或目录大小
  
  @param path string 路径
  @return string 大小 (字节)
--]]
local function getFileSize(path)
    local cmd = "du -sk '" .. path .. "'|awk '{printf $1 * 1024}'"
    local size = luci.util.exec(cmd)
    return size
end

--[[
  验证下载路径是否有效
  
  @param path string 路径
  @param isRoot boolean 是否允许根目录
  @return number 错误码，0表示有效
--]]
local function validateDownloadPath(path, isRoot)
    local fs = require("nixio.fs")
    local lostFoundPattern = "/lost%+found"
    
    -- 检查路径是否为空
    if not path or path == "" then
        return 2907
    end
    
    -- 检查路径是否存在
    local realPath = fs.realpath(path)
    if realPath == nil then
        return 2908
    end
    
    -- 检查路径是否在/mnt目录下
    if isRoot then
        local found = string.find(realPath, "/mnt")
        if found == nil then
            return 2917
        end
    else
        local found = string.find(realPath, "/mnt/")
        if found == nil then
            return 2917
        end
        
        -- 检查是否为lost+found目录
        local lostFound = string.find(realPath, lostFoundPattern, #lostFoundPattern)
        if lostFound ~= nil then
            return 2922
        end
    end
    
    return 0
end

--[[
  获取Aria2进程PID
  
  @return string PID，如果未运行返回空字符串
--]]
local function getAria2Pid()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    -- 获取PID文件路径
    local pidFile = cursor:get("aria2", "main", "pid")
    
    -- 读取PID文件
    local file = io.open(pidFile)
    local pid = nil
    
    if file then
        pid = file:read("*all")
    end
    
    if pid then
        pid = string.gsub(pid, "\n", "")
    else
        return ""
    end
    
    if pid then
        pid = tonumber(pid)
    else
        return ""
    end
    
    if not pid or pid == "" then
        return ""
    end
    
    -- 检查进程是否存在
    local cmd = "ps | awk '{ print $1 }' | grep -e '^" .. pid .. "'"
    local pipe = io.popen(cmd)
    
    if pipe then
        return pipe:read("*all")
    end
    
    return ""
end

--[[
  获取搜索结果
  
  @param resultFile string 结果文件路径
  @return table 搜索结果列表
  @return number 状态码
  @return number 错误码
--]]
function getSearchResult(resultFile)
    local result = {}
    local fileInfo = {}
    local count = 0
    
    -- 检查Aria2是否运行
    local pid = getAria2Pid()
    local status
    
    if pid == "" then
        status = "0"
    else
        status = "1"
    end
    
    -- 打开结果文件
    local file = io.open(resultFile)
    
    if not file then
        XQLog.log(4, "file open failed: " .. resultFile)
        return nil, 2916
    end
    
    local content = file:read("*all")
    
    -- 解析每一行
    for line in content:gmatch("[^\n]+") do
        fileInfo.path = line
        fileInfo.name = extractFileName(line, "/")
        
        -- 尝试打开文件获取大小
        local f = io.open(line, "rb")
        
        if not f then
            XQLog.log(5, "file open failed: " .. line)
            return nil, 2916
        end
        
        fileInfo.size = getFileSize(line)
        
        if fileInfo and next(fileInfo) ~= nil then
            table.insert(result, fileInfo)
            fileInfo = {}
        end
    end
    
    return result, count, status
end

--[[
  搜索BT种子文件
  
  @param searchPath string 搜索路径
  @param action string 操作类型: start/stop/get
  @return table 搜索结果
  @return number 错误码
  @return string 状态
--]]
function searchBitTorrentFile(searchPath, action)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local errorCode = 0
    local result = {}
    
    -- 获取搜索结果文件路径
    local searchResultFile = cursor:get("aria2", "main", "search")
    local script = cursor:get("aria2", "main", "script")
    local status = nil
    
    -- 验证搜索路径
    local pathError = validateDownloadPath(searchPath, true)
    if pathError ~= 0 then
        return nil, pathError
    end
    
    -- 验证操作类型
    if action ~= "start" and action ~= "stop" and action ~= "get" then
        return nil, 2918
    end
    
    -- 定义操作函数
    local actions = {}
    
    actions.start = function()
        -- 先停止之前的搜索
        os.execute(script .. " search " .. "stop")
        -- 启动新的搜索
        local cmd = script .. " search " .. searchPath .. " " .. searchResultFile
        XQFunction.forkExec(cmd)
    end
    
    actions.stop = function()
        local cmd = script .. " search " .. searchPath .. " " .. searchResultFile
        XQFunction.forkExec(cmd)
    end
    
    actions.get = function()
        result, errorCode, status = getSearchResult(searchResultFile)
    end
    
    actions[""] = function()
        errorCode = 2916
    end
    
    -- 执行操作
    local actionFunc = actions[action]
    if actionFunc then
        actionFunc()
    else
        errorCode = 2915
    end
    
    return result, errorCode, status
end

--[[
  写入输入文件 (用于添加下载任务)
  
  @param taskInfo table 任务信息
--]]
local function writeInputFile(taskInfo)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local inputFile = cursor:get("aria2", "main", "input_file")
    
    local file = io.open(inputFile, "a")
    assert(file, "read file is nil")
    
    -- 写入下载链接
    file:write(taskInfo.link .. "\n")
    file:write(" gid=" .. taskInfo.gid .. "\n")
    file:write(" dir=" .. taskInfo.dir .. "\n")
    file:write(" pause=true\n")
    file:write(" select-file=\n")
    
    if taskInfo.pause then
        file:write(" pause=" .. tostring(taskInfo.pause) .. "\n")
    end
    
    file:close()
end

--[[
  写入基本记录文件
  
  @param taskInfo table 任务信息
--]]
local function writeBasicFile(taskInfo)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    
    local file = io.open(basicFile, "a")
    assert(file, "read file is nil")
    
    if taskInfo.gid then
        if isValidGid(taskInfo.gid) then
            local jsonStr = json.encode(taskInfo)
            file:write(jsonStr .. "\n")
        end
    end
    
    file:close()
end

--[[
  批量写入任务记录
  
  @param taskList table 任务列表
  @param count number 任务数量
--]]
local function batchWriteRecords(taskList, count)
    for i = 1, count do
        writeInputFile(taskList[i])
        writeBasicFile(taskList[i])
    end
end

--[[
  检查链接是否已存在于记录中
  
  @param link string 下载链接
  @return boolean 是否存在
--]]
local function isLinkExist(link)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    local file = io.open(basicFile, "r")
    assert(file, "read file is nil")
    
    for line in file:lines() do
        if line and line ~= "" then
            local record = json.decode(line)
            for key, value in pairs(record) do
                if key == "link" and link == value then
                    return true
                end
            end
        end
    end
    
    return false
end

--[[
  检查MD5是否已存在 (用于种子文件去重)
  
  @param md5 string MD5值
  @return boolean 是否存在
--]]
local function isMd5Exist(md5)
    local sys = require("luci.sys")
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    
    local cmd = "grep -sq -m 1 '" .. "\"md5\": \"" .. md5 .. "\"' " .. basicFile
    local result = sys.call(cmd)
    
    return result == 0
end

--[[
  构建添加URI的RPC参数
  
  @param paramsStr string 当前参数字符串
  @param uri string 下载URI
  @param dir string 下载目录
  @param pause string 是否暂停 ("pause"或其他)
  @return string 更新后的参数字符串
--]]
local function buildAddUriParams(paramsStr, uri, dir, pause)
    if pause and pause == "pause" then
        paramsStr = paramsStr .. "{'methodName':'aria2.addUri','params':['token:Just4Aria2 c',['" .. uri .. "']" .. "{'dir':'" .. dir .. "','pause':'true'" .. "}" .. "]}"
    else
        paramsStr = paramsStr .. "{'methodName':'aria2.addUri','params':['token:Just4Aria2 c',['" .. uri .. "']" .. "{'dir':'" .. dir .. "'}" .. "]}"
    end
    
    return paramsStr
end

--[[
  构建修改全局下载目录的RPC参数
  
  @param paramsStr string 当前参数字符串
  @param dir string 下载目录
  @return string 更新后的参数字符串
--]]
local function buildChangeDirParams(paramsStr, dir)
    paramsStr = paramsStr .. "{'methodName':'aria2.changeGlobalOption','params':[{'dir':'" .. dir .. "'}]}"
    return paramsStr
end

--[[
  添加URI下载任务
  
  @param uriData table URI数据
  @param dir string 下载目录
  @param pause string 是否暂停
  @param skipCheck boolean 是否跳过重复检查
  @return table 操作结果
  @return number 错误码
--]]
function addUri(uriData, dir, pause, skipCheck)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local method = "system.multicall"
    local paramsStr = "[["
    local result = {}
    local errorCode = 0
    local taskList = {}
    local taskInfo = {}
    local taskCount = 0
    
    -- 验证下载目录
    local pathError = validateDownloadPath(dir, false)
    if pathError ~= 0 then
        return nil, pathError
    end
    
    -- 解析URI数据
    if type(uriData) ~= "table" then
        errorCode = 2915
    else
        for key, value in pairs(uriData) do
            if key == "uris" then
                if type(value) == "table" then
                    for _, uri in pairs(value) do
                        if skipCheck then
                            paramsStr = buildAddUriParams(paramsStr, uri, dir, pause)
                        else
                            -- 检查链接是否已存在
                            if not isLinkExist(uri) then
                                taskCount = taskCount + 1
                                taskInfo.link = uri
                                taskInfo.dir = dir
                                taskInfo.linktype = "uri"
                                table.insert(taskList, taskInfo)
                                paramsStr = buildAddUriParams(paramsStr, uri, dir, pause)
                            end
                        end
                    end
                elseif type(value) == "string" then
                    if skipCheck then
                        paramsStr = buildAddUriParams(paramsStr, value, dir, pause)
                    elseif not isLinkExist(value) then
                        taskCount = taskCount + 1
                        taskInfo.link = value
                        taskInfo.dir = dir
                        taskInfo.linktype = "uri"
                        table.insert(taskList, taskInfo)
                        taskInfo = {}
                        paramsStr = buildAddUriParams(paramsStr, value, dir, pause)
                    end
                else
                    errorCode = 2913
                    XQLog.log(4, " " .. value .. ": not a table, check json format")
                    return nil, errorCode
                end
            end
        end
    end
    
    -- 检查是否需要修改全局下载目录
    local currentDir = cursor:get("aria2", "main", "dir")
    if dir ~= currentDir then
        cursor:set("aria2", "main", "dir", dir)
        cursor:commit("aria2")
        paramsStr = buildChangeDirParams(paramsStr, dir)
    end
    
    paramsStr = paramsStr .. "]]"
    
    -- 调用RPC
    local params = json.decode(paramsStr)
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    
    result = response
    errorCode = err
    
    if errorCode ~= 0 then
        errorCode = 2912
    end
    
    -- 处理结果
    if not skipCheck then
        if 0 < taskCount then
            -- 提取GID并写入记录
            batchExtractGid(response, taskCount, taskList)
            batchWriteRecords(taskList, taskCount)
            errorCode = 0
        else
            errorCode = 2911
        end
    end
    
    return result, errorCode
end

--[[
  检查文件扩展名
  
  @param filename string 文件名
  @param extension string 扩展名
  @return number 0表示匹配，1表示不匹配
--]]
local function checkFileExtension(filename, extension)
    local extLen = #extension
    local suffix = string.sub(filename, 0 - extLen)
    
    if suffix == extension then
        return 0
    end
    
    return 1
end

--[[
  比较文件大小
  
  @param size1 string 大小1
  @param size2 string 大小2 (限制值)
  @return number 1表示size1大于size2，0表示不大于
--]]
local function compareFileSize(size1, size2)
    local num1 = tonumber(size1 .. ".0")
    local num2 = tonumber(size2 .. ".0")
    
    if num1 > num2 then
        return 1
    end
    
    return 0
end

--[[
  验证种子文件
  
  @param filePath string 文件路径
  @return number 错误码，0表示有效
--]]
local function validateTorrentFile(filePath)
    local result = 0
    
    -- 检查扩展名
    result = checkFileExtension(filePath, ".torrent")
    if result ~= 0 then
        return 2923  -- 非种子文件
    end
    
    -- 检查文件大小 (限制45MB)
    result = compareFileSize(getFileSize(filePath), "47185920")
    if result ~= 0 then
        return 2924  -- 文件过大
    end
    
    return 0
end

--[[
  Base64编码文件内容
  
  @param filePath string 文件路径
  @return string Base64编码后的内容
--]]
local function base64EncodeFile(filePath)
    local cmd = "base64 " .. "'" .. filePath .. "'"
    local pipe = io.popen(cmd)
    assert(pipe, "base64Encode fail")
    
    local content = pipe:read("*all")
    return content
end

--[[
  添加BT种子下载任务
  
  @param torrentPath string 种子文件路径
  @param dir string 下载目录
  @param pause string 是否暂停 ("pause"或其他)
  @param skipCheck boolean 是否跳过重复检查
  @return table 操作结果
  @return number 错误码
--]]
function addTorrent(torrentPath, dir, pause, skipCheck)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local result = {}
    local errorCode = nil
    local taskList = {}
    local taskInfo = {}
    local method = "system.multicall"
    local paramsStr = "[["
    local base64Content = nil
    local md5 = nil
    
    -- 验证下载目录
    local pathError = validateDownloadPath(dir, false)
    if pathError ~= 0 then
        return nil, pathError
    end
    
    -- 验证种子文件路径
    pathError = validateDownloadPath(torrentPath, false)
    if pathError ~= 0 then
        return nil, pathError
    end
    
    -- 验证种子文件
    local torrentError = validateTorrentFile(torrentPath)
    if torrentError ~= 0 then
        return nil, torrentError
    end
    
    -- 计算种子文件MD5
    md5 = XQCryptoUtil.md5File(torrentPath)
    if not md5 then
        return nil, 2901
    end
    
    -- 检查是否已存在相同的种子
    if not skipCheck then
        if isMd5Exist(md5) then
            return nil, 2911
        end
    end
    
    -- Base64编码种子文件
    base64Content = base64EncodeFile(torrentPath)
    
    -- 构建RPC参数
    if pause and pause == "pause" then
        paramsStr = paramsStr .. "{'methodName':'aria2.addTorrent','params':['" .. base64Content .. "'," .. "[''],{'pause':'true','dir':'" .. dir .. "'}]}"
    else
        paramsStr = paramsStr .. "{'methodName':'aria2.addTorrent','params':['" .. base64Content .. "'," .. "[''],{'dir':'" .. dir .. "'}]}"
    end
    
    -- 记录任务信息
    if not skipCheck then
        taskInfo.linktype = "torrent"
        taskInfo.link = torrentPath
        taskInfo.dir = dir
        taskInfo.md5 = md5
        table.insert(taskList, taskInfo)
    end
    
    -- 检查是否需要修改全局下载目录
    local currentDir = cursor:get("aria2", "main", "dir")
    if dir ~= currentDir then
        cursor:set("aria2", "main", "dir", dir)
        cursor:commit("aria2")
        paramsStr = paramsStr .. "{'methodName':'aria2.changeGlobalOption','params':[{'dir':'" .. dir .. "'}]}"
    end
    
    paramsStr = paramsStr .. "]]"
    
    -- 调用RPC
    local params = json.decode(paramsStr)
    local response = json.rpc.call(ARIA2_RPC_URL, method, params)
    result = response
    
    -- 解析响应
    local parsed, parseErr = parseRpcResponse(result)
    errorCode = parseErr
    result = parsed
    
    if not errorCode then
        errorCode = 0
    else
        errorCode = 2901
    end
    
    -- 处理结果
    if not skipCheck then
        local extractedCount = batchExtractGid(result, 1, taskList)
        
        if 0 < extractedCount then
            batchWriteRecords(taskList, extractedCount)
            errorCode = 0
        else
            errorCode = 2901
        end
    end
    
    return result, errorCode
end

--[[
  根据GID获取文件路径
  
  @param gid string 任务GID
  @return string 文件路径
--]]
function filePathGet(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    local file = nil
    local path = ""
    
    if gid == "" then
        return path
    end
    
    file = io.open(basicFile, "r")
    
    for line in file:lines() do
        if line and line ~= "" then
            local ok, record = pcall(json.decode, line)
            
            if ok then
                if record.gid == gid then
                    path = record.path or path
                    if not record.path then
                        path = "/path/not/exist"
                    end
                end
            end
        end
        
        if path ~= "" then
            break
        end
    end
    
    file:close()
    
    return path
end

--[[
  检查路径是否有效
  
  @param path string 路径
  @return number 错误码
--]]
function checkPath(path)
    return validateDownloadPath(path, false)
end

--[[
  标记文件不存在
  
  @param gid string 任务GID
--]]
function fileNotExist(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local script = cursor:get("aria2", "main", "script")
    local cmd = script .. " complete_record modify " .. gid
    
    XQFunction.forkExec(cmd)
end

--[[
  获取Aria2服务状态
  
  @return string 状态值
  @return number 错误码
--]]
function getStatus()
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local status = cursor:get("aria2", "main", "status")
    
    return status, 0
end

--[[
  验证状态值是否有效
  
  @param status number 状态值
  @return boolean 是否有效
--]]
local function isValidStatus(status)
    local validStatus = {
        [0] = true,
        [1] = true
    }
    
    return validStatus[status]
end

--[[
  设置Aria2服务状态
  
  @param status string 状态值 ("0"或"1")
  @return string 设置后的状态
  @return number 错误码
--]]
function setStatus(status)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local statusNum = tonumber(status)
    
    -- 验证状态值
    if not isValidStatus(statusNum) then
        return nil, 2915
    end
    
    -- 获取当前状态
    local currentStatus = tonumber(cursor:get("aria2", "main", "status"))
    
    -- 如果状态不同则更新
    if currentStatus ~= statusNum then
        cursor:set("aria2", "main", "status", statusNum)
        cursor:commit("aria2")
    end
    
    return statusNum, 0
end

--[[
  从记录文件中获取任务详细信息
  
  @param taskInfo table 任务信息 (输出参数)
  @param gid string 任务GID
--]]
local function getTaskDetailFromRecord(taskInfo, gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    local file = io.open(basicFile, "r")
    
    for line in file:lines() do
        if line and line ~= "" then
            local record = json.decode(line)
            
            -- 匹配GID或followedby
            if record.gid ~= gid then
                if record.followedby ~= gid then
                    goto continue
                end
            end
            
            -- 复制任务信息
            taskInfo.link = record.link
            taskInfo.dir = record.dir
            taskInfo.linktype = record.linktype
            
            if record.select_file then
                taskInfo.select_file = record.select_file
            end
        end
        
        ::continue::
    end
    
    file:close()
end

--[[
  删除任务关联的文件
  
  @param gid string 任务GID
--]]
local function deleteTaskFiles(gid)
    local uci = require("luci.model.uci")
    local cursor = uci.cursor()
    local fs = require("nixio.fs")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local basicFile = cursor:get("aria2", "main", "basic_file")
    local files = {}
    local cmd = nil
    
    local file = io.open(basicFile, "r")
    
    for line in file:lines() do
        if line and line ~= "" then
            local record = json.decode(line)
            
            if record.gid == gid then
                -- 构建文件路径
                files.file = record.dir .. "/" .. record.filename
                files[".aria2"] = record.dir .. "/" .. record.filename .. ".aria2"
                
                -- 删除主文件
                if files.file then
                    local realPath = fs.realpath(files.file)
                    if realPath then
                        cmd = "rm -r '" .. files.file .. "'"
                        XQFunction.forkExec(cmd)
                    end
                end
                
                -- 删除.aria2控制文件
                if files[".aria2"] then
                    local realPath = fs.realpath(files[".aria2"])
                    if realPath then
                        cmd = "rm '" .. files[".aria2"] .. "'"
                        XQFunction.forkExec(cmd)
                    end
                end
                
                file:close()
                return
            end
        end
    end
    
    file:close()
end

--[[
  重新启动失败的下载任务
  
  @param gidList table GID列表
  @return table 操作结果
  @return number 错误码
--]]
function restart(gidList)
    local taskInfo = {}
    local result, errorCode, newGid = nil, nil, nil
    local uriList = {}
    
    -- 获取任务详细信息
    getTaskDetailFromRecord(taskInfo, gidList[1])
    
    -- 删除旧的错误记录
    deleteTaskFiles(gidList[1])
    
    -- 根据任务类型重新添加
    if taskInfo.linktype == "torrent" then
        result, errorCode = addTorrent(taskInfo.link, taskInfo.dir, "", true)
    elseif taskInfo.linktype == "uri" then
        table.insert(uriList, taskInfo.link)
        result, errorCode = addUri(uriList, taskInfo.dir, "", true)
    end
    
    if errorCode ~= 0 then
        return result, errorCode
    end
    
    -- 获取新的GID
    newGid = result[1]
    
    if newGid then
        if not isValidGid(newGid) then
            return result, 2927
        end
    else
        return result, 2927
    end
    
    -- 更新记录中的GID
    updateBasicRecord("gid", gidList[1], "gid", newGid)
    updateBasicRecord("followedby", gidList[1], "gid", newGid)
    
    -- 删除错误记录
    errorDelete(gidList)
    
    -- 写入新的基本记录
    taskInfo.gid = newGid
    writeBasicFile(taskInfo)
    
    return result, errorCode
end
