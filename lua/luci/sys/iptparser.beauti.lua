--[[
LuCI iptables 规则解析器模块
luci.sys.iptparser - IPTables Parser Module

该模块提供 iptables/ip6tables 规则的解析和查询功能：
- 支持 IPv4 (iptables) 和 IPv6 (ip6tables)
- 解析规则链信息（策略、包计数、字节计数）
- 支持按条件过滤规则（表、链、目标、协议、源/目的地址、接口等）
]]--

local luci = {}
luci.util = require("luci.util")
luci.sys = require("luci.sys")
luci.ip = require("luci.ip")

local tonumber = tonumber
local ipairs = ipairs
local table = table

module("luci.sys.iptparser")

IptParser = luci.util.class()

function IptParser.__init__(self, family)
    self._family = (tonumber(family) == 6) and 6 or 4
    self._rules = {}
    self._chains = {}
    
    if self._family == 4 then
        self._nulladdr = "0.0.0.0/0"
        self._tables = { "filter", "nat", "mangle", "raw" }
        self._command = "iptables -t %s --line-numbers -nxvL"
    else
        self._nulladdr = "::/0"
        self._tables = { "filter", "mangle", "raw" }
        self._command = "ip6tables -t %s --line-numbers -nxvL"
    end
    
    self:_parse_rules()
end

function IptParser.find(self, args)
    args = args or {}
    local result = {}
    
    args.source = args.source and luci.ip.IPv4(args.source) or luci.ip.IPv6(args.source)
    args.destination = args.destination and luci.ip.IPv4(args.destination) or luci.ip.IPv6(args.destination)
    
    for _, rule in ipairs(self._rules) do
        local match = true
        
        if args.table then
            if args.table:lower() ~= rule.table then
                match = false
            end
        end
        
        if match == true then
            if args.chain and args.chain ~= rule.chain then
                match = false
            end
        end
        
        if match == true then
            if args.target and args.target ~= rule.target then
                match = false
            end
        end
        
        if match == true then
            if args.protocol and rule.protocol ~= "all" then
                if args.protocol:lower() ~= rule.protocol then
                    match = false
                end
            end
        end
        
        if match == true then
            if args.source and rule.source ~= self._nulladdr then
                local ruleSource = self:_parse_addr(rule.source)
                if not ruleSource:contains(args.source) then
                    match = false
                end
            end
        end
        
        if match == true then
            if args.destination and rule.destination ~= self._nulladdr then
                local ruleDest = self:_parse_addr(rule.destination)
                if not ruleDest:contains(args.destination) then
                    match = false
                end
            end
        end
        
        if match == true then
            if args.inputif and rule.inputif ~= "*" then
                if args.inputif ~= rule.inputif then
                    match = false
                end
            end
        end
        
        if match == true then
            if args.outputif and rule.outputif ~= "*" then
                if args.outputif ~= rule.outputif then
                    match = false
                end
            end
        end
        
        if match == true then
            if args.flags and rule.flags ~= args.flags then
                match = false
            end
        end
        
        if match == true then
            if args.options then
                if not self:_match_options(rule.options, args.options) then
                    match = false
                end
            end
        end
        
        if match == true then
            result[#result + 1] = rule
        end
    end
    
    return result
end

function IptParser.resync(self)
    self._rules = {}
    self._chain = nil
    self:_parse_rules()
end

function IptParser.tables(self)
    return self._tables
end

function IptParser.chains(self, tableName)
    local seen = {}
    local result = {}
    
    for _, rule in ipairs(self:find({ table = tableName })) do
        if not seen[rule.chain] then
            seen[rule.chain] = true
            result[#result + 1] = rule.chain
        end
    end
    
    return result
end

function IptParser.chain(self, tableName, chainName)
    local chains = self._chains[tableName:lower()]
    if chains then
        return chains[chainName]
    end
    return nil
end

function IptParser.is_custom_target(self, target)
    for _, rule in ipairs(self._rules) do
        if rule.chain == target then
            return true
        end
    end
    return false
end

function IptParser._parse_addr(self, addr)
    if self._family == 4 then
        return luci.ip.IPv4(addr)
    else
        return luci.ip.IPv6(addr)
    end
end

function IptParser._parse_rules(self)
    for _, tableName in ipairs(self._tables) do
        self._chains[tableName] = {}
        
        local command = self._command:format(tableName)
        for line in luci.util.execi(command) do
            if line:find("^Chain") == 1 then
                local chainName, policy, packets, bytes, references
                chainName, policy, packets, bytes = line:match("^Chain ([^%s]*) %(policy ([^%s]*) (%d+) packets, (%d+) bytes%)")
                
                if not chainName then
                    chainName, references = line:match("^Chain ([^%s]*) %((%d+) references%)")
                end
                
                self._chain = chainName
                self._chains[tableName][chainName] = {
                    policy = policy,
                    packets = tonumber(packets or 0),
                    bytes = tonumber(bytes or 0),
                    references = tonumber(references or 0),
                    rules = {}
                }
            elseif line:find("^%s*%d") == 1 then
                local fields = luci.util.split(line, "%s+", nil, true)
                local rule = {}
                
                local offset = 0
                if fields[4] == "--" then
                    offset = 1
                end
                
                if self._family == 6 then
                    offset = offset + 1
                end
                
                rule.table = tableName
                rule.chain = self._chain
                rule.index = tonumber(fields[1])
                rule.packets = tonumber(fields[2])
                rule.bytes = tonumber(fields[3])
                rule.target = fields[4 + offset]
                rule.protocol = fields[5 + offset]
                rule.flags = fields[6 + offset]
                rule.inputif = fields[7 + offset]
                rule.outputif = fields[8 + offset]
                rule.source = fields[9 + offset]
                rule.destination = fields[10 + offset]
                rule.options = {}
                
                for i = 11 + offset, #fields do
                    rule.options[i - 10 - offset] = fields[i]
                end
                
                self._rules[#self._rules + 1] = rule
                self._chains[tableName][self._chain].rules[#self._chains[tableName][self._chain].rules + 1] = rule
            end
        end
    end
    
    self._chain = nil
end

function IptParser._match_options(self, ruleOptions, queryOptions)
    local optionSet = {}
    for _, opt in ipairs(ruleOptions) do
        optionSet[opt] = true
    end
    
    for _, opt in ipairs(queryOptions) do
        if not optionSet[opt] then
            return false
        end
    end
    
    return true
end
