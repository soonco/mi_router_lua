--[[
LuCI 防火墙模型模块 (luci.model.firewall)

本模块提供防火墙配置的Lua对象模型，封装了UCI防火墙配置的操作。
支持区域(zone)、转发(forwarding)、规则(rule)和重定向(redirect)的管理。

主要类:
- defaults: 防火墙默认设置类
- zone: 防火墙区域类
- forwarding: 区域间转发类
- rule: 防火墙规则类
- redirect: 端口重定向/NAT类

主要功能:
- init(): 初始化防火墙模型
- get_defaults(): 获取默认设置
- get_zone(): 获取指定区域
- get_zones(): 获取所有区域
- add_zone(): 添加新区域
- del_zone(): 删除区域
- rename_zone(): 重命名区域
- new_zone(): 创建新区域(自动命名)
- del_network(): 从所有区域删除网络

依赖模块:
- luci.template.parser: 模板解析器
- luci.util: LuCI工具函数
- luci.model.uci: UCI配置接口

作者: LuCI开发团队
]]--

local type = type
local pairs = pairs
local ipairs = ipairs
local table = table
local luci = luci
local math = math

local parser = require("luci.template.parser")
local util = require("luci.util")
local uci_model = require("luci.model.uci")

module("luci.model.firewall")

-- 模块私有变量
local uci_cursor = nil      -- UCI cursor实例
local uci_state = nil       -- UCI状态cursor

-- 验证标识符是否有效
-- 标识符只能包含字母、数字和下划线
-- @param id 要验证的标识符
-- @return 有效返回true，无效返回nil
local function _valid_id(id)
    if id then
        local len = #id
        local match = id:match("^[a-zA-Z0-9_]+$")
        return len > 0 and match
    end
    return nil
end

-- 获取UCI配置值(内部函数)
-- @param config 配置文件名
-- @param section 配置节名
-- @param option 配置选项名
-- @return 配置值
local function _get(config, section, option)
    return uci_cursor:get(config, section, option)
end

-- 设置UCI配置值(内部函数)
-- 支持布尔值自动转换
-- @param config 配置文件名
-- @param section 配置节名
-- @param option 配置选项名
-- @param value 配置值(nil则删除)
-- @return 操作结果
local function _set(config, section, option, value)
    if value ~= nil then
        -- 布尔值转换
        if type(value) == "boolean" then
            value = value and "1" or "0"
        end
        return uci_cursor:set(config, section, option, value)
    else
        return uci_cursor:delete(config, section, option)
    end
end

-- 初始化防火墙模型
-- @param cursor UCI cursor实例(可选)
-- @return 模块自身
function init(cursor)
    uci_cursor = cursor or uci_cursor
    if not uci_cursor then
        uci_cursor = uci_model.cursor()
    end
    
    -- 获取状态子游标
    uci_state = uci_cursor:substate()
    
    return _M
end

-- 保存配置更改
-- @param ... 配置文件名列表
function save(...)
    uci_cursor:save(...)
    uci_cursor:load(...)
end

-- 提交配置更改
-- @param ... 配置文件名列表
function commit(...)
    uci_cursor:commit(...)
    uci_cursor:load(...)
end

-- 获取防火墙默认设置
-- @return defaults实例
function get_defaults()
    return defaults()
end

-- 创建新区域(自动生成名称)
-- @param self 模块实例
-- @return zone实例或nil
function new_zone(self)
    local zone_name = "newzone"
    local counter = 1
    
    -- 查找未使用的区域名
    while true do
        local existing = self:get_zone(zone_name)
        if not existing then
            break
        end
        counter = counter + 1
        zone_name = "newzone%d" % counter
    end
    
    return self:add_zone(zone_name)
end

-- 添加新区域
-- @param self 模块实例
-- @param name 区域名称
-- @return zone实例或nil
function add_zone(self, name)
    if not _valid_id(name) then
        return nil
    end
    
    -- 检查区域是否已存在
    if self:get_zone(name) then
        return nil
    end
    
    -- 获取默认策略
    local defs = defaults()
    
    -- 创建区域配置节
    local sid = uci_cursor:section("firewall", "zone", nil, {
        name = name,
        network = " ",
        input = defs:input() or "REJECT",
        forward = defs:forward() or "REJECT",
        output = defs:output() or "ACCEPT"
    })
    
    if sid then
        return zone(sid)
    end
    return nil
