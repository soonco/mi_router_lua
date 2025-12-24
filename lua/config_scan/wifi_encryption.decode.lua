local L0, L1, L2
L0 = module
L1 = "config_scan.wifi_encryption"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "config_scan"
  L4 = "wifi_encryption"
  L5 = "ignored"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 ~= "1"
  return L1
end
function L1()
  local L0, L1
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1()
  if L1 then
    L1 = 1
    if L1 then
      goto lbl_10
    end
  end
  L1 = 0
  ::lbl_10::
  L0.enable_scan = L1
  return L0
end
overview = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "config_scan.common"
  L1 = L1(L2)
  L2 = L1.prepare_status
  L3 = A0
  L2(L3)
  L2 = io
  L2 = L2.open
  L3 = A0
  L4 = "/meta/display"
  L3 = L3 .. L4
  L4 = "a"
  L2 = L2(L3, L4)
  L3 = L2
  L2 = L2.close
  L2(L3)
end
prepare = L1
function L1(A0)
  local L1
  L1 = A0 == "psk2" or A0 == "psk2+ccmp" or A0 == "ccmp"
  return L1
end
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "config_scan.common"
  L1 = L1(L2)
  L2 = L1.scan_leaf
  L3 = A0
  function L4()
    local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
    L0 = _UPVALUE0_
    L0 = L0()
    if not L0 then
      L0 = 0
      return L0
    end
    L0 = io
    L0 = L0.open
    L1 = _UPVALUE1_
    L2 = "/meta/enable_scan"
    L1 = L1 .. L2
    L2 = "a"
    L0 = L0(L1, L2)
    L1 = L0
    L0 = L0.close
    L0(L1)
    L0 = require
    L1 = "xiaoqiang.util.XQWifiUtil"
    L0 = L0(L1)
    L1 = L0.getAllWifiInfo
    L1 = L1()
    L2 = true
    for L6, L7 in L3, L4, L5 do
      if L2 then
        L8 = L7.encryption
        L2 = L8 or L2
        if L8 then
          L8 = _UPVALUE2_
          L9 = L7.encryption
          L8 = L8(L9)
          L2 = L8
        end
      end
    end
    if L2 then
      if L3 then
        goto lbl_43
      end
    end
    ::lbl_43::
    return L3
  end
  return L2(L3, L4)
end
scan = L2
