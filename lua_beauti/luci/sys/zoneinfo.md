# zoneinfo.lua - 时区信息模块

## 工作原理

提供时区信息的延迟加载功能，通过元表 `__index` 实现按需加载。当访问 `TZ` 或 `OFFSET` 属性时，才从对应的子模块加载数据，节省内存。

### 延迟加载机制

1. 首次访问 `TZ` 时，从 `luci.sys.zoneinfo.tzdata` 加载时区数据
2. 首次访问 `OFFSET` 时，从 `luci.sys.zoneinfo.tzoffset` 加载偏移量数据
3. 数据加载后缓存在模块中，后续访问直接返回

## 接口

| 属性 | 类型 | 说明 |
|------|------|------|
| `TZ` | table | 时区名称与 POSIX 时区字符串的映射表 |
| `OFFSET` | table | 时区缩写与 UTC 偏移量（秒）的映射表 |

### TZ 数据格式

```lua
{
    { "Asia/Shanghai", "CST-8" },
    { "America/New York", "EST5EDT,M3.2.0,M11.1.0" },
    ...
}
```

### OFFSET 数据格式

```lua
{
    gmt = 0,
    cst = -21600,
    jst = 32400,
    ...
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.sys.zoneinfo.tzdata` | 时区名称与 TZ 字符串映射 |
| `luci.sys.zoneinfo.tzoffset` | 时区缩写与 UTC 偏移量映射 |
