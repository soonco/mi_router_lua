local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
L0 = require
L1 = "string"
L0 = L0(L1)
L1 = require
L2 = "table"
L1 = L1(L2)
L2 = _G
L3 = {}
L4 = module
if L4 then
  ltn12 = L3
end
L4 = {}
L5 = {}
L6 = {}
L7 = {}
L3.filter = L4
L3.source = L5
L3.sink = L6
L3.pump = L7
L3.BLOCKSIZE = 2048
L3._VERSION = "LTN12 1.0.3"
function L8(A0, A1, A2)
  local L3, L4
  L3 = _UPVALUE0_
  L3 = L3.assert
  L4 = A0
  L3(L4)
  function L3(A0)
    local L1, L2, L3, L4, L5
    L2 = _UPVALUE1_
    L3 = _UPVALUE0_
    L4 = A0
    L5 = _UPVALUE2_
    L2, L3 = L2(L3, L4, L5)
    _UPVALUE0_ = L3
    L1 = L2
    return L1
  end
  return L3
end
L4.cycle = L8
function L8(...)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2, L3, L4, L5, L6 = ...
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  L2 = select
  L3 = "#"
  L4, L5, L6 = ...
  L2 = L2(L3, L4, L5, L6)
  L3 = 1
  L4 = 1
  L5 = ""
  function L6(A0)
    local L1, L2
    L1 = A0 or L1
    if A0 then
      L1 = _UPVALUE0_
    end
    _UPVALUE0_ = L1
    while true do
      L1 = _UPVALUE1_
      L2 = _UPVALUE2_
      if L1 == L2 then
        L1 = _UPVALUE3_
        L2 = _UPVALUE1_
        L1 = L1[L2]
        L2 = A0
        L1 = L1(L2)
        A0 = L1
        if A0 ~= "" then
          L1 = _UPVALUE2_
          L2 = _UPVALUE4_
          if L1 ~= L2 then
            goto lbl_23
          end
        end
        do return A0 end
        goto lbl_66
        ::lbl_23::
        if A0 then
          L1 = _UPVALUE1_
          L1 = L1 + 1
          _UPVALUE1_ = L1
        else
          L1 = _UPVALUE2_
          L1 = L1 + 1
          _UPVALUE2_ = L1
          L1 = _UPVALUE2_
          _UPVALUE1_ = L1
        end
      else
        L1 = _UPVALUE3_
        L2 = _UPVALUE1_
        L1 = L1[L2]
        L2 = A0 or L2
        if not A0 then
          L2 = ""
        end
        L1 = L1(L2)
        A0 = L1
        if A0 == "" then
          L1 = _UPVALUE1_
          L1 = L1 - 1
          _UPVALUE1_ = L1
          A0 = _UPVALUE0_
        elseif A0 then
          L1 = _UPVALUE1_
          L2 = _UPVALUE4_
          if L1 == L2 then
            return A0
          else
            L1 = _UPVALUE1_
            L1 = L1 + 1
            _UPVALUE1_ = L1
          end
        else
          L1 = _UPVALUE5_
          L1 = L1.error
          L2 = "filter returned inappropriate nil"
          L1(L2)
        end
      end
      ::lbl_66::
    end
  end
  return L6
end
L4.chain = L8
function L8()
  local L0, L1
  return L0
end
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
L5.empty = L9
function L9(A0)
  local L1
  function L1()
    local L0, L1
    L1 = _UPVALUE0_
    return L0, L1
  end
  return L1
end
L5.error = L9
function L9(A0, A1)
  local L2, L3
  if A0 then
    function L2()
      local L0, L1, L2
      L0 = _UPVALUE0_
      L1 = L0
      L0 = L0.read
      L2 = _UPVALUE1_
      L2 = L2.BLOCKSIZE
      L0 = L0(L1, L2)
      if not L0 then
        L1 = _UPVALUE0_
        L2 = L1
        L1 = L1.close
        L1(L2)
      end
      return L0
    end
    return L2
  else
    L2 = _UPVALUE1_
    L2 = L2.error
    L3 = A1 or L3
    if not A1 then
      L3 = "unable to open file"
    end
    return L2(L3)
  end
end
L5.file = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.assert
  L2 = A0
  L1(L2)
  function L1()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    L0, L1 = L0()
    L2 = L1 or L2
    if not L1 then
      L2 = _UPVALUE0_
    end
    _UPVALUE0_ = L2
    if not L0 then
      L2 = nil
      L3 = L1
      return L2, L3
    else
      return L0
    end
  end
  return L1
