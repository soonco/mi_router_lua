local L0, L1, L2, L3
L0 = module
L1 = "xiaoqiang.util.XQController"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "json"
L2 = L2(L3)
function L3(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.encode
  L2 = A0
  L1 = L1(L2)
  L2 = "ubus send trafficd \""
  L3 = _UPVALUE1_
  L3 = L3._cmdformat
  L4 = L1
  L3 = L3(L4)
  L4 = "\""
  L2 = L2 .. L3 .. L4
  L3 = os
  L3 = L3.execute
  L4 = L2
  L3(L4)
end
_ubusSend = L3
function L3(A0, A1, A2, A3, A4)
  local L5, L6, L7
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    return
  end
  L5 = {}
  L5.api = 1
  L5.ipaddr = A0
  L5.lan = A1
  L5.wan = A2
  L5.admin = A3
  L5.pridisk = A4
  L6 = _ubusSend
  L7 = L5
  L6(L7)
end
ippermission = L3
function L3(A0, A1, A2, A3, A4)
  local L5, L6, L7
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    return
  end
  L5 = {}
  L5.api = 1
  L5.mac = A0
  L5.lan = A1
  L5.wan = A2
  L5.admin = A3
  L5.pridisk = A4
  L6 = _ubusSend
  L7 = L5
  L6(L7)
end
permission = L3
function L3(A0, A1, A2, A3)
  local L4
  L4 = {}
  L4.api = 2
  L4.mac = ""
  L4.enable = ""
  L4.model = ""
  L4.option = ""
  if A0 then
    L4.mac = A0
    L4.model = A2
    L4.option = A3
  else
    L4.mac = nil
    if A1 then
      L4.enable = 1
    else
      L4.enable = nil
    end
    L4.model = A2
  end
end
wifimacfilter = L3
