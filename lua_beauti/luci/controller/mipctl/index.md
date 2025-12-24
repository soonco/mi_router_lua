# index.lua - MIPCTL 控制面板模块

## 工作原理

提供 MIPCTL 管理界面的路由配置。MIPCTL 是小米路由器的设备控制面板，使用 HTML 表单认证方式，通过模板渲染主页面。

### 路由配置

- 认证方式：htmlauth（HTML 表单认证）
- 静态资源路径：`/xiaoqiang/mipctl`
- 页面模板：`mipctl/home`

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `index()` | 无 | 无 | 注册 MIPCTL 路由 |

### 页面路由

| 路径 | 模板 | 权限级别 | 说明 |
|------|------|----------|------|
| `/mipctl` | mipctl/home | 13 | MIPCTL 主页面 |

### 节点配置

| 属性 | 值 | 说明 |
|------|-----|------|
| `order` | 110 | 菜单排序 |
| `sysauth` | admin | 需要管理员认证 |
| `sysauth_authenticator` | htmlauth | HTML 表单认证 |
| `mediaurlbase` | /xiaoqiang/mipctl | 静态资源基础路径 |

## 外部引用

无外部依赖
