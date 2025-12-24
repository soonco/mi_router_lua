local L0, L1, L2, L3, L4, L5, L6, L7
L0 = module
L1 = "xiaoqiang.module.XQWifiShare"
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
L3 = "xiaoqiang.util.XQSysUtil"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.XQLog"
L4 = L4(L5)
L5 = require
L6 = "luci.controller.api.xqsmarthome"
L5 = L5(L6)
L6 = require
L7 = "luci.http"
L6 = L6(L7)
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = {}
  L3.guest = 0
  L3.share = 0
  L3.need = 0
  L4 = {}
  L3.sns = L4
  L4 = L2.getGuestWifi
  L5 = A0
  L4 = L4(L5)
  L5 = tonumber
  L6 = L4.status
  L5 = L5(L6)
  L3.guest = L5
  L5 = {}
  L6 = _UPVALUE0_
  L6 = L6.encode4HtmlValue
  L7 = L4.ssid
  L6 = L6(L7)
  L5.ssid = L6
  L6 = L4.encryption
  L5.encryption = L6
  L6 = L4.hidden
  L5.hidden = L6
  L6 = _UPVALUE0_
  L6 = L6.encode4HtmlValue
  L7 = L4.password
  L6 = L6(L7)
  L5.password = L6
  L5.ssidHtmlEncode = 1
  L3.data = L5
  L5 = L3.guest
  if L5 == 0 then
    L3.need = 1
  end
  return L3
end
wifi_share_info = L7
function L7()
  local L0, L1
  L0 = {}
  L0.need = 1
  L1 = wifi_share_info
  L1 = L1()
  info = L1
  L1 = info
  L1 = L1.need
  L0.need = L1
  return L0
end
wifi_share_info_web = L7
function L7()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = 30020
  L3 = {}
  L3.command = "scene_delete"
  L3.id = L2
  L3.name = "\229\136\160\233\153\164\229\174\154\230\151\182\229\133\179\233\151\173\232\174\191\229\174\162\231\189\145\231\187\156\230\157\161\231\155\174"
  L4 = L0.encode
  L5 = L3
  L4 = L4(L5)
  L3 = L4
  L4 = L1.binaryBase64Enc
  L5 = L3
  L4 = L4(L5)
  L3 = L4
  L4 = _UPVALUE0_
  L4 = L4.guest_tunnelSmartControllerRequest
  L5 = L3
  L4(L5)
end
delete_share_time = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = os
  L3 = L3.time
  L3 = L3()
  L4 = L3 * 1000
  L5 = tonumber
  L6 = A0
  L5 = L5(L6)
  L5 = L5 * 60
  L5 = L5 * 60
  L5 = L5 * 1000
  L4 = L4 + L5
  L5 = tonumber
  L6 = A0
  L5 = L5(L6)
  L5 = L5 * 60
  L5 = L5 * 60
  L5 = L5 * 1000
  L6 = 30020
  L7 = L3 * 1000
  if L4 < L7 then
    L4 = L4 + 86400000
  end
  L7 = {}
  L8 = {}
  L9 = {}
  L10 = {}
  L10.duration = L5
  L10.total_length = 0
  L9.block = 1
  L9.delay = 0
  L9.extra = L10
  L9.keyName = "\229\133\179\233\151\173\232\174\191\229\174\162\231\189\145\231\187\156"
  L9.name = "\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168"
  L9.thirdParty = "xmrouter"
  L9.type = "guest_wifi_down"
  L11 = {}
  L12 = {}
  L12.enabled = true
  L12.time = "00:00:00"
  L12.utc_time = L4
  L11.timer = L12
  L13 = table
  L13 = L13.insert
  L14 = L8
  L15 = L9
  L13(L14, L15)
  L7.action_list = L8
  L7.command = "scene_setting"
  L7.id = L6
  L7.name = "\229\133\179\233\151\173\232\174\191\229\174\162\231\189\145\231\187\156"
  L7.launch = L11
  L13 = L1.encode
  L14 = L7
  L13 = L13(L14)
  L7 = L13
  L13 = L2.binaryBase64Enc
  L14 = L7
  L13 = L13(L14)
  L7 = L13
  L13 = _UPVALUE0_
  L13 = L13.guest_tunnelSmartControllerRequest
  L14 = L7
  L13(L14)
