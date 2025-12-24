local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQKVStore"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQDeviceUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQLanWanUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQQoSUtil"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.module.XQVASModule"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.module.XQPredownload"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.XQFeatures"
  L9 = L9(L10)
  L9 = L9.FEATURES
  L10 = L0.getNetModeType
  L10 = L10()
  L11 = L3.apcli_get_active_type
  L11 = L11()
  L12 = L1.pushSettings
  L12 = L12()
  L13 = L4.devicesInfo
  L13 = L13()
  L14 = L3.getWifiBssid
  L14, L15, L16 = L14()
  L17 = L3.getGuestWifiBssid
  L17 = L17()
  L18 = L3.getWifissid
  L18, L19, L20 = L18()
  L21 = L3.get_wlan_count
  L21 = L21()
  L22 = L3.getWiFiMacfilterModel
  L22 = L22()
  L22 = L22 - 1
  if L22 < 0 then
    L22 = 0
  end
  L23 = L7.get_vas_kv_info
  L23 = L23()
  if L24 == "table" then
    for L27, L28 in L24, L25, L26 do
      L13[L27] = L28
    end
  end
  if L25 then
    if L25 == "1" then
      if L10 == 0 then
        L27, L28, L29 = L26()
      end
      L24.guest = L25
    end
  end
  L13.router_name = L26
  L13.plugin_id_list = L26
  L27 = L2.getRouterLocale
  L27, L28, L29 = L27()
  L13.router_locale = L26
  L27 = L10
  L13.work_mode = L26
  L27 = L11
  L13.active_apcli_mode = L26
  L13.ap_lan_ip = L26
  if not L14 then
  end
  L13.bssid_24G = L26
  if not L15 then
  end
  L13.bssid_5G = L26
  if not L17 then
  end
  L13.bssid_guest = L26
  if not L18 then
  end
  L13.ssid_24G = L26
  if not L19 then
  end
  L13.ssid_5G = L26
  if 3 <= L21 then
    if not L16 then
    end
    L13.bssid_5G2 = L26
    if not L20 then
    end
    L13.ssid_5G2 = L26
  end
  L13.bssid_lan = L26
  if L26 then
    if L26 then
      goto lbl_151
    end
  end
  ::lbl_151::
  L13.protection_enabled = L26
  L27 = L22
  L13.protection_mode = L26
  L13.qos_info = L24
  L27 = L25.auto
  L13.auto_ota_rom = L26
  L27 = L25.plugin
  L13.auto_ota_plugin = L26
  return L13
end
getRouterKV = L0
