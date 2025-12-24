local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
L0 = module
L1 = "xiaoqiang.util.XQPortServiceUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "luci.model.uci"
L1 = L1(L2)
L1 = L1.cursor
L1 = L1()
L2 = require
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = "port_map"
L5 = "port_service"
L6 = {}
L6.WAN1 = "wan"
L6.WAN2 = "wan_2"
PS_WAN_SERVICE_NAME_MAP = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = {}
  L1.wan = "WAN"
  L1.wan_2 = "WAN2"
  L1.lan = "LAN"
  L1.lag = "\232\129\154\229\144\136\229\143\163"
  L1.iptv = "IPTV"
  L1.game = "\230\184\184\230\136\143\231\189\145\229\143\163"
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = _UPVALUE1_
  L5 = "port"
  function L6(A0)
    local L1, L2, L3, L4
    L1 = {}
    L2 = A0.type
    if "cpe" == L2 then
      return
    end
    L2 = A0[".name"]
    L1.port = L2
    L2 = L1.port
    L1.index = L2
    L2 = A0.speed
    L1.speed = L2
    L2 = A0.service
    L1.service = L2
    L2 = A0.label
    L1.label = L2
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = L1.service
    L2 = L2(L3)
    if not L2 then
      L2 = _UPVALUE1_
      L3 = L1.service
      L2 = L2[L3]
      L1.service = L2
    end
    L2 = _UPVALUE2_
    L3 = tonumber
    L4 = L1.index
    L3 = L3(L4)
    L2[L3] = L1
  end
  L2(L3, L4, L5, L6)
  return L0
end
psGetMap = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = "settings"
  L5 = "description"
  L1 = L1(L2, L3, L4, L5)
  L0 = L1
  if L0 then
    return L0
  else
    L1 = ""
    return L1
  end
end
psGetMapDesc = L6
function L6()
  local L0, L1
  L0 = true
  return L0
end
psRebuildMap = L6
function L6()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "/usr/sbin/port_service restart"
  L0(L1)
  L0 = true
  return L0
end
psReload = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    A0 = ""
  end
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = "/usr/sbin/port_service restart "
  L3 = tostring
  L4 = A0
  L3 = L3(L4)
  L2 = L2 .. L3
  L1(L2)
  L1 = true
  return L1
end
psRestart = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L7 = "settings"
  L8 = "service_vids"
  L2 = L4
  if L4 then
    return L4
  end
  for L7 in L4, L5, L6 do
    L8 = tonumber
    L9 = L7
    L8 = L8(L9)
    L3 = L8 or L3
    if not L8 then
      L3 = 0
    end
    if L3 ~= A1 and L3 == A0 then
      L8 = true
      return L8
    end
  end
  return L4
end
psIsVidConflict = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = {}
  L4, L5 = nil, nil
  if not L6 then
    if not L6 then
      goto lbl_20
    end
  end
  do return L6 end
  ::lbl_20::
  L9 = A0
  L6(L7, L8)
  L9 = "settings"
  L10 = "ports"
  L5 = L6
  L9 = ""
  L5 = L6
  for L9 = L6, L7, L8 do
    L10 = tonumber
    L11 = string
    L11 = L11.sub
    L12 = L5
    L13 = L9
    L14 = L9
    L11, L12, L13, L14 = L11(L12, L13, L14)
    L10 = L10(L11, L12, L13, L14)
    L4 = L10
    if nil ~= L4 then
      L10 = L4 + 1
      L3[L10] = 0
    end
  end
  L9 = ""
  A0 = L6
  L9 = "service"
  function L10(A0)
    local L1, L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A0[".name"]
    if L2 == L3 then
      return
    end
    L2 = _UPVALUE0_
    if L2 ~= "wan" then
      L2 = _UPVALUE0_
      if L2 ~= "wan_2" then
        goto lbl_19
      end
    end
    L2 = A0[".name"]
    if L2 ~= "wan" then
      L2 = A0[".name"]
      if L2 ~= "wan_2" then
        goto lbl_19
      end
    end
    do return end
    ::lbl_19::
    L2 = A0.enable
    if L2 == "1" then
      L1 = A0.ports
    end
    L2 = _UPVALUE1_
    L2 = L2.isStrNil
    L3 = L1
    L2 = L2(L3)
    if not L2 then
      L2 = _UPVALUE2_
      L3 = string
      L3 = L3.gsub
      L4 = L1
      L5 = "%s+"
      L6 = ""
      L3 = L3(L4, L5, L6)
      L2 = L2 .. L3
      _UPVALUE2_ = L2
    end
  end
  L6(L7, L8, L9, L10)
  L9 = A0
  L6(L7, L8)
  for L9 = L6, L7, L8 do
    L10 = tonumber
    L11 = string
    L11 = L11.sub
    L12 = A0
    L13 = L9
    L14 = L9
    L11, L12, L13, L14 = L11(L12, L13, L14)
    L10 = L10(L11, L12, L13, L14)
    L4 = L10
    if nil ~= L4 then
      L10 = L4 + 1
      L10 = L3[L10]
      if 0 == L10 then
        goto lbl_118
      end
    end
    L10 = _UPVALUE1_
    L10 = L10.log
    L11 = 5
    L12 = "check fail: "
    L13 = L2.encode
    L14 = L3
    L13 = L13(L14)
    L12 = L12 .. L13
    L10(L11, L12)
    L10 = true
    do return L10 end
    ::lbl_118::
    L10 = L4 + 1
    L3[L10] = 1
  end
  L9 = L2.encode
  L10 = L3
  L9 = L9(L10)
  L6(L7, L8)
  return L6
