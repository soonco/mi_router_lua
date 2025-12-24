# XQSysUtil.lua - 系统工具模块

## 概述

`XQSysUtil.lua` 是小米路由器系统级工具模块，提供最全面的系统管理功能，包括隐私设置、固件升级、系统信息、网络诊断、LED控制、MAC/IP过滤等核心功能。这是整个系统中功能最丰富的工具模块之一。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                     XQSysUtil 系统工具模块                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  隐私设置    │  │  固件升级    │  │  系统信息    │              │
│  │  管理模块    │  │  管理模块    │  │  获取模块    │              │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘              │
│         │                │                │                      │
│         ▼                ▼                ▼                      │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    UCI 配置系统                          │    │
│  │  xiaoqiang/common | network | wireless | macfilter      │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  LED控制    │  │  网络诊断    │  │  MAC/IP     │              │
│  │  定时管理    │  │  nettb检测   │  │  过滤管理    │              │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘              │
│         │                │                │                      │
│         ▼                ▼                ▼                      │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              系统命令 / Shell脚本                        │    │
│  │  led_ctl | nettb | macfilter | mkxqimage | nvram        │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘

固件升级流程:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 上传镜像  │───▶│ 验证签名  │───▶│ 刷写固件  │───▶│ 重启系统  │
│ cutImage │    │verifyImage│    │ flash    │    │ reboot   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
      │              │              │              │
      ▼              ▼              ▼              ▼
 checkSpace    secboot_check   getFlashStatus  checkBeenUpgraded
```

## 接口列表

### 隐私与配置管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getPrivacy()` | 无 | `boolean` | 获取隐私设置状态 |
| `setPrivacy(enabled)` | `enabled: boolean` | 无 | 设置隐私状态 |
| `isMiWiFi()` | 无 | `boolean` | 检查是否为MiWiFi设备 |
| `getConfUploadEnable()` | 无 | `boolean` | 获取配置上传启用状态 |
| `setConfUploadEnable(enabled)` | `enabled: boolean` | 无 | 设置配置上传启用状态 |
| `doConfUpload(params)` | `params: table` | 无 | 执行配置上传 |

### 厂商与设备信息

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getVendorInfo()` | 无 | `table{name,hardware,color,version,ip}` | 获取厂商信息 |
| `getBrandInfo()` | 无 | `string` | 获取品牌 ("Redmi"/"Xiaomi") |
| `getHardware()` | 无 | `string` | 获取硬件型号 |
| `getHardwareGPIO()` | 无 | `string` | 获取硬件GPIO版本 |
| `getHardwareVersion()` | 无 | `string` | 通过GPIO获取硬件版本 |
| `getMiscHardwareInfo()` | 无 | `table` | 获取杂项硬件信息 |
| `getSN()` | 无 | `string\|nil` | 获取设备序列号 |
| `getColor()` | 无 | `number` | 获取设备颜色代码 |

### 版本信息

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getRomVersion()` | 无 | `string` | 获取ROM版本 |
| `getDisplayRomVersion()` | 无 | `string` | 获取显示用ROM版本 |
| `getIspVersion()` | 无 | `string` | 获取ISP版本 |
| `getRomBuildtime()` | 无 | `string` | 获取ROM构建时间 |
| `getChannel()` | 无 | `string` | 获取渠道信息 |
| `getCFEVersion()` | 无 | `string` | 获取CFE版本 |
| `getKernelVersion()` | 无 | `string` | 获取内核版本 |
| `getRamFsVersion()` | 无 | `string` | 获取RamFS版本 |
| `getSqaFsVersion()` | 无 | `string` | 获取SquashFS版本 |
| `getRootFsVersion()` | 无 | `string` | 获取RootFS版本 |
| `getHWVersion()` | 无 | `string` | 获取硬件版本号 |
| `getBeta()` | 无 | `string` | 获取Beta版本标识 |

### 初始化与绑定

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getInitInfo()` | 无 | `boolean` | 获取初始化状态 |
| `setInited()` | 无 | `boolean` | 设置系统为已初始化 |
| `initMeshVersion()` | 无 | 无 | 初始化Mesh版本 |
| `getPassportBindInfo()` | 无 | `string\|false` | 获取通行证绑定信息 |
| `setPassportBound(bound, uuid)` | `bound: boolean, uuid: string` | `boolean` | 设置通行证绑定状态 |
| `getBindUUID()` | 无 | `string` | 获取绑定UUID |
| `getBindinfo()` | 无 | `number` | 获取绑定信息 |

### 路由器设置

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getRouterName()` | 无 | `string` | 获取路由器名称 |
| `setRouterName(name)` | `name: string` | `boolean` | 设置路由器名称 |
| `getRouterLocale()` | 无 | `string` | 获取路由器区域设置 |
| `setRouterLocale(locale)` | `locale: string` | 无 | 设置路由器区域 |
| `getRouterInfo()` | 无 | `string` | 获取路由器信息(JSON) |
| `getRouterInfo4Trafficd()` | 无 | `string` | 获取路由器信息(trafficd用) |

