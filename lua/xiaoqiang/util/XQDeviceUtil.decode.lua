local L0, L1, L2, L3, L4, L5, L6, L7, L8
L0 = module
L1 = "xiaoqiang.util.XQDeviceUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "cjson"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.XQEquipment"
L3 = L3(L4)
L4 = require
L5 = "luci.cbi.datatypes"
L4 = L4(L5)
function L5(A0)
  local L1, L2, L3, L4
  L1 = {}
  L1.name = ""
  L1.icon = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = string
    L2 = L2.len
    L3 = A0
    L2 = L2(L3)
    if not (L2 < 8) then
      goto lbl_17
    end
  end
  do return L1 end
  ::lbl_17::
  L2 = _UPVALUE1_
  L2 = L2.identifyDevice
  L3 = A0
  L4 = nil
  return L2(L3, L4)
end
getDeviceCompany = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQDBUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.fetchAllDeviceInfo
  L2 = L2()
  if 0 < L3 then
    for L6, L7 in L3, L4, L5 do
      L8 = L7.mac
      L1[L8] = L7
    end
  end
  return L1
end
getDeviceInfoFromDB = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.util.XQDBUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.fetchAllDeviceInfo
  L2 = L2()
  if 0 < L3 then
    for L6, L7 in L3, L4, L5 do
      L8 = table
      L8 = L8.insert
      L9 = L1
      L10 = L7.mac
      L8(L9, L10)
    end
  end
  return L1
end
getDeviceMacsFromDB = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "deviceinfo"
  L5 = "device"
  function L6(A0)
    local L1, L2, L3
    L1 = {}
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0.mac
    L2 = L2(L3)
    L1.mac = L2
    L2 = A0.owner
    L1.owner = L2
    L2 = A0.device
    L1.device = L2
    L2 = _UPVALUE1_
    L3 = L1.mac
    L2[L3] = L1
  end
  L2(L3, L4, L5, L6)
  return L1
end
getDeviceInfoFromConfig = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  L1.owner = ""
  L1.device = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return L1
  else
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  L2 = string
  L2 = L2.lower
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3, L4, L5, L6, L7 = L3(L4, L5, L6)
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get_all
  L6 = "deviceinfo"
  L7 = L2
  L4 = L4(L5, L6, L7)
  if L4 then
    L5 = L4.owner
    L5 = L5 or L5
    L1.owner = L5
    L5 = L4.device
    L5 = L5 or L5
    L1.device = L5
  end
  return L1
end
fetchDeviceInfoFromConfig = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    return
  end
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.macFormat
  L5 = A0
  L4 = L4(L5)
  L5 = string
  L5 = L5.lower
  L7 = L4
  L6 = L4.gsub
  L8 = ":"
  L9 = ""
  L6, L7, L8, L9, L10, L11, L12 = L6(L7, L8, L9)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12)
  L7 = L3
  L6 = L3.get_all
  L8 = "deviceinfo"
  L9 = L5
  L6 = L6(L7, L8, L9)
  if L6 then
    if A1 then
      L7 = L3
      L6 = L3.set
      L8 = "deviceinfo"
      L9 = L5
      L10 = "owner"
      L11 = A1
      L6(L7, L8, L9, L10, L11)
    end
    if A2 then
      L7 = L3
      L6 = L3.set
      L8 = "deviceinfo"
      L9 = L5
      L10 = "device"
      L11 = A2
      L6(L7, L8, L9, L10, L11)
    end
  else
    L6 = {}
    L6.mac = L4
    L7 = A1 or L7
    if not A1 then
      L7 = ""
    end
    L6.owner = L7
    L7 = A2 or L7
    if not A2 then
      L7 = ""
    end
    L6.device = L7
    L8 = L3
    L7 = L3.section
    L9 = "deviceinfo"
    L10 = "device"
    L11 = L5
    L12 = L6
    L7(L8, L9, L10, L11, L12)
  end
  L7 = L3
  L6 = L3.commit
  L8 = "deviceinfo"
  L6(L7, L8)
