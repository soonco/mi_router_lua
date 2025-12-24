# XQConfigs.lua - 配置常量模块

## 概述

`XQConfigs.lua` 是小米路由器的核心配置常量模块，定义了系统级配置常量、文件路径、命令行模板、API 服务器地址等。该模块是整个系统的配置中心。

**模块路径**: `xiaoqiang.common.XQConfigs`

## 配置分类

### 服务器配置

| 常量 | 说明 |
|-----|------|
| SERVER_CONFIG | 服务器配置标志 (0=在线, 1=测试, 2=预览) |
| SERVER_CONFIG_ONLINE_URL | API 服务器地址 |
| PASSPORT_CONFIG_ONLINE_URL | Passport 认证服务器 |
| XQ_SERVER_ONLINE_STS_URL | 小米 WiFi STS 服务器 |
| XQ_SERVER_ONLINE_API_URL | 小米 WiFi API 服务器 |

### 文件路径常量

| 常量 | 值 | 说明 |
|-----|-----|------|
| ARP_LIST_UI_FILEPATH | /tmp/activate.arp.list.ui | ARP 列表 UI 文件 |
| LOG_ZIP_FILEPATH | /tmp/log.tar.gz | 日志压缩包 |
| PPP_LOG_FILEPATH | /var/log/ppp.log | PPP 日志 |
| ROM_CACHE_FILEPATH | /tmp/rom.bin | ROM 缓存文件 |
| DHCP_LEASE_FILEPATH | /var/dhcp.leases | DHCP 租约文件 |
| WAN_MONITOR_STAT_FILEPATH | /tmp/wan.monitor.stat | WAN 监控状态文件 |
| XQ_ROM_VERSION_FILEPATH | /usr/share/xiaoqiang/xiaoqiang_version | 版本信息文件 |

### 偏好设置键名

| 常量 | 值 | 说明 |
|-----|-----|------|
| PREF_IS_CONFIGURED | "CONFIGURED" | 是否已配置 |
| PREF_IS_INITED | "INITTED" | 是否已初始化 |
| PREF_IS_PASSPORT_BOUND | "PASSPORT_BOUND" | 是否绑定 Passport |
| PREF_ROUTER_NAME | "ROUTER_NAME" | 路由器名称 |
| PREF_PPPOE_NAME | "PPPOE_NAME" | PPPoE 用户名 |
| PREF_PPPOE_PASSWORD | "PPPOE_PASSWORD" | PPPoE 密码 |
| PREF_ROM_DOWNLOAD_URL | "ROM_DOWNLOAD_URL" | ROM 下载地址 |

### WiFi 相关命令

| 常量 | 说明 |
|-----|------|
| GET_WIFI_CAC_TIME | 获取 WiFi CAC 时间 |
| FORK_RESTART_WIFI | 重启 WiFi 命令 |
| FORK_RESTART_WIFI_NOTIFY | 重启 WiFi 并通知设备 |

### 系统控制命令

| 常量 | 命令 | 说明 |
|-----|------|------|
| FORK_RESET_ALL | sleep 4; /usr/sbin/restore_defaults.sh | 恢复出厂设置 |
| FORK_RESTART_ROUTER | sleep 4; reboot | 重启路由器 |
| FORK_SHUTDOWN_ROUTER | sleep 4; /usr/sbin/uhbn 3 | 关机 |
| FORK_RESTART_DNSMASQ | sleep 2; /etc/init.d/dnsmasq restart | 重启 DNS 服务 |
| RESTART_MAC_FILTER | /bin/sh /etc/firewall.macfilter | 重启 MAC 过滤 |

### 版本信息获取命令

| 常量 | 说明 |
|-----|------|
| XQ_ROM_VERSION | 获取 ROM 版本 |
| XQ_ROM_HWVERSION | 获取硬件版本 |
| XQ_CHANNEL | 获取发布渠道 |
| XQ_HARDWARE | 获取硬件型号 |
| XQ_DEVICE_ID | 获取设备 ID |

