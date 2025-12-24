--[[
LuCI UCI配置接口扩展模块 (luci.model.uci)

本模块扩展了UCI (Unified Configuration Interface) cursor的功能，
提供了更便捷的配置操作方法。

主要功能:
- apply(): 应用配置更改并触发重载
- delete_all(): 批量删除符合条件的配置节
- section(): 创建或更新配置节
- tset(): 批量设置配置选项
- get_bool(): 获取布尔类型配置值
- get_list(): 获取列表类型配置值
- set_list(): 设置列表类型配置值
- get_first(): 获取第一个匹配的配置值
- substate(): 获取状态子游标
- _affected(): 获取受影响的配置文件列表

依赖模块:
- os: 系统操作
- uci: UCI核心库
- luci.util: LuCI工具函数
- table: 表操作

作者: LuCI开发团队
]]--

local os = require("os")
local uci = require("uci")
local util = require("luci.util")
local table = require("table")

local setmetatable = setmetatable
local rawget = rawget
local rawset = rawset
local require = require
local getmetatable = getmetatable
local error = error
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber
local unpack = unpack

module("luci.model.uci")

-- 导出UCI cursor构造函数
cursor = uci.cursor

-- 导出UCI API版本号
APIVERSION = uci.APIVERSION

-- 创建带状态的UCI cursor
-- 状态文件存储在 /var/state 目录
-- @return UCI cursor对象，带状态支持
function cursor_state()
    return cursor(nil, "/var/state")
end

-- 创建默认的UCI实例
inst = cursor()

-- 创建默认的带状态UCI实例
inst_state = cursor_state()

-- 获取UCI cursor的元表并扩展方法
local cursor_meta = getmetatable(inst)

-- 应用配置更改
-- 调用 /sbin/luci-reload 脚本重载受影响的服务
-- @param self UCI cursor对象
-- @param configlist 配置文件列表(可选)
-- @param async 是否异步执行(可选)
-- @return 异步模式返回命令数组，同步模式返回执行结果
function cursor_meta.apply(self, configlist, async)
    local affected_configs = self:_affected(configlist)
    
    if async then
        -- 异步模式: 返回命令数组供后续执行
        return {
            "/sbin/luci-reload",
            unpack(affected_configs)
        }
    else
        -- 同步模式: 立即执行重载命令
        local cmd = "/sbin/luci-reload %s >/dev/null 2>&1" % table.concat(affected_configs, " ")
        return os.execute(cmd)
    end
end

