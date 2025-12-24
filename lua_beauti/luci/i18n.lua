--[[
    LuCI 国际化（i18n）模块
    提供多语言翻译支持
    
    主要功能:
    - 语言设置
    - 翻译文本获取
    - 格式化翻译
]]

module("luci.i18n", package.seeall)

require("luci.util")
local parser = require("luci.template.parser")

table = {}

i18ndir = luci.util.libpath() .. "/i18n/"

loaded = {}

context = luci.util.threadlocal()

default = "en"

function clear()
end

function load(catalog, lang, force)
end

function loadc(catalog, force)
end

function setlanguage(lang)
    context.lang = lang:gsub("_", "-")
    
    context.parent = context.lang:match("^([a-z][a-z])_")
    
    local success = parser.load_catalog(context.lang, i18ndir)
    
    if not success then
        if context.parent then
            parser.load_catalog(context.parent, i18ndir)
            return context.parent
        end
    end
    
    return context.lang
end

function translate(key)
    local translated = parser.translate(key)
    return translated or key
end

function translatef(key, ...)
    local translated = tostring(translate(key))
    return translated:format(...)
end

function string(key)
    return tostring(translate(key))
end

function stringf(key, ...)
    local translated = tostring(translate(key))
    return translated:format(...)
end