end

-- 获取指定区域
-- @param self 模块实例
-- @param name 区域名称或配置节名
-- @return zone实例或nil
function get_zone(self, name)
    -- 首先尝试作为配置节名查找
    local section_type = uci_cursor:get("firewall", name)
    if section_type == "zone" then
        return zone(name)
    end
    
    -- 然后按区域名称查找
    local found_sid = nil
    
    uci_cursor:foreach("firewall", "zone", function(section)
        if name then
            if section.name == name then
                found_sid = section[".name"]
                return false  -- 停止遍历
            end
        end
    end)
    
    if found_sid then
        return zone(found_sid)
    end
    return nil
end

-- 获取所有区域
-- @param self 模块实例
-- @return zone实例数组
function get_zones(self)
    local zones_list = {}
    local zones_map = {}
    
    -- 收集所有区域
    uci_cursor:foreach("firewall", "zone", function(section)
        if section.name then
            zones_map[section.name] = zone(section[".name"])
        end
    end)
    
    -- 按名称排序
    local sorted_names = {}
    for name in pairs(zones_map) do
        sorted_names[#sorted_names + 1] = name
    end
    table.sort(sorted_names)
    
    -- 构建结果数组
    for _, name in ipairs(sorted_names) do
        zones_list[#zones_list + 1] = zones_map[name]
    end
    
    return zones_list
end

-- 根据网络名称获取区域
-- @param self 模块实例
-- @param network 网络名称
-- @return zone实例或nil
function get_zone_by_network(self, network)
    local found_sid = nil
    
    uci_cursor:foreach("firewall", "zone", function(section)
        if section.name then
            if network then
                -- 检查网络列表
                for net in util.imatch(section.network or section.name) do
                    if net == network then
                        found_sid = section[".name"]
                        return false
                    end
                end
            end
        end
    end)
    
    if found_sid then
        return zone(found_sid)
    end
    return nil
end

-- 删除区域
-- 同时删除相关的规则、重定向和转发
-- @param self 模块实例
-- @param name 区域名称或配置节名
-- @return 成功返回true
function del_zone(self, name)
    local deleted = false
    local zone_name = name
    
    -- 检查是否是配置节名
    local section_type = uci_cursor:get("firewall", name)
    if section_type == "zone" then
        zone_name = uci_cursor:get("firewall", name, "name")
        deleted = uci_cursor:delete("firewall", name)
    else
        -- 按区域名称查找并删除
        uci_cursor:foreach("firewall", "zone", function(section)
            if name then
                if section.name == name then
                    deleted = uci_cursor:delete("firewall", section[".name"])
                    return false
                end
            end
        end)
    end
    
    -- 删除相关的规则
    if deleted then
        uci_cursor:foreach("firewall", "rule", function(section)
            if section.src == zone_name or section.dest == zone_name then
                uci_cursor:delete("firewall", section[".name"])
            end
        end)
        
        -- 删除相关的重定向
        uci_cursor:foreach("firewall", "redirect", function(section)
            if section.src == zone_name or section.dest == zone_name then
                uci_cursor:delete("firewall", section[".name"])
            end
        end)
        
        -- 删除相关的转发
        uci_cursor:foreach("firewall", "forwarding", function(section)
            if section.src == zone_name or section.dest == zone_name then
                uci_cursor:delete("firewall", section[".name"])
            end
        end)
    end
    
    return deleted
end

-- 重命名区域
-- 同时更新所有引用该区域的规则、重定向和转发
-- @param self 模块实例
-- @param old_name 原区域名称
-- @param new_name 新区域名称
-- @return 成功返回true
function rename_zone(self, old_name, new_name)
    local renamed = false
    
    if not _valid_id(new_name) then
        return false
    end
    
    -- 检查新名称是否已存在
    if self:get_zone(new_name) then
        return false
    end
    
    -- 查找并重命名区域
    uci_cursor:foreach("firewall", "zone", function(section)
        if old_name then
            if section.name == old_name then
                -- 确保有network字段
                if not section.network then
                    uci_cursor:set("firewall", section[".name"], "network", old_name)
                end
                -- 更新名称
                uci_cursor:set("firewall", section[".name"], "name", new_name)
                renamed = true
                return false
            end
        end
    end)
    
    -- 更新所有引用
    if renamed then
        -- 更新规则
        uci_cursor:foreach("firewall", "rule", function(section)
            if section.src == old_name then
                uci_cursor:set("firewall", section[".name"], "src", new_name)
            end
            if section.dest == old_name then
                uci_cursor:set("firewall", section[".name"], "dest", new_name)
            end
        end)
        
        -- 更新重定向
        uci_cursor:foreach("firewall", "redirect", function(section)
            if section.src == old_name then
                uci_cursor:set("firewall", section[".name"], "src", new_name)
            end
            if section.dest == old_name then
                uci_cursor:set("firewall", section[".name"], "dest", new_name)
            end
        end)
        
        -- 更新转发
        uci_cursor:foreach("firewall", "forwarding", function(section)
            if section.src == old_name then
                uci_cursor:set("firewall", section[".name"], "src", new_name)
            end
            if section.dest == old_name then
                uci_cursor:set("firewall", section[".name"], "dest", new_name)
            end
        end)
    end
    
    return renamed
end

-- 从所有区域删除指定网络
-- @param self 模块实例
-- @param network 网络名称
function del_network(self, network)
    if network then
        local zones_list = self:get_zones()
        for _, z in ipairs(zones_list) do
            z:del_network(network)
        end
    end
end

--------------------------------------------------------------------------------
-- defaults类: 防火墙默认设置
--------------------------------------------------------------------------------

defaults = util.class()

-- 初始化默认设置
-- 查找或创建defaults配置节
function defaults:__init__()
    uci_cursor:foreach("firewall", "defaults", function(section)
        self.sid = section[".name"]
        return false
    end)
    
    -- 如果不存在则创建
    if not self.sid then
        self.sid = uci_cursor:section("firewall", "defaults", nil, {})
    end
end

-- 获取配置值
-- @param option 配置选项名
-- @return 配置值
function defaults:get(option)
    return _get("firewall", self.sid, option)
end

-- 设置配置值
-- @param option 配置选项名
-- @param value 配置值
-- @return 操作结果
function defaults:set(option, value)
    return _set("firewall", self.sid, option, value)
end

-- 获取SYN洪水防护状态
-- @return true表示启用
function defaults:syn_flood()
    return self:get("syn_flood") == "1"
end

-- 获取丢弃无效包状态
-- @return true表示启用
function defaults:drop_invalid()
    return self:get("drop_invalid") == "1"
end

-- 获取默认入站策略
-- @return 策略字符串(ACCEPT/REJECT/DROP)
function defaults:input()
    return self:get("input") or "REJECT"
end

-- 获取默认转发策略
-- @return 策略字符串
function defaults:forward()
    return self:get("forward") or "REJECT"
end

-- 获取默认出站策略
-- @return 策略字符串
function defaults:output()
    return self:get("output") or "ACCEPT"
end

--------------------------------------------------------------------------------
-- zone类: 防火墙区域
--------------------------------------------------------------------------------

zone = util.class()

-- 初始化区域
-- @param sid_or_name 配置节名或区域名
function zone:__init__(sid_or_name)
    local section_type = uci_cursor:get("firewall", sid_or_name)
    
    if section_type == "zone" then
        -- 直接使用配置节名
        self.sid = sid_or_name
        self.data = uci_cursor:get_all("firewall", sid_or_name)
    else
        -- 按区域名查找
        uci_cursor:foreach("firewall", "zone", function(section)
            if section.name == sid_or_name then
                self.sid = section[".name"]
                self.data = section
                return false
            end
        end)
    end
end

-- 获取配置值
function zone:get(option)
    return _get("firewall", self.sid, option)
end

-- 设置配置值
function zone:set(option, value)
    return _set("firewall", self.sid, option, value)
end

-- 获取伪装(NAT)状态
-- @return true表示启用
function zone:masq()
    return self:get("masq") == "1"
end

-- 获取区域名称
-- @return 区域名称字符串
function zone:name()
    return self:get("name")
end

-- 获取关联的网络列表字符串
-- @return 网络列表
function zone:network()
    return self:get("network")
end

-- 获取入站策略
-- @return 策略字符串，未设置则返回默认值
function zone:input()
    local policy = self:get("input")
    if not policy then
        local defs = defaults()
        policy = defs:input() or "REJECT"
    end
    return policy
end

-- 获取转发策略
function zone:forward()
    local policy = self:get("forward")
    if not policy then
        local defs = defaults()
        policy = defs:forward() or "REJECT"
    end
    return policy
end

-- 获取出站策略
function zone:output()
    local policy = self:get("output")
    if not policy then
        local defs = defaults()
        policy = defs:output() or "ACCEPT"
    end
    return policy
end

-- 添加网络到区域
-- @param network 网络名称
function zone:add_network(network)
    local section_type = uci_cursor:get("network", network)
    
    if section_type == "interface" then
        local networks = {}
        local option_name = self:get("network") and "network" or "name"
        
        -- 收集现有网络
        for net in util.imatch(self:get(option_name)) do
            if net ~= network then
                networks[#networks + 1] = net
            end
        end
        
        -- 添加新网络
        networks[#networks + 1] = network
        
        -- 保存
        self:set("network", table.concat(networks, " "))
    end
end

-- 从区域删除网络
-- @param network 网络名称
function zone:del_network(network)
    local networks = {}
    local option_name = self:get("network") and "network" or "name"
    
    -- 收集除目标外的网络
    for net in util.imatch(self:get(option_name)) do
        if net ~= network then
            networks[#networks + 1] = net
        end
    end
    
    -- 保存
    if #networks > 0 then
        self:set("network", table.concat(networks, " "))
    else
        self:set("network", " ")
    end
end

-- 获取关联的网络列表
-- @return 网络名称数组
function zone:get_networks()
    local networks = {}
    local option_name = self:get("network") and "network" or "name"
    
    for net in util.imatch(self:get(option_name)) do
        networks[#networks + 1] = net
    end
    
    return networks
end

-- 清空关联的网络
function zone:clear_networks()
    self:set("network", " ")
end

-- 获取指定方向的转发规则
-- @param direction "src"或"dest"
-- @return forwarding实例数组
function zone:get_forwardings_by(direction)
    local zone_name = self:name()
    local forwardings = {}
    
    uci_cursor:foreach("firewall", "forwarding", function(section)
        if section.src and section.dest then
            if section[direction] == zone_name then
                forwardings[#forwardings + 1] = forwarding(section[".name"])
            end
        end
    end)
    
    return forwardings
end

-- 添加到指定区域的转发
-- @param dest_zone 目标区域名
-- @return forwarding实例或nil
function zone:add_forwarding_to(dest_zone)
    local src_forwardings = self:get_forwardings_by("src")
    
    -- 检查是否已存在
    for _, fwd in ipairs(src_forwardings) do
        if fwd:dest() == dest_zone then
            return nil  -- 已存在
        end
    end
    
    -- 创建新转发
    if dest_zone ~= self:name() then
        local sid = uci_cursor:section("firewall", "forwarding", nil, {
            src = self:name(),
            dest = dest_zone
        })
        if sid then
            return forwarding(sid)
        end
    end
    return nil
end

-- 添加从指定区域的转发
-- @param src_zone 源区域名
-- @return forwarding实例或nil
function zone:add_forwarding_from(src_zone)
    local dest_forwardings = self:get_forwardings_by("dest")
    
    -- 检查是否已存在
    for _, fwd in ipairs(dest_forwardings) do
        if fwd:src() == src_zone then
            return nil
        end
    end
    
    -- 创建新转发
    if src_zone ~= self:name() then
        local sid = uci_cursor:section("firewall", "forwarding", nil, {
            src = src_zone,
            dest = self:name()
        })
        if sid then
            return forwarding(sid)
        end
    end
    return nil
end

-- 删除指定方向的所有转发
-- @param direction "src"或"dest"
function zone:del_forwardings_by(direction)
    local zone_name = self:name()
    
    uci_cursor:delete_all("firewall", "forwarding", function(section)
        if section.src and section.dest then
            return section[direction] == zone_name
        end
        return false
    end)
end

-- 添加重定向规则
-- @param options 配置选项表(可选)
-- @return redirect实例或nil
function zone:add_redirect(options)
    if not options then
        options = {}
    end
    
    options.src = self:name()
    
    local sid = uci_cursor:section("firewall", "redirect", nil, options)
    if sid then
        return redirect(sid)
    end
    return nil
end

-- 添加防火墙规则
-- @param options 配置选项表(可选)
-- @return rule实例或nil
function zone:add_rule(options)
    if not options then
        options = {}
    end
    
    options.src = self:name()
    
    local sid = uci_cursor:section("firewall", "rule", nil, options)
    if sid then
        return rule(sid)
    end
    return nil
end

-- 获取区域颜色
-- 用于Web界面显示
-- @return 颜色代码字符串
function zone:get_color()
    local zone_name = self:name()
    
    if zone_name == "lan" then
        return "#90f090"  -- 绿色
    elseif zone_name == "wan" then
        return "#f09090"  -- 红色
    elseif zone_name then
        -- 根据名称生成随机颜色
        math.randomseed(parser.hash(zone_name))
        
        local r = math.random(128)
        local g = math.random(128)
        local b
        
        -- 确保颜色不会太暗或太亮
        if r + g < 128 then
            b = 128 - r - g
        else
            b = 255 - r - g
        end
        
        local offset = math.floor(math.random() * (b - 0))
        b = 0 + offset
        
        return "#%02x%02x%02x" % { 255 - r, 255 - g, 255 - b }
    else
        return "#eeeeee"  -- 灰色
    end
end

--------------------------------------------------------------------------------
-- forwarding类: 区域间转发
--------------------------------------------------------------------------------

forwarding = util.class()

-- 初始化转发
-- @param sid 配置节名
function forwarding:__init__(sid)
    self.sid = sid
end

-- 获取源区域名
function forwarding:src()
    return uci_cursor:get("firewall", self.sid, "src")
end

-- 获取目标区域名
function forwarding:dest()
    return uci_cursor:get("firewall", self.sid, "dest")
end

-- 获取源区域对象
-- @return zone实例
function forwarding:src_zone()
    return zone(self:src())
end

-- 获取目标区域对象
-- @return zone实例
function forwarding:dest_zone()
    return zone(self:dest())
end

--------------------------------------------------------------------------------
-- rule类: 防火墙规则
--------------------------------------------------------------------------------

rule = util.class()

-- 初始化规则
-- @param sid 配置节名
function rule:__init__(sid)
    self.sid = sid
end

-- 获取配置值
function rule:get(option)
    return _get("firewall", self.sid, option)
end

-- 设置配置值
function rule:set(option, value)
    return _set("firewall", self.sid, option, value)
end

-- 获取源区域名
function rule:src()
    return uci_cursor:get("firewall", self.sid, "src")
end

-- 获取目标区域名
function rule:dest()
    return uci_cursor:get("firewall", self.sid, "dest")
end

-- 获取源区域对象
function rule:src_zone()
    return zone(self:src())
end

-- 获取目标区域对象
function rule:dest_zone()
    return zone(self:dest())
end

--------------------------------------------------------------------------------
-- redirect类: 端口重定向/NAT
--------------------------------------------------------------------------------

redirect = util.class()

-- 初始化重定向
-- @param sid 配置节名
function redirect:__init__(sid)
    self.sid = sid
end

-- 获取配置值
function redirect:get(option)
    return _get("firewall", self.sid, option)
end

-- 设置配置值
function redirect:set(option, value)
    return _set("firewall", self.sid, option, value)
end

-- 获取源区域名
function redirect:src()
    return uci_cursor:get("firewall", self.sid, "src")
end

-- 获取目标区域名
function redirect:dest()
    return uci_cursor:get("firewall", self.sid, "dest")
end

-- 获取源区域对象
function redirect:src_zone()
    return zone(self:src())
end

-- 获取目标区域对象
function redirect:dest_zone()
    return zone(self:dest())
end
