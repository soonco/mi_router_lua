# luci/ip.lua

## 概述

LuCI IP 地址处理模块，提供 IPv4 和 IPv6 地址的解析、验证和操作功能。支持 CIDR 网络计算、地址比较、网络/广播地址计算等。

## 工作原理

1. **地址解析**: 将字符串形式的 IP 地址解析为内部数组表示
2. **位运算**: 使用 `bit` 库进行子网掩码和网络地址计算
3. **面向对象**: IPv4 和 IPv6 类提供统一的操作接口
4. **类型检测**: 自动检测地址类型（IPv4/IPv6）

## 接口/函数列表

### 常量

| 常量 | 值 | 描述 |
|------|-----|------|
| `FAMILY_INET4` | 4 | IPv4 地址族 |
| `FAMILY_INET6` | 6 | IPv6 地址族 |

### 便捷函数

| 函数 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `new(address, prefix)` | 地址字符串、前缀长度 | IPv4/IPv6/nil | 自动创建 IP 对象 |
| `IPv4(address, prefix)` | 地址、前缀 | IPv4 | 创建 IPv4 对象 |
| `IPv6(address, prefix)` | 地址、前缀 | IPv6 | 创建 IPv6 对象 |
| `checkip4(address)` | 地址字符串 | boolean | 验证 IPv4 地址 |
| `checkip6(address)` | 地址字符串 | boolean | 验证 IPv6 地址 |
| `checkcidr4(cidr)` | CIDR 字符串 | boolean | 验证 IPv4 CIDR |
| `checkcidr6(cidr)` | CIDR 字符串 | boolean | 验证 IPv6 CIDR |

### IPv4 类方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `string()` | 无 | string | 返回点分十进制字符串 |
| `cidr()` | 无 | string | 返回 CIDR 表示 |
| `network()` | 无 | IPv4 | 计算网络地址 |
| `broadcast()` | 无 | IPv4 | 计算广播地址 |
| `mask()` | 无 | IPv4 | 获取子网掩码 |
| `host()` | 无 | IPv4 | 获取主机地址（/32） |
| `contains(other)` | 另一个 IP | boolean | 检查是否包含 |
| `equal(other)` | 另一个 IP | boolean | 检查是否相等 |
| `lower(other)` | 另一个 IP | boolean | 检查是否小于 |
| `higher(other)` | 另一个 IP | boolean | 检查是否大于 |
| `is_private()` | 无 | boolean | 检查是否私有地址 |
| `is_loopback()` | 无 | boolean | 检查是否回环地址 |
| `is_multicast()` | 无 | boolean | 检查是否组播地址 |

### IPv6 类方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `string()` | 无 | string | 返回压缩格式字符串 |
| `full_string()` | 无 | string | 返回完整格式字符串 |
| `cidr()` | 无 | string | 返回 CIDR 表示 |
| `network()` | 无 | IPv6 | 计算网络地址 |
| `host()` | 无 | IPv6 | 获取主机地址（/128） |
| `contains(other)` | 另一个 IP | boolean | 检查是否包含 |
| `equal(other)` | 另一个 IP | boolean | 检查是否相等 |
| `is_loopback()` | 无 | boolean | 检查是否回环地址 |
| `is_link_local()` | 无 | boolean | 检查是否链路本地地址 |
| `is_multicast()` | 无 | boolean | 检查是否组播地址 |

## 对象属性

```lua
-- IPv4/IPv6 对象
{
    addr = table,     -- 地址数组 (IPv4: 4个字节, IPv6: 8个16位组)
    prefix = number,  -- 前缀长度 (IPv4: 0-32, IPv6: 0-128)
    family = number   -- 地址族 (4 或 6)
}
```

## 外部依赖

- `bit` - 位运算库
- `luci.util` - 工具函数（class）

## 被引用情况

- `luci/sys.lua` - 路由表解析
- `luci/cbi/datatypes.lua` - IP 地址验证
- 网络配置模块 - IP 地址处理

## 关键代码说明

### IPv4 地址解析
```lua
function IPv4:__init__(address, prefix)
    if type(address) == "string" then
        local parts = {}
        for part in address:gmatch("(%d+)") do
            local num = tonumber(part)
            if not num or num < 0 or num > 255 then
                error("Invalid IPv4 address")
            end
            parts[#parts + 1] = num
        end
        self.addr = parts
    end
    self.prefix = prefix or 32
    self.family = FAMILY_INET4
end
```

### IPv6 双冒号展开
```lua
-- 处理 :: 压缩格式
local double_colon_pos = address:find("::")
if double_colon_pos then
    -- 分割左右两部分
    -- 计算缺失的组数
    -- 填充零
end
```

### 网络地址计算
```lua
function IPv4:network()
    local mask = self:mask()
    local net_addr = {}
    for i = 1, 4 do
        net_addr[i] = bit.band(self.addr[i], mask.addr[i])
    end
    return IPv4(net_addr, self.prefix)
end
```

### 私有地址检测
```lua
function IPv4:is_private()
    -- 10.0.0.0/8
    if self.addr[1] == 10 then return true end
    -- 172.16.0.0/12
    if self.addr[1] == 172 and self.addr[2] >= 16 and self.addr[2] <= 31 then
        return true
    end
    -- 192.168.0.0/16
    if self.addr[1] == 192 and self.addr[2] == 168 then return true end
    return false
end
```

## 使用示例

```lua
local ip = require("luci.ip")

-- 创建 IPv4 地址
local addr = ip.IPv4("192.168.1.100", 24)
print(addr:string())      -- "192.168.1.100"
print(addr:network():string())  -- "192.168.1.0"
print(addr:broadcast():string()) -- "192.168.1.255"

-- 验证地址
print(ip.checkip4("192.168.1.1"))  -- true
print(ip.checkcidr4("10.0.0.0/8")) -- true

-- 自动检测类型
local v6 = ip.new("::1")
print(v6.family)  -- 6
```
