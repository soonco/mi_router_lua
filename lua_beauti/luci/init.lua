--[[
    LuCI 核心初始化模块
    提供 LuCI 框架的基础功能和版本信息
    
    主要功能:
    - 版本信息
    - 包路径配置
]]

module("luci", package.seeall)

-- LuCI 版本信息
version = "0.11"
version_codename = "Tianyi"

-- 配置 Lua 包搜索路径
local package_path = os.getenv("LUA_PATH")
if package_path then
    package.path = package_path
end

local package_cpath = os.getenv("LUA_CPATH")
if package_cpath then
    package.cpath = package_cpath
end
