local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.util.XQSysUtil"
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
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.get
  L1 = "PRIVACY"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0
  L1 = L1(L2)
  if L1 then
    L1 = tonumber
    L2 = L0
    L1 = L1(L2)
    if L1 == 1 then
      L1 = true
      return L1
  end
  else
    L1 = false
    return L1
  end
end
getPrivacy = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = "1"
    if L1 then
      goto lbl_7
    end
  end
  L1 = "0"
  ::lbl_7::
  L2 = getHardware
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.XQPreference"
  L3 = L3(L4)
  L3 = L3.set
  L4 = "PRIVACY"
  L5 = L1
  L3(L4, L5)
end
setPrivacy = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = L0.get
  L2 = "ap_hostname"
  L1 = L1(L2)
  L1 = L1 or L1
  L2 = string
  L2 = L2.lower
  L3 = L1
  L2 = L2(L3)
  L1 = L2
  L3 = L1
  L2 = L1.match
  L4 = "^miwifi"
  L2 = L2(L3, L4)
  if L2 then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
isMiWiFi = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.get
  L1 = "CONFUPLOAD_ENABLE"
  L0 = L0(L1)
  if L0 then
    L1 = tonumber
    L2 = L0
    L1 = L1(L2)
    if L1 == 1 then
      L1 = true
      return L1
  end
  else
    L1 = false
    return L1
  end
end
getConfUploadEnable = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = L1.set
  L3 = "CONFUPLOAD_ENABLE"
  if A0 then
    L4 = "1"
    if L4 then
      goto lbl_12
    end
  end
  L4 = "0"
  ::lbl_12::
  L2(L3, L4)
end
setConfUploadEnable = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.util.XQSynchrodata"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = getConfUploadEnable
  L5 = L5()
  if L5 then
    if A0 then
      L5 = A0.ssid_24G
      if L5 then
        goto lbl_30
      end
    end
    L5 = L3.getWifiBasicInfo
    L6 = 1
    L5 = L5(L6)
    L6 = L5.ssid
    L4.ssid_24G = L6
    L6 = L5.password
    L4.wifi_24G_password = L6
    goto lbl_40
    ::lbl_30::
    L5 = A0.ssid_24G
    L5 = L5 or L5
    L4.ssid_24G = L5
    L5 = A0.wifi_24G_password
    L5 = L5 or L5
    L4.wifi_24G_password = L5
    ::lbl_40::
    if A0 then
      L5 = A0.pppoe_name
      if L5 then
        goto lbl_73
      end
    end
    L6 = L1
    L5 = L1.get
    L7 = "network"
    L8 = "wan"
    L9 = "proto"
    L5 = L5(L6, L7, L8, L9)
    if L5 and L5 == "pppoe" then
      L7 = L1
      L6 = L1.get
      L8 = "network"
      L9 = "wan"
      L10 = "username"
      L6 = L6(L7, L8, L9, L10)
      L6 = L6 or L6
      L8 = L1
      L7 = L1.get
      L9 = "network"
      L10 = "wan"
      L11 = "password"
      L7 = L7(L8, L9, L10, L11)
      L7 = L7 or L7
      L4.pppoe_name = L6
      L4.pppoe_password = L7
      goto lbl_83
      ::lbl_73::
      L5 = A0.pppoe_name
      L5 = L5 or L5
      L4.pppoe_name = L5
      L5 = A0.pppoe_password
      L5 = L5 or L5
      L4.pppoe_password = L5
    end
    ::lbl_83::
    L5 = L2.uploadConf
    L6 = L4
    L5(L6)
  end
end
doConfUpload = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = {}
  L0.name = ""
  L0.hardware = ""
  L0.color = ""
  L0.version = ""
  L0.ip = ""
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = L1.get
  L3 = "vendorinfo"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    return L0
  end
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = L3.split
  L5 = L2
  L6 = "-"
  L4 = L4(L5, L6)
  L5 = L1.get
  L6 = "ap_hostname"
  L5 = L5(L6)
  L5 = L5 or L5
  L0.name = L5
  L5 = L4[2]
  L5 = L5 or L5
  L0.hardware = L5
  L5 = L4[3]
  L5 = L5 or L5
  L0.version = L5
  L5 = L4[4]
  L5 = L5 or L5
  L0.color = L5
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L0.color
  L5 = L5(L6)
  if L5 then
    L0.color = "101"
  end
  L5 = L1.get
  L6 = "CAP_MODE"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L8 = L6
  L7 = L6.get
  L9 = "xiaoqiang"
  L10 = "common"
  L11 = "NETMODE"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  if L5 ~= nil then
    L9 = L5
    L8 = L5.match
    L10 = "^ap"
    L8 = L8(L9, L10)
    if L8 then
      L9 = L7
      L8 = L7.match
      L10 = "^whc_re"
      L8 = L8(L9, L10)
      if L8 then
        L9 = L6
        L8 = L6.get
        L10 = "xiaoqiang"
        L11 = "common"
        L12 = "CAP_IP"
        L8 = L8(L9, L10, L11, L12)
        L0.ip = L8
        return L0
      end
    end
  end
  L8 = _UPVALUE0_
  L8 = L8.getNetModeType
  L8 = L8()
  if L8 == 0 then
    L8 = require
    L9 = "ubus"
    L8 = L8(L9)
    L8 = L8.connect
    L8 = L8()
    L10 = L8
    L9 = L8.call
    L11 = "network.interface.wan"
    L12 = "status"
    L13 = {}
    L9 = L9(L10, L11, L12, L13)
    if L9 then
      L10 = L9.route
      if L10 then
        L10 = L9.route
        L10 = L10[1]
        if L10 then
          L10 = L9.route
          L10 = L10[1]
          L10 = L10.nexthop
          if L10 then
            L10 = L9.route
            L10 = L10[1]
            L10 = L10.nexthop
            L0.ip = L10
          end
        end
      end
    end
  else
    L8 = require
    L9 = "luci.model.uci"
    L8 = L8(L9)
    L8 = L8.cursor
    L8 = L8()
    L10 = L8
    L9 = L8.get
    L11 = "network"
    L12 = "lan"
    L13 = "gateway"
    L9 = L9(L10, L11, L12, L13)
    L9 = L9 or L9
    L0.ip = L9
  end
  return L0
end
getVendorInfo = L2
function L2()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.get
  L1 = _UPVALUE0_
  L1 = L1.PREF_IS_INITED
  L0 = L0(L1)
  if L0 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
getInitInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L4 = "mesh"
  L5 = "version"
  versionlist = L1
  max_version = L1
  if L1 then
    for L4, L5 in L1, L2, L3 do
      L6 = tonumber
      L7 = L5
      L6 = L6(L7)
      L7 = max_version
      if L6 > L7 then
        L6 = tonumber
        L7 = L5
        L6 = L6(L7)
        max_version = L6
      end
    end
    L4 = "common"
    L5 = "MESH_VERSION"
    L6 = max_version
    L1(L2, L3, L4, L5, L6)
    L1(L2, L3)
  end
end
initMeshVersion = L2
function L2()
  local L0, L1, L2
  L0 = initMeshVersion
  L0()
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.set
  L1 = _UPVALUE0_
  L1 = L1.PREF_IS_INITED
  L2 = "YES"
  L0(L1, L2)
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "/usr/sbin/sysapi webinitrdr set off"
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "[ -f /usr/sbin/wan_check.sh ] && /usr/sbin/wan_check.sh reset"
  L1(L2)
  L1 = L0.exec
  L2 = "[ -f /etc/init.d/meshd ] && /etc/init.d/meshd restart"
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/etc/init.d/xunlei restart"
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/etc/init.d/local_gw_security restart"
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/usr/sbin/set_wps_state 2"
  L1(L2)
  L1 = true
  return L1
end
setInited = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "mkxqimage -I"
  L1 = L1(L2)
  if L1 then
    L2 = require
    L3 = "luci.sys"
    L2 = L2(L3)
    L3 = L0.trim
    L4 = L1
    L3 = L3(L4)
    L1 = L3
    L3 = L2.user
    L3 = L3.setpasswd
    L4 = "root"
    L5 = L1
    L3(L4, L5)
  end
end
setSPwd = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L0.access
  L3 = _UPVALUE0_
  L3 = L3.XQ_CHANGELOG_FILEPATH
  L2 = L2(L3)
  if L2 then
    L2 = L1.exec
    L3 = "cat "
    L4 = _UPVALUE0_
    L4 = L4.XQ_CHANGELOG_FILEPATH
    L3 = L3 .. L4
    return L2(L3)
  end
  L2 = ""
  return L2
end
getChangeLog = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = tostring
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "bbs"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L1.bbs = L2
  L2 = tostring
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "cpufreq"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L1.cpufreq = L2
  L2 = tostring
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "verify"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L1.verify = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "gpio"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  if L2 == 1 then
    L2 = 1
    if L2 then
      goto lbl_44
    end
  end
  L2 = 0
  ::lbl_44::
  L1.gpio = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "recovery"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  if L2 == 1 then
    L2 = 1
    if L2 then
      goto lbl_58
    end
  end
  L2 = 0
  ::lbl_58::
  L1.recovery = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "misc"
  L6 = "hardware"
  L7 = "flash_per"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  if L2 == 1 then
    L2 = 1
    if L2 then
      goto lbl_72
    end
  end
  L2 = 0
  ::lbl_72::
  L1.flashpermission = L2
  L3 = L0
  L2 = L0.get
  L4 = "misc"
  L5 = "hardware"
  L6 = "memsize"
  L2 = L2(L3, L4, L5, L6)
  L1.memsize = L2
  return L1
end
getMiscHardwareInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "special_region_en"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 or L1 == "0" then
    L2 = 0
    return L2
  end
  L2 = 1
  return L2
end
specialRegionEnable = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = L0.get
  L2 = _UPVALUE0_
  L2 = L2.PREF_IS_PASSPORT_BOUND
  L1 = L1(L2)
  L2 = L0.get
  L3 = _UPVALUE0_
  L3 = L3.PREF_PASSPORT_BOUND_UUID
  L4 = ""
  L2 = L2(L3, L4)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if not L3 and L1 == "YES" then
    L3 = _UPVALUE1_
    L3 = L3.isStrNil
    L4 = L2
    L3 = L3(L4)
    if not L3 then
      return L2
  end
  else
    L3 = false
    return L3
  end
end
getPassportBindInfo = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = require
  L3 = "xiaoqiang.XQPreference"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDBUtil"
  L3 = L3(L4)
  if A0 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = A1
    L4 = L4(L5)
    if not L4 then
      L4 = L2.set
      L5 = _UPVALUE1_
      L5 = L5.PREF_PASSPORT_BOUND_UUID
      L6 = A1
      L4(L5, L6)
    end
    L4 = L2.set
    L5 = _UPVALUE1_
    L5 = L5.PREF_IS_PASSPORT_BOUND
    L6 = "YES"
    L4(L5, L6)
    L4 = L2.set
    L5 = _UPVALUE1_
    L5 = L5.PREF_TIMESTAMP
    L6 = "0"
    L4(L5, L6)
  else
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = A1
    L4 = L4(L5)
    if not L4 then
      L4 = L2.set
      L5 = _UPVALUE1_
      L5 = L5.PREF_PASSPORT_BOUND_UUID
      L6 = ""
      L4(L5, L6)
    end
    L4 = L2.set
    L5 = _UPVALUE1_
    L5 = L5.PREF_IS_PASSPORT_BOUND
    L6 = "NO"
    L4(L5, L6)
    L4 = L2.set
    L5 = _UPVALUE1_
    L5 = L5.PREF_BOUND_USERINFO
    L6 = ""
    L4(L5, L6)
  end
  L4 = true
  return L4
end
setPassportBound = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "redmi"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "1" then
    L2 = "Redmi"
    return L2
  else
    L2 = "Xiaomi"
    return L2
  end
end
getBrandInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = "cat /proc/uptime"
  L2 = L0.exec
  L3 = L1
  L2 = L2(L3)
  if L2 == nil then
    L3 = 0
    return L3
  else
    L4 = L2
    L3 = L2.match
    L5 = "^(%S+) (%S+)"
    L3, L4 = L3(L4, L5)
    L5 = L0.trim
    L6 = L3
    return L5(L6)
  end
end
getSysUptime = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "cat /etc/config/*"
  return L1(L2)
end
getConfigInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = L0.get
  L2 = _UPVALUE0_
  L2 = L2.PREF_ROUTER_NAME
  L3 = ""
  L1 = L1(L2, L3)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = L2.xssCheck
  L4 = L1
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE1_
    L4 = L4.isStrNil
    L5 = L1
    L4 = L4(L5)
    if not L4 then
      goto lbl_37
    end
  end
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = L4.getWifiStatus
  L6 = 1
  L5 = L5(L6)
  L6 = L5.ssid
  L1 = L6 or L1
  if not L6 then
    L1 = ""
  end
  ::lbl_37::
  return L1
end
getRouterName = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = L1.xssCheck
  L3 = A0
  L2 = L2(L3)
  if L2 == nil then
    L3 = false
    return L3
  end
  if A0 then
    L3 = require
    L4 = "xiaoqiang.util.XQSynchrodata"
    L3 = L3(L4)
    L4 = L3.syncRouterName
    L5 = A0
    L4(L5)
    L4 = require
    L5 = "xiaoqiang.XQPreference"
    L4 = L4(L5)
    L4 = L4.set
    L5 = _UPVALUE0_
    L5 = L5.PREF_ROUTER_NAME
    L6 = A0
    L4(L5, L6)
    L4 = setRouterNamePending
    L5 = "1"
    L4(L5)
    L4 = true
    return L4
  else
    L3 = false
    return L3
  end
end
setRouterName = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = L0.get
  L2 = "ROUTER_LOCALE"
  L1 = L1(L2)
  L1 = L1 or L1
  return L1
end
getRouterLocale = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  if A0 then
    L2 = require
    L3 = "xiaoqiang.util.XQSynchrodata"
    L2 = L2(L3)
    L3 = L2.syncRouterLocale
    L4 = A0
    L3(L4)
    L3 = L1.set
    L4 = "ROUTER_LOCALE"
    L5 = A0
    L3(L4, L5)
  end
end
setRouterLocale = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.get
  L1 = _UPVALUE0_
  L1 = L1.PREF_ROUTER_NAME_PENDING
  L2 = "0"
  return L0(L1, L2)
end
getRouterNamePending = L2
function L2(A0)
  local L1, L2, L3
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L1 = L1.set
  L2 = _UPVALUE0_
  L2 = L2.PREF_ROUTER_NAME_PENDING
  L3 = A0
  return L1(L2, L3)
end
setRouterNamePending = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L0 = L0.get
  L1 = _UPVALUE0_
  L1 = L1.PREF_PASSPORT_BOUND_UUID
  L2 = ""
  return L0(L1, L2)
