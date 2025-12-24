local L0, L1, L2, L3
L0 = module
L1 = "aeslua.gf"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "bit"
L0 = L0(L1)
L1 = {}
L2 = {}
L3 = aeslua
L3.gf = L2
L1.n = 256
L1.ord = 255
L1.irrPolynom = 283
L3 = {}
L1.exp = L3
L3 = {}
L1.log = L3
function L3(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.bxor
  L3 = A0
  L4 = A1
  return L2(L3, L4)
end
L2.add = L3
function L3(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.bxor
  L3 = A0
  L4 = A1
  return L2(L3, L4)
end
L2.sub = L3
function L3(A0)
  local L1, L2
  if A0 == 1 then
    L1 = 1
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.ord
  L2 = _UPVALUE0_
  L2 = L2.log
  L2 = L2[A0]
  L1 = L1 - L2
  L2 = _UPVALUE0_
  L2 = L2.exp
  L2 = L2[L1]
  return L2
end
L2.invert = L3
function L3(A0, A1)
  local L2, L3
  if A0 == 0 or A1 == 0 then
    L2 = 0
    return L2
  end
  L2 = _UPVALUE0_
  L2 = L2.log
  L2 = L2[A0]
  L3 = _UPVALUE0_
  L3 = L3.log
  L3 = L3[A1]
  L2 = L2 + L3
  L3 = _UPVALUE0_
  L3 = L3.ord
  if L2 >= L3 then
    L3 = _UPVALUE0_
    L3 = L3.ord
    L2 = L2 - L3
  end
  L3 = _UPVALUE0_
  L3 = L3.exp
  L3 = L3[L2]
  return L3
end
L2.mul = L3
function L3(A0, A1)
  local L2, L3
  if A0 == 0 then
    L2 = 0
    return L2
  end
  L2 = _UPVALUE0_
  L2 = L2.log
  L2 = L2[A0]
  L3 = _UPVALUE0_
  L3 = L3.log
  L3 = L3[A1]
  L2 = L2 - L3
  if L2 < 0 then
    L3 = _UPVALUE0_
    L3 = L3.ord
    L2 = L2 + L3
  end
  L3 = _UPVALUE0_
  L3 = L3.exp
  L3 = L3[L2]
  return L3
end
L2.div = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  for L3 = L0, L1, L2 do
    L4 = print
    L5 = "log("
    L6 = L3 - 1
    L7 = ")="
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = L3 - 1
    L8 = L8[L9]
    L4(L5, L6, L7, L8)
  end
end
L2.printLog = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  for L3 = L0, L1, L2 do
    L4 = print
    L5 = "exp("
    L6 = L3 - 1
    L7 = ")="
    L8 = _UPVALUE0_
    L8 = L8.exp
    L9 = L3 - 1
    L8 = L8[L9]
    L4(L5, L6, L7, L8)
  end
end
L2.printExp = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = 1
  for L4 = L1, L2, L3 do
    L5 = _UPVALUE0_
    L5 = L5.exp
    L5[L4] = L0
    L5 = _UPVALUE0_
    L5 = L5.log
    L5[L0] = L4
    L5 = _UPVALUE1_
    L5 = L5.bxor
    L6 = _UPVALUE1_
    L6 = L6.lshift
    L7 = L0
    L8 = 1
    L6 = L6(L7, L8)
    L7 = L0
    L5 = L5(L6, L7)
    L0 = L5
    L5 = _UPVALUE0_
    L5 = L5.ord
    if L0 > L5 then
      L5 = _UPVALUE2_
      L5 = L5.sub
      L6 = L0
      L7 = _UPVALUE0_
      L7 = L7.irrPolynom
      L5 = L5(L6, L7)
      L0 = L5
    end
  end
end
L1.initMulTable = L3
L3 = L1.initMulTable
L3()
return L2
