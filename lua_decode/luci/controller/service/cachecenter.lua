local L0, L1, L2, L3
L0 = module
L1 = "luci.controller.service.cachecenter"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = node
  L1 = "service"
  L2 = "cachecenter"
  L0 = L0(L1, L2)
  L1 = firstchild
  L1 = L1()
  L0.target = L1
  L0.title = ""
  L0.order = nil
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "cachecenter"
  L5 = "report_key"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "reportKey"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "service.util.ServiceErrorUtil"
L2 = L2(L3)
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = L1.encode
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = L3.binaryBase64Enc
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = _UPVALUE0_
  L4 = L4.THRIFT_TUNNEL_TO_CACHECENTER
  L4 = L4 % A0
  L5 = _UPVALUE1_
  L5 = L5.write
  L6 = L2.exec
  L7 = L4
  L6, L7 = L6(L7)
  L5(L6, L7)
end
tunnelRequestCachecenter = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = L1.encode
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = L3.binaryBase64Enc
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = _UPVALUE0_
  L4 = L4.THRIFT_TUNNEL_TO_CACHECENTER
  L4 = L4 % A0
  L5 = L2.exec
  L6 = L4
  return L5(L6)
end
requestCachecenter = L3
function L3()
  local L0, L1, L2
  L0 = {}
  L0.api = 1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "key"
  L1 = L1(L2)
  L0.key = L1
  L1 = tunnelRequestCachecenter
  L2 = L0
  L1(L2)
end
reportKey = L3
