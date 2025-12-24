--[[
  小米路由器 - 日志管理模块
  功能: 提供安全日志的查询、解析、删除等功能
  用于记录和展示路由器的安全事件、设备连接、系统状态等日志
]]

local MiwifiLog = {}

-- 引入依赖模块
local cjson = require("cjson")

-- SQL查询模板定义
local SQL_COUNT_BY_PREFIX = "SELECT COUNT(*) AS matching_count FROM TAG WHERE NAME LIKE '%s%%';"
local SQL_DELETE_TAG_BY_IDS = "DELETE FROM TAG WHERE LOG_ID IN (%s);"
local SQL_DELETE_LOG_BY_IDS = "DELETE FROM LOG WHERE ID IN (%s);"

-- 获取指定天数内的日志ID范围
local SQL_GET_ID_RANGE_BY_DAYS = [[
	SELECT COALESCE(MAX(ID), 0) AS max_id, COALESCE(MIN(ID), 0) AS min_id
	FROM
		LOG
	WHERE
		TIMESTAMP >= DATE('now', '-%d days', 'localtime');
]]

-- 按ID范围删除标签
local SQL_DELETE_TAG_BY_ID_RANGE = "DELETE FROM TAG WHERE LOG_ID <= %d AND LOG_ID >= %d;"
-- 按ID范围删除日志
local SQL_DELETE_LOG_BY_ID_RANGE = "DELETE FROM LOG WHERE ID <= %d AND ID >= %d;"

-- 按ID范围和前缀删除标签
local SQL_DELETE_TAG_BY_RANGE_AND_PREFIX = [[
	DELETE FROM TAG WHERE LOG_ID <= %d AND LOG_ID >= %d AND LOG_ID IN (
		SELECT LOG_ID FROM TAG WHERE TAG.NAME LIKE '%s%%'
	)
]]

-- 删除没有标签的日志
local SQL_DELETE_ORPHAN_LOGS = "\tDELETE FROM LOG WHERE ID <= %d AND ID >= %d AND ID NOT IN (SELECT LOG_ID FROM TAG)\n"

-- 按条件统计日志数量
local SQL_COUNT_LOGS = [[
	SELECT COUNT(*)
	FROM
		LOG AS L
	JOIN
		TAG AS T
	ON
		L.ID = T.LOG_ID
	WHERE
		DATE(L.TIMESTAMP) >= DATE('now', '-%d days', 'localtime')
		AND L.TIMESTAMP <= DATETIME(%s, 'unixepoch')
		AND T.NAME LIKE '%s%%';
]]

-- 查询日志列表
local SQL_GET_LOGS = [[
	SELECT
		DATE(L.TIMESTAMP, 'localtime') AS date,
		strftime('%%H:%%M', L.TIMESTAMP, 'localtime') AS time,
		strftime('%%s', L.TIMESTAMP) AS ts,
		L.ID AS id,
		L.MSG AS msg
	FROM
		LOG AS L
	JOIN
		TAG AS T
	ON
		L.ID = T.LOG_ID
	WHERE
		DATE(L.TIMESTAMP) >= DATE('now', '-%d days', 'localtime')
		AND L.TIMESTAMP <= DATETIME(%s, 'unixepoch')
		AND T.NAME LIKE '%s%%'
	ORDER BY
		L.ID DESC
	LIMIT %d
	OFFSET %d;
]]

-- 国际化函数(如果不存在则创建空实现)
if _ == nil then
    function _(str)
        return str
    end
end

-- 设备名称缓存
local deviceNameCache = nil

--[[
  获取设备名称映射表
  @return table MAC地址到设备名称的映射
]]
function MiwifiLog.get_device_map()
    if deviceNameCache == nil then
        local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
        local _, deviceList = XQDeviceUtil.getDeviceListV2()
        deviceNameCache = {}
        
        for _, device in ipairs(deviceList) do
            if device.name ~= "" then
                deviceNameCache[device.mac] = device.name
            end
        end
    end
    return deviceNameCache
