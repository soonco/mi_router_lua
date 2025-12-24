local L0, L1
L0 = require
L1 = "logging"
L0 = L0(L1)
function L1(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.new
  function L2(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9
    L3 = io
    L3 = L3.stdout
    L4 = L3
    L3 = L3.write
    L5 = _UPVALUE0_
    L5 = L5.prepareLogMsg
    L6 = _UPVALUE1_
    L7 = os
    L7 = L7.date
    L7 = L7()
    L8 = A1
    L9 = A2
    L5, L6, L7, L8, L9 = L5(L6, L7, L8, L9)
    L3(L4, L5, L6, L7, L8, L9)
    L3 = true
    return L3
  end
  return L1(L2)
end
L0.console = L1
L1 = L0.console
return L1
