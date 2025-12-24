# misystem.lua - 小米路由器系统 API 控制器模块

## 概述

小米路由器系统 API 控制器模块（Mi System API Controller），提供路由器系统管理的各种 API 接口，包括设备管理、网络配置、QoS 服务质量、磁盘管理、系统设置、Mesh 网络、防蹭网、生态系统等功能。这是小米路由器最核心的 API 控制器之一。

**文件路径**: `luci/controller/api/misystem.lua`  
**模块名称**: `luci.controller.api.misystem`  
**API 路径**: `/api/misystem/*` 和 `/api/xqsystem/*`

## 工作原理

1. **双路径注册**: 同时注册 `/api/misystem` 和 `/api/xqsystem` 两个路径
2. **特性检测**: 根据 `XQFeatures` 配置动态注册 API
3. **权限控制**: 不同 API 有不同的权限级别（1-16）
4. **UCI 配置**: 通过 UCI 系统读写路由器配置

## 接口/函数列表

### 系统状态 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/status` | `mainStatus()` | 默认 | 获取主状态信息 |
| `/api/misystem/devicelist` | `getDeviceList()` | 默认 | 获取设备列表 |
| `/api/misystem/device_list` | `getDeviceSrvList()` | 默认 | 获取设备服务列表 |
| `/api/misystem/messages` | `getMessages()` | 默认 | 获取消息列表 |
| `/api/misystem/router_info` | `getRouterBaseInfo()` | 9 | 获取路由器基本信息 |
| `/api/misystem/feature_info` | `getRouterFeatureInfo()` | 9 | 获取路由器特性信息 |

### 路由器配置 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/router_name` | `getRouterName()` | 8 | 获取路由器名称 |
| `/api/misystem/set_router_name` | `setRouterName()` | 8 | 设置路由器名称 |
| `/api/misystem/check_ip_conflict` | `checkIpConflict()` | 8 | 检查 IP 冲突 |
| `/api/misystem/get_config_result` | `getConfigResult()` | 8 | 获取配置结果 |

### 路由器模式 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/set_router_wifiap` | `setWifiApMode()` | 8 | 设置 WiFi AP 模式 |
| `/api/misystem/set_router_lanap` | `setLanApMode()` | 8 | 设置有线 AP 模式 |
| `/api/misystem/set_router_normal` | `setRouterInfo()` | 8 | 设置普通路由模式 |

### WAN 口设置 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/set_wan` | `setWan()` | 8 | 设置 WAN 口 |
| `/api/misystem/pppoe_status` | `getPPPoEStatus()` | 8 | 获取 PPPoE 状态 |
| `/api/misystem/pppoe_stop` | `pppoeStop()` | 8 | 停止 PPPoE |

### OTA 升级 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/ota` | `getOTAInfo()` | 8 | 获取 OTA 信息 |
| `/api/misystem/set_ota` | `setOTAInfo()` | 8 | 设置 OTA 信息 |

### WiFi 信道 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/channel_scan_start` | `channelScanStart()` | 开始信道扫描 |
| `/api/misystem/channel_scan_result` | `getScanResult()` | 获取扫描结果 |
| `/api/misystem/set_channel` | `setChannel()` | 设置信道 |

### Mesh 网络 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/topo_graph` | `getTopoGraph()` | 13 | 获取拓扑图 |
| `/api/misystem/child_mesh_infos` | `getChildMeshInfos()` | 8 | 获取子 Mesh 信息 |

### QoS 服务质量 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/qos_info` | `getQosInfo()` | 获取 QoS 信息 |
| `/api/misystem/qos_dev_info` | `getMACQoSInfo()` | 获取设备 QoS 信息 |
| `/api/misystem/qos_set_dev_info` | `setMACQoSInfo()` | 设置设备 QoS 信息 |
| `/api/misystem/qos_switch` | `qosSwitch()` | QoS 开关 |
| `/api/misystem/qos_mode` | `qosMode()` | QoS 模式 |
| `/api/misystem/qos_limit` | `qosLimit()` | QoS 限速 |
| `/api/misystem/qos_limits` | `qosLimits()` | QoS 批量限速 |
| `/api/misystem/qos_offlimit` | `qosOffLimit()` | 取消 QoS 限速 |
| `/api/misystem/set_band` | `setBand()` | 设置带宽 |

### 磁盘管理 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/disk_info` | `getDiskinfo()` | 获取磁盘信息 |
| `/api/misystem/io_data` | `getIOData()` | 获取 IO 数据 |
| `/api/misystem/disk_check` | `diskCheck()` | 磁盘检查 |
| `/api/misystem/check_status` | `diskCheckStatus()` | 检查状态 |
| `/api/misystem/disk_repair` | `diskRepair()` | 磁盘修复 |
| `/api/misystem/repair_status` | `diskRepairStatus()` | 修复状态 |
| `/api/misystem/disk_format` | `diskFormat()` | 磁盘格式化 |
| `/api/misystem/disk_smartctl` | `diskSmartCtl()` | 磁盘 SMART 信息 |

