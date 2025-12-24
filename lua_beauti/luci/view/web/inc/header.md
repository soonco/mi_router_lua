# header.htm - 页面导航头部模板

## 文件作用
提供小米路由器 Web 管理界面的顶部导航栏，包含 Logo、菜单、用户操作等元素。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.module.XQTopology` | 网络拓扑 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |

## 页面原理

### 网络模式检测
```lua
local mode = XQFunction.getNetMode()
-- lanapmode: 有线中继 (netMode=2)
-- wifiapmode: 无线中继 (netMode=1)
-- whc_cap: Mesh主设备 (netMode=0)
-- whc_re: Mesh从设备 (netMode=3)
```

### 功能特性检测
- `storageSupport`: 存储功能支持
- `dockerSupport`: Docker 支持
- `ports_custom`: 端口自定义
- `lan_port`: LAN 口聚合

### 导航元素
1. **Logo**: 链接到首页
2. **扩展功能入口**: header_box 组件
3. **网络拓扑链接**: 条件显示
4. **添加 Mesh 子路由**: Mesh 模式下显示
5. **系统菜单**: 路由器名称下拉菜单

## 依赖关系
- `web/inc/header_box` - 扩展功能入口
- 被所有主页面引入
