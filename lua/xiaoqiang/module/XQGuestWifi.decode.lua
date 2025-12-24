local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQGuestWifi"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.util.XQWifiUtil"
L1 = L1(L2)
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_all
  L3 = "network"
  L4 = "guest"
  L1 = L1(L2, L3, L4)
  if L1 then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
_checkGuestWifi = L2
function L2(A0, A1)
end
hookLanIPChangeEvent = L2
function L2(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14, L15, L16
  L8 = require
  L9 = "xiaoqiang.util.XQLanWanUtil"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.setGuestWifi
  L10 = A0
  L11 = A1
  L12 = A2
  L13 = A3
  L14 = A4
  L15 = A5
  L16 = A6
  L9 = L9(L10, L11, L12, L13, L14, L15, L16)
  if not L9 then
    L10 = false
    return L10
  end
  L10 = true
  L11 = _checkGuestWifi
  L11 = L11()
  if L11 then
    L10 = false
  end
  if A7 then
    L11 = type
    L12 = A7
    L11 = L11(L12)
    if L11 == "function" then
      L11 = A7
      L12 = L10
      L11(L12)
  end
  elseif L10 then
    L11 = _UPVALUE1_
    L11 = L11.forkExec
    L12 = "sleep 4; /usr/sbin/guestwifi.sh open; lua /usr/sbin/sync_guest_bssid.lua >/dev/null 2>/dev/null"
    L11(L12)
  else
    L11 = _UPVALUE1_
    L11 = L11.forkRestartWifi
    L12 = "lua /usr/sbin/sync_guest_bssid.lua"
    L11(L12)
  end
  L11 = true
  return L11
end
setGuestWifi = L2
function L2(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.delGuestWifi
  L2 = A0
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "sleep 4; /usr/sbin/guestwifi.sh close >/dev/null 2>/dev/null"
  L1(L2)
end
delGuestWifi = L2
