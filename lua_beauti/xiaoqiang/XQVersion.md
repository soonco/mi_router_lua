# XQVersion.lua - 版本信息模块

## 概述

`XQVersion.lua` 是小米路由器的版本信息模块，定义了Web界面版本号、默认路由器IP地址以及各平台客户端的下载地址。该模块提供静态配置信息，供其他模块引用。

**文件位置**: `xiaoqiang/XQVersion.lua`  
**模块名**: `xiaoqiang.XQVersion`  
**代码行数**: ~43行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    版本信息配置                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           Web界面配置                    │               │
│  │  webVersion = "0.0.3"                   │               │
│  │  webDefaultHost = "192.168.31.1"        │               │
│  └─────────────────────────────────────────┘               │
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           客户端下载地址                 │               │
│  │                                          │               │
│  │  ┌─────────────┐  ┌─────────────┐       │               │
│  │  │  Windows    │  │   macOS     │       │               │
│  │  │ xqpc_client │  │ xqmac_client│       │               │
│  │  │   .exe      │  │   .dmg      │       │               │
│  │  └─────────────┘  └─────────────┘       │               │
│  │                                          │               │
│  │  ┌─────────────┐                        │               │
│  │  │  Android    │                        │               │
│  │  │  xqapp.apk  │                        │               │
│  │  └─────────────┘                        │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 常量定义

| 常量名 | 类型 | 值 | 说明 |
|--------|------|-----|------|
| `webVersion` | string | "0.0.3" | Web界面版本号 |
| `webDefaultHost` | string | "192.168.31.1" | 默认路由器管理IP地址 |

### PC客户端下载地址

| 常量名 | 类型 | 说明 |
|--------|------|------|
| `pcClientRouter` | string | PC客户端路由器本地下载地址 |
| `pcClientServer` | string | PC客户端服务器下载地址 |

### Mac客户端下载地址

| 常量名 | 类型 | 说明 |
|--------|------|------|
| `macClientRouter` | string | Mac客户端路由器本地下载地址 |
| `macClientServer` | string | Mac客户端服务器下载地址 |

### Android客户端下载地址

| 常量名 | 类型 | 说明 |
|--------|------|------|
| `androidClientRouter` | string | Android客户端路由器本地下载路径 |
| `androidClientServer` | string | Android客户端服务器下载地址 |

## 外部依赖

无外部依赖，该模块仅定义静态常量。

## 被引用情况

该模块被以下模块引用：
- `luci.controller.api.xqsystem` - 系统API获取版本信息
- `luci.view` 模板 - 页面显示版本号
- `xiaoqiang.util.XQSysUtil` - 系统工具获取默认配置

## 关键代码说明

### 完整模块定义

```lua
module("xiaoqiang.XQVersion")

-- Web界面版本号
webVersion = "0.0.3"

-- 默认路由器管理IP地址
webDefaultHost = "192.168.31.1"

-- PC客户端下载地址 (Windows)
-- 路由器本地下载
pcClientRouter = "http://bigota.miwifi.com/xiaoqiang/client/xqpc_client.exe"
-- 服务器下载
pcClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqpc_client.exe"

-- Mac客户端下载地址 (macOS)
-- 路由器本地下载
macClientRouter = "http://bigota.miwifi.com/xiaoqiang/client/xqmac_client.dmg"
-- 服务器下载
macClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqmac_client.dmg"

-- Android客户端下载地址
-- 路由器本地下载路径
androidClientRouter = "/client/xqapp.apk"
-- 服务器下载
androidClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqapp.apk"
```

## 下载地址说明

### 下载服务器

所有客户端下载都托管在小米OTA服务器：
- **域名**: `bigota.miwifi.com`
- **路径**: `/xiaoqiang/client/`

### 客户端文件

| 平台 | 文件名 | 格式 |
|------|--------|------|
| Windows | xqpc_client.exe | 可执行文件 |
| macOS | xqmac_client.dmg | 磁盘映像 |
| Android | xqapp.apk | 安装包 |

### 下载方式

1. **路由器本地下载**: 通过路由器内置HTTP服务器下载
2. **服务器下载**: 直接从小米服务器下载

## 使用示例

```lua
local XQVersion = require("xiaoqiang.XQVersion")

-- 获取Web版本号
local version = XQVersion.webVersion  -- "0.0.3"

-- 获取默认管理地址
local host = XQVersion.webDefaultHost  -- "192.168.31.1"

-- 获取Android客户端下载地址
local apk_url = XQVersion.androidClientServer
```

## 注意事项

1. **版本号格式**: 使用语义化版本号（主版本.次版本.修订号）
2. **默认IP地址**: 192.168.31.1 是小米路由器的标准默认网关
3. **下载地址一致性**: Router和Server下载地址当前相同
4. **Android本地路径**: 使用相对路径 `/client/xqapp.apk`
5. **模块声明**: 使用简单的 `module()` 声明，不使用 `package.seeall`
