# luci/cbi.lua

## 概述

LuCI CBI（Configuration Binding Interface）配置绑定接口模块。提供配置界面的抽象框架，将 UCI 配置与 Web 表单绑定，支持自动生成配置页面、表单验证、提交和保存。

## 工作原理

1. **配置映射**: `Map` 类对应一个 UCI 配置文件
2. **配置节**: `Section` 类对应配置文件中的节
3. **配置值**: `Value` 类对应配置节中的选项
4. **表单处理**: 解析 HTTP 表单数据，验证并写入 UCI
5. **模板渲染**: 使用模板引擎渲染配置界面

## 类层次结构

```
Node (基类)
├── Template (模板节点)
├── Map (配置映射)
│   ├── Delegator (多步骤向导)
│   └── Compound (复合节点)
├── AbstractSection (配置节抽象类)
│   ├── NamedSection (命名配置节)
│   ├── TypedSection (类型化配置节)
│   └── Table (表格配置节)
└── AbstractValue (配置值抽象类)
    ├── Value (单值输入)
    ├── DummyValue (只读显示)
    ├── Flag (布尔标志)
    ├── ListValue (下拉列表)
    ├── MultiValue (多选值)
    ├── StaticList (静态列表)
    ├── DynamicList (动态列表)
    ├── TextValue (多行文本)
    ├── Button (按钮)
    ├── FileUpload (文件上传)
    └── FileBrowser (文件浏览器)
```

## 表单状态常量

| 常量 | 值 | 描述 |
|------|-----|------|
| `FORM_NODATA` | 0 | 无表单数据 |
| `FORM_PROCEED` | 0 | 继续处理 |
| `FORM_VALID` | 1 | 数据验证通过 |
| `FORM_DONE` | 1 | 处理完成 |
| `FORM_INVALID` | -1 | 数据验证失败 |
| `FORM_CHANGED` | 2 | 数据已更改 |
| `FORM_SKIP` | 4 | 跳过处理 |

## 主要类接口

### Node 基类

| 方法 | 描述 |
|------|------|
| `__init__(title, description)` | 初始化节点 |
| `append(child)` | 添加子节点 |
| `parse(...)` | 解析表单数据 |
| `render(scope)` | 渲染节点 |
| `render_children(...)` | 渲染子节点 |

### Map 类

| 方法 | 描述 |
|------|------|
| `__init__(config, title, desc)` | 初始化配置映射 |
| `section(class, ...)` | 创建配置节 |
| `formvalue(key)` | 获取表单值 |
| `get(section, option)` | 获取 UCI 值 |
| `set(section, option, value)` | 设置 UCI 值 |
| `del(section, option)` | 删除 UCI 值 |
| `parse(readinput)` | 解析并保存 |

### AbstractSection 类

| 方法 | 描述 |
|------|------|
| `option(class, name, ...)` | 创建配置选项 |
| `tab(name, title, desc)` | 创建选项卡 |
| `taboption(tab, class, name, ...)` | 在选项卡中创建选项 |
| `cfgvalue(section)` | 获取配置值 |
| `create(section)` | 创建配置节 |
| `remove(section)` | 删除配置节 |

### AbstractValue 类

| 方法 | 描述 |
|------|------|
| `depends(field, value)` | 设置依赖条件 |
| `cbid(section)` | 获取表单元素 ID |
| `formvalue(section)` | 获取表单值 |
| `cfgvalue(section)` | 获取配置值 |
| `validate(value)` | 验证值 |
| `write(section, value)` | 写入值 |
| `remove(section)` | 删除值 |

## 数据类型验证

通过 `datatype` 属性指定验证类型：

```lua
option.datatype = "ip4addr"      -- IPv4 地址
option.datatype = "port"         -- 端口号
option.datatype = "range(1,100)" -- 范围
option.datatype = "integer"      -- 整数
```

## 外部依赖

- `os` - 操作系统接口
- `nixio.fs` - 文件系统操作
- `luci.ip` - IP 地址处理
- `luci.util` - 工具函数
- `luci.cbi.datatypes` - 数据类型验证
- `luci.template` - 模板渲染
- `luci.http` - HTTP 处理
- `luci.model.uci` - UCI 配置接口

## 被引用情况

- `luci/dispatcher.lua` - CBI 目标处理
- 各种配置页面控制器

## 使用示例

```lua
local cbi = require("luci.cbi")

-- 创建配置映射
local m = cbi.Map("network", "网络配置")

-- 创建配置节
local s = m:section(cbi.TypedSection, "interface", "接口")
s.addremove = true

-- 创建配置选项
local proto = s:option(cbi.ListValue, "proto", "协议")
proto:value("dhcp", "DHCP")
proto:value("static", "静态IP")

local ip = s:option(cbi.Value, "ipaddr", "IP地址")
ip.datatype = "ip4addr"
ip:depends("proto", "static")

return m
```

## 钩子函数

Map 支持以下钩子：
- `on_init` - 初始化时
- `on_parse` - 解析前
- `on_before_save` - 保存前
- `on_before_commit` - 提交前
- `on_after_commit` - 提交后
- `on_before_apply` - 应用前
- `on_apply` - 应用时
- `on_after_apply` - 应用后
