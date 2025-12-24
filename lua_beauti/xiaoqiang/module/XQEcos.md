# XQEcos.lua - Ecos子设备管理模块

## 概述

XQEcos 是小米路由器的生态链(Ecos)子设备管理模块。该模块用于管理小米WiFi放大器等扩展设备，支持设备信息查询、固件升级、无线漫游切换等功能。通过 trafficd 服务和 tbus 协议与子设备通信。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        XQEcos 子设备管理模块                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────┐    ubus call     ┌──────────────┐                     │
│  │  XQEcos      │ ───────────────► │  trafficd    │                     │
│  │  Module      │    trafficd hw   │  服务        │                     │
│  └──────────────┘                  └──────────────┘                     │
│         │                                 │                              │
│         │                                 │ 设备硬件信息                 │
│         │                                 ▼                              │
│         │                          ┌──────────────┐                     │
│         │                          │  设备列表    │                     │
│         │                          │  ├─ R01     │                     │
│         │                          │  ├─ R02     │                     │
│         │                          │  └─ R03     │                     │
│         │                          └──────────────┘                     │
│         │                                                                │
│         │  tbus call              ┌──────────────┐                      │
│         │ ──────────────────────► │  Ecos设备    │                      │
│         │  (IP地址)               │  (WiFi放大器) │                      │
│         │                         └──────────────┘                      │
│         │                                                                │
│         ▼                                                                │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        功能操作                                   │   │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐  │   │
│  │  │设备信息    │  │信号强度    │  │固件升级    │  │漫游切换    │  │   │
│  │  │查询        │  │检测        │  │管理        │  │控制        │  │   │
│  │  └────────────┘  └────────────┘  └────────────┘  └────────────┘  │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 信号强度等级

```
┌─────────────────────────────────────────────────────────────────┐
│                      信号强度等级划分                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   信号强度 (dBm)        等级        描述                        │
│   ─────────────────────────────────────────────────────────     │
│   > -60 dBm             1          信号强                       │
│   -70 ~ -60 dBm         2          信号中等                     │
│   < -70 dBm             3          信号弱                       │
│                                                                  │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  -100    -90    -80    -70    -60    -50    -40    -30  │   │
│   │    │      │      │      │      │      │      │      │   │   │
│   │    ├──────┴──────┴──────┤      ├──────┴──────┴──────┤   │   │
│   │         弱(3)                        强(1)              │   │
│   │                         中等(2)                         │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 设备发现与筛选流程

```
┌─────────────┐                    ┌─────────────┐
│  XQEcos     │                    │  trafficd   │
└──────┬──────┘                    └──────┬──────┘
       │                                   │
       │  ubus call trafficd hw           │
       │ ─────────────────────────────────►│
       │                                   │
       │  返回所有硬件设备信息             │
       │ ◄─────────────────────────────────│
       │                                   │
       │  筛选条件:                        │
       │  1. hardware ∈ {R01,R02,R03}     │
       │  2. is_ap != 0 (AP模式)          │
       │  3. assoc == 1 (已关联)          │
       │  4. 有IP地址                      │
       │                                   │
       ▼                                   │
  ┌─────────────┐                          │
  │ Ecos设备列表│                          │
  └─────────────┘                          │
```

## 接口列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `_getEcosDevices()` | 无 | `devices:table` key为MAC地址 | 获取所有Ecos子设备列表 |
| `_getEcosSignal(mac)` | `mac:string` MAC地址 | `level:number` 1/2/3 或 nil | 获取信号强度等级 |
| `_getEcosSignalDB(mac)` | `mac:string` MAC地址 | `signal:number` dBm值 | 获取信号强度值 |
| `_getEcosUpgrade(version, channel, sn, ctycode)` | `version:string`, `channel:string`, `sn:string`, `ctycode:string` | `upgradeInfo:table` 或 nil | 检查设备升级 |
| `_getEcosWRoamingStatus(ip)` | `ip:string` 设备IP | `status:number` 0/1 | 获取漫游状态 |

### 公开接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getEcosInfo(mac)` | `mac:string` 设备MAC地址 | `info:table` 或 nil | 获取设备详细信息 |
| `ecosWirelessRoamingSwitch(mac, enable)` | `mac:string`, `enable:boolean` | `success:boolean` | 切换无线漫游功能 |
| `ecosUpgrade(mac)` | `mac:string` 设备MAC地址 | 无 | 触发固件升级 |
| `ecosUpgradeStatus(mac)` | `mac:string` 设备MAC地址 | `status:number` | 获取升级状态 |

