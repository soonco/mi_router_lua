local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.util.XQVPNUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L2 = L2.cursor
L2 = L2()
function L3(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A0
  L8 = L8(L9)
  if not L8 then
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = A1
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE0_
      L8 = L8.isStrNil
      L9 = A2
      L8 = L8(L9)
      if not L8 then
        L8 = _UPVALUE0_
        L8 = L8.isStrNil
        L9 = A3
        L8 = L8(L9)
        if not L8 then
          L8 = _UPVALUE0_
          L8 = L8.isStrNil
          L9 = A4
          L8 = L8(L9)
          if not L8 then
            L8 = _UPVALUE0_
            L8 = L8.isStrNil
            L9 = A6
            L8 = L8(L9)
            if not L8 then
              goto lbl_39
            end
          end
        end
      end
    end
  end
  L8 = false
  do return L8 end
  ::lbl_39::
  L8 = A5
  L9 = _UPVALUE0_
  L9 = L9.isStrNil
  L10 = L8
  L9 = L9(L10)
  if L9 then
    L9 = require
    L10 = "xiaoqiang.util.XQCryptoUtil"
    L9 = L9(L10)
    L10 = L9.md5Str
    L11 = A1
    L12 = A2
    L13 = A4
    L11 = L11 .. L12 .. L13
    L10 = L10(L11)
    L8 = L10
  end
  L9 = _UPVALUE0_
  L9 = L9.isStrNil
  L10 = A7
  L9 = L9(L10)
  if L9 then
    A7 = "auto"
  end
  L9 = "yes"
  L10 = _UPVALUE1_
  L11 = L10
  L10 = L10.get
  L12 = "smartvpn"
  L13 = "vpn"
  L14 = "switch"
  L10 = L10(L11, L12, L13, L14)
  if L10 and L10 == "1" then
    L9 = "no"
  end
  L11 = {}
  L12 = string
  L12 = L12.lower
  L13 = A4
  L12 = L12(L13)
  L11.proto = L12
  L11.server = A1
  L11.username = A2
  L11.password = A3
  L11.auth = A7
  L11.id = L8
  L11.auto = A6
  L11.trafficall = L9
  if A6 == "1" then
    L12 = "5"
    if L12 then
      goto lbl_94
    end
  end
  L12 = ""
  ::lbl_94::
  L11.checkup_interval = L12
  if L11 then
    L12 = _UPVALUE1_
    L13 = L12
    L12 = L12.delete
    L14 = "network"
    L15 = A0
    L12(L13, L14, L15)
    L12 = _UPVALUE1_
    L13 = L12
    L12 = L12.delete
    L14 = "network"
    L15 = A0
    L16 = "6"
    L15 = L15 .. L16
    L12(L13, L14, L15)
    L12 = _UPVALUE1_
    L13 = L12
    L12 = L12.section
    L14 = "network"
    L15 = "interface"
    L16 = A0
    L17 = L11
    L12(L13, L14, L15, L16, L17)
    L12 = _UPVALUE1_
    L13 = L12
    L12 = L12.commit
    L14 = "network"
    L12(L13, L14)
    L12 = require
    L13 = "luci.model.firewall"
    L12 = L12(L13)
    L13 = L12.init
    L13 = L13()
    L15 = L13
    L14 = L13.get_zone
    L16 = "wan"
    L14 = L14(L15, L16)
    L16 = L14
    L15 = L14.add_network
    L17 = A0
    L15(L16, L17)
    L16 = L13
    L15 = L13.save
    L17 = "firewall"
    L15(L16, L17)
    L16 = L13
    L15 = L13.commit
    L17 = "firewall"
    L15(L16, L17)
    L15 = true
    return L15
  end
  L12 = false
  return L12
end
setVpn = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "network"
  L4 = "vpn"
  L5 = "id"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == A0 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.delete
    L4 = "network"
    L5 = "vpn6"
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.delete
    L4 = "network"
    L5 = "vpn"
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.commit
    L4 = "network"
    L2(L3, L4)
  end
end
_delNetworkVpn = L3
function L3(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "network"
  L9 = "vpn"
  L10 = "id"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  if L6 == A4 then
    L7 = "vpn"
    L8 = require
    L9 = "xiaoqiang.util.XQCryptoUtil"
    L8 = L8(L9)
    L9 = L8.md5Str
    L10 = A0
    L11 = A1
    L12 = A3
    L10 = L10 .. L11 .. L12
    L9 = L9(L10)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "proto"
    L15 = string
    L15 = L15.lower
    L16 = A3
    L15, L16 = L15(L16)
    L10(L11, L12, L13, L14, L15, L16)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "server"
    L15 = A0
    L10(L11, L12, L13, L14, L15)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "username"
    L15 = A1
    L10(L11, L12, L13, L14, L15)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "password"
    L15 = A2
    L10(L11, L12, L13, L14, L15)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "id"
    L15 = L9
    L10(L11, L12, L13, L14, L15)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.set
    L12 = "network"
    L13 = L7
    L14 = "auth"
    L15 = A5
    L10(L11, L12, L13, L14, L15)
    L10 = _UPVALUE0_
    L11 = L10
    L10 = L10.commit
    L12 = "network"
    L10(L11, L12)
  end
end
_editNetworkVpn = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = "vpn"
  if A0 and A0 == 0 then
    L2 = "0"
    if L2 then
      goto lbl_14
    end
  end
  L2 = "1"
  ::lbl_14::
  if L2 == "1" then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.set
    L5 = "network"
    L6 = L1
    L7 = "checkup_interval"
    L8 = "5"
    L3(L4, L5, L6, L7, L8)
  else
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete
    L5 = "network"
    L6 = L1
    L7 = "checkup_interval"
    L3(L4, L5, L6, L7)
  end
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = "network"
  L6 = L1
  L7 = "auto"
  L8 = L2
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.commit
  L5 = "network"
  L3(L4, L5)
  L3 = true
  return L3
end
setVpnAuto = L3
function L3()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = L0.system
  L1 = L1.multiwan
  if L1 then
    L1 = L0.system
    L1 = L1.multiwan
    if L1 == "1" then
      L1 = require
      L2 = "xiaoqiang.module.XQMultiWanPolicy"
      L1 = L1(L2)
      L2 = L1.getCurrentWan
      L3 = "ipv4"
      return L2(L3)
  end
  else
    L1 = "wan"
    return L1
  end
end
getVpnBindWan = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = {}
  L1.proto = ""
  L1.server = ""
  L1.username = ""
  L1.password = ""
  L1.auto = "0"
  L1.id = ""
  L1.auth = ""
  L1.netmask = "255.255.255.0"
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return L1
  end
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get_all
  L4 = "network"
  L5 = A0
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = L2.proto
    L1.proto = L3
    L3 = L2.server
    L1.server = L3
    L3 = L2.username
    L1.username = L3
    L3 = L2.password
    L1.password = L3
    L3 = L2.auto
    L1.auto = L3
    L3 = L2.id
    L1.id = L3
    L3 = L2.auth
    L1.auth = L3
    L3 = getVpnBindWan
    L3 = L3()
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.get
    L6 = "network"
    L7 = L3
    L8 = "netmask"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L1.netmask = L4
  end
  return L1
end
getVPNInfo = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A1
  L2 = L2(L3)
  if L2 then
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "network"
    L5 = "vpn"
    L6 = "id"
    L2 = L2(L3, L4, L5, L6)
    A1 = L2
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if L2 then
      L2 = false
      return L2
    end
  end
  if A0 then
    L2 = require
    L3 = "ubus"
    L2 = L2(L3)
    L2 = L2.connect
    L2 = L2()
    L4 = L2
    L3 = L2.call
    L5 = "network.interface.vpn"
    L6 = "status"
    L7 = {}
    L3 = L3(L4, L5, L6, L7)
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.get
    L6 = "network"
    L7 = "vpn"
    L8 = "id"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L5 = _UPVALUE1_
    L6 = L5
    L5 = L5.get
    L7 = "network"
    L8 = "vpn"
    L9 = "auto"
    L5 = L5(L6, L7, L8, L9)
    L5 = L5 or L5
    if L4 ~= A1 then
      L6 = _UPVALUE1_
      L7 = L6
      L6 = L6.get_all
      L8 = "vpnlist"
      L9 = A1
      L6 = L6(L7, L8, L9)
      if L6 then
        L7 = setVpn
        L8 = "vpn"
        L9 = L6.server
        L10 = L6.username
        L11 = L6.password
        L12 = L6.proto
        L13 = A1
        L14 = L5
        L15 = L6.auth
        L7(L8, L9, L10, L11, L12, L13, L14, L15)
      end
    end
    L6 = os
    L6 = L6.execute
    L7 = _UPVALUE2_
    L7 = L7.RM_VPNSTATUS_FILE
    L6(L7)
    if L3 then
      L6 = os
      L6 = L6.execute
      L7 = _UPVALUE2_
      L7 = L7.VPN_DISABLE
      L6(L7)
      L6 = os
      L6 = L6.execute
      L7 = "sleep 1"
      L6(L7)
    end
    L6 = _UPVALUE0_
    L6 = L6.forkExec
    L7 = _UPVALUE2_
    L7 = L7.VPN_ENABLE
    L6(L7)
  else
    L2 = os
    L2 = L2.execute
    L3 = _UPVALUE2_
    L3 = L3.RM_VPNSTATUS_FILE
    L2(L3)
    L2 = _UPVALUE0_
    L2 = L2.forkExec
    L3 = _UPVALUE2_
    L3 = L3.VPN_DISABLE
    L2(L3)
  end
  if A0 then
    L2 = 1
    if L2 then
      goto lbl_109
    end
  end
  L2 = 0
  ::lbl_109::
  L3 = os
  L3 = L3.execute
  L4 = _UPVALUE2_
  L4 = L4.SET_VPN_USER_OPTION
  L5 = L2
  L4 = L4 .. L5
  L3(L4)
  L3 = 1
  return L3
end
vpnSwitch = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.VPN_STATUS
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = _UPVALUE1_
    L2 = L2.isStrNil
    L3 = L1
    L2 = L2(L3)
    if L2 then
      L2 = nil
      return L2
    end
    L2 = require
    L3 = "json"
    L2 = L2(L3)
    L3 = L2.decode
    L4 = L1
    L3 = L3(L4)
    L1 = L3
    if L1 then
      return L1
    end
  end
  L2 = nil
  return L2
end
vpnStatus = L3
function L3(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A0
  L7 = L7(L8)
  if not L7 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A1
    L7 = L7(L8)
    if not L7 then
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = A2
      L7 = L7(L8)
      if not L7 then
        L7 = _UPVALUE0_
        L7 = L7.isStrNil
        L8 = A3
        L7 = L7(L8)
        if not L7 then
          L7 = _UPVALUE0_
          L7 = L7.isStrNil
          L8 = A4
          L7 = L7(L8)
          if not L7 then
            goto lbl_33
          end
        end
      end
    end
  end
  L7 = false
  do return L7 end
  ::lbl_33::
  L7 = require
  L8 = "xiaoqiang.util.XQCryptoUtil"
  L7 = L7(L8)
  L8 = L7.md5Str
  L9 = A1
  L10 = A2
  L11 = A4
  L9 = L9 .. L10 .. L11
  L8 = L8(L9)
  L9 = {}
  L9.oname = A0
  L9.server = A1
  L9.username = A2
  L9.password = A3
  L10 = string
  L10 = L10.lower
  L11 = A4
  L10 = L10(L11)
  L9.proto = L10
  L9.id = L8
  L9.auth = A5
  if A6 then
    L10 = _UPVALUE1_
    L11 = L10
    L10 = L10.delete
    L12 = "vpnlist"
    L13 = A6
    L10(L11, L12, L13)
  end
  L10 = _UPVALUE1_
  L11 = L10
  L10 = L10.section
  L12 = "vpnlist"
  L13 = "vpn"
  L14 = L8
  L15 = L9
  L10(L11, L12, L13, L14, L15)
  L10 = _UPVALUE1_
  L11 = L10
  L10 = L10.commit
  L12 = "vpnlist"
  L10(L11, L12)
  L10 = true
  return L10
end
addVPN = L3
function L3(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A0
  L6 = L6(L7)
  if L6 then
    L6 = false
    return L6
  end
  L6 = _UPVALUE1_
  L7 = L6
  L6 = L6.get
  L8 = "vpnlist"
  L9 = A0
  L10 = "auth"
  L6 = L6(L7, L8, L9, L10)
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = L6
  L7 = L7(L8)
  if L7 then
    L6 = "auto"
  end
  L7 = _editNetworkVpn
  L8 = A2
  L9 = A3
  L10 = A4
  L11 = A5
  L12 = A0
  L13 = L6
  L7(L8, L9, L10, L11, L12, L13)
  L7 = addVPN
  L8 = A1
  L9 = A2
  L10 = A3
  L11 = A4
  L12 = A5
  L13 = L6
  L14 = A0
  return L7(L8, L9, L10, L11, L12, L13, L14)
end
editVPN = L3
function L3(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.delete
  L3 = "vpnlist"
  L4 = A0
  L1(L2, L3, L4)
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.commit
  L3 = "vpnlist"
  L1(L2, L3)
  L1 = _delNetworkVpn
  L2 = A0
  L1(L2)
  L1 = true
  return L1
end
delVPN = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "luci.ip"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = L2.iptonl
  L5 = A0
  L4 = L4(L5)
  L5 = L2.iptonl
  L6 = "169.254.0.0"
  L5 = L5(L6)
  if L4 >= L5 then
    L5 = L2.iptonl
    L6 = "169.254.255.255"
    L5 = L5(L6)
    if L4 <= L5 then
      goto lbl_32
    end
  end
  L5 = L2.iptonl
  L6 = "127.0.0.1"
  L5 = L5(L6)
  if L4 ~= L5 then
    L5 = _UPVALUE0_
    L5 = L5.isBroadcastOrMulticast
    L6 = A0
    L7 = A1
    L5 = L5(L6, L7)
    if not L5 then
      goto lbl_34
    end
  end
  ::lbl_32::
  L5 = false
  do return L5 end
  ::lbl_34::
  L5 = true
  return L5
end
checkVPNServerIp = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "vpnlist"
  L4 = "vpn"
  function L5(A0)
    local L1, L2, L3, L4
    L1 = {}
    L2 = A0.oname
    L1.oname = L2
    L2 = A0.server
    L1.server = L2
    L2 = A0.username
    L1.username = L2
    L2 = A0.password
    L1.password = L2
    L2 = A0.proto
    L1.proto = L2
    L2 = A0.id
    L1.id = L2
    L2 = table
    L2 = L2.insert
    L3 = _UPVALUE0_
    L4 = L1
    L2(L3, L4)
  end
  L1(L2, L3, L4, L5)
  return L0
end
getVPNList = L3
L3 = "/etc/smartvpn/proxy.txt"
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = {}
  L3 = L0.access
  L3 = L3(L4)
  if L3 then
    L3 = io
    L3 = L3.open
    L3 = L3(L4, L5)
    if L3 then
      for L7 in L4, L5, L6 do
        L8 = _UPVALUE1_
        L8 = L8.isStrNil
        L9 = L7
        L8 = L8(L9)
        if not L8 then
          L9 = L7
          L8 = L7.match
          L10 = "^%."
          L8 = L8(L9, L10)
          if L8 then
            L9 = L7
            L8 = L7.gsub
            L10 = "^%."
            L11 = ""
            L8 = L8(L9, L10, L11)
            L7 = L8
            L8 = table
            L8 = L8.insert
            L9 = L2
            L10 = L7
            L8(L9, L10)
          else
            L8 = L1.ipaddr
            L9 = L7
            L8 = L8(L9)
            if L8 then
              L8 = table
              L8 = L8.insert
              L9 = L2
              L10 = L7
              L8(L9, L10)
            end
          end
        end
      end
    end
  end
  L3 = #L2
  if 0 < L3 then
    return L2
  else
    L3 = nil
    return L3
  end
end
getProxyList = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  if A0 then
    L1 = type
    L1 = L1(L2)
    if L1 == "string" and A0 == "default" then
      A0 = nil
    end
  end
  if A0 then
    L1 = type
    L1 = L1(L2)
    if L1 == "table" then
      L1 = io
      L1 = L1.open
      L1 = L1(L2, L3)
      for L5, L6 in L2, L3, L4 do
        L7 = _UPVALUE1_
        L7 = L7.isStrNil
        L8 = L6
        L7 = L7(L8)
        if not L7 then
          L8 = L1
          L7 = L1.write
          L9 = L6
          L10 = "\n"
          L9 = L9 .. L10
          L7(L8, L9)
        end
      end
      L2(L3)
    end
  end
end
updateProxyList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "smartvpn"
  L4 = "device"
  L1 = L1(L2, L3, L4)
  if L1 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get_list
    L4 = "smartvpn"
    L5 = "device"
    L6 = "mac"
    L2 = L2(L3, L4, L5, L6)
    L0 = L2
  else
    L0 = nil
  end
  return L0
end
getDeviceList = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.status = 0
  L0.switch = 0
  L0.mode = 1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "smartvpn"
  L4 = "vpn"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get_all
  L4 = "smartvpn"
  L5 = "device"
  L2 = L2(L3, L4, L5)
  if L1 then
    L3 = L1.status
    if L3 == "on" then
      L0.status = 1
    else
      L3 = L1.status
      if L3 == "off" then
        L0.status = 0
      end
    end
    L3 = L1.switch
    if L3 then
      L3 = tonumber
      L4 = L1.switch
      L3 = L3(L4)
      if L3 == 1 then
        L0.switch = 1
      end
    end
    if L2 then
      L3 = L2.disabled
      if L3 then
        L3 = tonumber
        L4 = L2.disabled
        L3 = L3(L4)
        if L3 == 0 then
          L0.mode = 2
      end
    end
    else
      L3 = L1.disabled
      if L3 then
        L3 = tonumber
        L4 = L1.disabled
        L3 = L3(L4)
        if L3 == 0 then
          L0.mode = 1
      end
      else
        L0.mode = 0
      end
    end
  end
  return L0
end
getSmartVPNInfo = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  if A1 then
    if A1 == 1 then
      L3 = L2.access
      L4 = _UPVALUE0_
      L3 = L3(L4)
      if not L3 and A0 == 1 then
        L3 = updateProxyList
        L4 = "default"
        L3(L4)
      end
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "disabled"
      L8 = "0"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set_list
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "domain_file"
      L8 = {}
      L9 = _UPVALUE0_
      L8[1] = L9
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.get_all
      L5 = "smartvpn"
      L6 = "device"
      L3 = L3(L4, L5, L6)
      if L3 then
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.set
        L5 = "smartvpn"
        L6 = "device"
        L7 = "disabled"
        L8 = "1"
        L3(L4, L5, L6, L7, L8)
      end
    elseif A1 == 2 then
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "disabled"
      L8 = "1"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.get_all
      L5 = "smartvpn"
      L6 = "device"
      L3 = L3(L4, L5, L6)
      if L3 then
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.set
        L5 = "smartvpn"
        L6 = "device"
        L7 = "disabled"
        L8 = "0"
        L3(L4, L5, L6, L7, L8)
      else
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.section
        L5 = "smartvpn"
        L6 = "record"
        L7 = "device"
        L8 = {}
        L8.disabled = "0"
        L3(L4, L5, L6, L7, L8)
      end
    end
  end
  if A0 then
    if A0 == 0 then
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "switch"
      L8 = "0"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "disabled"
      L8 = "1"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "device"
      L7 = "disabled"
      L8 = "1"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "network"
      L6 = "vpn"
      L7 = "trafficall"
      L8 = "yes"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.commit
      L5 = "network"
      L3(L4, L5)
    elseif A0 == 1 then
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "smartvpn"
      L6 = "vpn"
      L7 = "switch"
      L8 = "1"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.set
      L5 = "network"
      L6 = "vpn"
      L7 = "trafficall"
      L8 = "no"
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.commit
      L5 = "network"
      L3(L4, L5)
    end
  end
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.commit
  L5 = "smartvpn"
  L3(L4, L5)
end
setSmartVPN = L4
function L4(A0)
  local L1, L2
  if A0 and A0 == 0 then
    L1 = os
    L1 = L1.execute
    L2 = "/usr/sbin/mivpn.sh off >/dev/null 2>/dev/null"
    L1(L2)
  end
end
setMiVPN = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if not A0 and not A1 then
    L3 = nil
    return L3
  end
  if A2 == "+" then
    if A0 then
      if not A1 then
        return A0
      end
      L3 = {}
      for L7, L8 in L4, L5, L6 do
        L3[L8] = true
      end
      for L7, L8 in L4, L5, L6 do
        L9 = L3[L8]
        if not L9 then
          L9 = table
          L9 = L9.insert
          L10 = A0
          L11 = L8
          L9(L10, L11)
        end
      end
      return A0
    elseif not A1 then
      L3 = nil
      return L3
    else
      return A1
    end
  elseif A2 == "-" and A0 then
    if not A1 then
      return A0
    end
    L3 = {}
    for L8, L9 in L5, L6, L7 do
      L4[L9] = true
    end
    for L8, L9 in L5, L6, L7 do
      L10 = L4[L9]
      if not L10 then
        L10 = table
        L10 = L10.insert
        L11 = L3
        L12 = L9
        L10(L11, L12)
      end
    end
    return L3
  end
  L3 = nil
  return L3
end
merge = L4
function L4(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  if A0 then
    L3 = A0
    L2 = A0.gsub
    L4 = "http://"
    L5 = ""
    L2 = L2(L3, L4, L5)
    A0 = L2
    L3 = A0
    L2 = A0.gsub
    L4 = "^www"
    L5 = ""
    L2 = L2(L3, L4, L5)
    A0 = L2
    L2 = L1.ipaddr
    L3 = A0
    L2 = L2(L3)
    if not L2 then
      L3 = A0
      L2 = A0.match
      L4 = "^%."
      L2 = L2(L3, L4)
      if not L2 then
        L2 = "."
        L3 = A0
        A0 = L2 .. L3
      end
    end
    return A0
  end
  L2 = nil
  return L2
end
urlFormat = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  if A1 then
    if L2 == "table" then
      goto lbl_10
    end
  end
  do return L2 end
  ::lbl_10::
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = L6
    L7 = L7(L8)
    if L7 then
      L7 = false
      return L7
    else
      L7 = urlFormat
      L8 = L6
      L7 = L7(L8)
      A1[L5] = L7
    end
  end
  if L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE0_
      L8 = L8.isStrNil
      L9 = L7
      L8 = L8(L9)
      if not L8 then
        L8 = urlFormat
        L9 = L7
        L8 = L8(L9)
        L2[L6] = L8
      end
    end
    if A0 == 0 then
      L6 = "+"
    elseif A0 == 1 then
      L6 = "-"
    end
    L3(L4)
  elseif A0 == 0 then
    L3(L4)
  end
  return L3
end
editUrl = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L2 = L2(L3)
  if A1 then
    if L3 == "table" then
      goto lbl_13
    end
  end
  do return L3 end
  ::lbl_13::
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = L7
    L8 = L8(L9)
    if not L8 then
      L8 = L2.macaddr
      L9 = L7
      L8 = L8(L9)
      if L8 then
        goto lbl_31
      end
    end
    L8 = false
    do return L8 end
    goto lbl_36
    ::lbl_31::
    L8 = _UPVALUE0_
    L8 = L8.macFormat
    L9 = L7
    L8 = L8(L9)
    A1[L6] = L8
    ::lbl_36::
  end
  L6 = "device"
  if L3 then
    if L4 then
      if L4 == "table" then
        if A0 == 0 then
          L6 = A1
          L7 = "+"
          L3.mac = L4
        elseif A0 == 1 then
          L6 = A1
          L7 = "-"
          L3.mac = L4
        end
    end
    elseif A0 == 0 then
      L3.mac = A1
    end
    if 0 < L4 then
      L6 = "smartvpn"
      L7 = "record"
      L8 = "device"
      L9 = L3
      L4(L5, L6, L7, L8, L9)
    else
      L6 = "smartvpn"
      L7 = "device"
      L8 = "mac"
      L4(L5, L6, L7, L8)
    end
  elseif A0 == 0 then
    L6 = "smartvpn"
    L7 = "record"
    L8 = "device"
    L9 = {}
    L9.disabled = 0
    L9.mac = A1
    L4(L5, L6, L7, L8, L9)
  end
  L6 = "smartvpn"
  L4(L5, L6)
  return L4
end
editMac = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "network"
  L3 = "vpn"
  L4 = "trafficall"
  L0 = L0(L1, L2, L3, L4)
  if L0 then
    L1 = string
    L1 = L1.lower
    L2 = L0
    L1 = L1(L2)
    if L1 == "yes" then
      L1 = 1
      return L1
  end
  else
    L1 = 0
    return L1
  end
end
mivpnInfo = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "network"
  L4 = "vpn"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "smartvpn"
  L5 = "vpn"
  L6 = "switch"
  L2 = L2(L3, L4, L5, L6)
  if A0 and L2 then
    L3 = tonumber
    L4 = L2
    L3 = L3(L4)
    if L3 == 1 then
      L3 = setSmartVPN
      L4 = 0
      L5 = 1
      L3(L4, L5)
    end
  end
  if L1 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.set
    L5 = "network"
    L6 = "vpn"
    L7 = "trafficall"
    if A0 then
      L8 = "yes"
      if L8 then
        goto lbl_38
      end
    end
    L8 = "no"
    ::lbl_38::
    L3(L4, L5, L6, L7, L8)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.commit
    L5 = "network"
    L3(L4, L5)
    if not A0 then
      L3 = setMiVPN
      L4 = 0
      L3(L4)
    end
    L3 = true
    return L3
  else
    L3 = false
    return L3
  end
end
mivpnSwitch = L4
