# XQDBUtil.lua - 数据库工具模块

## 概述

`XQDBUtil` 模块提供设备信息的数据库存储和查询功能，支持 SQLite 数据库和 UCI 配置文件两种存储方式。当 SQLite 不可用时自动降级为 UCI 配置存储。该模块还提供 VIP 设备推送功能的数据管理。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    数据存储架构                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   XQDBUtil 接口层                     │  │
│  │  saveDeviceInfo / fetchDeviceInfo / updateNickname   │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                 │
│            ┌──────────────┴──────────────┐                  │
│            ▼                             ▼                  │
│     ┌──────────────┐              ┌──────────────┐         │
│     │   SQLite     │              │     UCI      │         │
│     │  /etc/xqDb   │              │  devicelist  │         │
│     └──────────────┘              └──────────────┘         │
│            │                             │                  │
│            ▼                             ▼                  │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    DEVICE_INFO 表                     │  │
│  │  MAC | ONAME | NICKNAME | COMPANY | OWNERID          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  DEVICE_PUSH_INFO 表                  │  │
│  │  MAC | STATUS | TIME | ACTION | PUSHTIME | NAME      │  │
│  │  用于 VIP 设备推送功能                                │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 设备信息管理

#### saveDeviceInfo(mac, oname, nickname, company, ownerId)

保存设备信息（自动选择存储方式）。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| mac | string | 设备 MAC 地址 |
| oname | string | 设备原始名称 |
| nickname | string | 设备昵称 |
| company | string | 设备厂商 |
| ownerId | string | 设备所有者 ID |

---

#### fetchDeviceInfo(mac)

获取设备信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| mac | string | MAC 地址 |
| oName | string | 原始名称 |
| nickname | string | 昵称 |
| company | string | 厂商 |
| ownnerId | string | 所有者 ID |

---

#### fetchAllDeviceInfo()

获取所有设备信息列表。

---

#### updateDeviceNickname(mac, nickname)

更新设备昵称。

---

### SQLite 操作

#### sql_exec(sql, db)

执行 SQL 命令（带重试机制）。

**说明:** 失败时自动重试最多 3 次，每次间隔 100ms。

---

#### table_is_exist(tableName, db)

检查表是否存在。

---

#### table_dump(tableName, db)

打印表内容（调试用）。

---

### VIP 设备推送

#### vip_device_pre_push(mac, name, action)

VIP 设备预推送。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| mac | string | 设备 MAC 地址 |
| name | string | 设备名称（可选） |
| action | string | 动作类型 |

---

#### set_pending_status(mac, action, db)

设置设备待推送状态。

---

#### call_push_action_up()

唤起推送处理进程 `vip_device_push_act.lua`。

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| lsqlite3 | SQLite 数据库库（可选） |
| luci.model.uci | UCI 配置管理 |
| luci.cbi.datatypes | 数据类型验证 |
| xiaoqiang.XQLog | 日志模块 |
| socket | 延时功能 |
| /etc/xqDb | SQLite 数据库文件 |
| vip_device_push_act.lua | 推送处理脚本 |

## 被引用情况

- 设备工具模块 (`XQDeviceUtil`)
- 设备管理 API
- VIP 设备推送功能

## 关键代码说明

### 存储方式自动选择

```lua
local sqliteLoaded, SQLite = pcall(require, "lsqlite3")

function saveDeviceInfo(mac, oname, nickname, company, ownerId)
    if not sqliteLoaded then
        return conf_saveDeviceInfo(mac, oname, nickname, company)
    end
    -- SQLite 存储逻辑
end
```

使用 `pcall` 安全加载 SQLite 库，不可用时自动降级为 UCI 配置存储。

### SQL 重试机制

```lua
local retryCount = 0
repeat
    socket.select(nil, nil, 0.1)  -- 等待 100ms
    execResult = conn:exec(sql)
    retryCount = retryCount + 1
until execResult == SQLite.OK or retryCount >= 3
```

数据库操作失败时自动重试，提高可靠性。

### UCI 配置节命名

```lua
local sectionName = mac:gsub(":", "") .. "_INFO"
-- 例如: "AABBCCDDEEFF_INFO"
```

使用去掉冒号的 MAC 地址加 `_INFO` 后缀作为 UCI 配置节名称。

### 日志级别常量

```lua
DEBUG = 7
INFO = 6
NOTICE = 5
WARN = 4
ERROR = 3
CRIT = 2
```
