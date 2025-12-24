# xqdatacenter.lua - 小米数据中心 API 控制器模块

## 概述

小米数据中心 API 控制器模块（XQ Datacenter API Controller），提供数据中心相关的 API 接口，包括文件下载/上传、缩略图获取、设备识别、文件系统检测和修复、SSH 插件管理、隧道请求等功能。

**文件路径**: `luci/controller/api/xqdatacenter.lua`  
**模块名称**: `luci.controller.api.xqdatacenter`  
**API 路径**: `/api/xqdatacenter/*`  
**功能开关**: 依赖 `XQFeatures.apps.xqdatacenter` 配置

## 工作原理

1. **功能开关**: 根据 `XQFeatures.apps.xqdatacenter` 配置决定是否注册 API
2. **隧道通信**: 通过 thrift 隧道与数据中心服务通信
3. **nginx 加速**: 文件下载使用 nginx 的 X-Accel-Redirect 实现内部重定向
4. **断点续传**: 支持 HTTP Range 请求实现断点续传

## 接口/函数列表

### 内部函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `pathEncode(path)` | path: string | string | URL 路径编码，保留斜杠 |

### API 端点

| API 路径 | 函数名 | 权限 | 说明 |
|----------|--------|------|------|
| `/api/xqdatacenter/request` | `tunnelRequest()` | 默认 | 隧道请求 |
| `/api/xqdatacenter/identify_device` | `identifyDevice()` | 8 | 设备识别 |
| `/api/xqdatacenter/download` | `download()` | 默认 | 文件下载 |
| `/api/xqdatacenter/upload` | `upload()` | 16 | 文件上传 |
| `/api/xqdatacenter/thumb` | `getThumb()` | 默认 | 获取缩略图 |
| `/api/xqdatacenter/device_id` | `getDeviceId()` | 默认 | 获取设备 ID |
| `/api/xqdatacenter/check_file_exist` | `checkFileExist()` | 默认 | 检查文件是否存在 |
| `/api/xqdatacenter/plugin_ssh` | `pluginSSH()` | 默认 | SSH 插件控制 |
| `/api/xqdatacenter/plugin_ssh_status` | `pluginSSHStatus()` | 默认 | 获取 SSH 插件状态 |
| `/api/xqdatacenter/fsys_probe` | `fsysProbe()` | 默认 | 文件系统探测 |
| `/api/xqdatacenter/fsys_resume` | `fsysResume()` | 默认 | 文件系统修复 |

### 详细接口说明

#### download - 文件下载

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| path | string | 是 | 文件路径 |

**允许的下载路径**:
- `/userdisk/data/`
- `/mnt/`
- `/userdisk/privacyData/`
- `/userdisk/appdata/`
- `/userdisk/.thumbnails/`

**响应头**:
- `Accept-Ranges: bytes`
- `Content-Type`: 根据文件类型
- `Content-Length`: 文件大小
- `Content-Range`: 断点续传范围
- `Content-Disposition`: 附件下载
- `X-Accel-Redirect`: nginx 内部重定向

#### upload - 文件上传

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| target | string | 是 | 目标目录 |
| file | file | 是 | 上传的文件 |

**返回值**:
```json
{
    "code": 0
}
```

#### pluginSSH - SSH 插件控制

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| pluginID | string | 条件 | 插件 ID（开启时必填） |
| capability | string | 条件 | 能力列表，逗号分隔（开启时必填） |
| open | number | 是 | 开关状态（1=开启，0=关闭） |

**返回值**:
```json
{
    "code": 0
}
```

#### pluginSSHStatus - SSH 插件状态

**返回值**:
```json
{
    "code": 0,
    "enable": 1,
    "pluginID": "xxx",
    "capability": [
        {
            "key": "ssh",
            "name": "SSH",
            "enable": 1
        }
    ]
}
```

#### fsysProbe - 文件系统探测

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| type | number | 是 | 操作类型（1=检测，2=获取状态） |

**返回值**:
```json
{
    "code": 0,
    "status": {
        "healthy": true,
        "errors": []
    }
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `luci.http` | HTTP 请求处理 |
| `json` | JSON 编解码 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理工具 |
| `xiaoqiang.XQFeatures` | 特性配置 |
| `xiaoqiang.module.XQDisk` | 磁盘模块 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具 |
| `xiaoqiang.XQLog` | 日志记录 |
| `nixio.fs` | 文件系统操作 |
| `luci.http.protocol.mime` | MIME 类型 |
| `luci.ltn12` | 数据流处理 |
| `lcurl` | URL 编码 |
| `luci.fs` | 文件操作 |

## 被引用情况

- 由 LuCI dispatcher 在 `/api/xqdatacenter/*` 路径下自动加载
- 小米路由器 APP 的文件管理功能
- Web 管理界面的文件浏览器
- SSH 插件管理界面

## nginx 路径映射

| 源路径 | nginx 重定向 |
|--------|-------------|
| `/userdisk/data/` | `/download-userdisk/` |
| `/mnt/` | `/download-mnt/` |
| `/userdisk/privacyData/` | `/download-pridisk/` |
| `/userdisk/appdata/` | `/download-userdisk-appdata/` |
| `/userdisk/.thumbnails/` | `/download-userdisk-thumbnails/` |

## 安全措施

1. **路径白名单**: 只允许下载特定目录下的文件
2. **路径遍历检测**: 检测并阻止 `/../` 路径遍历攻击
3. **权限控制**: 上传 API 需要更高权限级别（16）

## 关键代码说明

### 断点续传实现

```lua
function download()
    local rangeHeader = http.getenv("HTTP_RANGE")
    local rangeStart = 0
    
    if rangeHeader then
        http.status(206)
        rangeStart = string.gsub(rangeHeader, "bytes=", "")
        rangeStart = string.gsub(rangeStart, "-", "")
    end
    
    local contentRange = "bytes " .. rangeStart .. "-" .. 
                         (fileStat.size - 1) .. "/" .. fileStat.size
    http.header("Content-Length", fileStat.size - rangeStart)
    http.header("Content-Range", contentRange)
end
```

### 文件名冲突处理

```lua
function upload()
    local finalFileName = uploadedFileName
    if luciFs.isfile(targetDir .. finalFileName) then
        local baseName = string.match(finalFileName, "(.+)%..+$")
        local extension = string.match(finalFileName, "%.([^.]+)$")
        
        for i = 1, 100 do
            local newName = baseName .. "(" .. i .. ")"
            if extension then
                newName = newName .. "." .. extension
            end
            
            if not luciFs.isfile(targetDir .. newName) then
                finalFileName = newName
                break
            end
        end
    end
end
```

### 隧道请求

```lua
function tunnelRequest()
    local payload = http.formvalue_unsafe("payload")
    local encodedPayload = XQCryptoUtil.binaryBase64Enc(payload)
    
    local cmd = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % encodedPayload
    local response = luciUtil.exec(cmd)
    
    http.write(response, nil, false, true)
end
```

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 6 | 参数错误 |
| 1537 | 参数缺失 |
| 1595 | SSH 插件开启失败 |
| 1600 | 获取 SSH 状态失败 |
| 1601 | SSH 插件关闭失败 |
