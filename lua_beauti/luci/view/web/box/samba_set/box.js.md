# box.js.htm - Samba设置JavaScript逻辑

## 文件作用
提供 Samba 文件共享服务配置的前端交互逻辑。

## 全局变量
| 变量 | 说明 |
|------|------|
| `update` | 更新锁，防止重复点击 |

## 核心函数

### samba_set_butt_click(obj)
按钮点击处理函数：

| 按钮文本 | 请求参数 | 说明 |
|----------|----------|------|
| 保存 | samba_update | 更新 Samba 密码 |
| 重启 | samba_start | 重启 Samba 服务 |

## 页面原理

### 保存密码流程
```javascript
pass = obj.parentNode['pass'].value
ajaxPost('<%=REQUEST_URI%>?mac=samba_update&pass='+btoa(encodeURIComponent(pass)), {}, callback)
```
1. 获取密码输入框的值
2. URL 编码后进行 Base64 编码
3. 发送 AJAX 请求到后端
4. 显示操作结果

### 重启服务流程
1. 发送重启请求
2. 显示操作结果
3. 刷新页面内容

### 防重复机制
使用 `update` 变量作为锁，防止重复点击。

## 依赖关系
- `ajaxPost()` - AJAX 请求函数
- `btoa()` - Base64 编码
- `encodeURIComponent()` - URL 编码
- `update_xxx_box()` - 页面刷新函数
