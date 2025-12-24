local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.util.XQSynchrodata"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQConfigs"
L2 = L2(L3)
L3 = pcall
L4 = require
L5 = "messageclient"
L3, L4 = L3(L4, L5)
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
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
      L3 = os
      L3 = L3.execute
      L4 = string
      L4 = L4.format
      L5 = "matool --method setKVB64 --params \"%s\" \"%s\""
      L6 = A0
      L7 = L2.binaryBase64Enc
      L8 = A1
      L7, L8 = L7(L8)
      L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
      L3(L4, L5, L6, L7, L8)
    end
  end
end
if not L3 then
  L6 = {}
  L6.send = L5
  L4 = L6
end
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.send
    L2 = "router_name"
    L3 = A0
    L1(L2, L3)
  end
end
syncRouterName = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = tostring
  L2 = A0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE1_
    L2 = L2.send
    L3 = "router_locale"
    L4 = L1
    L2(L3, L4)
  end
end
syncRouterLocale = L6
function L6(A0, A1)
  local L2, L3, L4
  if A0 then
    L2 = _UPVALUE0_
    L2 = L2.send
    L3 = "ssid_24G"
    L4 = A0
    L2(L3, L4)
  end
  if A1 then
    L2 = _UPVALUE0_
    L2 = L2.send
    L3 = "ssid_5G"
    L4 = A1
    L2(L3, L4)
  end
end
syncWiFiSSID = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      L1 = require
      L2 = "json"
      L1 = L1(L2)
      L2 = _UPVALUE0_
      L2 = L2.forkExec
      L3 = string
      L3 = L3.format
      L4 = "matool --method api_call_post --params /device/router_conf/upload \"%s\""
      L5 = _UPVALUE0_
      L5 = L5._cmdformat
      L6 = L1.encode
      L7 = A0
      L6, L7 = L6(L7)
      L5, L6, L7 = L5(L6, L7)
      L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
      L2(L3, L4, L5, L6, L7)
    end
  end