end
psIsPortConflict = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = ""
  L3 = ""
  if nil == A0 or nil == A1 then
    L4 = false
    return L4
  end
  L4 = psWandtEnable
  L4 = L4()
  if 1 == L4 then
    L4 = false
    return L4
  end
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L7 = A0
  L8 = "enable"
  L4 = L4(L5, L6, L7, L8)
  L3 = L4
  if nil ~= L3 then
    L4 = tostring
    L5 = L3
    L4 = L4(L5)
    if "1" == L4 then
      goto lbl_31
    end
  end
  L4 = false
  do return L4 end
  ::lbl_31::
  L4 = _UPVALUE2_
  L4 = L4.exec
  L5 = "port_map port service "
  L6 = A0
  L5 = L5 .. L6
  L4 = L4(L5)
  L2 = L4
  if nil == L2 then
    L4 = false
    return L4
  else
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.set
    L6 = _UPVALUE1_
    L7 = A0
    L8 = "link_mode"
    L9 = A1
    L4(L5, L6, L7, L8, L9)
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.commit
    L6 = _UPVALUE1_
    L4(L5, L6)
    L4 = os
    L4 = L4.execute
    L5 = "/sbin/phyhelper mode set "
    L6 = tostring
    L7 = L2
    L6 = L6(L7)
    L7 = " "
    L8 = tostring
    L9 = A1
    L8 = L8(L9)
    L9 = " &"
    L5 = L5 .. L6 .. L7 .. L8 .. L9
    L4(L5)
    L4 = true
    return L4
  end
end
psSetWanLinkMode = L6
function L6(A0)
  local L1, L2, L3, L4
  if nil == A0 then
    L1 = false
    return L1
  end
  L1 = os
  L1 = L1.execute
  L2 = "/sbin/phyhelper restart "
  L3 = tostring
  L4 = A0
  L3 = L3(L4)
  L4 = " > /dev/console"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = true
  return L1
end
psPortReLink = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L3 = 0
  if nil ~= A0 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE1_
    L7 = A0
    L8 = "link_mode"
    L4 = L4(L5, L6, L7, L8)
    L1 = L4
  end
  if nil ~= L1 then
    L4 = tonumber
    L5 = L1
    L4 = L4(L5)
    L3 = L4 or L3
    if not L4 then
      L3 = 0
    end
  end
  return L3
end
psGetWanLinkMode = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L3 = "0G"
  if nil ~= A0 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE1_
    L7 = A0
    L8 = "ports"
    L4 = L4(L5, L6, L7, L8)
    L2 = L4
  end
  if nil ~= L2 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE2_
    L7 = L2
    L8 = "speed"
    L4 = L4(L5, L6, L7, L8)
    L1 = L4
  end
  if nil ~= L1 then
    L4 = tostring
    L5 = L1
    L4 = L4(L5)
    L3 = L4
  end
  return L3
end
psGetWanSpeed = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L3 = "No Port"
  if nil ~= A0 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE1_
    L7 = A0
    L8 = "ports"
    L4 = L4(L5, L6, L7, L8)
    L2 = L4
  end
  if nil ~= L2 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE2_
    L7 = L2
    L8 = "label"
    L4 = L4(L5, L6, L7, L8)
    L1 = L4
  end
  if nil ~= L1 then
    L4 = tostring
    L5 = L1
    L4 = L4(L5)
    L3 = L4
  end
  return L3
end
psGetLabel = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L3 = "No Port"
  if nil ~= A0 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE1_
    L7 = A0
    L8 = "ports"
    L4 = L4(L5, L6, L7, L8)
    L2 = L4
  end
  if nil ~= L2 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = _UPVALUE2_
    L7 = L2
    L8 = "type"
    L4 = L4(L5, L6, L7, L8)
    L1 = L4
  end
  if nil ~= L1 then
    L4 = tostring
    L5 = L1
    L4 = L4(L5)
    L3 = L4
  end
  return L3
end
psGetType = L6
function L6()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = _UPVALUE1_
  L3 = "wan"
  L4 = "wandt"
  L0 = L0(L1, L2, L3, L4)
  if L0 then
    L1 = tonumber
    L2 = L0
    L1 = L1(L2)
    if L1 then
      goto lbl_15
    end
  end
  L1 = 0
  ::lbl_15::
  return L1
end
psWandtEnable = L6
function L6()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = _UPVALUE1_
  L3 = "wan_2"
  L4 = "enable"
  L0 = L0(L1, L2, L3, L4)
  if L0 then
    L1 = tonumber
    L2 = L0
    L1 = L1(L2)
    if L1 then
      goto lbl_15
    end
  end
  L1 = 0
  ::lbl_15::
  return L1
end
psMultiwanEnable = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = _UPVALUE1_
  L3 = "iptv"
  L4 = "enable"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = "iptv_attr"
  L5 = "vid"
  L1 = L1(L2, L3, L4, L5)
  if L0 then
    L2 = tonumber
    L3 = L0
    L2 = L2(L3)
    if 1 == L2 then
      goto lbl_22
    end
  end
  L2 = 0
  do return L2 end
  ::lbl_22::
  if L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if 0 == L2 then
      L2 = 1
      if L2 then
        goto lbl_33
      end
    end
  end
  L2 = 0
  ::lbl_33::
  return L2
end
psIptvBridgeEnable = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = "wan"
  L5 = "wandt"
  L1 = L1(L2, L3, L4, L5)
  if L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 then
      goto lbl_16
    end
  end
  L2 = 0
  ::lbl_16::
  L0.enable = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = _UPVALUE1_
  L5 = "wan"
  L6 = "ports"
  L2 = L2(L3, L4, L5, L6)
  if L2 then
    L3 = tonumber
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_31
    end
  end
  L3 = -1
  ::lbl_31::
  L0.wan_port = L3
  L3 = L0.wan_port
  L0.index = L3
  return L0
