local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31
L0 = require
L1 = "luci.model.network"
L0 = L0(L1)
L1 = require
L2 = "luci.model.firewall"
L1 = L1(L2)
L2 = require
L3 = "luci.dispatcher"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
L19 = Map
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L21(L22)
L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L4 = L19
L19 = luci
L19 = L19.dispatcher
L19 = L19.build_url
L19 = L19(L20)
L4.redirect = L19
L19 = L1.init
L19(L20)
L19 = L0.init
L19(L20)
L19 = L1.get_zone
L19 = L19(L20, L21)
if not L19 then
  L23, L24, L25, L26, L27, L28, L29, L30, L31 = L21(L22)
  L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  return
else
  L23 = "Zone %q"
  L25 = L19
  L24 = L19.name
  L24 = L24(L25)
  L24 = L24 or L24
  L23, L24, L25, L26, L27, L28, L29, L30, L31 = L22(L23, L24)
  L20[1] = L21
  L20[2] = L22
  L20[3] = L23
  L20[4] = L24
  L20[5] = L25
  L20[6] = L26
  L20[7] = L27
  L20[8] = L28
  L20[9] = L29
  L20[10] = L30
  L20[11] = L31
  L4.title = L20
end
L23 = L19.sid
L24 = "zone"
L25 = translatef
L26 = "Zone %q"
L28 = L19
L27 = L19.name
L27, L28, L29, L30, L31 = L27(L28)
L25 = L25(L26, L27, L28, L29, L30, L31)
L26 = translatef
L27 = [[
This section defines common properties of %q. 
		The <em>input</em> and <em>output</em> options set the default 
		policies for traffic entering and leaving this zone while the 
		<em>forward</em> option describes the policy for forwarded traffic 
		between different networks within the zone. 
		<em>Covered networks</em> specifies which available networks are 
		member of this zone.]]
L29 = L19
L28 = L19.name
L28, L29, L30, L31 = L28(L29)
L26, L27, L28, L29, L30, L31 = L26(L27, L28, L29, L30, L31)
L8 = L20
L8.anonymous = true
L8.addremove = false
L4.on_commit = L20
L23 = translate
L24 = "General Settings"
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = translate
L24 = "Advanced Settings"
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = Value
L24 = "name"
L25 = translate
L26 = "Name"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L9 = L20
L9.optional = false
L9.forcewrite = true
L9.datatype = "uciname"
L9.write = L20
L23 = "general"
L24 = ListValue
L25 = "input"
L26 = translate
L27 = "Input"
L26, L27, L28, L29, L30, L31 = L26(L27)
L23 = L8
L24 = "general"
L25 = ListValue
L26 = "output"
L27 = translate
L28 = "Output"
L27, L28, L29, L30, L31 = L27(L28)
L24 = L8
L23 = L8.taboption
L25 = "general"
L26 = ListValue
L27 = "forward"
L28 = translate
L29 = "Forward"
L28, L29, L30, L31 = L28(L29)
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24, L25, L26, L27, L28, L29, L30, L31)
L20[1] = L21
L20[2] = L22
L20[3] = L23
L20[4] = L24
L20[5] = L25
L20[6] = L26
L20[7] = L27
L20[8] = L28
L20[9] = L29
L20[10] = L30
L20[11] = L31
L5 = L20
for L23, L24 in L20, L21, L22 do
  L26 = L24
  L25 = L24.value
  L27 = "REJECT"
  L28 = translate
  L29 = "reject"
  L28, L29, L30, L31 = L28(L29)
  L25(L26, L27, L28, L29, L30, L31)
  L26 = L24
  L25 = L24.value
  L27 = "DROP"
  L28 = translate
  L29 = "drop"
  L28, L29, L30, L31 = L28(L29)
  L25(L26, L27, L28, L29, L30, L31)
  L26 = L24
  L25 = L24.value
  L27 = "ACCEPT"
  L28 = translate
  L29 = "accept"
  L28, L29, L30, L31 = L28(L29)
  L25(L26, L27, L28, L29, L30, L31)
