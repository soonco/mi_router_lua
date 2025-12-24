--[[
LuCI 模板引擎模块
luci.template - Template Engine Module

该模块提供 LuCI Web 界面的模板渲染功能：
- 模板解析与编译
- 模板缓存管理
- 视图命名空间支持
- 模板渲染执行
]]--

local util = require("luci.util")
local config = require("luci.config")
local parser = require("luci.template.parser")

local tostring = tostring
local pairs = pairs
local loadstring = loadstring
local setmetatable = setmetatable
local loadfile = loadfile
local getfenv = getfenv
local setfenv = setfenv
local rawget = rawget
local assert = assert
local type = type
local error = error

module("luci.template")

config.template = config.template or {}
viewdir = config.template.viewdir or (util.libpath() .. "/view")

context = util.threadlocal()

function render(templateName, scope)
    local template = Template(templateName)
    return template:render(scope or getfenv(2))
end

Template = util.class()

Template.cache = setmetatable({}, { __mode = "v" })

function Template.__init__(self, name)
    self.template = self.cache[name]
    self.name = name
    self.viewns = context.viewns
    
    if not self.template then
        local templatePath = viewdir .. "/" .. name .. ".htm"
        local compiled, _, parseError = parser.parse(templatePath)
        
        self.template = compiled
        
        if not self.template then
            error("Failed to load template '" .. name .. "'.\n" ..
                  "Error while parsing template '" .. templatePath .. "':\n" ..
                  (parseError or "Unknown syntax error"))
        else
            self.cache[name] = self.template
        end
    end
end

function Template.render(self, scope)
    if not scope then
        scope = getfenv(2)
    end
    
    setfenv(self.template, setmetatable({}, {
        __index = function(tbl, key)
            local value = rawget(tbl, key)
            if not value then
                value = self.viewns[key]
                if not value then
                    value = scope[key]
                end
            end
            return value
        end
    }))
    
    local success, errorMsg = util.copcall(self.template)
    
    if not success then
        error("Failed to execute template '" .. self.name .. "'.\n" ..
              "A runtime error occured: " .. tostring(errorMsg or "(nil)"))
    end
end
