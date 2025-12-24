---
--- 小米路由器内部服务API模块
--- 模块路径: luci.controller.service.internal
---
--- 功能概述:
---   提供内部服务接口，包括游戏加速、IPv6加速和自定义hosts
---
--- API端点:
---   /service/internal/ccgame         - CC游戏加速控制
---   /service/internal/ipv6           - IPv6加速服务控制
---   /service/internal/custom_host_get - 获取自定义hosts
---   /service/internal/custom_host_set - 设置自定义hosts
---
--- 依赖模块:
---   - luci.http: HTTP请求处理
---   - xiaoqiang.common.XQConfigs: 配置常量
---   - xiaoqiang.common.XQFunction: 通用工具函数
---   - service.util.ServiceErrorUtil: 服务错误处理
---   - cjson: JSON编解码
---   - nixio/nixio.fs: 文件系统操作
---   - xiaoqiang.XQLog: 日志模块
---

module("luci.controller.service.internal", package.seeall)

local http = require("luci.http")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local ServiceErrorUtil = require("service.util.ServiceErrorUtil")
local XQFunction = require("xiaoqiang.common.XQFunction")
local cjson = require("cjson")
local LuciUtil = require("luci.util")
local nixioFs = require("nixio.fs")
local nixio = require("nixio")
local XQLog = require("xiaoqiang.XQLog")

--- 模块路由注册入口
function index()
    --- 创建内部服务节点
    local internalNode = node("service", "internal")
    internalNode.target = firstchild()
    internalNode.title = ""
    internalNode.order = nil
    internalNode.sysauth = "admin"
    internalNode.sysauth_authenticator = "jsonauth"
    internalNode.index = true

    --- 注册API路由
    entry({"service", "internal", "ccgame"}, call("turbo_ccgame_call"), "", nil, 16)
    entry({"service", "internal", "ipv6"}, call("turbo_ipv6_call"), "", nil, 16)
    entry({"service", "internal", "custom_host_get"}, call("custom_host_get"), "", nil, 16)
    entry({"service", "internal", "custom_host_set"}, call("custom_host_set"), "", nil, 16)
end

--- 检查并启动ubus服务
--- @param ubusConn: ubus连接对象
--- @param serviceName: 服务名称
--- @param startCommand: 启动命令
--- @return boolean: 服务是否可用
local function check_and_run_ubus_ready(ubusConn, serviceName, startCommand)
    if not ubusConn then
        return false
    end

    --- 检查服务是否已注册
    for _ = 1, 3 do
        local objects = ubusConn:objects()
        for _, obj in ipairs(objects) do
            if obj == serviceName then
                return true
            end
        end

        --- 服务未运行，尝试启动
        os.execute(startCommand)
        os.execute("sleep 1")
    end

    return false
end

--- API: CC游戏加速控制
--- 控制CC游戏加速服务的各种操作
--- @param cmd: 命令ID (0-7)
---   0: 自定义ubus命令
---   1: 启动加速
---   2: 停止加速
---   3: 获取状态
---   4-7: 其他操作
--- @param ip: IP地址列表(可选)
--- @param byvpn: 是否通过VPN(可选)
--- @param game: 游戏ID(可选)
--- @param region: 区域ID(可选)
--- @param ubus: 自定义ubus命令(可选)
function turbo_ccgame_call()
    local cmd = tonumber(http.formvalue("cmd") or 0)
    local result = {}

    --- 加载CC游戏加速模块
    local ccgameInterface = require("turbo.ccgame.ccgame_interface")

    if not ccgameInterface then
        result.code = -1
        result.msg = "not support ccgame."
    elseif cmd < 0 or cmd > 7 then
        result.code = -1
        result.msg = "action id is not valid"
    else
        --- 构建请求参数
        local requestData = {
            cmdid = cmd,
            data = {}
        }

        --- 获取可选参数
        local ip = http.formvalue("ip")
        local byvpn = http.formvalue("byvpn")
        local game = http.formvalue("game")
        local region = http.formvalue("region")
        local ubusCmd = http.formvalue("ubus")

        --- 处理IP列表
        if ip then
            requestData.data.iplist = ccgameInterface._cmdformat(ip)
        end

        --- 处理VPN标志
        --- byvpn=0表示使用VPN，否则不使用
        if byvpn and byvpn ~= "0" then
            requestData.data.byvpn = "0"
        else
            requestData.data.byvpn = "1"
        end

        --- 处理游戏和区域
        if game and region then
            requestData.data.gameid = ccgameInterface._cmdformat(game)
            requestData.data.regionid = ccgameInterface._cmdformat(region)
        end

        --- 处理自定义ubus命令
        if ubusCmd then
            requestData.ubus = ccgameInterface._cmdformat(ubusCmd)
        end

        --- 调用CC游戏加速接口
        result = ccgameInterface.ccgame_call(requestData)
    end

    http.write_json(result)
