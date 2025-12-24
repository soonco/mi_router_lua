# XQVLANServiceUtil.lua - VLAN服务工具模块

## 概述

`XQVLANServiceUtil.lua` 是小米路由器的VLAN服务配置管理模块，主要用于IPTV、VoIP等多媒体服务的VLAN配置。支持Internet、IPTV、VoIP、Bridge四种类型的VLAN配置，实现运营商IPTV和VoIP业务的透传。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                   XQVLANServiceUtil 模块                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    VLAN 服务类型                          │    │
│  ├─────────────┬─────────────┬─────────────┬──────────────┤    │
│  │  Internet   │    IPTV     │    VoIP     │   Bridge     │    │
│  │  互联网流量  │  电视业务    │  语音业务    │  透明桥接     │    │
│  └──────┬──────┴──────┬──────┴──────┬──────┴──────┬───────┘    │
│         │             │             │             │             │
│         ▼             ▼             ▼             ▼             │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                 VLAN 标签配置                            │    │
│  │  VID (VLAN ID): 0-4095 | Priority: 0-7                  │    │
│  │  WAN Egress Tag | LAN Egress Tag                        │    │
│  └─────────────────────────────────────────────────────────┘    │
│                          │                                       │
│                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              UCI 配置 (vlan_service)                     │    │
│  │  - service: Internet/Multimedia 启用状态                 │    │
│  │  - type: iptv/voip/internet/bridge 参数                 │    │
│  │  - interface: 各接口的VLAN类型分配                       │    │
│  └─────────────────────────────────────────────────────────┘    │
│                          │                                       │
│                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │            vlan_service.sh 脚本执行                      │    │
│  │            (同步/异步重启VLAN服务)                        │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘

VLAN 数据流:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│   WAN    │───▶│ VLAN标签  │───▶│  路由器   │───▶│   LAN    │
│ 运营商网络 │    │ 识别/剥离 │    │ 流量分发  │    │ IPTV盒子 │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
                     │
                     ▼
              ┌──────────┐
              │ VID匹配   │
              │ 优先级处理 │
              └──────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getVlanService()` | 无 | `table` | 获取当前VLAN服务配置 |
| `setVlanService(config, async)` | `config: table, async: boolean` | `boolean` | 设置VLAN服务配置 |
| `validate_vlanid(vlanId)` | `vlanId: number` | `boolean` | 验证VLAN ID有效性 (-1~4095) |
| `validate_priority(priority)` | `priority: number` | `boolean` | 验证优先级有效性 (-1~7) |
| `check_vid_conflict(config)` | `config: table` | `boolean` | 检查VID冲突 |
| `vlan_service_changed(config)` | `config: table` | `boolean\|nil` | 检查配置是否变更 |

### 配置结构说明

#### getVlanService 返回结构
```lua
{
    service = {
        Internet = {
            enable = 0,     -- 0=禁用, 1=启用
            profile = 0     -- 配置文件编号
        },
        Multimedia = {
            enable = 0,     -- 0=禁用, 1=启用
            profile = 0     -- 配置文件编号
        }
    },
    type = {
        iptv = {
            vid = -1,           -- VLAN ID (-1表示不使用)
            priority = -1,      -- 802.1p优先级
            wan_egress_tag = 1, -- WAN出口是否打标签
            lan_egress_tag = 0  -- LAN出口是否打标签
        },
        voip = {
            vid = -1,
            priority = -1,
            wan_egress_tag = 1,
            lan_egress_tag = 0
        },
        internet = {
            vid = -1,
            priority = -1,
            wan_egress_tag = 1,
            lan_egress_tag = 0
        },
        bridge = {
            vid = -1,
            priority = -1,
            wan_egress_tag = 1,
            lan_egress_tag = 0
        }
    },
    interface = {
        -- 各物理接口的VLAN类型分配
        -- 例如: lan1 = "iptv", lan2 = "internet"
    }
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.model.uci` | UCI配置接口 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.common.XQFunction` | 通用工具函数（异步执行） |

## 被引用情况

该模块被以下模块引用：
- `luci/controller/api/xqnetwork.lua` - 网络API控制器
- IPTV配置相关的Web界面

## 关键代码说明

### VLAN ID验证
```lua
function validate_vlanid(vlanId)
    if nil == vlanId then
        return false
    end
    -- -1 表示不使用VLAN，0-4095为有效VLAN ID
    if -1 <= vlanId and vlanId <= 4095 then
        return true
    end
    return false
end
```

### 优先级验证
```lua
function validate_priority(priority)
    if nil == priority then
        return false
    end
    -- -1 表示不设置优先级，0-7为802.1p有效优先级
    if -1 <= priority and priority <= 7 then
        return true
    end
    return false
end
```

### VID冲突检查
```lua
function check_vid_conflict(config)
    -- 检查Internet、IPTV、VoIP的VID是否冲突
    -- 当多个服务启用时，不允许使用相同的VID
    local internetVid = config.type.internet.vid
    local iptvVid = config.type.iptv.vid
    local voipVid = config.type.voip.vid
    
    -- 如果两个服务都启用且VID相同（非-1），则冲突
    ...
end
```

### 配置应用
```lua
function setVlanService(config, async)
    -- 1. 检查配置是否变更
    local changed = vlan_service_changed(config)
    if not changed then
        return true  -- 无变更，直接返回
    end
    
    -- 2. 验证所有参数
    if check_vid_conflict(config) then return false end
    if not validate_vlanid(config.type.internet.vid) then return false end
    -- ... 更多验证
    
    -- 3. 写入UCI配置
    uciCursor:set("vlan_service", "Internet", "enable", ...)
    uciCursor:set("vlan_service", "iptv", "vid", ...)
    -- ... 更多配置
    
    -- 4. 提交配置
    uciCursor:save("vlan_service")
    uciCursor:commit("vlan_service")
    
    -- 5. 重启VLAN服务
    if async then
        XQFunction.forkExec("vlan_service.sh restart true")
    else
        os.execute("vlan_service.sh restart false")
    end
    
    return true
end
```

## 使用示例

```lua
local XQVLANServiceUtil = require("xiaoqiang.util.XQVLANServiceUtil")

-- 获取当前配置
local config = XQVLANServiceUtil.getVlanService()

-- 启用IPTV服务
config.service.Multimedia.enable = 1
config.type.iptv.vid = 85        -- 运营商指定的VLAN ID
config.type.iptv.priority = 4    -- 优先级
config.interface.lan4 = "iptv"   -- LAN4口用于IPTV

-- 应用配置（异步）
local success = XQVLANServiceUtil.setVlanService(config, true)
```

## 典型应用场景

### IPTV配置
运营商通常要求特定的VLAN ID用于IPTV业务：
- 电信: VID 通常为 85
- 联通: VID 通常为 85 或 51
- 移动: VID 通常为 4085

### VoIP配置
语音业务通常需要更高的优先级：
- VID: 运营商指定
- Priority: 5-7（高优先级）
