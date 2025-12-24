--[[
  小米路由器偏好设置模块
  
  功能说明:
  - 提供UCI配置的读写封装
  - 支持默认值设置
  - 支持扩展配置文件和节点
  
  默认配置:
  - 配置文件: xiaoqiang
  - 配置节点: common
  
  使用示例:
  local XQPreference = require("xiaoqiang.XQPreference")
  
  -- 读取配置
  local value = XQPreference.get("key_name", "default_value")
  
  -- 写入配置
  XQPreference.set("key_name", "new_value")
  
  -- 使用扩展配置
  local ext_value = XQPreference.get_ext("key_name", "default", "config_file", "section")
  XQPreference.set_ext("key_name", "value", "config_file", "section")
]]

local luci_util = require("luci.util")

module("xiaoqiang.XQPreference", package.seeall)

-- 默认配置文件名
local DEFAULT_CONFIG = "xiaoqiang"

-- 默认配置节点名
local DEFAULT_SECTION = "common"

-- 获取配置值
-- @param key 配置键名
-- @param default 默认值（当配置不存在时返回）
-- @param config 配置文件名（可选，默认为xiaoqiang）
-- @return string 配置值或默认值
function get(key, default, config)
    require("luci.model.uci")
    
    -- 使用默认配置文件
    config = config or DEFAULT_CONFIG
    
    if not key then
        return default
    end
    
    local uci = luci.model.uci.cursor()
    local value = uci:get(config, DEFAULT_SECTION, key)
    
    if not value then
        return default
    end
    
    return value
end

-- 设置配置值
-- @param key 配置键名
-- @param value 配置值
-- @param config 配置文件名（可选，默认为xiaoqiang）
-- @return boolean 是否设置成功
function set(key, value, config)
    require("luci.model.uci")
    
    -- 使用默认配置文件
    config = config or DEFAULT_CONFIG
    
    local uci = luci.model.uci.cursor()
    
    -- 处理nil值
    if value == nil then
        value = ""
    end
    
    -- 设置配置值
    uci:set(config, DEFAULT_SECTION, key, value)
    
    -- 保存并提交
    uci:save(config)
    return uci:commit(config)
end

-- 获取扩展配置值（指定配置文件和节点）
-- @param key 配置键名
-- @param default 默认值
-- @param config 配置文件名（可选，默认为xiaoqiang）
-- @param section 配置节点名（可选，默认为common）
-- @return string 配置值或默认值
function get_ext(key, default, config, section)
    require("luci.model.uci")
    
    -- 使用默认值
    config = config or DEFAULT_CONFIG
    section = section or DEFAULT_SECTION
    
    local uci = luci.model.uci.cursor()
    local value = uci:get(config, section, key)
    
    if not value then
        return default
    end
    
    return value
end

-- 设置扩展配置值（指定配置文件和节点）
-- @param key 配置键名
-- @param value 配置值
-- @param config 配置文件名（可选，默认为xiaoqiang）
-- @param section 配置节点名（可选，默认为common）
-- @return boolean 是否设置成功
function set_ext(key, value, config, section)
    require("luci.model.uci")
    
    -- 使用默认值
    config = config or DEFAULT_CONFIG
    section = section or DEFAULT_SECTION
    
    local uci = luci.model.uci.cursor()
    
    -- 处理nil值
    if value == nil then
        value = ""
    end
    
    -- 设置配置值
    uci:set(config, section, key, value)
    
    -- 保存并提交
    uci:save(config)
    return uci:commit(config)
end
