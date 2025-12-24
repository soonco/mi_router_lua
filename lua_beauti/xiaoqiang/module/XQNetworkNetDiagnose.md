# XQNetworkNetDiagnose.lua - 网络诊断模块

## 概述

`XQNetworkNetDiagnose` 是小米路由器的网络故障诊断模块，提供网络连接问题的自动检测和诊断功能。该模块可以检测WAN口连接、DHCP/PPPoE问题、DNS解析、网关可达性等多种网络故障，并返回详细的错误码和描述。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    网络诊断流程                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐                                              │
│  │  发起诊断     │                                              │
│  │ asyncNetDiag │                                              │
│  └──────┬───────┘                                              │
│         │                                                       │
│         ▼                                                       │
│  ┌──────────────────┐                                          │
│  │ 设置状态为检测中  │                                          │
│  │ NETTB = 99       │                                          │
│  └────────┬─────────┘                                          │
│           │                                                     │
│           ▼                                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │          do_net_diagose.lua (异步执行)                │      │
│  │  ┌────────────────────────────────────────────────┐ │      │
│  │  │ 1. 检查WAN口物理连接                            │ │      │
│  │  │ 2. 检查DHCP/PPPoE连接                          │ │      │
│  │  │ 3. 检查网关可达性                              │ │      │
│  │  │ 4. 检查DNS解析                                 │ │      │
│  │  │ 5. 检查AP模式网关                              │ │      │
│  │  └────────────────────────────────────────────────┘ │      │
│  └────────────────────────┬─────────────────────────────┘      │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │              保存诊断结果                             │      │
│  │              XQPreference.set("NETTB", code)         │      │
│  └──────────────────────────────────────────────────────┘      │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │              获取诊断结果                             │      │
│  │              getNetDiagResult()                       │      │
│  └──────────────────────────────────────────────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 错误码说明

```
网络诊断错误码 (NETTB)
├── 正常状态
│   ├── 0   -- 网络正常
│   └── 99  -- 正在检测中
│
├── 物理连接问题
│   ├── 1   -- WAN口未插网线
│   └── 10  -- 链路断开
│
├── DHCP问题
│   ├── 2   -- DHCP无服务器响应
│   └── 4   -- DHCP上游冲突
│
├── PPPoE问题
│   ├── 3   -- PPPoE无响应
│   ├── 31  -- PPPoE会话数超限
│   ├── 32  -- PPPoE密码错误
│   ├── 33  -- PPPoE账号无效
│   ├── 34  -- PPPoE需要重置MAC
│   └── 35  -- PPPoE被用户停止
│
├── 网关问题
│   ├── 5   -- 网关不可达
│   ├── 8   -- WiFi AP网关不可达
│   ├── 9   -- 有线AP网关不可达
│   └── 11  -- WHC RE网关不可达
│
└── DNS问题
    ├── 6   -- DNS解析失败
    └── 7   -- 自定义DNS设置问题
```

## 接口列表

### 常量

| 常量名 | 类型 | 说明 |
|--------|------|------|
| `NETTB` | table | 错误码到错误描述的映射表 |

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `execl2(command)` | command: string | table | 执行命令并返回输出行列表 |
| `saveNettb(errorCode)` | errorCode: string | 无 | 保存诊断结果 |
| `getWanMode()` | 无 | string | 获取WAN口连接模式 |
| `getDnsIp()` | 无 | string/nil | 获取DNS服务器IP |
| `getNetDiagResult()` | 无 | number, string | 获取诊断结果 |
| `asyncNetDiag()` | 无 | 无 | 异步执行网络诊断 |

### 返回值说明

**getNetDiagResult 返回值:**
| 返回值1 | 返回值2 | 说明 |
|---------|---------|------|
| 0 | "network ok!" | 网络正常 |
| 99 | "detecting..." | 正在检测 |
| 1-35 | 错误描述 | 具体错误 |
| -1 | "unknown nettb code!" | 未知错误码 |
| -2 | "no diag result!" | 无诊断结果 |

