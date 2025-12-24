local L0, L1, L2, L3
L0 = module
L1 = "xiaoqiang.module.XQExtendWifi"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
L1 = "/tmp/replace_router"
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = type
  L1 = L1(L2)
  if L1 ~= "string" or A0 == nil then
    return
  end
  L1 = io
  L1 = L1.open
  L1 = L1(L2, L3)
  if L1 == nil then
    return
  end
  for L5 in L2, L3, L4 do
    L6 = string
    L6 = L6.find
    L7 = L5
    L8 = A0
    L9 = "="
    L8 = L8 .. L9
    L6 = L6(L7, L8)
    if L6 ~= nil then
      L7 = string
      L7 = L7.sub
      L8 = L5
      L9 = string
      L9 = L9.len
      L10 = A0
      L9 = L9(L10)
      L9 = L6 + L9
      L9 = L9 + 1
      L7 = L7(L8, L9)
      L8 = io
      L8 = L8.close
      L9 = L1
      L8(L9)
      return L7
    end
  end
  L2(L3)
end
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = type
  L3 = A0
  L2 = L2(L3)
  if L2 ~= "string" or A0 == nil then
    return
  end
  L2 = type
  L3 = A1
  L2 = L2(L3)
  if L2 ~= "string" or A1 == nil then
    return
  end
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = string
  L3 = L3.format
  L4 = "echo %s='%s' >>%s"
  L5 = A0
  L6 = L2._strformat
  L7 = A1
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L3 = L3(L4, L5, L6, L7)
  L4 = os
  L4 = L4.execute
  L5 = L3
  L4(L5)
  L4 = get_val
  L5 = A0
  return L4(L5)
end
write_t_v = L3
function L3(A0)
  local L1, L2, L3, L4
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 ~= "string" or A0 == nil then
    return
  end
  L1 = "sed -i '/"
  L2 = A0
  L3 = "/d' "
  L4 = _UPVALUE0_
  L1 = L1 .. L2 .. L3 .. L4
  L2 = _UPVALUE1_
  L3 = A0
  L2 = L2(L3)
  L3 = os
  L3 = L3.execute
  L4 = L1
  L3(L4)
  return L2
end
clean_type_and_val = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 ~= "string" or A0 == nil then
    L1 = print
    L2 = "get type error type:"
    L3 = type
    L4 = A0
    L3 = L3(L4)
    L4 = "type:"
    L5 = A0
    L2 = L2 .. L3 .. L4 .. L5
    L1(L2)
    return
  end
  L1 = print
  L2 = "will get type"
  L1(L2)
  L1 = _UPVALUE0_
  L2 = A0
  return L1(L2)
end
get_val = L3
function L3()
  local L0, L1
  L0 = get_val
  L1 = "peer_ip"
  return L0(L1)
end
get_peer_ip = L3
function L3()
  local L0, L1
  L0 = get_val
  L1 = "self_ip"
  return L0(L1)
end
get_self_ip = L3
function L3()
  local L0, L1
  L0 = get_val
  L1 = "self_ifname"
  return L0(L1)
end
get_self_ifname = L3
function L3()
  local L0, L1
  L0 = get_val
  L1 = "peer_ifname"
  return L0(L1)
end
get_peer_ifname = L3
function L3()
  local L0, L1
  L0 = get_val
  L1 = "token"
  return L0(L1)
end
get_token = L3
function L3(A0)
  local L1, L2, L3
  L1 = write_t_v
  L2 = "token"
  L3 = A0
  return L1(L2, L3)
end
set_token = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "network"
  L4 = "lan"
  L5 = "ifname"
  return L1(L2, L3, L4, L5)
end
getLanEth = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = "ifconfig "
  L1 = getLanEth
  L1 = L1()
  L2 = " down"
  L0 = L0 .. L1 .. L2
  L1 = os
  L1 = L1.execute
  L2 = L0
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 1
  L3 = "run cmd:"
  L4 = L0
  L3 = L3 .. L4
  L1(L2, L3)
