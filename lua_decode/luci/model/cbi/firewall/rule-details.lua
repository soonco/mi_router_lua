local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30
L0 = require
L1 = "luci.sys"
L0 = L0(L1)
L1 = require
L2 = "luci.dispatcher"
L1 = L1(L2)
L2 = require
L3 = "nixio"
L2 = L2(L3)
L3 = require
L4 = "luci.tools.firewall"
L3 = L3(L4)
L4 = require
L5 = "luci.model.network"
L4 = L4(L5)
L5, L6, L7, L8, L9 = nil, nil, nil, nil, nil
L10 = arg
L11 = arg
L11 = L11[1]
L11 = L11 or L11
L10[1] = L11
L10 = Map
L11 = "firewall"
L12 = translate
L12 = L12(L13)
L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L13(L14)
L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
L5 = L10
L10 = L1.build_url
L11 = "admin/network/firewall/rules"
L10 = L10(L11)
L5.redirect = L10
L10 = L4.init
L11 = L5.uci
L10(L11)
L10 = L5.uci
L11 = L10
L10 = L10.get
L12 = "firewall"
L10 = L10(L11, L12, L13)
if L10 == "redirect" then
  L12 = L5
  L11 = L5.get
  L11 = L11(L12, L13, L14)
  if L11 ~= "SNAT" then
    L10 = nil
  end
end
if not L10 then
  L11 = luci
  L11 = L11.http
  L11 = L11.redirect
  L12 = L5.redirect
  L11(L12)
  return
