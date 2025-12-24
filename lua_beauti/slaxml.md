# slaxml.lua - 简单轻量级 XML 解析器

## 工作原理

SLAXML 是一个基于 SAX（Simple API for XML）风格的流式 XML 解析器，版本 0.5.1。它不构建完整的 DOM 树，而是在解析过程中触发回调函数处理各种 XML 事件。

解析流程：
1. 创建解析器实例并注册回调函数
2. 逐字符扫描 XML 内容
3. 识别 XML 结构（标签、属性、文本、注释等）
4. 触发相应的回调函数
5. 支持命名空间处理

支持的 XML 结构：
- 元素（开始/结束标签）
- 属性
- 文本内容
- 注释
- 处理指令（PI）
- CDATA 节
- 命名空间

## 接口

### 模块属性

| 属性 | 说明 |
|------|------|
| `slaxml.VERSION` | "0.5.1" |

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `slaxml:parser(callbacks)` | callbacks: 回调函数表 | 解析器实例 | 创建解析器 |
| `parser:parse(xmlContent, options)` | xmlContent: XML 字符串<br>options: 解析选项 | 无 | 解析 XML |

### 回调函数

| 回调 | 参数 | 说明 |
|------|------|------|
| `startElement(name, nsURI)` | 元素名, 命名空间 | 元素开始 |
| `closeElement(name, nsURI)` | 元素名, 命名空间 | 元素结束 |
| `attribute(name, value, nsURI)` | 属性名, 值, 命名空间 | 属性 |
| `text(content)` | 文本内容 | 文本节点 |
| `comment(content)` | 注释内容 | 注释 |
| `pi(target, content)` | 目标, 内容 | 处理指令 |

### 解析选项

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `stripWhitespace` | boolean | false | 是否去除空白文本 |

### 使用示例

```lua
local slaxml = require("slaxml")

local parser = slaxml:parser({
    startElement = function(name, nsURI)
        print("开始元素: " .. name)
    end,
    closeElement = function(name, nsURI)
        print("结束元素: " .. name)
    end,
    text = function(content)
        print("文本: " .. content)
    end
})

parser:parse("<root><child>Hello</child></root>")
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `string` | Lua 字符串库 |
| `table` | Lua 表操作库 |
