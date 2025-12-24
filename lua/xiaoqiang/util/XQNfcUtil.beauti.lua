--[[
  XQNfcUtil NFC工具模块
  
  功能说明：
  - 通过NFC标签分享WiFi配置
  - 支持WPS (Wi-Fi Protected Setup) 标准格式
  - 将WiFi配置编码为I2C数据格式写入NFC标签
  
  NFC标签数据格式：
  - 使用WPS TLV (Type-Length-Value) 格式
  - 支持的加密类型：Open, WPA-Personal, WPA2-Personal, SAE
  - 支持的加密算法：None, WEP, TKIP, AES
  
  主要功能：
  - nfc_is_supported: 检查设备是否支持NFC
  - nfc_is_enabled: 检查NFC是否已启用
  - nfc_update: 更新NFC标签中的WiFi配置
  - nfc_disable: 禁用NFC功能
]]

module("xiaoqiang.util.XQNfcUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local uci = require("luci.model.uci")
local uciCursor = uci.cursor()

-- ==================== WPS属性定义 ====================
-- WPS TLV属性表，格式：{属性ID, 最大长度}
local WPS_ATTRIBUTES = {}
WPS_ATTRIBUTES["802.1X_Enabled"] = {4193, 1}
WPS_ATTRIBUTES.AP_Channel = {4097, 2}
WPS_ATTRIBUTES.AP_Setup_Locked = {4183, 1}
WPS_ATTRIBUTES.Association_State = {4098, 2}
WPS_ATTRIBUTES.Authentication_Type = {4099, 2}
WPS_ATTRIBUTES.Authenticator = {4101, 8}
WPS_ATTRIBUTES.Configuration_Methods = {4104, 2}
WPS_ATTRIBUTES.Credential = {4110, 0}
WPS_ATTRIBUTES.Device_Name = {4113, 32}
WPS_ATTRIBUTES.Device_Password_ID = {4114, 2}
WPS_ATTRIBUTES.EAP_Identity = {4173, 64}
WPS_ATTRIBUTES.EAP_Type = {4185, 8}
WPS_ATTRIBUTES["E-Hash1"] = {4116, 32}
WPS_ATTRIBUTES["E-Hash2"] = {4117, 32}
WPS_ATTRIBUTES.Encrypted_Settings = {4120, 0}
WPS_ATTRIBUTES.Encryption_Type = {4111, 2}
WPS_ATTRIBUTES.MAC_Address = {4128, 6}
WPS_ATTRIBUTES.Manufacturer = {4129, 64}
WPS_ATTRIBUTES.Model_Name = {4131, 32}
WPS_ATTRIBUTES.Model_Number = {4132, 32}
WPS_ATTRIBUTES.Network_Index = {4134, 1}
WPS_ATTRIBUTES.Network_Key = {4135, 64}
WPS_ATTRIBUTES.Network_Key_Index = {4136, 1}
WPS_ATTRIBUTES.OS_Version = {4141, 4}
WPS_ATTRIBUTES.Permitted_Configuration_Methods = {4178, 2}
WPS_ATTRIBUTES.Power_Level = {4143, 1}
WPS_ATTRIBUTES.Radio_Enabled = {4147, 1}
WPS_ATTRIBUTES.RF_Bands = {4156, 1}
WPS_ATTRIBUTES.Serial_Number = {4162, 32}
WPS_ATTRIBUTES.SSID = {4165, 32}
WPS_ATTRIBUTES.Total_Networks = {4166, 1}
WPS_ATTRIBUTES.Vendor_Extension = {4193, 1}
WPS_ATTRIBUTES.Version = {4170, 1}
WPS_ATTRIBUTES["Wi-Fi_Simple_Configuration_State"] = {4164, 1}

-- ==================== WPS枚举值定义 ====================

-- 关联状态
local ASSOCIATION_STATE = {}
ASSOCIATION_STATE.Not_Associated = 0
ASSOCIATION_STATE.Connection_Success = 1
ASSOCIATION_STATE.Configuration_Failure = 2
ASSOCIATION_STATE.Association_Failure = 3
ASSOCIATION_STATE.IP_Failure = 4

-- 认证类型（位掩码）
local AUTHENTICATION_TYPE = {}
AUTHENTICATION_TYPE.Open = 1
AUTHENTICATION_TYPE["WPA-Personal"] = 2
AUTHENTICATION_TYPE.Shared = 4
AUTHENTICATION_TYPE["WPA-Enterprise"] = 8
AUTHENTICATION_TYPE["WPA2-Enterprise"] = 16
AUTHENTICATION_TYPE["WPA2-Personal"] = 32
AUTHENTICATION_TYPE.SAE = 32  -- WPA3-Personal

-- 配置方法（位掩码）
local CONFIGURATION_METHODS = {}
CONFIGURATION_METHODS.USBA = 1
CONFIGURATION_METHODS.Ethernet = 2
CONFIGURATION_METHODS.Label = 4
CONFIGURATION_METHODS.Display = 8
CONFIGURATION_METHODS.External_NFC_Token = 16
CONFIGURATION_METHODS.Integrated_NFC_Token = 32
CONFIGURATION_METHODS.NFC_Interface = 64
CONFIGURATION_METHODS.Pushbutton = 128
CONFIGURATION_METHODS.Keypad = 256
CONFIGURATION_METHODS.Virtual_Pushbutton = 640
CONFIGURATION_METHODS.Physical_Pushbutton = 1152
CONFIGURATION_METHODS["Reserved)"] = 2176
CONFIGURATION_METHODS.P2Ps = 4096
CONFIGURATION_METHODS.Virtual_Display_PIN = 8200
CONFIGURATION_METHODS.Physical_Display_PIN = 16392

-- 加密类型（位掩码）
local ENCRYPTION_TYPE = {}
ENCRYPTION_TYPE.None = 1
ENCRYPTION_TYPE.WEP = 2
ENCRYPTION_TYPE.TKIP = 4
ENCRYPTION_TYPE.AES = 8
ENCRYPTION_TYPE["AES/TKIP"] = 12

-- 射频频段（位掩码）
local RF_BANDS = {}
RF_BANDS["2.4GHz"] = 1
RF_BANDS["5GHz"] = 2
RF_BANDS["60GHz"] = 4

-- ==================== NFC数据格式常量 ====================
-- NDEF记录类型（application/vnd.wfa.wsc）
local NFC_RECORD_TYPE = "0x61 0x70 0x70 0x6c 0x69 0x63 0x61 0x74 0x69 0x6f 0x6e 0x2f 0x76 0x6e 0x64 0x2e 0x77 0x66 0x61 0x2e 0x77 0x73 0x63"
local NFC_RECORD_HEADER = "0xd2 0x17"
local NFC_SHORT_RECORD = "0x03"
local NFC_TERMINATOR = "0xfe"

-- ==================== 辅助函数 ====================

-- 检查NFC是否处于默认状态（未初始化）
-- @return boolean 是否为默认状态
function nfc_is_default()
    local isInitted = uciCursor:get("xiaoqiang", "common", "INITTED") or "NO"
    local nfcSsid = uciCursor:get("wireless", "nfc_2g", "ssid") or "NO"
    
    if nfcSsid == "NO" then
        return false
    end
    
    if isInitted == "NO" then
        return true
    end
    
    return false
end

-- 检查设备是否支持NFC
-- @return boolean 是否支持NFC
function nfc_is_supported()
    local nfcSupport = uciCursor:get("misc", "nfc", "nfc_support") or "0"
    
    if nfcSupport == "0" then
        return false
    end
    
    return true
end

-- 检查NFC是否已启用
-- @return boolean NFC是否启用
function nfc_is_enabled()
    local nfcEnable = uciCursor:get("nfc", "nfc", "nfc_enable") or "0"
    
    if nfcEnable == "0" then
        return false
    end
    
    return true
end

-- 将字符串转换为I2C格式的十六进制数据
-- @param str 输入字符串
-- @return string I2C格式的十六进制字符串
function str_to_i2c(str)
    local result = ""
    for i = 1, string.len(str) do
        result = result .. string.format("0x%02x ", string.byte(str, i))
    end
    local len = string.len(result)
    result = string.sub(result, 1, len - 1)
    return result
end

-- 将单字节数值转换为I2C格式
-- @param value 字节值（0-255）
-- @return string I2C格式的十六进制字符串
function byte_to_i2c(value)
    return string.format("0x%02x", math.floor(value))
end

-- 将双字节数值转换为I2C格式（大端序）
-- @param value 双字节值（0-65535）
-- @return string I2C格式的十六进制字符串
function word_to_i2c(value)
    local bit = require("bit")
    local highByte = bit.rshift(value, 8)
    local lowByte = bit.band(value, 255)
    return string.format("0x%02x 0x%02x", highByte, lowByte)
end

-- 将四字节数值转换为I2C格式（大端序）
-- @param value 四字节值
-- @return string I2C格式的十六进制字符串
function uint32_to_i2c(value)
    local bit = require("bit")
    local highWord = bit.rshift(value, 16)
    local lowWord = bit.band(value, 65535)
    return word_to_i2c(highWord) .. " " .. word_to_i2c(lowWord)
end

-- 计算I2C格式字符串的字节数
-- @param i2cStr I2C格式字符串
-- @return number 字节数
function i2c_strlen(i2cStr)
    local len = string.len(i2cStr)
    return (len + 1) / 5
end

-- 禁用NFC功能
function nfc_disable()
    XQFunction.forkExec(string.format("/sbin/nfc disable"))
end

-- ==================== WiFi标签生成函数 ====================

-- 生成当前WiFi配置的NFC标签数据
-- @return string NFC标签数据（I2C格式）或 "no_tag" 表示无可用WiFi
function update_wifi_tag()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local wifiList = {}
    local selectedWifi = {}
    local found = 0
    local tagData = ""
    local authType = ""
    
    local ifname2g = uciCursor:get("misc", "wireless", "ifname_2G") or ""
    local ifname5g = uciCursor:get("misc", "wireless", "ifname_5G") or ""
    local ifname5gHigh = uciCursor:get("misc", "wireless", "ifname_5GH") or ""
    
    wifiList = XQWifiUtil.getAllWifiInfo()
    
    for _, wifi in ipairs(wifiList) do
        if wifi.ifname == ifname5g then
            if wifi.status == "1" then
                selectedWifi = wifi
                found = 1
                break
            end
        end
    end
    
    if found == 0 then
        for _, wifi in ipairs(wifiList) do
            if wifi.ifname == ifname5gHigh then
                if wifi.status == "1" then
                    selectedWifi = wifi
                    found = 1
                    break
                end
            end
        end
    end
    
    if found == 0 then
        for _, wifi in ipairs(wifiList) do
            if wifi.ifname == ifname2g then
                if wifi.status == "1" then
                    selectedWifi = wifi
                    found = 1
                    break
                end
            end
        end
    end
    
    if found == 0 then
        for _, wifi in ipairs(wifiList) do
            if wifi.status == "1" then
                selectedWifi = wifi
                found = 1
                break
            end
        end
    end
    
    if found == 0 then
        return "no_tag"
    end
    
    tagData = word_to_i2c(WPS_ATTRIBUTES.Network_Index[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Network_Index[2]) .. " " .. "0x01" .. " "
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.SSID[1]) .. " " ..
              word_to_i2c(string.len(selectedWifi.ssid)) .. " " ..
              str_to_i2c(selectedWifi.ssid) .. " "
    
    local encryption = selectedWifi.encryption
    if encryption == "psk2+ccmp" or encryption == "ccmp" then
        authType = AUTHENTICATION_TYPE.SAE
    elseif encryption == "psk2" then
        authType = AUTHENTICATION_TYPE["WPA2-Personal"]
    elseif encryption == "mixed-psk" then
        authType = AUTHENTICATION_TYPE["WPA2-Personal"] + AUTHENTICATION_TYPE["WPA-Personal"]
    else
        authType = AUTHENTICATION_TYPE.Open
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[2]) .. " " ..
              word_to_i2c(authType) .. " "
    
    local encType
    if encryption == "none" then
        encType = ENCRYPTION_TYPE.None
    else
        encType = ENCRYPTION_TYPE.AES
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Encryption_Type[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Encryption_Type[2]) .. " " ..
              word_to_i2c(encType) .. " "
    
    if encryption ~= "none" then
        tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Network_Key[1]) .. " " ..
                  word_to_i2c(string.len(selectedWifi.password)) .. " " ..
                  str_to_i2c(selectedWifi.password) .. " "
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.MAC_Address[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.MAC_Address[2]) .. " " ..
              "0xff 0xff 0xff 0xff 0xff 0xff"
    
    local credentialLen = i2c_strlen(tagData)
    tagData = word_to_i2c(WPS_ATTRIBUTES.Credential[1]) .. " " ..
              word_to_i2c(credentialLen) .. " " .. tagData
    
    return tagData
