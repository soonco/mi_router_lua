# home.htm - 网络诊断页面

## 文件作用
提供路由器网络诊断功能的完整页面，自动检测网络连接状态并给出问题原因和解决方案。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.util.XQSysUtil` | 系统工具，获取硬件信息、ROM版本等 |
| `xiaoqiang.util.XQLanWanUtil` | LAN/WAN 工具，获取 MAC 地址 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `xiaoqiang.XQCountryCode` | 国家代码处理 |

### 后端接口
| 接口 | 说明 |
|------|------|
| `api/xqnetdetect/nettb2` | 网络诊断主接口 |
| `api/misystem/get_ps_service` | 获取多WAN策略服务状态 |
| `api/misystem/r_ip_conflict` | 修复IP冲突 |

## 页面原理

### 诊断流程
1. 页面加载时获取多WAN策略配置
2. 调用 `nettb2` 接口执行网络诊断
3. 根据诊断结果渲染对应的错误信息和解决方案

### 错误码映射
- **1**: WAN口无网线接入
- **2**: DHCP服务无响应
- **3**: 宽带拨号服务无响应
- **4**: IP冲突
- **5**: 网关不可达
- **6-7**: DNS服务器问题
- **8-9**: 中继连接异常
- **31-36**: PPPoE拨号相关错误

### 多WAN支持
- 均衡模式：显示所有WAN诊断结果
- 备份模式：有一路通则通
- 单WAN模式：仅显示指定WAN

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/g.js` - 全局 JavaScript 库
- `web/inc/footer` - 页面尾部
- `diagnosis/css/diagnosis.css` - 诊断页样式

## 关键代码说明

### 网络拓扑图
使用 CSS 动画展示设备 → 路由器 → 互联网的连接状态，通过动态修改 class 显示连接成功/失败。

### 响应式设计
```javascript
var isMobile = function(){
    return navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i)
};
```
根据设备类型选择不同的结果模板（桌面版/移动版）。
