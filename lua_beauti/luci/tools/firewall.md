# firewall.lua - 防火墙工具模块

## 工作原理

LuCI 防火墙工具模块，提供防火墙规则的格式化显示和 CBI 表单选项辅助函数，用于在 Web 界面中美化显示防火墙规则的各种参数。

核心功能：
1. **格式化函数** - 将防火墙参数格式化为 HTML 显示格式
2. **否定处理** - 处理以 `!` 开头的否定规则
3. **CBI 辅助** - 提供启用/禁用和名称选项的 CBI 表单集成

## 接口

### 格式化函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `fmt_neg(value)` | value: 原始值 | value, prefix | 处理否定前缀 |
| `fmt_mac(mac_list)` | mac_list: MAC 地址数组 | HTML 字符串 | 格式化 MAC 地址列表 |
| `fmt_port(port_list, default)` | port_list: 端口数组<br>default: 默认值 | HTML 字符串 | 格式化端口列表 |
| `fmt_ip(ip_list, default)` | ip_list: IP 地址数组<br>default: 默认值 | HTML 字符串 | 格式化 IP 地址列表 |
| `fmt_zone(zone, default)` | zone: 区域名<br>default: 默认值 | HTML 字符串 | 格式化防火墙区域 |
| `fmt_icmp_type(icmp_list)` | icmp_list: ICMP 类型数组 | HTML 字符串 | 格式化 ICMP 类型 |
| `fmt_proto(proto_list, icmp_types)` | proto_list: 协议数组<br>icmp_types: ICMP 类型 | HTML 字符串 | 格式化协议列表 |
| `fmt_limit(limit, burst)` | limit: 速率限制<br>burst: 突发值 | 可读字符串 | 格式化速率限制 |
| `fmt_target(action, dest_list)` | action: 动作<br>dest_list: 目标列表 | 可读字符串 | 格式化动作目标 |

### fmt_neg 返回值

| 返回值 | 说明 |
|--------|------|
| value | 去除 `!` 前缀后的值 |
| prefix | 否定前缀（如 "not "）或空字符串 |

### fmt_target 动作映射

| 动作 | 有目标 | 无目标 |
|------|--------|--------|
| ACCEPT | Accept forward | Accept input |
| REJECT | Refuse forward | Refuse input |
| NOTRACK | Do not track forward | Do not track input |
| 其他 | Discard forward | Discard input |

### CBI 辅助函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `opt_enabled(map, widget_type, ...)` | map: CBI Map<br>widget_type: 控件类型 | CBI 选项 | 添加启用/禁用选项 |
| `opt_name(map, widget_type, ...)` | map: CBI Map<br>widget_type: 控件类型 | CBI 选项 | 添加名称选项 |

### opt_enabled 行为

| widget_type | 行为 |
|-------------|------|
| `luci.cbi.Button` | 切换按钮，显示当前状态和切换操作 |
| 其他 | Flag 复选框，enabled="" / disabled="0" |

### opt_name 特性

- 优先读取 `name` 字段
- 回退读取 `_name` 字段
- 写入时设置 `name` 并删除 `_name`
- 值为 "-" 时删除两个字段

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.util` | 工具函数 |
| `luci.ip` | IP 地址处理 |
| `nixio` | 协议信息查询（getproto） |
| `luci.i18n` | 国际化翻译 |