end
L5.simplify = L9
function L9(A0)
  local L1, L2
  if A0 then
    L1 = 1
    function L2()
      local L0, L1, L2, L3, L4
      L0 = _UPVALUE0_
      L0 = L0.sub
      L1 = _UPVALUE1_
      L2 = _UPVALUE2_
      L3 = _UPVALUE2_
      L4 = _UPVALUE3_
      L4 = L4.BLOCKSIZE
      L3 = L3 + L4
      L3 = L3 - 1
      L0 = L0(L1, L2, L3)
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.BLOCKSIZE
      L1 = L1 + L2
      _UPVALUE2_ = L1
      if L0 ~= "" then
        return L0
      else
        L1 = nil
        return L1
      end
    end
    return L2
  else
    L1 = _UPVALUE2_
    L1 = L1.empty
    return L1()
  end
end
L5.string = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.assert
  L2 = A0
  L1(L2)
  L1 = {}
  function L2(A0)
    local L1, L2, L3
    if not A0 then
      L1 = _UPVALUE0_
      L1 = L1.remove
      L2 = _UPVALUE1_
      L1 = L1(L2)
      A0 = L1
      if not A0 then
        L1 = _UPVALUE2_
        return L1()
      else
        return A0
      end
    else
      L1 = _UPVALUE0_
      L1 = L1.insert
      L2 = _UPVALUE1_
      L3 = A0
      L1(L2, L3)
    end
  end
  return L2
end
L5.rewind = L9
function L9(A0, A1, ...)
  local L3, L4, L5, L6, L7
  L3 = (...)
  if L3 then
    L3 = _UPVALUE0_
    L3 = L3.chain
    L4 = A1
    L5, L6, L7 = ...
    L3 = L3(L4, L5, L6, L7)
    A1 = L3
  end
  L3 = _UPVALUE1_
  L3 = L3.assert
  L4 = A0 or L4
  if A0 then
    L4 = A1
  end
  L3(L4)
  L3 = ""
  L4 = ""
  L5 = "feeding"
  L6 = nil
  function L7()
    local L0, L1, L2
    L0 = _UPVALUE0_
    if not L0 then
      L0 = _UPVALUE1_
      L0 = L0.error
      L1 = "source is empty!"
      L2 = 2
      L0(L1, L2)
    end
    while true do
      L0 = _UPVALUE2_
      if L0 == "feeding" then
        L0 = _UPVALUE5_
        L0, L1 = L0()
        _UPVALUE4_ = L1
        _UPVALUE3_ = L0
        L0 = _UPVALUE4_
        if L0 then
          L0 = nil
          L1 = _UPVALUE4_
          return L0, L1
        end
        L0 = _UPVALUE6_
        L1 = _UPVALUE3_
        L0 = L0(L1)
        _UPVALUE0_ = L0
        L0 = _UPVALUE0_
        if not L0 then
          L0 = _UPVALUE3_
          if L0 then
            L0 = _UPVALUE1_
            L0 = L0.error
            L1 = "filter returned inappropriate nil"
            L0(L1)
          else
            L0 = nil
            return L0
          end
        else
          L0 = _UPVALUE0_
          if L0 ~= "" then
            L0 = "eating"
            _UPVALUE2_ = L0
            L0 = _UPVALUE3_
            if L0 then
              L0 = ""
              _UPVALUE3_ = L0
            end
            L0 = _UPVALUE0_
            return L0
          end
        end
      else
        L0 = _UPVALUE6_
        L1 = _UPVALUE3_
        L0 = L0(L1)
        _UPVALUE0_ = L0
        L0 = _UPVALUE0_
        if L0 == "" then
          L0 = _UPVALUE3_
          if L0 == "" then
            L0 = "feeding"
            _UPVALUE2_ = L0
          else
            L0 = _UPVALUE1_
            L0 = L0.error
            L1 = "filter returned \"\""
            L0(L1)
          end
        else
          L0 = _UPVALUE0_
          if not L0 then
            L0 = _UPVALUE3_
            if L0 then
              L0 = _UPVALUE1_
              L0 = L0.error
              L1 = "filter returned inappropriate nil"
              L0(L1)
            else
              L0 = nil
              return L0
            end
          else
            L0 = _UPVALUE0_
            return L0
          end
        end
      end
    end
  end
  return L7
