local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = module
L1 = "luci.controller.api.misystem"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = node
  L1 = "api"
  L2 = "xqsystem"
  L0 = L0(L1, L2)
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L2 = firstchild
  L2 = L2()
  L0.target = L2
  L0.title = ""
  L0.order = 100
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L3[1] = L4
  L3[2] = L5
  L4 = firstchild
  L4 = L4()
  L5 = ""
  L6 = 100
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "mainStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 101
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "devicelist"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceList"
  L4 = L4(L5)
  L5 = ""
  L6 = 102
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "device_list"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceSrvList"
  L4 = L4(L5)
  L5 = ""
  L6 = 102
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "messages"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMessages"
  L4 = L4(L5)
  L5 = ""
  L6 = 103
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "router_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRouterBaseInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "feature_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRouterFeatureInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_log"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setConfigLog"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "check_ip_conflict"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "checkIpConflict"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_config_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getConfigResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "router_name"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRouterName"
  L4 = L4(L5)
  L5 = ""
  L6 = 104
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_name"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setRouterName"
  L4 = L4(L5)
  L5 = ""
  L6 = 105
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_wifiap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiApMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_lanap"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLanApMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_normal"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setRouterInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_wifiap_init"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiApMode_Init"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_router_lanap_init"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLanApMode_Init"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_wan"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWan"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "pppoe_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPPPoEStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "pppoe_stop"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pppoeStop"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "ota"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getOTAInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 108
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_ota"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setOTAInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 109
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "device_detail"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceDetail"
  L4 = L4(L5)
  L5 = ""
  L6 = 110
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "device_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 111
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "channel_scan_start"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "channelScanStart"
  L4 = L4(L5)
  L5 = ""
  L6 = 111
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "channel_scan_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getScanResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 112
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_channel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setChannel"
  L4 = L4(L5)
  L5 = ""
  L6 = 113
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "topo_graph"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getTopoGraph"
  L4 = L4(L5)
  L5 = ""
  L6 = 114
  L7 = 13
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "child_mesh_infos"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getChildMeshInfos"
  L4 = L4(L5)
  L5 = ""
  L6 = 114
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "bandwidth_test"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "bandwidthTest"
  L4 = L4(L5)
  L5 = ""
  L6 = 115
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "router_common_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRouterStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 116
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getQosInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 117
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_dev_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMACQoSInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 117
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_set_dev_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setMACQoSInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 117
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 118
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 119
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_limit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 120
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_limit_flag"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosLimitFlag"
  L4 = L4(L5)
  L5 = ""
  L6 = 120
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_limits"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosLimits"
  L4 = L4(L5)
  L5 = ""
  L6 = 121
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_offlimit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosOffLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 122
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_band"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setBand"
  L4 = L4(L5)
  L5 = ""
  L6 = 123
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_info_new"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getQos"
  L4 = L4(L5)
  L5 = ""
  L6 = 124
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_guest"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosGuest"
  L4 = L4(L5)
  L5 = ""
  L6 = 124
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_xq"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosXQ"
  L4 = L4(L5)
  L5 = ""
  L6 = 124
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "active"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "active"
  L4 = L4(L5)
  L5 = ""
  L6 = 125
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiskinfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 126
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "io_data"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIOData"
  L4 = L4(L5)
  L5 = ""
  L6 = 127
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_check"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskCheck"
  L4 = L4(L5)
  L5 = ""
  L6 = 128
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "check_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskCheckStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 129
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_repair"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskRepair"
  L4 = L4(L5)
  L5 = ""
  L6 = 130
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "repair_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskRepairStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 131
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_init"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskInit"
  L4 = L4(L5)
  L5 = ""
  L6 = 131
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_format"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskFormat"
  L4 = L4(L5)
  L5 = ""
  L6 = 131
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_format_async"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskFormatAsync"
  L4 = L4(L5)
  L5 = ""
  L6 = 132
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_format_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskFormatStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 133
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 133
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "disk_smartctl"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskSmartCtl"
  L4 = L4(L5)
  L5 = ""
  L6 = 133
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "sys_log"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "backupSysLog"
  L4 = L4(L5)
  L5 = ""
  L6 = 132
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "log_upload"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "syslogUpload"
  L4 = L4(L5)
  L5 = ""
  L6 = 133
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "register"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "register"
  L4 = L4(L5)
  L5 = ""
  L6 = 134
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "speed_test"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "speedTest"
  L4 = L4(L5)
  L5 = ""
  L6 = 135
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "speed_test_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "speedTestResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 136
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAntiRubNetworkStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 137
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setAntiRubNetwork"
  L4 = L4(L5)
  L5 = ""
  L6 = 138
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_records"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAntiRubNetworkRecords"
  L4 = L4(L5)
  L5 = ""
  L6 = 139
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_ignore"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setAntiRubNetworkIgnore"
  L4 = L4(L5)
  L5 = ""
  L6 = 140
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "debug"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "debug"
  L4 = L4(L5)
  L5 = ""
  L6 = 141
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "password"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "changePassword"
  L4 = L4(L5)
  L5 = ""
  L6 = 142
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "ecos_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getEcosInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 143
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "ecos_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ecosSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 144
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "ecos_upgrade"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ecosUpgrade"
  L4 = L4(L5)
  L5 = ""
  L6 = 145
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "ecos_upgrade_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getEcosUpgradeStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 146
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "hwnat_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "hwnatStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 147
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "hwnat_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "hwnatSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 148
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "http_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "httpStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 149
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "http_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "httpSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 150
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "lsusb"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "lsusb"
  L4 = L4(L5)
  L5 = ""
  L6 = 150
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "c_backup"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "cBackup"
  L4 = L4(L5)
  L5 = ""
  L6 = 152
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "c_download"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "cDownload"
  L4 = L4(L5)
  L5 = ""
  L6 = 152
  L2 = L2(L3, L4, L5, L6)
  L2.leaf = true
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "c_upload"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "cUpload"
  L4 = L4(L5)
  L5 = ""
  L6 = 153
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "c_restore"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "cRestore"
  L4 = L4(L5)
  L5 = ""
  L6 = 154
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "r_ip_conflict"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "rIpConflict"
  L4 = L4(L5)
  L5 = ""
  L6 = 155
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "tb_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "toolbarInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 156
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "vas_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getVasInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 157
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "vas_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVasInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 158
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "netacctl_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "networkAccessControlStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 159
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "netacctl_set"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "networkAccessControlSet"
  L4 = L4(L5)
  L5 = ""
  L6 = 159
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_add"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlAdd"
  L4 = L4(L5)
  L5 = ""
  L6 = 159
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_update"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlUpdate"
  L4 = L4(L5)
  L5 = ""
  L6 = 160
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_delete"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlDelete"
  L4 = L4(L5)
  L5 = ""
  L6 = 161
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_get_filter"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlgetUrlFilter"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_set_filter"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlSetUrlFilter"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_set_url"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlSetUrl"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "parctl_get_url"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "parentalctlGetUrl"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "iperf"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "iperf"
  L4 = L4(L5)
  L5 = ""
  L6 = 163
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "web_access_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWebAccessInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 164
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "web_access_opt"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "webAccess"
  L4 = L4(L5)
  L5 = ""
  L6 = 165
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "smartvpn_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getSmartVPNInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 166
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "smartvpn_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setSmartVPN"
  L4 = L4(L5)
  L5 = ""
  L6 = 167
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "smartvpn_url"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setSmartVPNUrl"
  L4 = L4(L5)
  L5 = ""
  L6 = 168
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "smartvpn_mac"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setSmartVPNMac"
  L4 = L4(L5)
  L5 = ""
  L6 = 169
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "mi_vpn"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "miVPN"
  L4 = L4(L5)
  L5 = ""
  L6 = 170
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "mi_vpn_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "miVPNInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 171
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "sys_time"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getSysTime"
  L4 = L4(L5)
  L5 = ""
  L6 = 172
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_sys_time"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setSysTime"
  L4 = L4(L5)
  L5 = ""
  L6 = 173
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "miwifi"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "isMiWiFi"
  L4 = L4(L5)
  L5 = ""
  L6 = 175
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_app_entry"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosApp"
  L4 = L4(L5)
  L5 = ""
  L6 = 176
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_security"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "arnSecurity"
  L4 = L4(L5)
  L5 = ""
  L6 = 177
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "arn_security_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "arnSecuritySwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 178
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_dev_bsd"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDevBsdInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 179
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_dev_bsd"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDevBsdInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 180
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "conf_upload_enable"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "confUploadEnable"
  L4 = L4(L5)
  L5 = ""
  L6 = 181
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "vas_info_new"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getVasInfoNew"
  L4 = L4(L5)
  L5 = ""
  L6 = 182
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "vas_switch_new"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVasInfoNew"
  L4 = L4(L5)
  L5 = ""
  L6 = 183
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "usb_u3"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setUsbMode3"
  L4 = L4(L5)
  L5 = ""
  L6 = 184
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_usb_u3"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getUsbMode3"
  L4 = L4(L5)
  L5 = ""
  L6 = 185
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "usb_u2"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setUsbMode2"
  L4 = L4(L5)
  L5 = ""
  L6 = 186
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_usb_u2"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getUsbMode2"
  L4 = L4(L5)
  L5 = ""
  L6 = 187
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_elink"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setElink"
  L4 = L4(L5)
  L5 = ""
  L6 = 192
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_elink"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getElink"
  L4 = L4(L5)
  L5 = ""
  L6 = 193
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "app_status_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ustackSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 194
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_get_cfg"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetGetConfig"
  L4 = L4(L5)
  L5 = ""
  L6 = 195
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_set_cfg"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetSetConfig"
  L4 = L4(L5)
  L5 = ""
  L6 = 196
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_list_dev"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetListDevice"
  L4 = L4(L5)
  L5 = ""
  L6 = 197
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_grant_dev"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetGrantDevice"
  L4 = L4(L5)
  L5 = ""
  L6 = 198
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_get_state"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetGetState"
  L4 = L4(L5)
  L5 = ""
  L6 = 199
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "minet_ctrl_state"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "minetCtrlState"
  L4 = L4(L5)
  L5 = ""
  L6 = 200
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "mem_test_cfg"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "memTestConfig"
  L4 = L4(L5)
  L5 = ""
  L6 = 201
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "mem_test_res"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "memTestResGet"
  L4 = L4(L5)
  L5 = ""
  L6 = 202
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "qos_wangzhe"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "qosWangZhe"
  L4 = L4(L5)
  L5 = ""
  L6 = 203
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_wifi_pwd"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiPwd"
  L4 = L4(L5)
  L5 = ""
  L6 = 212
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_wifi_pwd_url"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiPwdUrl"
  L4 = L4(L5)
  L5 = ""
  L6 = 213
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "flash_test_cfg"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "flashTestConfig"
  L4 = L4(L5)
  L5 = ""
  L6 = 214
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "flash_test_res"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "flashTestResGet"
  L4 = L4(L5)
  L5 = ""
  L6 = 215
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "newstatus"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "newmainStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 216
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "start_portscan"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "startPortScan"
  L4 = L4(L5)
  L5 = ""
  L6 = 217
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "start_weakdetect"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "startWeakDetect"
  L4 = L4(L5)
  L5 = ""
  L6 = 218
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_portscan_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPortScanResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 219
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_weakdetect_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWeakDetectResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 220
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_config_iotdev"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setConfigIotDev"
  L4 = L4(L5)
  L5 = ""
  L6 = 221
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_unconfig_iotdev"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getunConfigIotDev"
  L4 = L4(L5)
  L5 = ""
  L6 = 222
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "net_diagnose_start"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "netDiagnoseStart"
  L4 = L4(L5)
  L5 = ""
  L6 = 223
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "net_diagnose_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "netDiagnoseResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 224
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_netwan_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getNetWanMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 225
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_iotdev_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIotDevStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 226
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_config_iotdev_hidessid"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setConfigIotDevHidessid"
  L4 = L4(L5)
  L5 = ""
  L6 = 227
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_unconfig_iotdev_hidessid"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getunConfigIotDevHidessid"
  L4 = L4(L5)
  L5 = ""
  L6 = 228
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_iotdev_status_hidessid"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIotDevStatusHidessid"
  L4 = L4(L5)
  L5 = ""
  L6 = 229
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_location"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLocation"
  L4 = L4(L5)
  L5 = ""
  L6 = 227
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_location"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLocation"
  L4 = L4(L5)
  L5 = ""
  L6 = 228
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_languages"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLangList"
  L4 = L4(L5)
  L5 = ""
  L6 = 229
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_main_language"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMainLang"
  L4 = L4(L5)
  L5 = ""
  L6 = 230
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_language"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLang"
  L4 = L4(L5)
  L5 = ""
  L6 = 231
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_iptv"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVlanService"
  L4 = L4(L5)
  L5 = ""
  L6 = 320
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_iptv"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getVlanInternet"
  L4 = L4(L5)
  L5 = ""
  L6 = 321
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_vlan_iptv"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVlanService"
  L4 = L4(L5)
  L5 = ""
  L6 = 322
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_vlan_iptv"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getVlanIPTV"
  L4 = L4(L5)
  L5 = ""
  L6 = 323
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_ps_service"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPSService"
  L4 = L4(L5)
  L5 = ""
  L6 = 324
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_ps_service"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPSService"
  L4 = L4(L5)
  L5 = ""
  L6 = 325
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "get_ps_map"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPSMap"
  L4 = L4(L5)
  L5 = ""
  L6 = 326
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "set_wan_no_remind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWanNoRemind"
  L4 = L4(L5)
  L5 = ""
  L6 = 327
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "misystem"
  L6 = "query_wan_no_remind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWanNoRemind"
  L4 = L4(L5)
  L5 = ""
  L6 = 327
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = "apps"
  L2 = L1[L2]
  L3 = "mipctlv2"
  L2 = L2[L3]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "mipctlv2"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_user_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlUserList"
      L4 = L4(L5)
      L5 = ""
      L6 = 324
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_device_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlDev"
      L4 = L4(L5)
      L5 = ""
      L6 = 325
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_deny_time"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlDenyTime"
      L4 = L4(L5)
      L5 = ""
      L6 = 326
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_app_antiaddict"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlApp"
      L4 = L4(L5)
      L5 = ""
      L6 = 327
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_filting_net"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlBanHost"
      L4 = L4(L5)
      L5 = ""
      L6 = 328
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_temp_deny"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlTempBan"
      L4 = L4(L5)
      L5 = ""
      L6 = 329
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_user_stats"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlUserStats"
      L4 = L4(L5)
      L5 = ""
      L6 = 330
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_set"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setPctl"
      L4 = L4(L5)
      L5 = ""
      L6 = 331
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_get_dpi_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getPctlDPIInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 332
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_dump_arg"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "pctlDumpArg"
      L4 = L4(L5)
      L5 = ""
      L6 = 333
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_dump_json"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "pctlDumpJson"
      L4 = L4(L5)
      L5 = ""
      L6 = 334
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "mipctl_dump_cfg"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "pctlDumpCfg"
      L4 = L4(L5)
      L5 = ""
      L6 = 335
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "LED_control"
    L2 = L2[L3]
    if L2 then
      L2 = require
      L3 = "bit"
      L2 = L2(L3)
      L3 = "band"
      L2 = L2[L3]
      L3 = "apps"
      L3 = L1[L3]
      L4 = "LED_control"
      L3 = L3[L4]
      L4 = 1
      L2 = L2(L3, L4)
      L3 = 0
      if L2 ~= L3 then
        L2 = entry
        L3 = {}
        L4 = "api"
        L5 = "misystem"
        L6 = "led"
        L3[1] = L4
        L3[2] = L5
        L3[3] = L6
        L4 = call
        L5 = "ledCtl"
        L4 = L4(L5)
        L5 = ""
        L6 = 174
        L2(L3, L4, L5, L6)
      end
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "LED_control"
    L2 = L2[L3]
    if L2 then
      L2 = require
      L3 = "bit"
      L2 = L2(L3)
      L3 = "band"
      L2 = L2[L3]
      L3 = "apps"
      L3 = L1[L3]
      L4 = "LED_control"
      L3 = L3[L4]
      L4 = 2
      L2 = L2(L3, L4)
      L3 = 0
      if L2 ~= L3 then
        L2 = entry
        L3 = {}
        L4 = "api"
        L5 = "misystem"
        L6 = "ethled"
        L3[1] = L4
        L3[2] = L5
        L3[3] = L6
        L4 = call
        L5 = "DoEthLED"
        L4 = L4(L5)
        L5 = ""
        L6 = 337
        L2(L3, L4, L5, L6)
      end
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "LED_control"
    L2 = L2[L3]
    if L2 then
      L2 = require
      L3 = "bit"
      L2 = L2(L3)
      L3 = "band"
      L2 = L2[L3]
      L3 = "apps"
      L3 = L1[L3]
      L4 = "LED_control"
      L3 = L3[L4]
      L4 = 4
      L2 = L2(L3, L4)
      L3 = 0
      if L2 ~= L3 then
        L2 = entry
        L3 = {}
        L4 = "api"
        L5 = "misystem"
        L6 = "effect_light"
        L3[1] = L4
        L3[2] = L5
        L3[3] = L6
        L4 = call
        L5 = "DoEffectLED"
        L4 = L4(L5)
        L5 = ""
        L6 = 336
        L2(L3, L4, L5, L6)
      end
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "LED_control"
    L2 = L2[L3]
    L3 = "0"
    if L2 ~= L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "allled"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "DoAllLED"
      L4 = L4(L5)
      L5 = ""
      L6 = 338
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "temp_control"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "get_temp_control"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "GetTempCtrl"
      L4 = L4(L5)
      L5 = ""
      L6 = 340
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "set_temp_control"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "SetTempCtrl"
      L4 = L4(L5)
      L5 = ""
      L6 = 341
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  L3 = "storage"
  L2 = L2[L3]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "storage"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "get_storage_device_list"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getStorageDeviceList"
      L4 = L4(L5)
      L5 = ""
      L6 = 360
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "umount_storage_devices"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "umountStorageDevices"
      L4 = L4(L5)
      L5 = ""
      L6 = 361
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "umount_all_storage_device"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "umountAllStorageDevices"
      L4 = L4(L5)
      L5 = ""
      L6 = 362
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  L3 = "samba"
  L2 = L2[L3]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "samba"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "get_samba_status"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getSambaStatus"
      L4 = L4(L5)
      L5 = ""
      L6 = 363
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "set_samba_status"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setSambaStatus"
      L4 = L4(L5)
      L5 = ""
      L6 = 364
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  L3 = "swapmask"
  L2 = L2[L3]
  if L2 then
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "misystem"
    L6 = "set_swap_info"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "setSwapInfo"
    L4 = L4(L5)
    L5 = ""
    L6 = 365
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "misystem"
    L6 = "get_swap_info"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "getSwapInfo"
    L4 = L4(L5)
    L5 = ""
    L6 = 366
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "misystem"
    L6 = "del_swap"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "delSwap"
    L4 = L4(L5)
    L5 = ""
    L6 = 367
    L2(L3, L4, L5, L6)
  end
  L2 = "apps"
  L2 = L1[L2]
  L3 = "timemachine"
  L2 = L2[L3]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "timemachine"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "set_timemachine_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setTimeMachineInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 368
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "get_timemachine_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getTimeMachineInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 369
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "apps"
  L2 = L1[L2]
  L3 = "download"
  L2 = L2[L3]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "download"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_set_task_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setDownloadTaskInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 370
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_get_task_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getDownloadTaskInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 371
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_get_global_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getDownloadGlobalInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 372
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_set_global_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setDownloadGlobalInfo"
      L4 = L4(L5)
      L5 = ""
      L6 = 373
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_set_uri"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setDownloadUri"
      L4 = L4(L5)
      L5 = ""
      L6 = 374
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_set_torrent"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setDownloadTorrent"
      L4 = L4(L5)
      L5 = ""
      L6 = 375
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_search"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "DownloadSearchFile"
      L4 = L4(L5)
      L5 = ""
      L6 = 376
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_check_path"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "DownloadCheckPath"
      L4 = L4(L5)
      L5 = ""
      L6 = 377
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "download_status"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "DownloadStatus"
      L4 = L4(L5)
      L5 = ""
      L6 = 378
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "system"
  L2 = L1[L2]
  L3 = "mesh_bhtype_mode"
  L2 = L2[L3]
  if L2 then
    L2 = "system"
    L2 = L1[L2]
    L3 = "mesh_bhtype_mode"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "set_mesh_bh_mode"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "setMeshBhMode"
      L4 = L4(L5)
      L5 = ""
      L6 = 386
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "misystem"
      L6 = "get_mesh_bh_mode"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getMeshBhMode"
      L4 = L4(L5)
      L5 = ""
      L6 = 387
      L2(L3, L4, L5, L6)
    end
  end
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "luci.cbi.datatypes"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQConfigs"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.common.XQFunction"
L4 = L4(L5)
L5 = require
L6 = "xiaoqiang.util.XQSysUtil"
L5 = L5(L6)
L6 = require
L7 = "xiaoqiang.util.XQErrorUtil"
L6 = L6(L7)
L7 = require
L8 = "luci.model.uci"
L7 = L7(L8)
L7 = L7.cursor
L7 = L7()
function L8()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQMinetUtil"
  L0 = L0(L1)
  L1 = L0.listDevice
  L1 = L1()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
minetListDevice = L8
function L8()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQMinetUtil"
  L0 = L0(L1)
  L1 = L0.listFsm
  L1 = L1()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
minetGetState = L8
function L8()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.util.XQMinetUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ctrl"
  L2 = L2(L3)
  L3 = L1.ctrlState
  L4 = L2
  L3 = L3(L4)
  L4 = L3.code
  L0.code = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
minetCtrlState = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "xiaoqiang.util.XQMinetUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "devid"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ctrl"
  L3 = L3(L4)
  if L2 == nil or L3 == nil then
    L0.code = 1
  else
    L4 = L1.grantDevice
    L5 = L2
    L6 = L3
    L4 = L4(L5, L6)
    L5 = L4.code
    L0.code = L5
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
minetGrantDevice = L8
function L8()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQMinetUtil"
  L0 = L0(L1)
  L1 = L0.getConfig
  L1 = L1()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
minetGetConfig = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L0.code = 0
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "express"
  L3 = L3(L4)
  if L2 == "0" or L2 == "1" then
    L1.enable = L2
  end
  if L3 == "0" or L3 == "1" then
    L1.express = L3
  end
  L4 = require
  L5 = "xiaoqiang.util.XQMinetUtil"
  L4 = L4(L5)
  L5 = L4.setConfig
  L6 = L2
  L7 = L3
  L5(L6, L7)
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L0
  L5(L6)
end
minetSetConfig = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = tonumber
  L1 = luci
  L1 = L1.util
  L1 = L1.exec
  L2 = "ps | grep -v grep | grep elink > /dev/NULL 2>&1 ; echo $?"
  L1, L2, L3, L4, L5, L6 = L1(L2)
  L0 = L0(L1, L2, L3, L4, L5, L6)
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 1
  L3 = "test_elink, enbale type:"
  L4 = type
  L5 = L0
  L4 = L4(L5)
  L5 = " ,enable:"
  L6 = L0
  L3 = L3 .. L4 .. L5 .. L6
  L1(L2, L3)
  L1 = 0
  if L0 == 0 then
    L1 = 1
  end
  return L1
end
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L0.enable = 0
  L1 = _UPVALUE0_
  L1 = L1()
  L0.enable = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getElink = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  _UPVALUE0_ = L0
  L0 = _UPVALUE1_
  L0 = L0.formvalue
  L1 = "enable"
  L0 = L0(L1)
  L1 = [[
        timeout -t 10 -s 9
        /etc/init.d/elink stop;
        nvram set elink_en=0;
        nvram commit;
    ]]
  L2 = [[
        time -t 10 -s 9
        nvram set elink_en=1;
        /etc/init.d/elink start;
        nvram commit;
   ]]
  L3 = {}
  L3.code = 0
  if L0 == nil or L0 == "" then
    L3.code = 1612
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = L3.code
    L4 = L4(L5)
    L3.msg = L4
    L4 = _UPVALUE1_
    L4 = L4.write_json
    L5 = L3
    L4(L5)
    return
  end
  if L0 ~= "0" and L0 ~= "1" then
    L3.code = 1537
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = L3.code
    L4 = L4(L5)
    L3.msg = L4
    L4 = _UPVALUE1_
    L4 = L4.write_json
    L5 = L3
    L4(L5)
    return
  end
  L4 = _UPVALUE3_
  L4 = L4.log
  L5 = 1
  L6 = "elink_enable:"
  L7 = L0
  L6 = L6 .. L7
  L4(L5, L6)
  if L0 == "1" then
    L4 = _UPVALUE4_
    L4 = L4()
    if L4 == 0 then
      L4 = _UPVALUE0_
      L4 = L4.forkExec
      L5 = L2
      L4(L5)
      L4 = _UPVALUE3_
      L4 = L4.log
      L5 = 1
      L6 = "enable elink"
      L4(L5, L6)
    end
  end
  if L0 == "0" then
    L4 = _UPVALUE4_
    L4 = L4()
    if L4 == 1 then
      L4 = _UPVALUE0_
      L4 = L4.forkExec
      L5 = L1
      L4(L5)
      L4 = _UPVALUE3_
      L4 = L4.log
      L5 = 1
      L6 = "kill all elink"
      L4(L5, L6)
    end
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
setElink = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQNetworkSpeedTest"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.get
  L4 = "BANDWIDTH"
  L3 = L3(L4)
  if L3 then
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    if L4 ~= 0 then
      goto lbl_76
    end
  end
  L4 = os
  L4 = L4.execute
  L5 = "/etc/init.d/miqos stop"
  L4(L5)
  L4 = require
  L5 = "xiaoqiang.util.XQQoSUtil"
  L4 = L4(L5)
  L5 = L1.syncSpeedTest
  L5, L6 = L5()
  if L5 and L6 then
    L7 = tonumber
    L8 = string
    L8 = L8.format
    L9 = "%.2f"
    L10 = 8 * L6
    L10 = L10 / 1024
    L8, L9, L10, L11, L12, L13 = L8(L9, L10)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L8 = tonumber
    L9 = string
    L9 = L9.format
    L10 = "%.2f"
    L11 = 8 * L5
    L11 = L11 / 1024
    L9, L10, L11, L12, L13 = L9(L10, L11)
    L8 = L8(L9, L10, L11, L12, L13)
    L9 = L0.set
    L10 = "BANDWIDTH"
    L11 = string
    L11 = L11.format
    L12 = "%.2f"
    L13 = 8 * L6
    L13 = L13 / 1024
    L11 = L11(L12, L13)
    L12 = "xiaoqiang"
    L9(L10, L11, L12)
    L9 = L0.set
    L10 = "BANDWIDTH2"
    L11 = string
    L11 = L11.format
    L12 = "%.2f"
    L13 = 8 * L5
    L13 = L13 / 1024
    L11 = L11(L12, L13)
    L12 = "xiaoqiang"
    L9(L10, L11, L12)
    L9 = L4.setQosBand
    L10 = L8
    L11 = L7
    L9(L10, L11)
  end
  L7 = os
  L7 = L7.execute
  L8 = "/etc/init.d/miqos start"
  L7(L8)
  ::lbl_76::
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
active = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = L0.get2g5gDeviceCount
  L1, L2 = L1()
  L3 = L0.getMeshDeviceCount
  L3, L4 = L3()
  L5 = require
  L6 = "xiaoqiang.util.XQLanWanUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQWifiUtil"
  L6 = L6(L7)
  L7 = L6.get_wlan_count
  L7 = L7()
  L8 = {}
  L9 = 0
  L10 = {}
  for L14 = L11, L12, L13 do
    L15 = L6.getWifiBasicInfo
    L16 = L14
    L15 = L15(L16)
    if L15 then
      L16 = {}
      L17 = _UPVALUE0_
      L17 = L17.encode4HtmlValue
      L18 = L15.ssid
      L17 = L17(L18)
      L16.ssid = L17
      L17 = L15.password
      L17 = L17 or L17
      L16.passwd = L17
      L17 = L15.ssidHtmlEncode
      if L17 then
        L17 = L15.ssidHtmlEncode
        if L17 == 1 then
          L17 = 1
          if L17 then
            goto lbl_49
          end
        end
      end
      L17 = 0
      ::lbl_49::
      L16.ssidHtmlEncode = L17
      L17 = L1[L14]
      L16.online_sta_count = L17
      L10[L14] = L16
    end
    if L14 == 1 then
      L9 = L15.bsd
    end
  end
  L11.platform = L12
  L11.version = L12
  L11.channel = L12
  L11.sn = L12
  L11.mac = L12
  L11.imei = L12
  L11.hw_version = L12
  L8.code = 0
  L8.hardware = L11
  L8["2g"] = L12
  L8["5g"] = L12
  if L7 == 3 then
    L8["5gh"] = L12
  end
  if not L2 then
  end
  L8.count = L12
  if not L3 then
  end
  L8.cap_count = L12
  if not L4 then
  end
  L8.re_count = L12
  L8.bsd = L9
  L12(L13)
