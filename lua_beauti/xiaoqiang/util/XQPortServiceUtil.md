# XQPortServiceUtil.lua - 端口服务工具模块

## 概述

路由器物理端口服务管理工具模块，提供WAN/LAN端口模式切换、IPTV端口配置、链路聚合(LAG)配置、多WAN策略配置、游戏端口配置、WAN VLAN标签配置等功能。是路由器端口管理的核心模块。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   API控制器      | --> | XQPortServiceUtil| --> |   port_service   |
|  (端口配置)      |     |  (配置管理)      |     |  (底层服务)      |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    接收配置请求           验证和处理参数           执行端口配置
         |                       |                       |
         v                       v                       v
    返回配置结果           更新UCI配置            重启端口服务
```

### 端口服务架构

```
                    +------------------+
                    | XQPortServiceUtil|
                    +------------------+
                           |
    +----------+-----------+-----------+-----------+
    |          |           |           |           |
    v          v           v           v           v
+-------+  +-------+  +-------+  +-------+  +-------+
|  WAN  |  | IPTV  |  |  LAG  |  | Multi |  | Game  |
| 服务  |  | 服务  |  | 服务  |  |  WAN  |  | 服务  |
+-------+  +-------+  +-------+  +-------+  +-------+
    |          |           |           |           |
    v          v           v           v           v
+-------+  +-------+  +-------+  +-------+  +-------+
| 固定  |  | 桥接  |  | 聚合  |  | 负载  |  | 游戏  |
| 自动  |  | VLAN  |  | 模式  |  | 均衡  |  | 加速  |
+-------+  +-------+  +-------+  +-------+  +-------+
```

### WAN模式

```
+------------------+     +------------------+     +------------------+
|  WAN_MODE_FIXED  |     |  WAN_MODE_WANDT  |     |  WAN_MODE_LAN    |
|     (1)          |     |     (2)          |     |     (3)          |
+------------------+     +------------------+     +------------------+
        |                        |                        |
        v                        v                        v
    固定WAN口              自动检测WAN口            LAN口模式
    手动指定端口           动态检测链路            无WAN功能
```

## 接口列表

### 端口映射查询

#### psGetMap()
获取端口映射信息。

**返回值：** `table` - 端口映射表 {index => {port, index, speed, service, label}}

---

#### psGetMapDesc()
获取端口映射描述。

**返回值：** `string` - 描述信息

---

### 服务控制

#### psReload()
重新加载端口服务。

**返回值：** `boolean` - 是否成功

---

#### psRestart(serviceName)
重启端口服务。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| serviceName | string | 否 | 服务名称 |

**返回值：** `boolean` - 是否成功

---

### 冲突检测

#### psIsVidConflict(vid, excludeVid)
检查VID是否冲突。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| vid | number | 待检查的VID |
| excludeVid | number | 排除的VID |

**返回值：** `boolean` - 是否冲突

---

#### psIsPortConflict(ports, serviceName)
检查端口是否冲突。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| ports | string | 待检查的端口字符串 |
| serviceName | string | 当前服务名称 |

**返回值：** `boolean` - 是否冲突

---

### WAN链路模式

#### psSetWanLinkMode(serviceName, linkMode)
设置WAN链路模式。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| serviceName | string | 服务名称 |
| linkMode | number | 链路模式 |

**返回值：** `boolean` - 是否成功

---

#### psGetWanLinkMode(serviceName)
获取WAN链路模式。

**返回值：** `number` - 链路模式（0=自动）

---

#### psGetWanSpeed(serviceName)
获取WAN端口速度。

**返回值：** `string` - 端口速度（如"1G", "2.5G"）

---

### 功能启用状态

#### psWandtEnable()
检查WAN自动检测是否启用。

**返回值：** `number` - 0=禁用，1=启用

---

#### psMultiwanEnable()
检查多WAN是否启用。

**返回值：** `number` - 0=禁用，1=启用

---

#### psIptvBridgeEnable()
检查IPTV桥接模式是否启用。

**返回值：** `number` - 0=禁用，1=启用

---

### WAN自动检测配置

#### wandtGetConfig()
获取WAN自动检测配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| enable | number | 是否启用 |
| wan_port | number | WAN端口号 |
| index | number | 端口索引 |

---

#### wandtSetConfig(config)
设置WAN自动检测配置。

**返回值：** `boolean, number` - 是否成功，错误码

---

#### wandtEnable(serviceName)
检查指定服务的WAN自动检测是否启用。

**返回值：** `boolean` - 是否启用

---

#### wanRedetect()
强制重新检测WAN。

---

### 链路聚合(LAG)配置

#### lagGetConfig()
获取LAG配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| enable | number | 是否启用 |
| ports | string | 聚合端口 |
| mode | number | 聚合模式 |
| status | number | 状态码 |
| info | string | 状态信息 |

---

#### lagSetConfig(config)
设置LAG配置。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| enable | number | 是否启用 |
| ports | string | 聚合端口 |
| mode | number | 聚合模式 |

**返回值：** `boolean, number` - 是否成功，错误码

---

### IPTV配置

#### iptvGetConfig()
获取IPTV配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| enable | number | 是否启用 |
| ports | string | IPTV端口 |
| profile | number | 配置模板 |
| vid | number | VLAN ID |
| priority | number | 优先级 |
| forbid_vid | string | 禁止的VID |
| permit_vid | string | 允许的VID范围 |

---

#### iptvSetConfig(config)
设置IPTV配置。

**返回值：** `boolean, number` - 是否成功，错误码

---

### WAN端口配置

#### wanGetConfig()
获取WAN配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| wan_port | number | WAN端口号 |
| wan_label | string | WAN端口标签 |
| mode | number | WAN模式（1=固定，2=自动，3=LAN） |

---

#### wanSetConfig(config)
设置WAN配置。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| enable | number | 是否启用 |
| wandt | number | 自动检测 |
| ports | string | 端口 |
| mode | number | WAN模式 |

**返回值：** `boolean, number` - 是否成功，错误码

---

### WAN VLAN标签配置

#### wantagGetConfig(request)
获取WAN VLAN标签配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| interface | string | 接口名称 |
| profile | number | 配置模板 |
| vid | number | VLAN ID |
| priority | number | 优先级 |
| forbid_vid | string | 禁止的VID |
| permit_vid | string | 允许的VID范围 |

---

#### wantagSetConfig(config)
设置WAN VLAN标签配置。

**返回值：** `boolean` - 是否成功

---

### 统一服务接口

模块导出`ps`对象，提供统一的服务配置接口：

```lua
ps.wandt.getConfig()
ps.wandt.setConfig(config)
ps.wandt.analyConfig(request)

