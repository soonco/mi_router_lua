# XQNfcUtil.lua - NFC工具模块

## 概述

NFC工具模块，提供通过NFC标签分享WiFi配置的功能。支持WPS (Wi-Fi Protected Setup) 标准格式，将WiFi配置编码为I2C数据格式写入NFC标签，实现一碰连网功能。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   WiFi配置       | --> |   XQNfcUtil      | --> |   NFC标签        |
|  (UCI配置)       |     |  (数据编码)      |     |  (I2C写入)       |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    读取WiFi信息           生成WPS TLV数据          写入NFC芯片
         |                       |                       |
         v                       v                       v
    选择优先网络           封装NDEF记录            更新标签内容
```

### NFC标签数据结构

```
+------------------+
|   NDEF记录头     |  <- 0xd2 0x17 (NDEF短记录)
+------------------+
|   记录类型       |  <- application/vnd.wfa.wsc
+------------------+
|   WPS Credential |  <- TLV格式的WiFi配置
|   - Network Index|
|   - SSID         |
|   - Auth Type    |
|   - Enc Type     |
|   - Network Key  |
|   - MAC Address  |
+------------------+
|   终止符         |  <- 0xfe
+------------------+
```

### WPS TLV格式

```
+--------+--------+--------+
| Type   | Length | Value  |
| 2字节  | 2字节  | N字节  |
+--------+--------+--------+
```

## 接口列表

### 状态检查

#### nfc_is_supported()
检查设备是否支持NFC。

**返回值：** `boolean` - 是否支持NFC

**实现：** 读取`misc.nfc.nfc_support`配置

---

#### nfc_is_enabled()
检查NFC是否已启用。

**返回值：** `boolean` - NFC是否启用

**实现：** 读取`nfc.nfc.nfc_enable`配置

---

#### nfc_is_default()
检查NFC是否处于默认状态（未初始化）。

**返回值：** `boolean` - 是否为默认状态

---

### 数据转换

#### str_to_i2c(str)
将字符串转换为I2C格式的十六进制数据。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| str | string | 输入字符串 |

**返回值：** `string` - I2C格式的十六进制字符串（如"0x48 0x65 0x6c 0x6c 0x6f"）

---

#### byte_to_i2c(value)
将单字节数值转换为I2C格式。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | number | 字节值（0-255） |

**返回值：** `string` - I2C格式（如"0x1a"）

---

#### word_to_i2c(value)
将双字节数值转换为I2C格式（大端序）。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | number | 双字节值（0-65535） |

**返回值：** `string` - I2C格式（如"0x10 0x45"）

---

#### uint32_to_i2c(value)
将四字节数值转换为I2C格式（大端序）。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | number | 四字节值 |

**返回值：** `string` - I2C格式

---

#### i2c_strlen(i2cStr)
计算I2C格式字符串的字节数。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| i2cStr | string | I2C格式字符串 |

**返回值：** `number` - 字节数

---

### NFC控制

#### nfc_update()
更新NFC标签。根据当前状态选择使用默认配置或当前WiFi配置。

**返回值：** `number` - 0表示失败或NFC不支持/未启用

**处理流程：**
1. 检查NFC支持和启用状态
2. 判断是否使用默认配置
3. 生成WiFi标签数据
4. 封装NDEF记录
5. 调用nfc命令写入标签

---

#### nfc_disable()
禁用NFC功能。

**实现：** 执行`/sbin/nfc disable`命令

---

#### nfc_mesh_sync_disable()
禁用Mesh同步（用于NFC配置）。

**实现：** 设置`nfc.nfc.mesh_sync_disabled=1`

---

### 标签生成

#### update_wifi_tag()
生成当前WiFi配置的NFC标签数据。

**返回值：** `string` - NFC标签数据（I2C格式）或"no_tag"表示无可用WiFi

**WiFi选择优先级：**
1. 5GHz主网络（ifname_5G）
2. 5GHz高频网络（ifname_5GH）
3. 2.4GHz网络（ifname_2G）
4. 任意已启用的WiFi

---

#### default_wifi_tag()
生成默认WiFi配置的NFC标签数据（从UCI配置读取）。

**返回值：** `string` - NFC标签数据（I2C格式）

**数据来源：** `wireless.nfc_2g`配置节

---

## WPS属性定义

| 属性名 | 属性ID | 最大长度 | 说明 |
|--------|--------|----------|------|
| Network_Index | 4134 | 1 | 网络索引 |
| SSID | 4165 | 32 | 网络名称 |
| Authentication_Type | 4099 | 2 | 认证类型 |
| Encryption_Type | 4111 | 2 | 加密类型 |
| Network_Key | 4135 | 64 | 网络密码 |
| MAC_Address | 4128 | 6 | MAC地址 |
| Credential | 4110 | 0 | 凭证容器 |

## 认证类型枚举

| 类型 | 值 | 说明 |
|------|-----|------|
| Open | 1 | 开放网络 |
| WPA-Personal | 2 | WPA个人版 |
| Shared | 4 | 共享密钥 |
| WPA-Enterprise | 8 | WPA企业版 |
| WPA2-Enterprise | 16 | WPA2企业版 |
| WPA2-Personal | 32 | WPA2个人版 |
| SAE | 32 | WPA3-Personal |

## 加密类型枚举

| 类型 | 值 | 说明 |
|------|-----|------|
| None | 1 | 无加密 |
| WEP | 2 | WEP加密 |
| TKIP | 4 | TKIP加密 |
| AES | 8 | AES加密 |
| AES/TKIP | 12 | 混合加密 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.util.XQWifiUtil | WiFi信息获取 |
| luci.model.uci | UCI配置接口 |
| bit | 位运算库 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API控制器
- `xiaoqiang/module/XQWifiShare.lua` - WiFi分享模块

## 关键代码说明

### WiFi配置编码

```lua
function update_wifi_tag()
    -- 网络索引
    tagData = word_to_i2c(WPS_ATTRIBUTES.Network_Index[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Network_Index[2]) .. " " .. "0x01" .. " "
    
    -- SSID
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.SSID[1]) .. " " ..
              word_to_i2c(string.len(selectedWifi.ssid)) .. " " ..
              str_to_i2c(selectedWifi.ssid) .. " "
    
    -- 认证类型
    local encryption = selectedWifi.encryption
    if encryption == "psk2+ccmp" or encryption == "ccmp" then
        authType = AUTHENTICATION_TYPE.SAE
    elseif encryption == "psk2" then
        authType = AUTHENTICATION_TYPE["WPA2-Personal"]
    end
    
    tagData = tagData .. word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[1]) .. " " ..
              word_to_i2c(WPS_ATTRIBUTES.Authentication_Type[2]) .. " " ..
              word_to_i2c(authType) .. " "