end
getBindUUID = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_NVRAM_SN
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
  end
  return L1
end
getSN = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ISP_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getIspVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ROM_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getRomVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.getFeature
  L1 = "0"
  L2 = "system"
  L3 = "cpe"
  L0 = L0(L1, L2, L3)
  if L0 == "1" then
    L0 = getIspVersion
    L0 = L0()
    L1 = _UPVALUE0_
    L1 = L1.isStrNil
    L2 = L0
    L1 = L1(L2)
    if not L1 then
      return L0
    end
  end
  L0 = getRomVersion
  return L0()
end
getDisplayRomVersion = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ROM_BUILDTIME
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  else
    L2 = os
    L2 = L2.date
    L3 = "%Y/%m/%d"
    L4 = tonumber
    L5 = L1
    L4, L5 = L4(L5)
    L2 = L2(L3, L4, L5)
    L1 = L2
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getRomBuildtime = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_CHANNEL
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getChannel = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.getGpioValue
  L1 = 14
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.getGpioValue
  L2 = 13
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.getGpioValue
  L3 = 12
  L2 = L2(L3)
  L3 = L0 * 4
  L4 = L1 * 2
  L3 = L3 + L4
  L3 = L3 + L2
  L4 = string
  L4 = L4.char
  L5 = 65 + L3
  L4 = L4(L5)
  L5 = "Ver."
  L6 = L4
  L5 = L5 .. L6
  return L5
end
getHardwareVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_HARDWARE
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
  end
  L2 = getMiscHardwareInfo
  L2 = L2()
  L3 = L2.gpio
  if L3 == 1 then
    L3 = getHardwareVersion
    return L3()
  end
  return L1
end
getHardwareGPIO = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_HARDWARE
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
  end
  return L1
end
getHardware = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_CFE_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getCFEVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_KERNEL_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getKernelVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_RAMFS_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getRamFsVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_SQAFS_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getSqaFsVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ROOTFS_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getRootFsVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_HW_VERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getHWVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ISP_CODE
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getISPCode = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = "mkxqimage -V "
  L4 = A0
  L5 = " | grep ISPCODE | awk '{print $3}' | sed \"s/'//g\""
  L3 = L3 .. L4 .. L5
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L2 = ""
  end
  L3 = L1.trim
  L4 = L2
  return L3(L4)
end
getImageIspcode = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_BETA
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getBeta = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.config"
  L1 = L1(L2)
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = type
    L9 = L7
    L8 = L8(L9)
    if L8 == "string" then
      L9 = L6
      L8 = L6.sub
      L10 = 1
      L11 = 1
      L8 = L8(L9, L10, L11)
      if L8 ~= "." then
        L8 = {}
        L8.lang = L6
        L8.name = L7
        L9 = table
        L9 = L9.insert
        L10 = L2
        L11 = L8
        L9(L10, L11)
      end
    end
  end
  return L2
end
getLangList = L2
function L2()
  local L0, L1
  L0 = require
  L1 = "luci.config"
  L0 = L0(L1)
  L1 = L0.main
  L1 = L1.lang
  return L1
end
getLang = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.config"
  L3 = L3(L4)
  L4 = L2.cursor
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.XQCountryCode"
  L5 = L5(L6)
  L6 = L5.getCurrentCountryCode
  L6 = L6()
  for L10, L11 in L7, L8, L9 do
    L12 = type
    L13 = L11
    L12 = L12(L13)
    if L12 == "string" then
      L13 = L10
      L12 = L10.sub
      L14 = 1
      L15 = 1
      L12 = L12(L13, L14, L15)
      if L12 ~= "." and (A0 == L10 or A0 == "auto") then
        if A0 == "auto" then
          L13 = L4
          L12 = L4.set
          L14 = "luci"
          L15 = "main"
          L16 = "lang"
          L17 = "auto"
          L12(L13, L14, L15, L16, L17)
        else
          L13 = L4
          L12 = L4.set
          L14 = "luci"
          L15 = "main"
          L16 = "lang"
          L17 = L10
          L12(L13, L14, L15, L16, L17)
        end
        L13 = L4
        L12 = L4.commit
        L14 = "luci"
        L12(L13, L14)
        L13 = L4
        L12 = L4.save
        L14 = "luci"
        L12(L13, L14)
        L12 = true
        return L12
      end
    end
  end
  if L6 ~= "CN" then
    L10 = "main"
    L11 = "lang"
    L12 = "en"
    L7(L8, L9, L10, L11, L12)
    L7(L8, L9)
    L7(L8, L9)
    return L7
  else
    return L7
  end
end
setLang = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.bdataGet
  L5 = "CountryCode"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.XQCountryCode"
  L5 = L5(L6)
  L7 = L3
  L6 = L3.get
  L8 = "country_mapping"
  L9 = A0
  L10 = "region"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  if L6 == "" then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A2
    L7 = L7(L8)
    if L7 then
      L7 = true
      return L7
    else
      L7 = string
      L7 = L7.upper
      L8 = A2
      L7 = L7(L8)
      A2 = L7
      L6 = A2
      L8 = L3
      L7 = L3.get
      L9 = "region_mapping"
      L10 = L6
      L11 = "CountryCode"
      L7 = L7(L8, L9, L10, L11)
      A0 = L7 or A0
      if not L7 then
        A0 = ""
      end
    end
  end
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A0
  L7 = L7(L8)
  if L7 then
    L7 = true
    return L7
  end
  if nil == A1 then
    A1 = true
  end
  L7 = _UPVALUE0_
  L7 = L7.nvramSet
  L8 = "CountryCode"
  L9 = A0
  L7(L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.nvramCommit
  L7()
  L7 = "server_"
  L8 = L6
  L7 = L7 .. L8
  server_name = L7
  L8 = L3
  L7 = L3.get
  L9 = "server_mapping"
  L10 = server_name
  L11 = "API"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  if L7 == "" then
    L8 = true
    return L8
  end
  L9 = L3
  L8 = L3.set
  L10 = "miwifi"
  L11 = "server"
  L12 = "API"
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.get
  L10 = "server_mapping"
  L11 = server_name
  L12 = "LOG"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  if L8 ~= "" then
    L10 = L3
    L9 = L3.set
    L11 = "miwifi"
    L12 = "server"
    L13 = "LOG"
    L14 = L8
    L9(L10, L11, L12, L13, L14)
  else
    L10 = L3
    L9 = L3.delete
    L11 = "miwifi"
    L12 = "server"
    L13 = "LOG"
    L9(L10, L11, L12, L13)
  end
  L10 = L3
  L9 = L3.get
  L11 = "server_mapping"
  L12 = server_name
  L13 = "S"
  L9 = L9(L10, L11, L12, L13)
  L9 = L9 or L9
  if L9 ~= "" then
    L11 = L3
    L10 = L3.set
    L12 = "miwifi"
    L13 = "server"
    L14 = "S"
    L15 = L9
    L10(L11, L12, L13, L14, L15)
  else
    L11 = L3
    L10 = L3.delete
    L12 = "miwifi"
    L13 = "server"
    L14 = "S"
    L10(L11, L12, L13, L14)
  end
  L11 = L3
  L10 = L3.get
  L12 = "server_mapping"
  L13 = server_name
  L14 = "APP"
  L10 = L10(L11, L12, L13, L14)
  L10 = L10 or L10
  if L10 ~= "" then
    L12 = L3
    L11 = L3.set
    L13 = "miwifi"
    L14 = "server"
    L15 = "APP"
    L16 = L10
    L11(L12, L13, L14, L15, L16)
  else
    L12 = L3
    L11 = L3.delete
    L13 = "miwifi"
    L14 = "server"
    L15 = "APP"
    L11(L12, L13, L14, L15)
  end
  L12 = L3
  L11 = L3.get
  L13 = "server_mapping"
  L14 = server_name
  L15 = "STUN"
  L11 = L11(L12, L13, L14, L15)
  L11 = L11 or L11
  if L11 ~= "" then
    L13 = L3
    L12 = L3.set
    L14 = "miwifi"
    L15 = "server"
    L16 = "STUN"
    L17 = L11
    L12(L13, L14, L15, L16, L17)
  else
    L13 = L3
    L12 = L3.delete
    L14 = "miwifi"
    L15 = "server"
    L16 = "STUN"
    L12(L13, L14, L15, L16)
  end
  L13 = L3
  L12 = L3.get
  L14 = "server_mapping"
  L15 = server_name
  L16 = "BROKER"
  L12 = L12(L13, L14, L15, L16)
  L12 = L12 or L12
  if L12 ~= "" then
    L14 = L3
    L13 = L3.set
    L15 = "miwifi"
    L16 = "server"
    L17 = "BROKER"
    L18 = L12
    L13(L14, L15, L16, L17, L18)
  else
    L14 = L3
    L13 = L3.delete
    L15 = "miwifi"
    L16 = "server"
    L17 = "BROKER"
    L13(L14, L15, L16, L17)
  end
  L14 = L3
  L13 = L3.commit
  L15 = "miwifi"
  L13(L14, L15)
  if L4 == "UK" then
    L13 = L5.isCountryAS
    L14 = A0
    L13 = L13(L14)
    if L13 then
      L13 = "MY"
      wifiCountry = L13
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi0"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi1"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi2"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.commit
      L15 = "wireless"
      L13(L14, L15)
    end
    if A0 == "GB" then
      L13 = "GB"
      wifiCountry = L13
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi0"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi1"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi2"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.commit
      L15 = "wireless"
      L13(L14, L15)
    end
  end
  if L4 == "EU" then
    L13 = L5.isCountryETSI_special
    L14 = A0
    L13 = L13(L14)
    if L13 then
      wifiCountry = A0
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi0"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi1"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.set
      L15 = "wireless"
      L16 = "wifi2"
      L17 = "country"
      L18 = wifiCountry
      L13(L14, L15, L16, L17, L18)
      L14 = L3
      L13 = L3.commit
      L15 = "wireless"
      L13(L14, L15)
    end
  end
  L13 = require
  L14 = "luci.util"
  L13 = L13(L14)
  if A1 then
    L14 = L13.exec
    L15 = "sleep 2;/etc/init.d/messagingagent.sh restart > /dev/null 2>&1"
    L14(L15)
  end
  L14 = L13.exec
  L15 = "/etc/init.d/timezone start > /dev/null 2>&1"
  L14(L15)
  L14 = true
  return L14
end
setLocation = L2
function L2()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.nvramGet
  L1 = "CountryCode"
  L2 = "DE"
  L0 = L0(L1, L2)
  if L0 == "EU" or L0 == "" then
    L0 = "DE"
  end
  return L0
end
getLocation = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.sys"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = L1.savePlaintextPwd
  L3 = "admin"
  L4 = "admin"
  L2(L3, L4)
end
setSysPasswordDefault = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = L1.user
  L2 = L2.checkpasswd
  L3 = "root"
  L4 = A0
  return L2(L3, L4)
end
checkSysPassword = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = L1.user
  L3 = L3.setpasswd
  L4 = "root"
  L5 = A0
  L3 = L3(L4, L5)
  check = L3
  L3 = L2.savePlaintextPwd
  L4 = "admin"
  L5 = A0
  L3(L4, L5)
  L3 = check
  if L3 == 0 then
    L3 = true
    return L3
  else
    L3 = require
    L4 = "luci.util"
    L3 = L3(L4)
    L4 = L3.exec
    L5 = "rm /etc/passwd+"
    L4(L5)
  end
  L3 = false
  return L3
end
setSysPassword = L2
function L2(A0)
  local L1, L2, L3
  if not A0 then
    L1 = false
    return L1
  end
  L1 = os
  L1 = L1.execute
  L2 = _UPVALUE0_
  L2 = L2.XQ_CUT_IMAGE
  L3 = A0
  L2 = L2 .. L3
  L1 = L1(L2)
  if 0 == L1 or 127 == L1 then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
cutImage = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = getISPCode
  L1 = L1()
  L2 = getImageIspcode
  L3 = A0
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  if L1 ~= L2 then
    L4 = L3.log
    L5 = 6
    L6 = "cpe_verifyImage failed: ispcode("
    L7 = L1
    L8 = "), imageIspcode("
    L9 = L2
    L10 = ")"
    L6 = L6 .. L7 .. L8 .. L9 .. L10
    L4(L5, L6)
    L4 = false
    return L4
  end
  L4 = L3.log
  L5 = 6
  L6 = "cpe_verifyImage: ispcode "
  L7 = L1
  L6 = L6 .. L7
  L4(L5, L6)
  L4 = true
  return L4
end
cpe_verifyImage = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.getFeature
  L2 = "0"
  L3 = "system"
  L4 = "cpe"
  L1 = L1(L2, L3, L4)
  if L1 == "1" then
    L1 = cpe_verifyImage
    L2 = A0
    return L1(L2)
  end
  L1 = true
  return L1
end
ota_verifyImage = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if not A0 then
    L2 = false
    return L2
  end
  L2 = getMiscHardwareInfo
  L2 = L2()
  L3 = os
  L3 = L3.execute
  L4 = L2.verify
  L5 = "'"
  L6 = A0
  L7 = "' > /dev/null"
  L4 = L4 .. L5 .. L6 .. L7
  L3 = L3(L4)
  if 0 == L3 then
    if A1 then
      L3 = ota_verifyImage
      L4 = A0
      L3 = L3(L4)
      if not L3 then
        L3 = false
        return L3
      end
    end
    L3 = os
    L3 = L3.execute
    L4 = "/usr/sbin/secboot_upgrade_check.sh fail_return "
    L5 = A0
    L6 = " > /dev/null"
    L4 = L4 .. L5 .. L6
    L3 = L3(L4)
    if 0 ~= L3 then
      L3 = false
      return L3
    end
    L3 = true
    return L3
  end
  L3 = false
  return L3
end
verifyImage = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  if not (A0 and A1) or not A2 then
    L3 = false
    return L3
  end
  L3 = os
  L3 = L3.execute
  L4 = "cd /tmp;verifycpeimage -h "
  L5 = A0
  L6 = " -m "
  L7 = A1
  L8 = " -s "
  L9 = A2
  L10 = " > /dev/null"
  L4 = L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10
  L3 = L3(L4)
  if 0 == L3 then
    L3 = true
    return L3
  else
    L3 = false
    return L3
  end
end
verifyCPEImage = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = string
  L1 = L1.format
  L2 = "%02x%02x%02x%02x"
  L4 = A0
  L3 = A0.byte
  L5 = 4
  L3 = L3(L4, L5)
  L5 = A0
  L4 = A0.byte
  L6 = 3
  L4 = L4(L5, L6)
  L6 = A0
  L5 = A0.byte
  L7 = 2
  L5 = L5(L6, L7)
  L7 = A0
  L6 = A0.byte
  L8 = 1
  L6, L7, L8 = L6(L7, L8)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  L2 = tonumber
  L3 = L1
  L4 = 16
  return L2(L3, L4)
end
swapEndian = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L4 = require
  L5 = "luci.fs"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.XQLog"
  L6 = L6(L7)
  if not (A0 and A1) or not A2 then
    L7 = false
    return L7
  end
  L7 = getUploadRomCPEHeaderFilePath
  L7 = L7()
  L8 = getUploadRomCPEModemFilePath
  L8 = L8()
  L9 = getUploadRomCPESignFilePath
  L9 = L9()
  L10 = getUploadRomFilePath
  L10 = L10()
  L11 = getUploadRomCPEHeaderLength
  L11 = L11()
  L12 = getUploadRomCPESignLength
  L12 = L12()
  L13 = getUploadRomCPESliceSize
  L13 = L13()
  if A0 == 1 and 1 < A1 then
    if not L3 then
      L14 = io
      L14 = L14.open
      L15 = A2
      L16 = "r"
      L14 = L14(L15, L16)
      L3 = L14
    end
    L15 = L3
    L14 = L3.read
    L16 = 4
    L14 = L14(L15, L16)
    if L14 == "CPE0" then
      L15 = L6.log
      L16 = 6
      L17 = "saveSliceImage find a dual image slice"
      L15(L16, L17)
      L15 = swapEndian
      L17 = L3
      L16 = L3.read
      L18 = 4
      L16, L17, L18, L19, L20, L21, L22 = L16(L17, L18)
      L15 = L15(L16, L17, L18, L19, L20, L21, L22)
      ModemLen = L15
      L15 = updateModemLengthForCPE
      L16 = ModemLen
      L15(L16)
    else
      L15 = io
      L15 = L15.close
      L16 = L3
      L15(L16)
      L15 = false
      return L15
    end
    L16 = L3
    L15 = L3.seek
    L17 = "set"
    L15(L16, L17)
    L16 = L3
    L15 = L3.read
    L17 = L11
    L15 = L15(L16, L17)
    L16 = io
    L16 = L16.close
    L17 = L3
    L16(L17)
    L16 = L5.exec
    L17 = "mtd erase modem_image > /dev/null"
    L16(L17)
    L16 = L4.access
    L17 = L7
    L16 = L16(L17)
    if L16 then
      L16 = L4.unlink
      L17 = L7
      L16(L17)
    end
    L16 = io
    L16 = L16.open
    L17 = L7
    L18 = "w"
    L16 = L16(L17, L18)
    L3 = L16
    if not L3 then
      L16 = false
      return L16
    end
    L17 = L3
    L16 = L3.write
    L18 = L15
    L16(L17, L18)
    L16 = io
    L16 = L16.close
    L17 = L3
    L16(L17)
    L16 = L5.exec
    L17 = string
    L17 = L17.format
    L18 = "nandwrite -p  --input-skip=%d %s %s  >/dev/null 2>&1"
    L19 = L11
    L20 = L8
    L21 = A2
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21)
    return L16(L17, L18, L19, L20, L21, L22)
  elseif A0 == A1 then
    if not L3 then
      L14 = io
      L14 = L14.open
      L15 = A2
      L16 = "r"
      L14 = L14(L15, L16)
      L3 = L14
    end
    L15 = L3
    L14 = L3.seek
    L16 = "end"
    L14 = L14(L15, L16)
    L15 = io
    L15 = L15.close
    L16 = L3
    L15(L16)
    L15 = L4.access
    L16 = L9
    L15 = L15(L16)
    if L15 then
      L15 = L4.unlink
      L16 = L9
      L15(L16)
    end
    L15 = L4.access
    L16 = L10
    L15 = L15(L16)
    if L15 then
      L15 = L4.unlink
      L16 = L10
      L15(L16)
    end
    L15 = getModemLengthForCPE
    L15 = L15()
    L16 = A0 - 1
    L16 = L13 * L16
    L15 = L15 - L16
    L15 = L15 - L11
    if L15 < 0 then
      L16 = false
      return L16
    end
    L16 = L5.exec
    L17 = string
    L17 = L17.format
    L18 = "nandwrite -p --input-size=%d -s %d %s %s  >/dev/null 2>&1"
    L19 = L15
    L20 = A0 - 1
    L20 = L13 * L20
    L21 = L8
    L22 = A2
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21, L22)
    L16 = L16(L17, L18, L19, L20, L21, L22)
    if not L16 then
      L16 = false
      return L16
    end
    L16 = L5.exec
    L17 = string
    L17 = L17.format
    L18 = "dd if=%s bs=%d count=1 iflag=skip_bytes skip=%d  of=%s  >/dev/null 2>&1"
    L19 = A2
    L20 = L12
    L21 = L15
    L22 = L9
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21, L22)
    L16 = L16(L17, L18, L19, L20, L21, L22)
    if not L16 then
      L16 = false
      return L16
    end
    L16 = L5.exec
    L17 = string
    L17 = L17.format
    L18 = "cutcpeimage -s %d -e %d -f %s  "
    L19 = L15 + L12
    L20 = L14 - 1
    L21 = A2
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21)
    L16 = L16(L17, L18, L19, L20, L21, L22)
    if not L16 then
      L16 = false
      return L16
    end
    L16 = L5.exec
    L17 = string
    L17 = L17.format
    L18 = "mv %s %s"
    L19 = A2
    L20 = L10
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20)
    L16 = L16(L17, L18, L19, L20, L21, L22)
    if not L16 then
      L16 = false
      return L16
    end
    L16 = true
    return L16
  else
    L14 = L5.exec
    L15 = string
    L15 = L15.format
    L16 = "nandwrite -p -s %d %s %s  >/dev/null 2>&1"
    L17 = A0 - 1
    L17 = L13 * L17
    L18 = L8
    L19 = A2
    L15, L16, L17, L18, L19, L20, L21, L22 = L15(L16, L17, L18, L19)
    return L14(L15, L16, L17, L18, L19, L20, L21, L22)
  end
