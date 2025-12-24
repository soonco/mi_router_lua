# ssl.lua - LuaSec SSL/TLS 模块

## 工作原理

本模块提供 SSL/TLS 加密连接功能，是 LuaSec 库的高级封装。支持创建安全的网络连接，包括证书验证、密码套件配置、ALPN 协议协商等。

主要功能：
- 创建 SSL 上下文（服务器/客户端模式）
- 包装普通 socket 为 SSL 连接
- 证书和私钥管理
- ALPN（应用层协议协商）支持
- SNI（服务器名称指示）支持

工作流程：
1. 创建 SSL 上下文并配置参数
2. 加载证书和私钥
3. 设置验证模式和密码套件
4. 包装 socket 创建 SSL 连接
5. 执行 SSL 握手

## 接口

### 模块属性

| 属性 | 说明 |
|------|------|
| `ssl._VERSION` | 版本号 "0.9" |
| `ssl._COPYRIGHT` | 版权信息 |
| `ssl.config` | SSL 配置模块 |

### 主要函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `ssl.newcontext(config)` | config: SSL 配置表 | SSL 上下文或 nil, 错误信息 | 创建 SSL 上下文 |
| `ssl.wrap(socket, params)` | socket: 原始 socket<br>params: SSL 配置或上下文 | SSL 连接或 nil, 错误信息 | 包装 socket 为 SSL 连接 |
| `ssl.loadcertificate(path)` | path: 证书路径 | 证书对象 | 加载 X.509 证书 |

### 配置参数

| 参数 | 类型 | 说明 |
|------|------|------|
| `mode` | string | "server" 或 "client" |
| `certificate` | string | 证书文件路径 |
| `key` | string | 私钥文件路径 |
| `password` | string/function | 私钥密码 |
| `cafile` | string | CA 证书文件路径 |
| `capath` | string | CA 证书目录路径 |
| `verify` | table | 验证模式 |
| `depth` | number | 验证深度 |
| `ciphers` | string | 密码套件 |
| `alpn` | table/function | ALPN 协议列表或回调 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `ssl.core` | SSL 核心 C 模块 |
| `ssl.context` | SSL 上下文管理 |
| `ssl.x509` | X.509 证书处理 |
| `ssl.config` | SSL 配置 |
