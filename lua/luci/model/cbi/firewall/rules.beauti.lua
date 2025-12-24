--[[
    防火墙流量规则列表页面
    
    功能说明:
    - 显示所有流量规则(Traffic Rules)的列表
    - 支持添加、删除、排序流量规则
    - 包含普通规则和SNAT(源地址转换)规则两个部分
    - 提供快速添加规则的表单
    
    流量规则(Traffic Rules)说明:
    - 定义不同区域之间的流量策略
    - 可以允许(ACCEPT)、拒绝(REJECT)、丢弃(DROP)流量
    - 例如: 允许WAN区域访问路由器的SSH端口
    
    SNAT(源NAT)说明:
    - 修改出站流量的源IP地址
    - 用于多WAN负载均衡或特定出口IP需求
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 编辑 /etc/config/firewall 中的 rule 和 redirect(SNAT) 配置段
    
    配置存储: /etc/config/firewall
]]

local dispatcher = require("luci.dispatcher")
local firewallTools = require("luci.tools.firewall")

-- ============================================================
-- 创建配置映射 (Map)
-- ============================================================
local firewallMap = Map(
    "firewall",
    translate("Firewall - Traffic Rules"),
    translate(
        "Traffic rules define policies for packets traveling between " ..
        "different zones, for example to reject traffic between certain hosts " ..
        "or to open WAN ports on the router."
    )
)

-- ============================================================
-- 第一部分: 流量规则列表 (TypedSection)
-- ============================================================
local ruleSection = firewallMap:section(
    TypedSection,
    "rule",
    translate("Traffic Rules")
)

-- 允许添加和删除规则
ruleSection.addremove = true

-- 匿名配置段
ruleSection.anonymous = true

-- 允许拖拽排序
ruleSection.sortable = true

-- 使用表格模板显示
ruleSection.template = "cbi/tblsection"

-- 点击编辑跳转到详情页
ruleSection.extedit = dispatcher.build_url("admin/network/firewall/rules/%s")

-- 新规则默认动作为ACCEPT
ruleSection.defaults.target = "ACCEPT"

-- 使用自定义添加模板
ruleSection.template_addremove = "firewall/cbi_addrule"

-- ============================================================
-- 创建新规则的处理函数
-- ============================================================
function ruleSection.create(self, sectionId)
    local created = TypedSection.create(self, sectionId)
end

-- ============================================================
-- 解析表单并处理新规则创建
-- ============================================================
function ruleSection.parse(self, ...)
    TypedSection.parse(self, ...)
    
    -- 处理"打开端口"表单
    local openName = firewallMap:formvalue("_newopen.name")
    local openProto = firewallMap:formvalue("_newopen.proto")
    local openPort = firewallMap:formvalue("_newopen.extport")
    local openSubmit = firewallMap:formvalue("_newopen.submit")
    
    -- 处理"转发规则"表单
    local fwdName = firewallMap:formvalue("_newfwd.name")
    local fwdSrc = firewallMap:formvalue("_newfwd.src")
    local fwdDest = firewallMap:formvalue("_newfwd.dest")
    local fwdSubmit = firewallMap:formvalue("_newfwd.submit")
    
    if openSubmit then
        -- 创建"打开端口"规则
        local created = TypedSection.create(self, section)
        self.map:set(created, "target", "ACCEPT")
        self.map:set(created, "src", "wan")
        self.map:set(created, "proto", (openProto == "other" or not openProto) and "all" or openProto)
        self.map:set(created, "dest_port", openPort)
        self.map:set(created, "name", openName)
        
        -- 如果协议不是other且有端口，清除created
        if openProto ~= "other" and openPort and #openPort > 0 then
            created = nil
        end
    elseif fwdSubmit then
        -- 创建"区域转发"规则
        local created = TypedSection.create(self, section)
        self.map:set(created, "target", "ACCEPT")
        self.map:set(created, "src", fwdSrc)
        self.map:set(created, "dest", fwdDest)
        self.map:set(created, "name", fwdName)
    end
    
    -- 如果创建了新规则，保存并跳转
    if created then
        firewallMap.uci:save("firewall")
        luci.http.redirect(dispatcher.build_url("admin/network/firewall/rules", created))
    end
