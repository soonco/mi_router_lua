# Controller 目录说明文档

小米路由器 LuCI 控制器模块目录，包含所有 API 接口和 Web 页面路由的定义。

## 目录结构

```
controller/
├── firewall.lua          # 防火墙控制器（空实现）
├── anti_attack/          # 防攻击模块
├── api/                  # API 接口模块（核心）
├── config_scan/          # 配置扫描模块
├── diagnosis/            # 网络诊断模块
├── dispatch/             # 调度模块
├── mipctl/               # 设备控制面板
├── sec_center/           # 安全中心
├── service/              # 内部服务模块
├── url_fw/               # URL 防火墙
└── web/                  # Web 管理界面
```

## 模块概览

### 1. 根目录模块

| 文件 | 说明 |
|------|------|
| `firewall.lua` | 防火墙控制器框架（空实现），实际功能在其他模块中 |

### 2. anti_attack - 防攻击模块

**路径**: `/api/anti_attack/*`

提供网关安全防护功能：
- 反向路径过滤（rpfilter）- 防止 IP 欺骗攻击
- DoS 防护 - 防止拒绝服务攻击
- 端口扫描防护 - 防止恶意端口扫描
- 网关安全概览 - 汇总所有安全防护状态

**主要 API**:
| 端点 | 说明 |
|------|------|
| `get_status` | 获取防攻击状态 |
| `set_rpfilter` | 设置反向路径过滤 |
| `set_dos` | 设置 DoS 防护 |
| `set_scan` | 设置端口扫描防护 |

### 3. api - API 接口模块（核心）

这是小米路由器最重要的模块目录，包含所有对外 API 接口。

#### 3.1 index.lua - API 根节点
- 定义 `/api` 路由的父节点
- 设置默认 JSON 认证方式
- 所有子 API 模块继承此认证配置

#### 3.2 cportal.lua - 强制门户
**路径**: `/api/cportal/*`

提供访客网络认证和放行功能，自动识别请求设备 MAC 地址。

#### 3.3 miats.lua - 小米增值服务
**路径**: `/api/miats/*`

提供小米增值服务相关接口：
- Token 验证
- WiFi MAC 过滤管理
- 危险设备检测
- 网络加速服务（免费/VIP）
- 广告拦截
- 游戏加速
- IPv6 加速

#### 3.4 milog.lua - 安全日志
**路径**: `/api/mi_log/*`

提供路由器安全日志管理：
- 日志开关控制
- 日志概览统计
- 日志删除和查询
- 支持风险日志(risk)、系统日志(sys)、网卡日志(nic)

#### 3.5 misns.lua - 社交网络分享
**路径**: `/api/misns/*`

提供 WiFi 共享和社交网络功能：
- WiFi 共享开关控制
- 访客 WiFi 管理
- 社交网络初始化

#### 3.6 misystem.lua - 系统管理（核心）
**路径**: `/api/misystem/*` 和 `/api/xqsystem/*`

这是最核心的系统管理 API 控制器，包含 100+ 个 API 端点：

| 功能分类 | 说明 |
|----------|------|
| 系统状态 | 设备列表、消息、路由器信息 |
| 路由器配置 | 名称设置、IP 冲突检查 |
| 路由器模式 | WiFi AP/有线 AP/普通路由模式 |
| WAN 口设置 | WAN 配置、PPPoE 状态 |
| OTA 升级 | 固件检查和升级 |
| WiFi 信道 | 信道扫描和设置 |
| Mesh 网络 | 拓扑图、子节点管理 |
| QoS | 流量控制和限速 |
| 磁盘管理 | 磁盘信息、检查、修复、格式化 |
| 防蹭网 | 状态、开关、记录 |
| 系统管理 | 日志、密码、时间 |
| 配置备份 | 备份、下载、上传、恢复 |

#### 3.7 xqdatacenter.lua - 数据中心
**路径**: `/api/xqdatacenter/*`

提供数据中心相关功能：
- 文件下载/上传（支持断点续传）
- 缩略图获取
- 设备识别
- SSH 插件管理
- 文件系统检测和修复

**安全措施**:
- 路径白名单限制
- 路径遍历检测
- 权限控制

#### 3.8 xqnetdetect.lua - 网络检测
**路径**: `/api/xqnetdetect/*`

提供网络诊断功能：
- WAN 状态检测
- 系统诊断（CPU、内存、温度、网络）
- 网速测试
- 故障排查（支持多 WAN 和 IPv6）

