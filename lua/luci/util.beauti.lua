--[[
LuCI 核心工具模块
luci.util - Core Utility Module

该模块提供 LuCI 框架的核心工具函数：
- 面向对象支持（class, instanceof）
- 线程本地存储（threadlocal）
- 字符串处理（split, trim, pcdata, striptags）
- 表操作（clone, keys, contains, update, append, combine）
- 数据序列化（serialize_data, restore_data, get_bytecode）
- 迭代器（imatch, spairs, kspairs, vspairs）
- 命令执行（exec, execi, execl）
- 协程安全调用（coxpcall, copcall）
]]--

local io = require("io")
local math = require("math")
local table = require("table")
local debug = require("debug")
require("luci.debug")
local string = require("string")
local coroutine = require("coroutine")
local parser = require("luci.template.parser")

local getmetatable = getmetatable
local setmetatable = setmetatable
local rawget = rawget
local rawset = rawset
local unpack = unpack
local tostring = tostring
local type = type
local assert = assert
local ipairs = ipairs
local pairs = pairs
local next = next
local loadstring = loadstring
local require = require
local pcall = pcall
local xpcall = xpcall
local collectgarbage = collectgarbage
local get_memory_limit = get_memory_limit

module("luci.util")

local stringMeta = getmetatable("")

function stringMeta.__mod(formatStr, args)
    if not args then
        return formatStr
    elseif type(args) == "table" then
        for key, value in pairs(args) do
            if type(args[key]) == "userdata" then
                args[key] = tostring(args[key])
            end
        end
        return formatStr:format(unpack(args))
    else
        if type(args) == "userdata" then
            args = tostring(args)
        end
        return formatStr:format(args)
    end
end

local function classCall(class, ...)
    local instance = setmetatable({}, { __index = class })
    if instance.__init__ then
        instance:__init__(...)
    end
    return instance
end

function class(base)
    return setmetatable({}, {
        __call = classCall,
        __index = base
    })
end

function instanceof(object, targetClass)
    local meta = getmetatable(object)
    while meta do
        if not meta.__index then
            break
        end
        if meta.__index == targetClass then
            return true
        end
        meta = getmetatable(meta.__index)
    end
    return false
end

local threadLocalMeta = {}
threadLocalMeta.__mode = "k"

function threadLocalMeta.__index(self, key)
    local thread = coxpt[coroutine.running()]
    if not thread then
        thread = coroutine.running() or 0
    end
    local data = rawget(self, thread)
    if data then
        return data[key]
    end
    return nil
end

function threadLocalMeta.__newindex(self, key, value)
    local thread = coxpt[coroutine.running()]
    if not thread then
        thread = coroutine.running() or 0
    end
    local data = rawget(self, thread)
    if not data then
        rawset(self, thread, { [key] = value })
    else
        rawget(self, thread)[key] = value
    end
end

function threadlocal(initialData)
    return setmetatable(initialData or {}, threadLocalMeta)
end

function perror(message)
    return io.stderr:write(tostring(message) .. "\n")
end

function dumptable(tbl, maxDepth, currentDepth, visited)
    currentDepth = currentDepth or 0
    if not visited then
        visited = {}
        visited.__mode = "k"
    end
    
    for key, value in pairs(tbl) do
        perror(string.rep("\t", currentDepth) .. tostring(key) .. "\t" .. tostring(value))
        
        if type(value) == "table" and (not maxDepth or maxDepth > currentDepth) then
            if not visited[value] then
                visited[value] = true
                dumptable(value, maxDepth, currentDepth + 1, visited)
            else
                perror(string.rep("\t", currentDepth) .. "*** RECURSION ***")
            end
        end
    end
end

function pcdata(text)
    if text then
        return parser.pcdata(tostring(text))
    end
    return text
end

function striptags(text)
    if text then
        return parser.striptags(tostring(text))
    end
    return text
end

