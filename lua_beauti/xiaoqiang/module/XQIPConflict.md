# XQIPConflict.lua - IP冲突检测模块

## 概述

XQIPConflict 是小米路由器的IP地址冲突检测和解决模块。该模块通过调用 `/usr/sbin/ip_conflict.sh` 脚本检测WAN口和LAN口的IP地址冲突，并在检测到冲突时自动修改IP地址，同时触发系统事件通知相关组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      XQIPConflict IP冲突检测模块                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        IP冲突场景                                 │   │
│  │                                                                   │   │
│  │   场景1: WAN口IP冲突                                             │   │
│  │   ┌──────────────┐         ┌──────────────┐                      │   │
│  │   │  上级路由器   │         │  本机路由器   │                      │   │
│  │   │ 192.168.1.1  │ ◄─────► │ 192.168.1.1  │  ← IP冲突!          │   │
│  │   └──────────────┘   WAN   └──────────────┘                      │   │
│  │                                                                   │   │
│  │   场景2: LAN-WAN IP冲突                                          │   │
│  │   ┌──────────────┐         ┌──────────────┐                      │   │
│  │   │   WAN口      │         │   LAN口      │                      │   │
│  │   │ 192.168.31.x │ ◄─────► │ 192.168.31.1 │  ← 网段冲突!        │   │
│  │   └──────────────┘         └──────────────┘                      │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        检测与解决流程                             │   │
│  │                                                                   │   │
│  │   ┌────────────────┐                                             │   │
│  │   │ ip_conflict.sh │                                             │   │
│  │   │     wan        │ ──► 检测WAN口IP冲突                         │   │
│  │   └────────────────┘                                             │   │
│  │           │                                                       │   │
│  │           ▼                                                       │   │
│  │   ┌────────────────┐                                             │   │
│  │   │ ip_conflict.sh │                                             │   │
│  │   │  wan modify    │ ──► 修改LAN口IP解决冲突                     │   │
│  │   └────────────────┘                                             │   │
│  │           │                                                       │   │
│  │           ▼                                                       │   │
│  │   ┌────────────────┐                                             │   │
│  │   │ lanIPChange    │                                             │   │
│  │   │    事件        │ ──► 通知系统IP已变更                        │   │
│  │   └────────────────┘                                             │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 冲突解决流程

```
┌─────────────────────────────────────────────────────────────────┐
│                      冲突解决流程                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   1. 检测冲突                                                   │
│      ip_conflict_detection()                                    │
│      └─ /usr/sbin/ip_conflict.sh wan                           │
│         └─ 返回冲突IP或空                                       │
│                                                                  │
│   2. 解决冲突                                                   │
│      ip_conflict_resolution()                                   │
│      └─ /usr/sbin/ip_conflict.sh wan modify                    │
│         └─ 返回新的LAN IP                                       │
│                                                                  │
│   3. 清理消息                                                   │
│      XQMessageBox.removeMessage(4)                              │
│      └─ 移除IP冲突提示消息                                      │
│                                                                  │
│   4. 触发事件                                                   │
│      XQEvent.lanIPChange(newLanIp, netmask, netmask)           │
│      └─ 通知系统LAN IP已变更                                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `ip_conflict_detection()` | 无 | `conflictIp:string` 或 `false` | 检测WAN口IP地址冲突 |
| `lan_ip_conflict_resolution()` | 无 | 无 | 解决LAN口IP冲突 |
| `ip_conflict_resolution()` | 无 | `success:boolean` | 解决WAN口IP冲突 |
| `lan_wan_ip_conflict_chk(lanIp, wanIp)` | `lanIp:string` LAN口IP, `wanIp:string` WAN口IP | `conflict:boolean` | 检查LAN和WAN之间的IP冲突 |

## 脚本命令

| 命令 | 说明 |
|------|------|
| `/usr/sbin/ip_conflict.sh wan` | 检测WAN口IP冲突，返回冲突IP |
| `/usr/sbin/ip_conflict.sh wan modify` | 修改LAN口IP解决冲突，返回新IP |
| `/usr/sbin/ip_conflict.sh br-lan` | 解决LAN口IP冲突 |
| `/usr/sbin/ip_conflict.sh br-lan check <lanIp> <wanIp>` | 检查LAN-WAN IP冲突 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `xiaoqiang.common.XQFunction` | 通用函数(网络模式检测、字符串处理) |
| `xiaoqiang.module.XQMessageBox` | 消息盒子(移除冲突提示) |
| `xiaoqiang.XQEvent` | 事件系统(触发IP变更事件) |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.util` | 命令执行 |
| `luci.model.uci` | UCI配置读取 |