end

-- 生成默认WiFi配置的NFC标签数据（从UCI配置读取）
-- @return string NFC标签数据（I2C格式）
function default_wifi_tag()
    local tagData = ""
    local authType = ""
    local ssid = ""
    local encryption = ""
    local password = ""
    
    ssid = uciCursor:get("wireless", "nfc_2g", "ssid")
    password = uciCursor:get("wireless", "nfc_2g", "key")
    encryption = uciCursor:get("wireless", "nfc_2g", "encryption")
    
    tagData = word_to_i2c(WPS_ATTRIBUTES.Network_Index[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Network_Index[2]) .. " " .. "0x01" .. " "
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.SSID[1]) .. " " ..
              word_to_i2c(string.len(ssid)) .. " " ..
              str_to_i2c(ssid) .. " "
    
    if encryption == "psk2+ccmp" or encryption == "ccmp" then
        authType = AUTHENTICATION_TYPE.SAE
    elseif encryption == "psk2" then
        authType = AUTHENTICATION_TYPE["WPA2-Personal"]
    elseif encryption == "mixed-psk" then
        authType = AUTHENTICATION_TYPE["WPA2-Personal"] + AUTHENTICATION_TYPE["WPA-Personal"]
    else
        authType = AUTHENTICATION_TYPE.Open
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[2]) .. " " ..
              word_to_i2c(authType) .. " "
    
    local encType
    if encryption == "none" then
        encType = ENCRYPTION_TYPE.None
    else
        encType = ENCRYPTION_TYPE.AES
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Encryption_Type[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Encryption_Type[2]) .. " " ..
              word_to_i2c(encType) .. " "
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Network_Key[1]) .. " " ..
              word_to_i2c(string.len(password)) .. " " ..
              str_to_i2c(password) .. " "
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.MAC_Address[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.MAC_Address[2]) .. " " ..
              "0xff 0xff 0xff 0xff 0xff 0xff"
    
    local credentialLen = i2c_strlen(tagData)
    tagData = word_to_i2c(WPS_ATTRIBUTES.Credential[1]) .. " " ..
              word_to_i2c(credentialLen) .. " " .. tagData
    
    return tagData
