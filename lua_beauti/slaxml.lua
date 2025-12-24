--[[
    SLAXML - 简单轻量级 XML 解析器
    一个基于 SAX 风格的流式 XML 解析器
    版本: 0.5.1
]]

-- 导入依赖
local stringLib = require("string")
local tableLib = require("table")

-- 注册为全局模块（兼容旧版 Lua）
local _G = _G
module("slaxml")

-- 模块定义
local slaxml = {}
slaxml.VERSION = "0.5.1"

-- 默认回调函数（用于调试输出）
local defaultCallbacks = {}

--[[
    处理 XML 处理指令
    @param target 处理指令目标（如 "xml"）
    @param content 处理指令内容
]]
function defaultCallbacks.pi(target, content)
    print(stringLib.format("<?%s %s?>", target, content))
end

--[[
    处理 XML 注释
    @param commentText 注释内容
]]
function defaultCallbacks.comment(commentText)
    print(stringLib.format("<!-- %s -->", commentText))
end

--[[
    处理元素开始标签
    @param elementName 元素名称
    @param namespace 命名空间（可选）
]]
function defaultCallbacks.startElement(elementName, namespace)
    local nsInfo = ""
    if namespace then
        nsInfo = " (" .. namespace .. ")"
    end
    print(stringLib.format("<%s%s>", elementName, nsInfo))
end

--[[
    处理元素属性
    @param attrName 属性名称
    @param attrValue 属性值
    @param namespace 命名空间（可选）
]]
function defaultCallbacks.attribute(attrName, attrValue, namespace)
    local nsInfo = ""
    if namespace then
        nsInfo = " (" .. namespace .. ")"
    end
    print(stringLib.format("  %s=%q%s", attrName, attrValue, nsInfo))
end

--[[
    处理文本内容
    @param textContent 文本内容
]]
function defaultCallbacks.text(textContent)
    print(stringLib.format("  text: %q", textContent))
end

--[[
    处理元素结束标签
    @param elementName 元素名称
    @param namespace 命名空间（可选）
]]
function defaultCallbacks.closeElement(elementName, namespace)
    print(stringLib.format("</%s>", elementName))
end

-- 设置默认回调
slaxml._call = defaultCallbacks

--[[
    创建 XML 解析器实例
    @param self 模块自身
    @param callbacks 自定义回调函数表（可选）
    @return 解析器实例
]]
function slaxml.parser(self, callbacks)
    local parser = {}
    
    -- 使用自定义回调或默认回调
    if callbacks then
        parser._call = callbacks
    else
        parser._call = self._call
    end
    
    -- 绑定解析方法
    parser.parse = slaxml.parse
    
    return parser
end

