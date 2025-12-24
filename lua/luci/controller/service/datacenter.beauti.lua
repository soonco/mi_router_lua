--[[
    小米路由器数据中心服务控制器
    文件路径: luci/controller/service/datacenter.lua
    功能: 提供数据中心相关的API接口，包括文件下载、上传、插件管理等功能
]]

-- 定义模块
module("luci.controller.service.datacenter", package.seeall)

-- 引入依赖模块
local LuciHttp = require("luci.http")                           -- HTTP请求处理模块
local XQConfigs = require("xiaoqiang.common.XQConfigs")         -- 小米路由器配置模块
local ServiceErrorUtil = require("service.util.ServiceErrorUtil") -- 服务错误处理工具
local XQFunction = require("xiaoqiang.common.XQFunction")       -- 小米路由器通用函数

-- Samba插件的AppID
local SAMBA_PLUGIN_APPID = "2882303761517280984"

--[[
    路由入口函数
    注册所有API路由
]]
function index()
    -- 创建数据中心节点
    local datacenterNode = node("service", "datacenter")
    datacenterNode.target = firstchild()
    datacenterNode.title = ""
    datacenterNode.order = nil
    datacenterNode.sysauth = "admin"                    -- 需要管理员认证
    datacenterNode.sysauth_authenticator = "jsonauth"   -- 使用JSON认证方式
    datacenterNode.index = true

    -- 注册API路由 (路径, 处理函数, 标题, 是否显示, 权限级别)
    -- 权限级别: 17=需要认证, 1=公开, 8=特殊权限

    -- 通用请求隧道接口
    entry({"service", "datacenter", "request"}, call("tunnelRequest"), _(""), nil, 17)

    -- 文件下载接口
    entry({"service", "datacenter", "download_file"}, call("downloadFile"), _(""), nil, 17)

    -- 获取设备ID接口
    entry({"service", "datacenter", "device_id"}, call("getDeviceID"), _(""), nil, 17)

    -- 获取下载信息接口
    entry({"service", "datacenter", "download_info"}, call("getDownloadInfo"), _(""), nil, 17)

    -- 文件上传接口
    entry({"service", "datacenter", "upload_file"}, call("uploadFile"), _(""), nil, 17)

    -- 批量获取下载信息接口
    entry({"service", "datacenter", "batch_download_info"}, call("getBatchDownloadInfo"), _(""), nil, 17)

    -- 获取配置信息接口
    entry({"service", "datacenter", "config_info"}, call("getConfigInfo"), _(""), nil, 17)

    -- 设置配置信息接口
    entry({"service", "datacenter", "set_config"}, call("setConfigInfo"), _(""), nil, 17)

    -- 启用插件接口
    entry({"service", "datacenter", "plugin_enable"}, call("enablePlugin"), _(""), nil, 17)

    -- 获取插件下载信息接口
    entry({"service", "datacenter", "plugin_download_info"}, call("pluginDownloadInfo"), _(""), nil, 17)

    -- 禁用插件接口
    entry({"service", "datacenter", "plugin_disable"}, call("disablePlugin"), _(""), nil, 17)

    -- 控制插件接口
    entry({"service", "datacenter", "plugin_control"}, call("controlPlugin"), _(""), nil, 17)

    -- 控制功能插件接口
    entry({"service", "datacenter", "feature_plugin_control"}, call("controlFeaturePlugin"), _(""), nil, 17)

    -- 删除下载任务接口
    entry({"service", "datacenter", "download_delete"}, call("deleteDownload"), _(""), nil, 17)

    -- 获取插件状态接口
    entry({"service", "datacenter", "get_plugin_status"}, call("pluginStatus"), _(""), nil, 17)

    -- 获取已连接设备接口
    entry({"service", "datacenter", "get_connected_device"}, call("connectedDevice"), _(""), nil, 17)

    -- 获取路由器MAC地址接口
    entry({"service", "datacenter", "get_router_mac"}, call("getMac"), _(""), nil, 17)

    -- 设置WAN口访问权限接口
    entry({"service", "datacenter", "set_wan_access"}, call("setWanAccess"), _(""), nil, 17)

    -- 获取路由器信息接口
    entry({"service", "datacenter", "get_router_info"}, call("getRouterInfo"), _(""), nil, 17)

    -- 迅雷通知接口
    entry({"service", "datacenter", "xunlei_notify"}, call("xunleiNotify"), _(""), nil, 17)

    -- 获取路由器IP接口
    entry({"service", "datacenter", "get_routerIP"}, call("getRouterIP"), _(""), nil, 17)

    -- 批量创建下载任务接口
    entry({"service", "datacenter", "multi_create"}, call("MultiCreate"), _(""), nil, 17)

    -- 执行命令接口
    entry({"service", "datacenter", "run_command"}, call("RunCommand"), _(""), nil, 17)

    -- 获取厂商ID接口
    entry({"service", "datacenter", "idforvendor"}, call("idforvendor"), _(""), nil, 17)

    -- 媒体增量同步接口 (公开)
    entry({"service", "datacenter", "media_delta"}, call("mediaDelta"), _(""), nil, 1)

    -- 获取媒体元数据接口 (公开)
    entry({"service", "datacenter", "media_metadata"}, call("mediaMetadata"), _(""), nil, 1)

    -- 共享MIUI备份目录接口 (公开)
    entry({"service", "datacenter", "share_miui_dir"}, call("shareMiuiBackupDir"), _(""), nil, 1)

    -- 获取文件列表接口 (公开)
    entry({"service", "datacenter", "get_file_list"}, call("getFileList"), _(""), nil, 1)

    -- 获取存储信息接口 (公开)
    entry({"service", "datacenter", "get_storage_info"}, call("getStorageInfo"), _(""), nil, 1)

    -- 获取优酷状态接口 (公开)
    entry({"service", "datacenter", "get_youku_status"}, call("getYoukuStatus"), _(""), nil, 1)

    -- 获取摄像头SMB路径接口 (公开)
    entry({"service", "datacenter", "get_camera_smbpath"}, call("getCameraSmbPath"), _(""), nil, 1)

    -- 绑定优酷AppID接口 (公开)
    entry({"service", "datacenter", "bind_youku_appid"}, call("bindYoukuAppid"), _(""), nil, 1)

    -- 检查是否有磁盘接口 (特殊权限)
    entry({"service", "datacenter", "is_has_disk"}, call("isHasDisk"), _(""), nil, 8)

    -- 设置同步路由器文件接口 (特殊权限)
    entry({"service", "datacenter", "set_sync_router_file"}, call("setSyncRouterFile"), _(""), nil, 8)
