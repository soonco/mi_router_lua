# box.js.htm - 文件浏览器JavaScript逻辑

## 文件作用
提供 FileBrowser 文件管理器的前端交互逻辑，处理按钮点击事件。

## 全局变量
| 变量 | 说明 |
|------|------|
| `update` | 更新锁，防止重复点击 |

## 核心函数

### filebrowser_butt_click(obj)
按钮点击处理函数，根据按钮文本执行不同操作：

| 按钮文本 | 请求参数 | 说明 |
|----------|----------|------|
| 加密 | filebrowser_lock | 启用密码认证 |
| 免密 | filebrowser_unlock | 禁用密码认证 |
| 开启 | filebrowser_start | 启动服务 |
| 重启 | filebrowser_restart | 重启服务 |
| 关闭 | filebrowser_stop | 停止服务 |

## 页面原理

### 操作流程
1. 检查 `update` 锁，防止重复操作
2. 设置锁为 1
3. 发送 AJAX 请求到后端
4. 显示操作结果（alert）
5. 刷新页面内容
6. 释放锁

### 防重复机制
```javascript
if (update==0) {
    update=1;
    // 执行操作
    update=0;
} else {
    alert("繁忙中,请等待...");
}
```

## 依赖关系
- `ajaxPost()` - AJAX 请求函数
- `update_xxx_box()` - 页面刷新函数
- `alert()` - 消息提示
