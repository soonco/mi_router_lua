local L0, L1, L2, L3, L4, L5
L0 = {}
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L0.util = L1
L1 = require
L2 = "luci.sys"
L1 = L1(L2)
L0.sys = L1
L1 = require
L2 = "luci.ip"
L1 = L1(L2)
L0.ip = L1
L1 = tonumber
L2 = ipairs
L3 = table
L4 = module
L5 = "luci.sys.iptparser"
L4(L5)
L4 = L0.util
L4 = L4.class
L4 = L4()
IptParser = L4
L4 = IptParser
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = A1
  L2 = L2(L3)
  if L2 == 6 then
    L2 = 6
    if L2 then
      goto lbl_10
    end
  end
  L2 = 4
  ::lbl_10::
  A0._family = L2
  L2 = {}
  A0._rules = L2
  L2 = {}
  A0._chains = L2
  L2 = A0._family
  if L2 == 4 then
    A0._nulladdr = "0.0.0.0/0"
    L2 = {}
    L3 = "filter"
    L4 = "nat"
    L5 = "mangle"
    L6 = "raw"
    L2[1] = L3
    L2[2] = L4
    L2[3] = L5
    L2[4] = L6
    A0._tables = L2
    A0._command = "iptables -t %s --line-numbers -nxvL"
  else
    A0._nulladdr = "::/0"
    L2 = {}
    L3 = "filter"
    L4 = "mangle"
    L5 = "raw"
    L2[1] = L3
    L2[2] = L4
    L2[3] = L5
    A0._tables = L2
    A0._command = "ip6tables -t %s --line-numbers -nxvL"
  end
  L3 = A0
  L2 = A0._parse_rules
  L2(L3)
end
L4.__init__ = L5
L4 = IptParser
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = A1 or L2
  if not A1 then
    L2 = {}
  end
  L3 = {}
  L2.source = L4
  L2.destination = L4
  for L7, L8 in L4, L5, L6 do
    L9 = true
    L10 = L2.table
    if L10 then
      L10 = L2.table
      L11 = L10
      L10 = L10.lower
      L10 = L10(L11)
      L11 = L8.table
      if L10 ~= L11 then
        L9 = false
      end
    end
    if L9 == true then
      L10 = L2.chain
      if not L10 then
        goto lbl_44
      end
      L10 = L2.chain
      L11 = L8.chain
      if L10 == L11 then
        goto lbl_44
      end
    end
    L9 = false
    ::lbl_44::
    if L9 == true then
      L10 = L2.target
      if not L10 then
        goto lbl_54
      end
      L10 = L2.target
      L11 = L8.target
      if L10 == L11 then
        goto lbl_54
      end
    end
    L9 = false
    ::lbl_54::
    if L9 == true then
      L10 = L2.protocol
      if not L10 then
        goto lbl_69
      end
      L10 = L8.protocol
      if L10 == "all" then
        goto lbl_69
      end
      L10 = L2.protocol
      L11 = L10
      L10 = L10.lower
      L10 = L10(L11)
      L11 = L8.protocol
      if L10 == L11 then
        goto lbl_69
      end
    end
    L9 = false
    ::lbl_69::
    if L9 == true then
      L10 = L2.source
      if not L10 then
        goto lbl_87
      end
      L10 = L8.source
      L11 = A0._nulladdr
      if L10 == L11 then
        goto lbl_87
      end
      L11 = A0
      L10 = A0._parse_addr
      L12 = L8.source
      L10 = L10(L11, L12)
      L11 = L10
      L10 = L10.contains
      L12 = L2.source
      L10 = L10(L11, L12)
      if L10 then
        goto lbl_87
      end
    end
    L9 = false
    ::lbl_87::
    if L9 == true then
      L10 = L2.destination
      if not L10 then
        goto lbl_105
      end
      L10 = L8.destination
      L11 = A0._nulladdr
      if L10 == L11 then
        goto lbl_105
      end
      L11 = A0
      L10 = A0._parse_addr
      L12 = L8.destination
      L10 = L10(L11, L12)
      L11 = L10
      L10 = L10.contains
      L12 = L2.destination
      L10 = L10(L11, L12)
      if L10 then
        goto lbl_105
      end
    end
    L9 = false
    ::lbl_105::
    if L9 == true then
      L10 = L2.inputif
      if not L10 then
        goto lbl_118
      end
      L10 = L8.inputif
      if L10 == "*" then
        goto lbl_118
      end
      L10 = L2.inputif
      L11 = L8.inputif
      if L10 == L11 then
        goto lbl_118
      end
    end
    L9 = false
    ::lbl_118::
    if L9 == true then
      L10 = L2.outputif
      if not L10 then
        goto lbl_131
      end
      L10 = L8.outputif
      if L10 == "*" then
        goto lbl_131
      end
      L10 = L2.outputif
      L11 = L8.outputif
      if L10 == L11 then
        goto lbl_131
      end
    end
    L9 = false
    ::lbl_131::
    if L9 == true then
      L10 = L2.flags
      if not L10 then
        goto lbl_141
      end
      L10 = L8.flags
      L11 = L2.flags
      if L10 == L11 then
        goto lbl_141
      end
    end
    L9 = false
    ::lbl_141::
    if L9 == true then
      L10 = L2.options
      if not L10 then
        goto lbl_153
      end
      L11 = A0
      L10 = A0._match_options
      L12 = L8.options
      L13 = L2.options
      L10 = L10(L11, L12, L13)
      if L10 then
        goto lbl_153
      end
    end
    L9 = false
    ::lbl_153::
    if L9 == true then
      L10 = #L3
      L10 = L10 + 1
      L3[L10] = L8
    end
  end
  return L3