### 密码管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `checkSysPassword(password)` | `password: string` | `boolean` | 检查系统密码 |
| `setSysPassword(password)` | `password: string` | `boolean` | 设置系统密码 |
| `setSysPasswordDefault()` | 无 | 无 | 设置默认系统密码 |
| `setSPwd()` | 无 | 无 | 设置特殊密码(从镜像获取) |

### 语言与位置

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getLang()` | 无 | `string` | 获取当前语言 |
| `setLang(lang)` | `lang: string` | `boolean` | 设置语言 |
| `getLangList()` | 无 | `table` | 获取语言列表 |
| `getLocation()` | 无 | `string` | 获取当前位置/国家代码 |
| `setLocation(countryCode, restartAgent, region)` | `countryCode: string, restartAgent: boolean, region: string` | `boolean` | 设置位置/国家代码 |
| `specialRegionEnable()` | 无 | `number` | 检查是否启用特殊区域 |

### 固件升级

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `verifyImage(imagePath, checkOta)` | `imagePath: string, checkOta: boolean` | `boolean` | 验证固件镜像 |
| `cutImage(imagePath)` | `imagePath: string` | `boolean` | 裁剪镜像 |
| `ota_verifyImage(imagePath)` | `imagePath: string` | `boolean` | OTA镜像验证 |
| `cpe_verifyImage(imagePath)` | `imagePath: string` | `boolean` | CPE镜像验证 |
| `verifyCPEImage(header, modem, sign)` | `header, modem, sign: string` | `boolean` | 验证CPE镜像 |
| `getUpgradeStatus()` | 无 | `number` | 获取升级状态 |
| `updateUpgradeStatus(status)` | `status: number` | 无 | 更新升级状态 |
| `checkUpgradeStatus()` | 无 | `number` | 检查升级状态 |
| `isUpgrading()` | 无 | `boolean` | 检查是否正在升级 |
| `cancelUpgrade()` | 无 | `boolean` | 取消升级 |
| `getFlashStatus()` | 无 | `number` | 获取刷写状态 |
| `getFlashProgress()` | 无 | `number` | 获取刷写进度 |
| `getUpgradeResult()` | 无 | `number` | 获取升级结果 |
| `checkBeenUpgraded()` | 无 | `boolean` | 检查是否已升级 |
| `getFlashPermission()` | 无 | `boolean` | 获取刷写权限 |
| `setFlashPermission(enabled)` | `enabled: boolean` | 无 | 设置刷写权限 |
| `getOtapred()` | 无 | `number` | 获取OTA预下载设置 |

### 系统信息与资源

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getSysInfo()` | 无 | `table` | 获取系统信息 |
| `getSysUptime()` | 无 | `string` | 获取系统运行时间 |
| `getConfigInfo()` | 无 | `string` | 获取所有配置信息 |
| `getDiskSpace()` | 无 | `string` | 获取磁盘空间 |
| `getAvailableMemery()` | 无 | `number\|false` | 获取可用内存 |
| `getAvailableDisk(cmd)` | `cmd: string` | `number\|false` | 获取可用磁盘空间 |
| `getAvailableSpace(path)` | `path: string` | `number` | 获取可用空间 |
| `checkDiskSpace(size)` | `size: number` | `boolean` | 检查磁盘空间是否足够 |
| `checkTmpSpace(size)` | `size: number` | `boolean` | 检查临时空间是否足够 |
| `checkSpace(path, size)` | `path: string, size: number` | `boolean` | 检查空间是否足够 |
| `getCpuTemperature()` | 无 | `number` | 获取CPU温度 |
| `checkSystemStatus()` | 无 | `table` | 检查系统状态 |

