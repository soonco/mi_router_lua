local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
L0 = require
L1 = "io"
L0 = L0(L1)
L1 = require
L2 = "math"
L1 = L1(L2)
L2 = require
L3 = "table"
L2 = L2(L3)
L3 = require
L4 = "debug"
L3 = L3(L4)
L4 = require
L5 = "luci.debug"
L4 = L4(L5)
L5 = require
L6 = "string"
L5 = L5(L6)
L6 = require
L7 = "coroutine"
L6 = L6(L7)
L7 = require
L8 = "luci.template.parser"
L7 = L7(L8)
L8 = getmetatable
L9 = setmetatable
L10 = rawget
L11 = rawset
L12 = unpack
L13 = tostring
L14 = type
L15 = assert
L16 = ipairs
L17 = pairs
L18 = next
L19 = loadstring
L20 = require
L21 = pcall
L22 = xpcall
L23 = collectgarbage
L24 = get_memory_limit
L25 = module
L26 = "luci.util"
L25(L26)
L25 = L8
L26 = ""
L25 = L25(L26)
function L26(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  if not A1 then
    return A0
  elseif L2 == "table" then
    for L5, L6 in L2, L3, L4 do
      L7 = _UPVALUE0_
      L8 = A1[L5]
      L7 = L7(L8)
      if L7 == "userdata" then
        L7 = _UPVALUE2_
        L8 = A1[L5]
        L7 = L7(L8)
        A1[L5] = L7
      end
    end
    L5 = A1
    L5, L6, L7, L8 = L4(L5)
    return L2(L3, L4, L5, L6, L7, L8)
  else
    if L2 == "userdata" then
      A1 = L2
    end
    return L2(L3, L4)
  end
end
L25.__mod = L26
function L25(A0, ...)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = {}
  L4 = {}
  L4.__index = A0
  L2 = L2(L3, L4)
  L3 = L2.__init__
  if L3 then
    L4 = L2
    L3 = L2.__init__
    L5 = ...
    L3(L4, L5)
  end
  return L2
end
function L26(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = {}
  L3 = {}
  L4 = _UPVALUE1_
  L3.__call = L4
  L3.__index = A0
  return L1(L2, L3)
end
class = L26
function L26(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  while L2 do
    L3 = L2.__index
    if not L3 then
      break
    end
    L3 = L2.__index
    if L3 == A1 then
      L3 = true
      return L3
    end
    L3 = _UPVALUE0_
    L4 = L2.__index
    L3 = L3(L4)
    L2 = L3
  end
  L3 = false
  return L3
end
instanceof = L26
L26 = {}
L26.__mode = "k"
function L27(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = A0
  L4 = coxpt
  L5 = _UPVALUE1_
  L5 = L5.running
  L5 = L5()
  L4 = L4[L5]
  if not L4 then
    L4 = _UPVALUE1_
    L4 = L4.running
    L4 = L4()
    L4 = L4 or L4
  end
  L2 = L2(L3, L4)
  L3 = L2 or L3
  if L2 then
    L3 = L2[A1]
  end
  return L3
end
L26.__index = L27
function L27(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = coxpt
  L4 = _UPVALUE0_
  L4 = L4.running
  L4 = L4()
  L3 = L3[L4]
  if not L3 then
    L3 = _UPVALUE0_
    L3 = L3.running
    L3 = L3()
    L3 = L3 or L3
  end
  L4 = _UPVALUE1_
  L5 = A0
  L6 = L3
  L4 = L4(L5, L6)
  if not L4 then
    L4 = _UPVALUE2_
    L5 = A0
    L6 = L3
    L7 = {}
    L7[A1] = A2
    L4(L5, L6, L7)
  else
    L4 = _UPVALUE1_
    L5 = A0
    L6 = L3
    L4 = L4(L5, L6)
    L4[A1] = A2
  end
end
L26.__newindex = L27
function L27(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0 or L2
  if not A0 then
    L2 = {}
  end
  L3 = _UPVALUE1_
  return L1(L2, L3)
end
threadlocal = L27
function L27(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.stderr
  L2 = L1
  L1 = L1.write
  L3 = _UPVALUE1_
  L4 = A0
  L3 = L3(L4)
  L4 = "\n"
  L3 = L3 .. L4
  return L1(L2, L3)
end
perror = L27
function L27(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  A2 = A2 or A2
  if not A3 then
    L6.__mode = "k"
    A3 = L4
  end
  for L7, L8 in L4, L5, L6 do
    L9 = perror
    L10 = _UPVALUE2_
    L10 = L10.rep
    L11 = "\t"
    L12 = A2
    L10 = L10(L11, L12)
    L11 = _UPVALUE3_
    L12 = L7
    L11 = L11(L12)
    L12 = "\t"
    L13 = _UPVALUE3_
    L14 = L8
    L13 = L13(L14)
    L10 = L10 .. L11 .. L12 .. L13
    L9(L10)
    L9 = _UPVALUE4_
    L10 = L8
    L9 = L9(L10)
    if L9 == "table" and (not A1 or A1 > A2) then
      L9 = A3[L8]
      if not L9 then
        A3[L8] = true
        L9 = dumptable
        L10 = L8
        L11 = A1
        L12 = A2 + 1
        L13 = A3
        L9(L10, L11, L12, L13)
      else
        L9 = perror
        L10 = _UPVALUE2_
        L10 = L10.rep
        L11 = "\t"
        L12 = A2
        L10 = L10(L11, L12)
        L11 = "*** RECURSION ***"
        L10 = L10 .. L11
        L9(L10)
      end
    end
  end
end
dumptable = L27
function L27(A0)
  local L1, L2, L3
  L1 = A0 or L1
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.pcdata
    L2 = _UPVALUE1_
    L3 = A0
    L2, L3 = L2(L3)
    L1 = L1(L2, L3)
  end
  return L1
end
pcdata = L27
function L27(A0)
  local L1, L2, L3
  L1 = A0 or L1
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.striptags
    L2 = _UPVALUE1_
    L3 = A0
    L2, L3 = L2(L3)
    L1 = L1(L2, L3)
  end
  return L1
end
striptags = L27
function L27(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  A1 = A1 or A1
  A2 = A2 or A2
  L4 = {}
  L5 = 1
  L6 = #A0
  if L6 == 0 then
    L6 = {}
    L7 = ""
    L6[1] = L7
    return L6
  end
  L6 = #A1
  if L6 == 0 then
    L6 = nil
    return L6
  end
  if A2 == 0 then
    return A0
  end
  repeat
    L7 = A0
    L6 = A0.find
    L8 = A1
    L9 = L5
    L10 = not A3
    L6, L7 = L6(L7, L8, L9, L10)
    A2 = A2 - 1
    if L6 and A2 < 0 then
      L8 = #L4
      L8 = L8 + 1
      L10 = A0
      L9 = A0.sub
      L11 = L5
      L9 = L9(L10, L11)
      L4[L8] = L9
    else
      L8 = #L4
      L8 = L8 + 1
      L10 = A0
      L9 = A0.sub
      L11 = L5
      L12 = L6 or L12
      if L6 then
        L12 = L6 - 1
      end
      L9 = L9(L10, L11, L12)
      L4[L8] = L9
    end
    if L7 then
      L8 = L7 + 1
      if L8 then
        goto lbl_57
        L5 = L8 or L5
      end
    end
    L8 = #A0
    L5 = L8 + 1
    ::lbl_57::
  until not L6 or A2 < 0
  return L4
end
split = L27
function L27(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.gsub
  L3 = "^%s*(.-)%s*$"
  L4 = "%1"
  L1 = L1(L2, L3, L4)
  return L1
end
trim = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = 0
  for L6 in L3, L4, L5 do
    L2 = L2 + 1
  end
  return L2
end
cmatch = L27
function L27(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 == "table" then
    L1 = nil
    function L2()
      local L0, L1, L2
      L0 = _UPVALUE1_
      L1 = _UPVALUE2_
      L2 = _UPVALUE0_
      L0 = L0(L1, L2)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE0_
      L0 = L0[L1]
      return L0
    end
    return L2
  else
    L1 = _UPVALUE0_
    L2 = A0
    L1 = L1(L2)
    if L1 ~= "number" then
      L1 = _UPVALUE0_
      L2 = A0
      L1 = L1(L2)
      if L1 ~= "boolean" then
        goto lbl_32
      end
    end
    L1 = true
    function L2()
      local L0, L1
      L0 = _UPVALUE0_
      if L0 then
        L0 = false
        _UPVALUE0_ = L0
        L0 = _UPVALUE1_
        L1 = _UPVALUE2_
        return L0(L1)
      end
    end
    do return L2 end
    goto lbl_49
    ::lbl_32::
    L1 = _UPVALUE0_
    L2 = A0
    L1 = L1(L2)
    if L1 ~= "userdata" then
      L1 = _UPVALUE0_
      L2 = A0
      L1 = L1(L2)
      if L1 ~= "string" then
        goto lbl_49
      end
    end
    L1 = _UPVALUE2_
    L2 = A0
    L1 = L1(L2)
    L2 = L1
    L1 = L1.gmatch
    L3 = "%S+"
    return L1(L2, L3)
  end
  ::lbl_49::
  function L1()
    local L0, L1
  end
  return L1
end
imatch = L27
function L27(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = 0
  L2 = {}
  L2.y = 31622400
  L2.m = 2678400
  L2.w = 604800
  L2.d = 86400
  L2.h = 3600
  L2.min = 60
  L2.kb = 1024
  L2.mb = 1048576
  L2.gb = 1073741824
  L2.kib = 1000
  L2.mib = 1000000
  L2.gib = 1000000000
  for L6 in L3, L4, L5 do
    L8 = L6
    L7 = L6.gsub
    L9 = "[^0-9%.]+$"
    L10 = ""
    L7 = L7(L8, L9, L10)
    L9 = L6
    L8 = L6.gsub
    L10 = "^[0-9%.]+"
    L11 = ""
    L8 = L8(L9, L10, L11)
    L9 = L2[L8]
    if not L9 then
      L10 = L8
      L9 = L8.sub
      L11 = 1
      L12 = 1
      L9 = L9(L10, L11, L12)
      L9 = L2[L9]
      if not L9 then
        goto lbl_50
      end
    end
    L9 = L2[L8]
    if not L9 then
      L10 = L8
      L9 = L8.sub
      L11 = 1
      L12 = 1
      L9 = L9(L10, L11, L12)
      L9 = L2[L9]
    end
    L9 = L7 * L9
    L1 = L1 + L9
    goto lbl_51
    ::lbl_50::
    L1 = L1 + L7
    ::lbl_51::
  end
  return L1
end
parse_units = L27
L27 = pcdata
L5.pcdata = L27
L27 = striptags
L5.striptags = L27
L27 = split
L5.split = L27
L27 = trim
L5.trim = L27
L27 = cmatch
L5.cmatch = L27
L27 = parse_units
L5.parse_units = L27
function L27(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L5, L6, L10, L11, L12 = ...
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L3[4] = L7
  L3[5] = L8
  L3[6] = L9
  L3[7] = L10
  L3[8] = L11
  L3[9] = L12
  for L5, L6 in L2, L3, L4 do
    if L7 == "table" then
      for L10, L11 in L7, L8, L9 do
        L12 = #A0
        L12 = L12 + 1
        A0[L12] = L11
      end
    else
      A0[L7] = L6
    end
  end
  return A0
end
append = L27
function L27(...)
  local L1, L2, L3
  L1 = append
  L2 = {}
  L3 = ...
  return L1(L2, L3)
end
combine = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    if A1 == L6 then
      return L5
    end
  end
  return L2
end
contains = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    A0[L5] = L6
  end
end
update = L27
function L27(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  if A0 then
    for L5, L6 in L2, L3, L4 do
      L7 = #L1
      L7 = L7 + 1
      L1[L7] = L5
    end
  end
  return L1
end
keys = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    if A1 then
      L8 = _UPVALUE1_
      L9 = L7
      L8 = L8(L9)
      if L8 == "table" then
        L8 = clone
        L9 = L7
        L10 = A1
        L8 = L8(L9, L10)
        L7 = L8
      end
    end
    L2[L6] = L7
  end
  L6 = A0
  L6, L7, L8, L9, L10 = L5(L6)
  return L3(L4, L5, L6, L7, L8, L9, L10)
end
clone = L27
function L27()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L1 = {}
  L2 = {}
  function L3(A0, A1)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if not L2 then
      L2 = _UPVALUE0_
      L3 = _UPVALUE1_
      L4 = A0
      L5 = A1
      L6 = dtable
      L6 = L6()
      L3 = L3(L4, L5, L6)
      L4 = A1
      L2 = L2(L3, L4)
    end
    return L2
  end
  L2.__index = L3
  return L0(L1, L2)
end
dtable = L27
function L27(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = ""
  L2 = ""
  L3 = 0
  for L7, L8 in L4, L5, L6 do
    L9 = _UPVALUE1_
    L10 = L7
    L9 = L9(L10)
    if L9 == "number" and not (L7 < 1) then
      L9 = _UPVALUE2_
      L9 = L9.floor
      L10 = L7
      L9 = L9(L10)
      if L9 == L7 then
        L9 = #A0
        L9 = L7 - L9
        if not (3 < L9) then
          goto lbl_47
        end
      end
    end
    L9 = _serialize_data
    L10 = L7
    L9 = L9(L10)
    L7 = L9
    L9 = _serialize_data
    L10 = L8
    L9 = L9(L10)
    L8 = L9
    L9 = L1
    L10 = #L1
    if 0 < L10 then
      L10 = ", "
      if L10 then
        goto lbl_41
      end
    end
    L10 = ""
    ::lbl_41::
    L11 = "["
    L12 = L7
    L13 = "] = "
    L14 = L8
    L1 = L9 .. L10 .. L11 .. L12 .. L13 .. L14
    goto lbl_50
    ::lbl_47::
    if L3 < L7 then
      L3 = L7
    end
    ::lbl_50::
  end
  for L7 = L4, L5, L6 do
    L8 = _serialize_data
    L9 = A0[L7]
    L8 = L8(L9)
    L9 = L2
    L10 = #L2
    if 0 < L10 then
      L10 = ", "
      if L10 then
        goto lbl_67
      end
    end
    L10 = ""
    ::lbl_67::
    L11 = L8
    L2 = L9 .. L10 .. L11
  end
  if 0 < L5 then
    if 0 < L5 then
      if L5 then
        goto lbl_81
      end
    end
  end
  ::lbl_81::
  return L4
end
_serialize_table = L27
function L27(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = hasRecursion
  L3 = A0
  L2 = L2(L3)
  L2 = not L2
  L3 = "Recursion detected."
  L1(L2, L3)
  L1 = _serialize_data
  L2 = A0
  return L1(L2)
end
serialize_data = L27
function L27(A0)
  local L1, L2, L3
  if A0 == nil then
    L1 = "nil"
    return L1
  else
    L1 = _UPVALUE0_
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" then
      return A0
    else
      L1 = _UPVALUE0_
      L2 = A0
      L1 = L1(L2)
      if L1 == "string" then
        L1 = "%q" % A0
        return L1
      else
        L1 = _UPVALUE0_
        L2 = A0
        L1 = L1(L2)
        if L1 == "boolean" then
          if A0 then
            L1 = "true"
            if L1 then
              goto lbl_32
            end
          end
          L1 = "false"
          ::lbl_32::
          return L1
        else
          L1 = _UPVALUE0_
          L2 = A0
          L1 = L1(L2)
          if L1 == "function" then
            L1 = get_bytecode
            L2 = A0
            L1 = L1(L2)
            L1 = "loadstring(%q)" % L1
            return L1
          else
            L1 = _UPVALUE0_
            L2 = A0
            L1 = L1(L2)
            if L1 == "table" then
              L1 = "{ "
              L2 = _serialize_table
              L3 = A0
              L2 = L2(L3)
              L3 = " }"
              L1 = L1 .. L2 .. L3
              return L1
            else
              L1 = "\"[unhandled data type:"
              L2 = _UPVALUE0_
              L3 = A0
              L2 = L2(L3)
              L3 = "]\""
              L1 = L1 .. L2 .. L3
              return L1
            end
          end
        end
      end
    end
  end
end
_serialize_data = L27
function L27(A0)
  local L1, L2, L3, L4
  if A0 ~= nil then
    L1 = _UPVALUE0_
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      goto lbl_10
    end
  end
  L1 = false
  do return L1 end
  ::lbl_10::
  L1 = {}
  L1[A0] = true
  L2 = hasR
  L3 = A0
  L4 = L1
  return L2(L3, L4)
end
hasRecursion = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE1_
    L8 = L5
    L7 = L7(L8)
    if L7 == "table" then
      L7 = A1[L5]
      if L7 then
        L7 = A0
        while true do
          if L7 == L5 then
            L8 = true
            return L8
          else
            L7 = A1[L7]
            if not L7 then
              break
            end
          end
        end
      end
      A1[L5] = A0
      L7 = hasR
      L8 = L5
      L9 = A1
      L7 = L7(L8, L9)
      if L7 then
        L7 = true
        return L7
      end
    end
    L7 = _UPVALUE1_
    L8 = L6
    L7 = L7(L8)
    if L7 == "table" then
      L7 = A1[L6]
      if L7 then
        L7 = A0
        while true do
          if L7 == L6 then
            L8 = true
            return L8
          else
            L7 = A1[L7]
            if not L7 then
              break
            end
          end
        end
      end
      A1[L6] = A0
      L7 = hasR
      L8 = L6
      L9 = A1
      L7 = L7(L8, L9)
      if L7 then
        L7 = true
        return L7
      end
    end
  end
  return L2
end
hasR = L27
function L27(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "return "
  L3 = A0
  L2 = L2 .. L3
  L1 = L1(L2)
  return L1()
end
restore_data = L27
function L27(A0)
  local L1, L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  if L2 == "function" then
    L2 = _UPVALUE1_
    L2 = L2.dump
    L3 = A0
    L2 = L2(L3)
    L1 = L2
  else
    L2 = _UPVALUE1_
    L2 = L2.dump
    L3 = _UPVALUE2_
    L4 = "return "
    L5 = serialize_data
    L6 = A0
    L5 = L5(L6)
    L4 = L4 .. L5
    L3, L4, L5, L6 = L3(L4)
    L2 = L2(L3, L4, L5, L6)
    L1 = L2
  end
  return L1
end
get_bytecode = L27
function L27(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = A0
  L1 = A0.byte
  L3 = 5
  L4 = 12
  L1, L2, L3, L4, L5, L6, L7, L8 = L1(L2, L3, L4)
  L9 = nil
  if L3 == 1 then
    function L9(A0, A1, A2)
      local L3, L4, L5, L6, L7, L8, L9, L10, L11
      L3 = 0
      for L7 = L4, L5, L6 do
        L8 = L3 * 256
        L10 = A0
        L9 = A0.byte
        L11 = A1 + L7
        L11 = L11 - 1
        L9 = L9(L10, L11)
        L3 = L8 + L9
      end
      return L4, L5
    end
  else
    function L9(A0, A1, A2)
      local L3, L4, L5, L6, L7, L8, L9, L10, L11
      L3 = 0
      for L7 = L4, L5, L6 do
        L8 = L3 * 256
        L10 = A0
        L9 = A0.byte
        L11 = A1 + L7
        L11 = L11 - 1
        L9 = L9(L10, L11)
        L3 = L8 + L9
      end
      return L4, L5
    end
  end
  function L10(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
    L1 = _UPVALUE0_
    L2 = A0
    L3 = 1
    L4 = _UPVALUE1_
    L1, L2 = L1(L2, L3, L4)
    L3 = {}
    L4 = _UPVALUE2_
    L4 = L4.rep
    L4, L8, L9, L10, L11, L12, L13, L14 = L4(L5, L6)
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3[4] = L7
    L3[5] = L8
    L3[6] = L9
    L3[7] = L10
    L3[8] = L11
    L3[9] = L12
    L3[10] = L13
    L3[11] = L14
    L4 = L2 + L1
    L2 = L5 + 4
    L8 = L2
    L9 = _UPVALUE3_
    L2 = L5 + L6
    L8 = _UPVALUE3_
    L2 = L6
    L1 = L5
    for L8 = L5, L6, L7 do
      L9 = nil
      L10 = _UPVALUE0_
      L11 = A0
      L12 = L2
      L13 = 1
      L10, L11 = L10(L11, L12, L13)
      L2 = L11
      L9 = L10
      if L9 == 1 then
        L2 = L2 + 1
      elseif L9 == 4 then
        L10 = _UPVALUE1_
        L10 = L2 + L10
        L11 = _UPVALUE0_
        L12 = A0
        L13 = L2
        L14 = _UPVALUE1_
        L11 = L11(L12, L13, L14)
        L2 = L10 + L11
      elseif L9 == 3 then
        L10 = _UPVALUE5_
        L2 = L2 + L10
      elseif L9 == 254 or L9 == 9 then
        L10 = _UPVALUE6_
        L2 = L2 + L10
      end
    end
    L8 = _UPVALUE3_
    L2 = L6
    L1 = L5
    L8 = L4
    L9 = L2 - 1
    L3[L5] = L6
    for L8 = L5, L6, L7 do
      L9 = _UPVALUE7_
      L11 = A0
      L10 = A0.sub
      L12 = L2
      L13 = -1
      L10, L11, L12, L13, L14 = L10(L11, L12, L13)
      L9, L10 = L9(L10, L11, L12, L13, L14)
      L11 = #L3
      L11 = L11 + 1
      L3[L11] = L9
      L11 = L2 + L10
      L2 = L11 - 1
    end
    L8 = _UPVALUE3_
    L2 = L5 + L6
    L8 = _UPVALUE3_
    L2 = L6
    L1 = L5
    for L8 = L5, L6, L7 do
      L9 = _UPVALUE0_
      L10 = A0
      L11 = L2
      L12 = _UPVALUE1_
      L9 = L9(L10, L11, L12)
      L9 = L2 + L9
      L10 = _UPVALUE1_
      L9 = L9 + L10
      L10 = _UPVALUE3_
      L10 = L10 * 2
      L2 = L9 + L10
    end
    L8 = _UPVALUE3_
    L2 = L6
    L1 = L5
    for L8 = L5, L6, L7 do
      L9 = _UPVALUE0_
      L10 = A0
      L11 = L2
      L12 = _UPVALUE1_
      L9 = L9(L10, L11, L12)
      L9 = L2 + L9
      L10 = _UPVALUE1_
      L2 = L9 + L10
    end
    L8 = _UPVALUE3_
    L8 = L8 * 3
    L3[L5] = L6
    return L5, L6
  end
  L12 = A0
  L11 = A0.sub
  L13 = 1
  L14 = 12
  L11 = L11(L12, L13, L14)
  L12 = L10
  L14 = A0
  L13 = A0.sub
  L15 = 13
  L16 = -1
  L13, L14, L15, L16 = L13(L14, L15, L16)
  L12 = L12(L13, L14, L15, L16)
  L11 = L11 .. L12
  return L11
end
strip_bytecode = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = {}
  L3, L4 = nil, nil
  for L8, L9 in L5, L6, L7 do
    L10 = #L2
    L10 = L10 + 1
    L2[L10] = L8
  end
  L8 = A1
  L6(L7, L8)
  return L6
end
_sortiter = L27
function L27(A0, A1)
  local L2, L3, L4
  L2 = _sortiter
  L3 = A0
  L4 = A1
  return L2(L3, L4)
end
spairs = L27
function L27(A0)
  local L1, L2
  L1 = _sortiter
  L2 = A0
  return L1(L2)
end
kspairs = L27
function L27(A0)
  local L1, L2, L3
  L1 = _sortiter
  L2 = A0
  function L3(A0, A1)
    local L2, L3
    L2 = _UPVALUE0_
    L2 = L2[A0]
    L3 = _UPVALUE0_
    L3 = L3[A1]
    L2 = L2 < L3
    return L2
  end
  return L1(L2, L3)
end
vspairs = L27
function L27()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.byte
  L1 = _UPVALUE0_
  L1 = L1.dump
  function L2()
    local L0, L1
  end
  L1 = L1(L2)
  L2 = 7
  L0 = L0(L1, L2)
  L0 = L0 == 0
  return L0
end
bigendian = L27
function L27(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L3 = L1
  L2 = L1.read
  L4 = "*a"
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.close
  L3(L4)
  return L2
end
exec = L27
function L27(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L2 = L1 or L2
  if L1 then
    function L2()
      local L0, L1, L2
      L0 = _UPVALUE0_
      L1 = L0
      L0 = L0.read
      L0 = L0(L1)
      if not L0 then
        L1 = _UPVALUE0_
        L2 = L1
        L1 = L1.close
        L1(L2)
      end
      return L0
    end
  end
  return L2
end
execi = L27
function L27(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L2 = ""
  L3 = {}
  while true do
    L5 = L1
    L4 = L1.read
    L4 = L4(L5)
    L2 = L4
    if L2 == nil then
      break
    end
    L4 = #L3
    L4 = L4 + 1
    L3[L4] = L2
  end
  L5 = L1
  L4 = L1.close
  L4(L5)
  return L3
end
execl = L27
function L27()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = "nixio.fs"
  L0 = L0(L1)
  L0 = L0.dirname
  L1 = _UPVALUE1_
  L1 = L1.__file__
  return L0(L1)
end
libpath = L27
L27, L28 = nil, nil
L29 = L21
L30 = L22
L31 = {}
coxpt = L31
L31 = L9
L32 = coxpt
L33 = {}
L33.__mode = "kv"
L31(L32, L33)
function L31(A0, ...)
  local L2
  L2 = ...
  return L2
end
function L32(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = _UPVALUE0_
  L4 = _UPVALUE1_
  L4 = L4.create
  L5 = A0
  L3, L4 = L3(L4, L5)
  if not L3 then
    L5 = {}
    L6, L7, L8, L9 = ...
    L5[1] = L6
    L5[2] = L7
    L5[3] = L8
    L5[4] = L9
    function L6()
      local L0, L1, L2
      L0 = _UPVALUE0_
      L1 = _UPVALUE1_
      L2 = _UPVALUE2_
      L1, L2 = L1(L2)
      return L0(L1, L2)
    end
    L7 = _UPVALUE1_
    L7 = L7.create
    L8 = L6
    L7 = L7(L8)
    L4 = L7
  end
  L5 = _UPVALUE1_
  L5 = L5.running
  L5 = L5()
  L6 = coxpt
  L7 = coxpt
  L7 = L7[L5]
  L7 = L5 or L7
  if not L7 and not L5 then
    L7 = 0
  end
  L6[L4] = L7
  L6 = _UPVALUE3_
  L7 = A1
  L8 = L4
  L9 = ...
  return L6(L7, L8, L9)
end
coxpcall = L32
function L32(A0, ...)
  local L2, L3, L4, L5
  L2 = coxpcall
  L3 = A0
  L4 = _UPVALUE0_
  L5 = ...
  return L2(L3, L4, L5)
end
copcall = L32
function L28(A0, A1, A2, ...)
  local L4, L5, L6, L7, L8
  if not A2 then
    L4 = false
    L5 = A0
    L6 = _UPVALUE0_
    L6 = L6.traceback
    L7 = A1
    L8 = (...)
    L6 = L6(L7, L8)
    L7, L8 = ...
    L5, L6, L7, L8 = L5(L6, L7, L8)
    return L4, L5, L6, L7, L8
  end
  L4 = _UPVALUE1_
  L4 = L4.status
  L5 = A1
  L4 = L4(L5)
  if L4 ~= "suspended" then
    L4 = true
    L5, L6, L7, L8 = ...
    return L4, L5, L6, L7, L8
  end
  L4 = _UPVALUE2_
  L5 = A0
  L6 = A1
  L7 = _UPVALUE1_
  L7 = L7.yield
  L8 = ...
  L7, L8 = L7(L8)
  return L4(L5, L6, L7, L8)
end
function L27(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L4 = A0
  L5 = A1
  L6 = _UPVALUE1_
  L6 = L6.resume
  L7 = A1
  L8 = ...
  L6, L7, L8 = L6(L7, L8)
  return L3(L4, L5, L6, L7, L8)
end
function L32(A0, A1)
  local L2, L3, L4
  A1 = A1 or A1
  if not A0 then
    return A1
  end
  L2 = exec
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L3 = trim
    L4 = L2
    L3 = L3(L4)
    L2 = L3
  else
    L2 = A1
  end
  return L2
end
exec_trim = L32
