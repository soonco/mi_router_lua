local L0, L1, L2
L0 = require
L1 = "logging"
L0 = L0(L1)
L1 = require
L2 = "socket.smtp"
L1 = L1(L2)
function L2(A0)
  local L1, L2
  if not A0 then
    L1 = {}
    A0 = L1
  end
  L1 = A0.headers
  L1 = L1 or L1
  A0.headers = L1
  L1 = A0.from
  if L1 == nil then
    L1 = nil
    L2 = "'from' parameter is required"
    return L1, L2
  end
  L1 = A0.rcpt
  if L1 == nil then
    L1 = nil
    L2 = "'rcpt' parameter is required"
    return L1, L2
  end
  L1 = _UPVALUE0_
  L1 = L1.new
  function L2(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9
    L3 = _UPVALUE0_
    L3 = L3.prepareLogMsg
    L4 = _UPVALUE1_
    L4 = L4.logPattern
    L5 = os
    L5 = L5.date
    L5 = L5()
    L6 = A1
    L7 = A2
    L3 = L3(L4, L5, L6, L7)
    L4 = _UPVALUE1_
    L4 = L4.headers
    L4 = L4.subject
    if L4 then
      L4 = _UPVALUE1_
      L4 = L4.headers
      L5 = _UPVALUE0_
      L5 = L5.prepareLogMsg
      L6 = _UPVALUE1_
      L6 = L6.headers
      L6 = L6.subject
      L7 = os
      L7 = L7.date
      L7 = L7()
      L8 = A1
      L9 = A2
      L5 = L5(L6, L7, L8, L9)
      L4.subject = L5
    end
    L4 = {}
    L5 = _UPVALUE1_
    L5 = L5.headers
    L4.headers = L5
    L4.body = L3
    L5 = _UPVALUE1_
    L6 = _UPVALUE2_
    L6 = L6.message
    L7 = L4
    L6 = L6(L7)
    L5.source = L6
    L5 = _UPVALUE2_
    L5 = L5.send
    L6 = _UPVALUE1_
    L5, L6 = L5(L6)
    if not L5 then
      L7 = nil
      L8 = L6
      return L7, L8
    end
    L7 = true
    return L7
  end
  return L1(L2)
end
L0.email = L2
L2 = L0.email
return L2
