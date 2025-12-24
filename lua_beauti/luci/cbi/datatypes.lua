--[[
    LuCI CBI 数据类型验证模块 (Data Types Validation Module)
    
    功能说明:
    - 提供各种数据类型的验证函数
    - 用于CBI表单输入值的合法性检查
    - 支持IP地址、端口、MAC地址、主机名等网络相关验证
    - 支持数值范围、字符串长度等通用验证
    
    主要验证类型:
    - 布尔值: bool
    - 数值: integer, uinteger, float, ufloat
    - 网络: ipaddr, ip4addr, ip6addr, port, portrange, macaddr
    - 主机: hostname, host, network
    - 安全: wpakey, wepkey
    - 文件: file, directory, device
    - 通用: string, uciname, range, min, max, minlength, maxlength
    
    依赖模块:
    - nixio.fs: 文件系统操作
    - luci.ip: IP地址处理
    - math: 数学函数
    - luci.util: 工具函数
]]

local fs = require("nixio.fs")
local ip = require("luci.ip")
local math = require("math")
local util = require("luci.util")

local tonumber = tonumber
local tostring = tostring
local type = type
local unpack = unpack
local select = select

module("luci.cbi.datatypes")

local datatypes = _M

--[[
    逻辑或验证
    
    检查值是否满足任一验证条件
    
    @param value any 要验证的值
    @param ... 验证函数或值列表
    @return boolean 任一条件满足返回true
]]
datatypes["or"] = function(value, ...)
    local args = {...}
    
    for i = 1, select("#", ...), 2 do
        local validator = select(i, ...)
        local param = select(i + 1, ...)
        
        if type(validator) ~= "function" then
            -- 直接比较值
            if validator == value then
                return true
            end
        else
            -- 调用验证函数
            if validator(value, unpack(param)) then
                return true
            end
        end
    end
    
    return false
end

--[[
    逻辑与验证
    
    检查值是否满足所有验证条件
    
    @param value any 要验证的值
    @param ... 验证函数或值列表
    @return boolean 所有条件满足返回true
]]
datatypes["and"] = function(value, ...)
    local args = {...}
    
    for i = 1, select("#", ...), 2 do
        local validator = select(i, ...)
        local param = select(i + 1, ...)
        
        if type(validator) ~= "function" then
            -- 直接比较值
            if validator ~= value then
                return false
            end
        else
            -- 调用验证函数
            if not validator(value, unpack(param)) then
                return false
            end
        end
    end
    
    return true
end

--[[
    否定验证
    
    去除值前面的感叹号后进行或验证
    
    @param value any 要验证的值
    @param ... 验证参数
    @return boolean 验证结果
]]
function neg(value, ...)
    local cleaned = value:gsub("^%s*!%s*", "")
    return datatypes["or"](cleaned, ...)
end

--[[
    列表验证
    
    对列表中的每个元素进行验证
    
    @param value string 以空格分隔的值列表
    @param validator function 验证函数
    @param ... 验证函数的额外参数
    @return boolean 所有元素验证通过返回true
]]
function list(value, validator, ...)
    if type(validator) ~= "function" then
        return false
    end
    
    for item in value:gmatch("%S+") do
        if not validator(item, ...) then
            return false
        end
    end
    
    return true
end

--[[
    布尔值验证
    
    检查值是否为有效的布尔表示
    有效值: "1", "yes", "on", "true", "0", "no", "off", "false", "", nil
    
    @param value string 要验证的值
    @return boolean 是否为有效布尔值
]]
function bool(value)
    if value == "1" or value == "yes" or value == "on" or value == "true" then
        return true
    elseif value == "0" or value == "no" or value == "off" or value == "false" then
        return true
    elseif value == "" or value == nil then
        return true
    end
    return false
end

--[[
    无符号整数验证
    
    检查值是否为非负整数
    
    @param value string 要验证的值
    @return boolean 是否为无符号整数
]]
function uinteger(value)
    local num = tonumber(value)
    if num ~= nil then
        if math.floor(num) == num and num >= 0 then
            return true
        end
    end
    return false
