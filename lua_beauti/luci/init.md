# luci/init.lua

## 概述

LuCI 核心初始化模块，提供 LuCI 框架的基础功能和版本信息。这是整个 LuCI 框架的入口模块。

## 工作原理

1. 定义 `luci` 模块命名空间
2. 设置 LuCI 版本信息
3. 根据环境变量配置 Lua 包搜索路径（`LUA_PATH` 和 `LUA_CPATH`）

## 接口/函数列表

| 变量/函数 | 类型 | 描述 |
|-----------|------|------|
| `version` | string | LuCI 版本号，当前为 "0.11" |
| `version_codename` | string | 版本代号，当前为 "Tianyi" |

## 外部依赖

- 无外部 Lua 模块依赖
- 依赖环境变量：
  - `LUA_PATH` - Lua 模块搜索路径
  - `LUA_CPATH` - Lua C 模块搜索路径

## 被引用情况

- `luci/dispatcher.lua` - 调度器模块引用
- 其他所有 LuCI 模块通过 `require("luci")` 或 `require("luci.xxx")` 间接引用

## 关键代码说明

```lua
module("luci", package.seeall)
```
使用 `package.seeall` 使模块可以访问全局环境，同时创建 `luci` 命名空间。

```lua
local package_path = os.getenv("LUA_PATH")
if package_path then
    package.path = package_path
end
```
允许通过环境变量自定义 Lua 模块搜索路径，便于部署和调试。
