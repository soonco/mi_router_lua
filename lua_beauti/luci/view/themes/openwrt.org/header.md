# header.htm - OpenWrt 官方主题页头

## 文件作用
OpenWrt 官方主题的页头模板，提供完整的页面框架、导航菜单和系统状态显示。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.sys` | 系统信息获取 |
| `luci.http` | HTTP 请求处理 |
| `luci.dispatcher` | 路由分发器 |
| `luci.model.uci` | UCI 配置管理 |

### 关键函数
| 函数 | 说明 |
|------|------|
| `sys.hostname()` | 获取主机名 |
| `sys.loadavg()` | 获取系统负载 |
| `disp.node_childs()` | 获取子节点列表 |

## 页面原理

### 页面结构
1. **XML 声明和 DOCTYPE** - XHTML 1.0 Strict
2. **头部信息** - 样式表、脚本、标题
3. **跳转链接** - 无障碍访问支持
4. **菜单栏** - 主机信息、负载、自动刷新状态
5. **模式菜单** - 顶级分类导航
6. **保存菜单** - UCI 未保存更改提示
7. **标签菜单** - 多级子菜单（递归生成）
8. **主内容区** - 包含 NoScript 警告和密码提示

### 菜单生成
使用递归函数 `subtree()` 生成多级菜单：
```lua
local function subtree(prefix, node, level)
    -- 遍历子节点生成菜单项
    -- 递归调用生成子菜单
end
```

### 安全提示
- NoScript 警告：提示用户启用 JavaScript
- 密码提示：root 用户未设置密码时显示警告

## 依赖关系
- `cascade.css` - 主样式表
- `ie6.css/ie7.css/ie8.css` - IE 兼容样式
- `xhr.js` - AJAX 请求库

## 关键代码说明

### 菜单选中状态
```lua
for i, r in ipairs(request) do
    if c.nodes and c.nodes[r] then
        c = c.nodes[r]
        c._menu_selected = true
    end
end
```
遍历请求路径，标记所有父级菜单为选中状态。

### UCI 更改计数
```lua
for i, j in pairs(require("luci.model.uci").cursor():changes()) do
    for k, l in pairs(j) do
        for m, n in pairs(l) do
            ucic = ucic + 1;
        end
    end
end
```
统计所有未保存的 UCI 配置更改数量。