end

-- ============================================================
-- 流量规则表格列定义
-- ============================================================

-- 规则名称列
firewallTools.opt_name(ruleSection, DummyValue, translate("Name"))

-- 协议格式化函数
local function formatProtocol(self, sectionId)
    local family = self.map:get(sectionId, "family")
    local proto = firewallTools.fmt_proto(
        self.map:get(sectionId, "proto"),
        self.map:get(sectionId, "icmp_type")
    ) or translate("Any")
    
    if family and family:match("4") then
        return "%s-%s" % {translate("IPv4"), proto}
    elseif family and family:match("6") then
        return "%s-%s" % {translate("IPv6"), proto}
    else
        return "%s %s" % {translate("Any"), proto}
    end
end

-- 源信息格式化函数
local function formatSource(self, sectionId)
    local zone = firewallTools.fmt_zone(
        self.map:get(sectionId, "src"),
        translate("any zone")
    )
    local ip = firewallTools.fmt_ip(
        self.map:get(sectionId, "src_ip"),
        translate("any host")
    )
    local port = firewallTools.fmt_port(self.map:get(sectionId, "src_port"))
    local mac = firewallTools.fmt_mac(self.map:get(sectionId, "src_mac"))
    
    if port and mac then
        return translatef("From %s in %s with source %s and %s", ip, zone, port, mac)
    elseif port or mac then
        return translatef("From %s in %s with source %s", ip, zone, port or mac)
    else
        return translatef("From %s in %s", ip, zone)
    end
end

-- 目标信息格式化函数
local function formatDestination(self, sectionId)
    local zone = firewallTools.fmt_zone(self.map:get(sectionId, "dest"))
    local port = firewallTools.fmt_port(self.map:get(sectionId, "dest_port"))
    
    if zone then
        local ip = firewallTools.fmt_ip(
            self.map:get(sectionId, "dest_ip"),
            translate("any host")
        )
        if port then
            return translatef("To %s, %s in %s", ip, port, zone)
        else
            return translatef("To %s in %s", ip, zone)
        end
    else
        local ip = firewallTools.fmt_ip(
            self.map:get(sectionId, "dest_ip"),
            translate("any router IP")
        )
        if port then
            return translatef("To %s at %s on <var>this device</var>", ip, port)
        else
            return translatef("To %s on <var>this device</var>", ip)
        end
    end
end

-- 匹配条件显示列
local matchColumn = ruleSection:option(DummyValue, "match", translate("Match"))
matchColumn.rawhtml = true
matchColumn.width = "70%"

function matchColumn.cfgvalue(self, sectionId)
    return "<small>%s<br />%s<br />%s</small>" % {
        formatProtocol(self, sectionId),
        formatSource(self, sectionId),
        formatDestination(self, sectionId)
    }
end

-- 动作列
local targetColumn = ruleSection:option(DummyValue, "target", translate("Action"))
targetColumn.rawhtml = true
targetColumn.width = "20%"

function targetColumn.cfgvalue(self, sectionId)
    local target = firewallTools.fmt_target(
        self.map:get(sectionId, "target"),
        self.map:get(sectionId, "dest")
    )
    local limit = firewallTools.fmt_limit(
        self.map:get(sectionId, "limit"),
        self.map:get(sectionId, "limit_burst")
    )
    
    if limit then
        return translatef("<var>%s</var> and limit to %s", target, limit)
    else
        return "<var>%s</var>" % target
    end
end

-- 启用开关列
local enabledColumn = firewallTools.opt_enabled(ruleSection, Flag, translate("Enable"))
enabledColumn.width = "1%"

-- ============================================================
-- 第二部分: SNAT规则列表 (TypedSection)
-- ============================================================
local snatSection = firewallMap:section(
    TypedSection,
    "redirect",
    translate("Source NAT"),
    translate(
        "Source NAT is a specific form of masquerading which allows " ..
        "fine grained control over the source IP used for outgoing traffic, " ..
        "for example to map multiple WAN addresses to internal subnets."
    )
)

