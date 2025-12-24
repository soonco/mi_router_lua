# LuCI View 模板目录说明

本目录包含小米路由器 LuCI Web 管理界面的所有视图模板文件。模板文件使用 LuCI 模板语法，混合 HTML 和 Lua 代码。

## 目录结构概览

```
view/
├── diagnosis/          # 网络诊断模块
├── firewall/           # 防火墙配置模块
├── mipctl/             # 家长控制拦截页
├── themes/             # 主题模板
│   ├── openwrt.org/    # OpenWrt 官方主题
│   └── xiaoqiang/      # 小米路由器主题
├── url_fw/             # URL 过滤拦截页
└── web/                # Web 管理界面主模块
    ├── apsetting/      # AP 模式设置
    ├── box/            # 扩展功能模块
    ├── inc/            # 公共组件
    ├── init/           # 初始化向导
    ├── setting/        # 系统设置
    └── wan2/           # 双 WAN 配置
```

---

## 根目录文件

| 文件 | 说明 |
|------|------|
| `index.htm` | 首页重定向页面，自动跳转到 `/web/home` |
| `header.htm` | 页头模板分发器，根据主题加载对应 header |
| `footer.htm` | 页脚模板分发器，根据主题加载对应 footer |
| `error404.htm` | 404 错误页面，显示无法分发的请求路径 |
| `error500.htm` | 500 错误页面，显示服务器内部错误详情 |
| `indexer.htm` | 索引页面 |
| `zt_exc_cy.htm` | ZeroTier 异常页面（超时） |
| `zt_exc_jb.htm` | ZeroTier 异常页面（拒绝） |

---

## diagnosis/ - 网络诊断模块

### home.htm
网络诊断功能页面，自动检测网络连接状态并给出问题原因和解决方案。

**主要功能：**
- 网络拓扑图展示（设备 → 路由器 → 互联网）
- 多 WAN 诊断支持（均衡/备份模式）
- 错误码映射和解决方案提示

**错误码说明：**
| 错误码 | 说明 |
|--------|------|
| 1 | WAN 口无网线接入 |
| 2 | DHCP 服务无响应 |
| 3 | 宽带拨号服务无响应 |
| 4 | IP 冲突 |
| 5 | 网关不可达 |
| 6-7 | DNS 服务器问题 |
| 8-9 | 中继连接异常 |
| 31-36 | PPPoE 拨号相关错误 |

---

## firewall/ - 防火墙配置模块

| 文件 | 说明 |
|------|------|
| `cbi_addforward.htm` | 端口转发规则添加表单 |
| `cbi_addrule.htm` | 防火墙规则添加表单（开放端口/转发规则） |
| `cbi_addsnat.htm` | 源 NAT 规则添加表单 |

**智能端口识别：**
| 端口 | 服务 | 协议 |
|------|------|------|
| 21 | FTP | TCP |
| 22 | SSH | TCP |
| 53 | DNS | TCP+UDP |
| 80 | HTTP | TCP |
| 443 | HTTPS | TCP |
| 3389 | RDP | TCP |
| 5900 | VNC | TCP |

---

## mipctl/ - 家长控制拦截页

### home.htm
家人上网保护拦截页面，当用户访问被家长控制功能拦截的网站时显示。

**拦截原因：**
- 禁止上网时段
- 关键字过滤匹配
- 使用时长限制

---

## themes/ - 主题模板

### openwrt.org/
OpenWrt 官方主题，提供完整的页面框架、导航菜单和系统状态显示。

| 文件 | 说明 |
|------|------|
| `header.htm` | 完整页头，包含菜单、系统负载、UCI 更改提示 |
| `footer.htm` | 页脚，关闭 HTML 标签 |

### xiaoqiang/
小米路由器主题，简洁的文档声明，实际页面结构由 `web/inc/` 组件提供。

| 文件 | 说明 |
|------|------|
| `header.htm` | 简洁页头，仅包含 XHTML 文档声明 |
| `footer.htm` | 页脚，关闭 HTML 标签 |

