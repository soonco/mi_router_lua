--[[
    LuCI 缓存加载器模块 (Cache Loader Module)
    
    功能说明:
    - 根据配置决定是否启用字节码缓存
    - 在模块加载时自动检查并启用缓存机制
    - 通过ccache模块实现按需缓存
    
    依赖模块:
    - luci.config: LuCI配置模块
    - luci.ccache: 字节码缓存模块
]]

local config = require("luci.config")
local ccache = require("luci.ccache")

module("luci.cacheloader")

-- 检查是否启用了字节码缓存
if config.ccache then
    -- 如果ccache配置节存在且enable为"1"
    if config.ccache.enable == "1" then
        -- 启用按需缓存模式
        -- 这将在模块首次加载时自动编译并缓存字节码
        ccache.cache_ondemand()
    end
end
