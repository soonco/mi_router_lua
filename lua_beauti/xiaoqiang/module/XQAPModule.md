# XQAPModule.lua - 小米路由器 AP模式管理模块

## 概述

XQAPModule 是小米路由器的 AP模式（接入点模式）管理模块，提供有线AP模式和无线AP模式的配置、启用、禁用以及相关网络配置的备份和恢复功能。

## 模块信息

- **模块名称**: `xiaoqiang.module.XQAPModule`
- **文件路径**: `xiaoqiang/module/XQAPModule.lua`

## 依赖模块

| 模块 | 说明 |
|------|------|
| `xiaoqiang.common.XQFunction` | 通用函数库 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `luci.util` | LuCI工具库 |
| `luci.model.uci` | UCI配置接口 |

## 功能函数

### 有线AP模式相关

#### QuickSetLanAPMode()

快速设置有线AP模式，获取AP模式下的访问地址。

**返回值**:
- `string` - 路由器的访问URL地址

**功能说明**:
1. 移除消息类型4的通知
2. 获取默认主机地址和别名IP
3. 根据WAN口状态返回合适的访问地址

---

#### QuickDisableLanAP()

快速禁用有线AP模式，获取禁用后的访问地址。

**返回值**:
- `string` - 路由器的访问URL地址

**功能说明**:
- 优先返回备份的LAN IP地址
- 如无备份则返回默认URL

---

#### QuickLanApServiceRestart(enable, async)

快速有线AP服务重启。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| enable | boolean | 是否启用AP模式 |
| async | boolean | 是否异步执行 |

**功能说明**:
- 调用 `/usr/sbin/set_apmode_quick.sh` 脚本
- 支持同步和异步两种执行方式

---

#### setLanAPMode()

设置有线AP模式，将路由器切换到有线AP模式（中继模式）。

**返回值**:
- `string|nil` - 新的LAN IP地址，如果IP未变化则返回nil

**功能说明**:
1. 检查是否支持快速AP模式
2. 备份当前LAN配置
3. 执行有线AP模式连接脚本
4. 配置MAC过滤、访客WiFi等
5. 设置网络模式为 `lanapmode`
6. 同步AP的LAN IP

---

#### setLanAPModeForce()

强制设置有线AP模式，无论当前状态如何都强制切换。

**返回值**:
- `string|nil` - 新的LAN IP地址

**功能说明**:
- 备份当前网络配置到 `/etc/config/.network.mode.router`
- 强制执行AP模式切换

---

#### disableLanAP()

禁用有线AP模式，将路由器从AP模式恢复到普通路由器模式。

**返回值**:
- `string|nil` - 恢复后的LAN IP地址

**功能说明**:
1. 恢复CAP模式状态
2. 从备份恢复LAN配置
3. 启用VPN
4. 禁用MAC过滤

---

#### lanApServiceRestart(enable, async, delay)

有线AP服务重启。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| enable | boolean | 是否启用AP模式 |
| async | boolean | 是否异步执行 |
| delay | boolean | 是否延迟执行（延迟7秒） |

**功能说明**:
- 调用 `/usr/sbin/lanap_mode.sh` 脚本
- 执行后调用 `/usr/sbin/shareUpdate -b` 更新共享

---

### 无线AP模式相关

#### setWifiAPMode(ssid, password, enctype, encryption, band, channel, bandwidth, newSsid, newEncryption, newPassword, newSsid5G, newSsid6G)

设置无线AP模式，将路由器配置为无线中继/AP模式。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| ssid | string | 上级WiFi的SSID |
| password | string | 上级WiFi的密码 |
| enctype | string | 加密类型 |
| encryption | string | 加密方式 |
| band | string | 频段(2g/5g) |
| channel | number | 信道 |
| bandwidth | string | 带宽 |
| newSsid | string | 新的2.4G WiFi SSID |
| newEncryption | string | 新的加密方式 |
| newPassword | string | 新的WiFi密码 |
| newSsid5G | string | 新的5G WiFi SSID |
| newSsid6G | string | 新的6G WiFi SSID（如果支持） |

**返回值**:
```lua
{
    connected = false,    -- 是否连接成功
    conerrmsg = "",       -- 错误信息
    scan = true,          -- 扫描是否成功
    ip = ""               -- 获取到的IP地址
}
```

**功能说明**:
1. 扫描并查找目标AP
2. 设置AP客户端连接
3. 等待连接建立（最多30秒）
4. 获取DHCP IP地址
5. 配置WiFi基本信息
6. 禁用回程AP和MiWiFi Mesh
7. 关闭访客WiFi

---

#### disableWifiAPMode(immediate)

禁用无线AP模式，将路由器从无线AP模式恢复到普通路由器模式。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| immediate | boolean | 是否立即执行 |

**返回值**:
- `string, string` - 返回LAN IP地址和WiFi SSID

**功能说明**:
1. 恢复备份配置
2. 启用VPN
3. 启用回程AP
4. 禁用AP客户端
5. 清除网络模式

---

#### appSetWifiAPMode(ssid, password, enctype, encryption, band, channel, bandwidth, newSsid, newEncryption, newPassword, newSsid5G)

APP设置无线AP模式，简化版的无线AP模式设置。

**参数**: 与 `setWifiAPMode` 类似，但不包含 `newSsid6G`

**返回值**:
```lua
{
    connected = false,    -- 是否连接成功
    conerrmsg = "",       -- 错误信息
    scan = true,          -- 扫描是否成功
    oldlan = ""           -- 旧的LAN IP地址
}
```

