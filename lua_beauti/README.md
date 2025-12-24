# 小米路由器 LuCI Web 管理系统

## 目录

- [1. 项目概述](#1-项目概述)
- [2. 系统架构](#2-系统架构)
- [3. 目录结构](#3-目录结构)
- [4. 核心模块详解](#4-核心模块详解)
- [5. 辅助模块](#5-辅助模块)
- [6. 安全机制](#6-安全机制)
- [7. 二次开发指南](#7-二次开发指南)
- [8. API 参考](#8-api-参考)
- [9. 配置文件说明](#9-配置文件说明)
- [10. 外部依赖](#10-外部依赖)

---

## 1. 项目概述

### 1.1 简介

本项目是小米路由器的 LuCI Web 管理系统，基于 OpenWrt 的 LuCI 框架进行深度定制开发。系统提供完整的路由器配置管理、网络管理、安全防护、智能家居控制等功能，支持 RESTful API 和 Web 管理界面两种交互方式。

### 1.2 技术栈

| 技术 | 说明 |
|------|------|
| **Lua 5.1** | 主要开发语言 |
| **LuCI** | OpenWrt Web 框架 |
| **UCI** | OpenWrt 统一配置接口 |
| **ubus** | OpenWrt 系统总线 |
| **nixio** | 底层 I/O 库 |
| **uhttpd** | Web 服务器 |

### 1.3 主要功能

| 功能模块 | 说明 |
|----------|------|
| **网络管理** | WAN/LAN 配置、WiFi 管理、DHCP、IPv6、Mesh 组网 |
| **安全防护** | 防火墙、MAC 过滤、防攻击、URL 过滤、配置安全扫描 |
| **系统管理** | 固件升级、系统重启、配置备份/恢复、日志管理 |
| **智能家居** | MIIO 设备控制、智能家居网关、设备管理 |
| **增值服务** | QoS 流量控制、VPN、DDNS、游戏加速 |

---

## 2. 系统架构

### 2.1 整体架构图

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              客户端请求                                      │
│                    (Web 浏览器 / APP / API 调用)                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           Web 服务器 (uhttpd)                                │
│                              CGI 接口                                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SGI 层 (luci.sgi.cgi)                               │
│                    服务器网关接口，协程驱动请求处理                            │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                      调度层 (luci.dispatcher)                               │
│              URL 路由 │ 认证管理 │ 权限控制 │ 请求分发                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
              ┌───────────────────────┼───────────────────────┐
              │                       │                       │
              ▼                       ▼                       ▼
┌─────────────────────┐   ┌─────────────────────┐   ┌─────────────────────┐
│    Controller 层    │   │      View 层        │   │      CBI 层         │
│   (API 接口处理)    │   │   (模板渲染)        │   │  (配置绑定接口)     │
│                     │   │                     │   │                     │
│ • api/misystem      │   │ • luci.template     │   │ • luci.cbi          │
│ • api/xqnetwork     │   │ • view/*.htm        │   │ • model/cbi/*       │
│ • api/xqpassport    │   │                     │   │                     │
│ • web/index         │   │                     │   │                     │
└─────────────────────┘   └─────────────────────┘   └─────────────────────┘
              │                       │                       │
              └───────────────────────┼───────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          Model 层 (数据模型)                                 │
│                                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ luci.model  │  │ luci.model  │  │ luci.model  │  │   luci.sys  │        │
│  │    .uci     │  │  .network   │  │  .firewall  │  │             │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           工具层 (Utilities)                                 │
│                                                                             │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐          │
│  │luci.util │ │luci.http │ │luci.json │ │ luci.ip  │ │luci.ltn12│          │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘          │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          系统接口层                                          │
│                                                                             │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐          │
│  │   UCI    │ │   ubus   │ │  nixio   │ │  /proc   │ │ /etc/config│         │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘          │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 请求处理流程

```
HTTP 请求
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│ 1. CGI 入口 (sgi/cgi.lua)                                       │
│    • 解析 CGI 环境变量                                          │
│    • 创建 Request 对象                                          │
│    • 创建协程执行调度器                                          │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│ 2. 路由匹配 (dispatcher.lua)                                    │
│    • 解析 URL 路径                                              │
│    • 查找路由树节点                                              │
│    • 确定目标处理器                                              │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│ 3. 认证检查                                                     │
│    • 检查权限标志位                                              │
│    • 验证会话 Token                                             │
│    • jsonauth / htmlauth                                        │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│ 4. 执行目标处理器                                               │
│    • call() - 调用控制器函数                                    │
│    • template() - 渲染模板                                      │
│    • cbi() - 处理配置表单                                       │
│    • alias() - 重定向到其他路由                                 │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│ 5. 响应输出                                                     │
│    • 协程 yield 返回响应数据                                    │
│    • 状态码 → 响应头 → 响应体                                   │
└─────────────────────────────────────────────────────────────────┘
```

### 2.3 协程响应机制

LuCI 使用 Lua 协程实现非阻塞的 HTTP 响应输出：

| 消息类型 | 说明 | 参数 |
|----------|------|------|
| 1 | 设置 HTTP 状态码 | arg1=状态码, arg2=状态描述 |
| 2 | 添加 HTTP 响应头 | arg1=头名称, arg2=头值 |
| 3 | 完成响应头部 | 无 |
| 4 | 写入响应正文 | arg1=内容 |
| 5 | 关闭输出流 | 无 |
| 6 | 零拷贝文件传输 | arg1=文件句柄, arg2=传输大小 |

---

## 3. 目录结构

```
lua_beauti/
├── luci/                          # LuCI 框架核心
│   ├── controller/                # 控制器层 (API 和页面路由)
│   │   ├── api/                   # RESTful API 接口
│   │   │   ├── index.lua          # API 根节点
│   │   │   ├── misystem.lua       # 系统管理 API
│   │   │   ├── xqnetwork.lua      # 网络管理 API
│   │   │   ├── xqpassport.lua     # 账号认证 API
│   │   │   ├── xqdatacenter.lua   # 数据中心 API
│   │   │   ├── xqnetdetect.lua    # 网络检测 API
│   │   │   ├── xqsmarthome.lua    # 智能家居 API
│   │   │   ├── xqsystem.lua       # 系统扩展 API
│   │   │   ├── xqtunnel.lua       # 隧道请求 API
│   │   │   ├── miats.lua          # 增值服务 API
│   │   │   ├── milog.lua          # 安全日志 API
│   │   │   ├── misns.lua          # WiFi 共享 API
│   │   │   ├── cportal.lua        # 强制门户 API
│   │   │   └── xxxapi.lua         # 第三方扩展 API
│   │   ├── anti_attack/           # 防攻击模块
│   │   ├── config_scan/           # 配置扫描模块
│   │   ├── diagnosis/             # 网络诊断模块
│   │   ├── dispatch/              # 调度模块
│   │   ├── mipctl/                # 设备控制面板
│   │   ├── sec_center/            # 安全中心
│   │   ├── service/               # 内部服务
│   │   ├── url_fw/                # URL 防火墙
│   │   ├── web/                   # Web 管理界面
│   │   └── firewall.lua           # 防火墙控制器
│   │
│   ├── model/                     # 数据模型层
│   │   ├── uci.lua                # UCI 配置接口扩展
│   │   ├── network.lua            # 网络数据模型
│   │   ├── firewall.lua           # 防火墙数据模型
│   │   ├── ipkg.lua               # OPKG 包管理接口
│   │   ├── network/               # 网络协议注册
│   │   │   └── proto_ppp.lua      # PPP 协议族
│   │   └── cbi/                   # CBI 表单模块
│   │       ├── admin_network/     # 网络协议配置表单
│   │       └── firewall/          # 防火墙配置表单
│   │
│   ├── view/                      # 视图模板层
│   │   ├── web/                   # Web 管理界面模板
│   │   │   ├── inc/               # 公共组件
│   │   │   ├── init/              # 初始化向导
│   │   │   ├── setting/           # 系统设置
│   │   │   ├── apsetting/         # AP 模式设置
│   │   │   └── box/               # 扩展功能模块
│   │   ├── diagnosis/             # 网络诊断模板
│   │   ├── firewall/              # 防火墙配置模板
│   │   ├── mipctl/                # 家长控制模板
│   │   ├── themes/                # 主题模板
│   │   └── url_fw/                # URL 过滤模板
│   │
│   ├── http/                      # HTTP 协议处理
│   │   ├── protocol.lua           # HTTP 协议核心
│   │   └── protocol/              # 协议子模块
│   │       ├── conditionals.lua   # 条件请求处理
│   │       ├── date.lua           # 日期格式处理
│   │       └── mime.lua           # MIME 类型映射
│   │
│   ├── sgi/                       # 服务器网关接口
│   │   └── cgi.lua                # CGI 实现
│   │
│   ├── sys/                       # 系统信息模块
│   │   ├── iptparser.lua          # iptables 解析器
│   │   ├── zoneinfo.lua           # 时区信息
│   │   └── zoneinfo/              # 时区数据
│   │
│   ├── cbi/                       # CBI 数据类型
│   │   └── datatypes.lua          # 数据类型验证
│   │
│   ├── tools/                     # 工具模块
│   │   ├── firewall.lua           # 防火墙工具
│   │   ├── proto.lua              # 协议工具
│   │   ├── status.lua             # 状态工具
│   │   └── webadmin.lua           # Web 管理工具
│   │
│   ├── i18n/                      # 国际化资源
│   │   ├── base.zh-cn.lmo         # 简体中文
│   │   ├── base.zh-hk.lmo         # 繁体中文(香港)
│   │   └── base.zh-tw.lmo         # 繁体中文(台湾)
│   │
│   ├── template/                  # 模板引擎
│   │   ├── parser.so              # 模板解析器 (C 模块)
│   │   └── verv.so                # 版本验证 (C 模块)
│   │
│   │   # 核心 Lua 模块
│   ├── dispatcher.lua             # 路由调度器
│   ├── http.lua                   # HTTP 请求处理
│   ├── template.lua               # 模板引擎
│   ├── util.lua                   # 核心工具库
│   ├── sys.lua                    # 系统信息接口
│   ├── cbi.lua                    # 配置绑定接口
│   ├── json.lua                   # JSON 编解码
│   ├── ip.lua                     # IP 地址处理
│   ├── fs.lua                     # 文件系统操作
│   ├── i18n.lua                   # 国际化支持
│   ├── sauth.lua                  # 会话认证
│   ├── store.lua                  # 应用商店
│   ├── config.lua                 # 配置管理
│   ├── debug.lua                  # 调试工具
│   ├── ccache.lua                 # 代码缓存
│   ├── cacheloader.lua            # 缓存加载器
│   ├── ltn12.lua                  # LTN12 数据传输
│   ├── init.lua                   # 初始化模块
│   ├── version.lua                # 版本信息
│   └── verk.lua                   # 版本检查
│
├── aeslua/                        # AES 加密库
│   ├── aes.lua                    # AES 核心算法
│   ├── ciphermode.lua             # 加密模式 (ECB/CBC/OFB/CFB)
│   ├── gf.lua                     # 伽罗瓦域运算
│   ├── buffer.lua                 # 字符串缓冲区
│   └── util.lua                   # 工具函数
│
├── cURL/                          # HTTP 网络请求库
│   ├── impl/                      # 核心实现
│   │   └── cURL.lua               # Easy/Multi/Form/Share 对象
│   ├── safe.lua                   # 安全模式封装
│   └── utils.lua                  # 工具函数
│
├── json/                          # JSON-RPC 模块
│   └── rpc.lua                    # RPC 客户端
│
├── logging/                       # 日志输出适配器
│   ├── console.lua                # 控制台输出
│   ├── file.lua                   # 文件输出
│   ├── rolling_file.lua           # 滚动文件输出
│   ├── email.lua                  # 邮件输出
│   ├── socket.lua                 # Socket 输出
│   └── sql.lua                    # SQL 数据库输出
│
├── config_scan/                   # 配置安全扫描
│   ├── main_scanner.lua           # 主扫描器
│   ├── common.lua                 # 公共函数
│   ├── system.lua                 # 系统配置扫描
│   ├── wireless.lua               # 无线配置扫描
│   ├── newest_rom.lua             # 固件更新检测
│   ├── rom_auto_updating.lua      # 自动更新检测
│   ├── DMZ.lua                    # DMZ 配置检测
│   ├── UPnP.lua                   # UPnP 配置检测
│   ├── port_mapping.lua           # 端口映射检测
│   ├── wifi_encryption.lua        # WiFi 加密检测
│   ├── wifi_passwd_security.lua   # WiFi 密码强度检测
│   └── anti_squatter.lua          # 防蹭网检测
│
│   # 根目录模块
├── aeslua.lua                     # AES 加密入口
├── cURL.lua                       # cURL 入口
├── json.lua                       # JSON 编解码
├── logging.lua                    # 日志框架入口
├── ltn12.lua                      # LTN12 数据传输
├── bit.lua                        # 位运算库
├── checks.lua                     # 参数类型检查
├── hotupgrade.lua                 # 热升级模块
│
│   # 编译的 C 模块
├── bit.so                         # 位运算 (C)
├── cjson.so                       # JSON (C)
├── lcurl.so                       # cURL (C)
├── librsa.so                      # RSA 加密 (C)
├── lsqlite3.so                    # SQLite3 (C)
└── iwinfo.so                      # 无线信息 (C)
```

---

## 4. 核心模块详解

### 4.1 LuCI 框架核心

#### 4.1.1 dispatcher.lua - 路由调度器

**功能定位**：LuCI 框架的核心组件，负责 URL 路由、认证管理、权限控制和请求分发。

**路由节点结构**：
```lua
{
    target = function/table,  -- 目标处理器
    title = string,           -- 显示标题
    order = number,           -- 排序权重
    flag = number,            -- 权限标志
    sysauth = string/table,   -- 需要的认证用户
    nodes = {},               -- 子节点
}
```

**权限标志位定义**：
| 位 | 说明 |
|----|------|
| bit 0 | 允许无认证访问 |
| bit 1 | 禁止远程访问 |
| bit 2 | 允许系统锁定时访问 |
| bit 3 | 允许未初始化时访问 |
| bit 4 | 需要 SDK 权限过滤 |

**关键函数**：
| 函数 | 说明 |
|------|------|
| `httpdispatch(request)` | HTTP 请求入口 |
| `dispatch(request)` | 核心调度函数 |
| `entry(path, target, title, order)` | 注册路由入口 |
| `call(name, ...)` | 创建函数调用目标 |
| `template(name)` | 创建模板渲染目标 |
| `cbi(model, config)` | 创建 CBI 表单目标 |
| `alias(...)` | 创建路由别名目标 |

**使用示例**：
```lua
-- 在 controller 中注册路由
function index()
    -- 注册 API 入口
    entry({"api", "misystem"}, firstchild(), "", 100)
    
    -- 注册具体 API
    entry({"api", "misystem", "router_info"}, call("getRouterInfo"), "", 101)
    
    -- 注册需要认证的 API
    entry({"api", "misystem", "set_password"}, call("setPassword"), "", 102, 0x08)
end
```

---

#### 4.1.2 http.lua - HTTP 请求处理

**功能定位**：封装 HTTP 请求和响应处理，提供表单解析、Cookie 操作、响应输出等功能。

**Request 类核心方法**：
| 方法 | 说明 |
|------|------|
| `formvalue(name, noparse)` | 获取表单值 |
| `formvaluetable(prefix)` | 获取表单值表 |
| `content()` | 获取原始请求体 |
| `getcookie(name)` | 获取 Cookie |
| `getenv(name)` | 获取环境变量 |

**响应输出方法**：
| 方法 | 说明 |
|------|------|
| `status(code, message)` | 设置状态码 |
| `header(key, value)` | 设置响应头 |
| `write(content)` | 写入响应体 |
| `write_json(data)` | 输出 JSON |
| `redirect(url)` | 重定向 |

**使用示例**：
```lua
local http = require("luci.http")

function myHandler()
    -- 获取请求参数
    local name = http.formvalue("name")
    
    -- 输出 JSON 响应
    http.write_json({
        code = 0,
        msg = "success",
        data = { name = name }
    })
end
```

---

#### 4.1.3 template.lua - 模板引擎

**功能定位**：提供模板加载、解析和渲染功能，支持 Lua 代码嵌入。

**模板语法**：
| 语法 | 说明 |
|------|------|
| `<% ... %>` | Lua 代码块 |
| `<%- ... %>` | Lua 代码块（去除前后空白） |
| `<%= ... %>` | 输出表达式 |
| `<%: ... %>` | 国际化文本输出 |
| `<%+ ... %>` | 包含其他模板 |
| `<%# ... %>` | 注释 |

**使用示例**：
```html
<%+header%>
<div class="container">
    <h1><%:Welcome%></h1>
    <% for i, item in ipairs(items) do %>
        <p><%= item.name %></p>
    <% end %>
</div>
<%+footer%>
```

**缓存机制**：
```lua
-- 使用弱引用表缓存编译后的模板
Template.cache = setmetatable({}, { __mode = "v" })
```

---

#### 4.1.4 util.lua - 核心工具库

**功能定位**：提供面向对象支持、字符串处理、表操作、命令执行等核心工具函数。

**面向对象支持**：
```lua
local util = require("luci.util")

-- 定义类
local MyClass = util.class()

function MyClass.__init__(self, name)
    self.name = name
end

function MyClass.sayHello(self)
    return "Hello, " .. self.name
end

-- 继承
local SubClass = util.class(MyClass)
```

**常用函数**：
| 函数 | 说明 |
|------|------|
| `class(base)` | 创建类 |
| `instanceof(obj, class)` | 类型检查 |
| `clone(obj, deep)` | 克隆对象 |
| `split(str, sep)` | 字符串分割 |
| `trim(str)` | 去除空白 |
| `pcdata(str)` | HTML 转义 |
| `exec(cmd)` | 执行命令 |
| `execi(cmd)` | 执行命令（迭代器） |
| `serialize_data(data)` | 序列化 |

---

#### 4.1.5 sys.lua - 系统信息接口

**功能定位**：提供系统信息获取、网络信息、进程管理、用户管理等功能。

**子模块结构**：
| 子模块 | 说明 |
|--------|------|
| `sys.net` | 网络函数（ARP、路由、连接跟踪） |
| `sys.process` | 进程函数 |
| `sys.user` | 用户函数 |
| `sys.wifi` | WiFi 函数 |
| `sys.init` | 初始化脚本管理 |

**常用函数**：
```lua
local sys = require("luci.sys")

-- 系统信息
local hostname = sys.hostname()
local uptime = sys.uptime()
local loadavg = sys.loadavg()
local mem = sys.sysinfo()

-- 网络信息
local arp_table = sys.net.arptable()
local routes = sys.net.routes()

-- 执行命令
local result = sys.exec("uci show network")
```

---

#### 4.1.6 cbi.lua - 配置绑定接口

**功能定位**：将 UCI 配置与 Web 表单绑定，自动生成配置界面。

**类层次结构**：
```
Node (基类)
├── Template (模板节点)
├── Map (配置映射)
│   ├── Delegator (多步骤向导)
│   └── Compound (复合节点)
├── AbstractSection (配置节抽象类)
│   ├── NamedSection (命名配置节)
│   ├── TypedSection (类型化配置节)
│   └── Table (表格配置节)
└── AbstractValue (配置值抽象类)
    ├── Value (单值输入)
    ├── Flag (布尔标志)
    ├── ListValue (下拉列表)
    ├── MultiValue (多选值)
    ├── FileUpload (文件上传)
    └── ...
```

**表单状态常量**：
| 常量 | 值 | 说明 |
|------|-----|------|
| `FORM_NODATA` | 0 | 无表单数据 |
| `FORM_VALID` | 1 | 数据验证通过 |
| `FORM_INVALID` | -1 | 数据验证失败 |
| `FORM_CHANGED` | 2 | 数据已更改 |

**使用示例**：
```lua
local m = Map("network", "Network Configuration")

local s = m:section(NamedSection, "wan", "interface", "WAN Settings")

local proto = s:option(ListValue, "proto", "Protocol")
proto:value("dhcp", "DHCP")
proto:value("static", "Static IP")
proto:value("pppoe", "PPPoE")

local ip = s:option(Value, "ipaddr", "IP Address")
ip:depends("proto", "static")

return m
```

---

### 4.2 Controller 层 (API 接口)

#### 4.2.1 API 路由设计

所有 API 接口遵循统一的路由规范：

```
/api/{module}/{action}
```

**主要 API 模块**：
| 模块 | 路径 | 说明 |
|------|------|------|
| misystem | `/api/misystem/*` | 系统管理（100+ API） |
| xqnetwork | `/api/xqnetwork/*` | 网络管理（100+ API） |
| xqpassport | `/api/xqpassport/*` | 账号认证 |
| xqdatacenter | `/api/xqdatacenter/*` | 数据中心 |
| xqnetdetect | `/api/xqnetdetect/*` | 网络检测 |
| xqsmarthome | `/api/xqsmarthome/*` | 智能家居 |
| miats | `/api/miats/*` | 增值服务 |
| milog | `/api/mi_log/*` | 安全日志 |

---

#### 4.2.2 认证与权限体系

**认证方式**：
| 认证器 | 说明 | 使用场景 |
|--------|------|----------|
| `jsonauth` | JSON 格式认证 | API 接口 |
| `htmlauth` | HTML 表单认证 | Web 页面 |

**权限级别**：
| 级别 | 说明 |
|------|------|
| 1 | 公开接口，无需认证 |
| 8 | 需要管理员认证 |
| 9 | 公开接口，但返回敏感信息 |
| 13 | Mesh 网络相关 |
| 16 | 文件上传相关 |

**认证流程**：
```
1. 客户端调用 /api/misystem/login 获取 Token
2. 后续请求携带 Token（Cookie 或参数）
3. 服务端验证 Token 有效性
4. 检查权限标志位
5. 执行目标处理器
```

---

#### 4.2.3 主要 API 模块详解

##### misystem.lua - 系统管理 API

| 功能分类 | 主要 API | 说明 |
|----------|----------|------|
| 认证相关 | `login`, `getToken`, `renewToken` | 用户登录、Token 管理 |
| 系统初始化 | `getInitInfo`, `setRouter` | 路由器初始化配置 |
| 密码管理 | `setPassword` | 管理员密码设置 |
| 固件升级 | `checkRomUpdate`, `upgradeRom`, `flashRom` | ROM 管理 |
| 路由器信息 | `router_info`, `devicelist` | 设备信息 |
| 系统操作 | `reboot`, `reset` | 重启、恢复出厂 |
| VPN 配置 | `vpnInfo`, `vpnSwitch`, `setVpn` | VPN 管理 |
| MAC 过滤 | `setMacFilter`, `getMacFilterInfo` | 访问控制 |
| 端口转发 | `portforward`, `setDMZ` | NAT 配置 |
| QoS | `qos_info`, `qos_switch`, `qos_limit` | 流量控制 |
| Mesh | `topo_graph`, `child_mesh_infos` | Mesh 网络 |

##### xqnetwork.lua - 网络管理 API

| 功能分类 | 主要 API | 说明 |
|----------|----------|------|
| WiFi 管理 | `wifi_status`, `set_wifi`, `wifi_up/down` | WiFi 配置 |
| WAN/LAN | `wan_info`, `set_wan`, `set_lan_ip` | 网络配置 |
| DDNS | `ddns`, `ddns_switch`, `add_server` | 动态域名 |
| 无线中继 | `wifi_list`, `set_wifi_ap` | AP 模式 |
| Mesh 组网 | `scan_mesh_node`, `add_mesh_node` | Mesh 管理 |
| IPv6 | `set_wan6`, `ipv6_status` | IPv6 配置 |
| MAC 过滤 | `wifi_macfilter_info`, `mac_bind` | 设备管理 |

##### xqsmarthome.lua - 智能家居 API

| API | 功能 |
|-----|------|
| `request` | 智能家居请求隧道 |
| `request_smartcontroller` | 智能控制器请求 |
| `request_miio` | MIIO 设备请求 |
| `request_mitv` | 小米电视请求 |
| `request_yeelink` | Yeelink 设备请求 |
| `request_camera` | 摄像头请求 |

---

#### 4.2.4 安全模块

##### anti_attack - 防攻击模块

| API | 功能 |
|-----|------|
| `get_status` | 获取防攻击状态 |
| `set_rpfilter` | 设置反向路径过滤 |
| `set_dos` | 设置 DoS 防护 |
| `set_scan` | 设置端口扫描防护 |

##### config_scan - 配置扫描模块

| API | 功能 |
|-----|------|
| `overview` | 获取扫描概览 |
| `config` | 配置扫描项 |
| `start` | 启动扫描 |
| `get_status` | 获取扫描状态 |
| `stop` | 停止扫描 |

##### url_fw - URL 防火墙

| API | 功能 |
|-----|------|
| `update_status` / `get_status` | 防火墙状态管理 |
| `show_policy` / `update_policy` | URL 分类策略 |
| `show_whitelist` / `add_whitelist` | 白名单管理 |

---

### 4.3 Model 层 (数据模型)

#### 4.3.1 uci.lua - UCI 配置接口扩展

**功能定位**：扩展 UCI cursor 的功能，提供批量操作和类型转换。

**主要功能**：
| 函数 | 说明 |
|------|------|
| `delete_all(config, type, comparator)` | 批量删除配置节 |
| `tset(config, section, values)` | 批量设置配置值 |
| `get_bool(config, section, option)` | 获取布尔值 |
| `get_list(config, section, option)` | 获取列表值 |
| `set_list(config, section, option, value)` | 设置列表值 |
| `apply(configlist)` | 应用配置并重载服务 |

**布尔值识别规则**：
- 识别为 `true` 的值：`"1"`, `"true"`, `"yes"`, `"on"`

---

#### 4.3.2 network.lua - 网络数据模型

**类层次结构**：
| 类 | 说明 |
|----|------|
| `protocol` | 网络协议基类 |
| `interface` | 网络接口类 |
| `wifidev` | 无线设备类 |
| `wifinet` | 无线网络类 |

**默认协议**：
| 协议 | 说明 |
|------|------|
| static | 静态地址配置 |
| dhcp | DHCP 客户端 |
| none | 未管理接口 |

**接口类型**：
- wifi（无线）、bridge（网桥）、tunnel（隧道）
- vlan（VLAN）、switch（交换机）、ethernet（以太网）

---

#### 4.3.3 firewall.lua - 防火墙数据模型

**类层次结构**：
| 类 | 说明 |
|----|------|
| `defaults` | 防火墙默认设置 |
| `zone` | 防火墙区域 |
| `forwarding` | 区域间转发 |
| `rule` | 防火墙规则 |
| `redirect` | 端口重定向/NAT |

**默认策略**：
| 策略 | 说明 |
|------|------|
| ACCEPT | 接受流量 |
| REJECT | 拒绝（返回错误） |
| DROP | 丢弃（静默） |

---

### 4.4 View 层 (视图模板)

#### 4.4.1 模板目录结构

```
view/
├── web/                   # Web 管理界面
│   ├── index.htm          # 主页
│   ├── sysauth.htm        # 登录页
│   ├── inc/               # 公共组件
│   │   ├── header.htm     # 页头
│   │   ├── footer.htm     # 页脚
│   │   ├── nav_set.htm    # 导航
│   │   └── g.js.htm       # 全局 JS
│   ├── init/              # 初始化向导
│   ├── setting/           # 系统设置
│   └── box/               # 扩展功能
├── diagnosis/             # 网络诊断
├── firewall/              # 防火墙配置
└── themes/                # 主题模板
```

#### 4.4.2 扩展功能模块 (Box)

每个扩展功能包含以下文件：
| 文件 | 说明 |
|------|------|
| `box.lua.htm` | 后端逻辑 |
| `box.htm.htm` | HTML 模板 |
| `box.js.htm` | JavaScript 脚本 |
| `box.css.htm` | CSS 样式 |

**已实现的扩展功能**：
| 模块 | 功能 |
|------|------|
| zerotier | ZeroTier 虚拟网络 |
| filebrowser | 文件浏览器 |
| samba_set | Samba 文件共享 |
| wol | 网络唤醒 |
| uciedit | UCI 配置编辑器 |
| config_bak | 配置备份 |
| speedtest | 网速测试 |

---

## 5. 辅助模块

### 5.1 AES 加密模块 (aeslua)

**功能概述**：纯 Lua 实现的 AES 对称加密库。

**支持的特性**：
| 特性 | 说明 |
|------|------|
| 密钥长度 | AES-128、AES-192、AES-256 |
| 加密模式 | ECB、CBC、OFB、CFB |
| 性能优化 | T-Tables 和预计算表 |

**模块组成**：
| 文件 | 功能 |
|------|------|
| `aes.lua` | AES 核心算法 |
| `ciphermode.lua` | 加密模式实现 |
| `gf.lua` | 伽罗瓦域运算 |
| `buffer.lua` | 字符串缓冲区 |
| `util.lua` | 工具函数 |

**使用示例**：
```lua
local aeslua = require("aeslua")

-- 加密
local ciphertext = aeslua.encrypt(key, plaintext, keyLength, mode)

-- 解密
local plaintext = aeslua.decrypt(key, ciphertext, keyLength, mode)
```

---

### 5.2 HTTP 网络请求模块 (cURL)

**功能概述**：Lua-cURL 库的高级封装，提供完整的 HTTP 客户端功能。

**主要功能**：
- HTTP/HTTPS 请求（GET、POST、PUT、DELETE）
- 文件上传/下载
- 表单数据提交
- Cookie 管理
- 代理支持
- 多路复用并发请求
- SSL/TLS 安全连接

**对象类型**：
| 类型 | 说明 |
|------|------|
| Easy | 单个 HTTP 请求 |
| Multi | 多路复用请求 |
| Form | 表单数据 |
| Share | 共享数据 |

---

### 5.3 JSON 模块

**功能概述**：JSON 编解码和 JSON-RPC 客户端。

**主要接口**：
| 函数 | 说明 |
|------|------|
| `json.encode(value)` | 编码为 JSON |
| `json.decode(str)` | 解码 JSON |
| `json.null()` | JSON null 值 |
| `json.rpc.proxy(url)` | 创建 RPC 代理 |
| `json.rpc.call(url, method, ...)` | 直接 RPC 调用 |

---

### 5.4 日志模块 (logging)

**支持的输出方式**：
| 模块 | 功能 | 适用场景 |
|------|------|----------|
| `console` | 控制台输出 | 开发调试 |
| `file` | 文件输出 | 日志持久化 |
| `rolling_file` | 滚动文件 | 长期运行 |
| `email` | 邮件输出 | 告警通知 |
| `socket` | Socket 输出 | 集中日志 |
| `sql` | 数据库输出 | 日志分析 |

**日志级别**：DEBUG、INFO、WARN、ERROR、FATAL

---

### 5.5 配置扫描模块 (config_scan)

**功能概述**：路由器配置安全扫描系统，检测各项配置的安全性。

**安全检测项**：

| 检测项 | 说明 | 安全建议 |
|--------|------|----------|
| 固件版本 | 检测是否最新 | 保持更新 |
| 自动更新 | 检测是否启用 | 建议启用 |
| DMZ | 检测是否启用 | 建议关闭 |
| UPnP | 检测是否启用 | 建议关闭 |
| 端口映射 | 检测是否存在 | 定期审查 |
| WiFi 加密 | 检测加密方式 | 使用 WPA2/WPA3 |
| WiFi 密码 | 检测密码强度 | 使用强密码 |
| 防蹭网 | 检测是否启用 | 建议启用 |

**评分标准**：
- 总分 100 分
- 40 分及以上为安全
- 低于 40 分需要关注

---

## 6. 安全机制

### 6.1 认证机制

**会话管理**：
```lua
-- 会话存储路径
/tmp/luci-sessions/

-- 会话结构
{
    token = "session_token",
    user = "admin",
    secret = "session_secret",
    atime = timestamp
}
```

**Token 验证流程**：
```
1. 从 Cookie 或参数获取 Token
2. 读取会话文件
3. 验证会话有效性
4. 检查会话超时
5. 更新访问时间
```

### 6.2 权限控制

**权限标志位**：
```lua
-- 权限检查
local flag = node.flag or 0

-- bit 0: 允许无认证访问
if bit.band(flag, 0x01) == 0 then
    -- 需要认证
end

-- bit 1: 禁止远程访问
if bit.band(flag, 0x02) ~= 0 then
    -- 仅允许本地访问
end
```

### 6.3 安全防护措施

| 措施 | 说明 |
|------|------|
| XSS 过滤 | `XQSecureUtil` 过滤危险字符 |
| 路径遍历检测 | 阻止 `/../` 攻击 |
| 参数验证 | 检测反引号、分号、管道符 |
| nonce 防重放 | 敏感操作使用 nonce |
| 路径白名单 | 文件下载限制目录 |
| Base64 过滤 | 隧道请求过滤非法字符 |

---

## 7. 二次开发指南

### 7.1 开发环境搭建

**依赖要求**：
| 依赖 | 版本 | 说明 |
|------|------|------|
| Lua | 5.1 | 主要运行环境 |
| LuCI | - | Web 框架 |
| nixio | - | I/O 库 |
| uci | - | 配置接口 |
| ubus | - | 系统总线 |

**开发工具**：
- Lua 语法检查：`luacheck`
- 代码格式化：`lua-format`
- 调试工具：`luci.debug`

### 7.2 添加新 API

**步骤 1**：创建控制器文件

```lua
-- luci/controller/api/myapi.lua
module("luci.controller.api.myapi", package.seeall)

function index()
    -- 注册 API 入口
    local page = entry({"api", "myapi"}, firstchild(), "", 200)
    page.sysauth = "admin"
    page.sysauth_authenticator = "jsonauth"
    
    -- 注册具体 API
    entry({"api", "myapi", "hello"}, call("hello"), "", 201)
    entry({"api", "myapi", "protected"}, call("protected"), "", 202, 0x08)
end

function hello()
    local http = require("luci.http")
    http.write_json({
        code = 0,
        msg = "Hello World"
    })
end

function protected()
    local http = require("luci.http")
    local name = http.formvalue("name")
    
    if not name then
        http.write_json({
            code = 1,
            msg = "Missing parameter: name"
        })
        return
    end
    
    http.write_json({
        code = 0,
        msg = "Hello, " .. name
    })
end
```

**步骤 2**：权限配置

```lua
-- 权限标志说明
-- 0x01: 允许无认证访问
-- 0x02: 禁止远程访问
-- 0x04: 允许系统锁定时访问
-- 0x08: 需要管理员认证
-- 0x10: 需要 SDK 权限过滤

entry({"api", "myapi", "public"}, call("public"), "", 201, 0x01)  -- 公开
entry({"api", "myapi", "private"}, call("private"), "", 202, 0x08) -- 需认证
entry({"api", "myapi", "local"}, call("local"), "", 203, 0x0A)    -- 本地+认证
```

### 7.3 添加新页面

**步骤 1**：创建控制器

```lua
-- luci/controller/web/mypage.lua
module("luci.controller.web.mypage", package.seeall)

function index()
    local page = entry({"web", "mypage"}, template("web/mypage/index"), "My Page", 300)
    page.sysauth = "admin"
    page.sysauth_authenticator = "htmlauth"
end
```

**步骤 2**：创建模板

```html
<!-- luci/view/web/mypage/index.htm -->
<%+web/inc/head%>
<%+web/inc/header%>

<div class="content">
    <h1><%:My Page%></h1>
    
    <% local sys = require("luci.sys") %>
    <p>Hostname: <%= sys.hostname() %></p>
    <p>Uptime: <%= sys.uptime() %> seconds</p>
</div>

<%+web/inc/footer%>
```

### 7.4 扩展功能开发 (Box 模块)

**步骤 1**：创建目录结构

```
luci/view/web/box/mybox/
├── box.lua.htm    # 后端逻辑
├── box.htm.htm    # HTML 模板
├── box.js.htm     # JavaScript
└── box.css.htm    # CSS 样式
```

**步骤 2**：编写后端逻辑

```html
<!-- box.lua.htm -->
<%
local http = require("luci.http")
local sys = require("luci.sys")

local action = http.formvalue("action")

if action == "get_status" then
    http.write_json({
        code = 0,
        status = "running"
    })
    return
elseif action == "start" then
    sys.exec("/etc/init.d/myservice start")
    http.write_json({
        code = 0,
        msg = "Started"
    })
    return
end
%>
```

**步骤 3**：编写 HTML 模板

```html
<!-- box.htm.htm -->
<div class="mybox-container">
    <h3>My Box</h3>
    <div id="status"></div>
    <button id="start-btn">Start</button>
</div>
```

**步骤 4**：编写 JavaScript

```html
<!-- box.js.htm -->
<script>
(function() {
    var statusEl = document.getElementById('status');
    var startBtn = document.getElementById('start-btn');
    
    function getStatus() {
        fetch('/cgi-bin/luci/web/box/mybox?action=get_status')
            .then(r => r.json())
            .then(data => {
                statusEl.textContent = data.status;
            });
    }
    
    startBtn.onclick = function() {
        fetch('/cgi-bin/luci/web/box/mybox?action=start')
            .then(r => r.json())
            .then(data => {
                alert(data.msg);
                getStatus();
            });
    };
    
    getStatus();
})();
</script>
```

### 7.5 安全检测项扩展

**步骤 1**：创建检测模块

```lua
-- config_scan/my_check.lua
module("luci.config_scan.my_check", package.seeall)

local common = require("luci.config_scan.common")

function scan()
    -- 执行检测逻辑
    local result = 0  -- 0=不安全, 1=安全
    
    -- 检测逻辑...
    local uci = require("luci.model.uci").cursor()
    local value = uci:get("myconfig", "section", "option")
    
    if value == "safe_value" then
        result = 1
    end
    
    return result
end

function get_info()
    return {
        name = "my_check",
        title = "My Security Check",
        description = "Check if my configuration is secure",
        category = "system"  -- system 或 wireless
    }
end
```

**步骤 2**：注册到扫描器

```lua
-- 在 config_scan/system.lua 或 wireless.lua 中添加
local my_check = require("luci.config_scan.my_check")

-- 添加到扫描项列表
table.insert(scan_items, {
    module = my_check,
    weight = 10  -- 权重分值
})
```

---

## 8. API 参考

### 8.1 常用 API 列表

#### 系统管理 API

| API | 方法 | 说明 |
|-----|------|------|
| `/api/misystem/login` | POST | 用户登录 |
| `/api/misystem/router_info` | GET | 获取路由器信息 |
| `/api/misystem/devicelist` | GET | 获取设备列表 |
| `/api/misystem/reboot` | POST | 重启路由器 |
| `/api/misystem/reset` | POST | 恢复出厂设置 |
| `/api/misystem/checkRomUpdate` | GET | 检查固件更新 |
| `/api/misystem/upgradeRom` | POST | 升级固件 |

#### 网络管理 API

| API | 方法 | 说明 |
|-----|------|------|
| `/api/xqnetwork/wifi_status` | GET | 获取 WiFi 状态 |
| `/api/xqnetwork/set_wifi` | POST | 设置 WiFi |
| `/api/xqnetwork/wan_info` | GET | 获取 WAN 信息 |
| `/api/xqnetwork/set_wan` | POST | 设置 WAN |
| `/api/xqnetwork/lan_info` | GET | 获取 LAN 信息 |
| `/api/xqnetwork/set_lan_ip` | POST | 设置 LAN IP |

### 8.2 错误码规范

| 范围 | 说明 |
|------|------|
| 0 | 成功 |
| 1-99 | 通用错误 |
| 1500-1600 | 系统相关错误 |
| 1537+ | 参数和认证错误 |

**常见错误码**：
| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 1 | 未知错误 |
| 401 | 未认证 |
| 403 | 权限不足 |
| 1537 | 参数错误 |
| 1538 | 认证失败 |
| 1539 | Token 过期 |

### 8.3 请求/响应格式

**请求格式**：
```
POST /api/misystem/login HTTP/1.1
Content-Type: application/x-www-form-urlencoded

username=admin&password=xxx&nonce=xxx
```

**响应格式**：
```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "token": "xxx",
        "url": "/web/home"
    }
}
```

---

## 9. 配置文件说明

### 9.1 UCI 配置路径

| 配置文件 | 路径 | 说明 |
|----------|------|------|
| 网络配置 | `/etc/config/network` | 网络接口配置 |
| 无线配置 | `/etc/config/wireless` | WiFi 配置 |
| 防火墙配置 | `/etc/config/firewall` | 防火墙规则 |
| DHCP 配置 | `/etc/config/dhcp` | DHCP 服务配置 |
| 系统配置 | `/etc/config/system` | 系统基本配置 |
| UCI 依赖 | `/etc/config/ucitrack` | 配置依赖关系 |

### 9.2 关键配置项

**网络配置示例**：
```
config interface 'wan'
    option proto 'dhcp'
    option ifname 'eth0.2'

config interface 'lan'
    option proto 'static'
    option ipaddr '192.168.31.1'
    option netmask '255.255.255.0'
```

**无线配置示例**：
```
config wifi-device 'radio0'
    option type 'mac80211'
    option channel '6'
    option hwmode '11g'

config wifi-iface
    option device 'radio0'
    option network 'lan'
    option mode 'ap'
    option ssid 'MyWiFi'
    option encryption 'psk2'
    option key 'password'
```

### 9.3 运行时路径

| 路径 | 说明 |
|------|------|
| `/tmp/luci-sessions/` | 会话存储 |
| `/tmp/luci-indexcache` | 路由缓存 |
| `/var/state/` | 运行时状态 |
| `/tmp/dhcp.leases` | DHCP 租约 |

---

## 10. 外部依赖

### 10.1 Lua 模块依赖

| 模块 | 说明 |
|------|------|
| `uci` | UCI 配置接口 |
| `ubus` | ubus 通信 |
| `nixio` | 底层 I/O |
| `posix` | POSIX 接口 |

### 10.2 小米专用模块

| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQLog` | 日志记录 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理 |
| `xiaoqiang.util.XQSecureUtil` | 安全工具 |
| `xiaoqiang.util.XQCryptoUtil` | 加密工具 |
| `xiaoqiang.util.XQDownloadUtil` | 下载工具 |
| `xiaoqiang.module.XQFirewall` | 防火墙模块 |
| `xiaoqiang.module.XQTopology` | 网络拓扑 |
| `xiaoqiang.module.XQPredownload` | 预下载模块 |

### 10.3 系统工具依赖

| 工具 | 说明 |
|------|------|
| `uhttpd` | Web 服务器 |
| `uci` | UCI 命令行工具 |
| `ubus` | ubus 命令行工具 |
| `iwinfo` | 无线信息工具 |
| `iptables` | 防火墙工具 |

### 10.4 C 扩展模块

| 模块 | 文件 | 说明 |
|------|------|------|
| 位运算 | `bit.so` | 位运算操作 |
| JSON | `cjson.so` | 高性能 JSON |
| cURL | `lcurl.so` | HTTP 客户端 |
| RSA | `librsa.so` | RSA 加密 |
| SQLite3 | `lsqlite3.so` | 数据库 |
| 无线信息 | `iwinfo.so` | WiFi 信息 |
| 模板解析 | `parser.so` | 模板解析器 |

---

## 附录

### A. 文件命名约定

| 后缀 | 说明 |
|------|------|
| `.lua` | Lua 源代码 |
| `.lua.md` | Lua 文件说明文档 |
| `.htm` | LuCI 模板文件 |
| `.htm.md` | 模板文件说明文档 |
| `.so` | C 扩展模块 |
| `.lmo` | 国际化资源文件 |

### B. 网络模式说明

| 模式 | netMode | 说明 |
|------|---------|------|
| 路由模式 | 0 | 标准路由器模式 |
| 无线中继 | 1 | WiFi 中继模式 |
| 有线中继 | 2 | 有线 AP 模式 |
| Mesh 从设备 | 3 | Mesh 子路由 |

### C. 通信协议

| 协议 | 用途 |
|------|------|
| Thrift 隧道 | 与后端服务通信 |
| ubus | 系统总线通信 |
| MQTT | Mesh 网络节点同步 |

---

## 版权信息

本项目基于 LuCI 框架开发，LuCI 采用 Apache License 2.0 许可证。

小米路由器相关代码版权归小米公司所有。