---

## url_fw/ - URL 过滤拦截页

### home.htm
网络安全保护功能拦截页面，支持查看拦截原因和加入白名单。

**拦截策略：**
- `reject`: 自动屏蔽模式
- `alarm`: 警告模式，提供加入白名单选项

**使用的 UBUS 接口：**
| 接口 | 方法 | 说明 |
|------|------|------|
| `antiy_url` | `getSession` | 获取会话信息 |
| `antiy_url` | `getTag` | 获取 URL 分类标签 |

---

## web/ - Web 管理界面主模块

### 根目录文件

| 文件 | 说明 |
|------|------|
| `index.htm` | 路由器主页，显示网络拓扑、设备连接、WiFi 信息 |
| `sysauth.htm` | 系统登录认证页面，支持 PC/移动端自适应 |
| `topograph.htm` | Mesh 网络拓扑图页面 |
| `apindex.htm` | AP 模式首页 |
| `store.htm` | 应用商店页面 |
| `docker.htm` | Docker 管理页面 |
| `recovery.htm` | 恢复模式页面 |
| `syslock.htm` | 系统锁定页面 |
| `ieblock.htm` | IE 浏览器不支持提示页 |
| `auto_login.htm` | 自动登录页面 |

---

### web/inc/ - 公共组件

#### 页面框架组件

| 文件 | 说明 |
|------|------|
| `head.htm` | HTML 文档头部，包含 IE 兼容性处理 |
| `header.htm` | 页面导航头部，包含 Logo、菜单、用户操作 |
| `header_box.htm` | 扩展功能入口组件 |
| `footer.htm` | 页面底部，显示版本、MAC、官方链接 |
| `footermini.htm` | 简化版页脚 |
| `nav_set.htm` | 设置页导航组件 |

#### 功能组件

| 文件 | 说明 |
|------|------|
| `sysinfo.htm` | 系统信息组件 |
| `guestwifi.htm` | 访客 WiFi 组件 |
| `ipv6.htm` | IPv6 配置组件 |
| `dual-wan.htm` | 双 WAN 配置组件 |
| `password.htm` | 密码修改组件 |
| `store.htm` | 应用商店组件 |
| `devcenter.htm` | 设备中心组件 |
| `docker.htm` | Docker 组件 |

#### 高级功能组件

| 文件 | 说明 |
|------|------|
| `hwnat.htm` | 硬件 NAT 加速组件 |
| `natpro.htm` | NAT 穿透组件 |
| `qosapp.htm` | QoS 应用限速组件 |
| `meshbhmode.htm` | Mesh 回程模式组件 |
| `netmod.htm` | 网络模式组件 |
| `led-switch.htm` | LED 开关组件 |
| `temp-control.htm` | 温控组件 |
| `sfp-speed.htm` | SFP 速率组件 |
| `lan_lag.htm` | LAN 口聚合组件 |
| `game_port.htm` | 游戏端口组件 |

#### 网络检测组件

| 文件 | 说明 |
|------|------|
| `wanCheck.htm` | WAN 连接检测组件 |
| `wanspeed.htm` | WAN 速率组件 |
| `wan2_wanspeed.htm` | 双 WAN 速率组件 |

#### 协议与隐私

| 文件 | 说明 |
|------|------|
| `agreement.htm` | 用户协议（中国大陆） |
| `agreement_HK.htm` | 用户协议（香港） |
| `agreement_TW.htm` | 用户协议（台湾） |
| `agreement_KR.htm` | 用户协议（韩国） |
| `agreement_US.htm` | 用户协议（美国） |
| `privacy.htm` | 隐私政策（中国大陆） |
| `privacy_HK.htm` | 隐私政策（香港） |
| `privacy_TW.htm` | 隐私政策（台湾） |
| `privacy_KR.htm` | 隐私政策（韩国） |
| `privacy_US.htm` | 隐私政策（美国） |

#### JavaScript 组件

