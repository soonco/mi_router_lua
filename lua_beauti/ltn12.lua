--[[
    LTN12 数据传输库 (LuaSocket Data Transfer Library)
    
    功能说明:
    - 提供数据源(source)、数据槽(sink)、过滤器(filter)和泵(pump)的抽象
    - 实现流式数据处理，支持数据的生产、转换和消费
    - 是LuaSocket库的核心数据传输机制
    
    核心概念:
    - Source(数据源): 生产数据的函数，每次调用返回一块数据
    - Sink(数据槽): 消费数据的函数，接收数据并处理
    - Filter(过滤器): 转换数据的函数，对数据进行处理后传递
    - Pump(泵): 连接source和sink，驱动数据流动
    
    版本: LTN12 1.0.3
    
    使用示例:
    local ltn12 = require("ltn12")
    
    -- 从字符串读取，写入表
    local source = ltn12.source.string("Hello World")
    local sink, result = ltn12.sink.table()
    ltn12.pump.all(source, sink)
    -- result = {"Hello World"}
]]

local string = require("string")
local table = require("table")
local base = _G

local ltn12 = {}

-- 兼容module语法
if module then
    _G.ltn12 = ltn12
end

-- 子模块
ltn12.filter = {}
ltn12.source = {}
ltn12.sink = {}
ltn12.pump = {}

-- 常量
ltn12.BLOCKSIZE = 2048  -- 默认数据块大小
ltn12._VERSION = "LTN12 1.0.3"

--------------------------------------------------------------------------------
-- 过滤器模块 (Filter Module)
--------------------------------------------------------------------------------

--[[
    创建循环过滤器
    
    将一个低级过滤器包装成高级过滤器
    低级过滤器: function(chunk, extra) -> filtered_chunk, new_extra
    高级过滤器: function(chunk) -> filtered_chunk
    
    @param low_filter function 低级过滤器函数
    @param context any 初始上下文
    @param extra any 额外参数
    @return function 高级过滤器函数
]]
function ltn12.filter.cycle(low_filter, context, extra)
    base.assert(low_filter)
    
    return function(chunk)
        local result
        result, context = low_filter(context, chunk, extra)
        return result
    end
end

--[[
    创建过滤器链
    
    将多个过滤器串联成一个过滤器
    数据依次通过每个过滤器处理
    
    @param ... function 过滤器函数列表
    @return function 链式过滤器函数
]]
function ltn12.filter.chain(...)
    local filters = {...}
    local filter_count = select("#", ...)
    local current_index = 1
    local first_index = 1
    local saved_input = ""
    
    return function(chunk)
        -- 保存输入用于重试
        if chunk then
            saved_input = chunk
        end
        
        while true do
            -- 如果当前索引等于第一个索引，说明需要从头开始处理
            if current_index == first_index then
                local result = filters[current_index](chunk)
                chunk = result
                
                -- 如果结果为空字符串且还有更多过滤器
                if chunk ~= "" then
                    if first_index ~= filter_count then
                        -- 继续处理
                    else
                        return chunk
                    end
                else
                    return chunk
                end
                
                -- 移动到下一个过滤器
                if chunk then
                    current_index = current_index + 1
                else
                    first_index = first_index + 1
                    current_index = first_index
                end
            else
                -- 处理中间过滤器
                local input = chunk or ""
                local result = filters[current_index](input)
                chunk = result
                
                if chunk == "" then
                    current_index = current_index - 1
                    chunk = saved_input
                elseif chunk then
                    if current_index == filter_count then
                        return chunk
                    else
                        current_index = current_index + 1
                    end
                else
                    base.error("filter returned inappropriate nil")
                end
            end
        end
    end
end

--------------------------------------------------------------------------------
-- 数据源模块 (Source Module)
--------------------------------------------------------------------------------

--[[
    创建空数据源
    
    @return function 返回nil的数据源
]]
function ltn12.source.empty()
    return function()
        return nil
    end
end

