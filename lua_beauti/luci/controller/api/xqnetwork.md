# xqnetwork.lua - 小米路由器网络 API 控制器模块

## 概述

小米路由器网络 API 控制器模块（XQ Network API Controller），提供网络相关的 API 接口，包括 WiFi 管理、WAN/LAN 配置、QoS 流量控制、DDNS 动态域名、Mesh 组网、IPv6 配置、设备管理等功能。这是小米路由器最核心的网络管理 API 控制器。

**文件路径**: `luci/controller/api/xqnetwork.lua`  
**模块名称**: `luci.controller.api.xqnetwork`  
**API 路径**: `/api/xqnetwork/*`

## 工作原理

1. **特性检测**: 根据 `XQFeatures` 配置动态注册 API
2. **权限控制**: 不同 API 有不同的权限级别
3. **UCI 配置**: 通过 UCI 系统读写网络配置
4. **Mesh 同步**: 配置变更自动同步到 Mesh 网络

## 接口/函数列表

### WiFi 相关 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/wifi_status` | `getWifiStatus()` | 获取 WiFi 状态 |
| `/api/xqnetwork/wifi_detail` | `getWifiInfo()` | 获取单个 WiFi 详细信息 |
| `/api/xqnetwork/wifi_detail_all` | `getAllWifiInfo()` | 获取所有 WiFi 详细信息 |
| `/api/xqnetwork/wifi_connect_devices` | `getWifiConDev()` | 获取 WiFi 连接的设备列表 |
| `/api/xqnetwork/wifi_txpwr_channel` | `getWifiChTx()` | 获取 WiFi 发射功率和信道 |
| `/api/xqnetwork/set_wifi_txpwr` | `setWifiTxpwr()` | 设置 WiFi 发射功率 |
| `/api/xqnetwork/wifi_up` | `turnOnWifi()` | 开启 WiFi |
| `/api/xqnetwork/wifi_down` | `shutDownWifi()` | 关闭 WiFi |
| `/api/xqnetwork/set_wifi` | `setWifi()` | 设置 WiFi 参数 |
| `/api/xqnetwork/set_all_wifi` | `setAllWifi()` | 设置所有 WiFi 参数 |
| `/api/xqnetwork/avaliable_channels` | `getChannels()` | 获取可用信道列表 |

### WAN/LAN 相关 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqnetwork/lan_info` | `getLanInfo()` | 默认 | 获取 LAN 口信息 |
| `/api/xqnetwork/wan_info` | `getWanInfo()` | 默认 | 获取 WAN 口信息 |
| `/api/xqnetwork/lan_dhcp` | `getLanDhcp()` | 默认 | 获取 LAN DHCP 配置 |
| `/api/xqnetwork/wan_down` | `wanDown()` | 默认 | 关闭 WAN 口 |
| `/api/xqnetwork/wan_up` | `wanUp()` | 默认 | 开启 WAN 口 |
| `/api/xqnetwork/check_wan_type` | `getAutoWanType()` | 8 | 自动检测 WAN 类型 |
| `/api/xqnetwork/set_lan_ip` | `setLanIp()` | 默认 | 设置 LAN 口 IP |
| `/api/xqnetwork/set_wan` | `setWan()` | 8 | 设置 WAN 口配置 |
| `/api/xqnetwork/mac_clone` | `setWanMac()` | 默认 | MAC 地址克隆 |

### QoS 流量控制 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/qos_info` | `getQosInfo()` | 获取 QoS 信息 |
| `/api/xqnetwork/qos_switch` | `qosSwitch()` | QoS 开关 |
| `/api/xqnetwork/qos_mode` | `qosMode()` | 设置 QoS 模式 |
| `/api/xqnetwork/qos_limit` | `qosLimit()` | 设置设备限速 |
| `/api/xqnetwork/qos_limits` | `qosLimits()` | 批量设置限速 |
| `/api/xqnetwork/qos_offlimit` | `qosOffLimit()` | 取消限速 |
| `/api/xqnetwork/set_band` | `setBand()` | 设置带宽 |

