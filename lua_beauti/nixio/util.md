# util.lua - Nixio 工具模块

## 工作原理

本模块为 nixio 库提供扩展工具函数，包括数据消费、I/O 操作等实用功能。它通过扩展 nixio 的元表，为 socket、TLS socket 和文件对象添加便捷方法。

主要特点：
- 提供数据迭代器消费功能
- 支持完整数据读写（readall/writeall）
- 提供行数据源和块数据源迭代器
- 支持 Linux 零拷贝传输（sendfile）
- 为 TLS socket 添加额外的便捷方法

## 接口

### 全局函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `consume(iterator, resultTable)` | iterator: 迭代器函数; resultTable: 结果表(可选) | 包含所有数据的表 | 消费迭代器数据到表中 |

### 元表方法（添加到 socket/file/tls_socket）

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `is_socket()` | - | boolean | 检查是否为 socket |
| `is_tls_socket()` | - | boolean | 检查是否为 TLS socket |
| `is_file()` | - | boolean | 检查是否为文件 |
| `readall()` | - | string | 读取所有数据 |
| `recvall()` | - | string | 接收所有数据 |
| `writeall(data)` | data: 要写入的数据 | number | 写入所有数据，返回字节数 |
| `sendall(data)` | data: 要发送的数据 | number | 发送所有数据，返回字节数 |
| `linesource(limit)` | limit: 最大读取字节数(可选) | function | 创建按行读取的迭代器 |
| `blocksource(blockSize)` | blockSize: 块大小(可选) | function | 创建按块读取的迭代器 |
| `sink()` | - | function | 创建数据接收器函数 |
| `copy(source, target)` | source: 数据源; target: 目标(可选) | number | 复制数据，返回字节数 |
| `copyz(source, count)` | source: 源文件描述符; count: 字节数 | number | 零拷贝复制（仅 Linux） |

### TLS Socket 专用方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `close()` | - | - | 关闭 TLS 连接 |
| `getsockname()` | - | 地址信息 | 获取本地地址 |
| `getpeername()` | - | 地址信息 | 获取对端地址 |
| `getsockopt(...)` | 选项参数 | 选项值 | 获取 socket 选项 |
| `setsockopt(...)` | 选项参数 | - | 设置 socket 选项 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `table` | 表操作 |
| `nixio` | 底层 I/O 操作 |