**诊断项目**:
| 项目 | 异常阈值 |
|------|----------|
| CPU 温度 | >70°C |
| CPU 负载 | >90% |
| 内存使用 | >90% |
| 网关丢包 | >80% |
| Ping 丢包 | >80% |

#### 3.9 xqnetwork.lua - 网络管理（核心）
**路径**: `/api/xqnetwork/*`

最核心的网络管理 API 控制器，包含 100+ 个 API 端点：

| 功能分类 | 说明 |
|----------|------|
| WiFi 管理 | 状态、详情、开关、设置 |
| WAN/LAN | 信息获取、配置设置 |
| QoS | 流量控制 |
| DDNS | 动态域名服务 |
| 无线中继 | AP 模式、信号强度 |
| Mesh 组网 | 节点扫描、添加、回程模式 |
| IPv6 | 配置和防火墙 |
| MAC 过滤 | 设备管理、绑定 |
| 信道扫描 | 扫描和设置 |

**条件性 API**（依赖硬件特性）:
- SFP 光口设置
- 多 WAN 设置
- TR-069 设置
- Docker 功能
- IoT WiFi 设置

#### 3.10 xqpassport.lua - 账号认证
**路径**: `/api/xqpassport/*`

提供小米账号相关功能：
- 小米账号登录
- 路由器绑定/解绑
- 用户信息获取
- 云端插件管理

#### 3.11 xqsmarthome.lua - 智能家居
**路径**: `/api/xqsmarthome/*`

提供智能家居控制接口：
- SmartHome 设备控制
- MIIO 设备控制
- Yeelink 智能灯控制
- 小米电视控制
- 摄像头控制

**支持的设备类型**:
| 类型 | 说明 |
|------|------|
| SmartHome | 智能家居设备 |
| SmartController | Mesh 网络下的智能控制器 |
| MIIO | 小米 IoT 平台设备 |
| Yeelink | 易来智能灯具 |
| MiTV | 小米电视 |
| Camera | 小米摄像头 |

#### 3.12 xqsystem.lua - 系统管理（核心）
**路径**: `/api/xqsystem/*`

最核心的系统管理 API 控制器（约 2400 行代码）：

| 功能模块 | API 数量 |
|----------|----------|
| 认证相关 | 4 |
| 系统初始化 | 5 |
| 密码管理 | 1 |
| 固件升级 | 10 |
| 插件管理 | 2 |
| 路由器信息 | 10 |
| 系统操作 | 5 |
| 绑定相关 | 6 |
| VPN 配置 | 6 |
| MAC 过滤 | 4 |
| 端口转发 | 10+ |
| 防火墙 | 10+ |

**条件性 API**:
- NAT Pro（端口转发高级版）
- 防火墙（SPI、DoS 防护）

#### 3.13 xqtunnel.lua - 隧道请求
**路径**: `/api/xqtunnel/*`

提供通用隧道请求转发功能，实现严格的 Base64 字符过滤防止命令注入。

#### 3.14 xxxapi.lua - 第三方扩展工具箱
**路径**: `/api/xxxapi/*`

第三方扩展工具箱 API（约 1230 行代码）：

| 功能模块 | 说明 |
|----------|------|
| 系统信息 | CPU、内存、磁盘、进程 |
| UCI 配置 | network、wireless、dhcp、firewall |
| OPKG 管理 | 软件包安装、卸载 |
| 插件管理 | 自定义插件生命周期 |
| 路由管理 | 静态路由配置 |
| 终端执行 | 命令行执行接口 |

### 4. config_scan - 配置扫描模块

**路径**: `/api/config_scanner/*`

提供路由器配置安全扫描功能：
- 异步扫描任务管理
- 支持最多 4 个并发扫描任务
- 实时跟踪扫描进度
- 自动清理超时任务

**主要 API**:
| 端点 | 说明 |
|------|------|
| `overview` | 获取扫描概览 |
| `config` | 配置扫描项 |
| `start` | 启动扫描 |
| `get_status` | 获取扫描状态 |
| `stop` | 停止扫描 |

### 5. diagnosis - 网络诊断模块

**路径**: `/diagnosis/*`

提供网络诊断页面和 API：
- WAN 口错误信息
- 网络连接问题诊断
- 技术支持信息

### 6. dispatch - 调度模块

定义 `/dispatch` 路由节点，作为跳转页面使用。

### 7. mipctl - 设备控制面板

**路径**: `/mipctl`

