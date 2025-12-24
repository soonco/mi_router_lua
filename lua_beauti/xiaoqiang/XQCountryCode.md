# XQCountryCode.lua - 国家/地区代码模块

## 概述

`XQCountryCode.lua` 是小米路由器的国家/地区代码管理模块，负责管理WiFi区域设置、语言映射和无线频段配置。该模块支持多国家/地区的无线标准（ETSI、FCC、AS），确保路由器在不同国家/地区符合当地的无线电法规。

**文件位置**: `xiaoqiang/XQCountryCode.lua`  
**模块名**: `xiaoqiang.XQCountryCode`  
**代码行数**: ~291行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    国家代码管理流程                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────┐    ┌──────────────┐    ┌───────────────┐  │
│  │ 国家代码表   │───▶│  区域配置表   │───▶│ WiFi频段设置  │  │
│  │ COUNTRY_CODE│    │   REGION     │    │ 2.4G/5G配置   │  │
│  └─────────────┘    └──────────────┘    └───────────────┘  │
│         │                                       │           │
│         ▼                                       ▼           │
│  ┌─────────────┐                        ┌───────────────┐  │
│  │ 语言映射表   │                        │  NVRAM存储    │  │
│  │  LANGUAGE   │                        │ CountryCode   │  │
│  └─────────────┘                        └───────────────┘  │
│                                                             │
│  无线标准判断:                                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    ETSI     │  │    FCC      │  │     AS      │        │
│  │ 欧洲标准    │  │ 美国标准    │  │  亚洲标准   │        │
│  │ DE,UK,EU   │  │   US,ID     │  │ HK,SG,MY   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### 核心数据结构

1. **COUNTRY_CODE**: 支持的国家/地区列表，包含代码、名称和主要支持标志
2. **REGION**: WiFi区域配置，定义2.4G和5G频段的区域代码
3. **LANGUAGE**: 国家代码到语言代码的映射
4. **JLANGUAGE**: Java语言代码映射（用于客户端）

## 接口列表

### 无线标准判断函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `isCountryETSI(country_code)` | country_code: string | boolean | 判断是否为ETSI标准国家（欧洲） |
| `isCountryETSI_special(country_code)` | country_code: string | boolean | 判断是否为特殊ETSI国家 |
| `isCountryFCC(country_code)` | country_code: string | boolean | 判断是否为FCC标准国家（美国） |
| `isCountryAS(country_code)` | country_code: string | boolean | 判断是否为亚洲标准国家 |

### 国家代码获取函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getCountryCodeList()` | 无 | table | 获取主要支持的国家/地区列表 |
| `getCurrentCountryCode()` | 无 | string | 获取当前国家代码，默认"CN" |
| `getSimCountryCode()` | 无 | string | 获取SIM卡国家代码（CPE设备） |
| `getBDataRegion()` | 无 | string | 获取BData存储的区域代码 |
| `getBDataCountryCode()` | 无 | string | 获取BData国家代码（考虑区域映射） |

### 国家代码设置函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `setCurrentCountryCode(country_code)` | country_code: string | boolean | 设置当前国家代码并更新WiFi区域 |

### 语言相关函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getCurrentJLan()` | 无 | string | 获取当前Java语言代码 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（nvramGet/Set, isStrNil等） |
| `xiaoqiang.util.XQSysUtil` | 系统工具（getChannel, getLang） |
| `xiaoqiang.util.XQWifiUtil` | WiFi工具（setWifiRegion） |
| `luci.i18n` | 国际化翻译 |
| `luci.model.uci` | UCI配置读取 |

## 被引用情况

该模块被以下模块引用：
- `xiaoqiang.util.XQSysUtil` - 系统工具获取国家代码
- `xiaoqiang.util.XQWifiUtil` - WiFi配置时获取区域设置
- `luci.controller.api.xqsystem` - 系统API获取/设置国家代码
- `luci.controller.api.xqnetwork` - 网络API获取区域信息

## 关键代码说明

### 1. 国家代码数据结构

```lua
COUNTRY_CODE = {
    { c = "CN", n = _("中国大陆"), p = true },  -- c=代码, n=名称, p=主要支持
    { c = "HK", n = _("香港地区"), p = true },
    { c = "US", n = _("美国"), p = false },
    -- ...
}
```

### 2. WiFi区域配置

```lua
REGION = {
    CN = { region = 1, regionABand = 0 },   -- 2.4G区域=1, 5G区域=0
    US = { region = 0, regionABand = 10 },  -- 2.4G区域=0, 5G区域=10
    EU = { region = 1, regionABand = 6 },   -- 2.4G区域=1, 5G区域=6
    -- ...
}
```

### 3. 设置国家代码流程

```lua
function setCurrentCountryCode(country_code)
    -- 1. 验证国家代码有效性
    if REGION[country_code] == nil then return false end
    if LANGUAGE[country_code] == nil then return false end
    
    -- 2. 保存到NVRAM
    XQFunction.nvramSet("CountryCode", country_code)
    XQFunction.nvramCommit()
    
    -- 3. 设置WiFi区域
    local region_config = REGION[country_code]
    XQWifiUtil.setWifiRegion(country_code, region_config.region, region_config.regionABand)
    
    return true
end
```

### 4. 无线标准判断

```lua
-- ETSI标准国家（欧洲电信标准协会）
function isCountryETSI(country_code)
    if country_code == "DE" or country_code == "UK" or country_code == "EU" then
        return true
    end
    return isCountryETSI_special(country_code)  -- 检查特殊ETSI国家
end

-- FCC标准国家（美国联邦通信委员会）
function isCountryFCC(country_code)
    return country_code == "US" or country_code == "ID"
end

-- 亚洲标准国家
function isCountryAS(country_code)
    return country_code == "HK" or country_code == "SG" or country_code == "MY" ...
end
```

## 支持的国家/地区

| 代码 | 国家/地区 | 主要支持 | 无线标准 |
|------|-----------|----------|----------|
| CN | 中国大陆 | ✓ | - |
| HK | 香港地区 | ✓ | AS |
| TW | 台湾地区 | ✓ | - |
| KR | 韩国 | ✓ | - |
| US | 美国 | ✗ | FCC |
| EU | 欧洲 | ✓ | ETSI |
| SG | 新加坡 | ✗ | AS |
| MY | 马来西亚 | ✗ | AS |
| ID | 印度尼西亚 | ✗ | FCC |
| DE | 德国 | ✗ | ETSI |
| UK | 英国 | ✗ | ETSI |
