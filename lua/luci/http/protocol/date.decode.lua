local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = module
L1 = "luci.http.protocol.date"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.sys.zoneinfo"
L0(L1)
L0 = {}
L1 = "Jan"
L2 = "Feb"
L3 = "Mar"
L4 = "Apr"
L5 = "May"
L6 = "Jun"
L7 = "Jul"
L8 = "Aug"
L9 = "Sep"
L10 = "Oct"
L11 = "Nov"
L12 = "Dec"
L0[1] = L1
L0[2] = L2
L0[3] = L3
L0[4] = L4
L0[5] = L5
L0[6] = L6
L0[7] = L7
L0[8] = L8
L0[9] = L9
L0[10] = L10
L0[11] = L11
L0[12] = L12
MONTHS = L0
function L0(A0)
  local L1, L2, L3, L4, L5
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L2 = A0
    L1 = A0.match
    L3 = "([%+%-])([0-9]+)"
    L1, L2 = L1(L2, L3)
    if L1 == "+" then
      L1 = 1
    else
      L1 = -1
    end
    if L2 then
      L3 = tonumber
      L4 = L2
      L3 = L3(L4)
      L2 = L3
    end
    if L1 and L2 then
      L3 = L1 * 60
      L4 = math
      L4 = L4.floor
      L5 = L2 / 100
      L4 = L4(L5)
      L4 = L4 * 60
      L5 = L2 % 100
      L4 = L4 + L5
      L3 = L3 * L4
      return L3
    else
      L3 = luci
      L3 = L3.sys
      L3 = L3.zoneinfo
      L3 = L3.OFFSET
      L5 = A0
      L4 = A0.lower
      L4 = L4(L5)
      L3 = L3[L4]
      if L3 then
        L3 = luci
        L3 = L3.sys
        L3 = L3.zoneinfo
        L3 = L3.OFFSET
        L5 = A0
        L4 = A0.lower
        L4 = L4(L5)
        L3 = L3[L4]
        return L3
      end
    end
  end
  L1 = 0
  return L1
end
tz_offset = L0
function L0(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = A0
  L1 = A0.match
  L3 = "([A-Z][a-z][a-z]), ([0-9]+) "
  L4 = "([A-Z][a-z][a-z]) ([0-9]+) "
  L5 = "([0-9]+):([0-9]+):([0-9]+) "
  L6 = "([A-Z0-9%+%-]+)"
  L3 = L3 .. L4 .. L5 .. L6
  L1, L2, L3, L4, L5, L6, L7, L8 = L1(L2, L3)
  if L2 and L3 and L4 and L5 and L6 and L7 then
    L9 = 1
    for L13 = L10, L11, L12 do
      L14 = MONTHS
      L14 = L14[L13]
      if L14 == L3 then
        L9 = L13
        break
      end
    end
    L12.year = L4
    L12.month = L9
    L12.day = L2
    L12.hour = L5
    L12.min = L6
    L12.sec = L7
    return L10
  end
  L9 = 0
  return L9
end
to_unix = L0
function L0(A0)
  local L1, L2, L3
  L1 = os
  L1 = L1.date
  L2 = "%a, %d %b %Y %H:%M:%S GMT"
  L3 = A0
  return L1(L2, L3)
end
to_http = L0
function L0(A0, A1)
  local L2, L3, L4
  L3 = A0
  L2 = A0.match
  L4 = "[^0-9]"
  L2 = L2(L3, L4)
  if L2 then
    L2 = to_unix
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  L3 = A1
  L2 = A1.match
  L4 = "[^0-9]"
  L2 = L2(L3, L4)
  if L2 then
    L2 = to_unix
    L3 = A1
    L2 = L2(L3)
    A1 = L2
  end
  if A0 == A1 then
    L2 = 0
    return L2
  elseif A0 < A1 then
    L2 = -1
    return L2
  else
    L2 = 1
    return L2
  end
end
compare = L0
