# XQParentControl.lua - 家长控制模块

## 概述

`XQParentControl` 是小米路由器的家长控制功能模块，提供设备上网时间控制、URL黑白名单过滤、网络访问权限管理等功能。该模块支持按时间段和星期控制设备的上网行为，是实现儿童上网管理的核心组件。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    家长控制系统架构                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    控制模式                           │      │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐          │      │
│  │  │  none    │  │ limited  │  │  time    │          │      │
│  │  │ (无限制)  │  │ (禁止上网)│  │ (定时控制)│          │      │
│  │  └──────────┘  └──────────┘  └──────────┘          │      │
│  └──────────────────────────────────────────────────────┘      │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                 XQParentControl                       │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐     │      │
│  │  │ 时间规则    │  │ URL过滤    │  │ 设备模式    │     │      │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘     │      │
│  └────────┼───────────────┼───────────────┼─────────────┘      │
│           │               │               │                     │
│           ▼               ▼               ▼                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              UCI配置 (parentalctl)                   │       │
│  │  ├── global (全局设置)                               │       │
│  │  ├── summary (设备模式摘要)                          │       │
│  │  ├── device (时间控制规则)                           │       │
│  │  └── rule (URL过滤规则)                              │       │
│  └─────────────────────────────────────────────────────┘       │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │              parentalctl.sh (执行脚本)               │       │
│  └─────────────────────────────────────────────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 控制模式说明

```
控制模式 (mode)
├── none     -- 无限制，允许正常上网
├── limited  -- 禁止上网，完全阻断网络访问
└── time     -- 按时间段控制，在指定时间允许上网
```

### 星期映射

```
星期映射 (WEEKDAY)
├── Mon = 1 (周一)
├── Tue = 2 (周二)
├── Wed = 3 (周三)
├── Thu = 4 (周四)
├── Fri = 5 (周五)
├── Sat = 6 (周六)
└── Sun = 7 (周日)

特殊值: 0 = 仅当天生效
```

### URL过滤模式

```
URL过滤模式
├── none   -- 无过滤
├── white  -- 白名单模式（只允许访问列表中的URL）
└── black  -- 黑名单模式（禁止访问列表中的URL）
```

## 接口列表

### 常量

| 常量名 | 值 | 说明 |
|--------|-----|------|
| `MAX_DEVICE_RULES` | 5 | 每个设备最大规则数 |

### 全局控制函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_global_info()` | 无 | table | 获取全局配置信息 |
| `apply(async)` | async: boolean | 无 | 应用配置更改 |

### 设备模式函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_device_mode_info(mac)` | mac: string | table | 获取设备控制模式 |
| `set_device_mode_info(mac, enable, mode)` | mac, mode: string, enable: number | table | 设置设备控制模式 |
| `check_mode(mode)` | mode: string | boolean | 检查模式是否有效 |

### 时间规则函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_device_info(mac)` | mac: string | table | 获取设备时间规则 |
| `add_device_info(mac, enable, weekdays, timeSeg)` | 见下表 | string/false | 添加时间规则 |
| `update_device_info(ruleId, mac, enable, weekdays, timeSeg)` | 见下表 | boolean | 更新时间规则 |
| `delete_device_info(ruleId)` | ruleId: string | boolean | 删除时间规则 |
| `parentctl_rules(macList)` | macList: table | table | 获取规则统计 |

### URL过滤函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_parentctl_url_filter(mac)` | mac: string | table | 获取URL过滤配置 |
| `set_parentctl_url_filter(mac, filterMode, name)` | mac, filterMode, name: string | 无 | 设置URL过滤模式 |
| `get_parentctl_url_list(mac, filterMode)` | mac, filterMode: string | table | 获取URL列表 |
| `edit_parentctl_url_list(mac, action, filterMode, url, newUrl)` | 见下表 | boolean | 编辑URL列表 |
| `disable_all_parentctl_url_filter()` | 无 | 无 | 禁用所有URL过滤 |

### 批量查询函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `netacctl_status(macList)` | macList: table | table | 批量获取设备状态 |
| `get_urlfilter_info(macList)` | macList: table | table | 批量获取URL过滤信息 |

### 参数说明

