local L0, L1, L2, L3, L4, L5, L6, L7
L0 = module
L1 = "xiaoqiang.util.XQParam"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = {}
L1 = require
L2 = "checks"
L1 = L1(L2)
L2 = require
L3 = "cjson"
L2 = L2(L3)
L3 = require
L4 = "luci.cbi.datatypes"
L3 = L3(L4)
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = false
  if A1 then
    if L3 == "table" then
      for L6, L7 in L3, L4, L5 do
        if A0 == L7 then
          L2 = true
          break
        end
      end
    end
  end
  return L2
end
L0.set = L4
function L4(A0, A1)
  local L2, L3, L4
  if A1 then
    L2 = type
    L3 = A1
    L2 = L2(L3)
    if L2 == "string" then
      L2 = string
      L2 = L2.match
      L3 = A0
      L4 = A1
      L2 = L2(L3, L4)
      if L2 then
        L2 = true
        return L2
      end
    end
  end
  L2 = false
  return L2
end
L0.regex = L4
function L4(A0, A1)
  local L2, L3, L4, L5
  L2 = true
  L3 = A1.rule
  if L3 then
    L3 = verify
    L4 = A0
    L5 = A1.rule
    L3 = L3(L4, L5)
    L2 = L3
  end
  L3 = type
  L4 = A1.func
  L3 = L3(L4)
  if L3 == "function" then
    if L2 then
      L3 = A1.func
      L4 = A0
      L5 = A1.farg
      L3 = L3(L4, L5)
      L2 = L3
    end
  else
    L2 = false
  end
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 == "boolean" then
    return L2
  else
    L3 = false
    return L3
  end
end
L0.func = L4
function L4(A0, A1)
  local L2, L3, L4
  L2 = A1.name
  if L2 then
    L2 = _UPVALUE0_
    L3 = A1.name
    L2 = L2[L3]
    if L2 then
      L2 = _UPVALUE0_
      L3 = A1.name
      L2 = L2[L3]
      L3 = A0
      L4 = A1.arg
      return L2(L3, L4)
    end
  end
  L2 = false
  return L2
end
function L5(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = A1
  L4 = "string"
  L2(L3, L4)
end
function L6(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = false
  L3 = type
  L4 = A1
  L3 = L3(L4)
  if L3 == "string" then
    L3 = pcall
    L4 = _UPVALUE0_
    L5 = A0
    L6 = A1
    L3, L4 = L3(L4, L5, L6)
    _ = L4
    L2 = L3
  else
    L3 = type
    L4 = A1
    L3 = L3(L4)
    if L3 == "table" then
      L3 = _UPVALUE1_
      L4 = A0
      L5 = A1
      L3 = L3(L4, L5)
      L2 = L3
    end
  end
  return L2
end
verify = L6
L6 = checkers
function L7(A0)
  local L1, L2, L3, L4
  L1 = [[
^[^`;>|$&
]+$]]
  L2 = _UPVALUE0_
  L2 = L2.regex
  L3 = A0
  L4 = L1
  return L2(L3, L4)
end
L6.commonstr = L7
L6 = checkers
function L7(A0)
  local L1, L2, L3, L4
  L1 = "^[a-zA-Z0-9]+$"
  L2 = _UPVALUE0_
  L2 = L2.regex
  L3 = A0
  L4 = L1
  return L2(L3, L4)
end
L6.engXnumstr = L7
L6 = checkers
function L7(A0)
  local L1, L2, L3, L4
  L1 = "^[0-9]+$"
  L2 = _UPVALUE0_
  L2 = L2.regex
  L3 = A0
  L4 = L1
  return L2(L3, L4)
end
L6.numberstr = L7
L6 = checkers
function L7(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.macaddr
  L2 = A0
  return L1(L2)
end
L6.macaddr = L7
L6 = checkers
function L7(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.ip4addr
  L2 = A0
  return L1(L2)
end
L6.ip4addr = L7
L6 = checkers
function L7(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.ip6addr
  L2 = A0
  return L1(L2)
end
L6.ip6addr = L7
L6 = checkers
function L7(A0)
  local L1, L2, L3, L4
  L2 = pcall
  L3 = _UPVALUE0_
  L3 = L3.decode
  L4 = A0
  L2, L3 = L2(L3, L4)
  _ = L3
  L1 = L2
  return L1
end
L6.json = L7