end
wandtGetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  if nil == A0 then
    L1 = false
    L2 = 0
    return L1, L2
  end
  L1 = psMultiwanEnable
  L1 = L1()
  if 1 == L1 then
    L1 = A0.enable
    if 1 == L1 then
      L1 = true
      L2 = 0
      return L1, L2
    end
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "wan"
  L5 = "wandt"
  L6 = A0.enable
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "wan"
  L5 = "ports"
  L6 = A0.wan_port
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.commit
  L3 = _UPVALUE1_
  L1(L2, L3)
  L1 = psRestart
  L2 = "wan"
  L1(L2)
  L1 = true
  L2 = 0
  return L1, L2
end
wandtSetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  if nil == A0 then
    L2 = nil
    return L2
  end
  L2 = tonumber
  L3 = A0.formvalue
  L4 = "enable"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  if nil == L2 or L2 < 0 or 1 < L2 then
    L3 = nil
    return L3
  end
  L1.enable = L2
  L3 = A0.formvalue
  L4 = "wan_port"
  L3 = L3(L4)
  if 0 == L2 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      L4 = psIsPortConflict
      L5 = L3
      L6 = "wan"
      L4 = L4(L5, L6)
    end
    if L4 then
      L4 = nil
      return L4
    end
  else
    L3 = ""
  end
  L1.wan_port = L3
  return L1
end
wandtAnalyConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  if nil == A0 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = A0
  L5 = "wandt"
  L1 = L1(L2, L3, L4, L5)
  if nil ~= L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if 1 == L2 then
      L2 = true
      if L2 then
        goto lbl_22
      end
    end
  end
  L2 = false
  ::lbl_22::
  return L2
end
wandtEnable = L6
function L6()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = " /usr/sbin/port_service redetect force > /dev/console 2>&1; "
  L0(L1)
end
wanRedetect = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L3 = nil
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L7 = "lag"
  L8 = "ports"
  L4 = L4(L5, L6, L7, L8)
  L5 = L4 or L5
  if not L4 then
    L5 = ""
  end
  L2.ports = L5
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = _UPVALUE1_
  L8 = "lag"
  L9 = "enable"
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = tonumber
    L7 = L5
    L6 = L6(L7)
    if L6 then
      goto lbl_33
    end
  end
  L6 = 0
  ::lbl_33::
  L2.enable = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = _UPVALUE1_
  L9 = "lag_attr"
  L10 = "mode"
  L6 = L6(L7, L8, L9, L10)
  if L6 then
    L7 = tonumber
    L8 = L6
    L7 = L7(L8)
    if L7 then
      goto lbl_48
    end
  end
  L7 = 0
  ::lbl_48::
  L2.mode = L7
  L7 = L0.decode
  L8 = L1.trim
  L9 = L1.exec
  L10 = "lag.sh status"
  L9, L10 = L9(L10)
  L8 = L8(L9, L10)
  L8 = L8 or L8
  L7 = L7(L8)
  L3 = L7
  if nil ~= L3 then
    L7 = L3.code
    L2.status = L7
    L7 = L3.info
    L2.info = L7
  end
  return L2
end
lagGetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  if nil == A0 then
    L1 = false
    L2 = 0
    return L1, L2
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "lag"
  L5 = "enable"
  L6 = A0.enable
  L1(L2, L3, L4, L5, L6)
  L1 = A0.enable
  if L1 == 1 then
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.set
    L3 = _UPVALUE1_
    L4 = "lag"
    L5 = "ports"
    L6 = A0.ports
    L1(L2, L3, L4, L5, L6)
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.set
    L3 = _UPVALUE1_
    L4 = "lag_attr"
    L5 = "mode"
    L6 = A0.mode
    L1(L2, L3, L4, L5, L6)
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.commit
  L3 = _UPVALUE1_
  L1(L2, L3)
  L1 = psRestart
  L2 = "lag"
  L1(L2)
  L1 = true
  L2 = 1
  return L1, L2
end
lagSetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  if nil == A0 then
    L2 = nil
    return L2
  end
  L2 = tonumber
  L3 = A0.formvalue
  L4 = "enable"
  L3, L4, L5, L6, L7 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7)
  if nil == L2 or L2 < 0 or 1 < L2 then
    L3 = nil
    return L3
  end
  L1.enable = L2
  L3 = tonumber
  L4 = A0.formvalue
  L5 = "mode"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  if nil == L3 or L3 < 0 then
    L4 = nil
    return L4
  end
  L1.mode = L3
  L4 = A0.formvalue
  L5 = "ports"
  L4 = L4(L5)
  if 1 == L2 then
    L5 = _UPVALUE0_
    L5 = L5.isStrNil
    L6 = L4
    L5 = L5(L6)
    if not L5 then
      L5 = psIsPortConflict
      L6 = L4
      L7 = "lag"
      L5 = L5(L6, L7)
    end
    if L5 then
      L5 = nil
      return L5
    end
  else
    L4 = ""
  end
  L1.ports = L4
  return L1
