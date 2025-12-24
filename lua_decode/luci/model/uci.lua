local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = require
L1 = "os"
L0 = L0(L1)
L1 = require
L2 = "uci"
L1 = L1(L2)
L2 = require
L3 = "luci.util"
L2 = L2(L3)
L3 = require
L4 = "table"
L3 = L3(L4)
L4 = setmetatable
L5 = rawget
L6 = rawset
L7 = require
L8 = getmetatable
L9 = error
L10 = pairs
L11 = ipairs
L12 = type
L13 = tostring
L14 = tonumber
L15 = unpack
L16 = module
L17 = "luci.model.uci"
L16(L17)
L16 = L1.cursor
cursor = L16
L16 = L1.APIVERSION
APIVERSION = L16
function L16()
  local L0, L1, L2
  L0 = cursor
  L1 = nil
  L2 = "/var/state"
  return L0(L1, L2)
end
cursor_state = L16
L16 = cursor
L16 = L16()
inst = L16
L16 = cursor_state
L16 = L16()
inst_state = L16
L16 = L8
L17 = inst
L16 = L16(L17)
function L17(A0, A1, A2)
  local L3, L4, L5, L6
  L4 = A0
  L3 = A0._affected
  L5 = A1
  L3 = L3(L4, L5)
  A1 = L3
  if A2 then
    L3 = {}
    L4 = "/sbin/luci-reload"
    L5 = _UPVALUE0_
    L6 = A1
    L5, L6 = L5(L6)
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    return L3
  else
    L3 = _UPVALUE1_
    L3 = L3.execute
    L4 = _UPVALUE2_
    L4 = L4.concat
    L5 = A1
    L6 = " "
    L4 = L4(L5, L6)
    L4 = "/sbin/luci-reload %s >/dev/null 2>&1" % L4
    return L3(L4)
  end
