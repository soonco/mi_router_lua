# wan.htm - AP模式网络模式切换页面

## 文件作用
路由器在 AP/中继模式下的网络模式切换页面，支持有线中继和无线中继模式的切换。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys.net` | 网络系统函数 |

## 页面原理

### 网络模式检测
```lua
local mode = XQFunction.getNetMode()
if mode == "lanapmode" then
    netMode = 2  -- 有线中继
elseif mode == "wifiapmode" then
    netMode = 1  -- 无线中继
end
```

### 条件显示
- 无线中继模式（netMode=1）时显示上级路由器切换组件
- 有线中继模式（netMode=2）时隐藏该组件

### 页面结构
1. 网络模式切换组件
2. 上级路由器切换组件（仅无线中继模式）

## 依赖关系

### 模板文件
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/netmod` - 网络模式组件
- `web/inc/aprouterchange` - AP 路由器切换组件
- `web/inc/footer` - 页面尾部

### JavaScript 文件
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/netmod.js` - 网络模式脚本
- `web/inc/aprouterchange.js` - AP 路由器切换脚本

### 样式文件
- `web/css/bc.css` - 基础样式
- `web/css/upgrade.css` - 升级页样式