elseif L10 == "redirect" then
  L12 = L5
  L11 = L5.get
  L11 = L11(L12, L13, L14)
  if not L11 then
    L12 = L5
    L11 = L5.get
    L11 = L11(L12, L13, L14)
  end
  if L11 then
    L12 = #L11
    if L12 ~= 0 then
      goto lbl_90
    end
  end
  L12 = translate
  L12 = L12(L13)
  L11 = L12
  goto lbl_91
  ::lbl_90::
  L11 = "SNAT %s" % L11
  ::lbl_91::
  L12 = {}
  L12[1] = L13
  L12[2] = L14
  L12 = "%s - %s" % L12
  L5.title = L12
  L12 = nil
  L16 = "zone"
  function L17(A0)
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
  L13(L14, L15, L16, L17)
  L16 = arg
  L16 = L16[1]
  L17 = "redirect"
  L18 = ""
  L6 = L13
  L6.anonymous = true
  L6.addremove = false
  L13(L14, L15)
  L16 = translate
  L17 = "Name"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L13(L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L16 = "proto"
  L17 = translate
  L18 = "Protocol"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L7 = L13
  L16 = "All protocols"
  L13(L14, L15, L16)
  L16 = "TCP+UDP"
  L13(L14, L15, L16)
  L16 = "TCP"
  L13(L14, L15, L16)
  L16 = "UDP"
  L13(L14, L15, L16)
  L16 = "ICMP"
  L13(L14, L15, L16)
  L7.cfgvalue = L13
  L16 = "src"
  L17 = translate
  L18 = "Source zone"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L7 = L13
  L7.nocreate = true
  L7.default = "wan"
  L7.template = "cbi/firewall_zonelist"
  L16 = "src_mac"
  L17 = translate
  L18 = "Source MAC address"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L7 = L13
  L7.rmempty = true
  L7.datatype = "neg(macaddr)"
  L7.placeholder = L13
  L13(L14)
  L16 = "src_ip"
  L17 = translate
  L18 = "Source IP address"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L7 = L13
  L7.rmempty = true
  L7.datatype = "neg(ipaddr)"
  L7.placeholder = L13
  L13(L14)
  L16 = "src_port"
  L17 = translate
  L18 = "Source port"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L7 = L13
  L7.rmempty = true
  L7.datatype = "neg(portrange)"
  L7.placeholder = L13
  L16 = "dest"
  L17 = translate
  L18 = "Destination zone"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L7 = L13
  L7.nocreate = true
  L7.default = "lan"
  L7.template = "cbi/firewall_zonelist"
  L16 = "dest_ip"
  L17 = translate
  L18 = "Destination IP address"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L7 = L13
  L7.datatype = "neg(ip4addr)"
  L13(L14)
  L16 = "dest_port"
  L17 = translate
  L18 = "Destination port"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L7 = L13
  L7.rmempty = true
  L7.placeholder = L13
  L7.datatype = "neg(portrange)"
  L16 = "src_dip"
  L17 = translate
  L18 = "SNAT IP address"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L7 = L13
  L7.rmempty = false
  L7.datatype = "ip4addr"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L14(L15)
  for L16, L17 in L13, L14, L15 do
    L18 = nil
    L22, L23, L24, L25, L26, L27, L28, L29, L30 = L20(L21)
    for L22, L23 in L19, L20, L21 do
      L25 = L7
      L24 = L7.value
      L27 = L23
      L26 = L23.host
      L26 = L26(L27)
      L27 = L26
      L26 = L26.string
      L26 = L26(L27)
      L27 = {}
      L29 = L23
      L28 = L23.host
      L28 = L28(L29)
      L29 = L28
      L28 = L28.string
      L28 = L28(L29)
      L30 = L17
      L29 = L17.shortname
      L29, L30 = L29(L30)
      L27[1] = L28
      L27[2] = L29
      L27[3] = L30
      L27 = "%s (%s)" % L27
      L24(L25, L26, L27)
    end
  end
  L16 = "src_dport"
  L17 = translate
  L18 = "SNAT port"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L7 = L13
  L7.datatype = "portrange"
  L7.rmempty = true
  L7.placeholder = L13
  L16 = "extra"
  L17 = translate
  L18 = "Extra arguments"
  L17 = L17(L18)
  L18 = translate
  L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L18(L19)
  L13(L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
else
  L12 = L5
  L11 = L5.get
  L11 = L11(L12, L13, L14)
  if not L11 then
    L12 = L5
    L11 = L5.get
    L11 = L11(L12, L13, L14)
  end
  if L11 then
    L12 = #L11
    if L12 ~= 0 then
      goto lbl_368
    end
  end
  L12 = translate
  L12 = L12(L13)
  L11 = L12
  ::lbl_368::
  L12 = {}
  L12[1] = L13
  L12[2] = L14
  L12 = "%s - %s" % L12
  L5.title = L12
  L12 = L5.section
  L16 = "rule"
  L17 = ""
  L12 = L12(L13, L14, L15, L16, L17)
  L6 = L12
  L6.anonymous = true
  L6.addremove = false
  L12 = L3.opt_enabled
  L12(L13, L14)
  L12 = L3.opt_name
  L16 = "Name"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L6.option
  L16 = translate
  L17 = "Restrict to address family"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.rmempty = true
  L12 = L7.value
  L16 = "IPv4 and IPv6"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L16 = "IPv4 only"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L16 = "IPv6 only"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L6.option
  L16 = translate
  L17 = "Protocol"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L12 = L7.value
  L16 = "Any"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L12(L13, L14, L15)
  L12 = L7.value
  L12(L13, L14, L15)
  L12 = L7.value
  L12(L13, L14, L15)
  L12 = L7.value
  L12(L13, L14, L15)
  function L12(...)
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
  L7.cfgvalue = L12
  L12 = L6.option
  L16 = translate
  L17 = "Match ICMP type"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L12 = L7.value
  L12(L13, L14, L15)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L7.value
  L12(L13, L14)
  L12 = L6.option
  L16 = translate
  L17 = "Source zone"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.nocreate = true
  L7.allowany = true
  L7.default = "wan"
  L7.template = "cbi/firewall_zonelist"
  L12 = L6.option
  L16 = translate
  L17 = "Source MAC address"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.datatype = "list(macaddr)"
  L12 = translate
  L12 = L12(L13)
  L7.placeholder = L12
  L12 = luci
  L12 = L12.sys
  L12 = L12.net
  L12 = L12.mac_hints
  L12(L13)
  L12 = L6.option
  L16 = translate
  L17 = "Source address"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.datatype = "neg(ipaddr)"
  L12 = translate
  L12 = L12(L13)
  L7.placeholder = L12
  L12 = luci
  L12 = L12.sys
  L12 = L12.net
  L12 = L12.ipv4_hints
  L12(L13)
  L12 = L6.option
  L16 = translate
  L17 = "Source port"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.datatype = "list(neg(portrange))"
  L12 = translate
  L12 = L12(L13)
  L7.placeholder = L12
  L12 = L6.option
  L16 = translate
  L17 = "Destination zone"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.nocreate = true
  L7.allowany = true
  L7.allowlocal = true
  L7.template = "cbi/firewall_zonelist"
  L12 = L6.option
  L16 = translate
  L17 = "Destination address"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.datatype = "neg(ipaddr)"
  L12 = translate
  L12 = L12(L13)
  L7.placeholder = L12
  L12 = luci
  L12 = L12.sys
  L12 = L12.net
  L12 = L12.ipv4_hints
  L12(L13)
  L12 = L6.option
  L16 = translate
  L17 = "Destination port"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.datatype = "list(neg(portrange))"
  L12 = translate
  L12 = L12(L13)
  L7.placeholder = L12
  L12 = L6.option
  L16 = translate
  L17 = "Action"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L16(L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L7 = L12
  L7.default = "ACCEPT"
  L12 = L7.value
  L16 = "drop"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L16 = "accept"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L16 = "reject"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L7.value
  L16 = "don't track"
  L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L15(L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L12 = L6.option
  L16 = translate
  L17 = "Extra arguments"
  L16 = L16(L17)
  L17 = translate
  L18 = "Passes additional arguments to iptables. Use with care!"
  L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30 = L17(L18)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
end
return L5
