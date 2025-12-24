local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
L0, L1, L2 = ...
L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
L17 = L1
L16 = L1.taboption
L18 = "general"
L19 = Value
L20 = "username"
L21 = translate
L22 = "PAP/CHAP username"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L3 = L16
L17 = L1
L16 = L1.taboption
L18 = "general"
L19 = Value
L20 = "password"
L21 = translate
L22 = "PAP/CHAP password"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L4 = L16
L4.password = true
L17 = L1
L16 = L1.taboption
L18 = "general"
L19 = Value
L20 = "ac"
L21 = translate
L22 = "Access Concentrator"
L21 = L21(L22)
L22 = translate
L23 = "Leave empty to autodetect"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L5 = L16
L16 = translate
L17 = "auto"
L16 = L16(L17)
L5.placeholder = L16
L17 = L1
L16 = L1.taboption
L18 = "general"
L19 = Value
L20 = "service"
L21 = translate
L22 = "Service Name"
L21 = L21(L22)
L22 = translate
L23 = "Leave empty to autodetect"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L6 = L16
L16 = translate
L17 = "auto"
L16 = L16(L17)
L6.placeholder = L16
L16 = luci
L16 = L16.model
L16 = L16.network
L17 = L16
L16 = L16.has_ipv6
L16 = L16(L17)
if L16 then
  L17 = L1
  L16 = L1.taboption
  L18 = "advanced"
  L19 = Flag
  L20 = "ipv6"
  L21 = translate
  L22 = "Enable IPv6 negotiation on the PPP link"
  L21, L22, L23 = L21(L22)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23)
  L7 = L16
  L16 = L7.disabled
  L7.default = L16
end
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Flag
L20 = "defaultroute"
L21 = translate
L22 = "Use default gateway"
L21 = L21(L22)
L22 = translate
L23 = "If unchecked, no default route is configured"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L8 = L16
L16 = L8.enabled
L8.default = L16
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Value
L20 = "metric"
L21 = translate
L22 = "Use gateway metric"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L9 = L16
L9.placeholder = "0"
L9.datatype = "uinteger"
L17 = L9
L16 = L9.depends
L18 = "defaultroute"
L19 = L8.enabled
L16(L17, L18, L19)
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Flag
L20 = "peerdns"
L21 = translate
L22 = "Use DNS servers advertised by peer"
L21 = L21(L22)
L22 = translate
L23 = "If unchecked, the advertised DNS server addresses are ignored"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L10 = L16
L16 = L10.enabled
L10.default = L16
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = DynamicList
L20 = "dns"
L21 = translate
L22 = "Use custom DNS servers"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L11 = L16
L17 = L11
L16 = L11.depends
L18 = "peerdns"
L19 = ""
L16(L17, L18, L19)
L11.datatype = "ipaddr"
L11.cast = "string"
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Value
L20 = "_keepalive_failure"
L21 = translate
L22 = "LCP echo failure threshold"
L21 = L21(L22)
L22 = translate
L23 = "Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L12 = L16
function L16(A0, A1)
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
L12.cfgvalue = L16
function L16()
  local L0, L1
end
L12.write = L16
function L16()
  local L0, L1
end
L12.remove = L16
L12.placeholder = "0"
L12.datatype = "uinteger"
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Value
L20 = "_keepalive_interval"
L21 = translate
L22 = "LCP echo interval"
L21 = L21(L22)
L22 = translate
L23 = "Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L13 = L16
function L16(A0, A1)
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
L13.cfgvalue = L16
function L16(A0, A1, A2)
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
L13.write = L16
L16 = L13.write
L13.remove = L16
L13.placeholder = "5"
L13.datatype = "min(1)"
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Value
L20 = "demand"
L21 = translate
L22 = "Inactivity timeout"
L21 = L21(L22)
L22 = translate
L23 = "Close inactive connection after the given amount of seconds, use 0 to persist connection"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L14 = L16
L14.placeholder = "0"
L14.datatype = "uinteger"
L17 = L1
L16 = L1.taboption
L18 = "advanced"
L19 = Value
L20 = "mtu"
L21 = translate
L22 = "Override MTU"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L15 = L16
L15.placeholder = "1500"
L15.datatype = "max(1500)"
