--[[
    LuCI JSON 编解码模块
    提供 JSON 数据的编码和解码功能
    
    主要功能:
    - JSON 解码（字符串 -> Lua 表）
    - JSON 编码（Lua 表 -> 字符串）
    - 支持流式解码
    - 支持自定义 null 值处理
]]

local math = require("math")
local string = require("string")
local table = require("table")
local util = require("luci.util")

local getmetatable = getmetatable
local setmetatable = setmetatable
local rawset = rawset
local error = error
local type = type
local tostring = tostring
local tonumber = tonumber
local pairs = pairs
local ipairs = ipairs
local next = next
local pcall = pcall

module("luci.json")

-- ========================================
-- JSON null 值处理
-- ========================================

--[[
    创建 null 值对象
    用于表示 JSON 中的 null
]]
function null()
    return nil
end

-- ========================================
-- JSON 解码器
-- ========================================

Decoder = util.class()

--[[
    创建 JSON 解码器
    
    @param source 数据源函数
    @param custom_null 自定义 null 值
]]
function Decoder:__init__(source, custom_null)
    self.source = source
    self.custom_null = custom_null
    
    self.chunk = nil
    self.position = 0
    
    getmetatable(self).__call = Decoder.get
end

--[[
    获取解码后的值
    
    @return 解码后的 Lua 值
]]
function Decoder:get()
    local value = self:_dispatch()
    self:_skip_whitespace()
    
    if self:_peek_char() then
        self:_error("Unexpected character after root element")
    end
    
    return value
end

--[[
    分发到对应的解析函数
]]
function Decoder:_dispatch()
    self:_skip_whitespace()
    
    local char = self:_peek_char()
    
    if not char then
        self:_error("Unexpected EOF")
    end
    
    local parser_map = {
        ['"'] = self._parse_string,
        ['t'] = self._parse_true,
        ['f'] = self._parse_false,
        ['n'] = self._parse_null,
        ['['] = self._parse_array,
        ['{'] = self._parse_object
    }
    
    local parser = parser_map[char]
    
    if parser then
        return parser(self)
    elseif char == '-' or (char >= '0' and char <= '9') then
        return self:_parse_number()
    else
        self:_error("Unexpected character '" .. char .. "'")
    end
end

--[[
    获取下一个字符（不移动位置）
]]
function Decoder:_peek_char()
    if not self.chunk or self.position > #self.chunk then
        local new_chunk = self.source()
        
        if not new_chunk then
            return nil
        end
        
        self.chunk = new_chunk
        self.position = 1
    end
    
    return self.chunk:sub(self.position, self.position)
end

--[[
    获取下一个字符（移动位置）
]]
function Decoder:_get_char()
    local char = self:_peek_char()
    
    if char then
        self.position = self.position + 1
    end
    
    return char
end

--[[
    跳过空白字符
]]
function Decoder:_skip_whitespace()
    while true do
        local char = self:_peek_char()
        
        if not char then
            break
        end
        
        if char == ' ' or char == '\t' or char == '\n' or char == '\r' then
            self.position = self.position + 1
        else
            break
        end
    end
end

--[[
    抛出解析错误
]]
function Decoder:_error(message)
    error("JSON parse error at position " .. self.position .. ": " .. message)
end