### WPS 相关命令

| 常量 | 命令 | 说明 |
|-----|------|------|
| OPEN_WPS | wps pbc | 开启 WPS |
| GET_WPS_STATUS | wps status | 获取 WPS 状态 |
| CLOSE_WPS | wps stop | 关闭 WPS |

### MAC 地址获取命令

| 常量 | 命令 | 说明 |
|-----|------|------|
| GET_DEFAULT_MACADDRESS | getmac | 获取默认 MAC |
| GET_DEFAULT_LAN_MACADDRESS | getmac lan | 获取 LAN MAC |
| GET_DEFAULT_WAN_MACADDRESS | getmac wan | 获取 WAN MAC |

### Nginx 缓存控制

| 常量 | 说明 |
|-----|------|
| NGINX_CACHE_START | 启动 Nginx 缓存 |
| NGINX_CACHE_STOP | 停止 Nginx 缓存 |
| NGINX_CACHE_STATUS | 获取 Nginx 缓存状态 |

### MAC 过滤控制

| 常量 | 说明 |
|-----|------|
| SET_LAN_BLACKLIST | 设置 LAN 黑名单模式 |
| SET_LAN_WHITELIST | 设置 LAN 白名单模式 |
| SET_WAN_BLACKLIST | 设置 WAN 黑名单模式 |
| SET_WAN_WHITELIST | 设置 WAN 白名单模式 |

### VPN 相关命令

| 常量 | 命令 | 说明 |
|-----|------|------|
| VPN_ENABLE | /usr/sbin/vpn.lua up | 启用 VPN |
| VPN_DISABLE | /usr/sbin/vpn.lua down | 禁用 VPN |
| VPN_STATUS | /usr/sbin/vpn.lua status | VPN 状态 |

### UPnP 相关命令

| 常量 | 说明 |
|-----|------|
| UPNP_STATUS | 检查 UPnP 状态 |
| UPNP_ENABLE | 启用 UPnP |
| UPNP_DISABLE | 禁用 UPnP |

### QoS 相关命令

| 常量 | 说明 |
|-----|------|
| QOS_APPSL_ENABLE | 启用应用 QoS |
| QOS_APPSL_DISABLE | 禁用应用 QoS |
| QOS_APPSL_RELOAD | 重载应用 QoS |

### Thrift 隧道命令

| 常量 | 目标 | 说明 |
|-----|------|------|
| THRIFT_TUNNEL_TO_DATACENTER | 0 | 数据中心隧道 |
| THRIFT_TUNNEL_TO_SMARTHOME | 1 | 智能家居隧道 |
| THRIFT_TUNNEL_TO_SMARTHOME_CONTROLLER | 2 | 智能控制器隧道 |
| THRIFT_TUNNEL_TO_MIIO | 6 | MIIO 设备隧道 |
| THRIFT_TUNNEL_TO_YEELINK | 7 | Yeelink 设备隧道 |
| TUNNEL_TOOL | - | 通用隧道工具 |

### 升级相关常量

| 常量 | 说明 |
|-----|------|
| UPGRADE_LOCK_FILE | 升级锁文件路径 |
| UPGRADE_INFO_CACHE | 升级信息缓存键 |
| UPGRADE_INFO_EXPIRE | 升级信息过期时间 (600秒) |

### SIM 卡/CPE 配置

| 常量 | 说明 |
|-----|------|
| XQ_SIM_CONFIG_NAME | SIM 配置文件名 |
| SIM_PIN_MAX_RETRY | PIN 码最大重试次数 (3) |
| SIM_PUK_MAX_RETRY | PUK 码最大重试次数 (10) |
| SIM_APN_MAX_NUMBER | 最大 APN 数量 (8) |

## 外部依赖

无外部依赖，该模块仅定义静态常量。

## 被引用情况

该模块被几乎所有业务模块引用，用于：
- 获取系统命令模板
- 获取文件路径
- 获取服务器地址
- 获取配置键名
