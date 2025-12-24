# wifi_encryption.lua - WiFi 加密检测模块

## 工作原理

本模块检测路由器 WiFi 的加密方式是否安全。使用强加密是保护无线网络安全的基础。

### 加密方式安全等级

| 加密方式 | 安全等级 | 建议 |
|----------|----------|------|
| WPA3 | 最安全 | 推荐 |
| WPA2/PSK2 | 安全 | 推荐 |
| WPA/PSK | 较弱 | 不推荐 |
| WEP | 不安全 | 已被破解 |
| 无加密 | 极不安全 | 禁止 |

### 安全加密判断

以下加密方式被认为是安全的：
- `psk2` - WPA2-PSK
- `psk2+ccmp` - WPA2-PSK with AES
- `ccmp` - AES 加密

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `overview()` | - | table | 获取扫描概览信息，包含 enable_scan 字段 |
| `prepare(statusPath)` | statusPath: 状态文件路径 | - | 准备扫描环境 |
| `scan(statusPath)` | statusPath: 状态文件路径 | number | 执行扫描，返回 0(不安全) 或 1(安全) |

### 扫描结果

| 结果 | 说明 |
|------|------|
| 0 | 不安全（使用弱加密或无加密） |
| 1 | 安全（使用 WPA2/PSK2 + CCMP） |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读取 |
| `config_scan.common` | 扫描公共函数 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 信息获取 |
