# XQBackup.lua - 配置备份恢复模块

## 概述

`XQBackup.lua` 是小米路由器的配置备份和恢复模块，支持将路由器配置导出为加密文件，并从备份文件恢复配置。该模块使用AES加密保护配置数据，支持多种配置项的选择性备份和恢复。

**文件位置**: `xiaoqiang/module/XQBackup.lua`  
**模块名**: `xiaoqiang.module.XQBackup`  
**代码行数**: ~800行

## 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                    配置备份流程                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           收集配置数据                   │               │
│  │  - 基本信息 (路由器名称、密码)           │               │
│  │  - WiFi设置 (SSID、密码、加密方式)       │               │
│  │  - 网络设置 (WAN/LAN配置)               │               │
│  │  - DHCP设置                             │               │
│  │  - MAC过滤设置                          │               │
│  │  - 蜂窝网络设置 (CPE设备)               │               │
│  │  - 短信信息 (CPE设备)                   │               │
│  └─────────────────────────────────────────┘               │
│                      │                                      │
│                      ▼                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           AES加密                        │               │
│  │  密钥 = SN(5) + MAC1(12) + MAC2(12) +   │               │
│  │         Color(3) = 32字节               │               │
│  └─────────────────────────────────────────┘               │
│                      │                                      │
│                      ▼                                      │
│  ┌─────────────────────────────────────────┐               │
│  │           打包输出                       │               │
│  │  cfg_backup.des (加密数据)              │               │
│  │  cfg_backup.mbu (元数据/配置项列表)     │               │
│  │  → tar.gz压缩包                         │               │
│  └─────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    配置恢复流程                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  tar.gz文件 → 解压 → 验证文件 → AES解密 → 恢复各项配置      │
│                                                             │
│  安全检查:                                                  │
│  - 检查是否包含符号链接                                     │
│  - 验证文件类型 (.des/.mbu)                                │
│  - 验证文件数量                                            │
└─────────────────────────────────────────────────────────────┘
```

## 接口列表

### 主要接口

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `backup(customItems)` | customItems: table(可选) | string/nil | 执行配置备份，返回文件名 |
| `restore(desFilePath, customItems)` | desFilePath: string, customItems: table | number | 恢复配置，返回错误码 |
| `extract(tarFile, targetDir)` | tarFile: string, targetDir: string | number | 解压备份文件 |
| `getdes(mbuFilePath)` | mbuFilePath: string | table/nil | 获取备份文件描述信息 |
| `defaultKeys()` | 无 | table | 获取默认备份项列表 |
| `getFullPath(filename)` | filename: string | string/nil | 获取备份文件完整路径 |

### 内部函数

| 函数名 | 说明 |
|--------|------|
| `generateEncryptionKey()` | 生成AES加密密钥 |
| `getBasicInfo()` | 获取基本信息 |
| `getWifiInfo()` | 获取WiFi配置 |
| `getNetworkInfo()` | 获取网络配置 |
| `getLanInfo()` | 获取LAN配置 |
| `getMacfilterInfo()` | 获取MAC过滤配置 |
| `getAccessInfo()` | 获取访问控制配置 |
| `getSmsInfo()` | 获取短信信息 |
| `getMobileInfo()` | 获取蜂窝网络配置 |
| `restoreBasicInfo(info)` | 恢复基本信息 |
| `restoreWifiInfo(info)` | 恢复WiFi配置 |
| `restoreNetworkInfo(info)` | 恢复网络配置 |
| `restoreLanInfo(info)` | 恢复LAN配置 |
| `restoreMacfilterInfo(info)` | 恢复MAC过滤配置 |
| `restoreAccessInfo(info)` | 恢复访问控制配置 |
| `restoreSmsInfo(info)` | 恢复短信信息 |
| `restoreMobileInfo(info)` | 恢复蜂窝网络配置 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（bdataGet等） |
| `xiaoqiang.util.XQWifiUtil` | WiFi配置工具 |
| `xiaoqiang.util.XQPushUtil` | 推送设置工具 |
| `xiaoqiang.util.XQDeviceUtil` | 设备工具 |
| `xiaoqiang.util.XQSysUtil` | 系统工具 |
| `xiaoqiang.util.XQSMSUtil` | 短信工具 |
| `xiaoqiang.util.DedicatedWirelessBackhaulUtil` | 专用无线回程工具 |
| `xiaoqiang.XQFeatures` | 功能特性 |
| `luci.model.uci` | UCI配置管理 |
| `nixio.fs` | 文件系统操作 |
| `aeslua` | AES加密库 |
| `json` | JSON编解码 |

## 被引用情况

该模块被以下模块引用：
- `luci.controller.api.xqsystem` - 系统API备份/恢复接口

## 关键代码说明

### 1. 加密密钥生成

```lua
local function generateEncryptionKey()
    local defaultKey = "7kl4n23mnm678m890s9dfklnmdqmwenq"
    
    local sn = string.sub(XQFunction.bdataGet("SN", "0529486"), 1, 5)
    local color = string.sub(XQFunction.bdataGet("color", "1000"), 1, 3)
    local mac1 = LuciUtil.trim(string.lower(LuciUtil.exec("getmac|awk -F ',' '{print $1}'|sed 's/://g'")))
    local mac2 = LuciUtil.trim(string.lower(LuciUtil.exec("getmac|awk -F ',' '{print $2}'|sed 's/://g'")))
    
    if sn ~= nil and color ~= nil and mac1 ~= nil and mac2 ~= nil then
        defaultKey = sn .. mac1 .. mac2 .. color  -- 32字节密钥
    end
    
    return defaultKey
