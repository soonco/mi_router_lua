# XQParentControlV2.lua - 家长控制模块V2

## 概述

`XQParentControlV2` 是小米路由器的第二代家长控制模块，基于 `mipctl` 服务实现更强大的家长控制功能。该模块支持用户管理、设备绑定、时间限制、应用分类控制等功能，提供更精细化的上网行为管理。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    家长控制V2系统架构                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    用户管理                           │      │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐          │      │
│  │  │ 用户1    │  │ 用户2    │  │ 用户3    │          │      │
│  │  │ (孩子A)  │  │ (孩子B)  │  │ (访客)   │          │      │
│  │  └────┬─────┘  └────┬─────┘  └────┬─────┘          │      │
│  └───────┼─────────────┼─────────────┼────────────────┘      │
│          │             │             │                        │
│          ▼             ▼             ▼                        │
│  ┌─────────────────────────────────────────────────────┐      │
│  │                 设备绑定                             │      │
│  │  用户1 ← [手机A, 平板B]                             │      │
│  │  用户2 ← [电脑C, 手机D]                             │      │
│  └─────────────────────────────────────────────────────┘      │
│          │                                                     │
│          ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐      │
│  │                 控制策略                             │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐   │      │
│  │  │ 时间禁用    │  │ 应用控制    │  │ 临时禁用    │   │      │
│  │  │ (time_ban) │  │ (app_class)│  │ (temp_ban) │   │      │
│  │  └────────────┘  └────────────┘  └────────────┘   │      │
│  └─────────────────────────────────────────────────────┘      │
│          │                                                     │
│          ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐      │
│  │              mipctl 服务 (ubus)                      │      │
│  │  - is_allow_access: 检查访问权限                     │      │
│  │  - reload: 重新加载配置                              │      │
│  └─────────────────────────────────────────────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 配置文件结构

```
UCI配置 (/etc/mipctl/)
├── mipctl_user (用户配置)
│   ├── meta (元数据: user_max, dev_per_user, ban_per_user)
│   ├── user (用户信息: user_id, user_name, icon_id, device)
│   ├── user_time_ban (时间禁用规则)
│   └── user_class_config (应用分类配置)
│
└── mipctl_app (应用配置)
    ├── meta (元数据: appinfo_version)
    └── app_class (应用分类定义)
```

### 用户状态

```
用户状态 (status)
├── -1  -- 被禁用（临时禁用或时间禁用）
├──  0  -- 离线
└──  1  -- 在线
```

## 接口列表

### 用户管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getPctlUserList()` | 无 | table | 获取用户列表 |
| `addUser(params)` | params: table | number, table | 添加用户 |
| `delUser(params)` | params: table | number | 删除用户 |
| `editUser(params)` | params: table | number | 编辑用户 |
| `findUser(userId)` | userId: number | string, table | 查找用户 |

### 设备绑定函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getDev()` | 无 | table | 获取设备绑定列表 |
| `setDev(params)` | params: table | number | 设置设备绑定 |
| `checkDevListFormat(devices)` | devices: table | table/nil | 检查设备列表格式 |

### 时间控制函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getTimeList(userId)` | userId: number | table | 获取时间禁用列表 |
| `setTimeList(params)` | params: table | number | 设置时间禁用列表 |
| `cal_nxt_permit_time(userId)` | userId: number | string | 计算下次允许时间 |

### 应用控制函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getApp(userId)` | userId: number | table, string | 获取应用控制配置 |
| `setApp(params)` | params: table | number | 设置应用控制配置 |
| `appCfgTplt(version)` | version: string | table | 获取应用配置模板 |

### 临时禁用函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setTempBan(params)` | params: table | number | 设置临时禁用 |
| `isTempBan(user)` | user: table | boolean | 检查是否临时禁用 |

### 统计函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getUserStat(userId)` | userId: number | table | 获取用户统计 |
| `getAppClassStat(userId)` | userId: number | table | 获取应用分类统计 |

