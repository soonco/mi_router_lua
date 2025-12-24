# XQEquipment.lua - 设备识别模块

## 概述

`XQEquipment.lua` 是小米路由器的设备识别模块，负责根据MAC地址OUI（组织唯一标识符）和DHCP名称识别连接设备的厂商和类型。该模块支持小米生态链设备的特殊识别，并提供设备图标和分类信息。

**文件位置**: `xiaoqiang/XQEquipment.lua`  
**模块名**: `xiaoqiang.XQEquipment`  
**代码行数**: ~287行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    设备识别流程                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  输入: MAC地址 + DHCP名称                                    │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────┐               │
│  │           OUI规则匹配                    │               │
│  │  MAC前6位 → OUI_RULES自定义规则          │               │
│  │  MAC前6位 → IEEE OUI数据库查询           │               │
│  └─────────────────────────────────────────┘               │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────┐               │
│  │          DHCP名称规则匹配                │               │
│  │  dhcpname → DHCP_RULES正则匹配           │               │
│  │  识别小米电视、盒子、路由器等            │               │
│  └─────────────────────────────────────────┘               │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────┐               │
│  │           优先级比较                     │               │
│  │  priority=1 优先于 priority=2            │               │
│  │  DHCP规则通常优先级更高                  │               │
│  └─────────────────────────────────────────┘               │
│         │                                                   │
│         ▼                                                   │
│  输出: {name, icon, type{c,p,n}, priority}                  │
└─────────────────────────────────────────────────────────────┘
```

### 设备类型分类

| 类别(c) | 产品(p) | 设备类型 |
|---------|---------|----------|
| 1 | 1 | 智能红外 |
| 1 | 2 | 智能插座 |
| 2 | 6 | 摄像机 |
| 3 | 4 | 小米电视 |
| 3 | 5 | 小米盒子 |
| 3 | 7 | 智能红外 |
| 3 | 8 | 小米路由器 |
| 3 | 9 | 小米路由器mini |
| 3 | 10 | 小米路由器mini2 |
| 3 | 11 | 小米随身WiFi/空气净化器 |
| 3 | 12 | 小米Wi-Fi放大器 |
| 4 | 1 | 迅雷矿机 |

## 接口列表

### 设备识别函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `identifyDevice(mac, dhcpname)` | mac: string, dhcpname: string | table | 识别设备（简化版，返回空结果） |
| `identifyDeviceOld(mac, dhcpname)` | mac: string, dhcpname: string | table | 识别设备（完整版，执行实际识别） |

### 返回值结构

```lua
{
    name = "厂商名称",           -- 设备厂商名称
    icon = "device_icon.png",   -- 设备图标文件名
    type = {
        c = 3,                  -- 类别代码
        p = 4,                  -- 产品代码
        n = "小米电视"          -- 产品名称
    },
    priority = 1                -- 优先级（1最高）
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量（OUI文件路径） |
| `luci.util` | 工具函数（exec, split） |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.util.XQDeviceUtil` - 设备工具获取设备信息
- `xiaoqiang.XQPushHelper` - 推送助手识别设备类型
- `luci.controller.api.xqnetwork` - 网络API获取设备列表

## 关键代码说明

### 1. OUI规则定义

```lua
local OUI_RULES = {
    ["B4430D"] = {  -- Broadlink设备的OUI
        {
            from = "300000",    -- MAC后6位起始范围
            to = "3FFFFF",      -- MAC后6位结束范围
            company = "Broadlink Pty Ltd",
            icon = "device_list_intelligent.png",
            type = { c = 1, p = 1, n = "智能红外" },
            priority = 2
        },
        {
            from = "100000",
            to = "1FFFFF",
            company = "Broadlink Pty Ltd",
            icon = "device_list_intelligent_plugin.png",
            type = { c = 1, p = 2, n = "智能插座" },
            priority = 2
        }
    }
}
```

### 2. DHCP名称规则定义

```lua
local DHCP_RULES = {
    {
        rule = "^mitv",         -- 正则匹配模式
        company = "Xiaomi",
        icon = "device_mitv.png",
        type = { c = 3, p = 4, n = "小米电视" },
        priority = 1            -- 高优先级
    },
    {
        rule = "^mibox",
        company = "Xiaomi",
        icon = "device_mibox.png",
        type = { c = 3, p = 5, n = "小米盒子" },
        priority = 1
    },
    -- 更多规则...
}
```

### 3. OUI数据库查询

```lua
-- 解压OUI数据库（首次使用时）
if not oui_extracted then
    os.execute("tar -xzf " .. XQConfigs.OUI_ZIP_FILEPATH .. " -C /tmp")
    oui_extracted = true
end

-- 查询OUI数据库
local mac_formatted = mac:gsub(":", "-")
local oui_prefix = string.sub(mac_formatted, 1, 8)
local cmd = "sed -n '/" .. oui_prefix .. "/p' " .. XQConfigs.OUI_FILEPATH
local oui_line = luci_util.exec(cmd)
```

### 4. 优先级比较逻辑

```lua
-- 返回优先级更高（数值更小）的结果
if oui_result and dhcp_result then
    if oui_result.priority < dhcp_result.priority then
        return oui_result
    else
        return dhcp_result
    end
elseif oui_result then
    return oui_result
elseif dhcp_result then
    return dhcp_result
else
    return { name = "", icon = "", type = { c = 0, p = 0, n = "" }, priority = 2 }
end
```

## 支持的设备识别规则

### DHCP名称规则

| 匹配模式 | 设备类型 | 厂商 |
|----------|----------|------|
| `^mitv` | 小米电视 | Xiaomi |
| `^mibox` | 小米盒子 | Xiaomi |
| `^miwifi-r1d` | 小米路由器 | Xiaomi |
| `^miwifi-r1cm` | 小米路由器mini | Xiaomi |
| `^miwifi-r1cq` | 小米路由器mini2 | Xiaomi |
| `^miwifi-tiny` | 小米随身WiFi | Xiaomi |
| `^xiaomirepeater` | 小米Wi-Fi放大器 | Xiaomi |
| `^broadlink_sp2` | 智能插座 | Broadlink |
| `^broadlink_rm2` | 智能红外 | Broadlink |
| `^antscam` | 小蚁智能摄像机 | 云蚁 |
| `^xiaomi.ir` | 智能红外 | Xiaomi |
| `chuangmi-plug` | 智能插座 | Chuangmi |
| `^zhimi-airpurifier` | 空气净化器 | zhimi |
| `^xl_miner` | 迅雷矿机 | xunlei |

## 注意事项

1. **简化版函数**: `identifyDevice()` 当前返回空结果，实际识别使用 `identifyDeviceOld()`
2. **OUI数据库**: 首次使用时会解压OUI数据库到 `/tmp` 目录
3. **优先级机制**: DHCP规则优先级(1)高于OUI规则优先级(2)
4. **MAC地址格式**: 内部处理时会转换为大写无分隔符格式
