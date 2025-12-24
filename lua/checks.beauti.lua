--[[
================================================================================
参数类型检查模块 (Parameter Type Checking Module)
================================================================================

功能说明：
  本模块提供函数参数类型检查功能，类似于静态类型语言的参数验证。
  可以在运行时检查函数参数是否符合预期类型。

主要接口：
  - checks(type1, type2, ...) : 检查当前函数的参数类型

支持的类型说明符：
  - "string"   : 字符串类型
  - "number"   : 数字类型
  - "table"    : 表类型
  - "function" : 函数类型
  - "boolean"  : 布尔类型
  - "?"        : 可选参数（允许 nil）
  - "?string"  : 可选字符串（字符串或 nil）
  - 自定义类型 : 通过 checkers 表扩展

使用示例：
  function greet(name, age)
      checks("string", "number")
      print("Hello, " .. name .. ", age " .. age)
  end
  
  greet("Alice", 25)  -- 正常
  greet(123, "abc")   -- 抛出类型错误

自定义类型检查器：
  checkers.positive = function(v)
      return type(v) == "number" and v > 0
  end
  
  function setCount(n)
      checks("positive")
  end

================================================================================
--]]

--[[
--------------------------------------------------------------------------------
内部函数: checkArgument(level, argName, value, expectedType)
--------------------------------------------------------------------------------
功能: 检查单个参数的类型

参数:
  level        - 调用栈层级
  argName      - 参数名称（用于错误信息）
  value        - 参数值
  expectedType - 期望的类型字符串

返回值:
  boolean - true 表示类型匹配

说明:
  - 如果类型以 "?" 开头，表示可选参数，允许 nil
  - 支持多个类型用 "|" 分隔，如 "string|number"
  - 支持自定义类型检查器
--------------------------------------------------------------------------------
--]]
local function checkArgument(level, argName, value, expectedType)
    level = level + 1
    
    if expectedType == "?" then
        return true
    else
        local isOptional = expectedType:match("^%?(.-)$")
        if isOptional and value == nil then
            return true
        end
    end
    
    local allowedTypes = {}
    for typeName in expectedType:gmatch("[^|]+") do
        allowedTypes[typeName] = true
    end
    
    local actualType = type(value)
    if allowedTypes[actualType] == true then
        return true
    end
    
    local metaType = value and type(value) == "table" and value.__type
    if metaType and allowedTypes[metaType] == true then
        return true
    end
    
    for typeName, _ in pairs(allowedTypes) do
        local checker = _G.checkers and _G.checkers[typeName]
        if type(checker) == "function" then
            if checker(value) == true then
                return true
            end
        end
    end
    
    local funcInfo = debug.getinfo(level, "nl")
    local errorMsg = string.format(
        "bad argument %s to %s (%s expected, got %s)",
        argName,
        funcInfo.name,
        expectedType,
        type(value)
    )
    error(errorMsg, level)
end

--[[
--------------------------------------------------------------------------------
内部函数: checkTableArgument(level, argName, schema, value)
--------------------------------------------------------------------------------
功能: 检查表类型参数的内部结构

参数:
  level   - 调用栈层级
  argName - 参数名称
  schema  - 表结构定义
  value   - 参数值（表）

说明:
  用于检查表参数的各个字段是否符合预期类型。
--------------------------------------------------------------------------------
--]]
local function checkTableArgument(level, argName, schema, value)
    level = level + 1
    
    for fieldName, fieldType in pairs(schema) do
        if type(fieldType) == "string" then
        elseif type(fieldType) == "table" then
            value[fieldName] = value[fieldName] or {}
        else
            error(string.format("checks: type %q is not supported", type(fieldType)), level)
        end
    end
    
    for fieldName, fieldType in pairs(schema) do
        local fullName = string.format("%s.%s", argName, fieldName)
        local fieldValue = value[fieldName]
        
        if not fieldValue then
            local funcInfo = debug.getinfo(level, "nl")
            error(string.format("unexpected argument %s to %s", fullName, funcInfo.name), level)
        else
            if type(fieldValue) == "string" then
                checkArgument(level, fullName, fieldType, fieldValue)
            elseif type(fieldValue) == "table" then
                checkArgument(level, fullName, fieldType, "?table")
                if fieldType then
                    checkTableArgument(level, fullName, fieldType, fieldValue)
                end
            end
        end
    end
end

--[[
--------------------------------------------------------------------------------
函数: checks(...)
--------------------------------------------------------------------------------
功能: 检查当前函数的所有参数类型

参数:
  ... - 各参数的期望类型字符串

说明:
  此函数应在被检查函数的开头调用。
  它会自动获取调用函数的参数并进行类型检查。
  
  如果类型不匹配，会抛出详细的错误信息，包括：
  - 参数位置
  - 函数名称
  - 期望类型
  - 实际类型

使用示例：
  function add(a, b)
      checks("number", "number")
      return a + b
  end
--------------------------------------------------------------------------------
--]]
local function checks(...)
    local expectedTypes = {...}
    local level = 2
    
    if type(expectedTypes[1]) == "number" then
        level = expectedTypes[1]
        table.remove(expectedTypes, 1)
    end
    level = level + 1
    
    for i = 1, #expectedTypes do
        local expectedType = expectedTypes[i]
        local argName, argValue = debug.getlocal(level, i)
        
        if expectedType == nil and argName == nil then
            break
        elseif expectedType == nil then
            error(string.format("checks: argument %q is not checked", argName), level)
        elseif argName == nil then
            error(string.format("checks: excess check, absent argument"), level)
        else
            if type(expectedType) == "string" then
                checkArgument(level, string.format("#%d", i), argValue, expectedType)
            elseif type(expectedType) == "table" then
                checkArgument(level, string.format("#%d", i), argValue, "?table")
                local tableValue = argValue or {}
                checkTableArgument(level, argName, tableValue, expectedType)
                debug.setlocal(level, i, tableValue)
            else
                error(string.format("checks: type %q is not supported", type(expectedType)), level)
            end
        end
    end
end

_G.checks = checks
_G.checkers = rawget(_G, "checkers") or {}

return checks
