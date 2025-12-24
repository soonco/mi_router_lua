--[[
  小米路由器通用函数模块
  
  功能说明:
  - 提供系统级通用工具函数
  - 字符串处理和格式化
  - 进程管理（fork执行）
  - 系统控制（重启、关机、重置）
  - 数据格式转换
  - 命令执行封装
  
  主要函数分类:
  - 字符串处理: macFormat, isStrNil, checkChineseChar, isDomain
  - 进程管理: forkExec, forkExec2, waitExec
  - 系统控制: forkReboot, forkShutdown, forkResetAll, forkRestartWifi
  - 格式转换: hzFormat, byteFormat, utfstrlen
  - 命令格式化: _cmdformat, _strformat, paramFormat
  - 系统锁: sysLock, sysUnlock, sysLockStatus
]]

module("xiaoqiang.common.XQFunction", package.seeall)

local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- ==================== 字符串处理函数 ====================

-- 格式化MAC地址为标准格式 (XX:XX:XX:XX:XX:XX)
-- @param mac 原始MAC地址
-- @return string 格式化后的MAC地址
function macFormat(mac)
    if mac then
        local formatted = string.gsub(string.upper(mac), "-", ":")
        return string.sub(formatted, 1, 17)
    else
        return ""
    end
end

-- 检查字符串是否为空
-- @param str 待检查的字符串
-- @return boolean 是否为空
function isStrNil(str)
    return str == nil or str == ""
end

-- 检查字符串是否包含中文字符
-- @param str 待检查的字符串
-- @return boolean 是否包含中文
function checkChineseChar(str)
    local has_chinese = false
    if str and type(str) == "string" then
        for i = 1, #str do
            local byte = string.byte(str, i)
            if byte > 127 then
                has_chinese = true
                break
            end
        end
    end
    return has_chinese
end

-- 检查是否为有效域名
-- @param domain 待检查的域名
-- @return boolean 是否为有效域名
function isDomain(domain)
    if not domain then
        return false
    end
    if domain:match("^%w[%w%-%.]+%w$") then
        return true
    end
    return false
end

-- 将换行符转换为HTML的<br>标签
-- @param str 原始字符串
-- @return string 转换后的字符串
function parseEnter2br(str)
    if str ~= nil then
        str = str:gsub("\r\n", "<br>")
        str = str:gsub("\r", "<br>")
        str = str:gsub("\n", "<br>")
    end
    return str
end

-- ==================== 进程管理函数 ====================

-- 异步执行命令（fork方式）
-- @param cmd 要执行的命令
function forkExec(cmd)
    local nixio = require("nixio")
    local pid = nixio.fork()
    
    if pid > 0 then
        -- 父进程直接返回
        return
    elseif pid == 0 then
        -- 子进程
        nixio.chdir("/")
        
        -- 重定向标准输入输出到/dev/null
        local null = nixio.open("/dev/null", "w+")
        if null then
            nixio.dup(null, nixio.stderr)
            nixio.dup(null, nixio.stdout)
            nixio.dup(null, nixio.stdin)
            if null:fileno() > 2 then
                null:close()
            end
        end
        
        -- 执行命令
        nixio.exec("/bin/sh", "-c", cmd)
    end
end

-- 异步执行命令（带参数）
-- @param cmd 要执行的命令
-- @param ... 命令参数
-- @return number 子进程PID
function forkExec2(cmd, ...)
    local nixio = require("nixio")
    local pid = nixio.fork()
    
    if pid > 0 then
        return pid
    elseif pid == 0 then
        nixio.chdir("/")
        
        local null = nixio.open("/dev/null", "w+")
        if null then
            nixio.dup(null, nixio.stderr)
            nixio.dup(null, nixio.stdout)
            nixio.dup(null, nixio.stdin)
            if null:fileno() > 2 then
                null:close()
            end
        end
        
        nixio.execp(cmd, unpack(arg))
    end
end

