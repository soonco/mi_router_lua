local L0, L1, L2
L0 = module
L1 = "sec_center.config_scanner"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1
  L0 = require
  L1 = "luci.controller.config_scan.index"
  L0 = L0(L1)
  L1 = L0._overview
  return L1()
end
_overview = L0
