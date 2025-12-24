# box.lua.htm - 文件浏览器后端逻辑

## 文件作用
提供 FileBrowser 文件管理器的服务端控制逻辑，支持启动、停止、重启以及认证模式切换。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `uci set` | 设置 UCI 配置 |
| `rm` | 删除文件 |
| `box` | 扩展工具管理脚本 |

## 页面原理

### 支持的操作

#### 加密模式 (mac=filebrowser_lock)
1. 清空 `lyq.filebrowser` 配置
2. 删除数据库文件
3. 重启后需要密码登录

#### 免密模式 (mac=filebrowser_unlock)
1. 设置 `lyq.filebrowser='--noauth'`
2. 删除数据库文件
3. 重启后无需密码

#### 服务控制
| 操作 | 参数 | 说明 |
|------|------|------|
| 启动 | filebrowser_start | 启动 FileBrowser 服务 |
| 重启 | filebrowser_restart | 重启 FileBrowser 服务 |
| 停止 | filebrowser_stop | 停止 FileBrowser 服务 |

### 工具函数
- **base64_dec()**: Base64 解码
- **urlDecode()**: URL 解码

## 依赖关系
- UCI 配置 `lyq.filebrowser`
- UCI 配置 `lyq.xxx_path`
- `box` 管理脚本
- FileBrowser 可执行文件

## FileBrowser 说明
FileBrowser 是一个基于 Web 的文件管理器，默认运行在 18888 端口，默认用户名密码为 admin。
