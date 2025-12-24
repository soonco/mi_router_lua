local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
L0, L1, L2 = ...
L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = ListValue
L22 = "encaps"
L23 = translate
L24 = "PPPoA Encapsulation"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L3 = L18
L19 = L3
L18 = L3.value
L20 = "vc"
L21 = "VC-Mux"
L18(L19, L20, L21)
L19 = L3
L18 = L3.value
L20 = "llc"
L21 = "LLC"
L18(L19, L20, L21)
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = Value
L22 = "atmdev"
L23 = translate
L24 = "ATM device number"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L4 = L18
L4.default = "0"
L4.datatype = "uinteger"
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = Value
L22 = "vci"
L23 = translate
L24 = "ATM Virtual Channel Identifier (VCI)"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L5 = L18
L5.default = "35"
L5.datatype = "uinteger"
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = Value
L22 = "vpi"
L23 = translate
L24 = "ATM Virtual Path Identifier (VPI)"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L6 = L18
L6.default = "8"
L6.datatype = "uinteger"
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = Value
L22 = "username"
L23 = translate
L24 = "PAP/CHAP username"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L7 = L18
L19 = L1
L18 = L1.taboption
L20 = "general"
L21 = Value
L22 = "password"
L23 = translate
L24 = "PAP/CHAP password"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L8 = L18
L8.password = true
L18 = luci
L18 = L18.model
L18 = L18.network
L19 = L18
L18 = L18.has_ipv6
L18 = L18(L19)
if L18 then
  L19 = L1
  L18 = L1.taboption
  L20 = "advanced"
  L21 = Flag
  L22 = "ipv6"
  L23 = translate
  L24 = "Enable IPv6 negotiation on the PPP link"
  L23, L24, L25 = L23(L24)
  L18 = L18(L19, L20, L21, L22, L23, L24, L25)
  L9 = L18
  L18 = L9.disabled
  L9.default = L18
end
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Flag
L22 = "defaultroute"
L23 = translate
L24 = "Use default gateway"
L23 = L23(L24)
L24 = translate
L25 = "If unchecked, no default route is configured"
L24, L25 = L24(L25)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L10 = L18
L18 = L10.enabled
L10.default = L18
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Value
L22 = "metric"
L23 = translate
L24 = "Use gateway metric"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L11 = L18
L11.placeholder = "0"
L11.datatype = "uinteger"
L19 = L11
L18 = L11.depends
L20 = "defaultroute"
L21 = L10.enabled
L18(L19, L20, L21)
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Flag
L22 = "peerdns"
L23 = translate
L24 = "Use DNS servers advertised by peer"
L23 = L23(L24)
L24 = translate
L25 = "If unchecked, the advertised DNS server addresses are ignored"
L24, L25 = L24(L25)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L12 = L18
L18 = L12.enabled
L12.default = L18
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = DynamicList
L22 = "dns"
L23 = translate
L24 = "Use custom DNS servers"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L13 = L18
L19 = L13
L18 = L13.depends
L20 = "peerdns"
L21 = ""
L18(L19, L20, L21)
L13.datatype = "ipaddr"
L13.cast = "string"
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Value
L22 = "_keepalive_failure"
L23 = translate
L24 = "LCP echo failure threshold"
L23 = L23(L24)
L24 = translate
L25 = "Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures"
L24, L25 = L24(L25)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L14 = L18
function L18(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = m
  L3 = L2
  L2 = L2.get
  L4 = A1
  L5 = "keepalive"
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = #L2
    if 0 < L3 then
      L3 = tonumber
      L5 = L2
      L4 = L2.match
      L6 = "^(%d+)[ ,]+%d+"
      L4 = L4(L5, L6)
      L4 = L4 or L4
      return L3(L4)
    end
  end
end
L14.cfgvalue = L18
function L18()
  local L0, L1
end
L14.write = L18
function L18()
  local L0, L1
end
L14.remove = L18
L14.placeholder = "0"
L14.datatype = "uinteger"
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Value
L22 = "_keepalive_interval"
L23 = translate
L24 = "LCP echo interval"
L23 = L23(L24)
L24 = translate
L25 = "Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold"
L24, L25 = L24(L25)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L15 = L18
function L18(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = m
  L3 = L2
  L2 = L2.get
  L4 = A1
  L5 = "keepalive"
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = #L2
    if 0 < L3 then
      L3 = tonumber
      L5 = L2
      L4 = L2.match
      L6 = "^%d+[ ,]+(%d+)"
      L4, L5, L6 = L4(L5, L6)
      return L3(L4, L5, L6)
    end
  end
end
L15.cfgvalue = L18
function L18(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = tonumber
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.formvalue
  L6 = A1
  L4, L5, L6, L7, L8, L9, L10, L11 = L4(L5, L6)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11)
  L3 = L3 or L3
  L4 = tonumber
  L5 = A2
  L4 = L4(L5)
  L4 = L4 or L4
  if L4 < 1 then
    L4 = 1
  end
  if 0 < L3 then
    L5 = m
    L6 = L5
    L5 = L5.set
    L7 = A1
    L8 = "keepalive"
    L9 = {}
    L10 = L3
    L11 = L4
    L9[1] = L10
    L9[2] = L11
    L9 = "%d %d" % L9
    L5(L6, L7, L8, L9)
  else
    L5 = m
    L6 = L5
    L5 = L5.del
    L7 = A1
    L8 = "keepalive"
    L5(L6, L7, L8)
  end
end
L15.write = L18
L18 = L15.write
L15.remove = L18
L15.placeholder = "5"
L15.datatype = "min(1)"
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Value
L22 = "demand"
L23 = translate
L24 = "Inactivity timeout"
L23 = L23(L24)
L24 = translate
L25 = "Close inactive connection after the given amount of seconds, use 0 to persist connection"
L24, L25 = L24(L25)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L16 = L18
L16.placeholder = "0"
L16.datatype = "uinteger"
L19 = L1
L18 = L1.taboption
L20 = "advanced"
L21 = Value
L22 = "mtu"
L23 = translate
L24 = "Override MTU"
L23, L24, L25 = L23(L24)
L18 = L18(L19, L20, L21, L22, L23, L24, L25)
L17 = L18
L17.placeholder = "1500"
L17.datatype = "max(1500)"
