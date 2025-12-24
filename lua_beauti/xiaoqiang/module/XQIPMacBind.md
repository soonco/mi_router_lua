# XQIPMacBind.lua - IP-MAC绑定模块

## 概述

`XQIPMacBind` 是小米路由器的IP-MAC绑定底层操作模块，负责通过系统脚本 `/usr/sbin/ipmac_binding` 执行实际的IP与MAC地址绑定操作。该模块提供了绑定的添加、删除、批量操作、清空和重载等功能，是 `XQMacBind` 模块的底层依赖。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    IP-MAC绑定操作流程                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐     ┌──────────────────┐                     │
│  │ XQMacBind    │────▶│  XQIPMacBind     │                     │
│  │ (高层接口)    │     │  (底层操作)       │                     │
│  └──────────────┘     └────────┬─────────┘                     │
│                                │                                │
│                                ▼                                │
│                    ┌──────────────────────┐                    │
│                    │   参数验证            │                    │
│                    │   - IP地址有效性      │                    │
│                    │   - MAC地址格式       │                    │
│                    │   - 单播地址检查      │                    │
│                    └──────────┬───────────┘                    │
│                               │                                 │
│                               ▼                                 │
│                    ┌──────────────────────┐                    │
│                    │ /usr/sbin/ipmac_binding │                 │
│                    │   - add <mac> <ip>   │                    │
│                    │   - del <mac> <ip>   │                    │
│                    │   - clearSession     │                    │
│                    │   - flush            │                    │
│                    │   - reload           │                    │
│                    └──────────────────────┘                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### IP地址验证范围

```
有效IP范围:
├── A类: 1.0.0.0 ~ 126.0.0.0
└── B/C类: 128.0.0.0 ~ 223.255.255.255

排除范围:
├── 0.x.x.x (保留)
├── 127.x.x.x (回环地址)
└── 224.0.0.0+ (组播/广播)
```

## 接口列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `checkIP(ip)` | ip: string | boolean | 验证IP是否在有效范围内 |
| `isUnicastMac(mac)` | mac: string | boolean | 检查是否为单播MAC地址 |

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_checkMac(mac)` | mac: string | boolean | 验证MAC地址有效性 |
| `addIPMacBindList(bindList)` | bindList: table | boolean | 批量添加IP-MAC绑定 |
| `addIPMacBindEntry(mac, ip)` | mac: string, ip: string | boolean | 添加单条绑定 |
| `delIPMacBindingList(macList)` | macList: table | boolean | 批量删除绑定 |
| `delIPMacBindingEntry(mac, ip)` | mac: string, ip: string | boolean | 删除单条绑定 |
| `ipMacBindclearOldSession(mac, ip)` | mac: string, ip: string | boolean | 清除旧的绑定会话 |
| `flushIPMacBindingList()` | 无 | boolean | 清空所有绑定 |
| `reloadIPMacBindingList()` | 无 | boolean | 重新加载绑定配置 |

### 参数说明

**bindList 结构:**
```lua
{
    { mac = "AA:BB:CC:DD:EE:FF", ip = "192.168.1.100" },
    { mac = "11:22:33:44:55:66", ip = "192.168.1.101" }
}
```

**macList 结构:**
```lua
{ "AA:BB:CC:DD:EE:FF", "11:22:33:44:55:66" }
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（字符串检查、MAC格式化） |
| `xiaoqiang.module.XQMacBind` | MAC绑定信息查询（删除时获取IP） |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.cbi.datatypes` | MAC地址格式验证 |
| `luci.ip` | IP地址转换和比较 |
| `cjson` | JSON处理 |

### 系统依赖

| 脚本/命令 | 用途 |
|-----------|------|
| `/usr/sbin/ipmac_binding` | IP-MAC绑定核心脚本 |

## 被引用情况

| 引用模块 | 引用函数 | 用途 |
|----------|----------|------|
| `xiaoqiang.module.XQMacBind` | `addIPMacBindEntry` | 添加绑定时同步底层 |
| `xiaoqiang.module.XQMacBind` | `delIPMacBindingEntry` | 删除绑定时同步底层 |
| `xiaoqiang.module.XQMacBind` | `ipMacBindclearOldSession` | 更新绑定时清理会话 |
| `xiaoqiang.module.XQMacBind` | `flushIPMacBindingList` | 解绑所有设备 |
| `xiaoqiang.module.XQMacBind` | `reloadIPMacBindingList` | 重载绑定配置 |

## 关键代码说明

### 单播MAC地址验证

```lua
local function isUnicastMac(mac)
    if DataTypes.macaddr(mac) then
        local firstByte = tonumber(mac:sub(1, 2), 16)
        local isUnicast = (firstByte % 2) == 0  -- 最低位为0表示单播
        return isUnicast
    end
    return false
end
```

单播MAC地址的第一个字节最低位必须为0，组播地址最低位为1。

### 绑定命令执行

```lua
-- 添加绑定
local cmd = "/usr/sbin/ipmac_binding add " .. mac .. " " .. ip .. " > /dev/console"
os.execute(cmd)

-- 删除绑定
local cmd = "/usr/sbin/ipmac_binding del " .. mac .. " " .. ip .. " > /dev/console"
os.execute(cmd)

-- 清除会话（用于更新绑定时）
local cmd = "/usr/sbin/ipmac_binding clearSession " .. mac .. " " .. ip .. " > /dev/console"
os.execute(cmd)
```

### 批量删除流程

```lua
function delIPMacBindingList(macList)
    local bindInfo = XQMacBind.macBindInfo()  -- 获取当前绑定信息
    
    for _, mac in ipairs(macList) do
        local entry = bindInfo[string.lower(mac)]
        if entry then
            local ip = entry.ip  -- 从绑定信息中获取对应IP
            local cmd = "/usr/sbin/ipmac_binding del " .. mac .. " " .. ip
            os.execute(cmd)
        end
    end
end
```

删除时需要先查询绑定信息获取对应的IP地址，因为底层脚本需要MAC和IP两个参数。