-- 同步执行命令并等待结果
-- @param cmd 要执行的命令
-- @param ... 命令参数
-- @return string, number, string 状态、退出码、输出
function waitExec(cmd, ...)
    local nixio = require("nixio")
    
    -- 创建管道
    local rd, wr = assert(nixio.pipe())
    local pid = assert(nixio.fork())
    
    if pid == 0 then
        -- 子进程
        nixio.dup(wr, nixio.stdout)
        rd:close()
        wr:close()
        
        local null = nixio.open("/dev/null", "w+")
        if null then
            nixio.dup(null, nixio.stdin)
            nixio.dup(null, nixio.stderr)
            null:close()
        end
        
        nixio.chdir("/")
        nixio.execp(cmd, unpack(arg))
        os.exit(-1)
    end
    
    -- 父进程
    wr:close()
    
    -- 等待子进程结束
    local status, exit_code = nixio.waitpid(pid)
    
    -- 读取输出
    local output_file = assert(io.open("/proc/self/fd/" .. rd:fileno(), "r"))
    rd:close()
    local output = output_file:read("*all")
    output_file:close()
    
    return status, exit_code, output
end

-- 打印表结构（调试用）
-- @param tbl 要打印的表
function doPrint(tbl)
    if type(tbl) == "table" then
        for k, v in pairs(tbl) do
            if type(v) == "table" then
                print("<" .. k .. ": ")
                doPrint(v)
                print(">")
            else
                print("[" .. k .. " : " .. tostring(v) .. "]")
            end
        end
    else
        print(tbl)
    end
end

-- ==================== 系统控制函数 ====================

-- 异步重启WiFi
-- @param extra_cmd 额外执行的命令（可选）
function forkRestartWifi(extra_cmd)
    if extra_cmd then
        forkExec(XQConfigs.FORK_RESTART_WIFI .. ";" .. extra_cmd)
    else
        forkExec(XQConfigs.FORK_RESTART_WIFI)
    end
end

-- 异步重启WiFi并通知设备
function forkRestartWifiNotify()
    forkExec(XQConfigs.FORK_RESTART_WIFI_NOTIFY_BUT_MIIO)
end

-- 异步重启WiFi并通知设备（不通知MIIO）
function forkRestartWifiNotifyButMiio()
    forkExec(XQConfigs.FORK_RESTART_WIFI_NOTIFY_BUT_MIIO)
end

-- 异步重启路由器
function forkReboot()
    local uci = require("luci.model.uci").cursor()
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    -- CPE设备需要先提交mobile配置
    if FEATURES.system and FEATURES.system.cpe == "1" then
        uci:commit("mobile")
    end
    
    forkExec(XQConfigs.FORK_RESTART_ROUTER)
end

-- 异步关机
function forkShutdown()
    forkExec(XQConfigs.FORK_SHUTDOWN_ROUTER)
end

-- 异步恢复出厂设置
function forkResetAll()
    forkExec(XQConfigs.FORK_RESET_ALL)
end

-- 异步重启DNS服务
function forkRestartDnsmasq()
    forkExec(XQConfigs.FORK_RESTART_DNSMASQ)
end

-- 异步刷写ROM文件
-- @param filepath ROM文件路径
function forkFlashRomFile(filepath)
    forkExec("flash.sh " .. filepath)
end

-- 延时关机并重启
-- @param shutdown_delay 关机延时（分钟）
-- @param reboot_delay 重启延时（秒）
function forkShutdownAndRebootWithDelay(shutdown_delay, reboot_delay)
    shutdown_delay = tonumber(shutdown_delay)
    reboot_delay = tonumber(reboot_delay)
    
    if shutdown_delay and reboot_delay and (shutdown_delay ~= 0 or reboot_delay ~= 0) then
        local cmd = nil
        
        if shutdown_delay > 0 and reboot_delay > 0 then
            cmd = string.format("sleep %s ; /usr/sbin/uhbn 2 %s",
                tostring(60 * shutdown_delay), tostring(reboot_delay))
        elseif shutdown_delay == 0 and reboot_delay > 0 then
            cmd = string.format("sleep 4 ; /usr/sbin/uhbn 2 %s", tostring(reboot_delay))
        elseif shutdown_delay > 0 and reboot_delay == 0 then
            cmd = string.format("sleep %s ; /usr/sbin/uhbn 3", tostring(60 * shutdown_delay))
        end
        
        if cmd then
            forkExec(cmd)
        end
    end
end

