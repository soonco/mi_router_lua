--[[
    小米日志控制器模块 (Mi Log Controller Module)
    
    功能说明:
    - 提供路由器安全日志相关的API接口
    - 支持日志开关、概览、删除和获取功能
    - 日志类型包括: 风险日志(risk)、系统日志(sys)、网卡日志(nic)
    
    API端点:
    - /api/mi_log/get_onoff: 获取日志开关状态
    - /api/mi_log/set_onoff: 设置日志开关
    - /api/mi_log/overview: 获取日志概览
    - /api/mi_log/del_logs: 删除日志
    - /api/mi_log/get_logs: 获取日志列表
    
    依赖模块:
    - xiaoqiang.module.XQMiwifiLog: 日志模块
    - luci.cbi.datatypes: 数据类型验证
    - luci.http: HTTP处理
    - xiaoqiang.XQLog: 日志工具
]]

module("luci.controller.api.milog", package.seeall)

local XQMiwifiLog = require("xiaoqiang.module.XQMiwifiLog")
local datatypes = require("luci.cbi.datatypes")
local http = require("luci.http")
local XQLog = require("xiaoqiang.XQLog")

function index()
    local api_node = node("api", "mi_log")
    api_node.target = firstchild()
    api_node.title = ""
    api_node.order = 999
    api_node.sysauth = "admin"
    api_node.sysauth_authenticator = "jsonauth"
    api_node.index = true
    
    entry({"api", "mi_log"}, firstchild(), "", 100)
    entry({"api", "mi_log", "get_onoff"}, call("getOnOff"), "", 100)
    entry({"api", "mi_log", "set_onoff"}, call("setOnOff"), "", 100)
    entry({"api", "mi_log", "overview"}, call("overview"), "", 100)
    entry({"api", "mi_log", "del_logs"}, call("delLogs"), "", 100)
    entry({"api", "mi_log", "get_logs"}, call("getLogs"), "", 100)
end

function _overview()
    local uci = require("luci.model.uci").cursor()
    local enable = uci:get("milog", "global", "enable") or "1"
    
    local result = {}
    result.meta = {
        enable = (enable ~= "0") and 1 or 0
    }
    
    return result, enable ~= "0"
end

function getOnOff()
    local uci = require("luci.model.uci").cursor()
    
    local result = {
        code = 0,
        msg = "success",
        info = { on = 0 }
    }
    
    local enable = uci:get("milog", "global", "enable") or "1"
    if enable ~= "0" then
        result.info.on = 1
    end
    
    http.write_json(result)
end

function setOnOff()
    local uci = require("luci.model.uci").cursor()
    local on = http.formvalue("on", nil, "?numberstr") or "1"
    
    local result = {
        code = 0,
        msg = "success"
    }
    
    uci:set("milog", "global", "enable", on)
    uci:commit("milog")
    
    os.execute("/etc/init.d/miwifi-logd reload")
    
    http.write_json(result)
end

function overview()
    local result = {
        code = 0,
        msg = "success",
        info = {
            risk_cnt = 0,
            sys_cnt = 0,
            nic_cnt = 0
        }
    }
    
    result.info.risk_cnt = XQMiwifiLog.get_cnt_by_prefix("sec_risk_")
    result.info.sys_cnt = XQMiwifiLog.get_cnt_by_prefix("sec_sys_")
    result.info.nic_cnt = XQMiwifiLog.get_cnt_by_prefix("sec_nic_")
    
    http.write_json(result)
end

function delLogs()
    local log_type = http.formvalue("type", nil, "?commonstr") or ""
    local value = http.formvalue("value", nil, "?commonstr") or ""
    local filter = http.formvalue("filter", nil, "?commonstr")
    
    local result = {
        code = 0,
        msg = "success"
    }
    
    if log_type ~= "duration" then
        XQMiwifiLog.del_by_ids(value)
    else
        if datatypes.integer(value) then
            local days = tonumber(value) or 0
            local prefix = filter and ("sec_" .. filter) or nil
            XQMiwifiLog.del_by_days(days, prefix)
        else
            result.code = 1523
            result.msg = _("参数错误")
        end
    end
    
    http.write_json(result)
end

function getLogs()
    local log_type = http.formvalue("type", nil, "?commonstr") or ""
    local tsclient = http.formvalue("tsclient", nil, "?numberstr") or ""
    local duration = http.formvalue("duration", nil, "?numberstr") or ""
    local offset = http.formvalue("offset", nil, "?numberstr") or ""
    local limit = http.formvalue("limit", nil, "?numberstr") or ""
    
    local result = {
        code = 0,
        msg = "success",
        info = {}
    }
    
    if tsclient == "" or duration == "" then
        result.code = 1523
        result.msg = _("参数错误")
        http.write_json(result)
        return
    end
    
    if log_type == "" then
        log_type = "sys"
    end
    if offset == "" then
        offset = "0"
    end
    if limit == "" then
        limit = "10"
    end
    
    local prefix = "sec_" .. log_type
    result.total = XQMiwifiLog.get_logs_cnt(tonumber(duration) or 0, tsclient, prefix)
    
    local logs = XQMiwifiLog.get_logs(
        tonumber(duration) or 0,
        tsclient,
        prefix,
        tonumber(offset) or 0,
        tonumber(limit) or 10
    )
    
    local current_group = nil
    local last_date = nil
    local count = 0
    
    for _, log in ipairs(logs) do
        local date = log.date
        log.date = nil
        
        local device_map = XQMiwifiLog.get_device_map()
        log.dev = device_map[log.mac] or ""
        
        if date ~= last_date then
            current_group = {
                date = date,
                data = {}
            }
            table.insert(result.info, current_group)
            last_date = date
        end
        
        table.insert(current_group.data, log)
        count = count + 1
    end
    
    result.count = count
    http.write_json(result)
end
