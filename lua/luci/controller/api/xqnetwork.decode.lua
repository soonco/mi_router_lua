local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "luci.controller.api.xqnetwork"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
logger = L0
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = node
  L1 = "api"
  L2 = "xqnetwork"
  L0 = L0(L1, L2)
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L2 = firstchild
  L2 = L2()
  L0.target = L2
  L0.title = ""
  L0.order = 200
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L3[1] = L4
  L3[2] = L5
  L4 = firstchild
  L4 = L4()
  L5 = ""
  L6 = 200
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 201
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_detail"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 202
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_detail_all"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAllWifiInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 202
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_connect_devices"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiConDev"
  L4 = L4(L5)
  L5 = ""
  L6 = 203
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_txpwr_channel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiChTx"
  L4 = L4(L5)
  L5 = ""
  L6 = 204
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_txpwr"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiTxpwr"
  L4 = L4(L5)
  L5 = ""
  L6 = 205
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_up"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "turnOnWifi"
  L4 = L4(L5)
  L5 = ""
  L6 = 206
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_down"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "shutDownWifi"
  L4 = L4(L5)
  L5 = ""
  L6 = 207
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifi"
  L4 = L4(L5)
  L5 = ""
  L6 = 208
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_without_restart"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiWithoutRestart"
  L4 = L4(L5)
  L5 = ""
  L6 = 208
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "check_wired_link"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "checkWiredLink"
  L4 = L4(L5)
  L5 = ""
  L6 = 212
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "lan_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLanInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 213
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 214
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "lan_dhcp"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLanDhcp"
  L4 = L4(L5)
  L5 = ""
  L6 = 215
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_down"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "wanDown"
  L4 = L4(L5)
  L5 = ""
  L6 = 216
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_up"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "wanUp"
  L4 = L4(L5)
  L5 = ""
  L6 = 217
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "check_wan_type"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAutoWanType"
  L4 = L4(L5)
  L5 = ""
  L6 = 218
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "check_wan_link"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAutoWanLink"
  L4 = L4(L5)
  L5 = ""
  L6 = 218
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_statistics"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanStatistics"
  L4 = L4(L5)
  L5 = ""
  L6 = 219
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "devices_statistics"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDevsStatistics"
  L4 = L4(L5)
  L5 = ""
  L6 = 220
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "device_statistics"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDevStatistics"
  L4 = L4(L5)
  L5 = ""
  L6 = 221
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_lan_ip"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLanIp"
  L4 = L4(L5)
  L5 = ""
  L6 = 222
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWan"
  L4 = L4(L5)
  L5 = ""
  L6 = 223
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan_new"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanNew"
  L4 = L4(L5)
  L5 = ""
  L6 = 223
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_lan_dhcp"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLanDhcp"
  L4 = L4(L5)
  L5 = ""
  L6 = 224
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "mac_clone"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanMac"
  L4 = L4(L5)
  L5 = ""
  L6 = 225
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_all_wifi"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setAllWifi"
  L4 = L4(L5)
  L5 = ""
  L6 = 226
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_dwb_wifi"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDWBWifi"
  L4 = L4(L5)
  L5 = ""
  L2(L3, L4, L5)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "avaliable_channels"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getChannels"
  L4 = L4(L5)
  L5 = ""
  L6 = 227
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_silence"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiSilence"
  L4 = L4(L5)
  L5 = ""
  L2(L3, L4, L5)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wifi_silence"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiSilence"
  L4 = L4(L5)
  L5 = ""
  L2(L3, L4, L5)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_macfilter_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiMacfilterInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 228
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_macfilter"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiMacfilter"
  L4 = L4(L5)
  L5 = ""
  L6 = 229
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "edit_device"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "editDevice"
  L4 = L4(L5)
  L5 = ""
  L6 = 230
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ignore_risk_device"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ignoreRiskDevice"
  L4 = L4(L5)
  L5 = ""
  L6 = 230
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "manually_add"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "manuallyAdd"
  L4 = L4(L5)
  L5 = ""
  L6 = 231
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "mac_bind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "macBind"
  L4 = L4(L5)
  L5 = ""
  L6 = 231
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "mac_unbind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "macUnbind"
  L4 = L4(L5)
  L5 = ""
  L6 = 232
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "savebind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "saveBind"
  L4 = L4(L5)
  L5 = ""
  L6 = 233
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "unbindall"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "unbindAll"
  L4 = L4(L5)
  L5 = ""
  L6 = 234
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "macbind_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMacBindInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 235
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ipmac_check_enable"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setIPMACCheckEnable"
  L4 = L4(L5)
  L5 = ""
  L6 = 235
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ipmac_check_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIPMACCheckStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 235
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "pppoe_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pppoeStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 236
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "pppoe_stop"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pppoeStop"
  L4 = L4(L5)
  L5 = ""
  L6 = 237
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "pppoe_start"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pppoeStart"
  L4 = L4(L5)
  L5 = ""
  L6 = 238
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getQosInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 239
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 240
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 241
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_limit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 242
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_limits"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosLimits"
  L4 = L4(L5)
  L5 = ""
  L6 = 242
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "qos_offlimit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosOffLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 243
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_band"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setBand"
  L4 = L4(L5)
  L5 = ""
  L6 = 244
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ddns"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ddnsStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 253
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ddns_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ddnsSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 254
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "add_server"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "addServer"
  L4 = L4(L5)
  L5 = ""
  L6 = 255
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "del_server"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "deleteServer"
  L4 = L4(L5)
  L5 = ""
  L6 = 256
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "server_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "serverSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 258
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ddns_reload"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ddnsReload"
  L4 = L4(L5)
  L5 = ""
  L6 = 259
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ddns_edit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ddnsEdit"
  L4 = L4(L5)
  L5 = ""
  L6 = 260
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_server"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getServer"
  L4 = L4(L5)
  L5 = ""
  L6 = 261
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_list"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getScanList"
  L4 = L4(L5)
  L5 = ""
  L6 = 262
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "disable_ap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "disableap"
  L4 = L4(L5)
  L5 = ""
  L6 = 263
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 264
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_link"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanLinkStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 265
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_ap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiApMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 266
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "app_set_wifi_ap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "appSetWifiApMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 286
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifiap_signal"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "apcli_get_signal"
  L4 = L4(L5)
  L5 = ""
  L6 = 267
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifiap_restart"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "serviceRestart"
  L4 = L4(L5)
  L5 = ""
  L6 = 268
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_lan_ap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLanAP"
  L4 = L4(L5)
  L5 = ""
  L6 = 272
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "disable_lan_ap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "disableLanAP"
  L4 = L4(L5)
  L5 = ""
  L6 = 273
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "app_wifiap_restart"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "wifiAPserviceRestart"
  L4 = L4(L5)
  L5 = ""
  L6 = 287
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getModeStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 288
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_active_apcli"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getActiveApcli"
  L4 = L4(L5)
  L5 = ""
  L6 = 289
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "channel_scan_start"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "channelScanStart"
  L4 = L4(L5)
  L5 = ""
  L6 = 269
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "channel_scan_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getScanResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 270
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_channel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setChannel"
  L4 = L4(L5)
  L5 = ""
  L6 = 271
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wan_speed"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanSpeed"
  L4 = L4(L5)
  L5 = ""
  L6 = 262
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan_speed"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanSpeed"
  L4 = L4(L5)
  L5 = ""
  L6 = 263
  L2(L3, L4, L5, L6)
  L2 = L1.apps
  if L2 then
    L2 = L1.apps
    L2 = L2.sfp
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_sfp"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "GetSFPSpeed"
      L4 = L4(L5)
      L5 = ""
      L6 = 374
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_sfp"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "SetSFPSpeed"
      L4 = L4(L5)
      L5 = ""
      L6 = 375
      L2(L3, L4, L5, L6)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "pppoe_catch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pppoeCatch"
  L4 = L4(L5)
  L5 = ""
  L6 = 264
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "wifi_diag_detail_all"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagAllWifiInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 275
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diagdevicelist"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagDeviceList"
  L4 = L4(L5)
  L5 = ""
  L6 = 276
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diagudiskstatus"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagUdiskStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 277
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diagdiskstatus"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagDiskStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 278
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_wifi_test"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diagWifiTest"
  L4 = L4(L5)
  L5 = ""
  L6 = 279
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_usb_test"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diagUsbTest"
  L4 = L4(L5)
  L5 = ""
  L6 = 280
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_hdd_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diagHddStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 281
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_disk_test"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diagDiskTest"
  L4 = L4(L5)
  L5 = ""
  L6 = 282
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_get_paras"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagParas"
  L4 = L4(L5)
  L5 = ""
  L6 = 283
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_set_paras"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDiagParas"
  L4 = L4(L5)
  L5 = ""
  L6 = 284
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "diag_get_log"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiagLog"
  L4 = L4(L5)
  L5 = ""
  L6 = 285
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_weak"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiWeakInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 286
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wifi_weak"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiWeakInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 287
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan6"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWan6"
  L4 = L4(L5)
  L5 = ""
  L6 = 223
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "ipv6_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ipv6Status"
  L4 = L4(L5)
  L5 = ""
  L6 = 223
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = "system"
  L2 = L1[L2]
  L3 = "ipv6_wired_v2"
  L2 = L2[L3]
  if L2 then
    L2 = "system"
    L2 = L1[L2]
    L3 = "ipv6_wired_v2"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_wan6_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setWan6V2"
      L4 = L4(L5)
      L5 = ""
      L6 = 360
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_wan6_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getWan6V2"
      L4 = L4(L5)
      L5 = ""
      L6 = 361
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_lan6_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setLan6V2"
      L4 = L4(L5)
      L5 = ""
      L6 = 362
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_lan6_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getLan6V2"
      L4 = L4(L5)
      L5 = ""
      L6 = 363
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_wan6_info_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getWan6InfoV2"
      L4 = L4(L5)
      L5 = ""
      L6 = 364
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_wan6_switch_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setWan6SwitchV2"
      L4 = L4(L5)
      L5 = ""
      L6 = 365
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_wan6_switch_v2"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getWan6SwitchV2"
      L4 = L4(L5)
      L5 = ""
      L6 = 366
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_wan_status"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getWanStatus"
      L4 = L4(L5)
      L5 = ""
      L6 = 367
      L7 = 8
      L2(L3, L4, L5, L6, L7)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_son_backhaul_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setSonBackhaulMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 209
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_son_backhaul_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getSonBackhaulMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 209
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "miscan_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "miscanSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 290
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_miscan_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMiscanSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 291
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_txbf"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiTxbf"
  L4 = L4(L5)
  L5 = ""
  L6 = 295
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wifi_ax"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiAx"
  L4 = L4(L5)
  L5 = ""
  L6 = 296
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "scan_mesh_node"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "scanMeshNode"
  L4 = L4(L5)
  L5 = ""
  L6 = 297
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "add_mesh_node"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "addMeshNode"
  L4 = L4(L5)
  L5 = ""
  L6 = 298
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_addnode_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMeshNodeStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 299
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_netmode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getNetMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 300
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan_lan_swap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanLanSwap"
  L4 = L4(L5)
  L5 = ""
  L6 = 301
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wan_port_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanPortStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 302
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wan_lan_port"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanLanPort"
  L4 = L4(L5)
  L5 = ""
  L6 = 303
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_wan_lan_port"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanLanPort"
  L4 = L4(L5)
  L5 = ""
  L6 = 304
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wan_lan_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanLanMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 305
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "miotrelay_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "miotrelaySwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 306
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_miotrelay_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMiotrelaySwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 307
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_ipv6_firewall"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setIpv6Firewall"
  L4 = L4(L5)
  L5 = ""
  L6 = 308
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_ipv6_firewall"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIpv6Firewall"
  L4 = L4(L5)
  L5 = ""
  L6 = 309
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_nfc_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setNfcStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 320
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_nfc_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getNfcInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 321
  L2(L3, L4, L5, L6)
  L2 = "system"
  L2 = L1[L2]
  L3 = "multiwan"
  L2 = L2[L3]
  if L2 then
    L2 = "system"
    L2 = L1[L2]
    L3 = "multiwan"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_multiwan_basic_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getMultiwanBasicInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 322
      L7 = 9
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_multiwan_dev_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getMultiwanDevList"
      L4 = L4(L5)
      L5 = ""
      L6 = 323
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_multiwan_dev_policies"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getMultiwanDevPolicies"
      L4 = L4(L5)
      L5 = ""
      L6 = 324
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_multiwan_dev_policy"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMultiwanDevPolicy"
      L4 = L4(L5)
      L5 = ""
      L6 = 325
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_multiwan_weight"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMultiwanWeight"
      L4 = L4(L5)
      L5 = ""
      L6 = 326
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_multiwan_enable"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMultiwanEnable"
      L4 = L4(L5)
      L5 = ""
      L6 = 327
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_multiwan_policy"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMultiwanPolicy"
      L4 = L4(L5)
      L5 = ""
      L6 = 328
      L7 = 8
      L2(L3, L4, L5, L6, L7)
    end
  end
  L2 = "system"
  L2 = L1[L2]
  L3 = "tr069"
  L2 = L2[L3]
  if L2 then
    L2 = "system"
    L2 = L1[L2]
    L3 = "tr069"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_cwmp"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setCwmp"
      L4 = L4(L5)
      L5 = ""
      L6 = 330
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_cwmp_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getCwmpInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 331
      L2(L3, L4, L5, L6)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_wps_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWpsInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 332
  L2(L3, L4, L5, L6)
  L2 = L1.apps
  L3 = "baidupan"
  L2 = L2[L3]
  if L2 then
    L2 = L1.apps
    L3 = "baidupan"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_router_to_baidu"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setRouterToBaidu"
      L4 = L4(L5)
      L5 = ""
      L6 = 333
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_baidu_to_router"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setBaiduToRouter"
      L4 = L4(L5)
      L5 = ""
      L6 = 334
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "delete_transport_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "deleteTransportList"
      L4 = L4(L5)
      L5 = ""
      L6 = 335
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_transport_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getTransportList"
      L4 = L4(L5)
      L5 = ""
      L6 = 336
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_translist_action"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setTransListAction"
      L4 = L4(L5)
      L5 = ""
      L6 = 337
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_translist_file_stat"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getTransListFileStat"
      L4 = L4(L5)
      L5 = ""
      L6 = 338
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_translist_count"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getTransListCount"
      L4 = L4(L5)
      L5 = ""
      L6 = 339
      L7 = 8
      L2(L3, L4, L5, L6, L7)
    end
  end
  L2 = L1.apps
  L3 = "docker"
  L2 = L2[L3]
  if L2 then
    L2 = L1.apps
    L3 = "docker"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_mi_docker"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMiDocker"
      L4 = L4(L5)
      L5 = ""
      L6 = 340
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_mi_docker_environment"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMiDockerEnv"
      L4 = L4(L5)
      L5 = ""
      L6 = 341
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_portainer_environment"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setPortainerEnv"
      L4 = L4(L5)
      L5 = ""
      L6 = 342
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_portainer_manage"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setPortainerManage"
      L4 = L4(L5)
      L5 = ""
      L6 = 343
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_docker_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getDockerInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 344
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_mi_docker_cancel"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMiDockerCancel"
      L4 = L4(L5)
      L5 = ""
      L6 = 345
      L7 = 8
      L2(L3, L4, L5, L6, L7)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_portainer_cancel"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setPortainerCancel"
      L4 = L4(L5)
      L5 = ""
      L6 = 346
      L7 = 8
      L2(L3, L4, L5, L6, L7)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "set_hostap_mlo"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setHostapMLO"
  L4 = L4(L5)
  L5 = ""
  L6 = 372
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "get_hostap_mlo"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getHostapMLO"
  L4 = L4(L5)
  L5 = ""
  L6 = 373
  L2(L3, L4, L5, L6)
  L2 = "wifi"
  L2 = L1[L2]
  L3 = "twt"
  L2 = L2[L3]
  if L2 then
    L2 = "wifi"
    L2 = L1[L2]
    L3 = "twt"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_twt"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getTwt"
      L4 = L4(L5)
      L5 = ""
      L2(L3, L4, L5)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_twt"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setTwt"
      L4 = L4(L5)
      L5 = ""
      L2(L3, L4, L5)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqnetwork"
  L6 = "bridge_lan_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getBridgeLanStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 382
  L2(L3, L4, L5, L6)
  L2 = L1.apps
  if L2 then
    L2 = L1.apps
    L3 = "local_gw_security"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_gw_security"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setGwSecurity"
      L4 = L4(L5)
      L5 = ""
      L6 = 383
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_gw_security"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getGwSecurity"
      L4 = L4(L5)
      L5 = ""
      L6 = 384
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "wifi"
  L2 = L1[L2]
  L3 = "iot_dev"
  L2 = L2[L3]
  if L2 then
    L2 = "wifi"
    L2 = L1[L2]
    L3 = "iot_dev"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_iotwifi_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getIotWifiInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 385
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_iotwifi_highprio"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setIotWifiHighPrio"
      L4 = L4(L5)
      L5 = ""
      L6 = 386
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_iotwifi_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setIotWifiInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 387
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "wifi"
  L2 = L1[L2]
  L3 = "wifi_access_ctl"
  L2 = L2[L3]
  if L2 then
    L2 = "wifi"
    L2 = L1[L2]
    L3 = "wifi_access_ctl"
    L2 = L2[L3]
    if L2 == "1" then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "get_sta_bindinfo"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getStaBindInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 388
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqnetwork"
      L6 = "set_sta_bindinfo"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setStaBindInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 389
      L2(L3, L4, L5, L6)
    end
  end
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.util.XQErrorUtil"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L2 = L2.cursor
L2 = L2()
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L3 = table
  L3 = L3.insert
  L4 = L2
  L5 = L0.getWifiStatus
  L6 = 1
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L3 = table
  L3 = L3.insert
  L4 = L2
  L5 = L0.getWifiStatus
  L6 = 2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L1.code = 0
  L1.status = L2
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getWifiStatus = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wifiIndex"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  if L3 and L3 < 3 then
    L4 = L0.getAllWifiInfo
    L4 = L4()
    L4 = L4[L3]
    L1.info = L4
  else
    L2 = 1523
  end
  if L2 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2
    L4 = L4(L5)
    L1.msg = L4
  end
  L1.code = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
getWifiInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = L0.getAllWifiInfo
  L4 = L4()
  L2.info = L4
  L2.code = L3
  L4 = L2.info
  L4 = #L4
  if 0 < L4 then
    L4 = tonumber
    L5 = L2.info
    L5 = L5[1]
    L5 = L5.bsd
    L4 = L4(L5)
    L2.bsd = L4
    L4 = L2.bsd
    if not L4 then
      L2.bsd = 0
    end
  end
  if L1 then
    L4 = L1.is_supported
    L4 = L4()
    if L4 then
      L4 = L1.mesh_get_dwb_type
      L4 = L4()
      L2.dwb_type = L4
      L4 = L1.mesh_get_dwb_band
      L4 = L4()
      L2.dwb_band = L4
      L4 = L1.mesh_get_dwb_status
      L4 = L4()
      L4 = L4 or L4
      L5 = tonumber
      L6 = L4
      L5 = L5(L6)
      L2.dwb_status = L5
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getAllWifiInfo = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "misc"
  L5 = "wireless"
  L6 = "wl_if_count"
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.get
  L5 = "misc"
  L6 = "wireless"
  L7 = "ifname_2G"
  L3 = L3(L4, L5, L6, L7)
  L5 = L1
  L4 = L1.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "ifname_5G"
  L4 = L4(L5, L6, L7, L8)
  L5 = nil
  L7 = L1
  L6 = L1.get
  L8 = "misc"
  L9 = "wireless"
  L10 = "ifname_guest_2G"
  L6 = L6(L7, L8, L9, L10)
  L8 = L1
  L7 = L1.get
  L9 = "misc"
  L10 = "wireless"
  L11 = "ifname_guest_5G"
  L7 = L7(L8, L9, L10, L11)
  L9 = L1
  L8 = L1.get
  L10 = "misc"
  L11 = "wireless"
  L12 = "wifi5_bk_2G"
  L8 = L8(L9, L10, L11, L12)
  L10 = L1
  L9 = L1.get
  L11 = "misc"
  L12 = "wireless"
  L13 = "wifi5_bk_5G"
  L9 = L9(L10, L11, L12, L13)
  if A0 == L3 or A0 == L6 or A0 == L8 then
    L10 = "2G"
    return L10
  elseif A0 == L4 or A0 == L7 or A0 == L9 then
    L10 = "5G"
    return L10
  end
  L10 = tonumber
  L11 = L2
  L10 = L10(L11)
  if L10 == 3 then
    L11 = L1
    L10 = L1.get
    L12 = "misc"
    L13 = "wireless"
    L14 = "ifname_5GH"
    L10 = L10(L11, L12, L13, L14)
    L5 = L10
    if L5 == A0 then
      L10 = "5G"
      return L10
    end
  end
end
getBandByIfname = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "misc"
  L5 = "wireless"
  L6 = "wl_if_count"
  L2 = L2(L3, L4, L5, L6)
  L4 = L1
  L3 = L1.get
  L5 = "misc"
  L6 = "wireless"
  L7 = "ifname_2G"
  L3 = L3(L4, L5, L6, L7)
  L5 = L1
  L4 = L1.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "ifname_5G"
  L4 = L4(L5, L6, L7, L8)
  L5 = nil
  L7 = L1
  L6 = L1.get
  L8 = "misc"
  L9 = "wireless"
  L10 = "ifname_guest_2G"
  L6 = L6(L7, L8, L9, L10)
  L8 = L1
  L7 = L1.get
  L9 = "misc"
  L10 = "wireless"
  L11 = "ifname_guest_5G"
  L7 = L7(L8, L9, L10, L11)
  L9 = L1
  L8 = L1.get
  L10 = "misc"
  L11 = "wireless"
  L12 = "wifi5_bk_2G"
  L8 = L8(L9, L10, L11, L12)
  L10 = L1
  L9 = L1.get
  L11 = "misc"
  L12 = "wireless"
  L13 = "wifi5_bk_5G"
  L9 = L9(L10, L11, L12, L13)
  if A0 == L3 or A0 == L4 then
    L10 = "master"
    return L10
  elseif A0 == L6 or A0 == L7 then
    L10 = "guest"
    return L10
  elseif A0 == L8 or A0 == L9 then
    L10 = "iot"
    return L10
  end
  L10 = tonumber
  L11 = L2
  L10 = L10(L11)
  if L10 == 3 then
    L11 = L1
    L10 = L1.get
    L12 = "misc"
    L13 = "wireless"
    L14 = "ifname_5GH"
    L10 = L10(L11, L12, L13, L14)
    L5 = L10
    if L5 == A0 then
      L10 = "master"
      return L10
    end
  end
end
getAssocNetByIfname = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  for L6, L7 in L3, L4, L5 do
    L8 = false
    for L12, L13 in L9, L10, L11 do
      if L12 == "mac" and L13 == A1 then
        L8 = true
      end
    end
    if true == L8 then
      for L12, L13 in L9, L10, L11 do
        if L12 == "router_name" then
          L2 = L13
        end
      end
    end
  end
  return L2
end
getAssocMeshNodeName = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  for L6, L7 in L3, L4, L5 do
    L8 = false
    for L12, L13 in L9, L10, L11 do
      if L12 == "mac" and L13 == A1 then
        L8 = true
      end
    end
    if true == L8 then
      for L12, L13 in L9, L10, L11 do
        if L12 == "location" then
          L2 = L13
        end
      end
    end
  end
  return L2
end
getAssocMeshNodeLocation = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "cjson"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = L4.exec
  L6 = "ubus call trafficd hw '{\"mlo\":true}'"
  L5 = L5(L6)
  L6 = string
  L6 = L6.upper
  L7 = L4.exec
  L8 = "getmac lan"
  L7, L8, L9, L13, L14, L18, L19, L20, L21, L22, L23 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23)
  L7 = L3.decode
  L8 = L5
  L7 = L7(L8)
  L8 = false
  L9 = {}
  if A0 ~= nil and A0 ~= "" then
    L9.assoc_band = ""
    for L13, L14 in L10, L11, L12 do
      if L15 == L13 then
        L8 = true
        for L18, L19 in L15, L16, L17 do
          if L18 == "ifname" then
            if L19 ~= "" then
              L20 = getBandByIfname
              L21 = L19
              L20 = L20(L21)
              L9.assoc_band = L20
              L20 = getAssocNetByIfname
              L21 = L19
              L20 = L20(L21)
              L9.assoc_netType = L20
            else
              L9.assoc_band = ""
              L9.assoc_netType = "lan"
            end
          elseif L18 == "parent" then
            if L19 ~= "" then
              L9.apmac = L19
            else
              L20 = L4.trim
              L21 = L6
              L20 = L20(L21)
              L9.apmac = L20
            end
            L20 = getAssocMeshNodeName
            L21 = A1
            L22 = L9.apmac
            L20 = L20(L21, L22)
            L9.assoc_node = L20
            L20 = getAssocMeshNodeLocation
            L21 = A1
            L22 = L9.apmac
            L20 = L20(L21, L22)
            L9.assoc_location = L20
          elseif L18 == "assoc" then
            L20 = tonumber
            L21 = L19
            L20 = L20(L21)
            L9.online = L20
          end
        end
      else
        L18 = A0
        L18, L19, L20, L21, L22, L23 = L17(L18)
        if L15 then
          for L18, L19 in L15, L16, L17 do
            if L18 == "hw" then
              L20 = string
              L20 = L20.upper
              L21 = A0
              L20 = L20(L21)
              if L19 == L20 then
                L8 = true
              end
            elseif L18 == "ifname" then
              if L19 ~= "" then
                L20 = L9.assoc_band
                if L20 == "" then
                  L20 = getBandByIfname
                  L21 = L19
                  L20 = L20(L21)
                  L9.assoc_band = L20
                else
                  L20 = L9.assoc_band
                  L21 = "+"
                  L22 = getBandByIfname
                  L23 = L19
                  L22 = L22(L23)
                  L20 = L20 .. L21 .. L22
                  L9.assoc_band = L20
                end
                L20 = getAssocNetByIfname
                L21 = L19
                L20 = L20(L21)
                L9.assoc_netType = L20
              else
                L9.assoc_band = ""
                L9.assoc_netType = "lan"
              end
            elseif L18 == "parent" then
              if L19 ~= "" then
                L9.apmac = L19
              else
                L20 = L4.trim
                L21 = L6
                L20 = L20(L21)
                L9.apmac = L20
              end
              L20 = getAssocMeshNodeName
              L21 = A1
              L22 = L9.apmac
              L20 = L20(L21, L22)
              L9.assoc_node = L20
              L20 = getAssocMeshNodeLocation
              L21 = A1
              L22 = L9.apmac
              L20 = L20(L21, L22)
              L9.assoc_location = L20
            elseif L18 == "assoc" then
              L20 = tonumber
              L21 = L19
              L20 = L20(L21)
              L9.online = L20
            end
          end
        end
      end
    end
  end
  if L8 == false then
    return L10
  else
    if L10 == "iot" then
      L13 = "iot_2g"
      L14 = "ssid"
      L9.ssid_2g = L10
      L13 = "iot_5g"
      L14 = "ssid"
      L9.ssid_5g = L10
      L9.ssidHtmlEncode = 1
    elseif L10 == "master" then
      L13 = "wireless"
      L14 = "ifname_2G"
      L13 = "misc"
      L14 = "wireless"
      L13 = L2
      L14 = "wireless"
      L12(L13, L14, L15, L16)
    elseif L10 == "guest" then
      L13 = "guest_2G"
      L14 = "ssid"
      L9.ssid_2g = L10
      L13 = "guest_5G"
      L14 = "ssid"
      L9.ssid_5g = L10
      L9.ssidHtmlEncode = 1
    end
    return L9
  end
end
getStationInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = {}
  L5 = {}
  L6 = L3.exec
  L7 = "bdata get wl0_ssid"
  L6 = L6(L7)
  L7 = L3.exec
  L8 = "bdata get model"
  L7 = L7(L8)
  L8 = L3.exec
  L9 = "getmac lan"
  L8 = L8(L9)
  L10 = L0
  L9 = L0.get
  L9 = L9(L10, L11, L12, L13)
  L5.location = L9
  L9 = L3.trim
  L10 = L6
  L9 = L9(L10)
  L5.router_name = L9
  L9 = L3.trim
  L10 = L7
  L9 = L9(L10)
  L5.model = L9
  L9 = string
  L9 = L9.upper
  L10 = L3.trim
  L10, L14, L15, L16, L17, L18, L22, L23, L24, L28, L29, L30 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L5.mac = L9
  L9 = tonumber
  L10 = L0.get
  L14 = "supportWifiAccessCtl"
  L10, L14, L15, L16, L17, L18, L22, L23, L24, L28, L29, L30 = L10(L11, L12, L13, L14)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
  L9 = L9 or L9
  L5.support_accessCtl = L9
  L5.cap = 1
  L9 = table
  L9 = L9.insert
  L10 = L4
  L9(L10, L11)
  L9 = L3.exec
  L10 = "ubus -t5 call xq_info_sync_mqtt topo_dump"
  L9 = L9(L10)
  if L9 ~= nil and L9 ~= "" then
    L10 = L1.decode
    L10 = L10(L11)
    for L14, L15 in L11, L12, L13 do
      L16 = {}
      L17 = true
      L18 = false
      L16.mac = L14
      for L22, L23 in L19, L20, L21 do
        if L22 == "router_name" then
          L24 = L2.binaryBase64Dec
          L24 = L24(L25)
          L16.router_name = L24
        elseif L22 == "wifiaccess" then
          L24 = tonumber
          L24 = L24(L25)
          L16.support_accessCtl = L24
          L18 = true
        elseif L22 == "description" then
          L24 = L1.decode
          L24 = L24(L25)
          for L28, L29 in L25, L26, L27 do
            if L28 == "hardware" then
              L16.model = L29
            elseif L28 == "locale" then
              L16.location = L29
            end
          end
        elseif L22 == "supportWifi" then
          L24 = tonumber
          L24 = L24(L25)
          if L24 == 0 then
            L17 = false
          end
        end
      end
      L16.cap = 0
      if L18 == false then
        L16.support_accessCtl = 0
      end
      if L17 == true then
        L19(L20, L21)
      end
    end
  end
  return L4
