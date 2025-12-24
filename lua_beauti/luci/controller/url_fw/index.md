# index.lua - URL 防火墙控制器模块

## 工作原理

小米路由器 URL 防火墙模块，提供 URL 过滤防火墙功能，基于安天（Antiy）URL 分类引擎。支持 URL 分类策略配置和白名单管理。

配置存储：
- 策略配置：`antiy_url_policy`
- 分类定义：`antiy_url_class`

## 接口

### API 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/api/url_fw/update_status` | POST | 更新防火墙状态 |
| `/api/url_fw/get_status` | GET | 获取防火墙状态 |
| `/api/url_fw/show_policy` | GET | 显示 URL 分类策略 |
| `/api/url_fw/update_policy` | POST | 更新 URL 分类策略 |
| `/api/url_fw/show_whitelist` | GET | 显示白名单 |
| `/api/url_fw/add_whitelist` | POST | 添加白名单 |
| `/api/url_fw/del_whitelist` | POST | 删除白名单 |
| `/api/url_fw/overview` | GET | 获取概览信息 |

### 页面路由

| 路径 | 模板 | 说明 |
|------|------|------|
| `/url_fw` | `url_fw/home` | URL 防火墙主页面 |

### 请求参数

#### update_status

| 参数 | 类型 | 说明 |
|------|------|------|
| `enable` | string | "0" 禁用，"1" 启用 |
| `auto_update` | string | "0" 禁用自动更新，"1" 启用 |

#### update_policy

| 参数 | 类型 | 说明 |
|------|------|------|
| `tag` | string | 分类标签 |
| `policy` | string | 策略值（reject/alarm/log/ignored） |

#### add_whitelist

| 参数 | 类型 | 说明 |
|------|------|------|
| `url` | string | 要添加的 URL |
| `session` | string | 会话标识（用于验证） |

#### del_whitelist

| 参数 | 类型 | 说明 |
|------|------|------|
| `url` | string | JSON 数组，要删除的 URL 列表 |

### 响应格式

#### get_status 响应

```json
{
    "code": 0,
    "enable": 1,
    "auto_update": 1,
    "update_ts": 1640000000
}
```

#### show_policy 响应

```json
{
    "code": 0,
    "list": [
        { "tag": "malware", "name": "恶意软件", "policy": "reject" },
        { "tag": "phishing", "name": "钓鱼网站", "policy": "reject" }
    ]
}
```

#### show_whitelist 响应

```json
{
    "code": 0,
    "whitelist": [
        { "utc": 1640000000, "url": "example.com" }
    ]
}
```

### 策略值说明

| 策略 | 说明 |
|------|------|
| `reject` | 拒绝访问 |
| `alarm` | 告警 |
| `log` | 仅记录日志 |
| `ignored` | 忽略 |

### 白名单条目格式

```
[timestamp]url
```

示例：`[1640000000]example.com`

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `ubus` | UCI 总线通信 |
| `luci.i18n` | 国际化支持 |
| `cjson` | JSON 解析 |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `xiaoqiang.common.XQFunction` | 通用工具函数 |
