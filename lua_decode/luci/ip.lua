local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
L0 = module
L1 = "luci.ip"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "nixio"
L0(L1)
L0 = nixio
L0 = L0.bit
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L2 = L1.bigendian
L2 = L2()
L2 = not L2
LITTLE_ENDIAN = L2
L2 = LITTLE_ENDIAN
L2 = not L2
BIG_ENDIAN = L2
L2 = 4
FAMILY_INET4 = L2
L2 = 6
FAMILY_INET6 = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = setmetatable
  L2 = A0
  L3 = {}
  L4 = luci
  L4 = L4.ip
  L4 = L4.cidr
  L3.__index = L4
  L4 = luci
  L4 = L4.ip
  L4 = L4.cidr
  L4 = L4.add
  L3.__add = L4
  L4 = luci
  L4 = L4.ip
  L4 = L4.cidr
  L4 = L4.sub
  L3.__sub = L4
  L4 = luci
  L4 = L4.ip
  L4 = L4.cidr
  L4 = L4.lower
  L3.__lt = L4
  L4 = luci
  L4 = L4.ip
  L4 = L4.cidr
  L4 = L4.equal
  L3.__eq = L4
  function L4(...)
    local L1, L2
    L1 = luci
    L1 = L1.ip
    L1 = L1.cidr
    L1 = L1.equal
    L2 = ...
    L1 = L1(L2)
    if not L1 then
      L1 = luci
      L1 = L1.ip
      L1 = L1.cidr
      L1 = L1.lower
      L2 = ...
      L1 = L1(L2)
    end
    return L1
  end
  L3.__le = L4
  return L1(L2, L3)
end
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = type
  L4 = A0
  L3 = L3(L4)
  if L3 == "number" then
    L3 = {}
    L4 = _UPVALUE0_
    L4 = L4.rshift
    L5 = A0
    L6 = 16
    L4 = L4(L5, L6)
    L5 = _UPVALUE0_
    L5 = L5.band
    L6 = A0
    L7 = 65535
    L5, L6, L7 = L5(L6, L7)
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3[4] = L7
    L2 = L3
  else
    L3 = type
    L4 = A0
    L3 = L3(L4)
    if L3 == "string" then
      L4 = A0
      L3 = A0.find
      L5 = ":"
      L3 = L3(L4, L5)
      if L3 then
        L3 = IPv6
        L4 = A0
        L3 = L3(L4)
        A0 = L3
      else
        L3 = IPv4
        L4 = A0
        L3 = L3(L4)
        A0 = L3
      end
      if A0 then
        L3 = assert
        L4 = A0[1]
        L4 = L4 == A1
        L5 = "Can't mix IPv4 and IPv6 addresses"
        L3(L4, L5)
        L3 = {}
        L4 = unpack
        L5 = A0[2]
        L4, L5, L6, L7 = L4(L5)
        L3[1] = L4
        L3[2] = L5
        L3[3] = L6
        L3[4] = L7
        L2 = L3
      end
    else
      L3 = type
      L4 = A0
      L3 = L3(L4)
      if L3 == "table" then
        L3 = type
        L4 = A0[2]
        L3 = L3(L4)
        if L3 == "table" then
          L3 = assert
          L4 = A0[1]
          L4 = L4 == A1
          L5 = "Can't mix IPv4 and IPv6 addresses"
          L3(L4, L5)
          L3 = {}
          L4 = unpack
          L5 = A0[2]
          L4, L5, L6, L7 = L4(L5)
          L3[1] = L4
          L3[2] = L5
          L3[3] = L6
          L3[4] = L7
          L2 = L3
      end
      else
        L3 = type
        L4 = A0
        L3 = L3(L4)
        if L3 == "table" then
          L3 = {}
          L4 = unpack
          L5 = A0
          L4, L5, L6, L7 = L4(L5)
          L3[1] = L4
          L3[2] = L5
          L3[3] = L6
          L3[4] = L7
          L2 = L3
        end
      end
    end
  end
  L3 = assert
  L4 = L2
  L5 = "Invalid operand"
  L3(L4, L5)
  return L2
