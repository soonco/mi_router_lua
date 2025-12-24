# box.lua.htm - UCI编辑器后端逻辑

## 文件作用
提供 UCI 配置编辑功能的服务端处理逻辑，支持搜索和批量修改 UCI 配置项。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `uci show` | 显示所有 UCI 配置 |
| `uci set` | 设置 UCI 配置项 |
| `uci commit` | 提交 UCI 配置更改 |

## 页面原理

### 支持的操作

#### 搜索配置 (mac=uci_search)
```lua
luci.http.write(luci.sys.exec("uci show"))
```
返回所有 UCI 配置项，供前端过滤显示。

#### 保存配置 (mac=uci_save)
1. 解码 Base64 和 URL 编码的配置文本
2. 按 `!@.@!` 分隔符拆分多个配置项
3. 逐个执行 `uci set` 和 `uci commit`

### 工具函数
- **base64_dec()**: Base64 解码
- **urlDecode()**: URL 解码

### 数据格式
配置项格式：`key=value!@.@!key2=value2!@.@!...`

## 依赖关系
- UCI 配置系统
- `uci` 命令行工具

## UCI 说明
UCI (Unified Configuration Interface) 是 OpenWrt 的统一配置接口，用于管理系统配置。
