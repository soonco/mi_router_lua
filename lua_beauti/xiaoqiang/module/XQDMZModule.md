# XQDMZModule.lua - DMZ主机模块

## 概述

`XQDMZModule.lua` 是小米路由器的DMZ（非军事区）主机管理模块，负责配置DMZ主机功能。该模块支持简单DMZ（端口重定向）和复杂DMZ（独立VLAN）两种模式，可将外网流量转发到指定的内网主机。

**文件位置**: `xiaoqiang/module/XQDMZModule.lua`  
**模块名**: `xiaoqiang.module.XQDMZModule`  
**代码行数**: ~435行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    简单DMZ模式                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  WAN (外网)                                                  │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           防火墙重定向规则               │               │
│  │  src=wan → dest=lan → dest_ip=DMZ主机   │               │
│  │  TCP + UDP (除67端口)                   │               │
│  └─────────────────────────────────────────┘               │
│      │                                                      │
│      ▼                                                      │
│  DMZ主机 (192.168.31.x)                                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    复杂DMZ模式                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  WAN (外网)                                                  │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           独立VLAN (eth0.3)              │               │
│  │  独立防火墙区域: dmz                     │               │
│  │  独立DHCP服务                           │               │
│  └─────────────────────────────────────────┘               │
│      │                                                      │
│      ▼                                                      │
│  DMZ主机 (独立网段)                                         │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 主要接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getDMZInfo()` | 无 | table | 获取DMZ状态信息 |
| `setDMZ(dmzType, destIp, mac)` | dmzType: number, destIp: string, mac: string | number | 设置DMZ |
| `unsetDMZ(dmzType)` | dmzType: number | 无 | 取消DMZ设置 |
| `moduleOn()` | 无 | boolean | 检查DMZ是否已启用 |
| `dmzReload(dmzType)` | dmzType: number | 无 | 重载DMZ配置 |

### 事件钩子

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `hookLanIPChangeEvent(newLanIp, netmask)` | 多参数 | 无 | LAN IP变更时更新DMZ配置 |

### 内部函数

| 函数名 | 说明 |
|--------|------|
| `_setSimpleDMZ(destIp, mac)` | 设置简单DMZ |
| `_setComplexDMZ(destIp, mac)` | 设置复杂DMZ |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.module.XQPortForward` | 端口转发模块 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `luci.model.uci` | UCI配置管理 |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.module.XQFirewall` - 防火墙模块代理调用
- `luci.controller.api.xqnetwork` - 网络API DMZ接口

## 关键代码说明

### 1. DMZ状态信息

```lua
function getDMZInfo()
    local result = {}
    
    -- 检查端口转发是否开启（与DMZ互斥）
    if XQPortForward.moduleOn() then
        result.status = 2  -- 端口转发已开启
    else
        if moduleOn() then
            result.status = 1  -- DMZ已开启
            result.ip = cursor:get("firewall", "dmz", "dest_ip") or ""
        else
            result.status = 0  -- DMZ未开启
        end
    end
    
    result.lanip = cursor:get("network", "lan", "ipaddr") or ""
    result.lanmask = cursor:get("network", "lan", "netmask") or ""
    
    return result
end
```

### 2. 简单DMZ设置

```lua
function _setSimpleDMZ(destIp, mac)
    -- 获取LAN配置
    local lanIp = cursor:get("network", "lan", "ipaddr")
    local netmask = cursor:get("network", "lan", "netmask")
    
    -- 检查IP是否在同一网段
    local lanPrefix = lanIp:gsub(".%d+$", "")
    local destPrefix = destIp:gsub(".%d+$", "")
    
    if lanPrefix ~= destPrefix or lanIp == destIp then
        return 2  -- IP不在同一网段或与LAN IP相同
    end
    
    -- 设置防火墙重定向规则
    dmzConfig.dest_ip = destIp
    dmzUdpConfig.dest_ip = destIp
    
    cursor:section("firewall", "redirect", "dmz", dmzConfig)
    cursor:section("firewall", "redirect", "dmzudp", dmzUdpConfig)
    cursor:commit("firewall")
    
    -- 可选：添加IP绑定
    if not XQFunction.isStrNil(mac) then
        XQLanWanUtil.addBind(mac, destIp)
    end
    
    return 0
end
```

### 3. LAN IP变更处理

```lua
function hookLanIPChangeEvent(newLanIp, netmask)
    local destIp = cursor:get("firewall", "dmz", "dest_ip")
    
    if not XQFunction.isStrNil(destIp) then
        -- 根据子网掩码确定匹配模式
        local matchPattern = ".%d+$"
        if netmask == "255.255.0.0" then
            matchPattern = ".%d+.%d+$"
        end
        
        -- 计算新的DMZ目标IP
        local newPrefix = newLanIp:gsub(matchPattern, "")
        local suffix = destIp:match(matchPattern)
        local newDestIp = newPrefix .. suffix
        
        -- 更新配置
        cursor:set("firewall", "dmz", "dest_ip", newDestIp)
        cursor:set("firewall", "dmzudp", "dest_ip", newDestIp)
        cursor:commit("firewall")
    end
end
```

## 返回值说明

### setDMZ 返回值

| 返回值 | 说明 |
|--------|------|
| 0 | 成功 |
| 2 | IP不在同一网段或与LAN IP相同 |
| 3 | DMZ类型错误 |
| 4 | 端口转发已开启 |
| 5 | 虚拟服务器或端口触发已开启 |

### getDMZInfo 状态值

| 状态值 | 说明 |
|--------|------|
| 0 | DMZ未开启 |
| 1 | DMZ已开启 |
| 2 | 端口转发已开启（与DMZ互斥） |

## 防火墙配置结构

### 简单DMZ防火墙规则

```lua
DMZ_FIREWALL_CONFIGS = {
    dmz = {
        src = "wan",
        proto = "tcp",
        target = "DNAT",
        dest = "lan",
        dest_ip = ""  -- DMZ主机IP
    },
    dmzudp = {
        src = "wan",
        proto = "udp",
        target = "DNAT",
        dest = "lan",
        src_port = "!67",  -- 排除DHCP端口
        dest_ip = ""
    }
}
```

## 注意事项

1. **互斥性**: DMZ与端口转发功能互斥，不能同时启用
2. **IP验证**: DMZ主机IP必须与路由器LAN IP在同一网段
3. **复杂DMZ**: 需要重启路由器才能生效
4. **IP绑定**: 可选择性地将DMZ主机MAC与IP绑定
5. **DHCP排除**: UDP重定向排除67端口，避免影响DHCP服务