## 数据结构

### 设备信息结构

```lua
{
    mac = "AA:BB:CC:DD:EE:FF",  -- MAC地址
    version = "1.0.0",          -- 固件版本
    channel = "current",        -- 升级通道
    color = "white",            -- 设备颜色
    sn = "12345678",            -- 序列号
    ctycode = "CN",             -- 国家代码
    ip = "192.168.31.100"       -- IP地址
}
```

### 详细信息结构 (getEcosInfo返回)

```lua
{
    upgrade = true/false,       -- 是否有可用升级
    upgradeinfo = {...},        -- 升级信息(如有)
    signal = 1/2/3,             -- 信号等级
    signalDB = -55,             -- 信号强度(dBm)
    roaming = 0/1,              -- 漫游状态
    version = "1.0.0",          -- 固件版本
    channel = "current",        -- 升级通道
    color = "white",            -- 设备颜色
    ip = "192.168.31.100"       -- IP地址
}
```

## 支持的设备型号

| 型号 | 说明 |
|------|------|
| R01 | 小米WiFi放大器第一代 |
| R02 | 小米WiFi放大器第二代 |
| R03 | 小米WiFi放大器Pro |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `json` | JSON编解码 |
| `luci.util` | 命令执行 |
| `nixio.fs` | 文件系统操作 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQWifiUtil` | WiFi信号获取 |
| `xiaoqiang.util.XQNetUtil` | 升级检查 |

## 被引用情况

该模块主要被以下组件引用：
- WiFi放大器管理界面
- 小米WiFi APP设备管理
- Mesh网络管理功能

## 关键代码说明

### 设备筛选逻辑

```lua
function _getEcosDevices()
    local output = util.exec("ubus call trafficd hw")
    local hwInfo = json.decode(output)
    
    for mac, device in pairs(hwInfo) do
        local parseOk, description = pcall(json.decode, device.description)
        
        if parseOk and description then
            -- 检查是否为支持的硬件型号
            if description.hardware and SUPPORTED_HARDWARE[description.hardware] then
                -- 检查是否为AP模式且已关联
                local isAp = tonumber(device.is_ap)
                local assoc = tonumber(device.assoc)
                
                if isAp ~= 0 and assoc == 1 then
                    -- 构建设备信息...
                    if deviceInfo.ip then
                        devices[mac] = deviceInfo
                    end
                end
            end
        end
    end
    
    return devices
end
```

### tbus通信

```lua
function _getEcosWRoamingStatus(ip)
    -- 通过tbus调用设备获取描述信息
    local cmd = "tbus call " .. ip .. " desc \"{\\\"desc\\\":1}\" 2>/dev/null"
    local output = util.exec(cmd)
    
    if output then
        local ok, result = pcall(json.decode, output)
        if ok then
            return result.switch_wifi_explorer or 0
        end
    end
    
    return 0
end

function ecosWirelessRoamingSwitch(mac, enable)
    local enableStr = enable and "1" or "0"
    local cmd = "tbus call " .. device.ip .. " switch \"{\\\"wifi_explorer\\\":" .. enableStr .. "}\" >/dev/null 2>/dev/null"
    local result = os.execute(cmd)
    return result == 0
end
```

### 异步升级

```lua
function ecosUpgrade(mac)
    if mac then
        -- 创建升级状态标记文件
        os.execute("echo 1 > /tmp/" .. mac)
        
        -- 异步执行升级脚本
        local cmd = "lua /usr/sbin/ecos_upgrade.lua " .. mac .. " 2>/dev/null"
        XQFunction.forkExec(cmd)
    end
end

function ecosUpgradeStatus(mac)
    -- 读取状态文件
    local statusFile = "/tmp/" .. mac
    local content = fs.readfile(statusFile)
    return tonumber(content) or 0
end
```

## 升级状态码

| 状态码 | 说明 |
|--------|------|
| 0 | 未开始/已完成 |
| 1 | 正在升级 |
| 其他 | 升级进度百分比 |