**add_device_info 参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| mac | string | 设备MAC地址 |
| enable | number | 是否启用 (1=启用) |
| weekdays | table | 星期列表 [1-7] 或 [0]=仅当天 |
| timeSeg | string | 时间段 "HH:MM-HH:MM" |

**edit_parentctl_url_list action:**
| 值 | 说明 |
|----|------|
| 0 | 添加URL |
| 1 | 删除URL |
| 2 | 修改URL |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.module.XQFirewall` | 防火墙MAC过滤 |
| `xiaoqiang.util.XQSynchrodata` | 数据同步 |
| `xiaoqiang.util.XQController` | 设备权限控制 |
| `luci.model.uci` | UCI配置操作 |
| `luci.cbi.datatypes` | 数据类型验证 |
| `nixio.fs` | 文件系统操作 |
| `bit` | 位运算库 |

### UCI配置

| 配置文件 | section | 用途 |
|----------|---------|------|
| `parentalctl` | `global` | 全局开关 |
| `parentalctl` | `summary` | 设备模式摘要 |
| `parentalctl` | `device` | 时间控制规则 |
| `parentalctl` | `rule` | URL过滤规则 |

### 文件依赖

| 路径 | 用途 |
|------|------|
| `/etc/parentalctl/` | URL过滤规则文件目录 |
| `/usr/sbin/parentalctl.sh` | 配置应用脚本 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 家长控制接口 |
| 小米WiFi App | 家长控制功能 |
| 设备管理页面 | 上网控制设置 |

## 关键代码说明

### 规则Key生成

```lua
function _generate_key(mac)
    local macKey = mac:gsub(":", "")
    local maxSlots = math.pow(2, MAX_DEVICE_RULES) - 1  -- 31 (二进制 11111)
    
    -- 查找已使用的槽位
    uci:foreach("parentalctl", "device", function(section)
        if sectionName:match("^" .. macKey .. "_") then
            local slotNum = tonumber(slotStr)
            -- 使用异或清除已使用的位
            maxSlots = bit.bxor(maxSlots, math.pow(2, slotNum - 1))
        end
    end)
    
    -- 找到第一个可用槽位
    for i = 1, MAX_DEVICE_RULES do
        if bit.band(maxSlots, math.pow(2, i - 1)) > 0 then
            return macKey .. "_" .. tostring(i)
        end
    end
    return nil  -- 已达上限
end
```

### 时间段解析

```lua
function _parse_frequency(weekdays, timeSeg)
    local weekdayList = {}
    
    for _, day in ipairs(weekdays) do
        if tonumber(day) == 0 then
            -- 0表示仅当天生效，使用日期范围
            weekdayList = nil
            break
        end
        local dayName = NUM_TO_WEEKDAY[tonumber(day)]
        table.insert(weekdayList, dayName)
    end
    
    if weekdayList then
        return weekdayList, nil, nil  -- 按星期重复
    else
        -- 计算当天的开始和结束时间戳
        local currentTime = os.time()
        local startDate = currentTime
        local stopDate = startDate + 86400
        return nil, startDate, stopDate
    end
end
```

### URL过滤文件格式

```lua
-- URL文件格式: url cleanUrl
-- 例如: www.example.com .example.com

function set_url_info(filePath, urlList)
    for _, url in ipairs(urlList) do
        local cleanUrl = url:gsub("http://", ""):gsub("^www.", "")
        
        if not DataTypes.ipaddr(cleanUrl) then
            if not cleanUrl:match("^%.") then
                cleanUrl = "." .. cleanUrl  -- 添加前导点
            end
        end
        
        file:write(url .. " " .. cleanUrl .. "\n")
    end
end
```

### 设备模式设置

```lua
function set_device_mode_info(mac, enable, mode)
    local wanStatus = "1"
    
    -- 如果模式为limited且启用，则禁止WAN访问
    if result.mode == "limited" and result.enable == 1 then
        wanStatus = "0"
    end
    
    -- 更新UCI配置
    uci:section("parentalctl", "summary", macKey, summaryConfig)
    uci:commit("parentalctl")
    
    -- 设置防火墙MAC过滤
    XQFirewall.setMacFilter(string.upper(mac), "", 0, wanStatus)
    
    -- 更新设备权限
    XQController.permission(mac, nil, wanStatus, nil, nil)
    
    -- 同步设备信息
    XQSynchrodata.syncDeviceInfo({mac = mac})
end
```