end
getMeshNodes = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = false
  L3 = {}
  L5 = L1
  L4 = L1.foreach
  L6 = "wifiaccess"
  L7 = "wifi-sta"
  function L8(A0)
    local L1, L2
    L1 = A0.stamac
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = true
      _UPVALUE1_ = L1
      L1 = _UPVALUE2_
      L2 = A0.bindNode
      L1.bind_node = L2
      L1 = _UPVALUE2_
      L2 = A0.bindBand
      L1.bind_band = L2
      L1 = _UPVALUE2_
      L2 = A0.bindMac
      L1.bind_mac = L2
    end
  end
  L4(L5, L6, L7, L8)
  if false == L2 then
    L3.bind_node = "none"
    L3.bind_band = "none"
    L3.bind_mac = "none"
  end
  return L3
end
getWifiAccessBindInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = getMeshNodes
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = {}
  L5 = 0
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "sta_mac"
  L6 = L6(L7)
  L7 = getStationInfo
  L8 = L6
  L9 = L2
  L7 = L7(L8, L9)
  if L7 ~= nil then
    L4.associnfo = L7
    L4.meshnode = L2
    L8 = getWifiAccessBindInfo
    L9 = L6
    L8 = L8(L9)
    L4.bindinfo = L8
  else
    L5 = -1
  end
  L4.code = L5
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L4
  L8(L9)
end
getStaBindInfo = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  if A0 == nil or A1 == nil or A2 == nil or A3 == nil then
    L6 = -1
    return L6
  end
  L6 = false
  L7 = nil
  L8 = 0
  L10 = L4
  L9 = L4.foreach
  L11 = "wifiaccess"
  L12 = "wifi-sta"
  function L13(A0)
    local L1, L2, L3
    L1 = string
    L1 = L1.upper
    L2 = A0.stamac
    L1 = L1(L2)
    L2 = string
    L2 = L2.upper
    L3 = _UPVALUE0_
    L2 = L2(L3)
    if L1 == L2 then
      L1 = A0[".name"]
      _UPVALUE1_ = L1
      L1 = true
      _UPVALUE2_ = L1
    end
    L1 = _UPVALUE3_
    L1 = L1 + 1
    _UPVALUE3_ = L1
  end
  L9(L10, L11, L12, L13)
  if L7 == nil and A1 == "none" and A2 == "none" and A3 == "none" then
    L9 = 0
    return L9
  end
  if L6 == true and L7 ~= nil then
    if A1 == "none" and A2 == "none" and A3 == "none" then
      L10 = L4
      L9 = L4.delete
      L11 = "wifiaccess"
      L12 = L7
      L9(L10, L11, L12)
    else
      L10 = L4
      L9 = L4.set
      L11 = "wifiaccess"
      L12 = L7
      L13 = "bindNode"
      L14 = A1
      L9(L10, L11, L12, L13, L14)
      L10 = L4
      L9 = L4.set
      L11 = "wifiaccess"
      L12 = L7
      L13 = "bindMac"
      L14 = A2
      L9(L10, L11, L12, L13, L14)
      L10 = L4
      L9 = L4.set
      L11 = "wifiaccess"
      L12 = L7
      L13 = "bindBand"
      L14 = A3
      L9(L10, L11, L12, L13, L14)
    end
  else
    L9 = tonumber
    L10 = L8
    L9 = L9(L10)
    if L9 == 128 then
      L9 = -2
      return L9
    else
      L10 = L4
      L9 = L4.add
      L11 = "wifiaccess"
      L12 = "wifi-sta"
      L9 = L9(L10, L11, L12)
      L11 = L4
      L10 = L4.set
      L12 = "wifiaccess"
      L13 = L9
      L14 = "stamac"
      L15 = A0
      L10(L11, L12, L13, L14, L15)
      L11 = L4
      L10 = L4.set
      L12 = "wifiaccess"
      L13 = L9
      L14 = "bindNode"
      L15 = A1
      L10(L11, L12, L13, L14, L15)
      L11 = L4
      L10 = L4.set
      L12 = "wifiaccess"
      L13 = L9
      L14 = "bindMac"
      L15 = A2
      L10(L11, L12, L13, L14, L15)
      L11 = L4
      L10 = L4.set
      L12 = "wifiaccess"
      L13 = L9
      L14 = "bindBand"
      L15 = A3
      L10(L11, L12, L13, L14, L15)
    end
  end
  L10 = L4
  L9 = L4.commit
  L11 = "wifiaccess"
  L9(L10, L11)
  L9 = L5.exec
  L10 = string
  L10 = L10.format
  L11 = "ubus call xq_info_sync_mqtt sync_wifictl_config;/sbin/applyWifiAccessPolicy.sh applyItem %s %s %s"
  L12 = A0
  L13 = A2
  L14 = A3
  L10, L11, L12, L13, L14, L15 = L10(L11, L12, L13, L14)
  L9(L10, L11, L12, L13, L14, L15)
  L9 = 0
  return L9
end
applyCAPCtlEntry = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "stamac"
  L1 = L1(L2)
  L1 = L1 or L1
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bindNode"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "bindMac"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "bindBand"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = {}
  L6 = 0
  L7 = applyCAPCtlEntry
  L8 = L1
  L9 = L2
  L10 = L3
  L11 = L4
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  L5.code = L6
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
setStaBindInfo = L3
function L3()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = L0.getDiagAllWifiInfo
  L3 = L3()
  L1.info = L3
  L1.code = L2
  L3 = L1.info
  L3 = #L3
  if 0 < L3 then
    L3 = tonumber
    L4 = L1.info
    L4 = L4[1]
    L4 = L4.bsd
    L3 = L3(L4)
    L1.bsd = L3
    L3 = L1.bsd
    if not L3 then
      L1.bsd = 0
    end
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getDiagAllWifiInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = L0.getIotWifiDeviceInfo
  L3 = L3()
  if L3 ~= nil then
    L4 = L3.basicInfo
    L1.basicInfo = L4
    L4 = L3.advanceInfo
    L1.advanceInfo = L4
  end
  L1.code = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
getIotWifiInfo = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "high_priority_access"
  L1 = L1(L2)
  L1 = L1 or L1
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = {}
  L5 = L0
  L4 = L0.set
  L6 = "wireless"
  L7 = "miot_2G"
  L8 = "miot_access_iotdev"
  L9 = tonumber
  L10 = L1
  L9, L10 = L9(L10)
  L4(L5, L6, L7, L8, L9, L10)
  L5 = L0
  L4 = L0.commit
  L6 = "wireless"
  L4(L5, L6)
  L4 = L2.forkExec
  L5 = "mesh_cmd sync_lite"
  L4(L5)
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
setIotWifiHighPrio = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L4 = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "enable"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ssid2g"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "ssid5g"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "encryption2g"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "encryption5g"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "password2g"
  L10 = L10(L11)
  L10 = L10 or L10
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "password5g"
  L11 = L11(L12)
  L11 = L11 or L11
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "wifi5mode"
  L12 = L12(L13)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_2g"
  L17 = "ssid"
  L18 = L6
  L13(L14, L15, L16, L17, L18)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_2g"
  L17 = "iotwifi5mode"
  L18 = L12
  L13(L14, L15, L16, L17, L18)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_2g"
  L17 = "encryption"
  L18 = L8
  L13(L14, L15, L16, L17, L18)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_5g"
  L17 = "ssid"
  L18 = L7
  L13(L14, L15, L16, L17, L18)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_5g"
  L17 = "iotwifi5mode"
  L18 = L12
  L13(L14, L15, L16, L17, L18)
  L14 = L2
  L13 = L2.set
  L15 = "wireless"
  L16 = "iot_5g"
  L17 = "encryption"
  L18 = L9
  L13(L14, L15, L16, L17, L18)
  if L8 == "none" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "ieee80211w"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
  elseif L8 == "ccmp" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae"
    L18 = "1"
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "key"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae_password"
    L18 = L10
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "ieee80211w"
    L18 = "2"
    L13(L14, L15, L16, L17, L18)
  elseif L8 == "psk2+ccmp" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae"
    L18 = "1"
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "key"
    L18 = L10
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae_password"
    L18 = L10
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "ieee80211w"
    L18 = "1"
    L13(L14, L15, L16, L17, L18)
  elseif L8 == "psk2" or L8 == "mixed-psk" or L8 == "psk" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "sae_password"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "ieee80211w"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "key"
    L18 = L10
    L13(L14, L15, L16, L17, L18)
  end
  if L9 == "none" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "ieee80211w"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
  elseif L9 == "ccmp" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae"
    L18 = "1"
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "key"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae_password"
    L18 = L11
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "ieee80211w"
    L18 = "2"
    L13(L14, L15, L16, L17, L18)
  elseif L9 == "psk2+ccmp" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae"
    L18 = "1"
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "key"
    L18 = L11
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae_password"
    L18 = L11
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "ieee80211w"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
  elseif L9 == "psk2" or L9 == "mixed-psk" or L9 == "psk" then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "sae_password"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "ieee80211w"
    L18 = ""
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "key"
    L18 = L11
    L13(L14, L15, L16, L17, L18)
  end
  L13 = tonumber
  L14 = L5
  L13 = L13(L14)
  if L13 == 0 then
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "disabled"
    L18 = 1
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "disabled"
    L18 = 1
    L13(L14, L15, L16, L17, L18)
  else
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_2g"
    L17 = "disabled"
    L18 = 0
    L13(L14, L15, L16, L17, L18)
    L14 = L2
    L13 = L2.set
    L15 = "wireless"
    L16 = "iot_5g"
    L17 = "disabled"
    L18 = 0
    L13(L14, L15, L16, L17, L18)
  end
  L14 = L2
  L13 = L2.commit
  L15 = "wireless"
  L13(L14, L15)
  L13 = L1.forkExec
  L14 = "/sbin/wifi update >/dev/null 2>/dev/null"
  L13(L14)
  L3.code = L4
  L13 = _UPVALUE0_
  L13 = L13.write_json
  L14 = L3
  L13(L14)
end
setIotWifiInfo = L3
function L3()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getAllWifiConnetDeviceList
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWifiConDev = L3
function L3()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getWifiChannelTxpwrList
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWifiChTx = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "channel1"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "txpwr1"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "channel2"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "txpwr2"
  L7 = L7(L8)
  L8 = L1.isStrNil
  L9 = L4
  L8 = L8(L9)
  if L8 then
    L8 = L1.isStrNil
    L9 = L6
    L8 = L8(L9)
    if L8 then
      L8 = L1.isStrNil
      L9 = L5
      L8 = L8(L9)
      if L8 then
        L8 = L1.isStrNil
        L9 = L7
        L8 = L8(L9)
        if L8 then
          L3 = 1502
      end
    end
  end
  else
    L8 = L0.setWifiChannelTxpwr
    L9 = L4
    L10 = L5
    L11 = L6
    L12 = L7
    L8(L9, L10, L11, L12)
  end
  if L3 ~= 0 then
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L3
    L8 = L8(L9)
    L2.msg = L8
  end
  L2.code = L3
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L2
  L8(L9)
  if L3 == 0 then
    L8 = _UPVALUE0_
    L8 = L8.close
    L8()
    L8 = L1.forkRestartWifi
    L8()
  end
end
setWifiChTx = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "txpwr"
  L4 = L4(L5)
  L5 = L1.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L3 = 1502
  else
    L5 = L0.setWifiTxpwr
    L6 = L4
    L5(L6)
  end
  if L3 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L3
    L5 = L5(L6)
    L2.msg = L5
  end
  L2.code = L3
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
  if L3 == 0 then
    L5 = _UPVALUE0_
    L5 = L5.close
    L5()
    L5 = L1.forkRestartWifi
    L5()
  end
end
setWifiTxpwr = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = 0
  L5 = L0.get_require_cac
  L5 = L5()
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "txbf"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "user_confirm"
  L7 = L7(L8)
  L8 = logger
  L8 = L8.log
  L9 = 6
  L10 = "======================== txbf "
  L11 = L6
  L10 = L10 .. L11
  L8(L9, L10)
  if L5 == true then
    L8 = L1.get_cac_time
    L9 = "cfg_file"
    L10 = "wl0"
    L11 = "0"
    L12 = "0"
    L8 = L8(L9, L10, L11, L12)
    L4 = L8
  else
    L4 = 0
  end
  if L7 == nil then
    L7 = "1"
  end
  if L4 == 600 and L7 == "0" then
    L2.need_confirm = 1
    L2.cac_time = L4
    L2.code = 0
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L2
    L8(L9)
    L8 = true
    return L8
  end
  L8 = L1.isStrNil
  L9 = L6
  L8 = L8(L9)
  if L8 then
    L3 = 1502
  else
    L8 = L0.setWifiTxbf
    L9 = L6
    L8(L9)
  end
  if L3 ~= 0 then
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L3
    L8 = L8(L9)
    L2.msg = L8
  end
  L2.cac_time = L4
  L2.code = L3
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L2
  L8(L9)
  if L3 == 0 then
    L8 = _UPVALUE0_
    L8 = L8.close
    L8()
    L8 = L1.forkRestartWifi
    L8()
  end
end
setWifiTxbf = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "ax"
  L4 = L4(L5)
  L5 = 0
  L6 = L0.get_require_cac
  L6 = L6()
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "user_confirm"
  L7 = L7(L8)
  if L7 == nil then
    L7 = "1"
  end
  if L6 == true then
    L8 = L1.get_cac_time
    L9 = "cfg_file"
    L10 = "wl0"
    L11 = "0"
    L12 = "0"
    L8 = L8(L9, L10, L11, L12)
    L5 = L8
  else
    L5 = 0
  end
  if L5 == 600 and L7 == "0" then
    L2.need_confirm = 1
    L2.cac_time = L5
    L2.code = 0
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L2
    L8(L9)
    L8 = true
    return L8
  end
  L8 = L1.isStrNil
  L9 = L4
  L8 = L8(L9)
  if L8 then
    L3 = 1502
  else
    L8 = L0.setWifiAx
    L9 = L4
    L8(L9)
  end
  if L3 ~= 0 then
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L3
    L8 = L8(L9)
    L2.msg = L8
  end
  L2.cac_time = L5
  L2.code = L3
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L2
  L8(L9)
  if L3 == 0 then
    L8 = _UPVALUE0_
    L8 = L8.close
    L8()
    L8 = L1.forkRestartWifi
    L8()
  end
end
setWifiAx = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wifiIndex"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  if L3 and L3 < 3 then
    L4 = L0.turnWifiOn
    L5 = L3
    L4(L5)
  else
    L2 = 1523
  end
  if L2 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2
    L4 = L4(L5)
    L1.msg = L4
  end
  L1.code = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
turnOnWifi = L3
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wifiIndex"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  if L3 and L3 < 3 then
    L4 = L0.turnWifiOff
    L5 = L3
    L4(L5)
  else
    L2 = 1523
  end
  if L2 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2
    L4 = L4(L5)
    L1.msg = L4
  end
  L1.code = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
shutDownWifi = L3
function L3(A0)
  local L1, L2, L3
  L1 = io
  L1 = L1.open
  L2 = A0
  L3 = "r"
  L1 = L1(L2, L3)
  if L1 == nil then
    L2 = false
    return L2
  end
  L3 = L1
  L2 = L1.close
  L2(L3)
  L2 = true
  return L2
end
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = {}
  L4 = 0
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "wifiIndex"
  L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ssid"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "pwd"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "encryption"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "channel"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "bandwidth"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "txpwr"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "hidden"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "on"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "txbf"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "weakenable"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "weakthreshold"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "kickthreshold"
  L17 = L17(L18)
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "ax"
  L18 = L18(L19)
  if L13 ~= nil then
    L19 = tonumber
    L20 = L13
    L19 = L19(L20)
    L13 = L19
  end
  if L5 == 1 then
    if L9 then
      L19 = L0.check
      L20 = 0
      L21 = L0.KEY_FUNC_2G_CHANNEL
      L22 = L9
      L19(L20, L21, L22)
    end
    if L11 then
      L19 = L0.check
      L20 = 0
      L21 = L0.KEY_FUNC_2G_SIGNAL
      L22 = L11
      L19(L20, L21, L22)
    end
  elseif L5 == 2 then
    if L9 then
      L19 = L0.check
      L20 = 0
      L21 = L0.KEY_FUNC_5G_CHANNEL
      L22 = L9
      L19(L20, L21, L22)
    end
    if L11 then
      L19 = L0.check
      L20 = 0
      L21 = L0.KEY_FUNC_5G_SIGNAL
      L22 = L11
      L19(L20, L21, L22)
    end
  elseif L5 == 3 then
  end
  L19 = true
  L20 = false
  if L5 == 1 then
    L21 = L1.getWifiBasicInfo
    L22 = L5
    L21 = L21(L22)
    L22 = L21.password
    if L22 == nil then
      L21.password = ""
    end
    L22 = L21.ssid
    if L22 == L6 then
      L22 = L21.password
      if L22 == L7 then
        L22 = L21.encryption
        if L22 == L8 then
          goto lbl_133
        end
      end
    end
    L20 = true
  end
  ::lbl_133::
  L21 = L1.checkSSID
  L22 = L6
  L23 = 31
  L21 = L21(L22, L23)
  L4 = L21
  if L4 == 0 then
    if L5 == 1 or L5 == 2 then
      L21 = L1.setWifiBasicInfo
      L22 = L5
      L23 = L6
      L24 = L7
      L25 = L8
      L26 = L9
      L27 = L11
      L28 = L12
      L29 = L13
      L30 = L10
      L31 = nil
      L32 = L14
      L33 = L15
      L34 = L16
      L35 = L17
      L36 = L18
      L21 = L21(L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36)
      if L21 == false then
        L22 = L1.checkWifiPasswd
        L23 = L7
        L24 = L8
        L22 = L22(L23, L24)
        L4 = L22
      end
    elseif L5 == 3 then
      L19 = true
    end
  end
  if L4 ~= 0 then
    L21 = _UPVALUE1_
    L21 = L21.getErrorMessage
    L22 = L4
    L21 = L21(L22)
    L3.msg = L21
  end
  L3.code = L4
  L21 = _UPVALUE0_
  L21 = L21.write_json
  L22 = L3
  L21(L22)
  if L4 == 0 then
    L21 = _UPVALUE0_
    L21 = L21.close
    L21()
    if L19 then
      if L20 then
        L21 = L2.forkRestartWifiNotify
        L21()
      else
        L21 = L2.forkRestartWifiNotifyButMiio
        L21()
      end
    end
  end
end
setWifi = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = {}
  L4 = 0
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "wifiIndex"
  L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ssid"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "pwd"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "encryption"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "channel"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "bandwidth"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "txpwr"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "hidden"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "on"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "txbf"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "ax"
  L15 = L15(L16)
  if L13 ~= nil then
    L16 = tonumber
    L17 = L13
    L16 = L16(L17)
    L13 = L16
  end
  if L9 == "0" then
    L10 = "0"
  end
  if L5 == 1 then
    if L9 then
      L16 = L0.check
      L17 = 0
      L18 = L0.KEY_FUNC_2G_CHANNEL
      L19 = L9
      L16(L17, L18, L19)
    end
    if L11 then
      L16 = L0.check
      L17 = 0
      L18 = L0.KEY_FUNC_2G_SIGNAL
      L19 = L11
      L16(L17, L18, L19)
    end
  elseif L5 == 2 then
    if L9 then
      L16 = L0.check
      L17 = 0
      L18 = L0.KEY_FUNC_5G_CHANNEL
      L19 = L9
      L16(L17, L18, L19)
    end
    if L11 then
      L16 = L0.check
      L17 = 0
      L18 = L0.KEY_FUNC_5G_SIGNAL
      L19 = L11
      L16(L17, L18, L19)
    end
  elseif L5 == 3 then
  end
  L16 = true
  L17 = false
  if L5 == 1 then
    L18 = L1.getWifiBasicInfo
    L19 = L5
    L18 = L18(L19)
    L19 = L18.password
    if L19 == nil then
      L18.password = ""
    end
    L19 = L18.ssid
    if L19 == L6 then
      L19 = L18.password
      if L19 == L7 then
        L19 = L18.encryption
        if L19 == L8 then
          goto lbl_124
        end
      end
    end
    L17 = true
  end
  ::lbl_124::
  L18 = L1.checkSSID
  L19 = L6
  L20 = 31
  L18 = L18(L19, L20)
  L4 = L18
  if L4 == 0 then
    if L5 == 1 or L5 == 2 then
      L18 = L1.setWifiBasicInfo
      L19 = L5
      L20 = L6
      L21 = L7
      L22 = L8
      L23 = L9
      L24 = L11
      L25 = L12
      L26 = L13
      L27 = L10
      L28 = nil
      L29 = L14
      L30, L31, L32 = nil, nil, nil
      L33 = L15
      L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
      if L18 == false then
        L19 = L1.checkWifiPasswd
        L20 = L7
        L21 = L8
        L19 = L19(L20, L21)
        L4 = L19
      end
    elseif L5 == 3 then
      L18 = require
      L19 = "xiaoqiang.module.XQGuestWifi"
      L18 = L18(L19)
      L19 = require
      L20 = "xiaoqiang.module.XQWifiShare"
      L19 = L19(L20)
      L20 = L18.setGuestWifi
      L21 = 1
      L22 = L6
      L23 = L8
      L24 = L7
      L25 = 1
      L26 = L13
      L20 = L20(L21, L22, L23, L24, L25, L26)
      if L20 == false then
        L4 = 1615
      else
        if L8 ~= "none" and L13 == 1 then
          L21 = L19.wifi_share_switch
          L22 = 0
          L21(L22)
        end
        L16 = false
      end
    end
  end
  if L4 ~= 0 then
    L18 = _UPVALUE1_
    L18 = L18.getErrorMessage
    L19 = L4
    L18 = L18(L19)
    L3.msg = L18
  end
  L3.code = L4
  L18 = _UPVALUE0_
  L18 = L18.write_json
  L19 = L3
  L18(L19)
end
setWifiWithoutRestart = L4
function L4(A0)
  local L1, L2, L3, L4
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "on"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.on = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ssid"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.ssid = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "pwd"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L2 = L2 or L2
  L1.passwd = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "encryption"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.encryption = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "channel"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.channel = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "txpwr"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.txpwr = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "hidden"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.hidden = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bandwidth"
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L1.bw = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bsd"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = L1.on
  if L3 == nil then
    if L2 == "1" then
      L1.on = 1
      return L1
    else
      return L1
    end
  else
    L3 = tonumber
    L4 = L1.on
    L3 = L3(L4)
    L1.on = L3
    return L1
  end