end
saveSliceImage = L2
function L2(A0)
  local L1, L2, L3, L4
  if not A0 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "cd /tmp ; mkxqplugin -X uploadplug.mpk -F"
  L2 = L2(L3)
  if 0 == L2 then
    L2 = true
    return L2
  else
    L2 = L1.log
    L3 = 6
    L4 = "Failed to extract plugin"
    L2(L3, L4)
    L2 = false
    return L2
  end
end
extractPlug = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "luci.sys"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = getMiscHardwareInfo
  L2 = L2()
  L3 = {}
  L4 = L1.execl
  L5 = "cat /proc/cpuinfo | grep processor"
  L4 = L4(L5)
  L5 = L0.sysinfo
  L5, L6, L7, L8, L9, L10, L11 = L5()
  L12 = #L4
  if 0 < L12 then
    L12 = #L4
    L3.core = L12
  else
    L3.core = 1
  end
  function L12(A0)
    local L1, L2, L3
    L1 = tonumber
    L2 = A0
    L1 = L1(L2)
    if L1 then
      L2 = L1 % 64
      if 32 <= L2 then
        L3 = L1 + 64
        L3 = L3 - L2
        return L3
      else
        L3 = L1 - L2
        return L3
      end
    else
      L2 = 0
      return L2
    end
  end
  L13 = L2.cpufreq
  if L13 then
    L13 = L2.cpufreq
    L3.hz = L13
  else
    L13 = _UPVALUE0_
    L13 = L13.hzFormat
    L14 = tonumber
    L15 = L11
    L14 = L14(L15)
    L14 = L14 * 500000
    L13 = L13(L14)
    L3.hz = L13
  end
  L13 = L2.memsize
  if L13 then
    L13 = L2.memsize
    L3.memTotal = L13
  else
    L13 = string
    L13 = L13.format
    L14 = "%d M"
    L15 = L12
    L16 = L7 / 1024
    L15, L16 = L15(L16)
    L13 = L13(L14, L15, L16)
    L3.memTotal = L13
  end
  L3.system = L5
  L13 = string
  L13 = L13.format
  L14 = "%0.2f M"
  L15 = L10 / 1024
  L13 = L13(L14, L15)
  L3.memFree = L13
  return L3
end
getSysInfo = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.DISK_SPACE
  L1 = L1(L2)
  if L1 then
    L2 = tonumber
    L3 = L0.trim
    L4 = L1
    L3, L4 = L3(L4)
    L2 = L2(L3, L4)
    if L2 then
      L2 = tonumber
      L3 = L0.trim
      L4 = L1
      L3, L4 = L3(L4)
      L2 = L2(L3, L4)
      L1 = L2
      L2 = _UPVALUE1_
      L2 = L2.byteFormat
      L3 = L1 * 1024
      return L2(L3)
  end
  else
    L2 = "Cannot find userdisk"
    return L2
  end
end
getDiskSpace = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.AVAILABLE_MEMERY
  L1 = L1(L2)
  if L1 then
    L2 = tonumber
    L3 = L0.trim
    L4 = L1
    L3, L4 = L3(L4)
    L2 = L2(L3, L4)
    if L2 then
      L2 = tonumber
      L3 = L0.trim
      L4 = L1
      L3, L4 = L3(L4)
      return L2(L3, L4)
  end
  else
    L2 = false
    return L2
  end
end
getAvailableMemery = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = A0 or L3
  if not A0 then
    L3 = _UPVALUE0_
    L3 = L3.AVAILABLE_DISK
  end
  L2 = L2(L3)
  if L2 then
    L3 = tonumber
    L4 = L1.trim
    L5 = L2
    L4, L5 = L4(L5)
    L3 = L3(L4, L5)
    if L3 then
      L3 = tonumber
      L4 = L1.trim
      L5 = L2
      L4, L5 = L4(L5)
      return L3(L4, L5)
  end
  else
    L3 = false
    return L3
  end
end
getAvailableDisk = L2
function L2(A0)
  local L1, L2, L3
  if A0 then
    L2 = A0
    L1 = A0.match
    L3 = "/userdisk/data"
    L1 = L1(L2, L3)
    if L1 then
      L1 = getAvailableDisk
      L2 = "df -k | grep \\ /userdisk/data$ | awk '{print $4}' | sed -n '1p'"
      return L1(L2)
  end
  elseif A0 then
    L2 = A0
    L1 = A0.match
    L3 = "/userdisk"
    L1 = L1(L2, L3)
    if L1 then
      L1 = getAvailableDisk
      return L1()
    end
  end
  L1 = getAvailableMemery
  return L1()
end
getAvailableSpace = L2
function L2(A0)
  local L1, L2
  L1 = getAvailableDisk
  L1 = L1()
  if L1 then
    L2 = A0 / 1024
    L2 = L1 - L2
    if 10240 < L2 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
checkDiskSpace = L2
function L2(A0)
  local L1, L2
  L1 = getAvailableMemery
  L1 = L1()
  if L1 then
    L2 = A0 / 1024
    L2 = L1 - L2
    if 10240 < L2 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
checkTmpSpace = L2
function L2(A0, A1)
  local L2, L3
  if A0 and A1 then
    L2 = getAvailableSpace
    L3 = A0
    L2 = L2(L3)
    if L2 then
      L3 = A1 / 1024
      L3 = L2 - L3
      if 10240 < L3 then
        L3 = true
        return L3
      end
    end
  end
  L2 = false
  return L2
end
checkSpace = L2
function L2()
  local L0, L1
  L0 = "/tmp/"
  return L0
end
getUploadDir = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CROM_CACHE_FILEPATH
  return L0
end
getUploadRomFilePath = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_HEADER_CACHE_FILEPATH
  return L0
end
getUploadRomCPEHeaderFilePath = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_MODEM_CACHE_FILEPATH
  return L0
end
getUploadRomCPEModemFilePath = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_SIGN_CACHE_FILEPATH
  return L0
end
getUploadRomCPESignFilePath = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_HEADER_LENGTH
  return L0
end
getUploadRomCPEHeaderLength = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_SIGN_LENGTH
  return L0
end
getUploadRomCPESignLength = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPE_UPLOAD_CPE_ROM_SLICE_SIZE
  return L0
end
getUploadRomCPESliceSize = L2
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.CPlug_CACHE_FILEPATH
  return L0
end
getUploadPlugFilePath = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = tostring
  L2 = A0
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "echo "
  L4 = L1
  L5 = " > "
  L6 = _UPVALUE0_
  L6 = L6.CPE_MODEM_LENGTH_FILE
  L3 = L3 .. L4 .. L5 .. L6
  L2(L3)
end
updateModemLengthForCPE = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.exec
  L3 = _UPVALUE0_
  L3 = L3.GET_CPE_MODEM_LENGTH_FILE
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 then
    return L1
  else
    L2 = 0
    return L2
  end
end
getModemLengthForCPE = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = tostring
  L2 = A0
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "echo "
  L4 = L1
  L5 = " > "
  L6 = _UPVALUE0_
  L6 = L6.UPGRADE_LOCK_FILE
  L3 = L3 .. L4 .. L5 .. L6
  L2(L3)
end
updateUpgradeStatus = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.exec
  L3 = _UPVALUE0_
  L3 = L3.UPGRADE_STATUS
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 then
    return L1
  else
    L2 = 0
    return L2
  end
end
getUpgradeStatus = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.exec
  L3 = "cat /tmp/state/upgrade_progress 2>/dev/null"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 then
    return L1
  else
    L2 = 0
    return L2
  end
end
getFlashProgress = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = "/tmp/upgraded_result"
  L3 = 0
  L4 = L1.access
  L5 = L2
  L4 = L4(L5)
  if L4 then
    L4 = tonumber
    L5 = L0.exec
    L6 = "cat /tmp/upgraded_result 2>/dev/null"
    L5, L6 = L5(L6)
    L4 = L4(L5, L6)
    L3 = L4
  end
  return L3
end
getUpgradeResult = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.exec
  L3 = "uci -q get otapred.settings.auto"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 then
    return L1
  else
    L2 = 0
    return L2
  end
end
getOtapred = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.trim
  L3 = L0.exec
  L4 = "nvram get flag_ota_reboot"
  L3, L4 = L3(L4)
  L2, L3, L4 = L2(L3, L4)
  L1 = L1(L2, L3, L4)
  if L1 == 1 then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
checkBeenUpgraded = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.fs"
  L0 = L0(L1)
  L1 = checkBeenUpgraded
  L1 = L1()
  if L1 then
    L1 = 2
    return L1
  end
  L1 = os
  L1 = L1.execute
  L2 = _UPVALUE0_
  L2 = L2.FLASH_EXECUTION_CHECK
  L1 = L1(L2)
  if L1 ~= 0 then
    L2 = 1
    return L2
  end
  L2 = L0.access
  L3 = _UPVALUE0_
  L3 = L3.FLASH_PID_TMP
  L2 = L2(L3)
  if not L2 then
    L2 = 0
    return L2
  else
    L2 = 3
    return L2
  end
