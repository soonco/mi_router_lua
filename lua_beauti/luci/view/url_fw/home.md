# home.htm - URL过滤拦截页面

## 文件作用
当用户访问被小米路由器网络安全保护功能拦截的网站时显示此页面，支持查看拦截原因和加入白名单。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `ubus` | 系统总线通信 |
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |

### UBUS 接口
| 接口 | 方法 | 说明 |
|------|------|------|
| `antiy_url` | `getSession` | 获取会话信息 |
| `antiy_url` | `getTag` | 获取URL分类标签 |
| `uci` | `get` | 读取UCI配置 |

### 后端接口
| 接口 | 说明 |
|------|------|
| `api/url_fw/add_whitelist` | 添加白名单 |

## 页面原理

### 拦截策略
根据 `policy` 配置显示不同的拦截页面：
- **reject**: 自动屏蔽模式，显示被屏蔽提示
- **alarm**: 警告模式，显示危险警告并提供加入白名单选项

### 数据获取流程
1. 从 HTTP 环境获取被拦截的 URL
2. 通过 UBUS 获取 URL 分类会话
3. 查询 URL 的安全标签
4. 读取 UCI 配置获取标签名称和策略

## 依赖关系
- `web/inc/head` - 页面头部
- `web/inc/footer` - 页面尾部
- `url_fw/css/url_fw.css` - 拦截页样式
- jQuery 库

## 关键代码说明

### 白名单功能
```javascript
$("body").on("click", ".enteryButton", function() {
    $.ajax({
        url: 'api/url_fw/add_whitelist',
        data: {url:'<%=url%>', session:'<%=session%>'},
        success: function(rsp) {
            if(rsp.code === 0) {
                window.location.reload();
            }
        }
    });
});
```
用户点击"加入白名单"后，调用后端接口添加白名单并刷新页面。

### 响应式字体
```javascript
html[0].style.fontSize = window.screen.width/10+"px"
```
根据屏幕宽度动态设置根字体大小，实现移动端适配。
