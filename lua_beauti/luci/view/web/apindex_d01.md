# apindex_d01.htm - D01型号AP模式主页

## 文件作用
专为 D01 型号路由器设计的 AP 模式主页，显示网络拓扑和中继连接状态。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.XQFeatures` | 功能特性 |

## 页面原理

### 网络模式显示
根据 `netmod` 值显示不同的中继类型：
- **netmod=1**: 无线中继
- **netmod=2**: 有线中继
- **netmod=3**: Mesh组网

### 页面结构
1. **终端设备区** - 显示连接设备
2. **路由器区** - 本机路由器信息
3. **中继线路** - 显示中继连接类型
4. **上级路由器** - 显示上级设备信息（如有）

### 上级设备信息
```lua
local vendorInfo = XQSysUtil.getVendorInfo()
```
获取上级路由器的 IP、硬件型号和颜色信息。

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/css/bc.css` - 基础样式
- `web/css/index.css` - 首页样式

## 与 apindex.htm 的区别
- 专门针对 D01 型号优化
- 增加了上级路由器的显示和链接
- 简化了设备计数显示