end
```

### NDEF记录封装

```lua
function nfc_update()
    -- 计算payload长度
    payloadLen = i2c_strlen(tagData)
    
    -- 添加NDEF头
    tagData = NFC_RECORD_HEADER .. " " .. byte_to_i2c(payloadLen) .. " " ..
              NFC_RECORD_TYPE .. " " .. tagData
    
    -- 计算总长度
    totalLen = i2c_strlen(tagData)
    
    -- 添加短记录标识和终止符
    if totalLen <= 255 then
        tagData = NFC_SHORT_RECORD .. " " .. byte_to_i2c(totalLen) .. " " ..
                  tagData .. " " .. NFC_TERMINATOR
    end
    
    -- 写入NFC标签
    XQFunction.forkExec(string.format("/sbin/nfc update '%s' %d", tagData, i2c_strlen(tagData)))
end
```

### I2C数据格式转换

```lua
function str_to_i2c(str)
    local result = ""
    for i = 1, string.len(str) do
        result = result .. string.format("0x%02x ", string.byte(str, i))
    end
    return string.sub(result, 1, -2)  -- 去除末尾空格
end

function word_to_i2c(value)
    local bit = require("bit")
    local highByte = bit.rshift(value, 8)
    local lowByte = bit.band(value, 255)
    return string.format("0x%02x 0x%02x", highByte, lowByte)
end
```

将数据转换为I2C总线可识别的十六进制格式，便于通过nfc命令写入NFC芯片。
