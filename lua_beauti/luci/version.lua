--[[
LuCI 版本信息模块
luci.version - Version Information Module

该模块提供 LuCI 和 OpenWrt 固件的版本信息。
通过读取 /etc/openwrt_release 文件获取发行版信息。
]]--

local globalEnv = _G

module("luci.version")

local success = pcall(dofile, "/etc/openwrt_release")

if success then
    if globalEnv.DISTRIB_DESCRIPTION then
        distname = ""
        distversion = globalEnv.DISTRIB_DESCRIPTION
    end
else
    distname = "OpenWrt Firmware"
    distversion = "Development Snapshot"
end

luciname = "LuCI 0.11.1 Release"
luciversion = "0.11.1"
