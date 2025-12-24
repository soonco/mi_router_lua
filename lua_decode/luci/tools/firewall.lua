local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "luci.tools.firewall"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "luci.ip"
L1 = L1(L2)
L2 = require
L3 = "nixio"
L2 = L2(L3)
L3 = luci
L3 = L3.i18n
L3 = L3.translate
L4 = luci
L4 = L4.i18n
L4 = L4.translatef
function L5(...)
  local L1, L2, L3
  L1 = tostring
  L2 = _UPVALUE0_
  L3 = ...
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L2 = A0
    L1 = A0.gsub
    L3 = "^ *! *"
    L4 = ""
    L1, L2 = L1(L2, L3, L4)
    if 0 < L2 then
      L3 = L1
      L4 = _UPVALUE0_
      L5 = "not"
      L4 = L4(L5)
      L4 = "%s " % L4
      return L3, L4
    else
      L3 = A0
      L4 = ""
      return L3, L4
    end
  end
  L1 = A0
  L2 = ""
  return L1, L2
end
fmt_neg = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if A0 then
    L1 = #A0
    if 0 < L1 then
      L1, L2 = nil, nil
      L3 = {}
      L3[1] = L4
      L3[2] = L5
      for L7 in L4, L5, L6 do
        L8 = fmt_neg
        L9 = L7
        L8, L9 = L8(L9)
        L2 = L9
        L7 = L8
        L8 = #L3
        L8 = L8 + 1
        L9 = {}
        L10 = L2
        L11 = L7
        L9[1] = L10
        L9[2] = L11
        L9 = "<var>%s%s</var>" % L9
        L3[L8] = L9
        L8 = #L3
        L8 = L8 + 1
        L3[L8] = ", "
      end
      if 1 < L4 then
        L3[L4] = nil
        if 3 < L4 then
          L3[1] = L4
        end
        return L4(L5, L6)
      end
    end
  end
end
fmt_mac = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if A0 then
    L2 = #A0
    if 0 < L2 then
      L2, L3 = nil, nil
      L4 = {}
      L4[1] = L5
      L4[2] = L6
      for L8 in L5, L6, L7 do
        L9 = fmt_neg
        L10 = L8
        L9, L10 = L9(L10)
        L3 = L10
        L8 = L9
        L10 = L8
        L9 = L8.match
        L11 = "(%d+)%D+(%d+)"
        L9, L10 = L9(L10, L11)
        if L9 and L10 then
          L11 = _UPVALUE0_
          L12 = "ports"
          L11 = L11(L12)
          L4[1] = L11
          L11 = #L4
          L11 = L11 + 1
          L12 = {}
          L13 = L3
          L14 = L9
          L15 = L10
          L12[1] = L13
          L12[2] = L14
          L12[3] = L15
          L12 = "<var>%s%d-%d</var>" % L12
          L4[L11] = L12
        else
          L11 = #L4
          L11 = L11 + 1
          L12 = {}
          L13 = L3
          L14 = L8
          L12[1] = L13
          L12[2] = L14
          L12 = "<var>%s%d</var>" % L12
          L4[L11] = L12
        end
        L11 = #L4
        L11 = L11 + 1
        L4[L11] = ", "
      end
      if 1 < L5 then
        L4[L5] = nil
        if 3 < L5 then
          L4[1] = L5
        end
        return L5(L6, L7)
      end
    end
  end
  L2 = A1 or L2
  if A1 then
    L2 = "<var>%s</var>" % A1
  end
  return L2
