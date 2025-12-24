--[[
  小米路由器 MiQoS 公共模块
  
  功能说明:
  - 提供 QoS 系统的核心公共函数
  - 配置管理 (UCI配置读写)
  - TC (Traffic Control) 命令生成
  - 系统清理和初始化
  - 日志记录
  
  全局变量:
  - cfg: 全局配置表
  - qdisc: 队列规则处理器表
  - g_limit: 限速状态表
  - g_group_def: 分组定义表
]]

local nixio_fs = require("nixio.fs")
local ubus = require("ubus")
local uci = require("luci.model.uci")
util = require("luci.util")
px = require("posix")
local nixio = require("nixio")

local CONFIG_PATH = "/etc/config/"
local TMP_CONFIG_PATH = "/tmp/etc/config/"
local MIQOS_CONFIG_FILE = CONFIG_PATH .. "miqos"
local MIQOS_TMP_CONFIG_FILE = TMP_CONFIG_PATH .. "miqos"

cfg = {
    server = {
        path = "/var/run/miqosd.sock"
    },
    idle_timeout = {
        wire = 301,
        wireless = 10
    },
    check_interval = 20,
    clean_counters = 0,
    lan = {
        ip = "",
        mask = ""
    },
    DEVS = {
        UP = {
            dev = "",
            id = "2"
        },
        DOWN = {
            dev = "br-lan",
            id = "1"
        }
    },
    guest = {
        changed = 0,
        UP = 0.6,
        DOWN = 0.6,
        inner = {
            UP = 0,
            DOWN = 0
        },
        default = 0.6
    },
    xq = {
        changed = 0,
        UP = 0.9,
        DOWN = 0.9,
        inner = {
            UP = 0,
            DOWN = 0
        },
        default = 0.9
    },
    enabled = {
        started = true,
        changed = false,
        flag = false
    },
    group = {
        changed = false,
        tab = g_group_def,
        default = "00",
        min_default = 0.5
    },
    flow = {
        changed = false,
        seq = "",
        dft = "auto"
    },
    qdisc = {
        old = nil,
        cur = nil
    },
    bands = {
        UP = 0,
        DOWN = 0,
        changed = true
    },
    qos_type = {
        changed = false,
        mode = "service"
    },
    quan = 1600,
    virtual_proto = "ip",
    supress_host = {
        changed = false,
        enabled = false
    },
    wangzhe = {
        changed = false,
        modeon = false,
        plugon = false,
        bandchanged = false,
        cleanother = false,
        cleanflag = false,
        bands = {
            UP = 1024000,
            DOWN = 1024000
        },
        devbands = {
            UP = 5000,
            DOWN = 5000
        },
        iplist = {}
    }
}

seq_prio = {
    auto = { game = 2, web = 3, video = 4, download = 5 },
    game = { game = 2, web = 3, video = 4, download = 5 },
    web = { web = 2, game = 3, video = 4, download = 5 },
    video = { video = 2, game = 3, web = 4, download = 5 }
}

UNIT = "kbit"
UP = "UP"
DOWN = "DOWN"

const_ipt_mangle = "iptables -t mangle "
const_ipt_clear = "iptables -t mangle -F "
const_ipt_delete = "iptables -t mangle -X "
const_tc_qdisc = "tc qdisc"
const_tc_class = "tc class"
const_tc_filter = "tc filter"

qdisc = {}
old_qdisc = ""
cur_qdisc = ""

g_debug = false
g_CONFIG_HZ = 100
g_htb_buffer_factor = 1.5
g_htb_buffer_data = 128 / g_CONFIG_HZ
g_min_burst = 1600
g_supress_host = false

px.openlog("miqos", LOG_NDELAY, LOG_USER)

-- 日志记录函数
-- @param level 日志级别
-- @param message 日志消息
function logger(level, message)
    px.syslog(level, message)
end

const_lockfile = "/tmp/miqos.lock"
g_lockfile = nil

