local L0, L1, L2, L3
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = module
L2 = "luci.config"
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = pcall
  L2 = require
  L3 = "luci.model.uci"
  L1 = L1(L2, L3)
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.threadlocal
    L1 = L1()
    L2 = setmetatable
    L3 = A0
    L4 = {}
    function L5(A0, A1)
      local L2, L3, L4, L5, L6
      L2 = _UPVALUE0_
      L2 = L2[A1]
      if not L2 then
        L2 = _UPVALUE0_
        L3 = luci
        L3 = L3.model
        L3 = L3.uci
        L3 = L3.cursor
        L3 = L3()
        L4 = L3
        L3 = L3.get_all
        L5 = "luci"
        L6 = A1
        L3 = L3(L4, L5, L6)
        L2[A1] = L3
      end
      L2 = _UPVALUE0_
      L2 = L2[A1]
      return L2
    end
    L4.__index = L5
    L2(L3, L4)
  end
end
L1(L2, L3)
