# LuCI SGI (Server Gateway Interface) 模块

## 目录概述

本目录包含 LuCI 框架的服务器网关接口模块，负责处理 Web 服务器与 LuCI 框架之间的通信。SGI 层是 LuCI 架构中的关键组件，它将底层 Web 服务器（如 uhttpd）的请求转换为 LuCI 可以处理的格式。

## 目录结构

```
sgi/
├── cgi.lua          # CGI 服务器网关接口实现
├── cgi.lua.md       # CGI 模块详细文档
└── Readme.md        # 本文档
```

## 模块列表

### cgi.lua - CGI 服务器网关接口

**模块路径**: `luci.sgi.cgi`

**功能描述**: 作为 Web 服务器和 LuCI 框架之间的桥梁，处理标准 CGI 请求。

**核心功能**:

| 功能 | 说明 |
|------|------|
| 请求处理 | 解析 CGI 环境变量和 HTTP 请求体 |
| 协程调度 | 使用 Lua 协程处理 HTTP 调度器 |
| 响应输出 | 按消息类型输出 HTTP 响应（状态码、头部、正文） |
| os.execute 修复 | 使用小米路由器的 waitExec 替代标准实现 |

**主要接口**:

| 函数 | 说明 |
|------|------|
| `run()` | CGI 主运行函数，处理完整的 HTTP 请求/响应周期 |

**消息类型协议**:

| 类型 | 说明 | 参数 |
|------|------|------|
| 1 | 设置 HTTP 状态码 | arg1=状态码, arg2=状态描述 |
| 2 | 添加 HTTP 响应头 | arg1=头名称, arg2=头值 |
| 3 | 完成响应头部 | 无 |
| 4 | 写入响应正文 | arg1=内容 |
| 5 | 关闭输出流 | 无 |
| 6 | 零拷贝文件传输 | arg1=文件句柄, arg2=传输大小 |

## 工作流程

```
┌─────────────────┐
│   Web Server    │  (uhttpd/nginx/etc.)
│   (CGI 调用)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   cgi.lua       │
│   run()         │
├─────────────────┤
│ 1. fixOsExecute │  修复 os.execute 函数
│ 2. 创建 Request  │  从环境变量和 stdin 构建
│ 3. 创建协程      │  luci.dispatcher.httpdispatch
│ 4. 协程循环      │  处理消息类型 1-6
│ 5. 输出响应      │  状态码 → 头部 → 正文
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ luci.dispatcher │  LuCI 核心调度器
└─────────────────┘
```

## 依赖模块

| 模块 | 用途 |
|------|------|
| `luci.ltn12` | LTN12 数据传输库 |
| `nixio.util` | Nixio I/O 工具函数 |
| `luci.http` | HTTP 请求/响应处理 |
| `luci.sys` | 系统函数（环境变量获取等） |
| `luci.dispatcher` | LuCI HTTP 调度器 |
| `xiaoqiang.common.XQFunction` | 小米路由器专用函数 |

## 技术特点

1. **协程驱动**: 使用 Lua 协程实现非阻塞的请求处理，调度器通过 yield 返回消息类型和数据
2. **流式处理**: 支持大文件的流式传输，避免内存溢出
3. **零拷贝传输**: 消息类型 6 支持使用 nixio 的 copyz 进行零拷贝文件传输
4. **错误处理**: 协程执行出错时自动返回 500 Internal Server Error

## 使用场景

本模块主要用于：
- 小米路由器 LuCI Web 管理界面
- 基于 CGI 的 Web 服务器部署
- 需要与 LuCI 框架集成的 Web 应用

## 相关文档

- [cgi.lua.md](./cgi.lua.md) - CGI 模块详细接口文档
