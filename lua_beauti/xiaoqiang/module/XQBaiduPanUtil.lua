--[[
  小米路由器 - 百度网盘工具模块
  功能: 提供百度网盘文件上传、下载、同步等功能
  模块名: xiaoqiang.module.XQBaiduPanUtil
]]

module("xiaoqiang.module.XQBaiduPanUtil", package.seeall)

-- 引入依赖模块
local luciHttp = require("luci.http")                           -- HTTP库
local XQLog = require("xiaoqiang.XQLog")                        -- 日志模块
local XQFunction = require("xiaoqiang.common.XQFunction")       -- 通用函数库
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")     -- 加密工具
local uci = require("luci.model.uci").cursor()                  -- UCI配置
local nixioFs = require("nixio.fs")                             -- 文件系统操作
local json = require("json")                                     -- JSON解析
local luciUtil = require("luci.util")                           -- Luci工具库

-- 常量定义
local BAIDUPAN_ROOT_DIR = "/来自百度网盘/"                       -- 百度网盘根目录名
local baidupan_debug_level = nil                                 -- 调试级别
local MAX_RETRY_COUNT = 6                                        -- 最大重试次数
local MAX_TASK_COUNT = 100                                       -- 最大任务数

-- 错误码定义
BDPAN_ERROR_CODE = {
    NO_ERRNO = 1600,                    -- 无错误
    ERROR_NOW_RUNNING = 1601,           -- 正在运行中
    ERROR_FILE_NO_EXIST = 1604,         -- 文件不存在
    ERROR_UPLOADLIST_FULL = 1605,       -- 上传列表已满
    ERROR_DOWNLOADLIST_FULL = 1606,     -- 下载列表已满
    ERROR_INTERNAL = 1660,              -- 内部错误
    ERROR_PEER_INFO = 1661,             -- 对端信息错误
    ERROR_CONFIG_TRANS = 1662,          -- 配置传输错误
    ERROR_INVALID_MODE = 1663,          -- 无效模式
    ERROR_INVALID_SIZE = 1664,          -- 无效大小
    ERROR_INVALID_LENGTH = 1665,        -- 无效长度
    ERROR_INVALID_PARAMETER = 1666,     -- 无效参数
    ERROR_INVALID_DISK = 1667,          -- 无效磁盘
    ERROR_PAUSE = 1668,                 -- 暂停错误
    ERROR_UBUS_CALL_FAILED = 1669,      -- UBUS调用失败
    ERROR_DIR_OR_FILE_NAME_EXCEPT = 1670 -- 目录或文件名异常
}

--[[
  获取文件锁
  用于防止多进程同时操作百度网盘
]]
function lock()
    os.execute("lock /var/run/baidupan.lock")
end

--[[
  释放文件锁
]]
function unlock()
    os.execute("lock -u /var/run/baidupan.lock")
end

