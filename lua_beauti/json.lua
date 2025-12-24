--[[
    JSON 编解码模块 (JSON Encode/Decode Module)
    
    功能说明:
    - 提供JSON格式的编码(Lua值转JSON字符串)和解码(JSON字符串转Lua值)功能
    - 支持所有JSON数据类型: null, boolean, number, string, array, object
    - 自动检测Lua表是数组还是对象
    - 支持JSON注释(/* */)
    
    使用示例:
    local json = require("json")
    
    -- 编码
    local str = json.encode({name = "test", value = 123})
    -- 结果: {"name":"test","value":123}
    
    -- 解码
    local obj = json.decode('{"name":"test","value":123}')
    -- 结果: {name = "test", value = 123}
    
    依赖模块:
    - math: 数学函数
    - string: 字符串操作
    - table: 表操作
]]

local math = require("math")
local string = require("string")
local table = require("table")
local base = _G

module("json")

local decode_scanArray
local decode_scanComment
local decode_scanConstant
local decode_scanNumber
local decode_scanObject
local decode_scanString
local decode_scanWhitespace
local encodeString
local isArray
local isEncodable

--[[
    将Lua值编码为JSON字符串
    
    @param value any Lua值(nil, boolean, number, string, table)
    @return string JSON字符串
]]
function encode(value)
    -- nil 编码为 "null"
    if value == nil then
        return "null"
    end
    
    local value_type = base.type(value)
    
    -- 字符串: 添加引号并转义
    if value_type == "string" then
        return "\"" .. encodeString(value) .. "\""
    end
    
    -- 数字和布尔值: 直接转换为字符串
    if value_type == "number" or value_type == "boolean" then
        return base.tostring(value)
    end
    
    -- 表: 根据是否为数组决定编码方式
    if value_type == "table" then
        local result = {}
        local is_array, array_len = isArray(value)
        
        if is_array then
            -- 数组编码: [elem1, elem2, ...]
            for i = 1, array_len do
                table.insert(result, encode(value[i]))
            end
            return "[" .. table.concat(result, ",") .. "]"
        else
            -- 对象编码: {"key1":value1, "key2":value2, ...}
            for key, val in base.pairs(value) do
                if isEncodable(key) and isEncodable(val) then
                    table.insert(result, "\"" .. encodeString(key) .. "\":" .. encode(val))
                end
            end
            return "{" .. table.concat(result, ",") .. "}"
        end
    end
    
    -- 函数类型: 检查是否为null函数
    if value_type == "function" then
        if value == null then
            return "null"
        end
    end
    
    -- 不支持的类型
    base.assert(false, "encode attempt to encode unsupported type " .. value_type .. ": " .. base.tostring(value))
end

--[[
    将JSON字符串解码为Lua值
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置(可选，默认1)
    @return any, number 解码后的Lua值和结束位置
]]
function decode(json_str, start_pos)
    start_pos = start_pos or 1
    
    -- 跳过空白字符
    start_pos = decode_scanWhitespace(json_str, start_pos)
    
    -- 验证位置有效
    base.assert(
        start_pos <= string.len(json_str),
        "Unterminated JSON encoded object found at position in [" .. json_str .. "]"
    )
    
    -- 获取当前字符，决定解码方式
    local current_char = string.sub(json_str, start_pos, start_pos)
    
    -- 对象: {...}
    if current_char == "{" then
        return decode_scanObject(json_str, start_pos)
    end
    
    -- 数组: [...]
    if current_char == "[" then
        return decode_scanArray(json_str, start_pos)
    end
    
    -- 数字: 以数字或符号开头
    if string.find("+-0123456789.e", current_char, 1, true) then
        return decode_scanNumber(json_str, start_pos)
    end
    
    -- 字符串: 以引号开头
    if current_char == "\"" or current_char == "'" then
        return decode_scanString(json_str, start_pos)
    end
    
    -- 注释: /* ... */
    local two_chars = string.sub(json_str, start_pos, start_pos + 1)
    if two_chars == "/*" then
        return decode(json_str, decode_scanComment(json_str, start_pos))
    end
    
    -- 常量: true, false, null
    return decode_scanConstant(json_str, start_pos)
end

--[[
    JSON null值
    
    返回一个特殊函数表示JSON的null值
    
    @return function null函数
]]
function null()
    return null
end

