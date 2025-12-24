local L0, L1, L2, L3
L0 = require
L1 = _G
L1 = L1.bit
if not L1 then
  L1 = _G
  L2 = L0
  L3 = "bit"
  L2 = L2(L3)
  L1.bit = L2
end
L1 = module
L2 = "luci"
L1(L2)
L1 = L0
L2 = "luci.version"
L1 = L1(L2)
L2 = L1.luciversion
L2 = L2 or L2
__version__ = L2
L2 = L1.luciname
L2 = L2 or L2
__appname__ = L2
