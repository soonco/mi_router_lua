--[[
    LuCI IP 地址处理模块
    提供 IP 地址和 CIDR 网络的解析、验证和操作功能
    
    主要功能:
    - IPv4/IPv6 地址解析
    - CIDR 网络计算
    - IP 地址验证
    - 网络地址计算
    - 广播地址计算
    - IP 地址比较
]]

local bit = require("bit")
local util = require("luci.util")

local type = type
local error = error
local tonumber = tonumber
local tostring = tostring
local setmetatable = setmetatable
local getmetatable = getmetatable

module("luci.ip")

-- ========================================
-- 常量定义
-- ========================================

FAMILY_INET4 = 4
FAMILY_INET6 = 6

-- ========================================
-- 内部辅助函数
-- ========================================

local function is_hex_char(char)
    return (char >= 48 and char <= 57) or
           (char >= 65 and char <= 70) or
           (char >= 97 and char <= 102)
end

local function hex_to_number(hex_str)
    return tonumber(hex_str, 16)
end

local function number_to_hex(num, width)
    return string.format("%0" .. width .. "x", num)
end

-- ========================================
-- IPv4 地址类
-- ========================================

IPv4 = util.class()

function IPv4:__init__(address, prefix)
    if type(address) == "string" then
        local parts = {}
        for part in address:gmatch("(%d+)") do
            local num = tonumber(part)
            if not num or num < 0 or num > 255 then
                error("Invalid IPv4 address")
            end
            parts[#parts + 1] = num
        end
        
        if #parts ~= 4 then
            error("Invalid IPv4 address")
        end
        
        self.addr = parts
    elseif type(address) == "table" then
        self.addr = address
    else
        error("Invalid IPv4 address type")
    end
    
    self.prefix = prefix or 32
    self.family = FAMILY_INET4
end

function IPv4:string()
    return string.format("%d.%d.%d.%d", 
        self.addr[1], self.addr[2], self.addr[3], self.addr[4])
end

function IPv4:cidr()
    return self:string() .. "/" .. self.prefix
end

function IPv4:network()
    local mask = self:mask()
    local net_addr = {}
    
    for i = 1, 4 do
        net_addr[i] = bit.band(self.addr[i], mask.addr[i])
    end
    
    return IPv4(net_addr, self.prefix)
end

function IPv4:broadcast()
    local mask = self:mask()
    local bcast_addr = {}
    
    for i = 1, 4 do
        bcast_addr[i] = bit.bor(self.addr[i], bit.bnot(mask.addr[i]) % 256)
    end
    
    return IPv4(bcast_addr, self.prefix)
end

function IPv4:mask()
    local mask_addr = { 0, 0, 0, 0 }
    local bits = self.prefix
    
    for i = 1, 4 do
        if bits >= 8 then
            mask_addr[i] = 255
            bits = bits - 8
        elseif bits > 0 then
            mask_addr[i] = bit.lshift(255, 8 - bits) % 256
            bits = 0
        end
    end
    
    return IPv4(mask_addr, 32)
end

function IPv4:host()
    return IPv4(self.addr, 32)
end

function IPv4:contains(other)
    if other.family ~= FAMILY_INET4 then
        return false
    end
    
    local my_net = self:network()
    local other_net = IPv4(other.addr, self.prefix):network()
    
    for i = 1, 4 do
        if my_net.addr[i] ~= other_net.addr[i] then
            return false
        end
    end
    
    return true
end

function IPv4:equal(other)
    if other.family ~= FAMILY_INET4 then
        return false
    end
    
    for i = 1, 4 do
        if self.addr[i] ~= other.addr[i] then
            return false
        end
    end
    
    return self.prefix == other.prefix
end

function IPv4:lower(other)
    if other.family ~= FAMILY_INET4 then
        return false
    end
    
    for i = 1, 4 do
        if self.addr[i] < other.addr[i] then
            return true
        elseif self.addr[i] > other.addr[i] then
            return false
        end
    end
    
    return false
end

function IPv4:higher(other)
    if other.family ~= FAMILY_INET4 then
        return false
    end
    
    for i = 1, 4 do
        if self.addr[i] > other.addr[i] then
            return true
        elseif self.addr[i] < other.addr[i] then
            return false
        end
    end
    
    return false
end

function IPv4:is_private()
    if self.addr[1] == 10 then
        return true
    end
    
    if self.addr[1] == 172 and self.addr[2] >= 16 and self.addr[2] <= 31 then
        return true
    end
    
    if self.addr[1] == 192 and self.addr[2] == 168 then
        return true
    end
    
    return false
end

function IPv4:is_loopback()
    return self.addr[1] == 127
end

function IPv4:is_multicast()
    return self.addr[1] >= 224 and self.addr[1] <= 239
end

-- ========================================
-- IPv6 地址类
-- ========================================

IPv6 = util.class()

function IPv6:__init__(address, prefix)
    if type(address) == "string" then
        local parts = {}
        
        local double_colon_pos = address:find("::")
        if double_colon_pos then
            local left_part = address:sub(1, double_colon_pos - 1)
            local right_part = address:sub(double_colon_pos + 2)
            
            local left_groups = {}
            for group in left_part:gmatch("([^:]+)") do
                left_groups[#left_groups + 1] = hex_to_number(group) or 0
            end
            
            local right_groups = {}
            for group in right_part:gmatch("([^:]+)") do
                right_groups[#right_groups + 1] = hex_to_number(group) or 0
            end
            
            local missing = 8 - #left_groups - #right_groups
            
            for i = 1, #left_groups do
                parts[i] = left_groups[i]
            end
            
            for i = 1, missing do
                parts[#parts + 1] = 0
            end
            
            for i = 1, #right_groups do
                parts[#parts + 1] = right_groups[i]
            end
        else
            for group in address:gmatch("([^:]+)") do
                parts[#parts + 1] = hex_to_number(group) or 0
            end
        end
        
        if #parts ~= 8 then
            error("Invalid IPv6 address")
        end
        
        self.addr = parts
    elseif type(address) == "table" then
        self.addr = address
    else
        error("Invalid IPv6 address type")
    end
    
    self.prefix = prefix or 128
    self.family = FAMILY_INET6
end

function IPv6:string()
    local parts = {}
    
    for i = 1, 8 do
        parts[i] = number_to_hex(self.addr[i], 1)
    end
    
    return table.concat(parts, ":")
end

function IPv6:full_string()
    local parts = {}
    
    for i = 1, 8 do
        parts[i] = number_to_hex(self.addr[i], 4)
    end
    
    return table.concat(parts, ":")
end

function IPv6:cidr()
    return self:string() .. "/" .. self.prefix
end

function IPv6:network()
    local net_addr = {}
    local bits = self.prefix
    
    for i = 1, 8 do
        if bits >= 16 then
            net_addr[i] = self.addr[i]
            bits = bits - 16
        elseif bits > 0 then
            local mask = bit.lshift(0xFFFF, 16 - bits)
            net_addr[i] = bit.band(self.addr[i], mask)
            bits = 0
        else
            net_addr[i] = 0
        end
    end
    
    return IPv6(net_addr, self.prefix)
end

function IPv6:host()
    return IPv6(self.addr, 128)
end

function IPv6:contains(other)
    if other.family ~= FAMILY_INET6 then
        return false
    end
    
    local my_net = self:network()
    local other_net = IPv6(other.addr, self.prefix):network()
    
    for i = 1, 8 do
        if my_net.addr[i] ~= other_net.addr[i] then
            return false
        end
    end
    
    return true
end

function IPv6:equal(other)
    if other.family ~= FAMILY_INET6 then
        return false
    end
    
    for i = 1, 8 do
        if self.addr[i] ~= other.addr[i] then
            return false
        end
    end
    
    return self.prefix == other.prefix
end

function IPv6:is_loopback()
    for i = 1, 7 do
        if self.addr[i] ~= 0 then
            return false
        end
    end
    return self.addr[8] == 1
end

function IPv6:is_link_local()
    return self.addr[1] == 0xfe80
end

function IPv6:is_multicast()
    return bit.band(self.addr[1], 0xff00) == 0xff00
end

-- ========================================
-- 便捷函数
-- ========================================

function new(address, prefix)
    if type(address) ~= "string" then
        return nil
    end
    
    if address:find(":") then
        local ok, result = pcall(IPv6, address, prefix)
        if ok then
            return result
        end
    else
        local ok, result = pcall(IPv4, address, prefix)
        if ok then
            return result
        end
    end
    
    return nil
end

function IPv4(address, prefix)
    local obj = {}
    setmetatable(obj, { __index = IPv4 })
    IPv4.__init__(obj, address, prefix)
    return obj
end

function IPv6(address, prefix)
    local obj = {}
    setmetatable(obj, { __index = IPv6 })
    IPv6.__init__(obj, address, prefix)
    return obj
end

function checkip4(address)
    local parts = {}
    
    for part in address:gmatch("(%d+)") do
        local num = tonumber(part)
        if not num or num < 0 or num > 255 then
            return false
        end
        parts[#parts + 1] = num
    end
    
    return #parts == 4
end

function checkip6(address)
    local ok, _ = pcall(function()
        IPv6(address)
    end)
    return ok
end

function checkcidr4(cidr)
    local addr, prefix = cidr:match("^(.+)/(%d+)$")
    
    if not addr or not prefix then
        return false
    end
    
    prefix = tonumber(prefix)
    if not prefix or prefix < 0 or prefix > 32 then
        return false
    end
    
    return checkip4(addr)
end

function checkcidr6(cidr)
    local addr, prefix = cidr:match("^(.+)/(%d+)$")
    
    if not addr or not prefix then
        return false
    end
    
    prefix = tonumber(prefix)
    if not prefix or prefix < 0 or prefix > 128 then
        return false
    end
    
    return checkip6(addr)
end
