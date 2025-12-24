# system.lua - 系统配置扫描父模块

## 工作原理

本模块是系统配置安全扫描的父模块，负责协调五个子扫描项的执行。所有子项权重相同，最终分数为各项的平均值。

### 子模块列表

| 子模块 | 权重 | 说明 |
|--------|------|------|
| newest_rom | 1 | 固件版本检查 |
| rom_auto_updating | 1 | 自动更新检查 |
| DMZ | 1 | DMZ 配置检查 |
| UPnP | 1 | UPnP 配置检查 |
| port_mapping | 1 | 端口映射检查 |

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `overview()` | - | table | 获取所有子模块的概览信息 |
| `prepare(statusPath)` | statusPath: 状态文件路径 | - | 准备扫描环境 |
| `scan(statusPath)` | statusPath: 状态文件路径 | number | 执行扫描，返回总分数(0-1) |

### 返回值格式

`overview()` 返回值：
```lua
{
    newest_rom = { enable_scan = 1 },
    rom_auto_updating = { enable_scan = 1 },
    DMZ = { enable_scan = 1 },
    UPnP = { enable_scan = 1 },
    port_mapping = { enable_scan = 1 }
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `config_scan.common` | 扫描公共函数 |
| `config_scan.newest_rom` | 固件更新扫描 |
| `config_scan.rom_auto_updating` | 自动更新扫描 |
| `config_scan.DMZ` | DMZ 配置扫描 |
| `config_scan.UPnP` | UPnP 配置扫描 |
| `config_scan.port_mapping` | 端口映射扫描 |
