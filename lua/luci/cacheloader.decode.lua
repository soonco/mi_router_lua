local L0, L1, L2, L3
L0 = require
L1 = "luci.config"
L0 = L0(L1)
L1 = require
L2 = "luci.ccache"
L1 = L1(L2)
L2 = module
L3 = "luci.cacheloader"
L2(L3)
L2 = L0.ccache
if L2 then
  L2 = L0.ccache
  L2 = L2.enable
  if L2 == "1" then
    L2 = L1.cache_ondemand
    L2()
  end
end
