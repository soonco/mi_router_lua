--[[
  小米路由器缓存工具模块
  
  功能说明:
  - 提供基于文件的缓存机制
  - 支持缓存过期时间设置
  - 缓存存储在/tmp目录下
  - 使用Lua字节码序列化数据
  
  缓存文件格式:
  - 使用luci.util.get_bytecode序列化Lua表
  - 包含: data(数据), atime(访问时间), expire(过期时间)
  
  主要函数:
  - saveCache(key, data, expire): 保存缓存
  - getCache(key): 获取缓存（过期自动删除）
  - getCacheData(key): 获取缓存数据（带活跃状态）
  - rmCacheData(key): 删除缓存
]]

module("xiaoqiang.util.XQCacheUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local luci_util = require("luci.util")
local luci_sys = require("luci.sys")
local nixio = require("nixio")
local fs = require("nixio.fs")

-- 保存缓存数据
-- @param key 缓存键名
-- @param data 要缓存的数据
-- @param expire 过期时间（秒），0表示永不过期
-- @return boolean 是否保存成功
function saveCache(key, data, expire)
    -- 参数验证
    if XQFunction.isStrNil(key) or not data or not expire then
        return false
    end
    
    local cache_path = "/tmp/" .. key
    
    -- 构建缓存数据结构
    local cache_data = {
        data = data,
        atime = luci_sys.uptime(),  -- 使用系统运行时间作为访问时间
        expire = tostring(expire)
    }
    
    -- 写入缓存文件
    local file = nixio.open(cache_path, "w", 600)  -- 权限600
    file:writeall(luci_util.get_bytecode(cache_data))
    file:close()
    
    return true
end

-- 获取缓存数据
-- @param key 缓存键名
-- @return any 缓存的数据，过期或不存在返回nil
function getCache(key)
    -- 参数验证
    if XQFunction.isStrNil(key) then
        return nil
    end
    
    local cache_path = "/tmp/" .. key
    
    -- 检查缓存文件是否存在
    if not fs.access(cache_path) then
        return nil
    end
    
    -- 读取缓存文件
    local content = fs.readfile(cache_path)
    
    -- 反序列化缓存数据
    local func = loadstring(content)
    setfenv(func, {})
    local cache_data = func()
    
    -- 检查是否过期
    if cache_data.atime and cache_data.expire then
        local expire_time = tonumber(cache_data.expire)
        
        if expire_time > 0 then
            local expire_at = cache_data.atime + cache_data.expire
            local current_time = luci_sys.uptime()
            
            -- 已过期，删除缓存
            if expire_at < current_time then
                fs.unlink(cache_path)
                return nil
            end
        end
    end
    
    return cache_data.data
end

-- 获取缓存数据（带活跃状态）
-- @param key 缓存键名
-- @return table 缓存数据，包含active字段 (1=活跃, 0=已过期)
function getCacheData(key)
    -- 参数验证
    if XQFunction.isStrNil(key) then
        return nil
    end
    
    local cache_path = "/tmp/" .. key
    
    -- 检查缓存文件是否存在
    if not fs.access(cache_path) then
        return nil
    end
    
    -- 读取缓存文件
    local content = fs.readfile(cache_path)
    
    -- 反序列化缓存数据
    local func = loadstring(content)
    setfenv(func, {})
    local cache_data = func()
    
    -- 检查是否过期
    if cache_data.atime and cache_data.expire then
        local expire_time = tonumber(cache_data.expire)
        
        if expire_time > 0 then
            local expire_at = cache_data.atime + cache_data.expire
            local current_time = luci_sys.uptime()
            
            -- 已过期
            if expire_at < current_time then
                cache_data.data.active = 0
                fs.unlink(cache_path)
            else
                cache_data.data.active = 1
            end
        else
            cache_data.data.active = 1
        end
    else
        cache_data.data.active = 1
    end
    
    return cache_data.data
end

-- 删除缓存数据
-- @param key 缓存键名
-- @return boolean 是否删除成功
function rmCacheData(key)
    -- 参数验证
    if XQFunction.isStrNil(key) then
        return false
    end
    
    local cache_path = "/tmp/" .. key
    
    -- 如果文件存在则删除
    if fs.access(cache_path) then
        fs.unlink(cache_path)
    end
    
    return true
end