end

--[[
    设置同步路由器文件
    从请求中获取sources参数并发送到数据中心
]]
function setSyncRouterFile()
    local cjson = require("cjson")
    local sources = LuciHttp.formvalue("sources")
    local sourcesDecoded = cjson.decode(sources)

    local requestData = {
        api = 118,                                          -- API编号: 设置同步路由器文件
        sources = sourcesDecoded,
        remote_router_id = LuciHttp.formvalue("remote_router_id")
    }

    tunnelRequestDatacenter(requestData)
end

--[[
    通用隧道请求
    将原始payload转发到数据中心
]]
function tunnelRequest()
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

    -- 获取原始payload并进行Base64编码
    local payload = LuciHttp.formvalue_unsafe("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)

    -- 构建命令并执行
    local command = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % encodedPayload
    local result = LuciUtil.exec(command)

    -- 直接写入响应
    LuciHttp.write(result, nil, false, true)
end

--[[
    检查是否有磁盘
    API编号: 122
]]
function isHasDisk()
    local requestData = {
        api = 122
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取摄像头SMB路径
    API编号: 115
    参数: mac - 设备MAC地址
]]
function getCameraSmbPath()
    local requestData = {
        api = 115,
        mac = LuciHttp.formvalue("mac")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取存储信息
    API编号: 17
]]
function getStorageInfo()
    local requestData = {
        api = 17
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取文件列表
    API编号: 3
    参数: path - 文件路径
]]
function getFileList()
    local requestData = {
        api = 3,
        path = LuciHttp.formvalue("path"),
        sharedOnly = true                   -- 仅显示共享文件
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取厂商ID
    API编号: 629
    参数: appId - 应用ID
]]
function idforvendor()
    local requestData = {
        api = 629,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取媒体元数据
    API编号: 1202
    参数: path - 文件路径, thumb_size - 缩略图大小
]]
function mediaMetadata()
    local requestData = {
        api = 1202,
        path = LuciHttp.formvalue("path"),
        thumb_size = LuciHttp.formvalue("thumb_size")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取媒体增量数据
    API编号: 1201
    参数: cursor - 游标位置, len - 数据长度
]]
function mediaDelta()
    local requestData = {
        api = 1201,
        cursor = LuciHttp.formvalue("cursor"),
        len = LuciHttp.formvalue("len")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取路由器IP
    API编号: 1112
    参数: appId - 应用ID
]]
function getRouterIP()
    local requestData = {
        api = 1112,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    共享MIUI备份目录
    API编号: 100
    参数: mac - 设备MAC地址
]]
function shareMiuiBackupDir()
    local requestData = {
        api = 100,
        mac = LuciHttp.formvalue("mac")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    迅雷通知
    API编号: 519
    参数: tasks - 任务信息
]]
function xunleiNotify()
    local requestData = {
        api = 519,
        info = LuciHttp.formvalue("tasks")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    执行命令
    API编号: 625
    参数: appId - 应用ID, command - 要执行的命令
]]
function RunCommand()
    local requestData = {
        api = 625,
        appid = LuciHttp.formvalue("appId"),
        command = LuciHttp.formvalue("command")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    批量创建下载任务
    API编号: 520
    参数: urls - 下载URL列表, pathForUserData - 用户数据路径
]]
function MultiCreate()
    local requestData = {
        api = 520,
        urls = LuciHttp.formvalue("urls"),
        pathForUserData = LuciHttp.formvalue("pathForUserData")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    向数据中心发送隧道请求 (无返回值版本)
    将请求数据JSON编码后通过Thrift隧道发送
    @param requestData 请求数据表
]]
function tunnelRequestDatacenter(requestData)
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

    -- JSON编码请求数据
    local jsonData = cjson.encode(requestData)

    -- Base64编码
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonData)

    -- 构建并执行命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % encodedData

    -- 写入响应
    LuciHttp.write(LuciUtil.exec(command))
