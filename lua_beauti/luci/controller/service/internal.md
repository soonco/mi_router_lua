# internal.lua - 内部服务API模块

## 工作原理

提供内部服务接口，包括 CC 游戏加速、IPv6 加速和自定义 hosts 管理。通过 ubus 与后端服务通信，支持服务启动检测和自动启动机制。

### 服务检测机制

1. 检查 ubus 服务是否已注册
2. 如未运行，执行启动命令
3. 最多重试 3 次，每次间隔 1 秒

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `index()` | 无 | 无 | 注册 API 路由 |
| `turbo_ccgame_call()` | HTTP: cmd, ip, byvpn, game, region, ubus | JSON | CC 游戏加速控制 |
| `turbo_ipv6_call()` | HTTP: cmd, ubus | JSON | IPv6 加速服务控制 |
| `custom_host_get()` | 无 | JSON: hosts[] | 获取自定义 hosts |
| `custom_host_set()` | HTTP: hosts | JSON | 设置自定义 hosts |

### API 端点

| 路径 | 函数 | 说明 |
|------|------|------|
| `/service/internal/ccgame` | turbo_ccgame_call | CC 游戏加速控制 |
| `/service/internal/ipv6` | turbo_ipv6_call | IPv6 加速服务控制 |
| `/service/internal/custom_host_get` | custom_host_get | 获取自定义 hosts |
| `/service/internal/custom_host_set` | custom_host_set | 设置自定义 hosts |

### CC 游戏加速命令

| cmd | 说明 |
|-----|------|
| 0 | 自定义 ubus 命令 |
| 1 | 启动加速 |
| 2 | 停止加速 |
| 3 | 获取状态 |
| 4-7 | 其他操作 |

### IPv6 加速命令

| cmd | 说明 |
|-----|------|
| 0 | 自定义 ubus 命令 |
| 1 | 启动服务（需激活账号） |
| 2 | 停止服务 |
| 3 | 获取状态 |

### hosts 文件路径

| 路径 | 说明 |
|------|------|
| `/tmp/hosts/custom_hosts` | 临时 hosts 文件 |
| `/etc/custom_hosts` | 永久 hosts 文件 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.util` | 工具函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `service.util.ServiceErrorUtil` | 服务错误处理 |
| `cjson` | JSON 编解码 |
| `nixio` / `nixio.fs` | 文件系统操作 |
| `xiaoqiang.XQLog` | 日志模块 |
| `turbo.ccgame.ccgame_interface` | CC 游戏加速接口 |
| `ubus` | 系统总线通信 |
