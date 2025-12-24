# rule_by_prio.lua - MiQoS 优先级规则模块

## 工作原理

本模块实现基于流量优先级的简单 QoS 方案。使用 Linux TC 的 prio qdisc 实现优先级队列，通过 fw 过滤器根据 fwmark 分类流量。

### 与 HTB 模式的区别

- prio 模式：简单的优先级队列，高优先级流量优先发送
- HTB 模式：分层令牌桶，可精确控制带宽分配

### 优先级队列

| 队列 | 类型 | 优先级 | 说明 |
|------|------|--------|------|
| 1 | high | 1 | 高优先级流量 |
| 2 | game | 2 | 游戏流量 |
| 3 | web | 3 | 网页流量 |
| 4 | video | 4 | 视频流量 |
| 5 | other | 5 | 其他流量 |
| 6 | guest | 6 | 访客网络 |
| 7 | xq | 7 | 小米设备 |

### fwmark 规则

| 类型 | fwmark | 过滤器优先级 |
|------|--------|--------------|
| high | 0x00010000/0x000f0000 | 4 |
| game | 0x00020000/0x000f0000, 0x00130000/0x00ff0000 | 4, 5 |
| web | 0x00230000/0x00ff0000 | 5 |
| video | 0x00330000/0x00ff0000 | 5 |
| other | 0x00430000/0x00ff0000 | 5 |
| guest | 0x00040000/0x000f0000 | 4 |
| xq | 0x00050000/0x000f0000 | 4 |

## 接口

### 模块注册

模块注册到 `qdisc["prio"]` 表中。

### 导出函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `qdisc.prio.clean(devs)` | devs: 设备列表 | - | 清理 prio QoS 规则 |
| `qdisc.prio.changed()` | - | boolean | 检查配置是否变化 |
| `qdisc.prio.read_qos_config()` | - | boolean | 读取 QoS 配置 |
| `qdisc.prio.apply(old_qdisc, bands, devs, force_clean)` | 参数列表 | boolean | 应用 prio QoS 规则 |

### 内部函数

| 函数 | 说明 |
|------|------|
| `gen_prio_qdisc()` | 生成 prio qdisc 规则 |
| `gen_special_host_filters()` | 生成特殊主机过滤规则 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `miqos.common` | QoS 公共函数 |
