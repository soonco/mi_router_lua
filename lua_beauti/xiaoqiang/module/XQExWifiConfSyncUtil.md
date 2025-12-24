# XQExWifiConfSyncUtil.lua - WiFi配置同步工具模块

## 概述

XQExWifiConfSyncUtil 是小米路由器WiFi配置同步的工具模块，用于扩展WiFi设备(中继器等)与主路由器之间的配置同步。该模块提供登录认证、配置文件获取、配置文件推送等功能，通过HTTP协议和自定义认证机制实现安全的配置传输。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                   XQExWifiConfSyncUtil 配置同步工具                      │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────┐                    ┌──────────────┐                   │
│  │  本地路由器   │                    │  对端路由器   │                   │
│  │              │    HTTP请求        │              │                   │
│  │  (主路由)    │ ─────────────────► │  (扩展器)    │                   │
│  │              │                    │              │                   │
│  └──────────────┘                    └──────────────┘                   │
│         │                                   │                            │
│         │                                   │                            │
│         ▼                                   ▼                            │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        同步流程                                   │   │
│  │                                                                   │   │
│  │   1. account_login     ──►  获取token                            │   │
│  │                             (nonce + 密码哈希认证)                │   │
│  │                                                                   │   │
│  │   2. config_get        ──►  拉取配置                              │   │
│  │      config_post       ──►  推送配置                              │   │
│  │                             (MD5校验)                             │   │
│  │                                                                   │   │
│  │   3. config_finish     ──►  完成同步                              │   │
│  │                             (重启/关闭WiFi)                       │   │
│  │                                                                   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### 认证流程

```
┌─────────────────────────────────────────────────────────────────┐
│                       登录认证流程                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   1. 生成 nonce                                                 │
│      nonce = deviceType_MAC_timestamp_random                    │
│            = "0_AA:BB:CC:DD:EE:FF_1703404800_5678"              │
│                                                                  │
│   2. 计算密码哈希 (双重SHA1)                                    │
│      hash1 = SHA1(localMAC + SHARED_KEY)                        │
│      hash2 = SHA1(nonce + hash1)                                │
│                                                                  │
│   3. 发送登录请求                                               │
│      POST /cgi-bin/luci/api/xqsystem/login                      │
│      Body: username=admin&password={hash2}&logtype=2&nonce=...  │
│                                                                  │
│   4. 获取 token                                                 │
│      Response: {"code":0, "token":"xxxxx", "url":"..."}         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 配置传输流程

```
┌─────────────────────────────────────────────────────────────────┐
│                      配置传输流程                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   config_get (拉取配置)                                         │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  GET /api/misystem/extendwifi_config_pull               │   │
│   │                                                          │   │
│   │  Response Headers:                                       │   │
│   │    Content-Checksum: {MD5}                              │   │
│   │                                                          │   │
│   │  Response Body:                                          │   │
│   │    配置文件内容 (tar.gz)                                 │   │
│   │                                                          │   │
│   │  本地验证:                                               │   │
│   │    计算文件MD5 == Content-Checksum                       │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                  │
│   config_post (推送配置)                                        │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  POST /api/misystem/extendwifi_config_push?checksum=... │   │
│   │                                                          │   │
│   │  Request Headers:                                        │   │
│   │    Content-Type: multipart/form-data                    │   │
│   │                                                          │   │
│   │  Request Body:                                           │   │
│   │    配置文件 (config.tar.gz)                             │   │
│   │                                                          │   │
│   │  Response:                                               │   │
│   │    {"code":0, "ssid_24g":"...", "password_24g":"..."}   │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 接口列表

### 认证

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `account_login(peerIp, peerMac, localMac)` | `peerIp:string` 对端IP, `peerMac:string` 对端MAC, `localMac:string` 本地MAC | `token:string` 或 `errorCode:number` | 登录获取token |

### 配置传输

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `config_get(peerIp, token, savePath)` | `peerIp:string`, `token:string`, `savePath:string` 保存路径 | `errorCode:number` 0=成功 | 从对端获取配置文件 |
| `config_post(peerIp, token, configPath)` | `peerIp:string`, `token:string`, `configPath:string` 配置文件路径 | `errorCode:number, ssid24g, password24g, ssid5g, password5g` | 向对端推送配置文件 |
| `config_finish(peerIp, token, enableWifi, reboot)` | `peerIp:string`, `token:string`, `enableWifi:boolean`, `reboot:boolean` | `errorCode:number` 0=成功 | 完成配置同步 |

## 错误码

