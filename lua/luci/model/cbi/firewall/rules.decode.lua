local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = require
L1 = "luci.dispatcher"
L0 = L0(L1)
L1 = require
L2 = "luci.tools.firewall"
L1 = L1(L2)
L2 = Map
L3 = "firewall"
L4 = translate
L5 = "Firewall - Traffic Rules"
L4 = L4(L5)
L5 = translate
L6 = [[
Traffic rules define policies for packets traveling between 
		different zones, for example to reject traffic between certain hosts 
		or to open WAN ports on the router.]]
L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12)
m = L2
L2 = m
L3 = L2
L2 = L2.section
L4 = TypedSection
L5 = "rule"
L6 = translate
L7 = "Traffic Rules"
L6, L7, L8, L9, L10, L11, L12 = L6(L7)
L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12)
s = L2
L2 = s
L2.addremove = true
L2 = s
L2.anonymous = true
L2 = s
L2.sortable = true
L2 = s
L2.template = "cbi/tblsection"
L2 = s
L3 = L0.build_url
L4 = "admin/network/firewall/rules/%s"
L3 = L3(L4)
L2.extedit = L3
L2 = s
L2 = L2.defaults
L2.target = "ACCEPT"
L2 = s
L2.template_addremove = "firewall/cbi_addrule"
L2 = s
function L3(A0, A1)
  local L2, L3, L4
  L2 = TypedSection
  L2 = L2.create
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  created = L2
end
L2.create = L3
L2 = s
function L3(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = TypedSection
  L2 = L2.parse
  L3 = A0
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = ...
  L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L2 = m
  L3 = L2
  L2 = L2.formvalue
  L4 = "_newopen.name"
  L2 = L2(L3, L4)
  L3 = m
  L4 = L3
  L3 = L3.formvalue
  L5 = "_newopen.proto"
  L3 = L3(L4, L5)
  L4 = m
  L5 = L4
  L4 = L4.formvalue
  L6 = "_newopen.extport"
  L4 = L4(L5, L6)
  L5 = m
  L6 = L5
  L5 = L5.formvalue
  L7 = "_newopen.submit"
  L5 = L5(L6, L7)
  L6 = m
  L7 = L6
  L6 = L6.formvalue
  L8 = "_newfwd.name"
  L6 = L6(L7, L8)
  L7 = m
  L8 = L7
  L7 = L7.formvalue
  L9 = "_newfwd.src"
  L7 = L7(L8, L9)
  L8 = m
  L9 = L8
  L8 = L8.formvalue
  L10 = "_newfwd.dest"
  L8 = L8(L9, L10)
  L9 = m
  L10 = L9
  L9 = L9.formvalue
  L11 = "_newfwd.submit"
  L9 = L9(L10, L11)
  if L5 then
    L10 = TypedSection
    L10 = L10.create
    L11 = A0
    L12 = section
    L10 = L10(L11, L12)
    created = L10
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "target"
    L14 = "ACCEPT"
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "src"
    L14 = "wan"
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "proto"
    L14 = L3 or L14
    if L3 == "other" or not L3 then
      L14 = "all"
    end
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "dest_port"
    L14 = L4
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "name"
    L14 = L2
    L10(L11, L12, L13, L14)
    if L3 ~= "other" and L4 then
      L10 = #L4
      if 0 < L10 then
        L10 = nil
        created = L10
      end
    end
  elseif L9 then
    L10 = TypedSection
    L10 = L10.create
    L11 = A0
    L12 = section
    L10 = L10(L11, L12)
    created = L10
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "target"
    L14 = "ACCEPT"
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "src"
    L14 = L7
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "dest"
    L14 = L8
    L10(L11, L12, L13, L14)
    L10 = A0.map
    L11 = L10
    L10 = L10.set
    L12 = created
    L13 = "name"
    L14 = L6
    L10(L11, L12, L13, L14)
  end
  L10 = created
  if L10 then
    L10 = m
    L10 = L10.uci
    L11 = L10
    L10 = L10.save
    L12 = "firewall"
    L10(L11, L12)
    L10 = luci
    L10 = L10.http
    L10 = L10.redirect
    L11 = _UPVALUE0_
    L11 = L11.build_url
    L12 = "admin/network/firewall/rules"
    L13 = created
    L11, L12, L13, L14 = L11(L12, L13)
    L10(L11, L12, L13, L14)
  end
end
L2.parse = L3
L2 = L1.opt_name
L3 = s
L4 = DummyValue
L5 = translate
L6 = "Name"
L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12)
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0.map
  L3 = L2
  L2 = L2.get
  L4 = A1
  L5 = "family"
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.fmt_proto
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "proto"
  L4 = L4(L5, L6, L7)
  L5 = A0.map
  L6 = L5
  L5 = L5.get
  L7 = A1
  L8 = "icmp_type"
  L5, L6, L7, L8 = L5(L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  if L2 then
    L5 = L2
    L4 = L2.match
    L6 = "4"
    L4 = L4(L5, L6)
    if L4 then
      L4 = {}
      L5 = translate
      L6 = "IPv4"
      L5 = L5(L6)
      L6 = L3
      L4[1] = L5
      L4[2] = L6
      L4 = "%s-%s" % L4
      return L4
  end
  else
    if L2 then
      L5 = L2
      L4 = L2.match
      L6 = "6"
      L4 = L4(L5, L6)
      if L4 then
        L4 = {}
        L5 = translate
        L6 = "IPv6"
        L5 = L5(L6)
        L6 = L3
        L4[1] = L5
        L4[2] = L6
        L4 = "%s-%s" % L4
        return L4
    end
    else
      L4 = {}
      L5 = translate
      L6 = "Any"
      L5 = L5(L6)
      L6 = L3
      L4[1] = L5
      L4[2] = L6
      L4 = "%s %s" % L4
      return L4
    end
  end
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
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2.fmt_zone
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "dest"
  L3, L4, L5, L6, L7, L8, L9 = L3(L4, L5, L6)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L3 = _UPVALUE0_
  L3 = L3.fmt_port
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "dest_port"
  L4, L5, L6, L7, L8, L9 = L4(L5, L6, L7)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  if L2 then
    L4 = _UPVALUE0_
    L4 = L4.fmt_ip
    L5 = A0.map
    L6 = L5
    L5 = L5.get
    L7 = A1
    L8 = "dest_ip"
    L5 = L5(L6, L7, L8)
    L6 = translate
    L7 = "any host"
    L6, L7, L8, L9 = L6(L7)
    L4 = L4(L5, L6, L7, L8, L9)
    if L3 then
      L5 = translatef
      L6 = "To %s, %s in %s"
      L7 = L4
      L8 = L3
      L9 = L2
      return L5(L6, L7, L8, L9)
    else
      L5 = translatef
      L6 = "To %s in %s"
      L7 = L4
      L8 = L2
      return L5(L6, L7, L8)
    end
  else
    L4 = _UPVALUE0_
    L4 = L4.fmt_ip
    L5 = A0.map
    L6 = L5
    L5 = L5.get
    L7 = A1
    L8 = "dest_ip"
    L5 = L5(L6, L7, L8)
    L6 = translate
    L7 = "any router IP"
    L6, L7, L8, L9 = L6(L7)
    L4 = L4(L5, L6, L7, L8, L9)
    if L3 then
      L5 = translatef
      L6 = "To %s at %s on <var>this device</var>"
      L7 = L4
      L8 = L3
      return L5(L6, L7, L8)
    else
      L5 = translatef
      L6 = "To %s on <var>this device</var>"
      L7 = L4
      return L5(L6, L7)
    end
  end
end
function L5(A0, A1)
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
    L6 = "To %s, %s in %s"
    L7 = L3
    L8 = L4
    L9 = L2
    return L5(L6, L7, L8, L9)
  else
    L5 = translatef
    L6 = "To %s in %s"
    L7 = L3
    L8 = L2
    return L5(L6, L7, L8)
  end
end
L6 = s
L7 = L6
L6 = L6.option
L8 = DummyValue
L9 = "match"
L10 = translate
L11 = "Match"
L10, L11, L12 = L10(L11)
L6 = L6(L7, L8, L9, L10, L11, L12)
match = L6
L6 = match
L6.rawhtml = true
L6 = match
L6.width = "70%"
L6 = match
function L7(A0, A1)
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
L6.cfgvalue = L7
L6 = s
L7 = L6
L6 = L6.option
L8 = DummyValue
L9 = "target"
L10 = translate
L11 = "Action"
L10, L11, L12 = L10(L11)
L6 = L6(L7, L8, L9, L10, L11, L12)
target = L6
L6 = target
L6.rawhtml = true
L6 = target
L6.width = "20%"
L6 = target
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.fmt_target
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "target"
  L3 = L3(L4, L5, L6)
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "dest"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L3 = L3.fmt_limit
  L4 = A0.map
  L5 = L4
  L4 = L4.get
  L6 = A1
  L7 = "limit"
  L4 = L4(L5, L6, L7)
  L5 = A0.map
  L6 = L5
  L5 = L5.get
  L7 = A1
  L8 = "limit_burst"
  L5, L6, L7, L8 = L5(L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  if L3 then
    L4 = translatef
    L5 = "<var>%s</var> and limit to %s"
    L6 = L2
    L7 = L3
    return L4(L5, L6, L7)
  else
    L4 = "<var>%s</var>" % L2
    return L4
  end
end
L6.cfgvalue = L7
L6 = L1.opt_enabled
L7 = s
L8 = Flag
L9 = translate
L10 = "Enable"
L9, L10, L11, L12 = L9(L10)
L6 = L6(L7, L8, L9, L10, L11, L12)
L6.width = "1%"
L6 = m
L7 = L6
L6 = L6.section
L8 = TypedSection
L9 = "redirect"
L10 = translate
L11 = "Source NAT"
L10 = L10(L11)
L11 = translate
L12 = [[
Source NAT is a specific form of masquerading which allows 
		fine grained control over the source IP used for outgoing traffic, 
		for example to map multiple WAN addresses to internal subnets.]]
L11, L12 = L11(L12)
L6 = L6(L7, L8, L9, L10, L11, L12)
s = L6
L6 = s
L6.template = "cbi/tblsection"
L6 = s
L6.addremove = true
L6 = s
L6.anonymous = true
L6 = s
L6.sortable = true
L6 = s
L7 = L0.build_url
L8 = "admin/network/firewall/rules/%s"
L7 = L7(L8)
L6.extedit = L7
L6 = s
L6.template_addremove = "firewall/cbi_addsnat"
L6 = s
function L7(A0, A1)
  local L2, L3, L4
  L2 = TypedSection
  L2 = L2.create
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  created = L2
end
L6.create = L7
L6 = s
function L7(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = TypedSection
  L2 = L2.parse
  L3 = A0
  L4, L5, L6, L7, L8, L9, L10, L11, L12 = ...
  L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12)
  L2 = m
  L3 = L2
  L2 = L2.formvalue
  L4 = "_newsnat.name"
  L2 = L2(L3, L4)
  L3 = m
  L4 = L3
  L3 = L3.formvalue
  L5 = "_newsnat.src"
  L3 = L3(L4, L5)
  L4 = m
  L5 = L4
  L4 = L4.formvalue
  L6 = "_newsnat.dest"
  L4 = L4(L5, L6)
  L5 = m
  L6 = L5
  L5 = L5.formvalue
  L7 = "_newsnat.dip"
  L5 = L5(L6, L7)
  L6 = m
  L7 = L6
  L6 = L6.formvalue
  L8 = "_newsnat.dport"
  L6 = L6(L7, L8)
  L7 = m
  L8 = L7
  L7 = L7.formvalue
  L9 = "_newsnat.submit"
  L7 = L7(L8, L9)
  if L7 and L5 then
    L8 = #L5
    if 0 < L8 then
      L8 = TypedSection
      L8 = L8.create
      L9 = A0
      L10 = section
      L8 = L8(L9, L10)
      created = L8
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "target"
      L12 = "SNAT"
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "src"
      L12 = L3
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "dest"
      L12 = L4
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "proto"
      L12 = "all"
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "src_dip"
      L12 = L5
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "src_dport"
      L12 = L6
      L8(L9, L10, L11, L12)
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = created
      L11 = "name"
      L12 = L2
      L8(L9, L10, L11, L12)
    end
  end
  L8 = created
  if L8 then
    L8 = m
    L8 = L8.uci
    L9 = L8
    L8 = L8.save
    L10 = "firewall"
    L8(L9, L10)
    L8 = luci
    L8 = L8.http
    L8 = L8.redirect
    L9 = _UPVALUE0_
    L9 = L9.build_url
    L10 = "admin/network/firewall/rules"
    L11 = created
    L9, L10, L11, L12 = L9(L10, L11)
    L8(L9, L10, L11, L12)
  end
end
L6.parse = L7
L6 = s
function L7(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.map
  L3 = L2
  L2 = L2.get
  L4 = A1
  L5 = "target"
  L2 = L2(L3, L4, L5)
  L2 = L2 == "SNAT"
  return L2
end
L6.filter = L7
L6 = L1.opt_name
L7 = s
L8 = DummyValue
L9 = translate
L10 = "Name"
L9, L10, L11, L12 = L9(L10)
L6(L7, L8, L9, L10, L11, L12)
L6 = s
L7 = L6
L6 = L6.option
L8 = DummyValue
L9 = "match"
L10 = translate
L11 = "Match"
L10, L11, L12 = L10(L11)
L6 = L6(L7, L8, L9, L10, L11, L12)
match = L6
L6 = match
L6.rawhtml = true
L6 = match
L6.width = "70%"
L6 = match
function L7(A0, A1)
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
L6.cfgvalue = L7
L6 = s
L7 = L6
L6 = L6.option
L8 = DummyValue
L9 = "via"
L10 = translate
L11 = "Action"
L10, L11, L12 = L10(L11)
L6 = L6(L7, L8, L9, L10, L11, L12)
snat = L6
L6 = snat
L6.rawhtml = true
L6 = snat
L6.width = "20%"
L6 = snat
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.fmt_ip
  L3 = A0.map
  L4 = L3
  L3 = L3.get
  L5 = A1
  L6 = "src_dip"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6)
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
  if L2 and L3 then
    L4 = translatef
    L5 = "Rewrite to source %s, %s"
    L6 = L2
    L7 = L3
    return L4(L5, L6, L7)
  else
    L4 = translatef
    L5 = "Rewrite to source %s"
    L6 = L2 or L6
    if not L2 then
      L6 = L3
    end
    return L4(L5, L6)
  end
end
L6.cfgvalue = L7
L6 = L1.opt_enabled
L7 = s
L8 = Flag
L9 = translate
L10 = "Enable"
L9, L10, L11, L12 = L9(L10)
L6 = L6(L7, L8, L9, L10, L11, L12)
L6.width = "1%"
L6 = m
return L6