end
L4.find = L5
L4 = IptParser
function L5(A0)
  local L1, L2
  L1 = {}
  A0._rules = L1
  A0._chain = nil
  L2 = A0
  L1 = A0._parse_rules
  L1(L2)
end
L4.resync = L5
L4 = IptParser
function L5(A0)
  local L1
  L1 = A0._tables
  return L1
end
L4.tables = L5
L4 = IptParser
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = {}
  L3 = {}
  L7 = {}
  L7.table = A1
  L7, L8, L9, L10 = L5(L6, L7)
  for L7, L8 in L4, L5, L6 do
    L9 = L8.chain
    L9 = L2[L9]
    if not L9 then
      L9 = L8.chain
      L2[L9] = true
      L9 = #L3
      L9 = L9 + 1
      L10 = L8.chain
      L3[L9] = L10
    end
  end
  return L3
end
L4.chains = L5
L4 = IptParser
function L5(A0, A1, A2)
  local L3, L4, L5
  L3 = A0._chains
  L5 = A1
  L4 = A1.lower
  L4 = L4(L5)
  L3 = L3[L4]
  if L3 then
    L3 = A0._chains
    L5 = A1
    L4 = A1.lower
    L4 = L4(L5)
    L3 = L3[L4]
    L3 = L3[A2]
  end
  return L3
end
L4.chain = L5
L4 = IptParser
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    L7 = L6.chain
    if L7 == A1 then
      L7 = true
      return L7
    end
  end
  return L2
end
L4.is_custom_target = L5
L4 = IptParser
function L5(A0, A1)
  local L2, L3
  L2 = A0._family
  if L2 == 4 then
    L2 = _UPVALUE0_
    L2 = L2.ip
    L2 = L2.IPv4
    L3 = A1
    return L2(L3)
  else
    L2 = _UPVALUE0_
    L2 = L2.ip
    L2 = L2.IPv6
    L3 = A1
    return L2(L3)
  end
end
L4._parse_addr = L5
L4 = IptParser
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  for L4, L5 in L1, L2, L3 do
    L6[L5] = L7
    L9, L10, L11, L12, L16, L17, L18, L19 = L7(L8)
    for L9, L10 in L6, L7, L8 do
      L12 = L10
      L11 = L10.find
      L11 = L11(L12, L13)
      if L11 == 1 then
        L11 = nil
        L12 = L10.match
        L12 = L12(L13, L14)
        if not L12 then
          L17 = L10
          L16 = L10.match
          L18 = "^Chain ([^%s]*) %((%d+) references%)"
          L16, L17 = L16(L17, L18)
          L11 = L17
          L12 = L16
        end
        A0._chain = L12
        L16 = A0._chains
        L16 = L16[L5]
        L17 = {}
        L17.policy = L13
        L18 = _UPVALUE2_
        L19 = L14 or L19
        if not L14 then
          L19 = 0
        end
        L18 = L18(L19)
        L17.packets = L18
        L18 = _UPVALUE2_
        L19 = L15 or L19
        if not L15 then
          L19 = 0
        end
        L18 = L18(L19)
        L17.bytes = L18
        L18 = _UPVALUE2_
        L19 = L11 or L19
        if not L11 then
          L19 = 0
        end
        L18 = L18(L19)
        L17.references = L18
        L18 = {}
        L17.rules = L18
        L16[L12] = L17
      else
        L12 = L10
        L11 = L10.find
        L11 = L11(L12, L13)
        if L11 == 1 then
          L11 = _UPVALUE1_
          L11 = L11.util
          L11 = L11.split
          L12 = L10
          L11 = L11(L12, L13, L14, L15)
          L12 = {}
          if L13 then
            L16 = nil
            L13(L14, L15, L16)
          end
          if L13 == 6 then
            L16 = "--"
            L13(L14, L15, L16)
          end
          L12.table = L5
          L12.chain = L13
          L12.index = L13
          L12.packets = L13
          L12.bytes = L13
          L12.target = L13
          L12.protocol = L13
          L12.flags = L13
          L12.inputif = L13
          L12.outputif = L13
          L12.source = L13
          L12.destination = L13
          L12.options = L13
          for L16 = L13, L14, L15 do
            L17 = L12.options
            L18 = L16 - 10
            L19 = L11[L16]
            L17[L18] = L19
          end
          L13[L14] = L12
          L13[L14] = L12
        end
      end
    end
  end
  A0._chain = nil
end
L4._parse_rules = L5
L4 = IptParser
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = {}
  for L7, L8 in L4, L5, L6 do
    L3[L8] = true
  end
  for L7, L8 in L4, L5, L6 do
    L9 = L3[L8]
    if not L9 then
      L9 = false
      return L9
    end
  end
  return L4
end
L4._match_options = L5
