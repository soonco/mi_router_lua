# iptparser.lua - IPTables 规则解析器模块

## 工作原理

提供 iptables/ip6tables 规则的解析和查询功能。通过执行 `iptables -t <table> --line-numbers -nxvL` 命令获取规则列表，解析输出并构建规则数据结构，支持按多种条件过滤查询。

### 解析流程

1. 遍历所有表（filter、nat、mangle、raw）
2. 执行 iptables 命令获取规则输出
3. 解析链信息（策略、包计数、字节计数、引用数）
4. 解析规则行（索引、目标、协议、接口、地址等）
5. 构建规则和链的数据结构

### 支持的表

| IPv4 | IPv6 |
|------|------|
| filter | filter |
| nat | - |
| mangle | mangle |
| raw | raw |

## 接口

### 类方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `IptParser.__init__(family)` | family: 4 或 6 | 无 | 初始化解析器 |
| `IptParser:find(args)` | args: 过滤条件表 | rules[] | 按条件查找规则 |
| `IptParser:resync()` | 无 | 无 | 重新解析规则 |
| `IptParser:tables()` | 无 | tables[] | 获取所有表名 |
| `IptParser:chains(tableName)` | tableName: 表名 | chains[] | 获取表中所有链名 |
| `IptParser:chain(tableName, chainName)` | 表名, 链名 | chain | 获取链信息 |
| `IptParser:is_custom_target(target)` | target: 目标名 | boolean | 判断是否为自定义链 |

### 查找条件 (args)

| 字段 | 类型 | 说明 |
|------|------|------|
| `table` | string | 表名（filter/nat/mangle/raw） |
| `chain` | string | 链名（INPUT/OUTPUT/FORWARD 等） |
| `target` | string | 目标（ACCEPT/DROP/REJECT 等） |
| `protocol` | string | 协议（tcp/udp/icmp 等） |
| `source` | string | 源地址（支持 CIDR） |
| `destination` | string | 目的地址（支持 CIDR） |
| `inputif` | string | 入接口 |
| `outputif` | string | 出接口 |
| `flags` | string | 标志 |
| `options` | table | 附加选项数组 |

### 规则数据结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `table` | string | 所属表 |
| `chain` | string | 所属链 |
| `index` | number | 规则索引 |
| `packets` | number | 匹配包数 |
| `bytes` | number | 匹配字节数 |
| `target` | string | 目标动作 |
| `protocol` | string | 协议 |
| `flags` | string | 标志 |
| `inputif` | string | 入接口 |
| `outputif` | string | 出接口 |
| `source` | string | 源地址 |
| `destination` | string | 目的地址 |
| `options` | table | 附加选项 |

### 链数据结构

| 字段 | 类型 | 说明 |
|------|------|------|
| `policy` | string | 默认策略（ACCEPT/DROP） |
| `packets` | number | 处理包数 |
| `bytes` | number | 处理字节数 |
| `references` | number | 引用计数（自定义链） |
| `rules` | table | 规则数组 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.util` | 工具函数（class、split、execi） |
| `luci.sys` | 系统函数 |
| `luci.ip` | IP 地址处理（IPv4/IPv6 解析和比较） |
