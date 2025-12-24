# luci/util.lua

## 概述

LuCI 核心工具模块，提供 LuCI 框架的核心工具函数，包括面向对象支持、线程本地存储、字符串处理、表操作、数据序列化、迭代器、命令执行和协程安全调用等功能。

## 工作原理

1. **面向对象**: 通过元表实现类和实例化机制
2. **线程本地存储**: 使用协程作为键存储线程特定数据
3. **字符串增强**: 扩展 string 元表，添加实用方法
4. **协程安全**: 封装 pcall/xpcall 支持协程环境

## 接口/函数列表

### 面向对象支持

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `class(base)` | 基类 | table | 创建类，支持继承 |
| `instanceof(object, targetClass)` | 对象、目标类 | boolean | 检查对象是否是类的实例 |

### 线程本地存储

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `threadlocal(initialData)` | 初始数据 | table | 创建线程本地存储对象 |

### 字符串处理

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `pcdata(text)` | 文本 | string | HTML 实体编码 |
| `striptags(text)` | 文本 | string | 去除 HTML 标签 |
| `split(str, delimiter, limit, plain)` | 字符串、分隔符、限制、是否纯文本 | table | 分割字符串 |
| `trim(str)` | 字符串 | string | 去除首尾空白 |
| `cmatch(str, pattern)` | 字符串、模式 | number | 统计模式匹配次数 |

### 表操作

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `clone(tbl, deep)` | 表、是否深拷贝 | table | 克隆表 |
| `keys(tbl)` | 表 | table | 获取所有键 |
| `contains(tbl, value)` | 表、值 | boolean | 检查值是否存在 |
| `update(target, source)` | 目标表、源表 | void | 合并表 |
| `append(tbl, ...)` | 表、元素 | table | 追加元素 |
| `combine(...)` | 多个表/元素 | table | 合并为新表 |
| `dtable()` | 无 | table | 创建自动初始化的嵌套表 |

### 数据序列化

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `serialize_data(data)` | 数据 | string | 序列化为 Lua 代码 |
| `restore_data(str)` | 字符串 | any | 反序列化 Lua 代码 |
| `get_bytecode(data)` | 数据/函数 | string | 获取字节码 |
| `strip_bytecode(bytecode)` | 字节码 | string | 精简字节码 |
| `hasRecursion(data)` | 数据 | boolean | 检查是否有循环引用 |

### 迭代器

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `imatch(value)` | 值 | iterator | 创建值迭代器 |
| `spairs(tbl, sortFunc)` | 表、排序函数 | iterator | 排序迭代器 |
| `kspairs(tbl)` | 表 | iterator | 按键排序迭代器 |
| `vspairs(tbl)` | 表 | iterator | 按值排序迭代器 |

### 命令执行

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `exec(command)` | 命令 | string | 执行命令返回输出 |
| `execi(command)` | 命令 | iterator | 执行命令逐行迭代 |
| `execl(command)` | 命令 | table | 执行命令返回行列表 |
| `exec_trim(command, default)` | 命令、默认值 | string | 执行命令返回去空白输出 |

### 协程安全调用

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `coxpcall(func, handler, ...)` | 函数、错误处理器、参数 | boolean, any | 协程安全的 xpcall |
| `copcall(func, ...)` | 函数、参数 | boolean, any | 协程安全的 pcall |

### 其他

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `perror(message)` | 消息 | void | 输出到 stderr |
| `dumptable(tbl, maxDepth, currentDepth, visited)` | 表、最大深度、当前深度、已访问 | void | 调试输出表结构 |
| `parse_units(expr)` | 表达式 | number | 解析带单位的数值 |
| `libpath()` | 无 | string | 获取 LuCI 库路径 |
| `bigendian()` | 无 | boolean | 检查是否大端序 |

## 外部依赖

- `io` - 文件 I/O
- `math` - 数学函数
- `table` - 表操作
- `debug` - 调试信息
- `string` - 字符串操作
- `coroutine` - 协程
- `luci.debug` - LuCI 调试模块
- `luci.template.parser` - 模板解析器（用于 pcdata/striptags）
- `nixio.fs` - 文件系统（用于 libpath）

## 被引用情况

- 几乎所有 LuCI 模块都依赖此模块
- `luci/dispatcher.lua` - 线程本地上下文、协程调用
- `luci/http.lua` - Request 类定义
- `luci/template.lua` - Template 类定义
- `luci/json.lua` - Encoder/Decoder 类定义

## 关键代码说明

### 字符串格式化扩展
```lua
-- 允许使用 % 运算符格式化字符串
-- "Hello %s" % "World" => "Hello World"
-- "Value: %d" % {42} => "Value: 42"
function stringMeta.__mod(formatStr, args)
```

### 类实现
```lua
function class(base)
    return setmetatable({}, {
        __call = classCall,  -- 调用类创建实例
        __index = base       -- 继承基类
    })
end
```

### 线程本地存储
```lua
-- 使用协程作为键，每个协程有独立的数据空间
function threadLocalMeta.__index(self, key)
    local thread = coxpt[coroutine.running()]
    -- ...
end
```

### 单位解析支持
```lua
local units = {
    y = 31622400,    -- 年
    m = 2678400,     -- 月
    w = 604800,      -- 周
    d = 86400,       -- 天
    h = 3600,        -- 小时
    min = 60,        -- 分钟
    kb = 1024,       -- KB
    mb = 1048576,    -- MB
    gb = 1073741824  -- GB
}
```
