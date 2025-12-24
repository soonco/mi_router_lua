# header.htm - 页头模板分发器

## 文件作用
作为页头模板的分发器，根据当前使用的主题动态加载对应主题的 header 模板文件，并防止重复发送页头。

## 使用的 API
| API | 说明 |
|-----|------|
| `theme` | 全局变量，当前使用的主题名称 |
| `include()` | LuCI 模板引入函数 |
| `luci.dispatcher.context.template_header_sent` | 标记页头是否已发送 |

## 页面原理
1. **防重复机制**: 检查 `template_header_sent` 标志，避免页头被多次渲染
2. **主题适配**: 根据 `theme` 变量值动态拼接模板路径
3. **状态标记**: 发送页头后设置标志为 `true`

## 依赖关系
- `themes/openwrt.org/header.htm` - OpenWrt 官方主题页头
- `themes/xiaoqiang/header.htm` - 小米路由器主题页头

## 关键代码说明
```lua
if not luci.dispatcher.context.template_header_sent then
    include("themes/" .. theme .. "/header")
    luci.dispatcher.context.template_header_sent = true
end
```
使用上下文变量控制页头只发送一次，防止嵌套模板导致的重复渲染问题。