end
function L4(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.lshift
  L2 = _UPVALUE0_
  L2 = L2.rshift
  L3 = 65535
  L4 = A0 % 16
  L4 = 16 - L4
  L2 = L2(L3, L4)
  L3 = A0 % 16
  L3 = 16 - L3
  return L1(L2, L3)
end
function L5(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = _UPVALUE0_
  L2 = L2.bnot
  L3 = _UPVALUE1_
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = 65535
  return L1(L2, L3)
end
function L6(A0)
  local L1
  L1 = FAMILY_INET4
  if A0 == L1 then
    L1 = 32
    if L1 then
      goto lbl_8
    end
  end
  L1 = 128
  ::lbl_8::
  return L1
end
function L7(A0)
  local L1
  L1 = FAMILY_INET4
  if A0 == L1 then
    L1 = 30
    if L1 then
      goto lbl_8
    end
  end
  L1 = 127
  ::lbl_8::
  return L1
end
function L8(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = LITTLE_ENDIAN
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.bor
    L2 = _UPVALUE0_
    L2 = L2.rshift
    L3 = A0
    L4 = 8
    L2 = L2(L3, L4)
    L3 = _UPVALUE0_
    L3 = L3.band
    L4 = _UPVALUE0_
    L4 = L4.lshift
    L5 = A0
    L6 = 8
    L4 = L4(L5, L6)
    L5 = 65280
    L3, L4, L5, L6 = L3(L4, L5)
    return L1(L2, L3, L4, L5, L6)
  else
    return A0
  end
end
htons = L8
function L8(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = LITTLE_ENDIAN
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.bor
    L2 = _UPVALUE0_
    L2 = L2.lshift
    L3 = htons
    L4 = _UPVALUE0_
    L4 = L4.band
    L5 = A0
    L6 = 65535
    L4, L5, L6 = L4(L5, L6)
    L3 = L3(L4, L5, L6)
    L4 = 16
    L2 = L2(L3, L4)
    L3 = htons
    L4 = _UPVALUE0_
    L4 = L4.rshift
    L5 = A0
    L6 = 16
    L4, L5, L6 = L4(L5, L6)
    L3, L4, L5, L6 = L3(L4, L5, L6)
    return L1(L2, L3, L4, L5, L6)
  else
    return A0
  end
end
htonl = L8
L8 = htons
ntohs = L8
L8 = htonl
ntohl = L8
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  A0 = A0 or A0
  L2 = _UPVALUE0_
  L3 = {}
  L4 = FAMILY_INET4
  L3[1] = L4
  L2 = L2(L3)
  L3 = {}
  L5 = A0
  L4 = A0.match
  L6 = "/(.+)"
  L4 = L4(L5, L6)
  L6 = A0
  L5 = A0.gsub
  L7 = "/.+"
  L8 = ""
  L5 = L5(L6, L7, L8)
  A0 = L5
  L6 = A0
  L5 = A0.gsub
  L7 = "^%[(.*)%]$"
  L8 = "%1"
  L5 = L5(L6, L7, L8)
  L6 = L5
  L5 = L5.upper
  L5 = L5(L6)
  L6 = L5
  L5 = L5.gsub
  L7 = "^::FFFF:"
  L8 = ""
  L5 = L5(L6, L7, L8)
  A0 = L5
  if A1 then
    L6 = L2
    L5 = L2.prefix
    L7 = A1
    L5 = L5(L6, L7)
    L4 = L5
  elseif L4 then
    L5 = tonumber
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    if not L4 or L4 < 0 or 32 < L4 then
      L5 = nil
      return L5
    end
  else
    L4 = 32
  end
  L6 = A0
  L5 = A0.match
  L7 = "^(%d+)%.(%d+)%.(%d+)%.(%d+)$"
  L5, L6, L7, L8 = L5(L6, L7)
  L9 = tonumber
  L10 = L5
  L9 = L9(L10)
  L5 = L9
  L9 = tonumber
  L10 = L6
  L9 = L9(L10)
  L6 = L9
  L9 = tonumber
  L10 = L7
  L9 = L9(L10)
  L7 = L9
  L9 = tonumber
  L10 = L8
  L9 = L9(L10)
  L8 = L9
  if L5 and L5 <= 255 and L6 and L6 <= 255 and L7 and L7 <= 255 and L8 and L8 <= 255 and L4 then
    L9 = table
    L9 = L9.insert
    L10 = L2
    L11 = {}
    L12 = L5 * 256
    L12 = L12 + L6
    L13 = L7 * 256
    L13 = L13 + L8
    L11[1] = L12
    L11[2] = L13
    L9(L10, L11)
    L9 = table
    L9 = L9.insert
    L10 = L2
    L11 = L4
    L9(L10, L11)
    return L2
  end
end
IPv4 = L8
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  A0 = A0 or A0
  L2 = _UPVALUE0_
  L3 = {}
  L4 = FAMILY_INET6
  L3[1] = L4
  L2 = L2(L3)
  L3 = {}
  L5 = A0
  L4 = A0.match
  L6 = "/(.+)"
  L4 = L4(L5, L6)
  L6 = A0
  L5 = A0.gsub
  L7 = "/.+"
  L8 = ""
  L5 = L5(L6, L7, L8)
  A0 = L5
  L6 = A0
  L5 = A0.gsub
  L7 = "^%[(.*)%]$"
  L8 = "%1"
  L5 = L5(L6, L7, L8)
  A0 = L5
  if A1 then
    L6 = L2
    L5 = L2.prefix
    L7 = A1
    L5 = L5(L6, L7)
    L4 = L5
  elseif L4 then
    L5 = tonumber
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    if not L4 or L4 < 0 or 128 < L4 then
      L5 = nil
      return L5
    end
  else
    L4 = 128
  end
  L6 = A0
  L5 = A0.sub
  L7 = 1
  L8 = 1
  L5 = L5(L6, L7, L8)
  if L5 == ":" then
    L5 = 2
    if L5 then
      goto lbl_56
    end
  end
  L5 = 1
  ::lbl_56::
  L6, L7, L8, L9, L10 = nil, nil, nil, nil, nil
  if 45 < L11 then
    return L11
  end
  repeat
    L14 = L5
    L15 = true
    L6 = L11
    if not L6 then
      break
    end
    L14 = L5
    L15 = L6 - 1
    L9 = L11
    if L9 and L9 <= 65535 then
      L3[L11] = L9
    else
      if not L7 then
        if not (1 < L11) then
          goto lbl_94
        end
      end
      do return L11 end
      ::lbl_94::
      L7 = L11 + 1
    end
    L5 = L6 + 1
  until L11 == 7
  L8 = L11
  if 0 < L11 then
    if L11 <= 4 then
      L9 = L11
      if not L9 or 65535 < L9 then
        return L11
      end
      L3[L11] = L9
  end
  elseif 4 < L11 then
    if L11 ~= 7 then
      if not (15 < L11) then
        goto lbl_136
      end
    end
    do return L11 end
    ::lbl_136::
    L5 = 1
    for L14 = L11, L12, L13 do
      L16 = L8
      L15 = L8.find
      L17 = "."
      L18 = L5
      L19 = true
      L15 = L15(L16, L17, L18, L19)
      L6 = L15
      if not L6 and L14 < 4 then
        L15 = nil
        return L15
      end
      L6 = L6 and L6
      L15 = tonumber
      L17 = L8
      L16 = L8.sub
      L18 = L5
      L19 = L6
      L16, L17, L18, L19 = L16(L17, L18, L19)
      L15 = L15(L16, L17, L18, L19)
      L9 = L15
      if not L9 or 255 < L9 then
        L15 = nil
        return L15
      end
      if L14 == 1 or L14 == 3 then
        L15 = #L3
        L15 = L15 + 1
        L16 = L9 * 256
        L3[L15] = L16
      else
        L15 = #L3
        L16 = #L3
        L16 = L3[L16]
        L16 = L16 + L9
        L3[L15] = L16
      end
      L5 = L6 or L5
      if L6 then
        L5 = L6 + 2
      end
    end
  end
  if L7 then
    if L11 == 8 then
      return L11
    end
    while true do
      if not (L11 < 8) then
        break
      end
      L14 = 0
      L11(L12, L13, L14)
    end
  end
  if L11 == 8 and L4 then
    L11(L12, L13)
    L11(L12, L13)
    return L2
  end
end
IPv6 = L8
function L8(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  A2 = A2 ~= nil and A2 or A2
  if A3 == nil then
    L4 = true
    A3 = L4 or A3
    if not L4 then
    end
  end
  if not A1 then
    L4 = _UPVALUE0_
    L5 = A2
    L4 = L4(L5)
    A1 = L4
  end
  L4 = _UPVALUE0_
  L5 = A2
  L4 = L4(L5)
  L5 = ""
  L6 = {}
  L7 = nil
  for L11 = L8, L9, L10 do
    L12 = L5
    L13 = "0"
    L5 = L12 .. L13
  end
  if A3 then
    if L8 then
      for L11 = L8, L9, L10 do
        L12 = L5
        L14 = A0
        L13 = A0.sub
        L15 = L11 - 1
        L16 = L11
        L13 = L13(L14, L15, L16)
        L5 = L12 .. L13
      end
  end
  else
    L5 = L8 .. L9
  end
  A0 = L5
  for L11 = L8, L9, L10 do
    L12 = tonumber
    L14 = A0
    L13 = A0.sub
    L15 = L11
    L16 = L11 + 3
    L13 = L13(L14, L15, L16)
    L14 = 16
    L12 = L12(L13, L14)
    if L12 then
      L13 = #L6
      L13 = L13 + 1
      L6[L13] = L12
    else
      L13 = nil
      return L13
    end
  end
  L11 = L6
  L12 = A1
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  return L8(L9)
end
Hex = L8
L8 = L1.class
L8 = L8()
cidr = L8
L8 = cidr
function L9(A0)
  local L1, L2
  L1 = A0[1]
  L2 = FAMILY_INET4
  L1 = L1 == L2
  return L1
end
L8.is4 = L9
L8 = cidr
function L9(A0)
  local L1, L2
  L1 = A0[1]
  L2 = FAMILY_INET4
  if L1 == L2 then
    L1 = A0[2]
    L1 = L1[1]
    if 2560 <= L1 then
      L1 = A0[2]
      L1 = L1[1]
    end
    L1 = L1 <= 2815
    return L1
  end
  L1 = false
  return L1
end
L8.is4rfc1918 = L9
L8 = cidr
function L9(A0)
  local L1, L2
  L1 = A0[1]
  L2 = FAMILY_INET4
  if L1 == L2 then
    L1 = A0[2]
    L1 = L1[1]
    L1 = L1 == 43518
    return L1
  end
  L1 = false
  return L1
end
L8.is4linklocal = L9
L8 = cidr
function L9(A0)
  local L1, L2
  L1 = A0[1]
  L2 = FAMILY_INET6
  L1 = L1 == L2
  return L1
end
L8.is6 = L9
L8 = cidr
function L9(A0)
  local L1, L2
  L1 = A0[1]
  L2 = FAMILY_INET6
  if L1 == L2 then
    L1 = A0[2]
    L1 = L1[1]
    L1 = 65152 <= L1
    return L1
  end
  L1 = false
  return L1
end
L8.is6linklocal = L9
L8 = cidr
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L3 = A0
  L2 = A0.is4
  L2 = L2(L3)
  if L2 then
    L2 = string
    L2 = L2.format
    L3 = "%d.%d.%d.%d"
    L4 = _UPVALUE0_
    L4 = L4.rshift
    L5 = A0[2]
    L5 = L5[1]
    L6 = 8
    L4 = L4(L5, L6)
    L5 = _UPVALUE0_
    L5 = L5.band
    L6 = A0[2]
    L6 = L6[1]
    L7 = 255
    L5 = L5(L6, L7)
    L6 = _UPVALUE0_
    L6 = L6.rshift
    L7 = A0[2]
    L7 = L7[2]
    L8 = 8
    L6 = L6(L7, L8)
    L7 = _UPVALUE0_
    L7 = L7.band
    L8 = A0[2]
    L8 = L8[2]
    L9 = 255
    L7, L8, L9 = L7(L8, L9)
    L2 = L2(L3, L4, L5, L6, L7, L8, L9)
    L1 = L2
    L2 = A0[3]
    if L2 < 32 then
      L2 = L1
      L3 = "/"
      L4 = A0[3]
      L1 = L2 .. L3 .. L4
    end
  else
    L3 = A0
    L2 = A0.is6
    L2 = L2(L3)
    if L2 then
      L2 = string
      L2 = L2.format
      L3 = "%X:%X:%X:%X:%X:%X:%X:%X"
      L4 = unpack
      L5 = A0[2]
      L4, L5, L6, L7, L8, L9 = L4(L5)
      L2 = L2(L3, L4, L5, L6, L7, L8, L9)
      L1 = L2
      L2 = A0[3]
      if L2 < 128 then
        L2 = L1
        L3 = "/"
        L4 = A0[3]
        L1 = L2 .. L3 .. L4
      end
    end
  end
  return L1
end
L8.string = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = assert
  L3 = L3 == L4
  L2(L3, L4)
  L2 = nil
  for L6 = L3, L4, L5 do
    L7 = A0[2]
    L7 = L7[L6]
    L8 = A1[2]
    L8 = L8[L6]
    if L7 ~= L8 then
      L7 = A0[2]
      L7 = L7[L6]
      L8 = A1[2]
      L8 = L8[L6]
      L7 = L7 < L8
      return L7
    end
  end
  return L3
end
L8.lower = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = assert
  L3 = L3 == L4
  L2(L3, L4)
  L2 = nil
  for L6 = L3, L4, L5 do
    L7 = A0[2]
    L7 = L7[L6]
    L8 = A1[2]
    L8 = L8[L6]
    if L7 ~= L8 then
      L7 = A0[2]
      L7 = L7[L6]
      L8 = A1[2]
      L8 = L8[L6]
      L7 = L7 > L8
      return L7
    end
  end
  return L3
end
L8.higher = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = assert
  L3 = L3 == L4
  L2(L3, L4)
  L2 = nil
  for L6 = L3, L4, L5 do
    L7 = A0[2]
    L7 = L7[L6]
    L8 = A1[2]
    L8 = L8[L6]
    if L7 ~= L8 then
      L7 = false
      return L7
    end
  end
  return L3
end
L8.equal = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = A0[3]
  if A1 then
    L2 = 0
    L3 = false
    L4 = type
    L5 = A1
    L4 = L4(L5)
    if L4 ~= "table" then
      L5 = A0
      L4 = A0.is4
      L4 = L4(L5)
      if L4 then
        L4 = IPv4
        L5 = A1
        L4 = L4(L5)
        if L4 then
          goto lbl_26
        end
      end
      L4 = IPv6
      L5 = A1
      L4 = L4(L5)
      if L4 then
        goto lbl_26
      end
    end
    L4 = A1
    ::lbl_26::
    if not L4 then
      L5 = nil
      return L5
    end
    L5, L6 = nil, nil
    for L10, L11 in L7, L8, L9 do
      if L11 == 65535 then
        L2 = L2 + 16
      else
        L12 = _UPVALUE0_
        L12 = L12.lshift
        L13 = 1
        L14 = 15
        L12 = L12(L13, L14)
        while true do
          L13 = _UPVALUE0_
          L13 = L13.band
          L14 = L11
          L15 = L12
          L13 = L13(L14, L15)
          if L13 ~= L12 then
            goto lbl_63
          end
          L2 = L2 + 1
          L13 = _UPVALUE0_
          L13 = L13.lshift
          L14 = 1
          L15 = L2 % 16
          L15 = 15 - L15
          L13 = L13(L14, L15)
          L12 = L13
        end
        break
      end
    end
  end
  ::lbl_63::
  return L2
end
L8.prefix = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = {}
  A1 = A1 or A1
  L3 = nil
  for L7 = L4, L5, L6 do
    L8 = #L2
    L8 = L8 + 1
    L9 = A0[2]
    L9 = L9[L7]
    L2[L8] = L9
  end
  if L4 < L5 then
    L7 = #L2
    L7 = 1 + L7
    L7 = _UPVALUE1_
    L8 = A1
    L7, L8, L9 = L7(L8)
    L2[L4] = L5
    for L7 = L4, L5, L6 do
      L8 = #L2
      L8 = L8 + 1
      L2[L8] = 0
    end
  end
  L7 = L2
  L8 = _UPVALUE3_
  L9 = A0[1]
  L8, L9 = L8(L9)
  L5[1] = L6
  L5[2] = L7
  L5[3] = L8
  L5[4] = L9
  return L4(L5)
end
L8.network = L9
L8 = cidr
function L9(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = {}
  L3 = A0[1]
  L4 = A0[2]
  L5 = _UPVALUE1_
  L6 = A0[1]
  L5, L6 = L5(L6)
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  return L1(L2)
end
L8.host = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = {}
  A1 = A1 or A1
  for L6 = L3, L4, L5 do
    L7 = #L2
    L7 = L7 + 1
    L2[L7] = 65535
  end
  if L3 < L4 then
    L2[L3] = L4
    for L6 = L3, L4, L5 do
      L7 = #L2
      L7 = L7 + 1
      L2[L7] = 0
    end
  end
  L6 = L2
  L7 = _UPVALUE2_
  L8 = A0[1]
  L7, L8 = L7(L8)
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  return L3(L4)
end
L8.mask = L9
L8 = cidr
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = A0[1]
  L2 = FAMILY_INET4
  if L1 == L2 then
    L1 = {}
    L2 = unpack
    L2, L6, L7, L8 = L2(L3)
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L1[5] = L6
    L1[6] = L7
    L1[7] = L8
    L2 = math
    L2 = L2.floor
    L2 = L2(L3)
    L2 = L2 + 1
    if L2 <= L3 then
      L6 = A0[3]
      L6, L7, L8 = L5(L6)
      L1[L2] = L3
      for L6 = L3, L4, L5 do
        L1[L6] = 65535
      end
      L6 = L1
      L7 = _UPVALUE3_
      L8 = A0[1]
      L7, L8 = L7(L8)
      L4[1] = L5
      L4[2] = L6
      L4[3] = L7
      L4[4] = L8
      return L3(L4)
    end
  end
end
L8.broadcast = L9
L8 = cidr
function L9(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = assert
  L3 = A0[1]
  L4 = A1[1]
  L3 = L3 == L4
  L4 = "Can't compare IPv4 and IPv6 addresses"
  L2(L3, L4)
  L3 = A0
  L2 = A0.prefix
  L2 = L2(L3)
  L4 = A1
  L3 = A1.prefix
  L3 = L3(L4)
  if L2 <= L3 then
    L3 = A0
    L2 = A0.network
    L2 = L2(L3)
    L4 = A1
    L3 = A1.network
    L6 = A0
    L5 = A0.prefix
    L5, L6 = L5(L6)
    L3 = L3(L4, L5, L6)
    L2 = L2 == L3
    return L2
  end
  L2 = false
  return L2
end
L8.contains = L9
L8 = cidr
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = {}
  L5 = unpack
  L5, L9, L10, L11, L12, L13 = L5(L6)
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  L4[7] = L11
  L4[8] = L12
  L4[9] = L13
  L5 = _UPVALUE0_
  L5 = L5(L6, L7)
  for L9 = L6, L7, L8 do
    L10 = #L5
    if 0 < L10 then
      L10 = table
      L10 = L10.remove
      L11 = L5
      L12 = #L5
      L10 = L10(L11, L12)
      if L10 then
        goto lbl_25
      end
    end
    L10 = 0
    ::lbl_25::
    L11 = L4[L9]
    L11 = L11 + L10
    if 65535 < L11 then
      L11 = L4[L9]
      L11 = L11 + L10
      L11 = L11 % 65535
      L4[L9] = L11
      if 1 < L9 then
        L11 = L9 - 1
        L12 = L9 - 1
        L12 = L4[L12]
        L13 = L4[L9]
        L13 = L10 - L13
        L12 = L12 + L13
        L4[L11] = L12
      else
        L11 = nil
        return L11
      end
    else
      L11 = L4[L9]
      L11 = L11 + L10
      L4[L9] = L11
    end
  end
  if A2 then
    A0[2] = L4
    return A0
  else
    L9 = L4
    L10 = A0[3]
    L7[1] = L8
    L7[2] = L9
    L7[3] = L10
    return L6(L7)
  end
end
L8.add = L9
L8 = cidr
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = {}
  L5 = unpack
  L5, L9, L10, L11, L12, L13 = L5(L6)
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  L4[7] = L11
  L4[8] = L12
  L4[9] = L13
  L5 = _UPVALUE0_
  L5 = L5(L6, L7)
  for L9 = L6, L7, L8 do
    L10 = #L5
    if 0 < L10 then
      L10 = table
      L10 = L10.remove
      L11 = L5
      L12 = #L5
      L10 = L10(L11, L12)
      if L10 then
        goto lbl_25
      end
    end
    L10 = 0
    ::lbl_25::
    L11 = L4[L9]
    L11 = L11 - L10
    if L11 < 0 then
      L11 = L4[L9]
      L11 = L10 - L11
      L11 = L11 % 65535
      L4[L9] = L11
      if 1 < L9 then
        L11 = L9 - 1
        L12 = L9 - 1
        L12 = L4[L12]
        L13 = L4[L9]
        L13 = L10 + L13
        L12 = L12 - L13
        L4[L11] = L12
      else
        L11 = nil
        return L11
      end
    else
      L11 = L4[L9]
      L11 = L11 - L10
      L4[L9] = L11
    end
  end
  if A2 then
    A0[2] = L4
    return A0
  else
    L9 = L4
    L10 = A0[3]
    L7[1] = L8
    L7[2] = L9
    L7[3] = L10
    return L6(L7)
  end
end
L8.sub = L9
L8 = cidr
function L9(A0)
  local L1, L2, L3, L4
  L1 = A0[3]
  L2 = _UPVALUE0_
  L3 = A0[1]
  L2 = L2(L3)
  if L1 <= L2 then
    L2 = A0
    L1 = A0.network
    L1 = L1(L2)
    L2 = L1
    L1 = L1.add
    L3 = 1
    L4 = true
    return L1(L2, L3, L4)
  end
end
L8.minhost = L9
L8 = cidr
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = A0[3]
  L2 = _UPVALUE0_
  L3 = A0[1]
  L2 = L2(L3)
  if L1 <= L2 then
    L1 = nil
    L2 = {}
    L3 = unpack
    L3, L7, L8, L9 = L3(L4)
    L2[1] = L3
    L2[2] = L4
    L2[3] = L5
    L2[4] = L6
    L2[5] = L7
    L2[6] = L8
    L2[7] = L9
    L3 = math
    L3 = L3.floor
    L3 = L3(L4)
    L3 = L3 + 1
    L7 = A0[3]
    L7, L8, L9 = L6(L7)
    L2[L3] = L4
    for L7 = L4, L5, L6 do
      L2[L7] = 65535
    end
    L7 = L2
    L8 = _UPVALUE4_
    L9 = A0[1]
    L8, L9 = L8(L9)
    L5[1] = L6
    L5[2] = L7
    L5[3] = L8
    L5[4] = L9
    L2 = L4
    if L4 == L5 then
      L7 = true
      L4(L5, L6, L7)
    end
    return L2
  end
end
L8.maxhost = L9
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L2 = A0
  L1 = A0.match
  L3 = "^(%d+).(%d+).(%d+).(%d+)"
  L1, L2, L3, L4 = L1(L2, L3)
  L5 = _UPVALUE0_
  L5 = L5.lshift
  L6 = L1
  L7 = 24
  L5 = L5(L6, L7)
  L6 = _UPVALUE0_
  L6 = L6.lshift
  L7 = L2
  L8 = 16
  L6 = L6(L7, L8)
  L5 = L5 + L6
  L6 = _UPVALUE0_
  L6 = L6.lshift
  L7 = L3
  L8 = 8
  L6 = L6(L7, L8)
  L5 = L5 + L6
  L5 = L5 + L4
  return L5
end
iptonl = L8
function L8(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = iptonl
  L2 = A0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.band
  L3 = _UPVALUE0_
  L3 = L3.bnot
  L4 = L1
  L3 = L3(L4)
  L4 = tonumber
  L5 = "FFFFFFFF"
  L6 = 16
  L4, L5, L6 = L4(L5, L6)
  return L2(L3, L4, L5, L6)
end
ipnot = L8
