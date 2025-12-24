# rpc.lua - JSON-RPC 客户端模块

## 工作原理

本模块实现 JSON-RPC 协议客户端，用于通过 HTTP 发送 JSON-RPC 请求到远程服务器。

JSON-RPC 协议：
- 基于 JSON 的远程过程调用协议
- 请求包含：id、method、params
- 响应包含：id、result 或 error

工作流程：
1. 构建 JSON-RPC 请求对象
2. 将请求编码为 JSON 字符串
3. 通过 HTTP POST 发送到服务器
4. 解析 JSON 响应
5. 返回结果或错误

## 接口

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `json.rpc.proxy(url)` | url: RPC 服务端地址 | 代理对象 | 创建 RPC 代理对象 |
| `json.rpc.call(url, method, ...)` | url: 地址<br>method: 方法名<br>...: 参数 | result, error | 执行远程调用 |

### 使用示例

```lua
local json = require("json")
require("json.rpc")

-- 方式一：使用代理对象
local proxy = json.rpc.proxy("http://api.example.com/rpc")
local result, err = proxy.getUserInfo(123)

-- 方式二：直接调用
local result, err = json.rpc.call(
    "http://api.example.com/rpc",
    "getUserInfo",
    123
)

if result then
    print("用户名:", result.name)
else
    print("错误:", err)
end
```

### 请求格式

```json
{
    "id": "随机ID",
    "method": "方法名",
    "params": [参数列表]
}
```

### 响应格式

成功：
```json
{
    "id": "请求ID",
    "result": "返回值"
}
```

失败：
```json
{
    "id": "请求ID",
    "error": "错误信息"
}
```

### HTTP 请求头

| 头部 | 值 |
|------|-----|
| `Content-Type` | `application/json-rpc` |
| `Content-Length` | 请求体长度 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `json` | JSON 编解码 |
| `socket.http` | HTTP 客户端 |
| `ltn12` | 数据传输库 |
