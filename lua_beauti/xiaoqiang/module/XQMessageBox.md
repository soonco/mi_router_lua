# XQMessageBox.lua - 消息盒子模块

## 概述

`XQMessageBox` 是小米路由器的消息盒子模块，负责管理路由器的系统消息和通知。该模块提供消息的增删改查、已读状态管理、消息分类、过期清理等功能，支持系统通知、安全警告、设备上下线、固件更新等多种消息类型。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    消息盒子系统架构                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    消息来源                              │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐   │   │
│  │  │ 系统通知  │ │ 安全警告  │ │ 设备事件  │ │ 固件更新  │   │   │
│  │  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘   │   │
│  └───────┼────────────┼────────────┼────────────┼─────────┘   │
│          │            │            │            │              │
│          └────────────┴─────┬──────┴────────────┘              │
│                             ▼                                   │
│                    ┌─────────────────┐                         │
│                    │  XQMessageBox   │                         │
│                    │  ┌───────────┐  │                         │
│                    │  │ addMessage│  │                         │
│                    │  └─────┬─────┘  │                         │
│                    └────────┼────────┘                         │
│                             │                                   │
│                             ▼                                   │
│                    ┌─────────────────┐                         │
│                    │ 消息处理        │                         │
│                    │ - 生成ID        │                         │
│                    │ - 添加时间戳    │                         │
│                    │ - 设置优先级    │                         │
│                    │ - 限制数量      │                         │
│                    └────────┬────────┘                         │
│                             │                                   │
│                             ▼                                   │
│                    ┌─────────────────────────┐                 │
│                    │ /tmp/message_box.json   │                 │
│                    │ (消息存储文件)           │                 │
│                    └─────────────────────────┘                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 消息类型

```
消息类型 (MSG_TYPE)
├── SYSTEM (1)    -- 系统消息
├── SECURITY (2)  -- 安全消息
├── UPDATE (3)    -- 更新消息
├── DEVICE (4)    -- 设备消息
└── PLUGIN (5)    -- 插件消息
```

### 消息优先级

```
优先级 (MSG_PRIORITY)
├── LOW (1)       -- 低优先级
├── NORMAL (2)    -- 普通优先级
└── HIGH (3)      -- 高优先级
```

### 消息数据结构

```lua
{
    id = "1703404800_1234",    -- 消息ID (时间戳_随机数)
    type = 1,                  -- 消息类型
    title = "系统通知",         -- 消息标题
    content = "消息内容...",    -- 消息内容
    priority = 2,              -- 优先级
    timestamp = 1703404800,    -- 创建时间戳
    read = 0,                  -- 已读状态 (0=未读, 1=已读)
    extra = {}                 -- 额外数据
}
```

## 接口列表

### 常量

