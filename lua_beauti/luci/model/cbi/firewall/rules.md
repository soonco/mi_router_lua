# rules.lua - 防火墙流量规则列表页面模块

## 工作原理

本模块是 LuCI CBI 框架的防火墙流量规则列表页面，显示和管理所有流量规则。

**核心功能:**
- 显示所有流量规则 (Traffic Rules) 的列表
- 支持添加、删除、排序流量规则
- 包含普通规则和 SNAT (源地址转换) 规则两个部分
- 提供快速添加规则的表单

**流量规则说明:**
- 定义不同区域之间的流量策略
- 可以允许(ACCEPT)、拒绝(REJECT)、丢弃(DROP)流量
- 例如: 允许WAN区域访问路由器的SSH端口

**SNAT说明:**
- 修改出站流量的源IP地址
- 用于多WAN负载均衡或特定出口IP需求

**配置存储:** `/etc/config/firewall`

## 接口

### 流量规则列表 (TypedSection: rule)

| 属性 | 值 | 说明 |
|------|-----|------|
| addremove | true | 允许添加和删除规则 |
| anonymous | true | 匿名配置段 |
| sortable | true | 允许拖拽排序 |
| template | cbi/tblsection | 表格模板 |
| extedit | admin/network/firewall/rules/%s | 编辑跳转URL |
| defaults.target | ACCEPT | 新规则默认动作 |

### 流量规则表格列

| 列 | 类型 | 说明 |
|-----|------|------|
| 名称 | DummyValue | 规则名称 |
| 匹配条件 | DummyValue | 协议/源/目标信息 |
| 动作 | DummyValue | ACCEPT/REJECT/DROP等 |
| 启用 | Flag | 启用开关 |

### SNAT规则列表 (TypedSection: redirect)

| 属性 | 值 | 说明 |
|------|-----|------|
| filter | target == "SNAT" | 只显示SNAT规则 |
| addremove | true | 允许添加和删除规则 |
| sortable | true | 允许拖拽排序 |

### SNAT规则表格列

| 列 | 类型 | 说明 |
|-----|------|------|
| 名称 | DummyValue | 规则名称 |
| 匹配条件 | DummyValue | 协议/源/目标信息 |
| 动作 | DummyValue | 重写的源IP和端口 |
| 启用 | Flag | 启用开关 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| ruleSection.parse() | 处理"打开端口"和"转发规则"表单 |
| snatSection.filter() | 过滤只显示SNAT规则 |
| snatSection.parse() | 处理新SNAT规则表单 |
| formatProtocol() | 格式化协议显示 |
| formatSource() | 格式化源信息显示 |
| formatDestination() | 格式化目标信息显示 |
| formatSnatSource() | 格式化SNAT源信息显示 |

## 外部引用

- `luci.dispatcher`: 路由调度器
- `luci.tools.firewall`: 防火墙工具函数（格式化显示）
