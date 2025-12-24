# version.lua - 版本信息模块

## 工作原理

LuCI 版本信息模块，提供 LuCI 和 OpenWrt 固件的版本信息。

工作流程：
1. 尝试读取 `/etc/openwrt_release` 文件
2. 如果成功，从全局变量获取发行版描述
3. 如果失败，使用默认的开发版本信息

版本信息来源：
- OpenWrt 发行版信息来自系统文件
- LuCI 版本信息硬编码在模块中

## 接口

### 模块变量

| 变量 | 类型 | 说明 |
|------|------|------|
| `distname` | string | 发行版名称 |
| `distversion` | string | 发行版版本描述 |
| `luciname` | string | LuCI 名称和版本 |
| `luciversion` | string | LuCI 版本号 |

### 默认值

| 变量 | 默认值 | 条件 |
|------|--------|------|
| `distname` | "OpenWrt Firmware" | 读取发行版文件失败时 |
| `distversion` | "Development Snapshot" | 读取发行版文件失败时 |
| `distname` | "" | 读取成功且有 DISTRIB_DESCRIPTION |
| `distversion` | DISTRIB_DESCRIPTION | 读取成功时 |

### 固定值

| 变量 | 值 |
|------|-----|
| `luciname` | "LuCI 0.11.1 Release" |
| `luciversion` | "0.11.1" |

### 使用示例

```lua
local version = require("luci.version")

print("LuCI: " .. version.luciname)
print("Firmware: " .. version.distversion)
```

## 外部引用

| 文件 | 用途 |
|------|------|
| `/etc/openwrt_release` | OpenWrt 发行版信息文件 |