end

--[[
    向数据中心发送请求 (有返回值版本)
    @param requestData 请求数据表
    @return 命令执行结果
]]
function requestDatacenter(requestData)
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

    -- JSON编码请求数据
    local jsonData = cjson.encode(requestData)

    -- Base64编码
    local encodedData = XQCryptoUtil.binaryBase64Enc(jsonData)

    -- 构建并执行命令
    local command = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % encodedData

    return LuciUtil.exec(command)
end

--[[
    下载文件
    API编号: 1101
    参数: appId, path, url, downloadName, tag, hidden, redownload, dupId, pathForUserData
]]
function downloadFile()
    local requestData = {
        api = 1101,
        appid = LuciHttp.formvalue("appId"),
        path = LuciHttp.formvalue("path"),
        url = LuciHttp.formvalue("url"),
        name = LuciHttp.formvalue("downloadName"),
        tag = LuciHttp.formvalue("tag"),
        hidden = false,
        redownload = 0,
        dupId = LuciHttp.formvalue("dupId"),
        pathForUserData = LuciHttp.formvalue("pathForUserData")
    }

    -- 处理hidden参数
    if LuciHttp.formvalue("hidden") == "true" then
        requestData.hidden = true
    end

    -- 处理redownload参数
    if LuciHttp.formvalue("redownload") == "1" then
        requestData.redownload = 1
    end

    tunnelRequestDatacenter(requestData)
end

--[[
    设置WAN口访问权限
    API编号: 618
    参数: appId, mac, enable
]]
function setWanAccess()
    local requestData = {
        api = 618,
        appid = LuciHttp.formvalue("appId"),
        mac = LuciHttp.formvalue("mac"),
        enable = false
    }

    if LuciHttp.formvalue("enable") == "true" then
        requestData.enable = true
    end

    tunnelRequestDatacenter(requestData)
end

