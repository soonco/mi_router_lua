# common.lua - 配置扫描公共函数库

## 工作原理

本模块提供配置扫描系统的公共函数和常量，包括扫描状态管理、进度报告、文件操作辅助和子模块扫描协调等功能。

### 工作状态常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `WORK_STATUS_WAIT` | 0 | 等待扫描 |
| `WORK_STATUS_RUNNING` | 1 | 正在扫描 |
| `WORK_STATUS_DONE` | 2 | 扫描完成 |

### 扫描目录结构

```
statusPath/
├── meta/
│   ├── status      - 扫描状态 (0/1/2)
│   ├── score       - 扫描分数
│   ├── display     - 显示标记
│   └── enable_scan - 启用扫描标记
└── submod_name/    - 子模块目录
    └── meta/
        └── ...
```

## 接口

### 常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `SCAN_SCRIPTS_DIR` | "/usr/lib/lua/config_scan" | 扫描脚本目录 |
| `WORK_STATUS_WAIT` | 0 | 等待扫描 |
| `WORK_STATUS_RUNNING` | 1 | 正在扫描 |
| `WORK_STATUS_DONE` | 2 | 扫描完成 |

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `prepare_status(statusPath, submods)` | statusPath: 状态目录; submods: 子模块列表(可选) | - | 准备扫描状态目录结构 |
| `scan_submod(statusPath, submods)` | statusPath: 状态目录; submods: 子模块列表 | number | 扫描所有子模块，返回加权平均分数(0-1) |
| `scan_leaf(statusPath, scanFunc)` | statusPath: 状态目录; scanFunc: 扫描函数 | number | 执行叶子节点扫描 |

### 子模块配置格式

```lua
submods = {
    { name = "module_name", weight = 1 },
    { name = "another_module", weight = 2 }
}
```

### 扫描流程

1. `prepare_status()` - 创建目录结构和状态文件
2. `scan_submod()` - 使用协程并发执行子模块扫描
3. `scan_leaf()` - 执行实际的安全检查（叶子节点）

## 外部引用

| 模块 | 用途 |
|------|------|
| `posix` | POSIX 接口，用于休眠 |
| `nixio` | 文件系统操作 |