function split(str, delimiter, limit, plain)
    delimiter = delimiter or " "
    limit = limit or -1
    local result = {}
    local startPos = 1
    
    if #str == 0 then
        return { "" }
    end
    
    if #delimiter == 0 then
        return nil
    end
    
    if limit == 0 then
        return str
    end
    
    repeat
        local matchStart, matchEnd = str:find(delimiter, startPos, not plain)
        limit = limit - 1
        
        if matchStart and limit < 0 then
            result[#result + 1] = str:sub(startPos)
        else
            result[#result + 1] = str:sub(startPos, matchStart and matchStart - 1)
        end
        
        if matchEnd then
            startPos = matchEnd + 1
        else
            startPos = #str + 1
        end
    until not matchStart or limit < 0
    
    return result
end

function trim(str)
    return str:gsub("^%s*(.-)%s*$", "%1")
end

function cmatch(str, pattern)
    local count = 0
    for _ in str:gmatch(pattern) do
        count = count + 1
    end
    return count
end

function imatch(value)
    if type(value) == "table" then
        local index = nil
        return function()
            index = next(value, index)
            return value[index]
        end
    elseif type(value) == "number" or type(value) == "boolean" then
        local done = true
        return function()
            if done then
                done = false
                return tostring(value)
            end
        end
    elseif type(value) == "userdata" or type(value) == "string" then
        return tostring(value):gmatch("%S+")
    end
    
    return function() end
end

function parse_units(expr)
    local total = 0
    local units = {
        y = 31622400,
        m = 2678400,
        w = 604800,
        d = 86400,
        h = 3600,
        min = 60,
        kb = 1024,
        mb = 1048576,
        gb = 1073741824,
        kib = 1000,
        mib = 1000000,
        gib = 1000000000
    }
    
    for token in imatch(expr) do
        local number = token:gsub("[^0-9%.]+$", "")
        local unit = token:gsub("^[0-9%.]+", "")
        
        local multiplier = units[unit]
        if not multiplier then
            multiplier = units[unit:sub(1, 1)]
            if not multiplier then
                total = total + number
                goto continue
            end
        end
        
        multiplier = units[unit] or units[unit:sub(1, 1)]
        total = total + number * multiplier
        ::continue::
    end
    
    return total
end

string.pcdata = pcdata
string.striptags = striptags
string.split = split
string.trim = trim
string.cmatch = cmatch
string.parse_units = parse_units

function append(tbl, ...)
    local args = { ... }
    for _, item in ipairs(args) do
        if type(item) == "table" then
            for _, value in ipairs(item) do
                tbl[#tbl + 1] = value
            end
        else
            tbl[#tbl + 1] = item
        end
    end
    return tbl
end

function combine(...)
    return append({}, ...)
end

function contains(tbl, value)
    for _, v in ipairs(tbl) do
        if value == v then
            return true
        end
    end
    return false
end

function update(target, source)
    for key, value in pairs(source) do
        target[key] = value
    end
end

function keys(tbl)
    local result = {}
    if tbl then
        for key, _ in pairs(tbl) do
            result[#result + 1] = key
        end
    end
    return result
end

function clone(tbl, deep)
    local result = {}
    for key, value in pairs(tbl) do
        if deep then
            if type(value) == "table" then
                value = clone(value, deep)
            end
        end
        result[key] = value
    end
    local meta = getmetatable(tbl)
    if meta then
        setmetatable(result, meta)
    end
    return result
end

function dtable()
    return setmetatable({}, {
        __index = function(self, key)
            local value = rawget(self, key)
            if not value then
                value = dtable()
                rawset(self, key, value)
            end
            return value
        end
    })
end

function _serialize_table(tbl)
    local hashPart = ""
    local arrayPart = ""
    local maxIndex = 0
    
    for key, value in pairs(tbl) do
        if type(key) == "number" and key >= 1 and math.floor(key) == key and key - #tbl <= 3 then
            if maxIndex < key then
                maxIndex = key
            end
        else
            local serializedKey = _serialize_data(key)
            local serializedValue = _serialize_data(value)
            hashPart = hashPart .. (#hashPart > 0 and ", " or "") .. "[" .. serializedKey .. "] = " .. serializedValue
        end
    end
    
    for i = 1, maxIndex do
        local serializedValue = _serialize_data(tbl[i])
        arrayPart = arrayPart .. (#arrayPart > 0 and ", " or "") .. serializedValue
    end
    
    if #arrayPart > 0 and #hashPart > 0 then
        return arrayPart .. ", " .. hashPart
    elseif #arrayPart > 0 then
        return arrayPart
    else
        return hashPart
    end
end

function serialize_data(data)
    assert(not hasRecursion(data), "Recursion detected.")
    return _serialize_data(data)
end

function _serialize_data(data)
    if data == nil then
        return "nil"
    elseif type(data) == "number" then
        return data
    elseif type(data) == "string" then
        return "%q" % data
    elseif type(data) == "boolean" then
        return data and "true" or "false"
    elseif type(data) == "function" then
        return "loadstring(%q)" % get_bytecode(data)
    elseif type(data) == "table" then
        return "{ " .. _serialize_table(data) .. " }"
    else
        return "\"[unhandled data type:" .. type(data) .. "]\""
    end
end

function hasRecursion(data)
    if data == nil or type(data) ~= "table" then
        return false
    end
    local visited = {}
    visited[data] = true
    return hasR(data, visited)
end

function hasR(tbl, visited)
    for key, value in pairs(tbl) do
        if type(key) == "table" then
            if visited[key] then
                local current = tbl
                while true do
                    if current == key then
                        return true
                    else
                        current = visited[current]
                        if not current then
                            break
                        end
                    end
                end
            end
            visited[key] = tbl
            if hasR(key, visited) then
                return true
            end
        end
        
        if type(value) == "table" then
            if visited[value] then
                local current = tbl
                while true do
                    if current == value then
                        return true
                    else
                        current = visited[current]
                        if not current then
                            break
                        end
                    end
                end
            end
            visited[value] = tbl
            if hasR(value, visited) then
                return true
            end
        end
    end
    return false
end

function restore_data(str)
    local loader = loadstring("return " .. str)
    return loader()
end

function get_bytecode(data)
    local bytecode
    if type(data) == "function" then
        bytecode = string.dump(data)
    else
        bytecode = string.dump(loadstring("return " .. serialize_data(data)))
    end
    return bytecode
end

function strip_bytecode(bytecode)
    local byte1, byte2, byte3, byte4, byte5, byte6, byte7, byte8 = bytecode:byte(5, 12)
    
    local readInt
    if byte3 == 1 then
        readInt = function(data, pos, size)
            local result = 0
            for i = size, 1, -1 do
                result = result * 256 + data:byte(pos + i - 1)
            end
            return result, pos + size
        end
    else
        readInt = function(data, pos, size)
            local result = 0
            for i = 1, size do
                result = result * 256 + data:byte(pos + i - 1)
            end
            return result, pos + size
        end
    end
    
    local function stripFunction(data)
        local pos = 13
        local result = { data:sub(1, 12) }
        
        local sourceLen
        sourceLen, pos = readInt(data, pos, byte6)
        pos = pos + sourceLen
        
        local lineStart, lineEnd
        lineStart, pos = readInt(data, pos, byte5)
        lineEnd, pos = readInt(data, pos, byte5)
        
        result[#result + 1] = string.rep("\0", byte6)
        result[#result + 1] = data:sub(pos - byte5 * 2, pos - 1)
        
        local numUpvalues, numParams, isVararg, maxStack
        numUpvalues = data:byte(pos)
        numParams = data:byte(pos + 1)
        isVararg = data:byte(pos + 2)
        maxStack = data:byte(pos + 3)
        pos = pos + 4
        
        result[#result + 1] = string.char(numUpvalues, numParams, isVararg, maxStack)
        
        local codeSize
        codeSize, pos = readInt(data, pos, byte5)
        local codeEnd = pos + codeSize * byte7
        result[#result + 1] = data:sub(pos - byte5, codeEnd - 1)
        pos = codeEnd
        
        local numConstants
        numConstants, pos = readInt(data, pos, byte5)
        
        local constStart = pos
        for i = 1, numConstants do
            local constType = data:byte(pos)
            pos = pos + 1
            
            if constType == 1 then
                pos = pos + 1
            elseif constType == 4 then
                local strLen
                strLen, pos = readInt(data, pos, byte6)
                pos = pos + strLen
            elseif constType == 3 then
                pos = pos + byte8
            elseif constType == 254 or constType == 9 then
                pos = pos + byte5 * 2
            end
        end
        
        result[#result + 1] = data:sub(constStart - byte5, pos - 1)
        
        local numFunctions
        numFunctions, pos = readInt(data, pos, byte5)
        result[#result + 1] = data:sub(pos - byte5, pos - 1)
        
        for i = 1, numFunctions do
            local funcData, funcLen = stripFunction(data:sub(pos))
            result[#result + 1] = funcData
            pos = pos + funcLen - 1
        end
        
        local numLineInfo
        numLineInfo, pos = readInt(data, pos, byte5)
        pos = pos + numLineInfo * byte5
        
        local numLocals
        numLocals, pos = readInt(data, pos, byte5)
        for i = 1, numLocals do
            local nameLen
            nameLen, pos = readInt(data, pos, byte6)
            pos = pos + nameLen + byte5 * 2
        end
        
        local numUpvalueNames
        numUpvalueNames, pos = readInt(data, pos, byte5)
        for i = 1, numUpvalueNames do
            local nameLen
            nameLen, pos = readInt(data, pos, byte6)
            pos = pos + nameLen
        end
        
        result[#result + 1] = string.rep("\0", byte5 * 3)
        
        return table.concat(result), pos
    end
    
    local header = bytecode:sub(1, 12)
    local stripped = stripFunction(bytecode:sub(13))
    return header .. stripped
end

function _sortiter(tbl, sortFunc)
    local keys = {}
    for key, _ in pairs(tbl) do
        keys[#keys + 1] = key
    end
    table.sort(keys, sortFunc)
    
    local index = 0
    return function()
        index = index + 1
        local key = keys[index]
        if key then
            return key, tbl[key]
        end
    end
end

function spairs(tbl, sortFunc)
    return _sortiter(tbl, sortFunc)
end

function kspairs(tbl)
    return _sortiter(tbl)
end

function vspairs(tbl)
    return _sortiter(tbl, function(a, b)
        return tbl[a] < tbl[b]
    end)
end

function bigendian()
    local bytecode = string.dump(function() end)
    return string.byte(bytecode, 7) == 0
end

function exec(command)
    local pipe = io.popen(command)
    local output = pipe:read("*a")
    pipe:close()
    return output
end

function execi(command)
    local pipe = io.popen(command)
    if pipe then
        return function()
            local line = pipe:read()
            if not line then
                pipe:close()
            end
            return line
        end
    end
    return pipe
end

function execl(command)
    local pipe = io.popen(command)
    local lines = {}
    while true do
        local line = pipe:read()
        if line == nil then
            break
        end
        lines[#lines + 1] = line
    end
    pipe:close()
    return lines
end

function libpath()
    local fs = require("nixio.fs")
    return fs.dirname(debug.__file__)
end

coxpt = {}
setmetatable(coxpt, { __mode = "kv" })

local function handleCoroutineResult(handler, co, success, ...)
    if not success then
        return false, handler(debug.traceback(co, ...))
    end
    
    if coroutine.status(co) ~= "suspended" then
        return true, ...
    end
    
    return handleCoroutineResult(handler, co, coroutine.yield(...))
end

local function resumeCoroutine(handler, co, ...)
    return handleCoroutineResult(handler, co, coroutine.resume(co, ...))
end

function coxpcall(func, handler, ...)
    local success, co = pcall(coroutine.create, func)
    
    if not success then
        local args = { ... }
        local wrapper = function()
            return func(unpack(args))
        end
        co = coroutine.create(wrapper)
    end
    
    local parentThread = coxpt[coroutine.running()]
    if not parentThread then
        parentThread = coroutine.running() or 0
    end
    coxpt[co] = parentThread
    
    return resumeCoroutine(handler, co, ...)
end

function copcall(func, ...)
    return coxpcall(func, function(err) return err end, ...)
end

function exec_trim(command, default)
    default = default or ""
    if not command then
        return default
    end
    
    local output = exec(command)
    if output then
        return trim(output)
    else
        return default
    end
end