--[[
  获取文件大小
  @param filePath 文件路径
  @return number 文件大小(字节)
]]
function _file_size(filePath)
    local cmd = "stat -c %s '" .. filePath .. "'"
    local result = luci.util.exec(cmd)
    local sizeStr = result:sub(1, #result - 1)
    local size = tonumber(sizeStr .. ".0") or 0
    return size
end

--[[
  写入文件内容
  @param filePath 文件路径
  @param content  要写入的内容
  @return boolean 成功返回true，失败返回false
]]
local function _write_file(filePath, content)
    local file = io.open(filePath, "w+b")
    if file then
        local result = file:write(content)
        if result == nil then
            return false
        end
        io.close(file)
        return true
    else
        return false
    end
end

--[[
  检查路径是否为目录
  @param path 路径
  @return boolean 是目录返回true
]]
local function _is_directory(path)
    local fileType = nixioFs.stat(path, "type")
    return fileType == "dir"
end

--[[
  检查文件是否存在
  @param filePath 文件路径
  @return boolean 存在返回true
]]
function _file_exists(filePath)
    local file = io.open(filePath, "r")
    if not file then
        return false
    end
    file:close()
    return true
end

--[[
  检查超时文件
  @param filePath 文件路径
  @return boolean 包含超时标记返回true
]]
function checkTimeoutFile(filePath)
    local hasTimeout = false
    local file = io.open(filePath, "r")
    if file then
        local content = file:read()
        io.close(file)
        if content ~= nil then
            -- 检查是否包含超时错误码 31360
            if string.match(content, "31360") then
                hasTimeout = true
            end
        end
    end
    return hasTimeout
end

--[[
  URL编码
  @param str 要编码的字符串
  @return string 编码后的字符串
]]
function xqurlencode(str)
    if str then
        -- 统一换行符
        str = string.gsub(str, "\r?\n", "\r\n")
        -- 编码特殊字符
        str = string.gsub(str, "([^%w%-%.%_%~ ])", function(char)
            return string.format("%%%02X", string.byte(char))
        end)
        -- 空格转换为+
        str = string.gsub(str, " ", "+")
    end
    return str
end

--[[
  执行URL请求(带重试)
  @param cmd 要执行的命令
  @return string 执行结果
]]
function execUrl(cmd)
    local retryCount = 3
    local result = nil
    
    for i = 1, retryCount do
        result = luci.util.exec(cmd)
        if result == nil or result == "" then
            XQLog.log(baidupan_debug_level, "test execUrl loop: " .. i)
            os.execute("sleep 1")
        else
            break
        end
    end
    return result
end

--[[
  检查用户文件大小是否符合会员等级限制
  @param filePath    文件路径
  @param memberLevel 会员等级 ("0"=普通, "1"=会员, "2"=超级会员)
  @return number     错误码，0表示正常
]]
function userFileSize(filePath, memberLevel)
    local errorCode = 0
    local maxSize = 0
    local fileSize = _file_size(filePath)
    
    -- 根据会员等级设置最大文件大小
    if memberLevel == "0" then
        maxSize = 4294967296      -- 4GB (普通用户)
    elseif memberLevel == "1" then
        maxSize = 10737418240     -- 10GB (会员)
    elseif memberLevel == "2" then
        maxSize = 21474836480     -- 20GB (超级会员)
    end
    
    -- 检查文件大小是否超限
    if fileSize > maxSize or fileSize <= 0 then
        errorCode = BDPAN_ERROR_CODE.ERROR_INVALID_SIZE
    end
    
    XQLog.log(baidupan_debug_level, "current size: " .. fileSize .. " max_size: " .. maxSize .. " res: " .. errorCode)
    return errorCode
end

--[[
  格式化文件名(去除空白字符)
  @param fileName 文件名
  @return string 格式化后的文件名
]]
function formatFileName(fileName)
    local result = fileName:gsub("%s+", "")
    result = string.gsub(result, "%s+", "")
    return result
end

--[[
  从URL中提取文件名
  @param url URL地址
  @return string 文件名
]]
function getFileName(url)
    XQLog.log(baidupan_debug_level, "BAIDUPAN getFilename url: " .. url)
    local fileName = url:match("([^/]+)$")
    XQLog.log(baidupan_debug_level, "BAIDUPAN getFilename filename: " .. fileName)
    fileName = formatFileName(fileName)
    XQLog.log(baidupan_debug_level, "BAIDUPAN getFilename format filename: " .. fileName)
    return fileName
end

--[[
  检查文件名长度(中文字符数)
  @param fileName 文件名
  @return number|nil 超过32个中文字符返回错误码
]]
function checkFileName(fileName)
    local _, chineseCount = string.gsub(fileName, "[^\128-\193]", "")
    if chineseCount > 32 then
        return BDPAN_ERROR_CODE.ERROR_INVALID_LENGTH
    end
end

--[[
  获取文件暂停状态
  @param statusFile 状态文件路径
  @return string 暂停状态 ("0"=运行中, "1"=已暂停)
]]
function getFilePauseStat(statusFile)
    local file = io.open(statusFile, "rb")
    if file then
        local content = file:read("*a")
        file:close()
        -- 去除末尾换行符
        content = string.sub(content, 1, -2)
        return content
    else
        return "0"
    end
end

--[[
  暂停上传任务
  @param taskId   任务ID
  @param fileName 文件名
  @param filePath 文件路径
  @param fileSize 文件大小
]]
function puaseUpload(taskId, fileName, filePath, fileSize)
    local msg = taskId .. ":4:" .. fileName .. ":" .. filePath
    sendMsgtoBaidupan("0", msg)
end

--[[
  继续上传任务
  @param taskId   任务ID
  @param fileName 文件名
  @param filePath 文件路径
  @param fileSize 文件大小
]]
function continueUpload(taskId, fileName, filePath, fileSize)
    local timestamp = os.time()
    local msg = taskId .. ":1:" .. fileName .. ":" .. filePath .. ":" .. timestamp .. ":" .. fileSize
    sendMsgtoBaidupan("0", msg)
end

--[[
  从百度网盘下载链接获取文件
  @param downloadUrl 下载链接
  @param accessToken 访问令牌
  @param savePath    保存路径
  @param resumeMode  断点续传模式 ("0"=新下载, 其他=续传)
  @return string|number HTTP状态码或错误码
]]
function getFileFromDlink(downloadUrl, accessToken, savePath, resumeMode)
    if not downloadUrl or not savePath or not accessToken then
        XQLog.log(baidupan_debug_level, "invalid input parameters!")
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    XQLog.log(baidupan_debug_level, "get config from peer: " .. downloadUrl .. " create file" .. savePath)
    
    local cmd
    if resumeMode == "0" then
        -- 新下载
        cmd = "curl -k -L '" .. downloadUrl .. "&access_token=" .. accessToken .. 
              "' -o '" .. savePath .. "' -H 'User-Agent: pan.baidu.com' -w %{http_code}"
    else
        -- 断点续传
        cmd = "curl -k -L -C - '" .. downloadUrl .. "&access_token=" .. accessToken .. 
              "' -o '" .. savePath .. "' -H 'User-Agent: pan.baidu.com' -w %{http_code}"
    end
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN getFileFromDlin URL: " .. cmd)
    
    local result = luci.util.exec(cmd)
    if result == nil or result == "" then
        return BDPAN_ERROR_CODE.ERROR_PAUSE
    else
        XQLog.log(baidupan_debug_level, "BAIDUPAN getFileFromDlink: result: " .. result)
    end
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN getFileFromDlink success")
    return result
end

--[[
  创建百度网盘文件(合并分片)
  @param remotePath  远程路径
  @param accessToken 访问令牌
  @param localPath   本地路径
  @param uploadInfo  上传信息(包含uploadid, block_list, size等)
  @return number 错误码
]]
function routerCreateFilePost(remotePath, accessToken, localPath, uploadInfo)
    local result = {}
    local errorCode = 0
    
    if not remotePath or not accessToken or not localPath or not uploadInfo then
        XQLog.log(baidupan_debug_level, "invalid input parameters!")
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    local fileSize = uploadInfo.size
    
    -- 构建创建文件请求
    local cmd = 'curl -k "https://pan.baidu.com/rest/2.0/xpan/file?method=create&access_token=' .. accessToken .. 
                '" -d \'path=' .. remotePath .. '&size=' .. fileSize .. 
                '&isdir=0&rtype=3&uploadid=' .. uploadInfo.uploadid .. 
                '&block_list=["' .. uploadInfo.block_list .. '"]\' -H "User-Agent: pan.baidu.com"'
    
    local response = execUrl(cmd)
    XQLog.log(baidupan_debug_level, "BAIDUPAN routerCreateFilePost result: " .. response)
    
    if response == nil or response == "" then
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    else
        local jsonResult = json.decode(response)
        XQLog.log(baidupan_debug_level, "BAIDUPAN routerCreateFilePost errno: " .. jsonResult.errno)
        errorCode = jsonResult.errno
    end
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN routerCreateFilePost success")
    return errorCode
end

--[[
  分片上传文件
  @param remotePath  远程路径
  @param accessToken 访问令牌
  @param localPath   本地文件路径
  @param uploadInfo  上传信息
  @param actionId    操作ID
  @return number 错误码
]]
function routerUploadFilePost(remotePath, accessToken, localPath, uploadInfo, actionId)
    local result = {}
    local errorCode = 0
    local tempFilePath = "/tmp/baidupan/" .. actionId
    
    XQLog.log(baidupan_debug_level, "router_upload_file_post respone:  " .. uploadInfo.block_list_count .. 
              " max_size: " .. uploadInfo.max_size .. " " .. localPath)
    
    local uploadId = uploadInfo.uploadid
    local fileSize = uploadInfo.size
    local blockCount = uploadInfo.block_list_count
    local blockSize = uploadInfo.max_size
    
    local luciUtil = require("luci.util")
    
    if not remotePath or not accessToken or not localPath then
        XQLog.log(baidupan_debug_level, "invalid input parameters!")
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    local configDir = getBaidupanConfigDir()
    XQLog.log(baidupan_debug_level, "post config to peer: ")
    
    local file = io.open(localPath, "rb")
    if not file then
        XQLog.log(baidupan_debug_level, "file open failed")
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    local statusFilePath = configDir .. "/.baidupan/tmp/"
    local encodedPath = xqurlencode(remotePath)
    
    -- 分片上传循环
    for blockIndex = 0, blockCount - 1 do
        -- 检查暂停状态
        local pauseStatus = getFilePauseStat(statusFilePath)
        XQLog.log(baidupan_debug_level, "pause: " .. pauseStatus .. " i = " .. blockIndex)
        
        if pauseStatus == "1" then
            -- 等待恢复
            puaseUpload(actionId, fileSize)
            for waitCount = 1, 3600 do
                pauseStatus = getFilePauseStat(statusFilePath)
                XQLog.log(baidupan_debug_level, "file :" .. localPath .. " pause: " .. pauseStatus .. 
                          " j = " .. waitCount .. " i = " .. blockIndex)
                if pauseStatus == "0" then
                    break
                end
                os.execute("sleep 1")
            end
            continueUpload(actionId, fileSize)
        end
        
        -- 读取文件块
        local blockData = file:read(blockSize)
        if not blockData then
            XQLog.log(baidupan_debug_level, "file read failed ")
            break
        end
        
        -- 写入临时文件
        _write_file(tempFilePath, blockData)
        
        -- 计算MD5
        local blockMd5 = XQCryptoUtil.md5File(tempFilePath)
        if not blockMd5 then
            io.close(file)
            XQLog.log(baidupan_debug_level, "file calculate checksum failed: " .. localPath)
            return BDPAN_ERROR_CODE.ERROR_INTERNAL
        end
        
        -- 上传分片
        local uploadCmd = "curl -k -F 'file=@" .. tempFilePath .. 
                         "' 'https://d.pcs.baidu.com/rest/2.0/pcs/superfile2?access_token=" .. accessToken .. 
                         "&method=upload&type=tmpfile&path=" .. encodedPath .. 
                         "&uploadid=" .. uploadId .. "&partseq=" .. blockIndex .. "'"
        
        local response = execUrl(uploadCmd)
        XQLog.log(baidupan_debug_level, "BAIDUPAN router_upload_file_post result: " .. response)
        
        if response == nil or response == "" then
            return BDPAN_ERROR_CODE.ERROR_INTERNAL
        else
            local jsonResult = json.decode(response)
            if jsonResult.errno then
                errorCode = jsonResult.errno
            end
        end
        
        -- 更新进度
        local progressCmd = "echo '" .. blockIndex .. "' > '" .. statusFilePath .. "_tmp'"
        XQLog.log(baidupan_debug_level, "BAIDUPAN pause cmd : " .. progressCmd)
        luci.util.exec(progressCmd)
    end
    
    io.close(file)
    XQLog.log(baidupan_debug_level, "everything seems ok with config post!")
    return errorCode
end

--[[
  预上传文件(获取uploadid)
  @param remotePath  远程路径
  @param accessToken 访问令牌
  @param localPath   本地文件路径
  @param memberLevel 会员等级
  @param actionId    操作ID
  @return table 上传信息
]]
function routerPost(remotePath, accessToken, localPath, memberLevel, actionId)
    local uploadInfo = {}
    local blockListStr = nil
    local tempFilePath = "/tmp/baidupan/" .. actionId
    local timestamp = os.time()
    
    if not remotePath or not accessToken or not localPath then
        XQLog.log(baidupan_debug_level, "invalid input parameters!")
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    local file = io.open(localPath, "rb")
    if not file then
        XQLog.log(baidupan_debug_level, "file open failed: " .. localPath)
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    end
    
    -- 获取文件大小和分片信息
    local blockCount, fileSize, blockSize = getLocalFileSize(localPath, memberLevel)
    XQLog.log(baidupan_debug_level, "size: " .. fileSize .. " max_size: " .. blockSize .. " count: " .. blockCount)
    
    -- 计算每个分片的MD5
    for blockIndex = 0, blockCount - 1 do
        local blockData = file:read(blockSize)
        if not blockData then
            break
        end
        
        _write_file(tempFilePath, blockData)
        local blockMd5 = XQCryptoUtil.md5File(tempFilePath)
        
        if not blockMd5 then
            io.close(file)
            XQLog.log(baidupan_debug_level, "file calculate checksum failed: " .. localPath)
            return BDPAN_ERROR_CODE.ERROR_INTERNAL
        elseif not blockListStr then
            blockListStr = blockMd5
        else
            blockListStr = blockListStr .. '","' .. blockMd5
        end
    end
    
    io.close(file)
    
    uploadInfo.size = fileSize
    uploadInfo.block_list = blockListStr
    uploadInfo.block_list_count = blockCount
    uploadInfo.max_size = blockSize
    
    -- 发送预上传请求
    local preUploadCmd = 'curl -k "https://pan.baidu.com/rest/2.0/xpan/file?method=precreate&access_token=' .. accessToken .. 
                        '" -d \'path=' .. remotePath .. '&size=' .. fileSize .. 
                        '&isdir=0&autoinit=1&rtype=3&block_list=["' .. blockListStr .. '"]\' -H "User-Agent: pan.baidu.com"'
    
    local response = execUrl(preUploadCmd)
    if response == nil or response == "" then
        return BDPAN_ERROR_CODE.ERROR_INTERNAL
    else
        local jsonResult = json.decode(response)
        XQLog.log(baidupan_debug_level, "BAIDUPAN router_post: errno: " .. jsonResult.errno .. 
                  " uploadid: " .. jsonResult.uploadid)
        uploadInfo.uploadid = jsonResult.uploadid
    end
    
    -- 发送任务状态
    local statusMsg = remotePath .. ":1:" .. blockCount .. ":" .. actionId .. ":" .. timestamp .. ":" .. fileSize
    sendMsgtoBaidupan("0", statusMsg)
    
    return uploadInfo
end

--[[
  创建百度网盘目录
  @param basePath 基础路径
  @param subDir   子目录名
]]
function creat_baidupan_dir(basePath, subDir)
    local fullPath = basePath .. subDir
    local exists = _is_directory(fullPath)
    
    XQLog.log(baidupan_debug_level, "creat_baidupan_dir: " .. fullPath)
    
    if not exists then
        XQLog.log(baidupan_debug_level, "create dir success!")
        os.execute("mkdir -p " .. fullPath .. " >/dev/null 2>&1")
    end
end

--[[
  获取百度到路由器的下载进度
  @param totalSize   总大小
  @param currentPath 当前文件路径
  @return string 进度百分比
]]
function getBaiduToRouterStatus(totalSize, currentPath)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local maxSize = tonumber(totalSize)
    local currentSize = _file_size(currentPath)
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN getBaiduToRouterStatus current filename : " .. currentPath .. 
              " file_size: " .. currentSize .. " max size: " .. maxSize)
    
    local progress = tostring(math.floor(currentSize / maxSize * 100) .. "%")
    XQLog.log(baidupan_debug_level, "getBaiduToRouterStatus: " .. progress)
    
    return progress
