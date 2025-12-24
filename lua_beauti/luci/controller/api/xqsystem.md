# xqsystem.lua - 系统管理API控制器

## 概述

`xqsystem.lua` 是小米路由器最核心的系统管理 API 控制器，提供全面的系统管理功能，包括用户认证、系统初始化、固件升级、设备管理、VPN 配置、防火墙设置等。该模块是路由器 Web 管理界面和 APP 的主要后端接口。

**模块路径**: `luci.controller.api.xqsystem`  
**API 基础路径**: `/api/xqsystem/*`  
**认证方式**: JSON 认证 (`jsonauth`)，需要管理员权限  
**代码行数**: ~2400 行

## 工作原理

1. **路由注册**: 通过 `index()` 函数注册所有 API 路由，部分路由根据设备功能特性动态启用
2. **认证机制**: 使用 JSON 认证方式，支持 nonce 防重放攻击
3. **功能模块化**: 按功能分组组织 API，便于维护和扩展
4. **条件性 API**: 根据 `XQFeatures` 配置动态启用高级功能（如 NAT Pro、防火墙）

## 功能模块

| 模块 | 说明 | API 数量 |
|-----|------|---------|
| 认证相关 | 登录、Token 管理 | 4 |
| 系统初始化 | 初始化信息、工厂信息 | 5 |
| 密码管理 | 管理员密码设置 | 1 |
| 固件升级 | ROM 检查、上传、刷写 | 10 |
| 插件管理 | 插件上传、安装列表 | 2 |
| 路由器信息 | 名称、状态、设备列表 | 10 |
| 系统操作 | 重启、重置、关机 | 5 |
| 绑定相关 | Passport 绑定 | 6 |
| 语言设置 | 多语言支持 | 3 |
| VPN 配置 | VPN 管理 | 6 |
| MAC 过滤 | 访问控制 | 4 |
| 端口转发 | DMZ、NAT 配置 | 10+ |
| 防火墙 | SPI、DoS 防护 | 10+ |

## 接口列表

### 认证相关 API

#### actionLogin()
**功能**: 用户登录处理

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| init | number | 否 | 是否初始化登录（1=是）|
| privacy | number | 否 | 隐私设置（1=同意）|
| callback | string | 否 | JSONP 回调函数名 |

**返回值**:
```json
{
  "code": 0,
  "url": "跳转URL",
  "token": "会话Token"
}
```

---

#### getToken()
**功能**: 获取当前会话 Token

**返回值**:
```json
{
  "code": 0,
  "token": "会话Token",
  "id": "设备序列号",
  "name": "路由器名称"
}
```

---

#### renewToken()
**功能**: 刷新会话 Token

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| ip | string | 否 | 客户端 IP |

**返回值**:
```json
{
  "code": 0,
  "token": "新Token"
}
```

---

### 系统初始化 API

#### getInitInfo()
**功能**: 获取路由器初始化信息

**返回值**:
```json
{
  "code": 0,
  "connect": 1,
  "inited": 1,
  "bound": 0,
  "id": "序列号",
  "routerId": "设备ID",
  "hardware": "硬件型号",
  "model": "完整型号",
  "romversion": "固件版本",
  "language": "语言",
  "countrycode": "国家代码",
  "routername": "路由器名称",
  "isSupportMesh": true,
  "features": {}
}
```

---

#### setRouter()
**功能**: 路由器初始化配置（设置 WiFi、密码、WAN）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| nonce | string | 是 | 防重放随机数 |
| oldPwd | string | 否 | 旧密码 |
| newPwd | string | 否 | 新密码 |
| newPwd256 | string | 否 | SHA256 加密的新密码 |
| wifiPwd | string | 否 | WiFi 密码 |
| wifi24Ssid | string | 否 | 2.4G WiFi 名称 |
| wifi50Ssid | string | 否 | 5G WiFi 名称 |
| wanType | string | 否 | WAN 类型（pppoe/dhcp）|
| pppoeName | string | 否 | PPPoE 用户名 |
| pppoePwd | string | 否 | PPPoE 密码 |

---

### 密码管理 API

#### setPassword()
**功能**: 设置管理员密码

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| nonce | string | 是 | 防重放随机数 |
| oldPwd | string | 是 | 旧密码 |
| newPwd | string | 是 | 新密码 |
| newPwd256 | string | 否 | SHA256 加密的新密码 |

**错误码**:
- 1502: 参数缺失
- 1523: nonce 无效
- 1552: 旧密码错误
- 1553: 保存失败
- 1582: nonce 校验失败

---

### 固件升级 API

#### checkRomUpdate()
**功能**: 检查 ROM 更新

**返回值**:
```json
{
  "code": 0,
  "status": {"status": 0, "percent": 0},
  "needUpdate": true,
  "version": "新版本号",
  "changeLog": "更新日志"
}
```

---

#### upgradeRom()
**功能**: 升级 ROM

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| url | string | 否 | ROM 下载地址 |
| filesize | string | 否 | 文件大小 |
| hash | string | 否 | 文件哈希 |
| needpermission | number | 否 | 是否需要权限确认 |

---

#### uploadRom()
**功能**: 上传 ROM 文件

**参数**: 通过 multipart/form-data 上传 `image` 文件

**返回值**:
```json
{
  "code": 0,
  "downgrade": false
}
```

---

#### flashRom()
**功能**: 刷写 ROM

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| custom | number | 否 | 是否自定义 ROM（1=是）|
| recovery | number | 否 | 是否恢复模式（1=是）|

---

