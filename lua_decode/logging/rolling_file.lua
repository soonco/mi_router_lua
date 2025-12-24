local L0, L1, L2, L3, L4
L0 = require
L1 = "logging"
L0 = L0(L1)
function L1(A0)
  local L1, L2, L3, L4
  L1 = io
  L1 = L1.open
  L2 = A0.filename
  L3 = "a"
  L1 = L1(L2, L3)
  A0.file = L1
  L1 = A0.file
  if not L1 then
    L1 = nil
    L2 = string
    L2 = L2.format
    L3 = "file `%s' could not be opened for writing"
    L4 = A0.filename
    L2, L3, L4 = L2(L3, L4)
    return L1, L2, L3, L4
  end
  L1 = A0.file
  L2 = L1
  L1 = L1.setvbuf
  L3 = "line"
  L1(L2, L3)
  L1 = A0.file
  return L1
end
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  for L4 = L1, L2, L3 do
    L5 = os
    L5 = L5.rename
    L6 = A0.filename
    L7 = "."
    L8 = L4
    L6 = L6 .. L7 .. L8
    L7 = A0.filename
    L8 = "."
    L9 = L4 + 1
    L7 = L7 .. L8 .. L9
    L5(L6, L7)
  end
  L1(L2)
  A0.file = nil
  L4 = "."
  L5 = "1"
  if L2 then
    L4 = string
    L4 = L4.format
    L5 = "error %s on log rollover"
    L6 = L2
    L4, L5, L6, L7, L8, L9 = L4(L5, L6)
    return L3, L4, L5, L6, L7, L8, L9
  end
  L4 = A0
  return L3(L4)
end
function L3(A0)
  local L1, L2, L3, L4
  L1 = A0.file
  if not L1 then
    L1 = _UPVALUE0_
    L2 = A0
    return L1(L2)
  end
  L1 = A0.file
  L2 = L1
  L1 = L1.seek
  L3 = "end"
  L4 = 0
  L1 = L1(L2, L3, L4)
  L2 = A0.maxSize
  if L1 < L2 then
    L2 = A0.file
    return L2
  end
  L2 = _UPVALUE1_
  L3 = A0
  return L2(L3)
end
function L4(A0, A1, A2, A3)
  local L4, L5, L6
  L4 = type
  L5 = A0
  L4 = L4(L5)
  if L4 ~= "string" then
    A0 = "lualogging.log"
  end
  L4 = {}
  L4.filename = A0
  L4.maxSize = A1
  L5 = A2 or L5
  if not A2 then
    L5 = 1
  end
  L4.maxIndex = L5
  L5 = _UPVALUE0_
  L5 = L5.new
  function L6(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9
    L3 = _UPVALUE0_
    L4 = _UPVALUE1_
    L3, L4 = L3(L4)
    if not L3 then
      L5 = nil
      L6 = L4
      return L5, L6
    end
    L5 = _UPVALUE2_
    L5 = L5.prepareLogMsg
    L6 = _UPVALUE3_
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
  return L5(L6)
end
L0.rolling_file = L4
L4 = L0.rolling_file
return L4