end
get_http_formvalue_by_index = L4
function L4(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = 0
  L3 = A0.ssid
  if L3 then
    L3 = string
    L3 = L3.len
    L4 = A0.ssid
    L3 = L3(L4)
    if L3 ~= 0 then
      goto lbl_16
    end
  end
  L2 = 0
  goto lbl_32
  ::lbl_16::
  L3 = string
  L3 = L3.len
  L4 = A0.ssid
  L3 = L3(L4)
  if 31 < L3 then
    L2 = 1572
  else
    L3 = A0.on
    if L3 == 1 then
      L3 = L1.checkWifiPasswd
      L4 = A0.passwd
      L5 = A0.encryption
      L3 = L3(L4, L5)
      L2 = L3
    end
  end
  ::lbl_32::
  return L2
end
check_wl_setting_info = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQNfcUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = {}
  L4 = {}
  L5 = {}
  L6 = 0
  L8 = L0
  L7 = L0.get
  L9 = "misc"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L9 = L0
  L8 = L0.get
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = L0.get
  L13 = "ifname_5GH"
  L9 = L9(L10, L11, L12, L13)
  L9 = L9 or L9
  L3 = L10
  for L13, L14 in L10, L11, L12 do
    L15 = L14.ifname
    if L15 == L8 then
      L15 = L14.status
      if L15 == "1" then
        L4 = L14
        L6 = 1
        break
      end
    end
  end
  if L6 == 0 then
    for L13, L14 in L10, L11, L12 do
      L15 = L14.ifname
      if L15 == L9 then
        L15 = L14.status
        if L15 == "1" then
          L4 = L14
          L6 = 1
          break
        end
      end
    end
  end
  if L6 == 0 then
    for L13, L14 in L10, L11, L12 do
      L15 = L14.ifname
      if L15 == L7 then
        L15 = L14.status
        if L15 == "1" then
          L4 = L14
          L6 = 1
          break
        end
      end
    end
  end
  if L6 == 0 then
    for L13, L14 in L10, L11, L12 do
      L15 = L14.status
      if L15 == "1" then
        L4 = L14
        L6 = 1
        break
      end
    end
  end
  L5.code = 0
  L13 = "misc"
  L14 = "nfc"
  L15 = "nfc_support"
  L13, L14, L15 = L11(L12, L13, L14, L15)
  L5.nfc_support = L10
  L13 = "nfc"
  L14 = "nfc"
  L15 = "nfc_enable"
  L13, L14, L15 = L11(L12, L13, L14, L15)
  L5.nfc_enable = L10
  if L6 == 1 then
    if L10 == "ccmp" then
      L5.wpa3_only = 1
  end
  else
    L5.wpa3_only = 0
  end
  L10(L11)
end
getNfcInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.util.XQNfcUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "nfc_enable"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L7 = L1
  L6 = L1.set
  L8 = "nfc"
  L9 = "nfc"
  L10 = "nfc_enable"
  L11 = L4
  L6(L7, L8, L9, L10, L11)
  L7 = L1
  L6 = L1.commit
  L8 = "nfc"
  L6(L7, L8)
  if L4 == "0" then
    L6 = L2.nfc_disable
    L6()
  else
    L6 = L2.nfc_update
    L6()
  end
  L6 = L3.isMeshRe
  L6 = L6()
  if L6 then
    L6 = L2.nfc_mesh_sync_disable
    L6()
  else
    L6 = L3.isMeshCap
    L6 = L6()
    if L6 then
      L6 = L3.GenRandID
      L7 = 8
      L6 = L6(L7)
      L8 = L1
      L7 = L1.set
      L9 = "nfc"
      L10 = "nfc"
      L11 = "config_id"
      L12 = L6
      L7(L8, L9, L10, L11, L12)
      L7 = {}
      L7.cmd = "sync_nfc"
      if L4 == "0" then
        L8 = "0"
        if L8 then
          goto lbl_65
        end
      end
      L8 = "1"
      ::lbl_65::
      L7.nfc_enable = L8
      L8 = require
      L9 = "luci.json"
      L8 = L8(L9)
      L9 = L8.encode
      L10 = L7
      L9 = L9(L10)
      L10 = L0.log
      L11 = 6
      L12 = "CAP call RE do action msg:"
      L13 = L9
      L12 = L12 .. L13
      L10(L11, L12)
      L10 = L3.forkExec
      L11 = "/sbin/whc_to_re_common_api.sh action '"
      L12 = L9
      L13 = "'"
      L11 = L11 .. L12 .. L13
      L10(L11)
    end
  end
  L7 = L1
  L6 = L1.commit
  L8 = "nfc"
  L6(L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L5
  L6(L7)
end
setNfcStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.isMeshMLOSupport
  L2 = L2()
  L3 = {}
  L3.code = 0
  if L2 then
    L4 = 1
    if L4 then
      goto lbl_19
    end
  end
  L4 = 0
  ::lbl_19::
  L3.mlo_support = L4
  L4 = tonumber
  L6 = L0
  L5 = L0.get
  L7 = "wireless"
  L8 = "hostap_mld"
  L9 = "mlo_enable"
  L5, L6, L7, L8, L9 = L5(L6, L7, L8, L9)
  L4 = L4(L5, L6, L7, L8, L9)
  L4 = L4 or L4
  L3.mlo_enable = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
getHostapMLO = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mlo_enable"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  if L3 == 1 then
    L4 = L0.mlo_hostap_enable
    L4()
  else
    L4 = L0.mlo_hostap_disable
    L4()
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
  L4 = L1.forkRestartWifiNotify
  L4()
end
setHostapMLO = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = 0
  L7 = L0
  L6 = L0.get
  L8 = "misc"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L8 = L0
  L7 = L0.get
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L8 = L0.get
  L12 = "ifname_5GH"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L2 = L9
  for L12, L13 in L9, L10, L11 do
    L14 = L13.ifname
    if L14 == L7 then
      L14 = L13.status
      if L14 == "1" then
        L3 = L13
        L5 = 1
        break
      end
    end
  end
  if L5 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.ifname
      if L14 == L8 then
        L14 = L13.status
        if L14 == "1" then
          L3 = L13
          L5 = 1
          break
        end
      end
    end
  end
  if L5 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.ifname
      if L14 == L6 then
        L14 = L13.status
        if L14 == "1" then
          L3 = L13
          L5 = 1
          break
        end
      end
    end
  end
  if L5 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.status
      if L14 == "1" then
        L3 = L13
        L5 = 1
        break
      end
    end
  end
  L4.code = 0
  L12 = "wireless"
  L13 = "wps"
  L14 = "enable"
  L12, L13, L14 = L10(L11, L12, L13, L14)
  L4.wps_enable = L9
  if L5 == 1 then
    if L9 == "ccmp" then
      L4.wpa3_only = 1
  end
  else
    L4.wpa3_only = 0
  end
  L9(L10)
end
getWpsInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L3 = L3(L4)
  L4 = L1.getAllWifiInfo
  L4 = L4()
  L5 = L1.get_wlan_count
  L5 = L5()
  L6 = L1.getWifiDevNames
  L6 = L6()
  L7 = {}
  L8 = {}
  L9 = {}
  L10 = {}
  L11 = 0
  L12 = 0
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "user_confirm"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "ver"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "bsd"
  L15 = L15(L16)
  L16 = L4[1]
  L16 = L16.bsd
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L17 = L17(L18)
  if L17 then
    if L18 == "table" then
      L17 = L17[1]
    end
  end
  L17 = L18
  if L13 == nil then
    L13 = "1"
  end
  for L21 = L18, L19, L20 do
    L9[L21] = L22
    if L22 then
      if L22 ~= nil then
        if L22 == false then
          L22.channel = 0
        end
      end
    end
  end
  if L15 ~= nil then
    if L18 == 1 then
      if L16 ~= nil then
        if L18 ~= 0 then
          goto lbl_99
        end
      end
      L18.on = 1
      ::lbl_99::
      for L21 = L18, L19, L20 do
        if L22 then
          L22.on = L23
          L22.ssid = L23
          L22.encryption = L23
          L22.passwd = L23
          L22.hidden = L23
        end
      end
      if L17 == nil or not L17 then
      end
      if L16 ~= nil then
      end
      if L19 == 0 and L18 == 1 then
        L19()
      end
      L21 = L0.KEY_FUNC_WIFI_BSD
      L19(L20, L21, L22)
    end
  end
  if L16 ~= nil then
    if L18 == 1 and L15 ~= nil then
      if L18 == 0 then
        if L14 == nil then
          L18.on = 1
          for L21 = L18, L19, L20 do
            if L22 then
              L22.on = L23
              if 28 < L22 then
                L22.ssid = L23
              elseif L21 == 2 then
                L22.ssid = L23
              elseif L21 == 3 then
                L25 = L1.get5G2BandSuffix
                L25 = L25()
                L25 = 1
                L26 = 31
                L22.ssid = L23
              end
              L22.encryption = L23
              L22.passwd = L23
              L22.hidden = L23
            end
          end
        end
        L18()
      end
    end
  end
  for L21 = L18, L19, L20 do
    if L22 then
      L10 = L22
      if 0 < L10 then
        L22.code = L10
        L22.msg = L23
      end
      L11 = L10
    end
  end
  L7.code = L11
  if L11 ~= 0 then
    L7.msg = L18
    L7.errorDetails = L8
    L18(L19)
    return
  end
  if L15 ~= nil then
    if L18 ~= 0 then
      goto lbl_297
    end
  end
  for L21 = L18, L19, L20 do
    if L22 == 1 then
      L25 = L9[L21]
      L25 = L25.channel
      L26 = L9[L21]
      L26 = L26.bw
      cac_time_new = L22
      if L12 < L22 then
        L12 = cac_time_new
      end
    end
  end
  goto lbl_298
  ::lbl_297::
  L12 = 0
  ::lbl_298::
  if L12 == 600 and L13 == "0" then
    L7.need_confirm = 1
    L7.cac_time = L12
    L7.code = 0
    L18(L19)
    return L18
  end
  L21 = "weakthreshold"
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L21 = L21(L22)
  if L3 then
    if L22 then
      L25 = L15
      L22(L23, L24, L25)
    end
  end
  for L25 = L22, L23, L24 do
    L26 = L9[L25]
    if L26 then
      L26 = L1.setWifiBasicInfo
      L27 = L25
      L28 = L9[L25]
      L28 = L28.ssid
      L29 = L9[L25]
      L29 = L29.passwd
      L30 = L9[L25]
      L30 = L30.encryption
      L31 = L9[L25]
      L31 = L31.channel
      L32 = L9[L25]
      L32 = L32.txpwr
      L33 = L9[L25]
      L33 = L33.hidden
      L34 = L9[L25]
      L34 = L34.on
      L35 = L9[L25]
      L35 = L35.bw
      L36 = L15
      L37 = L18
      L38 = L19
      L39 = L20
      L40 = L21
      L41 = L17
      L26(L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41)
    end
  end
  L7.cac_time = L12
  L22(L23)
  L22()
  L22()
end
setAllWifi = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.checkWiredLink
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.link = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
checkWiredLink = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.getLanWanInfo
  L2 = "lan"
  L1 = L1(L2)
  L2 = L0.getLanLinkList
  L2 = L2()
  L3 = {}
  L3.code = 0
  L3.info = L1
  L3.linkList = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
getLanInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wan_name"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = L1.PS_WAN_SERVICE_NAME_MAP
  L3 = L3[L2]
  L2 = L3 or L2
  if not L3 then
    L2 = "wan"
  end
  L3 = L0.getLanWanInfo
  L4 = L2
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L4.info = L3
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
getWanInfo = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = L0.getWanLanNetworkStatistics
  L2 = "wan"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L2.statistics = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getWanStatistics = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = L0.getDevNetStatisticsList
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.statistics = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getDevsStatistics = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = L0.getDevNetStatisticsDict
  L4 = L4()
  L5 = L1.macFormat
  L6 = L3
  L5 = L5(L6)
  L5 = L4[L5]
  L2.code = 0
  L2.statistics = L5
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L2
  L6(L7)
end
getDevStatistics = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = luci
  L4 = L4.model
  L4 = L4.uci
  L4 = L4.cursor
  L4 = L4()
  L5 = {}
  L6 = 0
  L7 = L0.getAutoWanType
  L7 = L7()
  if L7 == false then
    L6 = 1524
  else
    L5.wanType = L7
    L9 = L4
    L8 = L4.get
    L10 = "network"
    L11 = "wan"
    L12 = "username"
    L8 = L8(L9, L10, L11, L12)
    L5.pppoeName = L8
    L9 = L4
    L8 = L4.get
    L10 = "network"
    L11 = "wan"
    L12 = "password"
    L8 = L8(L9, L10, L11, L12)
    L5.pppoePassword = L8
    L8 = L3.isSupport160Mhz
    L8 = L8()
    L5.support160Mhz = L8
  end
  if L6 ~= 0 then
    L8 = _UPVALUE0_
    L8 = L8.getErrorMessage
    L9 = L6
    L8 = L8(L9)
    L5.msg = L8
  end
  L5.code = L6
  L8 = _UPVALUE1_
  L8 = L8.write_json
  L9 = L5
  L8(L9)
end
getAutoWanType = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = os
  L4 = L4.execute
  L5 = "/etc/init.d/autowan off"
  L4(L5)
  L4 = os
  L4 = L4.execute
  L5 = "/etc/init.d/network reload_warm 2 eth0; sleep 1"
  L4(L5)
  L4 = L1.exec
  L5 = "ssdk_sh port linkstatus get 2 | grep ENABLE | wc -l"
  L4 = L4(L5)
  L5 = logger
  L5 = L5.log
  L6 = 6
  L7 = "==== getAutoWanLink() get eth0 link: "
  L8 = L1.trim
  L9 = L4
  L8 = L8(L9)
  L7 = L7 .. L8
  L5(L6, L7)
  L5 = L1.trim
  L6 = L4
  L5 = L5(L6)
  L2.code = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
getAutoWanLink = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getLanDHCPService
  L2 = L2()
  L1.code = 0
  L1.info = L2
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getLanDhcp = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wifiIndex"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  L2 = {}
  L2.code = 0
  L3 = L0.getDefaultWifiChannels
  L4 = L1
  L3 = L3(L4)
  L2.list = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getChannels = L4
function L4()
  local L0, L1, L2
  L0 = luci
  L0 = L0.sys
  L0 = L0.call
  L1 = "env -i /sbin/ifdown wan"
  L0(L1)
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
wanDown = L4
function L4()
  local L0, L1, L2
  L0 = luci
  L0 = L0.sys
  L0 = L0.call
  L1 = "env -i /sbin/ifup wan"
  L0(L1)
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
wanUp = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.cbi.datatypes"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.module.XQIPConflict"
  L5 = L5(L6)
  L6 = {}
  L7 = 0
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "ip"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "mask"
  L9 = L9(L10)
  L10 = L3.ipaddr
  L11 = L8
  L10 = L10(L11)
  if not L10 then
    L7 = 1525
  else
    L10 = L3.ipaddr
    L11 = L9
    L10 = L10(L11)
    if not L10 then
      L7 = 1527
    else
      L10 = L5.lan_wan_ip_conflict_chk
      L11 = L8
      L12 = L9
      L10 = L10(L11, L12)
      if L10 then
        L7 = 1526
      else
        L10 = L1.checkLanIpMask
        L11 = L8
        L12 = L9
        L10 = L10(L11, L12)
        L7 = L10
      end
    end
  end
  if L7 == 0 then
    L10 = L1.setLanIp
    L11 = L8
    L12 = L9
    L10(L11, L12)
    L10 = L5.lan_ip_conflict_resolution
    L10()
    L6.ip = L8
  else
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L7
    L10 = L10(L11)
    L6.msg = L10
  end
  L6.code = L7
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L6
  L10(L11)
  if L7 == 0 then
    L10 = _UPVALUE0_
    L10 = L10.close
    L10()
    L10 = L0.system
    L10 = L10.tr069
    if L10 then
      L10 = L0.system
      L10 = L10.tr069
      if L10 == "1" then
        L10 = nil
        L11 = L2.isMeshCap
        L11 = L11()
        if L11 then
          L11 = "sh /sbin/whc_to_re_common_api.sh gw_update "
          L12 = L8
          L13 = "; sleep 3;"
          L10 = L11 .. L12 .. L13
          L11 = logger
          L11 = L11.log
          L12 = 4
          L13 = string
          L13 = L13.format
          L14 = "@ activate cmd=%s!"
          L15 = L10
          L13, L14, L15 = L13(L14, L15)
          L11(L12, L13, L14, L15)
        end
        L11 = _UPVALUE0_
        L11 = L11.formvalue
        L12 = "is_tr069"
        L11 = L11(L12)
        if not L11 then
          if L10 then
            L12 = L10
            L13 = "reboot"
            L10 = L12 .. L13
          else
            L10 = "reboot"
          end
        end
        if L10 then
          L12 = L2.forkExec
          L13 = L10
          L12(L13)
        end
    end
    else
      L10 = L2.isMeshCap
      L10 = L10()
      if L10 then
        L10 = "sh /sbin/whc_to_re_common_api.sh gw_update "
        L11 = L8
        L12 = "; sleep 3; reboot"
        L10 = L10 .. L11 .. L12
        L11 = logger
        L11 = L11.log
        L12 = 4
        L13 = string
        L13 = L13.format
        L14 = "@ activate cmd=%s!"
        L15 = L10
        L13, L14, L15 = L13(L14, L15)
        L11(L12, L13, L14, L15)
        L11 = L2.forkExec
        L12 = L10
        L11(L12)
      else
        L10 = L2.forkReboot
        L10()
      end
    end
  end
end
setLanIp = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQFeatures"
  L4 = L4(L5)
  L4 = L4.FEATURES
  L5 = 0
  L6 = L3.isStrNil
  L7 = A0.wanType
  L6 = L6(L7)
  if L6 then
    L6 = L3.isStrNil
    L7 = A0.username
    L6 = L6(L7)
    if L6 then
      L6 = L3.isStrNil
      L7 = A0.password
      L6 = L6(L7)
      if L6 then
        L6 = L3.isStrNil
        L7 = A0.ip
        L6 = L6(L7)
        if L6 then
          L6 = L3.isStrNil
          L7 = A0.mask
          L6 = L6(L7)
          if L6 then
            L6 = L3.isStrNil
            L7 = A0.gw
            L6 = L6(L7)
            if L6 then
              L6 = L3.isStrNil
              L7 = A0.dns1
              L6 = L6(L7)
              if L6 then
                L6 = L3.isStrNil
                L7 = A0.dns2
                L6 = L6(L7)
                if L6 then
                  L6 = L3.isStrNil
                  L7 = A0.autoset
                  L6 = L6(L7)
                  if L6 then
                    L6 = L3.isStrNil
                    L7 = A0.special
                    L6 = L6(L7)
                    if L6 then
                      L6 = 1502
                      return L6
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L6 = L3.isStrNil
  L7 = A0.dns1
  L6 = L6(L7)
  if L6 then
    L6 = L3.isStrNil
    L7 = A0.dns2
    L6 = L6(L7)
    if L6 then
      A0.autoset = "1"
  end
  else
    A0.autoset = "0"
  end
  L6 = L2.get_wanDevCfg
  L7 = A0.wanConn
  L8 = "Router"
  L9 = A0.wanType
  L10 = 4
  L6 = L6(L7, L8, L9, L10)
  A0.wanDevCfg = L6
  L6 = A0.wanDevCfg
  if not L6 then
    L6 = L1.log
    L7 = 3
    L8 = "_setWan: get wanDevCfg failed!"
    L6(L7, L8)
    L6 = 1529
    return L6
  end
  L6 = L4.system
  L6 = L6.international
  if L6 then
    L6 = L4.system
    L6 = L6.international
    if L6 == "1" then
      L6 = A0.wanType
      if L6 ~= "l2tp" then
        L6 = A0.wanType
        if L6 ~= "pptp" then
          goto lbl_221
        end
      end
      L6 = A0.client
      if L6 == "web" then
        L6 = L1.check
        L7 = 0
        L8 = L1.KEY_VALUE_NETWORK_VPN
        L9 = 1
        L6(L7, L8, L9)
      end
      L6 = L2.chkWan4VPN
      L7 = A0.wanType
      L8 = A0.vpnServer
      L9 = A0.vpnUsername
      L10 = A0.vpnPassword
      L6 = L6(L7, L8, L9, L10)
      L5 = L6
      if L5 == 0 then
        L6 = A0.baseWanType
        if L6 then
          L6 = A0.baseWanType
          if L6 == "dhcp" then
            L6 = L2.chkWan4Dhcp
            L7 = A0.autoset
            L8 = A0.dns1
            L9 = A0.dns2
            L6 = L6(L7, L8, L9)
            L5 = L6
          else
            L6 = A0.baseWanType
            if L6 == "static" then
              L6 = L2.chkWan4StaticIP
              L7 = A0.ipChk
              L8 = A0.ip
              L9 = A0.mask
              L10 = A0.gw
              L11 = A0.dns1
              L12 = A0.dns2
              L6 = L6(L7, L8, L9, L10, L11, L12)
              L5 = L6
            else
              L6 = A0.baseWanType
              if L6 == "pppoe" then
                L6 = L2.chkWan4PPPoE
                L7 = A0.autoset
                L8 = A0.username
                L9 = A0.password
                L10 = A0.mtu
                L11 = A0.dns1
                L12 = A0.dns2
                L13 = A0.service
                L6 = L6(L7, L8, L9, L10, L11, L12, L13)
                L5 = L6
              else
                L5 = 1537
              end
            end
          end
        else
          L5 = 1537
        end
        if L5 ~= 0 then
          return L5
        end
      else
        return L5
      end
      L6 = L2.setWan4VPN
      L7 = A0
      L6 = L6(L7)
      L5 = L6
      if L5 ~= 0 then
        return L5
      end
      L6 = A0.baseWanType
      if L6 == "dhcp" then
        L6 = L2.setWan4Dhcp
        L7 = A0
        L6 = L6(L7)
        L5 = L6
      else
        L6 = A0.baseWanType
        if L6 == "static" then
          L6 = L2.setWan4StaticIP
          L7 = A0
          L6 = L6(L7)
          L5 = L6
        else
          L6 = A0.baseWanType
          if L6 == "pppoe" then
            L6 = L3.isStrNil
            L7 = A0.dns1
            L6 = L6(L7)
            if L6 then
              L6 = L3.isStrNil
              L7 = A0.dns2
              L6 = L6(L7)
              if L6 then
                L6 = A0.autoset
                if L6 == "0" then
                  A0.autoset = "1"
                end
              end
            end
            L6 = L2.setWan4PPPoE
            L7 = A0
            L6 = L6(L7)
            L5 = L6
          end
        end
      end
      do return L5 end
      goto lbl_228
      ::lbl_221::
      L6 = L2.stopWan4VPN
      L7 = A0
      L6 = L6(L7)
      L5 = L6
      if L5 ~= 0 then
        return L5
      end
    end
  end
  ::lbl_228::
  L6 = A0.wanType
  if L6 == "pppoe" then
    L6 = A0.client
    if L6 == "web" then
      L6 = L1.check
      L7 = 0
      L8 = L1.KEY_VALUE_NETWORK_PPPOE
      L9 = 1
      L6(L7, L8, L9)
    end
    L6 = L2.chkWan4PPPoE
    L7 = A0.autoset
    L8 = A0.username
    L9 = A0.password
    L10 = A0.mtu
    L11 = A0.dns1
    L12 = A0.dns2
    L13 = A0.service
    L6 = L6(L7, L8, L9, L10, L11, L12, L13)
    L5 = L6
    if L5 == 0 then
      L6 = L3.isStrNil
      L7 = A0.dns1
      L6 = L6(L7)
      if L6 then
        L6 = L3.isStrNil
        L7 = A0.dns2
        L6 = L6(L7)
        if L6 then
          L6 = A0.autoset
          if L6 == "0" then
            A0.autoset = "1"
          end
        end
      end
      L6 = L2.setWan4PPPoE
      L7 = A0
      L6 = L6(L7)
      L5 = L6
    end
  else
    L6 = A0.wanType
    if L6 == "dhcp" then
      L6 = A0.client
      if L6 == "web" then
        L6 = L1.check
        L7 = 0
        L8 = L1.KEY_VALUE_NETWORK_DHCP
        L9 = 1
        L6(L7, L8, L9)
      end
      L6 = L2.chkWan4Dhcp
      L7 = A0.autoset
      L8 = A0.dns1
      L9 = A0.dns2
      L6 = L6(L7, L8, L9)
      L5 = L6
      if L5 == 0 then
        L6 = L2.setWan4Dhcp
        L7 = A0
        L6 = L6(L7)
        L5 = L6
      end
    else
      L6 = A0.wanType
      if L6 == "static" then
        L6 = A0.client
        if L6 == "web" then
          L6 = L1.check
          L7 = 0
          L8 = L1.KEY_VALUE_NETWORK_STATIC
          L9 = 1
          L6(L7, L8, L9)
        end
        L6 = L2.chkWan4StaticIP
        L7 = A0.ipChk
        L8 = A0.ip
        L9 = A0.mask
        L10 = A0.gw
        L11 = A0.dns1
        L12 = A0.dns2
        L6 = L6(L7, L8, L9, L10, L11, L12)
        L5 = L6
        if L5 == 0 then
          L6 = L2.setWan4StaticIP
          L7 = A0
          L6 = L6(L7)
          L5 = L6
        end
      end
    end
  end
  return L5
end
_setWan = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.util.XQPortServiceUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "wan_name"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "client"
  L4 = L4(L5)
  L1.client = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wanType"
  L4 = L4(L5)
  L1.wanType = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "pppoeName"
  L4 = L4(L5)
  L1.username = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "pppoePwd"
  L4 = L4(L5)
  L1.password = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticIp"
  L4 = L4(L5)
  L1.ip = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticMask"
  L4 = L4(L5)
  L1.mask = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticGateway"
  L4 = L4(L5)
  L1.gw = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dns1"
  L4 = L4(L5)
  L1.dns1 = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dns2"
  L4 = L4(L5)
  L1.dns2 = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "special"
  L4 = L4(L5)
  L4 = L4 or L4
  L1.special = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mtu"
  L4 = L4(L5)
  L1.mtu = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "service"
  L4 = L4(L5)
  L1.service = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "autoset"
  L4 = L4(L5)
  L4 = L4 or L4
  L1.autoset = L4
  L4 = L2.PS_WAN_SERVICE_NAME_MAP
  L4 = L4[L3]
  L4 = L4 or L4
  L1.wanConn = L4
  L1.ipChk = "1"
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "baseWanType"
  L4 = L4(L5)
  L1.baseWanType = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnServer"
  L4 = L4(L5)
  L1.vpnServer = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnUsername"
  L4 = L4(L5)
  L1.vpnUsername = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnPassword"
  L4 = L4(L5)
  L1.vpnPassword = L4
  L4 = _setWan
  L5 = L1
  L4 = L4(L5)
  L0.code = L4
  L4 = L0.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L0.code
    L4 = L4(L5)
    L0.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
setWan = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.util.XQPortServiceUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "wan_name"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "client"
  L4 = L4(L5)
  L1.client = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wanType"
  L4 = L4(L5)
  L1.wanType = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "pppoeName"
  L4 = L4(L5)
  L1.username = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "pppoePwd"
  L4 = L4(L5)
  L1.password = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticIp"
  L4 = L4(L5)
  L1.ip = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticMask"
  L4 = L4(L5)
  L1.mask = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "staticGateway"
  L4 = L4(L5)
  L1.gw = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dns1"
  L4 = L4(L5)
  L1.dns1 = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dns2"
  L4 = L4(L5)
  L1.dns2 = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "special"
  L4 = L4(L5)
  L4 = L4 or L4
  L1.special = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mtu"
  L4 = L4(L5)
  L1.mtu = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "service"
  L4 = L4(L5)
  L1.service = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "autoset"
  L4 = L4(L5)
  L4 = L4 or L4
  L1.autoset = L4
  L4 = L2.PS_WAN_SERVICE_NAME_MAP
  L4 = L4[L3]
  L4 = L4 or L4
  L1.wanConn = L4
  L1.ipChk = "0"
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "baseWanType"
  L4 = L4(L5)
  L1.baseWanType = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnServer"
  L4 = L4(L5)
  L1.vpnServer = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnUsername"
  L4 = L4(L5)
  L1.vpnUsername = L4
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "vpnPassword"
  L4 = L4(L5)
  L1.vpnPassword = L4
  L4 = _setWan
  L5 = L1
  L4 = L4(L5)
  L0.code = L4
  L4 = L0.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L0.code
    L4 = L4(L5)
    L0.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
setWanNew = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = 0
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "wanType"
  L5 = L5(L6)
  L6 = L2.parseCmdline
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "ipaddr"
  L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L7 = L2.parseCmdline
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "gw"
  L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L8 = L2.parseCmdline
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "prefix"
  L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L9 = L2.parseCmdline
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "assign"
  L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L10 = L2.parseCmdline
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "dns1"
  L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L11 = L2.parseCmdline
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "dns2"
  L12, L13, L14, L15, L16, L17, L18, L19 = L12(L13)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
  L12 = L1.isStrNil
  L13 = L5
  L12 = L12(L13)
  if L12 then
    L12 = L1.isStrNil
    L13 = L6
    L12 = L12(L13)
    if L12 then
      L12 = L1.isStrNil
      L13 = L7
      L12 = L12(L13)
      if L12 then
        L12 = L1.isStrNil
        L13 = L8
        L12 = L12(L13)
        if L12 then
          L3 = 1502
      end
    end
  end
  elseif L5 ~= "native" and L5 ~= "nat" and L5 ~= "static" and L5 ~= "off" then
    L3 = 1606
  else
    L12 = L0.setWan6
    L13 = L5
    L14 = L10
    L15 = L11
    L16 = L6
    L17 = L7
    L18 = L8
    L19 = L9
    L12(L13, L14, L15, L16, L17, L18, L19)
  end
  L4.code = L3
  if L3 ~= 0 then
    L12 = _UPVALUE1_
    L12 = L12.getErrorMessage
    L13 = L3
    L12 = L12(L13)
    L4.msg = L12
  end
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L4
  L12(L13)
end
setWan6 = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSecureUtil"
  L4 = L4(L5)
  L5 = 0
  L6 = {}
  L7 = {}
  L8 = 0
  L9 = 64
  L10 = "wan"
  L11 = L4.parseCmdline
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "wan6_name"
  L12 = L12(L13)
  L12 = L12 or L12
  L11 = L11(L12)
  L12 = tonumber
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "automode"
  L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L13(L14)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L12 = L12 or L12
  L13 = L4.parseCmdline
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "ipv6_mode"
  L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L14(L15)
  L13 = L13(L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L14 = L4.parseCmdline
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "dns1"
  L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L15(L16)
  L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L15 = L4.parseCmdline
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "dns2"
  L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L16(L17)
  L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L16 = tonumber
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "nat6_enabled"
  L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L17(L18)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L16 = L16 or L16
  L17 = L4.parseCmdline
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "ip6prefix"
  L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L18(L19)
  L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L18 = tonumber
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "ip6prefixlen"
  L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L19(L20)
  L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L18 = L18 or L18
  L19 = L4.parseCmdline
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "ipv6DialAccount"
  L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L20(L21)
  L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L20 = L4.parseCmdline
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "ipv6DialPassword"
  L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L21(L22)
  L20 = L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L21 = tonumber
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "use_pppoev4"
  L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L22(L23)
  L21 = L21(L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L21 = L21 or L21
  L22 = L4.parseCmdline
  L23 = _UPVALUE0_
  L23 = L23.formvalue
  L24 = "ip6addr"
  L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L23(L24)
  L22 = L22(L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L23 = L4.parseCmdline
  L24 = _UPVALUE0_
  L24 = L24.formvalue
  L25 = "ip6gw"
  L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L24(L25)
  L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L24 = L4.parseCmdline
  L25 = _UPVALUE0_
  L25 = L25.formvalue
  L26 = "peeraddr"
  L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L25(L26)
  L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L25 = L4.parseCmdline
  L26 = _UPVALUE0_
  L26 = L26.formvalue
  L27 = "tunnelid"
  L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L26(L27)
  L25 = L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L26 = tonumber
  L27 = _UPVALUE0_
  L27 = L27.formvalue
  L28 = "use_dhcp"
  L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L27(L28)
  L26 = L26(L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
  L26 = L26 or L26
  L27 = string
  L27 = L27.find
  L28 = L11
  L29 = "_"
  L27 = L27(L28, L29)
  if L27 then
    L28 = string
    L28 = L28.len
    L29 = "wan6"
    L28 = L28(L29)
    if L27 > L28 then
      L28 = tonumber
      L29 = string
      L29 = L29.sub
      L30 = L11
      L31 = L27 + 1
      L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L29(L30, L31)
      L28 = L28(L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
      L8 = L28
    end
  end
  if L8 and 0 < L8 then
    L28 = L10
    L29 = "_"
    L30 = L8
    L10 = L28 .. L29 .. L30
  end
  L28 = L3.get_wanDevCfg
  L29 = L10
  L30 = "Router"
  L31 = nil
  L32 = 4
  L28 = L28(L29, L30, L31, L32)
  L30 = L0
  L29 = L0.get
  L31 = "ipv6"
  L32 = L11
  L33 = "permession"
  L29 = L29(L30, L31, L32, L33)
  L29 = L29 or L29
  L31 = L0
  L30 = L0.get
  L32 = "ipv6"
  L33 = "globals"
  L34 = "enabled"
  L30 = L30(L31, L32, L33, L34)
  L30 = L30 or L30
  if L30 == "0" then
    L5 = 2609
  elseif L29 == "0" then
    L5 = 2608
  else
    L31 = L2.isStrNil
    L32 = L13
    L31 = L31(L32)
    if L31 then
      L5 = 1502
    else
      if L28 and L8 then
        L31 = L28.wanSection
        if L31 == L10 then
          goto lbl_213
        end
      end
      L5 = 1523
      goto lbl_435
      ::lbl_213::
      L31 = L3.chkWan6Mode
      L32 = L11
      L33 = L13
      L31 = L31(L32, L33)
      if L31 ~= 0 then
        L5 = 2606
      else
        L31 = {}
        L32 = L2.isStrNil
        L33 = L14
        L32 = L32(L33)
        if L32 then
          L32 = L2.isStrNil
          L33 = L15
          L32 = L32(L33)
          if L32 then
            L7.peerdns = 1
        end
        else
          L7.peerdns = 0
          L32 = L2.isStrNil
          L33 = L14
          L32 = L32(L33)
          if not L32 then
            L32 = L1.ip6addr
            L33 = L14
            L32 = L32(L33)
            if L32 then
              L32 = table
              L32 = L32.insert
              L33 = L31
              L34 = L14
              L32(L33, L34)
            end
          end
          L32 = L2.isStrNil
          L33 = L15
          L32 = L32(L33)
          if not L32 then
            L32 = L1.ip6addr
            L33 = L15
            L32 = L32(L33)
            if L32 then
              L32 = table
              L32 = L32.insert
              L33 = L31
              L34 = L15
              L32(L33, L34)
            end
          end
          L7.dnsList = L31
        end
        if L13 == "native" then
        elseif L13 == "dhcpv6" then
          L32 = L3.chkWan6CfgDHCPv6
          L33 = L16
          L34 = L17
          L35 = L18
          L32 = L32(L33, L34, L35)
          L5 = L32
          if L5 == 0 then
            if L16 ~= 0 then
              L7.nat6Enabled = 1
              L32 = L17
              L33 = "/"
              L34 = L18
              L32 = L32 .. L33 .. L34
              L7.ip6prefix = L32
            else
              L7.nat6Enabled = 0
            end
          end
        elseif L13 == "pppoev6" then
          L32 = L3.chkWan6CfgPPPoEv6
          L33 = L16
          L34 = L17
          L35 = L18
          L36 = L21
          L37 = L19
          L38 = L20
          L32 = L32(L33, L34, L35, L36, L37, L38)
          L5 = L32
          if L5 == 0 then
            if L16 ~= 0 then
              L7.nat6Enabled = 1
              L32 = L17
              L33 = "/"
              L34 = L18
              L32 = L32 .. L33 .. L34
              L7.ip6prefix = L32
            else
              L7.nat6Enabled = 0
            end
            if L21 == 0 then
              L7.username = L19
              L7.password = L20
              L7.usePPPoEv4 = 0
            else
              L7.usePPPoEv4 = 1
            end
          end
        elseif L13 == "static" then
          L32 = L3.chkWan6CfgStatic
          L33 = L22
          L34 = L23
          L35 = L17
          L36 = L18
          L32 = L32(L33, L34, L35, L36)
          L5 = L32
          if L5 == 0 then
            L7.ip6addr = L22
            L7.ip6gw = L23
            L32 = L17
            L33 = "/"
            L34 = L18
            L32 = L32 .. L33 .. L34
            L7.ip6prefix = L32
          end
        elseif L13 == "passthrough" then
        elseif L13 == "relay" then
        elseif L13 == "pi_relay" then
        elseif L13 == "6in4" then
          L32 = L3.chkWan6Cfg6in4
          L33 = L24
          L34 = L22
          L35 = L17
          L36 = L18
          L37 = L25
          L38 = L19
          L39 = L20
          L32 = L32(L33, L34, L35, L36, L37, L38, L39)
          L5 = L32
          if L5 == 0 then
            L7.peeraddr = L24
            L7.ip6addr = L22
            L32 = L17
            L33 = "/"
            L34 = L18
            L32 = L32 .. L33 .. L34
            L7.ip6prefix = L32
            L32 = L2.isStrNil
            L33 = L25
            L32 = L32(L33)
            if not L32 then
              L7.tunnelid = L25
              L7.username = L19
              L7.password = L20
            end
          end
        elseif L13 == "6to4" then
          L32 = L4.parseCmdline
          L33 = _UPVALUE0_
          L33 = L33.formvalue
          L34 = "peeraddr"
          L33 = L33(L34)
          L33 = L33 or L33
          L32 = L32(L33)
          L7.peeraddr = L32
          L32 = L3.chkWan6Cfg6to4
          L33 = L7.peeraddr
          L32 = L32(L33)
          L5 = L32
        elseif L13 == "6rd" then
          L32 = L3.chkWan6Cfg6rd
          L33 = L26
          L34 = L24
          L35 = L17
          L36 = L18
          L32 = L32(L33, L34, L35, L36)
          L5 = L32
          if L5 == 0 then
            if L26 == 0 then
              L7.useDHCP = 0
              L7.peeraddr = L24
              L7.ip6prefix = L17
              L7.ip6prefixlen = L18
            else
              L7.useDHCP = 1
            end
          end
        elseif L13 == "464xlat" then
          L32 = L3.chkWan6Cfg464xlat
          L33 = L17
          L34 = L18
          L32 = L32(L33, L34)
          L5 = L32
          if L5 == 0 then
            L32 = L17
            L33 = "/"
            L34 = L18
            L32 = L32 .. L33 .. L34
            L7.ip6prefix = L32
          end
        elseif L13 == "off" then
        else
          L5 = 2606
        end
      end
    end
  end
  ::lbl_435::
  if L5 == 0 then
    if L13 ~= "off" then
      L31 = tonumber
      L33 = L0
      L32 = L0.get
      L34 = "network"
      L35 = L10
      L36 = "mru"
      L32, L33, L34, L35, L36, L37, L38, L39 = L32(L33, L34, L35, L36)
      L31 = L31(L32, L33, L34, L35, L36, L37, L38, L39)
      L31 = L31 or L31
      if L31 < 1280 then
        L33 = L0
        L32 = L0.set
        L34 = "network"
        L35 = L10
        L36 = "mru"
        L37 = 1280
        L32(L33, L34, L35, L36, L37)
        L33 = L0
        L32 = L0.commit
        L34 = "network"
        L32(L33, L34)
        L32 = L2.forkExec
        L33 = "ubus call network reload"
        L32(L33)
      end
    end
    L7.autoMode = L12
    L7.wanIface = L10
    L7.wan6Iface = L11
    L7.wan6IfaceID = L8
    L31 = L28.wanIfname
    L31 = L31 or L31
    L7.wan6Ifame = L31
    L31 = L28.wantype
    L7.wantype = L31
    L31 = L3.setWan6Cfg
    L32 = L13
    L33 = L7
    L34 = true
    L35 = false
    L31(L32, L33, L34, L35)
    if L12 == 1 then
      L31 = L2.forkExec
      L32 = "/usr/sbin/ipv6.sh autocheck "
      L33 = L11
      L34 = " clear_result"
      L32 = L32 .. L33 .. L34
      L31(L32)
    end
  else
    L31 = _UPVALUE1_
    L31 = L31.getErrorMessage
    L32 = L5
    L31 = L31(L32)
    L6.msg = L31
  end
  L6.code = L5
  L31 = _UPVALUE0_
  L31 = L31.write_json
  L32 = L6
  L31(L32)
end
setWan6V2 = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = 0
  L1 = {}
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQLanWanUtil"
  L4 = L4(L5)
  L6 = L2
  L5 = L2.get
  L7 = "ipv6"
  L8 = "globals"
  L9 = "enabled"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  if L5 == "0" then
    L0 = 2609
  else
    L6 = L3.parseCmdline
    L7 = _UPVALUE0_
    L7 = L7.formvalue
    L8 = "wan6_name"
    L7 = L7(L8)
    L7 = L7 or L7
    L6 = L6(L7)
    L7 = L4.get_wanDevCfg
    L8 = L6
    L9 = "Router"
    L10 = nil
    L11 = 6
    L7 = L7(L8, L9, L10, L11)
    L8 = L4.getWan6Cfg
    L9 = L6
    L8 = L8(L9)
    if L8 then
      L1.wan6_cfg = L8
    end
  end
  if L0 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L0
    L6 = L6(L7)
    L1.msg = L6
  end
  L1.code = L0
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
getWan6V2 = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.getWan6Info
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.info = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
ipv6Status = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L3.isStrNil
  L5 = A0
  L4 = L4(L5)
  if L4 then
    A0 = "wan6"
  end
  L4 = 0
  L5 = {}
  L6 = L1.parseCmdline
  L7 = A0
  L6 = L6(L7)
  L7 = L2.getWan6InfoV2
  L8 = L6
  L7 = L7(L8)
  if L7 then
    L5.wan6_info = L7
  end
  if L4 ~= 0 then
    L8 = _UPVALUE0_
    L8 = L8.getErrorMessage
    L9 = L4
    L8 = L8(L9)
    L5.msg = L8
  end
  L5.code = L4
  return L5
end
wan6InfoV2Handle = L4
function L4()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "wan6_name"
  L2 = nil
  L3 = "?commonstr"
  L0 = L0(L1, L2, L3)
  L0 = L0 or L0
  L1 = wan6InfoV2Handle
  L2 = L0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWan6InfoV2 = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = 0
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "enabled"
  L5, L6 = L5(L6)
  L4 = L4(L5, L6)
  if not L4 then
    L0 = 1502
  elseif L4 ~= 0 and L4 ~= 1 then
    L0 = 1523
  end
  if L0 == 0 then
    L5 = L3.setWan6Switch
    L6 = L4
    L5(L6)
  else
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L0
    L5 = L5(L6)
    L1.msg = L5
  end
  L1.code = L0
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
setWan6SwitchV2 = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = 0
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = L2.getWan6Switch
  L3 = L3()
  L3 = L3 or L3
  L1.enabled = L3
  L1.code = L0
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getWan6SwitchV2 = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = 0
  L1 = {}
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "luci.cbi.datatypes"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQLanWanUtil"
  L4 = L4(L5)
  L6 = L2
  L5 = L2.get
  L7 = "ipv6"
  L8 = "globals"
  L9 = "enabled"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  if L5 == "0" then
    L0 = 2609
  else
    L6 = {}
    L7 = tonumber
    L8 = _UPVALUE0_
    L8 = L8.formvalue
    L9 = "mode"
    L8, L9, L10, L11 = L8(L9)
    L7 = L7(L8, L9, L10, L11)
    L7 = L7 or L7
    L8 = tonumber
    L9 = _UPVALUE0_
    L9 = L9.formvalue
    L10 = "ip6assign"
    L9, L10, L11 = L9(L10)
    L8 = L8(L9, L10, L11)
    L8 = L8 or L8
    if L7 < 0 or 3 < L7 then
      L0 = 2607
    else
      L9 = L3.ip6prefix
      L10 = L8
      L9 = L9(L10)
      if not L9 then
        L0 = 2604
      else
        L6.ip6assign = L8
        L9 = L4.setLan6Cfg
        L10 = L7
        L11 = L6
        L9(L10, L11)
      end
    end
  end
  if L0 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L0
    L6 = L6(L7)
    L1.msg = L6
  end
  L1.code = L0
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
setLan6V2 = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = 0
  L1 = {}
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L5 = L2
  L4 = L2.get
  L6 = "ipv6"
  L7 = "globals"
  L8 = "enabled"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  if L4 == "0" then
    L0 = 2609
  else
    L5 = L3.getLan6Cfg
    L5 = L5()
    if L5 then
      L1.lan6_cfg = L5
    end
  end
  if L0 ~= 0 then
    L5 = _UPVALUE0_
    L5 = L5.getErrorMessage
    L6 = L0
    L5 = L5(L6)
    L1.msg = L5
  end
  L1.code = L0
  L5 = _UPVALUE1_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
getLan6V2 = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mode"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = L0.setIpv6FirewallV2
  L4 = L2
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
setIpv6Firewall = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.getIpv6FirewallV2
  L1 = L1()
  L2 = {}
  L2.code = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getIpv6Firewall = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQIPMacBind"
  L3 = L3(L4)
  L4 = 0
  L5 = {}
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "start"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "end"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "startip"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "endip"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "leasetime"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "ignore"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "router"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "dns1"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "dns2"
  L14 = L14(L15)
  L15 = [[
 sleep 2;
                   /etc/init.d/network restart;
                   /sbin/phyhelper restart lan;
                   [ -f "/usr/sbin/port_service" ] && /usr/sbin/port_service restart;
                ]]
  L16 = tonumber
  L17 = L11
  L16 = L16(L17)
  if L16 == 1 then
    L16 = L0.setLanDHCPService
    L17, L18, L19, L20, L21 = nil, nil, nil, nil, nil
    L22 = L11
    L23, L24, L25 = nil, nil, nil
    L16(L17, L18, L19, L20, L21, L22, L23, L24, L25)
    L16 = L2.forkExec
    L17 = L15
    L16(L17)
    L16 = L3.flushIPMacBindingList
    L16()
  else
    L16 = nil
    L17 = unit
    if L10 then
      L18 = L10
      L17 = L10.match
      L19 = "^(%d+)(%S+)"
      L17, L18 = L17(L18, L19)
      unit = L18
      L16 = L17
    end
    L17 = tonumber
    L18 = L16
    L17 = L17(L18)
    L16 = L17
    if L16 ~= nil then
      L17 = unit
      if L17 ~= "h" then
        L17 = unit
        if L17 ~= "m" then
          goto lbl_107
        end
      end
      if L13 and L13 ~= "" then
        L17 = L1.ipaddr
        L18 = L13
        L17 = L17(L18)
        if not L17 then
          goto lbl_107
        end
      end
      if not L14 or L14 == "" then
        goto lbl_109
      end
      L17 = L1.ipaddr
      L18 = L14
      L17 = L17(L18)
      if L17 then
        goto lbl_109
      end
    end
    ::lbl_107::
    L4 = 1537
    goto lbl_189
    ::lbl_109::
    L17 = unit
    if L17 ~= "h" or not (L16 < 1) and not (48 < L16) then
      L17 = unit
      if not (L17 == "m" and (L16 < 2 or 2880 < L16)) then
        goto lbl_125
      end
    end
    L4 = 1536
    goto lbl_189
    ::lbl_125::
    if L12 and L12 ~= "" then
      L17 = L1.ipaddr
      L18 = L12
      L17 = L17(L18)
      if not L17 then
        L4 = 1532
    end
    elseif L8 and L9 then
      L17 = L0.checkDhcpIpPool
      L18 = 0
      L19 = L8
      L20 = L9
      L17 = L17(L18, L19, L20)
      L4 = L17
      if L4 == 0 then
        L17 = L0.setLanDHCPService
        L18, L19 = nil, nil
        L20 = L8
        L21 = L9
        L22 = L10
        L23 = L11
        L24 = L12
        L25 = L13
        L26 = L14
        L17(L18, L19, L20, L21, L22, L23, L24, L25, L26)
        L17 = L2.forkExec
        L18 = L15
        L17(L18)
      end
    elseif L6 and L7 then
      L17 = L0.checkDhcpIpPool
      L18 = 1
      L19 = L6
      L20 = L7
      L17 = L17(L18, L19, L20)
      L4 = L17
      if L4 == 0 then
        L17 = L0.setLanDHCPService
        L18 = L6
        L19 = L7
        L20, L21 = nil, nil
        L22 = L10
        L23 = L11
        L24 = L12
        L25 = L13
        L26 = L14
        L17(L18, L19, L20, L21, L22, L23, L24, L25, L26)
        L17 = L2.forkExec
        L18 = L15
        L17(L18)
      end
    else
      L4 = 1537
    end
  end
  ::lbl_189::
  L5.code = L4
  if L4 ~= 0 then
    L16 = _UPVALUE1_
    L16 = L16.getErrorMessage
    L17 = L4
    L16 = L16(L17)
    L5.msg = L16
    L16 = L3.reloadIPMacBindingList
    L16()
  end
  L16 = _UPVALUE0_
  L16 = L16.write_json
  L17 = L5
  L16(L17)
end
setLanDhcp = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQPortServiceUtil"
  L3 = L3(L4)
  L4 = 0
  L5 = {}
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "mac"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "wan_name"
  L7 = L7(L8)
  L7 = L7 or L7
  if L6 then
    L8 = L2.macaddr
    L9 = L6
    L8 = L8(L9)
    if L8 then
      L8 = string
      L8 = L8.lower
      L9 = L6
      L8 = L8(L9)
      L6 = L8
      L9 = L6
      L8 = L6.match
      L10 = "^%x[1,3,5,7,9,b,d,f]"
      L8 = L8(L9, L10)
      if L8 then
        L4 = 1637
      else
        L8 = L3.PS_WAN_SERVICE_NAME_MAP
        L8 = L8[L7]
        L7 = L8 or L7
        if not L8 then
          L7 = "wan"
        end
        L8 = L1.setWanMac
        L9 = L6
        L10 = L7
        L8 = L8(L9, L10)
        L9 = L0.check
        L10 = 0
        L11 = L0.KEY_FUNC_MACCLONE
        L12 = 1
        L9(L10, L11, L12)
        if not L8 then
          L4 = 1537
        end
      end
  end
  else
    L4 = 1523
  end
  L5.code = L4
  if L4 ~= 0 then
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L4
    L8 = L8(L9)
    L5.msg = L8
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L5
  L8(L9)
end
setWanMac = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQDeviceUtil"
  L2 = L2(L3)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "model"
  L4, L5, L6, L10, L11, L15, L16, L17, L18 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18)
  L4 = 0
  L5 = {}
  L6 = L1.getWiFiMacfilterInfo
  L6 = L6(L7)
  L10 = false
  wifiList = L7
  L10 = false
  flist = L7
  L5.enable = L7
  L5.model = L7
  if L7 then
    for L10, L11 in L7, L8, L9 do
      L11.added = 0
      for L15, L16 in L12, L13, L14 do
        L17 = L16.mac
        L18 = L11.mac
        if L17 == L18 then
          L11.added = 1
          break
        end
      end
    end
    for L10, L11 in L7, L8, L9 do
      if L12 then
        L11.added = 1
      else
        L11.added = 0
      end
    end
  end
  L5.code = 0
  L5.list = L7
  L5.macfilter = L7
  L5.weblist = L7
  L5.flist = L7
  L7(L8)
end
getWifiMacfilterInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQPushUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQController"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQSynchrodata"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "enable"
  L7, L8, L9, L10, L11 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11)
  if L6 == 1 then
    L6 = true
    if L6 then
      goto lbl_31
    end
  end
  L6 = false
  ::lbl_31::
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "model"
  L8, L9, L10, L11 = L8(L9)
  L7 = L7(L8, L9, L10, L11)
  L8 = L0.check
  L9 = 0
  L10 = L0.KEY_FUNC_WIRELESS_ACCESS
  if L6 then
    L11 = 0
    if L11 then
      goto lbl_46
    end
  end
  L11 = 1
  ::lbl_46::
  L8(L9, L10, L11)
  if L7 and L7 == 0 then
    L8 = L0.check
    L9 = 0
    L10 = L0.KEY_FUNC_WIRELESS_BLACK
    L11 = 1
    L8(L9, L10, L11)
  else
    L8 = L0.check
    L9 = 0
    L10 = L0.KEY_FUNC_WIRELESS_WHITE
    L11 = 1
    L8(L9, L10, L11)
  end
  L8 = L3.pushConfig
  L9 = "auth"
  if L6 then
    L10 = "1"
    if L10 then
      goto lbl_70
    end
  end
  L10 = "0"
  ::lbl_70::
  L8(L9, L10)
  L8 = L5.syncProtectionStatus
  if L6 then
    L9 = "1"
    if L9 then
      goto lbl_78
    end
  end
  L9 = "0"
  ::lbl_78::
  L10 = L7
  L8(L9, L10)
  L8 = L2.setWiFiMacfilterModel
  L9 = L6
  L10 = L7
  L8(L9, L10)
  L8 = L4.wifimacfilter
  L9 = nil
  L10 = L6
  L11 = L7
  L8(L9, L10, L11)
  L8 = L1.forkExec
  L9 = "/sbin/notice_tbus_device_maclist.sh"
  L8(L9)
  L8 = {}
  L8.code = 0
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L8
  L9(L10)
end
setWifiMacfilter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQController"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.cbi.datatypes"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.model.network"
  L6 = L6(L7)
  L6 = L6.init
  L6 = L6()
  L8 = L6
  L7 = L6.get_wifinet
  L9 = _wifiNameForIndex
  L10 = 1
  L9, L10, L11, L12, L13, L14, L18, L19, L20, L21, L22, L23, L24, L25 = L9(L10)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
  L9 = L7
  L8 = L7.get
  L10 = "macfilter"
  L8 = L8(L9, L10)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "mac"
  L11 = nil
  L12 = {}
  L12.name = "regex"
  L12.arg = "^[^`|$&]+$"
  L9 = L9(L10, L11, L12)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "erase"
  L11, L12, L13, L14, L18, L19, L20, L21, L22, L23, L24, L25 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25)
  L11 = 0
  L12 = 1
  L13 = 0
  L14 = {}
  if L8 and L8 == "allow" then
    L11 = 1
  end
  if L10 and L10 == 0 then
    L12 = 0
  end
  if L15 then
    L13 = 1523
  else
    L18 = ";"
    L18, L19, L20, L21, L22, L23, L24, L25 = L16(L17, L18)
    for L18, L19 in L15, L16, L17 do
      L20 = L3.isStrNil
      L21 = L19
      L20 = L20(L21)
      if not L20 then
        L20 = L5.macaddr
        L21 = L19
        L20 = L20(L21)
        if L20 then
          goto lbl_87
        end
      end
      L13 = 1523
      do break end
      goto lbl_99
      ::lbl_87::
      L20 = string
      L20 = L20.upper
      L21 = L19
      L20 = L20(L21)
      L19 = L20
      L21 = L19
      L20 = L19.match
      L22 = "^%x[1,3,5,7,9,B,D,F]"
      L20 = L20(L21, L22)
      if L20 then
        L13 = 1637
        break
      end
      ::lbl_99::
    end
    if 0 == L13 then
      L18 = L9
      L19 = ";"
      L18 = L12
      if L15 and L15 == 1 then
        L13 = 1591
      end
    end
  end
  L14.code = L13
  if L13 ~= 0 then
    L14.msg = L15
  else
    L18 = ";"
    L18, L19, L20, L21, L22, L23, L24, L25 = L16(L17, L18)
    for L18, L19 in L15, L16, L17 do
      L20 = os
      L20 = L20.execute
      L21 = string
      L21 = L21.format
      L22 = "milog.sh -m '{\"tag\":\"sec_nic_%slist\",\"mac\":\"%s\",\"enabled\":%s}'"
      if L11 == 1 then
        L23 = "white"
        if L23 then
          goto lbl_143
        end
      end
      L23 = "black"
      ::lbl_143::
      L24 = L19
      if L12 == 1 then
        L25 = "false"
        if L25 then
          goto lbl_150
        end
      end
      L25 = "true"
      ::lbl_150::
      L21, L22, L23, L24, L25 = L21(L22, L23, L24, L25)
      L20(L21, L22, L23, L24, L25)
    end
    L18 = "1"
    L16(L17, L18)
    L18 = L11
    L16(L17, L18)
    L16(L17)
  end
  L15(L16)
end
ignoreRiskDevice = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQController"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.cbi.datatypes"
  L5 = L5(L6)
  L6 = 0
  L7 = {}
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "mac"
  L10 = nil
  L11.name = "regex"
  L11.arg = "^[^`|$&]+$"
  L8 = L8(L9, L10, L11)
  L9 = tonumber
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L10, L14, L15, L16, L17, L18 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18)
  L10 = tonumber
  L14, L15, L16, L17, L18 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18)
  if L11 then
    L6 = 1523
  else
    L14 = ";"
    L14, L15, L16, L17, L18 = L12(L13, L14)
    for L14, L15 in L11, L12, L13 do
      L16 = L3.isStrNil
      L17 = L15
      L16 = L16(L17)
      if not L16 then
        L16 = L5.macaddr
        L17 = L15
        L16 = L16(L17)
        if L16 then
          goto lbl_68
        end
      end
      L6 = 1523
      do break end
      goto lbl_80
      ::lbl_68::
      L16 = string
      L16 = L16.upper
      L17 = L15
      L16 = L16(L17)
      L15 = L16
      L17 = L15
      L16 = L15.match
      L18 = "^%x[1,3,5,7,9,B,D,F]"
      L16 = L16(L17, L18)
      if L16 then
        L6 = 1637
        break
      end
      ::lbl_80::
    end
    if 0 == L6 then
      L14 = L8
      L15 = ";"
      L14 = L10
      if L11 and L11 == 1 then
        L6 = 1591
      end
    end
  end
  L7.code = L6
  if L6 ~= 0 then
    L7.msg = L11
  else
    L14 = "1"
    L12(L13, L14)
    L14 = L9
    L12(L13, L14)
    L12(L13)
  end
  L11(L12)
end
editDevice = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.cbi.datatypes"
  L4 = L4(L5)
  L5 = 0
  L6 = {}
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "mac"
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = L3.hackCharsCheck
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "name"
  L9, L10, L11, L12, L13 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13)
  L8 = L8 or L8
  L9 = tonumber
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "model"
  L10, L11, L12, L13 = L10(L11)
  L9 = L9(L10, L11, L12, L13)
  L10 = L2.isStrNil
  L11 = L7
  L10 = L10(L11)
  if not L10 then
    L10 = L4.macaddr
    L11 = L7
    L10 = L10(L11)
    if L10 then
      goto lbl_52
    end
  end
  L6.code = 1523
  goto lbl_80
  ::lbl_52::
  L10 = string
  L10 = L10.upper
  L11 = L7
  L10 = L10(L11)
  L7 = L10
  L11 = L7
  L10 = L7.match
  L12 = "^%x[1,3,5,7,9,B,D,F]"
  L10 = L10(L11, L12)
  if L10 then
    L5 = 1637
  else
    L10 = L1.addDevice
    L11 = L9
    L12 = L7
    L13 = L8
    L10 = L10(L11, L12, L13)
    if L10 and L10 == 1 then
      L5 = 1591
    elseif L10 and L10 == 3 then
      L5 = 1658
    end
  end
  ::lbl_80::
  L6.code = L5
  if L5 ~= 0 then
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L5
    L10 = L10(L11)
    L6.msg = L10
  else
    L10 = require
    L11 = "xiaoqiang.util.XQSynchrodata"
    L10 = L10(L11)
    L11 = L0.pushConfig
    L12 = "auth"
    L13 = "1"
    L11(L12, L13)
    L11 = L10.syncProtectionStatus
    L12 = "1"
    L13 = L9
    L11(L12, L13)
    L11 = L2.forkExec
    L12 = "/sbin/notice_tbus_device_maclist.sh"
    L11(L12)
  end
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L6
  L10(L11)
end
manuallyAdd = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.module.XQMacBind"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = 0
  L4 = 0
  L5 = {}
  L6 = L1.xssCheck
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "data"
  L7, L8 = L7(L8)
  L6 = L6(L7, L8)
  if L6 then
    L7 = L2.decode
    L8 = L6
    L7 = L7(L8)
    L6 = L7
    L7 = L0.addBinds
    L8 = L6
    L7 = L7(L8)
    L4 = L7
  else
    L3 = 1523
  end
  if L4 == 1 then
    L3 = 1593
  elseif L4 == 2 then
    L3 = 1592
  elseif L4 == 3 then
    L3 = 1613
  elseif L4 == 4 then
    L3 = 3100
  end
  L5.code = L3
  if L3 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L3
    L7 = L7(L8)
    L5.msg = L7
  else
    L7 = L0.reload
    L7()
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
macBind = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQMacBind"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enable"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  if L3 ~= nil then
    L4 = L0.setIPMACCheckEnable
    L5 = L3
    L4 = L4(L5)
    L2 = L4
  else
    L2 = 1523
  end
  L1.code = L2
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
setIPMACCheckEnable = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQMacBind"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getIPMACCheckEnable
  L2 = L2()
  L1.enable = L2
  L1.code = 0
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getIPMACCheckStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMacBind"
  L1 = L1(L2)
  L2 = 0
  L3 = {}
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mac"
  L6 = nil
  L7 = "string"
  L4 = L4(L5, L6, L7)
  L5 = nil
  if L4 then
    L6 = L0.split
    L7 = L4
    L8 = ";"
    L6 = L6(L7, L8)
    L7 = #L6
    if 1 < L7 then
      L7 = L1.removeBinds
      L8 = L6
      L7 = L7(L8)
      L5 = L7
    else
      L7 = L1.removeBind
      L8 = L4
      L7 = L7(L8)
      L5 = L7
    end
  end
  if not L5 then
    L2 = 1594
  end
  L3.code = L2
  if L2 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L2
    L6 = L6(L7)
    L3.msg = L6
  else
    L6 = L1.reload
    L6()
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L3
  L6(L7)
end
macUnbind = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMacBind"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L1.saveBindInfo
  L3()
  L3 = L1.reload
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
saveBind = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMacBind"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L1.unbindAll
  L3()
  L3 = L1.reload
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
unbindAll = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQMacBind"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = {}
  L5 = L2.macBindInfo
  L5 = L5()
  L6 = L1.getDeviceList
  L7 = true
  L8 = true
  L6 = L6(L7, L8)
  L6 = L6 or L6
  L7 = {}
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "mac"
  L8 = L8(L9)
  L9 = 0
  for L13, L14 in L10, L11, L12 do
    L15 = string
    L15 = L15.lower
    L16 = L14.mac
    L15 = L15(L16)
    L15 = L5[L15]
    if L15 then
      L16 = L15.tag
      L14.tag = L16
    else
      L14.tag = 0
    end
    L16 = L14.port
    if L16 then
      L16 = L14.port
      if L16 ~= 3 then
        L16 = L14.isap
        if L16 == 0 then
          L16 = table
          L16 = L16.insert
          L17 = L7
          L18 = L14
          L16(L17, L18)
        end
      end
    end
  end
  if L8 ~= nil then
    L9 = L10
    if L9 == true then
      L13 = string
      L13 = L13.upper
      L14 = L8
      L13 = L13(L14)
      L12.mac = L13
      L10(L11, L12)
    end
  else
    for L13, L14 in L10, L11, L12 do
      L15 = table
      L15 = L15.insert
      L16 = L4
      L17 = {}
      L18 = L14.name
      L17.name = L18
      L18 = string
      L18 = L18.upper
      L19 = L14.mac
      L18 = L18(L19)
      L17.mac = L18
      L18 = L14.ip
      L17.ip = L18
      L18 = L14.tag
      L17.tag = L18
      L18 = L14.instance
      L17.instance = L18
      L15(L16, L17)
    end
  end
  L3.list = L4
  if L8 == nil then
    L3.devicelist = L7
    L3.lanmask = L10
  end
  L10(L11)
end
getMacBindInfo = L4
function L4()
  local L0, L1, L2
  L0 = {}
  L1 = pppoeStatusHandle
  L1 = L1()
  L0.ipv4 = L1
  L1 = wan6InfoV2Handle
  L1 = L1()
  L0.ipv6 = L1
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getWanStatus = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQPortServiceUtil"
  L3 = L3(L4)
  L4 = L1.isStrNil
  L5 = A0
  L4 = L4(L5)
  if L4 then
    A0 = "WAN1"
  end
  L4 = L3.PS_WAN_SERVICE_NAME_MAP
  L4 = L4[A0]
  A0 = L4 or A0
  if not L4 then
    A0 = "wan"
  end
  L4 = 0
  L5 = L2.getPPPoEStatus
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L6 = L5.errtype
    if L6 == 1 then
      L4 = 1603
    else
      L6 = L5.errtype
      if L6 == 2 then
        L4 = 1604
      else
        L6 = L5.errtype
        if L6 == 3 then
          L4 = 1605
        end
      end
    end
  else
    L4 = 1602
  end
  if L4 ~= 0 then
    if L4 ~= 1602 then
      L6 = string
      L6 = L6.format
      L7 = "%s(%s)"
      L8 = _UPVALUE0_
      L8 = L8.getErrorMessage
      L9 = L4
      L8 = L8(L9)
      L9 = tostring
      L10 = L5.errcode
      L9, L10 = L9(L10)
      L6 = L6(L7, L8, L9, L10)
      L5.msg = L6
    else
      L6 = _UPVALUE0_
      L6 = L6.getErrorMessage
      L7 = L4
      L6 = L6(L7)
      L5.msg = L6
    end
  end
  L5.code = L4
  return L5
end
pppoeStatusHandle = L4
function L4()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "wan_name"
  L0 = L0(L1)
  L0 = L0 or L0
  L1 = pppoeStatusHandle
  L2 = L0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
pppoeStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wan_name"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = {}
  L3.code = 0
  L4 = L1.PS_WAN_SERVICE_NAME_MAP
  L4 = L4[L2]
  L2 = L4 or L2
  if not L4 then
    L2 = "wan"
  end
  L4 = L0.pppoeStop
  L5 = L2
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
pppoeStop = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wan_name"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = {}
  L3.code = 0
  L4 = L1.PS_WAN_SERVICE_NAME_MAP
  L4 = L4[L2]
  L2 = L4 or L2
  if not L4 then
    L2 = "wan"
  end
  L4 = L0.pppoeStart
  L5 = L2
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
pppoeStart = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.qosStatus
  L3 = L3()
  L2.status = L3
  L4 = L3.on
  if L4 == 1 then
    L4 = L0.qosBand
    L4 = L4()
    L2.band = L4
    L4 = L0.qosList
    L4 = L4()
    L2.list = L4
    L4 = L0.guestQoSInfo
    L4 = L4()
    L2.guest = L4
  else
    L4 = L0.qosBandinConf
    L4 = L4()
    L2.band = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getQosInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "on"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  if L3 == 1 then
    L3 = true
    if L3 then
      goto lbl_21
    end
  end
  L3 = false
  ::lbl_21::
  L4 = L0.check
  L5 = 0
  L6 = L0.KEY_FUNC_QOS
  if L3 then
    L7 = 0
    if L7 then
      goto lbl_30
    end
  end
  L7 = 1
  ::lbl_30::
  L4(L5, L6, L7)
  L4 = L1.qosSwitch
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L2.code = 1606
  end
  L5 = L2.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
qosSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L3 = L0.qosStatus
  L3 = L3()
  L4 = nil
  if L3 then
    L5 = L3.on
    if L5 == 1 then
      L5 = L0.setQoSMode
      L6 = L2
      L5 = L5(L6)
      L4 = L5
  end
  else
    L1.code = 1607
  end
  if not L4 then
    L5 = L1.code
    if L5 == 0 then
      L1.code = 1606
    end
  end
  L5 = L1.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L1.code
    L5 = L5(L6)
    L1.msg = L5
  else
    L5 = require
    L6 = "xiaoqiang.util.XQSynchrodata"
    L5 = L5(L6)
    L6 = L5.syncQosInfo
    L6()
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
qosMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "upload"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "download"
  L5, L6, L7, L8, L9, L10, L11, L12, L13 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "level"
  L6, L7, L8, L9, L10, L11, L12, L13 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
  L6 = nil
  L7 = L0.qosStatus
  L7 = L7()
  if L7 then
    L8 = L7.on
    if L8 == 1 then
      if L2 and L3 and L4 and L5 then
        L8 = L0.qosOnLimit
        L9 = L2
        L10 = L3 / 100
        L11 = L4 / 100
        L12 = L5
        L13 = L5
        L8 = L8(L9, L10, L11, L12, L13)
        L6 = L8
      else
        L1.code = 1523
      end
  end
  else
    L1.code = 1607
  end
  if not L6 then
    L8 = L1.code
    if L8 == 0 then
      L1.code = 1606
    end
  end
  L8 = L1.code
  if L8 ~= 0 then
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L1.code
    L8 = L8(L9)
    L1.msg = L8
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L1
  L8(L9)
end
qosLimit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = L0.qosStatus
  L3 = L3()
  L4 = nil
  if L3 then
    L5 = L3.on
    if L5 == 1 then
      L5 = L0.qosOffLimit
      L6 = L2
      L5 = L5(L6)
      L4 = L5
  end
  else
    L1.code = 1607
  end
  if not L4 then
    L5 = L1.code
    if L5 == 0 then
      L1.code = 1606
    end
  end
  L5 = L1.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L1.code
    L5 = L5(L6)
    L1.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
qosOffLimit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "upload"
  L3, L4, L5, L6, L7, L8 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "download"
  L4, L5, L6, L7, L8 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = nil
  L5 = L0.qosStatus
  L5 = L5()
  if L2 and L3 then
    L6 = L0.setQosBand
    L7 = L2
    L8 = L3
    L6 = L6(L7, L8)
    L4 = L6
    if not L4 then
      L6 = L0.setQosBandinConf
      L7 = L2
      L8 = L3
      L6 = L6(L7, L8)
      L4 = L6
    end
  else
    L1.code = 1523
  end
  if not L4 then
    L6 = L1.code
    if L6 == 0 then
      L1.code = 1606
    end
  end
  L6 = L1.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L1.code
    L6 = L6(L7)
    L1.msg = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
setBand = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQDDNS"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.get
  L4 = "DDNS_FLAG"
  L3 = L3(L4)
  if L3 then
    L2.flag = 0
  else
    L2.flag = 1
    L4 = L0.set
    L5 = "DDNS_FLAG"
    L6 = "1"
    L4(L5, L6)
  end
  L4 = L1.ddnsInfo
  L4 = L4()
  L5 = L4.on
  L2.on = L5
  L5 = L4.list
  L2.list = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
ddnsStatus = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "on"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  if L2 == 1 then
    L2 = true
    if L2 then
      goto lbl_18
    end
  end
  L2 = false
  ::lbl_18::
  L3 = L0.ddnsSwitch
  L4 = L2
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
ddnsSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enable"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_24
    end
  end
  L3 = 0
  ::lbl_24::
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "domain"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "username"
  L5 = L5(L6)
  L5 = L5 or L5
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "password"
  L6 = L6(L7)
  L6 = L6 or L6
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "checkinterval"
  L8, L9, L10, L11, L12, L13, L14, L15, L16 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "forceinterval"
  L9, L10, L11, L12, L13, L14, L15, L16 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16)
  if not (L2 and L7) or not L8 then
    L1.code = 1612
  elseif L7 <= 0 or L8 <= 0 then
    L1.code = 1523
  else
    L9 = L0.setDdns
    L10 = L2
    L11 = L3
    L12 = L5
    L13 = L6
    L14 = L7
    L15 = L8
    L16 = L4
    L9 = L9(L10, L11, L12, L13, L14, L15, L16)
    if not L9 then
      L1.code = 1606
    end
  end
  L9 = L1.code
  if L9 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L1.code
    L9 = L9(L10)
    L1.msg = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L1
  L9(L10)