end
L23 = Flag
L24 = "masq"
L25 = translate
L26 = "Masquerading"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = Flag
L24 = "mtu_fix"
L25 = translate
L26 = "MSS clamping"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = Value
L24 = "network"
L25 = translate
L26 = "Covered networks"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L10 = L20
L10.template = "cbi/network_netlist"
L10.widget = "checkbox"
L10.cast = "string"
L10.formvalue = L20
L10.cfgvalue = L20
L10.write = L20
L23 = ListValue
L24 = "family"
L25 = translate
L26 = "Restrict to address family"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L11 = L20
L11.rmempty = true
L23 = translate
L24 = "IPv4 and IPv6"
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = translate
L24 = "IPv4 only"
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = translate
L24 = "IPv6 only"
L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = DynamicList
L24 = "masq_src"
L25 = translate
L26 = "Restrict Masquerading to given source subnets"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L12 = L20
L12.optional = true
L12.datatype = "list(neg(or(uciname,hostname,ip4addr)))"
L12.placeholder = "0.0.0.0/0"
L23 = ""
L20(L21, L22, L23)
L23 = "ipv4"
L20(L21, L22, L23)
L23 = DynamicList
L24 = "masq_dest"
L25 = translate
L26 = "Restrict Masquerading to given destination subnets"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L13 = L20
L13.optional = true
L13.datatype = "list(neg(or(uciname,hostname,ip4addr)))"
L13.placeholder = "0.0.0.0/0"
L23 = ""
L20(L21, L22, L23)
L23 = "ipv4"
L20(L21, L22, L23)
L23 = Flag
L24 = "conntrack"
L25 = translate
L26 = "Force connection tracking"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
L23 = Flag
L24 = "log"
L25 = translate
L26 = "Enable logging on this zone"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L14 = L20
L14.rmempty = true
L14.enabled = "1"
L23 = Value
L24 = "log_limit"
L25 = translate
L26 = "Limit log messages"
L25, L26, L27, L28, L29, L30, L31 = L25(L26)
L15 = L20
L15.placeholder = "10/minute"
L23 = "1"
L20(L21, L22, L23)
L23 = L19.sid
L24 = "fwd_out"
L25 = translate
L26 = "Inter-Zone Forwarding"
L25 = L25(L26)
L26 = translatef
L27 = [[
The options below control the forwarding policies between 
		this zone (%s) and other zones. <em>Destination zones</em> cover 
		forwarded traffic <strong>originating from %q</strong>. 
		<em>Source zones</em> match forwarded traffic from other zones 
		<strong>targeted at %q</strong>. The forwarding rule is 
		<em>unidirectional</em>, e.g. a forward from lan to wan does 
		<em>not</em> imply a permission to forward from wan to lan as well.]]
L29 = L19
L28 = L19.name
L28 = L28(L29)
L30 = L19
L29 = L19.name
L29 = L29(L30)
L31 = L19
L30 = L19.name
L30, L31 = L30(L31)
L26, L27, L28, L29, L30, L31 = L26(L27, L28, L29, L30, L31)
L16 = L20
L23 = "out"
L24 = translate
L25 = "Allow forward to <em>destination zones</em>:"
L24, L25, L26, L27, L28, L29, L30, L31 = L24(L25)
L17 = L20
L17.nocreate = true
L17.widget = "checkbox"
L17.exclude = L20
L17.template = "cbi/firewall_zonelist"
L23 = "in"
L24 = translate
L25 = "Allow forward from <em>source zones</em>:"
L24, L25, L26, L27, L28, L29, L30, L31 = L24(L25)
L18 = L20
L18.nocreate = true
L18.widget = "checkbox"
L18.exclude = L20
L18.template = "cbi/firewall_zonelist"
L17.cfgvalue = L20
L18.cfgvalue = L20
L17.formvalue = L20
L18.formvalue = L20
L17.write = L20
L18.write = L20
return L4
