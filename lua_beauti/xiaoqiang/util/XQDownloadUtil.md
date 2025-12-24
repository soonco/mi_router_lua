# XQDownloadUtil.lua - 下载工具模块

## 概述

`XQDownloadUtil` 模块提供固件下载功能，包括普通固件下载、CPE 固件下载、下载进度查询、下载取消等。该模块主要用于 OTA 升级和固件更新，支持分片下载和 MTD 分区直写。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    固件下载架构                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │  URL校验     │───▶│  空间检查    │───▶│  curl下载    │  │
│  │  资源检测    │    │  /tmp空间    │    │  断点续传    │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│                                                 │          │
│                                                 ▼          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  CPE固件结构                          │  │
│  │  ┌────────┬─────────────┬────────┬─────────────┐     │  │
│  │  │ Header │   Modem     │  Sign  │    ROM      │     │  │
│  │  │ 固定长 │  动态长度   │ 固定长 │   剩余部分  │     │  │
│  │  └────────┴─────────────┴────────┴─────────────┘     │  │
│  │                                                       │  │
│  │  下载顺序: Header → Modem(MTD) → Sign → ROM          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 普通固件下载

#### syncDownload(url)

同步下载固件。

**参数:**
| 参数 | 类型 | 说明 |
|------|------|------|
| url | string | 固件下载 URL |

**返回值:**
| 返回值 | 类型 | 说明 |
|--------|------|------|
| md5 | string/false | 下载文件的 MD5 值，失败返回 false |
| filePath | string | 下载文件路径 (/tmp/rom.bin) |

---

#### syncDownloadV2(url)

同步下载 V2 版本（改进版，更安全的 URL 处理）。

---

### CPE 固件下载

#### syncDownloadForCpe(url)

同步下载 CPE 固件（支持分片下载和 MTD 直写）。

**返回值:** 是否成功, 文件路径

---

#### getCpeModemLengthFromFile()

从本地文件获取 CPE Modem 长度。

---

### 下载进度

#### downloadPercent()

获取普通固件下载进度百分比。

**返回值:** number - 下载进度 (0-100)

---

#### downloadPercentForCpe()

获取 CPE 固件下载进度百分比。

**返回值:** number - 下载进度 (1-100)

---

### 下载控制

#### cancelDownload()

取消下载任务。

**返回值:** boolean - 是否成功

## 外部依赖

| 模块/文件 | 用途 |
|-----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.XQPreference | 偏好设置存储 |
| xiaoqiang.XQLog | 日志模块 |
| xiaoqiang.util.XQCryptoUtil | MD5 计算 |
| xiaoqiang.util.XQSysUtil | 系统工具 |
| nixio.fs | 文件系统操作 |
| luci.util | LuCI 工具函数 |
| curl | HTTP 下载命令 |
| nandwrite | NAND 写入命令 |
| mtd | MTD 分区操作命令 |

## 被引用情况

- 固件升级 API 控制器
- OTA 更新功能
- 系统升级页面

## 关键代码说明

### curl 命令模板

```lua
-- 普通下载
CURL_DOWNLOAD_CMD = "curl --retry 3 -m 30 -s -f -o %s %s"

-- 资源检测
CURL_CHECK_CMD = "curl --retry 3 -m 10 -s -f -I -o /dev/null %s"

-- 范围下载（分片）
CURL_RANGE_CMD = "curl --range %d-%d --retry 3 -m 30 -s -f -o %s %s"
```

### CPE 固件结构

```lua
CPE_FIRMWARE_INFO = {
    [1] = { size = CPE_HEADER_LENGTH, path = CPE_HEADER_CACHE_FILEPATH },
    [2] = { size = 0, path = CPE_MODEM_CACHE_FILEPATH },  -- 动态长度
    [3] = { size = CPE_SIGN_LENGTH, path = CPE_SIGN_CACHE_FILEPATH },
    [4] = { size = 0, path = ROM_DOWNLOAD_PATH }  -- 剩余部分
}
```

### MTD 分区写入

```lua
LuciUtil.exec(string.format("mtd erase %s", destPath))
LuciUtil.exec(string.format("nandwrite -p -s %d %s %s", 
    writeOffset, destPath, MODEM_SLICE_PATH))
```

CPE 的 Modem 部分直接写入 MTD 分区，支持分片写入避免内存不足。

### URL 安全校验

```lua
local function isValidUrl(url)
    if string.find(url, "[^%w:/?&%%.=#_-]") then
        return false
    end
    return true
end
```

检查 URL 是否包含非法字符，防止命令注入。

### 进度计算

```lua
local downloadedSize = math.modf(nixio.stat(downloadPath).size)
local percent = math.modf(downloadedSize / fullSize * 100)
```

通过比较已下载文件大小与总大小计算进度百分比。
