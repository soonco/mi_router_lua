local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30
L0 = module
L1 = "xiaoqiang.module.XQBackup"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = "/tmp"
TMP_DIR = L0
L0 = "bkcfg_tmp"
TMP_TARGET_DIR = L0
L0 = "/tmp/syslogbackup/"
BACKUP_PATH = L0
L0 = "cfgbackup.tar.gz"
TAR_FILE_NAME = L0
L0 = "cfg_backup.des"
DES_FILE_NAME = L0
L0 = "cfg_backup.mbu"
MBU_FILE_NAME = L0
L0 = TMP_DIR
L1 = "/"
L2 = TMP_TARGET_DIR
L0 = L0 .. L1 .. L2
L1 = TMP_DIR
L2 = "/"
L3 = "cfgbackup.tar.gz"
L1 = L1 .. L2 .. L3
L2 = TMP_DIR
L3 = "/"
L4 = "cfg_backup.des"
L2 = L2 .. L3 .. L4
L3 = TMP_DIR
L4 = "/"
L5 = "cfg_backup.mbu"
L3 = L3 .. L4 .. L5
L4 = require
L5 = "xiaoqiang.XQFeatures"
L4 = L4(L5)
L4 = L4.FEATURES
L5 = "/tmp/cfg_backup.des"
L6 = "/tmp/cfg_backup.mbu"
function L7()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = "7kl4n23mnm678m890s9dfklnmdqmwenq"
  L3 = string
  L3 = L3.sub
  L4 = L0.bdataGet
  L5 = "SN"
  L6 = "0529486"
  L4 = L4(L5, L6)
  L5 = 1
  L6 = 5
  L3 = L3(L4, L5, L6)
  sn = L3
  L3 = string
  L3 = L3.sub
  L4 = L0.bdataGet
  L5 = "color"
  L6 = "1000"
  L4 = L4(L5, L6)
  L5 = 1
  L6 = 3
  L3 = L3(L4, L5, L6)
  color = L3
  L3 = L1.trim
  L4 = string
  L4 = L4.lower
  L5 = L1.exec
  L6 = "getmac|awk -F ',' '{print $1}'|sed 's/://g'"
  L5, L6 = L5(L6)
  L4, L5, L6 = L4(L5, L6)
  L3 = L3(L4, L5, L6)
  mac1 = L3
  L3 = L1.trim
  L4 = string
  L4 = L4.lower
  L5 = L1.exec
  L6 = "getmac|awk -F ',' '{print $2}'|sed 's/://g'"
  L5, L6 = L5(L6)
  L4, L5, L6 = L4(L5, L6)
  L3 = L3(L4, L5, L6)
  mac2 = L3
  L3 = sn
  if L3 ~= nil then
    L3 = color
    if L3 ~= nil then
      L3 = mac1
      if L3 ~= nil then
        L3 = mac2
        if L3 ~= nil then
          L3 = sn
          L4 = mac1
          L5 = mac2
          L6 = color
          L2 = L3 .. L4 .. L5 .. L6
        end
      end
    end
  end
  return L2
end
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.name = ""
  L1.location = ""
  L1.password = ""
  L3 = L0
  L2 = L0.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "ROUTER_NAME"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.name = L2
  L3 = L0
  L2 = L0.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "ROUTER_LOCALE"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.location = L2
  L3 = L0
  L2 = L0.get
  L4 = "account"
  L5 = "common"
  L6 = "admin"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.password = L2
  L3 = L0
  L2 = L0.get
  L4 = "account"
  L5 = "legacy"
  L6 = "admin"
  L2 = L2(L3, L4, L5, L6)
  if L2 then
    L4 = L0
    L3 = L0.get
    L5 = "account"
    L6 = "legacy"
    L7 = "admin"
    L3 = L3(L4, L5, L6, L7)
    L1.legacy_password = L3
  end
  return L1
