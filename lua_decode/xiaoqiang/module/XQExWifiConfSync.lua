local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
L0 = module
L1 = "xiaoqiang.module.XQExWifiConfSync"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQCryptoUtil"
L3 = L3(L4)
L4 = "/tmp/extendwifi/"
L5 = "/etc/config/"
L6 = "/etc/xqDb"
L7 = "config.tar.gz"
L8 = 6
L9 = {}
L9.ERROR_INTERNAL = 1639
L9.ERROR_PEER_INFO = 1640
L9.ERROR_CONFIG_TRANS = 1641
L9.ERROR_INVALID_MODE = 1642
function L10()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQExtendWifi"
  L0 = L0(L1)
  L1 = L0.get_token
  L1 = L1()
  if not L1 then
    L2 = _UPVALUE0_
    L2 = L2.log
    L3 = _UPVALUE1_
    L4 = "get token failed!"
    L2(L3, L4)
    L2 = nil
    return L2
  end
  L2 = L0.get_peer_ip
  L2 = L2()
  if not L2 then
    L3 = _UPVALUE0_
    L3 = L3.log
    L4 = _UPVALUE1_
    L5 = "get remote address failed!"
    L3(L4, L5)
    L3 = nil
    return L3
  end
  L3 = L2
  L4 = L1
  return L3, L4
