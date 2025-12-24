# auto_login.htm - 自动登录脚本

## 文件作用
为已授权的 MAC 地址提供自动登录功能，无需手动输入密码即可进入路由器管理界面。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.sys` | 系统命令执行 |
| `luci.http` | HTTP 请求处理 |

### 后端接口
| 接口 | 说明 |
|------|------|
| `api/xqsystem/login` | 登录验证接口 |

## 页面原理

### 授权验证流程
1. 读取配置文件 `xxx.json` 获取已授权的 MAC 地址列表
2. 获取当前访问者的 MAC 地址
3. 检查 MAC 是否在授权列表中
4. 如果已授权，自动生成登录请求

### 密码加密
根据路由器型号选择不同的加密算法：
- **型号 7000**: 使用 SHA256
- **其他型号**: 使用 SHA1

### 登录流程
```javascript
var nonce = Encrypt.init();
var oldPwd = CryptoJS.SHA{sha}(nonce + password).toString();
$.post(url, {username: 'admin', password: oldPwd, logtype: 2, nonce: nonce}, callback);
```

## 依赖关系
- 需要 `xxx.json` 配置文件
- 需要 CryptoJS 加密库
- 需要 Encrypt 初始化模块

## 安全说明
此功能用于信任设备的免密登录，MAC 地址需要预先配置在授权列表中。
