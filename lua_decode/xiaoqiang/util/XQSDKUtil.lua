local L0, L1, L2, L3, L4, L5
L0 = module
L1 = "xiaoqiang.util.XQSDKUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQPreference"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQConfigs"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.util.XQCryptoUtil"
L4 = L4(L5)
L5 = "sdkfilter"
CONFIG_MACFILTER = L5
function L5(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L2 = A0
  L1 = A0.gsub
  L3 = ":"
  L4 = ""
  return L1(L2, L3, L4)
end
_formatMac = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = _UPVALUE1_
  L1 = L1.get
  L2 = _formatMac
  L3 = A0
  L2 = L2(L3)
  L3 = nil
  L4 = CONFIG_MACFILTER
  L1 = L1(L2, L3, L4)
  if L1 then
    if L1 == "1" then
      L2 = _UPVALUE2_
      L2 = L2.log
      L3 = 6
      L4 = "SDK filter. mac:"
      L5 = A0
      L6 = " OK!"
      L4 = L4 .. L5 .. L6
      L2(L3, L4)
      L2 = true
      return L2
    else
      L2 = _UPVALUE2_
      L2 = L2.log
      L3 = 6
      L4 = "SDK filter. mac:"
      L5 = A0
      L6 = " not allowed"
      L4 = L4 .. L5 .. L6
      L2(L3, L4)
      L2 = false
      return L2
    end
  end
  L2 = false
  return L2
end
checkPermission = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = false
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  if A1 then
    L2 = "1"
    if L2 then
      goto lbl_21
    end
  end
  L2 = "0"
  ::lbl_21::
  L3 = _UPVALUE1_
  L3 = L3.set
  L4 = _formatMac
  L5 = A0
  L4 = L4(L5)
  L5 = L2
  L6 = CONFIG_MACFILTER
  L3(L4, L5, L6)
end
setPermission = L5
