# box.js.htm - 配置备份JavaScript逻辑

## 文件作用
提供配置备份功能的前端交互逻辑，支持单个和批量备份/恢复操作。

## 全局变量
| 变量 | 说明 |
|------|------|
| `config_bak_update` | 更新锁，防止并发请求 |
| `config_bak_box_id` | 当前操作的容器 ID |
| `config_bak_index` | 当前处理的索引 |
| `config_bak_names` | 待处理的配置名称列表 |
| `interval` | 定时器 ID |

## 核心函数

### butt_click(obj)
按钮点击处理函数：
1. 根据按钮 ID 判断操作类型（备份/恢复，单个/全部）
2. 收集需要处理的配置名称
3. 启动定时器执行批量操作

### xxxbak_call(exec, value)
执行备份/恢复操作：
1. 检查更新锁，防止并发
2. 显示当前进度 `[当前/总数]`
3. 发送 AJAX 请求到后端
4. 处理完成后更新索引
5. 全部完成后刷新页面

## 页面原理

### 操作流程
1. 用户点击按钮触发 `butt_click()`
2. 收集待处理项目列表
3. 每秒执行一次 `xxxbak_call()`
4. 显示实时进度
5. 完成后调用 `update_xxx_box()` 刷新

### 取消机制
设置 `index=99999999999999999` 触发取消逻辑

### 请求格式
```javascript
ajaxPost('<%=REQUEST_URI%>?mac='+exec+'&name='+btoa(encodeURIComponent(name)), {}, callback)
```
- `mac`: 操作类型
- `name`: Base64 编码的配置名称

## 依赖关系
- `ajaxPost()` - AJAX 请求函数
- `btoa()` - Base64 编码
- `update_xxx_box()` - 页面刷新函数
