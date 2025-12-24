# XQDownload.lua - 下载管理模块

## 概述

XQDownload 是小米路由器的下载管理模块，基于 Aria2 下载引擎实现。该模块提供完整的下载任务管理功能，支持 HTTP/FTP/BT/磁力链接等多种下载方式，通过 JSON-RPC 协议与 Aria2 进程通信。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        XQDownload 下载管理模块                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────┐    JSON-RPC     ┌──────────────┐                      │
│  │  Web API     │ ──────────────► │   Aria2      │                      │
│  │  Controller  │    localhost    │   Engine     │                      │
│  └──────────────┘     :6800       └──────────────┘                      │
│         │                                │                               │
│         │                                │                               │
│         ▼                                ▼                               │
│  ┌──────────────┐              ┌──────────────────┐                     │
│  │  UCI配置     │              │  下载任务        │                     │
│  │  aria2       │              │  ├─ HTTP/FTP    │                     │
│  └──────────────┘              │  ├─ BT种子      │                     │
│         │                       │  └─ 磁力链接   │                     │
│         ▼                                │                               │
│  ┌──────────────────────────────────────┴───────────────────────────┐  │
│  │                        记录文件系统                                │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐  │  │
│  │  │basic_file  │  │ondownload  │  │complete    │  │error       │  │  │
│  │  │基本记录    │  │下载中记录  │  │已完成记录  │  │错误记录    │  │  │
│  │  └────────────┘  └────────────┘  └────────────┘  └────────────┘  │  │
│  └──────────────────────────────────────────────────────────────────┘  │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Aria2 JSON-RPC 通信

```
┌─────────────┐                    ┌─────────────┐
│  XQDownload │                    │   Aria2     │
└──────┬──────┘                    └──────┬──────┘
       │                                   │
       │  aria2.addUri(uri, options)      │
       │ ─────────────────────────────────►│
       │                                   │
       │  返回 GID (任务ID)                │
       │ ◄─────────────────────────────────│
       │                                   │
       │  aria2.tellStatus(gid)           │
       │ ─────────────────────────────────►│
       │                                   │
       │  返回任务状态                     │
       │ ◄─────────────────────────────────│
       │                                   │
       │  system.multicall(批量操作)       │
       │ ─────────────────────────────────►│
       │                                   │
```

## 接口列表

### 全局配置管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getGlobalOption()` | 无 | `options:table, errorCode:number` | 获取Aria2全局配置 |
| `changeGlobalOption(maxDownloadLimit, maxConcurrentDownloads)` | `maxDownloadLimit:string` 最大下载速度, `maxConcurrentDownloads:string` 最大并发数 | `errorCode:number` | 修改全局配置 |
| `getStatus()` | 无 | `status:string, errorCode:number` | 获取Aria2服务状态 |
| `setStatus(status)` | `status:string` 状态值("0"或"1") | `status:number, errorCode:number` | 设置服务状态 |

### 任务查询

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `tellActive()` | 无 | `tasks:table, errorCode:number` | 获取正在下载的任务 |
| `tellWaiting()` | 无 | `tasks:table, errorCode:number` | 获取等待中的任务 |
| `tellStopped()` | 无 | `tasks:table, errorCode:number` | 获取已停止的任务 |
| `tellOndownload()` | 无 | `tasks:table, errorCode:number` | 获取下载中任务(批量) |
| `tellAll()` | 无 | `summary:table, errorCode:number` | 获取所有任务汇总 |
| `getTaskInfo(gidList)` | `gidList:table` GID列表 | `tasks:table, errorCode:number` | 批量获取任务信息 |

### 任务控制

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `pause(gidList)` | `gidList:table` GID列表 | `result:table, errorCode:number` | 暂停指定任务 |
| `unpause(gidList)` | `gidList:table` GID列表 | `result:table, errorCode:number` | 恢复指定任务 |
| `pauseAll()` | 无 | `result:table, errorCode:number` | 暂停所有任务 |
| `unpauseAll()` | 无 | `result:table, errorCode:number` | 恢复所有任务 |
| `remove(gidList)` | `gidList:table` GID列表 | `result:table, errorCode:number` | 删除任务 |
| `changeOption(gidList, selectFile)` | `gidList:table`, `selectFile:string` 文件索引 | `result:table, errorCode:number` | 修改任务选项 |
| `restart(gidList)` | `gidList:table` GID列表 | `result:table, errorCode:number` | 重启失败任务 |

### 任务添加

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `addUri(uriData, dir, pause, skipCheck)` | `uriData:table` URI数据, `dir:string` 下载目录, `pause:string` 是否暂停, `skipCheck:boolean` 跳过重复检查 | `result:table, errorCode:number` | 添加URI下载 |
| `addTorrent(torrentPath, dir, pause, skipCheck)` | `torrentPath:string` 种子路径, `dir:string` 下载目录, `pause:string`, `skipCheck:boolean` | `result:table, errorCode:number` | 添加BT种子下载 |

### 文件搜索

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `searchBitTorrentFile(searchPath, action)` | `searchPath:string` 搜索路径, `action:string` 操作(start/stop/get) | `result:table, errorCode:number, status:string` | 搜索BT种子文件 |
| `getSearchResult(resultFile)` | `resultFile:string` 结果文件路径 | `result:table, status:string, errorCode:number` | 获取搜索结果 |