-- 执行命令并返回第一行输出
-- @param cmd 要执行的命令
-- @return 命令输出的第一行
function run_cmd(cmd)
    if not cmd or cmd == "" then
        return nil
    end
    
    local handle = io.popen(cmd)
    local result = handle:read("*line")
    handle:close()
    
    return result
end

-- 获取当前 WAN 接口名称
-- @return WAN接口名称
function get_cur_wan_sec()
    local wan_name = run_cmd("/usr/sbin/mwan3 curr_wan ipv4")
    if not wan_name or wan_name == "" then
        return "wan"
    end
    return wan_name
end

-- 获取 WAN 接口协议类型
-- @return 协议类型 (dhcp/static/pppoe等)
function get_wan_proto()
    local wan_sec = get_cur_wan_sec()
    return run_cmd("uci -q get network." .. wan_sec .. ".proto")
end

-- 读取网络接口设备名
-- @param iface 接口名称 (lan/wan)
-- @return 设备名称
function read_interfaces(iface)
    if iface == "lan" then
        return "br-lan"
    elseif iface == "wan" then
        local model = run_cmd("uci -q get misc.hardware.model") or ""
        if model == "D01" then
            return "eth0"
        end
        
        local wan_sec = get_cur_wan_sec()
        return run_cmd("uci -q get network." .. wan_sec .. ".ifname")
    end
    
    return ""
end

-- 获取文件锁
-- @return 是否成功获取锁
function lock()
    if not g_lockfile then
        g_lockfile = nixio.open(const_lockfile, "w")
    end
    
    local success = g_lockfile:lock("tlock")
    if not success then
        logger(3, "Note: try to get lock failed .")
        return false
    end
    
    return true
end

-- 释放文件锁
-- @return 总是返回 true
function unlock()
    if g_lockfile then
        g_lockfile:lock("ulock")
        g_lockfile:close()
        g_lockfile = nil
    end
    return true
end

g_ubus = ubus.connect()

-- 复制配置文件到临时目录
-- @return 是否成功
function cfg2tmp()
    if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
        return true
    end
    
    local success, code, msg = nixio_fs.mkdirr(TMP_CONFIG_PATH)
    if not success then
        logger(3, "fatal error: mkdir failed, code:" .. code .. ",msg:" .. msg)
        return nil
    end
    
    success, code, msg = nixio_fs.copy(MIQOS_CONFIG_FILE, MIQOS_TMP_CONFIG_FILE)
    if not success then
        logger(3, "fatal error: copy cfg file 2 /tmp memory failed. code:" .. code .. ",msg:" .. msg)
        return nil
    end
    
    return true
end

-- 十进制转十六进制字符串
-- @param num 十进制数
-- @return 十六进制字符串
function dec2hexstr(num)
    return string.format("%x", num)
end

-- 从临时目录复制配置文件回永久存储
-- @return 是否成功
function tmp2cfg()
    if QOS_VER == "FIX" or QOS_VER == "NOIFB" then
        return true
    end
    
    local success = nixio_fs.copy(MIQOS_TMP_CONFIG_FILE, MIQOS_CONFIG_FILE)
    if not success then
        logger(3, "fatal error: copy /tmp cfg file 2 /etc/config/ failed. exit.")
        return nil
    end
    
    os.execute("/bin/sync")
    return true
end

-- 深拷贝表
-- @param src 源表
-- @return 拷贝后的新表
function copytab(src)
    local result = {}
    if not src then
        return result
    end
    
    for key, value in pairs(src) do
        if type(value) ~= "table" then
            result[key] = value
        else
            result[key] = copytab(value)
        end
    end
    
    return result
end

-- 获取配置值 (带默认值)
-- @param config 配置名
-- @param section 节名
-- @param option 选项名
-- @param default 默认值
-- @return 配置值
function get_conf_std(config, section, option, default)
    local cursor = uci.cursor()
    local success, value = pcall(function()
        return cursor:get(config, section, option)
    end)
    
    if not value then
        return default
    end
    return value