end
newmainStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = L0.getDevNetStatisticsList
  L3 = L3()
  L3 = L3 or L3
  L4 = #L3
  if 0 < L4 then
    L4 = table
    L4 = L4.sort
    L4(L5, L6)
  end
  L4 = #L3
  if L4 > L5 then
    L4 = {}
    L4.mac = ""
    L4.ip = ""
    for L8 = L5, L6, L7 do
      L9 = table
      L9 = L9.remove
      L10 = L3
      L11 = _UPVALUE0_
      L11 = L11.DEVICE_STATISTICS_LIST_LIMIT
      L9 = L9(L10, L11)
      L10 = tonumber
      L11 = L9.upload
      L10 = L10(L11)
      L11 = tonumber
      L12 = L4.upload
      L12 = L12 or L12
      L11 = L11(L12)
      L10 = L10 + L11
      L4.upload = L10
      L10 = tonumber
      L11 = L9.upspeed
      L10 = L10(L11)
      L11 = tonumber
      L12 = L4.upspeed
      L12 = L12 or L12
      L11 = L11(L12)
      L10 = L10 + L11
      L4.upspeed = L10
      L10 = tonumber
      L11 = L9.download
      L10 = L10(L11)
      L11 = tonumber
      L12 = L4.download
      L12 = L12 or L12
      L11 = L11(L12)
      L10 = L10 + L11
      L4.download = L10
      L10 = tonumber
      L11 = L9.downspeed
      L10 = L10(L11)
      L11 = tonumber
      L12 = L4.downspeed
      L12 = L12 or L12
      L11 = L11(L12)
      L10 = L10 + L11
      L4.downspeed = L10
      L10 = L9.online
      L4.online = L10
      L4.devname = "Others"
      L10 = L9.maxuploadspeed
      L4.maxuploadspeed = L10
      L10 = L9.maxdownloadspeed
      L4.maxdownloadspeed = L10
    end
    L5(L6, L7)
  end
  L4 = {}
  L4.online = 0
  L4.all = 0
  L4.online_without_mash = 0
  L4.all_without_mash = 0
  L8 = L5()
  L4.all_without_mash = L8
  L4.online_without_mash = L7
  L4.all = L6
  L4.online = L5
  L5.platform = L6
  L5.version = L6
  L5.channel = L6
  L5.sn = L6
  L5.mac = L6
  L8 = {}
  L9 = L6.core
  L8.core = L9
  L9 = L6.hz
  L8.hz = L9
  L9 = L7.cpuload
  L9 = L9 / 100
  L9 = L9 or L9
  L8.load = L9
  L9 = _UPVALUE1_
  L9 = L9.checkSystemStatus
  L9 = L9()
  L10 = require
  L11 = "luci.model.uci"
  L10 = L10(L11)
  L10 = L10.cursor
  L10 = L10()
  L11 = {}
  L12 = L6.memTotal
  L11.total = L12
  L13 = L10
  L12 = L10.get
  L14 = "misc"
  L15 = "hardware"
  L16 = "memtype"
  L12 = L12(L13, L14, L15, L16)
  L12 = L12 or L12
  L11.type = L12
  L13 = L10
  L12 = L10.get
  L14 = "misc"
  L15 = "hardware"
  L16 = "memfreq"
  L12 = L12(L13, L14, L15, L16)
  L12 = L12 or L12
  L11.hz = L12
  L12 = L9.mem
  L11.usage = L12
  L2.code = 0
  L2.count = L4
  L2.hardware = L5
  L12 = _UPVALUE1_
  L12 = L12.getSysUptime
  L12 = L12()
  L2.upTime = L12
  L12 = L0.getWanLanNetworkStatistics
  L13 = "wan"
  L12 = L12(L13)
  L2.wan = L12
  L2.dev = L3
  L2.cpu = L8
  L2.mem = L11
  L12 = L9.tmp
  L2.temperature = L12
  L12 = _UPVALUE2_
  L12 = L12.write_json
  L13 = L2
  L12(L13)
end
mainStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "online"
  L3, L4, L5, L6, L7, L8 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L2 = L2 or L2
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "withbrlan"
  L4, L5, L6, L7, L8 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mlo"
  L5, L6, L7, L8 = L5(L6)
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5 = luci
  L5 = L5.dispatcher
  L5 = L5.getremotemac
  L5 = L5()
  L1.mac = L5
  L5 = L0.getDeviceListV2
  L6 = L2 == 1
  L7 = L3 == 1
  L8 = L4 == 1
  L5 = L5(L6, L7, L8)
  L1.list = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
getDeviceList = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.wanTX = 0
  L1.wanRX = 0
  L2 = ""
  L3 = L0.getDeviceListV3
  L4 = L2
  L3 = L3(L4)
  L1.devices = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getDeviceSrvList = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.macaddr
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_20
    end
  end
  L1.code = 1523
  goto lbl_25
  ::lbl_20::
  L3 = L0.getDeviceInfo
  L4 = L2
  L5 = true
  L3 = L3(L4, L5)
  L1.info = L3
  ::lbl_25::
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
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
getDeviceDetail = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQMessageBox"
  L0 = L0(L1)
  L1 = L0.getMessages
  L1 = L1()
  L2 = {}
  L2.code = 0
  L3 = #L1
  L2.count = L3
  L2.messages = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getMessages = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQIPConflict"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.ip_conflict_detection
  L2 = L2()
  L2 = L2 or L2
  L1.ip_conflict = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
checkIpConflict = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQCountryCode"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.getRouterName
  L3 = L3()
  L2.name = L3
  L3 = _UPVALUE0_
  L3 = L3.getHardware
  L3 = L3()
  L2.hardware = L3
  L3 = _UPVALUE1_
  L3 = L3.getNetModeType
  L3 = L3()
  L2.mode = L3
  L3 = _UPVALUE0_
  L3 = L3.getColor
  L3 = L3()
  L2.color = L3
  L3 = _UPVALUE0_
  L3 = L3.getRouterLocale
  L3 = L3()
  L2.locale = L3
  L3 = _UPVALUE0_
  L3 = L3.getLang
  L3 = L3()
  L3 = L3 or L3
  L2.lang = L3
  L3 = L0.getBDataCountryCode
  L3 = L3()
  L2.ccode = L3
  L3 = L1.getDefaultMacAddress
  L3 = L3()
  L3 = L3 or L3
  L2.mac = L3
  L3 = _UPVALUE0_
  L3 = L3.getMiscFeaturesInfo
  L3 = L3()
  L3 = L3 or L3
  L2.features = L3
  L3 = _UPVALUE0_
  L3 = L3.getBrandInfo
  L3 = L3()
  L3 = L3 or L3
  L2.brand = L3
  L3 = _UPVALUE2_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getRouterBaseInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "type"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "step"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 5
  L5 = "stat_points_none luci_config=type:"
  L6 = L1
  L7 = ",step:"
  L8 = L2
  L5 = L5 .. L6 .. L7 .. L8
  L3(L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
setConfigLog = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.getNetModeType
  L3 = L3()
  L5 = L2
  L4 = L2.get
  L6 = "network"
  L7 = "wan"
  L8 = "proto"
  L4 = L4(L5, L6, L7, L8)
  L5 = L1.getWifiBasicInfo
  L6 = 1
  L5 = L5(L6)
  L6 = L1.getWifiBasicInfo
  L7 = 2
  L6 = L6(L7)
  L7 = {}
  L8 = tostring
  L9 = L3
  L8 = L8(L9)
  L7.workmode = L8
  L8 = L4 or L8
  if not L4 then
    L8 = ""
  end
  L7.wan_proto = L8
  L8 = L0.getLanIp
  L8 = L8()
  L7.lan_ip = L8
  L8 = L5.ssid
  L8 = L8 or L8
  L7.ssid2g_ssid = L8
  L8 = L5.password
  L8 = L8 or L8
  L7.ssid2g_passwd = L8
  L9 = L2
  L8 = L2.get
  L10 = "account"
  L11 = "common"
  L12 = "admin"
  L8 = L8(L9, L10, L11, L12)
  L7.admin_passwd = L8
  if L4 == "pppoe" then
    L9 = L2
    L8 = L2.get
    L10 = "network"
    L11 = "wan"
    L12 = "username"
    L8 = L8(L9, L10, L11, L12)
    L8 = L8 or L8
    L7.pppoeName = L8
    L9 = L2
    L8 = L2.get
    L10 = "network"
    L11 = "wan"
    L12 = "password"
    L8 = L8(L9, L10, L11, L12)
    L8 = L8 or L8
    L7.pppoePassword = L8
  end
  if L6 then
    L8 = L6.ssid
    L8 = L8 or L8
    L7.ssid5g_ssid = L8
    L8 = L6.password
    L8 = L8 or L8
    L7.ssid5g_passwd = L8
  end
  L7.code = 0
  L8 = _UPVALUE1_
  L8 = L8.write_json
  L9 = L7
  L8(L9)
end
getConfigResult = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getRouterName
  L1 = L1()
  L0.name = L1
  L1 = _UPVALUE0_
  L1 = L1.getRouterLocale
  L1 = L1()
  L0.locale = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getRouterName = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "name"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "locale"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = #L2
    if 27 < L4 then
      L1.code = 1523
    else
      L4 = _UPVALUE2_
      L4 = L4.setRouterName
      L5 = L2
      L4(L5)
    end
  end
  if L3 then
    L4 = #L3
    if 24 < L4 then
      L1.code = 1523
    else
      L4 = _UPVALUE2_
      L4 = L4.setRouterLocale
      L5 = L3
      L4(L5)
    end
  end
  L4 = L0.exec
  L5 = "ubus call xq_info_sync_mqtt topo_changed"
  L4(L5)
  L4 = L0.exec
  L5 = "ubus call trafficd reload"
  L4(L5)
  L4 = _UPVALUE3_
  L4 = L4.log
  L5 = 6
  L6 = "ubus call trafficd reload config ok... "
  L4(L5, L6)
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE4_
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
setRouterName = L9
function L9(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  L4 = require
  L5 = "xiaoqiang.util.XQSecureUtil"
  L4 = L4(L5)
  L5 = 0
  L6 = luci
  L6 = L6.dispatcher
  L6 = L6.getremotemac
  L6 = L6()
  L7 = L4.checkNonce
  L8 = A0
  L9 = L6
  L7 = L7(L8, L9)
  if L7 then
    L8 = L4.checkUser
    L9 = "admin"
    L10 = A0
    L11 = A1
    L8 = L8(L9, L10, L11)
    if L8 then
      L9 = _UPVALUE0_
      L9 = L9.getEncryptMode
      L9 = L9()
      if L9 == 1 then
        L10 = L4.saveCiphertextLegacyPwd
        L11 = "admin"
        L12 = A2
        L10 = L10(L11, L12)
        if L10 then
          L10 = L4.saveCiphertextPwd
          L11 = "admin"
          L12 = A3
          L10 = L10(L11, L12)
          if L10 then
            L10 = _UPVALUE1_
            L10 = L10.forkExec
            L11 = "/sbin/whc_to_re_common_api.sh webpasswd_update"
            L10(L11)
            L5 = 0
        end
        else
          L5 = 1553
        end
      else
        L10 = L4.saveCiphertextPwd
        L11 = "admin"
        L12 = A2
        L10 = L10(L11, L12)
        if L10 then
          L10 = _UPVALUE1_
          L10 = L10.forkExec
          L11 = "/sbin/whc_to_re_common_api.sh webpasswd_update"
          L10(L11)
          L5 = 0
        else
          L5 = 1553
        end
      end
    else
      L5 = 1552
    end
  else
    L5 = 1582
  end
  return L5
end
_savePassword = L9
function L9(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = 0
  L3 = L1.saveCiphertextPwd
  L4 = "admin"
  L5 = A0
  L3 = L3(L4, L5)
  if L3 then
    L2 = 0
  else
    L2 = 1553
  end
  return L2
end
_meshSavePassword = L9
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQWifiUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L5 = L5(L6)
  L6 = L4.get_wlan_count
  L6 = L6()
  if A0 == 1 then
    L7 = "0"
    if L7 then
      goto lbl_18
    end
  end
  L7 = "80"
  ::lbl_18::
  L8 = 1
  if L5 then
    L9 = L5.is_supported
    L9 = L9()
    if L9 then
      L9 = L3.trim
      L10 = L3.exec
      L11 = "mesh_cmd mesh_suites"
      L10 = L10(L11)
      L10 = L10 or L10
      L9 = L9(L10)
      if L9 == 0 then
        L10 = L5.mesh_set_dwb_status
        L11 = "1"
        L10(L11)
      else
        L8 = 0
      end
    end
  end
  L9 = L4.setWifiBasicInfo
  L10 = 1
  L11 = A1
  L12 = A2
  L13 = "psk2"
  L14, L15 = nil, nil
  L16 = 0
  L17 = 1
  L18 = nil
  L19 = 1
  L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L9 = L4.setWifiBasicInfo
  L10 = 2
  L11 = A1
  L12 = A2
  L13 = "psk2"
  L14, L15 = nil, nil
  L16 = 0
  L17 = 1
  L18 = L7
  L19 = 1
  L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  if L6 == 3 then
    L9 = L4.setWifiBasicInfo
    L10 = 3
    L11 = A1
    L12 = A2
    L13 = "psk2"
    L14, L15 = nil, nil
    L16 = 0
    L17 = L8
    L18 = L7
    L19 = 1
    L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  end
  L9 = L4.mlo_hostap_enable
  L9()
end
setInitBsdWifiInfo = L9
function L9(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L7 = require
  L8 = "luci.util"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQWifiUtil"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
  L9 = L9(L10)
  L10 = L8.get_wlan_count
  L10 = L10()
  L11 = 1
  if A0 == 1 then
    L12 = "0"
    if L12 then
      goto lbl_19
    end
  end
  L12 = "80"
  ::lbl_19::
  if L9 then
    L13 = L9.is_supported
    L13 = L13()
    if L13 then
      L13 = L9.mesh_get_dwb_band
      L13 = L13()
      L13 = L13 or L13
      L14 = L7.trim
      L15 = L7.exec
      L16 = "mesh_cmd mesh_suites"
      L15 = L15(L16)
      L15 = L15 or L15
      L14 = L14(L15)
      if L14 == 0 then
        L15 = L9.mesh_set_dwb_status
        L16 = "1"
        L15(L16)
      else
        L11 = 0
      end
    end
  end
  L13 = L8.setWifiBasicInfo
  L14 = 1
  L15 = A1
  L16 = A2
  L17 = "psk2"
  L18, L19 = nil, nil
  L20 = 0
  L13(L14, L15, L16, L17, L18, L19, L20)
  if A3 ~= nil then
    L13 = #A3
    if L13 ~= 0 and A4 ~= nil then
      L13 = #A4
      if L13 ~= 0 then
        goto lbl_67
      end
    end
  end
  L13 = A1
  L14 = "_5G"
  A3 = L13 .. L14
  A4 = A2
  ::lbl_67::
  L13 = L8.setWifiBasicInfo
  L14 = 2
  L15 = A3
  L16 = A4
  L17 = "psk2"
  L18, L19 = nil, nil
  L20 = 0
  L21 = 1
  L22 = L12
  L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
  if L10 == 3 then
    if A5 ~= nil then
      L13 = #A5
      if L13 ~= 0 and A6 ~= nil then
        L13 = #A6
        if L13 ~= 0 then
          goto lbl_94
        end
      end
    end
    L13 = A1
    L14 = L8.get5G2BandSuffix
    L14 = L14()
    A5 = L13 .. L14
    A6 = A2
    ::lbl_94::
    L13 = L8.setWifiBasicInfo
    L14 = 3
    L15 = A5
    L16 = A6
    L17 = "psk2"
    L18, L19 = nil, nil
    L20 = 0
    L21 = L11
    L22 = L12
    L13(L14, L15, L16, L17, L18, L19, L20, L21, L22)
  end
  L13 = L8.mlo_hostap_disable
  L13()
end
setInitWifiInfo = L9
function L9(A0)
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
isFileExist = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQIPConflict"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "name"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "locale"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "nonce"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "newPwd"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "oldPwd"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "newPwd256"
  L9 = L9(L10)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "bsd"
  L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
  L10 = L10 or L10
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "ssid"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "password"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "ssid5g"
  L13 = L13(L14)
  L13 = L13 or L13
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "password5g"
  L14 = L14(L15)
  L14 = L14 or L14
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "ssid5g2"
  L15 = L15(L16)
  L15 = L15 or L15
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "password5g2"
  L16 = L16(L17)
  L16 = L16 or L16
  L17 = tonumber
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "txpwr"
  L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29 = L18(L19)
  L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
  L17 = L17 or L17
  L18 = tonumber
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "bw160"
  L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29 = L19(L20)
  L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
  L18 = L18 or L18
  L19 = _UPVALUE1_
  L19 = L19.nvramSet
  L20 = "Router_unconfigured"
  L21 = "0"
  L19(L20, L21)
  L19 = _UPVALUE1_
  L19 = L19.nvramCommit
  L19()
  L19 = string
  L19 = L19.lower
  L20 = luci
  L20 = L20.http
  L20 = L20.getenv
  L21 = "HTTP_USER_AGENT"
  L20 = L20(L21)
  L20 = L20 or L20
  L19 = L19(L20)
  L21 = L19
  L20 = L19.match
  L22 = "mozilla"
  L20 = L20(L21, L22)
  if L20 then
    L20 = _UPVALUE2_
    L20 = L20.check
    L21 = 0
    L22 = _UPVALUE2_
    L22 = L22.KEY_GEL_INIT_OTHER
    L23 = 1
    L20(L21, L22, L23)
  else
    L20 = _UPVALUE2_
    L20 = L20.check
    L21 = 0
    L22 = _UPVALUE2_
    L22 = L22.KEY_GEL_INIT_APP
    L23 = 1
    L20(L21, L22, L23)
  end
  L20 = L1.ip_conflict_detection
  L20 = L20()
  if L20 then
    L21 = L2.exec
    L22 = "/etc/init.d/cab_meshd stop"
    L21(L22)
  end
  L21 = _UPVALUE1_
  L21 = L21.isStrNil
  L22 = L4
  L21 = L21(L22)
  if not L21 then
    L21 = _UPVALUE1_
    L21 = L21.isStrNil
    L22 = L5
    L21 = L21(L22)
    if not L21 then
      L21 = _UPVALUE1_
      L21 = L21.isStrNil
      L22 = L6
      L21 = L21(L22)
      if not L21 then
        L21 = _UPVALUE1_
        L21 = L21.isStrNil
        L22 = L7
        L21 = L21(L22)
        if not L21 then
          L21 = _UPVALUE1_
          L21 = L21.isStrNil
          L22 = L8
          L21 = L21(L22)
          if not L21 then
            L21 = _UPVALUE1_
            L21 = L21.isStrNil
            L22 = L11
            L21 = L21(L22)
            if not L21 then
              L21 = _UPVALUE1_
              L21 = L21.isStrNil
              L22 = L12
              L21 = L21(L22)
              if not L21 then
                goto lbl_189
              end
            end
          end
        end
      end
    end
  end
  L3.code = 1523
  goto lbl_259
  ::lbl_189::
  L21 = #L4
  if not (28 < L21) then
    L21 = #L5
    if not (28 < L21) then
      goto lbl_196
    end
  end
  L3.code = 1523
  ::lbl_196::
  L21 = L3.code
  if L21 == 0 then
    L21 = _savePassword
    L22 = L6
    L23 = L8
    L24 = L7
    L25 = L9
    L21 = L21(L22, L23, L24, L25)
    L3.code = L21
  end
  L21 = L3.code
  if L21 == 0 then
    L21 = L0.checkSSID
    L22 = L11
    L23 = 28
    L21 = L21(L22, L23)
    if L21 == 0 then
      L22 = L2.exec
      L23 = string
      L23 = L23.format
      L24 = "/usr/sbin/mesh_connect.sh init_cap 2"
      L23, L24, L25, L26, L27, L28, L29 = L23(L24)
      L22(L23, L24, L25, L26, L27, L28, L29)
      if L10 == 1 or L10 == true then
        L22 = setInitBsdWifiInfo
        L23 = L18
        L24 = L11
        L25 = L12
        L22(L23, L24, L25)
      else
        L22 = setInitWifiInfo
        L23 = L18
        L24 = L11
        L25 = L12
        L26 = L13
        L27 = L14
        L28 = L15
        L29 = L16
        L22(L23, L24, L25, L26, L27, L28, L29)
      end
      if L17 == 1 then
        L22 = L0.setWifiTxpwr
        L23 = "max"
        L22(L23)
      else
        L22 = L0.setWifiTxpwr
        L23 = "mid"
        L22(L23)
      end
      L22 = _UPVALUE3_
      L22 = L22.setRouterName
      L23 = L4
      L22(L23)
      L22 = _UPVALUE3_
      L22 = L22.setRouterLocale
      L23 = L5
      L22(L23)
    else
      L3.code = L21
    end
  end
  ::lbl_259::
  L21 = L3.code
  if L21 ~= 0 then
    L21 = _UPVALUE3_
    L21 = L21.setSysPasswordDefault
    L21()
    L21 = _UPVALUE4_
    L21 = L21.getErrorMessage
    L22 = L3.code
    L21 = L21(L22)
    L3.msg = L21
    if L20 then
      L21 = _UPVALUE1_
      L21 = L21.forkExec
      L22 = "/etc/init.d/cab_meshd restart"
      L21(L22)
    end
  else
    L21 = require
    L22 = "xiaoqiang.util.XQLanWanUtil"
    L21 = L21(L22)
    L22 = L0.get_require_cac
    L22 = L22()
    if L22 == true then
      L23 = _UPVALUE1_
      L23 = L23.get_cac_time
      L24 = "cfg_file"
      L25 = "wl0"
      L26 = "0"
      L27 = "0"
      L23 = L23(L24, L25, L26, L27)
      L3.cac_time = L23
    else
      L3.cac_time = 0
    end
    L23 = _UPVALUE3_
    L23 = L23.setInited
    L23()
    L23 = _UPVALUE3_
    L23 = L23.setSPwd
    L23()
    if L20 then
      L3.ip = L20
      L23 = "lua /usr/sbin/ip_change_delay.lua"
      L24 = string
      L24 = L24.format
      L25 = "%s %s"
      L26 = L23
      L27 = L20
      L24 = L24(L25, L26, L27)
      L23 = L24
      L24 = _UPVALUE2_
      L24 = L24.log
      L25 = 6
      L26 = L23
      L24(L25, L26)
      L24 = _UPVALUE1_
      L24 = L24.forkExec
      L25 = L23
      L24(L25)
    else
      L23 = L21.getLanIp
      L23 = L23()
      L3.ip = L23
      L23 = _UPVALUE1_
      L23 = L23.forkRestartWifi
      L24 = "/etc/init.d/miwifi-discovery restart"
      L23(L24)
      L23 = L2.exec
      L24 = "[ -f /etc/init.d/cab_meshd ] && /etc/init.d/cab_meshd restart &"
      L23(L24)
    end
    L23 = luci
    L23 = L23.sauth
    L23 = L23.killall
    L23()
  end
  L21 = _UPVALUE1_
  L21 = L21.getNetModeType
  L21 = L21()
  L3.workmode = L21
  L21 = require
  L22 = "xiaoqiang.XQPreference"
  L21 = L21(L22)
  L21 = L21.set
  L22 = _UPVALUE5_
  L22 = L22.PREF_IS_CONFIGURED
  L23 = "YES"
  L21(L22, L23)
  L21 = _UPVALUE1_
  L21 = L21.forkExec
  L22 = "/usr/sbin/configured.sh"
  L21(L22)
  L21 = L2.exec
  L22 = "/usr/sbin/luci_post_init.sh"
  L21(L22)
  L21 = _UPVALUE0_
  L21 = L21.write_json
  L22 = L3
  L21(L22)
end
setRouterInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L1.list = L2
  L2 = {}
  L2.ssid = ""
  L2.band = "2g"
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "device_"
  L9 = L2.band
  L10 = "_name"
  L8 = L8 .. L9 .. L10
  L4 = L4(L5, L6, L7, L8)
  L6 = L3
  L5 = L3.get
  L7 = "wireless"
  L8 = L4
  L9 = "disabled"
  L5 = L5(L6, L7, L8, L9)
  if L5 == "1" or L5 == 1 then
    L1.code = 1656
    L6 = _UPVALUE0_
    L6 = L6.getErrorMessage
    L7 = L1.code
    L6 = L6(L7)
    L1.msg = L6
    L6 = _UPVALUE1_
    L6 = L6.write_json
    L7 = L1
    L6(L7)
    return
  end
  L6 = _UPVALUE2_
  L6 = L6.getInitInfo
  L6 = L6()
  if L6 then
    L6 = 1
    if L6 then
      goto lbl_53
    end
  end
  L6 = 0
  ::lbl_53::
  initted = L6
  L6 = initted
  if L6 == 1 then
    L6 = L0.extendwifi_get_scanlist
    L7 = L2
    L6 = L6(L7)
    L1.list = L6
  else
    L6 = L0.extendwifi_get_all_scanlist
    L7 = L2
    L6 = L6(L7)
    L1.list = L6
  end
  L6 = _UPVALUE1_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
get_extendwifi_scanlist = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.msg = ""
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ssid"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "encryption"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enctype"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "password"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "channel"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "band"
  L7 = L7(L8)
  L8 = L0.extendwifi_set_connect
  L9 = L2
  L10 = L5
  L11 = L4
  L12 = L3
  L13 = L7
  L14 = L6
  L8 = L8(L9, L10, L11, L12, L13, L14)
  L9 = L8.ip
  if L9 ~= "" then
    L1.code = 0
    L1.msg = "connect succces!"
  else
    L9 = L8.connected
    if L9 then
      L9 = L8.dhcpcode
      if L9 == 100 then
        L1.code = 1646
        L9 = _UPVALUE1_
        L9 = L9.getErrorMessage
        L10 = L1.code
        L9 = L9(L10)
        L1.msg = L9
      else
        L9 = L8.dhcpcode
        if L9 == 2 then
          L1.code = 1647
          L9 = _UPVALUE1_
          L9 = L9.getErrorMessage
          L10 = L1.code
          L9 = L9(L10)
          L1.msg = L9
        else
          L9 = L8.dhcpcode
          if L9 == 102 then
            L1.code = 1648
            L9 = _UPVALUE1_
            L9 = L9.getErrorMessage
            L10 = L1.code
            L9 = L9(L10)
            L1.msg = L9
          else
            L9 = L8.dhcpcode
            if L9 ~= 105 then
              L9 = L8.dhcpcode
              if L9 ~= 106 then
                goto lbl_91
              end
            end
            L1.code = 1649
            L9 = _UPVALUE1_
            L9 = L9.getErrorMessage
            L10 = L1.code
            L9 = L9(L10)
            L1.msg = L9
            goto lbl_132
            ::lbl_91::
            L9 = L8.dhcpcode
            if L9 == 107 then
              L1.code = 1650
              L9 = _UPVALUE1_
              L9 = L9.getErrorMessage
              L10 = L1.code
              L9 = L9(L10)
              L1.msg = L9
            else
              L9 = L8.dhcpcode
              if L9 ~= 110 then
                L9 = L8.dhcpcode
                if L9 ~= 111 then
                  goto lbl_114
                end
              end
              L1.code = 1651
              L9 = _UPVALUE1_
              L9 = L9.getErrorMessage
              L10 = L1.code
              L9 = L9(L10)
              L1.msg = L9
              goto lbl_132
              ::lbl_114::
              L9 = L8.dhcpcode
              if L9 ~= 115 then
                L9 = L8.dhcpcode
                if L9 ~= 116 then
                  goto lbl_127
                end
              end
              L1.code = 1652
              L9 = _UPVALUE1_
              L9 = L9.getErrorMessage
              L10 = L1.code
              L9 = L9(L10)
              L1.msg = L9
              goto lbl_132
              ::lbl_127::
              L1.code = 1619
              L1.msg = "dhcp failed!"
            end
          end
        end
      end
    else
      L1.code = 1655
      L1.msg = "wifi connect faild!"
    end
  end
  ::lbl_132::
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L1
  L9(L10)
end
set_extendwifi_connect = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ssid"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "name"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "locale"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "encryption"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "enctype"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "password"
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
  L12 = "nssid"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "nssid5G"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "nssid5G2"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "nencryption"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "npassword"
  L15 = L15(L16)
  L16 = tonumber
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "initialize"
  L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37 = L17(L18)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37)
  if L16 == 1 then
    L16 = 1
    if L16 then
      goto lbl_73
    end
  end
  L16 = 0
  ::lbl_73::
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "nonce"
  L17 = L17(L18)
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "newPwd"
  L18 = L18(L19)
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "oldPwd"
  L19 = L19(L20)
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "newPwd256"
  L20 = L20(L21)
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "band"
  L21 = L21(L22)
  L22 = tonumber
  L23 = _UPVALUE0_
  L23 = L23.formvalue
  L24 = "txpwr"
  L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37 = L23(L24)
  L22 = L22(L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37)
  L22 = L22 or L22
  L23 = _UPVALUE1_
  L23 = L23.nvramSet
  L24 = "Router_unconfigured"
  L25 = "0"
  L23(L24, L25)
  L23 = _UPVALUE1_
  L23 = L23.nvramCommit
  L23()
  if L16 == 1 then
    L23 = string
    L23 = L23.lower
    L24 = luci
    L24 = L24.http
    L24 = L24.getenv
    L25 = "HTTP_USER_AGENT"
    L24 = L24(L25)
    L24 = L24 or L24
    L23 = L23(L24)
    L25 = L23
    L24 = L23.match
    L26 = "mozilla"
    L24 = L24(L25, L26)
    if L24 then
      L24 = _UPVALUE2_
      L24 = L24.check
      L25 = 0
      L26 = _UPVALUE2_
      L26 = L26.KEY_GEL_INIT_OTHER
      L27 = 1
      L24(L25, L26, L27)
    else
      L24 = _UPVALUE2_
      L24 = L24.check
      L25 = 0
      L26 = _UPVALUE2_
      L26 = L26.KEY_GEL_INIT_APP
      L27 = 1
      L24(L25, L26, L27)
    end
  end
  L23 = L2.code
  if L23 == 0 and L3 then
    L23 = nil
    L24 = require
    L25 = "xiaoqiang.util.XQSysUtil"
    L24 = L24(L25)
    L25 = L0.setWifiAPMode
    L26 = L3
    L27 = L8
    L28 = L7
    L29 = L6
    L30 = L21
    L31 = L9
    L32 = L10
    L33 = L11
    L34 = L14
    L35 = L15
    L36 = L12
    L37 = L13
    L25 = L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37)
    L23 = L25
    L25 = L23.scan
    if not L25 then
      L2.code = 1617
    else
      L25 = L23.connected
      if L25 then
        L25 = _UPVALUE1_
        L25 = L25.isStrNil
        L26 = L23.ip
        L25 = L25(L26)
        if L25 then
          L2.code = 1615
        else
          L25 = L23.ip
          L2.ip = L25
          L25 = L1.getWifissid
          L25, L26, L27 = L25()
          L2.ssid5G2 = L27
          L2.ssid5G = L26
          L2.ssid = L25
          if L16 == 1 and L4 and L5 then
            L25 = _UPVALUE3_
            L25 = L25.setRouterName
            L26 = L4
            L25(L26)
            L25 = _UPVALUE3_
            L25 = L25.setRouterLocale
            L26 = L5
            L25(L26)
            if L17 and L18 and L19 then
              L25 = _savePassword
              L26 = L17
              L27 = L19
              L28 = L18
              L29 = L20
              L25 = L25(L26, L27, L28, L29)
              L2.code = L25
            end
          end
        end
      else
        L2.code = 1616
        L25 = _UPVALUE4_
        L25 = L25.getErrorMessage
        L26 = L2.code
        L25 = L25(L26)
        L26 = "("
        L27 = tostring
        L28 = L23.conerrmsg
        L27 = L27(L28)
        L28 = ")"
        L25 = L25 .. L26 .. L27 .. L28
        L2.msg = L25
      end
    end
  else
    L23 = L2.code
    if L23 == 0 then
      L2.code = 1523
    end
  end
  if L16 == 1 then
    L23 = L2.code
    if L23 ~= 0 then
      L23 = _UPVALUE3_
      L23 = L23.setSysPasswordDefault
      L23()
    end
  end
  L23 = L2.code
  if L23 ~= 0 then
    L23 = L2.code
    if L23 ~= 1616 then
      L23 = _UPVALUE4_
      L23 = L23.getErrorMessage
      L24 = L2.code
      L23 = L23(L24)
      L2.msg = L23
  end
  else
    L23 = L2.code
    if L23 == 0 then
      L23 = _UPVALUE3_
      L23 = L23.setInited
      L23()
      if L16 == 1 then
        L23 = _UPVALUE3_
        L23 = L23.setSPwd
        L23()
      end
      L23 = L0.actionForEnableWifiAP
      L23()
    end
  end
  L23 = _UPVALUE1_
  L23 = L23.getNetModeType
  L23 = L23()
  L2.workmode = L23
  L23 = require
  L24 = "xiaoqiang.XQPreference"
  L23 = L23(L24)
  L23 = L23.set
  L24 = _UPVALUE5_
  L24 = L24.PREF_IS_CONFIGURED
  L25 = "YES"
  L23(L24, L25)
  L23 = _UPVALUE1_
  L23 = L23.forkExec
  L24 = "/usr/sbin/configured.sh"
  L23(L24)
  L23 = _UPVALUE0_
  L23 = L23.write_json
  L24 = L2
  L23(L24)
end
setWifiApMode = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ssid"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "name"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "locale"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "encryption"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "enctype"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "password"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "channel"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "bandwidth"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "nssid"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "nssid5G"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "nssid5G2"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "nencryption"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "npassword"
  L17 = L17(L18)
  L18 = tonumber
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "initialize"
  L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38 = L19(L20)
  L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38)
  if L18 == 1 then
    L18 = 1
    if L18 then
      goto lbl_79
    end
  end
  L18 = 0
  ::lbl_79::
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "nonce"
  L19 = L19(L20)
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "newPwd"
  L20 = L20(L21)
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "oldPwd"
  L21 = L21(L22)
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "newPwd256"
  L22 = L22(L23)
  L23 = _UPVALUE0_
  L23 = L23.formvalue
  L24 = "band"
  L23 = L23(L24)
  L24 = tonumber
  L25 = _UPVALUE0_
  L25 = L25.formvalue
  L26 = "txpwr"
  L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38 = L25(L26)
  L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38)
  L24 = L24 or L24
  L25 = _UPVALUE1_
  L25 = L25.nvramSet
  L26 = "Router_unconfigured"
  L27 = "0"
  L25(L26, L27)
  L25 = _UPVALUE1_
  L25 = L25.nvramCommit
  L25()
  if L18 == 1 then
    L25 = string
    L25 = L25.lower
    L26 = luci
    L26 = L26.http
    L26 = L26.getenv
    L27 = "HTTP_USER_AGENT"
    L26 = L26(L27)
    L26 = L26 or L26
    L25 = L25(L26)
    L27 = L25
    L26 = L25.match
    L28 = "mozilla"
    L26 = L26(L27, L28)
    if L26 then
      L26 = _UPVALUE2_
      L26 = L26.check
      L27 = 0
      L28 = _UPVALUE2_
      L28 = L28.KEY_GEL_INIT_OTHER
      L29 = 1
      L26(L27, L28, L29)
    else
      L26 = _UPVALUE2_
      L26 = L26.check
      L27 = 0
      L28 = _UPVALUE2_
      L28 = L28.KEY_GEL_INIT_APP
      L29 = 1
      L26(L27, L28, L29)
    end
  end
  L25 = L4.code
  if L25 == 0 and L5 then
    L25 = nil
    L26 = L0.setWifiAPMode
    L27 = L5
    L28 = L10
    L29 = L9
    L30 = L8
    L31 = L23
    L32 = L11
    L33 = L12
    L34 = L13
    L35 = L16
    L36 = L17
    L37 = L14
    L38 = L15
    L26 = L26(L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38)
    L25 = L26
    L26 = L25.scan
    if not L26 then
      L4.code = 1617
    else
      L26 = L25.connected
      if L26 then
        L26 = _UPVALUE1_
        L26 = L26.isStrNil
        L27 = L25.ip
        L26 = L26(L27)
        if L26 then
          L4.code = 1615
        else
          L26 = L25.ip
          L4.ip = L26
          L26 = L25.ssid
          L4.ssid = L26
          L26 = L25.ssid5G
          L4.ssid5G = L26
          if L18 == 1 and L6 and L7 then
            L26 = _UPVALUE3_
            L26 = L26.setRouterName
            L27 = L6
            L26(L27)
            L26 = _UPVALUE3_
            L26 = L26.setRouterLocale
            L27 = L7
            L26(L27)
            if L19 and L20 and L21 then
              L26 = _savePassword
              L27 = L19
              L28 = L21
              L29 = L20
              L30 = L22
              L26 = L26(L27, L28, L29, L30)
              L4.code = L26
            end
          end
        end
      else
        L4.code = 1616
        L26 = _UPVALUE4_
        L26 = L26.getErrorMessage
        L27 = L4.code
        L26 = L26(L27)
        L27 = "("
        L28 = tostring
        L29 = L25.conerrmsg
        L28 = L28(L29)
        L29 = ")"
        L26 = L26 .. L27 .. L28 .. L29
        L4.msg = L26
      end
    end
  else
    L25 = L4.code
    if L25 == 0 then
      L4.code = 1523
    end
  end
  if L18 == 1 then
    L25 = L4.code
    if L25 ~= 0 then
      L25 = _UPVALUE3_
      L25 = L25.setSysPasswordDefault
      L25()
    end
  end
  L25 = L4.code
  if L25 ~= 0 then
    L25 = L4.code
    if L25 ~= 1616 then
      L25 = _UPVALUE4_
      L25 = L25.getErrorMessage
      L26 = L4.code
      L25 = L25(L26)
      L4.msg = L25
  end
  else
    L25 = L4.code
    if L25 == 0 then
      L25 = _UPVALUE3_
      L25 = L25.setInited
      L25()
      if L18 == 1 then
        L25 = _UPVALUE3_
        L25 = L25.setSPwd
        L25()
      end
      L25 = L0.actionForEnableWifiAP
      L25()
    end
  end
  L25 = L4.code
  if L25 == 0 then
    L25 = L1.getWifiBasicInfo
    L26 = 1
    L25 = L25(L26)
    L26 = L1.getWifiBasicInfo
    L27 = 2
    L26 = L26(L27)
    L27 = L3.getLanIp
    L27 = L27()
    L4.lan_ip = L27
    L27 = L25.ssid
    L27 = L27 or L27
    L4.ssid2g_ssid = L27
    L27 = L25.password
    L27 = L27 or L27
    L4.ssid2g_passwd = L27
    if L26 then
      L27 = L26.ssid
      L27 = L27 or L27
      L4.ssid5g_ssid = L27
      L27 = L26.password
      L27 = L27 or L27
      L4.ssid5g_passwd = L27
    end
    L27 = luci
    L27 = L27.sauth
    L27 = L27.killall
    L27()
  else
    L25 = L2.exec
    L26 = string
    L26 = L26.format
    L27 = "/etc/init.d/meshd restart"
    L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38 = L26(L27)
    L25(L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38)
  end
  L25 = _UPVALUE1_
  L25 = L25.getNetModeType
  L25 = L25()
  L4.workmode = L25
  L25 = require
  L26 = "xiaoqiang.XQPreference"
  L25 = L25(L26)
  L25 = L25.set
  L26 = _UPVALUE5_
  L26 = L26.PREF_IS_CONFIGURED
  L27 = "YES"
  L25(L26, L27)
  L25 = _UPVALUE1_
  L25 = L25.forkExec
  L26 = "/usr/sbin/configured.sh"
  L25(L26)
  L25 = L2.exec
  L26 = "/usr/sbin/luci_post_init.sh"
  L25(L26)
  L25 = _UPVALUE0_
  L25 = L25.write_json
  L26 = L4
  L25(L26)
