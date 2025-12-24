# index.lua - 配置扫描控制器模块

## 工作原理

配置扫描控制器模块，提供路由器配置安全扫描的 API 接口，支持异步扫描任务管理。

核心功能：
1. **异步扫描** - 使用 fork 创建子进程执行扫描
2. **任务管理** - 支持多个并发扫描任务（最多 4 个）
3. **状态跟踪** - 实时跟踪扫描进度和结果
4. **自动清理** - 清理超时的扫描任务

文件系统结构：
```
/tmp/config_scan/
├── meta/
│   ├── ids/       # 任务 ID 文件
│   ├── result/    # 扫描结果
│   └── pids/      # 进程 ID 文件
└── {workid}/      # 任务工作目录
```

## 接口

### API 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/api/config_scanner/overview` | GET | 获取扫描概览 |
| `/api/config_scanner/config` | POST | 配置扫描项 |
| `/api/config_scanner/start` | POST | 启动扫描 |
| `/api/config_scanner/get_status` | GET | 获取扫描状态 |
| `/api/config_scanner/stop` | POST | 停止扫描 |

### 请求参数

#### config

| 参数 | 类型 | 说明 |
|------|------|------|
| `{item_name}` | string | "1" 启用扫描，"0" 禁用 |

#### get_status / stop

| 参数 | 类型 | 说明 |
|------|------|------|
| `work_id` | string | 扫描任务 ID |

### 响应格式

#### start 响应

```json
{
    "code": 0,
    "meta": {
        "work_id": "123"
    }
}
```

#### get_status 响应

```json
{
    "code": 0,
    "meta": {
        "status": 1,
        "score": 80,
        "running": "wifi_encryption"
    },
    "wifi_encryption": {
        "status": 2,
        "secure": 1,
        "enable_scan": 1
    }
}
```

### 状态码说明

| 状态 | 说明 |
|------|------|
| 1 | 扫描中 |
| 2 | 扫描完成 |

### 内部函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_uptime()` | 无 | number | 获取系统运行时间 |
| `ensure_dirs()` | 无 | 无 | 确保目录存在 |
| `acquire_lock()` | 无 | fd | 获取文件锁 |
| `release_lock(fd)` | fd | 无 | 释放文件锁 |
| `create_work_id()` | 无 | string/nil | 创建任务 ID |
| `cleanup_old_works()` | 无 | 无 | 清理超时任务 |
| `remove_work(workid)` | workid | 无 | 删除任务 |
| `kill_process(workid)` | workid | 无 | 终止任务进程 |

### 并发限制

| 限制 | 值 | 说明 |
|------|-----|------|
| `MAX_CONCURRENT` | 4 | 最大并发扫描数 |
| 任务超时 | 10 秒 | 无更新则自动清理 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.model.uci` | UCI 配置读取 |
| `config_scan.main_scanner` | 主扫描器 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `xiaoqiang.common.XQFunction` | 通用函数（forkExec2） |
| `nixio` | 文件系统操作 |
| `posix.fcntl` | 文件锁 |