end

-- 获取 UCI 游标对象
-- @return UCI游标
function get_cursor()
    local cursor = uci.cursor()
    
    if QOS_VER ~= "FIX" and QOS_VER ~= "NOIFB" then
        cursor:set_confdir(TMP_CONFIG_PATH)
    end
    
    return cursor
end

-- 获取配置表
-- @param config 配置名
-- @param section_type 节类型
-- @return 配置表
function get_tbls(config, section_type)
    local result = {}
    local cursor = get_cursor()
    
    local success = pcall(function()
        cursor:foreach(config, section_type, function(section)
            result[section.name] = section
        end)
    end)
    
    if not result then
        return {}
    end
    
    return result
end

-- 通过 ubus 获取网络接口状态
-- @param interface 接口名称
-- @return IP地址, 子网掩码
local function get_interface_status(interface)
    local status = g_ubus:call("network.interface", "status", { interface = interface })
    
    if status then
        local ipv4_count = table.getn(status["ipv4-address"])
        if ipv4_count > 0 then
            local addr_info = table.remove(status["ipv4-address"])
            return addr_info.address, addr_info.mask
        end
    end
    
    return nil
end

-- 读取网络配置
-- @return 是否成功
function read_network_conf()
    local lan_ip, lan_mask = get_interface_status("lan")
    cfg.lan.ip = lan_ip
    cfg.lan.mask = lan_mask
    
    if QOS_VER == "HWQOS" then
        return true
    end
    
    local wan_proto = get_wan_proto()
    
    if QOS_VER == "STD" then
        if wan_proto == "dhcp" or wan_proto == "static" then
            cfg.DEVS.UP.dev = read_interfaces("wan")
            cfg.virtual_proto = "ip"
        elseif wan_proto == "pppoe" then
            cfg.DEVS.UP.dev = "pppoe-wan"
            cfg.virtual_proto = "pppoe"
        else
            logger(3, "unsupported wan proto: " .. (wan_proto or "nil"))
            return false
        end
    else
        cfg.DEVS.UP.dev = read_interfaces("wan")
        if wan_proto == "pppoe" then
            cfg.virtual_proto = "pppoe"
        else
            cfg.virtual_proto = "ip"
        end
    end
    
    if QOS_VER == "NOIFB" then
        cfg.DEVS.DOWN.dev = "br-lan"
    end
    
    for _, dev_info in pairs(cfg.DEVS) do
        local link_status = util.exec("ip link 2>&-|grep UP|grep " .. dev_info.dev)
        if link_status == "" then
            logger(3, "DEV " .. dev_info.dev .. " is not UP. exit. ")
            return false
        end
    end
    
    return true
end