### 辅助函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `commit()` | 无 | 无 | 提交配置并重载服务 |
| `allowAccess(userId)` | userId: number | boolean | 检查是否允许访问 |
| `isOnline(devices)` | devices: table | boolean | 检查设备是否在线 |

### 错误码说明

| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| -1662 | 用户数量已达上限 |
| -1663 | 用户名包含非法字符 |
| -1664 | 用户不存在 |
| -1665 | 设备数量超过限制 |
| -1666 | 时间规则数量超过限制 |
| -1668 | 用户名过长 |
| -1672 | 参数格式错误 |
| -1673 | 配置操作失败 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `cjson` | JSON处理 |
| `luci.model.uci` | UCI配置操作 |
| `ubus` | 与mipctl服务通信 |

### UCI配置

| 配置文件 | 路径 | 用途 |
|----------|------|------|
| `mipctl_user` | `/etc/mipctl/` | 用户和规则配置 |
| `mipctl_app` | `/etc/mipctl/` | 应用分类配置 |
| `pctl_user_stat` | `/etc/xqDb/` | 用户统计数据 |
| `pctl_appclass_stat` | `/etc/xqDb/` | 应用分类统计 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 家长控制V2接口 |
| 小米WiFi App | 高级家长控制功能 |

## 关键代码说明

### 用户列表获取

```lua
function getPctlUserList()
    local result = {}
    
    mipctlUci:foreach(MIPCTL_USER_CONFIG, "user", function(section)
        local user = {}
        user.user_id = tonumber(section.user_id)
        user.user_name = section.user_name
        user.icon = section.icon_id
        
        -- 判断用户状态
        if isTempBan(section) then
            user.status = -1  -- 临时禁用
        elseif not allowAccess(user.user_id) then
            user.status = -1  -- 时间禁用
        elseif isOnline(section.device) then
            user.status = 1   -- 在线
        else
            user.status = 0   -- 离线
        end
        
        table.insert(result, user)
    end)
    
    return result
end
```

### 时间禁用规则格式

```lua
-- 时间禁用规则结构
{
    id = "1_480_1200_127",  -- user_id_start_end_enable
    start = 480,            -- 开始时间(分钟，从0点开始)
    ["end"] = 1200,         -- 结束时间(分钟)
    enable = {1,1,1,1,1,1,1}  -- 星期启用状态 [周一到周日]
}

-- enable字符串格式: "1111111" (7位，每位代表一天)
```

### 应用控制配置

```lua
-- 应用分类配置结构
{
    class_name = "game",     -- 分类名称
    enable = true,           -- 是否启用控制
    time_quota = 120,        -- 时间配额(分钟)
    app_list = {             -- 应用列表
        { name = "王者荣耀", enable = true },
        { name = "和平精英", enable = false }
    }
}
```

### 访问权限检查

```lua
function allowAccess(userId)
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        -- 调用mipctl服务检查权限
        local result = conn:call("mipctl", "is_allow_access", { user_id = userId })
        conn:close()
        
        if result then
            return result.result
        end
    end
    
    return true  -- 默认允许
end
```

### 配置提交

```lua
function commit()
    -- 保存UCI配置
    mipctlUci:commit(MIPCTL_USER_CONFIG)
    
    -- 通知mipctl服务重新加载
    local ubus = require("ubus")
    local conn = ubus.connect()
    
    if conn then
        conn:call("mipctl", "reload", {})
        conn:close()
    end
end
```

### 用户名验证

```lua
function checkUserName(userName)
    if type(userName) ~= "string" then
        return -1672
    end
    
    -- 检查字符串宽度（中文字符算2个宽度）
    if calStrWidth(userName) > 12 then
        return -1668
    end
    
    -- 检查是否包含换行符
    local matched = string.match(userName, "[^\n]+")
    if matched ~= userName then
        return -1663
    end
    
    return 0
end
```