### DDNS 动态域名 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/ddns` | `ddnsStatus()` | 获取 DDNS 状态 |
| `/api/xqnetwork/ddns_switch` | `ddnsSwitch()` | DDNS 开关 |
| `/api/xqnetwork/add_server` | `addServer()` | 添加 DDNS 服务器 |
| `/api/xqnetwork/del_server` | `deleteServer()` | 删除 DDNS 服务器 |
| `/api/xqnetwork/server_switch` | `serverSwitch()` | DDNS 服务器开关 |
| `/api/xqnetwork/ddns_reload` | `ddnsReload()` | 重载 DDNS 配置 |

### 无线中继/AP 模式 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqnetwork/wifi_list` | `getScanList()` | 8 | 扫描 WiFi 列表 |
| `/api/xqnetwork/disable_ap` | `disableap()` | 默认 | 禁用 AP 模式 |
| `/api/xqnetwork/mode` | `getMode()` | 默认 | 获取当前模式 |
| `/api/xqnetwork/set_wifi_ap` | `setWifiApMode()` | 默认 | 设置 WiFi AP 模式 |
| `/api/xqnetwork/set_lan_ap` | `setLanAP()` | 默认 | 设置有线 AP 模式 |
| `/api/xqnetwork/wifiap_signal` | `apcli_get_signal()` | 默认 | 获取中继信号强度 |

### Mesh 组网 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/set_son_backhaul_mode` | `setSonBackhaulMode()` | 设置 SON 回程模式 |
| `/api/xqnetwork/get_son_backhaul_mode` | `getSonBackhaulMode()` | 获取 SON 回程模式 |
| `/api/xqnetwork/scan_mesh_node` | `scanMeshNode()` | 扫描 Mesh 节点 |
| `/api/xqnetwork/add_mesh_node` | `addMeshNode()` | 添加 Mesh 节点 |
| `/api/xqnetwork/get_addnode_status` | `getMeshNodeStatus()` | 获取节点添加状态 |
| `/api/xqnetwork/get_netmode` | `getNetMode()` | 获取网络模式 |

### IPv6 配置 API

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqnetwork/set_wan6` | `setWan6()` | 8 | 设置 IPv6 WAN 配置 |
| `/api/xqnetwork/ipv6_status` | `ipv6Status()` | 8 | 获取 IPv6 状态 |
| `/api/xqnetwork/set_ipv6_firewall` | `setIpv6Firewall()` | 8 | 设置 IPv6 防火墙 |
| `/api/xqnetwork/get_ipv6_firewall` | `getIpv6Firewall()` | 8 | 获取 IPv6 防火墙状态 |

### MAC 过滤/设备管理 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/wifi_macfilter_info` | `getWifiMacfilterInfo()` | 获取 MAC 过滤信息 |
| `/api/xqnetwork/set_wifi_macfilter` | `setWifiMacfilter()` | 设置 MAC 过滤 |
| `/api/xqnetwork/edit_device` | `editDevice()` | 编辑设备信息 |
| `/api/xqnetwork/mac_bind` | `macBind()` | MAC-IP 绑定 |
| `/api/xqnetwork/mac_unbind` | `macUnbind()` | 解除 MAC-IP 绑定 |
| `/api/xqnetwork/macbind_info` | `getMacBindInfo()` | 获取绑定信息 |

### 信道扫描 API

| API 路径 | 函数名 | 说明 |
|----------|--------|------|
| `/api/xqnetwork/channel_scan_start` | `channelScanStart()` | 开始信道扫描 |
| `/api/xqnetwork/channel_scan_result` | `getScanResult()` | 获取扫描结果 |
| `/api/xqnetwork/set_channel` | `setChannel()` | 设置信道 |

### 条件注册的 API（依赖特性配置）

