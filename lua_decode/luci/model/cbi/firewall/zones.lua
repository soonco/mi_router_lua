local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = require
L1 = "luci.dispatcher"
L0 = L0(L1)
L1 = require
L2 = "luci.model.firewall"
L1 = L1(L2)
L2, L3, L4, L5, L6, L7 = nil, nil, nil, nil, nil, nil
L11 = "Firewall - Zone Settings"
L11 = translate
L12 = "The firewall creates zones over your network interfaces to control network traffic flow."
L11, L12, L13, L14, L15, L16, L17 = L11(L12)
L2 = L8
L8(L9)
L11 = "defaults"
L12 = translate
L13 = "General Settings"
L12, L13, L14, L15, L16, L17 = L12(L13)
L3 = L8
L3.anonymous = true
L3.addremove = false
L11 = "syn_flood"
L12 = translate
L13 = "Enable SYN-flood protection"
L12, L13, L14, L15, L16, L17 = L12(L13)
L8(L9, L10, L11, L12, L13, L14, L15, L16, L17)
L11 = "drop_invalid"
L12 = translate
L13 = "Drop invalid packets"
L12, L13, L14, L15, L16, L17 = L12(L13)
L4 = L8
L4.default = L8
L11 = ListValue
L12 = "input"
L13 = translate
L14 = "Input"
L13, L14, L15, L16, L17 = L13(L14)
L11 = L3
L12 = ListValue
L13 = "output"
L14 = translate
L15 = "Output"
L14, L15, L16, L17 = L14(L15)
L12 = L3
L11 = L3.option
L13 = ListValue
L14 = "forward"
L15 = translate
L16 = "Forward"
L15, L16, L17 = L15(L16)
L11, L12, L13, L14, L15, L16, L17 = L11(L12, L13, L14, L15, L16, L17)
L8[1] = L9
L8[2] = L10
L8[3] = L11
L8[4] = L12
L8[5] = L13
L8[6] = L14
L8[7] = L15
L8[8] = L16
L8[9] = L17
L5 = L8
for L11, L12 in L8, L9, L10 do
  L14 = L12
  L13 = L12.value
  L15 = "REJECT"
  L16 = translate
  L17 = "reject"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
  L14 = L12
  L13 = L12.value
  L15 = "DROP"
  L16 = translate
  L17 = "drop"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
  L14 = L12
  L13 = L12.value
  L15 = "ACCEPT"
  L16 = translate
  L17 = "accept"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
end
L11 = "zone"
L12 = translate
L13 = "Zones"
L12, L13, L14, L15, L16, L17 = L12(L13)
L3 = L8
L3.template = "cbi/tblsection"
L3.anonymous = true
L3.addremove = true
L11 = "firewall"
L12 = "zones"
L13 = "%s"
L3.extedit = L8
L3.create = L8
L3.remove = L8
L11 = "_info"
L12 = translate
L13 = "Zone \226\135\146 Forwardings"
L12, L13, L14, L15, L16, L17 = L12(L13)
L4 = L8
L4.template = "cbi/firewall_zoneforwards"
L4.cfgvalue = L8
L11 = ListValue
L12 = "input"
L13 = translate
L14 = "Input"
L13, L14, L15, L16, L17 = L13(L14)
L11 = L3
L12 = ListValue
L13 = "output"
L14 = translate
L15 = "Output"
L14, L15, L16, L17 = L14(L15)
L12 = L3
L11 = L3.option
L13 = ListValue
L14 = "forward"
L15 = translate
L16 = "Forward"
L15, L16, L17 = L15(L16)
L11, L12, L13, L14, L15, L16, L17 = L11(L12, L13, L14, L15, L16, L17)
L8[1] = L9
L8[2] = L10
L8[3] = L11
L8[4] = L12
L8[5] = L13
L8[6] = L14
L8[7] = L15
L8[8] = L16
L8[9] = L17
L5 = L8
for L11, L12 in L8, L9, L10 do
  L14 = L12
  L13 = L12.value
  L15 = "REJECT"
  L16 = translate
  L17 = "reject"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
  L14 = L12
  L13 = L12.value
  L15 = "DROP"
  L16 = translate
  L17 = "drop"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
  L14 = L12
  L13 = L12.value
  L15 = "ACCEPT"
  L16 = translate
  L17 = "accept"
  L16, L17 = L16(L17)
  L13(L14, L15, L16, L17)
end
L11 = "masq"
L12 = translate
L13 = "Masquerading"
L12, L13, L14, L15, L16, L17 = L12(L13)
L8(L9, L10, L11, L12, L13, L14, L15, L16, L17)
L11 = "mtu_fix"
L12 = translate
L13 = "MSS clamping"
L12, L13, L14, L15, L16, L17 = L12(L13)
L8(L9, L10, L11, L12, L13, L14, L15, L16, L17)
return L2
