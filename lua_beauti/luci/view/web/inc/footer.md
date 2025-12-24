# footer.htm - 页面底部模板

## 文件作用
提供小米路由器 Web 管理界面的页脚，显示系统版本、MAC 地址和官方链接。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `luci.i18n` | 国际化支持 |

## 页面原理

### 版本信息
```lua
local romVersion = XQSysUtil.getDisplayRomVersion()
local _romChannel = XQSysUtil.getChannel()
```
显示当前固件版本和渠道（开发版/内测版/稳定版）。

### 渠道类型
| 渠道 | 显示名称 |
|------|----------|
| current | 内测版 |
| release | 稳定版 |
| 其他 | 开发版 |

### 国家/地区判断
```lua
local ccode = xqCountryCode.getBDataCountryCode()
```
中国大陆用户显示官方网站、微博、微信等链接。

## 显示内容
- 系统版本号和渠道
- 路由器 MAC 地址
- 版权信息
- 官方链接（中国大陆）
- 服务热线

## 依赖关系
- 被所有主页面引入