--[[
    解析字符串
]]
function Decoder:_parse_string()
    self:_get_char()
    
    local parts = {}
    local escape_map = {
        ['"'] = '"',
        ['\\'] = '\\',
        ['/'] = '/',
        ['b'] = '\b',
        ['f'] = '\f',
        ['n'] = '\n',
        ['r'] = '\r',
        ['t'] = '\t'
    }
    
    while true do
        local char = self:_get_char()
        
        if not char then
            self:_error("Unterminated string")
        end
        
        if char == '"' then
            break
        elseif char == '\\' then
            local escape_char = self:_get_char()
            
            if not escape_char then
                self:_error("Unterminated escape sequence")
            end
            
            if escape_map[escape_char] then
                parts[#parts + 1] = escape_map[escape_char]
            elseif escape_char == 'u' then
                local hex = ""
                for i = 1, 4 do
                    local hex_char = self:_get_char()
                    if not hex_char then
                        self:_error("Invalid unicode escape")
                    end
                    hex = hex .. hex_char
                end
                
                local codepoint = tonumber(hex, 16)
                if not codepoint then
                    self:_error("Invalid unicode escape")
                end
                
                if codepoint < 128 then
                    parts[#parts + 1] = string.char(codepoint)
                elseif codepoint < 2048 then
                    parts[#parts + 1] = string.char(
                        192 + math.floor(codepoint / 64),
                        128 + (codepoint % 64)
                    )
                else
                    parts[#parts + 1] = string.char(
                        224 + math.floor(codepoint / 4096),
                        128 + math.floor((codepoint % 4096) / 64),
                        128 + (codepoint % 64)
                    )
                end
            else
                self:_error("Invalid escape character")
            end
        else
            parts[#parts + 1] = char
        end
    end
    
    return table.concat(parts)
end

--[[
    解析数字
]]
function Decoder:_parse_number()
    local num_str = ""
    
    local char = self:_peek_char()
    if char == '-' then
        num_str = num_str .. self:_get_char()
    end
    
    while true do
        char = self:_peek_char()
        
        if not char then
            break
        end
        
        if char >= '0' and char <= '9' then
            num_str = num_str .. self:_get_char()
        elseif char == '.' or char == 'e' or char == 'E' or char == '+' or char == '-' then
            num_str = num_str .. self:_get_char()
        else
            break
        end
    end
    
    local num = tonumber(num_str)
    
    if not num then
        self:_error("Invalid number: " .. num_str)
    end
    
    return num
end

--[[
    解析 true
]]
function Decoder:_parse_true()
    if self:_get_char() == 't' and
       self:_get_char() == 'r' and
       self:_get_char() == 'u' and
       self:_get_char() == 'e' then
        return true
    end
    
    self:_error("Invalid literal")
end

--[[
    解析 false
]]
function Decoder:_parse_false()
    if self:_get_char() == 'f' and
       self:_get_char() == 'a' and
       self:_get_char() == 'l' and
       self:_get_char() == 's' and
       self:_get_char() == 'e' then
        return false
    end
    
    self:_error("Invalid literal")
end

--[[
    解析 null
]]
function Decoder:_parse_null()
    if self:_get_char() == 'n' and
       self:_get_char() == 'u' and
       self:_get_char() == 'l' and
       self:_get_char() == 'l' then
        return self.custom_null
    end
    
    self:_error("Invalid literal")
end

--[[
    解析数组
]]
function Decoder:_parse_array()
    self:_get_char()
    
    local result = {}
    local index = 1
    
    self:_skip_whitespace()
    
    if self:_peek_char() == ']' then
        self:_get_char()
        return result
    end
    
    while true do
        result[index] = self:_dispatch()
        index = index + 1
        
        self:_skip_whitespace()
        
        local char = self:_get_char()
        
        if char == ']' then
            break
        elseif char ~= ',' then
            self:_error("Expected ',' or ']'")
        end
    end
    
    return result
end

--[[
    解析对象
]]
function Decoder:_parse_object()
    self:_get_char()
    
    local result = {}
    
    self:_skip_whitespace()
    
    if self:_peek_char() == '}' then
        self:_get_char()
        return result
    end
    
    while true do
        self:_skip_whitespace()
        
        if self:_peek_char() ~= '"' then
            self:_error("Expected string key")
        end
        
        local key = self:_parse_string()
        
        self:_skip_whitespace()
        
        if self:_get_char() ~= ':' then
            self:_error("Expected ':'")
        end
        
        result[key] = self:_dispatch()
        
        self:_skip_whitespace()
        
        local char = self:_get_char()
        
        if char == '}' then
            break
        elseif char ~= ',' then
            self:_error("Expected ',' or '}'")
        end
    end
    
    return result
end

-- ========================================
-- JSON 编码器
-- ========================================

Encoder = util.class()

--[[
    创建 JSON 编码器
    
    @param data 要编码的数据
    @param is_array 是否强制作为数组处理
]]
function Encoder:__init__(data, is_array)
    self.data = data
    self.is_array = is_array
    
    getmetatable(self).__call = Encoder.source
end

--[[
    获取编码后的 JSON 字符串
    
    @return 编码后的字符串
]]
function Encoder:source()
    local result = self:_encode(self.data)
    self.data = nil
    return result
end

--[[
    编码值
]]
function Encoder:_encode(value)
    local value_type = type(value)
    
    if value_type == "nil" then
        return "null"
    elseif value_type == "boolean" then
        return value and "true" or "false"
    elseif value_type == "number" then
        if value ~= value then
            return "null"
        elseif value == math.huge or value == -math.huge then
            return "null"
        else
            return tostring(value)
        end
    elseif value_type == "string" then
        return self:_encode_string(value)
    elseif value_type == "table" then
        return self:_encode_table(value)
    else
        return "null"
    end
end

--[[
    编码字符串
]]
function Encoder:_encode_string(str)
    local escape_map = {
        ['"'] = '\\"',
        ['\\'] = '\\\\',
        ['\b'] = '\\b',
        ['\f'] = '\\f',
        ['\n'] = '\\n',
        ['\r'] = '\\r',
        ['\t'] = '\\t'
    }
    
    local result = str:gsub('[%z\001-\031"\\]', function(char)
        if escape_map[char] then
            return escape_map[char]
        else
            return string.format("\\u%04x", string.byte(char))
        end
    end)
    
    return '"' .. result .. '"'
end

--[[
    编码表
]]
function Encoder:_encode_table(tbl)
    local is_array = self.is_array
    
    if not is_array then
        local max_index = 0
        local count = 0
        
        for key, _ in pairs(tbl) do
            count = count + 1
            if type(key) == "number" and key > 0 and math.floor(key) == key then
                if key > max_index then
                    max_index = key
                end
            else
                is_array = false
                break
            end
        end
        
        if is_array == nil then
            is_array = (max_index == count)
        end
    end
    
    if is_array then
        return self:_encode_array(tbl)
    else
        return self:_encode_object(tbl)
    end
end

--[[
    编码数组
]]
function Encoder:_encode_array(arr)
    local parts = {}
    
    for i, value in ipairs(arr) do
        parts[i] = self:_encode(value)
    end
    
    return "[" .. table.concat(parts, ",") .. "]"
end

--[[
    编码对象
]]
function Encoder:_encode_object(obj)
    local parts = {}
    
    for key, value in pairs(obj) do
        local key_str = tostring(key)
        parts[#parts + 1] = self:_encode_string(key_str) .. ":" .. self:_encode(value)
    end
    
    return "{" .. table.concat(parts, ",") .. "}"
end

-- ========================================
-- 便捷函数
-- ========================================

--[[
    解码 JSON 字符串
    
    @param json_str JSON 字符串
    @return 解码后的 Lua 值
]]
function decode(json_str)
    local pos = 1
    
    local function source()
        if pos <= #json_str then
            local chunk = json_str:sub(pos)
            pos = #json_str + 1
            return chunk
        end
        return nil
    end
    
    local decoder = Decoder(source)
    return decoder:get()
end

--[[
    编码 Lua 值为 JSON 字符串
    
    @param value Lua 值
    @return JSON 字符串
]]
function encode(value)
    local encoder = Encoder(value)
    return encoder:source()
end

--[[
    创建活动解码器
    用于流式解码
    
    @param source 数据源函数
    @param custom_null 自定义 null 值
    @return 解码器对象
]]
function ActiveDecoder(source, custom_null)
    return Decoder(source, custom_null)
end
