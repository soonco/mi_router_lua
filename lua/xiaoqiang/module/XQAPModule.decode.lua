local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.module.XQAPModule"
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
L3 = "luci.util"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQMessageBox"
  L0 = L0(L1)
  L1 = L0.removeMessage
  L2 = 4
  L1(L2)
  L1 = require
  L2 = "xiaoqiang.XQVersion"
  L1 = L1(L2)
  L1 = L1.webDefaultHost
  L2 = "http://"
  L3 = L1
  L1 = L2 .. L3
  L2 = _UPVALUE0_
  L2 = L2.trim
  L3 = _UPVALUE0_
  L3 = L3.exec
  L4 = "get_alias_ip 2>/dev/null"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = L3.getIpv4Info
  L5 = "wan"
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L2
  L5 = L5(L6)
  if not L5 then
    if L4 then
      L5 = L4.gw
      if L5 == L2 then
        return L1
    end
    else
      return L2
    end
  end
  return L1
end
QuickSetLanAPMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.XQVersion"
  L0 = L0(L1)
  L0 = L0.webDefaultHost
  L1 = "http://"
  L2 = L0
  L0 = L1 .. L2
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "network"
  L4 = "lan"
  L5 = "ipaddr_back"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    return L1
  end
  return L0
end
QuickDisableLanAP = L4
function L4(A0, A1)
  local L2, L3, L4, L5
  L2 = [[
        /usr/sbin/set_apmode_quick.sh enable
    ]]
  L3 = [[
        /usr/sbin/set_apmode_quick.sh disable
    ]]
  if A1 then
    if A0 then
      L4 = _UPVALUE0_
      L4 = L4.forkExec
      L5 = L2
      L4(L5)
    else
      L4 = _UPVALUE0_
      L4 = L4.forkExec
      L5 = L3
      L4(L5)
    end
  elseif A0 then
    L4 = os
    L4 = L4.execute
    L5 = L2
    L4(L5)
  else
    L4 = os
    L4 = L4.execute
    L5 = L3
    L4(L5)
  end
end
QuickLanApServiceRestart = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = L0.system
  L1 = L1.QuickApMode
  if L1 then
    L1 = L0.system
    L1 = L1.QuickApMode
    if L1 == "1" then
      L1 = QuickSetLanAPMode
      return L1()
    end
  end
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQMessageBox"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.getNetMode
  L4 = L4()
  L5 = L2.getLanIp
  L5 = L5()
  if L4 ~= "wifiapmode" and L4 ~= "lanapmode" then
    L6 = require
    L7 = "luci.model.uci"
    L6 = L6(L7)
    L6 = L6.cursor
    L6 = L6()
    L8 = L6
    L7 = L6.get_all
    L9 = "network"
    L10 = "lan"
    L7 = L7(L8, L9, L10)
    L9 = L6
    L8 = L6.section
    L10 = "backup"
    L11 = "backup"
    L12 = "lan"
    L13 = L7
    L8(L9, L10, L11, L12, L13)
    L9 = L6
    L8 = L6.commit
    L10 = "backup"
    L8(L9, L10)
  end
  L6 = os
  L6 = L6.execute
  L7 = "/usr/sbin/lanap_mode.sh connect >/dev/null 2>/dev/null"
  L6(L7)
  L6 = L2.getLanIp
  L6 = L6()
  if L5 ~= L6 then
    L7 = require
    L8 = "xiaoqiang.util.XQSynchrodata"
    L7 = L7(L8)
    L8 = L3.removeMessage
    L9 = 4
    L8(L9)
    L8 = L1.setWiFiMacfilterModel
    L9 = false
    L8(L9)
    L8 = L1.closeGuestWifi
    L9 = 1
    L8(L9)
    L8 = L1.closeGuestWifi
    L9 = 2
    L8(L9)
    L8 = _UPVALUE0_
    L8 = L8.setNetMode
    L9 = "lanapmode"
    L8(L9)
    if L4 == "whc_cap" then
      L8 = _UPVALUE0_
      L8 = L8.setCAPMode
      L9 = "ap"
      L8(L9)
    end
    L8 = L7.syncApLanIp
    L9 = L6
    L8(L9)
    return L6
  end
  L7 = nil
  return L7