end
fmt_port = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  if A0 then
    L2 = #A0
    if 0 < L2 then
      L2 = {}
      L3 = _UPVALUE0_
      L4 = "IP"
      L3 = L3(L4)
      L4 = " "
      L2[1] = L3
      L2[2] = L4
      L3, L4, L5 = nil, nil, nil
      for L9 in L6, L7, L8 do
        L10 = fmt_neg
        L11 = L9
        L10, L11 = L10(L11)
        L5 = L11
        L9 = L10
        L11 = L9
        L10 = L9.match
        L12 = "(%S+)/(%d+%.%S+)"
        L10, L11 = L10(L11, L12)
        m = L11
        L4 = L10
        L4 = L4 or L4
        L11 = L4
        L10 = L4.match
        L12 = ":"
        L10 = L10(L11, L12)
        if L10 then
          L10 = _UPVALUE2_
          L10 = L10.IPv6
          L11 = L4
          L12 = m
          L10 = L10(L11, L12)
          if L10 then
            goto lbl_49
            L4 = L10 or L4
          end
        end
        L10 = _UPVALUE2_
        L10 = L10.IPv4
        L11 = L4
        L12 = m
        L10 = L10(L11, L12)
        L4 = L10
        ::lbl_49::
        if L4 then
          L11 = L4
          L10 = L4.is6
          L10 = L10(L11)
          if L10 then
            L11 = L4
            L10 = L4.prefix
            L10 = L10(L11)
            if L10 < 128 then
              goto lbl_63
            end
          end
          L11 = L4
          L10 = L4.prefix
          L10 = L10(L11)
          ::lbl_63::
          if L10 < 32 then
            L10 = _UPVALUE0_
            L11 = "IP range"
            L10 = L10(L11)
            L2[1] = L10
            L10 = #L2
            L10 = L10 + 1
            L11 = {}
            L13 = L4
            L12 = L4.minhost
            L12 = L12(L13)
            L13 = L12
            L12 = L12.string
            L12 = L12(L13)
            L14 = L4
            L13 = L4.maxhost
            L13 = L13(L14)
            L14 = L13
            L13 = L13.string
            L13 = L13(L14)
            L14 = L5
            L16 = L4
            L15 = L4.string
            L15, L16 = L15(L16)
            L11[1] = L12
            L11[2] = L13
            L11[3] = L14
            L11[4] = L15
            L11[5] = L16
            L11 = "<var title='%s - %s'>%s%s</var>" % L11
            L2[L10] = L11
        end
        else
          L10 = #L2
          L10 = L10 + 1
          L11 = {}
          L12 = L5
          if L4 then
            L14 = L4
            L13 = L4.string
            L13 = L13(L14)
            if L13 then
              goto lbl_96
            end
          end
          L13 = L9
          ::lbl_96::
          L11[1] = L12
          L11[2] = L13
          L11 = "<var>%s%s</var>" % L11
          L2[L10] = L11
        end
        L10 = #L2
        L10 = L10 + 1
        L2[L10] = ", "
      end
      if 1 < L6 then
        L2[L6] = nil
        if 3 < L6 then
          L2[1] = L6
        end
        return L6(L7, L8)
      end
    end
  end
  L2 = A1 or L2
  if A1 then
    L2 = "<var>%s</var>" % A1
  end
  return L2
end
fmt_ip = L6
function L6(A0, A1)
  local L2, L3
  if A0 == "*" then
    L2 = _UPVALUE0_
    L3 = "any zone"
    L2 = L2(L3)
    L2 = "<var>%s</var>" % L2
    return L2
  else
    if A0 then
      L2 = #A0
      if 0 < L2 then
        L2 = "<var>%s</var>" % A0
        return L2
    end
    elseif A1 then
      L2 = "<var>%s</var>" % A1
      return L2
    end
  end
end
fmt_zone = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A0 then
    L1 = #A0
    if 0 < L1 then
      L1, L2, L3 = nil, nil, nil
      L4 = {}
      L4[1] = L5
      L4[2] = L6
      for L8 in L5, L6, L7 do
        L9 = fmt_neg
        L10 = L8
        L9, L10 = L9(L10)
        L3 = L10
        L8 = L9
        L9 = #L4
        L9 = L9 + 1
        L10 = {}
        L11 = L3
        L12 = L8
        L10[1] = L11
        L10[2] = L12
        L10 = "<var>%s%s</var>" % L10
        L4[L9] = L10
        L9 = #L4
        L9 = L9 + 1
        L4[L9] = ", "
      end
      if 1 < L5 then
        L4[L5] = nil
        if 3 < L5 then
          L4[1] = L5
        end
        return L5(L6, L7)
      end
    end
  end
