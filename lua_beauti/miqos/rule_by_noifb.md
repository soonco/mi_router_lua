# rule_by_noifb.lua - MiQoS 无 IFB 设备规则模块

## 工作原理

本模块实现不使用 IFB (Intermediate Functional Block) 设备的 QoS 方案。直接在物理接口上进行流量控制，适用于不支持 IFB 的设备或需要简化配置的场景。

### 与标准模式的区别

- 标准模式：使用 IFB 设备重定向入站流量进行整形
- NoIFB 模式：直接在 br-lan 等接口上进行流量控制

### HTB 类层级结构

与 service 模块相同，使用十进制 ID：
- root: 4096 (0x1000)
- special: 8192 (0x2000)
- host: 12288 (0x3000)
- guest: 16384 (0x4000)
- xq: 20480 (0x5000)

## 接口

### 模块注册

模块注册到 `qdisc["noifb"]` 表中。

### 导出函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `qdisc.noifb.clean(dev_list)` | dev_list: 设备列表 | - | 清理 NoIFB QoS 规则 |
| `qdisc.noifb.changed()` | - | boolean | 检查配置是否变化 |
| `qdisc.noifb.read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `qdisc.noifb.apply(prev_qdisc, bands, dev_list, force)` | 参数同 service | boolean | 应用 NoIFB QoS 规则 |
| `qdisc.noifb.update_counters(dev_list)` | dev_list: 设备列表 | table | 更新计数器信息 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `scan_online_hosts()` | 扫描在线主机 |
| `generate_noifb_qdisc()` | 生成 NoIFB QoS 规则 |
| `generate_host_class_rules()` | 生成主机类规则 |
| `apply_guest_qdisc()` | 应用访客网络 QoS |

## 外部引用

| 模块 | 用途 |
|------|------|
| `miqos.common` | QoS 公共函数 |
| `luci.ip` | IP 地址处理 |
