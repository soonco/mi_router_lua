# index.lua - Web 管理界面控制器模块

## 工作原理

小米路由器 Web 管理界面模块，提供路由器 Web 管理界面的所有页面路由配置。根据不同的网络模式（路由器/中继/Mesh）显示不同的界面。

网络模式：
- `netModeType=0`: 路由器模式
- `netModeType=1`: 中继模式
- `netModeType=3`: Mesh 模式
- `recovery=1`: 恢复模式

## 接口

### 页面路由

#### 首页

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web` | - | 根节点，重定向到 home |
| `/web/home` | `web/index` 或 `web/apindex` | 路由器状态概览 |
| `/web/logout` | call | 登出操作 |

#### 初始化向导

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/init/hello` | call | 欢迎页面 |
| `/web/init/agreement` | `web/init/agreement` | 用户协议 |
| `/web/init/privacy` | `web/init/privacy` | 隐私政策 |
| `/web/init/guide` | `web/init/guide` | 向导模式 |
| `/web/init/guidetoapp` | `web/init/guidetoapp` | 引导 APP |
| `/web/init/bind` | `web/init/bind` | 绑定页面 |

#### 基础设置

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/setting/upgrade` | `web/setting/upgrade` | 路由手动升级 |
| `/web/setting/wifi` | `web/setting/wifi` | Wi-Fi 设置 |
| `/web/setting/wan` | `web/setting/wan` | 外网设置 |
| `/web/setting/proset` | `web/setting/proset` | 高级设置 |
| `/web/setting/lannetset` | `web/setting/lannetset` | 局域网设置 |
| `/web/setting/safe` | `web/setting/safe` | 安全中心 |

#### 高级设置

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/prosetting/dhcpipmacband` | `web/setting/dhcp_ip_mac` | DHCP 静态 IP 分配 |
| `/web/prosetting/dmz` | `web/setting/dmz` | DMZ 设置 |
| `/web/prosetting/nat` | `web/setting/nat_dmz` | 端口转发 |
| `/web/prosetting/upnp` | `web/setting/upnp` | UPnP 设置 |
| `/web/prosetting/ddns` | `web/setting/ddns` | DDNS 设置 |
| `/web/prosetting/vpn` | `web/setting/vpn` | VPN 设置 |
| `/web/prosetting/qos` | call | 智能限速 QoS |
| `/web/prosetting/iptv` | `web/setting/iptv` | IPTV 设置 |
| `/web/prosetting/networkportcustom` | `web/setting/network_port_custom` | 网口自定义（可选） |

#### 中继/AP 模式设置

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/apsetting/upgrade` | `web/apsetting/upgrade` | 中继系统信息 |
| `/web/apsetting/wan` | `web/apsetting/wan` | 中继模式切换 |
| `/web/apsetting/safe` | `web/apsetting/safe` | 中继密码设置 |
| `/web/apsetting/wifi` | call | 中继 Wi-Fi 设置 |
| `/web/apsetting/roam` | `web/apsetting/roam` | 漫游设置 |
| `/web/apsetting/lannetset` | `web/apsetting/lannetset` | 局域网设置 |

#### 存储管理（可选）

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/store/storesetting` | `web/inc/store` | 存储设置 |
| `/web/store/docker` | `web/inc/docker` | Docker 管理（可选） |

#### 系统页面

| 路径 | 模板 | 说明 |
|------|------|------|
| `/web/syslock` | `web/syslock` | 系统锁定 |
| `/web/upgrading` | `web/syslock` | 升级中 |
| `/web/login` | `web/sysauth` | 登录页面 |
| `/web/ieblock` | `web/ieblock` | IE 浏览器提示 |
| `/web/topo` | `web/topograph` | 网络拓扑 |

### 动作函数

| 函数 | 说明 |
|------|------|
| `action_apwifi()` | 中继模式 WiFi 设置页面 |
| `action_qos()` | QoS 设置页面（完整版/精简版） |
| `action_logout()` | 登出操作，销毁会话并重定向 |
| `action_hello()` | 欢迎页面，检查初始化状态 |
| `action_webinitrdr()` | Web 初始化重定向提示 |

### 认证配置

| 属性 | 值 | 说明 |
|------|-----|------|
| `sysauth` | "admin" | 需要管理员权限 |
| `sysauth_authenticator` | "htmlauth" | HTML 表单认证 |
| `mediaurlbase` | "/xiaoqiang/web" | 媒体资源基础路径 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.util` | 工具函数 |
| `luci.template` | 模板渲染 |
| `luci.dispatcher` | 路由调度 |
| `luci.sauth` | 会话认证 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
