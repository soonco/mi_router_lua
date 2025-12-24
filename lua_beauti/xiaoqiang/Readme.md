# 小米路由器 Lua 模块库 (xiaoqiang)

## 概述

本目录包含小米路由器 (MiWiFi) 固件的核心 Lua 模块库，基于 OpenWrt/LuCI 框架开发。这些模块提供了路由器的各种功能实现，包括网络配置、WiFi管理、安全控制、设备管理、系统工具等。

## 目录结构

```
xiaoqiang/
├── common/                 # 核心公共模块
│   ├── XQConfigs.lua      # 配置常量定义
│   └── XQFunction.lua     # 通用工具函数
├── module/                 # 业务功能模块
│   ├── XQAPModule.lua     # AP模式管理
│   ├── XQAntiRubNetwork.lua # 防蹭网安全
│   ├── XQBackup.lua       # 配置备份恢复
│   ├── XQFirewall.lua     # 防火墙管理
│   ├── XQGuestWifi.lua    # 访客WiFi
│   ├── XQParentControl.lua # 家长控制
│   ├── XQPortForward.lua  # 端口转发
│   ├── XQTopology.lua     # Mesh网络拓扑
│   └── ...                # 更多业务模块
├── util/                   # 工具类模块
│   ├── XQWifiUtil.lua     # WiFi工具
│   ├── XQSysUtil.lua      # 系统工具
│   ├── XQNetUtil.lua      # 网络工具
│   ├── XQDeviceUtil.lua   # 设备工具
│   ├── XQLanWanUtil.lua   # LAN/WAN工具
│   ├── XQSecureUtil.lua   # 安全工具
│   └── ...                # 更多工具模块
├── XQCountryCode.lua      # 国家/地区代码
├── XQEquipment.lua        # 设备识别
├── XQEvent.lua            # 事件处理
├── XQFeatures.lua         # 功能特性配置
├── XQLog.lua              # 日志模块
├── XQPreference.lua       # 偏好设置
├── XQPushHelper.lua       # 推送助手
├── XQStatPoints.lua       # 统计打点
└── XQVersion.lua          # 版本信息
```

## 模块分类详解

### 一、核心公共模块 (common/)

#### XQConfigs.lua - 配置常量模块
定义系统级配置常量，包括：
- 服务器URL地址（API、OTA、日志上传等）
- 文件路径常量（配置文件、临时文件、日志文件等）
- 系统命令模板（网络、WiFi、VPN、QoS等）
- 功能开关和默认值

#### XQFunction.lua - 通用工具函数模块
提供全局通用的工具函数：
- MAC地址格式化和验证
- 进程管理（启动、停止、检查）
- 系统控制（重启、关机）
- 格式转换（时间、大小、IP地址）
- NVRAM操作
- 命令执行封装

### 二、业务功能模块 (module/)

| 模块 | 功能说明 |
|------|----------|
| **XQAPModule** | AP模式管理，支持有线AP和无线中继模式配置 |
| **XQAntiRubNetwork** | 防蹭网安全，WiFi认证失败追踪和黑名单管理 |
| **XQBackup** | 配置备份恢复，支持AES加密的配置导入导出 |
| **XQBaiduPanUtil** | 百度云盘集成，支持文件上传下载 |
| **XQDDNS** | 动态DNS服务管理 |
| **XQDMZModule** | DMZ主机配置管理 |
| **XQDownload** | 下载管理，基于Aria2的JSON-RPC接口 |
| **XQEBit** | eBit带宽加速服务 |
| **XQEcos** | 生态系统设备管理（WiFi扩展器等） |
| **XQExWifiConfSync** | WiFi配置同步（主路由与扩展器间） |
| **XQExtendWifi** | 扩展WiFi管理（中继/桥接/WISP模式） |
| **XQFirewall** | 防火墙管理（DoS防护、MAC/IP过滤、端口转发代理） |
| **XQGuestWifi** | 访客WiFi网络管理 |
| **XQIPConflict** | IP冲突检测和解决 |
| **XQIPMacBind** | IP-MAC绑定（底层实现） |
| **XQKVStore** | KV存储聚合（路由器状态数据） |
| **XQMacBind** | MAC绑定（高层DHCP集成） |
| **XQMessageBox** | 系统消息通知管理 |
| **XQMiDockerUtil** | Docker容器管理 |
| **XQMiwifiLog** | 安全事件日志（SQLite存储） |
| **XQMultiWanPolicy** | 多WAN负载均衡策略（mwan3） |
| **XQNetworkNetDiagnose** | 网络诊断工具 |
| **XQNetworkSpeedTest** | 网络测速功能 |
| **XQParentControl** | 家长控制V1（时间/URL过滤） |
| **XQParentControlV2** | 家长控制V2（用户管理、mipctl） |
| **XQPortForward** | 端口转发、虚拟服务器、端口触发、ALG |
| **XQPredownload** | OTA固件预下载 |
| **XQRouterStatus** | 路由器状态查询（USB、WAN、设备） |
| **XQSecurity** | 安全功能聚合 |
| **XQStorage** | 存储管理（USB、Samba、Swap） |
| **XQTimeMachine** | macOS Time Machine备份支持 |
| **XQTopology** | Mesh网络拓扑管理 |
| **XQVASModule** | 增值服务管理 |
| **XQWifiShare** | WiFi分享和访客网络 |

