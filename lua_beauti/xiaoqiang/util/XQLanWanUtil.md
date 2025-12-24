# XQLanWanUtil.lua - LAN/WAN网络配置工具模块

## 概述

小米路由器LAN/WAN网络配置核心工具模块，提供完整的网络接口配置、DHCP管理、IPv6配置、PPPoE拨号、MAC绑定、多WAN策略等功能。这是路由器网络配置的核心模块，功能非常全面。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   API控制器      | --> |  XQLanWanUtil    | --> |   UCI配置系统    |
|  (misystem等)    |     |  (网络配置)      |     |  (network/dhcp)  |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    接收配置请求           验证和处理参数           持久化配置
         |                       |                       |
         v                       v                       v
    返回配置结果           重启网络服务            应用网络变更
```

### 网络配置架构

```
                    +------------------+
                    |   XQLanWanUtil   |
                    +------------------+
                           |
        +------------------+------------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|   LAN配置     |  |   WAN配置     |  |   IPv6配置    |
| - IP地址      |  | - PPPoE       |  | - Native      |
| - DHCP服务    |  | - DHCP        |  | - DHCPv6      |
| - MAC绑定     |  | - 静态IP      |  | - 6in4/6to4   |
+---------------+  +---------------+  +---------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|  dnsmasq服务  |  |  pppoe服务    |  |  ipv6服务     |
+---------------+  +---------------+  +---------------+
```

## 接口列表

### MAC地址获取

#### getDefaultMacAddress()
获取默认MAC地址，根据网络模式返回适当的MAC。

**返回值：** `string` - MAC地址（大写格式）或"null"

---

#### getDefaultWanMacAddress()
获取默认WAN口MAC地址。

**返回值：** `string` - MAC地址（大写格式）或"null"

---

#### getLanMac()
获取LAN口MAC地址。

**返回值：** `string` - MAC地址（大写格式）或"null"

---

#### getWanMac(wanIface)
获取WAN口MAC地址。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| wanIface | string | 否 | WAN接口名，默认"wan" |

**返回值：** `string|nil` - MAC地址或nil

---

### LAN配置

#### getLanIp()
获取LAN口IP地址。

**返回值：** `string` - LAN IP地址

---

#### getLanMask()
获取LAN口子网掩码。

**返回值：** `string` - 子网掩码

---

#### setLanIp(ipAddr, netmask)
设置LAN IP地址。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| ipAddr | string | 是 | 新IP地址 |
| netmask | string | 是 | 新子网掩码 |

**返回值：** `boolean` - 是否成功

---

#### checkLanIpMask(ipAddr, netmask)
检查LAN IP和掩码的有效性。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| ipAddr | string | 是 | IP地址 |
| netmask | string | 是 | 子网掩码 |

**返回值：** `number` - 0=成功，1527=错误

---

### DHCP配置

#### getLanDHCPService()
获取LAN DHCP服务配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| lanIp | string | LAN IP地址 |
| start | string | 起始地址偏移 |
| startip | string | 起始IP地址 |
| endip | string | 结束IP地址 |
| limit | string | 地址池大小 |
| leasetime | string | 租约时间 |
| ignore | string | 是否禁用 |
| router | string | 网关地址 |
| dns1 | string | DNS1 |
| dns2 | string | DNS2 |

---

#### setLanDHCPService(startVal, endVal, startIp, endIp, leasetime, ignore, router, dns1, dns2)
设置LAN DHCP服务。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| startVal | string | 是 | 起始地址 |
| endVal | string | 是 | 结束地址 |
| startIp | string | 否 | 起始IP |
| endIp | string | 否 | 结束IP |
| leasetime | string | 是 | 租约时间 |
| ignore | string | 是 | "1"=禁用 |
| router | string | 否 | 网关地址 |
| dns1 | string | 否 | DNS1 |
| dns2 | string | 否 | DNS2 |

---

### MAC绑定

#### macBindInfo()
获取MAC绑定信息。

**返回值：** `table` - MAC地址到绑定信息的映射

---

#### addBind(macAddr, ipAddr)
添加MAC-IP绑定。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| macAddr | string | 是 | MAC地址 |
| ipAddr | string | 是 | IP地址 |

**返回值：** `number` - 0=成功，1=IP已被使用，2=参数无效

---

#### removeBind(macAddr)
删除MAC绑定。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| macAddr | string | 是 | MAC地址 |

**返回值：** `boolean` - 是否成功

---

### WAN配置

#### getAutoWanType()
自动检测WAN类型。

**返回值：** `string` - "pppoe"/"dhcp"/"static"/"nolink"/"unknown"

---

#### getWanLink(wanIface, retryCount)
获取WAN链路状态。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| wanIface | string | 否 | WAN接口名 |
| retryCount | number | 否 | 重试次数 |

**返回值：** `boolean` - 链路是否连接

---

#### ubusWanStatus(wanIface)
通过ubus获取WAN状态。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| wanIface | string | 否 | WAN接口名，默认"wan" |

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| ipv4 | table | IPv4地址列表 |
| gw | string | 网关地址 |
| dns | table | DNS服务器列表 |
| proto | string | 协议类型 |
| up | boolean | 是否在线 |
| uptime | number | 在线时长 |

---

#### getWanDetails(wanIface)
获取WAN详细配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| wanType | string | WAN类型 |
| ipaddr | string | IP地址（静态） |
| netmask | string | 子网掩码（静态） |
| gateway | string | 网关（静态） |
| username | string | 用户名（PPPoE） |
| password | string | 密码（PPPoE） |
| mtu | string | MTU值 |
| dns | table | DNS列表 |

---

### WAN类型设置

#### setWan4PPPoE(config)
设置WAN为PPPoE模式。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| username | string | PPPoE用户名 |
| password | string | PPPoE密码 |
| dns1 | string | DNS1 |
| dns2 | string | DNS2 |
| mtu | string | MTU值 |
| service | string | 服务名 |
| special | string | 特殊模式 |

**返回值：** `number` - 0=成功

---

#### setWan4Dhcp(config)
设置WAN为DHCP模式。

**返回值：** `number` - 0=成功

---

#### setWan4StaticIP(config)
设置WAN为静态IP模式。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| ip | string | IP地址 |
| mask | string | 子网掩码 |
| gw | string | 网关 |
| dns1 | string | DNS1 |
| dns2 | string | DNS2 |

**返回值：** `number` - 0=成功

---

### PPPoE控制

#### getPPPoEStatus(wanIface)
获取PPPoE连接状态。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| proto | string | 协议类型 |
| status | number | 0=断开，1=连接中，2=已连接，3=错误，4=已停止 |
| errcode | number | 错误码 |
| errtype | number | 错误类型 |
| ip | table | IP信息 |
| dns | table | DNS列表 |
| gw | string | 网关 |

---

#### pppoeStart(wanIface)
启动PPPoE连接。

---

#### pppoeStop(wanIface)
停止PPPoE连接。

---

### IPv6配置

#### setWan6(mode, dns1, dns2, ip6addr, ip6gw, ip6prefix, ip6prefixlen)
设置IPv6 WAN配置（旧版本）。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| mode | string | IPv6模式（native/nat/static/off） |
| dns1 | string | DNS1 |
| dns2 | string | DNS2 |
| ip6addr | string | IPv6地址（静态模式） |
| ip6gw | string | IPv6网关（静态模式） |
| ip6prefix | string | IPv6前缀 |
| ip6prefixlen | string | 前缀长度 |

---

#### setIpv6Firewall(enable)
设置IPv6防火墙。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| enable | string | "0"=关闭，"1"=开启 |

---

### 网络服务控制

#### wanRestart(wanIface, async, delay)
重启WAN接口。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| wanIface | string | WAN接口名 |
| async | boolean | 是否异步执行 |
| delay | number | 延迟秒数 |

---

#### wan6Restart(wan6Iface)
重启IPv6接口。

---

#### dnsmsqRestart(needRestart)
重启dnsmasq服务。

---

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.XQEvent | 事件处理 |
| xiaoqiang.util.XQErrorUtil | 错误码处理 |
| xiaoqiang.util.XQVPNUtil | VPN配置（国际版） |
| xiaoqiang.util.XQPortServiceUtil | 端口服务 |
| xiaoqiang.module.XQMultiWanPolicy | 多WAN策略 |
| luci.model.uci | UCI配置接口 |
| luci.util | LuCI工具函数 |
| luci.ip | IP地址处理 |
| luci.cbi.datatypes | 数据类型验证 |
| ubus | ubus通信 |
| nixio | 系统IO操作 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API控制器
- `xiaoqiang/controller/api/xqnetwork.lua` - 网络API控制器
- `xiaoqiang/util/XQNetUtil.lua` - 网络工具
- `xiaoqiang/util/XQDeviceUtil.lua` - 设备工具
- `xiaoqiang/module/XQBackup.lua` - 备份恢复

## 关键代码说明

### 私有IP地址验证

```lua
function checkLanIpMask(ipAddr, netmask)
    local LuciIP = require("luci.ip")
    local ipNum = LuciIP.iptonl(ipAddr)
    
    -- 10.0.0.0 - 10.255.255.255
    if ipNum >= LuciIP.iptonl("10.0.0.0") and ipNum <= LuciIP.iptonl("10.255.255.255") then
        return 0
    end
    
    -- 172.16.0.0 - 172.31.255.255
    if ipNum >= LuciIP.iptonl("172.16.0.0") and ipNum <= LuciIP.iptonl("172.31.255.255") then
        return 0
    end
    
    -- 192.168.0.0 - 192.168.255.255
    if ipNum >= LuciIP.iptonl("192.168.0.0") and ipNum <= LuciIP.iptonl("192.168.255.255") then
        return 0
    end
    
    return 1527
