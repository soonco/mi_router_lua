# XQZigbeeUtil.lua - Zigbee工具模块

## 概述

`XQZigbeeUtil.lua` 是小米路由器的Zigbee智能设备管理模块，提供与Zigbee智能设备（如Yeelink智能灯泡）的通信和管理功能。通过MIIO协议与Zigbee网关通信，获取设备列表并将设备信息整合到路由器的设备管理系统中。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    XQZigbeeUtil 模块                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   Zigbee 设备管理                         │    │
│  ├─────────────────────┬───────────────────────────────────┤    │
│  │   get_zigbee_count  │     append_yeelink_list           │    │
│  │   获取设备数量       │     添加设备到列表                  │    │
│  └──────────┬──────────┴──────────────┬────────────────────┘    │
│             │                         │                         │
│             ▼                         ▼                         │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                  request_yeelink                         │    │
│  │              发送MIIO请求到Zigbee网关                     │    │
│  └─────────────────────────┬───────────────────────────────┘    │
│                            │                                     │
│                            ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              Thrift Tunnel to MIIO                       │    │
│  │           Base64编码命令 → MIIO网关 → JSON响应            │    │
│  └─────────────────────────────────────────────────────────┘    │
│                            │                                     │
│                            ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   Zigbee 设备                            │    │
│  │           智能灯泡 | 传感器 | 开关 | 其他设备              │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘

通信流程:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Lua请求   │───▶│ Base64   │───▶│ Thrift   │───▶│ MIIO     │
│ JSON命令  │    │ 编码     │    │ Tunnel   │    │ 网关     │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
                                                      │
                                                      ▼
                                               ┌──────────┐
                                               │ Zigbee   │
                                               │ 设备列表  │
                                               └──────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `request_yeelink(command)` | `command: string` | `table` | 向Yeelink/MIIO发送请求 |
| `get_zigbee_count()` | 无 | `number` | 获取Zigbee设备数量 |
| `append_yeelink_list(device_list)` | `device_list: table` | 无 | 将Yeelink设备添加到设备列表 |

### 返回值详细说明

#### request_yeelink 命令格式
```lua
-- 获取设备列表
'{"command":"device_list"}'
```

#### append_yeelink_list 添加的设备结构
```lua
{
    mac = "AA:BB:CC:DD:EE:FF",  -- 设备MAC地址
    type = "zigbee",            -- 设备类型
    ctype = 4,                  -- 连接类型
    ptype = 3,                  -- 协议类型
    online = 0,                 -- 在线状态
    origin_name = "light",      -- 原始设备类型名
    origin_info = {...},        -- 原始设备信息
    name = "智能灯泡",           -- 显示名称
    company = {
        icon = "device_list_intelligent_lamp.png",
        name = "Yeelink"
    }
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.json` | JSON编解码 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.common.XQConfigs` | 配置常量（Thrift隧道命令） |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具（获取数据库设备信息） |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（Base64编码） |
| `xiaoqiang.util.XQDBUtil` | 数据库工具（保存设备信息） |

### XQConfigs 中使用的常量
- `THRIFT_TUNNEL_TO_MIIO` - Thrift隧道命令模板，包含 `%s` 占位符用于Base64编码的命令

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang/util/XQDeviceUtil.lua` - 设备工具模块（获取完整设备列表时调用）
- 智能家居相关的Web界面

## 关键代码说明

### MIIO请求发送
```lua
function request_yeelink(command)
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    -- 将JSON命令进行Base64编码
    local encoded_cmd = XQCryptoUtil.binaryBase64Enc(command)
    
    -- 构建Thrift隧道命令
    local cmd = XQConfigs.THRIFT_TUNNEL_TO_MIIO % encoded_cmd
    
    -- 执行命令并获取响应
    local luci_util = require("luci.util")
    local response = luci_util.exec(cmd)
    
    -- 解析JSON响应
    return json.decode(response)
end
```

### 设备数量获取
```lua
function get_zigbee_count()
    -- 发送设备列表请求
    local response = request_yeelink('{"command":"device_list"}')
    
    -- 返回设备数量
    if response ~= nil and response.list ~= nil then
        return #response.list
    end
    
    return 0
end
```

### 设备列表整合
```lua
function append_yeelink_list(device_list)
    local response = request_yeelink('{"command":"device_list"}')
    
    if response == nil or response.list == nil or device_list == nil then
        return
    end
    
    for _, device in ipairs(response.list) do
        local device_info = {}
        
        device_info.mac = device.mac
        device_info.type = "zigbee"
        device_info.ctype = 4
        device_info.ptype = 3
        device_info.online = 0
        device_info.origin_name = device.type
        device_info.origin_info = device
        
        -- 根据设备类型设置名称和图标
        if device.type == "light" then
            device_info.name = "智能灯泡"
            device_info.company = {
                icon = "device_list_intelligent_lamp.png",
                name = "Yeelink"
            }
        end
        
        -- 从数据库获取用户自定义名称
        local db_devices = XQDeviceUtil.getDeviceInfoFromDB()
        local db_device = db_devices[device_info.mac]
        
        if db_device ~= nil then
            if not XQFunction.isStrNil(db_device.nickname) then
                device_info.name = db_device.nickname
            end
        end
        
        -- 如果设备不在数据库中，保存设备信息
        if not db_device then
            local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
            XQDBUtil.saveDeviceInfo(device_info.mac, device_info.origin_name, "", "", "")
        end
        
        table.insert(device_list, device_info)
    end
end
```

## 使用示例

```lua
local XQZigbeeUtil = require("xiaoqiang.util.XQZigbeeUtil")

-- 获取Zigbee设备数量
local count = XQZigbeeUtil.get_zigbee_count()
print("Zigbee设备数量: " .. count)

-- 获取完整设备列表（包含Zigbee设备）
local device_list = {}
-- ... 先添加其他类型设备 ...

-- 添加Zigbee设备到列表
XQZigbeeUtil.append_yeelink_list(device_list)

-- 遍历设备列表
for _, device in ipairs(device_list) do
    if device.type == "zigbee" then
        print(string.format("Zigbee设备: %s (%s)", device.name, device.mac))
    end
end
```

## 支持的设备类型

| 设备类型 | origin_name | 显示名称 | 图标 |
|----------|-------------|----------|------|
| 智能灯泡 | light | 智能灯泡 | device_list_intelligent_lamp.png |

## 注意事项

1. 该模块依赖MIIO网关服务，需要路由器支持Zigbee功能
2. 设备信息会自动保存到数据库，支持用户自定义设备名称
3. 设备的在线状态默认为0，实际状态需要通过其他方式获取
