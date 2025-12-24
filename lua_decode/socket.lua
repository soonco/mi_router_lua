local L0, L1, L2, L3, L4, L5, L6, L7, L8
L0 = _G
L1 = require
L2 = "string"
L1 = L1(L2)
L2 = require
L3 = "math"
L2 = L2(L3)
L3 = require
L4 = "socket.core"
L3 = L3(L4)
L4 = L3
function L5(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = _UPVALUE0_
  L4 = L4.connect
  L5 = A0
  L6 = A1
  L7 = A2
  L8 = A3
  L9 = "inet"
  return L4(L5, L6, L7, L8, L9)
end
L4.connect4 = L5
function L5(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = _UPVALUE0_
  L4 = L4.connect
  L5 = A0
  L6 = A1
  L7 = A2
  L8 = A3
  L9 = "inet6"
  return L4(L5, L6, L7, L8, L9)
end
L4.connect6 = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if A0 == "*" then
    A0 = "0.0.0.0"
  end
  L3 = _UPVALUE0_
  L3 = L3.dns
  L3 = L3.getaddrinfo
  L4 = A0
  L3, L4 = L3(L4)
  if not L3 then
    L5 = nil
    L6 = L4
    return L5, L6
  end
  L5, L6 = nil, nil
  L4 = "no info on address"
  for L10, L11 in L7, L8, L9 do
    L12 = L11.family
    if L12 == "inet" then
      L12 = _UPVALUE0_
      L12 = L12.tcp
      L12, L13 = L12()
      L4 = L13
      L5 = L12
    else
      L12 = _UPVALUE0_
      L12 = L12.tcp6
      L12, L13 = L12()
      L4 = L13
      L5 = L12
    end
    if not L5 then
      L12 = nil
      L13 = L4
      return L12, L13
    end
    L13 = L5
    L12 = L5.setoption
    L14 = "reuseaddr"
    L15 = true
    L12(L13, L14, L15)
    L13 = L5
    L12 = L5.bind
    L14 = L11.addr
    L15 = A1
    L12, L13 = L12(L13, L14, L15)
    L4 = L13
    L6 = L12
    if not L6 then
      L13 = L5
      L12 = L5.close
      L12(L13)
    else
      L13 = L5
      L12 = L5.listen
      L14 = A2
      L12, L13 = L12(L13, L14)
      L4 = L13
      L6 = L12
      if not L6 then
        L13 = L5
        L12 = L5.close
        L12(L13)
      else
        return L5
      end
    end
  end
  return L7, L8
end
L4.bind = L5
L5 = L4.newtry
L5 = L5()
L4.try = L5
function L5(A0)
  local L1
  function L1(A0, A1, A2)
    local L3, L4, L5, L6, L7
    L3 = _UPVALUE0_
    L3 = L3.type
    L4 = A0
    L3 = L3(L4)
    if L3 ~= "string" then
      L3 = "default"
      L4 = A0
      A2 = A1
      A1 = L4
      A0 = L3
    end
    L3 = _UPVALUE1_
    L4 = A0 or L4
    if not A0 then
      L4 = "nil"
    end
    L3 = L3[L4]
    if not L3 then
      L4 = _UPVALUE0_
      L4 = L4.error
      L5 = "unknown key ("
      L6 = _UPVALUE0_
      L6 = L6.tostring
      L7 = A0
      L6 = L6(L7)
      L7 = ")"
      L5 = L5 .. L6 .. L7
      L6 = 3
      L4(L5, L6)
    else
      L4 = L3
      L5 = A1
      L6 = A2
      return L4(L5, L6)
    end
  end
  return L1
end
L4.choose = L5
L5 = {}
L6 = {}
L4.sourcet = L5
L4.sinkt = L6
L4.BLOCKSIZE = 2048
function L7(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.setmetatable
  L2 = {}
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L2.getfd = L3
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L2.dirty = L3
  L3 = {}
  function L4(A0, A1, A2)
    local L3, L4, L5
    if not A1 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.close
      L3(L4)
      L3 = 1
      return L3
    else
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.send
      L5 = A1
      return L3(L4, L5)
    end
  end
  L3.__call = L4
  return L1(L2, L3)
end
L6["close-when-done"] = L7
function L7(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.setmetatable
  L2 = {}
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L2.getfd = L3
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L2.dirty = L3
  L3 = {}
  function L4(A0, A1, A2)
    local L3, L4, L5
    if A1 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.send
      L5 = A1
      return L3(L4, L5)
    else
      L3 = 1
      return L3
    end
  end
  L3.__call = L4
  return L1(L2, L3)
end
L6["keep-open"] = L7
L7 = L6["keep-open"]
L6.default = L7
L7 = L4.choose
L8 = L6
L7 = L7(L8)
L4.sink = L7
function L7(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.setmetatable
  L3 = {}
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L3.getfd = L4
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L3.dirty = L4
  L4 = {}
  function L5()
    local L0, L1, L2, L3, L4, L5
    L0 = _UPVALUE0_
    if L0 <= 0 then
      L0 = nil
      return L0
    end
    L0 = _UPVALUE1_
    L0 = L0.min
    L1 = _UPVALUE2_
    L1 = L1.BLOCKSIZE
    L2 = _UPVALUE0_
    L0 = L0(L1, L2)
    L1 = _UPVALUE3_
    L2 = L1
    L1 = L1.receive
    L3 = L0
    L1, L2 = L1(L2, L3)
    if L2 then
      L3 = nil
      L4 = L2
      return L3, L4
    end
    L3 = _UPVALUE0_
    L4 = _UPVALUE4_
    L4 = L4.len
    L5 = L1
    L4 = L4(L5)
    L3 = L3 - L4
    _UPVALUE0_ = L3
    return L1
  end
  L4.__call = L5
  return L2(L3, L4)
end
L5["by-length"] = L7
function L7(A0)
  local L1, L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.setmetatable
  L3 = {}
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L3.getfd = L4
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L3.dirty = L4
  L4 = {}
  function L5()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    if L0 then
      L0 = nil
      return L0
    end
    L0 = _UPVALUE1_
    L1 = L0
    L0 = L0.receive
    L2 = _UPVALUE2_
    L2 = L2.BLOCKSIZE
    L0, L1, L2 = L0(L1, L2)
    if not L1 then
      return L0
    elseif L1 == "closed" then
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.close
      L3(L4)
      L3 = 1
      _UPVALUE0_ = L3
      return L2
    else
      L3 = nil
      L4 = L1
      return L3, L4
    end
  end
  L4.__call = L5
  return L2(L3, L4)
end
L5["until-closed"] = L7
L7 = L5["until-closed"]
L5.default = L7
L7 = L4.choose
L8 = L5
L7 = L7(L8)
L4.source = L7
return L4