-- 批量删除符合条件的配置节
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section_type 配置节类型
-- @param filter_func 过滤函数(可选)，返回true表示删除该节
function cursor_meta.delete_all(self, config, section_type, filter_func)
    local to_delete = {}
    
    -- 如果filter_func是表，转换为匹配函数
    if type(filter_func) == "table" then
        local match_table = filter_func
        filter_func = function(section)
            for key, value in pairs(match_table) do
                if section[key] ~= value then
                    return false
                end
            end
            return true
        end
    end
    
    -- 收集要删除的配置节名称
    local collect_func = function(section)
        if filter_func then
            if not filter_func(section) then
                return
            end
        end
        to_delete[#to_delete + 1] = section[".name"]
    end
    
    self:foreach(config, section_type, collect_func)
    
    -- 执行删除操作
    for _, section_name in ipairs(to_delete) do
        self:delete(config, section_name)
    end
end

-- 创建或更新配置节
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section_type 配置节类型
-- @param section_name 配置节名称(可选，nil则自动生成)
-- @param values 配置值表(可选)
-- @return 成功返回配置节名称，失败返回nil
function cursor_meta.section(self, config, section_type, section_name, values)
    local success = true
    
    if section_name then
        -- 命名配置节: 使用set创建
        success = self:set(config, section_name, section_type)
    else
        -- 匿名配置节: 使用add创建
        section_name = self:add(config, section_type)
        success = section_name and true or success
        if section_name then
            success = true
        end
    end
    
    -- 设置配置值
    if success and values then
        success = self:tset(config, section_name, values)
    end
    
    if success then
        return section_name
    end
    return nil
end

-- 批量设置配置选项
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section_name 配置节名称
-- @param values 配置值表
-- @return 成功返回true，失败返回false
function cursor_meta.tset(self, config, section_name, values)
    local success = true
    
    for key, value in pairs(values) do
        -- 跳过以"."开头的元数据字段
        local first_char = key:sub(1, 1)
        if first_char ~= "." and success then
            success = self:set(config, section_name, key, value)
        end
    end
    
    return success
end

-- 获取布尔类型配置值
-- @param self UCI cursor对象
-- @param ... 传递给get的参数
-- @return 布尔值
function cursor_meta.get_bool(self, ...)
    local value = self:get(...)
    return value == "1" or value == "true" or value == "yes" or value == "on"
end

-- 获取列表类型配置值
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section 配置节名称
-- @param option 配置选项名
-- @return 列表(数组)，如果不是列表则包装成单元素数组
function cursor_meta.get_list(self, config, section, option)
    if config and section and option then
        local value = self:get(config, section, option)
        local value_type = type(value)
        
        if value_type ~= "table" or not value then
            -- 非表类型或nil，包装成数组
            return { value }
        end
        return value
    end
    return nil
end

-- 获取第一个匹配的配置值
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section_type 配置节类型
-- @param option 配置选项名(可选，nil则返回节名)
-- @param expected_type 期望的值类型(可选，number或boolean)
-- @return 找到的值或nil
function cursor_meta.get_first(self, config, section_type, option, expected_type)
    local result = expected_type
    
    local search_func = function(section)
        local value
        
        if not option then
            -- 没有指定选项，返回节名
            value = section[".name"]
        else
            value = section[option]
        end
        
        -- 类型转换
        if type(expected_type) == "number" then
            value = tonumber(value)
        elseif type(expected_type) == "boolean" then
            value = value == "1" or value == "true" or value == "yes" or value == "on"
        end
        
        if value ~= nil then
            result = value
            return false  -- 停止遍历
        end
    end
    
    self:foreach(config, section_type, search_func)
    return result
end

-- 设置列表类型配置值
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param section 配置节名称
-- @param option 配置选项名
-- @param value 值(字符串或数组)
-- @return 成功返回true，失败返回false
function cursor_meta.set_list(self, config, section, option, value)
    if config and section and option then
        local list_value
        if type(value) ~= "table" or not value then
            -- 非表类型，包装成数组
            list_value = { value }
        else
            list_value = value
        end
        return self:set(config, section, option, list_value)
    end
    return false
end

-- 获取受影响的配置文件列表
-- 递归查找所有相关的配置文件
-- @param self UCI cursor对象
-- @param configlist 初始配置文件列表
-- @return 去重后的受影响配置文件列表
function cursor_meta._affected(self, configlist)
    -- 确保configlist是数组
    if type(configlist) ~= "table" or not configlist then
        configlist = { configlist }
    end
    
    -- 创建新的cursor加载配置
    local uci_cursor = cursor()
    uci_cursor:load("ucitrack")
    
    local affected = {}
    
    -- 递归查找依赖的配置文件
    local function find_dependencies(config_name)
        local deps = { config_name }
        local result = {}
        
        -- 查找ucitrack中的依赖关系
        uci_cursor:foreach("ucitrack", config_name, function(section)
            if section.affects then
                for _, dep in ipairs(section.affects) do
                    deps[#deps + 1] = dep
                end
            end
        end)
        
        -- 递归处理依赖
        for _, dep in ipairs(deps) do
            local sub_deps = find_dependencies(dep)
            for _, sub_dep in ipairs(sub_deps) do
                result[#result + 1] = sub_dep
            end
        end
        
        return result
    end
    
    -- 处理所有配置文件
    for _, config in ipairs(configlist) do
        local deps = find_dependencies(config)
        for _, dep in ipairs(deps) do
            -- 去重
            if not util.contains(affected, dep) then
                affected[#affected + 1] = dep
            end
        end
    end
    
    return affected
end

-- 获取状态子游标
-- 用于管理多个配置文件的状态
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @return 状态子游标
function cursor_meta.substate(self, config)
    -- 初始化子状态存储
    self._substates = self._substates or {}
    
    -- 如果不存在则创建新的状态cursor
    if not self._substates[config] then
        self._substates[config] = cursor_state()
    end
    
    return self._substates[config]
end

-- 保存原始的load方法
local original_load = cursor_meta.load

-- 扩展load方法，同时加载子状态
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param ... 其他参数
function cursor_meta.load(self, config, ...)
    -- 加载子状态
    if self._substates then
        if self._substates[config] then
            original_load(self._substates[config], ...)
        end
    end
    
    -- 调用原始load
    return original_load(self, ...)
end

-- 保存原始的unload方法
local original_unload = cursor_meta.unload

-- 扩展unload方法，同时卸载子状态
-- @param self UCI cursor对象
-- @param config 配置文件名
-- @param ... 其他参数
function cursor_meta.unload(self, config, ...)
    -- 卸载子状态
    if self._substates then
        if self._substates[config] then
            original_unload(self._substates[config], ...)
        end
    end
    
    -- 调用原始unload
    return original_unload(self, ...)
end