end
setWifiApMode_Init = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ssid"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "name"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "locale"
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
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "newPwd256"
  L10 = L10(L11)
  L11 = tonumber
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "initialize"
  L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22 = L12(L13)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  if L11 == 1 then
    L11 = 1
    if L11 then
      goto lbl_53
    end
  end
  L11 = 0
  ::lbl_53::
  L12 = tonumber
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "txpwr"
  L13, L14, L15, L16, L17, L18, L19, L20, L21, L22 = L13(L14)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L12 = L12 or L12
  L13 = _UPVALUE1_
  L13 = L13.nvramSet
  L14 = "Router_unconfigured"
  L15 = "0"
  L13(L14, L15)
  L13 = _UPVALUE1_
  L13 = L13.nvramCommit
  L13()
  if L11 == 1 then
    L13 = string
    L13 = L13.lower
    L14 = luci
    L14 = L14.http
    L14 = L14.getenv
    L15 = "HTTP_USER_AGENT"
    L14 = L14(L15)
    L14 = L14 or L14
    L13 = L13(L14)
    L15 = L13
    L14 = L13.match
    L16 = "mozilla"
    L14 = L14(L15, L16)
    if L14 then
      L14 = _UPVALUE2_
      L14 = L14.check
      L15 = 0
      L16 = _UPVALUE2_
      L16 = L16.KEY_GEL_INIT_OTHER
      L17 = 1
      L14(L15, L16, L17)
    else
      L14 = _UPVALUE2_
      L14 = L14.check
      L15 = 0
      L16 = _UPVALUE2_
      L16 = L16.KEY_GEL_INIT_APP
      L17 = 1
      L14(L15, L16, L17)
    end
  end
  L13 = _UPVALUE1_
  L13 = L13.getNetMode
  L13 = L13()
  if L13 == "wifiapmode" then
    L2.code = 1618
  elseif L11 == 1 and L4 and L5 and L6 and L7 and L8 and L9 then
    L14 = _savePassword
    L15 = L7
    L16 = L9
    L17 = L8
    L18 = L10
    L14 = L14(L15, L16, L17, L18)
    L2.code = L14
    L14 = L2.code
    if L14 == 0 then
      L14 = L0.setLanAPMode
      L14 = L14()
      if L14 then
        L2.ip = L14
        L15 = L1.setWifiBasicInfo
        L16 = 1
        L17 = L3
        L18 = L6
        L19 = "psk2"
        L20, L21 = nil, nil
        L22 = 0
        L15(L16, L17, L18, L19, L20, L21, L22)
        L15 = L1.setWifiBasicInfo
        L16 = 2
        L17 = L3
        L18 = "_5G"
        L17 = L17 .. L18
        L18 = L6
        L19 = "psk2"
        L20, L21 = nil, nil
        L22 = 0
        L15(L16, L17, L18, L19, L20, L21, L22)
        if L12 == 1 then
          L15 = L1.setWifiTxpwr
          L16 = "max"
          L15(L16)
        else
          L15 = L1.setWifiTxpwr
          L16 = "mid"
          L15(L16)
        end
        L15 = _UPVALUE3_
        L15 = L15.setInited
        L15()
        L15 = _UPVALUE3_
        L15 = L15.setSPwd
        L15()
        L15 = _UPVALUE3_
        L15 = L15.setRouterName
        L16 = L4
        L15(L16)
        L15 = _UPVALUE3_
        L15 = L15.setRouterLocale
        L16 = L5
        L15(L16)
      else
        L2.code = 1619
      end
    end
  end
  if L11 == 1 then
    L14 = L2.code
    if L14 ~= 0 then
      L14 = _UPVALUE3_
      L14 = L14.setSysPasswordDefault
      L14()
    end
  end
  L14 = L2.code
  if L14 ~= 0 then
    L14 = _UPVALUE4_
    L14 = L14.getErrorMessage
    L15 = L2.code
    L14 = L14(L15)
    L2.msg = L14
  else
    L14 = L0.lanApServiceRestart
    L15 = true
    L16 = true
    L17 = false
    L14(L15, L16, L17)
  end
  L14 = _UPVALUE1_
  L14 = L14.getNetModeType
  L14 = L14()
  L2.workmode = L14
  L14 = require
  L15 = "xiaoqiang.XQPreference"
  L14 = L14(L15)
  L14 = L14.set
  L15 = _UPVALUE5_
  L15 = L15.PREF_IS_CONFIGURED
  L16 = "YES"
  L14(L15, L16)
  L14 = _UPVALUE1_
  L14 = L14.forkExec
  L15 = "/usr/sbin/configured.sh"
  L14(L15)
  L14 = _UPVALUE0_
  L14 = L14.write_json
  L15 = L2
  L14(L15)
end
setLanApMode = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ssid"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "name"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "locale"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "password"
  L9 = L9(L10)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "bsd"
  L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32)
  L10 = L10 or L10
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "ssid5g"
  L11 = L11(L12)
  L11 = L11 or L11
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "password5g"
  L12 = L12(L13)
  L12 = L12 or L12
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "ssid5g2"
  L13 = L13(L14)
  L13 = L13 or L13
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "password5g2"
  L14 = L14(L15)
  L14 = L14 or L14
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "nonce"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "newPwd"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "oldPwd"
  L17 = L17(L18)
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "newPwd256"
  L18 = L18(L19)
  L19 = tonumber
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "initialize"
  L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32 = L20(L21)
  L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32)
  if L19 == 1 then
    L19 = 1
    if L19 then
      goto lbl_101
    end
  end
  L19 = 0
  ::lbl_101::
  L20 = tonumber
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "txpwr"
  L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32 = L21(L22)
  L20 = L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32)
  L20 = L20 or L20
  L21 = tonumber
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "bw160"
  L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32 = L22(L23)
  L21 = L21(L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32)
  L21 = L21 or L21
  L22 = _UPVALUE1_
  L22 = L22.nvramSet
  L23 = "Router_unconfigured"
  L24 = "0"
  L22(L23, L24)
  L22 = _UPVALUE1_
  L22 = L22.nvramCommit
  L22()
  if L19 == 1 then
    L22 = string
    L22 = L22.lower
    L23 = luci
    L23 = L23.http
    L23 = L23.getenv
    L24 = "HTTP_USER_AGENT"
    L23 = L23(L24)
    L23 = L23 or L23
    L22 = L22(L23)
    L24 = L22
    L23 = L22.match
    L25 = "mozilla"
    L23 = L23(L24, L25)
    if L23 then
      L23 = _UPVALUE2_
      L23 = L23.check
      L24 = 0
      L25 = _UPVALUE2_
      L25 = L25.KEY_GEL_INIT_OTHER
      L26 = 1
      L23(L24, L25, L26)
    else
      L23 = _UPVALUE2_
      L23 = L23.check
      L24 = 0
      L25 = _UPVALUE2_
      L25 = L25.KEY_GEL_INIT_APP
      L26 = 1
      L23(L24, L25, L26)
    end
  end
  L22 = _UPVALUE1_
  L22 = L22.getNetMode
  L22 = L22()
  if L22 == "wifiapmode" then
    L5.code = 1618
  elseif L19 == 1 and L7 and L8 and L9 and L15 and L16 and L17 then
    L23 = _savePassword
    L24 = L15
    L25 = L17
    L26 = L16
    L27 = L18
    L23 = L23(L24, L25, L26, L27)
    L5.code = L23
    L23 = L5.code
    if L23 == 0 then
      L23 = L0.setLanAPMode
      L23 = L23()
      if L23 then
        L5.ip = L23
        L24 = L1.get_require_cac
        L24 = L24()
        if L24 == true then
          L25 = _UPVALUE1_
          L25 = L25.get_cac_time
          L26 = "cfg_file"
          L27 = "wl0"
          L28 = "0"
          L29 = "0"
          L25 = L25(L26, L27, L28, L29)
          L5.cac_time = L25
        else
          L5.cac_time = 0
        end
        L25 = L4.exec
        L26 = string
        L26 = L26.format
        L27 = "/usr/sbin/mesh_connect.sh init_cap 2"
        L26, L27, L28, L29, L30, L31, L32 = L26(L27)
        L25(L26, L27, L28, L29, L30, L31, L32)
        if L10 == 1 or L10 == true then
          L25 = setInitBsdWifiInfo
          L26 = L21
          L27 = L6
          L28 = L9
          L25(L26, L27, L28)
        else
          L25 = setInitWifiInfo
          L26 = L21
          L27 = L6
          L28 = L9
          L29 = L11
          L30 = L12
          L31 = L13
          L32 = L14
          L25(L26, L27, L28, L29, L30, L31, L32)
        end
        if L20 == 1 then
          L25 = L1.setWifiTxpwr
          L26 = "max"
          L25(L26)
        else
          L25 = L1.setWifiTxpwr
          L26 = "mid"
          L25(L26)
        end
        L25 = _UPVALUE3_
        L25 = L25.setInited
        L25()
        L25 = _UPVALUE3_
        L25 = L25.setSPwd
        L25()
        L25 = _UPVALUE3_
        L25 = L25.setRouterName
        L26 = L7
        L25(L26)
        L25 = _UPVALUE3_
        L25 = L25.setRouterLocale
        L26 = L8
        L25(L26)
      else
        L5.code = 1619
      end
    end
  end
  if L19 == 1 then
    L23 = L5.code
    if L23 ~= 0 then
      L23 = _UPVALUE3_
      L23 = L23.setSysPasswordDefault
      L23()
    end
  end
  L23 = L5.code
  if L23 ~= 0 then
    L23 = _UPVALUE4_
    L23 = L23.getErrorMessage
    L24 = L5.code
    L23 = L23(L24)
    L5.msg = L23
  else
    L23 = L0.lanApServiceRestart
    L24 = true
    L25 = true
    L26 = true
    L23(L24, L25, L26)
  end
  L23 = L5.code
  if L23 == 0 then
    L24 = L3
    L23 = L3.get
    L25 = "network"
    L26 = "wan"
    L27 = "proto"
    L23 = L23(L24, L25, L26, L27)
    L24 = L1.getWifiBasicInfo
    L25 = 1
    L24 = L24(L25)
    L25 = L1.getWifiBasicInfo
    L26 = 2
    L25 = L25(L26)
    L26 = L1.getWifiBasicInfo
    L27 = 3
    L26 = L26(L27)
    L27 = L2.getLanIp
    L27 = L27()
    L5.lan_ip = L27
    L27 = L24.ssid
    L27 = L27 or L27
    L5.ssid2g_ssid = L27
    L27 = L24.password
    L27 = L27 or L27
    L5.ssid2g_passwd = L27
    if L25 then
      L27 = L25.ssid
      L27 = L27 or L27
      L5.ssid5g_ssid = L27
      L27 = L25.password
      L27 = L27 or L27
      L5.ssid5g_passwd = L27
    end
    if L26 then
      L27 = L26.ssid
      L27 = L27 or L27
      L5.ssid5g2_ssid = L27
      L27 = L26.password
      L27 = L27 or L27
      L5.ssid5g2_passwd = L27
    end
    L27 = luci
    L27 = L27.sauth
    L27 = L27.killall
    L27()
  else
    L23 = L4.exec
    L24 = string
    L24 = L24.format
    L25 = "/etc/init.d/meshd restart"
    L24, L25, L26, L27, L28, L29, L30, L31, L32 = L24(L25)
    L23(L24, L25, L26, L27, L28, L29, L30, L31, L32)
  end
  L23 = _UPVALUE1_
  L23 = L23.getNetModeType
  L23 = L23()
  L5.workmode = L23
  L23 = require
  L24 = "xiaoqiang.XQPreference"
  L23 = L23(L24)
  L23 = L23.set
  L24 = _UPVALUE5_
  L24 = L24.PREF_IS_CONFIGURED
  L25 = "YES"
  L23(L24, L25)
  L23 = _UPVALUE1_
  L23 = L23.forkExec
  L24 = "/usr/sbin/configured.sh"
  L23(L24)
  L23 = L4.exec
  L24 = "/usr/sbin/luci_post_init.sh"
  L23(L24)
  L23 = _UPVALUE0_
  L23 = L23.write_json
  L24 = L5
  L23(L24)
end
setLanApMode_Init = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.predownloadInfo
  L2 = L2()
  L1.code = 0
  L3 = L2.time
  L1.time = L3
  L3 = L2.auto
  L1.auto = L3
  L3 = L2.plugin
  L1.plugin = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getOTAInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSynchrodata"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "auto"
  L4, L5, L6, L7, L8, L9, L10 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "time"
  L5, L6, L7, L8, L9, L10 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "plugin"
  L6, L7, L8, L9, L10 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10)
  L6 = L0.setPredownload
  L7 = nil
  L8 = L3
  L9 = L4
  L10 = L5
  L6(L7, L8, L9, L10)
  L6 = L1.syncOTAInfo
  L6()
  L6 = _UPVALUE1_
  L6 = L6.isSupportMesh
  L6 = L6()
  if L6 then
    L6 = _UPVALUE2_
    L6 = L6.isMeshCap
    L6 = L6()
    if L6 then
      L6 = luci
      L6 = L6.util
      L6 = L6.exec
      L7 = "mesh_cmd sync_lite > /dev/null 2>&1 &"
      L6(L7)
    end
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L2
  L6(L7)
end
setOTAInfo = L9
function L9()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.module.XQKVStore"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0.getRouterKV
  L2 = L2()
  L1(L2)
end
getDeviceInfo = L9
function L9()
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
channelScanStart = L9
function L9()
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
getScanResult = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "channel1"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "channel2"
  L2 = L2(L3)
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
setChannel = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQTopology"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "simplified"
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
  if L2 then
    L3 = L0.simpleTopoGraph
    L3 = L3()
    if L3 then
      goto lbl_26
    end
  end
  L3 = L0.topologicalGraph
  L3 = L3()
  ::lbl_26::
  L1.graph = L3
  L4 = L3.leafs
  if L4 then
    L4 = 1
    if L4 then
      goto lbl_34
    end
  end
  L4 = 0
  ::lbl_34::
  L1.show = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
getTopoGraph = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQTopology"
  L0 = L0(L1)
  L1 = nil
  L2 = L0.meshChildList
  L2 = L2()
  L1 = L2
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getChildMeshInfos = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQNetworkSpeedTest"
  L2 = L2(L3)
  L3 = 0
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "history"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "new"
  L7, L8, L9, L10, L11, L12, L13 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13)
  if L5 then
    L7 = tonumber
    L8 = L1.get
    L9 = "BANDWIDTH"
    L10 = 0
    L11 = "xiaoqiang"
    L8, L9, L10, L11, L12, L13 = L8(L9, L10, L11)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L4.bandwidth = L7
    L7 = tonumber
    L8 = string
    L8 = L8.format
    L9 = "%.2f"
    L10 = L4.bandwidth
    L10 = 128 * L10
    L8, L9, L10, L11, L12, L13 = L8(L9, L10)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L4.download = L7
    L7 = tonumber
    L8 = L1.get
    L9 = "BANDWIDTH2"
    L10 = 0
    L11 = "xiaoqiang"
    L8, L9, L10, L11, L12, L13 = L8(L9, L10, L11)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L4.bandwidth2 = L7
    L7 = tonumber
    L8 = string
    L8 = L8.format
    L9 = "%.2f"
    L10 = L4.bandwidth2
    L10 = 128 * L10
    L8, L9, L10, L11, L12, L13 = L8(L9, L10)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L4.upload = L7
    L7 = tonumber
    L8 = L1.get
    L9 = "MANUAL"
    L10 = 0
    L11 = "xiaoqiang"
    L8, L9, L10, L11, L12, L13 = L8(L9, L10, L11)
    L7 = L7(L8, L9, L10, L11, L12, L13)
    L4.manual = L7
  else
    L7 = os
    L7 = L7.execute
    L8 = "/etc/init.d/miqos stop"
    L7(L8)
    L7, L8 = nil, nil
    if L6 and L6 == 1 then
      L9 = L2.syncSpeedTest
      L9, L10 = L9()
      L8 = L10
      L7 = L9
    else
      L9 = L2.speedTest
      L9, L10 = L9()
      L8 = L10
      L7 = L9
    end
    if L7 and L8 and L7 ~= 0 and L8 ~= 0 then
      L4.upload = L7
      L4.download = L8
      L9 = tonumber
      L10 = string
      L10 = L10.format
      L11 = "%.2f"
      L12 = 8 * L7
      L12 = L12 / 1024
      L10, L11, L12, L13 = L10(L11, L12)
      L9 = L9(L10, L11, L12, L13)
      L4.bandwidth2 = L9
      L9 = tonumber
      L10 = string
      L10 = L10.format
      L11 = "%.2f"
      L12 = 8 * L8
      L12 = L12 / 1024
      L10, L11, L12, L13 = L10(L11, L12)
      L9 = L9(L10, L11, L12, L13)
      L4.bandwidth = L9
      L9 = L1.set
      L10 = "BANDWIDTH"
      L11 = tostring
      L12 = L4.bandwidth
      L11 = L11(L12)
      L12 = "xiaoqiang"
      L9(L10, L11, L12)
      L9 = L1.set
      L10 = "BANDWIDTH2"
      L11 = tostring
      L12 = L4.bandwidth2
      L11 = L11(L12)
      L12 = "xiaoqiang"
      L9(L10, L11, L12)
    else
      L3 = 1588
    end
    if L3 ~= 0 then
      L9 = _UPVALUE1_
      L9 = L9.getErrorMessage
      L10 = L3
      L9 = L9(L10)
      L4.msg = L9
    end
    L9 = os
    L9 = L9.execute
    L10 = "/etc/init.d/miqos start"
    L9(L10)
  end
  L4.code = L3
  L7 = io
  L7 = L7.open
  L8 = "/tmp/diag_net_spd"
  L9 = "w+"
  L7 = L7(L8, L9)
  L8 = L0.trim
  L9 = L0.exec
  L10 = string
  L10 = L10.format
  L11 = "date"
  L10, L11, L12, L13 = L10(L11)
  L9, L10, L11, L12, L13 = L9(L10, L11, L12, L13)
  L8 = L8(L9, L10, L11, L12, L13)
  if L7 then
    L10 = L7
    L9 = L7.write
    L11 = string
    L11 = L11.format
    L12 = "network speed test at %s, result is:\n"
    L13 = L8
    L11, L12, L13 = L11(L12, L13)
    L9(L10, L11, L12, L13)
    if L3 ~= 0 then
      L10 = L7
      L9 = L7.write
      L11 = string
      L11 = L11.format
      L12 = "msg:%s\n"
      L13 = L4.msg
      L11, L12, L13 = L11(L12, L13)
      L9(L10, L11, L12, L13)
      L10 = L7
      L9 = L7.write
      L11 = string
      L11 = L11.format
      L12 = "upload speed:0 Mbps\n"
      L11, L12, L13 = L11(L12)
      L9(L10, L11, L12, L13)
      L10 = L7
      L9 = L7.write
      L11 = string
      L11 = L11.format
      L12 = "download speed:0 Mbps\n"
      L11, L12, L13 = L11(L12)
      L9(L10, L11, L12, L13)
    else
      L10 = L7
      L9 = L7.write
      L11 = string
      L11 = L11.format
      L12 = "upload speed:%s Mbps\n"
      L13 = L4.bandwidth2
      L11, L12, L13 = L11(L12, L13)
      L9(L10, L11, L12, L13)
      L10 = L7
      L9 = L7.write
      L11 = string
      L11 = L11.format
      L12 = "download speed:%s Mbps\n"
      L13 = L4.bandwidth
      L11, L12, L13 = L11(L12, L13)
      L9(L10, L11, L12, L13)
    end
    L10 = L7
    L9 = L7.flush
    L9(L10)
    L10 = L7
    L9 = L7.close
    L9(L10)
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L4
  L9(L10)
end
bandwidthTest = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = {}
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "proto"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "username"
  L5 = L5(L6)
  L3.username = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "password"
  L5 = L5(L6)
  L3.password = L5
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "service"
  L5 = L5(L6)
  L3.service = L5
  L5 = L0.get_wanDevCfg
  L6 = nil
  L7 = "Router"
  L8 = wanType
  L9 = 4
  L5 = L5(L6, L7, L8, L9)
  L3.wanDevCfg = L5
  L3.autoset = "0"
  L3.special = "0"
  L5 = L3.wanDevCfg
  if L5 then
    if L4 == "pppoe" then
      L5 = L0.chkWan4PPPoE
      L6 = L3
      L5 = L5(L6)
      L2 = L5
      if L2 == 0 then
        L5 = L0.setWan4PPPoE
        L6 = L3
        L5 = L5(L6)
        L2 = L5
      end
    elseif L4 == "dhcp" then
      L5 = L0.setWan4Dhcp
      L6 = L3
      L5 = L5(L6)
      L2 = L5
    elseif L4 == "staticip" then
    end
  end
  L1.code = L2
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
setWan = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = 0
  L2 = {}
  L3 = L0.getPPPoEStatus
  L3 = L3()
  if L3 then
    L2 = L3
    L4 = L2.errtype
    if L4 == 1 then
      L1 = 1603
    else
      L4 = L2.errtype
      if L4 == 2 then
        L1 = 1604
      else
        L4 = L2.errtype
        if L4 == 3 then
          L1 = 1605
        end
      end
    end
  else
    L1 = 1602
  end
  if L1 ~= 0 then
    if L1 ~= 1602 then
      L4 = string
      L4 = L4.format
      L5 = "%s(%s)"
      L6 = _UPVALUE0_
      L6 = L6.getErrorMessage
      L7 = L1
      L6 = L6(L7)
      L7 = tostring
      L8 = L2.errcode
      L7, L8 = L7(L8)
      L4 = L4(L5, L6, L7, L8)
      L2.msg = L4
    else
      L4 = _UPVALUE0_
      L4 = L4.getErrorMessage
      L5 = L1
      L4 = L4(L5)
      L2.msg = L4
    end
  end
  L2.code = 0
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getPPPoEStatus = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.pppoeStop
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
pppoeStop = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQRouterStatus"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "keys"
  L1 = L1(L2)
  L2 = L0.getStatus
  L3 = L1
  L2 = L2(L3)
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getRouterStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.qosBand
  L2 = L2()
  L3 = L0.qosStatus
  L3 = L3()
  L4 = L0.qosList
  L5 = L2
  L4 = L4(L5)
  L5 = L0.guestQoSInfo
  L5 = L5()
  L1.status = L3
  L1.list = L4
  L1.band = L2
  L1.guest = L5
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
getQosInfo = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.macFormat
    L4 = L2
    L3 = L3(L4)
    L2 = L3
    L3 = L0.macQosInfo
    L4 = L2
    L3 = L3(L4)
    if L3 then
      L4 = L0.qosStatus
      L4 = L4()
      L1.status = L4
      L4 = L0.qosBand
      L4 = L4()
      L1.band = L4
      L1.limit = L3
    else
      L1.code = 2
    end
  else
    L1.code = 1
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getMACQoSInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
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
  L4, L5, L6, L7, L8, L9 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "download"
  L5, L6, L7, L8, L9 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = nil
  if L2 and L3 and L4 then
    L6 = L0.setMacQosInfo
    L7 = L2
    L8 = L3
    L9 = L4
    L6 = L6(L7, L8, L9)
    L5 = L6
  else
    L1.code = 1523
  end
  if not L5 then
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
  else
    L6 = require
    L7 = "xiaoqiang.util.XQSynchrodata"
    L6 = L6(L7)
    L7 = L6.syncQosInfo
    L7()
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
setMACQoSInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "macs"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = L0.split
    L4 = L2
    L5 = ";"
    L3 = L3(L4, L5)
    L2 = L3
  end
  L3 = L1.qosHistory
  L4 = L2
  L3 = L3(L4)
  L3.code = 0
  L4 = L1.guestQoSInfo
  L4 = L4()
  L3.guest = L4
  L4 = L1.wangzheInfo
  L4 = L4()
  L3.wangzhe = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