end
getFlashStatus = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L3 = tonumber
    L4 = L1.trim
    L5 = L2
    L4, L5 = L4(L5)
    L3 = L3(L4, L5)
    L2 = L3
    if 0 < L2 then
      L3 = 1
      return L3
    end
  end
  L3 = 0
  return L3
end
checkExecStatus = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.fs"
  L0 = L0(L1)
  L1 = checkBeenUpgraded
  L1 = L1()
  if L1 then
    L1 = 11
    return L1
  end
  L1 = getUpgradeStatus
  L1 = L1()
  L2 = checkExecStatus
  L3 = _UPVALUE0_
  L3 = L3.CRONTAB_ROM_CHECK
  L2 = L2(L3)
  if L2 == 1 then
    if L1 == 0 then
      L2 = 1
      return L2
    else
      return L1
    end
  end
  L2 = os
  L2 = L2.execute
  L3 = _UPVALUE0_
  L3 = L3.FLASH_EXECUTION_CHECK
  L2 = L2(L3)
  if L2 ~= 0 then
    L3 = checkExecStatus
    L4 = _UPVALUE0_
    L4 = L4.CROM_FLASH_CHECK
    L3 = L3(L4)
    if L3 == 1 then
      L3 = 12
      return L3
    else
      L3 = 5
      return L3
    end
  end
  L3 = getFlashStatus
  L3 = L3()
  L4 = L0.access
  L5 = _UPVALUE0_
  L5 = L5.CRONTAB_PID_TMP
  L4 = L4(L5)
  if L4 then
    if L1 == 0 then
      if L3 == 2 then
        L5 = 11
        return L5
      elseif L3 == 3 then
        L5 = 10
        return L5
      end
    end
    return L1
  elseif L3 == 2 then
    L5 = 11
    return L5
  elseif L3 == 3 then
    L5 = 10
    return L5
  end
  L5 = 0
  return L5
end
checkUpgradeStatus = L2
function L2()
  local L0, L1
  L0 = checkUpgradeStatus
  L0 = L0()
  if L0 == 1 or L0 == 2 or L0 == 3 or L0 == 4 or L0 == 5 or L0 == 12 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
isUpgrading = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQDownloadUtil"
  L2 = L2(L3)
  L3 = os
  L3 = L3.execute
  L4 = _UPVALUE0_
  L4 = L4.FLASH_EXECUTION_CHECK
  L3 = L3(L4)
  if L3 ~= 0 then
    L4 = false
    return L4
  end
  L4 = L0.exec
  L5 = _UPVALUE0_
  L5 = L5.UPGRADE_PID
  L4 = L4(L5)
  L5 = L0.exec
  L6 = _UPVALUE0_
  L6 = L6.UPGRADE_LUA_PID
  L5 = L5(L6)
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = L4
  L6 = L6(L7)
  if not L6 then
    L6 = L0.trim
    L7 = L4
    L6 = L6(L7)
    L4 = L6
    L6 = os
    L6 = L6.execute
    L7 = "kill "
    L8 = L4
    L7 = L7 .. L8
    L6(L7)
    L6 = _UPVALUE1_
    L6 = L6.isStrNil
    L7 = L5
    L6 = L6(L7)
    if not L6 then
      L6 = os
      L6 = L6.execute
      L7 = "kill "
      L8 = L0.trim
      L9 = L5
      L8 = L8(L9)
      L7 = L7 .. L8
      L6(L7)
    end
    L6 = L2.cancelDownload
    L7 = L1.get
    L8 = _UPVALUE0_
    L8 = L8.PREF_ROM_DOWNLOAD_ID
    L9 = ""
    L7, L8, L9 = L7(L8, L9)
    L6(L7, L8, L9)
    L6 = _UPVALUE1_
    L6 = L6.sysUnlock
    L6()
    L6 = true
    return L6
  else
    L6 = false
    return L6
  end
end
cancelUpgrade = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.CPU_TEMPERATURE
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L3 = L1
    L2 = L1.match
    L4 = "Temperature: (%S+)"
    L2 = L2(L3, L4)
    L1 = L2
    if L1 then
      L2 = tonumber
      L3 = L0.trim
      L4 = L1
      L3, L4 = L3(L4)
      L2 = L2(L3, L4)
      L1 = L2
      return L1
    end
  end
  L2 = 0
  return L2
end
getCpuTemperature = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "json"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSecureUtil"
  L4 = L4(L5)
  L5 = {}
  if A1 ~= nil then
    L6 = L4.cmdSafeCheck
    L7 = A1
    L6 = L6(L7)
    if L6 then
      goto lbl_21
    end
  end
  L6 = "http://www.baidu.com"
  ::lbl_21::
  L6 = L6 or L6
  if L6 then
    L8 = L6
    L7 = L6.match
    L9 = "http://"
    L7 = L7(L8, L9)
    if L7 == nil then
      L8 = L6
      L7 = L6.match
      L9 = "https://"
      L7 = L7(L8, L9)
      if L7 == nil then
        L7 = "http://"
        L8 = L6
        L6 = L7 .. L8
      end
    end
  end
  L7 = nil
  L8 = tonumber
  L9 = A0
  L8 = L8(L9)
  if L8 == 1 then
    L8 = L2.exec
    L9 = _UPVALUE0_
    L9 = L9.SIMPLE_NETWORK_NOLOG_DETECT
    L10 = "'"
    L11 = L6
    L12 = "'"
    L9 = L9 .. L10 .. L11 .. L12
    L8 = L8(L9)
    L7 = L8
  else
    L8 = tonumber
    L9 = A0
    L8 = L8(L9)
    if L8 == 2 then
      L8 = L2.exec
      L9 = _UPVALUE0_
      L9 = L9.SIMPLE_NETWORK_DETECT
      L10 = "'"
      L11 = L6
      L12 = "'"
      L9 = L9 .. L10 .. L11 .. L12
      L8 = L8(L9)
      L7 = L8
    else
      L8 = L2.exec
      L9 = _UPVALUE0_
      L9 = L9.FULL_NETWORK_DETECT
      L10 = "'"
      L11 = L6
      L12 = "'"
      L9 = L9 .. L10 .. L11 .. L12
      L8 = L8(L9)
      L7 = L8
    end
  end
  if L7 then
    L8 = L3.decode
    L9 = L2.trim
    L10 = L7
    L9, L10, L11, L12 = L9(L10)
    L8 = L8(L9, L10, L11, L12)
    L7 = L8
    if L7 then
      L8 = type
      L9 = L7
      L8 = L8(L9)
      if L8 == "table" then
        L8 = L7.CHECKINFO
        if L8 then
          L9 = type
          L10 = L8
          L9 = L9(L10)
          if L9 == "table" then
            L9 = L8.wanlink
            if L9 == "up" then
              L9 = 1
              if L9 then
                goto lbl_107
              end
            end
            L9 = 0
            ::lbl_107::
            L5.wanLink = L9
            L9 = L8.wanprotocal
            L9 = L9 or L9
            L5.wanType = L9
            L9 = L8.ping
            L10 = L9
            L9 = L9.match
            L11 = "(%S+)%%"
            L9 = L9(L10, L11)
            L5.pingLost = L9
            L9 = L8.gw
            L10 = L9
            L9 = L9.match
            L11 = "(%S+)%%"
            L9 = L9(L10, L11)
            L5.gw = L9
            L9 = L8.dns
            if L9 == "ok" then
              L9 = 1
              if L9 then
                goto lbl_130
              end
            end
            L9 = 0
            ::lbl_130::
            L5.dns = L9
            L9 = L8.tracer
            if L9 == "ok" then
              L9 = 1
              if L9 then
                goto lbl_138
              end
            end
            L9 = 0
            ::lbl_138::
            L5.tracer = L9
            L9 = tonumber
            L10 = L8.memory
            L9 = L9(L10)
            L9 = L9 * 100
            L5.memory = L9
            L9 = tonumber
            L10 = L8.cpu
            L9 = L9(L10)
            L5.cpu = L9
            L9 = L8.disk
            L5.disk = L9
            L9 = L8.tcp
            L5.tcp = L9
            L9 = L8.http
            L5.http = L9
            L9 = L8.ip
            L5.ip = L9
            return L5
          end
        end
      end
    end
  end
  L8 = nil
  return L8
end
getNetworkDetectInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = {}
  L3 = L1.sysinfo
  L3, L4, L5, L6, L7, L8, L9 = L3()
  L10 = tonumber
  L11 = L0.trim
  L12 = L0.exec
  L13 = _UPVALUE0_
  L13 = L13.CPU_LOAD_AVG
  L12, L13 = L12(L13)
  L11, L12, L13 = L11(L12, L13)
  L10 = L10(L11, L12, L13)
  L10 = L10 or L10
  L2.cpu = L10
  L10 = tonumber
  L11 = string
  L11 = L11.format
  L12 = "%0.2f"
  L13 = L6 + L7
  L13 = L13 + L8
  L13 = L13 / L5
  L13 = 1 - L13
  L11, L12, L13 = L11(L12, L13)
  L10 = L10(L11, L12, L13)
  L10 = L10 or L10
  L2.mem = L10
  L10 = string
  L10 = L10.upper
  L11 = L0.trim
  L12 = L0.exec
  L13 = _UPVALUE0_
  L13 = L13.WAN_LINK
  L12, L13 = L12(L13)
  L11, L12, L13 = L11(L12, L13)
  L10 = L10(L11, L12, L13)
  L10 = L10 == "UP"
  L2.link = L10
  L2.wan = true
  L10 = getCpuTemperature
  L10 = L10()
  L2.tmp = L10
  return L2
end
checkSystemStatus = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_FLASH_PERMISSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = false
    return L2
  else
    L2 = tonumber
    L3 = L0.trim
    L4 = L1
    L3, L4 = L3(L4)
    L2 = L2(L3, L4)
    L1 = L2
    if L1 and L1 == 1 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
getFlashPermission = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  if A0 then
    L2 = L1.exec
    L3 = _UPVALUE0_
    L3 = L3.SET_FLASH_PERMISSION
    L4 = "1"
    L3 = L3 .. L4
    L2(L3)
  else
    L2 = L1.exec
    L3 = _UPVALUE0_
    L3 = L3.SET_FLASH_PERMISSION
    L4 = "0"
    L3 = L3 .. L4
    L2(L3)
  end
end
setFlashPermission = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = nil
  L6 = 0
  if A1 == nil or A0 == nil or A2 == nil then
    L7 = 1523
    return L7
  end
  if A1 == "0" then
    L7 = "white"
    if L7 then
      goto lbl_25
    end
  end
  L7 = "black"
  ::lbl_25::
  L9 = L3
  L8 = L3.get
  L10 = "macfilter"
  L11 = A2
  L12 = "enable"
  L8 = L8(L9, L10, L11, L12)
  oldenable = L8
  L9 = L3
  L8 = L3.get
  L10 = "macfilter"
  L11 = A2
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  oldmode = L8
  L8 = oldenable
  if L8 == A0 then
    L8 = oldmode
    if L8 == L7 then
      L8 = 0
      return L8
    end
  end
  L9 = L3
  L8 = L3.set
  L10 = "macfilter"
  L11 = A2
  L12 = "enable"
  L13 = A0
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.set
  L10 = "macfilter"
  L11 = A2
  L12 = "mode"
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.commit
  L10 = "macfilter"
  L8(L9, L10)
  L8 = L4.log
  L9 = 4
  L10 = "uci commit macfilter enable="
  L11 = A0
  L12 = " filter="
  L13 = A2
  L14 = " mode="
  L15 = L7
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8(L9, L10)
  L8 = "/usr/sbin/macfilter enable "
  L9 = A0
  L10 = " "
  L11 = L7
  L12 = " "
  L13 = A2
  L5 = L8 .. L9 .. L10 .. L11 .. L12 .. L13
  L8 = L4.log
  L9 = 4
  L10 = "set macfilter enable: "
  L11 = L5
  L10 = L10 .. L11
  L8(L9, L10)
  if L5 then
    L8 = os
    L8 = L8.execute
    L9 = L5
    L8 = L8(L9)
    L6 = L8
  end
  return L6
end
setmacfilterenablemode = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = nil
  L6 = 0
  if A1 == nil or A0 == nil or A2 == nil then
    L7 = 1523
    return L7
  end
  if A1 == "0" then
    L7 = "white"
    if L7 then
      goto lbl_25
    end
  end
  L7 = "black"
  ::lbl_25::
  L9 = L3
  L8 = L3.get
  L10 = "ipfilter"
  L11 = A2
  L12 = "enable"
  L8 = L8(L9, L10, L11, L12)
  oldenable = L8
  L9 = L3
  L8 = L3.get
  L10 = "ipfilter"
  L11 = A2
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  oldmode = L8
  L8 = oldenable
  if L8 == A0 then
    L8 = oldmode
    if L8 == L7 then
      L8 = 0
      return L8
    end
  end
  L9 = L3
  L8 = L3.set
  L10 = "ipfilter"
  L11 = A2
  L12 = "enable"
  L13 = A0
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.set
  L10 = "ipfilter"
  L11 = A2
  L12 = "mode"
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.commit
  L10 = "ipfilter"
  L8(L9, L10)
  L8 = L4.log
  L9 = 4
  L10 = "uci commit ipfilter enable="
  L11 = A0
  L12 = " filter="
  L13 = A2
  L14 = " mode="
  L15 = L7
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8(L9, L10)
  L8 = "/usr/sbin/ipfilter enable "
  L9 = A0
  L10 = " "
  L11 = L7
  L12 = " "
  L13 = A2
  L5 = L8 .. L9 .. L10 .. L11 .. L12 .. L13
  L8 = L4.log
  L9 = 4
  L10 = "set ipfilter enable: "
  L11 = L5
  L10 = L10 .. L11
  L8(L9, L10)
  if L5 then
    L8 = os
    L8 = L8.execute
    L9 = L5
    L8 = L8(L9)
    L6 = L8
  end
  return L6
end
setipfilterenablemode = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L3 = L1
    L2 = L1.get
    L4 = "macfilter"
    L5 = A0
    L6 = "enable"
    L2 = L2(L3, L4, L5, L6)
    return L2
  end
end
getMacfilterEnable = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.GET_LAN_MODE
  if A0 == "wan" then
    L4 = _UPVALUE0_
    L3 = L4.GET_WAN_MODE
  elseif A0 == "admin" then
    L4 = _UPVALUE0_
    L3 = L4.GET_ADMIN_MODE
  end
  L5 = L1
  L4 = L1.get
  L6 = "macfilter"
  L7 = A0
  L8 = "mode"
  L4 = L4(L5, L6, L7, L8)
  if L4 and L4 == "white" then
    L5 = 0
    return L5
  else
    L5 = 1
    return L5
  end
  L5 = 0
  return L5
