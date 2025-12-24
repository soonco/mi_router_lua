--[[
    LuCI CBI 配置绑定接口模块 (Configuration Binding Interface Module)
    
    功能说明:
    - 提供配置界面的抽象框架
    - 将UCI配置与Web表单绑定
    - 支持自动生成配置页面
    - 处理表单验证、提交和保存
    
    核心类层次结构:
    - Node: 所有CBI元素的基类
      - Template: 模板节点
      - Map: 配置映射(对应一个UCI配置文件)
        - Delegator: 多步骤向导
        - Compound: 复合节点
      - AbstractSection: 配置节抽象类
        - NamedSection: 命名配置节
        - TypedSection: 类型化配置节
        - Table: 表格形式的配置节
      - AbstractValue: 配置值抽象类
        - Value: 单值输入
        - DummyValue: 只读显示值
        - Flag: 布尔标志
        - ListValue: 下拉列表
        - MultiValue: 多选值
        - StaticList: 静态列表
        - DynamicList: 动态列表
        - TextValue: 多行文本
        - Button: 按钮
        - FileUpload: 文件上传
        - FileBrowser: 文件浏览器
    
    表单状态常量:
    - FORM_NODATA: 无数据
    - FORM_PROCEED: 继续处理
    - FORM_VALID: 数据有效
    - FORM_DONE: 处理完成
    - FORM_INVALID: 数据无效
    - FORM_CHANGED: 数据已更改
    - FORM_SKIP: 跳过处理
    
    依赖模块:
    - luci.template: 模板渲染
    - luci.util: 工具函数
    - luci.http: HTTP处理
    - luci.model.uci: UCI配置接口
    - luci.cbi.datatypes: 数据类型验证
]]

local os = require("os")
local fs = require("nixio.fs")
local ip = require("luci.ip")
local util = require("luci.util")
local class = require("luci.util").class
local datatypes = require("luci.cbi.datatypes")

local table = table
local ipairs = ipairs
local pairs = pairs
local type = type
local tonumber = tonumber
local tostring = tostring
local pcall = pcall
local error = error
local unpack = unpack
local rawset = rawset
local setmetatable = setmetatable
local getmetatable = getmetatable

module("luci.cbi")

--------------------------------------------------------------------------------
-- 表单状态常量 (Form State Constants)
--------------------------------------------------------------------------------

FORM_NODATA = 0    -- 无表单数据
FORM_PROCEED = 0   -- 继续处理
FORM_VALID = 1     -- 数据验证通过
FORM_DONE = 1      -- 处理完成
FORM_INVALID = -1  -- 数据验证失败
FORM_CHANGED = 2   -- 数据已更改
FORM_SKIP = 4      -- 跳过处理

-- 前缀常量
AUTO = true                    -- 自动生成
CREATE_PREFIX = "cbi.cts."     -- 创建配置节前缀
REMOVE_PREFIX = "cbi.rts."     -- 删除配置节前缀
RESORT_PREFIX = "cbi.sts."     -- 重排序前缀
FEXIST_PREFIX = "cbi.cbe."     -- 存在检查前缀

-- UCI配置游标
local uci = require("luci.model.uci")

-- 数据类型验证缓存
local datatype_cache = {}

