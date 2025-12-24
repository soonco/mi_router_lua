--[[
    XSS 过滤器模块
    用于过滤和清理 HTML 内容中的潜在 XSS（跨站脚本攻击）代码
    支持白名单标签、属性验证和自定义处理器
]]

module("xssFilter", package.seeall)

-- 尝试加载 iconv 库（用于 UTF-8 编码验证）
local iconvLoaded, iconv = pcall(require, "iconv")

--[[
    替换标签处理器
    将不允许的标签替换为可见的提示信息
    @param match 匹配的完整内容
    @param tagName 标签名称
    @param reason 移除原因（可选）
    @param content 标签内容
    @return 替换后的字符串
]]
function REPLACE_TAGS(match, tagName, reason, content)
    local result = "<code>[HTML tag &lt;" .. tagName .. "&gt; removed"
    if reason then
        result = result .. ": " .. reason
    end
    result = result .. "]</code>"
    return result
end

--[[
    移除标签处理器
    直接返回标签内的内容，移除标签本身
    @param match 匹配的完整内容
    @param tagName 标签名称
    @param reason 移除原因
    @param content 标签内容
    @return 标签内容
]]
function REMOVE_TAGS(match, tagName, reason, content)
    return content
end

-- 允许的 HTML 标签白名单
ALLOWED_TAGS = {
    -- 段落和标题
    "p", "h1", "h2", "h3", "h4", "h5", "h6",
    -- 列表
    "ul", "ol", "li", "dl", "dt", "dd",
    -- 换行
    "br",
    -- 文本格式化
    "em", "strong", "i", "b",
    -- 引用和代码
    "blockquote", "pre", "code",
    -- 缩写和引用
    "acronym", "abbr", "cite", "dfn",
    -- 其他文本样式
    "tt", "del", "ins", "kbd", "strike", "sub", "sup", "var",
    -- 表格
    "table", "tr", "thead", "caption", "tbody", "tfoot",
    -- 布局和样式
    "big", "center", "right", "left", "hr", "style", "div",
    
    -- span 标签（带属性限制）
    span = {
        style = ".",  -- 允许 style 属性
        --[[
            span 标签的自定义验证函数
            检查 style 属性中是否包含 url（防止 CSS 注入）
            @param element 元素对象
            @return 是否通过验证, 错误信息
        ]]
        _test = function(element)
            if element.xarg.style then
                if element.xarg.style:find("url") then
                    return nil, "'url' not allowed in the value of 'style'"
                end
            end
            return true
        end
    },
    
    -- th 表头单元格（允许合并属性）
    th = {
        colspan = ".",
        rowspan = "."
    },
    
    -- td 表格单元格（允许合并属性）
    td = {
        colspan = ".",
        rowspan = "."
    }
}

-- 额外允许的标签（特殊处理）
EXTRA_TAGS = {
    -- object 标签（仅允许 SVG 图像）
    object = {
        data = "http://",  -- data 属性必须以 http:// 开头
        --[[
            object 标签的自定义验证函数
            仅允许 SVG 图像类型
            @param element 元素对象
            @return 是否通过验证, 错误信息
        ]]
        _test = function(element)
            if element.xarg.type == "image/svg+xml" then
                return true
            else
                return false, "only 'image/svg+xml' is allowed for 'type'"
            end
        end
    }
}

-- 通用属性白名单（所有标签都可以使用）
GENERIC_ATTRIBUTES = {
    class = ".",   -- CSS 类名
    alt = ".",     -- 替代文本
    title = "."    -- 标题提示
}

-- XSSFilter 类定义
local XSSFilter = {}
local XSSFilterMeta = {
    __metatable = {},
    __index = XSSFilter
}

--[[
    创建新的 XSS 过滤器实例
    @param allowedTags 允许的标签配置（可选，默认使用 ALLOWED_TAGS）
    @param genericAttrs 通用属性配置（可选，默认使用 GENERIC_ATTRIBUTES）
    @param tagsHandler 标签处理函数（可选，默认使用 REPLACE_TAGS）
    @return XSSFilter 实例
]]
function new(allowedTags, genericAttrs, tagsHandler)
    local instance = setmetatable({}, XSSFilterMeta)
    
    -- 初始化配置
    instance:init(allowedTags)
    
    -- 如果 iconv 库可用，创建 UTF-8 转换器
    if iconvLoaded then
        instance.utf8_converter = iconv.new("UTF8", "UTF8")
    end
    
    -- 设置标签处理器
    instance.tags_handler = tagsHandler or REPLACE_TAGS
    
    return instance
end

--[[
    初始化过滤器配置
    @param allowedTags 允许的标签配置
    @param genericAttrs 通用属性配置
]]
function XSSFilter:init(allowedTags, genericAttrs)
    -- 设置允许的标签
    self.allowed_tags = allowedTags or ALLOWED_TAGS
    
    -- 将数组形式的标签转换为表形式
    for _, tagName in ipairs(self.allowed_tags) do
        self.allowed_tags[tagName] = self.allowed_tags[tagName] or {}
    end
    
    -- 设置通用属性
    self.generic_attributes = genericAttrs or GENERIC_ATTRIBUTES
end

--[[
    解析 HTML 属性字符串
    @param attrString 属性字符串
    @return 属性表
]]
local function parseAttributes(attrString)
    local attrs = {}
    string.gsub(attrString, "(%w+)=([\"'])(.-)%2", function(name, quote, value)
        attrs[name] = value
    end)
    return attrs
end

