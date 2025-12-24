--[[
  小米路由器国家/地区代码模块
  
  功能说明:
  - 定义支持的国家/地区列表
  - 管理WiFi区域设置（2.4G/5G频段）
  - 语言与国家代码映射
  - 国家代码的获取和设置
  
  支持的国家/地区:
  - CN: 中国大陆 (p=true 表示主要支持)
  - HK: 香港地区
  - TW: 台湾地区
  - KR: 韩国
  - US: 美国
  - EU: 欧洲
  - SG: 新加坡
  - MY: 马来西亚
  - IN: 印度
  - 等等...
  
  无线区域标准:
  - ETSI: 欧洲电信标准协会 (DE, UK, EU等)
  - FCC: 美国联邦通信委员会 (US, ID)
  - AS: 亚洲标准 (HK, SG, MY等)
]]

module("xiaoqiang.XQCountryCode", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local i18n = require("luci.i18n")

-- 翻译辅助函数
local function _(text)
    return i18n.translate(text)
end

-- 国家/地区代码列表
-- c: 国家代码 (ISO 3166-1 alpha-2)
-- n: 国家名称 (支持国际化)
-- p: 是否为主要支持的国家/地区
COUNTRY_CODE = {
    { c = "CN", n = _("中国大陆"), p = true },
    { c = "HK", n = _("香港地区"), p = true },
    { c = "TW", n = _("台湾地区"), p = true },
    { c = "KR", n = _("韩国"), p = true },
    { c = "US", n = _("美国"), p = false },
    { c = "SG", n = _("新加坡"), p = false },
    { c = "MY", n = _("马来西亚"), p = false },
    { c = "IN", n = _("印度"), p = false },
    { c = "CA", n = _("加拿大"), p = false },
    { c = "FR", n = _("法国"), p = false },
    { c = "DE", n = _("德国"), p = false },
    { c = "IT", n = _("意大利"), p = false },
    { c = "ES", n = _("西班牙"), p = false },
    { c = "PH", n = _("菲律宾"), p = false },
    { c = "ID", n = _("印度尼西亚"), p = false },
    { c = "TH", n = _("泰国"), p = false },
    { c = "VN", n = _("越南"), p = false },
    { c = "BR", n = _("巴西"), p = false },
    { c = "RU", n = _("俄罗斯"), p = false },
    { c = "MX", n = _("墨西哥"), p = false },
    { c = "TR", n = _("土耳其"), p = false },
    { c = "EU", n = _("欧洲"), p = true }
}

-- WiFi区域配置
-- region: 2.4GHz频段区域代码
-- regionABand: 5GHz频段区域代码
REGION = {
    CN = { region = 1, regionABand = 0 },
    TW = { region = 0, regionABand = 13 },
    HK = { region = 1, regionABand = 0 },
    US = { region = 0, regionABand = 10 },
    EU = { region = 1, regionABand = 6 },
    KR = { region = 1, regionABand = 23 },
    ID = { region = 1, regionABand = 5 }
}

-- 国家代码到语言代码的映射
LANGUAGE = {
    CN = "zh_cn",
    TW = "zh_tw",
    HK = "zh_hk",
    US = "en",
    EU = "en",
    KR = "ko_kr",
    ID = "en_id"
}

-- Java语言代码映射 (用于客户端)
JLANGUAGE = {
    zh_cn = "zh_CN",
    zh_tw = "zh_TW",
    zh_hk = "zh_HK",
    en = "en_US",
    ko_kr = "ko_KR",
    en_id = "en_ID"
}

-- 检查是否为ETSI标准国家（欧洲电信标准协会）
-- @param country_code 国家代码
-- @return boolean 是否为ETSI国家
function isCountryETSI(country_code)
    if country_code == "DE" or country_code == "UK" or country_code == "EU" then
        return true
    end
    
    if isCountryETSI_special(country_code) then
        return true
    end
    
    return false
end

-- 检查是否为特殊ETSI国家
-- @param country_code 国家代码
-- @return boolean 是否为特殊ETSI国家
function isCountryETSI_special(country_code)
    -- 乌克兰、俄罗斯、埃及、摩洛哥
    if country_code == "UA" or country_code == "RU" or 
       country_code == "EG" or country_code == "MA" then
        return true
    end
    
    -- 阿塞拜疆、哈萨克斯坦、乌兹别克斯坦、尼日利亚、突尼斯
    if country_code == "AZ" or country_code == "KZ" or 
       country_code == "UZ" or country_code == "NG" or 
       country_code == "TN" then
        return true
    end
    
    return false
end

-- 检查是否为FCC标准国家（美国联邦通信委员会）
-- @param country_code 国家代码
-- @return boolean 是否为FCC国家
function isCountryFCC(country_code)
    if country_code == "US" or country_code == "ID" then
        return true
    end
    return false
end

-- 检查是否为亚洲标准国家
-- @param country_code 国家代码
-- @return boolean 是否为亚洲标准国家
function isCountryAS(country_code)
    -- 香港、新加坡、马来西亚、肯尼亚、阿联酋、沙特阿拉伯
    if country_code == "HK" or country_code == "SG" or 
       country_code == "MY" or country_code == "KE" or 
       country_code == "AE" or country_code == "SA" then
        return true
    end
    return false
end

-- 获取主要支持的国家/地区列表
-- @return table 国家/地区列表 [{name, code}, ...]
function getCountryCodeList()
    local result = {}
    
    for _, country in ipairs(COUNTRY_CODE) do
        if country and country.p then
            table.insert(result, {
                name = country.n,
                code = country.c
            })
        end
    end
    
    return result
end

-- 获取当前国家代码
-- @return string 当前国家代码，默认为"CN"
function getCurrentCountryCode()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    local country_code = XQFunction.nvramGet("CountryCode")
    local channel = XQSysUtil.getChannel()
    
    if XQFunction.isStrNil(country_code) then
        return "CN"
    end
    
    return country_code
end

-- 获取SIM卡国家代码（CPE设备用）
-- @return string SIM卡国家代码
function getSimCountryCode()
    local uci = require("luci.model.uci").cursor()
    
    local country_code = uci:get("mobile", "sim", "country_code")
    
    if XQFunction.isStrNil(country_code) then
        return ""
    end
    
    return country_code
end

-- 获取BData中存储的区域代码
-- @return string 区域代码，默认为"CN"
function getBDataRegion()
    local bdata_code = XQFunction.bdataGet("CountryCode")
    local nvram_code = XQFunction.nvramGet("CountryCode")
    
    if XQFunction.isStrNil(bdata_code) then
        return "CN"
    end
    
    return bdata_code
end

-- 获取BData国家代码（考虑区域映射）
-- @return string 国家代码
function getBDataCountryCode()
    local uci = require("luci.model.uci").cursor()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    local bdata_region = getBDataRegion()
    local nvram_code = XQFunction.nvramGet("CountryCode")
    
    -- 从区域映射配置获取国家代码
    local country_code = uci:get("region_mapping", bdata_region, "CountryCode")
    
    if XQFunction.isStrNil(country_code) then
        country_code = bdata_region
    end
    
    -- EU区域特殊处理
    if bdata_region == "EU" then
        if isCountryETSI_special(nvram_code) then
            country_code = nvram_code
        end
    end
    
    -- UK区域特殊处理
    if bdata_region == "UK" then
        if isCountryAS(nvram_code) then
            country_code = nvram_code
        end
    end
    
    return country_code
end

-- 设置当前国家代码
-- @param country_code 国家代码
-- @return boolean 是否设置成功
function setCurrentCountryCode(country_code)
    if XQFunction.isStrNil(country_code) then
        return false
    end
    
    -- 验证国家代码是否有效
    if REGION[country_code] == nil then
        return false
    end
    
    if LANGUAGE[country_code] == nil then
        return false
    end
    
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 保存到NVRAM
    XQFunction.nvramSet("CountryCode", country_code)
    XQFunction.nvramCommit()
    
    -- 设置WiFi区域
    local region_config = REGION[country_code]
    XQWifiUtil.setWifiRegion(country_code, region_config.region, region_config.regionABand)
    
    return true
end

-- 获取当前Java语言代码
-- @return string Java语言代码
function getCurrentJLan()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    local channel = XQSysUtil.getChannel()
    local lang = XQSysUtil.getLang() or lang
    
    return JLANGUAGE[lang]
end
