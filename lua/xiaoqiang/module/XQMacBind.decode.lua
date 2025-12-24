local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = module
L1 = "xiaoqiang.module.XQMacBind"
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
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQDBUtil"
L3 = L3(L4)
L4 = require
L5 = "luci.model.uci"
L4 = L4(L5)
L4 = L4.cursor
L4 = L4()
L5 = require
L6 = "xiaoqiang.module.XQIPMacBind"
L5 = L5(L6)
L6 = require
L7 = "luci.cbi.datatypes"
L6 = L6(L7)
L7 = require
L8 = "xiaoqiang.util.XQWifiUtil"
L7 = L7(L8)
L8 = require
L9 = "xiaoqiang.util.XQPortServiceUtil"
L8 = L8(L9)
L9 = require
L10 = "luci.util"
L9 = L9(L10)
L10 = require
L11 = "cjson"
L10 = L10(L11)
L11 = require
L12 = "xiaoqiang.XQFeatures"
L11 = L11(L12)
L11 = L11.FEATURES
L12 = L11.system
L12 = L12.ipmaccheck
if L12 then
  L12 = L11.system
  L12 = L12.ipmaccheck
  if L12 == "1" then
    L12 = 1
    if L12 then
      goto lbl_57
    end
  end
end
L12 = 0
::lbl_57::
function L13(A0)
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
_checkIP = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6
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
  if L2 then
    L2 = tonumber
    L4 = A0
    L3 = A0.sub
    L5 = 1
    L6 = 2
    L3 = L3(L4, L5, L6)
    L4 = 16
    L2 = L2(L3, L4)
    L3 = L2 % 2
    L3 = L3 == 0
    return L3
  else
    L2 = false
    return L2
  end