### 记录管理

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `clean(gidList)` | `gidList:table` GID列表 | `count:number` | 清理已完成任务记录 |
| `errorDelete(gidList)` | `gidList:table` GID列表 | `count:number` | 删除错误任务记录 |
| `filePathGet(gid)` | `gid:string` 任务GID | `path:string` | 获取任务文件路径 |
| `checkPath(path)` | `path:string` 路径 | `errorCode:number` | 验证下载路径 |
| `fileNotExist(gid)` | `gid:string` 任务GID | 无 | 标记文件不存在 |

## 错误码定义

| 错误码 | 说明 |
|--------|------|
| 0 | 操作成功 |
| 2901 | 添加种子失败 |
| 2903 | 获取全局选项失败 |
| 2904 | 修改选项失败 |
| 2906 | 删除任务失败 |
| 2907 | 路径为空 |
| 2908 | 路径不存在 |
| 2911 | 任务已存在 |
| 2912 | 添加URI失败 |
| 2913 | JSON格式错误 |
| 2914 | 查询任务失败 |
| 2915 | 参数无效 |
| 2916 | 文件打开失败 |
| 2917 | 路径不在/mnt下 |
| 2918 | 操作类型无效 |
| 2920 | 暂停所有任务失败 |
| 2921 | 恢复所有任务失败 |
| 2922 | lost+found目录不允许 |
| 2923 | 非种子文件 |
| 2924 | 文件过大(>45MB) |
| 2925 | 脚本正在运行 |
| 2926 | 配置文件不存在 |
| 2927 | 重启任务失败 |

## 任务状态码

| 状态码 | 状态字符串 | 说明 |
|--------|-----------|------|
| 1 | active | 正在下载 |
| 2 | paused | 已暂停 |
| 3 | complete | 已完成 |
| 4 | waiting | 等待中 |
| 0 | - | 未知状态 |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `xiaoqiang.XQLog` | 日志记录 |
| `json` | JSON编解码 |
| `json.rpc` | JSON-RPC调用 |
| `luci.model.uci` | UCI配置读写 |
| `luci.util` | 命令执行 |
| `luci.sys` | 系统调用 |
| `nixio.fs` | 文件系统操作 |
| `xiaoqiang.common.XQFunction` | 通用函数(forkExec) |
| `xiaoqiang.util.XQCryptoUtil` | MD5计算 |

## 被引用情况

该模块主要被以下组件引用：
- Web API下载管理接口
- 远程下载功能
- 迅雷/百度网盘等第三方下载集成

## 关键代码说明

### GID验证

```lua
local function isValidGid(gid)
    local len = #gid
    if len ~= 16 then
        return false
    end
    return true
end
```

GID是Aria2任务的唯一标识，必须是16位十六进制字符串。

### 路径安全验证

```lua
local function validateDownloadPath(path, isRoot)
    -- 检查路径是否为空
    if not path or path == "" then
        return 2907
    end
    
    -- 检查路径是否存在
    local realPath = fs.realpath(path)
    if realPath == nil then
        return 2908
    end
    
    -- 检查路径是否在/mnt目录下
    if isRoot then
        local found = string.find(realPath, "/mnt")
        if found == nil then
            return 2917
        end
    else
        local found = string.find(realPath, "/mnt/")
        if found == nil then
            return 2917
        end
        
        -- 禁止lost+found目录
        local lostFound = string.find(realPath, lostFoundPattern, #lostFoundPattern)
        if lostFound ~= nil then
            return 2922
        end
    end
    
    return 0
end
```

### 批量RPC调用

```lua
function tellOndownload()
    local method = "system.multicall"
    local paramsStr = "[[{'methodName':'aria2.tellActive'},{'methodName':'aria2.tellWaiting','params':[0,1000]}]]"
    local params = json.decode(paramsStr)
    
    local response, err = json.rpc.call(ARIA2_RPC_URL, method, params)
    -- ...
end
```

使用`system.multicall`批量调用多个RPC方法，提高效率。

### 种子文件验证

```lua
local function validateTorrentFile(filePath)
    -- 检查扩展名
    result = checkFileExtension(filePath, ".torrent")
    if result ~= 0 then
        return 2923  -- 非种子文件
    end
    
    -- 检查文件大小 (限制45MB)
    result = compareFileSize(getFileSize(filePath), "47185920")
    if result ~= 0 then
        return 2924  -- 文件过大
    end
    
    return 0
end
```

### 任务去重机制

```lua
local function isLinkExist(link)
    -- 从basic_file中查找是否已存在相同链接
    for line in file:lines() do
        local record = json.decode(line)
        for key, value in pairs(record) do
            if key == "link" and link == value then
                return true
            end
        end
    end
    return false
end

local function isMd5Exist(md5)
    -- 通过grep快速检查种子文件MD5是否已存在
    local cmd = "grep -sq -m 1 '\"md5\": \"" .. md5 .. "\"' " .. basicFile
    local result = sys.call(cmd)
    return result == 0
end
```