--[[
    扫描JSON数组
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return table, number 数组和结束位置
]]
decode_scanArray = function(json_str, start_pos)
    local result = {}
    local str_len = string.len(json_str)
    
    -- 验证数组开始
    base.assert(
        string.sub(json_str, start_pos, start_pos) == "[",
        "decode_scanArray called but array does not start at position " .. start_pos .. " in string:\n" .. json_str
    )
    
    start_pos = start_pos + 1
    
    repeat
        -- 跳过空白
        start_pos = decode_scanWhitespace(json_str, start_pos)
        base.assert(str_len >= start_pos, "JSON String ended unexpectedly scanning array.")
        
        local current_char = string.sub(json_str, start_pos, start_pos)
        
        -- 数组结束
        if current_char == "]" then
            return result, start_pos + 1
        end
        
        -- 跳过逗号
        if current_char == "," then
            start_pos = decode_scanWhitespace(json_str, start_pos + 1)
        end
        
        base.assert(str_len >= start_pos, "JSON String ended unexpectedly scanning array.")
        
        -- 解码元素
        local element
        element, start_pos = decode(json_str, start_pos)
        table.insert(result, element)
    until false
end

--[[
    扫描JSON注释
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return number 注释结束后的位置
]]
decode_scanComment = function(json_str, start_pos)
    base.assert(
        string.sub(json_str, start_pos, start_pos + 1) == "/*",
        "decode_scanComment called but comment does not start at position " .. start_pos
    )
    
    -- 查找注释结束位置
    local end_pos = string.find(json_str, "*/", start_pos + 2)
    
    base.assert(end_pos ~= nil, "Unterminated comment in string at " .. start_pos)
    
    return end_pos + 2
end

--[[
    扫描JSON常量(true, false, null)
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return any, number 常量值和结束位置
]]
decode_scanConstant = function(json_str, start_pos)
    -- 常量值映射
    local constants = {
        ["true"] = true,
        ["false"] = false,
        ["null"] = nil
    }
    
    -- 常量名称列表
    local constant_names = {"true", "false", "null"}
    
    for _, name in base.ipairs(constant_names) do
        local end_pos = start_pos + string.len(name) - 1
        local substr = string.sub(json_str, start_pos, end_pos)
        
        if substr == name then
            return constants[name], start_pos + string.len(name)
        end
    end
    
    base.assert(false, "Failed to scan constant from string " .. json_str .. " at starting position " .. start_pos)
end

--[[
    扫描JSON数字
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return number, number 数字值和结束位置
]]
decode_scanNumber = function(json_str, start_pos)
    local end_pos = start_pos + 1
    local str_len = string.len(json_str)
    local number_chars = "+-0123456789.e"
    
    -- 扫描所有数字字符
    while true do
        local char = string.sub(json_str, end_pos, end_pos)
        if not (string.find(number_chars, char, 1, true) and end_pos <= str_len) then
            break
        end
        end_pos = end_pos + 1
    end
    
    -- 构建并执行数字解析
    local number_str = "return " .. string.sub(json_str, start_pos, end_pos - 1)
    local number_func = base.loadstring(number_str)
    
    base.assert(
        number_func,
        "Failed to scan number [ " .. number_str .. "] in JSON string at position " .. start_pos .. " : " .. end_pos
    )
    
    return number_func(), end_pos
end

--[[
    扫描JSON对象
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return table, number 对象和结束位置
]]
decode_scanObject = function(json_str, start_pos)
    local result = {}
    local str_len = string.len(json_str)
    local key, value
    
    -- 验证对象开始
    base.assert(
        string.sub(json_str, start_pos, start_pos) == "{",
        "decode_scanObject called but object does not start at position " .. start_pos .. " in string:\n" .. json_str
    )
    
    start_pos = start_pos + 1
    
    repeat
        -- 跳过空白
        start_pos = decode_scanWhitespace(json_str, start_pos)
        base.assert(str_len >= start_pos, "JSON string ended unexpectedly while scanning object.")
        
        local current_char = string.sub(json_str, start_pos, start_pos)
        
        -- 对象结束
        if current_char == "}" then
            return result, start_pos + 1
        end
        
        -- 跳过逗号
        if current_char == "," then
            start_pos = decode_scanWhitespace(json_str, start_pos + 1)
        end
        
        base.assert(str_len >= start_pos, "JSON string ended unexpectedly scanning object.")
        
        -- 解码键
        key, start_pos = decode(json_str, start_pos)
        
        base.assert(str_len >= start_pos, "JSON string ended unexpectedly searching for value of key " .. key)
        
        -- 跳过空白
        start_pos = decode_scanWhitespace(json_str, start_pos)
        
        base.assert(str_len >= start_pos, "JSON string ended unexpectedly searching for value of key " .. key)
        
        -- 验证冒号
        base.assert(
            string.sub(json_str, start_pos, start_pos) == ":",
            "JSON object key-value assignment mal-formed at " .. start_pos
        )
        
        -- 跳过冒号和空白
        start_pos = decode_scanWhitespace(json_str, start_pos + 1)
        
        base.assert(str_len >= start_pos, "JSON string ended unexpectedly searching for value of key " .. key)
        
        -- 解码值
        value, start_pos = decode(json_str, start_pos)
        
        result[key] = value
    until false
