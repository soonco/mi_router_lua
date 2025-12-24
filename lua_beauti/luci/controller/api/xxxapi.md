# xxxapi.lua - 第三方扩展工具箱API模块

## 概述

`xxxapi.lua` 是一个第三方扩展工具箱 API 模块，提供了丰富的系统管理、配置编辑和插件管理功能。该模块主要用于小米路由器的高级管理和自定义扩展，支持 UCI 配置编辑、OPKG 包管理、Docker 容器管理等功能。

**模块路径**: `luci.controller.api.xxxapi`  
**API 基础路径**: `/api/xxxapi/*`  
**认证方式**: JSON 认证 (`jsonauth`)，需要管理员权限  
**代码行数**: ~1230 行

## 工作原理

1. **配置管理**: 通过 UCI 命令直接操作路由器配置文件
2. **插件系统**: 支持自定义插件的安装、卸载、启动、停止
3. **文件操作**: 提供配置文件的读取和保存功能
4. **系统监控**: 获取系统资源使用情况（CPU、内存、磁盘）

## 功能模块

| 模块 | 说明 |
|-----|------|
| 系统信息 | CPU、内存、磁盘、进程信息 |
| UCI 配置 | network、wireless、dhcp、firewall 配置管理 |
| OPKG 管理 | 软件包安装、卸载、列表 |
| 插件管理 | 自定义插件的生命周期管理 |
| 路由管理 | 静态路由配置 |
| 终端执行 | 命令行执行接口 |

## 接口列表

### 系统信息 API

#### get_info()
**功能**: 获取系统综合信息

**返回值**: JSON 格式的系统信息，包含：
- WAN 流量统计
- 系统信息（uptime、load）
- CPU 使用率
- 硬件信息

---

#### sys_info()
**功能**: 获取指定类型的系统信息

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| name | string | 是 | 信息类型：cpu/ram/df/cgroup/pro/ip/sys |

**返回值**: 对应类型的系统信息文本

---

#### get_disk_info_html()
**功能**: 获取磁盘信息 HTML

**返回值**: 
```json
{
  "code": 1,
  "msg": "Base64编码的HTML内容"
}
```

包含：
- 插件目录使用情况
- 系统内存使用情况
- 虚拟内存使用情况
- 临时空间使用情况

---

### UCI 配置管理 API

#### get_network()
**功能**: 获取网络接口配置列表

**返回值**:
```json
{
  "list": [
    {
      "network_class": "interface",
      "network_addr": "192.168.31.1",
      "network_cname": "lan",
      "network_ifname": "eth0",
      "network_proto": "static",
      "network_netmask": "255.255.255.0"
    }
  ]
}
```

---

#### network_form_sub()
**功能**: 网络接口配置表单提交

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| type | string | 是 | 操作类型：新增/保存/删除 |
| network_cname | string | 是 | 配置节名称 |
| network_name | string | 是 | 新名称 |
| network_addr | string | 否 | IP 地址 |
| network_ifname | string | 否 | 接口名称 |
| network_netmask | string | 否 | 子网掩码 |
| network_macaddr | string | 否 | MAC 地址 |

---

#### get_wireless()
**功能**: 获取无线配置列表

**返回值**:
```json
{
  "list": [
    {
      "wireless_class": "wifi-iface",
      "wireless_ssid": "WiFi名称",
      "wireless_key": "密码",
      "wireless_device": "wifi0",
      "wireless_network": "lan"
    }
  ]
}
```

---

#### wireless_form_sub()
**功能**: 无线配置表单提交

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| type | string | 是 | 操作类型 |
| wireless_cname | string | 是 | 配置节名称 |
| wireless_ssid | string | 否 | WiFi 名称 |
| wireless_key | string | 否 | 密码 |
| wireless_device | string | 否 | 设备 |
| wireless_network | string | 否 | 网络 |
| wireless_hidden | string | 否 | 是否隐藏 |

