# wireless.lua - 无线配置扫描父模块

## 工作原理

本模块是无线相关安全扫描的父模块，负责协调三个子扫描器的执行。通过统一的接口调用各子模块，汇总扫描结果。

### 子模块列表

| 子模块 | 权重 | 说明 |
|--------|------|------|
| wifi_passwd_security | 1 | WiFi 密码安全性检查 |
| wifi_encryption | 1 | WiFi 加密方式检查 |
| anti_squatter | 1 | 防蹭网检查 |

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `overview()` | - | table | 获取所有子模块的概览信息 |
| `prepare(status)` | status: 状态对象 | - | 准备扫描状态 |
| `scan(status)` | status: 状态对象 | mixed | 执行无线配置扫描 |

### 返回值格式

`overview()` 返回值：
```lua
{
    wifi_passwd_security = { enable_scan = 1 },
    wifi_encryption = { enable_scan = 1 },
    anti_squatter = { enable_scan = 1 }
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `config_scan.common` | 扫描公共函数 |
| `config_scan.wifi_passwd_security` | WiFi 密码安全扫描 |
| `config_scan.wifi_encryption` | WiFi 加密扫描 |
| `config_scan.anti_squatter` | 防蹭网扫描 |
