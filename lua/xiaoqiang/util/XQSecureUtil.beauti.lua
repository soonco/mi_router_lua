---
--- XQSecureUtil 安全工具模块
--- 小米路由器安全验证和密码管理工具
--- 功能：XSS过滤、密码加密验证、Nonce管理、命令安全检查、密码强度检测
---

module("xiaoqiang.util.XQSecureUtil", package.seeall)

require("luci.util")
require("luci.sys")

local bit = require("bit")
local nixio = require("nixio")
require("nixio.util")
local nixioFs = require("nixio.fs")
local XQLog = require("xiaoqiang.XQLog")
local xssFilter = require("xssFilter").new()
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQPreference = require("xiaoqiang.XQPreference")
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

local PASSWORD_SALT = "a2ffa5c9be07488bbb04a3a47d3c5f6a"
local OPENSSL_DECRYPT_CMD = "echo -e '%s' | openssl aes-128-cbc -d -K '%s' -iv '64175472480004614961023454661220' -base64"
local AES_DECRYPT_CMD = "echo -e '%s' | /usr/bin/aes_crypt -b -d -k '%s' -i 64175472480004614961023454661220 -"
local NONCE_BASE_PATH = "/etc/tmp"
local NONCE_PATH = "/etc/tmp/luci-nonce"

--- 检查ID格式是否有效（必须是十六进制字符串）
--- @param id string 待检查的ID
--- @return boolean 是否有效
function checkid(id)
    local len = #id
    local isInvalid = id and not id:match("^[a-fA-F0-9]+$")
    return isInvalid
end

--- 准备Nonce存储目录
function prepare()
    nixioFs.mkdir(NONCE_BASE_PATH, 700)
    nixioFs.mkdir(NONCE_PATH, 700)
    
    if not sane() then
        error("Security Exception: Nonce path is not sane!")
    end
end

--- 检查路径安全性（确保路径属于当前用户）
--- @param path string 待检查的路径
--- @return boolean 是否安全
function sane(path)
    local currentUid = luci.sys.process.info("uid")
    local pathUid = nixioFs.stat(path or NONCE_PATH, "uid")
    return currentUid == pathUid
end

--- 读取Nonce数据
--- @param nonceId string Nonce ID
--- @return table Nonce数据表
function readNonce(nonceId)
    if not nonceId or not checkid(nonceId) then
        return nil
    end
    
    local noncePath = NONCE_PATH .. "/" .. nonceId
    
    if not sane(noncePath) then
        return nil
    end
    
    local content = nixioFs.readfile(noncePath)
    local loader = loadstring(content)
    setfenv(loader, {})
    local data = loader()
    
    if type(data) ~= "table" then
        return nil
    end
    
    return data
end

--- 写入Nonce数据
--- @param nonceId string Nonce ID
--- @param data table Nonce数据表
function writeNonce(nonceId, data)
    if not sane() then
        prepare()
    end
    
    if not checkid(nonceId) or type(data) ~= "table" then
        return
    end
    
    local bytecode = luci.util.get_bytecode(data)
    local file = nixio.open(NONCE_PATH .. "/" .. nonceId, "w", 600)
    file:writeall(bytecode)
    file:close()
end

--- XSS安全检查
--- @param input string 待检查的输入
--- @return string 过滤后的安全字符串
function xssCheck(input)
    if XQFunction.isStrNil(input) then
        return input
    end
    
    if type(input) == "string" then
        local filtered = xssFilter:filter(input)
        if filtered then
            return filtered
        else
            local XQLog = require("xiaoqiang.XQLog")
            XQLog.log(4, "XSS Warning:" .. input)
            return nil
        end
    else
        return input
    end
end

--- 生成重定向密钥
--- @param redirectType string 重定向类型
--- @return string 生成的密钥
function generateRedirectKey(redirectType)
    local sys = require("luci.sys")
    local sauth = require("luci.sauth")
    
    local session = {}
    local sessionId = sys.uniqueid(16)
    session.type = tostring(redirectType)
    
    sauth.write(sessionId, session)
    return sessionId