| 特性 | API 路径 | 说明 |
|------|----------|------|
| `sfp` | `/api/xqnetwork/get_sfp`, `set_sfp` | SFP 光口设置 |
| `ipv6_wired_v2` | `/api/xqnetwork/set_wan6_v2` 等 | IPv6 V2 接口 |
| `multiwan` | `/api/xqnetwork/get_multiwan_*` | 多 WAN 设置 |
| `tr069` | `/api/xqnetwork/set_cwmp` 等 | TR-069 设置 |
| `baidupan` | `/api/xqnetwork/set_router_to_baidu` 等 | 百度网盘功能 |
| `docker` | `/api/xqnetwork/set_mi_docker` 等 | Docker 功能 |
| `twt` | `/api/xqnetwork/get_twt`, `set_twt` | TWT 设置 |
| `local_gw_security` | `/api/xqnetwork/set_gw_security` 等 | 网关安全设置 |
| `iot_dev` | `/api/xqnetwork/get_iotwifi_info` 等 | IoT WiFi 设置 |
| `wifi_access_ctl` | `/api/xqnetwork/get_sta_bindinfo` 等 | WiFi 接入控制 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQQoSUtil` | QoS 工具 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具 |
| `xiaoqiang.util.DedicatedWirelessBackhaulUtil` | DWB 工具 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.XQFeatures` | 特性配置 |
| `xiaoqiang.module.XQIPConflict` | IP 冲突检测 |
| `luci.model.uci` | UCI 配置 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `cjson` | JSON 编解码 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/xqnetwork/*` 路径下自动加载
- 小米路由器 APP 的网络管理功能
- Web 管理界面的网络设置模块
- Mesh 组网管理

## 关键代码说明

### 获取所有 WiFi 信息

```lua
function getAllWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    
    result.info = XQWifiUtil.getAllWifiInfo()
    
    -- 获取 BSD 状态
    if #result.info > 0 then
        result.bsd = tonumber(result.info[1].bsd) or 0
    end
    
    -- 获取 DWB (专用无线回程) 状态
    if DWBUtil and DWBUtil.is_supported() then
        result.dwb_type = DWBUtil.mesh_get_dwb_type()
        result.dwb_band = DWBUtil.mesh_get_dwb_band()
        result.dwb_status = tonumber(DWBUtil.mesh_get_dwb_status() or 0)
    end
end
```

### 设置 LAN 口 IP

```lua
function setLanIp()
    local ip = LuciHttp.formvalue("ip")
    local mask = LuciHttp.formvalue("mask")
    
    -- 验证 IP 地址格式
    if not datatypes.ipaddr(ip) then
        code = 1525
    elseif XQIPConflict.lan_wan_ip_conflict_chk(ip, mask) then
        code = 1526
    end
    
    if code == 0 then
        XQLanWanUtil.setLanIp(ip, mask)
        XQIPConflict.lan_ip_conflict_resolution()
        
        -- Mesh 网络同步并重启
        if XQFunction.isMeshCap() then
            local cmd = "sh /sbin/whc_to_re_common_api.sh gw_update " .. ip
            XQFunction.forkExec(cmd)
        end
    end
end
```

### WiFi 接入控制

```lua
function applyCAPCtlEntry(staMac, bindNode, bindMac, bindBand)
    -- 查找现有条目
    uciCursor:foreach("wifiaccess", "wifi-sta", function(section)
        if string.upper(section.stamac) == string.upper(staMac) then
            sectionName = section[".name"]
            found = true
        end
    end)
    
    -- 更新或添加条目
    if found then
        uciCursor:set("wifiaccess", sectionName, "bindNode", bindNode)
    else
        local newSection = uciCursor:add("wifiaccess", "wifi-sta")
        uciCursor:set("wifiaccess", newSection, "stamac", staMac)
    end
    
    -- 同步配置并应用策略
    LuciUtil.exec("ubus call xq_info_sync_mqtt sync_wifictl_config")
end
```

## 注意事项

1. 此模块是小米路由器最大的网络 API 控制器，包含 100+ 个 API 端点
2. 设置 LAN IP 后会自动重启路由器
3. Mesh 网络配置变更会自动同步到所有节点
4. 部分 API 需要特定的硬件支持（如 SFP、多 WAN）
5. WiFi 接入控制最多支持 128 个条目
