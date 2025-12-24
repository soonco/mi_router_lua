# proto.lua - 协议工具模块

## 工作原理

LuCI 协议工具模块，提供网络协议相关的 CBI 表单选项辅助函数，主要用于处理网络接口的 MAC 地址配置。

核心功能：
1. **MAC 地址选项** - 为 CBI 表单添加 MAC 地址配置选项
2. **WiFi 网络支持** - 自动检测并处理 WiFi 网络的 MAC 地址
3. **占位符显示** - 显示当前接口的实际 MAC 地址作为占位符

## 接口

### 模块函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `opt_macaddr(section, iface, ...)` | section: CBI section<br>iface: 网络接口对象<br>...: 额外参数 | 无 | 添加 MAC 地址选项 |

### opt_macaddr 行为

| 场景 | 读取来源 | 写入目标 |
|------|----------|----------|
| WiFi 网络 | wifinet:get("macaddr") | wifinet:set("macaddr", value) |
| 普通接口 | Value.cfgvalue() | Value.write() |

### 选项属性

| 属性 | 值 | 说明 |
|------|-----|------|
| `tab` | "advanced" | 所属标签页 |
| `datatype` | "macaddr" | 数据类型验证 |
| `placeholder` | iface:mac() | 当前 MAC 地址 |

### 使用示例

```lua
local proto = require("luci.tools.proto")

-- 在 CBI 表单中添加 MAC 地址选项
function m.on_init(self)
    local iface = network_model:get_interface("eth0")
    proto.opt_macaddr(s, iface, translate("Override MAC address"))
end
```

### 方法覆盖

| 方法 | 说明 |
|------|------|
| `cfgvalue(section_id)` | 从 WiFi 网络或普通配置读取 MAC 地址 |
| `write(section_id, value)` | 写入 MAC 地址到 WiFi 网络或普通配置 |
| `remove(section_id)` | 调用 write(section_id, nil) 删除配置 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.cbi` | CBI 表单框架 |
