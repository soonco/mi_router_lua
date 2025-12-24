# XQUPnPUtil.lua - UPnP工具模块

## 概述

`XQUPnPUtil.lua` 是小米路由器的UPnP（通用即插即用）工具模块，提供UPnP服务的状态管理和端口映射列表获取功能。UPnP允许网络设备自动发现彼此并建立功能性网络服务，常用于游戏、P2P应用等需要端口映射的场景。

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    XQUPnPUtil 模块                           │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │getUPnPStatus│    │ switchUPnP  │    │ getUPnPList │      │
│  │  状态查询    │    │  开关控制    │    │  列表获取    │      │
│  └──────┬──────┘    └──────┬──────┘    └──────┬──────┘      │
│         │                  │                  │              │
│         ▼                  ▼                  ▼              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              miniupnpd 服务                          │    │
│  │         /etc/config/upnpd 配置文件                   │    │
│  └─────────────────────────────────────────────────────┘    │
│                          │                                   │
│                          ▼                                   │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              UPnP 租约文件                           │    │
│  │    协议:远程端口:内网IP:内网端口:过期时间:应用名称      │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                               │
└─────────────────────────────────────────────────────────────┘

端口映射数据流:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 外网请求  │───▶│ 路由器    │───▶│ UPnP映射  │───▶│ 内网设备  │
│ :远程端口 │    │ WAN口    │    │ 规则匹配   │    │ :内网端口 │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
```

## 接口列表

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getUPnPStatus()` | 无 | `boolean` | 获取UPnP服务状态，true表示已启用 |
| `switchUPnP(enable)` | `enable: boolean` | `number` | 开启或关闭UPnP服务，返回命令执行结果 |
| `getUPnPList()` | 无 | `table\|nil` | 获取UPnP端口映射列表 |

### 返回值详细说明

#### getUPnPList 返回结构
```lua
{
    {
        protocol = "TCP",      -- 协议类型 (TCP/UDP)
        rport = "8080",        -- 远程端口（外网端口）
        ip = "192.168.31.100", -- 内网IP地址
        cport = "80",          -- 内网端口
        time = "3600",         -- 租约过期时间（秒）
        name = "Web Server"    -- 应用名称，"(null)"显示为"未知程序"
    },
    ...
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用工具函数（字符串检查等） |
| `xiaoqiang.common.XQConfigs` | 配置常量（UPnP相关命令路径） |
| `xssFilter` | XSS过滤器，防止租约文件中的恶意内容 |
| `luci.util` | LuCI工具函数（字符串处理） |

### XQConfigs 中使用的常量
- `UPNP_STATUS` - UPnP状态检查命令
- `UPNP_ENABLE` - UPnP启用命令
- `UPNP_DISABLE` - UPnP禁用命令
- `UPNP_LEASE_FILE` - UPnP租约文件路径获取命令

## 被引用情况

该模块被以下模块引用：
- `luci/controller/api/xqnetwork.lua` - 网络API控制器
- `luci/controller/api/misystem.lua` - 系统API接口

## 关键代码说明

### UPnP状态检查
```lua
function getUPnPStatus()
    local result = os.execute(XQConfigs.UPNP_STATUS)
    if result == 0 then
        return true  -- UPnP已启用
    else
        return false -- UPnP已禁用
    end
end
```

### UPnP开关控制
```lua
function switchUPnP(enable)
    if enable then
        -- 修改配置文件并启用服务
        os.execute("[ -f /etc/config/upnpd ] && sed -i 's/disable_upnp/enable_upnp/g' /etc/config/upnpd")
        return os.execute(XQConfigs.UPNP_ENABLE)
    else
        -- 修改配置文件并禁用服务
        os.execute("[ -f /etc/config/upnpd ] && sed -i 's/enable_upnp/disable_upnp/g' /etc/config/upnpd")
        return os.execute(XQConfigs.UPNP_DISABLE)
    end
end
```

### 租约文件解析
租约文件格式：`协议:远程端口:内网IP:内网端口:过期时间:应用名称`

```lua
-- 解析租约文件每行
local parts = luci_util.split(filtered_line, ":", 5)
if #parts == 6 then
    entry.protocol = parts[1]  -- TCP/UDP
    entry.rport = parts[2]     -- 远程端口
    entry.ip = parts[3]        -- 内网IP
    entry.cport = parts[4]     -- 内网端口
    entry.time = parts[5]      -- 过期时间
    entry.name = parts[6]      -- 应用名称
end
```

## 使用示例

```lua
local XQUPnPUtil = require("xiaoqiang.util.XQUPnPUtil")

-- 检查UPnP状态
if XQUPnPUtil.getUPnPStatus() then
    print("UPnP已启用")
    
    -- 获取端口映射列表
    local list = XQUPnPUtil.getUPnPList()
    if list then
        for _, entry in ipairs(list) do
            print(string.format("%s %s:%s -> %s:%s (%s)",
                entry.protocol, "WAN", entry.rport,
                entry.ip, entry.cport, entry.name))
        end
    end
else
    -- 启用UPnP
    XQUPnPUtil.switchUPnP(true)
end
```
