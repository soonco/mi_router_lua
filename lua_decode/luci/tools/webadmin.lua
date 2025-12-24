local L0, L1, L2
L0 = module
L1 = "luci.tools.webadmin"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.model.uci"
L0 = L0(L1)
L1 = require
L2 = "luci.sys"
L1(L2)
L1 = require
L2 = "luci.ip"
L1(L2)
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L5 = "GB"
  L6 = "TB"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  for L5 = L2, L3, L4 do
    if 1024 < A0 and L5 < 5 then
      A0 = A0 / 1024
    else
      L6 = string
      L6 = L6.format
      L7 = "%.2f %s"
      L8 = A0
      L9 = L1[L5]
      return L6(L7, L8, L9)
    end
  end
end
byte_format = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  L2 = "min"
  L3 = "h"
  L4 = "d"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L2 = 0
  L3 = 0
  L4 = 0
  L5 = math
  L5 = L5.floor
  L6 = A0
  L5 = L5(L6)
  A0 = L5
  if 60 < A0 then
    L5 = math
    L5 = L5.floor
    L6 = A0 / 60
    L5 = L5(L6)
    L2 = L5
    A0 = A0 % 60
  end
  if 60 < L2 then
    L5 = math
    L5 = L5.floor
    L6 = L2 / 60
    L5 = L5(L6)
    L3 = L5
    L2 = L2 % 60
  end
  if 24 < L3 then
    L5 = math
    L5 = L5.floor
    L6 = L3 / 24
    L5 = L5(L6)
    L4 = L5
    L3 = L3 % 24
  end
  if 0 < L4 then
    L5 = string
    L5 = L5.format
    L6 = "%.0fd %02.0fh %02.0fmin %02.0fs"
    L7 = L4
    L8 = L3
    L9 = L2
    L10 = A0
    return L5(L6, L7, L8, L9, L10)
  else
    L5 = string
    L5 = L5.format
    L6 = "%02.0fh %02.0fmin %02.0fs"
    L7 = L3
    L8 = L2
    L9 = A0
    return L5(L6, L7, L8, L9)
  end
end
date_format = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L1 = L1.cursor_state
  L1 = L1()
  L3 = L1
  L2 = L1.load
  L4 = "network"
  L2(L3, L4)
  L2 = {}
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = A0
  L7 = "ipaddr"
  L3 = L3(L4, L5, L6, L7)
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "netmask"
  L4 = L4(L5, L6, L7, L8)
  L6 = L1
  L5 = L1.get
  L7 = "network"
  L8 = A0
  L9 = "ip6addr"
  L5 = L5(L6, L7, L8, L9)
  if L3 then
    L6 = #L3
    if 0 < L6 then
      if L4 then
        L6 = #L4
        if L6 == 0 then
          L4 = nil
        end
      end
      L6 = luci
      L6 = L6.ip
      L6 = L6.IPv4
      L7 = L3
      L8 = L4
      L6 = L6(L7, L8)
      L3 = L6
      if L3 then
        L6 = table
        L6 = L6.insert
        L7 = L2
        L9 = L3
        L8 = L3.string
        L8, L9, L10 = L8(L9)
        L6(L7, L8, L9, L10)
      end
    end
  end
  if L5 then
    L6 = table
    L6 = L6.insert
    L7 = L2
    L8 = L5
    L6(L7, L8)
  end
  L7 = L1
  L6 = L1.foreach
  L8 = "network"
  L9 = "alias"
  function L10(A0)
    local L1, L2, L3, L4, L5
    L1 = A0.interface
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0.ipaddr
      if L1 then
        L1 = A0.netmask
        if L1 then
          L1 = luci
          L1 = L1.ip
          L1 = L1.IPv4
          L2 = A0.ipaddr
          L3 = A0.netmask
          L1 = L1(L2, L3)
          if L1 then
            L2 = table
            L2 = L2.insert
            L3 = _UPVALUE1_
            L5 = L1
            L4 = L1.string
            L4, L5 = L4(L5)
            L2(L3, L4, L5)
          end
        end
      end
      L1 = A0.ip6addr
      if L1 then
        L1 = table
        L1 = L1.insert
        L2 = _UPVALUE1_
        L3 = A0.ip6addr
        L1(L2, L3)
      end
    end
  end
  L6(L7, L8, L9, L10)
  return L2
end
network_get_addresses = L1
function L1(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.cursor
  L1 = L1()
  L2 = L1
  L1 = L1.foreach
  L3 = "network"
  L4 = "interface"
  function L5(A0)
    local L1, L2, L3
    L1 = A0[".name"]
    if L1 ~= "loopback" then
      L1 = _UPVALUE0_
      L2 = L1
      L1 = L1.value
      L3 = A0[".name"]
      L1(L2, L3)
    end
  end
  L1(L2, L3, L4, L5)
  L1 = luci
  L1 = L1.dispatcher
  L1 = L1.build_url
  L2 = "admin"
  L3 = "network"
  L4 = "network"
  L1 = L1(L2, L3, L4)
  A0.titleref = L1
end
cbi_add_networks = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L4, L5, L6, L7, L8 = L2()
  for L4, L5 in L1, L2, L3 do
    L7 = A0
    L6 = A0.value
    L8 = L5["IP address"]
    L6(L7, L8)
  end
end
cbi_add_knownips = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.cursor_state
  L1 = L1()
  L3 = L1
  L2 = L1.load
  L4 = "firewall"
  L2 = L2(L3, L4)
  if not L2 then
    L2 = nil
    return L2
  end
  L2 = {}
  L4 = L1
  L3 = L1.foreach
  L5 = "firewall"
  L6 = "zone"
  function L7(A0)
    local L1, L2, L3, L4, L5
    L1 = A0.network
    L1 = L1 or L1
    L2 = luci
    L2 = L2.util
    L2 = L2.contains
    L3 = luci
    L3 = L3.util
    L3 = L3.split
    L4 = L1
    L5 = " "
    L3 = L3(L4, L5)
    L4 = _UPVALUE0_
    L2 = L2(L3, L4)
    if L2 then
      L2 = table
      L2 = L2.insert
      L3 = _UPVALUE1_
      L4 = A0.name
      L2(L3, L4)
    end
  end
  L3(L4, L5, L6, L7)
  return L2
end
network_get_zones = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6
  L2 = luci
  L2 = L2.model
  L2 = L2.uci
  L2 = L2.cursor
  L2 = L2()
  L3 = L2
  L2 = L2.foreach
  L4 = "firewall"
  L5 = "zone"
  function L6(A0)
    local L1, L2
    L1 = A0.name
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0[".name"]
      _UPVALUE1_ = L1
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
firewall_find_zone = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.cursor_state
  L1 = L1()
  L3 = L1
  L2 = L1.load
  L4 = "network"
  L2(L3, L4)
  L2 = nil
  L4 = L1
  L3 = L1.foreach
  L5 = "network"
  L6 = "interface"
  function L7(A0)
    local L1, L2, L3, L4, L5
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.get
    L3 = "network"
    L4 = A0[".name"]
    L5 = "ifname"
    L1 = L1(L2, L3, L4, L5)
    L2 = _UPVALUE1_
    if L2 == L1 then
      L2 = A0[".name"]
      _UPVALUE2_ = L2
    end
  end
  L3(L4, L5, L6, L7)
  return L2
end
iface_get_network = L1