end
lagAnalyConfig = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = "iptv"
  L5 = "enable"
  L1 = L1(L2, L3, L4, L5)
  if L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 then
      goto lbl_16
    end
  end
  L2 = 0
  ::lbl_16::
  L0.enable = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = _UPVALUE1_
  L5 = "iptv"
  L6 = "ports"
  L2 = L2(L3, L4, L5, L6)
  L3 = L2 or L3
  if not L2 then
    L3 = ""
  end
  L0.ports = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = _UPVALUE1_
  L6 = "iptv_attr"
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    if L4 then
      goto lbl_41
    end
  end
  L4 = 0
  ::lbl_41::
  L0.profile = L4
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = tonumber
    L6 = L4
    L5 = L5(L6)
    if L5 then
      goto lbl_56
    end
  end
  L5 = -1
  ::lbl_56::
  L0.vid = L5
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = tonumber
    L6 = L6(L7)
    if L6 then
      goto lbl_71
    end
  end
  L6 = -1
  ::lbl_71::
  L0.priority = L6
  L6 = _UPVALUE0_
  L6 = L6.get
  L10 = "forbid_vid"
  L6 = L6(L7, L8, L9, L10)
  L0.forbid_vid = ""
  if L6 then
    for L10, L11 in L7, L8, L9 do
      if L11 then
        L12 = tonumber
        L13 = L11
        L12 = L12(L13)
        if nil ~= L12 then
          L12 = L0.forbid_vid
          if L12 ~= "" then
            L12 = L0.forbid_vid
            L13 = ","
            L12 = L12 .. L13
            L0.forbid_vid = L12
          end
          L12 = L0.forbid_vid
          L13 = L11
          L12 = L12 .. L13
          L0.forbid_vid = L12
        end
      end
    end
  end
  L10 = "iptv_attr"
  L11 = "permit_vid"
  if not L7 then
  end
  L0.permit_vid = L8
  return L0
end
iptvGetConfig = L6
function L6()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = _UPVALUE1_
  L3 = "iptv_attr"
  L4 = "permit_vid"
  L0 = L0(L1, L2, L3, L4)
  L1 = L0 or L1
  if not L0 then
    L1 = "1~4094"
  end
  return L1
end
psGetIPTVPermitVid = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  if nil == A0 then
    L1 = false
    L2 = 0
    return L1, L2
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "iptv"
  L5 = "ports"
  L6 = A0.ports
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "iptv"
  L5 = "enable"
  L6 = A0.enable
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "iptv_attr"
  L5 = "profile"
  L6 = A0.profile
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "iptv_attr"
  L5 = "vid"
  L6 = A0.vid
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "iptv_attr"
  L5 = "priority"
  L6 = A0.priority
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.commit
  L3 = _UPVALUE1_
  L1(L2, L3)
  L1 = psRestart
  L2 = "iptv"
  L1(L2)
  L1 = true
  L2 = 5
  return L1, L2
end
iptvSetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = iptvGetConfig
  L1 = L1()
  if nil == A0 then
    L2 = nil
    return L2
  end
  L2 = tonumber
  L3 = A0.formvalue
  L4 = "enable"
  L3, L4, L5, L6, L7, L11, L12, L13, L14 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  if nil == L2 or L2 < 0 or 1 < L2 then
    L3 = nil
    return L3
  end
  L1.enable = L2
  if L2 == 0 then
    return L1
  end
  L3 = tonumber
  L4 = A0.formvalue
  L5 = "profile"
  L4, L5, L6, L7, L11, L12, L13, L14 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  if nil == L3 or L3 < 0 then
    L4 = nil
    return L4
  end
  L1.profile = L3
  L4 = tonumber
  L5 = A0.formvalue
  L6 = "vid"
  L5, L6, L7, L11, L12, L13, L14 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  if nil == L4 or L4 < -1 or 4094 < L4 then
    L5 = nil
    return L5
  end
  L5 = tonumber
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L6, L7, L11, L12, L13, L14 = L6(L7, L8, L9, L10)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L5 = L5 or L5
  if 1 == L2 and L4 == 0 and L5 == 1 then
    L6 = nil
    L7 = 1611
    return L6, L7
  end
  L6 = nil
  L7 = tonumber
  L11 = "iptv"
  L12 = "enable"
  L11, L12, L13, L14 = L8(L9, L10, L11, L12)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14)
  if L7 == 1 then
    L7 = tonumber
    L11 = "iptv_attr"
    L12 = "vid"
    L11, L12, L13, L14 = L8(L9, L10, L11, L12)
    L7 = L7(L8, L9, L10, L11, L12, L13, L14)
    L6 = L7 or L6
    if not L7 then
      L6 = nil
    end
  end
  if 1 == L2 then
    L7 = psIsVidConflict
    L7 = L7(L8, L9)
    if L7 then
      L7 = nil
      return L7, L8
    end
  end
  L7 = _UPVALUE0_
  L7 = L7.get
  L11 = "forbid_vid"
  L7 = L7(L8, L9, L10, L11)
  if L7 then
    for L11, L12 in L8, L9, L10 do
      L13 = tonumber
      L14 = L12
      L13 = L13(L14)
      if L4 == L13 then
        L13 = nil
        L14 = 1805
        return L13, L14
      end
    end
  end
  L1.vid = L4
  L11, L12, L13, L14 = L9(L10)
  if nil == L8 or L8 < -1 or 7 < L8 then
    return L9
  end
  L1.priority = L8
  if 1 == L2 then
    L11 = L9
    if not L10 then
      L11 = L9
      L12 = "iptv"
    end
    if L10 then
      return L10
    end
  else
  end
  L1.ports = L9
  return L1
end
iptvAnalyConfig = L6
L6 = 1
WAN_MODE_FIXED = L6
L6 = 2
WAN_MODE_WANDT = L6
L6 = 3
WAN_MODE_LAN = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = "-1"
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = _UPVALUE1_
  L5 = "wan"
  L6 = "ports"
  L2 = L2(L3, L4, L5, L6)
  if L2 then
    L3 = tonumber
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_17
    end
  end
  L3 = -1
  ::lbl_17::
  L0.wan_port = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = _UPVALUE1_
  L6 = "wan"
  L7 = "enable"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L7 = "wan"
  L8 = "wandt"
  L4 = L4(L5, L6, L7, L8)
  if L2 then
    L5 = _UPVALUE0_
    L6 = L5
    L5 = L5.get
    L7 = _UPVALUE2_
    L8 = L2
    L9 = "label"
    L5 = L5(L6, L7, L8, L9)
    L1 = L5
  end
  L0.wan_label = L1
  if L3 then
    L5 = tonumber
    L6 = L3
    L5 = L5(L6)
    if 1 == L5 then
      if L4 then
        L5 = tonumber
        L6 = L4
        L5 = L5(L6)
        if 1 == L5 then
          L5 = WAN_MODE_WANDT
          L0.mode = L5
      end
      else
        L5 = WAN_MODE_FIXED
        L0.mode = L5
      end
  end
  else
    L5 = WAN_MODE_LAN
    L0.mode = L5
  end
  return L0