end

--- 检查重定向密钥有效性
--- @param key string 重定向密钥
--- @return string|boolean 重定向类型或false
function checkRedirectKey(key)
    if XQFunction.isStrNil(key) then
        return false
    end
    
    local sys = require("luci.sys")
    local sauth = require("luci.sauth")
    
    local session = sauth.read(key)
    
    if session then
        if type(session) == "table" then
            sauth.kill(key)
            local uptime = sys.uptime()
            local elapsed = uptime - session.atime
            
            if elapsed > 10 then
                return false
            else
                return tostring(session.type)
            end
        end
    end
    
    return false
end

--- 密文格式化（按64字符分割）
--- @param ciphertext string 密文
--- @return string 格式化后的密文
function ciphertextFormat(ciphertext)
    if XQFunction.isStrNil(ciphertext) then
        return ""
    end
    
    local lineCount = math.ceil(#ciphertext / 64)
    local lines = {}
    
    for i = 1, lineCount do
        if i ~= lineCount then
            table.insert(lines, string.sub(ciphertext, (i - 1) * 64 + 1, i * 64))
        else
            table.insert(lines, string.sub(ciphertext, (i - 1) * 64 + 1, -1))
        end
    end
    
    return table.concat(lines, "\n")
end

--- 解密密文
--- @param account string 账户名
--- @param ciphertext string 密文
--- @param section string 配置节名（可选）
--- @return string 解密后的明文
function decCiphertext(account, ciphertext, section)
    if XQFunction.isStrNil(ciphertext) then
        return nil
    end
    
    if ciphertext:match("\"") or ciphertext:match(" ") or ciphertext:match("'") then
        return nil
    end
    
    local key = XQPreference.get_ext(account, "", "account", section)
    
    local opensslCmd = string.format(OPENSSL_DECRYPT_CMD, ciphertextFormat(ciphertext), key)
    local aesCmd = string.format(AES_DECRYPT_CMD, ciphertext, key)
    
    local result = os.execute(opensslCmd .. "> /dev/null")
    
    if result == 0 then
        return luci.util.trim(luci.util.exec(opensslCmd))
    else
        result = os.execute(aesCmd .. "> /dev/null")
        if result == 0 then
            return luci.util.trim(luci.util.exec(aesCmd))
        end
    end
    
    return nil
end

--- 保存明文密码（哈希后存储）
--- @param account string 账户名
--- @param password string 明文密码
--- @return boolean 是否保存成功
function savePlaintextPwd(account, password)
    if XQFunction.isStrNil(account) or XQFunction.isStrNil(password) then
        return false
    end
    
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local encryptMode = XQSysUtil.getEncryptMode()
    local hashedPwd
    
    if encryptMode == 1 then
        hashedPwd = XQCryptoUtil.sha256(password .. PASSWORD_SALT)
    else
        hashedPwd = XQCryptoUtil.sha1(password .. PASSWORD_SALT)
    end
    
    XQPreference.set(account, hashedPwd, "account")
    return true
end

--- 保存明文密码扩展版（同时保存新旧格式）
--- @param account string 账户名
--- @param password string 明文密码
--- @return boolean 是否保存成功
function savePlaintextPwdEx(account, password)
    if XQFunction.isStrNil(account) or XQFunction.isStrNil(password) then
        return false
    end
    
    local uci = require("luci.model.uci").cursor()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local encryptMode = XQSysUtil.getEncryptMode()
    
    local sha1Hash = XQCryptoUtil.sha1(password .. PASSWORD_SALT)
    
    if encryptMode == 1 then
        local sha256Hash = XQCryptoUtil.sha256(password .. PASSWORD_SALT)
        uci:set("account", "common", account, sha256Hash)
        uci:set("account", "legacy", account, sha1Hash)
    else
        uci:set("account", "common", account, sha1Hash)
    end
    
    uci:commit("account")
    return true
end

--- 保存密文密码
--- @param account string 账户名
--- @param ciphertext string 密文密码
--- @return boolean 是否保存成功
function saveCiphertextPwd(account, ciphertext)
    if XQFunction.isStrNil(account) or XQFunction.isStrNil(ciphertext) then
        return false
    end
    
    local decrypted = decCiphertext(account, ciphertext)
    
    if decrypted then
        XQPreference.set(account, decrypted, "account")
        return true
    end
    
    return false
end

--- 保存密文遗留密码
--- @param account string 账户名
--- @param ciphertext string 密文密码
--- @return boolean 是否保存成功
function saveCiphertextLegacyPwd(account, ciphertext)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    if XQFunction.isStrNil(ciphertext) then
        return true
    end
    
    local decrypted = decCiphertext(account, ciphertext, "legacy")
    
    if decrypted then
        XQPreference.set_ext(account, decrypted, "account", "legacy")
        return true
    end
    
    return false
end

--- 检查明文密码
--- @param account string 账户名
--- @param password string 明文密码
--- @return boolean 密码是否正确
function checkPlaintextPwd(account, password)
    if XQFunction.isStrNil(account) or XQFunction.isStrNil(password) then
        return false
    end
    
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local encryptMode = XQSysUtil.getEncryptMode()
    
    local storedPwd = XQPreference.get(account, "", "account")
    local hashedPwd
    
    if encryptMode == 1 then
        hashedPwd = XQCryptoUtil.sha256(password .. PASSWORD_SALT)
    else
        hashedPwd = XQCryptoUtil.sha1(password .. PASSWORD_SALT)
    end
    
    if storedPwd == hashedPwd then
        return true
    else
        return false
    end
end

--- 检查用户认证
--- @param account string 账户名
--- @param nonce string 随机数
--- @param hash string 哈希值
--- @return boolean 认证是否通过
function checkUser(account, nonce, hash)
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local encryptMode = XQSysUtil.getEncryptMode()
    
    if XQFunction.isStrNil(account) then
        return false
    end
    
    local storedPwd = XQPreference.get(account, nil, "account")
    
    if storedPwd then
        if not XQFunction.isStrNil(hash) and not XQFunction.isStrNil(nonce) then
            if encryptMode == 1 then
                local expectedHash = XQCryptoUtil.sha256(nonce .. storedPwd)
                if expectedHash == hash then
                    return true
                end
            else
                local expectedHash = XQCryptoUtil.sha1(nonce .. storedPwd)
                if expectedHash == hash then
                    return true
                end
            end
        end
    end
    
    XQLog.log(4, luci.http.getenv("REMOTE_ADDR") or "" .. " Authentication failed", nonce, storedPwd, hash)
    return false
end

--- 检查Nonce有效性
--- @param nonceStr string Nonce字符串
--- @param macAddr string MAC地址
--- @return boolean Nonce是否有效
function checkNonce(nonceStr, macAddr)
    local LuciUtil = require("luci.util")
    local sys = require("luci.sys")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    if nonceStr and macAddr then
        macAddr = XQFunction.macFormat(macAddr)
        local parts = LuciUtil.split(nonceStr, "_")
        
        if #parts ~= 4 then
            XQLog.log(6, "Nonce check failed!: Illegal" .. nonceStr .. " remote MAC address:" .. macAddr)
            return false
        end
        
        local nonceType = tonumber(parts[1])
        local deviceId = tostring(parts[2])
        local mark = tonumber(parts[3])
        
        if nonceType and deviceId then
            local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
            local encryptMode = XQSysUtil.getEncryptMode()
            local nonceId
            
            if encryptMode == 1 then
                nonceId = XQCryptoUtil.sha256(nonceType .. deviceId)
            else
                nonceId = XQCryptoUtil.sha1(nonceType .. deviceId)
            end
            
            if nonceType > 4 then
                XQLog.log(6, "Nonce check failed! Type error:" .. nonceStr .. " remote MAC address:" .. macAddr)
                return false
            end
            
            local nonceData = readNonce(nonceId)
            
            if nonceData then
                if type(nonceData) == "table" then
                    local storedMark = tonumber(nonceData.mark)
                    
                    if mark > storedMark then
                        if macAddr ~= nonceData.mac then
                            XQLog.log(6, "Mac address changed: " .. nonceData.mac .. " --> " .. macAddr, nonceData, nonceStr)
                        end
                        
                        nonceData.mark = tostring(mark)
                        writeNonce(nonceId, nonceData)
                        return true
                    else
                        XQLog.log(6, "Nonce check failed!: Not match" .. nonceStr .. " remote MAC address:" .. macAddr, nonceData)
                    end
                end
            else
                nonceData = {}
                nonceData.mark = tostring(mark)
                nonceData.mac = macAddr
                writeNonce(nonceId, nonceData)
                return true
            end
        end
    end
    
    return false
end

local PASSPORT_SID = "xiaoqiang-web"

--- 获取Passport登录URL
--- @return string 登录URL
function passportLoginUrl()
    local protocol = require("luci.http.protocol")
    local XQConfigs = require("xiaoqiang.common.XQConfigs")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local loginUrl = nil
    local followupUrl = "http://miwifi.com/cgi-bin/luci/web/xmaccount"
    local signData = "followup=" .. followupUrl
    
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local encryptMode = XQSysUtil.getEncryptMode()
    local sign
    
    if encryptMode == 1 then
        sign = XQCryptoUtil.binaryBase64Enc(XQCryptoUtil.sha256Binary(signData))
    else
        sign = XQCryptoUtil.binaryBase64Enc(XQCryptoUtil.sha1Binary(signData))
    end
    
    if XQConfigs.SERVER_CONFIG == 0 then
        loginUrl = XQConfigs.PASSPORT_CONFIG_ONLINE_URL 
            .. "?callback=" 
            .. protocol.urlencode(XQConfigs.XQ_SERVER_ONLINE_STS_URL .. "?sign=" .. sign .. "&followup=" .. followupUrl)
            .. "&sid=" .. PASSPORT_SID
    elseif XQConfigs.SERVER_CONFIG == 1 then
        loginUrl = XQConfigs.PASSPORT_CONFIG_PREVIEW_URL 
            .. "?callback=" 
            .. protocol.urlencode(XQConfigs.XQ_SERVER_STAGING_STS_URL .. "?sign=" .. sign .. "&followup=" .. followupUrl)
            .. "&sid=" .. PASSPORT_SID
    end
    
    return loginUrl
end

--- 获取Passport登出URL
--- @return string 登出URL
function passportLogoutUrl()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local protocol = require("luci.http.protocol")
    local XQConfigs = require("xiaoqiang.common.XQConfigs")
    
    local logoutUrl = nil
    local userId = XQSysUtil.getPassportBindInfo()
    
    if XQFunction.isStrNil(userId) then
        return ""
    end
    
    local callbackUrl = "http://miwifi.com/cgi-bin/luci/web/home"
    
    if XQConfigs.SERVER_CONFIG == 0 then
        logoutUrl = XQConfigs.PASSPORT_LOGOUT_ONLINE_URL 
            .. "?callback=" .. protocol.urlencode(callbackUrl)
            .. "&sid=" .. PASSPORT_SID
            .. "&userId=" .. userId
    elseif XQConfigs.SERVER_CONFIG == 1 then
        logoutUrl = XQConfigs.PASSPORT_LOGOUT_PREVIEW_URL 
            .. "?callback=" .. protocol.urlencode(callbackUrl)
            .. "&sid=" .. PASSPORT_SID
            .. "&userId=" .. userId
    end
    
    return logoutUrl
end

--- 检查密码强度
--- @param password string 密码
--- @return number 强度级别 (1=弱, 2=中, 3=强)
function checkStrong(password)
    local score = 0
    local lengthBonus = {l = 0.5}
    
    if XQFunction.isStrNil(password) then
        return 1
    end
    
    local len = #password
    
    if len < 6 then
        return 1
    else
        local bonus = lengthBonus.l * math.sqrt((len - 6) / 2)
        if bonus > 2 then
            bonus = 1
        end
        score = score + bonus
    end
    
    if password:match("%d") then
        score = score + 1
    end
    
    if password:match("%l") then
        score = score + 1
    end
    
    if password:match("%u") then
        score = score + 1
    end
    
    if password:match("%W") then
        score = score + 1
    end
    
    if score < 2 then
        return 1
    elseif score < 3 then
        return 2
    else
        return 3
    end
end

KEY_WORDS = {"'", ";", "nvram", "dropbear", "bdata"}

--- 关键词过滤（内部函数）
--- @param input string 输入字符串
--- @return string|boolean 过滤后的字符串或false
local function _keyWordsFilter(input)
    if not input then
        return input
    end
    
    for _, keyword in ipairs(KEY_WORDS) do
        if input:match(keyword) then
            local XQLog = require("xiaoqiang.XQLog")
            XQLog.log(6, "Keyword Warning:" .. input)
            return false
        end
    end
    
    return input
end

--- 命令安全检查
--- @param cmd string 命令字符串
--- @return string|boolean 安全的命令或false
function cmdSafeCheck(cmd)
    return _keyWordsFilter(cmd)
end

local HACK_CHARS_PATTERN = "[`;|$&\n]"

local SAFE_PARAMS = {
    name = 1,
    password = 1,
    password2g = 1,
    password5g = 1,
    password5g2 = 1,
    pppoeName = 1,
    pppoePwd = 1,
    pwd = 1,
    pwd1 = 1,
    pwd2 = 1,
    pwd3 = 1,
    newPwd = 1,
    service = 1,
    ssid = 1,
    ssid1 = 1,
    ssid2 = 1,
    ssid3 = 1,
    ssid2g = 1,
    ssid5g = 1,
    ssid5g2 = 1,
    username = 1,
    apn = 1,
    pdp = 1,
    user = 1,
    passwd = 1,
    contact_phone = 1,
    phoneList = 1,
    msgtext = 1,
    acs_username = 1,
    acs_password = 1,
    conn_username = 1,
    conn_password = 1
}

--- 黑客攻击检查
--- @param key string 参数名
--- @param value string 参数值
--- @return string 安全的值或nil
function hackCheck(key, value)
    if not key or not value then
        return value
    end
    
    if SAFE_PARAMS[key] then
        return value
    end
    
    if string.find(value, HACK_CHARS_PATTERN) then
        XQLog.log(3, "hackCheck match key:" .. key .. " val:" .. value)
        return nil
    end
    
    return value
end

--- 黑客字符检查
--- @param input string 输入字符串
--- @return string 安全的字符串
function hackCharsCheck(input)
    if string.find(input, HACK_CHARS_PATTERN) then
        return ""
    end
    return input
end

--- 解析命令行参数（转义特殊字符）
--- @param input string 输入字符串
--- @return string 转义后的字符串
function parseCmdline(input)
    if XQFunction.isStrNil(input) then
        return ""
    else
        local result = input:gsub("\\", "\\\\")
        result = result:gsub("`", "\\`")
        result = result:gsub("\"", "\\\"")
        result = result:gsub("%$", "\\$")
        result = result:gsub("%&", "\\&")
        result = result:gsub("%|", "\\|")
        result = result:gsub("%;", "\\;")
        return result
    end
end