end
getMacfilterMode = L2
function L2(A0, A1)
  local L2, L3, L4, L5
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = nil
  if A0 == "lan" then
    L4 = tonumber
    L5 = A1
    L4 = L4(L5)
    if L4 == 0 then
      L4 = _UPVALUE0_
      L3 = L4.SET_LAN_WHITELIST
    else
      L4 = _UPVALUE0_
      L3 = L4.SET_LAN_BLACKLIST
    end
  elseif A0 == "wan" then
    L4 = tonumber
    L5 = A1
    L4 = L4(L5)
    if L4 == 0 then
      L4 = _UPVALUE0_
      L3 = L4.SET_WAN_WHITELIST
    else
      L4 = _UPVALUE0_
      L3 = L4.SET_WAN_BLACKLIST
    end
  elseif A0 == "admin" then
    L4 = tonumber
    L5 = A1
    L4 = L4(L5)
    if L4 == 0 then
      L4 = _UPVALUE0_
      L3 = L4.SET_ADMIN_WHITELIST
    else
      L4 = _UPVALUE0_
      L3 = L4.SET_ADMIN_BLACKLIST
    end
  end
  if L3 then
    L4 = os
    L4 = L4.execute
    L5 = L3
    L4 = L4(L5)
    if L4 == 0 then
      L4 = true
      return L4
  end
  else
    L4 = false
    return L4
  end
end
setMacfilterMode = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.get
  L3 = _UPVALUE0_
  L3 = L3.PREF_TIMESTAMP
  L4 = "0"
  L2, L3, L4 = L2(L3, L4)
  return L1(L2, L3, L4)
end
getDetectionTimestamp = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = L0.set
  L2 = _UPVALUE0_
  L2 = L2.PREF_TIMESTAMP
  L3 = tostring
  L4 = os
  L4 = L4.time
  L4 = L4()
  L3, L4 = L3(L4)
  L1(L2, L3, L4)
end
setDetectionTimestamp = L2
function L2()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.WIFI_LOG_COLLECTION
  L0(L1)
end
getWifiLog = L2
function L2()
  local L0, L1, L2, L3
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_rom_ver"
  L3 = ""
  L1 = L1(L2, L3)
  L0.rom_ver = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_rom_channel"
  L3 = ""
  L1 = L1(L2, L3)
  L0.rom_channel = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_hardware"
  L3 = ""
  L1 = L1(L2, L3)
  L0.hardware = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_uboot"
  L3 = ""
  L1 = L1(L2, L3)
  L0.uboot = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_linux"
  L3 = ""
  L1 = L1(L2, L3)
  L0.linux = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_ramfs"
  L3 = ""
  L1 = L1(L2, L3)
  L0.ramfs = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_sqafs"
  L3 = ""
  L1 = L1(L2, L3)
  L0.sqafs = L1
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "nv_rootfs"
  L3 = ""
  L1 = L1(L2, L3)
  L0.rootfs = L1
  return L0
end
getNvramConfigs = L2
function L2()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "/etc/init.d/noflushd status"
  return L0(L1)
end
noflushdStatus = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = os
    L1 = L1.execute
    L2 = "/etc/init.d/noflushd on"
    L1 = L1(L2)
    L1 = L1 == 0
    return L1
  else
    L1 = os
    L1 = L1.execute
    L2 = "killall -s 10 noflushd ; /etc/init.d/noflushd off"
    L1 = L1(L2)
    L1 = L1 == 0
    return L1
  end
end
noflushdSwitch = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = L0.get_all
  L2 = L2(L3, L4, L5)
  if L3 == "table" then
    for L6, L7 in L3, L4, L5 do
      if L6 and L7 then
        L9 = L6
        L8 = L6.match
        L10 = "%."
        L8 = L8(L9, L10)
        if not L8 then
          L1[L6] = L7
        end
      end
    end
  end
  if L3 == nil then
    return L3
  else
    return L1
  end
end
getModulesList = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.exec
  L3 = "bdata show"
  L2 = L2(L3)
  while true do
    L3 = string
    L3 = L3.find
    L4 = L2
    L5 = "\n"
    L3 = L3(L4, L5)
    if nil == L3 then
      break
    end
    L4 = string
    L4 = L4.sub
    L5 = L2
    L6 = 1
    L7 = L3 - 1
    L4 = L4(L5, L6, L7)
    L5 = string
    L5 = L5.find
    L6 = L4
    L7 = "="
    L5 = L5(L6, L7)
    if L5 then
      L6 = string
      L6 = L6.sub
      L7 = L4
      L8 = 1
      L9 = L5 - 1
      L6 = L6(L7, L8, L9)
      k = L6
      L6 = string
      L6 = L6.sub
      L7 = L4
      L8 = L5 + 1
      L9 = #L4
      L6 = L6(L7, L8, L9)
      v = L6
      L6 = v
      if L6 then
        L6 = k
        L7 = v
        L1[L6] = L7
      end
    end
    L6 = string
    L6 = L6.sub
    L7 = L2
    L8 = L3 + 1
    L9 = #L2
    L6 = L6(L7, L8, L9)
    L2 = L6
  end
  return L1
end
bdataInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L4 = L1.getWifissid
  L4, L5, L6 = L4()
  L3.wl0_ssid = L5
  L3.wl1_ssid = L4
  if L6 then
    L3.wl2_ssid = L6
  end
  L7 = getRomVersion
  L7 = L7()
  L3.version = L7
  L7 = getInitInfo
  L7 = L7()
  L3.init = L7
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.nvramGet
  L9 = "ssh_en"
  L10 = 0
  L8, L9, L10, L11, L12, L13 = L8(L9, L10)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 == 1 then
    L7 = true
    if L7 then
      goto lbl_39
    end
  end
  L7 = false
  ::lbl_39::
  L3.ssh = L7
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.nvramGet
  L9 = "uart_en"
  L10 = 0
  L8, L9, L10, L11, L12, L13 = L8(L9, L10)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 == 1 then
    L7 = true
    if L7 then
      goto lbl_53
    end
  end
  L7 = false
  ::lbl_53::
  L3.uart = L7
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.nvramGet
  L9 = "telnet_en"
  L10 = 0
  L8, L9, L10, L11, L12, L13 = L8(L9, L10)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 == 1 then
    L7 = true
    if L7 then
      goto lbl_67
    end
  end
  L7 = false
  ::lbl_67::
  L3.telnet = L7
  L7 = tonumber
  L8 = L0.exec
  L9 = "cat /proc/xiaoqiang/ft_mode 2>/dev/null"
  L8, L9, L10, L11, L12, L13 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 == 1 then
    L7 = true
    if L7 then
      goto lbl_79
    end
  end
  L7 = false
  ::lbl_79::
  L3.facmode = L7
  L7 = tonumber
  L8 = L0.exec
  L9 = "cat /proc/xiaoqiang/secboot_enable 2>/dev/null"
  L8, L9, L10, L11, L12, L13 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 == 1 then
    L7 = true
    if L7 then
      goto lbl_91
    end
  end
  L7 = false
  ::lbl_91::
  L3.secboot = L7
  L7 = tonumber
  L8 = L0.exec
  L9 = "fdisk -lu | grep /dev/sda4 | awk {'print $2'}"
  L8, L9, L10, L11, L12, L13 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  if L7 then
    L8 = math
    L8 = L8.mod
    L9 = L7
    L10 = 8
    L8 = L8(L9, L10)
    if L8 == 0 then
      L8 = true
      if L8 then
        goto lbl_110
        L7 = L8 or L7
      end
    end
    L7 = false
    ::lbl_110::
  else
    L7 = false
  end
  L3["4kblock"] = L7
  L9 = L2
  L8 = L2.get
  L10 = "misc"
  L11 = "features"
  L12 = "meshSuites"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = tostring
  L10 = L8
  L9 = L9(L10)
  if L9 == "1" then
    L9 = L0.trim
    L10 = tostring
    L11 = L0.exec
    L12 = "getmac peernum 2>/dev/null"
    L11, L12, L13 = L11(L12)
    L10, L11, L12, L13 = L10(L11, L12, L13)
    L9 = L9(L10, L11, L12, L13)
    L10 = tostring
    L11 = L9
    L10 = L10(L11)
    if L10 == "1" then
      L10 = L0.trim
      L11 = tostring
      L12 = L0.exec
      L13 = "getmac peer1 wl0 2>/dev/null"
      L12, L13 = L12(L13)
      L11, L12, L13 = L11(L12, L13)
      L10 = L10(L11, L12, L13)
      L3.peer1 = L10
    else
      L10 = tostring
      L11 = L8
      L10 = L10(L11)
      if L10 == "2" then
        L10 = L0.trim
        L11 = tostring
        L12 = L0.exec
        L13 = "getmac peer1 wl0 2>/dev/null"
        L12, L13 = L12(L13)
        L11, L12, L13 = L11(L12, L13)
        L10 = L10(L11, L12, L13)
        L3.peer1 = L10
        L10 = L0.trim
        L11 = tostring
        L12 = L0.exec
        L13 = "getmac peer2 wl0 2>/dev/null"
        L12, L13 = L12(L13)
        L11, L12, L13 = L11(L12, L13)
        L10 = L10(L11, L12, L13)
        L3.peer2 = L10
      end
    end
  end
  return L3
end
facInfo = L2
function L2(A0)
  local L1
  return A0
end
_ = L2
L2 = {}
L3 = _
L4 = "\232\183\175\231\148\177\229\153\168\230\178\161\230\156\137\230\163\128\230\181\139\229\136\176WAN\229\143\163\231\189\145\231\186\191\230\142\165\229\133\165"
L3 = L3(L4)
L2["1"] = L3
L3 = _
L4 = "DHCP\230\156\141\229\138\161\230\178\161\230\156\137\229\147\141\229\186\148"
L3 = L3(L4)
L2["2"] = L3
L3 = _
L4 = "\229\174\189\229\184\166\230\139\168\229\143\183\230\156\141\229\138\161\230\151\160\229\147\141\229\186\148"
L3 = L3(L4)
L2["3"] = L3
L3 = _
L4 = "\228\184\138\231\186\167\231\189\145\231\187\156IP\228\184\142\232\183\175\231\148\177\229\153\168\229\177\128\229\159\159\231\189\145IP\230\156\137\229\134\178\231\170\129"
L3 = L3(L4)
L2["4"] = L3
L3 = _
L4 = "\231\189\145\229\133\179\228\184\141\229\143\175\232\190\190"
L3 = L3(L4)
L2["5"] = L3
L3 = _
L4 = "DNS\230\156\141\229\138\161\229\153\168\230\151\160\230\179\149\230\156\141\229\138\161\239\188\140\229\143\175\228\187\165\229\176\157\232\175\149\232\135\170\229\174\154\228\185\137DNS\232\167\163\229\134\179\239\188\136114.114.114.114, 114.114.115.115  \229\155\189\229\164\1508.8.8.8  8.8.4.4)"
L3 = L3(L4)
L2["6"] = L3
L3 = _
L4 = "\232\135\170\229\174\154\228\185\137\231\154\132DNS\230\151\160\230\179\149\230\156\141\229\138\161\239\188\140\232\175\183\229\133\179\233\151\173\232\135\170\229\138\168\228\187\165DNS\230\136\150\232\128\133\233\135\141\230\150\176\232\174\190\231\189\174"
L3 = L3(L4)
L2["7"] = L3
L3 = _
L4 = "\230\151\160\231\186\191\228\184\173\231\187\167\239\188\140\230\151\160\230\179\149\228\184\173\231\187\167\228\184\138\231\186\167"
L3 = L3(L4)
L2["8"] = L3
L3 = _
L4 = "\230\156\137\231\186\191\228\184\173\231\187\167\239\188\140\230\151\160\230\179\149\228\184\173\231\187\167\228\184\138\231\186\167"
L3 = L3(L4)
L2["9"] = L3
L3 = _
L4 = "\233\157\153\230\128\129IP\239\188\140\232\191\158\230\142\165\230\151\182\232\191\158\230\142\165\230\150\173\229\188\128"
L3 = L3(L4)
L2["10"] = L3
L3 = _
L4 = "mesh\228\187\142\232\174\190\229\164\135\239\188\140\230\151\160\230\179\149\232\191\158\230\142\165\228\184\187\232\183\175\231\148\177"
L3 = L3(L4)
L2["11"] = L3
L3 = _
L4 = "SIM\229\141\161\233\170\140\232\175\129\233\151\174\233\162\152"
L3 = L3(L4)
L2["12"] = L3
L3 = _
L4 = "\232\156\130\231\170\157\230\149\176\230\141\174\230\156\170\229\188\128\229\144\175"
L3 = L3(L4)
L2["13"] = L3
L3 = _
L4 = "\230\179\168\231\189\145\229\164\177\232\180\165"
L3 = L3(L4)
L2["14"] = L3
L3 = _
L4 = "\230\151\160\232\156\130\231\170\157\228\191\161\229\143\183"
L3 = L3(L4)
L2["15"] = L3
L3 = _
L4 = "IP\229\136\134\233\133\141\233\148\153\232\175\175"
L3 = L3(L4)
L2["16"] = L3
L3 = _
L4 = "\228\184\138\231\186\167\231\189\145\231\187\156IP\228\184\142\232\183\175\231\148\177\229\153\168\229\177\128\229\159\159\231\189\145IP\230\156\137\229\134\178\231\170\129"
L3 = L3(L4)
L2["17"] = L3
L3 = _
L4 = "DNS\232\167\163\230\158\144\229\164\177\232\180\165"
L3 = L3(L4)
L2["18"] = L3
L3 = _
L4 = "\230\151\160\230\179\149\232\191\158\230\142\165\229\164\150\231\189\145"
L3 = L3(L4)
L2["19"] = L3
L3 = _
L4 = "PPPoE\230\156\141\229\138\161\229\153\168\228\184\141\229\133\129\232\174\184\228\184\128\228\184\170\232\180\166\229\143\183\229\144\140\230\151\182\231\153\187\229\189\149"
L3 = L3(L4)
L2["31"] = L3
L3 = _
L4 = "PPPoE\228\184\138\231\189\145\230\152\175\231\148\168\230\136\183\229\144\141\230\136\150\232\128\133\229\175\134\231\160\129\233\148\153\232\175\175 691"
L3 = L3(L4)
L2["32"] = L3
L3 = _
L4 = "PPPoE\228\184\138\231\189\145\230\152\175\231\148\168\230\136\183\229\144\141\230\136\150\232\128\133\229\175\134\231\160\129\233\148\153\232\175\175 678"
L3 = L3(L4)
L2["33"] = L3
NETTB = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L1.exec
  L5 = "/usr/sbin/nettb"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if not L5 then
    L5 = L1.trim
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    L5 = L0.decode
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    L5 = L4.code
    if L5 then
      L5 = tonumber
      L6 = L4.code
      L5 = L5(L6)
      L3.code = L5
      L5 = L3.code
      if L5 == 32 then
        L5 = L2._pppoeError
        L6 = 691
        L5 = L5(L6)
        L5 = L5 or L5
        L3.code = L5
      else
        L5 = L3.code
        if L5 == 33 then
          L5 = L2._pppoeError
          L6 = 678
          L5 = L5(L6)
          L5 = L5 or L5
          L3.code = L5
        end
      end
    end
  end
  return L3
