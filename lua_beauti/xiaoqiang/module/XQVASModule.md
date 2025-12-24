# XQVASModule.lua - 增值服务模块

## 概述

`XQVASModule` 模块管理路由器的增值服务（VAS, Value-Added Services）功能，包括安全防护、广告过滤、游戏加速、VPN 服务等。该模块提供统一的服务状态查询和配置接口，整合了多种增值功能的管理。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                      增值服务架构                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   XQVASModule                         │  │
│  └──────────────────────────────────────────────────────┘  │
│         │              │              │              │      │
│         ▼              ▼              ▼              ▼      │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌─────────┐  │
│  │ 安全防护 │   │ 广告过滤 │   │ 游戏加速 │   │  VPN    │  │
│  │ Security │   │ AdFilter │   │GameAccel │   │ Service │  │
│  └──────────┘   └──────────┘   └──────────┘   └─────────┘  │
│         │              │              │              │      │
│         ▼              ▼              ▼              ▼      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    存储层                             │  │
│  │  • XQPreference (KV存储)                             │  │
│  │  • UCI配置 (/etc/config/vas)                         │  │
│  │  • 系统服务 (/etc/init.d/*)                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### KV 信息整合

#### get_vas_kv_info()

获取 VAS 相关的 KV 存储信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| security_enabled | number | 安全防护启用状态 |
| ad_filter_enabled | number | 广告过滤启用状态 |
| game_accel_enabled | number | 游戏加速启用状态 |
| vpn_enabled | number | VPN 服务启用状态 |

---

### 服务列表管理

#### getVASList()

获取所有增值服务列表。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| [].id | string | 服务 ID |
| [].name | string | 服务名称 |
| [].enabled | string | 启用状态 ("0"/"1") |
| [].status | string | 运行状态 |
| [].expire_time | string | 过期时间 |

---

#### setVASStatus(serviceId, enabled)

设置增值服务状态。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| serviceId | string | 服务 ID |
| enabled | number | 启用状态 (0/1) |

**返回值:** 0=成功, 1=参数错误, 2=服务不存在

---

### 安全防护

#### getSecurityInfo()

获取安全防护信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| enabled | number | 启用状态 |
| malware_block | number | 恶意网站拦截 |
| phishing_block | number | 钓鱼网站拦截 |
| intrusion_detect | number | 入侵检测 |
| last_update | string | 最后更新时间 |

---

#### setSecurityConfig(enabled, malwareBlock, phishingBlock, intrusionDetect)

设置安全防护配置。

**返回值:** 0=成功

---

### 广告过滤

#### getAdFilterInfo()

获取广告过滤信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| enabled | number | 启用状态 |
| rule_count | number | 过滤规则数量 |
| blocked_today | number | 今日拦截数量 |

---

#### setAdFilterEnabled(enabled)

设置广告过滤状态。

**返回值:** 0=成功

---

### 游戏加速

#### getGameAccelInfo()

获取游戏加速信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| enabled | number | 启用状态 |
| mode | string | 加速模式 ("auto"/"manual") |
| accel_devices | number | 当前加速的设备数 |

---

#### setGameAccelConfig(enabled, mode)

设置游戏加速配置。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| enabled | number | 启用状态 |
| mode | string | 加速模式 (可选) |

**返回值:** 0=成功

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.XQPreference | KV 存储模块 |
| luci.model.uci | UCI 配置管理 |
| /etc/init.d/adfilter | 广告过滤服务 |
| /etc/init.d/gameaccel | 游戏加速服务 |

## 被引用情况

- 安全模块 (`XQSecurity`)
- 增值服务 API 控制器
- 系统设置页面
- 移动端 APP 增值服务管理

## 关键代码说明

### KV 存储键名

```lua
-- 安全防护
SECURITY_ENABLED
MALWARE_BLOCK_ENABLED
PHISHING_BLOCK_ENABLED
INTRUSION_DETECT_ENABLED
SECURITY_LAST_UPDATE

-- 广告过滤
AD_FILTER_ENABLED
AD_FILTER_RULE_COUNT
AD_BLOCKED_TODAY

-- 游戏加速
GAME_ACCEL_ENABLED
GAME_ACCEL_MODE
GAME_ACCEL_DEVICES

-- VPN
VPN_ENABLED
```

### 服务启停控制

```lua
if enabled == 1 then
    XQFunction.forkExec("/etc/init.d/adfilter start")
else
    XQFunction.forkExec("/etc/init.d/adfilter stop")
end
```

设置服务状态时会自动启动或停止对应的系统服务，确保配置与实际运行状态一致。

### UCI 配置遍历

```lua
cursor:foreach("vas", "service", function(section)
    local service = {}
    service.id = section[".name"]
    service.name = section.name or ""
    -- ...
    table.insert(result, service)
end)
```

通过遍历 UCI 配置的 `vas.service` section 获取所有已配置的增值服务列表。