end

--[[
  获取下载到路由器的进度
  @param totalSize   总大小
  @param currentPath 当前文件路径
  @return string 进度百分比
]]
function getDownloadRouterStatus(totalSize, currentPath)
    local currentSize = _file_size(currentPath)
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN getDownloadRouterStatus current filename : " .. currentPath .. 
              " file_size: " .. currentSize .. " max size: " .. totalSize)
    
    local progress = tostring(math.floor(currentSize / totalSize * 100) .. "%")
    return progress
end

--[[
  解析本地目录中的文件
  @param dirPath     目录路径
  @param memberLevel 会员等级
  @return number|nil 错误码或nil
]]
function parsesLocalDire(dirPath, memberLevel)
    local errorCode = 0
    local result = nil
    -- 遍历目录中的文件并检查大小
    -- (原始代码此处有缺失的循环逻辑)
    return result
end

--[[
  解析文件列表
  @param listStr 列表字符串
  @return table 解析后的列表
]]
function parseList(listStr)
    local result = {}
    -- 解析格式: filename:status:size
    -- (原始代码此处有缺失的循环逻辑)
    return result
end

--[[
  解析下载链接信息
  @param dlinkList 下载链接列表
  @return table 解析后的信息
]]
function parseDlink(dlinkList)
    local errorCode = 0
    local result = nil
    -- (原始代码此处有缺失的循环逻辑)
    return result