| 常量名 | 值 | 说明 |
|--------|-----|------|
| `MSG_TYPE_SYSTEM` | 1 | 系统消息 |
| `MSG_TYPE_SECURITY` | 2 | 安全消息 |
| `MSG_TYPE_UPDATE` | 3 | 更新消息 |
| `MSG_TYPE_DEVICE` | 4 | 设备消息 |
| `MSG_TYPE_PLUGIN` | 5 | 插件消息 |
| `MSG_PRIORITY_LOW` | 1 | 低优先级 |
| `MSG_PRIORITY_NORMAL` | 2 | 普通优先级 |
| `MSG_PRIORITY_HIGH` | 3 | 高优先级 |
| `MSG_STORAGE_PATH` | "/tmp/message_box.json" | 消息存储路径 |

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getMessages(msgType, unreadOnly)` | msgType: number, unreadOnly: boolean | table | 获取消息列表 |
| `getUnreadCount(msgType)` | msgType: number | number | 获取未读消息数量 |
| `addMessage(msgType, title, content, priority, extra)` | 见下表 | string/nil | 添加新消息 |
| `markAsRead(msgId)` | msgId: string | number | 标记消息为已读 |
| `deleteMessage(msgId)` | msgId: string | number | 删除消息 |
| `deleteByType(msgType)` | msgType: number | number | 删除指定类型的所有消息 |
| `getMessageDetail(msgId)` | msgId: string | table/nil | 获取消息详情 |
| `sendSystemNotification(title, content, priority)` | title, content: string, priority: number | string | 发送系统通知 |
| `sendSecurityAlert(title, content, extra)` | title, content: string, extra: table | string | 发送安全警告 |
| `sendDeviceNotification(deviceName, action, extra)` | deviceName, action: string, extra: table | string | 发送设备通知 |
| `sendUpdateNotification(version, changelog)` | version, changelog: string | string | 发送更新通知 |
| `cleanExpiredMessages(days)` | days: number | number | 清理过期消息 |

### 参数说明

**addMessage 参数:**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| msgType | number | 是 | 消息类型 |
| title | string | 是 | 消息标题 |
| content | string | 否 | 消息内容 |
| priority | number | 否 | 优先级，默认NORMAL |
| extra | table | 否 | 额外数据 |

### 返回值说明

**markAsRead/deleteMessage 返回值:**
| 值 | 说明 |
|----|------|
| 0 | 成功 |
| 1 | 消息不存在 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（字符串检查） |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `luci.jsonc` | JSON解析和序列化 |
| `nixio.fs` | 文件系统操作 |

### 文件依赖

| 文件路径 | 用途 |
|----------|------|
| `/tmp/message_box.json` | 消息存储文件 |

## 被引用情况

| 引用模块 | 引用函数 | 用途 |
|----------|----------|------|
| API控制器 | `getMessages` | 获取消息列表接口 |
| API控制器 | `markAsRead` | 标记已读接口 |
| API控制器 | `deleteMessage` | 删除消息接口 |
| 安全模块 | `sendSecurityAlert` | 发送安全警告 |
| 设备管理模块 | `sendDeviceNotification` | 设备上下线通知 |
| OTA模块 | `sendUpdateNotification` | 固件更新通知 |

## 关键代码说明

### 消息ID生成

```lua
-- 使用时间戳+随机数生成唯一ID
local msgId = string.format("%d_%d", os.time(), math.random(1000, 9999))
```

### 消息数量限制

```lua
-- 添加到消息列表头部
table.insert(messages, 1, newMsg)

-- 限制消息数量(最多保留100条)
while #messages > 100 do
    table.remove(messages)  -- 删除最旧的消息
end
```

### 消息过滤与排序

```lua
function getMessages(msgType, unreadOnly)
    local result = {}
    
    for _, msg in ipairs(messages) do
        local include = true
        
        -- 按类型过滤
        if msgType and msg.type ~= msgType then
            include = false
        end
        
        -- 按已读状态过滤
        if unreadOnly and msg.read == 1 then
            include = false
        end
        
        if include then
            table.insert(result, msg)
        end
    end
    
    -- 按时间倒序排列（最新的在前）
    table.sort(result, function(a, b)
        return (a.timestamp or 0) > (b.timestamp or 0)
    end)
    
    return result
end
```

### 快捷发送函数

```lua
-- 发送系统通知
function sendSystemNotification(title, content, priority)
    return addMessage(MSG_TYPE_SYSTEM, title, content, priority)
end

-- 发送安全警告（自动设置高优先级）
function sendSecurityAlert(title, content, extra)
    return addMessage(MSG_TYPE_SECURITY, title, content, MSG_PRIORITY_HIGH, extra)
end

-- 发送设备通知（自动格式化标题和内容）
function sendDeviceNotification(deviceName, action, extra)
    local title = string.format("设备%s", action)
    local content = string.format("设备 %s %s", deviceName, action)
    return addMessage(MSG_TYPE_DEVICE, title, content, MSG_PRIORITY_NORMAL, extra)
end

-- 发送更新通知（附带版本和更新日志）
function sendUpdateNotification(version, changelog)
    local extra = { version = version, changelog = changelog }
    return addMessage(MSG_TYPE_UPDATE, "系统更新可用", 
                      string.format("新版本 %s 可用", version), 
                      MSG_PRIORITY_NORMAL, extra)
end
```

### 过期消息清理

```lua
function cleanExpiredMessages(days)
    days = days or 30
    local expireTime = os.time() - (days * 24 * 60 * 60)
    
    local newMessages = {}
    local cleanedCount = 0
    
    for _, msg in ipairs(messages) do
        if msg.timestamp and msg.timestamp >= expireTime then
            table.insert(newMessages, msg)
        else
            cleanedCount = cleanedCount + 1
        end
    end
    
    fs.writefile(MSG_STORAGE_PATH, json.stringify(newMessages))
    return cleanedCount
end
```

### 存储说明

消息存储在 `/tmp/message_box.json` 文件中，这意味着：
- 消息在路由器重启后会丢失（/tmp是临时文件系统）
- 适合存储临时性通知，不适合持久化重要数据
- 如需持久化存储，应考虑使用其他存储位置
