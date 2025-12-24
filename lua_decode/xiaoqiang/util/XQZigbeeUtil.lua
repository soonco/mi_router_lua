local L0, L1, L2, L3, L4, L5
L0 = module
L1 = "xiaoqiang.util.XQZigbeeUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.json"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQConfigs"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.util.XQDeviceUtil"
L4 = L4(L5)
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = L1.binaryBase64Enc
  L3 = A0
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.THRIFT_TUNNEL_TO_MIIO
  L3 = L3 % L2
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L5 = L5.decode
  L6 = L4.exec
  L7 = L3
  L6, L7 = L6(L7)
  return L5(L6, L7)
end
request_yeelink = L5
function L5()
  local L0, L1
  L0 = request_yeelink
  L1 = "{\"command\":\"device_list\"}"
  L0 = L0(L1)
  if L0 ~= nil then
    L1 = L0.list
    if L1 ~= nil then
      goto lbl_11
    end
  end
  L1 = 0
  do return L1 end
  ::lbl_11::
  L1 = L0.list
  L1 = #L1
  return L1
end
get_zigbee_count = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = request_yeelink
  L1 = L1(L2)
  if L1 ~= nil then
    if L2 ~= nil and A0 ~= nil then
      goto lbl_12
    end
  end
  do return end
  ::lbl_12::
  for L5, L6 in L2, L3, L4 do
    L7 = {}
    L8 = L6.mac
    L7.mac = L8
    L7.type = "zigbee"
    L7.ctype = 4
    L7.ptype = 3
    L7.online = 0
    L8 = L6.type
    L7.origin_name = L8
    L7.origin_info = L6
    L8 = {}
    L9 = L6.type
    if L9 == "light" then
      L7.name = "\230\153\186\232\131\189\231\129\175\230\179\161"
      L8.icon = "device_list_intelligent_lamp.png"
      L8.name = "Yeelink"
    end
    L7.company = L8
    L9 = _UPVALUE0_
    L9 = L9.getDeviceInfoFromDB
    L9 = L9()
    L10 = L7.mac
    L10 = L9[L10]
    if L10 ~= nil then
      L11 = _UPVALUE1_
      L11 = L11.isStrNil
      L12 = L10.nickname
      L11 = L11(L12)
      if not L11 then
        L11 = L7.mac
        L11 = L9[L11]
        L11 = L11.nickname
        L7.name = L11
      end
    end
    if not L10 then
      L11 = require
      L12 = "xiaoqiang.util.XQDBUtil"
      L11 = L11(L12)
      L12 = L11.saveDeviceInfo
      L13 = L7.mac
      L14 = L7.origin_name
      L15 = ""
      L16 = ""
      L17 = ""
      L12(L13, L14, L15, L16, L17)
    end
    L11 = table
    L11 = L11.insert
    L12 = A0
    L13 = L7
    L11(L12, L13)
  end
end
append_yeelink_list = L5
