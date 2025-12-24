--[[
    LuCI 配置模块 (Configuration Module)
    
    功能说明:
    - 提供对LuCI配置的懒加载访问
    - 配置存储在UCI的"luci"配置文件中
    - 使用元表实现按需加载配置节
    - 支持线程本地存储以避免并发问题
    
    使用示例:
    local config = require("luci.config")
    local value = config.main.mediaurlbase  -- 访问luci配置的main节
    
    依赖模块:
    - luci.util: 工具函数模块
    - luci.model.uci: UCI配置接口
]]

local util = require("luci.util")

module("luci.config", function(module_env)
    -- 尝试加载UCI模块
    local ok = pcall(require, "luci.model.uci")
    
    if ok then
        -- 创建线程本地缓存，用于存储已加载的配置节
        local config_cache = util.threadlocal()
        
        -- 设置元表实现配置的懒加载
        setmetatable(module_env, {
            --[[
                元方法: 按需加载配置节
                
                @param self table 模块表
                @param section_name string 要访问的配置节名称
                @return table|nil 配置节内容
            ]]
            __index = function(self, section_name)
                -- 检查缓存中是否已有该配置节
                if not config_cache[section_name] then
                    -- 从UCI获取配置节
                    local cursor = luci.model.uci.cursor()
                    -- 获取"luci"配置文件中指定节的所有选项
                    config_cache[section_name] = cursor:get_all("luci", section_name)
                end
                
                return config_cache[section_name]
            end
        })
    end
end)