---

#### setWifiAPModeConfig()

从临时文件读取配置并应用无线AP模式设置。

**功能说明**:
- 读取 `/tmp/luci_set_wifi_ap_mode_result` 配置文件
- 解析JSON配置并应用网络设置
- 配置WiFi SSID和加密方式

---

#### actionForEnableWifiAP(immediate)

启用WiFi AP模式的后续操作。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| immediate | boolean | 是否立即执行 |

**功能说明**:
- 调用 `wifiap_mode.sh open` 脚本
- 非立即执行时延迟10秒

---

#### actionForDisableWifiAP()

禁用WiFi AP模式的后续操作。

**功能说明**:
- 延迟3秒后调用 `wifiap_mode.sh close` 脚本

---

### 扩展WiFi相关

#### extednwifi_disconnect(band)

断开指定频段的扩展WiFi连接。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| band | string | 频段(2g/5g)，默认为2g |

---

#### extendwifi_set_connect(ssid, password, enctype, encryption, band, channel)

连接到指定的上级WiFi网络。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| ssid | string | 上级WiFi的SSID |
| password | string | 上级WiFi的密码 |
| enctype | string | 加密类型 |
| encryption | string | 加密方式 |
| band | string | 频段 |
| channel | number | 信道 |

**返回值**:
```lua
{
    connected = false,    -- 是否连接成功
    dhcpcode = -1,        -- DHCP返回码
    ip = ""               -- 获取到的IP地址
}
```

**功能说明**:
- 最多重试3次连接
- 每次连接等待最多20秒
- 连接成功后获取DHCP IP

---

### 配置备份恢复

#### backupConfigs()

备份当前的网络、DHCP和WiFi配置。

**功能说明**:
- 备份DHCP LAN/WAN配置
- 备份网络LAN配置
- 备份WiFi信息
- 中国区域删除VPN备份

---

#### recoveryConfigs()

从备份中恢复网络和DHCP配置。

**功能说明**:
- 恢复DHCP LAN/WAN配置
- 恢复网络LAN配置

---

### 工具函数

#### setWanAuto(auto)

设置WAN自动连接。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| auto | boolean\|nil | 是否自动连接 |

---

#### parseCmdline(str)

解析命令行参数，对字符串进行转义处理。

**参数**:
| 参数 | 类型 | 说明 |
|------|------|------|
| str | string | 输入字符串 |

**返回值**:
- `string` - 转义后的字符串

**转义字符**:
- `\` → `\\`
- `` ` `` → `` \` ``
- `"` → `\"`
- `$` → `\$`

---

## 网络模式说明

| 模式 | 说明 |
|------|------|
| `lanapmode` | 有线AP模式 |
| `wifiapmode` | 无线AP模式 |
| `whc_cap` | WHC CAP模式 |
| `nil` | 普通路由器模式 |

## 相关脚本

| 脚本路径 | 说明 |
|----------|------|
| `/usr/sbin/set_apmode_quick.sh` | 快速AP模式设置脚本 |
| `/usr/sbin/lanap_mode.sh` | 有线AP模式管理脚本 |
| `/usr/sbin/shareUpdate` | 共享更新脚本 |
| `wifiap_mode.sh` | 无线AP模式管理脚本 |
| `dhcp_apclient.sh` | AP客户端DHCP脚本 |

## 配置文件

| 文件路径 | 说明 |
|----------|------|
| `/etc/config/network` | 网络配置 |
| `/etc/config/dhcp` | DHCP配置 |
| `/etc/config/backup` | 备份配置 |
| `/etc/config/xiaoqiang` | 小米路由器配置 |
| `/etc/config/.network.mode.router` | 路由器模式网络配置备份 |
| `/tmp/luci_set_wifi_ap_mode_result` | AP模式设置结果临时文件 |

## 使用示例

### 启用有线AP模式

```lua
local XQAPModule = require("xiaoqiang.module.XQAPModule")

-- 设置有线AP模式
local newIp = XQAPModule.setLanAPMode()
if newIp then
    print("新的LAN IP: " .. newIp)
end

-- 重启AP服务（异步，延迟执行）
XQAPModule.lanApServiceRestart(true, true, true)
```

### 启用无线AP模式

```lua
local XQAPModule = require("xiaoqiang.module.XQAPModule")

-- 连接到上级WiFi并设置AP模式
local result = XQAPModule.setWifiAPMode(
    "UpperRouter_SSID",     -- 上级WiFi SSID
    "password123",          -- 上级WiFi密码
    "wpa2",                 -- 加密类型
    "psk2",                 -- 加密方式
    "5g",                   -- 频段
    36,                     -- 信道
    "80",                   -- 带宽
    "MyRouter_2G",          -- 新的2.4G SSID
    "psk2",                 -- 新的加密方式
    "newpassword",          -- 新的密码
    "MyRouter_5G"           -- 新的5G SSID
)

if result.connected then
    print("连接成功，IP: " .. result.ip)
else
    print("连接失败: " .. result.conerrmsg)
end
```

### 禁用AP模式

```lua
local XQAPModule = require("xiaoqiang.module.XQAPModule")

-- 禁用有线AP模式
local lanIp = XQAPModule.disableLanAP()

-- 禁用无线AP模式
local lanIp, wifiSsid = XQAPModule.disableWifiAPMode(true)
```