end
fmt_icmp_type = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  if A0 then
    L2 = #A0
    if 0 < L2 then
      L2, L3 = nil, nil
      L4 = {}
      L5 = fmt_icmp_type
      L5 = L5(L6)
      for L9 in L6, L7, L8 do
        L10 = fmt_neg
        L11 = L9
        L10, L11 = L10(L11)
        L3 = L11
        L9 = L10
        if L9 == "tcpudp" then
          L10 = #L4
          L10 = L10 + 1
          L4[L10] = "TCP"
          L10 = #L4
          L10 = L10 + 1
          L4[L10] = ", "
          L10 = #L4
          L10 = L10 + 1
          L4[L10] = "UDP"
          L10 = #L4
          L10 = L10 + 1
          L4[L10] = ", "
        elseif L9 ~= "all" then
          L10 = _UPVALUE1_
          L10 = L10.getproto
          L11 = L9
          L10 = L10(L11)
          if L10 then
            L11 = L10.proto
            if L11 ~= 1 then
              L11 = L10.proto
            end
            if L11 == 58 and L5 then
              L11 = #L4
              L11 = L11 + 1
              L12 = _UPVALUE2_
              L13 = "%s%s with %s"
              L14 = L3
              L15 = L10.aliases
              L15 = L15[1]
              L15 = L15 or L15
              L16 = L5
              L12 = L12(L13, L14, L15, L16)
              L4[L11] = L12
            else
              L11 = #L4
              L11 = L11 + 1
              L12 = {}
              L13 = L3
              L14 = L10.aliases
              L14 = L14[1]
              L14 = L14 or L14
              L12[1] = L13
              L12[2] = L14
              L12 = "%s%s" % L12
              L4[L11] = L12
            end
            L11 = #L4
            L11 = L11 + 1
            L4[L11] = ", "
          end
        end
      end
      if 0 < L6 then
        L4[L6] = nil
        return L6(L7, L8)
      end
    end
  end
end
fmt_proto = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = tonumber
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  if A0 then
    L2 = #A0
    if 0 < L2 then
      L3 = A0
      L2 = A0.match
      L4 = "(%d+)/(%w+)"
      L2, L3 = L2(L3, L4)
      L4 = tonumber
      L5 = L2 or L5
      if not L2 then
        L5 = A0
      end
      L4 = L4(L5)
      L2 = L4
      L3 = L3 or L3
      if L2 then
        L5 = L3
        L4 = L3.match
        L6 = "^s"
        L4 = L4(L5, L6)
        if L4 then
          L4 = _UPVALUE0_
          L5 = "second"
          L4 = L4(L5)
          L3 = L4
        else
          L5 = L3
          L4 = L3.match
          L6 = "^m"
          L4 = L4(L5, L6)
          if L4 then
            L4 = _UPVALUE0_
            L5 = "minute"
            L4 = L4(L5)
            L3 = L4
          else
            L5 = L3
            L4 = L3.match
            L6 = "^h"
            L4 = L4(L5, L6)
            if L4 then
              L4 = _UPVALUE0_
              L5 = "hour"
              L4 = L4(L5)
              L3 = L4
            else
              L5 = L3
              L4 = L3.match
              L6 = "^d"
              L4 = L4(L5, L6)
              if L4 then
                L4 = _UPVALUE0_
                L5 = "day"
                L4 = L4(L5)
                L3 = L4
              end
            end
          end
        end
        if A1 and 0 < A1 then
          L4 = _UPVALUE1_
          L5 = [[
<var>%d</var> pkts. per <var>%s</var>, 
				    burst <var>%d</var> pkts.]]
          L6 = L2
          L7 = L3
          L8 = A1
          return L4(L5, L6, L7, L8)
        else
          L4 = _UPVALUE1_
          L5 = "<var>%d</var> pkts. per <var>%s</var>"
          L6 = L2
          L7 = L3
          return L4(L5, L6, L7)
        end
      end
    end
  end
end
fmt_limit = L6
function L6(A0, A1)
  local L2, L3
  if A1 then
    L2 = #A1
    if 0 < L2 then
      if A0 == "ACCEPT" then
        L2 = _UPVALUE0_
        L3 = "Accept forward"
        return L2(L3)
      elseif A0 == "REJECT" then
        L2 = _UPVALUE0_
        L3 = "Refuse forward"
        return L2(L3)
      elseif A0 == "NOTRACK" then
        L2 = _UPVALUE0_
        L3 = "Do not track forward"
        return L2(L3)
      else
        L2 = _UPVALUE0_
        L3 = "Discard forward"
        return L2(L3)
      end
  end
  elseif A0 == "ACCEPT" then
    L2 = _UPVALUE0_
    L3 = "Accept input"
    return L2(L3)
  elseif A0 == "REJECT" then
    L2 = _UPVALUE0_
    L3 = "Refuse input"
    return L2(L3)
  elseif A0 == "NOTRACK" then
    L2 = _UPVALUE0_
    L3 = "Do not track input"
    return L2(L3)
  else
    L2 = _UPVALUE0_
    L3 = "Discard input"
    return L2(L3)
  end
