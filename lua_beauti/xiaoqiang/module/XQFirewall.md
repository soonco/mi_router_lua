# XQFirewall.lua - 防火墙模块

## 概述

`XQFirewall.lua` 是小米路由器的防火墙配置管理模块，提供DoS防护、WAN Ping控制、MAC/IP过滤、端口转发、DMZ等功能的统一接口。该模块整合了多个子模块的功能，是防火墙配置的核心入口。

**文件位置**: `xiaoqiang/module/XQFirewall.lua`  
**模块名**: `xiaoqiang.module.XQFirewall`  
**代码行数**: ~657行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    防火墙模块架构                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           XQFirewall (主模块)            │               │
│  └─────────────────────────────────────────┘               │
│         │              │              │                     │
│         ▼              ▼              ▼                     │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐              │
│  │XQDMZModule│  │XQPortFwd  │  │ macfilter │              │
│  │  DMZ管理  │  │ 端口转发  │  │ MAC过滤   │              │
│  └───────────┘  └───────────┘  └───────────┘              │
│                                                             │
│  防火墙功能:                                                │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐              │
│  │ DoS防护   │  │ WAN Ping  │  │ SPI防火墙 │              │
│  │syn/rst/   │  │ 允许/禁止 │  │ 状态检测  │              │
│  │icmp/udp   │  │           │  │           │              │
│  └───────────┘  └───────────┘  └───────────┘              │
│                                                             │
│  过滤功能:                                                  │
│  ┌───────────┐  ┌───────────┐                             │
│  │ MAC过滤   │  │  IP过滤   │                             │
│  │ 黑/白名单 │  │ IPv4/IPv6 │                             │
│  └───────────┘  └───────────┘                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 防火墙基础配置

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `FirewallInfo()` | 无 | table | 获取防火墙配置信息 |
| `setFirewallEnable(enabled)` | enabled: number | 无 | 设置防火墙启用状态 |
| `setDoSFirewall(enabled)` | enabled: number | 无 | 设置DoS防护 |
| `setWANPingFirewall(ignorewanping)` | ignorewanping: number | 无 | 设置WAN Ping响应 |
| `setSPIFirewall(enabled)` | enabled: number | 无 | 设置SPI状态检测防火墙 |

### 防火墙服务控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `reload()` | 无 | 无 | 重载防火墙配置 |
| `restart()` | 无 | 无 | 重启防火墙服务 |

### DMZ代理接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getDMZInfo()` | 无 | table | 获取DMZ信息 |
| `setDMZ(enabled, ipaddr, lanIp)` | 多参数 | number | 设置DMZ |
| `unsetDMZ(ipaddr)` | ipaddr: string | 无 | 取消DMZ |
| `dmzReload(async)` | async: boolean | 无 | 重载DMZ配置 |
| `hookDMZLanIPChangeEvent(oldIp, newIp)` | 多参数 | 无 | DMZ IP变更钩子 |

### 端口转发代理接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `VSInfo()` | 无 | table | 获取虚拟服务器信息 |
| `setVSRules(...)` | 多参数 | number | 设置虚拟服务器规则 |
| `deleteVSRule(...)` | 多参数 | number | 删除虚拟服务器规则 |
| `PTInfo()` | 无 | table | 获取端口触发信息 |
| `setPTRules(...)` | 多参数 | number | 设置端口触发规则 |
| `deletePTRule(...)` | 多参数 | number | 删除端口触发规则 |
| `ALGInfo()` | 无 | table | 获取ALG信息 |
| `setALGFirewall(...)` | 多参数 | number | 设置ALG配置 |

### MAC过滤接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getMacfilterInfo()` | 无 | table | 获取MAC过滤配置 |
| `getMacfilterInfoList(filterType)` | filterType: string | table | 获取MAC过滤列表 |
| `getBlackMacfilterInfo()` | 无 | table | 获取MAC黑名单 |
| `getWhiteMacfilterInfo()` | 无 | table | 获取MAC白名单 |
| `setmacfilterenablemode(enabled, filterMode, filterType)` | 多参数 | number | 设置MAC过滤模式 |
| `setMacFilter(mac, ruleName, action, allow)` | 多参数 | boolean | 设置MAC过滤规则 |

