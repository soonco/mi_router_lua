## 项目概述

这是一个小米路由器（MiWiFi）的 LuCI Web 管理界面项目，包含约 **200+ Lua 文件** 和 **160+ HTM 模板文件**。

## 执行计划

### 阶段 1: 核心框架模块 (luci/)
为以下核心文件生成文档：
- `luci/init.lua` - 框架初始化
- `luci/dispatcher.lua` - URL 路由分发
- `luci/http.lua` - HTTP 请求处理
- `luci/template.lua` - 模板引擎
- `luci/util.lua` - 工具函数
- `luci/json.lua` - JSON 处理
- `luci/sys.lua` - 系统调用
- `luci/fs.lua` - 文件系统操作
- `luci/i18n.lua` - 国际化
- `luci/sauth.lua` - 会话认证
- 其他核心模块...

### 阶段 2: API 控制器 (luci/controller/api/)
- `xqsystem.lua` - 系统 API
- `xqnetwork.lua` - 网络 API
- `xqpassport.lua` - 认证 API
- `misystem.lua` - 小米系统 API
- 其他 API 控制器...

### 阶段 3: 业务模块 (xiaoqiang/)
- `xiaoqiang/common/` - 通用配置和函数
- `xiaoqiang/module/` - 业务功能模块（WiFi、防火墙、QoS等）
- `xiaoqiang/util/` - 工具类

### 阶段 4: 工具库
- `aeslua/` - AES 加密库
- `socket/` - Socket 网络库
- `cURL/` - HTTP 客户端
- `ssl/` - SSL/TLS 支持
- `miqos/` - QoS 服务质量
- `sec_center/` - 安全中心
- `config_scan/` - 配置扫描

### 阶段 5: 视图模板 (luci/view/)
- `web/` - Web 页面模板
- `web/setting/` - 设置页面
- `web/init/` - 初始化向导
- `web/inc/` - 公共组件
- `web/box/` - 插件盒子

## 文档格式

每个 Markdown 文件将包含：

```markdown
# 文件名

## 概述
简要描述文件的用途和功能

## 工作原理
详细说明代码的工作流程和逻辑

## 接口/函数列表
| 函数名 | 参数 | 返回值 | 描述 |
|--------|------|--------|------|
| ... | ... | ... | ... |

## 外部依赖
- 依赖的模块列表
- require 的外部库

## 被引用情况
- 哪些文件引用了本模块

## 关键代码说明
重要逻辑的解释
```

## 输出位置

所有 Markdown 文件将生成在与源文件相同的目录下，文件名为 `原文件名.md`，例如：
- `luci/dispatcher.lua` → `luci/dispatcher.lua.md`
- `luci/view/web/index.htm` → `luci/view/web/index.htm.md`

## 预计工作量

- 总文件数：约 360+ 个
- 每个文件需要分析代码结构、提取接口、追踪依赖
- 将按模块分批处理，确保文档质量

## 是否继续？

确认后我将开始逐个分析文件并生成对应的 Markdown 文档。