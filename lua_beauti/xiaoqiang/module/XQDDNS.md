# XQDDNS.lua - 动态域名服务模块

## 概述

`XQDDNS.lua` 是小米路由器的DDNS（动态域名服务）管理模块，负责配置和管理动态域名解析服务。该模块支持多种DDNS服务提供商，包括DynDNS、No-IP、花生壳、DNSPod、Cloudflare等。

**文件位置**: `xiaoqiang/module/XQDDNS.lua`  
**模块名**: `xiaoqiang.module.XQDDNS`  
**代码行数**: ~186行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    DDNS工作流程                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           用户配置DDNS                   │               │
│  │  - 选择服务提供商                        │               │
│  │  - 输入域名、用户名、密码                │               │
│  └─────────────────────────────────────────┘               │
│                      │                                      │
│                      ▼                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           保存UCI配置                    │               │
│  │  /etc/config/ddns                       │               │
│  │  section: myddns                        │               │
│  └─────────────────────────────────────────┘               │
│                      │                                      │
│                      ▼                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           DDNS服务守护进程               │               │
│  │  - 定期检查公网IP变化                    │               │
│  │  - 检测到变化时更新DNS记录               │               │
│  │  - 定期强制更新                          │               │
│  └─────────────────────────────────────────┘               │
│                      │                                      │
│                      ▼                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           状态文件                       │               │
│  │  /var/run/ddns/myddns.dat               │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 配置管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getDDNSInfo()` | 无 | table | 获取DDNS配置信息 |
| `setDDNS(enabled, service, domain, username, password)` | 多参数 | number | 设置DDNS配置 |
| `getDDNSProviders()` | 无 | table | 获取支持的DDNS服务提供商列表 |

### 状态查询函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `checkDDNSStatus()` | 无 | table | 检查DDNS运行状态 |
| `forceUpdateDDNS()` | 无 | number | 强制更新DDNS |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（forkExec等） |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `luci.model.uci` | UCI配置管理 |
| `luci.util` | 工具函数 |

## 被引用情况

该模块被以下模块引用：
- `luci.controller.api.xqsystem` - 系统API DDNS接口
- `luci.controller.api.xqnetwork` - 网络API DDNS接口

## 关键代码说明

### 1. 获取DDNS配置

```lua
function getDDNSInfo()
    local result = {}
    
    result.enabled = tonumber(cursor:get("ddns", "myddns", "enabled") or "0")
    result.service = cursor:get("ddns", "myddns", "service_name") or ""
    result.domain = cursor:get("ddns", "myddns", "domain") or ""
    result.username = cursor:get("ddns", "myddns", "username") or ""
    result.password = ""  -- 出于安全考虑，不返回密码
    result.ip_source = cursor:get("ddns", "myddns", "ip_source") or "network"
    result.check_interval = tonumber(cursor:get("ddns", "myddns", "check_interval") or "10")
    result.check_unit = cursor:get("ddns", "myddns", "check_unit") or "minutes"
    result.force_interval = tonumber(cursor:get("ddns", "myddns", "force_interval") or "72")
    result.force_unit = cursor:get("ddns", "myddns", "force_unit") or "hours"
    
    return result
end
```

### 2. 设置DDNS配置

```lua
function setDDNS(enabled, service, domain, username, password)
    -- 参数校验
    if enabled == 1 then
        if XQFunction.isStrNil(service) or
           XQFunction.isStrNil(domain) or
           XQFunction.isStrNil(username) or
           XQFunction.isStrNil(password) then
            return 1  -- 参数不完整
        end
    end
    
    -- 设置配置
    cursor:set("ddns", "myddns", "enabled", tostring(enabled))
    
    if enabled == 1 then
        cursor:set("ddns", "myddns", "service_name", service)
        cursor:set("ddns", "myddns", "domain", domain)
        cursor:set("ddns", "myddns", "username", username)
        cursor:set("ddns", "myddns", "password", password)
        cursor:set("ddns", "myddns", "ip_source", "network")
        cursor:set("ddns", "myddns", "ip_network", "wan")
        cursor:set("ddns", "myddns", "check_interval", "10")
        cursor:set("ddns", "myddns", "check_unit", "minutes")
        cursor:set("ddns", "myddns", "force_interval", "72")
        cursor:set("ddns", "myddns", "force_unit", "hours")
    end
    
    cursor:commit("ddns")
    
    -- 重启服务
    if enabled == 1 then
        XQFunction.forkExec("/etc/init.d/ddns restart")
    else
        XQFunction.forkExec("/etc/init.d/ddns stop")
    end
    
    return 0
end
```

### 3. 支持的DDNS服务提供商

```lua
function getDDNSProviders()
    return {
        {name = "dyndns.org", display = "DynDNS"},
        {name = "changeip.com", display = "ChangeIP"},
        {name = "zoneedit.com", display = "ZoneEdit"},
        {name = "free.editdns.net", display = "EditDNS"},
        {name = "freedns.afraid.org", display = "FreeDNS"},
        {name = "no-ip.com", display = "No-IP"},
        {name = "dnsomatic.com", display = "DNS-O-Matic"},
        {name = "3322.org", display = "3322.org"},
        {name = "oray.com", display = "花生壳(Oray)"},
        {name = "dnspod.cn", display = "DNSPod"},
        {name = "cloudflare.com", display = "Cloudflare"}
    }
end
```

## UCI配置结构

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `enabled` | 是否启用 | 0 |
| `service_name` | 服务提供商 | - |
| `domain` | 域名 | - |
| `username` | 用户名 | - |
| `password` | 密码 | - |
| `ip_source` | IP来源 | network |
| `ip_network` | 网络接口 | wan |
| `check_interval` | 检查间隔 | 10 |
| `check_unit` | 检查单位 | minutes |
| `force_interval` | 强制更新间隔 | 72 |
| `force_unit` | 强制更新单位 | hours |

## 返回值说明

### setDDNS 返回值

| 返回值 | 说明 |
|--------|------|
| 0 | 成功 |
| 1 | 参数不完整 |

## 注意事项

1. **安全性**: `getDDNSInfo()` 不返回密码字段
2. **默认配置**: 检查间隔10分钟，强制更新间隔72小时
3. **IP来源**: 默认从WAN接口获取公网IP
4. **服务管理**: 启用时重启服务，禁用时停止服务
