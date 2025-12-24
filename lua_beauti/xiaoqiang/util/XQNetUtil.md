# XQNetUtil.lua - 网络工具模块

## 概述

小米云服务API交互工具模块，提供设备认证、小米账号登录、固件升级检测、日志上传、签名请求等功能。是路由器与小米云服务通信的核心模块。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   业务模块       | --> |    XQNetUtil     | --> |   小米云服务     |
|  (升级/登录等)   |     |  (API封装)       |     |  (api.miwifi.com)|
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    调用API接口            生成签名请求            执行HTTP请求
         |                       |                       |
         v                       v                       v
    处理响应结果           解密响应数据            返回API响应
```

### API请求签名流程

```
+-------------+     +-------------+     +-------------+     +-------------+
|  参数排序   | --> |  签名生成   | --> |  请求构建   | --> |  响应解密   |
+-------------+     +-------------+     +-------------+     +-------------+
      |                   |                   |                   |
      v                   v                   v                   v
  按key排序          MD5/SHA1签名        添加签名参数        RC4解密
  拼接字符串          Base64编码          发送请求          JSON解析
```

### 小米账号登录流程

```
+-------------+     +-------------+     +-------------+     +-------------+
|  Step1      | --> |  Step2      | --> |  保存凭证   | --> |  完成登录   |
| 账号认证    |     | 获取Token   |     |             |     |             |
+-------------+     +-------------+     +-------------+     +-------------+
      |                   |                   |                   |
      v                   v                   v                   v
  POST账号密码       302重定向          保存到数据库        返回登录结果
  获取nonce/ssecurity  获取serviceToken   passport表
```

## 接口列表

### 基础信息获取

#### getToken()
获取API令牌。

**返回值：** `string` - API令牌

---

#### getMacAddr()
获取设备MAC地址。

**返回值：** `string` - MAC地址

---

#### getSN()
获取设备序列号。

**返回值：** `string|nil` - 序列号

---

#### getDeviceId()
获取设备唯一标识。

**返回值：** `string` - 设备ID

---

#### getUserAgent()
获取User-Agent字符串。

**返回值：** `string` - "miwifi-{SN}"格式

---

### URL签名

#### cryptUrl(baseUrl, path, params, extraData)
生成带签名的URL。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| baseUrl | string | 是 | 基础URL |
| path | string | 是 | URL路径 |
| params | table | 是 | 参数列表 {{key, value}, ...} |
| extraData | string | 否 | 额外签名数据 |

**返回值：** `string|nil` - 签名后的完整URL

**签名算法：**
1. 添加时间戳参数
2. 按key排序参数
3. 拼接为key=value&格式
4. MD5+Base64生成签名
5. 附加s、time、token参数

---

### 日志上传

#### generateLogKey()
生成日志上传的行键。

**返回值：** `string` - "MAC-时间戳"格式

---

#### uploadLogFile(filePath, columnType, rowKey)
上传日志文件到HBase（旧版本）。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| filePath | string | 是 | 日志文件路径 |
| columnType | string | 是 | 列类型（M/B/X/Y/Z） |
| rowKey | string | 否 | 行键 |

**返回值：** `boolean` - 是否成功

---

#### uploadLogV2(logFileName)
上传日志文件V2版本。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| logFileName | string | 否 | 日志文件名（用于提取时间戳） |

**返回值：** `boolean` - 是否成功

---

#### uploadConfigFile(filePath)
上传配置文件。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| filePath | string | 是 | 配置文件路径 |

**返回值：** `boolean` - 是否成功

---

### 小米账号登录

#### xiaomiLogin(username, passwordHash)
小米账号登录。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| username | string | 是 | 用户名 |
| passwordHash | string | 是 | 密码哈希（MD5大写） |

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| code | number | 0=成功，1=用户名/密码错误，2=认证失败，3=服务不可达 |
| uuid | string | 用户ID |
| token | string | passToken |
| stoken | string | serviceToken |
| sid | string | 会话ID |
| ssecurity | string | 安全密钥 |

---

#### getPassport(uuid)
获取用户凭证。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| uuid | string | 否 | 用户ID |

**返回值：** `table|false` - 凭证信息或false

---

#### getUserInfo(uuid)
获取用户信息。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| aliasNick | string | 别名昵称 |
| miliaoNick | string | 米聊昵称 |
| userId | string | 用户ID |
| miliaoIcon | string | 头像URL |
| miliaoIconOrig | string | 原始尺寸头像URL |

---

### 升级检测

#### checkUpgrade()
检查固件升级。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| needUpdate | number | 1=需要更新，0=不需要 |
| downloadUrl | string | 下载URL |
| fullHash | string | 文件哈希 |
| fileSize | number | 文件大小 |
| version | string | 目标版本 |
| changeLog | string | 更新日志 |
| weight | number | 权重 |
| buildTime | string | 构建时间 |

---

#### checkPctlDPIUpgrade()
检查家长控制DPI库升级。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| downloadUrl | string | 下载URL |
| fullHash | string | 文件哈希 |
| fileSize | number | 文件大小 |
| version | string | 版本号 |

---

#### checkEcosUpgrade(version, channel, filterID, countryCode)
检查生态系统升级。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| version | string | 当前版本 |
| channel | string | 渠道 |
| filterID | string | 过滤ID |
| countryCode | string | 国家代码 |

**返回值：** 同checkUpgrade

---

### 签名请求

#### generateSignature(method, body, params, secret)
生成请求签名。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| method | string | HTTP方法 |
| body | string | 请求体 |
| params | table | 参数列表 |
| secret | string | 密钥 |

**返回值：** `string` - SHA1签名

---

#### doRequest(method, path, params, uuid)
执行签名API请求。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| method | string | 是 | HTTP方法（GET/POST） |
| path | string | 是 | API路径 |
| params | table | 否 | 参数列表 |
| uuid | string | 否 | 用户ID |

**返回值：** `table|false` - 响应数据或false

---

## API路径常量

| 常量 | 路径 | 说明 |
|------|------|------|
| UPGRADE_PATH | /rs/grayupgrade | 固件升级 |
| UPGRADE_PATH_V2 | /rs/grayupgrade/v2/r01 | 升级V2 |
| RECOVERY_UPGRADE_PATH | /rs/grayupgrade/recovery | 恢复模式升级 |
| PCTL_DPI_UPGRADE_PATH | /rs/parent_control/feature_lib | 家长控制DPI库 |
| REGISTER_PATH | /s/register | 设备注册 |
| DEVICE_LIST_PATH | /s/admin/deviceList | 设备列表 |
| ADMIN_LIST_PATH | /s/device/adminList | 管理员列表 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.common.XQConfigs | 配置常量 |
| xiaoqiang.util.XQHttpUtil | HTTP请求 |
| xiaoqiang.util.XQSysUtil | 系统工具 |
| xiaoqiang.util.XQCryptoUtil | 加密工具 |
| xiaoqiang.util.XQDBUtil | 数据库工具 |
| xiaoqiang.XQLog | 日志记录 |
| xiaoqiang.XQCountryCode | 国家代码 |
| luci.http.protocol | HTTP协议 |
| xqcrypto | 加密库（C扩展） |
| json | JSON解析 |
| mime | Base64编码 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API
- `xiaoqiang/controller/api/xqsystem.lua` - 系统设置
- `xiaoqiang/module/XQMessageBox.lua` - 消息盒子
- `xiaoqiang/module/XQSystem.lua` - 系统模块

## 关键代码说明

### URL签名生成

```lua
function cryptUrl(baseUrl, path, params, extraData)
    local timestamp = XQFunction.getTime()
    table.insert(params, {"time", timestamp})
    
    -- 按key排序
    table.sort(params, function(a, b)
        return a[1] < b[1]
    end)
    
    -- 拼接签名字符串
    local signStr = ""
    table.foreach(params, function(_, item)
        signStr = signStr .. item[1] .. "=" .. item[2] .. "&"
    end)
    
    if extraData ~= nil and extraData ~= "" then
        signStr = signStr .. extraData
    end
    
    -- MD5+Base64签名
    local signature = XQCryptoUtil.md5Base64Str(signStr)
