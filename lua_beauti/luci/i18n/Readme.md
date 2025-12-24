# LuCI i18n 国际化翻译文件目录

## 概述

本目录存放 LuCI Web 管理界面的国际化（i18n）翻译文件。这些文件采用 `.lmo`（LuCI Message Object）二进制格式，是 LuCI 特有的编译后翻译文件格式。

## 目录结构

```
i18n/
├── base.zh-cn.lmo       # 基础翻译 - 简体中文
├── base.zh-hk.lmo       # 基础翻译 - 繁体中文(香港)
├── base.zh-tw.lmo       # 基础翻译 - 繁体中文(台湾)
├── firewall.zh-cn.lmo   # 防火墙模块翻译 - 简体中文
├── firewall.zh-hk.lmo   # 防火墙模块翻译 - 繁体中文(香港)
├── firewall.zh-tw.lmo   # 防火墙模块翻译 - 繁体中文(台湾)
└── Readme.md            # 本文档
```

## 文件说明

### .lmo 文件格式

`.lmo` 文件是 LuCI 的编译后翻译文件格式，具有以下特点：

- **二进制格式**: 经过编译优化，加载速度快
- **哈希索引**: 使用哈希表快速查找翻译字符串
- **UTF-8 编码**: 翻译文本使用 UTF-8 编码存储

### 文件命名规范

```
<模块名>.<语言代码>.lmo
```

| 组成部分 | 说明 | 示例 |
|---------|------|------|
| 模块名 | 翻译所属的功能模块 | `base`, `firewall` |
| 语言代码 | ISO 语言-地区代码 | `zh-cn`, `zh-hk`, `zh-tw` |

### 翻译模块说明

| 文件前缀 | 模块 | 包含内容 |
|---------|------|---------|
| `base` | 基础模块 | 通用界面文本、系统信息、网络设置等基础翻译 |
| `firewall` | 防火墙模块 | 防火墙配置、端口转发、通信规则、区域设置等翻译 |

### 支持的语言

| 语言代码 | 语言 | 文件大小 |
|---------|------|---------|
| `zh-cn` | 简体中文 | base: 24B, firewall: 5.8KB |
| `zh-hk` | 繁体中文(香港) | base: 29.9KB, firewall: 5.8KB |
| `zh-tw` | 繁体中文(台湾) | base: 32.1KB, firewall: 5.8KB |

> 注: `base.zh-cn.lmo` 文件较小可能是因为简体中文为默认语言或该文件仅包含差异翻译。

## 工作原理

### 加载流程

1. **语言检测**: 系统根据用户设置或浏览器语言确定目标语言
2. **目录加载**: `luci.i18n.setlanguage()` 调用 C 模块加载对应的 `.lmo` 文件
3. **回退机制**: 如果指定语言不存在，尝试加载父语言（如 `zh-cn` 回退到 `zh`）

### 翻译查找

```lua
-- 设置语言
luci.i18n.setlanguage("zh-cn")

-- 获取翻译
local text = luci.i18n.translate("Firewall")  -- 返回 "防火墙"

-- 格式化翻译
local msg = luci.i18n.translatef("Port %d", 80)  -- 返回 "端口 80"
```

### 模板中使用

```html
<!-- 简单翻译 -->
<%:Firewall%>

<!-- 格式化翻译 -->
<%:Port %d%> % {port}
```

## 相关文件

| 文件路径 | 说明 |
|---------|------|
| `luci/i18n.lua` | i18n 模块主文件，提供翻译 API |
| `luci/template/parser.so` | C 模块，负责加载 .lmo 文件和翻译查找 |
| `luci/dispatcher.lua` | 调度器，设置请求的语言环境 |

## 翻译内容示例

### firewall 模块翻译示例

| 原文 | 简体中文翻译 |
|------|-------------|
| Firewall | 防火墙 |
| Port Forwards | 端口转发 |
| Traffic Rules | 通信规则 |
| Custom Rules | 自定义规则 |
| Enable | 启用 |
| Enable NAT loopback | 启用NAT环回 |
| Enable SYN-flood defense | 启用SYN-flood防御 |
| Source zone | 源区域 |
| Destination zone | 目标区域 |
| Internal IP address | 内部IP地址 |
| External port | 外部端口 |
| Match ICMP type | 匹配ICMP类型 |
| IPv4 and IPv6 | IPv4 和 IPv6 |

## 开发说明

### 生成 .lmo 文件

`.lmo` 文件通常由 `.po`（Portable Object）文件编译生成：

```bash
# 使用 LuCI 提供的工具
po2lmo base.zh-cn.po base.zh-cn.lmo
```

### 添加新语言

1. 创建对应语言的 `.po` 翻译文件
2. 使用 `po2lmo` 工具编译为 `.lmo` 格式
3. 将生成的 `.lmo` 文件放入本目录

### 添加新模块翻译

1. 创建 `<模块名>.<语言代码>.po` 文件
2. 添加模块相关的翻译字符串
3. 编译并放入本目录
4. 在模块代码中使用 `translate()` 函数引用翻译

## 注意事项

1. **文件格式**: `.lmo` 是二进制文件，不能直接编辑，需要修改源 `.po` 文件后重新编译
2. **编码要求**: 所有翻译文本必须使用 UTF-8 编码
3. **占位符**: 翻译中的 `%s`、`%d` 等占位符必须与原文保持一致
4. **HTML 标签**: 翻译中可能包含 HTML 标签（如 `<em>`、`<var>`），需保持标签完整
