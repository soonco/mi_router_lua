# luci/store.lua

## 概述

LuCI 线程本地存储模块，提供线程本地存储功能，用于在协程/线程间隔离数据。每个协程拥有独立的存储空间。

## 工作原理

该模块直接使用 `luci.util.threadlocal` 作为模块本身，使得模块可以像表一样使用，但每个协程访问的是独立的数据空间。

## 接口/函数列表

本模块作为线程本地存储表使用，支持标准的表操作：

```lua
local store = require("luci.store")

-- 存储数据
store.key = value

-- 读取数据
local value = store.key

-- 删除数据
store.key = nil
```

## 外部依赖

- `luci.util` - 工具函数（threadlocal）

## 被引用情况

- 用于在请求处理过程中存储临时数据
- 各种需要线程隔离数据的场景

## 关键代码说明

```lua
local util = require("luci.util")

-- 直接将 threadlocal 作为模块导出
module("luci.store", util.threadlocal)
```

## 使用示例

```lua
local store = require("luci.store")

-- 在请求处理中存储用户信息
store.current_user = "admin"
store.request_time = os.time()

-- 在其他模块中访问
local user = store.current_user

-- 每个协程的数据是隔离的
-- 协程 A 中设置的值不会影响协程 B
```

## 与 dispatcher.context 的区别

- `luci.store` - 通用线程本地存储
- `luci.dispatcher.context` - 专门用于请求上下文的线程本地存储

两者都基于 `luci.util.threadlocal`，但用途不同。
