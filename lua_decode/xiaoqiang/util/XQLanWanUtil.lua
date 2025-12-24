local L0, L1, L2, L3
L0 = module
L1 = "xiaoqiang.util.XQLanWanUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1, L2 = nil, nil
  L3 = _UPVALUE0_
  L3 = L3.getFeature
  L4 = "0"
  L5 = "system"
  L6 = "BridgeWanMac"
  L3 = L3(L4, L5, L6)
  if "1" == L3 then
    L3 = L0.exec
    L4 = _UPVALUE1_
    L4 = L4.GET_DEFAULT_WAN_MACADDRESS
    L3 = L3(L4)
    L2 = L3
  else
    L3 = _UPVALUE0_
    L3 = L3.getNetMode
    L3 = L3()
    L1 = L3
    if L1 == "wifiapmode" or L1 == "lanapmode" or L1 == "whc_re" then
      L3 = L0.exec
      L4 = _UPVALUE1_
      L4 = L4.GET_DEFAULT_LAN_MACADDRESS
      L3 = L3(L4)
      L2 = L3
    else
      L3 = L0.exec
      L4 = _UPVALUE1_
      L4 = L4.GET_DEFAULT_WAN_MACADDRESS
      L3 = L3(L4)
      L2 = L3
    end
  end
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L2 = nil
    L3 = "null"
    return L3
  else
    L3 = L0.trim
    L4 = L2
    L3 = L3(L4)
    L2 = L3
    L3 = string
    L3 = L3.upper
    L4 = L2
    return L3(L4)
  end
end
getDefaultMacAddress = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_DEFAULT_WAN_MACADDRESS
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = nil
    L2 = "null"
    return L2
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = string
    L2 = L2.upper
    L3 = L1
    return L2(L3)
  end
end
getDefaultWanMacAddress = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_DEFAULT_WAN2_MACADDRESS
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = nil
    L2 = "null"
    return L2
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = string
    L2 = L2.upper
    L3 = L1
    return L2(L3)
  end
end
getDefaultWan2MacAddress = L2
function L2()
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
  L5 = "macaddr"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = string
    L2 = L2.upper
    L3 = L1
    return L2(L3)
  end
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = L2.exec
  L4 = _UPVALUE1_
  L4 = L4.GET_DEFAULT_LAN_MACADDRESS
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L3 = nil
    L4 = "null"
    return L4
  else
    L4 = L2.trim
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    L4 = string
    L4 = L4.upper
    L5 = L3
    return L4(L5)
  end
end
getLanMac = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = "/sbin/phyhelper link service lan"
  L3 = {}
  L7, L8, L9, L10, L11, L12 = L5(L6)
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.match
    L11 = "port:(%d) link:(%S+)"
    L9, L10 = L9(L10, L11)
    if L9 and L10 then
      L11 = tonumber
      L12 = L9
      L11 = L11(L12)
      if L10 == "up" then
        L12 = 1
        if L12 then
          goto lbl_33
        end
      end
      L12 = 0
      ::lbl_33::
      L3[L11] = L12
    end
  end
  return L3
end
getLanLinkList = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.foreach
  L5 = "network"
  L6 = "device"
  function L7(A0)
    local L1, L2, L3
    L1 = A0.name
    L2 = A0[".name"]
    L3 = _UPVALUE0_
    if not L3 then
      L3 = _UPVALUE1_
      if L1 == L3 then
        _UPVALUE0_ = L2
      end
    end
  end
  L3(L4, L5, L6, L7)
  return L1
end
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
  L5 = "ipaddr"
  return L1(L2, L3, L4, L5)
end
getLanIp = L3
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
  L5 = "netmask"
  return L1(L2, L3, L4, L5)
end
getLanMask = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "network"
  L4 = "lan"
  L5 = "ipaddr"
  L1 = L1(L2, L3, L4, L5)
  lanip = L1
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = lanip
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L2 = L0
  L1 = L0.get
  L3 = "network"
  L4 = "lan"
  L5 = "netmask"
  L1 = L1(L2, L3, L4, L5)
  L2 = ".%d+$"
  if L1 ~= "255.255.255.0" then
    L2 = ".%d+.%d+$"
  end
  L3 = lanip
  L4 = L3
  L3 = L3.gsub
  L5 = L2
  L6 = ""
  return L3(L4, L5, L6)
end
getLanIpPre = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L0 = L0.connect
  L0 = L0()
  L2 = L0
  L1 = L0.call
  L3 = "network.interface.lan"
  L4 = "status"
  L5 = {}
  L1 = L1(L2, L3, L4, L5)
  if L1 then
    L2 = L1.route
    if L2 then
      L2 = L1.route
      L2 = #L2
      if 0 < L2 then
        L2 = result
        L3 = wan
        L3 = L3.route
        L3 = L3[1]
        L3 = L3.nexthop
        L3 = L3 or L3
        L2.gw = L3
      end
    end
  end
  L3 = L0
  L2 = L0.close
  L2(L3)
  L2 = ""
  return L2
end
getLanGwaddr = L3
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
  L1 = require
  L2 = "luci.ip"
  L1 = L1(L2)
  L2 = L1.iptonl
  L3 = A0
  L2 = L2(L3)
  L3 = L1.iptonl
  L4 = "1.0.0.0"
  L3 = L3(L4)
  if L2 >= L3 then
    L3 = L1.iptonl
    L4 = "126.0.0.0"
    L3 = L3(L4)
    if L2 <= L3 then
      goto lbl_35
    end
  end
  L3 = L1.iptonl
  L4 = "128.0.0.0"
  L3 = L3(L4)
  if L2 >= L3 then
    L3 = L1.iptonl
    L4 = "223.255.255.255"
    L3 = L3(L4)
    ::lbl_35::
    if L2 <= L3 then
      L3 = true
      return L3
  end
  else
    L3 = false
    return L3
  end
end
_checkIP = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = require
  L3 = "luci.ip"
  L2 = L2(L3)
  L3 = L2.iptonl
  L4 = A0
  L3 = L3(L4)
  L4 = L2.iptonl
  L5 = "10.0.0.0"
  L4 = L4(L5)
  if L3 >= L4 then
    L4 = L2.iptonl
    L5 = "10.255.255.255"
    L4 = L4(L5)
    if L3 <= L4 then
      goto lbl_37
    end
  end
  L4 = L2.iptonl
  L5 = "172.16.0.0"
  L4 = L4(L5)
  if L3 >= L4 then
    L4 = L2.iptonl
    L5 = "172.31.255.255"
    L4 = L4(L5)
    if L3 <= L4 then
      goto lbl_37
    end
  end
  L4 = L2.iptonl
  L5 = "192.168.0.0"
  L4 = L4(L5)
  if L3 >= L4 then
    L4 = L2.iptonl
    L5 = "192.168.255.255"
    L4 = L4(L5)
    ::lbl_37::
    if L3 <= L4 then
      L4 = L2.iptonl
      L5 = "192.168.0.0"
      L4 = L4(L5)
      if L3 >= L4 and A1 ~= "255.255.255.0" then
        L4 = 1527
        return L4
      end
      L4 = 0
      return L4
  end
  else
    L4 = 1527
    return L4
  end
end
checkLanIpMask = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = require
  L3 = "xiaoqiang.XQEvent"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = getLanMask
  L4 = L4()
  L6 = L3
  L5 = L3.set
  L7 = "network"
  L8 = "lan"
  L9 = "ipaddr"
  L10 = A0
  L5(L6, L7, L8, L9, L10)
  L6 = L3
  L5 = L3.set
  L7 = "network"
  L8 = "lan"
  L9 = "netmask"
  L10 = A1
  L5(L6, L7, L8, L9, L10)
  L6 = L3
  L5 = L3.commit
  L7 = "network"
  L5(L6, L7)
  L5 = L2.lanIPChange
  L6 = A0
  L7 = L4
  L8 = A1
  L5(L6, L7, L8)
  L5 = true
  return L5
