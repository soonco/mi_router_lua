local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = require
L1 = "luci.sys"
L0 = L0(L1)
L1 = require
L2 = "luci.dispatcher"
L1 = L1(L2)
L2 = require
L3 = "luci.tools.firewall"
L2 = L2(L3)
L3, L4, L5 = nil, nil, nil
L6 = arg
L7 = arg
L7 = L7[1]
L7 = L7 or L7
L6[1] = L7
L6 = Map
L7 = "firewall"
L8 = translate
L9 = "Firewall - Port Forwards"
L8 = L8(L9)
L9 = translate
L10 = [[
This page allows you to change advanced properties of the port 
	           forwarding entry. In most cases there is no need to modify 
			   those settings.]]
L9, L10, L11, L12, L13, L14 = L9(L10)
L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
L3 = L6
L6 = L1.build_url
L7 = "admin/network/firewall/forwards"
L6 = L6(L7)
L3.redirect = L6
L6 = L3.uci
L7 = L6
L6 = L6.get
L8 = "firewall"
L9 = arg
L9 = L9[1]
L6 = L6(L7, L8, L9)
if L6 ~= "redirect" then
  L6 = luci
  L6 = L6.http
  L6 = L6.redirect
  L7 = L3.redirect
  L6(L7)
  return
else
  L7 = L3
  L6 = L3.get
  L8 = arg
  L8 = L8[1]
  L9 = "name"
  L6 = L6(L7, L8, L9)
  if not L6 then
    L7 = L3
    L6 = L3.get
    L8 = arg
    L8 = L8[1]
    L9 = "_name"
    L6 = L6(L7, L8, L9)
  end
  if L6 then
    L7 = #L6
    if L7 ~= 0 then
      goto lbl_68
    end
  end
  L7 = translate
  L8 = "(Unnamed Entry)"
  L7 = L7(L8)
  L6 = L7
  ::lbl_68::
  L7 = {}
  L8 = translate
  L9 = "Firewall - Port Forwards"
  L8 = L8(L9)
  L9 = L6
  L7[1] = L8
  L7[2] = L9
  L7 = "%s - %s" % L7
  L3.title = L7
end
L6 = nil
L7 = L3.uci
L8 = L7
L7 = L7.foreach
L9 = "firewall"
L10 = "zone"
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = A0.network
  L1 = L1 or L1
  if L1 then
    L2 = nil
    for L6 in L3, L4, L5 do
      if L6 == "wan" then
        L7 = A0.name
        _UPVALUE0_ = L7
        L7 = false
        return L7
      end
    end
  end
end
L7(L8, L9, L10, L11)
L8 = L3
L7 = L3.section
L9 = NamedSection
L10 = arg
L10 = L10[1]
L11 = "redirect"
L12 = ""
L7 = L7(L8, L9, L10, L11, L12)
L4 = L7
L4.anonymous = true
L4.addremove = false
L7 = L2.opt_enabled
L8 = L4
L9 = Button
L7(L8, L9)
L7 = L2.opt_name
L8 = L4
L9 = Value
L10 = translate
L11 = "Name"
L10, L11, L12, L13, L14 = L10(L11)
L7(L8, L9, L10, L11, L12, L13, L14)
L8 = L4
L7 = L4.option
L9 = Value
L10 = "proto"
L11 = translate
L12 = "Protocol"
L11, L12, L13, L14 = L11(L12)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L8 = L5
L7 = L5.value
L9 = "tcp udp"
L10 = "TCP+UDP"
L7(L8, L9, L10)
L8 = L5
L7 = L5.value
L9 = "tcp"
L10 = "TCP"
L7(L8, L9, L10)
L8 = L5
L7 = L5.value
L9 = "udp"
L10 = "UDP"
L7(L8, L9, L10)
L8 = L5
L7 = L5.value
L9 = "icmp"
L10 = "ICMP"
L7(L8, L9, L10)
function L7(...)
  local L1, L2
  L1 = Value
  L1 = L1.cfgvalue
  L2 = ...
  L1 = L1(L2)
  if not L1 or L1 == "tcpudp" then
    L2 = "tcp udp"
    return L2
  end
  return L1
end
L5.cfgvalue = L7
L8 = L4
L7 = L4.option
L9 = Value
L10 = "src"
L11 = translate
L12 = "Source zone"
L11, L12, L13, L14 = L11(L12)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.nocreate = true
L5.default = "wan"
L5.template = "cbi/firewall_zonelist"
L8 = L4
L7 = L4.option
L9 = DynamicList
L10 = "src_mac"
L11 = translate
L12 = "Source MAC address"
L11 = L11(L12)
L12 = translate
L13 = "Only match incoming traffic from these MACs."
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.rmempty = true
L5.datatype = "neg(macaddr)"
L7 = translate
L8 = "any"
L7 = L7(L8)
L5.placeholder = L7
L7 = luci
L7 = L7.sys
L7 = L7.net
L7 = L7.mac_hints
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.value
  L4 = A0
  L5 = {}
  L6 = A0
  L7 = A1
  L5[1] = L6
  L5[2] = L7
  L5 = "%s (%s)" % L5
  L2(L3, L4, L5)
