# common.lua - MiQoS 公共模块

## 工作原理

本模块提供 QoS 系统的核心公共函数，包括配置管理、TC 命令生成、系统清理和日志记录等功能。是所有 MiQoS 子模块的基础依赖。

### 全局配置结构 (cfg)

```lua
cfg = {
    server = { path = "/var/run/miqosd.sock" },
    bands = { UP = 0, DOWN = 0, changed = true },
    guest = { UP = 0.6, DOWN = 0.6 },
    xq = { UP = 0.9, DOWN = 0.9 },
    enabled = { started = true, changed = false, flag = false },
    qos_type = { changed = false, mode = "service" },
    wangzhe = { modeon = false, plugon = false, ... }
}
```

### 优先级配置 (seq_prio)

| 模式 | game | web | video | download |
|------|------|-----|-------|----------|
| auto | 2 | 3 | 4 | 5 |
| game | 2 | 3 | 4 | 5 |
| web | 3 | 2 | 4 | 5 |
| video | 3 | 4 | 2 | 5 |

## 接口

### 配置管理函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_cursor()` | - | UCI游标 | 获取 UCI 游标对象 |
| `get_conf_std(config, section, option, default)` | 配置参数 | 配置值 | 获取配置值（带默认值） |
| `get_tbls(config, section_type)` | 配置名, 节类型 | table | 获取配置表 |
| `read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `read_qos_group_config()` | - | table | 读取分组配置 |
| `read_qos_guest_xq_config(is_guest)` | is_guest: 是否访客 | table | 读取访客/XQ 配置 |
| `read_network_conf()` | - | boolean | 读取网络配置 |

### TC 命令相关函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_burst(rate)` | rate: 速率(kbps) | burst, cburst | 计算 HTB burst 值 |
| `get_supressed_ceil(ceil, supress_value)` | ceil, supress_value | number | 获取抑制后的 ceil 值 |
| `apply_leaf_qdisc(cmd_list, dev, parent, classid, rate, is_new)` | 参数列表 | - | 应用叶子队列规则 |
| `apply_ppp_qdisc(cmd_list, dev, parent, prio)` | 参数列表 | - | 应用 PPPoE 过滤规则 |
| `apply_arp_small_filter(cmd_list, dev, action, parent, classid)` | 参数列表 | - | 应用小包过滤规则 |
| `get_stab_string(dev)` | dev: 设备名 | string | 获取 STAB 参数字符串 |

### 工具函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `dec2hexstr(num)` | num: 十进制数 | string | 十进制转十六进制字符串 |
| `run_cmd(cmd)` | cmd: 命令 | string | 执行命令并返回输出 |
| `exec_cmd(cmd_list, ignore_error)` | cmd_list: 命令列表 | boolean | 执行命令列表 |
| `lock()` / `unlock()` | - | boolean | 文件锁操作 |
| `logger(level, message)` | level, message | - | 日志记录 |
| `cleanup_system()` | - | boolean | 清理 QoS 系统 |

### 常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `UNIT` | "kbit" | 带宽单位 |
| `UP` / `DOWN` | "UP" / "DOWN" | 方向常量 |
| `const_tc_qdisc` | "tc qdisc" | TC qdisc 命令 |
| `const_tc_class` | "tc class" | TC class 命令 |
| `const_tc_filter` | "tc filter" | TC filter 命令 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `nixio.fs` | 文件系统操作 |
| `ubus` | ubus 通信 |
| `luci.model.uci` | UCI 配置 |
| `luci.util` | LuCI 工具函数 |
| `posix` | POSIX 接口 |
| `nixio` | 底层 I/O |
