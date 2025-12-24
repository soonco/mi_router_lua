# box.js.htm - ZeroTier JavaScript逻辑

## 文件作用
提供 ZeroTier 虚拟网络服务的前端交互逻辑。

## 全局变量
| 变量 | 说明 |
|------|------|
| `update_zerotier` | 服务操作锁 |
| `join_zerotier` | 加入操作锁 |
| `leave_zerotier` | 离开操作锁 |
| `zerotier_up` | 操作状态标记 |

## 核心函数

### up_zerotier(str, obj)
统一的操作处理函数：

| 操作类型 | 说明 |
|----------|------|
| stop_zerotier | 停止服务 |
| restart_zerotier | 重启服务 |
| join_zerotier | 加入网络 |
| leave_zerotier | 离开网络 |

## 页面原理

### 服务控制流程
1. 检查更新锁
2. 发送 AJAX 请求
3. 验证响应（检查 '前置标记'）
4. 显示操作结果
5. 刷新页面

### 网络操作流程
1. 检查对应操作锁
2. 获取网络 ID 输入值
3. Base64 编码后发送请求
4. 解析响应显示结果
5. 刷新页面

### 响应处理
```javascript
if (r.indexOf(''前置标记'')) {
    string = r.split(''前置标记'')[1];
    alert(string);
}
```

## 依赖关系
- `ajaxPost()` - AJAX 请求函数
- `btoa()` - Base64 编码
- `update_xxx_box()` - 页面刷新函数
