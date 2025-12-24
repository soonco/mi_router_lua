# box.lua.htm - ZeroTier后端逻辑

## 文件作用
提供 ZeroTier 虚拟网络服务的服务端控制逻辑，支持启动、停止、加入和离开网络。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `zerotier-cli join` | 加入 ZeroTier 网络 |
| `zerotier-cli leave` | 离开 ZeroTier 网络 |
| `xxxbox zerotier stop` | 停止 ZeroTier 服务 |
| `xxxbox zerotier restart` | 重启 ZeroTier 服务 |

## 页面原理

### 支持的操作

#### 停止服务 (mac=stop_zerotier)
执行 `xxxbox zerotier stop` 停止服务。

#### 重启服务 (mac=restart_zerotier)
执行 `xxxbox zerotier restart` 重启服务。

#### 加入网络 (mac=join_zerotier)
1. 解码网络 ID
2. 执行 `zerotier-cli join {network_id}`
3. 检查返回结果判断是否成功

#### 离开网络 (mac=leave_zerotier)
1. 解码网络 ID
2. 执行 `zerotier-cli leave {network_id}`
3. 检查返回结果判断是否成功

### 工具函数
- **base64_dec()**: Base64 解码
- **urlDecode()**: URL 解码

## 依赖关系
- UCI 配置 `lyq.xxx_path`
- `xxxbox` 管理脚本
- `zerotier-cli` 命令行工具

## ZeroTier 说明
ZeroTier 是一个软件定义网络（SDN）平台，可以创建安全的虚拟网络，实现跨互联网的设备互联。