-- 读取 QoS 配置
-- @return 是否成功
function read_qos_config()
    if QOS_VER ~= "FIX" then
        if not cfg.enabled.started then
            if g_debug then
                logger(3, "qos stopped, no action.")
            end
            return false
        end
    end
    
    local config_tables = get_tbls("miqos", "miqos")
    
    local enabled = config_tables.settings.enabled or "0"
    if cfg.enabled.flag ~= enabled then
        cfg.enabled.flag = enabled
        cfg.enabled.changed = true
    end
    
    local qos_auto = config_tables.settings.qos_auto or "auto"
    if cfg.qos_type.mode ~= qos_auto then
        cfg.qos_type.mode = qos_auto
        cfg.qos_type.changed = true
    else
        cfg.qos_type.changed = false
    end
    
    local system_tables = get_tbls("miqos", "system")
    local seq_prio_value = system_tables.param.seq_prio or ""
    
    if cfg.flow.seq ~= seq_prio_value then
        cfg.flow.seq = seq_prio_value
        if cfg.flow.seq == "" then
            cfg.flow.seq = cfg.flow.dft
        end
        cfg.flow.changed = true
    end
    
    local upload = config_tables.settings.upload or "0"
    local download = config_tables.settings.download or "0"
    
    if cfg.bands.UP ~= upload or cfg.bands.DOWN ~= download then
        cfg.bands.UP = upload
        cfg.bands.DOWN = download
        cfg.bands.changed = true
    else
        cfg.bands.changed = false
    end
    
    if tonumber(cfg.bands.UP) <= 0 or tonumber(cfg.bands.DOWN) <= 0 then
        cfg.clean_counters = cfg.clean_counters + 1
        if g_debug then
            logger(3, "bands zero clean counters: " .. cfg.clean_counters)
        end
        
        if cfg.clean_counters < 3 then
            if g_debug then
                logger(3, "bands zero clean system ")
            end
            cleanup_system()
        end
        return false
    end
    
    if tonumber(cfg.bands.DOWN) < 8000 then
        cfg.bands.UP = "0"
        cfg.bands.DOWN = "0"
        update_bw("0", "0")
        cleanup_system()
        return false
    end
    
    if QOS_VER == "HWQOS" then
        cfg.qdisc.cur = "service"
    else
        if cfg.enabled.flag == "0" then
            cfg.qdisc.cur = "prio"
        else
            cfg.qdisc.cur = "service"
        end
    end
    
    if QOS_VER == "FIX" then
        cur_qdisc = "service"
        cfg.qdisc.cur = "service"
    elseif QOS_VER == "NOIFB" then
        cur_qdisc = "noifb"
        cfg.qdisc.cur = "noifb"
    else
        old_qdisc = cfg.qdisc.old
        cur_qdisc = cfg.qdisc.cur
    end
    
    if qdisc[cur_qdisc] and qdisc[cur_qdisc].read_qos_config then
        qdisc[cur_qdisc].read_qos_config()
    end
    
    return true
end

-- 读取 QoS 分组配置
-- @return 分组配置表
function read_qos_group_config()
    local group_tables = get_tbls("miqos", "group")
    
    g_group_def = {}
    g_group_def["00"] = {
        min_grp_uplink = cfg.group.min_default,
        min_grp_downlink = cfg.group.min_default
    }
    
    local qos_mode = cfg.qos_type.mode
    
    if QOS_VER == "FIX" or QOS_VER == "HWQOS" or QOS_VER == "NOIFB" then
        for name, group in pairs(group_tables) do
            if name ~= cfg.group.default then
                if not group.flag then
                    local max_up = tonumber(g_group_def[name].max_grp_uplink or 0)
                    local max_down = tonumber(g_group_def[name].max_grp_downlink or 0)
                    if max_up <= 0 and max_down <= 0 then
                        g_group_def[name].flag = "off"
                    end
                elseif group.flag == "off" then
                    g_group_def[name].max_grp_uplink = 0
                    g_group_def[name].max_grp_downlink = 0
                end
            end
        end
        return g_group_def
    end
    
    if qos_mode == "auto" then
        for name, group in pairs(group_tables) do
            if name ~= cfg.group.default then
                g_group_def[name] = nil
            else
                g_group_def[name].min_grp_uplink = cfg.group.min_default
                g_group_def[name].min_grp_downlink = cfg.group.min_default
            end
        end
    elseif qos_mode == "min" then
        for name, group in pairs(group_tables) do
            if name ~= cfg.group.default then
                g_group_def[name].max_grp_uplink = 0
                g_group_def[name].max_grp_downlink = 0
            end
            if g_group_def[name].min_grp_uplink == 0 then
                g_group_def[name].min_grp_uplink = cfg.group.min_default
            end
            if g_group_def[name].min_grp_downlink == 0 then
                g_group_def[name].min_grp_downlink = cfg.group.min_default
            end
        end
    elseif qos_mode == "max" then
        for name, group in pairs(group_tables) do
            if name ~= cfg.group.default then
                g_group_def[name].min_grp_uplink = 0
                g_group_def[name].min_grp_downlink = 0
            end
            if g_group_def[name].min_grp_uplink == 0 then
                g_group_def[name].min_grp_uplink = cfg.group.min_default
            end
            if g_group_def[name].min_grp_downlink == 0 then
                g_group_def[name].min_grp_downlink = cfg.group.min_default
            end
        end
    elseif qos_mode == "both" then
        -- both模式保持原样
    elseif qos_mode == "service" then
        for name, group in pairs(group_tables) do
            if name ~= cfg.group.default then
                if not group.flag then
                    local max_up = tonumber(g_group_def[name].max_grp_uplink or 0)
                    local max_down = tonumber(g_group_def[name].max_grp_downlink or 0)
                    if max_up <= 0 and max_down <= 0 then
                        g_group_def[name].flag = "off"
                    end
                elseif group.flag == "off" then
                    g_group_def[name].max_grp_uplink = 0
                    g_group_def[name].max_grp_downlink = 0
                end
            end
        end
    else
        logger(3, "unknown qos mode: " .. qos_mode)
        return g_group_def
    end
    
    return g_group_def
