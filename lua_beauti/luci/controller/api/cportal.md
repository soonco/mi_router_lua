# cportal.lua - 强制门户控制器模块

## 概述

强制门户控制器模块（Captive Portal Controller Module），提供强制门户相关的 API 接口，用于处理网络认证和访客放行功能。

**文件路径**: `luci/controller/api/cportal.lua`  
**模块名称**: `luci.controller.api.cportal`  
**API 路径**: `/api/cportal/*`

## 工作原理

1. **路由注册**: 通过 `index()` 函数注册 API 路由节点
2. **设备识别**: 自动获取请求设备的 MAC 地址
3. **放行执行**: 调用系统脚本 `/usr/sbin/captive_portal.sh` 执行放行操作
4. **响应格式**: 支持 JSONP 回调格式

## 接口/函数列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `index()` | 无 | 无 | 路由索引函数，注册所有 API 路由 |
| `captivePortalAllow()` | 无（从 HTTP 获取） | JSON/JSONP | 允许设备通过强制门户 |

### API 端点详情

#### /api/cportal/allow

允许设备通过强制门户。

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| callback | string | 否 | JSONP 回调函数名 |
| interval | number | 否 | 放行时间间隔（秒） |

**返回值**:
```json
{
    "code": 0
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理和响应输出 |
| `xiaoqiang.XQLog` | 日志记录 |
| `luci.dispatcher` | 获取远程 MAC 地址 |

### 系统依赖

- `/usr/sbin/captive_portal.sh`: 强制门户放行脚本

## 被引用情况

- 由 LuCI dispatcher 在 `/api/cportal/*` 路径下自动加载
- 通常由前端 Web 页面或 APP 调用进行访客网络认证

## 关键代码说明

### 放行逻辑

```lua
function captivePortalAllow()
    -- 获取请求设备的 MAC 地址
    local remote_mac = luci.dispatcher.getremotemac()
    
    -- 获取放行时间间隔
    local interval = http.formvalue("interval")
    if tonumber(interval) == nil then
        interval = ""
    end
    
    -- 执行放行脚本
    os.execute("/usr/sbin/captive_portal.sh allow " .. remote_mac .. " " .. interval)
end
```

该函数自动识别请求设备的 MAC 地址，无需客户端传递，增强了安全性。