--[[
    编译数据类型表达式
    
    将数据类型字符串解析为可执行的验证函数
    
    @param datatype_str string 数据类型表达式，如 "integer", "range(1,100)"
    @return table 解析后的验证函数和参数列表
]]
local function compile_datatype(datatype_str)
    if not datatype_str or #datatype_str == 0 then
        return nil
    end
    
    local tokens = {}
    local paren_depth = 0
    local start_pos = 1
    
    for i = 1, #datatype_str do
        local char = datatype_str:byte(i)
        
        if char == 40 then  -- '('
            if paren_depth == 0 then
                local token = datatype_str:sub(start_pos, i - 1)
                if #token > 0 then
                    if token:match("^'.*'$") or token:match("^\".*\"$") then
                        table.insert(tokens, token:gsub("[\"'](.*)[\"']", "%1"))
                    elseif type(datatypes[token]) == "function" then
                        table.insert(tokens, datatypes[token])
                        table.insert(tokens, {})
                    else
                        error("Datatype error, bad token %q" % token)
                    end
                end
                start_pos = i + 1
            end
            paren_depth = paren_depth + 1
            
        elseif char == 41 then  -- ')'
            paren_depth = paren_depth - 1
            if paren_depth <= 0 then
                if type(tokens[#tokens - 1]) ~= "function" then
                    error("Datatype error, argument list follows non-function")
                end
                tokens[#tokens] = compile_datatype(datatype_str:sub(start_pos, i - 1))
                start_pos = i + 1
            end
            
        elseif char == 44 and paren_depth <= 0 then  -- ','
            local token = datatype_str:sub(start_pos, i - 1)
            if #token > 0 then
                if token:match("^'.*'$") or token:match("^\".*\"$") then
                    table.insert(tokens, token:gsub("[\"'](.*)[\"']", "%1"))
                elseif type(datatypes[token]) == "function" then
                    table.insert(tokens, datatypes[token])
                    table.insert(tokens, {})
                else
                    error("Datatype error, bad token %q" % token)
                end
            end
            start_pos = i + 1
        end
    end
    
    if start_pos <= #datatype_str then
        local token = datatype_str:sub(start_pos)
        if #token > 0 then
            if token:match("^'.*'$") or token:match("^\".*\"$") then
                table.insert(tokens, token:gsub("[\"'](.*)[\"']", "%1"))
            elseif type(datatypes[token]) == "function" then
                table.insert(tokens, datatypes[token])
                table.insert(tokens, {})
            else
                error("Datatype error, bad token %q" % token)
            end
        end
    end
    
    return tokens
end

--[[
    验证数据类型
    
    使用编译后的数据类型表达式验证值
    
    @param datatype_str string 数据类型表达式
    @param value any 要验证的值
    @return boolean 验证结果
]]
function verify_datatype(datatype_str, value)
    if datatype_str and #datatype_str > 0 then
        if not datatype_cache[datatype_str] then
            local compiled = compile_datatype(datatype_str)
            if compiled and type(compiled[1]) == "function" then
                datatype_cache[datatype_str] = compiled
            else
                error("Datatype error, not a function expression")
            end
        end
        
        local cached = datatype_cache[datatype_str]
        if cached then
            return cached[1](value, unpack(cached[2]))
        end
    end
    
    return true
end

--------------------------------------------------------------------------------
-- Node 基类 (Base Node Class)
--------------------------------------------------------------------------------

--[[
    Node: 所有CBI元素的基类
    
    提供基本的树形结构、渲染和解析功能
]]
Node = class()

function Node.__init__(self, title, description)
    self.children = {}
    self.title = title or ""
    self.description = description or ""
    self.template = "cbi/node"
end

function Node._run_hook(self, hook_name)
    if type(self[hook_name]) == "function" then
        return self[hook_name](self)
    end
end

function Node._run_hooks(self, ...)
    local ran = false
    for _, hook_name in ipairs({...}) do
        if type(self[hook_name]) == "function" then
            self[hook_name](self)
            ran = true
        end
    end
    return ran
end

function Node.prepare(self, ...)
    for _, child in ipairs(self.children) do
        child:prepare(...)
    end
end

function Node.append(self, child)
    table.insert(self.children, child)
end

function Node.parse(self, ...)
    for _, child in ipairs(self.children) do
        child:parse(...)
    end
end

function Node.render(self, scope)
    if not scope then
        scope = {}
    end
    scope.self = self
    luci.template.render(self.template, scope)
end

function Node.render_children(self, ...)
    for i, child in ipairs(self.children) do
        child.last_child = (i == #self.children)
        child:render(...)
    end
end

--------------------------------------------------------------------------------
-- Template 类 (Template Class)
--------------------------------------------------------------------------------

--[[
    Template: 简单模板节点
    
    用于渲染静态模板内容
]]
Template = class(Node)

function Template.__init__(self, template_name)
    Node.__init__(self)
    self.template = template_name
end

function Template.render(self)
    luci.template.render(self.template, {self = self})
end

function Template.parse(self, readinput)
    self.readinput = (readinput ~= false)
    if Map.formvalue(self, "cbi.submit") then
        return FORM_DONE
    end
    return FORM_NODATA
end

--------------------------------------------------------------------------------
-- Map 类 (Map Class)
--------------------------------------------------------------------------------

--[[
    Map: 配置映射
    
    对应一个UCI配置文件，是CBI表单的顶层容器
]]
Map = class(Node)

function Map.__init__(self, config, ...)
    Node.__init__(self, ...)
    
    self.config = config
    self.parsechain = {self.config}
    self.template = "cbi/map"
    self.apply_on_parse = nil
    self.readinput = true
    self.proceed = false
    self.flow = {}
    
    self.uci = uci.cursor()
    self.save = true
    self.changed = false
    
    if not self.uci:load(self.config) then
        error("Unable to read UCI data: " .. self.config)
    end
end

function Map.formvalue(self, key)
    if self.readinput then
        return luci.http.formvalue(key)
    end
end

function Map.formvaluetable(self, key)
    if self.readinput then
        return luci.http.formvaluetable(key) or {}
    end
    return {}
end

function Map.get_scheme(self, sectiontype, option)
    if not option then
        if self.scheme then
            return self.scheme.sections[sectiontype]
        end
    else
        if self.scheme and self.scheme.variables[sectiontype] then
            return self.scheme.variables[sectiontype][option]
        end
    end
end

function Map.submitstate(self)
    return self:formvalue("cbi.submit")
end

function Map.chain(self, config)
    table.insert(self.parsechain, config)
end

function Map.state_handler(self, state)
    return state
end

function Map.parse(self, readinput, ...)
    self.readinput = (readinput ~= false)
    
    if self:_run_hooks("on_parse") then
        self.state = self:state_handler(self.state)
        return self.state
    end
    
    Node.parse(self, ...)
    
    if self.save then
        self:_run_hooks("on_before_save")
        
        for _, config in ipairs(self.parsechain) do
            self.uci:save(config)
        end
        
        if self:submitstate() then
            if self.proceed or self.flow.autoapply then
                self:_run_hooks("on_before_commit")
                
                for _, config in ipairs(self.parsechain) do
                    self.uci:commit(config)
                    self.uci:load(config)
                end
                
                self:_run_hooks("on_after_commit", "on_before_apply")
                
                if self.apply_on_parse then
                    self:_run_hooks("on_apply")
                    self:_run_hooks("on_after_apply")
                else
                    self.apply_needed = true
                end
            end
        end
        
        for _, config in ipairs(self.parsechain) do
            self.uci:unload(config)
        end
        
        if type(self.state_handler) == "function" then
            self.state = self:state_handler(self.state)
        end
    end
    
    if self.changed then
        self.state = FORM_CHANGED
    elseif self:submitstate() then
        self.state = FORM_VALID
    else
        self.state = FORM_NODATA
    end
    
    return self.state
end

function Map.render(self, ...)
    self:_run_hooks("on_init")
    Node.render(self, ...)
end

function Map.section(self, section_class, ...)
    local section = section_class(self, ...)
    self:append(section)
    return section
end

function Map.add(self, sectiontype)
    return self.uci:add(self.config, sectiontype)
end

function Map.set(self, section, option, value)
    if option then
        return self.uci:set(self.config, section, option, value)
    else
        return self.uci:set(self.config, section, value)
    end
end

function Map.del(self, section, option)
    if option then
        return self.uci:delete(self.config, section, option)
    else
        return self.uci:delete(self.config, section)
    end
end

function Map.get(self, section, option)
    if option then
        return self.uci:get(self.config, section, option)
    else
        return self.uci:get(self.config, section)
    end
end

function Map.stateget(self, section, option)
    return self.uci:get(self.config, section, option)
end

--------------------------------------------------------------------------------
-- Delegator 类 (Delegator Class)
--------------------------------------------------------------------------------

--[[
    Delegator: 多步骤向导
    
    用于创建多步骤配置向导
]]
Delegator = class(Node)

function Delegator.__init__(self, ...)
    Node.__init__(self, ...)
    self.nodes = {}
    self.defaultpath = {}
    self.pageaction = false
    self.readinput = true
    self.allow_reset = false
    self.allow_cancel = false
    self.allow_back = false
    self.allow_finish = false
    self.template = "cbi/delegator"
end

function Delegator.set(self, name, node)
    if type(node) == "table" and getmetatable(node) == nil then
        node = Compound(unpack(node))
    end
    self.nodes[name] = node
end

function Delegator.add(self, name, node)
    node = self:set(name, node)
    self.defaultpath[#self.defaultpath + 1] = name
end

function Delegator.insert_after(self, name, node, after)
    local index = #self.defaultpath + 1
    for i, v in ipairs(self.defaultpath) do
        if v == after then
            index = i + 1
            break
        end
    end
    table.insert(self.defaultpath, index, name)
end

function Delegator.get(self, name)
    local node = self.nodes[name]
    if type(node) == "string" then
        node = load(node, name)
    end
    if type(node) == "table" and getmetatable(node) == nil then
        node = Compound(unpack(node))
    end
    return node
end

function Delegator.parse(self, ...)
    if self.allow_cancel then
        if Map.formvalue(self, "cbi.cancel") then
            if self:_run_hooks("on_cancel") then
                return FORM_DONE
            end
        end
    end
    
    if not Map.formvalue(self, "cbi.delg.current") then
        self:_run_hooks("on_init")
    end
    
    local next_node = nil
    
    if not self.chain then
        self.chain = self:get_chain()
    end
    
    if not self.current then
        self.current = self:get_active()
    end
    
    if not self.active then
        self.active = self:get(self.current)
    end
    
    assert(self.active, "Invalid state")
    
    local state = FORM_DONE
    
    if type(self.active) ~= "function" then
        self.active:populate_delegator(self)
        state = self.active:parse()
    else
        self.active(self)
    end
    
    if state > FORM_PROCEED then
        if Map.formvalue(self, "cbi.delg.back") then
            next_node = self:get_prev(self.current)
        else
            next_node = self:get_next(self.current)
        end
    elseif state < FORM_PROCEED then
        return state
    end
    
    if not Map.formvalue(self, "cbi.submit") then
        return FORM_NODATA
    end
    
    if state > FORM_PROCEED then
        if next_node and self:get(next_node) then
            self.current = next_node
            self.active = self:get(self.current)
            if type(self.active) ~= "function" then
                self.active:populate_delegator(self)
                local parse_state = self.active:parse(false)
                if parse_state == FORM_SKIP then
                    return self:parse(...)
                end
                return FORM_PROCEED
            else
                return self:parse(...)
            end
        else
            return self:_run_hook("on_done") or FORM_DONE
        end
    end
    
    return FORM_PROCEED
end

function Delegator.get_next(self, state)
    for i, v in ipairs(self.chain) do
        if v == state then
            return self.chain[i + 1]
        end
    end
end

function Delegator.get_prev(self, state)
    for i, v in ipairs(self.chain) do
        if v == state then
            return self.chain[i - 1]
        end
    end
end

function Delegator.get_chain(self)
    local chain = {}
    for _, v in ipairs(self.defaultpath) do
        table.insert(chain, v)
    end
    return chain
end

function Delegator.get_active(self)
    return Map.formvalue(self, "cbi.delg.current") or self.chain[1]
end

--------------------------------------------------------------------------------
-- Compound 类 (Compound Class)
--------------------------------------------------------------------------------

--[[
    Compound: 复合节点
    
    将多个Map组合在一起
]]
Compound = class(Node)

function Compound.__init__(self, ...)
    Node.__init__(self)
    self.children = {...}
end

function Compound.populate_delegator(self, delegator)
    for _, child in ipairs(self.children) do
        child.delegator = delegator
    end
end

function Compound.parse(self, ...)
    local state = FORM_DONE
    for _, child in ipairs(self.children) do
        local child_state = child:parse(...)
        state = (child_state < state) and child_state or state
    end
    return state
end

--------------------------------------------------------------------------------
-- AbstractSection 类 (Abstract Section Class)
--------------------------------------------------------------------------------

--[[
    AbstractSection: 配置节抽象类
    
    所有配置节类型的基类
]]
AbstractSection = class(Node)

function AbstractSection.__init__(self, map, sectiontype, ...)
    Node.__init__(self, ...)
    
    self.sectiontype = sectiontype
    self.map = map
    self.config = map.config
    self.optionals = {}
    self.defaults = {}
    self.fields = {}
    self.tag_error = {}
    self.tag_invalid = {}
    self.tag_deperror = {}
    self.changed = false
    
    self.optional = true
    self.addremove = false
    self.dynamic = false
end

function AbstractSection.tab(self, tab_name, title, description)
    self.tabs = self.tabs or {}
    self.tab_names = self.tab_names or {}
    
    self.tab_names[#self.tab_names + 1] = tab_name
    self.tabs[tab_name] = {
        title = title,
        description = description,
        childs = {}
    }
end

function AbstractSection.option(self, option_class, option_name, ...)
    if self.tabs then
        error("Cannot add options to a tabbed section directly")
    end
    
    local option = option_class(self.map, self, option_name, ...)
    self:append(option)
    self.fields[option_name] = option
    return option
end

function AbstractSection.taboption(self, tab_name, option_class, option_name, ...)
    local option = option_class(self.map, self, option_name, ...)
    
    if not self.tabs or not self.tabs[tab_name] then
        error("Invalid tab %q" % tab_name)
    end
    
    self:append(option)
    self.fields[option_name] = option
    table.insert(self.tabs[tab_name].childs, option)
    
    return option
end

function AbstractSection.render_tab(self, tab_name, ...)
    local tab = self.tabs[tab_name]
    if tab then
        for _, child in ipairs(tab.childs) do
            child:render(...)
        end
    end
end

function AbstractSection.has_tabs(self)
    return self.tabs ~= nil
end

function AbstractSection.cfgvalue(self, section)
    return self.map:get(section)
end

function AbstractSection.push_events(self)
    self.map.changed = true
end

function AbstractSection.remove(self, section)
    self.map.proceed = true
    return self.map:del(section)
end

function AbstractSection.create(self, section)
    local stat = true
    
    if section then
        stat = self.map.uci:set(self.config, section, self.sectiontype)
    else
        section = self.map:add(self.sectiontype)
        stat = (section ~= nil)
    end
    
    if stat then
        for option, value in pairs(self.defaults) do
            self.map:set(section, option, value)
        end
    end
    
    return stat
end

function AbstractSection.parse_dynamic(self, section)
    if self.dynamic then
        local form_create = self.map:formvalue("cbi.opt." .. self.config .. "." .. section)
        
        if form_create then
            local option_class = self.dynamic_option or Value
            local option_name = form_create
            
            local option = self:option(option_class, option_name, form_create)
            option.optional = true
        end
    end
end

function AbstractSection.parse_optionals(self, section)
    if self.optional then
        for i, option in ipairs(self.children) do
            if option.optional then
                local form_create = self.map:formvalue(
                    "cbi.opt." .. self.config .. "." .. section .. "." .. option.option
                )
                
                if form_create then
                    option:write(section, option.default or "")
                end
            end
        end
    end
end

--------------------------------------------------------------------------------
-- NamedSection 类 (Named Section Class)
--------------------------------------------------------------------------------

--[[
    NamedSection: 命名配置节
    
    对应UCI中具有固定名称的配置节
]]
NamedSection = class(AbstractSection)

function NamedSection.__init__(self, map, section, sectiontype, ...)
    AbstractSection.__init__(self, map, sectiontype, ...)
    
    self.addremove = false
    self.template = "cbi/nsection"
    self.section = section
end

function NamedSection.parse(self, readinput)
    local section = self.section
    local cfg_exists = self:cfgvalue(section)
    
    if self.addremove then
        local form_key = self.config .. "." .. section
        
        if cfg_exists then
            if self.map:formvalue("cbi.rns." .. form_key) then
                if self:remove(section) then
                    self:push_events()
                    return
                end
            end
        else
            if self.map:formvalue("cbi.cns." .. form_key) then
                self:create(section)
                return
            end
        end
    end
    
    if cfg_exists then
        AbstractSection.parse_dynamic(self, section)
        
        if self.map:submitstate() then
            Node.parse(self, section)
        end
        
        AbstractSection.parse_optionals(self, section)
        
        if self.changed then
            self:push_events()
        end
    end
end

--------------------------------------------------------------------------------
-- TypedSection 类 (Typed Section Class)
--------------------------------------------------------------------------------

--[[
    TypedSection: 类型化配置节
    
    对应UCI中特定类型的所有配置节
]]
TypedSection = class(AbstractSection)

function TypedSection.__init__(self, map, sectiontype, ...)
    AbstractSection.__init__(self, map, sectiontype, ...)
    
    self.template = "cbi/tsection"
    self.deps = {}
    self.anonymous = false
end

function TypedSection.cfgsections(self)
    local sections = {}
    
    self.map.uci:foreach(self.map.config, self.sectiontype, function(s)
        if self:checkscope(s[".name"]) then
            table.insert(sections, s[".name"])
        end
    end)
    
    return sections
end

function TypedSection.depends(self, option, value)
    table.insert(self.deps, {option = option, value = value})
end

function TypedSection.checkscope(self, section)
    if #self.deps == 0 then
        return true
    end
    
    for _, dep in ipairs(self.deps) do
        local cfg_value = self.map:get(section, dep.option)
        if cfg_value == dep.value then
            return true
        end
    end
    
    return false
end

function TypedSection.parse(self, readinput)
    if self.addremove then
        local form_values = self.map:formvaluetable(REMOVE_PREFIX .. self.config .. "." .. self.sectiontype)
        
        for key, _ in pairs(form_values) do
            local section = key
            if key:sub(-2) == ".x" then
                section = key:sub(1, -3)
            end
            
            if self:cfgvalue(section) and self:checkscope(section) then
                self:remove(section)
            end
        end
    end
    
    local created = nil
    local sections = self:cfgsections()
    
    for _, section in ipairs(sections) do
        AbstractSection.parse_dynamic(self, section)
        
        if self.map:submitstate() then
            Node.parse(self, section, readinput)
        end
        
        AbstractSection.parse_optionals(self, section)
    end
    
    if self.addremove then
        local create_name = self.map:formvalue(CREATE_PREFIX .. self.config .. "." .. self.sectiontype)
        
        if create_name then
            if #create_name > 0 then
                created = self:create(create_name)
            else
                created = self:create()
            end
        end
    end
    
    if self.sortable then
        local order = self.map:formvalue(RESORT_PREFIX .. self.config .. "." .. self.sectiontype)
        
        if order and #order > 0 then
            local sort_index = 0
            for section in order:gmatch("[^,]+") do
                sort_index = sort_index + 1
                self.map.uci:reorder(self.config, section, sort_index)
            end
            
            if sort_index > 0 then
                self.changed = true
            end
        end
    end
    
    if self.changed then
        self:push_events()
    end
    
    if created then
        AbstractSection.parse_optionals(self, created)
    end
end

--------------------------------------------------------------------------------
-- Table 类 (Table Class)
--------------------------------------------------------------------------------

--[[
    Table: 表格形式配置节
    
    以表格形式显示配置数据
]]
Table = class(AbstractSection)

function Table.__init__(self, form, data, ...)
    AbstractSection.__init__(self, form, nil, ...)
    
    self.template = "cbi/tblsection"
    self.data = data or {}
    self.rowcolors = true
    self.anonymous = true
end

function Table.cfgsections(self)
    local sections = {}
    
    for i, _ in pairs(self.data) do
        table.insert(sections, i)
    end
    
    return sections
end

function Table.parse(self, readinput)
    -- Table不解析输入
end

function Table.update(self, data)
    self.data = data
end

--------------------------------------------------------------------------------
-- AbstractValue 类 (Abstract Value Class)
--------------------------------------------------------------------------------

--[[
    AbstractValue: 配置值抽象类
    
    所有配置值类型的基类
]]
AbstractValue = class(Node)

function AbstractValue.__init__(self, map, section, option, ...)
    Node.__init__(self, ...)
    
    self.section = section
    self.option = option
    self.map = map
    self.config = map.config
    self.tag_invalid = {}
    self.tag_missing = {}
    self.tag_reqerror = {}
    self.tag_error = {}
    self.deps = {}
    self.subdeps = {}
    
    self.track_missing = false
    self.rmempty = true
    self.default = nil
    self.size = nil
    self.optional = false
end

function AbstractValue.prepare(self)
    self.cast = self.cast or "string"
end

function AbstractValue.depends(self, field, value)
    local deps
    
    if type(field) == "table" then
        deps = field
    else
        deps = {[field] = value}
    end
    
    table.insert(self.deps, deps)
end

function AbstractValue.cbid(self, section)
    return "cbid." .. self.map.config .. "." .. section .. "." .. self.option
end

function AbstractValue.formvalue(self, section)
    return self.map:formvalue(self:cbid(section))
end

function AbstractValue.formcreated(self, section)
    local form_key = FEXIST_PREFIX .. self.map.config .. "." .. section .. "." .. self.option
    return self.map:formvalue(form_key)
end

function AbstractValue.cfgvalue(self, section)
    local value = self.map:get(section, self.option)
    
    if not value then
        return nil
    elseif not self.cast or self.cast == "string" then
        if type(value) == "table" then
            return value[1]
        end
    elseif self.cast == "table" then
        if type(value) ~= "table" then
            return {value}
        end
    end
    
    return value
end

function AbstractValue.validate(self, value)
    if self.datatype and value then
        if type(value) == "table" then
            for _, v in ipairs(value) do
                if v and #v > 0 and not verify_datatype(self.datatype, v) then
                    return nil
                end
            end
        else
            if not verify_datatype(self.datatype, value) then
                return nil
            end
        end
    end
    
    return value
end

function AbstractValue.write(self, section, value)
    return self.map:set(section, self.option, value)
end

function AbstractValue.remove(self, section)
    return self.map:del(section, self.option)
end

function AbstractValue.parse(self, section, novld)
    local form_value = self:formvalue(section)
    local cfg_value = self:cfgvalue(section)
    
    if form_value and #form_value > 0 then
        local validated = self:validate(form_value, section)
        
        if validated then
            if cfg_value ~= validated then
                self:write(section, validated)
                self.section.changed = true
            end
        else
            if not novld then
                self.tag_invalid[section] = true
                self.tag_error[section] = true
            end
        end
    else
        if self.rmempty then
            if cfg_value then
                self:remove(section)
                self.section.changed = true
            end
        elseif self.track_missing and not self:formcreated(section) then
            self.tag_missing[section] = true
            self.tag_error[section] = true
        end
    end
end

--------------------------------------------------------------------------------
-- Value 类 (Value Class)
--------------------------------------------------------------------------------

--[[
    Value: 单值输入
    
    标准的文本输入框
]]
Value = class(AbstractValue)

function Value.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/value"
    self.keylist = {}
    self.vallist = {}
    self.password = false
end

function Value.reset_values(self)
    self.keylist = {}
    self.vallist = {}
end

function Value.value(self, key, value)
    value = value or key
    table.insert(self.keylist, tostring(key))
    table.insert(self.vallist, tostring(value))
end

--------------------------------------------------------------------------------
-- DummyValue 类 (Dummy Value Class)
--------------------------------------------------------------------------------

--[[
    DummyValue: 只读显示值
    
    用于显示不可编辑的值
]]
DummyValue = class(AbstractValue)

function DummyValue.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/dvalue"
    self.value = nil
end

function DummyValue.cfgvalue(self, section)
    local value
    
    if self.value then
        if type(self.value) == "function" then
            value = self.value(self, section)
        else
            value = self.value
        end
    else
        value = AbstractValue.cfgvalue(self, section)
    end
    
    return value
end

function DummyValue.parse(self, section)
    -- DummyValue不解析输入
end

--------------------------------------------------------------------------------
-- Flag 类 (Flag Class)
--------------------------------------------------------------------------------

--[[
    Flag: 布尔标志
    
    复选框形式的布尔值
]]
Flag = class(AbstractValue)

function Flag.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/fvalue"
    self.enabled = "1"
    self.disabled = "0"
    self.default = self.disabled
end

function Flag.parse(self, section)
    local form_value = self:formvalue(section)
    local cfg_value = self:cfgvalue(section)
    
    if form_value then
        if form_value == self.enabled then
            if cfg_value ~= self.enabled then
                self:write(section, self.enabled)
                self.section.changed = true
            end
        else
            if cfg_value ~= self.disabled then
                self:write(section, self.disabled)
                self.section.changed = true
            end
        end
    else
        if self.rmempty then
            if cfg_value then
                self:remove(section)
                self.section.changed = true
            end
        elseif cfg_value ~= self.disabled then
            self:write(section, self.disabled)
            self.section.changed = true
        end
    end
end

--------------------------------------------------------------------------------
-- ListValue 类 (List Value Class)
--------------------------------------------------------------------------------

--[[
    ListValue: 下拉列表
    
    从预定义选项中选择一个值
]]
ListValue = class(AbstractValue)

function ListValue.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/lvalue"
    self.keylist = {}
    self.vallist = {}
    self.size = 1
    self.widget = "select"
end

function ListValue.reset_values(self)
    self.keylist = {}
    self.vallist = {}
end

function ListValue.value(self, key, value, ...)
    if luci.util.contains(self.keylist, key) then
        return
    end
    
    value = value or key
    table.insert(self.keylist, tostring(key))
    table.insert(self.vallist, tostring(value))
    
    for i, dep in ipairs({...}) do
        table.insert(self.subdeps, {add = key, deps = dep})
    end
end

function ListValue.validate(self, value)
    if luci.util.contains(self.keylist, value) then
        return value
    else
        return nil
    end
end

--------------------------------------------------------------------------------
-- MultiValue 类 (Multi Value Class)
--------------------------------------------------------------------------------

--[[
    MultiValue: 多选值
    
    可以选择多个值
]]
MultiValue = class(AbstractValue)

function MultiValue.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/mvalue"
    self.keylist = {}
    self.vallist = {}
    self.widget = "checkbox"
    self.delimiter = " "
end

function MultiValue.render(self, ...)
    if self.widget == "select" then
        if not self.size then
            self.size = #self.vallist
        end
    end
    
    AbstractValue.render(self, ...)
end

function MultiValue.reset_values(self)
    self.keylist = {}
    self.vallist = {}
end

function MultiValue.value(self, key, value)
    if luci.util.contains(self.keylist, key) then
        return
    end
    
    value = value or key
    table.insert(self.keylist, tostring(key))
    table.insert(self.vallist, tostring(value))
end

function MultiValue.valuelist(self, section)
    local cfg_value = self:cfgvalue(section)
    
    if type(cfg_value) ~= "string" then
        return {}
    end
    
    return luci.util.split(cfg_value, self.delimiter)
end

function MultiValue.validate(self, value)
    if type(value) ~= "table" or not value then
        value = {value}
    end
    
    local result = nil
    
    for _, v in ipairs(value) do
        if luci.util.contains(self.keylist, v) then
            if result then
                result = result .. self.delimiter .. v
            else
                result = v
            end
        end
    end
    
    return result
end

--------------------------------------------------------------------------------
-- StaticList 类 (Static List Class)
--------------------------------------------------------------------------------

--[[
    StaticList: 静态列表
    
    从预定义选项中选择多个值
]]
StaticList = class(MultiValue)

function StaticList.__init__(self, ...)
    MultiValue.__init__(self, ...)
    
    self.cast = "table"
    self.valuelist = self.cfgvalue
end

function StaticList.validate(self, value)
    if type(value) ~= "table" or not value then
        value = {value}
    end
    
    local result = {}
    
    for _, v in ipairs(value) do
        if luci.util.contains(self.keylist, v) then
            table.insert(result, v)
        end
    end
    
    return result
end

--------------------------------------------------------------------------------
-- DynamicList 类 (Dynamic List Class)
--------------------------------------------------------------------------------

--[[
    DynamicList: 动态列表
    
    可以动态添加/删除的值列表
]]
DynamicList = class(AbstractValue)

function DynamicList.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/dynlist"
    self.cast = "table"
    self.keylist = {}
    self.vallist = {}
end

function DynamicList.reset_values(self)
    self.keylist = {}
    self.vallist = {}
end

function DynamicList.value(self, key, value)
    value = value or key
    table.insert(self.keylist, tostring(key))
    table.insert(self.vallist, tostring(value))
end

function DynamicList.write(self, section, value)
    local result = {}
    
    if type(value) == "table" then
        for _, v in ipairs(value) do
            if v and #v > 0 then
                table.insert(result, v)
            end
        end
    else
        result = {value}
    end
    
    if self.cast == "string" then
        value = table.concat(result, " ")
    else
        value = result
    end
    
    return AbstractValue.write(self, section, value)
end

function DynamicList.cfgvalue(self, section)
    local value = AbstractValue.cfgvalue(self, section)
    
    if type(value) == "string" then
        local result = {}
        for v in value:gmatch("%S+") do
            if #v > 0 then
                table.insert(result, v)
            end
        end
        value = result
    end
    
    return value
end

function DynamicList.formvalue(self, section)
    local value = AbstractValue.formvalue(self, section)
    
    if type(value) == "string" then
        if self.cast == "string" then
            local result = {}
            for v in value:gmatch("[^\r\n]+") do
                table.insert(result, v)
            end
            value = result
        else
            value = {value}
        end
    end
    
    return value
end

--------------------------------------------------------------------------------
-- TextValue 类 (Text Value Class)
--------------------------------------------------------------------------------

--[[
    TextValue: 多行文本
    
    多行文本输入框
]]
TextValue = class(AbstractValue)

function TextValue.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/tvalue"
end

--------------------------------------------------------------------------------
-- Button 类 (Button Class)
--------------------------------------------------------------------------------

--[[
    Button: 按钮
    
    触发操作的按钮
]]
Button = class(AbstractValue)

function Button.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/button"
    self.inputstyle = nil
    self.rmempty = true
end

--------------------------------------------------------------------------------
-- FileUpload 类 (File Upload Class)
--------------------------------------------------------------------------------

--[[
    FileUpload: 文件上传
    
    文件上传输入框
]]
FileUpload = class(AbstractValue)

function FileUpload.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/upload"
    
    if not self.map.upload_fields then
        self.map.upload_fields = {self}
    else
        self.map.upload_fields[#self.map.upload_fields + 1] = self
    end
end

function FileUpload.formcreated(self, section)
    if AbstractValue.formcreated(self, section) then
        return true
    end
    
    return self.map:formvalue("cbi.rlf." .. section .. "." .. self.option) or
           self.map:formvalue("cbi.rlf." .. section .. "." .. self.option .. ".x")
end

function FileUpload.cfgvalue(self, section)
    local value = AbstractValue.cfgvalue(self, section)
    
    if value and fs.access(value) then
        return value
    end
    
    return nil
end

function FileUpload.formvalue(self, section)
    local value = AbstractValue.formvalue(self, section)
    
    if value then
        if self.map:formvalue("cbi.rlf." .. section .. "." .. self.option) or
           self.map:formvalue("cbi.rlf." .. section .. "." .. self.option .. ".x") then
            fs.unlink(value)
            self.value = nil
        else
            return value
        end
    end
    
    return nil
end

function FileUpload.remove(self, section)
    local value = AbstractValue.formvalue(self, section)
    
    if value and fs.access(value) then
        fs.unlink(value)
    end
    
    return AbstractValue.remove(self, section)
end

--------------------------------------------------------------------------------
-- FileBrowser 类 (File Browser Class)
--------------------------------------------------------------------------------

--[[
    FileBrowser: 文件浏览器
    
    文件路径选择器
]]
FileBrowser = class(AbstractValue)

function FileBrowser.__init__(self, ...)
    AbstractValue.__init__(self, ...)
    
    self.template = "cbi/browser"
end
