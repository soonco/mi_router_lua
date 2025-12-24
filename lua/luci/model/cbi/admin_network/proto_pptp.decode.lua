local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
L0, L1, L2 = ...
L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
L15 = L1
L14 = L1.taboption
L16 = "general"
L17 = Value
L18 = "server"
L19 = translate
L20 = "VPN Server"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L3 = L14
L3.datatype = "host"
L15 = L1
L14 = L1.taboption
L16 = "general"
L17 = Value
L18 = "username"
L19 = translate
L20 = "PAP/CHAP username"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L4 = L14
L15 = L1
L14 = L1.taboption
L16 = "general"
L17 = Value
L18 = "password"
L19 = translate
L20 = "PAP/CHAP password"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L5 = L14
L5.password = true
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Flag
L18 = "defaultroute"
L19 = translate
L20 = "Use default gateway"
L19 = L19(L20)
L20 = translate
L21 = "If unchecked, no default route is configured"
L20, L21 = L20(L21)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L6 = L14
L14 = L6.enabled
L6.default = L14
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Value
L18 = "metric"
L19 = translate
L20 = "Use gateway metric"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L7 = L14
L7.placeholder = "0"
L7.datatype = "uinteger"
L15 = L7
L14 = L7.depends
L16 = "defaultroute"
L17 = L6.enabled
L14(L15, L16, L17)
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Flag
L18 = "peerdns"
L19 = translate
L20 = "Use DNS servers advertised by peer"
L19 = L19(L20)
L20 = translate
L21 = "If unchecked, the advertised DNS server addresses are ignored"
L20, L21 = L20(L21)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L8 = L14
L14 = L8.enabled
L8.default = L14
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = DynamicList
L18 = "dns"
L19 = translate
L20 = "Use custom DNS servers"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L9 = L14
L15 = L9
L14 = L9.depends
L16 = "peerdns"
L17 = ""
L14(L15, L16, L17)
L9.datatype = "ipaddr"
L9.cast = "string"
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Value
L18 = "_keepalive_failure"
L19 = translate
L20 = "LCP echo failure threshold"
L19 = L19(L20)
L20 = translate
L21 = "Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures"
L20, L21 = L20(L21)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L10 = L14
function L14(A0, A1)
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
L10.cfgvalue = L14
function L14()
  local L0, L1
end
L10.write = L14
function L14()
  local L0, L1
end
L10.remove = L14
L10.placeholder = "0"
L10.datatype = "uinteger"
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Value
L18 = "_keepalive_interval"
L19 = translate
L20 = "LCP echo interval"
L19 = L19(L20)
L20 = translate
L21 = "Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold"
L20, L21 = L20(L21)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L11 = L14
function L14(A0, A1)
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
L11.cfgvalue = L14
function L14(A0, A1, A2)
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
L11.write = L14
L14 = L11.write
L11.remove = L14
L11.placeholder = "5"
L11.datatype = "min(1)"
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Value
L18 = "demand"
L19 = translate
L20 = "Inactivity timeout"
L19 = L19(L20)
L20 = translate
L21 = "Close inactive connection after the given amount of seconds, use 0 to persist connection"
L20, L21 = L20(L21)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L12 = L14
L12.placeholder = "0"
L12.datatype = "uinteger"
L15 = L1
L14 = L1.taboption
L16 = "advanced"
L17 = Value
L18 = "mtu"
L19 = translate
L20 = "Override MTU"
L19, L20, L21 = L19(L20)
L14 = L14(L15, L16, L17, L18, L19, L20, L21)
L13 = L14
L13.placeholder = "1500"
L13.datatype = "max(1500)"
