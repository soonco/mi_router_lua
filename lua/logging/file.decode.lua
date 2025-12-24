local L0, L1, L2, L3, L4
L0 = require
L1 = "logging"
L0 = L0(L1)
L1, L2 = nil, nil
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = string
  L2 = L2.format
  L3 = A0
  L4 = os
  L4 = L4.date
  L5 = A1
  L4, L5, L6, L7 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = _UPVALUE0_
  if L3 ~= L2 then
    L3 = io
    L3 = L3.open
    L4 = L2
    L5 = "a"
    L3 = L3(L4, L5)
    if L3 then
      L5 = L3
      L4 = L3.setvbuf
      L6 = "line"
      L4(L5, L6)
      _UPVALUE0_ = L2
      _UPVALUE1_ = L3
      return L3
    else
      L4 = nil
      L5 = string
      L5 = L5.format
      L6 = "file `%s' could not be opened for writing"
      L7 = L2
      L5, L6, L7 = L5(L6, L7)
      return L4, L5, L6, L7
    end
  else
    L3 = _UPVALUE1_
    return L3
  end
end
function L4(A0, A1, A2)
  local L3, L4
  L3 = type
  L4 = A0
  L3 = L3(L4)
  if L3 ~= "string" then
    A0 = "lualogging.log"
  end
  L3 = _UPVALUE0_
  L3 = L3.new
  function L4(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9
    L3 = _UPVALUE0_
    L4 = _UPVALUE1_
    L5 = _UPVALUE2_
    L3, L4 = L3(L4, L5)
    if not L3 then
      L5 = nil
      L6 = L4
      return L5, L6
    end
    L5 = _UPVALUE3_
    L5 = L5.prepareLogMsg
    L6 = _UPVALUE4_
    L7 = os
    L7 = L7.date
    L7 = L7()
    L8 = A1
    L9 = A2
    L5 = L5(L6, L7, L8, L9)
    L7 = L3
    L6 = L3.write
    L8 = L5
    L6(L7, L8)
    L6 = true
    return L6
  end
  return L3(L4)
end
L0.file = L4
L4 = L0.file
return L4
