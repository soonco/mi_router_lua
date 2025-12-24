local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.module.XQEcos"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = {}
L3.R01 = 1
L3.R02 = 1
L3.R03 = 1
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = _UPVALUE0_
  L0 = L0.exec
  L1 = "ubus call trafficd hw"
  L0 = L0(L1)
  L1 = _UPVALUE1_
  L1 = L1.isStrNil
  L1 = L1(L2)
  if L1 then
    L1 = {}
    return L1
  end
  L1 = {}
  L0 = L2
  for L5, L6 in L2, L3, L4 do
    L7, L8 = nil, nil
    L9 = L6.description
    if L9 then
      L9 = pcall
      L10 = _UPVALUE2_
      L10 = L10.decode
      L11 = L6.description
      L9, L10 = L9(L10, L11)
      L8 = L10
      L7 = L9
    end
    if L7 and L8 then
      L9 = L8.hardware
      if L9 then
        L9 = _UPVALUE3_
        L10 = L8.hardware
        L9 = L9[L10]
        if L9 then
          L9 = L6.version
          if L9 then
            L9 = tonumber
            L10 = L6.is_ap
            L9 = L9(L10)
            if L9 ~= 0 then
              L9 = tonumber
              L10 = L6.assoc
              L9 = L9(L10)
              if L9 == 1 then
                L9 = {}
                L9.mac = L5
                L10 = L6.version
                L9.version = L10
                L9.channel = "current"
                L10 = L8.color
                L10 = L10 or L10
                L9.color = L10
                L10 = L8.sn
                L10 = L10 or L10
                L9.sn = L10
                L10 = L8.country_code
                L10 = L10 or L10
                L9.ctycode = L10
                L10 = L6.ip_list
                L11 = #L10
                if 0 < L11 then
                  L11 = L10[1]
                  L11 = L11.ip
                  L9.ip = L11
                end
                L11 = L8.channel
                L11 = L11 or L11
                L9.channel = L11
                L11 = L9.ip
                if L11 then
                  L1[L5] = L9
                end
              end
            end
          end
        end
      end
    end
  end
  return L1
end
_getEcosDevices = L4
function L4(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = L1.getWifiDeviceSignal
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  if L2 then
    if L2 < -70 then
      L3 = 3
      return L3
    elseif -60 < L2 then
      L3 = 1
      return L3
    else
      L3 = 2
      return L3
    end
  end
  L3 = nil
  return L3
end
_getEcosSignal = L4
function L4(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = L1.getWifiDeviceSignal
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L2 = L2 or L2
  return L2
end
_getEcosSignalDB = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = require
  L5 = "xiaoqiang.util.XQNetUtil"
  L4 = L4(L5)
  L5 = L4.checkEcosUpgrade
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = L5.needUpdate
    if L6 == 1 then
      return L5
  end
  else
    L6 = nil
    return L6
  end
end
_getEcosUpgrade = L4
function L4(A0)
  local L1, L2, L3, L4
  if not A0 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = "tbus call "
  L3 = A0
  L4 = " desc \"{\\\"desc\\\":1}\" 2>/dev/null"
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  if L1 then
    L2 = pcall
    L3 = _UPVALUE1_
    L3 = L3.decode
    L4 = L1
    L2, L3 = L2(L3, L4)
    if L2 then
      L4 = L3.switch_wifi_explorer
      L4 = L4 or L4
      return L4
    end
  end
  L2 = 0
  return L2
end
_getEcosWRoamingStatus = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = {}
  L2 = _getEcosDevices
  L2 = L2()
  L3 = L2[A0]
  if L3 then
    L4 = _getEcosUpgrade
    L5 = L3.version
    L6 = L3.channel
    L7 = L3.sn
    L8 = L3.ctycode
    L4 = L4(L5, L6, L7, L8)
    if L4 then
      L1.upgrade = true
      L1.upgradeinfo = L4
    else
      L1.upgrade = false
    end
    L5 = _getEcosSignal
    L6 = A0
    L5 = L5(L6)
    L5 = L5 or L5
    L1.signal = L5
    L5 = _getEcosSignalDB
    L6 = A0
    L5 = L5(L6)
    L1.signalDB = L5
    L5 = _getEcosWRoamingStatus
    L6 = L3.ip
    L5 = L5(L6)
    L5 = L5 or L5
    L1.roaming = L5
    L5 = L3.version
    L1.version = L5
    L5 = L3.channel
    L1.channel = L5
    L5 = L3.color
    L1.color = L5
    L5 = L3.ip
    L1.ip = L5
    return L1
  else
    L4 = nil
    return L4
  end
end
getEcosInfo = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _getEcosDevices
  L2 = L2()
  L3 = L2[A0]
  if L3 then
    L4 = "tbus call "
    L5 = L3.ip
    L6 = " switch \"{\\\"wifi_explorer\\\":"
    if A1 then
      L7 = "1"
      if L7 then
        goto lbl_15
      end
    end
    L7 = "0"
    ::lbl_15::
    L8 = "}\" >/dev/null 2>/dev/null"
    L4 = L4 .. L5 .. L6 .. L7 .. L8
    L5 = os
    L5 = L5.execute
    L6 = L4
    L5 = L5(L6)
    L5 = L5 == 0
    return L5
  end
  L4 = false
  return L4
end
ecosWirelessRoamingSwitch = L4
function L4(A0)
  local L1, L2, L3
  if A0 then
    L1 = os
    L1 = L1.execute
    L2 = "echo 1 > /tmp/"
    L3 = A0
    L2 = L2 .. L3
    L1(L2)
    L1 = "lua /usr/sbin/ecos_upgrade.lua "
    L2 = A0
    L3 = " 2>/dev/null"
    L1 = L1 .. L2 .. L3
    L2 = _UPVALUE0_
    L2 = L2.forkExec
    L3 = L1
    L2(L3)
  end
end
ecosUpgrade = L4
function L4(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = require
    L2 = "nixio.fs"
    L1 = L1(L2)
    L2 = "/tmp/"
    L3 = A0
    L2 = L2 .. L3
    L3 = L1.readfile
    L4 = L2
    L3 = L3(L4)
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    if L4 then
      L4 = tonumber
      L5 = L3
      return L4(L5)
    end
  end
  L1 = 0
  return L1
end
ecosUpgradeStatus = L4
