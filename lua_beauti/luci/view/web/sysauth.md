# sysauth.htm - 系统登录认证页面

## 文件作用
路由器管理后台的登录页面，支持 PC 端和移动端自适应，提供密码登录和 APP 引导功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.module.XQTopology` | 网络拓扑 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys.net` | 网络系统函数 |

## 页面原理

### 初始化检测
```lua
if not XQSysUtil.getInitInfo() then
    luci.http.redirect("/init.html")
end
```
未初始化的路由器自动跳转到初始化向导。

### 设备检测与跳转
```javascript
if ((isMobile.Android() || isMobile.iOS()) && flag != "pc" && netmod != 3 && !iscpe) {
    window.location.href = protocol + "//" + domain + "/main.html";
}
```
移动设备自动跳转到移动端页面。

### Mesh 拓扑检测
```lua
local topo = XQTopology.topologicalGraph()
if leafs and #leafs > 0 then
    luci.http.redirect(luci.dispatcher.build_url("web", "topo"))
end
```
通过 miwifi.com 访问且存在 Mesh 子设备时跳转到拓扑页。

## 依赖关系
- `web/inc/head` - 页面头部
- `web/css/bc.css` - 基础样式
- `web/css/login.css` - 登录页样式
- `web/css/guide.css` - 引导页样式

## 页面功能

### PC 端
- 密码输入表单
- 米家 APP 下载二维码
- 官方网站链接

### 移动端
- APP 下载引导
- 功能特性介绍

## 安全特性
- 获取访问者 MAC 地址用于设备识别
- 支持绑定状态检测
- 多种登录类型支持
