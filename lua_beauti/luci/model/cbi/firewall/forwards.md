# forwards.lua - 端口转发列表页面模块

## 工作原理

本模块是 LuCI CBI 框架的端口转发列表页面，显示和管理所有端口转发(DNAT)规则。

**核心功能:**
- 显示所有端口转发规则的列表
- 支持添加、删除、排序端口转发规则
- 提供快速添加端口转发的表单
- 点击规则可进入详细编辑页面

**端口转发原理:**
- 将外网访问路由器特定端口的流量转发到内网主机
- 实现内网服务器对外提供服务
- 例如: 外网访问 WAN_IP:8080 -> 转发到 192.168.1.100:80

**配置存储:** `/etc/config/firewall`

## 接口

### 端口转发列表 (TypedSection: redirect)

| 属性 | 值 | 说明 |
|------|-----|------|
| filter | target != "SNAT" | 排除SNAT规则，只显示DNAT |
| addremove | true | 允许添加和删除规则 |
| anonymous | true | 匿名配置段 |
| sortable | true | 允许拖拽排序 |
| template | cbi/tblsection | 表格模板 |
| extedit | admin/network/firewall/forwards/%s | 编辑跳转URL |

### 表格列定义

| 列 | 类型 | 宽度 | 说明 |
|-----|------|------|------|
| 名称 | DummyValue | - | 规则名称 |
| 匹配条件 | DummyValue | 50% | 协议/源/外部访问点信息 |
| 转发目标 | DummyValue | 40% | 内网主机和端口 |
| 启用 | Flag | 1% | 启用开关 |

### 新规则创建参数

| 参数 | 表单字段 | 说明 |
|------|---------|------|
| 名称 | _newfwd.name | 规则名称 |
| 协议 | _newfwd.proto | TCP/UDP/other |
| 外部区域 | _newfwd.extzone | 默认wan |
| 外部端口 | _newfwd.extport | WAN侧监听端口 |
| 内部区域 | _newfwd.intzone | 默认lan |
| 内部地址 | _newfwd.intaddr | 转发目标IP |
| 内部端口 | _newfwd.intport | 转发目标端口 |

### 自定义函数

| 函数 | 说明 |
|------|------|
| forwardSection.filter() | 过滤只显示DNAT规则（排除SNAT） |
| forwardSection.create() | 创建新端口转发规则 |
| forwardSection.parse() | 解析表单并处理重定向 |
| formatProtocol() | 格式化协议显示（IPv4-协议） |
| formatSource() | 格式化源信息显示 |
| formatExternal() | 格式化外部访问点显示 |
| matchColumn.cfgvalue() | 组合显示匹配条件 |
| destColumn.cfgvalue() | 显示转发目标信息 |

## 外部引用

- `luci.dispatcher`: 路由调度器
- `luci.tools.firewall`: 防火墙工具函数（格式化显示）
