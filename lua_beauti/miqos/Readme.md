# MiQoS - 小米路由器 QoS 流量控制系统

## 概述

MiQoS 是小米路由器的智能 QoS（服务质量）流量控制系统，基于 Linux TC (Traffic Control) 实现。该系统支持多种流量控制策略，包括基于服务类型、主机、优先级的流量管理，以及针对特定应用（如王者荣耀）的专项优化。

## 目录结构

| 文件 | 说明 |
|------|------|
| `common.lua` | 公共模块，提供核心函数和配置管理 |
| `command.lua` | 命令处理模块，统一的命令入口 |
| `rule_by_service.lua` | 基于服务类型的 QoS 规则模块 |
| `rule_by_host.lua` | 基于主机的 QoS 规则模块 |
| `rule_by_prio.lua` | 基于优先级的 QoS 规则模块 |
| `rule_by_noifb.lua` | 无 IFB 设备的 QoS 规则模块 |
| `rule_by_wangzhe.lua` | 王者荣耀游戏加速模块 |

## 模块详解

### 1. common.lua - 公共模块

提供 QoS 系统的核心公共函数，是所有子模块的基础依赖。

**主要功能：**
- 配置管理（UCI 配置读取/写入）
- TC 命令生成（HTB、qdisc、filter）
- 系统清理和日志记录
- 文件锁操作

**全局配置结构：**
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

**优先级配置表：**

| 模式 | game | web | video | download |
|------|------|-----|-------|----------|
| auto | 2 | 3 | 4 | 5 |
| game | 2 | 3 | 4 | 5 |
| web | 3 | 2 | 4 | 5 |
| video | 3 | 4 | 2 | 5 |

### 2. command.lua - 命令处理模块

处理 QoS 系统的各种控制命令，通过 `process_cmd()` 函数作为统一入口。

**命令分类：**

| 类别 | 命令 | 说明 |
|------|------|------|
| 基础控制 | on, off, shutdown | QoS 开关控制 |
| 带宽设置 | change_band, show_band | 带宽配置 |
| 限速管理 | on_limit, set_limit, off_limit | 设备限速 |
| 访客/XQ | on_guest, on_xq, show_guest, show_xq | 访客和小米设备限速 |
| 游戏模式 | game_mode_on/off, game_dev_add/del | 游戏加速 |
| 王者荣耀 | wangzhe_plug_on/off, show_wangzhe | 王者荣耀加速 |
| 配置查询 | show_limit, show_cfg, get_seq | 查询配置 |

**返回值格式：**
```lua
{
    status = 0,  -- 0: 成功, 1: 失败
    data = "ok"  -- 结果数据或错误信息
}
```

### 3. rule_by_service.lua - 基于服务的 QoS 规则模块

实现基于服务类型（游戏/网页/视频/下载）的流量控制，使用 HTB 队列算法。

**HTB 类层级结构：**
```
root (0x1000) - 根类，总带宽
├── special (0x2000) - 特殊流量类 (ARP/SYN/FIN/RST/ICMP)
├── host (0x3000) - 主网络主机类
│   ├── game (0x00130000) - 游戏流量
│   ├── web (0x00230000) - 网页流量
│   ├── video (0x00330000) - 视频流量
│   └── download (0x00430000) - 下载流量
├── guest (0x4000) - 访客网络类
└── xq (0x5000) - 小米设备类
```

**服务类型配置：**

| 服务类型 | 保证速率 | 上限速率 | 优先级 |
|----------|----------|----------|--------|
| game | 10% | 60% | 高 |
| web | 35% | 100% | 中高 |
| video | 45% | 100% | 中 |
| download | 10% | 95% | 低(默认) |

### 4. rule_by_host.lua - 基于主机的 QoS 规则模块

实现基于主机（MAC/IP）的流量控制，为每个在线主机创建独立的 HTB 类。

**HTB 类层级结构：**
```
root (0x1000) - 根类
├── special (0x2000) - 特殊主机类（高优先级）
├── host (0x3000) - 普通主机类
│   ├── host_1 - 主机1
│   │   ├── game (子类)
│   │   ├── web (子类)
│   │   ├── video (子类)
│   │   └── download (子类)
│   └── host_N - 主机N
├── guest (0x4000) - 访客网络类
└── xq (0x5000) - 小米设备类
```

