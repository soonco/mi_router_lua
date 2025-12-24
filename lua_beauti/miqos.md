# miqos.lua - 小米路由器 QoS 主模块

## 工作原理

本模块是小米路由器 MiQoS（Quality of Service）系统的主入口模块。由于原始文件为编译后的 Lua 字节码，具体实现细节无法直接解析。

根据相关子模块（miqos/common.lua 等）分析，MiQoS 系统的主要功能包括：

- **流量控制**: 使用 Linux TC（Traffic Control）实现带宽管理
- **QoS 策略**: 支持多种 QoS 模式（auto/min/max/both/service）
- **设备限速**: 支持按设备、按分组进行带宽限制
- **优先级管理**: 游戏、视频、网页、下载等流量优先级
- **访客网络**: 独立的访客网络带宽控制

## 接口

由于文件为字节码，以下接口基于相关模块推测：

### 可能的主要函数

| 函数 | 说明 |
|------|------|
| `init()` | 初始化 QoS 系统 |
| `start()` | 启动 QoS 服务 |
| `stop()` | 停止 QoS 服务 |
| `reload()` | 重新加载配置 |
| `set_bandwidth(up, down)` | 设置上下行带宽 |

### 配置项

| 配置 | 说明 |
|------|------|
| `enabled` | QoS 启用状态 |
| `upload` | 上行带宽 (kbps) |
| `download` | 下行带宽 (kbps) |
| `qos_auto` | QoS 模式 |

## 外部引用

根据 miqos 子模块分析，可能的依赖：

| 模块 | 说明 |
|------|------|
| `miqos.common` | QoS 公共函数 |
| `miqos.command` | TC 命令生成 |
| `miqos.rule_by_service` | 服务规则 |
| `miqos.rule_by_host` | 主机规则 |
| `miqos.rule_by_prio` | 优先级规则 |
| `nixio.fs` | 文件系统操作 |
| `ubus` | ubus 通信 |
| `luci.model.uci` | UCI 配置管理 |

## 相关文件

- `miqos/common.lua` - 公共函数和配置
- `miqos/command.lua` - TC 命令生成
- `miqos/rule_by_service.lua` - 服务规则
- `miqos/rule_by_host.lua` - 主机规则
- `miqos/rule_by_prio.lua` - 优先级规则
- `miqos/rule_by_noifb.lua` - 无 IFB 模式规则
- `miqos/rule_by_wangzhe.lua` - 王者荣耀优化规则