end
addServer = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  if not L2 then
    L1.code = 1612
  else
    L3 = L0.deleteDdns
    L4 = L2
    L3 = L3(L4)
    if not L3 then
      L1.code = 1606
    end
  end
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L1.code
    L3 = L3(L4)
    L1.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
deleteServer = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "on"
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  if L3 == 1 then
    L3 = true
    if L3 then
      goto lbl_24
    end
  end
  L3 = false
  ::lbl_24::
  if not L2 then
    L1.code = 1612
  else
    L4 = L0.ddnsServerSwitch
    L5 = L2
    L6 = L3
    L4 = L4(L5, L6)
    if not L4 then
      L1.code = 1606
    end
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
serverSwitch = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.reload
  L2 = L2()
  if not L2 then
    L1.code = 1606
  end
  L2 = L1.code
  if L2 ~= 0 then
    L2 = _UPVALUE0_
    L2 = L2.getErrorMessage
    L3 = L1.code
    L2 = L2(L3)
    L1.msg = L2
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
ddnsReload = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3, L4, L5 = L3(L4)
  L2 = L2(L3, L4, L5)
  L3 = L0.getDdns
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L1 = L3
    L1.code = 0
  else
    L1.code = 1614
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
getServer = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.module.XQDDNS"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enable"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_24
    end
  end
  L3 = 0
  ::lbl_24::
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "domain"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "username"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "password"
  L6 = L6(L7)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "checkinterval"
  L8, L9, L10, L11, L12, L13, L14, L15, L16 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "forceinterval"
  L9, L10, L11, L12, L13, L14, L15, L16 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16)
  L9 = L0.editDdns
  L10 = L2
  L11 = L3
  L12 = L5
  L13 = L6
  L14 = L7
  L15 = L8
  L16 = L4
  L9 = L9(L10, L11, L12, L13, L14, L15, L16)
  if not L9 then
    L1.code = 1606
  end
  L10 = L1.code
  if L10 ~= 0 then
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L1.code
    L10 = L10(L11)
    L1.msg = L10
  end
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L1
  L10(L11)
