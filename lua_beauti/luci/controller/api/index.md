# index.lua - API 控制器索引模块

## 概述

API 控制器索引模块（API Controller Index Module），定义 API 模块的根节点，设置所有 `/api/*` 路由的默认认证方式。

**文件路径**: `luci/controller/api/index.lua`  
**模块名称**: `luci.controller.api.index`  
**API 路径**: `/api`

## 工作原理

1. **根节点定义**: 创建 `/api` 路由的父节点
2. **认证配置**: 设置默认的系统认证方式
3. **子节点继承**: 所有子 API 模块默认继承此认证配置

## 接口/函数列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `index()` | 无 | 无 | 路由索引函数，定义 API 根节点属性 |

### 节点属性配置

| 属性 | 值 | 说明 |
|------|-----|------|
| `target` | `firstchild()` | 目标为第一个子节点 |
| `title` | `""` | 空标题 |
| `order` | `10` | 排序优先级 |
| `sysauth` | `"admin"` | 需要管理员权限 |
| `sysauth_authenticator` | `"jsonauth"` | 使用 JSON 格式认证 |
| `index` | `true` | 作为索引节点 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| LuCI dispatcher | 路由节点注册（隐式依赖） |

## 被引用情况

- 由 LuCI dispatcher 自动加载作为 `/api` 路径的根节点
- 所有 `/api/*` 子模块继承此节点的认证配置
- 子模块可覆盖认证设置以实现不同的访问控制

## 关键代码说明

### 认证配置

```lua
function index()
    local api_node = node("api")
    api_node.sysauth = "admin"              -- 需要 admin 用户认证
    api_node.sysauth_authenticator = "jsonauth"  -- 使用 JSON 认证器
end
```

- `sysauth = "admin"`: 表示访问 API 需要管理员权限
- `sysauth_authenticator = "jsonauth"`: 使用 JSON 格式的认证响应，适合 AJAX 请求

### 认证方式说明

`jsonauth` 认证器会在认证失败时返回 JSON 格式的错误信息，而不是重定向到登录页面，这对于 API 调用更加友好。