end

--[[
  获取本地百度网盘目录
  @return string 本地目录路径
]]
function getLocalPanDire()
    local configDir = getBaidupanConfigDir()
    creat_baidupan_dir(configDir, BAIDUPAN_ROOT_DIR)
    
    local localDir = configDir .. BAIDUPAN_ROOT_DIR
    
    -- 检查UCI配置是否已设置
    local savedDir = uci:get("baidupan", "user", "localdir")
    if savedDir and savedDir == localDir then
        return localDir
    end
    
    -- 更新UCI配置
    local uciCmd = "uci set baidupan.user.localdir='" .. localDir .. "';uci commit baidupan;"
    XQLog.log(baidupan_debug_level, "BAIDUPAN getLocalPanDire add_dir: " .. uciCmd)
    handleBaidupanUci(uciCmd)
    
    return localDir
end

--[[
  创建百度网盘配置目录
  @return string 配置目录路径
]]
function creatBaidupanConfigDir()
    local configDir = getBaidupanConfigDir()
    local baidupanDir = "/.baidupan/"
    
    -- 创建配置目录
    creat_baidupan_dir(configDir, baidupanDir)
    creat_baidupan_dir("/etc", baidupanDir)
    
    -- 创建临时目录
    local tmpDir = "/.baidupan/tmp/"
    creat_baidupan_dir(configDir, tmpDir)
    
    local fullPath = configDir .. "/.baidupan/"
    XQLog.log(baidupan_debug_level, "BAIDUPAN defult mount disk dir: " .. fullPath)
    
    return fullPath
