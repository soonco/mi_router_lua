# rule_by_host.lua - MiQoS 基于主机的 QoS 规则模块

## 工作原理

本模块实现基于主机（MAC/IP）的 QoS 流量控制。为每个在线主机创建独立的 HTB 类，支持按主机进行带宽分配和限速。

### HTB 类层级结构

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

### 服务类型子类

| 子类 | ID | 优先级 | 保证速率 | 上限速率 |
|------|-----|--------|----------|----------|
| game | 1 | 2 | 15% | 60% |
| web | 2 | 3 | 40% | 100% |
| video | 3 | 4 | 40% | 100% |
| download | 4 | 5 | 5% | 95% |

### 变化级别

| 级别 | 说明 | 处理方式 |
|------|------|----------|
| "0" | 无变化 | 不处理 |
| "1" | 带宽变化 | 仅更新速率 |
| "2" | 配置变化 | 重新生成所有规则 |

## 接口

### 模块注册

模块注册到 `qdisc["host"]` 表中。

### 导出函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `qdisc.host.clean(dev_list)` | dev_list: 设备列表 | - | 清理 host QoS 规则 |
| `qdisc.host.changed()` | - | boolean | 检查配置是否变化 |
| `qdisc.host.read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `qdisc.host.apply(prev_qdisc, bands, dev_list, force)` | 参数列表 | boolean | 应用 host QoS 规则 |
| `qdisc.host.update_counters(dev_list)` | dev_list: 设备列表 | table | 更新计数器信息 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `scan_online_hosts()` | 扫描在线主机 |
| `detect_host_changes()` | 检测主机列表变化 |
| `calculate_group_bandwidth()` | 计算分组带宽分配 |
| `generate_host_class()` | 生成单个主机的 TC 类规则 |
| `generate_all_hosts_rules()` | 生成所有主机的 TC 规则 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `miqos.common` | QoS 公共函数 |
| `luci.ip` | IP 地址处理 |