end
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L3.getFeature
  L5 = "0"
  L6 = "wifi"
  L7 = "split5g"
  L4 = L4(L5, L6, L7)
  L4 = L4 == "1"
  L5 = L3.getFeature
  L6 = "0"
  L7 = "wifi"
  L8 = "mlo"
  L5 = L5(L6, L7, L8)
  L5 = L5 == "1"
  L6 = {}
  L7 = {}
  L6["24g"] = L7
  L7 = {}
  L6["5g"] = L7
  L7 = L1.getWifiBasicInfo
  L8 = 1
  L7 = L7(L8)
  L6["24g"] = L7
  L7 = L1.getWifiBasicInfo
  L8 = 2
  L7 = L7(L8)
  L6["5g"] = L7
  L7 = L1.get_wlan_count
  L7 = L7()
  if L7 == 3 then
    L7 = L1.getWifiBasicInfo
    L8 = 3
    L7 = L7(L8)
    L6["5gh"] = L7
  end
  if L2 then
    L7 = L2.is_supported
    L7 = L7()
    if L7 then
      L7 = L2.mesh_get_dwb_status
      L7 = L7()
      L7 = L7 or L7
      L6.dwb_status = L7
    end
  end
  if L4 then
    L7 = L1.get_wifi_split_status
    L7 = L7()
    L6.split5g = L7
  end
  if L5 then
    L8 = L0
    L7 = L0.get
    L9 = "misc"
    L10 = "mld"
    L11 = "hostap"
    L7 = L7(L8, L9, L10, L11)
    if L7 then
      L8 = tonumber
      L10 = L0
      L9 = L0.get
      L11 = "wireless"
      L12 = L7
      L13 = "mlo_enable"
      L9, L10, L11, L12, L13 = L9(L10, L11, L12, L13)
      L8 = L8(L9, L10, L11, L12, L13)
      L8 = L8 or L8
      L6.mlo = L8
    else
      L6.mlo = 0
    end
  end
  return L6
end
function L10()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = "/etc/config/vlan_service"
  L3 = L0.stat
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L4 = L1
    L3 = L1.get_all
    L5 = "vlan_service"
    L3 = L3(L4, L5)
    return L3
  end
  L3 = nil
  return L3
end
function L11()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = "/etc/config/port_service"
  L3 = L0.stat
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L4 = L1
    L3 = L1.get_all
    L5 = "port_service"
    L3 = L3(L4, L5)
    return L3
  end
  L3 = nil
  return L3
