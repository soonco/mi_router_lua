# anti_squatter.lua - 防蹭网检测模块

## 工作原理

本模块检测路由器的防蹭网功能是否启用。防蹭网功能可以防止未授权设备连接到您的 WiFi 网络。

### 功能特点

- 检测陌生设备连接
- 自动阻止可疑设备
- 提供设备白名单管理

### 安全建议

- 建议启用防蹭网功能
- 定期检查已连接设备列表
- 及时将可信设备加入白名单

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `overview()` | - | table | 获取扫描概览信息，包含 enable_scan 字段 |
| `prepare(statusPath)` | statusPath: 状态文件路径 | - | 准备扫描环境 |
| `scan(statusPath)` | statusPath: 状态文件路径 | number | 执行扫描，返回防蹭网功能的开启状态 |

### 扫描结果

返回 `antiRubStatus.open` 字段的值，表示防蹭网功能是否开启。

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读取 |
| `config_scan.common` | 扫描公共函数 |
| `luci.controller.api.misystem` | 系统 API，获取防蹭网状态 |