end
function L14(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L2 = A0
  L1 = L1(L2)
  if L1 == false then
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
_checkMac = L14
function L14(A0)
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
_parseMac = L14
function L14()
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
_parseDhcpLeases = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  end
  L2 = A0
  L1 = A0.gsub
  L3 = ".%d+$"
  L4 = ""
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.foreach
  L4 = "macbind"
  L5 = "host"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.ip
    L2 = _UPVALUE0_
    L3 = "."
    L5 = L1
    L4 = L1.match
    L6 = ".(%d+)$"
    L4 = L4(L5, L6)
    L1 = L2 .. L3 .. L4
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.set
    L4 = "macbind"
    L5 = A0[".name"]
    L6 = "ip"
    L7 = L1
    L2(L3, L4, L5, L6, L7)
  end
  L2(L3, L4, L5, L6)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.foreach
  L4 = "dhcp"
  L5 = "host"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.ip
    L2 = _UPVALUE0_
    L3 = "."
    L5 = L1
    L4 = L1.match
    L6 = ".(%d+)$"
    L4 = L4(L5, L6)
    L1 = L2 .. L3 .. L4
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.set
    L4 = "dhcp"
    L5 = A0[".name"]
    L6 = "ip"
    L7 = L1
    L2(L3, L4, L5, L6, L7)
  end
  L2(L3, L4, L5, L6)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.commit
  L4 = "dhcp"
  L2(L3, L4)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.commit
  L4 = "macbind"
  L2(L3, L4)
end
hookLanIPChangeEvent = L14
function L14()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.util.XQDBUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQEquipment"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.foreach
  L5 = "dhcp"
  L6 = "host"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = {}
    L1.name = ""
    L2 = A0.mac
    L1.mac = L2
    L2 = A0.ip
    L1.ip = L2
    L1.tag = 2
    L2 = A0.cwmp_LANDHCPStaticAddress_instance
    L1.instance = L2
    L2 = string
    L2 = L2.upper
    L3 = A0.mac
    L2 = L2(L3)
    L3 = ""
    L4 = _UPVALUE0_
    L4 = L4.fetchDeviceInfo
    L5 = L2
    L4 = L4(L5)
    if L4 then
      L5 = L4.oName
      L6 = L4.nickname
      L7 = _UPVALUE1_
      L7 = L7.isStrNil
      L8 = L6
      L7 = L7(L8)
      if not L7 then
        L3 = L6
      else
        L7 = _UPVALUE2_
        L7 = L7.identifyDevice
        L8 = L2
        L9 = L5
        L7 = L7(L8, L9)
        L8 = L7.type
        L9 = _UPVALUE1_
        L9 = L9.isStrNil
        L10 = L3
        L9 = L9(L10)
        if L9 then
          L9 = _UPVALUE1_
          L9 = L9.isStrNil
          L10 = L8.n
          L9 = L9(L10)
          if not L9 then
            L3 = L8.n
          end
        end
        L9 = _UPVALUE1_
        L9 = L9.isStrNil
        L10 = L3
        L9 = L9(L10)
        if L9 then
          L9 = _UPVALUE1_
          L9 = L9.isStrNil
          L10 = L5
          L9 = L9(L10)
          if not L9 then
            L3 = L5
          end
        end
        L9 = _UPVALUE1_
        L9 = L9.isStrNil
        L10 = L3
        L9 = L9(L10)
        if L9 then
          L9 = _UPVALUE1_
          L9 = L9.isStrNil
          L10 = L7.name
          L9 = L9(L10)
          if not L9 then
            L3 = L7.name
          end
        end
        L9 = _UPVALUE1_
        L9 = L9.isStrNil
        L10 = L3
        L9 = L9(L10)
        if L9 then
          L3 = L2
        end
        L9 = L8.c
        if L9 == 3 then
          L9 = _UPVALUE1_
          L9 = L9.isStrNil
          L10 = L6
          L9 = L9(L10)
          if L9 then
            L3 = L8.n
          end
        end
      end
      L1.name = L3
    end
    L5 = _UPVALUE3_
    L6 = A0.mac
    L5[L6] = L1
  end
  L3(L4, L5, L6, L7)
  return L0
end
macBindInfo = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = _checkIP
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = _checkMac
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = _parseMac
      L4 = A0
      L3 = L3(L4)
      L4 = {}
      L4.name = L3
      L4.mac = A0
      L4.ip = A1
      L5 = _UPVALUE0_
      L5 = L5.saveDeviceInfo
      L6 = string
      L6 = L6.upper
      L7 = A0
      L6 = L6(L7)
      L7 = A2
      L8 = A2
      L9 = ""
      L10 = ""
      L5(L6, L7, L8, L9, L10)
      L5 = _UPVALUE1_
      L6 = L5
      L5 = L5.section
      L7 = "macbind"
      L8 = "host"
      L9 = L3
      L10 = L4
      L5(L6, L7, L8, L9, L10)
      L4.name = ""
      L5 = _UPVALUE1_
      L6 = L5
      L5 = L5.section
      L7 = "dhcp"
      L8 = "host"
      L9 = L3
      L10 = L4
      L5(L6, L7, L8, L9, L10)
      L5 = _UPVALUE1_
      L6 = L5
      L5 = L5.commit
      L7 = "macbind"
      L5(L6, L7)
      L5 = _UPVALUE1_
      L6 = L5
      L5 = L5.commit
      L7 = "dhcp"
      L5(L6, L7)
      L5 = true
      return L5
    end
  end
  L3 = false
  return L3
end
changeBindInfo = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  if L1 == 0 then
    L1 = 0
    return L1
  end
  if A0 == nil then
    L1 = 1523
    return L1
  end
  if A0 ~= 0 and A0 ~= 1 then
    L1 = 1523
    return L1
  end
  if A0 == 1 then
    L1 = _UPVALUE1_
    L2 = L1
    L1 = L1.set
    L3 = "firewall"
    L4 = "ipmacBind"
    L5 = "status"
    L6 = "on"
    L1(L2, L3, L4, L5, L6)
  else
    L1 = _UPVALUE1_
    L2 = L1
    L1 = L1.set
    L3 = "firewall"
    L4 = "ipmacBind"
    L5 = "status"
    L6 = "off"
    L1(L2, L3, L4, L5, L6)
  end
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.commit
  L3 = "firewall"
  L1(L2, L3)
  L1 = _UPVALUE2_
  L1 = L1.reloadIPMacBindingList
  L1()
  L1 = 0
  return L1
end
setIPMACCheckEnable = L14
function L14()
  local L0, L1, L2, L3, L4, L5
  L0 = 0
  L1 = _UPVALUE0_
  if L1 == 0 then
    L1 = 0
    return L1
  end
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = "ipmacBind"
  L5 = "status"
  L1 = L1(L2, L3, L4, L5)
  L0 = L1
  if L0 and L0 == "on" then
    L1 = 1
    return L1
  end
  L1 = 0
  return L1
end
getIPMACCheckEnable = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L5 = _checkIP
  L6 = A1
  L5 = L5(L6)
  if L5 then
    L5 = _checkMac
    L6 = A0
    L5 = L5(L6)
    if L5 then
      L5 = _parseDhcpLeases
      L5 = L5()
      L6 = string
      L6 = L6.lower
      L7 = _UPVALUE0_
      L7 = L7.macFormat
      L8 = A0
      L7, L8, L9, L10, L11, L12, L13, L14 = L7(L8)
      L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
      A0 = L6
      L6 = L5[A1]
      if L6 then
        L7 = L6.mac
        if L7 ~= A0 then
          L7 = os
          L7 = L7.execute
          L8 = "arping -f -q -c 2 -w 2 -I br-lan "
          L9 = A1
          L8 = L8 .. L9
          L7 = L7(L8)
          if L7 == 0 then
            L7 = 1
            return L7
          end
        end
      end
      L7 = getMacbindStatus
      L8 = A0
      L7 = L7(L8)
      L3 = L7
      if L3 == true then
        L7 = getMacBindedIPInfo
        L8 = A0
        L7 = L7(L8)
        if L7 == A1 then
          L8 = _UPVALUE1_
          L8 = L8.saveDeviceInfo
          L9 = string
          L9 = L9.upper
          L10 = A0
          L9 = L9(L10)
          L10 = A2
          L11 = A2
          L12 = ""
          L13 = ""
          L8(L9, L10, L11, L12, L13)
          L8 = 0
          return L8
        end
        L8 = _UPVALUE2_
        if L8 then
          L8 = _UPVALUE3_
          L8 = L8.delIPMacBindingEntry
          L9 = A0
          L10 = L7
          L8 = L8(L9, L10)
          if true == L8 then
            L8 = _UPVALUE3_
            L8 = L8.ipMacBindclearOldSession
            L9 = A0
            L10 = L7
            L8 = L8(L9, L10)
            if true == L8 then
              L8 = _UPVALUE3_
              L8 = L8.addIPMacBindEntry
              L9 = A0
              L10 = A1
              L8 = L8(L9, L10)
              if true == L8 then
                L8 = changeBindInfo
                L9 = A0
                L10 = A1
                L11 = A2
                L8(L9, L10, L11)
                L8 = 0
                return L8
            end
          end
          else
            L8 = _UPVALUE3_
            L8 = L8.reloadIPMacBindingList
            L8()
            L8 = 4
            return L8
          end
        end
      else
        L7 = _UPVALUE2_
        if L7 then
          L7 = _UPVALUE3_
          L7 = L7.addIPMacBindEntry
          L8 = A0
          L9 = A1
          L7 = L7(L8, L9)
          if false == L7 then
            L7 = 4
            return L7
          end
        end
      end
      L7 = _parseMac
      L8 = A0
      L7 = L7(L8)
      L8 = {}
      L8.name = L7
      L8.mac = A0
      L8.ip = A1
      L9 = _UPVALUE1_
      L9 = L9.saveDeviceInfo
      L10 = string
      L10 = L10.upper
      L11 = A0
      L10 = L10(L11)
      L11 = A2
      L12 = A2
      L13 = ""
      L14 = ""
      L9(L10, L11, L12, L13, L14)
      L9 = _UPVALUE4_
      L10 = L9
      L9 = L9.section
      L11 = "macbind"
      L12 = "host"
      L13 = L7
      L14 = L8
      L9(L10, L11, L12, L13, L14)
      L8.name = ""
      L9 = _UPVALUE4_
      L10 = L9
      L9 = L9.section
      L11 = "dhcp"
      L12 = "host"
      L13 = L7
      L14 = L8
      L9(L10, L11, L12, L13, L14)
      L9 = _UPVALUE4_
      L10 = L9
      L9 = L9.commit
      L11 = "macbind"
      L9(L10, L11)
      L9 = _UPVALUE4_
      L10 = L9
      L9 = L9.commit
      L11 = "dhcp"
      L9(L10, L11)
  end
  else
    L5 = 2
    return L5
  end
  L5 = 0
  return L5
end
addBind = L14
function L14(A0)
  local L1, L2, L3
  L1 = macBindInfo
  L1 = L1()
  L2 = string
  L2 = L2.lower
  L3 = A0
  L2 = L2(L3)
  L2 = L1[L2]
  if L2 then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
getMacbindStatus = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2 = macBindInfo
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    L8 = string
    L8 = L8.lower
    L9 = L7.mac
    L8 = L8(L9)
    L8 = L2[L8]
    if L8 then
      L9 = {}
      L10 = L8.mac
      L9.mac = L10
      L10 = L8.ip
      L9.ip = L10
      L10 = string
      L10 = L10.lower
      L11 = host
      L11 = L11.mac
      L10 = L10(L11)
      L1[L10] = L9
    end
  end
  return L1
end
getMacBindList = L14
function L14(A0)
  local L1, L2, L3
  L1 = macBindInfo
  L1 = L1()
  L2 = string
  L2 = L2.lower
  L3 = A0
  L2 = L2(L3)
  L2 = L1[L2]
  if L2 then
    L3 = L2.ip
    return L3
  end
  L3 = 0
  return L3
end
getMacBindedIPInfo = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = {}
  L2 = _parseDhcpLeases
  L2 = L2()
  L3, L4, L5, L6, L7, L8, L9, L10 = nil, nil, nil, nil, nil, nil, nil, nil
  if L11 ~= "table" then
    return L11
  end
  for L14, L15 in L11, L12, L13 do
    L16 = string
    L16 = L16.lower
    L17 = _UPVALUE0_
    L17 = L17.macFormat
    L18 = L15.mac
    L17, L18, L19, L20, L21 = L17(L18)
    L16 = L16(L17, L18, L19, L20, L21)
    L3 = L16
    L4 = L15.ip
    L16 = _checkIP
    L17 = L4
    L16 = L16(L17)
    if L16 then
      L16 = _checkMac
      L17 = L3
      L16 = L16(L17)
      if L16 then
        goto lbl_37
      end
    end
    L16 = 2
    do return L16 end
    ::lbl_37::
    L16 = L1[L4]
    if L16 == 1 then
      L16 = 3
      return L16
    end
    L1[L4] = 1
    L7 = L2[L4]
    if L7 then
      L16 = L7.mac
      if L16 ~= L3 then
        L16 = os
        L16 = L16.execute
        L17 = "arping -f -q -c 2 -w 2 -I br-lan "
        L18 = L4
        L17 = L17 .. L18
        L16 = L16(L17)
        if L16 == 0 then
          L16 = 1
          return L16
        end
      end
    end
  end
  for L14, L15 in L11, L12, L13 do
    L16 = string
    L16 = L16.lower
    L17 = _UPVALUE0_
    L17 = L17.macFormat
    L18 = L15.mac
    L17, L18, L19, L20, L21 = L17(L18)
    L16 = L16(L17, L18, L19, L20, L21)
    L3 = L16
    L4 = L15.ip
    L16 = getMacbindStatus
    L17 = L3
    L16 = L16(L17)
    L9 = L16
    L16 = _UPVALUE1_
    if L16 then
      if L9 == true then
        L16 = getMacBindedIPInfo
        L17 = L3
        L16 = L16(L17)
        if L16 ~= L4 then
          L17 = _UPVALUE2_
          L17 = L17.delIPMacBindingEntry
          L18 = L3
          L19 = L16
          L17 = L17(L18, L19)
          if false ~= L17 then
            L17 = _UPVALUE2_
            L17 = L17.addIPMacBindEntry
            L18 = L3
            L19 = L4
            L17 = L17(L18, L19)
          end
          if false == L17 then
            L17 = _UPVALUE2_
            L17 = L17.reloadIPMacBindingList
            L17()
            L17 = 4
            return L17
          end
        end
      else
        L16 = _UPVALUE2_
        L16 = L16.addIPMacBindEntry
        L17 = L3
        L18 = L4
        L16 = L16(L17, L18)
        if false == L16 then
          L16 = _UPVALUE2_
          L16 = L16.reloadIPMacBindingList
          L16()
          L16 = 4
          return L16
        end
      end
    end
  end
  for L14, L15 in L11, L12, L13 do
    L16 = string
    L16 = L16.lower
    L17 = _UPVALUE0_
    L17 = L17.macFormat
    L18 = L15.mac
    L17, L18, L19, L20, L21 = L17(L18)
    L16 = L16(L17, L18, L19, L20, L21)
    L3 = L16
    L4 = L15.ip
    L5 = L15.instance
    L6 = L15.name
    L7 = L2[L4]
    L16 = _parseMac
    L17 = L3
    L16 = L16(L17)
    oname = L16
    L16 = {}
    L17 = oname
    L16.name = L17
    L16.mac = L3
    L16.ip = L4
    L16.cwmp_LANDHCPStaticAddress_instance = L5
    L8 = L16
    L16 = _UPVALUE3_
    L16 = L16.saveDeviceInfo
    L17 = string
    L17 = L17.upper
    L18 = L3
    L17 = L17(L18)
    L18 = L6
    L19 = L6
    L20 = ""
    L21 = ""
    L16(L17, L18, L19, L20, L21)
    L16 = _UPVALUE4_
    L17 = L16
    L16 = L16.section
    L18 = "macbind"
    L19 = "host"
    L20 = oname
    L21 = L8
    L16(L17, L18, L19, L20, L21)
    L8.name = ""
    L16 = _UPVALUE4_
    L17 = L16
    L16 = L16.section
    L18 = "dhcp"
    L19 = "host"
    L20 = oname
    L21 = L8
    L16(L17, L18, L19, L20, L21)
  end
  L11(L12, L13)
  L11(L12, L13)
  return L11
end
addBinds = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L4 = _checkMac
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = false
    return L4
  end
  L4 = _parseMac
  L5 = A0
  L4 = L4(L5)
  L2 = L4
  L4 = getMacBindedIPInfo
  L5 = A0
  L4 = L4(L5)
  L3 = L4
  if L3 ~= 0 then
    L4 = _UPVALUE0_
    if L4 then
      L4 = _UPVALUE1_
      L4 = L4.delIPMacBindingEntry
      L5 = A0
      L6 = L3
      L4 = L4(L5, L6)
      L1 = L4
      if L1 == false then
        L4 = false
        return L4
      end
    end
  end
  L4 = _UPVALUE2_
  L5 = L4
  L4 = L4.delete
  L6 = "dhcp"
  L7 = L2
  L4(L5, L6, L7)
  L4 = _UPVALUE2_
  L5 = L4
  L4 = L4.commit
  L6 = "dhcp"
  L4(L5, L6)
  L4 = true
  return L4
end
removeBind = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if L3 ~= "table" then
    return L3
  end
  for L6, L7 in L3, L4, L5 do
    L8 = _checkMac
    L9 = L7
    L8 = L8(L9)
    if not L8 then
      L8 = false
      return L8
    end
  end
  if L3 then
    L2 = L3
    if L2 == false then
      return L3
    end
  end
  for L6, L7 in L3, L4, L5 do
    L8 = _parseMac
    L9 = L7
    L8 = L8(L9)
    L9 = _UPVALUE2_
    L10 = L9
    L9 = L9.delete
    L11 = "dhcp"
    L12 = L8
    L9(L10, L11, L12)
  end
  L3(L4, L5)
  return L3
end
removeBinds = L14
function L14()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.delete_all
  L2 = "dhcp"
  L3 = "host"
  L0(L1, L2, L3)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "dhcp"
  L0(L1, L2)
  L0 = _UPVALUE1_
  if L0 then
    L0 = _UPVALUE2_
    L0 = L0.flushIPMacBindingList
    L0()
  end
end
unbindAll = L14
function L14()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "killall -s 10 noflushd ; /etc/init.d/dnsmasq restart"
  L0(L1)
end
reload = L14