end
ddnsEdit = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.getWanSpeed
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.speed = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getWanSpeed = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wan_name"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "speed"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  L4 = {}
  L4.code = 0
  L5 = L1.PS_WAN_SERVICE_NAME_MAP
  L5 = L5[L2]
  L2 = L5 or L2
  if not L5 then
    L2 = "wan"
  end
  L5 = L0.setWanSpeed
  L6 = L3
  L7 = L2
  L5 = L5(L6, L7)
  if not L5 then
    L4.code = 1523
  end
  L6 = L4.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L4.code
    L6 = L6(L7)
    L4.msg = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L4
  L6(L7)
end
setWanSpeed = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = L0.get
  L4 = "SFP_SPEED"
  L5 = 0
  L3, L4, L5 = L3(L4, L5)
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  L1.mode = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
GetSFPSpeed = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L4.wait = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "sfp_mode"
  L7 = nil
  L8 = "numberstr"
  L5 = L5(L6, L7, L8)
  L6 = L0.log
  L7 = 5
  L8 = "SetSFPSpeed"
  L6(L7, L8)
  L7 = L2
  L6 = L2.get
  L8 = "misc"
  L9 = "sw_reg"
  L10 = "sfp_port"
  L6 = L6(L7, L8, L9, L10)
  L7 = L0.log
  L8 = 5
  L9 = "sfp_port: "
  L10 = tostring
  L11 = L6
  L10 = L10(L11)
  L11 = " mode: "
  L12 = tostring
  L13 = L5
  L12 = L12(L13)
  L9 = L9 .. L10 .. L11 .. L12
  L7(L8, L9)
  if L5 and L6 then
    L7 = L1.set
    L8 = "SFP_SPEED"
    L9 = L5
    L7(L8, L9)
    L7 = L3.forkExec
    L8 = "/sbin/phyhelper mode set "
    L9 = tostring
    L10 = L6
    L9 = L9(L10)
    L10 = " "
    L11 = tostring
    L12 = L5
    L11 = L11(L12)
    L12 = " &"
    L8 = L8 .. L9 .. L10 .. L11 .. L12
    L7(L8)
  else
    L4.code = 1537
  end
  L7 = L4.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L4.code
    L7 = L7(L8)
    L4.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L4
  L7(L8)
end
SetSFPSpeed = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mode"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "flg"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = {}
  L3.code = 0
  L4 = L0.setWanLanSwap
  L5 = L1
  L6 = L2
  L4 = L4(L5, L6)
  if not L4 then
    L3.code = 1523
  end
  L5 = L3.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L3.code
    L5 = L5(L6)
    L3.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
setWanLanSwap = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mode"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.getWanPortStatus
  L4 = L1
  L3 = L3(L4)
  if L3 == 0 then
    L2.code = 99
  elseif L3 == 1 then
    L2.code = 0
  elseif L3 == 2 then
    L2.code = 1
  else
    L2.code = 1523
  end
  L4 = L2.code
  if L4 == 1523 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2.code
    L4 = L4(L5)
    L2.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getWanPortStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = {}
  L6 = 0
  if L3 then
    L7 = L0.getWanLanType
    L8 = L3
    L7 = L7(L8)
    if L7 == false then
      L6 = 1524
    elseif L3 == "2.5G" then
      L5["2GwanType"] = L7
      L9 = L4
      L8 = L4.get
      L10 = "network"
      L11 = "wan"
      L12 = "username"
      L8 = L8(L9, L10, L11, L12)
      L5["2GpppoeName"] = L8
      L9 = L4
      L8 = L4.get
      L10 = "network"
      L11 = "wan"
      L12 = "password"
      L8 = L8(L9, L10, L11, L12)
      L5["2GpppoePassword"] = L8
    else
      L5["1GwanType"] = L7
      L9 = L4
      L8 = L4.get
      L10 = "network"
      L11 = "wan"
      L12 = "username"
      L8 = L8(L9, L10, L11, L12)
      L5["1GpppoeName"] = L8
      L9 = L4
      L8 = L4.get
      L10 = "network"
      L11 = "wan"
      L12 = "password"
      L8 = L8(L9, L10, L11, L12)
      L5["1GpppoePassword"] = L8
    end
  end
  if L6 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L6
    L7 = L7(L8)
    L5.msg = L7
  end
  L5.code = L6
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
getWanLanPort = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getWanLanMode
  L2 = L2()
  L1.mode = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWanLanMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mode"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.setWanLanPort
  L4 = L1
  L3 = L3(L4)
  if not L3 then
    L2.code = 1523
  end
  L4 = L2.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2.code
    L4 = L4(L5)
    L2.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setWanLanPort = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.service = ""
  L1.name = ""
  L1.passwd = ""
  L2 = L0.pppoeCatch
  L3 = 50
  L2 = L2(L3)
  L3 = L2.code
  if L3 == 0 then
    L3 = L2.service
    L1.service = L3
    L3 = L2.pppoename
    L1.name = L3
    L3 = L2.pppoepasswd
    L1.passwd = L3
  else
    L1.code = 1621
  end
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE0_
    L3 = L3.getErrorMessage
    L4 = L1.code
    L3 = L3(L4)
    L1.msg = L3
  end
  L3 = _UPVALUE1_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
pppoeCatch = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L2.ssid = ""
  L2.band = ""
  L3 = L0.apcli_get_scanlist
  L4 = L2
  L3 = L3(L4)
  L1.list = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getScanList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAPModule"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L0.apcli_get_active
  L4 = L4()
  L5 = {}
  L5.code = 0
  L6 = L1.check
  L7 = 0
  L8 = L1.KEY_FUNC_WIFI_RELAY
  L9 = 1
  L6(L7, L8, L9)
  L6 = L2.disableWifiAPMode
  L7 = L4
  L6, L7 = L6(L7)
  L5.ssid = L7
  L5.lanip = L6
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L5
  L8(L9)
end
disableap = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = nil
  L5 = {}
  L5.code = 0
  L5.mode = 0
  L6 = L0.getNetMode
  L6 = L6()
  L7 = L3.getLanGwaddr
  L7 = L7()
  L8 = L1.get
  L9 = "ap_hostname"
  L10 = ""
  L8 = L8(L9, L10)
  if L6 == "lanapmode" then
    L5.mode = 2
    L5.hostip = L7
    L5.hostname = L8
  elseif L6 == "wifiapmode" then
    L5.mode = 1
    L5.hostip = L7
    L5.hostname = L8
    L9 = L2.apcli_get_active
    L9 = L9()
    L4 = L9
    L9 = L2.apcli_get_wifinet
    L10 = L4
    L9 = L9(L10)
    if L9 then
      L11 = L9
      L10 = L9.ssid
      L10 = L10(L11)
      L5.ssid = L10
    else
      L5.mode = 0
    end
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L5
  L9(L10)
end
getMode = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "wan_sec"
  L1 = L1(L2)
  L1 = L1 or L1
  L2 = {}
  L2.code = 0
  L2.link = 0
  L3 = L0.getWanLink
  L4 = L1
  L3 = L3(L4)
  if L3 then
    L2.link = 1
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getWanLinkStatus = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = 0
  L5 = luci
  L5 = L5.dispatcher
  L5 = L5.getremotemac
  L5 = L5()
  L6 = L3.checkNonce
  L7 = A0
  L8 = L5
  L6 = L6(L7, L8)
  if L6 then
    L7 = L3.checkUser
    L8 = "admin"
    L9 = A0
    L10 = A1
    L7 = L7(L8, L9, L10)
    if L7 then
      L8 = L3.saveCiphertextPwd
      L9 = "admin"
      L10 = A2
      L8 = L8(L9, L10)
      if L8 then
        L4 = 0
      else
        L4 = 1553
      end
    else
      L4 = 1552
    end
  else
    L4 = 1582
  end
  return L4
end
_savePassword = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAPModule"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQPortServiceUtil"
  L5 = L5(L6)
  L6 = {}
  L6.code = 0
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "ssid"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "password"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "nssid"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "nencryption"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "npassword"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "nssid5G"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "nssid5G2"
  L13 = L13(L14)
  L14 = tonumber
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "initialize"
  L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34 = L15(L16)
  L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34)
  if L14 == 1 then
    L14 = 1
    if L14 then
      goto lbl_61
    end
  end
  L14 = 0
  ::lbl_61::
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "nonce"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "band"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "newPwd"
  L17 = L17(L18)
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "oldPwd"
  L18 = L18(L19)
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "channel"
  L19 = L19(L20)
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "enctype"
  L20 = L20(L21)
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "encryption"
  L21 = L21(L22)
  L22 = nil
  L23 = L0.check
  L24 = 0
  L25 = L0.KEY_FUNC_WIFI_RELAY
  L26 = 1
  L23(L24, L25, L26)
  L23 = L5.psMultiwanEnable
  L23 = L23()
  if 1 == L23 then
    L6.code = 3000
  elseif not L7 then
    L6.code = 1523
  end
  L23 = L6.code
  if 0 == L23 then
    L23 = L2.setWifiAPMode
    L24 = L7
    L25 = L8
    L26 = L20
    L27 = L21
    L28 = L16
    L29 = L19
    L30 = bandwidth
    L31 = L9
    L32 = L10
    L33 = L11
    L34 = L12
    L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34)
    L22 = L23
    L23 = L22.scan
    if not L23 then
      L6.code = 1617
    else
      L23 = L22.connected
      if L23 then
        L23 = L1.isStrNil
        L24 = L22.ip
        L23 = L23(L24)
        if L23 then
          L6.code = 1615
        else
          L23 = L22.ip
          L6.ip = L23
          L23 = L4.getWifissid
          L23, L24, L25 = L23()
          L6.ssid5G2 = L25
          L6.ssid5G = L24
          L6.ssid = L23
        end
      else
        L6.code = 1616
        L23 = _UPVALUE1_
        L23 = L23.getErrorMessage
        L24 = L6.code
        L23 = L23(L24)
        L24 = "("
        L25 = tostring
        L26 = L22.conerrmsg
        L25 = L25(L26)
        L26 = ")"
        L23 = L23 .. L24 .. L25 .. L26
        L6.msg = L23
      end
    end
  end
  L23 = L6.code
  if L23 ~= 0 then
    L23 = L6.code
    if L23 ~= 1616 then
      L23 = _UPVALUE1_
      L23 = L23.getErrorMessage
      L24 = L6.code
      L23 = L23(L24)
      L6.msg = L23
  end
  else
    L23 = L6.code
    if L23 == 0 then
      if L14 == 1 then
        L23 = L1.isStrNil
        L24 = L22.ssid
        L23 = L23(L24)
        if not L23 then
          L23 = L3.setRouterName
          L24 = L22.ssid
          L23(L24)
          if L15 and L17 and L18 then
            L23 = _savePassword
            L24 = L15
            L25 = L18
            L26 = L17
            L23 = L23(L24, L25, L26)
            L6.code = L23
          end
        end
      end
      L23 = L3.setInited
      L23()
      L23 = L2.actionForEnableWifiAP
      L23()
    end
  end
  L23 = _UPVALUE0_
  L23 = L23.write_json
  L24 = L6
  L23(L24)