MIPCTL 管理界面，使用 HTML 表单认证。

### 8. sec_center - 安全中心

**路径**: `/api/sec_center/*`

安全中心入口模块，聚合各安全子模块的概览信息：
- 安全日志 (log)
- 配置扫描 (config_scanner)
- 内容过滤 (content_filter)
- 网关安全 (gateway_security)

### 9. service - 内部服务模块

#### 9.1 index.lua - 服务根节点
创建 `/service` 路由节点，配置 JSON 认证。

#### 9.2 cachecenter.lua - 缓存中心
**路径**: `/service/cachecenter/*`

通过 Thrift 隧道与缓存中心服务通信。

#### 9.3 datacenter.lua - 数据中心
**路径**: `/service/datacenter/*`

提供数据中心相关功能：
- 文件下载/上传
- 插件管理
- 存储管理
- 设备信息
- 优酷集成

#### 9.4 internal.lua - 内部服务
**路径**: `/service/internal/*`

提供内部服务接口：
- CC 游戏加速
- IPv6 加速
- 自定义 hosts 管理

### 10. url_fw - URL 防火墙

**路径**: `/api/url_fw/*`

基于安天（Antiy）URL 分类引擎的 URL 过滤防火墙：
- URL 分类策略配置
- 白名单管理
- 支持 reject/alarm/log/ignored 策略

**主要 API**:
| 端点 | 说明 |
|------|------|
| `update_status` | 更新防火墙状态 |
| `get_status` | 获取防火墙状态 |
| `show_policy` | 显示 URL 分类策略 |
| `update_policy` | 更新策略 |
| `show_whitelist` | 显示白名单 |
| `add_whitelist` | 添加白名单 |
| `del_whitelist` | 删除白名单 |

### 11. web - Web 管理界面

#### 11.1 index.lua - Web 主控制器

提供路由器 Web 管理界面的所有页面路由：

**页面分类**:

| 分类 | 说明 |
|------|------|
| 首页 | 路由器状态概览 |
| 初始化向导 | 欢迎、协议、向导、绑定 |
| 基础设置 | 升级、WiFi、WAN、高级、安全 |
| 高级设置 | DHCP、DMZ、NAT、UPnP、DDNS、VPN、QoS、IPTV |
| 中继设置 | 中继模式专用设置页面 |
| 存储管理 | 存储设置、Docker 管理 |
| 系统页面 | 锁定、升级、登录 |

**网络模式**:
| 模式 | 说明 |
|------|------|
| 0 | 路由器模式 |
| 1 | 中继模式 |
| 3 | Mesh 模式 |

#### 11.2 docker.lua - Docker 管理
**路径**: `/web/docker/*`

Docker 管理界面路由配置。

## 认证方式

| 认证器 | 说明 | 使用场景 |
|--------|------|----------|
| `jsonauth` | JSON 格式认证 | API 接口 |
| `htmlauth` | HTML 表单认证 | Web 页面 |

## 权限级别

| 级别 | 说明 |
|------|------|
| 1 | 公开接口，无需认证 |
| 8 | 需要管理员认证 |
| 9 | 公开接口，但返回敏感信息 |
| 13 | Mesh 网络相关 |
| 16 | 文件上传相关 |

## 外部依赖

### 核心依赖

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.dispatcher` | 路由调度 |
| `luci.model.uci` | UCI 配置管理 |
| `luci.template` | 模板渲染 |
| `luci.sauth` | 会话认证 |

### 小米专用模块

| 模块 | 用途 |
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

## 通信协议

| 协议 | 用途 |
|------|------|
| Thrift 隧道 | 与后端服务通信 |
| ubus | 系统总线通信 |
| MQTT | Mesh 网络节点同步 |

## 安全机制

1. **认证机制**: 所有敏感 API 需要管理员认证
2. **nonce 防重放**: 密码修改等敏感操作使用 nonce 防重放
3. **路径白名单**: 文件下载限制在特定目录
4. **路径遍历检测**: 阻止 `/../` 路径遍历攻击
5. **Base64 字符过滤**: 隧道请求过滤非法字符防止命令注入
6. **参数安全检查**: 检测危险字符（反引号、分号、管道符等）

## 错误码规范

| 范围 | 说明 |
|------|------|
| 0 | 成功 |
| 1-99 | 通用错误 |
| 1500-1600 | 系统相关错误 |
| 1537+ | 参数和认证错误 |

详细错误码请参考各模块的 `.md` 文档。