end

--[[
    整数验证
    
    检查值是否为整数(可正可负)
    
    @param value string 要验证的值
    @return boolean 是否为整数
]]
function integer(value)
    local num = tonumber(value)
    if num ~= nil then
        if math.floor(num) == num then
            return true
        end
    end
    return false
end

--[[
    无符号浮点数验证
    
    检查值是否为非负浮点数
    
    @param value string 要验证的值
    @return boolean 是否为无符号浮点数
]]
function ufloat(value)
    local num = tonumber(value)
    return num ~= nil and num >= 0
end

--[[
    浮点数验证
    
    检查值是否为有效浮点数
    
    @param value string 要验证的值
    @return boolean 是否为浮点数
]]
function float(value)
    local num = tonumber(value)
    return num ~= nil
end

--[[
    IP地址验证
    
    检查值是否为有效的IPv4或IPv6地址
    
    @param value string 要验证的值
    @return boolean 是否为有效IP地址
]]
function ipaddr(value)
    return ip4addr(value) or ip6addr(value)
end

--[[
    IPv4地址验证
    
    检查值是否为有效的IPv4地址
    
    @param value string 要验证的值
    @return boolean 是否为有效IPv4地址
]]
function ip4addr(value)
    if value then
        if ip.IPv4(value) then
            return true
        end
        return false
    end
    return false
end

--[[
    IPv4前缀验证
    
    检查值是否为有效的IPv4前缀长度(0-32)
    
    @param value string 要验证的值
    @return boolean 是否为有效IPv4前缀
]]
function ip4prefix(value)
    local num = tonumber(value)
    return num and num >= 0 and num <= 32
end

--[[
    IPv6地址验证
    
    检查值是否为有效的IPv6地址
    
    @param value string 要验证的值
    @return boolean 是否为有效IPv6地址
]]
function ip6addr(value)
    if value then
        if ip.IPv6(value) then
            return true
        end
        return false
    end
    return false
end

--[[
    IPv6前缀验证
    
    检查值是否为有效的IPv6前缀长度(0-128)
    
    @param value string 要验证的值
    @return boolean 是否为有效IPv6前缀
]]
function ip6prefix(value)
    local num = tonumber(value)
    return num and num >= 0 and num <= 128
end

--[[
    端口号验证
    
    检查值是否为有效的端口号(0-65535)
    
    @param value string 要验证的值
    @return boolean 是否为有效端口号
]]
function port(value)
    local num = tonumber(value)
    return num and num >= 0 and num <= 65535
end

--[[
    端口范围验证
    
    检查值是否为有效的端口或端口范围(如 "80" 或 "1024-65535")
    
    @param value string 要验证的值
    @return boolean 是否为有效端口范围
]]
function portrange(value)
    local start_port, end_port = value:match("^(%d+)%-(%d+)$")
    
    if start_port and end_port then
        if port(start_port) and port(end_port) then
            return true
        end
    else
        return port(value)
    end
end

--[[
    MAC地址验证
    
    检查值是否为有效的MAC地址
    格式: XX:XX:XX:XX:XX:XX (十六进制)
    
    @param value string 要验证的值
    @return boolean 是否为有效MAC地址
]]
function macaddr(value)
    if value then
        if value:match("^[a-fA-F0-9]+:[a-fA-F0-9]+:[a-fA-F0-9]+:[a-fA-F0-9]+:[a-fA-F0-9]+:[a-fA-F0-9]+$") then
            local parts = util.split(value, ":")
            
            for i = 1, 6 do
                parts[i] = tonumber(parts[i], 16)
                if parts[i] < 0 or parts[i] > 255 then
                    return false
                end
            end
            
            return true
        end
    end
    
    return false
end

