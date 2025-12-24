--[[
  LED控制工具模块 (XQLEDControlUtil)
  提供路由器LED灯控制功能
  包括系统LED、氛围灯(XLED)、网口LED等控制
]]--

module("xiaoqiang.util.XQLEDControlUtil", package.seeall)

local uci = require("luci.model.uci").cursor()
local XQLog = require("xiaoqiang.XQLog")
local XQFunction = require("xiaoqiang.common.XQFunction")

local LED_STATUS_MAP = {
    ["1"] = "led_on",
    ["0"] = "led_off"
}

--[[
  HSL颜色转RGB颜色
  @param h 色相 (0-360)
  @param s 饱和度 (0-100)
  @param l 亮度 (0-100)
  @return RGB颜色表 {r, g, b}
]]--
local function hslToRgb(h, s, l)
    h = h / 60
    s = s / 100
    l = l / 100
    
    local r, g, b
    
    if s == 0 then
        r = l
        g = l
        b = l
    else
        local function hueToRgb(p, q, t)
            if t < 0 then
                t = t + 6
            end
            if t >= 6 then
                t = t - 6
            end
            
            if t < 1 then
                return p + (q - p) * t
            elseif t < 3 then
                return q
            elseif t < 4 then
                return p + (q - p) * (4 - t)
            else
                return p
            end
        end
        
        local q
        if l < 0.5 then
            q = l * (1 + s)
        else
            q = l + s - l * s
        end
        
        local p = 2 * l - q
        
        r = hueToRgb(p, q, h + 2)
        g = hueToRgb(p, q, h)
        b = hueToRgb(p, q, h - 2)
    end
    
    return {
        r = math.floor(r * 255),
        g = math.floor(g * 255),
        b = math.floor(b * 255)
    }
end

--[[
  RGB颜色转HSL颜色
  @param r 红色分量 (0-255)
  @param g 绿色分量 (0-255)
  @param b 蓝色分量 (0-255)
  @return HSL颜色表 {h, s, l}
]]--
local function rgbToHsl(r, g, b)
    r = r / 255
    g = g / 255
    b = b / 255
    
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    
    local h = 0
    local s = 0
    local l = (max + min) / 2
    local d = max - min
    
    if max == min then
        h = 0
    else
        if l > 0.5 then
            s = d / (2 - max - min)
        else
            s = d / (max + min)
        end
        
        if max == r then
            h = (g - b) / d
            if g < b then
                h = h + 6
            end
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        
        h = h / 6
    end
    
    return {
        h = h * 360,
        s = s * 100,
        l = l * 100
    }
end

--[[
  十进制颜色值转RGB
  @param decValue 十进制颜色值
  @return RGB颜色表 {r, g, b}
]]--
local function decToRgb(decValue)
    local bit = require("bit")
    local r, g, b
    
    local value = tonumber(decValue)
    if value then
        r = bit.band(bit.rshift(value, 24), 255)
        g = bit.band(bit.rshift(value, 16), 255)
        b = bit.band(bit.rshift(value, 8), 255)
        
        return {
            r = r,
            g = g,
            b = b
        }
    else
        return nil
    end
end

--[[
  RGB颜色转十进制值
  @param r 红色分量 (0-255)
  @param g 绿色分量 (0-255)
  @param b 蓝色分量 (0-255)
  @return 十进制颜色值
]]--
local function rgbToDec(r, g, b)
    local bit = require("bit")
    local value = 0
    
    value = bit.bor(value, bit.lshift(r, 24))
    value = bit.bor(value, bit.lshift(g, 16))
    value = bit.bor(value, bit.lshift(b, 8))
    
    XQLog.log(5, "rgb2dec: " .. value)
    return value
end

local XLED = {}

--[[
  获取XLED配置
  @return XLED配置表
]]--
function XLED.get_config()
end