## 被引用情况

该模块主要被以下组件引用：
- 网络状态检测服务
- WAN口连接状态监控
- 系统初始化脚本
- 网络配置变更钩子

## 关键代码说明

### WAN口IP冲突检测

```lua
function ip_conflict_detection()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    -- 只在路由模式下检测
    local netModeType = XQFunction.getNetModeType()
    if netModeType ~= 0 then
        return false
    end
    
    local LuciUtil = require("luci.util")
    
    -- 执行检测脚本
    local conflictIp = string.gsub(
        LuciUtil.exec("/usr/sbin/ip_conflict.sh wan"),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",  -- 去除首尾空白
        "%1"
    )
    
    -- 检查是否有冲突
    if XQFunction.isStrNil(conflictIp) or conflictIp == "0.0.0.0" then
        return false
    end
    
    return conflictIp
end
```

### IP冲突解决

```lua
function ip_conflict_resolution()
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    local XQEvent = require("xiaoqiang.XQEvent")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local LuciUtil = require("luci.util")
    
    -- 执行修改脚本获取新IP
    local newLanIp = string.gsub(
        LuciUtil.exec("/usr/sbin/ip_conflict.sh wan modify"),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",
        "%1"
    )
    
    if not XQFunction.isStrNil(newLanIp) and newLanIp ~= "0.0.0.0" then
        -- 移除IP冲突提示消息
        XQMessageBox.removeMessage(4)
        
        -- 获取子网掩码
        local uci = require("luci.model.uci").cursor()
        local netmask = uci:get("network", "lan", "netmask") or "255.255.255.0"
        
        -- 触发LAN IP变更事件
        XQEvent.lanIPChange(newLanIp, netmask, netmask)
        
        return true
    end
    
    return false
end
```

### LAN-WAN IP冲突检查

```lua
function lan_wan_ip_conflict_chk(lanIp, wanIp)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQLog = require("xiaoqiang.XQLog")
    local LuciUtil = require("luci.util")
    
    -- 构建检查命令
    local checkCmd = "/usr/sbin/ip_conflict.sh br-lan check"
    local formattedLanIp = XQFunction._strformat(lanIp)
    local formattedWanIp = XQFunction._strformat(wanIp)
    
    checkCmd = checkCmd .. " " .. formattedLanIp .. " " .. formattedWanIp
    
    -- 执行检查
    local result = string.gsub(
        LuciUtil.exec(checkCmd),
        "^[%s\n\r\t]*(.-)[%s\n\r\t]*$",
        "%1"
    )
    
    if not XQFunction.isStrNil(result) then
        XQLog.log(6, "lan_wan_ip_conflict_chk: " .. result)
    end
    
    -- 返回是否冲突
    if XQFunction.isStrNil(result) or result == "0" then
        return false
    end
    
    return true
end
```

## 消息类型

| 消息ID | 说明 |
|--------|------|
| 4 | IP冲突提示消息 |

## 网络模式

| 模式值 | 说明 |
|--------|------|
| 0 | 路由模式(需要检测IP冲突) |
| 其他 | 其他模式(不检测) |

## 注意事项

1. IP冲突检测只在路由模式(netModeType=0)下执行
2. 冲突解决会自动修改LAN口IP地址
3. IP变更后会触发lanIPChange事件，相关组件需要响应此事件
4. 消息盒子中的IP冲突提示(ID=4)会在解决后自动移除