---

#### get_dhcp()
**功能**: 获取 DHCP 配置列表

#### dhcp_form_sub()
**功能**: DHCP 配置表单提交

---

#### get_firewall()
**功能**: 获取防火墙配置列表

#### firewall_zone_form_sub()
**功能**: 防火墙区域配置表单提交

#### firewall_rule_form_sub()
**功能**: 防火墙规则配置表单提交

---

### 路由管理 API

#### get_route()
**功能**: 获取路由表

**返回值**: `route` 命令输出

---

#### route_form_sub()
**功能**: 路由配置表单提交

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| type | string | 是 | 操作类型：新增/保存/删除 |
| route_Destination | string | 是 | 目标网络 |
| route_Gateway | string | 否 | 网关 |
| route_Genmask | string | 否 | 子网掩码 |
| route_Metric | string | 否 | 跃点数 |

---

### OPKG 包管理 API

#### get_opkg_list()
**功能**: 获取已安装软件包列表

**返回值**: JSON 格式的包名和版本映射

---

#### get_opkg_all_list()
**功能**: 获取所有可用软件包列表

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| opkg_abcef_butt_set | string | 是 | 首字母过滤 |

---

#### opkg_exc()
**功能**: 执行 OPKG 命令

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| opkg_exc | string | 是 | OPKG 操作（install/remove/update）|
| opkg_name | string | 是 | 包名 |

---

#### set_opkg_path()
**功能**: 设置 OPKG 安装路径

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| opkg_path | string | 是 | 安装路径 |

---

### 插件管理 API

#### xxx_json()
**功能**: 获取插件列表 JSON

**返回值**: 插件列表，包含端口状态检测

---

#### box_load()
**功能**: 加载插件箱数据

**返回值**: 完整的插件信息，包含：
- 安装状态
- 运行状态
- 自启状态
- 文件大小
- 存储位置
- Docker 容器状态

---

#### box_exec()
**功能**: 执行插件操作

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| exec_name | string | 是 | 操作名称 |
| box_name | string | 是 | 插件名称 |

**支持的操作**:
- `install` - 安装插件
- `uninstall` - 卸载插件
- `start` - 启动插件
- `stop` - 停止插件
- `enable` - 启用自启
- `disable` - 禁用自启
- `update` - 更新插件
- `down_install` - 下载并安装
- `del_tar` - 删除安装包

---

### 命令执行 API

#### ssh_exec()
**功能**: 执行 Shell 命令

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| exec | string | 是 | Base64 编码的命令 |

---

#### xxx_exec()
**功能**: 执行预定义操作

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| xxx_save_id | number | 是 | 操作 ID |

**操作 ID 映射**:
- 1: OPKG 更新
- 2: 挂载所有分区
- 3: 执行自启脚本
- 4: 执行用户自定义脚本
- >9999: 执行自定义命令

---

### 文件操作 API

#### xxx_save()
**功能**: 保存配置文件

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| xxx_save_id | number | 是 | 文件 ID |
| xxx_base64 | string | 是 | Base64 编码的文件内容 |

**文件 ID 映射**:
- 1: xxx.json（插件数据）
- 2: user_auto.sh（开机自启）
- 3: distfeeds.conf（OPKG 源）
- 4: fstab（挂载配置）
- 5: auto_start.sh（硬盘自启）

---

#### net_save()
**功能**: 保存网络配置更改

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| butt | string | 是 | 操作：ok/no |
| name | string | 是 | 配置名称 |
| data | string | 是 | Base64 编码的配置数据 |

---

### 其他 API

#### get_dhcp_mac()
**功能**: 获取 DHCP 租约的 MAC 地址列表

**返回值**: JSON 格式的 MAC 地址列表

---

#### get_xjc()
**功能**: 获取网页资源文件

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| p | string | 是 | 文件路径 |

---

#### xxxboxfunc()
**功能**: 工具箱功能控制