-- 同步重启MAC过滤
function syncRestartMacFilter()
    os.execute(XQConfigs.RESTART_MAC_FILTER)
end

-- 关闭Web初始化重定向
function closeWebInitRDR()
    os.execute("/usr/sbin/sysapi webinitrdr set off")
end

-- ==================== 时间和格式化函数 ====================

-- 获取当前时间字符串
-- @return string 格式化的时间字符串
function getTime()
    return os.date("%Y-%m-%d--%X", os.time())
end

-- 格式化频率（Hz）
-- @param hz 频率值（Hz）
-- @return string 格式化后的频率字符串
function hzFormat(hz)
    local units = {"Hz", "KHz", "MHz", "GHz", "THz"}
    
    for i = 1, 5 do
        if hz > 1024 and i < 5 then
            hz = hz / 1024
        else
            return string.format("%.2f %s", hz, units[i])
        end
    end
end

-- 格式化字节数
-- @param bytes 字节数
-- @return string 格式化后的字节字符串
function byteFormat(bytes)
    local units = {"B", "KB", "MB", "GB", "TB"}
    
    for i = 1, 5 do
        if bytes > 1024 and i < 5 then
            bytes = bytes / 1024
        else
            return string.format("%.2f %s", bytes, units[i])
        end
    end
end

-- 计算UTF-8字符串长度
-- @param str UTF-8字符串
-- @return number 字符数
function utfstrlen(str)
    local len = #str
    local pos = len
    local count = 0
    
    -- UTF-8字节头部标识
    local utf8_headers = {0, 192, 224, 240, 248, 252}
    
    while pos ~= 0 do
        local byte = string.byte(str, pos)
        local header_idx = #utf8_headers
        
        while true do
            local header = utf8_headers[header_idx]
            if not header then
                break
            end
            if byte >= header then
                pos = pos - header_idx
                break
            end
            header_idx = header_idx - 1
        end
        
        count = count + 1
    end
    
    return count
end

-- 检查SSID是否有效
-- @param ssid WiFi SSID
-- @return boolean 是否有效
function checkSSID(ssid)
    return true
end

-- 获取WiFi CAC时间
-- @param mode 模式 ("cfg_file" 或其他)
-- @param iface 接口名
-- @param channel 信道
-- @param bandwidth 带宽
-- @return number CAC时间（秒）
function get_cac_time(mode, iface, channel, bandwidth)
    local luci_util = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local wlan_count = XQWifiUtil.get_wlan_count()
    local max_cac_time = 0
    local cmd = ""
    
    if mode == "cfg_file" then
        -- 从配置文件读取5G接口设置
        local if_5g = uci:get("misc", "wireless", "if_5G")
        local ch_5g = uci:get("wireless", if_5g, "channel")
        local bw_5g = uci:get("wireless", if_5g, "bw")
        
        cmd = "/sbin/wifi get_cac_time " .. if_5g .. " " .. ch_5g .. " " .. bw_5g .. " 2>/dev/null"
        local result = io.popen(cmd)
        local output = string.trim(result:read("*all") or "")
        result:close()
        
        local cac_time = tonumber(luci_util.trim(output))
        if cac_time and cac_time > max_cac_time then
            max_cac_time = cac_time
        end
        
        -- 三频路由器检查5G高频
        if wlan_count >= 3 then
            local if_5gh = uci:get("misc", "wireless", "if_5GH")
            local ch_5gh = uci:get("wireless", if_5gh, "channel")
            local bw_5gh = uci:get("wireless", if_5gh, "bw")
            
            cmd = "/sbin/wifi get_cac_time " .. if_5gh .. " " .. ch_5gh .. " " .. bw_5gh .. " 2>/dev/null"
            result = io.popen(cmd)
            output = string.trim(result:read("*all") or "")
            result:close()
            
            cac_time = tonumber(luci_util.trim(output))
            if cac_time and cac_time > max_cac_time then
                max_cac_time = cac_time
            end
        end
    else
        -- 使用传入的参数
        local cur_channel = uci:get("wireless", iface, "channel")
        local cur_bw = uci:get("wireless", iface, "bw")
        
        if isStrNil(channel) then
            channel = cur_channel
        end
        if isStrNil(bandwidth) then
            bandwidth = cur_bw
        end
        
        cmd = "/sbin/wifi get_cac_time " .. iface .. " " .. channel .. " " .. bandwidth .. " 2>/dev/null"
        local result = io.popen(cmd)
        local output = string.trim(result:read("*all") or "")
        result:close()
        
        local cac_time = tonumber(luci_util.trim(output))
        if cac_time and cac_time > max_cac_time then
            max_cac_time = cac_time
        end
    end
    
    return max_cac_time
