-- ============================================================================
-- 小米路由器数据库工具模块
-- 提供设备信息的数据库存储和查询功能
-- 支持 SQLite 数据库和 UCI 配置文件两种存储方式
-- ============================================================================

module("xiaoqiang.util.XQDBUtil", package.seeall)

-- 尝试加载 SQLite 库（可能不存在）
local sqliteLoaded, SQLite = pcall(require, "lsqlite3")

-- 数据库文件路径
local DB_PATH = "/etc/xqDb"

-- 加载依赖模块
local uci = require("luci.model.uci").cursor()
local XQLog = require("xiaoqiang.XQLog")

-- 日志级别常量
DEBUG = 7
INFO = 6
NOTICE = 5
WARN = 4
ERROR = 3
CRIT = 2

local datatypes = require("luci.cbi.datatypes")

-- ============================================================================
-- 设备信息管理函数（UCI 配置文件方式）
-- ============================================================================

-- 保存设备信息到 UCI 配置文件
-- @param mac string - 设备 MAC 地址
-- @param oname string - 设备原始名称
-- @param nickname string - 设备昵称
-- @param company string - 设备厂商
-- @return boolean - 是否保存成功
function conf_saveDeviceInfo(mac, oname, nickname, company)
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return false
    end
    
    -- 生成配置节名称：去掉冒号的 MAC 地址 + "_INFO"
    local sectionName = mac:gsub(":", "") .. "_INFO"
    
    -- 构建设备信息
    local deviceInfo = {
        mac = mac,
        oname = oname,
        nickname = nickname,
        company = company
    }
    
    -- 保存到 UCI 配置
    uci:section("devicelist", "deviceinfo", sectionName, deviceInfo)
    return uci:commit("devicelist")
end

-- 保存设备信息（自动选择存储方式）
-- @param mac string - 设备 MAC 地址
-- @param oname string - 设备原始名称
-- @param nickname string - 设备昵称
-- @param company string - 设备厂商
-- @param ownerId string - 设备所有者 ID
function saveDeviceInfo(mac, oname, nickname, company, ownerId)
    -- 如果 SQLite 不可用，使用 UCI 配置方式
    if not sqliteLoaded then
        return conf_saveDeviceInfo(mac, oname, nickname, company)
    end
    
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return
    end
    
    -- 打开数据库
    local db = SQLite.open(DB_PATH)
    
    -- 检查设备是否已存在
    local sql = string.format("select * from DEVICE_INFO where MAC = '%s'", mac)
    local exists = false
    for row in db:nrows(sql) do
        if row then
            exists = true
        end
    end
    
    -- 根据是否存在执行插入或更新
    local execSql
    if not exists then
        execSql = string.format(
            "INSERT INTO DEVICE_INFO (MAC, ONAME, NICKNAME, COMPANY, OWNERID) VALUES ('%s', '%s', '%s', '%s', '%s')",
            mac, oname, nickname, company, ownerId
        )
    else
        execSql = string.format(
            "UPDATE DEVICE_INFO SET ONAME='%s', NICKNAME='%s', COMPANY='%s', OWNERID='%s' WHERE MAC='%s'",
            oname, nickname, company, ownerId, mac
        )
    end
    
    db:exec(execSql)
    return db:close()
end

-- 更新设备昵称（UCI 配置文件方式）
-- @param mac string - 设备 MAC 地址
-- @param nickname string - 新昵称
-- @return boolean - 是否更新成功
function conf_updateDeviceNickname(mac, nickname)
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return false
    end
    
    -- 生成配置节名称
    local sectionName = mac:gsub(":", "") .. "_INFO"
    
    -- 检查设备是否存在
    local deviceInfo = uci:get_all("devicelist", sectionName)
    if deviceInfo then
        return uci:set("devicelist", "key", "nickname", nickname)
    end
    
    return false
end