end

--[[
  根据MAC地址获取设备名称
  @param mac MAC地址
  @return string 设备名称或MAC地址本身
]]
local function get_dev_name(mac)
    mac = string.upper(mac)
    local deviceMap = MiwifiLog.get_device_map()
    return deviceMap[mac] or mac
end

--[[
  格式化时间戳为可读时间
  @param timestamp Unix时间戳
  @return string 格式化后的时间字符串
]]
local function get_time(timestamp)
    return os.date("%Y-%m-%d %H:%M", timestamp)
end

-- 日志类型配置表
-- 定义各种安全事件的显示模板和参数映射
local LOG_TYPE_CONFIG = {
    -- 网关安全风险
    sec_risk_gw = {
        msg = {
            tpl = _("已拦截 %s攻击"),
            arg = {"type"},
            map = {
                type = function(val) return string.upper(val) end
            }
        }
    },
    
    -- 网络拒绝访问攻击
    sec_risk_flood = {
        msg = {
            tpl = _("已拦截 网络拒绝访问攻击")
        },
        ext = {
            tpl = _("%s在%s对%s发起了泛洪攻击"),
            arg = {"mac", "timestamp", "dstmac"},
            map = {
                mac = get_dev_name,
                timestamp = get_time,
                dstmac = get_dev_name
            }
        }
    },
    
    -- 端口扫描攻击
    sec_risk_portscan = {
        msg = {
            tpl = _("已拦截 恶意流量攻击")
        },
        ext = {
            tpl = _("%s在%s对%s发起了端口扫描"),
            arg = {"mac", "timestamp", "dstmac"},
            map = {
                mac = get_dev_name,
                timestamp = get_time,
                dstmac = get_dev_name
            }
        }
    },
    
    -- IP扫描攻击
    sec_risk_ipscan = {
        msg = {
            tpl = _("已拦截 恶意流量攻击")
        },
        ext = {
            tpl = _("%s在%s发起了IP扫描"),
            arg = {"mac", "timestamp"},
            map = {
                mac = get_dev_name,
                timestamp = get_time
            }
        }
    },
    
    -- 网页安全风险
    sec_risk_web = {
        msg = {
            tpl = _("%s"),
            arg = {"type"},
            map = {
                type = {
                    reject = _("屏蔽单独访问"),
                    log = _("允许单独访问"),
                    whitelist = _("加入访问白名单")
                }
            }
        },
        ext = {
            tpl = _("%s"),
            arg = {"url"}
        }
    },
    
    -- 系统重启
    sec_sys_restart = {
        msg = {
            tpl = _("重新启动")
        }
    },
    
    -- 网络连接状态
    sec_sys_internet = {
        msg = {
            tpl = _("网络%s"),
            arg = {"connected"},
            map = {
                connected = {
                    ["false"] = _("断开"),
                    ["true"] = _("重连")
                }
            }
        }
    },
    
    -- 加入Mesh网络
    sec_sys_addre = {
        msg = {
            tpl = _("加入了Mesh网络")
        }
    },
    
    -- WiFi密码修改
    sec_sys_wlanpwd = {
        msg = {
            tpl = _("修改网络密码")
        }
    },
    
    -- 设备联网限制
    sec_nic_internet = {
        msg = {
            tpl = _("%s限制联网"),
            arg = {"restricted"},
            map = {
                restricted = {
                    ["false"] = _("解除"),
                    ["true"] = _("被")
                }
            }
        }
    },
    
    -- 设备连接状态
    sec_nic_connect = {
        msg = {
            tpl = _("已%s"),
            arg = {"connected"},
            map = {
                connected = {
                    ["false"] = _("断开"),
                    ["true"] = _("上线")
                }
            }
        }
    },
    
    -- 设备黑名单
    sec_nic_blacklist = {
        msg = {
            tpl = _("被%s黑名单"),
            arg = {"enabled"},
            map = {
                enabled = {
                    ["false"] = _("解除"),
                    ["true"] = _("加入")
                }
            }
        }
    },
    
    -- 设备白名单
    sec_nic_whitelist = {
        msg = {
            tpl = _("被%s白名单"),
            arg = {"enabled"},
            map = {
                enabled = {
                    ["false"] = _("解除"),
                    ["true"] = _("加入")
                }
            }
        }
    }
}

