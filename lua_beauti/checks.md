# checks.lua - 参数类型检查模块

## 工作原理

本模块提供函数参数类型检查功能，类似于静态类型语言的参数验证。通过在函数开头调用 `checks()` 函数，可以在运行时检查函数参数是否符合预期类型。

工作流程：
1. 在被检查函数开头调用 `checks(type1, type2, ...)`
2. 使用 `debug.getlocal()` 获取调用函数的参数
3. 逐个检查参数类型是否匹配期望类型
4. 类型不匹配时抛出详细的错误信息

支持的类型说明符：
- 基本类型：`"string"`, `"number"`, `"table"`, `"function"`, `"boolean"`
- 可选参数：`"?"` 或 `"?string"` 等
- 多类型：`"string|number"` 用 `|` 分隔
- 自定义类型：通过 `checkers` 表扩展

## 接口

### 全局函数

| 函数 | 参数 | 说明 |
|------|------|------|
| `checks(...)` | 各参数的期望类型字符串 | 检查当前函数的所有参数类型 |

### 全局变量

| 变量 | 说明 |
|------|------|
| `checkers` | 自定义类型检查器表，可添加自定义验证函数 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `checkArgument(level, argName, value, expectedType)` | 检查单个参数的类型 |
| `checkTableArgument(level, argName, schema, value)` | 检查表类型参数的内部结构 |

## 外部引用

本模块为纯 Lua 实现，仅使用 Lua 标准库：

| 模块/函数 | 说明 |
|------|------|
| `debug.getlocal` | 获取局部变量信息 |
| `debug.getinfo` | 获取函数调用信息 |
| `debug.setlocal` | 设置局部变量值 |