end
wanGetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  if nil == A0 then
    L2 = false
    L3 = 0
    return L2, L3
  end
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = _UPVALUE1_
  L5 = "wan_2"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  if L2 == nil then
    L3 = 0
    if L3 then
      goto lbl_25
      L2 = L3 or L2
    end
  end
  L3 = tonumber
  L4 = L2
  L3 = L3(L4)
  L2 = L3
  ::lbl_25::
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = _UPVALUE1_
  L6 = "wan"
  L7 = "enable"
  L8 = A0.enable
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = _UPVALUE1_
  L6 = "wan"
  L7 = "wandt"
  L8 = A0.wandt
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = _UPVALUE1_
  L6 = "wan"
  L7 = "ports"
  L8 = A0.ports
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = _UPVALUE1_
  L6 = "wan"
  L7 = "mode"
  L8 = A0.mode
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.commit
  L5 = _UPVALUE1_
  L3(L4, L5)
  L3 = psRestart
  L4 = "wan"
  L3(L4)
  L3 = L1.system
  L3 = L3.multiwan
  if L3 then
    L3 = L1.system
    L3 = L3.multiwan
    if L3 == "1" then
      L3 = require
      L4 = "xiaoqiang.module.XQMultiWanPolicy"
      L3 = L3(L4)
      L4 = A0.enable
      if L4 == 0 then
        L4 = L1.system
        L4 = L4.cpe
        if L4 then
          L4 = L1.system
          L4 = L4.cpe
          if L4 == "1" then
            L4 = L1.system
            L4 = L4.dt_spec
            if L4 == "1" then
              L4 = L3.setEnable
              L5 = "0"
              L4(L5)
            else
              L4 = L3.setPolicy
              L5 = 4
              L4(L5)
            end
        end
        else
          L4 = L3.setEnable
          L5 = "0"
          L4(L5)
        end
      elseif L2 == 0 then
        L4 = L3.setEnable
        L5 = "0"
        L4(L5)
      else
        L4 = L3.setEnable
        L5 = "1"
        L4(L5)
      end
    end
  end
  L3 = L1.system
  L3 = L3.tr069
  if L3 then
    L3 = L1.system
    L3 = L3.tr069
    if L3 == "1" then
      L3 = A0.mode
      L4 = WAN_MODE_LAN
      if L3 == L4 then
        L3 = require
        L4 = "xiaoqiang.util.XQCwmpUtil"
        L3 = L3(L4)
        L4 = L3.modifyWan
        L5 = "br-lan"
        L4(L5)
      end
    end
  end
  L3 = true
  L4 = 0
  return L3, L4
end
wanSetConfig = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  if nil == A0 then
    L1 = nil
    return L1
  end
  L1 = tonumber
  L2 = A0.formvalue
  L3 = "mode"
  L2, L3, L4, L5 = L2(L3)
  L1 = L1(L2, L3, L4, L5)
  L2 = A0.formvalue
  L3 = "wan_port"
  L2 = L2(L3)
  if nil == L1 then
    L3 = nil
    return L3
  end
  L3 = WAN_MODE_FIXED
  if L3 == L1 and nil == L2 then
    L3 = nil
    return L3
  end
  L3 = {}
  L4 = WAN_MODE_FIXED
  function L5(A0)
    local L1, L2, L3
    L1 = psIsPortConflict
    L2 = A0
    L3 = "wan"
    L1 = L1(L2, L3)
    if L1 then
      L1 = nil
      return L1
    end
    L1 = {}
    L1.enable = 1
    L1.wandt = 0
    L1.ports = A0
    L2 = WAN_MODE_FIXED
    L1.mode = L2
    return L1
  end
  L3[L4] = L5
  L4 = WAN_MODE_WANDT
  function L5()
    local L0, L1
    L0 = {}
    L0.enable = 1
    L0.wandt = 1
    L0.ports = ""
    L1 = WAN_MODE_WANDT
    L0.mode = L1
    return L0
  end
  L3[L4] = L5
  L4 = WAN_MODE_LAN
  function L5()
    local L0, L1
    L0 = {}
    L0.enable = 0
    L0.wandt = 0
    L0.ports = ""
    L1 = WAN_MODE_LAN
    L0.mode = L1
    return L0
  end
  L3[L4] = L5
  L4 = L3[L1]
  if L4 then
    L4 = L3[L1]
    L5 = L2
    return L4(L5)
  else
    L4 = nil
    return L4
  end
end
wanAnalyConfig = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.module.XQMultiWanPolicy"
  L0 = L0(L1)
  L1 = L0.getBandwidth
  L1, L2 = L1()
  L3 = L0.getWeight
  L3, L4 = L3()
  L5 = {}
  L6 = {}
  L7 = {}
  L8 = {}
  L6[1] = L7
  L6[2] = L8
  L5.port_map = L6
  L6 = {}
  L5.policy = L6
  L6 = L0.getStatus
  L6 = L6()
  L5.enable = L6
  L6 = L5.port_map
  L6 = L6[1]
  L6.name = "WAN1"
  L6 = L5.port_map
  L6 = L6[1]
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = _UPVALUE1_
  L10 = "wan"
  L11 = "ports"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6.port = L7
  L6 = L5.port_map
  L6 = L6[2]
  L6.name = "WAN2"
  L6 = L5.port_map
  L6 = L6[2]
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = _UPVALUE1_
  L10 = "wan_2"
  L11 = "ports"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6.port = L7
  L6 = L5.policy
  L7 = L0.getPolicy
  L7 = L7()
  L6.mode = L7
  L6 = L5.policy
  L7 = L0.getCurrentWan
  L8 = "ipv4"
  L7 = L7(L8)
  L7 = L7 or L7
  L6.currwan = L7
  L6 = L5.policy
  L6.weight1 = L3
  L6 = L5.policy
  L6.weight2 = L4
  L6 = L5.policy
  L6.bandwidth_wan1 = L1
  L6 = L5.policy
  L6.bandwidth_wan2 = L2
  L6 = _UPVALUE2_
  L6 = L6.log
  L7 = 5
  L8 = "multiwanGetConfig: "
  L9 = L5
  L6(L7, L8, L9)
  return L5
