# XQRouterStatus.lua - 路由器状态模块

## 概述

`XQRouterStatus` 模块提供路由器各种状态信息的查询功能，包括 USB 设备状态、WAN 口网络状态、在线设备状态等。该模块采用函数映射表设计，支持灵活的状态查询方式。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    路由器状态查询架构                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    ┌──────────────┐                         │
│                    │  getStatus() │                         │
│                    │   统一入口    │                         │
│                    └──────┬───────┘                         │
│                           │                                 │
│            ┌──────────────┼──────────────┐                  │
│            ▼              ▼              ▼                  │
│     ┌──────────┐   ┌──────────┐   ┌──────────┐             │
│     │usb_status│   │wan_status│   │dev_status│             │
│     │ USB状态  │   │ WAN状态  │   │ 设备状态 │             │
│     └────┬─────┘   └────┬─────┘   └────┬─────┘             │
│          │              │              │                    │
│          ▼              ▼              ▼                    │
│     ┌──────────┐   ┌──────────┐   ┌──────────┐             │
│     │ Thrift   │   │ Device   │   │ Device   │             │
│     │ 数据中心 │   │  Util    │   │  Util    │             │
│     └──────────┘   └──────────┘   └──────────┘             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### getStatus(statusTypes)

获取路由器状态信息（公开接口）。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| statusTypes | table/nil | 要获取的状态类型列表，nil 表示获取所有状态 |

**返回值:**
| 类型 | 说明 |
|------|------|
| table | 包含请求的状态信息 |

**可用状态类型:**
- `usb_status`: USB 设备状态
- `wan_status`: WAN 口状态
- `dev_status`: 在线设备状态

---

### usb_status() [内部函数]

获取 USB 设备状态信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| extdisk | number | 外接磁盘存在状态 (0=不存在, 1=存在) |
| status | number | 数据迁移状态 (-1=错误, 0=无迁移, 其他=迁移中) |
| progress | number | 迁移进度百分比 |

---

### wan_status() [内部函数]

获取 WAN 口网络状态。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| speed | number | 当前下载速度 (bytes/s) |
| maxspeed | number | 最大下载速度 (bytes/s) |

---

### dev_status() [内部函数]

获取在线设备状态。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| online | number | 在线设备数量 |
| all | number | 总设备数量 |
| online_without_mash | number | 不含 Mesh 节点的在线设备数 |
| all_without_mash | number | 不含 Mesh 节点的总设备数 |

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| luci.util | LuCI 工具函数 |
| xiaoqiang.common.XQFunction | 通用工具函数（Thrift 通信） |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.util.XQDeviceUtil | 设备信息工具 |

## 被引用情况

- 首页状态展示 API
- 系统监控页面
- 移动端 APP 状态查询接口

## 关键代码说明

### 函数映射表设计

```lua
local STATUS_FUNCTIONS = {
    usb_status = usb_status,
    wan_status = wan_status,
    dev_status = dev_status
}
```

使用函数映射表实现状态查询的解耦，便于扩展新的状态类型。

### Thrift 数据中心通信

```lua
local checkResult = XQFunction.thrift_tunnel_to_datacenter('{"api":1}')
-- api:1 - 检查外接磁盘
-- api:62 - 获取迁移状态
```

USB 状态通过 Thrift 协议与数据中心服务通信，获取外接存储设备的详细信息。

### Mesh 设备统计

模块区分了包含和不包含 Mesh 节点的设备统计，便于在不同场景下展示准确的设备数量。
