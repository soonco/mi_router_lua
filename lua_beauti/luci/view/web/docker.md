# docker.htm - Docker管理页面

## 文件作用
提供 Docker 容器管理界面，通过 iframe 嵌入 Portainer 或其他 Docker 管理工具。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |

## 页面原理

### 页面结构
1. 标准页面头部和导航
2. iframe 容器嵌入 Docker 管理界面
3. 页面底部和脚本

### iframe 动态地址
```javascript
document.getElementById("shell_iframe").src = "http://"+document.domain+":9001/";
```
自动获取当前域名并拼接 9001 端口（Portainer 默认端口）。

### 安全设置
```html
<meta name="referrer" content="never">
```
禁止发送 Referrer 头，保护隐私。

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/reboot.js` - 重启功能
- `web/inc/sysinfo.js` - 系统信息

## 使用前提
- 路由器需要安装 Docker
- 需要运行 Portainer 或类似的 Docker 管理工具
- 管理工具需要监听 9001 端口