end
```

### 小米账号两步登录

```lua
function xiaomiLogin(username, passwordHash)
    -- Step1: 账号认证
    local response = XQHttpUtil.httpPostRequest(loginUrl, postData)
    
    if response.code == 302 then
        -- 提取nonce和ssecurity
        local pragmaData = json.decode(extensionPragma)
        nonce = extensionPragma:match("%S+\"nonce\":(%d+),%S+")
        ssecurity = pragmaData.ssecurity
        
        -- 生成客户端签名
        local signData = "nonce=" .. nonce .. "&" .. ssecurity
        local clientSign = XQCryptoUtil.binaryBase64Enc(XQCryptoUtil.sha1Binary(signData))
        
        -- Step2: 获取serviceToken
        local step2Response = XQHttpUtil.httpGetRequest(step2Url)
        serviceToken = step2Cookie:match("serviceToken=(%S+);")
        
        -- 保存凭证
        XQDBUtil.savePassport(userId, passToken, serviceToken, sid, ssecurity)
    end
end
```

### 加密请求执行

```lua
function doRequest(method, path, params, uuid)
    local passport = getPassport(uuid)
    local nonce = xqcrypto.generateNonce()
    local sessionSecurity = xqcrypto.generateSessionSecurity(nonce)
    
    -- 加密参数
    local encryptedData = xqcrypto.encryptParams(sessionSecurity, encryptedParams)
    
    -- 生成签名
    local signature = generateSignature(method, nil, queryParams, rc4Hash)
    
    -- 发送请求
    local response = XQHttpUtil.httpGetRequest(API_SERVER_URL .. path, requestParams, cookies)
    
    -- 解密响应
    local decryptedResult = xqcrypto.decryptResult(sessionSecurity, response.res)
    return json.decode(decryptedResult)
end
```

使用xqcrypto C扩展库进行参数加密和响应解密，保证API通信安全。
