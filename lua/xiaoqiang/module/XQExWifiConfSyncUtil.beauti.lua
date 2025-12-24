--[[
  小米路由器 - WiFi配置同步工具模块
  功能: 用于扩展WiFi设备(中继器等)与主路由之间的配置同步
  包括登录认证、配置获取、配置推送等功能
  模块名: xiaoqiang.module.XQExWifiConfSyncUtil
]]

module("xiaoqiang.module.XQExWifiConfSyncUtil", package.seeall)

-- 引入依赖模块
local socketHttp = require("socket.http")                       -- HTTP请求库
local cjson = require("cjson")                                  -- JSON解析
local luciHttp = require("luci.http")                           -- Luci HTTP库
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")     -- 加密工具
local XQLog = require("xiaoqiang.XQLog")                        -- 日志模块

-- 常量定义
local SHARED_KEY = "a2ffa5c9be07488bbb04a3a47d3c5f6a"           -- 共享密钥
local LOGIN_TYPE = 1002                                          -- 登录类型
local RANDOM_MAX = 9998                                          -- 随机数最大值
local MAX_RETRY = 6                                              -- 最大重试次数

-- 错误码定义
local ERROR_CODE = {
    ERROR_INTERNAL = 1639,      -- 内部错误
    ERROR_PEER_INFO = 1640,     -- 对端信息错误
    ERROR_CONFIG_TRANS = 1641,  -- 配置传输错误
    ERROR_INVALID_MODE = 1642   -- 无效模式
}

--[[
  生成随机数(nonce)用于登录认证
  @param mac MAC地址
  @return string, string 原始nonce和URL编码后的nonce
]]
local function generateNonce(mac)
    local deviceType = 0
    
    -- MAC地址转大写
    local upperMac = string.upper(mac)
    
    -- URL编码MAC地址
    local encodedMac = luciHttp.urlencode(upperMac)
    
    -- 获取当前时间戳
    local timestamp = os.time()
    
    -- 设置随机种子并生成随机数
    math.randomseed(timestamp)
    local randomNum = math.random(LOGIN_TYPE, RANDOM_MAX)
    
    -- 构建nonce字符串: deviceType_mac_timestamp_random
    local nonce = deviceType .. "_" .. upperMac .. "_" .. timestamp .. "_" .. randomNum
    local encodedNonce = deviceType .. "_" .. encodedMac .. "_" .. timestamp .. "_" .. randomNum
    
    return nonce, encodedNonce
end

--[[
  计算登录密码哈希
  @param mac   MAC地址
  @param nonce 随机数
  @return string|nil 密码哈希或nil(失败时)
]]
local function calculatePasswordHash(mac, nonce)
    if not nonce then
        XQLog.log(XQLog.LOG_ERROR, "please generate nonce first!")
        return nil
    end
    
    -- 第一次SHA1: mac + 共享密钥
    local hash = XQCryptoUtil.sha1(mac .. SHARED_KEY)
    
    -- 第二次SHA1: nonce + 第一次哈希结果
    hash = XQCryptoUtil.sha1(nonce .. hash)
    
    return hash
end

--[[
  获取文件大小
  @param file 文件句柄
  @return number 文件大小(字节)
]]
local function getFileSize(file)
    local currentPos = file:seek()
    local size = file:seek("end")
    file:seek("set", currentPos)
    return size
end

--[[
  账户登录(获取token)
  @param peerIp   对端IP地址
  @param peerMac  对端MAC地址
  @param localMac 本地MAC地址
  @return string|number token或错误码
]]
function account_login(peerIp, peerMac, localMac)
    local responseData = {}
    local url, token, code = nil, nil, nil
    
    -- 生成nonce
    local nonce, encodedNonce = generateNonce(peerMac)
    
    -- 计算密码哈希
    local passwordHash = calculatePasswordHash(localMac, nonce)
    
    -- 构建登录请求体
    local requestBody = "username=admin&password=" .. passwordHash .. 
                       "&logtype=2&nonce=" .. encodedNonce
    
    XQLog.log(XQLog.LOG_DEBUG, "login request: " .. requestBody)
    
    -- 发送HTTP POST请求
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/api/xqsystem/login",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8",
            ["Content-Length"] = #requestBody
        },
        source = ltn12.source.string(requestBody),
        sink = ltn12.sink.table(responseData)
    })
    
    -- 检查请求是否成功
    if not response or not status or not headers then
        XQLog.log(XQLog.LOG_ERROR, "login request failed")
        return ERROR_CODE.ERROR_PEER_INFO
    end
    
    if response ~= 1 or status ~= 200 then
        XQLog.log(XQLog.LOG_ERROR, "login failed, response: " .. response .. " status: " .. status)
        return ERROR_CODE.ERROR_PEER_INFO
    end
    
    -- 解析响应JSON
    if type(responseData) == "table" then
        for _, chunk in ipairs(responseData) do
            local jsonData = cjson.decode(chunk)
            url = jsonData.url
            token = jsonData.token
            code = jsonData.code
        end
    end
    
    -- 检查登录结果
    if code == 0 then
        return token
    end
    
    return ERROR_CODE.ERROR_PEER_INFO
