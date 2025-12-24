# XQStorage.lua - 存储模块

## 概述

`XQStorage` 模块提供外部存储设备管理功能，包括 USB 存储设备的挂载/卸载、Samba 文件共享服务配置、Swap 交换空间管理、内存信息查询等。该模块是路由器存储管理的核心组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                      存储管理架构                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    XQStorage 模块                     │  │
│  └──────────────────────────────────────────────────────┘  │
│         │              │              │              │      │
│         ▼              ▼              ▼              ▼      │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌─────────┐  │
│  │ 设备管理 │   │  Samba   │   │   Swap   │   │ 内存    │  │
│  │ 挂载卸载 │   │ 文件共享 │   │ 交换空间 │   │ 信息    │  │
│  └──────────┘   └──────────┘   └──────────┘   └─────────┘  │
│         │              │              │              │      │
│         ▼              ▼              ▼              ▼      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    系统命令/配置                      │  │
│  │  /usr/sbin/storage  /etc/init.d/samba  /usr/sbin/swap │  │
│  │  /tmp/etc/storage   /etc/config/samba  /etc/config/swap│  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 存储设备管理

#### getStorageDeviceList()

获取所有存储设备及分区列表。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| [].sid | string | 设备 section ID |
| [].vendor | string | 设备厂商 |
| [].model | string | 设备型号 |
| [].partitionList | table | 分区列表 |
| [].partitionList[].name | string | 分区名称 |
| [].partitionList[].path | string | 挂载路径 |
| [].partitionList[].uuid | string | 分区 UUID |
| [].partitionList[].fstype | string | 文件系统类型 |
| [].partitionList[].capacity | string | 总容量 (如 "100.0GB") |
| [].partitionList[].used | string | 已用空间 |
| [].partitionList[].available | string | 可用空间 |
| [].partitionList[].width | string | 使用率百分比 |

---

#### getStorageInfoByUuid(uuid)

根据 UUID 获取存储分区信息。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| uuid | string | 分区 UUID |

**返回值:** table/nil - 分区信息或 nil

---

#### getStorageMountPathByUuid(uuid)

根据 UUID 获取挂载路径。

**参数/返回值:** string/nil - 挂载路径

---

#### getStorageUuidByMountPath(mountPath)

根据挂载路径获取 UUID。

**参数/返回值:** string/nil - UUID

---

#### umountStorageDevice(partitionName)

卸载指定分区。

**返回值:** 0=成功, 1502=参数错误, 1523=分区不存在

---

#### umountAllStorageDevices()

卸载所有存储设备。

**返回值:** 0=成功

---

### Samba 服务管理

#### getSambaStatus()

获取 Samba 服务状态。

**返回值:** string - "0"=禁用, "1"=启用

---

#### setSambaStatus(enabled)

设置 Samba 服务状态。

**参数:** enabled - "0"/"1"

**返回值:** 0=成功

---

#### getSambaName()

获取 Samba 共享名称。

**返回值:** string - 共享名称

---

### Swap 交换空间管理

#### getSwapInfo()

获取 Swap 配置信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| uuid | string | 绑定的存储分区 UUID |
| size | string | Swap 大小 |
| exist | number | 存储设备是否存在 (0/1) |

---

#### setSwapInfo(uuid, size)

设置 Swap 配置。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| uuid | string | 存储分区 UUID |
| size | number | Swap 大小 |

**返回值:** 0=成功

---

#### delSwap(uuid)

删除 Swap 配置。

**返回值:** 0=成功, 1502=参数错误, 1523=UUID 不匹配

---

### 内存信息

#### getMemInfo()

获取内存和 Swap 使用信息。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| memtotal | number | 总内存 (MB) |
| memused | number | 已用内存 (MB) |
| swaptotal | number | Swap 总量 (MB) |
| swapused | number | Swap 已用 (MB) |

---

#### getMemTotal()

获取总内存大小。

**返回值:** number - 内存大小 (MB)

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.XQLog | 日志模块 |
| luci.util | LuCI 工具函数 |
| luci.model.uci | UCI 配置管理 |
| /usr/sbin/storage | 存储管理命令 |
| /usr/sbin/swap | Swap 管理命令 |
| /etc/init.d/samba | Samba 服务脚本 |
| /tmp/etc/storage | 存储配置临时目录 |

## 被引用情况

- 存储管理 API 控制器
- Time Machine 模块 (`XQTimeMachine`)
- 系统设置页面的存储配置
- USB 设备管理功能

## 关键代码说明

### 容量单位转换

```lua
local sizeKB = storageUci:get("storage", sectionName, "size") or "0"
local sizeBytes = tonumber(sizeKB .. ".0") / 2
partition.capacity = string.format("%.1f", sizeBytes / 1048576) .. "GB"
```

存储配置中的 size 单位为 512 字节块，需要除以 2 转换为 KB，再转换为 GB 显示。

### 内存大小解析

```lua
local unit = string.upper(string.sub(memSize, string.len(memSize) - 1))
if unit == "MB" then
    memTotal = tonumber(string.sub(memSize, 0, string.len(memSize) - 2))
elseif unit == "GB" then
    memTotal = tonumber(string.sub(memSize, 0, string.len(memSize) - 2)) * 1024
end
```

从 `misc.hardware.memsize` 配置读取内存大小，支持 MB/GB/KB 单位自动转换。

### Swap 粒度控制

```lua
local granularity = tonumber(uci:get("swap", "swap0", "granularity") or "1")
size = math.modf(tonumber(size) / granularity)
```

Swap 大小按配置的粒度进行对齐，确保分配的 Swap 空间符合系统要求。
