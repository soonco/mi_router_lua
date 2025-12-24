# XQMultiWanPolicy.lua - 多WAN策略模块

## 概述

`XQMultiWanPolicy` 是小米路由器的多WAN口策略管理模块，基于mwan3实现多WAN负载均衡和策略路由功能。该模块支持权重负载均衡、故障转移、策略路由等多种模式，适用于双WAN或多WAN口的路由器型号。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    多WAN策略管理架构                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    流量入口                           │      │
│  └──────────────────────────┬───────────────────────────┘      │
│                             │                                   │
│                             ▼                                   │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                 XQMultiWanPolicy                      │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐     │      │
│  │  │ 负载均衡    │  │ 策略路由    │  │ 故障转移    │     │      │
│  │  │ (权重分配)  │  │ (规则匹配)  │  │ (健康检查)  │     │      │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘     │      │
│  └────────┼───────────────┼───────────────┼─────────────┘      │
│           │               │               │                     │
│           └───────────────┼───────────────┘                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    mwan3 服务                         │      │
│  │  ┌──────────────────────────────────────────────┐   │      │
│  │  │              UCI配置 (mwan3)                  │   │      │
│  │  │  ├── globals (全局设置)                       │   │      │
│  │  │  ├── interface (接口配置)                     │   │      │
│  │  │  ├── member (成员配置)                        │   │      │
│  │  │  ├── policy (策略配置)                        │   │      │
│  │  │  └── rule (规则配置)                          │   │      │
│  │  └──────────────────────────────────────────────┘   │      │
│  └──────────────────────────────────────────────────────┘      │
│                           │                                     │
│           ┌───────────────┼───────────────┐                    │
│           ▼               ▼               ▼                    │
│      ┌─────────┐     ┌─────────┐     ┌─────────┐              │
│      │  WAN1   │     │  WAN2   │     │  WAN3   │              │
│      │ (主线路) │     │ (备线路) │     │ (扩展)   │              │
│      └─────────┘     └─────────┘     └─────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 负载均衡模式

```
BALANCE_MODE
├── WEIGHT (1)    -- 权重模式: 按权重比例分配流量
├── FAILOVER (2)  -- 故障转移: 主线路故障时切换
└── POLICY (3)    -- 策略路由: 按规则选择线路
```

### 健康检查流程

```
健康检查 (Health Check)
        │
        ▼
┌───────────────────┐
│ 发送探测包         │
│ (ping/arping/http)│
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 检查响应          │
│ - timeout: 超时   │
│ - interval: 间隔  │
│ - count: 次数     │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 判断接口状态       │
│ - up: 上线阈值    │
│ - down: 下线阈值  │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 更新路由策略       │
└───────────────────┘
```

## 接口列表

### 常量

