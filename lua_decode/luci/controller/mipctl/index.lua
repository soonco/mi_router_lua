local L0, L1, L2
L0 = module
L1 = "luci.controller.mipctl.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = node
  L1 = "mipctl"
  L0 = L0(L1)
  L1 = firstchild
  L1 = L1()
  L0.target = L1
  L1 = _
  L2 = ""
  L1 = L1(L2)
  L0.title = L1
  L0.order = 110
  L0.sysauth = "admin"
  L0.mediaurlbase = "/xiaoqiang/mipctl"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "mipctl"
  L2[1] = L3
  L3 = template
  L4 = "mipctl/home"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = 1
  L6 = 13
  L1(L2, L3, L4, L5, L6)
end
index = L0
