# socket.lua - LuaSocket 核心模块

## 工作原理

本模块是 LuaSocket 库的核心模块，提供 TCP/UDP 网络通信功能，包含数据源（source）和数据接收器（sink）的实现。

主要功能：
- TCP/UDP 连接创建和管理
- IPv4/IPv6 支持
- 数据源和接收器抽象
- DNS 解析
- 地址绑定和监听

数据传输模型：
- **Source（数据源）**: 生产数据的函数
- **Sink（数据槽）**: 消费数据的函数
- 配合 LTN12 库实现流式数据处理

## 接口

### 连接函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `socket.connect4(address, port, localAddr, localPort)` | 地址参数 | socket 对象 | IPv4 连接 |
| `socket.connect6(address, port, localAddr, localPort)` | 地址参数 | socket 对象 | IPv6 连接 |
| `socket.bind(address, port, backlog)` | 绑定参数 | socket 对象 | 绑定并监听端口 |

### 数据源函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `socket.source("by-length", sock, length)` | socket, 长度 | 数据源对象 | 按长度读取 |
| `socket.source("until-closed", sock)` | socket | 数据源对象 | 读取直到关闭 |

### 数据接收器函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `socket.sink("close-when-done", sock)` | socket | 接收器对象 | 完成后关闭 |
| `socket.sink("keep-open", sock)` | socket | 接收器对象 | 保持打开 |

### 工具函数

| 函数 | 说明 |
|------|------|
| `socket.try` | 创建 try 函数 |
| `socket.choose(handlers)` | 创建选择器函数 |

### 常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `socket.BLOCKSIZE` | 2048 | 默认块大小 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `socket.core` | Socket 核心 C 模块 |
| `string` | Lua 字符串库 |
| `math` | Lua 数学库 |
