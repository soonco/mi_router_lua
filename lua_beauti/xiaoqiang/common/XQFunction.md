# XQFunction.lua - 通用函数模块

## 概述

`XQFunction.lua` 是小米路由器的核心通用函数模块，提供系统级工具函数，包括字符串处理、进程管理、系统控制、数据格式转换等功能。

**模块路径**: `xiaoqiang.common.XQFunction`

## 功能分类

| 分类 | 说明 |
|-----|------|
| 字符串处理 | MAC 格式化、空值检查、中文检测、域名验证 |
| 进程管理 | 异步执行、同步执行、Fork 操作 |
| 系统控制 | 重启、关机、重置、WiFi 重启 |
| 格式转换 | 频率格式化、字节格式化、UTF-8 长度计算 |
| 命令格式化 | 命令行参数转义、安全格式化 |
| 系统锁 | 升级锁管理 |

## 接口列表

### 字符串处理函数

#### macFormat(mac)
**功能**: 格式化 MAC 地址为标准格式 (XX:XX:XX:XX:XX:XX)

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| mac | string | 是 | 原始 MAC 地址 |

**返回值**: 格式化后的 MAC 地址

---

#### isStrNil(str)
**功能**: 检查字符串是否为空

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| str | string | 是 | 待检查的字符串 |

**返回值**: boolean - 是否为空

---

#### checkChineseChar(str)
**功能**: 检查字符串是否包含中文字符

**返回值**: boolean - 是否包含中文

---

#### isDomain(domain)
**功能**: 检查是否为有效域名

**返回值**: boolean - 是否为有效域名

---

### 进程管理函数

#### forkExec(cmd)
**功能**: 异步执行命令（fork 方式）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| cmd | string | 是 | 要执行的命令 |

**说明**: 父进程立即返回，子进程在后台执行命令

---

#### forkExec2(cmd, ...)
**功能**: 异步执行命令（带参数）

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| cmd | string | 是 | 要执行的命令 |
| ... | any | 否 | 命令参数 |

**返回值**: number - 子进程 PID

---

#### waitExec(cmd, ...)
**功能**: 同步执行命令并等待结果

**返回值**: 
- status: 状态
- exit_code: 退出码
- output: 输出内容

---

### 系统控制函数

#### forkRestartWifi(extra_cmd)
**功能**: 异步重启 WiFi

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| extra_cmd | string | 否 | 额外执行的命令 |

---

#### forkReboot()
**功能**: 异步重启路由器

---

#### forkShutdown()
**功能**: 异步关机

---

#### forkResetAll()
**功能**: 异步恢复出厂设置

---

#### forkRestartDnsmasq()
**功能**: 异步重启 DNS 服务

---

#### forkShutdownAndRebootWithDelay(shutdown_delay, reboot_delay)
**功能**: 延时关机并重启

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| shutdown_delay | number | 是 | 关机延时（分钟）|
| reboot_delay | number | 是 | 重启延时（秒）|

---

### 格式转换函数

#### hzFormat(hz)
**功能**: 格式化频率（Hz）

**返回值**: 格式化后的频率字符串（如 "2.40 GHz"）

---

#### byteFormat(bytes)
**功能**: 格式化字节数

**返回值**: 格式化后的字节字符串（如 "1.50 GB"）

---

#### utfstrlen(str)
**功能**: 计算 UTF-8 字符串长度

**返回值**: 字符数（非字节数）

---

### 系统锁函数

#### sysLock()
**功能**: 获取系统锁（用于升级等操作）

---

#### sysUnlock()
**功能**: 释放系统锁

---

#### sysLockStatus()
**功能**: 检查系统锁状态

**返回值**: 1=已锁定, 0=未锁定

---

### 命令格式化函数

#### _cmdformat(str)
**功能**: 格式化命令行参数（转义特殊字符）

**转义字符**: `\`, `` ` ``, `"`, `$`

---

#### _strformat(str)
**功能**: 格式化字符串（移除单引号并转义）

---

#### paramFormat(str)
**功能**: 格式化参数（转义特殊字符）

---

### NVRAM/BDATA 操作

#### getBdataValue(key, default)
**功能**: 从 bdata 获取值

---

#### getNvramValue(key, default)
**功能**: 从 nvram 获取值

---

#### setNvramValue(key, value)
**功能**: 设置 nvram 值

---

#### nvramCommit()
**功能**: 提交 nvram 更改

---

### 其他函数

#### ledFlashAlert(enable)
**功能**: LED 闪烁提醒控制

---

#### getGpioValue(gpio)
**功能**: 获取 GPIO 值

---

#### get_cac_time(mode, iface, channel, bandwidth)
**功能**: 获取 WiFi CAC 时间

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `nixio` | POSIX 系统调用（fork、exec）|
| `luci.model.uci` | UCI 配置管理 |
| `luci.util` | LuCI 工具函数 |
| `luci.fs` | 文件系统操作 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |

## 被引用情况

该模块是最核心的工具模块，被几乎所有业务模块引用。

## 关键代码说明

### Fork 执行实现
```lua
function forkExec(cmd)
    local nixio = require("nixio")
    local pid = nixio.fork()
    
    if pid > 0 then
        return  -- 父进程直接返回
    elseif pid == 0 then
        -- 子进程
        nixio.chdir("/")
        
        -- 重定向标准输入输出到 /dev/null
        local null = nixio.open("/dev/null", "w+")
        if null then
            nixio.dup(null, nixio.stderr)
            nixio.dup(null, nixio.stdout)
            nixio.dup(null, nixio.stdin)
            if null:fileno() > 2 then
                null:close()
            end
        end
        
        nixio.exec("/bin/sh", "-c", cmd)
    end
end
```

### 命令参数转义
```lua
function _cmdformat(str)
    if isStrNil(str) then
        return ""
    end
    
    str = str:gsub("\\", "\\\\")
    str = str:gsub("`", "\\`")
    str = str:gsub("\"", "\\\"")
    str = str:gsub("%$", "\\$")
    
    return str
end
```
