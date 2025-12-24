# uci.lua - UCI 配置接口扩展模块

## 工作原理

扩展 UCI (Unified Configuration Interface) cursor 的功能，提供更便捷的配置操作方法。通过元表扩展 uci.cursor 对象，添加批量操作、类型转换、配置依赖追踪等功能。

### 配置应用流程

1. 调用 `apply()` 方法
2. 通过 `_affected()` 查找受影响的配置文件
3. 递归查找 ucitrack 中的依赖关系
4. 执行 `/sbin/luci-reload` 重载服务

## 接口

### 模块级函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cursor()` | 无 | UCI cursor | 创建 UCI cursor |
| `cursor_state()` | 无 | UCI cursor | 创建带状态的 cursor |

### cursor 扩展方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `apply(configlist, async)` | 配置列表, 是否异步 | 命令数组或执行结果 | 应用配置更改 |
| `delete_all(config, type, filter)` | 配置文件, 节类型, 过滤函数/表 | 无 | 批量删除配置节 |
| `section(config, type, name, values)` | 配置文件, 节类型, 节名, 值表 | 节名或 nil | 创建或更新配置节 |
| `tset(config, section, values)` | 配置文件, 节名, 值表 | boolean | 批量设置配置选项 |
| `get_bool(...)` | get 参数 | boolean | 获取布尔类型配置值 |
| `get_list(config, section, option)` | 配置文件, 节名, 选项名 | table | 获取列表类型配置值 |
| `set_list(config, section, option, value)` | 配置文件, 节名, 选项名, 值 | boolean | 设置列表类型配置值 |
| `get_first(config, type, option, expected)` | 配置文件, 节类型, 选项名, 期望类型 | 值或 nil | 获取第一个匹配的配置值 |
| `substate(config)` | 配置文件名 | cursor | 获取状态子游标 |
| `_affected(configlist)` | 配置列表 | 配置文件数组 | 获取受影响的配置文件列表 |

### 布尔值识别

以下值被识别为 `true`：
- `"1"`
- `"true"`
- `"yes"`
- `"on"`

### 配置依赖追踪

通过 `/etc/config/ucitrack` 文件定义配置文件之间的依赖关系：

```
config network
    list affects firewall
    list affects dhcp
```

### 状态文件

状态文件存储在 `/var/state` 目录，用于存储运行时状态信息。

## 外部引用

| 模块 | 用途 |
|------|------|
| `os` | 系统操作（执行命令） |
| `uci` | UCI 核心库 |
| `luci.util` | 工具函数（contains） |
| `table` | 表操作 |
