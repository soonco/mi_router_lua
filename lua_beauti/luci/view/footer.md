# footer.htm - 页脚模板分发器

## 文件作用
作为页脚模板的分发器，根据当前使用的主题动态加载对应主题的 footer 模板文件。

## 使用的 API
| API | 说明 |
|-----|------|
| `theme` | 全局变量，当前使用的主题名称 |
| `include()` | LuCI 模板引入函数 |

## 页面原理
1. **主题适配**: 根据 `theme` 变量值动态拼接模板路径
2. **模板加载**: 调用 `include()` 函数加载 `themes/{theme}/footer` 模板
3. **解耦设计**: 实现主题与核心模板的分离，便于主题切换

## 依赖关系
- `themes/openwrt.org/footer.htm` - OpenWrt 官方主题页脚
- `themes/xiaoqiang/footer.htm` - 小米路由器主题页脚

## 关键代码说明
```lua
<% include("themes/" .. theme .. "/footer") %>
```
使用 Lua 字符串拼接动态构建模板路径，实现主题无关的页脚引入机制。
