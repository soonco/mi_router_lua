# XQPortForward.lua - 端口转发模块

## 概述

`XQPortForward` 是小米路由器的端口转发管理模块，提供端口转发规则、虚拟服务器(VS)、端口触发(PT)和ALG(应用层网关)的配置管理功能。该模块是实现NAT穿透和外网访问内网服务的核心组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    端口转发系统架构                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    外网请求                           │      │
│  │              WAN_IP:外部端口                          │      │
│  └──────────────────────────┬───────────────────────────┘      │
│                             │                                   │
│                             ▼                                   │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                 XQPortForward                         │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐     │      │
│  │  │ 端口转发    │  │ 虚拟服务器  │  │ 端口触发    │     │      │
│  │  │ (redirect) │  │ (VS)       │  │ (PT)       │     │      │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘     │      │
│  └────────┼───────────────┼───────────────┼─────────────┘      │
│           │               │               │                     │
│           ▼               ▼               ▼                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              UCI配置 (firewall)                      │       │
│  │  ├── redirect (端口重定向规则)                       │       │
│  │  ├── porttrigger (端口触发规则)                      │       │
│  │  └── basicset (ALG设置)                              │       │
│  └─────────────────────────────────────────────────────┘       │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              iptables (DNAT)                         │       │
│  │  WAN_IP:外部端口 → LAN_IP:内部端口                   │       │
│  └─────────────────────────────────────────────────────┘       │
│           │                                                     │
│           ▼                                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    内网服务                           │      │
│  │              LAN_IP:内部端口                          │      │
│  └──────────────────────────────────────────────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 协议类型

```
协议类型 (proto)
├── 1 / "tcp"     -- TCP协议
├── 2 / "udp"     -- UDP协议
└── 3 / "tcpudp"  -- TCP和UDP
```

### 转发类型

```
转发类型 (ftype)
├── 1  -- 单端口转发
└── 2  -- 端口范围转发
```

## 接口列表

### 常量

| 常量名 | 值 | 说明 |
|--------|-----|------|
| `ALL_NORMAL` | 0 | 正常 |
| `ERR_EMPTY` | 1 | 参数为空 |
| `ERR_CHECK_FAILED` | 2 | 检查失败/端口冲突 |
| `ERR_DMZ_ON` | 3 | DMZ已开启 |
| `ERR_RELATIVE` | 4 | 端口范围错误 |

### 端口转发函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `portForwardInfo()` | 无 | table | 获取端口转发状态 |
| `portForwards(filterType)` | filterType: number | table | 获取端口转发规则列表 |
| `setPortForward(name, destIp, srcPort, destPort, proto)` | 见下表 | number | 设置单端口转发 |
| `setRangePortForward(name, destIp, startPort, endPort, proto)` | 见下表 | number | 设置端口范围转发 |
| `deletePortForward(srcPort, proto)` | srcPort, proto: number | boolean | 删除端口转发 |
| `deleteAllPortForward()` | 无 | boolean | 删除所有端口转发 |
| `moduleOn()` | 无 | boolean | 检查模块是否启用 |

### 虚拟服务器函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `VSInfo()` | 无 | table | 获取虚拟服务器规则列表 |
| `setVSRules(name, service, proto, exportPort, inportPort, destIp)` | 见下表 | number | 设置虚拟服务器规则 |
| `deleteVSRule(...)` | 见下表 | boolean | 删除虚拟服务器规则 |
| `VSOn()` | 无 | boolean | 检查VS是否开启 |

### 端口触发函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `PTInfo()` | 无 | table | 获取端口触发规则列表 |
| `setPTRules(name, tgProtocol, tgPort, exProtocol, exPort)` | 见下表 | number | 设置端口触发规则 |
| `deletePTRule(...)` | 见下表 | boolean | 删除端口触发规则 |
| `PTOn()` | 无 | boolean | 检查PT是否开启 |

### ALG函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `ALGInfo()` | 无 | table | 获取ALG配置 |
| `setALGFirewall(pptp, l2tp, ipsec, sip, ftp, tftp, rtsp, h323)` | 各参数: number | 无 | 设置ALG配置 |

### 辅助函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `hookLanIPChangeEvent(newLanIp, netmask)` | newLanIp, netmask: string | 无 | LAN IP变更时更新规则 |
| `checkPort(port)` | port: string | number | 检查端口有效性 |
| `checkOnePort(port)` | port: string | number | 检查单个端口 |

### 返回值说明

**portForwardInfo 返回结构:**
```lua
{
    status = 0  -- 0=关闭, 1=开启, 2=DMZ已开启
}
```

