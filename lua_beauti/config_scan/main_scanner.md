# main_scanner.lua - 主配置扫描器模块

## 工作原理

本模块是配置扫描系统的主入口，负责协调所有子扫描模块。它将扫描任务分为两大类：系统配置和无线配置。

### 扫描架构

```
main_scanner
├── system (系统配置扫描)
│   ├── newest_rom      - 固件更新检查
│   ├── rom_auto_updating - 自动更新检查
│   ├── DMZ             - DMZ 配置检查
│   ├── UPnP            - UPnP 配置检查
│   └── port_mapping    - 端口映射检查
└── wireless (无线配置扫描)
    ├── wifi_encryption - WiFi 加密检查
    ├── wifi_passwd_security - WiFi 密码强度检查
    └── anti_squatter   - 防蹭网检查
```

### 评分标准

- 总分 100 分
- 40 分及以上为安全
- 低于 40 分需要关注安全配置

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `overview()` | - | table, boolean | 获取所有扫描项概览和安全状态 |
| `prepare(statusPath)` | statusPath: 状态文件路径 | - | 准备扫描环境 |
| `scan(statusPath)` | statusPath: 状态文件路径 | number | 执行完整扫描，返回总分数(0-1) |

### 返回值格式

`overview()` 返回值：
```lua
{
    -- 各子模块概览
    newest_rom = { enable_scan = 1 },
    wifi_encryption = { enable_scan = 1 },
    -- ...
    meta = { last_score = "85" }  -- 上次扫描分数
}
```

### 扫描流程

1. 创建协程执行子模块扫描
2. 实时更新扫描进度
3. 计算最终分数并保存到 UCI 配置
4. 分数乘以 100 后保存（显示为百分比）

## 外部引用

| 模块 | 用途 |
|------|------|
| `config_scan.common` | 扫描公共函数 |
| `config_scan.system` | 系统配置扫描 |
| `config_scan.wireless` | 无线配置扫描 |
| `luci.model.uci` | UCI 配置读写 |
