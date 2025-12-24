# xqsmarthome.lua - 智能家居控制API模块

## 概述

`xqsmarthome.lua` 是小米路由器智能家居控制的 API 控制器模块，提供与小米生态链智能设备通信的接口。该模块通过 Thrift 隧道协议将请求转发到各类智能设备，支持多种小米 IoT 平台设备的控制。

**模块路径**: `luci.controller.api.xqsmarthome`  
**API 基础路径**: `/api/xqsmarthome/*`  
**认证方式**: JSON 认证 (`jsonauth`)，需要管理员权限

## 工作原理

1. **请求转发机制**: 接收 HTTP 请求中的 payload 参数，进行 Base64 编码后通过 Thrift 隧道命令转发到对应的智能设备服务
2. **Mesh 网络支持**: 在 Mesh 组网模式下，对于重启和 WiFi 关闭等操作，通过 MQTT 协议同步到其他节点
3. **设备类型区分**: 根据不同设备类型（SmartHome、MIIO、Yeelink、MiTV、Camera）使用不同的隧道通道

## 支持的设备类型

| 设备类型 | 说明 | 通信协议 |
|---------|------|---------|
| SmartHome | 智能家居设备 | Thrift 隧道 |
| SmartController | Mesh 网络下的智能控制器 | Thrift 隧道 + MQTT |
| MIIO | 小米 IoT 平台设备 | MIIO 协议 |
| Yeelink | 易来智能灯具 | MIIO 协议 |
| MiTV | 小米电视 | 专用协议 |
| Camera | 小米摄像头 | 专用协议 |

## 接口列表

### index()
**功能**: 模块路由注册入口

注册以下 API 端点：
- `/api/xqsmarthome/request` - 智能家居请求隧道
- `/api/xqsmarthome/request_smartcontroller` - 智能控制器请求
- `/api/xqsmarthome/request_miio` - MIIO 设备请求
- `/api/xqsmarthome/request_mitv` - 小米电视请求
- `/api/xqsmarthome/request_yeelink` - Yeelink 设备请求
- `/api/xqsmarthome/request_camera` - 摄像头请求
- `/api/xqsmarthome/request_miiolist` - 获取 MIIO 设备列表

---

### tunnelSmartHomeRequest()
**功能**: 智能家居请求隧道

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷（JSON 格式）|

**返回值**: 命令执行结果（原始输出）

**处理流程**:
1. 获取 HTTP 请求中的 payload 参数
2. 使用 Base64 编码 payload
3. 通过 `THRIFT_TUNNEL_TO_SMARTHOME` 命令模板发送请求
4. 返回执行结果

---

### tunnelSmartControllerRequest()
**功能**: 智能控制器请求隧道（支持 Mesh 网络）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷（JSON 格式），包含 command 字段 |

**返回值**: 命令执行结果

**特殊处理**:
- 在 Mesh 模式下，对于 `normal_reboot`（重启）和 `normal_wifi_down`（关闭 WiFi）操作，通过 MQTT 同步到其他节点
- 使用 `xq_info_sync_mqtt` ubus 服务进行消息同步

---

### guest_tunnelSmartControllerRequest(encodedPayload)
**功能**: 访客模式下的智能控制器请求（内部函数）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| encodedPayload | string | 是 | 已 Base64 编码的请求载荷 |

**返回值**: 无

---

### tunnelMiioRequest()
**功能**: MIIO 设备请求隧道

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷 |

**返回值**: 命令执行结果

---

### tunnelYeelink()
**功能**: Yeelink 智能灯设备请求隧道

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷 |

**返回值**: 命令执行结果

**说明**: Yeelink 设备实际使用 MIIO 协议通信

---

### requestMitv()
**功能**: 小米电视请求

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷 |

**返回值**: 小米电视响应结果

---

### requestMiioList()
**功能**: 获取 MIIO 设备列表

**参数**: 无

**返回值**: JSON 格式的设备列表及 token 信息

**实现**: 调用 `matool --method api_call --params /device/miot_get_device_tokens`

---

### requestCamera()
**功能**: 小米摄像头请求

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| payload | string | 是 | 请求载荷 |

**返回值**: 摄像头响应结果

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `luci.http` | HTTP 请求处理 |
| `luci.util` | 工具函数（命令执行）|
| `xiaoqiang.common.XQConfigs` | 配置常量（Thrift 隧道命令模板）|
| `xiaoqiang.common.XQFunction` | 通用工具函数（Mesh 模式检测、异步执行）|
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（Base64 编码）|
| `xiaoqiang.util.XQMitvUtil` | 小米电视工具 |
| `xiaoqiang.util.XQCameraUtil` | 摄像头工具 |
| `xiaoqiang.XQLog` | 日志模块 |
| `json` | JSON 编解码 |

## 被引用情况

该模块作为 API 控制器，主要被以下方式调用：
- LuCI 框架路由系统通过 HTTP 请求调用
- 小米路由器 APP 通过 API 接口调用
- 智能家居设备控制场景

## 关键代码说明

### Mesh 网络 MQTT 同步
```lua
if XQFunction.isMeshMode() then
    local actionList = commandData.action_list
    if actionList then
        local actionType = actionList[1].type
        if actionType == "normal_reboot" or actionType == "normal_wifi_down" then
            mqttCommand = "ubus call xq_info_sync_mqtt send_smart '{\"msg\":\"" 
                .. encodedCommand 
                .. "\"}';sleep 2;ubus call xq_info_sync_mqtt smart_changed"
            XQFunction.forkExec(mqttCommand)
        end
    end
end
```
在 Mesh 组网模式下，重启和关闭 WiFi 等操作需要通过 MQTT 同步到其他节点，确保整个 Mesh 网络的一致性。

### Thrift 隧道通信
```lua
local command = XQConfigs.THRIFT_TUNNEL_TO_SMARTHOME % encodedPayload
http.write(LuciUtil.exec(command))
```
使用配置中的命令模板，将 Base64 编码的 payload 通过 Thrift 隧道发送到智能家居服务。
