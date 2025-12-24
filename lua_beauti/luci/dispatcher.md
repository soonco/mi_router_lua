# luci/dispatcher.lua

## 概述

LuCI 核心调度器模块，负责 URL 路由、认证、权限控制和请求分发。这是 LuCI Web 框架的核心组件，处理所有 HTTP 请求的路由和分发。

## 工作原理

1. **请求接收**: `httpdispatch()` 接收 HTTP 请求，解析 URL 路径和令牌
2. **路由树构建**: `createtree()` 扫描控制器目录，构建路由节点树
3. **路径匹配**: `dispatch()` 遍历路由树，匹配请求路径到目标节点
4. **权限检查**: 检查初始化状态、远程访问权限、SDK 权限、认证状态
5. **认证处理**: 通过认证器（jsonauth/htmlauth）验证用户身份
6. **目标执行**: 调用匹配节点的目标处理器（函数、模板、别名等）

## 接口/函数列表

### URL 构建

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `build_url(...)` | 路径组件 | string | 构建完整 URL 路径 |

### 节点操作

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `node(...)` | 路径组件 | table | 获取或创建路由节点 |
| `entry(path, target, title, order, flag)` | 路径表、目标、标题、排序、标志 | table | 注册路由入口 |
| `assign(path, target, title, order, flag)` | 路径表、目标路径、标题、排序、标志 | table | 分配路由别名 |
| `get(...)` | 路径组件 | table | 获取路由节点 |
| `node_visible(node)` | 节点 | boolean | 检查节点是否可见 |
| `node_childs(node)` | 节点 | table | 获取可见子节点列表 |

### 目标处理器工厂

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `call(name, ...)` | 函数名、参数 | table | 创建函数调用目标 |
| `template(view)` | 模板名 | table | 创建模板渲染目标 |
| `alias(...)` | 目标路径 | function | 创建别名目标 |
| `rewrite(n, ...)` | 移除数量、新路径 | function | 创建重写目标 |
| `firstchild()` | 无 | table | 创建跳转到第一个子节点目标 |
| `arcombine(target1, target2)` | 两个目标 | table | 创建组合目标 |

### 调度函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `httpdispatch(request, prefix)` | HTTP 请求、前缀 | void | HTTP 请求分发入口 |
| `dispatch(path)` | 路径表 | void | 核心调度函数 |
| `createtree()` | 无 | table | 创建路由树 |
| `createindex()` | 无 | void | 创建控制器索引 |

### 错误处理

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `error404(message)` | 错误消息 | false | 显示 404 错误页面 |
| `error500(message)` | 错误消息 | false | 显示 500 错误页面 |
| `errorpage(code, message)` | 状态码、消息 | false | 显示自定义错误页面 |

### 认证器

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `authenticator.jsonauth(validator, accs, default)` | 验证器、用户列表、默认用户 | user, type | JSON API 认证 |
| `authenticator.htmlauth(validator, accs, default)` | 验证器、用户列表、默认用户 | user, type | HTML 页面认证 |
| `authenticator.htmlauth_moblie(validator, accs, default)` | 验证器、用户列表、默认用户 | user, type | 移动端认证 |

### 权限标志检查

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `_noauthAccessAllowed(flag)` | 标志 | boolean | 检查是否允许无认证访问 (bit 0) |
| `_remoteAccessForbidden(flag)` | 标志 | boolean | 检查是否禁止远程访问 (bit 1) |
| `_syslockAccessAllowed(flag)` | 标志 | boolean | 检查是否允许系统锁定时访问 (bit 2) |
| `_noinitAccessAllowed(flag)` | 标志 | boolean | 检查是否允许未初始化时访问 (bit 3) |
| `_sdkFilter(flag)` | 标志 | boolean | 检查是否需要 SDK 过滤 (bit 4) |

### 辅助函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `getremotemac(useExtended)` | 是否使用扩展方法 | string | 获取远程客户端 MAC 地址 |
| `check_show_syslock(authType)` | 认证类型 | boolean | 检查是否显示系统锁定页面 |
| `modifier(func, order)` | 函数、顺序 | void | 注册路由修改器 |

## 外部依赖

### Lua 模块
- `nixio.fs` - 文件系统操作
- `bit` - 位运算
- `luci.sys` - 系统信息
- `luci.init` - LuCI 初始化
- `luci.util` - 工具函数
- `luci.http` - HTTP 处理
- `nixio` - 底层 I/O
- `luci.i18n` - 国际化
- `luci.sauth` - 会话认证
- `luci.config` - 配置
- `luci.template` - 模板引擎

### 小米模块
- `xiaoqiang.util.XQSecureUtil` - 安全工具
- `xiaoqiang.common.XQFunction` - 通用函数
- `xiaoqiang.util.XQSysUtil` - 系统工具
- `xiaoqiang.util.XQDBUtil` - 数据库工具
- `xiaoqiang.util.XQCryptoUtil` - 加密工具
- `xiaoqiang.util.XQSDKUtil` - SDK 工具
- `xiaoqiang.XQLog` - 日志
- `xiaoqiang.XQPushHelper` - 推送助手

## 被引用情况

- `luci/sgi/cgi.lua` - CGI 网关调用 `httpdispatch`
- 所有控制器模块使用 `entry()`, `node()`, `call()`, `template()` 等函数注册路由
- `luci/http.lua` - 构建重定向 URL

## 关键代码说明

### 权限标志位定义
```lua
-- bit 0: 允许无认证访问
-- bit 1: 禁止远程访问
-- bit 2: 允许系统锁定时访问
-- bit 3: 允许未初始化时访问
-- bit 4: 需要 SDK 权限过滤
```

### 路由节点结构
```lua
{
    target = function/table,  -- 目标处理器
    title = string,           -- 显示标题
    order = number,           -- 排序权重
    flag = number,            -- 权限标志
    module = string,          -- 所属模块
    nodes = {},               -- 子节点
    sysauth = string/table,   -- 需要的认证用户
    sysauth_authenticator = string/function  -- 认证器
}
```

### 认证流程
1. 检查是否本地访问（127.0.0.1/localhost）
2. 获取 URL 中的 session token (stok)
3. 读取会话数据验证用户
4. 如果未认证，调用认证器
5. 认证成功后创建新会话
