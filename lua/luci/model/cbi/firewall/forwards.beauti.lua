--[[
    端口转发列表页面
    
    功能说明:
    - 显示所有端口转发(DNAT)规则的列表
    - 支持添加、删除、排序端口转发规则
    - 提供快速添加端口转发的表单
    - 点击规则可进入详细编辑页面
    
    端口转发(Port Forward)说明:
    - 将外网访问路由器特定端口的流量转发到内网主机
    - 实现内网服务器对外提供服务
    - 例如: 外网访问 WAN_IP:8080 -> 转发到 192.168.1.100:80
    
    CBI框架说明:
    - 本文件是LuCI CBI模块
    - 编辑 /etc/config/firewall 中的 redirect 配置段
    - 仅显示 target=DNAT 的规则(排除SNAT)
    
    配置存储: /etc/config/firewall
]]

local dispatcher = require("luci.dispatcher")
local firewallTools = require("luci.tools.firewall")

-- ============================================================
-- 创建配置映射 (Map)
-- ============================================================
local firewallMap = Map(
    "firewall",
    translate("Firewall - Port Forwards"),
    translate(
        "Port forwarding allows remote computers on the Internet to " ..
        "connect to a specific computer or service within the private LAN."
    )
)

-- ============================================================
-- 创建端口转发规则列表 (TypedSection)
-- ============================================================
local forwardSection = firewallMap:section(
    TypedSection,
    "redirect",
    translate("Port Forwards")
)

-- 使用表格模板显示
forwardSection.template = "cbi/tblsection"

-- 允许添加和删除规则
forwardSection.addremove = true

-- 匿名配置段
forwardSection.anonymous = true

-- 允许拖拽排序
forwardSection.sortable = true

-- 点击编辑跳转到详情页
forwardSection.extedit = dispatcher.build_url("admin/network/firewall/forwards/%s")

-- 使用自定义添加模板
forwardSection.template_addremove = "firewall/cbi_addforward"

-- ============================================================
-- 过滤函数: 只显示DNAT规则
-- ============================================================
function forwardSection.filter(self, sectionId)
    local target = firewallMap:get(sectionId, "target")
    -- 排除SNAT规则，只显示DNAT(端口转发)规则
    return target ~= "SNAT"
end

-- ============================================================
-- 创建新规则的处理函数
-- ============================================================
function forwardSection.create(self, sectionId)
    -- 从表单获取新规则参数
    local name = firewallMap:formvalue("_newfwd.name")
    local proto = firewallMap:formvalue("_newfwd.proto")
    local extZone = firewallMap:formvalue("_newfwd.extzone")
    local extPort = firewallMap:formvalue("_newfwd.extport")
    local intZone = firewallMap:formvalue("_newfwd.intzone")
    local intAddr = firewallMap:formvalue("_newfwd.intaddr")
    local intPort = firewallMap:formvalue("_newfwd.intport")
    
    -- 验证必填项: 协议为other或有内部地址
    if proto == "other" or (proto and intAddr) then
        -- 创建新配置段
        local created = TypedSection.create(self, sectionId)
        
        -- 设置规则属性
        self.map:set(created, "target", "DNAT")
        self.map:set(created, "src", extZone or "wan")
        self.map:set(created, "dest", intZone or "lan")
        self.map:set(created, "proto", (proto == "other" or not proto) and "all" or proto)
        self.map:set(created, "src_dport", extPort)
        self.map:set(created, "dest_ip", intAddr)
        self.map:set(created, "dest_port", intPort)
        self.map:set(created, "name", name)
    end
    
    -- 如果协议不是other，清除created变量
    if proto ~= "other" then
        created = nil
    end
end

-- ============================================================
-- 解析表单并处理重定向
-- ============================================================
function forwardSection.parse(self, ...)
    TypedSection.parse(self, ...)
    
    -- 如果创建了新规则，保存并跳转到编辑页面
    if created then
        firewallMap.uci:save("firewall")
        luci.http.redirect(dispatcher.build_url("admin/network/firewall/redirect", created))
    end
end

-- ============================================================
-- 表格列定义
-- ============================================================

-- 规则名称列
firewallTools.opt_name(forwardSection, DummyValue, translate("Name"))

-- 协议列 (显示格式化的协议信息)
local function formatProtocol(self, sectionId)
    local proto = firewallTools.fmt_proto(
        self.map:get(sectionId, "proto"),
        self.map:get(sectionId, "icmp_type")
    ) or translate("Any")
    return "%s-%s" % {translate("IPv4"), proto}
end

-- 匹配条件列 (源地址/端口信息)
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

-- 外部访问点列 (WAN侧IP和端口)
local function formatExternal(self, sectionId)
    local ip = firewallTools.fmt_ip(
        self.map:get(sectionId, "src_dip"),
        translate("any router IP")
    )
    local port = firewallTools.fmt_port(self.map:get(sectionId, "src_dport"))
    
    if port then
        return translatef("Via %s at %s", ip, port)
    else
        return translatef("Via %s", ip)
    end
end

-- 匹配条件显示列
local matchColumn = forwardSection:option(DummyValue, "match", translate("Match"))
matchColumn.rawhtml = true
matchColumn.width = "50%"

function matchColumn.cfgvalue(self, sectionId)
    return "<small>%s<br />%s<br />%s</small>" % {
        formatProtocol(self, sectionId),
        formatSource(self, sectionId),
        formatExternal(self, sectionId)
    }
end

-- 转发目标列 (内网主机和端口)
local destColumn = forwardSection:option(DummyValue, "dest", translate("Forward to"))
destColumn.rawhtml = true
destColumn.width = "40%"

function destColumn.cfgvalue(self, sectionId)
    local zone = firewallTools.fmt_zone(
        self.map:get(sectionId, "dest"),
        translate("any zone")
    )
    local ip = firewallTools.fmt_ip(
        self.map:get(sectionId, "dest_ip"),
        translate("any host")
    )
    local port = firewallTools.fmt_port(self.map:get(sectionId, "dest_port"))
    
    -- 如果没有指定目标端口，使用源端口
    if not port then
        port = firewallTools.fmt_port(self.map:get(sectionId, "src_dport"))
    end
    
    if port then
        return translatef("%s, %s in %s", ip, port, zone)
    else
        return translatef("%s in %s", ip, zone)
    end
end

-- 启用开关列
local enabledColumn = firewallTools.opt_enabled(forwardSection, Flag, translate("Enable"))
enabledColumn.width = "1%"

return firewallMap
