# index.lua - 安全中心控制器模块

## 工作原理

小米路由器安全中心控制器入口模块，聚合各安全子模块的概览信息，提供统一的安全状态查询接口。

聚合的子模块：
- `log` - 安全日志
- `config_scanner` - 配置扫描
- `content_filter` - 内容过滤
- `gateway_security` - 网关安全

工作流程：
1. 扫描 `/usr/lib/lua/sec_center` 目录下的所有 Lua 模块
2. 调用每个子模块的 `_overview()` 函数
3. 汇总所有子模块的状态信息

## 接口

### API 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/api/sec_center/overview` | GET | 获取安全中心总览 |

### 响应格式

```json
{
    "code": 0,
    "log": { ... },
    "config_scanner": { ... },
    "content_filter": { ... },
    "gateway_security": { ... },
    "meta": {
        "insecure": 1,
        "total": 4
    }
}
```

### 内部函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `_overview()` | 无 | table | 获取所有子模块的概览信息 |

### 子模块接口要求

每个子模块必须实现 `_overview()` 函数：

```lua
function _overview()
    local data = { ... }
    local has_insecure = true/false
    return data, has_insecure
end
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `posix` | 目录遍历 |
| `sec_center.*` | 安全子模块 |
