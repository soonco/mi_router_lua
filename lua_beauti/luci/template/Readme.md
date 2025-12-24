# luci/template 目录

## 概述

本目录包含 LuCI 模板引擎的核心 C 扩展模块（编译后的共享库），提供高性能的模板解析、国际化支持和字符串处理功能。

## 文件列表

| 文件 | 类型 | 描述 |
|------|------|------|
| `parser.so` | C 共享库 | 模板解析器，提供模板编译、国际化和字符串处理功能 |
| `verv.so` | C 共享库 | 辅助模块（具体功能待确认） |

## parser.so 详细说明

`parser.so` 是 LuCI 框架的核心 C 扩展模块，通过 `require("luci.template.parser")` 加载使用。

### 提供的函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `parse(filepath)` | 模板文件路径 | compiled, _, error | 解析 `.htm` 模板文件，返回编译后的 Lua 函数 |
| `load_catalog(lang, dir)` | 语言代码, 目录 | boolean | 加载指定语言的 `.lmo` 翻译文件 |
| `translate(key)` | 翻译键 | string/nil | 查找并返回翻译文本 |
| `pcdata(text)` | 文本字符串 | string | HTML 实体编码（转义特殊字符） |
| `striptags(text)` | 文本字符串 | string | 移除 HTML 标签 |
| `hash(text)` | 文本字符串 | number | 计算字符串的哈希值 |

### 模板语法

`parser.so` 支持解析以下模板语法：

| 语法 | 描述 |
|------|------|
| `<% ... %>` | Lua 代码块 |
| `<%= ... %>` | 输出表达式（自动转义） |
| `<%: ... %>` | 翻译文本输出 |
| `<%+ ... %>` | 包含其他模板 |
| `<%- ... %>` | 去除空白的代码块 |

### 使用示例

```lua
-- 模板解析
local parser = require("luci.template.parser")
local compiled, _, err = parser.parse("/path/to/template.htm")

-- 国际化
parser.load_catalog("zh-cn", "/usr/lib/lua/luci/i18n/")
local text = parser.translate("Save")  -- 返回 "保存"

-- 字符串处理
local safe = parser.pcdata("<script>alert('xss')</script>")
-- 返回: "&lt;script&gt;alert('xss')&lt;/script&gt;"

local plain = parser.striptags("<b>Hello</b> World")
-- 返回: "Hello World"

-- 哈希计算
local hash = parser.hash("zone_name")
math.randomseed(hash)  -- 用于生成一致的随机颜色
```

## 被引用情况

### parser.so 引用模块

| 模块 | 使用的函数 | 用途 |
|------|------------|------|
| `luci/template.lua` | `parse()` | 解析和编译 `.htm` 模板文件 |
| `luci/i18n.lua` | `load_catalog()`, `translate()` | 国际化翻译支持 |
| `luci/util.lua` | `pcdata()`, `striptags()` | HTML 安全处理 |
| `luci/model/firewall.lua` | `hash()` | 生成防火墙区域颜色 |

## 技术说明

### 为什么使用 C 扩展

1. **性能**: 模板解析和字符串处理是高频操作，C 实现比纯 Lua 快数倍
2. **内存效率**: C 扩展可以更高效地管理内存
3. **功能扩展**: 某些底层操作（如二进制文件读取）在 C 中更容易实现

### 编译依赖

这些 `.so` 文件是针对特定平台编译的：
- 需要与目标系统的 Lua 版本匹配
- 依赖系统的 C 运行时库
- 通常在 OpenWrt 构建系统中编译

## 相关文件

- `luci/template.lua` - 模板引擎 Lua 封装层
- `luci/i18n.lua` - 国际化模块
- `luci/util.lua` - 工具函数模块
- `luci/i18n/*.lmo` - 编译后的翻译文件