end
L7(L8)
L8 = L4
L7 = L4.option
L9 = Value
L10 = "src_ip"
L11 = translate
L12 = "Source IP address"
L11 = L11(L12)
L12 = translate
L13 = "Only match incoming traffic from this IP or range."
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.rmempty = true
L5.datatype = "neg(ip4addr)"
L7 = translate
L8 = "any"
L7 = L7(L8)
L5.placeholder = L7
L7 = luci
L7 = L7.sys
L7 = L7.net
L7 = L7.ipv4_hints
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.value
  L4 = A0
  L5 = {}
  L6 = A0
  L7 = A1
  L5[1] = L6
  L5[2] = L7
  L5 = "%s (%s)" % L5
  L2(L3, L4, L5)
end
L7(L8)
L8 = L4
L7 = L4.option
L9 = Value
L10 = "src_port"
L11 = translate
L12 = "Source port"
L11 = L11(L12)
L12 = translate
L13 = "Only match incoming traffic originating from the given source port or port range on the client host"
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.rmempty = true
L5.datatype = "neg(portrange)"
L7 = translate
L8 = "any"
L7 = L7(L8)
L5.placeholder = L7
L8 = L4
L7 = L4.option
L9 = Value
L10 = "src_dip"
L11 = translate
L12 = "External IP address"
L11 = L11(L12)
L12 = translate
L13 = "Only match incoming traffic directed at the given IP address."
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L7 = luci
L7 = L7.sys
L7 = L7.net
L7 = L7.ipv4_hints
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.value
  L4 = A0
  L5 = {}
  L6 = A0
  L7 = A1
  L5[1] = L6
  L5[2] = L7
  L5 = "%s (%s)" % L5
  L2(L3, L4, L5)
end
L7(L8)
L5.rmempty = true
L5.datatype = "neg(ip4addr)"
L7 = translate
L8 = "any"
L7 = L7(L8)
L5.placeholder = L7
L8 = L4
L7 = L4.option
L9 = Value
L10 = "src_dport"
L11 = translate
L12 = "External port"
L11 = L11(L12)
L12 = translate
L13 = "Match incoming traffic directed at the given "
L14 = "destination port or port range on this host"
L13 = L13 .. L14
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.datatype = "neg(portrange)"
L8 = L4
L7 = L4.option
L9 = Value
L10 = "dest"
L11 = translate
L12 = "Internal zone"
L11, L12, L13, L14 = L11(L12)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.nocreate = true
L5.default = "lan"
L5.template = "cbi/firewall_zonelist"
L8 = L4
L7 = L4.option
L9 = Value
L10 = "dest_ip"
L11 = translate
L12 = "Internal IP address"
L11 = L11(L12)
L12 = translate
L13 = [[
Redirect matched incoming traffic to the specified 
		internal host]]
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.datatype = "ip4addr"
L7 = luci
L7 = L7.sys
L7 = L7.net
L7 = L7.ipv4_hints
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.value
  L4 = A0
  L5 = {}
  L6 = A0
  L7 = A1
  L5[1] = L6
  L5[2] = L7
  L5 = "%s (%s)" % L5
  L2(L3, L4, L5)
end
L7(L8)
L8 = L4
L7 = L4.option
L9 = Value
L10 = "dest_port"
L11 = translate
L12 = "Internal port"
L11 = L11(L12)
L12 = translate
L13 = [[
Redirect matched incoming traffic to the given port on 
		the internal host]]
L12, L13, L14 = L12(L13)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L7 = translate
L8 = "any"
L7 = L7(L8)
L5.placeholder = L7
L5.datatype = "portrange"
L8 = L4
L7 = L4.option
L9 = Flag
L10 = "reflection"
L11 = translate
L12 = "Enable NAT Loopback"
L11, L12, L13, L14 = L11(L12)
L7 = L7(L8, L9, L10, L11, L12, L13, L14)
L5 = L7
L5.rmempty = true
L7 = L5.enabled
L5.default = L7
L8 = L5
L7 = L5.depends
L9 = "src"
L10 = L6
L7(L8, L9, L10)
function L7(...)
  local L1, L2
  L1 = Flag
  L1 = L1.cfgvalue
  L2 = ...
  L1 = L1(L2)
  L1 = L1 or L1
  return L1
end
L5.cfgvalue = L7
L8 = L4
L7 = L4.option
L9 = Value
L10 = "extra"
L11 = translate
L12 = "Extra arguments"
L11 = L11(L12)
L12 = translate
L13 = "Passes additional arguments to iptables. Use with care!"
L12, L13, L14 = L12(L13)
L7(L8, L9, L10, L11, L12, L13, L14)
return L3