--[[
  设置XLED HSL颜色
  @param params 参数表 {val1=H, val2=S, val3=L}
  @return 是否成功
]]--
function XLED.set_hsl(params)
    if params.val1 == "-1" or params.val2 == "-1" or params.val3 == "-1" then
        return false
    end
    
    local hsl = {
        h = tonumber(params.val1) * 3.6,
        s = tonumber(params.val2),
        l = tonumber(params.val3)
    }
    
    if hsl.h < 0 or hsl.h > 360 or
       hsl.s < 0 or hsl.s > 100 or
       hsl.l < 0 or hsl.l > 100 then
        return false
    end
    
    local rgb = hslToRgb(hsl.h, hsl.s, hsl.l)
    
    uci:set("xqled", "custom_ambient_brightness", "value", rgbToDec(rgb.r, rgb.g, rgb.b))
    uci:commit("xqled")
    
    XQFunction.forkExec("xqled update user_defined")
    
    return true
end

--[[
  设置XLED RGB颜色
  @param params 参数表 {val1=R, val2=G, val3=B}
  @return 是否成功
]]--
function XLED.set_rgb(params)
    if params.val1 == "-1" or params.val2 == "-1" or params.val3 == "-1" then
        return false
    end
    
    local rgb = {
        r = tonumber(params.val1),
        g = tonumber(params.val2),
        b = tonumber(params.val3)
    }
    
    if rgb.r < 0 or rgb.r > 255 or
       rgb.g < 0 or rgb.g > 255 or
       rgb.b < 0 or rgb.b > 255 then
        return false
    end
    
    uci:set("xqled", "custom_ambient_brightness", "value", rgbToDec(rgb.r, rgb.g, rgb.b))
    uci:commit("xqled")
    
    XQFunction.forkExec("xqled update user_defined")
    
    return true
end

--[[
  开启XLED
  @return 是否成功
]]--
function XLED.on()
    os.execute("/usr/sbin/led_ctl led_on xled")
    return true
end

--[[
  关闭XLED
  @return 是否成功
]]--
function XLED.off()
    os.execute("/usr/sbin/led_ctl led_off xled")
    return true
end

--[[
  开启XLED事件响应
  @return 是否成功
]]--
function XLED.event_on()
    os.execute("/usr/sbin/led_ctl event_toggle 1")
    return true
end

--[[
  关闭XLED事件响应
  @return 是否成功
]]--
function XLED.event_off()
    os.execute("/usr/sbin/led_ctl event_toggle 0")
    return true
end

--[[
  设置XLED定时器
  @param params 参数表，包含timer子表
  @return 是否成功
]]--
function XLED.timer(params)
    if params.timer then
        if params.timer.status == "1" then
            os.execute("/usr/sbin/led_ctl timer_on " ..
                params.timer.start_h .. " " ..
                params.timer.start_m .. " " ..
                params.timer.stop_h .. " " ..
                params.timer.stop_m .. " xled")
        else
            os.execute("/usr/sbin/led_ctl timer_off xled")
        end
    end
    
    return true
end

local XLED_ACTION_MAP = {
    still_light = "ambient_rgb_light",
    breath = "ambient_rgb_breath",
    flashing = "ambient_rgb_star",
    cycle = "ambient_rgb_cycle",
    rainbow = "ambient_rgb_rainbow"
}

local XLED_ACTION_INDEX = {
    ambient_rgb_light = 0,
    ambient_rgb_breath = 1,
    ambient_rgb_star = 2,
    ambient_rgb_cycle = 3,
    ambient_rgb_rainbow = 4
}

--[[
  解析XLED配置请求
  @param request HTTP请求对象
  @return 配置参数表或nil
]]--
local function analyzeXLEDConfig(request)
    local config = {}
    local timer = {}
    
    config.func = request:formvalue("func")
    config.val1 = request:formvalue("val1")
    config.val2 = request:formvalue("val2")
    config.val3 = request:formvalue("val3")
    
    timer.status = request:formvalue("timer_on")
    timer.start_time = request:formvalue("timer_open")
    timer.stop_time = request:formvalue("timer_close")
    
    if next(timer) then
        config.timer = timer
    end
    
    XQLog.log(5, "[XLED] analyzeXLEDConfig: ", config)
    
    if not XLED_ACTION_MAP[config.func] and not XLED[config.func] then
        return nil
    end
    
    if timer.status and timer.status == "1" then
        if not timer.start_time or not timer.stop_time then
            XQLog.log(1, "analyzeXLEDConfig: need timer_open and timer_close")
            return nil
        end
        
        timer.start_h, timer.start_m = string.match(timer.start_time, "^([0-2][0-9]):([0-5][0-9])$")
        timer.stop_h, timer.stop_m = string.match(timer.stop_time, "^([0-2][0-9]):([0-5][0-9])$")
        
        if not timer.start_h or not timer.start_m or not timer.stop_h or not timer.stop_m then
            XQLog.log(1, "analyzeXLEDConfig: timer_open or timer_close format error")
            return nil
        end
    end
    
    if next(config) then
        return config
    else
        return nil
    end