end
fmt_target = L6
function L6(A0, A1, ...)
  local L3, L4, L5, L6, L7
  L3 = luci
  L3 = L3.cbi
  L3 = L3.Button
  if A1 == L3 then
    L4 = A0
    L3 = A0.option
    L5 = A1
    L6 = "__enabled"
    L3 = L3(L4, L5, L6)
    function L4(A0, A1)
      local L2, L3, L4, L5
      L2 = A0.map
      L3 = L2
      L2 = L2.get
      L4 = A1
      L5 = "enabled"
      L2 = L2(L3, L4, L5)
      if L2 ~= "0" then
        L2 = _UPVALUE0_
        L3 = "Rule is enabled"
        L2 = L2(L3)
        A0.title = L2
        L2 = _UPVALUE0_
        L3 = "Disable"
        L2 = L2(L3)
        A0.inputtitle = L2
        A0.inputstyle = "reset"
      else
        L2 = _UPVALUE0_
        L3 = "Rule is disabled"
        L2 = L2(L3)
        A0.title = L2
        L2 = _UPVALUE0_
        L3 = "Enable"
        L2 = L2(L3)
        A0.inputtitle = L2
        A0.inputstyle = "apply"
      end
      L2 = _UPVALUE1_
      L2 = L2.render
      L3 = A0
      L4 = A1
      L2(L3, L4)
    end
    L3.render = L4
    function L4(A0, A1, A2)
      local L3, L4, L5, L6, L7
      L3 = A0.map
      L4 = L3
      L3 = L3.get
      L5 = A1
      L6 = "enabled"
      L3 = L3(L4, L5, L6)
      if L3 ~= "0" then
        L3 = A0.map
        L4 = L3
        L3 = L3.set
        L5 = A1
        L6 = "enabled"
        L7 = "0"
        L3(L4, L5, L6, L7)
      else
        L3 = A0.map
        L4 = L3
        L3 = L3.del
        L5 = A1
        L6 = "enabled"
        L3(L4, L5, L6)
      end
    end
    L3.write = L4
    return L3
  else
    L4 = A0
    L3 = A0.option
    L5 = A1
    L6 = "enabled"
    L7 = ...
    L3 = L3(L4, L5, L6, L7)
    L3.enabled = ""
    L3.disabled = "0"
    L4 = L3.enabled
    L3.default = L4
    return L3
  end
end
opt_enabled = L6
function L6(A0, A1, ...)
  local L3, L4, L5, L6, L7
  L4 = A0
  L3 = A0.option
  L5 = A1
  L6 = "name"
  L7 = ...
  L3 = L3(L4, L5, L6, L7)
  function L4(A0, A1)
    local L2, L3, L4, L5
    L2 = A0.map
    L3 = L2
    L2 = L2.get
    L4 = A1
    L5 = "name"
    L2 = L2(L3, L4, L5)
    if not L2 then
      L2 = A0.map
      L3 = L2
      L2 = L2.get
      L4 = A1
      L5 = "_name"
      L2 = L2(L3, L4, L5)
      L2 = L2 or L2
    end
    return L2
  end
  L3.cfgvalue = L4
  function L4(A0, A1, A2)
    local L3, L4, L5, L6, L7
    if A2 ~= "-" then
      L3 = A0.map
      L4 = L3
      L3 = L3.set
      L5 = A1
      L6 = "name"
      L7 = A2
      L3(L4, L5, L6, L7)
      L3 = A0.map
      L4 = L3
      L3 = L3.del
      L5 = A1
      L6 = "_name"
      L3(L4, L5, L6)
    else
      L4 = A0
      L3 = A0.remove
      L5 = A1
      L3(L4, L5)
    end
  end
  L3.write = L4
  function L4(A0, A1)
    local L2, L3, L4, L5
    L2 = A0.map
    L3 = L2
    L2 = L2.del
    L4 = A1
    L5 = "name"
    L2(L3, L4, L5)
    L2 = A0.map
    L3 = L2
    L2 = L2.del
    L4 = A1
    L5 = "_name"
    L2(L3, L4, L5)
  end
  L3.remove = L4
  return L3
end
opt_name = L6
