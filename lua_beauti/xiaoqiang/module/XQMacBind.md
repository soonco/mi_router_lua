# XQMacBind.lua - MAC绑定模块

## 概述

`XQMacBind` 是小米路由器的MAC地址绑定核心模块，提供设备MAC地址与IP地址的绑定管理功能。该模块支持DHCP静态分配、IP-MAC绑定检查、批量绑定操作等功能，是实现设备固定IP分配和网络访问控制的关键组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    MAC绑定管理架构                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐                                              │
│  │  API请求      │                                              │
│  └──────┬───────┘                                              │
│         │                                                       │
│         ▼                                                       │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                   XQMacBind                           │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐     │      │
│  │  │ addBind    │  │ removeBind │  │ macBindInfo│     │      │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘     │      │
│  │        │               │               │             │      │
│  └────────┼───────────────┼───────────────┼─────────────┘      │
│           │               │               │                     │
│           ▼               ▼               ▼                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              UCI配置层                               │       │
│  │  ┌──────────────┐    ┌──────────────┐              │       │
│  │  │ dhcp.host    │    │ macbind.host │              │       │
│  │  │ (DHCP静态IP) │    │ (绑定记录)    │              │       │
│  │  └──────────────┘    └──────────────┘              │       │
│  └─────────────────────────────────────────────────────┘       │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              XQIPMacBind (底层操作)                   │       │
│  │  ┌──────────────────────────────────────────┐       │       │
│  │  │ /usr/sbin/ipmac_binding                  │       │       │
│  │  │ (内核级IP-MAC绑定)                        │       │       │
│  │  └──────────────────────────────────────────┘       │       │
│  └─────────────────────────────────────────────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 绑定添加流程

```
addBind(mac, ip, name)
        │
        ▼
┌───────────────────┐
│ 1. 参数验证        │
│    - IP有效性      │
│    - MAC有效性     │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 2. IP冲突检测      │
│    - 检查DHCP租约  │
│    - ARP探测       │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 3. 已绑定检查      │
│    - 相同IP则跳过  │
│    - 不同IP则更新  │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 4. 底层绑定        │
│    - XQIPMacBind  │
│    (如果启用检查)  │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 5. UCI配置更新     │
│    - dhcp.host    │
│    - macbind.host │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ 6. 设备信息保存    │
│    - XQDBUtil     │
└───────────────────┘
```

## 接口列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_checkIP(ip)` | ip: string | boolean | 验证IP地址有效性 |
| `_checkMacFormat(mac)` | mac: string | boolean | 验证MAC是否为单播地址 |
| `_checkMac(mac)` | mac: string | boolean | 验证MAC地址有效性 |
| `_parseMac(mac)` | mac: string | string | 解析MAC为无分隔符格式 |
| `_parseDhcpLeases()` | 无 | table | 解析DHCP租约文件 |

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `macBindInfo()` | 无 | table | 获取所有MAC绑定信息 |
| `hookLanIPChangeEvent(newLanIp)` | newLanIp: string | 无 | LAN IP变更时更新绑定 |
| `changeBindInfo(mac, ip, name)` | mac, ip, name: string | boolean | 修改绑定信息 |
| `setIPMACCheckEnable(enable)` | enable: number | number | 设置IP-MAC检查开关 |
| `getIPMACCheckEnable()` | 无 | number | 获取IP-MAC检查状态 |
| `addBind(mac, ip, name)` | mac, ip, name: string | number | 添加单条绑定 |
| `addBinds(bindEntries)` | bindEntries: table | number | 批量添加绑定 |
| `removeBind(mac)` | mac: string | boolean | 删除单条绑定 |
| `removeBinds(macList)` | macList: table | boolean | 批量删除绑定 |
| `unbindAll()` | 无 | 无 | 解绑所有设备 |
| `getMacbindStatus(mac)` | mac: string | boolean | 检查MAC是否已绑定 |
| `getMacBindList(deviceList)` | deviceList: table | table | 获取设备列表的绑定信息 |
| `getMacBindedIPInfo(mac)` | mac: string | string/0 | 获取MAC绑定的IP |
| `reload()` | 无 | 无 | 重启DHCP服务 |

### 返回值说明

**addBind/addBinds 返回值:**
| 值 | 说明 |
|----|------|
| 0 | 成功 |
| 1 | IP地址已被其他设备使用 |
| 2 | 参数无效（IP或MAC格式错误） |
| 3 | IP地址重复（批量添加时） |
| 4 | 底层绑定操作失败 |

