--[[
    SLAXDOM - SLAXML DOM 构建器
    基于 SLAXML 解析器构建 DOM（文档对象模型）树
    提供将 XML 字符串解析为可遍历的 DOM 结构的功能
]]

-- 导入依赖
local slaxml = require("slaxml")
local stringLib = require("string")
local tableLib = require("table")

-- 注册为全局模块
module("slaxdom")

--[[
    解析 XML 字符串并构建 DOM 树
    @param parser SLAXML 解析器实例
    @param xmlString XML 字符串
    @param options 解析选项（可选）
        - simple: 是否使用简单模式（不包含 el 和 parent 字段）
    @return DOM 文档对象
]]
function slaxml.dom(parser, xmlString, options)
    -- 初始化选项
    if not options then
        options = {}
    end
    
    -- 是否包含完整的父子关系
    local includeRelations = not options.simple
    
    -- 表操作函数引用
    local insert = tableLib.insert
    local remove = tableLib.remove
    
    -- 元素栈，用于跟踪嵌套关系
    local elementStack = {}
    
    -- 创建文档根节点
    local document = {
        type = "document",
        name = "#doc",
        kids = {}
    }
    
    -- 当前元素指针
    local currentElement = document
    
    -- 创建解析器回调
    local callbacks = {}
    
    --[[
        处理元素开始标签
        @param elementName 元素名称
        @param namespaceURI 命名空间 URI（可选）
    ]]
    callbacks.startElement = function(elementName, namespaceURI)
        -- 创建新元素节点
        local element = {
            type = "element",
            name = elementName,
            kids = {},
            el = includeRelations and {} or nil,
            attr = {},
            nsURI = namespaceURI,
            parent = includeRelations and currentElement or nil
        }
        
        -- 检查是否为文档根元素
        if currentElement == document then
            if document.root then
                error(stringLib.format(
                    "Encountered element '%s' when the document already has a root '%s' element",
                    elementName,
                    document.root.name
                ))
            end
            document.root = element
        end
        
        -- 添加到父元素的子节点列表
        insert(currentElement.kids, element)
        
        -- 如果启用关系跟踪，添加到父元素的元素列表
        if currentElement.el then
            insert(currentElement.el, element)
        end
        
        -- 更新当前元素指针
        currentElement = element
        
        -- 压入元素栈
        insert(elementStack, element)
    end
    
    --[[
        处理元素属性
        @param attrName 属性名称
        @param attrValue 属性值
        @param namespaceURI 命名空间 URI（可选）
    ]]
    callbacks.attribute = function(attrName, attrValue, namespaceURI)
        -- 验证当前是否在元素内
        if not currentElement or currentElement.type ~= "element" then
            error(stringLib.format(
                "Encountered an attribute %s=%s but I wasn't inside an element",
                attrName,
                attrValue
            ))
        end
        
        -- 创建属性节点
        local attribute = {
            type = "attribute",
            name = attrName,
            nsURI = namespaceURI,
            value = attrValue,
            parent = includeRelations and currentElement or nil
        }
        
        -- 添加到元素的属性表（简化访问）
        if includeRelations then
            currentElement.attr[attrName] = attrValue
        end
        
        -- 添加到属性列表
        insert(currentElement.attr, attribute)
    end
    
    --[[
        处理元素结束标签
        @param elementName 元素名称
    ]]
    callbacks.closeElement = function(elementName)
        -- 验证标签匹配
        if currentElement.name ~= elementName or currentElement.type ~= "element" then
            error(stringLib.format(
                "Received a close element notification for '%s' but was inside a '%s' %s",
                elementName,
                currentElement.name,
                currentElement.type
            ))
        end
        
        -- 弹出元素栈
        remove(elementStack)
        
        -- 更新当前元素指针
        currentElement = elementStack[#elementStack]
    end
    
    --[[
        处理文本内容
        @param textContent 文本内容
    ]]
    callbacks.text = function(textContent)
        -- 只在元素内处理文本
        if currentElement.type ~= "document" and currentElement.type ~= "element" then
            error(stringLib.format(
                "Received a text notification '%s' but was inside a %s",
                textContent,
                currentElement.type
            ))
        end
        
        -- 只在元素内添加文本节点（忽略文档级别的文本）
        if currentElement.type == "element" then
            insert(currentElement.kids, {
                type = "text",
                name = "#text",
                value = textContent,
                parent = includeRelations and currentElement or nil
            })
        end
    end
    
    --[[
        处理注释
        @param commentText 注释内容
    ]]
    callbacks.comment = function(commentText)
        insert(currentElement.kids, {
            type = "comment",
            name = "#comment",
            value = commentText,
            parent = includeRelations and currentElement or nil
        })
    end
    
    --[[
        处理处理指令
        @param target 处理指令目标
        @param content 处理指令内容
    ]]
    callbacks.pi = function(target, content)
        insert(currentElement.kids, {
            type = "pi",
            name = target,
            value = content,
            parent = includeRelations and currentElement or nil
        })
    end
    
    -- 创建解析器并解析 XML
    local xmlParser = parser:parser(callbacks)
    xmlParser:parse(xmlString, options)
    
    return document
end

return slaxml