--[[
    主机名验证
    
    检查值是否为有效的主机名
    规则:
    - 长度不超过253字符
    - 只包含字母、数字、下划线、连字符和点
    - 不能以数字和点组成(避免与IP地址混淆)
    
    @param value string 要验证的值
    @return boolean 是否为有效主机名
]]
function hostname(value)
    if value then
        if #value < 254 then
            -- 纯字母加下划线
            if value:match("^[a-zA-Z_]+$") then
                return true
            end
            -- 字母数字开头和结尾，中间可包含连字符和点
            if value:match("^[a-zA-Z0-9_][a-zA-Z0-9_%-%.]*[a-zA-Z0-9]$") then
                -- 确保不是纯数字和点(避免与IP混淆)
                if value:match("[^0-9%.]") then
                    return true
                end
            end
        end
    end
    
    return false
end

--[[
    主机验证
    
    检查值是否为有效的主机名或IP地址
    
    @param value string 要验证的值
    @return boolean 是否为有效主机
]]
function host(value)
    return hostname(value) or ipaddr(value)
end

--[[
    网络验证
    
    检查值是否为有效的网络名称(UCI名称或主机)
    
    @param value string 要验证的值
    @return boolean 是否为有效网络名称
]]
function network(value)
    return uciname(value) or host(value)
end

--[[
    WPA密钥验证
    
    检查值是否为有效的WPA/WPA2密钥
    规则:
    - 64位十六进制字符串
    - 或8-63个ASCII字符
    
    @param value string 要验证的值
    @return boolean 是否为有效WPA密钥
]]
function wpakey(value)
    if #value == 64 then
        -- 64位十六进制
        return value:match("^[a-fA-F0-9]+$") ~= nil
    else
        -- 8-63个字符
        return #value >= 8
    end
end

--[[
    WEP密钥验证
    
    检查值是否为有效的WEP密钥
    规则:
    - 10或26位十六进制字符串
    - 或5或13个ASCII字符(可带s:前缀)
    
    @param value string 要验证的值
    @return boolean 是否为有效WEP密钥
]]
function wepkey(value)
    -- 处理s:前缀(ASCII字符串标识)
    if value:sub(1, 2) == "s:" then
        value = value:sub(3)
    end
    
    -- 十六进制格式: 10位(40bit)或26位(104bit)
    if #value == 10 or #value == 26 then
        return value:match("^[a-fA-F0-9]+$") ~= nil
    end
    
    -- ASCII格式: 5字符(40bit)或13字符(104bit)
    return #value == 5 or #value == 13
end

--[[
    字符串验证
    
    任何字符串都有效
    
    @param value string 要验证的值
    @return boolean 始终返回true
]]
function string(value)
    return true
end

--[[
    目录验证
    
    检查路径是否为有效的目录
    支持符号链接解析
    
    @param path string 要验证的路径
    @param visited table 已访问的inode(防止循环链接)
    @return boolean 是否为有效目录
]]
function directory(path, visited)
    local stat = fs.stat(path)
    
    if not visited then
        visited = {}
    end
    
    if stat then
        -- 防止循环链接
        if not visited[stat.ino] then
            visited[stat.ino] = true
            
            if stat.type == "dir" then
                return true
            elseif stat.type == "lnk" then
                -- 递归检查符号链接目标
                return directory(fs.readlink(path), visited)
            end
        end
    end
    
    return false
end

--[[
    文件验证
    
    检查路径是否为有效的普通文件
    支持符号链接解析
    
    @param path string 要验证的路径
    @param visited table 已访问的inode(防止循环链接)
    @return boolean 是否为有效文件
]]
function file(path, visited)
    local stat = fs.stat(path)
    
    if not visited then
        visited = {}
    end
    
    if stat then
        -- 防止循环链接
        if not visited[stat.ino] then
            visited[stat.ino] = true
            
            if stat.type == "reg" then
                return true
            elseif stat.type == "lnk" then
                -- 递归检查符号链接目标
                return file(fs.readlink(path), visited)
            end
        end
    end
    
    return false
end

