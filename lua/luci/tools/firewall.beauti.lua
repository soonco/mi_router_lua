--[[
  LuCI 防火墙工具模块
  
  提供防火墙规则的格式化显示和CBI表单选项辅助函数
  用于在Web界面中美化显示防火墙规则的各种参数
]]

module("luci.tools.firewall", package.seeall)

local util = require("luci.util")
local ip = require("luci.ip")
local nxo = require("nixio")

local translate = luci.i18n.translate
local translatef = luci.i18n.translatef

-- 将值转换为字符串
local function tostring_value(value)
  return tostring(translate(value))
end

-- 格式化否定前缀
-- 处理以"!"开头的值，返回处理后的值和否定前缀
function fmt_neg(value)
  if type(value) == "string" then
    local stripped, count = value:gsub("^ *! *", "")
    if count > 0 then
      local not_prefix = translate("not")
      return stripped, "%s " % not_prefix
    else
      return value, ""
    end
  end
  return value, ""
end

-- 格式化MAC地址列表
-- 将MAC地址数组格式化为HTML显示格式
function fmt_mac(mac_list)
  if mac_list and #mac_list > 0 then
    local neg_prefix, mac_value
    local result = {}
    
    for _, mac in ipairs(mac_list) do
      mac_value, neg_prefix = fmt_neg(mac)
      result[#result + 1] = "<var>%s%s</var>" % { neg_prefix, mac_value }
      result[#result + 1] = ", "
    end
    
    if #result > 1 then
      result[#result] = nil
      if #result > 3 then
        result[1] = #result
      end
      return table.concat(result)
    end
  end
end

-- 格式化端口列表
-- 将端口号或端口范围格式化为HTML显示格式
function fmt_port(port_list, default_value)
  if port_list and #port_list > 0 then
    local neg_prefix, port_value
    local result = {}
    
    for _, port in ipairs(port_list) do
      port_value, neg_prefix = fmt_neg(port)
      
      local start_port, end_port = port_value:match("(%d+)%D+(%d+)")
      if start_port and end_port then
        result[1] = translate("ports")
        result[#result + 1] = "<var>%s%d-%d</var>" % { neg_prefix, start_port, end_port }
      else
        result[#result + 1] = "<var>%s%d</var>" % { neg_prefix, port_value }
      end
      result[#result + 1] = ", "
    end
    
    if #result > 1 then
      result[#result] = nil
      if #result > 3 then
        result[1] = #result
      end
      return table.concat(result)
    end
  end
  
  if default_value then
    return "<var>%s</var>" % default_value
  end
  return default_value
end

-- 格式化IP地址列表
-- 将IP地址或CIDR格式化为HTML显示格式，支持IPv4和IPv6
function fmt_ip(ip_list, default_value)
  if ip_list and #ip_list > 0 then
    local result = {
      translate("IP"),
      " "
    }
    local neg_prefix, ip_value, addr, mask
    
    for _, ip_str in ipairs(ip_list) do
      ip_value, neg_prefix = fmt_neg(ip_str)
      
      addr, mask = ip_value:match("(%S+)/(%d+%.%S+)")
      addr = addr or ip_value
      
      local ip_obj
      if addr:match(":") then
        ip_obj = ip.IPv6(addr, mask)
      else
        ip_obj = ip.IPv4(addr, mask)
      end
      
      if ip_obj then
        local prefix = ip_obj:prefix()
        local is_ipv6 = ip_obj:is6()
        local max_prefix = is_ipv6 and 128 or 32
        
        if prefix < max_prefix then
          result[1] = translate("IP range")
          local min_host = ip_obj:minhost():string()
          local max_host = ip_obj:maxhost():string()
          local ip_string = ip_obj:string()
          result[#result + 1] = "<var title='%s - %s'>%s%s</var>" % {
            min_host, max_host, neg_prefix, ip_string
          }
        else
          result[#result + 1] = "<var>%s%s</var>" % {
            neg_prefix, ip_obj:string() or ip_str
          }
        end
      else
        result[#result + 1] = "<var>%s%s</var>" % { neg_prefix, ip_str }
      end
      result[#result + 1] = ", "
    end
    
    if #result > 2 then
      result[#result] = nil
      if #result > 3 then
        result[1] = #result
      end
      return table.concat(result)
    end
  end
  
  if default_value then
    return "<var>%s</var>" % default_value
  end
  return default_value
end

-- 格式化防火墙区域
-- 将区域名称格式化为HTML显示格式
function fmt_zone(zone, default_value)
  if zone == "*" then
    return "<var>%s</var>" % translate("any zone")
  elseif zone and #zone > 0 then
    return "<var>%s</var>" % zone
  elseif default_value then
    return "<var>%s</var>" % default_value
  end
end

-- 格式化ICMP类型列表
function fmt_icmp_type(icmp_list)
  if icmp_list and #icmp_list > 0 then
    local neg_prefix, icmp_value
    local result = {}
    
    for _, icmp in ipairs(icmp_list) do
      icmp_value, neg_prefix = fmt_neg(icmp)
      result[#result + 1] = "<var>%s%s</var>" % { neg_prefix, icmp_value }
      result[#result + 1] = ", "
    end
    
    if #result > 1 then
      result[#result] = nil
      if #result > 3 then
        result[1] = #result
      end
      return table.concat(result)
    end
  end
end

-- 格式化协议列表
-- 将协议名称格式化为HTML显示格式
function fmt_proto(proto_list, icmp_types)
  if proto_list and #proto_list > 0 then
    local neg_prefix, proto_value
    local result = {}
    local icmp_info = fmt_icmp_type(icmp_types)
    
    for _, proto in ipairs(proto_list) do
      proto_value, neg_prefix = fmt_neg(proto)
      
      if proto_value == "tcpudp" then
        result[#result + 1] = "TCP"
        result[#result + 1] = ", "
        result[#result + 1] = "UDP"
        result[#result + 1] = ", "
      elseif proto_value ~= "all" then
        local proto_info = nxo.getproto(proto_value)
        if proto_info then
          local proto_num = proto_info.proto
          if (proto_num == 1 or proto_num == 58) and icmp_info then
            result[#result + 1] = translatef("%s%s with %s", 
              neg_prefix, proto_info.aliases[1] or proto_value, icmp_info)
          else
            result[#result + 1] = "%s%s" % { 
              neg_prefix, proto_info.aliases[1] or proto_value 
            }
          end
          result[#result + 1] = ", "
        end
      end
    end
    
    if #result > 0 then
      result[#result] = nil
      return table.concat(result)
    end
  end
end

-- 格式化速率限制
-- 将速率限制规则格式化为可读字符串
function fmt_limit(limit_value, burst)
  burst = tonumber(burst)
  
  if limit_value and #limit_value > 0 then
    local rate, unit = limit_value:match("(%d+)/(%w+)")
    rate = tonumber(rate or limit_value)
    
    if rate then
      unit = unit or "s"
      if unit:match("^s") then
        unit = translate("second")
      elseif unit:match("^m") then
        unit = translate("minute")
      elseif unit:match("^h") then
        unit = translate("hour")
      elseif unit:match("^d") then
        unit = translate("day")
      end
      
      if burst and burst > 0 then
        return translatef("<var>%d</var> pkts. per <var>%s</var>, burst <var>%d</var> pkts.",
          rate, unit, burst)
      else
        return translatef("<var>%d</var> pkts. per <var>%s</var>", rate, unit)
      end
    end
  end
end

-- 格式化动作目标
-- 将防火墙动作格式化为可读字符串
function fmt_target(action, dest_list)
  if dest_list and #dest_list > 0 then
    if action == "ACCEPT" then
      return translate("Accept forward")
    elseif action == "REJECT" then
      return translate("Refuse forward")
    elseif action == "NOTRACK" then
      return translate("Do not track forward")
    else
      return translate("Discard forward")
    end
  else
    if action == "ACCEPT" then
      return translate("Accept input")
    elseif action == "REJECT" then
      return translate("Refuse input")
    elseif action == "NOTRACK" then
      return translate("Do not track input")
    else
      return translate("Discard input")
    end
  end
end

-- 添加启用/禁用选项到CBI表单
-- 支持Button类型和普通Flag类型
function opt_enabled(map, widget_type, ...)
  if widget_type == luci.cbi.Button then
    local btn = map:option(widget_type, "__enabled")
    
    function btn:render(section)
      local enabled = self.map:get(section, "enabled")
      if enabled ~= "0" then
        self.title = translate("Rule is enabled")
        self.inputtitle = translate("Disable")
        self.inputstyle = "reset"
      else
        self.title = translate("Rule is disabled")
        self.inputtitle = translate("Enable")
        self.inputstyle = "apply"
      end
      luci.cbi.Button.render(self, section)
    end
    
    function btn:write(section, value)
      local enabled = self.map:get(section, "enabled")
      if enabled ~= "0" then
        self.map:set(section, "enabled", "0")
      else
        self.map:del(section, "enabled")
      end
    end
    
    return btn
  else
    local flag = map:option(widget_type, "enabled", ...)
    flag.enabled = ""
    flag.disabled = "0"
    flag.default = flag.enabled
    return flag
  end
end

-- 添加名称选项到CBI表单
-- 支持从name或_name字段读取值
function opt_name(map, widget_type, ...)
  local name_opt = map:option(widget_type, "name", ...)
  
  function name_opt:cfgvalue(section)
    local value = self.map:get(section, "name")
    if not value then
      value = self.map:get(section, "_name") or value
    end
    return value
  end
  
  function name_opt:write(section, value)
    if value ~= "-" then
      self.map:set(section, "name", value)
      self.map:del(section, "_name")
    else
      self:remove(section)
    end
  end
  
  function name_opt:remove(section)
    self.map:del(section, "name")
    self.map:del(section, "_name")
  end
  
  return name_opt
end
