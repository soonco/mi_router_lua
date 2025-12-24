# command.lua - MiQoS 命令处理模块

## 工作原理

本模块处理 QoS 系统的各种控制命令，包括开关控制、带宽设置、限速管理、游戏模式等。通过 `process_cmd()` 函数作为统一入口，分发到各个命令处理函数。

### 命令分类

| 类别 | 命令 | 说明 |
|------|------|------|
| 基础控制 | on, off, shutdown | QoS 开关控制 |
| 带宽设置 | change_band, show_band | 带宽配置 |
| 限速管理 | on_limit, set_limit, off_limit, limit_flag | 设备限速 |
| 访客/XQ | on_guest, on_xq, show_guest, show_xq | 访客和小米设备限速 |
| 游戏模式 | game_mode_on/off, game_dev_add/del | 游戏加速 |
| 王者荣耀 | wangzhe_plug_on/off, show_wangzhe | 王者荣耀加速 |
| 配置查询 | show_limit, show_cfg, get_seq | 查询配置 |

## 接口

### 主入口函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `process_cmd(cmd, ...)` | cmd: 命令名; ...: 命令参数 | 结果表 | 处理命令的主入口 |

### 命令处理函数

| 命令 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `on()` | - | {status, data}, need_apply | 开启 QoS |
| `off()` | - | {status, data}, need_apply | 关闭 QoS |
| `shutdown()` | - | {status, data}, need_apply | 完全关闭 QoS 系统 |
| `change_band(upload, download)` | 上传/下载带宽 | {status, data}, need_apply | 修改带宽设置 |
| `on_limit(mode, mac, ...)` | mode: max/min/both; mac: MAC地址 | {status, data}, need_apply | 设置设备限速 |
| `off_limit(mac)` | mac: MAC地址(可选) | {status, data}, need_apply | 关闭限速 |
| `game_mode_on()` | - | {status, data}, need_apply | 开启游戏模式 |
| `game_mode_off()` | - | {status, data}, need_apply | 关闭游戏模式 |

### 返回值格式

```lua
{
    status = 0,  -- 0: 成功, 1: 失败
    data = "ok"  -- 结果数据或错误信息
}
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `json` | JSON 编解码 |
| `miqos.common` | QoS 公共函数 |