end
nettb = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = L2.exec
  L6 = "/usr/sbin/nettb2 "
  L7 = A0
  L6 = L6 .. L7
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = L5
  L6 = L6(L7)
  if not L6 then
    L6 = L2.trim
    L7 = L5
    L6 = L6(L7)
    L5 = L6
    L6 = L1.decode
    L7 = L5
    L6 = L6(L7)
    L5 = L6
    L6 = L5.code
    if L6 then
      L6 = tonumber
      L7 = L5.code
      L6 = L6(L7)
      L4.code = L6
      L6 = L4.code
      if L6 == 32 then
        L6 = L3._pppoeError
        L7 = 691
        L6 = L6(L7)
        L6 = L6 or L6
        L4.code = L6
      else
        L6 = L4.code
        if L6 == 33 then
          L6 = L3._pppoeError
          L7 = 678
          L6 = L6(L7)
          L6 = L6 or L6
          L4.code = L6
        end
      end
    end
  end
  return L4
end
nettb2 = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "nvram get color"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    if not L1 then
      L1 = 100
    end
  else
    L1 = 100
  end
  return L1
end
getColor = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = "matool --method api_call --params \"/device/minet_get_bindinfo\""
  L4 = L2.exec
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L0.log
    L6 = 6
    L7 = "ret "
    L8 = L4
    L7 = L7 .. L8
    L5(L6, L7)
    L5 = L1.decode
    L6 = L4
    L5 = L5(L6)
    L6 = L5.code
    L7 = L0.log
    L8 = 6
    L9 = "code: "
    L10 = L6
    L9 = L9 .. L10
    L7(L8, L9)
    if L6 ~= nil and L6 == 0 then
      L7 = L5.data
      L7 = L7.bind
      L8 = L0.log
      L9 = 6
      L10 = "bind: "
      L11 = L7
      L10 = L10 .. L11
      L8(L9, L10)
      return L7
    else
      L7 = L0.log
      L8 = 6
      L9 = "bind return 2"
      L7(L8, L9)
      L7 = 2
      return L7
    end
  else
    L5 = 2
    return L5
  end
end
getBindinfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "cjson"
  L2 = L2(L3)
  L3 = L0.getWifiStatus
  L4 = 1
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = L0.getWifiBssid
  L4, L5 = L4()
  L6 = {}
  L7 = getHardware
  L7 = L7()
  L6.hardware = L7
  L7 = getChannel
  L7 = L7()
  L6.channel = L7
  L7 = getColor
  L7 = L7()
  L6.color = L7
  L7 = getRouterLocale
  L7 = L7()
  L6.locale = L7
  L7 = L3.ssid
  L7 = L7 or L7
  L6.ssid = L7
  L7 = L4 or L7
  if not L4 then
    L7 = ""
  end
  L6.bssid1 = L7
  L7 = L5 or L7
  if not L5 then
    L7 = ""
  end
  L6.bssid2 = L7
  L7 = L1.getLanIp
  L7 = L7()
  L6.ip = L7
  L7 = L2.encode
  L8 = L6
  return L7(L8)
end
getRouterInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "cjson"
  L4 = L4(L5)
  L5 = L2.exec
  L6 = "uci -q get wireless.@wifi-iface[0].ssid"
  L5 = L5(L6)
  L6 = L1.getWifiBssid
  L6, L7 = L6()
  L8 = string
  L8 = L8.sub
  L9 = L5
  L10 = 0
  L11 = string
  L11 = L11.len
  L12 = L5
  L11 = L11(L12)
  L11 = L11 - 1
  L8 = L8(L9, L10, L11)
  L5 = L8
  L8 = {}
  L9 = getHardware
  L9 = L9()
  L8.hardware = L9
  L9 = getChannel
  L9 = L9()
  L8.channel = L9
  L9 = getColor
  L9 = L9()
  L8.color = L9
  L9 = getRouterLocale
  L9 = L9()
  L8.locale = L9
  L9 = L5 or L9
  if not L5 then
    L9 = ""
  end
  L8.ssid = L9
  L9 = L6 or L9
  if not L6 then
    L9 = ""
  end
  L8.bssid1 = L9
  L9 = L7 or L9
  if not L7 then
    L9 = ""
  end
  L8.bssid2 = L9
  L9 = L3.getLanIp
  L9 = L9()
  L8.ip = L9
  L9 = getSN
  L9 = L9()
  L8.sn = L9
  L9 = tonumber
  L11 = L0
  L10 = L0.get
  L12 = "bind"
  L13 = "info"
  L14 = "status"
  L10, L11, L12, L13, L14 = L10(L11, L12, L13, L14)
  L9 = L9(L10, L11, L12, L13, L14)
  L9 = L9 or L9
  L8.bind_status = L9
  L9 = tonumber
  L11 = L0
  L10 = L0.get
  L12 = "bind"
  L13 = "info"
  L14 = "record"
  L10, L11, L12, L13, L14 = L10(L11, L12, L13, L14)
  L9 = L9(L10, L11, L12, L13, L14)
  L9 = L9 or L9
  L8.bind_record = L9
  L9 = L4.encode
  L10 = L8
  return L9(L10)
end
getRouterInfo4Trafficd = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.sys"
  L3 = L3(L4)
  L4 = "/tmp/syslogbackup/"
  L6 = L1
  L5 = L1.get
  L7 = "network"
  L8 = "lan"
  L9 = "ipaddr"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  function L6()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    L0 = L0.process
    L0 = L0.info
    L1 = "uid"
    L0 = L0(L1)
    L1 = _UPVALUE1_
    L1 = L1.stat
    L2 = _UPVALUE2_
    L3 = "uid"
    L1 = L1(L2, L3)
    L0 = L0 == L1
    return L0
  end
  sane = L6
  function L6()
    local L0, L1, L2
    L0 = _UPVALUE0_
    L0 = L0.mkdir
    L1 = _UPVALUE1_
    L2 = 700
    L0(L1, L2)
  end
  prepare = L6
  L6 = sane
  L6 = L6()
  if not L6 then
    L6 = prepare
    L6()
  else
    L6 = os
    L6 = L6.execute
    L7 = "rm "
    L8 = L4
    L9 = "*.tar.gz"
    L7 = L7 .. L8 .. L9
    L6(L7)
  end
  L6 = os
  L6 = L6.execute
  L7 = "/usr/sbin/log_collection.sh >/dev/null 2>/dev/null"
  L6(L7)
  L6 = L2.access
  L7 = L0.LOG_ZIP_FILEPATH
  L6 = L6(L7)
  if L6 then
    L6 = os
    L6 = L6.date
    L7 = "%Y-%m-%d--%X"
    L8 = os
    L8 = L8.time
    L8, L9, L10, L11, L12 = L8()
    L6 = L6(L7, L8, L9, L10, L11, L12)
    L7 = ".tar.gz"
    L6 = L6 .. L7
    L7 = os
    L7 = L7.execute
    L8 = "cp "
    L9 = L0.LOG_ZIP_FILEPATH
    L10 = " "
    L11 = L4
    L12 = L6
    L8 = L8 .. L9 .. L10 .. L11 .. L12
    L7(L8)
    L7 = os
    L7 = L7.execute
    L8 = "rm "
    L9 = L0.LOG_ZIP_FILEPATH
    L8 = L8 .. L9
    L7(L8)
    return L6
  end
  L6 = nil
  return L6
end
backupSysLog = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = io
  L1 = L1.open
  L2 = "/tmp/dir_info"
  L3 = "r"
  L1 = L1(L2, L3)
  if L1 then
    L3 = L1
    L2 = L1.read
    L4 = "*a"
    L2 = L2(L3, L4)
    L4 = L1
    L3 = L1.close
    L3(L4)
    L3 = pcall
    L4 = L0.decode
    L5 = L2
    L3, L4 = L3(L4, L5)
    if L3 and L4 then
      return L4
    else
      L5 = nil
      return L5
    end
  else
    L2 = nil
    return L2
  end
end
getCachedDirInfo = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L2.total = ""
  L3 = {}
  L2.info = L3
  L3 = A0 or L3
  if not A0 then
    L3 = "/userdisk/data/"
  end
  L5 = L3
  L4 = L3.match
  L4 = L4(L5, L6)
  if not L4 then
    L4 = L3
    L5 = "/"
    L3 = L4 .. L5
  end
  L4 = L1.execl
  L5 = "du -h -d 1 "
  L5 = L5 .. L6
  L4 = L4(L5)
  L5 = #L4
  for L9, L10 in L6, L7, L8 do
    if L10 then
      L12 = L10
      L11 = L10.match
      L13 = "(%S+)%s+(%S+)"
      L11, L12 = L11(L12, L13)
      if L12 and L9 ~= L5 then
        L13 = {}
        L15 = L12
        L14 = L12.gsub
        L16 = L3
        L17 = ""
        L14 = L14(L15, L16, L17)
        L13.name = L14
        L13.size = L11
        L13.path = L12
        L13.type = "folder"
        L14 = table
        L14 = L14.insert
        L15 = L2.info
        L16 = L13
        L14(L15, L16)
      elseif L12 and L9 == L5 then
        L2.total = L11
      end
    end
  end
  for L10, L11 in L7, L8, L9 do
    if L11 then
      L13 = L11
      L12 = L11.match
      L14 = "(%S+)%s+%S+%s+%S+%s+%S+%s+(%S+)%s+"
      L12, L13 = L12(L13, L14)
      L15 = L11
      L14 = L11.match
      L16 = "%s(%S+)$"
      L14 = L14(L15, L16)
      if L12 then
        L16 = L12
        L15 = L12.match
        L17 = "^d"
        L15 = L15(L16, L17)
        if not L15 then
          L15 = {}
          L15.name = L14
          L15.size = L13
          L16 = L3
          L17 = L14
          L16 = L16 .. L17
          L15.path = L16
          L15.type = "file"
          L16 = table
          L16 = L16.insert
          L17 = L2.info
          L18 = L15
          L16(L17, L18)
        end
      end
    end
  end
  return L2
end
getDirectoryInfo = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A0 then
    L2 = type
    L2 = L2(L3)
    if L2 == "table" then
      L2 = A1 or L2
      if not A1 then
        L2 = "/tmp/usb/"
      end
      for L6, L7 in L3, L4, L5 do
        L8 = L7.type
        if L8 then
          L8 = L7.path
          if L8 then
            L8 = L7.type
            if L8 == "folder" then
              L8 = "cp -r '"
              L9 = L7.path
              L10 = "' "
              L11 = L2
              L8 = L8 .. L9 .. L10 .. L11
              L9 = os
              L9 = L9.execute
              L10 = "echo 1 '"
              L11 = L7.path
              L12 = "' > /tmp/backup_files_status"
              L10 = L10 .. L11 .. L12
              L9(L10)
            else
              L8 = L7.type
              if L8 == "file" then
                L8 = "cp '"
                L9 = L7.path
                L10 = "' "
                L11 = L2
                L8 = L8 .. L9 .. L10 .. L11
                L9 = os
                L9 = L9.execute
                L10 = "echo 1 '"
                L11 = L7.path
                L12 = "' > /tmp/backup_files_status"
                L10 = L10 .. L11 .. L12
                L9(L10)
              end
            end
            L8 = os
            L8 = L8.execute
            L9 = cp
            L8(L9)
          end
        end
      end
    end
  end
  L2 = os
  L2 = L2.execute
  L2(L3)
end
backupFiles = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.status = 0
  L1.description = ""
  L2 = L0.exec
  L3 = "cat /tmp/backup_files_status 2>/dev/null"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L4 = L2
    L3 = L2.match
    L5 = "^2"
    L3 = L3(L4, L5)
    if L3 then
      L1.status = 2
    else
      L4 = L2
      L3 = L2.match
      L5 = "^1"
      L3 = L3(L4, L5)
      if L3 then
        L1.status = 1
        L4 = L2
        L3 = L2.gsub
        L5 = "1 "
        L6 = ""
        L3 = L3(L4, L5, L6)
        L1.description = L3
      else
        L4 = L2
        L3 = L2.match
        L5 = "^3"
        L3 = L3(L4, L5)
        if L3 then
          L1.status = 3
        end
      end
    end
  end
  return L1
end
backupStatus = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "cat /tmp/backup_files_pid 2>/dev/null"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = os
    L2 = L2.execute
    L3 = "kill -9 "
    L4 = L1
    L3 = L3 .. L4
    L2(L3)
  end
end
cancelBackup = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = L0.dir
  L2 = "/userdisk/appdata/app_infos"
  L1 = L1(L2)
  L2 = {}
  if L1 then
    for L6 in L3, L4, L5 do
      L8 = L6
      L7 = L6.match
      L9 = "(%d+)"
      L7 = L7(L8, L9)
      if L7 then
        L8 = table
        L8 = L8.insert
        L9 = L2
        L10 = L7
        L8(L9, L10)
      end
    end
  end
  return L3(L4, L5)
end
getPluginIdList = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "cat /tmp/usbDeployRootPath.conf 2>/dev/null"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = L0.trim
    L3 = L1
    return L2(L3)
  end
end
usbMode = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.execl
  L3 = "cd /tmp; mkxqimage -V '"
  L4 = A0
  L3 = L3 .. L4 .. L5 .. L6
  L2 = L2(L3)
  L3 = nil
  L4 = getRomVersion
  L4 = L4()
  if L2 then
    if L5 == "table" then
      for L8, L9 in L5, L6, L7 do
        L10 = _UPVALUE0_
        L10 = L10.isStrNil
        L11 = L9
        L10 = L10(L11)
        if not L10 then
          L11 = L9
          L10 = L9.match
          L12 = "%s+option%sROM%s+'(%S+)'"
          L10 = L10(L11, L12)
          L9 = L10
          if L9 then
            L3 = L9
            break
          end
        end
      end
    end
  end
  if L3 and L4 then
    L3 = L5
    L4 = L5
    if L5 == L6 then
      for L8, L9 in L5, L6, L7 do
        L10 = tonumber
        L11 = L9
        L10 = L10(L11)
        L11 = tonumber
        L12 = L3[L8]
        L11 = L11(L12)
        if L10 > L11 then
          L10 = true
          return L10
        else
          L10 = tonumber
          L11 = L9
          L10 = L10(L11)
          L11 = tonumber
          L12 = L3[L8]
          L11 = L11(L12)
          if L10 < L11 then
            L10 = false
            return L10
          end
        end
      end
      return L5
    end
  end
  return L5
