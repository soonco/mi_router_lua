--[[
    防攻击控制器模块 (Anti-Attack Controller Module)
    
    功能说明:
    - 提供防攻击相关的API接口
    - 支持反向路径过滤(rpfilter)、DoS防护、端口扫描防护
    - 提供网关安全概览接口
    
    API端点:
    - /api/anti_attack/get_status: 获取防攻击状态
    - /api/anti_attack/set_rpfilter: 设置反向路径过滤
    - /api/anti_attack/set_dos: 设置DoS防护
    - /api/anti_attack/set_scan: 设置端口扫描防护
    - /api/gateway_security/overview: 网关安全概览
    
    依赖模块:
    - luci.http: HTTP处理
    - ubus: 系统总线通信
]]

module("luci.controller.anti_attack.index", package.seeall)

local CONFIG_NAME = "firewall_cpp"
local SECTION_NAME = "anti_attack"

local http = require("luci.http")
local ubus = require("ubus")

--[[
    路由索引函数
    
    注册所有API路由
]]
function index()
    local api_node = node("api", "anti_attack")
    api_node.sysauth = "admin"
    api_node.sysauth_authenticator = "htmlauth"
    api_node.index = true
    
    entry({"api", "anti_attack", "get_status"}, call("get_status_api"), "")
    entry({"api", "anti_attack", "set_rpfilter"}, call("set_rpfilter_api"), "")
    entry({"api", "anti_attack", "set_dos"}, call("set_dos_api"), "")
    entry({"api", "anti_attack", "set_scan"}, call("set_scan_api"), "")
    
    local gateway_node = node("api", "gateway_security")
    gateway_node.sysauth = "admin"
    gateway_node.sysauth_authenticator = "htmlauth"
    gateway_node.index = true
    
    entry({"api", "gateway_security", "overview"}, call("overview"), "")
end

--[[
    设置反向路径过滤
    
    反向路径过滤用于防止IP欺骗攻击
    
    @param enable boolean 是否启用
    @return number 0成功，-1失败
]]
function set_rpfilter(enable)
    local conn = ubus.connect()
    if not conn then
        return -1
    end
    
    conn:call("uci", "set", {
        config = CONFIG_NAME,
        section = SECTION_NAME,
        values = {
            rpfilter_enable = enable and "1" or "0"
        }
    })
    
    conn:call("uci", "commit", {
        config = CONFIG_NAME
    })
    
    return 0
end

--[[
    设置反向路径过滤API
    
    从HTTP请求获取enable参数并调用set_rpfilter
]]
function set_rpfilter_api()
    local enable = http.formvalue("enable", nil, "numberstr")
    
    if enable == "1" or enable == "0" then
        local enabled = (enable == "1")
        http.write_json({
            code = set_rpfilter(enabled)
        })
    else
        http.write_json({
            code = -1
        })
    end
end

--[[
    设置DoS防护
    
    DoS防护用于防止拒绝服务攻击
    
    @param enable boolean 是否启用
    @return number 0成功，-1失败
]]
function set_dos(enable)
    local conn = ubus.connect()
    if not conn then
        return -1
    end
    
    conn:call("uci", "set", {
        config = CONFIG_NAME,
        section = SECTION_NAME,
        values = {
            dos_enable = enable and "1" or "0"
        }
    })
    
    conn:call("uci", "commit", {
        config = CONFIG_NAME
    })
    
    return 0
end

--[[
    设置DoS防护API
]]
function set_dos_api()
    local enable = http.formvalue("enable", nil, "numberstr")
    
    if enable == "1" or enable == "0" then
        local enabled = (enable == "1")
        http.write_json({
            code = set_dos(enabled)
        })
    else
        http.write_json({
            code = -1
        })
    end
end

--[[
    设置端口扫描防护
    
    端口扫描防护用于防止恶意端口扫描
    
    @param enable boolean 是否启用
    @return number 0成功，-1失败
]]
function set_scan(enable)
    local conn = ubus.connect()
    if not conn then
        return -1
    end
    
    conn:call("uci", "set", {
        config = CONFIG_NAME,
        section = SECTION_NAME,
        values = {
            scan_enable = enable and "1" or "0"
        }
    })
    
    conn:call("uci", "commit", {
        config = CONFIG_NAME
    })
    
    return 0
end

--[[
    设置端口扫描防护API
]]
function set_scan_api()
    local enable = http.formvalue("enable", nil, "numberstr")
    
    if enable == "1" or enable == "0" then
        local enabled = (enable == "1")
        http.write_json({
            code = set_scan(enabled)
        })
    else
        http.write_json({
            code = -1
        })
    end
end

--[[
    获取防攻击状态
    
    @return table 包含各项防护状态的表
        - code: 状态码(0成功，-1失败)
        - dos: DoS防护状态(0/1)
        - scan: 端口扫描防护状态(0/1)
        - rpfilter: 反向路径过滤状态(0/1)
]]
function get_status()
    local result = {}
    
    local conn = ubus.connect()
    if not conn then
        result.code = -1
        return result
    end
    
    local uci_data = conn:call("uci", "get", {
        config = CONFIG_NAME,
        section = SECTION_NAME
    })
    
    local values = uci_data.values
    if not values then
        result.code = -1
        return result
    end
    
    result.code = 0
    
    result.dos = (values.dos_enable == "1" and values.disable ~= "1") and 1 or 0
    result.scan = (values.scan_enable == "1" and values.disable ~= "1") and 1 or 0
    result.rpfilter = (values.rpfilter_enable == "1" and values.disable ~= "1") and 1 or 0
    
    return result
end

--[[
    获取防攻击状态API
]]
function get_status_api()
    http.write_json(get_status())
end

--[[
    获取网关安全概览(内部函数)
    
    汇总所有安全防护项目的状态
    
    @return table, boolean 概览数据和是否有启用的防护
]]
function _overview()
    local features = require("xiaoqiang.XQFeatures").FEATURES
    
    local result = {}
    local total_count = 0
    local protected_count = 0
    
    local status = get_status()
    
    result.dos = { enable = status.dos }
    protected_count = protected_count + status.dos
    total_count = total_count + 1
    
    result.scan = { enable = status.scan }
    protected_count = protected_count + status.scan
    total_count = total_count + 1
    
    if features.system and features.system.ipmaccheck == "1" then
        local macbind = require("xiaoqiang.module.XQMacBind")
        local arp_bind_status = macbind.getIPMACCheckEnable()
        result.arp_bind = { enable = arp_bind_status }
        protected_count = protected_count + arp_bind_status
        total_count = total_count + 1
    end
    
    if features.apps and features.apps.local_gw_security == "1" then
        local uci_cursor = require("luci.model.uci").cursor()
        local fake_gw_enabled = tonumber(uci_cursor:get("local_gw_security", "settings", "enabled") or 0)
        result.fake_gateway = { enable = fake_gw_enabled }
        protected_count = protected_count + fake_gw_enabled
        total_count = total_count + 1
    end
    
    result.meta = {
        protected = protected_count,
        total = total_count
    }
    
    return result, protected_count > 0
end

--[[
    网关安全概览API
]]
function overview()
    local result = _overview()
    result.code = 0
    http.write_json(result)
end
