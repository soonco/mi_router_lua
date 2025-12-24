# upgrade.htm - AP模式系统信息与升级页面

## 文件作用
路由器在 AP/中继模式下的系统信息和升级设置页面，集成多个系统配置功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys.net` | 网络系统函数 |

## 页面原理

### 集成功能模块
页面通过 include 引入多个功能组件：
1. **Mesh 回程模式** - `meshbhmode` 组件
2. **LED 开关** - `led-switch` 组件
3. **温控设置** - `temp-control` 组件
4. **系统信息** - `sysinfo` 组件

### 页面结构
每个功能模块都有对应的 HTML 组件和 JavaScript 脚本。

## 依赖关系

### 模板文件
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/meshbhmode` - Mesh 回程模式
- `web/inc/led-switch` - LED 开关
- `web/inc/temp-control` - 温控设置
- `web/inc/sysinfo` - 系统信息
- `web/inc/footer` - 页面尾部

### JavaScript 文件
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/reboot.js` - 重启功能
- `web/inc/sysinfo.js` - 系统信息脚本
- `web/inc/meshbhmode.js` - Mesh 回程脚本
- `web/inc/led-switch.js` - LED 开关脚本
- `web/inc/temp-control.js` - 温控脚本

### 样式文件
- `web/css/bc.css` - 基础样式
- `web/css/upgrade.css` - 升级页样式
