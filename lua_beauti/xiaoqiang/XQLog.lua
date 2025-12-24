--[[
  小米路由器日志模块
  
  功能说明:
  - 提供系统日志记录功能
  - 支持不同日志级别
  - 支持统计打点功能
  - 定义各种统计键名常量
  
  日志级别 (syslog标准):
  - 0: LOG_EMERG (紧急)
  - 1: LOG_ALERT (警报)
  - 2: LOG_CRIT (严重)
  - 3: LOG_ERR (错误)
  - 4: LOG_WARNING (警告)
  - 5: LOG_NOTICE (通知)
  - 6: LOG_INFO (信息)
  - 7: LOG_DEBUG (调试)
  
  使用示例:
  local XQLog = require("xiaoqiang.XQLog")
  XQLog.log(6, "This is an info message", some_data)
  XQLog.check(0, "function_qos", 1)
]]

module("xiaoqiang.XQLog", package.seeall)

local posix = require("posix")
local uci = require("luci.model.uci")

-- 执行命令并返回第一行结果
-- @param cmd 要执行的命令
-- @return string 命令输出的第一行
local function run_cmd(cmd)
    if not cmd or cmd == "" then
        return nil
    end
    
    local handle = io.popen(cmd)
    local result = handle:read("*line")
    handle:close()
    
    return result
end

-- 记录日志
-- @param level 日志级别 (0-7)
-- @param ... 日志内容（可以是多个参数）
function log(level, ...)
    local log_level = arg[1]
    
    -- 获取配置的调试级别
    local debug_level = run_cmd("uci -q get luci.debuglevel")
    debug_level = debug_level or debug_level
    
    if log_level then
        local level_num = tonumber(log_level)
        
        if level_num and level_num >= 0 and level_num <= tonumber(debug_level) then
            local json = require("json")
            
            -- 打开syslog
            posix.openlog("luci", posix.LOG_NDELAY, posix.LOG_USER)
            
            -- 记录所有参数
            for i = 2, #arg do
                local data = json.serialize_data(arg[i])
                posix.syslog(log_level, data)
            end
            
            -- 关闭syslog
            posix.closelog()
        end
    end
end

-- ==================== 统计打点键名常量 ====================

-- 基础统计
KEY_GEL_USE = "gel_use"                              -- 凝胶使用
KEY_REBOOT = "gel_restart_soft_count"                -- 软重启次数

-- 网络检测
KEY_DETECT_ERROR = "network_detect_error"            -- 网络检测错误

-- 网络连接方式
KEY_VALUE_NETWORK_PPPOE = "network_method_pppoe"     -- PPPoE拨号
KEY_VALUE_NETWORK_DHCP = "network_method_dhcp"       -- DHCP自动获取
KEY_VALUE_NETWORK_STATIC = "network_method_static"   -- 静态IP
KEY_VALUE_NETWORK_VPN = "network_method_vpn"         -- VPN连接

-- 初始化来源
KEY_GEL_INIT_ANDROID = "gel_init_android"            -- Android初始化
KEY_GEL_INIT_IOS = "gel_init_ios"                    -- iOS初始化
KEY_GEL_INIT_OTHER = "gel_init_other"                -- 其他方式初始化
KEY_GEL_INIT_APP = "gel_init_app"                    -- App初始化

-- 硬盘休眠
KEY_DISKSLEEP_OPEN = "disk_sleep_open"               -- 开启硬盘休眠
KEY_DISKSLEEP_CLOSE = "disk_sleep_close"             -- 关闭硬盘休眠

-- 功能使用统计
KEY_FUNC_PPTP = "function_pptp_web"                  -- PPTP VPN功能
KEY_FUNC_L2TP = "function_l2tp_web"                  -- L2TP VPN功能
KEY_FUNC_APPQOS = "function_appqos"                  -- 应用QoS功能
KEY_FUNC_MACCLONE = "function_clone"                 -- MAC克隆功能
KEY_FUNC_QOS = "function_qos"                        -- QoS功能
KEY_FUNC_UPNP = "function_upnp"                      -- UPnP功能
KEY_FUNC_DMZ = "function_dmz"                        -- DMZ功能
KEY_FUNC_FIREWALL = "function_firewall"              -- 防火墙功能
KEY_FUNC_PLUGIN = "function_plugin"                  -- 插件功能

-- 端口转发
KEY_FUNC_PORTFADD = "function_port_forwarding_add"   -- 添加端口转发
KEY_FUNC_RANGEFADD = "function_range_forwarding_add" -- 添加端口范围转发
KEY_FUNC_PORTENABLE = "function_port_forwarding_active" -- 启用端口转发

-- 无线访问控制
KEY_FUNC_WIRELESS_ACCESS = "function_wireless_access"           -- 无线访问控制
KEY_FUNC_WIRELESS_BLACK = "function_wireless_access_blacklist"  -- 无线黑名单
KEY_FUNC_WIRELESS_WHITE = "function_wireless_access_whitelist"  -- 无线白名单

-- WiFi信道和信号
KEY_FUNC_2G_CHANNEL = "function_channel_2g"          -- 2.4G信道设置
KEY_FUNC_5G_CHANNEL = "function_channel_5g"          -- 5G信道设置
KEY_FUNC_2G_SIGNAL = "function_channel_2g_signal"    -- 2.4G信号强度
KEY_FUNC_5G_SIGNAL = "function_channel_5g_signal"    -- 5G信号强度

-- 其他功能
KEY_FUNC_NOFLUSHED = "function_hdd_hibernation"      -- 硬盘休眠
KEY_FUNC_WIFI_RELAY = "function_relay"               -- WiFi中继
KEY_FUNC_WIFI_BSD = "function_wifi_bsd"              -- WiFi双频合一

-- 统计打点记录
-- @param mode 模式 (0=无统计, 其他=即时统计)
-- @param key 统计键名
-- @param value 统计值
function check(mode, key, value)
    local log_type
    
    if mode == 0 then
        log_type = "stat_points_none"
    else
        log_type = "stat_points_instant"
    end
    
    -- 打开syslog
    posix.openlog("luci", posix.LOG_NDELAY, posix.LOG_USER)
    
    -- 记录统计信息
    local message = log_type .. " " .. key .. "=" .. tostring(value)
    posix.syslog(6, message)
    
    -- 关闭syslog
    posix.closelog()
end