getQos = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "nixio"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "on"
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  if L3 == 1 then
    L3 = true
    if L3 then
      goto lbl_21
    end
  end
  L3 = false
  ::lbl_21::
  L4 = L0.qosSwitch
  L5 = L3
  L4(L5)
  L4 = require
  L5 = "xiaoqiang.util.XQSynchrodata"
  L4 = L4(L5)
  L5 = L4.syncQosInfo
  L5()
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
qosSwitch = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3, L4, L5 = L3(L4)
  L2 = L2(L3, L4, L5)
  L3 = L0.qosStatus
  L3 = L3()
  if L3 then
    L4 = L3.on
    if L4 == 1 then
      L4 = L0.setQoSMode
      L5 = L2
      L4 = L4(L5)
      L1.code = L4
  end
  else
    L1.code = 1607
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  else
    L4 = require
    L5 = "xiaoqiang.util.XQSynchrodata"
    L4 = L4(L5)
    L5 = L4.syncQosInfo
    L5()
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
qosMode = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "upload"
  L4, L5, L6, L7, L8, L9 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "download"
  L5, L6, L7, L8, L9 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "manual"
  L6, L7, L8, L9 = L6(L7)
  L5 = L5(L6, L7, L8, L9)
  L6 = L0.set
  L7 = "BANDWIDTH"
  L8 = tostring
  L9 = L4
  L8 = L8(L9)
  L9 = "xiaoqiang"
  L6(L7, L8, L9)
  L6 = L0.set
  L7 = "BANDWIDTH2"
  L8 = tostring
  L9 = L3
  L8 = L8(L9)
  L9 = "xiaoqiang"
  L6(L7, L8, L9)
  if L5 and L5 == 1 then
    L6 = L0.set
    L7 = "MANUAL"
    L8 = "1"
    L9 = "xiaoqiang"
    L6(L7, L8, L9)
    L6 = L1.setQosBand
    L7 = L3
    L8 = L4
    L6 = L6(L7, L8)
    if not L6 then
      L2.code = 1606
    end
  else
    L6 = L0.set
    L7 = "MANUAL"
    L8 = "0"
    L9 = "xiaoqiang"
    L6(L7, L8, L9)
  end
  L6 = L2.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L2.code
    L6 = L6(L7)
    L2.msg = L6
  else
    L6 = require
    L7 = "xiaoqiang.util.XQSynchrodata"
    L6 = L6(L7)
    L7 = L6.syncQosInfo
    L7()
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L2
  L6(L7)
end
setBand = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "upload"
  L4, L5, L6, L7, L8, L9 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "download"
  L5, L6, L7, L8, L9 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "manual"
  L6, L7, L8, L9 = L6(L7)
  L5 = L5(L6, L7, L8, L9)
  L6 = L0.set
  L7 = "BANDWIDTH"
  L8 = tostring
  L9 = L4
  L8 = L8(L9)
  L9 = "xiaoqiang"
  L6(L7, L8, L9)
  L6 = L0.set
  L7 = "BANDWIDTH2"
  L8 = tostring
  L9 = L3
  L8 = L8(L9)
  L9 = "xiaoqiang"
  L6(L7, L8, L9)
  if L5 and L5 == 1 then
    L6 = L0.set
    L7 = "MANUAL"
    L8 = "1"
    L9 = "xiaoqiang"
    L6(L7, L8, L9)
    L6 = L1.setQosBand
    L7 = L3
    L8 = L4
    L6 = L6(L7, L8)
    if not L6 then
      L2.code = 1606
    end
  end
  L6 = L2.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L2.code
    L6 = L6(L7)
    L2.msg = L6
  else
    L6 = require
    L7 = "xiaoqiang.util.XQSynchrodata"
    L6 = L6(L7)
    L7 = L6.syncQosInfo
    L7()
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L2
  L6(L7)
end
setBandApp = L9
function L9()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getLocation
  L1 = L1()
  if L1 == "" then
    L0.code = 1502
  else
    L0.location = L1
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
getLocation = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = 0
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "location"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "server"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if L4 then
    L0 = 1502
  else
    L4 = _UPVALUE2_
    L4 = L4.setLocation
    L5 = L2
    L6 = true
    L7 = L3
    L4 = L4(L5, L6, L7)
    if not L4 then
      L0 = 1511
    end
  end
  if L0 ~= 0 then
    L4 = _UPVALUE3_
    L4 = L4.getErrorMessage
    L5 = L0
    L4 = L4(L5)
    L1.msg = L4
  end
  L1.code = L0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
setLocation = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getLangList
  L1 = L1()
  L0.list = L1
  L1 = _UPVALUE0_
  L1 = L1.getLang
  L1 = L1()
  L0.lang = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getLangList = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getLang
  L1 = L1()
  L0.lang = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getMainLang = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = 0
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "language"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L0 = 1502
  end
  L3 = _UPVALUE2_
  L3 = L3.setLang
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L0 = 1511
  end
  if L0 ~= 0 then
    L4 = _UPVALUE3_
    L4 = L4.getErrorMessage
    L5 = L0
    L4 = L4(L5)
    L1.msg = L4
  end
  L1.code = L0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
setLang = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
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
  L5 = "mode"
  L4, L5, L6, L7, L8, L9, L10, L11, L12 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12)
  L3 = L3 or L3
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "upload"
  L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "download"
  L6, L7, L8, L9, L10, L11, L12 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12)
  L6 = nil
  L7 = L0.qosStatus
  L7 = L7()
  if L7 then
    L8 = L7.on
    if L8 == 1 then
      if L2 and L3 and L4 and L5 then
        L8 = L0.qosOnLimit
        L9 = L2
        L10 = L3
        L11 = L4
        L12 = L5
        L8 = L8(L9, L10, L11, L12)
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
  else
    L8 = require
    L9 = "xiaoqiang.util.XQSynchrodata"
    L8 = L8(L9)
    L9 = L8.syncQosInfo
    L9()
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L1
  L8(L9)
end
qosLimit = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 1
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "flag"
  L3 = L3(L4)
  L3 = L3 or L3
  if L2 and (L3 == "on" or L3 == "off") then
    L4 = L0.qosLimitFlag
    L5 = L2
    L6 = L3
    L4 = L4(L5, L6)
    if L4 then
      L1.code = 0
      L4 = require
      L5 = "xiaoqiang.util.XQSynchrodata"
      L4 = L4(L5)
      L5 = L4.syncQosInfo
      L5()
    else
      L1.msg = "XQQoSUtil.qosLimitFlag() failed. "
    end
  else
    L1.msg = "parameter mac or flag is NULL. "
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
qosLimitFlag = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.json"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mode"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "data"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  if L3 then
    L5 = L1.decode
    L6 = L3
    L5 = L5(L6)
    L3 = L5
  end
  L5 = L0.qosOnLimits
  L6 = L2
  L7 = L3
  L5 = L5(L6, L7)
  L4.code = L5
  L5 = L4.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L4.code
    L5 = L5(L6)
    L4.msg = L5
  else
    L5 = require
    L6 = "xiaoqiang.util.XQSynchrodata"
    L5 = L5(L6)
    L6 = L5.syncQosInfo
    L6()
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
qosLimits = L9
function L9()
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
qosOffLimit = L9
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "percent"
  L4 = L4(L5)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "percent_up"
  L5 = L5(L6)
  L5 = L5 or L5
  L4 = L4(L5)
  if not L3 or L3 < 0 or 1 < L3 then
    L2.code = 1523
  else
    if not L4 or L4 < 0 or 1 < L4 then
      L4 = L3
    end
    L5 = L1.setQosGuestOrXQ
    L6 = A0
    L7 = L3
    L8 = L4
    L5(L6, L7, L8)
    if A0 == "guest" then
      L5 = L1.guestQoSInfo
      L5 = L5()
      L2.guest = L5
    elseif A0 == "local" then
      L5 = L1.xqQoSInfo
      L5 = L5()
      L2["local"] = L5
    else
      L2.code = 1
      L2.msg = "not supported limit."
    end
  end
  L5 = L2.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
  else
    L5 = require
    L6 = "xiaoqiang.util.XQSynchrodata"
    L5 = L5(L6)
    L6 = L5.syncQosInfo
    L6()
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
qosGuestAndXQ = L9
function L9()
  local L0, L1
  L0 = qosGuestAndXQ
  L1 = "guest"
  L0(L1)
end
qosGuest = L9
function L9()
  local L0, L1
  L0 = qosGuestAndXQ
  L1 = "local"
  L0(L1)
end
qosXQ = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQDisk"
  L1 = L1(L2)
  L2 = L1.smartctl
  L2 = L2()
  L3 = L1.diskInfo
  L3 = L3()
  L4 = tonumber
  L5 = L0.get
  L6 = "DISK_CHECK_TIMESTAMP"
  L5, L6 = L5(L6)
  L4 = L4(L5, L6)
  L3.code = 0
  L5 = L4 or L5
  if not L4 then
    L5 = 0
  end
  L3.timestamp = L5
  L5 = L2.poweronhours
  L3.poweronhours = L5
  L5 = L1.get_diskstatus
  L5 = L5()
  L3.status = L5
  L5 = L1.get_diskmstatus
  L5 = L5()
  L3.mstatus = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
getDiskinfo = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = L0.iostatus
  L1 = L1()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getIOData = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQDisk"
  L1 = L1(L2)
  L2 = string
  L2 = L2.lower
  L3 = luci
  L3 = L3.http
  L3 = L3.getenv
  L4 = "HTTP_USER_AGENT"
  L3 = L3(L4)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = L0.set
  L4 = "DISK_CHECK_TIMESTAMP"
  L5 = tostring
  L6 = os
  L6 = L6.time
  L6 = L6()
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L4 = L2
  L3 = L2.match
  L5 = "mozilla"
  L3 = L3(L4, L5)
  if L3 then
    L3 = L1.disk_check
    L3()
  else
    L3 = L1.disk_check
    L4 = true
    L3(L4)
  end
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
diskCheck = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.get_diskstatus
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskCheckStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = string
  L1 = L1.lower
  L2 = luci
  L2 = L2.http
  L2 = L2.getenv
  L3 = "HTTP_USER_AGENT"
  L2 = L2(L3)
  L2 = L2 or L2
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L4 = L1
  L3 = L1.match
  L5 = "mozilla"
  L3 = L3(L4, L5)
  if L3 then
    L3 = L0.disk_repair
    L3()
  else
    L3 = L0.disk_repair
    L4 = true
    L3(L4)
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
diskRepair = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.get_repairstatus
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskRepairStatus = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.disk_init
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskInit = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.disk_format
  L2 = L2()
  if not L2 then
    L1.code = 1558
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
diskFormat = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.save_diskfstatus
  L3 = 1
  L2(L3)
  L2 = L0.disk_format_async
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskFormatAsync = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.get_formatstatus
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskFormatStatus = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.disk_status_v2
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskStatus = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.smartctl_info_v2
  L2 = L2()
  L1.info = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskSmartCtl = L9
function L9()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.backupSysLog
  L1 = L1()
  if L1 then
    L0.file = L1
  else
    L0.code = 1540
  end
  L2 = L0.code
  if L2 ~= 0 then
    L2 = _UPVALUE1_
    L2 = L2.getErrorMessage
    L3 = L0.code
    L2 = L2(L3)
    L0.msg = L2
  end
  L2 = _UPVALUE2_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
backupSysLog = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQNetUtil"
  L0 = L0(L1)
  L1 = L0.generateLogKeyV2
  L1 = L1()
  L2 = {}
  L2.code = 0
  L2.key = L1
  L3 = _UPVALUE0_
  L3 = L3.forkExec
  L4 = "lua /usr/sbin/syslog_upload.lua "
  L5 = L1
  L4 = L4 .. L5
  L3(L4)
  L3 = _UPVALUE1_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
syslogUpload = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = luci
  L2 = L2.dispatcher
  L2 = L2.getremotemac
  L2 = L2()
  if L2 then
    L3 = tostring
    L4 = os
    L4 = L4.time
    L4, L5, L6, L7, L8 = L4()
    L3 = L3(L4, L5, L6, L7, L8)
    L4 = L0.setAdminDevice
    L6 = L2
    L5 = L2.gsub
    L7 = ":"
    L8 = ""
    L5 = L5(L6, L7, L8)
    L6 = L3
    L4(L5, L6)
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
register = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQNetworkSpeedTest"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "nettb"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L1.set
  L5 = "UPLOAD_SPEED"
  L6 = "0"
  L4(L5, L6)
  L4 = L1.set
  L5 = "DOWNLOAD_SPEED"
  L6 = "0"
  L4(L5, L6)
  if L2 ~= 0 then
    L3.code = 1623
  else
    L4 = L0.asyncSpeedTest
    L4()
  end
  L4 = L3.code
  if L4 ~= 0 then
    L4 = _UPVALUE0_
    L4 = L4.getErrorMessage
    L5 = L3.code
    L4 = L4(L5)
    L3.msg = L4
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
speedTest = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQNetworkSpeedTest"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.status = 0
  L2 = L0.getSpeedTestResult
  L2, L3 = L2()
  if L2 and L3 then
    if L2 == 0 or L3 == 0 then
      L1.status = 1
    else
      L1.status = 2
      L1.up = L2
      L1.down = L3
    end
  else
    L1.code = 1588
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE0_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
speedTestResult = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.mode = "error"
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = "uci -q get xiaoqiang.common.NETMODE"
  L2 = L2(L3)
  L3 = L1.trim
  L4 = L2
  L3 = L3(L4)
  if L3 == "wifiapmode" then
    L0.mode = "wifiapmode"
  elseif L3 == "lanapmode" then
    L0.mode = "lanapmode"
  else
    L4 = L1.exec
    L5 = "uci -q get network.wan.proto"
    L4 = L4(L5)
    if L4 then
      L5 = L1.trim
      L6 = L4
      L5 = L5(L6)
      L4 = L5
      if L4 == "pppoe" then
        L0.mode = "pppoe"
      elseif L4 == "dhcp" then
        L0.mode = "dhcp"
      elseif L4 == "static" then
        L0.mode = "static"
      else
        L0.mode = "error"
      end
    else
      L0.mode = "error"
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
getNetWanMode = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQNetworkNetDiagnose"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.asyncNetDiag
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
netDiagnoseStart = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQNetworkNetDiagnose"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.status = 0
  L2 = L0.getNetDiagResult
  L2, L3 = L2()
  if L2 and L3 then
    if L2 < 0 then
      L1.code = 1588
    elseif L2 == 0 then
      L1.status = 1
    elseif L2 == 99 then
      L1.status = 3
    else
      L4 = L0.getWanMode
      L4 = L4()
      if L4 then
        L1.status = 2
        L1.wanmode = L4
        if L2 == 1 then
          L1.wan = "down"
        elseif L2 == 2 then
          L1.wan = "up"
          L1.diagnose = "111"
        elseif L2 == 4 then
          L1.wan = "up"
          L1.diagnose = "113"
        elseif L2 == 10 then
          L1.wan = "up"
          L1.diagnose = "114"
        elseif L2 == 5 then
          L1.wan = "up"
          L1.diagnose = "112"
        elseif L2 == 3 or L2 == 34 then
          L1.wan = "up"
          L1.diagnose = "678"
        elseif L2 == 31 then
          L1.wan = "up"
          L1.diagnose = "633"
        elseif L2 == 35 then
          L1.wan = "up"
          L1.diagnose = "101"
        elseif L2 == 32 or L2 == 33 then
          L1.wan = "up"
          L1.diagnose = "691"
        elseif L2 == 6 or L2 == 7 then
          L1.wan = "up"
          L1.diagnose = "100"
          L5 = L0.getDnsIp
          L5 = L5()
          L1.dns = L5
        else
          L1.wan = "up"
          L1.diagnose = "unknown"
        end
      else
        L1.code = 1588
      end
    end
  else
    L1.code = 1588
  end
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE0_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
netDiagnoseResult = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L2.getWiFiMacfilterModel
  L4 = L4()
  L3.wifimode = L4
  L4 = L3.wifimode
  if L4 == 0 then
    L3.wifimode = 1
  end
  L4 = ""
  L5 = L2.getAllWifiInfo
  L5 = L5()
  if L5 then
    L6 = L5[1]
    if L6 then
      L6 = L5[1]
      L4 = L6.password
    end
  end
  L6 = L1.checkPlaintextPwd
  L7 = "admin"
  L8 = L4
  L6 = L6(L7, L8)
  if L6 then
    L3.adminlevel = 2
  else
    L3.adminlevel = 3
  end
  L6 = L1.checkStrong
  L7 = L4
  L6 = L6(L7)
  L3.wifilevel = L6
  L6 = L0.pushSettings
  L6 = L6()
  L7 = L6.auth
  if L7 then
    L7 = 1
    if L7 then
      goto lbl_51
    end
  end
  L7 = 0
  ::lbl_51::
  L3.open = L7
  L7 = L6.level
  L3.level = L7
  L7 = L6.count
  L3.count = L7
  return L3
end
_getAntiRubNetworkStatus = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.write_json
  L1 = _getAntiRubNetworkStatus
  L1 = L1()
  L0(L1)
end
getAntiRubNetworkStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSecureUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "open"
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  if L2 == 1 then
    L2 = 1
    if L2 then
      goto lbl_19
    end
  end
  L2 = 0
  ::lbl_19::
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_31
    end
  end
  L3 = 0
  ::lbl_31::
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "level"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = luci
  L5 = L5.dispatcher
  L5 = L5.getremotemac
  L5 = L5()
  L6 = "lua /usr/sbin/set_anti_rub_network.lua"
  L7 = {}
  L7.code = 0
  L8 = L0.pushConfig
  L9 = "auth"
  L10 = L2
  L8(L9, L10)
  if "nil" ~= L4 then
    L8 = tonumber
    L9 = L4
    L8 = L8(L9)
    if nil == L8 then
      L4 = "nil"
    end
  end
  if L5 == "" then
    L8 = "nil"
    L5 = L8 or L5
    if not L8 then
    end
  end
  L8 = string
  L8 = L8.format
  L9 = "%s %d %d %s %s"
  L10 = L6
  L11 = L2
  L12 = L3
  L13 = L4
  L14 = L5
  L8 = L8(L9, L10, L11, L12, L13, L14)
  L6 = L8
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = 6
  L10 = L6
  L8(L9, L10)
  L8 = L1.cmdSafeCheck
  L9 = L6
  L8 = L8(L9)
  if L8 then
    L8 = _UPVALUE2_
    L8 = L8.forkExec
    L9 = L6
    L8(L9)
  else
    L7.code = 1523
    L8 = _UPVALUE3_
    L8 = L8.getErrorMessage
    L9 = 1523
    L8 = L8(L9)
    L7.msg = L8
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L7
  L8(L9)
end
setAntiRubNetwork = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "macs"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "keys"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L4.records = L5
  if not L5 then
    L2 = L5
  end
  if not L5 then
    L3 = L5
  end
  if L2 and L3 then
    for L8, L9 in L5, L6, L7 do
      L10 = _UPVALUE1_
      L10 = L10.isStrNil
      L10 = L10(L11)
      if not L10 then
        L10 = {}
        L9 = L11
        for L14, L15 in L11, L12, L13 do
          if L15 and L15 == "wifi" then
            L16 = {}
            L17 = L1.getAuthenFailedTimes
            L18 = L9
            L17 = L17(L18)
            L16.count = L17
            L17 = L1.getWifiAuthenFailedFrequency
            L18 = L9
            L17 = L17(L18)
            L16.frequency = L17
            L10[L15] = L16
          elseif L15 and L15 == "login" then
            L16 = {}
            L17 = L1.getLoginAuthenFailedTimes
            L18 = L9
            L17 = L17(L18)
            L16.count = L17
            L17 = L1.getLoginAuthenFailedFrequency
            L18 = L9
            L17 = L17(L18)
            L16.frequency = L17
            L10[L15] = L16
          end
        end
        L11[L9] = L10
      end
    end
  end
  L5(L6)
end
getAntiRubNetworkRecords = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQAntiRubNetwork"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "key"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = L0.ignoreDevice
  L5 = L2
  L6 = L3
  L4(L5, L6)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
setAntiRubNetworkIgnore = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQSecurity"
  L0 = L0(L1)
  L1 = L0.security_status
  L1 = L1()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
arnSecurity = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQSecurity"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQPushUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSynchrodata"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "info"
  L5 = L5(L6)
  L6 = {}
  L6.code = 0
  if not L5 then
    L6.code = 1523
  else
    L7 = pcall
    L8 = L0.decode
    L9 = L5
    L7, L8 = L7(L8, L9)
    if L7 and L8 then
      L9 = L1.security_switch
      L10 = L8
      L9(L10)
      L9 = L8.wifi_arn
      if L9 then
        L10 = L2.pushConfig
        L11 = "auth"
        L12 = L9
        L10(L11, L12)
        L10 = L4.syncProtectionStatus
        L11 = L9
        L12 = 0
        L10(L11, L12)
        if L9 == 1 then
          L10 = L3.setWiFiMacfilterModel
          L11 = true
          L12 = 0
          L10(L11, L12)
        elseif L9 == 0 then
          L10 = L3.setWiFiMacfilterModel
          L11 = false
          L12 = 0
          L10(L11, L12)
        end
      end
      L10 = _UPVALUE1_
      L10 = L10.forkExec
      L11 = "/sbin/notice_tbus_device_maclist.sh"
      L10(L11)
    else
      L6.code = 1523
    end
  end
  L7 = L6.code
  if L7 ~= 0 then
    L7 = _UPVALUE2_
    L7 = L7.getErrorMessage
    L8 = L6.code
    L7 = L7(L8)
    L6.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
end
arnSecuritySwitch = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "open"
  L2, L3, L4, L5, L6, L7, L8, L9, L10 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8, L9, L10)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "verifycode"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "password"
  L3 = L3(L4)
  L4 = true
  if L1 then
    if L1 == 1 and L2 then
      L5 = L0.exec
      L6 = string
      L6 = L6.format
      L7 = "/etc/init.d/miDebug.sh start \"%s\" \"%s\""
      L8 = _UPVALUE1_
      L8 = L8._cmdformat
      L9 = L2
      L8 = L8(L9)
      L9 = _UPVALUE1_
      L9 = L9._cmdformat
      L10 = L3
      L9, L10 = L9(L10)
      L6, L7, L8, L9, L10 = L6(L7, L8, L9, L10)
      L5 = L5(L6, L7, L8, L9, L10)
      L4 = L5
    end
    if L1 == 0 then
      L5 = L0.exec
      L6 = "/etc/init.d/miDebug.sh stop 2>/dev/null"
      L5 = L5(L6)
      L4 = L5
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = {}
  L6.code = 0
  L6.succeed = L4
  L5(L6)
end
debug = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = 0
  L2 = luci
  L2 = L2.http
  L2 = L2.getenv
  L3 = "REMOTE_ADDR"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "newPwd"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L1 = 1502
  elseif L2 == "127.0.0.1" then
    L4 = require
    L5 = "xiaoqiang.util.XQSecureUtil"
    L4 = L4(L5)
    L5 = L4.savePlaintextPwd
    L6 = "admin"
    L7 = L3
    L5 = L5(L6, L7)
    if L5 then
      L1 = 0
    else
      L1 = 1553
    end
  else
    L1 = 1624
  end
  if L1 ~= 0 then
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = L1
    L4 = L4(L5)
    L0.msg = L4
  end
  L0.code = L1
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
changePassword = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQEcos"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = L1.getWifissid
  L3 = L3()
  L4 = {}
  L4.code = 0
  if L2 then
    L5 = L0.getEcosInfo
    L6 = L2
    L5 = L5(L6)
    if L5 then
      L5.ssid = L3
      L4.info = L5
    else
      L4.code = 1625
    end
  else
    L4.code = 1523
  end
  L5 = L4.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L4.code
    L5 = L5(L6)
    L4.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
getEcosInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.module.XQEcos"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "key"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "on"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = {}
  L4.code = 0
  if L1 then
    L5 = _UPVALUE1_
    L5 = L5.macaddr
    L6 = L1
    L5 = L5(L6)
    if L5 and L2 and L3 then
      if L2 == "roaming" then
        L5 = L0.ecosWirelessRoamingSwitch
        L6 = L1
        L7 = L3 == 1
        L5 = L5(L6, L7)
        if not L5 then
          L4.code = 1626
        end
      end
  end
  else
    L4.code = 1523
  end
  L5 = L4.code
  if L5 ~= 0 then
    L5 = _UPVALUE2_
    L5 = L5.getErrorMessage
    L6 = L4.code
    L5 = L5(L6)
    L4.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
ecosSwitch = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQEcos"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  if L1 then
    L3 = _UPVALUE1_
    L3 = L3.macaddr
    L4 = L1
    L3 = L3(L4)
    if L3 then
      L3 = L0.ecosUpgrade
      L4 = L1
      L3(L4)
  end
  else
    L2.code = 1523
  end
  L3 = L2.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
ecosUpgrade = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQEcos"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  if L1 then
    L3 = _UPVALUE1_
    L3 = L3.macaddr
    L4 = L1
    L3 = L3(L4)
    if L3 then
      L3 = L0.ecosUpgradeStatus
      L4 = L1
      L3 = L3(L4)
      L2.status = L3
  end
  else
    L2.code = 1523
  end
  L3 = L2.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getEcosUpgradeStatus = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getHwnatStatus
  L1 = L1()
  L0.status = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
hwnatStatus = L9
function L9()
  local L0, L1, L2
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "on"
  L1, L2 = L1(L2)
  L0 = L0(L1, L2)
  if L0 == 1 then
    L0 = true
    if L0 then
      goto lbl_13
    end
  end
  L0 = false
  ::lbl_13::
  L1 = _UPVALUE1_
  L1 = L1.hwnatSwitch
  L2 = L0
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
  if L0 then
    L1 = _UPVALUE2_
    L1 = L1.forkReboot
    L1()
  end
end
hwnatSwitch = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.httpStatus
  L1 = L1()
  L0.status = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