end

-- 读取访客网络和小米设备限速配置
-- @param is_guest 是否为访客网络配置
-- @return 配置表
function read_qos_guest_xq_config(is_guest)
    local directions = { "UP", "DOWN" }
    local config_type = is_guest and "guest" or "xq"
    
    if is_guest then
        for _, dir in ipairs(directions) do
            local inner_value = tonumber(cfg[config_type].inner[dir])
            if inner_value <= 0 then
                cfg[config_type][dir] = tonumber(cfg.bands[dir])
            elseif inner_value <= 1 then
                cfg[config_type][dir] = math.ceil(cfg.bands[dir] * inner_value)
            else
                cfg[config_type][dir] = math.ceil(inner_value)
            end
        end
        return cfg[config_type]
    end
    
    for _, config_name in ipairs({ "guest", "xq" }) do
        for _, dir in ipairs(directions) do
            local inner_value = tonumber(cfg[config_name].inner[dir])
            if inner_value <= 0 then
                cfg[config_name][dir] = tonumber(cfg.bands[dir])
            elseif inner_value <= 1 then
                cfg[config_name][dir] = math.ceil(cfg.bands[dir] * inner_value)
            else
                cfg[config_name][dir] = math.ceil(inner_value)
            end
        end
    end
    
    return cfg
end

-- 计算 HTB burst 值
-- @param rate 速率 (kbps)
-- @return burst值, cburst值
function get_burst(rate)
    local burst = math.ceil(rate * g_htb_buffer_data * g_htb_buffer_factor)
    local cburst = math.ceil(rate * g_htb_buffer_data)
    
    if burst < g_min_burst then
        burst = g_min_burst
    end
    if cburst < g_min_burst then
        cburst = g_min_burst
    end
    
    return burst, cburst
end

-- 获取抑制后的 ceil 值
-- @param ceil 原始 ceil 值
-- @param supress_value 抑制值
-- @return 抑制后的 ceil 值
function get_supressed_ceil(ceil, supress_value)
    local result = ceil
    
    if cfg.supress_host.enabled and supress_value and supress_value > 0 then
        local max_supress = math.ceil(ceil * 0.75)
        if supress_value < max_supress then
            max_supress = supress_value
        end
        result = result - max_supress
    end
    
    return result
end

-- 执行命令列表
-- @param cmd_list 命令列表
-- @param ignore_error 是否忽略错误
-- @return 是否全部成功
function exec_cmd(cmd_list, ignore_error)
    local log_file = "/tmp/miqos.log"
    
    for _, cmd in ipairs(cmd_list) do
        local full_cmd = cmd
        
        if g_debug then
            logger(3, "++" .. full_cmd)
            full_cmd = full_cmd .. " >/dev/null 2>>" .. log_file
        else
            full_cmd = full_cmd .. " &>/dev/null "
        end
        
        local ret = os.execute(full_cmd)
        
        if ret ~= 0 and ignore_error ~= 1 then
            if g_debug then
                os.execute("echo \"^^^ " .. full_cmd .. " ^^^ \" >>" .. log_file)
            end
            logger(3, "[ERROR]:  " .. full_cmd .. " failed!")
            dump_qdisc(cfg.DEVS)
            system_exit()
            return false
        end
    end
    
    return true
