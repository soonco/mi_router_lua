local L0, L1, L2
L0 = module
L1 = "config_scan.main_scanner"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = {}
L1 = {}
L1.name = "system"
L1.weight = 1
L2 = {}
L2.name = "wireless"
L2.weight = 1
L0[1] = L1
L0[2] = L2
function L1()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = {}
  for L4, L5 in L1, L2, L3 do
    L6 = require
    L6 = L6(L7)
    L10, L11, L12 = L8()
    for L10, L11 in L7, L8, L9 do
      L0[L10] = L11
    end
  end
  L4 = "config_scan"
  L5 = "meta"
  L6 = "last_score"
  if L2 then
    L4 = L2
    if L3 then
      goto lbl_39
    end
  end
  ::lbl_39::
  L3.last_score = L2
  L0.meta = L3
  L4 = 40 <= L2
  return L3, L4
end
overview = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "config_scan.common"
  L1 = L1(L2)
  L2 = L1.prepare_status
  L3 = A0
  L4 = _UPVALUE0_
  L2(L3, L4)
end
prepare = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = require
  L2 = "config_scan.common"
  L1 = L1(L2)
  L2 = coroutine
  L2 = L2.create
  function L3()
    local L0, L1, L2
    L0 = _UPVALUE0_
    L0 = L0.scan_submod
    L1 = _UPVALUE1_
    L2 = _UPVALUE2_
    return L0(L1, L2)
  end
  L2 = L2(L3)
  L3 = 1
  while true do
    L4 = coroutine
    L4 = L4.status
    L5 = L2
    L4 = L4(L5)
    if L4 == "dead" then
      break
    end
    L4 = nil
    L5 = coroutine
    L5 = L5.resume
    L6 = L2
    L5, L6 = L5(L6)
    L3 = L6
    L4 = L5
  end
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L6 = L4
  L5 = L4.set
  L7 = "config_scan"
  L8 = "meta"
  L9 = "meta"
  L5(L6, L7, L8, L9)
  L6 = L4
  L5 = L4.set
  L7 = "config_scan"
  L8 = "meta"
  L9 = "last_score"
  L10 = tostring
  L11 = math
  L11 = L11.floor
  L12 = 100 * L3
  L11, L12 = L11(L12)
  L10, L11, L12 = L10(L11, L12)
  L5(L6, L7, L8, L9, L10, L11, L12)
  L6 = L4
  L5 = L4.commit
  L7 = "config_scan"
  L5(L6, L7)
  return L3
end
scan = L1