end
setLanAPMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQMessageBox"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.getNetMode
  L4 = L4()
  L5 = L1.getLanIp
  L5 = L5()
  L6 = os
  L6 = L6.execute
  L7 = "cp /etc/config/network /etc/config/.network.mode.router"
  L6(L7)
  if L4 ~= "wifiapmode" and L4 ~= "lanapmode" then
    L7 = L3
    L6 = L3.get_all
    L8 = "network"
    L9 = "lan"
    L6 = L6(L7, L8, L9)
    L8 = L3
    L7 = L3.section
    L9 = "backup"
    L10 = "backup"
    L11 = "lan"
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L8 = L3
    L7 = L3.commit
    L9 = "backup"
    L7(L8, L9)
  end
  L6 = os
  L6 = L6.execute
  L7 = "/usr/sbin/lanap_mode.sh connect >/dev/null 2>/dev/null"
  L6(L7)
  L6 = L1.getLanIp
  L6 = L6()
  L7 = L2.removeMessage
  L8 = 4
  L7(L8)
  L7 = L0.setWiFiMacfilterModel
  L8 = false
  L7(L8)
  L7 = _UPVALUE0_
  L7 = L7.setNetMode
  L8 = "lanapmode"
  L7(L8)
  if L5 ~= L6 then
    L7 = require
    L8 = "xiaoqiang.util.XQSynchrodata"
    L7 = L7(L8)
    L8 = L7.syncApLanIp
    L9 = L6
    L8(L9)
    return L6
  else
    L8 = L3
    L7 = L3.set
    L9 = "network"
    L10 = "lan"
    L11 = "proto"
    L12 = "dhcp"
    L7(L8, L9, L10, L11, L12)
    L8 = L3
    L7 = L3.commit
    L9 = "network"
    L7(L8, L9)
  end
  L7 = nil
  return L7
end
setLanAPModeForce = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = L0.system
  L1 = L1.QuickApMode
  if L1 then
    L1 = L0.system
    L1 = L1.QuickApMode
    if L1 == "1" then
      L1 = QuickDisableLanAP
      return L1()
    end
  end
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "backup"
  L6 = "lan"
  L7 = "ipaddr"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.getCAPMode
  L4 = L4()
  if L4 == 1 then
    L5 = _UPVALUE0_
    L5 = L5.setNetMode
    L6 = "whc_cap"
    L5(L6)
    L5 = _UPVALUE0_
    L5 = L5.setCAPMode
    L6 = "router"
    L5(L6)
  else
    L5 = _UPVALUE0_
    L5 = L5.setNetMode
    L6 = nil
    L5(L6)
  end
  L6 = L2
  L5 = L2.get_all
  L7 = "backup"
  L8 = "lan"
  L5 = L5(L6, L7, L8)
  L7 = L2
  L6 = L2.delete
  L8 = "network"
  L9 = "lan"
  L6(L7, L8, L9)
  L7 = L2
  L6 = L2.section
  L8 = "network"
  L9 = "interface"
  L10 = "lan"
  L11 = L5
  L6(L7, L8, L9, L10, L11)
  L7 = L2
  L6 = L2.set
  L8 = "network"
  L9 = "vpn"
  L10 = "disabled"
  L11 = "0"
  L6(L7, L8, L9, L10, L11)
  L6 = os
  L6 = L6.execute
  L7 = _UPVALUE1_
  L7 = L7.SET_VPN_USER_OPTION
  L8 = "1"
  L7 = L7 .. L8
  L6(L7)
  L7 = L2
  L6 = L2.commit
  L8 = "network"
  L6(L7, L8)
  L6 = L1.setWiFiMacfilterModel
  L7 = false
  L6(L7)
  return L3
end
disableLanAP = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "xiaoqiang.XQFeatures"
  L3 = L3(L4)
  L3 = L3.FEATURES
  L4 = L3.system
  L4 = L4.QuickApMode
  if L4 then
    L4 = L3.system
    L4 = L4.QuickApMode
    if L4 == "1" then
      L4 = QuickLanApServiceRestart
      L5 = A0
      L6 = A1
      return L4(L5, L6)
    end
  end
  L4 = " /usr/sbin/shareUpdate -b >/dev/null 2>/dev/null; "
  L5 = " /usr/sbin/lanap_mode.sh open; "
  L6 = " /usr/sbin/lanap_mode.sh close; "
  L7 = " sleep 7; "
  if nil == A0 or nil == A1 or nil == A2 then
    return
  end
  if A2 then
    if A0 then
      L8 = L7
      L9 = L5
      L10 = L4
      L4 = L8 .. L9 .. L10
    else
      L8 = L7
      L9 = L6
      L10 = L4
      L4 = L8 .. L9 .. L10
    end
  elseif A0 then
    L8 = L5
    L9 = L4
    L4 = L8 .. L9
  else
    L8 = L6
    L9 = L4
    L4 = L8 .. L9
  end
  if A1 then
    L8 = _UPVALUE0_
    L8 = L8.forkExec
    L9 = L4
    L8(L9)
  else
    L8 = os
    L8 = L8.execute
    L9 = L4
    L8(L9)
  end
  return