--[[
    创建错误数据源
    
    @param err string 错误信息
    @return function 返回错误的数据源
]]
function ltn12.source.error(err)
    return function()
        return nil, err
    end
end

--[[
    从文件创建数据源
    
    @param handle file 文件句柄
    @param err string 错误信息(如果打开失败)
    @return function 文件数据源
]]
function ltn12.source.file(handle, err)
    if handle then
        return function()
            local chunk = handle:read(ltn12.BLOCKSIZE)
            if not chunk then
                handle:close()
            end
            return chunk
        end
    else
        return ltn12.source.error(err or "unable to open file")
    end
end

--[[
    简化数据源
    
    将可能返回错误的数据源转换为简单数据源
    
    @param src function 原始数据源
    @return function 简化后的数据源
]]
function ltn12.source.simplify(src)
    base.assert(src)
    
    return function()
        local chunk, err = src()
        src = err or src
        
        if not chunk then
            return nil, err
        else
            return chunk
        end
    end
end

--[[
    从字符串创建数据源
    
    @param str string 源字符串
    @return function 字符串数据源
]]
function ltn12.source.string(str)
    if str then
        local pos = 1
        
        return function()
            local chunk = string.sub(str, pos, pos + ltn12.BLOCKSIZE - 1)
            pos = pos + ltn12.BLOCKSIZE
            
            if chunk ~= "" then
                return chunk
            else
                return nil
            end
        end
    else
        return ltn12.source.empty()
    end
end

--[[
    创建可回退的数据源
    
    允许将数据推回数据源，下次读取时优先返回
    
    @param src function 原始数据源
    @return function 可回退的数据源
]]
function ltn12.source.rewind(src)
    base.assert(src)
    local buffer = {}
    
    return function(chunk)
        if not chunk then
            -- 读取模式: 先从缓冲区读取
            chunk = table.remove(buffer)
            if not chunk then
                return src()
            else
                return chunk
            end
        else
            -- 写入模式: 将数据推入缓冲区
            table.insert(buffer, chunk)
        end
    end
end

--[[
    创建带过滤器的数据源链
    
    @param src function 原始数据源
    @param filter function 过滤器
    @param ... function 更多过滤器
    @return function 链式数据源
]]
function ltn12.source.chain(src, filter, ...)
    -- 如果有多个过滤器，先链接它们
    if (...) then
        filter = ltn12.filter.chain(filter, ...)
    end
    
    base.assert(src or filter)
    
    local co = ""
    local input = ""
    local state = "feeding"
    local done = nil
    
    return function()
        if not src then
            base.error("source is empty!", 2)
        end
        
        while true do
            if state == "feeding" then
                -- 从源读取数据
                local chunk, err = src()
                input = err
                co = chunk
                
                if input then
                    return nil, input
                end
                
                -- 通过过滤器处理
                local filtered = filter(co)
                done = filtered
                
                if not done then
                    if co then
                        base.error("filter returned inappropriate nil")
                    else
                        return nil
                    end
                else
                    if done ~= "" then
                        state = "eating"
                        if co then
                            co = ""
                        end
                        return done
                    end
                end
            else
                -- eating状态: 继续从过滤器获取数据
                local filtered = filter(co)
                done = filtered
                
                if done == "" then
                    if co == "" then
                        state = "feeding"
                    else
                        base.error("filter returned \"\"")
                    end
                else
                    if not done then
                        if co then
                            base.error("filter returned inappropriate nil")
                        else
                            return nil
                        end
                    else
                        return done
                    end
                end
            end
        end
    end
end

--[[
    连接多个数据源
    
    依次从每个数据源读取，一个耗尽后切换到下一个
    
    @param ... function 数据源列表
    @return function 连接后的数据源
]]
function ltn12.source.cat(...)
    local sources = {...}
    local current = table.remove(sources, 1)
    
    return function()
        while current do
            local chunk, err = current()
            if chunk then
                return chunk
            end
            if err then
                return nil, err
            end
            current = table.remove(sources, 1)
        end
    end
