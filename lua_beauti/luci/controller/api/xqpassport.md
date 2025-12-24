# xqpassport.lua - 小米路由器 Passport API 控制器模块

## 概述

小米路由器 Passport（账号认证）API 控制器模块，提供小米账号登录、绑定、解绑、插件管理等功能。用于实现路由器与小米账号的关联，以及云端插件服务的管理。

**文件路径**: `luci/controller/api/xqpassport.lua`  
**模块名称**: `luci.controller.api.xqpassport`  
**API 路径**: `/api/xqpassport/*`

## 工作原理

1. **账号认证**: 通过小米 Passport 服务进行用户认证
2. **设备绑定**: 将路由器与小米账号绑定，实现远程管理
3. **Cookie 管理**: 使用 `psp` Cookie 存储登录状态
4. **插件管理**: 管理云端插件的启用/禁用

## 接口/函数列表

### API 端点

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqpassport/login` | `passportLogin()` | 1 | 小米账号登录 |
| `/api/xqpassport/userInfo` | `getUserInfo()` | 默认 | 获取用户信息 |
| `/api/xqpassport/rigister` | `routerRegister()` | 1 | 路由器注册 |
| `/api/xqpassport/binded` | `getBindInfo()` | 1 | 获取绑定信息 |
| `/api/xqpassport/plugin_list` | `pluginList()` | 默认 | 获取插件列表 |
| `/api/xqpassport/plugin_enable` | `pluginEnable()` | 默认 | 启用插件 |
| `/api/xqpassport/plugin_disable` | `pluginDisable()` | 默认 | 禁用插件 |
| `/api/xqpassport/plugin_detail` | `pluginDetail()` | 默认 | 获取插件详情 |
| `/api/xqpassport/unbound` | `unboundRouter()` | 默认 | 解绑路由器 |

### 详细接口说明

#### passportLogin - 小米账号登录

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 是 | 用户 UUID |
| password | string | 是 | 密码 |
| encrypt | string | 否 | 加密方式 |

**返回值**:
```json
{
    "code": 0,
    "token": "xxx",
    "uuid": "xxx"
}
```

**Cookie 设置**:
登录成功后设置 `psp` Cookie：
```
psp=<uuid>|||<level>|||<token>;path=/;
```

#### getBindInfo - 获取绑定信息

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 否 | 用户 UUID |
| force | number | 否 | 强制刷新（1=是） |

**返回值**:
```json
{
    "code": 0,
    "bind": 1,
    "routerName": "小米路由器",
    "info": {
        "userId": "xxx",
        "aliasNick": "昵称",
        "miliaoNick": "米聊昵称",
        "miliaoIcon": "头像URL",
        "miliaoIconOrig": "原始头像URL"
    }
}
```

#### routerRegister - 路由器注册

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 是 | 用户 UUID |

**返回值**:
```json
{
    "code": 0,
    "deviceID": "xxx"
}
```

#### unboundRouter - 解绑路由器

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 否 | 用户 UUID |
| password | string | 是 | 密码（验证身份） |

**返回值**:
```json
{
    "code": 0
}
```

#### pluginList - 获取插件列表

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 否 | 用户 UUID |

**返回值**:
```json
{
    "code": 0,
    "list": {
        "plugins": [
            {
                "id": "xxx",
                "name": "插件名称",
                "enabled": true
            }
        ]
    }
}
```

#### pluginEnable/pluginDisable - 启用/禁用插件

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| uuid | string | 否 | 用户 UUID |
| pluginId | string | 是 | 插件 ID |

**返回值**:
```json
{
    "code": 0
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `xiaoqiang.util.XQNetUtil` | 网络工具（小米 API 调用） |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQDBUtil` | 数据库工具 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/xqpassport/*` 路径下自动加载
- 小米路由器 APP 的账号绑定功能
- Web 管理界面的账号管理模块

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 1538 | 登录失败 |
| 1539 | 获取用户信息失败 |
| 1541 | 注册失败 |
| 1542 | 未绑定账号 |
| 1543 | 获取管理员列表失败 |
| 1544 | 获取插件列表失败 |
| 1545 | 启用插件失败 |
| 1546 | 禁用插件失败 |
| 1547 | 获取插件详情失败 |
| 1548 | 账号不匹配 |
| 1549 | 认证失败 |
| 1550 | 解绑失败 |
| 1551 | 无权限 |
| 1556 | 密码错误 |
| 1557 | 登录验证失败 |
| 1564 | 用户不存在 |
| 1565 | 密码错误 |
| 1566 | 登录异常 |
| 1580 | 设备未绑定 |
| 1581 | 认证过期 |

## 关键代码说明

### 登录流程

```lua
function passportLogin()
    local loginResult = XQNetUtil.xiaomiLogin(uuid, password)
    
    if loginResult and loginResult.code == 0 then
        local bindUserId = XQSysUtil.getPassportBindInfo()
        
        if bindUserId then
            -- 已绑定，验证是否为同一账号
            if loginResult.uuid == bindUserId then
                -- 验证管理员权限
                local adminList = XQNetUtil.getAdminList()
                if adminList and adminList.code == 0 then
                    -- 设置登录 Cookie
                    http.header("Set-Cookie", "psp=" .. loginResult.uuid .. 
                        "|||1|||" .. loginResult.token .. ";path=/;")
                end
            else
                errorCode = 1548  -- 账号不匹配
            end
        else
            -- 未绑定，保存 UUID
            XQDBUtil.setBindUUID(loginResult.uuid)
        end
    end
end
```

### 解绑流程

```lua
function unboundRouter()
    -- 验证密码
    local loginResult = XQNetUtil.xiaomiLogin(uuid, password)
    
    if loginResult and loginResult.code == 0 then
        -- 调用云端解绑接口
        local dismissResult = XQNetUtil.dismissAccount(nil, uuid)
        
        if dismissResult then
            local dismissCode = tonumber(dismissResult.code)
            -- 0=成功, 3001=设备未绑定, 3002=账号不匹配
            if dismissCode == 0 or dismissCode == 3001 or dismissCode == 3002 then
                XQSysUtil.setPassportBound(false, uuid)
            end
        end
    end
    
    -- 清除登录 Cookie
    http.header("Set-Cookie", "psp=admin|||2|||0;path=/;")
end
```

### NTP 时间同步

登录失败时会尝试同步 NTP 时间，以解决因时间不同步导致的认证问题：

```lua
if errorCode ~= 0 then
    XQFunction.forkExec("/usr/sbin/ntpsetclock 99999 log >/dev/null 2>&1")
end
```

## Cookie 格式说明

`psp` Cookie 格式：`<uuid>|||<level>|||<token>`

| 字段 | 说明 |
|------|------|
| uuid | 用户 UUID 或 "admin" |
| level | 权限级别（1=已登录，2=未登录） |
| token | 认证 Token 或 "0" |

## 注意事项

1. 登录和注册接口权限级别为 1，允许未认证访问
2. 解绑需要验证密码以确保安全
3. 登录失败会触发 NTP 时间同步
4. 插件管理功能依赖云端服务
