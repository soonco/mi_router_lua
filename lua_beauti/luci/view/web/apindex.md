# apindex.htm - AP模式主页

## 文件作用
路由器在 AP（接入点）模式下的主页面，显示网络拓扑、设备连接状态和 WiFi 信息。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |

## 页面原理

### 网络模式判断
根据 `netmod` 变量显示不同的网络拓扑：
- **netmod=2, capmode=1**: Mesh LAN AP 模式
- **netmod=3**: Mesh 从设备模式
- 其他: 普通 LAN AP 模式

### 页面结构
1. **终端设备区** - 显示连接的设备数量
2. **路由器区** - 显示路由器图标和 WiFi 状态
3. **WiFi 信息** - 2.4GHz/5GHz/5GHz-Game 频段状态

### 动态图标
根据硬件型号和颜色动态生成路由器图标路径：
```lua
local routerSrc = "router_".._hardware.."_".. color..".png"
```

## 依赖关系
- `web/inc/xxx.lua` - 扩展功能
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/css/bc.css` - 基础样式
- `web/css/index.css` - 首页样式

## 关键代码说明

### 设备计数
```lua
local count, total = XQDeviceUtil.get2g5gDeviceCount()
```
获取 2.4G 和 5G 频段的设备连接数量。

### Mesh 支持
页面支持 Mesh 组网模式，可显示主路由和子路由的连接关系。
