--[[
  XQParam 参数验证工具模块
  
  功能说明：
  - 提供输入参数验证功能
  - 支持多种验证规则（正则、函数、命名检查器）
  - 内置常用验证器（MAC地址、IP地址、JSON等）
  
  主要验证器：
  - commonstr: 通用安全字符串验证（防注入）
  - engXnumstr: 英文+数字字符串验证
  - numberstr: 纯数字字符串验证
  - macaddr: MAC地址验证
  - ip4addr: IPv4地址验证
  - ip6addr: IPv6地址验证
  - json: JSON格式验证
]]

module("xiaoqiang.util.XQParam", package.seeall)

local checkers = require("checks")
local cjson = require("cjson")
local datatypes = require("luci.cbi.datatypes")

local verifyRules = {}

-- 集合验证：检查值是否在给定集合中
-- @param value 待验证的值
-- @param validSet 有效值集合（table类型）
-- @return boolean 是否在集合中
function verifyRules.set(value, validSet)
    local isValid = false
    if validSet then
        local valueType = type(validSet)
        if valueType == "table" then
            for _, item in ipairs(validSet) do
                if value == item then
                    isValid = true
                    break
                end
            end
        end
    end
    return isValid
end

-- 正则表达式验证
-- @param value 待验证的值
-- @param pattern 正则表达式模式
-- @return boolean 是否匹配
function verifyRules.regex(value, pattern)
    if pattern then
        local patternType = type(pattern)
        if patternType == "string" then
            local matched = string.match(value, pattern)
            if matched then
                return true
            end
        end
    end
    return false
end

-- 函数验证：使用自定义函数进行验证
-- @param value 待验证的值
-- @param config 验证配置 {rule=前置规则, func=验证函数, farg=函数参数}
-- @return boolean 验证结果
function verifyRules.func(value, config)
    local isValid = true
    
    local preRule = config.rule
    if preRule then
        local preResult = verify(value, config.rule)
        isValid = preResult
    end
    
    local funcType = type(config.func)
    if funcType == "function" then
        if isValid then
            local funcResult = config.func(value, config.farg)
            isValid = funcResult
        end
    else
        isValid = false
    end
    
    local resultType = type(isValid)
    if resultType == "boolean" then
        return isValid
    else
        return false
    end
end

-- 命名检查器验证：使用预定义的检查器进行验证
-- @param value 待验证的值
-- @param config 验证配置 {name=检查器名称, arg=检查器参数}
-- @return boolean 验证结果
local function namedCheckerVerify(value, config)
    local checkerName = config.name
    if checkerName then
        local checker = checkers[checkerName]
        if checker then
            return checker(value, config.arg)
        end
    end
    return false
end

-- 类型检查辅助函数
-- @param value 待检查的值
-- @param expectedType 期望的类型
local function typeCheck(value, expectedType)
    checkers(expectedType, "string")
end

-- 主验证函数
-- @param value 待验证的值
-- @param rule 验证规则（字符串或table）
-- @return boolean 验证结果
function verify(value, rule)
    local isValid = false
    local ruleType = type(rule)
    
    if ruleType == "string" then
        local success, _ = pcall(typeCheck, value, rule)
        isValid = success
    elseif ruleType == "table" then
        local result = namedCheckerVerify(value, rule)
        isValid = result
    end
    
    return isValid
end

-- ==================== 内置检查器 ====================

-- 通用安全字符串检查器
-- 防止命令注入，禁止特殊字符：` ; > | $ & 和换行符
-- @param value 待验证的字符串
-- @return boolean 是否安全
checkers.commonstr = function(value)
    local pattern = [[^[^`;>|$&
]+$]]
    return verifyRules.regex(value, pattern)
end

-- 英文+数字字符串检查器
-- 只允许英文字母和数字
-- @param value 待验证的字符串
-- @return boolean 是否匹配
checkers.engXnumstr = function(value)
    local pattern = "^[a-zA-Z0-9]+$"
    return verifyRules.regex(value, pattern)
end

-- 纯数字字符串检查器
-- 只允许数字字符
-- @param value 待验证的字符串
-- @return boolean 是否匹配
checkers.numberstr = function(value)
    local pattern = "^[0-9]+$"
    return verifyRules.regex(value, pattern)
end

-- MAC地址检查器
-- 使用luci.cbi.datatypes进行验证
-- @param value 待验证的MAC地址
-- @return boolean 是否有效
checkers.macaddr = function(value)
    return datatypes.macaddr(value)
end

-- IPv4地址检查器
-- 使用luci.cbi.datatypes进行验证
-- @param value 待验证的IPv4地址
-- @return boolean 是否有效
checkers.ip4addr = function(value)
    return datatypes.ip4addr(value)
end

-- IPv6地址检查器
-- 使用luci.cbi.datatypes进行验证
-- @param value 待验证的IPv6地址
-- @return boolean 是否有效
checkers.ip6addr = function(value)
    return datatypes.ip6addr(value)
end

-- JSON格式检查器
-- 尝试解析JSON，成功则有效
-- @param value 待验证的JSON字符串
-- @return boolean 是否有效
checkers.json = function(value)
    local success, _ = pcall(cjson.decode, value)
    return success
end
