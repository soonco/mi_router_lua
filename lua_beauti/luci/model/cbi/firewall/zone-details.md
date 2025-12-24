# zone-details.lua - 防火墙区域详细配置页面模块

## 工作原理

本模块是 LuCI CBI 框架的防火墙区域详细配置页面，提供防火墙区域的完整配置界面。

**核心功能:**
- 配置区域的入站、出站、转发策略
- 配置区域关联的网络接口
- 配置区域间的转发规则
- 高级选项: 地址族限制、伪装子网限制、日志等

**区域(Zone)概念:**
- 区域是网络接口的逻辑分组
- 定义该组接口的默认流量策略
- 区域间转发需要明确配置

**配置存储:** `/etc/config/firewall`

## 接口

### 基本设置标签页 (General Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 区域名称 | name | Value | 必填，支持重命名 |
| 入站策略 | input | ListValue | REJECT/DROP/ACCEPT |
| 出站策略 | output | ListValue | REJECT/DROP/ACCEPT |
| 转发策略 | forward | ListValue | REJECT/DROP/ACCEPT |
| 伪装 | masq | Flag | 启用NAT伪装 |
| MSS钳制 | mtu_fix | Flag | 自动调整TCP MSS值 |
| 关联网络 | network | Value | 选择网络接口（复选框） |

### 高级设置标签页 (Advanced Settings)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| 地址族限制 | family | ListValue | IPv4和IPv6/仅IPv4/仅IPv6 |
| 伪装源子网限制 | masq_src | DynamicList | 限制NAT的源子网 |
| 伪装目标子网限制 | masq_dest | DynamicList | 限制NAT的目标子网 |
| 强制连接跟踪 | conntrack | Flag | 强制启用conntrack |
| 启用日志 | log | Flag | 记录该区域流量日志 |
| 日志速率限制 | log_limit | Value | 如10/minute |

### 区域间转发配置

| 选项 | 类型 | 说明 |
|------|------|------|
| 允许转发到目标区域 | Value (checkbox) | 从当前区域转发到其他区域 |
| 允许从源区域转发 | Value (checkbox) | 从其他区域转发到当前区域 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| nameOption.write() | 处理区域重命名，更新所有引用 |
| networkOption.cfgvalue() | 获取区域关联的网络列表 |
| networkOption.write() | 设置区域关联的网络列表 |
| destZonesOption.cfgvalue() | 获取出站转发区域列表 |
| srcZonesOption.cfgvalue() | 获取入站转发区域列表 |
| destZonesOption.write() | 设置出站转发规则 |
| srcZonesOption.write() | 设置入站转发规则 |

## 外部引用

- `luci.model.network`: 网络模型
- `luci.model.firewall`: 防火墙模型
- `luci.dispatcher`: 路由调度器
- `luci.util`: 工具函数