end

--- API: IPv6加速服务控制
--- 控制IPv6加速服务的启动、停止和状态查询
--- @param cmd: 命令ID
---   0: 自定义ubus命令
---   1: 启动服务
---   2: 停止服务
---   3: 获取状态
function turbo_ipv6_call()
    local cmd = tonumber(http.formvalue("cmd") or 0)
    local result = {}

    if cmd < 0 or cmd > 3 then
        result.code = -1
        result.msg = "action id is not valid"
    else
        local ubus = require("ubus")
        local ubusConn = ubus.connect()

        if not ubusConn then
            result.code = -1
            result.msg = "ubus cannot connected."
        else
            --- 检查并启动turbo_ipv6服务
            local serviceReady = check_and_run_ubus_ready(
                ubusConn,
                "turbo_ipv6",
                "/etc/init.d/turbo start_ipv6"
            )

            if not serviceReady then
                result.code = -1
                result.msg = "ubus service is not running..."
            else
                local action = nil
                local serviceName = "turbo_ipv6"
                local params = {}

                if cmd == 1 then
                    --- 启动服务前需要激活账号
                    local accountData = {provider = "sellon"}
                    local matoolCmd = "matool --method api_call_post --params /device/vip/account '"
                        .. cjson.encode(accountData) .. "'"

                    local success, response = pcall(function()
                        return cjson.decode(LuciUtil.trim(LuciUtil.exec(matoolCmd)))
                    end)

                    if success and response and type(response) == "table" and response.code == 0 then
                        action = "start"
                    else
                        result.code = -1
                        result.msg = "active account failed. pls check if account binded or network is connected."
                        action = nil
                    end
                elseif cmd == 2 then
                    action = "stop"
                elseif cmd == 3 then
                    action = "status"
                elseif cmd == 0 then
                    --- 自定义ubus命令
                    local ubusCmd = http.formvalue("ubus") or ""
                    action = XQFunction._cmdformat(ubusCmd)
                else
                    action = nil
                    result.msg = "not supported command."
                end

                --- 执行ubus调用
                if action and action ~= "" then
                    local ubusResult = ubusConn:call(serviceName, action, params)
                    ubusConn:close()

                    if ubusResult then
                        result = ubusResult
                    else
                        result.code = -1
                        result.msg = "call ubus failed."
                    end
                else
                    result.code = -1
                end
            end
        end
    end

    http.write_json(result)
end

--- API: 获取自定义hosts
--- 读取并解析自定义hosts文件
--- @return hosts: hosts条目数组，格式为 "ip hostname"
function custom_host_get()
    local CUSTOM_HOSTS_FILE = "/tmp/hosts/custom_hosts"
    local result = {
        code = 0,
        msg = "OK"
    }

    --- 检查文件是否存在
    if nixioFs.access(CUSTOM_HOSTS_FILE) then
        local hFile = io.open(CUSTOM_HOSTS_FILE, "r")
        local hosts = {}

        --- 解析hosts文件
        --- 格式: IP地址 主机名
        for line in hFile:lines() do
            local startPos, _, ip, hostname = string.find(line, "^%s*([0-9A-Fa-f.:]+)%s*([^%s]+)%s*")
            if startPos and ip and hostname then
                table.insert(hosts, ip .. " " .. hostname)
            end
        end

        hFile:close()
        result.hosts = hosts
    else
        result.code = -1
        result.msg = "read hosts file failure."
    end

    http.write_json(result)
end

--- API: 设置自定义hosts
--- 将hosts配置写入自定义hosts文件
--- @param hosts: hosts条目JSON数组
function custom_host_set()
    local hostsJson = http.formvalue("hosts") or ""
    local result = {
        code = 0,
        msg = "OK"
    }

    --- 解析hosts JSON
    local success, hosts = pcall(function()
        return cjson.decode(LuciUtil.trim(hostsJson))
    end)

    local ETC_HOSTS_FILE = "/etc/custom_hosts"
    local TMP_HOSTS_FILE = "/tmp/hosts/custom_hosts"

    if success and hosts then
        --- 写入临时hosts文件
        local hFile = io.open(TMP_HOSTS_FILE, "w")

        for _, entry in ipairs(hosts) do
            local startPos, _, ip, hostname = string.find(entry, "^%s*([0-9A-Fa-f.:]+)%s*([^%s]+)%s*")
            if startPos and ip and hostname then
                hFile:write(ip, " ", hostname, "\n")
            end
        end

        hFile:close()

        --- 复制到永久存储
        nixioFs.copy(TMP_HOSTS_FILE, ETC_HOSTS_FILE)
    else
        result.code = -1
        result.msg = "parameter hosts lost or foramt invalid."
    end

    http.write_json(result)
end
