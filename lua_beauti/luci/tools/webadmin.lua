--[[
  LuCI Web管理工具模块
  
  提供Web管理界面的辅助函数
  包括字节格式化、时间格式化、网络配置获取等功能
]]

module("luci.tools.webadmin", package.seeall)

local uci = require("luci.model.uci")
require("luci.sys")
require("luci.ip")

-- 格式化字节数为人类可读格式
-- @param bytes 字节数
-- @return 格式化后的字符串(如 "1.50 GB")
function byte_format(bytes)
  local units = { "B", "KB", "MB", "GB", "TB" }
  
  for i = 1, 5 do
    if bytes > 1024 and i < 5 then
      bytes = bytes / 1024
    else
      return string.format("%.2f %s", bytes, units[i])
    end
  end
end

-- 格式化秒数为人类可读的时间格式
-- @param seconds 秒数
-- @return 格式化后的字符串(如 "1d 02h 30min 45s")
function date_format(seconds)
  local units = { "min", "h", "d" }
  
  local minutes = 0
  local hours = 0
  local days = 0
  
  seconds = math.floor(seconds)
  
  if seconds > 60 then
    minutes = math.floor(seconds / 60)
    seconds = seconds % 60
  end
  
  if minutes > 60 then
    hours = math.floor(minutes / 60)
    minutes = minutes % 60
  end
  
  if hours > 24 then
    days = math.floor(hours / 24)
    hours = hours % 24
  end
  
  if days > 0 then
    return string.format("%.0fd %02.0fh %02.0fmin %02.0fs", days, hours, minutes, seconds)
  else
    return string.format("%02.0fh %02.0fmin %02.0fs", hours, minutes, seconds)
  end
end

-- 获取网络接口的IP地址列表
-- @param interface_name 接口名称
-- @return IP地址数组(包括IPv4和IPv6)
function network_get_addresses(interface_name)
  local cursor = uci.cursor_state()
  cursor:load("network")
  
  local addresses = {}
  
  local ipaddr = cursor:get("network", interface_name, "ipaddr")
  local netmask = cursor:get("network", interface_name, "netmask")
  local ip6addr = cursor:get("network", interface_name, "ip6addr")
  
  if ipaddr and #ipaddr > 0 then
    if netmask and #netmask == 0 then
      netmask = nil
    end
    
    local ip_obj = luci.ip.IPv4(ipaddr, netmask)
    ipaddr = ip_obj
    
    if ipaddr then
      table.insert(addresses, ipaddr:string())
    end
  end
  
  if ip6addr then
    table.insert(addresses, ip6addr)
  end
  
  cursor:foreach("network", "alias", function(section)
    if section.interface == interface_name then
      if section.ipaddr and section.netmask then
        local ip_obj = luci.ip.IPv4(section.ipaddr, section.netmask)
        if ip_obj then
          table.insert(addresses, ip_obj:string())
        end
      end
      
      if section.ip6addr then
        table.insert(addresses, section.ip6addr)
      end
    end
  end)
  
  return addresses
end

-- 向CBI表单添加网络接口选项
-- @param widget CBI widget对象
function cbi_add_networks(widget)
  local cursor = uci.cursor()
  
  cursor:foreach("network", "interface", function(section)
    if section[".name"] ~= "loopback" then
      widget:value(section[".name"])
    end
  end)
  
  widget.titleref = luci.dispatcher.build_url("admin", "network", "network")
end

-- 向CBI表单添加已知IP地址选项
-- @param widget CBI widget对象
function cbi_add_knownips(widget)
  for _, entry in ipairs(luci.sys.net.arptable() or {}) do
    widget:value(entry["IP address"])
  end
end

-- 获取网络接口所属的防火墙区域
-- @param interface_name 接口名称
-- @return 区域名称数组
function network_get_zones(interface_name)
  local cursor = uci.cursor_state()
  
  if not cursor:load("firewall") then
    return nil
  end
  
  local zones = {}
  
  cursor:foreach("firewall", "zone", function(section)
    local networks = section.network or section[".name"]
    local network_list = luci.util.split(networks, " ")
    
    if luci.util.contains(network_list, interface_name) then
      table.insert(zones, section.name)
    end
  end)
  
  return zones
end

-- 根据区域名称查找防火墙区域配置节
-- @param zone_name 区域名称
-- @return 配置节名称
function firewall_find_zone(zone_name)
  local section_name
  local cursor = luci.model.uci.cursor()
  
  cursor:foreach("firewall", "zone", function(section)
    if section.name == zone_name then
      section_name = section[".name"]
    end
  end)
  
  return section_name
end

-- 根据接口名称获取所属网络
-- @param ifname 接口名称
-- @return 网络名称
function iface_get_network(ifname)
  local cursor = uci.cursor_state()
  cursor:load("network")
  
  local network_name
  
  cursor:foreach("network", "interface", function(section)
    local iface = cursor:get("network", section[".name"], "ifname")
    if ifname == iface then
      network_name = section[".name"]
    end
  end)
  
  return network_name
end