httpStatus = L9
function L9()
  local L0, L1, L2
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "on"
  L1, L2 = L1(L2)
  L0 = L0(L1, L2)
  if L0 == 1 then
    L0 = true
    if L0 then
      goto lbl_13
    end
  end
  L0 = false
  ::lbl_13::
  L1 = _UPVALUE1_
  L1 = L1.httpSwitch
  L2 = L0
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
httpSwitch = L9
function L9()
  local L0, L1, L2
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "on"
  L1, L2 = L1(L2)
  L0 = L0(L1, L2)
  if L0 == 1 then
    L0 = true
    if L0 then
      goto lbl_13
    end
  end
  L0 = false
  ::lbl_13::
  L1 = _UPVALUE1_
  L1 = L1.ustackSwitch
  L2 = L0
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
ustackSwitch = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.usberror = false
  L2 = L0.exec
  L3 = "lsusb"
  L2 = L2(L3)
  if L2 then
    L4 = L2
    L3 = L2.match
    L5 = "Bus 002 Device 002:"
    L3 = L3(L4, L5)
    if L3 then
      L1.usberror = true
    end
  end
  L1.lsusb = L2
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
lsusb = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "xiaoqiang.module.XQExWifiConfSync"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQExtendWifi"
  L1 = L1(L2)
  L2 = require
  L3 = "cjson"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "syn_root_dir"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "syn_config"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "extendwifi_act"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "remote_router_id"
  L6 = L6(L7)
  L7 = 1
  L8 = {}
  L8.code = 0
  if L4 ~= "0" then
    L9 = _UPVALUE1_
    L9 = L9.log
    L10 = L7
    L11 = "enter extendwifiConfigSync"
    L9(L10, L11)
    L9 = L0.extendwifi_config_sync
    L10 = L5
    L11 = nil
    L9, L10, L11, L12, L13 = L9(L10, L11)
    if L9 ~= 0 then
      L8.code = L9
      L14 = _UPVALUE2_
      L14 = L14.getErrorMessage
      L15 = L8.code
      L14 = L14(L15)
      L8.msg = L14
      L14 = _UPVALUE0_
      L14 = L14.write_json
      L15 = L8
      return L14(L15)
    end
    if L10 then
      L14 = _UPVALUE1_
      L14 = L14.log
      L15 = L7
      L16 = "ssid_24g: "
      L17 = L10
      L16 = L16 .. L17
      L14(L15, L16)
      L8.ssid_24g = L10
      if L11 then
        L14 = _UPVALUE1_
        L14 = L14.log
        L15 = L7
        L16 = "passwd_24g: "
        L17 = L11
        L16 = L16 .. L17
        L14(L15, L16)
        L8.password_24g = L11
      end
    end
    if L12 then
      L14 = _UPVALUE1_
      L14 = L14.log
      L15 = L7
      L16 = "ssid_5g: "
      L17 = L12
      L16 = L16 .. L17
      L14(L15, L16)
      L8.ssid_5g = L12
      if L13 then
        L14 = _UPVALUE1_
        L14 = L14.log
        L15 = L7
        L16 = "passwd_5g: "
        L17 = L13
        L16 = L16 .. L17
        L14(L15, L16)
        L8.password_5g = L13
      end
    end
  end
  if L3 == "" or L3 == nil then
    L8.file_sync = true
  elseif L5 == "2" then
    L9 = L2.decode
    L10 = L3
    L9 = L9(L10)
    L10 = nil
    if L6 == "" or L6 == nil then
      L11 = {}
      L11.api = 118
      L11.sources = L9
      L10 = L11
    else
      L11 = {}
      L11.api = 118
      L11.sources = L9
      L11.remote_router_id = L6
      L10 = L11
    end
    L11 = L2.encode
    L12 = L10
    L11 = L11(L12)
    L12 = _UPVALUE1_
    L12 = L12.log
    L13 = L7
    L14 = "get payload_j:"
    L15 = L11
    L14 = L14 .. L15
    L12(L13, L14)
    L12 = L1.ExtendWifiCallNewRouterDataCenterAPI
    L13 = L5
    L14 = L11
    L12 = L12(L13, L14)
    L13 = L12.code
    if L13 ~= 0 then
      L8.file_sync = false
      L13 = _UPVALUE1_
      L13 = L13.log
      L14 = L7
      L15 = "func(extend.ExtendWifiCallNewRouterDataCenterAPI)ret.code:"
      L16 = L12.code
      L17 = " msg:"
      L18 = _UPVALUE2_
      L18 = L18.getErrorMessage
      L19 = L12.code
      L18 = L18(L19)
      L15 = L15 .. L16 .. L17 .. L18
      L13(L14, L15)
    else
      L13 = L2.decode
      L14 = L12.msg
      L13 = L13(L14)
      L14 = L13.code
      if L14 ~= 0 then
        L8.file_sync = false
        L14 = _UPVALUE1_
        L14 = L14.log
        L15 = L7
        L16 = "func(extend.ExtendWifiCallNewRouterDataCenterAPI)ret:success,json(ret.msg):"
        L17 = L13.code
        L18 = " msg:"
        L19 = _UPVALUE2_
        L19 = L19.getErrorMessage
        L20 = L13.code
        L19 = L19(L20)
        L16 = L16 .. L17 .. L18 .. L19
        L14(L15, L16)
      else
        L8.file_sync = true
      end
    end
  else
    L9 = nil
    L10 = string
    L10 = L10.gsub
    L11 = L3
    L12 = "\\\""
    L13 = "\""
    L10 = L10(L11, L12, L13)
    L11 = _UPVALUE1_
    L11 = L11.log
    L12 = L7
    L13 = "get sync_dir_sub:"
    L14 = L10
    L13 = L13 .. L14
    L11(L12, L13)
    if L6 == "" or L6 == nil then
      L11 = "sources="
      L12 = L10
      L9 = L11 .. L12
    else
      L11 = "sources="
      L12 = L10
      L13 = "&remote_router_id="
      L14 = L6
      L9 = L11 .. L12 .. L13 .. L14
    end
    L11 = nil
    L12 = L1.ExtendWifiRequestRemoteAPIForLua
    L13 = "/service/datacenter/set_sync_router_file"
    L14 = "1"
    L15 = L9
    L12 = L12(L13, L14, L15)
    L11 = L12
    L12 = L11.code
    if L12 == 0 then
      L12 = L2.decode
      L13 = L11.msg
      L12 = L12(L13)
      L13 = L12.code
      if L13 == 0 then
        L8.file_sync = true
      else
        L8.file_sync = false
      end
    else
      L8.file_sync = false
    end
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L8
  L9(L10)
  L9 = L0.extendwifi_config_sync
  L10 = L5
  L11 = "finish"
  L9(L10, L11)
end
extendwifiConfigSync = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQExWifiConfSync"
  L0 = L0(L1)
  L1 = 6
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = L1
  L5 = "enter extendwifiConfigPull"
  L3(L4, L5)
  L3 = L0.extendwifi_config_pull
  L3 = L3()
  if not L3 or L3 ~= 0 then
    L2.code = 1
    L4 = _UPVALUE1_
    L4 = L4.status
    L5 = 500
    L6 = "config file pull failed!"
    L4(L5, L6)
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
extendwifiConfigPull = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQExWifiConfSync"
  L2 = L2(L3)
  L3 = "/tmp/config.tar.gz"
  L4 = "/tmp/extendwifi/"
  L5 = L4
  L6 = "config.tar.gz"
  L5 = L5 .. L6
  L6 = 1
  L7 = 6
  L8 = {}
  L8.code = L6
  L9 = _UPVALUE0_
  L9 = L9.log
  L10 = L7
  L11 = "enter extendwifiConfigPush"
  L9(L10, L11)
  L9 = _UPVALUE1_
  L9 = L9.setfilehandler
  function L10(A0, A1, A2)
    local L3, L4, L5, L6
    L3 = fp
    if not L3 and A0 then
      L3 = A0.name
      if L3 == "config" then
        L3 = io
        L3 = L3.open
        L4 = _UPVALUE0_
        L5 = "w"
        L3 = L3(L4, L5)
        fp = L3
        L3 = fp
        if not L3 then
          L3 = _UPVALUE1_
          L3 = L3.log
          L4 = _UPVALUE2_
          L5 = "file open failed: "
          L6 = _UPVALUE0_
          L5 = L5 .. L6
          L3(L4, L5)
        end
      end
    end
    if A1 then
      L3 = fp
      L4 = L3
      L3 = L3.write
      L5 = A1
      L3(L4, L5)
    end
    if A2 then
      L3 = fp
      L4 = L3
      L3 = L3.close
      L3(L4)
    end
  end
  L9(L10)
  L9 = _UPVALUE1_
  L9 = L9.formvalue
  L10 = "config"
  L9 = L9(L10)
  if L9 then
    L9 = fp
    if L9 then
      L6 = 0
    end
  end
  if L6 ~= 0 then
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = L7
    L11 = "config file store failed!"
    L9(L10, L11)
    L8.code = L6
    L9 = _UPVALUE1_
    L9 = L9.status
    L10 = 500
    L11 = "config file store failed!"
    L9(L10, L11)
    L9 = _UPVALUE1_
    L9 = L9.write_json
    L10 = L8
    return L9(L10)
  end
  L9 = _UPVALUE1_
  L9 = L9.formvalue
  L10 = "checksum"
  L9 = L9(L10)
  if not L9 then
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = L7
    L12 = "config file checksum get failed!"
    L10(L11, L12)
    L8.code = 1
    L10 = _UPVALUE1_
    L10 = L10.status
    L11 = 500
    L12 = "config file checksum get failed!"
    L10(L11, L12)
    L10 = _UPVALUE1_
    L10 = L10.write_json
    L11 = L8
    return L10(L11)
  end
  L10 = _UPVALUE0_
  L10 = L10.log
  L11 = L7
  L12 = "config file checksum "
  L13 = L9
  L12 = L12 .. L13
  L10(L11, L12)
  L10 = os
  L10 = L10.execute
  L11 = "rm -rf "
  L12 = L4
  L11 = L11 .. L12
  L10(L11)
  L10 = L0.mkdir
  L11 = L4
  L12 = 600
  L10(L11, L12)
  L10 = os
  L10 = L10.execute
  L11 = "mv "
  L12 = L3
  L13 = " "
  L14 = L4
  L15 = ">/dev/null 2>&1"
  L11 = L11 .. L12 .. L13 .. L14 .. L15
  L10(L11)
  L10 = os
  L10 = L10.execute
  L11 = "tar -C "
  L12 = L4
  L13 = " -zxvf "
  L14 = L5
  L15 = " >/dev/null 2>&1"
  L11 = L11 .. L12 .. L13 .. L14 .. L15
  L10(L11)
  L10 = io
  L10 = L10.open
  L11 = L5
  L10 = L10(L11)
  if not L10 then
    L11 = _UPVALUE0_
    L11 = L11.log
    L12 = L7
    L13 = "config file open failed!"
    L11(L12, L13)
    L11 = os
    L11 = L11.execute
    L12 = "rm -rf "
    L13 = L4
    L12 = L12 .. L13
    L11(L12)
    L8.code = 1
    L11 = _UPVALUE1_
    L11 = L11.status
    L12 = 500
    L13 = "config file open failed!"
    L11(L12, L13)
    L11 = _UPVALUE1_
    L11 = L11.write_json
    L12 = L8
    return L11(L12)
  end
  L12 = L10
  L11 = L10.close
  L11(L12)
  L11 = L1.md5File
  L12 = L5
  L11 = L11(L12)
  if not L11 then
    L12 = _UPVALUE0_
    L12 = L12.log
    L13 = L7
    L14 = "config file md5sum calculate failed!"
    L12(L13, L14)
    L12 = os
    L12 = L12.execute
    L13 = "rm -rf "
    L14 = L4
    L13 = L13 .. L14
    L12(L13)
    L8.code = 1
    L12 = _UPVALUE1_
    L12 = L12.status
    L13 = 500
    L14 = "config file md5sum calculate failed!"
    L12(L13, L14)
    L12 = _UPVALUE1_
    L12 = L12.write_json
    L13 = L8
    return L12(L13)
  end
  if L11 ~= L9 then
    L12 = _UPVALUE0_
    L12 = L12.log
    L13 = L7
    L14 = "config file checksum failed, checksum: "
    L15 = L9
    L16 = " md5sum: "
    L17 = L11
    L14 = L14 .. L15 .. L16 .. L17
    L12(L13, L14)
    L12 = os
    L12 = L12.execute
    L13 = "rm -rf "
    L14 = L4
    L13 = L13 .. L14
    L12(L13)
    L8.code = 1
    L12 = _UPVALUE1_
    L12 = L12.status
    L13 = 500
    L14 = "config file checksum failed!"
    L12(L13, L14)
    L12 = _UPVALUE1_
    L12 = L12.write_json
    L13 = L8
    return L12(L13)
  end
  L12 = _UPVALUE0_
  L12 = L12.log
  L13 = L7
  L14 = "config file checksum ok!"
  L12(L13, L14)
  L12, L13, L14, L15 = nil, nil, nil, nil
  L16 = L2.extendwifi_config_merge
  L16, L17, L18, L19, L20 = L16()
  L15 = L20
  L14 = L19
  L13 = L18
  L12 = L17
  L6 = L16
  if not L6 or L6 ~= 0 then
    L8.code = 1
  else
    L8.code = 0
    if L12 then
      L8.ssid_24g = L12
      if L13 then
        L8.password_24g = L13
      end
    end
    if L14 then
      L8.ssid_5g = L14
      if L15 then
        L8.password_5g = L15
      end
    end
  end
  L16 = _UPVALUE1_
  L16 = L16.write_json
  L17 = L8
  L16(L17)
  L16 = os
  L16 = L16.execute
  L17 = "rm -rf "
  L18 = L4
  L17 = L17 .. L18
  L16(L17)
end
extendwifiConfigPush = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.module.XQExWifiConfSync"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "wifi"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "reboot"
  L2 = L2(L3)
  L3 = 6
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE1_
  L5 = L5.log
  L6 = L3
  L7 = "enter extendwifiConfigFini"
  L5(L6, L7)
  if L2 then
    L5 = _UPVALUE1_
    L5 = L5.log
    L6 = L3
    L7 = "will do reboot ..."
    L5(L6, L7)
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L4
    L5(L6)
    L5 = L0.extendwifi_reboot
    L5()
  elseif L1 then
    L5 = _UPVALUE1_
    L5 = L5.log
    L6 = L3
    L7 = "turn off hotspot ..."
    L5(L6, L7)
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L4
    L5(L6)
    L5 = L0.extendwifi_hotspot_shutdown
    L5()
  else
    L5 = _UPVALUE1_
    L5 = L5.log
    L6 = L3
    L7 = "both wifi and reboot are nil, do nothing"
    L5(L6, L7)
    L4.code = 1
    L5 = _UPVALUE0_
    L5 = L5.status
    L6 = 400
    L5(L6)
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L4
    L5(L6)
  end
end
extendwifiConfigFini = L9
function L9(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.module.XQBackup"
  L1 = L1(L2)
  L2 = L1.getFullPath
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L3 = _UPVALUE0_
    L3 = L3.status
    L4 = 404
    L5 = "Not Found"
    L3(L4, L5)
    return
  end
  L3 = _UPVALUE0_
  L3 = L3.write_file
  L4 = L2
  L3(L4)
end
cDownload = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQBackup"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "keys"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if L4 then
    L2 = nil
  else
    L4 = L0.split
    L5 = L2
    L6 = ","
    L4 = L4(L5, L6)
    L2 = L4
  end
  L4 = L1.backup
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L3.code = 1627
  else
    L3.file = L4
  end
  L5 = L3.code
  if L5 ~= 0 then
    L5 = _UPVALUE2_
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
cBackup = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.module.XQBackup"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L2 = 0
  L3 = true
  L4 = luci
  L4 = L4.sys
  L4 = L4.uniqueid
  L5 = 16
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = "/tmp/"
  L6 = L4
  L5 = L5 .. L6
  L6 = L5
  L7 = "/"
  L8 = L0.TAR_FILE_NAME
  L6 = L6 .. L7 .. L8
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.getenv
  L9 = "CONTENT_LENGTH"
  L8, L9, L10, L11, L12, L13 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13)
  L8 = {}
  if 102400 < L7 then
    L3 = false
  end
  if L5 then
    L9 = os
    L9 = L9.execute
    L10 = "mkdir -p "
    L11 = L5
    L12 = " >/dev/null 2>&1"
    L10 = L10 .. L11 .. L12
    L9(L10)
  end
  L9 = _UPVALUE0_
  L9 = L9.setfilehandler
  function L10(A0, A1, A2)
    local L3, L4, L5
    L3 = _UPVALUE0_
    if L3 then
      L3 = fp
      if not L3 and A0 then
        L3 = A0.name
        if L3 == "image" then
          L3 = io
          L3 = L3.open
          L4 = _UPVALUE1_
          L5 = "w"
          L3 = L3(L4, L5)
          fp = L3
        end
      end
      if A1 then
        L3 = fp
        L4 = L3
        L3 = L3.write
        L5 = A1
        L3(L4, L5)
      end
      if A2 then
        L3 = fp
        L4 = L3
        L3 = L3.close
        L3(L4)
      end
    else
      L3 = 1630
      _UPVALUE2_ = L3
    end
  end
  L9(L10)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "image"
  L9 = L9(L10)
  if L9 then
    L9 = fp
    if L9 then
      L2 = 0
    end
  end
  L9 = L1.system
  L9 = L9.tr069
  if L9 then
    L9 = L1.system
    L9 = L9.tr069
    if L9 == "1" then
      L9 = _UPVALUE0_
      L9 = L9.formvalue
      L10 = "is_tr069"
      L9 = L9(L10)
      if L9 == "1" then
        L10 = os
        L10 = L10.execute
        L11 = "mv /tmp/cfgbackup.tar.gz "
        L12 = L6
        L13 = " >/dev/null 2>&1"
        L11 = L11 .. L12 .. L13
        L10(L11)
      end
    end
  end
  if L2 == 0 then
    L9 = L0.extract
    L10 = L6
    L11 = L5
    L9 = L9(L10, L11)
    if L9 == 0 then
      L10 = L0.getdes
      L11 = nil
      L10 = L10(L11)
      L8.des = L10
    else
      L2 = 1629
    end
  end
  L9 = os
  L9 = L9.execute
  L10 = "rm -rf "
  L11 = L6
  L12 = " >/dev/null 2>&1"
  L10 = L10 .. L11 .. L12
  L9(L10)
  L9 = os
  L9 = L9.execute
  L10 = "rm -rf "
  L11 = L5
  L12 = " >/dev/null 2>&1"
  L10 = L10 .. L11 .. L12
  L9(L10)
  if L2 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L2
    L9 = L9(L10)
    L8.msg = L9
  end
  L8.code = L2
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L8
  L9(L10)
end
cUpload = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQBackup"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "keys"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L3
  L5 = L5(L6)
  if L5 then
    L3 = nil
  else
    L5 = L0.split
    L6 = L3
    L7 = ","
    L5 = L5(L6, L7)
    L3 = L5
  end
  L5 = L2.restore
  L6 = nil
  L7 = L3
  L5 = L5(L6, L7)
  if L5 == 1 then
    L4.code = 1628
  elseif L5 == 2 then
    L4.code = 1629
  end
  L6 = L4.code
  if L6 ~= 0 then
    L6 = _UPVALUE2_
    L6 = L6.getErrorMessage
    L7 = L4.code
    L6 = L6(L7)
    L4.msg = L6
  else
    L6 = L1.getLanIp
    L6 = L6()
    L4.ip = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L4
  L6(L7)
end
cRestore = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQIPConflict"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L1.ip_conflict_resolution
  L3 = L3()
  if L3 then
    L3 = L0.forkExec
    L4 = "/usr/sbin/ip_changed.sh lan"
    L3(L4)
  else
    L2.code = 1631
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
rIpConflict = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQDeviceUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQMessageBox"
  L4 = L4(L5)
  L5 = {}
  L6 = "wan_info"
  L7 = "link_info"
  L5[1] = L6
  L5[2] = L7
  L5[3] = L8
  L6 = {}
  L6.code = 0
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L7 = L7(L8)
  if L8 then
    L7 = L5
  else
    L7 = L8
  end
  for L11, L12 in L8, L9, L10 do
    if L12 == "wan_info" then
      L13 = L2.getWanLanNetworkStatistics
      L13 = L13(L14)
      if L14 then
        if L16 then
          if 0 < L16 then
          end
        end
      end
      if L13 then
        L17 = L15 or L17
        if not L15 then
          L17 = ""
        end
        L16.ip = L17
        L17 = tonumber
        L18 = L13.upspeed
        L17 = L17(L18)
        L17 = L17 or L17
        L16.upspeed = L17
        L17 = tonumber
        L18 = L13.downspeed
        L17 = L17(L18)
        L17 = L17 or L17
        L16.downspeed = L17
        L17 = tonumber
        L18 = L13.maxuploadspeed
        L17 = L17(L18)
        L17 = L17 or L17
        L16.maxup = L17
        L17 = tonumber
        L18 = L13.maxdownloadspeed
        L17 = L17(L18)
        L17 = L17 or L17
        L16.maxdown = L17
        L6.wan = L16
      end
    elseif L12 == "link_info" then
      L13 = {}
      L13.type = "line"
      L13.signal = 0
      if L15 then
        L13.type = "wifi"
        if L15 < -70 then
          L13.signal = 3
        elseif -60 < L15 then
          L13.signal = 2
        else
          L13.signal = 1
        end
      end
      L6.link = L13
    elseif L12 == "upgrade_info" then
      L13 = L4.getMessages
      L13 = L13()
      for L17, L18 in L14, L15, L16 do
        L19 = L18.type
        if L19 == 1 then
          L19 = L18.data
          L6.upgrade = L19
          L19 = L6.upgrade
          L19.upgrade = 1
        end
      end
      if not L14 then
        L14.upgrade = 0
        L6.upgrade = L14
      end
    end
  end
  L8(L9)
end
toolbarInfo = L9
function L9()
  local L0, L1
  L0 = getVasInfo
  L1 = true
  L0(L1)
end
getVasInfoNew = L9
function L9()
  local L0, L1, L2, L3
  function L0()
    local L0, L1
    L0 = _UPVALUE0_
    L0 = L0.forkExec
    L1 = "/usr/sbin/vasinfo_fw.sh off;/etc/init.d/firewall reload"
    L0(L1)
  end
  L1 = setVasInfo
  L2 = true
  L3 = L0
  L1(L2, L3)
end
setVasInfoNew = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L3 = L0
  L2 = L0.get
  L4 = "usb"
  L5 = "config"
  L6 = "usb2_enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "enable"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = result
    L4.code = 1502
    L4 = _UPVALUE0_
    L4 = L4.write_json
    L5 = result
    L4(L5)
    return
  end
  if L2 == L3 then
    if L3 == "0" then
      L5 = L0
      L4 = L0.set
      L6 = "usb"
      L7 = "config"
      L8 = "usb2_enable"
      L9 = "1"
      L4(L5, L6, L7, L8, L9)
    else
      L5 = L0
      L4 = L0.set
      L6 = "usb"
      L7 = "config"
      L8 = "usb2_enable"
      L9 = "0"
      L4(L5, L6, L7, L8, L9)
    end
    L5 = L0
    L4 = L0.commit
    L6 = "usb"
    L4(L5, L6)
    L4 = L1.exec
    L5 = string
    L5 = L5.format
    L6 = "/etc/init.d/usb restart"
    L5, L6, L7, L8, L9 = L5(L6)
    L4(L5, L6, L7, L8, L9)
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = {}
  L5.code = 0
  L5.enable = L3
  L4(L5)
end
setUsbMode3 = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "usb"
  L4 = "config"
  L5 = "usb2_enable"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 == 1 then
      L2 = _UPVALUE0_
      L2 = L2.write_json
      L3 = {}
      L3.code = 0
      L3.enable = 0
      L2(L3)
  end
  else
    L2 = _UPVALUE0_
    L2 = L2.write_json
    L3 = {}
    L3.code = 0
    L3.enable = 1
    L2(L3)
  end
end
getUsbMode3 = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L3 = L0
  L2 = L0.get
  L4 = "usb"
  L5 = "config"
  L6 = "usb2_enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "enable"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = result
    L4.code = 1502
    L4 = _UPVALUE0_
    L4 = L4.write_json
    L5 = result
    L4(L5)
    return
  end
  if L2 ~= L3 then
    L5 = L0
    L4 = L0.set
    L6 = "usb"
    L7 = "config"
    L8 = "usb2_enable"
    L9 = L3
    L4(L5, L6, L7, L8, L9)
    L5 = L0
    L4 = L0.commit
    L6 = "usb"
    L4(L5, L6)
    L4 = L1.exec
    L5 = string
    L5 = L5.format
    L6 = "/etc/init.d/usb restart"
    L5, L6, L7, L8, L9 = L5(L6)
    L4(L5, L6, L7, L8, L9)
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = {}
  L5.code = 0
  L5.enable = L3
  L4(L5)
end
setUsbMode2 = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "usb"
  L4 = "config"
  L5 = "usb2_enable"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 == 1 then
      L2 = _UPVALUE0_
      L2 = L2.write_json
      L3 = {}
      L3.code = 0
      L3.enable = 1
      L2(L3)
  end
  else
    L2 = _UPVALUE0_
    L2 = L2.write_json
    L3 = {}
    L3.code = 0
    L3.enable = 0
    L2(L3)
  end
end
getUsbMode2 = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = require
  L3 = "xiaoqiang.module.XQVASModule"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = nil
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "key"
  L5 = L5(L6)
  L5 = L5 or L5
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "web"
  L6 = L6(L7)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "callback"
  L7 = L7(L8)
  if L5 == "new" then
    L8 = L2.get_new_vas
    L8 = L8()
    L4 = L8
  else
    L8 = L2.get_vas
    L8 = L8()
    L4 = L8
  end
  L8 = next
  L8 = L8(L9)
  if L8 ~= nil then
    L3.vas = L4
    L8 = tonumber
    L8 = L8(L9)
    if L8 == 1 then
      L8 = {}
      for L12, L13 in L9, L10, L11 do
        L14 = table
        L14 = L14.insert
        L15 = L8
        L16 = L12
        L14(L15, L16)
      end
      L3.web = L9
    end
  end
  if A1 then
    L8 = type
    L8 = L8(L9)
    if L8 == "function" then
      L8 = A1
      L8()
    end
  end
  if A0 and L7 then
    L8 = _UPVALUE1_
    L8 = L8.nvramGet
    L8 = L8(L9, L10)
    if L9 then
      if L9 == 1 then
        L3.closed = 0
    end
    else
      L3.closed = 1
    end
    L9(L10, L11)
  else
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L8(L9)
  end
end
getVasInfo = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "xiaoqiang.module.XQVASModule"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "info"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "callback"
  L5 = L5(L6)
  if L4 then
    L6 = {}
    for L10, L11 in L7, L8, L9 do
      L12 = tonumber
      L13 = L11
      L12 = L12(L13)
      if L12 then
        L12 = tonumber
        L13 = L11
        L12 = L12(L13)
        L6[L10] = L12
      end
    end
    L7(L8)
  end
  if A1 then
    L6 = type
    L6 = L6(L7)
    if L6 == "function" then
      L6 = A1
      L6()
    end
  end
  if A0 and L5 then
    L6 = _UPVALUE0_
    L6 = L6.write_jsonp
    L6(L7, L8)
  else
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L6(L7)
  end
end
setVasInfo = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE2_
    L3 = L3.macaddr
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_29
    end
  end
  L1.code = 1523
  L3 = _UPVALUE3_
  L3 = L3.getErrorMessage
  L4 = L1.code
  L3 = L3(L4)
  L1.msg = L3
  goto lbl_33
  ::lbl_29::
  L3 = L0.get_device_mode_info
  L4 = L2
  L3 = L3(L4)
  L1.status = L3
  ::lbl_33::
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
networkAccessControlStatus = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3 = L3(L4)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "enable"
  L5, L6, L7, L8 = L5(L6)
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L2
  L5 = L5(L6)
  if not L5 then
    L5 = _UPVALUE2_
    L5 = L5.macaddr
    L6 = L2
    L5 = L5(L6)
    if L5 then
      L5 = L0.check_mode
      L6 = L3
      L5 = L5(L6)
      if L5 then
        goto lbl_44
      end
    end
  end
  L1.code = 1523
  L5 = _UPVALUE3_
  L5 = L5.getErrorMessage
  L6 = L1.code
  L5 = L5(L6)
  L1.msg = L5
  goto lbl_57
  ::lbl_44::
  L5 = _UPVALUE1_
  L5 = L5.macFormat
  L6 = L2
  L5 = L5(L6)
  L2 = L5
  L5 = L0.set_device_mode_info
  L6 = L2
  L7 = L4
  L8 = L3
  L5 = L5(L6, L7, L8)
  L1.status = L5
  L5 = L0.apply
  L5()
  ::lbl_57::
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
networkAccessControlSet = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQParentControl"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enable"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "frequency"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "timeseg"
  L6 = L6(L7)
  L7 = _UPVALUE1_
  L7 = L7.isStrNil
  L8 = L3
  L7 = L7(L8)
  if not L7 then
    L7 = _UPVALUE2_
    L7 = L7.macaddr
    L8 = L3
    L7 = L7(L8)
    if L7 and L4 then
      L7 = _UPVALUE1_
      L7 = L7.isStrNil
      L8 = L5
      L7 = L7(L8)
      if not L7 then
        L7 = _UPVALUE1_
        L7 = L7.isStrNil
        L8 = L6
        L7 = L7(L8)
        if not L7 then
          L8 = L6
          L7 = L6.match
          L9 = "[%d:]+%-[%d:]+"
          L7 = L7(L8, L9)
          if L7 then
            goto lbl_58
          end
        end
      end
    end
  end
  L2.code = 1523
  goto lbl_74
  ::lbl_58::
  L7 = L1.add_device_info
  L8 = L3
  L9 = tonumber
  L10 = L4
  L9 = L9(L10)
  L10 = L0.split
  L11 = L5
  L12 = ","
  L10 = L10(L11, L12)
  L11 = L6
  L7 = L7(L8, L9, L10, L11)
  if not L7 then
    L2.code = 1632
  else
    L2.id = L7
  end
  ::lbl_74::
  L7 = L2.code
  if L7 ~= 0 then
    L7 = _UPVALUE3_
    L7 = L7.getErrorMessage
    L8 = L2.code
    L7 = L7(L8)
    L2.msg = L7
  else
    L7 = L1.apply
    L7()
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L2
  L7(L8)
end
parentalctlAdd = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQParentControl"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "id"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mac"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "enable"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "frequency"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "timeseg"
  L7 = L7(L8)
  L8 = _UPVALUE1_
  L8 = L8.isStrNil
  L9 = L3
  L8 = L8(L9)
  if not L8 then
    L8 = _UPVALUE1_
    L8 = L8.isStrNil
    L9 = L4
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE2_
      L8 = L8.macaddr
      L9 = L4
      L8 = L8(L9)
      if L8 then
        goto lbl_49
      end
    end
  end
  L2.code = 1523
  goto lbl_68
  ::lbl_49::
  if L6 then
    L8 = L0.split
    L9 = L6
    L10 = ","
    L8 = L8(L9, L10)
    L6 = L8
  end
  L8 = L1.update_device_info
  L9 = L3
  L10 = L4
  L11 = tonumber
  L12 = L5
  L11 = L11(L12)
  L12 = L6
  L13 = L7
  L8 = L8(L9, L10, L11, L12, L13)
  if not L8 then
    L2.code = 1633
  end
  ::lbl_68::
  L8 = L2.code
  if L8 ~= 0 then
    L8 = _UPVALUE3_
    L8 = L8.getErrorMessage
    L9 = L2.code
    L8 = L8(L9)
    L2.msg = L8
  else
    L8 = L1.apply
    L8()
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L2
  L8(L9)