--[[
  检查SQL注入风险
  @param str 要检查的字符串
  @return boolean 存在风险返回true
]]
local function is_sql_hack(str)
    return string.find(str, "'") ~= nil
end

--[[
  执行SQL查询
  @param sql SQL语句
  @return table 查询结果
]]
function MiwifiLog.exec_sql(sql)
    local ubus = require("ubus")
    local result = {}
    local conn = ubus.connect()
    
    if not conn then
        return result
    end
    
    local response = conn:call("miwifi-logd", "query", {sql = sql})
    if response.code == 0 then
        result = response.result
    end
    
    return result
end

--[[
  从SQL查询获取统计值
  @param sql SQL语句
  @param expectedCount 期望的返回值数量
  @return ... 查询结果
]]
function MiwifiLog.get_stat_from_sql(sql, expectedCount)
    local result = MiwifiLog.exec_sql(sql)
    
    if #result == 0 then
        local defaults = {}
        for i = 1, expectedCount do
            defaults[i] = 0
        end
        return unpack(defaults)
    end
    
    return unpack(result)
end

--[[
  按前缀统计日志数量
  @param prefix 标签前缀
  @return number 匹配的日志数量
]]
function MiwifiLog.get_cnt_by_prefix(prefix)
    if is_sql_hack(prefix) then
        return 0
    end
    
    local sql = string.format(SQL_COUNT_BY_PREFIX, prefix)
    local count = MiwifiLog.get_stat_from_sql(sql, 1)
    return tonumber(count) or 0
end

--[[
  从字符串解析ID列表
  @param idStr ID字符串(逗号分隔)
  @return table ID数组
]]
function MiwifiLog.get_ids_from_str(idStr)
    local ids = {}
    for id in string.gmatch(idStr, "%d+") do
        table.insert(ids, tonumber(id))
    end
    return ids
end

--[[
  按ID列表删除日志
  @param idStr ID字符串(逗号分隔)
]]
function MiwifiLog.del_by_ids(idStr)
    local ids = MiwifiLog.get_ids_from_str(idStr)
    local idList = table.concat(ids, ",")
    
    -- 先删除标签
    MiwifiLog.exec_sql(string.format(SQL_DELETE_TAG_BY_IDS, idList))
    -- 再删除日志
    MiwifiLog.exec_sql(string.format(SQL_DELETE_LOG_BY_IDS, idList))
end

--[[
  按天数删除日志
  @param days 保留天数
  @param prefix 可选的标签前缀(只删除匹配的日志)
]]
function MiwifiLog.del_by_days(days, prefix)
    -- 检查SQL注入
    if prefix then
        if is_sql_hack(prefix) then
            return
        end
    end
    
    -- 获取ID范围
    local sql = string.format(SQL_GET_ID_RANGE_BY_DAYS, days - 1)
    local maxId, minId = MiwifiLog.get_stat_from_sql(sql, 2)
    
    if type(prefix) == "string" then
        -- 按前缀删除
        MiwifiLog.exec_sql(string.format(SQL_DELETE_TAG_BY_RANGE_AND_PREFIX, maxId, minId, prefix))
        MiwifiLog.exec_sql(string.format(SQL_DELETE_ORPHAN_LOGS, maxId, minId))
    else
        -- 删除所有
        MiwifiLog.exec_sql(string.format(SQL_DELETE_TAG_BY_ID_RANGE, maxId, minId))
        MiwifiLog.exec_sql(string.format(SQL_DELETE_LOG_BY_ID_RANGE, maxId, minId))
    end