end
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if nil == A0 then
    L1 = false
    L2 = 0
    return L1, L2
  end
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = L1.getStatus
  L2 = L2()
  L3 = false
  if L4 ~= L2 then
    L3 = true
    L4(L5, L6)
    L4(L5, L6)
    L7 = "wan_2"
    L8 = "enable"
    L9 = A0.enable
    L4(L5, L6, L7, L8, L9)
    if L4 == 1 then
      L7 = "wan"
      L8 = "wandt"
      L9 = 0
      L4(L5, L6, L7, L8, L9)
    else
      L4(L5, L6)
      L4(L5)
      L4()
      return L4, L5
    end
  end
  if L4 then
    L3 = true
    for L7, L8 in L4, L5, L6 do
      L9 = L8.name
      if L9 then
        L9 = L8.port
        if L9 then
          L9 = PS_WAN_SERVICE_NAME_MAP
          L10 = L8.name
          L9 = L9[L10]
          if L9 then
            L10 = _UPVALUE0_
            L11 = L10
            L10 = L10.set
            L12 = _UPVALUE1_
            L13 = L9
            L14 = "ports"
            L15 = L8.port
            L10(L11, L12, L13, L14, L15)
          end
        end
      end
    end
  end
  if L4 then
    L4(L5, L6)
    if L4 == 0 then
      L7 = true
      L4(L5, L6, L7)
    end
  end
  L4(L5, L6)
  if L3 then
    L4(L5)
  end
  L4()
  return L4, L5
end
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  if nil == A0 then
    L1 = nil
    return L1
  end
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = {}
  L6 = tonumber
  L7 = A0.formvalue
  L8 = "enable"
  L7, L8, L9, L10 = L7(L8)
  L6 = L6(L7, L8, L9, L10)
  L2.enable = L6
  L6 = A0.formvalue
  L7 = "policy%5Bmode%5D"
  L6 = L6(L7)
  L5.mode = L6
  L6 = A0.formvalue
  L7 = "policy%5Bbandwidth_wan1%5D"
  L6 = L6(L7)
  L5.bandwidth_wan1 = L6
  L6 = A0.formvalue
  L7 = "policy%5Bbandwidth_wan2%5D"
  L6 = L6(L7)
  L5.bandwidth_wan2 = L6
  L6 = L2.enable
  if nil == L6 then
    L6 = nil
    return L6
  end
  L6 = L2.enable
  if L6 == 1 then
    L6 = 0
    while "name" do
      L7 = {}
      L3 = L7
      L7 = A0.formvalue
      L8 = "port_map%5B"
      L9 = L6
      L10 = "%5D%5Bname%5D"
      L8 = L8 .. L9 .. L10
      L7 = L7(L8)
      L3.name = L7
      L7 = A0.formvalue
      L8 = "port_map%5B"
      L9 = L6
      L10 = "%5D%5Bport%5D"
      L8 = L8 .. L9 .. L10
      L7 = L7(L8)
      L3.port = L7
      L7 = L3.name
      if nil == L7 then
        break
      end
      L7 = PS_WAN_SERVICE_NAME_MAP
      L8 = L3.name
      L7 = L7[L8]
      if L7 then
        L8 = _UPVALUE0_
        L8 = L8.isStrNil
        L9 = L3.port
        L8 = L8(L9)
        if not L8 then
          L8 = psIsPortConflict
          L9 = L3.port
          L10 = L7
          L8 = L8(L9, L10)
        end
        if L8 then
          L8 = nil
          return L8
        end
      else
        L8 = nil
        return L8
      end
      L8 = table
      L8 = L8.insert
      L9 = L4
      L10 = L3
      L8(L9, L10)
      L6 = L6 + 1
    end
    L7 = L5.mode
    if L7 then
      L7 = L1.isValidPolicyCode
      L8 = L5.mode
      L7 = L7(L8)
      if L7 then
        L7 = tonumber
        L8 = L5.mode
        L7 = L7(L8)
        L5.mode = L7
        L7 = L5.mode
        if L7 == 0 then
          L7 = L5.bandwidth_wan1
          if nil ~= L7 then
            L7 = L5.bandwidth_wan2
          end
          if nil == L7 then
            L7 = nil
            return L7
          end
        end
      else
        L7 = nil
        return L7
      end
    end
    L7 = #L4
    L7 = L4 or L7
    if not (0 < L7) or not L4 then
      L7 = nil
    end
    L2.port_map = L7
    L7 = L5.mode
    L7 = L5 or L7
    if not L7 or not L5 then
      L7 = nil
    end
    L2.policy = L7
  end
  L6 = _UPVALUE1_
  L6 = L6.log
  L7 = 5
  L8 = "multiwanAnalyConfig: "
  L9 = L2
  L6(L7, L8, L9)
  return L2