end
checkRomVersion = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "hwnat"
  L4 = "switch"
  L5 = "force_start"
  L1 = L1(L2, L3, L4, L5)
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  L2 = L2 or L2
  return L2
end
getHwnatStatus = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.set
  L4 = "hwnat"
  L5 = "switch"
  L6 = "force_start"
  if A0 then
    L7 = 1
    if L7 then
      goto lbl_16
    end
  end
  L7 = 0
  ::lbl_16::
  L2(L3, L4, L5, L6, L7)
  L3 = L1
  L2 = L1.commit
  L4 = "hwnat"
  L2(L3, L4)
  if A0 then
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/hwnat start >/dev/null 2>/dev/null"
    L2(L3)
  else
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/hwnat stop >/dev/null 2>/dev/null"
    L2(L3)
  end
end
hwnatSwitch = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "http_status_stat"
  L4 = "settings"
  L5 = "enabled"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tonumber
  L3 = L1
  return L2(L3)
end
httpStatus = L2
function L2(A0)
  local L1, L2, L3
  L1 = "/etc/init.d/http_status_stat "
  if A0 then
    L2 = "on"
    if L2 then
      goto lbl_8
    end
  end
  L2 = "off"
  ::lbl_8::
  L3 = " >/dev/null 2>/dev/null"
  L1 = L1 .. L2 .. L3
  L2 = os
  L2 = L2.execute
  L3 = L1
  L2 = L2(L3)
  L2 = L2 == 0
  return L2
end
httpSwitch = L2
function L2(A0)
  local L1, L2, L3
  L1 = "/etc/init.d/ustack "
  if A0 then
    L2 = "on"
    if L2 then
      goto lbl_8
    end
  end
  L2 = "off"
  ::lbl_8::
  L3 = " >/dev/null 2>/dev/null"
  L1 = L1 .. L2 .. L3
  L2 = os
  L2 = L2.execute
  L3 = L1
  L2 = L2(L3)
  L2 = L2 == 0
  return L2
end
ustackSwitch = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L1 = {}
  L1.cpuload = 0
  L1.fanspeed = 1
  L1.temperature = 40
  L2 = L0.connect
  L2 = L2()
  if L2 then
    L4 = L2
    L3 = L2.call
    L5 = "rmonitor"
    L6 = "status"
    L7 = {}
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3.cpuload
      L4 = L4(L5)
      L1.cpuload = L4
      L4 = tonumber
      L5 = L3.fanspeed
      L4 = L4(L5)
      L1.fanspeed = L4
      L4 = tonumber
      L5 = L3.temperature
      L4 = L4(L5)
      L1.temperature = L4
    end
    L5 = L2
    L4 = L2.close
    L4(L5)
  end
  return L1
end
getSysStatus = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "luci.cbi.datatypes"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  if A0 then
    L6 = L4
    L5 = L4.set
    L7 = "webfilter"
    L8 = "admin"
    L9 = "enable"
    L10 = 1
    L5(L6, L7, L8, L9, L10)
    if A1 then
      L5 = L3.macaddr
      L6 = A1
      L5 = L5(L6)
      if L5 then
        L5 = string
        L5 = L5.gsub
        L6 = A1
        L7 = "%:"
        L8 = "_"
        L5 = L5(L6, L7, L8)
        if A2 == 0 then
          L7 = L4
          L6 = L4.set
          L8 = "webfilter"
          L9 = L5
          L10 = "adminwhite"
          L6(L7, L8, L9, L10)
        else
          L7 = L4
          L6 = L4.delete
          L8 = "webfilter"
          L9 = L5
          L6(L7, L8, L9)
        end
      end
    end
  else
    L6 = L4
    L5 = L4.set
    L7 = "webfilter"
    L8 = "admin"
    L9 = "enable"
    L10 = 0
    L5(L6, L7, L8, L9, L10)
  end
  L6 = L4
  L5 = L4.commit
  L7 = "webfilter"
  L5(L6, L7)
