# datatypes.lua - CBI 数据类型验证模块

## 工作原理

LuCI CBI 数据类型验证模块，提供各种数据类型的验证函数，用于 CBI 表单输入值的合法性检查。

验证类别：
1. **逻辑验证** - or、and、neg、list
2. **布尔验证** - bool
3. **数值验证** - integer、uinteger、float、ufloat、range、min、max
4. **网络验证** - ipaddr、ip4addr、ip6addr、port、portrange、macaddr
5. **主机验证** - hostname、host、network
6. **安全验证** - wpakey、wepkey
7. **文件验证** - file、directory、device
8. **字符串验证** - string、uciname、minlength、maxlength、rangelength、phonedigit

## 接口

### 逻辑验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `datatypes["or"](value, ...)` | value + 验证器列表 | boolean | 任一条件满足返回 true |
| `datatypes["and"](value, ...)` | value + 验证器列表 | boolean | 所有条件满足返回 true |
| `neg(value, ...)` | value + 验证器列表 | boolean | 去除 `!` 前缀后验证 |
| `list(value, validator, ...)` | value + 验证函数 | boolean | 验证空格分隔的列表 |

### 布尔验证

| 函数 | 有效值 | 说明 |
|------|--------|------|
| `bool(value)` | "1", "yes", "on", "true", "0", "no", "off", "false", "", nil | 布尔值验证 |

### 数值验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `integer(value)` | value | boolean | 整数验证 |
| `uinteger(value)` | value | boolean | 无符号整数验证（≥0） |
| `float(value)` | value | boolean | 浮点数验证 |
| `ufloat(value)` | value | boolean | 无符号浮点数验证（≥0） |
| `range(value, min, max)` | value, min, max | boolean | 数值范围验证 |
| `min(value, min_val)` | value, min_val | boolean | 最小值验证 |
| `max(value, max_val)` | value, max_val | boolean | 最大值验证 |

### 网络验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `ipaddr(value)` | value | boolean | IPv4 或 IPv6 地址 |
| `ip4addr(value)` | value | boolean | IPv4 地址 |
| `ip6addr(value)` | value | boolean | IPv6 地址 |
| `ip4prefix(value)` | value | boolean | IPv4 前缀长度（0-32） |
| `ip6prefix(value)` | value | boolean | IPv6 前缀长度（0-128） |
| `port(value)` | value | boolean | 端口号（0-65535） |
| `portrange(value)` | value | boolean | 端口或端口范围（如 "80" 或 "1024-65535"） |
| `macaddr(value)` | value | boolean | MAC 地址（XX:XX:XX:XX:XX:XX） |

### 主机验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `hostname(value)` | value | boolean | 主机名（≤253字符） |
| `host(value)` | value | boolean | 主机名或 IP 地址 |
| `network(value)` | value | boolean | UCI 名称或主机 |

### 安全验证函数

| 函数 | 有效格式 | 说明 |
|------|----------|------|
| `wpakey(value)` | 64位十六进制 或 8-63个字符 | WPA/WPA2 密钥 |
| `wepkey(value)` | 10/26位十六进制 或 5/13个字符 | WEP 密钥 |

### 文件验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `file(path, visited)` | path, visited | boolean | 普通文件验证 |
| `directory(path, visited)` | path, visited | boolean | 目录验证 |
| `device(path, visited)` | path, visited | boolean | 设备文件验证 |

### 字符串验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `string(value)` | value | true | 任意字符串（始终有效） |
| `uciname(value)` | value | boolean | UCI 名称（字母数字下划线） |
| `minlength(value, min_len)` | value, min_len | boolean | 最小长度验证 |
| `maxlength(value, max_len)` | value, max_len | boolean | 最大长度验证 |
| `rangelength(value, min, max)` | value, min, max | boolean | 长度范围验证 |
| `phonedigit(value)` | value | boolean | 电话号码数字（0-9*#） |

### 使用示例

```lua
local dt = require("luci.cbi.datatypes")

-- 验证 IP 地址
if dt.ip4addr("192.168.1.1") then
    print("Valid IPv4")
end

-- 验证端口范围
if dt.portrange("1024-65535") then
    print("Valid port range")
end

-- 验证 WPA 密钥
if dt.wpakey("mypassword123") then
    print("Valid WPA key")
end

-- 组合验证
if dt["or"]("192.168.1.1", dt.ip4addr, {}, dt.hostname, {}) then
    print("Valid host or IP")
end
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `nixio.fs` | 文件系统操作 |
| `luci.ip` | IP 地址处理 |
| `luci.util` | 工具函数 |
| `math` | 数学函数 |