end
uploadConf = L6
function L6(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.send
    L2 = "work_mode"
    L3 = tostring
    L4 = A0
    L3, L4 = L3(L4)
    L1(L2, L3, L4)
  end
end
syncWorkMode = L6
function L6(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.send
    L2 = "active_apcli_mode"
    L3 = tostring
    L4 = A0
    L3, L4 = L3(L4)
    L1(L2, L3, L4)
  end
end
syncActiveApcliMode = L6
function L6(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.send
    L2 = "ap_lan_ip"
    L3 = tostring
    L4 = A0
    L3, L4 = L3(L4)
    L1(L2, L3, L4)
  end
end
syncApLanIp = L6
function L6(A0, A1)
  local L2, L3, L4, L5
  if A0 then
    L2 = _UPVALUE0_
    L2 = L2.send
    L3 = "protection_enabled"
    L4 = tostring
    L5 = A0
    L4, L5 = L4(L5)
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L2 = L2.send
    L3 = "protection_mode"
    L4 = tostring
    L5 = A1
    L4, L5 = L4(L5)
    L2(L3, L4, L5)
  end
end
syncProtectionStatus = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = L0.qosHistory
  L3 = L1.getDeviceMacsFromDB
  L3, L4, L5, L6 = L3()
  L2 = L2(L3, L4, L5, L6)
  L3 = L0.guestQoSInfo
  L3 = L3()
  L2.guest = L3
  L3 = L0.xqQoSInfo
  L3 = L3()
  L2["local"] = L3
  L3 = _UPVALUE0_
  L3 = L3.send
  L4 = "qos_info"
  L5 = _UPVALUE1_
  L5 = L5.encode
  L6 = L2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
end
syncQosInfo = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = L0.predownloadInfo
  L1 = L1()
  L2 = _UPVALUE0_
  L2 = L2.send
  L3 = "auto_ota_rom"
  L4 = tostring
  L5 = L1.auto
  L4, L5 = L4(L5)
  L2(L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.send
  L3 = "auto_ota_plugin"
  L4 = tostring
  L5 = L1.plugin
  L4, L5 = L4(L5)
  L2(L3, L4, L5)
end
syncOTAInfo = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQPushUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDeviceUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQFirewall"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.module.XQParentControl"
  L5 = L5(L6)
  if A0 then
    L6 = A0.mac
    if L6 then
      L6 = L5.parentctl_rules
      L7 = {}
      L8 = A0.mac
      L7[L8] = 1
      L6 = L6(L7)
      L7 = L5.netacctl_status
      L8 = {}
      L9 = A0.mac
      L8[L9] = 1
      L7 = L7(L8)
      L8 = L5.get_urlfilter_info
      L9 = {}
      L10 = A0.mac
      L9[L10] = 1
      L8 = L8(L9)
      L9 = {}
      L10 = A0.mac
      L9.mac = L10
      L9.lan = 1
      L10 = A0.wan
      L9.wan = L10
      L9.admin = 1
      L9.limited = 0
      L9.nickname = ""
      L9.pridisk = 0
      L9.owner = ""
      L9.device = ""
      L9.push = 0
      L10 = A0.mac
      L10 = L6[L10]
      L9.pcontrol = L10
      L10 = A0.mac
      L10 = L7[L10]
      L9.netacctl = L10
      L10 = A0.mac
      L10 = L8[L10]
      L9.urlfilter = L10
      L10 = {}
      L10.api = 70
      L11 = {}
      L12 = A0.mac
      L11[1] = L12
      L10.macs = L11
      L11 = {}
      L12 = L4.getMacfilterInfoDict
      L12 = L12()
      L13 = L3.fetchDeviceInfoFromConfig
      L14 = A0.mac
      L13 = L13(L14)
      L14 = _UPVALUE0_
      L14 = L14.thrift_tunnel_to_datacenter
      L15 = _UPVALUE1_
      L15 = L15.encode
      L16 = L10
      L15, L16, L17, L21, L22, L23 = L15(L16)
      L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23)
      if L14 then
        L15 = L14.code
        if L15 == 0 then
          L11 = L14.canAccessAllDisk
        end
      end
      L15 = A0.mac
      L15 = L12[L15]
      L16 = L1.getWiFiMacfilterModel
      L16 = L16()
      if L16 == 1 then
        L17 = L1.getCurrentMacfilterList
        L17 = L17()
        if L17 then
          for L21, L22 in L18, L19, L20 do
            L23 = A0.mac
            if L22 == L23 then
              L9.limited = 1
              break
            end
          end
        end
      end
      L17 = A0.push
      if L17 then
        L17 = A0.push
        L9.push = L17
      else
        L17 = L2.specialNotify
        L17 = L17(L18)
        if L17 then
          if L18 then
            goto lbl_119
          end
        end
        ::lbl_119::
        L9.push = L18
      end
      if L15 then
        L17 = L15.wan
        if L17 then
          L17 = 1
          if L17 then
            goto lbl_129
          end
        end
        L17 = 0
        ::lbl_129::
        L9.wan = L17
        L17 = L15.lan
        if L17 then
          L17 = 1
          if L17 then
            goto lbl_137
          end
        end
        L17 = 0
        ::lbl_137::
        L9.lan = L17
        L17 = L15.admin
        if L17 then
          L17 = 1
          if L17 then
            goto lbl_145
          end
        end
        L17 = 0
        ::lbl_145::
        L9.admin = L17
        L17 = L15.pridisk
        if L17 then
          L17 = 1
          if L17 then
            goto lbl_153
          end
        end
        L17 = 0
        ::lbl_153::
        L9.pridisk = L17
      end
      L17 = A0.mac
      L17 = L11[L17]
      if L17 ~= nil then
        L17 = A0.mac
        L17 = L11[L17]
        if L17 then
          L17 = 1
          if L17 then
            goto lbl_166
          end
        end
        L17 = 0
        ::lbl_166::
        L9.lan = L17
      end
      if L13 then
        L17 = L13.owner
        L9.owner = L17
        L17 = L13.device
        L9.device = L17
      end
      L17 = A0.nickname
      if L17 then
        L17 = A0.nickname
        L9.nickname = L17
      else
        L17 = require
        L17 = L17(L18)
        if L18 then
          if not L19 then
            L9.nickname = L19
          end
        end
      end
      L17 = A0.lan
      if L17 then
        L17 = A0.lan
        L9.lan = L17
      end
      L17 = A0.wan
      if L17 then
        L17 = A0.wan
        L9.wan = L17
      end
      L17 = A0.admin
      if L17 then
        L17 = A0.admin
        L9.admin = L17
      end
      L17 = A0.pridisk
      if L17 then
        L17 = A0.pridisk
        L9.pridisk = L17
      end
      L17 = A0.owner
      if L17 then
        L17 = A0.pridisk
        L9.owner = L17
      end
      L17 = A0.device
      if L17 then
        L17 = A0.device
        L9.device = L17
      end
      L17 = A0.limited
      if L17 then
        L17 = A0.limited
        L9.limited = L17
      end
      L17 = A0.pcontrol
      if L17 then
        L17 = A0.pcontrol
        L9.pcontrol = L17
      end
      L17 = _UPVALUE2_
      L17 = L17.send
      L21, L22, L23 = L19(L20)
      L17(L18, L19, L20, L21, L22, L23)
    end
  end
end
syncDeviceInfo = L6
