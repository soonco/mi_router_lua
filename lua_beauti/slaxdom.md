# slaxdom.lua - SLAXML DOM 构建器

## 工作原理

本模块基于 SLAXML 解析器构建 DOM（文档对象模型）树，提供将 XML 字符串解析为可遍历的 DOM 结构的功能。

解析流程：
1. 创建文档根节点和元素栈
2. 注册 SAX 风格的回调函数处理各种 XML 事件
3. 遍历 XML 内容，触发相应回调构建 DOM 节点
4. 返回完整的 DOM 文档对象

DOM 节点类型：
- `document`: 文档根节点
- `element`: 元素节点
- `attribute`: 属性节点
- `text`: 文本节点
- `comment`: 注释节点
- `pi`: 处理指令节点

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `slaxml.dom(parser, xmlString, options)` | parser: SLAXML 解析器实例<br>xmlString: XML 字符串<br>options: 解析选项 | DOM 文档对象 | 解析 XML 并构建 DOM 树 |

### 选项参数

| 选项 | 类型 | 说明 |
|------|------|------|
| `simple` | boolean | 是否使用简单模式（不包含 el 和 parent 字段） |

### DOM 节点结构

```lua
-- 元素节点
{
    type = "element",
    name = "tagName",
    kids = {},      -- 子节点列表
    el = {},        -- 子元素列表（非简单模式）
    attr = {},      -- 属性表
    nsURI = "...",  -- 命名空间 URI
    parent = {}     -- 父节点引用（非简单模式）
}
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `slaxml` | SLAXML 流式 XML 解析器 |
| `string` | Lua 字符串库 |
| `table` | Lua 表操作库 |
