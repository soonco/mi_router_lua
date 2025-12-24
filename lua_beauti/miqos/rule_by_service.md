# rule_by_service.lua - MiQoS 基于服务的 QoS 规则模块

## 工作原理

本模块实现基于服务类型（游戏/网页/视频/下载）的流量控制。使用 Linux TC (Traffic Control) 的 HTB (Hierarchical Token Bucket) 队列算法，为不同类型的流量分配不同的带宽和优先级。

### HTB 类层级结构

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

### 服务类型配置

| 服务类型 | 保证速率 | 上限速率 | 优先级 |
|----------|----------|----------|--------|
| game | 10% | 60% | 高 |
| web | 35% | 100% | 中高 |
| video | 45% | 100% | 中 |
| download | 10% | 95% | 低(默认) |

## 接口

### 模块注册

模块注册到 `qdisc["service"]` 表中。

### 导出函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `qdisc.service.clean(interfaces)` | interfaces: 接口列表 | - | 清理服务 QoS 规则 |
| `qdisc.service.changed()` | - | boolean | 检查配置是否变化 |
| `qdisc.service.read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `qdisc.service.apply(qos_type, origin_disc, interfaces, force_rebuild)` | qos_type: QoS类型; origin_disc: 原始qdisc; interfaces: 接口; force_rebuild: 强制重建 | boolean | 应用服务 QoS 规则 |
| `qdisc.service.update_counters(interfaces)` | interfaces: 接口列表 | table | 更新计数器信息 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `scan_online_hosts()` | 扫描在线主机 |
| `process_host_changes()` | 处理主机变化 |
| `generate_service_qdisc()` | 生成服务 QoS 规则 |
| `generate_host_class_rules()` | 生成主机类规则 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `miqos.common` | QoS 公共函数 |
| `luci.ip` | IP 地址处理 |
