local L0, L1, L2
L0 = module
L1 = "aeslua.buffer"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = {}
L1 = aeslua
L1.buffer = L0
function L1()
  local L0, L1
  L0 = {}
  return L0
end
L0.new = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2(L3, L4)
  for L5 = L2, L3, L4 do
    L6 = A0[L5]
    L6 = #L6
    L7 = L5 + 1
    L7 = A0[L7]
    L7 = #L7
    if L6 > L7 then
      break
    end
    L6 = A0[L5]
    L7 = table
    L7 = L7.remove
    L8 = A0
    L7 = L7(L8)
    L6 = L6 .. L7
    A0[L5] = L6
  end
end
L0.addString = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  for L4 = L1, L2, L3 do
    L5 = A0[L4]
    L6 = table
    L6 = L6.remove
    L7 = A0
    L6 = L6(L7)
    L5 = L5 .. L6
    A0[L4] = L5
  end
  return L1
end
L0.toString = L1
return L0
