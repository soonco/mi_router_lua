# wifi.htm - AP模式WiFi设置页面

## 文件作用
路由器在 AP/中继模式下的 WiFi 设置页面，提供多频合一、MLO、信道等 WiFi 配置功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `luci.json` | JSON 处理 |

## 页面原理

### 功能模块

#### WiFi 多频合一
```lua
<%if features["wifi"]["wifimerge"] == "1" then%>
```
将 2.4GHz 和 5GHz 合并为同一个 SSID，由路由器自动选择最佳频段。

#### MLO 多链路连接
```lua
<%if features.wifi.mlo == '1' then%>
```
WiFi 7 特性，支持多频段并发接入，提高速率降低延迟。

### 信道配置
```lua
local channel1 = WifiUtil.getDefaultWifiChannels(1)  -- 2.4GHz
local channel2 = WifiUtil.getDefaultWifiChannels(2)  -- 5GHz
local channel3 = WifiUtil.getDefaultWifiChannels(3)  -- 5GHz-2/Game
```

### 网络模式判断
- netmod=3: Mesh 从设备模式
- netmod=4: Mesh 主设备模式
- netmod=0: 普通路由器模式

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/g.js` - 全局 JavaScript
- `web/css/bc.css` - 基础样式
- `web/css/wifi.css` - WiFi 设置样式

## 特殊功能
- 静音模式支持检测
- WiFi 游戏频段支持
- 多 WLAN 接口支持
