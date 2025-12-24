---
--- 小米路由器URL防火墙模块
--- 模块路径: luci.controller.url_fw.index
---
--- 功能概述:
---   提供URL过滤防火墙功能，基于安天(Antiy)URL分类引擎
---   支持URL分类策略配置和白名单管理
---
--- API端点:
---   /api/url_fw/update_status  - 更新防火墙状态
---   /api/url_fw/get_status     - 获取防火墙状态
---   /api/url_fw/show_policy    - 显示URL分类策略
---   /api/url_fw/update_policy  - 更新URL分类策略
---   /api/url_fw/show_whitelist - 显示白名单
---   /api/url_fw/add_whitelist  - 添加白名单
---   /api/url_fw/del_whitelist  - 删除白名单
---   /api/url_fw/overview       - 获取概览信息
---
--- 页面路由:
---   /url_fw - URL防火墙主页面
---
--- 依赖模块:
---   - luci.http: HTTP请求处理
---   - ubus: UCI总线通信
---   - xiaoqiang.common.XQConfigs: 配置常量
---   - xiaoqiang.common.XQFunction: 通用工具函数
---   - luci.i18n: 国际化支持
---

module("luci.controller.url_fw.index", package.seeall)

local UCI_CONFIG_POLICY = "antiy_url_policy"
local UCI_CONFIG_CLASS = "antiy_url_class"

local http = require("luci.http")
local ubus = require("ubus")

--- 模块路由注册入口
function index()
    --- 创建URL防火墙API节点
    local apiNode = node("api", "url_fw")
    apiNode.sysauth = "admin"
    apiNode.mediaurlbase = "/xiaoqiang/url_fw"
    apiNode.sysauth_authenticator = "htmlauth"
    apiNode.index = true

    --- 注册URL防火墙主页面
    entry({"url_fw"}, template("url_fw/home"), _(""), 1, 1)

    --- 注册API路由
    entry({"api", "url_fw", "update_status"}, call("update_status"), "", 3)
    entry({"api", "url_fw", "get_status"}, call("get_status"), "", 4)
    entry({"api", "url_fw", "show_policy"}, call("show_policy"), "", 5)
    entry({"api", "url_fw", "update_policy"}, call("update_policy"), "", 6)
    entry({"api", "url_fw", "show_whitelist"}, call("show_whitelist"), "", 7)
    entry({"api", "url_fw", "add_whitelist"}, call("add_whitelist"), "", 8, 1)
    entry({"api", "url_fw", "del_whitelist"}, call("del_whitelist"), "", 9)
    entry({"api", "url_fw", "overview"}, call("overview"), "", 10)
end

--- API: 更新防火墙状态
--- 设置防火墙启用状态和自动更新状态
--- @param enable: "0"或"1" - 是否启用防火墙
--- @param auto_update: "0"或"1" - 是否自动更新规则
function update_status()
    local enable = http.formvalue("enable", nil, "numberstr")
    local autoUpdate = http.formvalue("auto_update", nil, "numberstr")

    local ubusConn = ubus.connect()
    if not ubusConn then
        http.write_json({code = -1})
        return
    end

    local values = {}
    if enable == "0" or enable == "1" then
        values.enable = enable
    end
    if autoUpdate == "0" or autoUpdate == "1" then
        values.auto_update = autoUpdate
    end

    --- 通过UCI设置配置
    ubusConn:call("uci", "set", {
        config = UCI_CONFIG_POLICY,
        section = "meta",
        values = values
    })

    --- 提交配置
    ubusConn:call("uci", "commit", {
        config = UCI_CONFIG_POLICY
    })

    http.write_json({code = 0})
end

--- 内部函数: 获取防火墙状态
--- @return table: 状态信息表，包含enable, auto_update, update_ts
local function _get_status()
    local ubusConn = ubus.connect()
    if not ubusConn then
        return nil
    end

    local uciResult = ubusConn:call("uci", "get", {
        config = UCI_CONFIG_POLICY
    })

    local values = uciResult.values
    if values and values.meta and values.meta.enable and values.meta.auto_update then
        local XQConfigs = require("xiaoqiang.common.XQConfigs")
        local LuciUtil = require("luci.util")

        --- 获取ROM构建时间
        local buildTime = tonumber(LuciUtil.exec(XQConfigs.XQ_ROM_BUILDTIME))
        --- 获取规则更新时间
        local updateTs = tonumber(values.meta.update_ts) or 0

        local result = {}
        result.enable = tonumber(values.meta.enable)
        result.auto_update = tonumber(values.meta.auto_update)
        --- 使用较大的时间戳作为更新时间
        result.update_ts = math.max(buildTime, updateTs)

        return result
    end

    return nil