end
L5.chain = L9
function L9(...)
  local L1, L2, L3, L4
  L1 = {}
  L2, L3, L4 = ...
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L2 = _UPVALUE0_
  L2 = L2.remove
  L3 = L1
  L4 = 1
  L2 = L2(L3, L4)
  function L3()
    local L0, L1, L2, L3, L4
    while true do
      L0 = _UPVALUE0_
      if not L0 then
        break
      end
      L0 = _UPVALUE0_
      L0, L1 = L0()
      if L0 then
        return L0
      end
      if L1 then
        L2 = nil
        L3 = L1
        return L2, L3
      end
      L2 = _UPVALUE1_
      L2 = L2.remove
      L3 = _UPVALUE2_
      L4 = 1
      L2 = L2(L3, L4)
      _UPVALUE0_ = L2
    end
  end
  return L3
end
L5.cat = L9
function L9(A0)
  local L1, L2, L3
  if not A0 then
    L1 = {}
    A0 = L1
  end
  function L1(A0, A1)
    local L2, L3, L4
    if A0 then
      L2 = _UPVALUE0_
      L2 = L2.insert
      L3 = _UPVALUE1_
      L4 = A0
      L2(L3, L4)
    end
    L2 = 1
    return L2
  end
  L2 = L1
  L3 = A0
  return L2, L3
end
L6.table = L9
function L9(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.assert
  L2 = A0
  L1(L2)
  function L1(A0, A1)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2, L3 = L2(L3, L4)
    if not L2 then
      L4 = nil
      L5 = L3
      return L4, L5
    end
    L4 = L3 or L4
    if not L3 then
      L4 = _UPVALUE0_
    end
    _UPVALUE0_ = L4
    L4 = 1
    return L4
  end
  return L1
end
L6.simplify = L9
function L9(A0, A1)
  local L2, L3
  if A0 then
    function L2(A0, A1)
      local L2, L3, L4
      if not A0 then
        L2 = _UPVALUE0_
        L3 = L2
        L2 = L2.close
        L2(L3)
        L2 = 1
        return L2
      else
        L2 = _UPVALUE0_
        L3 = L2
        L2 = L2.write
        L4 = A0
        return L2(L3, L4)
      end
    end
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.error
    L3 = A1 or L3
    if not A1 then
      L3 = "unable to open file"
    end
    return L2(L3)
  end
end
L6.file = L9
function L9()
  local L0, L1
  L0 = 1
  return L0
end
function L10()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
L6.null = L10
function L10(A0)
  local L1
  function L1()
    local L0, L1
    L1 = _UPVALUE0_
    return L0, L1
  end
  return L1
end
L6.error = L10
function L10(A0, A1, ...)
  local L3, L4, L5, L6
  L3 = (...)
  if L3 then
    L3 = {}
    L4 = A0
    L5 = A1
    L6 = ...
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = _UPVALUE0_
    L4 = L4.remove
    L5 = L3
    L6 = #L3
    L4 = L4(L5, L6)
    A1 = L4
    L4 = _UPVALUE1_
    L4 = L4.chain
    L5 = unpack
    L6 = L3
    L5, L6 = L5(L6)
    L4 = L4(L5, L6)
    A0 = L4
  end
  L3 = _UPVALUE2_
  L3 = L3.assert
  L4 = A0 or L4
  if A0 then
    L4 = A1
  end
  L3(L4)
  function L3(A0, A1)
    local L2, L3, L4, L5, L6, L7
    if A0 ~= "" then
      L2 = _UPVALUE0_
      L3 = A0
      L2 = L2(L3)
      L3 = A0 or L3
      if A0 then
        L3 = ""
      end
      while true do
        L4 = _UPVALUE1_
        L5 = L2
        L6 = A1
        L4, L5 = L4(L5, L6)
        if not L4 then
          L6 = nil
          L7 = L5
          return L6, L7
        end
        if L2 == L3 then
          L6 = 1
          return L6
        end
        L6 = _UPVALUE0_
        L7 = L3
        L6 = L6(L7)
        L2 = L6
      end
    else
      L2 = 1
      return L2
    end
  end
  return L3
end
L6.chain = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0
  L2, L3 = L2()
  L4 = A1
  L5 = L2
  L6 = L3
  L4, L5 = L4(L5, L6)
  if L2 and L4 then
    L6 = 1
    return L6
  else
    L6 = nil
    L7 = L3 or L7
    if not L3 then
      L7 = L5
    end
    return L6, L7
  end
end
L7.step = L10
function L10(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L3 = L3.assert
  L4 = A0 or L4
  if A0 then
    L4 = A1
  end
  L3(L4)
  if not A2 then
    L3 = _UPVALUE1_
    A2 = L3.step
  end
  while true do
    L3 = A2
    L4 = A0
    L5 = A1
    L3, L4 = L3(L4, L5)
    if not L3 then
      if L4 then
        L5 = nil
        L6 = L4
        return L5, L6
      else
        L5 = 1
        return L5
      end
    end
  end
end
L7.all = L10
return L3
