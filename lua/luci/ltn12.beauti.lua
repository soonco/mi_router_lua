--[[
    LTN12 数据流处理模块
    基于 Lua Technical Note 12 的数据流抽象
    
    主要功能:
    - 数据源（Source）：数据的生产者
    - 数据槽（Sink）：数据的消费者
    - 过滤器（Filter）：数据转换器
    - 数据泵（Pump）：连接数据源和数据槽
    
    这是一个用于处理数据流的通用框架，广泛用于网络编程、文件处理等场景
]]

local string = require("string")
local table = require("table")
local base = _G

module("luci.ltn12")

-- 模块版本信息
BLOCKSIZE = 2048
_VERSION = "LTN12 1.0.1"

-- ========================================
-- 过滤器（Filter）模块
-- 用于数据转换
-- ========================================
filter = {}

--[[
    创建过滤器链
    将多个过滤器串联成一个过滤器
    
    @param ... 多个过滤器函数
    @return 串联后的过滤器函数
]]
function filter.chain(...)
    local filters = { ... }
    local filter_count = base.select("#", ...)
    
    if filter_count == 0 then
        return nil
    end
    
    if filter_count == 1 then
        return filters[1]
    end
    
    return function(chunk)
        local result = chunk
        
        for i = 1, filter_count do
            result = filters[i](result)
        end
        
        return result
    end
end