| 常量名 | 值 | 说明 |
|--------|-----|------|
| `BALANCE_MODE_WEIGHT` | 1 | 权重负载均衡模式 |
| `BALANCE_MODE_FAILOVER` | 2 | 故障转移模式 |
| `BALANCE_MODE_POLICY` | 3 | 策略路由模式 |

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getMultiWanInfo()` | 无 | table | 获取多WAN配置信息 |
| `setMultiWanEnabled(enabled)` | enabled: number | number | 设置启用状态 |
| `setBalanceMode(mode)` | mode: number | number | 设置负载均衡模式 |
| `setInterfaceWeight(interfaceName, weight)` | interfaceName: string, weight: number | number | 设置接口权重 |
| `addPolicyRule(...)` | 见下表 | number | 添加策略路由规则 |
| `deletePolicyRule(ruleName)` | ruleName: string | number | 删除策略路由规则 |
| `getInterfaceStatus()` | 无 | table | 获取接口状态 |
| `setHealthCheck(...)` | 见下表 | number | 设置健康检查参数 |

### 参数说明

**addPolicyRule 参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| ruleName | string | 规则名称 |
| srcIp | string | 源IP地址 |
| destIp | string | 目标IP地址 |
| proto | string | 协议 (tcp/udp/all) |
| srcPort | string | 源端口 |
| destPort | string | 目标端口 |
| policy | string | 使用的策略名称 |

**setHealthCheck 参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| interfaceName | string | 接口名称 |
| trackIp | table | 检测IP列表 |
| trackMethod | string | 检测方法 (ping/arping/httping) |
| interval | number | 检测间隔(秒) |
| timeout | number | 超时时间(秒) |
| reliability | number | 可靠性阈值 |

### 返回值说明

**getMultiWanInfo 返回结构:**
```lua
{
    enabled = 1,           -- 是否启用
    mode = 1,              -- 负载均衡模式
    interfaces = {         -- 接口列表
        {
            name = "wan",
            enabled = "1",
            weight = 10,
            track_ip = {"8.8.8.8", "114.114.114.114"},
            track_method = "ping",
            reliability = 1,
            count = 1,
            timeout = 2,
            interval = 5,
            down = 3,
            up = 3
        }
    },
    rules = {              -- 策略规则列表
        {
            name = "rule1",
            src_ip = "192.168.1.0/24",
            dest_ip = "",
            proto = "all",
            src_port = "",
            dest_port = "",
            use_policy = "balanced"
        }
    }
}
```

**返回码说明:**
| 值 | 说明 |
|----|------|
| 0 | 成功 |
| 1 | 参数错误 |
| 2 | 接口/规则不存在 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（异步执行） |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `luci.model.uci` | UCI配置操作 |
| `luci.util` | 命令执行 |

### UCI配置

| 配置文件 | section | 用途 |
|----------|---------|------|
| `mwan3` | `globals` | 全局设置（启用状态、模式） |
| `mwan3` | `interface` | 接口配置（权重、健康检查） |
| `mwan3` | `rule` | 策略路由规则 |

### 系统依赖

| 服务/命令 | 用途 |
|-----------|------|
| `/etc/init.d/mwan3` | mwan3服务控制 |
| `/usr/sbin/mwan3` | mwan3状态查询 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 多WAN管理接口 |
| 网络设置页面 | 多WAN配置界面 |

## 关键代码说明

### 获取接口配置

```lua
function getMultiWanInfo()
    local cursor = uci.cursor()
    
    -- 遍历接口配置
    cursor:foreach("mwan3", "interface", function(section)
        local interface = {
            name = section[".name"],
            enabled = section.enabled or "1",
            weight = tonumber(section.weight or "1"),
            track_ip = section.track_ip or {},
            track_method = section.track_method or "ping",
            -- 健康检查参数
            reliability = tonumber(section.reliability or "1"),
            timeout = tonumber(section.timeout or "2"),
            interval = tonumber(section.interval or "5"),
            down = tonumber(section.down or "3"),
            up = tonumber(section.up or "3")
        }
        table.insert(result.interfaces, interface)
    end)
end
```

### 设置负载均衡模式

```lua
function setBalanceMode(mode)
    if mode < 1 or mode > 3 then
        return 1
    end
    
    cursor:set("mwan3", "globals", "mode", tostring(mode))
    cursor:commit("mwan3")
    
    -- 重启服务使配置生效
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    return 0
end
```

### 添加策略路由规则

```lua
function addPolicyRule(ruleName, srcIp, destIp, proto, srcPort, destPort, policy)
    local config = {
        src_ip = srcIp or "",
        dest_ip = destIp or "",
        proto = proto or "all",
        src_port = srcPort or "",
        dest_port = destPort or "",
        use_policy = policy
    }
    
    cursor:section("mwan3", "rule", ruleName, config)
    cursor:commit("mwan3")
    
    XQFunction.forkExec("/etc/init.d/mwan3 restart")
    return 0
end
```

### 获取接口状态

```lua
function getInterfaceStatus()
    local statusOutput = luciUtil.exec("/usr/sbin/mwan3 status 2>/dev/null")
    
    -- 解析状态输出
    for line in statusOutput:gmatch("[^\r\n]+") do
        local interface, status = line:match("^interface (%w+) is (%w+)")
        if interface and status then
            table.insert(result, {
                name = interface,
                status = status  -- online/offline
            })
        end
    end
end
```