end

--[[
  格式化显示字符串
  @param config 配置表(包含tpl模板、arg参数列表、map映射表)
  @param data   数据表
  @return string 格式化后的字符串
]]
function MiwifiLog.format_display_str(config, data)
    local args = {}
    local tpl = config.tpl
    local map = config.map or {}
    local argList = config.arg or {}
    
    if tpl == nil then
        return nil
    end
    
    -- 处理每个参数
    for _, argName in ipairs(argList) do
        local value = data[argName]
        local mapType = type(map[argName])
        
        if mapType == "table" then
            -- 表映射: 根据值查找对应的显示文本
            if type(value) ~= "string" then
                value = tostring(value)
            end
            value = map[argName][value] or value
        elseif mapType == "function" then
            -- 函数映射: 调用函数转换值
            value = map[argName](value) or value
        end
        
        table.insert(args, value)
    end
    
    -- 格式化字符串
    if #argList > 0 then
        return string.format(tpl, unpack(args))
    else
        return tpl
    end
end

--[[
  解析JSON格式的日志消息
  @param timestamp 时间戳
  @param jsonMsg   JSON格式的消息
  @return string, string, string, string 标签、消息、扩展信息、MAC地址
]]
function MiwifiLog.parse_json_msg(timestamp, jsonMsg)
    local data = cjson.decode(jsonMsg)
    local msg = ""
    local ext = ""
    local mac = ""
    
    -- 检查标签是否存在
    if data.tag == nil then
        return "", jsonMsg, "", ""
    end
    
    -- 如果没有时间戳，使用传入的时间戳
    if data.timestamp == nil then
        data.timestamp = tonumber(timestamp)
    end
    
    -- 获取日志类型配置
    local config = LOG_TYPE_CONFIG[data.tag]
    
    -- 格式化主消息
    msg = MiwifiLog.format_display_str(config.msg or {}, data)
    
    -- 格式化扩展信息
    ext = MiwifiLog.format_display_str(config.ext or {}, data)
    
    -- 获取MAC地址
    mac = string.upper(data.mac or "")
    
    return data.tag, msg, ext, mac
end

--[[
  获取日志数量
  @param days      查询天数
  @param timestamp 截止时间戳
  @param prefix    标签前缀
  @return number 日志数量
]]
function MiwifiLog.get_logs_cnt(days, timestamp, prefix)
    local sql = string.format(SQL_COUNT_LOGS, days - 1, timestamp, prefix)
    local count = MiwifiLog.get_stat_from_sql(sql, 1)
    return tonumber(count) or 0
end

--[[
  获取日志列表
  @param days      查询天数
  @param timestamp 截止时间戳
  @param prefix    标签前缀
  @param limit     返回数量限制
  @param offset    偏移量
  @return table 日志列表
]]
function MiwifiLog.get_logs(days, timestamp, prefix, limit, offset)
    -- 检查SQL注入
    if is_sql_hack(prefix) then
        return {}
    end
    
    local logs = {}
    local sql = string.format(SQL_GET_LOGS, days - 1, timestamp, prefix, limit, offset)
    local result = MiwifiLog.exec_sql(sql)
    
    for _, row in ipairs(result) do
        local jsonMsg = row[5]
        local tag, msg, ext, mac = MiwifiLog.parse_json_msg(row[3], jsonMsg)
        
        table.insert(logs, {
            date = row[1],      -- 日期
            time = row[2],      -- 时间
            ts = row[3],        -- 时间戳
            id = row[4],        -- 日志ID
            type = tag,         -- 日志类型
            msg = msg,          -- 主消息
            ext = ext,          -- 扩展信息
            mac = mac,          -- MAC地址
            dev = mac           -- 设备标识(与MAC相同)
        })
    end
    
    return logs
end

return MiwifiLog
