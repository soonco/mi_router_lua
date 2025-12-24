# box.lua.htm - Samba设置后端逻辑

## 文件作用
提供 Samba 文件共享服务的配置功能，支持设置 root 用户密码和重启服务。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `smbpasswd` | Samba 密码管理工具 |
| `/etc/init.d/samba` | Samba 服务控制脚本 |

## 页面原理

### 支持的操作

#### 更新密码 (mac=samba_update)
```lua
luci.sys.exec("printf '"..pass.."\\n"..pass.."' | smbpasswd -a -s root")
```
1. 解码 Base64 和 URL 编码的密码
2. 使用 `smbpasswd` 设置 root 用户的 Samba 密码
3. `-a` 添加用户，`-s` 静默模式

#### 重启服务 (mac=samba_start)
```lua
luci.sys.exec("/etc/init.d/samba restart")
```
调用 init.d 脚本重启 Samba 服务。

### 工具函数
- **base64_dec()**: Base64 解码
- **urlDecode()**: URL 解码

## 依赖关系
- Samba 服务已安装
- `smbpasswd` 命令可用
- `/etc/init.d/samba` 脚本存在

## Samba 说明
Samba 是 SMB/CIFS 协议的开源实现，用于 Windows 和 Linux 之间的文件共享。
