# luci.sys - LuCI 系统功能模块

## 概述

`luci.sys` 模块提供 LuCI Web 管理界面所需的系统级功能，包括 IPTables 防火墙规则解析和时区信息管理。

## 目录结构

```
sys/
├── iptparser.lua          # IPTables 规则解析器
├── zoneinfo.lua           # 时区信息入口模块
└── zoneinfo/              # 时区数据子目录
    ├── tzdata.lua         # 时区名称与 TZ 字符串映射
    └── tzoffset.lua       # 时区缩写与 UTC 偏移量映射
```

## 模块说明

### iptparser.lua - IPTables 规则解析器

提供 iptables/ip6tables 规则的解析和查询功能。

#### 主要功能

- 支持 IPv4 和 IPv6 防火墙规则解析
- 解析 filter、nat、mangle、raw 四种表
- 支持按表、链、目标、协议、地址等条件过滤查询
- 获取规则的包计数、字节计数等统计信息

#### 支持的表

| IPv4 | IPv6 |
|------|------|
| filter | filter |
| nat | - |
| mangle | mangle |
| raw | raw |

#### 核心接口

| 方法 | 说明 |
|------|------|
| `IptParser.__init__(family)` | 初始化解析器，family 为 4 或 6 |
| `IptParser:find(args)` | 按条件查找规则 |
| `IptParser:resync()` | 重新解析规则 |
| `IptParser:tables()` | 获取所有表名 |
| `IptParser:chains(tableName)` | 获取表中所有链名 |
| `IptParser:chain(tableName, chainName)` | 获取链信息 |
| `IptParser:is_custom_target(target)` | 判断是否为自定义链 |

#### 查找条件

支持以下过滤条件：`table`、`chain`、`target`、`protocol`、`source`、`destination`、`inputif`、`outputif`、`flags`、`options`

#### 依赖模块

- `luci.util` - 工具函数
- `luci.sys` - 系统函数
- `luci.ip` - IP 地址处理

---

### zoneinfo.lua - 时区信息模块

提供时区信息的延迟加载功能，通过元表实现按需加载，节省内存。

#### 主要功能

- 延迟加载时区数据
- 提供时区名称与 POSIX TZ 字符串映射
- 提供时区缩写与 UTC 偏移量映射

#### 接口

| 属性 | 类型 | 说明 |
|------|------|------|
| `TZ` | table | 时区名称与 POSIX TZ 字符串的映射表 |
| `OFFSET` | table | 时区缩写与 UTC 偏移量（秒）的映射表 |

#### 依赖模块

- `luci.sys.zoneinfo.tzdata`
- `luci.sys.zoneinfo.tzoffset`

---

### zoneinfo/tzdata.lua - 时区数据

提供世界各地时区名称与 POSIX TZ 字符串的映射表。

#### POSIX TZ 字符串格式

```
STD offset [DST [offset] [,rule]]
```

- `STD`: 标准时区缩写（如 CST、EST）
- `offset`: UTC 偏移量（正值表示西时区，负值表示东时区）
- `DST`: 夏令时缩写（可选）
- `rule`: 夏令时切换规则（可选）

#### 覆盖区域

| 区域 | 数量 | 示例 |
|------|------|------|
| Africa | 67 | Africa/Cairo, Africa/Johannesburg |
| America | 147 | America/New York, America/Los Angeles |
| Antarctica | 10 | Antarctica/McMurdo |
| Asia | 78 | Asia/Shanghai, Asia/Tokyo |
| Australia | 12 | Australia/Sydney |
| Europe | 56 | Europe/London, Europe/Paris |
| Pacific | 38 | Pacific/Auckland, Pacific/Honolulu |
| 其他 | 23 | Arctic, Atlantic, Indian, UTC |

#### 常用时区示例

| 时区名称 | TZ 字符串 | 说明 |
|----------|-----------|------|
| `Asia/Shanghai` | `CST-8` | 中国标准时间 |
| `Asia/Tokyo` | `JST-9` | 日本标准时间 |
| `America/New York` | `EST5EDT,M3.2.0,M11.1.0` | 美国东部时间（带夏令时） |
| `Europe/London` | `GMT0BST,M3.5.0/1,M10.5.0` | 英国时间（带夏令时） |
| `UTC` | `UTC0` | 协调世界时 |

---

### zoneinfo/tzoffset.lua - 时区偏移量数据

提供各时区缩写与 UTC 偏移量（秒）的映射表。

#### 偏移量计算

- 1 小时 = 3600 秒
- 正值表示东时区（UTC+），负值表示西时区（UTC-）

#### 常用时区偏移量

| 缩写 | 偏移量（秒） | UTC 偏移 | 说明 |
|------|-------------|----------|------|
| `gmt` | 0 | UTC+0 | 格林威治标准时间 |
| `cst` | -21600 | UTC-6 | 美国中部标准时间 |
| `est` | -18000 | UTC-5 | 美国东部标准时间 |
| `pst` | -28800 | UTC-8 | 美国太平洋标准时间 |
| `jst` | 32400 | UTC+9 | 日本标准时间 |
| `hkt` | 28800 | UTC+8 | 香港时间 |
| `nzst` | 43200 | UTC+12 | 新西兰标准时间 |

## 使用示例

### IPTables 规则查询

```lua
local IptParser = require "luci.sys.iptparser".IptParser

-- 创建 IPv4 解析器
local ipt = IptParser(4)

-- 查找所有 DROP 规则
local rules = ipt:find({ target = "DROP" })

-- 查找 filter 表 INPUT 链的规则
local input_rules = ipt:find({ table = "filter", chain = "INPUT" })

-- 获取所有表名
local tables = ipt:tables()

-- 获取 filter 表的所有链
local chains = ipt:chains("filter")
```

### 时区信息查询

```lua
local zoneinfo = require "luci.sys.zoneinfo"

-- 获取时区列表
for _, tz in ipairs(zoneinfo.TZ) do
    local name = tz[1]      -- 时区名称，如 "Asia/Shanghai"
    local tzstr = tz[2]     -- TZ 字符串，如 "CST-8"
end

-- 获取时区偏移量
local offset = zoneinfo.OFFSET["jst"]  -- 返回 32400 (UTC+9)
```

## 模块依赖关系

```
luci.sys.iptparser
    ├── luci.util
    ├── luci.sys
    └── luci.ip

luci.sys.zoneinfo
    ├── luci.sys.zoneinfo.tzdata
    └── luci.sys.zoneinfo.tzoffset
```
