# cbi_addrule.htm - 防火墙规则添加表单

## 文件作用
提供添加防火墙规则的表单界面，包括开放端口规则和转发规则两种类型。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.model.firewall` | 防火墙配置模型 |

### JavaScript 函数
| 函数 | 说明 |
|------|------|
| `cbi_validate_field()` | CBI 表单字段验证 |
| `cbi_bind()` | 事件绑定 |

## 页面原理

### 开放端口规则 (Open ports on router)
允许外部访问路由器指定端口：
| 字段 | 说明 | 验证规则 |
|------|------|----------|
| Name | 规则名称 | - |
| Protocol | 协议类型 | TCP/UDP/TCP+UDP/其他 |
| External port | 外部端口 | list(neg(portrange)) |

### 转发规则 (New forward rule)
配置区域间的流量转发：
| 字段 | 说明 |
|------|------|
| Name | 规则名称 |
| Source zone | 源区域（默认 LAN） |
| Destination zone | 目标区域（默认 WAN） |

### 智能填充
根据端口号自动填充规则名称和协议：
- 22 → SSH (TCP)
- 53 → DNS (TCP+UDP)
- 80 → HTTP (TCP)
- 443 → HTTPS (TCP)

## 依赖关系
- `luci.model.firewall` - 防火墙模型
- CBI 框架组件

## 关键代码说明

### 条件渲染
```lua
<% if wz and lz then %>
    <!-- 显示完整表单 -->
<% else %>
    <!-- 仅显示添加按钮 -->
<% end %>
```
只有当 WAN 和 LAN 区域都存在时才显示完整的规则配置表单。

### 区域选择
动态遍历所有防火墙区域，生成下拉选项，并设置合理的默认值。