end

-- 创建有序集合
-- @return 有序集合对象
function newset()
    local index = {}
    local set = {}
    
    setmetatable(set, {
        __index = {
            insert = function(self, value)
                if not index[value] then
                    table.insert(self, value)
                    index[value] = table.getn(self)
                end
            end,
            remove = function(self, value)
                local pos = index[value]
                if pos then
                    index[value] = nil
                    local removed = table.remove(self)
                    if removed ~= value then
                        index[removed] = pos
                        self[pos] = removed
                    end
                end
            end
        }
    })
    
    return set
end

string.split = function(str, sep)
    local result = {}
    string.gsub(str, "[^" .. sep .. "]+", function(match)
        table.insert(result, match)
    end)
    return result
end

-- 递归打印表 (调试用)
-- @param tbl 要打印的表
-- @param indent 缩进字符串
-- @param print_func 打印函数
local function print_table(tbl, indent, print_func)
    indent = indent or ""
    print_func = print_func or logger
    
    if not tbl then
        return
    end
    
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            print_func(3, indent .. key .. " = {")
            print_table(value, indent .. "    ", print_func)
            print_func(3, indent .. "}")
        elseif type(value) == "boolean" then
            local bool_str = value and "true" or "false"
            print_func(3, indent .. key .. "=" .. bool_str)
        else
            print_func(3, indent .. key .. "=" .. value)
        end
    end
end

-- 打印表 (带分隔线)
-- @param tbl 要打印的表
-- @param title 标题
-- @param print_func 打印函数
function pr(tbl, title, print_func)
    print_func = print_func or logger
    title = title or ""
    title = title .. "-----------------"
    
    print_func(3, title)
    print_table(tbl, "", print_func)
    print_func(3, title)
end

-- 打印表到控制台
-- @param tbl 要打印的表
-- @param title 标题
function pr_console(tbl, title)
    if not printf then
        printf = logger
    end
    
    title = title or ""
    title = title .. "-----------------"
    
    printf(3, title)
    print_table(tbl, "", printf)
    printf(3, title)
end

-- 打印系统信息
-- @return 系统信息字符串
function p_sysinfo()
    local info = "INFO,Qdisc:" .. (cfg.qdisc.cur or "nil")
        .. ",Mode:" .. cfg.qos_type.mode
        .. ",Band: U:" .. cfg.bands.UP .. "kbps,D:" .. cfg.bands.DOWN .. "kbps"
    return info
end

g_limit = {}

-- 更新计数器
-- @param param 参数
function update_counters(param)
    local qdisc_type = cfg.qdisc.cur
    
    if qdisc[qdisc_type] and qdisc[qdisc_type].update_counters then
        g_limit = qdisc[qdisc_type].update_counters(param)
    else
        g_limit = {}
    end
end

local const_tc_qdisc_show = "tc -d qdisc show | sort "
local const_tc_class_show = "tc -d class show dev "
local const_tc_filter_show = "tc -d filter show dev "

-- 转储 qdisc 信息 (调试用)
-- @param devs 设备列表
function dump_qdisc(devs)
    local cmds = {}
    
    for _, dev in pairs(devs) do
        table.insert(cmds, const_tc_class_show .. dev.dev)
    end
    
    for _, dev in pairs(devs) do
        table.insert(cmds, const_tc_filter_show .. dev.dev)
    end
    
    local handle = io.popen(const_tc_qdisc_show)
    for line in handle:lines() do
        if g_debug then
            logger(3, line)
        end
    end
    handle:close()
end