end
landown = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = "ifconfig "
  L1 = getLanEth
  L1 = L1()
  L2 = " up"
  L0 = L0 .. L1 .. L2
  L1 = os
  L1 = L1.execute
  L2 = L0
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 1
  L3 = "run cmd:"
  L4 = L0
  L3 = L3 .. L4
  L1(L2, L3)
end
lanup = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = L4.isStrNil
  L7 = A0
  L6 = L6(L7)
  if not L6 then
    L6 = L4.isStrNil
    L7 = A1
    L6 = L6(L7)
    if not L6 then
      L6 = L4.isStrNil
      L7 = A2
      L6 = L6(L7)
      if not L6 then
        goto lbl_26
      end
    end
  end
  L5.code = 1636
  do return L5 end
  ::lbl_26::
  L6 = clean_type_and_val
  L7 = "token"
  L6(L7)
  L6 = get_peer_ip
  L6 = L6()
  if L6 == nil or L6 == "" then
    L5.code = 1639
    L7 = L3.log
    L8 = 1
    L9 = "func(oneClickGetRemoteTokenForLua),get peer ip error"
    L7(L8, L9)
    return L5
  end
  L7 = get_remote_token
  L8 = L6
  L9 = A0
  L10 = A1
  L11 = A2
  L7 = L7(L8, L9, L10, L11)
  res = L7
  L7 = res
  L7 = L7.code
  if L7 ~= 0 then
    L7 = res
    return L7
  end
  L7 = set_token
  L8 = res
  L8 = L8.result
  L7(L8)
  L7 = res
  L7 = L7.result
  L5.token = L7
  return L5
end
oneClickGetRemoteTokenForLua = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  if A1 == "" or A1 == nil then
    A1 = "0"
  end
  L5 = params_st
  if L5 ~= nil then
    L5 = L3.log
    L6 = 1
    L7 = "func(exten),get api_str"
    L8 = A0
    L9 = " params_str:"
    L10 = A2
    L7 = L7 .. L8 .. L9 .. L10
    L5(L6, L7)
  else
    L5 = L3.log
    L6 = 1
    L7 = "func(exten),get api_str"
    L8 = A0
    L7 = L7 .. L8
    L5(L6, L7)
  end
  if A0 ~= nil and A0 ~= "" then
    L5 = type
    L6 = A0
    L5 = L5(L6)
    if L5 == "string" then
      goto lbl_40
    end
  end
  L4.code = 1636
  do return L4 end
  ::lbl_40::
  if A1 ~= "1" and A1 ~= "0" then
    L4.code = 1639
    L5 = L3.log
    L6 = 1
    L7 = "func(ExtendWifiRequestRemoteAPIForLua),need_token error"
    L5(L6, L7)
    return L4
  end
  L5 = get_peer_ip
  L5 = L5()
  if L5 ~= "" then
    L5 = get_peer_ip
    L5 = L5()
    if L5 ~= nil then
      goto lbl_64
    end
  end
  L4.code = 1639
  L5 = L3.log
  L6 = 1
  L7 = "func(ExtendWifiRequestRemoteAPIForLua),get peer ip error"
  L5(L6, L7)
  do return L4 end
  ::lbl_64::
  L5 = get_token
  L5 = L5()
  if A1 == "1" and (L5 == "" or L5 == nil) then
    L4.code = 1639
    L6 = L3.log
    L7 = 1
    L8 = "func(ExtendWifiRequestRemoteAPIForLua),get token error"
    L6(L7, L8)
    return L4
  end
  if A1 == "1" then
    L6 = L3.log
    L7 = 1
    L8 = "get remote_ip"
    L9 = get_peer_ip
    L9 = L9()
    L10 = " get token:"
    L11 = L5
    L8 = L8 .. L9 .. L10 .. L11
    L6(L7, L8)
  else
    L6 = L3.log
    L7 = 1
    L8 = "get remote_ip"
    L9 = get_peer_ip
    L9 = L9()
    L10 = " do not need token"
    L8 = L8 .. L9 .. L10
    L6(L7, L8)
    L5 = ""
  end
  L6 = nil
  L7 = ExtenWifiRequestRemoteAPI_
  L8 = get_peer_ip
  L8 = L8()
  L9 = A0
  L10 = L5
  L11 = A2
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  L7 = L6.code
  if L7 ~= 0 then
    L7 = L6.code
    L4.code = L7
    L7 = L6.msg
    L4.msg = L7
  else
    L4.code = 0
    L7 = L6.msg
    L4.msg = L7
  end
  L7 = L3.log
  L8 = 1
  L9 = "func(ExtendWifiRequestRemoteAPIForLua).result.msg"
  L10 = L4.msg
  L9 = L9 .. L10
  L7(L8, L9)
  return L4