end

--- API: 获取防火墙状态
function get_status()
    local result = _get_status()
    if result then
        result.code = 0
    else
        result = {code = -1}
    end

    http.write_json(result)
end

--- 验证策略值是否有效
--- @param policy: 策略字符串
--- @return boolean: 是否有效
local function check_policy(policy)
    return policy == "reject" or policy == "alarm" or policy == "log" or policy == "ignored"
end

--- 内部函数: 获取URL分类策略列表
--- @return table: 策略列表
local function _show_policy()
    local i18n = require("luci.i18n")
    local lang = http.formvalue("lang", nil, "commonstr")

    if lang then
        i18n.setlanguage(lang)
    end

    local ubusConn = ubus.connect()
    if not ubusConn then
        return nil
    end

    --- 获取URL分类定义
    local classResult = ubusConn:call("uci", "get", {
        config = UCI_CONFIG_CLASS,
        type = "class"
    })
    local classValues = classResult.values

    --- 获取当前策略配置
    local policyResult = ubusConn:call("uci", "get", {
        config = UCI_CONFIG_POLICY
    })
    local policyValues = policyResult.values

    local result = {}

    --- 遍历所有分类
    for tag, classInfo in pairs(classValues) do
        local policyInfo = policyValues[tag]

        if policyInfo and policyInfo.policy and check_policy(policyInfo.policy) then
            --- 已配置策略的分类
            table.insert(result, {
                tag = tag,
                name = i18n.translate(classInfo.name),
                policy = policyInfo.policy
            })
        else
            --- 未配置策略的分类，默认为reject
            table.insert(result, {
                tag = tag,
                name = i18n.translate(classInfo.name),
                policy = "reject"
            })
        end
    end

    return result
end

--- API: 显示URL分类策略
function show_policy()
    local result = _show_policy()
    if not result then
        http.write_json({code = -1})
        return
    end

    http.write_json({
        list = result,
        code = 0
    })
end

--- API: 更新URL分类策略
--- @param tag: 分类标签
--- @param policy: 策略值(reject/alarm/log/ignored)
function update_policy()
    local tag = http.formvalue("tag", nil, "commonstr")
    local policy = http.formvalue("policy", nil, "commonstr")

    local ubusConn = ubus.connect()

    if not (tag and policy and check_policy(policy) and ubusConn) then
        http.write_json({code = -1})
        return
    end

    --- 添加分类配置节点
    ubusConn:call("uci", "add", {
        config = UCI_CONFIG_POLICY,
        type = "class",
        name = tag
    })

    --- 设置策略值
    ubusConn:call("uci", "set", {
        config = UCI_CONFIG_POLICY,
        section = tag,
        values = {policy = policy}
    })

    --- 提交配置
    ubusConn:call("uci", "commit", {
        config = UCI_CONFIG_POLICY
    })

    http.write_json({code = 0})
end

--- API: 显示白名单
function show_whitelist()
    local ubusConn = ubus.connect()
    if not ubusConn then
        http.write_json({code = -1})
        return
    end

    --- 获取白名单条目
    local result = ubusConn:call("uci", "get", {
        config = UCI_CONFIG_POLICY,
        section = "whitelist",
        option = "entry"
    })

    local entries = result and result.value or {}
    local whitelist = {}

    --- 解析白名单条目
    --- 格式: [timestamp]url
    for _, entry in ipairs(entries) do
        local startPos, endPos = string.find(entry, "%[%d+%]")
        if startPos and endPos then
            local timestamp = tonumber(string.sub(entry, startPos + 1, endPos - 1))
            local url = string.sub(entry, endPos + 1)

            table.insert(whitelist, {
                utc = timestamp,
                url = url
            })
        end
    end

    http.write_json({
        whitelist = whitelist,
        code = 0
    })
end

--- 根据IP地址获取MAC地址
--- @param ip: IP地址
--- @return string: MAC地址
local function ip_to_mac(ip)
    local XQFunction = require("xiaoqiang.common.XQFunction")

    --- 读取ARP表
    local arpOutput = XQFunction.waitExec("cat /proc/net/arp")

    --- 处理IP地址格式
    local cleanIp = ip:match("([^%%]+)") or ip

    --- 解析ARP表查找对应MAC
    for line in arpOutput:gmatch("[^\n]+") do
        local arpIp, arpMac = line:match("([^%s]+) [^%s]+ [^%s]+ [^%s]+ ([^%s]+) [^%s]+")
        if arpIp == cleanIp then
            return arpMac
        end
    end

    return nil
