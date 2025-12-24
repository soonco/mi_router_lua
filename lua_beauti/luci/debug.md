# debug.lua - 调试工具模块

## 工作原理

LuCI 调试工具模块，提供内存跟踪功能用于性能分析和内存泄漏检测。

核心功能：
1. **内存跟踪** - 记录 Lua 代码执行过程中的内存使用情况
2. **峰值检测** - 跟踪内存使用峰值
3. **调用追踪** - 记录函数调用位置和名称

跟踪机制：
- 使用 `debug.sethook()` 设置钩子函数
- 在指定事件（调用、返回、行）时触发
- 将跟踪信息写入文件

## 接口

### 模块变量

| 变量 | 类型 | 说明 |
|------|------|------|
| `__file__` | string | 当前模块的文件路径 |

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `trap_memtrace(flags, dest)` | flags: 钩子标志<br>dest: 输出文件路径 | function | 启用内存跟踪，返回禁用函数 |

### trap_memtrace 参数

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `flags` | "clr" | 钩子事件标志 |
| `dest` | "/tmp/memtrace" | 跟踪日志文件路径 |

### 钩子标志说明

| 标志 | 说明 |
|------|------|
| `c` | 函数调用 (call) |
| `r` | 函数返回 (return) |
| `l` | 行执行 (line) |

### 跟踪日志格式

```
[事件类型] 源文件:行号    名称类型    函数名    当前内存 (峰值内存)
```

示例：
```
[call] @/usr/lib/lua/luci/dispatcher.lua:123    local    dispatch    1024 (2048)
[return] @/usr/lib/lua/luci/dispatcher.lua:150    local    dispatch    1000 (2048)
```

### 使用示例

```lua
local debug = require("luci.debug")

-- 启用内存跟踪
local stop = debug.trap_memtrace("clr", "/tmp/mytrace.log")

-- 执行要跟踪的代码
doSomeWork()

-- 停止跟踪
stop()
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `debug` | Lua 调试库 |
| `io` | 文件 I/O |
| `math` | 数学函数（floor） |