**getDnsIp 返回值:**
- 返回DNS服务器IP（多个用空格分隔）
- 返回nil表示未找到DNS
- 返回"0"表示配置文件不存在

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.util` | 命令执行 |
| `xiaoqiang.common.XQFunction` | 异步执行 |
| `xiaoqiang.XQPreference` | 诊断结果存储 |

### 系统依赖

| 文件/命令 | 用途 |
|-----------|------|
| `/tmp/resolv.conf.auto` | DNS配置文件 |
| `uci` | 获取网络配置 |
| `/usr/sbin/do_net_diagose.lua` | 诊断脚本 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 网络诊断接口 |
| 网络设置页面 | 网络故障排查 |
| 小米WiFi App | 网络诊断功能 |

## 关键代码说明

### 错误码映射表

```lua
NETTB = {
    ["1"] = "wan port unplug",
    ["2"] = "dhcp no server",
    ["3"] = "pppoe no reaponse",
    ["4"] = "dhcp upstream conflict",
    ["5"] = "gateway unreachable",
    ["6"] = "dns resolve failed",
    ["7"] = "dns custom set",
    ["8"] = "wifi_ap gateway unreachable",
    ["9"] = "wired_ap gateway unreachable",
    ["10"] = "link broken",
    ["11"] = "whc_re gateway unreachable",
    ["31"] = "pppoe no more sesson",
    ["32"] = "pppoe password error",
    ["33"] = "pppoe account not valid",
    ["34"] = "pppoe need reset mac",
    ["35"] = "pppoe stop by user"
}
```

### 异步诊断启动

```lua
function asyncNetDiag()
    -- 设置状态为检测中
    saveNettb("99")
    -- 异步执行诊断脚本
    XQFunction.forkExec("lua /usr/sbin/do_net_diagose.lua")
end
```

### 获取诊断结果

```lua
function getNetDiagResult()
    local XQPreference = require("xiaoqiang.XQPreference")
    local errorCode = tonumber(XQPreference.get("NETTB"))
    
    if errorCode then
        if errorCode == 99 then
            return errorCode, "detecting..."
        elseif errorCode == 0 then
            return errorCode, "network ok!"
        else
            local errorMsg = NETTB[tostring(errorCode)]
            if errorMsg then
                return errorCode, errorMsg
            end
            return -1, "unknown nettb code!"
        end
    else
        return -2, "no diag result!"
    end
end
```

### 获取DNS服务器

```lua
function getDnsIp()
    local lines = execl2("cat /tmp/resolv.conf.auto")
    local dnsServers = nil
    
    if lines and next(lines) ~= nil then
        local count = 0
        for _, line in ipairs(lines) do
            if count >= 2 then break end  -- 最多获取2个DNS
            
            local _, _, dnsIp = string.find(line, 
                "nameserver ([0-9]+%.[0-9]+%.[0-9]+%.[0-9]+)")
            if dnsIp then
                count = count + 1
                if dnsServers then
                    dnsServers = dnsServers .. " " .. dnsIp
                else
                    dnsServers = dnsIp
                end
            end
        end
    end
    
    return dnsServers
end
```

### 获取WAN模式

```lua
function getWanMode()
    local pipe = io.popen("uci -q get network.wan.proto")
    local wanProto = pipe:read("*line")
    pipe:close()
    return wanProto  -- dhcp/pppoe/static等
end
```

### 使用示例

```lua
-- 1. 启动异步诊断
asyncNetDiag()

-- 2. 轮询获取结果
local code, msg = getNetDiagResult()
while code == 99 do
    -- 等待诊断完成
    os.execute("sleep 1")
    code, msg = getNetDiagResult()
end

-- 3. 处理诊断结果
if code == 0 then
    print("网络正常")
else
    print("网络故障: " .. msg)
end
```
