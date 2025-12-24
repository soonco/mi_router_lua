# XQNetworkSpeedTest.lua - 网络测速模块

## 概述

`XQNetworkSpeedTest` 是小米路由器的网络速度测试模块，提供上传和下载速度测试功能。该模块支持同步和异步测速模式，测速结果会保存到偏好设置中供后续查询。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    网络测速流程                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                    测速模式选择                        │      │
│  │  ┌────────────────┐      ┌────────────────┐         │      │
│  │  │  同步测速       │      │  异步测速       │         │      │
│  │  │ syncSpeedTest  │      │ asyncSpeedTest │         │      │
│  │  └───────┬────────┘      └───────┬────────┘         │      │
│  └──────────┼───────────────────────┼──────────────────┘      │
│             │                       │                          │
│             ▼                       ▼                          │
│  ┌──────────────────┐    ┌──────────────────┐                 │
│  │ 直接执行测速命令  │    │ 后台执行测速脚本  │                 │
│  └────────┬─────────┘    │ speed_test.lua   │                 │
│           │              └────────┬─────────┘                 │
│           │                       │                            │
│           ▼                       ▼                            │
│  ┌─────────────────────────────────────────────────────┐      │
│  │                   测速命令                           │      │
│  │  ┌────────────────────┐  ┌────────────────────┐    │      │
│  │  │ /usr/bin/          │  │ /usr/bin/          │    │      │
│  │  │ upload_speedtest   │  │ download_speedtest │    │      │
│  │  └─────────┬──────────┘  └─────────┬──────────┘    │      │
│  └────────────┼───────────────────────┼───────────────┘      │
│               │                       │                        │
│               ▼                       ▼                        │
│  ┌─────────────────────────────────────────────────────┐      │
│  │                   结果解析                           │      │
│  │  avg tx: xxx (bps)  →  上传速度 (MB/s)              │      │
│  │  avg rx: xxx (bps)  →  下载速度 (MB/s)              │      │
│  └────────────────────────┬────────────────────────────┘      │
│                           │                                    │
│                           ▼                                    │
│  ┌─────────────────────────────────────────────────────┐      │
│  │              XQPreference 存储                       │      │
│  │  UPLOAD_SPEED / DOWNLOAD_SPEED                       │      │
│  └─────────────────────────────────────────────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 单位转换

```
测速结果单位转换:
bps (bits per second) → MB/s (MegaBytes per second)

公式: MB/s = bps / 8
(因为 1 Byte = 8 bits)
```

## 接口列表

### 公开函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `uploadSpeedTest()` | 无 | number/nil | 执行上传速度测试 |
| `downloadSpeedTest()` | 无 | number/nil | 执行下载速度测试 |
| `saveSpeedTestResult(uploadSpeed, downloadSpeed)` | uploadSpeed, downloadSpeed: number | 无 | 保存测速结果 |
| `getSpeedTestResult()` | 无 | number, number | 获取保存的测速结果 |
| `speedTest()` | 无 | number, number | 执行完整速度测试 |
| `asyncSpeedTest()` | 无 | 无 | 异步执行速度测试 |
| `syncSpeedTest()` | 无 | number, number | 同步执行速度测试 |

### 返回值说明

**uploadSpeedTest/downloadSpeedTest:**
- 返回速度值 (MB/s)，精确到小数点后2位
- 测试失败返回 nil

**getSpeedTestResult:**
- 返回 uploadSpeed, downloadSpeed
- 如果结果有效返回实际值
- 如果结果为0返回 0, 0
- 如果无结果返回 nil, nil

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.util` | 命令执行 |
| `xiaoqiang.common.XQFunction` | 通用函数（字符串检查、异步执行） |
| `xiaoqiang.XQPreference` | 测速结果存储 |

### 系统依赖

| 命令/脚本 | 用途 |
|-----------|------|
| `/usr/bin/upload_speedtest` | 上传速度测试命令 |
| `/usr/bin/download_speedtest` | 下载速度测试命令 |
| `/usr/bin/speedtest` | 综合速度测试命令 |
| `/usr/sbin/speed_test.lua` | 异步测速脚本 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | 网络测速接口 |
| 小米WiFi App | 网络测速功能 |
| 网络诊断页面 | 带宽检测 |

## 关键代码说明

### 上传速度测试

```lua
function uploadSpeedTest()
    local uploadCmd = "/usr/bin/upload_speedtest"
    local result = luciUtil.exec(uploadCmd)
    
    for line in result:gmatch("[^\r\n]+") do
        -- 匹配上传速度行: "avg tx: xxx"
        if line:match("^avg tx:") then
            uploadSpeed = line:match("^avg tx:(%S+)")
            if uploadSpeed then
                -- 将bps转换为MB/s (除以8)
                uploadSpeed = tonumber(string.format("%.2f", uploadSpeed / 8))
            end
            break
        end
    end
    
    return uploadSpeed
end
```

### 下载速度测试

```lua
function downloadSpeedTest()
    local downloadCmd = "/usr/bin/download_speedtest"
    local result = luciUtil.exec(downloadCmd)
    
    for line in result:gmatch("[^\r\n]+") do
        -- 匹配下载速度行: "avg rx: xxx"
        if line:match("^avg rx:") then
            downloadSpeed = line:match("^avg rx:(%S+)")
            if downloadSpeed then
                -- 将bps转换为MB/s
                downloadSpeed = tonumber(string.format("%.2f", downloadSpeed / 8))
            end
            break
        end
    end
    
    return downloadSpeed
end
```

### 异步测速

```lua
function asyncSpeedTest()
    -- 先将结果重置为0，表示测速进行中
    saveSpeedTestResult(0, 0)
    
    -- 异步执行测速脚本
    XQFunction.forkExec("lua /usr/sbin/speed_test.lua")
end
```

### 结果存储与获取

```lua
function saveSpeedTestResult(uploadSpeed, downloadSpeed)
    if tonumber(uploadSpeed) and tonumber(downloadSpeed) then
        XQPreference.set("UPLOAD_SPEED", tostring(uploadSpeed))
        XQPreference.set("DOWNLOAD_SPEED", tostring(downloadSpeed))
    end
end

function getSpeedTestResult()
    local uploadSpeed = tonumber(XQPreference.get("UPLOAD_SPEED"))
    local downloadSpeed = tonumber(XQPreference.get("DOWNLOAD_SPEED"))
    
    if uploadSpeed and downloadSpeed then
        if uploadSpeed > 0 and downloadSpeed > 0 then
            return uploadSpeed, downloadSpeed
        elseif uploadSpeed == 0 or downloadSpeed == 0 then
            return 0, 0  -- 测速进行中
        end
    end
    return nil, nil  -- 无测速结果
end
```

### 使用示例

```lua
-- 异步测速
asyncSpeedTest()

-- 轮询获取结果
local upload, download = getSpeedTestResult()
while upload == 0 and download == 0 do
    os.execute("sleep 1")
    upload, download = getSpeedTestResult()
end

if upload and download then
    print(string.format("上传: %.2f MB/s, 下载: %.2f MB/s", upload, download))
end

-- 同步测速
local upload, download = syncSpeedTest()
print(string.format("上传: %.2f MB/s, 下载: %.2f MB/s", upload, download))
```
