# XQPredownload.lua - OTA预下载模块

## 概述

`XQPredownload` 模块提供 OTA（Over-The-Air）固件预下载功能的配置管理。该模块允许用户配置自动下载、定时下载、下载优先级等设置，用于在后台预先下载固件更新包。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    OTA预下载配置流程                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   UCI配置    │───▶│  预下载服务   │───▶│  固件下载    │  │
│  │  (otapred)   │    │ predownload  │    │              │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│         │                   │                   │          │
│         ▼                   ▼                   ▼          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    配置参数说明                       │  │
│  │  • auto: 自动下载开关 (0/1)                          │  │
│  │  • time: 定时下载时间 (0-23小时)                     │  │
│  │  • priority: 下载优先级                              │  │
│  │  • plugin: 插件下载开关                              │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### predownloadInfo()

获取当前预下载配置信息。

**参数:** 无

**返回值:**
| 字段 | 类型 | 说明 |
|------|------|------|
| auto | number | 自动下载开关 (0=关闭, 1=开启) |
| time | number | 定时下载时间 (0-23小时) |
| priority | number | 下载优先级 |
| plugin | number | 插件下载开关 (0=关闭, 1=开启) |

---

### setPredownload(priority, auto, time, plugin)

设置预下载配置参数。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| priority | number/string | 下载优先级 |
| auto | number/string | 自动下载开关 |
| time | number/string | 定时下载时间 (0-23) |
| plugin | number/string | 插件下载开关 |

**返回值:** 无

**说明:** 时间参数会进行范围校验，仅接受 0-23 的有效值。

---

### switch(enable)

启动或停止预下载服务。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| enable | boolean | true=启动服务, false=停止服务 |

**返回值:**
| 类型 | 说明 |
|------|------|
| boolean | 操作是否成功 |

---

### reload()

重启预下载服务。

**参数:** 无

**返回值:** 无

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| luci.model.uci | UCI配置管理 |
| /etc/init.d/predownload-ota | 预下载服务脚本 |

## 被引用情况

- API控制器中的固件更新相关接口
- 系统设置页面的预下载配置功能

## 关键代码说明

### 时间参数校验

```lua
if tonumber(time) then
    local timeNum = tonumber(time)
    if 0 <= timeNum and timeNum < 24 then
        uciCursor:set("otapred", "settings", "time", time)
    end
end
```

模块对定时下载时间进行严格的范围校验，确保只接受 0-23 小时的有效值，防止无效配置导致服务异常。

### UCI配置结构

配置存储在 `/etc/config/otapred` 文件中：
- section: `settings`
- options: `auto`, `time`, `priority`, `plugin`
