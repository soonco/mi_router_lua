--[[
小米数据中心API控制器模块 (XQ Datacenter API Controller)
提供数据中心相关的API接口，包括：
- 文件下载/上传
- 缩略图获取
- 设备识别
- 文件系统检测和修复
- SSH插件管理
- 隧道请求

路径: /api/xqdatacenter/*
认证: jsonauth (需要admin权限)
功能开关: 依赖 XQFeatures.apps.xqdatacenter 配置
]]

module("luci.controller.api.xqdatacenter", package.seeall)

local http = require("luci.http")
local json = require("json")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

--[[
路由注册入口函数
根据功能开关注册数据中心相关的API端点
]]
function index()
    local apiNode = node("api", "xqdatacenter")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 300
    apiNode.sysauth = "admin"
    apiNode.sysauth_authenticator = "jsonauth"
    apiNode.index = true
    
    entry({"api", "xqdatacenter"}, firstchild(), _(""), 300)
    
    -- 检查数据中心功能是否启用
    if features.apps and features.apps.xqdatacenter and features.apps.xqdatacenter == "1" then
        -- 隧道请求API
        entry({"api", "xqdatacenter", "request"}, call("tunnelRequest"), _(""), 301)
        
        -- 设备识别API
        entry({"api", "xqdatacenter", "identify_device"}, call("identifyDevice"), _(""), 302, 8)
        
        -- 文件操作API
        entry({"api", "xqdatacenter", "download"}, call("download"), _(""), 303)
        entry({"api", "xqdatacenter", "upload"}, call("upload"), _(""), 304, 16)
        entry({"api", "xqdatacenter", "thumb"}, call("getThumb"), _(""), 305)
        entry({"api", "xqdatacenter", "device_id"}, call("getDeviceId"), _(""), 306)
        entry({"api", "xqdatacenter", "check_file_exist"}, call("checkFileExist"), _(""), 307)
        
        -- SSH插件API
        entry({"api", "xqdatacenter", "plugin_ssh"}, call("pluginSSH"), _(""), 308)
        entry({"api", "xqdatacenter", "plugin_ssh_status"}, call("pluginSSHStatus"), _(""), 309)
        
        -- 文件系统API
        entry({"api", "xqdatacenter", "fsys_probe"}, call("fsysProbe"), _(""), 301)
        entry({"api", "xqdatacenter", "fsys_resume"}, call("fsysResume"), _(""), 301)
    end
end

--[[
文件系统探测
API: /api/xqdatacenter/fsys_probe

@param type number 操作类型 (1=检测, 2=获取状态)
@return JSON 检测结果或状态
]]
function fsysProbe()
    local result = {
        code = 0,
        msg = ""
    }
    
    local XQDisk = require("xiaoqiang.module.XQDisk")
    local opType = tonumber(http.formvalue("type") or 0)
    
    if opType == 1 then
        -- 执行磁盘检测
        XQDisk.disk_check()
    elseif opType == 2 then
        -- 获取磁盘状态
        result.status = XQDisk.get_diskstatus()
    else
        result.code = 6
        result.msg = "ParameterError"
    end
    
    http.write_json(result)
end

--[[
文件系统修复
API: /api/xqdatacenter/fsys_resume

@param type number 操作类型 (1=修复, 2=获取状态)
@return JSON 修复结果或状态
]]
function fsysResume()
    local result = {
        code = 0,
        msg = ""
    }
    
    local XQDisk = require("xiaoqiang.module.XQDisk")
    local opType = tonumber(http.formvalue("type") or 0)
    
    if opType == 1 then
        -- 执行磁盘修复
        XQDisk.disk_repair()
    elseif opType == 2 then
        -- 获取修复状态
        result.status = XQDisk.get_repairstatus()
    else
        result.code = 6
        result.msg = "ParameterError"
    end
    
    http.write_json(result)
end

--[[
隧道请求
API: /api/xqdatacenter/request
将请求转发到数据中心服务

@param payload string 请求负载数据
@return 原始响应数据
]]
function tunnelRequest()
    local luciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    -- 获取并编码请求负载
    local payload = http.formvalue_unsafe("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)
    
    -- 构建隧道命令
    local cmd = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % encodedPayload
    
    -- 执行命令并返回结果
    local response = luciUtil.exec(cmd)
    http.write(response, nil, false, true)
end

--[[
设备识别
API: /api/xqdatacenter/identify_device

@return JSON 设备识别信息
]]
function identifyDevice()
    local result = { code = 0 }
    
    -- 调用matool获取设备识别信息
    result.info = XQFunction.mattool_identify_device()
    
    http.write_json(result)
end

--[[
获取设备ID
API: /api/xqdatacenter/device_id

@return JSON 设备ID
]]
function getDeviceId()
    local result = { code = 0 }
    
    -- 调用matool获取设备ID
    result.deviceId = XQFunction.mattool_get_deviceid()
    
    http.write_json(result)
end

--[[
URL路径编码
对路径进行URL编码，保留斜杠

@param path string 待编码的路径
@return string 编码后的路径
]]
function pathEncode(path)
    local lcurl = require("lcurl")
    local easy = lcurl.easy()
    local encoded = easy:escape(path)
    -- 将编码后的斜杠还原
    return string.gsub(encoded, "%%2F", "/")
end

--[[
文件下载
API: /api/xqdatacenter/download
支持断点续传

允许的下载路径:
- /userdisk/data/
- /mnt/
- /userdisk/privacyData/
- /userdisk/appdata/
- /userdisk/.thumbnails/

@param path string 文件路径
@return 文件内容(通过nginx X-Accel-Redirect)
]]
function download()
    local nixioFs = require("nixio.fs")
    local mime = require("luci.http.protocol.mime")
    local ltn12 = require("luci.ltn12")
    local XQLog = require("xiaoqiang.XQLog")
    
    local filePath = http.formvalue("path", false, "string")
    
    -- 检查路径参数
    if XQFunction.isStrNil(filePath) then
        http.status(404, _("no Such file"))
        return
    end
    
    -- 允许的路径前缀
    local allowedPaths = {
        "/userdisk/data/",
        "/mnt/",
        "/userdisk/privacyData/",
        "/userdisk/appdata/",
        "/userdisk/.thumbnails/"
    }
    
    -- 检查路径权限
    local allowed = false
    for _, prefix in ipairs(allowedPaths) do
        if string.sub(filePath, 1, string.len(prefix)) == prefix then
            allowed = true
            break
        end
    end
    
    if not allowed then
        http.status(403, _("no permission"))
        return
    end
    
    XQLog.log(7, "=============path = " .. filePath)
    
    -- 检查路径遍历攻击
    if string.find(filePath, "/../") then
        http.status(404, _("no Such file"))
        return
    end
    
    -- 检查文件是否存在
    local fileStat = nixioFs.stat(filePath)
    if not fileStat then
        http.status(404, _("no Such file"))
        return
    end
    
    -- 设置响应头
    http.header("Accept-Ranges", "bytes")
    http.header("Content-Type", mime.to_mime(filePath))
    
    -- 处理断点续传
    local rangeHeader = http.getenv("HTTP_RANGE")
    local rangeStart = 0
    
    if rangeHeader then
        http.status(206)
        rangeStart = string.gsub(rangeHeader, "bytes=", "")
        rangeStart = string.gsub(rangeStart, "-", "")
    end
    
    XQLog.log(7, "=============range = " .. rangeStart)
    
    -- 构建Content-Range头
    local contentRange = "bytes " .. rangeStart .. "-" .. (fileStat.size - 1) .. "/" .. fileStat.size
    XQLog.log(7, "=============contentRange = " .. contentRange)
    
    http.header("Content-Length", fileStat.size - rangeStart)
    http.header("Content-Range", contentRange)
    http.header("Content-Disposition", "attachment; filename=" .. nixioFs.basename(filePath))
    
    -- 根据路径设置X-Accel-Redirect (nginx内部重定向)
    local pathMappings = {
        {prefix = "/userdisk/data/", redirect = "/download-userdisk/"},
        {prefix = "/mnt/", redirect = "/download-mnt/"},
        {prefix = "/userdisk/privacyData/", redirect = "/download-pridisk/"},
        {prefix = "/userdisk/appdata/", redirect = "/download-userdisk-appdata/"},
        {prefix = "/userdisk/.thumbnails/", redirect = "/download-userdisk-thumbnails/"}
    }
    
    for _, mapping in ipairs(pathMappings) do
        if string.sub(filePath, 1, string.len(mapping.prefix)) == mapping.prefix then
            local relativePath = string.sub(filePath, string.len(mapping.prefix) + 1)
            http.header("X-Accel-Redirect", mapping.redirect .. pathEncode(relativePath))
            break
        end
    end
end

--[[
文件上传
API: /api/xqdatacenter/upload

@param target string 目标目录
@param file file 上传的文件
@return JSON 上传结果
]]
function upload()
    local XQLog = require("xiaoqiang.XQLog")
    local luciFs = require("luci.fs")
    
    local tempPath = "/userdisk/upload.tmp"
    
    -- 清理临时文件
    if luciFs.isfile(tempPath) then
        luciFs.unlink(tempPath)
    end
    
    local uploadedFileName = nil
    
    -- 设置文件处理器
    http.setfilehandler(function(meta, chunk, eof)
        local fileHandle
        
        if not fileHandle and meta then
            if meta.name == "file" then
                fileHandle = io.open(tempPath, "w")
                uploadedFileName = meta.file
                -- URL解码文件名
                uploadedFileName = string.gsub(uploadedFileName, "+", " ")
                uploadedFileName = string.gsub(uploadedFileName, "%%(%x%x)", function(hex)
                    return string.char(tonumber(hex, 16))
                end)
                uploadedFileName = string.gsub(uploadedFileName, "\r\n", "\n")
            end
        end
        
        if chunk then
            fileHandle:write(chunk)
        end
        
        if eof then
            fileHandle:close()
        end
    end)
    
    -- 获取目标目录
    local targetDir = http.formvalue("target")
    if not string.match(targetDir, "/$") then
        targetDir = targetDir .. "/"
    end
    
    -- 创建目标目录
    luciFs.mkdir(targetDir, true)
    
    -- 处理文件名冲突
    local finalFileName = uploadedFileName
    if luciFs.isfile(targetDir .. finalFileName) then
        local baseName = string.match(finalFileName, "(.+)%..+$")
        local extension = string.match(finalFileName, "%.([^.]+)$")
        
        for i = 1, 100 do
            local newName = baseName .. "(" .. i .. ")"
            if extension then
                newName = newName .. "." .. extension
            end
            
            if not luciFs.isfile(targetDir .. newName) then
                finalFileName = newName
                break
            end
        end
    end
    
    -- 移动文件到目标位置
    local finalPath = targetDir .. finalFileName
    XQLog.log(7, "Upload to: " .. finalPath)
    luciFs.rename(tempPath, finalPath)
    
    local result = { code = 0 }
    http.write_json(result)
end

--[[
获取缩略图
API: /api/xqdatacenter/thumb

@param filePath string 原始文件路径
@return 缩略图内容
]]
function getThumb()
    local luciUtil = require("luci.util")
    local nixioFs = require("nixio.fs")
    local mime = require("luci.http.protocol.mime")
    local ltn12 = require("luci.ltn12")
    local XQLog = require("xiaoqiang.XQLog")
    
    local filePath = http.formvalue("filePath")
    
    XQLog.log(7, "realPath = ", filePath)
    
    if filePath == nil then
        http.status(404, _("no Such file"))
        return
    end
    
    -- 请求数据中心生成缩略图
    local request = "{\"api\":10, \"files\":[\"" .. filePath .. "\"]}"
    local response = XQFunction.thrift_tunnel_to_datacenter(request)
    
    if response and response.code == 0 then
        local thumbPath = response.thumbnails[1]
        local thumbStat = nixioFs.stat(thumbPath)
        
        http.header("Content-Type", mime.to_mime(thumbPath))
        http.header("Content-Length", thumbStat.size)
        
        -- 输出缩略图内容
        ltn12.pump.all(
            ltn12.source.file(io.open(thumbPath, "r")),
            http.write
        )
    else
        http.status(404, _("no Such thumb file"))
    end
end

--[[
检查文件是否存在
API: /api/xqdatacenter/check_file_exist

@param filePath string 文件路径
@return JSON 文件存在状态
]]
function checkFileExist()
    local nixioFs = require("nixio.fs")
    
    local exists = true
    local filePath = http.formvalue("filePath")
    
    if XQFunction.isStrNil(filePath) then
        exists = false
    else
        local fileStat = nixioFs.stat(filePath)
        if not fileStat then
            exists = false
        end
    end
    
    local result = {
        code = 0,
        exist = exists
    }
    
    http.write_json(result)
end

--[[
SSH插件控制
API: /api/xqdatacenter/plugin_ssh

@param pluginID string 插件ID
@param capability string 能力列表(逗号分隔)
@param open number 开关状态 (1=开启)
@return JSON 操作结果
]]
function pluginSSH()
    local luciUtil = require("luci.util")
    local XQLog = require("xiaoqiang.XQLog")
    
    local code = 0
    local result = {}
    
    local pluginID = http.formvalue("pluginID")
    local capability = http.formvalue("capability")
    local open = tonumber(http.formvalue("open") or 0)
    
    -- 记录功能调用日志
    XQLog.check(0, XQLog.KEY_FUNC_PLUGIN, 1)
    
    if open and open == 1 then
        -- 开启SSH插件
        if pluginID and capability then
            local request = {
                api = 611,
                pluginID = pluginID,
                capability = luciUtil.split(capability, ",")
            }
            
            local response = XQFunction.thrift_tunnel_to_datacenter(json.encode(request))
            if response and response.code ~= 0 then
                code = 1595
            end
        else
            code = 1537
        end
    else
        -- 关闭SSH插件
        local request = { api = 613 }
        local response = XQFunction.thrift_tunnel_to_datacenter(json.encode(request))
        
        if response then
            if response.code == 0 then
                code = 0
            end
        else
            code = 1601
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    result.code = code
    http.write_json(result)
end

--[[
获取SSH插件状态
API: /api/xqdatacenter/plugin_ssh_status

@return JSON SSH插件状态和能力列表
]]
function pluginSSHStatus()
    local code = 0
    local result = {}
    
    -- 获取插件状态
    local statusResponse = XQFunction.thrift_tunnel_to_datacenter("{\"api\":612}")
    -- 获取能力列表
    local capResponse = XQFunction.thrift_tunnel_to_datacenter("{\"api\":621}")
    
    if statusResponse and statusResponse.code == 0 and capResponse and capResponse.code == 0 then
        local capabilities = {}
        
        -- 设置启用状态
        result.enable = (statusResponse.status == 1) and 1 or 0
        
        -- 处理能力列表
        local enabledCaps = {}
        if statusResponse.status == 1 then
            result.pluginID = statusResponse.pluginID
            enabledCaps = statusResponse.capability or {}
        end
        
        -- 标记每个能力的启用状态
        for _, cap in ipairs(capResponse.capabilities or {}) do
            cap.enable = 0
            for _, enabledCap in ipairs(enabledCaps) do
                if cap.key == enabledCap then
                    cap.enable = 1
                    break
                end
            end
            table.insert(capabilities, cap)
        end
        
        result.capability = capabilities
    else
        code = 1600
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    result.code = code
    http.write_json(result)
end
