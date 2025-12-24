local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
L0 = require
L1 = "nixio.fs"
L0 = L0(L1)
L1 = require
L2 = "luci.ip"
L1 = L1(L2)
L2 = require
L3 = "math"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4 = tonumber
L5 = tostring
L6 = type
L7 = unpack
L8 = select
L9 = module
L10 = "luci.cbi.datatypes"
L9(L10)
L9 = _M
function L10(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L6, L7, L8, L9, L10, L11, L12 = ...
  for L6 = L3, L4, L5 do
    L7 = _UPVALUE0_
    L8 = L6
    L9, L10, L11, L12 = ...
    L7 = L7(L8, L9, L10, L11, L12)
    L8 = _UPVALUE0_
    L9 = L6 + 1
    L10, L11, L12 = ...
    L8 = L8(L9, L10, L11, L12)
    L9 = _UPVALUE1_
    L10 = L7
    L9 = L9(L10)
    if L9 ~= "function" then
      if L7 == A0 then
        L9 = true
        return L9
      end
      L6 = L6 - 1
    else
      L9 = L7
      L10 = A0
      L11 = _UPVALUE2_
      L12 = L8
      L11, L12 = L11(L12)
      L9 = L9(L10, L11, L12)
      if L9 then
        L9 = true
        return L9
      end
    end
  end
  return L3
end
L9["or"] = L10
L9 = _M
function L10(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L6, L7, L8, L9, L10, L11, L12 = ...
  for L6 = L3, L4, L5 do
    L7 = _UPVALUE0_
    L8 = L6
    L9, L10, L11, L12 = ...
    L7 = L7(L8, L9, L10, L11, L12)
    L8 = _UPVALUE0_
    L9 = L6 + 1
    L10, L11, L12 = ...
    L8 = L8(L9, L10, L11, L12)
    L9 = _UPVALUE1_
    L10 = L7
    L9 = L9(L10)
    if L9 ~= "function" then
      if L7 ~= A0 then
        L9 = false
        return L9
      end
      L6 = L6 - 1
    else
      L9 = L7
      L10 = A0
      L11 = _UPVALUE2_
      L12 = L8
      L11, L12 = L11(L12)
      L9 = L9(L10, L11, L12)
      if not L9 then
        L9 = false
        return L9
      end
    end
  end
  return L3
end
L9["and"] = L10
function L9(A0, ...)
  local L2, L3, L4, L5, L6
  L2 = _M
  L2 = L2["or"]
  L4 = A0
  L3 = A0.gsub
  L5 = "^%s*!%s*"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4, L5, L6 = ...
  return L2(L3, L4, L5, L6)
end
neg = L9
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = _UPVALUE0_
  L3 = L3(L4)
  if L3 ~= "function" then
    L3 = false
    return L3
  end
  L3 = nil
  for L7 in L4, L5, L6 do
    L8 = A1
    L9 = L7
    L10 = _UPVALUE1_
    L11 = A2
    L10, L11 = L10(L11)
    L8 = L8(L9, L10, L11)
    if not L8 then
      L8 = false
      return L8
    end
  end
  return L4
end
list = L9
function L9(A0)
  local L1
  if A0 == "1" or A0 == "yes" or A0 == "on" or A0 == "true" then
    L1 = true
    return L1
  elseif A0 == "0" or A0 == "no" or A0 == "off" or A0 == "false" then
    L1 = true
    return L1
  elseif A0 == "" or A0 == nil then
    L1 = true
    return L1
  end
  L1 = false
  return L1
end
bool = L9
function L9(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 ~= nil then
    L2 = _UPVALUE1_
    L2 = L2.floor
    L3 = L1
    L2 = L2(L3)
    if L2 == L1 and 0 <= L1 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
uinteger = L9
function L9(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 ~= nil then
    L2 = _UPVALUE1_
    L2 = L2.floor
    L3 = L1
    L2 = L2(L3)
    if L2 == L1 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
integer = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  L2 = L1 ~= nil and 0 <= L1
  return L2
end
ufloat = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  L1 = L1 ~= nil
  return L1
end
float = L9
function L9(A0)
  local L1, L2
  L1 = ip4addr
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = ip6addr
    L2 = A0
    L1 = L1(L2)
  end
  return L1
end
ipaddr = L9
function L9(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.IPv4
    L2 = A0
    L1 = L1(L2)
    if L1 then
      L1 = true
      if L1 then
        goto lbl_13
      end
    end
    L1 = false
    ::lbl_13::
    return L1
  end
  L1 = false
  return L1
end
ip4addr = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = A0 or L1
  L1 = A0 and 0 <= A0 and A0 <= 32
  return L1
end
ip4prefix = L9
function L9(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.IPv6
    L2 = A0
    L1 = L1(L2)
    if L1 then
      L1 = true
      if L1 then
        goto lbl_13
      end
    end
    L1 = false
    ::lbl_13::
    return L1
  end
  L1 = false
  return L1
end
ip6addr = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = A0 or L1
  L1 = A0 and 0 <= A0 and A0 <= 128
  return L1
end
ip6prefix = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = A0 or L1
  L1 = A0 and 0 <= A0 and A0 <= 65535
  return L1
end
port = L9
function L9(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.match
  L3 = "^(%d+)%-(%d+)$"
  L1, L2 = L1(L2, L3)
  if L1 and L2 then
    L3 = port
    L4 = L1
    L3 = L3(L4)
    if L3 then
      L3 = port
      L4 = L2
      L3 = L3(L4)
      if L3 then
        L3 = true
        return L3
    end
  end
  else
    L3 = port
    L4 = A0
    return L3(L4)
  end
end
portrange = L9
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  if A0 then
    L1 = A0.match
    L1 = L1(L2, L3)
    if L1 then
      L1 = _UPVALUE0_
      L1 = L1.split
      L1 = L1(L2, L3)
      for L5 = L2, L3, L4 do
        L6 = _UPVALUE1_
        L7 = L1[L5]
        L8 = 16
        L6 = L6(L7, L8)
        L1[L5] = L6
        L6 = L1[L5]
        if not (L6 < 0) then
          L6 = L1[L5]
          if not (255 < L6) then
            goto lbl_32
          end
        end
        L6 = false
        do return L6 end
        ::lbl_32::
      end
      return L2
    end
  end
  L1 = false
  return L1
end
macaddr = L9
function L9(A0)
  local L1, L2, L3
  if A0 then
    L1 = #A0
    if L1 < 254 then
      L2 = A0
      L1 = A0.match
      L3 = "^[a-zA-Z_]+$"
      L1 = L1(L2, L3)
      if not L1 then
        L2 = A0
        L1 = A0.match
        L3 = "^[a-zA-Z0-9_][a-zA-Z0-9_%-%.]*[a-zA-Z0-9]$"
        L1 = L1(L2, L3)
        if not L1 then
          goto lbl_23
        end
        L2 = A0
        L1 = A0.match
        L3 = "[^0-9%.]"
        L1 = L1(L2, L3)
        if not L1 then
          goto lbl_23
        end
      end
      L1 = true
      return L1
    end
  end
  ::lbl_23::
  L1 = false
  return L1
end
hostname = L9
function L9(A0)
  local L1, L2
  L1 = hostname
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = ipaddr
    L2 = A0
    L1 = L1(L2)
  end
  return L1
end
host = L9
function L9(A0)
  local L1, L2
  L1 = uciname
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = host
    L2 = A0
    L1 = L1(L2)
  end
  return L1
end
network = L9
function L9(A0)
  local L1, L2, L3
  L1 = #A0
  if L1 == 64 then
    L2 = A0
    L1 = A0.match
    L3 = "^[a-fA-F0-9]+$"
    L1 = L1(L2, L3)
    L1 = L1 ~= nil
    return L1
  else
    L1 = #A0
    L1 = 8 <= L1
    return L1
  end
end
wpakey = L9
function L9(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.sub
  L3 = 1
  L4 = 2
  L1 = L1(L2, L3, L4)
  if L1 == "s:" then
    L2 = A0
    L1 = A0.sub
    L3 = 3
    L1 = L1(L2, L3)
    A0 = L1
  end
  L1 = #A0
  if L1 ~= 10 then
    L1 = #A0
    if L1 ~= 26 then
      goto lbl_26
    end
  end
  L2 = A0
  L1 = A0.match
  L3 = "^[a-fA-F0-9]+$"
  L1 = L1(L2, L3)
  L1 = L1 ~= nil
  do return L1 end
  goto lbl_35
  ::lbl_26::
  L1 = #A0
  L1 = L1 == 5
  do return L1 end
  ::lbl_35::
end
wepkey = L9
function L9(A0)
  local L1
  L1 = true
  return L1
end
string = L9
function L9(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0
  L2 = L2(L3)
  if not A1 then
    L3 = {}
    A1 = L3
  end
  if L2 then
    L3 = L2.ino
    L3 = A1[L3]
    if not L3 then
      L3 = L2.ino
      A1[L3] = true
      L3 = L2.type
      if L3 == "dir" then
        L3 = true
        return L3
      else
        L3 = L2.type
        if L3 == "lnk" then
          L3 = directory
          L4 = _UPVALUE0_
          L4 = L4.readlink
          L5 = A0
          L4 = L4(L5)
          L5 = A1
          return L3(L4, L5)
        end
      end
    end
  end
  L3 = false
  return L3
end
directory = L9
function L9(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0
  L2 = L2(L3)
  if not A1 then
    L3 = {}
    A1 = L3
  end
  if L2 then
    L3 = L2.ino
    L3 = A1[L3]
    if not L3 then
      L3 = L2.ino
      A1[L3] = true
      L3 = L2.type
      if L3 == "reg" then
        L3 = true
        return L3
      else
        L3 = L2.type
        if L3 == "lnk" then
          L3 = file
          L4 = _UPVALUE0_
          L4 = L4.readlink
          L5 = A0
          L4 = L4(L5)
          L5 = A1
          return L3(L4, L5)
        end
      end
    end
  end
  L3 = false
  return L3
end
file = L9
function L9(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0
  L2 = L2(L3)
  if not A1 then
    L3 = {}
    A1 = L3
  end
  if L2 then
    L3 = L2.ino
    L3 = A1[L3]
    if not L3 then
      L3 = L2.ino
      A1[L3] = true
      L3 = L2.type
      if L3 ~= "chr" then
        L3 = L2.type
        if L3 ~= "blk" then
          goto lbl_26
        end
      end
      L3 = true
      do return L3 end
      goto lbl_37
      ::lbl_26::
      L3 = L2.type
      if L3 == "lnk" then
        L3 = device
        L4 = _UPVALUE0_
        L4 = L4.readlink
        L5 = A0
        L4 = L4(L5)
        L5 = A1
        return L3(L4, L5)
      end
    end
  end
  ::lbl_37::
  L3 = false
  return L3
end
device = L9
function L9(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.match
  L3 = "^[a-zA-Z0-9_]+$"
  L1 = L1(L2, L3)
  L1 = L1 ~= nil
  return L1
end
uciname = L9
function L9(A0, A1, A2)
  local L3, L4
  L3 = _UPVALUE0_
  L4 = A0
  L3 = L3(L4)
  A0 = L3
  L3 = _UPVALUE0_
  L4 = A1
  L3 = L3(L4)
  A1 = L3
  L3 = _UPVALUE0_
  L4 = A2
  L3 = L3(L4)
  A2 = L3
  if A0 ~= nil and A1 ~= nil and A2 ~= nil then
    L3 = A0 >= A1 and A0 <= A2
    return L3
  end
  L3 = false
  return L3
end
range = L9
function L9(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L2 = _UPVALUE0_
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  if A0 ~= nil and A1 ~= nil then
    L2 = A0 >= A1
    return L2
  end
  L2 = false
  return L2
end
min = L9
function L9(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L2 = _UPVALUE0_
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  if A0 ~= nil and A1 ~= nil then
    L2 = A0 <= A1
    return L2
  end
  L2 = false
  return L2
end
max = L9
function L9(A0, A1, A2)
  local L3, L4
  L3 = _UPVALUE0_
  L4 = A0
  L3 = L3(L4)
  A0 = L3
  L3 = _UPVALUE1_
  L4 = A1
  L3 = L3(L4)
  A1 = L3
  L3 = _UPVALUE1_
  L4 = A2
  L3 = L3(L4)
  A2 = L3
  if A0 ~= nil and A1 ~= nil and A2 ~= nil then
    L3 = #A0
    L3 = A1 <= L3
    return L3
  end
  L3 = false
  return L3
end
rangelength = L9
function L9(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L2 = _UPVALUE1_
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  if A0 ~= nil and A1 ~= nil then
    L2 = #A0
    L2 = A1 <= L2
    return L2
  end
  L2 = false
  return L2
end
minlength = L9
function L9(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L2 = _UPVALUE1_
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  if A0 ~= nil and A1 ~= nil then
    L2 = #A0
    L2 = A1 >= L2
    return L2
  end
  L2 = false
  return L2
end
maxlength = L9
function L9(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.match
  L3 = "^[0-9*#]+$"
  L1 = L1(L2, L3)
  L1 = L1 ~= nil
  return L1
end
phonedigit = L9
