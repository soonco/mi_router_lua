# cbi_addsnat.htm - 源NAT规则添加表单

## 文件作用
提供添加源地址转换（SNAT）规则的表单界面，用于配置出站流量的源地址伪装。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.model.firewall` | 防火墙配置模型 |
| `luci.model.network` | 网络配置模型 |

### JavaScript 函数
| 函数 | 说明 |
|------|------|
| `cbi_validate_field()` | CBI 表单字段验证 |
| `cbi_combobox_init()` | 初始化下拉组合框 |

## 页面原理

### SNAT 概念
源NAT（Source NAT）用于修改出站数据包的源IP地址，常用于：
- 多WAN负载均衡
- 特定流量路由
- IP地址伪装

### 表单字段
| 字段 | 说明 | 验证规则 |
|------|------|----------|
| Name | 规则名称 | - |
| Source zone | 源区域 | 默认 LAN |
| Destination zone | 目标区域 | 默认 WAN |
| To source IP | 转换后的源IP | ip4addr |
| To source port | 转换后的源端口 | portrange |

## 依赖关系
- `luci.model.firewall` - 防火墙模型
- `luci.model.network` - 网络模型
- CBI 框架组件

## 关键代码说明

### IP 地址选项
```lua
for k, v in ipairs(nw:get_interfaces()) do
    for k, a in ipairs(v:ipaddrs()) do
        -- 生成 IP 地址选项，格式：IP (接口名)
    end
end
```
自动获取所有网络接口的 IP 地址作为下拉选项。

### 条件渲染
只有当 WAN 和 LAN 区域都存在时才显示完整的 SNAT 配置表单。