end

--- API: 添加白名单
--- @param url: 要添加的URL
--- @param session: 会话标识(用于验证)
function add_whitelist()
    local url = http.formvalue("url", nil, "commonstr")
    local session = http.formvalue("session", nil, "commonstr")

    local ubusConn = ubus.connect()

    if not (url and session) or not ubusConn then
        http.write_json({code = -1})
        return
    end

    --- 验证会话
    local verifyResult = ubusConn:call("antiy_url", "verifySession", {
        session = session,
        url = url
    })

    if not (verifyResult and verifyResult.code and verifyResult.code == 0) then
        http.write_json({code = 0})
        return
    end

    --- 添加白名单条目
    --- 格式: [timestamp]url
    local timestamp = tostring(os.time())
    local entry = "[" .. timestamp .. "]" .. url

    ubusConn:call("uci", "add", {
        config = UCI_CONFIG_POLICY,
        type = "whitelist",
        name = "whitelist",
        values = {
            entry = {entry}
        }
    })

    ubusConn:call("uci", "commit", {
        config = UCI_CONFIG_POLICY
    })

    --- 记录日志
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local clientIp = http.getenv("X_REAL_IP") or http.getenv("REMOTE_ADDR")
    local clientMac = ip_to_mac(clientIp)

    local logMsg = string.format(
        '{"tag":"sec_risk_web","type":"whitelist","mac":"%s","url":"%s"}',
        clientMac or "",
        url
    )
    XQFunction.waitExec("milog.sh", "-m", logMsg)

    --- 重新加载防火墙规则
    XQFunction.waitExec("antiy_url_firewall")

    http.write_json({code = 0})
end

--- API: 删除白名单
--- @param url: 要删除的URL列表(JSON数组)
function del_whitelist()
    local cjson = require("cjson")
    local urlList = http.formvalue("url", nil)

    local ubusConn = ubus.connect()

    if not urlList or not ubusConn then
        http.write_json({code = -1})
        return
    end

    --- 解析URL列表
    local urls = cjson.decode(urlList)

    --- 获取当前白名单
    local result = ubusConn:call("uci", "get", {
        config = UCI_CONFIG_POLICY,
        section = "whitelist",
        option = "entry"
    })

    local entries = result and result.value or {}

    --- 移除指定的URL
    for _, urlToDelete in ipairs(urls) do
        local indexToRemove = -1

        for i, entry in ipairs(entries) do
            local startPos, endPos = string.find(entry, "%[%d+%]")
            if startPos and endPos then
                local entryUrl = string.sub(entry, endPos + 1)
                if urlToDelete == entryUrl then
                    indexToRemove = i
                    break
                end
            end
        end

        if indexToRemove == -1 then
            http.write_json({code = -1})
            return
        end

        table.remove(entries, indexToRemove)
    end

    --- 更新白名单
    if #entries == 0 then
        entries = ""
    end

    ubusConn:call("uci", "set", {
        config = UCI_CONFIG_POLICY,
        section = "whitelist",
        values = {entry = entries}
    })

    ubusConn:call("uci", "commit", {
        config = UCI_CONFIG_POLICY
    })

    http.write_json({code = 0})
end

--- 内部函数: 获取概览信息
--- @return table: 概览数据
--- @return boolean: 是否有不安全项
local function _overview()
    local result = {}

    --- 复制状态信息
    local status = _get_status()
    if status then
        for k, v in pairs(status) do
            result[k] = v
        end
    end

    --- 获取策略统计
    local policies = _show_policy()
    local totalCount = 0
    local protectedCount = 0

    for _, policy in ipairs(policies or {}) do
        if policy.policy ~= "ignored" then
            protectedCount = protectedCount + 1
        end
        totalCount = totalCount + 1
    end

    result.policy = policies
    result.total = totalCount
    result.protected = (status and status.enable == 1) and protectedCount or 0

    local meta = {}
    meta.meta = result

    --- 如果有未保护的分类，标记为不安全
    local hasInsecure = protectedCount > 0

    return meta, hasInsecure
end

--- API: 获取概览信息
function overview()
    local result = _overview()
    result.code = 0

    http.write_json(result)
end
