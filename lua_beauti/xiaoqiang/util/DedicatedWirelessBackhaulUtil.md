# DedicatedWirelessBackhaulUtil.lua - 专用无线回程工具模块

## 概述

`DedicatedWirelessBackhaulUtil.lua` 是小米路由器的专用无线回程（DWB - Dedicated Wireless Backhaul）管理模块，用于Mesh网络中节点间的专用无线通信。DWB将用户连接的WiFi频段与节点间回程通信的频段分离，提高Mesh网络的整体性能和稳定性。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                DedicatedWirelessBackhaulUtil 模块                │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    DWB 概念说明                          │    │
│  │                                                           │    │
│  │  ┌─────────┐         ┌─────────┐         ┌─────────┐    │    │
│  │  │  主路由  │◄──DWB──►│  子节点  │◄──DWB──►│  子节点  │    │    │
│  │  │  (CAP)  │  5GHz-H │  (RE)   │  5GHz-H │  (RE)   │    │    │
│  │  └────┬────┘         └────┬────┘         └────┬────┘    │    │
│  │       │                   │                   │          │    │
│  │       ▼                   ▼                   ▼          │    │
│  │  ┌─────────┐         ┌─────────┐         ┌─────────┐    │    │
│  │  │ 用户设备 │         │ 用户设备 │         │ 用户设备 │    │    │
│  │  │ 2.4G/5G │         │ 2.4G/5G │         │ 2.4G/5G │    │    │
│  │  └─────────┘         └─────────┘         └─────────┘    │    │
│  │                                                           │    │
│  │  前端频段(Fronthaul): 2.4GHz/5GHz - 用户设备连接          │    │
│  │  回程频段(Backhaul):  5GHz-H      - 节点间通信            │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    功能模块                              │    │
│  ├─────────────┬─────────────┬─────────────┬──────────────┤    │
│  │ is_supported│ get_dwb_band│get_dwb_status│set_dwb_status│    │
│  │  支持检测    │  频段获取    │  状态获取    │  状态设置     │    │
│  └─────────────┴─────────────┴─────────────┴──────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘

DWB 连接类型:
┌──────────────────────────────────────────────────────────────┐
│  Type 0: 无连接                                               │
│  Type 1: 有线回程 (Ethernet Backhaul)                         │
│  Type 2: 无线回程 (Wireless Backhaul / DWB)                   │
└──────────────────────────────────────────────────────────────┘

频段分配示例 (三频路由器):
┌──────────────────────────────────────────────────────────────┐
│  Band 1 (wifi0): 2.4GHz  - 前端频段 (用户设备)                │
│  Band 2 (wifi1): 5GHz    - 前端频段 (用户设备)                │
│  Band 3 (wifi2): 5GHz-H  - 回程频段 (DWB专用)                 │
└──────────────────────────────────────────────────────────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `is_supported()` | 无 | `boolean` | 检查是否支持DWB功能 |
| `mesh_get_dwb_band()` | 无 | `number` | 获取DWB使用的频段编号 |
| `get_dwb_wifinet()` | 无 | `wifinet\|nil` | 获取DWB的WiFi网络接口对象 |
| `mesh_get_dwb_status()` | 无 | `string\|nil` | 获取DWB状态 |
| `mesh_set_dwb_status(status)` | `status: string` | `number` | 设置DWB状态 |
| `mesh_get_dwb_type()` | 无 | `number` | 获取DWB连接类型 |
| `mesh_set_dwb_ssid_channge(flag)` | `flag: string` | 无 | 设置DWB SSID变更标志 |
| `mesh_get_dwb_bsd_channge()` | 无 | `string\|nil` | 获取DWB SSID变更标志 |
| `mesh_sync_dwb_ssid(old_config, new_config, bsd_status)` | 见下 | 无 | 同步DWB SSID配置 |

### 参数说明

#### mesh_set_dwb_status
- `status: "0"` - 禁用DWB
- `status: "1"` - 启用DWB

#### mesh_get_dwb_type 返回值
- `0` - 无连接
- `1` - 有线回程
- `2` - 无线回程

#### mesh_sync_dwb_ssid 参数
- `old_config` - 旧的WiFi配置表
- `new_config` - 新的WiFi配置表
- `bsd_status` - 双频合一状态

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.model.uci` | UCI配置接口 |
| `luci.model.network` | 网络模型 |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具（获取接口名称列表） |
| `xiaoqiang.common.XQFunction` | 通用工具函数（Mesh模式检测） |
| `ubus` | ubus通信（获取Mesh节点信息） |

### UCI配置
- `misc.wireless.ifname_dwb` - DWB接口名称配置

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang/util/XQWifiUtil.lua` - WiFi工具模块
- Mesh网络配置相关的Web界面和API

## 关键代码说明

