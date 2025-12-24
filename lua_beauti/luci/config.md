# luci/config.lua

## 概述

LuCI 配置模块，提供对 LuCI 系统配置的懒加载访问。配置存储在 UCI 的 `luci` 配置文件中，通过元表实现按需加载。

## 工作原理

1. **懒加载**: 使用元表的 `__index` 方法，在首次访问配置节时才从 UCI 加载
2. **线程本地缓存**: 使用 `threadlocal` 存储已加载的配置，避免重复读取
3. **UCI 集成**: 通过 `luci.model.uci` 读取 `/etc/config/luci` 配置文件

## 接口/函数列表

本模块不导出函数，而是通过属性访问配置节：

```lua
local config = require("luci.config")

-- 访问配置节
config.main          -- 主配置节
config.sauth         -- 会话认证配置
config.template      -- 模板配置
config.internal      -- 内部配置
```

## 配置结构

UCI 配置文件 `/etc/config/luci` 的典型结构：

```
config core 'main'
    option mediaurlbase '/luci-static/resources'
    option lang 'auto'
    option resourcebase '/luci-static/resources'

config internal 'sauth'
    option sessionpath '/tmp/luci-sessions'
    option sessiontime '3600'

config internal 'template'
    option viewdir '/usr/lib/lua/luci/view'

config internal 'ccache'
    option enable '1'
```

## 常用配置项

### main 节
| 选项 | 描述 |
|------|------|
| `mediaurlbase` | 静态资源 URL 基路径 |
| `lang` | 默认语言 |
| `resourcebase` | 资源文件基路径 |

### sauth 节
| 选项 | 描述 |
|------|------|
| `sessionpath` | 会话文件存储路径 |
| `sessiontime` | 会话超时时间（秒） |

### template 节
| 选项 | 描述 |
|------|------|
| `viewdir` | 模板视图目录 |

### ccache 节
| 选项 | 描述 |
|------|------|
| `enable` | 是否启用控制器缓存 |

## 外部依赖

- `luci.util` - 工具函数（threadlocal）
- `luci.model.uci` - UCI 配置接口

## 被引用情况

- `luci/sauth.lua` - 会话路径和超时配置
- `luci/template.lua` - 模板目录配置
- `luci/ccache.lua` - 缓存配置
- `luci/dispatcher.lua` - 各种系统配置

## 关键代码说明

### 懒加载实现
```lua
module("luci.config", function(module_env)
    local ok = pcall(require, "luci.model.uci")
    
    if ok then
        local config_cache = util.threadlocal()
        
        setmetatable(module_env, {
            __index = function(self, section_name)
                -- 检查缓存
                if not config_cache[section_name] then
                    -- 从 UCI 加载
                    local cursor = luci.model.uci.cursor()
                    config_cache[section_name] = cursor:get_all("luci", section_name)
                end
                return config_cache[section_name]
            end
        })
    end
end)
```

### 线程安全
```lua
-- 使用 threadlocal 确保每个请求有独立的缓存
local config_cache = util.threadlocal()
```

## 使用示例

```lua
local config = require("luci.config")

-- 获取会话超时时间
local timeout = config.sauth.sessiontime or 3600

-- 获取模板目录
local viewdir = config.template.viewdir

-- 获取语言设置
local lang = config.main.lang or "auto"
```

## 注意事项

1. 配置值在首次访问时加载，之后缓存在内存中
2. 配置更改需要重新加载模块才能生效
3. 如果 UCI 模块加载失败，配置访问将返回 nil
