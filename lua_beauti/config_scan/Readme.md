# Config Scan - 路由器配置安全扫描系统

## 概述

Config Scan 是一个路由器配置安全扫描系统，用于检测路由器各项配置的安全性。系统采用模块化设计，将扫描任务分为系统配置和无线配置两大类，通过评分机制量化安全状态。

## 特性

- **模块化架构**：各扫描项独立实现，易于扩展
- **分层设计**：主扫描器 → 分类扫描器 → 具体检测项
- **协程并发**：使用 Lua 协程实现并发扫描
- **量化评分**：0-100 分评分系统，直观展示安全状态
- **实时进度**：扫描过程中实时更新状态

## 模块结构

```
config_scan/
├── main_scanner.lua       # 主扫描器入口
├── common.lua             # 公共函数库
├── system.lua             # 系统配置扫描（父模块）
│   ├── newest_rom.lua         # 固件更新检测
│   ├── rom_auto_updating.lua  # 自动更新检测
│   ├── DMZ.lua                # DMZ 配置检测
│   ├── UPnP.lua               # UPnP 配置检测
│   └── port_mapping.lua       # 端口映射检测
├── wireless.lua           # 无线配置扫描（父模块）
│   ├── wifi_encryption.lua    # WiFi 加密检测
│   ├── wifi_passwd_security.lua # WiFi 密码强度检测
│   └── anti_squatter.lua      # 防蹭网检测
└── Readme.md              # 本文档
```

## 扫描架构图

```
┌─────────────────────────────────────────────────────────────┐
│                      main_scanner                           │
│                      (主扫描入口)                            │
├─────────────────────────────┬───────────────────────────────┤
│         system              │           wireless            │
│       (系统配置)             │          (无线配置)            │
├─────────────────────────────┼───────────────────────────────┤
│  ┌─────────────────────┐    │    ┌─────────────────────┐    │
│  │ newest_rom          │    │    │ wifi_encryption     │    │
│  │ (固件更新)           │    │    │ (WiFi加密)          │    │
│  ├─────────────────────┤    │    ├─────────────────────┤    │
│  │ rom_auto_updating   │    │    │ wifi_passwd_security│    │
│  │ (自动更新)           │    │    │ (密码强度)          │    │
│  ├─────────────────────┤    │    ├─────────────────────┤    │
│  │ DMZ                 │    │    │ anti_squatter       │    │
│  │ (DMZ配置)           │    │    │ (防蹭网)            │    │
│  ├─────────────────────┤    │    └─────────────────────┘    │
│  │ UPnP                │    │                               │
│  │ (UPnP配置)          │    │                               │
│  ├─────────────────────┤    │                               │
│  │ port_mapping        │    │                               │
│  │ (端口映射)           │    │                               │
│  └─────────────────────┘    │                               │
└─────────────────────────────┴───────────────────────────────┘
```

## 模块详解

### 1. main_scanner.lua - 主扫描器

主入口模块，负责协调所有子扫描模块的执行。

**主要接口：**

| 函数 | 说明 |
|------|------|
| `overview()` | 获取所有扫描项概览和安全状态 |
| `prepare(statusPath)` | 准备扫描环境 |
| `scan(statusPath)` | 执行完整扫描，返回总分数 |

**评分标准：**
- 总分 100 分
- 40 分及以上为安全
- 低于 40 分需要关注安全配置

---

### 2. common.lua - 公共函数库

提供扫描系统的公共函数和常量。

**工作状态常量：**

| 常量 | 值 | 说明 |
|------|-----|------|
| `WORK_STATUS_WAIT` | 0 | 等待扫描 |
| `WORK_STATUS_RUNNING` | 1 | 正在扫描 |
| `WORK_STATUS_DONE` | 2 | 扫描完成 |

**主要接口：**

| 函数 | 说明 |
|------|------|
| `prepare_status(statusPath, submods)` | 准备扫描状态目录结构 |
| `scan_submod(statusPath, submods)` | 扫描所有子模块，返回加权平均分数 |
| `scan_leaf(statusPath, scanFunc)` | 执行叶子节点扫描 |

---

### 3. system.lua - 系统配置扫描

系统配置安全扫描的父模块，协调五个子扫描项。

**子模块列表：**

| 子模块 | 权重 | 说明 |
|--------|------|------|
| newest_rom | 1 | 固件版本检查 |
| rom_auto_updating | 1 | 自动更新检查 |
| DMZ | 1 | DMZ 配置检查 |
| UPnP | 1 | UPnP 配置检查 |
| port_mapping | 1 | 端口映射检查 |

---

### 4. wireless.lua - 无线配置扫描

无线配置安全扫描的父模块，协调三个子扫描项。

**子模块列表：**

| 子模块 | 权重 | 说明 |
|--------|------|------|
| wifi_passwd_security | 1 | WiFi 密码安全性检查 |
| wifi_encryption | 1 | WiFi 加密方式检查 |
| anti_squatter | 1 | 防蹭网检查 |

---

## 具体检测项说明

### 系统配置检测项

#### newest_rom.lua - 固件更新检测

检测路由器是否运行最新版本的固件。

