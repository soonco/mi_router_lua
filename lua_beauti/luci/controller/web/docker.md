# docker.lua - Docker 管理控制器模块

## 工作原理

Docker 管理控制器模块，提供 Docker 管理界面的路由配置。

## 接口

### 路由配置

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/docker` | - | Docker 管理根节点 |
| `/web/docker/index` | `web/docker` | Docker 管理页面 |

### 节点属性

| 属性 | 值 | 说明 |
|------|-----|------|
| `target` | firstchild() | 目标为第一个子节点 |
| `title` | "" | 页面标题 |
| `order` | 100 | 排序权重 |
| `sysauth` | "admin" | 需要管理员认证 |
| `sysauth_authenticator` | "jsonauth" | JSON 认证方式 |
| `index` | true | 索引节点 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.dispatcher` | 路由调度（node, entry, template） |