end

-- ==================== 系统锁函数 ====================

-- 获取系统锁
function sysLock()
    return os.execute(XQConfigs.UPGRADE_LOCK)
end

-- 释放系统锁
function sysUnlock()
    return os.execute(XQConfigs.UPGRADE_UNLOCK)
end

-- 检查系统锁状态
-- @return number 1=已锁定, 0=未锁定
function sysLockStatus()
    local fs = require("luci.fs")
    if fs.access(XQConfigs.UPGRADE_LOCK_FILE) then
        return 1
    else
        return 0
    end
end

-- LED闪烁提醒控制
-- @param enable 是否启用
function ledFlashAlert(enable)
    if enable then
        forkExec(XQConfigs.UPDATE_LED_FLASH_ALERT_ENABLE)
    else
        os.execute(XQConfigs.UPDATE_LED_FLASH_ALERT_DISABLE)
    end
end

-- 获取GPIO值
-- @param gpio GPIO编号
-- @return number GPIO值
function getGpioValue(gpio)
    local luci_util = require("luci.util")
    local result = luci_util.exec(string.format(XQConfigs.GPIO_VALUE, tostring(gpio)))
    
    if result then
        return tonumber(luci_util.trim(result)) or 0
    end
    return 0
end

-- ==================== 命令格式化函数 ====================

-- 格式化命令行参数（转义特殊字符）
-- @param str 原始字符串
-- @return string 转义后的字符串
function _cmdformat(str)
    if isStrNil(str) then
        return ""
    end
    
    str = str:gsub("\\", "\\\\")
    str = str:gsub("`", "\\`")
    str = str:gsub("\"", "\\\"")
    str = str:gsub("%$", "\\$")
    
    return str
end

-- 格式化字符串（移除单引号并转义）
-- @param str 原始字符串
-- @return string 格式化后的字符串
function _strformat(str)
    if isStrNil(str) then
        return ""
    end
    
    str = str:gsub("'", "")
    str = str:gsub("\\", "\\\\")
    str = str:gsub("`", "\\`")
    str = str:gsub("\"", "\\\"")
    str = str:gsub("%$", "\\$")
    
    return str
end

-- 格式化参数（转义特殊字符）
-- @param str 原始字符串
-- @return string 转义后的字符串
function paramFormat(str)
    if isStrNil(str) then
        return ""
    end
    
    str = str:gsub("\\", "\\\\")
    str = str:gsub("`", "\\`")
    str = str:gsub("\"", "\\\"")
    str = str:gsub("%$", "\\$")
    
    return str
end

-- 从bdata获取值
-- @param key 键名
-- @param default 默认值
-- @return string 获取的值
function getBdataValue(key, default)
    if isStrNil(key) then
        return default
    end
    
    local luci_util = require("luci.util")
    local cmd = string.format("bdata get \"%s\"", _cmdformat(key))
    local result = luci_util.exec(cmd)
    
    if result then
        return luci_util.trim(result)
    end
    return default
end

-- 从nvram获取值
-- @param key 键名
-- @param default 默认值
-- @return string 获取的值
function getNvramValue(key, default)
    if isStrNil(key) then
        return default
    end
    
    local luci_util = require("luci.util")
    local cmd = string.format("nvram get \"%s\"", _cmdformat(key))
    local result = luci_util.exec(cmd)
    
    if result then
        return luci_util.trim(result)
    end
    return default
end

-- 设置nvram值
-- @param key 键名
-- @param value 值
function setNvramValue(key, value)
    if isStrNil(key) then
        return
    end
    
    local cmd = string.format("nvram set %s=\"%s\"", _cmdformat(key), _cmdformat(value or ""))
    os.execute(cmd)
end

-- 提交nvram更改
function nvramCommit()
    os.execute("nvram commit")
end