| 结果 | 说明 |
|------|------|
| 0 | 需要更新（有新固件可用） |
| 1 | 已是最新（无需更新） |

**安全重要性：**
- 新固件通常包含安全漏洞修复
- 过时的固件可能存在已知漏洞

---

#### rom_auto_updating.lua - 自动更新检测

检测固件自动更新功能是否启用。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（自动更新未启用） |
| 1 | 安全（自动更新已启用） |

**安全建议：** 建议启用自动更新功能，减少安全漏洞暴露时间。

---

#### DMZ.lua - DMZ 配置检测

检测 DMZ（非军事区）配置安全性。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（DMZ 已启用） |
| 1 | 安全（DMZ 未启用） |

**安全风险：**
- DMZ 主机的所有端口都暴露到公网
- 可能被攻击者扫描和利用
- 绕过防火墙保护

---

#### UPnP.lua - UPnP 配置检测

检测 UPnP（通用即插即用）配置安全性。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（UPnP 已启用） |
| 1 | 安全（UPnP 已关闭） |

**安全风险：**
- 恶意软件可能利用 UPnP 自动打开端口
- 可能导致内网服务意外暴露到公网

---

#### port_mapping.lua - 端口映射检测

检测端口映射（端口转发）配置。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（存在端口映射规则） |
| 1 | 安全（无端口映射规则） |

**安全建议：**
- 仅在必要时启用端口映射
- 定期审查端口映射规则

---

### 无线配置检测项

#### wifi_encryption.lua - WiFi 加密检测

检测 WiFi 的加密方式是否安全。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（使用弱加密或无加密） |
| 1 | 安全（使用 WPA2/PSK2 + CCMP） |

**加密方式安全等级：**

| 加密方式 | 安全等级 | 建议 |
|----------|----------|------|
| WPA3 | 最安全 | 推荐 |
| WPA2/PSK2 | 安全 | 推荐 |
| WPA/PSK | 较弱 | 不推荐 |
| WEP | 不安全 | 已被破解 |
| 无加密 | 极不安全 | 禁止 |

---

#### wifi_passwd_security.lua - WiFi 密码强度检测

检测 WiFi 密码的安全强度。

| 结果 | 说明 |
|------|------|
| 0 | 不安全（密码强度不足） |
| 1 | 安全（密码强度足够） |

**强密码标准：**
1. 长度至少 8 个字符
2. 包含以下至少 2 种字符类型：
   - 数字 (0-9)
   - 小写字母 (a-z)
   - 大写字母 (A-Z)
   - 特殊字符

---

#### anti_squatter.lua - 防蹭网检测

检测防蹭网功能是否启用。

**功能特点：**
- 检测陌生设备连接
- 自动阻止可疑设备
- 提供设备白名单管理

**安全建议：** 建议启用防蹭网功能，定期检查已连接设备列表。

---

## 使用示例

### 执行完整扫描

```lua
local main_scanner = require("config_scan.main_scanner")

-- 准备扫描环境
main_scanner.prepare("/tmp/config_scan_status")

-- 执行扫描
local score = main_scanner.scan("/tmp/config_scan_status")

-- score 为 0-1 之间的数值，乘以 100 即为百分制分数
print("安全评分: " .. (score * 100) .. " 分")
```

### 获取扫描概览

```lua
local main_scanner = require("config_scan.main_scanner")

local overview, is_safe = main_scanner.overview()

-- overview 包含各子模块的概览信息
-- is_safe 表示整体是否安全（分数 >= 40）
```

## 状态目录结构

```
statusPath/
├── meta/
│   ├── status      - 扫描状态 (0/1/2)
│   ├── score       - 扫描分数
│   ├── display     - 显示标记
│   └── enable_scan - 启用扫描标记
├── system/
│   ├── meta/
│   ├── newest_rom/
│   ├── rom_auto_updating/
│   ├── DMZ/
│   ├── UPnP/
│   └── port_mapping/
└── wireless/
    ├── meta/
    ├── wifi_encryption/
    ├── wifi_passwd_security/
    └── anti_squatter/
```

## 依赖模块

| 模块 | 说明 |
|------|------|
| `luci.model.uci` | UCI 配置读写 |
| `posix` | POSIX 接口 |
| `nixio` | 文件系统操作 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `xiaoqiang.util.XQUPnPUtil` | UPnP 工具 |
| `xiaoqiang.util.XQNetUtil` | 网络工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.module.XQPredownload` | 预下载模块 |
| `luci.controller.api.misystem` | 系统 API |

## 安全建议总结

| 检测项 | 安全配置建议 |
|--------|-------------|
| 固件版本 | 保持固件为最新版本 |
| 自动更新 | 启用自动更新功能 |
| DMZ | 除非必要，不要启用 DMZ |
| UPnP | 如非必要，建议关闭 |
| 端口映射 | 仅在必要时启用，定期审查 |
| WiFi 加密 | 使用 WPA2/WPA3 加密 |
| WiFi 密码 | 使用强密码（8位以上，混合字符） |
| 防蹭网 | 建议启用，定期检查设备列表 |

## 许可证

请参考项目根目录的许可证文件。
