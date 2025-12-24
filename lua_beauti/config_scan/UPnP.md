# UPnP.lua - UPnP 配置检测模块

## 工作原理

本模块检测路由器的 UPnP（通用即插即用）配置安全性。UPnP 允许应用程序自动配置端口转发，可能被恶意软件利用。

### 安全风险

- 恶意软件可能利用 UPnP 自动打开端口
- 可能导致内网服务意外暴露到公网
- 难以追踪哪些应用程序打开了端口

### 安全建议

- 如非必要，建议关闭 UPnP 功能
- 如需使用，定期检查 UPnP 映射列表
- 使用手动端口转发替代 UPnP

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
| 0 | 不安全（UPnP 已启用） |
| 1 | 安全（UPnP 已关闭） |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.model.uci` | UCI 配置读取 |
| `config_scan.common` | 扫描公共函数 |
| `xiaoqiang.util.XQUPnPUtil` | UPnP 工具，获取状态 |
