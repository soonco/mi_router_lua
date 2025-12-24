local L0, L1, L2, L3, L4, L5, L6, L7
L0 = setmetatable
L1 = require
L2 = rawget
L3 = rawset
L4 = module
L5 = "luci.sys.zoneinfo"
L4(L5)
L4 = L0
L5 = _M
L6 = {}
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  if A1 == "TZ" then
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if not L2 then
      L2 = _UPVALUE1_
      L3 = "luci.sys.zoneinfo.tzdata"
      L2 = L2(L3)
      L3 = _UPVALUE2_
      L4 = A0
      L5 = A1
      L6 = _UPVALUE0_
      L7 = L2
      L8 = A1
      L6, L7, L8 = L6(L7, L8)
      L3(L4, L5, L6, L7, L8)
  end
  elseif A1 == "OFFSET" then
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if not L2 then
      L2 = _UPVALUE1_
      L3 = "luci.sys.zoneinfo.tzoffset"
      L2 = L2(L3)
      L3 = _UPVALUE2_
      L4 = A0
      L5 = A1
      L6 = _UPVALUE0_
      L7 = L2
      L8 = A1
      L6, L7, L8 = L6(L7, L8)
      L3(L4, L5, L6, L7, L8)
    end
  end
  L2 = _UPVALUE0_
  L3 = A0
  L4 = A1
  return L2(L3, L4)
end
L6.__index = L7
L4(L5, L6)
