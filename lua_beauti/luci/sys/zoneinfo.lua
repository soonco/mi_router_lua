--[[
LuCI 时区信息模块
luci.sys.zoneinfo - Timezone Information Module

该模块提供时区信息的延迟加载功能：
- TZ: 时区名称与POSIX时区字符串的映射表
- OFFSET: 时区缩写与UTC偏移量（秒）的映射表

数据按需从子模块加载，节省内存。
]]--

local setmetatable = setmetatable
local require = require
local rawget = rawget
local rawset = rawset

module("luci.sys.zoneinfo")

setmetatable(_M, {
    __index = function(self, key)
        if key == "TZ" then
            if not rawget(self, key) then
                local tzdata = require("luci.sys.zoneinfo.tzdata")
                rawset(self, key, rawget(tzdata, key))
            end
        elseif key == "OFFSET" then
            if not rawget(self, key) then
                local tzoffset = require("luci.sys.zoneinfo.tzoffset")
                rawset(self, key, rawget(tzoffset, key))
            end
        end
        return rawget(self, key)
    end
})
