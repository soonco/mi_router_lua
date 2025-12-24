# index.lua - 网络诊断控制器模块

## 工作原理

提供网络诊断相关的页面和 API 接口，显示网络连接错误信息和解决方案。当用户无法访问互联网时，显示诊断建议和技术支持信息。

### 路由配置

- 认证方式：htmlauth（HTML 表单认证）
- 静态资源路径：`/xiaoqiang/diagnosis`
- 页面模板：`diagnosis/home`

## 接口

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `index()` | 无 | 无 | 注册诊断路由 |
| `action_wanerr()` | 无 | JSON | WAN 口错误信息 |
| `action_errindex()` | 无 | JSON | 错误索引页信息 |

### 页面路由

| 路径 | 处理方式 | 权限级别 | 说明 |
|------|----------|----------|------|
| `/diagnosis` | template("diagnosis/home") | 9 | 诊断首页 |
| `/diagnosis/wanerr` | call("action_wanerr") | 9 | WAN 口错误信息 |
| `/diagnosis/errindex` | call("action_errindex") | 9 | 错误索引页 |

### WAN 口错误响应

```json
{
    "code": 0,
    "data": {
        "a": "无法访问Internet",
        "b": "1、请确保WAN口已用网线连接到因特网（如入户宽带、光猫等）",
        "c": "2、请确认网线是否插紧或损坏，光猫是否连接电源",
        "d": "3、若仍然无法上网，请联系您的宽带运营商",
        "e": "小米路由器技术支持"
    }
}
```

### 错误索引响应

```json
{
    "code": 0,
    "data": {
        "a": "对不起，小米路由器出现网络连接问题无法打开网页",
        "b": "立即进行网络诊断",
        "c": "小米路由器技术支持"
    }
}
```

### 节点配置

| 属性 | 值 | 说明 |
|------|-----|------|
| `order` | 110 | 菜单排序 |
| `sysauth` | admin | 需要管理员认证 |
| `sysauth_authenticator` | htmlauth | HTML 表单认证 |
| `mediaurlbase` | /xiaoqiang/diagnosis | 静态资源基础路径 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 响应写入 |
