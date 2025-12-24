# LuCI CBI 模块

## 目录概述

本目录包含 LuCI CBI (Configuration Bind Interface) 框架的核心模块，主要用于 OpenWrt Web 界面的表单配置和数据验证。

## 目录结构

```
luci/cbi/
├── datatypes.lua       # 数据类型验证模块
├── datatypes.lua.md    # datatypes.lua 的详细说明文档
└── Readme.md           # 本文件
```

## 模块说明

### datatypes.lua - 数据类型验证模块

**功能**: 提供各种数据类型的验证函数，用于 CBI 表单输入值的合法性检查。

**验证类别**:

| 类别 | 函数 | 说明 |
|------|------|------|
| 逻辑验证 | `or`, `and`, `neg`, `list` | 组合验证逻辑 |
| 布尔验证 | `bool` | 验证布尔值表示 |
| 数值验证 | `integer`, `uinteger`, `float`, `ufloat`, `range`, `min`, `max` | 验证各类数值 |
| 网络验证 | `ipaddr`, `ip4addr`, `ip6addr`, `ip4prefix`, `ip6prefix`, `port`, `portrange`, `macaddr` | 验证网络相关数据 |
| 主机验证 | `hostname`, `host`, `network` | 验证主机名和网络名称 |
| 安全验证 | `wpakey`, `wepkey` | 验证无线密钥 |
| 文件验证 | `file`, `directory`, `device` | 验证文件系统路径 |
| 字符串验证 | `string`, `uciname`, `minlength`, `maxlength`, `rangelength`, `phonedigit` | 验证字符串格式 |

**依赖模块**:
- `nixio.fs` - 文件系统操作
- `luci.ip` - IP 地址处理
- `luci.util` - 工具函数
- `math` - 数学函数

**使用示例**:

```lua
local dt = require("luci.cbi.datatypes")

-- 验证 IPv4 地址
dt.ip4addr("192.168.1.1")  -- true

-- 验证端口范围
dt.portrange("1024-65535")  -- true

-- 验证 MAC 地址
dt.macaddr("AA:BB:CC:DD:EE:FF")  -- true

-- 验证 WPA 密钥
dt.wpakey("mypassword123")  -- true (8-63字符)

-- 数值范围验证
dt.range("50", "0", "100")  -- true
```

## 核心功能

### 1. 表单输入验证

CBI 数据类型模块的主要用途是验证用户在 Web 界面输入的配置值，确保数据格式正确后再写入 UCI 配置文件。

### 2. 支持的验证规则

| 验证类型 | 示例值 | 说明 |
|----------|--------|------|
| IPv4 地址 | `192.168.1.1` | 标准点分十进制格式 |
| IPv6 地址 | `2001:db8::1` | 标准 IPv6 格式 |
| 端口号 | `0-65535` | 有效端口范围 |
| 端口范围 | `1024-65535` | 起始端口-结束端口 |
| MAC 地址 | `AA:BB:CC:DD:EE:FF` | 冒号分隔的十六进制 |
| 主机名 | `router.local` | 符合 RFC 规范的主机名 |
| WPA 密钥 | 8-63字符 或 64位十六进制 | WPA/WPA2 密码 |
| WEP 密钥 | 5/13字符 或 10/26位十六进制 | WEP 密码 |
| UCI 名称 | `wan`, `lan_zone` | 字母数字下划线 |

### 3. 组合验证

支持通过 `or` 和 `and` 函数进行复杂的组合验证：

```lua
-- 值必须是 IP 地址或主机名
dt["or"](value, dt.ipaddr, {}, dt.hostname, {})

-- 值必须同时满足多个条件
dt["and"](value, dt.integer, {}, dt.min, {0}, dt.max, {100})
```

### 4. 列表验证

支持验证空格分隔的值列表：

```lua
-- 验证多个 IP 地址
dt.list("192.168.1.1 192.168.1.2 192.168.1.3", dt.ip4addr)
```

## 与其他模块的关系

```
┌─────────────────────────────────────────────────────┐
│                   LuCI Web 界面                      │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│                    CBI 表单框架                      │
│  ┌─────────────────────────────────────────────┐   │
│  │              datatypes.lua                   │   │
│  │           (数据类型验证模块)                  │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────┐
│                   UCI 配置系统                       │
└─────────────────────────────────────────────────────┘
```

## 扩展指南

如需添加新的验证类型，可在 `datatypes.lua` 中添加新函数：

```lua
-- 添加自定义验证函数
function custom_validator(value)
    -- 实现验证逻辑
    return true or false
end
```

## 文件说明对照表

| 文件 | 类型 | 说明 |
|------|------|------|
| `datatypes.lua` | 源代码 | 数据类型验证模块实现 |
| `datatypes.lua.md` | 文档 | datatypes.lua 的详细 API 文档 |

## 相关链接

- LuCI 官方文档: https://openwrt.org/docs/guide-developer/luci
- UCI 配置系统: https://openwrt.org/docs/guide-user/base-system/uci
