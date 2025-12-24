# XQParam.lua - 参数验证工具模块

## 概述

参数验证工具模块，提供输入参数验证功能。支持多种验证规则（正则、函数、命名检查器），内置常用验证器（MAC地址、IP地址、JSON等），用于API接口的参数安全验证。

## 工作原理

```
+------------------+     +------------------+     +------------------+
|   API控制器      | --> |    XQParam       | --> |   验证结果       |
|  (参数输入)      |     |  (参数验证)      |     |  (true/false)    |
+------------------+     +------------------+     +------------------+
         |                       |                       |
         v                       v                       v
    获取请求参数           选择验证规则            返回验证结果
         |                       |                       |
         v                       v                       v
    调用verify()           执行验证逻辑            处理验证失败
```

### 验证规则类型

```
                    +------------------+
                    |    verify()      |
                    +------------------+
                           |
        +------------------+------------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|   字符串规则  |  |   表规则      |  |   内置检查器  |
|  (类型检查)   |  | (命名检查器)  |  |  (checkers)   |
+---------------+  +---------------+  +---------------+
        |                  |                  |
        v                  v                  v
+---------------+  +---------------+  +---------------+
|  pcall检查    |  | namedChecker  |  |  commonstr   |
|               |  |  Verify()     |  |  macaddr     |
|               |  |               |  |  ip4addr等   |
+---------------+  +---------------+  +---------------+
```

## 接口列表

### 主验证函数

#### verify(value, rule)
主验证函数，根据规则验证参数值。

**参数：**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| value | any | 是 | 待验证的值 |
| rule | string/table | 是 | 验证规则 |

**返回值：** `boolean` - 验证结果

**规则类型：**
- `string` - 类型检查（如"string", "number"）
- `table` - 命名检查器配置 {name=检查器名, arg=参数}

**示例：**
```lua
-- 类型检查
XQParam.verify("hello", "string")  -- true
XQParam.verify(123, "number")      -- true

-- 命名检查器
XQParam.verify("192.168.1.1", {name = "ip4addr"})  -- true
XQParam.verify("AA:BB:CC:DD:EE:FF", {name = "macaddr"})  -- true
```

---

### 验证规则函数

#### verifyRules.set(value, validSet)
集合验证：检查值是否在给定集合中。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | any | 待验证的值 |
| validSet | table | 有效值集合 |

**返回值：** `boolean` - 是否在集合中

**示例：**
```lua
verifyRules.set("on", {"on", "off"})  -- true
verifyRules.set("maybe", {"on", "off"})  -- false
```

---

#### verifyRules.regex(value, pattern)
正则表达式验证。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | string | 待验证的值 |
| pattern | string | Lua正则表达式模式 |

**返回值：** `boolean` - 是否匹配

**示例：**
```lua
verifyRules.regex("abc123", "^[a-z0-9]+$")  -- true
verifyRules.regex("abc 123", "^[a-z0-9]+$")  -- false
```

---

#### verifyRules.func(value, config)
函数验证：使用自定义函数进行验证。

**参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| value | any | 待验证的值 |
| config.rule | any | 前置验证规则（可选） |
| config.func | function | 验证函数 |
| config.farg | any | 函数参数（可选） |

**返回值：** `boolean` - 验证结果

**示例：**
```lua
verifyRules.func("test", {
    func = function(v) return #v > 3 end
})  -- true
```

---

## 内置检查器

### checkers.commonstr
通用安全字符串检查器，防止命令注入。

**禁止字符：** `` ` `` `;` `>` `|` `$` `&` 和换行符

**示例：**
```lua
checkers.commonstr("hello world")  -- true
checkers.commonstr("hello; rm -rf /")  -- false
checkers.commonstr("test`whoami`")  -- false
```

---

### checkers.engXnumstr
英文+数字字符串检查器，只允许英文字母和数字。

**正则模式：** `^[a-zA-Z0-9]+$`

**示例：**
```lua
checkers.engXnumstr("abc123")  -- true
checkers.engXnumstr("abc_123")  -- false
```

---

### checkers.numberstr
纯数字字符串检查器，只允许数字字符。

**正则模式：** `^[0-9]+$`

**示例：**
```lua
checkers.numberstr("12345")  -- true
checkers.numberstr("123.45")  -- false
```

---

### checkers.macaddr
MAC地址检查器，使用luci.cbi.datatypes进行验证。

**示例：**
```lua
checkers.macaddr("AA:BB:CC:DD:EE:FF")  -- true
checkers.macaddr("AA-BB-CC-DD-EE-FF")  -- true
checkers.macaddr("invalid")  -- false
```

---

### checkers.ip4addr
IPv4地址检查器，使用luci.cbi.datatypes进行验证。

**示例：**
```lua
checkers.ip4addr("192.168.1.1")  -- true
checkers.ip4addr("256.1.1.1")  -- false
```

---

### checkers.ip6addr
IPv6地址检查器，使用luci.cbi.datatypes进行验证。

**示例：**
```lua
checkers.ip6addr("fe80::1")  -- true
checkers.ip6addr("invalid")  -- false
```

---

### checkers.json
JSON格式检查器，尝试解析JSON，成功则有效。

**示例：**
```lua
checkers.json('{"key": "value"}')  -- true
checkers.json('{invalid}')  -- false
```

---

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| checks | 类型检查库 |
| cjson | JSON解析 |
| luci.cbi.datatypes | LuCI数据类型验证 |

## 被引用情况

- `xiaoqiang/controller/api/misystem.lua` - 系统API参数验证
- `xiaoqiang/controller/api/xqnetwork.lua` - 网络API参数验证
- `xiaoqiang/controller/api/xqsystem.lua` - 系统设置参数验证

## 关键代码说明

### 命令注入防护

```lua
checkers.commonstr = function(value)
    local pattern = [[^[^`;>|$&
]+$]]
    return verifyRules.regex(value, pattern)
end
```

通过正则表达式禁止危险字符，防止Shell命令注入攻击。禁止的字符包括：
- `` ` `` - 命令替换
- `;` - 命令分隔
- `>` - 输出重定向
- `|` - 管道
- `$` - 变量引用
- `&` - 后台执行
- 换行符 - 命令分隔

### 命名检查器验证

```lua
local function namedCheckerVerify(value, config)
    local checkerName = config.name
    if checkerName then
        local checker = checkers[checkerName]
        if checker then
            return checker(value, config.arg)
        end
    end
    return false
end
```

通过检查器名称动态调用对应的验证函数，支持扩展自定义检查器。

### 类型检查封装

```lua
function verify(value, rule)
    local ruleType = type(rule)
    
    if ruleType == "string" then
        -- 使用pcall安全调用类型检查
        local success, _ = pcall(typeCheck, value, rule)
        return success
    elseif ruleType == "table" then
        -- 使用命名检查器
        return namedCheckerVerify(value, rule)
    end
    
    return false
end
```

统一的验证入口，根据规则类型选择不同的验证策略。