end
setWifiApMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAPModule"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.json"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ssid"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "password"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "nssid"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "nencryption"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "npassword"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "nssid5G"
  L11 = L11(L12)
  L12 = tonumber
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "initialize"
  L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L13(L14)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  if L12 == 1 then
    L12 = 1
    if L12 then
      goto lbl_55
    end
  end
  L12 = 0
  ::lbl_55::
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "nonce"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "band"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "newPwd"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "oldPwd"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "channel"
  L17 = L17(L18)
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "enctype"
  L18 = L18(L19)
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "encryption"
  L19 = L19(L20)
  L20 = nil
  L21 = L0.check
  L22 = 0
  L23 = L0.KEY_FUNC_WIFI_RELAY
  L24 = 1
  L21(L22, L23, L24)
  L21 = {}
  L21.code = 0
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "band"
  L22 = L22(L23)
  L21.band = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "nonce"
  L22 = L22(L23)
  L21.nonce = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "newPwd"
  L22 = L22(L23)
  L21.newPwd = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "oldPwd"
  L22 = L22(L23)
  L21.oldPwd = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "nssid"
  L22 = L22(L23)
  L21.nssid = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "nencryption"
  L22 = L22(L23)
  L21.nencryption = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "npassword"
  L22 = L22(L23)
  L21.npassword = L22
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "nssid5G"
  L22 = L22(L23)
  L21.nssid5G = L22
  if L6 then
    L22 = L2.appSetWifiAPMode
    L23 = L6
    L24 = L7
    L25 = L18
    L26 = L19
    L27 = L14
    L28 = L17
    L29 = bandwidth
    L30 = L8
    L31 = L9
    L32 = L10
    L33 = L11
    L22 = L22(L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
    L20 = L22
    L22 = L20.scan
    if not L22 then
      L21.code = 1617
    else
      L22 = L20.connected
      if L22 then
        L22 = L20.ifname
        L21.ifname = L22
        L22 = L20.ssid
        L21.ssid = L22
        L22 = L20.password
        L21.password = L22
        L22 = L20.enctype
        L21.enctype = L22
        L22 = L20.encryption
        L21.encryption = L22
        L22 = L20.conerrmsg
        L21.conerrmsg = L22
        L22 = L20.oldlan
        L21.oldlan = L22
      else
        L21.code = 1616
        L22 = _UPVALUE1_
        L22 = L22.getErrorMessage
        L23 = L21.code
        L22 = L22(L23)
        L23 = "("
        L24 = tostring
        L25 = L20.ssid
        L24 = L24(L25)
        L25 = ")"
        L22 = L22 .. L23 .. L24 .. L25
        L21.msg = L22
      end
    end
  else
    L21.code = 1523
  end
  L22 = L21.code
  if L22 ~= 0 then
    L22 = L21.code
    if L22 ~= 1616 then
      L22 = _UPVALUE1_
      L22 = L22.getErrorMessage
      L23 = L21.code
      L22 = L22(L23)
      L21.msg = L22
    end
  end
  L22 = io
  L22 = L22.popen
  L23 = "cat /proc/uptime | awk '{print $1}'"
  L22 = L22(L23)
  L23 = string
  L23 = L23.trim
  L25 = L22
  L24 = L22.read
  L26 = "*all"
  L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L24(L25, L26)
  L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L21.uptime = L23
  L23 = assert
  L24 = io
  L24 = L24.open
  L25 = "/tmp/luci_set_wifi_ap_mode_result"
  L26 = "w"
  L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L24(L25, L26)
  L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L24 = L5.encode
  L25 = L21
  L24 = L24(L25)
  L26 = L23
  L25 = L23.write
  L27 = L24
  L25(L26, L27)
  L26 = L23
  L25 = L23.close
  L25(L26)
  L25 = L21.code
  if L25 == 0 then
    L25 = tonumber
    L26 = os
    L26 = L26.execute
    L27 = "sleep 2;dhcp_apclient.sh start "
    L28 = L21.ifname
    L27 = L27 .. L28
    L26, L27, L28, L29, L30, L31, L32, L33 = L26(L27)
    L25 = L25(L26, L27, L28, L29, L30, L31, L32, L33)
    L26 = L0.log
    L27 = 6
    L28 = "dhcpcode:"
    L29 = L25
    L26(L27, L28, L29)
    if L25 ~= 0 then
      L26 = tonumber
      L27 = os
      L27 = L27.execute
      L28 = "sleep 2;dhcp_apclient.sh start br-lan"
      L27, L28, L29, L30, L31, L32, L33 = L27(L28)
      L26 = L26(L27, L28, L29, L30, L31, L32, L33)
      L25 = L26
    end
  end
  L25 = _UPVALUE0_
  L25 = L25.write_json
  L26 = L21
  L25(L26)
end
appSetWifiApMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAPModule"
  L2 = L2(L3)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "initialize"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_22
    end
  end
  L3 = 0
  ::lbl_22::
  L4 = require
  L5 = "luci.json"
  L4 = L4(L5)
  L5 = {}
  L5.code = ""
  L6 = io
  L6 = L6.open
  L7 = "/tmp/luci_set_wifi_ap_mode_result"
  L8 = "r"
  L6 = L6(L7, L8)
  if L6 == nil then
    L5.code = 2
  else
    L8 = L6
    L7 = L6.read
    L9 = "*a"
    L7 = L7(L8, L9)
    L8 = L4.decode
    L9 = L7
    L8 = L8(L9)
    L10 = L6
    L9 = L6.close
    L9(L10)
    L9 = io
    L9 = L9.popen
    L10 = "cat /proc/uptime | awk '{print $1}'"
    L9 = L9(L10)
    L10 = string
    L10 = L10.trim
    L12 = L9
    L11 = L9.read
    L13 = "*all"
    L11, L12, L13, L14, L15, L16, L17 = L11(L12, L13)
    L10 = L10(L11, L12, L13, L14, L15, L16, L17)
    L11 = L8.uptime
    L11 = L10 - L11
    if 300 < L11 then
      L5.code = 3
    end
    L11 = L8.code
    if L11 then
      L11 = L8.code
      if L11 == 0 then
        L5.code = 0
        L11 = L5.nonce
        L12 = L5.newPwd
        L13 = L5.oldPwd
        if L3 == 1 then
          L14 = XQFunction
          L14 = L14.isStrNil
          L15 = L5.ssid
          L14 = L14(L15)
          if not L14 then
            L14 = L1.setRouterName
            L15 = L5.ssid
            L14(L15)
            if L11 and L12 and L13 then
              L14 = _savePassword
              L15 = L11
              L16 = L13
              L17 = L12
              L14 = L14(L15, L16, L17)
              L5.code = L14
            end
          end
        end
        L14 = L2.setWifiAPModeConfig
        L14()
        L14 = L1.setInited
        L14()
        L14 = L2.actionForEnableWifiAP
        L14()
      end
    end
    L11 = L8.msg
    L5.msg = L11
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
wifiAPserviceRestart = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.json"
  L0 = L0(L1)
  L1 = {}
  L1.code = ""
  L2 = io
  L2 = L2.open
  L3 = "/tmp/luci_set_wifi_ap_mode_result"
  L4 = "r"
  L2 = L2(L3, L4)
  if L2 == nil then
    L1.code = 2
  else
    L4 = L2
    L3 = L2.read
    L5 = "*a"
    L3 = L3(L4, L5)
    L4 = L0.decode
    L5 = L3
    L4 = L4(L5)
    L6 = L2
    L5 = L2.close
    L5(L6)
    L5 = L4.ipaddr
    if L5 then
      L5 = L4.code
      if L5 == 0 then
        L1.code = 0
    end
    else
      L1.code = 1
    end
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getModeStatus = L4
function L4()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = L1.get_active_apcli
  L2 = L2()
  L0.apcli = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
getActiveApcli = L4
function L4(A0)
  local L1, L2, L3, L4
  if A0 == nil then
    return
  else
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      L1 = require
      L2 = "luci.json"
      L1 = L1(L2)
      L2 = "echo \""
      L3 = L1.decode
      L4 = A0
      L3 = L3(L4)
      L4 = "\" > /tmp/luci_set_auto_wifi_ap_mode_result"
      L2 = L2 .. L3 .. L4
      L3 = os
      L3 = L3.execute
      L4 = L2
      L3(L4)
    else
      L1 = type
      L2 = A0
      L1 = L1(L2)
      if L1 ~= "number" then
        L1 = type
        L2 = A0
        L1 = L1(L2)
        if L1 ~= "boolean" then
          goto lbl_36
        end
      end
      do return end
      goto lbl_37
      ::lbl_36::
      return
    end
  end
  ::lbl_37::
end
write_json_tmpfile = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQAPModule"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQWifiUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.module.XQAPModule"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.module.XQExtendWifi"
  L7 = L7(L8)
  L8 = require
  L9 = "luci.model.uci"
  L8 = L8(L9)
  L8 = L8.cursor
  L8 = L8()
  L9 = {}
  L9.code = 0
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "ssid"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "password"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "band"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "channel"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "enctype"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "encryption"
  L15 = L15(L16)
  L16, L17, L18 = nil, nil, nil
  L19 = L1.log
  L20 = 1
  L21 = "ssid:"
  L22 = L10
  L23 = " password:"
  L24 = L11
  L25 = "band:"
  L26 = L12
  L27 = "channel:"
  L28 = L13
  L29 = "enctype:"
  L30 = L14
  L31 = "enctyption"
  L32 = L15
  L21 = L21 .. L22 .. L23 .. L24 .. L25 .. L26 .. L27 .. L28 .. L29 .. L30 .. L31 .. L32
  L19(L20, L21)
  L19 = L5.getAllWifiInfo
  L19 = L19()
  L20 = L19[1]
  if L20 then
    L20 = L19[1]
    L20 = L20.status
    if L20 == "1" then
      L20 = L19[1]
      L20 = L20.ssid
      self_ssid = L20
      L20 = L19[1]
      L17 = L20.password
      if L17 == nil then
        L17 = ""
      end
      L18 = "2g"
  end
  else
    L20 = L19[2]
    if L20 then
      L20 = wifinfo
      L20 = L20[2]
      L20 = L20.status
      if L20 == "1" then
        L20 = L19[2]
        L20 = L20.ssid
        self_ssid = L20
        L20 = L19[2]
        L17 = L20.password
        L18 = "5g"
        L20 = L1.log
        L21 = 1
        L22 = "ssid:"
        L23 = self_ssid
        L24 = " password: "
        L25 = L17
        L26 = " admin_password: "
        L27 = admin_password
        L28 = " band"
        L29 = L18
        L22 = L22 .. L23 .. L24 .. L25 .. L26 .. L27 .. L28 .. L29
        L20(L21, L22)
    end
    else
      L9.code = 1646
      L20 = _UPVALUE1_
      L20 = L20.getErrorMessage
      L21 = L9.code
      L20 = L20(L21)
      L9.msg = L20
      L20 = L1.log
      L21 = "get self wifi info error"
      L20(L21)
      L20 = _UPVALUE0_
      L20 = L20.write_json
      L21 = L9
      L20(L21)
      return
    end
  end
  L21 = L8
  L20 = L8.get
  L22 = "account"
  L23 = "common"
  L24 = "admin"
  L20 = L20(L21, L22, L23, L24)
  L21 = L6.extendwifi_set_connect
  L22 = L10
  L23 = L11
  L24 = L14
  L25 = L15
  L26 = L12
  L27 = L13
  L21 = L21(L22, L23, L24, L25, L26, L27)
  L22 = L21.ip
  if L22 ~= "" then
    L9.code = 0
    L9.msg = "connect succces!"
  else
    L22 = L21.connected
    if L22 then
      L22 = L21.dhcpcode
      if L22 == 100 then
        L9.code = 1646
        L22 = _UPVALUE1_
        L22 = L22.getErrorMessage
        L23 = L9.code
        L22 = L22(L23)
        L9.msg = L22
      else
        L22 = L21.dhcpcode
        if L22 == 2 then
          L9.code = 1647
          L22 = _UPVALUE1_
          L22 = L22.getErrorMessage
          L23 = L9.code
          L22 = L22(L23)
          L9.msg = L22
        else
          L22 = L21.dhcpcode
          if L22 == 102 then
            L9.code = 1648
            L22 = _UPVALUE1_
            L22 = L22.getErrorMessage
            L23 = L9.code
            L22 = L22(L23)
            L9.msg = L22
          else
            L22 = L21.dhcpcode
            if L22 ~= 105 then
              L22 = L21.dhcpcode
              if L22 ~= 106 then
                goto lbl_198
              end
            end
            L9.code = 1649
            L22 = _UPVALUE1_
            L22 = L22.getErrorMessage
            L23 = L9.code
            L22 = L22(L23)
            L9.msg = L22
            goto lbl_236
            ::lbl_198::
            L22 = L21.dhcpcode
            if L22 == 107 then
              L9.code = 1650
              L22 = _UPVALUE1_
              L22 = L22.getErrorMessage
              L23 = L9.code
              L22 = L22(L23)
              L9.msg = L22
            else
              L22 = L21.dhcpcode
              if L22 ~= 110 then
                L22 = L21.dhcpcode
                if L22 ~= 111 then
                  goto lbl_221
                end
              end
              L9.code = 1651
              L22 = _UPVALUE1_
              L22 = L22.getErrorMessage
              L23 = L9.code
              L22 = L22(L23)
              L9.msg = L22
              goto lbl_236
              ::lbl_221::
              L22 = L21.dhcpcode
              if L22 ~= 115 then
                L22 = L21.dhcpcode
                if L22 ~= 116 then
                  goto lbl_234
                end
              end
              L9.code = 1652
              L22 = _UPVALUE1_
              L22 = L22.getErrorMessage
              L23 = L9.code
              L22 = L22(L23)
              L9.msg = L22
              goto lbl_236
              ::lbl_234::
              L9.code = 1619
              L9.msg = "dhcp failed!"
            end
          end
        end
      end
      ::lbl_236::
      L22 = _UPVALUE0_
      L22 = L22.write_json
      L23 = L9
      L22(L23)
      L22 = L1.log
      L23 = "dhcp failed"
      L22(L23)
      return
    else
      L9.code = 1616
      L9.msg = "wifi connect faild!"
      L22 = _UPVALUE0_
      L22 = L22.write_json
      L23 = L9
      L22(L23)
      L22 = L1.log
      L23 = "wifi connect failed"
      L22(L23)
      return
    end
  end
  L22 = L1.log
  L23 = 1
  L24 = "connect peer success"
  L22(L23, L24)
  L22 = "admin_password="
  L23 = L20
  L24 = "&ssid="
  L25 = self_ssid
  L26 = "&password="
  L27 = L17
  L28 = "&band="
  L29 = L18
  L22 = L22 .. L23 .. L24 .. L25 .. L26 .. L27 .. L28 .. L29
  L23 = L1.log
  L24 = 1
  L25 = "params:"
  L26 = L22
  L25 = L25 .. L26
  L23(L24, L25)
  L23 = L7.ExtendWifiRequestRemoteAPIForLua
  L24 = "/api/xqnetwork/set_wifi_auto_ap_mode"
  L25 = ""
  L26 = L22
  L23 = L23(L24, L25, L26)
  L24 = L23.code
  if L24 == 0 then
    L24 = require
    L25 = "cjson"
    L24 = L24(L25)
    L25 = L24.decode
    L26 = L23.msg
    L25 = L25(L26)
    L26 = L25.code
    if L26 == 0 then
      L26 = L1.log
      L27 = 1
      L28 = "auto wifi ap mode success"
      L26(L27, L28)
      L26 = {}
      L26.code = 0
      L27 = self_ssid
      L26.ssid_24g = L27
      L27 = self_ssid
      L28 = "_5G"
      L27 = L27 .. L28
      L26.ssid_5g = L27
      L26.password_24g = L17
      L26.password_5g = L17
      L27 = _UPVALUE0_
      L27 = L27.write_json
      L28 = L26
      L27(L28)
    else
      L26 = L1.log
      L27 = 1
      L28 = "auto wifi ap mode error"
      L26(L27, L28)
      L26 = _UPVALUE0_
      L26 = L26.write
      L27 = L23.msg
      L26(L27)
    end
  else
    L24 = L1.log
    L25 = 1
    L26 = "auto wifi ap mode http request error"
    L24(L25, L26)
    L24 = _UPVALUE1_
    L24 = L24.getErrorMessage
    L25 = L9.code
    L24 = L24(L25)
    L23.msg = L24
    L24 = _UPVALUE0_
    L24 = L24.write_json
    L25 = L23
    L24(L25)
  end
  L24 = L6.extednwifi_disconnect
  L25 = L18
  L24(L25)
end
setPeerWifiAutoAPMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAPModule"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = {}
  L6.code = 0
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "ssid"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "password"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "admin_password"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "band"
  L10 = L10(L11)
  L11 = L0.log
  L12 = 1
  L13 = "recv ssid:"
  L14 = L7
  L15 = " password"
  L16 = L8
  L17 = " band"
  L18 = L10
  L13 = L13 .. L14 .. L15 .. L16 .. L17 .. L18
  L11(L12, L13)
  L11 = "lua /usr/sbin/set_wifi_auto_ap_mode.lua "
  L12 = L7
  L13 = " "
  L14 = L8
  L15 = " "
  L16 = L10
  L17 = " "
  L18 = L9
  L11 = L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18
  L12 = L0.log
  L13 = 1
  L14 = "run cmd:"
  L15 = L11
  L14 = L14 .. L15
  L12(L13, L14)
  L12 = L1.forkExec
  L13 = L11
  L12(L13)
end
setWifiAutoApMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L2.ssid = ""
  L2.signal = 0
  L2.band = ""
  L3 = nil
  L4 = L0.getNetMode
  L4 = L4()
  if L4 == "wifiapmode" then
    L5 = L1.apcli_get_active
    L5 = L5()
    L6 = L1.apcli_get_wifinet
    L7 = L5
    L6 = L6(L7)
    if L6 then
      L7 = L0.isStrNil
      L9 = L6
      L8 = L6.signal
      L8, L9 = L8(L9)
      L7 = L7(L8, L9)
      if not L7 then
        L7 = L1.miwifiutil_rssi_to_signal
        L9 = L6
        L8 = L6.signal
        L8, L9 = L8(L9)
        L7 = L7(L8, L9)
        L2.signal = L7
        L7 = L1.apcli_get_connect
        L8 = L5
        L7, L8 = L7(L8)
        if L7 == false then
          L2.signal = 0
        end
      end
    end
    L8 = L6
    L7 = L6.ssid
    L7 = L7(L8)
    L2.ssid = L7
    L7 = L1.apcli_get_real_signal
    L8 = L5
    L7 = L7(L8)
    L3 = L7
    if nil ~= L3 then
      L7 = L1.miwifiutil_rssi_to_signal
      L8 = L3
      L7 = L7(L8)
      L2.signal = L7
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
apcli_get_signal = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.actionForEnableWifiAP
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
serviceRestart = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQAPModule"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQPortServiceUtil"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ssid"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "password"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "nonce"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "newPwd"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "oldPwd"
  L9 = L9(L10)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "initialize"
  L11, L12, L13, L14, L15, L16, L17, L18, L19, L20 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  if L10 == 1 then
    L10 = 1
    if L10 then
      goto lbl_48
    end
  end
  L10 = 0
  ::lbl_48::
  L11 = L0.getNetMode
  L11 = L11()
  L12 = {}
  L12.code = 0
  L13 = L4.psMultiwanEnable
  L13 = L13()
  if 1 == L13 then
    L12.code = 3000
  elseif L11 == "wifiapmode" then
    L12.code = 1618
  end
  L13 = L12.code
  if 0 == L13 then
    if L10 == 1 and L5 and L6 and L7 and L8 and L9 then
      L13 = _savePassword
      L14 = L7
      L15 = L9
      L16 = L8
      L13 = L13(L14, L15, L16)
      L12.code = L13
      L13 = L12.code
      if L13 == 0 then
        L13 = L3.setWifiBasicInfo
        L14 = 1
        L15 = L5
        L16 = L6
        L17 = "psk2"
        L18, L19 = nil, nil
        L20 = 0
        L13(L14, L15, L16, L17, L18, L19, L20)
        L13 = L3.setWifiBasicInfo
        L14 = 2
        L15 = L5
        L16 = "_5G"
        L15 = L15 .. L16
        L16 = L6
        L17 = "psk2"
        L18, L19 = nil, nil
        L20 = 0
        L13(L14, L15, L16, L17, L18, L19, L20)
        L13 = L2.setInited
        L13()
        L13 = L2.setRouterName
        L14 = L5
        L13(L14)
      end
    end
    L13 = L12.code
    if L13 == 0 then
      L13 = L1.setLanAPMode
      L13 = L13()
      if L13 then
        L12.ip = L13
      else
        L12.code = 1619
      end
    end
  end
  L13 = L12.code
  if L13 ~= 0 then
    L13 = _UPVALUE1_
    L13 = L13.getErrorMessage
    L14 = L12.code
    L13 = L13(L14)
    L12.msg = L13
  else
    L13 = L1.lanApServiceRestart
    L14 = true
    L15 = true
    L16 = false
    L13(L14, L15, L16)
  end
  L13 = _UPVALUE0_
  L13 = L13.write_json
  L14 = L12
  L13(L14)
end
setLanAP = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.disableLanAP
  L2 = L2()
  L1.ip = L2
  L2 = L0.lanApServiceRestart
  L3 = false
  L4 = true
  L5 = false
  L2(L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
disableLanAP = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.wifiChannelQuality
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
channelScanStart = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getAllWifiInfo
  L2 = L2()
  L3 = L2[1]
  if L3 then
    L3 = L2[1]
    L3 = L3.status
    if L3 == "1" then
      L3 = L0.scanWifiChannel
      L4 = 1
      L3 = L3(L4)
      L1["2G"] = L3
    end
  end
  L3 = 0
  L4 = L1["2G"]
  if L4 then
    L4 = L1["2G"]
    L4 = L4.code
    if L4 ~= 0 then
      L3 = 1
    end
  end
  L1.status = L3
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
getScanResult = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "channel1"
  L2, L3, L4, L5, L6 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "channel2"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L3 = {}
  L3.code = 0
  L4 = L0.iwprivSetChannel
  L5 = L1
  L6 = L2
  L4(L5, L6)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
setChannel = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = {}
  L4.code = 0
  L5 = io
  L5 = L5.open
  L6 = "/tmp/diag_sta_sig"
  L7 = "w+"
  L5 = L5(L6, L7)
  L6 = L0.trim
  L7 = L0.exec
  L8 = string
  L8 = L8.format
  L8, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L8(L9)
  L7, L8, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26)
  L8 = L5
  L7 = L5.write
  L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L9(L10, L11)
  L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26)
  L7 = L1.getDeviceList
  L8 = true
  L7 = L7(L8, L9)
  L7 = L7 or L7
  L8 = {}
  for L12, L13 in L9, L10, L11 do
    L14 = 0
    L15 = 0
    L16 = 0
    L17 = 0
    L18 = tonumber
    L19 = L13.port
    L18 = L18(L19)
    if L18 ~= 1 then
      L18 = tonumber
      L19 = L13.port
      L18 = L18(L19)
      if L18 ~= 2 then
        L18 = tonumber
        L19 = L13.port
        L18 = L18(L19)
        if L18 ~= 3 then
          goto lbl_106
        end
      end
    end
    L18 = L2.getWifiDeviceSignal
    L19 = string
    L19 = L19.upper
    L20 = L13.mac
    L19, L20, L21, L22, L23, L24, L25, L26 = L19(L20)
    L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26)
    L14 = L18
    L18 = L2.getWifiDeviceSpeed
    L19 = string
    L19 = L19.upper
    L20 = L13.mac
    L19, L20, L21, L22, L23, L24, L25, L26 = L19(L20)
    L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26)
    L18 = L18.upspeed
    L16 = L18 / 1000
    L18 = L2.getWifiDeviceSpeed
    L19 = string
    L19 = L19.upper
    L20 = L13.mac
    L19, L20, L21, L22, L23, L24, L25, L26 = L19(L20)
    L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26)
    L18 = L18.downspeed
    L17 = L18 / 1000
    L18 = tonumber
    L20 = L3
    L19 = L3.get
    L21 = "diag"
    L22 = "config"
    L23 = "signal_thr"
    L19 = L19(L20, L21, L22, L23)
    L19 = L19 or L19
    L18 = L18(L19)
    signal_thr = L18
    L18 = signal_thr
    if L14 < L18 then
      L15 = 1
    end
    ::lbl_106::
    L18 = table
    L18 = L18.insert
    L19 = L8
    L20 = {}
    L21 = L13.name
    L20.name = L21
    L21 = string
    L21 = L21.upper
    L22 = L13.mac
    L21 = L21(L22)
    L20.mac = L21
    L21 = L13.ip
    L20.ip = L21
    L21 = L13.port
    L20.port = L21
    L20.signal = L14
    L20.signal_warning = L15
    L20.upspeed = L16
    L20.downspeed = L17
    L21 = L13.statistics
    L21 = L21.online
    L20.onlinetime = L21
    L18(L19, L20)
    L18 = "PASS"
    if L15 == 1 then
      L18 = "FAIL"
    end
    L19 = L13.port
    if L19 ~= 0 then
      L20 = L5
      L19 = L5.write
      L21 = string
      L21 = L21.format
      L22 = "name:%s, mac: %s, signal:%s, result:%s\n"
      L23 = L13.name
      L24 = string
      L24 = L24.upper
      L25 = L13.mac
      L24 = L24(L25)
      L25 = L14
      L26 = L18
      L21, L22, L23, L24, L25, L26 = L21(L22, L23, L24, L25, L26)
      L19(L20, L21, L22, L23, L24, L25, L26)
    end
  end
  L9(L10)
  L9(L10)
  L4.devicelist = L8
  L9(L10)
end
getDiagDeviceList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L3 = L0.execl
  L7, L8, L9, L10, L11, L12, L13, L14 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  for L7, L8 in L4, L5, L6 do
    L9 = L0.trim
    L10 = L0.exec
    L11 = string
    L11 = L11.format
    L12 = "basename %s"
    L13 = L8
    L11, L12, L13, L14 = L11(L12, L13)
    L10, L11, L12, L13, L14 = L10(L11, L12, L13, L14)
    L9 = L9(L10, L11, L12, L13, L14)
    L10 = L0.trim
    L11 = L0.exec
    L12 = string
    L12 = L12.format
    L13 = "getdisk bus %s"
    L14 = L9
    L12, L13, L14 = L12(L13, L14)
    L11, L12, L13, L14 = L11(L12, L13, L14)
    L10 = L10(L11, L12, L13, L14)
    L11 = table
    L11 = L11.insert
    L12 = L2
    L13 = {}
    L13.diskname = L9
    L13.disktype = L10
    L11(L12, L13)
  end
  L1.disklist = L2
  return L1
end
getDiagDiskInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L0.code = 0
  L0.status = 0
  L1 = getDiagDiskInfo
  L1 = L1()
  L2 = L1.disklist
  for L6, L7 in L3, L4, L5 do
    L8 = L7.disktype
    L9 = L8
    L8 = L8.match
    L10 = "^USB"
    L8 = L8(L9, L10)
    if L8 then
      L0.status = 1
      break
    end
  end
  L3(L4)
end
getDiagUdiskStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L0.code = 0
  L0.status = 0
  L1 = getDiagDiskInfo
  L1 = L1()
  L2 = L1.disklist
  for L6, L7 in L3, L4, L5 do
    L8 = L7.disktype
    L9 = L8
    L8 = L8.match
    L10 = "^SATA"
    L8 = L8(L9, L10)
    if L8 then
      L0.status = 1
      break
    end
  end
  L3(L4)
end
getDiagDiskStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = 8
  L4 = 2 * L3
  L4 = L4 + 2
  L5 = nil
  L7 = L2
  L6 = L2.get
  L8 = "diag"
  L9 = "config"
  L10 = "iperf_test_thr"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = 1
  L8 = "/tmp/iperf_test_result"
  L9 = {}
  L9.code = 0
  L10 = io
  L10 = L10.open
  L11 = "/tmp/diag_sta_iperf"
  L12 = "w+"
  L10 = L10(L11, L12)
  L11 = L0.trim
  L12 = L0.exec
  L13 = string
  L13 = L13.format
  L14 = "date"
  L13, L14, L15, L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L13(L14)
  L12, L13, L14, L15, L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L13 = L10
  L12 = L10.write
  L14 = string
  L14 = L14.format
  L15 = "station iperf test at %s, result is:\n"
  L16 = L11
  L14, L15, L16, L17, L18, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L14(L15, L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L12 = L1.getDeviceList
  L13 = true
  L14 = true
  L12 = L12(L13, L14)
  L12 = L12 or L12
  L13 = {}
  L14, L15, L16, L17, L18 = nil, nil, nil, nil, nil
  for L22, L23 in L19, L20, L21 do
    L24 = L0.exec
    L25 = string
    L25 = L25.format
    L26 = "timeout -t %d /usr/bin/iperf -c %s -d -t %d > %s.%d"
    L27 = L4
    L28 = L23.ip
    L29 = L3
    L30 = L8
    L31 = L7
    L25, L26, L27, L28, L29, L30, L31, L32, L33 = L25(L26, L27, L28, L29, L30, L31)
    L24(L25, L26, L27, L28, L29, L30, L31, L32, L33)
    L24 = L0.trim
    L25 = L0.exec
    L26 = string
    L26 = L26.format
    L27 = "cat %s.%d | grep \"Mbits/sec\" | wc -l"
    L28 = L8
    L29 = L7
    L26, L27, L28, L29, L30, L31, L32, L33 = L26(L27, L28, L29)
    L25, L26, L27, L28, L29, L30, L31, L32, L33 = L25(L26, L27, L28, L29, L30, L31, L32, L33)
    L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33)
    L5 = L24
    L24 = tonumber
    L25 = L5
    L24 = L24(L25)
    if L24 == 2 then
      L24 = L0.trim
      L25 = L0.exec
      L26 = string
      L26 = L26.format
      L27 = "cat %s.%d | awk -F 'Bytes' '/Bytes/{print $2}' | awk -F ' ' '{print $1}' | awk 'NR==1'"
      L28 = L8
      L29 = L7
      L26, L27, L28, L29, L30, L31, L32, L33 = L26(L27, L28, L29)
      L25, L26, L27, L28, L29, L30, L31, L32, L33 = L25(L26, L27, L28, L29, L30, L31, L32, L33)
      L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33)
      L16 = L24
      L24 = L0.trim
      L25 = L0.exec
      L26 = string
      L26 = L26.format
      L27 = "cat %s.%d | awk -F 'Bytes' '/Bytes/{print $2}' | awk -F ' ' '{print $1}' | awk 'NR==2'"
      L28 = L8
      L29 = L7
      L26, L27, L28, L29, L30, L31, L32, L33 = L26(L27, L28, L29)
      L25, L26, L27, L28, L29, L30, L31, L32, L33 = L25(L26, L27, L28, L29, L30, L31, L32, L33)
      L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33)
      L17 = L24
      L24 = tonumber
      L25 = L16
      L24 = L24(L25)
      L25 = tonumber
      L26 = L6
      L25 = L25(L26)
      if L24 > L25 then
        L24 = tonumber
        L25 = L17
        L24 = L24(L25)
        L25 = tonumber
        L26 = L6
        L25 = L25(L26)
        if L24 > L25 then
          L14 = "PASS"
          L15 = "0"
      end
      else
        L14 = "FAIL"
        L15 = "2"
      end
    else
      L14 = "FAIL"
      L15 = "1"
      L16 = "0"
      L17 = "0"
    end
    L24 = table
    L24 = L24.insert
    L25 = L13
    L26 = {}
    L27 = L23.name
    L26.name = L27
    L27 = string
    L27 = L27.upper
    L28 = L23.mac
    L27 = L27(L28)
    L26.mac = L27
    L27 = L23.ip
    L26.ip = L27
    L26.testresult = L14
    L26.testresultcode = L15
    L26.downlink = L16
    L26.uplink = L17
    L24(L25, L26)
    L24 = tonumber
    L25 = L15
    L24 = L24(L25)
    if L24 == 2 then
      L18 = "throughput not meet standards"
    else
      L24 = tonumber
      L25 = L15
      L24 = L24(L25)
      if L24 == 1 then
        L18 = "iperf server not start"
      else
        L18 = "success"
      end
    end
    L25 = L10
    L24 = L10.write
    L26 = string
    L26 = L26.format
    L27 = "name:%s, mac: %s, downlink:%s, uplink:%s, result:%s, reason:%s\n"
    L28 = L23.name
    L29 = string
    L29 = L29.upper
    L30 = L23.mac
    L29 = L29(L30)
    L30 = L16
    L31 = L17
    L32 = L14
    L33 = L18
    L26, L27, L28, L29, L30, L31, L32, L33 = L26(L27, L28, L29, L30, L31, L32, L33)
    L24(L25, L26, L27, L28, L29, L30, L31, L32, L33)
    L7 = L7 + 1
  end
  L19(L20)
  L19(L20)
  L9.devicetestlist = L13
  L19(L20)
end
diagWifiTest = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.usbname = "none"
  L2.usbtype = "none"
  L2.usbspeed = "0"
  L2.usbtestresult = "FAIL"
  L3 = 0
  L4 = nil
  L5 = "/tmp/usbtestrst.txt"
  L6 = tostring
  L8 = L1
  L7 = L1.get
  L9 = "diag"
  L10 = "config"
  L11 = "usb_write_thr"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = tostring
  L9 = L1
  L8 = L1.get
  L10 = "diag"
  L11 = "config"
  L12 = "usb_read_thr"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L7 = L7(L8)
  L8 = 1
  L9 = 0
  L10 = io
  L10 = L10.open
  L11 = "/tmp/diag_usb_test"
  L12 = "w+"
  L10 = L10(L11, L12)
  L11 = L0.trim
  L12 = L0.exec
  L13 = string
  L13 = L13.format
  L13, L17, L18, L19, L20, L21, L22 = L13(L14)
  L12, L13, L17, L18, L19, L20, L21, L22 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L13 = L10
  L12 = L10.write
  L17, L18, L19, L20, L21, L22 = L14(L15, L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L12 = L0.trim
  L13 = L0.exec
  L17, L18, L19, L20, L21, L22 = L14(L15)
  L13, L17, L18, L19, L20, L21, L22 = L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L8 = L12
  L12 = L0.trim
  L13 = L0.exec
  L17, L18, L19, L20, L21, L22 = L14(L15)
  L13, L17, L18, L19, L20, L21, L22 = L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L9 = L12
  L12 = tonumber
  L13 = L9
  L12 = L12(L13)
  if L12 == 1 then
    L2.usbtype = "3.0"
    L12 = L0.trim
    L13 = L0.exec
    L17, L18, L19, L20, L21, L22 = L14(L15)
    L13, L17, L18, L19, L20, L21, L22 = L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
    L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
    L2.usbspeed = L12
  else
    L12 = tonumber
    L13 = L8
    L12 = L12(L13)
    if L12 == 1 then
      L2.usbtype = "2.0"
      L12 = L0.trim
      L13 = L0.exec
      L17, L18, L19, L20, L21, L22 = L14(L15)
      L13, L17, L18, L19, L20, L21, L22 = L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
      L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
      L2.usbspeed = L12
    end
  end
  L12 = getDiagDiskInfo
  L12 = L12()
  L13 = L12.disklist
  for L17, L18 in L14, L15, L16 do
    L19 = L18.disktype
    L20 = L19
    L19 = L19.match
    L21 = "^USB"
    L19 = L19(L20, L21)
    if L19 then
      L3 = 1
      L4 = L18.diskname
      break
    end
  end
  if L14 == 1 then
    L17 = "ls -1 /dev/%s[0-9]"
    L18 = L4
    L17, L18, L19, L20, L21, L22 = L16(L17, L18)
    L17, L18, L19, L20, L21, L22 = L15(L16, L17, L18, L19, L20, L21, L22)
    L2.usbname = L14
    L17 = "date > %s"
    L18 = L5
    L17, L18, L19, L20, L21, L22 = L16(L17, L18)
    L15(L16, L17, L18, L19, L20, L21, L22)
    L17 = string
    L17 = L17.format
    L18 = "ubenchmark_disk '%s' 64 '%s' '%s' >> '%s' 2>&1 && echo PASS || echo FAIL"
    L19 = L14
    L20 = L6
    L21 = L7
    L22 = L5
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21, L22)
    L17, L18, L19, L20, L21, L22 = L16(L17, L18, L19, L20, L21, L22)
    L17 = string
    L17 = L17.format
    L18 = "echo 'wr_thr:%s, rd_thr:%s, result:%s' >> %s"
    L19 = L6
    L20 = L7
    L21 = L15
    L22 = L5
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21, L22)
    L16(L17, L18, L19, L20, L21, L22)
    L17 = L15
    L18 = "^PASS"
    if L16 then
      L2.usbtestresult = "PASS"
    end
    L17 = L0.exec
    L18 = string
    L18 = L18.format
    L19 = "cat %s"
    L20 = L5
    L18, L19, L20, L21, L22 = L18(L19, L20)
    L17, L18, L19, L20, L21, L22 = L17(L18, L19, L20, L21, L22)
    L2.usbtestlog = L16
  end
  L17 = [[
%s
usbtype:%s, usbspeed:%s
]]
  L18 = L2.usbtestresult
  L19 = L2.usbtype
  L20 = L2.usbspeed
  L17, L18, L19, L20, L21, L22 = L16(L17, L18, L19, L20)
  L14(L15, L16, L17, L18, L19, L20, L21, L22)
  L14(L15)
  L14(L15)
  L14(L15)
end
diagUsbTest = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.diskname = "none"
  L1.hddstatus = "PASS"
  L2 = io
  L2 = L2.open
  L3 = "/tmp/diag_disk_smart"
  L4 = "w+"
  L2 = L2(L3, L4)
  L3 = L0.trim
  L4 = L0.exec
  L5 = string
  L5 = L5.format
  L6 = "date"
  L5, L6, L10, L11, L12, L13, L14 = L5(L6)
  L4, L5, L6, L10, L11, L12, L13, L14 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L5 = L2
  L4 = L2.write
  L6 = string
  L6 = L6.format
  L6, L10, L11, L12, L13, L14 = L6(L7, L8)
  L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L4 = 0
  L5 = getDiagDiskInfo
  L5 = L5()
  L6 = L5.disklist
  for L10, L11 in L7, L8, L9 do
    L12 = L11.disktype
    L13 = L12
    L12 = L12.match
    L14 = "^SATA"
    L12 = L12(L13, L14)
    if L12 then
      L4 = 1
      L12 = L11.diskname
      L1.diskname = L12
      break
    end
  end
  if L7 == 1 then
    L10 = "/usr/sbin/hddstatus && echo PASS || echo FAIL"
    L10, L11, L12, L13, L14 = L9(L10)
    L10, L11, L12, L13, L14 = L8(L9, L10, L11, L12, L13, L14)
    L10 = "^FAIL"
    if L8 then
      L1.hddstatus = "FAIL"
    end
  end
  L10 = "%s\n"
  L11 = L1.hddstatus
  L10, L11, L12, L13, L14 = L9(L10, L11)
  L7(L8, L9, L10, L11, L12, L13, L14)
  L7(L8)
  L7(L8)
  L7(L8)
end
diagHddStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.diskname = "none"
  L2.diskrdtestresult = "PASS"
  L3 = nil
  L4 = 0
  L5 = "/tmp/disktestrst.txt"
  L6 = tostring
  L8 = L1
  L7 = L1.get
  L9 = "diag"
  L10 = "config"
  L11 = "disk_write_thr"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = tostring
  L9 = L1
  L8 = L1.get
  L10 = "diag"
  L11 = "config"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L7 = L7(L8)
  L8 = io
  L8 = L8.open
  L9 = "/tmp/diag_disk_rd_test"
  L10 = "w+"
  L8 = L8(L9, L10)
  L9 = L0.trim
  L10 = L0.exec
  L11 = string
  L11 = L11.format
  L11, L15, L16, L17, L18, L19, L20 = L11(L12)
  L10, L11, L15, L16, L17, L18, L19, L20 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L11 = L8
  L10 = L8.write
  L15, L16, L17, L18, L19, L20 = L12(L13, L14)
  L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L10 = getDiagDiskInfo
  L10 = L10()
  L11 = L10.disklist
  for L15, L16 in L12, L13, L14 do
    L17 = L16.disktype
    L18 = L17
    L17 = L17.match
    L19 = "^SATA"
    L17 = L17(L18, L19)
    if L17 then
      L4 = 1
      L3 = L16.diskname
      L2.diskname = L3
      break
    end
  end
  if L12 == 1 then
    L15 = "ls -1 /dev/%s[0-9]"
    L16 = L3
    L15, L16, L17, L18, L19, L20 = L14(L15, L16)
    L15, L16, L17, L18, L19, L20 = L13(L14, L15, L16, L17, L18, L19, L20)
    L15 = "date > %s"
    L16 = L5
    L15, L16, L17, L18, L19, L20 = L14(L15, L16)
    L13(L14, L15, L16, L17, L18, L19, L20)
    L15 = string
    L15 = L15.format
    L16 = "ubenchmark_disk %s 256 %s %s >> %s 2>&1 && echo PASS || echo FAIL"
    L17 = L12
    L18 = L6
    L19 = L7
    L20 = L5
    L15, L16, L17, L18, L19, L20 = L15(L16, L17, L18, L19, L20)
    L15, L16, L17, L18, L19, L20 = L14(L15, L16, L17, L18, L19, L20)
    L15 = string
    L15 = L15.format
    L16 = "echo 'wr_thr:%s, rd_thr:%s, result:%s' >> %s"
    L17 = L6
    L18 = L7
    L19 = L13
    L20 = L5
    L15, L16, L17, L18, L19, L20 = L15(L16, L17, L18, L19, L20)
    L14(L15, L16, L17, L18, L19, L20)
    L15 = L13
    L16 = "^FAIL"
    if L14 then
      L2.diskrdtestresult = "FAIL"
    end
  end
  L15 = "%s\n"
  L16 = L2.diskrdtestresult
  L15, L16, L17, L18, L19, L20 = L14(L15, L16)
  L12(L13, L14, L15, L16, L17, L18, L19, L20)
  L12(L13)
  L12(L13)
  L12(L13)