end

--[[
  获取XLED配置
  @return XLED配置表
]]--
local function getXLEDConfig()
    local config = {}
    
    local colorValue = uci:get("xqled", "custom_ambient_brightness", "value") or "0"
    local rgb = decToRgb(colorValue)
    
    if rgb then
        config.color_R = rgb.r
        config.color_G = rgb.g
        config.color_B = rgb.b
    else
        return nil
    end
    
    local hsl = rgbToHsl(rgb.r, rgb.g, rgb.b)
    if hsl then
        config.color_H = hsl.h / 3.6
        config.color_S = hsl.s
        config.color_L = hsl.l
    else
        return nil
    end
    
    local action = uci:get("xqled", "custom_ambient_action", "value")
    local xledStatus = uci:get("xiaoqiang", "common", "XLED") or "1"
    
    if xledStatus == "0" then
        config.status = 5
    else
        config.status = XLED_ACTION_INDEX[action]
    end
    
    if not config.status then
        return nil
    end
    
    config.event_enable = uci:get("xqled", "handle_event", "value") or "1"
    config.xled_timer_enable = uci:get("xiaoqiang", "common", "XLED_TIMER") or "0"
    config.xled_timer_open = uci:get("xiaoqiang", "common", "XLED_TIMER_OPEN") or ""
    config.xled_timer_close = uci:get("xiaoqiang", "common", "XLED_TIMER_CLOSE") or ""
    config.default_color = uci:get("xqled", "default_color", "value") or ""
    
    XQLog.log(5, "[XLED] getXLEDConfig: ", config)
    
    return config
end

--[[
  设置XLED配置
  @param config 配置参数表
  @return 是否成功
]]--
local function setXLEDConfig(config)
    if not config then
        return false
    end
    
    local success = true
    
    if XLED[config.func] then
        success = XLED[config.func](config)
    else
        uci:set("xqled", "custom_ambient_action", "value", XLED_ACTION_MAP[config.func])
        
        if config.val1 ~= "-1" and config.val2 ~= "-1" and config.val3 ~= "-1" then
            uci:set("xqled", "custom_ambient_brightness", "value",
                rgbToDec(config.val1, config.val2, config.val3))
        end
        
        uci:commit("xqled")
        XQFunction.forkExec("xqled update user_defined")
    end
    
    uci:set("miled", "settings", "action", config.func)
    uci:commit("miled")
    XQFunction.forkExec("miled_ctrl.lua generate")
    
    return success
end

--[[
  解析网口LED配置请求
  @param request HTTP请求对象
  @return 配置参数表
]]--
local function analyzeEthLEDConfig(request)
    local config = {}
    local timer = {}
    
    config.status = request:formvalue("on")
    
    timer.status = request:formvalue("timer_on")
    timer.start_time = request:formvalue("timer_open")
    timer.stop_time = request:formvalue("timer_close")
    
    if next(timer) then
        config.timer = timer
    end
    
    XQLog.log(5, "analyzeEthLEDConfig: ", config)
    
    if timer.status and timer.status == "1" then
        if not timer.start_time or not timer.stop_time then
            XQLog.log(1, "analyzeEthLEDConfig: need timer_open and timer_close")
            return nil
        end
        
        timer.start_h, timer.start_m = string.match(timer.start_time, "^([0-2][0-9]):([0-5][0-9])$")
        timer.stop_h, timer.stop_m = string.match(timer.stop_time, "^([0-2][0-9]):([0-5][0-9])$")
        
        if not timer.start_h or not timer.start_m or not timer.stop_h or not timer.stop_m then
            XQLog.log(1, "analyzeEthLEDConfig: timer_open or timer_close format error")
            return nil
        end
    end
    
    return config
end

