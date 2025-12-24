--[[
  LuCI 状态工具模块
  
  提供系统状态信息获取功能
  包括DHCP租约、WiFi网络状态、交换机端口状态等
]]

module("luci.tools.status", package.seeall)

local uci = require("luci.model.uci")
local uci_cursor = uci.cursor()

-- 读取DHCP租约信息(内部函数)
-- @param ip_version IP版本(4或6)
-- @return 租约信息数组
local function read_dhcp_leases(ip_version)
  local leases = {}
  local fs = require("nixio.fs")
  
  local lease_file = "/var/dhcp.leases"
  
  uci_cursor:foreach("dhcp", "dnsmasq", function(section)
    if section.leasefile then
      if fs.access(section.leasefile) then
        lease_file = section.leasefile
        return false
      end
    end
  end)
  
  local file = io.open(lease_file, "r")
  if file then
    while true do
      local line = file:read("*l")
      if not line then
        break
      end
      
      local expire_time, mac_addr, ip_addr, hostname, duid = 
        line:match("^(%d+) (%S+) (%S+) (%S+) (%S+)")
      
      if expire_time and mac_addr and ip_addr and hostname and duid then
        if ip_version == 4 then
          if not ip_addr:match(":") then
            local lease = {
              expires = os.difftime(tonumber(expire_time) or 0, os.time()),
              macaddr = mac_addr,
              ipaddr = ip_addr,
              hostname = hostname ~= "*" and hostname or nil
            }
            leases[#leases + 1] = lease
          end
        elseif ip_version == 6 then
          if ip_addr:match(":") then
            local lease = {
              expires = os.difftime(tonumber(expire_time) or 0, os.time()),
              ip6addr = ip_addr,
              duid = duid ~= "*" and duid or nil,
              hostname = hostname ~= "*" and hostname or nil
            }
            leases[#leases + 1] = lease
          end
        end
      end
    end
    file:close()
  end
  
  return leases
end

-- 获取DHCPv4租约列表
-- @return IPv4租约信息数组
function dhcp_leases()
  return read_dhcp_leases(4)
end

-- 获取DHCPv6租约列表
-- @return IPv6租约信息数组
function dhcp6_leases()
  local fs = require("nixio.fs")
  local relay_file = "/tmp/hosts/6relayd"
  local leases = {}
  
  if fs.access(relay_file, "r") then
    local file = io.open(relay_file, "r")
    if file then
      while true do
        local line = file:read("*l")
        if not line then
          break
        end
        
        local _, duid, _, hostname, expire_time, _, _, ip6addr = 
          line:match("^# (%S+) (%S+) (%S+) (%S+) (%d+) (%S+) (%S+) (.*)")
        
        if ip6addr then
          local lease = {
            expires = os.difftime(tonumber(expire_time) or 0, os.time()),
            duid = duid,
            ip6addr = ip6addr,
            hostname = hostname ~= "-" and hostname or nil
          }
          leases[#leases + 1] = lease
        end
      end
      file:close()
    end
    return leases
  else
    local ret = luci.sys.call("dnsmasq --version 2>/dev/null | grep -q ' DHCPv6 '")
    if ret == 0 then
      return read_dhcp_leases(6)
    end
  end
end

-- 获取所有WiFi网络状态
-- @return WiFi设备和网络状态信息
function wifi_networks()
  local result = {}
  local ntm = require("luci.model.network")
  local network_model = ntm.init()
  
  for _, wifi_dev in ipairs(network_model:get_wifidevs()) do
    local device_info = {
      up = wifi_dev:is_up(),
      device = wifi_dev:name(),
      name = wifi_dev:get_i18n(),
      networks = {}
    }
    
    for _, wifi_net in ipairs(wifi_dev:get_wifinets()) do
      local net_info = {
        name = wifi_net:shortname(),
        link = wifi_net:adminlink(),
        up = wifi_net:is_up(),
        mode = wifi_net:active_mode(),
        ssid = wifi_net:active_ssid(),
        bssid = wifi_net:active_bssid(),
        encryption = wifi_net:active_encryption(),
        frequency = wifi_net:frequency(),
        channel = wifi_net:channel(),
        signal = wifi_net:signal(),
        quality = wifi_net:signal_percent(),
        noise = wifi_net:noise(),
        bitrate = wifi_net:bitrate(),
        ifname = wifi_net:ifname(),
        assoclist = wifi_net:assoclist(),
        country = wifi_net:country(),
        txpower = wifi_net:txpower(),
        txpoweroff = wifi_net:txpower_offset()
      }
      device_info.networks[#device_info.networks + 1] = net_info
    end
    
    result[#result + 1] = device_info
  end
  
  return result
end

-- 获取指定WiFi网络状态
-- @param network_id WiFi网络ID
-- @return WiFi网络状态信息
function wifi_network(network_id)
  local ntm = require("luci.model.network")
  local network_model = ntm.init()
  
  local wifi_net = network_model:get_wifinet(network_id)
  if wifi_net then
    local wifi_dev = wifi_net:get_device()
    if wifi_dev then
      local net_info = {
        id = network_id,
        name = wifi_net:shortname(),
        link = wifi_net:adminlink(),
        up = wifi_net:is_up(),
        mode = wifi_net:active_mode(),
        ssid = wifi_net:active_ssid(),
        bssid = wifi_net:active_bssid(),
        encryption = wifi_net:active_encryption(),
        frequency = wifi_net:frequency(),
        channel = wifi_net:channel(),
        signal = wifi_net:signal(),
        quality = wifi_net:signal_percent(),
        noise = wifi_net:noise(),
        bitrate = wifi_net:bitrate(),
        ifname = wifi_net:ifname(),
        assoclist = wifi_net:assoclist(),
        country = wifi_net:country(),
        txpower = wifi_net:txpower(),
        txpoweroff = wifi_net:txpower_offset(),
        device = {
          up = wifi_dev:is_up(),
          device = wifi_dev:name(),
          name = wifi_dev:get_i18n()
        }
      }
      return net_info
    end
  end
  
  return {}
end

-- 获取交换机端口状态
-- @param switch_name 交换机名称(可选)
-- @return 交换机端口状态信息
function switch_status(switch_name)
  local result = {}
  
  for _, switch in ipairs(luci.sys.net.switches() or {}) do
    local ports = {}
    
    local pipe = io.popen("swconfig dev %q show" % switch, "r")
    if pipe then
      local line
      repeat
        line = pipe:read("*l")
        if line then
          local port_num, link_state = line:match("port:(%d+) link:(%w+)")
          if port_num then
            local speed = line:match(" speed:(%d+)")
            local duplex = line:match(" (%w+)-duplex")
            local txflow = line:match(" (txflow)")
            local rxflow = line:match(" (rxflow)")
            local auto_neg = line:match(" (auto)")
            
            local port_info = {
              port = tonumber(port_num) or 0,
              speed = tonumber(speed) or 0,
              link = link_state == "up",
              duplex = duplex == "full",
              rxflow = not not rxflow,
              txflow = not not txflow,
              auto = not not auto_neg
            }
            ports[#ports + 1] = port_info
          end
        end
      until not line
      pipe:close()
    end
    
    result[switch] = ports
  end
  
  return result
end