--[[
    获取设备ID
    API编号: 1103
    参数: appId
]]
function getDeviceID()
    local requestData = {
        api = 1103,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取路由器MAC地址
    API编号: 617
    参数: appId
]]
function getMac()
    local requestData = {
        api = 617,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取路由器信息
    API编号: 622
    参数: appId
]]
function getRouterInfo()
    local requestData = {
        api = 622,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取操作设备ID (内部函数)
    用于验证设备ID是否有效
    @return code 状态码 (0=成功, 5=特定错误, 1559=通用错误)
    @return deviceId 设备ID (成功时返回)
]]
function getOperateDeviceID()
    local requestData = {
        api = 1103,
        appid = LuciHttp.formvalue("appId")
    }

    local result = requestDatacenter(requestData)

    if result then
        local cjson = require("cjson")
        local decoded = cjson.decode(result)

        if decoded then
            if decoded.code == 0 then
                if decoded.deviceid then
                    return 0, decoded.deviceid
                end
            elseif decoded.code == 5 then
                return 5, nil
            end
        end
    end

    return 1559, nil    -- 错误码1559: 通用错误
end

--[[
    URL编码函数
    将特殊字符转换为URL安全格式
    @param str 要编码的字符串
    @return 编码后的字符串
]]
function urlEncode(str)
    if str then
        -- 将换行符转换为CRLF格式
        str = string.gsub(str, "\n", "\r\n")

        -- 将非字母数字和斜杠的字符转换为%XX格式
        str = string.gsub(str, "([^0-9a-zA-Z/])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
    end
    return str
end

--[[
    从文件路径生成下载URL
    将本地文件路径转换为可访问的HTTP URL
    @param path 本地文件路径
    @return 对应的HTTP URL，失败返回nil
]]
function generateUrlFromPath(path)
    if path then
        -- URL编码路径
        path = urlEncode(path)

        -- 尝试匹配公共数据目录
        local url, count = string.gsub(path, "^/userdisk/data/", "http://miwifi.com/api-third-party/download/public/")
        if count == 1 then
            return url
        end

        -- 尝试匹配私有应用数据目录
        url, count = string.gsub(path, "^/userdisk/appdata/", "http://miwifi.com/api-third-party/download/private/")
        if count == 1 then
            return url
        end

        -- 尝试匹配外部磁盘目录
        url, count = string.gsub(path, "^/extdisks/", "http://miwifi.com/api-third-party/download/extdisks/")
        if count == 1 then
            return url
        end
    end

    return nil
end

--[[
    根据错误码生成响应
    @param code 错误码
    @return 包含code和msg的响应表
]]
function generateResponseFromCode(code)
    return {
        code = code,
        msg = ServiceErrorUtil.getErrorMessage(code)
    }
end

--[[
    获取下载信息
    API编号: 1102
    参数: appId, deviceId, downloadId, hidden
]]
function getDownloadInfo()
    local cjson = require("cjson")

    local requestData = {
        api = 1102,
        appid = LuciHttp.formvalue("appId"),
        deviceId = LuciHttp.formvalue("deviceId"),
        downloadId = LuciHttp.formvalue("downloadId"),
        hidden = false
    }

    if LuciHttp.formvalue("hidden") == "true" then
        requestData.hidden = true
    end

    local response = {}
    local result = requestDatacenter(requestData)

    if result then
        local decoded = cjson.decode(result)

        if decoded then
            if decoded.code == 0 then
                -- 成功，生成下载URL
                local url = generateUrlFromPath(decoded.path)
                if url then
                    response.code = decoded.code
                    response.msg = decoded.msg
                    response.url = url
                else
                    response = generateResponseFromCode(1559)
                end
            else
                response = decoded
            end
        end
    else
        response = generateResponseFromCode(1559)
    end

    LuciHttp.write_json(response)
    LuciHttp.close()
end

--[[
    上传文件
    处理文件上传请求，保存到指定目录
]]
function uploadFile()
    local XQLog = require("xiaoqiang.XQLog")
    local LuciFs = require("luci.fs")

    local tempFilePath = "/userdisk/data/upload.tmp"
    local uploadedFileName = nil
    local fileHandle = nil

    -- 清理临时文件
    if LuciFs.isfile(tempFilePath) then
        LuciFs.unlink(tempFilePath)
    end

    -- 设置文件处理器
    LuciHttp.setfilehandler(function(meta, chunk, eof)
        -- 创建文件句柄
        if not fileHandle and meta then
            if meta.name == "file" then
                fileHandle = io.open(tempFilePath, "w")
                uploadedFileName = meta.file

                -- URL解码文件名
                uploadedFileName = string.gsub(uploadedFileName, "+", " ")
                uploadedFileName = string.gsub(uploadedFileName, "%%(%x%x)", function(hex)
                    return string.char(tonumber(hex, 16))
                end)
                uploadedFileName = string.gsub(uploadedFileName, "\r\n", "\n")
            end
        end

        -- 写入数据块
        if chunk then
            fileHandle:write(chunk)
        end

        -- 关闭文件
        if eof then
            fileHandle:close()
        end
    end)

    -- 验证设备ID
    local code, deviceId = getOperateDeviceID()
    if code ~= 0 then
        return LuciHttp.write_json(generateResponseFromCode(code))
    end

    -- 确定保存路径
    local savePath = nil
    local appId = LuciHttp.formvalue("appId")
    local saveType = LuciHttp.formvalue("saveType")

    if saveType == "public" then
        -- 公共目录: /userdisk/data/上传/
        savePath = "/userdisk/data/\228\184\138\228\188\160/"   -- UTF-8编码的"上传"
    elseif saveType == "private" then
        -- 私有目录: /userdisk/appdata/{appId}/
        -- 检查appId是否包含斜杠(安全检查)
        if string.find(appId, "/") then
            return LuciHttp.write_json(generateResponseFromCode(3))
        end
        savePath = "/userdisk/appdata/" .. appId .. "/"
    else
        return LuciHttp.write_json(generateResponseFromCode(3))
    end

    -- 创建目录
    LuciFs.mkdir(savePath, true)

    -- 处理文件名冲突
    local fileName = LuciFs.basename(uploadedFileName)
    if LuciFs.isfile(savePath .. fileName) then
        -- 提取文件名和扩展名
        local baseName = fileName
        local extension = fileName:match("%.([^%.]+)$")

        if extension then
            baseName = fileName:sub(1, -(#extension + 2))
        end

        -- 尝试添加数字后缀
        for i = 1, 100 do
            local newName = baseName .. "(" .. i .. ")"
            if extension then
                newName = newName .. "." .. extension
            end

            if not LuciFs.isfile(savePath .. newName) then
                fileName = newName
                break
            end
        end
    end

    -- 移动文件到目标位置
    local destPath = savePath .. fileName
    XQLog.log("dest=" .. destPath)
    LuciFs.rename(tempFilePath, destPath)

    -- 返回成功响应
    local response = {
        code = 0,
        url = generateUrlFromPath(destPath),
        deviceId = deviceId,
        msg = ""
    }

    LuciHttp.write_json(response)
    LuciHttp.close()
end

--[[
    批量获取下载信息
    API编号: 1105
    参数: appId, ids, hidden
]]
function getBatchDownloadInfo()
    local requestData = {
        api = 1105,
        appid = LuciHttp.formvalue("appId"),
        ids = LuciHttp.formvalue("ids"),
        hidden = false
    }

    if LuciHttp.formvalue("hidden") == "true" then
        requestData.hidden = true
    end

    tunnelRequestDatacenter(requestData)
end

--[[
    获取配置信息
    API编号: 1106
    参数: appId, key
]]
function getConfigInfo()
    local requestData = {
        api = 1106,
        appid = LuciHttp.formvalue("appId"),
        key = LuciHttp.formvalue("key")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    获取已连接设备
    API编号: 616
    参数: appId
]]
function connectedDevice()
    local requestData = {
        api = 616,
        appid = LuciHttp.formvalue("appId")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    设置配置信息
    API编号: 1107
    参数: appId, key, value
]]
function setConfigInfo()
    local requestData = {
        api = 1107,
        appid = LuciHttp.formvalue("appId"),
        key = LuciHttp.formvalue("key"),
        value = LuciHttp.formvalue("value")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    启用插件
    API编号: 1108, status=5
    参数: appId
    特殊处理: 如果是Samba插件，直接设置Samba状态为启用
]]
function enablePlugin()
    local XQStorage = require("xiaoqiang.module.XQStorage")

    local requestData = {
        api = 1108,
        appid = LuciHttp.formvalue("appId"),
        status = 5      -- 启用状态
    }

    -- 特殊处理Samba插件
    if requestData.appid == SAMBA_PLUGIN_APPID then
        local response = {
            code = 0,
            msg = ""
        }
        XQStorage.setSambaStatus("1")   -- 启用Samba
        LuciHttp.write_json(response)
    else
        tunnelRequestDatacenter(requestData)
    end