**变化级别：**

| 级别 | 说明 | 处理方式 |
|------|------|----------|
| "0" | 无变化 | 不处理 |
| "1" | 带宽变化 | 仅更新速率 |
| "2" | 配置变化 | 重新生成所有规则 |

### 5. rule_by_prio.lua - 优先级规则模块

实现基于流量优先级的简单 QoS 方案，使用 prio qdisc 实现优先级队列。

**与 HTB 模式的区别：**
- prio 模式：简单的优先级队列，高优先级流量优先发送
- HTB 模式：分层令牌桶，可精确控制带宽分配

**优先级队列：**

| 队列 | 类型 | 优先级 | 说明 |
|------|------|--------|------|
| 1 | high | 1 | 高优先级流量 |
| 2 | game | 2 | 游戏流量 |
| 3 | web | 3 | 网页流量 |
| 4 | video | 4 | 视频流量 |
| 5 | other | 5 | 其他流量 |
| 6 | guest | 6 | 访客网络 |
| 7 | xq | 7 | 小米设备 |

**fwmark 规则：**

| 类型 | fwmark | 过滤器优先级 |
|------|--------|--------------|
| high | 0x00010000/0x000f0000 | 4 |
| game | 0x00020000/0x000f0000, 0x00130000/0x00ff0000 | 4, 5 |
| web | 0x00230000/0x00ff0000 | 5 |
| video | 0x00330000/0x00ff0000 | 5 |
| other | 0x00430000/0x00ff0000 | 5 |
| guest | 0x00040000/0x000f0000 | 4 |
| xq | 0x00050000/0x000f0000 | 4 |

### 6. rule_by_noifb.lua - 无 IFB 设备规则模块

实现不使用 IFB (Intermediate Functional Block) 设备的 QoS 方案。

**与标准模式的区别：**
- 标准模式：使用 IFB 设备重定向入站流量进行整形
- NoIFB 模式：直接在 br-lan 等接口上进行流量控制

**适用场景：**
- 不支持 IFB 的设备
- 需要简化配置的场景

### 7. rule_by_wangzhe.lua - 王者荣耀游戏加速模块

专门针对王者荣耀（Honor of Kings）游戏进行 QoS 优化。

**工作流程：**
1. 通过 `is_wangzhe_dev()` 检测王者荣耀游戏设备
2. 为检测到的设备分配专用带宽
3. 使用与 service 模块相同的 HTB 类层级结构
4. 动态跟踪设备上下线状态

**配置项：**

| 配置 | 说明 |
|------|------|
| `cfg.wangzhe.bands` | 游戏模式总带宽 |
| `cfg.wangzhe.devbands` | 单个游戏设备带宽 |
| `cfg.wangzhe.iplist` | 游戏设备 IP 列表 |
| `cfg.wangzhe.modeon` | 游戏模式开关 |
| `cfg.wangzhe.plugon` | 加速插件开关 |

## 统一接口规范

所有规则模块（rule_by_*.lua）都注册到 `qdisc` 表中，并提供统一的接口：

| 函数 | 说明 |
|------|------|
| `qdisc.<type>.clean(dev_list)` | 清理 QoS 规则 |
| `qdisc.<type>.changed()` | 检查配置是否变化 |
| `qdisc.<type>.read_qos_config()` | 读取 QoS 配置 |
| `qdisc.<type>.apply(...)` | 应用 QoS 规则 |
| `qdisc.<type>.update_counters(dev_list)` | 更新计数器信息（部分模块） |

## 外部依赖

| 模块 | 用途 |
|------|------|
| `nixio.fs` | 文件系统操作 |
| `ubus` | ubus 通信 |
| `luci.model.uci` | UCI 配置 |
| `luci.util` | LuCI 工具函数 |
| `luci.ip` | IP 地址处理 |
| `posix` | POSIX 接口 |
| `nixio` | 底层 I/O |
| `json` | JSON 编解码 |

## 技术特点

1. **分层设计**：公共模块提供基础功能，规则模块实现具体策略
2. **多策略支持**：支持 service、host、prio、noifb、wangzhe 等多种 QoS 策略
3. **动态调整**：支持在线主机检测和动态规则调整
4. **增量更新**：通过变化级别检测，支持增量更新以提高效率
5. **游戏优化**：针对游戏场景提供专项优化
