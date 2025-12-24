# datacenter.lua - 数据中心服务控制器

## 工作原理

提供数据中心相关的 API 接口，包括文件下载/上传、插件管理、存储管理等功能。通过 Thrift 隧道与数据中心服务通信，请求数据经 JSON 编码后进行 Base64 编码传输。

### 通信流程

1. 构建请求数据（包含 api 编号和参数）
2. JSON 编码请求数据
3. Base64 编码
4. 通过 Thrift 隧道发送命令
5. 返回执行结果

## 接口

### 路由注册

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `index()` | 无 | 无 | 注册所有 API 路由 |

### 文件操作

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `downloadFile()` | 1101 | appId, path, url, downloadName, tag, hidden, redownload, dupId, pathForUserData | 下载文件 |
| `uploadFile()` | - | appId, saveType, file | 上传文件 |
| `getDownloadInfo()` | 1102 | appId, deviceId, downloadId, hidden | 获取下载信息 |
| `getBatchDownloadInfo()` | 1105 | appId, ids, hidden | 批量获取下载信息 |
| `deleteDownload()` | 1110 | appId, idList, deletefile | 删除下载任务 |
| `MultiCreate()` | 520 | urls, pathForUserData | 批量创建下载任务 |
| `getFileList()` | 3 | path | 获取文件列表 |

### 存储和媒体

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `getStorageInfo()` | 17 | 无 | 获取存储信息 |
| `mediaDelta()` | 1201 | cursor, len | 媒体增量同步 |
| `mediaMetadata()` | 1202 | path, thumb_size | 获取媒体元数据 |
| `isHasDisk()` | 122 | 无 | 检查是否有磁盘 |

### 设备信息

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `getDeviceID()` | 1103 | appId | 获取设备 ID |
| `getMac()` | 617 | appId | 获取路由器 MAC 地址 |
| `getRouterInfo()` | 622 | appId | 获取路由器信息 |
| `getRouterIP()` | 1112 | appId | 获取路由器 IP |
| `connectedDevice()` | 616 | appId | 获取已连接设备 |
| `idforvendor()` | 629 | appId | 获取厂商 ID |

### 插件管理

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `enablePlugin()` | 1108 (status=5) | appId | 启用插件 |
| `disablePlugin()` | 1108 (status=6) | appId | 禁用插件 |
| `pluginStatus()` | 1111 | appId | 获取插件状态 |
| `pluginDownloadInfo()` | 1109 | appId, hidden, lite | 获取插件下载信息 |
| `controlPlugin()` | 600 | appId, info | 控制插件 |
| `controlFeaturePlugin()` | 634 | appId, info | 控制功能插件 |

### 配置管理

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `getConfigInfo()` | 1106 | appId, key | 获取配置信息 |
| `setConfigInfo()` | 1107 | appId, key, value | 设置配置信息 |

### 其他功能

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `tunnelRequest()` | - | payload | 通用隧道请求 |
| `setWanAccess()` | 618 | appId, mac, enable | 设置 WAN 口访问权限 |
| `RunCommand()` | 625 | appId, command | 执行命令 |
| `xunleiNotify()` | 519 | tasks | 迅雷通知 |
| `shareMiuiBackupDir()` | 100 | mac | 共享 MIUI 备份目录 |
| `getCameraSmbPath()` | 115 | mac | 获取摄像头 SMB 路径 |
| `setSyncRouterFile()` | 118 | sources, remote_router_id | 设置同步路由器文件 |

### 优酷集成

| 函数 | API 编号 | 参数 | 说明 |
|------|----------|------|------|
| `getYoukuStatus()` | 634 (内部 api=4) | appid | 获取优酷状态 |
| `bindYoukuAppid()` | 634 (内部 api=5) | appid, ip, token | 绑定优酷 AppID |

### 内部函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `tunnelRequestDatacenter(requestData)` | 请求数据表 | 无 | 发送请求并写入 HTTP 响应 |
| `requestDatacenter(requestData)` | 请求数据表 | string | 发送请求并返回结果 |
| `getOperateDeviceID()` | 无 | code, deviceId | 获取并验证设备 ID |
| `urlEncode(str)` | 字符串 | 编码后字符串 | URL 编码 |
| `generateUrlFromPath(path)` | 文件路径 | HTTP URL | 从路径生成下载 URL |
| `generateResponseFromCode(code)` | 错误码 | 响应表 | 根据错误码生成响应 |

### 权限级别

| 级别 | 说明 |
|------|------|
| 17 | 需要认证 |
| 1 | 公开访问 |
| 8 | 特殊权限 |

### 特殊处理

- Samba 插件 (AppID: 2882303761517280984) 的启用/禁用/状态直接操作本地配置
- 优酷插件 (pluginID: 2882303761517440411) 通过 controlFeaturePlugin 接口操作

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.util` | 工具函数 |
| `luci.fs` | 文件系统操作 |
| `xiaoqiang.common.XQConfigs` | 配置常量（Thrift 隧道命令） |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具（Base64 编码） |
| `xiaoqiang.module.XQStorage` | 存储模块（Samba 状态） |
| `xiaoqiang.XQLog` | 日志模块 |
| `service.util.ServiceErrorUtil` | 服务错误处理 |
| `cjson` | JSON 编解码 |
