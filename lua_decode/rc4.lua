local L0, L1, L2, L3, L4, L5, L6, L7
L0 = require
L1 = "string"
L0 = L0(L1)
L1 = require
L2 = "bit"
L1 = L1(L2)
L2 = module
L3 = "rc4"
L2(L3)
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = A0.schedule
  L2 = A0.i
  L1 = L1[L2]
  L2 = A0.schedule
  L3 = A0.i
  L4 = A0.schedule
  L5 = A0.j
  L4 = L4[L5]
  L2[L3] = L4
  L2 = A0.schedule
  L3 = A0.j
  L2[L3] = L1
end
function L3(A0, A1, A2)
  local L3, L4
  L3 = A0[A1]
  L4 = A0[A2]
  A0[A1] = L4
  A0[A2] = L3
end
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = _UPVALUE0_
  L1 = L1.len
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.byte
  L3, L8, L9, L10, L11, L12 = L3(L4, L5, L6)
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L2[6] = L8
  L2[7] = L9
  L2[8] = L10
  L2[9] = L11
  L2[10] = L12
  if L1 < 1 or 256 < L1 then
    L3 = error
    L3(L4)
  end
  L3 = {}
  for L7 = L4, L5, L6 do
    L3[L7] = L7
  end
  for L8 = L5, L6, L7 do
    L9 = L3[L8]
    L9 = L4 + L9
    L10 = L8 % L1
    L10 = L10 + 1
    L10 = L2[L10]
    L9 = L9 + L10
    L9 = _UPVALUE1_
    L10 = L3
    L11 = L8
    L12 = L4
    L9(L10, L11, L12)
  end
  return L3
end
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = {}
  for L6 = L3, L4, L5 do
    L7 = A0.i
    L7 = L7 + 1
    L7 = L7 % 256
    A0.i = L7
    L7 = A0.j
    L8 = A0.schedule
    L9 = A0.i
    L9 = L9 - 1
    L8 = L8[L9]
    L7 = L7 + L8
    L7 = L7 % 256
    A0.j = L7
    L7 = _UPVALUE0_
    L8 = A0
    L7(L8)
    L7 = #L2
    L7 = L7 + 1
    L8 = A0.schedule
    L9 = A0.schedule
    L10 = A0.i
    L10 = L10 - 1
    L9 = L9[L10]
    L10 = A0.schedule
    L11 = A0.j
    L11 = L11 - 1
    L10 = L10[L11]
    L9 = L9 + L10
    L9 = L9 - 1
    L9 = L9 % 256
    L8 = L8[L9]
    L2[L7] = L8
  end
  return L2
end
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = _UPVALUE0_
  L2 = L2.len
  L3 = A0
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L4 = A1
  L3 = L3(L4, L5)
  L4 = ""
  for L8 = L5, L6, L7 do
    L9 = L4
    L10 = _UPVALUE0_
    L10 = L10.char
    L11 = _UPVALUE2_
    L11 = L11.bxor
    L12 = L3[L8]
    L13 = _UPVALUE0_
    L13 = L13.byte
    L14 = A0
    L15 = L8
    L13, L14, L15 = L13(L14, L15)
    L11, L12, L13, L14, L15 = L11(L12, L13, L14, L15)
    L10 = L10(L11, L12, L13, L14, L15)
    L4 = L9 .. L10
  end
  return L4
end
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  L3 = 0
  L4 = 0
  L5 = {}
  L5.i = L3
  L5.j = L4
  L5.schedule = L2
  L6 = {}
  L7 = "decrypt"
  if A1 then
    L7 = "encrypt"
  end
  function L8(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = A0
    L3 = _UPVALUE1_
    L1 = L1(L2, L3)
    return L1
  end
  L6[L7] = L8
  return L6
end
new = L7
