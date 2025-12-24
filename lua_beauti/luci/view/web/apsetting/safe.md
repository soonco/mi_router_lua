# safe.htm - AP模式安全中心页面

## 文件作用
路由器在 AP/中继模式下的安全设置页面，主要提供管理密码修改功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys.net` | 网络系统函数 |

## 页面原理

### 安全信息获取
```lua
local remote_addr = luci.http.getenv("REMOTE_ADDR") or ""
local mac = string.upper(luci.sys.net.ip4mac(remote_addr) or "")
local macdefault = string.upper(xqlanwanutil.getDefaultMacAddress())
```
获取访问者 IP 和 MAC 地址，以及路由器默认 MAC 地址。

### 页面结构
1. 页面头部和导航
2. 密码设置组件
3. 页面尾部

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/password` - 密码设置组件
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/password.js` - 密码设置脚本
- `web/css/bc.css` - 基础样式
- `web/css/upgrade.css` - 升级页样式

## 功能说明
此页面用于 AP/中继模式下修改路由器管理密码，保障设备安全。
