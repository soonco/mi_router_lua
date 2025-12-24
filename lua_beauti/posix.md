# posix.lua - POSIX 系统调用 Lua 封装库

## 工作原理

本模块提供 Unix/Linux POSIX 系统调用的 Lua 接口，是一个综合性的系统编程库。模块通过加载多个 POSIX 子模块并合并到主模块中，提供统一的 API。

主要功能类别：
- **文件操作**: 目录遍历、文件状态、文件控制
- **进程管理**: fork、exec、wait、信号处理
- **用户/组管理**: 用户 ID、组 ID、密码数据库
- **网络操作**: 套接字、I/O 多路复用
- **时间操作**: 时间获取、时间计算
- **终端操作**: 终端 I/O、伪终端

## 接口

### 进程管理

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `posix.spawn(command, ...)` | 命令和参数 | 退出状态 | 创建子进程执行命令 |
| `posix.system(command, ...)` | 命令和参数 | 退出状态 | spawn 的别名 |
| `posix.fork()` | 无 | pid | 创建子进程 |
| `posix.wait(pid)` | 进程 ID | 状态信息 | 等待子进程 |
| `posix.execp(...)` | 命令和参数 | 不返回 | 执行程序 |

### 伪终端操作

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `posix.openpty()` | 无 | masterFd, slaveFd, slaveName | 打开伪终端对 |

### 管道操作

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `posix.pipeline(commands, pipeFunc)` | 命令列表 | 退出状态 | 执行管道命令序列 |
| `posix.pipeline_iterator(commands, pipeFunc)` | 命令列表 | 迭代器函数 | 创建管道输出迭代器 |
| `posix.pipeline_slurp(commands, pipeFunc)` | 命令列表 | 完整输出字符串 | 读取管道全部输出 |

### 文件访问

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `posix.euidaccess(path, mode)` | 路径, 访问模式 | 0 或 nil | 检查有效用户访问权限 |
| `posix.access(path, mode)` | 路径, 访问模式 | 0 或 nil | 检查文件访问权限 |
| `posix.stat(path)` | 路径 | 文件状态表 | 获取文件状态 |

### 时间操作

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `posix.timeradd(t1, t2)` | 两个时间值 | 相加结果 | 时间值相加 |
| `posix.timersub(t1, t2)` | 两个时间值 | 相减结果 | 时间值相减 |
| `posix.timercmp(t1, t2)` | 两个时间值 | 比较结果 | 比较时间值 |

### 包含的子模块

| 子模块 | 说明 |
|------|------|
| `posix.dirent` | 目录操作 |
| `posix.errno` | 错误码 |
| `posix.fcntl` | 文件控制 |
| `posix.signal` | 信号处理 |
| `posix.unistd` | Unix 标准函数 |
| `posix.sys.socket` | 套接字操作 |
| `posix.syslog` | 系统日志 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `posix.bit32` | 位操作库 |
| `posix.fcntl` | 文件控制 |
| `posix.stdlib` | 标准库函数 |
| `posix.unistd` | Unix 标准函数 |