end
parentalctlUpdate = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "id"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L1.code = 1523
  else
    L3 = L0.delete_device_info
    L4 = L2
    L3(L4)
  end
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = L1.code
    L3 = L3(L4)
    L1.msg = L3
  else
    L3 = L0.apply
    L3()
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
parentalctlDelete = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE2_
    L3 = L3.macaddr
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_24
    end
  end
  L1.code = 1523
  goto lbl_31
  ::lbl_24::
  L3 = L0.get_device_info
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L4 = L3.rules
    L1.info = L4
  end
  ::lbl_31::
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE3_
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
parentalctlInfo = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE2_
    L3 = L3.macaddr
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_24
    end
  end
  L1.code = 1523
  goto lbl_28
  ::lbl_24::
  L3 = L0.get_parentctl_url_filter
  L4 = L2
  L3 = L3(L4)
  L1.urlfilter = L3
  ::lbl_28::
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
parentalctlgetUrlFilter = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.macaddr
    L5 = L2
    L4 = L4(L5)
    if L4 and L3 then
      goto lbl_30
    end
  end
  L1.code = 1523
  goto lbl_34
  ::lbl_30::
  L4 = L0.set_parentctl_url_filter
  L5 = L2
  L6 = L3
  L4(L5, L6)
  ::lbl_34::
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE3_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  else
    L4 = L0.get_parentctl_url_filter
    L5 = L2
    L4 = L4(L5)
    L5 = L4.mode
    L1.mode = L5
    L5 = L4.count
    L1.count = L5
    L5 = L0.apply
    L5()
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
parentalctlSetUrlFilter = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.macaddr
    L5 = L2
    L4 = L4(L5)
    if L4 and L3 then
      goto lbl_30
    end
  end
  L1.code = 1523
  goto lbl_35
  ::lbl_30::
  L4 = L0.get_parentctl_url_list
  L5 = L2
  L6 = L3
  L4 = L4(L5, L6)
  L1.list = L4
  ::lbl_35::
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE3_
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
parentalctlGetUrl = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.module.XQParentControl"
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
  L5 = "opt"
  L4, L5, L6, L7, L11, L12, L13, L14 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "url"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "newurl"
  L6 = L6(L7)
  L7 = _UPVALUE1_
  L7 = L7.isStrNil
  L7 = L7(L8)
  if not L7 then
    L7 = _UPVALUE2_
    L7 = L7.macaddr
    L7 = L7(L8)
    if L7 and L3 and L4 and L5 then
      if not L6 then
        goto lbl_56
      end
      L7 = _UPVALUE1_
      L7 = L7.isDomain
      L7 = L7(L8)
      if L7 then
        goto lbl_56
      end
    end
  end
  L1.code = 1523
  goto lbl_91
  ::lbl_56::
  L7 = _UPVALUE1_
  L7 = L7.isDomain
  L7 = L7(L8)
  if not L7 and L3 == 1 then
    L7 = L5.match
    L7 = L7(L8, L9)
    if L7 then
      L7 = require
      L7 = L7(L8)
      L5 = L8
      for L11, L12 in L8, L9, L10 do
        L13 = _UPVALUE1_
        L13 = L13.isDomain
        L14 = L12
        L13 = L13(L14)
        if not L13 then
          L1.code = 1523
          break
        end
      end
    end
  end
  ::lbl_91::
  L7 = L1.code
  if L7 ~= 0 then
    L7 = _UPVALUE3_
    L7 = L7.getErrorMessage
    L7 = L7(L8)
    L1.msg = L7
  else
    L7 = L0.edit_parentctl_url_list
    L11 = L5
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L7 = L0.apply
    L7()
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L7(L8)
end
parentalctlSetUrl = L9
function L9()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "switch"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 == 1 then
    L2 = _UPVALUE1_
    L2 = L2.forkExec
    L3 = "lua /usr/sbin/iperf_script.lua start"
    L2(L3)
  else
    L2 = os
    L2 = L2.execute
    L3 = "lua /usr/sbin/iperf_script.lua stop"
    L2(L3)
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
iperf = L9
function L9()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "switch"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  if L1 == 1 then
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/leteng tstart"
    L2(L3)
  else
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/leteng stop"
    L2(L3)
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
qosWangZhe = L9
function L9()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.webAccessInfo
  L0 = L0()
  L0.code = 0
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getWebAccessInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L0.code = 0
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "open"
  L2, L3, L4, L5, L6, L7, L8 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  if L1 == 1 then
    L1 = true
    if L1 then
      goto lbl_15
    end
  end
  L1 = false
  ::lbl_15::
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "opt"
  L4, L5, L6, L7, L8 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_31
    end
  end
  L3 = 0
  ::lbl_31::
  L4 = luci
  L4 = L4.dispatcher
  L4 = L4.getremotemac
  L4 = L4()
  L2 = L2 or L2
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L2
  L5 = L5(L6)
  if not L5 then
    L5 = _UPVALUE2_
    L5 = L5.macaddr
    L6 = L2
    L5 = L5(L6)
    if L5 then
      goto lbl_52
    end
  end
  L0.code = 1523
  goto lbl_72
  ::lbl_52::
  L5 = string
  L5 = L5.lower
  L6 = L2
  L5 = L5(L6)
  L2 = L5
  if L3 == 0 then
    L6 = L2
    L5 = L2.match
    L7 = "^%x[1,3,5,7,9,b,d,f]"
    L5 = L5(L6, L7)
    if L5 then
      L0.code = 1637
  end
  else
    L5 = _UPVALUE3_
    L5 = L5.webAccessControl
    L6 = L1
    L7 = L2
    L8 = L3
    L5(L6, L7, L8)
  end
  ::lbl_72::
  L5 = L0.code
  if L5 ~= 0 then
    L5 = _UPVALUE4_
    L5 = L5.getErrorMessage
    L6 = L0.code
    L5 = L5(L6)
    L0.msg = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L0
  L5(L6)
end
webAccess = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.getSmartVPNInfo
  L3 = L3()
  L4 = L3.switch
  if L4 == 1 then
    L4 = L3.mode
    if L4 == 1 then
      L4 = L0.getProxyList
      L4 = L4()
      L3.ulist = L4
    else
      L4 = L3.mode
      if L4 == 2 then
        L4 = L0.getDeviceList
        L4 = L4()
        L3.mlist = L4
        L4 = L1.getDevicesName
        L5 = L3.mlist
        L4 = L4(L5)
        L3.name = L4
      end
    end
  end
  L2.info = L3
  L4 = L2.code
  if L4 ~= 0 then
    L4 = _UPVALUE0_
    L4 = L4.getErrorMessage
    L5 = L2.code
    L4 = L4(L5)
    L2.msg = L4
  end
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getSmartVPNInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enable"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  if L3 == 1 then
    L3 = 1
    if L3 then
      goto lbl_21
    end
  end
  L3 = 0
  ::lbl_21::
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mode"
  L5, L6, L7 = L5(L6)
  L4 = L4(L5, L6, L7)
  if L4 == 2 then
    L4 = 2
    if L4 then
      goto lbl_33
    end
  end
  L4 = 1
  ::lbl_33::
  L5 = L0.setSmartVPN
  L6 = L3
  L7 = L4
  L5(L6, L7)
  L5 = L2.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
  else
    L5 = L0.getSmartVPNInfo
    L5 = L5()
    L6 = L5.switch
    if L6 == 1 then
      L6 = L5.mode
      if L6 == 1 then
        L6 = L0.getProxyList
        L6 = L6()
        L5.ulist = L6
      else
        L6 = L5.mode
        if L6 == 2 then
          L6 = L0.getDeviceList
          L6 = L6()
          L5.mlist = L6
          L6 = L1.getDevicesName
          L7 = L5.mlist
          L6 = L6(L7)
          L5.name = L6
        end
      end
    end
    L2.info = L5
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
setSmartVPN = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQVPNUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L2.xssCheck
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "url"
  L5, L6, L7, L8, L9, L10, L11 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11)
  L5 = L2.xssCheck
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "urls"
  L6, L7, L8, L9, L10, L11 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "opt"
  L7, L8, L9, L10, L11 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11)
  if L6 == 1 then
    L6 = 1
    if L6 then
      goto lbl_36
    end
  end
  L6 = 0
  ::lbl_36::
  if L4 then
    L7 = L1.editUrl
    L8 = L6
    L9 = {}
    L10 = L4
    L9[1] = L10
    L7(L8, L9)
  elseif L5 then
    L7 = pcall
    L8 = L0.decode
    L9 = L5
    L7, L8 = L7(L8, L9)
    if L7 and L8 then
      L9 = L1.editUrl
      L10 = L6
      L11 = L8
      L9(L10, L11)
    end
  end
  L7 = L3.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L3.code
    L7 = L7(L8)
    L3.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L3
  L7(L8)
end
setSmartVPNUrl = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQVPNUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "macs"
  L3 = L3(L4)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "opt"
  L5, L6, L7, L8, L9 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9)
  if L4 == 1 then
    L4 = 1
    if L4 then
      goto lbl_25
    end
  end
  L4 = 0
  ::lbl_25::
  if L3 and L4 then
    L5 = L1.editMac
    L6 = L4
    L7 = L0.split
    L8 = L3
    L9 = ","
    L7, L8, L9 = L7(L8, L9)
    L5(L6, L7, L8, L9)
  else
    L2.code = 1623
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
setSmartVPNMac = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "open"
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
  L3 = L0.mivpnSwitch
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1.code = 1634
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
miVPN = L9
function L9()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.mivpnInfo
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
miVPNInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.getSysTime
  L2 = L2()
  L1.time = L2
  L2 = _UPVALUE1_
  L2 = L2.isMeshMode
  L2 = L2()
  if L2 then
    L2 = require
    L3 = "luci.util"
    L2 = L2(L3)
    L3 = L2.exec
    L4 = "uci -q get xiaoqiang.common.NETMODE"
    L3 = L3(L4)
    L4 = L2.trim
    L5 = L3
    L4 = L4(L5)
    L1.role = L4
    L4 = _UPVALUE1_
    L4 = L4.isMeshCap
    L4 = L4()
    if L4 then
      L1.role = "whc_cap"
    end
  end
  L2 = _UPVALUE2_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getSysTime = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "time"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "timezone"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "index"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE1_
  L4 = L4.setSysTime
  L5 = L1
  L6 = L2
  L7 = L3
  L4(L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
setSysTime = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "on"
  L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L2 = _UPVALUE1_
  L2 = L2.getLedStatus
  L2 = L2()
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "timer_on"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L4 = _UPVALUE1_
  L4 = L4.getLedTimerStatus
  L4 = L4()
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "timer_open"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "timer_close"
  L6 = L6(L7)
  L7 = {}
  L7.code = 0
  L7.status = L2
  L8 = L4.status
  L7.timer_status = L8
  L8 = L4.timer_open
  L7.timer_open = L8
  L8 = L4.timer_close
  L7.timer_close = L8
  L7.error = 0
  if L1 and L1 ~= L2 then
    L8 = _UPVALUE1_
    L8 = L8.setLedStatus
    if L1 == 1 then
      L9 = true
      if L9 then
        goto lbl_54
      end
    end
    L9 = false
    ::lbl_54::
    L8(L9)
    L7.status = L1
  end
  if L3 and L5 and L6 then
    L8 = L4.status
    if L3 == L8 then
      L8 = L4.timer_open
      if L5 == L8 then
        L8 = L4.timer_close
        if L6 == L8 then
          goto lbl_101
        end
      end
    end
    L8 = _UPVALUE1_
    L8 = L8.setLedTimer
    if L3 == 1 then
      L9 = true
      if L9 then
        goto lbl_79
      end
    end
    L9 = false
    ::lbl_79::
    L10 = L5
    L11 = L6
    L8 = L8(L9, L10, L11)
    L7.timer_status = L8
    L8 = L7.timer_status
    if L8 ~= L3 then
      L7.error = 1
      L8 = _UPVALUE2_
      L8 = L8.log
      L9 = 4
      L10 = string
      L10 = L10.format
      L11 = "luci-routerLed: set timer fail! server_timer_status = %s, timer_status = %s"
      L12 = tostring
      L13 = L3
      L12 = L12(L13)
      L13 = tostring
      L14 = L7.timer_status
      L13, L14 = L13(L14)
      L10, L11, L12, L13, L14 = L10(L11, L12, L13, L14)
      L8(L9, L10, L11, L12, L13, L14)
    end
    ::lbl_101::
    L8 = L7.error
    if L8 == 0 then
      L8 = L7.timer_status
      if L8 == 1 then
        L7.timer_open = L5
        L7.timer_close = L6
    end
    else
      L7.timer_open = "00:00"
      L7.timer_close = "00:00"
    end
  end
  L8 = _UPVALUE3_
  L8 = L8.isMeshRe
  L8 = L8()
  if L8 then
    L8 = _UPVALUE1_
    L8 = L8.disableLedMeshSync
    L8()
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L7
  L8(L9)
end
ledCtl = L9
function L9()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.isMiWiFi
  L1 = L1()
  if L1 then
    L1 = 1
    if L1 then
      goto lbl_12
    end
  end
  L1 = 0
  ::lbl_12::
  L0.status = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
isMiWiFi = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appid"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "sip"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dip"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "dport"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "opt"
  L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  if L6 then
    if L3 then
      L7 = _UPVALUE1_
      L7 = L7.ip4addr
      L8 = L3
      L7 = L7(L8)
      if not L7 then
        goto lbl_46
      end
    end
    if not L4 then
      goto lbl_48
    end
    L7 = _UPVALUE1_
    L7 = L7.ip4addr
    L8 = L4
    L7 = L7(L8)
    if L7 then
      goto lbl_48
    end
  end
  ::lbl_46::
  L1.code = 1523
  goto lbl_104
  ::lbl_48::
  L7 = L0.qos_app
  L8 = L2
  L9 = L3
  L10 = L4
  L11 = L5
  L12 = L6
  L7 = L7(L8, L9, L10, L11, L12)
  if L7 == -1 then
    L1.code = 1523
  elseif L7 == -2 then
    L1.code = 1636
  elseif L7 < -2 then
    L1.code = 1606
  end
  if L7 < 0 then
    L8 = require
    L9 = "xiaoqiang.XQLog"
    L8 = L8(L9)
    L9 = L8.log
    L10 = 4
    L11 = string
    L11 = L11.format
    L12 = "app_qos error: error_status=%d appid=%s sip=%s dip=%s dport=%s opt=%s"
    L13 = L7
    L14 = tostring
    L15 = L2
    L14 = L14(L15)
    L15 = tostring
    L16 = L3
    L15 = L15(L16)
    L16 = tostring
    L17 = L4
    L16 = L16(L17)
    L17 = tostring
    L18 = L5
    L17 = L17(L18)
    L18 = tostring
    L19 = L6
    L18, L19 = L18(L19)
    L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
    L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  else
    L8 = os
    L8 = L8.execute
    L9 = "echo "
    L10 = tostring
    L11 = L4
    L10 = L10(L11)
    L11 = " > /proc/net/nf_conntrack ; /etc/init.d/miqos supress_update >/dev/null 2>&1"
    L9 = L9 .. L10 .. L11
    L8(L9)
  end
  ::lbl_104::
  L7 = L1.code
  if L7 ~= 0 then
    L7 = _UPVALUE2_
    L7 = L7.getErrorMessage
    L8 = L1.code
    L7 = L7(L8)
    L1.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L1
  L7(L8)
end
qosApp = L9
function L9()
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
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.macaddr
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_20
    end
  end
  L1.code = 1523
  goto lbl_32
  ::lbl_20::
  L3 = _UPVALUE2_
  L3 = L3.macFormat
  L4 = L2
  L3 = L3(L4)
  L2 = L3
  L3 = L0.getBsdInfo
  L4 = L2
  L3 = L3(L4)
  L4 = L3.bsd
  L1.bsd = L4
  L4 = L3.mode
  L1.mode = L4
  ::lbl_32::
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE3_
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
getDevBsdInfo = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
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
  L5 = "mode"
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  if L2 then
    L4 = _UPVALUE1_
    L4 = L4.macaddr
    L5 = L2
    L4 = L4(L5)
    if L4 and L3 then
      goto lbl_28
    end
  end
  L1.code = 1523
  goto lbl_36
  ::lbl_28::
  L4 = L0.setBsdMaclist
  L5 = L2
  L6 = L3
  L4 = L4(L5, L6)
  L5 = L4.bsd
  L1.bsd = L5
  L5 = L4.mode
  L1.mode = L5
  ::lbl_36::
  L4 = L1.code
  if L4 ~= 0 then
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = L1.code
    L4 = L4(L5)
    L1.msg = L4
  else
    L4 = _UPVALUE3_
    L4 = L4.forkRestartWifi
    L4()
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
setDevBsdInfo = L9
function L9()
  local L0, L1, L2
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "enable"
  L1 = L1(L2)
  L1 = L1 or L1
  L0 = L0(L1)
  L1 = _UPVALUE1_
  L1 = L1.isMeshMode
  L1 = L1()
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L2.code = 0
    return L1(L2)
  end
  L1 = _UPVALUE2_
  L1 = L1.setConfUploadEnable
  if L0 == 1 then
    L2 = true
    if L2 then
      goto lbl_29
    end
  end
  L2 = false
  ::lbl_29::
  L1(L2)
  if L0 == 1 then
    L1 = _UPVALUE2_
    L1 = L1.doConfUpload
    L1()
  end
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
confUploadEnable = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "action"
  L1 = L1(L2)
  if L1 == "set" then
    L2 = _UPVALUE0_
    L2 = L2.formvalue
    L3 = "value"
    L2 = L2(L3)
    if L2 == "once" or L2 == "auto" then
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "auto_memtest"
      L5 = L2
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramCommit
      L3()
    elseif L2 == "clear" then
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "auto_memtest"
      L5 = ""
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "memtestres"
      L5 = ""
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramCommit
      L3()
    else
      L0.code = 1537
    end
  else
    L0.code = 1523
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
memTestConfig = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.code = 1
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.json"
  L2 = L2(L3)
  L3 = "grep FAILURE /data/resofmemtest"
  L4 = L1.exec
  L5 = L3
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L0.data = "NULL"
    return L0
  end
  L0.data = L4
  return L0
end
getMemtestFailInfo = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "memtestres"
  L3 = 0
  L1 = L1(L2, L3)
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 == 1 then
      L2 = getMemtestFailInfo
      L2 = L2()
      L3 = _UPVALUE1_
      L3 = L3.write_json
      L4 = L2
      L3(L4)
    else
      L2 = _UPVALUE1_
      L2 = L2.write_json
      L3 = L0
      L2(L3)
    end
  else
    L0.code = 2
    L2 = _UPVALUE1_
    L2 = L2.write_json
    L3 = L0
    L2(L3)
  end
end
memTestResGet = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "action"
  L1 = L1(L2)
  if L1 == "set" then
    L2 = _UPVALUE0_
    L2 = L2.formvalue
    L3 = "value"
    L2 = L2(L3)
    if L2 == "once" or L2 == "auto" then
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "auto_flashtest"
      L5 = L2
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramCommit
      L3()
    elseif L2 == "clear" then
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "auto_flashtest"
      L5 = ""
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramSet
      L4 = "flashtestres"
      L5 = ""
      L3(L4, L5)
      L3 = _UPVALUE1_
      L3 = L3.nvramCommit
      L3()
    else
      L0.code = 1537
    end
  else
    L0.code = 1523
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
flashTestConfig = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.code = 1
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.json"
  L2 = L2(L3)
  L3 = "grep [MTD_TEST]FINISHED /data/resofflashtest"
  L4 = L1.exec
  L5 = L3
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L0.data = L4
    return L0
  end
  L0.data = "NULL"
  return L0
end
getFlashtestFailInfo = L9
function L9()
  local L0, L1, L2, L3, L4
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.nvramGet
  L2 = "flashtestres"
  L3 = 0
  L1 = L1(L2, L3)
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    if L2 == 1 then
      L2 = getFlashtestFailInfo
      L2 = L2()
      L3 = _UPVALUE1_
      L3 = L3.write_json
      L4 = L2
      L3(L4)
    else
      L2 = _UPVALUE1_
      L2 = L2.write_json
      L3 = L0
      L2(L3)
    end
  else
    L0.code = 2
    L2 = _UPVALUE1_
    L2 = L2.write_json
    L3 = L0
    L2(L3)
  end
end
flashTestResGet = L9
L9 = "/tmp/iot_time_cache"
L10 = "/tmp/iot_pubkey_cache"
L11 = "/tmp/iot_token_cache"
L12 = "/proc/sys/kernel/random/uuid"
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = assert
  L3 = io
  L3 = L3.open
  L4 = A0
  L5 = "w"
  L3, L4, L5 = L3(L4, L5)
  L2 = L2(L3, L4, L5)
  if L2 ~= nil then
    L4 = L2
    L3 = L2.write
    L5 = A1
    L3(L4, L5)
    L4 = L2
    L3 = L2.close
    L3(L4)
  end
end
write_txt = L13
function L13(A0)
  local L1, L2, L3, L4
  L1 = assert
  L2 = io
  L2 = L2.open
  L3 = A0
  L4 = "r"
  L2, L3, L4 = L2(L3, L4)
  L1 = L1(L2, L3, L4)
  if L1 ~= nil then
    L3 = L1
    L2 = L1.read
    L4 = "*line"
    L2 = L2(L3, L4)
    L4 = L1
    L3 = L1.close
    L3(L4)
    return L2
  end
end
read_txt = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "librsa"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "rsa_pubkey"
  L4 = L4(L5)
  if L4 == nil then
    L3.code = 1
    L3.msg = "http get rsa_pubkey null."
  end
  L5 = _UPVALUE1_
  L5 = L5.log
  L6 = 6
  L7 = "iot rsa_pubkey:"
  L8 = L4
  L7 = L7 .. L8
  L5(L6, L7)
  L5 = L3.code
  if L5 == 0 then
    L5 = write_txt
    L6 = _UPVALUE2_
    L7 = L4
    L5(L6, L7)
    L5 = os
    L5 = L5.time
    L5 = L5()
    L6 = write_txt
    L7 = _UPVALUE3_
    L8 = L5
    L6(L7, L8)
    L6 = _UPVALUE1_
    L6 = L6.log
    L7 = 6
    L8 = "iot timestamp:"
    L9 = L5
    L8 = L8 .. L9
    L6(L7, L8)
    L6 = read_txt
    L7 = _UPVALUE4_
    L6 = L6(L7)
    L7 = write_txt
    L8 = _UPVALUE5_
    L9 = L6
    L7(L8, L9)
    L7 = _UPVALUE1_
    L7 = L7.log
    L8 = 6
    L9 = "iot token:"
    L10 = L6
    L9 = L9 .. L10
    L7(L8, L9)
    L7 = L0.getLanIp
    L7 = L7()
    L8 = _UPVALUE6_
    L8 = L8.isStrNil
    L9 = L7
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE1_
      L8 = L8.log
      L9 = 6
      L10 = "iot lanip:"
      L11 = L7
      L10 = L10 .. L11
      L8(L9, L10)
      L8 = string
      L8 = L8.format
      L9 = "http://%s/cgi-bin/luci/api/misystem/get_wifi_pwd?token=%s"
      L10 = L7
      L11 = L6
      L8 = L8(L9, L10, L11)
      L9 = _UPVALUE1_
      L9 = L9.log
      L10 = 6
      L11 = "iot url_origin:"
      L12 = L8
      L11 = L11 .. L12
      L9(L10, L11)
      L9 = L2.lua_rsa_pubkey_encrypt
      L10 = L8
      L11 = L4
      L9 = L9(L10, L11)
      if L9 ~= nil then
        L10 = type
        L11 = L9
        L10 = L10(L11)
        if L10 == "string" then
          L10 = string
          L10 = L10.len
          L11 = L9
          L10 = L10(L11)
          L11 = _UPVALUE1_
          L11 = L11.log
          L12 = 6
          L13 = "url encrypted len:"
          L14 = L10
          L13 = L13 .. L14
          L11(L12, L13)
          L11 = L1.binaryBase64Enc
          L12 = L9
          L11 = L11(L12)
          L12 = _UPVALUE1_
          L12 = L12.log
          L13 = 6
          L14 = "url_base64:"
          L15 = L11
          L14 = L14 .. L15
          L12(L13, L14)
          L3.code = 0
          L3.url = L11
        else
          L10 = _UPVALUE1_
          L10 = L10.log
          L11 = 6
          L12 = "lua call C ret code:"
          L13 = L9
          L12 = L12 .. L13
          L10(L11, L12)
          if L9 == 101 then
            L3.code = 4
            L3.msg = "base64 decode key error."
          else
            L10 = value
            if L10 == 102 then
              L3.code = 5
              L3.msg = "parse pubkey key error."
            else
              L3.code = 6
              L3.msg = "rsa encrypt error."
            end
          end
        end
      else
        L10 = _UPVALUE1_
        L10 = L10.log
        L11 = 6
        L12 = "lua call C lib lua_rsa_pubkey_encrypt() ret nil"
        L10(L11, L12)
        L3.code = 3
        L3.msg = "lua call c api ret null."
      end
    else
      L8 = _UPVALUE1_
      L8 = L8.log
      L9 = 6
      L10 = "get lanip error"
      L8(L9, L10)
      L3.code = 2
      L3.msg = "router get lanip failed."
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
getWifiPwdUrl = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "librsa"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = {}
  L4["2gssid"] = ""
  L4["2gpwd"] = ""
  L4["5gssid"] = ""
  L4["5gpwd"] = ""
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "token"
  L5 = L5(L6)
  if L5 == nil then
    L3.code = 1
    L3.msg = "get token null"
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L7 = L3
    L6(L7)
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L7 = L3
    return L6(L7)
  end
  L6 = read_txt
  L7 = _UPVALUE1_
  L6 = L6(L7)
  L7 = _UPVALUE2_
  L7 = L7.log
  L8 = 6
  L9 = "iot token:"
  L10 = tostring
  L11 = L5
  L10 = L10(L11)
  L9 = L9 .. L10
  L7(L8, L9)
  L7 = _UPVALUE2_
  L7 = L7.log
  L8 = 6
  L9 = "iot token_local:"
  L10 = tostring
  L11 = L6
  L10 = L10(L11)
  L9 = L9 .. L10
  L7(L8, L9)
  if L6 ~= nil and L5 == L6 then
    L7 = tonumber
    L8 = read_txt
    L9 = _UPVALUE3_
    L8, L9, L10, L11, L12, L13, L14, L15, L16, L17 = L8(L9)
    L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17)
    L8 = tonumber
    L9 = os
    L9 = L9.time
    L9, L10, L11, L12, L13, L14, L15, L16, L17 = L9()
    L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17)
    L8 = L8 - L7
    L9 = _UPVALUE2_
    L9 = L9.log
    L10 = 6
    L11 = "token timeout:"
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
    if 300 < L8 then
      L3.code = 3
      L3.msg = "token timeout"
      L9 = _UPVALUE0_
      L9 = L9.write_json
      L10 = L3
      return L9(L10)
    end
  else
    L3.code = 2
    L3.msg = "token error"
    L7 = _UPVALUE0_
    L7 = L7.write_json
    L8 = L3
    return L7(L8)
  end
  L7 = _UPVALUE4_
  L8 = L7
  L7 = L7.get
  L9 = "wireless"
  L10 = "miot_2G"
  L11 = "miot_access_iotdev"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L8 = tonumber
  L9 = L7
  L8 = L8(L9)
  if L8 == 0 then
    L8 = L0.getWifiBasicInfo
    L9 = 1
    L8 = L8(L9)
    L9 = L0.getWifiBasicInfo
    L10 = 2
    L9 = L9(L10)
    L10 = L8.ssid
    L10 = L10 or L10
    L4["2gssid"] = L10
    L10 = L8.password
    L10 = L10 or L10
    L4["2gpwd"] = L10
    if L9 then
      L10 = L9.ssid
      L10 = L10 or L10
      L4["5gssid"] = L10
      L10 = L9.password
      L10 = L10 or L10
      L4["5gpwd"] = L10
    end
  else
    L8 = _UPVALUE4_
    L9 = L8
    L8 = L8.get
    L10 = "wireless"
    L11 = "iot_2g"
    L12 = "ssid"
    L8 = L8(L9, L10, L11, L12)
    L9 = _UPVALUE4_
    L10 = L9
    L9 = L9.get
    L11 = "wireless"
    L12 = "iot_2g"
    L13 = "key"
    L9 = L9(L10, L11, L12, L13)
    L9 = L9 or L9
    L10 = _UPVALUE4_
    L11 = L10
    L10 = L10.get
    L12 = "wireless"
    L13 = "iot_5g"
    L14 = "ssid"
    L10 = L10(L11, L12, L13, L14)
    L11 = _UPVALUE4_
    L12 = L11
    L11 = L11.get
    L13 = "wireless"
    L14 = "iot_5g"
    L15 = "key"
    L11 = L11(L12, L13, L14, L15)
    L11 = L11 or L11
    L4["2gssid"] = L8
    L4["2gpwd"] = L9
    L4["5gssid"] = L10
    L4["5gpwd"] = L11
  end
  L8 = require
  L9 = "luci.json"
  L8 = L8(L9)
  L9 = L8.encode
  L10 = L4
  L9 = L9(L10)
  L10 = _UPVALUE2_
  L10 = L10.log
  L11 = 6
  L12 = "iot pwd_origin:"
  L13 = L9
  L12 = L12 .. L13
  L10(L11, L12)
  L10 = _UPVALUE2_
  L10 = L10.log
  L11 = 6
  L12 = "iot pwd_origin json encode:"
  L13 = string
  L13 = L13.len
  L14 = L9
  L13 = L13(L14)
  L12 = L12 .. L13
  L10(L11, L12)
  L10 = read_txt
  L11 = _UPVALUE5_
  L10 = L10(L11)
  L11 = _UPVALUE2_
  L11 = L11.log
  L12 = 6
  L13 = "iot read last rsa_pub_key:"
  L14 = L10
  L13 = L13 .. L14
  L11(L12, L13)
  L11 = L2.lua_rsa_pubkey_encrypt
  L12 = L9
  L13 = L10
  L11 = L11(L12, L13)
  if L11 ~= nil then
    L12 = type
    L13 = L11
    L12 = L12(L13)
    if L12 == "string" then
      L12 = string
      L12 = L12.len
      L13 = L11
      L12 = L12(L13)
      L13 = _UPVALUE2_
      L13 = L13.log
      L14 = 6
      L15 = "pwd_new encrypted len:"
      L16 = L12
      L15 = L15 .. L16
      L13(L14, L15)
      L13 = L1.binaryBase64Enc
      L14 = L11
      L13 = L13(L14)
      L14 = _UPVALUE2_
      L14 = L14.log
      L15 = 6
      L16 = "pwd_base64:"
      L17 = L13
      L16 = L16 .. L17
      L14(L15, L16)
      L3.code = 0
      L3.info = L13
    else
      L12 = _UPVALUE2_
      L12 = L12.log
      L13 = 6
      L14 = "lua call C lib lua_rsa_pubkey_encrypt() ret nil"
      L12(L13, L14)
      L3.code = 0
      L3.msg = "pubkey encrypt failed."
    end
  else
    L3.code = 3
    L3.msg = "lua call c api ret null."
  end
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L3
  L12(L13)
