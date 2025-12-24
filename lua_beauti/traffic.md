# traffic.lua - 流量解码与设备管理模块

## 工作原理

本模块是小米路由器流量统计守护进程（trafficd）的 Lua 接口，提供设备识别、主机名获取、网络接口管理、WiFi 配对验证等功能。

主要功能：
- **设备识别**: 根据 MAC 地址识别设备类型和名称
- **主机名获取**: 优先级为用户昵称 > 设备识别名 > DHCP 名称 > MAC 地址
- **网络接口管理**: 获取 WAN/LAN 口设备名称
- **AP 模式支持**: 获取 AP 模式下的硬件地址
- **ECOS 配对验证**: 处理 WiFi 配对验证请求

## 接口

### 初始化函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_hostname_init()` | 无 | 无 | 初始化主机名获取功能 |

### 设备信息函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_hostname(macAddress)` | MAC 地址 | 主机名或 MAC | 获取设备主机名 |
| `get_wan_dev_name()` | 无 | 设备名称 | 获取 WAN 口设备名 |
| `get_lan_dev_name()` | 无 | 设备名称 | 获取 LAN 口设备名 |
| `get_ap_hw()` | 无 | MAC 地址或 nil | 获取 AP 模式硬件地址 |

### 系统信息函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `get_description()` | 无 | 路由器信息表 | 获取路由器描述信息 |
| `get_version()` | 无 | 版本号字符串 | 获取 ROM 版本号 |

### 工具函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `cmdfmt(inputStr)` | 输入字符串 | 转义后字符串 | 命令格式化，防止注入 |
| `trafficd_lua_done()` | 无 | 无 | 通知 trafficd 完成处理 |

### 配对验证函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `trafficd_lua_ecos_pair_verify(requestData)` | 请求数据 | 配对信息 | ECOS 配对验证 |

### 模块级变量

| 变量 | 说明 |
|------|------|
| `deviceUtil` | 设备工具模块引用 |
| `equipmentUtil` | 设备信息模块引用 |
| `deviceInfoDB` | 设备信息数据库 |
| `dhcpDict` | DHCP 分配记录字典 |

## 外部引用

| 模块 | 说明 |
|------|------|
| `ubus` | ubus 通信库 |
| `json` | JSON 编解码 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具模块 |
| `xiaoqiang.XQEquipment` | 设备信息模块 |
| `xiaoqiang.util.XQSysUtil` | 系统工具模块 |