| 文件 | 说明 |
|------|------|
| `g.js.htm` | 全局 JavaScript 库 |
| `i18n.js.htm` | 国际化 JavaScript |
| `reboot.js.htm` | 重启功能脚本 |
| `upgrade.js.htm` | 升级功能脚本 |
| `speedtest.js.htm` | 测速功能脚本 |
| `sysinfo.js.htm` | 系统信息脚本 |
| `store.js.htm` | 应用商店脚本 |
| `wanCheck.js.htm` | WAN 检测脚本 |
| `ipv6.js.htm` | IPv6 配置脚本 |
| `dual-wan.js.htm` | 双 WAN 配置脚本 |
| `password.js.htm` | 密码修改脚本 |
| `hwnat.js.htm` | 硬件 NAT 脚本 |
| `natpro.js.htm` | NAT 穿透脚本 |
| `qosapp.js.htm` | QoS 应用脚本 |
| `meshbhmode.js.htm` | Mesh 回程脚本 |
| `netmod.js.htm` | 网络模式脚本 |
| `led-switch.js.htm` | LED 开关脚本 |
| `temp-control.js.htm` | 温控脚本 |
| `devcenter.js.htm` | 设备中心脚本 |
| `aprouterchange.js.htm` | AP 路由切换脚本 |

#### 扩展模板

| 文件 | 说明 |
|------|------|
| `xxx.lua.htm` | 后端逻辑模板 |
| `xxx.htm.htm` | HTML 模板 |
| `xxx.js.htm` | JavaScript 模板 |
| `xxx.css.htm` | CSS 模板 |

---

### web/init/ - 初始化向导

| 文件 | 说明 |
|------|------|
| `guide.htm` | 初始化向导页面 |
| `hello.htm` | 欢迎页面 |
| `bind.htm` | 账号绑定页面 |
| `agreement.htm` | 用户协议页面 |
| `privacy.htm` | 隐私政策页面 |
| `guidetoapp.htm` | 引导下载 APP 页面 |
| `guidetoapp_uninit.htm` | 未初始化时引导下载 APP |

---

### web/setting/ - 系统设置

| 文件 | 说明 |
|------|------|
| `wifi.htm` | WiFi 设置 |
| `wan.htm` | WAN 设置 |
| `lannetset.htm` | LAN 网络设置 |
| `safe.htm` | 安全设置 |
| `upgrade.htm` | 系统升级 |
| `upgrade_manual.htm` | 手动升级 |
| `qos.htm` | QoS 设置 |
| `qos_lite.htm` | 简化版 QoS |
| `nat.htm` | NAT 设置 |
| `nat_dmz.htm` | NAT/DMZ 设置 |
| `dmz.htm` | DMZ 设置 |
| `ddns.htm` | DDNS 设置 |
| `upnp.htm` | UPnP 设置 |
| `vpn.htm` | VPN 设置 |
| `iptv.htm` | IPTV 设置 |
| `dhcp_ip_mac.htm` | DHCP IP-MAC 绑定 |
| `proset.htm` | 高级设置 |
| `network_port_custom.htm` | 网络端口自定义 |

---

### web/wan2/ - 双 WAN 配置

| 文件 | 说明 |
|------|------|
| `wan2_setting.htm` | 双 WAN 设置页面 |
| `wan2_info.htm` | 双 WAN 信息页面 |
| `wan2_clone.htm` | MAC 克隆页面 |
| `wan2_wanspeed.htm` | WAN 速率设置 |
| `wan2.js.htm` | 双 WAN JavaScript |

---

### web/apsetting/ - AP 模式设置

| 文件 | 说明 |
|------|------|
| `wifi.htm` | AP 模式 WiFi 设置 |
| `wan.htm` | AP 模式 WAN 设置 |
| `lannetset.htm` | AP 模式 LAN 设置 |
| `safe.htm` | AP 模式安全设置 |
| `upgrade.htm` | AP 模式升级 |
| `roam.htm` | 漫游设置 |

---

### web/box/ - 扩展功能模块

