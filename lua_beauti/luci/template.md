# luci/template.lua

## 概述

LuCI 模板引擎模块，提供 LuCI Web 界面的模板渲染功能。支持模板解析、编译、缓存和渲染执行。

## 工作原理

1. **模板加载**: 从视图目录加载 `.htm` 模板文件
2. **模板解析**: 使用 `luci.template.parser` 解析模板语法
3. **模板缓存**: 编译后的模板缓存在内存中，避免重复解析
4. **作用域设置**: 渲染时设置模板执行环境，支持视图命名空间和调用者作用域
5. **安全执行**: 使用 `copcall` 安全执行模板代码

## 接口/函数列表

### 模块级函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `render(templateName, scope)` | 模板名、作用域 | void | 渲染模板的便捷函数 |

### Template 类

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `Template:__init__(name)` | 模板名 | void | 初始化模板对象，加载并编译模板 |
| `Template:render(scope)` | 作用域 | void | 渲染模板到输出 |

### 模块变量

| 变量 | 类型 | 描述 |
|------|------|------|
| `viewdir` | string | 模板视图目录路径 |
| `context` | threadlocal | 线程本地上下文，包含 viewns |
| `Template.cache` | table | 模板缓存（弱引用） |

## 外部依赖

- `luci.util` - 工具函数（class、copcall、libpath）
- `luci.config` - 配置（template.viewdir）
- `luci.template.parser` - 模板解析器（C 模块）

## 被引用情况

- `luci/dispatcher.lua` - 渲染错误页面、模板目标
- 所有控制器 - 渲染视图模板
- `luci/cbi.lua` - CBI 表单渲染

## 关键代码说明

### 模板缓存机制
```lua
Template.cache = setmetatable({}, { __mode = "v" })
-- 使用弱引用表，允许垃圾回收未使用的模板
```

### 模板加载流程
```lua
function Template.__init__(self, name)
    self.template = self.cache[name]  -- 先查缓存
    
    if not self.template then
        local templatePath = viewdir .. "/" .. name .. ".htm"
        local compiled, _, parseError = parser.parse(templatePath)
        -- 解析并缓存
        self.cache[name] = self.template
    end
end
```

### 渲染作用域
```lua
function Template.render(self, scope)
    setfenv(self.template, setmetatable({}, {
        __index = function(tbl, key)
            -- 优先级: 本地 > viewns > scope
            local value = rawget(tbl, key)
            if not value then
                value = self.viewns[key]
                if not value then
                    value = scope[key]
                end
            end
            return value
        end
    }))
end
```

### 模板语法
模板文件使用特殊语法，由 `parser.so` 解析：
- `<%` ... `%>` - Lua 代码块
- `<%=` ... `%>` - 输出表达式
- `<%:` ... `%>` - 翻译文本
- `<%+` ... `%>` - 包含其他模板
- `<%-` ... `%>` - 去除空白的代码块
