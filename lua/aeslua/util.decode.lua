local L0, L1, L2, L3
L0 = module
L1 = "aeslua.util"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "bit"
L0 = L0(L1)
L1 = {}
L2 = {}
L3 = aeslua
L3.util = L1
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.bxor
  L2 = A0
  L3 = _UPVALUE0_
  L3 = L3.rshift
  L4 = A0
  L5 = 4
  L3, L4, L5 = L3(L4, L5)
  L1 = L1(L2, L3, L4, L5)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.bxor
  L2 = A0
  L3 = _UPVALUE0_
  L3 = L3.rshift
  L4 = A0
  L5 = 2
  L3, L4, L5 = L3(L4, L5)
  L1 = L1(L2, L3, L4, L5)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.bxor
  L2 = A0
  L3 = _UPVALUE0_
  L3 = L3.rshift
  L4 = A0
  L5 = 1
  L3, L4, L5 = L3(L4, L5)
  L1 = L1(L2, L3, L4, L5)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = A0
  L3 = 1
  return L1(L2, L3)
end
L1.byteParity = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  if A1 == 0 then
    L2 = _UPVALUE0_
    L2 = L2.band
    L3 = A0
    L4 = 255
    return L2(L3, L4)
  else
    L2 = _UPVALUE0_
    L2 = L2.band
    L3 = _UPVALUE0_
    L3 = L3.rshift
    L4 = A0
    L5 = A1 * 8
    L3 = L3(L4, L5)
    L4 = 255
    return L2(L3, L4)
  end
end
L1.getByte = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  if A1 == 0 then
    L2 = _UPVALUE0_
    L2 = L2.band
    L3 = A0
    L4 = 255
    return L2(L3, L4)
  else
    L2 = _UPVALUE0_
    L2 = L2.lshift
    L3 = _UPVALUE0_
    L3 = L3.band
    L4 = A0
    L5 = 255
    L3 = L3(L4, L5)
    L4 = A1 * 8
    return L2(L3, L4)
  end
end
L1.putByte = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = {}
  for L7 = L4, L5, L6 do
    L8 = _UPVALUE0_
    L8 = L8.putByte
    L9 = L7 * 4
    L9 = A1 + L9
    L9 = A0[L9]
    L10 = 3
    L8 = L8(L9, L10)
    L9 = _UPVALUE0_
    L9 = L9.putByte
    L10 = L7 * 4
    L10 = A1 + L10
    L10 = L10 + 1
    L10 = A0[L10]
    L11 = 2
    L9 = L9(L10, L11)
    L8 = L8 + L9
    L9 = _UPVALUE0_
    L9 = L9.putByte
    L10 = L7 * 4
    L10 = A1 + L10
    L10 = L10 + 2
    L10 = A0[L10]
    L11 = 1
    L9 = L9(L10, L11)
    L8 = L8 + L9
    L9 = _UPVALUE0_
    L9 = L9.putByte
    L10 = L7 * 4
    L10 = A1 + L10
    L10 = L10 + 3
    L10 = A0[L10]
    L11 = 0
    L9 = L9(L10, L11)
    L8 = L8 + L9
    L3[L7] = L8
  end
  return L3
end
L1.bytesToInts = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  A3 = A3 or A3
  for L7 = L4, L5, L6 do
    for L11 = L8, L9, L10 do
      L12 = L7 * 4
      L12 = A2 + L12
      L13 = 3 - L11
      L12 = L12 + L13
      L13 = _UPVALUE0_
      L13 = L13.getByte
      L14 = A0[L7]
      L15 = L11
      L13 = L13(L14, L15)
      A1[L12] = L13
    end
  end
  return A1
end
L1.intsToBytes = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = ""
  for L5, L6 in L2, L3, L4 do
    L7 = L1
    L8 = string
    L8 = L8.format
    L9 = "%02x "
    L10 = L6
    L8 = L8(L9, L10)
    L1 = L7 .. L8
  end
  return L1
