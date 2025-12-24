# box.htm.htm - 文件浏览器HTML模板

## 文件作用
提供 FileBrowser 文件管理器的用户界面，包含服务控制和认证模式切换按钮。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.sys` | 系统命令执行 |

## 页面原理

### 界面结构
1. **状态显示**: 显示当前认证模式（免密/密码登录）
2. **操作按钮**:
   - 浏览 - 打开 FileBrowser 界面
   - 免密 - 切换到免密模式
   - 加密 - 切换到密码模式
   - 开启 - 启动服务
   - 重启 - 重启服务
   - 关闭 - 停止服务

### 状态检测
```lua
<%=luci.sys.exec("[ '$(uci set lyq.filebrowser)'='' && echo 免密登录 || echo 密码登录")%>
```
通过 UCI 配置判断当前认证模式。

### 访问地址
```javascript
window.open('http://'+document.domain+':18888', '_blank')
```
FileBrowser 默认运行在 **18888** 端口。

## 依赖关系
- `box.js.htm` - 交互逻辑
- `box.css.htm` - 样式定义
- `box.lua.htm` - 后端处理

## 默认凭据
- 用户名: admin
- 密码: admin