end

--[[
    禁用插件
    API编号: 1108, status=6
    参数: appId
    特殊处理: 如果是Samba插件，直接设置Samba状态为禁用
]]
function disablePlugin()
    local XQStorage = require("xiaoqiang.module.XQStorage")

    local requestData = {
        api = 1108,
        appid = LuciHttp.formvalue("appId"),
        status = 6      -- 禁用状态
    }

    -- 特殊处理Samba插件
    if requestData.appid == SAMBA_PLUGIN_APPID then
        local response = {
            code = 0,
            msg = ""
        }
        XQStorage.setSambaStatus("0")   -- 禁用Samba
        LuciHttp.write_json(response)
    else
        tunnelRequestDatacenter(requestData)
    end
end

--[[
    控制插件
    API编号: 600
    参数: appId (作为pluginID), info
]]
function controlPlugin()
    local requestData = {
        api = 600,
        pluginID = LuciHttp.formvalue("appId"),
        info = LuciHttp.formvalue("info")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    控制功能插件
    API编号: 634
    参数: appId (作为pluginID), info
]]
function controlFeaturePlugin()
    local requestData = {
        api = 634,
        pluginID = LuciHttp.formvalue("appId"),
        info = LuciHttp.formvalue("info")
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    删除下载任务
    API编号: 1110
    参数: appId, idList, deletefile
]]
function deleteDownload()
    local requestData = {
        api = 1110,
        appid = LuciHttp.formvalue("appId"),
        idList = LuciHttp.formvalue("idList"),
        deletefile = false
    }

    if LuciHttp.formvalue("deletefile") == "true" then
        requestData.deletefile = true
    end

    tunnelRequestDatacenter(requestData)