每个扩展功能包含以下文件类型：
- `box.lua.htm` - 后端逻辑
- `box.htm.htm` - HTML 模板
- `box.js.htm` - JavaScript 脚本
- `box.css.htm` - CSS 样式

#### zerotier/ - ZeroTier 虚拟网络

提供 ZeroTier 虚拟网络服务的控制功能。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `stop_zerotier` | 停止 ZeroTier 服务 |
| `restart_zerotier` | 重启 ZeroTier 服务 |
| `join_zerotier` | 加入 ZeroTier 网络 |
| `leave_zerotier` | 离开 ZeroTier 网络 |

#### filebrowser/ - 文件浏览器

提供 FileBrowser 文件管理器的控制功能，默认运行在 18888 端口。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `filebrowser_lock` | 启用密码认证 |
| `filebrowser_unlock` | 禁用密码认证 |
| `filebrowser_start` | 启动服务 |
| `filebrowser_restart` | 重启服务 |
| `filebrowser_stop` | 停止服务 |

#### samba_set/ - Samba 文件共享

提供 Samba 文件共享服务的配置功能。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `samba_update` | 更新 root 用户密码 |
| `samba_start` | 重启 Samba 服务 |

#### wol/ - 网络唤醒

提供 Wake-on-LAN 网络唤醒功能。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `save_wol` | 保存 WOL 配置 |
| `restart_wol` | 重启 WOL 服务 |

#### uciedit/ - UCI 配置编辑器

提供 UCI 配置的搜索和批量修改功能。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `uci_search` | 搜索所有 UCI 配置 |
| `uci_save` | 批量保存 UCI 配置 |

#### config_bak/ - 配置备份

提供扩展功能配置的备份和恢复功能。

**支持的操作：**
| 操作 | 说明 |
|------|------|
| `conf_bak` | 单个配置备份 |
| `conf_bak_all` | 批量配置备份 |
| `conf_rec` | 单个配置恢复 |
| `conf_rec_all` | 批量配置恢复 |

**备份路径：** `/mnt/sda/mi_bak/`

#### speedtest/ - 网速测试

通过 ttyd 终端工具执行网速测试脚本，使用端口 37635。

#### broadband/ - 宽带检测

宽带连接检测功能。

#### template/ - 扩展模板

扩展功能的模板文件。

---

## 常用 Lua 模块

| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具（硬件信息、ROM 版本等） |
| `xiaoqiang.util.XQWifiUtil` | WiFi 工具 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.XQCountryCode` | 国家代码处理 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `xiaoqiang.module.XQTopology` | 网络拓扑 |
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |
| `luci.dispatcher` | 路由分发器 |
| `luci.model.uci` | UCI 配置管理 |
| `luci.model.firewall` | 防火墙配置模型 |
| `luci.model.network` | 网络配置模型 |
| `luci.i18n` | 国际化支持 |

---

## LuCI 模板语法

| 语法 | 说明 |
|------|------|
| `<% ... %>` | Lua 代码块 |
| `<%- ... %>` | Lua 代码块（去除前后空白） |
| `<%= ... %>` | 输出表达式 |
| `<%: ... %>` | 国际化文本输出 |
| `<%+ ... %>` | 包含其他模板 |
| `<%# ... %>` | 注释 |

---

## 网络模式说明

| 模式 | netMode | 说明 |
|------|---------|------|
| 路由模式 | 0 | 标准路由器模式 |
| 无线中继 | 1 | WiFi 中继模式 |
| 有线中继 | 2 | 有线 AP 模式 |
| Mesh 从设备 | 3 | Mesh 子路由 |

---

## 文件命名约定

- `.htm` - LuCI 模板文件
- `.htm.md` - 对应模板的说明文档
- `.bak` - 备份文件
- `box.lua.htm` - 扩展功能后端逻辑
- `box.htm.htm` - 扩展功能 HTML 模板
- `box.js.htm` - 扩展功能 JavaScript
- `box.css.htm` - 扩展功能 CSS 样式