| 错误码 | 常量名 | 说明 |
|--------|--------|------|
| 1639 | ERROR_INTERNAL | 内部错误 |
| 1640 | ERROR_PEER_INFO | 对端信息错误 |
| 1641 | ERROR_CONFIG_TRANS | 配置传输错误 |
| 1642 | ERROR_INVALID_MODE | 无效模式 |

## 常量定义

| 常量 | 值 | 说明 |
|------|-----|------|
| `SHARED_KEY` | `a2ffa5c9be07488bbb04a3a47d3c5f6a` | 共享密钥 |
| `LOGIN_TYPE` | 1002 | 登录类型 |
| `RANDOM_MAX` | 9998 | 随机数最大值 |
| `MAX_RETRY` | 6 | 最大重试次数 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `socket.http` | HTTP请求 |
| `cjson` | JSON解析 |
| `luci.http` | URL编码 |
| `xiaoqiang.util.XQCryptoUtil` | SHA1/MD5计算 |
| `xiaoqiang.XQLog` | 日志记录 |
| `ltn12` | 数据传输 |

## 被引用情况

该模块主要被以下组件引用：
- XQExWifiConfSync WiFi配置同步主模块
- 扩展器配置管理
- Mesh网络配置同步

## 关键代码说明

### Nonce生成

```lua
local function generateNonce(mac)
    local deviceType = 0
    local upperMac = string.upper(mac)
    local encodedMac = luciHttp.urlencode(upperMac)
    local timestamp = os.time()
    
    math.randomseed(timestamp)
    local randomNum = math.random(LOGIN_TYPE, RANDOM_MAX)
    
    -- 格式: deviceType_mac_timestamp_random
    local nonce = deviceType .. "_" .. upperMac .. "_" .. timestamp .. "_" .. randomNum
    local encodedNonce = deviceType .. "_" .. encodedMac .. "_" .. timestamp .. "_" .. randomNum
    
    return nonce, encodedNonce
end
```

### 密码哈希计算

```lua
local function calculatePasswordHash(mac, nonce)
    if not nonce then
        return nil
    end
    
    -- 双重SHA1哈希
    -- 第一次: MAC + 共享密钥
    local hash = XQCryptoUtil.sha1(mac .. SHARED_KEY)
    
    -- 第二次: nonce + 第一次哈希结果
    hash = XQCryptoUtil.sha1(nonce .. hash)
    
    return hash
end
```

### 配置文件推送

```lua
function config_post(peerIp, token, configPath)
    local file = io.open(configPath, "rb")
    
    -- 计算MD5校验和
    local checksum = XQCryptoUtil.md5File(configPath)
    local fileSize = getFileSize(file)
    local fileContent = file:read("*a")
    
    -- 构建multipart/form-data请求体
    local boundary = "-----------------------------7004473821227421780129388645"
    local contentDisposition = 'Content-Disposition: form-data; name="config"; filename="config.tar.gz"\r\n'
    local contentType = "Content-Type: application/octetstream\r\n\r\n"
    
    local requestBody = "--" .. boundary .. "\r\n" .. 
                       contentDisposition .. contentType .. 
                       fileContent .. "\r\n--" .. boundary .. "--\r\n"
    
    -- 发送请求
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/;stok=" .. token .. 
              "/api/misystem/extendwifi_config_push?checksum=" .. checksum,
        method = "POST",
        headers = {
            ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
            ["Content-Length"] = #requestBody
        },
        source = ltn12.source.string(requestBody),
        sink = ltn12.sink.table(responseData)
    })
    
    -- 解析响应获取WiFi配置信息
    -- ...
end
```

### 配置完成通知

```lua
function config_finish(peerIp, token, enableWifi, reboot)
    local params
    if not enableWifi and reboot then
        params = "reboot=yes"      -- 重启设备
    elseif enableWifi and not reboot then
        params = "wifi=off"        -- 关闭WiFi
    else
        return 1
    end
    
    local response, status, headers = socketHttp.request({
        url = "http://" .. peerIp .. "/cgi-bin/luci/;stok=" .. token .. 
              "/api/misystem/extendwifi_config_fini?" .. params,
        method = "GET",
        sink = ltn12.sink.table(responseData)
    })
    
    -- ...
end
```

## API端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/cgi-bin/luci/api/xqsystem/login` | POST | 登录认证 |
| `/api/misystem/extendwifi_config_pull` | GET | 拉取配置 |
| `/api/misystem/extendwifi_config_push` | POST | 推送配置 |
| `/api/misystem/extendwifi_config_fini` | GET | 完成同步 |
