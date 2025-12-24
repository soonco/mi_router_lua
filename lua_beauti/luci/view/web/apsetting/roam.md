# roam.htm - WiFi漫游设置页面

## 文件作用
配置 WiFi 漫游功能，通过设置信号阈值引导弱信号设备切换到更好的网络。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |

### 后端接口
| 接口 | 说明 |
|------|------|
| `api/xqnetwork/set_wifi_weak` | 设置弱信号阈值 |

## 页面原理

### 漫游参数
| 参数 | 说明 | 取值范围 |
|------|------|----------|
| 拒绝阈值 | 信号低于此值时拒绝设备接入 | -95 ~ -65 dBm |
| 踢除阈值 | 信号低于此值时强制设备下线 | -100 ~ -70 dBm |

### 适用场景
1. 多路由器环境下引导设备连接信号更好的路由器
2. 单路由器环境下引导设备切换到移动网络
3. 高负载时踢除弱信号设备减轻压力

### 硬件限制
仅支持特定型号：R3A、R3G、R4AC

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/devcenter` - 设备中心组件
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/css/bc.css` - 基础样式
- `web/css/wifi.css` - WiFi 设置样式
- `web/css/upnp.css` - UPnP 样式

## 警告
开启此功能可能导致某些设备无法接入路由器，建议非专业人士谨慎使用。