end
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L4 = "game"
  L5 = "enable"
  L1 = L1(L2, L3, L4, L5)
  if L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 then
      goto lbl_16
    end
  end
  L2 = 0
  ::lbl_16::
  L0.enable = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = _UPVALUE1_
  L5 = "game"
  L6 = "ports"
  L2 = L2(L3, L4, L5, L6)
  L3 = L2 or L3
  if not L2 or not L2 then
    L3 = "-1"
  end
  L0.ports = L3
  return L0
end
function L10(A0)
  local L1, L2, L3, L4, L5, L6
  if nil == A0 then
    L1 = false
    L2 = 0
    return L1, L2
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.set
  L3 = _UPVALUE1_
  L4 = "game"
  L5 = "enable"
  L6 = A0.enable
  L1(L2, L3, L4, L5, L6)
  L1 = A0.enable
  if L1 == 1 then
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.set
    L3 = _UPVALUE1_
    L4 = "game"
    L5 = "ports"
    L6 = A0.ports
    L1(L2, L3, L4, L5, L6)
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.commit
  L3 = _UPVALUE1_
  L1(L2, L3)
  L1 = psRestart
  L2 = "game"
  L1(L2)
  L1 = true
  L2 = 0
  return L1, L2
end
function L11(A0)
  local L1, L2, L3, L4, L5
  if nil == A0 then
    L1 = nil
    return L1
  end
  L1 = tonumber
  L2 = A0.formvalue
  L3 = "enable"
  L2, L3, L4, L5 = L2(L3)
  L1 = L1(L2, L3, L4, L5)
  L2 = A0.formvalue
  L3 = "ports"
  L2 = L2(L3)
  if nil == L1 then
    L3 = nil
    return L3
  end
  if L1 == 1 then
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = L2
    L3 = L3(L4)
    if not L3 then
      L3 = psIsPortConflict
      L4 = L2
      L5 = "game"
      L3 = L3(L4, L5)
      if not L3 then
        goto lbl_33
      end
    end
    L3 = nil
    return L3
  end
  ::lbl_33::
  L3 = {}
  L3.enable = L1
  L4 = L2 or L4
  if not L2 then
    L4 = ""
  end
  L3.ports = L4
  return L3
end
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L2 = "tag_attr"
  if nil == A0 then
    L3 = nil
    return L3
  end
  L3 = A0.formvalue
  L4 = "interface"
  L3 = L3(L4)
  if nil == L3 then
    L4 = nil
    return L4
  end
  L1.interface = L3
  L4 = L3
  L5 = L2
  L2 = L4 .. L5
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L7 = L2
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = tonumber
    L6 = L4
    L5 = L5(L6)
    if L5 then
      goto lbl_32
    end
  end
  L5 = 0
  ::lbl_32::
  L1.profile = L5
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = _UPVALUE1_
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = tonumber
    L7 = L5
    L6 = L6(L7)
    if L6 then
      goto lbl_47
    end
  end
  L6 = -1
  ::lbl_47::
  L1.vid = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L6 = L6(L7, L8, L9, L10)
  if L6 then
    L7 = tonumber
    L7 = L7(L8)
    if L7 then
      goto lbl_62
    end
  end
  L7 = -1
  ::lbl_62::
  L1.priority = L7
  L7 = _UPVALUE0_
  L7 = L7.get
  L11 = "forbid_vid"
  L7 = L7(L8, L9, L10, L11)
  L1.forbid_vid = ""
  if L7 then
    for L11, L12 in L8, L9, L10 do
      if L12 then
        L13 = tonumber
        L14 = L12
        L13 = L13(L14)
        if nil ~= L13 then
          L13 = L1.forbid_vid
          if L13 ~= "" then
            L13 = L1.forbid_vid
            L14 = ","
            L13 = L13 .. L14
            L1.forbid_vid = L13
          end
          L13 = L1.forbid_vid
          L14 = L12
          L13 = L13 .. L14
          L1.forbid_vid = L13
        end
      end
    end
  end
  L11 = L2
  L12 = "permit_vid"
  if not L8 then
  end
  L1.permit_vid = L9
  return L1
end
wantagGetConfig = L12
function L12(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.get
    L3 = _UPVALUE1_
    L4 = A0
    L5 = "tag_attr"
    L4 = L4 .. L5
    L5 = "permit_vid"
    L1 = L1(L2, L3, L4, L5)
    L2 = L1 or L2
    if not L1 then
      L2 = "1~4094"
    end
    return L2
  else
    L1 = "1~4094"
    return L1
  end
end
psGetWantagPermitVid = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = "tag_attr"
  if nil == A0 then
    L2 = false
    L3 = 0
    return L2, L3
  end
  L2 = A0.interface
  L3 = L1
  L1 = L2 .. L3
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.set
  L4 = _UPVALUE1_
  L5 = A0.interface
  L6 = "wantag"
  L7 = A0.enable
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.set
  L4 = _UPVALUE1_
  L5 = L1
  L6 = "profile"
  L7 = A0.profile
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.set
  L4 = _UPVALUE1_
  L5 = L1
  L6 = "vid"
  L7 = A0.vid
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.set
  L4 = _UPVALUE1_
  L5 = L1
  L6 = "priority"
  L7 = A0.priority
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L4 = _UPVALUE1_
  L2(L3, L4)
  L2 = psRestart
  L3 = A0.interface
  L2(L3)
  L2 = true
  return L2
end
wantagSetConfig = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  L1.interface = "wan"
  L1.enable = 0
  L1.profile = 0
  L1.vid = 0
  L1.priority = 0
  if nil == A0 then
    L2 = nil
    return L2
  end
  L2 = A0.formvalue
  L3 = "interface"
  L2 = L2(L3)
  if nil == L2 then
    L3 = nil
    return L3
  end
  L1.interface = L2
  L3 = tonumber
  L4 = A0.formvalue
  L5 = "profile"
  L4, L5, L6, L10, L11, L12, L13 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  if nil == L3 or L3 < 0 then
    L4 = nil
    return L4
  end
  L1.profile = L3
  L4 = L1.profile
  if L4 ~= 0 then
    L1.enable = 1
  end
  L4 = L1.enable
  if L4 == 0 then
    return L1
  end
  L4 = psIptvBridgeEnable
  L4 = L4()
  if 1 == L4 then
    L4 = nil
    L5 = 1611
    return L4, L5
  end
  L4 = tonumber
  L5 = A0.formvalue
  L6 = "vid"
  L5, L6, L10, L11, L12, L13 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  if nil == L4 or L4 <= 0 or 4094 < L4 then
    L5 = nil
    return L5
  end
  L5 = nil
  L6 = tonumber
  L10 = L2
  L11 = "wantag"
  L10, L11, L12, L13 = L7(L8, L9, L10, L11)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13)
  if L6 == 1 then
    L6 = tonumber
    L10 = "wantag_attr"
    L11 = "vid"
    L10, L11, L12, L13 = L7(L8, L9, L10, L11)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13)
    L5 = L6 or L5
    if not L6 then
      L5 = nil
    end
  end
  L6 = psIsVidConflict
  L6 = L6(L7, L8)
  if L6 then
    L6 = nil
    return L6, L7
  end
  L6 = _UPVALUE0_
  L6 = L6.get
  L10 = "forbid_vid"
  L6 = L6(L7, L8, L9, L10)
  if L6 then
    for L10, L11 in L7, L8, L9 do
      L12 = tonumber
      L13 = L11
      L12 = L12(L13)
      if L4 == L12 then
        L12 = nil
        L13 = 1805
        return L12, L13
      end
    end
  end
  L1.vid = L4
  L10, L11, L12, L13 = L8(L9)
  if nil == L7 or L7 < 0 or 7 < L7 then
    return L8
  end
  L1.priority = L7
  return L1