end

--[[
    扫描JSON字符串
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return string, number 字符串值和结束位置
]]
decode_scanString = function(json_str, start_pos)
    base.assert(start_pos, "decode_scanString(..) called without start position")
    
    local quote_char = string.sub(json_str, start_pos, start_pos)
    
    base.assert(
        quote_char == "'" or quote_char == "\"",
        "decode_scanString called for a non-string"
    )
    
    local escaped = false
    local end_pos = start_pos + 1
    local found_end = false
    local str_len = string.len(json_str)
    
    repeat
        local char = string.sub(json_str, end_pos, end_pos)
        
        if not escaped then
            if char == "\\" then
                escaped = true
            else
                found_end = (char == quote_char)
            end
        else
            escaped = false
        end
        
        end_pos = end_pos + 1
        
        base.assert(
            end_pos <= str_len + 1,
            "String decoding failed: unterminated string at position " .. end_pos
        )
    until found_end
    
    -- 使用loadstring解析字符串(处理转义序列)
    local string_code = "return " .. string.sub(json_str, start_pos, end_pos - 1)
    local string_func = base.loadstring(string_code)
    
    base.assert(
        string_func,
        "Failed to load string [ " .. string_code .. "] in JSON4Lua.decode_scanString at position " .. start_pos .. " : " .. end_pos
    )
    
    return string_func(), end_pos
end

--[[
    跳过空白字符
    
    @param json_str string JSON字符串
    @param start_pos number 起始位置
    @return number 非空白字符的位置
]]
decode_scanWhitespace = function(json_str, start_pos)
    local whitespace = " \n\r\t"
    local str_len = string.len(json_str)
    
    while true do
        local char = string.sub(json_str, start_pos, start_pos)
        if not (string.find(whitespace, char, 1, true) and start_pos <= str_len) then
            break
        end
        start_pos = start_pos + 1
    end
    
    return start_pos
end

--[[
    转义字符串中的特殊字符
    
    @param str string 原始字符串
    @return string 转义后的字符串
]]
encodeString = function(str)
    -- 转义反斜杠
    str = string.gsub(str, "\\", "\\\\")
    -- 转义双引号
    str = string.gsub(str, "\"", "\\\"")
    -- 转义单引号
    str = string.gsub(str, "'", "\\'")
    -- 转义换行符
    str = string.gsub(str, "\n", "\\n")
    -- 转义制表符
    str = string.gsub(str, "\t", "\\t")
    
    return str
end

--[[
    检测表是否为数组
    
    数组的条件:
    1. 所有键都是正整数
    2. 键从1开始连续
    3. 所有值都是可编码的
    
    @param tbl table 要检测的表
    @return boolean, number 是否为数组，数组长度
]]
isArray = function(tbl)
    local max_index = 0
    
    for key, value in base.pairs(tbl) do
        local key_type = base.type(key)
        
        if key_type == "number" then
            -- 键必须是正整数
            if math.floor(key) == key and key >= 1 then
                -- 值必须可编码
                if not isEncodable(value) then
                    return false
                end
                max_index = math.max(max_index, key)
            end
        elseif key == "n" then
            -- 特殊处理 table.getn 的 n 字段
            if value ~= table.getn(tbl) then
                return false
            end
        else
            -- 非数字键，不是数组
            if isEncodable(value) then
                return false
            end
        end
    end
    
    return true, max_index
end

--[[
    检测值是否可编码为JSON
    
    @param value any 要检测的值
    @return boolean 是否可编码
]]
isEncodable = function(value)
    local value_type = base.type(value)
    return value_type == "string" or value_type == "boolean" or value_type == "number" or value_type == "nil" or value_type == "table"
end