end

--[[
  获取百度网盘配置目录(挂载点)
  @return string 挂载点路径
]]
function getBaidupanConfigDir()
    local mountPath
    
    -- 获取第一个挂载的存储设备路径
    local cmd = "block info | awk -F 'MOUNT' '{print $2}' | awk -F '\"' 'NR==1{print $2}'"
    local result = luci.util.exec(cmd)
    result = string.gsub(result, "^[%s\n\r\t]*(.-)[%s\n\r\t]*$", "%1")
    
    if result then
        mountPath = result
    end
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN getBaidupanConfigDir mount disk: " .. result)
    return mountPath
end

--[[
  设置用户名
  @param userName 用户名
  @return boolean 是否需要创建新配置
]]
function setUserName(userName)
    local savedName = uci:get("baidupan", "user", "name")
    local configPath = "/etc/.baidupan/"
    local configExists = _file_exists(configPath)
    
    -- 如果用户名相同且配置已存在，无需更新
    if savedName and savedName == userName and configExists == true then
        return false
    else
        -- 更新用户名配置
        local uciCmd = "uci set baidupan.user.name='" .. userName .. "';uci commit baidupan;"
        handleBaidupanUci(uciCmd)
        creatBaidupanConfigDir()
        return true
    end
end

--[[
  终止百度网盘进程
  @param actionId 操作ID(可选)
]]
function kill_baidupan_process(actionId)
    local searchPattern = actionId or ""
    if not actionId then
        searchPattern = ""
    end
    
    local cmd = 'pgrep -f "baidupan.lua .* ' .. searchPattern .. '"'
    XQLog.log(baidupan_debug_level, "kill cmd: " .. cmd)
    
    local pidList = luci.util.execl(cmd)
    for _, pid in ipairs(pidList) do
        XQLog.log(baidupan_debug_level, "BAIDUPAN kill_baidupan_process pid: " .. pid)
        if pid == nil or pid == "" then
            break
        end
        
        -- 终止进程及其子进程
        local killCmd = "echo `pstree -p " .. pid .. 
                       "`|awk 'BEGIN{ FS=\"(\" ; RS=\")\" } NF>1 { print $NF }'|xargs kill -9 &>/dev/nul"
        XQLog.log(baidupan_debug_level, "BAIDUPAN kill_baidupan_process cmd_str: " .. killCmd)
        luci.util.exec(killCmd)
    end