end
saveDeviceInfo = L5
function L5(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  L4 = require
  L5 = "xiaoqiang.util.XQDBUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQSynchrodata"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.macFormat
  L7 = A0
  L6 = L6(L7)
  L7 = L5.syncDeviceInfo
  L8 = {}
  L8.mac = L6
  L8.nickname = A1
  L8.owner = A2
  L8.device = A3
  L7(L8)
  L7 = L4.updateDeviceNickname
  L8 = L6
  L9 = A1
  L7 = L7(L8, L9)
  if L7 == 0 then
    L8 = saveDeviceInfo
    L9 = L6
    L10 = A2
    L11 = A3
    L8(L9, L10, L11)
    L8 = true
    return L8
  else
    L8 = false
    return L8
  end
end
saveDeviceName = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L2 = L1.cursor
  L2 = L2()
  L3 = {}
  L4 = _UPVALUE0_
  L4 = L4.DHCP_LEASE_FILEPATH
  L5 = L2.foreach
  function L9(A0)
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
  L5(L6, L7, L8, L9)
  L5 = io
  L5 = L5.open
  L5 = L5(L6, L7)
  if L5 then
    for L9 in L6, L7, L8 do
      if L9 then
        L11 = L9
        L10 = L9.match
        L12 = "^(%d+) (%S+) (%S+) (%S+)"
        L10, L11, L12, L13 = L10(L11, L12)
        if L13 == "*" then
          L13 = ""
        end
        if L10 and L11 and L12 and L13 then
          L14 = #L3
          L14 = L14 + 1
          L15 = {}
          L16 = _UPVALUE1_
          L16 = L16.macFormat
          L17 = L11
          L16 = L16(L17)
          L15.mac = L16
          L15.ip = L12
          L15.name = L13
          L3[L14] = L15
        end
      end
    end
    L6(L7)
    return L3
  else
    return L6
  end
end
getDHCPList = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = getDHCPList
  L1 = L1()
  for L5, L6 in L2, L3, L4 do
    L7 = L6.mac
    L0[L7] = L6
  end
  return L0
end
getDHCPDict = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = getDHCPList
  L1 = L1()
  for L5, L6 in L2, L3, L4 do
    L7 = L6.ip
    L0[L7] = L6
  end
  return L0
end
getDHCPIpDict = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  if A0 then
    L2 = type
    L3 = A0
    L2 = L2(L3)
    if L2 == "table" then
      L2 = getDeviceInfoFromDB
      L2 = L2()
      L3 = getDHCPDict
      L3 = L3()
      for L7, L8 in L4, L5, L6 do
        L9 = _UPVALUE0_
        L9 = L9.macFormat
        L10 = L8
        L9 = L9(L10)
        L8 = L9
        L9 = L2[L8]
        L10 = L3[L8]
        if L9 then
          L11 = _UPVALUE0_
          L11 = L11.isStrNil
          L12 = L9.nickname
          L11 = L11(L12)
          if not L11 then
            L11 = L9.nickname
            L1[L8] = L11
        end
        else
          L11 = nil
          if L10 then
            L12 = _UPVALUE0_
            L12 = L12.isStrNil
            L13 = L10.name
            L12 = L12(L13)
            if not L12 then
              L11 = L10.name
              L12 = L10.name
              L1[L8] = L12
            end
          end
          L12 = _UPVALUE1_
          L12 = L12.identifyDevice
          L13 = L8
          L14 = L11
          L12 = L12(L13, L14)
          L13 = _UPVALUE0_
          L13 = L13.isStrNil
          L14 = L1[L8]
          L13 = L13(L14)
          if L13 then
            if L12 then
              L13 = _UPVALUE0_
              L13 = L13.isStrNil
              L14 = L12.type
              L14 = L14.n
              L13 = L13(L14)
              if not L13 then
                L13 = L12.type
                L13 = L13.n
                L1[L8] = L13
            end
            else
              if L12 then
                L13 = _UPVALUE0_
                L13 = L13.isStrNil
                L14 = L12.name
                L13 = L13(L14)
                if not L13 then
                  L13 = L12.name
                  L1[L8] = L13
              end
              else
                L1[L8] = L8
              end
            end
          else
          end
        end
      end
      return L1
  end
  else
    L2 = nil
    return L2
  end
end
getDevicesName = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = {}
  L4 = {}
  L5 = L1.execl
  L6 = "/usr/sbin/sysapi macfilter get"
  L5 = L5(L6)
  L6 = {}
  L7 = {}
  if A0 then
    if L8 == "table" then
      L6 = A0
  end
  else
    for L11, L12 in L8, L9, L10 do
      L14 = L12
      L13 = L12.match
      L15 = "mac=(%S-);"
      L13 = L13(L14, L15)
      L13 = L13 or L13
      if L13 and L13 ~= "" then
        L14 = table
        L14 = L14.insert
        L15 = L6
        L16 = _UPVALUE0_
        L16 = L16.macFormat
        L17 = L13
        L16, L17, L18, L19, L20, L21, L22 = L16(L17)
        L14(L15, L16, L17, L18, L19, L20, L21, L22)
      end
    end
  end
  L8.api = 70
  L8.macs = L6
  L13, L14, L15, L16, L17, L18, L19, L20, L21, L22 = L10(L11)
  if L9 then
    if L10 == 0 then
      for L13, L14 in L10, L11, L12 do
        L15 = L6[L13]
        L7[L15] = L14
      end
    end
  end
  for L13, L14 in L10, L11, L12 do
    L15 = L14
    L16 = ";"
    L14 = L15 .. L16
    L16 = L14
    L15 = L14.match
    L17 = "mac=(%S-);"
    L15 = L15(L16, L17)
    L15 = L15 or L15
    L17 = L14
    L16 = L14.match
    L18 = "wan=(%S-);"
    L16 = L16(L17, L18)
    L16 = L16 or L16
    L18 = L14
    L17 = L14.match
    L19 = "lan=(%S-);"
    L17 = L17(L18, L19)
    L17 = L17 or L17
    L19 = L14
    L18 = L14.match
    L20 = "admin=(%S-);"
    L18 = L18(L19, L20)
    L18 = L18 or L18
    L20 = L14
    L19 = L14.match
    L21 = "pridisk=(%S-);"
    L19 = L19(L20, L21)
    L19 = L19 or L19
    L20 = {}
    if L15 then
      L21 = _UPVALUE0_
      L21 = L21.macFormat
      L22 = L15
      L21 = L21(L22)
      L15 = L21
      L21 = tostring
      L22 = L16
      L21 = L21(L22)
      if L21 == "0" then
        L21 = 0
        if L21 then
          goto lbl_123
        end
      end
      L21 = 1
      ::lbl_123::
      L20.wan = L21
      L21 = string
      L21 = L21.upper
      L22 = L17
      L21 = L21(L22)
      if L21 == "YES" then
        L21 = 1
        if L21 then
          goto lbl_134
        end
      end
      L21 = 0
      ::lbl_134::
      L20.lan = L21
      L21 = string
      L21 = L21.upper
      L22 = L18
      L21 = L21(L22)
      if L21 == "YES" then
        L21 = 1
        if L21 then
          goto lbl_145
        end
      end
      L21 = 0
      ::lbl_145::
      L20.admin = L21
      L21 = string
      L21 = L21.upper
      L22 = L19
      L21 = L21(L22)
      if L21 == "YES" then
        L21 = 1
        if L21 then
          goto lbl_156
        end
      end
      L21 = 0
      ::lbl_156::
      L20.pridisk = L21
      L21 = L7[L15]
      if L21 ~= nil then
        if L21 then
          L22 = 1
          if L22 then
            goto lbl_166
          end
        end
        L22 = 0
        ::lbl_166::
        L20.lan = L22
      end
      L3[L15] = L20
    end
  end
  for L13, L14 in L10, L11, L12 do
    L15 = L3[L14]
    if L15 then
      L15 = L3[L14]
      L4[L14] = L15
    else
      L15 = {}
      L15.wan = 1
      L16 = L7[L14]
      if L16 then
        L16 = 1
        if L16 then
          goto lbl_189
        end
      end
      L16 = 0
      ::lbl_189::
      L15.lan = L16
      L15.admin = 1
      L15.pridisk = 0
      L4[L14] = L15
    end
  end
  return L4
end
getDevicesPermissions = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = ""
  if A0 == "lan" then
    L2 = "ubus call trafficd lan"
  elseif A0 == "wan" then
    L2 = "ubus call trafficd wan"
  end
  L3 = {}
  L3.upload = "0"
  L3.upspeed = "0"
  L3.download = "0"
  L3.downspeed = "0"
  L3.devname = ""
  L3.maxuploadspeed = "0"
  L3.maxdownloadspeed = "0"
  L4 = L1.exec
  L5 = L2
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    return L3
  end
  L5 = _UPVALUE1_
  L5 = L5.decode
  L6 = L4
  L5 = L5(L6)
  if A0 == "wan" then
    L6 = tostring
    L6 = L6(L7)
    L3.devname = L6
    L6 = tostring
    L6 = L6(L7)
    L3.upload = L6
    L6 = tostring
    L6 = L6(L7)
    L3.download = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.upspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.downspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.maxuploadspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.maxdownloadspeed = L6
    L6 = L1.exec
    L6 = L6(L7)
    if not L7 then
      historylist = L7
      L6 = L7
      for L10, L11 in L7, L8, L9 do
        if L11 then
          L12 = table
          L12 = L12.insert
          L13 = historylist
          L14 = tostring
          L15 = L11
          L14, L15 = L14(L15)
          L12(L13, L14, L15)
        end
      end
      L3.history = L7
    end
  else
    L6 = tostring
    L6 = L6(L7)
    L3.devname = L6
    L6 = tostring
    L6 = L6(L7)
    L3.upload = L6
    L6 = tostring
    L6 = L6(L7)
    L3.download = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.upspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.downspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.maxuploadspeed = L6
    L6 = tostring
    L10, L11, L12, L13, L14, L15 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
    L3.maxdownloadspeed = L6
  end
  return L3
end
getWanLanNetworkStatistics = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = {}
  L6 = {}
  if A1 ~= nil then
    for L10, L11 in L7, L8, L9 do
      L6[L11] = 1
    end
  end
  if A0 == nil then
    if L8 then
      return L8
    else
      L4 = L8
    end
  else
    L4 = A0
  end
  if L7 == nil then
    return L8
  end
  L6[L7] = 1
  for L11, L12 in L8, L9, L10 do
    L13 = L12.ifname
    L13 = L6[L13]
    if L13 ~= 1 then
      L5[L11] = L12
    end
  end
  return L5
end
skip_master_dev_from_trafficd = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L2 = getDHCPDict
  L2 = L2()
  L3 = getDeviceInfoFromDB
  L3 = L3()
  L4 = L0.exec
  L4 = L4(L5)
  if L5 then
    return L1
  else
    L4 = L5
  end
  for L8, L9 in L5, L6, L7 do
    if L9 then
      L10 = {}
      L11 = _UPVALUE0_
      L11 = L11.macFormat
      L12 = L8
      L11 = L11(L12)
      L12, L13, L14 = nil, nil, nil
      L15 = L2[L11]
      if L15 then
        L15 = L2[L11]
        L14 = L15.name
      end
      L15 = L3[L11]
      if L15 then
        L16 = _UPVALUE0_
        L16 = L16.isStrNil
        L17 = L14
        L16 = L16(L17)
        if L16 then
          L14 = L15.oName
        end
        L13 = L15.nickname
      end
      L16 = _UPVALUE2_
      L16 = L16.identifyDevice
      L17 = L11
      L18 = L14
      L16 = L16(L17, L18)
      L17 = L16.type
      L18 = _UPVALUE0_
      L18 = L18.isStrNil
      L19 = L13
      L18 = L18(L19)
      if not L18 then
        L12 = L13
      end
      L18 = _UPVALUE0_
      L18 = L18.isStrNil
      L19 = L12
      L18 = L18(L19)
      if L18 then
        L18 = _UPVALUE0_
        L18 = L18.isStrNil
        L19 = L17.n
        L18 = L18(L19)
        if not L18 then
          L12 = L17.n
        end
      end
      L18 = _UPVALUE0_
      L18 = L18.isStrNil
      L19 = L12
      L18 = L18(L19)
      if L18 then
        L18 = _UPVALUE0_
        L18 = L18.isStrNil
        L19 = L14
        L18 = L18(L19)
        if not L18 then
          L12 = L14
        end
      end
      L18 = _UPVALUE0_
      L18 = L18.isStrNil
      L19 = L12
      L18 = L18(L19)
      if L18 then
        L18 = _UPVALUE0_
        L18 = L18.isStrNil
        L19 = L16.name
        L18 = L18(L19)
        if not L18 then
          L12 = L16.name
        end
      end
      L18 = _UPVALUE0_
      L18 = L18.isStrNil
      L19 = L12
      L18 = L18(L19)
      if L18 then
        L12 = L11
      end
      L18 = 0
      L19 = 0
      L20 = 0
      L21 = 0
      L22 = 0
      L23 = 0
      L24 = L9.ip_list
      if 0 < L25 then
        for L28, L29 in L25, L26, L27 do
          L30 = L29.tx_bytes
          L30 = L18 + L30
          L18 = L30 or L18
          if not L30 then
            L18 = 0
          end
          L30 = L29.rx_bytes
          L30 = L20 + L30
          L20 = L30 or L20
          if not L30 then
            L20 = 0
          end
          L30 = L29.tx_rate
          L30 = L19 + L30
          L19 = L30 or L19
          if not L30 then
            L19 = 0
          end
          L30 = L29.rx_rate
          L30 = L21 + L30
          L21 = L30 or L21
          if not L30 then
            L21 = 0
          end
          L30 = L29.max_tx_rate
          L30 = L22 + L30
          L22 = L30 or L22
          if not L30 then
            L22 = 0
          end
          L30 = L29.max_rx_rate
          L30 = L23 + L30
          L23 = L30 or L23
          if not L30 then
            L23 = 0
          end
        end
      end
      L10.mac = L11
      L10.upload = L25
      L28, L29, L30 = L26(L27)
      L10.upspeed = L25
      L10.download = L25
      L28, L29, L30 = L26(L27)
      L10.downspeed = L25
      L10.online = L25
      L10.devname = L12
      L10.isap = L25
      L28, L29, L30 = L26(L27)
      L10.maxuploadspeed = L25
      L28, L29, L30 = L26(L27)
      L10.maxdownloadspeed = L25
      L1[L25] = L10
    end
  end
  return L1
end
getDevNetStatisticsList = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = 0
  L2 = L0.exec
  L3 = "ubus call trafficd hw 2>/dev/null"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = L4.get_wlan_count
  L5 = L5()
  L6 = L4.get_wlan_ifname
  L6 = L6()
  L7 = L4.get_wlan_wifi5_ifname
  L7 = L7()
  L8 = {}
  L9 = 0
  for L13 = L10, L11, L12 do
    L8[L13] = 0
  end
  if L10 then
    for L13 = L10, L11, L12 do
      L14 = L4.get_wl_con_dev_num
      L14 = L14(L15)
      L8[L13] = L14
      L14 = L8[L13]
      L9 = L9 + L14
    end
    return L10, L11
  else
    L2 = L10
  end
  for L13, L14 in L10, L11, L12 do
    if L15 == 1 then
      if L15 then
        for L18, L19 in L15, L16, L17 do
          L20 = L14.ifname
          if L20 == L19 then
            L20 = L8[L18]
            L21 = L14.ip_list
            L21 = #L21
            L20 = L20 + L21
            L8[L18] = L20
          end
        end
        for L18, L19 in L15, L16, L17 do
          L20 = L14.ifname
          if L20 == L19 then
            L20 = L8[L18]
            L21 = L14.ip_list
            L21 = #L21
            L20 = L20 + L21
            L8[L18] = L20
          end
        end
        L1 = L1 + L15
      end
    end
  end
  return L10, L11
end
get2g5gDeviceCount = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = getDevNetStatisticsList
  L1 = L1()
  for L5, L6 in L2, L3, L4 do
    if L6 then
      L7 = L6.mac
      L0[L7] = L6
    end
  end
  return L0
end
getDevNetStatisticsDict = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDBUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = 0
  L4 = 0
  L5 = L0.exec
  L6 = "ubus call trafficd hw"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L6 = L6(L7)
  if L6 then
    L6 = 0
    return L6, L7
  end
  L6 = L2.getLanIpPre
  L6 = L6()
  L5 = L7
  for L10, L11 in L7, L8, L9 do
    L12 = L11.ifname
    if L13 then
      for L16, L17 in L13, L14, L15 do
        L18 = false
        if L12 ~= "wl1.2" and L12 ~= "wl3" and L12 ~= "wl14" and L12 ~= "wl15" and L6 then
          L19 = L17.ip
          if L19 then
            L19 = L17.ip
            L20 = L19
            L19 = L19.match
            L21 = "^"
            L22 = L6
            L21 = L21 .. L22
            L19 = L19(L20, L21)
            if not L19 then
              L19 = L17.ip
              if L19 ~= "0.0.0.0" then
                goto lbl_70
              end
            end
            L18 = false
            goto lbl_71
            ::lbl_70::
            L18 = true
          end
        end
        ::lbl_71::
        if not L18 then
          L19 = L11.is_ap
          if L19 ~= 8 then
            L19 = L11.is_ap
            if L19 ~= 4 then
              goto lbl_92
            end
          end
          L19 = tonumber
          L20 = L11.assoc
          L19 = L19(L20)
          if L19 == 1 then
            L19 = L11.is_ap
            if L19 == 8 then
              L4 = L4 + 1
            end
            L19 = L11.is_ap
            if L19 == 4 then
              L3 = L3 + 1
            end
          end
        end
        ::lbl_92::
      end
    end
  end
  return L7, L8
end
getMeshDeviceCount = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDBUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = 0
  L4 = 0
  L5 = 0
  L6 = 0
  L7 = L0.exec
  L8 = "ubus call trafficd hw"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L8 = L8(L9)
  if L8 then
    L8 = 0
    return L8, L9
  end
  L8 = _UPVALUE1_
  L8 = L8.decode
  L8 = L8(L9)
  L7 = L8
  L8 = L1.fetchAllDeviceInfo
  L8 = L8()
  if L8 then
    for L12, L13 in L9, L10, L11 do
      if L13 then
        L14 = L13.mac
        L14 = L7[L14]
        if not L14 then
          L14 = _UPVALUE0_
          L14 = L14.isStrNil
          L15 = L13.oName
          L14 = L14(L15)
          if L14 then
            L14 = _UPVALUE0_
            L14 = L14.isStrNil
            L15 = L13.nickname
            L14 = L14(L15)
            if L14 then
              goto lbl_59
            end
          end
          L4 = L4 + 1
          L6 = L6 + 1
        end
      end
      ::lbl_59::
    end
  end
  for L13, L14 in L10, L11, L12 do
    L15 = L14.ifname
    if L16 then
      for L19, L20 in L16, L17, L18 do
        L21 = false
        if L15 ~= "wl1.2" and L15 ~= "wl3" and L15 ~= "wl14" and L9 then
          L22 = L20.ip
          if L22 then
            L22 = L20.ip
            L23 = L22
            L22 = L22.match
            L24 = "^"
            L25 = L9
            L24 = L24 .. L25
            L22 = L22(L23, L24)
            if not L22 then
              L22 = L20.ip
              if L22 ~= "0.0.0.0" then
                goto lbl_100
              end
            end
            L21 = false
            goto lbl_101
            ::lbl_100::
            L21 = true
          end
        end
        ::lbl_101::
        if not L21 then
          L23 = L15
          L22 = L15.match
          L24 = "wl"
          L22 = L22(L23, L24)
          if L22 then
            L22 = L14.is_ap
            if L22 ~= 8 then
              L22 = L14.is_ap
              if L22 ~= 4 then
                L23 = L15
                L22 = L15.match
                L24 = "wl"
                L22 = L22(L23, L24)
                if not L22 then
                  goto lbl_135
                end
                L22 = tonumber
                L23 = L14.assoc
                L22 = L22(L23)
                if L22 ~= 1 then
                  goto lbl_135
                end
              end
            end
          end
          L22 = L20.ageing_timer
          if L22 <= 300 then
            L3 = L3 + 1
            L22 = L14.is_ap
            if L22 ~= 4 then
              L22 = L14.is_ap
              if L22 ~= 8 then
                L5 = L5 + 1
              end
            end
          end
          ::lbl_135::
          L4 = L4 + 1
          L22 = L14.is_ap
          if L22 ~= 4 then
            L22 = L14.is_ap
            if L22 ~= 8 then
              L6 = L6 + 1
            end
          end
        end
      end
    end
  end
  L13 = L6
  return L10, L11, L12, L13
end
getDeviceCount = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = 0
  L2 = L0.exec
  L2 = L2(L3)
  if L3 then
    return L1
  else
    L2 = L3
  end
  for L6, L7 in L3, L4, L5 do
    if L7 then
      L8 = L7.ip_list
      if L8 then
        L8 = L7.ip_list
        L8 = #L8
        if 0 < L8 then
          L8 = L7.ifname
          if not L9 then
            if L9 ~= 1 then
              if L9 then
                goto lbl_67
              end
            end
            for L12, L13 in L9, L10, L11 do
              L14 = L13.ageing_timer
              if L14 <= 300 then
                L14 = L13.tx_bytes
                if L14 == 0 then
                  L14 = L13.rx_bytes
                  if L14 == 0 then
                    goto lbl_65
                  end
                end
                L1 = L1 + 1
              end
              ::lbl_65::
            end
          end
        end
      end
    end
    ::lbl_67::
  end
  return L1
end
getConnectDeviceCount = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.XQEquipment"
  L0 = L0(L1)
  L1 = {}
  L1.mitv = 0
  L1.mibox = 0
  L2 = getDeviceInfoFromDB
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    if L7 then
      L8 = _UPVALUE0_
      L8 = L8.isStrNil
      L9 = L7.oName
      L8 = L8(L9)
      if not L8 then
        L8 = _UPVALUE0_
        L8 = L8.macFormat
        L9 = L6
        L8 = L8(L9)
        L9 = L7.oName
        L11 = L9
        L10 = L9.match
        L12 = "^mitv"
        L10 = L10(L11, L12)
        if L10 then
          L10 = L1.mitv
          L10 = L10 + 1
          L1.mitv = L10
        end
        L11 = L9
        L10 = L9.match
        L12 = "^mibox"
        L10 = L10(L11, L12)
        if L10 then
          L10 = L1.mibox
          L10 = L10 + 1
          L1.mibox = L10
        end
      end
    end
  end
  return L1
end
getSpecialDevCount = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L2 = {}
  L2.flag = 0
  L2.name = ""
  L2.mac = ""
  L2.dhcpname = ""
  L3 = {}
  L3.c = 0
  L3.p = 0
  L3.n = ""
  L2.type = L3
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    return L2
  else
    L3 = _UPVALUE0_
    L3 = L3.macFormat
    L4 = A0
    L3 = L3(L4)
    A0 = L3
  end
  L3 = require
  L4 = "xiaoqiang.XQEquipment"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQDBUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.module.XQFirewall"
  L5 = L5(L6)
  L6 = getDHCPDict
  L6 = L6()
  L6 = L6[A0]
  L7 = L4.fetchDeviceInfo
  L8 = A0
  L7 = L7(L8)
  L8, L9, L10, L11 = nil, nil, nil, nil
  if L6 then
    L12 = L6.name
    if L12 then
      L9 = L6.name
    end
  end
  if L7 then
    L12 = _UPVALUE0_
    L12 = L12.isStrNil
    L13 = L7.mac
    L12 = L12(L13)
    if not L12 then
      L2.flag = 1
    end
    L12 = _UPVALUE0_
    L12 = L12.isStrNil
    L13 = L7.nickname
    L12 = L12(L13)
    if not L12 then
      L10 = L7.nickname
      L8 = L10
    end
    L12 = _UPVALUE0_
    L12 = L12.isStrNil
    L13 = L7.oName
    L12 = L12(L13)
    if not L12 then
      L12 = _UPVALUE0_
      L12 = L12.isStrNil
      L13 = L9
      L12 = L12(L13)
      if L12 then
        L9 = L7.oName
      end
    end
  end
  L12 = L3.identifyDevice
  L13 = A0
  L14 = L9
  L12 = L12(L13, L14)
  L13 = L12.type
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = L8
  L14 = L14(L15)
  if L14 then
    L14 = _UPVALUE0_
    L14 = L14.isStrNil
    L15 = L13.n
    L14 = L14(L15)
    if not L14 then
      L8 = L13.n
    end
  end
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = L8
  L14 = L14(L15)
  if L14 then
    L14 = _UPVALUE0_
    L14 = L14.isStrNil
    L15 = L9
    L14 = L14(L15)
    if not L14 then
      L8 = L9
    end
  end
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = L8
  L14 = L14(L15)
  if L14 then
    L14 = _UPVALUE0_
    L14 = L14.isStrNil
    L15 = L12.name
    L14 = L14(L15)
    if not L14 then
      L8 = L12.name
    end
  end
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = L8
  L14 = L14(L15)
  if L14 then
    L8 = A0
  end
  L14 = L13.c
  if L14 == 3 then
    L14 = _UPVALUE0_
    L14 = L14.isStrNil
    L15 = L10
    L14 = L14(L15)
    if L14 then
      L8 = L13.n
    end
  end
  L14 = fetchDeviceInfoFromConfig
  L15 = A0
  L14 = L14(L15)
  L2.mac = A0
  L2.name = L8
  L15 = L14.owner
  L15 = L15 or L15
  L2.owner = L15
  L15 = L14.device
  L15 = L15 or L15
  L2.device = L15
  L15 = L9 or L15
  if not L9 then
    L15 = ""
  end
  L2.dhcpname = L15
  L2.type = L13
  if A1 then
    L15 = require
    L16 = "xiaoqiang.util.XQPushUtil"
    L15 = L15(L16)
    L16 = L5.getMacfilterInfoDict
    L16 = L16()
    L17 = nil
    L18 = {}
    L18.api = 70
    L19 = {}
    L20 = A0
    L19[1] = L20
    L18.macs = L19
    L19 = _UPVALUE0_
    L19 = L19.thrift_tunnel_to_datacenter
    L20 = _UPVALUE1_
    L20 = L20.encode
    L21 = L18
    L20, L21, L22, L23, L24, L25, L26 = L20(L21)
    L19 = L19(L20, L21, L22, L23, L24, L25, L26)
    if L19 then
      L20 = L19.code
      if L20 == 0 then
        L20 = L19.canAccessAllDisk
        L17 = L20[1]
      end
    end
    L20 = {}
    L21 = L16[A0]
    if L21 then
      L21 = L16[A0]
      L21 = L21.wan
      if L21 then
        L21 = 1
        if L21 then
          goto lbl_197
        end
      end
      L21 = 0
      ::lbl_197::
      L20.wan = L21
      L21 = L16[A0]
      L21 = L21.lan
      if L21 then
        L21 = 1
        if L21 then
          goto lbl_206
        end
      end
      L21 = 0
      ::lbl_206::
      L20.lan = L21
      L21 = L16[A0]
      L21 = L21.admin
      if L21 then
        L21 = 1
        if L21 then
          goto lbl_215
        end
      end
      L21 = 0
      ::lbl_215::
      L20.admin = L21
      L21 = L16[A0]
      L21 = L21.pridisk
      if L21 then
        L21 = 1
        if L21 then
          goto lbl_224
        end
      end
      L21 = 0
      ::lbl_224::
      L20.pridisk = L21
    else
      L20.wan = 1
      L20.lan = 1
      L20.admin = 1
      L20.pridisk = 0
    end
    if L17 ~= nil then
      if L17 then
        L21 = 1
        if L21 then
          goto lbl_238
        end
      end
      L21 = 0
      ::lbl_238::
      L20.lan = L21
    end
    L21 = L15.notifyDict
    L21 = L21()
    L22 = 0
    L24 = A0
    L23 = A0.gsub
    L25 = ":"
    L26 = ""
    L23 = L23(L24, L25, L26)
    L24 = L21[L23]
    if L24 then
      L22 = 1
    end
    L24 = L15.getAuthenFailedTimes
    L25 = A0
    L24 = L24(L25)
    L24 = L24 or L24
    L2.push = L22
    L2.times = L24
    L2.authority = L20
  end
  return L2
end
getDeviceInfo = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57, L58, L59, L60, L61, L62
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDBUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQEquipment"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQPushUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQLanWanUtil"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.common.XQFunction"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQWifiUtil"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.module.XQFirewall"
  L9 = L9(L10)
  L10 = require
  L11 = "luci.util"
  L10 = L10(L11)
  L11 = {}
  L12 = L7.isMeshRe
  L12 = L12()
  if L12 then
    L12 = L8.getWifiAllDeviceMacList
    L12 = L12()
    L11 = L12
    return L11
  end
  L12 = "ubus call trafficd hw"
  L13 = L10.exec
  L14 = L12
  L13 = L13(L14)
  L14 = L7.isStrNil
  L15 = L13
  L14 = L14(L15)
  if L14 then
    return L11
  end
  L14 = _UPVALUE0_
  L14 = L14.decode
  L15 = L13
  L14 = L14(L15)
  L13 = L14
  L14 = L9.getMacfilterInfoDict
  L14 = L14()
  L15 = getDHCPIpDict
  L15 = L15()
  L16 = getDeviceInfoFromDB
  L16 = L16()
  L17 = L5.notifyDict
  L17 = L17()
  L18 = L5.getAuthenFailedTimesDict
  L18 = L18()
  L19 = L8.getWiFiMacfilterModel
  L19 = L19()
  if L19 == 1 then
    if L20 then
      for L24, L25 in L21, L22, L23 do
        L26 = L13[L25]
        if not L26 then
          L26 = {}
          L26.hw = L25
          L26.ifname = "wl1"
          L26.assoc = 0
          L28.ip = "0.0.0.0"
          L28.hw = L25
          L28.ageing_timer = 400
          L28.rx_bytes = 0
          L28.tx_bytes = 0
          L28.rx_rate = 0
          L28.tx_rate = 0
          L28.max_rx_rate = 0
          L28.max_tx_rate = 0
          L27[1] = L28
          L26.ip_list = L27
          L13[L25] = L26
        end
      end
    end
  end
  if not A0 and L16 then
    for L23, L24 in L20, L21, L22 do
      L25 = L13[L23]
      if not L25 then
        L25 = L7.isStrNil
        L26 = L24.oName
        L25 = L25(L26)
        if L25 then
          L25 = L7.isStrNil
          L26 = L24.nickname
          L25 = L25(L26)
          if L25 then
            goto lbl_136
          end
        end
        L25 = {}
        L25.hw = L23
        L25.ifname = "wl1"
        L25.assoc = 0
        L26 = {}
        L27.ip = "0.0.0.0"
        L27.hw = L23
        L27.ageing_timer = 400
        L27.rx_bytes = 0
        L27.tx_bytes = 0
        L27.rx_rate = 0
        L27.tx_rate = 0
        L27.max_rx_rate = 0
        L27.max_tx_rate = 0
        L26[1] = L27
        L25.ip_list = L26
        L13[L23] = L25
      end
      ::lbl_136::
    end
  end
  L24 = "misc"
  L25 = "wireless"
  L26 = "iface_guest_2g_ifname"
  L24 = L20
  L25 = "misc"
  L26 = "wireless"
  L24 = L6.getLanIpPre
  L24 = L24()
  L25 = L7.getNetMode
  L25 = L25()
  L26 = L20.get
  L30 = "gateway"
  L26 = L26(L27, L28, L29, L30)
  for L30, L31 in L27, L28, L29 do
    L32 = 1
    L33 = L31.ifname
    L34 = L7.isStrNil
    L35 = L33
    L34 = L34(L35)
    if L34 and not A0 then
      L34 = tonumber
      L35 = L31.assoc
      L34 = L34(L35)
      if 0 == L34 then
        L32 = 0
        L33 = "wl1"
      end
    end
    L34 = L7.macFormat
    L35 = L30
    L34 = L34(L35)
    L35, L36 = nil, nil
    L38 = L33
    L37 = L33.match
    L39 = "eth"
    L37 = L37(L38, L39)
    if L37 then
      L35 = "line"
      L36 = 0
    else
      if L33 == "" then
        L37 = tonumber
        L38 = L31.assoc
        L37 = L37(L38)
        if 1 == L37 then
          L33 = "eth"
          L35 = "line"
          L36 = 0
      end
      else
        L37 = L21[2]
        if L37 then
          L37 = L21[2]
          if L33 == L37 then
            L35 = "wifi"
            L36 = 2
        end
        else
          L37 = L21[1]
          if L37 then
            L37 = L21[1]
            if L33 == L37 then
              L35 = "wifi"
              L36 = 1
          end
          else
            L37 = L21[3]
            if L37 then
              L37 = L21[3]
              if L33 == L37 then
                L35 = "wifi"
                L37 = L8.getGameWifiSupport
                L37 = L37()
                if L37 then
                  L36 = 6
                else
                  L36 = 7
                end
            end
            elseif L33 == L22 or L33 == L23 then
              L35 = "wifi"
              L36 = 3
            end
          end
        end
      end
    end
    L37 = L7.isStrNil
    L38 = L33
    L37 = L37(L38)
    if not L37 then
      L37 = false
      L38 = false
      L39 = false
      L37 = 1 < L40
      for L43, L44 in L40, L41, L42 do
        L45 = tonumber
        L46 = L31.assoc
        L45 = L45(L46)
        if L45 == 1 then
          L39 = true
        end
      end
      for L43, L44 in L40, L41, L42 do
        L45, L46, L47, L48 = nil, nil, nil, nil
        L49 = L44.ip
        L49 = L15[L49]
        if L49 ~= nil then
          L49 = L44.ip
          L49 = L15[L49]
          L46 = L49.name
        end
        L49 = 0
        L50 = 0
        L52 = L34
        L51 = L34.gsub
        L53 = ":"
        L54 = ""
        L51 = L51(L52, L53, L54)
        L52 = L17[L51]
        if L52 then
          L49 = 1
        end
        L52 = tonumber
        L53 = L18[L51]
        L52 = L52(L53)
        L50 = L52 or L50
        if not L52 then
          L50 = 0
        end
        L52 = L16[L34]
        if L52 then
          L53 = L7.isStrNil
          L54 = L46
          L53 = L53(L54)
          if L53 then
            L46 = L52.oName
          end
          L47 = L52.nickname
        end
        L53 = L7.isStrNil
        L54 = L47
        L53 = L53(L54)
        if not L53 then
          L45 = L47
        end
        L53 = L31.is_ap
        if L53 ~= nil then
          L53 = L31.is_ap
        end
        if L53 == 0 and not L52 then
          L53 = L3.saveDeviceInfo
          L54 = L34
          L55 = L46 or L55
          if not L46 then
            L55 = ""
          end
          L56 = ""
          L57 = ""
          L58 = ""
          L53(L54, L55, L56, L57, L58)
        end
        L53 = L4.identifyDevice
        L54 = L34
        L55 = L46
        L53 = L53(L54, L55)
        L48 = L53
        L53 = {}
        L54 = L14[L34]
        if L54 then
          L54 = L14[L34]
          L54 = L54.wan
          if L54 then
            L54 = 1
            if L54 then
              goto lbl_356
            end
          end
          L54 = 0
          ::lbl_356::
          L53.wan = L54
          L54 = L14[L34]
          L54 = L54.lan
          if L54 then
            L54 = 1
            if L54 then
              goto lbl_365
            end
          end
          L54 = 0
          ::lbl_365::
          L53.lan = L54
          L54 = L14[L34]
          L54 = L54.admin
          if L54 then
            L54 = 1
            if L54 then
              goto lbl_374
            end
          end
          L54 = 0
          ::lbl_374::
          L53.admin = L54
          L54 = L14[L34]
          L54 = L54.pridisk
          if L54 then
            L54 = 1
            if L54 then
              goto lbl_383
            end
          end
          L54 = 0
          ::lbl_383::
          L53.pridisk = L54
        else
          L53.wan = 1
          L53.lan = 1
          L53.admin = 1
          L53.pridisk = 0
        end
        L54 = L48.type
        L55 = L7.isStrNil
        L56 = L45
        L55 = L55(L56)
        if L55 then
          L55 = L7.isStrNil
          L56 = L54.n
          L55 = L55(L56)
          if not L55 then
            L45 = L54.n
          end
        end
        L55 = L7.isStrNil
        L56 = L45
        L55 = L55(L56)
        if L55 then
          L55 = L7.isStrNil
          L56 = L46
          L55 = L55(L56)
          if not L55 then
            L45 = L46
          end
        end
        L55 = L7.isStrNil
        L56 = L45
        L55 = L55(L56)
        if L55 then
          L55 = L7.isStrNil
          L56 = L48.name
          L55 = L55(L56)
          if not L55 then
            L45 = L48.name
          end
        end
        L55 = L7.isStrNil
        L56 = L45
        L55 = L55(L56)
        if L55 then
          L45 = L34
        end
        L55 = L54.c
        if L55 == 3 then
          L55 = L7.isStrNil
          L56 = L47
          L55 = L55(L56)
          if L55 then
            L45 = L54.n
          end
        end
        L55 = 0
        L56 = false
        if L33 ~= "wl1.2" and L33 ~= "wl3" and L33 ~= "wl14" and L33 ~= "wl15" and L24 then
          L57 = L44.ip
          if L57 then
            L57 = L44.ip
            L58 = L57
            L57 = L57.match
            L59 = "^"
            L60 = L24
            L59 = L59 .. L60
            L57 = L57(L58, L59)
            if not L57 then
              L57 = L44.ip
              if L57 ~= "0.0.0.0" then
                goto lbl_466
              end
            end
            L56 = false
            goto lbl_467
            ::lbl_466::
            L56 = true
          end
        end
        ::lbl_467::
        L57 = L7.isStrNil
        L58 = L25
        L57 = L57(L58)
        if not L57 and (L25 == "lanapmode" or L25 == "wifiapmode") then
          L57 = L7.isStrNil
          L58 = L26
          L57 = L57(L58)
          if not L57 then
            L57 = L44.ip
            if L26 == L57 then
              L56 = true
            end
          end
        end
        L58 = L33
        L57 = L33.match
        L59 = "wl"
        L57 = L57(L58, L59)
        if L57 or not A1 then
          L58 = L33
          L57 = L33.match
          L59 = "wl"
          L57 = L57(L58, L59)
        end
        if L57 and not L56 then
          L57 = tonumber
          L58 = L31.assoc
          L57 = L57(L58)
          if L57 == 1 then
            L55 = 1
            if L32 == 0 then
              L55 = 0
            end
          end
          L57 = L31.parent
          L57 = L57 or L57
          L58 = L7.isStrNil
          L59 = L57
          L58 = L58(L59)
          if not L58 then
            L35 = "ap"
          end
          L58 = {}
          L59 = L44.ip
          L58.ip = L59
          L58.mac = L34
          L58.online = L55
          L58.type = L35
          L58.port = L36
          L59 = L54.c
          L58.ctype = L59
          L59 = L54.p
          L58.ptype = L59
          L59 = L46 or L59
          if not L46 then
            L59 = ""
          end
          L58.origin_name = L59
          L58.name = L45
          L58.push = L49
          L58.company = L48
          L58.times = L50
          L58.authority = L53
          L58.parent = L57
          L59 = tonumber
          L60 = L31.is_ap
          L59 = L59(L60)
          L59 = L59 or L59
          L58.isap = L59
          L59 = L31.hostname
          L59 = L59 or L59
          L58.hostname = L59
          L59 = {}
          L59.dev = L33
          L59.mac = L34
          L60 = L44.ip
          L59.ip = L60
          L60 = tostring
          L61 = L44.tx_bytes
          L61 = L61 or L61
          L60 = L60(L61)
          L59.upload = L60
          L60 = tostring
          L61 = math
          L61 = L61.floor
          L62 = L44.tx_rate
          L62 = L62 or L62
          L61, L62 = L61(L62)
          L60 = L60(L61, L62)
          L59.upspeed = L60
          L60 = tostring
          L61 = L44.rx_bytes
          L61 = L61 or L61
          L60 = L60(L61)
          L59.download = L60
          L60 = tostring
          L61 = math
          L61 = L61.floor
          L62 = L44.rx_rate
          L62 = L62 or L62
          L61, L62 = L61(L62)
          L60 = L60(L61, L62)
          L59.downspeed = L60
          L60 = tostring
          L61 = L31.online_timer
          L61 = L61 or L61
          L60 = L60(L61)
          L59.online = L60
          L60 = tostring
          L61 = math
          L61 = L61.floor
          L62 = L44.max_tx_rate
          L62 = L62 or L62
          L61, L62 = L61(L62)
          L60 = L60(L61, L62)
          L59.maxuploadspeed = L60
          L60 = tostring
          L61 = math
          L61 = L61.floor
          L62 = L44.max_rx_rate
          L62 = L62 or L62
          L61, L62 = L61(L62)
          L60 = L60(L61, L62)
          L59.maxdownloadspeed = L60
          L58.statistics = L59
          if A0 and L55 == 1 then
            L60 = table
            L60 = L60.insert
            L61 = L11
            L62 = L58
            L60(L61, L62)
          elseif not A0 then
            if L37 and L39 and L55 == 1 then
              L60 = table
              L60 = L60.insert
              L61 = L11
              L62 = L58
              L60(L61, L62)
            elseif L37 and not L39 and L55 ~= 1 and not L38 then
              L60 = table
              L60 = L60.insert
              L61 = L11
              L62 = L58
              L60(L61, L62)
              L38 = true
            elseif not L37 then
              L60 = table
              L60 = L60.insert
              L61 = L11
              L62 = L58
              L60(L61, L62)
            end
          end
        end
      end
    end
  end
  return L11
end
getDeviceList = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQFirewall"
  L4 = L4(L5)
  L5 = {}
  L6 = "ubus call trafficd hw"
  L7 = L0.exec
  L8 = L6
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L9 = L7
  L8 = L8(L9)
  if L8 then
    return L5
  end
  L8 = _UPVALUE1_
  L8 = L8.decode
  L9 = L7
  L8 = L8(L9)
  L7 = L8
  L8 = L2.getLanIpPre
  L8 = L8()
  L9 = L4.getMacfilterInfoDict
  L9 = L9()
  L10 = getDHCPIpDict
  L10 = L10()
  L11 = getDeviceInfoFromDB
  L11 = L11()
  L12 = L1.notifyDict
  L12 = L12()
  L13 = L1.getAuthenFailedTimesDict
  L13 = L13()
  L14 = {}
  L15 = {}
  L16 = 1
  for L20, L21 in L17, L18, L19 do
    L15[L16] = L20
    L16 = L16 + 1
  end
  for L20, L21 in L17, L18, L19 do
    L22 = _UPVALUE2_
    L22 = L22.macaddr
    L22 = L22(L23)
    if L22 then
      L22 = L7[L20]
      if not L22 then
        L22 = table
        L22 = L22.insert
        L22(L23, L24)
      end
    end
  end
  L17.api = 70
  L17.macs = L15
  L22, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L43, L44, L45, L46, L47, L48, L49, L50 = L19(L20)
  if L18 then
    if L19 == 0 then
      L16 = 1
      for L22, L23 in L19, L20, L21 do
        L14[L24] = L23
        L16 = L16 + 1
      end
    end
  end
  L22 = L19
  L22 = L19.get
  L26 = "iface_guest_5g_ifname"
  L22 = L22(L23, L24, L25, L26)
  L22 = L22 or L22
  for L26, L27 in L23, L24, L25 do
    L28 = L27.ifname
    L29 = _UPVALUE0_
    L29 = L29.isStrNil
    L30 = L28
    L29 = L29(L30)
    if not L29 then
      L29 = _UPVALUE0_
      L29 = L29.macFormat
      L30 = L26
      L29 = L29(L30)
      L30, L31 = nil, nil
      L32 = L27.parent
      L32 = L32 or L32
      L34 = L28
      L33 = L28.match
      L35 = "eth"
      L33 = L33(L34, L35)
      if L33 then
        L30 = "line"
        L31 = 0
      else
        L33 = L20[2]
        if L33 then
          L33 = L20[2]
          if L28 == L33 then
            L30 = "wifi"
            L31 = 2
        end
        else
          L33 = L20[1]
          if L33 then
            L33 = L20[1]
            if L28 == L33 then
              L30 = "wifi"
              L31 = 1
          end
          elseif L28 == L21 or L28 == L22 then
            L30 = "wifi"
            L31 = 3
          end
        end
      end
      L33 = _UPVALUE0_
      L33 = L33.isStrNil
      L34 = L32
      L33 = L33(L34)
      if not L33 then
        L30 = "ap"
        L31 = 4
      end
      L33, L34 = nil, nil
      L35 = L11[L29]
      if L35 then
        L36 = L35.oName
        L33 = L36 or L33
        if not L36 then
          L33 = ""
        end
        L36 = L35.nickname
        L34 = L36 or L34
        if not L36 then
          L34 = ""
        end
      end
      L36 = 0
      L37 = 0
      L39 = L29
      L38 = L29.gsub
      L38 = L38(L39, L40, L41)
      L39 = L12[L38]
      if L39 then
        L36 = 1
      end
      L39 = tonumber
      L39 = L39(L40)
      L37 = L39 or L37
      if not L39 then
        L37 = 0
      end
      L39 = {}
      if L40 then
        if L40 then
          if L40 then
            goto lbl_224
          end
        end
        ::lbl_224::
        L39.wan = L40
        if L40 then
          if L40 then
            goto lbl_233
          end
        end
        ::lbl_233::
        L39.lan = L40
        if L40 then
          if L40 then
            goto lbl_242
          end
        end
        ::lbl_242::
        L39.admin = L40
        if L40 then
          if L40 then
            goto lbl_251
          end
        end
        ::lbl_251::
        L39.pridisk = L40
      else
        L39.wan = 1
        L39.lan = 1
        L39.admin = 1
        L39.pridisk = 0
      end
      if L40 ~= nil then
        if L40 then
          if L40 then
            goto lbl_267
          end
        end
        ::lbl_267::
        L39.lan = L40
      end
      for L43, L44 in L40, L41, L42 do
        if L28 ~= "wl1.2" and L28 ~= "wl3" and L28 ~= "wl14" and L8 then
          L45 = L44.ip
          if L45 then
            L45 = L44.ip
            L46 = L45
            L45 = L45.match
            L47 = "^"
            L48 = L8
            L47 = L47 .. L48
            L45 = L45(L46, L47)
            if L45 then
              L45 = false
              ignor = L45
            else
              L45 = true
              ignor = L45
            end
          end
        end
        L46 = L28
        L45 = L28.match
        L47 = "wl"
        L45 = L45(L46, L47)
        if L45 then
          L46 = L28
          L45 = L28.match
          L47 = "wl"
          L45 = L45(L46, L47)
          if not L45 then
            goto lbl_426
          end
          L45 = tonumber
          L46 = L27.assoc
          L45 = L45(L46)
          if L45 ~= 1 then
            goto lbl_426
          end
        end
        L45 = L44.ageing_timer
        if L45 <= 300 then
          L45 = ignor
          if not L45 then
            L45 = L44.ip
            L45 = L10[L45]
            if L45 then
              L45 = _UPVALUE0_
              L45 = L45.isStrNil
              L46 = L44.ip
              L46 = L10[L46]
              L46 = L46.name
              L45 = L45(L46)
              if L45 then
                L45 = L44.ip
                L45 = L10[L45]
                L33 = L45.name
              end
            end
            L45 = {}
            L46 = L44.ip
            L45.ip = L46
            L45.mac = L29
            L45.dhcp = L33
            L46 = {}
            L46.nickname = L34
            L46.type = L30
            L46.port = L31
            L46.push = L36
            L46.times = L37
            L46.authority = L39
            L46.parent = L32
            L47 = tonumber
            L48 = L27.is_ap
            L47 = L47(L48)
            L47 = L47 or L47
            L46.isap = L47
            L47 = L27.hostname
            L47 = L47 or L47
            L46.hostname = L47
            L47 = {}
            L48 = tostring
            L49 = L44.tx_bytes
            L49 = L49 or L49
            L48 = L48(L49)
            L47.upload = L48
            L48 = tostring
            L49 = math
            L49 = L49.floor
            L50 = L44.tx_rate
            L50 = L50 or L50
            L49, L50 = L49(L50)
            L48 = L48(L49, L50)
            L47.upspeed = L48
            L48 = tostring
            L49 = L44.rx_bytes
            L49 = L49 or L49
            L48 = L48(L49)
            L47.download = L48
            L48 = tostring
            L49 = math
            L49 = L49.floor
            L50 = L44.rx_rate
            L50 = L50 or L50
            L49, L50 = L49(L50)
            L48 = L48(L49, L50)
            L47.downspeed = L48
            L48 = tostring
            L49 = L27.online_timer
            L49 = L49 or L49
            L48 = L48(L49)
            L47.online = L48
            L48 = tostring
            L49 = math
            L49 = L49.floor
            L50 = L44.max_tx_rate
            L50 = L50 or L50
            L49, L50 = L49(L50)
            L48 = L48(L49, L50)
            L47.maxuploadspeed = L48
            L48 = tostring
            L49 = math
            L49 = L49.floor
            L50 = L44.max_rx_rate
            L50 = L50 or L50
            L49, L50 = L49(L50)
            L48 = L48(L49, L50)
            L47.maxdownloadspeed = L48
            L46.statistics = L47
            L45.data = L46
            L46 = table
            L46 = L46.insert
            L47 = L5
            L48 = L45
            L46(L47, L48)
          end
        end
        ::lbl_426::
      end
    end
  end
  return L5
end
devicelistForMAgent = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57, L58, L59, L60
  L3 = require
  L4 = "xiaoqiang.XQFeatures"
  L3 = L3(L4)
  L3 = L3.FEATURES
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQDBUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.XQEquipment"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.util.XQPushUtil"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQLanWanUtil"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.util.XQWifiUtil"
  L9 = L9(L10)
  L10 = require
  L11 = "xiaoqiang.module.XQFirewall"
  L10 = L10(L11)
  L11 = require
  L12 = "luci.model.uci"
  L11 = L11(L12)
  L11 = L11.cursor
  L11 = L11()
  L12 = require
  L13 = "xiaoqiang.module.XQParentControl"
  L12 = L12(L13)
  L13 = L9.get_wlan_ifname
  L13 = L13()
  L14 = {}
  L15 = "ubus call trafficd hw '{\"mlo\":"
  L16 = tostring
  L17 = A2 or L17
  if not A2 then
    L17 = false
  end
  L16 = L16(L17)
  L17 = "}'"
  L15 = L15 .. L16 .. L17
  L16 = L4.exec
  L17 = L15
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.isStrNil
  L18 = L16
  L17 = L17(L18)
  if L17 then
    return L14
  end
  L17 = _UPVALUE1_
  L17 = L17.decode
  L18 = L16
  L17 = L17(L18)
  L16 = L17
  L17 = L8.getLanIpPre
  L17 = L17()
  L18 = L10.getMacfilterInfoDict
  L19 = "wan"
  L18 = L18(L19)
  L19 = getDHCPDict
  L19 = L19()
  L20 = getDeviceInfoFromDB
  L20 = L20()
  L21 = L7.notifyDict
  L21 = L21()
  L22 = L7.getAuthenFailedTimesDict
  L22 = L22()
  L23 = {}
  L24 = {}
  if L25 then
    if L25 == "1" then
      for L30, L31 in L27, L28, L29 do
        for L35, L36 in L32, L33, L34 do
          L24[L36] = 1
        end
      end
    end
  end
  if not A0 and L20 then
    for L28, L29 in L25, L26, L27 do
      L30 = L16[L28]
      if not L30 then
        L30 = _UPVALUE0_
        L30 = L30.isStrNil
        L31 = L29.oName
        L30 = L30(L31)
        if L30 then
          L30 = _UPVALUE0_
          L30 = L30.isStrNil
          L31 = L29.nickname
          L30 = L30(L31)
          if L30 then
            goto lbl_142
          end
        end
        L30 = {}
        L30.hw = L28
        L30.ifname = "wl1"
        L30.assoc = 0
        L31 = {}
        L32.ip = "0.0.0.0"
        L32.hw = L28
        L32.ageing_timer = 400
        L32.rx_bytes = 0
        L32.tx_bytes = 0
        L32.rx_rate = 0
        L32.tx_rate = 0
        L32.max_rx_rate = 0
        L32.max_tx_rate = 0
        L31[1] = L32
        L30.ip_list = L31
        L16[L28] = L30
      end
      ::lbl_142::
    end
  end
  L30 = "iot_dev"
  L30, L31, L35, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L53, L54, L55, L56, L57, L58, L59, L60 = L26(L27, L28, L29, L30)
  for L29, L30 in L26, L27, L28 do
    L31 = _UPVALUE0_
    L31 = L31.macFormat
    L31 = L31(L32)
    L35 = L32
    if L34 then
    else
      if L34 then
        if L32 == L34 then
      end
      else
        if L34 then
          if L32 == L34 then
        end
        else
          if L34 then
            if L32 == L34 then
          end
          elseif L32 == "wl1.2" then
          elseif L32 == "wl3" then
          elseif L32 == "wl14" then
          elseif L32 == "wl15" then
          elseif L25 == 1 and (L32 == "wl16" or L32 == "wl17") then
          elseif L32 == "" then
          end
        end
      end
    end
    if not A1 and L33 ~= 0 or A1 then
      L35 = false
      for L39, L40 in L36, L37, L38 do
        L41 = tonumber
        L42 = L30.assoc
        L41 = L41(L42)
        if L41 == 1 then
          L35 = true
          break
        end
      end
      L34.mac = L31
      if L35 then
        if L36 then
          goto lbl_250
        end
      end
      ::lbl_250::
      L34.online = L36
      L34.type = L33
      L34.isap = L36
      L34.parent = L36
      L34.pctlv2 = L36
      L39 = nil
      L40 = L19[L31]
      if L40 ~= nil then
        L40 = L19[L31]
      end
      L40 = L20[L31]
      if L40 then
        L41 = _UPVALUE0_
        L41 = L41.isStrNil
        L42 = L37
        L41 = L41(L42)
        if L41 then
        end
      end
      L41 = _UPVALUE0_
      L41 = L41.isStrNil
      L42 = L38
      L41 = L41(L42)
      if not L41 then
      end
      if not L40 then
        L41 = L5.saveDeviceInfo
        L42 = L31
        L43 = L37 or L43
        if not L37 then
          L43 = ""
        end
        L44 = ""
        L45 = ""
        L46 = ""
        L41(L42, L43, L44, L45, L46)
      end
      L41 = L6.identifyDevice
      L42 = L31
      L43 = L37
      L41 = L41(L42, L43)
      L39 = L41
      L41 = L39.type
      L42 = _UPVALUE0_
      L42 = L42.isStrNil
      L43 = L36
      L42 = L42(L43)
      if L42 then
        L42 = _UPVALUE0_
        L42 = L42.isStrNil
        L43 = L41.n
        L42 = L42(L43)
        if not L42 then
        end
      end
      L42 = _UPVALUE0_
      L42 = L42.isStrNil
      L43 = L36
      L42 = L42(L43)
      if L42 then
        L42 = _UPVALUE0_
        L42 = L42.isStrNil
        L43 = L37
        L42 = L42(L43)
        if not L42 then
        end
      end
      L42 = _UPVALUE0_
      L42 = L42.isStrNil
      L43 = L36
      L42 = L42(L43)
      if L42 then
        L42 = _UPVALUE0_
        L42 = L42.isStrNil
        L43 = L39.name
        L42 = L42(L43)
        if not L42 then
        end
      end
      L42 = _UPVALUE0_
      L42 = L42.isStrNil
      L43 = L36
      L42 = L42(L43)
      if L42 then
      end
      L42 = L41.c
      if L42 == 3 then
        L42 = _UPVALUE0_
        L42 = L42.isStrNil
        L43 = L38
        L42 = L42(L43)
        if L42 then
        end
      end
      L42 = L36 or L42
      if not L36 then
        L42 = ""
      end
      L34.name = L42
      L42 = L37 or L42
      if not L37 then
        L42 = ""
      end
      L34.oname = L42
      L42 = L39.icon
      L42 = L42 or L42
      L34.icon = L42
      L42 = 0
      L43 = 0
      L45 = L31
      L44 = L31.gsub
      L46 = ":"
      L47 = ""
      L44 = L44(L45, L46, L47)
      L45 = L21[L44]
      if L45 then
        L42 = 1
      end
      L45 = tonumber
      L46 = L22[L44]
      L45 = L45(L46)
      L43 = L45 or L43
      if not L45 then
        L43 = 0
      end
      L34.push = L42
      L34.times = L43
      L45 = {}
      L47 = L11
      L46 = L11.get
      L48 = "macfilter"
      L46 = L46(L47, L48, L49, L50)
      L47 = L18[L31]
      if L47 then
        L47 = L18[L31]
        L47 = L47.wan
        if L47 then
          L47 = 1
          if L47 then
            goto lbl_414
          end
        end
        L47 = 0
        ::lbl_414::
        L45.wan = L47
      elseif L46 == "black" then
        L45.wan = 1
      else
        L45.wan = 0
      end
      L47 = L45.wan
      if L47 == 1 then
        L48 = L31
        L47 = L31.gsub
        L47 = L47(L48, L49, L50)
        L48 = L11.get
        L48 = L48(L49, L50, L51, L52)
        if L48 == "time" then
          if L49 then
            if L50 then
              for L53, L54 in L50, L51, L52 do
                L55 = L54.active
                if L55 == 1 then
                  L45.wan = 0
                  break
                end
              end
            end
          end
        end
      end
      L34.authority = L45
      L47 = {}
      L48 = {}
      for L52, L53 in L49, L50, L51 do
        L54 = false
        if L32 ~= "wl1.2" and L32 ~= "wl3" and L32 ~= "wl14" and L32 ~= "wl15" and L17 then
          L55 = L53.ip
          if L55 then
            L55 = L53.ip
            L56 = L55
            L55 = L55.match
            L57 = "^"
            L58 = L17
            L57 = L57 .. L58
            L55 = L55(L56, L57)
            if not L55 then
              L55 = L53.ip
              if L55 ~= "0.0.0.0" then
                goto lbl_488
              end
            end
            L54 = false
            goto lbl_489
            ::lbl_488::
            L54 = true
          end
        end
        ::lbl_489::
        if not L54 then
          L55 = 0
          L56 = tonumber
          L57 = L30.assoc
          L56 = L56(L57)
          if L56 == 1 then
            L55 = 1
          end
          L56 = {}
          L57 = L53.ip
          L56.ip = L57
          L56.active = L55
          L57 = tostring
          L58 = math
          L58 = L58.floor
          L59 = L53.tx_rate
          L59 = L59 or L59
          L58, L59, L60 = L58(L59)
          L57 = L57(L58, L59, L60)
          L56.upspeed = L57
          L57 = tostring
          L58 = math
          L58 = L58.floor
          L59 = L53.rx_rate
          L59 = L59 or L59
          L58, L59, L60 = L58(L59)
          L57 = L57(L58, L59, L60)
          L56.downspeed = L57
          L57 = tostring
          L58 = L30.online_timer
          L58 = L58 or L58
          L57 = L57(L58)
          L56.online = L57
          if L55 == 1 or not A0 then
            L57 = table
            L57 = L57.insert
            L58 = L47
            L59 = L56
            L57(L58, L59)
            L57 = L48.online
            if not L57 then
              L57 = L56.online
              L48.online = L57
            end
            L57 = tostring
            L58 = tonumber
            L59 = L48.upspeed
            L59 = L59 or L59
            L58 = L58(L59)
            L59 = tonumber
            L60 = L56.upspeed
            L59 = L59(L60)
            L58 = L58 + L59
            L57 = L57(L58)
            L48.upspeed = L57
            L57 = tostring
            L58 = tonumber
            L59 = L48.downspeed
            L59 = L59 or L59
            L58 = L58(L59)
            L59 = tonumber
            L60 = L56.downspeed
            L59 = L59(L60)
            L58 = L58 + L59
            L57 = L57(L58)
            L48.downspeed = L57
          end
        end
      end
      L34.ip = L47
      L34.statistics = L48
      if L35 and A0 or not A0 then
        L49(L50, L51)
      end
    end
  end
  return L14
end
getDeviceListV2 = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = L1.get_wlan_ifname
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.arrayTransposition
  L4 = L1.get_wlan_guest_ifname
  L4, L5, L6, L7, L8, L9 = L4()
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = _UPVALUE0_
  L4 = L4.arrayTransposition
  L5 = L1.get_wlan_wifi5_ifname
  L5, L6, L7, L8, L9 = L5()
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = L1.getGameWifiSupport
  L5 = L5()
  L6 = 4
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A0
  L7 = L7(L8)
  if L7 then
    L6 = 4
  else
    L7 = L2[1]
    if L7 then
      L7 = L2[1]
      if A0 == L7 then
        L6 = 1
    end
    else
      L7 = L2[2]
      if L7 then
        L7 = L2[2]
        if A0 == L7 then
          if L5 then
            L6 = 6
          else
            L6 = 2
          end
      end
      else
        L7 = L2[3]
        if L7 then
          L7 = L2[3]
          if A0 == L7 then
            L6 = 7
        end
        else
          L7 = L3[A0]
          if L7 then
            L6 = 3
          else
            L7 = L4[A0]
            if L7 then
              L6 = 8
            else
              L8 = A0
              L7 = A0.match
              L9 = "wl"
              L7 = L7(L8, L9)
              if L7 then
                L6 = 2
              end
            end
          end
        end
      end
    end
  end
  return L6
end
function L6(A0, A1)
  local L2, L3, L4
  L2 = {}
  L2[1] = "2.4GHz\230\142\165\229\133\165"
  L2[2] = "5GHz\230\142\165\229\133\165"
  L2[3] = "\232\174\191\229\174\162\230\142\165\229\133\165"
  L2[4] = "\230\156\137\231\186\191\230\142\165\229\133\165"
  L2[6] = "5GHz Game\230\142\165\229\133\165"
  L2[7] = "5GHz-2\230\142\165\229\133\165"
  L2[8] = "IoT\231\189\145\231\187\156\230\142\165\229\133\165"
  L2[9] = "MLO\231\189\145\231\187\156\230\142\165\229\133\165"
  L2[10] = "6GHz\230\142\165\229\133\165"
  if A1 then
    L3 = tonumber
    L4 = A1
    L3 = L3(L4)
    if L3 == 1 then
      L3 = "2.4GHz\227\128\1295GHz\230\142\165\229\133\165"
      return L3
  end
  else
    L3 = L2[A0]
    L3 = L3 or L3
    return L3
  end
end
function L7(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L4 = A1.ifname
  L4 = L4 or L4
  L5 = _UPVALUE0_
  L6 = L4
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQWifiUtil"
  L6 = L6(L7)
  L7 = _UPVALUE1_
  L7 = L7.arrayTransposition
  L8 = L6.get_wlan_guest_ifname
  L8, L9, L10, L11, L12, L13, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29 = L8()
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
  L8 = {}
  L9 = false
  L10 = require
  L11 = "xiaoqiang.module.XQFirewall"
  L10 = L10(L11)
  L11 = L10.getMacfilterInfoDict
  L12 = "wan"
  L11 = L11(L12)
  L12 = require
  L13 = "luci.model.uci"
  L12 = L12(L13)
  L12 = L12.cursor
  L12 = L12()
  L13 = L12.get
  L17 = "mode"
  L13 = L13(L14, L15, L16, L17)
  if A2 ~= "" then
    if A2 ~= L14 then
      return L8
    end
  end
  for L17, L18 in L14, L15, L16 do
    if L19 == 1 then
      L9 = true
      break
    end
  end
  if L9 then
    if L14 then
      goto lbl_59
    end
  end
  ::lbl_59::
  L8.online = L14
  L8.connectionType = L5
  L14[1] = L15
  L8.connectionTypes = L14
  L8.isap = L14
  L8.parent = L14
  L8.mac = A0
  L8.gameFlag = 0
  L8.wifi_quality = 1
  L14.enable = 1
  L14.mode = "none"
  L8.netacctl = L14
  L14.enabled = 0
  L14.total = 0
  L8.pcontrol = L14
  L8.signal = L14
  L8.wifiprotocol = L14
  L8.nego_tx_rate = L14
  L8.nego_rx_rate = L14
  L8.port = L14
  L8.portspeed = L14
  if L11 then
    if L14 then
      if L14 then
        if L14 then
          goto lbl_131
        end
      end
      ::lbl_131::
      L8.wan = L14
  end
  elseif L13 == "black" then
    L8.wan = 1
  else
    L8.wan = 0
  end
  L17 = nil
  L18 = A3.dhcpDict
  L18 = L18[A0]
  if L18 ~= nil then
    L18 = A3.dhcpDict
    L18 = L18[A0]
  end
  L18 = A3.deviceDict
  L18 = L18[A0]
  if L18 then
    if L19 then
    end
  end
  if not L19 then
  end
  if L19 then
    if not L19 then
    end
  end
  if L19 then
  end
  if not L14 then
  end
  L8.name = L19
  if not L15 then
  end
  L8.originName = L19
  for L22, L23 in L19, L20, L21 do
    L24 = false
    L25 = L7[L4]
    if not L25 then
      L25 = A3.lanipPre
      if L25 then
        L25 = L23.ip
        if L25 then
          L25 = L23.ip
          L26 = L25
          L25 = L25.match
          L27 = "^"
          L28 = A3.lanipPre
          L27 = L27 .. L28
          L25 = L25(L26, L27)
          if not L25 then
            L25 = L23.ip
            if L25 ~= "0.0.0.0" then
              goto lbl_220
            end
          end
          L24 = false
          goto lbl_221
          ::lbl_220::
          L24 = true
        end
      end
    end
    ::lbl_221::
    if not L24 then
      L25 = L23.ip
      L8.ip = L25
      L25 = L23.tx_rate
      L8.uSpeed = L25
      L25 = L23.rx_rate
      L8.dSpeed = L25
      L25 = L23.tx_bytes
      L8.totalTX = L25
      L25 = L23.rx_bytes
      L8.totalRX = L25
      L25 = os
      L25 = L25.time
      L25 = L25()
      L26 = {}
      L27 = A1.online_timer
      L27 = L27 or L27
      L26.duration = L27
      L26.eventID = 1
      L27 = A1.online_timer
      L27 = L27 or L27
      L27 = L25 - L27
      L26.originatedTime = L27
      L27 = _UPVALUE2_
      L28 = L5
      L29 = A1.mld
      L29 = L29 or L29
      L27 = L27(L28, L29)
      L26.text = L27
      L26.timeDisplay = 1
      L27 = {}
      L8.events = L27
      L27 = table
      L27 = L27.insert
      L28 = L8.events
      L29 = L26
      L27(L28, L29)
    end
  end
  return L8
end
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = {}
  L4 = "ubus call trafficd hw '{\"wlan\":true,\"port\":true}'"
  L5 = L1.exec
  L6 = L4
  L5 = L5(L6)
  L6 = "ubus call trafficd hw '{\"leaf\": false}'"
  L7 = L1.exec
  L8 = L6
  L7 = L7(L8)
  L8 = require
  L9 = "miqos"
  L8 = L8(L9)
  L9 = L8.cmd
  L10 = "show_limit"
  L9 = L9(L10)
  L10 = {}
  if L9 then
    L11 = L9.status
    if L11 == 0 then
      L11 = L9.data
      if L11 then
        L9 = L9.data
    end
  end
  else
    L9 = nil
  end
  L11 = _UPVALUE0_
  L11 = L11.isStrNil
  L12 = L5
  L11 = L11(L12)
  if L11 then
    return L3
  end
  L11 = _UPVALUE1_
  L11 = L11.decode
  L12 = L5
  L11 = L11(L12)
  L5 = L11
  L11 = {}
  L12 = L2.getLanIpPre
  L12 = L12()
  L11.lanipPre = L12
  L12 = getDHCPDict
  L12 = L12()
  L11.dhcpDict = L12
  L12 = getDeviceInfoFromDB
  L12 = L12()
  L11.deviceDict = L12
  L12 = ""
  if A0 ~= "" then
    if not L13 then
      L7 = L13
      L12 = "unknown-did"
      for L16, L17 in L13, L14, L15 do
        L18 = L17.device_id
        if L18 then
          L18 = L17.device_id
          if L18 == A0 then
            L12 = L16
            break
          end
        end
      end
    end
  end
  for L16, L17 in L13, L14, L15 do
    L18 = _UPVALUE2_
    L19 = _UPVALUE0_
    L19 = L19.macFormat
    L20 = L16
    L19 = L19(L20)
    L20 = L17
    L21 = L12
    L22 = L11
    L18 = L18(L19, L20, L21, L22)
    if L18 ~= nil then
      L19 = L18.isap
      if L19 ~= nil then
        L19 = L18.isap
        if L19 == 8 then
          L18.ip = nil
        end
      end
    end
    L19 = L18.ip
    if L19 ~= nil then
      L19 = {}
      L18.qos_info = L19
      L19 = L18.qos_info
      L20 = _UPVALUE0_
      L20 = L20.macFormat
      L21 = L16
      L20 = L20(L21)
      L19.mac = L20
      if L9 then
        L19 = L18.ip
        L19 = L9[L19]
        if L19 then
          L19 = L18.ip
          L10 = L9[L19]
          L19 = L18.qos_info
          L20 = tonumber
          L21 = L10.DOWN
          L21 = L21.max_per
          L20 = L20(L21)
          L20 = L20 / 8
          L19.downmax = L20
          L19 = L18.qos_info
          L20 = tonumber
          L21 = L10.UP
          L21 = L21.max_per
          L20 = L20(L21)
          L20 = L20 / 8
          L19.upmax = L20
          L19 = L18.qos_info
          L20 = L10.flag
          L19.flag = L20
      end
      else
        L19 = L18.qos_info
        L19.downmax = 0
        L19 = L18.qos_info
        L19.upmax = 0
        L19 = L18.qos_info
        L19.flag = "off"
      end
    end
    L19 = L18.ip
    if L19 ~= nil then
      L19 = table
      L19 = L19.insert
      L20 = L3
      L21 = L18
      L19(L20, L21)
    end
  end
  return L3
end
getDeviceListV3 = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L0 = require
  L1 = "luci.cbi.datatypes"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQPushUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQParentControl"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQFirewall"
  L4 = L4(L5)
  L5 = {}
  L6 = {}
  L7 = {}
  L8 = {}
  L9 = L2.notifyDict
  L9 = L9()
  L10 = getDeviceInfoFromDB
  L10 = L10()
  L11 = L4.getMacfilterInfoDict
  L11 = L11()
  L12 = getDeviceInfoFromConfig
  L12 = L12()
  L13 = L1.getWiFiMacfilterModel
  L13 = L13()
  L14 = {}
  if L13 == 1 then
    if L15 then
      for L19, L20 in L16, L17, L18 do
        L14[L20] = 1
      end
    end
  end
  for L18, L19 in L15, L16, L17 do
    L20 = L0.macaddr
    L20 = L20(L21)
    if L20 then
      L20 = {}
      L20.nickname = L21
      L5[L18] = L20
      L7[L18] = 1
      L20 = table
      L20 = L20.insert
      L20(L21, L22)
    end
  end
  L15.api = 70
  L15.macs = L6
  L19, L20, L24, L25, L26, L27, L28, L29 = L17(L18)
  if L16 then
    if L17 == 0 then
      L8 = L16.canAccessAllDisk
    end
  end
  L19 = L7
  L19 = L3.get_urlfilter_info
  L20 = L7
  L19 = L19(L20)
  L20 = {}
  for L24, L25 in L21, L22, L23 do
    L26 = L11[L24]
    L27 = L12[L24]
    L28 = L9[L24]
    if L28 then
      L25.push = 1
    else
      L25.push = 0
    end
    L28 = L17[L24]
    L25.pcontrol = L28
    L28 = L18[L24]
    L25.netacctl = L28
    L28 = L19[L24]
    L25.urlfilter = L28
    if L26 then
      L28 = L26.wan
      if L28 then
        L28 = 1
        if L28 then
          goto lbl_121
        end
      end
      L28 = 0
      ::lbl_121::
      L25.wan = L28
      L28 = L26.lan
      if L28 then
        L28 = 1
        if L28 then
          goto lbl_129
        end
      end
      L28 = 0
      ::lbl_129::
      L25.lan = L28
      L28 = L26.admin
      if L28 then
        L28 = 1
        if L28 then
          goto lbl_137
        end
      end
      L28 = 0
      ::lbl_137::
      L25.admin = L28
      L28 = L26.pridisk
      if L28 then
        L28 = 1
        if L28 then
          goto lbl_145
        end
      end
      L28 = 0
      ::lbl_145::
      L25.pridisk = L28
    else
      L25.wan = 1
      L25.lan = 1
      L25.admin = 1
      L25.pridisk = 0
    end
    L28 = L14[L24]
    if L28 == 1 then
      L25.limited = 1
    else
      L25.limited = 0
    end
    if L27 then
      L28 = L27.owner
      L28 = L28 or L28
      L25.owner = L28
      L28 = L27.device
      L28 = L28 or L28
      L25.device = L28
    else
      L25.owner = ""
      L25.device = ""
    end
    L28 = L8[L24]
    if L28 ~= nil then
      L28 = L8[L24]
      if L28 then
        L28 = 1
        if L28 then
          goto lbl_182
        end
      end
      L28 = 0
      ::lbl_182::
      L25.lan = L28
    end
    L28 = "device/"
    L29 = L24
    L28 = L28 .. L29
    L20[L28] = L25
  end
  return L20
end
devicesInfo = L8
