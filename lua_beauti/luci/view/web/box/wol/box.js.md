# box.js.htm - 网络唤醒JavaScript逻辑

## 文件作用
提供 Wake-on-LAN 网络唤醒功能的前端交互逻辑。

## 全局变量
| 变量 | 说明 |
|------|------|
| `update_wol` | 更新锁，防止重复请求 |
| `wol_up` | 操作状态标记 |

## 核心函数

### up_wol(obj)
按钮点击处理函数：
1. 设置操作状态
2. 检查更新锁
3. 获取配置文本内容
4. Base64 编码后发送请求
5. 显示操作结果
6. 刷新页面

## 页面原理

### 请求格式
```javascript
ajaxPost('<%=REQUEST_URI%>?mac='+obj.id+"&wol_text="+btoa(encodeURIComponent(text)), {}, callback)
```
- `mac`: 操作类型（save_wol 或 restart_wol）
- `wol_text`: Base64 编码的配置内容

### 响应验证
检查响应中是否包含 `'前置标记'` 来判断操作是否成功。

### 防重复机制
使用 `update_wol` 变量作为锁，防止重复点击。

## 依赖关系
- `ajaxPost()` - AJAX 请求函数
- `btoa()` - Base64 编码
- `encodeURIComponent()` - URL 编码
- `update_xxx_box()` - 页面刷新函数
