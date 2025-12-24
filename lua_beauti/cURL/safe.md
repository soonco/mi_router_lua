# safe.lua - cURL 安全模式封装模块

## 工作原理

本模块是 Lua-cURL 库的安全模式入口。与标准 cURL 模块的区别是使用 `lcurl.safe` 作为底层库，提供更安全的错误处理机制。

安全模式特点：
- 错误不会抛出异常，而是返回 nil 和错误信息
- 更适合需要优雅处理错误的场景
- API 与标准 cURL 模块完全兼容

## 接口

本模块返回由 `cURL.impl.cURL` 初始化的 cURL 对象，与标准 cURL 模块接口相同。

### 使用示例

```lua
local cURL = require("cURL.safe")

-- 创建 Easy 对象（安全模式）
local easy, err = cURL.easy()
if not easy then
    print("创建失败:", err)
    return
end

-- 设置 URL
local ok, err = easy:setopt_url("http://example.com")
if not ok then
    print("设置 URL 失败:", err)
end

-- 执行请求
local result, err = easy:perform()
if not result then
    print("请求失败:", err)
end
```

### 与标准模式的区别

| 模式 | 错误处理 | 适用场景 |
|------|----------|----------|
| 标准模式 (`cURL`) | 抛出异常 | 简单脚本 |
| 安全模式 (`cURL.safe`) | 返回 nil + 错误 | 生产环境 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `lcurl.safe` | 底层安全模式 cURL 绑定 |
| `cURL.impl.cURL` | Lua 层封装实现模块 |