end
ExtendWifiRequestRemoteAPIForLua = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  if A1 == "" or A1 == nil then
    L3.code = 1612
    return L3
  end
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 ~= "string" then
    L3.code = 1636
    return L3
  end
  if A0 == "" or A0 == nil then
    L3.code = 1612
    return L3
  end
  L4 = type
  L5 = A0
  L4 = L4(L5)
  if L4 ~= "string" then
    L3.code = 1636
    return L3
  end
  if A0 ~= "1" and A0 ~= "2" then
    L3.code = 1636
    return L3
  end
  L4 = ExtendWifiCallNewRouterDataCenterAPI
  L5 = A0
  L6 = 118
  L7 = A1
  L4 = L4(L5, L6, L7)
  L3 = L4
  return L3
end
ExtendWifiSetSynDirForLua = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  if A1 == "" or A1 == nil then
    L3.code = 1612
    return L3
  end
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 ~= "string" then
    L3.code = 1636
    return L3
  end
  if A0 == nil or A0 == "" then
    L3.code = 1612
    return L3
  end
  if A0 ~= "1" and A0 ~= "2" then
    L3.code = 1636
    return L3
  end
  if A0 == "1" then
    L4 = ExtendWifiCallPeerDataCenterAPI
    L5 = A1
    L4 = L4(L5)
    return L4
  else
    L4 = ExtendWifiCallSelfDataCenterAPI
    L5 = A1
    L4 = L4(L5)
    L5 = {}
    L5.code = 0
    L5.msg = L4
    return L5
  end
end
ExtendWifiCallNewRouterDataCenterAPI = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = require
  L5 = "xiaoqiang.util.XQHttpUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.XQLog"
  L5 = L5(L6)
  L6 = {}
  L6.code = 0
  L7 = nil
  L8 = type
  L9 = A0
  L8 = L8(L9)
  if L8 == "string" and A0 ~= nil then
    L8 = type
    L9 = A1
    L8 = L8(L9)
    if L8 == "string" and A1 ~= nil then
      goto lbl_25
    end
  end
  do return end
  ::lbl_25::
  if A2 == "" or A2 == nil then
    L8 = "http://"
    L9 = A0
    L10 = "/cgi-bin/luci"
    L11 = A1
    L7 = L8 .. L9 .. L10 .. L11
  else
    L8 = "http://"
    L9 = A0
    L10 = "/cgi-bin/luci/;stok="
    L11 = A2
    L12 = A1
    L7 = L8 .. L9 .. L10 .. L11 .. L12
  end
  if A3 ~= nil then
    L8 = L5.log
    L9 = 1
    L10 = "func(ExtenWifiRequestRemoteAPI_),url:"
    L11 = L7
    L12 = " params:"
    L13 = A3
    L10 = L10 .. L11 .. L12 .. L13
    L8(L9, L10)
  else
    L8 = L5.log
    L9 = 1
    L10 = "func(ExtenWifiRequestRemoteAPI_),url:"
    L11 = L7
    L10 = L10 .. L11
    L8(L9, L10)
  end
  L8 = L4.httpGetRequest
  L9 = L7
  L10 = A3
  L8 = L8(L9, L10)
  L9 = L8.code
  if L9 == 200 then
    L6.code = 0
    L9 = L8.res
    L6.msg = L9
  else
    L6.code = 1643
    L6.msg = "http request error"
  end
  return L6
