# index.htm - 首页重定向页面

## 文件作用
LuCI 根路径的入口页面，自动将用户重定向到路由器 Web 管理界面的主页。

## 使用的 API
| API | 说明 |
|-----|------|
| `luci.dispatcher.build_url()` | 构建 LuCI 内部 URL |

## 页面原理
1. **URL 构建**: 使用 `build_url("web", "home")` 生成主页完整路径
2. **双重重定向**: 
   - JavaScript 重定向：`window.location.href`
   - NoScript 回退：`<meta http-equiv="refresh">` 标签
3. **浏览器兼容**: 使用 IE 条件注释处理旧版 IE 浏览器

## 依赖关系
无外部模板依赖

## 关键代码说明
```lua
local home = luci.dispatcher.build_url("web", "home")
```
动态构建主页 URL，确保在不同部署环境下路径正确。

```html
<noscript>
<meta http-equiv="refresh" content="0; url=/cgi-bin/luci/web" />
</noscript>
```
为禁用 JavaScript 的浏览器提供 meta 刷新重定向作为备选方案。