**setIPMACCheckEnable 返回值:**
| 值 | 说明 |
|----|------|
| 0 | 成功或功能未启用 |
| 1523 | 参数无效 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（字符串检查、MAC格式化） |
| `xiaoqiang.common.XQConfigs` | 配置常量（DHCP租约文件路径） |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.util.XQDBUtil` | 设备信息数据库操作 |
| `xiaoqiang.module.XQIPMacBind` | IP-MAC底层绑定操作 |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具函数 |
| `xiaoqiang.util.XQPortServiceUtil` | 端口服务工具 |
| `xiaoqiang.XQEquipment` | 设备识别 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `luci.model.uci` | UCI配置操作 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `luci.util` | LuCI工具函数 |
| `luci.ip` | IP地址处理 |
| `nixio.fs` | 文件系统操作 |
| `cjson` | JSON处理 |

### UCI配置

| 配置文件 | section | 用途 |
|----------|---------|------|
| `dhcp` | `host` | DHCP静态IP分配 |
| `macbind` | `host` | MAC绑定记录 |
| `firewall` | `ipmacBind` | IP-MAC检查开关 |

## 被引用情况

| 引用模块 | 引用函数 | 用途 |
|----------|----------|------|
| `xiaoqiang.module.XQIPMacBind` | `macBindInfo` | 删除绑定时获取IP |
| API控制器 | `addBind/removeBind` | 设备绑定管理接口 |
| API控制器 | `macBindInfo` | 获取绑定列表 |
| API控制器 | `setIPMACCheckEnable` | IP-MAC检查开关 |

## 关键代码说明

### IP冲突检测

```lua
-- 检查DHCP租约中是否有其他设备使用该IP
local existingLease = dhcpLeases[ip]
if existingLease then
    if existingLease.mac ~= mac then
        -- 使用ARP探测确认IP是否在线
        local arpResult = os.execute("arping -f -q -c 2 -w 2 -I br-lan " .. ip)
        if arpResult == 0 then
            return 1  -- IP已被使用
        end
    end
end
```

### IP-MAC检查功能

```lua
-- 功能开关由features配置控制
local ipMacCheckFeature = features.system and features.system.ipmaccheck
local ipMacCheckEnabled = (ipMacCheckFeature and ipMacCheckFeature == "1") and 1 or 0

-- 启用/禁用IP-MAC检查
function setIPMACCheckEnable(enable)
    if enable == 1 then
        uciCursor:set("firewall", "ipmacBind", "status", "on")
    else
        uciCursor:set("firewall", "ipmacBind", "status", "off")
    end
    uciCursor:commit("firewall")
    XQIPMacBind.reloadIPMacBindingList()
end
```

### LAN IP变更处理

```lua
function hookLanIPChangeEvent(newLanIp)
    local ipPrefix = newLanIp:gsub(".%d+$", "")  -- 提取网段前缀
    
    -- 更新macbind配置中的IP
    uciCursor:foreach("macbind", "host", function(section)
        local lastOctet = section.ip:match(".(%d+)$")
        local newIp = ipPrefix .. "." .. lastOctet
        uciCursor:set("macbind", section[".name"], "ip", newIp)
    end)
    
    -- 更新dhcp配置中的IP
    uciCursor:foreach("dhcp", "host", function(section)
        local lastOctet = section.ip:match(".(%d+)$")
        local newIp = ipPrefix .. "." .. lastOctet
        uciCursor:set("dhcp", section[".name"], "ip", newIp)
    end)
end
```

### 绑定信息查询

```lua
function macBindInfo()
    local bindList = {}
    
    uciCursor:foreach("dhcp", "host", function(section)
        local entry = {
            name = "",
            mac = section.mac,
            ip = section.ip,
            tag = 2,
            instance = section.cwmp_LANDHCPStaticAddress_instance
        }
        
        -- 获取设备显示名称
        local deviceInfo = XQDBUtil.fetchDeviceInfo(string.upper(section.mac))
        if deviceInfo then
            -- 优先使用昵称，其次是设备类型名称，最后是原始名称
            entry.name = deviceInfo.nickname or deviceType.n or originalName
        end
        
        bindList[section.mac] = entry
    end)
    
    return bindList
end
```

### DHCP租约解析

```lua
function _parseDhcpLeases()
    local leaseList = {}
    local leaseFilePath = XQConfigs.DHCP_LEASE_FILEPATH
    
    -- 从dnsmasq配置获取实际租约文件路径
    uci:foreach("dhcp", "dnsmasq", function(section)
        if section.leasefile and nixioFs.access(section.leasefile) then
            leaseFilePath = section.leasefile
        end
    end)
    
    -- 解析租约文件
    -- 格式: timestamp mac ip hostname
    for line in leaseFile:lines() do
        local timestamp, mac, ip, hostname = line:match("^(%d+) (%S+) (%S+) (%S+)")
        leaseList[ip] = { mac = mac, ip = ip, name = hostname }
    end
    
    return leaseList
end
```