end
ExtenWifiRequestRemoteAPI_ = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = L3.binaryBase64Enc
  L5 = A0
  L4 = L4(L5)
  L5 = L2.THRIFT_TUNNEL_TO_DATACENTER
  L5 = L5 % L4
  L6 = require
  L7 = "luci.util"
  L6 = L6(L7)
  L7 = L6.exec
  L8 = L5
  L7 = L7(L8)
  return L7
end
ExtendWifiCallSelfDataCenterAPI = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = "payload="
  L3 = A0
  L2 = L2 .. L3
  L3 = ExtendWifiRequestRemoteAPIForLua
  L4 = "/api/xqdatacenter/request"
  L5 = "1"
  L6 = L2
  L3 = L3(L4, L5, L6)
  L4 = L1.log
  L5 = 1
  L6 = "func(ExtendWifiCallPeerDataCenterAPI)return "
  L7 = L3.code
  L6 = L6 .. L7
  L4(L5, L6)
  return L3
end
ExtendWifiCallPeerDataCenterAPI = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  if A1 == nil or A1 == "" then
    L3.code = 1612
    return L3
  end
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 ~= "string" then
    L3.code = 1636
    return L3
  end
  if A0 == nil or A0 == "" then
    L3.code = 1612
    return L3
  end
  if A0 ~= "1" and A0 ~= "2" then
    L3.code = 1636
    return L3
  end
  if A0 == "1" then
    L4 = ExtendWifiCallSelfDataCenterAPI
    L5 = A1
    L4 = L4(L5)
    L5 = {}
    L5.code = 0
    L5.msg = L4
    L3 = L5
    return L3
  else
    L4 = ExtendWifiCallPeerDataCenterAPI
    L5 = A1
    L4 = L4(L5)
    return L4
  end
end
ExtendWifiCallOldRouterDataCenterAPI = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQHttpUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQNetUtil"
  L6 = L6(L7)
  L7 = {}
  L7.code = 0
  L8 = "http://"
  L9 = A0
  L10 = "/cgi-bin/luci/api/xqsystem/token"
  L8 = L8 .. L9 .. L10
  L9 = {}
  L10 = {}
  L11 = "username"
  L12 = A1
  L10[1] = L11
  L10[2] = L12
  L11 = {}
  L12 = "password"
  L13 = A2
  L11[1] = L12
  L11[2] = L13
  L12 = {}
  L13 = "nonce"
  L14 = A3
  L12[1] = L13
  L12[2] = L14
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = ""
  L11 = table
  L11 = L11.foreach
  L12 = L9
  function L13(A0, A1)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = "="
    L5 = A1[2]
    L6 = "&"
    L2 = L2 .. L3 .. L4 .. L5 .. L6
    _UPVALUE0_ = L2
  end
  L11(L12, L13)
  L11 = L4.log
  L12 = 1
  L13 = "func(get_remote_token),http request: "
  L14 = L8
  L15 = "?"
  L16 = string
  L16 = L16.sub
  L17 = L10
  L18 = 1
  L19 = -2
  L16 = L16(L17, L18, L19)
  L13 = L13 .. L14 .. L15 .. L16
  L11(L12, L13)
  L11 = L5.httpGetRequest
  L12 = L8
  L13 = string
  L13 = L13.sub
  L14 = L10
  L15 = 1
  L16 = -2
  L13, L14, L15, L16, L17, L18, L19 = L13(L14, L15, L16)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
  L12 = L11.code
  if L12 == 200 then
    L12 = require
    L13 = "cjson"
    L12 = L12(L13)
    L13 = L12.decode
    L14 = L11.res
    L13 = L13(L14)
    L14 = L13.code
    if L14 == 0 then
      L7.code = 0
      L14 = L13.token
      L7.result = L14
    else
      L14 = L13.code
      if L14 == 401 then
        L7.code = 1653
      else
        L14 = L13.code
        if L14 == 1582 then
          L7.code = 1654
        else
          L7.code = 1639
        end
      end
    end
  else
    L7.code = 1643
  end
  L12 = L4.log
  L13 = 1
  L14 = "get remote token return code:"
  L15 = L7.code
  L14 = L14 .. L15
  L12(L13, L14)
  return L7
end
get_remote_token = L3
