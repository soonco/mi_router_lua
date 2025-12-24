local L0, L1, L2, L3
L0 = module
L1 = "luci.controller.sec_center.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQFeatures"
L0 = L0(L1)
L0 = L0.FEATURES
L1 = "sec_center"
L2 = require
L3 = "luci.http"
L2 = L2(L3)
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = node
  L1 = "api"
  L2 = "sec_center"
  L0 = L0(L1, L2)
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "sec_center"
  L5 = "overview"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "overview"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
end
index = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = {}
  L1 = require
  L2 = "posix"
  L1 = L1(L2)
  L2 = L1.dir
  L3 = "/usr/lib/lua/"
  L3 = L3 .. L4
  L2 = L2(L3)
  files = L2
  L2 = files
  if not L2 then
    L2 = L0
    L3 = 0
    return L2, L3, L4
  end
  L2 = 0
  L3 = 0
  for L7, L8 in L4, L5, L6 do
    if L8 ~= "." and L8 ~= ".." then
      L9 = string
      L9 = L9.gsub
      L10 = L8
      L11 = "%.lua"
      L12 = ""
      L9 = L9(L10, L11, L12)
      L8 = L9
      L9 = require
      L10 = _UPVALUE0_
      L11 = "."
      L12 = L8
      L10 = L10 .. L11 .. L12
      L9 = L9(L10)
      L10 = L9._overview
      L10, L11 = L10()
      if L10 then
        L0[L8] = L10
        L3 = L3 + 1
        if L11 then
          L2 = L2 + 1
        end
      end
    end
  end
  L4.insecure = L5
  L4.total = L3
  L0.meta = L4
  return L0
end
_overview = L3
function L3()
  local L0, L1, L2
  L0 = _overview
  L0 = L0()
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
overview = L3