end
getWifiPwd = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = io
  L1 = L1.open
  L1 = L1(L2, L3)
  if L1 == nil then
    return L2
  else
    for L5 in L2, L3, L4 do
      L6 = L5.find
      L7 = L5
      L8 = "tcp_port"
      L6 = L6(L7, L8)
      if L6 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
      L6 = L5.find
      L7 = L5
      L8 = "udp_port"
      L6 = L6(L7, L8)
      if L6 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
    end
  end
  L2(L3)
  return L2
end
isPortScanResultExist = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = io
  L1 = L1.open
  L1 = L1(L2, L3)
  if L1 == nil then
    return L2
  else
    for L5 in L2, L3, L4 do
      L6 = L5.find
      L7 = L5
      L8 = "ftp_weak_detect"
      L6 = L6(L7, L8)
      if L6 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
      L6 = L5.find
      L7 = L5
      L8 = "ssh_weak_detect"
      L6 = L6(L7, L8)
      if L6 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
      L6 = L5.find
      L7 = L5
      L8 = "telnet_weak_detect"
      L6 = L6(L7, L8)
      if L6 then
        L7 = L1
        L6 = L1.close
        L6(L7)
        L6 = true
        return L6
      end
    end
  end
  L2(L3)
  return L2
end
isWeakDetectResultExist = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ip"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.ip4addr
    L5 = L2
    L4 = L4(L5)
    if L4 then
      L4 = _UPVALUE1_
      L4 = L4.isStrNil
      L5 = L3
      L4 = L4(L5)
      if not L4 then
        L4 = _UPVALUE2_
        L4 = L4.macaddr
        L5 = L3
        L4 = L4(L5)
        if L4 then
          L4 = "/usr/sbin/portscan "
          L5 = L2
          L6 = " "
          L7 = L3
          L8 = " portscan"
          L4 = L4 .. L5 .. L6 .. L7 .. L8
          L5 = "/tmp/portscan_result/"
          L6 = L3
          L5 = L5 .. L6
          L6 = isPortScanResultExist
          L7 = L5
          L6 = L6(L7)
          if not L6 then
            L6 = isFileExist
            L7 = "/tmp/portscan.pid"
            L6 = L6(L7)
            if L6 then
              L1 = 1658
            else
              L6 = _UPVALUE1_
              L6 = L6.forkExec
              L7 = L4
              L6 = L6(L7)
            end
          end
      end
    end
  end
  else
    L1 = 1659
  end
  L0.code = L1
  if L1 ~= 0 then
    L4 = _UPVALUE3_
    L4 = L4.getErrorMessage
    L5 = L1
    L4 = L4(L5)
    L0.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
startPortScan = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ip"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.ip4addr
    L5 = L2
    L4 = L4(L5)
    if L4 then
      L4 = _UPVALUE1_
      L4 = L4.isStrNil
      L5 = L3
      L4 = L4(L5)
      if not L4 then
        L4 = _UPVALUE2_
        L4 = L4.macaddr
        L5 = L3
        L4 = L4(L5)
        if L4 then
          L4 = "/usr/sbin/portscan "
          L5 = L2
          L6 = " "
          L7 = L3
          L8 = " weakdetect"
          L4 = L4 .. L5 .. L6 .. L7 .. L8
          L5 = "/tmp/portscan_result/"
          L6 = L3
          L5 = L5 .. L6
          L6 = isWeakDetectResultExist
          L7 = L5
          L6 = L6(L7)
          if not L6 then
            L6 = isFileExist
            L7 = "/tmp/portscan.pid"
            L6 = L6(L7)
            if L6 then
              L1 = 1658
            else
              L6 = _UPVALUE1_
              L6 = L6.forkExec
              L7 = L4
              L6 = L6(L7)
            end
          end
      end
    end
  end
  else
    L1 = 1659
  end
  L0.code = L1
  if L1 ~= 0 then
    L4 = _UPVALUE3_
    L4 = L4.getErrorMessage
    L5 = L1
    L4 = L4(L5)
    L0.msg = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
startWeakDetect = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = string
  L2 = L2.find
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  L3 = string
  L3 = L3.sub
  L4 = A0
  L5 = L2 + 1
  L6 = string
  L6 = L6.len
  L7 = A0
  L6, L7 = L6(L7)
  L3 = L3(L4, L5, L6, L7)
  return L3
end
getContent = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "ip"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE2_
    L3 = L3.ip4addr
    L4 = L1
    L3 = L3(L4)
    if L3 then
      L3 = _UPVALUE1_
      L3 = L3.isStrNil
      L4 = L2
      L3 = L3(L4)
      if not L3 then
        L3 = _UPVALUE2_
        L3 = L3.macaddr
        L4 = L2
        L3 = L3(L4)
        if L3 then
          L3 = "/tmp/portscan_result/"
          L4 = L2
          L3 = L3 .. L4
          L4 = isFileExist
          L4 = L4(L5)
          if L4 then
            L0.code = 1658
          else
            L4 = isPortScanResultExist
            L4 = L4(L5)
            if L4 then
              L4 = io
              L4 = L4.open
              L4 = L4(L5)
              for L8 in L5, L6, L7 do
                L9 = L8.find
                L10 = L8
                L11 = "tcp_port"
                L9 = L9(L10, L11)
                if L9 then
                  L0.tcp_port = ""
                  L9 = getContent
                  L10 = L8
                  L11 = "]"
                  L9 = L9(L10, L11)
                  L0.tcp_port = L9
                end
                L9 = L8.find
                L10 = L8
                L11 = "udp_port"
                L9 = L9(L10, L11)
                if L9 then
                  L0.udp_port = ""
                  L9 = getContent
                  L10 = L8
                  L11 = "]"
                  L9 = L9(L10, L11)
                  L0.udp_port = L9
                end
              end
              L0.ip = L1
              L0.mac = L2
            else
              L0.code = 1660
            end
          end
      end
    end
  end
  else
    L0.code = 1659
  end
  L3 = L0.code
  if L3 ~= 0 then
    L3 = _UPVALUE3_
    L3 = L3.getErrorMessage
    L4 = L0.code
    L3 = L3(L4)
    L0.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
getPortScanResult = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "ip"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "mac"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE2_
    L3 = L3.ip4addr
    L4 = L1
    L3 = L3(L4)
    if L3 then
      L3 = _UPVALUE1_
      L3 = L3.isStrNil
      L4 = L2
      L3 = L3(L4)
      if not L3 then
        L3 = _UPVALUE2_
        L3 = L3.macaddr
        L4 = L2
        L3 = L3(L4)
        if L3 then
          L3 = "/tmp/portscan_result/"
          L4 = L2
          L3 = L3 .. L4
          L4 = isFileExist
          L4 = L4(L5)
          if L4 then
            L0.code = 1658
          else
            L4 = isWeakDetectResultExist
            L4 = L4(L5)
            if L4 then
              L4 = io
              L4 = L4.open
              L4 = L4(L5)
              for L8 in L5, L6, L7 do
                L9 = L8.find
                L10 = L8
                L11 = "ftp_weak_detect"
                L9 = L9(L10, L11)
                if L9 then
                  L0.ftp_weak_detect = ""
                  L9 = getContent
                  L10 = L8
                  L11 = "]"
                  L9 = L9(L10, L11)
                  L0.ftp_weak_detect = L9
                end
                L9 = L8.find
                L10 = L8
                L11 = "ssh_weak_detect"
                L9 = L9(L10, L11)
                if L9 then
                  L0.ssh_weak_detect = ""
                  L9 = getContent
                  L10 = L8
                  L11 = "]"
                  L9 = L9(L10, L11)
                  L0.ssh_weak_detect = L9
                end
                L9 = L8.find
                L10 = L8
                L11 = "telnet_weak_detect"
                L9 = L9(L10, L11)
                if L9 then
                  L0.telnet_weak_detect = ""
                  L9 = getContent
                  L10 = L8
                  L11 = "]"
                  L9 = L9(L10, L11)
                  L0.telnet_weak_detect = L9
                end
              end
              L0.ip = L1
              L0.mac = L2
            else
              L0.code = 1660
            end
          end
      end
    end
  end
  else
    L0.code = 1659
  end
  L3 = L0.code
  if L3 ~= 0 then
    L3 = _UPVALUE3_
    L3 = L3.getErrorMessage
    L4 = L0.code
    L3 = L3(L4)
    L0.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
getWeakDetectResult = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "ssid"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bssid"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "user_id"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.log
  L5 = debug_level
  L6 = "ssid = "
  L7 = L1
  L6 = L6 .. L7
  L4(L5, L6)
  L4 = _UPVALUE1_
  L4 = L4.log
  L5 = debug_level
  L6 = "bssid = "
  L7 = L2
  L6 = L6 .. L7
  L4(L5, L6)
  L4 = _UPVALUE1_
  L4 = L4.log
  L5 = debug_level
  L6 = "uid = "
  L7 = L3
  L6 = L6 .. L7
  L4(L5, L6)
  L4 = _UPVALUE2_
  L4 = L4.isStrNil
  L5 = L1
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.isStrNil
    L5 = L2
    L4 = L4(L5)
    if not L4 then
      L4 = _UPVALUE3_
      L4 = L4.macaddr
      L5 = L2
      L4 = L4(L5)
      if L4 then
        L4 = _UPVALUE2_
        L4 = L4.isStrNil
        L5 = L3
        L4 = L4(L5)
        if not L4 then
          goto lbl_61
        end
      end
    end
  end
  L0.code = 1523
  ::lbl_61::
  L4 = L0.code
  if L4 ~= 0 then
    L4 = _UPVALUE4_
    L4 = L4.getErrorMessage
    L5 = L0.code
    L4 = L4(L5)
    L0.msg = L4
  else
    L4 = _UPVALUE2_
    L4 = L4.forkExec
    L5 = string
    L5 = L5.format
    L6 = "connect -s \"%s\" -b \"%s\" -u \"%s\""
    L7 = _UPVALUE2_
    L7 = L7._cmdformat
    L8 = L1
    L7 = L7(L8)
    L8 = _UPVALUE2_
    L8 = L8._cmdformat
    L9 = L2
    L8 = L8(L9)
    L9 = _UPVALUE2_
    L9 = L9._cmdformat
    L10 = L3
    L9, L10 = L9(L10)
    L5, L6, L7, L8, L9, L10 = L5(L6, L7, L8, L9, L10)
    L4(L5, L6, L7, L8, L9, L10)
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
end
setConfigIotDev = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = {}
  L4 = {}
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L7 = L5
  L6 = L5.get
  L8 = "miscan"
  L9 = "config"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = nil
  L8 = {}
  L9 = tonumber
  L9 = L9(L10)
  L9 = L9 == 0
  wifi24GOn = L9
  if L6 == "1" then
    L9 = wifi24GOn
    if L9 then
      L9 = "scan 1"
      scancmd = L9
      L9 = L1.execl
      L9 = L9(L10)
      if L9 then
        for L13, L14 in L10, L11, L12 do
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L14
          L15 = L15(L16)
          if not L15 then
            L16 = L14
            L15 = L14.match
            L17 = "ssid:(%S+) bssid:(%S+) model:(%S+) routerSSID:(%S+) routerBSSID:(%S+) rssi:(%S+)"
            L15, L16, L17, L18, L19, L20 = L15(L16, L17)
            rssi = L20
            router_bssid = L19
            router_ssid = L18
            model = L17
            bssid = L16
            ssid = L15
            L15 = ssid
            if L15 ~= nil then
              L15 = table
              L15 = L15.insert
              L16 = L3
              L17 = {}
              L18 = tostring
              L19 = model
              L18 = L18(L19)
              L17.model = L18
              L18 = tostring
              L19 = ssid
              L18 = L18(L19)
              L17.ssid = L18
              L18 = tostring
              L19 = bssid
              L18 = L18(L19)
              L17.bssid = L18
              L18 = tostring
              L19 = router_ssid
              L18 = L18(L19)
              L17.router_ssid = L18
              L18 = tostring
              L19 = router_bssid
              L18 = L18(L19)
              L17.router_bssid = L18
              L18 = tostring
              L19 = rssi
              L18 = L18(L19)
              L17.rssi = L18
              L15(L16, L17)
            end
          end
        end
      end
    end
  end
  L4.list = L3
  L2.data = L4
  L9 = _UPVALUE1_
  L9 = L9.write_json
  L9(L10)
end
getunConfigIotDev = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = {}
  L4 = 0
  L5 = nil
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "bssid"
  L6 = L6(L7)
  L7 = _UPVALUE1_
  L7 = L7.log
  L7(L8, L9)
  L7 = L0.isStrNil
  L7 = L7(L8)
  if L7 then
    L2.code = 1523
  end
  L7 = L2.code
  if L7 ~= 0 then
    L7 = _UPVALUE2_
    L7 = L7.getErrorMessage
    L7 = L7(L8)
    L2.msg = L7
  else
    L7 = string
    L7 = L7.format
    L7 = L7(L8)
    if L8 then
      L11 = L0._cmdformat
      L12 = L6
      L11, L12, L13, L14 = L11(L12)
      L11, L12, L13, L14 = L9(L10, L11, L12, L13, L14)
      L5 = L8
      for L11, L12 in L8, L9, L10 do
        L13 = L0.isStrNil
        L14 = L12
        L13 = L13(L14)
        if not L13 then
          L13 = tonumber
          L14 = L12
          L13 = L13(L14)
          L4 = L13 or L4
          if not L13 then
            L4 = 0
          end
        end
      end
    end
  end
  L3.status = L4
  L2.data = L3
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L7(L8)
end
getIotDevStatus = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "configtype"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "cloud_data"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "cloud_sign"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "public_key"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "app_data"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "app_sign"
  L7 = L7(L8)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "mac = "
  L11 = L1
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "configType = "
  L11 = L2
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "cloud_data = "
  L11 = L3
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "cloud_sign = "
  L11 = L4
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "public_key = "
  L11 = L5
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "app_data = "
  L11 = L6
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE1_
  L8 = L8.log
  L9 = debug_level
  L10 = "app_sign = "
  L11 = L7
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = _UPVALUE2_
  L8 = L8.isStrNil
  L9 = L1
  L8 = L8(L9)
  if not L8 then
    L8 = _UPVALUE2_
    L8 = L8.isStrNil
    L9 = L2
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE2_
      L8 = L8.isStrNil
      L9 = L3
      L8 = L8(L9)
      if not L8 then
        L8 = _UPVALUE2_
        L8 = L8.isStrNil
        L9 = L4
        L8 = L8(L9)
        if not L8 then
          L8 = _UPVALUE2_
          L8 = L8.isStrNil
          L9 = L5
          L8 = L8(L9)
          if not L8 then
            goto lbl_111
          end
        end
      end
    end
  end
  L0.code = 1523
  ::lbl_111::
  L9 = L1
  L8 = L1.match
  L10 = "^(%x%x:%x%x:%x%x:%x%x:%x%x:%x%x)$"
  L8 = L8(L9, L10)
  if not L8 then
    L0.code = 1523
  end
  L8 = tonumber
  L9 = L2
  L8 = L8(L9)
  if L8 ~= 1 and L8 ~= 2 then
    L0.code = 1523
  elseif L8 == 2 then
    L9 = _UPVALUE2_
    L9 = L9.isStrNil
    L10 = L6
    L9 = L9(L10)
    if not L9 then
      L9 = _UPVALUE2_
      L9 = L9.isStrNil
      L10 = L7
      L9 = L9(L10)
      if not L9 then
        goto lbl_141
      end
    end
    L0.code = 1523
  end
  ::lbl_141::
  L9 = L0.code
  if L9 ~= 0 then
    L9 = _UPVALUE3_
    L9 = L9.getErrorMessage
    L10 = L0.code
    L9 = L9(L10)
    L0.msg = L9
  elseif L8 == 1 then
    L9 = _UPVALUE2_
    L9 = L9.forkExec
    L10 = string
    L10 = L10.format
    L11 = "iotrelay -m \"%s\" -t 1 -c 1 -d \"%s\" -s \"%s\" -p \"%s\""
    L12 = _UPVALUE2_
    L12 = L12._cmdformat
    L13 = L1
    L12 = L12(L13)
    L13 = _UPVALUE2_
    L13 = L13._cmdformat
    L14 = L3
    L13 = L13(L14)
    L14 = _UPVALUE2_
    L14 = L14._cmdformat
    L15 = L4
    L14 = L14(L15)
    L15 = _UPVALUE2_
    L15 = L15._cmdformat
    L16 = L5
    L15, L16, L17, L18 = L15(L16)
    L10, L11, L12, L13, L14, L15, L16, L17, L18 = L10(L11, L12, L13, L14, L15, L16, L17, L18)
    L9(L10, L11, L12, L13, L14, L15, L16, L17, L18)
  else
    L9 = _UPVALUE2_
    L9 = L9.forkExec
    L10 = string
    L10 = L10.format
    L11 = "iotrelay -m \"%s\" -t 1 -c 2 -d \"%s\" -s \"%s\" -p \"%s\" -a \"%s\" -b \"%s\""
    L12 = _UPVALUE2_
    L12 = L12._cmdformat
    L13 = L1
    L12 = L12(L13)
    L13 = _UPVALUE2_
    L13 = L13._cmdformat
    L14 = L3
    L13 = L13(L14)
    L14 = _UPVALUE2_
    L14 = L14._cmdformat
    L15 = L4
    L14 = L14(L15)
    L15 = _UPVALUE2_
    L15 = L15._cmdformat
    L16 = L5
    L15 = L15(L16)
    L16 = _UPVALUE2_
    L16 = L16._cmdformat
    L17 = L6
    L16 = L16(L17)
    L17 = _UPVALUE2_
    L17 = L17._cmdformat
    L18 = L7
    L17, L18 = L17(L18)
    L10, L11, L12, L13, L14, L15, L16, L17, L18 = L10(L11, L12, L13, L14, L15, L16, L17, L18)
    L9(L10, L11, L12, L13, L14, L15, L16, L17, L18)
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L0
  L9(L10)
end
setConfigIotDevHidessid = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L4 = L0
  L3 = L0.get
  L5 = "wireless"
  L6 = "miot_2G"
  L7 = "ifname"
  L3 = L3(L4, L5, L6, L7)
  L5 = L0
  L4 = L0.get
  L6 = "wireless"
  L7 = "iot_2g"
  L8 = "disabled"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L6 = L0
  L5 = L0.get
  L7 = "wireless"
  L8 = "miot_2G"
  L9 = "miot_access_iotdev"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L6 = "wl1"
  L7 = {}
  L8 = {}
  L9, L10, L11 = nil, nil, nil
  L12 = tonumber
  L13 = L4
  L12 = L12(L13)
  if L12 == 0 then
    L12 = tonumber
    L13 = L5
    L12 = L12(L13)
    if L12 == 1 then
      L13 = L0
      L12 = L0.get
      L12 = L12(L13, L14, L15, L16)
      L6 = L12
    end
  end
  L12 = pcall
  L13 = require
  L12, L13 = L12(L13, L14)
  if L12 then
    if not L3 then
    end
    if L3 and L14 then
      if L15 then
        L11 = L15
      end
    end
    if not L6 then
    end
    if L6 and L14 then
      if L15 then
        L9 = L15
        L10 = L15
      end
    end
  end
  if L11 then
    for L17, L18 in L14, L15, L16 do
      if L17 and L18 then
        L19 = string
        L19 = L19.lower
        L23, L24, L25, L26, L27, L28, L29 = L20(L21)
        L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
        L17 = L19
        L19 = string
        L19 = L19.format
        L19 = L19(L20)
        if L20 then
          L23 = _UPVALUE0_
          L23 = L23._cmdformat
          L24 = L17
          L23, L24, L25, L26, L27, L28, L29 = L23(L24)
          L23, L24, L25, L26, L27, L28, L29 = L21(L22, L23, L24, L25, L26, L27, L28, L29)
          statusResult = L20
          for L23, L24 in L20, L21, L22 do
            L25 = _UPVALUE0_
            L25 = L25.isStrNil
            L26 = L24
            L25 = L25(L26)
            if not L25 then
              L25 = tonumber
              L26 = L24
              L25 = L25(L26)
              status = L25
              L25 = status
              if L25 == 5 then
                L25 = table
                L25 = L25.insert
                L26 = L7
                L27 = {}
                L27.mac = L17
                L28 = tostring
                L29 = L18.signal
                L28 = L28(L29)
                L27.rssi = L28
                L25(L26, L27)
              end
            end
          end
        end
      end
    end
  end
  if L10 then
    L8.ssid = L10
  end
  if L9 then
    L8.bssid = L9
  end
  L8.list = L7
  L2.data = L8
  L14(L15)
end
getunConfigIotDevHidessid = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L3 = 0
  L4 = nil
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mac"
  L5 = L5(L6)
  L6 = _UPVALUE1_
  L6 = L6.log
  L6(L7, L8)
  L6 = _UPVALUE2_
  L6 = L6.isStrNil
  L6 = L6(L7)
  if L6 then
    L1.code = 1523
  end
  L6 = L1.code
  if L6 ~= 0 then
    L6 = _UPVALUE3_
    L6 = L6.getErrorMessage
    L6 = L6(L7)
    L1.msg = L6
  else
    L6 = string
    L6 = L6.format
    L6 = L6(L7)
    if L7 then
      L10 = _UPVALUE2_
      L10 = L10._cmdformat
      L11 = L5
      L10, L11, L12, L13 = L10(L11)
      L10, L11, L12, L13 = L8(L9, L10, L11, L12, L13)
      L4 = L7
      for L10, L11 in L7, L8, L9 do
        L12 = _UPVALUE2_
        L12 = L12.isStrNil
        L13 = L11
        L12 = L12(L13)
        if not L12 then
          L12 = tonumber
          L13 = L11
          L12 = L12(L13)
          L3 = L12 or L3
          if not L12 then
            L3 = 0
          end
        end
      end
    end
  end
  L2.status = L3
  L1.data = L2
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L6(L7)
end
getIotDevStatusHidessid = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQVLANServiceUtil"
  L0 = L0(L1)
  L1 = L0.getVlanService
  L1 = L1()
  L2 = {}
  L2.code = 0
  L3 = L1.type
  L3 = L3.internet
  L3 = L3.wan_egress_tag
  L2.internet_tag = L3
  L3 = L1.type
  L3 = L3.internet
  L3 = L3.vid
  L2.internet_vid = L3
  L3 = L1.service
  L3 = L3.Internet
  L3 = L3.profile
  L2.internet_profile = L3
  L3 = L1.type
  L3 = L3.internet
  L3 = L3.priority
  L2.internet_priority = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getVlanInternet = L13
function L13(A0, A1)
  local L2, L3
  L2 = A0.name
  L3 = A1.name
  L2 = L2 < L3
  return L2
end
interface_sort = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQVLANServiceUtil"
  L1 = L1(L2)
  L2 = L1.getVlanService
  L2 = L2()
  L3 = {}
  L3.code = 0
  L4 = {}
  L5 = {}
  L4.enable = L6
  L4.profile = L6
  L4.vid = L6
  L4.priority = L6
  L4.wan_egress_tag = L6
  L4.lan_egress_tag = L6
  for L9, L10 in L6, L7, L8 do
    L11 = {}
    L13 = L9
    L12 = L9.upper
    L12 = L12(L13)
    L11.name = L12
    if L10 == "internet" then
      L12 = L0.null
      if L12 then
        goto lbl_50
      end
    end
    L13 = L10
    L12 = L10.upper
    L12 = L12(L13)
    ::lbl_50::
    L11.type = L12
    L12 = table
    L12 = L12.insert
    L13 = L5
    L14 = L11
    L12(L13, L14)
  end
  L6(L7, L8)
  L3.IPTV = L4
  L3.interfaces = L5
  L6(L7)
end
getVlanIPTV = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31
  L0 = require
  L1 = "xiaoqiang.util.XQVLANServiceUtil"
  L0 = L0(L1)
  L1 = L0.getVlanService
  L1 = L1()
  L2 = {}
  L2.code = 0
  L3 = true
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "opt"
  L4 = L4(L5)
  L5 = 0
  if nil ~= L4 then
    L6 = tostring
    L7 = L4
    L6 = L6(L7)
    L4 = L6
    if "clean" == L4 then
      L6 = 0
      if L6 then
        goto lbl_26
        L5 = L6 or L5
      end
    end
    L5 = 1
    ::lbl_26::
    if "set" ~= L4 then
      L3 = false
    end
  end
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "internet_vid"
  L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "internet_priority"
  L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "internet_profile"
  L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  if nil ~= L8 and 0 == L8 then
    L9 = 0
    L5 = L9 or L5
    if not L9 then
    end
  end
  L9 = tonumber
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "internet_tag"
  L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "IPTV.enable"
  L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L11 = tonumber
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "VOIP.enable"
  L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L12(L13)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L12 = tonumber
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "bridge.enable"
  L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L13(L14)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L13 = L12 or L13
  L13 = L10 and 1 == L10 or L11 and 1 == L11 or L12 and 1 == L12
  L14 = tonumber
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "IPTV.profile"
  L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L15(L16)
  L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L15 = tonumber
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "IPTV.vid"
  L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L16(L17)
  L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L16 = tonumber
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "IPTV.priority"
  L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L17(L18)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L17 = tonumber
  L18 = _UPVALUE0_
  L18 = L18.formvalue
  L19 = "IPTV.wan_egress_tag"
  L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L18(L19)
  L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L18 = tonumber
  L19 = _UPVALUE0_
  L19 = L19.formvalue
  L20 = "IPTV.lan_egress_tag"
  L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L19(L20)
  L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L19 = tonumber
  L20 = _UPVALUE0_
  L20 = L20.formvalue
  L21 = "VOIP.vid"
  L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L20(L21)
  L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L20 = tonumber
  L21 = _UPVALUE0_
  L21 = L21.formvalue
  L22 = "VOIP.priority"
  L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L21(L22)
  L20 = L20(L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L21 = tonumber
  L22 = _UPVALUE0_
  L22 = L22.formvalue
  L23 = "VOIP.wan_egress_tag"
  L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 = L22(L23)
  L21 = L21(L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L22 = tonumber
  L23 = _UPVALUE0_
  L23 = L23.formvalue
  L24 = "VOIP.lan_egress_tag"
  L23, L24, L25, L26, L27, L28, L29, L30, L31 = L23(L24)
  L22 = L22(L23, L24, L25, L26, L27, L28, L29, L30, L31)
  L23 = tonumber
  L24 = _UPVALUE0_
  L24 = L24.formvalue
  L25 = "bridge.vid"
  L24, L25, L26, L27, L28, L29, L30, L31 = L24(L25)
  L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31)
  L24 = tonumber
  L25 = _UPVALUE0_
  L25 = L25.formvalue
  L26 = "bridge.priority"
  L25, L26, L27, L28, L29, L30, L31 = L25(L26)
  L24 = L24(L25, L26, L27, L28, L29, L30, L31)
  L25 = tonumber
  L26 = _UPVALUE0_
  L26 = L26.formvalue
  L27 = "bridge.wan_egress_tag"
  L26, L27, L28, L29, L30, L31 = L26(L27)
  L25 = L25(L26, L27, L28, L29, L30, L31)
  L26 = tonumber
  L27 = _UPVALUE0_
  L27 = L27.formvalue
  L28 = "bridge.lan_egress_tag"
  L27, L28, L29, L30, L31 = L27(L28)
  L26 = L26(L27, L28, L29, L30, L31)
  if nil ~= L10 or nil ~= L11 or nil ~= L12 then
    L27 = L1.service
    L27 = L27.Multimedia
    if L13 then
      L28 = 1
      if L28 then
        goto lbl_184
      end
    end
    L28 = 0
    ::lbl_184::
    L27.enable = L28
  end
  if nil ~= L14 then
    L27 = L1.service
    L27 = L27.Multimedia
    L27.profile = L14
  end
  if nil ~= L4 then
    L27 = L1.service
    L27 = L27.Internet
    L27.enable = L5
  end
  if nil ~= L6 then
    L27 = L1.type
    L27 = L27.internet
    L27.vid = L6
  end
  if nil ~= L7 then
    L27 = L1.type
    L27 = L27.internet
    L27.priority = L7
  end
  if nil ~= L8 then
    L27 = L1.service
    L27 = L27.Internet
    L27.profile = L8
  end
  if nil ~= L9 then
    L27 = L1.type
    L27 = L27.internet
    L27.wan_egress_tag = L9
  end
  if nil ~= L15 then
    L27 = L1.type
    L27 = L27.iptv
    L27.vid = L15
  end
  if nil ~= L16 then
    L27 = L1.type
    L27 = L27.iptv
    L27.priority = L16
  end
  if nil ~= L17 then
    L27 = L1.type
    L27 = L27.iptv
    L27.wan_egress_tag = L17
  end
  if nil ~= L18 then
    L27 = L1.type
    L27 = L27.iptv
    L27.lan_egress_tag = L18
  end
  if nil ~= L19 then
    L27 = L1.type
    L27 = L27.voip
    L27.vid = L19
  end
  if nil ~= L20 then
    L27 = L1.type
    L27 = L27.voip
    L27.priority = L20
  end
  if nil ~= L21 then
    L27 = L1.type
    L27 = L27.voip
    L27.wan_egress_tag = L21
  end
  if nil ~= L22 then
    L27 = L1.type
    L27 = L27.voip
    L27.lan_egress_tag = L22
  end
  if nil ~= L23 then
    L27 = L1.type
    L27 = L27.bridge
    L27.vid = L23
  end
  if nil ~= L24 then
    L27 = L1.type
    L27 = L27.bridge
    L27.priority = L24
  end
  if nil ~= L25 then
    L27 = L1.type
    L27 = L27.bridge
    L27.wan_egress_tag = L25
  end
  if nil ~= L26 then
    L27 = L1.type
    L27 = L27.bridge
    L27.lan_egress_tag = L26
  end
  L27 = _UPVALUE1_
  L28 = L27
  L27 = L27.foreach
  L29 = "vlan_service"
  L30 = "interface"
  function L31(A0)
    local L1, L2, L3, L4, L5
    L1 = _UPVALUE0_
    L1 = L1.formvalue
    L2 = A0[".name"]
    L3 = L2
    L2 = L2.upper
    L2 = L2(L3)
    L3 = ".type"
    L2 = L2 .. L3
    L1 = L1(L2)
    if nil ~= L1 then
      L2 = tostring
      L3 = L1
      L2 = L2(L3)
      L1 = L2
      L2 = _UPVALUE1_
      L2 = L2.interface
      L3 = A0[".name"]
      L4 = tostring
      if L1 == "null" then
        L5 = "internet"
        if L5 then
          goto lbl_25
        end
      end
      L5 = L1
      ::lbl_25::
      L4 = L4(L5)
      L5 = L4
      L4 = L4.lower
      L4 = L4(L5)
      L2[L3] = L4
    end
  end
  L27(L28, L29, L30, L31)
  L27 = L0.setVlanService
  L28 = L1
  L29 = L3
  L27 = L27(L28, L29)
  if not L27 then
    L2.code = 1523
    L27 = _UPVALUE2_
    L27 = L27.getErrorMessage
    L28 = L2.code
    L27 = L27(L28)
    L2.msg = L27
  end
  L27 = _UPVALUE0_
  L27 = L27.write_json
  L28 = L2
  L27(L28)
end
setVlanService = L13
function L13()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getRouterFeatureInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.util.XQPortServiceUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "service"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "interface"
  L2 = L2(L3)
  L3 = {}
  L4 = {}
  L5 = 0
  L6 = {}
  L6.code = 1523
  L7 = false
  L8 = L0.ps
  L8 = L8[L1]
  if nil ~= L8 then
    L9 = L8.analyConfig
    L10 = _UPVALUE0_
    L9, L10 = L9(L10)
    L5 = L10
    L3 = L9
    if L5 then
      L6.code = L5
    end
    if L3 and L1 == "wantag" and L2 == "wan" then
      L9 = L8.getConfig
      L10 = _UPVALUE0_
      L9 = L9(L10)
      L4 = L9
      if nil ~= L4 then
        L9 = L3.profile
        L10 = L4.profile
        if L9 == L10 then
          L9 = L3.vid
          L10 = L4.vid
          if L9 == L10 then
            L9 = L3.priority
            L10 = L4.priority
            if L9 == L10 then
              L6.code = 0
              L9 = _UPVALUE0_
              L9 = L9.write_json
              L10 = L6
              L9(L10)
              return
            end
          end
        end
      end
    end
    L9 = L8.setConfig
    L10 = L3
    L9, L10 = L9(L10)
    L6.wait = L10
    L7 = L9
    if L7 then
      L6.code = 0
    end
  end
  L9 = L6.code
  if 0 ~= L9 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L6.code
    L9 = L9(L10)
    L6.msg = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L6
  L9(L10)
end
setPSService = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQPortServiceUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "service"
  L1 = L1(L2)
  L2 = {}
  L3 = {}
  L3.code = 1523
  L4 = L0.ps
  L4 = L4[L1]
  if nil ~= L4 then
    L5 = L4.getConfig
    L6 = _UPVALUE0_
    L5 = L5(L6)
    L2 = L5
    if nil ~= L2 then
      L3.code = 0
      L3[L1] = L2
    end
  end
  L5 = L3.code
  if 0 ~= L5 then
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
getPSService = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQPortServiceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = {}
  L1.ports = L2
  L1.description = ""
  L2 = L0.psGetMap
  L2 = L2()
  L1.ports = L2
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L0.psGetMapDesc
  L3 = L3()
  L2 = L2(L3)
  if not L2 then
    L2 = translate
    L3 = L0.psGetMapDesc
    L3 = L3()
    L2 = L2(L3)
    L1.description = L2
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getPSMap = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "noremind"
  L1, L2, L3, L4, L5, L6, L7 = L1(L2)
  L0 = L0(L1, L2, L3, L4, L5, L6, L7)
  L1 = {}
  L1.code = 0
  if L0 == 1 or L0 == 0 then
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.set
    L4 = "xiaoqiang"
    L5 = "common"
    L6 = "noremind"
    L7 = L0
    L2(L3, L4, L5, L6, L7)
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.commit
    L4 = "xiaoqiang"
    L2(L3, L4)
  else
    L1.code = 1523
  end
  L2 = L1.code
  if L2 ~= 0 then
    L2 = _UPVALUE2_
    L2 = L2.getErrorMessage
    L3 = L1.code
    L2 = L2(L3)
    L1.msg = L2
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
setWanNoRemind = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.code = 0
  L1 = tonumber
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "noremind"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1 = L1(L2)
  L0.noremind = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getWanNoRemind = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getPctlUserList
  L2 = L2()
  L1.user_list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getPctlUserList = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getDev
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getPctlDev = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "user_id"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 ~= "number" then
    L1.code = 1672
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L1.code
    L3 = L3(L4)
    L1.msg = L3
  else
    L3 = L0.getTimeList
    L4 = L2
    L3 = L3(L4)
    L1.time_list = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getPctlDenyTime = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "user_id"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 ~= "number" then
    L1.code = 1672
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L1.code
    L3 = L3(L4)
    L1.msg = L3
  else
    L3 = L0.getApp
    L4 = L2
    L3 = L3(L4)
    L1.list = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getPctlApp = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "user_id"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  L2 = {}
  L2.code = 0
  L3 = type
  L4 = L1
  L3 = L3(L4)
  if L3 ~= "number" then
    L2.code = 1672
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
  else
    L3 = L0.getHosts
    L4 = L1
    L3 = L3(L4)
    L2.list = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getPctlBanHost = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "user_id"
  L2, L3, L7, L8, L9 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8, L9)
  L2 = {}
  L2.code = 0
  L3 = nil
  if L4 ~= "number" then
    L2.code = 1672
    L2.msg = L4
  else
    L3 = L4
    if L3 then
      for L7, L8 in L4, L5, L6 do
        L2[L7] = L8
      end
    else
      L2.code = 1664
    end
  end
  L4(L5)