### 网络诊断

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getNetworkDetectInfo(mode, url)` | `mode: number, url: string` | `table\|nil` | 获取网络检测信息 |
| `nettb()` | 无 | `table` | 网络诊断 |
| `nettb2(param)` | `param: string` | `table` | 网络诊断2 |

### MAC/IP过滤

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setmacfilterenablemode(enable, mode, filter)` | `enable, mode, filter: string` | `number` | 设置MAC过滤启用模式 |
| `setipfilterenablemode(enable, mode, filter)` | `enable, mode, filter: string` | `number` | 设置IP过滤启用模式 |
| `getMacfilterEnable(filter)` | `filter: string` | `string` | 获取MAC过滤启用状态 |
| `getMacfilterMode(filter)` | `filter: string` | `number` | 获取MAC过滤模式 |
| `setMacfilterMode(filter, mode)` | `filter, mode: string` | `boolean` | 设置MAC过滤模式 |

### LED控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getLedStatus()` | 无 | `number` | 获取LED状态 |
| `setLedStatus(enabled)` | `enabled: boolean` | 无 | 设置LED状态 |
| `setLedTimer(enabled, openTime, closeTime)` | `enabled: boolean, openTime, closeTime: string` | `number` | 设置LED定时器 |
| `disableLedMeshSync()` | 无 | 无 | 禁用LED Mesh同步 |

### 其他工具

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getChangeLog()` | 无 | `string` | 获取更新日志 |
| `getNvramConfigs()` | 无 | `table` | 获取NVRAM配置 |
| `getDetectionTimestamp()` | 无 | `number` | 获取检测时间戳 |
| `setDetectionTimestamp()` | 无 | 无 | 设置检测时间戳 |
| `getWifiLog()` | 无 | 无 | 收集WiFi日志 |
| `backupSysLog()` | 无 | `string\|nil` | 备份系统日志 |
| `noflushdStatus()` | 无 | `number` | 获取noflushd状态 |
| `noflushdSwitch(enabled)` | `enabled: boolean` | `boolean` | noflushd开关 |
| `getUploadDir()` | 无 | `string` | 获取上传目录 |
| `getUploadRomFilePath()` | 无 | `string` | 获取上传ROM文件路径 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.XQPreference` | 偏好设置存储 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.XQCountryCode` | 国家代码处理 |
| `xiaoqiang.util.XQSecureUtil` | 安全工具 |
| `xiaoqiang.util.XQSynchrodata` | 数据同步 |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN工具 |
| `xiaoqiang.util.XQDownloadUtil` | 下载工具 |
| `xiaoqiang.util.XQDBUtil` | 数据库工具 |
| `luci.model.uci` | UCI配置接口 |
| `luci.util` | LuCI工具函数 |
| `luci.sys` | 系统信息接口 |
| `luci.fs` | 文件系统操作 |
| `nixio.fs` | 文件系统操作 |
| `ubus` | ubus通信 |
| `json` / `cjson` | JSON处理 |

## 被引用情况

该模块被以下模块引用：
- `luci/controller/api/misystem.lua` - 系统API接口
- `luci/controller/api/xqsystem.lua` - 系统控制器
- `xiaoqiang/module/XQNetworkSpeedTest.lua` - 网络测速
- `xiaoqiang/util/XQWifiUtil.lua` - WiFi工具
- `xiaoqiang/util/XQSecureUtil.lua` - 安全工具
- 其他多个控制器和模块

## 关键代码说明

### 网络诊断错误码表
```lua
NETTB = {
    ["1"] = "路由器没有检测到WAN口网线接入",
    ["2"] = "DHCP服务没有响应",
    ["3"] = "宽带拨号服务无响应",
    ["4"] = "上级网络IP与路由器局域网IP有冲突",
    ["5"] = "网关不可达",
    ["6"] = "DNS服务器无法服务",
    ["7"] = "自定义的DNS无法服务",
    ["8"] = "无线中继，无法中继上级",
    ["9"] = "有线中继，无法中继上级",
    ["10"] = "静态IP，连接时连接断开",
    ["11"] = "mesh从设备，无法连接主路由",
    ["12"] = "SIM卡验证问题",
    ["13"] = "蜂窝数据未开启",
    ["14"] = "注网失败",
    ["15"] = "无蜂窝信号",
    ...
}
```

### 升级状态码
- `0` - 空闲
- `1` - 检查中
- `2-4` - 下载中
- `5` - 刷写中
- `10` - 等待中
- `11` - 已升级
- `12` - 刷写检查中

### LED定时器格式
```lua
-- 时间格式: HH:MM (24小时制)
setLedTimer(true, "08:00", "22:00")  -- 8点开启，22点关闭
```
