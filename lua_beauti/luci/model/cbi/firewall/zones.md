# zones.lua - 防火墙区域设置页面模块

## 工作原理

本模块是 LuCI CBI 框架的防火墙区域设置页面，显示和管理防火墙全局设置及区域列表。

**核心功能:**
- 显示防火墙全局默认策略设置
- 显示所有防火墙区域 (Zone) 的列表
- 支持添加、删除防火墙区域
- 配置区域的入站、出站、转发策略

**防火墙区域概念:**
- 区域是网络接口的逻辑分组
- 常见区域: wan(外网)、lan(内网)、guest(访客网络)
- 区域之间的流量由转发规则控制

**策略说明:**
- ACCEPT: 允许流量通过
- REJECT: 拒绝并返回错误信息
- DROP: 静默丢弃流量

**配置存储:** `/etc/config/firewall`

## 接口

### 全局默认设置 (TypedSection: defaults)

| 选项 | UCI字段 | 类型 | 说明 |
|------|---------|------|------|
| SYN洪水防护 | syn_flood | Flag | 启用SYN-flood攻击防护 |
| 丢弃无效包 | drop_invalid | Flag | 丢弃无效数据包（默认禁用） |
| 默认入站策略 | input | ListValue | REJECT/DROP/ACCEPT |
| 默认出站策略 | output | ListValue | REJECT/DROP/ACCEPT |
| 默认转发策略 | forward | ListValue | REJECT/DROP/ACCEPT |

### 区域列表 (TypedSection: zone)

| 属性 | 值 | 说明 |
|------|-----|------|
| template | cbi/tblsection | 表格模板 |
| anonymous | true | 匿名配置段 |
| addremove | true | 允许添加和删除区域 |
| extedit | admin/network/firewall/zones/%s | 编辑跳转URL |

### 区域表格列

| 列 | UCI字段 | 类型 | 说明 |
|-----|---------|------|------|
| 区域信息 | _info | DummyValue | 区域名称和转发关系（自定义模板） |
| 入站策略 | input | ListValue | REJECT/DROP/ACCEPT |
| 出站策略 | output | ListValue | REJECT/DROP/ACCEPT |
| 转发策略 | forward | ListValue | REJECT/DROP/ACCEPT |
| 伪装 | masq | Flag | 启用NAT伪装 |
| MSS钳制 | mtu_fix | Flag | 自动调整TCP MSS值 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| zoneSection.create() | 创建新区域时的处理 |
| zoneSection.remove() | 删除区域时同时删除相关转发规则 |
| infoColumn.cfgvalue() | 返回区域ID用于自定义模板显示 |

### 使用的模板

- `cbi/tblsection`: 表格布局模板
- `cbi/firewall_zoneforwards`: 区域转发关系显示模板

## 外部引用

- `luci.dispatcher`: 路由调度器
- `luci.model.firewall`: 防火墙模型