end
getPctlTempBan = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "user_id"
  L3, L4, L8, L9, L10 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L4, L8, L9, L10 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10)
  L4 = nil
  if L5 == "number" then
    if L5 == "number" then
      goto lbl_36
    end
  end
  L1.code = 1672
  L1.msg = L5
  goto lbl_48
  ::lbl_36::
  L4 = L5
  for L8, L9 in L5, L6, L7 do
    L1[L8] = L9
  end
  ::lbl_48::
  L5(L6)
end
getPctlUserStats = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L3, L7, L8, L9 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L3 = nil
  L3 = L4
  for L7, L8 in L4, L5, L6 do
    L1[L7] = L8
  end
  L4(L5)
end
getPctlDPIInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "opt_list"
  L2 = L2(L3)
  L3, L4 = nil, nil
  if L5 ~= "string" then
    L1.code = 1672
    L1.msg = L5
  else
    L3 = L6
    L4 = L5
    if L4 < 0 then
      L1.code = L5
      L1.msg = L5
    elseif L3 then
      for L8, L9 in L5, L6, L7 do
        L1[L8] = L9
      end
    end
  end
  L5(L6)
end
setPctl = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQParentControlV2"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.write
  L2 = L0.readAll
  L3 = "/etc/config/mipctl_user"
  L2, L3 = L2(L3)
  L1(L2, L3)
end
pctlDumpCfg = L13
function L13()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "opt_list"
  L1 = L1(L2)
  L0.arg_str = L1
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
pctlDumpArg = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "opt_list"
  L2 = L2(L3)
  L3 = L0.decode
  L4 = L2
  L3 = L3(L4)
  L1.json = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
pctlDumpJson = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getStorageDeviceList
  L2 = L2()
  L1.deviceList = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getStorageDeviceList = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "devName"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if L3 then
    L2.code = 1502
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4 = L2
    L3(L4)
  end
  L3 = L0.umountStorageDevice
  L4 = L1
  L3 = L3(L4)
  L2.code = L3
  L3 = L2.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = L2.code
    L3 = L3(L4)
    L2.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
umountStorageDevices = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.umountAllStorageDevices
  L2 = L2()
  L1.code = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
umountAllStorageDevices = L13
function L13()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getSambaStatus
  L2 = L2()
  L1.enable = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getSambaStatus = L13
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "enable"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = L0.setSambaStatus
  L5 = L1
  L4 = L4(L5)
  L3 = L4
  L2.code = L3
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setSambaStatus = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "size"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "uuid"
  L2 = L2(L3)
  L3 = {}
  L4 = 0
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L1
  L5 = L5(L6)
  if not L5 then
    L5 = _UPVALUE1_
    L5 = L5.isStrNil
    L6 = L2
    L5 = L5(L6)
    if not L5 then
      goto lbl_36
    end
  end
  L3.code = 1502
  L5 = _UPVALUE2_
  L5 = L5.getErrorMessage
  L6 = L3.code
  L5 = L5(L6)
  L3.msg = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
  ::lbl_36::
  L5 = L0.setSwapInfo
  L6 = L2
  L7 = L1
  L5 = L5(L6, L7)
  L4 = L5
  L3.code = L4
  L5 = L3.code
  if L5 ~= 0 then
    L5 = _UPVALUE2_
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
setSwapInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L3 = {}
  L3.code = 0
  L3.swaptotal = 0
  L3.swapused = 0
  L3.memtotal = 0
  L3.memused = 0
  L3.enable = 0
  L3.uuid = 0
  L3.size = 0
  L4 = L0.getSwapInfo
  L4 = L4()
  L1 = L4
  L4 = L0.getMemInfo
  L4 = L4()
  L2 = L4
  L4 = L2.memtotal
  L3.memtotal = L4
  L4 = L2.memused
  L3.memused = L4
  L4 = L2.swaptotal
  L3.swaptotal = L4
  L4 = L2.swapused
  L3.swapused = L4
  L4 = L1.exist
  L3.exist = L4
  L4 = L1.uuid
  L3.uuid = L4
  L4 = L1.size
  L3.size = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
getSwapInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQTimeMachine"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "enabled"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "password"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "path"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "size"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = L1
  L6 = L6(L7)
  if not L6 then
    L6 = _UPVALUE1_
    L6 = L6.isStrNil
    L7 = L3
    L6 = L6(L7)
    if not L6 then
      L6 = _UPVALUE1_
      L6 = L6.isStrNil
      L7 = L2
      L6 = L6(L7)
      if not L6 then
        goto lbl_51
      end
    end
  end
  L5.code = 1502
  L6 = _UPVALUE2_
  L6 = L6.getErrorMessage
  L7 = L5.code
  L6 = L6(L7)
  L5.msg = L6
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L5
  L6(L7)
  do return end
  ::lbl_51::
  L6 = L0.setTimeMachineInfo
  L7 = L1
  L8 = L3
  L9 = L4
  L10 = L2
  L6 = L6(L7, L8, L9, L10)
  code = L6
  L6 = code
  L5.code = L6
  L6 = L5.code
  if L6 ~= 0 then
    L6 = _UPVALUE2_
    L6 = L6.getErrorMessage
    L7 = L5.code
    L6 = L6(L7)
    L5.msg = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L5
  L6(L7)
end
setTimeMachineInfo = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQTimeMachine"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L2.code = 0
  L2.enabled = ""
  L2.path = ""
  L2.size = ""
  L2.password = ""
  L2.bindStatus = ""
  L3 = L0.getTimeMachineInfo
  L3 = L3()
  L1 = L3
  L3 = L1.enabled
  L2.enabled = L3
  L3 = L1.path
  L2.path = L3
  L3 = L1.size
  L2.size = L3
  L3 = L1.password
  L2.password = L3
  L3 = L1.bindStatus
  L2.bindStatus = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getTimeMachineInfo = L13
function L13()
  local L0, L1, L2, L3, L4
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQStorage"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "uuid"
  L2 = L2(L3)
  L3 = L1.delSwap
  L4 = L2
  L3 = L3(L4)
  L0.code = L3
  L3 = L0.code
  if L3 ~= 0 then
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L0.code
    L3 = L3(L4)
    L0.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
delSwap = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQLEDControlUtil"
  L0 = L0(L1)
  L1 = L0.LEDControl
  L1 = L1.xled
  L2 = {}
  L2.code = 0
  L2.str = "0"
  L3 = L1.analyzeConfig
  L4 = _UPVALUE0_
  L3 = L3(L4)
  if not L3 then
    L2.code = 1523
  else
    L4 = L3.func
    if L4 == "get_config" then
      L4 = L1.getConfig
      L4 = L4()
      if L4 then
        L5 = L4.color_R
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.color_G
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.color_B
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.status
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.event_enable
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.xled_timer_enable
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.xled_timer_open
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " "
        L7 = L4.xled_timer_close
        L5 = L5 .. L6 .. L7
        L2.str = L5
        L5 = L2.str
        L6 = " 0"
        L5 = L5 .. L6
        L2.str = L5
        L5 = L4.default_color
        L2.default_color = L5
      else
        L2.code = 1576
      end
    else
      L4 = L1.setConfig
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L2.code = 0
      else
        L2.code = 1523
      end
    end
  end
  L4 = L2.code
  if L4 ~= 0 then
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L2.code
    L4 = L4(L5)
    L2.msg = L4
  end
  L4 = _UPVALUE2_
  L4 = L4.log
  L5 = _UPVALUE2_
  L5 = L5.INFO
  L6 = "DoEffectLED: result: "
  L7 = L2
  L4(L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
DoEffectLED = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQLEDControlUtil"
  L0 = L0(L1)
  L1 = L0.LEDControl
  L1 = L1.ethled
  L2 = L1.analyzeConfig
  L3 = _UPVALUE0_
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L3.error = 0
  L4 = L1.setConfig
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L3.error = 1523
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L3.error
    L4 = L4(L5)
    L3.msg = L4
  end
  L4 = next
  L5 = L2
  L4 = L4(L5)
  if L4 then
    L4 = L2.status
    L3.status = L4
    L4 = L2.timer
    if L4 then
      L4 = L2.timer
      L4 = L4.status
      L3.timer_status = L4
      L4 = L2.timer
      L4 = L4.start_time
      L3.timer_open = L4
      L4 = L2.timer
      L4 = L4.stop_time
      L3.timer_close = L4
    end
  else
    L4 = L1.getConfig
    L4 = L4()
    if L4 then
      L5 = L4.status
      L3.status = L5
      L5 = L4.timer_status
      L3.timer_status = L5
      L5 = L4.timer_open
      L3.timer_open = L5
      L5 = L4.timer_close
      L3.timer_close = L5
    else
      L3.code = 1576
      L5 = _UPVALUE1_
      L5 = L5.getErrorMessage
      L6 = L3.code
      L5 = L5(L6)
      L3.msg = L5
    end
  end
  L4 = _UPVALUE2_
  L4 = L4.log
  L5 = _UPVALUE2_
  L5 = L5.INFO
  L6 = "DoEthLED: result: "
  L7 = L3
  L4(L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
DoEthLED = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQLEDControlUtil"
  L0 = L0(L1)
  L1 = L0.LEDControl
  L1 = L1.allled
  L2 = L1.analyzeConfig
  L3 = _UPVALUE0_
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L3.error = 0
  L4 = L1.setConfig
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L3.error = 1523
    L4 = _UPVALUE1_
    L4 = L4.getErrorMessage
    L5 = L3.error
    L4 = L4(L5)
    L3.msg = L4
  end
  L4 = next
  L5 = L2
  L4 = L4(L5)
  if L4 then
    L4 = L2.status
    L3.status = L4
  else
    L4 = L1.getConfig
    L4 = L4()
    if L4 then
      L5 = L4.status
      L3.status = L5
    else
      L3.code = 1576
      L5 = _UPVALUE1_
      L5 = L5.getErrorMessage
      L6 = L3.code
      L5 = L5(L6)
      L3.msg = L5
    end
  end
  L4 = _UPVALUE2_
  L4 = L4.log
  L5 = _UPVALUE2_
  L5 = L5.INFO
  L6 = "DoAllLED: result: "
  L7 = L3
  L4(L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
DoAllLED = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQDownload"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "gid"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "option"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "value"
  L5 = L5(L6)
  L5 = L5 or L5
  L6 = {}
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.pause
      L3 = _UPVALUE0_
      L2, L3 = L2(L3)
      L1.code = L3
      L0.info = L2
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.pause = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.unpause
      L3 = _UPVALUE0_
      L2, L3 = L2(L3)
      L1.code = L3
      L0.info = L2
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.unpause = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L2 = L2.pauseAll
    L2, L3 = L2()
    L1.code = L3
    L0.info = L2
  end
  L6.pauseall = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L2 = L2.unpauseAll
    L2, L3 = L2()
    L1.code = L3
    L0.info = L2
  end
  L6.unpauseall = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.remove
      L3 = _UPVALUE0_
      L2, L3 = L2(L3)
      L1.code = L3
      L0.info = L2
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.remove = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.delete
      L3 = _UPVALUE0_
      L2, L3 = L2(L3)
      L1.code = L3
      L0.info = L2
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.delete = L7
  function L7()
    local L0, L1, L2
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE3_
      L1 = L1.errorDelete
      L2 = _UPVALUE0_
      L1 = L1(L2)
      L0.code = L1
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.errordelete = L7
  function L7()
    local L0, L1, L2
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE3_
      L1 = L1.clean
      L2 = _UPVALUE0_
      L1 = L1(L2)
      L0.code = L1
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.clean = L7
  function L7()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      if L0 ~= "" then
        L0 = _UPVALUE2_
        L0 = L0.decode
        L1 = _UPVALUE0_
        L0 = L0(L1)
        _UPVALUE0_ = L0
        L0 = _UPVALUE3_
        L1 = _UPVALUE3_
        L2 = _UPVALUE4_
        L2 = L2.changeOption
        L3 = _UPVALUE0_
        L4 = _UPVALUE1_
        L2, L3 = L2(L3, L4)
        L1.code = L3
        L0.info = L2
    end
    else
      L0 = _UPVALUE3_
      L0.code = 2907
    end
  end
  L6.select = L7
  function L7()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 ~= "" then
      L0 = _UPVALUE1_
      L0 = L0.decode
      L1 = _UPVALUE0_
      L0 = L0(L1)
      _UPVALUE0_ = L0
      L0 = _UPVALUE2_
      L1 = _UPVALUE2_
      L2 = _UPVALUE3_
      L2 = L2.restart
      L3 = _UPVALUE0_
      L2, L3 = L2(L3)
      L1.code = L3
      L0.info = L2
    else
      L0 = _UPVALUE2_
      L0.code = 2907
    end
  end
  L6.restart = L7
  function L7()
    local L0, L1
    L0 = _UPVALUE0_
    L0.code = 2907
  end
  L6[""] = L7
  L7 = L6[L4]
  f = L7
  L7 = f
  if L7 then
    L7 = f
    L7()
  else
    L0.code = 2915
  end
  L7 = L0.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L0.code
    L7 = L7(L8)
    L0.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L0
  L7(L8)
end
setDownloadTaskInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.module.XQDownload"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "gid"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "status"
  L4 = L4(L5)
  L4 = L4 or L4
  if L3 == "" and L4 == "" then
    L1.code = 2907
  end
  if L3 ~= "" then
    L5 = L0.decode
    L6 = L3
    L5 = L5(L6)
    L3 = L5
    L5 = L2.getTaskInfo
    L6 = L3
    L5, L6 = L5(L6)
    L1.code = L6
    L1.info = L5
  else
    L5 = {}
    function L6()
      local L0, L1, L2, L3
      L0 = _UPVALUE0_
      L1 = _UPVALUE0_
      L2 = _UPVALUE1_
      L2 = L2.tellActive
      L2, L3 = L2()
      L1.code = L3
      L0.info = L2
    end
    L5.active = L6
    function L6()
      local L0, L1, L2, L3
      L0 = _UPVALUE0_
      L1 = _UPVALUE0_
      L2 = _UPVALUE1_
      L2 = L2.tellStopped
      L2, L3 = L2()
      L1.code = L3
      L0.info = L2
    end
    L5.stopped = L6
    function L6()
      local L0, L1, L2, L3
      L0 = _UPVALUE0_
      L1 = _UPVALUE0_
      L2 = _UPVALUE1_
      L2 = L2.tellOndownload
      L2, L3 = L2()
      L1.code = L3
      L0.info = L2
    end
    L5.ondownload = L6
    function L6()
      local L0, L1, L2, L3
      L0 = _UPVALUE0_
      L1 = _UPVALUE0_
      L2 = _UPVALUE1_
      L2 = L2.tellWaiting
      L2, L3 = L2()
      L1.code = L3
      L0.info = L2
    end
    L5.waiting = L6
    function L6()
      local L0, L1, L2, L3
      L0 = _UPVALUE0_
      L1 = _UPVALUE0_
      L2 = _UPVALUE1_
      L2 = L2.tellAll
      L2, L3 = L2()
      L1.code = L3
      L0.info = L2
    end
    L5.all = L6
    function L6()
      local L0, L1
      L0 = _UPVALUE0_
      L0.code = 2907
    end
    L5[""] = L6
    L6 = L5[L4]
    if L6 then
      L7 = L6
      L7()
    else
      L1.code = 2915
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
getDownloadTaskInfo = L13
function L13()
  local L0, L1, L2, L3
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQDownload"
  L1 = L1(L2)
  L2 = L1.getGlobalOption
  L2, L3 = L2()
  L0.code = L3
  L0.info = L2
  L2 = L0.code
  if L2 ~= 0 then
    L2 = _UPVALUE0_
    L2 = L2.getErrorMessage
    L3 = L0.code
    L2 = L2(L3)
    L0.msg = L2
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
getDownloadGlobalInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L0.code = 0
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.module.XQDownload"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "max_download_limit"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "max_concurrent_downloads"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "autoclean_cycle"
  L6, L7, L8, L9, L10, L11 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11)
  L5 = L5 or L5
  if L3 == "" and L4 == "" and L5 == "" then
    L0.code = 2907
  else
    if L5 ~= "" then
      if L5 < 0 or 30 < L5 then
        L0.code = 2918
      else
        L7 = L1
        L6 = L1.set
        L8 = "aria2"
        L9 = "main"
        L10 = "autoclean_cycle"
        L11 = L5
        L6(L7, L8, L9, L10, L11)
        L7 = L1
        L6 = L1.commit
        L8 = "aria2"
        L6(L7, L8)
      end
    end
    if L4 ~= "" then
      L6 = tonumber
      L7 = L4
      L6 = L6(L7)
      if not (5 < L6) then
        L6 = tonumber
        L7 = L4
        L6 = L6(L7)
        if not (L6 < 0) then
          goto lbl_73
        end
      end
      L0.code = 2918
      goto lbl_84
      ::lbl_73::
      L6 = L2.changeGlobalOption
      L7 = L3
      L8 = L4
      L6 = L6(L7, L8)
      L0.code = L6
    else
      L6 = L2.changeGlobalOption
      L7 = L3
      L8 = ""
      L6 = L6(L7, L8)
      L0.code = L6
    end
  end
  ::lbl_84::
  L6 = L0.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L0.code
    L6 = L6(L7)
    L0.msg = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L0
  L6(L7)
end
setDownloadGlobalInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = {}
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "luci.http.protocol"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQDownload"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "uris"
  L7 = nil
  L8 = "string"
  L5 = L5(L6, L7, L8)
  L5 = L5 or L5
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "dir"
  L8 = nil
  L9 = "string"
  L6 = L6(L7, L8, L9)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "action"
  L9 = nil
  L10 = "?string"
  L7 = L7(L8, L9, L10)
  L8 = require
  L9 = "xiaoqiang.XQStatPoints"
  L8 = L8(L9)
  L9 = L8.Log
  L10 = "storage.download"
  L11 = "uri:1"
  L9(L10, L11)
  if L5 == "" then
    L0.code = 2907
  else
    if L6 == "" then
      L10 = L2
      L9 = L2.get
      L11 = "aria2"
      L12 = "main"
      L13 = "dir"
      L9 = L9(L10, L11, L12, L13)
      L6 = L9
    end
    L9 = L3.urldecode
    L10 = L5
    L9 = L9(L10)
    L5 = L9
    L9 = L1.decode
    L10 = L5
    L9 = L9(L10)
    L5 = L9
    L9 = L4.addUri
    L10 = L5
    L11 = L6
    L12 = L7
    L9, L10 = L9(L10, L11, L12)
    L0.code = L10
    L0.info = L9
  end
  L9 = L0.code
  if L9 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L0.code
    L9 = L9(L10)
    L0.msg = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L0
  L9(L10)
end
setDownloadUri = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.module.XQDownload"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "file"
  L5 = nil
  L6 = "string"
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "dir"
  L6 = nil
  L7 = "string"
  L4 = L4(L5, L6, L7)
  L4 = L4 or L4
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "action"
  L7 = nil
  L8 = "string"
  L5 = L5(L6, L7, L8)
  L5 = L5 or L5
  L6 = require
  L7 = "xiaoqiang.XQStatPoints"
  L6 = L6(L7)
  L7 = L6.Log
  L8 = "storage.download"
  L9 = "torrent:1"
  L7(L8, L9)
  if L3 ~= "" then
    if L4 == "" then
      L8 = L1
      L7 = L1.get
      L9 = "aria2"
      L10 = "main"
      L11 = "dir"
      L7 = L7(L8, L9, L10, L11)
      L4 = L7
    end
    L7 = L2.addTorrent
    L8 = L3
    L9 = L4
    L10 = L5
    L7, L8 = L7(L8, L9, L10)
    L0.code = L8
    L0.info = L7
  else
    L0.code = 2907
  end
  L7 = L0.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L0.code
    L7 = L7(L8)
    L0.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L0
  L7(L8)
end
setDownloadTorrent = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQDownload"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "path"
  L4 = nil
  L5 = "?string"
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "option"
  L5 = nil
  L6 = "string"
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  L4 = L1.searchBitTorrentFile
  L5 = L2
  L6 = L3
  L4, L5, L6 = L4(L5, L6)
  L0.status = L6
  L0.code = L5
  L0.info = L4
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
DownloadSearchFile = L13
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQDownload"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "gid"
  L4 = nil
  L5 = "?commonstr"
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  L3 = L1.filePathGet
  L4 = L2
  L3 = L3(L4)
  if L3 ~= "" then
    L4 = L1.checkPath
    L5 = L3
    L4 = L4(L5)
    L0.code = L4
    L4 = L0.code
    if L4 ~= 0 then
      L4 = L1.fileNotExist
      L5 = L2
      L4(L5)
    end
  else
    L0.code = 2906
  end
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
DownloadCheckPath = L13
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQDownload"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "option"
  L4 = nil
  L5 = "?numberstr"
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  if L2 == "" then
    L3 = L1.getStatus
    L3, L4 = L3()
    L0.code = L4
    L0.info = L3
  else
    L3 = L1.setStatus
    L4 = L2
    L3, L4 = L3(L4)
    L0.code = L4
    L0.info = L3
  end
  L3 = L0.code
  if L3 ~= 0 then
    L3 = _UPVALUE1_
    L3 = L3.getErrorMessage
    L4 = L0.code
    L3 = L3(L4)
    L0.msg = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
DownloadStatus = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L0 = L0.connect
  L0 = L0()
  L1 = {}
  if L0 then
    L3 = L0
    L2 = L0.call
    L4 = "mitempctrl"
    L5 = "status"
    L6 = {}
    L2 = L2(L3, L4, L5, L6)
    L1 = L2
    L3 = L0
    L2 = L0.close
    L2(L3)
  end
  if L1 then
    L2 = next
    L3 = L1
    L2 = L2(L3)
    if L2 then
      L1.code = 0
  end
  else
    L2 = {}
    L2.code = 1576
    L1 = L2
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
GetTempCtrl = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "fan_mode"
  L4 = nil
  L5 = "numberstr"
  L2 = L2(L3, L4, L5)
  if L2 then
    L4 = L0
    L3 = L0.get
    L5 = "mitempctrl"
    L6 = L2
    L7 = "tgt_temp"
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L5 = L0
      L4 = L0.set
      L6 = "mitempctrl"
      L7 = "settings"
      L8 = "mode"
      L9 = L2
      L4(L5, L6, L7, L8, L9)
      L5 = L0
      L4 = L0.commit
      L6 = "mitempctrl"
      L4(L5, L6)
      L4 = _UPVALUE1_
      L4 = L4.isMeshCap
      L4 = L4()
      if L4 then
        L4 = _UPVALUE1_
        L4 = L4.GenRandID
        L5 = 8
        L4 = L4(L5)
        L6 = L0
        L5 = L0.set
        L7 = "mitempctrl"
        L8 = "settings"
        L9 = "config_sum"
        L10 = L4
        L5(L6, L7, L8, L9, L10)
        L6 = L0
        L5 = L0.commit
        L7 = "mitempctrl"
        L5(L6, L7)
        L5 = _UPVALUE1_
        L5 = L5.forkExec
        L6 = "/sbin/whc_to_re_common_api.sh whc_sync"
        L5(L6)
      end
      L4 = require
      L5 = "ubus"
      L4 = L4(L5)
      L4 = L4.connect
      L4 = L4()
      if L4 then
        L6 = L4
        L5 = L4.call
        L7 = "mitempctrl"
        L8 = "reload"
        L9 = {}
        L5 = L5(L6, L7, L8, L9)
        L7 = L4
        L6 = L4.close
        L6(L7)
        if not L5 then
          L1.code = 1575
        else
          L6 = L5.ret
          L1.code = L6
        end
      else
        L1.code = 1575
      end
      L5 = _UPVALUE1_
      L5 = L5.forkExec
      L6 = "/etc/init.d/powerctl restart"
      L5(L6)
    else
      L1.code = 1537
    end
  else
    L1.code = 1537
  end
  L3 = L1.code
  if L3 ~= 0 then
    L3 = _UPVALUE2_
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
SetTempCtrl = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "bhmode"
  L2 = L2(L3)
  L2 = L2 or L2
  L4 = L0
  L3 = L0.get_all
  L5 = "wireless"
  L6 = "meshbhmode"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L0
    L3 = L0.section
    L5 = "wireless"
    L6 = "meshbhmode"
    L7 = "meshbhmode"
    L8 = {}
    L8.mode = L2
    L3(L4, L5, L6, L7, L8)
  else
    L4 = L0
    L3 = L0.set
    L5 = "wireless"
    L6 = "meshbhmode"
    L7 = "mode"
    L8 = L2
    L3(L4, L5, L6, L7, L8)
  end
  L4 = L0
  L3 = L0.commit
  L5 = "wireless"
  L3(L4, L5)
  L3 = _UPVALUE1_
  L3 = L3.forkExec
  L4 = "ubus call topomon bhmode_change"
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
setMeshBhMode = L13
function L13()
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
  L4 = "wireless"
  L5 = "meshbhmode"
  L6 = "mode"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.bhmode = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getMeshBhMode = L13