end
setLanIp = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = ".%d+$"
  if A2 == "255.255.0.0" then
    L4 = ".%d+.%d+$"
  end
  L6 = A0
  L5 = A0.gsub
  L7 = L4
  L8 = ""
  L5 = L5(L6, L7, L8)
  L7 = L3
  L6 = L3.foreach
  L8 = "macbind"
  L9 = "host"
  function L10(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.ip
    L2 = _UPVALUE0_
    L4 = L1
    L3 = L1.match
    L5 = _UPVALUE1_
    L3 = L3(L4, L5)
    L1 = L2 .. L3
    L2 = _UPVALUE2_
    L3 = L2
    L2 = L2.set
    L4 = "macbind"
    L5 = A0[".name"]
    L6 = "ip"
    L7 = L1
    L2(L3, L4, L5, L6, L7)
  end
  L6(L7, L8, L9, L10)
  L7 = L3
  L6 = L3.commit
  L8 = "macbind"
  L6(L7, L8)
  L6 = setDhcpCfg
  L7 = A0
  L8 = A1
  L9 = A2
  L6(L7, L8, L9)
end
hookLanIPChangeEvent = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = require
  L4 = "luci.cbi.datatypes"
  L3 = L3(L4)
  if A0 == 1 then
    L4 = tonumber
    L5 = A1
    L4 = L4(L5)
    L5 = tonumber
    L6 = A2
    L5 = L5(L6)
    L6 = L3.uinteger
    L7 = L4
    L6 = L6(L7)
    if L6 then
      L6 = L3.integer
      L7 = L5
      L6 = L6(L7)
      if L6 then
        goto lbl_24
      end
    end
    L6 = 1537
    do return L6 end
    ::lbl_24::
    if L4 > L5 then
      L6 = 1534
      return L6
    elseif L4 <= 1 or 254 < L5 or L5 <= 1 or 254 < L5 then
      L6 = 1535
      return L6
    end
    L6 = 0
    return L6
  end
  L4 = L3.ipaddr
  L5 = A1
  L4 = L4(L5)
  if L4 then
    L4 = L3.ipaddr
    L5 = A2
    L4 = L4(L5)
    if L4 then
      goto lbl_53
    end
  end
  L4 = 1525
  do return L4 end
  ::lbl_53::
  L4 = require
  L5 = "luci.ip"
  L4 = L4(L5)
  L5 = L4.iptonl
  L6 = A1
  L5 = L5(L6)
  L6 = L4.iptonl
  L7 = A2
  L6 = L6(L7)
  if L5 > L6 then
    L7 = 1534
    return L7
  end
  L7 = 0
  return L7
end
checkDhcpIpPool = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.DHCP_LEASE_FILEPATH
  L4 = L1.foreach
  function L8(A0)
    local L1, L2
    L1 = A0.leasefile
    if L1 then
      L1 = _UPVALUE0_
      L1 = L1.access
      L2 = A0.leasefile
      L1 = L1(L2)
      if L1 then
        L1 = A0.leasefile
        _UPVALUE1_ = L1
        L1 = false
        return L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  L4 = io
  L4 = L4.open
  L4 = L4(L5, L6)
  if L4 then
    for L8 in L5, L6, L7 do
      if L8 then
        L10 = L8
        L9 = L8.match
        L11 = "^(%d+) (%S+) (%S+) (%S+)"
        L9, L10, L11, L12 = L9(L10, L11)
        if L12 == "*" then
          L12 = ""
        end
        if L9 and L10 and L11 and L12 then
          L13 = {}
          L14 = string
          L14 = L14.lower
          L15 = _UPVALUE1_
          L15 = L15.macFormat
          L16 = L10
          L15, L16 = L15(L16)
          L14 = L14(L15, L16)
          L13.mac = L14
          L13.ip = L11
          L13.name = L12
          L2[L11] = L13
        end
      end
    end
    L5(L6)
  end
  return L2
end
_parseDhcpLeases = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = ".%d+$"
  if A2 ~= "255.255.255.0" then
    L4 = ".%d+.%d+$"
  end
  L6 = A0
  L5 = A0.gsub
  L7 = L4
  L8 = ""
  L5 = L5(L6, L7, L8)
  L7 = L3
  L6 = L3.foreach
  L8 = "dhcp"
  L9 = "host"
  function L10(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.ip
    L2 = _UPVALUE0_
    L4 = L1
    L3 = L1.match
    L5 = _UPVALUE1_
    L3 = L3(L4, L5)
    L1 = L2 .. L3
    L2 = _UPVALUE2_
    L3 = L2
    L2 = L2.set
    L4 = "dhcp"
    L5 = A0[".name"]
    L6 = "ip"
    L7 = L1
    L2(L3, L4, L5, L6, L7)
  end
  L6(L7, L8, L9, L10)
  if A1 == A2 then
    if A2 ~= "255.255.255.0" then
      L7 = L3
      L6 = L3.get
      L8 = "dhcp"
      L9 = "lan"
      L10 = "startip"
      L6 = L6(L7, L8, L9, L10)
      L8 = L3
      L7 = L3.get
      L9 = "dhcp"
      L10 = "lan"
      L11 = "endip"
      L7 = L7(L8, L9, L10, L11)
      if nil == L6 or nil == L7 then
        L8 = L5
        L9 = ".0.5"
        L6 = L8 .. L9
        L8 = L5
        L9 = ".3.237"
        L7 = L8 .. L9
      else
        L8 = L5
        L10 = L6
        L9 = L6.match
        L11 = L4
        L9 = L9(L10, L11)
        L6 = L8 .. L9
        L8 = L5
        L10 = L7
        L9 = L7.match
        L11 = L4
        L9 = L9(L10, L11)
        L7 = L8 .. L9
      end
      L9 = L3
      L8 = L3.set
      L10 = "dhcp"
      L11 = "lan"
      L12 = "startip"
      L13 = L6
      L8(L9, L10, L11, L12, L13)
      L9 = L3
      L8 = L3.set
      L10 = "dhcp"
      L11 = "lan"
      L12 = "endip"
      L13 = L7
      L8(L9, L10, L11, L12, L13)
    end
    L7 = L3
    L6 = L3.commit
    L8 = "dhcp"
    L6(L7, L8)
    return
  end
  if A2 == "255.255.255.0" then
    L7 = L3
    L6 = L3.set
    L8 = "dhcp"
    L9 = "lan"
    L10 = "start"
    L11 = "5"
    L6(L7, L8, L9, L10, L11)
    L7 = L3
    L6 = L3.set
    L8 = "dhcp"
    L9 = "lan"
    L10 = "limit"
    L11 = "250"
    L6(L7, L8, L9, L10, L11)
    L7 = L3
    L6 = L3.delete
    L8 = "dhcp"
    L9 = "lan"
    L10 = "startip"
    L6(L7, L8, L9, L10)
    L7 = L3
    L6 = L3.delete
    L8 = "dhcp"
    L9 = "lan"
    L10 = "endip"
    L6(L7, L8, L9, L10)
    L7 = L3
    L6 = L3.delete
    L8 = "dhcp"
    L9 = "lan"
    L10 = "router"
    L6(L7, L8, L9, L10)
  elseif A2 == "255.255.0.0" then
    L7 = L3
    L6 = L3.set
    L8 = "dhcp"
    L9 = "lan"
    L10 = "startip"
    L11 = L5
    L12 = ".0.5"
    L11 = L11 .. L12
    L6(L7, L8, L9, L10, L11)
    L7 = L3
    L6 = L3.set
    L8 = "dhcp"
    L9 = "lan"
    L10 = "endip"
    L11 = L5
    L12 = ".3.237"
    L11 = L11 .. L12
    L6(L7, L8, L9, L10, L11)
    L7 = L3
    L6 = L3.delete
    L8 = "dhcp"
    L9 = "lan"
    L10 = "router"
    L6(L7, L8, L9, L10)
  end
  L7 = L3
  L6 = L3.commit
  L8 = "dhcp"
  L6(L7, L8)
end
setDhcpCfg = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "dhcp"
  L5 = "lan"
  L6 = "miwifi_force_ignore"
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.get
  L5 = "dhcp"
  L6 = "lan"
  L7 = "leasetime"
  L3 = L3(L4, L5, L6, L7)
  if L2 ~= "1" then
    L2 = "0"
  end
  L5 = L3
  L4 = L3.match
  L6 = "^(%d+)([^%d]+)"
  L4, L5 = L4(L5, L6)
  L6 = getLanWanIp
  L7 = "lan"
  L6 = L6(L7)
  L0.lanIp = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "start"
  L6 = L6(L7, L8, L9, L10)
  L0.start = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "startip"
  L6 = L6(L7, L8, L9, L10)
  L0.startip = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "endip"
  L6 = L6(L7, L8, L9, L10)
  L0.endip = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "limit"
  L6 = L6(L7, L8, L9, L10)
  L0.limit = L6
  L0.leasetime = L3
  L0.leasetimeNum = L4
  L0.leasetimeUnit = L5
  L0.ignore = L2
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "router"
  L6 = L6(L7, L8, L9, L10)
  L0.router = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "dns1"
  L6 = L6(L7, L8, L9, L10)
  L0.dns1 = L6
  L7 = L1
  L6 = L1.get
  L8 = "dhcp"
  L9 = "lan"
  L10 = "dns2"
  L6 = L6(L7, L8, L9, L10)
  L0.dns2 = L6
  return L0
end
getLanDHCPService = L3
function L3(A0, A1, A2, A3, A4, A5, A6, A7, A8)
  local L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L9 = require
  L10 = "luci.model.uci"
  L9 = L9(L10)
  L9 = L9.cursor
  L9 = L9()
  L10 = require
  L11 = "luci.util"
  L10 = L10(L11)
  if A5 == "1" then
    L12 = L9
    L11 = L9.set
    L13 = "dhcp"
    L14 = "lan"
    L15 = "miwifi_force_ignore"
    L16 = tonumber
    L17 = A5
    L16, L17, L18 = L16(L17)
    L11(L12, L13, L14, L15, L16, L17, L18)
    L12 = L9
    L11 = L9.set
    L13 = "dhcp"
    L14 = "lan"
    L15 = "ignore"
    L16 = tonumber
    L17 = A5
    L16, L17, L18 = L16(L17)
    L11(L12, L13, L14, L15, L16, L17, L18)
  else
    if A2 and A3 then
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "startip"
      L16 = A2
      L11(L12, L13, L14, L15, L16)
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "endip"
      L16 = A3
      L11(L12, L13, L14, L15, L16)
    else
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "start"
      L16 = tonumber
      L17 = A0
      L16, L17, L18 = L16(L17)
      L11(L12, L13, L14, L15, L16, L17, L18)
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "limit"
      L16 = tonumber
      L17 = A1
      L16 = L16(L17)
      L17 = tonumber
      L18 = A0
      L17 = L17(L18)
      L16 = L16 - L17
      L16 = L16 + 1
      L11(L12, L13, L14, L15, L16)
    end
    L12 = L9
    L11 = L9.set
    L13 = "dhcp"
    L14 = "lan"
    L15 = "leasetime"
    L16 = A4
    L11(L12, L13, L14, L15, L16)
    if A6 then
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "router"
      L16 = A6
      L11(L12, L13, L14, L15, L16)
    end
    if A7 then
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "dns1"
      L16 = A7
      L11(L12, L13, L14, L15, L16)
    end
    if A8 then
      L12 = L9
      L11 = L9.set
      L13 = "dhcp"
      L14 = "lan"
      L15 = "dns2"
      L16 = A8
      L11(L12, L13, L14, L15, L16)
    end
    L12 = L9
    L11 = L9.delete
    L13 = "dhcp"
    L14 = "lan"
    L15 = "miwifi_force_ignore"
    L11(L12, L13, L14, L15)
    L12 = L9
    L11 = L9.delete
    L13 = "dhcp"
    L14 = "lan"
    L15 = "ignore"
    L11(L12, L13, L14, L15)
  end
  L12 = L9
  L11 = L9.save
  L13 = "dhcp"
  L11(L12, L13)
  L12 = L9
  L11 = L9.commit
  L13 = "dhcp"
  L11(L12, L13)
  L11 = L10.exec
  L12 = "/etc/init.d/dnsmasq restart > /dev/null"
  L11(L12)
end
setLanDHCPService = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "macbind"
  L5 = "host"
  function L6(A0)
    local L1, L2, L3
    L1 = {}
    L2 = A0.name
    L1.name = L2
    L2 = A0.mac
    L1.mac = L2
    L2 = A0.ip
    L1.ip = L2
    L1.tag = 1
    L2 = _UPVALUE0_
    L3 = A0.mac
    L2[L3] = L1
  end
  L2(L3, L4, L5, L6)
  L3 = L0
  L2 = L0.foreach
  L4 = "dhcp"
  L5 = "host"
  function L6(A0)
    local L1, L2, L3
    L1 = {}
    L2 = A0.name
    L1.name = L2
    L2 = A0.mac
    L1.mac = L2
    L2 = A0.ip
    L1.ip = L2
    L1.tag = 2
    L2 = _UPVALUE0_
    L3 = A0.mac
    L2[L3] = L1
  end
  L2(L3, L4, L5, L6)
  return L1
end
macBindInfo = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = _checkIP
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = _checkMac
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = _parseDhcpLeases
      L3 = L3()
      L4 = string
      L4 = L4.lower
      L5 = _UPVALUE0_
      L5 = L5.macFormat
      L6 = A0
      L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
      L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12)
      A0 = L4
      L4 = L3[A1]
      if L4 then
        L5 = L4.mac
        if L5 ~= A0 then
          L5 = 1
          return L5
        end
      end
      L5 = _parseMac
      L6 = A0
      L5 = L5(L6)
      L6 = {}
      L6.name = L5
      L6.mac = A0
      L6.ip = A1
      L8 = L2
      L7 = L2.section
      L9 = "macbind"
      L10 = "host"
      L11 = L5
      L12 = L6
      L7(L8, L9, L10, L11, L12)
      L8 = L2
      L7 = L2.commit
      L9 = "macbind"
      L7(L8, L9)
  end
  else
    L3 = 2
    return L3
  end
  L3 = 0
  return L3
end
addBind = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = _checkMac
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = _parseMac
    L3 = A0
    L2 = L2(L3)
    L4 = L1
    L3 = L1.delete
    L5 = "macbind"
    L6 = L2
    L3(L4, L5, L6)
    L4 = L1
    L3 = L1.delete
    L5 = "dhcp"
    L6 = L2
    L3(L4, L5, L6)
    L4 = L1
    L3 = L1.commit
    L5 = "macbind"
    L3(L4, L5)
    L4 = L1
    L3 = L1.commit
    L5 = "dhcp"
    L3(L4, L5)
    L3 = true
    return L3
  else
    L2 = false
    return L2
  end
end
removeBind = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.delete_all
  L3 = "dhcp"
  L4 = "host"
  L1(L2, L3, L4)
  L2 = L0
  L1 = L0.delete_all
  L3 = "macbind"
  L4 = "host"
  L1(L2, L3, L4)
  L2 = L0
  L1 = L0.commit
  L3 = "dhcp"
  L1(L2, L3)
  L2 = L0
  L1 = L0.commit
  L3 = "macbind"
  L1(L2, L3)
end
unbindAll = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.delete_all
  L3 = "dhcp"
  L4 = "host"
  L1(L2, L3, L4)
  L2 = L0
  L1 = L0.foreach
  L3 = "macbind"
  L4 = "host"
  function L5(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = {}
    L2 = A0.name
    L1.name = L2
    L2 = A0.mac
    L1.mac = L2
    L2 = A0.ip
    L1.ip = L2
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.section
    L4 = "dhcp"
    L5 = "host"
    L6 = A0.name
    L7 = L1
    L2(L3, L4, L5, L6, L7)
  end
  L1(L2, L3, L4, L5)
  L2 = L0
  L1 = L0.commit
  L3 = "dhcp"
  L1(L2, L3)
end
saveBindInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = L0.readfile
  L2 = _UPVALUE0_
  L2 = L2.WAN_MONITOR_STAT_FILEPATH
  L1 = L1(L2)
  L2 = {}
  if L1 ~= nil then
    for L6 in L3, L4, L5 do
      L8 = L6
      L7 = L6.match
      L9 = "(%S+)=(%S+)"
      L7, L8 = L7(L8, L9)
      value = L8
      key = L7
      L7 = key
      L8 = value
      L2[L7] = L8
    end
  end
  return L2
end
getWanMonitorStat = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "INITTED"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = L0.execi
  L4 = "/usr/sbin/wanlinkprobe 7 WAN pppoe dhcp"
  L3 = L3(L4)
  L4, L5, L6, L7 = nil, nil, nil, nil
  if L3 then
    for L11 in L8, L9, L10 do
      L13 = L11
      L12 = L11.match
      L14 = "^LINK=(%S+)"
      L12 = L12(L13, L14)
      if L12 ~= nil then
        L13 = L11
        L12 = L11.match
        L14 = "^LINK=(%S+)"
        L12 = L12(L13, L14)
        L4 = L12
      else
        L13 = L11
        L12 = L11.match
        L14 = "^PPPOE=(%S+)"
        L12 = L12(L13, L14)
        if L12 ~= nil then
          L13 = L11
          L12 = L11.match
          L14 = "^PPPOE=(%S+)"
          L12 = L12(L13, L14)
          L5 = L12
        else
          L13 = L11
          L12 = L11.match
          L14 = "^DHCP=(%S+)"
          L12 = L12(L13, L14)
          if L12 ~= nil then
            L13 = L11
            L12 = L11.match
            L14 = "^DHCP=(%S+)"
            L12 = L12(L13, L14)
            L6 = L12
          else
            L13 = L11
            L12 = L11.match
            L14 = "^STATIC=(%S+)"
            L12 = L12(L13, L14)
            if L12 ~= nil then
              L13 = L11
              L12 = L11.match
              L14 = "^STATIC=(%S+)"
              L12 = L12(L13, L14)
              L7 = L12
            end
          end
        end
      end
    end
  end
  if L5 == "YES" then
    return L8
  elseif L6 == "YES" then
    return L8
  elseif L7 == "YES" then
    return L8
  elseif L4 ~= "YES" then
    return L8
  else
    return L8
  end
end
getAutoWanType = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "nixio"
  L2 = L2(L3)
  L3 = A1 or L3
  if not A1 then
    L3 = 1
  end
  L4 = _UPVALUE0_
  L4 = L4.waitExec
  L5 = "/sbin/phyhelper"
  L6 = "link"
  L4, L5, L6 = L4(L5, L6, L7, L8)
  for L10 = L7, L8, L9 do
    L11 = _UPVALUE0_
    L11 = L11.isStrNil
    L12 = L6
    L11 = L11(L12)
    if not L11 then
      L12 = L6
      L11 = L6.match
      L13 = "port:(%d) link:(%S+)"
      L11, L12 = L11(L12, L13)
      if L12 and L12 == "up" then
        L13 = true
        return L13
      end
    end
    L11 = L2.nanosleep
    L12 = 0
    L13 = 100000000
    L11(L12, L13)
  end
  if L7 then
    L10 = "*all"
    L10 = L7
    L9(L10)
    L10 = L8
    if 0 < L9 then
      return L9
    end
  end
  return L8
end
getWanLink = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L1 = L1.connect
  L1 = L1()
  L2 = A0 or L2
  if not A0 then
    L2 = "wan"
  end
  L4 = L1
  L3 = L1.call
  L5 = "network.interface."
  L6 = L2
  L5 = L5 .. L6
  L6 = "status"
  L3 = L3(L4, L5, L6, L7)
  L4 = {}
  if not L3 then
    L6 = L1
    L5 = L1.close
    L5(L6)
    L5 = nil
    return L5
  end
  L5 = L3["ipv4-address"]
  if L5 then
    L5 = L3["ipv4-address"]
    L5 = #L5
    if 0 < L5 then
      L5 = require
      L6 = "luci.util"
      L5 = L5(L6)
      L6 = {}
      for L10, L11 in L7, L8, L9 do
        L12 = #L6
        L12 = L12 + 1
        L13 = {}
        L6[L12] = L13
        L12 = #L6
        L12 = L6[L12]
        L13 = L11.address
        L12.ip = L13
        L12 = L5.exec
        L13 = "ipcalc.sh 255.255.255.255/"
        L14 = L11.mask
        L15 = " | grep \"NETWORK\" | cut -d '=' -f 2"
        L13 = L13 .. L14 .. L15
        L12 = L12(L13)
        L13 = #L6
        L13 = L6[L13]
        L14 = string
        L14 = L14.trim
        L15 = L12
        L14 = L14(L15)
        L13.mask = L14
      end
      L4.ipv4 = L6
  end
  else
    L5 = {}
    L6 = {}
    L6.ip = ""
    L6.mask = ""
    L5[1] = L6
    L4.ipv4 = L5
  end
  L5 = L3.route
  if L5 then
    L5 = L3.route
    L5 = #L5
    if 0 < L5 then
      L5 = L3.route
      L5 = L5[1]
      L5 = L5.nexthop
      L4.gw = L5
  end
  else
    L4.gw = ""
  end
  L5 = L3["dns-server"]
  L5 = L5 or L5
  L4.dns = L5
  L5 = string
  L5 = L5.lower
  L6 = L3.proto
  L6 = L6 or L6
  L5 = L5(L6)
  L4.proto = L5
  L5 = L3.up
  L4.up = L5
  L5 = L3.uptime
  L5 = L5 or L5
  L4.uptime = L5
  L5 = L3.pending
  L4.pending = L5
  L5 = L3.autostart
  L4.autostart = L5
  L6 = L1
  L5 = L1.close
  L5(L6)
  return L4
end
ubusWanStatus = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = "lua /usr/sbin/pppoe.lua status "
  L4 = A0
  L3 = L3 .. L4
  L4 = L2.exec
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L2.trim
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    L5 = _UPVALUE0_
    L5 = L5.isStrNil
    L6 = L4
    L5 = L5(L6)
    if L5 then
      L5 = false
      return L5
    end
    L5 = L1.decode
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    return L4
  else
    L5 = false
    return L5
  end
end
_pppoeStatusCheck = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = {}
  L1["507"] = 1
  L1["691"] = 1
  L1["509"] = 1
  L1["514"] = 1
  L1["520"] = 1
  L1["646"] = 1
  L1["647"] = 1
  L1["648"] = 1
  L1["649"] = 1
  L1["691"] = 1
  L1["646"] = 1
  L1["678"] = 1
  L2 = {}
  L2["516"] = 1
  L2["650"] = 1
  L2["601"] = 1
  L2["510"] = 1
  L2["530"] = 1
  L2["531"] = 1
  L3 = {}
  L3["501"] = 1
  L3["502"] = 1
  L3["503"] = 1
  L3["504"] = 1
  L3["505"] = 1
  L3["506"] = 1
  L3["507"] = 1
  L3["508"] = 1
  L3["511"] = 1
  L3["512"] = 1
  L3["515"] = 1
  L3["517"] = 1
  L3["518"] = 1
  L3["519"] = 1
  L4 = tostring
  L5 = A0
  L4 = L4(L5)
  if L4 then
    L5 = L1[L4]
    if L5 then
      L5 = 1
      return L5
    end
    L5 = L2[L4]
    if L5 then
      L5 = 2
      return L5
    end
    L5 = L3[L4]
    if L5 then
      L5 = 3
      return L5
    end
    L5 = 1
    return L5
  end
end
_pppoeErrorCodeHelper = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "network"
  L5 = "wan"
  L6 = "username"
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = "wan"
  L7 = "password"
  L3 = L3(L4, L5, L6, L7)
  L4 = tonumber
  L6 = L1
  L5 = L1.get
  L7 = "network"
  L8 = "wan"
  L9 = "last_succeed"
  L5, L6, L7, L8, L9 = L5(L6, L7, L8, L9)
  L4 = L4(L5, L6, L7, L8, L9)
  L4 = L4 or L4
  if L2 and L3 then
    if A0 == 691 then
      if L4 == 0 then
        L5 = 33
        return L5
      else
        L5 = 34
        return L5
      end
    elseif A0 == 678 then
      if L4 == 0 then
        L5 = 35
        return L5
      else
        L5 = 36
        return L5
      end
    end
  end
  L5 = nil
  return L5
end
_pppoeError = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = "port_map port service "
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L3 = ""
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = L1.exec
    L5 = "phyhelper speed port "
    L6 = L2
    L5 = L5 .. L6
    L4 = L4(L5)
    L3 = L4
  end
  return L3
end
getPhyhelperWanSpeed = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQErrorUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    A0 = "wan"
  end
  L6 = L1
  L5 = L1.get
  L7 = "network"
  L8 = A0
  L9 = "proto"
  L5 = L5(L6, L7, L8, L9)
  L6 = getWanLink
  L7 = A0
  L8 = 3
  L6 = L6(L7, L8)
  L7 = ubusWanStatus
  L8 = A0
  L7 = L7(L8)
  L4.proto = L5
  L4.status = 0
  if L5 == "pppoe" then
    if not L6 then
      L4.status = 3
      L4.errcode = 678
      L4.errtype = 2
      L4.perror = 35
    else
      if not L7 then
        goto lbl_169
      end
      L8 = L7.up
      if L8 then
        L4.status = 2
      else
        L8 = _pppoeStatusCheck
        L9 = A0
        L8 = L8(L9)
        if L8 then
          L9 = L8.process
          if L9 == "down" then
            L4.status = 4
            L9 = L8.code
            if L9 ~= nil then
              L9 = L8.code
              if L9 ~= 0 then
                L9 = L8.msg
                L9 = L9 or L9
                L4.errcode = L9
                L9 = _pppoeErrorCodeHelper
                L10 = tostring
                L11 = L8.code
                L10, L11, L12, L13, L14 = L10(L11)
                L9 = L9(L10, L11, L12, L13, L14)
                L4.errtype = L9
                L9 = _pppoeError
                L10 = L8.msg
                L9 = L9(L10)
                L4.perror = L9
            end
            else
              L4.errtype = 0
              L4.errcode = ""
            end
          else
            L9 = L8.process
            if L9 == "up" then
              L4.status = 2
            else
              L9 = L8.process
              if L9 == "connecting" then
                L9 = L8.code
                if L9 ~= nil then
                  L9 = L8.code
                  if L9 ~= 0 then
                    goto lbl_100
                  end
                end
                L4.status = 1
                goto lbl_116
                ::lbl_100::
                L4.status = 3
                L9 = L8.msg
                L9 = L9 or L9
                L4.errcode = L9
                L9 = _pppoeErrorCodeHelper
                L10 = tostring
                L11 = L8.code
                L10, L11, L12, L13, L14 = L10(L11)
                L9 = L9(L10, L11, L12, L13, L14)
                L4.errtype = L9
                L9 = _pppoeError
                L10 = L8.msg
                L9 = L9(L10)
                L4.perror = L9
              end
            end
          end
        end
      end
      ::lbl_116::
      L9 = L1
      L8 = L1.get
      L10 = "network"
      L11 = A0
      L12 = "dns"
      L8 = L8(L9, L10, L11, L12)
      L9 = _UPVALUE0_
      L9 = L9.isStrNil
      L10 = L8
      L9 = L9(L10)
      if not L9 then
        L9 = type
        L10 = L8
        L9 = L9(L10)
        if L9 == "table" then
          L4.cdns = L8
        else
          L9 = type
          L10 = L8
          L9 = L9(L10)
          if L9 == "string" then
            L9 = L2.split
            L10 = L8
            L11 = " "
            L9 = L9(L10, L11)
            L4.cdns = L9
          end
        end
      end
      L10 = L1
      L9 = L1.get
      L11 = "network"
      L12 = A0
      L13 = "username"
      L9 = L9(L10, L11, L12, L13)
      L4.pppoename = L9
      L10 = L1
      L9 = L1.get
      L11 = "network"
      L12 = A0
      L13 = "password"
      L9 = L9(L10, L11, L12, L13)
      L4.password = L9
      L10 = L1
      L9 = L1.get
      L11 = "network"
      L12 = A0
      L13 = "peerdns"
      L9 = L9(L10, L11, L12, L13)
      L4.peerdns = L9
    end
  elseif L7 then
    L8 = L7.up
    if L8 then
      L4.status = 2
    end
  end
  ::lbl_169::
  L8 = {}
  L4.ip = L8
  if L7 then
    L8 = L7.up
    if L8 then
      L8 = L4.ip
      L9 = L7.ipv4
      L9 = L9[1]
      L9 = L9.ip
      L8.address = L9
      L8 = L4.ip
      L9 = L7.ipv4
      L9 = L9[1]
      L9 = L9.mask
      L8.mask = L9
      L8 = L7.dns
      L4.dns = L8
      L8 = L7.gw
      L4.gw = L8
      L8 = getPhyhelperWanSpeed
      L9 = A0
      L8 = L8(L9)
      L4.wanSpeed = L8
  end
  else
    L8 = L4.ip
    L8.address = ""
    L8 = L4.ip
    L8.mask = ""
    L8 = {}
    L4.dns = L8
    L4.gw = ""
    L4.wanSpeed = ""
  end
  L8 = _UPVALUE0_
  L8 = L8.getFeature
  L9 = "0"
  L10 = "system"
  L11 = "international"
  L8 = L8(L9, L10, L11)
  if "1" == L8 then
    L8 = chkWan4VPNEnable
    L8 = L8()
    if L8 then
      L8 = require
      L9 = "xiaoqiang.util.XQVPNUtil"
      L8 = L8(L9)
      L8 = L8.vpnStatus
      L8 = L8()
      L9 = {}
      L10 = nil
      if L8 then
        L11 = L8.proto
        L9.proto = L11
        L11 = {}
        L11.address = ""
        L11.mask = 0
        L9.ip = L11
        L11 = L8.up
        if L11 then
          L9.status = 2
          L11 = L8.uptime
          L9.uptime = L11
          L11 = L8["ipv4-address"]
          if L11 then
            L11 = L8["ipv4-address"]
            L11 = #L11
            if 0 < L11 then
              L11 = L8["ipv4-address"]
              L11 = L11[1]
              L9.ip = L11
              L11 = L2.exec
              L12 = "ipcalc.sh 255.255.255.255/"
              L13 = L9.ip
              L13 = L13.mask
              L14 = " | grep \"NETWORK\" | cut -d '=' -f 2"
              L12 = L12 .. L13 .. L14
              L11 = L11(L12)
              L10 = L11
              L11 = L9.ip
              L12 = L2.trim
              L13 = L10
              L12 = L12(L13)
              L11.mask = L12
            end
          end
          L11 = L8["dns-server"]
          L9.dns = L11
        else
          L11 = L8.autostart
          if L11 then
            L11 = L8.stat
            if L11 then
              L11 = L8.stat
              L11 = L11.code
              if L11 ~= 0 then
                L9.status = 3
                L9.uptime = 0
                L11 = L8.stat
                L11 = L11.code
                L9.errcode = L11
                L11 = L3.getErrorMessage
                L12 = _vpnErrorCodeHelper
                L13 = L8.stat
                L13 = L13.code
                L12, L13, L14 = L12(L13)
                L11 = L11(L12, L13, L14)
                L12 = " "
                L13 = tostring
                L14 = L8.stat
                L14 = L14.code
                L13 = L13(L14)
                L11 = L11 .. L12 .. L13
                L9.errmsg = L11
            end
            else
              L9.status = 1
              L9.uptime = 0
            end
          else
            L9.status = 4
            L9.uptime = 0
            L11 = L8.stat
            if L11 then
              L11 = L8.stat
              if L11 == 701 then
                L9.status = 2
                L9.uptime = 0
                L11 = L8.stat
                L11 = L11.code
                L9.errcode = L11
                L11 = L3.getErrorMessage
                L12 = _vpnErrorCodeHelper
                L13 = L8.stat
                L13 = L13.code
                L12, L13, L14 = L12(L13)
                L11 = L11(L12, L13, L14)
                L12 = " "
                L13 = tostring
                L14 = L8.stat
                L14 = L14.code
                L13 = L13(L14)
                L11 = L11 .. L12 .. L13
                L9.errmsg = L11
              end
            end
          end
        end
        L11 = L8.proto
        L4.wanType = L11
        L4.vpnInfo = L9
      end
    end
  end
  return L4
end
getPPPoEStatus = L3
function L3(A0)
  local L1, L2, L3
  L1 = os
  L1 = L1.execute
  L2 = "lua /usr/sbin/pppoe.lua down "
  L3 = A0
  L2 = L2 .. L3
  L1(L2)
end
pppoeStop = L3
function L3(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = "lua /usr/sbin/pppoe.lua up "
  L3 = A0
  L2 = L2 .. L3
  L1(L2)
end
pppoeStart = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L2.service = ""
  L2.pppoename = ""
  L2.pppoepasswd = ""
  L3 = L1.execl
  L3 = L3(L4)
  if L3 then
    if L4 == "table" then
      for L7, L8 in L4, L5, L6 do
        L9 = _UPVALUE0_
        L9 = L9.isStrNil
        L10 = L8
        L9 = L9(L10)
        if not L9 then
          L9 = L1.trim
          L10 = L8
          L9 = L9(L10)
          L10 = L9
          L9 = L9.match
          L11 = "^Service%-Name:%s(.+)"
          L9 = L9(L10, L11)
          L10 = _UPVALUE0_
          L10 = L10.isStrNil
          L11 = L9
          L10 = L10(L11)
          if not L10 then
            L2.service = L9
          end
          L10 = L1.trim
          L11 = L8
          L10 = L10(L11)
          L11 = L10
          L10 = L10.match
          L12 = "PPPoE:"
          L10 = L10(L11, L12)
          if L10 then
            L10 = L7 + 1
            L10 = L3[L10]
            L11 = L7 + 2
            L11 = L3[L11]
            L12 = _UPVALUE0_
            L12 = L12.isStrNil
            L13 = L10
            L12 = L12(L13)
            if not L12 then
              L12 = L1.trim
              L13 = L10
              L12 = L12(L13)
              L2.pppoename = L12
            end
            L12 = _UPVALUE0_
            L12 = L12.isStrNil
            L13 = L11
            L12 = L12(L13)
            if not L12 then
              L12 = L1.trim
              L13 = L11
              L12 = L12(L13)
              L2.pppoepasswd = L12
            end
            break
          end
        end
      end
    end
  end
  if L4 then
    if L4 then
      L2.code = 1
    end
  end
  return L2
end
pppoeCatch = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = L1.wanGetConfig
  L2 = L2()
  L3 = 0
  L4 = L2.mode
  if L4 == L5 then
    L3 = 0
  else
    L4 = L2.mode
    if L4 == L5 then
      L4 = getWanLink
      L4 = L4(L5, L6)
      if L4 then
        L4 = 1
        if L4 then
          goto lbl_30
          L3 = L4 or L3
        end
      end
      L3 = 0
      ::lbl_30::
    else
      L4 = L2.mode
      if L4 == L5 then
        L4 = "/sbin/phyhelper link type eth"
        L8, L9, L10, L11, L12 = L6(L7)
        for L8, L9 in L5, L6, L7 do
          L11 = L9
          L10 = L9.match
          L12 = "port:(%d) link:(%S+)"
          L10, L11 = L10(L11, L12)
          if L11 and L11 == "up" then
            L3 = 1
            break
          end
        end
      end
    end
  end
  return L3
end
checkWiredLink = L3
function L3(A0)
  local L1, L2
  if A0 == "lan" then
    L1 = getLanInfo
    L2 = A0
    return L1(L2)
  else
    L1 = getWanInfo
    L2 = A0
    return L1(L2)
  end
end
getLanWanInfo = L3
function L3(A0)
  local L1, L2, L3
  L1 = ubusWanStatus
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L2 = {}
    L3 = L1.ipv4
    L2.ipv4 = L3
    L3 = L1.uptime
    L2.uptime = L3
    L3 = L1.up
    if L3 then
      L3 = 1
      if L3 then
        goto lbl_18
      end
    end
    L3 = 0
    ::lbl_18::
    L2.status = L3
    L3 = getLanMac
    L3 = L3()
    L2.mac = L3
    return L2
  end
  L2 = nil
  return L2
end
getLanInfo = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  L2 = getWanLink
  L3 = A0
  L4 = 1
  L2 = L2(L3, L4)
  if L2 then
    L2 = 1
    if L2 then
      goto lbl_12
    end
  end
  L2 = 0
  ::lbl_12::
  L1.link = L2
  L2 = getWanDetails
  L3 = A0
  L2 = L2(L3)
  L1.details = L2
  L2 = L1.details
  if L2 then
    L2 = L1.details
    L2 = L2.mtu
    L1.mtu = L2
    L2 = L1.details
    L2 = L2.special
    L1.special = L2
  end
  L2 = getWanMac
  L3 = A0
  L2 = L2(L3)
  L1.mac = L2
  L2 = ubusWanStatus
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L3 = L2.ipv4
    L1.ipv4 = L3
    L3 = L2.gw
    L1.gateWay = L3
    L3 = L2.dns
    L3 = L3[1]
    L3 = L3 or L3
    L1.dnsAddrs = L3
    L3 = L2.dns
    L3 = L3[2]
    L3 = L3 or L3
    L1.dnsAddrs1 = L3
    L3 = L2.uptime
    L1.uptime = L3
    L3 = L2.up
    if L3 then
      L1.status = 1
      L3 = L1.details
      if L3 then
        L3 = L1.details
        L3 = L3.wanType
        if L3 == "pppoe" then
          L3 = getWanMonitorStat
          L3 = L3()
          wanMonitor = L3
          L3 = wanMonitor
          L3 = L3.WANLINKSTAT
          if L3 ~= "UP" then
            L1.status = 0
          end
        end
      end
    else
      L1.status = 0
    end
  end
  L3 = getWan6Sec
  L4 = A0
  L3 = L3(L4)
  L4 = getIp6Details
  L5 = "all"
  L6 = L3
  L4 = L4(L5, L6)
  L1.ipv6_info = L4
  L1.ipv6_show = 1
  L4 = _UPVALUE0_
  L4 = L4.getFeature
  L5 = "0"
  L6 = "system"
  L7 = "international"
  L4 = L4(L5, L6, L7)
  if "1" == L4 and A0 == "wan" then
    L4 = require
    L5 = "xiaoqiang.util.XQVPNUtil"
    L4 = L4(L5)
    L4 = L4.getVPNInfo
    L5 = "vpn"
    L4 = L4(L5)
    if L4 then
      L5 = {}
      L1.vpnInfo = L5
      L5 = L1.vpnInfo
      L6 = L4.username
      L5.username = L6
      L5 = L1.vpnInfo
      L6 = L4.password
      L5.password = L6
      L5 = L1.vpnInfo
      L6 = L4.server
      L5.server = L6
      L5 = L1.vpnInfo
      L6 = L4.proto
      L5.proto = L6
      L5 = chkWan4VPNEnable
      L5 = L5()
      if L5 then
        L5 = L1.details
        L6 = L1.details
        L6 = L6.wanType
        L5.baseWanType = L6
        L5 = L1.details
        L6 = L4.proto
        L5.wanType = L6
      end
    end
  end
  return L1
end
getWanInfo = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  if not A0 then
    L3 = require
    L4 = "cjson"
    L3 = L3(L4)
    L4 = L1.exec
    L4 = L4(L5)
    L2 = L5
  else
    L2 = A0
  end
  L3 = nil
  L4 = L1.exec
  L4 = L4(L5)
  L8 = ""
  L4 = L5
  for L8, L9 in L5, L6, L7 do
    if L10 ~= nil then
      for L13, L14 in L10, L11, L12 do
        L15 = L14.ip
        if L15 == L4 then
          L3 = L14.ifname
          break
        end
      end
    end
  end
  return L3
end
getDefaultGWDev = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L1 = L1.connect
  L1 = L1()
  L3 = L1
  L2 = L1.call
  L4 = "network.interface."
  L4 = L4 .. L5
  L2 = L2(L3, L4, L5, L6)
  L3 = {}
  if L2 then
    L4 = L2["ipv4-address"]
    if L4 then
      L4 = L2["ipv4-address"]
      L4 = #L4
      if 0 < L4 then
        L4 = require
        L4 = L4(L5)
        for L8, L9 in L5, L6, L7 do
          L10 = #L3
          L10 = L10 + 1
          L11 = {}
          L3[L10] = L11
          L10 = #L3
          L10 = L3[L10]
          L11 = L9.address
          L10.ip = L11
          L10 = L4.exec
          L11 = "ipcalc.sh 255.255.255.255/"
          L12 = L9.mask
          L13 = " | grep \"NETWORK\" | cut -d '=' -f 2"
          L11 = L11 .. L12 .. L13
          L10 = L10(L11)
          L11 = #L3
          L11 = L3[L11]
          L12 = string
          L12 = L12.trim
          L13 = L10
          L12 = L12(L13)
          L11.mask = L12
        end
      end
    end
  end
  L4 = L1.close
  L4(L5)
  return L3
end
getLanWanIp = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = luci
  L1 = L1.model
  L1 = L1.uci
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get_all
  L4 = "network"
  L5 = A0 or L5
  if not A0 then
    L5 = "wan"
  end
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = {}
    L4 = L2.proto
    if L4 == "3g" then
      L4 = "mobile"
      L5 = L2.mtu
      L3.mtu = L5
    elseif L4 == "static" then
      L5 = L2.ipaddr
      L3.ipaddr = L5
      L5 = L2.netmask
      L3.netmask = L5
      L5 = L2.gateway
      L3.gateway = L5
      L5 = L2.mtu
      L3.mtu = L5
    elseif L4 == "pppoe" then
      L5 = L2.username
      L3.username = L5
      L5 = L2.password
      L3.password = L5
      L5 = L2.peerdns
      L3.peerdns = L5
      L5 = L2.service
      L3.service = L5
      L5 = L2.special
      L3.special = L5
      L5 = L2.mru
      L3.mtu = L5
      L5 = _UPVALUE0_
      L5 = L5.isStrNil
      L6 = L3.mtu
      L5 = L5(L6)
      if L5 then
        L3.mtu = "1480"
      end
    elseif L4 == "dhcp" then
      L5 = L2.peerdns
      L3.peerdns = L5
      L5 = L2.mtu
      L3.mtu = L5
    end
    L5 = L2.dns
    if L5 then
      L5 = type
      L6 = L2.dns
      L5 = L5(L6)
      if L5 == "table" then
        L5 = next
        L6 = L2.dns
        L5 = L5(L6)
        if L5 ~= nil then
          L5 = L2.dns
          L3.dns = L5
      end
      else
        L5 = type
        L6 = L2.dns
        L5 = L5(L6)
        if L5 == "string" then
          L5 = L2.dns
          if L5 ~= "" then
            L5 = luci
            L5 = L5.util
            L5 = L5.split
            L6 = L2.dns
            L7 = " "
            L5 = L5(L6, L7)
            L3.dns = L5
          end
        end
      end
    end
    L3.wanType = L4
    L5 = L2.ifname
    L3.ifname = L5
    return L3
  end
  L3 = nil
  return L3
end
getWanDetails = L3
function L3(A0)
  local L1, L2, L3
  L1 = ubusWanStatus
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  if L1 then
    L3 = L1.ipv4
    L2.ipv4 = L3
    L3 = L1.gw
    L2.gw = L3
    L3 = L1.dns
    L2.dns = L3
  end
  return L2
end
getIpv4Info = L3
function L3(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = L1.macaddr
  L3 = A0
  L2 = L2(L3)
  if L2 and A0 ~= "ff:ff:ff:ff:ff:ff" and A0 ~= "00:00:00:00:00:00" then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
_checkMac = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = string
    L1 = L1.lower
    L2 = string
    L2 = L2.gsub
    L3 = A0
    L4 = "[:-]"
    L5 = ""
    L2, L3, L4, L5 = L2(L3, L4, L5)
    return L1(L2, L3, L4, L5)
  else
    L1 = nil
    return L1
  end
end
_parseMac = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "network"
  L5 = A0 or L5
  if not A0 then
    L5 = "wan"
  end
  L6 = "macaddr"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = string
    L3 = L3.upper
    L4 = L2
    return L3(L4)
  end
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = A0 or L6
  if not A0 then
    L6 = "wan"
  end
  L7 = "ifname"
  L3 = L3(L4, L5, L6, L7)
  if not L3 then
    L4 = nil
    return L4
  end
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = L4.exec
  L6 = "ifconfig "
  L7 = L3
  L6 = L6 .. L7
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = L5
  L6 = L6(L7)
  if not L6 then
    L7 = L5
    L6 = L5.match
    L8 = "HWaddr (%S+)"
    L6 = L6(L7, L8)
    L6 = L6 or L6
    return L6
  end
  L6 = nil
  return L6
end
getWanMac = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "luci.cbi.datatypes"
  L4 = L4(L5)
  L6 = L3
  L5 = L3.get
  L7 = "network"
  L8 = A1 or L8
  if not A1 then
    L8 = "wan"
  end
  L9 = "macaddr"
  L5 = L5(L6, L7, L8, L9)
  L6 = require
  L7 = "xiaoqiang.util.XQPortServiceUtil"
  L6 = L6(L7)
  L7 = nil
  if L5 ~= A0 then
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = A0
    L8 = L8(L9)
    if L8 then
      L8 = getDefaultWanMacAddress
      L8 = L8()
      if L5 ~= L8 and L8 ~= "null" then
        L7 = L8
      end
    else
      L8 = L4.macaddr
      L9 = A0
      L8 = L8(L9)
      if L8 and A0 ~= "ff:ff:ff:ff:ff:ff" and A0 ~= "00:00:00:00:00:00" then
        L7 = A0
      end
    end
    if L7 then
      L9 = L3
      L8 = L3.set
      L10 = "network"
      L11 = A1 or L11
      if not A1 then
        L11 = "wan"
      end
      L12 = "macaddr"
      L13 = L7
      L8(L9, L10, L11, L12, L13)
      L9 = L3
      L8 = L3.commit
      L10 = "network"
      L8(L9, L10)
      L9 = L3
      L8 = L3.get
      L10 = "network"
      L11 = A1 or L11
      if not A1 then
        L11 = "wan"
      end
      L12 = "ifname"
      L8 = L8(L9, L10, L11, L12)
      if L8 then
        L9 = _UPVALUE1_
        L10 = L8
        L9 = L9(L10)
        if L9 then
          L11 = L3
          L10 = L3.set
          L12 = "network"
          L13 = L9
          L14 = "macaddr"
          L15 = L7
          L10(L11, L12, L13, L14, L15)
          L11 = L3
          L10 = L3.save
          L12 = "network"
          L10(L11, L12)
          L11 = L3
          L10 = L3.commit
          L12 = "network"
          L10(L11, L12)
        end
      end
      L9 = L6.psIptvBridgeEnable
      L9 = L9()
      if 1 == L9 then
        L9 = L6.psRestart
        L10 = "iptv"
        L9(L10)
      else
        L9 = wanRestart
        L9()
      end
      L9 = L2.split
      L10 = A1
      L11 = "_"
      L9 = L9(L10, L11)
      L9 = L9[2]
      L10 = "wan6"
      if L9 then
        L11 = "_"
        L12 = L9
        L11 = L11 .. L12
        if L11 then
          goto lbl_112
        end
      end
      L11 = ""
      ::lbl_112::
      L10 = L10 .. L11
      L12 = L3
      L11 = L3.get
      L13 = "ipv6"
      L14 = L10
      L15 = "mode"
      L11 = L11(L12, L13, L14, L15)
      L11 = L11 or L11
      if L11 == "passthrough" then
        L12 = wan6Restart
        L13 = L10
        L12(L13)
      end
      L12 = true
      return L12
    end
  end
  L8 = false
  return L8
end
setWanMac = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = tonumber
  L3 = L1.get
  L4 = "WAN_SPEED"
  L5 = 0
  L3, L4, L5 = L3(L4, L5)
  L2 = L2(L3, L4, L5)
  L3 = L2 or L3
  if not L2 then
    L3 = 0
  end
  return L3
end
getWanSpeed = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQPortServiceUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQPreference"
  L4 = L4(L5)
  L5 = ""
  if nil == L3 then
    if A0 then
      L6 = L4.set
      L7 = "WAN_SPEED"
      L8 = A0
      L6(L7, L8)
      if A0 == 10 then
        L6 = os
        L6 = L6.execute
        L7 = "/usr/bin/longloopd stop > /dev/null 2>&1"
        L6(L7)
      else
        L6 = os
        L6 = L6.execute
        L7 = "/usr/bin/longloopd start > /dev/null 2>&1"
        L6(L7)
      end
      L6 = L2.exec
      L7 = "port_map port service wan"
      L6 = L6(L7)
      L5 = L6
      L6 = os
      L6 = L6.execute
      L7 = "phyhelper mode set "
      L8 = tostring
      L9 = L5
      L8 = L8(L9)
      L9 = " "
      L10 = tostring
      L11 = A0
      L10 = L10(L11)
      L11 = " > /dev/null 2>&1"
      L7 = L7 .. L8 .. L9 .. L10 .. L11
      L6(L7)
      L6 = true
      return L6
    end
    L6 = false
    return L6
  else
    if A0 then
      if A1 then
        L6 = L4.set
        L7 = string
        L7 = L7.upper
        L8 = A1
        L7 = L7(L8)
        L8 = "_SPEED"
        L7 = L7 .. L8
        L8 = A0
        L6(L7, L8)
        L6 = L3.psSetWanLinkMode
        L7 = A1
        L8 = A0
        L6(L7, L8)
      else
        L6 = L4.set
        L7 = "WAN_SPEED"
        L8 = A0
        L6(L7, L8)
        L6 = L3.psSetWanLinkMode
        L7 = "wan"
        L8 = A0
        L6(L7, L8)
      end
      L6 = true
      return L6
    end
    L6 = false
    return L6
  end
end
setWanSpeed = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = 0
  L5 = "1"
  if A0 then
    if A0 == "2.5G" then
      L6 = L2.exec
      L7 = "swconfig dev switch0 port 2 get link | grep 'link:up' | wc -l"
      L6 = L6(L7)
      L5 = L6
    else
      L6 = L2.exec
      L7 = "swconfig dev switch1 port 1 get link | grep 'link:up' | wc -l"
      L6 = L6(L7)
      L5 = L6
    end
    L6 = string
    L6 = L6.gsub
    L7 = L5
    L8 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
    L9 = "%1"
    L6 = L6(L7, L8, L9)
    L5 = L6
    if L5 == "1" then
      L6 = L2.exec
      L7 = "/sbin/ifstatus wan | grep up | awk 'NR==1 {print $2}' | sed -e 's/,//'"
      L6 = L6(L7)
      L7 = string
      L7 = L7.gsub
      L8 = L6
      L9 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
      L10 = "%1"
      L7 = L7(L8, L9, L10)
      L6 = L7
      L7 = L1.log
      L8 = 6
      L9 = "getWanPortStatus status  "
      L10 = L6
      L9 = L9 .. L10
      L7(L8, L9)
      if L6 == "true" then
        L4 = 2
      elseif L6 == "false" then
        L4 = 1
      else
        L4 = 1523
      end
    else
      L4 = 0
    end
  end
  L6 = L1.log
  L7 = 6
  L8 = "getWanPortStatus result  "
  L9 = tostring
  L10 = L4
  L9 = L9(L10)
  L8 = L8 .. L9
  L6(L7, L8)
  return L4
end
getWanPortStatus = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "wan_port_type"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
getWanLanMode = L3
function L3(A0)
  local L1
  if A0 == "2.5G" then
    L1 = "eth1"
    return L1
  else
    L1 = "eth0.2"
    return L1
  end
end
getWanIfname = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = "0"
  if A0 == "2.5G" then
    L3 = L1.exec
    L4 = "swconfig dev switch0 port 2 get link | grep 'link:up' | wc -l"
    L3 = L3(L4)
    L2 = L3
  else
    L3 = L1.exec
    L4 = "swconfig dev switch1 port 1 get link | grep 'link:up' | wc -l"
    L3 = L3(L4)
    L2 = L3
  end
  L3 = string
  L3 = L3.gsub
  L4 = L2
  L5 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
  L6 = "%1"
  L3 = L3(L4, L5, L6)
  L2 = L3
  if L2 == "1" then
    L3 = "YES"
    return L3
  else
    L3 = "NO"
    return L3
  end
end
getIntfLink = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get
  L6 = "xiaoqiang"
  L7 = "common"
  L8 = "wan_port_type"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5, L6, L7 = nil, nil, nil
  L8 = getWanIfname
  L9 = A0
  L8 = L8(L9)
  L9 = getIntfLink
  L9 = L9(L10)
  L5 = L9
  if L5 ~= "YES" then
    L9 = 99
    return L9
  end
  if L4 ~= A0 then
    L9 = setWanLanPort
    L9(L10)
  end
  L9 = L2.execi
  L9 = L9(L10)
  if L9 then
    for L13 in L10, L11, L12 do
      L15 = L13
      L14 = L13.match
      L16 = "^LINK=(%S+)"
      L14 = L14(L15, L16)
      if L14 ~= nil then
        L15 = L13
        L14 = L13.match
        L16 = "^LINK=(%S+)"
        L14 = L14(L15, L16)
        L5 = L14
      else
        L15 = L13
        L14 = L13.match
        L16 = "^PPPOE=(%S+)"
        L14 = L14(L15, L16)
        if L14 ~= nil then
          L15 = L13
          L14 = L13.match
          L16 = "^PPPOE=(%S+)"
          L14 = L14(L15, L16)
          L6 = L14
        else
          L15 = L13
          L14 = L13.match
          L16 = "^DHCP=(%S+)"
          L14 = L14(L15, L16)
          if L14 ~= nil then
            L15 = L13
            L14 = L13.match
            L16 = "^DHCP=(%S+)"
            L14 = L14(L15, L16)
            L7 = L14
          end
        end
      end
    end
  end
  if L6 ~= "YES" and L7 ~= "YES" and L4 ~= A0 then
    L10(L11)
  elseif (L6 == "YES" or L7 == "YES") and L4 ~= A0 then
    L10(L11)
  end
  L13 = A0
  L14 = " pppoe:"
  L15 = L6
  L16 = " link:"
  L17 = L5
  L18 = " dhcp:"
  L19 = L7
  L10(L11, L12)
  if L6 == "YES" then
    return L10
  elseif L7 == "YES" then
    return L10
  elseif L5 ~= "YES" then
    return L10
  else
    return L10
  end
end
getWanLanType = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "xiaoqiang"
  L6 = "common"
  L7 = "wan_port_type"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = L1.log
  L5 = 6
  L6 = "setWanLanPort  "
  L7 = L3
  L8 = "-->"
  L9 = A0
  L6 = L6 .. L7 .. L8 .. L9
  L4(L5, L6)
  if A0 then
    if A0 == "2.5G" and L3 ~= "2.5G" then
      L4 = os
      L4 = L4.execute
      L5 = "/usr/sbin/switch2.5Gwan.sh ToWanCfg > /dev/null 2>&1"
      L4(L5)
    elseif A0 ~= "2.5G" and L3 == "2.5G" then
      L4 = os
      L4 = L4.execute
      L5 = "/usr/sbin/switch2.5Gwan.sh ToLanCfg > /dev/null 2>&1"
      L4(L5)
    end
    L4 = true
    return L4
  end
  L4 = false
  return L4
end
setWanLanPort = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "xiaoqiang"
  L6 = "common"
  L7 = "wan_port_type"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = "1"
  if A0 then
    if A1 ~= "0" then
      L4 = "0"
    end
    if A0 == "2.5G" and L3 ~= "2.5G" then
      L5 = os
      L5 = L5.execute
      L6 = "/usr/sbin/switch2.5Gwan.sh toWan "
      L7 = L4
      L8 = " > /dev/null 2>&1"
      L6 = L6 .. L7 .. L8
      L5(L6)
    elseif A0 ~= "2.5G" and L3 == "2.5G" then
      L5 = os
      L5 = L5.execute
      L6 = "/usr/sbin/switch2.5Gwan.sh toLan "
      L7 = L4
      L8 = " > /dev/null 2>&1"
      L6 = L6 .. L7 .. L8
      L5(L6)
    end
    L5 = true
    return L5
  end
  L5 = false
  return L5
end
setWanLanSwap = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  if A0 == 6 then
    L3 = "wan6_2"
    if L3 then
      goto lbl_13
    end
  end
  L3 = "wan_2"
  ::lbl_13::
  L2.wanSection = L3
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = L2.wanSection
  L7 = "ifname"
  L3 = L3(L4, L5, L6, L7)
  L2.wanIfname = L3
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = L2.wanSection
  L7 = "proto"
  L3 = L3(L4, L5, L6, L7)
  L2.oldWanType = L3
  return L2
end
get_cpeWan = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  if A0 == 6 then
    L4 = "wan6"
    if L4 then
      goto lbl_13
    end
  end
  L4 = "wan"
  ::lbl_13::
  L3.wanSection = L4
  L5 = L2
  L4 = L2.get
  L6 = "network"
  L7 = L3.wanSection
  L8 = "ifname"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3.wanIfname = L4
  L5 = L2
  L4 = L2.get
  L6 = "network"
  L7 = L3.wanSection
  L8 = "proto"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3.oldWanType = L4
  L5 = L2
  L4 = L2.get
  L6 = "network"
  L7 = L3.wanSection
  L8 = "wantype"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3.wantype = L4
  return L3
end
get_routerWan = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = 1
  L5 = tonumber
  L9 = "wan"
  L10 = "instance_id"
  L5 = L5(L6)
  for L9 = L6, L7, L8 do
    L11 = L2
    L10 = L2.get
    L12 = "network"
    L13 = "wan_"
    L14 = tostring
    L15 = L9
    L14 = L14(L15)
    L13 = L13 .. L14
    L14 = "instance_id"
    L10 = L10(L11, L12, L13, L14)
    if not L10 and (L5 == 0 or L5 ~= L9) then
      L11 = L3.log
      L12 = 6
      L13 = "calc_wan_instanceid:  found  idx= "
      L14 = tostring
      L15 = L9
      L14 = L14(L15)
      L13 = L13 .. L14
      L11(L12, L13)
      return L9
    end
  end
  return L6
end
calc_conn_instanceid = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = 0
  L6 = 0
  L7 = {}
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A2
  L8 = L8(L9)
  if not L8 then
    L9 = L4
    L8 = L4.get_all
    L10 = "network"
    L11 = A2
    L8 = L8(L9, L10, L11)
    if L8 then
      L9 = L8.ifname
      L7.wanIfname = L9
      L7.wanSection = A2
      L9 = L8.proto
      L7.oldWanType = L9
      L9 = L8.wantype
      L7.wantype = L9
      return L7
    end
    L9 = nil
    return L9
  end
  L9 = L4
  L8 = L4.foreach
  L10 = "network"
  L11 = "interface"
  function L12(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.sub
    L2 = A0[".name"]
    L3 = 1
    L4 = 4
    L1 = L1(L2, L3, L4)
    if L1 == "wan_" then
      L2 = A0[".name"]
      if L2 ~= "wan_cpe" then
        goto lbl_15
      end
    end
    L2 = A0[".name"]
    ::lbl_15::
    if L2 == "wan" then
      L2 = _UPVALUE0_
      L2 = L2 + 1
      _UPVALUE0_ = L2
    end
  end
  L8(L9, L10, L11, L12)
  L8 = tonumber
  L9 = A3
  L8 = L8(L9)
  if L5 >= L8 then
    L8 = nil
    return L8
  end
  if A0 == 4 then
    L7.oldWanType = A1
    L8 = calc_conn_instanceid
    L9 = A1
    L10 = A3
    L8 = L8(L9, L10)
    L6 = L8
    if L6 < 1 then
      L8 = nil
      return L8
    end
    L8 = "macv_"
    L9 = tostring
    L10 = L6
    L9 = L9(L10)
    L8 = L8 .. L9
    L7.wanIfname = L8
    L8 = "wan_"
    L9 = tostring
    L10 = L6
    L9 = L9(L10)
    L8 = L8 .. L9
    L7.wanSection = L8
    return L7
  else
  end
end
get_routerMultiWan = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = tonumber
  L7 = L4
  L6 = L4.get
  L8 = "misc"
  L9 = "features"
  L10 = "multiwan"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L5 = L5(L6)
  if A1 == "CPE" then
    L6 = get_cpeWan
    L7 = A3
    return L6(L7)
  elseif A1 == "Router" then
    if L5 == 0 then
      L6 = get_routerWan
      L7 = A3
      L8 = A2
      return L6(L7, L8)
    else
      L6 = get_routerMultiWan
      L7 = A3
      L8 = A2
      L9 = A0
      L10 = L5
      return L6(L7, L8, L9, L10)
    end
  end
  L6 = nil
  return L6
end
get_wanDevCfg = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = A0 or L2
  if not A0 then
    L2 = "wan"
  end
  L3 = L1.exec
  L4 = "env -i /sbin/ifdown "
  L5 = L2
  L4 = L4 .. L5
  L3(L4)
end
wanDown = L3
function L3(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "ubus call network reload; sleep 1; /etc/init.d/dnsmasq restart > /dev/null"
    L1(L2)
  end
end
dnsmsqRestart = L3
function L3(A0)
  local L1, L2
  if "0" ~= A0 then
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = ". /lib/functions.sh;. /lib/network/switch.sh; setup_switch"
    L1(L2)
  end
end
vlanRestart = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "ipv6"
  L6 = "globals"
  L7 = "ver"
  L3 = L3(L4, L5, L6, L7)
  L4 = "wan"
  if A1 then
    L5 = "_"
    L6 = A1
    L5 = L5 .. L6
    if L5 then
      goto lbl_20
    end
  end
  L5 = ""
  ::lbl_20::
  L4 = L4 .. L5
  if L3 == "2" then
    L6 = L2
    L5 = L2.get
    L7 = "ipv6"
    L8 = A0
    L9 = "mode"
    L5 = L5(L6, L7, L8, L9)
    L7 = L2
    L6 = L2.get
    L8 = "ipv6"
    L9 = A0
    L10 = "automode"
    L6 = L6(L7, L8, L9, L10)
    if L6 == "1" then
      L7 = _UPVALUE0_
      L7 = L7.forkExec
      L8 = "/usr/sbin/ipv6.sh autocheck "
      L9 = A0
      L10 = " clear_result"
      L8 = L8 .. L9 .. L10
      L7(L8)
      if L5 == "passthrough" then
        L7 = {}
        L7.peerdns = 1
        L7.wanIface = L4
        L7.wan6Iface = A0
        L8 = tonumber
        L9 = A1
        L8 = L8(L9)
        L8 = L8 or L8
        L7.wan6IfaceID = L8
        L9 = L2
        L8 = L2.get
        L10 = "network"
        L11 = L4
        L12 = "ifname"
        L8 = L8(L9, L10, L11, L12)
        L8 = L8 or L8
        L7.wan6Ifame = L8
        L9 = L2
        L8 = L2.get
        L10 = "network"
        L11 = L4
        L12 = "wantype"
        L8 = L8(L9, L10, L11, L12)
        L7.wantype = L8
        L8 = setWan6Cfg
        L9 = "native"
        L10 = L7
        L11 = false
        L12 = false
        L8(L9, L10, L11, L12)
        L8 = setLan6Cfg
        L9 = 0
        L10 = nil
        L8(L9, L10)
      end
    end
  else
    L6 = L2
    L5 = L2.get
    L7 = "ipv6"
    L8 = "settings"
    L9 = "enabled"
    L5 = L5(L6, L7, L8, L9)
    L5 = L5 or L5
    L7 = L2
    L6 = L2.get
    L8 = "ipv6"
    L9 = "settings"
    L10 = "mode"
    L6 = L6(L7, L8, L9, L10)
    L6 = L6 or L6
    if L5 ~= "0" and L6 ~= "off" then
      L7 = os
      L7 = L7.execute
      L8 = "/etc/init.d/ipv6 start_ipv6 "
      L9 = L6
      L10 = " "
      L11 = L6
      L12 = " reconfig > /dev/null 2>&1"
      L8 = L8 .. L9 .. L10 .. L11 .. L12
      L7(L8)
    end
  end
end
wan6Reconf = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "ipv6"
  L5 = "globals"
  L6 = "ver"
  L2 = L2(L3, L4, L5, L6)
  if L2 == "2" then
    L3 = _UPVALUE0_
    L3 = L3.forkExec
    L4 = "/usr/sbin/ipv6.sh reload "
    L5 = A0
    L4 = L4 .. L5
    L3(L4)
  else
    L4 = L1
    L3 = L1.get
    L5 = "ipv6"
    L6 = "settings"
    L7 = "enabled"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    L5 = L1
    L4 = L1.get
    L6 = "ipv6"
    L7 = "settings"
    L8 = "mode"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    if L3 == "0" or L4 == "off" then
      L5 = _UPVALUE0_
      L5 = L5.forkExec
      L6 = "/etc/init.d/ipv6 off"
      L5(L6)
    else
      L5 = _UPVALUE0_
      L5 = L5.forkExec
      L6 = "/etc/init.d/ipv6 start_ipv6 "
      L7 = L4
      L6 = L6 .. L7
      L5(L6)
    end
  end
end
wan6Restart = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = A0 or L3
  if not A0 then
    L3 = "wan"
  end
  L4 = "/sbin/ifup "
  L5 = L3
  L6 = ";"
  L4 = L4 .. L5 .. L6
  if A1 then
    if A2 then
      L5 = "sleep "
      L6 = tostring
      L7 = A2
      L6 = L6(L7)
      L7 = "; "
      L8 = L4
      L4 = L5 .. L6 .. L7 .. L8
    end
    L5 = _UPVALUE0_
    L5 = L5.forkExec
    L6 = L4
    L5(L6)
  else
    L5 = require
    L6 = "luci.util"
    L5 = L5(L6)
    L6 = L5.exec
    L7 = L4
    L6(L7)
  end
end
wanRestart = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQMultiWanPolicy"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.getFeature
  L2 = "0"
  L3 = "system"
  L4 = "multiwan"
  L1 = L1(L2, L3, L4)
  if "1" == L1 then
    L1 = L0.restartService
    L1()
  end
end
multiwanRestart = L3
function L3()
  local L0, L1, L2
  L0 = [[
        /etc/init.d/dnsmasq restart;
        /etc/init.d/miqos restart;
        /etc/init.d/wan_check restart;
    ]]
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = L0
  L1(L2)
  return
end
serviceRestart = L3
function L3(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11
  L6 = require
  L7 = "luci.util"
  L6 = L6(L7)
  L7 = L6.split
  L8 = A0
  L9 = "_"
  L7 = L7(L8, L9)
  L7 = L7[2]
  L8 = "wan6"
  if L7 then
    L9 = "_"
    L10 = L7
    L9 = L9 .. L10
    if L9 then
      goto lbl_18
    end
  end
  L9 = ""
  ::lbl_18::
  L8 = L8 .. L9
  L9 = wan6Reconf
  L10 = L8
  L11 = L7
  L9(L10, L11)
  if A5 then
    L9 = require
    L10 = "xiaoqiang.util.XQPortServiceUtil"
    L9 = L9(L10)
    if nil ~= L9 then
      L10 = L9.wandtEnable
      L11 = "wan"
      L10 = L10(L11)
      if L10 then
        L10 = wan6Restart
        L11 = L8
        L10(L11)
        L10 = _UPVALUE0_
        L10 = L10.forkExec
        L11 = "ubus call network reload"
        L10(L11)
        L10 = L9.wanRedetect
        L10()
        return
      end
    end
  end
  if A2 then
    L9 = wanRestart
    L10 = A0
    L9(L10)
  else
    L9 = dnsmsqRestart
    L10 = A3
    L9(L10)
    if A1 == "pppoe" then
      L9 = getPPPoEStatus
      L10 = A0
      L9 = L9(L10)
      if L9 then
        L10 = L9.status
        if L10 == 4 then
          L10 = pppoeStart
          L11 = A0
          L10(L11)
        end
      end
    end
  end
  L9 = wan6Restart
  L10 = L8
  L9(L10)
  L9 = vlanRestart
  L10 = A4
  L9(L10)
  L9 = multiwanRestart
  L9()
  L9 = serviceRestart
  L9()
end
wanServiceRestart = L3
function L3(A0, A1, A2)
  local L3, L4, L5
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L4 = 1500
  if A1 and A1 == "pppoe" then
    L4 = 1492
  end
  if A2 == "1" then
    L4 = L4 - 4
  end
  if L3 and 576 <= L3 and L3 <= L4 then
    L5 = true
    return L5
  end
  L5 = false
  return L5
end
checkMTU = L3
function L3(A0, A1)
  local L2, L3, L4
  L2 = 1500
  if A0 then
    L3 = tonumber
    L4 = A0
    L3 = L3(L4)
    L2 = L3
  end
  if L2 == 1500 and A1 and "0" ~= A1 then
    L2 = 1496
  end
  return L2
end
calcMtu = L3
function L3(A0, A1, A2)
  local L3, L4, L5
  if A0 == "1" then
    L3 = 0
    return L3
  end
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A1
  L4 = L4(L5)
  if L4 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = A2
    L4 = L4(L5)
    if L4 then
      L4 = 1502
      return L4
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A1
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE0_
    L4 = L4.checkDns
    L5 = A1
    L4 = L4(L5)
    if not L4 then
      L4 = 1537
      return L4
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A2
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE0_
    L4 = L4.checkDns
    L5 = A2
    L4 = L4(L5)
    if not L4 then
      L4 = 1537
      return L4
    end
  end
  L4 = 0
  return L4
end
chkWanDns = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L3 = {}
  L4 = {}
  if A0 then
    L5 = type
    L6 = A0
    L5 = L5(L6)
    if L5 == "string" then
      L5 = {}
      L6 = A0
      L5[1] = L6
      L4 = L5
  end
  elseif A0 then
    L5 = type
    L6 = A0
    L5 = L5(L6)
    if L5 == "table" then
      L4 = A0
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A1
  L5 = L5(L6)
  if not L5 then
    L5 = table
    L5 = L5.insert
    L6 = L3
    L5(L6, L7)
  end
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A2
  L5 = L5(L6)
  if not L5 then
    L5 = table
    L5 = L5.insert
    L6 = L3
    L5(L6, L7)
  end
  L5 = #L3
  L6 = #L4
  if L5 == L6 then
    L5 = #L3
    if L5 == 0 then
      L5 = false
      return L5
    else
      L5 = {}
      L6 = 0
      for L10, L11 in L7, L8, L9 do
        L5[L11] = 1
      end
      for L10, L11 in L7, L8, L9 do
        L12 = L5[L11]
        if L12 == 1 then
          L6 = L6 + 1
        end
      end
      if L6 == L7 then
        return L7
      end
    end
  end
  L5 = true
  return L5
end
chkDnsChg = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = A1
    L3 = L3(L4)
    if not L3 then
      L3 = {}
      L4 = A0
      L5 = A1
      L3[1] = L4
      L3[2] = L5
      L2 = L3
  end
  else
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = A0
    L3 = L3(L4)
    if not L3 then
      L2 = A0
    else
      L3 = _UPVALUE0_
      L3 = L3.isStrNil
      L4 = A1
      L3 = L3(L4)
      if not L3 then
        L2 = A1
      end
    end
  end
  return L2
end
generateDns = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = ""
  L5 = L2.split
  L6 = A0
  L7 = "_"
  L5 = L5(L6, L7)
  L5 = L5[2]
  L6 = "wan6"
  if L5 then
    L7 = "_"
    L8 = L5
    L7 = L7 .. L8
    if L7 then
      goto lbl_24
    end
  end
  L7 = ""
  ::lbl_24::
  L6 = L6 .. L7
  L8 = L3
  L7 = L3.get
  L9 = "network"
  L10 = L6
  L7 = L7(L8, L9, L10)
  if not L7 then
    L8 = nil
    return L8
  end
  L8 = 1
  L9 = L6
  L11 = L3
  L10 = L3.get
  L12 = "ipv6"
  L13 = L6
  L14 = "mode"
  L10 = L10(L11, L12, L13, L14)
  if A1 == "pppoe" and L10 ~= "dhcpv6" then
    L4 = 1
    L8 = "auto"
    L9 = A0
  end
  if L10 == "native" or L10 == "static" or L10 == "relay" or L10 == "pi_relay" then
    L12 = L3
    L11 = L3.set
    L13 = "network"
    L14 = L6
    L15 = "disabled"
    L16 = L4
    L11(L12, L13, L14, L15, L16)
    L12 = L3
    L11 = L3.commit
    L13 = "network"
    L11(L12, L13)
  end
  if L10 == "relay" or L10 == "pi_relay" then
    L12 = L3
    L11 = L3.set
    L13 = "dhcp"
    L14 = L6
    L15 = "interface"
    L16 = L9
    L11(L12, L13, L14, L15, L16)
    L12 = L3
    L11 = L3.commit
    L13 = "dhcp"
    L11(L12, L13)
  end
  return L8
end
setWan4AssocWan6cfg = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get
  L6 = "ipv6"
  L7 = "globals"
  L8 = "ver"
  L4 = L4(L5, L6, L7, L8)
  if L4 == "2" then
    L5 = setWan4AssocWan6cfg
    L6 = A0
    L7 = A1
    L5 = L5(L6, L7)
    if L5 then
      return L5
    end
  end
  L5 = A2 or L5
  if not A2 then
    L5 = "0"
  end
  return L5
end
getIpv6Opt = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.getFeature
  L3 = "0"
  L4 = "system"
  L5 = "cpe"
  L2 = L2(L3, L4, L5)
  if "1" == L2 and A0 == "pppoe" then
    L2 = _UPVALUE0_
    L2 = L2.getFeature
    L3 = "0"
    L4 = "system"
    L5 = "multiwan"
    L2 = L2(L3, L4, L5)
    if "1" == L2 then
      L2 = require
      L3 = "xiaoqiang.module.XQMultiWanPolicy"
      L2 = L2(L3)
      L3 = L2.getEnable
      L3 = L3()
      if L3 ~= 0 then
        L3 = L2.getPolicy
        L3 = L3()
        if L3 == 0 then
          L3 = "1"
          return L3
        end
      end
    end
  end
  return A1
end
getForceDisableIpv6Opt = L3
function L3(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A0
  L7 = L7(L8)
  if not L7 and A0 == 0 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A3
    L7 = L7(L8)
    if L7 then
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = A4
      L7 = L7(L8)
      if L7 then
        L7 = _UPVALUE0_
        L7 = L7.isStrNil
        L8 = A5
        L7 = L7(L8)
        if L7 then
          L7 = _UPVALUE0_
          L7 = L7.isStrNil
          L8 = A6
          L7 = L7(L8)
          if L7 then
            L7 = 1502
            return L7
          end
        end
      end
    end
  end
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
      goto lbl_50
    end
  end
  L7 = 1528
  do return L7 end
  goto lbl_79
  ::lbl_50::
  if A3 then
    L7 = checkMTU
    L8 = A3
    L9 = "pppoe"
    L7 = L7(L8, L9)
    if not L7 then
      L7 = 1590
      return L7
  end
  else
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A4
    L7 = L7(L8)
    if L7 then
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = A5
      L7 = L7(L8)
      if L7 then
        goto lbl_79
      end
    end
    L7 = chkWanDns
    L8 = A0
    L9 = A4
    L10 = A5
    return L7(L8, L9, L10)
  end
  ::lbl_79::
  L7 = 0
  return L7
end
chkWan4PPPoE = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "vlan_service"
  L5 = "Internet"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L4 = L1
  L3 = L1.get_all
  L5 = "network"
  L6 = A0.wanDevCfg
  L6 = L6.wanSection
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  L4 = chkDnsChg
  L5 = L3.dns
  L6 = A0.dns1
  L7 = A0.dns2
  L4 = L4(L5, L6, L7)
  L5 = true
  L6 = L3.proto
  if L6 ~= "pppoe" then
    L6 = true
    if L6 then
      goto lbl_35
    end
  end
  L6 = false
  ::lbl_35::
  L7 = 1480
  L8 = 1500
  L9 = A0.mtu
  if L9 then
    L9 = tonumber
    L10 = A0.mtu
    L9 = L9(L10)
    L7 = L9 or L7
    if not L9 then
      L7 = 1480
    end
  end
  if "1" == L2 and 1496 < L8 then
    L8 = 1496
    if 1492 <= L7 then
      L7 = 1488
    end
  end
  L9 = L3.username
  L10 = A0.username
  if L9 == L10 then
    L9 = L3.password
    L10 = A0.password
    if L9 == L10 then
      L9 = tonumber
      L10 = L3.mru
      L9 = L9(L10)
      if L9 == L7 then
        L9 = L3.service
        L10 = A0.service
        if L9 == L10 then
          L9 = L3.special
          L10 = A0.special
          if L9 ~= L10 then
            L9 = L3.special
            if L9 then
              goto lbl_82
            end
            L9 = A0.special
            if L9 ~= "0" then
              goto lbl_82
            end
          end
          L5 = false
        end
      end
    end
  end
  ::lbl_82::
  L9 = {}
  L9.proto = "pppoe"
  L10 = L3.ifname
  L9.ifname = L10
  L10 = A0.username
  L9.username = L10
  L10 = A0.password
  L9.password = L10
  L10 = generateDns
  L11 = A0.dns1
  L12 = A0.dns2
  L10 = L10(L11, L12)
  L9.dns = L10
  L10 = A0.autoset
  L9.peerdns = L10
  L10 = L3.macaddr
  L9.macaddr = L10
  L10 = A0.service
  L9.service = L10
  L9.mru = L7
  L9.mtu = L8
  L10 = A0.special
  L9.special = L10
  L10 = getIpv6Opt
  L11 = A0.wanDevCfg
  L11 = L11.wanSection
  L12 = "pppoe"
  L13 = L3.ipv6
  L10 = L10(L11, L12, L13)
  L9.ipv6 = L10
  L10 = L3.wantype
  L9.wantype = L10
  L10 = L3.disabled
  L9.disabled = L10
  L10 = getForceDisableIpv6Opt
  L11 = "pppoe"
  L12 = L3.force_disable_ipv6
  L10 = L10(L11, L12)
  L9.force_disable_ipv6 = L10
  L11 = L1
  L10 = L1.delete
  L12 = "network"
  L13 = A0.wanDevCfg
  L13 = L13.wanSection
  L10(L11, L12, L13)
  L11 = L1
  L10 = L1.section
  L12 = "network"
  L13 = "interface"
  L14 = A0.wanDevCfg
  L14 = L14.wanSection
  L15 = L9
  L10(L11, L12, L13, L14, L15)
  L11 = L1
  L10 = L1.commit
  L12 = "network"
  L10(L11, L12)
  L10 = A0.username
  if L10 then
    L10 = A0.password
    if L10 then
      L10 = require
      L11 = "xiaoqiang.util.XQSysUtil"
      L10 = L10(L11)
      L11 = L10.doConfUpload
      L12 = {}
      L13 = A0.username
      L12.pppoe_name = L13
      L13 = A0.password
      L12.pppoe_password = L13
      L11(L12)
    end
  end
  L10 = wanServiceRestart
  L11 = A0.wanDevCfg
  L11 = L11.wanSection
  L12 = "pppoe"
  L13 = L5
  L14 = L4
  L15 = L2
  L16 = L6
  L10(L11, L12, L13, L14, L15, L16)
  L10 = 0
  return L10
end
setWan4PPPoE = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 and A0 == 0 then
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = A1
    L3 = L3(L4)
    if L3 then
      L3 = _UPVALUE0_
      L3 = L3.isStrNil
      L4 = A2
      L3 = L3(L4)
      if L3 then
        L3 = 1502
        return L3
      end
    end
  end
  L3 = chkWanDns
  L4 = A0
  L5 = A1
  L6 = A2
  return L3(L4, L5, L6)
end
chkWan4Dhcp = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "vlan_service"
  L5 = "Internet"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = calcMtu
  L4 = A0.mtu
  L5 = L2
  L3 = L3(L4, L5)
  L5 = L1
  L4 = L1.get_all
  L6 = "network"
  L7 = A0.wanDevCfg
  L7 = L7.wanSection
  L4 = L4(L5, L6, L7)
  L4 = L4 or L4
  L5 = chkDnsChg
  L6 = L4.dns
  L7 = A0.dns1
  L8 = A0.dns2
  L5 = L5(L6, L7, L8)
  L6 = L4.proto
  if L6 ~= "dhcp" then
    L6 = true
    if L6 then
      goto lbl_38
    end
  end
  L6 = false
  ::lbl_38::
  L7 = {}
  L7.proto = "dhcp"
  L8 = L4.ifname
  L7.ifname = L8
  L8 = generateDns
  L9 = A0.dns1
  L10 = A0.dns2
  L8 = L8(L9, L10)
  L7.dns = L8
  L8 = L4.macaddr
  L7.macaddr = L8
  L8 = A0.autoset
  L7.peerdns = L8
  L7.mtu = L3
  L8 = getIpv6Opt
  L9 = A0.wanDevCfg
  L9 = L9.wanSection
  L10 = "dhcp"
  L11 = L4.ipv6
  L8 = L8(L9, L10, L11)
  L7.ipv6 = L8
  L8 = L4.wantype
  L7.wantype = L8
  L8 = L4.disabled
  L7.disabled = L8
  L8 = L4.force_disable_ipv6
  L7.force_disable_ipv6 = L8
  L9 = L1
  L8 = L1.delete
  L10 = "network"
  L11 = A0.wanDevCfg
  L11 = L11.wanSection
  L8(L9, L10, L11)
  L9 = L1
  L8 = L1.section
  L10 = "network"
  L11 = "interface"
  L12 = A0.wanDevCfg
  L12 = L12.wanSection
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L1
  L8 = L1.commit
  L10 = "network"
  L8(L9, L10)
  L8 = wanServiceRestart
  L9 = A0.wanDevCfg
  L9 = L9.wanSection
  L10 = "dhcp"
  L11 = L6
  L12 = L5
  L13 = L2
  L14 = L6
  L8(L9, L10, L11, L12, L13, L14)
  L8 = 0
  return L8
end
setWan4Dhcp = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = require
  L3 = "luci.ip"
  L2 = L2(L3)
  L3 = L2.iptonl
  L4 = A0
  L3 = L3(L4)
  L4 = L2.iptonl
  L5 = "1.0.0.0"
  L4 = L4(L5)
  if L3 >= L4 then
    L4 = L2.iptonl
    L5 = "126.255.255.255"
    L4 = L4(L5)
    if L3 <= L4 then
      goto lbl_40
    end
  end
  L4 = L2.iptonl
  L5 = "128.0.0.0"
  L4 = L4(L5)
  if L3 >= L4 then
    L4 = L2.iptonl
    L5 = "169.254.0.0"
    L4 = L4(L5)
    if L3 < L4 then
      goto lbl_40
    end
  end
  L4 = L2.iptonl
  L5 = "169.254.255.255"
  L4 = L4(L5)
  if L3 > L4 then
    L4 = L2.iptonl
    L5 = "223.255.255.255"
    L4 = L4(L5)
    if L3 <= L4 then
  end
  else
    L4 = 1533
    return L4
  end
  ::lbl_40::
  L4 = _UPVALUE0_
  L4 = L4.isBroadcastOrMulticast
  L5 = A0
  L6 = A1
  L4 = L4(L5, L6)
  if L4 then
    L4 = 1530
    return L4
  end
  L4 = 0
  return L4
end
checkWanIp = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L3 = require
  L4 = "luci.ip"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "bit"
  L5 = L5(L6)
  L6 = L4.split
  L7 = A2
  L8 = "."
  L6 = L6(L7, L8)
  L7 = L4.split
  L8 = A0
  L9 = "."
  L7 = L7(L8, L9)
  L8 = L4.split
  L9 = A1
  L10 = "."
  L8 = L8(L9, L10)
  L9 = 0
  L10 = 0
  L11 = 0
  L12 = 0
  L13 = 0
  L14 = L5.lshift
  L15 = tonumber
  L16 = L7[1]
  L15 = L15(L16)
  L16 = 24
  L14 = L14(L15, L16)
  L9 = L9 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L7[2]
  L15 = L15(L16)
  L16 = 16
  L14 = L14(L15, L16)
  L9 = L9 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L7[3]
  L15 = L15(L16)
  L16 = 8
  L14 = L14(L15, L16)
  L9 = L9 + L14
  L14 = tonumber
  L15 = L7[4]
  L14 = L14(L15)
  L9 = L9 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L8[1]
  L15 = L15(L16)
  L16 = 24
  L14 = L14(L15, L16)
  L10 = L10 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L8[2]
  L15 = L15(L16)
  L16 = 16
  L14 = L14(L15, L16)
  L10 = L10 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L8[3]
  L15 = L15(L16)
  L16 = 8
  L14 = L14(L15, L16)
  L10 = L10 + L14
  L14 = tonumber
  L15 = L8[4]
  L14 = L14(L15)
  L10 = L10 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L6[1]
  L15 = L15(L16)
  L16 = 24
  L14 = L14(L15, L16)
  L11 = L11 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L6[2]
  L15 = L15(L16)
  L16 = 16
  L14 = L14(L15, L16)
  L11 = L11 + L14
  L14 = L5.lshift
  L15 = tonumber
  L16 = L6[3]
  L15 = L15(L16)
  L16 = 8
  L14 = L14(L15, L16)
  L11 = L11 + L14
  L14 = tonumber
  L15 = L6[4]
  L14 = L14(L15)
  L11 = L11 + L14
  L14 = L5.band
  L15 = L9
  L16 = L11
  L14 = L14(L15, L16)
  L12 = L14
  L14 = L5.band
  L15 = L12
  L16 = 4294967295
  L14 = L14(L15, L16)
  L12 = L14
  L14 = L5.band
  L15 = L10
  L16 = L11
  L14 = L14(L15, L16)
  L13 = L14
  L14 = L5.band
  L15 = L13
  L16 = 4294967295
  L14 = L14(L15, L16)
  L13 = L14
  L14 = tonumber
  L15 = L12
  L14 = L14(L15)
  L15 = tonumber
  L16 = L13
  L15 = L15(L16)
  if L14 ~= L15 then
    L14 = 1531
    return L14
  end
  L14 = 0
  return L14
end
checkSubnet = L3
function L3(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L6 = require
  L7 = "luci.cbi.datatypes"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A4
  L7 = L7(L8)
  if L7 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A5
    L7 = L7(L8)
    if L7 then
      L7 = 1502
      return L7
    end
  end
  L7 = L6.ipaddr
  L8 = A1
  L7 = L7(L8)
  if not L7 then
    L7 = 1530
    return L7
  else
    L7 = _UPVALUE0_
    L7 = L7.checkMask
    L8 = A2
    L7 = L7(L8)
    if not L7 then
      L7 = 1531
      return L7
    else
      L7 = L6.ipaddr
      L8 = A3
      L7 = L7(L8)
      if not L7 then
        L7 = 1532
        return L7
      else
        if A0 ~= "0" then
          L7 = require
          L8 = "luci.ip"
          L7 = L7(L8)
          L8 = getLanWanIp
          L9 = "lan"
          L8 = L8(L9)
          L8 = L8[1]
          L9 = L7.iptonl
          L10 = L8.ip
          L9 = L9(L10)
          L10 = L7.iptonl
          L11 = L8.mask
          L10 = L10(L11)
          L11 = L7.iptonl
          L12 = A1
          L11 = L11(L12)
          L12 = L7.iptonl
          L13 = A2
          L12 = L12(L13)
          L13 = bit
          L13 = L13.band
          L14 = L9
          L15 = L10
          L13 = L13(L14, L15)
          L14 = bit
          L14 = L14.band
          L15 = L11
          L16 = L10
          L14 = L14(L15, L16)
          if L13 ~= L14 then
            L13 = bit
            L13 = L13.band
            L14 = L9
            L15 = L12
            L13 = L13(L14, L15)
            L14 = bit
            L14 = L14.band
            L15 = L11
            L16 = L12
            L14 = L14(L15, L16)
            if L13 ~= L14 then
              goto lbl_90
            end
          end
          L13 = 1526
          return L13
        end
        ::lbl_90::
        L7 = checkWanIp
        L8 = A1
        L9 = A2
        L7 = L7(L8, L9)
        if L7 ~= 0 then
          return L7
        end
        L8 = checkWanIp
        L9 = A3
        L10 = A2
        L8 = L8(L9, L10)
        L7 = L8
        if L7 ~= 0 then
          L8 = 1532
          return L8
        end
        L8 = checkSubnet
        L9 = A1
        L10 = A3
        L11 = A2
        L8 = L8(L9, L10, L11)
        L7 = L8
        if L7 ~= 0 then
          return L7
        end
        L8 = chkWanDns
        L9 = 0
        L10 = A4
        L11 = A5
        return L8(L9, L10, L11)
      end
    end
  end
  L7 = 0
  return L7
end
chkWan4StaticIP = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "vlan_service"
  L5 = "Internet"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = true
  L4 = calcMtu
  L5 = A0.mtu
  L6 = L2
  L4 = L4(L5, L6)
  L6 = L1
  L5 = L1.get_all
  L7 = "network"
  L8 = A0.wanDevCfg
  L8 = L8.wanSection
  L5 = L5(L6, L7, L8)
  L5 = L5 or L5
  L6 = chkDnsChg
  L7 = L5.dns
  L8 = A0.dns1
  L9 = A0.dns2
  L6 = L6(L7, L8, L9)
  L7 = L5.proto
  if L7 == "static" then
    L7 = L5.ipaddr
    L8 = A0.ip
    if L7 == L8 then
      L7 = L5.netmask
      L8 = A0.mask
      if L7 == L8 then
        L7 = L5.gateway
        L8 = A0.gw
        if L7 == L8 then
          L7 = L5.mtu
          if L7 == L4 then
            L3 = false
          end
        end
      end
    end
  end
  L7 = {}
  L7.proto = "static"
  L8 = A0.ip
  L7.ipaddr = L8
  L8 = A0.mask
  L7.netmask = L8
  L8 = A0.gw
  L7.gateway = L8
  L8 = generateDns
  L9 = A0.dns1
  L10 = A0.dns2
  L8 = L8(L9, L10)
  L7.dns = L8
  L8 = L5.macaddr
  L7.macaddr = L8
  L8 = L5.ifname
  L7.ifname = L8
  L7.mtu = L4
  L8 = getIpv6Opt
  L9 = A0.wanDevCfg
  L9 = L9.wanSection
  L10 = "static"
  L11 = L5.ipv6
  L8 = L8(L9, L10, L11)
  L7.ipv6 = L8
  L8 = L5.wantype
  L7.wantype = L8
  L8 = L5.disabled
  L7.disabled = L8
  L8 = L5.force_disable_ipv6
  L7.force_disable_ipv6 = L8
  L9 = L1
  L8 = L1.delete
  L10 = "network"
  L11 = A0.wanDevCfg
  L11 = L11.wanSection
  L8(L9, L10, L11)
  L9 = L1
  L8 = L1.section
  L10 = "network"
  L11 = "interface"
  L12 = A0.wanDevCfg
  L12 = L12.wanSection
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L1
  L8 = L1.commit
  L10 = "network"
  L8(L9, L10)
  L8 = wanServiceRestart
  L9 = A0.wanDevCfg
  L9 = L9.wanSection
  L10 = "static"
  L11 = L3
  L12 = L6
  L13 = L2
  L14 = L3
  L8(L9, L10, L11, L12, L13, L14)
  L8 = 0
  return L8
end
setWan4StaticIP = L3
function L3(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L7 = require
  L8 = "luci.model.uci"
  L7 = L7(L8)
  L7 = L7.cursor
  L7 = L7()
  L8 = nil
  L9 = _UPVALUE0_
  L9 = L9._strformat
  L10 = A1
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10._strformat
  L11 = A2
  L10 = L10(L11)
  if A0 == "native" or A0 == "nat" then
    L11 = _UPVALUE0_
    L11 = L11.isStrNil
    L12 = L9
    L11 = L11(L12)
    if L11 then
      L11 = _UPVALUE0_
      L11 = L11.isStrNil
      L12 = L10
      L11 = L11(L12)
      if L11 then
        L11 = string
        L11 = L11.format
        L12 = "sleep 1; /etc/init.d/ipv6 %s"
        L13 = A0
        L11 = L11(L12, L13)
        L8 = L11
    end
    else
      L11 = _UPVALUE0_
      L11 = L11.isStrNil
      L12 = L9
      L11 = L11(L12)
      if not L11 then
        L11 = _UPVALUE0_
        L11 = L11.isStrNil
        L12 = L10
        L11 = L11(L12)
        if L11 then
          L11 = string
          L11 = L11.format
          L12 = "sleep 1; /etc/init.d/ipv6 %s '%s'"
          L13 = A0
          L14 = L9
          L11 = L11(L12, L13, L14)
          L8 = L11
      end
      else
        L11 = _UPVALUE0_
        L11 = L11.isStrNil
        L12 = L9
        L11 = L11(L12)
        if L11 then
          L11 = _UPVALUE0_
          L11 = L11.isStrNil
          L12 = L10
          L11 = L11(L12)
          if not L11 then
            L11 = string
            L11 = L11.format
            L12 = "sleep 1; /etc/init.d/ipv6 %s '%s'"
            L13 = A0
            L14 = L10
            L11 = L11(L12, L13, L14)
            L8 = L11
        end
        else
          L11 = string
          L11 = L11.format
          L12 = "sleep 1; /etc/init.d/ipv6 %s '%s','%s'"
          L13 = A0
          L14 = L9
          L15 = L10
          L11 = L11(L12, L13, L14, L15)
          L8 = L11
        end
      end
    end
  elseif A0 == "static" then
    L11 = _UPVALUE0_
    L11 = L11._strformat
    L12 = A3
    L11 = L11(L12)
    L12 = _UPVALUE0_
    L12 = L12._strformat
    L13 = A4
    L12 = L12(L13)
    L13 = _UPVALUE0_
    L13 = L13._strformat
    L14 = A5
    L13 = L13(L14)
    L14 = _UPVALUE0_
    L14 = L14._strformat
    L15 = A6
    L14 = L14(L15)
    L15 = _UPVALUE0_
    L15 = L15.isStrNil
    L16 = L14
    L15 = L15(L16)
    if L15 then
      L14 = "64"
    end
    L15 = L13
    L16 = "1/"
    L17 = L14
    L13 = L15 .. L16 .. L17
    L15 = _UPVALUE0_
    L15 = L15.isStrNil
    L16 = L9
    L15 = L15(L16)
    if L15 then
      L15 = _UPVALUE0_
      L15 = L15.isStrNil
      L16 = L10
      L15 = L15(L16)
      if L15 then
        L15 = string
        L15 = L15.format
        L16 = "sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s'"
        L17 = L11
        L18 = L12
        L19 = L13
        L20 = L14
        L15 = L15(L16, L17, L18, L19, L20)
        L8 = L15
    end
    else
      L15 = _UPVALUE0_
      L15 = L15.isStrNil
      L16 = L9
      L15 = L15(L16)
      if not L15 then
        L15 = _UPVALUE0_
        L15 = L15.isStrNil
        L16 = L10
        L15 = L15(L16)
        if L15 then
          L15 = string
          L15 = L15.format
          L16 = "sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s'"
          L17 = L11
          L18 = L12
          L19 = L13
          L20 = L14
          L21 = L9
          L15 = L15(L16, L17, L18, L19, L20, L21)
          L8 = L15
      end
      else
        L15 = _UPVALUE0_
        L15 = L15.isStrNil
        L16 = L9
        L15 = L15(L16)
        if L15 then
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L10
          L15 = L15(L16)
          if not L15 then
            L15 = string
            L15 = L15.format
            L16 = "sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s'"
            L17 = L11
            L18 = L12
            L19 = L13
            L20 = L14
            L21 = L10
            L15 = L15(L16, L17, L18, L19, L20, L21)
            L8 = L15
        end
        else
          L15 = string
          L15 = L15.format
          L16 = "sleep 1; /etc/init.d/ipv6 static '%s' '%s' '%s' '%s' '%s','%s'"
          L17 = L11
          L18 = L12
          L19 = L13
          L20 = L14
          L21 = L9
          L22 = L10
          L15 = L15(L16, L17, L18, L19, L20, L21, L22)
          L8 = L15
        end
      end
    end
  elseif A0 == "off" then
    L11 = string
    L11 = L11.format
    L12 = "sleep 1; /etc/init.d/ipv6 off"
    L11 = L11(L12)
    L8 = L11
  end
  L11 = _UPVALUE0_
  L11 = L11.isStrNil
  L12 = L8
  L11 = L11(L12)
  if not L11 then
    L11 = _UPVALUE0_
    L11 = L11.forkExec
    L12 = L8
    L11(L12)
  end
  if A0 ~= "off" then
    L12 = L7
    L11 = L7.set
    L13 = "ipv6"
    L14 = "settings"
    L15 = "ipv6_show"
    L16 = "1"
    L11(L12, L13, L14, L15, L16)
    L12 = L7
    L11 = L7.commit
    L13 = "ipv6"
    L11(L12, L13)
    L12 = L7
    L11 = L7.delete
    L13 = "network"
    L14 = "vpn6"
    L11(L12, L13, L14)
    L12 = L7
    L11 = L7.commit
    L13 = "network"
    L11(L12, L13)
  end
end
setWan6 = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "ipv6"
  L5 = "settings"
  L6 = "firewall"
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.get
  L5 = "ipv6"
  L6 = "settings"
  L7 = "mode"
  L3 = L3(L4, L5, L6, L7)
  if A0 ~= "0" then
    A0 = "1"
  end
  if L2 and L2 == A0 then
    return
  end
  L5 = L1
  L4 = L1.set
  L6 = "ipv6"
  L7 = "settings"
  L8 = "firewall"
  L9 = A0
  L4(L5, L6, L7, L8, L9)
  L5 = L1
  L4 = L1.commit
  L6 = "ipv6"
  L4(L5, L6)
  if L3 == "native" then
    L4 = _UPVALUE0_
    L4 = L4.forkExec
    L5 = "/etc/init.d/ipv6 set_firewall "
    L6 = A0
    L5 = L5 .. L6
    L4(L5)
  end
end
setIpv6Firewall = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "ipv6"
  L4 = "settings"
  L5 = "firewall"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
getIpv6Firewall = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "ipv6"
  L5 = "globals"
  L6 = "firewall"
  L2 = L2(L3, L4, L5, L6)
  if A0 ~= "0" then
    A0 = "1"
  end
  if L2 and L2 == A0 then
    return
  end
  L4 = L1
  L3 = L1.set
  L5 = "ipv6"
  L6 = "globals"
  L7 = "firewall"
  L8 = A0
  L3(L4, L5, L6, L7, L8)
  L4 = L1
  L3 = L1.commit
  L5 = "ipv6"
  L3(L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.forkExec
  L4 = "/usr/sbin/ipv6.sh set_firewall "
  L5 = A0
  L4 = L4 .. L5
  L3(L4)
end
setIpv6FirewallV2 = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "ipv6"
  L4 = "globals"
  L5 = "firewall"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
getIpv6FirewallV2 = L3
function L3(A0)
  local L1, L2, L3, L4
  L1 = {}
  L2 = getIp6Details
  L3 = "status"
  L4 = A0 or L4
  if not A0 then
    L4 = "wan6"
  end
  L2 = L2(L3, L4)
  L1.ipv6_info = L2
  L1.ipv6_show = 1
  return L1
end
getWan6Info = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  if not A0 then
    L1 = "wan6"
    return L1
  end
  L1 = string
  L1 = L1.find
  L2 = A0
  L3 = "_"
  L1 = L1(L2, L3)
  if L1 and 1 < L1 then
    L2 = string
    L2 = L2.sub
    L3 = A0
    L4 = 1
    L5 = L1 - 1
    L2 = L2(L3, L4, L5)
    L3 = string
    L3 = L3.sub
    L4 = A0
    L5 = L1
    L3 = L3(L4, L5)
    L4 = L2
    L5 = "6"
    L6 = L3
    L4 = L4 .. L5 .. L6
    return L4
  end
  L2 = "wan6"
  return L2
end
getWan6Sec = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0[1]
  L3 = L2
  L2 = L2.get_network
  L4 = A1.wanIface
  L2 = L2(L3, L4)
  L4 = L2
  L3 = L2.proto
  L3 = L3(L4)
  L4 = {}
  L4.proto = "dhcpv6"
  L5 = A1.wan6Ifame
  L4.ifname = L5
  L4.reqaddress = "try"
  L4.reqprefix = "auto"
  L5 = A1.wantype
  L4.wantype = L5
  if L3 == "pppoe" then
    L6 = L2
    L5 = L2.set
    L7 = "ipv6"
    L8 = "auto"
    L5(L6, L7, L8)
    L4.disabled = "1"
  end
  L5 = A0[1]
  L6 = L5
  L5 = L5.add_network
  L7 = A1.wan6Iface
  L8 = L4
  L5(L6, L7, L8)
end
setWan6CfgNative = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = L2.get_list
  L7 = "support_modes"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  if L4 == 0 then
    return L4
  end
  for L7, L8 in L4, L5, L6 do
    if A1 == L8 then
      L9 = 0
      return L9
    end
  end
  return L4
end
chkWan6Mode = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = require
  L4 = "luci.cbi.datatypes"
  L3 = L3(L4)
  if not A0 and A0 ~= 0 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = A1
    L4 = L4(L5)
    if not L4 then
      L4 = L3.ip6addr
      L5 = A1
      L4 = L4(L5)
      if L4 then
        L4 = string
        L4 = L4.sub
        L5 = A1
        L6 = -2
        L4 = L4(L5, L6)
        if L4 == "::" then
          goto lbl_28
        end
      end
    end
    L4 = 2602
    do return L4 end
    ::lbl_28::
    L4 = L3.ip6prefix
    L5 = A2
    L4 = L4(L5)
    if not L4 then
      L4 = 2603
      return L4
    end
  end
  L4 = 0
  return L4
end
chkWan6CfgDHCPv6 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0[1]
  L3 = L2
  L2 = L2.get_network
  L4 = "lan"
  L2 = L2(L3, L4)
  L3 = A0[1]
  L4 = L3
  L3 = L3.get_network
  L5 = A1.wanIface
  L3 = L3(L4, L5)
  L4 = {}
  L4.proto = "dhcpv6"
  L5 = A1.wan6Ifame
  L4.ifname = L5
  L4.reqprefix = "auto"
  L4.reqaddress = "try"
  L5 = A1.wantype
  L4.wantype = L5
  L5 = A1.nat6Enabled
  if L5 == 1 then
    L4.reqprefix = "no"
    L5 = A1.ip6prefix
    L4.ip6prefix = L5
  else
    L4.reqprefix = "auto"
  end
  L5 = A0[1]
  L6 = L5
  L5 = L5.add_network
  L7 = A1.wan6Iface
  L8 = L4
  L5(L6, L7, L8)
end
setWan6CfgDHCPv6 = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = A0.wanIface
  L7 = "macaddr"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L4 = string
    L4 = L4.sub
    L5 = L3
    L6 = 0
    L7 = 17
    L4 = L4(L5, L6, L7)
    L3 = L4
  end
  L4 = L2.macaddr
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = string
    L4 = L4.sub
    L5 = L3
    L6 = 0
    L7 = 8
    L4 = L4(L5, L6, L7)
    L5 = math
    L5 = L5.randomseed
    L6 = tonumber
    L7 = tostring
    L8 = os
    L8 = L8.time
    L8, L9, L10, L11, L12, L13 = L8()
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L8 = L7
    L7 = L7.reverse
    L7 = L7(L8)
    L8 = L7
    L7 = L7.sub
    L9 = 1
    L10 = 7
    L7, L8, L9, L10, L11, L12, L13 = L7(L8, L9, L10)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13)
    L6 = L6 or L6
    L5(L6)
    L5 = string
    L5 = L5.format
    L6 = "%02x"
    L7 = math
    L7 = L7.random
    L8 = 0
    L9 = 255
    L7, L8, L9, L10, L11, L12, L13 = L7(L8, L9)
    L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
    L6 = string
    L6 = L6.format
    L7 = "%02x"
    L8 = math
    L8 = L8.random
    L9 = 0
    L10 = 255
    L8, L9, L10, L11, L12, L13 = L8(L9, L10)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13)
    L7 = string
    L7 = L7.format
    L8 = "%02x"
    L9 = math
    L9 = L9.random
    L10 = 0
    L11 = 255
    L9, L10, L11, L12, L13 = L9(L10, L11)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L8 = string
    L8 = L8.format
    L9 = "%s:%s:%s:%s"
    L10 = L4
    L11 = L5
    L12 = L6
    L13 = L7
    return L8(L9, L10, L11, L12, L13)
  end
  L4 = nil
  return L4
end
getRandomMac = L3
function L3(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9
  L6 = require
  L7 = "luci.cbi.datatypes"
  L6 = L6(L7)
  if not A0 and A0 ~= 0 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A1
    L7 = L7(L8)
    if not L7 then
      L7 = L6.ip6addr
      L8 = A1
      L7 = L7(L8)
      if L7 then
        L7 = string
        L7 = L7.sub
        L8 = A1
        L9 = -2
        L7 = L7(L8, L9)
        if L7 == "::" then
          goto lbl_28
        end
      end
    end
    L7 = 2602
    do return L7 end
    ::lbl_28::
    L7 = L6.ip6prefix
    L8 = A2
    L7 = L7(L8)
    if not L7 then
      L7 = 2603
      return L7
    end
  end
  if not A3 and A3 == 0 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A4
    L7 = L7(L8)
    if not L7 then
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = A5
      L7 = L7(L8)
      if not L7 then
        goto lbl_53
      end
    end
    L7 = 1528
    return L7
  end
  ::lbl_53::
  L7 = 0
  return L7
end
chkWan6CfgPPPoEv6 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0[1]
  L3 = L2
  L2 = L2.get_network
  L4 = A1.wanIface
  L2 = L2(L3, L4)
  L3 = {}
  L3.proto = "dhcpv6"
  L4 = A1.wan6Ifame
  L3.ifname = L4
  L3.reqprefix = "auto"
  L3.reqaddress = "try"
  L3.disabled = "1"
  L4 = A1.wantype
  L3.wantype = L4
  L4 = {}
  L4.proto = "pppoe"
  L4.ipv4 = "0"
  L4.ipv6 = "auto"
  L4.mtu = "1500"
  L4.mru = "1480"
  L4.special = "0"
  L5 = A1.wantype
  L4.wantype = L5
  L5 = {}
  L5.type = "macvlan"
  L6 = A1.wan6Ifame
  L5.ifname = L6
  L5.mode = "private"
  L6 = A1.usePPPoEv4
  if L6 == 1 then
    L7 = L2
    L6 = L2.set
    L8 = "ipv6"
    L9 = "auto"
    L6(L7, L8, L9)
    L6 = A1.nat6Enabled
    if L6 == 1 then
      L6 = A1.ip6prefix
      L3.ip6prefix = L6
    end
    L6 = A0[1]
    L7 = L6
    L6 = L6.add_network
    L8 = A1.wan6Iface
    L9 = L3
    L6(L7, L8, L9)
  else
    L6 = A1.nat6Enabled
    if L6 == 1 then
      L6 = A1.ip6prefix
      L4.ip6prefix = L6
    end
    L6 = getRandomMac
    L7 = A1
    L6 = L6(L7)
    L6 = L6 or L6
    L5.macaddr = L6
    L6 = "macv_"
    L7 = A1.wan6Iface
    L6 = L6 .. L7
    L5.name = L6
    L6 = A1.username
    L4.username = L6
    L6 = A1.password
    L4.password = L6
    L6 = L5.name
    L4.ifname = L6
    L6 = A0[1]
    L7 = L6
    L6 = L6.add_device
    L8 = L5.name
    L9 = L5
    L6(L7, L8, L9)
    L6 = A1.wan6IfaceID
    if 0 < L6 then
      L6 = A0[1]
      L7 = L6
      L6 = L6.add_network
      L8 = "wan6ppp_"
      L9 = A1.wan6IfaceID
      L8 = L8 .. L9
      L9 = L4
      L6(L7, L8, L9)
    else
      L6 = A0[1]
      L7 = L6
      L6 = L6.add_network
      L8 = "wan6ppp"
      L9 = L4
      L6(L7, L8, L9)
    end
  end
end
setWan6CfgPPPoEv6 = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7
  L4 = require
  L5 = "luci.cbi.datatypes"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L5 = L4.ip6addr
    L6 = A0
    L5 = L5(L6)
    if L5 then
      goto lbl_17
    end
  end
  L5 = 2600
  do return L5 end
  ::lbl_17::
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A1
  L5 = L5(L6)
  if not L5 then
    L5 = L4.ip6addr
    L6 = A1
    L5 = L5(L6)
    if L5 then
      goto lbl_30
    end
  end
  L5 = 2601
  do return L5 end
  ::lbl_30::
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A2
  L5 = L5(L6)
  if not L5 then
    L5 = L4.ip6addr
    L6 = A2
    L5 = L5(L6)
    if L5 then
      L5 = string
      L5 = L5.sub
      L6 = A2
      L7 = -2
      L5 = L5(L6, L7)
      if L5 == "::" then
        goto lbl_50
      end
    end
  end
  L5 = 2602
  do return L5 end
  ::lbl_50::
  L5 = L4.ip6prefix
  L6 = A3
  L5 = L5(L6)
  if not L5 then
    L5 = 2603
    return L5
  end
  L5 = 0
  return L5
end
chkWan6CfgStatic = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0[1]
  L3 = L2
  L2 = L2.get_network
  L4 = A1.wanIface
  L2 = L2(L3, L4)
  L4 = L2
  L3 = L2.proto
  L3 = L3(L4)
  L4 = {}
  L4.proto = "static"
  L5 = A1.wan6Ifame
  L4.ifname = L5
  L5 = A1.ip6addr
  L4.ip6addr = L5
  L5 = A1.ip6gw
  L4.ip6gw = L5
  L5 = A1.ip6prefix
  L4.ip6prefix = L5
  L5 = A1.wantype
  L4.wantype = L5
  if L3 == "pppoe" then
    L6 = L2
    L5 = L2.set
    L7 = "ipv6"
    L8 = "auto"
    L5(L6, L7, L8)
    L4.disabled = "1"
  end
  L5 = A0[1]
  L6 = L5
  L5 = L5.add_network
  L7 = A1.wan6Iface
  L8 = L4
  L5(L6, L7, L8)
end
setWan6CfgStatic = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = "br-lan"
  L3 = A1.wan6Ifame
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A1.wan6Ifame
  L4 = L4(L5)
  if L4 then
    L2 = ""
  end
  L4 = A1.wan6Ifame
  if L4 == "br-internet" then
    L4 = require
    L5 = "luci.model.uci"
    L4 = L4(L5)
    L4 = L4.cursor
    L4 = L4()
    L6 = L4
    L5 = L4.foreach
    L7 = "port_map"
    L8 = "port"
    function L9(A0)
      local L1, L2
      L1 = A0.service
      if L1 then
        L2 = _UPVALUE0_
        L2 = L2.wanIface
        if L1 == L2 then
          L2 = A0.ifname
          _UPVALUE1_ = L2
          L2 = false
          return L2
        end
      end
    end
    L5(L6, L7, L8, L9)
  end
  L4 = {}
  L4.proto = "dhcpv6"
  L4.passthrough = "1"
  L4.ifname = L2
  L4.pass_ifname = L3
  L5 = A1.wantype
  L4.wantype = L5
  L5 = A0[1]
  L6 = L5
  L5 = L5.add_network
  L7 = A1.wan6Iface
  L8 = L4
  L5(L6, L7, L8)
end
setWan6CfgPassthrough = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = A1.wan6Iface
  L3 = {}
  L4 = "none"
  L3[1] = L4
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = A0[1]
  L6 = L5
  L5 = L5.get_network
  L7 = A1.wanIface
  L5 = L5(L6, L7)
  L7 = L5
  L6 = L5.proto
  L6 = L6(L7)
  L7 = {}
  L7.proto = "dhcpv6"
  L8 = A1.wan6Ifame
  L7.ifname = L8
  L7.reqprefix = "auto"
  L7.reqaddress = "try"
  L8 = A1.wantype
  L7.wantype = L8
  L9 = L4
  L8 = L4.section
  L10 = "dhcp"
  L11 = "dhcp"
  L12 = L2
  L8(L9, L10, L11, L12)
  L9 = L4
  L8 = L4.set
  L10 = "dhcp"
  L11 = L2
  L12 = "master"
  L13 = 1
  L8(L9, L10, L11, L12, L13)
  L9 = L4
  L8 = L4.set
  L10 = "dhcp"
  L11 = L2
  L12 = "ignore"
  L13 = 1
  L8(L9, L10, L11, L12, L13)
  L9 = L4
  L8 = L4.set
  L10 = "dhcp"
  L11 = L2
  L12 = "ra"
  L13 = "relay"
  L8(L9, L10, L11, L12, L13)
  L9 = L4
  L8 = L4.set
  L10 = "dhcp"
  L11 = L2
  L12 = "dhcpv6"
  L13 = "relay"
  L8(L9, L10, L11, L12, L13)
  L9 = L4
  L8 = L4.set
  L10 = "dhcp"
  L11 = L2
  L12 = "ndp"
  L13 = "relay"
  L8(L9, L10, L11, L12, L13)
  L9 = L4
  L8 = L4.set_list
  L10 = "dhcp"
  L11 = L2
  L12 = "ra_flags"
  L13 = L3
  L8(L9, L10, L11, L12, L13)
  if L6 == "pppoe" then
    L9 = L4
    L8 = L4.set
    L10 = "dhcp"
    L11 = L2
    L12 = "interface"
    L13 = A1.wanIface
    L8(L9, L10, L11, L12, L13)
    L9 = L5
    L8 = L5.set
    L10 = "ipv6"
    L11 = "auto"
    L8(L9, L10, L11)
    L7.disabled = "1"
  else
    L9 = L4
    L8 = L4.set
    L10 = "dhcp"
    L11 = L2
    L12 = "interface"
    L13 = A1.wan6Iface
    L8(L9, L10, L11, L12, L13)
  end
  L9 = L4
  L8 = L4.commit
  L10 = "dhcp"
  L8(L9, L10)
  L8 = A0[1]
  L9 = L8
  L8 = L8.add_network
  L10 = A1.wan6Iface
  L11 = L7
  L8(L9, L10, L11)
end
setWan6CfgRelay = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = A1.wan6Iface
  L3 = {}
  L4 = "none"
  L3[1] = L4
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = A0[1]
  L6 = L5
  L5 = L5.get_network
  L7 = "lan"
  L5 = L5(L6, L7)
  L6 = A0[1]
  L7 = L6
  L6 = L6.get_network
  L8 = A1.wanIface
  L6 = L6(L7, L8)
  L8 = L6
  L7 = L6.proto
  L7 = L7(L8)
  L8 = {}
  L8.proto = "dhcpv6"
  L9 = A1.wan6Ifame
  L8.ifname = L9
  L8.reqprefix = "auto"
  L8.reqaddress = "try"
  L9 = A1.wantype
  L8.wantype = L9
  L10 = L4
  L9 = L4.section
  L11 = "dhcp"
  L12 = "dhcp"
  L13 = L2
  L9(L10, L11, L12, L13)
  L10 = L4
  L9 = L4.set
  L11 = "dhcp"
  L12 = L2
  L13 = "master"
  L14 = 1
  L9(L10, L11, L12, L13, L14)
  L10 = L4
  L9 = L4.set
  L11 = "dhcp"
  L12 = L2
  L13 = "ignore"
  L14 = 1
  L9(L10, L11, L12, L13, L14)
  L10 = L4
  L9 = L4.set
  L11 = "dhcp"
  L12 = L2
  L13 = "ndp"
  L14 = "relay"
  L9(L10, L11, L12, L13, L14)
  L10 = L4
  L9 = L4.set_list
  L11 = "dhcp"
  L12 = L2
  L13 = "ra_flags"
  L14 = L3
  L9(L10, L11, L12, L13, L14)
  if L7 == "pppoe" then
    L10 = L4
    L9 = L4.set
    L11 = "dhcp"
    L12 = L2
    L13 = "interface"
    L14 = A1.wanIface
    L9(L10, L11, L12, L13, L14)
    L10 = L6
    L9 = L6.set
    L11 = "ipv6"
    L12 = "auto"
    L9(L10, L11, L12)
    L8.disabled = "1"
  else
    L10 = L4
    L9 = L4.set
    L11 = "dhcp"
    L12 = L2
    L13 = "interface"
    L14 = A1.wan6Iface
    L9(L10, L11, L12, L13, L14)
  end
  L10 = L5
  L9 = L5.set
  L11 = "ip6ifaceid"
  L12 = "eui64"
  L9(L10, L11, L12)
  L10 = L4
  L9 = L4.commit
  L11 = "dhcp"
  L9(L10, L11)
  L9 = A0[1]
  L10 = L9
  L9 = L9.add_network
  L11 = A1.wan6Iface
  L12 = L8
  L9(L10, L11, L12)
end
setWan6CfgPIRelay = L3
function L3(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10
  L7 = require
  L8 = "luci.cbi.datatypes"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A0
  L8 = L8(L9)
  if not L8 then
    L8 = L7.ip4addr
    L9 = A0
    L8 = L8(L9)
    if L8 then
      goto lbl_17
    end
  end
  L8 = 2605
  do return L8 end
  ::lbl_17::
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A1
  L8 = L8(L9)
  if not L8 then
    L8 = L7.ip6addr
    L9 = A1
    L8 = L8(L9)
    if L8 then
      goto lbl_30
    end
  end
  L8 = 2600
  do return L8 end
  ::lbl_30::
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A2
  L8 = L8(L9)
  if not L8 then
    L8 = L7.ip6addr
    L9 = A2
    L8 = L8(L9)
    if L8 then
      L8 = string
      L8 = L8.sub
      L9 = A2
      L10 = -2
      L8 = L8(L9, L10)
      if L8 == "::" then
        goto lbl_50
      end
    end
  end
  L8 = 2602
  do return L8 end
  ::lbl_50::
  L8 = L7.ip6prefix
  L9 = A3
  L8 = L8(L9)
  if not L8 then
    L8 = 2603
    return L8
  end
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = A4
  L8 = L8(L9)
  if not L8 then
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = A5
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE0_
      L8 = L8.isStrNil
      L9 = A6
      L8 = L8(L9)
      if not L8 then
        goto lbl_77
      end
    end
    L8 = 1528
    return L8
  end
  ::lbl_77::
  L8 = 0
  return L8
end
chkWan6Cfg6in4 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = {}
  L2.proto = "6in4"
  L3 = A1.wanIface
  L2.tunlink = L3
  L3 = A1.peeraddr
  L2.peeraddr = L3
  L3 = A1.ip6addr
  L2.ip6addr = L3
  L3 = A1.ip6prefix
  L2.ip6prefix = L3
  L3 = A1.tunnelid
  L2.tunnelid = L3
  L3 = A1.username
  L2.username = L3
  L3 = A1.password
  L2.password = L3
  L3 = A0[1]
  L4 = L3
  L3 = L3.add_network
  L5 = A1.wan6Iface
  L6 = L2
  L3(L4, L5, L6)
end
setWan6Cfg6in4 = L3
function L3(A0)
  local L1, L2, L3
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = L1.ip4addr
    L3 = A0
    L2 = L2(L3)
    if L2 then
      goto lbl_17
    end
  end
  L2 = 2605
  do return L2 end
  ::lbl_17::
  L2 = 0
  return L2
end
chkWan6Cfg6to4 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = {}
  L2.proto = "6to4"
  L3 = A1.peeraddr
  L2.peeraddr = L3
  L3 = A0[1]
  L4 = L3
  L3 = L3.add_network
  L5 = A1.wan6Iface
  L6 = L2
  L3(L4, L5, L6)
end
setWan6Cfg6to4 = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7
  L4 = require
  L5 = "luci.cbi.datatypes"
  L4 = L4(L5)
  if not A0 and A0 == 0 then
    L5 = _UPVALUE0_
    L5 = L5.isStrNil
    L6 = A1
    L5 = L5(L6)
    if not L5 then
      L5 = L4.ip4addr
      L6 = A1
      L5 = L5(L6)
      if L5 then
        goto lbl_21
      end
    end
    L5 = 2605
    do return L5 end
    ::lbl_21::
    L5 = _UPVALUE0_
    L5 = L5.isStrNil
    L6 = A2
    L5 = L5(L6)
    if not L5 then
      L5 = L4.ip6addr
      L6 = A2
      L5 = L5(L6)
      if L5 then
        L5 = string
        L5 = L5.sub
        L6 = A2
        L7 = -2
        L5 = L5(L6, L7)
        if L5 == "::" then
          goto lbl_41
        end
      end
    end
    L5 = 2602
    do return L5 end
    ::lbl_41::
    L5 = L4.ip6prefix
    L6 = A3
    L5 = L5(L6)
    if not L5 then
      L5 = 2603
      return L5
    end
  end
  L5 = 0
  return L5
end
chkWan6Cfg6rd = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0[1]
  L3 = L2
  L2 = L2.get_network
  L4 = A1.wanIface
  L2 = L2(L3, L4)
  L3 = {}
  L3.proto = "6rd"
  L4 = A1.useDHCP
  if L4 == 1 then
    L5 = L2
    L4 = L2.set
    L6 = "iface6rd"
    L7 = A1.wan6Iface
    L4(L5, L6, L7)
    L3.disabled = 1
  else
    L4 = A1.peeraddr
    L3.peeraddr = L4
    L4 = A1.ip6prefix
    L3.ip6prefix = L4
    L4 = A1.ip6prefixlen
    L3.ip6prefixlen = L4
    L3.ip4prefixlen = 16
  end
  L4 = A0[1]
  L5 = L4
  L4 = L4.add_network
  L6 = A1.wan6Iface
  L7 = L3
  L4(L5, L6, L7)
end
setWan6Cfg6rd = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = L2.ip6addr
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = string
      L3 = L3.sub
      L4 = A0
      L5 = -2
      L3 = L3(L4, L5)
      if L3 == "::" then
        goto lbl_24
      end
    end
  end
  L3 = 2602
  do return L3 end
  ::lbl_24::
  L3 = L2.ip6prefix
  L4 = A1
  L3 = L3(L4)
  if not L3 then
    L3 = 2603
    return L3
  end
  L3 = 0
  return L3
end
chkWan6Cfg464xlat = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = "clat"
  L4 = A1[1]
  L5 = L4
  L4 = L4.get_zone
  L6 = "wan"
  L4 = L4(L5, L6)
  L5 = A2.wan6IfaceID
  if 0 < L5 then
    L5 = L3
    L6 = "_"
    L7 = A2.wan6IfaceID
    L3 = L5 .. L6 .. L7
  end
  L5 = {}
  L5.proto = "dhcpv6"
  L6 = A2.wan6Ifame
  L5.ifname = L6
  L5.reqprefix = "auto"
  L5.reqaddress = "try"
  L6 = A2.wantype
  L5.wantype = L6
  L6 = {}
  L6.proto = "464xlat"
  L7 = A2.ip6prefix
  L6.ip6prefix = L7
  L7 = A2.wan6Iface
  L6.tunlink = L7
  L8 = L4
  L7 = L4.get
  L7 = L7(L8, L9)
  L8 = false
  for L12, L13 in L9, L10, L11 do
    if L13 == L3 then
      L8 = true
      break
    end
  end
  if not L8 then
    L9(L10, L11)
    L12 = L7
    L9(L10, L11, L12)
  end
  L12 = L6
  L9(L10, L11, L12)
  L12 = L5
  L9(L10, L11, L12)
end
setWan6Cfg464xlat = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L4 = "wan"
  L5 = "clat"
  L6 = A1.wan6Iface
  L7 = "wan6ppp"
  L8 = "macv_"
  L9 = A1.wan6Iface
  L8 = L8 .. L9
  L9 = require
  L10 = "luci.model.uci"
  L9 = L9(L10)
  L9 = L9.cursor
  L9 = L9()
  L10 = {}
  L11 = require
  L12 = "luci.model.network"
  L11 = L11(L12)
  L11 = L11.init
  L11, L12, L13, L14, L15, L16, L17, L21, L22, L23, L24, L25, L26 = L11()
  L10[1] = L11
  L10[2] = L12
  L10[3] = L13
  L10[4] = L14
  L10[5] = L15
  L10[6] = L16
  L10[7] = L17
  L10[8] = L18
  L10[9] = L19
  L10[10] = L20
  L10[11] = L21
  L10[12] = L22
  L10[13] = L23
  L10[14] = L24
  L10[15] = L25
  L10[16] = L26
  L11 = {}
  L12 = require
  L13 = "luci.model.firewall"
  L12 = L12(L13)
  L12 = L12.init
  L12, L13, L14, L15, L16, L17, L21, L22, L23, L24, L25, L26 = L12()
  L11[1] = L12
  L11[2] = L13
  L11[3] = L14
  L11[4] = L15
  L11[5] = L16
  L11[6] = L17
  L11[7] = L18
  L11[8] = L19
  L11[9] = L20
  L11[10] = L21
  L11[11] = L22
  L11[12] = L23
  L11[13] = L24
  L11[14] = L25
  L11[15] = L26
  L12 = L10[1]
  L13 = L12
  L12 = L12.get_network
  L14 = "lan"
  L12 = L12(L13, L14)
  L13 = L10[1]
  L14 = L13
  L13 = L13.get_network
  L15 = "wan"
  L13 = L13(L14, L15)
  L15 = L9
  L14 = L9.get
  L16 = "ipv6"
  L17 = A1.wan6Iface
  L14 = L14(L15, L16, L17, L18)
  L16 = L9
  L15 = L9.get
  L17 = "ipv6"
  L15 = L15(L16, L17, L18, L19)
  L16 = A1.wan6IfaceID
  if 0 < L16 then
    L16 = L5
    L17 = "_"
    L5 = L16 .. L17 .. L18
    L16 = L7
    L17 = "_"
    L7 = L16 .. L17 .. L18
  end
  if L15 == "1" then
    L16 = _UPVALUE0_
    L16 = L16.forkExec
    L17 = "/usr/sbin/ipv6.sh autocheck "
    L17 = L17 .. L18 .. L19
    L16(L17)
  end
  L16 = os
  L16 = L16.execute
  L17 = "/usr/sbin/ipv6.sh macvlan deinit"
  L16(L17)
  L17 = L9
  L16 = L9.delete
  L16(L17, L18, L19)
  L17 = L9
  L16 = L9.delete
  L16(L17, L18, L19, L20)
  L17 = L9
  L16 = L9.delete
  L16(L17, L18, L19, L20)
  L17 = L9
  L16 = L9.delete
  L16(L17, L18, L19, L20)
  L17 = L9
  L16 = L9.commit
  L16(L17, L18)
  L17 = L9
  L16 = L9.commit
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.del_device
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.del_network
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.del_network
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.del_network
  L16(L17, L18)
  L17 = L12
  L16 = L12.set
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L16(L17, L18, L19)
  L17 = L13
  L16 = L13.set
  L16(L17, L18, L19)
  L17 = L13
  L16 = L13.set
  L16(L17, L18, L19)
  if A0 == "native" then
    L16 = setWan6CfgNative
    L17 = L10
    L16(L17, L18)
  elseif A0 == "dhcpv6" then
    L17 = L9
    L16 = L9.set
    L21 = A1.nat6Enabled
    L16(L17, L18, L19, L20, L21)
    L16 = setWan6CfgDHCPv6
    L17 = L10
    L16(L17, L18)
  elseif A0 == "pppoev6" then
    L17 = L9
    L16 = L9.set
    L21 = A1.nat6Enabled
    L16(L17, L18, L19, L20, L21)
    L17 = L9
    L16 = L9.set
    L21 = A1.usePPPoEv4
    L16(L17, L18, L19, L20, L21)
    L16 = setWan6CfgPPPoEv6
    L17 = L10
    L16(L17, L18)
    L16 = A1.usePPPoEv4
    if L16 == 0 then
      L6 = L7
    end
  elseif A0 == "static" then
    L16 = setWan6CfgStatic
    L17 = L10
    L16(L17, L18)
  elseif A0 == "passthrough" then
    L16 = setWan6CfgPassthrough
    L17 = L10
    L16(L17, L18)
  elseif A0 == "relay" then
    L16 = setWan6CfgRelay
    L17 = L10
    L16(L17, L18)
  elseif A0 == "pi_relay" then
    L16 = setWan6CfgPIRelay
    L17 = L10
    L16(L17, L18)
  elseif A0 == "6in4" then
    L16 = setWan6Cfg6in4
    L17 = L10
    L16(L17, L18)
  elseif A0 == "6to4" then
    L16 = setWan6Cfg6to4
    L17 = L10
    L16(L17, L18)
  elseif A0 == "6rd" then
    L17 = L9
    L16 = L9.set
    L21 = A1.useDHCP
    L16(L17, L18, L19, L20, L21)
    L16 = setWan6Cfg6rd
    L17 = L10
    L16(L17, L18)
  elseif A0 == "464xlat" then
    L16 = setWan6Cfg464xlat
    L17 = L10
    L16(L17, L18, L19)
  elseif A0 == "off" then
  else
    L16 = false
    return L16
  end
  if A0 ~= "off" then
    L16 = L10[1]
    L17 = L16
    L16 = L16.get_network
    L16 = L16(L17, L18)
    if L16 then
      L17 = A1.peerdns
      if L17 == 1 then
        L17 = L16.set
        L17(L18, L19, L20)
      else
        L17 = L16.set
        L17(L18, L19, L20)
        L17 = L16.set
        L17(L18, L19, L20)
      end
    end
  end
  if A0 ~= "off" then
    L16 = L10[1]
    L17 = L16
    L16 = L16.del_network
    L16(L17, L18)
  end
  if L14 == "464xlat" and A0 ~= "464xlat" then
    L16 = L11[1]
    L17 = L16
    L16 = L16.get_zone
    L16 = L16(L17, L18)
    L17 = L16.get
    L17 = L17(L18, L19)
    if L17 then
      for L21, L22 in L18, L19, L20 do
        if L22 == L5 then
          L23 = table
          L23 = L23.remove
          L24 = L17
          L25 = L21
          L23(L24, L25)
          L24 = L16
          L23 = L16.set
          L25 = "network"
          L26 = L17
          L23(L24, L25, L26)
          break
        end
      end
    end
  end
  L17 = L9
  L16 = L9.set
  L21 = A0
  L16(L17, L18, L19, L20, L21)
  L16 = A1.autoMode
  if L16 then
    L17 = L9
    L16 = L9.set
    L21 = A1.autoMode
    L16(L17, L18, L19, L20, L21)
  end
  L17 = L9
  L16 = L9.commit
  L16(L17, L18)
  L16 = L11[1]
  L17 = L16
  L16 = L16.save
  L16(L17, L18)
  L16 = L11[1]
  L17 = L16
  L16 = L16.commit
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.save
  L16(L17, L18)
  L16 = L10[1]
  L17 = L16
  L16 = L16.commit
  L16(L17, L18)
  L16 = os
  L16 = L16.execute
  L17 = "/usr/sbin/ipv6.sh macvlan init"
  L16(L17)
  if A2 then
    L16 = _UPVALUE0_
    L16 = L16.forkExec
    L17 = "/usr/sbin/ipv6.sh reload "
    L17 = L17 .. L18
    L16(L17)
  end
  if A0 ~= L14 and A3 then
    L16 = _UPVALUE0_
    L16 = L16.forkExec
    L17 = "sleep 3;/sbin/phyhelper restart lan"
    L16(L17)
  end
  L16 = true
  return L16
end
setWan6Cfg = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = false
  if A0 == 0 then
    L4 = L1
    L3 = L1.foreach
    L5 = "ipv6"
    L6 = "wan"
    function L7(A0)
      local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
      L1 = A0[".name"]
      L2 = A0.mode
      L3 = A0.permession
      if L1 and L2 ~= "off" and L3 ~= "0" then
        L4 = nil
        L5 = {}
        L6 = "wan"
        L7 = L1
        L8 = string
        L8 = L8.find
        L9 = L7
        L10 = "_"
        L8 = L8(L9, L10)
        if L8 and 1 < L8 then
          L9 = string
          L9 = L9.sub
          L10 = L7
          L11 = L8 + 1
          L9 = L9(L10, L11)
          L4 = L9
          L9 = L6
          L10 = "_"
          L11 = L4
          L6 = L9 .. L10 .. L11
        end
        L9 = get_wanDevCfg
        L10 = L6
        L11 = "Router"
        L12 = nil
        L13 = 4
        L9 = L9(L10, L11, L12, L13)
        if L9 then
          L10 = _UPVALUE0_
          L10 = L10.isStrNil
          L11 = L9.wanIfname
          L10 = L10(L11)
          if not L10 then
            L5.autoMode = 0
            L10 = L9.wanIfname
            L5.wan6Ifame = L10
            L5.wan6Iface = L7
            L10 = tonumber
            L11 = L4
            L10 = L10(L11)
            L10 = L10 or L10
            L5.wan6IfaceID = L10
            L10 = setWan6Cfg
            L11 = "off"
            L12 = L5
            L13 = true
            L14 = false
            L10(L11, L12, L13, L14)
            L10 = true
            _UPVALUE1_ = L10
          end
        end
      end
    end
    L3(L4, L5, L6, L7)
  end
  if A0 then
    L4 = L1
    L3 = L1.set
    L5 = "ipv6"
    L6 = "globals"
    L7 = "enabled"
    L8 = A0
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "ipv6"
    L3(L4, L5)
  end
  if L2 then
    L3 = _UPVALUE0_
    L3 = L3.forkExec
    L4 = "sleep 3;/sbin/phyhelper restart lan"
    L3(L4)
  end
end
setWan6Switch = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = tonumber
  L3 = L0
  L2 = L0.get
  L4 = "ipv6"
  L5 = "globals"
  L6 = "enabled"
  L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
  return L1(L2, L3, L4, L5, L6)
end
getWan6Switch = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = tonumber
  L5 = L1
  L4 = L1.get
  L6 = "ipv6"
  L7 = A0
  L8 = "nat6_enabled"
  L4, L5, L6, L7, L8, L9 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L3 = L3 or L3
  L2.nat6_enabled = L3
  if L3 == 1 then
    L4 = luci
    L4 = L4.util
    L4 = L4.split
    L6 = L1
    L5 = L1.get
    L7 = "network"
    L8 = A0
    L9 = "ip6prefix"
    L5 = L5(L6, L7, L8, L9)
    L6 = "/"
    L4 = L4(L5, L6)
    if L4 then
      L5 = L4[1]
      if L5 then
        L5 = L4[1]
        L2.ip6prefix = L5
      end
      L5 = L4[2]
      if L5 then
        L5 = L4[2]
        L2.ip6prefixlen = L5
      end
    end
  end
  return L2
end
getWan6CfgDHCPv6 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L4 = A0
  L5 = tonumber
  L7 = L2
  L6 = L2.get
  L8 = "ipv6"
  L9 = A0
  L10 = "use_pppoev4"
  L6, L7, L8, L9, L10, L11, L12 = L6(L7, L8, L9, L10)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12)
  L5 = L5 or L5
  L6 = tonumber
  L8 = L2
  L7 = L2.get
  L9 = "ipv6"
  L10 = A0
  L11 = "nat6_enabled"
  L7, L8, L9, L10, L11, L12 = L7(L8, L9, L10, L11)
  L6 = L6(L7, L8, L9, L10, L11, L12)
  L6 = L6 or L6
  L3.use_pppoev4 = L5
  L3.nat6_enabled = L6
  if L5 == 0 then
    L4 = A1
    L8 = L2
    L7 = L2.get
    L9 = "network"
    L10 = A1
    L11 = "username"
    L7 = L7(L8, L9, L10, L11)
    L3.username = L7
    L8 = L2
    L7 = L2.get
    L9 = "network"
    L10 = A1
    L11 = "password"
    L7 = L7(L8, L9, L10, L11)
    L3.password = L7
  end
  if L6 == 1 then
    L7 = luci
    L7 = L7.util
    L7 = L7.split
    L9 = L2
    L8 = L2.get
    L10 = "network"
    L11 = L4
    L12 = "ip6prefix"
    L8 = L8(L9, L10, L11, L12)
    L9 = "/"
    L7 = L7(L8, L9)
    if L7 then
      L8 = L7[1]
      if L8 then
        L8 = L7[1]
        L3.ip6prefix = L8
      end
      L8 = L7[2]
      if L8 then
        L8 = L7[2]
        L3.ip6prefixlen = L8
      end
    end
  end
  return L3
end
getWan6CfgPPPoEv6 = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = luci
  L3 = L3.util
  L3 = L3.split
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6prefix"
  L4 = L4(L5, L6, L7, L8)
  L5 = "/"
  L3 = L3(L4, L5)
  if L3 then
    L4 = L3[1]
    if L4 then
      L4 = L3[1]
      L2.ip6prefix = L4
    end
    L4 = L3[2]
    if L4 then
      L4 = L3[2]
      L2.ip6prefixlen = L4
    end
  end
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6addr"
  L4 = L4(L5, L6, L7, L8)
  L2.ip6addr = L4
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6gw"
  L4 = L4(L5, L6, L7, L8)
  L2.ip6gw = L4
  return L2
end
getWan6CfgStatic = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = luci
  L3 = L3.util
  L3 = L3.split
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6prefix"
  L4 = L4(L5, L6, L7, L8)
  L5 = "/"
  L3 = L3(L4, L5)
  if L3 then
    L4 = L3[1]
    if L4 then
      L4 = L3[1]
      L2.ip6prefix = L4
    end
    L4 = L3[2]
    if L4 then
      L4 = L3[2]
      L2.ip6prefixlen = L4
    end
  end
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "peeraddr"
  L4 = L4(L5, L6, L7, L8)
  L2.peeraddr = L4
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6addr"
  L4 = L4(L5, L6, L7, L8)
  L2.ip6addr = L4
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "tunnelid"
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if not L5 then
    L2.tunnelid = L4
    L6 = L1
    L5 = L1.get
    L7 = "network"
    L8 = A0
    L9 = "username"
    L5 = L5(L6, L7, L8, L9)
    L2.username = L5
    L6 = L1
    L5 = L1.get
    L7 = "network"
    L8 = A0
    L9 = "password"
    L5 = L5(L6, L7, L8, L9)
    L2.password = L5
  end
  return L2
end
getWan6Cfg6in4 = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = A0
  L7 = "peeraddr"
  L3 = L3(L4, L5, L6, L7)
  L2.peeraddr = L3
  return L2
end
getWan6Cfg6to4 = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = tonumber
  L5 = L1
  L4 = L1.get
  L6 = "ipv6"
  L7 = A0
  L8 = "use_dhcp"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L2.use_dhcp = L3
  if L3 == 0 then
    L5 = L1
    L4 = L1.get
    L6 = "network"
    L7 = A0
    L8 = "peeraddr"
    L4 = L4(L5, L6, L7, L8)
    L2.peeraddr = L4
    L5 = L1
    L4 = L1.get
    L6 = "network"
    L7 = A0
    L8 = "ip6prefix"
    L4 = L4(L5, L6, L7, L8)
    L2.ip6prefix = L4
    L5 = L1
    L4 = L1.get
    L6 = "network"
    L7 = A0
    L8 = "ip6prefixlen"
    L4 = L4(L5, L6, L7, L8)
    L2.ip6prefixlen = L4
  end
  return L2
end
getWan6Cfg6rd = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = luci
  L3 = L3.util
  L3 = L3.split
  L5 = L1
  L4 = L1.get
  L6 = "network"
  L7 = A0
  L8 = "ip6prefix"
  L4 = L4(L5, L6, L7, L8)
  L5 = "/"
  L3 = L3(L4, L5)
  if L3 then
    L4 = L3[1]
    if L4 then
      L4 = L3[1]
      L2.ip6prefix = L4
    end
    L4 = L3[2]
    if L4 then
      L4 = L3[2]
      L2.ip6prefixlen = L4
    end
  end
  return L2
end
getWan6Cfg464xlat = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = "clat"
  L3 = "wan6ppp"
  L4 = A0
  L5 = {}
  L6 = string
  L6 = L6.find
  L7 = A0
  L8 = "_"
  L6 = L6(L7, L8)
  if L6 and 1 < L6 then
    L7 = string
    L7 = L7.sub
    L8 = A0
    L9 = L6
    L7 = L7(L8, L9)
    L8 = L2
    L9 = L7
    L2 = L8 .. L9
    L8 = L3
    L9 = L7
    L3 = L8 .. L9
  end
  L8 = L1
  L7 = L1.get
  L9 = "ipv6"
  L10 = A0
  L11 = "automode"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L9 = L1
  L8 = L1.get
  L10 = "ipv6"
  L11 = A0
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  if L7 == "1" or L8 == "native" then
    L8 = "native"
  elseif L8 == "dhcpv6" then
    L9 = getWan6CfgDHCPv6
    L10 = A0
    L9 = L9(L10)
    L5 = L9
  elseif L8 == "pppoev6" then
    L9 = getWan6CfgPPPoEv6
    L10 = A0
    L11 = L3
    L9 = L9(L10, L11)
    L5 = L9
    L9 = L5.use_pppoev4
    if L9 == 0 then
      L4 = L3
    end
  elseif L8 == "static" then
    L9 = getWan6CfgStatic
    L10 = A0
    L9 = L9(L10)
    L5 = L9
  elseif L8 == "passthrough" then
  elseif L8 == "6in4" then
    L9 = getWan6Cfg6in4
    L10 = A0
    L9 = L9(L10)
    L5 = L9
  elseif L8 == "6to4" then
    L9 = getWan6Cfg6to4
    L10 = A0
    L9 = L9(L10)
    L5 = L9
  elseif L8 == "6rd" then
    L9 = getWan6Cfg6rd
    L10 = A0
    L9 = L9(L10)
    L5 = L9
  elseif L8 == "relay" then
  elseif L8 == "pi_relay" then
  elseif L8 == "464xlat" then
    L9 = getWan6Cfg464xlat
    L10 = L2
    L9 = L9(L10)
    L5 = L9
  else
    L8 = "off"
  end
  if L8 ~= "off" then
    L9 = tonumber
    L11 = L1
    L10 = L1.get
    L12 = "network"
    L13 = L4
    L14 = "peerdns"
    L10, L11, L12, L13, L14 = L10(L11, L12, L13, L14)
    L9 = L9(L10, L11, L12, L13, L14)
    L9 = L9 or L9
    L5.peerdns = L9
    if L9 == 0 then
      L11 = L1
      L10 = L1.get
      L12 = "network"
      L13 = L4
      L14 = "dns"
      L10 = L10(L11, L12, L13, L14)
      if L10 then
        L5.dns = L10
      end
    end
  end
  L5.ipv6_mode = L8
  return L5
end
getWan6Cfg = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  end
  L1 = {}
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = string
  L3 = L3.format
  L4 = "cat /proc/net/if_inet6 | grep %s | grep -v '\\bfe80' | awk '{print $1,$3}'"
  L3 = L3(L4, L5)
  L4 = L2.execi
  L4 = L4(L5)
  for L8 in L5, L6, L7 do
    L10 = L8
    L9 = L8.match
    L11 = "([^%s]+) ([^%s]+)"
    L9, L10 = L9(L10, L11)
    if L9 then
      L11 = string
      L11 = L11.len
      L11 = L11(L12)
      if L11 == 32 and L10 then
        L11 = tonumber
        L11 = L11(L12)
        L10 = L11
        L11 = ""
        for L15 = L12, L13, L14 do
          if L15 ~= 8 then
            L16 = ":"
            if L16 then
              goto lbl_53
            end
          end
          L16 = ""
          ::lbl_53::
          separator = L16
          L16 = L11
          L17 = string
          L17 = L17.sub
          L18 = L9
          L19 = L15 * 4
          L19 = L19 - 3
          L20 = L15 * 4
          L17 = L17(L18, L19, L20)
          L18 = separator
          L11 = L16 .. L17 .. L18
        end
        for L15 = L12, L13, L14 do
          L16 = "ping6 -w 2 -c 1 -I "
          L17 = A0
          L18 = " "
          L19 = L11
          L20 = " | grep 'PING.*data bytes' | awk -F'[(|)]' '{printf \"%s\",$2}'"
          L3 = L16 .. L17 .. L18 .. L19 .. L20
          L16 = L2.exec
          L17 = L3
          L16 = L16(L17)
          if L16 then
            L17 = table
            L17 = L17.insert
            L18 = L1
            L19 = L16
            L20 = "/"
            L21 = L10
            L19 = L19 .. L20 .. L21
            L17(L18, L19)
            break
          end
        end
      end
    end
  end
  return L1
end
getIPv6AddrsFromProc = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = {}
  L4.up = false
  L6 = L3
  L5 = L3.get
  L7 = "ipv6"
  L8 = A0
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L7 = L3
  L6 = L3.get
  L8 = "ipv6"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L4.ipv6_mode = L5
  if L5 ~= "off" then
    L7 = string
    L7 = L7.format
    L8 = "ubus call network.interface.%s status"
    L7 = L7(L8, L9)
    L8 = L2.exec
    L8 = L8(L9)
    if not L9 then
      L8 = L9
      if L9 then
        for L12 = L9, L10, L11 do
          if L13 ~= "::" then
            L4.ip6gw = L13
            break
          end
        end
        L4.dns = L9
      end
      if L6 == "1" then
        if L10 then
        end
      elseif L10 then
        for L13, L14 in L10, L11, L12 do
          L15 = table
          L15 = L15.insert
          L16 = L9
          L17 = L14.address
          L18 = "/"
          L19 = L14.mask
          L17 = L17 .. L18 .. L19
          L15(L16, L17)
        end
      end
      L4.ip6addr = L9
      if L10 then
        for L15, L16 in L12, L13, L14 do
          L17 = table
          L17 = L17.insert
          L18 = L10
          L19 = L16.address
          L17(L18, L19)
          L17 = getLanIPv6Addrs
          L18 = L16.address
          L17 = L17(L18)
          if L17 then
            L18 = table
            L18 = L18.insert
            L19 = L11
            L20 = L17
            L18(L19, L20)
          end
        end
        L4.lan_ip6addr = L11
        L4.lan_ip6prefix = L10
      end
      L4.ifname = L10
      L4.up = L10
    end
  end
  return L4
end
getWan6InfoV2 = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = {}
  L5 = ""
  L6 = ""
  L7 = "lan"
  L8 = "server"
  L9 = "server"
  L10 = ""
  L11 = A0
  L12 = tonumber
  L14 = L3
  L13 = L3.get
  L15 = "ipv6"
  L16 = "lan6"
  L17 = "mode"
  L13, L14, L15, L16, L17, L18, L19 = L13(L14, L15, L16, L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19)
  L13 = tonumber
  L15 = L3
  L14 = L3.get
  L16 = "network"
  L17 = "lan"
  L18 = "ip6assign"
  L14, L15, L16, L17, L18, L19 = L14(L15, L16, L17, L18)
  L13 = L13(L14, L15, L16, L17, L18, L19)
  L15 = L3
  L14 = L3.foreach
  L16 = "ipv6"
  L17 = "wan"
  function L18(A0)
    local L1, L2
    L1 = A0.mode
    if L1 then
      if L1 == "relay" then
        L2 = 4
        _UPVALUE0_ = L2
      elseif L1 == "pi_relay" then
        L2 = 5
        _UPVALUE0_ = L2
      end
    end
  end
  L14(L15, L16, L17, L18)
  if L12 ~= L11 then
    if L11 == 0 then
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "managed-config"
      L14(L15, L16)
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "other-config"
      L14(L15, L16)
    elseif L11 == 1 then
      L6 = 1
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "managed-config"
      L14(L15, L16)
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "other-config"
      L14(L15, L16)
    elseif L11 == 2 then
      L5 = 0
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "other-config"
      L14(L15, L16)
    elseif L11 == 3 then
      L8 = "disabled"
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "none"
      L14(L15, L16)
    elseif L11 == 4 then
      L9 = "hybrid"
      L10 = "hybrid"
      L8 = "hybrid"
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "managed-config"
      L14(L15, L16)
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "other-config"
      L14(L15, L16)
    elseif L11 == 5 then
      L10 = "hybrid"
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "managed-config"
      L14(L15, L16)
      L14 = table
      L14 = L14.insert
      L15 = L4
      L16 = "other-config"
      L14(L15, L16)
    else
      L14 = false
      return L14
    end
    L15 = L3
    L14 = L3.set
    L16 = "ipv6"
    L17 = "lan6"
    L18 = "mode"
    L19 = L11
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set
    L16 = "dhcp"
    L17 = L7
    L18 = "ra"
    L19 = L9
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set
    L16 = "dhcp"
    L17 = L7
    L18 = "ndp"
    L19 = L10
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set
    L16 = "dhcp"
    L17 = L7
    L18 = "dhcpv6_na"
    L19 = L5
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set
    L16 = "dhcp"
    L17 = L7
    L18 = "dhcpv6"
    L19 = L8
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set
    L16 = "dhcp"
    L17 = L7
    L18 = "ra_no_prefix"
    L19 = L6
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.set_list
    L16 = "dhcp"
    L17 = L7
    L18 = "ra_flags"
    L19 = L4
    L14(L15, L16, L17, L18, L19)
    L15 = L3
    L14 = L3.commit
    L16 = "ipv6"
    L14(L15, L16)
    L15 = L3
    L14 = L3.commit
    L16 = "dhcp"
    L14(L15, L16)
    L14 = L2.forkExec
    L15 = "/etc/init.d/odhcpd restart"
    L14(L15)
  end
  if A1 then
    L14 = A1.ip6assign
    if L14 then
      L14 = A1.ip6assign
      if L14 ~= L13 then
        L15 = L3
        L14 = L3.set
        L16 = "network"
        L17 = "lan"
        L18 = "ip6assign"
        L19 = A1.ip6assign
        L14(L15, L16, L17, L18, L19)
        L15 = L3
        L14 = L3.commit
        L16 = "network"
        L14(L15, L16)
        L14 = L2.forkExec
        L15 = "/usr/sbin/ipv6.sh reload_network all"
        L14(L15)
      end
    end
  end
  L14 = L2.forkExec
  L15 = "sleep 3;/sbin/phyhelper restart lan"
  L14(L15)
  L14 = true
  return L14
end
setLan6Cfg = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.get
  L4 = "ipv6"
  L5 = "lan6"
  L6 = "mode"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.mode = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "network"
  L6 = "lan"
  L7 = "ip6assign"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L1.ip6assign = L2
  return L1
end
getLan6Cfg = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = luci
  L2 = L2.model
  L2 = L2.uci
  L2 = L2.cursor
  L2 = L2()
  L3 = getWan6InfoV2
  L4 = A1
  L3 = L3(L4)
  L4 = L3.ipv6_mode
  L3.wanType = L4
  L4 = L3.wanType
  if "pppoev6" == L4 then
    L5 = L2
    L4 = L2.get
    L6 = "network"
    L7 = "wan6ppp"
    L8 = "peerdns"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L3.peerdns = L4
  else
    L5 = L2
    L4 = L2.get
    L6 = "network"
    L7 = A1
    L8 = "peerdns"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L3.peerdns = L4
  end
  return L3
end
getIp6Details = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = A0 or L2
  if not A0 then
    L2 = "wan6"
  end
  L3 = L1.exec
  L4 = "ubus call network.interface."
  L5 = L2
  L4 = L4 .. L5 .. L6
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L4 = {}
    L5 = require
    L5 = L5(L6)
    L3 = L6
    if L6 then
      for L9 = L6, L7, L8 do
        if L10 ~= "::" then
          L4.ip6gw = L10
          break
        end
      end
      L4.dns = L6
    end
    if L6 then
      for L10, L11 in L7, L8, L9 do
        L12 = table
        L12 = L12.insert
        L13 = L6
        L14 = L11.address
        L15 = "/"
        L16 = L11.mask
        L14 = L14 .. L15 .. L16
        L12(L13, L14)
      end
      L4.ip6addr = L6
    end
    if L6 then
      for L11, L12 in L8, L9, L10 do
        L13 = table
        L13 = L13.insert
        L14 = L6
        L15 = L12.address
        L13(L14, L15)
        L13 = getLanIPv6Addrs
        L14 = L12.address
        L13 = L13(L14)
        if L13 then
          L14 = table
          L14 = L14.insert
          L15 = L7
          L16 = L13
          L14(L15, L16)
        end
      end
      L4.lan_ip6prefix = L6
      L4.lan_ip6addr = L7
    end
    return L4
  end
  L4 = nil
  return L4
end
getIpv6Info = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.ip"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = "ifconfig|grep inet6"
  L3 = L1.execi
  L4 = L2
  L3 = L3(L4)
  L4 = {}
  for L8 in L5, L6, L7 do
    L9 = luci
    L9 = L9.util
    L9 = L9.trim
    L10 = L8
    L9 = L9(L10)
    L8 = L9
    L10 = L8
    L9 = L8.match
    L11 = "inet6 addr: ([^%s]+)/([^%s]+)%s+Scope:([^%s]+)"
    L9, L10, L11 = L9(L10, L11)
    if L9 then
      L12 = L0.IPv6
      L13 = L9
      L14 = "ffff:ffff:ffff:ffff::"
      L12 = L12(L13, L14)
      L9 = L12
      L13 = L9
      L12 = L9.host
      L12 = L12(L13)
      L13 = L12
      L12 = L12.string
      L12 = L12(L13)
      L9 = L12
      L12 = {}
      L4[L9] = L12
      L12 = L4[L9]
      L12.ip = L9
      L12 = L4[L9]
      L12.mask = L10
      L12 = L4[L9]
      L12.type = L11
    end
  end
  return L4
end
getIPv6Addrs = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L1 = L1.connect
  L1 = L1()
  L3 = L1
  L2 = L1.call
  L4 = "network.interface.lan"
  L2 = L2(L3, L4, L5, L6)
  L3 = {}
  if L2 then
    L4 = L2["ipv6-prefix-assignment"]
    if L4 then
      L4 = L2["ipv6-prefix-assignment"]
      L4 = #L4
      if 0 < L4 then
        L4 = L2["ipv6-prefix-assignment"]
        for L8, L9 in L5, L6, L7 do
          L10 = L9.address
          if L10 then
            L10 = L9.address
            if L10 == A0 then
              L10 = L9["local-address"]
              if L10 then
                L11 = L10.address
                if L11 then
                  L11 = L10.mask
                  if L11 then
                    L11 = table
                    L11 = L11.insert
                    L12 = L3
                    L13 = L10.address
                    L14 = "/"
                    L15 = L10.mask
                    L13 = L13 .. L14 .. L15
                    L11(L12, L13)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L4 = L1.close
  L4(L5)
  return L3
end
getLanIPv6Addrs = L3
function L3()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = {}
  L0.ip = L1
  L1 = ubusWanStatus
  L2 = "lan"
  L1 = L1(L2)
  if L1 then
    L2 = L1.up
    if L2 then
      L2 = L0.ip
      L3 = L1.ipv4
      L3 = L3[1]
      L3 = L3.ip
      L2.address = L3
      L2 = L0.ip
      L3 = L1.ipv4
      L3 = L3[1]
      L3 = L3.mask
      L2.mask = L3
      L2 = L1.dns
      L0.dns = L2
      L2 = L1.gw
      L0.gw = L2
      L2 = getPhyhelperWanSpeed
      L3 = "wan"
      L2 = L2(L3)
      L0.wanSpeed = L2
  end
  else
    L2 = L0.ip
    L2.address = ""
    L2 = L0.ip
    L2.mask = ""
    L2 = {}
    L0.dns = L2
    L0.gw = ""
    L0.wanSpeed = ""
  end
  return L0
end
getLanStatus = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L2.ip = ""
  L2.gw = ""
  L2.dns = ""
  L3 = L0.trim
  L4 = L0.exec
  L5 = "uci -q get /tmp/bridge_ipv6.lan.ADDR"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L2.ip = L3
  L3 = L0.trim
  L4 = L0.exec
  L5 = "uci -q get /tmp/bridge_ipv6.lan.GW"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L2.gw = L3
  L3 = L0.trim
  L4 = L0.exec
  L5 = "uci -q get /tmp/bridge_ipv6.lan.DNS"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L2.dns = L3
  return L2
end
getLanV6Status = L3
function L3(A0, A1, A2, A3)
  local L4, L5
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A1
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = A2
    L4 = L4(L5)
    if not L4 then
      L4 = _UPVALUE0_
      L4 = L4.isStrNil
      L5 = A3
      L4 = L4(L5)
      if not L4 then
        goto lbl_21
      end
    end
  end
  L4 = 1502
  do return L4 end
  ::lbl_21::
  L4 = 0
  return L4
end
chkWan4VPN = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "network"
  L4 = "vpn"
  L5 = "disabled"
  L6 = "1"
  L1 = L1(L2, L3, L4, L5, L6)
  L2 = L1 or L2
  L2 = L1 and L1 == "0"
  return L2
end
chkWan4VPNEnable = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.delete
  L4 = "network"
  L5 = "vpn"
  L2(L3, L4, L5)
  L3 = L1
  L2 = L1.commit
  L4 = "network"
  L2(L3, L4)
  L2 = os
  L2 = L2.execute
  L3 = _UPVALUE0_
  L3 = L3.RM_VPNSTATUS_FILE
  L2(L3)
  L2 = _UPVALUE1_
  L2 = L2.forkExec
  L3 = _UPVALUE0_
  L3 = L3.VPN_DISABLE
  L2(L3)
  L2 = os
  L2 = L2.execute
  L3 = _UPVALUE0_
  L3 = L3.SET_VPN_USER_OPTION
  L4 = "0"
  L3 = L3 .. L4
  L2(L3)
  L2 = 0
  return L2
end
stopWan4VPN = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQVPNUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = L1.md5Str
  L5 = A0.vpnServer
  L6 = A0.vpnUsername
  L7 = A0.vpnPassword
  L5 = L5 .. L6 .. L7
  L4 = L4(L5)
  L5 = L2.setVpn
  L6 = "vpn"
  L7 = A0.vpnServer
  L8 = A0.vpnUsername
  L9 = A0.vpnPassword
  L10 = A0.wanType
  L11 = L4
  L12 = "1"
  L13 = "auto"
  L5(L6, L7, L8, L9, L10, L11, L12, L13)
  L6 = L3
  L5 = L3.set
  L7 = "network"
  L8 = "vpn"
  L9 = "disabled"
  L10 = "0"
  L5(L6, L7, L8, L9, L10)
  L5 = os
  L5 = L5.execute
  L6 = _UPVALUE0_
  L6 = L6.RM_VPNSTATUS_FILE
  L5(L6)
  L5 = os
  L5 = L5.execute
  L6 = _UPVALUE0_
  L6 = L6.SET_VPN_USER_OPTION
  L7 = "1"
  L6 = L6 .. L7
  L5(L6)
  L6 = L3
  L5 = L3.commit
  L7 = "network"
  L5(L6, L7)
  L5 = 0
  return L5
end
setWan4VPN = L3