end
function L12()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2()
  L3 = _UPVALUE1_
  L3 = L3()
  L4 = {}
  L1.wan = L4
  L5 = L0
  L4 = L0.foreach
  L6 = "network"
  L7 = "interface"
  function L8(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = string
    L1 = L1.sub
    L2 = A0[".name"]
    L3 = 1
    L4 = 3
    L1 = L1(L2, L3, L4)
    if L1 == "wan" then
      L2 = {}
      L3 = A0[".name"]
      L2.wansec = L3
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.get_all
      L5 = "network"
      L6 = L2.wansec
      L3 = L3(L4, L5, L6)
      L2.waninfo = L3
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE1_
      L4 = L4.wan
      L5 = L2
      L3(L4, L5)
    end
  end
  L4(L5, L6, L7, L8)
  if L2 then
    L1.vlan_service = L2
  end
  if L3 then
    L1.port_service = L3
  end
  L4 = _UPVALUE2_
  L4 = L4.system
  L4 = L4.multiwan
  if L4 then
    L4 = _UPVALUE2_
    L4 = L4.system
    L4 = L4.multiwan
    if L4 == "1" then
      L5 = L0
      L4 = L0.get_all
      L6 = "mwan3"
      L4 = L4(L5, L6)
      L1.multiwan = L4
    end
  end
  return L1
end
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = {}
  L1.network = L2
  L2 = {}
  L1.dhcp = L2
  L3 = L0
  L2 = L0.get_all
  L4 = "network"
  L5 = "lan"
  L2 = L2(L3, L4, L5)
  L1.network = L2
  L3 = L0
  L2 = L0.get_all
  L4 = "dhcp"
  L5 = "lan"
  L2 = L2(L3, L4, L5)
  L1.dhcp = L2
  L2 = _UPVALUE0_
  L2 = L2.system
  L2 = L2.cpe
  if L2 then
    L2 = _UPVALUE0_
    L2 = L2.system
    L2 = L2.cpe
    if L2 == "1" then
      L3 = L0
      L2 = L0.get_all
      L4 = "ipv6"
      L5 = "lan6"
      L2 = L2(L3, L4, L5)
      L1.lan6 = L2
    end
  end
  return L1
end
function L14()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = L1.pushSettings
  L2 = L2()
  L3 = {}
  L4 = L2.auth
  if L4 then
    L4 = 1
    if L4 then
      goto lbl_17
    end
  end
  L4 = 0
  ::lbl_17::
  L3.enable = L4
  L3.mode = 0
  L4 = L0.getWiFiMacfilterModel
  L4 = L4()
  L3.mode = L4
  L4 = L0.getCurrentMacfilterList
  L4 = L4()
  L3.list = L4
  return L3
end
function L15()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = {}
  L3 = L0.getDeviceMacsFromDB
  L3 = L3()
  for L7, L8 in L4, L5, L6 do
    if 50 < L7 then
      break
    end
    L9 = L1.macaddr
    L10 = L8
    L9 = L9(L10)
    if L9 then
      L9 = table
      L9 = L9.insert
      L10 = L2
      L11 = L8
      L9(L10, L11)
    end
  end
  return L4(L5)
end
function L16()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.util.XQSMSUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.dbBackupSelectAllMsg
  L2 = L2()
  L1.sms = L2
  return L1
end
function L17()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = L0.stat
  L3 = "/etc/config/mobile"
  L2 = L2(L3)
  if L2 then
    L2 = {}
    L4 = L1
    L3 = L1.get_all
    L5 = "mobile"
    L3 = L3(L4, L5)
    L2.mobile = L3
    return L2
  end
  L2 = nil
  return L2
end
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L2 = A0.name
    if L2 then
      L3 = L1
      L2 = L1.set
      L4 = "xiaoqiang"
      L5 = "common"
      L6 = "ROUTER_NAME"
      L7 = A0.name
      L2(L3, L4, L5, L6, L7)
    end
    L2 = A0.location
    if L2 then
      L3 = L1
      L2 = L1.set
      L4 = "xiaoqiang"
      L5 = "common"
      L6 = "ROUTER_LOCALE"
      L7 = A0.location
      L2(L3, L4, L5, L6, L7)
    end
    L3 = L1
    L2 = L1.commit
    L4 = "xiaoqiang"
    L2(L3, L4)
    L2 = A0.password
    if L2 then
      L3 = L1
      L2 = L1.set
      L4 = "account"
      L5 = "common"
      L6 = "admin"
      L7 = A0.password
      L2(L3, L4, L5, L6, L7)
    end
    L2 = A0.legacy_password
    if L2 then
      L3 = L1
      L2 = L1.set
      L4 = "account"
      L5 = "legacy"
      L6 = "admin"
      L7 = A0.legacy_password
      L2(L3, L4, L5, L6, L7)
    end
    L3 = L1
    L2 = L1.commit
    L4 = "account"
    L2(L3, L4)
  end
end
function L19(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L3.getFeature
  L5 = "0"
  L6 = "wifi"
  L7 = "split5g"
  L4 = L4(L5, L6, L7)
  L4 = L4 == "1"
  L5 = L3.getFeature
  L6 = "0"
  L7 = "wifi"
  L8 = "mlo"
  L5 = L5(L6, L7, L8)
  L5 = L5 == "1"
  if A0 then
    if L4 then
      L6 = A0.split5g
      L6 = L6 or L6
      L7 = tonumber
      L8 = L1.get_wifi_split_status
      L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23 = L8()
      L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23)
      L8 = tonumber
      L9 = L6
      L8 = L8(L9)
      if L8 ~= L7 then
        L9 = L1.set_wifi_split_status
        L10 = L8
        L9(L10)
      end
    end
    if L5 then
      L6 = A0.mlo
      L6 = L6 or L6
      if L6 == 1 then
        L7 = L1.mlo_hostap_enable
        L7()
      else
        L7 = L1.mlo_hostap_disable
        L7()
      end
    end
    L6 = A0["24g"]
    L7 = A0["5g"]
    L8 = A0["5gh"]
    L9 = A0.dwb_status
    L9 = L9 or L9
    L10 = L1.init
    L10()
    if L6 then
      L10 = tonumber
      L11 = L6.on
      L10 = L10(L11)
      if L10 == 0 then
        L10 = 1
        if L10 then
          goto lbl_81
        end
      end
      L10 = 0
      ::lbl_81::
      L11 = tostring
      L12 = L6.hidden
      L11 = L11(L12)
      if L11 == "1" then
        L11 = "1"
        if L11 then
          goto lbl_90
        end
      end
      L11 = "0"
      ::lbl_90::
      L12 = L1.setWifiBasicInfo
      L13 = 1
      L14 = L6.ssid
      L15 = L6.password
      L16 = L6.encryption
      L17 = L6.channel
      L18 = L6.txpwr
      L19 = L11
      L20 = L10
      L21 = L6.bandwidth
      L22 = L6.bsd
      L23 = L6.txbf
      L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23)
    end
    if L7 then
      L10 = tonumber
      L11 = L7.on
      L10 = L10(L11)
      if L10 == 0 then
        L10 = 1
        if L10 then
          goto lbl_114
        end
      end
      L10 = 0
      ::lbl_114::
      L11 = tostring
      L12 = L7.hidden
      L11 = L11(L12)
      if L11 == "1" then
        L11 = "1"
        if L11 then
          goto lbl_123
        end
      end
      L11 = "0"
      ::lbl_123::
      L12 = L1.setWifiBasicInfo
      L13 = 2
      L14 = L7.ssid
      L15 = L7.password
      L16 = L7.encryption
      L17 = L7.channel
      L18 = L7.txpwr
      L19 = L11
      L20 = L10
      L21 = L7.bandwidth
      L22 = L7.bsd
      L23 = L7.txbf
      L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23)
    end
    if L2 then
      L10 = L2.is_supported
      L10 = L10()
      if L10 then
        L10 = L2.mesh_set_dwb_status
        L11 = L9
        L10(L11)
      end
    end
    L10 = L1.get_wlan_count
    L10 = L10()
    if L10 == 3 then
      if L8 and L9 == "1" then
        L10 = tonumber
        L11 = L8.on
        L10 = L10(L11)
        if L10 == 0 then
          L10 = 1
          if L10 then
            goto lbl_162
          end
        end
        L10 = 0
        ::lbl_162::
        L11 = tostring
        L12 = L8.hidden
        L11 = L11(L12)
        if L11 == "1" then
          L11 = "1"
          if L11 then
            goto lbl_171
          end
        end
        L11 = "0"
        ::lbl_171::
        L12 = L1.setWifiBasicInfo
        L13 = 3
        L14 = L8.ssid
        L15 = L8.password
        L16 = L8.encryption
        L17 = L8.channel
        L18 = L8.txpwr
        L19 = L11
        L20 = L10
        L21 = L8.bandwidth
        L22 = L8.bsd
        L23 = L8.txbf
        L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23)
      else
        L10 = L1.setWifiBasicInfo
        L11 = 3
        L12, L13, L14 = nil, nil, nil
        L15 = "0"
        L16 = "max"
        L17 = nil
        L18 = 0
        L19 = "0"
        L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
      end
    end
  end
