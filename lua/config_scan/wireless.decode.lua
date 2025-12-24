local L0, L1, L2, L3
L0 = module
L1 = "config_scan.wireless"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = {}
L1 = {}
L1.name = "wifi_passwd_security"
L1.weight = 1
L2 = {}
L2.name = "wifi_encryption"
L2.weight = 1
L3 = {}
L3.name = "anti_squatter"
L3.weight = 1
L0[1] = L1
L0[2] = L2
L0[3] = L3
function L1()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  for L4, L5 in L1, L2, L3 do
    L6 = require
    L7 = "config_scan."
    L8 = L5.name
    L7 = L7 .. L8
    L6 = L6(L7)
    L7 = L5.name
    L8 = L6.overview
    L8 = L8()
    L0[L7] = L8
  end
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
  L4 = _UPVALUE0_
  L2(L3, L4)
end
prepare = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "config_scan.common"
  L1 = L1(L2)
  L2 = L1.scan_submod
  L3 = A0
  L4 = _UPVALUE0_
  return L2(L3, L4)
end
scan = L1
