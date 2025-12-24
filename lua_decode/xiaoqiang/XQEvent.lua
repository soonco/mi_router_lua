local L0, L1, L2
L0 = module
L1 = "xiaoqiang.XQEvent"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L3.isStrNil
  L5 = A0
  L4 = L4(L5)
  if L4 then
    return
  end
  L4 = require
  L5 = "xiaoqiang.module.XQGuestWifi"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.module.XQFirewall"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQLanWanUtil"
  L6 = L6(L7)
  L7 = L5.hookDMZLanIPChangeEvent
  L8 = A0
  L9 = A2
  L7(L8, L9)
  L7 = L4.hookLanIPChangeEvent
  L8 = A0
  L9 = A2
  L7(L8, L9)
  L7 = L5.hookPortForwardLanIPChangeEvent
  L8 = A0
  L9 = A2
  L7(L8, L9)
  L7 = L6.hookLanIPChangeEvent
  L8 = A0
  L9 = A1
  L10 = A2
  L7(L8, L9, L10)
end
lanIPChange = L0