ps.lag.getConfig()
ps.lag.setConfig(config)
ps.lag.analyConfig(request)

ps.iptv.getConfig()
ps.iptv.setConfig(config)
ps.iptv.analyConfig(request)

ps.wan.getConfig()
ps.wan.setConfig(config)
ps.wan.analyConfig(request)

ps.multiwan.getConfig()
ps.multiwan.setConfig(config)
ps.multiwan.analyConfig(request)

ps.game.getConfig()
ps.game.setConfig(config)
ps.game.analyConfig(request)
```

## WAN模式常量

| 常量 | 值 | 说明 |
|------|-----|------|
| WAN_MODE_FIXED | 1 | 固定WAN口 |
| WAN_MODE_WANDT | 2 | 自动检测WAN口 |
| WAN_MODE_LAN | 3 | LAN口模式（无WAN） |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| luci.util | LuCI工具函数 |
| luci.model.uci | UCI配置接口 |
| xiaoqiang.XQLog | 日志记录 |
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.XQFeatures | 功能特性检测 |
| xiaoqiang.module.XQMultiWanPolicy | 多WAN策略 |
| xiaoqiang.util.XQCwmpUtil | TR-069配置 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API控制器
- `xiaoqiang/controller/api/xqnetwork.lua` - 网络API控制器
- `xiaoqiang/util/XQLanWanUtil.lua` - LAN/WAN工具

## 关键代码说明

### 端口冲突检测

```lua
function psIsPortConflict(ports, serviceName)
    local portUsage = {}
    local usedPorts = ""
    
    -- 收集已使用的端口
    uciCursor:foreach(PORT_SERVICE_CONFIG, "service", function(section)
        if serviceName == section[".name"] then
            return  -- 跳过当前服务
        end
        
        if section.enable == "1" then
            usedPorts = usedPorts .. string.gsub(section.ports, "%s+", "")
        end
    end)
    
    -- 标记已使用端口
    for i = 1, string.len(usedPorts) do
        portIndex = tonumber(string.sub(usedPorts, i, i))
        if portIndex ~= nil then
            portUsage[portIndex + 1] = 1
        end
    end
    
    -- 检查新端口是否冲突
    for i = 1, string.len(ports) do
        portIndex = tonumber(string.sub(ports, i, i))
        if portUsage[portIndex + 1] ~= 0 then
            return true  -- 冲突
        end
    end
    
    return false
end
```

### WAN模式处理

```lua
function wanAnalyConfig(request)
    local modeHandlers = {}
    
    modeHandlers[WAN_MODE_FIXED] = function(port)
        if psIsPortConflict(port, "wan") then
            return nil
        end
        return {
            enable = 1,
            wandt = 0,
            ports = port,
            mode = WAN_MODE_FIXED
        }
    end
    
    modeHandlers[WAN_MODE_WANDT] = function()
        return {
            enable = 1,
            wandt = 1,
            ports = "",
            mode = WAN_MODE_WANDT
        }
    end
    
    modeHandlers[WAN_MODE_LAN] = function()
        return {
            enable = 0,
            wandt = 0,
            ports = "",
            mode = WAN_MODE_LAN
        }
    end
    
    return modeHandlers[mode](wanPort)
end
```

### 多WAN策略联动

```lua
function wanSetConfig(config)
    -- 更新端口服务配置
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "enable", config.enable)
    uciCursor:set(PORT_SERVICE_CONFIG, "wan", "wandt", config.wandt)
    uciCursor:commit(PORT_SERVICE_CONFIG)
    
    psRestart("wan")
    
    -- 联动多WAN策略
    if features.system.multiwan == "1" then
        if config.enable == 0 then
            XQMultiWanPolicy.setEnable("0")
        elseif wan2Enable == 0 then
            XQMultiWanPolicy.setEnable("0")
        else
            XQMultiWanPolicy.setEnable("1")
        end
    end
end
```

WAN配置变更时自动同步多WAN策略状态，保持配置一致性。
