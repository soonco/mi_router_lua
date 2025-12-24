# XQBaiduPanUtil.lua - 百度网盘工具模块

## 概述

`XQBaiduPanUtil.lua` 是小米路由器的百度网盘集成模块，提供文件上传、下载、同步等功能。该模块支持分片上传、断点续传、会员等级限制等特性，通过百度网盘开放API实现路由器与云存储的数据交互。

**文件位置**: `xiaoqiang/module/XQBaiduPanUtil.lua`  
**模块名**: `xiaoqiang.module.XQBaiduPanUtil`  
**代码行数**: ~1198行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    百度网盘上传流程                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  本地文件                                                    │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  1. 预上传 (precreate)                   │               │
│  │  - 计算文件分片MD5                       │               │
│  │  - 获取uploadid                         │               │
│  └─────────────────────────────────────────┘               │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  2. 分片上传 (superfile2)                │               │
│  │  - 按会员等级确定分片大小                │               │
│  │  - 普通用户: 4MB, 会员: 16MB, 超会: 32MB │               │
│  │  - 支持暂停/继续                         │               │
│  └─────────────────────────────────────────┘               │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  3. 创建文件 (create)                    │               │
│  │  - 合并所有分片                          │               │
│  │  - 完成上传                              │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    百度网盘下载流程                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  百度网盘文件                                                │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  获取下载链接 (dlink)                    │               │
│  │  + access_token                         │               │
│  └─────────────────────────────────────────┘               │
│      │                                                      │
│      ▼                                                      │
│  ┌─────────────────────────────────────────┐               │
│  │  curl下载到本地存储                      │               │
│  │  - 支持断点续传 (-C -)                   │               │
│  │  - 保存到挂载的存储设备                  │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 文件操作函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getFileFromDlink(downloadUrl, accessToken, savePath, resumeMode)` | 多参数 | string/number | 从下载链接获取文件 |
| `routerPost(remotePath, accessToken, localPath, memberLevel, actionId)` | 多参数 | table | 预上传文件 |
| `routerUploadFilePost(remotePath, accessToken, localPath, uploadInfo, actionId)` | 多参数 | number | 分片上传文件 |
| `routerCreateFilePost(remotePath, accessToken, localPath, uploadInfo)` | 多参数 | number | 创建文件（合并分片） |

### 任务管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `puaseUpload(taskId, fileName, filePath, fileSize)` | 多参数 | 无 | 暂停上传任务 |
| `continueUpload(taskId, fileName, filePath, fileSize)` | 多参数 | 无 | 继续上传任务 |
| `deleteTransportList(deleteAll, taskType, actionIds)` | 多参数 | boolean | 删除传输任务 |
| `kill_baidupan_process(actionId)` | actionId: string | 无 | 终止百度网盘进程 |

### 配置管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setBaidupanPath(mountPath)` | mountPath: string | number | 设置存储路径 |
| `getBaidupanPath()` | 无 | table | 获取存储路径状态 |
| `setUserName(userName)` | userName: string | boolean | 设置用户名 |
| `getLocalPanDire()` | 无 | string | 获取本地百度网盘目录 |
| `getBaidupanConfigDir()` | 无 | string | 获取配置目录 |

### 工具函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `lock()` | 无 | 无 | 获取文件锁 |
| `unlock()` | 无 | 无 | 释放文件锁 |
| `userFileSize(filePath, memberLevel)` | 多参数 | number | 检查文件大小限制 |
| `getLocalFileSize(filePath, memberLevel)` | 多参数 | 多值 | 获取文件大小和分片信息 |
| `checkFileFormat(fileListJson)` | fileListJson: string | boolean | 验证文件格式 |
| `checkLocalFileName(fileListJson)` | fileListJson: string | string | 检查本地文件名 |
| `checkRemoteFileName(fileListJson)` | fileListJson: string | string | 检查远程文件名 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP库 |
| `xiaoqiang.XQLog` | 日志模块 |
| `xiaoqiang.common.XQFunction` | 通用函数库 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（MD5计算） |
| `xiaoqiang.module.XQStorage` | 存储模块 |
| `luci.model.uci` | UCI配置 |
| `nixio.fs` | 文件系统操作 |
| `json` | JSON解析 |
| `ubus` | UBUS通信 |

## 被引用情况

该模块被以下模块引用：
- `luci.controller.api.xqsystem` - 系统API百度网盘接口
- 百度网盘后台服务脚本

## 关键代码说明

### 1. 错误码定义