end
```

### 2. 备份项配置

```lua
local BACKUP_ITEM_NAMES = {
    mi_basic_info = "路由器名称和路由器管理密码",
    mi_wifi_info = "Wi-Fi设置(Wi-Fi名称、Wi-Fi密码)",
    mi_network_info = "上网设置(拨号方式和宽带账号密码)",
    mi_lan_info = "DHCP服务和局域网IP设置",
    mi_mobile_info = "蜂窝设置(网络设置,PIN码设置,流量监控)",
    mi_sms_info = "短信信息"
}
```

### 3. 备份文件安全验证

```lua
function extract(tarFile, targetDir)
    -- 检查是否包含符号链接（安全风险）
    local hasSymlink = os.execute("tar -tzvf " .. tarFile .. " | grep ^l")
    if hasSymlink == 0 then
        os.execute("rm -rf " .. tarFile)
        return 2  -- 包含符号链接，拒绝
    end
    
    -- 验证只包含.des和.mbu文件
    local hasInvalidFiles = os.execute("tar -tzvf " .. tarFile .. 
        " | grep -v '\\.des$' | grep -v '\\.mbu$'")
    if hasInvalidFiles == 0 then
        os.execute("rm -rf " .. tarFile)
        return 22  -- 包含非法文件
    end
    
    -- 验证.des文件数量为1
    local desCount = tonumber(pipe:read("*a"))
    if desCount ~= 1 then
        return 2
    end
    
    -- 验证.mbu文件数量为1
    local mbuCount = tonumber(pipe:read("*a"))
    if mbuCount ~= 1 then
        return 3
    end
    
    -- 解压文件
    os.execute("tar -xzf " .. tarFile .. " -C " .. targetDir)
    return 0
end
```

### 4. WiFi配置恢复

```lua
local function restoreWifiInfo(info)
    if info then
        -- 恢复5G分离状态
        if supportSplit5g then
            XQWifiUtil.set_wifi_split_status(tonumber(info.split5g))
        end
        
        -- 恢复MLO状态
        if supportMlo then
            if info.mlo == 1 then
                XQWifiUtil.mlo_hostap_enable()
            else
                XQWifiUtil.mlo_hostap_disable()
            end
        end
        
        -- 恢复2.4G WiFi
        local wifi24g = info["24g"]
        if wifi24g then
            XQWifiUtil.setWifiBasicInfo(1, wifi24g.ssid, wifi24g.password, ...)
        end
        
        -- 恢复5G WiFi
        local wifi5g = info["5g"]
        if wifi5g then
            XQWifiUtil.setWifiBasicInfo(2, wifi5g.ssid, wifi5g.password, ...)
        end
    end
end
```

## 文件路径常量

| 常量 | 值 | 说明 |
|------|-----|------|
| `TMP_DIR` | `/tmp` | 临时目录 |
| `BACKUP_PATH` | `/tmp/syslogbackup/` | 备份文件存储路径 |
| `TAR_FILE_NAME` | `cfgbackup.tar.gz` | 压缩包文件名 |
| `DES_FILE_NAME` | `cfg_backup.des` | 加密数据文件名 |
| `MBU_FILE_NAME` | `cfg_backup.mbu` | 元数据文件名 |

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 1 | 文件不存在 |
| 2 | 解密失败或文件格式错误 |
| 3 | 元数据文件错误 |
| 22 | 包含非法文件类型 |

## 注意事项

1. **设备绑定**: 加密密钥基于设备SN和MAC地址生成，备份文件只能在同一设备上恢复
2. **安全验证**: 解压前会检查符号链接和文件类型，防止路径遍历攻击
3. **选择性恢复**: 支持选择性恢复部分配置项
4. **CPE支持**: 支持蜂窝网络设备的特殊配置（mobile、sms）
