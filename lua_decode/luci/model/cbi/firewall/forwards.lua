local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
L0 = require
L1 = "luci.dispatcher"
L0 = L0(L1)
L1 = require
L2 = "luci.tools.firewall"
L1 = L1(L2)
L2 = Map
L3 = "firewall"
L4 = translate
L5 = "Firewall - Port Forwards"
L4 = L4(L5)
L5 = translate
L6 = [[
Port forwarding allows remote computers on the Internet to 
	           connect to a specific computer or service within the 
	           private LAN.]]
L5, L6, L7, L8, L9, L10 = L5(L6)
L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10)
m = L2
L2 = m
L3 = L2
L2 = L2.section
L4 = TypedSection
L5 = "redirect"
L6 = translate
L7 = "Port Forwards"
L6, L7, L8, L9, L10 = L6(L7)
L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10)
s = L2
L2 = s
L2.template = "cbi/tblsection"
L2 = s
L2.addremove = true
L2 = s
L2.anonymous = true
L2 = s
L2.sortable = true
L2 = s
L3 = L0.build_url
L4 = "admin/network/firewall/forwards/%s"
L3 = L3(L4)
L2.extedit = L3
L2 = s
L2.template_addremove = "firewall/cbi_addforward"
L2 = s
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = m
  L3 = L2
  L2 = L2.formvalue
  L4 = "_newfwd.name"
  L2 = L2(L3, L4)
  L3 = m
  L4 = L3
  L3 = L3.formvalue
  L5 = "_newfwd.proto"
  L3 = L3(L4, L5)
  L4 = m
  L5 = L4
  L4 = L4.formvalue
  L6 = "_newfwd.extzone"
  L4 = L4(L5, L6)
  L5 = m
  L6 = L5
  L5 = L5.formvalue
  L7 = "_newfwd.extport"
  L5 = L5(L6, L7)
  L6 = m
  L7 = L6
  L6 = L6.formvalue
  L8 = "_newfwd.intzone"
  L6 = L6(L7, L8)
  L7 = m
  L8 = L7
  L7 = L7.formvalue
  L9 = "_newfwd.intaddr"
  L7 = L7(L8, L9)
  L8 = m
  L9 = L8
  L8 = L8.formvalue
  L10 = "_newfwd.intport"
  L8 = L8(L9, L10)
  if L3 == "other" or L3 and L7 then
    L9 = TypedSection
    L9 = L9.create
    L10 = A0
    L11 = A1
    L9 = L9(L10, L11)
    created = L9
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "target"
    L13 = "DNAT"
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "src"
    L13 = L4 or L13
    if not L4 then
      L13 = "wan"
    end
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "dest"
    L13 = L6 or L13
    if not L6 then
      L13 = "lan"
    end
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "proto"
    L13 = L3 or L13
    if L3 == "other" or not L3 then
      L13 = "all"
    end
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "src_dport"
    L13 = L5
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "dest_ip"
    L13 = L7
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "dest_port"
    L13 = L8
    L9(L10, L11, L12, L13)
    L9 = A0.map
    L10 = L9
    L9 = L9.set
    L11 = created
    L12 = "name"
    L13 = L2
    L9(L10, L11, L12, L13)
  end
  if L3 ~= "other" then
    L9 = nil
    created = L9
  end
end
L2.create = L3
L2 = s
function L3(A0, ...)
  local L2, L3, L4, L5
  L2 = TypedSection
  L2 = L2.parse
  L3 = A0
  L4, L5 = ...
  L2(L3, L4, L5)
  L2 = created
  if L2 then
    L2 = m
    L2 = L2.uci
    L3 = L2
    L2 = L2.save
    L4 = "firewall"
    L2(L3, L4)
    L2 = luci
    L2 = L2.http
    L2 = L2.redirect
    L3 = _UPVALUE0_
    L3 = L3.build_url
    L4 = "admin/network/firewall/redirect"
    L5 = created
    L3, L4, L5 = L3(L4, L5)
    L2(L3, L4, L5)
  end
end
L2.parse = L3
L2 = s
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.map
  L3 = L2
  L2 = L2.get
  L4 = A1
  L5 = "target"
  L2 = L2(L3, L4, L5)
  L2 = L2 ~= "SNAT"
  return L2
end
L2.filter = L3
L2 = L1.opt_name
L3 = s
L4 = DummyValue
L5 = translate
L6 = "Name"
L5, L6, L7, L8, L9, L10 = L5(L6)
L2(L3, L4, L5, L6, L7, L8, L9, L10)
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = {}
  L3 = translate
  L4 = "IPv4"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.fmt_proto
  L5 = A0.map
  L6 = L5
  L5 = L5.get
  L7 = A1
  L8 = "proto"
  L5 = L5(L6, L7, L8)
  L6 = A0.map
  L7 = L6
  L6 = L6.get
  L8 = A1
  L9 = "icmp_type"
  L6, L7, L8, L9 = L6(L7, L8, L9)
  L4 = L4(L5, L6, L7, L8, L9)
  L4 = L4 or L4
  L2[1] = L3
  L2[2] = L4
  L2 = "%s-%s" % L2
  return L2