-- 更新设备昵称（自动选择存储方式）
-- @param mac string - 设备 MAC 地址
-- @param nickname string - 新昵称
function updateDeviceNickname(mac, nickname)
    -- 如果 SQLite 不可用，使用 UCI 配置方式
    if not sqliteLoaded then
        return conf_updateDeviceNickname(mac, nickname)
    end
    
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return
    end
    
    -- 打开数据库并执行更新
    local db = SQLite.open(DB_PATH)
    local sql = string.format("update DEVICE_INFO set NICKNAME = '%s' where MAC = '%s'", nickname, mac)
    db:exec(sql)
    return db:close()
end

-- 获取设备信息（UCI 配置文件方式）
-- @param mac string - 设备 MAC 地址
-- @return table - 设备信息表
function conf_fetchDeviceInfo(mac)
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return {}
    end
    
    -- 生成配置节名称
    local sectionName = mac:gsub(":", "") .. "_INFO"
    
    -- 从 UCI 获取设备信息
    local deviceInfo = uci:get_all("devicelist", sectionName)
    if deviceInfo then
        return {
            mac = deviceInfo.mac or "",
            oName = deviceInfo.oname or "",
            nickname = deviceInfo.nickname or "",
            company = deviceInfo.company or "",
            ownnerId = ""
        }
    end
    
    return {}
end

-- 获取设备信息（自动选择存储方式）
-- @param mac string - 设备 MAC 地址
-- @return table - 设备信息表
function fetchDeviceInfo(mac)
    -- 如果 SQLite 不可用，使用 UCI 配置方式
    if not sqliteLoaded then
        return conf_fetchDeviceInfo(mac)
    end
    
    -- 验证 MAC 地址格式
    if not datatypes.macaddr(mac) then
        return
    end
    
    -- 打开数据库并查询
    local db = SQLite.open(DB_PATH)
    local sql = string.format("select * from DEVICE_INFO where MAC = '%s'", mac)
    local result = {}
    
    for row in db:nrows(sql) do
        if row then
            result = {
                mac = row[1],
                oName = row[2],
                nickname = row[3],
                company = row[4],
                ownnerId = row[5]
            }
        end
    end
    
    db:close()
    return result
end

-- 获取所有设备信息（UCI 配置文件方式）
-- @return table - 设备信息列表
function conf_fetchAllDeviceInfo()
    local devices = {}
    
    uci:foreach("devicelist", "deviceinfo", function(section)
        table.insert(devices, {
            mac = section.mac or "",
            oName = section.oname or "",
            nickname = section.nickname or "",
            company = section.company or "",
            ownnerId = ""
        })
    end)
    
    return devices
end

-- 获取所有设备信息（自动选择存储方式）
-- @return table - 设备信息列表
function fetchAllDeviceInfo()
    -- 如果 SQLite 不可用，使用 UCI 配置方式
    if not sqliteLoaded then
        return conf_fetchAllDeviceInfo()
    end
    
    -- 打开数据库
    local db = SQLite.open(DB_PATH)
    local sql = string.format("select * from DEVICE_INFO")
    local devices = {}
    
    if not db then
        return devices
    end
    
    -- 遍历所有设备记录
    for row in db:nrows(sql) do
        if row then
            -- 验证 MAC 地址格式
            if datatypes.macaddr(row[1]) then
                table.insert(devices, {
                    mac = row[1],
                    oName = row[2],
                    nickname = row[3],
                    company = row[4],
                    ownnerId = row[5]
                })
            end
        end
    end
    
    db:close()
    return devices
end

-- ============================================================================
-- SQLite 数据库操作函数
-- ============================================================================

