--[[
  XQNetUtil 网络工具模块
  
  功能说明：
  - 小米云服务API交互
  - 设备认证和登录
  - 固件升级检测
  - 日志上传
  - 请求签名生成
  
  主要功能：
  - getDeviceId: 获取设备唯一标识
  - xiaomiLogin: 小米账号登录
  - checkUpgrade: 检查固件升级
  - uploadLogV2: 上传日志文件
  - doRequest: 执行签名API请求
]]

module("xiaoqiang.util.XQNetUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local httpProtocol = require("luci.http.protocol")
local XQHttpUtil = require("xiaoqiang.util.XQHttpUtil")
local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

local API_TOKEN = "8007236f-a2d6-4847-ac83-c49395ad6d65"
local cachedToken = nil

-- ==================== 基础信息获取 ====================

-- 获取API令牌
-- @return string API令牌
function getToken()
    return API_TOKEN
end

-- 获取设备MAC地址
-- @return string MAC地址
function getMacAddr()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    return XQLanWanUtil.getDefaultMacAddress()
end

-- 获取设备序列号
-- @return string|nil 序列号
function getSN()
    local luciUtil = require("luci.util")
    local sn = luciUtil.exec(XQConfigs.GET_NVRAM_SN)
    
    if XQFunction.isStrNil(sn) then
        return nil
    else
        sn = luciUtil.trim(sn)
    end
    
    return sn
end

-- 获取User-Agent字符串
-- @return string User-Agent
function getUserAgent()
    local sn = getSN() or ""
    return "miwifi-" .. sn
end

-- ==================== URL签名 ====================

-- 生成带签名的URL
-- @param baseUrl 基础URL
-- @param path URL路径
-- @param params 参数列表 {{key, value}, ...}
-- @param extraData 额外签名数据
-- @return string|nil 签名后的完整URL
function cryptUrl(baseUrl, path, params, extraData)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    if baseUrl == nil or params == nil then
        return nil
    end
    
    local timestamp = XQFunction.getTime()
    
    table.insert(params, {"time", timestamp})
    
    table.sort(params, function(a, b)
        return a[1] < b[1]
    end)
    
    local signStr = ""
    table.foreach(params, function(_, item)
        signStr = signStr .. item[1] .. "=" .. item[2] .. "&"
    end)
    
    if extraData ~= nil and extraData ~= "" then
        signStr = signStr .. extraData
    end
    
    local signature = XQCryptoUtil.md5Base64Str(signStr)
    local token = getToken()
    
    local isV2Api = string.find(baseUrl .. path, "/v2/") ~= nil
    
    if XQFunction.isStrNil(token) or isV2Api then
        token = API_TOKEN
    end
    
    local fullUrl = ""
    local hasQuery = string.find(baseUrl .. path, "?")
    
    if hasQuery == nil then
        fullUrl = baseUrl .. path .. "?s=" .. signature .. "&time=" .. timestamp ..
                  "&token=" .. httpProtocol.urlencode(token)
    else
        fullUrl = baseUrl .. path .. "&s=" .. signature .. "&time=" .. timestamp ..
                  "&token=" .. httpProtocol.urlencode(token)
    end
    
    return fullUrl
end

-- ==================== 服务器配置 ====================

local logServerUrl = luci.util.trim(luci.util.exec("uci get /etc/config/miwifi.server.LOG"))
local LOG_UPLOAD_URL = "https://" .. logServerUrl .. "/xiaoqiang_log/"
local CONFIG_UPLOAD_URL = "https://" .. logServerUrl .. "/xiaoqiang_config/"

local FALSE_ROW_KEY = "false-row-key"
local HBASE_UPLOAD_CMD = "curl -k -i -f -X PUT %s%s -H \"Content-Type: application/json\" --data @%s 2>/dev/null"
local DEFAULT_COLUMN = "Qzo="

local COLUMN_MAP = {}
COLUMN_MAP.M = "TTo="
COLUMN_MAP.B = "Qjo="
COLUMN_MAP.X = "WDo="
COLUMN_MAP.Y = "WTo="
COLUMN_MAP.Z = "Wjo="

-- ==================== 日志上传 ====================

-- 生成日志上传的行键
-- @return string 行键（MAC-时间戳）
function generateLogKey()
    local mac = getMacAddr()
    local timestamp = string.format("%012d", os.time())
    return mac .. "-" .. timestamp
end

-- 上传日志文件到HBase（旧版本）
-- @param filePath 日志文件路径
-- @param columnType 列类型（M/B/X/Y/Z）
-- @param rowKey 行键（可选）
-- @return boolean 是否成功
function uploadLogFile(filePath, columnType, rowKey)
    local json = require("json")
    
    local column = COLUMN_MAP[columnType]
    if XQFunction.isStrNil(column) then
        return false
    end
    
    local mime = require("mime")
    local encodedKey = mime.b64(rowKey)
    if not encodedKey then
        encodedKey = mime.b64(generateLogKey())
    end
    
    local fileContent = luci.util.exec("/usr/bin/base64 " .. filePath)
    
    local cell = {}
    cell.column = column
    cell["$"] = string.gsub(fileContent, "\n", "")
    
    local row = {}
    row.key = encodedKey
    row.Cell = {cell}
    
    local payload = {}
    payload.Row = row
    
    local jsonData = json.encode(payload)
    
    local file = io.open(XQConfigs.XQ_LOG_JSON_FILEPATH, "w")
    if file then
        file:write(jsonData)
        file:close()
    end
    
    local cmd = string.format(HBASE_UPLOAD_CMD, LOG_UPLOAD_URL, FALSE_ROW_KEY, XQConfigs.XQ_LOG_JSON_FILEPATH)
    local result = luci.util.exec(cmd)
    
    if result == nil or result == "" then
        return false
    else
        if string.find(result, "OK") ~= nil then
            return true
        else
            return false
        end
    end
end

-- 上传配置文件
-- @param filePath 配置文件路径
-- @return boolean 是否成功
function uploadConfigFile(filePath)
    local mime = require("mime")
    local json = require("json")
    
    local mac = getMacAddr()
    if mac == nil then
        return false
    end
    
    local fileContent = luci.util.exec("/usr/bin/base64 " .. filePath)
    local encodedKey = mime.b64(mac)
    
    local cell = {}
    cell.column = DEFAULT_COLUMN
    cell["$"] = string.gsub(fileContent, "\n", "")
    
    local row = {}
    row.key = encodedKey
    row.Cell = {cell}
    
    local payload = {}
    payload.Row = row
    
    local jsonData = json.encode(payload)
    
    local file = io.open(XQConfigs.XQ_CONFIG_JSON_FILEPATH, "w")
    if file then
        file:write(jsonData)
        file:close()
    end
    
    local cmd = string.format(HBASE_UPLOAD_CMD, CONFIG_UPLOAD_URL, FALSE_ROW_KEY, XQConfigs.XQ_CONFIG_JSON_FILEPATH)
    local result = luci.util.exec(cmd)
    
    if result == nil or result == "" then
        return false
    else
        if string.find(result, "OK") ~= nil then
            return true
        else
            return false
        end
    end
end

-- ==================== 日志上传V2 ====================

local LOG_ZIP_FILEPATH = XQConfigs.LOG_ZIP_FILEPATH
local LOG_SUFFIX = "tar.gz"
local LOG_UPLOAD_URL_V2 = "https://" .. logServerUrl .. "/log/lite/common/%s"
local LOG_UPLOAD_CMD_V2 = "curl -k -i -X POST -F 'id=%s' -F '_n=%s' -F '_t=%s' -F 'extra_data={\"version\":\"%s\", \"sn\":\"%s\", \"suffix\":\"" ..
                          LOG_SUFFIX .. "\"}' -F 'mode=%s' -F 'key=%s' -F 'payload=@" ..
                          LOG_ZIP_FILEPATH .. "' %s"

-- 生成日志上传V2的键
-- @return string 日志键
function generateLogKeyV2()
    local deviceId = getDeviceId() or ""
    local hardware = XQSysUtil.getHardware() or ""
    local timestamp = os.time()
    return "common-" .. hardware .. "-" .. deviceId .. "-" .. timestamp
end

-- 上传日志文件V2
-- @param logFileName 日志文件名（可选，用于提取时间戳）
-- @return boolean 是否成功
function uploadLogV2(logFileName)
    local luciSys = require("luci.sys")
    
    local deviceId = getDeviceId() or ""
    local nonce = luciSys.uniqueid(10)
    local timestamp = os.time()
    local romVersion = XQSysUtil.getRomVersion()
    local sn = getSN() or ""
    local hardware = XQSysUtil.getHardware() or ""
    
    local uploadUrl = string.format(LOG_UPLOAD_URL_V2, hardware)
    local mode = ""
    
    if logFileName then
        mode = "useRomTime"
        local extractedTime = logFileName:match("%-(%d+)$")
        timestamp = extractedTime
    else
        logFileName = ""
    end
    
    local cmd = string.format(LOG_UPLOAD_CMD_V2, deviceId, nonce, timestamp, romVersion, sn, mode, logFileName, uploadUrl)
    local result = luci.util.exec(cmd)
    
    if result == nil or result == "" then
        return false
    else
        if string.find(result, "\"code\":0") ~= nil then
            return true
        else
            return false
        end
    end
end

-- ==================== 小米账号登录 ====================

local XIAOMI_ACCOUNT_URL = "https://account.xiaomi.com/"
local XIAOMI_ACCOUNT_PREVIEW_URL = "http://account.preview.n.xiaomi.net/"
local LOGIN_AUTH_PATH = "pass/serviceLoginAuth"
local LOGIN_PATH = "pass/serviceLogin?sid=xiaoqiang"

-- 小米账号登录
-- @param username 用户名
-- @param passwordHash 密码哈希（MD5大写）
-- @return table 登录结果 {code=状态码, uuid=用户ID, token=令牌, ...}
--         code: 0=成功, 1=用户名/密码错误, 2=认证失败, 3=服务不可达
function xiaomiLogin(username, passwordHash)
    local json = require("json")
    local XQLog = require("xiaoqiang.XQLog")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local userId, nonce, passToken, ssecurity, psecurity, location, domain = nil, nil, nil, nil, nil, nil, nil
    
    local params = {
        {"user", username},
        {"hash", string.upper(passwordHash)},
        {"sid", "xiaoqiang"},
        {"deviceId", getSN() or ""}
    }
    
    local loginUrl = nil
    if XQConfigs.SERVER_CONFIG == 1 then
        loginUrl = XIAOMI_ACCOUNT_PREVIEW_URL .. LOGIN_AUTH_PATH
    else
        loginUrl = XIAOMI_ACCOUNT_URL .. LOGIN_AUTH_PATH
    end
    
    local postData = ""
    table.foreach(params, function(_, item)
        postData = postData .. item[1] .. "=" .. item[2] .. "&"
    end)
    
    local response = XQHttpUtil.httpPostRequest(loginUrl, string.sub(postData, 1, -2))
    
    if response.code == 302 then
        local extensionPragma = response.headers["extension-pragma"]
        local setCookie = response.headers["set-cookie"]
        local pragmaData = json.decode(extensionPragma)
        
        location = response.headers.location
        userId = setCookie:match("userId=(%d+);")
        passToken = setCookie:match("passToken=(%S+);")
        domain = setCookie:match("domain=(%S+);")
        nonce = extensionPragma:match("%S+\"nonce\":(%d+),%S+")
        ssecurity = pragmaData.ssecurity
        psecurity = pragmaData.psecurity
        
        XQLog.log(7, "XiaomiLogin Step1 Succeed:", response)
        
        local signData = "nonce=" .. nonce .. "&" .. ssecurity
        local clientSign = XQCryptoUtil.binaryBase64Enc(XQCryptoUtil.sha1Binary(signData))
        
        local step2Params = XQFunction.xq_urlencode_params({
            uuid = userId,
            clientSign = clientSign
        })
        
        local step2Url = location .. "&" .. step2Params
        local step2Response = XQHttpUtil.httpGetRequest(step2Url)
        
        local serviceToken = nil
        if step2Response.code == 200 then
            if type(step2Response.headers) == "table" then
                local step2Cookie = step2Response.headers["set-cookie"]
                if step2Cookie then
                    serviceToken = step2Cookie:match("serviceToken=(%S+);")
                end
            end
        elseif step2Response.code == 401 then
            XQLog.log(3, "XiaomiLogin Step2 401 Failed:", step2Url, step2Response)
            return {code = 2}
        end
        
        local sid = ssecurity
        
        if not XQFunction.isStrNil(userId) and
           not XQFunction.isStrNil(passToken) and
           not XQFunction.isStrNil(serviceToken) and
           not XQFunction.isStrNil(sid) and
           not XQFunction.isStrNil(ssecurity) then
            XQLog.log(7, "XiaomiLogin Step2 succeed:" .. userId)
            XQDBUtil.savePassport(userId, passToken, serviceToken, sid, ssecurity)
            return {
                code = 0,
                uuid = userId,
                token = passToken,
                stoken = serviceToken,
                sid = sid,
                ssecurity = ssecurity
            }
        else
            XQLog.log(3, "XiaomiLogin Step2 Failed:", {
                step2url = step2Url,
                userId = userId or "",
                passToken = passToken or "",
                ssecurity = ssecurity or ""
            })
            return {code = 2}
        end
    elseif response.code == 200 then
        XQLog.log(3, "XiaomiLogin Step1 Username/Password Error:", params, response)
        return {code = 1}
    else
        XQLog.log(3, "XiaomiLogin Step1 Service Unreachable:", params, response)
        return {code = 3}
    end
end

-- ==================== 用户信息 ====================

-- 获取用户凭证
-- @param uuid 用户ID（可选）
-- @return table|false 凭证信息或false
function getPassport(uuid)
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    
    if XQFunction.isStrNil(uuid) then
        uuid = XQSysUtil.getBindUUID()
    end
    
    if XQFunction.isStrNil(uuid) then
        return false
    end
    
    local passport = XQDBUtil.fetchPassport(uuid)
    passport = passport[1]
    
    if not passport then
        return false
    end
    
    if XQFunction.isStrNil(passport.token) then
        return false
    end
    
    cachedToken = passport.token
    return passport
end

-- 生成原始头像URL
-- @param iconUrl 头像URL
-- @return string 原始尺寸头像URL
function generateOrigIconUrl(iconUrl)
    if XQFunction.isStrNil(iconUrl) then
        return ""
    else
        return string.gsub(iconUrl, ".jpg", "_150.jpg")
    end
end

local USER_INFO_URL = "http://api.account.xiaomi.com/pass/usersCard?ids="

-- 获取用户信息
-- @param uuid 用户ID（可选）
-- @return table|false 用户信息或false
function getUserInfo(uuid)
    local json = require("json")
    
    if XQFunction.isStrNil(uuid) then
        uuid = XQSysUtil.getBindUUID()
        if XQFunction.isStrNil(uuid) then
            return false
        end
    end
    
    local response = XQHttpUtil.httpGetRequest(USER_INFO_URL .. uuid)
    
    if response.code ~= 200 then
        return false
    end
    
    local data = json.decode(response.res)
    if data then
        if string.upper(data.result) == "OK" then
            local list = data.data.list
            local userInfo = list[1]
            if userInfo then
                local result = {}
                result.aliasNick = userInfo.aliasNick or ""
                result.miliaoNick = userInfo.miliaoNick or ""
                result.userId = userInfo.userId or ""
                result.miliaoIcon = userInfo.miliaoIcon or ""
                result.miliaoIconOrig = generateOrigIconUrl(result.miliaoIcon)
                XQSysUtil.setBindUserInfo(result)
                return result
            end
        end
    end
    
    return false
end

-- ==================== 设备ID ====================

local serverConfigUrl = luci.util.trim(luci.util.exec(XQConfigs.SERVER_CONFIG_ONLINE_URL))
local API_SERVER_URL = "https://" .. serverConfigUrl

if XQConfigs.SERVER_CONFIG == 1 then
    API_SERVER_URL = XQConfigs.SERVER_CONFIG_STAGING_URL
elseif XQConfigs.SERVER_CONFIG == 2 then
    API_SERVER_URL = XQConfigs.SERVER_CONFIG_PREVIEW_URL
end

local UPGRADE_PATH = "/rs/grayupgrade"
local PCTL_DPI_UPGRADE_PATH = "/rs/parent_control/feature_lib"
local UPGRADE_PATH_V2 = "/rs/grayupgrade/v2/r01"
local RECOVERY_UPGRADE_PATH = "/rs/grayupgrade/recovery"
local DEVICE_LIST_PATH = "/s/admin/deviceList"
local ADMIN_LIST_PATH = "/s/device/adminList"
local REGISTER_PATH = "/s/register"
local ADMIN_PROMOTE_PATH = "/s/admin/promote"
local ADMIN_DISMISS_PATH = "/s/admin/dismiss"
local PLUGIN_ENABLE_PATH = "/s/plugin/enable"
local PLUGIN_DISABLE_PATH = "/s/plugin/disable"
local PLUGIN_LIST_PATH = "/s/plugin/list"
local PLUGIN_DETAIL_PATH = "/s/plugin/detail"
local DEVICE_NAME_PATH = "/s/device/name"

-- 获取设备ID
-- @return string 设备ID
function getDeviceId()
    local luciUtil = require("luci.util")
    local deviceId = luciUtil.exec(XQConfigs.XQ_DEVICE_ID)
    
    if XQFunction.isStrNil(deviceId) then
        deviceId = ""
    end
    
    return luciUtil.trim(deviceId)
end

-- ==================== 升级检测 ====================

-- 检查家长控制DPI库升级
-- @return table|false 升级信息或false
function checkPctlDPIUpgrade()
    local json = require("json")
    
    local params = {
        {"hardware", XQSysUtil.getHardware()}
    }
    
    local queryParams = {}
    table.foreach(params, function(_, item)
        queryParams[item[1]] = item[2]
    end)
    
    local queryString = httpProtocol.urlencode_params(queryParams)
    local path = PCTL_DPI_UPGRADE_PATH .. "?" .. queryString
    local url = cryptUrl(API_SERVER_URL, path, params, API_TOKEN)
    
    local response = XQHttpUtil.httpGetRequest(url)
    
    if response.code ~= 200 then
        return false
    end
    
    local data = nil
    local function parseJson(str)
        data = json.decode(str)
    end
    
    local success = pcall(parseJson, response.res)
    if not success then
        return false
    end
    
    if not data then
        return false
    end
    
    if tonumber(data.code) == 0 then
        local result = {}
        if data.data then
            result.downloadUrl = data.data.downloadUrl
            result.fullHash = data.data.fullHash
            result.fileSize = data.data.fileSize
            result.version = data.data.version
        else
            result = false
        end
        return result
    else
        return false
    end
end

-- 检查生态系统升级
-- @param version 当前版本
-- @param channel 渠道
-- @param filterID 过滤ID
-- @param countryCode 国家代码
-- @return table|false 升级信息或false
function checkEcosUpgrade(version, channel, filterID, countryCode)
    local json = require("json")
    
    local params = {
        {"version", version},
        {"hardware", "r01"},
        {"channel", channel},
        {"filterID", filterID},
        {"countryCode", countryCode}
    }
    
    local queryParams = {}
    table.foreach(params, function(_, item)
        queryParams[item[1]] = item[2]
    end)
    
    local queryString = httpProtocol.urlencode_params(queryParams)
    local path = UPGRADE_PATH_V2 .. "?" .. queryString
    local url = cryptUrl(API_SERVER_URL, path, params, API_TOKEN)
    
    local response = XQHttpUtil.httpGetRequest(url)
    
    if response.code ~= 200 then
        return false
    end
    
    local data = nil
    local function parseJson(str)
        data = json.decode(str)
    end
    
    local success = pcall(parseJson, response.res)
    if not success then
        return false
    end
    
    if not data then
        return false
    end
    
    if tonumber(data.code) == 0 then
        local result = {}
        if data.data then
            local upgradeInfo = data.data.upgradeInfo
            if upgradeInfo then
                if upgradeInfo.link then
                    result.needUpdate = 1
                    result.downloadUrl = upgradeInfo.link
                    result.fullHash = upgradeInfo.hash
                    result.fileSize = upgradeInfo.size
                    result.version = upgradeInfo.toVersion
                    result.description = upgradeInfo.description
                end
            end
        else
            result.needUpdate = 0
        end
        return result
    else
        return false
    end
end

-- 从下载URL中提取ISP版本号
-- @param downloadUrl 下载URL
-- @return string ISP版本号
function get_ispver(downloadUrl)
    local startPos, endPos = string.find(downloadUrl, "_ispver")
    if endPos == nil then
        return ""
    end
    
    local remaining = string.sub(downloadUrl, endPos + 2)
    if XQFunction.isStrNil(remaining) then
        return ""
    end
    
    local underscorePos, underscoreEnd = string.find(remaining, "_")
    startPos = underscoreEnd
    endPos = underscorePos
    
    if endPos == nil then
        local binPos, binEnd = string.find(remaining, ".bin")
        startPos = binEnd
        endPos = binPos
        if endPos == nil then
            return ""
        end
    end
    
    return string.sub(remaining, 1, endPos - 1)
end

-- 检查固件升级
-- @return table|false 升级信息或false
function checkUpgrade()
    local json = require("json")
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local luciUtil = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    
    local hardwareInfo = XQSysUtil.getMiscHardwareInfo()
    local isRecoveryMode = hardwareInfo.recovery == 1
    
    local params = {}
    
    if isRecoveryMode then
        local nvramConfigs = XQSysUtil.getNvramConfigs()
        params = {
            {"deviceID", ""},
            {"rom", nvramConfigs.rom_ver},
            {"hardware", XQSysUtil.getHardware()},
            {"cfe", nvramConfigs.uboot},
            {"linux", nvramConfigs.linux},
            {"ramfs", nvramConfigs.ramfs},
            {"sqafs", nvramConfigs.sqafs},
            {"rootfs", nvramConfigs.rootfs},
            {"channel", nvramConfigs.rom_channel},
            {"serialNumber", XQFunction.nvramGet("SN", "")},
            {"ispCode", XQSysUtil.getISPCode()}
        }
    else
        local specialRegion = XQSysUtil.specialRegionEnable()
        if specialRegion == 1 then
            params = {
                {"deviceID", getDeviceId()},
                {"rom", XQSysUtil.getRomVersion()},
                {"hardware", XQSysUtil.getHardware()},
                {"cfe", XQSysUtil.getCFEVersion()},
                {"linux", XQSysUtil.getKernelVersion()},
                {"ramfs", XQSysUtil.getRamFsVersion()},
                {"sqafs", XQSysUtil.getSqaFsVersion()},
                {"rootfs", XQSysUtil.getRootFsVersion()},
                {"channel", XQSysUtil.getChannel()},
                {"countryCode", XQCountryCode.getCurrentCountryCode()},
                {"bCountryCode", XQCountryCode.getBDataRegion()},
                {"locale", XQCountryCode.getCurrentJLan()},
                {"serialNumber", getSN() or ""},
                {"ispCode", XQSysUtil.getISPCode()}
            }
        else
            params = {
                {"deviceID", getDeviceId()},
                {"rom", XQSysUtil.getRomVersion()},
                {"hardware", XQSysUtil.getHardware()},
                {"cfe", XQSysUtil.getCFEVersion()},
                {"linux", XQSysUtil.getKernelVersion()},
                {"ramfs", XQSysUtil.getRamFsVersion()},
                {"sqafs", XQSysUtil.getSqaFsVersion()},
                {"rootfs", XQSysUtil.getRootFsVersion()},
                {"channel", XQSysUtil.getChannel()},
                {"countryCode", XQCountryCode.getCurrentCountryCode()},
                {"locale", XQCountryCode.getCurrentJLan()},
                {"serialNumber", getSN() or ""},
                {"ispCode", XQSysUtil.getISPCode()}
            }
        end
    end
    
    local queryParams = {}
    table.foreach(params, function(_, item)
        queryParams[item[1]] = item[2]
    end)
    
    local queryString = httpProtocol.urlencode_params(queryParams)
    local upgradePath = isRecoveryMode and RECOVERY_UPGRADE_PATH or UPGRADE_PATH
    local path = upgradePath .. "?" .. queryString
    local url = cryptUrl(API_SERVER_URL, path, params, API_TOKEN)
    
    local response = XQHttpUtil.httpGetRequest(url)
    
    if response.code ~= 200 then
        return false
    end
    
    local data = nil
    local function parseJson(str)
        data = json.decode(str)
    end
    
    local success = pcall(parseJson, response.res)
    if not success then
        return false
    end
    
    if not data then
        return false
    end
    
    if tonumber(data.code) == 0 then
        local result = {}
        if data.data then
            if data.data.link then
                local description = XQFunction.parseEnter2br(luciUtil.trim(data.data.description))
                local weight = tonumber(data.data.weight)
                
                result.needUpdate = 1
                result.downloadUrl = data.data.link
                result.fullHash = data.data.hash
                result.fileSize = data.data.size
                result.version = data.data.toVersion
                
                local dtSpec = XQFunction.getFeature("0", "system", "dt_spec")
                if dtSpec == "1" then
                    result.ispver = get_ispver(result.downloadUrl)
                    if XQFunction.isStrNil(data.data.buildTime) then
                        result.buildTime = XQSysUtil.getRomBuildtime()
                    else
                        result.buildTime = luciUtil.trim(os.date("%Y/%m/%d", tonumber(data.data.buildTime) / 1000))
                    end
                end
                
                result.weight = weight or 1
                result.changelogUrl = data.data.changelogUrl
                result.changeLog = description
            end
        else
            local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
            XQMessageBox.removeMessage(1)
            
            local description = ""
            if data.data then
                if data.data.description then
                    description = XQFunction.parseEnter2br(luciUtil.trim(data.data.description))
                end
            end
            
            result.needUpdate = 0
            result.version = XQSysUtil.getRomVersion()
            result.changeLog = description
        end
        
        if data.data then
            if data.data.otherParam then
                if data.data.otherParam ~= "" then
                    result.otherParam = json.decode(data.data.otherParam)
                end
            end
        end
        
        return result
    else
        return false
    end
end

-- ==================== 签名请求 ====================

-- 生成请求签名
-- @param method HTTP方法
-- @param body 请求体
-- @param params 参数列表
-- @param secret 密钥
-- @return string 签名
function generateSignature(method, body, params, secret)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local signStr = ""
    
    if params then
        local paramCount = #params
        if paramCount > 0 then
            table.sort(params, function(a, b)
                return a[1] < b[1]
            end)
            
            table.foreach(params, function(_, item)
                signStr = signStr .. item[1] .. "=" .. item[2] .. "&"
            end)
        end
    end
    
    signStr = signStr .. secret
    
    if not XQFunction.isStrNil(body) then
        signStr = body .. "&" .. signStr
    end
    
    if not XQFunction.isStrNil(method) then
        signStr = string.upper(method) .. "&" .. signStr
    end
    
    return XQCryptoUtil.hash4SHA1(signStr)
end

-- 执行签名API请求
-- @param method HTTP方法（GET/POST）
-- @param path API路径
-- @param params 参数列表（可选）
-- @param uuid 用户ID（可选）
-- @return table|false 响应数据或false
function doRequest(method, path, params, uuid)
    local json = require("json")
    local xqcrypto = require("xqcrypto")
    local luciUtil = require("luci.util")
    local XQLog = require("xiaoqiang.XQLog")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local passport = getPassport(uuid)
    method = string.upper(method)
    
    if not passport then
        XQLog.log(3, "XQRequest: Passport missing " .. path)
        return false
    end
    
    local nonce = xqcrypto.generateNonce()
    
    local cookies = {}
    cookies.userId = passport.uuid
    cookies.serviceToken = passport.stoken
    
    local sessionSecurity = xqcrypto.generateSessionSecurity(nonce)
    
    local encryptedParams = ""
    if params then
        if type(params) == "table" then
            for _, item in ipairs(params) do
                encryptedParams = encryptedParams .. item[1] .. "=" .. item[2] .. ";;"
            end
        end
    else
        params = {}
    end
    
    local queryParams = {}
    local debugParams = {}
    
    local encryptedData = xqcrypto.encryptParams(sessionSecurity, encryptedParams)
    if encryptedData then
        local dataCount = #encryptedData
        if dataCount > 0 then
            for i, item in ipairs(params) do
                table.insert(queryParams, {item[1], encryptedData[i]})
                table.insert(debugParams, {item[1], encryptedData[i]})
            end
        end
    end
    
    local rc4Hash = sessionSecurity
    for _, item in ipairs(queryParams) do
        if item[1] == "rc4_hash__" then
            rc4Hash = item[2]
            break
        end
    end
    
    local signature = generateSignature(method, nil, queryParams, rc4Hash)
    
    table.insert(queryParams, {"signature", signature})
    table.insert(queryParams, {"_nonce", nonce})
    table.insert(queryParams, {"rc4_hash__", rc4Hash})
    
    local requestParams = {}
    table.foreach(queryParams, function(_, item)
        requestParams[item[1]] = item[2]
    end)
    
    local response
    if method == "GET" then
        response = XQHttpUtil.httpGetRequest(API_SERVER_URL .. path, requestParams, cookies)
    elseif method == "POST" then
        response = XQHttpUtil.httpPostRequest(API_SERVER_URL .. path, requestParams, cookies)
    end
    
    if response.code == 200 then
        local decryptedResult = xqcrypto.decryptResult(sessionSecurity, response.res)
        
        if not XQFunction.isStrNil(decryptedResult) then
            decryptedResult = string.gsub(decryptedResult, "u201c", "\"")
            decryptedResult = string.gsub(decryptedResult, "u201d", "\"")
            
            XQLog.log(7, "XQRequest succeed:" .. decryptedResult)
            return json.decode(decryptedResult)
        end
    elseif response.code == 401 then
        XQLog.log(3, "XQRequest 401:" .. API_SERVER_URL .. path, "QueryString:" .. tostring(requestParams), debugParams)
        return {code = 401}
    end
    
    XQLog.log(3, "XQRequest Failed:" .. API_SERVER_URL .. path, "QueryString:" .. tostring(requestParams), debugParams)
    return false
end