end
lanApServiceRestart = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.bdataGet
  L4 = "CountryCode"
  L5 = "CN"
  L3 = L3(L4, L5)
  L5 = L0
  L4 = L0.get_all
  L6 = "dhcp"
  L7 = "lan"
  L4 = L4(L5, L6, L7)
  L6 = L0
  L5 = L0.get_all
  L7 = "dhcp"
  L8 = "wan"
  L5 = L5(L6, L7, L8)
  L7 = L0
  L6 = L0.delete
  L8 = "backup"
  L9 = "lan"
  L6(L7, L8, L9)
  L7 = L0
  L6 = L0.delete
  L8 = "backup"
  L9 = "wifi1"
  L6(L7, L8, L9)
  L7 = L0
  L6 = L0.delete
  L8 = "backup"
  L9 = "wifi2"
  L6(L7, L8, L9)
  L7 = L0
  L6 = L0.delete
  L8 = "backup"
  L9 = "dhcplan"
  L6(L7, L8, L9)
  L7 = L0
  L6 = L0.delete
  L8 = "backup"
  L9 = "dhcpwan"
  L6(L7, L8, L9)
  if L3 == "CN" then
    L7 = L0
    L6 = L0.delete
    L8 = "backup"
    L9 = "vpn"
    L6(L7, L8, L9)
  end
  L7 = L0
  L6 = L0.section
  L8 = "backup"
  L9 = "backup"
  L10 = "dhcplan"
  L11 = L4
  L6(L7, L8, L9, L10, L11)
  L7 = L0
  L6 = L0.section
  L8 = "backup"
  L9 = "backup"
  L10 = "dhcpwan"
  L11 = L5
  L6(L7, L8, L9, L10, L11)
  L7 = L0
  L6 = L0.get_all
  L8 = "network"
  L9 = "lan"
  L6 = L6(L7, L8, L9)
  L8 = L0
  L7 = L0.delete
  L9 = "backup"
  L10 = "networklan"
  L7(L8, L9, L10)
  L8 = L0
  L7 = L0.section
  L9 = "backup"
  L10 = "backup"
  L11 = "networklan"
  L12 = L6
  L7(L8, L9, L10, L11, L12)
  L8 = L0
  L7 = L0.commit
  L9 = "backup"
  L7(L8, L9)
  L7 = L2.getInitInfo
  L7 = L7()
  if L7 then
    L7 = L1.backupWifiInfo
    L8 = 1
    L7(L8)
    L7 = L1.backupWifiInfo
    L8 = 2
    L7(L8)
  end
end
backupConfigs = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_all
  L3 = "backup"
  L4 = "dhcplan"
  L1 = L1(L2, L3, L4)
  L3 = L0
  L2 = L0.get_all
  L4 = "backup"
  L5 = "dhcpwan"
  L2 = L2(L3, L4, L5)
  if L1 then
    L4 = L0
    L3 = L0.section
    L5 = "dhcp"
    L6 = "dhcp"
    L7 = "lan"
    L8 = L1
    L3(L4, L5, L6, L7, L8)
  end
  if L2 then
    L4 = L0
    L3 = L0.section
    L5 = "dhcp"
    L6 = "dhcp"
    L7 = "wan"
    L8 = L2
    L3(L4, L5, L6, L7, L8)
  end
  L4 = L0
  L3 = L0.get_all
  L5 = "backup"
  L6 = "networklan"
  L3 = L3(L4, L5, L6)
  L5 = L0
  L4 = L0.delete
  L6 = "network"
  L7 = "lan"
  L4(L5, L6, L7)
  L5 = L0
  L4 = L0.section
  L6 = "network"
  L7 = "interface"
  L8 = "lan"
  L9 = L3
  L4(L5, L6, L7, L8, L9)
  L5 = L0
  L4 = L0.commit
  L6 = "dhcp"
  L4(L5, L6)
  L5 = L0
  L4 = L0.commit
  L6 = "network"
  L4(L5, L6)
end
recoveryConfigs = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.network"
  L1 = L1(L2)
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_network
  L4 = "wan"
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.get_network
  L5 = "wan6"
  L3 = L3(L4, L5)
  if L2 then
    L5 = L2
    L4 = L2.set
    L6 = "auto"
    L7 = A0
    L4(L5, L6, L7)
  end
  if L3 then
    L5 = L3
    L4 = L3.set
    L6 = "auto"
    L7 = A0
    L4(L5, L6, L7)
  end
  L5 = L1
  L4 = L1.commit
  L6 = "network"
  L4(L5, L6)