-- 计算 fq_codel 参数
-- @param rate 速率 (kbps)
-- @return target值, interval值
function calc_fq_codel_params(rate)
    local target = 5000
    local interval = 100000
    
    if rate <= 0 then
        return target, interval
    end
    
    target = 12800000 / rate
    if target < 5000 then
        target = 5000
    end
    
    interval = 95000 + target
    
    return math.ceil(target), math.ceil(interval)
end

-- 应用叶子队列规则
-- @param cmd_list 命令列表
-- @param dev 设备名
-- @param parent 父类ID
-- @param classid 类ID
-- @param rate 速率
-- @param is_new 是否为新建
function apply_leaf_qdisc(cmd_list, dev, parent, classid, rate, is_new)
    local action = "add"
    local del_cmds = {}
    
    if g_leaf_type == "sfq" then
        if not is_new then
            local del_cmd = string.format(" %s del dev %s parent %s:%s sfq",
                const_tc_qdisc, dev, parent, classid)
            table.insert(del_cmds, del_cmd)
        end
        
        local add_cmd = string.format(" %s %s dev %s parent %s:%s sfq perturb 10 ",
            const_tc_qdisc, action, dev, parent, classid)
        table.insert(cmd_list, add_cmd)
        
    elseif g_leaf_type == "fq_codel" then
        if not is_new then
            local del_cmd = string.format(" %s del dev %s parent %s:%s ",
                const_tc_qdisc, dev, parent, classid)
            table.insert(del_cmds, del_cmd)
        end
        
        local target, interval = calc_fq_codel_params(rate)
        local add_cmd = string.format(" %s %s dev %s parent %s:%s fq_codel limit 1024 flows 1024 target %sus interval %sus ",
            const_tc_qdisc, action, dev, parent, classid, target, interval)
        table.insert(cmd_list, add_cmd)
        
    else
        if not is_new then
            local del_cmd = string.format(" %s del dev %s parent %s:%s ",
                const_tc_qdisc, dev, parent, classid)
            table.insert(del_cmds, del_cmd)
        end
        
        local add_cmd = string.format(" %s %s dev %s parent %s:%s pfifo limit 1024 ",
            const_tc_qdisc, action, dev, parent, classid)
        table.insert(cmd_list, add_cmd)
    end
    
    exec_cmd(del_cmds, 1)
end

-- 应用 PPPoE 过滤规则
-- @param cmd_list 命令列表
-- @param dev 设备名
-- @param parent 父类ID
-- @param prio 优先级
function apply_ppp_qdisc(cmd_list, dev, parent, prio)
    prio = prio or "1"
    local mask = "0x80"
    local offset = 0
    local protocol = nil
    
    if cfg.virtual_proto == "pppoe" then
        offset = 6
        protocol = "0x8864"
        
        local filter_cmd = string.format(" %s %s dev %s parent %s: prio %s protocol %s u32 match u8 0x80 %s at %d flowid %s: ",
            const_tc_filter, "add", dev, parent, prio, protocol, mask, offset, parent)
        table.insert(cmd_list, filter_cmd)
    end
end

-- 应用 ARP 小包过滤规则
-- @param cmd_list 命令列表
-- @param dev 设备名
-- @param action 操作 (add/del)
-- @param parent 父类ID
-- @param classid 类ID
function apply_arp_small_filter(cmd_list, dev, action, parent, classid)
    local protocol = "ip"
    local offset = 0
    local prio = "3"
    
    if cfg.virtual_proto == "pppoe" then
        if dev == "pppoe-wan" then
            offset = 0
        elseif string.find(dev, "eth", 1) then
            offset = 8
            protocol = "0x8864"
        else
            if QOS_VER == "STD" then
                protocol = "0x8864"
                offset = 8
            else
                protocol = "ip"
                offset = 0
            end
        end
    end
    
    local mask = "0xffc0"
    local filter_cmd = string.format(" %s %s dev %s parent %s: prio %s protocol %s u32 match u16 0x0000 %s at %d flowid %s:%s ",
        const_tc_filter, action, dev, parent, prio, protocol, mask, offset + 2, parent, classid)
    table.insert(cmd_list, filter_cmd)