end

--[[
  删除传输列表中的任务
  @param deleteAll   是否删除全部 ("1"=全部)
  @param taskType    任务类型 ("0"=上传, "1"=下载)
  @param actionIds   操作ID列表(JSON字符串)
  @return boolean 成功返回true
]]
function deleteTransportList(deleteAll, taskType, actionIds)
    local configDir = getBaidupanConfigDir()
    local tmpDir = configDir .. "/.baidupan/tmp/"
    local etcDir = "/etc/.baidupan/"
    
    XQLog.log(baidupan_debug_level, "deleteTransportList")
    
    if deleteAll == "1" then
        -- 删除全部任务
        kill_baidupan_process()
        
        if taskType == "0" then
            -- 删除上传任务
            local rmCmd = "rm -rf " .. tmpDir .. "*"
            luci.util.exec(rmCmd)
            rmCmd = "rm -rf " .. etcDir .. "upload_*"
            luci.util.exec(rmCmd)
        elseif taskType == "1" then
            -- 删除下载任务
            local rmCmd = "rm -rf " .. etcDir .. "download_*"
            luci.util.exec(rmCmd)
        else
            XQLog.log(baidupan_debug_level, "invalid task type")
        end
    else
        -- 删除指定任务
        local idList = json.decode(actionIds)
        for _, actionId in ipairs(idList) do
            -- 验证actionId格式(只允许十六进制字符)
            if type(actionId) == "string" then
                if not actionId:match("^[a-fA-F0-9]+$") then
                    XQLog.log(baidupan_debug_level, "BAIDUPAN deleteTransportList error: Invalid actionid detected")
                    return false
                end
            end
            
            XQLog.log(baidupan_debug_level, "BAIDUPAN actionid : " .. actionId)
            kill_baidupan_process(actionId)
            
            if taskType == "0" then
                local rmCmd = "rm -rf " .. etcDir .. "upload_" .. actionId
                XQLog.log(baidupan_debug_level, "BAIDUPAN last del_upload_list: " .. rmCmd)
                luci.util.exec(rmCmd)
            elseif taskType == "1" then
                local rmCmd = "rm -rf " .. etcDir .. "download_" .. actionId
                XQLog.log(baidupan_debug_level, "BAIDUPAN last del_download_list: " .. rmCmd)
                luci.util.exec(rmCmd)
            else
                XQLog.log(baidupan_debug_level, "BAIDUPAN last deleteTransportList error ")
            end
        end
    end
    
    return true
end

--[[
  获取本地文件大小和分片信息
  @param filePath    文件路径
  @param memberLevel 会员等级
  @return number, number, number 分片数、文件大小、分片大小
]]
function getLocalFileSize(filePath, memberLevel)
    local blockCount, blockSize
    local fileSize = _file_size(filePath)
    
    -- 根据会员等级确定分片大小
    if memberLevel == "0" then
        blockSize = 4194304      -- 4MB (普通用户)
        blockCount = math.ceil(fileSize / blockSize)
    elseif memberLevel == "1" then
        blockSize = 16777216     -- 16MB (会员)
        blockCount = math.ceil(fileSize / blockSize)
    elseif memberLevel == "2" then
        blockSize = 33554432     -- 32MB (超级会员)
        blockCount = math.ceil(fileSize / blockSize)
    end
    
    return blockCount, fileSize, blockSize
end

