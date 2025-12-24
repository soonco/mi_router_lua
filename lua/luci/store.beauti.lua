--[[
LuCI 线程本地存储模块
luci.store - Thread-local Storage Module

该模块提供线程本地存储功能，用于在协程/线程间隔离数据。
使用 luci.util.threadlocal 实现，每个协程拥有独立的存储空间。
]]--

local util = require("luci.util")

module("luci.store", util.threadlocal)
