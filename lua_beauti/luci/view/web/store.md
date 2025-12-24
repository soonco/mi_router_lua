# store.htm - 存储状态页面

## 文件作用
显示路由器存储设备的状态信息，包括磁盘使用情况、存储统计等。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |

## 页面原理

### 页面结构
1. 页面头部和导航
2. 存储状态主体内容（通过 include 引入）
3. 图表展示组件

### 图表组件
- `class.linechart.js` - 折线图组件
- `class.pie.js` - 饼图组件

用于可视化展示存储使用情况。

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/header` - 导航头部
- `web/inc/store` - 存储状态内容
- `web/inc/footer` - 页面尾部
- `web/inc/g.js` - 全局 JavaScript
- `web/inc/store.js` - 存储页脚本
- `web/js/class.linechart.js` - 折线图
- `web/js/class.pie.js` - 饼图
- `web/css/bc.css` - 基础样式
- `web/css/store.css` - 存储页样式

## 功能说明
此页面主要用于带有存储功能的路由器型号（如带硬盘的小米路由器），展示：
- 硬盘总容量和已用空间
- 各类文件占用比例
- 存储健康状态
