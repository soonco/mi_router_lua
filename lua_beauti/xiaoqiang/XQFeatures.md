# XQFeatures.lua - 功能特性配置模块

## 概述

`XQFeatures.lua` 是小米路由器的功能特性配置模块，定义了路由器支持的各种功能开关和配置选项。不同型号的路由器可能有不同的特性配置。

**模块路径**: `xiaoqiang.XQFeatures`

## 工作原理

该模块通过 `FEATURES` 全局表定义所有功能特性，各模块通过读取该表来判断是否启用特定功能。

## 特性值说明

| 值 | 说明 |
|---|------|
| "0" | 功能禁用 |
| "1" | 功能启用 |
| 其他数值 | 特殊配置值 |

## 特性分类

### system - 系统级功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| shutdown | "0" | 关机功能 |
| downloadlogs | "0" | 下载日志功能 |
| i18n | "0" | 国际化支持 |
| infileupload | "1" | 文件上传功能 |
| task | "0" | 任务管理功能 |
| upnp | "1" | UPnP 功能 |
| new_update | "1" | 新版本更新检测 |
| multiwan | "1" | 多 WAN 支持 |
| support_1000_dhcp | "1" | 支持 1000 个 DHCP 客户端 |
| ipv6_wired | "0" | IPv6 有线支持 |
| ipv6_wired_v2 | "1" | IPv6 有线支持 v2 |
| ipv6_passthrough_relay | "1" | IPv6 透传/中继 |
| mesh_bhtype_mode | "1" | Mesh 回程类型模式 |
| ipmaccheck | "1" | IP/MAC 绑定检查 |

### wifi - WiFi 相关功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| wifi24 | "1" | 2.4GHz WiFi |
| wifi50 | "1" | 5GHz WiFi |
| wifiguest | "1" | 访客 WiFi |
| wifimerge | "1" | WiFi 双频合一 |
| wifi_mu_mimo | "1" | MU-MIMO 支持 |
| twt | "1" | Target Wake Time (WiFi 6) |
| mlo | "1" | Multi-Link Operation (WiFi 7) |
| iot_dev | "1" | IoT 设备专用网络 |
| silence_switch | "1" | 静音开关 |
| wifi_access_ctl | "1" | WiFi 访问控制 |

### apmode - AP 模式功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| wifiapmode | "1" | WiFi AP 模式 |
| lanapmode | "1" | 有线 AP 模式 |

### netmode - 网络模式功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| elink | "0" | eLink 功能 |
| net2.5G | "1" | 2.5G 网口支持 |
| net10G | "1" | 10G 网口支持 |

### apps - 应用功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| apptc | "0" | 应用流量控制 |
| qos | "1" | QoS 功能 |
| dhcpMsg | "1" | DHCP 消息 |
| upnp | "1" | UPnP 功能 |
| nfc | "1" | NFC 功能 |
| wanLan | "1" | WAN/LAN 切换 |
| mipctlv2 | "1" | MIPCTL v2 |
| lanPort | "1" | LAN 端口管理 |
| xqdatacenter | "1" | 小米数据中心 |
| baidupan | "1" | 百度网盘 |
| timemachine | "1" | Time Machine 备份 |
| storage | "1" | 存储功能 |
| samba | "1" | Samba 文件共享 |
| docker | "1" | Docker 支持 |
| swapmask | "7" | 交换掩码配置 |
| ports_custom | "1" | 端口自定义 |
| LED_control | "7" | LED 控制模式 |
| download | "0" | 下载功能 |
| temp_control | "1" | 温度控制 |
| sfp | "1" | SFP 光口支持 |
| game_port | "1" | 游戏端口优化 |
| lan_lag | "1" | LAN 端口聚合 |
| local_gw_security | "1" | 本地网关安全 |
| sec_center | "2" | 安全中心版本 |
| firewall | "1" | 防火墙功能 |

### hardware - 硬件功能

| 特性 | 默认值 | 说明 |
|-----|-------|------|
| usb | "1" | USB 接口 |
| usb_deploy | "0" | USB 部署功能 |
| disk | "0" | 内置硬盘 |

## 使用示例

```lua
local XQFeatures = require("xiaoqiang.XQFeatures")
local FEATURES = XQFeatures.FEATURES

-- 检查是否支持 QoS
if FEATURES.apps and FEATURES.apps.qos == "1" then
    -- 启用 QoS 功能
end

-- 检查是否支持 Mesh
if FEATURES.system and FEATURES.system.mesh_bhtype_mode == "1" then
    -- 启用 Mesh 相关功能
end

-- 检查 WiFi 6 TWT 功能
if FEATURES.wifi and FEATURES.wifi.twt == "1" then
    -- 启用 TWT 功能
end
```

## 外部依赖

无外部依赖，该模块仅定义静态配置数据。

## 被引用情况

该模块被广泛引用于：
- API 控制器中的功能路由注册
- 系统初始化信息返回
- 功能开关判断
- 硬件能力检测