end
setWanAuto = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2, L3 = nil, nil
  L4 = recoveryConfigs
  L4()
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "network"
  L7 = "lan"
  L8 = "ipaddr"
  L4 = L4(L5, L6, L7, L8)
  L2 = L4
  L4 = L1.getWifissid
  L4 = L4()
  L3 = L4
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.set
  L6 = "network"
  L7 = "vpn"
  L8 = "disabled"
  L9 = "0"
  L4(L5, L6, L7, L8, L9)
  L4 = os
  L4 = L4.execute
  L5 = _UPVALUE1_
  L5 = L5.SET_VPN_USER_OPTION
  L6 = "1"
  L5 = L5 .. L6
  L4(L5)
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.commit
  L6 = "network"
  L4(L5, L6)
  L4 = setWanAuto
  L5 = nil
  L4(L5)
  L4 = L1.bh_ap_enable
  L4()
  L4 = L1.apcli_disable
  L5 = A0
  L4(L5)
  L4 = _UPVALUE2_
  L4 = L4.setNetMode
  L5 = nil
  L4(L5)
  L4 = L1.apcli_set_active
  L5 = nil
  L4(L5)
  L4 = L1.setWiFiMacfilterModel
  L5 = false
  L4(L5)
  L4 = actionForDisableWifiAP
  L4()
  L4 = L2
  L5 = L3
  return L4, L5
end
disableWifiAPMode = L4
function L4(A0)
  local L1, L2, L3
  if A0 then
    L1 = [[
		wifiap_mode.sh open;
        ]]
  else
    L1 = [[
            sleep 10;
			wifiap_mode.sh open;
        ]]
  end
  L2 = _UPVALUE0_
  L2 = L2.forkExec
  L3 = L1
  L2(L3)
end
actionForEnableWifiAP = L4
function L4()
  local L0, L1, L2
  L0 = [[
    sleep 3;
	wifiap_mode.sh close;
    ]]
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = L0
  L1(L2)
