# cachecenter.lua - 缓存中心服务模块

## 工作原理

提供缓存中心服务的 API 接口，通过 Thrift 隧道与缓存中心服务通信。请求数据经 JSON 编码后进行 Base64 编码，通过 `THRIFT_TUNNEL_TO_CACHECENTER` 命令发送。

### 通信流程

1. 构建请求数据（包含 api 编号和参数）
2. JSON 编码请求数据
3. Base64 编码
4. 通过 Thrift 隧道发送到缓存中心
5. 返回执行结果

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `index()` | 无 | 无 | 注册 API 路由 |
| `tunnelRequestCachecenter(requestData)` | 请求数据表 | 无 | 异步发送请求到缓存中心 |
| `requestCachecenter(requestData)` | 请求数据表 | string | 同步发送请求并返回结果 |
| `reportKey()` | HTTP: key | JSON | 上报缓存键 |

### API 端点

| 路径 | 函数 | API 编号 | 权限 | 说明 |
|------|------|----------|------|------|
| `/service/cachecenter/report_key` | reportKey | 1 | 公开 | 上报缓存键 |

### 请求数据格式

```lua
{
    api = 1,        -- API 编号
    key = "..."     -- 缓存键名称
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.util` | 工具函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量（Thrift 隧道命令） |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（Base64 编码） |
| `service.util.ServiceErrorUtil` | 服务错误处理 |
| `cjson` | JSON 编解码 |
