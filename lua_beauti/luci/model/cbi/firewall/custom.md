# custom.lua - 防火墙自定义规则编辑器模块

## 工作原理

本模块是 LuCI CBI 框架的自定义防火墙规则编辑器，提供直接编辑 iptables 规则的界面。

**核心功能:**
- 提供自定义 iptables 规则的编辑界面
- 规则存储在 `/etc/firewall.user` 文件中
- 在系统防火墙启动时自动加载执行
- 适用于高级用户添加复杂的防火墙规则

**使用场景:**
- 添加 Web 界面不支持的高级规则
- 自定义 NAT 规则
- 特殊的流量控制规则
- 端口敲门 (Port Knocking) 等高级功能

**安全提示:**
- 错误的规则可能导致网络中断
- 修改前请备份现有规则
- 建议通过 SSH 保持连接以便恢复

**配置文件:** `/etc/firewall.user`

## 接口

### SimpleForm 配置

| 属性 | 值 | 说明 |
|------|-----|------|
| reset | false | 禁用重置按钮 |
| submit | "Save" | 提交按钮文字 |

### 规则编辑区域 (TextValue)

| 属性 | 值 | 说明 |
|------|-----|------|
| rmempty | true | 允许为空 |
| rows | 20 | 文本框行数 |

### 自定义函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| rulesTextArea.cfgvalue(self, section) | section: 配置段 | string | 从文件读取现有规则 |
| rulesTextArea.write(self, section, value) | section: 配置段, value: 规则内容 | - | 保存规则到文件，自动转换换行符 |

### 文件操作

- **读取:** `nixio.fs.readfile(CUSTOM_RULES_FILE)`
- **写入:** `nixio.fs.writefile(CUSTOM_RULES_FILE, value)`
- **换行符处理:** 将 Windows 换行符 (`\r\n`) 转换为 Unix 换行符 (`\n`)

## 外部引用

- `nixio.fs`: 文件系统操作模块