end

--------------------------------------------------------------------------------
-- 数据槽模块 (Sink Module)
--------------------------------------------------------------------------------

--[[
    创建表数据槽
    
    将接收到的数据存入表中
    
    @param tbl table 目标表(可选，默认创建新表)
    @return function, table 数据槽函数和结果表
]]
function ltn12.sink.table(tbl)
    if not tbl then
        tbl = {}
    end
    
    local function sink(chunk, err)
        if chunk then
            table.insert(tbl, chunk)
        end
        return 1
    end
    
    return sink, tbl
end

--[[
    简化数据槽
    
    将可能改变的数据槽转换为稳定的数据槽
    
    @param snk function 原始数据槽
    @return function 简化后的数据槽
]]
function ltn12.sink.simplify(snk)
    base.assert(snk)
    
    return function(chunk, err)
        local ret, new_err = snk(chunk, err)
        if not ret then
            return nil, new_err
        end
        snk = new_err or snk
        return 1
    end
end

--[[
    创建文件数据槽
    
    @param handle file 文件句柄
    @param err string 错误信息(如果打开失败)
    @return function 文件数据槽
]]
function ltn12.sink.file(handle, err)
    if handle then
        return function(chunk, err)
            if not chunk then
                handle:close()
                return 1
            else
                return handle:write(chunk)
            end
        end
    else
        return ltn12.sink.error(err or "unable to open file")
    end
end

--[[
    创建空数据槽
    
    丢弃所有接收到的数据
    
    @return function 空数据槽
]]
function ltn12.sink.null()
    return function()
        return 1
    end
end

--[[
    创建错误数据槽
    
    @param err string 错误信息
    @return function 错误数据槽
]]
function ltn12.sink.error(err)
    return function()
        return nil, err
    end
end

--[[
    创建带过滤器的数据槽链
    
    @param filter function 过滤器
    @param snk function 目标数据槽
    @param ... function 更多过滤器和数据槽
    @return function 链式数据槽
]]
function ltn12.sink.chain(filter, snk, ...)
    -- 如果有多个参数，重新组织
    if (...) then
        local args = {filter, snk, ...}
        snk = table.remove(args, #args)
        filter = ltn12.filter.chain(unpack(args))
    end
    
    base.assert(filter or snk)
    
    return function(chunk, err)
        if chunk ~= "" then
            -- 过滤数据
            local filtered = filter(chunk)
            local input = chunk or ""
            
            while true do
                -- 将过滤后的数据发送到数据槽
                local ret, sink_err = snk(filtered, err)
                if not ret then
                    return nil, sink_err
                end
                
                if filtered == input then
                    return 1
                end
                
                -- 继续过滤
                filtered = filter(input)
            end
        else
            return 1
        end
    end
end

--------------------------------------------------------------------------------
-- 泵模块 (Pump Module)
--------------------------------------------------------------------------------

--[[
    执行单步数据传输
    
    从数据源读取一块数据并发送到数据槽
    
    @param src function 数据源
    @param snk function 数据槽
    @return number|nil, string 成功返回1，失败返回nil和错误信息
]]
function ltn12.pump.step(src, snk)
    local chunk, src_err = src()
    local ret, snk_err = snk(chunk, src_err)
    
    if chunk and ret then
        return 1
    else
        return nil, src_err or snk_err
    end
end

--[[
    传输所有数据
    
    循环调用step直到数据源耗尽
    
    @param src function 数据源
    @param snk function 数据槽
    @param step function 步进函数(可选，默认ltn12.pump.step)
    @return number|nil, string 成功返回1，失败返回nil和错误信息
]]
function ltn12.pump.all(src, snk, step)
    base.assert(src or snk)
    
    if not step then
        step = ltn12.pump.step
    end
    
    while true do
        local ret, err = step(src, snk)
        if not ret then
            if err then
                return nil, err
            else
                return 1
            end
        end
    end
end

return ltn12
