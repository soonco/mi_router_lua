# firewall.lua - 防火墙模型模块

## 工作原理

提供防火墙配置的 Lua 对象模型，封装 UCI 防火墙配置的操作。支持区域(zone)、转发(forwarding)、规则(rule)和重定向(redirect)的管理。

### 类层次结构

- `defaults`: 防火墙默认设置
- `zone`: 防火墙区域
- `forwarding`: 区域间转发
- `rule`: 防火墙规则
- `redirect`: 端口重定向/NAT

## 接口

### 模块级函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `init(cursor)` | UCI cursor | 模块自身 | 初始化防火墙模型 |
| `save(...)` | 配置文件名 | 无 | 保存配置更改 |
| `commit(...)` | 配置文件名 | 无 | 提交配置更改 |
| `get_defaults()` | 无 | defaults | 获取默认设置 |
| `new_zone()` | 无 | zone | 创建新区域（自动命名） |
| `add_zone(name)` | 区域名 | zone | 添加新区域 |
| `get_zone(name)` | 区域名 | zone | 获取指定区域 |
| `get_zones()` | 无 | zone[] | 获取所有区域 |
| `get_zone_by_network(network)` | 网络名 | zone | 根据网络获取区域 |
| `del_zone(name)` | 区域名 | boolean | 删除区域 |
| `rename_zone(old, new)` | 原名, 新名 | boolean | 重命名区域 |
| `del_network(network)` | 网络名 | 无 | 从所有区域删除网络 |

### defaults 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `syn_flood()` | 无 | boolean | 获取 SYN 洪水防护状态 |
| `drop_invalid()` | 无 | boolean | 获取丢弃无效包状态 |
| `input()` | 无 | string | 获取默认入站策略 |
| `forward()` | 无 | string | 获取默认转发策略 |
| `output()` | 无 | string | 获取默认出站策略 |

### zone 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `name()` | 无 | string | 获取区域名称 |
| `network()` | 无 | string | 获取关联网络列表 |
| `masq()` | 无 | boolean | 获取伪装(NAT)状态 |
| `input()` | 无 | string | 获取入站策略 |
| `forward()` | 无 | string | 获取转发策略 |
| `output()` | 无 | string | 获取出站策略 |
| `add_network(network)` | 网络名 | 无 | 添加网络到区域 |
| `del_network(network)` | 网络名 | 无 | 从区域删除网络 |
| `get_networks()` | 无 | string[] | 获取关联网络列表 |
| `clear_networks()` | 无 | 无 | 清空关联网络 |
| `get_forwardings_by(dir)` | "src"/"dest" | forwarding[] | 获取转发规则 |
| `add_forwarding_to(zone)` | 目标区域名 | forwarding | 添加到指定区域的转发 |
| `add_forwarding_from(zone)` | 源区域名 | forwarding | 添加从指定区域的转发 |
| `del_forwardings_by(dir)` | "src"/"dest" | 无 | 删除转发规则 |
| `add_redirect(options)` | 配置选项 | redirect | 添加重定向规则 |
| `add_rule(options)` | 配置选项 | rule | 添加防火墙规则 |
| `get_color()` | 无 | string | 获取区域颜色（Web 显示） |

### forwarding 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `src()` | 无 | string | 获取源区域名 |
| `dest()` | 无 | string | 获取目标区域名 |
| `src_zone()` | 无 | zone | 获取源区域对象 |
| `dest_zone()` | 无 | zone | 获取目标区域对象 |

### rule 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `src()` | 无 | string | 获取源区域名 |
| `dest()` | 无 | string | 获取目标区域名 |
| `src_zone()` | 无 | zone | 获取源区域对象 |
| `dest_zone()` | 无 | zone | 获取目标区域对象 |

### redirect 类

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get(option)` | 选项名 | 值 | 获取配置值 |
| `set(option, value)` | 选项名, 值 | boolean | 设置配置值 |
| `src()` | 无 | string | 获取源区域名 |
| `dest()` | 无 | string | 获取目标区域名 |
| `src_zone()` | 无 | zone | 获取源区域对象 |
| `dest_zone()` | 无 | zone | 获取目标区域对象 |

### 默认策略

| 策略 | 说明 |
|------|------|
| `ACCEPT` | 接受 |
| `REJECT` | 拒绝（返回错误） |
| `DROP` | 丢弃（静默） |

### 区域颜色

| 区域 | 颜色 |
|------|------|
| lan | #90f090 (绿色) |
| wan | #f09090 (红色) |
| 其他 | 根据名称哈希生成 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.template.parser` | 模板解析器（哈希函数） |
| `luci.util` | 工具函数（class、imatch） |
| `luci.model.uci` | UCI 配置接口 |