end

-- 获取 STAB 字符串 (用于 PPPoE 开销计算)
-- @param dev 设备名
-- @return STAB参数字符串
function get_stab_string(dev)
    if g_enable_stab then
        local overhead = "0"
        
        if cfg.virtual_proto == "pppoe" then
            if dev == "pppoe-wan" then
                overhead = "14"
            elseif string.find(dev, "eth") then
                overhead = "22"
            else
                if QOS_VER == "STD" then
                    overhead = "22"
                else
                    overhead = "14"
                end
            end
        else
            overhead = "14"
        end
        
        return "stab linklayer ethernet mpu 0 overhead " .. overhead
    else
        return " "
    end
end

-- 获取接口设备名
-- @param interface 接口名
-- @return 设备名
local function get_interface_device(interface)
    return run_cmd("uci -q get network." .. interface .. ".ifname")
end

-- 默认清理函数
local function default_cleanup()
    local cmds = {}
    local devices = { "br-lan" }
    
    if QOS_VER ~= "NOIFB" then
        table.insert(devices, "ifb0")
    end
    
    local guest_exists = run_cmd("uci -q get network.guest")
    if guest_exists then
        table.insert(devices, get_interface_device("guest"))
    end
    
    local wan_dev = get_interface_device("wan")
    if wan_dev then
        table.insert(devices, wan_dev)
    end
    
    for _, dev in ipairs(devices) do
        local cmd = string.format("%s del dev %s root ", const_tc_qdisc, dev)
        table.insert(cmds, cmd)
    end
    
    exec_cmd(cmds, 1)
end

-- 清理 QoS 系统
-- @return 总是返回 true
function cleanup_system()
    if QOS_VER ~= "FIX" and QOS_VER ~= "NOIFB" then
        if cfg.qdisc.cur and qdisc[cfg.qdisc.cur] and qdisc[cfg.qdisc.cur].clean then
            logger(3, "======= Cleanup QoS rules for " .. cfg.qdisc.cur)
            qdisc[cfg.qdisc.cur].clean(cfg.DEVS)
            cfg.qdisc.cur = nil
            cfg.qdisc.old = nil
        end
    else
        if QOS_VER == "HWQOS" then
            logger(3, "======= Cleanup  HWQOS rules for ")
            qdisc.service.clean(nil)
        else
            logger(3, "======= Cleanup  default ")
            default_cleanup()
        end
    end
    
    return true
end

-- 转储当前和旧的 qdisc 状态 (调试用)
-- @param prefix 日志前缀
function dump_cur_old_qdisc(prefix)
    old_qdisc = cfg.qdisc.old
    cur_qdisc = cfg.qdisc.cur
    
    local old_str, cur_str, cfg_old_str, cfg_cur_str
    
    if old_qdisc ~= nil then
        old_str = string.format("old_qdisc: %s  ", old_qdisc)
    else
        old_str = string.format("old_qdisc: %s  ", "nil")
    end
    
    if cur_qdisc ~= nil then
        cur_str = string.format("cur_qdisc: %s  ", cur_qdisc)
    else
        cur_str = string.format("cur_qdisc: %s  ", "nil")
    end
    
    if cfg.qdisc.old ~= nil then
        cfg_old_str = string.format("cfg.qdisc.old: %s  ", cfg.qdisc.old)
    else
        cfg_old_str = string.format("cfg.qdisc.old: %s  ", "nil")
    end
    
    if cfg.qdisc.cur ~= nil then
        cfg_cur_str = string.format("cfg.qdisc.cur: %s  ", cfg.qdisc.cur)
    else
        cfg_cur_str = string.format("cfg.qdisc.cur: %s  ", "nil")
    end
    
    logger(3, "=================" .. prefix .. old_str .. cur_str .. cfg_old_str .. cfg_cur_str)
end