end
L2.bytesToHex = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "number" then
    L2 = string
    L2 = L2.format
    L3 = "%08x"
    L4 = A0
    return L2(L3, L4)
  elseif L1 == "table" then
    L2 = _UPVALUE0_
    L2 = L2.bytesToHex
    L3 = A0
    return L2(L3)
  elseif L1 == "string" then
    L2 = {}
    L3 = string
    L3 = L3.byte
    L4 = A0
    L5 = 1
    L6 = #A0
    L3, L4, L5, L6 = L3(L4, L5, L6)
    L2[1] = L3
    L2[2] = L4
    L2[3] = L5
    L2[4] = L6
    L3 = _UPVALUE0_
    L3 = L3.bytesToHex
    L4 = L2
    return L3(L4)
  else
    return A0
  end
end
L1.toHexString = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = #A0
  L2 = math
  L2 = L2.random
  L3 = 0
  L4 = 255
  L2 = L2(L3, L4)
  L3 = math
  L3 = L3.random
  L4 = 0
  L5 = 255
  L3 = L3(L4, L5)
  L4 = string
  L4 = L4.char
  L5 = L2
  L6 = L3
  L10 = L1
  L11 = 3
  L10 = _UPVALUE0_
  L10 = L10.getByte
  L11 = L1
  L12 = 2
  L10 = L10(L11, L12)
  L11 = _UPVALUE0_
  L11 = L11.getByte
  L12 = L1
  L13 = 1
  L11 = L11(L12, L13)
  L12 = _UPVALUE0_
  L12 = L12.getByte
  L13 = L1
  L14 = 0
  L12, L13, L14, L15 = L12(L13, L14)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L5 = L4
  L6 = A0
  A0 = L5 .. L6
  L5 = math
  L5 = L5.ceil
  L6 = #A0
  L6 = L6 / 16
  L5 = L5(L6)
  L5 = L5 * 16
  L6 = #A0
  L5 = L5 - L6
  L6 = ""
  for L10 = L7, L8, L9 do
    L11 = L6
    L12 = string
    L12 = L12.char
    L13 = math
    L13 = L13.random
    L14 = 0
    L15 = 255
    L13, L14, L15 = L13(L14, L15)
    L12 = L12(L13, L14, L15)
    L6 = L11 .. L12
  end
  return L7
end
L1.padByteString = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = {}
  L2 = string
  L2 = L2.byte
  L3 = A0
  L4 = 1
  L5 = 4
  L2, L3, L4, L5 = L2(L3, L4, L5)
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L2 = L1[1]
  L3 = L1[3]
  if L2 == L3 then
    L2 = L1[2]
    L3 = L1[4]
    if L2 == L3 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
L2.properlyDecrypted = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.properlyDecrypted
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.putByte
  L2 = string
  L2 = L2.byte
  L3 = A0
  L4 = 5
  L2 = L2(L3, L4)
  L3 = 3
  L1 = L1(L2, L3)
  L2 = _UPVALUE1_
  L2 = L2.putByte
  L3 = string
  L3 = L3.byte
  L4 = A0
  L5 = 6
  L3 = L3(L4, L5)
  L4 = 2
  L2 = L2(L3, L4)
  L1 = L1 + L2
  L2 = _UPVALUE1_
  L2 = L2.putByte
  L3 = string
  L3 = L3.byte
  L4 = A0
  L5 = 7
  L3 = L3(L4, L5)
  L4 = 1
  L2 = L2(L3, L4)
  L1 = L1 + L2
  L2 = _UPVALUE1_
  L2 = L2.putByte
  L3 = string
  L3 = L3.byte
  L4 = A0
  L5 = 8
  L3 = L3(L4, L5)
  L4 = 0
  L2 = L2(L3, L4)
  L1 = L1 + L2
  L2 = string
  L2 = L2.sub
  L3 = A0
  L4 = 9
  L5 = 8 + L1
  return L2(L3, L4, L5)
end
L1.unpadByteString = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  for L5 = L2, L3, L4 do
    L6 = _UPVALUE0_
    L6 = L6.bxor
    L7 = A0[L5]
    L8 = A1[L5]
    L6 = L6(L7, L8)
    A0[L5] = L6
  end
end
L1.xorIV = L3
return L1
