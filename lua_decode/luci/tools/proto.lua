local L0, L1, L2
L0 = module
L1 = "luci.tools.proto"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = luci
  L3 = L3.cbi
  L3 = L3.Value
  L5 = A0
  L4 = A0.taboption
  L6 = "advanced"
  L7 = L3
  L8 = "macaddr"
  L9 = ...
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = A1 or L5
  if A1 then
    L6 = A1
    L5 = A1.mac
    L5 = L5(L6)
  end
  L4.placeholder = L5
  L4.datatype = "macaddr"
  function L5(A0, A1)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    if L2 then
      L2 = _UPVALUE0_
      L3 = L2
      L2 = L2.get_wifinet
      L2 = L2(L3)
    end
    if L2 then
      L4 = L2
      L3 = L2.get
      L5 = "macaddr"
      return L3(L4, L5)
    else
      L3 = _UPVALUE1_
      L3 = L3.cfgvalue
      L4 = A0
      L5 = A1
      return L3(L4, L5)
    end
  end
  L4.cfgvalue = L5
  function L5(A0, A1, A2)
    local L3, L4, L5, L6, L7
    L3 = _UPVALUE0_
    if L3 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.get_wifinet
      L3 = L3(L4)
    end
    if L3 then
      L5 = L3
      L4 = L3.set
      L6 = "macaddr"
      L7 = A2
      L4(L5, L6, L7)
    elseif A2 then
      L4 = _UPVALUE1_
      L4 = L4.write
      L5 = A0
      L6 = A1
      L7 = A2
      L4(L5, L6, L7)
    else
      L4 = _UPVALUE1_
      L4 = L4.remove
      L5 = A0
      L6 = A1
      L4(L5, L6)
    end
  end
  L4.write = L5
  function L5(A0, A1)
    local L2, L3, L4, L5
    L3 = A0
    L2 = A0.write
    L4 = A1
    L5 = nil
    L2(L3, L4, L5)
  end
  L4.remove = L5
end
opt_macaddr = L0