end

--[[
    获取插件状态
    API编号: 1111
    参数: appId
    特殊处理: 如果是Samba插件，直接返回Samba状态
]]
function pluginStatus()
    local XQStorage = require("xiaoqiang.module.XQStorage")

    local requestData = {
        api = 1111,
        appid = LuciHttp.formvalue("appId")
    }

    -- 特殊处理Samba插件
    if requestData.appid == SAMBA_PLUGIN_APPID then
        local response = {
            code = 0,
            isEnable = (XQStorage.getSambaStatus() == "1")
        }
        LuciHttp.write_json(response)
    else
        tunnelRequestDatacenter(requestData)
    end
end

--[[
    获取插件下载信息
    API编号: 1109
    参数: appId, hidden, lite
]]
function pluginDownloadInfo()
    local requestData = {
        api = 1109,
        appid = LuciHttp.formvalue("appId"),
        hidden = false,
        lite = false
    }

    if LuciHttp.formvalue("hidden") == "true" then
        requestData.hidden = true
    end

    if LuciHttp.formvalue("lite") == "true" then
        requestData.lite = true
    end

    tunnelRequestDatacenter(requestData)
end

--[[
    获取优酷状态
    通过优酷插件(pluginID: 2882303761517440411)获取状态
    API编号: 634, 内部api=4
    参数: appid
]]
function getYoukuStatus()
    local requestData = {
        api = 634,
        pluginID = "2882303761517440411",   -- 优酷插件ID
        info = {
            api = 4,                         -- 获取状态的内部API
            appid = LuciHttp.formvalue("appid")
        }
    }
    tunnelRequestDatacenter(requestData)
end

--[[
    绑定优酷AppID
    通过优酷插件绑定AppID
    API编号: 634, 内部api=5
    参数: appid, ip, token
]]
function bindYoukuAppid()
    local requestData = {
        api = 634,
        pluginID = "2882303761517440411",   -- 优酷插件ID
        info = {
            api = 5,                         -- 绑定的内部API
            appid = LuciHttp.formvalue("appid"),
            ip = LuciHttp.formvalue("ip"),
            token = LuciHttp.formvalue("token")
        }
    }
    tunnelRequestDatacenter(requestData)
end
