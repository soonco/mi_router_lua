# rule_by_wangzhe.lua - MiQoS 王者荣耀游戏加速模块

## 工作原理

本模块专门针对王者荣耀（Honor of Kings）游戏进行 QoS 优化。通过检测运行王者荣耀的设备，为其分配专用带宽保障，降低游戏延迟。

### 工作流程

1. 通过 `is_wangzhe_dev()` 检测王者荣耀游戏设备
2. 为检测到的设备分配 `cfg.wangzhe.devbands` 配置的专用带宽
3. 使用与 service 模块相同的 HTB 类层级结构
4. 动态跟踪设备上下线状态

### 配置项

| 配置 | 说明 |
|------|------|
| `cfg.wangzhe.bands` | 游戏模式总带宽 |
| `cfg.wangzhe.devbands` | 单个游戏设备带宽 |
| `cfg.wangzhe.iplist` | 游戏设备 IP 列表 |
| `cfg.wangzhe.modeon` | 游戏模式开关 |
| `cfg.wangzhe.plugon` | 加速插件开关 |

## 接口

### 模块注册

模块注册到 `qdisc["wangzhe"]` 表中。

### 导出函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `qdisc.wangzhe.clean(interfaces)` | interfaces: 接口列表 | - | 清理王者荣耀 QoS 规则 |
| `qdisc.wangzhe.changed()` | - | boolean | 检查配置是否变化 |
| `qdisc.wangzhe.read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `qdisc.wangzhe.apply(interfaces, force_rebuild)` | interfaces: 接口; force_rebuild: 强制重建 | boolean | 应用王者荣耀 QoS 规则 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `is_wangzhe_dev(ip)` | 检测是否为王者荣耀设备 |
| `scan_online_hosts()` | 扫描在线主机 |
| `generate_wangzhe_qdisc()` | 生成王者荣耀 QoS 规则 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `miqos.common` | QoS 公共函数 |
| `luci.ip` | IP 地址处理 |