--[[
    解析 XML/HTML 字符串为 DOM 树
    @param xmlString XML/HTML 字符串
    @return DOM 树结构
]]
local function parseXML(xmlString)
    local stack = {}          -- 元素栈
    local top = {}            -- 当前顶层元素
    table.insert(stack, top)
    
    local matchStart, matchEnd, isClosing, tagName, attrString, isSelfClosing
    local pos = 1
    local lastPos = 1
    
    while true do
        -- 查找下一个标签
        matchStart, matchEnd, isClosing, tagName, attrString, isSelfClosing = 
            string.find(xmlString, "<(%/?)(%w+)(.-)(%/?)>", pos)
        
        if not matchStart then
            break
        end
        
        -- 处理标签前的文本
        local textBefore = string.sub(xmlString, pos, matchStart - 1)
        table.insert(top, textBefore)
        
        if isSelfClosing == "/" then
            -- 自闭合标签
            table.insert(top, {
                label = tagName,
                xarg = parseAttributes(attrString),
                empty = 1
            })
        elseif isClosing == "" then
            -- 开始标签
            local element = {
                label = tagName,
                xarg = parseAttributes(attrString)
            }
            top = element
            table.insert(stack, top)
        else
            -- 结束标签
            local element = table.remove(stack)
            local stackSize = #stack
            top = stack[stackSize]
            
            if stackSize < 1 then
                error("nothing to close with " .. tagName)
            end
            
            if element.label ~= tagName then
                error("trying to close " .. element.label .. " with " .. tagName)
            end
            
            table.insert(top, element)
        end
        
        pos = matchEnd + 1
    end
    
    -- 处理剩余文本
    local remainingText = string.sub(xmlString, pos)
    if not string.find(remainingText, "^%s*$") then
        table.insert(stack[#stack], remainingText)
    end
    
    -- 检查是否有未闭合的标签
    if #stack > 1 then
        error("unclosed " .. stack[#stack].label)
    end
    
    return stack[1]
end

--[[
    检查字符串是否匹配指定模式
    @param str 要检查的字符串
    @param patterns 模式列表（字符串或表）
    @return 是否匹配
]]
local function matchesPattern(str, patterns)
    patterns = patterns or {}
    
    if type(patterns) == "string" then
        patterns = { patterns }
    end
    
    for _, pattern in ipairs(patterns) do
        if str:find(pattern) then
            return true
        end
    end
    
    return false
end

--[[
    默认验证函数（始终返回 true）
    @return true
]]
local function defaultValidator()
    return true
end

--[[
    过滤 HTML 内容
    移除或替换不安全的标签和属性
    @param htmlContent HTML 内容字符串
    @return 过滤后的 HTML 字符串, 错误信息（如果有）
]]
function XSSFilter:filter(htmlContent)
    -- UTF-8 编码验证
    if self.utf8_converter then
        local out, err = self.utf8_converter:iconv(htmlContent)
        if err then
            htmlContent = "[Invalid UTF8 - removed by XSSFilter]"
        end
    end
    
    -- 尝试解析 HTML
    local success, parsedXML = pcall(parseXML, "<xml>" .. htmlContent .. "</xml>")
    
    if not success then
        local escapedContent = htmlContent:gsub("<", "&lt;"):gsub(">", "&gt;")
        return nil, "XSSFilter could not parse (X)HTML:\n" .. escapedContent
    end
    
    local result = ""
    
    --[[
        递归将 DOM 树转换为安全的 HTML 字符串
        @param element DOM 元素
    ]]
    local function xml2string(element)
        for _, child in ipairs(element) do
            if type(child) == "string" then
                -- 文本节点直接添加
                result = result .. child
            elseif type(child) == "table" then
                -- 元素节点需要验证
                local tagConfig = self.allowed_tags[child.label]
                
                if not tagConfig then
                    -- 标签不在白名单中，使用处理器处理
                    result = result .. self.tags_handler(nil, child.label, nil, child[1])
                else
                    -- 验证标签
                    local validator = tagConfig._test or defaultValidator
                    local isValid, errorMsg = validator(child)
                    
                    if not isValid then
                        -- 验证失败
                        result = result .. self.tags_handler(nil, child.label, errorMsg, child[1])
                    else
                        -- 验证通过，构建标签
                        result = result .. "<" .. child.label
                        
                        -- 处理属性
                        for attrName, attrValue in pairs(child.xarg) do
                            local attrConfig = tagConfig[attrName]
                            
                            if not attrConfig then
                                attrConfig = self.generic_attributes[attrName]
                            end
                            
                            -- 检查属性是否允许
                            if matchesPattern(attrValue, attrConfig) then
                                local escapedValue = attrValue:gsub("\"", "&quot;")
                                result = result .. " " .. attrName .. "=\"" .. escapedValue .. "\""
                            end
                        end
                        
                        if child.empty then
                            -- 自闭合标签
                            result = result .. "/>"
                        else
                            -- 普通标签
                            result = result .. ">"
                            -- 递归处理子元素
                            xml2string(child)
                            result = result .. "</" .. child.label .. ">"
                        end
                    end
                end
            else
                error("XSSFilter: Unexpected type of field in parsed XML")
            end
        end
    end
    
    -- 处理解析后的 XML（跳过根元素 <xml>）
    xml2string(parsedXML[2] or parsedXML)
    
    return result
end

--[[
    调用标签处理器
    @param tagName 标签名称
    @param reason 处理原因
    @param content 标签内容
    @return 处理结果
]]
function XSSFilter:call_tags_handler(tagName, reason, content)
    local result, errorMsg = self.tags_handler(self, tagName, reason, content)
    
    if not result then
        error(errorMsg)
    end
    
    return result or ""
end