end
function L20(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = require
  L3 = L3(L4)
  if not A0 then
    return
  end
  if L4 then
    L7 = "interface"
    function L8(A0)
      local L1, L2, L3, L4, L5
      L1 = string
      L1 = L1.sub
      L2 = A0[".name"]
      L3 = 1
      L4 = 3
      L1 = L1(L2, L3, L4)
      if L1 == "wan" then
        L2 = _UPVALUE0_
        L3 = L2
        L2 = L2.delete
        L4 = "network"
        L5 = A0[".name"]
        L2(L3, L4, L5)
      end
    end
    L4(L5, L6, L7, L8)
    for L7, L8 in L4, L5, L6 do
      L10 = L1
      L9 = L1.section
      L11 = "network"
      L12 = "interface"
      L13 = L8.wansec
      L14 = L8.waninfo
      L9(L10, L11, L12, L13, L14)
    end
    L4(L5, L6)
  end
  if L4 then
    for L7, L8 in L4, L5, L6 do
      L9 = L2.log
      L10 = 7
      L11 = L7
      L12 = L8
      L9(L10, L11, L12)
      L10 = L1
      L9 = L1.delete
      L11 = "vlan_service"
      L12 = L7
      L9(L10, L11, L12)
      L10 = L1
      L9 = L1.section
      L11 = "vlan_service"
      L12 = L8[".type"]
      L13 = L7
      L14 = L8
      L9(L10, L11, L12, L13, L14)
    end
    L4(L5, L6)
    L4(L5)
  end
  if L4 then
    for L7, L8 in L4, L5, L6 do
      L9 = L2.log
      L10 = 7
      L11 = L7
      L12 = L8
      L9(L10, L11, L12)
      L10 = L1
      L9 = L1.delete
      L11 = "port_service"
      L12 = L7
      L9(L10, L11, L12)
      L10 = L1
      L9 = L1.section
      L11 = "port_service"
      L12 = L8[".type"]
      L13 = L7
      L14 = L8
      L9(L10, L11, L12, L13, L14)
    end
    L4(L5, L6)
  end
  if L4 then
    if L4 == "1" then
      if L4 then
        L4(L5, L6)
        for L7, L8 in L4, L5, L6 do
          L9 = L2.log
          L10 = 7
          L11 = L7
          L12 = L8
          L9(L10, L11, L12)
          L10 = L1
          L9 = L1.section
          L11 = "mwan3"
          L12 = L8[".type"]
          L13 = L7
          L14 = L8
          L9(L10, L11, L12, L13, L14)
        end
        L4(L5, L6)
      end
    end
  end
end
function L21(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L2 = A0.network
    L3 = A0.dhcp
    if L2 then
      L5 = L1
      L4 = L1.delete
      L6 = "network"
      L7 = "lan"
      L4(L5, L6, L7)
      L5 = L1
      L4 = L1.section
      L6 = "network"
      L7 = "interface"
      L8 = "lan"
      L9 = L2
      L4(L5, L6, L7, L8, L9)
      L5 = L1
      L4 = L1.commit
      L6 = "network"
      L4(L5, L6)
    end
    if L3 then
      L5 = L1
      L4 = L1.delete
      L6 = "dhcp"
      L7 = "lan"
      L4(L5, L6, L7)
      L5 = L1
      L4 = L1.section
      L6 = "dhcp"
      L7 = "dhcp"
      L8 = "lan"
      L9 = L3
      L4(L5, L6, L7, L8, L9)
      L5 = L1
      L4 = L1.commit
      L6 = "dhcp"
      L4(L5, L6)
    end
    L4 = _UPVALUE0_
    L4 = L4.system
    L4 = L4.cpe
    if L4 then
      L4 = _UPVALUE0_
      L4 = L4.system
      L4 = L4.cpe
      if L4 == "1" then
        L4 = A0.lan6
        if L4 then
          L5 = L1
          L4 = L1.delete
          L6 = "ipv6"
          L7 = "lan6"
          L4(L5, L6, L7)
          L5 = L1
          L4 = L1.section
          L6 = "ipv6"
          L7 = "lan"
          L8 = "lan6"
          L9 = A0.lan6
          L4(L5, L6, L7, L8, L9)
          L5 = L1
          L4 = L1.commit
          L6 = "ipv6"
          L4(L5, L6)
        end
      end
    end
  end
end
function L22(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQPushUtil"
  L2 = L2(L3)
  if A0 then
    L3 = A0.mode
    L4 = A0.list
    L5 = A0.enable
    L6 = L1.getCurrentMacfilterList
    L6 = L6()
    L7 = L1.getWiFiMacfilterModel
    L7 = L7()
    if L6 then
      L8 = L1.editWiFiMacfilterList
      L9 = L7 - 1
      L10 = L6
      L11 = 1
      L8(L9, L10, L11)
    end
    L8 = L2.pushConfig
    L9 = "auth"
    L10 = L5
    L8(L9, L10)
    L8 = L1.setWiFiMacfilterModel
    L9 = L5
    L10 = L3 - 1
    L8(L9, L10)
    if L4 then
      L8 = L1.editWiFiMacfilterList
      L9 = L3 - 1
      L10 = L4
      L11 = 0
      L8(L9, L10, L11)
    end
  end
end
function L23(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L2 = L2(L3)
  if A0 then
    if L3 == "table" then
      for L6, L7 in L3, L4, L5 do
        L8 = L2.macaddr
        L9 = L6
        L8 = L8(L9)
        if L8 then
          L8 = L1.setMacFilter
          L9 = L6
          L10 = tostring
          L11 = L7.lan
          L10 = L10(L11)
          L11 = tostring
          L12 = L7.wan
          L11 = L11(L12)
          L12 = tostring
          L13 = L7.admin
          L12 = L12(L13)
          L13 = tostring
          L14 = L7.pridisk
          L13, L14 = L13(L14)
          L8(L9, L10, L11, L12, L13, L14)
        end
      end
    end
  end
end
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = require
  L1 = L1(L2)
  if A0 then
    if L2 then
      L2()
      for L5, L6 in L2, L3, L4 do
        L7 = L1.dbBackupInsertMsg
        L8 = L6.msg_id
        L9 = L6.state
        L10 = L6.timestamp
        L11 = L6.contact_phone
        L12 = L6.content
        L7(L8, L9, L10, L11, L12)
      end
    end
  end
end
function L25(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L2 = L2(L3)
  if A0 then
    if L3 then
      L3(L4, L5)
      for L6, L7 in L3, L4, L5 do
        L8 = L2.log
        L9 = 7
        L10 = L6
        L11 = L7
        L8(L9, L10, L11)
        L9 = L1
        L8 = L1.section
        L10 = "mobile"
        L11 = L7[".type"]
        L12 = L6
        L13 = L7
        L8(L9, L10, L11, L12, L13)
      end
      L3(L4, L5)
    end
  end
end
function L26(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = nil
  if not A0 then
    L4 = L1
    L3 = L1.get_list
    L5 = "cfgbackup"
    L6 = "backup"
    L7 = "item"
    L3 = L3(L4, L5, L6, L7)
    L2 = L3
  else
    L2 = A0
  end
  return L2
end
L27 = {}
L28 = _
L29 = "\232\183\175\231\148\177\229\153\168\229\144\141\231\167\176\229\146\140\232\183\175\231\148\177\229\153\168\231\174\161\231\144\134\229\175\134\231\160\129"
L28 = L28(L29)
L27.mi_basic_info = L28
L28 = _
L29 = "Wi-Fi\232\174\190\231\189\174(Wi-Fi\229\144\141\231\167\176\227\128\129Wi-Fi\229\175\134\231\160\129)"
L28 = L28(L29)
L27.mi_wifi_info = L28
L28 = _
L29 = "\228\184\138\231\189\145\232\174\190\231\189\174(\230\139\168\229\143\183\230\150\185\229\188\143\229\146\140\229\174\189\229\184\166\232\180\166\229\143\183\229\175\134\231\160\129)"
L28 = L28(L29)
L27.mi_network_info = L28
L28 = _
L29 = "DHCP\230\156\141\229\138\161\229\146\140\229\177\128\229\159\159\231\189\145IP\232\174\190\231\189\174"
L28 = L28(L29)
L27.mi_lan_info = L28
L28 = _
L29 = "\232\156\130\231\170\157\232\174\190\231\189\174(\231\189\145\231\187\156\232\174\190\231\189\174,PIN\231\160\129\232\174\190\231\189\174,\230\181\129\233\135\143\231\155\145\230\142\167)"
L28 = L28(L29)
L27.mi_mobile_info = L28
L28 = _
L29 = "\231\159\173\228\191\161\228\191\161\230\129\175"
L28 = L28(L29)
L27.mi_sms_info = L28
L28 = {}
L28.mi_basic_info = L8
L28.mi_wifi_info = L9
L28.mi_network_info = L12
L28.mi_lan_info = L13
L28.mi_arn_info = L14
L28.mi_access_info = L15
L28.mi_mobile_info = L17
L28.mi_sms_info = L16
L29 = {}
L29.mi_basic_info = L18
L29.mi_wifi_info = L19
L29.mi_network_info = L20
L29.mi_lan_info = L21
L29.mi_arn_info = L22
L29.mi_access_info = L23
L29.mi_mobile_info = L25
L29.mi_sms_info = L24
function L30(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.match
  L3 = "%d+%-%d+%-%d+%-+%d+:%d+:%d+.tar.gz"
  L1 = L1(L2, L3)
  if L1 then
    L2 = BACKUP_PATH
    L3 = L1
    L2 = L2 .. L3
    if L2 then
      goto lbl_12
    end
  end
  L2 = nil
  ::lbl_12::
  return L2
end
getFullPath = L30
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "json"
  L3 = L3(L4)
  L4 = require
  L5 = "aeslua"
  L4 = L4(L5)
  L5 = require
  L6 = "nixio.fs"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.sys"
  L6 = L6(L7)
  L7 = BACKUP_PATH
  L8 = _UPVALUE0_
  L8 = L8()
  L10 = L2
  L9 = L2.get
  L11 = "network"
  L12 = "lan"
  L13 = "ipaddr"
  L9 = L9(L10, L11, L12, L13)
  L9 = L9 or L9
  function L10()
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
  sane = L10
  function L10()
    local L0, L1, L2
    L0 = _UPVALUE0_
    L0 = L0.mkdir
    L1 = _UPVALUE1_
    L2 = 700
    L0(L1, L2)
  end
  prepare = L10
  L10 = sane
  L10 = L10()
  if not L10 then
    L10 = prepare
    L10()
  else
    L10 = os
    L10 = L10.execute
    L11 = "rm "
    L12 = L7
    L13 = "*.tar.gz >/dev/null 2>/dev/null"
    L11 = L11 .. L12 .. L13
    L10(L11)
  end
  L10 = L3.encode
  L11 = A1
  L10 = L10(L11)
  L11 = L3.encode
  L12 = A0
  L11 = L11(L12)
  L12 = L4.encrypt
  L13 = L8
  L14 = L10
  L12 = L12(L13, L14)
  L13 = os
  L13 = L13.date
  L14 = "%Y-%m-%d--%X"
  L15 = os
  L15 = L15.time
  L15, L16, L17, L18 = L15()
  L13 = L13(L14, L15, L16, L17, L18)
  L14 = ".tar.gz"
  L13 = L13 .. L14
  L14 = L5.writefile
  L15 = _UPVALUE1_
  L16 = L12
  L14(L15, L16)
  L14 = L5.writefile
  L15 = _UPVALUE2_
  L16 = L11
  L14(L15, L16)
  L14 = os
  L14 = L14.execute
  L15 = "cd /tmp; tar -czf "
  L16 = L7
  L17 = L13
  L18 = " cfg_backup.des cfg_backup.mbu >/dev/null 2>/dev/null"
  L15 = L15 .. L16 .. L17 .. L18
  L14(L15)
  L14 = os
  L14 = L14.execute
  L15 = "rm "
  L16 = _UPVALUE1_
  L17 = " >/dev/null 2>/dev/null"
  L15 = L15 .. L16 .. L17
  L14(L15)
  L14 = os
  L14 = L14.execute
  L15 = "rm "
  L16 = _UPVALUE2_
  L17 = " >/dev/null 2>/dev/null"
  L15 = L15 .. L16 .. L17
  L14(L15)
  return L13
end
save_info = L30
function L30()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = L0.get_list
  L6 = "item"
  L2 = L2(L3, L4, L5, L6)
  if L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE0_
      L8 = L8[L7]
      if L8 then
        L8 = _UPVALUE0_
        L8 = L8[L7]
        L1[L7] = L8
      end
    end
  end
  return L1
end
defaultKeys = L30
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  if L1 then
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE1_
      L8 = L8[L7]
      if L8 then
        L9 = L8
        L9 = L9()
        L2[L7] = L9
      end
    end
    return L3(L4, L5)
  end
  return L3
end
backup = L30
function L30(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = L1.lstat
  L3 = A0
  L2, L3, L4, L5 = L2(L3)
  if L2 then
    L6 = L2.type
    if L6 ~= "dir" then
      L6 = L2.type
      if L6 ~= "lnk" then
        goto lbl_17
      end
    end
  end
  L6 = false
  do return L6 end
  ::lbl_17::
  L6 = true
  return L6
end
check_file = L30
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = ""
  L4 = ""
  A0 = A0 or A0
  A1 = A1 or A1
  L5 = A1
  L6 = "/"
  L7 = DES_FILE_NAME
  L3 = L5 .. L6 .. L7
  L5 = A1
  L6 = "/"
  L7 = MBU_FILE_NAME
  L4 = L5 .. L6 .. L7
  L5 = L2.access
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L5 = 1
    return L5
  end
  L5 = os
  L5 = L5.execute
  L6 = "tar -tzvf "
  L7 = A0
  L8 = " | grep ^l >/dev/null 2>&1"
  L6 = L6 .. L7 .. L8
  L5 = L5(L6)
  if L5 == 0 then
    L6 = os
    L6 = L6.execute
    L7 = "rm -rf "
    L8 = A0
    L7 = L7 .. L8
    L6(L7)
    L6 = 2
    return L6
  end
  L6 = os
  L6 = L6.execute
  L7 = "tar -tzvf "
  L8 = A0
  L9 = " | grep -v '\\.des$' | grep -v '\\.mbu$' >/dev/null 2>&1"
  L7 = L7 .. L8 .. L9
  L6 = L6(L7)
  if L6 == 0 then
    L7 = os
    L7 = L7.execute
    L8 = "rm -rf "
    L9 = A0
    L8 = L8 .. L9
    L7(L8)
    L7 = 22
    return L7
  end
  L7 = io
  L7 = L7.popen
  L8 = "tar -tzvf "
  L9 = A0
  L10 = " | grep -c '\\.des$'"
  L8 = L8 .. L9 .. L10
  L7 = L7(L8)
  L9 = L7
  L8 = L7.read
  L10 = "*a"
  L8 = L8(L9, L10)
  L10 = L7
  L9 = L7.close
  L9(L10)
  L9 = tonumber
  L10 = L8
  L9 = L9(L10)
  if L9 ~= 1 then
    L9 = os
    L9 = L9.execute
    L10 = "rm -rf "
    L11 = A0
    L10 = L10 .. L11
    L9(L10)
    L9 = 2
    return L9
  end
  L9 = io
  L9 = L9.popen
  L10 = "tar -tzvf "
  L11 = A0
  L12 = " | grep -c '\\.mbu$'"
  L10 = L10 .. L11 .. L12
  L9 = L9(L10)
  L7 = L9
  L10 = L7
  L9 = L7.read
  L11 = "*a"
  L9 = L9(L10, L11)
  L8 = L9
  L10 = L7
  L9 = L7.close
  L9(L10)
  L9 = tonumber
  L10 = L8
  L9 = L9(L10)
  if L9 ~= 1 then
    L9 = os
    L9 = L9.execute
    L10 = "rm -rf "
    L11 = A0
    L10 = L10 .. L11
    L9(L10)
    L9 = 3
    return L9
  end
  if A1 then
    L9 = L2.access
    L10 = A1
    L9 = L9(L10)
    if not L9 then
      L9 = os
      L9 = L9.execute
      L10 = "mkdir -p "
      L11 = A1
      L12 = " >/dev/null 2>&1"
      L10 = L10 .. L11 .. L12
      L9(L10)
    end
  end
  L9 = os
  L9 = L9.execute
  L10 = "tar -xzf "
  L11 = A0
  L12 = " -C "
  L13 = A1
  L14 = " >/dev/null 2>&1"
  L10 = L10 .. L11 .. L12 .. L13 .. L14
  L9(L10)
  L9 = os
  L9 = L9.execute
  L10 = "rm "
  L11 = A0
  L12 = " >/dev/null 2>&1"
  L10 = L10 .. L11 .. L12
  L9(L10)
  L9 = check_file
  L10 = L3
  L9 = L9(L10)
  if not L9 then
    L9 = os
    L9 = L9.execute
    L10 = "rm -rf /tmp/"
    L11 = A1
    L10 = L10 .. L11
    L9(L10)
    L9 = 2
    return L9
  end
  L9 = check_file
  L10 = L4
  L9 = L9(L10)
  if not L9 then
    L9 = os
    L9 = L9.execute
    L10 = "rm -rf /tmp/"
    L11 = A1
    L10 = L10 .. L11
    L9(L10)
    L9 = 3
    return L9
  end
  L9 = os
  L9 = L9.execute
  L10 = "mv "
  L11 = L3
  L12 = " "
  L13 = TMP_DIR
  L10 = L10 .. L11 .. L12 .. L13
  L9(L10)
  L9 = os
  L9 = L9.execute
  L10 = "mv "
  L11 = L4
  L12 = " "
  L13 = TMP_DIR
  L10 = L10 .. L11 .. L12 .. L13
  L9(L10)
  L9 = 0
  return L9
end
extract = L30
function L30(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  A0 = A0 or A0
  L4 = L1.access
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = nil
    return L4
  end
  L4 = L1.readfile
  L5 = A0
  L4 = L4(L5)
  L5 = pcall
  L6 = L2.decode
  L7 = L4
  L5, L6 = L5(L6, L7)
  if L5 and L6 then
    L7 = {}
    L8 = {}
    L7.keys = L8
    L8 = {}
    L7.unknown = L8
    L9 = L3
    L8 = L3.get_list
    L8 = L8(L9, L10, L11, L12)
    L9 = {}
    for L13, L14 in L10, L11, L12 do
      L9[L14] = true
    end
    for L13, L14 in L10, L11, L12 do
      L15 = L9[L14]
      if L15 then
        L15 = L7.keys
        L16 = _UPVALUE1_
        L16 = L16[L14]
        L15[L14] = L16
      else
        L15 = table
        L15 = L15.insert
        L16 = L7.unknown
        L17 = L14
        L15(L16, L17)
      end
    end
    return L7
  else
    L7 = nil
    return L7
  end
end
getdes = L30
function L30(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = require
  L4 = "nixio.fs"
  L3 = L3(L4)
  L4 = require
  L5 = "aeslua"
  L4 = L4(L5)
  L5 = A0
  L5 = L5 or L5
  L6 = L3.access
  L7 = L5
  L6 = L6(L7)
  if not L6 then
    L6 = 1
    return L6
  end
  L6 = _UPVALUE1_
  L6 = L6()
  L7 = L3.readfile
  L8 = L5
  L7 = L7(L8)
  L8 = os
  L8 = L8.execute
  L9 = "rm "
  L10 = L5
  L11 = " >/dev/null 2>/dev/null"
  L9 = L9 .. L10 .. L11
  L8(L9)
  L8 = L4.decrypt
  L9 = L6
  L10 = L7
  L8 = L8(L9, L10)
  if not L8 then
    L9 = 2
    return L9
  end
  L9 = pcall
  L10 = L2.decode
  L11 = L8
  L9, L10 = L9(L10, L11)
  if not L9 then
    L11 = 2
    return L11
  end
  L11 = _UPVALUE2_
  L11 = L11(L12)
  if L11 then
    for L15, L16 in L12, L13, L14 do
      L17 = _UPVALUE3_
      L17 = L17[L16]
      L18 = L10[L16]
      if L17 and L18 then
        L19 = L17
        L20 = L18
        L19(L20)
      end
    end
  end
  return L12
end
restore = L30
