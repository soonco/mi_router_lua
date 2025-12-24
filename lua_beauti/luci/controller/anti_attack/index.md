# index.lua - 防攻击控制器模块

## 工作原理

防攻击控制器模块，提供防攻击相关的 API 接口，支持反向路径过滤（rpfilter）、DoS 防护、端口扫描防护等功能。

核心功能：
1. **反向路径过滤** - 防止 IP 欺骗攻击
2. **DoS 防护** - 防止拒绝服务攻击
3. **端口扫描防护** - 防止恶意端口扫描
4. **网关安全概览** - 汇总所有安全防护状态

配置存储：
- 配置文件：`firewall_cpp`
- 配置节：`anti_attack`

## 接口

### API 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/api/anti_attack/get_status` | GET | 获取防攻击状态 |
| `/api/anti_attack/set_rpfilter` | POST | 设置反向路径过滤 |
| `/api/anti_attack/set_dos` | POST | 设置 DoS 防护 |
| `/api/anti_attack/set_scan` | POST | 设置端口扫描防护 |
| `/api/gateway_security/overview` | GET | 网关安全概览 |

### 请求参数

| 参数 | 类型 | 说明 |
|------|------|------|
| `enable` | string | "1" 启用，"0" 禁用 |

### 响应格式

#### get_status 响应

```json
{
    "code": 0,
    "dos": 1,
    "scan": 1,
    "rpfilter": 0
}
```

#### overview 响应

```json
{
    "code": 0,
    "dos": { "enable": 1 },
    "scan": { "enable": 1 },
    "arp_bind": { "enable": 0 },
    "fake_gateway": { "enable": 0 },
    "meta": {
        "protected": 2,
        "total": 4
    }
}
```

### 内部函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `set_rpfilter(enable)` | enable: boolean | 0/-1 | 设置反向路径过滤 |
| `set_dos(enable)` | enable: boolean | 0/-1 | 设置 DoS 防护 |
| `set_scan(enable)` | enable: boolean | 0/-1 | 设置端口扫描防护 |
| `get_status()` | 无 | table | 获取防攻击状态 |
| `_overview()` | 无 | table, boolean | 获取安全概览 |

### UCI 配置项

| 配置项 | 说明 |
|--------|------|
| `rpfilter_enable` | 反向路径过滤开关 |
| `dos_enable` | DoS 防护开关 |
| `scan_enable` | 端口扫描防护开关 |
| `disable` | 全局禁用开关 |

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `ubus` | 系统总线通信 |
| `xiaoqiang.XQFeatures` | 功能特性配置 |
| `xiaoqiang.module.XQMacBind` | MAC 绑定模块 |
| `luci.model.uci` | UCI 配置读取 |
