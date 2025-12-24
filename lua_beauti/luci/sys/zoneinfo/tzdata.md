# tzdata.lua - 时区数据模块

## 工作原理

提供世界各地时区名称与 POSIX TZ 字符串的映射表。TZ 字符串用于系统时区配置，包含标准时区缩写、UTC 偏移量和可选的夏令时规则。

### POSIX TZ 字符串格式

```
STD offset [DST [offset] [,rule]]
```

- `STD`: 标准时区缩写（如 CST、EST）
- `offset`: UTC 偏移量（正值表示西时区，负值表示东时区）
- `DST`: 夏令时缩写（可选）
- `rule`: 夏令时切换规则（可选）

### 示例

| TZ 字符串 | 说明 |
|-----------|------|
| `CST-8` | 中国标准时间 UTC+8 |
| `EST5EDT,M3.2.0,M11.1.0` | 美国东部时间，带夏令时 |
| `CET-1CEST,M3.5.0,M10.5.0/3` | 中欧时间，带夏令时 |

### 夏令时规则格式

- `M3.2.0`: 3 月第 2 个星期日
- `M11.1.0`: 11 月第 1 个星期日
- `/3`: 切换时间为凌晨 3 点

## 接口

| 属性 | 类型 | 说明 |
|------|------|------|
| `TZ` | table | 时区名称与 POSIX TZ 字符串的映射数组 |

### 数据格式

```lua
TZ = {
    { "时区名称", "POSIX TZ字符串" },
    ...
}
```

### 覆盖区域

| 区域 | 数量 | 示例 |
|------|------|------|
| Africa | 67 | Africa/Cairo, Africa/Johannesburg |
| America | 147 | America/New York, America/Los Angeles |
| Antarctica | 10 | Antarctica/McMurdo |
| Arctic | 1 | Arctic/Longyearbyen |
| Asia | 78 | Asia/Shanghai, Asia/Tokyo |
| Atlantic | 10 | Atlantic/Azores |
| Australia | 12 | Australia/Sydney |
| Europe | 56 | Europe/London, Europe/Paris |
| Indian | 11 | Indian/Maldives |
| Pacific | 38 | Pacific/Auckland, Pacific/Honolulu |
| UTC | 1 | UTC |

### 常用时区

| 时区名称 | TZ 字符串 | 说明 |
|----------|-----------|------|
| `Asia/Shanghai` | `CST-8` | 中国标准时间 |
| `Asia/Tokyo` | `JST-9` | 日本标准时间 |
| `Asia/Hong Kong` | `HKT-8` | 香港时间 |
| `America/New York` | `EST5EDT,M3.2.0,M11.1.0` | 美国东部时间 |
| `America/Los Angeles` | `PST8PDT,M3.2.0,M11.1.0` | 美国太平洋时间 |
| `Europe/London` | `GMT0BST,M3.5.0/1,M10.5.0` | 英国时间 |
| `UTC` | `UTC0` | 协调世界时 |

## 外部引用

无外部依赖
