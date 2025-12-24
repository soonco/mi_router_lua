# footer.htm - OpenWrt 官方主题页脚

## 文件作用
OpenWrt 官方主题的页脚模板，显示 LuCI 版本信息并关闭页面结构标签。

## 使用的 API

### Lua 变量
| 变量 | 说明 |
|------|------|
| `luci.__appname__` | LuCI 应用名称 |
| `luci.__version__` | LuCI 版本号 |

## 页面原理

### 页面结构
1. 清除浮动的 div
2. 关闭主内容区域的 div 标签
3. 显示 "Powered by LuCI (版本号)" 信息
4. 关闭 body 和 html 标签

### 版本展示
```html
Powered by <%= luci.__appname__ .. " (" .. luci.__version__ .. ")" %>
```
动态拼接 LuCI 名称和版本号。

## 依赖关系
- 需要配合 `header.htm` 使用
- 属于 OpenWrt 官方主题的一部分

## 关键代码说明

### 清除浮动
```html
<div class="clear"></div>
```
确保页面布局正确，防止浮动元素影响页脚位置。