--[[
  获取网口LED配置
  @return 网口LED配置表
]]--
local function getEthLEDConfig()
    local config = {}
    
    config.status = uci:get("xiaoqiang", "common", "ETHLED") or "1"
    config.timer_status = uci:get("xiaoqiang", "common", "ETHLED_TIMER") or "0"
    config.timer_open = uci:get("xiaoqiang", "common", "ETHLED_TIMER_OPEN") or ""
    config.timer_close = uci:get("xiaoqiang", "common", "ETHLED_TIMER_CLOSE") or ""
    
    return config
end

--[[
  设置网口LED配置
  @param config 配置参数表
  @return 是否成功
]]--
local function setEthLEDConfig(config)
    if config == nil then
        return false
    end
    
    if not next(config) then
        return true
    end
    
    if not LED_STATUS_MAP[config.status] then
        return false
    end
    
    local currentConfig = getEthLEDConfig()
    
    if config.status ~= currentConfig.status then
        XQFunction.forkExec("/usr/sbin/led_ctl " .. LED_STATUS_MAP[config.status] .. " ethled")
    end
    
    if config.timer then
        if config.timer.status == "1" then
            XQFunction.forkExec("/usr/sbin/led_ctl timer_on " ..
                config.timer.start_h .. " " ..
                config.timer.start_m .. " " ..
                config.timer.stop_h .. " " ..
                config.timer.stop_m .. " ethled")
        else
            XQFunction.forkExec("/usr/sbin/led_ctl timer_off ethled")
        end
    end
    
    return true
end

--[[
  解析全部LED配置请求
  @param request HTTP请求对象
  @return 配置参数表
]]--
local function analyzeAllLEDConfig(request)
    local config = {}
    
    config.status = request:formvalue("on")
    
    XQLog.log(5, "analyzeAllLEDConfig: ", config)
    
    return config
end

--[[
  获取全部LED配置
  @return 全部LED配置表
]]--
local function getAllLEDConfig()
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local features = XQFeatures.FEATURES
    local config = {}
    local totalStatus = 0
    
    if features.apps and features.apps.LED_control then
        local bit = require("bit")
        
        if bit.band(features.apps.LED_control, 1) ~= 0 then
            local blueLed = tonumber(uci:get("xiaoqiang", "common", "BLUE_LED") or "1")
            totalStatus = totalStatus + blueLed
        end
    end
    
    if features.apps and features.apps.LED_control then
        local bit = require("bit")
        
        if bit.band(features.apps.LED_control, 2) ~= 0 then
            local ethLed = tonumber(uci:get("xiaoqiang", "common", "ETHLED") or "1")
            totalStatus = totalStatus + ethLed
        end
    end
    
    if features.apps and features.apps.LED_control then
        local bit = require("bit")
        
        if bit.band(features.apps.LED_control, 4) ~= 0 then
            local xled = tonumber(uci:get("xiaoqiang", "common", "XLED") or "1")
            totalStatus = totalStatus + xled
        end
    end
    
    if totalStatus == 0 then
        config.status = "0"
    else
        config.status = "1"
    end
    
    XQLog.log(5, "getAllLEDConfig: ", config)
    
    return config
end

--[[
  设置全部LED配置
  @param config 配置参数表
  @return 是否成功
]]--
local function setAllLEDConfig(config)
    if config == nil then
        return false
    end
    
    if not next(config) then
        return true
    end
    
    if LED_STATUS_MAP[config.status] == nil then
        return false
    end
    
    XQFunction.forkExec("/usr/sbin/led_ctl " .. LED_STATUS_MAP[config.status])
    XQFunction.forkExec("/usr/sbin/led_ctl " .. LED_STATUS_MAP[config.status] .. " xled")
    XQFunction.forkExec("/usr/sbin/led_ctl " .. LED_STATUS_MAP[config.status] .. " ethled")
    
    return true
end

LEDControl = {
    led = {
        analyzeConfig = function() end,
        getConfig = function() end,
        setConfig = function() end
    },
    xled = {
        analyzeConfig = analyzeXLEDConfig,
        getConfig = getXLEDConfig,
        setConfig = setXLEDConfig
    },
    ethled = {
        analyzeConfig = analyzeEthLEDConfig,
        getConfig = getEthLEDConfig,
        setConfig = setEthLEDConfig
    },
    allled = {
        analyzeConfig = analyzeAllLEDConfig,
        getConfig = getAllLEDConfig,
        setConfig = setAllLEDConfig
    }
}