end
set_share_time = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      goto lbl_10
    end
  end
  L1 = false
  do return L1 end
  ::lbl_10::
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = nil
  L4 = A0.guest
  if L4 then
    L4 = _UPVALUE0_
    L4 = L4.log
    L5 = 6
    L6 = "info.guest "
    L7 = A0.guest
    L6 = L6 .. L7
    L4(L5, L6)
    L4 = "XIAOMI_ROUTER_GUEST"
    function L5(A0)
      local L1, L2
      if A0 then
        L1 = _UPVALUE0_
        L1 = L1.forkExec
        L2 = "/usr/sbin/guestwifi.sh open; sleep 6; lua /usr/sbin/sync_guest_bssid.lua"
        L1(L2)
      else
        L1 = _UPVALUE0_
        L1 = L1.forkExec
        L2 = "/sbin/wifi update >/dev/null 2>/dev/null; sleep 1; lua /usr/sbin/sync_guest_bssid.lua"
        L1(L2)
      end
    end
    L6, L7, L8 = nil, nil, nil
    L9 = A0.data
    if L9 then
      L9 = type
      L10 = A0.data
      L9 = L9(L10)
      if L9 == "table" then
        L9 = A0.data
        L6 = L9.ssid
        L9 = A0.data
        L7 = L9.encryption
        L9 = A0.data
        L8 = L9.password
      end
    end
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = 6
    L11 = "ssid "
    L12 = L6
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = 6
    L11 = "encryption "
    L12 = L7
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = 6
    L11 = "key "
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
    if L7 == "none" then
      L8 = "12345678"
      L9 = _UPVALUE0_
      L9 = L9.log
      L10 = 6
      L11 = "set guest not share, key = "
      L12 = L8
      L11 = L11 .. L12
      L9(L10, L11)
    end
    L9 = tonumber
    L10 = A0.guest
    L9 = L9(L10)
    if L9 == 1 then
      L9 = A0.closingTime
      L3 = L9 or L3
      if not L9 then
        L3 = "0"
      end
    else
      L3 = "0"
    end
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = 6
    L11 = "closingTime "
    L12 = L3
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = L2.setGuestWifi
    L10 = 1
    L11 = L6
    L12 = L7
    L13 = L8
    L14 = 1
    L15 = A0.guest
    L16 = L4
    L17 = L3
    L9(L10, L11, L12, L13, L14, L15, L16, L17)
    L9 = L2.setGuestWifi
    L10 = 2
    L11 = L6
    L12 = L7
    L13 = L8
    L14 = 1
    L15 = A0.guest
    L16 = L4
    L17 = L3
    L9(L10, L11, L12, L13, L14, L15, L16, L17)
    L9 = L2.enableGuestWifi
    L10 = L5
    L9(L10)
    L9 = tonumber
    L10 = A0.guest
    L9 = L9(L10)
    if L9 == 1 and L3 ~= nil then
      L9 = tonumber
      L10 = L3
      L9 = L9(L10)
      if L9 ~= 0 then
        L9 = delete_share_time
        L9()
        L9 = set_share_time
        L10 = L3
        L9(L10)
      end
    end
    L9 = tonumber
    L10 = A0.guest
    L9 = L9(L10)
    if L9 == 1 then
      L9 = _UPVALUE1_
      L9 = L9.forkExec
      L10 = "sleep 1; /usr/sbin/mipctl_public.sh add_guest_wifi_if"
      L9(L10)
    else
      L9 = _UPVALUE1_
      L9 = L9.forkExec
      L10 = "sleep 1; /usr/sbin/mipctl_public.sh del_guest_wifi_if"
      L9(L10)
    end
  end
  L4 = true
  return L4
end
set_wifi_share = L7