--[[
    设备验证
    
    检查路径是否为有效的设备文件(字符设备或块设备)
    支持符号链接解析
    
    @param path string 要验证的路径
    @param visited table 已访问的inode(防止循环链接)
    @return boolean 是否为有效设备
]]
function device(path, visited)
    local stat = fs.stat(path)
    
    if not visited then
        visited = {}
    end
    
    if stat then
        -- 防止循环链接
        if not visited[stat.ino] then
            visited[stat.ino] = true
            
            if stat.type == "chr" or stat.type == "blk" then
                return true
            elseif stat.type == "lnk" then
                -- 递归检查符号链接目标
                return device(fs.readlink(path), visited)
            end
        end
    end
    
    return false
end

--[[
    UCI名称验证
    
    检查值是否为有效的UCI配置名称
    规则: 只包含字母、数字和下划线
    
    @param value string 要验证的值
    @return boolean 是否为有效UCI名称
]]
function uciname(value)
    return value:match("^[a-zA-Z0-9_]+$") ~= nil
end

--[[
    数值范围验证
    
    检查数值是否在指定范围内
    
    @param value string 要验证的值
    @param min_val string 最小值
    @param max_val string 最大值
    @return boolean 是否在范围内
]]
function range(value, min_val, max_val)
    value = tonumber(value)
    min_val = tonumber(min_val)
    max_val = tonumber(max_val)
    
    if value ~= nil and min_val ~= nil and max_val ~= nil then
        return value >= min_val and value <= max_val
    end
    
    return false
end

--[[
    最小值验证
    
    检查数值是否大于等于指定最小值
    
    @param value string 要验证的值
    @param min_val string 最小值
    @return boolean 是否满足最小值要求
]]
function min(value, min_val)
    value = tonumber(value)
    min_val = tonumber(min_val)
    
    if value ~= nil and min_val ~= nil then
        return value >= min_val
    end
    
    return false
end

--[[
    最大值验证
    
    检查数值是否小于等于指定最大值
    
    @param value string 要验证的值
    @param max_val string 最大值
    @return boolean 是否满足最大值要求
]]
function max(value, max_val)
    value = tonumber(value)
    max_val = tonumber(max_val)
    
    if value ~= nil and max_val ~= nil then
        return value <= max_val
    end
    
    return false
end

--[[
    字符串长度范围验证
    
    检查字符串长度是否在指定范围内
    
    @param value string 要验证的值
    @param min_len string 最小长度
    @param max_len string 最大长度
    @return boolean 是否在长度范围内
]]
function rangelength(value, min_len, max_len)
    value = tostring(value)
    min_len = tonumber(min_len)
    max_len = tonumber(max_len)
    
    if value ~= nil and min_len ~= nil and max_len ~= nil then
        local len = #value
        return len >= min_len and len <= max_len
    end
    
    return false
end

--[[
    最小长度验证
    
    检查字符串长度是否大于等于指定最小长度
    
    @param value string 要验证的值
    @param min_len string 最小长度
    @return boolean 是否满足最小长度要求
]]
function minlength(value, min_len)
    value = tostring(value)
    min_len = tonumber(min_len)
    
    if value ~= nil and min_len ~= nil then
        return #value >= min_len
    end
    
    return false
end

--[[
    最大长度验证
    
    检查字符串长度是否小于等于指定最大长度
    
    @param value string 要验证的值
    @param max_len string 最大长度
    @return boolean 是否满足最大长度要求
]]
function maxlength(value, max_len)
    value = tostring(value)
    max_len = tonumber(max_len)
    
    if value ~= nil and max_len ~= nil then
        return #value <= max_len
    end
    
    return false
end

--[[
    电话号码数字验证
    
    检查值是否只包含电话号码允许的字符(数字、*、#)
    
    @param value string 要验证的值
    @return boolean 是否为有效电话号码数字
]]
function phonedigit(value)
    return value:match("^[0-9*#]+$") ~= nil
end
