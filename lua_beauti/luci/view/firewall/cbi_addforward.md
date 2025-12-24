# cbi_addforward.htm - 端口转发规则添加表单

## 文件作用
提供添加新端口转发规则的表单界面，是 LuCI 防火墙配置的一部分。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.model.firewall` | 防火墙配置模型 |
| `luci.sys.net.ipv4_hints` | 获取网络中的 IPv4 设备提示 |

### JavaScript 函数
| 函数 | 说明 |
|------|------|
| `cbi_validate_field()` | CBI 表单字段验证 |
| `cbi_combobox_init()` | 初始化下拉组合框 |
| `cbi_bind()` | 事件绑定 |

## 页面原理

### 表单字段
| 字段 | 说明 | 验证规则 |
|------|------|----------|
| Name | 规则名称 | - |
| Protocol | 协议类型 | TCP/UDP/TCP+UDP/其他 |
| External zone | 外部区域 | 非WAN区域列表 |
| External port | 外部端口 | portrange |
| Internal zone | 内部区域 | 非LAN区域列表 |
| Internal IP | 内部IP地址 | host |
| Internal port | 内部端口 | portrange |

### 智能填充
当用户输入外部端口时，自动根据常用端口提示规则名称和协议：
- 21 → FTP (TCP)
- 22 → SSH (TCP)
- 53 → DNS (TCP+UDP)
- 80 → HTTP (TCP)
- 443 → HTTPS (TCP)
- 3389 → RDP (TCP)
- 5900 → VNC (TCP)

## 依赖关系
- `luci.model.firewall` - 防火墙模型
- CBI 框架的验证和组件库

## 关键代码说明

### 区域过滤
```lua
for _, z in ipairs(fw:get_zones()) do
    if z:name() ~= "wan" then
        izl[#izl+1] = z  -- 内部区域排除 WAN
    elseif z:name() ~= "lan" then
        ezl[#ezl+1] = z  -- 外部区域排除 LAN
    end
end
```

### IP 地址下拉框
使用 `ipv4_hints` 函数自动填充局域网内已知设备的 IP 地址列表。