### 防蹭网 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/arn_status` | `getAntiRubNetworkStatus()` | 获取防蹭网状态 |
| `/api/misystem/arn_switch` | `setAntiRubNetwork()` | 设置防蹭网 |
| `/api/misystem/arn_records` | `getAntiRubNetworkRecords()` | 获取防蹭网记录 |
| `/api/misystem/arn_security` | `arnSecurity()` | 防蹭网安全 |

### 系统管理 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/sys_log` | `backupSysLog()` | 备份系统日志 |
| `/api/misystem/log_upload` | `syslogUpload()` | 上传日志 |
| `/api/misystem/password` | `changePassword()` | 修改密码 |
| `/api/misystem/sys_time` | `getSysTime()` | 获取系统时间 |
| `/api/misystem/set_sys_time` | `setSysTime()` | 设置系统时间 |

### 配置备份恢复 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/misystem/c_backup` | `cBackup()` | 配置备份 |
| `/api/misystem/c_download` | `cDownload()` | 配置下载 |
| `/api/misystem/c_upload` | `cUpload()` | 配置上传 |
| `/api/misystem/c_restore` | `cRestore()` | 配置恢复 |

### 语言和位置 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/misystem/get_location` | `getLocation()` | 9 | 获取位置 |
| `/api/misystem/set_location` | `setLocation()` | 8 | 设置位置 |
| `/api/misystem/get_languages` | `getLangList()` | 1 | 获取语言列表 |
| `/api/misystem/get_main_language` | `getMainLang()` | 1 | 获取主语言 |
| `/api/misystem/set_language` | `setLang()` | 8 | 设置语言 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `luci.model.uci` | UCI 配置 |
| `xiaoqiang.XQFeatures` | 特性配置 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQQoSUtil` | QoS 工具 |
| `xiaoqiang.module.XQDisk` | 磁盘模块 |
| `xiaoqiang.module.XQNetworkSpeedTest` | 网络测速模块 |
| `xiaoqiang.module.XQIPConflict` | IP 冲突检测模块 |
| `xiaoqiang.module.XQMessageBox` | 消息模块 |
| `xiaoqiang.XQPreference` | 偏好设置 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.XQStatPoints` | 统计点 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/misystem/*` 和 `/api/xqsystem/*` 路径下自动加载
- 小米路由器 APP 的主要 API 接口
- Web 管理界面的核心功能模块
- Mesh 组网管理

## 权限级别说明

| 级别 | 说明 |
|------|------|
| 1 | 公开接口，无需认证 |
| 8 | 需要管理员认证 |
| 9 | 公开接口，但返回敏感信息 |
| 13 | Mesh 网络相关 |
| 16 | 文件上传相关 |

## 关键代码说明

### 路由器初始化设置

```lua
function setRouterInfo()
    -- 设置 NVRAM 标志：路由器已配置
    XQFunction.nvramSet("Router_unconfigured", "0")
    XQFunction.nvramCommit()
    
    -- 检测 IP 冲突
    local ipConflict = XQIPConflict.ip_conflict_detection()
    
    -- 保存密码
    result.code = _savePassword(nonce, oldPwd, newPwd, newPwd256)
    
    -- 设置 WiFi
    if bsd == 1 then
        setInitBsdWifiInfo(bw160, ssid, password)
    else
        setInitWifiInfo(bw160, ssid, password, ssid5g, password5g)
    end
end
```

### 激活和带宽测试

```lua
function active()
    -- 停止 QoS 服务
    os.execute("/etc/init.d/miqos stop")
    
    -- 执行同步测速
    local upload, download = XQNetworkSpeedTest.syncSpeedTest()
    
    -- 保存带宽信息
    XQPreference.set("BANDWIDTH", downloadKbps, "xiaoqiang")
    XQPreference.set("BANDWIDTH2", uploadKbps, "xiaoqiang")
    
    -- 设置 QoS 带宽
    XQQoSUtil.setQosBand(uploadKbps, downloadKbps)
    
    -- 启动 QoS 服务
    os.execute("/etc/init.d/miqos start")
end
```

### 设备列表获取

```lua
function getDeviceList()
    local online = tonumber(http.formvalue("online")) or 0
    local withbrlan = tonumber(http.formvalue("withbrlan")) or 0
    local mlo = tonumber(http.formvalue("mlo")) or 0
    
    result.mac = luci.dispatcher.getremotemac()
    result.list = XQDeviceUtil.getDeviceListV2(
        online == 1,
        withbrlan == 1,
        mlo == 1
    )
end
```

## 注意事项

1. 此模块是小米路由器最大的 API 控制器，包含 100+ 个 API 端点
2. 部分 API 需要特定的硬件支持（如磁盘管理需要带硬盘的路由器）
3. Mesh 相关 API 仅在支持 Mesh 的路由器上可用
4. 初始化向导 API 会修改 NVRAM 配置