### 三、工具类模块 (util/)

| 模块 | 功能说明 |
|------|----------|
| **XQWifiUtil** | WiFi管理核心模块，支持多频段(2.4G/5G/5GH/6G)、频道管理、加密配置、设备管理、WPS、Mesh、WiFi 6等 |
| **XQSysUtil** | 系统级工具，包括隐私设置、固件升级、系统信息、网络诊断、LED控制、MAC/IP过滤等 |
| **XQNetUtil** | 小米云服务API交互，设备认证、账号登录、固件升级检测、日志上传、签名请求 |
| **XQDeviceUtil** | 设备管理核心，设备列表、网络统计、DHCP租约、设备识别 |
| **XQLanWanUtil** | LAN/WAN网络配置，DHCP管理、IPv6配置、PPPoE拨号、MAC绑定 |
| **XQSecureUtil** | 安全工具，XSS过滤、密码加密验证、Nonce管理、命令安全检查 |
| **XQVPNUtil** | VPN连接配置（PPTP/L2TP），智能VPN分流 |
| **XQQoSUtil** | QoS服务质量管理，应用限速、设备限速、带宽管理 |
| **XQCryptoUtil** | 加密工具，Base64、MD5、SHA1、SHA256 |
| **XQDBUtil** | 数据库工具，SQLite和UCI双存储支持 |
| **XQHttpUtil** | HTTP请求工具，基于cURL |
| **XQDownloadUtil** | 固件下载工具，支持分片下载和MTD直写 |
| **XQErrorUtil** | 错误码管理，国际化错误消息 |
| **XQBrUtil** | Linux网桥MAC地址表读取 |
| **XQController** | 设备权限控制（通过trafficd） |
| **XQCacheUtil** | 文件缓存机制 |
| **XQSynchrodata** | 配置数据云端同步 |
| **XQPushUtil** | 推送通知和认证管理 |
| **XQLEDControlUtil** | LED灯控制（系统LED、氛围灯、网口LED） |
| **XQParam** | 参数验证工具 |
| **XQNfcUtil** | NFC标签WiFi分享 |
| **XQPortServiceUtil** | 端口服务管理（WAN/LAN切换、IPTV、LAG） |
| **XQSDKUtil** | SDK权限管理 |
| **XQUPnPUtil** | UPnP服务管理 |
| **XQVLANServiceUtil** | VLAN服务配置（IPTV/VoIP） |
| **XQZigbeeUtil** | Zigbee智能设备管理 |
| **DedicatedWirelessBackhaulUtil** | 专用无线回程（DWB）管理 |

### 四、根目录模块

| 模块 | 功能说明 |
|------|----------|
| **XQCountryCode** | 国家/地区代码管理，WiFi区域设置，无线标准判断(ETSI/FCC/AS) |
| **XQEquipment** | 设备识别，基于MAC OUI和DHCP名称识别设备厂商和类型 |
| **XQEvent** | 事件处理，LAN IP变更等系统事件的钩子机制 |
| **XQFeatures** | 功能特性配置，定义路由器支持的各种功能开关 |
| **XQLog** | 日志模块，基于POSIX syslog，支持多级别日志和统计打点 |
| **XQPreference** | 偏好设置，UCI配置读写封装 |
| **XQPushHelper** | 推送助手，处理设备连接/断开、系统升级等事件的推送通知 |
| **XQStatPoints** | 统计打点，系统日志和统计数据收集 |
| **XQVersion** | 版本信息，Web界面版本号和客户端下载地址 |