end
diagDiskTest = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.code = 0
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "signal_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.signal_thr = L2
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "iperf_test_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.iperf_test_thr = L2
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "usb_write_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.usb_write_thr = L2
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "usb_read_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.usb_read_thr = L2
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "disk_write_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.disk_write_thr = L2
  L3 = L0
  L2 = L0.get
  L4 = "diag"
  L5 = "config"
  L6 = "disk_read_thr"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.disk_read_thr = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getDiagParas = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "signal_thr"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "iperf_test_thr"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "usb_write_thr"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "usb_read_thr"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "disk_write_thr"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "disk_read_thr"
  L6 = L6(L7)
  L7 = {}
  L7.code = 0
  L8 = "[`$|;&]"
  L9 = string
  L9 = L9.find
  L10 = L3
  L11 = L8
  L9 = L9(L10, L11)
  if not L9 then
    L9 = string
    L9 = L9.find
    L10 = L4
    L11 = L8
    L9 = L9(L10, L11)
    if not L9 then
      L9 = string
      L9 = L9.find
      L10 = L5
      L11 = L8
      L9 = L9(L10, L11)
      if not L9 then
        L9 = string
        L9 = L9.find
        L10 = L6
        L11 = L8
        L9 = L9(L10, L11)
        if not L9 then
          goto lbl_67
        end
      end
    end
  end
  L7.code = -1
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
  do return end
  ::lbl_67::
  if L1 ~= nil then
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "signal_thr"
    L14 = L1
    L9(L10, L11, L12, L13, L14)
  end
  if L2 ~= nil then
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "iperf_test_thr"
    L14 = L2
    L9(L10, L11, L12, L13, L14)
  end
  if L3 ~= nil and L4 ~= nil and (L3 ~= 0 or L4 ~= 0) then
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "usb_write_thr"
    L14 = L3
    L9(L10, L11, L12, L13, L14)
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "usb_read_thr"
    L14 = L4
    L9(L10, L11, L12, L13, L14)
  end
  if L5 ~= nil and L6 ~= nil and (L5 ~= 0 or L6 ~= 0) then
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "disk_write_thr"
    L14 = L5
    L9(L10, L11, L12, L13, L14)
    L10 = L0
    L9 = L0.set
    L11 = "diag"
    L12 = "config"
    L13 = "disk_read_thr"
    L14 = L6
    L9(L10, L11, L12, L13, L14)
  end
  if L1 ~= nil or L2 ~= nil or L3 ~= nil or L4 ~= nil then
    L10 = L0
    L9 = L0.commit
    L11 = "diag"
    L9(L10, L11)
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
end
setDiagParas = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L3 = io
  L3 = L3.open
  L4 = A0
  L5 = "r"
  L3 = L3(L4, L5)
  if L3 then
    L5 = L3
    L4 = L3.read
    L6 = "*a"
    L4 = L4(L5, L6)
    L2 = L4
    L5 = L3
    L4 = L3.close
    L4(L5)
    if L2 == nil then
      L4 = false
      return L4
    end
  else
    L4 = false
    return L4
  end
  L4 = io
  L4 = L4.open
  L5 = A1
  L6 = "a"
  L4 = L4(L5, L6)
  if L4 then
    L6 = L4
    L5 = L4.write
    L7 = L2
    L5 = L5(L6, L7)
    if L5 == nil then
      L7 = L4
      L6 = L4.close
      L6(L7)
      L6 = false
      return L6
    end
    L7 = L4
    L6 = L4.write
    L8 = string
    L8 = L8.format
    L9 = "\n"
    L8, L9 = L8(L9)
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.close
    L6(L7)
    L6 = true
    return L6
  else
    L5 = false
    return L5
  end
end
addtofile = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "xiaoqiang.util.XQNetUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "nixio.fs"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.sys"
  L4 = L4(L5)
  L5 = "/tmp/syslogbackup/"
  L7 = L2
  L6 = L2.get
  L8 = "network"
  L9 = "lan"
  L10 = "ipaddr"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = {}
  L7.code = 0
  L8 = "/tmp/diag_test.log"
  L9 = addtofile
  L10 = "/tmp/diag_net_spd"
  L11 = L8
  L9(L10, L11)
  L9 = addtofile
  L10 = "/tmp/diag_sta_sig"
  L11 = L8
  L9(L10, L11)
  L9 = addtofile
  L10 = "/tmp/diag_sta_iperf"
  L11 = L8
  L9(L10, L11)
  L9 = addtofile
  L10 = "/tmp/diag_usb_test"
  L11 = L8
  L9(L10, L11)
  L9 = addtofile
  L10 = "/tmp/diag_disk_smart"
  L11 = L8
  L9(L10, L11)
  L9 = addtofile
  L10 = "/tmp/diag_disk_rd_test"
  L11 = L8
  L9(L10, L11)
  function L9()
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
  sane = L9
  function L9()
    local L0, L1, L2
    L0 = _UPVALUE0_
    L0 = L0.mkdir
    L1 = _UPVALUE1_
    L2 = 700
    L0(L1, L2)
  end
  prepare = L9
  L9 = sane
  L9 = L9()
  if not L9 then
    L9 = prepare
    L9()
  else
    L9 = os
    L9 = L9.execute
    L10 = "rm "
    L11 = L5
    L12 = "*.diag.log"
    L10 = L10 .. L11 .. L12
    L9(L10)
  end
  L9 = L3.access
  L10 = L8
  L9 = L9(L10)
  if L9 then
    L9 = L0.getSN
    L9 = L9()
    L10 = string
    L10 = L10.find
    L11 = L9
    L12 = "/"
    L10, L11 = L10(L11, L12)
    L12 = string
    L12 = L12.sub
    L13 = L9
    L14 = 1
    L15 = L11 - 1
    L12 = L12(L13, L14, L15)
    L13 = string
    L13 = L13.sub
    L14 = L9
    L15 = L11 + 1
    L16 = string
    L16 = L16.len
    L17 = L9
    L16, L17, L18, L19, L20 = L16(L17)
    L13 = L13(L14, L15, L16, L17, L18, L19, L20)
    L14 = L12
    L15 = "-"
    L16 = L13
    L17 = "--"
    L18 = os
    L18 = L18.date
    L19 = "%Y-%m-%d--%X"
    L20 = os
    L20 = L20.time
    L20 = L20()
    L18 = L18(L19, L20)
    L19 = ".diag.log"
    L14 = L14 .. L15 .. L16 .. L17 .. L18 .. L19
    L15 = L1.exec
    L16 = "cp "
    L17 = L8
    L18 = " "
    L19 = L5
    L20 = L14
    L16 = L16 .. L17 .. L18 .. L19 .. L20
    L15(L16)
    L15 = L1.exec
    L16 = "rm "
    L17 = L8
    L16 = L16 .. L17
    L15(L16)
    L15 = L6
    L16 = "/backup/log/"
    L17 = L14
    L15 = L15 .. L16 .. L17
    L7.logUrl = L15
  else
    L7.code = 1
    L7.msg = "There is no diag test log, not test yet?"
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
end
getDiagLog = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "wifiIndex"
  L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "weakenable"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "weakthreshold"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "kickthreshold"
  L7 = L7(L8)
  L8 = L0.setWifiWeakInfo
  L9 = L4
  L10 = L5
  L11 = L6
  L12 = L7
  L8 = L8(L9, L10, L11, L12)
  if L8 == false then
    L3 = 1502
  end
  if L3 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L3
    L9 = L9(L10)
    L2.msg = L9
  end
  L2.code = L3
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L2
  L9(L10)
  if L3 == 0 then
    L9 = _UPVALUE0_
    L9 = L9.close
    L9()
    L9 = L1.forkRestartWifi
    L9()
  end
end
setWifiWeakInfo = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = L0.getWifiWeakInfo
  L3 = L3()
  L1.info = L3
  L1.code = L2
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getWifiWeakInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "on"
  L3, L4, L5 = L3(L4)
  L2 = L2(L3, L4, L5)
  if L2 == 1 then
    L2 = true
    if L2 then
      goto lbl_18
    end
  end
  L2 = false
  ::lbl_18::
  L3 = L0.miscanSwitch
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1.code = 1606
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
miscanSwitch = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = L0.getMiscanSwitch
  L3 = L3()
  L2 = L2(L3)
  L1.enabled = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getMiscanSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
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
  L6 = "wireless"
  L7 = "miot_2G"
  L8 = "bindstatus"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L6 = L3
  L5 = L3.get
  L7 = "wireless"
  L8 = "miot_2G"
  L9 = "userswitch"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L7 = L3
  L6 = L3.get
  L8 = "misc"
  L9 = "wireless"
  L10 = "if_2G"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = {}
  L7.code = 0
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "on"
  L9, L10, L11, L12, L13, L14 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14)
  if L8 == 1 then
    L8 = "1"
    if L8 then
      goto lbl_53
    end
  end
  L8 = "0"
  ::lbl_53::
  if L4 == "1" then
    if L5 == "0" and L8 == "1" then
      if "wifi0" == L6 then
        L9 = L2.exec
        L10 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 enable"
        L9(L10)
      elseif "wifi1" == L6 then
        L9 = L2.exec
        L10 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 enable"
        L9(L10)
      else
        L9 = L2.exec
        L10 = "ifconfig wl13 up"
        L9(L10)
      end
      L9 = L2.exec
      L10 = "/usr/sbin/sysapi miot"
      L9(L10)
    elseif L5 == "1" and L8 == "0" then
      if "wifi0" == L6 then
        L9 = L2.exec
        L10 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 disable"
        L9(L10)
      elseif "wifi1" == L6 then
        L9 = L2.exec
        L10 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 disable"
        L9(L10)
      else
        L9 = L2.exec
        L10 = "ifconfig wl13 down"
        L9(L10)
      end
    end
  end
  L10 = L3
  L9 = L3.set
  L11 = "wireless"
  L12 = "miot_2G"
  L13 = "userswitch"
  L14 = L8
  L9(L10, L11, L12, L13, L14)
  L10 = L3
  L9 = L3.commit
  L11 = "wireless"
  L9(L10, L11)
  L9 = L1.forkExec
  L10 = [[
        [ -f "/etc/init.d/miot" ] && /etc/init.d/miot restart;
        /sbin/whc_to_re_common_api.sh whc_sync;
    ]]
  L9(L10)
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
end
miotrelaySwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "wireless"
  L6 = "miot_2G"
  L7 = "userswitch"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = {}
  L4.code = 0
  L5 = tonumber
  L6 = L3
  L5 = L5(L6)
  L4.enabled = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
getMiotrelaySwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3, L4, L5, L6, L7, L8 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L3 = {}
  L5 = L1
  L4 = L1.get
  L6 = "repacd"
  L7 = "WiFiLink"
  L8 = "2GIndependentChannelSelectionEnable"
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = L0.log
    L6 = 6
    L7 = "get 2.4G backhaul_mode\239\188\154"
    L8 = L4
    L7 = L7 .. L8
    L5(L6, L7)
    L3.mode = L4
    L3.code = 0
  else
    L5 = L0.log
    L6 = 6
    L7 = "can not get 2.4G backhaul_mode, check hardware."
    L5(L6, L7)
    L3.code = 1
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
getSonBackhaulMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mode"
  L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12)
  L5 = {}
  L5.code = 0
  L6 = L3.log
  L7 = 6
  L8 = "setSonBackhaulMode mode:"
  L9 = L4
  L8 = L8 .. L9
  L6(L7, L8)
  L6 = L0.isMeshCap
  L6 = L6()
  if L6 then
    L6 = {}
    L6.cmd = "set_backhaul_mode"
    L7 = tostring
    L8 = L4
    L7 = L7(L8)
    L6.backhaul_mode = L7
    L7 = require
    L8 = "luci.json"
    L7 = L7(L8)
    L8 = L7.encode
    L9 = L6
    L8 = L8(L9)
    L9 = L3.log
    L10 = 6
    L11 = "CAP call RE do action msg:"
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = L0.forkExec
    L10 = "/sbin/whc_to_re_common_api.sh action '"
    L11 = L8
    L12 = "'"
    L10 = L10 .. L11 .. L12
    L9(L10)
  end
  L7 = L2
  L6 = L2.set
  L8 = "repacd"
  L9 = "WiFiLink"
  L10 = "2GIndependentChannelSelectionEnable"
  L11 = L4
  L6(L7, L8, L9, L10, L11)
  L7 = L2
  L6 = L2.commit
  L8 = "repacd"
  L6(L7, L8)
  L7 = L2
  L6 = L2.set
  L8 = "xiaoqiang"
  L9 = "common"
  L10 = "son_no_24backhaul"
  L11 = L4
  L6(L7, L8, L9, L10, L11)
  L7 = L2
  L6 = L2.commit
  L8 = "xiaoqiang"
  L6(L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L5
  L6(L7)
end
setSonBackhaulMode = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.mesh_get_scanlist
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
scanMeshNode = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = io
  L1 = L1.open
  L1 = L1(L2, L3)
  if L1 then
    for L5 in L2, L3, L4 do
      if L5 == A0 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
    end
    L2(L3)
  end
  return L2
end
isMeshVer4_Node = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mac"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "locate"
  L5 = L5(L6)
  L6 = L1.isStrNil
  L7 = L4
  L6 = L6(L7)
  if L6 then
    L3.code = 1502
  else
    L7 = L4
    L6 = L4.match
    L8 = "^(%x%x:%x%x:%x%x:%x%x:%x%x:%x%x)$"
    L6 = L6(L7, L8)
    if L6 then
      L6 = isMeshVer4_Node
      L7 = L4
      L6 = L6(L7)
      if L6 then
        L6 = L0.mesh_ver4_add_node
        L7 = L4
        L8 = L5
        L6(L7, L8)
      else
        L6 = L0.mesh_add_node
        L7 = L4
        L8 = L5
        L6(L7, L8)
      end
    else
      L3.code = 1502
    end
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L3
  L6(L7)
end
addMeshNode = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = L0.mesh_get_status
  L4 = L2
  L3 = L3(L4)
  L1.status = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getMeshNodeStatus = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getnetmode
  L2 = L2()
  L1.netmode = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getNetMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L0 = require
  L1 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 1502
  if L0 ~= nil then
    L2 = L0.is_supported
    L2 = L2()
    if L2 ~= false then
      goto lbl_20
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
  L2 = _UPVALUE0_
  L2 = L2.close
  L2()
  do return end
  ::lbl_20::
  L2 = false
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = L0.mesh_get_dwb_band
  L5 = L5()
  L6 = tonumber
  L7 = L0.mesh_get_dwb_status
  L7 = L7()
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = L3.getAllWifiInfo
  L7 = L7()
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "status"
  L8 = L8(L9)
  if L7 and L5 then
    L9 = #L7
    if L5 <= L9 and L8 then
      L9 = tonumber
      L10 = L8
      L9 = L9(L10)
      L8 = L9
      L9 = 2
      if L5 == 3 then
        L9 = 2
      elseif L5 == 2 then
        L9 = 3
      end
      L10 = tonumber
      L11 = L0.mesh_get_dwb_bsd_channge
      L11 = L11()
      L11 = L11 or L11
      L10 = L10(L11)
      if L8 == 1 and L6 ~= 1 then
        if L10 == 1 then
          L11 = nil
          L12 = L7[L9]
          L12 = L12.ssid
          L12 = #L12
          if 28 < L12 then
            L12 = L7[L9]
            L11 = L12.ssid
          else
            L12 = string
            L12 = L12.sub
            L13 = L7[L9]
            L13 = L13.ssid
            L14 = "_5G2"
            L13 = L13 .. L14
            L14 = 1
            L15 = 31
            L12 = L12(L13, L14, L15)
            L11 = L12
          end
          L12 = L3.setWifiBasicInfo
          L13 = L5
          L14 = L11
          L15 = L7[L9]
          L15 = L15.password
          L16 = L7[L9]
          L16 = L16.encryption
          L17, L18, L19 = nil, nil, nil
          L20 = L8
          L21 = nil
          L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21)
          L2 = L12
        else
          L11 = L3.setWifiBasicInfo
          L12 = L5
          L13 = nil
          L14 = L7[L9]
          L14 = L14.password
          L15 = L7[L9]
          L15 = L15.encryption
          L16, L17, L18 = nil, nil, nil
          L19 = L8
          L20 = nil
          L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20)
          L2 = L11
        end
        if L2 == true then
          L11 = L0.mesh_set_dwb_status
          L12 = "1"
          L11(L12)
          L1.code = 0
        end
      elseif L8 == 0 and L6 == 1 then
        L11 = L3.setWifiBasicInfo
        L12 = L5
        L13, L14, L15 = nil, nil, nil
        L16 = "0"
        L17 = "max"
        L18 = nil
        L19 = L8
        L20 = "0"
        L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20)
        L2 = L11
        if L2 == true then
          L11 = L7[L5]
          L11 = L11.status
          if L11 == 0 then
            L11 = L0.mesh_set_dwb_status
            L12 = "2"
            L11(L12)
          else
            L11 = L0.mesh_set_dwb_status
            L12 = "0"
            L11(L12)
          end
          L1.code = 0
        end
      else
        L1.code = 0
      end
    end
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L1
  L9(L10)
  L9 = _UPVALUE0_
  L9 = L9.close
  L9()
  if L2 then
    L9 = L4.forkRestartWifiNotify
    L9()
  end
end
setDWBWifi = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = L1.getBandwidth
  L2, L3 = L2()
  L4 = L1.getWeight
  L4, L5 = L4()
  L6 = {}
  L6.code = 0
  L7 = {}
  L6.info = L7
  L7 = L6.info
  L8 = L1.getStatus
  L8 = L8()
  L7.enable = L8
  L7 = L6.info
  L8 = L1.getPolicy
  L8 = L8()
  L7.policy = L8
  L7 = L6.info
  L8 = L1.getCurrentWan
  L9 = "ipv4"
  L8 = L8(L9)
  L8 = L8 or L8
  L7.currwan = L8
  L7 = L6.info
  L7.weight1 = L4
  L7 = L6.info
  L7.weight2 = L5
  L7 = L6.info
  L7.bandwidth_wan1 = L2
  L7 = L6.info
  L7.bandwidth_wan2 = L3
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
end
getMultiwanBasicInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2 = L2(L3)
  L3 = L1.getStatus
  L3 = L3()
  L4 = {}
  L4.code = 0
  L5 = L0.isStrNil
  L6 = L2
  L5 = L5(L6)
  if L5 then
    L4.code = 1502
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L4.code
    L5 = L5(L6)
    L4.msg = L5
  else
    L5 = tostring
    L6 = L2
    L5 = L5(L6)
    L6 = tostring
    L7 = L3
    L6 = L6(L7)
    if L5 ~= L6 then
      L5 = L1.setStatus
      L6 = L2
      L5(L6)
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
setMultiwanEnable = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "policy"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L1.isValidPolicyCode
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L3.code = 1502
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L3.code
    L4 = L4(L5)
    L3.msg = L4
  else
    L4 = L1.setPolicy
    L5 = L2
    L4(L5)
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
setMultiwanPolicy = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bandwidth_wan1"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "bandwidth_wan2"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = L0.isStrNil
  L6 = L2
  L5 = L5(L6)
  if not L5 then
    L5 = L0.isStrNil
    L6 = L3
    L5 = L5(L6)
    if not L5 then
      goto lbl_34
    end
  end
  L4.code = 1502
  L5 = _UPVALUE1_
  L5 = L5.getErrorMessage
  L6 = L4.code
  L5 = L5(L6)
  L4.msg = L5
  goto lbl_38
  ::lbl_34::
  L5 = L1.setWeight
  L6 = L2
  L7 = L3
  L5(L6, L7)
  ::lbl_38::
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
setMultiwanWeight = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wan"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "oname"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "manual"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "opt"
  L7 = L7(L8)
  L8 = nil
  L9 = {}
  L9.code = 0
  L10 = L0.isStrNil
  L11 = L3
  L10 = L10(L11)
  if not L10 then
    L10 = L0.isStrNil
    L11 = L7
    L10 = L10(L11)
    if not L10 then
      L10 = L0.isStrNil
      L11 = L6
      L10 = L10(L11)
      if not L10 then
        L10 = L1.isValidWanName
        L11 = L4
        L10 = L10(L11)
        if L10 then
          goto lbl_60
        end
      end
    end
  end
  L9.code = 1502
  L10 = _UPVALUE1_
  L10 = L10.getErrorMessage
  L11 = L9.code
  L10 = L10(L11)
  L9.msg = L10
  goto lbl_204
  ::lbl_60::
  L10 = require
  L11 = "json"
  L10 = L10(L11)
  L11 = L2.exec
  L12 = "ubus call trafficd hw"
  L11 = L11(L12)
  L12 = L10.decode
  L12 = L12(L13)
  L11 = L12
  L12 = L3.upper
  L12 = L12(L13)
  L3 = L12
  if L6 == "0" then
    L12 = L2.split
    L12 = L12(L13, L14)
    for L16 = L13, L14, L15 do
      L17 = L12[L16]
      if nil ~= L17 then
        if L7 == "0" or L7 == 0 then
          L8 = nil
          L17 = L12[L16]
          L17 = L11[L17]
          if L17 then
            L17 = L12[L16]
            L17 = L11[L17]
            L17 = L17.ip_list
            if L17 then
              L17 = L12[L16]
              L17 = L11[L17]
              L17 = L17.ip_list
              L17 = L17[1]
              if L17 then
                L17 = L12[L16]
                L17 = L11[L17]
                L17 = L17.ip_list
                L17 = L17[1]
                L17 = L17.ip
                if L17 then
                  L17 = L12[L16]
                  L17 = L11[L17]
                  L17 = L17.ip_list
                  L17 = L17[1]
                  L8 = L17.ip
                end
              end
            end
          end
          L17 = L12[L16]
          L17 = L11[L17]
          if L17 then
            L17 = L12[L16]
            L17 = L11[L17]
            L17 = L17.hw
            if L17 then
              L17 = L12[L16]
              L17 = L11[L17]
              L17 = L17.hostname
              if L17 then
                L17 = L12[L16]
                L17 = L11[L17]
                L5 = L17.hostname
              end
            end
          end
          if L5 == "" then
            L5 = "unknown"
          end
          L17 = L1.setDevPolicy
          L18 = L12[L16]
          L19 = L8
          L20 = "ipv4"
          L21 = L5
          L22 = L4
          L23 = L6
          L17(L18, L19, L20, L21, L22, L23)
        else
          L17 = L1.deleteDevPolicy
          L18 = L12[L16]
          L17(L18)
        end
      end
    end
  elseif L6 == "1" then
    if L7 == "0" or L7 == 0 then
      L12 = L0.isStrNil
      L12 = L12(L13)
      if L12 then
        L9.code = 1502
        L12 = _UPVALUE1_
        L12 = L12.getErrorMessage
        L12 = L12(L13)
        L9.msg = L12
      else
        L12 = L11[L3]
        if L12 then
          L12 = L11[L3]
          L12 = L12.ip_list
          if L12 then
            L12 = L11[L3]
            L12 = L12.ip_list
            L12 = L12[1]
            if L12 then
              L12 = L11[L3]
              L12 = L12.ip_list
              L12 = L12[1]
              L12 = L12.ip
              if L12 then
                L12 = L11[L3]
                L12 = L12.ip_list
                L12 = L12[1]
                L8 = L12.ip
              end
            end
          end
        end
        L12 = L1.setDevPolicy
        L16 = L5
        L17 = L4
        L18 = L6
        L12(L13, L14, L15, L16, L17, L18)
      end
    else
      L12 = L1.deleteDevPolicy
      L12(L13)
    end
  end
  ::lbl_204::
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L9
  L10(L11)
end
setMultiwanDevPolicy = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQMultiWanPolicy"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L1.info = L2
  L2 = L1.info
  L3 = L0.getAllDevPolicies
  L3 = L3()
  L2.dev_policies = L3
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getMultiwanDevPolicies = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQMultiWanPolicy"
  L1 = L1(L2)
  L2 = L0.getDeviceListV2
  L3 = true
  L4 = true
  L2 = L2(L3, L4)
  L3 = {}
  L4 = {}
  L4.code = 0
  L4.info = L5
  for L8, L9 in L5, L6, L7 do
    L10 = L1.isDevPolicyExist
    L11 = L9.mac
    L10 = L10(L11)
    if not L10 then
      L10 = {}
      L11 = L9.mac
      L10.mac = L11
      L11 = L9.oname
      L10.oname = L11
      L11 = L10.oname
      if L11 == "" then
        L10.oname = "unknown"
      end
      L11 = L9.ip
      if L11 then
        L11 = L9.ip
        L11 = L11[1]
        if L11 then
          L11 = L9.ip
          L11 = L11[1]
          L11 = L11.ip
          L10.ip = L11
        end
      end
      L11 = table
      L11 = L11.insert
      L12 = L3
      L13 = L10
      L11(L12, L13)
    end
  end
  L4.info = L3
  L5(L6)
end
getMultiwanDevList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCwmpUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "cwmp_enable"
  L5 = L5(L6)
  L4.cwmp_enable = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "cwmp_inform_enable"
  L5 = L5(L6)
  L4.cwmp_inform_enable = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "inform_interval"
  L5 = L5(L6)
  L4.inform_interval = L5
  L5 = L2.xssCheck
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "acs_url"
  L6, L7 = L6(L7)
  L5 = L5(L6, L7)
  L4.acs_url = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "acs_username"
  L5 = L5(L6)
  L4.acs_username = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "acs_password"
  L5 = L5(L6)
  L4.acs_password = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "wan_label"
  L5 = L5(L6)
  L4.wan_label = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "conn_request_auth"
  L5 = L5(L6)
  L4.conn_request_auth = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "conn_username"
  L5 = L5(L6)
  L4.conn_username = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "conn_password"
  L5 = L5(L6)
  L4.conn_password = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "conn_port"
  L5 = L5(L6)
  L5 = L5 or L5
  L4.conn_port = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "country"
  L5 = L5(L6)
  L5 = L5 or L5
  L4.country = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "isp"
  L5 = L5(L6)
  L5 = L5 or L5
  L4.isp = L5
  L5 = L4.cwmp_enable
  if L5 == "1" then
    L5 = L1.checkValue
    L6 = L4
    L5 = L5(L6)
    L3.code = L5
  end
  L5 = L3.code
  if L5 == 0 then
    L5 = L1.setCwmp
    L6 = L4
    L5 = L5(L6)
    L3.code = L5
  end
  L5 = L3.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L3.code
    L5 = L5(L6)
    L3.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
setCwmp = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCwmpUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "wan_label"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "country"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "isp"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = L1.getCwmpSec
  L6 = L2
  L7 = L3
  L8 = L4
  L5 = L5(L6, L7, L8)
  L6 = {}
  L6.code = 0
  L7 = L0.isStrNil
  L8 = L2
  L7 = L7(L8)
  if not L7 then
    L7 = L0.isStrNil
    L8 = L5
    L7 = L7(L8)
    if L7 then
      L6.code = 1502
      L7 = _UPVALUE1_
      L7 = L7.getErrorMessage
      L8 = L6.code
      L7 = L7(L8)
      L6.msg = L7
  end
  else
    L6.code = 0
    L7 = L1.getCwmpInfo
    L8 = L5
    L7 = L7(L8)
    L6.current = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
