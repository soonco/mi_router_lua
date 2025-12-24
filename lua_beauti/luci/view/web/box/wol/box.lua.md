# box.lua.htm - 网络唤醒后端逻辑

## 文件作用
提供 Wake-on-LAN (WOL) 网络唤醒功能的服务端处理逻辑，支持配置保存和服务重启。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `uci get` | 读取 UCI 配置 |
| `xxxbox wol restart` | 重启 WOL 服务 |

## 页面原理

### 支持的操作

#### 保存配置 (mac=save_wol)
1. 获取配置文本参数
2. 解码 Base64 和 URL 编码
3. 写入配置文件 `config.yaml`

#### 重启服务 (mac=restart_wol)
执行 `xxxbox wol restart` 重启 WOL 服务。

### 配置文件路径
```
$(uci get lyq.xxx_path)/xxxbox/wol/config.yaml
```

### 工具函数
- **base64_dec()**: Base64 解码
- **urlDecode()**: URL 解码

## 依赖关系
- UCI 配置 `lyq.xxx_path`
- `xxxbox` 管理脚本
- WOL 服务程序

## WOL 说明
Wake-on-LAN 是一种网络唤醒技术，可以通过发送特殊的网络数据包远程唤醒处于休眠状态的计算机。
