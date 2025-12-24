# XQLEDControlUtil.lua - LED控制工具模块

## 概述

路由器LED灯控制工具模块，提供系统LED、氛围灯(XLED)、网口LED等控制功能。支持HSL/RGB颜色设置、定时开关、事件响应等高级功能。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   API控制器      | --> | XQLEDControlUtil | --> |   led_ctl命令    |
|  (misystem等)    |     |  (LED控制)       |     |  (底层控制)      |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    接收LED请求            解析配置参数            执行LED操作
         |                       |                       |
         v                       v                       v
    返回操作结果           颜色空间转换            更新LED状态
```

### LED控制架构

```
                    +------------------+
                    | XQLEDControlUtil |
                    +------------------+
                           |
        +------------------+------------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|    XLED       |  |   EthLED      |  |   AllLED      |
|  (氛围灯)     |  |  (网口灯)     |  |  (全部LED)    |
+---------------+  +---------------+  +---------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|  颜色控制     |  |  开关控制     |  |  统一控制     |
|  定时控制     |  |  定时控制     |  |               |
|  事件响应     |  |               |  |               |
+---------------+  +---------------+  +---------------+
```

### 颜色空间转换

```
+-------------+     +-------------+     +-------------+
|    HSL      | <-> |    RGB      | <-> |  十进制值   |
| (色相/饱和  |     | (红/绿/蓝)  |     | (UCI存储)   |
|  度/亮度)   |     |             |     |             |
+-------------+     +-------------+     +-------------+
```

## 接口列表

### 颜色转换函数

#### hslToRgb(h, s, l) [内部函数]
HSL颜色转RGB颜色。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| h | number | 色相 (0-360) |
| s | number | 饱和度 (0-100) |
| l | number | 亮度 (0-100) |

**返回值：** `table` - {r, g, b} RGB颜色表

---

#### rgbToHsl(r, g, b) [内部函数]
RGB颜色转HSL颜色。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| r | number | 红色分量 (0-255) |
| g | number | 绿色分量 (0-255) |
| b | number | 蓝色分量 (0-255) |

**返回值：** `table` - {h, s, l} HSL颜色表

---

#### decToRgb(decValue) [内部函数]
十进制颜色值转RGB。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| decValue | number | 十进制颜色值 |

**返回值：** `table|nil` - {r, g, b} RGB颜色表或nil

---

#### rgbToDec(r, g, b) [内部函数]
RGB颜色转十进制值。

**返回值：** `number` - 十进制颜色值

---

### XLED氛围灯控制

#### XLED.set_hsl(params)
设置XLED HSL颜色。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| val1 | string | 色相值 (0-100，映射到0-360) |
| val2 | string | 饱和度 (0-100) |
| val3 | string | 亮度 (0-100) |

**返回值：** `boolean` - 是否成功

---

#### XLED.set_rgb(params)
设置XLED RGB颜色。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| val1 | string | 红色分量 (0-255) |
| val2 | string | 绿色分量 (0-255) |
| val3 | string | 蓝色分量 (0-255) |

**返回值：** `boolean` - 是否成功

---

#### XLED.on()
开启XLED。

**返回值：** `boolean` - 是否成功

---

#### XLED.off()
关闭XLED。

**返回值：** `boolean` - 是否成功

---

#### XLED.event_on()
开启XLED事件响应。

**返回值：** `boolean` - 是否成功

---

#### XLED.event_off()
关闭XLED事件响应。

**返回值：** `boolean` - 是否成功

---

#### XLED.timer(params)
设置XLED定时器。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| timer.status | string | "1"=启用定时 |
| timer.start_h | string | 开始小时 |
| timer.start_m | string | 开始分钟 |
| timer.stop_h | string | 结束小时 |
| timer.stop_m | string | 结束分钟 |

**返回值：** `boolean` - 是否成功

---

### LED控制统一接口

#### LEDControl.xled.getConfig()
获取XLED配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| color_R | number | 红色分量 |
| color_G | number | 绿色分量 |
| color_B | number | 蓝色分量 |
| color_H | number | 色相 |
| color_S | number | 饱和度 |
| color_L | number | 亮度 |
| status | number | 状态（0-4=动作，5=关闭） |
| event_enable | string | 事件响应启用 |
| xled_timer_enable | string | 定时启用 |
| xled_timer_open | string | 定时开始时间 |
| xled_timer_close | string | 定时结束时间 |

---

#### LEDControl.xled.setConfig(config)
设置XLED配置。

**参数：**
| 字段 | 类型 | 说明 |
|------|------|------|
| func | string | 功能名称 |
| val1 | string | 参数1 |
| val2 | string | 参数2 |
| val3 | string | 参数3 |
| timer | table | 定时配置 |

**返回值：** `boolean` - 是否成功

---

#### LEDControl.ethled.getConfig()
获取网口LED配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| status | string | "0"=关闭，"1"=开启 |
| timer_status | string | 定时状态 |
| timer_open | string | 定时开始时间 |
| timer_close | string | 定时结束时间 |

---

#### LEDControl.ethled.setConfig(config)
设置网口LED配置。

**返回值：** `boolean` - 是否成功

---

#### LEDControl.allled.getConfig()
获取全部LED配置。

**返回值：**
| 字段 | 类型 | 说明 |
|------|------|------|
| status | string | "0"=全部关闭，"1"=有开启 |

---

#### LEDControl.allled.setConfig(config)
设置全部LED配置。

**返回值：** `boolean` - 是否成功

---

## XLED动作类型

| 动作名称 | 内部名称 | 索引 | 说明 |
|----------|----------|------|------|
| still_light | ambient_rgb_light | 0 | 常亮 |
| breath | ambient_rgb_breath | 1 | 呼吸 |
| flashing | ambient_rgb_star | 2 | 闪烁 |
| cycle | ambient_rgb_cycle | 3 | 循环 |
| rainbow | ambient_rgb_rainbow | 4 | 彩虹 |

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| luci.model.uci | UCI配置接口 |
| xiaoqiang.XQLog | 日志记录 |
| xiaoqiang.common.XQFunction | 通用工具函数 |
| xiaoqiang.XQFeatures | 功能特性检测 |
| bit | 位运算库 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API控制器
- `xiaoqiang/controller/api/xqsystem.lua` - 系统设置API

## 关键代码说明

### HSL到RGB转换算法

```lua
local function hslToRgb(h, s, l)
    h = h / 60
    s = s / 100
    l = l / 100
    
    local function hueToRgb(p, q, t)
        if t < 0 then t = t + 6 end
        if t >= 6 then t = t - 6 end
        
        if t < 1 then
            return p + (q - p) * t
        elseif t < 3 then
            return q
        elseif t < 4 then
            return p + (q - p) * (4 - t)
        else
            return p
        end
    end
    
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    
    r = hueToRgb(p, q, h + 2)
    g = hueToRgb(p, q, h)
    b = hueToRgb(p, q, h - 2)
end
```

标准HSL到RGB颜色空间转换算法实现。

### 十进制颜色值编码

```lua
local function rgbToDec(r, g, b)
    local bit = require("bit")
    local value = 0
    
    value = bit.bor(value, bit.lshift(r, 24))
    value = bit.bor(value, bit.lshift(g, 16))
    value = bit.bor(value, bit.lshift(b, 8))
    
    return value
end
```

将RGB颜色编码为32位整数，格式为RGBA（A固定为0），便于UCI配置存储。

### LED控制命令执行

```lua
function XLED.on()
    os.execute("/usr/sbin/led_ctl led_on xled")
    return true
end
```

通过`led_ctl`命令控制LED硬件，支持的命令包括：
- `led_on`/`led_off` - 开关控制
- `timer_on`/`timer_off` - 定时控制
- `event_toggle` - 事件响应控制
