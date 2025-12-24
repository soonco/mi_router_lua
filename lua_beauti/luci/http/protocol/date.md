# date.lua - HTTP 日期处理模块

## 工作原理

处理 HTTP 协议中的日期格式转换和比较。支持 HTTP 日期格式（RFC 1123）与 Unix 时间戳的互转，以及时区偏移计算。

### HTTP 日期格式

```
Day, DD Mon YYYY HH:MM:SS TZ
```

示例：`Mon, 01 Jan 2024 12:00:00 GMT`

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `tz_offset(timezone)` | 时区字符串 | 偏移秒数 | 计算时区偏移量 |
| `to_unix(http_date)` | HTTP 日期字符串 | Unix 时间戳 | HTTP 日期转 Unix 时间戳 |
| `to_http(timestamp)` | Unix 时间戳 | HTTP 日期字符串 | Unix 时间戳转 HTTP 日期 |
| `compare(date1, date2)` | 两个日期 | -1/0/1 | 比较两个日期 |

### 时区偏移格式

| 格式 | 示例 | 说明 |
|------|------|------|
| 数字格式 | `+0800`, `-0500` | 直接指定偏移 |
| 时区名称 | `gmt`, `pst`, `jst` | 从时区表查找 |

### 月份常量

```lua
MONTHS = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
}
```

### 日期比较返回值

| 返回值 | 说明 |
|--------|------|
| -1 | date1 < date2 |
| 0 | date1 == date2 |
| 1 | date1 > date2 |

### 使用示例

```lua
-- HTTP 日期转 Unix 时间戳
local timestamp = date.to_unix("Mon, 01 Jan 2024 12:00:00 GMT")

-- Unix 时间戳转 HTTP 日期
local http_date = date.to_http(os.time())

-- 计算时区偏移
local offset = date.tz_offset("+0800")  -- 28800 秒

-- 比较日期
local result = date.compare(date1, date2)
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.sys.zoneinfo` | 时区偏移量数据 |
