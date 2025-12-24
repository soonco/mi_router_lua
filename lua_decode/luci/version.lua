local L0, L1, L2, L3, L4, L5
L0 = pcall
L1 = dofile
L2 = _G
L3 = module
L4 = "luci.version"
L3(L4)
L3 = L0
L4 = L1
L5 = "/etc/openwrt_release"
L3 = L3(L4, L5)
if L3 then
  L3 = L2.DISTRIB_DESCRIPTION
  if L3 then
    L3 = ""
    distname = L3
    L3 = L2.DISTRIB_DESCRIPTION
    distversion = L3
end
else
  L3 = "OpenWrt Firmware"
  distname = L3
  L3 = "Development Snapshot"
  distversion = L3
end
L3 = "LuCI 0.11.1 Release"
luciname = L3
L3 = "0.11.1"
luciversion = L3