end

--[[
  从对端获取配置文件
  @param peerIp   对端IP地址
  @param token    认证token
  @param savePath 保存路径
  @return number 错误码(0=成功)
]]
function config_get(peerIp, token, savePath)
    local checksum = nil
    
    -- 参数验证
    if not peerIp or not token or not savePath then
        XQLog.log(XQLog.LOG_ERROR, "invalid input parameters!")
        return ERROR_CODE.ERROR_INTERNAL
    end
    
    XQLog.log(XQLog.LOG_DEBUG, "get config from peer: " .. peerIp .. " save to: " .. savePath)
    
    -- 打开保存文件
    local file = io.open(savePath, "wb")
    if not file then
        XQLog.log(XQLog.LOG_ERROR, "file open failed: " .. savePath)
        return ERROR_CODE.ERROR_INTERNAL
    end
    
    -- 发送HTTP GET请求获取配置
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/;stok=" .. token .. 
              "/api/misystem/extendwifi_config_pull",
        method = "GET",
        sink = ltn12.sink.file(file)
    })
    
    -- 检查请求是否成功
    if not response or not status or not headers then
        XQLog.log(XQLog.LOG_ERROR, "config get request failed")
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    if response ~= 1 or status ~= 200 then
        XQLog.log(XQLog.LOG_ERROR, "config get failed, response: " .. response .. " status: " .. status)
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    -- 获取校验和
    if type(headers) == "table" then
        for key, value in pairs(headers) do
            if key == "Content-Checksum" then
                checksum = value
            end
        end
    end
    
    -- 验证文件
    file = io.open(savePath, "rb")
    if not file then
        XQLog.log(XQLog.LOG_ERROR, "config file open failed!")
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    -- 计算文件MD5并验证
    local fileMd5 = XQCryptoUtil.md5File(savePath)
    if checksum ~= fileMd5 then
        XQLog.log(XQLog.LOG_ERROR, "config file checksum failed!")
        file:close()
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    XQLog.log(XQLog.LOG_DEBUG, "config file checksum ok!")
    file:close()
    
    XQLog.log(XQLog.LOG_DEBUG, "everything seems ok with config get!")
    return 0
end

