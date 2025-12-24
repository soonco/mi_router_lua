local L0, L1, L2
L0 = module
L1 = "xiaoqiang.XQLog"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "posix"
L0 = L0(L1)
L1 = require
L2 = "luci.model.uci"
L1 = L1(L2)
function L2(A0)
  local L1, L2, L3, L4
  if not A0 or A0 == "" then
    L1 = nil
    return L1
  end
  L1 = io
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L3 = L1
  L2 = L1.read
  L4 = "*line"
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.close
  L3(L4)
  return L2
end
run_cmd = L2
function L2(...)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = arg[1]
  L2 = run_cmd
  L3 = "uci -q get luci.debuglevel"
  L2 = L2(L3)
  L2 = L2 or L2
  if L1 then
    L3 = tonumber
    L3 = L3(L4)
    if L3 then
      L3 = tonumber
      L3 = L3(L4)
      if 0 <= L3 then
        L3 = tonumber
        L3 = L3(L4)
        if L3 <= L4 then
          L3 = require
          L3 = L3(L4)
          L7 = LOG_USER
          L4(L5, L6, L7)
          for L7 = L4, L5, L6 do
            L8 = _UPVALUE0_
            L8 = L8.syslog
            L9 = L1
            L10 = L3.serialize_data
            L11 = arg[L7]
            L10, L11 = L10(L11)
            L8(L9, L10, L11)
          end
          L4()
        end
      end
    end
  end
end
log = L2
L2 = "gel_use"
KEY_GEL_USE = L2
L2 = "gel_restart_soft_count"
KEY_REBOOT = L2
L2 = "network_detect_error"
KEY_DETECT_ERROR = L2
L2 = "network_method_pppoe"
KEY_VALUE_NETWORK_PPPOE = L2
L2 = "network_method_dhcp"
KEY_VALUE_NETWORK_DHCP = L2
L2 = "network_method_static"
KEY_VALUE_NETWORK_STATIC = L2
L2 = "network_method_vpn"
KEY_VALUE_NETWORK_VPN = L2
L2 = "gel_init_android"
KEY_GEL_INIT_ANDROID = L2
L2 = "gel_init_ios"
KEY_GEL_INIT_IOS = L2
L2 = "gel_init_other"
KEY_GEL_INIT_OTHER = L2
L2 = "gel_init_app"
KEY_GEL_INIT_APP = L2
L2 = "disk_sleep_open"
KEY_DISKSLEEP_OPEN = L2
L2 = "disk_sleep_close"
KEY_DISKSLEEP_CLOSE = L2
L2 = "function_pptp_web"
KEY_FUNC_PPTP = L2
L2 = "function_l2tp_web"
KEY_FUNC_L2TP = L2
L2 = "function_appqos"
KEY_FUNC_APPQOS = L2
L2 = "function_clone"
KEY_FUNC_MACCLONE = L2
L2 = "function_qos"
KEY_FUNC_QOS = L2
L2 = "function_upnp"
KEY_FUNC_UPNP = L2
L2 = "function_dmz"
KEY_FUNC_DMZ = L2
L2 = "function_firewall"
KEY_FUNC_FIREWALL = L2
L2 = "function_plugin"
KEY_FUNC_PLUGIN = L2
L2 = "function_port_forwarding_add"
KEY_FUNC_PORTFADD = L2
L2 = "function_range_forwarding_add"
KEY_FUNC_RANGEFADD = L2
L2 = "function_port_forwarding_active"
KEY_FUNC_PORTENABLE = L2
L2 = "function_wireless_access"
KEY_FUNC_WIRELESS_ACCESS = L2
L2 = "function_wireless_access_blacklist"
KEY_FUNC_WIRELESS_BLACK = L2
L2 = "function_wireless_access_whitelist"
KEY_FUNC_WIRELESS_WHITE = L2
L2 = "function_channel_2g"
KEY_FUNC_2G_CHANNEL = L2
L2 = "function_channel_5g"
KEY_FUNC_5G_CHANNEL = L2
L2 = "function_channel_2g_signal"
KEY_FUNC_2G_SIGNAL = L2
L2 = "function_channel_5g_signal"
KEY_FUNC_5G_SIGNAL = L2
L2 = "function_hdd_hibernation"
KEY_FUNC_NOFLUSHED = L2
L2 = "function_relay"
KEY_FUNC_WIFI_RELAY = L2
L2 = "function_wifi_bsd"
KEY_FUNC_WIFI_BSD = L2
function L2(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  if A0 == 0 then
    L3 = "stat_points_none"
  else
    L3 = "stat_points_instant"
  end
  L4 = _UPVALUE0_
  L4 = L4.openlog
  L5 = "luci"
  L6 = LOG_NDELAY
  L7 = LOG_USER
  L4(L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.syslog
  L5 = 6
  L6 = L3
  L7 = " "
  L8 = A1
  L9 = "="
  L10 = tostring
  L11 = A2
  L10 = L10(L11)
  L6 = L6 .. L7 .. L8 .. L9 .. L10
  L4(L5, L6)
  L4 = _UPVALUE0_
  L4 = L4.closelog
  L4()
end
check = L2
