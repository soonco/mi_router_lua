local L0, L1, L2, L3, L4, L5, L6
function L0(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  A0 = A0 + 1
  if A3 == "?" then
    L4 = true
    return L4
  else
    L4 = A3.match
    L4 = L4(L5, L6)
    if L4 and A2 == nil then
      L4 = true
      return L4
    end
  end
  L4 = {}
  for L8 in L5, L6, L7 do
    L4[L8] = true
  end
  if L5 == true then
    return L5
  end
  if L5 then
    if L6 == true then
      return L6
    end
  end
  for L9, L10 in L6, L7, L8 do
    L11 = _G
    L11 = L11.checkers
    L11 = L11[L9]
    L12 = type
    L13 = L11
    L12 = L12(L13)
    if L12 == "function" then
      L12 = L11
      L13 = A2
      L12 = L12(L13)
      if L12 == true then
        L12 = true
        return L12
      end
    end
  end
  L9 = "bad argument %s to %s (%s expected, got %s)"
  L10 = A1
  L11 = L6.name
  L12 = A3
  L13 = type
  L14 = A2
  L13, L14 = L13(L14)
  L9 = A0
  L7(L8, L9)
end
function L1(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  A0 = A0 + 1
  for L7, L8 in L4, L5, L6 do
    L9 = type
    L10 = L8
    L9 = L9(L10)
    if L9 == "string" then
    else
      L9 = type
      L10 = L8
      L9 = L9(L10)
      if L9 == "table" then
        L9 = A2[L7]
        L9 = L9 or L9
        A2[L7] = L9
      else
        L9 = error
        L10 = string
        L10 = L10.format
        L11 = "checks: type %q is not supported"
        L12 = type
        L13 = L8
        L12, L13, L14, L15, L16 = L12(L13)
        L10 = L10(L11, L12, L13, L14, L15, L16)
        L11 = A0
        L9(L10, L11)
      end
    end
  end
  for L7, L8 in L4, L5, L6 do
    L9 = string
    L9 = L9.format
    L10 = "%s.%s"
    L11 = A1
    L12 = L7
    L9 = L9(L10, L11, L12)
    L10 = A3[L7]
    if not L10 then
      L11 = debug
      L11 = L11.getinfo
      L12 = A0
      L13 = "nl"
      L11 = L11(L12, L13)
      L12 = error
      L13 = string
      L13 = L13.format
      L14 = "unexpected argument %s to %s"
      L15 = L9
      L16 = L11.name
      L13 = L13(L14, L15, L16)
      L14 = A0
      L12(L13, L14)
    else
      L11 = type
      L12 = L10
      L11 = L11(L12)
      if L11 == "string" then
        L11 = _UPVALUE0_
        L12 = A0
        L13 = L9
        L14 = L8
        L15 = L10
        L11(L12, L13, L14, L15)
      else
        L11 = type
        L12 = L10
        L11 = L11(L12)
        if L11 == "table" then
          L11 = _UPVALUE0_
          L12 = A0
          L13 = L9
          L14 = L8
          L15 = "?table"
          L11(L12, L13, L14, L15)
          if L8 then
            L11 = _UPVALUE1_
            L12 = A0
            L13 = L9
            L14 = L8
            L15 = L10
            L11(L12, L13, L14, L15)
          end
        end
      end
    end
  end
end
function L2(...)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = ...
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  L1[6] = L7
  L1[7] = L8
  L1[8] = L9
  L1[9] = L10
  L1[10] = L11
  L1[11] = L12
  L1[12] = L13
  L1[13] = L14
  L1[14] = L15
  L2 = 1
  if L3 == "number" then
    L2 = L1[1]
    L3(L4, L5)
  end
  L2 = L2 + 1
  for L6 = L3, L4, L5 do
    L7 = L1[L6]
    L8 = debug
    L8 = L8.getlocal
    L9 = L2
    L10 = L6
    L8, L9 = L8(L9, L10)
    if L7 == nil and L8 == nil then
      break
    elseif L7 == nil then
      L10 = error
      L11 = string
      L11 = L11.format
      L12 = "checks: argument %q is not checked"
      L13 = L8
      L11 = L11(L12, L13)
      L12 = L2
      L10(L11, L12)
    elseif L8 == nil then
      L10 = error
      L11 = string
      L11 = L11.format
      L12 = "checks: excess check, absent argument"
      L11 = L11(L12)
      L12 = L2
      L10(L11, L12)
    else
      L10 = type
      L11 = L7
      L10 = L10(L11)
      if L10 == "string" then
        L10 = _UPVALUE0_
        L11 = L2
        L12 = string
        L12 = L12.format
        L13 = "#%d"
        L14 = L6
        L12 = L12(L13, L14)
        L13 = L9
        L14 = L7
        L10(L11, L12, L13, L14)
      else
        L10 = type
        L11 = L7
        L10 = L10(L11)
        if L10 == "table" then
          L10 = _UPVALUE0_
          L11 = L2
          L12 = string
          L12 = L12.format
          L13 = "#%d"
          L14 = L6
          L12 = L12(L13, L14)
          L13 = L9
          L14 = "?table"
          L10(L11, L12, L13, L14)
          L10 = L9 or L10
          if not L9 then
            L10 = {}
          end
          L11 = _UPVALUE1_
          L12 = L2
          L13 = L8
          L14 = L10
          L15 = L7
          L11(L12, L13, L14, L15)
          L11 = debug
          L11 = L11.setlocal
          L12 = L2
          L13 = L6
          L14 = L10
          L11(L12, L13, L14)
        else
          L10 = error
          L11 = string
          L11 = L11.format
          L12 = "checks: type %q is not supported"
          L13 = type
          L14 = L7
          L13, L14, L15 = L13(L14)
          L11 = L11(L12, L13, L14, L15)
          L12 = L2
          L10(L11, L12)
        end
      end
    end
  end
end
L3 = _G
L3.checks = L2
L3 = _G
L4 = rawget
L5 = _G
L6 = "checkers"
L4 = L4(L5, L6)
L4 = L4 or L4
L3.checkers = L4
return L2
