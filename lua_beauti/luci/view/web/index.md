# index.htm - 路由器主页

## 文件作用
小米路由器 Web 管理界面的主页，显示网络拓扑图、设备连接状态、WiFi 信息等核心功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |

## 页面原理

### 网络拓扑展示
页面展示三层网络结构：
1. **终端设备** - 连接到路由器的设备
2. **路由器** - 当前路由器状态
3. **互联网** - WAN 连接状态

### WiFi 状态显示
根据硬件支持显示不同频段：
- 2.4GHz WiFi 状态
- 5GHz WiFi 状态
- 5GHz-Game 频段（部分型号）

### 动态内容
- 设备在线数量实时更新
- WiFi SSID 和状态动态获取
- 网络连接状态动画展示

## 依赖关系
- `web/inc/xxx.lua` - 扩展功能
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/css/bc.css` - 基础样式
- `web/css/qos.css` - QoS 样式
- `web/css/index.css` - 首页样式

## 关键代码说明

### 路由器图标
```lua
local routerSrc = "router_".._hardware.."_".. color..".png"
local routerSrcOn = "router_".._hardware.."_".. color.."_on.png"
```
根据硬件型号和颜色动态生成路由器图标。

### 功能特性检测
```lua
local features = require("xiaoqiang.XQFeatures").FEATURES
local wifi50IsSupport = features["wifi"]["wifi50"]
```
检测硬件是否支持 5GHz WiFi 等功能。