end
L16.apply = L17
function L17(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5(L6)
  if L5 == "table" then
    L5 = A3
    function A3(A0)
      local L1, L2, L3, L4, L5, L6
      for L4, L5 in L1, L2, L3 do
        L6 = A0[L4]
        if L6 ~= L5 then
          L6 = false
          return L6
        end
      end
      return L1
    end
  end
  function L5(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    if L1 then
      L1 = _UPVALUE0_
      L2 = A0
      L1 = L1(L2)
      if not L1 then
        goto lbl_15
      end
    end
    L1 = _UPVALUE1_
    L2 = _UPVALUE1_
    L2 = #L2
    L2 = L2 + 1
    L3 = A0[".name"]
    L1[L2] = L3
    ::lbl_15::
  end
  L9 = A2
  L10 = L5
  L6(L7, L8, L9, L10)
  for L9, L10 in L6, L7, L8 do
    L12 = A0
    L11 = A0.delete
    L13 = A1
    L14 = L10
    L11(L12, L13, L14)
  end
end
L16.delete_all = L17
function L17(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = true
  if A3 then
    L7 = A0
    L6 = A0.set
    L8 = A1
    L9 = A3
    L10 = A2
    L6 = L6(L7, L8, L9, L10)
    L5 = L6
  else
    L7 = A0
    L6 = A0.add
    L8 = A1
    L9 = A2
    L6 = L6(L7, L8, L9)
    A3 = L6
    L5 = A3 or L5
    if A3 then
      L5 = true
    end
  end
  if L5 and A4 then
    L7 = A0
    L6 = A0.tset
    L8 = A1
    L9 = A3
    L10 = A4
    L6 = L6(L7, L8, L9, L10)
    L5 = L6
  end
  L6 = L5 or L6
  if L5 then
    L6 = A3
  end
  return L6
end
L16.section = L17
function L17(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = true
  for L8, L9 in L5, L6, L7 do
    L11 = L8
    L10 = L8.sub
    L12 = 1
    L13 = 1
    L10 = L10(L11, L12, L13)
    if L10 ~= "." and L4 then
      L11 = A0
      L10 = A0.set
      L12 = A1
      L13 = A2
      L14 = L8
      L15 = L9
      L10 = L10(L11, L12, L13, L14, L15)
      L4 = L10
    end
  end
  return L4
end
L16.tset = L17
function L17(A0, ...)
  local L2, L3, L4
  L3 = A0
  L2 = A0.get
  L4 = ...
  L2 = L2(L3, L4)
  L3 = L2 == "1" or L2 == "true" or L2 == "yes" or L2 == "on"
  return L3
end
L16.get_bool = L17
function L17(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  if A1 and A2 and A3 then
    L5 = A0
    L4 = A0.get
    L6 = A1
    L7 = A2
    L8 = A3
    L4 = L4(L5, L6, L7, L8)
    L5 = _UPVALUE0_
    L6 = L4
    L5 = L5(L6)
    L5 = L4 or L5
    if L5 ~= "table" or not L4 then
      L5 = {}
      L6 = L4
      L5[1] = L6
    end
    return L5
  end
  L4 = nil
  return L4
end
L16.get_list = L17
function L17(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = A4
  L7 = A0
  L6 = A0.foreach
  L8 = A1
  L9 = A2
  function L10(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    if not L1 then
      L1 = A0[".name"]
      if L1 then
        goto lbl_9
      end
    end
    L1 = _UPVALUE0_
    L1 = A0[L1]
    ::lbl_9::
    L2 = _UPVALUE1_
    L3 = _UPVALUE2_
    L2 = L2(L3)
    if L2 == "number" then
      L2 = _UPVALUE3_
      L3 = L1
      L2 = L2(L3)
      L1 = L2
    else
      L2 = _UPVALUE1_
      L3 = _UPVALUE2_
      L2 = L2(L3)
      if L2 == "boolean" then
        L1 = L1 == "1" or L1 == "true" or L1 == "yes" or L1 == "on"
      end
    end
    if L1 ~= nil then
      _UPVALUE4_ = L1
      L2 = false
      return L2
    end
  end
  L6(L7, L8, L9, L10)
  return L5
end
L16.get_first = L17
function L17(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11
  if A1 and A2 and A3 then
    L6 = A0
    L5 = A0.set
    L7 = A1
    L8 = A2
    L9 = A3
    L10 = _UPVALUE0_
    L11 = A4
    L10 = L10(L11)
    L10 = A4 or L10
    if L10 ~= "table" or not A4 then
      L10 = {}
      L11 = A4
      L10[1] = L11
    end
    return L5(L6, L7, L8, L9, L10)
  end
  L5 = false
  return L5
end
L16.set_list = L17
function L17(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L2 = _UPVALUE0_
  L3 = A1
  L2 = L2(L3)
  if L2 ~= "table" or not A1 then
    L2 = {}
    L3 = A1
    L2[1] = L3
    A1 = L2
  end
  L2 = cursor
  L2 = L2()
  L4 = L2
  L3 = L2.load
  L3(L4, L5)
  L3 = {}
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
    L1 = {}
    L2 = A0
    L1[1] = L2
    L2 = {}
    L6 = A0
    function L7(A0)
      local L1, L2, L3, L4, L5, L6, L7
      if L1 then
        for L4, L5 in L1, L2, L3 do
          L6 = _UPVALUE1_
          L7 = _UPVALUE1_
          L7 = #L7
          L7 = L7 + 1
          L6[L7] = L5
        end
      end
    end
    L3(L4, L5, L6, L7)
    for L6, L7 in L3, L4, L5 do
      L11, L12, L13 = L9(L10)
      for L11, L12 in L8, L9, L10 do
        L13 = #L1
        L13 = L13 + 1
        L1[L13] = L12
      end
    end
    return L1
  end
  for L8, L9 in L5, L6, L7 do
    L13, L14, L15, L16, L17 = L11(L12)
    for L13, L14 in L10, L11, L12 do
      L15 = _UPVALUE2_
      L15 = L15.contains
      L16 = L3
      L17 = L14
      L15 = L15(L16, L17)
      if not L15 then
        L15 = #L3
        L15 = L15 + 1
        L3[L15] = L14
      end
    end
  end
  return L3
end
L16._affected = L17
function L17(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = _UPVALUE0_
  L2 = L2._substates
  L2 = L2 or L2
  L1._substates = L2
  L1 = _UPVALUE0_
  L1 = L1._substates
  L2 = _UPVALUE0_
  L2 = L2._substates
  L2 = L2[A0]
  if not L2 then
    L2 = cursor_state
    L2 = L2()
  end
  L1[A0] = L2
  L1 = _UPVALUE0_
  L1 = L1._substates
  L1 = L1[A0]
  return L1
end
L16.substate = L17
L17 = L16.load
function L18(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2._substates
  if L2 then
    L2 = _UPVALUE0_
    L2 = L2._substates
    L2 = L2[A0]
    if L2 then
      L2 = _UPVALUE1_
      L3 = _UPVALUE0_
      L3 = L3._substates
      L3 = L3[A0]
      L4 = ...
      L2(L3, L4)
    end
  end
  L2 = _UPVALUE1_
  L3 = A0
  L4 = ...
  return L2(L3, L4)
end
L16.load = L18
L18 = L16.unload
function L19(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2._substates
  if L2 then
    L2 = _UPVALUE0_
    L2 = L2._substates
    L2 = L2[A0]
    if L2 then
      L2 = _UPVALUE1_
      L3 = _UPVALUE0_
      L3 = L3._substates
      L3 = L3[A0]
      L4 = ...
      L2(L3, L4)
    end
  end
  L2 = _UPVALUE1_
  L3 = A0
  L4 = ...
  return L2(L3, L4)
end
L16.unload = L19