--[[
  向对端推送配置文件
  @param peerIp     对端IP地址
  @param token      认证token
  @param configPath 配置文件路径
  @return number, string, string, string, string 错误码和WiFi配置信息
]]
function config_post(peerIp, token, configPath)
    local responseData = {}
    local jsonResult, code, ssid24g, password24g, ssid5g, password5g = nil, nil, nil, nil, nil, nil
    
    -- 参数验证
    if not peerIp or not token or not configPath then
        XQLog.log(XQLog.LOG_ERROR, "invalid input parameters!")
        return ERROR_CODE.ERROR_INTERNAL
    end
    
    XQLog.log(XQLog.LOG_DEBUG, "post config to peer: " .. peerIp .. " " .. configPath)
    
    -- 打开配置文件
    local file = io.open(configPath, "rb")
    if not file then
        XQLog.log(XQLog.LOG_ERROR, "file open failed: " .. configPath)
        return ERROR_CODE.ERROR_INTERNAL
    end
    
    -- 计算文件MD5校验和
    local checksum = XQCryptoUtil.md5File(configPath)
    if not checksum then
        io.close(file)
        XQLog.log(XQLog.LOG_ERROR, "file calculate checksum failed: " .. configPath)
        return ERROR_CODE.ERROR_INTERNAL
    end
    
    -- 获取文件大小
    local fileSize = getFileSize(file)
    
    -- 读取文件内容
    local fileContent = file:read("*a")
    
    -- 构建multipart/form-data请求体
    local fieldName = "config"
    local fileName = "config.tar.gz"
    local boundary = "-----------------------------7004473821227421780129388645"
    
    local contentDisposition = 'Content-Disposition: form-data; name="' .. fieldName .. 
                               '"; filename="' .. fileName .. '"\r\n'
    local contentType = "Content-Type: application/octetstream\r\n\r\n"
    
    local requestBody = "--" .. boundary .. "\r\n" .. contentDisposition .. contentType .. 
                       fileContent .. "\r\n--" .. boundary .. "--\r\n"
    
    -- 发送HTTP POST请求
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/;stok=" .. token .. 
              "/api/misystem/extendwifi_config_push?checksum=" .. checksum,
        method = "POST",
        headers = {
            ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
            ["Content-Length"] = #requestBody
        },
        source = ltn12.source.string(requestBody),
        sink = ltn12.sink.table(responseData)
    })
    
    file:close()
    
    -- 检查请求是否成功
    if not response or not status or not headers then
        XQLog.log(XQLog.LOG_ERROR, "config post request failed")
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    if response ~= 1 or status ~= 200 then
        XQLog.log(XQLog.LOG_ERROR, "config post failed, response: " .. response .. " status: " .. status)
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    -- 解析响应JSON
    if type(responseData) == "table" then
        for _, chunk in ipairs(responseData) do
            jsonResult = cjson.decode(chunk)
        end
    end
    
    -- 提取WiFi配置信息
    if jsonResult then
        code = jsonResult.code
        ssid24g = jsonResult.ssid_24g
        password24g = jsonResult.password_24g
        ssid5g = jsonResult.ssid_5g
        password5g = jsonResult.password_5g
    end
    
    -- 检查推送结果
    if code ~= 0 then
        if code then
            XQLog.log(XQLog.LOG_ERROR, "config post error code: " .. code)
        end
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    -- 记录WiFi配置信息
    if ssid24g then
        XQLog.log(XQLog.LOG_DEBUG, "ssid_24g: " .. ssid24g)
    end
    if password24g then
        XQLog.log(XQLog.LOG_DEBUG, "password_24g: " .. password24g)
    end
    if ssid5g then
        XQLog.log(XQLog.LOG_DEBUG, "ssid_5g: " .. ssid5g)
    end
    if password5g then
        XQLog.log(XQLog.LOG_DEBUG, "password_5g: " .. password5g)
    end
    
    XQLog.log(XQLog.LOG_DEBUG, "everything seems ok with config post!")
    
    return 0, ssid24g, password24g, ssid5g, password5g
end

--[[
  完成配置同步(通知对端重启或关闭WiFi)
  @param peerIp     对端IP地址
  @param token      认证token
  @param enableWifi 是否启用WiFi
  @param reboot     是否重启
  @return number 错误码(0=成功)
]]
function config_finish(peerIp, token, enableWifi, reboot)
    local responseData = {}
    local jsonResult, code = nil, nil
    
    -- 参数验证
    if not peerIp or not token then
        XQLog.log(XQLog.LOG_ERROR, "invalid input parameters!")
        return 1
    end
    
    -- 构建请求参数
    local params
    if not enableWifi and reboot then
        params = "reboot=yes"
    elseif enableWifi and not reboot then
        params = "wifi=off"
    else
        XQLog.log(XQLog.LOG_ERROR, "invalid input parameters, wifi: " .. tostring(enableWifi) .. 
                  " reboot: " .. tostring(reboot))
        return 1
    end
    
    -- 发送HTTP GET请求
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/;stok=" .. token .. 
              "/api/misystem/extendwifi_config_fini?" .. params,
        method = "GET",
        sink = ltn12.sink.table(responseData)
    })
    
    -- 检查请求是否成功
    if not response or not status or not headers then
        XQLog.log(XQLog.LOG_ERROR, "config finish request failed")
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    if response ~= 1 or status ~= 200 then
        XQLog.log(XQLog.LOG_ERROR, "config finish failed, response: " .. response .. " status: " .. status)
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    -- 解析响应JSON
    if type(responseData) == "table" then
        for _, chunk in ipairs(responseData) do
            jsonResult = cjson.decode(chunk)
        end
    end
    
    -- 提取返回码
    if jsonResult then
        code = jsonResult.code
    end
    
    -- 检查完成结果
    if code ~= 0 then
        if code then
            XQLog.log(XQLog.LOG_ERROR, "config finish error code: " .. code)
        end
        return ERROR_CODE.ERROR_CONFIG_TRANS
    end
    
    XQLog.log(XQLog.LOG_DEBUG, "everything seems ok with config finish!")
    return 0
end