end
getCwmpInfo = L4
L4 = 4
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQBaiduPanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "json"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "userName"
  L8 = nil
  L9 = "numberstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "token"
  L9 = nil
  L10 = "commonstr"
  L7 = L7(L8, L9, L10)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "localDire"
  L10 = nil
  L11 = "json"
  L8 = L8(L9, L10, L11)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "remoteDire"
  L11 = nil
  L12 = "commonstr"
  L9 = L9(L10, L11, L12)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "level"
  L12 = nil
  L13 = "commonstr"
  L10 = L10(L11, L12, L13)
  L11 = require
  L12 = "xiaoqiang.XQStatPoints"
  L11 = L11(L12)
  L12 = L11.Log
  L13 = "storage.baidupan"
  L14 = "upload:1"
  L12(L13, L14)
  L12 = L2.isStrNil
  L13 = L7
  L12 = L12(L13)
  if not L12 then
    L12 = L2.isStrNil
    L13 = L8
    L12 = L12(L13)
    if not L12 then
      L12 = L2.isStrNil
      L13 = L9
      L12 = L12(L13)
      if not L12 then
        L12 = L2.isStrNil
        L13 = L10
        L12 = L12(L13)
        if not L12 then
          L12 = L2.isStrNil
          L13 = L6
          L12 = L12(L13)
          if not L12 then
            goto lbl_85
          end
        end
      end
    end
  end
  L0.code = 1502
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L0
  L12(L13)
  do return end
  ::lbl_85::
  L12 = L1.log
  L13 = _UPVALUE1_
  L14 = "BAIDUPAN setRouterToBaidu token "
  L15 = L7
  L16 = " local: "
  L17 = L8
  L18 = " remote: "
  L19 = L9
  L20 = " mode: "
  L21 = L10
  L22 = " username: "
  L23 = L6
  L14 = L14 .. L15 .. L16 .. L17 .. L18 .. L19 .. L20 .. L21 .. L22 .. L23
  L12(L13, L14)
  L12 = L3.setUserName
  L13 = L6
  L12(L13)
  L12 = L3.checkLocalFileName
  L13 = L8
  L12 = L12(L13)
  L8 = L12
  L12 = L3.checkFileFormat
  L13 = L8
  L12 = L12(L13)
  if not L12 then
    L13 = L3.BDPAN_ERROR_CODE
    L13 = L13.ERROR_DIR_OR_FILE_NAME_EXCEPT
    L0.code = L13
    L13 = _UPVALUE0_
    L13 = L13.write_json
    L14 = L0
    L13(L14)
    return
  end
  L13 = L3.getLocalPanDire
  L13 = L13()
  L14 = type
  L15 = L13
  L14 = L14(L15)
  if L14 == "number" then
    L0.code = L13
    L14 = _UPVALUE0_
    L14 = L14.write_json
    L15 = L0
    L14(L15)
    return
  end
  L14 = L5.decode
  L15 = L8
  L14 = L14(L15)
  L15 = L3.parsesLocalDire
  L16 = L14
  L17 = L10
  L15 = L15(L16, L17)
  L16 = type
  L17 = L15
  L16 = L16(L17)
  if L16 == "number" then
    L0.code = L15
    L16 = _UPVALUE0_
    L16 = L16.write_json
    L17 = L0
    L16(L17)
    return
  end
  L16 = {}
  L16.token = L7
  L16.remote_directory = L9
  L16.level = L10
  L16.directorys = L8
  L17 = L3.callUbus
  L18 = "upload"
  L19 = L16
  L17 = L17(L18, L19)
  L18 = L2.isStrNil
  L19 = L17
  L18 = L18(L19)
  if L18 then
    L18 = L3.BDPAN_ERROR_CODE
    L18 = L18.ERROR_UBUS_CALL_FAILED
    L0.code = L18
    L18 = _UPVALUE0_
    L18 = L18.write_json
    L19 = L0
    L18(L19)
    return
  end
  L18 = L17.code
  L0.code = L18
  L18 = _UPVALUE0_
  L18 = L18.write_json
  L19 = L0
  L18(L19)
end
setRouterToBaidu = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQBaiduPanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "json"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "token"
  L8 = nil
  L9 = "commonstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "userName"
  L9 = nil
  L10 = "numberstr"
  L7 = L7(L8, L9, L10)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "info"
  L10 = nil
  L11 = "json"
  L8 = L8(L9, L10, L11)
  L9 = require
  L10 = "xiaoqiang.XQStatPoints"
  L9 = L9(L10)
  L10 = L9.Log
  L11 = "storage.baidupan"
  L12 = "download:1"
  L10(L11, L12)
  if not (L6 and L8) or not L7 then
    L0.code = 1502
    L10 = _UPVALUE0_
    L10 = L10.write_json
    L11 = L0
    L10(L11)
    return
  end
  L10 = L1.log
  L11 = _UPVALUE1_
  L12 = "BAIDUPAN setBaiduToRouter token "
  L13 = L6
  L14 = " username: "
  L15 = L7
  L16 = " info: "
  L17 = L8
  L12 = L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L10(L11, L12)
  L10 = L2.setUserName
  L11 = L7
  L10(L11)
  L10 = L2.checkRemoteFileName
  L11 = L8
  L10 = L10(L11)
  L8 = L10
  L10 = L1.log
  L11 = _UPVALUE1_
  L12 = "BAIDUPAN setBaiduToRouter info: "
  L13 = L8
  L12 = L12 .. L13
  L10(L11, L12)
  L10 = L2.getLocalPanDire
  L10 = L10()
  L11 = type
  L12 = L10
  L11 = L11(L12)
  if L11 == "number" then
    L11 = dir_result
    L0.code = L11
    L11 = _UPVALUE0_
    L11 = L11.write_json
    L12 = L0
    L11(L12)
    return
  end
  L11 = L5.decode
  L12 = L8
  L11 = L11(L12)
  L12 = L2.parseDlink
  L13 = L11
  L12 = L12(L13)
  L13 = type
  L14 = L12
  L13 = L13(L14)
  if L13 == "number" then
    L13 = L2.BDPAN_ERROR_CODE
    L13 = L13.ERROR_UBUS_CALL_FAILED
    L0.code = L13
    L13 = _UPVALUE0_
    L13 = L13.write_json
    L14 = L0
    L13(L14)
    return
  end
  L13 = {}
  L13.token = L6
  L13.local_directory = L10
  L13.info = L8
  L14 = L2.callUbus
  L15 = "download"
  L16 = L13
  L14 = L14(L15, L16)
  L15 = L3.isStrNil
  L16 = L14
  L15 = L15(L16)
  if L15 then
    L15 = L2.BDPAN_ERROR_CODE
    L15 = L15.ERROR_UBUS_CALL_FAILED
    L0.code = L15
    L15 = _UPVALUE0_
    L15 = L15.write_json
    L16 = L0
    L15(L16)
    return
  end
  L15 = L14.code
  L0.code = L15
  L15 = _UPVALUE0_
  L15 = L15.write_json
  L16 = L0
  L15(L16)
end
setBaiduToRouter = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQBaiduPanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "userName"
  L7 = nil
  L8 = "commonstr"
  L5 = L5(L6, L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "actiontype"
  L8 = nil
  L9 = "commonstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "listtype"
  L9 = nil
  L10 = "commonstr"
  L7 = L7(L8, L9, L10)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "actionids"
  L10 = nil
  L11 = "json"
  L8 = L8(L9, L10, L11)
  L9 = require
  L10 = "luci.util"
  L9 = L9(L10)
  L10 = require
  L11 = "luci.model.uci"
  L10 = L10(L11)
  L10 = L10.cursor
  L10 = L10()
  L11 = L4.isStrNil
  L12 = L5
  L11 = L11(L12)
  if not L11 then
    L11 = L4.isStrNil
    L12 = L7
    L11 = L11(L12)
    if not L11 then
      L11 = L4.isStrNil
      L12 = L8
      L11 = L11(L12)
      if not L11 then
        L11 = L4.isStrNil
        L12 = L6
        L11 = L11(L12)
        if not L11 then
          goto lbl_72
        end
      end
    end
  end
  L0.code = 1502
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L0
  L11(L12)
  do return end
  ::lbl_72::
  L11 = L1.log
  L12 = _UPVALUE1_
  L13 = "BAIDUPAN deleteTransportList: "
  L14 = L5
  L15 = " listtype: "
  L16 = L7
  L17 = " actiontids: "
  L18 = L8
  L13 = L13 .. L14 .. L15 .. L16 .. L17 .. L18
  L11(L12, L13)
  L11 = L3.deleteTransportList
  L12 = L6
  L13 = L7
  L14 = L8
  L11(L12, L13, L14)
  L11 = {}
  L11.actiontype = L6
  L11.listtype = L7
  L11.actionid = L8
  L12 = L3.callUbus
  L13 = "deltranslistfile"
  L14 = L11
  L12(L13, L14)
  L0.code = 0
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L0
  L12(L13)
end
deleteTransportList = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = L3.isStrNil
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = L3.isStrNil
    L5 = A1
    L4 = L4(L5)
    if not L4 then
      goto lbl_19
    end
  end
  L4 = true
  do return L4 end
  ::lbl_19::
  L4 = L2.split
  L5 = A0
  L6 = ":"
  L4 = L4(L5, L6)
  L5 = tonumber
  L6 = L4[2]
  L5 = L5(L6)
  L6 = tonumber
  L7 = L4[5]
  L6 = L6(L7)
  L7 = L3.isStrNil
  L8 = L6
  L7 = L7(L8)
  if L7 then
    L6 = 2147483647
  end
  L7 = L2.split
  L8 = A1
  L9 = ":"
  L7 = L7(L8, L9)
  L8 = tonumber
  L9 = L7[2]
  L8 = L8(L9)
  L9 = tonumber
  L10 = L7[5]
  L9 = L9(L10)
  L10 = L3.isStrNil
  L11 = L9
  L10 = L10(L11)
  if L10 then
    L9 = 2147483647
  end
  L10 = L6 > L9
  return L10
end
time_cmp = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L5 = {}
  L6 = 10
  L7 = require
  L8 = "xiaoqiang.XQLog"
  L7 = L7(L8)
  L8 = require
  L9 = "json"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.module.XQBaiduPanUtil"
  L9 = L9(L10)
  L10 = require
  L11 = "xiaoqiang.common.XQFunction"
  L10 = L10(L11)
  L11 = require
  L12 = "luci.util"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "userName"
  L14 = nil
  L15 = "commonstr"
  L12 = L12(L13, L14, L15)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "listtype"
  L15 = nil
  L16 = "commonstr"
  L13 = L13(L14, L15, L16)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "listoffset"
  L16 = nil
  L17 = "commonstr"
  L14 = L14(L15, L16, L17)
  L15 = require
  L16 = "luci.model.uci"
  L15 = L15(L16)
  L15 = L15.cursor
  L15 = L15()
  L16 = {}
  L16.code = 0
  L16.downloadlist = ""
  L16.uploadlist = ""
  if not (L12 and L13) or not L14 then
    L16.code = 1502
    L17 = _UPVALUE0_
    L17 = L17.write_json
    L18 = L16
    L17(L18)
    return
  end
  L17 = L7.log
  L18 = _UPVALUE1_
  L19 = "BAIDUPAN getTransportList: "
  L20 = L12
  L21 = " mode: "
  L22 = L13
  L23 = " offset: "
  L24 = L14
  L19 = L19 .. L20 .. L21 .. L22 .. L23 .. L24
  L17(L18, L19)
  L18 = L15
  L17 = L15.get
  L19 = "baidupan"
  L20 = "user"
  L21 = "name"
  L17 = L17(L18, L19, L20, L21)
  L3 = L17
  L18 = L15
  L17 = L15.get
  L19 = "baidupan"
  L20 = "user"
  L21 = "localdir"
  L17 = L17(L18, L19, L20, L21)
  L4 = L17
  L17 = {}
  L17.listtype = L13
  L18 = L9.callUbus
  L19 = "gettranslist"
  L20 = L17
  L18 = L18(L19, L20)
  L19 = L10.isStrNil
  L20 = L18
  L19 = L19(L20)
  if L19 then
    L19 = L9.BDPAN_ERROR_CODE
    L19 = L19.ERROR_UBUS_CALL_FAILED
    L16.code = L19
    L19 = _UPVALUE0_
    L19 = L19.write_json
    L20 = L16
    L19(L20)
    return
  end
  if L13 and L13 == "uploadlist" then
    L19 = L8.decode
    L20 = L18.list
    L19 = L19(L20)
    L20 = table
    L20 = L20.sort
    L21 = L19
    L22 = time_cmp
    L20(L21, L22)
    L20 = L9.splitList
    L21 = L19
    L20 = L20(L21)
    L16.uploadlist = L20
  elseif L13 and L13 == "downloadlist" then
    L19 = L8.decode
    L20 = L18.list
    L19 = L19(L20)
    L20 = table
    L20 = L20.sort
    L21 = L19
    L22 = time_cmp
    L20(L21, L22)
    L20 = L9.splitList
    L21 = L19
    L20 = L20(L21)
    L16.downloadlist = L20
  else
    L19 = L7.log
    L20 = _UPVALUE1_
    L21 = "paramter error!"
    L19(L20, L21)
  end
  L16.username = L3
  L16.localdir = L4
  L19 = _UPVALUE0_
  L19 = L19.write_json
  L20 = L16
  L19(L20)
end
getTransportList = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQBaiduPanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "userName"
  L6 = nil
  L7 = "commonstr"
  L4 = L4(L5, L6, L7)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "actiontype"
  L7 = nil
  L8 = "commonstr"
  L5 = L5(L6, L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "listtype"
  L8 = nil
  L9 = "commonstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "actionid"
  L9 = nil
  L10 = "commonstr"
  L7 = L7(L8, L9, L10)
  L8 = require
  L9 = "luci.model.uci"
  L8 = L8(L9)
  L8 = L8.cursor
  L8 = L8()
  L9 = {}
  L9.code = 0
  L10 = L3.isStrNil
  L11 = L4
  L10 = L10(L11)
  if not L10 then
    L10 = L3.isStrNil
    L11 = L5
    L10 = L10(L11)
    if not L10 then
      L10 = L3.isStrNil
      L11 = L7
      L10 = L10(L11)
      if not L10 then
        goto lbl_65
      end
    end
  end
  L9.code = 1502
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L9
  L10(L11)
  do return end
  ::lbl_65::
  L10 = L1.log
  L11 = _UPVALUE1_
  L12 = "BAIDUPAN setBaidupanAction: "
  L13 = L4
  L14 = " actiontype: "
  L15 = L5
  L16 = " actionid: "
  L17 = L7
  L12 = L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L10(L11, L12)
  L10 = {}
  L10.actiontype = L5
  L10.listtype = L6
  L10.actionid = L7
  L11 = L2.callUbus
  L12 = "translistaction"
  L13 = L10
  L11(L12, L13)
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L9
  L11(L12)
end
setTransListAction = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQBaiduPanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "userName"
  L7 = nil
  L8 = "commonstr"
  L5 = L5(L6, L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "listtype"
  L8 = nil
  L9 = "commonstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "actionid"
  L9 = nil
  L10 = "commonstr"
  L7 = L7(L8, L9, L10)
  L8 = require
  L9 = "luci.model.uci"
  L8 = L8(L9)
  L8 = L8.cursor
  L8 = L8()
  L9 = {}
  L9.code = 0
  L10 = L4.isStrNil
  L11 = L5
  L10 = L10(L11)
  if not L10 then
    L10 = L4.isStrNil
    L11 = L6
    L10 = L10(L11)
    if not L10 then
      L10 = L4.isStrNil
      L11 = L7
      L10 = L10(L11)
      if not L10 then
        goto lbl_62
      end
    end
  end
  L9.code = 1502
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L9
  L10(L11)
  do return end
  ::lbl_62::
  L10 = {}
  L10.listtype = L6
  L10.actionid = L7
  L11 = L3.callUbus
  L12 = "transfilestat"
  L13 = L10
  L11 = L11(L12, L13)
  L12 = L4.isStrNil
  L13 = L11
  L12 = L12(L13)
  if L12 then
    L9.code = 1502
    L12 = _UPVALUE0_
    L12 = L12.write_json
    L13 = L9
    L12(L13)
    return
  end
  L12 = L11.percent
  L9.percentage = L12
  L12 = L11.speed
  L9.speed = L12
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L9
  L12(L13)
end
getTransListFileStat = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.module.XQBaiduPanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = require
  L5 = "json"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "userName"
  L7 = nil
  L8 = "commonstr"
  L5 = L5(L6, L7, L8)
  L6 = L2.isStrNil
  L7 = L5
  L6 = L6(L7)
  if L6 then
    L0.code = 1502
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L7 = L0
    L6(L7)
    return
  end
  L6 = {}
  L7 = L1.callUbus
  L8 = "gettranslistcount"
  L9 = L6
  L7 = L7(L8, L9)
  L8 = L2.isStrNil
  L9 = L7
  L8 = L8(L9)
  if L8 then
    L0.code = 1502
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L0
    L8(L9)
    return
  end
  L8 = L7.count
  L0.count = L8
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L0
  L8(L9)
end
getTransListCount = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQBaiduPanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "userName"
  L4 = nil
  L5 = "commonstr"
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "path"
  L5 = nil
  L6 = "commonstr"
  L3 = L3(L4, L5, L6)
  L4 = {}
  L4.code = 0
  L5 = L1.isStrNil
  L6 = L2
  L5 = L5(L6)
  if not L5 then
    L5 = L1.isStrNil
    L6 = L3
    L5 = L5(L6)
    if not L5 then
      goto lbl_37
    end
  end
  L4.code = 1502
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
  do return end
  ::lbl_37::
  L5 = L0.setBaidupanPath
  L6 = L3
  L5 = L5(L6)
  code = L5
  L5 = code
  L4.code = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
setBaiduPath = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQBaiduPanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "userName"
  L4 = nil
  L5 = "commonstr"
  L2 = L2(L3, L4, L5)
  L3 = {}
  L4 = {}
  L4.code = 0
  L4.path = ""
  L4.bindStatus = ""
  L5 = L1.isStrNil
  L6 = L2
  L5 = L5(L6)
  if L5 then
    L4.code = 1502
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L4
    L5(L6)
    return
  end
  L5 = L0.getBaidupanPath
  L5 = L5()
  L3 = L5
  L5 = L3.path
  L4.path = L5
  L5 = L3.bindStatus
  L4.bindStatus = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
getBaiduPath = L5
L5 = 6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQMiDockerUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mode"
  L5 = L5(L6)
  L7 = L4
  L6 = L4.get
  L8 = "mi_docker"
  L9 = "settings"
  L10 = "docker_enable"
  L6 = L6(L7, L8, L9, L10)
  L8 = L4
  L7 = L4.get
  L9 = "mi_docker"
  L10 = "settings"
  L11 = "docker_install"
  L7 = L7(L8, L9, L10, L11)
  L8 = L3.DOCKER_ERROR_CODE
  L9 = L2.isStrNil
  L10 = L5
  L9 = L9(L10)
  if L9 then
    L0.code = 1502
    L9 = _UPVALUE0_
    L9 = L9.write_json
    L10 = L0
    L9(L10)
    return
  end
  L9 = L1.log
  L10 = _UPVALUE1_
  L11 = "setMiDocker mode : "
  L12 = L5
  L13 = " enable: "
  L14 = L6
  L15 = " install: "
  L16 = L7
  L11 = L11 .. L12 .. L13 .. L14 .. L15 .. L16
  L9(L10, L11)
  if L7 and L7 == "0" then
    L9 = L3.getErrorInfo
    L10 = L8.ERROR_NOT_INSTALL_DOCKER
    L9 = L9(L10)
    L0 = L9
    L9 = _UPVALUE0_
    L9 = L9.write_json
    L10 = L0
    L9(L10)
    return
  end
  L9 = L1.log
  L10 = _UPVALUE1_
  L11 = "setMiDocker mode : "
  L12 = L5
  L11 = L11 .. L12
  L9(L10, L11)
  if L5 == "1" then
    if L6 and L6 == "0" then
      L9 = L3.start
      L9()
    end
  elseif L6 and L6 == "1" then
    L9 = L3.stop
    L9()
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L0
  L9(L10)
end
setMiDocker = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.module.XQStorage"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQMiDockerUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "mode"
  L8 = nil
  L9 = "numberstr"
  L6 = L6(L7, L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "uuid"
  L9 = nil
  L10 = "?commonstr"
  L7 = L7(L8, L9, L10)
  L9 = L5
  L8 = L5.get
  L10 = "mi_docker"
  L11 = "settings"
  L12 = "docker_install"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = L4.DOCKER_ERROR_CODE
  L10, L11 = nil, nil
  L12 = L3.isStrNil
  L13 = L6
  L12 = L12(L13)
  if not L12 then
    if L6 ~= "1" then
      goto lbl_60
    end
    L12 = L3.isStrNil
    L13 = L7
    L12 = L12(L13)
    if not L12 then
      goto lbl_60
    end
  end
  L0.code = 1502
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L0
  L12(L13)
  do return end
  ::lbl_60::
  L13 = L5
  L12 = L5.get
  L14 = "mi_docker"
  L15 = "settings"
  L16 = "device_uuid"
  L12 = L12(L13, L14, L15, L16)
  L12 = L12 or L12
  if L6 == "1" and L12 ~= L7 then
    L13 = L1.getStorageInfoByUuid
    L14 = L7
    L13 = L13(L14)
    L11 = L13
    if L11 then
      L13 = L11.type
      if L13 then
        L13 = L11.size
        if L13 then
          L14 = L5
          L13 = L5.set
          L15 = "mi_docker"
          L16 = "settings"
          L17 = "device_type"
          L18 = L11.type
          L19 = L18
          L18 = L18.upper
          L18, L19, L20, L21, L22 = L18(L19)
          L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
          L14 = L5
          L13 = L5.set
          L15 = "mi_docker"
          L16 = "settings"
          L17 = "device_size"
          L18 = tonumber
          L19 = L11.size
          L20 = L19
          L19 = L19.sub
          L21 = 1
          L22 = -7
          L19, L20, L21, L22 = L19(L20, L21, L22)
          L18 = L18(L19, L20, L21, L22)
          L18 = L18 / 2
          L13(L14, L15, L16, L17, L18)
        end
      end
    end
    L14 = L5
    L13 = L5.set
    L15 = "mi_docker"
    L16 = "settings"
    L17 = "device_uuid"
    L18 = L7
    L13(L14, L15, L16, L17, L18)
    L14 = L5
    L13 = L5.commit
    L15 = "mi_docker"
    L13(L14, L15)
  end
  if L6 == "1" then
    L13 = L4.checkEnv
    L13 = L13()
    L10 = L13
    if L10 == 1 then
      L13 = L4.getErrorInfo
      L14 = L9.ERROR_NOT_INSTALL_USB
      L13 = L13(L14)
      L0 = L13
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L0
      L13(L14)
      return
    elseif L10 == 2 then
      L13 = L4.getErrorInfo
      L14 = L9.ERROR_NOT_EXT4
      L13 = L13(L14)
      L0 = L13
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L0
      L13(L14)
      return
    elseif L10 == 3 then
      L13 = L4.getErrorInfo
      L14 = L9.ERROR_NOT_GREATER_32G
      L13 = L13(L14)
      L0 = L13
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L0
      L13(L14)
      return
    end
  end
  if L6 == "0" then
    L13 = L4.checkRunning
    L13 = L13()
    if L13 then
      L13 = L4.getErrorInfo
      L14 = L9.ERROR_NOW_RUNNING
      L13 = L13(L14)
      L0 = L13
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L0
      L13(L14)
      return
    end
  end
  if L6 == "1" then
    if L8 == "0" then
      L13 = L4.install
      L13()
    else
      L13 = L4.getErrorInfo
      L14 = L9.ERROR_DOCKER_ALREADY_INSTALL
      L13 = L13(L14)
      L0 = L13
    end
  else
    L13 = L4.uninstall
    L13()
    L14 = L5
    L13 = L5.set
    L15 = "mi_docker"
    L16 = "settings"
    L17 = "docker_enable"
    L18 = "0"
    L13(L14, L15, L16, L17, L18)
    L14 = L5
    L13 = L5.delete
    L15 = "mi_docker"
    L16 = "settings"
    L17 = "device_uuid"
    L13(L14, L15, L16, L17)
    L14 = L5
    L13 = L5.delete
    L15 = "mi_docker"
    L16 = "settings"
    L17 = "device_type"
    L13(L14, L15, L16, L17)
    L14 = L5
    L13 = L5.delete
    L15 = "mi_docker"
    L16 = "settings"
    L17 = "device_size"
    L13(L14, L15, L16, L17)
    L14 = L5
    L13 = L5.commit
    L15 = "mi_docker"
    L13(L14, L15)
  end
  L13 = _UPVALUE0_
  L13 = L13.write_json
  L14 = L0
  L13(L14)
end
setMiDockerEnv = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQMiDockerUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4 = L4(L5)
  L6 = L3
  L5 = L3.get
  L7 = "mi_docker"
  L8 = "settings"
  L9 = "docker_enable"
  L5 = L5(L6, L7, L8, L9)
  L7 = L3
  L6 = L3.get
  L8 = "mi_docker"
  L9 = "settings"
  L10 = "portainer_install"
  L6 = L6(L7, L8, L9, L10)
  L7 = L2.DOCKER_ERROR_CODE
  L8 = L1.isStrNil
  L9 = L4
  L8 = L8(L9)
  if L8 then
    L0.code = 1502
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L0
    L8(L9)
    return
  end
  if L5 and L5 == "0" then
    L8 = L2.getErrorInfo
    L9 = L7.ERROR_NOT_START_DOCKER
    L8 = L8(L9)
    L0 = L8
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L0
    L8(L9)
    return
  end
  if L4 == "1" and L6 == "1" then
    L8 = L2.getErrorInfo
    L9 = L7.ERROR_ALREADY_INSTALL
    L8 = L8(L9)
    L0 = L8
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L0
    L8(L9)
    return
  end
  if L4 == "1" and L6 and L6 == "0" then
    L8 = L2.installPortainer
    L8()
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L0
  L8(L9)
end
setPortainerEnv = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQMiDockerUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQLanWanUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = L3.DOCKER_ERROR_CODE
  L8 = L5
  L7 = L5.get
  L9 = "mi_docker"
  L10 = "settings"
  L11 = "docker_enable"
  L7 = L7(L8, L9, L10, L11)
  if L7 and L7 == "0" then
    L8 = L3.getErrorInfo
    L9 = L6.ERROR_NOT_START_DOCKER
    L8 = L8(L9)
    L0 = L8
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L0
    L8(L9)
    return
  end
  L8 = L4.getLanIp
  L8 = L8()
  L9 = L2.isStrNil
  L10 = L8
  L9 = L9(L10)
  if L9 then
    L9 = L3.getErrorInfo
    L10 = L6.ERROR_LAN_NOT_EXIST_IP
    L9 = L9(L10)
    L0 = L9
    L0.http = "error"
  else
    L9 = "http://"
    L10 = L8
    L11 = ":9001"
    L9 = L9 .. L10 .. L11
    L0.http = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L0
  L9(L10)
end
setPortainerManage = L6
function L6()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.module.XQMiDockerUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0.getInfo
  L2 = L2()
  L1(L2)
end
getDockerInfo = L6
function L6()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.module.XQMiDockerUtil"
  L0 = L0(L1)
  L1 = L0.cancelInstall
  L1()
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
setMiDockerCancel = L6
function L6()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.module.XQMiDockerUtil"
  L0 = L0(L1)
  L1 = L0.cancelInstallPortainer
  L1()
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
setPortainerCancel = L6
function L6()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.get_twt_hostap
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getTwt = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "on"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L0.set_twt_hostap
  L5 = L2
  L4 = L4(L5)
  L5 = flase
  if L4 == L5 then
    L3.code = 1537
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
  L5 = _UPVALUE0_
  L5 = L5.close
  L5()
  L5 = L1.forkRestartWifiNotify
  L5()
end
setTwt = L6
function L6()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L1.ipv4 = L2
  L2 = {}
  L1.ipv6 = L2
  L2 = L0.getLanStatus
  L2 = L2()
  L1.ipv4 = L2
  L2 = L0.getLanV6Status
  L2 = L2()
  L1.ipv6 = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getBridgeLanStatus = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "on"
  L1, L2, L3, L4, L5, L6, L7, L8, L9 = L1(L2)
  L0 = L0(L1, L2, L3, L4, L5, L6, L7, L8, L9)
  if L0 == 1 then
    L0 = "1"
    if L0 then
      goto lbl_13
    end
  end
  L0 = "0"
  ::lbl_13::
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L5 = L1
  L4 = L1.set
  L6 = "wireless"
  L7 = "wifi0"
  L8 = "disabled"
  L9 = L0
  L4(L5, L6, L7, L8, L9)
  L5 = L1
  L4 = L1.set
  L6 = "wireless"
  L7 = "wifi1"
  L8 = "disabled"
  L9 = L0
  L4(L5, L6, L7, L8, L9)
  L5 = L1
  L4 = L1.set
  L6 = "wireless"
  L7 = "wifi2"
  L8 = "disabled"
  L9 = L0
  L4(L5, L6, L7, L8, L9)
  L5 = L1
  L4 = L1.commit
  L6 = "wireless"
  L4(L5, L6)
  L4 = os
  L4 = L4.execute
  L5 = "echo "
  L6 = L0
  L7 = " > /tmp/wifi_silence"
  L5 = L5 .. L6 .. L7
  L4(L5)
  L4 = L2.forkExec
  L5 = "/sbin/wifi"
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
setWifiSilence = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.code = 0
  L0.on = 0
  L1 = io
  L1 = L1.popen
  L2 = "cat /tmp/wifi_silence 2>/dev/null"
  L1 = L1(L2)
  L2 = string
  L2 = L2.trim
  L4 = L1
  L3 = L1.read
  L5 = "*all"
  L3, L4, L5 = L3(L4, L5)
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  L4 = L1
  L3 = L1.close
  L3(L4)
  L3 = tonumber
  L4 = L2
  L3 = L3(L4)
  L0.on = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
getWifiSilence = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "on"
  L3 = L3(L4)
  L3 = L3 or L3
  if L3 ~= "1" and L3 ~= "0" then
    L4 = L0.log
    L5 = 6
    L6 = "Gateway Security switch is:"
    L7 = L3
    L6 = L6 .. L7
    L4(L5, L6)
    L2.code = 1537
  else
    L5 = L1
    L4 = L1.set
    L6 = "local_gw_security"
    L7 = "settings"
    L8 = "enabled"
    L9 = L3
    L4(L5, L6, L7, L8, L9)
    L5 = L1
    L4 = L1.commit
    L6 = "local_gw_security"
    L4(L5, L6)
    L4 = os
    L4 = L4.execute
    L5 = "/etc/init.d/local_gw_security restart"
    L4(L5)
  end
  L4 = L2.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2.code
    L4 = L4(L5)
    L2.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setGwSecurity = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.msg = "success"
  L4 = L1
  L3 = L1.get
  L5 = "local_gw_security"
  L6 = "settings"
  L7 = "enabled"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2.enable = L3
  L3 = L2.code
  if L3 ~= 0 then
    L3 = _UPVALUE0_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
  end
  L3 = _UPVALUE1_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getGwSecurity = L6
