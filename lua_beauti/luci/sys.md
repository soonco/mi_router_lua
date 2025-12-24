# luci/sys.lua

## 概述

LuCI 系统信息模块，提供系统级别的信息获取和操作功能，包括系统信息、网络信息、进程管理、用户管理、WiFi 信息和初始化脚本管理。

## 工作原理

1. **系统信息**: 读取 `/proc` 文件系统获取 CPU、内存等信息
2. **网络信息**: 解析 `/proc/net/` 下的网络状态文件
3. **进程管理**: 通过 `nixio` 库和系统命令管理进程
4. **用户管理**: 通过 `nixio` 库操作用户密码
5. **初始化脚本**: 操作 `/etc/init.d/` 下的服务脚本

## 接口/函数列表

### 系统函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `call(...)` | 命令参数 | number | 执行命令返回退出码 |
| `exec(command)` | 命令 | string | 执行命令返回输出 |
| `hostname(newHostname)` | 新主机名(可选) | string | 获取/设置主机名 |
| `loadavg()` | 无 | n1, n2, n3 | 获取系统负载 |
| `uptime()` | 无 | number | 获取运行时间(秒) |
| `sysinfo()` | 无 | cpu, board, memTotal, memCached, memBuffers, memFree, bogomips | 获取系统信息 |
| `syslog()` | 无 | string | 获取系统日志 |
| `dmesg()` | 无 | string | 获取内核日志 |
| `mounts()` | 无 | table | 获取挂载点列表 |
| `reboot()` | 无 | number | 重启系统 |
| `uniqueid(bytes)` | 字节数 | string | 生成唯一 ID |
| `httpget(url, stream, target)` | URL、流式、目标文件 | string/number | HTTP GET 请求 |
| `getenv` | 环境变量名 | string | 获取环境变量 |

### 网络函数 (net.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `net.arptable(callback)` | 回调函数 | table | 获取 ARP 表 |
| `net.host_hints(callback)` | 回调函数 | void | 获取主机提示信息 |
| `net.mac_hints(callback)` | 回调函数 | table | 获取 MAC 地址提示 |
| `net.ipv4_hints(callback)` | 回调函数 | table | 获取 IPv4 提示 |
| `net.ipv6_hints(callback)` | 回调函数 | table | 获取 IPv6 提示 |
| `net.conntrack(callback)` | 回调函数 | table | 获取连接跟踪表 |
| `net.routes(callback)` | 回调函数 | table | 获取 IPv4 路由表 |
| `net.routes6(callback)` | 回调函数 | table | 获取 IPv6 路由表 |
| `net.defaultroute()` | 无 | table | 获取默认 IPv4 路由 |
| `net.defaultroute6()` | 无 | table | 获取默认 IPv6 路由 |
| `net.devices()` | 无 | table | 获取网络设备列表 |
| `net.deviceinfo()` | 无 | table | 获取设备统计信息 |
| `net.ip4mac(ip)` | IP 地址 | string | IP 转 MAC 地址 |
| `net.ip4mac_ex(ip)` | IP 地址 | string | IP 转 MAC（扩展） |
| `net.pingtest(host)` | 主机 | number | Ping 测试 |

### 进程函数 (process.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `process.info(key)` | 键名(可选) | table/any | 获取进程信息 |
| `process.list()` | 无 | table | 获取进程列表 |
| `process.setgroup(gid)` | 组 ID | boolean | 设置进程组 |
| `process.setuser(uid)` | 用户 ID | boolean | 设置进程用户 |
| `process.signal` | pid, signal | boolean | 发送信号 |

### 用户函数 (user.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `user.getuser` | 用户名 | table | 获取用户信息 |
| `user.getpasswd(username)` | 用户名 | string, table | 获取密码哈希 |
| `user.checkpasswd(username, password)` | 用户名、密码 | boolean | 验证密码 |
| `user.setpasswd(username, password)` | 用户名、密码 | number | 设置密码 |

### WiFi 函数 (wifi.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `wifi.getiwinfo(ifname)` | 接口名 | table | 获取无线接口信息 |

### 初始化脚本 (init.*)

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `init.names()` | 无 | table | 获取所有初始化脚本名 |
| `init.index(name)` | 脚本名 | number | 获取脚本启动顺序 |
| `init.enabled(name)` | 脚本名 | boolean | 检查是否启用 |
| `init.enable(name)` | 脚本名 | boolean | 启用脚本 |
| `init.disable(name)` | 脚本名 | boolean | 禁用脚本 |
| `init.start(name)` | 脚本名 | boolean | 启动服务 |
| `init.stop(name)` | 脚本名 | boolean | 停止服务 |

## 外部依赖

- `io` - 文件 I/O
- `os` - 操作系统接口
- `table` - 表操作
- `nixio` - 底层系统调用
- `nixio.fs` - 文件系统操作
- `luci.model.uci` - UCI 配置
- `luci.util` - 工具函数
- `luci.ip` - IP 地址处理
- `iwinfo` - 无线信息（可选）
- `ubus` - ubus 通信（用于 ip4mac_ex）

## 被引用情况

- `luci/dispatcher.lua` - 用户认证、会话管理
- `luci/sauth.lua` - 会话时间
- `luci/tools/status.lua` - 系统状态
- 各种控制器 - 系统信息获取

## 关键代码说明

### 系统信息获取
```lua
function sysinfo()
    local cpuinfo = nixioFs.readfile("/proc/cpuinfo")
    local meminfo = nixioFs.readfile("/proc/meminfo")
    -- 解析 CPU 型号、内存信息等
end
```

### ARP 表解析
```lua
function net.arptable(callback)
    for line in luci.util.execi("cat /proc/net/arp") do
        -- 解析: IP address, HW type, Flags, HW address, Mask, Device
    end
end
```

### 路由表解析
```lua
function net.routes(callback)
    for line in luci.util.execi("cat /proc/net/route") do
        -- 解析十六进制地址，转换为 IP 对象
        local destAddr = luci.ip.Hex(dst, 32, luci.ip.FAMILY_INET4)
    end
end
```

### 用户名映射
```lua
-- admin 用户映射到 root
if username:lower() == "admin" then
    username = "root"
end
```

### 连接跟踪
```lua
function net.conntrack(callback)
    -- 优先读取 nf_conntrack，兼容 ip_conntrack
    local conntrackFile = luci.util.execi("cat /proc/net/nf_conntrack 2>/dev/null")
    if not conntrackFile then
        conntrackFile = luci.util.execi("cat /proc/net/ip_conntrack 2>/dev/null")
    end
end
```
