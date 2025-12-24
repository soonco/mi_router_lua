# XQHttpUtil.lua - HTTP工具模块

## 概述

HTTP工具模块，提供HTTP GET和POST请求功能。基于Lua cURL库实现，封装了HTTP请求的常用操作，包括参数处理、Cookie管理、响应解析等。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   调用方模块     | --> |   XQHttpUtil     | --> |    cURL库        |
|  (XQNetUtil等)   |     |  (请求封装)      |     |  (底层HTTP)      |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    准备请求参数           构建cURL请求            执行HTTP请求
         |                       |                       |
         v                       v                       v
    处理响应结果           解析响应数据            返回HTTP响应
```

### HTTP请求流程

```
+-------------+     +-------------+     +-------------+     +-------------+
|  参数处理   | --> | Cookie设置  | --> |  执行请求   | --> |  响应解析   |
+-------------+     +-------------+     +-------------+     +-------------+
      |                   |                   |                   |
      v                   v                   v                   v
  URL编码            格式化Cookie        cURL.perform()      提取响应码
  查询字符串         设置域名            收集响应体          解析响应头
```

## 接口列表

### httpGetRequest(url, params, cookies)

发送HTTP GET请求。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| url | string | 是 | 请求URL |
| params | table | 否 | 查询参数表 {key=value, ...} |
| cookies | table | 否 | Cookie表 {key=value, ...} |

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| code | number | HTTP响应状态码 |
| headers | table | 响应头列表 |
| status | number | 状态标识（-3=成功，其他=错误信息） |
| res | string | 响应体内容 |

**示例：**
```lua
local result = XQHttpUtil.httpGetRequest(
    "https://api.example.com/data",
    {id = "123", type = "info"},
    {token = "abc123"}
)
if result.code == 200 then
    print(result.res)
end
```

---

### httpPostRequest(url, postData, cookies, contentType)

发送HTTP POST请求。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| url | string | 是 | 请求URL |
| postData | string/table | 是 | POST数据（字符串或表） |
| cookies | table | 否 | Cookie表 {key=value, ...} |
| contentType | string | 否 | Content-Type头 |

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| code | number | HTTP响应状态码 |
| res | string | 响应体内容 |
| status | number | 状态标识 |
| headers | table | 响应头列表 |

**示例：**
```lua
local result = XQHttpUtil.httpPostRequest(
    "https://api.example.com/login",
    {username = "admin", password = "123456"},
    nil,
    "application/x-www-form-urlencoded"
)
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.XQLog | 日志记录 |
| cURL | Lua cURL库，HTTP请求底层实现 |

## 被引用情况

- `xiaoqiang/util/XQNetUtil.lua` - 小米云服务API请求
- `xiaoqiang/module/XQVASModule.lua` - 增值服务API调用
- `xiaoqiang/module/XQTopology.lua` - 网络拓扑数据获取

## 关键代码说明

### Cookie格式化

```lua
if cookies then
    if type(cookies) == "table" then
        cookieStr = ""
        for key, value in pairs(cookies) do
            cookieStr = cookieStr .. key .. "=" .. value .. ";path=/;domain=.xiaomi.com;"
        end
    end
end
```

Cookie自动添加小米域名(.xiaomi.com)和路径(/)，适配小米云服务认证。

### 查询参数拼接

```lua
if params and type(params) == "table" then
    local queryString = ""
    for key, value in pairs(params) do
        if queryString == "" then
            queryString = key .. "=" .. value
        else
            queryString = queryString .. "&" .. key .. "=" .. value
        end
    end
    
    if string.find(url, "?") then
        url = url .. "&" .. queryString
    else
        url = url .. "?" .. queryString
    end
end
```

智能处理URL中已有查询参数的情况，使用`?`或`&`正确拼接。

### 响应收集

```lua
curl:setopt_writefunction(function(data)
    table.insert(responseBody, data)
    return #data
end)

curl:setopt_headerfunction(function(header)
    table.insert(responseHeaders, header)
    return #header
end)
```

使用回调函数分别收集响应体和响应头，支持流式数据处理。
