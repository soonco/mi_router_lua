local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
L0, L1, L2 = ...
L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
L16 = L1
L15 = L1.taboption
L20 = translate
L21 = "Modem device"
L20, L21, L22, L23 = L20(L21)
L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23)
L3 = L15
L3.rmempty = false
L15 = nixio
L15 = L15.fs
L15 = L15.glob
L16 = "/dev/tty*S*"
L15 = L15(L16)
if not L15 then
  L15 = nixio
  L15 = L15.fs
  L15 = L15.glob
  L16 = "/dev/tts/*"
  L15 = L15(L16)
end
if L15 then
  L16 = nil
  for L20 in L17, L18, L19 do
    L22 = L3
    L21 = L3.value
    L23 = L20
    L21(L22, L23)
  end
end
L16 = L1.taboption
L20 = "username"
L21 = translate
L22 = "PAP/CHAP username"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L4 = L16
L16 = L1.taboption
L20 = "password"
L21 = translate
L22 = "PAP/CHAP password"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L5 = L16
L5.password = true
L16 = luci
L16 = L16.model
L16 = L16.network
L16 = L16.has_ipv6
L16 = L16(L17)
if L16 then
  L16 = L1.taboption
  L20 = "ipv6"
  L21 = translate
  L22 = "Enable IPv6 negotiation on the PPP link"
  L21, L22, L23 = L21(L22)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23)
  L6 = L16
  L16 = L6.disabled
  L6.default = L16
end
L16 = L1.taboption
L20 = "defaultroute"
L21 = translate
L22 = "Use default gateway"
L21 = L21(L22)
L22 = translate
L23 = "If unchecked, no default route is configured"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L7 = L16
L16 = L7.enabled
L7.default = L16
L16 = L1.taboption
L20 = "metric"
L21 = translate
L22 = "Use gateway metric"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L8 = L16
L8.placeholder = "0"
L8.datatype = "uinteger"
L16 = L8.depends
L16(L17, L18, L19)
L16 = L1.taboption
L20 = "peerdns"
L21 = translate
L22 = "Use DNS servers advertised by peer"
L21 = L21(L22)
L22 = translate
L23 = "If unchecked, the advertised DNS server addresses are ignored"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L9 = L16
L16 = L9.enabled
L9.default = L16
L16 = L1.taboption
L20 = "dns"
L21 = translate
L22 = "Use custom DNS servers"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L10 = L16
L16 = L10.depends
L16(L17, L18, L19)
L10.datatype = "ipaddr"
L10.cast = "string"
L16 = L1.taboption
L20 = "_keepalive_failure"
L21 = translate
L22 = "LCP echo failure threshold"
L21 = L21(L22)
L22 = translate
L23 = "Presume peer to be dead after given amount of LCP echo failures, use 0 to ignore failures"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L11 = L16
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
L11.cfgvalue = L16
function L16()
  local L0, L1
end
L11.write = L16
function L16()
  local L0, L1
end
L11.remove = L16
L11.placeholder = "0"
L11.datatype = "uinteger"
L16 = L1.taboption
L20 = "_keepalive_interval"
L21 = translate
L22 = "LCP echo interval"
L21 = L21(L22)
L22 = translate
L23 = "Send LCP echo requests at the given interval in seconds, only effective in conjunction with failure threshold"
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
      L6 = "^%d+[ ,]+(%d+)"
      L4, L5, L6 = L4(L5, L6)
      return L3(L4, L5, L6)
    end
  end
end
L12.cfgvalue = L16
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
L12.write = L16
L16 = L12.write
L12.remove = L16
L12.placeholder = "5"
L12.datatype = "min(1)"
L16 = L1.taboption
L20 = "demand"
L21 = translate
L22 = "Inactivity timeout"
L21 = L21(L22)
L22 = translate
L23 = "Close inactive connection after the given amount of seconds, use 0 to persist connection"
L22, L23 = L22(L23)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L13 = L16
L13.placeholder = "0"
L13.datatype = "uinteger"
L16 = L1.taboption
L20 = "mtu"
L21 = translate
L22 = "Override MTU"
L21, L22, L23 = L21(L22)
L16 = L16(L17, L18, L19, L20, L21, L22, L23)
L14 = L16
L14.placeholder = "1500"
L14.datatype = "max(1500)"
