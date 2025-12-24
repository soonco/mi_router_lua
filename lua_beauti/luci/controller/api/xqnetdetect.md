# xqnetdetect.lua - 小米网络检测 API 控制器模块

## 概述

小米网络检测 API 控制器模块（XQ Network Detect API Controller），提供网络检测和诊断相关的 API 接口，包括 WAN 状态检测、系统信息获取、网络连通性测试、系统诊断、网速测试和网络故障排查等功能。

**文件路径**: `luci/controller/api/xqnetdetect.lua`  
**模块名称**: `luci.controller.api.xqnetdetect`  
**API 路径**: `/api/xqnetdetect/*`

## 工作原理

1. **系统诊断**: 检测 CPU、内存、温度、网络等多项指标
2. **网速测试**: 执行上传/下载速度测试
3. **故障排查**: 支持单 WAN 和多 WAN 的网络故障诊断
4. **IPv6 支持**: 故障排查支持 IPv4/IPv6 双栈检测

## 接口/函数列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getIPv6Name(wanName)` | wanName: string | string/nil | 根据 WAN 接口名获取对应的 IPv6 接口 |
| `getNettbRes(wan4Name, wan4Result, wan6Name, wan6Result)` | 多参数 | string, number | 比较 IPv4/IPv6 检测结果，返回最佳结果 |

### API 端点

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqnetdetect/nettb` | `nettb()` | 1 | 网络故障排查（单 WAN） |
| `/api/xqnetdetect/nettb2` | `nettb2()` | 1 | 网络故障排查（多 WAN） |

### 其他函数（未注册为路由）

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getWanStatus()` | 无 | JSON | 获取 WAN 状态 |
| `getSysInfo()` | 无 | JSON | 获取系统信息 |
| `pingTest()` | url: string | JSON | Ping 测试 |
| `systemDiagnostics()` | simple, target | JSON | 系统诊断 |
| `systemStatus()` | 无 | JSON | 系统状态快速检查 |
| `netspeed()` | history: boolean | JSON | 网速测试 |
| `uploadSpeed()` | 无 | JSON | 上传速度测试 |

### 详细接口说明

#### systemDiagnostics - 系统诊断

**检测项目**:
| 项目 | 异常阈值 | 说明 |
|------|----------|------|
| CPU 温度 | >70°C | 过热警告 |
| CPU 负载 | >90% | 负载过高 |
| 内存使用 | >90% | 内存不足 |
| WAN 连接 | 未连接 | 网络断开 |
| 网关丢包 | >80% | 网关不稳定 |
| DNS 状态 | 异常 | DNS 解析失败 |
| Ping 丢包 | >80% | 网络不稳定 |
| WiFi 密码 | 弱密码 | 安全风险 |

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| simple | number | 否 | 简化模式 |
| target | string | 否 | 测试目标 |

**返回值**:
```json
{
    "code": 0,
    "status": 0,
    "count": 0,
    "cpuavg": {"loadavg": 10, "status": 1},
    "memoryuse": {"use": 50, "status": 1},
    "cputemp": {"temperature": 45, "status": 1},
    "link": {"status": 1},
    "wan": {"type": 1, "status": 1},
    "gateway": {"lost": 0, "status": 1},
    "dnsstatus": {"status": 1},
    "ping": {"lost": 0, "status": 1},
    "wifi": {"same": 0, "strong": 1},
    "speed": {"lan": 1000, "wan": 100},
    "disk": {"Used": "10.5G", "Available": "50.2G"}
}
```

**状态码说明**:
- `status: 0` - 正常
- `status: 1` - 警告
- `status: 2` - 错误

#### netspeed - 网速测试

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| history | boolean | 否 | 是否获取历史记录 |

**返回值**:
```json
{
    "code": 0,
    "download": 12500,
    "bandwidth": 100,
    "upload": 6250,
    "bandwidth2": 50
}
```

#### nettb2 - 多 WAN 故障排查

**返回值**:
```json
{
    "code": 0,
    "on": 1,
    "info": [
        {
            "wanname": "WAN1",
            "name": "wan",
            "wantype": "dhcp",
            "disabled": 0,
            "error": 0
        },
        {
            "wanname": "WAN2",
            "name": "wan_2",
            "wantype": "pppoe",
            "disabled": 0,
            "error": 0
        }
    ]
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQSecureUtil` | 安全工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.XQPreference` | 偏好设置 |
| `xiaoqiang.module.XQNetworkSpeedTest` | 网络测速模块 |
| `xiaoqiang.module.XQMultiWanPolicy` | 多 WAN 策略模块 |
| `xiaoqiang.XQPushHelper` | 推送助手 |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.sys` | 系统信息 |
| `luci.model.uci` | UCI 配置 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/xqnetdetect/*` 路径下自动加载
- 小米路由器 APP 的网络诊断功能
- Web 管理界面的网络检测工具

## 故障排查错误码

| 错误码 | 说明 |
|--------|------|
| 0 | 正常 |
| 1 | WAN 口未连接 |
| 2 | 无法获取 IP |
| 3 | 网关不可达 |
| 4 | DNS 解析失败 |
| 5 | 互联网不可达 |

## 关键代码说明

### 系统诊断流程

```lua
function systemDiagnostics()
    -- 获取网络流量统计
    local lanStats = XQDeviceUtil.getWanLanNetworkStatistics("lan")
    local wanStats = XQDeviceUtil.getWanLanNetworkStatistics("wan")
    
    -- 获取 CPU 温度
    local cpuTemp = XQSysUtil.getCpuTemperature()
    
    -- 执行网络检测
    local detectInfo = XQSysUtil.getNetworkDetectInfo(simple, target)
    
    -- 检查 WiFi 密码安全性
    for _, wifi in ipairs(wifiList) do
        if XQSecureUtil.checkPlaintextPwd("admin", wifi.password) then
            sameAsAdmin = true
        end
        if XQSecureUtil.checkStrong(wifi.password) < 2 then
            strongPassword = false
        end
    end
end
```

### 多 WAN 故障排查

```lua
function nettb2()
    -- 获取多 WAN 状态
    result.on = XQMultiWanPolicy.getStatus()
    
    -- 遍历所有网络接口
    uci:foreach("network", "interface", function(section)
        local ifName = section[".name"]
        
        -- 处理 WAN 接口
        if prefix == "wan_" or ifName == "wan" then
            -- 执行故障排查
            local nettbResult = XQSysUtil.nettb2(ifName)
            
            -- 如果 IPv4 检测失败，尝试 IPv6
            if nettbResult.code ~= 0 then
                local wan6Name = getIPv6Name(ifName)
                if wan6Name then
                    local wan6Result = XQSysUtil.nettb2(wan6Name)
                    -- 选择最佳结果
                end
            end
        end
    end)
end
```

### 网速测试

```lua
function netspeed()
    -- 停止 QoS 以获得准确结果
    os.execute("/etc/init.d/miqos stop")
    
    local downloadSpeed = XQNetworkSpeedTest.downloadSpeedTest()
    
    if downloadSpeed then
        result.download = downloadSpeed
        result.bandwidth = downloadSpeed * 8 / 1024
        XQPreference.set("BANDWIDTH", result.bandwidth, "xiaoqiang")
    end
    
    -- 恢复 QoS
    os.execute("/etc/init.d/miqos start")
end
```

## 注意事项

1. 网速测试会临时停止 QoS 服务以获得准确结果
2. 系统诊断会推送网速信息到云端
3. 多 WAN 故障排查支持 IPv4/IPv6 双栈检测
4. 诊断结果会记录到日志系统