end
function L11(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "rm -rf "
  L4 = A0
  L3 = L3 .. L4
  L2(L3)
  L2 = L1.mkdir
  L3 = A0
  L4 = 600
  return L2(L3, L4)
end
function L12(A0)
  local L1, L2, L3
  L1 = os
  L1 = L1.execute
  L2 = "rm -rf "
  L3 = A0
  L2 = L2 .. L3
  L1(L2)
end
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = require
  L3 = "xiaoqiang.module.XQExWifiConfSyncUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L4 = _UPVALUE1_
  L3 = L3 .. L4
  L4, L5, L6, L7, L8 = nil, nil, nil, nil, nil
  L9 = _UPVALUE2_
  L9 = L9.log
  L10 = _UPVALUE3_
  L11 = "work in active mode"
  L9(L10, L11)
  if not A0 or not A1 then
    L9 = _UPVALUE2_
    L9 = L9.log
    L10 = _UPVALUE3_
    L11 = "invalid input parameter!"
    L9(L10, L11)
    L9 = _UPVALUE4_
    L9 = L9.ERROR_PEER_INFO
    return L9
  end
  L9 = _UPVALUE5_
  L10 = _UPVALUE0_
  L9 = L9(L10)
  L4 = L9
  if not L4 then
    L9 = _UPVALUE2_
    L9 = L9.log
    L10 = _UPVALUE3_
    L11 = "work directory create failed, "
    L12 = _UPVALUE0_
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = _UPVALUE4_
    L9 = L9.ERROR_INTERNAL
    return L9
  end
  L9 = os
  L9 = L9.execute
  L10 = "tar -zcvf "
  L11 = L3
  L12 = " "
  L13 = _UPVALUE6_
  L14 = " "
  L15 = _UPVALUE7_
  L16 = " >/dev/null 2>&1"
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15 .. L16
  L9(L10)
  L9 = L2.config_post
  L10 = A0
  L11 = A1
  L12 = L3
  L9, L10, L11, L12, L13 = L9(L10, L11, L12)
  L8 = L13
  L7 = L12
  L6 = L11
  L5 = L10
  L4 = L9
  L9 = _UPVALUE8_
  L10 = _UPVALUE0_
  L9(L10)
  L9 = L4
  L10 = L5
  L11 = L6
  L12 = L7
  L13 = L8
  return L9, L10, L11, L12, L13
end
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = require
  L3 = "xiaoqiang.module.XQExWifiConfSyncUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQExWifiConfSyncUci"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L5 = _UPVALUE1_
  L4 = L4 .. L5
  L5 = nil
  L6 = _UPVALUE2_
  L6 = L6.log
  L7 = _UPVALUE3_
  L8 = "work in passive mode"
  L6(L7, L8)
  if not A0 or not A1 then
    L6 = _UPVALUE2_
    L6 = L6.log
    L7 = _UPVALUE3_
    L8 = "invalid input parameter!"
    L6(L7, L8)
    L6 = _UPVALUE4_
    L6 = L6.ERROR_PEER_INFO
    return L6
  end
  L6 = _UPVALUE5_
  L7 = _UPVALUE0_
  L6 = L6(L7)
  L5 = L6
  if not L5 then
    L6 = _UPVALUE2_
    L6 = L6.log
    L7 = _UPVALUE3_
    L8 = "work directory create failed, "
    L9 = _UPVALUE0_
    L8 = L8 .. L9
    L6(L7, L8)
    L6 = _UPVALUE4_
    L6 = L6.ERROR_INTERNAL
    return L6
  end
  L6 = L2.config_get
  L7 = A0
  L8 = A1
  L9 = L4
  L6 = L6(L7, L8, L9)
  L5 = L6
  if L5 ~= 0 then
    L6 = _UPVALUE2_
    L6 = L6.log
    L7 = _UPVALUE3_
    L8 = "config file fetch failed!"
    L6(L7, L8)
    L6 = _UPVALUE6_
    L7 = _UPVALUE0_
    L6(L7)
    return L5
  end
  L6 = os
  L6 = L6.execute
  L7 = "tar -C "
  L8 = _UPVALUE0_
  L9 = " -zxvf "
  L10 = L4
  L11 = " >/dev/null 2>&1"
  L7 = L7 .. L8 .. L9 .. L10 .. L11
  L6(L7)
  L6 = L3.config_merge
  L6 = L6()
  L5 = L6
  L6 = _UPVALUE6_
  L7 = _UPVALUE0_
  L6(L7)
  L6 = L3.hotspot_info
  L6, L7, L8, L9 = L6()
  L10 = L5
  L11 = L6
  L12 = L7
  L13 = L8
  L14 = L9
  return L10, L11, L12, L13, L14
end
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "xiaoqiang.module.XQExWifiConfSyncUtil"
  L2 = L2(L3)
  L3 = L2.config_finish
  L4 = A0
  L5 = A1
  L6 = nil
  L7 = "yes"
  L3 = L3(L4, L5, L6, L7)
  if L3 == 0 then
    L4 = extendwifi_hotspot_shutdown
    L4()
  end
end
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "xiaoqiang.module.XQExWifiConfSyncUtil"
  L2 = L2(L3)
  L3 = L2.config_finish
  L4 = A0
  L5 = A1
  L6 = "off"
  L7 = nil
  L3 = L3(L4, L5, L6, L7)
  L4 = extendwifi_reboot
  L4()
end
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = require
  L2 = "xiaoqiang.module.XQExWifiConfSyncUci"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = _UPVALUE1_
  L5 = "enter _apcli_shutdown"
  L3(L4, L5)
  if not A0 then
    return
  end
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = _UPVALUE1_
  L5 = "apcli_ifname: "
  L6 = A0
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = "killall -9 wpa_supplicant"
  L4 = "ifconfig "
  L5 = A0
  L6 = " down"
  L4 = L4 .. L5 .. L6
  L5 = "wlanconfig "
  L6 = A0
  L7 = " destroy"
  L5 = L5 .. L6 .. L7
  L6 = L2.apcli_get_device
  L7 = A0
  L6 = L6(L7)
  L7 = "ifconfig "
  L9 = L6
  L8 = L6.name
  L8 = L8(L9)
  L9 = " down"
  L7 = L7 .. L8 .. L9
  L8 = _UPVALUE2_
  L8 = L8.forkExec
  L9 = "sleep 2; "
  L10 = L3
  L11 = "; "
  L12 = L4
  L13 = "; "
  L14 = L5
  L15 = "; "
  L16 = L7
  L17 = ";"
  L9 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L8(L9)
end
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L1 = _UPVALUE1_
  L0 = L0 .. L1
  L1 = nil
  L2 = _UPVALUE2_
  L2 = L2.log
  L3 = _UPVALUE3_
  L4 = "enter extendwifi_config_pull"
  L2(L3, L4)
  L2 = _UPVALUE4_
  L3 = _UPVALUE0_
  L2 = L2(L3)
  res = L2
  L2 = res
  if not L2 then
    L2 = _UPVALUE2_
    L2 = L2.log
    L3 = _UPVALUE3_
    L4 = "work directory create failed, "
    L5 = _UPVALUE0_
    L4 = L4 .. L5
    L2(L3, L4)
    L2 = nil
    return L2
  end
  L2 = os
  L2 = L2.execute
  L3 = "tar -zcvf "
  L4 = L0
  L5 = " "
  L6 = _UPVALUE5_
  L7 = " "
  L8 = _UPVALUE6_
  L9 = " >/dev/null 2>&1"
  L3 = L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9
  L2(L3)
  L2 = io
  L2 = L2.open
  L3 = L0
  L4 = "r"
  L2 = L2(L3, L4)
  if not L2 then
    L3 = _UPVALUE2_
    L3 = L3.log
    L4 = _UPVALUE3_
    L5 = "config file open failed!"
    L3(L4, L5)
    L3 = _UPVALUE7_
    L4 = _UPVALUE0_
    L3(L4)
    L3 = nil
    return L3
  end
  L3 = _UPVALUE8_
  L3 = L3.md5File
  L4 = L0
  L3 = L3(L4)
  if not L3 then
    L4 = _UPVALUE2_
    L4 = L4.log
    L5 = _UPVALUE3_
    L6 = "config file calculate md5sum failed!"
    L4(L5, L6)
    L4 = io
    L4 = L4.close
    L5 = L2
    L4(L5)
    L4 = _UPVALUE7_
    L5 = _UPVALUE0_
    L4(L5)
    L4 = nil
    return L4
  end
  L4 = _UPVALUE9_
  L4 = L4.header
  L5 = "Content-Checksum"
  L6 = L3
  L4(L5, L6)
  L4 = _UPVALUE9_
  L4 = L4.header
  L5 = "Content-Disposition"
  L6 = {}
  L7 = _UPVALUE1_
  L6[1] = L7
  L6 = "attachment; filename=\"%s\"" % L6
  L4(L5, L6)
  L4 = _UPVALUE9_
  L4 = L4.prepare_content
  L5 = "application/otect-stream"
  L4(L5)
  while true do
    L5 = L2
    L4 = L2.read
    L6 = nixio
    L6 = L6.const
    L6 = L6.buffersize
    L4 = L4(L5, L6)
    L1 = L4
    if not L1 then
      break
    end
    L4 = #L1
    if L4 == 0 then
      break
    else
      L4 = _UPVALUE9_
      L4 = L4.write
      L5 = L1
      L4(L5)
    end
  end
  L5 = L2
  L4 = L2.close
  L4(L5)
  L4 = _UPVALUE9_
  L4 = L4.close
  L4()
  L4 = _UPVALUE7_
  L5 = _UPVALUE0_
  L4(L5)
  L4 = 0
  return L4
end
extendwifi_config_pull = L18
function L18()
  local L0, L1
end
extendwifi_config_push = L18
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQExWifiConfSyncUci"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = _UPVALUE1_
  L3 = "enter extendwifi_config_merge"
  L1(L2, L3)
  L1 = L0.config_merge
  L1 = L1()
  L2 = L0.hotspot_info
  L2, L3, L4, L5 = L2()
  L6 = L1
  L7 = L2
  L8 = L3
  L9 = L4
  L10 = L5
  return L6, L7, L8, L9, L10
end
extendwifi_config_merge = L18
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.module.XQExtendWifi"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.log
  L2(L3, L4)
  L2 = L1.apcli_get_ifnames
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE2_
    L9 = L7
    L8(L9)
  end
  L3(L4)
  if L3 then
    L3(L4)
    L6 = L0.get_self_ifname
    L6 = L6()
    L3(L4, L5)
  else
    L3(L4)
    L3(L4, L5)
  end
  return L3
end
extendwifi_hotspot_shutdown = L18
function L18()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  XQSysUtil = L0
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "enter extendwifi_reboot"
  L0(L1, L2)
  L0 = XQSysUtil
  L0 = L0.setSPwd
  L0()
  L0 = _UPVALUE2_
  L0 = L0.forkExec
  L1 = "(sleep 1; /usr/sbin/set_wps_state 2;)"
  L0(L1)
  L0 = _UPVALUE2_
  L0 = L0.forkExec
  L1 = "(sleep 2; /usr/sbin/sysapi webinitrdr set off; reboot;)"
  L0(L1)
  L0 = 0
  return L0
end
extendwifi_reboot = L18
L18 = {}
L18.active = L13
L18.passive = L14
L19 = {}
L19.active = L15
L19.passive = L16
function L20(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L8 = _UPVALUE0_
  L8 = L8.log
  L9 = _UPVALUE1_
  L10 = "enter extendwifi_config_sync"
  L8(L9, L10)
  if not A0 then
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "invalid input parameter!"
    L8(L9, L10)
    L8 = _UPVALUE2_
    L8 = L8.ERROR_INVALID_MODE
    return L8
  end
  if A0 == "1" then
    A0 = "active"
  elseif A0 == "2" then
    A0 = "passive"
  else
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "unknown work mode "
    L11 = A0
    L10 = L10 .. L11
    L8(L9, L10)
    L8 = _UPVALUE2_
    L8 = L8.ERROR_INVALID_MODE
    return L8
  end
  L8 = _UPVALUE3_
  L8, L9 = L8()
  if not L8 or not L9 then
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "get peer info failed!"
    L10(L11, L12)
    L10 = _UPVALUE2_
    L10 = L10.ERROR_PEER_INFO
    return L10
  end
  L10 = _UPVALUE0_
  L10 = L10.log
  L11 = _UPVALUE1_
  L12 = "peer info, remote: "
  L13 = L8
  L14 = " mode: "
  L15 = A0
  L12 = L12 .. L13 .. L14 .. L15
  L10(L11, L12)
  if not A1 then
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "config sync start!"
    L10(L11, L12)
    L10 = _UPVALUE4_
    L7 = L10[A0]
    if L7 then
      L10 = L7
      L11 = L8
      L12 = L9
      L10, L11, L12, L13, L14 = L10(L11, L12)
      L6 = L14
      L5 = L13
      L4 = L12
      L3 = L11
      L2 = L10
    end
    if not L2 then
      L10 = _UPVALUE2_
      L2 = L10.ERROR_INTERNAL
    end
    L10 = L2
    L11 = L3
    L12 = L4
    L13 = L5
    L14 = L6
    return L10, L11, L12, L13, L14
  else
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "config sync finish!"
    L10(L11, L12)
    L10 = _UPVALUE5_
    L7 = L10[A0]
    if L7 then
      L10 = L7
      L11 = L8
      L12 = L9
      L10(L11, L12)
    end
  end
end
extendwifi_config_sync = L20
