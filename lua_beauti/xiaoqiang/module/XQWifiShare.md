# XQWifiShare.lua - WiFi分享模块

## 概述

`XQWifiShare` 模块提供 WiFi 分享和访客网络管理功能。该模块支持获取 WiFi 分享信息、设置访客 WiFi 网络、管理访客网络定时关闭功能，并与小米智能家居控制器集成实现自动化场景。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    WiFi分享/访客网络架构                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │  WiFi分享    │───▶│  访客WiFi    │───▶│  定时关闭    │  │
│  │   信息查询   │    │   配置管理   │    │   智能场景   │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│         │                   │                   │          │
│         ▼                   ▼                   ▼          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    底层组件                           │  │
│  │  • XQWifiUtil: WiFi配置管理                          │  │
│  │  • XQSmartHome: 智能家居场景控制                     │  │
│  │  • guestwifi.sh: 访客WiFi脚本                        │  │
│  │  • mipctl_public.sh: 家长控制集成                    │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  智能场景配置                         │  │
│  │  场景ID: 30020                                        │  │
│  │  功能: 到时定时关闭访客网络                           │  │
│  │  触发: 基于UTC时间戳的定时器                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### wifi_share_info(wifiIndex)

获取 WiFi 分享信息。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| wifiIndex | number | WiFi 索引 (可选) |

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| guest | number | 访客 WiFi 状态 (0=关闭, 1=开启) |
| share | number | 分享状态 |
| need | number | 是否需要配置 (0=不需要, 1=需要) |
| sns | table | 社交网络分享配置 |
| data | table | WiFi 配置数据 |
| data.ssid | string | SSID (HTML 编码) |
| data.encryption | string | 加密方式 |
| data.hidden | number | 是否隐藏 |
| data.password | string | 密码 (HTML 编码) |
| data.ssidHtmlEncode | number | SSID 编码标记 |

---

### wifi_share_info_web()

获取 Web 端 WiFi 分享信息（简化版）。

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| need | number | 是否需要配置 |

---

### set_wifi_share(shareInfo)

设置 WiFi 分享/访客网络配置。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| shareInfo | table | 分享配置信息 |

**shareInfo 字段:**
| 字段 | 类型 | 说明 |
|------|------|------|
| guest | number | 访客 WiFi 开关 (0/1) |
| data | table | WiFi 配置 |
| data.ssid | string | SSID |
| data.encryption | string | 加密方式 |
| data.password | string | 密码 |
| closingTime | string | 定时关闭时间（小时） |

**返回值:** boolean - 操作是否成功

---

### set_share_time(hours)

设置访客网络定时关闭。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| hours | number | 关闭倒计时（小时） |

**返回值:** 无

---

### delete_share_time()

删除访客网络定时关闭场景。

**参数:** 无

**返回值:** 无

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.util.XQSysUtil | 系统工具 |
| xiaoqiang.util.XQWifiUtil | WiFi 工具 |
| xiaoqiang.util.XQCryptoUtil | 加密工具 |
| xiaoqiang.XQLog | 日志模块 |
| luci.controller.api.xqsmarthome | 智能家居 API |
| luci.http | HTTP 工具 |
| luci.util | LuCI 工具函数 |
| /usr/sbin/guestwifi.sh | 访客 WiFi 脚本 |
| /usr/sbin/sync_guest_bssid.lua | BSSID 同步脚本 |
| /usr/sbin/mipctl_public.sh | 家长控制脚本 |

## 被引用情况

- WiFi 分享 API 控制器
- 访客网络管理页面
- 移动端 APP WiFi 分享功能
- 智能家居场景集成

## 关键代码说明

### 智能场景配置

```lua
local SMART_SCENE_ID = 30020

local sceneData = {
    action_list = {actionItem},
    command = "scene_setting",
    id = SMART_SCENE_ID,
    name = "关闭访客网络",
    launch = launchConfig
}
```

使用固定的场景 ID (30020) 创建定时关闭访客网络的智能场景，通过智能家居控制器执行。

### 定时器时间计算

```lua
local currentTime = os.time()
local currentTimeMs = currentTime * 1000
local durationMs = tonumber(hours) * 60 * 60 * 1000
local triggerTimeMs = currentTimeMs + durationMs

if triggerTimeMs < currentTimeMs then
    triggerTimeMs = triggerTimeMs + 86400000  -- 加一天
end
```

计算定时关闭的 UTC 时间戳（毫秒），如果计算结果小于当前时间则自动加一天。

### 双频同步配置

```lua
XQWifiUtil.setGuestWifi(1, ssid, encryption, password, 1, shareInfo.guest, guestSsidPrefix, closingTime)
XQWifiUtil.setGuestWifi(2, ssid, encryption, password, 1, shareInfo.guest, guestSsidPrefix, closingTime)
```

访客 WiFi 配置同时应用到 2.4G (索引 1) 和 5G (索引 2) 频段，保持配置一致。

### 无密码处理

```lua
if encryption == "none" then
    password = "12345678"
    XQLog.log(6, "set guest not share, key = " .. password)
end
```

当加密方式为 `none`（开放网络）时，内部仍设置一个默认密码，可能用于后续配置兼容性。

### 家长控制集成

```lua
if tonumber(shareInfo.guest) == 1 then
    LuciUtil.forkExec("sleep 1; /usr/sbin/mipctl_public.sh add_guest_wifi_if")
else
    LuciUtil.forkExec("sleep 1; /usr/sbin/mipctl_public.sh del_guest_wifi_if")
end
```

开启/关闭访客网络时同步更新家长控制模块的接口配置。