## 技术架构

### 依赖关系

```
┌─────────────────────────────────────────────────────────────┐
│                      API Controllers                         │
│              (luci/controller/api/*.lua)                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Business Modules                          │
│                    (xiaoqiang/module/)                       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     Utility Modules                          │
│                     (xiaoqiang/util/)                        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     Common Modules                           │
│                    (xiaoqiang/common/)                       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    System Services                           │
│        UCI | ubus | trafficd | dnsmasq | hostapd            │
└─────────────────────────────────────────────────────────────┘
```

### 核心技术栈

- **配置管理**: UCI (Unified Configuration Interface)
- **进程通信**: ubus (OpenWrt微总线)
- **流量控制**: trafficd 服务
- **WiFi管理**: hostapd / wpa_supplicant
- **DNS/DHCP**: dnsmasq
- **Web框架**: LuCI (Lua Configuration Interface)
- **数据存储**: SQLite / UCI配置文件
- **加密通信**: Thrift协议 / MIIO协议

## 主要功能特性

### 网络功能
- 多WAN支持和负载均衡
- IPv4/IPv6双栈
- PPPoE/DHCP/静态IP
- VLAN和IPTV支持
- 端口聚合(LAG)
- DMZ和端口转发

### WiFi功能
- 多频段支持 (2.4G/5G/5GH/6G)
- WiFi 6/6E/7支持
- 双频合一(BSD)
- 访客网络
- WiFi中继/桥接
- Mesh组网
- WPS配置
- NFC一碰连网

### 安全功能
- 防火墙和DoS防护
- MAC/IP过滤
- 家长控制
- 防蹭网
- VPN客户端(PPTP/L2TP)
- 安全日志

### 设备管理
- 设备识别和分类
- 流量统计
- QoS带宽管理
- 设备权限控制
- 推送通知

### 存储功能
- USB存储管理
- Samba文件共享
- Time Machine备份
- 下载管理(Aria2)
- 百度云盘集成

### 系统功能
- 固件升级(OTA)
- 配置备份恢复
- LED控制
- 系统诊断
- 多语言支持
- 云端同步

## 使用示例

### 获取WiFi信息
```lua
local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
XQWifiUtil.init()

local allWifi = XQWifiUtil.getAllWifiInfo()
for i, wifi in ipairs(allWifi) do
    print(string.format("WiFi %d: %s, Channel: %s", i, wifi.ssid, wifi.channel))
end
```

### 设置LAN IP
```lua
local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
local result = XQLanWanUtil.setLanIp("192.168.1.1", "255.255.255.0")
```

### 获取设备列表
```lua
local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
local devices = XQDeviceUtil.getDeviceList(true, false)
for _, device in ipairs(devices) do
    print(string.format("MAC: %s, Name: %s", device.mac, device.name))
end
```

### 配置端口转发
```lua
local XQPortForward = require("xiaoqiang.module.XQPortForward")
XQPortForward.addPortForward("Web Server", 80, 80, "192.168.31.100", "TCP")
```

### 记录日志
```lua
local XQLog = require("xiaoqiang.XQLog")
XQLog.log(6, "This is an info message")
```

## 配置文件

主要UCI配置文件：
- `/etc/config/xiaoqiang` - 小米路由器主配置
- `/etc/config/network` - 网络配置
- `/etc/config/wireless` - WiFi配置
- `/etc/config/firewall` - 防火墙配置
- `/etc/config/dhcp` - DHCP配置
- `/etc/config/devicelist` - 设备列表
- `/etc/config/miqos` - QoS配置

## 注意事项

1. **模块依赖**: 大多数模块依赖 `xiaoqiang.common.XQFunction` 和 `xiaoqiang.common.XQConfigs`
2. **配置持久化**: 修改配置后需要调用 `uci:commit()` 保存
3. **服务重启**: 某些配置变更需要重启相关服务才能生效
4. **权限控制**: 部分操作需要root权限
5. **版本兼容**: 不同路由器型号可能有不同的功能支持

## 版本信息

- Web界面版本: 0.0.3
- 默认管理地址: 192.168.31.1

## 相关资源

- [OpenWrt官方文档](https://openwrt.org/docs/start)
- [LuCI框架文档](https://github.com/openwrt/luci)
- [UCI配置系统](https://openwrt.org/docs/guide-user/base-system/uci)
