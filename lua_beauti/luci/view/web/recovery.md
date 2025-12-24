# recovery.htm - 安全恢复模式页面

## 文件作用
当路由器进入安全恢复模式时显示此页面，提供系统恢复选项。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |

### 关键函数
| 函数 | 说明 |
|------|------|
| `XQSysUtil.diskExist()` | 检测硬盘是否存在 |

## 页面原理

### 硬盘检测
```lua
local hasDisk = 2
if XQSysUtil.diskExist() then
    hasDisk = 1
end
```
检测路由器是否有内置硬盘，决定显示不同的恢复选项。

### 恢复模式场景
1. **有硬盘** - 显示"系统启动失败，可一键恢复"，提供 OTA 恢复按钮
2. **无硬盘** - 显示"系统启动失败，无内置硬盘"，提示重新连接硬盘

### 页面状态
- 安全恢复模式下仍可正常上网
- 提供 OTA 恢复系统选项
- 无硬盘时建议安全断电后重新连接

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/css/bc.css` - 基础样式
- `web/css/recovery.css` - 恢复页样式

## 关键代码说明

### 动态显示
```javascript
if (diskType === 1) {
    recoveryisok.show();
    diskok.show();
} else {
    recoveryiserr.show();
    diskerr.show();
}
```
根据硬盘状态显示对应的恢复选项。