end
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = _UPVALUE0_
  L2 = L2.fmt_zone
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "src"
  L3 = L3(L4, L5, L6)
  L4 = translate
  L5 = "any zone"
  L4, L5, L6, L7, L8, L9, L10, L11 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11)
  L3 = _UPVALUE0_
  L3 = L3.fmt_ip
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "src_ip"
  L4 = L4(L5, L6, L7)
  L5 = translate
  L6 = "any host"
  L5, L6, L7, L8, L9, L10, L11 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11)
  L4 = _UPVALUE0_
  L4 = L4.fmt_port
  L5 = A0.map
  L6 = L5
  L5 = L5.get
  L7 = A1
  L8 = "src_port"
  L5, L6, L7, L8, L9, L10, L11 = L5(L6, L7, L8)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11)
  L5 = _UPVALUE0_
  L5 = L5.fmt_mac
  L6 = A0.map
  L7 = L6
  L6 = L6.get
  L8 = A1
  L9 = "src_mac"
  L6, L7, L8, L9, L10, L11 = L6(L7, L8, L9)
  L5 = L5(L6, L7, L8, L9, L10, L11)
  if L4 and L5 then
    L6 = translatef
    L7 = "From %s in %s with source %s and %s"
    L8 = L3
    L9 = L2
    L10 = L4
    L11 = L5
    return L6(L7, L8, L9, L10, L11)
  elseif L4 or L5 then
    L6 = translatef
    L7 = "From %s in %s with source %s"
    L8 = L3
    L9 = L2
    L10 = L4 or L10
    if not L4 then
      L10 = L5
    end
    return L6(L7, L8, L9, L10)
  else
    L6 = translatef
    L7 = "From %s in %s"
    L8 = L3
    L9 = L2
    return L6(L7, L8, L9)
  end
end
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.fmt_ip
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "src_dip"
  L3 = L3(L4, L5, L6)
  L4 = translate
  L5 = "any router IP"
  L4, L5, L6, L7 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = _UPVALUE0_
  L3 = L3.fmt_port
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "src_dport"
  L4, L5, L6, L7 = L4(L5, L6, L7)
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = translatef
    L5 = "Via %s at %s"
    L6 = L2
    L7 = L3
    return L4(L5, L6, L7)
  else
    L4 = translatef
    L5 = "Via %s"
    L6 = L2
    return L4(L5, L6)
  end
end
L5 = s
L6 = L5
L5 = L5.option
L7 = DummyValue
L8 = "match"
L9 = translate
L10 = "Match"
L9, L10 = L9(L10)
L5 = L5(L6, L7, L8, L9, L10)
match = L5
L5 = match
L5.rawhtml = true
L5 = match
L5.width = "50%"
L5 = match
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = {}
  L3 = _UPVALUE0_
  L4 = A0
  L5 = A1
  L3 = L3(L4, L5)
  L4 = _UPVALUE1_
  L5 = A0
  L6 = A1
  L4 = L4(L5, L6)
  L5 = _UPVALUE2_
  L6 = A0
  L7 = A1
  L5, L6, L7 = L5(L6, L7)
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L2 = "<small>%s<br />%s<br />%s</small>" % L2
  return L2
end
L5.cfgvalue = L6
L5 = s
L6 = L5
L5 = L5.option
L7 = DummyValue
L8 = "dest"
L9 = translate
L10 = "Forward to"
L9, L10 = L9(L10)
L5 = L5(L6, L7, L8, L9, L10)
dest = L5
L5 = dest
L5.rawhtml = true
L5 = dest
L5.width = "40%"
L5 = dest
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2.fmt_zone
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "dest"
  L3 = L3(L4, L5, L6)
  L4 = translate
  L5 = "any zone"
  L4, L5, L6, L7, L8, L9 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L3 = _UPVALUE0_
  L3 = L3.fmt_ip
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "dest_ip"
  L4 = L4(L5, L6, L7)
  L5 = translate
  L6 = "any host"
  L5, L6, L7, L8, L9 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = _UPVALUE0_
  L4 = L4.fmt_port
  L5 = A0.map
  L6 = L5
  L5 = L5.get
  L7 = A1
  L8 = "dest_port"
  L5, L6, L7, L8, L9 = L5(L6, L7, L8)
  L4 = L4(L5, L6, L7, L8, L9)
  if not L4 then
    L4 = _UPVALUE0_
    L4 = L4.fmt_port
    L5 = A0.map
    L6 = L5
    L5 = L5.get
    L7 = A1
    L8 = "src_dport"
    L5, L6, L7, L8, L9 = L5(L6, L7, L8)
    L4 = L4(L5, L6, L7, L8, L9)
  end
  if L4 then
    L5 = translatef
    L6 = "%s, %s in %s"
    L7 = L3
    L8 = L4
    L9 = L2
    return L5(L6, L7, L8, L9)
  else
    L5 = translatef
    L6 = "%s in %s"
    L7 = L3
    L8 = L2
    return L5(L6, L7, L8)
  end
end
L5.cfgvalue = L6
L5 = L1.opt_enabled
L6 = s
L7 = Flag
L8 = translate
L9 = "Enable"
L8, L9, L10 = L8(L9)
L5 = L5(L6, L7, L8, L9, L10)
L5.width = "1%"
L5 = m
return L5
