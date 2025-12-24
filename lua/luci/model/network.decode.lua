local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40
L0 = type
L1 = next
L2 = pairs
L3 = ipairs
L4 = loadfile
L5 = table
L6 = tonumber
L7 = tostring
L8 = math
L9 = require
L10 = L9
L11 = "ubus"
L10 = L10(L11)
L11 = L9
L12 = "nixio"
L11 = L11(L12)
L12 = L9
L13 = "nixio.fs"
L12 = L12(L13)
L13 = L9
L14 = "luci.ip"
L13 = L13(L14)
L14 = L9
L15 = "luci.sys"
L14 = L14(L15)
L15 = L9
L16 = "luci.util"
L15 = L15(L16)
L16 = L9
L17 = "luci.dispatcher"
L16 = L16(L17)
L17 = L9
L18 = "luci.model.uci"
L17 = L17(L18)
L18 = L9
L19 = "luci.i18n"
L18 = L18(L19)
L19 = module
L20 = "luci.model.network"
L19(L20)
L19 = {}
IFACE_PATTERNS_VIRTUAL = L19
L19 = {}
L20 = "^wmaster%d"
L21 = "^wifi%d"
L22 = "^hwsim%d"
L23 = "^imq%d"
L24 = "^ifb%d"
L25 = "^mon%.wlan%d"
L26 = "^sit%d"
L27 = "^gre%d"
L28 = "^lo$"
L19[1] = L20
L19[2] = L21
L19[3] = L22
L19[4] = L23
L19[5] = L24
L19[6] = L25
L19[7] = L26
L19[8] = L27
L19[9] = L28
IFACE_PATTERNS_IGNORE = L19
L19 = {}
L20 = "^wlan%d"
L21 = "^wl%d"
L22 = "^ath%d"
L23 = "^%w+%.network%d"
L19[1] = L20
L19[2] = L21
L19[3] = L22
L19[4] = L23
IFACE_PATTERNS_WIRELESS = L19
L19 = L15.class
L19 = L19()
protocol = L19
L19 = {}
L20, L21, L22, L23, L24, L25, L26, L27, L28 = nil, nil, nil, nil, nil, nil, nil, nil, nil
function L29(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = {}
    if L6 == "string" then
      for L9 in L6, L7, L8 do
        if L9 ~= A3 then
          L10 = #L5
          L10 = L10 + 1
          L5[L10] = L9
        end
      end
      if 0 < L6 then
        L9 = A1
        L10 = A2
        L11 = _UPVALUE2_
        L11 = L11.concat
        L12 = L5
        L13 = " "
        L11, L12, L13 = L11(L12, L13)
        L6(L7, L8, L9, L10, L11, L12, L13)
      else
        L9 = A1
        L10 = A2
        L6(L7, L8, L9, L10)
      end
    elseif L6 == "table" then
      for L9, L10 in L6, L7, L8 do
        if L10 ~= A3 then
          L11 = #L5
          L11 = L11 + 1
          L5[L11] = L10
        end
      end
      if 0 < L6 then
        L9 = A1
        L10 = A2
        L11 = L5
        L6(L7, L8, L9, L10, L11)
      else
        L9 = A1
        L10 = A2
        L6(L7, L8, L9, L10)
      end
    end
  end
end
_filter = L29
function L29(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5 = _UPVALUE1_
  L5 = L5(L6)
  if L5 == "string" then
    L5 = {}
    for L9 in L6, L7, L8 do
      if L9 ~= A3 then
        L10 = #L5
        L10 = L10 + 1
        L5[L10] = L9
      end
    end
    L5[L6] = A3
    L9 = A1
    L10 = A2
    L11 = _UPVALUE2_
    L11 = L11.concat
    L12 = L5
    L13 = " "
    L11, L12, L13 = L11(L12, L13)
    L6(L7, L8, L9, L10, L11, L12, L13)
  else
    L5 = _UPVALUE1_
    L5 = L5(L6)
    if L5 == "table" then
      L5 = {}
      for L9, L10 in L6, L7, L8 do
        if L10 ~= A3 then
          L11 = #L5
          L11 = L11 + 1
          L5[L11] = L10
        end
      end
      L5[L6] = A3
      L9 = A1
      L10 = A2
      L11 = L5
      L6(L7, L8, L9, L10, L11)
    end
  end
end
_append = L29
function L29(A0, A1)
  local L2
  if A0 then
    L2 = #A0
    if L2 ~= 0 then
      goto lbl_17
    end
  end
  L2 = A1 or L2
  if A1 then
    L2 = #A1
    L2 = 0 < L2 and L2
  end
  do return L2 end
  goto lbl_18
  ::lbl_17::
  do return A0 end
  ::lbl_18::
end
_stror = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = A0
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
_get = L29
function L29(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  if A3 ~= nil then
    L4 = _UPVALUE0_
    L5 = A3
    L4 = L4(L5)
    if L4 == "boolean" then
      if A3 then
        L4 = "1"
        if L4 then
          goto lbl_14
          A3 = L4 or A3
        end
      end
      A3 = "0"
    end
    ::lbl_14::
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.set
    L6 = A0
    L7 = A1
    L8 = A2
    L9 = A3
    return L4(L5, L6, L7, L8, L9)
  else
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.delete
    L6 = A0
    L7 = A1
    L8 = A2
    return L4(L5, L6, L7, L8)
  end
end
_set = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  for L6, L7 in L3, L4, L5 do
    L9 = A0
    L8 = A0.match
    L10 = L7
    L8 = L8(L9, L10)
    if L8 then
      L8 = true
      return L8
    end
  end
  return L3
end
_wifi_iface = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0
  L1 = A0.match
  L3 = "^(%w+)%.network(%d+)$"
  L1, L2 = L1(L2, L3)
  if L1 and L2 then
    L3 = nil
    L4 = 0
    L5 = _UPVALUE0_
    L6 = L2
    L5 = L5(L6)
    L2 = L5
    L5 = _UPVALUE1_
    L6 = L5
    L5 = L5.foreach
    L7 = "wireless"
    L8 = "wifi-iface"
    function L9(A0)
      local L1, L2
      L1 = A0.device
      L2 = _UPVALUE0_
      if L1 == L2 then
        L1 = _UPVALUE1_
        L1 = L1 + 1
        _UPVALUE1_ = L1
        L1 = _UPVALUE1_
        L2 = _UPVALUE2_
        if L1 == L2 then
          L1 = A0[".name"]
          _UPVALUE3_ = L1
          L1 = false
          return L1
        end
      end
    end
    L5(L6, L7, L8, L9)
    return L3
  else
    L3 = _wifi_iface
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = nil
      L4 = _UPVALUE2_
      L5 = L4
      L4 = L4.foreach
      L6 = "wireless"
      L7 = "wifi-iface"
      function L8(A0)
        local L1, L2
        L1 = A0.ifname
        L2 = _UPVALUE0_
        if L1 == L2 then
          L1 = A0[".name"]
          _UPVALUE1_ = L1
          L1 = false
          return L1
        end
      end
      L4(L5, L6, L7, L8)
      return L3
    end
  end
end
_wifi_lookup = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  for L6, L7 in L3, L4, L5 do
    L9 = A0
    L8 = A0.match
    L10 = L7
    L8 = L8(L9, L10)
    if L8 then
      L8 = true
      return L8
    end
  end
  return L3
end
_iface_virtual = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  for L6, L7 in L3, L4, L5 do
    L9 = A0
    L8 = A0.match
    L10 = L7
    L8 = L8(L9, L10)
    if L8 then
      L8 = true
      return L8
    end
  end
  return L3(L4)
end
_iface_ignore = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = A0 or L1
  if not A0 then
    L1 = _UPVALUE0_
    if not L1 then
      L1 = _UPVALUE1_
      L1 = L1.cursor
      L1 = L1()
    end
  end
  _UPVALUE0_ = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.substate
  L1 = L1(L2)
  _UPVALUE2_ = L1
  L1 = {}
  _UPVALUE3_ = L1
  L1 = {}
  _UPVALUE4_ = L1
  L1 = {}
  _UPVALUE5_ = L1
  L1 = {}
  _UPVALUE6_ = L1
  L1 = _UPVALUE8_
  L1 = L1.connect
  L1 = L1()
  _UPVALUE7_ = L1
  L1 = {}
  _UPVALUE9_ = L1
  L1 = {}
  _UPVALUE10_ = L1
  L1, L2 = nil, nil
  L8, L9, L10, L11, L12, L13, L14 = L4()
  for L6, L7 in L3, L4, L5 do
    L8 = L7.name
    L9 = L8
    L8 = L8.match
    L10 = "[^:]+"
    L8 = L8(L9, L10)
    L10 = L8
    L9 = L8.match
    L11 = "^([^%.]+)%."
    L9 = L9(L10, L11)
    L10 = _iface_virtual
    L11 = L8
    L10 = L10(L11)
    if L10 then
      L10 = _UPVALUE6_
      L10[L8] = true
    end
    L10 = _UPVALUE6_
    L10 = L10[L8]
    if not L10 then
      L10 = _iface_ignore
      L11 = L8
      L10 = L10(L11)
      if L10 then
        goto lbl_138
      end
    end
    L10 = _UPVALUE3_
    L11 = _UPVALUE3_
    L11 = L11[L8]
    if not L11 then
      L11 = {}
      L12 = L7.ifindex
      L12 = L12 or L12
      L11.idx = L12
      L11.name = L8
      L12 = L7.name
      L11.rawname = L12
      L12 = {}
      L11.flags = L12
      L12 = {}
      L11.ipaddrs = L12
      L12 = {}
      L11.ip6addrs = L12
    end
    L10[L8] = L11
    if L9 then
      L10 = _UPVALUE5_
      L10[L8] = true
      L10 = _UPVALUE5_
      L10[L9] = true
    end
    L10 = L7.family
    if L10 == "packet" then
      L10 = _UPVALUE3_
      L10 = L10[L8]
      L11 = L7.flags
      L10.flags = L11
      L10 = _UPVALUE3_
      L10 = L10[L8]
      L11 = L7.data
      L10.stats = L11
      L10 = _UPVALUE3_
      L10 = L10[L8]
      L11 = L7.addr
      L10.macaddr = L11
    else
      L10 = L7.family
      if L10 == "inet" then
        L10 = _UPVALUE3_
        L10 = L10[L8]
        L10 = L10.ipaddrs
        L11 = _UPVALUE3_
        L11 = L11[L8]
        L11 = L11.ipaddrs
        L11 = #L11
        L11 = L11 + 1
        L12 = _UPVALUE13_
        L12 = L12.IPv4
        L13 = L7.addr
        L14 = L7.netmask
        L12 = L12(L13, L14)
        L10[L11] = L12
      else
        L10 = L7.family
        if L10 == "inet6" then
          L10 = _UPVALUE3_
          L10 = L10[L8]
          L10 = L10.ip6addrs
          L11 = _UPVALUE3_
          L11 = L11[L8]
          L11 = L11.ip6addrs
          L11 = #L11
          L11 = L11 + 1
          L12 = _UPVALUE13_
          L12 = L12.IPv6
          L13 = L7.addr
          L14 = L7.netmask
          L12 = L12(L13, L14)
          L10[L11] = L12
        end
      end
    end
    ::lbl_138::
  end
  for L8 in L5, L6, L7 do
    L10 = L8
    L9 = L8.match
    L11 = "STP"
    L9 = L9(L10, L11)
    if not L9 then
      L9 = _UPVALUE14_
      L9 = L9.split
      L10 = L8
      L11 = "%s+"
      L12 = nil
      L13 = true
      L9 = L9(L10, L11, L12, L13)
      L10 = #L9
      if L10 == 4 then
        L10 = {}
        L11 = L9[1]
        L10.name = L11
        L11 = L9[2]
        L10.id = L11
        L11 = L9[3]
        L11 = L11 == "yes"
        L10.stp = L11
        L11 = {}
        L12 = _UPVALUE3_
        L13 = L9[4]
        L12 = L12[L13]
        L11[1] = L12
        L10.ifnames = L11
        L10 = L3.ifnames
        L10 = L10[1]
        if L10 then
          L10 = L3.ifnames
          L10 = L10[1]
          L10.bridge = L3
        end
        L10 = _UPVALUE4_
        L11 = L9[1]
        L10[L11] = L3
      elseif L3 then
        L10 = L3.ifnames
        L11 = L3.ifnames
        L11 = #L11
        L11 = L11 + 1
        L12 = _UPVALUE3_
        L13 = L9[2]
        L12 = L12[L13]
        L10[L11] = L12
        L10 = L3.ifnames
        L11 = L3.ifnames
        L11 = #L11
        L10 = L10[L11]
        L10.bridge = L3
      end
    end
  end
  return L5
end
init = L29
function L29(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.save
  L4 = ...
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.load
  L4 = ...
  L2(L3, L4)
end
save = L29
function L29(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L4 = ...
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.load
  L4 = ...
  L2(L3, L4)
end
commit = L29
function L29(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.instanceof
  L3 = A1
  L4 = interface
  L2 = L2(L3, L4)
  if L2 then
    L3 = A1
    L2 = A1.name
    return L2(L3)
  else
    L2 = _UPVALUE0_
    L2 = L2.instanceof
    L3 = A1
    L4 = protocol
    L2 = L2(L3, L4)
    if L2 then
      L3 = A1
      L2 = A1.ifname
      return L2(L3)
    else
      L2 = _UPVALUE1_
      L3 = A1
      L2 = L2(L3)
      if L2 == "string" then
        L3 = A1
        L2 = A1.match
        L4 = "^[^:]+"
        return L2(L3, L4)
      end
    end
  end
end
ifnameof = L29
function L29(A0, A1, A2)
  local L3, L4, L5
  L3 = _UPVALUE0_
  L3 = L3[A1]
  if L3 then
    L4 = L3
    L5 = A2 or L5
    if not A2 then
      L5 = "__dummy__"
    end
    return L4(L5)
  end
end
get_protocol = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2, L3 = nil, nil
  for L7, L8 in L4, L5, L6 do
    L9 = #L1
    L9 = L9 + 1
    L10 = L8
    L11 = "__dummy__"
    L10 = L10(L11)
    L1[L9] = L10
  end
  return L1
end
get_protocols = L29
function L29(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.class
  L3 = protocol
  L2 = L2(L3)
  function L3(A0, A1)
    A0.sid = A1
  end
  L2.__init__ = L3
  function L3(A0)
    local L1
    L1 = _UPVALUE0_
    return L1
  end
  L2.proto = L3
  L3 = _UPVALUE1_
  L4 = _UPVALUE1_
  L4 = #L4
  L4 = L4 + 1
  L3[L4] = L2
  L3 = _UPVALUE1_
  L3[A1] = L2
  return L2
end
register_protocol = L29
function L29(A0, A1)
  local L2, L3
  L2 = IFACE_PATTERNS_VIRTUAL
  L3 = IFACE_PATTERNS_VIRTUAL
  L3 = #L3
  L3 = L3 + 1
  L2[L3] = A1
end
register_pattern_virtual = L29
function L29(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.access
  L2 = "/proc/net/ipv6_route"
  return L1(L2)
end
has_ipv6 = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L4 = A0
  L3 = A0.get_network
  L5 = A1
  L3 = L3(L4, L5)
  if A1 then
    L4 = #A1
    if 0 < L4 then
      L5 = A1
      L4 = A1.match
      L4 = L4(L5, L6)
      if L4 and not L3 then
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.section
        L9 = A2
        L4 = L4(L5, L6, L7, L8, L9)
        if L4 then
          L4 = network
          L5 = A1
          return L4(L5)
        end
    end
  end
  elseif L3 then
    L5 = L3
    L4 = L3.is_empty
    L4 = L4(L5)
    if L4 then
      if A2 then
        L4, L5 = nil, nil
        for L9, L10 in L6, L7, L8 do
          L12 = L3
          L11 = L3.set
          L13 = L9
          L14 = L10
          L11(L12, L13, L14)
        end
      end
      return L3
    end
  end
end
add_network = L29
function L29(A0, A1)
  local L2, L3, L4, L5
  if A1 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get
    L4 = "network"
    L5 = A1
    L2 = L2(L3, L4, L5)
    if L2 == "interface" then
      L2 = network
      L3 = A1
      return L2(L3)
    end
  end
end
get_network = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.foreach
  function L7(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L2 = A0[".name"]
    L3 = network
    L4 = A0[".name"]
    L3 = L3(L4)
    L1[L2] = L3
  end
  L3(L4, L5, L6, L7)
  L3 = nil
  for L7 in L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = L2[L7]
    L1[L8] = L9
  end
  return L1
end
get_networks = L29
function L29(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.delete
  L4 = "network"
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete_all
    L5 = "network"
    L6 = "alias"
    function L7(A0)
      local L1, L2
      L1 = A0.interface
      L2 = _UPVALUE0_
      L1 = L1 == L2
      return L1
    end
    L3(L4, L5, L6, L7)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete_all
    L5 = "network"
    L6 = "route"
    function L7(A0)
      local L1, L2
      L1 = A0.interface
      L2 = _UPVALUE0_
      L1 = L1 == L2
      return L1
    end
    L3(L4, L5, L6, L7)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete_all
    L5 = "network"
    L6 = "route6"
    function L7(A0)
      local L1, L2
      L1 = A0.interface
      L2 = _UPVALUE0_
      L1 = L1 == L2
      return L1
    end
    L3(L4, L5, L6, L7)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "wireless"
    L6 = "wifi-iface"
    function L7(A0)
      local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
      L2 = {}
      for L6 in L3, L4, L5 do
        L7 = _UPVALUE1_
        if L6 ~= L7 then
          L7 = #L2
          L7 = L7 + 1
          L2[L7] = L6
        end
      end
      if 0 < L3 then
        L6 = A0[".name"]
        L7 = "network"
        L8 = _UPVALUE3_
        L8 = L8.concat
        L9 = L2
        L10 = " "
        L8, L9, L10 = L8(L9, L10)
        L3(L4, L5, L6, L7, L8, L9, L10)
      else
        L6 = A0[".name"]
        L7 = "network"
        L3(L4, L5, L6, L7)
      end
    end
    L3(L4, L5, L6, L7)
  end
  return L2
end
del_network = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A2 then
    L4 = #A2
    if 0 < L4 then
      L5 = A2
      L4 = A2.match
      L6 = "^[a-zA-Z0-9_]+$"
      L4 = L4(L5, L6)
      if L4 then
        L5 = A0
        L4 = A0.get_network
        L6 = A2
        L4 = L4(L5, L6)
        if not L4 then
          L4 = _UPVALUE0_
          L5 = L4
          L4 = L4.section
          L6 = "network"
          L7 = "interface"
          L8 = A2
          L9 = _UPVALUE0_
          L10 = L9
          L9 = L9.get_all
          L11 = "network"
          L12 = A1
          L9, L10, L11, L12 = L9(L10, L11, L12)
          L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12)
          L3 = L4
          if L3 then
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.foreach
            L6 = "network"
            L7 = "alias"
            function L8(A0)
              local L1, L2, L3, L4, L5, L6
              L1 = A0.interface
              L2 = _UPVALUE0_
              if L1 == L2 then
                L1 = _UPVALUE1_
                L2 = L1
                L1 = L1.set
                L3 = "network"
                L4 = A0[".name"]
                L5 = "interface"
                L6 = _UPVALUE2_
                L1(L2, L3, L4, L5, L6)
              end
            end
            L4(L5, L6, L7, L8)
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.foreach
            L6 = "network"
            L7 = "route"
            function L8(A0)
              local L1, L2, L3, L4, L5, L6
              L1 = A0.interface
              L2 = _UPVALUE0_
              if L1 == L2 then
                L1 = _UPVALUE1_
                L2 = L1
                L1 = L1.set
                L3 = "network"
                L4 = A0[".name"]
                L5 = "interface"
                L6 = _UPVALUE2_
                L1(L2, L3, L4, L5, L6)
              end
            end
            L4(L5, L6, L7, L8)
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.foreach
            L6 = "network"
            L7 = "route6"
            function L8(A0)
              local L1, L2, L3, L4, L5, L6
              L1 = A0.interface
              L2 = _UPVALUE0_
              if L1 == L2 then
                L1 = _UPVALUE1_
                L2 = L1
                L1 = L1.set
                L3 = "network"
                L4 = A0[".name"]
                L5 = "interface"
                L6 = _UPVALUE2_
                L1(L2, L3, L4, L5, L6)
              end
            end
            L4(L5, L6, L7, L8)
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.foreach
            L6 = "wireless"
            L7 = "wifi-iface"
            function L8(A0)
              local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
              L2 = {}
              for L6 in L3, L4, L5 do
                L7 = _UPVALUE1_
                if L6 == L7 then
                  L7 = #L2
                  L7 = L7 + 1
                  L8 = _UPVALUE2_
                  L2[L7] = L8
                else
                  L7 = #L2
                  L7 = L7 + 1
                  L2[L7] = L6
                end
              end
              if 0 < L3 then
                L6 = A0[".name"]
                L7 = "network"
                L8 = _UPVALUE4_
                L8 = L8.concat
                L9 = L2
                L10 = " "
                L8, L9, L10 = L8(L9, L10)
                L3(L4, L5, L6, L7, L8, L9, L10)
              end
            end
            L4(L5, L6, L7, L8)
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.delete
            L6 = "network"
            L7 = A1
            L4(L5, L6, L7)
          end
        end
      end
    end
  end
  L4 = L3 or L4
  if not L3 then
    L4 = false
  end
  return L4
end
rename_network = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L4 = A0
  L3 = A0.get_network
  L5 = A1
  L3 = L3(L4, L5)
  if A1 then
    L4 = #A1
    if 0 < L4 then
      L5 = A1
      L4 = A1.match
      L4 = L4(L5, L6)
      if L4 and not L3 then
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.section
        L9 = A2
        L4 = L4(L5, L6, L7, L8, L9)
        if L4 then
          L4 = network
          L5 = A1
          return L4(L5)
        end
    end
  end
  elseif L3 then
    L5 = L3
    L4 = L3.is_empty
    L4 = L4(L5)
    if L4 then
      if A2 then
        L4, L5 = nil, nil
        for L9, L10 in L6, L7, L8 do
          L12 = L3
          L11 = L3.set
          L13 = L9
          L14 = L10
          L11(L12, L13, L14)
        end
      end
      return L3
    end
  end
end
add_device = L29
function L29(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.delete
  L4 = "network"
  L5 = A1
  return L2(L3, L4, L5)
end
del_device = L29
function L29(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2[A1]
  if not L2 then
    L2 = _wifi_iface
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  L2 = interface
  L3 = A1
  do return L2(L3) end
  goto lbl_28
  ::lbl_15::
  L2 = nil
  L3 = {}
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.foreach
  L6 = "wireless"
  L7 = "wifi-iface"
  function L8(A0)
    local L1, L2, L3, L4, L5
    L1 = A0.device
    if L1 then
      L1 = _UPVALUE0_
      L2 = A0.device
      L3 = _UPVALUE0_
      L4 = A0.device
      L3 = L3[L4]
      if L3 then
        L3 = _UPVALUE0_
        L4 = A0.device
        L3 = L3[L4]
        L3 = L3 + 1
        if L3 then
          goto lbl_18
        end
      end
      L3 = 1
      ::lbl_18::
      L1[L2] = L3
      L1 = A0[".name"]
      L2 = _UPVALUE1_
      if L1 == L2 then
        L1 = interface
        L2 = {}
        L3 = A0.device
        L4 = _UPVALUE0_
        L5 = A0.device
        L4 = L4[L5]
        L2[1] = L3
        L2[2] = L4
        L2 = "%s.network%d" % L2
        L1 = L1(L2)
        _UPVALUE2_ = L1
        L1 = false
        return L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  do return L2 end
  ::lbl_28::
end
get_interface = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = {}
  L6(L7, L8, L9, L10)
  for L9 in L6, L7, L8 do
    if not L10 then
      L11 = L9
      if not L10 then
        L11 = L9
        if not L10 then
          L11 = L9
          L4[L9] = L10
        end
      end
    end
  end
  L6(L7, L8, L9, L10)
  for L9 in L6, L7, L8 do
    L11 = L4[L9]
    L2[L10] = L11
  end
  L11 = "wifi-iface"
  function L12(A0)
    local L1, L2, L3, L4
    L1 = A0.device
    if L1 then
      L1 = _UPVALUE0_
      L2 = A0.device
      L3 = _UPVALUE0_
      L4 = A0.device
      L3 = L3[L4]
      if L3 then
        L3 = _UPVALUE0_
        L4 = A0.device
        L3 = L3[L4]
        L3 = L3 + 1
        if L3 then
          goto lbl_18
        end
      end
      L3 = 1
      ::lbl_18::
      L1[L2] = L3
      L1 = {}
      L2 = A0.device
      L3 = _UPVALUE0_
      L4 = A0.device
      L3 = L3[L4]
      L1[1] = L2
      L1[2] = L3
      L1 = "%s.network%d" % L1
      L2 = _UPVALUE1_
      L3 = interface
      L4 = L1
      L3 = L3(L4)
      L2[L1] = L3
    end
  end
  L8(L9, L10, L11, L12)
  for L11 in L8, L9, L10 do
    L12 = #L2
    L12 = L12 + 1
    L13 = L7[L11]
    L2[L12] = L13
  end
  return L2
end
get_interfaces = L29
function L29(A0, A1)
  local L2, L3
  L2 = _iface_ignore
  L3 = A1
  return L2(L3)
end
ignore_interface = L29
function L29(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "wireless"
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 == "wifi-device" then
    L2 = wifidev
    L3 = A1
    return L2(L3)
  end
end
get_wifidev = L29
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.foreach
  function L7(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L3 = A0[".name"]
    L1[L2] = L3
  end
  L3(L4, L5, L6, L7)
  L3 = nil
  for L7, L8 in L4, L5, L6 do
    L9 = #L1
    L9 = L9 + 1
    L10 = wifidev
    L11 = L8
    L10 = L10(L11)
    L1[L9] = L10
  end
  return L1
end
get_wifidevs = L29
function L29(A0, A1)
  local L2, L3, L4
  if nil == A1 then
    L2 = nil
    return L2
  end
  L2 = _wifi_lookup
  L3 = A1
  L2 = L2(L3)
  if L2 then
    L3 = wifinet
    L4 = L2
    return L3(L4)
  end
end
get_wifinet = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L4 = A2
  L3 = L3(L4)
  if L3 == "table" then
    L3 = A2.device
    if L3 then
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.get
      L5 = "wireless"
      L6 = A2.device
      L3 = L3(L4, L5, L6)
      if L3 == "wifi-device" then
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.section
        L5 = "wireless"
        L6 = "wifi-iface"
        L7 = nil
        L8 = A2
        L3 = L3(L4, L5, L6, L7, L8)
        L4 = wifinet
        L5 = L3
        return L4(L5)
      end
    end
  end
end
add_wifinet = L29
function L29(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _wifi_lookup
  L3 = A1
  L2 = L2(L3)
  if L2 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete
    L5 = "wireless"
    L6 = L2
    L3(L4, L5, L6)
    L3 = true
    return L3
  end
  L3 = false
  return L3
end
del_wifinet = L29
function L29(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L8, L9, L10, L11, L12, L16, L17, L18, L19 = L6(L7)
  for L8, L9 in L5, L6, L7 do
    L11 = L9
    L10 = L9.match
    L12 = "^network%.interface%.(.+)"
    L10 = L10(L11, L12)
    if L10 then
      L11 = _UPVALUE1_
      L12 = L11
      L11 = L11.call
      L11 = L11(L12, L13, L14, L15)
      if L11 then
        L12 = L11.route
        if L12 then
          L12 = nil
          for L16, L17 in L13, L14, L15 do
            L18 = L17.target
            if L18 == A1 then
              L18 = L17.mask
              if L18 == A2 then
                L18 = L10
                L19 = L11
                return L18, L19
              end
            end
          end
        end
      end
    end
  end
end
get_status_by_route = L29
function L29(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L7, L8, L9, L10, L11, L15, L16, L17, L18 = L5(L6)
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.match
    L11 = "^network%.interface%.(.+)"
    L9 = L9(L10, L11)
    if L9 then
      L10 = _UPVALUE1_
      L11 = L10
      L10 = L10.call
      L10 = L10(L11, L12, L13, L14)
      if L10 then
        L11 = L10["ipv4-address"]
        if L11 then
          L11 = nil
          for L15, L16 in L12, L13, L14 do
            L17 = L16.address
            if L17 == A1 then
              L17 = L9
              L18 = L10
              return L17, L18
            end
          end
        end
      end
      if L10 then
        L11 = L10["ipv6-address"]
        if L11 then
          L11 = nil
          for L15, L16 in L12, L13, L14 do
            L17 = L16.address
            if L17 == A1 then
              L17 = L9
              L18 = L10
              return L17, L18
            end
          end
        end
      end
    end
  end
end
get_status_by_address = L29
function L29(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.get_status_by_route
  L3 = "0.0.0.0"
  L4 = 0
  L1 = L1(L2, L3, L4)
  L2 = L1 or L2
  if L1 then
    L2 = network
    L3 = L1
    L2 = L2(L3)
  end
  return L2
end
get_wannet = L29
function L29(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.get_status_by_route
  L3 = "0.0.0.0"
  L4 = 0
  L1, L2 = L1(L2, L3, L4)
  L3 = L2 or L3
  if L2 then
    L3 = interface
    L4 = L2.l3_device
    L4 = L4 or L4
    L3 = L3(L4)
  end
  return L3
end
get_wandev = L29
function L29(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.get_status_by_route
  L3 = "::"
  L4 = 0
  L1 = L1(L2, L3, L4)
  L2 = L1 or L2
  if L1 then
    L2 = network
    L3 = L1
    L2 = L2(L3)
  end
  return L2
end
get_wan6net = L29
function L29(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.get_status_by_route
  L3 = "::"
  L4 = 0
  L1, L2 = L1(L2, L3, L4)
  L3 = L2 or L3
  if L2 then
    L3 = interface
    L4 = L2.l3_device
    L4 = L4 or L4
    L3 = L3(L4)
  end
  return L3
end
get_wan6dev = L29
function L29(A0, A1)
  local L2, L3, L4, L5, L6
  if A0 then
    L2 = A1 or L2
    if not A1 then
      L2 = _UPVALUE0_
      L3 = L2
      L2 = L2.get
      L4 = "network"
      L5 = A0
      L6 = "proto"
      L2 = L2(L3, L4, L5, L6)
    end
    if L2 then
      L3 = _UPVALUE1_
      L3 = L3[L2]
      if L3 then
        goto lbl_18
      end
    end
    L3 = protocol
    ::lbl_18::
    L4 = L3
    L5 = A0
    return L4(L5)
  end
end
network = L29
L29 = protocol
function L30(A0, A1)
  A0.sid = A1
end
L29.__init__ = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "network"
  L5 = A0.sid
  L6 = A1
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE1_
  L4 = L2
  L3 = L3(L4)
  if L3 == "table" then
    L3 = _UPVALUE2_
    L3 = L3.concat
    L4 = L2
    L5 = " "
    return L3(L4, L5)
  end
  L3 = L2 or L3
  if not L2 then
    L3 = ""
  end
  return L3
end
L29._get = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L3 = A0.sid
  L2 = L2[L3]
  if not L2 then
    L2 = _UPVALUE0_
    L3 = A0.sid
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.call
    L6 = A0.sid
    L6 = "network.interface.%s" % L6
    L7 = "status"
    L8 = {}
    L4 = L4(L5, L6, L7, L8)
    L2[L3] = L4
  end
  L2 = _UPVALUE0_
  L3 = A0.sid
  L2 = L2[L3]
  if L2 and A1 then
    L2 = _UPVALUE0_
    L3 = A0.sid
    L2 = L2[L3]
    L2 = L2[A1]
    return L2
  end
  L2 = _UPVALUE0_
  L3 = A0.sid
  L2 = L2[L3]
  return L2
end
L29._ubus = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "network"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L29.get = L30
L29 = protocol
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "network"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L29.set = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L3 = A0
  L2 = A0.is_floating
  L2 = L2(L3)
  if L2 then
    L3 = A0
    L2 = A0._ubus
    L4 = "l3_device"
    L2 = L2(L3, L4)
    L1 = L2
  else
    L3 = A0
    L2 = A0._ubus
    L4 = "device"
    L2 = L2(L3, L4)
    L1 = L2
  end
  if not L1 then
    L2 = {}
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "wireless"
    L6 = "wifi-iface"
    function L7(A0)
      local L1, L2, L3, L4, L5, L6, L7, L8, L9
      L1 = A0.device
      if L1 then
        L1 = _UPVALUE0_
        if L3 then
          if L3 then
            goto lbl_18
          end
        end
        ::lbl_18::
        L1[L2] = L3
        L1 = nil
        for L5 in L2, L3, L4 do
          L6 = _UPVALUE2_
          L6 = L6.sid
          if L5 == L6 then
            L6 = {}
            L7 = A0.device
            L8 = _UPVALUE0_
            L9 = A0.device
            L8 = L8[L9]
            L6[1] = L7
            L6[2] = L8
            L6 = "%s.network%d" % L6
            _UPVALUE3_ = L6
            L6 = false
            return L6
          end
        end
      end
    end
    L3(L4, L5, L6, L7)
  end
  return L1
end
L29.ifname = L30
L29 = protocol
function L30(A0)
  local L1
  L1 = "none"
  return L1
end
L29.proto = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.proto
  L1 = L1(L2)
  if L1 == "none" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Unmanaged"
    return L2(L3)
  elseif L1 == "static" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Static address"
    return L2(L3)
  elseif L1 == "dhcp" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "DHCP client"
    return L2(L3)
  else
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Unknown"
    return L2(L3)
  end
end
L29.get_i18n = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._get
  L3 = "type"
  return L1(L2, L3)
end
L29.type = L30
L29 = protocol
function L30(A0)
  local L1
  L1 = A0.sid
  return L1
end
L29.name = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "uptime"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  return L1
end
L29.uptime = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get
  L4 = "network"
  L5 = A0.sid
  L6 = "lease_acquired"
  L2, L3, L4, L5, L6, L7 = L2(L3, L4, L5, L6)
  L1 = L1(L2, L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.get
  L5 = "network"
  L6 = A0.sid
  L7 = "lease_lifetime"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  if L1 and L2 then
    L3 = _UPVALUE2_
    L3 = L3.sysinfo
    L3 = L3()
    L3 = L3.uptime
    L3 = L3 - L1
    L2 = L2 - L3
    L3 = L2 or L3
    if not (0 < L2) or not L2 then
      L3 = 0
    end
    return L3
  end
  L3 = -1
  return L3
end
L29.expires = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get
  L4 = "network"
  L5 = A0.sid
  L6 = "metric"
  L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
  L1 = L1(L2, L3, L4, L5, L6)
  L1 = L1 or L1
  return L1
end
L29.metric = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "ipv4-address"
  L1 = L1(L2, L3)
  L2 = L1 or L2
  if L1 then
    L2 = #L1
    L2 = L1[1]
    L2 = 0 < L2 and L2
  end
  return L2
end
L29.ipaddr = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "ipv4-address"
  L1 = L1(L2, L3)
  L2 = L1 or L2
  if L1 then
    L2 = #L1
    L2 = _UPVALUE0_
    L2 = L2.IPv4
    L3 = L1[1]
    L3 = L3.mask
    L3 = "0.0.0.0/%d" % L3
    L2 = L2(L3)
    L3 = L2
    L2 = L2.mask
    L2 = L2(L3)
    L3 = L2
    L2 = L2.string
    L2 = 0 < L2 and L2
  end
  return L2
end
L29.netmask = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L6 = "route"
  for L6, L7 in L3, L4, L5 do
    L8 = L7.target
    if L8 == "0.0.0.0" then
      L8 = L7.mask
      if L8 == 0 then
        L8 = L7.nexthop
        return L8
      end
    end
  end
end
L29.gwaddr = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2, L3 = nil, nil
  L7 = "dns-server"
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.match
    L11 = ":"
    L9 = L9(L10, L11)
    if not L9 then
      L9 = #L1
      L9 = L9 + 1
      L1[L9] = L8
    end
  end
  return L1
end
L29.dnsaddrs = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0._ubus
  L3 = "ipv6-address"
  L1 = L1(L2, L3)
  if L1 then
    L2 = #L1
    if 0 < L2 then
      L2 = {}
      L3 = L1[1]
      L3 = L3.address
      L4 = L1[1]
      L4 = L4.mask
      L2[1] = L3
      L2[2] = L4
      L2 = "%s/%d" % L2
      return L2
  end
  else
    L3 = A0
    L2 = A0._ubus
    L4 = "ipv6-prefix-assignment"
    L2 = L2(L3, L4)
    L1 = L2
    if L1 then
      L2 = #L1
      if 0 < L2 then
        L2 = {}
        L3 = L1[1]
        L3 = L3.address
        L4 = L1[1]
        L4 = L4.mask
        L2[1] = L3
        L2[2] = L4
        L2 = "%s/%d" % L2
        return L2
      end
    end
  end
end
L29.ip6addr = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L6 = "route"
  for L6, L7 in L3, L4, L5 do
    L8 = L7.target
    if L8 == "::" then
      L8 = L7.mask
      if L8 == 0 then
        L8 = _UPVALUE1_
        L8 = L8.IPv6
        L9 = L7.nexthop
        L8 = L8(L9)
        L9 = L8
        L8 = L8.string
        return L8(L9)
      end
    end
  end
end
L29.gw6addr = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2, L3 = nil, nil
  L7 = "dns-server"
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.match
    L11 = ":"
    L9 = L9(L10, L11)
    if L9 then
      L9 = #L1
      L9 = L9 + 1
      L1[L9] = L8
    end
  end
  return L1
end
L29.dns6addrs = L30
L29 = protocol
function L30(A0)
  local L1, L2
  L2 = A0
  L1 = A0.is_virtual
  L1 = L1(L2)
  L1 = not L1
  return L1
end
L29.is_bridge = L30
L29 = protocol
function L30(A0)
  local L1
  return L1
end
L29.opkg_package = L30
L29 = protocol
function L30(A0)
  local L1
  L1 = true
  return L1
end
L29.is_installed = L30
L29 = protocol
function L30(A0)
  local L1
  L1 = false
  return L1
end
L29.is_virtual = L30
L29 = protocol
function L30(A0)
  local L1
  L1 = false
  return L1
end
L29.is_floating = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L2 = A0
  L1 = A0.is_floating
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  else
    L1 = true
    L3 = A0
    L2 = A0._get
    L4 = "ifname"
    L2 = L2(L3, L4)
    L2 = L2 or L2
    L3 = L2
    L2 = L2.match
    L4 = "%S+"
    L2 = L2(L3, L4)
    if L2 then
      L1 = false
    end
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.foreach
    L4 = "wireless"
    L5 = "wifi-iface"
    function L6(A0)
      local L1, L2, L3, L4, L5, L6, L7
      for L5 in L2, L3, L4 do
        L6 = _UPVALUE1_
        L6 = L6.sid
        if L5 == L6 then
          L6 = false
          _UPVALUE2_ = L6
          L6 = false
          return L6
        end
      end
    end
    L2(L3, L4, L5, L6)
    return L1
  end
end
L29.is_empty = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _M
  L3 = L2
  L2 = L2.ifnameof
  L4 = A1
  L2 = L2(L3, L4)
  A1 = L2
  if A1 then
    L3 = A0
    L2 = A0.is_floating
    L2 = L2(L3)
    if not L2 then
      L2 = _wifi_lookup
      L3 = A1
      L2 = L2(L3)
      if L2 then
        L3 = _append
        L4 = "wireless"
        L5 = L2
        L6 = "network"
        L7 = A0.sid
        L3(L4, L5, L6, L7)
      else
        L3 = _append
        L4 = "network"
        L5 = A0.sid
        L6 = "ifname"
        L7 = A1
        L3(L4, L5, L6, L7)
      end
    end
  end
end
L29.add_interface = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _M
  L3 = L2
  L2 = L2.ifnameof
  L4 = A1
  L2 = L2(L3, L4)
  A1 = L2
  if A1 then
    L3 = A0
    L2 = A0.is_floating
    L2 = L2(L3)
    if not L2 then
      L2 = _wifi_lookup
      L3 = A1
      L2 = L2(L3)
      if L2 then
        L3 = _filter
        L4 = "wireless"
        L5 = L2
        L6 = "network"
        L7 = A0.sid
        L3(L4, L5, L6, L7)
      end
      L3 = _filter
      L4 = "network"
      L5 = A0.sid
      L6 = "ifname"
      L7 = A1
      L3(L4, L5, L6, L7)
    end
  end
end
L29.del_interface = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0
  L1 = A0.is_virtual
  L1 = L1(L2)
  if L1 then
    L1 = _UPVALUE0_
    L2 = A0.proto
    L2 = L2(L3)
    L2 = L2 .. L3 .. L4
    L1[L2] = true
    L1 = interface
    L2 = A0.proto
    L2 = L2(L3)
    L2 = L2 .. L3 .. L4
    return L1(L2, L3)
  else
    L2 = A0
    L1 = A0.is_bridge
    L1 = L1(L2)
    if L1 then
      L1 = _UPVALUE1_
      L2 = "br-"
      L2 = L2 .. L3
      L1[L2] = true
      L1 = interface
      L2 = "br-"
      L2 = L2 .. L3
      return L1(L2, L3)
    else
      L1 = nil
      L2 = {}
      L6 = "network"
      L7 = A0.sid
      L8 = "ifname"
      L6, L7, L8, L9 = L4(L5, L6, L7, L8)
      for L6 in L3, L4, L5 do
        L8 = L6
        L7 = L6.match
        L9 = "^[^:/]+"
        L7 = L7(L8, L9)
        L6 = L7
        L7 = L6 or L7
        if L6 then
          L7 = interface
          L8 = L6
          L9 = A0
          L7 = L7(L8, L9)
        end
        return L7
      end
      L1 = nil
      L6 = "wifi-iface"
      function L7(A0)
        local L1, L2, L3, L4, L5, L6, L7, L8, L9
        L1 = A0.device
        if L1 then
          L1 = _UPVALUE0_
          if L3 then
            if L3 then
              goto lbl_18
            end
          end
          ::lbl_18::
          L1[L2] = L3
          L1 = nil
          for L5 in L2, L3, L4 do
            L6 = _UPVALUE2_
            L6 = L6.sid
            if L5 == L6 then
              L6 = {}
              L7 = A0.device
              L8 = _UPVALUE0_
              L9 = A0.device
              L8 = L8[L9]
              L6[1] = L7
              L6[2] = L8
              L6 = "%s.network%d" % L6
              _UPVALUE3_ = L6
              L6 = false
              return L6
            end
          end
        end
      end
      L3(L4, L5, L6, L7)
      if L1 then
      end
      return L3
    end
  end
end
L29.get_interface = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = A0
  L1 = A0.is_bridge
  L1 = L1(L2)
  if not L1 then
    L2 = A0
    L1 = A0.is_virtual
    L1 = L1(L2)
    if not L1 then
      goto lbl_71
    end
    L2 = A0
    L1 = A0.is_floating
    L1 = L1(L2)
    if L1 then
      goto lbl_71
    end
  end
  L1 = {}
  L2 = nil
  L3 = {}
  L9, L10, L11 = L5(L6, L7)
  for L7 in L4, L5, L6 do
    L9 = L7
    L10 = "^[^:/]+"
    L9 = L7
    L10 = A0
    L3[L7] = L8
  end
  for L7 in L4, L5, L6 do
    L9 = L3[L7]
    L1[L8] = L9
  end
  L9 = "wifi-iface"
  function L10(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = A0.device
    if L1 then
      L1 = _UPVALUE0_
      if L3 then
        if L3 then
          goto lbl_18
        end
      end
      ::lbl_18::
      L1[L2] = L3
      L1 = nil
      for L5 in L2, L3, L4 do
        L6 = _UPVALUE2_
        L6 = L6.sid
        if L5 == L6 then
          L6 = {}
          L7 = A0.device
          L8 = _UPVALUE0_
          L9 = A0.device
          L8 = L8[L9]
          L6[1] = L7
          L6[2] = L8
          L6 = "%s.network%d" % L6
          _UPVALUE3_ = L6
          L6 = _UPVALUE4_
          L7 = _UPVALUE3_
          L8 = interface
          L9 = _UPVALUE3_
          L10 = _UPVALUE2_
          L8 = L8(L9, L10)
          L6[L7] = L8
        end
      end
    end
  end
  L6(L7, L8, L9, L10)
  for L9 in L6, L7, L8 do
    L10 = #L1
    L10 = L10 + 1
    L11 = L5[L9]
    L1[L10] = L11
  end
  do return L1 end
  ::lbl_71::
end
L29.get_interfaces = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _M
  L2 = L2.ifnameof
  L2 = L2(L3, L4)
  A1 = L2
  if not A1 then
    L2 = false
    return L2
  else
    L2 = A0.is_virtual
    L2 = L2(L3)
    if L2 then
      L2 = A0.proto
      L2 = L2(L3)
      L2 = L2 .. L3 .. L4
      if L2 == A1 then
        L2 = true
        return L2
    end
    else
      L2 = A0.is_bridge
      L2 = L2(L3)
      if L2 then
        L2 = "br-"
        L2 = L2 .. L3
        if L2 == A1 then
          L2 = true
          return L2
      end
      else
        L2 = nil
        L8, L9, L10 = L4(L5, L6)
        for L6 in L3, L4, L5 do
          L8 = L6
          L9 = "[^:]+"
          if L6 == A1 then
            return L7
          end
        end
        if L3 then
          L8 = "wireless"
          L9 = L3
          L10 = "network"
          L8, L9, L10 = L6(L7, L8, L9, L10)
          for L8 in L5, L6, L7 do
            L9 = A0.sid
            if L8 == L9 then
              L9 = true
              return L9
            end
          end
        end
      end
    end
  end
  L2 = false
  return L2
end
L29.contains_interface = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.build_url
  L2 = "admin"
  L3 = "network"
  L4 = "network"
  L5 = A0.sid
  return L1(L2, L3, L4, L5)
end
L29.adminlink = L30
L29 = protocol
function L30(A0, A1)
  local L2, L3, L4
  L3 = A0
  L2 = A0._get
  L4 = A1
  return L2(L3, L4)
end
L29.get_option_value = L30
L29 = protocol
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.cursor_state
  L1 = L1()
  L2 = L1
  L1 = L1.get_all
  L3 = "network"
  L4 = A0.sid
  L1 = L1(L2, L3, L4)
  L2 = L1.proto
  L3 = L1.ifname
  L4 = L1.device
  L5 = _UPVALUE1_
  L6 = L1.up
  L5 = L5(L6)
  if L2 == "pppoe" then
    if L4 == nil then
      L6 = "down"
      return L6
    end
    if L5 == nil then
      L6 = "connection"
      return L6
    end
    if L5 == 1 then
      L6 = "up"
      return L6
    end
  elseif L2 == "3g" then
    if L4 ~= L3 and L5 == nil then
      L6 = "down"
      return L6
    end
    if L4 == L3 and L5 == nil then
      L6 = "connection"
      return L6
    end
    if L5 == 1 then
      L6 = "up"
      return L6
    end
  elseif L2 == "static" then
    if L5 == nil then
      L6 = "down"
      return L6
    end
    if L5 == 1 then
      L6 = "up"
      return L6
    end
  elseif L2 == "dhcp" then
    if L5 == nil then
      L6 = "down"
      return L6
    end
    if L5 == 1 then
      L6 = "up"
      return L6
    end
  end
  L6 = "unkown"
  return L6
end
L29.status = L30
L29 = L15.class
L29 = L29()
interface = L29
L29 = interface
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _wifi_lookup
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L4 = wifinet
    L5 = L3
    L4 = L4(L5)
    A0.wif = L4
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = "wireless"
    L7 = L3
    L8 = "ifname"
    L4 = L4(L5, L6, L7, L8)
    A0.ifname = L4
  end
  L4 = A0.ifname
  L4 = L4 or L4
  A0.ifname = L4
  L4 = _UPVALUE1_
  L5 = A0.ifname
  L4 = L4[L5]
  A0.dev = L4
  A0.network = A2
end
L29.__init__ = L30
L29 = interface
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L3 = A0.ifname
  L2 = L2[L3]
  if not L2 then
    L2 = _UPVALUE0_
    L3 = A0.ifname
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.call
    L6 = "network.device"
    L7 = "status"
    L8 = {}
    L9 = A0.ifname
    L8.name = L9
    L4 = L4(L5, L6, L7, L8)
    L2[L3] = L4
  end
  L2 = _UPVALUE0_
  L3 = A0.ifname
  L2 = L2[L3]
  if L2 and A1 then
    L2 = _UPVALUE0_
    L3 = A0.ifname
    L2 = L2[L3]
    L2 = L2[A1]
    return L2
  end
  L2 = _UPVALUE0_
  L3 = A0.ifname
  L2 = L2[L3]
  return L2
end
L29._ubus = L30
L29 = interface
function L30(A0)
  local L1, L2
  L1 = A0.wif
  if L1 then
    L1 = A0.wif
    L2 = L1
    L1 = L1.ifname
    L1 = L1(L2)
    if L1 then
      goto lbl_10
    end
  end
  L1 = A0.ifname
  ::lbl_10::
  return L1
end
L29.name = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "macaddr"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  L2 = L1
  L1 = L1.upper
  return L1(L2)
end
L29.mac = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.dev
  if L1 then
    L1 = A0.dev
    L1 = L1.ipaddrs
    if L1 then
      goto lbl_9
    end
  end
  L1 = {}
  ::lbl_9::
  return L1
end
L29.ipaddrs = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.dev
  if L1 then
    L1 = A0.dev
    L1 = L1.ip6addrs
    if L1 then
      goto lbl_9
    end
  end
  L1 = {}
  ::lbl_9::
  return L1
end
L29.ip6addrs = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L1 = A0.wif
  if not L1 then
    L1 = _wifi_iface
    L2 = A0.ifname
    L1 = L1(L2)
    if not L1 then
      goto lbl_12
    end
  end
  L1 = "wifi"
  do return L1 end
  goto lbl_47
  ::lbl_12::
  L1 = _UPVALUE0_
  L2 = A0.ifname
  L1 = L1[L2]
  if L1 then
    L1 = "bridge"
    return L1
  else
    L1 = _UPVALUE1_
    L2 = A0.ifname
    L1 = L1[L2]
    if L1 then
      L1 = "tunnel"
      return L1
    else
      L1 = A0.ifname
      L2 = L1
      L1 = L1.match
      L3 = "%."
      L1 = L1(L2, L3)
      if L1 then
        L1 = "vlan"
        return L1
      else
        L1 = _UPVALUE2_
        L2 = A0.ifname
        L1 = L1[L2]
        if L1 then
          L1 = "switch"
          return L1
        else
          L1 = "ethernet"
          return L1
        end
      end
    end
  end
  ::lbl_47::
end
L29.type = L30
L29 = interface
function L30(A0)
  local L1, L2, L3, L4
  L1 = A0.wif
  if L1 then
    L1 = {}
    L2 = A0.wif
    L3 = L2
    L2 = L2.active_mode
    L2 = L2(L3)
    L3 = A0.wif
    L4 = L3
    L3 = L3.active_ssid
    L3 = L3(L4)
    if not L3 then
      L3 = A0.wif
      L4 = L3
      L3 = L3.active_bssid
      L3 = L3(L4)
    end
    L1[1] = L2
    L1[2] = L3
    L1 = "%s %q" % L1
    return L1
  else
    L1 = A0.ifname
    return L1
  end
end
L29.shortname = L30
L29 = interface
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = A0.wif
  if L1 then
    L1 = {}
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Wireless Network"
    L2 = L2(L3)
    L3 = A0.wif
    L4 = L3
    L3 = L3.active_mode
    L3 = L3(L4)
    L4 = A0.wif
    L5 = L4
    L4 = L4.active_ssid
    L4 = L4(L5)
    if not L4 then
      L4 = A0.wif
      L5 = L4
      L4 = L4.active_bssid
      L4 = L4(L5)
    end
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1 = "%s: %s %q" % L1
    return L1
  else
    L1 = {}
    L3 = A0
    L2 = A0.get_type_i18n
    L2 = L2(L3)
    L4 = A0
    L3 = A0.name
    L3, L4, L5 = L3(L4)
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L1 = "%s: %q" % L1
    return L1
  end
end
L29.get_i18n = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.type
  L1 = L1(L2)
  if L1 == "wifi" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Wireless Adapter"
    return L2(L3)
  elseif L1 == "bridge" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Bridge"
    return L2(L3)
  elseif L1 == "switch" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Ethernet Switch"
    return L2(L3)
  elseif L1 == "vlan" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "VLAN Interface"
    return L2(L3)
  elseif L1 == "tunnel" then
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Tunnel Interface"
    return L2(L3)
  else
    L2 = _UPVALUE0_
    L2 = L2.translate
    L3 = "Ethernet Adapter"
    return L2(L3)
  end
end
L29.get_type_i18n = L30
L29 = interface
function L30(A0)
  local L1, L2
  L1 = A0.wif
  if L1 then
    L1 = A0.wif
    L2 = L1
    L1 = L1.adminlink
    return L1(L2)
  end
end
L29.adminlink = L30
L29 = interface
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = A0
  L1 = A0._ubus
  L3 = "bridge-members"
  L1 = L1(L2, L3)
  if L1 then
    L2, L3 = nil, nil
    L4 = {}
    for L8, L9 in L5, L6, L7 do
      L10 = #L4
      L10 = L10 + 1
      L11 = interface
      L12 = L9
      L11 = L11(L12)
      L4[L10] = L11
    end
  end
end
L29.ports = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.br
  if L1 then
    L1 = A0.br
    L1 = L1.id
    return L1
  else
    L1 = nil
    return L1
  end
end
L29.bridge_id = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.br
  if L1 then
    L1 = A0.br
    L1 = L1.stp
    return L1
  else
    L1 = false
    return L1
  end
end
L29.bridge_stp = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L1 = A0.wif
  if L1 then
    L1 = A0.wif
    L2 = L1
    L1 = L1.is_up
    return L1(L2)
  else
    L2 = A0
    L1 = A0._ubus
    L3 = "up"
    L1 = L1(L2, L3)
    L1 = L1 or L1
    return L1
  end
end
L29.is_up = L30
L29 = interface
function L30(A0)
  local L1, L2
  L2 = A0
  L1 = A0.type
  L1 = L1(L2)
  L1 = L1 == "bridge"
  return L1
end
L29.is_bridge = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.dev
  if L1 then
    L1 = A0.dev
    L1 = L1.bridge
    if L1 then
      L1 = true
      if L1 then
        goto lbl_12
      end
    end
  end
  L1 = false
  ::lbl_12::
  return L1
end
L29.is_bridgeport = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "statistics"
  L1 = L1(L2, L3)
  if L1 then
    L2 = L1.tx_bytes
    if L2 then
      goto lbl_10
    end
  end
  L2 = 0
  ::lbl_10::
  return L2
end
L29.tx_bytes = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "statistics"
  L1 = L1(L2, L3)
  if L1 then
    L2 = L1.rx_bytes
    if L2 then
      goto lbl_10
    end
  end
  L2 = 0
  ::lbl_10::
  return L2
end
L29.rx_bytes = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "statistics"
  L1 = L1(L2, L3)
  if L1 then
    L2 = L1.tx_packets
    if L2 then
      goto lbl_10
    end
  end
  L2 = 0
  ::lbl_10::
  return L2
end
L29.tx_packets = L30
L29 = interface
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0._ubus
  L3 = "statistics"
  L1 = L1(L2, L3)
  if L1 then
    L2 = L1.rx_packets
    if L2 then
      goto lbl_10
    end
  end
  L2 = 0
  ::lbl_10::
  return L2
end
L29.rx_packets = L30
L29 = interface
function L30(A0)
  local L1, L2
  L2 = A0
  L1 = A0.get_networks
  L1 = L1(L2)
  L1 = L1[1]
  return L1
end
L29.get_network = L30
L29 = interface
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = A0.networks
  if not L1 then
    L1 = {}
    L2, L3 = nil, nil
    L7, L8, L9, L10, L11 = L5(L6)
    for L7, L8 in L4, L5, L6 do
      L10 = L8
      L9 = L8.contains_interface
      L11 = A0.ifname
      L9 = L9(L10, L11)
      if not L9 then
        L10 = L8
        L9 = L8.ifname
        L9 = L9(L10)
        L10 = A0.ifname
        if L9 ~= L10 then
          goto lbl_25
        end
      end
      L9 = #L1
      L9 = L9 + 1
      L1[L9] = L8
      ::lbl_25::
    end
    L4(L5, L6)
    A0.networks = L1
    return L1
  else
    L1 = A0.networks
    return L1
  end
end
L29.get_networks = L30
L29 = interface
function L30(A0)
  local L1
  L1 = A0.wif
  return L1
end
L29.get_wifinet = L30
L29 = L15.class
L29 = L29()
wifidev = L29
L29 = wifidev
function L30(A0, A1)
  local L2, L3
  A0.sid = A1
  if A1 then
    L2 = _UPVALUE0_
    L2 = L2.wifi
    L2 = L2.getiwinfo
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_12
    end
  end
  L2 = {}
  ::lbl_12::
  A0.iwinfo = L2
end
L29.__init__ = L30
L29 = wifidev
function L30(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "wireless"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L29.get = L30
L29 = wifidev
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "wireless"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L29.set = L30
L29 = wifidev
function L30(A0)
  local L1
  L1 = A0.sid
  return L1
end
L29.name = L30
L29 = wifidev
function L30(A0)
  local L1, L2, L3
  L1 = A0.iwinfo
  L1 = L1.hwmodelist
  if L1 then
    L2 = _UPVALUE0_
    L3 = L1
    L2 = L2(L3)
    if L2 then
      return L1
  end
  else
    L2 = {}
    L2.b = true
    L2.g = true
    return L2
  end
end
L29.hwmodes = L30
L29 = wifidev
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = "Generic"
  L2 = A0.iwinfo
  L2 = L2.type
  if L2 == "wl" then
    L1 = "Broadcom"
  else
    L2 = A0.iwinfo
    L2 = L2.type
    if L2 == "madwifi" then
      L1 = "Atheros"
    end
  end
  L2 = ""
  L4 = A0
  L3 = A0.hwmodes
  L3 = L3(L4)
  L4 = L3.a
  if L4 then
    L4 = L2
    L5 = "a"
    L2 = L4 .. L5
  end
  L4 = L3.b
  if L4 then
    L4 = L2
    L5 = "b"
    L2 = L4 .. L5
  end
  L4 = L3.g
  if L4 then
    L4 = L2
    L5 = "g"
    L2 = L4 .. L5
  end
  L4 = L3.n
  if L4 then
    L4 = L2
    L5 = "n"
    L2 = L4 .. L5
  end
  L4 = {}
  L5 = L1
  L6 = L2
  L8 = A0
  L7 = A0.name
  L7, L8 = L7(L8)
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4 = "%s 802.11%s Wireless Controller (%s)" % L4
  return L4
end
L29.get_i18n = L30
L29 = wifidev
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = false
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = "wireless"
  L5 = "wifi-iface"
  function L6(A0)
    local L1, L2
    L1 = A0.device
    L2 = _UPVALUE0_
    L2 = L2.sid
    if L1 == L2 then
      L1 = A0.up
      if L1 == "1" then
        L1 = true
        _UPVALUE1_ = L1
        L1 = false
        return L1
      end
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
L29.is_up = L30
L29 = wifidev
function L30(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "wireless"
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 == "wifi-iface" then
    L2 = wifinet
    L3 = A1
    return L2(L3)
  else
    L2 = _wifi_lookup
    L3 = A1
    L2 = L2(L3)
    if L2 then
      L3 = wifinet
      L4 = L2
      return L3(L4)
    end
  end
end
L29.get_wifinet = L30
L29 = wifidev
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = "wireless"
  L5 = "wifi-iface"
  function L6(A0)
    local L1, L2, L3, L4
    L1 = A0.device
    L2 = _UPVALUE0_
    L2 = L2.sid
    if L1 == L2 then
      L1 = _UPVALUE1_
      L2 = _UPVALUE1_
      L2 = #L2
      L2 = L2 + 1
      L3 = wifinet
      L4 = A0[".name"]
      L3 = L3(L4)
      L1[L2] = L3
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
L29.get_wifinets = L30
L29 = wifidev
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if not A1 then
    L2 = {}
    A1 = L2
  end
  L2 = A0.sid
  A1.device = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.section
  L4 = "wireless"
  L5 = "wifi-iface"
  L6 = nil
  L7 = A1
  L2 = L2(L3, L4, L5, L6, L7)
  if L2 then
    L3 = wifinet
    L4 = L2
    L5 = A1
    return L3(L4, L5)
  end
end
L29.add_wifinet = L30
L29 = wifidev
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  if not A2 then
    L3 = {}
    A2 = L3
  end
  L3 = A0.sid
  A2.device = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.section
  L5 = "wireless"
  L6 = "wifi-iface"
  L7 = A1
  L8 = A2
  L3 = L3(L4, L5, L6, L7, L8)
  if L3 then
    L4 = wifinet
    L5 = L3
    L6 = A2
    return L4(L5, L6)
  end
end
L29.add_wifinet_s = L30
L29 = wifidev
function L30(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.instanceof
  L3 = A1
  L4 = wifinet
  L2 = L2(L3, L4)
  if L2 then
    A1 = A1.sid
  else
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "wireless"
    L5 = A1
    L2 = L2(L3, L4, L5)
    if L2 ~= "wifi-iface" then
      L2 = _wifi_lookup
      L3 = A1
      L2 = L2(L3)
      A1 = L2
    end
  end
  if A1 then
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "wireless"
    L5 = A1
    L6 = "device"
    L2 = L2(L3, L4, L5, L6)
    L3 = A0.sid
    if L2 == L3 then
      L2 = _UPVALUE1_
      L3 = L2
      L2 = L2.delete
      L4 = "wireless"
      L5 = A1
      L2(L3, L4, L5)
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
L29.del_wifinet = L30
L29 = L15.class
L29 = L29()
wifinet = L29
L29 = wifinet
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  A0.sid = A1
  L3 = {}
  L4 = nil
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.foreach
  L7 = "wireless"
  L8 = "wifi-iface"
  function L9(A0)
    local L1, L2, L3, L4
    L1 = A0.device
    if L1 then
      L1 = _UPVALUE0_
      L2 = A0.device
      L3 = _UPVALUE0_
      L4 = A0.device
      L3 = L3[L4]
      if L3 then
        L3 = _UPVALUE0_
        L4 = A0.device
        L3 = L3[L4]
        L3 = L3 + 1
        if L3 then
          goto lbl_18
        end
      end
      L3 = 1
      ::lbl_18::
      L1[L2] = L3
      L1 = A0[".name"]
      L2 = _UPVALUE1_
      L2 = L2.sid
      if L1 == L2 then
        L1 = {}
        L2 = A0.device
        L3 = _UPVALUE0_
        L4 = A0.device
        L3 = L3[L4]
        L1[1] = L2
        L1[2] = L3
        L1 = "%s.network%d" % L1
        _UPVALUE2_ = L1
        L1 = false
        return L1
      end
    end
  end
  L5(L6, L7, L8, L9)
  L5 = _UPVALUE1_
  L6 = L5
  L5 = L5.get
  L7 = "wireless"
  L8 = A0.sid
  L9 = "ifname"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  A0.netid = L4
  A0.wdev = L5
  if L5 then
    L6 = _UPVALUE2_
    L6 = L6.wifi
    L6 = L6.getiwinfo
    L7 = L5
    L6 = L6(L7)
    if L6 then
      goto lbl_34
    end
  end
  L6 = {}
  ::lbl_34::
  A0.iwinfo = L6
  L6 = A2 or L6
  if not A2 then
    L6 = _UPVALUE1_
    L7 = L6
    L6 = L6.get_all
    L8 = "wireless"
    L9 = A0.sid
    L6 = L6(L7, L8, L9)
    if not L6 then
      L6 = _UPVALUE0_
      L7 = L6
      L6 = L6.get_all
      L8 = "wireless"
      L9 = A0.sid
      L6 = L6(L7, L8, L9)
      L6 = L6 or L6
    end
  end
  A0.iwdata = L6
end
L29.__init__ = L30
L29 = wifinet
function L30(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "wireless"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L29.get = L30
L29 = wifinet
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "wireless"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L29.set = L30
L29 = wifinet
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  if A2 then
    L3 = _UPVALUE0_
    L4 = A2
    L3 = L3(L4)
    if L3 == "table" then
      L3 = #A2
      if 0 < L3 then
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.set_list
        L5 = "wireless"
        L6 = A0.sid
        L7 = A1
        L8 = A2
        return L3(L4, L5, L6, L7, L8)
    end
  end
  else
    L3 = _UPVALUE1_
    L4 = L3
    L3 = L3.delete
    L5 = "wireless"
    L6 = A0.sid
    L7 = A1
    return L3(L4, L5, L6, L7)
  end
end
L29.set_list = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L4 = A0.sid
  L5 = "mode"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
L29.mode = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L4 = A0.sid
  L5 = "disabled"
  return L1(L2, L3, L4, L5)
end
L29.disabled = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L4 = A0.sid
  L5 = "ssid"
  return L1(L2, L3, L4, L5)
end
L29.ssid = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L4 = A0.sid
  L5 = "bssid"
  return L1(L2, L3, L4, L5)
end
L29.bssid = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wifinet"
  L4 = A0.sid
  L5 = "network"
  return L1(L2, L3, L4, L5)
end
L29.network = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.netid
  return L1
end
L29.id = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.sid
  return L1
end
L29.name = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4
  L1 = A0.iwinfo
  L1 = L1.ifname
  if L1 then
    L3 = L1
    L2 = L1.match
    L4 = "^wifi%d"
    L2 = L2(L3, L4)
    if not L2 then
      L3 = L1
      L2 = L1.match
      L4 = "^radio%d"
      L2 = L2(L3, L4)
      if not L2 then
        goto lbl_16
      end
    end
  end
  L1 = A0.wdev
  ::lbl_16::
  return L1
end
L29.ifname = L30
L29 = wifinet
function L30(A0)
  local L1, L2
  L1 = A0.iwdata
  L1 = L1.device
  if L1 then
    L1 = wifidev
    L2 = A0.iwdata
    L2 = L2.device
    return L1(L2)
  end
end
L29.get_device = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwdata
  L1 = L1.up
  L1 = L1 == "1"
  return L1
end
L29.is_up = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = _stror
  L2 = A0.iwinfo
  L2 = L2.mode
  L3 = A0.iwdata
  L3 = L3.mode
  L1 = L1(L2, L3)
  L1 = L1 or L1
  if L1 == "ap" then
    L1 = "Master"
  elseif L1 == "sta" then
    L1 = "Client"
  elseif L1 == "adhoc" then
    L1 = "Ad-Hoc"
  elseif L1 == "mesh" then
    L1 = "Mesh"
  elseif L1 == "monitor" then
    L1 = "Monitor"
  end
  return L1
end
L29.active_mode = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.translate
  L3 = A0
  L2 = A0.active_mode
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L29.active_mode_i18n = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = _stror
  L2 = A0.iwinfo
  L2 = L2.ssid
  L3 = A0.iwdata
  L3 = L3.ssid
  return L1(L2, L3)
end
L29.active_ssid = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = _stror
  L2 = A0.iwinfo
  L2 = L2.bssid
  L3 = A0.iwdata
  L3 = L3.bssid
  L1 = L1(L2, L3)
  L1 = L1 or L1
  return L1
end
L29.active_bssid = L30
L29 = wifinet
function L30(A0)
  local L1, L2
  L1 = A0.iwinfo
  if L1 then
    L1 = A0.iwinfo
    L1 = L1.encryption
  end
  if L1 then
    L2 = L1.description
    if L2 then
      goto lbl_12
    end
  end
  L2 = "-"
  ::lbl_12::
  return L2
end
L29.active_encryption = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.assoclist
  L1 = L1 or L1
  return L1
end
L29.assoclist = L30
L29 = wifinet
function L30(A0)
  local L1, L2
  L1 = A0.iwinfo
  L1 = L1.frequency
  if L1 and 0 < L1 then
    L2 = L1 / 1000
    L2 = "%.03f" % L2
    return L2
  end
end
L29.frequency = L30
L29 = wifinet
function L30(A0)
  local L1, L2
  L1 = A0.iwinfo
  L1 = L1.bitrate
  if L1 and 0 < L1 then
    L2 = L1 / 1000
    return L2
  end
end
L29.bitrate = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = A0.iwinfo
  L1 = L1.channel
  if not L1 then
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "wireless"
    L5 = A0.iwdata
    L5 = L5.device
    L6 = "channel"
    L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
    L1 = L1(L2, L3, L4, L5, L6)
  end
  return L1
end
L29.channel = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get
  L4 = "wireless"
  L5 = A0.iwdata
  L5 = L5.device
  L6 = "channel"
  L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
  return L1(L2, L3, L4, L5, L6)
end
L29.confchannel = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = A0.iwinfo
  L1 = L1.bw
  if not L1 then
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "wireless"
    L5 = A0.iwdata
    L5 = L5.device
    L6 = "bw"
    L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
    L1 = L1(L2, L3, L4, L5, L6)
  end
  return L1
end
L29.bw = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get
  L4 = "wireless"
  L5 = A0.iwdata
  L5 = L5.device
  L6 = "bw"
  L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
  return L1(L2, L3, L4, L5, L6)
end
L29.confbw = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = A0.iwinfo
  L1 = L1.txpwr
  if not L1 then
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "wireless"
    L5 = A0.iwdata
    L5 = L5.device
    L6 = "txpwr"
    L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
    L1 = L1(L2, L3, L4, L5, L6)
  end
  return L1
end
L29.txpwr = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.signal
  L1 = L1 or L1
  return L1
end
L29.signal = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.noise
  L1 = L1 or L1
  return L1
end
L29.noise = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.country
  L1 = L1 or L1
  return L1
end
L29.country = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.scanlist
  L1 = L1 or L1
  return L1
end
L29.scanlist = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = A0.iwinfo
  L1 = L1.txpower
  L1 = L1 or L1
  L3 = A0
  L2 = A0.txpower_offset
  L2 = L2(L3)
  L2 = L1 + L2
  return L2
end
L29.txpower = L30
L29 = wifinet
function L30(A0)
  local L1
  L1 = A0.iwinfo
  L1 = L1.txpower_offset
  L1 = L1 or L1
  return L1
end
L29.txpower_offset = L30
L29 = wifinet
function L30(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L4 = A0
  L3 = A0.active_bssid
  L3 = L3(L4)
  if L3 ~= "00:00:00:00:00:00" then
    L3 = A1 or L3
    if not A1 then
      L4 = A0
      L3 = A0.signal
      L3 = L3(L4)
    end
    L4 = A2 or L4
    if not A2 then
      L5 = A0
      L4 = A0.noise
      L4 = L4(L5)
    end
    if L3 < 0 and L4 < 0 then
      L5 = L4 - L3
      L5 = -1 * L5
      L6 = _UPVALUE0_
      L6 = L6.floor
      L7 = L5 / 5
      return L6(L7)
    else
      L5 = 0
      return L5
    end
  else
    L3 = -1
    return L3
  end
end
L29.signal_level = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4
  L1 = A0.iwinfo
  L1 = L1.quality
  L1 = L1 or L1
  L2 = A0.iwinfo
  L2 = L2.quality_max
  L2 = L2 or L2
  if 0 < L1 and 0 < L2 then
    L3 = _UPVALUE0_
    L3 = L3.floor
    L4 = 100 / L2
    L4 = L4 * L1
    return L3(L4)
  else
    L3 = 0
    return L3
  end
end
L29.signal_percent = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.translate
  L4 = A0
  L3 = A0.active_mode
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L4 = A0
  L3 = A0.active_ssid
  L3 = L3(L4)
  if not L3 then
    L4 = A0
    L3 = A0.active_bssid
    L3 = L3(L4)
  end
  L1[1] = L2
  L1[2] = L3
  L1 = "%s %q" % L1
  return L1
end
L29.shortname = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.translate
  L3 = "Wireless Network"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.translate
  L5 = A0
  L4 = A0.active_mode
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  L5 = A0
  L4 = A0.active_ssid
  L4 = L4(L5)
  if not L4 then
    L5 = A0
    L4 = A0.active_bssid
    L4 = L4(L5)
  end
  L6 = A0
  L5 = A0.ifname
  L5, L6 = L5(L6)
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  L1 = "%s: %s %q (%s)" % L1
  return L1
end
L29.get_i18n = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.build_url
  L2 = "admin"
  L3 = "network"
  L4 = "wireless"
  L5 = A0.netid
  return L1(L2, L3, L4, L5)
end
L29.adminlink = L30
L29 = wifinet
function L30(A0)
  local L1, L2
  L2 = A0
  L1 = A0.get_networks
  L1 = L1(L2)
  L1 = L1[1]
  return L1
end
L29.get_network = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  L2 = nil
  L6, L7, L8, L9, L10 = L4(L5)
  for L6 in L3, L4, L5 do
    L7 = _UPVALUE2_
    L8 = L7
    L7 = L7.get
    L9 = "network"
    L10 = L6
    L7 = L7(L8, L9, L10)
    if L7 == "interface" then
      L7 = #L1
      L7 = L7 + 1
      L8 = network
      L9 = L6
      L8 = L8(L9)
      L1[L7] = L8
    end
  end
  L3(L4, L5)
  return L1
end
L29.get_networks = L30
L29 = wifinet
function L30(A0)
  local L1, L2, L3
  L1 = interface
  L3 = A0
  L2 = A0.ifname
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L29.get_interface = L30
L29 = _M
L30 = L29
L29 = L29.register_protocol
L29(L30, L31)
L29 = _M
L30 = L29
L29 = L29.register_protocol
L29(L30, L31)
L29 = _M
L30 = L29
L29 = L29.register_protocol
L29(L30, L31)
L29 = L12.dir
L30 = L15.libpath
L30 = L30()
L30 = L30 .. L31
L29 = L29(L30)
if L29 then
  L30 = nil
  for L34 in L31, L32, L33 do
    L36 = L34
    L35 = L34.match
    L37 = "%.lua$"
    L35 = L35(L36, L37)
    if L35 then
      L35 = L9
      L36 = "luci.model.network."
      L38 = L34
      L37 = L34.gsub
      L39 = "%.lua$"
      L40 = ""
      L37 = L37(L38, L39, L40)
      L36 = L36 .. L37
      L35(L36)
    end
  end
end