```lua
BDPAN_ERROR_CODE = {
    NO_ERRNO = 1600,                    -- 无错误
    ERROR_NOW_RUNNING = 1601,           -- 正在运行中
    ERROR_FILE_NO_EXIST = 1604,         -- 文件不存在
    ERROR_UPLOADLIST_FULL = 1605,       -- 上传列表已满
    ERROR_DOWNLOADLIST_FULL = 1606,     -- 下载列表已满
    ERROR_INTERNAL = 1660,              -- 内部错误
    ERROR_INVALID_SIZE = 1664,          -- 无效大小
    ERROR_INVALID_LENGTH = 1665,        -- 无效长度
    ERROR_INVALID_PARAMETER = 1666,     -- 无效参数
    ERROR_UBUS_CALL_FAILED = 1669,      -- UBUS调用失败
}
```

### 2. 会员等级文件大小限制

```lua
function userFileSize(filePath, memberLevel)
    local maxSize = 0
    
    if memberLevel == "0" then
        maxSize = 4294967296      -- 4GB (普通用户)
    elseif memberLevel == "1" then
        maxSize = 10737418240     -- 10GB (会员)
    elseif memberLevel == "2" then
        maxSize = 21474836480     -- 20GB (超级会员)
    end
    
    if fileSize > maxSize or fileSize <= 0 then
        return BDPAN_ERROR_CODE.ERROR_INVALID_SIZE
    end
    return 0
end
```

### 3. 分片大小配置

```lua
function getLocalFileSize(filePath, memberLevel)
    local blockSize
    
    if memberLevel == "0" then
        blockSize = 4194304      -- 4MB (普通用户)
    elseif memberLevel == "1" then
        blockSize = 16777216     -- 16MB (会员)
    elseif memberLevel == "2" then
        blockSize = 33554432     -- 32MB (超级会员)
    end
    
    local blockCount = math.ceil(fileSize / blockSize)
    return blockCount, fileSize, blockSize
end
```

### 4. 存储路径状态

```lua
function getBaidupanPath()
    local result = {}
    local savedUuid = uci:get("baidupan", "user", "uuid") or ""
    local hasMounted = checkStorageMounted()
    
    if XQFunction.isStrNil(savedUuid) then
        if hasMounted == 0 then
            result.bindStatus = "0"  -- 未绑定，无存储设备
        else
            result.bindStatus = "1"  -- 未绑定，有存储设备
        end
    else
        local uuidMounted = checkStorageByUuid(savedUuid)
        if hasMounted == 0 then
            result.bindStatus = "2"  -- 已绑定，无存储设备
        elseif uuidMounted == 0 then
            result.bindStatus = "4"  -- 已绑定，但绑定的存储离线
        else
            result.bindStatus = "3"  -- 已绑定，存储在线
        end
    end
    
    return result
end
```

### 5. 文件名安全验证

```lua
function checkFileFormat(fileListJson)
    local fileList = json.decode(fileListJson)
    
    for _, filePath in ipairs(fileList) do
        -- 检查文件是否存在
        if not _file_exists(filePath) then
            return false
        end
        
        -- 检查文件名是否包含4字节UTF-8字符
        local fileName = getFileName(filePath)
        if vaildUtf8Str(fileName) == true then
            return false
        end
        
        -- 检查非法字符
        if string.find(filePath, ":") ~= nil then
            return false
        end
        if string.find(filePath, "|") ~= nil then
            return false
        end
    end
    
    return true
end
```

## 配置存储

| UCI配置 | 说明 |
|---------|------|
| `baidupan.user.name` | 百度网盘用户名 |
| `baidupan.user.uuid` | 绑定的存储设备UUID |
| `baidupan.user.localdir` | 本地存储目录 |

## 文件路径

| 路径 | 说明 |
|------|------|
| `/来自百度网盘/` | 百度网盘本地根目录 |
| `/.baidupan/` | 配置目录 |
| `/.baidupan/tmp/` | 临时文件目录 |
| `/etc/.baidupan/` | 系统配置目录 |
| `/tmp/baidupan/` | 上传临时文件目录 |

## 注意事项

1. **文件锁**: 使用 `/var/run/baidupan.lock` 防止多进程冲突
2. **会员限制**: 不同会员等级有不同的文件大小和分片大小限制
3. **文件名处理**: 自动替换空格、冒号、单引号等特殊字符
4. **UTF-8验证**: 不支持4字节UTF-8字符（如emoji）的文件名
5. **断点续传**: 下载支持断点续传，上传支持暂停/继续
6. **actionId验证**: 删除任务时验证actionId只包含十六进制字符