-- 执行 SQL 命令（带重试机制）
-- @param sql string - SQL 语句
-- @param db userdata - 可选，数据库连接对象
-- @return boolean - 是否执行成功
function sql_exec(sql, db)
    local socket = require("socket")
    local result = nil
    
    if sql == nil then
        return false
    end
    
    -- 如果没有传入数据库连接，则打开新连接
    local conn
    if db ~= nil then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    -- 执行 SQL
    local execResult = conn:exec(sql)
    
    -- 如果执行失败，进行重试
    if execResult ~= SQLite.OK then
        local retryCount = 0
        repeat
            -- 等待 100ms 后重试
            socket.select(nil, nil, 0.1)
            execResult = conn:exec(sql)
            retryCount = retryCount + 1
        until execResult == SQLite.OK or retryCount >= 3
        
        -- 检查重试结果
        if execResult ~= SQLite.OK then
            XQLog.log(ERROR, string.format(
                "SQLite cmd retry[%d] exec failed[%s] resson[%s]",
                retryCount, sql, conn:errmsg()
            ))
            result = false
        else
            XQLog.log(INFO, string.format("SQLite cmd retry[%d] exec success", retryCount))
            result = true
        end
    else
        XQLog.log(INFO, string.format("SQLite cmd[%s] exec success", sql))
        result = true
    end
    
    -- 如果是新打开的连接，则关闭
    if not db then
        conn:close()
    end
    
    return result
end

-- 检查表是否存在
-- @param tableName string - 表名
-- @param db userdata - 可选，数据库连接对象
-- @return boolean - 表是否存在
function table_is_exist(tableName, db)
    local conn
    if db then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    local sql = string.format("select name from sqlite_master where name = '%s'", tableName)
    local exists = {}
    
    for row in conn:nrows(sql) do
        exists = row
    end
    
    local result
    if exists == nil then
        result = false
    else
        result = true
    end
    
    if not db then
        conn:close()
    end
    
    return result
end

-- 打印表内容（调试用）
-- @param tableName string - 表名
-- @param db userdata - 可选，数据库连接对象
function table_dump(tableName, db)
    local conn
    if db then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    local sql = string.format("select * from '%s'", tableName)
    local cjson = require("cjson")
    local rows = {}
    
    for row in conn:nrows(sql) do
        XQLog.log(DEBUG, cjson.encode(row))
    end
    
    if not db then
        conn:close()
    end
end

-- ============================================================================
-- VIP 设备推送相关函数
-- ============================================================================

-- 创建设备推送信息表
-- @param db userdata - 可选，数据库连接对象
-- @return boolean - 是否创建成功
function table_create(db)
    local conn
    if db then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    -- 创建表的 SQL 语句
    local sql = string.format([[
        CREATE TABLE DEVICE_PUSH_INFO (
            MAC TEXT PRIMARY KEY NOT NULL,
            STATUS TEXT,
            TIME INTEGER,
            ACTION TEXT,
            PUSHTIME INTEGER,
            LAST_ACTION TEXT,
            NAME TEXT
        );
    ]])
    
    local result
    if sql_exec(sql, conn) == false then
        XQLog.log(ERROR, "[vip push]create table for DEVICE_PUSH_INFO error")
        result = false
    else
        result = true
    end
    
    if not db then
        conn:close()
    end
    
    return result
end

-- 设置设备待推送状态
-- @param mac string - 设备 MAC 地址
-- @param action string - 动作类型
-- @param db userdata - 可选，数据库连接对象
-- @return boolean - 是否设置成功
function set_pending_status(mac, action, db)
    local conn
    if db then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    -- MAC 地址转大写
    mac = string.upper(mac)
    
    -- 检查设备是否已存在
    local sql = string.format("select * from DEVICE_PUSH_INFO where MAC = '%s'", mac)
    local exists = false
    for row in conn:nrows(sql) do
        if row then
            exists = true
        end
    end
    
    local execSql
    local currentTime = os.time()
    
    if not exists then
        -- 插入新记录
        execSql = string.format(
            "INSERT INTO DEVICE_PUSH_INFO (MAC, STATUS, TIME, ACTION) VALUES ('%s', 'pending', %d, '%s')",
            string.upper(mac), currentTime, action
        )
    else
        -- 更新现有记录
        execSql = string.format(
            "UPDATE DEVICE_PUSH_INFO SET STATUS='pending', TIME=%d, ACTION='%s' WHERE MAC='%s'",
            currentTime, action, mac
        )
    end
    
    local result = sql_exec(execSql, conn)
    
    if not db then
        conn:close()
    end
    
    return result
