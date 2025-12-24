local L0, L1
L0 = require
L1 = "logging"
L0 = L0(L1)
function L1(A0)
  local L1, L2, L3, L4
  if not A0 then
    L1 = {}
    A0 = L1
  end
  L1 = A0.tablename
  L1 = L1 or L1
  A0.tablename = L1
  L1 = A0.logdatefield
  L1 = L1 or L1
  A0.logdatefield = L1
  L1 = A0.loglevelfield
  L1 = L1 or L1
  A0.loglevelfield = L1
  L1 = A0.logmessagefield
  L1 = L1 or L1
  A0.logmessagefield = L1
  L1 = A0.connectionfactory
  if L1 ~= nil then
    L1 = type
    L2 = A0.connectionfactory
    L1 = L1(L2)
    if L1 == "function" then
      goto lbl_36
    end
  end
  L1 = nil
  L2 = "No specified connection factory function"
  do return L1, L2 end
  ::lbl_36::
  L1, L2 = nil, nil
  L3 = A0.keepalive
  if L3 then
    L3 = A0.connectionfactory
    L3, L4 = L3()
    L2 = L4
    L1 = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.new
  function L4(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
    L3 = _UPVALUE0_
    L3 = L3.keepalive
    if L3 then
      L3 = _UPVALUE1_
      if L3 ~= nil then
        goto lbl_19
      end
    end
    L3 = _UPVALUE0_
    L3 = L3.connectionfactory
    L3, L4 = L3()
    _UPVALUE2_ = L4
    _UPVALUE1_ = L3
    L3 = _UPVALUE1_
    if not L3 then
      L3 = nil
      L4 = _UPVALUE2_
      return L3, L4
    end
    ::lbl_19::
    L3 = os
    L3 = L3.date
    L4 = "%Y-%m-%d %H:%M:%S"
    L3 = L3(L4)
    L4 = string
    L4 = L4.format
    L5 = "INSERT INTO %s (%s, %s, %s) VALUES ('%s', '%s', '%s')"
    L6 = _UPVALUE0_
    L6 = L6.tablename
    L7 = _UPVALUE0_
    L7 = L7.logdatefield
    L8 = _UPVALUE0_
    L8 = L8.loglevelfield
    L9 = _UPVALUE0_
    L9 = L9.logmessagefield
    L10 = L3
    L11 = A1
    L12 = string
    L12 = L12.gsub
    L13 = A2
    L14 = "'"
    L15 = "''"
    L12, L13, L14, L15 = L12(L13, L14, L15)
    L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L5 = pcall
    L6 = _UPVALUE1_
    L6 = L6.execute
    L7 = _UPVALUE1_
    L8 = L4
    L5, L6 = L5(L6, L7, L8)
    if not L5 then
      L7 = _UPVALUE0_
      L7 = L7.connectionfactory
      L7, L8 = L7()
      L6 = L8
      _UPVALUE1_ = L7
      L7 = _UPVALUE1_
      if not L7 then
        L7 = nil
        L8 = L6
        return L7, L8
      end
      L7 = _UPVALUE1_
      L8 = L7
      L7 = L7.execute
      L9 = L4
      L7, L8 = L7(L8, L9)
      L6 = L8
      L5 = L7
      if not L5 then
        L7 = nil
        L8 = L6
        return L7, L8
      end
    end
    L7 = _UPVALUE0_
    L7 = L7.keepalive
    if not L7 then
      L7 = _UPVALUE1_
      L8 = L7
      L7 = L7.close
      L7(L8)
    end
    L7 = true
    return L7
  end
  return L3(L4)
end
L0.sql = L1
L1 = L0.sql
return L1