end
```

验证LAN IP必须在RFC 1918定义的私有地址范围内。

### PPPoE错误码分类

```lua
function _pppoeErrorCodeHelper(errorCode)
    -- 认证相关错误
    local authErrors = {
        ["507"] = 1, ["691"] = 1, ["509"] = 1, ["514"] = 1,
        ["520"] = 1, ["646"] = 1, ["647"] = 1, ["648"] = 1,
        ["649"] = 1, ["678"] = 1
    }
    
    -- 协议相关错误
    local protoErrors = {
        ["516"] = 1, ["650"] = 1, ["601"] = 1, ["510"] = 1,
        ["530"] = 1, ["531"] = 1
    }
```

将PPPoE错误码分类为认证错误、协议错误和其他错误，便于前端展示不同的错误提示。

### LAN IP变更联动

```lua
function hookLanIPChangeEvent(ipAddr, oldMask, newMask)
    -- 更新MAC绑定的IP地址
    cursor:foreach("macbind", "host", function(section)
        local oldIp = section.ip
        local suffix = oldIp:match(pattern)
        local newIp = ipPrefix .. suffix
        cursor:set("macbind", section[".name"], "ip", newIp)
    end)
    
    setDhcpCfg(ipAddr, oldMask, newMask)
end
```

LAN IP变更时自动更新MAC绑定和DHCP配置，保持网络配置一致性。