### IP过滤接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getIpfilterInfo()` | 无 | table | 获取IP过滤配置 |
| `getBlackIpfilterInfo()` | 无 | table | 获取IP黑名单 |
| `getWhiteIpfilterInfo()` | 无 | table | 获取IP白名单 |
| `setIpFilter(addr, ruleName, action, allow)` | 多参数 | boolean | 设置IP过滤规则 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.module.XQDMZModule` | DMZ模块 |
| `xiaoqiang.module.XQPortForward` | 端口转发模块 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `xiaoqiang.XQLog` | 日志模块 |
| `luci.model.uci` | UCI配置管理 |
| `luci.cbi.datatypes` | 数据类型验证 |

## 被引用情况

该模块被以下模块引用：
- `luci.controller.api.xqnetwork` - 网络API防火墙接口
- `luci.controller.api.xqsystem` - 系统API防火墙接口
- `xiaoqiang.XQEvent` - 事件处理模块

## 关键代码说明

### 1. 获取防火墙信息

```lua
function FirewallInfo()
    local info = {}
    
    info.firewall_enable = uci:get("firewall", "@defaults[0]", "fw_enable")
    info.spi_firewall = uci:get("firewall", "@defaults[0]", "spi_rule")
    info.dos_firewall = uci:get("firewall", "@defaults[0]", "dos_enable") or "0"
    info.wanping_firewall = uci:get("firewall", "@defaults[0]", "ignore_wan_ping")
    
    return info
end
```

### 2. DoS防护设置

```lua
function setDoSFirewallFw(enabled)
    if enabled == 1 then
        uci:set("firewall", "@defaults[0]", "syn_flood", "1")
        uci:set("firewall", "@defaults[0]", "rst_flood", "1")
        uci:set("firewall", "@defaults[0]", "icmp_flood", "1")
        uci:set("firewall", "@defaults[0]", "udp_flood", "1")
    elseif enabled == 0 then
        uci:set("firewall", "@defaults[0]", "syn_flood", "0")
        uci:set("firewall", "@defaults[0]", "rst_flood", "0")
        uci:set("firewall", "@defaults[0]", "icmp_flood", "0")
        uci:set("firewall", "@defaults[0]", "udp_flood", "0")
    end
    
    uci:commit("firewall")
end
```

### 3. MAC过滤设置

```lua
function setMacFilter(mac, ruleName, action, allow)
    local operation = (action == "0") and "add" or "del"
    local mode = uci:get("macfilter", "wan", "mode")
    
    -- 根据allow参数调整操作
    if allow == "1" then
        operation = (mode == "white") and "add" or "del"
    elseif allow == "0" then
        operation = (mode == "black") and "add" or "del"
    end
    
    -- 验证MAC地址格式
    if not datatypes.macaddr(mac) then
        return false
    end
    
    -- 执行过滤规则命令
    local cmd = "/usr/sbin/macfilter " .. operation .. " " .. mode .. " " .. mac
    local result = os.execute(cmd)
    return result == 0
end
```

### 4. IP过滤设置

```lua
function setIpFilter(addr, ruleName, action, allow)
    local operation = (action == "0") and "add" or "del"
    local mode = uci:get("ipfilter", "wan", "mode")
    local ipType = "v4"
    
    -- 判断IP类型
    if datatypes.ip6addr(addr) then
        ipType = "v6"
    elseif not datatypes.ip4addr(addr) then
        return false
    end
    
    local sectionType = mode .. "_" .. ipType
    
    -- 执行过滤规则命令
    local cmd = "/usr/sbin/ipfilter " .. operation .. " " .. mode .. " " .. addr
    local result = os.execute(cmd)
    return result == 0
end
```

## 协议编号转换

```lua
function numberToProto(protoNum)
    if protoNum == 1 then return "tcp"
    elseif protoNum == 2 then return "udp"
    elseif protoNum == 3 then return "tcpudp"
    else return "tcp"
    end
end
```

## 防火墙配置项

| 配置项 | 说明 |
|--------|------|
| `fw_enable` | 防火墙总开关 |
| `spi_rule` | SPI状态检测 |
| `dos_enable` | DoS防护开关 |
| `ignore_wan_ping` | 忽略WAN Ping |
| `syn_flood` | SYN洪水防护 |
| `rst_flood` | RST洪水防护 |
| `icmp_flood` | ICMP洪水防护 |
| `udp_flood` | UDP洪水防护 |

## 注意事项

1. **模块代理**: 该模块代理调用DMZ和端口转发子模块
2. **服务重启**: 配置变更后需要重启防火墙服务
3. **MWAN3集成**: 支持多WAN场景下的防火墙配置
4. **UPNP联动**: 防火墙重启时会联动UPNP服务
5. **IPv6支持**: IP过滤支持IPv4和IPv6地址
