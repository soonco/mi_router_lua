# g.js.htm - 全局JavaScript模板

## 文件作用
提供小米路由器 Web 管理界面的全局 JavaScript 代码，包含核心库引入、全局变量和通用功能。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 版本信息 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.XQCountryCode` | 国家代码 |
| `xiaoqiang.common.XQFunction` | 通用函数 |
| `xiaoqiang.util.DedicatedWirelessBackhaulUtil` | 无线回程工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |

## 页面原理

### 全局变量
- `G_FEATURES`: 功能特性配置对象
- `isMesh`: 是否 Mesh 模式
- `maxMeshCount`: 最大 Mesh 节点数
- `dwb_type/dwb_status`: 无线回程状态

### 引入的库
| 库 | 说明 |
|-----|------|
| jquery-1.8.3.js | jQuery 核心库 |
| qwrap.js | QWrap 框架 |
| common.js | 通用函数 |
| raphael.js | 矢量图形库 |
| crypto-js | 加密库（SHA1/AES/SHA256） |
| valid.js | 表单验证 |
| selectbeautify.js | 下拉框美化 |
| jquery.dialog.js | 对话框组件 |
| jquery.cookie.js | Cookie 操作 |

### 下拉菜单
提供系统菜单功能：
- 修改路由器名称
- 系统升级
- 下载米家APP
- 重启/关机
- 注销

## 依赖关系
- `web/inc/i18n.js` - 国际化脚本
- `web/inc/reboot.js` - 重启功能
- 被所有主页面引入
