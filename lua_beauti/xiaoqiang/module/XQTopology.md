# XQTopology.lua - 网络拓扑模块

## 概述

`XQTopology` 模块提供 Mesh 网络拓扑结构的获取和管理功能。该模块能够获取主路由器和所有子节点（AP、中继器）的详细信息，构建完整的网络拓扑图，支持新旧两种拓扑获取方式。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    Mesh网络拓扑架构                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    ┌──────────────┐                         │
│                    │   主路由器    │                         │
│                    │  (Mesh CAP)  │                         │
│                    └──────┬───────┘                         │
│                           │                                 │
│            ┌──────────────┼──────────────┐                  │
│            ▼              ▼              ▼                  │
│     ┌──────────┐   ┌──────────┐   ┌──────────┐             │
│     │  子节点1  │   │  子节点2  │   │  子节点3  │             │
│     │   (AP)   │   │   (AP)   │   │ (中继器) │             │
│     └────┬─────┘   └────┬─────┘   └──────────┘             │
│          │              │                                   │
│          ▼              ▼                                   │
│     ┌──────────┐   ┌──────────┐                            │
│     │  设备群  │   │  设备群  │                            │
│     └──────────┘   └──────────┘                            │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    数据来源                           │  │
│  │  • ubus call xq_info_sync_mqtt child_list (新版)     │  │
│  │  • ubus call trafficd hw '{\"tree\":true}' (旧版)    │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### topologicalGraph()

获取完整的网络拓扑图。

**参数:** 无

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| ip | string | 主路由器 LAN IP |
| name | string | 路由器名称 |
| locale | string | 地区信息 |
| hardware | string | 硬件型号 |
| channel | string | 渠道信息 |
| mode | number | 工作模式 (0=路由, 1=AP) |
| color | number | 信号强度颜色指示 |
| ssid | string | WiFi SSID |
| onlines | number | 在线设备数 (Mesh CAP) |
| leafs | table | 子节点列表 |
| renumber | number | 重编号标记 |

**子节点 (leafs) 字段:**
| 字段 | 类型 | 说明 |
|------|------|------|
| ip | string | 节点 IP 地址 |
| name | string | 节点名称 |
| locale | string | 地区信息 |
| hardware | string | 硬件型号 |
| channel | string | 渠道信息 |
| mode | number | 工作模式 |
| version | string | 固件版本 |
| ssid | string | WiFi SSID |
| color | number | 信号强度指示 |
| signal | string | 信号强度 (新版) |
| link_type | string | 连接类型 (新版) |
| internet | string | 网络状态 (新版) |
| onlines | number | 在线设备数 |
| leafs | table | 下级子节点 |

---

### simpleTopoGraph()

获取简化的拓扑图（仅包含 MAC 地址信息）。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| mac | string | 2.4G BSSID |
| mac5G | string | 5G BSSID |
| leafs | table | 子节点列表 |

---

### meshChildList()

获取 Mesh 子节点列表（原始数据）。

**返回值:** table - 子节点原始 JSON 数据

---

### _recursive(nodeData) [内部函数]

递归解析子节点信息。

**参数:** nodeData - 节点原始数据

**返回值:** table - 解析后的节点信息

---

### _simpleRecursive(nodeData) [内部函数]

简化的递归解析（仅获取 MAC 地址）。

**返回值:** table/nil - 节点信息或 nil

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| cjson | JSON 解析 |
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.util.XQSysUtil | 系统工具 |
| xiaoqiang.util.XQLanWanUtil | LAN/WAN 工具 |
| xiaoqiang.util.XQWifiUtil | WiFi 工具 |
| xiaoqiang.util.XQDeviceUtil | 设备工具 |
| xiaoqiang.util.XQCryptoUtil | 加密工具 |
| luci.util | LuCI 工具函数 |

## 被引用情况

- Mesh 网络管理 API
- 网络拓扑展示页面
- 移动端 APP 网络拓扑功能
- 设备管理功能

## 关键代码说明

### 新旧拓扑获取方式

```lua
local supportNewTopo = XQSysUtil.isSupportNewTopo()
if supportNewTopo == 1 then
    if XQFunction.isMeshCap() then
        childListJson = luciUtil.exec("ubus call xq_info_sync_mqtt child_list")
        isMeshCap = true
    end
else
    childListJson = luciUtil.exec("ubus call trafficd hw '{\"tree\":true}'")
end
```

模块支持两种拓扑获取方式：
- 新版：通过 `xq_info_sync_mqtt` 服务获取 Mesh 子节点
- 旧版：通过 `trafficd` 服务获取硬件树结构

### 小米中继器名称处理

```lua
local lowerName = string.lower(nodeInfo.name)
if lowerName:match("^xiaomirepeater") then
    nodeInfo.name = "小米中继器"
end
```

对小米中继器设备进行特殊名称处理，统一显示为中文名称。

### IP 地址选择逻辑

```lua
for _, ipInfo in ipairs(nodeData.ip_list) do
    if ipInfo.ageing_timer <= 300 then
        if ipInfo.tx_bytes == 0 and ipInfo.rx_bytes == 0 then
            goto continue
        end
        nodeInfo.ip = ipInfo.ip
        break
    end
    ::continue::
end
```

从 IP 列表中选择有效的 IP 地址，条件包括：
- 老化时间在 300 秒以内
- 有实际的收发流量

### Description 字段解析

子节点的详细信息（hardware、channel、color、ssid、ip、locale）存储在 `description` 字段中，以 JSON 格式编码，需要解析后提取。