--[[
    解析 XML 文档
    @param self 解析器实例
    @param xmlContent XML 文档字符串
    @param options 解析选项表（可选）
        - stripWhitespace: 是否去除空白文本（默认 false）
]]
function slaxml.parse(self, xmlContent, options)
    -- 初始化选项
    if not options then
        options = { stripWhitespace = false }
    end
    
    -- 字符串操作函数引用
    local find = stringLib.find
    local sub = stringLib.sub
    local gsub = stringLib.gsub
    local char = stringLib.char
    local insert = tableLib.insert
    local remove = tableLib.remove
    
    -- 解析状态变量
    local matchStart, matchEnd, capture1, capture2, capture3 = nil, nil, nil, nil, nil
    local currentPos = 1              -- 当前解析位置
    local parseMode = "text"          -- 解析模式: "text" 或 "attributes"
    local textStartPos = 1            -- 文本开始位置
    local namespaceStack = {}         -- 命名空间栈
    local attributeList = {}          -- 当前元素的属性列表
    local currentElement = nil        -- 当前元素信息
    local currentNamespace = {}       -- 当前命名空间映射
    local attributeCount = 0          -- 属性计数
    
    -- XML 预定义实体
    local XML_ENTITIES = {
        lt = "<",
        gt = ">",
        amp = "&",
        quot = "\"",
        apos = "'"
    }
    
    --[[
        解码 XML 实体引用
        @param fullMatch 完整匹配
        @param isNumeric 是否为数字实体（"#" 或空）
        @param entityName 实体名称或数字
        @return 解码后的字符
    ]]
    local function decodeEntity(fullMatch, isNumeric, entityName)
        -- 查找预定义实体
        local decoded = XML_ENTITIES[entityName]
        
        if not decoded then
            -- 处理数字字符引用
            if isNumeric == "#" then
                decoded = char(tonumber(entityName))
            else
                -- 未知实体，保持原样
                decoded = fullMatch
            end
        end
        
        return decoded
    end
    
    --[[
        解码字符串中的所有实体引用
        @param str 包含实体引用的字符串
        @return 解码后的字符串
    ]]
    local function decodeEntities(str)
        return gsub(str, "(&(#?)([%d%a]+);)", decodeEntity)
    end
    
    --[[
        刷新并处理累积的文本内容
    ]]
    local function flushText()
        -- 检查是否有文本需要处理
        if textStartPos > currentPos then
            return
        end
        
        -- 检查是否有文本回调
        if not self._call.text then
            return
        end
        
        -- 提取文本内容
        local textContent = sub(xmlContent, textStartPos, currentPos - 1)
        
        -- 处理空白去除选项
        if options.stripWhitespace then
            textContent = gsub(textContent, "^%s+", "")
            textContent = gsub(textContent, "%s+$", "")
            if #textContent == 0 then
                textContent = nil
            end
        end
        
        -- 调用文本回调
        if textContent then
            self._call.text(decodeEntities(textContent))
        end
    end
    
    --[[
        尝试解析 XML 处理指令
        @return 是否成功解析
    ]]
    local function tryParsePI()
        matchStart, matchEnd, capture1, capture2 = find(xmlContent, "^<%?([:%a_][:%w_.-]*) ?(.-)%?>", currentPos)
        
        if matchStart then
            flushText()
            
            -- 调用处理指令回调
            if self._call.pi then
                self._call.pi(capture1, capture2)
            end
            
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            return true
        end
        
        return nil
    end
    
    --[[
        尝试解析 XML 注释
        @return 是否成功解析
    ]]
    local function tryParseComment()
        matchStart, matchEnd, capture1 = find(xmlContent, "^<!%-%-(.-)%-%->", currentPos)
        
        if matchStart then
            flushText()
            
            -- 调用注释回调
            if self._call.comment then
                self._call.comment(capture1)
            end
            
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            return true
        end
        
        return nil
    end
    
    --[[
        在命名空间栈中查找前缀对应的 URI
        @param prefix 命名空间前缀
        @return 命名空间 URI
    ]]
    local function lookupNamespace(prefix)
        -- 从栈顶向下查找
        for i = #namespaceStack, 1, -1 do
            if namespaceStack[i][prefix] then
                return namespaceStack[i][prefix]
            end
        end
        
        -- 未找到，添加到当前映射
        currentNamespace[prefix] = prefix
        return prefix
    end
    
    --[[
        尝试解析元素开始标签
        @return 是否成功解析
    ]]
    local function tryParseStartElement()
        -- 匹配开始标签
        matchStart, matchEnd, capture1 = find(xmlContent, "^<([:%a_][:%w_.-]*)", currentPos)
        
        if matchStart then
            flushText()
            
            -- 初始化新的命名空间作用域
            insert(namespaceStack, {})
            
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            -- 重置属性列表
            attributeList = {}
            attributeCount = 0
            
            -- 保存元素信息
            currentElement = { capture1, nil }
            
            -- 解析命名空间前缀
            local prefix, localName = stringLib.match(capture1, "^([^:]+):([^:]+)$")
            if prefix then
                -- 查找默认命名空间
                for i = #namespaceStack, 1, -1 do
                    if namespaceStack[i]["!"] then
                        currentElement[2] = namespaceStack[i]["!"]
                        break
                    end
                end
            else
                -- 无前缀，使用默认命名空间
                currentElement[1] = capture1
            end
            
            return true
        end
        
        return nil
    end
    
    --[[
        尝试解析元素属性
        @return 是否成功解析
    ]]
    local function tryParseAttribute()
        -- 匹配属性名
        matchStart, matchEnd, capture1 = find(xmlContent, "^%s+([:%a_][:%w_.-]*)%s*=%s*", currentPos)
        
        if matchStart then
            currentPos = matchEnd + 1
            
            -- 尝试匹配双引号属性值
            matchStart, matchEnd, capture2 = find(xmlContent, "^\"([^\"]*)\"", currentPos)
            
            if matchStart then
                currentPos = matchEnd + 1
                capture2 = decodeEntities(capture2)
            else
                -- 尝试匹配单引号属性值
                matchStart, matchEnd, capture2 = find(xmlContent, "^'([^']*)'", currentPos)
                
                if matchStart then
                    currentPos = matchEnd + 1
                    capture2 = decodeEntities(capture2)
                end
            end
        end
        
        -- 处理解析到的属性
        if capture1 and capture2 then
            local attr = { capture1, capture2 }
            
            -- 解析属性的命名空间前缀
            local prefix, localName = stringLib.match(capture1, "^([^:]+):([^:]+)$")
            
            if prefix then
                if prefix == "xmlns" then
                    -- 命名空间声明 xmlns:prefix="uri"
                    namespaceStack[#namespaceStack][localName] = capture2
                else
                    -- 带前缀的属性
                    attr[1] = localName
                    attr[3] = lookupNamespace(prefix)
                end
            else
                if capture1 == "xmlns" then
                    -- 默认命名空间声明 xmlns="uri"
                    namespaceStack[#namespaceStack]["!"] = capture2
                    currentElement[2] = capture2
                end
            end
            
            -- 添加到属性列表
            attributeCount = attributeCount + 1
            attributeList[attributeCount] = attr
            
            return true
        end
        
        return nil
    end
    
    --[[
        尝试解析 CDATA 节
        @return 是否成功解析
    ]]
    local function tryParseCDATA()
        matchStart, matchEnd, capture1 = find(xmlContent, "^<!%[CDATA%[(.-)%]%]>", currentPos)
        
        if matchStart then
            flushText()
            
            -- CDATA 内容作为文本处理
            if self._call.text then
                self._call.text(capture1)
            end
            
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            return true
        end
        
        return nil
    end
    
    --[[
        完成元素开始标签的解析
        处理属性并调用回调
        @return 是否为自闭合标签
    ]]
    local function finishStartElement()
        -- 匹配标签结束
        matchStart, matchEnd, capture1 = find(xmlContent, "^%s*(/?)>", currentPos)
        
        if matchStart then
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            -- 确定元素的命名空间
            local elementNS = currentElement[2]
            if not elementNS then
                -- 查找默认命名空间
                for i = #namespaceStack, 1, -1 do
                    if namespaceStack[i]["!"] then
                        elementNS = namespaceStack[i]["!"]
                        break
                    end
                end
            end
            
            -- 调用元素开始回调
            if self._call.startElement then
                self._call.startElement(currentElement[1], elementNS)
            end
            
            -- 调用属性回调
            if self._call.attribute then
                for i = 1, attributeCount do
                    self._call.attribute(tableLib.unpack(attributeList[i]))
                end
            end
            
            -- 处理自闭合标签
            if capture1 == "/" then
                -- 调用元素结束回调
                if self._call.closeElement then
                    self._call.closeElement(currentElement[1], elementNS)
                end
                
                -- 弹出命名空间作用域
                remove(namespaceStack)
            end
            
            -- 切换回文本模式
            parseMode = "text"
            
            return true
        end
        
        return nil
    end
    
    --[[
        尝试解析元素结束标签
        @return 是否成功解析
    ]]
    local function tryParseEndElement()
        -- 匹配带命名空间前缀的结束标签
        matchStart, matchEnd, capture1, capture2 = find(xmlContent, "^</([^:]+):([^>]+)>", currentPos)
        
        if matchStart then
            -- 查找命名空间
            local elementNS = nil
            for i = #namespaceStack, 1, -1 do
                if namespaceStack[i]["!"] then
                    elementNS = namespaceStack[i]["!"]
                    break
                end
            end
        else
            -- 匹配无前缀的结束标签
            matchStart, matchEnd, capture1 = find(xmlContent, "^</([^>]+)>", currentPos)
            
            if matchStart then
                -- 使用默认命名空间
                local elementNS = nil
            end
        end
        
        if matchStart then
            flushText()
            
            -- 调用元素结束回调
            if self._call.closeElement then
                self._call.closeElement(capture1 or capture2, elementNS)
            end
            
            -- 更新位置
            currentPos = matchEnd + 1
            textStartPos = currentPos
            
            -- 弹出命名空间作用域
            remove(namespaceStack)
            
            return true
        end
        
        return nil
    end
    
    -- 主解析循环
    while currentPos < #xmlContent do
        if parseMode == "text" then
            -- 文本模式：尝试解析各种 XML 结构
            if not tryParsePI() then
                if not tryParseComment() then
                    if not tryParseCDATA() then
                        if not tryParseEndElement() then
                            if tryParseStartElement() then
                                -- 进入属性解析模式
                                parseMode = "attributes"
                            else
                                -- 跳过普通文本字符
                                matchStart, matchEnd = find(xmlContent, "^[^<]+", currentPos)
                                currentPos = (matchEnd or currentPos) + 1
                            end
                        end
                    end
                end
            end
        elseif parseMode == "attributes" then
            -- 属性模式：解析元素属性
            if not tryParseAttribute() then
                if not finishStartElement() then
                    error("Was in an element and couldn't find attributes or the close.")
                end
            end
        end
    end
end

return slaxml