### 系统操作 API

#### reboot()
**功能**: 重启路由器

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| client | string | 否 | 客户端类型（web/app）|

**返回值**:
```json
{
  "code": 0,
  "lanIp": "192.168.31.1"
}
```

---

#### reset()
**功能**: 恢复出厂设置

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| format | number | 否 | 是否格式化用户磁盘（1=是）|

**特殊处理**: 
- Mesh 主路由会通过 MQTT 通知子节点恢复
- 会重置智能家居场景配置

---

### 设备管理 API

#### getDeviceList()
**功能**: 获取连接设备列表

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| all | number | 否 | 是否获取所有设备（1=是）|

**返回值**:
```json
{
  "code": 0,
  "mac": "当前设备MAC",
  "list": [...]
}
```

---

#### setDeviceNickName()
**功能**: 设置设备昵称

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| mac | string | 是 | 设备 MAC 地址 |
| name | string | 是 | 昵称 |
| owner | string | 否 | 所有者 |
| device | string | 否 | 设备类型 |

---

### VPN 配置 API

#### vpnInfo()
**功能**: 获取 VPN 信息

#### vpnStatus()
**功能**: 获取 VPN 连接状态

#### vpnSwitch()
**功能**: VPN 开关

#### setVpn()
**功能**: 设置 VPN 配置

#### delVpn()
**功能**: 删除 VPN 配置

---

### MAC 过滤 API

#### setMacFilter()
**功能**: 设置 MAC 过滤规则

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| mac | string | 是 | MAC 地址 |
| wan | string | 否 | WAN 访问权限 |
| lan | string | 否 | LAN 访问权限 |
| name | string | 否 | 设备名称 |
| option | string | 否 | 过滤选项 |

---

### DMZ 配置 API

#### getDMZInfo()
**功能**: 获取 DMZ 信息

#### setDMZ()
**功能**: 设置 DMZ

#### closeDMZ()
**功能**: 关闭 DMZ

---

### 条件性 API（基于功能特性）

#### NAT Pro 功能（端口转发高级版）
当 `FEATURES.apps.natpro == "1"` 时启用：
- `get_vs_rules()` - 获取虚拟服务器规则
- `set_vs_rules()` - 设置虚拟服务器规则
- `set_vs_range_rules()` - 设置范围规则
- `del_vs_rules()` - 删除规则
- `apply_vs_rules()` - 应用规则
- `get_pt_rules()` - 获取端口触发规则
- `set_pt_rules()` - 设置端口触发规则
- `set_alg_rules()` - 设置 ALG 规则

#### 防火墙功能
当 `FEATURES.apps.firewall == "1"` 时启用：
- `set_firewall_enable()` - 防火墙开关
- `set_spi_firewall()` - SPI 防火墙
- `set_dos_firewall()` - DoS 防护
- `set_wanping_firewall()` - WAN Ping 防护
- `get_macfilter_info()` - MAC 过滤信息
- `get_ipfilter_info()` - IP 过滤信息

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统操作 |
| `luci.model.uci` | UCI 配置管理 |
| `luci.sauth` | 会话认证 |
| `luci.fs` | 文件系统操作 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理 |
| `xiaoqiang.util.XQSecureUtil` | 安全工具 |
| `xiaoqiang.util.XQLanWanUtil` | 网络工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQNetUtil` | 网络工具 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.XQLog` | 日志模块 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `xiaoqiang.module.XQExtendWifi` | 扩展 WiFi 模块 |
| `xiaoqiang.module.XQAPModule` | AP 模块 |

## 被引用情况

该模块是路由器最核心的 API 控制器，被以下场景广泛使用：
- 路由器 Web 管理界面
- 小米路由器 APP
- 第三方管理工具
- 自动化脚本

## 关键代码说明

### 密码保存机制
```lua
local function _savePassword(nonce, oldPwd, newPwd, newPwd256)
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    
    -- 验证 nonce 防重放
    if not XQSecureUtil.checkNonce(nonce, remoteMac) then
        return 1582
    end
    
    -- 验证旧密码
    if not XQSecureUtil.checkUser("admin", nonce, oldPwd) then
        return 1552
    end
    
    -- 根据加密模式保存密码
    local encryptMode = XQSysUtil.getEncryptMode()
    if encryptMode == 1 then
        XQSecureUtil.saveCiphertextLegacyPwd("admin", newPwd)
        XQSecureUtil.saveCiphertextPwd("admin", newPwd256)
    else
        XQSecureUtil.saveCiphertextPwd("admin", newPwd)
    end
    
    -- 同步到 Mesh 子节点
    XQFunction.forkExec("/sbin/whc_to_re_common_api.sh webpasswd_update")
end
```

### Mesh 网络恢复出厂
```lua
function reset()
    if XQFunction.isMeshCap() then
        resetCmd = "ubus call xq_info_sync_mqtt restore >/dev/null 2>/dev/null ;" .. resetCmd
    end
    
    -- 重置智能家居场景
    XQFunction.thrift_tunnel_to_smarthome_controller("{\"command\":\"reset_scenes\"}")
    XQFunction.forkExec(resetCmd)
end
```

### 功能特性动态路由
```lua
if FEATURES.apps and FEATURES.apps.natpro == "1" then
    entry({"api", "xqsystem", "get_vs_rules"}, call("get_vs_rules"), "", 300)
    -- ... 更多 NAT Pro 路由
else
    entry({"api", "xqsystem", "portforward"}, call("portForward"), "", 311)
    -- ... 基础端口转发路由
end
```