end
actionForDisableWifiAP = L4
function L4(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
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
end
parseCmdline = L4
function L4(A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11)
  local L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35
  L12 = require
  L13 = "xiaoqiang.util.XQWifiUtil"
  L12 = L12(L13)
  L13 = {}
  L13.ifname = ""
  L13.ssid = A0
  L13.cmdssid = A0
  L13.password = A1
  L13.cmdpassword = A1
  L13.encryption = A3
  L13.enctype = A2
  L13.band = A4
  L13.channel = A5
  L13.bw = A6
  L13.reconnect = nil
  L14 = {}
  L14.connected = false
  L14.conerrmsg = ""
  L14.scan = true
  L14.ip = ""
  L15 = nil
  L16 = _UPVALUE0_
  L16 = L16.getNetMode
  L16 = L16()
  L17 = L13.ssid
  if L17 then
    L17 = L13.ssid
    L13.cmdssid = L17
    L17 = L13.password
    L13.cmdpassword = L17
    L17 = L12.apcli_check_apcliitem
    L18 = L13
    L17 = L17(L18)
    if L17 then
      L17 = L12.apcli_get_scanlist
      L18 = L13
      L17 = L17(L18)
      L18 = nil
      for L22, L23 in L19, L20, L21 do
        if L23 then
          L24 = L23.ssid
          if L24 == A0 then
            L18 = L23
            break
          end
        end
      end
      if not L18 then
        L14.scan = false
        return L14
      end
      L13.enctype = L19
      L13.channel = L19
      L13.encryption = L19
      L13.band = L19
      L13.channel = L19
      L13.ifname = L19
    end
    L17 = _UPVALUE0_
    L17 = L17.isStrNil
    L18 = L13.ifname
    L17 = L17(L18)
    if L17 then
      L17 = L12.apcli_get_ifname_form_band
      L18 = L13.band
      L17 = L17(L18)
      L13.ifname = L17
    end
    L17 = L12.apcli_get_ifnames
    L17 = L17()
    L18 = nil
    for L22, L23 in L19, L20, L21 do
      L24 = L13.ifname
      if L23 ~= L24 then
        L24 = L12.apcli_get_wifinet
        L25 = L23
        L24 = L24(L25)
        if L24 then
          L24 = L12.apcli_set_inactive
          L25 = L23
          L24(L25)
        end
      end
    end
    if L19 then
      L19(L20)
    end
    L19(L20)
    for L23 = L20, L21, L22 do
      L24 = L12.apcli_get_connect
      L25 = L13.ifname
      L24, L25 = L24(L25)
      if L24 then
        break
      end
      L26 = os
      L26 = L26.execute
      L27 = "sleep 3"
      L26(L27)
    end
    L14.connected = L19
    L14.ifname = L20
  end
  L17 = L14.connected
  if L17 then
    L17 = require
    L18 = "xiaoqiang.util.XQLanWanUtil"
    L17 = L17(L18)
    if L16 ~= "wifiapmode" and L16 ~= "lanapmode" then
      L18 = backupConfigs
      L18()
    end
    L18 = require
    L18 = L18(L19)
    L18 = L18.cursor
    L18 = L18()
    L20(L21)
    L23 = L13.ifname
    L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35 = L21(L22)
    if L20 ~= 0 then
      L23 = "sleep 2;dhcp_apclient.sh start br-lan"
      L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35 = L22(L23)
    end
    if L20 and L20 == 0 then
      L23 = "xiaoqiang.util.XQSynchrodata"
      L23 = require
      L24 = "xiaoqiang.module.XQMessageBox"
      L23 = L23(L24)
      L24 = L23.removeMessage
      L25 = 4
      L24(L25)
      L24 = _UPVALUE0_
      L24 = L24.setNetMode
      L25 = "wifiapmode"
      L24(L25)
      L24 = L22.syncApLanIp
      L25 = L21
      L24(L25)
      L14.ip = L21
      L24 = require
      L25 = "luci.model.uci"
      L24 = L24(L25)
      L24 = L24.cursor
      L24 = L24()
      L26 = L24
      L25 = L24.delete
      L27 = "dhcp"
      L28 = "lan"
      L25(L26, L27, L28)
      L26 = L24
      L25 = L24.delete
      L27 = "dhcp"
      L28 = "wan"
      L25(L26, L27, L28)
      L26 = L24
      L25 = L24.commit
      L27 = "dhcp"
      L25(L26, L27)
      if A10 ~= nil then
        L25 = #A10
        if L25 ~= 0 then
          goto lbl_219
        end
      end
      A10 = A7
      ::lbl_219::
      L25 = L12.get_wlan_count
      L25 = L25()
      if 2 < L25 then
        if A11 ~= nil then
          L25 = #A11
          if L25 ~= 0 then
            goto lbl_229
          end
        end
        A11 = A7
      end
      ::lbl_229::
      L25 = L12.setWifiBasicInfo
      L26 = 1
      L27 = A7
      L28 = A9
      L29 = A8
      L30, L31, L32, L33, L34, L35 = nil, nil, nil, nil, nil, nil
      L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
      L25 = L12.setWifiBasicInfo
      L26 = 2
      L27 = A10
      L28 = A9
      L29 = A8
      L30, L31, L32, L33 = nil, nil, nil, nil
      L34 = "0"
      L35 = nil
      L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
      L25 = L12.get_wlan_count
      L25 = L25()
      if 2 < L25 then
        L25 = L12.setWifiBasicInfo
        L26 = 3
        L27 = A11
        L28 = A9
        L29 = A8
        L30, L31, L32, L33 = nil, nil, nil, nil
        L34 = "0"
        L35 = nil
        L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
      end
      if A7 then
        L25 = L12.mlo_hostap_disable
        L25()
      end
      L25 = L12.bh_ap_disable
      L25()
      L25 = L12.miwifi_mesh_disable
      L25()
      L25 = L12.apcli_enable
      L26 = L13
      L25(L26)
      L25 = L12.setWiFiMacfilterModel
      L26 = false
      L25(L26)
      L25 = L12.closeGuestWifi
      L26 = 1
      L25(L26)
      L25 = L12.closeGuestWifi
      L26 = 2
      L25(L26)
    else
      L23 = nil
      L22(L23)
      L22()
    end
  end
  L17 = L14.connected
  if L17 then
    L17 = L14.ip
    if L17 ~= "" then
      goto lbl_356
    end
  end
  L17 = L13.reconnect
  if L17 == nil then
    L17 = L12.apcli_get_ifnames
    L17 = L17()
    L18 = nil
    for L22, L23 in L19, L20, L21 do
      L24 = L12.apcli_set_inactive
      L25 = L23
      L24(L25)
    end
    if L16 then
      L21.ifname = L19
      L23 = L20
      L24 = "ssid"
      L21.ssid = L22
      L23 = L20
      L24 = "ssid"
      L21.cmdssid = L22
      L23 = L20
      L24 = "key"
      L21.password = L22
      L23 = L20
      L24 = "key"
      L21.cmdpassword = L22
      L23 = L20
      L24 = "encryption"
      L21.encryption = L22
      L23 = L20
      L24 = "enctype"
      L21.enctype = L22
      L23 = L21
      L22(L23)
    else
    end
  end
  L14.conerrmsg = "Connect faild!"
  goto lbl_366
  ::lbl_356::
  L17 = L13.band
  L18 = L17
  L17 = L17.match
  L17 = L17(L18, L19)
  if L17 then
    L17 = os
    L17 = L17.execute
    L18 = "radartool -i wifi1 enable"
    L17(L18)
  end
  ::lbl_366::
  return L14
end
setWifiAPMode = L4
function L4(A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10)
  local L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L11 = require
  L12 = "xiaoqiang.util.XQWifiUtil"
  L11 = L11(L12)
  L12 = {}
  L12.ifname = ""
  L12.ssid = A0
  L12.cmdssid = A0
  L12.password = A1
  L12.cmdpassword = A1
  L12.encryption = A3
  L12.enctype = A2
  L12.band = A4
  L12.channel = A5
  L12.bw = A6
  L13 = {}
  L13.connected = false
  L13.conerrmsg = ""
  L13.scan = true
  L14 = nil
  L15 = _UPVALUE0_
  L15 = L15.getNetMode
  L15 = L15()
  L15 = L15 ~= nil
  L16 = L12.ssid
  if L16 then
    L16 = L12.ssid
    L12.cmdssid = L16
    L16 = L12.password
    L12.cmdpassword = L16
    L16 = L11.apcli_check_apcliitem
    L16 = L16(L17)
    if L16 then
      L16 = logger
      L16 = L16.log
      L16(L17, L18)
      L16 = L11.apcli_get_scanlist
      L16 = L16(L17)
      for L21, L22 in L18, L19, L20 do
        if L22 then
          L23 = L22.ssid
          if L23 == A0 then
            break
          end
        end
      end
      if not L17 then
        L13.scan = false
        return L13
      end
      L12.enctype = L18
      L12.channel = L18
      L12.encryption = L18
      L12.band = L18
      L12.channel = L18
      L12.ifname = L18
    end
    L16 = _UPVALUE0_
    L16 = L16.isStrNil
    L16 = L16(L17)
    if L16 then
      L16 = L11.apcli_get_ifname_form_band
      L16 = L16(L17)
      L12.ifname = L16
    end
    L16 = L11.apcli_get_ifnames
    L16 = L16()
    for L21, L22 in L18, L19, L20 do
      L23 = L12.ifname
      if L22 ~= L23 then
        L23 = L11.apcli_set_inactive
        L24 = L22
        L23(L24)
      end
    end
    L18(L19)
    for L22 = L19, L20, L21 do
      L23 = L11.apcli_get_connect
      L24 = L12.ifname
      L23, L24 = L23(L24)
      if L23 then
        break
      end
      L25 = os
      L25 = L25.execute
      L26 = "sleep 2"
      L25(L26)
    end
    L13.connected = L18
  end
  L16 = L13.connected
  if L16 then
    L16 = require
    L16 = L16(L17)
    if not L15 then
      L17()
    end
    L13.oldlan = L18
  end
  L16 = require
  L16 = L16(L17)
  L16 = L16.cursor
  L16 = L16()
  for L20, L21 in L17, L18, L19 do
    L13[L20] = L21
  end
  return L13
end
appSetWifiAPMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.getNetMode
  L1 = L1()
  L1 = L1 ~= nil
  L2 = io
  L2 = L2.open
  L3 = "/tmp/luci_set_wifi_ap_mode_result"
  L4 = "r"
  L2 = L2(L3, L4)
  if L2 ~= nil then
    L4 = L2
    L3 = L2.read
    L5 = "*a"
    L3 = L3(L4, L5)
    L4 = require
    L5 = "json"
    L4 = L4(L5)
    L5 = L4.decode
    L6 = L3
    L5 = L5(L6)
    L7 = L2
    L6 = L2.close
    L6(L7)
    L6 = L5.code
    if L6 then
      L6 = L5.code
      if L6 == 0 then
        L6 = require
        L7 = "xiaoqiang.util.XQLanWanUtil"
        L6 = L6(L7)
        L7 = setWanAuto
        L7(L8)
        L7 = L5.ipaddr
        if L7 ~= nil then
          L11 = 4
          L10(L11)
          L11 = "wifiapmode"
          L10(L11)
          L11 = L7
          L10(L11)
          L11 = "luci.model.uci"
          L12 = L10
          L11 = L10.set
          L13 = "xiaoqiang"
          L14 = "common"
          L15 = "ap_hostname"
          L16 = L5.hostname
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "xiaoqiang"
          L14 = "common"
          L15 = "vendorinfo"
          L16 = L5.vendorinfo
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.commit
          L13 = "xiaoqiang"
          L11(L12, L13)
          L12 = L10
          L11 = L10.delete
          L13 = "network"
          L14 = "lan"
          L15 = "dns"
          L11(L12, L13, L14, L15)
          L11 = countrycode
          if L11 == "CN" then
            L12 = L10
            L11 = L10.delete
            L13 = "network"
            L14 = "vpn"
            L11(L12, L13, L14)
          end
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "proto"
          L16 = "static"
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "type"
          L16 = "bridge"
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "ipaddr"
          L16 = L7
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "netmask"
          L16 = L5.netmask
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "gateway"
          L16 = L5.gateway
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "mtu"
          L16 = L5.mtu
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.set
          L13 = "network"
          L14 = "lan"
          L15 = "dns"
          L16 = L5.dns1
          L11(L12, L13, L14, L15, L16)
          L12 = L10
          L11 = L10.commit
          L13 = "network"
          L11(L12, L13)
          L12 = L10
          L11 = L10.delete
          L13 = "dhcp"
          L14 = "lan"
          L11(L12, L13, L14)
          L12 = L10
          L11 = L10.delete
          L13 = "dhcp"
          L14 = "wan"
          L11(L12, L13, L14)
          L12 = L10
          L11 = L10.commit
          L13 = "dhcp"
          L11(L12, L13)
          L11, L12, L13, L14 = nil, nil, nil, nil
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = nssid
          L15 = L15(L16)
          if not L15 then
            L15 = nencryption
            if L15 then
              L15 = npassword
              if not L15 then
                L15 = nencryption
                if L15 ~= "none" then
                  goto lbl_168
                end
              end
              L11 = nssid
              L12 = nssid
              L13 = npassword
              L14 = nencryption
            end
          end
          ::lbl_168::
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = nssid5G
          L15 = L15(L16)
          if not L15 then
            L12 = nssid5G
          end
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L5.band
          L15 = L15(L16)
          if not L15 then
            L15 = L5.band
            L16 = L15
            L15 = L15.match
            L17 = "2g"
            L15 = L15(L16, L17)
            if L15 then
              L15 = L0.setWifiBasicInfo
              L16 = 1
              L17 = L11
              L18 = L13
              L19 = L14
              L20 = nil
              L21 = "max"
              L22, L23, L24, L25 = nil, nil, nil, nil
              L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
              L15 = L0.setWifiBasicInfo
              L16 = 2
              L17 = L12
              L18 = L13
              L19 = L14
              L20, L21, L22, L23, L24, L25 = nil, nil, nil, nil, nil, nil
              L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
            else
              L15 = L0.setWifiBasicInfo
              L16 = 1
              L17 = L11
              L18 = L13
              L19 = L14
              L20, L21, L22, L23, L24, L25 = nil, nil, nil, nil, nil, nil
              L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
              L15 = L0.setWifiBasicInfo
              L16 = 2
              L17 = L12
              L18 = L13
              L19 = L14
              L20 = nil
              L21 = "max"
              L22, L23, L24, L25 = nil, nil, nil, nil
              L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
            end
          else
            L15 = L0.setWifiBasicInfo
            L16 = 1
            L17 = L11
            L18 = L13
            L19 = L14
            L20, L21, L22, L23, L24, L25 = nil, nil, nil, nil, nil, nil
            L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
            L15 = L0.setWifiBasicInfo
            L16 = 2
            L17 = L12
            L18 = L13
            L19 = L14
            L20, L21, L22, L23, L24, L25 = nil, nil, nil, nil, nil, nil
            L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
          end
          L15 = L0.apcli_enable
          L16 = L5
          L15(L16)
          L15 = L0.setWiFiMacfilterModel
          L16 = false
          L15(L16)
          L15 = L0.closeGuestWifi
          L16 = 1
          L15(L16)
          L15 = L0.closeGuestWifi
          L16 = 2
          L15(L16)
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L11
          L15 = L15(L16)
          if L15 then
            L15 = L0.getWifiBasicInfo
            L16 = 1
            L15 = L15(L16)
            if L15 ~= nil then
              L16 = L15.ssid
              L5.ssid = L16
            end
          else
            L5.ssid = L11
          end
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L12
          L15 = L15(L16)
          if L15 then
            L15 = L0.getWifiBasicInfo
            L16 = 2
            L15 = L15(L16)
            if L15 ~= nil then
              L16 = L15.ssid
              L5.ssid5G = L16
            end
          else
            L5.ssid5G = L12
          end
        else
        end
      end
    end
    L6 = L5.code
    if L6 == 0 then
      L6 = L5.ipaddr
      if L6 ~= nil then
        goto lbl_356
      end
    end
    L6 = logger
    L6 = L6.log
    L7 = 6
    L6(L7, L8)
    L6 = L0.apcli_get_ifnames
    L6 = L6()
    L7 = nil
    for L11, L12 in L8, L9, L10 do
      L13 = L0.apcli_set_inactive
      L14 = L12
      L13(L14)
    end
    if L1 then
      L10.ifname = L8
      L12 = L9
      L11 = L9.get
      L13 = "ssid"
      L11 = L11(L12, L13)
      L10.ssid = L11
      L12 = L9
      L11 = L9.get
      L13 = "ssid"
      L11 = L11(L12, L13)
      L10.cmdssid = L11
      L12 = L9
      L11 = L9.get
      L13 = "key"
      L11 = L11(L12, L13)
      L11 = L11 or L11
      L10.password = L11
      L12 = L9
      L11 = L9.get
      L13 = "key"
      L11 = L11(L12, L13)
      L11 = L11 or L11
      L10.cmdpassword = L11
      L12 = L9
      L11 = L9.get
      L13 = "encryption"
      L11 = L11(L12, L13)
      L11 = L11 or L11
      L10.encryption = L11
      L12 = L9
      L11 = L9.get
      L13 = "enctype"
      L11 = L11(L12, L13)
      L11 = L11 or L11
      L10.enctype = L11
      L11 = logger
      L11 = L11.log
      L12 = 6
      L13 = "Connect faild Rollback to old apcliitem"
      L11(L12, L13)
      L11 = L0.apcli_set_connect
      L12 = L10
      L11(L12)
    else
    end
    L5.conerrmsg = "Connect faild!"
  end
  ::lbl_356::
end
setWifiAPModeConfig = L4
function L4(A0)
  local L1, L2, L3
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    A0 = "2g"
  end
  L2 = L1.apcli_get_ifname_form_band
  L3 = A0
  L2 = L2(L3)
  ifname = L2
  L2 = L1.apcli_set_inactive
  L3 = ifname
  L2(L3)
end
extednwifi_disconnect = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L6 = require
  L7 = "xiaoqiang.util.XQWifiUtil"
  L6 = L6(L7)
  L7 = {}
  L7.ifname = ""
  L7.ssid = A0
  L7.cmdssid = A0
  L7.password = A1
  L7.cmdpassword = A1
  L7.encryption = A3
  L7.enctype = A2
  L7.band = A4
  L7.channel = A5
  L8 = {}
  L8.connected = false
  L8.dhcpcode = -1
  L8.ip = ""
  L9 = nil
  L10 = _UPVALUE0_
  L10 = L10.getNetMode
  L10 = L10()
  L10 = L10 ~= nil
  if L11 then
    L7.ssid = L11
    L7.password = L11
    L7.cmdssid = L11
    L7.cmdpassword = L11
    if L11 then
      for L16, L17 in L13, L14, L15 do
        if L17 then
          if L18 == A0 then
            break
          end
        end
      end
      if not L12 then
        return L8
      end
      L7.enctype = L13
      L7.channel = L13
      L7.encryption = L13
      L7.band = L13
      L7.channel = L13
      L7.ifname = L13
    end
    if L11 then
      L7.ifname = L11
    end
    for L14 = L11, L12, L13 do
      L15(L16, L17)
      for L19 = L16, L17, L18 do
        L20 = L6.apcli_get_connect
        L21 = L7.ifname
        L20, L21 = L20(L21)
        if L20 then
          break
        end
        L22 = os
        L22 = L22.execute
        L23 = "sleep 2"
        L22(L23)
      end
      L8.connected = L15
      if L15 == true then
        break
      end
    end
  end
  if L11 then
    L8.dhcpcode = L14
    if L14 == 0 then
      L8.ip = L14
    end
  end
  if L11 then
    if L11 ~= "" then
      goto lbl_218
    end
  end
  L11(L12)
  if L10 then
    L13.ifname = L11
    L13.ssid = L14
    L13.cmdssid = L14
    L13.password = L14
    L13.cmdpassword = L14
    L13.encryption = L14
    L13.enctype = L14
    if L14 == "0" then
      L15(L16)
    else
    end
  end
  ::lbl_218::
  return L8
end
extendwifi_set_connect = L4