--[[
  处理百度网盘UCI配置(带锁)
  @param uciCmd UCI命令
]]
function handleBaidupanUci(uciCmd)
    local cmd = string.format('/usr/sbin/baidupan_uci_lock.sh "%s"', uciCmd)
    XQLog.log(baidupan_debug_level, "BAIDUPAN handleBaidupanUci: " .. cmd)
    luci.util.exec(cmd)
end

--[[
  分类任务列表
  @param listData 列表数据
  @return table 分类后的列表(uploading/error/finished)
]]
function splitList(listData)
    local result = {
        uploading = {},
        error = {},
        finished = {}
    }
    
    local luciUtil = require("luci.util")
    
    -- 遍历并分类任务
    -- 状态码: 0,1,4,7=上传中, 2=已完成, 其他=错误
    -- (原始代码此处有缺失的循环逻辑)
    
    return result
end

--[[
  处理文件目录名(替换特殊字符)
  @param fileList    文件列表
  @param replaceChar 要替换的字符
  @return table 处理后的文件列表
]]
function handleFileDirname(fileList, replaceChar)
    local result = {}
    
    for _, filePath in ipairs(fileList) do
        local fileName = getFileName(filePath)
        local dirName = filePath:match("(.*[/\\])")
        
        XQLog.log(baidupan_debug_level, "BAIDUPAN local file: " .. filePath .. 
                  "file name: " .. fileName .. " dir: " .. dirName)
        
        -- 检查文件名是否包含需要替换的字符
        if string.find(fileName, replaceChar) ~= nil then
            local newFileName = string.gsub(fileName, replaceChar, "_")
            local newPath = dirName .. newFileName
            
            local mvCmd = 'mv "' .. filePath .. '" "' .. newPath .. '"'
            XQLog.log(baidupan_debug_level, "BAIDUPAN rename cmd: " .. mvCmd)
            luci.util.exec(mvCmd)
            
            table.insert(result, newPath)
        else
            XQLog.log(baidupan_debug_level, "BAIDUPAN local file: " .. filePath)
            table.insert(result, filePath)
        end
    end
    
    return result
end

--[[
  检查本地文件名(替换空格和单引号)
  @param fileListJson 文件列表JSON字符串
  @return string 处理后的文件列表JSON
]]
function checkLocalFileName(fileListJson)
    local result = {}
    
    local luciUtil = require("luci.util")
    local XQLog = require("xiaoqiang.XQLog")
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN checkLocalFileName: ")
    
    local fileList = json.decode(fileListJson)
    
    -- 替换空格
    fileList = handleFileDirname(fileList, " ")
    -- 替换单引号
    result = handleFileDirname(fileList, "'")
    
    return json.encode(result)
end

--[[
  检查远程文件名(替换冒号和空格)
  @param fileListJson 文件列表JSON字符串
  @return string 处理后的文件列表JSON
]]
function checkRemoteFileName(fileListJson)
    local result = {}
    local XQLog = require("xiaoqiang.XQLog")
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN checkRemoteFileName: ")
    
    local fileList = json.decode(fileListJson)
    
    for _, fileInfo in ipairs(fileList) do
        XQLog.log(baidupan_debug_level, "BAIDUPAN remote file: " .. fileInfo.filename)
        
        -- 替换冒号
        if string.find(fileInfo.filename, ":") ~= nil then
            fileInfo.filename = string.gsub(fileInfo.filename, ":", "_")
        end
        
        -- 替换空格
        if string.find(fileInfo.filename, " ") ~= nil then
            fileInfo.filename = string.gsub(fileInfo.filename, " ", "_")
        end
        
        table.insert(result, fileInfo)
    end
    
    return json.encode(result)
end

--[[
  发送消息到百度网盘服务
  @param msgType 消息类型
  @param msgCmd  消息命令
  @return boolean 成功返回true
]]
function sendMsgtoBaidupan(msgType, msgCmd)
    XQLog.log(baidupan_debug_level, " BAIDUPAN function: sendMsgtoBaidupan")
    
    local params = {
        type = msgType,
        cmd = msgCmd
    }
    
    local result = callUbus("settaskstatus", params)
    
    if XQFunction.isStrNil(result) then
        return false
    end
    return true
end

--[[
  清理上传重复环境
  @param actionId 操作ID
]]
function cleanUploadRepeatEnv(actionId)
    local configDir = getBaidupanConfigDir()
    local rmCmd = "rm -rf " .. configDir .. "/.baidupan/tmp/" .. actionId .. "*"
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN cleanUploadRepeatEnv 2: " .. rmCmd)
    luciUtil.exec(rmCmd)
end

--[[
  验证UTF-8字符串(检查是否包含4字节字符)
  @param str 字符串
  @return boolean 包含4字节字符返回true
]]
function vaildUtf8Str(str)
    local len = string.len(str)
    local pos = 0
    
    while len > pos do
        local byte = string.byte(str, pos + 1)
        if byte >= 240 then
            -- 4字节UTF-8字符
            return true
        elseif byte >= 224 then
            pos = pos + 3
        elseif byte >= 192 then
            pos = pos + 2
        else
            pos = pos + 1
        end
    end
    
    return false