end
wantagAnalyConfig = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  L1.interface = "wan"
  L1.enable = 0
  L1.profile = 0
  L1.vid = 0
  L1.priority = 0
  if nil == A0 then
    L2 = nil
    return L2
  end
  L2 = A0.formvalue
  L3 = "opt"
  L2 = L2(L3)
  if L2 == "init" or L2 == "set" then
    L3 = tonumber
    L4 = A0.formvalue
    L5 = "internet_profile"
    L4, L5, L6, L10, L11, L12, L13 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
    if nil == L3 or L3 < 0 then
      L4 = nil
      return L4
    end
    L1.profile = L3
    L4 = L1.profile
    if L4 ~= 0 then
      L1.enable = 1
    end
    L4 = L1.enable
    if L4 == 0 then
      return L1
    end
    L4 = psIptvBridgeEnable
    L4 = L4()
    if 1 == L4 then
      L4 = nil
      L5 = 1611
      return L4, L5
    end
    L4 = tonumber
    L5 = A0.formvalue
    L6 = "internet_vid"
    L5, L6, L10, L11, L12, L13 = L5(L6)
    L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
    if nil == L4 or L4 <= 0 or 4094 < L4 then
      L5 = nil
      return L5
    end
    L5 = nil
    L6 = tonumber
    L10 = L1.interface
    L11 = "wantag"
    L10, L11, L12, L13 = L7(L8, L9, L10, L11)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13)
    if L6 == 1 then
      L6 = tonumber
      L10 = "wantag_attr"
      L11 = "vid"
      L10, L11, L12, L13 = L7(L8, L9, L10, L11)
      L6 = L6(L7, L8, L9, L10, L11, L12, L13)
      L5 = L6 or L5
      if not L6 then
        L5 = nil
      end
    end
    L6 = psIsVidConflict
    L6 = L6(L7, L8)
    if L6 then
      L6 = nil
      return L6, L7
    end
    L6 = _UPVALUE0_
    L6 = L6.get
    L10 = "forbid_vid"
    L6 = L6(L7, L8, L9, L10)
    if L6 then
      for L10, L11 in L7, L8, L9 do
        L12 = tonumber
        L13 = L11
        L12 = L12(L13)
        if L4 == L12 then
          L12 = nil
          L13 = 1805
          return L12, L13
        end
      end
    end
    L1.vid = L4
    L10, L11, L12, L13 = L8(L9)
    if nil == L7 or L7 < 0 or 7 < L7 then
      return L8
    end
    L1.priority = L7
  elseif L2 == "clean" then
    L1.enable = 0
    L1.profile = 0
    L1.vid = -1
    L1.priority = -1
  else
    L3 = nil
    return L3
  end
  return L1
end
wantagAnalyInternetVlan = L12
L12 = {}
L13 = wandtGetConfig
L12.getConfig = L13
L13 = wandtSetConfig
L12.setConfig = L13
L13 = wandtAnalyConfig
L12.analyConfig = L13
L13 = {}
L14 = lagGetConfig
L13.getConfig = L14
L14 = lagSetConfig
L13.setConfig = L14
L14 = lagAnalyConfig
L13.analyConfig = L14
L14 = {}
L15 = iptvGetConfig
L14.getConfig = L15
L15 = iptvSetConfig
L14.setConfig = L15
L15 = iptvAnalyConfig
L14.analyConfig = L15
L15 = {}
L16 = wanGetConfig
L15.getConfig = L16
L16 = wanSetConfig
L15.setConfig = L16
L16 = wanAnalyConfig
L15.analyConfig = L16
L16 = {}
L16.getConfig = L6
L16.setConfig = L7
L16.analyConfig = L8
L17 = {}
L17.getConfig = L9
L17.setConfig = L10
L17.analyConfig = L11
L18 = {}
L18.wandt = L12
L18.lag = L13
L18.iptv = L14
L18.wan = L15
L18.multiwan = L16
L18.game = L17
ps = L18
