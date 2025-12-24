local L0, L1, L2
L0 = module
L1 = "luci.controller.dispatch.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = node
  L0 = L0()
  L1 = L0.target
  if not L1 then
    L1 = alias
    L2 = "dispatch"
    L1 = L1(L2)
    L0.target = L1
    L0.index = true
  end
  L1 = node
  L2 = "dispatch"
  L1 = L1(L2)
  L2 = firstchild
  L2 = L2()
  L1.target = L2
  L2 = _
  L3 = ""
  L2 = L2(L3)
  L1.title = L2
  L1.order = 1
  L1.sysauth = "admin"
  L1.mediaurlbase = "/xiaoqiang/dispatch"
  L1.sysauth_authenticator = "htmlauth"
  L1.index = true
  L2 = entry
  L3 = {}
  L4 = "dispatch"
  L3[1] = L4
  L4 = template
  L5 = "index"
  L4 = L4(L5)
  L5 = _
  L6 = "\232\183\179\232\189\172"
  L5 = L5(L6)
  L6 = 1
  L7 = 9
  L2(L3, L4, L5, L6, L7)
end
index = L0