**参数**:
| 参数名 | 类型 | 必填 | 说明 |
|-------|------|-----|------|
| enabled | string | 是 | 功能类型：self/uninstall |
| state | string | 是 | 状态：start/stop |

## 工具函数

### Str_Cut(str, s_begin, s_end)
**功能**: 截取字符串中间部分

### base64_enc(data)
**功能**: Base64 编码

### base64_dec(data)
**功能**: Base64 解码

### urlDecode(s)
**功能**: URL 解码

### file_exists(name)
**功能**: 检查文件是否存在

### getbackc(divwidth)
**功能**: 根据使用率返回颜色值

## 外部依赖

| 模块 | 说明 |
|-----|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |
| `json` | JSON 编解码 |
| `cjson` | 高性能 JSON 编解码 |
| `luci.fs` | 文件系统操作 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
| `xiaoqiang.util.XQErrorUtil` | 错误处理 |

## 配置文件路径

| ID | 文件路径 | 说明 |
|----|---------|------|
| 1 | `{xxx_path}/xxxweb/xxx.json` | 插件数据文件 |
| 2 | `{xxx_path}/xxxcon/user_auto.sh` | 开机自启脚本 |
| 3 | `/etc/opkg/distfeeds.conf` | OPKG 源配置 |
| 4 | `/etc/fstab` | 挂载配置 |
| 5 | `/mnt/docker_disk/auto_start.sh` | 硬盘自启脚本 |
| 6 | `{xxx_path}/xxxcon/box_list.json` | 插件列表 |

## 被引用情况

该模块是第三方扩展工具箱的核心 API，主要被以下场景使用：
- 工具箱 Web 管理界面
- 插件管理系统
- 高级配置编辑器
- 系统监控面板

## 关键代码说明

### 插件状态检测
```lua
-- 检测程序端口状态
local allstr = luci.sys.exec("echo `/bin/netstat -anp | awk '{print $4}' | grep : | awk '{print $0\"P \"}'`")
for i = 1, # xxx_list["xxx"], 1 do
    if xxx_list["xxx"][i]["class"] == "box" then
        url_prot = Str_Cut(url_arr[2], ":", "/")
        if string.find(allstr, ":" .. url_prot .. "P") then
            xxx_list["xxx"][i]["tag"] = url_prot  -- 端口已监听
        else
            xxx_list["xxx"][i]["tag"] = 0  -- 端口未监听
        end
    end
end
```

### Docker 容器状态检测
```lua
if box_list["box"][i]["class"]=="dockerd" then
    is_install = luci.sys.exec("cat /tmp/tmp/.dockerps | awk '{print $2}' | grep "..str.." >/dev/null && echo -n true || echo -n false")
    is_run = luci.sys.exec("cat /tmp/tmp/.dockerps | sed -n '"..is_run_int.."p' | awk '{print $5 $6 $7 $8 $9}' | grep Up >/dev/null && echo -n true || echo -n false")
end
```

### UCI 配置操作
```lua
function network_form_sub()
    if rtype == "新增" then
        luci.sys.exec("sh -c \"$(uci show "..cname2.." | sed 's/"..cname2.."/network."..name.."/g' | sed 's/^/uci set /')\"")
        luci.sys.exec("sh -c \"$(uci set network."..name..".ipaddr='"..addr.."')\"")
    elseif rtype == "保存" then
        luci.sys.exec("sh -c \"$(uci set network."..name..".ipaddr='"..addr.."')\"")
    elseif rtype == "删除" then
        luci.sys.exec("uci delete network."..cname)
    end
    luci.http.write(luci.sys.exec("uci changes"))
end
```

## 安全注意事项

1. 该模块提供了强大的系统管理功能，包括命令执行接口
2. 所有 API 都需要管理员认证
3. 部分功能（如 `ssh_exec`）允许执行任意命令，存在安全风险
4. 建议仅在受信任的网络环境中使用
