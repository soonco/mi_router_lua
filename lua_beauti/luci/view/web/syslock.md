# syslock.htm - 系统升级锁定页面

## 文件作用
系统升级过程中的锁定页面，显示下载进度、刷写状态，防止用户中断升级操作。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |

### 后端接口
| 接口 | 说明 |
|------|------|
| `api/xqsystem/upgrade_rom` | 开始下载升级包 |
| `api/xqsystem/upgrade_status` | 查询升级状态 |
| `api/xqsystem/flash_rom` | 执行刷写 |
| `api/xqsystem/flash_permission` | 清除刷写权限 |
| `api/xqsystem/cancel` | 取消升级 |

## 页面原理

### 升级状态码
| 状态码 | 说明 |
|--------|------|
| 0 | 无升级进行 |
| 3 | 正在下载 |
| 5, 11, 12 | 正在刷写/刷写完成 |
| 6 | 下载失败 |
| 7 | 磁盘空间不足 |
| 8 | 下载失败 |
| 9 | 校验失败 |
| 10 | 刷写失败 |

### 升级流程
1. **下载阶段** - 显示下载进度条
2. **刷写阶段** - 显示刷写动画和注意事项
3. **完成阶段** - 自动跳转到首页

### 页面保护
```javascript
window.onbeforeunload = function() {
    return "正在进行系统升级，请不要离开页面";
}
```
防止用户意外关闭或刷新页面。

## 依赖关系
- `web/inc/g.js` - 全局 JavaScript
- `web/css/bc.css` - 基础样式
- `web/css/syslock.css` - 升级页样式

## 关键代码说明

### 升级类型
通过 URL 参数 `flashtype` 区分：
- **download**: OTA 自动下载升级
- **upload**: 手动上传固件升级

### 降级处理
如果检测到固件降级（`downgrade=1`），显示警告提示。
