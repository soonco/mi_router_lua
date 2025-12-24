# XQEvent.lua - 事件处理模块

## 概述

`XQEvent.lua` 是小米路由器的事件处理模块，负责处理系统级事件并协调各模块的配置更新。当前主要处理LAN IP地址变更事件，确保DMZ、端口转发、访客WiFi等功能在网络配置变化时能正确更新。

**文件位置**: `xiaoqiang/XQEvent.lua`  
**模块名**: `xiaoqiang.XQEvent`  
**代码行数**: ~50行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                  LAN IP变更事件处理流程                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  触发: LAN IP地址变更 (old_ip → new_ip)                      │
│              │                                              │
│              ▼                                              │
│  ┌─────────────────────────────────────────┐               │
│  │         lanIPChange(old_ip, old_mask, new_ip)           │
│  └─────────────────────────────────────────┘               │
│              │                                              │
│              ├──────────────────────────────────────┐       │
│              │                                      │       │
│              ▼                                      ▼       │
│  ┌─────────────────────┐            ┌─────────────────────┐│
│  │  XQFirewall         │            │  XQGuestWifi        ││
│  │  hookDMZLanIP...    │            │  hookLanIPChange... ││
│  │  DMZ主机IP更新      │            │  访客网络配置更新   ││
│  └─────────────────────┘            └─────────────────────┘│
│              │                                              │
│              ▼                                              │
│  ┌─────────────────────┐            ┌─────────────────────┐│
│  │  XQFirewall         │            │  XQLanWanUtil       ││
│  │  hookPortForward... │            │  hookLanIPChange... ││
│  │  端口转发规则更新   │            │  LAN/WAN配置更新    ││
│  └─────────────────────┘            └─────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### 事件处理机制

模块采用钩子（Hook）模式，当LAN IP变更时，依次调用各相关模块的钩子函数，实现配置的级联更新。

## 接口列表

### 事件处理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `lanIPChange(old_ip, old_mask, new_ip)` | old_ip: string, old_mask: string, new_ip: string | 无 | 处理LAN IP地址变更事件 |

### 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| `old_ip` | string | 旧的LAN IP地址（如 "192.168.31.1"） |
| `old_mask` | string | 旧的子网掩码（如 "255.255.255.0"） |
| `new_ip` | string | 新的LAN IP地址（如 "192.168.1.1"） |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（isStrNil） |
| `xiaoqiang.module.XQGuestWifi` | 访客WiFi模块 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN工具模块 |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.util.XQLanWanUtil` - LAN配置变更时触发事件
- `luci.controller.api.xqnetwork` - 网络API修改LAN配置时触发
- `luci.controller.api.xqsystem` - 系统API网络配置变更时触发

## 关键代码说明

### LAN IP变更事件处理

```lua
function lanIPChange(old_ip, old_mask, new_ip)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    -- 参数验证
    if XQFunction.isStrNil(old_ip) then
        return
    end
    
    -- 加载相关模块
    local XQGuestWifi = require("xiaoqiang.module.XQGuestWifi")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    -- 通知DMZ模块更新配置
    -- DMZ主机IP可能需要根据新的LAN网段调整
    XQFirewall.hookDMZLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知访客WiFi模块更新配置
    -- 访客网络的IP分配可能需要调整
    XQGuestWifi.hookLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知端口转发模块更新配置
    -- 端口转发规则中的内网IP可能需要更新
    XQFirewall.hookPortForwardLanIPChangeEvent(old_ip, new_ip)
    
    -- 通知LAN/WAN工具模块更新配置
    XQLanWanUtil.hookLanIPChangeEvent(old_ip, old_mask, new_ip)
end
```

## 钩子函数说明

### 1. DMZ配置更新钩子

```lua
XQFirewall.hookDMZLanIPChangeEvent(old_ip, new_ip)
```
- **作用**: 当LAN IP变更时，检查DMZ主机IP是否需要更新
- **场景**: DMZ主机IP如果在旧网段内，需要映射到新网段

### 2. 访客WiFi配置更新钩子

```lua
XQGuestWifi.hookLanIPChangeEvent(old_ip, new_ip)
```
- **作用**: 更新访客网络的IP分配范围
- **场景**: 访客网络通常使用独立的IP段，需要与主网络协调

### 3. 端口转发规则更新钩子

```lua
XQFirewall.hookPortForwardLanIPChangeEvent(old_ip, new_ip)
```
- **作用**: 更新端口转发规则中的内网目标IP
- **场景**: 端口转发规则指向的内网设备IP可能需要调整

### 4. LAN/WAN配置更新钩子

```lua
XQLanWanUtil.hookLanIPChangeEvent(old_ip, old_mask, new_ip)
```
- **作用**: 更新LAN/WAN相关的网络配置
- **场景**: DHCP服务器配置、路由表等可能需要更新

## 使用场景

1. **用户手动修改LAN IP**: 通过Web界面修改路由器LAN IP地址
2. **网络冲突自动调整**: 检测到IP冲突时自动切换网段
3. **恢复出厂设置**: 重置网络配置时触发
4. **导入配置**: 从备份恢复配置时可能触发

## 注意事项

1. **参数验证**: 函数会检查 `old_ip` 是否为空，为空则直接返回
2. **模块延迟加载**: 相关模块在函数内部按需加载，避免循环依赖
3. **事件顺序**: 钩子函数按固定顺序调用，确保配置更新的一致性
4. **无返回值**: 函数不返回执行结果，各钩子函数内部处理错误