end
webAccessControl = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
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
  L4 = "webfilter"
  L5 = "admin"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  L3 = nil
  L4 = {}
  L5 = L2 == "1"
  L4.open = L5
  L5 = L4.open
  if not L5 then
    return L4
  end
  L6 = L1
  L5 = L1.foreach
  L7 = "webfilter"
  L8 = "adminwhite"
  function L9(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    if L1 then
      L2 = _UPVALUE0_
      if not L2 then
        L2 = {}
        _UPVALUE0_ = L2
      end
      L2 = table
      L2 = L2.insert
      L3 = _UPVALUE0_
      L4 = L1
      L2(L3, L4)
    end
  end
  L5(L6, L7, L8, L9)
  L4.list = L3
  return L4
end
webAccessInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.timezone = "CST-8"
  L1.index = "0"
  L1.year = 0
  L1.month = 0
  L1.day = 0
  L1.hour = 0
  L1.min = 0
  L1.sec = 0
  L2 = os
  L2 = L2.date
  L3 = "*t"
  L4 = os
  L4 = L4.time
  L4, L5, L6, L7 = L4()
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = L2.year
  L1.year = L3
  L3 = L2.month
  L1.month = L3
  L3 = L2.day
  L1.day = L3
  L3 = L2.hour
  L1.hour = L3
  L3 = L2.min
  L1.min = L3
  L3 = L2.sec
  L1.sec = L3
  L4 = L0
  L3 = L0.foreach
  L5 = "system"
  L6 = "system"
  function L7(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L1 = L1.isStrNil
    L2 = A0.webtimezone
    L1 = L1(L2)
    if not L1 then
      L1 = _UPVALUE1_
      L2 = A0.webtimezone
      L1.timezone = L2
      L1 = _UPVALUE1_
      L2 = A0.timezoneindex
      L2 = L2 or L2
      L1.index = L2
    else
      L1 = _UPVALUE0_
      L1 = L1.isStrNil
      L2 = A0.timezone
      L1 = L1(L2)
      if not L1 then
        L1 = _UPVALUE1_
        L2 = A0.timezone
        L1.timezone = L2
        L1 = _UPVALUE1_
        L2 = A0.timezoneindex
        L2 = L2 or L2
        L1.index = L2
      end
    end
  end
  L3(L4, L5, L6, L7)
  return L1
end
getSysTime = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L6 = L3
  L5 = L3.get
  L7 = "timezone"
  L8 = tostring
  L9 = A2
  L8 = L8(L9)
  L9 = L8
  L8 = L8.gsub
  L10 = "%."
  L11 = "_"
  L8 = L8(L9, L10, L11)
  L9 = "tz"
  L5 = L5(L6, L7, L8, L9)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = L5
  L6 = L6(L7)
  if not L6 then
    L6 = require
    L7 = "nixio.fs"
    L6 = L6(L7)
    L8 = L3
    L7 = L3.foreach
    L9 = "system"
    L10 = "system"
    function L11(A0)
      local L1, L2, L3, L4, L5, L6
      L1 = _UPVALUE0_
      L1 = L1.isStrNil
      L2 = A0.timezone
      L1 = L1(L2)
      if not L1 then
        L1 = _UPVALUE1_
        L2 = L1
        L1 = L1.set
        L3 = "system"
        L4 = A0[".name"]
        L5 = "timezone"
        L6 = _UPVALUE2_
        L1(L2, L3, L4, L5, L6)
        L1 = _UPVALUE1_
        L2 = L1
        L1 = L1.set
        L3 = "system"
        L4 = A0[".name"]
        L5 = "webtimezone"
        L6 = _UPVALUE2_
        L1(L2, L3, L4, L5, L6)
        L1 = _UPVALUE1_
        L2 = L1
        L1 = L1.set
        L3 = "system"
        L4 = A0[".name"]
        L5 = "timezoneindex"
        L6 = _UPVALUE3_
        L1(L2, L3, L4, L5, L6)
      end
    end
    L7(L8, L9, L10, L11)
    L8 = L3
    L7 = L3.set
    L9 = "system"
    L10 = "ntp"
    L11 = "enabled"
    L12 = "1"
    L7(L8, L9, L10, L11, L12)
    L8 = L3
    L7 = L3.commit
    L9 = "system"
    L7(L8, L9)
    L7 = _UPVALUE0_
    L7 = L7.forkExec
    L8 = "/etc/init.d/timezone restart"
    L7(L8)
    L7 = require
    L8 = "xiaoqiang.util.XQSysUtil"
    L7 = L7(L8)
    L8 = require
    L9 = "xiaoqiang.XQLog"
    L8 = L8(L9)
    L9 = _UPVALUE0_
    L9 = L9.isMeshCap
    L9 = L9()
    if L9 then
      L9 = {}
      L9.cmd = "sync_time"
      L10 = tostring
      L11 = L5
      L10 = L10(L11)
      L9.timezone = L10
      L10 = tostring
      L11 = A2 or L11
      if not A2 then
        L11 = 0
      end
      L10 = L10(L11)
      L9.index = L10
      L10 = tostring
      L11 = L5
      L10 = L10(L11)
      L9.tz_value = L10
      L10 = require
      L11 = "luci.json"
      L10 = L10(L11)
      L11 = L10.encode
      L12 = L9
      L11 = L11(L12)
      L12 = L8.log
      L13 = 6
      L14 = " CAP call RE sync timezone msg:"
      L15 = L11
      L14 = L14 .. L15
      L12(L13, L14)
      L12 = _UPVALUE0_
      L12 = L12.forkExec
      L13 = "/sbin/whc_to_re_common_api.sh action '"
      L14 = L11
      L15 = "'"
      L13 = L13 .. L14 .. L15
      L12(L13)
      L12 = _UPVALUE0_
      L12 = L12.forkExec
      L13 = "/sbin/whc_to_re_common_api.sh whc_sync"
      L12(L13)
    end
  end
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A0
  L6 = L6(L7)
  if not L6 then
    L7 = A0
    L6 = A0.match
    L8 = "^%d+%-%d+%-%d+ %d+:%d+:%d+$"
    L6 = L6(L7, L8)
    if L6 then
      L6 = require
      L7 = "xiaoqiang.XQFeatures"
      L6 = L6(L7)
      L6 = L6.FEATURES
      L7 = L6.system
      L7 = L7.dt_spec
      if L7 then
        L7 = L6.system
        L7 = L7.dt_spec
        if L7 == "1" then
          L7 = require
          L8 = "luci.util"
          L7 = L7(L8)
          L8 = L7.exec
          L9 = "echo 'ok,xiaoqiang' > /tmp/ntp.status; date -s \""
          L10 = A0
          L11 = "\""
          L9 = L9 .. L10 .. L11
          L8(L9)
      end
      else
        L7 = _UPVALUE0_
        L7 = L7.forkExec
        L8 = "echo 'ok,xiaoqiang' > /tmp/ntp.status; sleep 3; date -s \""
        L9 = A0
        L10 = "\""
        L8 = L8 .. L9 .. L10
        L7(L8)
      end
      L8 = L3
      L7 = L3.set
      L9 = "system"
      L10 = "ntp"
      L11 = "enabled"
      L12 = "0"
      L7(L8, L9, L10, L11, L12)
      L8 = L3
      L7 = L3.commit
      L9 = "system"
      L7(L8, L9)
    end
  end
end
setSysTime = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "/usr/sbin/led_ctl led_on"
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "/usr/sbin/led_ctl led_off"
    L1(L2)
  end
  return
end
setLedStatus = L2
function L2()
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
  L5 = "BLUE_LED"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tonumber
  L3 = L1
  return L2(L3)
end
getLedStatus = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.set
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "led_mesh_sync_disabled"
  L6 = "1"
  L1(L2, L3, L4, L5, L6)
  L2 = L0
  L1 = L0.commit
  L3 = "xiaoqiang"
  L1(L2, L3)
end
disableLedMeshSync = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = "/usr/sbin/led_ctl timer_off"
  L5 = 0
  if A0 then
    L6 = string
    L6 = L6.match
    L7 = A1
    L8 = "^([0-2][0-9]):([0-5][0-9])$"
    L6, L7 = L6(L7, L8)
    L8 = string
    L8 = L8.match
    L9 = A2
    L10 = "^([0-2][0-9]):([0-5][0-9])$"
    L8, L9 = L8(L9, L10)
    if L8 and L9 and L6 and L7 then
      L10 = tonumber
      L11 = L8
      L10 = L10(L11)
      if L10 < 24 then
        L10 = tonumber
        L11 = L6
        L10 = L10(L11)
        if L10 < 24 then
          L10 = string
          L10 = L10.format
          L11 = "/usr/sbin/led_ctl timer_on %s %s %s %s"
          L12 = L6
          L13 = L7
          L14 = L8
          L15 = L9
          L10 = L10(L11, L12, L13, L14, L15)
          L4 = L10
          L5 = 1
      end
    end
    else
      L10 = L3.log
      L11 = 4
      L12 = "XQSysUtil - setLedTimer : resolve timer string failed!"
      L10(L11, L12)
    end
  end
  L6 = _UPVALUE0_
  L6 = L6.forkExec
  L7 = L4
  L6(L7)
  L6 = L3.log
  L7 = 4
  L8 = string
  L8 = L8.format
  L9 = "XQSysUtil - setLedTimer : set timer %d"
  L10 = L5
  L8, L9, L10, L11, L12, L13, L14, L15 = L8(L9, L10)
  L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
  return L5
end
setLedTimer = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "xiaoqiang"
  L6 = "common"
  L7 = "BLUE_LED_TIMER"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L1.status = L2
  L3 = L0
  L2 = L0.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "BLUE_LED_TIMER_OPEN"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.timer_open = L2
  L3 = L0
  L2 = L0.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "BLUE_LED_TIMER_CLOSE"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.timer_close = L2
  return L1
end
getLedTimerStatus = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "mobile_accel"
  L4 = "settings"
  L5 = "enabled"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "0" then
    L2 = "0"
    return L2
  end
  L3 = L0
  L2 = L0.get
  L4 = "mobile_accel"
  L5 = "settings"
  L6 = "client_active"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L4 = L0
  L3 = L0.get
  L5 = "mobile_accel"
  L6 = "settings"
  L7 = "client_active_max"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = tonumber
  L5 = L2
  L4 = L4(L5)
  L5 = tonumber
  L6 = L3
  L5 = L5(L6)
  if L4 >= L5 then
    L4 = "0"
    return L4
  end
  L5 = L0
  L4 = L0.get
  L6 = "xiaoqiang"
  L7 = "common"
  L8 = "NETMODE"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  if L4 ~= "wifiapmode" and L4 ~= "lanapmode" then
    L5 = _UPVALUE0_
    L5 = L5.isMeshRe
    L5 = L5()
    if not L5 then
      goto lbl_63
    end
  end
  L5 = "0"
  do return L5 end
  ::lbl_63::
  L5 = "1"
  return L5
end
getMobileAccel = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "miwifi"
  L4 = "server"
  L5 = "BROKER"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = string
  L2 = L2.sub
  L3 = L1
  L4 = 1
  L5 = 2
  L2 = L2(L3, L4, L5)
  L3 = string
  L3 = L3.upper
  L4 = L2
  return L3(L4)
end
getServer = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "supportMesh"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  L2 = L2(L3)
  if L2 == "1" then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
isSupportMesh = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = "mesh_cmd backhaul get band"
  L1 = L1(L2)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  return L2(L3)
end
getMeshBackhaul = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
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
  L4 = "misc"
  L5 = "features"
  L6 = "lanWanSwitch"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = "0"
  L4 = isSupportMesh
  L4 = L4()
  if L4 then
    L4 = L0.trim
    L5 = L0.exec
    L6 = "mesh_cmd mesh_suites"
    L5 = L5(L6)
    L5 = L5 or L5
    L4 = L4(L5)
    L3 = L4
  end
  L5 = L1
  L4 = L1.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "wl_if_count"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L6 = L1
  L5 = L1.get
  L7 = "misc"
  L8 = "features"
  L9 = "game"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L6 = {}
  L7 = tostring
  L8 = L2
  L7 = L7(L8)
  L6.lanWanSwitch = L7
  L7 = tostring
  L8 = L3
  L7 = L7(L8)
  L6.meshSuites = L7
  L7 = tostring
  L8 = L4
  L7 = L7(L8)
  L6.bandNum = L7
  L7 = tostring
  L8 = L5
  L7 = L7(L8)
  L6.game = L7
  return L6
end
getMiscFeaturesInfo = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "redmi"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  L2 = L2(L3)
  if L2 == "1" then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
isRedmi = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "hardware"
  L5 = "displayName"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = _UPVALUE0_
  L2 = L2.bdataGet
  L3 = "subModel"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L4 = L0
    L3 = L0.get
    L5 = "misc"
    L6 = L2
    L7 = "displayName"
    L3 = L3(L4, L5, L6, L7)
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      L4 = tostring
      L5 = L3
      return L4(L5)
    end
  end
  L3 = tostring
  L4 = L1
  return L3(L4)
end
getDisplayName = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "hardware"
  L5 = "displayName"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L3 = L0
  L2 = L0.get
  L4 = "misc"
  L5 = "hardware"
  L6 = "seriesName"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = 0
  L5 = L0
  L4 = L0.foreach
  L6 = "misc"
  L7 = "custom"
  function L8(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L1 = L1.isStrNil
    L2 = A0.displayName
    L1 = L1(L2)
    if not L1 then
      L1 = _UPVALUE0_
      L1 = L1.isStrNil
      L2 = _UPVALUE1_
      L1 = L1(L2)
      if not L1 then
        L1 = _UPVALUE1_
        L2 = "/"
        L3 = A0.displayName
        L1 = L1 .. L2 .. L3
        _UPVALUE1_ = L1
        L1 = 1
        _UPVALUE2_ = L1
      else
        L1 = A0.displayName
        _UPVALUE1_ = L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  if L3 == 1 then
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = L2
    L4 = L4(L5)
    if not L4 then
      L4 = L2
      L5 = "("
      L6 = L1
      L7 = ")"
      L1 = L4 .. L5 .. L6 .. L7
    end
  end
  return L1
end
getDisplayNameListStr = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "supportNewTopo"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  L2 = L2(L3)
  if L2 == "1" then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
isSupportNewTopo = L2
function L2()
  local L0, L1
  L0 = 1
  return L0
end
getSecAcc = L2
function L2()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = L0.system
  L1 = L1.GdprPrivacy
  if L1 == "1" then
    L1 = 1
    return L1
  else
    L1 = 0
    return L1
  end
end
getGdprPrivacy = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "supportWifiAp"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  L2 = L2(L3)
  if L2 == "1" then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
isWifiApSupport = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L5 = "mesh"
  L6 = "version"
  versionlist = L2
  if L2 then
    for L5, L6 in L2, L3, L4 do
      L7 = tonumber
      L8 = L6
      L7 = L7(L8)
      if L7 == A0 then
        L7 = true
        return L7
      end
    end
  end
  return L2
end
isSupportMeshVersion = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec_trim
  L2 = "mesh_cmd mlo_support"
  L3 = "0"
  L1 = L1(L2, L3)
  if L1 ~= "1" then
    L2 = false
    return L2
  end
  L2 = true
  return L2
end
isMeshMLOSupport = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = L0.isMeshMLOSupport
  L2 = L2()
  if not L2 then
    L2 = false
    return L2
  end
  L3 = L1
  L2 = L1.get
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  if L2 ~= "nil" then
    L3 = string
    L3 = L3.split
    L3 = L3(L4, L5)
    for L7, L8 in L4, L5, L6 do
      if L8 ~= nil and L8 == "2g" then
        L9 = true
        return L9
      end
    end
  end
  L3 = false
  return L3
end
isMeshMLOSupport_2G = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "mesh"
  L5 = "support_dfs"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "1" then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
isMeshSupportDFS = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "account"
  L4 = "legacy"
  L1 = L1(L2, L3, L4)
  L1 = L1 or L1
  if L1 == "0" then
    L2 = 0
    return L2
  else
    L2 = 1
    return L2
  end
end
getEncryptMode = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "mobile"
  L4 = "device"
  L5 = "imei"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "" then
    L2 = require
    L3 = "ubus"
    L2 = L2(L3)
    L2 = L2.connect
    L2 = L2()
    L4 = L2
    L3 = L2.call
    L5 = "mobile"
    L6 = "device"
    L7 = {}
    L7.method = "imei"
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = L3.code
      if L4 then
        L4 = L3.code
        if L4 == 0 then
          L1 = L3.imei
        end
      end
    end
  end
  return L1
end
getIMEI = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "mobile"
  L4 = "device"
  L5 = "imeisv"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "" then
    L2 = require
    L3 = "ubus"
    L2 = L2(L3)
    L2 = L2.connect
    L2 = L2()
    L4 = L2
    L3 = L2.call
    L5 = "mobile"
    L6 = "device"
    L7 = {}
    L7.method = "imei"
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = L3.code
      if L4 then
        L4 = L3.code
        if L4 == 0 then
          L1 = L3.sv
        end
      end
    end
  end
  return L1
end
getIMEISV = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_ROM_HWVERSION
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getHwVersion = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "mobile"
  L4 = "device"
  L5 = "version"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
getModuleSoftwareVersion = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "wireless"
  L4 = "wps"
  L5 = "enable"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tostring
  L3 = L1
  L2 = L2(L3)
  if L2 == "1" then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
getWpsEnabled = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_list
  L3 = "system"
  L4 = "ntp"
  L5 = "server"
  L1 = L1(L2, L3, L4, L5)
  return L1
end
getNTPServerList = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get_list
  L5 = "system"
  L3 = L3(L4, L5, L6, L7)
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L5 = L5(L6)
  if not L5 then
    L5 = table
    L5 = L5.insert
    L5(L6, L7)
  end
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L5 = L5(L6)
  if not L5 then
    L5 = table
    L5 = L5.insert
    L5(L6, L7)
  end
  L5 = false
  for L9, L10 in L6, L7, L8 do
    for L14, L15 in L11, L12, L13 do
      if L10 == L15 then
        L5 = true
        break
      end
      L5 = false
    end
    if not L5 then
      break
    end
  end
  if not L5 then
    L9 = "ntp"
    L10 = "server"
    L6(L7, L8, L9, L10)
    L9 = "ntp"
    L10 = "server"
    L6(L7, L8, L9, L10, L11)
    L6(L7, L8)
    L6(L7, L8)
    L6(L7)
  end
  return L6
end
setNTPServer = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
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
  L6 = "system"
  L7 = "ntp"
  L8 = "timemode"
  L4 = L4(L5, L6, L7, L8)
  L5 = {}
  if L4 then
    L6 = tonumber
    L7 = L4
    L6 = L6(L7)
    if L6 then
      goto lbl_23
    end
  end
  L6 = 0
  ::lbl_23::
  L5.mode = L6
  L5.sync = 0
  if A1 and L4 ~= A1 then
    L7 = L3
    L6 = L3.set
    L8 = "system"
    L9 = "ntp"
    L10 = "timemode"
    L11 = A1
    L6(L7, L8, L9, L10, L11)
    L6 = tonumber
    L7 = A1
    L6 = L6(L7)
    L5.mode = L6
    if A1 == "0" then
      L7 = L3
      L6 = L3.set
      L8 = "system"
      L9 = "ntp"
      L10 = "enabled"
      L11 = 1
      L6(L7, L8, L9, L10, L11)
      L7 = L3
      L6 = L3.commit
      L8 = "system"
      L6(L7, L8)
      if A0 == "1" then
        L6 = L2.exec
        L7 = "/usr/sbin/ntpsetclock now"
        L6(L7)
        L5.sync = 1
      else
        L6 = _UPVALUE0_
        L6 = L6.forkExec
        L7 = "/usr/sbin/ntpsetclock now"
        L6(L7)
      end
    else
      L7 = L3
      L6 = L3.set
      L8 = "system"
      L9 = "ntp"
      L10 = "enabled"
      L11 = 0
      L6(L7, L8, L9, L10, L11)
      L7 = L3
      L6 = L3.commit
      L8 = "system"
      L6(L7, L8)
    end
  end
  return L5
end
timeMode = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L2 = _UPVALUE0_
  L2 = L2.getFeature
  L3 = "1"
  L4 = "system"
  L5 = "sp_lib"
  L2 = L2(L3, L4, L5)
  if L2 ~= "1" then
    return
  end
  L2 = require
  L3 = "xiaoqiang.XQStatPoints"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = "/data/usr/log/login_records"
  L6 = L3
  L5 = L3.get
  L7 = "system"
  L8 = "@system[0]"
  L9 = "login_records_max"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L7 = L3
  L6 = L3.get
  L8 = "system"
  L9 = "@system[0]"
  L10 = "login_records_file"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = os
  L7 = L7.date
  L8 = "%Y/%m/%d %H:%M:%S"
  L7 = L7(L8)
  L8 = L7
  L7 = L7.match
  L9 = "(%S+) (%S+)"
  L7, L8 = L7(L8, L9)
  L9 = "date="
  L10 = L7
  L11 = ";"
  L12 = "time="
  L13 = L8
  L14 = ";"
  L15 = "ip="
  L16 = A0
  L17 = ";"
  L18 = "mac="
  L19 = A1
  L9 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18 .. L19
  L10 = L2.LogToFile
  L11 = "sys.ctrl"
  L12 = L9
  L13 = L6
  L14 = L5
  L10(L11, L12, L13, L14)
end
writeLoginRecord = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = "/data/usr/log/login_records"
  L4 = L0
  L3 = L0.get
  L5 = "system"
  L6 = "@system[0]"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L5 = L0
  L4 = L0.get
  L6 = "system"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5 = "tail -n "
  L6 = L3
  L5 = L5 .. L6 .. L7 .. L8
  L6 = luci
  L6 = L6.util
  L6 = L6.execi
  L6 = L6(L7)
  for L10 in L7, L8, L9 do
    L12 = L10
    L11 = L10.match
    L13 = "date=(%S+);time=(%S+);ip=(%S+);mac=(%S+)"
    L11 = L11(L12, L13)
    if L11 then
      L12 = L10
      L11 = L10.match
      L13 = "date=(%S+);time=(%S+);ip=(%S+);mac=(%S+)"
      L11, L12, L13, L14 = L11(L12, L13)
      L15 = table
      L15 = L15.insert
      L16 = L1
      L17 = {}
      L17.date = L11
      L17.time = L12
      L17.ip = L13
      L17.mac = L14
      L15(L16, L17)
    end
  end
  return L1
end
readLoginRecord = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = "/data/usr/log/login_records"
  L3 = L0
  L2 = L0.get
  L4 = "system"
  L5 = "@system[0]"
  L6 = "login_records_file"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = io
  L3 = L3.open
  L4 = L2
  L5 = "w"
  L3 = L3(L4, L5)
  L4 = L3
  L3 = L3.close
  L3(L4)
end
clearLoginRecord = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = {}
  L4 = L0
  L3 = L0.foreach
  L5 = "timezone"
  L6 = "timezone"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = {}
    L2 = A0.index
    L1.index = L2
    L2 = A0.tz
    L1.timezone = L2
    L2 = A0.z_name
    L2 = L2 .. L3
    if L3 == "table" then
      for L6, L7 in L3, L4, L5 do
        L8 = L2
        L9 = translate
        L10 = L7
        L9 = L9(L10)
        L10 = ", "
        L2 = L8 .. L9 .. L10
      end
      L6 = -3
      L1.name = L3
    else
      L1.name = L3
    end
    L3(L4, L5)
  end
  L3(L4, L5, L6, L7)
  L3 = table
  L3 = L3.sort
  L4 = L2
  function L5(A0, A1)
    local L2, L3, L4, L5, L6, L7
    L2 = A0.name
    L3 = L2
    L2 = L2.match
    L4 = "%((UTC%S+)%)"
    L2 = L2(L3, L4)
    L3 = A1.name
    L4 = L3
    L3 = L3.match
    L5 = "%((UTC%S+)%)"
    L3 = L3(L4, L5)
    L5 = L2
    L4 = L2.gsub
    L6 = ":"
    L7 = "."
    L4 = L4(L5, L6, L7)
    L2 = L4
    L5 = L3
    L4 = L3.gsub
    L6 = ":"
    L7 = "."
    L4 = L4(L5, L6, L7)
    L3 = L4
    L5 = L2
    L4 = L2.gsub
    L6 = "UTC"
    L7 = ""
    L4 = L4(L5, L6, L7)
    L2 = L4
    L5 = L3
    L4 = L3.gsub
    L6 = "UTC"
    L7 = ""
    L4 = L4(L5, L6, L7)
    L3 = L4
    L4 = tonumber
    L5 = L2
    L4 = L4(L5)
    L2 = L4
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    if L2 < L3 then
      L4 = true
      return L4
    else
      L4 = false
      return L4
    end
  end
  L3(L4, L5)
  L3 = L1.encode
  L4 = L2
  L3 = L3(L4)
  return L3
end
getTimeZoneList = L2
