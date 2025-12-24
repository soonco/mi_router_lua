# XQEBit.lua - eBit宽带加速模块

## 概述

XQEBit 是小米路由器与 eBit 宽带加速服务进行 API 交互的模块。该模块通过与运营商合作，实现网络带宽的临时加速功能，支持用户信息查询、加速开启/关闭、状态查询等操作。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        XQEBit 宽带加速模块                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────┐                    ┌──────────────────────────────┐   │
│  │  小米路由器   │                    │    eBit API服务器            │   │
│  │              │    HTTP POST       │    218.85.118.9:8000         │   │
│  │  XQEBit      │ ─────────────────► │                              │   │
│  │  Module      │    JSON格式        │    /api2/user/query          │   │
│  │              │ ◄───────────────── │    /api2/speedup/open        │   │
│  └──────────────┘                    │    /api2/speedup/close       │   │
│         │                            │    /api2/speedup/query       │   │
│         │                            │    /api2/speedup/check       │   │
│         ▼                            │    /api2/task/query          │   │
│  ┌──────────────┐                    └──────────────────────────────┘   │
│  │  WAN口IP     │                                                       │
│  │  获取        │                                                       │
│  └──────────────┘                                                       │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### API签名机制

```
┌─────────────────────────────────────────────────────────────────┐
│                       签名生成流程                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   1. 获取当前时间戳                                              │
│      timestamp = os.time()                                       │
│                                                                  │
│   2. 拼接签名字符串                                              │
│      signStr = APP_ID + timestamp + APP_SECRET                   │
│             = "APP_MIOFGBVQ" + "1703404800" + "2ErNCyfk..."     │
│                                                                  │
│   3. 计算MD5哈希                                                 │
│      secret = MD5(signStr)                                       │
│                                                                  │
│   4. 请求参数                                                    │
│      {                                                           │
│        "app": "APP_MIOFGBVQ",                                   │
│        "timestamp": 1703404800,                                  │
│        "secret": "a1b2c3d4e5f6...",                             │
│        ...其他参数                                               │
│      }                                                           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 异步任务查询流程

```
┌─────────────┐                    ┌─────────────┐
│  XQEBit     │                    │  eBit API   │
└──────┬──────┘                    └──────┬──────┘
       │                                   │
       │  speedup/open 请求               │
       │ ─────────────────────────────────►│
       │                                   │
       │  返回 task_id                     │
       │ ◄─────────────────────────────────│
       │                                   │
       │  task/query(task_id)             │
       │ ─────────────────────────────────►│
       │                                   │
       │  返回任务执行结果                 │
       │ ◄─────────────────────────────────│
       │                                   │
```

## 接口列表

### 签名与工具函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `genSecret()` | 无 | `timestamp:number, secret:string` | 生成API请求签名 |
| `wanip()` | 无 | `ip:string` 或 `nil` | 获取WAN口IP地址 |

### 用户信息查询

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `basic_info_query(ip)` | `ip:string` 可选，指定IP | `result:table` 或 `nil` | 查询用户基本信息 |
| `task_query(timestamp, secret, taskId)` | `timestamp:number`, `secret:string`, `taskId:string` | `result:table` 或 `nil` | 查询任务状态 |

### 加速控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `speed_up_open(upBandwidth, downBandwidth, duration, dialAccount, ip)` | `upBandwidth:number` 上行带宽(Kbps), `downBandwidth:number` 下行带宽(Kbps), `duration:number` 时长(秒), `dialAccount:string` 拨号账号, `ip:string` 可选 | `result:table` 或 `nil` | 开启宽带加速 |
| `speed_up_close(channelId)` | `channelId:string` 加速通道ID | `result:table` 或 `nil` | 关闭宽带加速 |
| `speed_up_query(channelId)` | `channelId:string` 加速通道ID | `result:table` 或 `nil` | 查询加速状态 |
| `speed_up_check(dialAccount, ip)` | `dialAccount:string` 拨号账号, `ip:string` 可选 | `result:table` 或 `nil` | 检查是否支持加速 |

## API端点

| 端点 | 功能 |
|------|------|
| `/api2/user/query` | 用户信息查询 |
| `/api2/task/query` | 任务状态查询 |
| `/api2/speedup/open` | 开启加速 |
| `/api2/speedup/close` | 关闭加速 |
| `/api2/speedup/query` | 查询加速状态 |
| `/api2/speedup/check` | 检查加速支持 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `json` | JSON编解码 |
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.XQHttpUtil` | HTTP请求 |
| `xiaoqiang.util.XQCryptoUtil` | MD5计算 |
| `xiaoqiang.util.XQLanWanUtil` | WAN口状态获取 |
| `luci.http.protocol` | HTTP协议处理 |

## 被引用情况

该模块主要被以下组件引用：
- 宽带加速Web管理界面
- 小米WiFi APP加速功能
- 增值服务管理模块

## 关键代码说明

### 签名生成

```lua
function genSecret()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    -- 获取当前时间戳
    local timestamp = os.time()
    
    -- 构建待签名字符串: APP_ID + 时间戳 + APP_SECRET
    local signStr = APP_ID .. tostring(timestamp) .. APP_SECRET
    
    -- 计算MD5签名
    local secret = XQCryptoUtil.md5Str(signStr)
    
    return timestamp, secret
end
```

### WAN口IP获取

```lua
function wanip()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    -- 获取WAN口状态
    local wanStatus = XQLanWanUtil.ubusWanStatus()
    
    if wanStatus then
        local ipv4 = wanStatus.ipv4
        if ipv4 and #ipv4 > 0 then
            -- 返回第一个IPv4地址
            return ipv4[1].ip
        end
    end
    
    return nil
end
```

### 开启加速请求

```lua
function speed_up_open(upBandwidth, downBandwidth, duration, dialAccount, ip)
    local timestamp, secret = genSecret()
    
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.ip_addr = ip or wanip()
    params.dial_acct = dialAccount
    params.bandwidths = {upBandwidth, downBandwidth}  -- [上行, 下行]
    params.duration = duration
    
    local response = XQHttpUtil.httpPostRequest(
        API_SPEEDUP_OPEN,
        json.encode(params),
        nil,
        "application/json"
    )
    
    -- 异步任务处理
    if response and response.code == 200 then
        local result = json.decode(response.res)
        if result.task_id then
            return task_query(timestamp, secret, result.task_id)
        end
    end
    
    return nil
end
```

## 配置常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `APP_ID` | `APP_MIOFGBVQ` | 应用标识 |
| `APP_SECRET` | `2ErNCyfk8HZoH432T7Em0K16` | 应用密钥 |
| API服务器 | `218.85.118.9:8000` | eBit API服务地址 |