end

--[[
  检查文件格式(验证文件存在性和名称合法性)
  @param fileListJson 文件列表JSON字符串
  @return boolean 验证通过返回true
]]
function checkFileFormat(fileListJson)
    local result = {}
    local luciUtil = require("luci.util")
    local XQLog = require("xiaoqiang.XQLog")
    
    XQLog.log(baidupan_debug_level, "BAIDUPAN checkFileFormat: ")
    
    local fileList = json.decode(fileListJson)
    
    for _, filePath in ipairs(fileList) do
        -- 检查文件是否存在
        local exists = _file_exists(filePath)
        if not exists then
            return exists
        end
        
        -- 检查文件名是否包含4字节UTF-8字符
        local fileName = getFileName(filePath)
        if vaildUtf8Str(fileName) == true then
            XQLog.log(baidupan_debug_level, "A single character exceeds 4 bytes")
            return false
        end
        
        -- 检查文件名是否包含非法字符
        if string.find(filePath, ":") ~= nil then
            return false
        end
        if string.find(filePath, "|") ~= nil then
            return false
        end
    end
    
    return true
end

--[[
  调用UBUS接口
  @param method 方法名
  @param params 参数表
  @return table 返回结果
]]
function callUbus(method, params)
    local result = ""
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        result = conn:call("baidupan_action", method, params)
        conn:close()
    end
    
    return result
end

--[[
  检查是否有存储设备挂载
  @return number 有挂载返回1，否则返回0
]]
local function checkStorageMounted()
    local hasMounted = 0
    local result = luciUtil.exec("block info")
    
    if not XQFunction.isStrNil(result) then
        hasMounted = 1
    end
    
    return hasMounted
end

--[[
  检查指定UUID的存储设备是否挂载
  @param uuid 设备UUID
  @return number 已挂载返回1，否则返回0
]]
local function checkStorageByUuid(uuid)
    local hasMounted = 0
    local result = luciUtil.exec("block info | grep " .. uuid)
    
    if not XQFunction.isStrNil(result) then
        hasMounted = 1
    end
    
    return hasMounted
end

--[[
  设置百度网盘存储路径
  @param mountPath 挂载路径
  @return number 错误码(0=成功)
]]
function setBaidupanPath(mountPath)
    local XQStorage = require("xiaoqiang.module.XQStorage")
    
    -- 获取保存的UUID
    local savedUuid = uci:get("baidupan", "user", "uuid") or ""
    
    -- 获取当前挂载路径的UUID
    local currentUuid = XQStorage.getStorageUuidByMountPath(mountPath)
    
    if XQFunction.isStrNil(currentUuid) then
        return 1589  -- 无效存储设备
    end
    
    -- 如果UUID变化，更新配置
    if savedUuid ~= currentUuid then
        uci:set("baidupan", "user", "uuid", currentUuid)
        uci:commit("baidupan")
    end
    
    -- 获取本地目录
    local localDir = getLocalPanDire()
    if type(localDir) == "number" then
        return 1502  -- 目录创建失败
    end
    
    -- 重启百度网盘服务
    XQFunction.forkExec("/etc/init.d/baidupan restart")
    
    return 0
end

--[[
  获取百度网盘存储路径状态
  @return table 包含绑定状态和路径信息
    bindStatus: "0"=未绑定无存储, "1"=未绑定有存储, "2"=已绑定无存储,
                "3"=已绑定存储在线, "4"=已绑定存储离线
]]
function getBaidupanPath()
    local result = {}
    local XQStorage = require("xiaoqiang.module.XQStorage")
    
    -- 获取保存的UUID
    local savedUuid = uci:get("baidupan", "user", "uuid") or ""
    
    -- 检查是否有存储设备挂载
    local hasMounted = checkStorageMounted()
    
    if XQFunction.isStrNil(savedUuid) then
        -- 未绑定存储
        if hasMounted == 0 then
            result.bindStatus = "0"  -- 未绑定，无存储设备
        else
            result.bindStatus = "1"  -- 未绑定，有存储设备
        end
    else
        -- 已绑定存储
        local uuidMounted = checkStorageByUuid(savedUuid)
        
        if hasMounted == 0 then
            result.bindStatus = "2"  -- 已绑定，无存储设备
        elseif uuidMounted == 0 then
            result.bindStatus = "4"  -- 已绑定，但绑定的存储离线
        else
            result.bindStatus = "3"  -- 已绑定，存储在线
        end
    end
    
    -- 获取挂载路径
    result.path = XQStorage.getStorageMountPathByUuid(savedUuid)
    
    return result
end
