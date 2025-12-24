local L0, L1, L2, L3, L4
function L4(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.gsub
  L3 = "\\"
  L4 = "\\\\"
  L1 = L1(L2, L3, L4)
  L2 = L1
  L1 = L1.gsub
  L3 = "`"
  L4 = "\\`"
  L1 = L1(L2, L3, L4)
  L2 = L1
  L1 = L1.gsub
  L3 = "\""
  L4 = "\\\""
  L1 = L1(L2, L3, L4)
  L2 = L1
  L1 = L1.gsub
  L3 = "%$"
  L4 = "\\$"
  return L1(L2, L3, L4)
end
cmdfmt = L4
function L4()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  _UPVALUE0_ = L0
  L0 = require
  L1 = "xiaoqiang.XQEquipment"
  L0 = L0(L1)
  _UPVALUE1_ = L0
  L0 = _UPVALUE0_
  L0 = L0.getDeviceInfoFromDB
  L0 = L0()
  _UPVALUE2_ = L0
  L0 = _UPVALUE0_
  L0 = L0.getDHCPDict
  L0 = L0()
  _UPVALUE3_ = L0
end
get_hostname_init = L4
function L4(A0)
  local L1, L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2[A0]
  if L2 then
    L2 = _UPVALUE0_
    L2 = L2[A0]
    L2 = L2.nickname
    if L2 ~= "" then
      L2 = _UPVALUE0_
      L2 = L2[A0]
      L1 = L2.nickname
  end
  else
    L2 = _UPVALUE1_
    L2 = L2[A0]
    if L2 then
      L2 = _UPVALUE1_
      L2 = L2[A0]
      L2 = L2.name
      if L2 then
        goto lbl_24
      end
    end
    L2 = ""
    ::lbl_24::
    if L2 == "" then
      L3 = _UPVALUE2_
      L3 = L3.identifyDevice
      L4 = A0
      L5 = ""
      L3 = L3(L4, L5)
      L1 = L3.name
    else
      L3 = _UPVALUE2_
      L3 = L3.identifyDevice
      L4 = A0
      L5 = L2
      L3 = L3(L4, L5)
      L4 = L3.type
      L4 = L4.p
      L5 = L3.type
      L5 = L5.c
      L4 = L4 + L5
      if 0 < L4 then
        L1 = L3.name
      else
        L1 = L2
      end
    end
  end
  L2 = A0 or L2
  if L1 ~= "" or not A0 then
    L2 = L1
  end
  return L2
end
get_hostname = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L1 = L0.connect
  L1 = L1()
  if not L1 then
    L2 = elog
    L3 = "Failed to connect to ubusd"
    L2(L3)
  end
  L3 = L1
  L2 = L1.call
  L4 = "network.interface.wan"
  L5 = "status"
  L6 = {}
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.close
  L3(L4)
  L3 = L2.l3_device
  if L3 then
    L3 = L2.l3_device
    if L3 then
      goto lbl_25
    end
  end
  L3 = L2.device
  ::lbl_25::
  return L3
end
get_wan_dev_name = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L1 = L0.connect
  L1 = L1()
  if not L1 then
    L2 = elog
    L3 = "Failed to connect to ubusd"
    L2(L3)
  end
  L3 = L1
  L2 = L1.call
  L4 = "network.interface.lan"
  L5 = "status"
  L6 = {}
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.close
  L3(L4)
  L3 = L2.l3_device
  if L3 then
    L3 = L2.l3_device
    if L3 then
      goto lbl_25
    end
  end
  L3 = L2.device
  ::lbl_25::
  return L3
end
get_lan_dev_name = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = io
  L0 = L0.popen
  L1 = "uci get xiaoqiang.common.NETMODE"
  L0 = L0(L1)
  L2 = L0
  L1 = L0.read
  L3 = "*line"
  L1 = L1(L2, L3)
  L3 = L0
  L2 = L0.close
  L2(L3)
  if L1 == "wifiapmode" then
    L2 = io
    L2 = L2.popen
    L3 = "ifconfig  apcli0 | grep HWaddr"
    L2 = L2(L3)
    L0 = L2
    L3 = L0
    L2 = L0.read
    L4 = "*line"
    L2 = L2(L3, L4)
    L3 = string
    L3 = L3.find
    L4 = L2
    L5 = "HWaddr%s+([0-9A-F:]+)%s*$"
    L3, L4, L5 = L3(L4, L5)
    L7 = L0
    L6 = L0.close
    L6(L7)
    return L5
  end
  if L1 == "lanapmode" then
    L2 = io
    L2 = L2.popen
    L3 = "ifconfig  br-lan | grep HWaddr"
    L2 = L2(L3)
    L0 = L2
    L3 = L0
    L2 = L0.read
    L4 = "*line"
    L2 = L2(L3, L4)
    L3 = string
    L3 = L3.find
    L4 = L2
    L5 = "HWaddr%s+([0-9A-F:]+)%s*$"
    L3, L4, L5 = L3(L4, L5)
    L7 = L0
    L6 = L0.close
    L6(L7)
    return L5
  end
  L2 = nil
  return L2
end
get_ap_hw = L4
function L4()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "killall -q -s 10 noflushd"
  L0(L1)
end
trafficd_lua_done = L4
function L4()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = L0.getRouterInfo4Trafficd
  return L1()
end
get_description = L4
function L4()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = L0.getRomVersion
  return L1()
end
get_version = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L9 = require
  L10 = "json"
  L9 = L9(L10)
  L10, L11, L12 = nil, nil, nil
  L13 = 1
  L14, L15 = nil, nil
  L10 = L16
  L11 = L16
  L16(L17)
  L10 = L16
  L14 = L16
  L16(L17)
  if L11 ~= nil and L14 ~= nil then
    L14 = L16
    if L14 ~= nil then
      for L19 = L16, L17, L18 do
        L20 = io
        L20 = L20.popen
        L21 = string
        L21 = L21.format
        L22 = "uci get wireless.@wifi-iface[%d].ifname"
        L23 = L19
        L21, L22, L23, L24, L25 = L21(L22, L23)
        L20 = L20(L21, L22, L23, L24, L25)
        L10 = L20
        L21 = L10
        L20 = L10.read
        L22 = "*line"
        L20 = L20(L21, L22)
        L12 = L20
        L21 = L10
        L20 = L10.close
        L20(L21)
        if L12 == L11 then
          L13 = L19
          break
        end
      end
    end
  end
  L19 = cmdfmt
  L20 = L11
  L19 = L19(L20)
  L20 = cmdfmt
  L21 = A0
  L20, L21, L22, L23, L24, L25 = L20(L21)
  L19, L20, L21, L22, L23, L24, L25 = L17(L18, L19, L20, L21, L22, L23, L24, L25)
  L16(L17, L18, L19, L20, L21, L22, L23, L24, L25)
  file = L16
  if L16 ~= nil then
    for L19 in L16, L17, L18 do
      L20 = L9.decode
      L21 = L19
      L20 = L20(L21)
      L1 = L20.code
      L2 = L20.token
      L3 = L20.ssid
      L4 = L20.ssid_pwd
      L5 = L20.ssid_type
      L6 = L20.ssid_hidden
      L7 = L20.bssid
      L8 = L20.device_id
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L1
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L2
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L3
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L4
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L5
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L6
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L7
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
      L21 = os
      L21 = L21.execute
      L22 = string
      L22 = L22.format
      L23 = "logger \"%s\" "
      L24 = cmdfmt
      L25 = L8
      L24, L25 = L24(L25)
      L22, L23, L24, L25 = L22(L23, L24, L25)
      L21(L22, L23, L24, L25)
    end
    L16(L17)
  end
  L19 = L4
  L20 = L5
  L21 = L6
  L22 = L7
  L23 = L8
  return L16, L17, L18, L19, L20, L21, L22, L23
end
trafficd_lua_ecos_pair_verify = L4
