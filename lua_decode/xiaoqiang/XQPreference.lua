local L0, L1, L2, L3
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = module
L2 = "xiaoqiang.XQPreference"
L3 = package
L3 = L3.seeall
L1(L2, L3)
function L1(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = require
  L4 = "luci.model.uci"
  L3(L4)
  A2 = A2 or A2
  if not A0 then
    return A1
  end
  L3 = luci
  L3 = L3.model
  L3 = L3.uci
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get
  L6 = A2
  L7 = "common"
  L8 = A0
  L4 = L4(L5, L6, L7, L8)
  L5 = L4 or L5
  if not L4 then
    L5 = A1
  end
  return L5
end
get = L1
function L1(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = require
  L4 = "luci.model.uci"
  L3(L4)
  A2 = A2 or A2
  L3 = luci
  L3 = L3.model
  L3 = L3.uci
  L3 = L3.cursor
  L3 = L3()
  if A1 == nil then
    A1 = ""
  end
  L5 = L3
  L4 = L3.set
  L6 = A2
  L7 = "common"
  L8 = A0
  L9 = A1
  L4(L5, L6, L7, L8, L9)
  L5 = L3
  L4 = L3.save
  L6 = A2
  L4(L5, L6)
  L5 = L3
  L4 = L3.commit
  L6 = A2
  return L4(L5, L6)
end
set = L1
function L1(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = require
  L5 = "luci.model.uci"
  L4(L5)
  A2 = A2 or A2
  A3 = A3 or A3
  L4 = luci
  L4 = L4.model
  L4 = L4.uci
  L4 = L4.cursor
  L4 = L4()
  L6 = L4
  L5 = L4.get
  L7 = A2
  L8 = A3
  L9 = A0
  L5 = L5(L6, L7, L8, L9)
  L6 = L5 or L6
  if not L5 then
    L6 = A1
  end
  return L6
end
get_ext = L1
function L1(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = require
  L5 = "luci.model.uci"
  L4(L5)
  A2 = A2 or A2
  A3 = A3 or A3
  L4 = luci
  L4 = L4.model
  L4 = L4.uci
  L4 = L4.cursor
  L4 = L4()
  if A1 == nil then
    A1 = ""
  end
  L6 = L4
  L5 = L4.set
  L7 = A2
  L8 = A3
  L9 = A0
  L10 = A1
  L5(L6, L7, L8, L9, L10)
  L6 = L4
  L5 = L4.save
  L7 = A2
  L5(L6, L7)
  L6 = L4
  L5 = L4.commit
  L7 = A2
  return L5(L6, L7)
end
set_ext = L1