end

-- 设置设备待推送状态（带设备名称）
-- @param mac string - 设备 MAC 地址
-- @param name string - 设备名称
-- @param action string - 动作类型
-- @param db userdata - 可选，数据库连接对象
-- @return boolean - 是否设置成功
function set_pending_status_with_name(mac, name, action, db)
    local conn
    if db then
        conn = db
    else
        conn = SQLite.open(DB_PATH)
    end
    
    -- MAC 地址转大写
    mac = string.upper(mac)
    
    -- 检查设备是否已存在
    local sql = string.format("select * from DEVICE_PUSH_INFO where MAC = '%s'", mac)
    local exists = false
    for row in conn:nrows(sql) do
        if row then
            exists = true
        end
    end
    
    local execSql
    local currentTime = os.time()
    
    if not exists then
        -- 插入新记录
        execSql = string.format(
            "INSERT INTO DEVICE_PUSH_INFO (MAC, STATUS, TIME, ACTION, NAME) VALUES ('%s', 'pending', %d, '%s', '%s')",
            string.upper(mac), currentTime, action, name
        )
    else
        -- 更新现有记录
        execSql = string.format(
            "UPDATE DEVICE_PUSH_INFO SET STATUS='pending', TIME=%d, ACTION='%s', NAME='%s' WHERE MAC='%s'",
            currentTime, action, name, mac
        )
    end
    
    local result = sql_exec(execSql, conn)
    
    if not db then
        conn:close()
    end
    
    return result
end

-- 唤起推送处理进程
-- 检查 vip_device_push_act.lua 进程是否运行，如果没有则启动
function call_push_action_up()
    local luciUtil = require("luci.util")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    -- 检查进程是否存在
    local processExists = tonumber(luciUtil.exec(
        "ps | grep -v grep | grep vip_device_push_act.lua 2>&1 > /dev/null; echo $?"
    ))
    
    if processExists == 1 then
        -- 进程不存在，启动它
        XQLog.log(6, "can not found processon 'vip_device_push_act.lua' call it up")
        XQFunction.forkExec("vip_device_push_act.lua")
    else
        -- 进程已存在
        XQLog.log(4, "vip_device_push_act.lua exist")
    end
end

-- VIP 设备预推送
-- 设置设备的待推送状态并唤起推送处理进程
-- @param mac string - 设备 MAC 地址
-- @param name string - 可选，设备名称
-- @param action string - 动作类型
function vip_device_pre_push(mac, name, action)
    -- 参数验证
    if mac == nil or action == nil then
        return nil
    end
    
    -- 打开数据库
    local db = SQLite.open(DB_PATH)
    if db == nil then
        XQLog.log(ERROR, "[vip push]open db failed")
    end
    
    -- 检查表是否存在
    if not table_is_exist("DEVICE_PUSH_INFO", db) then
        XQLog.log(NOTICE, "[vip push]can't found table named 'DEIVCE_PUSH_INFO'")
        
        -- 创建表
        if not table_create(db) then
            XQLog.log(ERROR, "[vip push]create table error")
            db:close()
            return false
        end
    end
    
    -- 设置待推送状态
    local result
    if name == nil then
        -- 不带设备名称
        result = set_pending_status(mac, action, db)
        if not result then
            XQLog.log(ERROR, "[vip push]set mac[" .. string.upper(mac) .. "] status[pending] error")
        else
            XQLog.log(DEBUG, "[vip push]set mac[" .. string.upper(mac) .. "] status[pending] success,call vip_device_push_act.lua")
            call_push_action_up()
        end
    else
        -- 带设备名称
        result = set_pending_status_with_name(mac, name, action, db)
        if not result then
            XQLog.log(ERROR, "[vip push]set mac[" .. string.upper(mac) .. "] status[pending] error")
        else
            XQLog.log(DEBUG, "[vip push]set mac[" .. string.upper(mac) .. "] status[pending] success,call vip_device_push_act.lua")
            call_push_action_up()
        end
    end
    
    db:close()
end