**端口转发规则结构:**
```lua
{
    name = "Web Server",
    destip = "192.168.1.100",
    proto = 1,           -- 1=tcp, 2=udp, 3=tcpudp
    srcport = 80,        -- 单端口时为数字
    destport = 80,
    ftype = 1            -- 1=单端口, 2=端口范围
}
-- 端口范围时:
{
    srcport = { f = 80, t = 90 }  -- from-to
}
```

**ALG配置结构:**
```lua
{
    pptp = "1",   -- PPTP穿透
    l2tp = "1",   -- L2TP穿透
    ipsec = "1",  -- IPSec穿透
    sip = "1",    -- SIP穿透
    ftp = "1",    -- FTP穿透
    tftp = "1",   -- TFTP穿透
    rtsp = "1",   -- RTSP穿透
    h323 = "1"    -- H323穿透
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.module.XQDMZModule` | DMZ模块 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `luci.model.uci` | UCI配置操作 |
| `luci.util` | 工具函数 |
| `luci.cbi.datatypes` | 数据类型验证 |

### UCI配置

| 配置文件 | section | 用途 |
|----------|---------|------|
| `firewall` | `redirect` | 端口重定向规则 |
| `firewall` | `porttrigger` | 端口触发规则 |
| `firewall` | `basicset` | ALG设置 |
| `firewall` | `vs` | 虚拟服务器元数据 |
| `firewall` | `pt` | 端口触发元数据 |
| `fw3_helper` | 各helper | ALG helper配置 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 端口转发管理接口 |
| 高级设置页面 | 端口转发配置界面 |

## 关键代码说明

### 端口冲突检测

```lua
function _portRangeOverlap(portRange1, portRange2)
    -- 解析端口范围
    local range1 = {}
    if portRange1:match("-") then
        local parts = luciUtil.split(portRange1, "-")
        range1.f = tonumber(parts[1])
        range1.t = tonumber(parts[2])
    else
        range1.f = tonumber(portRange1)
        range1.t = tonumber(portRange1)
    end
    
    -- 检查是否重叠
    if (range1.f >= range2.f and range1.f <= range2.t) or
       (range1.t >= range2.f and range1.t <= range2.t) or
       (range1.t >= range2.t and range1.f <= range2.f) then
        return true
    end
    return false
end
```

### 设置端口转发

```lua
function setPortForward(name, destIp, srcPort, destPort, proto)
    -- 检查DMZ状态
    if portForwardInfo().status == 2 then
        return ERR_DMZ_ON
    end
    
    -- 检查端口冲突
    if _portConflictCheckWithProto(srcPort, proto) then
        return ERR_CHECK_FAILED
    end
    
    -- 生成规则名称
    local sectionName = string.format("wan%srdr%s", srcPort, proto)
    
    -- 构建配置
    local config = {
        src = "wan",
        src_dport = srcPort,
        proto = _protoHelper(proto),
        target = "DNAT",
        dest = "lan",
        dest_port = destPort,
        dest_ip = destIp,
        ftype = 1,
        name = name
    }
    
    cursor:section("firewall", "redirect", sectionName, config)
    cursor:commit("firewall")
    return ALL_NORMAL
end
```

### LAN IP变更处理

```lua
function hookLanIPChangeEvent(newLanIp, netmask)
    local matchPattern = ".%d+$"
    if netmask == "255.255.0.0" then
        matchPattern = ".%d+.%d+$"
    end
    
    local newPrefix = newLanIp:gsub(matchPattern, "")
    
    -- 更新所有规则的目标IP
    cursor:foreach("firewall", "redirect", function(section)
        if section.ftype then
            local suffix = section.dest_ip:match(matchPattern)
            local newDestIp = newPrefix .. suffix
            cursor:set("firewall", section[".name"], "dest_ip", newDestIp)
        end
    end)
end
```

### ALG配置

```lua
function setALGFirewall(pptp, l2tp, ipsec, sip, ftp, tftp, rtsp, h323)
    -- 设置fw3_helper配置
    cursor:set("fw3_helper", "pptp", "enabled", pptp == 1 and "1" or "0")
    cursor:set("fw3_helper", "sip", "enabled", sip == 1 and "1" or "0")
    -- ...
    cursor:commit("fw3_helper")
    
    -- 设置firewall basicset配置
    cursor:set("firewall", "basicset", "alg_pptp", pptp == 1 and "1" or "0")
    cursor:set("firewall", "basicset", "alg_l2tp", l2tp == 1 and "1" or "0")
    -- ...
    cursor:commit("firewall")
end
```