-- 使用表格模板显示
snatSection.template = "cbi/tblsection"

-- 允许添加和删除规则
snatSection.addremove = true

-- 匿名配置段
snatSection.anonymous = true

-- 允许拖拽排序
snatSection.sortable = true

-- 点击编辑跳转到详情页
snatSection.extedit = dispatcher.build_url("admin/network/firewall/rules/%s")

-- 使用自定义添加模板
snatSection.template_addremove = "firewall/cbi_addsnat"

-- ============================================================
-- 过滤函数: 只显示SNAT规则
-- ============================================================
function snatSection.filter(self, sectionId)
    local target = self.map:get(sectionId, "target")
    return target == "SNAT"
end

-- ============================================================
-- SNAT规则创建和解析
-- ============================================================
function snatSection.create(self, sectionId)
    local created = TypedSection.create(self, sectionId)
end

function snatSection.parse(self, ...)
    TypedSection.parse(self, ...)
    
    -- 处理新SNAT规则表单
    local snatName = firewallMap:formvalue("_newsnat.name")
    local snatSrc = firewallMap:formvalue("_newsnat.src")
    local snatDest = firewallMap:formvalue("_newsnat.dest")
    local snatDip = firewallMap:formvalue("_newsnat.dip")
    local snatDport = firewallMap:formvalue("_newsnat.dport")
    local snatSubmit = firewallMap:formvalue("_newsnat.submit")
    
    if snatSubmit and snatDip and #snatDip > 0 then
        local created = TypedSection.create(self, section)
        self.map:set(created, "target", "SNAT")
        self.map:set(created, "src", snatSrc)
        self.map:set(created, "dest", snatDest)
        self.map:set(created, "proto", "all")
        self.map:set(created, "src_dip", snatDip)
        self.map:set(created, "src_dport", snatDport)
        self.map:set(created, "name", snatName)
    end
    
    if created then
        firewallMap.uci:save("firewall")
        luci.http.redirect(dispatcher.build_url("admin/network/firewall/rules", created))
    end
end

-- ============================================================
-- SNAT规则表格列定义
-- ============================================================

-- 规则名称列
firewallTools.opt_name(snatSection, DummyValue, translate("Name"))

-- SNAT源信息格式化函数
local function formatSnatSource(self, sectionId)
    local zone = firewallTools.fmt_zone(
        self.map:get(sectionId, "dest"),
        translate("any zone")
    )
    local ip = firewallTools.fmt_ip(
        self.map:get(sectionId, "dest_ip"),
        translate("any host")
    )
    local port = firewallTools.fmt_port(self.map:get(sectionId, "dest_port"))
    
    if not port then
        port = firewallTools.fmt_port(self.map:get(sectionId, "src_dport"))
    end
    
    if port then
        return translatef("To %s, %s in %s", ip, port, zone)
    else
        return translatef("To %s in %s", ip, zone)
    end
end

-- 匹配条件显示列
local snatMatchColumn = snatSection:option(DummyValue, "match", translate("Match"))
snatMatchColumn.rawhtml = true
snatMatchColumn.width = "70%"

function snatMatchColumn.cfgvalue(self, sectionId)
    return "<small>%s<br />%s<br />%s</small>" % {
        formatProtocol(self, sectionId),
        formatSource(self, sectionId),
        formatSnatSource(self, sectionId)
    }
end

-- SNAT动作列 (显示重写的源IP和端口)
local snatActionColumn = snatSection:option(DummyValue, "via", translate("Action"))
snatActionColumn.rawhtml = true
snatActionColumn.width = "20%"

function snatActionColumn.cfgvalue(self, sectionId)
    local ip = firewallTools.fmt_ip(self.map:get(sectionId, "src_dip"))
    local port = firewallTools.fmt_port(self.map:get(sectionId, "src_dport"))
    
    if ip and port then
        return translatef("Rewrite to source %s, %s", ip, port)
    else
        return translatef("Rewrite to source %s", ip or port)
    end
end

-- 启用开关列
local snatEnabledColumn = firewallTools.opt_enabled(snatSection, Flag, translate("Enable"))
snatEnabledColumn.width = "1%"

return firewallMap