end

-- 禁用Mesh同步（用于NFC配置）
function nfc_mesh_sync_disable()
    local cursor = require("luci.model.uci").cursor()
    cursor:set("nfc", "nfc", "mesh_sync_disabled", "1")
    cursor:commit("nfc")
end

-- 更新NFC标签
-- 根据当前状态选择使用默认配置或当前WiFi配置
-- @return number 0表示失败或NFC不支持/未启用
function nfc_update()
    local tagData = ""
    local payloadLen = 0
    local totalLen = 0
    
    local isSupported = nfc_is_supported()
    local isEnabled = nfc_is_enabled()
    local isDefault = nfc_is_default()
    
    if isSupported == false or isEnabled == false then
        return 0
    end
    
    if isDefault == true then
        tagData = default_wifi_tag()
    else
        tagData = update_wifi_tag()
    end
    
    if tagData == "no_tag" then
        nfc_disable()
        return 0
    end
    
    payloadLen = i2c_strlen(tagData)
    
    if tagData == "" then
        tagData = NFC_RECORD_HEADER .. " " .. byte_to_i2c(payloadLen) .. " " .. NFC_RECORD_TYPE
    else
        tagData = NFC_RECORD_HEADER .. " " .. byte_to_i2c(payloadLen) .. " " ..
                  NFC_RECORD_TYPE .. " " .. tagData
    end
    
    totalLen = i2c_strlen(tagData)
    
    if totalLen <= 255 then
        tagData = NFC_SHORT_RECORD .. " " .. byte_to_i2c(totalLen) .. " " ..
                  tagData .. " " .. NFC_TERMINATOR
    else
        tagData = NFC_SHORT_RECORD .. " " .. uint32_to_i2c(totalLen) .. " " ..
                  tagData .. " " .. NFC_TERMINATOR
    end
    
    XQFunction.forkExec(string.format("/sbin/nfc update '%s' %d", tagData, math.floor(i2c_strlen(tagData))))
end