### DWB支持检测
```lua
function is_supported()
    -- 检查misc配置中是否定义了DWB接口
    if dwb_ifname then
        return true
    else
        return false
    end
end
```

### DWB频段获取
```lua
function mesh_get_dwb_band()
    -- 遍历无线接口列表，找到DWB接口对应的频段编号
    for i = 1, #wlan_ifnames do
        if wlan_ifnames[i] == dwb_ifname then
            return i  -- 返回频段编号 (2=5GHz, 3=5GHz-H)
        end
    end
    return 0
end
```

### DWB状态获取（区分主节点和子节点）
```lua
function mesh_get_dwb_status()
    local wifinet = get_dwb_wifinet()
    local status = "0"
    
    if wifinet == nil then
        return nil
    end
    
    -- Mesh子节点(RE)的DWB状态取决于接口是否禁用
    if XQFunction.isMeshRe() then
        local disabled = wifinet:get("disabled")
        if disabled ~= "1" then
            status = "1"  -- 接口启用 = DWB启用
        else
            status = "0"  -- 接口禁用 = DWB禁用
        end
    else
        -- Mesh主节点直接读取dwb_status配置
        status = wifinet:get("dwb_status")
    end
    
    return status
end
```

### DWB连接类型检测
```lua
function mesh_get_dwb_type()
    local ubus = require("ubus")
    local wired_count = 0
    
    -- 通过ubus获取Mesh节点信息
    local conn = ubus.connect(nil)
    local mesh_info = conn:call("xq_info_sync_mesh", "get_mesh_info", {})
    conn:close()
    
    -- 遍历节点检查连接类型
    for _, node in pairs(mesh_info) do
        if node.link_type ~= nil then
            if node.link_type == "wired" then
                wired_count = wired_count + 1
            else
                return 2  -- 存在无线连接的节点
            end
        end
    end
    
    if wired_count == 0 then
        return 0  -- 无连接
    else
        return 1  -- 有线回程
    end
end
```

### SSID同步逻辑
```lua
function mesh_sync_dwb_ssid(old_config, new_config, bsd_status)
    -- 当主WiFi SSID变更时，需要同步更新DWB配置
    
    local dwb_band = mesh_get_dwb_band()
    local dwb_status = mesh_get_dwb_status()
    
    -- 确定前端频段（与DWB频段不同的频段）
    local front_band = 2
    if dwb_band == 3 then
        front_band = 2
    elseif dwb_band == 2 then
        front_band = 3
    end
    
    -- 如果DWB已启用但新配置中关闭了该频段，需要同步关闭
    if new_config[dwb_band] then
        if new_config[dwb_band].on == 1 and dwb_status ~= "1" then
            new_config[dwb_band].on = 0
        end
    end
    
    -- 检查双频合一状态变化
    if old_config[1].bsd ~= bsd_status then
        mesh_set_dwb_ssid_channge("0")
        return
    end
    
    -- 检查SSID是否变更
    if new_config[front_band] then
        if old_config[front_band].ssid ~= new_config[front_band].ssid then
            mesh_set_dwb_ssid_channge("1")
        end
    end
end
```

## 使用示例

```lua
local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")

-- 检查是否支持DWB
if DWBUtil.is_supported() then
    print("支持专用无线回程")
    
    -- 获取DWB频段
    local band = DWBUtil.mesh_get_dwb_band()
    print("DWB使用频段: " .. band)
    
    -- 获取DWB状态
    local status = DWBUtil.mesh_get_dwb_status()
    print("DWB状态: " .. (status == "1" and "启用" or "禁用"))
    
    -- 获取连接类型
    local connType = DWBUtil.mesh_get_dwb_type()
    local typeNames = {[0]="无连接", [1]="有线回程", [2]="无线回程"}
    print("连接类型: " .. typeNames[connType])
    
    -- 启用DWB
    DWBUtil.mesh_set_dwb_status("1")
else
    print("不支持专用无线回程")
end
```

## Mesh网络架构

```
                    Internet
                        │
                        ▼
                ┌───────────────┐
                │   主路由(CAP)  │
                │   有线连接     │
                └───────┬───────┘
                        │
           ┌────────────┼────────────┐
           │            │            │
           ▼            ▼            ▼
    ┌──────────┐  ┌──────────┐  ┌──────────┐
    │ 子节点RE1 │  │ 子节点RE2 │  │ 子节点RE3 │
    │ DWB无线  │  │ DWB无线  │  │ 有线回程  │
    └──────────┘  └──────────┘  └──────────┘
```

## 注意事项

1. DWB功能需要三频路由器支持（2.4GHz + 5GHz + 5GHz-H）
2. 主节点(CAP)和子节点(RE)的DWB状态获取逻辑不同
3. 修改主WiFi SSID时需要同步更新DWB配置
4. DWB频段通常使用5GHz高频段，与用户设备使用的频段分离
