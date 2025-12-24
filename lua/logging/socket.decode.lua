local L0, L1, L2
L0 = require
L1 = "logging"
L0 = L0(L1)
L1 = require
L2 = "socket"
L1 = L1(L2)
function L2(A0, A1, A2)
  local L3, L4
  L3 = _UPVALUE0_
  L3 = L3.new
  function L4(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9
    L3 = _UPVALUE0_
    L3 = L3.prepareLogMsg
    L4 = _UPVALUE1_
    L5 = os
    L5 = L5.date
    L5 = L5()
    L6 = A1
    L7 = A2
    L3 = L3(L4, L5, L6, L7)
    L4 = _UPVALUE2_
    L4 = L4.connect
    L5 = _UPVALUE3_
    L6 = _UPVALUE4_
    L4, L5 = L4(L5, L6)
    if not L4 then
      L6 = nil
      L7 = L5
      return L6, L7
    end
    L7 = L4
    L6 = L4.send
    L8 = L3
    L6, L7 = L6(L7, L8)
    if not L6 then
      L8 = nil
      L9 = L7
      return L8, L9
    end
    L9 = L4
    L8 = L4.close
    L8(L9)
    L8 = true
    return L8
  end
  return L3(L4)
end
L0.socket = L2
L2 = L0.socket
return L2
