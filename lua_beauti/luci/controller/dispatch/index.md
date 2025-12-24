# index.lua - 调度控制器索引模块

## 工作原理

LuCI 调度控制器索引模块，用于定义 `/dispatch` 路由节点及其配置。

## 接口

### 路由配置

| 路径 | 模板 | 说明 |
|------|------|------|
| `/dispatch` | `index` | 跳转页面 |

### 节点属性

| 属性 | 值 | 说明 |
|------|-----|------|
| `target` | firstchild() | 目标为第一个子节点 |
| `title` | "" | 页面标题 |
| `order` | 1 | 排序优先级 |
| `sysauth` | "admin" | 需要管理员认证 |
| `mediaurlbase` | "/xiaoqiang/dispatch" | 媒体资源基础 URL |
| `sysauth_authenticator` | "htmlauth" | HTML 表单认证 |
| `index` | true | 索引节点 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.dispatcher` | 路由调度（node, entry, alias, firstchild, template） |
