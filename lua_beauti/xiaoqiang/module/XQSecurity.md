# XQSecurity.lua - 安全模块

## 概述

`XQSecurity` 模块管理路由器的安全功能开关，包括隐私保护、病毒文件防火墙、恶意 URL 防护、WiFi 接入认证等安全特性。该模块整合了多个安全相关的配置源，提供统一的安全状态查询和设置接口。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                      安全功能架构                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                  security_status()                   │   │
│  │                    状态聚合层                         │   │
│  └─────────────────────────────────────────────────────┘   │
│         │              │              │              │      │
│         ▼              ▼              ▼              ▼      │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌─────────┐  │
│  │ security │   │vas_user  │   │   VAS    │   │  Push   │  │
│  │  config  │   │ config   │   │ Module   │   │Settings │  │
│  └──────────┘   └──────────┘   └──────────┘   └─────────┘  │
│       │              │              │              │        │
│       ▼              ▼              ▼              ▼        │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    安全功能项                         │  │
│  │  • privacy_protection: 隐私保护                      │  │
│  │  • virus_file_firewall: 病毒文件防火墙               │  │
│  │  • malicious_url_firewall: 恶意URL防火墙             │  │
│  │  • app_security_v2: 应用安全V2                       │  │
│  │  • wifi_arn: WiFi接入认证                            │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### security_status()

获取所有安全功能的状态。

**参数:** 无

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| wifi_arn | number | WiFi 接入认证 (0=关闭, 1=开启) |
| privacy_protection | number | 隐私保护 (0=关闭, 1=开启) |
| virus_file_firewall | number | 病毒文件防火墙 (0=关闭, 1=开启) |
| malicious_url_firewall | number | 恶意 URL 防火墙 (0=关闭, 1=开启) |
| app_security_v2 | number | 应用安全 V2（如果支持） |
| open | number | 总开关状态 (0=有功能关闭, 1=全部开启) |
| count | number | 已开启的功能数量 |

---

### security_switch(settings)

设置安全功能开关。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| settings | table | 要设置的安全功能键值对 |

**settings 可用字段:**
| 字段 | 类型 | 说明 |
|------|------|------|
| privacy_protection | number | 隐私保护 (0/1) |
| virus_file_firewall | number | 病毒文件防火墙 (0/1) |
| malicious_url_firewall | number | 恶意 URL 防火墙 (0/1) |
| app_security_v2 | number | 应用安全 V2 (0/1) |

**返回值:** 无

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.module.XQVASModule | 增值服务模块 |
| xiaoqiang.util.XQPushUtil | 推送设置工具 |
| luci.model.uci | UCI 配置管理 |
| /etc/init.d/securitypage | 安全页面服务 |

## 被引用情况

- 安全中心 API 控制器
- 系统设置页面的安全配置
- 移动端 APP 安全功能管理

## 关键代码说明

### 配置同步机制

```lua
if userSecurityPage ~= currentSecurityPage and vasSecurityPage ~= -6 then
    uci:set("security", "common", "security_page", userSecurityPage)
    uci:commit("security")
    XQFunction.forkExec("touch /etc/config/securitypage/enable.tag;/etc/init.d/securitypage restart")
end
```

模块在获取状态时会自动同步用户配置与当前配置，确保配置一致性。`-6` 表示 VAS 服务禁用状态。

### 多配置源整合

安全状态来自多个配置源：
- `security` 配置：隐私保护、病毒防火墙
- `vas_user` 配置：恶意 URL 防火墙
- `XQVASModule`：应用安全 V2
- `XQPushUtil`：WiFi 接入认证

### 总开关计算逻辑

```lua
for _, value in pairs(status) do
    if value == 0 then
        allEnabled = 0
        break
    end
    enabledCount = enabledCount + 1
end
```

`open` 字段表示所有安全功能是否全部开启，任一功能关闭则为 0。
