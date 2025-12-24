# lannetset.htm - AP模式局域网设置页面

## 文件作用
路由器在 AP 模式下的局域网设置页面，主要提供 LAN 口聚合等网络配置功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |

## 页面原理

### 功能特性检测
```lua
<%if features["apps"]["lanPort"] == "1" then%>
<%include("web/inc/wanCheck")%>
<%end%>
```
根据硬件是否支持 LAN 口聚合功能来决定是否显示相关配置。

### 页面结构
1. 页面头部和导航
2. LAN 口检测/聚合配置（条件显示）
3. 页面尾部

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/wanCheck` - WAN/LAN 检测组件
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/wanCheck.js` - WAN 检测脚本
- `web/css/bc.css` - 基础样式
- `web/css/proset.css` - 高级设置样式
- `web/css/wancheck.css` - WAN 检测样式

## 安全设置
```html
<meta name="referrer" content="never">
```
禁止发送 Referrer 头。