--[[
    创建循环过滤器
    对数据块反复应用过滤函数直到处理完毕
    
    @param low_level_func 底层过滤函数
    @param context 上下文参数
    @param extra 额外参数
    @return 高层过滤器函数
]]
function filter.cycle(low_level_func, context, extra)
    return function(chunk)
        local result_parts = {}
        local result, new_context, new_extra
        
        if chunk == "" then
            return ""
        end
        
        while true do
            result, new_context, new_extra = low_level_func(context, chunk, extra)
            
            if result then
                if result ~= "" then
                    result_parts[#result_parts + 1] = result
                end
                
                context = new_context
                extra = new_extra
                chunk = ""
            else
                if context then
                    return base.table.concat(result_parts)
                else
                    base.error(new_context)
                end
            end
        end
    end
end

-- ========================================
-- 数据源（Source）模块
-- 数据的生产者
-- ========================================
source = {}

--[[
    创建空数据源
    立即返回 EOF
    
    @param err 可选的错误信息
    @return 空数据源函数
]]
function source.empty(err)
    return function()
        return nil, err
    end
end

--[[
    创建错误数据源
    总是返回错误
    
    @param err 错误信息
    @return 错误数据源函数
]]
function source.error(err)
    return function()
        return nil, err
    end
end

--[[
    创建文件数据源
    从文件读取数据
    
    @param file_handle 文件句柄
    @param io_err 打开文件时的错误
    @return 文件数据源函数
]]
function source.file(file_handle, io_err)
    if file_handle then
        return function()
            local chunk = file_handle:read(BLOCKSIZE)
            
            if not chunk then
                file_handle:close()
            end
            
            return chunk
        end
    else
        return source.error(io_err or "unable to open file")
    end
end

--[[
    简化数据源
    将返回多个值的数据源转换为标准格式
    
    @param src 原始数据源
    @return 简化后的数据源
]]
function source.simplify(src)
    return function()
        local chunk, err_or_new_src = src()
        
        if chunk then
            return chunk
        elseif err_or_new_src then
            src = err_or_new_src
            return src()
        else
            return nil
        end
    end
end

--[[
    创建字符串数据源
    从字符串或字符串表读取数据
    
    @param data 字符串或字符串表
    @return 字符串数据源函数
]]
function source.string(data)
    if data then
        local index = 1
        
        return function()
            local chunk = data
            data = nil
            return chunk
        end
    else
        return source.empty()
    end
end

--[[
    为数据源添加过滤器
    
    @param src 原始数据源
    @param flt 过滤器函数
    @return 添加过滤器后的数据源
]]
function source.chain(src, flt)
    return function()
        if not src then
            return nil
        end
        
        local chunk, err = src()
        
        if chunk ~= "" then
            local filtered = flt(chunk)
            
            if filtered == "" then
                if chunk then
                    return ""
                end
            elseif filtered then
                return filtered
            else
                src = nil
                return nil
            end
        else
            return ""
        end
    end
end

--[[
    创建表数据源
    从表中逐个返回元素
    
    @param tbl 数据表
    @return 表数据源函数
]]
function source.table(tbl)
    local index = 0
    
    return function()
        index = index + 1
        return tbl[index]
    end
end

--[[
    连接多个数据源
    按顺序从多个数据源读取数据
    
    @param ... 多个数据源
    @return 连接后的数据源
]]
function source.cat(...)
    local sources = { ... }
    local current_index = 1
    
    return function()
        while current_index <= #sources do
            local chunk, err = sources[current_index]()
            
            if chunk then
                return chunk
            end
            
            if err then
                return nil, err
            end
            
            current_index = current_index + 1
        end
        
        return nil
    end
end

-- ========================================
-- 数据槽（Sink）模块
-- 数据的消费者
-- ========================================
sink = {}

--[[
    创建表数据槽
    将数据收集到表中
    
    @param tbl 可选的目标表
    @return 表数据槽函数和目标表
]]
function sink.table(tbl)
    tbl = tbl or {}
    
    local sink_func = function(chunk, err)
        if chunk then
            tbl[#tbl + 1] = chunk
        end
        return 1
    end
    
    return sink_func, tbl
end

--[[
    简化数据槽
    将复杂数据槽转换为标准格式
    
    @param snk 原始数据槽
    @return 简化后的数据槽
]]
function sink.simplify(snk)
    return function(chunk, err)
        local result, new_snk_or_err = snk(chunk, err)
        
        if not result then
            return nil, new_snk_or_err
        end
        
        if new_snk_or_err then
            snk = new_snk_or_err
        end
        
        return 1
    end
end

--[[
    创建文件数据槽
    将数据写入文件
    
    @param file_handle 文件句柄
    @param io_err 打开文件时的错误
    @return 文件数据槽函数
]]
function sink.file(file_handle, io_err)
    if file_handle then
        return function(chunk, err)
            if chunk then
                local ok, write_err = file_handle:write(chunk)
                
                if not ok then
                    file_handle:close()
                    return nil, write_err
                end
            else
                file_handle:close()
            end
            
            return 1
        end
    else
        return sink.error(io_err or "unable to open file")
    end
end

--[[
    创建空数据槽
    丢弃所有数据
    
    @return 空数据槽函数
]]
function sink.null()
    return function(chunk, err)
        if chunk then
            return 1
        else
            return nil, err
        end
    end
end

--[[
    创建错误数据槽
    总是返回错误
    
    @param err 错误信息
    @return 错误数据槽函数
]]
function sink.error(err)
    return function()
        return nil, err
    end
end

--[[
    为数据槽添加过滤器
    
    @param flt 过滤器函数
    @param snk 原始数据槽
    @return 添加过滤器后的数据槽
]]
function sink.chain(flt, snk)
    return function(chunk, err)
        local filtered = flt(chunk)
        local result = snk(filtered, err)
        
        if filtered == "" then
            if chunk == "" then
                return 1
            elseif chunk then
                return result
            end
        else
            return result
        end
    end
end

-- ========================================
-- 数据泵（Pump）模块
-- 连接数据源和数据槽
-- ========================================
pump = {}

--[[
    单步数据传输
    从数据源读取一块数据并写入数据槽
    
    @param src 数据源
    @param snk 数据槽
    @return 成功返回 1，失败返回 nil 和错误信息
]]
function pump.step(src, snk)
    local chunk, src_err = src()
    local result, snk_err = snk(chunk, src_err)
    
    if chunk and result then
        return 1
    else
        return nil, snk_err or src_err
    end
end

--[[
    完整数据传输
    将数据源的所有数据传输到数据槽
    
    @param src 数据源
    @param snk 数据槽
    @param step_func 可选的步进函数
    @return 成功返回 1，失败返回 nil 和错误信息
]]
function pump.all(src, snk, step_func)
    step_func = step_func or pump.step
    
    while true do
        local result, err = step_func(src, snk)
        
        if not result then
            if err then
                return nil, err
            else
                return 1
            end
        end
    end
end
