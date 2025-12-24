local L0, L1, L2, L3, L4
L0 = module
L1 = "luci.controller.api.xqsystem"
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
  L5 = "xqsystem"
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
  L5 = "xqsystem"
  L6 = "login"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "actionLogin"
  L4 = L4(L5)
  L5 = ""
  L6 = 109
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "maccel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setMobileAccel"
  L4 = L4(L5)
  L5 = ""
  L6 = 101
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "ma_check"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "checkMobileAccel"
  L4 = L4(L5)
  L5 = ""
  L6 = 101
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "init_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getInitInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 101
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "fac_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getFacInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 101
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "farewell"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "farewell"
  L4 = L4(L5)
  L5 = ""
  L6 = 102
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "token"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getToken"
  L4 = L4(L5)
  L5 = ""
  L6 = 103
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_inited"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setInited"
  L4 = L4(L5)
  L5 = ""
  L6 = 103
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_name_password"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPassword"
  L4 = L4(L5)
  L5 = ""
  L6 = 105
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "check_rom_update"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "checkRomUpdate"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "lan_wan"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLanWanSta"
  L4 = L4(L5)
  L5 = ""
  L6 = 106
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "router_bind_ok"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "routerBindOk"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "new_router_bind_ok"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "newrouterBindOk"
  L4 = L4(L5)
  L5 = ""
  L6 = 107
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "flash_rom"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "flashRom"
  L4 = L4(L5)
  L5 = ""
  L6 = 108
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_router_name"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setRouterName"
  L4 = L4(L5)
  L5 = ""
  L6 = 109
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "router_name"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRouterName"
  L4 = L4(L5)
  L5 = ""
  L6 = 110
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "device_list"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceList"
  L4 = L4(L5)
  L5 = ""
  L6 = 112
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_device_nickname"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDeviceNickName"
  L4 = L4(L5)
  L5 = ""
  L6 = 113
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "internet_connect"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "isInternetConnect"
  L4 = L4(L5)
  L5 = ""
  L6 = 114
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upload_rom"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "uploadRom"
  L4 = L4(L5)
  L5 = ""
  L6 = 115
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upload_plug"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "uploadPlug"
  L4 = L4(L5)
  L5 = ""
  L6 = 116
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "installed_plug"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "installedPlug"
  L4 = L4(L5)
  L5 = ""
  L6 = 117
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_languages"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLangList"
  L4 = L4(L5)
  L5 = ""
  L6 = 118
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_main_language"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMainLang"
  L4 = L4(L5)
  L5 = ""
  L6 = 119
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_language"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLang"
  L4 = L4(L5)
  L5 = ""
  L6 = 120
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upload_rom_split"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "uploadRomSplit"
  L4 = L4(L5)
  L5 = ""
  L6 = 121
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upload_log"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "uploadLogFile"
  L4 = L4(L5)
  L5 = ""
  L6 = 124
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "router_init"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setRouter"
  L4 = L4(L5)
  L5 = ""
  L6 = 126
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "information"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getAllInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 127
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getStatusInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 128
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "count"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getConDevCount"
  L4 = L4(L5)
  L5 = ""
  L6 = 129
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "reboot"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "reboot"
  L4 = L4(L5)
  L5 = ""
  L6 = 130
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "reset"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "reset"
  L4 = L4(L5)
  L5 = ""
  L6 = 131
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "unbind"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "unbind"
  L4 = L4(L5)
  L5 = ""
  L2(L3, L4, L5)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "passport_bind_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPassportBindInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 132
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_passport_bound"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPassportBound"
  L4 = L4(L5)
  L5 = ""
  L6 = 133
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_sys_avg_load"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getSysAvgLoad"
  L4 = L4(L5)
  L5 = ""
  L6 = 134
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_mac_filter"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setMacFilter"
  L4 = L4(L5)
  L5 = ""
  L6 = 135
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "renew_token"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "renewToken"
  L4 = L4(L5)
  L5 = ""
  L6 = 136
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_ip"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIp"
  L4 = L4(L5)
  L5 = ""
  L6 = 136
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "remove_passport_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "removePassportBindInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 137
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upgrade_rom"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "upgradeRom"
  L4 = L4(L5)
  L5 = ""
  L6 = 138
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "wps"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "openWps"
  L4 = L4(L5)
  L5 = ""
  L6 = 139
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "wps_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWpsStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 140
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "stop_nginx"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "stopNginx"
  L4 = L4(L5)
  L5 = ""
  L6 = 141
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "check_router_name_pending"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "checkRouterNamePending"
  L4 = L4(L5)
  L5 = ""
  L6 = 142
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "clear_router_name_pending"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "clearRouterNamePending"
  L4 = L4(L5)
  L5 = ""
  L6 = 143
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "web_url"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "redirectUrl"
  L4 = L4(L5)
  L5 = ""
  L6 = 144
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "start_nginx"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "startNginx"
  L4 = L4(L5)
  L5 = ""
  L6 = 145
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "nginx"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "nginxCacheStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 146
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "flash_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "flashStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 147
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upgrade_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "upgradeStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 148
  L7 = 13
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "create_sandbox"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "createSandbox"
  L4 = L4(L5)
  L5 = ""
  L6 = 149
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "is_sandbox_created"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "isSandboxCreated"
  L4 = L4(L5)
  L5 = ""
  L6 = 150
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "mount_things"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "mountThings"
  L4 = L4(L5)
  L5 = ""
  L6 = 151
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "umount_things"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "umountThings"
  L4 = L4(L5)
  L5 = ""
  L6 = 152
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "are_things_mounted"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "areThingsMounted"
  L4 = L4(L5)
  L5 = ""
  L6 = 153
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "start_dropbear"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "startDropbear"
  L4 = L4(L5)
  L5 = ""
  L6 = 154
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "stop_dropbear"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "stopDropbear"
  L4 = L4(L5)
  L5 = ""
  L6 = 155
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "is_dropbear_started"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "isDropbearStarted"
  L4 = L4(L5)
  L5 = ""
  L6 = 156
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "main_status_for_app"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "mainStatusForApp"
  L4 = L4(L5)
  L5 = ""
  L6 = 157
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getMacfilterMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 158
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_mode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setMacfilterMode"
  L4 = L4(L5)
  L5 = ""
  L6 = 159
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "cancel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "cancelUpgrade"
  L4 = L4(L5)
  L5 = ""
  L6 = 160
  L7 = 13
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "shutdown"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "shutdown"
  L4 = L4(L5)
  L5 = ""
  L6 = 161
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upnp"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "upnpList"
  L4 = L4(L5)
  L5 = ""
  L6 = 162
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "upnp_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "upnpSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 163
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "app_limit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "appLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 164
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "xunlei_api"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "xunlei_api"
  L4 = L4(L5)
  L5 = ""
  L6 = 164
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "app_limit_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "appLimitSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 165
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_app_limit"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setAppLimit"
  L4 = L4(L5)
  L5 = ""
  L6 = 166
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "vpn"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "vpnInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 167
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "vpn_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "vpnStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 168
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "vpn_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "vpnSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 169
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_vpn"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVpn"
  L4 = L4(L5)
  L5 = ""
  L6 = 170
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "del_vpn"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "delVpn"
  L4 = L4(L5)
  L5 = ""
  L6 = 171
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_vpnauto"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setVpnAuto"
  L4 = L4(L5)
  L5 = ""
  L6 = 172
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "device_mac"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceMacaddr"
  L4 = L4(L5)
  L5 = ""
  L6 = 173
  L7 = 1
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "wps_cancel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "stopWps"
  L4 = L4(L5)
  L5 = ""
  L6 = 174
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "detection_ts"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDetectionTimestamp"
  L4 = L4(L5)
  L5 = ""
  L6 = 175
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "wifi_log"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiLog"
  L4 = L4(L5)
  L5 = ""
  L6 = 176
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "sys_recovery"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "sysRecovery"
  L4 = L4(L5)
  L5 = ""
  L6 = 177
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "smart_shutdown"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "smartShutdown"
  L4 = L4(L5)
  L5 = ""
  L6 = 178
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "device_list_zigbee"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDeviceListZigbee"
  L4 = L4(L5)
  L5 = ""
  L6 = 179
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "noflushd"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getNofStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 180
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "nof_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "nofSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 181
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "pred_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "predownloadInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 182
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "pred_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "predownloadSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 183
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "privacy"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "privacy"
  L4 = L4(L5)
  L5 = ""
  L6 = 184
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_privacy"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPrivacy"
  L4 = L4(L5)
  L5 = ""
  L6 = 185
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_privacy_new"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPrivacy_new"
  L4 = L4(L5)
  L5 = ""
  L6 = 185
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "disk_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDiskInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 186
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "io_data"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getIOData"
  L4 = L4(L5)
  L5 = ""
  L6 = 187
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "disk_scan"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskScan"
  L4 = L4(L5)
  L5 = ""
  L6 = 188
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "disk_check"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskCheck"
  L4 = L4(L5)
  L5 = ""
  L6 = 189
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "disk_check_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "diskCheckStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 190
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "country_code"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getCountryCode"
  L4 = L4(L5)
  L5 = ""
  L6 = 191
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_country_code"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setCountryCode"
  L4 = L4(L5)
  L5 = ""
  L6 = 192
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "push_settings"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getPushSettings"
  L4 = L4(L5)
  L5 = ""
  L6 = 193
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "push_switch"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "pushSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 194
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "dev_notify"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDevNotify"
  L4 = L4(L5)
  L5 = ""
  L6 = 195
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "ota"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getOTAInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 196
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_ota"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setOTAInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 197
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "sdev"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "specialDevCount"
  L4 = L4(L5)
  L5 = ""
  L6 = 198
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "devicelist"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "devicelistForMAgent"
  L4 = L4(L5)
  L5 = ""
  L6 = 199
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "flash_permission"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "flashPermission"
  L4 = L4(L5)
  L5 = ""
  L6 = 200
  L7 = 13
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "userdisk_data"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getUserdiskDataInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 201
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "backup_data"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "backupData"
  L4 = L4(L5)
  L5 = ""
  L6 = 202
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "backup_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "backupStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 203
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "backup_cancel"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "backupCancel"
  L4 = L4(L5)
  L5 = ""
  L6 = 204
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "usbservice"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "usbServiceSwitch"
  L4 = L4(L5)
  L5 = ""
  L6 = 205
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "usbmode"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "usbmode"
  L4 = L4(L5)
  L5 = ""
  L6 = 206
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_payment_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setPaymentInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 207
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "sign_order"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "signOrder"
  L4 = L4(L5)
  L5 = ""
  L6 = 208
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "oneclick_get_remote_token"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "oneClickGetRemoteToken"
  L4 = L4(L5)
  L5 = ""
  L6 = 209
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "extendwifi_request_remote_api"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ExtendWifiRequestRemoteAPI"
  L4 = L4(L5)
  L5 = ""
  L6 = 210
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "extendwifi_get_root_dir_info"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ExtendWifiGetRootDirInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 211
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "extendwifi_get_root_dir_useage"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ExtendWifiGetRootDirUseage"
  L4 = L4(L5)
  L5 = ""
  L6 = 212
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "extendwifi_connect_inited_router"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ExtendWifiConnectInitedRouter"
  L4 = L4(L5)
  L5 = ""
  L6 = 214
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "extendwifi_sign_for_auto_band"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "ExtendWifiSignForAutoBand"
  L4 = L4(L5)
  L5 = ""
  L6 = 215
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
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
  L5 = "xqsystem"
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
  L5 = "xqsystem"
  L6 = "get_location"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getLocation"
  L4 = L4(L5)
  L5 = ""
  L6 = 225
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_location"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setLocation"
  L4 = L4(L5)
  L5 = ""
  L6 = 226
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_access_force_https"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getForceHttps"
  L4 = L4(L5)
  L5 = ""
  L6 = 227
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_access_force_https"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setForceHttps"
  L4 = L4(L5)
  L5 = ""
  L6 = 228
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "clear_upgrade_result"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "clearUpgradeResult"
  L4 = L4(L5)
  L5 = ""
  L6 = 229
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_register_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getRegisterStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 230
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_sim_status"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getSimStatus"
  L4 = L4(L5)
  L5 = ""
  L6 = 231
  L7 = 9
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_wps_enable"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWpsEnabled"
  L4 = L4(L5)
  L5 = ""
  L6 = 232
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "modem_logd_start"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "modemLogdStart"
  L4 = L4(L5)
  L5 = ""
  L6 = 233
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "modem_logd_stop"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "modemLogdStop"
  L4 = L4(L5)
  L5 = ""
  L6 = 234
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "dmz"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getDMZInfo"
  L4 = L4(L5)
  L5 = ""
  L6 = 250
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_dmz"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setDMZ"
  L4 = L4(L5)
  L5 = ""
  L6 = 251
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "dmz_off"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "closeDMZ"
  L4 = L4(L5)
  L5 = ""
  L6 = 252
  L2(L3, L4, L5, L6)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "dmz_reload"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "reloadDMZ"
  L4 = L4(L5)
  L5 = ""
  L6 = 252
  L2(L3, L4, L5, L6)
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "natpro"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_vs_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_vs_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 300
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_vs_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_vs_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 301
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_vs_range_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_vs_range_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 302
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "del_vs_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "del_vs_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 303
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "apply_vs_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "apply_vs_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 304
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_pt_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_pt_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 305
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_pt_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_pt_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 306
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "del_pt_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "del_pt_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 307
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "apply_pt_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "apply_pt_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 308
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_alg_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_alg_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 309
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_alg_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_alg_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 310
      L2(L3, L4, L5, L6)
  end
  else
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "xqsystem"
    L6 = "portforward"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "portForward"
    L4 = L4(L5)
    L5 = ""
    L6 = 311
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "xqsystem"
    L6 = "add_redirect"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "addRedirect"
    L4 = L4(L5)
    L5 = ""
    L6 = 312
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "xqsystem"
    L6 = "add_range_redirect"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "addRangeRedirect"
    L4 = L4(L5)
    L5 = ""
    L6 = 313
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "xqsystem"
    L6 = "delete_redirect"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "deleteRedirect"
    L4 = L4(L5)
    L5 = ""
    L6 = 314
    L2(L3, L4, L5, L6)
    L2 = entry
    L3 = {}
    L4 = "api"
    L5 = "xqsystem"
    L6 = "redirect_apply"
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L4 = call
    L5 = "redirectApply"
    L4 = L4(L5)
    L5 = ""
    L6 = 315
    L2(L3, L4, L5, L6)
  end
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "firewall"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_firewall_enable"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_firewall_enable"
      L4 = L4(L5)
      L5 = ""
      L6 = 316
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_firewall_enable"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_firewall_enable"
      L4 = L4(L5)
      L5 = ""
      L6 = 317
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_spi_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_spi_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 318
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_spi_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_spi_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 319
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_dos_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_dos_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 320
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_dos_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_dos_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 321
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_wanping_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_wanping_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 322
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_wanping_firewall"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_wanping_firewall"
      L4 = L4(L5)
      L5 = ""
      L6 = 323
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_macfilter_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_macfilter_info"
      L4 = L4(L5)
      L5 = ""
      L6 = 324
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_macfilter_enable_mode"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_macfilter_enable_mode"
      L4 = L4(L5)
      L5 = ""
      L6 = 325
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_macfilter_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_macfilter_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 326
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_macfilter_rule"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_macfilter_rule"
      L4 = L4(L5)
      L5 = ""
      L6 = 327
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_ipfilter_info"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "get_ipfilter_info"
      L4 = L4(L5)
      L5 = ""
      L6 = 328
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_ipfilter_enable_mode"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_ipfilter_enable_mode"
      L4 = L4(L5)
      L5 = ""
      L6 = 329
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_ipfilter_rules"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_ipfilter_rules"
      L4 = L4(L5)
      L5 = ""
      L6 = 430
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "set_ipfilter_rule"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "set_ipfilter_rule"
      L4 = L4(L5)
      L5 = ""
      L6 = 431
      L2(L3, L4, L5, L6)
    end
  end
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "get_wifi_split"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "getWifiSplit"
  L4 = L4(L5)
  L5 = ""
  L6 = 330
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "set_wifi_split"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "setWifiSplit"
  L4 = L4(L5)
  L5 = ""
  L6 = 331
  L7 = 8
  L2(L3, L4, L5, L6, L7)
  L2 = entry
  L3 = {}
  L4 = "api"
  L5 = "xqsystem"
  L6 = "start_binding"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = call
  L5 = "startBinding"
  L4 = L4(L5)
  L5 = ""
  L6 = 332
  L2(L3, L4, L5, L6)
  L2 = "apps"
  L2 = L1[L2]
  if L2 then
    L2 = "apps"
    L2 = L1[L2]
    L3 = "sec_center"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "sec_center_status"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "secCenterStatus"
      L4 = L4(L5)
      L5 = ""
      L6 = 999
      L2(L3, L4, L5, L6)
    end
  end
  L2 = "system"
  L2 = L1[L2]
  if L2 then
    L2 = "system"
    L2 = L1[L2]
    L3 = "web_acc_log"
    L2 = L2[L3]
    L3 = "1"
    if L2 == L3 then
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "get_login_record"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "getLoginRecord"
      L4 = L4(L5)
      L5 = ""
      L6 = 229
      L2(L3, L4, L5, L6)
      L2 = entry
      L3 = {}
      L4 = "api"
      L5 = "xqsystem"
      L6 = "clear_login_record"
      L3[1] = L4
      L3[2] = L5
      L3[3] = L6
      L4 = call
      L5 = "clearLoginRecord"
      L4 = L4(L5)
      L5 = ""
      L6 = 230
      L2(L3, L4, L5, L6)
    end
  end
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.util.XQSysUtil"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQErrorUtil"
L3 = L3(L4)
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = luci
  L2 = L2.http
  L2 = L2.getenv
  L3 = "REMOTE_ADDR"
  L2 = L2(L3)
  L3 = luci
  L3 = L3.sys
  L3 = L3.net
  L3 = L3.ip4mac
  L4 = L2 or L4
  if not L2 then
    L4 = ""
  end
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "type"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "mode"
  L6 = L6(L7)
  L7 = nil
  L8 = L1.isStrNil
  L9 = L2
  L8 = L8(L9)
  if L8 then
    L4.code = -1
    L8 = L0.log
    L9 = 6
    L10 = "setMobileAccel: remote_ip is null"
    L8(L9, L10)
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L4
    L8(L9)
    return
  end
  L8 = L1.isStrNil
  L9 = L3
  L8 = L8(L9)
  if L8 then
    L4.code = -2
    L8 = L0.log
    L9 = 6
    L10 = "setMobileAccel: remote_mac is null"
    L8(L9, L10)
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L4
    L8(L9)
    return
  end
  if L5 == "1" or L5 == "3" then
    L8 = L1.isStrNil
    L9 = L6
    L8 = L8(L9)
    if not L8 then
      L8 = tonumber
      L9 = L6
      L8 = L8(L9)
      if not (L8 < 1) then
        L8 = tonumber
        L9 = L6
        L8 = L8(L9)
        if not (4 < L8) then
          goto lbl_93
        end
      end
      L4.code = -4
      L8 = L0.log
      L9 = 6
      L10 = "setMobileAccel: invalid mode("
      L11 = L6
      L12 = ")"
      L10 = L10 .. L11 .. L12
      L8(L9, L10)
      L8 = _UPVALUE0_
      L8 = L8.write_json
      L9 = L4
      L8(L9)
      do return end
      ::lbl_93::
      if L5 == "1" then
        L7 = "on"
      else
        L7 = "off"
      end
  end
  elseif L5 == "2" then
    L7 = "renew"
  else
    L4.code = -3
    L8 = L0.log
    L9 = 6
    L10 = "setMobileAccel: invalid type("
    L11 = L5
    L12 = ")"
    L10 = L10 .. L11 .. L12
    L8(L9, L10)
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L4
    L8(L9)
    return
  end
  L8 = L1._strformat
  L9 = L7
  L8 = L8(L9)
  L7 = L8
  L8 = L1._strformat
  L9 = L6
  L8 = L8(L9)
  L6 = L8
  L8 = L1.forkExec
  L9 = "/usr/sbin/mobile_accel.sh '"
  L10 = L7
  L11 = "' '"
  L12 = L2
  L13 = "' '"
  L14 = L3
  L15 = "' '"
  L16 = L6
  L17 = "'"
  L9 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L8(L9)
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L4
  L8(L9)
end
setMobileAccel = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = luci
  L3 = L3.http
  L3 = L3.getenv
  L4 = "REMOTE_ADDR"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = luci
  L4 = L4.sys
  L4 = L4.net
  L4 = L4.ip4mac
  L5 = L3
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mode"
  L5 = L5(L6)
  L6 = {}
  L6.code = 0
  L7 = L2.isStrNil
  L8 = L4
  L7 = L7(L8)
  if L7 then
    L6.code = -2
    L7 = L0.log
    L8 = 6
    L9 = "checkMobileAccel: remote_mac is null"
    L7(L8, L9)
    L7 = _UPVALUE0_
    L7 = L7.write_json
    L8 = L6
    L7(L8)
    return
  end
  L7 = string
  L7 = L7.lower
  L8 = string
  L8 = L8.gsub
  L9 = L4
  L10 = "[:-]"
  L11 = ""
  L8, L9, L10, L11 = L8(L9, L10, L11)
  L7 = L7(L8, L9, L10, L11)
  L4 = L7
  L8 = L1
  L7 = L1.get
  L9 = "mobile_accel"
  L10 = L4
  L11 = "mode"
  L7 = L7(L8, L9, L10, L11)
  cur_mode = L7
  L7 = cur_mode
  if not L7 then
    L6.code = -1
  else
    L7 = cur_mode
    L6.mode = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
end
checkMobileAccel = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = L3.xssCheck
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "sign_str"
  L5 = L5(L6)
  L5 = L5 or L5
  L4 = L4(L5)
  if L4 == nil then
    L2.code = 1612
    L2.msg = "Warning: Blocked by XSS Check"
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L2
    L5(L6)
    return
  elseif L4 == "" then
    L2.code = 1612
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L2
    L5(L6)
    return
  end
  L5 = L1.log
  L6 = 1
  L7 = "sign_str:"
  L8 = L4
  L7 = L7 .. L8
  L5(L6, L7)
  L2.signed_str = L4
  L6 = L0
  L5 = L0.get
  L7 = "messaging"
  L8 = "deviceInfo"
  L9 = "DEVICE_ID"
  L5 = L5(L6, L7, L8, L9)
  L2.deviceid = L5
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
ExtendWifiSignForAutoBand = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.module.XQAPModule"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQExtendWifi"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L2.msg = ""
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ssid"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "encryption"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "enctype"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "password"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "channel"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "band"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "admin_username"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "admin_password"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "admin_nonce"
  L11 = L11(L12)
  L12 = L0.extendwifi_set_connect
  L13 = L3
  L14 = L6
  L15 = L5
  L16 = L4
  L17 = L8
  L18 = L7
  L12 = L12(L13, L14, L15, L16, L17, L18)
  L13 = L12.ip
  if L13 ~= "" then
    L2.code = 0
    L2.msg = "connect succces!"
  else
    L13 = L12.connected
    if L13 then
      L13 = L12.dhcpcode
      if L13 == 100 then
        L2.code = 1646
        L13 = _UPVALUE1_
        L13 = L13.getErrorMessage
        L14 = L2.code
        L13 = L13(L14)
        L2.msg = L13
      else
        L13 = L12.dhcpcode
        if L13 == 2 then
          L2.code = 1647
          L13 = _UPVALUE1_
          L13 = L13.getErrorMessage
          L14 = L2.code
          L13 = L13(L14)
          L2.msg = L13
        else
          L13 = L12.dhcpcode
          if L13 == 102 then
            L2.code = 1648
            L13 = _UPVALUE1_
            L13 = L13.getErrorMessage
            L14 = L2.code
            L13 = L13(L14)
            L2.msg = L13
          else
            L13 = L12.dhcpcode
            if L13 ~= 105 then
              L13 = L12.dhcpcode
              if L13 ~= 106 then
                goto lbl_106
              end
            end
            L2.code = 1649
            L13 = _UPVALUE1_
            L13 = L13.getErrorMessage
            L14 = L2.code
            L13 = L13(L14)
            L2.msg = L13
            goto lbl_144
            ::lbl_106::
            L13 = L12.dhcpcode
            if L13 == 107 then
              L2.code = 1650
              L13 = _UPVALUE1_
              L13 = L13.getErrorMessage
              L14 = L2.code
              L13 = L13(L14)
              L2.msg = L13
            else
              L13 = L12.dhcpcode
              if L13 ~= 110 then
                L13 = L12.dhcpcode
                if L13 ~= 111 then
                  goto lbl_129
                end
              end
              L2.code = 1651
              L13 = _UPVALUE1_
              L13 = L13.getErrorMessage
              L14 = L2.code
              L13 = L13(L14)
              L2.msg = L13
              goto lbl_144
              ::lbl_129::
              L13 = L12.dhcpcode
              if L13 ~= 115 then
                L13 = L12.dhcpcode
                if L13 ~= 116 then
                  goto lbl_142
                end
              end
              L2.code = 1652
              L13 = _UPVALUE1_
              L13 = L13.getErrorMessage
              L14 = L2.code
              L13 = L13(L14)
              L2.msg = L13
              goto lbl_144
              ::lbl_142::
              L2.code = 1619
              L2.msg = "dhcp failed!"
            end
          end
        end
      end
      ::lbl_144::
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L2
      L13(L14)
      return
    else
      L2.code = 1616
      L2.msg = "wifi connect faild!"
      L13 = _UPVALUE0_
      L13 = L13.write_json
      L14 = L2
      L13(L14)
      return
    end
  end
  L13 = L1.oneClickGetRemoteTokenForLua
  L14 = L9
  L15 = L10
  L16 = L11
  L13 = L13(L14, L15, L16)
  L14 = L13.code
  if L14 ~= 0 then
    L14 = _UPVALUE1_
    L14 = L14.getErrorMessage
    L15 = L13.code
    L14 = L14(L15)
    L13.msg = L14
    L14 = _UPVALUE0_
    L14 = L14.write_json
    L15 = L13
    L14(L15)
    return
  end
  L14 = _UPVALUE0_
  L14 = L14.write_json
  L15 = L13
  L14(L15)
end
ExtendWifiConnectInitedRouter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQExtendWifi"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "extendwifi_act"
  L3 = L3(L4)
  L4 = {}
  L4.api = 116
  L5 = require
  L6 = "cjson"
  L5 = L5(L6)
  L6 = L5.encode
  L7 = L4
  L6 = L6(L7)
  L7 = L1.ExtendWifiCallOldRouterDataCenterAPI
  L8 = L3
  L9 = L6
  L7 = L7(L8, L9)
  L8 = L0.log
  L9 = 1
  L10 = "ret_old.code"
  L11 = L7.code
  L10 = L10 .. L11
  L8(L9, L10)
  L8 = L7.code
  if L8 == 0 then
    L8 = require
    L9 = "cjson"
    L8 = L8(L9)
    L9 = L8.decode
    L10 = L7.msg
    L9 = L9(L10)
    L10 = L9.code
    if L10 ~= 0 then
      L2.code = 1644
      L10 = _UPVALUE1_
      L10 = L10.getErrorMessage
      L11 = L2.code
      L10 = L10(L11)
      L2.msg = L10
      L10 = _UPVALUE0_
      L10 = L10.write_json
      L11 = L2
      L10(L11)
      return
    end
  end
  L8 = L7.code
  if L8 == 1643 then
    L2.code = 1644
    L8 = _UPVALUE1_
    L8 = L8.getErrorMessage
    L9 = L2.code
    L8 = L8(L9)
    L2.msg = L8
    L8 = _UPVALUE0_
    L8 = L8.write_json
    L9 = L2
    L8(L9)
    return
  end
  L8 = L1.ExtendWifiCallNewRouterDataCenterAPI
  L9 = L3
  L10 = L6
  L8 = L8(L9, L10)
  L9 = L0.log
  L10 = 1
  L11 = "ret_new:"
  L12 = L8.code
  L11 = L11 .. L12
  L9(L10, L11)
  L9 = L8.code
  if L9 == 0 then
    L9 = require
    L10 = "cjson"
    L9 = L9(L10)
    L10 = L9.decode
    L11 = L8.msg
    L10 = L10(L11)
    L11 = L10.code
    if L11 ~= 0 then
      L2.code = 1645
      L11 = _UPVALUE1_
      L11 = L11.getErrorMessage
      L12 = L2.code
      L11 = L11(L12)
      L2.msg = L11
      L11 = _UPVALUE0_
      L11 = L11.write_json
      L12 = L2
      L11(L12)
      return
    end
  end
  L9 = L8.code
  if L9 == 1643 then
    L9 = nil
    L10 = L1.ExtendWifiRequestRemoteAPIForLua
    L11 = "/service/datacenter/is_has_disk"
    L12 = "1"
    L10 = L10(L11, L12)
    L11 = L10.code
    if L11 == 0 then
      L11 = require
      L12 = "cjson"
      L11 = L11(L12)
      L12 = L11.decode
      L13 = L10.msg
      L12 = L12(L13)
      L13 = L12.code
      if L13 == 0 then
        L13 = L12.isHasDisk
        if L13 == true then
          L8.code = 0
      end
      else
        L2.code = 1645
        L13 = _UPVALUE1_
        L13 = L13.getErrorMessage
        L14 = L2.code
        L13 = L13(L14)
        L2.msg = L13
        L13 = _UPVALUE0_
        L13 = L13.write_json
        L14 = L2
        L13(L14)
        return
      end
    else
      L2.code = 1645
      L11 = _UPVALUE1_
      L11 = L11.getErrorMessage
      L12 = L2.code
      L11 = L11(L12)
      L2.msg = L11
      L11 = _UPVALUE0_
      L11 = L11.write_json
      L12 = L2
      L11(L12)
      return
    end
  end
  L9 = L8.code
  if L9 == 0 then
    L9 = L7.code
    if L9 == 0 then
      goto lbl_173
    end
  end
  L9 = L7.code
  if L9 == 0 then
    L9 = L8.code
    L2.code = L9
  else
    L9 = L7.code
    L2.code = L9
  end
  L9 = _UPVALUE1_
  L9 = L9.getErrorMessage
  L10 = L2.code
  L9 = L9(L10)
  L2.msg = L9
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L2
  L9(L10)
  goto lbl_177
  ::lbl_173::
  L9 = _UPVALUE0_
  L9 = L9.write
  L10 = L7.msg
  L9(L10)
  ::lbl_177::
end
ExtendWifiGetRootDirUseage = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQExtendWifi"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "extendwifi_act"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "PrimaryDisk"
  L4 = L4(L5)
  if L4 == nil or L4 == "" then
    L2.code = 1612
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L2
    L5(L6)
    return
  end
  L5 = {}
  L5.api = 3
  L5.path = L4
  L5.sharedOnly = 0
  L5.needSambaPath = 0
  L6 = require
  L7 = "cjson"
  L6 = L6(L7)
  L7 = L6.encode
  L8 = L5
  L7 = L7(L8)
  L8 = L1.ExtendWifiCallOldRouterDataCenterAPI
  L9 = L3
  L10 = L7
  L8 = L8(L9, L10)
  L9 = L8.code
  if L9 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L8.code
    L9 = L9(L10)
    L8.msg = L9
    L9 = _UPVALUE0_
    L9 = L9.write_json
    L10 = L8
    L9(L10)
  else
    L9 = _UPVALUE0_
    L9 = L9.write
    L10 = L8.msg
    L9(L10)
  end
end
ExtendWifiGetRootDirInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQExtendWifi"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "username"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "password"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "nonce"
  L4 = L4(L5)
  L5 = L1.oneClickGetRemoteTokenForLua
  L6 = L2
  L7 = L3
  L8 = L4
  L5 = L5(L6, L7, L8)
  L6 = L5.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
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
oneClickGetRemoteToken = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getPrivacy
  L2 = L2()
  if L2 then
    L2 = 1
    if L2 then
      goto lbl_14
    end
  end
  L2 = 0
  ::lbl_14::
  L1.privacy = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
privacy = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "privacy"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  L2 = {}
  L2.code = 0
  L3 = L0.setPrivacy
  if L1 == 1 then
    L4 = true
    if L4 then
      goto lbl_19
    end
  end
  L4 = false
  ::lbl_19::
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
setPrivacy = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "privacy"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  L2 = {}
  L2.code = 0
  L3 = L0.setPrivacy
  if L1 == 1 then
    L4 = true
    if L4 then
      goto lbl_19
    end
  end
  L4 = false
  ::lbl_19::
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
setPrivacy_new = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.XQCountryCode"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQNetUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQLanWanUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQConfigs"
  L4 = L4(L5)
  L5 = L3.getWanMonitorStat
  L5 = L5()
  L6 = L0.getCurrentCountryCode
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.common.XQFunction"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.XQFeatures"
  L8 = L8(L9)
  L8 = L8.FEATURES
  L9 = 0
  L10 = L5.WANLINKSTAT
  if L10 == "UP" then
    L9 = 1
  end
  L10 = {}
  L10.code = 0
  L10.connect = L9
  L11 = L2.getInitInfo
  L11 = L11()
  if L11 then
    L11 = 1
    if L11 then
      goto lbl_43
    end
  end
  L11 = 0
  ::lbl_43::
  L10.inited = L11
  L11 = L2.getPassportBindInfo
  L11 = L11()
  if L11 then
    L11 = 1
    if L11 then
      goto lbl_52
    end
  end
  L11 = 0
  ::lbl_52::
  L10.bound = L11
  L11 = L1.getSN
  L11 = L11()
  L10.id = L11
  L11 = L1.getDeviceId
  L11 = L11()
  L10.routerId = L11
  L11 = L2.getHardware
  L11 = L11()
  L10.hardware = L11
  L11 = L4.XQ_MODEL_PREFIX
  L12 = string
  L12 = L12.lower
  L13 = L10.hardware
  L13 = L13 or L13
  L12 = L12(L13)
  L11 = L11 .. L12
  L10.model = L11
  L11 = L2.getRomVersion
  L11 = L11()
  L10.romversion = L11
  L11 = L2.getModulesList
  L11 = L11()
  L10.modules = L11
  L11 = L2.getLang
  L11 = L11()
  L10.language = L11
  L10.countrycode = L6
  L11 = L2.getRouterName
  L11 = L11()
  L10.routername = L11
  L11 = L2.getMobileAccel
  L11 = L11()
  L10.maccel = L11
  if L6 ~= "CN" then
    L11 = L2.getServer
    L11 = L11()
    L10.server = L11
  end
  L11 = L2.isRedmi
  L11 = L11()
  L10.isRedmi = L11
  L11 = L2.getDisplayName
  L11 = L11()
  L10.displayName = L11
  L11 = L2.isSupportMesh
  L11 = L11()
  L10.isSupportMesh = L11
  L11 = L2.getSecAcc
  L11 = L11()
  L10.secAcc = L11
  L11 = L2.getGdprPrivacy
  L11 = L11()
  L10.showPrivacy = L11
  L11 = L2.getEncryptMode
  L11 = L11()
  L10.newEncryptMode = L11
  L11 = L2.isWifiApSupport
  L11 = L11()
  L10.wifi_ap = L11
  L11 = L7.isSupport160Mhz
  L11 = L11()
  L10.support160M = L11
  L11 = L2.getIMEI
  L11 = L11()
  L10.imei = L11
  L11 = L2.getModuleSoftwareVersion
  L11 = L11()
  L10.moduleVersion = L11
  L11 = L8.system
  L11 = L11.dt_spec
  if L11 then
    L11 = L8.system
    L11 = L11.dt_spec
    if L11 == "1" then
      L11 = L2.getDisplayNameListStr
      L11 = L11()
      L10.displayNameLstStr = L11
    end
  end
  L11 = L8.system
  L11 = L11.international
  if L11 then
    L11 = L8.system
    L11 = L11.international
    if L11 == "1" then
      L10.ipv6 = 0
  end
  else
    L11 = L8.system
    L11 = L11.ipv6_wired_v2
    if L11 then
      L11 = L8.system
      L11 = L11.ipv6_wired_v2
      if L11 == "1" then
        L10.ipv6 = 1
      end
    end
  end
  L11 = L8.system
  L11 = L11.vpn_init
  if L11 then
    L11 = L8.system
    L11 = L11.vpn_init
    if L11 == "1" then
      L11 = 1
      if L11 then
        goto lbl_165
      end
    end
  end
  L11 = 0
  ::lbl_165::
  L10.vpn_init = L11
  L10.features = L8
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L10
  L11(L12)
end
getInitInfo = L4
function L4()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0.facInfo
  L2 = L2()
  L1(L2)
end
getFacInfo = L4
function L4()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0.bdataInfo
  L2 = L2()
  L1(L2)
end
getBdataInfo = L4
function L4()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = L0.forkExec
  L2 = "sleep 1; /sbin/farewell"
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = {}
  L2.code = 0
  L1(L2)
end
farewell = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "init"
  L3, L4, L5, L6, L7, L8, L9, L10 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10)
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "privacy"
  L4, L5, L6, L7, L8, L9, L10 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "callback"
  L4 = L4(L5)
  L1.code = 0
  if L2 and L2 == 1 then
    L5 = require
    L6 = "xiaoqiang.util.XQSysUtil"
    L5 = L5(L6)
    L6 = L5.setPrivacy
    if L3 == 1 then
      L7 = true
      if L7 then
        goto lbl_36
      end
    end
    L7 = false
    ::lbl_36::
    L6(L7)
    L6 = luci
    L6 = L6.dispatcher
    L6 = L6.build_url
    L7 = "web"
    L8 = "init"
    L9 = "guide"
    L6 = L6(L7, L8, L9)
    L1.url = L6
  else
    L5 = luci
    L5 = L5.dispatcher
    L5 = L5.build_url
    L6 = "web"
    L7 = "home"
    L5 = L5(L6, L7)
    L1.url = L5
  end
  L5 = luci
  L5 = L5.http
  L5 = L5.getenv
  L6 = "REMOTE_ADDR"
  L5 = L5(L6)
  L5 = L5 or L5
  L6 = luci
  L6 = L6.sys
  L6 = L6.net
  L6 = L6.ip4mac
  L7 = L5
  L6 = L6(L7)
  L6 = L6 or L6
  L7 = _UPVALUE1_
  L7 = L7.writeLoginRecord
  L8 = L5
  L9 = L6
  L7(L8, L9)
  L7 = L0.getFeature
  L8 = "1"
  L9 = "system"
  L10 = "sp_lib"
  L7 = L7(L8, L9, L10)
  if L7 == "1" then
    L7 = require
    L8 = "xiaoqiang.XQStatPoints"
    L7 = L7(L8)
    L8 = L7.Log
    L9 = "sys.ctrl"
    L10 = "web:1"
    L8(L9, L10)
  end
  L7 = luci
  L7 = L7.dispatcher
  L7 = L7.context
  L7 = L7.urltoken
  L7 = L7.stok
  L1.token = L7
  L7 = L0.isStrNil
  L8 = L4
  L7 = L7(L8)
  if L7 then
    L7 = _UPVALUE0_
    L7 = L7.write_json
    L8 = L1
    L7(L8)
  else
    L7 = _UPVALUE0_
    L7 = L7.write_jsonp
    L8 = L1
    L9 = L4
    L7(L8, L9)
  end
end
actionLogin = L4
function L4()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.readLoginRecord
  L1 = L1()
  L0.login_records = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getLoginRecord = L4
function L4()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.clearLoginRecord
  L1()
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
clearLoginRecord = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQNetUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "sid"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = luci
  L3 = L3.dispatcher
  L3 = L3.context
  L3 = L3.urltoken
  L3 = L3.stok
  L2.token = L3
  L3 = L0.getSN
  L3 = L3()
  L2.id = L3
  L3 = _UPVALUE1_
  L3 = L3.getRouterName
  L3 = L3()
  L2.name = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getToken = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.cbi.datatypes"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.sauth"
  L1 = L1(L2)
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ip"
  L3 = L3(L4)
  if L3 then
    L4 = L0.ipaddr
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      L3 = nil
    end
  end
  L4 = L1.available
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L4.token
    if L5 then
      L5 = L4.token
      L2.token = L5
  end
  else
    L5 = luci
    L5 = L5.sys
    L5 = L5.uniqueid
    L6 = 16
    L5 = L5(L6)
    L6 = L1.write
    L7 = L5
    L8 = {}
    L8.user = "admin"
    L8.token = L5
    L8.ltype = "2"
    L8.ip = L3
    L9 = luci
    L9 = L9.sys
    L9 = L9.uniqueid
    L10 = 16
    L9 = L9(L10)
    L8.secret = L9
    L6(L7, L8)
    L2.token = L5
  end
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L6 = L5.getFeature
  L7 = "1"
  L8 = "system"
  L9 = "sp_lib"
  L6 = L6(L7, L8, L9)
  if L6 == "1" then
    L6 = require
    L7 = "xiaoqiang.XQStatPoints"
    L6 = L6(L7)
    L7 = L6.Log
    L8 = "sys.ctrl"
    L9 = "app:1"
    L7(L8, L9)
  end
  L2.code = 0
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L2
  L6(L7)
end
renewToken = L4
function L4()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.write_json
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.getenv
  L3 = "REMOTE_ADDR"
  L2 = L2(L3)
  L2 = L2 or L2
  L1.ip = L2
  L0(L1)
end
getIp = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "client"
  L1 = L1(L2)
  if L1 == "ios" then
    L2 = L0.check
    L3 = 0
    L4 = L0.KEY_GEL_INIT_IOS
    L5 = 1
    L2(L3, L4, L5)
  elseif L1 == "android" then
    L2 = L0.check
    L3 = 0
    L4 = L0.KEY_GEL_INIT_ANDROID
    L5 = 1
    L2(L3, L4, L5)
  elseif L1 == "other" then
    L2 = L0.check
    L3 = 0
    L4 = L0.KEY_GEL_INIT_OTHER
    L5 = 1
    L2(L3, L4, L5)
  end
  L2 = {}
  L3 = _UPVALUE1_
  L3 = L3.setInited
  L3 = L3()
  if not L3 then
    L2.code = 1501
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = 1501
    L4 = L4(L5)
    L2.msg = L4
  else
    L2.code = 0
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setInited = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getWanLanNetworkStatistics
  L3 = "lan"
  L2 = L2(L3)
  L1.lan = L2
  L2 = L0.getWanLanNetworkStatistics
  L3 = "wan"
  L2 = L2(L3)
  L1.wan = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getLanWanSta = L4
function L4()
  local L0, L1, L2, L3
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.getPassportBindInfo
  L1 = L1()
  L0.code = 0
  if L1 then
    L0.bound = 1
    L0.uuid = L1
  else
    L0.bound = 0
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L0
  L2(L3)
end
getPassportBindInfo = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "uuid"
  L0 = L0(L1)
  L1 = {}
  L2 = _UPVALUE1_
  L2 = L2.setPassportBound
  L3 = true
  L4 = L0
  L2 = L2(L3, L4)
  if not L2 then
    L1.code = 1501
    L3 = _UPVALUE2_
    L3 = L3.getErrorMessage
    L4 = 1501
    L3 = L3(L4)
    L1.msg = L3
  else
    L1.code = 0
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
setPassportBound = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "uuid"
  L0 = L0(L1)
  L1 = {}
  L2 = _UPVALUE1_
  L2 = L2.setPassportBound
  L3 = false
  L4 = L0
  L2(L3, L4)
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
removePassportBindInfo = L4
function L4()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getSysUptime
  L1 = L1()
  L0.upTime = L1
  L1 = _UPVALUE0_
  L1 = L1.getRouterName
  L1 = L1()
  L0.routerName = L1
  L1 = _UPVALUE0_
  L1 = L1.getRomVersion
  L1 = L1()
  L0.romVersion = L1
  L1 = _UPVALUE0_
  L1 = L1.getChannel
  L1 = L1()
  L0.romChannel = L1
  L1 = _UPVALUE0_
  L1 = L1.getHardware
  L1 = L1()
  L0.hardware = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getSysInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = L0.getWanMonitorStat
  L3 = L3()
  L4 = 0
  L5 = L3.WANLINKSTAT
  if L5 == "UP" then
    L4 = 1
  end
  L2.connect = L4
  L5 = L1.getAllWifiInfo
  L5 = L5()
  L2.wifi = L5
  L5 = L0.getLanWanInfo
  L6 = "wan"
  L5 = L5(L6)
  L2.wan = L5
  L5 = L0.getLanWanInfo
  L6 = "lan"
  L5 = L5(L6)
  L2.lan = L5
  L2.code = 0
  L5 = L2.wifi
  L5 = L5[1]
  L6 = L1.getWifiWorkChannel
  L7 = 1
  L6 = L6(L7)
  L5.channel = L6
  L5 = L2.wifi
  L5 = L5[2]
  L6 = L1.getWifiWorkChannel
  L7 = 2
  L6 = L6(L7)
  L5.channel = L6
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
getAllInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L5 = L3
  L4 = L3.get_wlan_count
  L4 = L4(L5)
  L5 = {}
  L6 = L1.getWanMonitorStat
  L6 = L6()
  L7 = L6.WANLINKSTAT
  if L7 == "UP" then
    L5.connect = 1
  end
  L7 = L6.VPNLINKSTAT
  if L7 == "UP" then
    L5.vpn = 1
  end
  L7 = {}
  for L11 = L8, L9, L10 do
    L13 = L7
    L14 = L3.getWifiConnectDeviceList
    L15 = L11
    L14 = L14(L15)
    L14 = #L14
    L12(L13, L14)
  end
  if 0 < L9 then
    L9(L10, L11)
  end
  if L9 > L10 then
    L9.mac = ""
    L9.ip = ""
    for L13 = L10, L11, L12 do
      L14 = table
      L14 = L14.remove
      L15 = L8
      L16 = L2.DEVICE_STATISTICS_LIST_LIMIT
      L14 = L14(L15, L16)
      L15 = L14.onlinets
      L9.onlinets = L15
      L15 = L14.activets
      L9.activets = L15
      L15 = tonumber
      L16 = L14.upload
      L15 = L15(L16)
      L16 = tonumber
      L17 = L9.upload
      L17 = L17 or L17
      L16 = L16(L17)
      L15 = L15 + L16
      L9.upload = L15
      L15 = tonumber
      L16 = L14.upspeed
      L15 = L15(L16)
      L16 = tonumber
      L17 = L9.upspeed
      L17 = L17 or L17
      L16 = L16(L17)
      L15 = L15 + L16
      L9.upspeed = L15
      L15 = tonumber
      L16 = L14.download
      L15 = L15(L16)
      L16 = tonumber
      L17 = L9.download
      L17 = L17 or L17
      L16 = L16(L17)
      L15 = L15 + L16
      L9.download = L15
      L15 = tonumber
      L16 = L14.downspeed
      L15 = L15(L16)
      L16 = tonumber
      L17 = L9.downspeed
      L17 = L17 or L17
      L16 = L16(L17)
      L15 = L15 + L16
      L9.downspeed = L15
      L15 = L14.online
      L9.online = L15
      L15 = L14.idle
      L9.idle = L15
      L9.devname = "Others"
      L15 = L14.initail
      L9.initail = L15
      L15 = L14.maxuploadspeed
      L9.maxuploadspeed = L15
      L15 = L14.maxdownloadspeed
      L9.maxdownloadspeed = L15
    end
    L10(L11, L12)
  end
  L5.lanLink = L9
  L5.count = L9
  L5.upTime = L9
  L5.wifiCount = L7
  L5.wanStatistics = L9
  L5.devStatistics = L8
  L5.code = 0
  L9(L10)
end
getStatusInfo = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getConnectDeviceCount
  L2 = L2()
  L1.count = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getConDevCount = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQSecureUtil"
  L6 = L6(L7)
  L7 = 0
  L8 = luci
  L8 = L8.dispatcher
  L8 = L8.getremotemac
  L8 = L8()
  L9 = L6.checkNonce
  L10 = A0
  L11 = L8
  L9 = L9(L10, L11)
  if L9 then
    L10 = L6.checkUser
    L11 = "admin"
    L12 = A0
    L13 = A1
    L10 = L10(L11, L12, L13)
    if L10 then
      L11 = L4.getEncryptMode
      L11 = L11()
      if L11 == 1 then
        L12 = L6.saveCiphertextLegacyPwd
        L13 = "admin"
        L14 = A2
        L12 = L12(L13, L14)
        if L12 then
          L12 = L6.saveCiphertextPwd
          L13 = "admin"
          L14 = A3
          L12 = L12(L13, L14)
          if L12 then
            L12 = L5.forkExec
            L13 = "/sbin/whc_to_re_common_api.sh webpasswd_update"
            L12(L13)
            L7 = 0
        end
        else
          L7 = 1553
        end
      else
        L12 = L6.saveCiphertextPwd
        L13 = "admin"
        L14 = A2
        L12 = L12(L13, L14)
        if L12 then
          L12 = L5.forkExec
          L13 = "/sbin/whc_to_re_common_api.sh webpasswd_update"
          L12(L13)
          L7 = 0
        else
          L7 = 1553
        end
      end
    else
      L7 = 1552
    end
  else
    L7 = 1582
  end
  return L7
end
_savePassword = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.XQLog"
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
  L4 = "cjson"
  L3 = L3(L4)
  L4 = 0
  L5 = {}
  L7 = L2
  L6 = L2.get
  L8 = "wireless"
  L9 = "miot_2G"
  L10 = "bindstatus"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L8 = L2
  L7 = L2.get
  L9 = "wireless"
  L10 = "miot_2G"
  L11 = "userswitch"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L9 = L2
  L8 = L2.get
  L10 = "misc"
  L11 = "wireless"
  L12 = "if_2G"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = require
  L10 = "xiaoqiang.common.XQFunction"
  L9 = L9(L10)
  L10 = L9.isMeshCap
  L10 = L10()
  if L10 then
    L11 = L2
    L10 = L2.get
    L12 = "messaging"
    L13 = "deviceInfo"
    L14 = "BINDING"
    L10 = L10(L11, L12, L13, L14)
    L10 = L10 or L10
    L11 = L1.trim
    L12 = L1.exec
    L13 = "matool --method api_call --params '/device/minet_get_bindinfo'"
    L12, L13, L14, L15, L16, L17, L18 = L12(L13)
    L11 = L11(L12, L13, L14, L15, L16, L17, L18)
    L12 = L3.decode
    L13 = L11
    L12 = L12(L13)
    L13 = L0.log
    L14 = 1
    L15 = "bind_flag:"
    L16 = L10
    L15 = L15 .. L16
    L13(L14, L15)
    L13 = L0.log
    L14 = 1
    L15 = "bind_result:"
    L16 = L11
    L15 = L15 .. L16
    L13(L14, L15)
    L13 = tostring
    L14 = L10
    L13 = L13(L14)
    if "1" == L13 then
      L13 = L12.code
      if 0 == L13 then
        L13 = L12.data
        if L13 then
          L13 = L12.data
          L13 = L13.bind
          if 1 == L13 then
            L13 = L1.exec
            L14 = "ubus call xq_info_sync_mqtt bind"
            L13(L14)
            L13 = L0.log
            L14 = 6
            L15 = "luci call bind ok... "
            L13(L14, L15)
            L14 = L2
            L13 = L2.set
            L15 = "messaging"
            L16 = "deviceInfo"
            L17 = "BINDING"
            L18 = "0"
            L13(L14, L15, L16, L17, L18)
            L14 = L2
            L13 = L2.commit
            L15 = "messaging"
            L13(L14, L15)
        end
      end
    end
    else
      L4 = 1661
    end
  else
    L11 = L2
    L10 = L2.set
    L12 = "bind"
    L13 = "info"
    L14 = "status"
    L15 = "1"
    L10(L11, L12, L13, L14, L15)
    L11 = L2
    L10 = L2.set
    L12 = "bind"
    L13 = "info"
    L14 = "record"
    L15 = "1"
    L10(L11, L12, L13, L14, L15)
    L11 = L2
    L10 = L2.commit
    L12 = "bind"
    L10(L11, L12)
    L10 = L0.log
    L11 = 6
    L12 = "luci call bind ok... "
    L10(L11, L12)
  end
  if L6 == "0" then
    L10 = L0.log
    L11 = 6
    L12 = "change bindstatus success"
    L10(L11, L12)
    L11 = L2
    L10 = L2.set
    L12 = "wireless"
    L13 = "miot_2G"
    L14 = "bindstatus"
    L15 = "1"
    L10(L11, L12, L13, L14, L15)
    L11 = L2
    L10 = L2.commit
    L12 = "wireless"
    L10(L11, L12)
    if L7 == "1" then
      if "wifi0" == L8 then
        L10 = L1.exec
        L11 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 enable"
        L10(L11)
      elseif "wifi1" == L8 then
        L10 = L1.exec
        L11 = "hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 enable"
        L10(L11)
      else
        L10 = L1.exec
        L11 = "ifconfig wl13 up"
        L10(L11)
      end
      L10 = L1.exec
      L11 = "/usr/sbin/sysapi miot"
      L10(L11)
      L10 = L1.exec
      L11 = "ubus call network reload"
      L10(L11)
    end
  end
  L11 = L2
  L10 = L2.get
  L12 = "misc"
  L13 = "features"
  L14 = "miio_ot"
  L10 = L10(L11, L12, L13, L14)
  L10 = L10 or L10
  L11 = tonumber
  L12 = L10
  L11 = L11(L12)
  if L11 == 1 then
    L11 = L1.exec
    L12 = "/usr/bin/miio_bind.sh"
    L11(L12)
    L12 = L2
    L11 = L2.get
    L13 = "messaging"
    L14 = "deviceInfo"
    L15 = "DEVICE_ID"
    L11 = L11(L12, L13, L14, L15)
    L13 = L2
    L12 = L2.get
    L14 = "miio_ot"
    L15 = "ot"
    L16 = "partner_id"
    L12 = L12(L13, L14, L15, L16)
    if L11 == nil or L12 == nil or L11 ~= L12 then
      L13 = L0.log
      L14 = 6
      L15 = "miio_bind fail set code to 1661"
      L13(L14, L15)
      L4 = 1661
    end
  end
  L5.code = L4
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L5
  L11(L12)
end
routerBindOk = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = 0
  L4 = {}
  L6 = L2
  L5 = L2.get
  L7 = "bind"
  L8 = "info"
  L9 = "status"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L6 = tostring
  L7 = L5
  L6 = L6(L7)
  if "0" == L6 then
    L7 = L2
    L6 = L2.set
    L8 = "bind"
    L9 = "info"
    L10 = "status"
    L11 = "1"
    L6(L7, L8, L9, L10, L11)
    L7 = L2
    L6 = L2.set
    L8 = "bind"
    L9 = "info"
    L10 = "record"
    L11 = "1"
    L6(L7, L8, L9, L10, L11)
    L7 = L2
    L6 = L2.commit
    L8 = "bind"
    L6(L7, L8)
    L6 = L0.log
    L7 = 6
    L8 = "new luci call bind ok... "
    L6(L7, L8)
  end
  L4.code = L3
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L4
  L6(L7)
end
newrouterBindOk = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L2 = nil
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "nonce"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "oldPwd"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "newPwd"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "newPwd256"
  L6 = L6(L7)
  L7 = L0.isStrNil
  L8 = L4
  L7 = L7(L8)
  if not L7 then
    L7 = L0.isStrNil
    L8 = L5
    L7 = L7(L8)
    if not L7 then
      goto lbl_34
    end
  end
  L2 = 1502
  goto lbl_45
  ::lbl_34::
  if L3 then
    L7 = _savePassword
    L8 = L3
    L9 = L4
    L10 = L5
    L11 = L6
    L7 = L7(L8, L9, L10, L11)
    L2 = L7
  else
    L2 = 1523
  end
  ::lbl_45::
  if L2 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L2
    L7 = L7(L8)
    L1.msg = L7
  end
  L1.code = L2
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L1
  L7(L8)
end
setPassword = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQNetUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L2.status = 0
  L2.percent = 0
  L3 = 0
  L4 = L0.checkUpgrade
  L4 = L4()
  if L4 == false then
    L3 = 1504
  else
    L3 = 0
    L1 = L4
  end
  L1.status = L2
  if L3 ~= 0 then
    L5 = _UPVALUE0_
    L5 = L5.getErrorMessage
    L6 = L3
    L5 = L5(L6)
    L1.msg = L5
  end
  L1.code = L3
  L5 = _UPVALUE1_
  L5 = L5.write_json
  L6 = L1
  L5(L6)
end
checkRomUpdate = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "url"
  L3 = L3(L4)
  L4 = tostring
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "filesize"
  L5 = L5(L6)
  L5 = L5 or L5
  L4 = L4(L5)
  L5 = tostring
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "hash"
  L6 = L6(L7)
  L6 = L6 or L6
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "needpermission"
  L7, L8, L9, L10, L11, L12, L13, L14, L15 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
  if L6 and L6 == 1 then
    L7 = L1.setFlashPermission
    L8 = false
    L7(L8)
  else
    L7 = L1.setFlashPermission
    L8 = true
    L7(L8)
  end
  L7 = {}
  L8 = 0
  L9 = L1.checkBeenUpgraded
  L9 = L9()
  if L9 then
    L8 = 1577
  else
    L9 = L1.isUpgrading
    L9 = L9()
    if L9 then
      L8 = 1568
    else
      L9 = L2.cmdSafeCheck
      L10 = L3
      L9 = L9(L10)
      if L9 then
        L9 = L2.cmdSafeCheck
        L10 = L4
        L9 = L9(L10)
        if L9 then
          L9 = L2.cmdSafeCheck
          L10 = L5
          L9 = L9(L10)
          if L9 then
            goto lbl_79
          end
        end
      end
      L8 = 1523
    end
  end
  ::lbl_79::
  L7.code = L8
  if L8 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L8
    L9 = L9(L10)
    L7.msg = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
  if L8 == 0 then
    L9 = L0.sysLock
    L9()
    if L3 and L4 ~= "" and L5 ~= "" then
      L9 = L0.forkExec
      L10 = string
      L10 = L10.format
      L11 = "/usr/sbin/crontab_rom.sh '%s' '%s' '%s'"
      L12 = L2.parseCmdline
      L13 = L3
      L12 = L12(L13)
      L13 = L2.parseCmdline
      L14 = L5
      L13 = L13(L14)
      L14 = L2.parseCmdline
      L15 = L4
      L14, L15 = L14(L15)
      L10, L11, L12, L13, L14, L15 = L10(L11, L12, L13, L14, L15)
      L9(L10, L11, L12, L13, L14, L15)
    else
      L9 = L0.forkExec
      L10 = "/usr/sbin/crontab_rom.sh"
      L9(L10)
    end
  end
end
upgradeRom = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = 0
  L2 = {}
  L3 = L0.cancelUpgrade
  L3 = L3()
  if not L3 then
    L1 = 1579
    L4 = _UPVALUE0_
    L4 = L4.getErrorMessage
    L5 = L1
    L4 = L4(L5)
    L2.msg = L4
  end
  L2.code = L1
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
cancelUpgrade = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "luci.fs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQPreference"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "custom"
  L7 = L7(L8)
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "recovery"
  L8 = L8(L9)
  L8 = L8 or L8
  L7 = L7(L8)
  L8 = {}
  L9 = 0
  L10 = L1.ROM_CACHE_FILEPATH
  if L6 == 1 then
    L11 = L4.getUploadRomFilePath
    L11 = L11()
    L10 = L11
  end
  L11 = L4.getFlashStatus
  L11 = L11()
  if L11 == 1 then
    L9 = 1560
  elseif L11 == 2 then
    L9 = 1577
  else
    L12 = L0.access
    L13 = L10
    L12 = L12(L13)
    if not L12 then
      L9 = 1507
    end
  end
  L12 = L2.ledFlashAlert
  L13 = false
  L12(L13)
  if L9 ~= 0 then
    L12 = _UPVALUE1_
    L12 = L12.getErrorMessage
    L13 = L9
    L12 = L12(L13)
    L8.msg = L12
  end
  L8.code = L9
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L8
  L12(L13)
  if L9 == 0 then
    L12 = _UPVALUE0_
    L12 = L12.close
    L12()
    L12 = L2.sysLock
    L12()
    L12 = L2.forkExec
    L13 = "flash.sh "
    L14 = L10
    if L7 == 1 then
      L15 = " 1"
      if L15 then
        goto lbl_92
      end
    end
    L15 = ""
    ::lbl_92::
    L13 = L13 .. L14 .. L15
    L12(L13)
  else
    L12 = L0.unlink
    L13 = L10
    L12(L13)
  end
end
flashRom = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getFlashStatus
  L2 = L2()
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
flashStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.checkUpgradeStatus
  L2 = L2()
  L1.status = L2
  L2 = L1.status
  if L2 == 3 then
    L2 = require
    L3 = "luci.fs"
    L2 = L2(L3)
    L3 = require
    L4 = "xiaoqiang.common.XQConfigs"
    L3 = L3(L4)
    L4 = require
    L5 = "xiaoqiang.XQPreference"
    L4 = L4(L5)
    L5 = require
    L6 = "xiaoqiang.util.XQDownloadUtil"
    L5 = L5(L6)
    L6 = L4.get
    L7 = L3.PREF_ROM_DOWNLOAD_ID
    L8 = nil
    L6 = L6(L7, L8)
    L7 = L5.downloadPercent
    L8 = L6
    L7 = L7(L8)
    L1.percent = L7
  else
    L2 = L1.status
    if L2 == 5 then
      L2 = L0.getFlashProgress
      L2 = L2()
      L1.percent = L2
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
upgradeStatus = L4
function L4()
  local L0, L1, L2
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getRouterName
  L1 = L1()
  L0.routerName = L1
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
getRouterName = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.xqformvalue
  L2 = "routerName"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = L0.isStrNil
  L5 = L1
  L4 = L4(L5)
  if L4 then
    L3 = 1502
  else
    L4 = _UPVALUE1_
    L4 = L4.setRouterName
    L5 = L1
    L4 = L4(L5)
    if L4 == false then
      L3 = 1503
    else
      L2.routerName = L4
    end
  end
  if L3 ~= 0 then
    L4 = _UPVALUE2_
    L4 = L4.getErrorMessage
    L5 = L3
    L4 = L4(L5)
    L2.msg = L4
  end
  L2.code = L3
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setRouterName = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = 0
  L6 = {}
  L7 = false
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "nonce"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "newPwd"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "oldPwd"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "newPwd256"
  L11 = L11(L12)
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "wifiPwd"
  L12 = L12(L13)
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "wifi24Ssid"
  L13 = L13(L14)
  L14 = _UPVALUE0_
  L14 = L14.formvalue
  L15 = "wifi50Ssid"
  L14 = L14(L15)
  L15 = _UPVALUE0_
  L15 = L15.formvalue
  L16 = "wanType"
  L15 = L15(L16)
  L16 = _UPVALUE0_
  L16 = L16.formvalue
  L17 = "pppoeName"
  L16 = L16(L17)
  L17 = _UPVALUE0_
  L17 = L17.formvalue
  L18 = "pppoePwd"
  L17 = L17(L18)
  L18 = L1.nvramSet
  L19 = "Router_unconfigured"
  L20 = "0"
  L18(L19, L20)
  L18 = L1.nvramCommit
  L18()
  L18 = L3.checkSSID
  L19 = L13
  L20 = 28
  L18 = L18(L19, L20)
  L19 = L1.isStrNil
  L20 = L13
  L19 = L19(L20)
  if not L19 and L18 == 0 then
    L19 = _UPVALUE1_
    L19 = L19.setRouterName
    L20 = L13
    L19(L20)
  end
  L19 = L1.isStrNil
  L20 = L9
  L19 = L19(L20)
  if not L19 then
    L19 = L1.isStrNil
    L20 = L10
    L19 = L19(L20)
    if not L19 then
      if L8 then
        L19 = _savePassword
        L20 = L8
        L21 = L10
        L22 = L9
        L23 = L11
        L19 = L19(L20, L21, L22, L23)
        L5 = L19
      else
        L5 = 1523
      end
      if L5 ~= 0 then
        L19 = table
        L19 = L19.insert
        L20 = L6
        L21 = _UPVALUE2_
        L21 = L21.getErrorMessage
        L22 = L5
        L21, L22, L23, L24, L25, L26, L27 = L21(L22)
        L19(L20, L21, L22, L23, L24, L25, L26, L27)
      end
    end
  end
  L19 = L1.isStrNil
  L20 = L15
  L19 = L19(L20)
  if not L19 then
    L19 = nil
    if L15 == "pppoe" then
      L20 = L1.isStrNil
      L21 = L16
      L20 = L20(L21)
      if not L20 then
        L20 = L1.isStrNil
        L21 = L17
        L20 = L20(L21)
        if not L20 then
          L20 = L2.setWanPPPoE
          L21 = L16
          L22 = L17
          L20 = L20(L21, L22)
          L19 = L20
      end
    end
    elseif L15 == "dhcp" then
      L20 = L2.setWanStaticOrDHCP
      L21 = L15
      L20 = L20(L21)
      L19 = L20
    end
    if not L19 then
      L5 = 1518
      L20 = table
      L20 = L20.insert
      L21 = L6
      L22 = _UPVALUE2_
      L22 = L22.getErrorMessage
      L23 = L5
      L22, L23, L24, L25, L26, L27 = L22(L23)
      L20(L21, L22, L23, L24, L25, L26, L27)
    else
      L7 = true
    end
  end
  L19 = L1.isStrNil
  L20 = L12
  L19 = L19(L20)
  if not L19 and L18 == 0 then
    L19 = L3.setWifiBasicInfo
    L20 = 1
    L21 = L13
    L22 = L12
    L23 = "psk2"
    L24, L25 = nil, nil
    L26 = 0
    L19 = L19(L20, L21, L22, L23, L24, L25, L26)
    L20 = L3.setWifiBasicInfo
    L21 = 2
    L22 = L14
    L23 = L12
    L24 = "psk2"
    L25, L26 = nil, nil
    L27 = 0
    L20 = L20(L21, L22, L23, L24, L25, L26, L27)
    if L19 or L20 then
      L7 = true
    end
    if not L19 or not L20 then
      L21 = L3.checkWifiPasswd
      L22 = L12
      L23 = "psk2"
      L21 = L21(L22, L23)
      L5 = L21
      L21 = table
      L21 = L21.insert
      L22 = L6
      L23 = _UPVALUE2_
      L23 = L23.getErrorMessage
      L24 = L5
      L23, L24, L25, L26, L27 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27)
    end
  end
  if L18 ~= 0 then
    L5 = L18
  end
  if L5 ~= 0 then
    L19 = _UPVALUE2_
    L19 = L19.getErrorMessage
    L20 = 1519
    L19 = L19(L20)
    L4.msg = L19
    L4.errorDetails = L6
  end
  L19 = _UPVALUE1_
  L19 = L19.setSPwd
  L19()
  L19 = _UPVALUE1_
  L19 = L19.setInited
  L19()
  L4.code = L5
  L19 = _UPVALUE0_
  L19 = L19.write_json
  L20 = L4
  L19(L20)
  if L7 then
    L19 = _UPVALUE0_
    L19 = L19.close
    L19()
    L19 = L1.forkRestartWifi
    L19()
  end
end
setRouter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "all"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  if L2 == 1 then
    L2 = true
    if L2 then
      goto lbl_19
    end
  end
  L2 = false
  ::lbl_19::
  L3 = {}
  L3.code = 0
  L4 = luci
  L4 = L4.dispatcher
  L4 = L4.getremotemac
  L4 = L4()
  L3.mac = L4
  L4 = L1.getDeviceList
  L5 = not L2
  L6 = true
  L4 = L4(L5, L6)
  L3.list = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
getDeviceList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQZigbeeUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = luci
  L4 = L4.dispatcher
  L4 = L4.getremotemac
  L4 = L4()
  L3.mac = L4
  L4 = {}
  L5 = L2.append_yeelink_list
  L6 = L4
  L5(L6)
  L3.list = L4
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
getDeviceListZigbee = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getWanMonitorStat
  L2 = L2()
  L3 = 0
  L4 = L2.WANLINKSTAT
  if L4 == "UP" then
    L3 = 1
  end
  L1.code = 0
  L1.connect = L3
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
isInternetConnect = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L3 = {}
  L4 = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mac"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "name"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "owner"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "device"
  L8 = L8(L9)
  L9 = L0.isStrNil
  L10 = L5
  L9 = L9(L10)
  if not L9 then
    L9 = L0.isStrNil
    L10 = L6
    L9 = L9(L10)
    if not L9 then
      goto lbl_40
    end
  end
  L4 = 1502
  goto lbl_46
  ::lbl_40::
  L9 = L1.saveDeviceName
  L10 = L5
  L11 = L6
  L12 = L7
  L13 = L8
  L9(L10, L11, L12, L13)
  ::lbl_46::
  if L4 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L4
    L9 = L9(L10)
    L3.msg = L9
  end
  L3.code = L4
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L3
  L9(L10)
end
setDeviceNickName = L4
function L4(A0)
  local L1, L2, L3, L4
  if not A0 then
    return
  end
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = L1.mkdir
  L3 = A0
  L4 = 777
  return L2(L3, L4)
end
_prepare = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6
  if not A0 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.sys"
  L2 = L2(L3)
  L3 = L2.process
  L3 = L3.info
  L4 = "uid"
  L3 = L3(L4)
  L4 = L1.stat
  L5 = A0
  L6 = "uid"
  L4 = L4(L5, L6)
  L3 = L3 == L4
  return L3
end
_sane = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.fs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "present_slice"
  L6 = L6(L7)
  L6 = L6 or L6
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "total_slice"
  L7 = L7(L8)
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = 0
  L8 = true
  L9 = L0.getUploadRomFilePath
  L9 = L9()
  L10 = _UPVALUE0_
  L10 = L10.getenv
  L11 = "UPLOADFILE"
  L10 = L10(L11)
  if L10 then
    L11 = true
    if L11 then
      goto lbl_48
    end
  end
  L11 = false
  ::lbl_48::
  L12 = L4.exec
  L13 = "echo 3 > /proc/sys/vm/drop_caches "
  L12(L13)
  L12 = L2.access
  L13 = L9
  L12 = L12(L13)
  if L12 then
    L12 = L2.unlink
    L13 = L9
    L12(L13)
  end
  L12 = L0.getUploadRomCPEHeaderFilePath
  L12 = L12()
  L13 = L0.getUploadRomCPEModemFilePath
  L13 = L13()
  L14 = L0.getUploadRomCPESignFilePath
  L14 = L14()
  if L11 and L5 and L6 and L5 <= L6 then
    L15 = L2.access
    L16 = L10
    L15 = L15(L16)
    if L15 then
      L15 = L0.cutImage
      L16 = L10
      L15 = L15(L16)
      if not L15 then
        L7 = 1554
        L15 = L3.log
        L16 = 6
        L17 = "-----cutImage failed----"
        L15(L16, L17)
        L15 = L2.unlink
        L16 = L10
        L15(L16)
      else
        L15 = L0.saveSliceImage
        L16 = L5
        L17 = L6
        L18 = L10
        L15 = L15(L16, L17, L18)
        if not L15 then
          L7 = 1554
          L15 = L3.log
          L16 = 6
          L17 = "saveSliceImage failed !"
          L15(L16, L17)
        end
      end
    else
      L7 = 1554
      L15 = L3.log
      L16 = 6
      L17 = "nginx upload file fail, file not exits!"
      L18 = tostring
      L19 = L10
      L18 = L18(L19)
      L17 = L17 .. L18
      L15(L16, L17)
    end
  else
    L7 = 1554
    L15 = L3.log
    L16 = 6
    L17 = "-----uploadRomSplit failed ----"
    L15(L16, L17)
  end
  L15 = {}
  if L5 == L6 then
    if L7 == 0 and L9 then
      L16 = L0.verifyImage
      L17 = L9
      L16 = L16(L17)
      if not L16 then
        L7 = 1554
        L16 = L3.log
        L17 = 6
        L18 = "----uploadFile sucess but failed to verifyimage----"
        L16(L17, L18)
      end
    end
    if L7 == 0 then
      L16 = L0.checkRomVersion
      L17 = L9
      L16 = L16(L17)
      L15.downgrade = L16
      L16 = L15.downgrade
      if L16 then
        L16 = L2.unlink
        L17 = L9
        L16(L17)
        L16 = L2.unlink
        L17 = L12
        L16(L17)
        L16 = L2.unlink
        L17 = L14
        L16(L17)
      end
    end
  end
  if L7 ~= 0 then
    L16 = _UPVALUE1_
    L16 = L16.getErrorMessage
    L17 = L7
    L16 = L16(L17)
    L15.msg = L16
    L16 = L2.unlink
    L17 = L9
    L16(L17)
    L16 = L2.unlink
    L17 = L12
    L16(L17)
    L16 = L2.unlink
    L17 = L14
    L16(L17)
  end
  L15.code = L7
  L16 = _UPVALUE0_
  L16 = L16.write_json
  L17 = L15
  L16(L17)
end
uploadRomSplit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.sys"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.fs"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.common.XQFunction"
  L6 = L6(L7)
  L7 = 0
  L8 = true
  L9 = L1.getUploadDir
  L9 = L9()
  L10 = L1.getUploadRomFilePath
  L10 = L10()
  L11 = L9
  L12 = L2.uniqueid
  L13 = 16
  L12 = L12(L13)
  L11 = L11 .. L12
  L12 = tonumber
  L13 = _UPVALUE0_
  L13 = L13.getenv
  L14 = "CONTENT_LENGTH"
  L13, L14, L15, L16, L17, L18, L19, L20, L21 = L13(L14)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19, L20, L21)
  L13 = _UPVALUE0_
  L13 = L13.getenv
  L14 = "UPLOADFILE"
  L13 = L13(L14)
  if L13 then
    L14 = true
    if L14 then
      goto lbl_49
    end
  end
  L14 = false
  ::lbl_49::
  L15 = L5.exec
  L16 = "/usr/sbin/kill_plugin_process.sh > /dev/null"
  L15(L16)
  if L14 then
    if L10 then
      L15 = L3.access
      L16 = L13
      L15 = L15(L16)
      if L15 then
        L15 = L3.rename
        L16 = L13
        L17 = L10
        L15(L16, L17)
        L15 = L4.log
        L16 = 6
        L17 = "nginx upload file ok, file rename "
        L18 = tostring
        L19 = L13
        L18 = L18(L19)
        L19 = "=>"
        L20 = tostring
        L21 = L10
        L20 = L20(L21)
        L17 = L17 .. L18 .. L19 .. L20
        L15(L16, L17)
        L15 = L1.cutImage
        L16 = L10
        L15 = L15(L16)
        if not L15 then
          L7 = 1554
          L15 = L4.log
          L16 = 6
          L17 = "-----cutImage failed----"
          L15(L16, L17)
          L15 = L3.unlink
          L16 = L10
          L15(L16)
        end
    end
    else
      L15 = L4.log
      L16 = 6
      L17 = "nginx upload file fail, file not exits!"
      L18 = tostring
      L19 = L13
      L18 = L18(L19)
      L19 = "=>"
      L20 = tostring
      L21 = L10
      L20 = L20(L21)
      L17 = L17 .. L18 .. L19 .. L20
      L15(L16, L17)
    end
  else
    L15 = nil
    L16 = L1.checkSpace
    L17 = L9
    L18 = L12
    L16 = L16(L17, L18)
    L8 = L16
    L16 = _UPVALUE0_
    L16 = L16.setfilehandler
    function L17(A0, A1, A2)
      local L3, L4, L5
      L3 = _UPVALUE0_
      if L3 then
        L3 = _UPVALUE1_
        if not L3 and A0 then
          L3 = A0.name
          if L3 == "image" then
            L3 = io
            L3 = L3.open
            L4 = _UPVALUE2_
            L5 = "w"
            L3 = L3(L4, L5)
            _UPVALUE1_ = L3
          end
        end
        if A1 then
          L3 = _UPVALUE1_
          L4 = L3
          L3 = L3.write
          L5 = A1
          L3(L4, L5)
        end
        if A2 then
          L3 = _UPVALUE1_
          L4 = L3
          L3 = L3.close
          L3(L4)
          L3 = _UPVALUE3_
          L3 = L3.access
          L4 = _UPVALUE4_
          L3 = L3(L4)
          if L3 then
            L3 = _UPVALUE3_
            L3 = L3.unlink
            L4 = _UPVALUE4_
            L3(L4)
          end
          L3 = _UPVALUE3_
          L3 = L3.rename
          L4 = _UPVALUE2_
          L5 = _UPVALUE4_
          L3(L4, L5)
        end
      else
        L3 = 1578
        _UPVALUE5_ = L3
      end
    end
    L16(L17)
    L16 = _UPVALUE0_
    L16 = L16.formvalue
    L17 = "image"
    L16 = L16(L17)
    if L16 and L15 then
      L7 = 0
    end
  end
  L15 = {}
  if L7 == 0 and L10 then
    L16 = L1.verifyImage
    L17 = L10
    L16 = L16(L17)
    if not L16 then
      L7 = 1554
      L16 = L4.log
      L17 = 6
      L18 = "----uploadFile sucess but failed to verifyimage----"
      L16(L17, L18)
    end
  end
  if L7 ~= 0 then
    L16 = _UPVALUE1_
    L16 = L16.getErrorMessage
    L17 = L7
    L16 = L16(L17)
    L15.msg = L16
    L16 = L3.unlink
    L17 = L10
    L16(L17)
  else
    L16 = L1.checkRomVersion
    L17 = L10
    L16 = L16(L17)
    L15.downgrade = L16
    L16 = L15.downgrade
    if L16 then
      L16 = L3.unlink
      L17 = L10
      L16(L17)
    end
  end
  L15.code = L7
  L16 = _UPVALUE0_
  L16 = L16.write_json
  L17 = L15
  L16(L17)
end
uploadRom = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQConfigs"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQCryptoUtil"
  L4 = L4(L5)
  L5 = L4.binaryBase64Enc
  L6 = "{\"api\":602,\"pluginPath\":\"/tmp/unified_plug.mpk\"}"
  L5 = L5(L6)
  L6 = L3.THRIFT_TUNNEL_TO_DATACENTER
  L6 = L6 % L5
  L7 = L1.exec
  L8 = L6
  L7 = L7(L8)
  L8 = L0.decode
  L9 = L7
  L8 = L8(L9)
  L9 = L8.code
  return L9
end
pluginLocalInstall = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.fs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.common.XQConfigs"
  L6 = L6(L7)
  L7 = require
  L8 = "json"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQCryptoUtil"
  L8 = L8(L9)
  L9 = 0
  L10 = true
  L11 = L0.getUploadDir
  L11 = L11()
  L12 = L0.getUploadPlugFilePath
  L12 = L12()
  L13 = L11
  L14 = L1.uniqueid
  L15 = 16
  L14 = L14(L15)
  L13 = L13 .. L14
  L14 = tonumber
  L15 = _UPVALUE0_
  L15 = L15.getenv
  L16 = "CONTENT_LENGTH"
  L15, L16, L17, L18, L19, L20, L21, L22, L23 = L15(L16)
  L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23)
  L15 = _UPVALUE0_
  L15 = L15.getenv
  L16 = "UPLOADFILE"
  L15 = L15(L16)
  if L15 then
    L16 = true
    if L16 then
      goto lbl_55
    end
  end
  L16 = false
  ::lbl_55::
  if L16 then
    if L12 then
      L17 = L2.access
      L18 = L15
      L17 = L17(L18)
      if L17 then
        L17 = L2.rename
        L18 = L15
        L19 = L12
        L17(L18, L19)
        L17 = L3.log
        L18 = 6
        L19 = "nginx upload file ok, file rename "
        L20 = tostring
        L21 = L15
        L20 = L20(L21)
        L21 = "=>"
        L22 = tostring
        L23 = L12
        L22 = L22(L23)
        L19 = L19 .. L20 .. L21 .. L22
        L17(L18, L19)
        L17 = L0.cutImage
        L18 = L12
        L17 = L17(L18)
        if not L17 then
          L9 = 1554
          L17 = L2.unlink
          L18 = L12
          L17(L18)
        end
    end
    else
      L17 = L3.log
      L18 = 6
      L19 = "nginx upload file fail, file not exits!"
      L20 = tostring
      L21 = L15
      L20 = L20(L21)
      L21 = "=>"
      L22 = tostring
      L23 = L12
      L22 = L22(L23)
      L19 = L19 .. L20 .. L21 .. L22
      L17(L18, L19)
    end
  else
    L17 = nil
    L18 = L0.checkSpace
    L19 = L11
    L20 = L14
    L18 = L18(L19, L20)
    L10 = L18
    L18 = _UPVALUE0_
    L18 = L18.setfilehandler
    function L19(A0, A1, A2)
      local L3, L4, L5
      L3 = _UPVALUE0_
      if L3 then
        L3 = _UPVALUE1_
        if not L3 and A0 then
          L3 = A0.name
          if L3 == "image" then
            L3 = io
            L3 = L3.open
            L4 = _UPVALUE2_
            L5 = "w"
            L3 = L3(L4, L5)
            _UPVALUE1_ = L3
          end
        end
        if A1 then
          L3 = _UPVALUE1_
          L4 = L3
          L3 = L3.write
          L5 = A1
          L3(L4, L5)
        end
        if A2 then
          L3 = _UPVALUE1_
          L4 = L3
          L3 = L3.close
          L3(L4)
          L3 = _UPVALUE3_
          L3 = L3.access
          L4 = _UPVALUE4_
          L3 = L3(L4)
          if L3 then
            L3 = _UPVALUE3_
            L3 = L3.unlink
            L4 = _UPVALUE4_
            L3(L4)
          end
          L3 = _UPVALUE3_
          L3 = L3.rename
          L4 = _UPVALUE2_
          L5 = _UPVALUE4_
          L3(L4, L5)
        end
      else
        L3 = 1578
        _UPVALUE5_ = L3
      end
    end
    L18(L19)
    L18 = _UPVALUE0_
    L18 = L18.formvalue
    L19 = "image"
    L18 = L18(L19)
    if L18 and L17 then
      L9 = 0
    end
  end
  L17 = {}
  if L9 == 0 and L12 then
    L18 = L0.extractPlug
    L19 = L12
    L18 = L18(L19)
    if not L18 then
      L9 = 1554
    end
  end
  if 0 == L9 then
    L18 = pluginLocalInstall
    L18 = L18()
    L9 = L18
  end
  if L9 ~= 0 then
    L18 = _UPVALUE1_
    L18 = L18.getErrorMessage
    L19 = L9
    L18 = L18(L19)
    L17.msg = L18
    L18 = L2.unlink
    L19 = L12
    L18(L19)
  end
  L17.code = L9
  L18 = _UPVALUE0_
  L18 = L18.write_json
  L19 = L17
  L18(L19)
end
uploadPlug = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = L0.exec
  L4 = "pluginmanager -j '{\"api\":601}'"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  if L3 then
    L5 = L0.trim
    L6 = L3
    L5 = L5(L6)
    L3 = L5
    L5 = L2.isStrNil
    L6 = L3
    L5 = L5(L6)
    if not L5 then
      L5 = L1.decode
      L6 = L3
      L5 = L5(L6)
      L3 = L5
      L5 = L3.code
      L4.code = L5
      L5 = L3.msg
      L4.msg = L5
      L5 = {}
      L4.data = L5
      L5 = L4.data
      L6 = L3.data
      L5.list = L6
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
installedPlug = L4
function L4()
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
getLangList = L4
function L4()
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
getMainLang = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = 0
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "language"
  L3 = L3(L4)
  L4 = L0.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L1 = 1502
  end
  L4 = _UPVALUE1_
  L4 = L4.setLang
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L1 = 1511
  end
  if L1 ~= 0 then
    L5 = _UPVALUE2_
    L5 = L5.getErrorMessage
    L6 = L1
    L5 = L5(L6)
    L2.msg = L5
  end
  L2.code = L1
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
setLang = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.getLocation
  L1, L2 = L1()
  if L1 == "" then
    L0.code = 1502
  else
    L0.location = L1
    L0.name = L2
  end
  L3 = _UPVALUE1_
  L3 = L3.write_json
  L4 = L0
  L3(L4)
end
getLocation = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = 0
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "location"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "server"
  L4 = L4(L5)
  L5 = L0.isStrNil
  L6 = L3
  L5 = L5(L6)
  if L5 then
    L1 = 1502
  else
    L5 = _UPVALUE1_
    L5 = L5.setLocation
    L6 = L3
    L7 = true
    L8 = L4
    L5 = L5(L6, L7, L8)
    if not L5 then
      L1 = 1511
    end
  end
  if L1 ~= 0 then
    L5 = _UPVALUE2_
    L5 = L5.getErrorMessage
    L6 = L1
    L5 = L5(L6)
    L2.msg = L5
  end
  L2.code = L1
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
setLocation = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = "0"
  L2 = {}
  L2.code = 0
  L4 = L0
  L3 = L0.get
  L5 = "nginx"
  L6 = "main"
  L7 = "force_https"
  L3 = L3(L4, L5, L6, L7)
  L1 = L3 or L1
  if not L3 then
    L1 = "0"
  end
  L3 = tonumber
  L4 = L1
  L3 = L3(L4)
  L2.on = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getForceHttps = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "on"
  L3, L4, L5, L6, L7, L8, L9, L10 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10)
  if L2 == 1 then
    L2 = "1"
    if L2 then
      goto lbl_19
    end
  end
  L2 = "0"
  ::lbl_19::
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = {}
  L4.code = 0
  L5 = tonumber
  L6 = L2
  L5 = L5(L6)
  L4.on = L5
  L6 = L3
  L5 = L3.set
  L7 = "nginx"
  L8 = "main"
  L9 = "force_https"
  L10 = L2
  L5(L6, L7, L8, L9, L10)
  L6 = L3
  L5 = L3.commit
  L7 = "nginx"
  L5(L6, L7)
  L5 = L0.forkExec
  L6 = "/etc/init.d/nginx restart"
  L5(L6)
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L4
  L5(L6)
end
setForceHttps = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQNetUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = 0
  L7 = {}
  L8 = L0.isMeshCap
  L8 = L8()
  if L8 then
    L8 = L2.generateLogKeyV2
    L8 = L8()
    L9 = L4.log
    L10 = 6
    L11 = "CAP call RE upload log, CAP key:"
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = L0.forkExec
    L10 = "/sbin/whc_to_re_common_api.sh log_upload "
    L11 = L8
    L10 = L10 .. L11
    L9(L10)
  end
  L8 = L3.exec
  L9 = "/usr/sbin/log_collection.sh"
  L8(L9)
  L8 = L2.uploadLogV2
  L8 = L8()
  if not L8 then
    L6 = 1512
  end
  L7.code = L6
  if L6 ~= 0 then
    L9 = _UPVALUE0_
    L9 = L9.getErrorMessage
    L10 = L6
    L9 = L9(L10)
    L7.msg = L9
  end
  L9 = L3.exec
  L10 = "rm "
  L11 = L1.LOG_ZIP_FILEPATH
  L10 = L10 .. L11
  L9(L10)
  L9 = _UPVALUE1_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
end
uploadLogFile = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "client"
  L3 = L3(L4)
  L4 = L2.getLanWanIp
  L5 = "lan"
  L4 = L4(L5)
  L5 = {}
  if L3 == "web" then
    L6 = L0.check
    L7 = 0
    L8 = L0.KEY_REBOOT
    L9 = 1
    L6(L7, L8, L9)
  end
  L5.code = 0
  L5.lanIp = L4
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L5
  L6(L7)
  L6 = _UPVALUE0_
  L6 = L6.close
  L6()
  L6 = L1.forkReboot
  L6()
end
reboot = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.common.XQConfigs"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "json"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "format"
  L6 = L6(L7)
  L6 = L6 or L6
  L5 = L5(L6)
  L6 = 0
  L7 = {}
  L8 = L0.FORK_RESET_ALL
  if L5 == 1 then
    L9 = "/usr/sbin/format_userdisk fs >/dev/null 2>/dev/null ;"
    L10 = L8
    L8 = L9 .. L10
  end
  L9 = L1.isMeshCap
  L9 = L9()
  if L9 then
    L9 = "ubus call xq_info_sync_mqtt restore >/dev/null 2>/dev/null ;"
    L10 = L8
    L8 = L9 .. L10
  end
  L7.code = L6
  if L6 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L7.code
    L9 = L9(L10)
    L7.msg = L9
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L7
  L9(L10)
  L9 = _UPVALUE0_
  L9 = L9.close
  L9()
  L9 = L7.code
  if L9 == 0 then
    L9 = L1.thrift_tunnel_to_smarthome_controller
    L10 = "{\"command\":\"reset_scenes\"}"
    L9(L10)
    L9 = L1.forkExec
    L10 = L8
    L9(L10)
  end
end
reset = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = "/etc/messagingagent/unbind.sh"
  L4 = L1.log
  L5 = 6
  L6 = "deivce unbind from server"
  L4(L5, L6)
  L4 = L2.forkExec
  L5 = L3
  L4(L5)
  L0.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L0
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.close
  L4()
end
unbind = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.setDetectionTimestamp
  L2()
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = "/usr/sbin/sysapi system_info get cpuload"
  L3 = L3(L4)
  L4 = tonumber
  L5 = L3
  L4 = L4(L5)
  L2.loadavg = L4
  L4 = tonumber
  L5 = L0.exec
  L6 = "cat /proc/cpuinfo | grep -c 'processor'"
  L5, L6 = L5(L6)
  L4 = L4(L5, L6)
  L2.processCount = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.close
  L4()
end
getSysAvgLoad = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "macfilter"
  L4 = "wan"
  L5 = "mode"
  L1 = L1(L2, L3, L4, L5)
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "macfilter"
  L6 = "wan"
  L7 = "maxrulenum"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L2 = L2 or L2
  if L1 == "black" then
    L4 = L0
    L3 = L0.get
    L5 = "macfilter"
    L6 = "wan"
    L7 = "blacknum"
    L3 = L3(L4, L5, L6, L7)
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    if L2 < L3 then
      L4 = 2700
      return L4
    end
  elseif L1 == "white" then
    L4 = L0
    L3 = L0.get
    L5 = "macfilter"
    L6 = "wan"
    L7 = "whitenum"
    L3 = L3(L4, L5, L6, L7)
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    if L2 < L3 then
      L4 = 2700
      return L4
    end
  end
  L3 = 0
  return L3
end
checkAddMaxMACNumItem = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.module.XQFirewall"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQController"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.util.XQSynchrodata"
  L7 = L7(L8)
  L8 = require
  L9 = "luci.util"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.module.XQParentControl"
  L9 = L9(L10)
  L10 = {}
  L11 = L4.macFormat
  L12 = A0
  L11 = L11(L12)
  L10.mac = L11
  L11 = 0
  L12 = checkAddMaxMACNumItem
  L12 = L12()
  L11 = L12
  if L11 ~= 0 then
    return L11
  end
  if A3 ~= "" then
    L12 = tonumber
    L13 = A3
    L12 = L12(L13)
    if L12 == 1 then
      L12 = "1"
      if L12 then
        goto lbl_42
        A3 = L12 or A3
      end
    end
    A3 = "0"
    ::lbl_42::
    if A3 == "1" then
      L12 = 1
      if L12 then
        goto lbl_48
      end
    end
    L12 = 0
    ::lbl_48::
    L10.wan = L12
    L12 = L9.macfilter_wan_changed
    L13 = A0
    if A3 == "1" then
      L14 = true
      if L14 then
        goto lbl_57
      end
    end
    L14 = false
    ::lbl_57::
    L12(L13, L14)
  end
  if A1 then
    L10.name = A1
  else
    A1 = A0
  end
  if A2 then
    L12 = tonumber
    L13 = A2
    L12 = L12(L13)
    if L12 == 1 then
      L12 = "1"
      if L12 then
        goto lbl_74
        A2 = L12 or A2
      end
    end
    A2 = "0"
    ::lbl_74::
    if A2 == "1" then
      L12 = 1
      if L12 then
        goto lbl_80
      end
    end
    L12 = 0
    ::lbl_80::
    L10.option = L12
  end
  L12 = L5.setMacFilter
  L13 = string
  L13 = L13.upper
  L14 = A0
  L13 = L13(L14)
  L14 = A1
  L15 = A2
  L16 = A3
  L12(L13, L14, L15, L16)
  L12 = L6.permission
  L13 = A0
  L14 = lan
  L15 = A3
  L16 = admin
  L17 = pridisk
  L12(L13, L14, L15, L16, L17)
  L12 = L7.syncDeviceInfo
  L13 = L10
  L12(L13)
  return L11
end
_setMacFilter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mac"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "wan"
  L5 = L5(L6)
  L5 = L5 or L5
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "lan"
  L6 = L6(L7)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "admin"
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "pridisk"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "name"
  L11 = nil
  L12 = "?commonstr"
  L9 = L9(L10, L11, L12)
  L9 = L9 or L9
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "option"
  L10 = L10(L11)
  L10 = L10 or L10
  L11 = L0.isStrNil
  L12 = L4
  L11 = L11(L12)
  if not L11 then
    L11 = L1.macaddr
    L12 = L4
    L11 = L11(L12)
    if L11 then
      L11 = _setMacFilter
      L12 = L4
      L13 = L9
      L14 = L10
      L15 = L5
      L11 = L11(L12, L13, L14, L15)
      L3 = L11
  end
  else
    L3 = 1508
  end
  L2.code = L3
  if L3 ~= 0 then
    L11 = _UPVALUE1_
    L11 = L11.getErrorMessage
    L12 = L3
    L11 = L11(L12)
    L2.msg = L11
  end
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L2
  L11(L12)
end
setMacFilter = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L6 = require
  L7 = "xiaoqiang.common.XQFunction"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.module.XQFirewall"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQController"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.util.XQSynchrodata"
  L9 = L9(L10)
  L10 = require
  L11 = "luci.util"
  L10 = L10(L11)
  L11 = require
  L12 = "xiaoqiang.module.XQParentControl"
  L11 = L11(L12)
  L12 = {}
  L13 = tostring
  L14 = A1
  L13 = L13(L14)
  L12.ipaddr = L13
  if A3 then
    L13 = tonumber
    L14 = A3
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_35
        A3 = L13 or A3
      end
    end
    A3 = "0"
    ::lbl_35::
    if A3 == "1" then
      L13 = 1
      if L13 then
        goto lbl_41
      end
    end
    L13 = 0
    ::lbl_41::
    L12.wan = L13
    L13 = L11.macfilter_wan_changed
    L14 = A1
    if A3 == "1" then
      L15 = true
      if L15 then
        goto lbl_50
      end
    end
    L15 = false
    ::lbl_50::
    L13(L14, L15)
  end
  L13 = lan
  if L13 then
    L13 = tonumber
    L14 = lan
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_63
      end
    end
    L13 = "0"
    ::lbl_63::
    lan = L13
    L13 = lan
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_71
      end
    end
    L13 = 0
    ::lbl_71::
    L12.lan = L13
  end
  L13 = admin
  if L13 then
    L13 = tonumber
    L14 = admin
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_84
      end
    end
    L13 = "0"
    ::lbl_84::
    admin = L13
    L13 = admin
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_92
      end
    end
    L13 = 0
    ::lbl_92::
    L12.admin = L13
  end
  L13 = pridisk
  if L13 then
    L13 = tonumber
    L14 = pridisk
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_105
      end
    end
    L13 = "0"
    ::lbl_105::
    pridisk = L13
    L13 = pridisk
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_113
      end
    end
    L13 = 0
    ::lbl_113::
    L12.pridisk = L13
  end
  if A4 then
    L12.name = A4
  end
  if A5 then
    L13 = tonumber
    L14 = A5
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_128
        A5 = L13 or A5
      end
    end
    A5 = "0"
    ::lbl_128::
    if A5 == "1" then
      L13 = 1
      if L13 then
        goto lbl_134
      end
    end
    L13 = 0
    ::lbl_134::
    L12.option = L13
  end
  L13 = L7.setIpFilter
  L14 = A0
  L15 = A1
  L16 = A2
  L17 = A3
  L18 = A4
  L19 = A5
  L13(L14, L15, L16, L17, L18, L19)
  L13 = L8.ippermission
  L14 = A1
  L15 = lan
  L16 = A3
  L17 = admin
  L18 = pridisk
  L13(L14, L15, L16, L17, L18)
  L13 = L9.syncDeviceInfo
  L14 = L12
  L13(L14)
end
_setIpFilter = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L6 = require
  L7 = "xiaoqiang.common.XQFunction"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.module.XQFirewall"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQController"
  L8 = L8(L9)
  L9 = require
  L10 = "xiaoqiang.util.XQSynchrodata"
  L9 = L9(L10)
  L10 = require
  L11 = "luci.util"
  L10 = L10(L11)
  L11 = require
  L12 = "xiaoqiang.module.XQParentControl"
  L11 = L11(L12)
  L12 = {}
  L13 = tostring
  L14 = A1
  L13 = L13(L14)
  L12.ipaddrv6 = L13
  if A3 then
    L13 = tonumber
    L14 = A3
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_35
        A3 = L13 or A3
      end
    end
    A3 = "0"
    ::lbl_35::
    if A3 == "1" then
      L13 = 1
      if L13 then
        goto lbl_41
      end
    end
    L13 = 0
    ::lbl_41::
    L12.wan = L13
    L13 = L11.macfilter_wan_changed
    L14 = A1
    if A3 == "1" then
      L15 = true
      if L15 then
        goto lbl_50
      end
    end
    L15 = false
    ::lbl_50::
    L13(L14, L15)
  end
  L13 = lan
  if L13 then
    L13 = tonumber
    L14 = lan
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_63
      end
    end
    L13 = "0"
    ::lbl_63::
    lan = L13
    L13 = lan
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_71
      end
    end
    L13 = 0
    ::lbl_71::
    L12.lan = L13
  end
  L13 = admin
  if L13 then
    L13 = tonumber
    L14 = admin
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_84
      end
    end
    L13 = "0"
    ::lbl_84::
    admin = L13
    L13 = admin
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_92
      end
    end
    L13 = 0
    ::lbl_92::
    L12.admin = L13
  end
  L13 = pridisk
  if L13 then
    L13 = tonumber
    L14 = pridisk
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_105
      end
    end
    L13 = "0"
    ::lbl_105::
    pridisk = L13
    L13 = pridisk
    if L13 == "1" then
      L13 = 1
      if L13 then
        goto lbl_113
      end
    end
    L13 = 0
    ::lbl_113::
    L12.pridisk = L13
  end
  if A4 then
    L12.name = A4
  end
  if A5 then
    L13 = tonumber
    L14 = A5
    L13 = L13(L14)
    if L13 == 1 then
      L13 = "1"
      if L13 then
        goto lbl_128
        A5 = L13 or A5
      end
    end
    A5 = "0"
    ::lbl_128::
    if A5 == "1" then
      L13 = 1
      if L13 then
        goto lbl_134
      end
    end
    L13 = 0
    ::lbl_134::
    L12.option = L13
  end
  L13 = L7.setIpv6Filter
  L14 = A0
  L15 = A1
  L16 = A2
  L17 = A3
  L18 = A4
  L19 = A5
  L13(L14, L15, L16, L17, L18, L19)
  L13 = L8.ippermission
  L14 = A1
  L15 = lan
  L16 = A3
  L17 = admin
  L18 = pridisk
  L13(L14, L15, L16, L17, L18)
  L13 = L9.syncDeviceInfo
  L14 = L12
  L13(L14)
end
_setIpv6Filter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "ipaddr"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ipaddrv6"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "wan"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "lan"
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "export"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = string
  L9 = L9.lower
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "protocol"
  L10 = L10(L11)
  L10 = L10 or L10
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "admin"
  L10 = L10(L11)
  L10 = L10 or L10
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "pridisk"
  L11 = L11(L12)
  L11 = L11 or L11
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "name"
  L12 = L12(L13)
  L12 = L12 or L12
  L13 = _UPVALUE0_
  L13 = L13.formvalue
  L14 = "option"
  L13 = L13(L14)
  L13 = L13 or L13
  L14 = L0.isStrNil
  L15 = L8
  L14 = L14(L15)
  if not L14 then
    L14 = XQFirewall
    L14 = L14.checkPort
    L15 = L8
    L14 = L14(L15)
    if not L14 then
      L3 = 1523
  end
  else
    L14 = L0.isStrNil
    L15 = L4
    L14 = L14(L15)
    if not L14 then
      L14 = L1.ipaddr
      L15 = L4
      L14 = L14(L15)
      if not L14 then
        L14 = _setIpFilter
        L15 = L9
        L16 = L4
        L17 = L8
        L18 = L6
        L19 = L12
        L20 = L13
        L14(L15, L16, L17, L18, L19, L20)
    end
    else
      L3 = 1508
    end
    L14 = L0.isStrNil
    L15 = L5
    L14 = L14(L15)
    if not L14 then
      L14 = L1.ipaddr
      L15 = L5
      L14 = L14(L15)
      if not L14 then
        L14 = _setIpv6Filter
        L15 = L9
        L16 = L5
        L17 = L8
        L18 = L6
        L19 = L12
        L20 = L13
        L14(L15, L16, L17, L18, L19, L20)
    end
    else
      L3 = 1508
    end
  end
  L2.code = L3
  if L3 ~= 0 then
    L14 = _UPVALUE1_
    L14 = L14.getErrorMessage
    L15 = L3
    L14 = L14(L15)
    L2.msg = L14
  end
  L14 = _UPVALUE0_
  L14 = L14.write_json
  L15 = L2
  L14(L15)
end
setIpFilter = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.openWifiWps
  L2 = L2()
  L1.timestamp = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
openWps = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = L0.stopWps
  L1()
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
stopWps = L4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = require
  L4 = "xiaoqiang.util.XQWifiUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = L4.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L5 = L3.getWpsConDevMac
    L5 = L5()
    L2 = L5
  else
    L2 = A0
  end
  L5 = L3.getDeviceWifiIndex
  L6 = A0
  L5 = L5(L6)
  if 0 < L5 then
    return L2
  elseif 0 < A1 then
    L5 = os
    L5 = L5.execute
    L6 = "sleep 3"
    L5(L6)
    L5 = _checkConnection
    L6 = L2
    L7 = A1 - 1
    L5 = L5(L6, L7)
    L6 = L4.isStrNil
    L7 = L5
    L6 = L6(L7)
    if not L6 then
      return L5
    end
  end
  L5 = false
  return L5
end
_checkConnection = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = "/tmp/new_sta_onre"
  L2 = L0.access
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = nil
    L3 = io
    L3 = L3.open
    L4 = L1
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
      if L2 ~= nil then
        L4 = true
        return L4
      end
    end
  end
  L2 = false
  return L2
end
chkNewStaOnRe = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDeviceUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = {}
  L6 = L0.getWifiWpsStatus
  L6 = L6()
  if L6 == 2 then
    L7 = {}
    L8 = L0.getWpsConDevMac
    L8 = L8()
    if L8 then
      L9 = L0.getDeviceWifiIndex
      L10 = L8
      L9 = L9(L10)
      if 0 < L9 then
        L7.mac = L8
        L9 = L3.getDeviceCompany
        L10 = L8
        L9 = L9(L10)
        L7.company = L9
      else
        L9 = _checkConnection
        L10 = L8
        L11 = 2
        L9 = L9(L10, L11)
        if L9 then
          L7.mac = L9
          L10 = L3.getDeviceCompany
          L11 = L9
          L10 = L10(L11)
          L7.company = L10
          L5.device = L7
        else
          L6 = 9
        end
      end
    else
      L9 = _checkConnection
      L10 = L8
      L11 = 2
      L9 = L9(L10, L11)
      if L9 then
        L7.mac = L9
        L10 = L3.getDeviceCompany
        L11 = L9
        L10 = L10(L11)
        L7.company = L10
        L5.device = L7
      else
        L6 = 9
      end
    end
  end
  if 3 <= L6 and L6 <= 7 then
    L6 = 3
  end
  L5.code = 0
  L5.status = L6
  L7 = L1.get
  L8 = L2.PREF_WPS_TIMESTAMP
  L9 = ""
  L7 = L7(L8, L9)
  L5.startTime = L7
  L7 = tostring
  L8 = os
  L8 = L8.time
  L8, L9, L10, L11 = L8()
  L7 = L7(L8, L9, L10, L11)
  L5.currentTime = L7
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
getWpsStatus = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.LAMP_CREATE_SANDBOX
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
createSandbox = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.LAMP_MOUNT_THINGS
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
mountThings = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.LAMP_UMOUNT_THINGS
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
umountThings = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.LAMP_START_DROPBEAR
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
startDropbear = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.LAMP_STOP_DROPBEAR
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
stopDropbear = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = os
  L4 = L4.execute
  L5 = L1.LAMP_IS_SANDBOX_CREATED
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L3 = 0 == L3
  L2.isSandboxCreated = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
isSandboxCreated = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = os
  L4 = L4.execute
  L5 = L1.LAMP_ARE_THINGS_MOUNTED
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L3 = 0 == L3
  L2.areThingsMounted = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
areThingsMounted = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = os
  L4 = L4.execute
  L5 = L1.LAMP_IS_DROPBEAR_STARTED
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L3 = 0 == L3
  L2.isDropbearStarted = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
isDropbearStarted = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.NGINX_CACHE_STOP
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
stopNginx = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = L1.NGINX_CACHE_START
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
startNginx = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L2.status = 1
  L3 = L0.exec
  L4 = L1.NGINX_CACHE_STATUS
  L3 = L3(L4)
  if L3 then
    L4 = L0.trim
    L5 = L3
    L4 = L4(L5)
    if L4 == "NGINX_CACHE=off" then
      L4 = 0
      if L4 then
        goto lbl_24
      end
    end
    L4 = 1
    ::lbl_24::
    L2.status = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
nginxCacheStatus = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.getRouterNamePending
  L2 = L2()
  L1.pending = L2
  L2 = L0.mattool_get_deviceid
  L2 = L2()
  L1.routerId = L2
  L2 = _UPVALUE0_
  L2 = L2.getRouterName
  L2 = L2()
  L1.routerName = L2
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
checkRouterNamePending = L4
function L4()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.setRouterNamePending
  L1 = "0"
  L0(L1)
  L0 = {}
  L0.code = 0
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
clearRouterNamePending = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.util.XQSecureUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.getcookie
  L3 = "psp"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L1.getLanIp
  L4 = L4()
  L4 = L4 or L4
  if L2 then
    L6 = L2
    L5 = L2.match
    L7 = "|||(%S)|||"
    L5 = L5(L6, L7)
    L6 = "http://"
    L7 = L4
    L8 = "/cgi-bin/luci/web/home?redirectKey="
    L9 = L0.generateRedirectKey
    L10 = L5
    L9 = L9(L10)
    L6 = L6 .. L7 .. L8 .. L9
    L3.redirectUrl = L6
  else
    L5 = "http://"
    L6 = L4
    L7 = "/cgi-bin/luci/web/home?redirectKey="
    L8 = L0.generateRedirectKey
    L9 = 2
    L8 = L8(L9)
    L5 = L5 .. L6 .. L7 .. L8
    L3.redirectUrl = L5
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
redirectUrl = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQDeviceUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQZigbeeUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = L2.getWanLanNetworkStatistics
  L6 = "lan"
  L5 = L5(L6)
  L6 = L2.getWanLanNetworkStatistics
  L7 = "wan"
  L6 = L6(L7)
  L7 = L0.thrift_tunnel_to_smarthome_controller
  L8 = "{\"command\":\"get_scene_count\"}"
  L7 = L7(L8)
  if L7 then
    L8 = L7.code
    if L8 == 0 then
      L8 = L7.count
      L4.smartSceneCount = L8
  end
  else
    L4.smartSceneCount = 0
  end
  L8 = L0.thrift_tunnel_to_datacenter
  L9 = "{\"api\":26}"
  L8 = L8(L9)
  if L8 then
    L9 = L8.code
    if L9 == 0 then
      L9 = math
      L9 = L9.floor
      L10 = tonumber
      L11 = L8.free
      L10 = L10(L11)
      L10 = L10 / 1024
      L9 = L9(L10)
      L4.useableSpace = L9
  end
  else
    L4.useableSpace = 0
  end
  L9 = L0.thrift_tunnel_to_datacenter
  L10 = "{\"api\":601}"
  L9 = L9(L10)
  if L9 then
    L10 = L9.code
    if L10 == 0 then
      L10 = L9.data
      L10 = #L10
      L4.installedPluginCount = L10
  end
  else
    L4.installedPluginCount = 0
  end
  L10 = 0
  L11 = 0
  L12 = L0.thrift_tunnel_to_datacenter
  L13 = "{\"api\":503}"
  L12 = L12(L13)
  if L12 then
    L13 = L12.code
    if L13 == 0 then
      L13 = table
      L13 = L13.foreach
      L14 = L12.uncompletedList
      function L15(A0, A1)
        local L2
        L2 = _UPVALUE0_
        L2 = L2 + 1
        _UPVALUE0_ = L2
        L2 = A1.downloadStatus
        if L2 == 1 then
          L2 = _UPVALUE1_
          L2 = L2 + 1
          _UPVALUE1_ = L2
        end
      end
      L13(L14, L15)
    end
  end
  L13 = L3.get_zigbee_count
  L13 = L13()
  L4.code = 0
  L14 = L2.getConnectDeviceCount
  L14 = L14()
  L14 = L13 + L14
  L4.connectDeviceCount = L14
  L14 = L1.getSysUptime
  L14 = L14()
  L4.upTime = L14
  L14 = tonumber
  L15 = L6.maxdownloadspeed
  L14 = L14(L15)
  L4.maxWanSpeed = L14
  L14 = tonumber
  L15 = L5.maxdownloadspeed
  L14 = L14(L15)
  L4.maxLanSpeed = L14
  L14 = tonumber
  L15 = L6.downspeed
  L14 = L14(L15)
  L4.wanSpeed = L14
  L14 = tonumber
  L15 = L5.downspeed
  L14 = L14(L15)
  L4.lanSpeed = L14
  if 0 < L11 then
    L14 = 1
    if L14 then
      goto lbl_112
    end
  end
  L14 = 0
  ::lbl_112::
  L4.hasDownloading = L14
  L4.downloadingCount = L10
  L14 = _UPVALUE0_
  L14 = L14.write_json
  L15 = L4
  L14(L15)
end
mainStatusForApp = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = 0
  L3 = {}
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "filter"
  L4 = L4(L5)
  L4 = L4 or L4
  L6 = L1
  L5 = L1.get
  L7 = "macfilter"
  L8 = L4
  L9 = "mode"
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L3.mode = L5
  else
    L2 = 1574
  end
  L3.code = L2
  L6 = L3.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L3.code
    L6 = L6(L7)
    L3.msg = L6
  end
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L3
  L6(L7)
end
getMacfilterMode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = 0
  L3 = {}
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "filter"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "mode"
  L6 = L6(L7)
  L6 = L6 or L6
  L5 = L5(L6)
  L6 = L0.setMacfilterMode
  L7 = L4
  L8 = L5
  L6 = L6(L7, L8)
  if not L6 then
    L2 = 1575
  end
  L3.code = L2
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
setMacfilterMode = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
  L2 = _UPVALUE0_
  L2 = L2.close
  L2()
  L2 = L0.forkShutdown
  L2()
end
shutdown = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQUPnPUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getUPnPStatus
  L2 = L2()
  if L2 then
    L2 = 1
    if L2 then
      goto lbl_14
    end
  end
  L2 = 0
  ::lbl_14::
  L1.status = L2
  L2 = L0.getUPnPList
  L2 = L2()
  if L2 then
    L1.list = L2
  else
    L3 = {}
    L1.list = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
upnpList = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQUPnPUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "switch"
  L3 = L3(L4)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = {}
  L4 = L0.check
  L5 = 0
  L6 = L0.KEY_FUNC_UPNP
  if L2 == 1 then
    L7 = 0
    if L7 then
      goto lbl_26
    end
  end
  L7 = 1
  ::lbl_26::
  L4(L5, L6, L7)
  L4 = L1.switchUPnP
  L5 = L2 == 1
  L4(L5)
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
upnpSwitch = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = L0.appInfo
  L1 = L1()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
appLimit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "api"
  L0 = L0(L1)
  L0 = L0 or L0
  L1 = {}
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L1.code = 0
  L4 = L2.exec
  L5 = "curl \"http://127.0.0.1:9000/"
  L6 = L3._cmdformat
  L7 = L0
  L6 = L6(L7)
  L7 = "\""
  L5 = L5 .. L6 .. L7
  L4 = L4(L5)
  L1.data = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
xunlei_api = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQQoSUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "switch"
  L3 = L3(L4)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = {}
  L4 = L0.check
  L5 = 0
  L6 = L0.KEY_FUNC_APPQOS
  if L2 == 1 then
    L7 = 0
    if L7 then
      goto lbl_26
    end
  end
  L7 = 1
  ::lbl_26::
  L4(L5, L6, L7)
  L4 = L1.appSpeedlimitSwitch
  L5 = L2 == 1
  L4(L5)
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
appLimitSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQQoSUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "xlmaxdownload"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "xlmaxupload"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "kpmaxdownload"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "kpmaxupload"
  L5 = L5(L6)
  L6 = L0.setXunlei
  L7 = L2
  L8 = L3
  L6(L7, L8)
  L6 = L0.setKuaipan
  L7 = L4
  L8 = L5
  L6(L7, L8)
  L6 = L0.reload
  L6()
  L1.code = 0
  L6 = _UPVALUE0_
  L6 = L6.write_json
  L7 = L1
  L6(L7)
end
setAppLimit = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getVPNInfo
  L3 = "vpn"
  L2 = L2(L3)
  L3 = L0.getVPNList
  L3 = L3()
  L1.code = 0
  L1.current = L2
  L1.list = L3
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
vpnInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQVPNUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = 0
  L4 = {}
  L5 = L2.xssCheck
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "server"
  L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "username"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "password"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "proto"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "auto"
  L9 = L9(L10)
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "id"
  L10 = L10(L11)
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "oname"
  L11 = L11(L12)
  L12 = true
  if L10 then
    L13 = L1.editVPN
    L14 = L10
    L15 = L11
    L16 = L5
    L17 = L6
    L18 = L7
    L19 = L8
    L13 = L13(L14, L15, L16, L17, L18, L19)
    L12 = L13
  else
    L13 = L1.addVPN
    L14 = L11
    L15 = L5
    L16 = L6
    L17 = L7
    L18 = L8
    L19 = "auto"
    L13 = L13(L14, L15, L16, L17, L18, L19)
    L12 = L13
  end
  if L12 then
    L3 = 0
  else
    L3 = 1583
  end
  L4.code = L3
  L13 = L4.code
  if L13 ~= 0 then
    L13 = _UPVALUE1_
    L13 = L13.getErrorMessage
    L14 = L4.code
    L13 = L13(L14)
    L4.msg = L13
  end
  L13 = _UPVALUE0_
  L13 = L13.write_json
  L14 = L4
  L13(L14)
end
setVpn = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = 0
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "auto"
  L3 = L3(L4)
  L4 = L0.setVpnAuto
  L5 = L3
  L4(L5)
  L2.code = L1
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
setVpnAuto = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "id"
  L2 = L2(L3)
  L3 = L0.delVPN
  L4 = L2
  L3(L4)
  L1.code = 0
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
delVpn = L4
function L4(A0)
  local L1, L2, L3, L4, L5
  L1 = {}
  L1["300"] = 1
  L1["301"] = 1
  L1["302"] = 1
  L1["303"] = 1
  L1["646"] = 1
  L1["647"] = 1
  L1["648"] = 1
  L1["649"] = 1
  L1["691"] = 1
  L2 = {}
  L2["516"] = 1
  L2["650"] = 1
  L2["601"] = 1
  L2["510"] = 1
  L2["701"] = 1
  L3 = {}
  L3["400"] = 1
  L3["401"] = 1
  L3["402"] = 1
  L3["403"] = 1
  L3["404"] = 1
  L3["405"] = 1
  L3["410"] = 1
  L3["411"] = 1
  L3["412"] = 1
  L3["413"] = 1
  L3["414"] = 1
  L3["415"] = 1
  L3["505"] = 1
  L3["506"] = 1
  L3["513"] = 1
  L3["514"] = 1
  L3["517"] = 1
  L4 = tostring
  L5 = A0
  L4 = L4(L5)
  if L4 then
    L5 = L1[L4]
    if L5 then
      L5 = 1584
      return L5
    end
    L5 = L2[L4]
    if L5 then
      L5 = 1585
      return L5
    end
    L5 = L3[L4]
    if L5 then
      L5 = 1586
      return L5
    end
    L5 = 1584
    return L5
  end
end
_vpnErrorCodeHelper = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = L0.vpnStatus
  L1 = L1()
  L2 = {}
  if L1 then
    L3 = L1.up
    L4 = L1.autostart
    L5 = tonumber
    L6 = L1.uptime
    L5 = L5(L6)
    L6 = L1.stat
    L7 = L1.pending
    if L3 then
      L2.status = 0
      L2.uptime = L5
    elseif L4 then
      if L6 then
        L8 = L6.code
        if L8 ~= 0 then
          L2.status = 2
          L2.uptime = 0
          L8 = L6.code
          L2.errcode = L8
          L8 = _UPVALUE0_
          L8 = L8.getErrorMessage
          L9 = _vpnErrorCodeHelper
          L10 = L6.code
          L9, L10, L11 = L9(L10)
          L8 = L8(L9, L10, L11)
          L9 = " "
          L10 = tostring
          L11 = L6.code
          L10 = L10(L11)
          L8 = L8 .. L9 .. L10
          L2.errmsg = L8
      end
      else
        L2.status = 1
        L2.uptime = 0
      end
    else
      L2.status = 3
      L2.uptime = 0
      if L6 then
        L8 = L6.code
        if L8 == 701 then
          L2.status = 2
          L2.uptime = 0
          L8 = L6.code
          L2.errcode = L8
          L8 = _UPVALUE0_
          L8 = L8.getErrorMessage
          L9 = _vpnErrorCodeHelper
          L10 = L6.code
          L9, L10, L11 = L9(L10)
          L8 = L8(L9, L10, L11)
          L9 = " "
          L10 = tostring
          L11 = L6.code
          L10 = L10(L11)
          L8 = L8 .. L9 .. L10
          L2.errmsg = L8
        end
      end
    end
  else
    L2.status = 4
    L2.uptime = 0
  end
  L2.code = 0
  L3 = _UPVALUE1_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
vpnStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQVPNUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "conn"
  L2, L3, L4, L5, L6 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "id"
  L2 = L2(L3)
  L3 = {}
  if L1 and L1 == 1 then
    L4 = L0.vpnSwitch
    L5 = true
    L6 = L2
    L4(L5, L6)
  else
    L4 = L0.vpnSwitch
    L5 = false
    L6 = L2
    L4(L5, L6)
  end
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
vpnSwitch = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = luci
  L0 = L0.http
  L0 = L0.getenv
  L1 = "REMOTE_ADDR"
  L0 = L0(L1)
  L0 = L0 or L0
  L1 = {}
  L2 = 0
  if L0 ~= "127.0.0.1" then
    L3 = luci
    L3 = L3.dispatcher
    L3 = L3.getremotemac
    L4 = "use_ex"
    L3 = L3(L4)
    L1.mac = L3
  else
    L2 = 1587
  end
  L1.code = L2
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
getDeviceMacaddr = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getDetectionTimestamp
  L2 = L2()
  L1.timestamp = L2
  L2 = tostring
  L3 = os
  L3 = L3.time
  L3 = L3()
  L2 = L2(L3)
  L1.currentTime = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getDetectionTimestamp = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getWifiLog
  L2()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWifiLog = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "ssid"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "enc"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "pwd"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "wanType"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "pppoeName"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "pppoePwd"
  L8 = L8(L9)
  if L3 then
    L9 = L1.setWifiBasicInfo
    L10 = 1
    L11 = L3
    L12 = L5
    L13 = L4
    L14, L15 = nil, nil
    L16 = 0
    L9(L10, L11, L12, L13, L14, L15, L16)
    L9 = L1.setWifiBasicInfo
    L10 = 2
    L11 = L3
    L12 = "_5G"
    L11 = L11 .. L12
    L12 = L5
    L13 = L4
    L14, L15 = nil, nil
    L16 = 0
    L9(L10, L11, L12, L13, L14, L15, L16)
  end
  L9 = L0.forkRestartWifi
  L9()
  if L6 == "pppoe" then
    L9 = L2.setWanPPPoE
    L10 = L7
    L11 = L8
    L12, L13, L14 = nil, nil, nil
    L9(L10, L11, L12, L13, L14)
  elseif L6 == "dhcp" then
    L9 = L2.setWanStaticOrDHCP
    L10 = L6
    L11, L12, L13, L14, L15, L16 = nil, nil, nil, nil, nil, nil
    L9(L10, L11, L12, L13, L14, L15, L16)
  end
  L9 = {}
  L9.code = 0
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L9
  L10(L11)
end
sysRecovery = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = {}
  L2 = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "delay1"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "delay2"
  L4 = L4(L5)
  if L3 and L4 then
    L5 = L0.forkShutdownAndRebootWithDelay
    L6 = L3
    L7 = L4
    L5(L6, L7)
  else
    L2 = 1502
  end
  L1.code = L2
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
smartShutdown = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.noflushdStatus
  L2, L3, L4 = L2()
  L1 = L1(L2, L3, L4)
  if L1 == 0 then
    L1 = 1
  else
    L1 = 0
  end
  L2 = {}
  L2.code = 0
  L2.status = L1
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getNofStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "switch"
  L3, L4, L5, L6, L7, L8 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L2 = L2 or L2
  L3 = {}
  L4 = L1.noflushdSwitch
  if L2 == 1 then
    L5 = true
    if L5 then
      goto lbl_24
    end
  end
  L5 = false
  ::lbl_24::
  L4 = L4(L5)
  L5 = L0.check
  L6 = 0
  L7 = L0.KEY_FUNC_NOFLUSHED
  if L2 == 1 then
    L8 = 0
    if L8 then
      goto lbl_34
    end
  end
  L8 = 1
  ::lbl_34::
  L5(L6, L7, L8)
  if L2 == 1 then
    L5 = L0.check
    L6 = 0
    L7 = L0.KEY_DISKSLEEP_OPEN
    L8 = 1
    L5(L6, L7, L8)
  else
    L5 = L0.check
    L6 = 0
    L7 = L0.KEY_DISKSLEEP_CLOSE
    L8 = 1
    L5(L6, L7, L8)
  end
  if L4 then
    L3.code = 0
  else
    L3.code = 1606
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
nofSwitch = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.predownloadInfo
  L2 = L2()
  L1.code = 0
  L3 = L2.enable
  L1.status = L3
  L3 = L2.priority
  L1.priority = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
predownloadInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "switch"
  L2, L3, L4, L5 = L2(L3)
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = {}
  L3 = L0.switch
  if L1 == 1 then
    L4 = true
    if L4 then
      goto lbl_21
    end
  end
  L4 = false
  ::lbl_21::
  L3 = L3(L4)
  if L3 then
    L2.code = 0
  else
    L2.code = 1606
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
predownloadSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
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
  L4 = L1.diskstatus
  L4 = L4()
  L5 = tonumber
  L6 = L0.get
  L7 = "SMARTCTL_TIME"
  L8 = 0
  L6, L7, L8 = L6(L7, L8)
  L5 = L5(L6, L7, L8)
  L6 = os
  L6 = L6.time
  L6 = L6()
  L6 = L6 - L5
  if L5 == 0 or L6 < 0 then
    L3.interval = "0"
  else
    L7 = tostring
    L8 = L6
    L7 = L7(L8)
    L3.interval = L7
  end
  L3.code = 0
  L7 = L2.poweronhours
  L3.poweronhours = L7
  L3.status = L4
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L3
  L7(L8)
end
getDiskInfo = L4
function L4()
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
getIOData = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = L0.smartctl
  L1 = L1()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
diskScan = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQDisk"
  L1 = L1(L2)
  L2 = {}
  L3 = L0.set
  L4 = "SMARTCTL_TIME"
  L5 = os
  L5 = L5.time
  L5 = L5()
  L3(L4, L5)
  L3 = L1.checkdisk
  L3()
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
diskCheck = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQDisk"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.getcheckstatus
  L2 = L2()
  L1.code = 0
  L1.status = L2
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
diskCheckStatus = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.pushSettings
  L2 = L2()
  L3 = L2.auth
  if L3 then
    L3 = 1
    if L3 then
      goto lbl_15
    end
  end
  L3 = 0
  ::lbl_15::
  L1.auth = L3
  L3 = L2.quiet
  if L3 then
    L3 = 1
    if L3 then
      goto lbl_23
    end
  end
  L3 = 0
  ::lbl_23::
  L1.quiet = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getPushSettings = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "auth"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "quiet"
  L3 = L3(L4)
  if L2 then
    L4 = tonumber
    L5 = L2
    L4 = L4(L5)
    if L4 then
      L4 = L0.pushConfig
      L5 = "auth"
      L6 = tonumber
      L7 = L2
      L6, L7 = L6(L7)
      L4(L5, L6, L7)
    end
  end
  if L3 then
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    if L4 then
      L4 = L0.pushConfig
      L5 = "quiet"
      L6 = tonumber
      L7 = L3
      L6, L7 = L6(L7)
      L4(L5, L6, L7)
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
pushSwitch = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.util.XQPushUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSynchrodata"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mac"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "notify"
  L4 = L4(L5)
  if L3 and L4 then
    L5 = L0.setSpecialNotify
    L6 = L3
    L7 = tonumber
    L8 = L4
    L7 = L7(L8)
    if L7 == 1 then
      L7 = true
      if L7 then
        goto lbl_32
      end
    end
    L7 = false
    ::lbl_32::
    L8 = 1
    L5(L6, L7, L8)
    L5 = L1.syncDeviceInfo
    L6 = {}
    L6.mac = L3
    L7 = tonumber
    L8 = L4
    L7 = L7(L8)
    L6.push = L7
    L5(L6)
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
end
setDevNotify = L4
function L4()
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
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getOTAInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQPredownload"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "auto"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L3 = L0.setPredownload
  L4 = nil
  L5 = L2
  L6 = nil
  L3(L4, L5, L6)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
setOTAInfo = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = L0.getSpecialDevCount
  L1 = L1()
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
specialDevCount = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQDeviceUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.devicelistForMAgent
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
devicelistForMAgent = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "language"
  L2 = nil
  L3 = "commonstr"
  L0 = L0(L1, L2, L3)
  L1 = require
  L2 = "xiaoqiang.XQCountryCode"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L1.getCurrentCountryCode
  L3 = L3()
  L2.current = L3
  L3 = L1.getCountryCodeList
  L4 = L0
  L3 = L3(L4)
  L2.list = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
getCountryCode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQCountryCode"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L1.getCurrentCountryCode
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "country"
  L4 = L4(L5)
  L5 = L1.setCurrentCountryCode
  L6 = L4
  L5 = L5(L6)
  if not L5 then
    L2.code = 1620
  else
    L5 = "matool --method server_host_update"
    L6 = tonumber
    L7 = os
    L7 = L7.execute
    L8 = L5
    L7, L8 = L7(L8)
    L6 = L6(L7, L8)
    if L6 ~= 0 then
      L2.code = 1606
      L6 = L1.setCurrentCountryCode
      L7 = L3
      L6(L7)
    end
  end
  L5 = L2.code
  if L5 ~= 0 then
    L5 = _UPVALUE1_
    L5 = L5.getErrorMessage
    L6 = L2.code
    L5 = L5(L6)
    L2.msg = L5
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L2
    L5(L6)
  else
    L5 = _UPVALUE0_
    L5 = L5.write_json
    L6 = L2
    L5(L6)
    L5 = _UPVALUE0_
    L5 = L5.close
    L5()
    L5 = L0.forkReboot
    L5()
  end
end
setCountryCode = L4
function L4()
  local L0, L1, L2, L3
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "permission"
  L1, L2, L3 = L1(L2)
  L0 = L0(L1, L2, L3)
  if L0 and L0 == 0 then
    L1 = _UPVALUE1_
    L1 = L1.setFlashPermission
    L2 = false
    L1(L2)
  else
    L1 = _UPVALUE1_
    L1 = L1.setFlashPermission
    L2 = true
    L1(L2)
  end
  L1 = {}
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
flashPermission = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = L0.getCachedDirInfo
  L1 = L1()
  if not L1 then
    L2 = {}
    L2.code = 1638
    L3 = _UPVALUE0_
    L3 = L3.getErrorMessage
    L4 = 1638
    L3 = L3(L4)
    L2.msg = L3
    L1 = L2
  else
    L1.code = 0
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getUserdiskDataInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "files"
  L4 = L4(L5)
  if L4 then
    L5 = L2.binaryBase64Enc
    L6 = L4
    L5 = L5(L6)
    L6 = L0.forkExec
    L7 = "lua /usr/sbin/disk_backup.lua "
    L8 = L5
    L7 = L7 .. L8
    L6(L7)
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
backupData = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.backupStatus
  L2 = L2()
  L3 = L2.status
  L1.status = L3
  L3 = L2.description
  L1.description = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
backupStatus = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.cancelBackup
  L2()
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
backupCancel = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2, L3, L4, L5 = L2(L3)
  L1 = L1(L2, L3, L4, L5)
  if L1 == 1 then
    L1 = true
    if L1 then
      goto lbl_16
    end
  end
  L1 = false
  ::lbl_16::
  L2 = {}
  L2.code = 0
  L3 = L0.usbMode
  L3 = L3()
  if L3 then
    L2.usb = 1
  else
    L2.usb = 0
  end
  if L1 then
    if not L3 then
      L4 = os
      L4 = L4.execute
      L5 = "/etc/init.d/usb_deploy_init_script.sh start >/dev/null 2>/dev/null"
      L4(L5)
    end
  elseif L3 then
    L4 = os
    L4 = L4.execute
    L5 = "/etc/init.d/usb_deploy_init_script.sh stop >/dev/null 2>/dev/null; echo 3 > /proc/sys/vm/drop_caches"
    L4(L5)
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
usbServiceSwitch = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.usbMode
  L2 = L2()
  if L2 then
    L1.usb = 1
  else
    L1.usb = 0
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
usbmode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "data"
  L5 = L5(L6)
  L6 = L0.isStrNil
  L7 = L5
  L6 = L6(L7)
  if L6 then
    L4.code = 1523
  else
    L6 = string
    L6 = L6.format
    L7 = "matool --method dec --params \"%s\""
    L8 = L0._cmdformat
    L9 = L5
    L8, L9, L10, L11, L12, L13, L14, L15, L16 = L8(L9)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
    L7 = L2.trim
    L8 = L2.exec
    L9 = L6
    L8, L9, L10, L11, L12, L13, L14, L15, L16 = L8(L9)
    L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
    L8 = pcall
    L9 = L1.decode
    L10 = L7
    L8, L9 = L8(L9, L10)
    if not L8 then
      L4.code = 1523
    else
      L10 = L0.isStrNil
      L11 = L9.sid
      L10 = L10(L11)
      if not L10 then
        L10 = L0.isStrNil
        L11 = L9.key
        L10 = L10(L11)
        if not L10 then
          goto lbl_60
        end
      end
      L4.code = 1523
      goto lbl_71
      ::lbl_60::
      L11 = L3
      L10 = L3.section
      L12 = "mipayment"
      L13 = "sid"
      L14 = L9.sid
      L15 = {}
      L16 = L9.key
      L15.key = L16
      L10(L11, L12, L13, L14, L15)
      L11 = L3
      L10 = L3.commit
      L12 = "mipayment"
      L10(L11, L12)
    end
  end
  ::lbl_71::
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
setPaymentInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "sid"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "digest"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = L0.isStrNil
  L7 = L3
  L6 = L6(L7)
  if not L6 then
    L6 = L0.isStrNil
    L7 = L4
    L6 = L6(L7)
    if not L6 then
      goto lbl_34
    end
  end
  L5.code = 1523
  goto lbl_62
  ::lbl_34::
  L7 = L2
  L6 = L2.get
  L8 = "mipayment"
  L9 = L3
  L10 = "key"
  L6 = L6(L7, L8, L9, L10)
  L7 = L0.isStrNil
  L8 = L6
  L7 = L7(L8)
  if L7 then
    L5.code = 1636
  else
    L7 = string
    L7 = L7.format
    L8 = "matool --method signOrder --params \"%s\" \"%s\""
    L9 = L0._cmdformat
    L10 = L6
    L9 = L9(L10)
    L10 = L0._cmdformat
    L11 = L4
    L10, L11 = L10(L11)
    L7 = L7(L8, L9, L10, L11)
    L8 = L1.trim
    L9 = L1.exec
    L10 = L7
    L9, L10, L11 = L9(L10)
    L8 = L8(L9, L10, L11)
    L5.signature = L8
  end
  ::lbl_62::
  L6 = L5.code
  if L6 ~= 0 then
    L6 = _UPVALUE1_
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
signOrder = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQNetworkNetDiagnose"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.asyncNetDiag
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
netDiagnoseStart = L4
function L4()
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
netDiagnoseResult = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.exec
  L3 = "echo 0 > /tmp/upgraded_result"
  L2(L3)
  L1.code = 0
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
clearUpgradeResult = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "ubus"
  L2 = L2(L3)
  L2 = L2.connect
  L2 = L2()
  L3 = {}
  L3.registration = "0"
  L3.level = "0"
  L3.code = "0"
  L5 = L2
  L4 = L2.call
  L6 = "mobile"
  L7 = "net"
  L8 = {}
  L8.method = "use_default"
  L4(L5, L6, L7, L8)
  L4 = L0.exec
  L5 = "sleep 3"
  L4(L5)
  L5 = L2
  L4 = L2.call
  L6 = "mobile"
  L7 = "status"
  L8 = {}
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = L4.registration
    if L5 then
      L5 = L4.registration
      if L5 == 1 then
        L5 = tostring
        L6 = L4.registration
        L5 = L5(L6)
        L3.registration = L5
        L5 = tostring
        L6 = L4.level
        L5 = L5(L6)
        L3.level = L5
      end
    end
  end
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L3
  L5(L6)
end
getRegisterStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L1 = L1.connect
  L1 = L1()
  L2 = {}
  L2.status = "0"
  L2.code = "0"
  L4 = L1
  L3 = L1.call
  L5 = "mobile"
  L6 = "sim"
  L7 = {}
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = L3.status
    if L4 then
      L4 = tostring
      L5 = L3.status
      L4 = L4(L5)
      L2.status = L4
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
getSimStatus = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2, L3, L4, L5, L6, L7, L8 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  if L1 == 1 then
    L1 = "1"
    if L1 then
      goto lbl_18
    end
  end
  L1 = "0"
  ::lbl_18::
  L2 = {}
  L2.code = 0
  L4 = L0
  L3 = L0.set
  L5 = "wireless"
  L6 = "wps"
  L7 = "enable"
  L8 = L1
  L3(L4, L5, L6, L7, L8)
  L4 = L0
  L3 = L0.commit
  L5 = "wireless"
  L3(L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
setWpsEnabled = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.exec
  L4 = "pgrep -l -f QLog|awk '{print $1}'"
  L3 = L3(L4)
  if L3 then
    L4 = os
    L4 = L4.execute
    L5 = "kill "
    L6 = L0.trim
    L7 = L3
    L6 = L6(L7)
    L5 = L5 .. L6
    L4(L5)
  end
  L4 = L1.forkExec
  L5 = "/usr/sbin/qlog_daemon.sh"
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
modemLogdStart = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.exec
  L3 = "pgrep -l -f QLog|awk '{print $1}'"
  L2 = L2(L3)
  if L2 then
    L3 = os
    L3 = L3.execute
    L4 = "kill "
    L5 = L0.trim
    L6 = L2
    L5 = L5(L6)
    L4 = L4 .. L5
    L3(L4)
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
modemLogdStop = L4
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "ftype"
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L3 = L3 or L3
  L4 = L0.portForwardInfo
  L4 = L4()
  L4 = L4.status
  L2.status = L4
  L4 = L0.portForwards
  L5 = L3
  L4 = L4(L5)
  L2.list = L4
  L4 = L1.getLanMask
  L4 = L4()
  L2.lanmask = L4
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
portForward = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L2.xssCheck
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ip"
  L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "name"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "proto"
  L7, L8, L9, L10, L11, L12, L13, L14 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "sport"
  L8, L9, L10, L11, L12, L13, L14 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "dport"
  L9, L10, L11, L12, L13, L14 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14)
  L9 = L1.setPortForward
  L10 = L5
  L11 = L4
  L12 = L7
  L13 = L8
  L14 = L6
  L9 = L9(L10, L11, L12, L13, L14)
  L10 = L0.check
  L11 = 0
  L12 = L0.KEY_FUNC_PORTFADD
  L13 = 1
  L10(L11, L12, L13)
  if L9 == 1 then
    L3.code = 1537
  elseif L9 == 2 then
    L3.code = 1608
  elseif L9 == 3 then
    L3.code = 1609
  end
  L10 = L3.code
  if L10 ~= 0 then
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L3.code
    L10 = L10(L11)
    L3.msg = L10
  else
    L10 = L1.restart
    L10()
  end
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L3
  L10(L11)
end
addRedirect = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L2.xssCheck
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ip"
  L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "name"
  L5 = L5(L6)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "proto"
  L7, L8, L9, L10, L11, L12, L13, L14 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "fport"
  L8, L9, L10, L11, L12, L13, L14 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "tport"
  L9, L10, L11, L12, L13, L14 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14)
  L9 = L1.setRangePortForward
  L10 = L5
  L11 = L4
  L12 = L7
  L13 = L8
  L14 = L6
  L9 = L9(L10, L11, L12, L13, L14)
  L10 = L0.check
  L11 = 0
  L12 = L0.KEY_FUNC_RANGEFADD
  L13 = 1
  L10(L11, L12, L13)
  if L9 == 1 then
    L3.code = 1537
  elseif L9 == 2 then
    L3.code = 1608
  elseif L9 == 3 then
    L3.code = 1609
  end
  L10 = L3.code
  if L10 ~= 0 then
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L3.code
    L10 = L10(L11)
    L3.msg = L10
  else
    L10 = L1.restart
    L10()
  end
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L3
  L10(L11)
end
addRangeRedirect = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "port"
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "proto"
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  if L2 == 0 then
    L4 = L0.deleteAllPortForward
    L4()
  else
    L4 = L0.deletePortForward
    L5 = L2
    L6 = L3
    L4(L5, L6)
  end
  L4 = L0.restart
  L4()
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L1
  L4(L5)
end
deleteRedirect = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.check
  L4 = 0
  L5 = L0.KEY_FUNC_PORTENABLE
  L6 = 1
  L3(L4, L5, L6)
  L3 = L1.restart
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
redirectApply = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.getDMZInfo
  L2 = L2()
  L3 = L2.status
  L1.status = L3
  L3 = L2.ip
  L1.ip = L3
  L3 = L2.lanip
  L1.lanip = L3
  L3 = L2.lanmask
  L1.lanmask = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getDMZInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQLanWanUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQFeatures"
  L3 = L3(L4)
  L3 = L3.FEATURES
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "ip"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "mac"
  L6 = L6(L7)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "mode"
  L8, L9, L10, L11, L12 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12)
  L7 = L7 or L7
  L8 = L1.setDMZ
  L9 = L7
  L10 = L5
  L11 = L6
  L8 = L8(L9, L10, L11)
  if L8 == 1 then
    L4.code = 1593
  elseif L8 == 2 then
    L4.code = 1592
  elseif L8 == 3 then
    L4.code = 1611
  elseif L8 == 4 then
    L4.code = 1610
  elseif L8 == 5 then
    L9 = L3.system
    L9 = L9.dt_spec
    if L9 then
      L9 = L3.system
      L9 = L9.dt_spec
      if L9 == "1" then
        L4.code = 2705
    end
    else
      L4.code = 2701
    end
  end
  L9 = L0.check
  L10 = 0
  L11 = L0.KEY_FUNC_DMZ
  L12 = 0
  L9(L10, L11, L12)
  L9 = L4.code
  if L9 ~= 0 then
    L9 = _UPVALUE1_
    L9 = L9.getErrorMessage
    L10 = L4.code
    L9 = L9(L10)
    L4.msg = L9
  else
    L9 = L1.dmzReload
    L10 = L7
    L9(L10)
    L9 = L2.multiwanRestart
    L9()
  end
  L9 = _UPVALUE0_
  L9 = L9.write_json
  L10 = L4
  L9(L10)
end
setDMZ = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = L0.check
  L5 = 0
  L6 = L0.KEY_FUNC_DMZ
  L7 = 1
  L4(L5, L6, L7)
  L4 = L1.unsetDMZ
  L5 = L3
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
end
closeDMZ = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "mode"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L2 = L2 or L2
  L3 = L0.dmzReload
  L4 = L2
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
reloadDMZ = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.status = "1"
  L2 = L0.VSInfo
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_vs_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQPortForward"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "name"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "service"
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "protocol"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "export"
  L9 = L9(L10)
  L9 = L9 or L9
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "inport"
  L10 = L10(L11)
  L10 = L10 or L10
  L11 = L3.xssCheck
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "ip"
  L12, L13, L14, L15, L16, L17, L18 = L12(L13)
  L11 = L11(L12, L13, L14, L15, L16, L17, L18)
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
        L13 = L11
        L12 = L12(L13)
        if not L12 then
          goto lbl_72
        end
      end
    end
  end
  L5.code = 1523
  goto lbl_111
  ::lbl_72::
  L12 = L1.checkAddMaxVSNumItem
  L13 = L10
  L12 = L12(L13)
  if L12 == 1 then
    L5.code = 2700
  else
    L12 = L1.setVSRules
    L13 = L6
    L14 = L7
    L15 = L8
    L16 = L9
    L17 = L10
    L18 = L11
    L12 = L12(L13, L14, L15, L16, L17, L18)
    L13 = L0.check
    L14 = 0
    L15 = L0.KEY_FUNC_FIREWALL
    L16 = 1
    L13(L14, L15, L16)
    L13 = L4.ERR_EMPTY
    if L12 == L13 then
      L5.code = 1537
    else
      L13 = L4.ERR_CHECK_FAILED
      if L12 == L13 then
        L5.code = 1608
      else
        L13 = L4.ERR_DMZ_ON
        if L12 == L13 then
          L5.code = 1609
        else
          L13 = L4.ERR_RELATIVE
          if L12 == L13 then
            L5.code = 1804
          end
        end
      end
    end
  end
  ::lbl_111::
  L12 = L5.code
  if L12 ~= 0 then
    L12 = _UPVALUE1_
    L12 = L12.getErrorMessage
    L13 = L5.code
    L12 = L12(L13)
    L5.msg = L12
  else
    L12 = L1.restart
    L12()
  end
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L5
  L12(L13)
end
set_vs_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "name"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "service"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "protocol"
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "export"
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "inport"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = L2.xssCheck
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "ip"
  L10, L11, L12, L13, L14, L15, L16 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16)
  L10 = L1.deleteVSRule
  L11 = L4
  L12 = L5
  L13 = L6
  L14 = L7
  L15 = L8
  L16 = L9
  L10 = L10(L11, L12, L13, L14, L15, L16)
  L11 = L0.check
  L12 = 0
  L13 = L0.KEY_FUNC_FIREWALL
  L14 = 1
  L11(L12, L13, L14)
  L11 = L1.restart
  L11()
  L11 = _UPVALUE0_
  L11 = L11.write_json
  L12 = L3
  L11(L12)
end
del_vs_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.check
  L4 = 0
  L5 = L0.KEY_FUNC_FIREWALL
  L6 = 1
  L3(L4, L5, L6)
  L3 = L1.restart
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
apply_vs_rules = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.status = "1"
  L2 = L0.PTInfo
  L2 = L2()
  L1.list = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_pt_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "name"
  L7 = nil
  L8 = "?commonstr"
  L5 = L5(L6, L7, L8)
  L5 = L5 or L5
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "tgprotocol"
  L8 = nil
  L9 = "?commonstr"
  L6 = L6(L7, L8, L9)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "tgport"
  L9 = nil
  L10 = "?commonstr"
  L7 = L7(L8, L9, L10)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "exprotocol"
  L10 = nil
  L11 = "?commonstr"
  L8 = L8(L9, L10, L11)
  L8 = L8 or L8
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "export"
  L11 = nil
  L12 = "?commonstr"
  L9 = L9(L10, L11, L12)
  L9 = L9 or L9
  L10 = L2.isStrNil
  L11 = L6
  L10 = L10(L11)
  if not L10 then
    L10 = L2.isStrNil
    L11 = L7
    L10 = L10(L11)
    if not L10 then
      L10 = L2.isStrNil
      L11 = L8
      L10 = L10(L11)
      if not L10 then
        L10 = L2.isStrNil
        L11 = L9
        L10 = L10(L11)
        if not L10 then
          goto lbl_82
        end
      end
    end
  end
  L4.code = 1523
  goto lbl_112
  ::lbl_82::
  L10 = L1.checkAddMaxPTNumItem
  L11 = L7
  L10 = L10(L11)
  if L10 == 1 then
    L4.code = 2700
  else
    L10 = L1.setPTRules
    L11 = L5
    L12 = L6
    L13 = L7
    L14 = L8
    L15 = L9
    L10 = L10(L11, L12, L13, L14, L15)
    L11 = L0.check
    L12 = 0
    L13 = L0.KEY_FUNC_FIREWALL
    L14 = 1
    L11(L12, L13, L14)
    if L10 == 1 then
      L4.code = 1537
    elseif L10 == 2 then
      L4.code = 1608
    elseif L10 == 3 then
      L4.code = 2702
    end
  end
  ::lbl_112::
  L10 = L4.code
  if L10 ~= 0 then
    L10 = _UPVALUE1_
    L10 = L10.getErrorMessage
    L11 = L4.code
    L10 = L10(L11)
    L4.msg = L10
  else
    L10 = L1.trigger_add
    L11 = L5
    L12 = L6
    L13 = L7
    L14 = L8
    L15 = L9
    L10(L11, L12, L13, L14, L15)
  end
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L4
  L10(L11)
end
set_pt_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSecureUtil"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "name"
  L6 = nil
  L7 = "?commonstr"
  L4 = L4(L5, L6, L7)
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "tgprotocol"
  L7 = nil
  L8 = "?commonstr"
  L5 = L5(L6, L7, L8)
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "tgport"
  L8 = nil
  L9 = "?commonstr"
  L6 = L6(L7, L8, L9)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "exprotocol"
  L9 = nil
  L10 = "?commonstr"
  L7 = L7(L8, L9, L10)
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "export"
  L10 = nil
  L11 = "?commonstr"
  L8 = L8(L9, L10, L11)
  L8 = L8 or L8
  L9 = L1.deletePTRule
  L10 = L4
  L11 = L5
  L12 = L6
  L13 = L7
  L14 = L8
  L9 = L9(L10, L11, L12, L13, L14)
  L10 = L0.check
  L11 = 0
  L12 = L0.KEY_FUNC_FIREWALL
  L13 = 1
  L10(L11, L12, L13)
  L10 = L1.trigger_del
  L11 = L4
  L12 = L5
  L13 = L6
  L14 = L7
  L15 = L8
  L10(L11, L12, L13, L14, L15)
  L10 = _UPVALUE0_
  L10 = L10.write_json
  L11 = L3
  L10(L11)
end
del_pt_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = L0.check
  L4 = 0
  L5 = L0.KEY_FUNC_FIREWALL
  L6 = 1
  L3(L4, L5, L6)
  L3 = L1.restart
  L3()
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
apply_pt_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "pptp"
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L4 = tonumber
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "l2tp"
  L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L5(L6)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ipsec"
  L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L6 = tonumber
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "sip"
  L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L7(L8)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L7 = tonumber
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "ftp"
  L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L8(L9)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L8 = tonumber
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "tftp"
  L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L9 = tonumber
  L10 = _UPVALUE0_
  L10 = L10.formvalue
  L11 = "rtsp"
  L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L10(L11)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L10 = tonumber
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "h323"
  L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L11 = L1.setALGFirewall
  L12 = L3
  L13 = L4
  L14 = L5
  L15 = L6
  L16 = L7
  L17 = L8
  L18 = L9
  L19 = L10
  L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
  L12 = L1.restart
  L12()
  L12 = _UPVALUE0_
  L12 = L12.write_json
  L13 = L2
  L12(L13)
  L12 = L0.check
  L13 = 0
  L14 = L0.KEY_FUNC_FIREWALL
  L15 = 1
  L12(L13, L14, L15)
end
set_alg_rules = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L1.status = "1"
  L2 = L0.ALGInfo
  L2 = L2()
  L1.alg_status = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_alg_rules = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "firewall_enable"
  L4 = L4(L5)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = L1.setFirewallEnable
  L5 = L3
  L4 = L4(L5)
  L5 = L1.restart
  L5()
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
  L5 = L0.check
  L6 = 0
  L7 = L0.KEY_FUNC_FIREWALL
  L8 = 1
  L5(L6, L7, L8)
end
set_firewall_enable = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.FirewallInfo
  L2 = L2()
  L2 = L2.firewall_enable
  L1.firewall_enable = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_firewall_enable = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "spi_firewall"
  L4, L5, L6, L7, L8 = L4(L5)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = L1.setSPIFirewall
  L5 = L3
  L4 = L4(L5)
  L5 = L1.restart
  L5()
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
  L5 = L0.check
  L6 = 0
  L7 = L0.KEY_FUNC_FIREWALL
  L8 = 1
  L5(L6, L7, L8)
end
set_spi_firewall = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.FirewallInfo
  L2 = L2()
  L2 = L2.spi_firewall
  L1.spi_firewall = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_spi_firewall = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = pcall
  L1 = require
  L2 = "luci.controller.anti_attack.index"
  L0, L1 = L0(L1, L2)
  if L0 then
    L2 = _UPVALUE0_
    L2 = L2.write_json
    L3 = {}
    L4 = L1.set_dos
    L5 = _UPVALUE0_
    L5 = L5.formvalue
    L6 = "dos_firewall"
    L5 = L5(L6)
    if L5 == "1" then
      L5 = true
      if L5 then
        goto lbl_21
      end
    end
    L5 = false
    ::lbl_21::
    L4 = L4(L5)
    L3.code = L4
    L2(L3)
    return
  end
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.module.XQFirewall"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = tonumber
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "dos_firewall"
  L6, L7, L8, L9, L10 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10)
  L6 = L3.setDoSFirewall
  L7 = L5
  L6 = L6(L7)
  L7 = L3.reload
  L7()
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L4
  L7(L8)
  L7 = L2.check
  L8 = 0
  L9 = L2.KEY_FUNC_FIREWALL
  L10 = 1
  L7(L8, L9, L10)
end
set_dos_firewall = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = pcall
  L1 = require
  L2 = "luci.controller.anti_attack.index"
  L0, L1 = L0(L1, L2)
  if L0 then
    L2 = L1.get_status
    L2 = L2()
    L3 = {}
    L3.code = 0
    L4 = L2.dos
    if L4 == 1 then
      L4 = "1"
      if L4 then
        goto lbl_18
      end
    end
    L4 = "0"
    ::lbl_18::
    L3.dos_firewall = L4
    return L3
  end
  L2 = require
  L3 = "xiaoqiang.module.XQFirewall"
  L2 = L2(L3)
  L3 = {}
  L3.code = 0
  L4 = L2.FirewallInfo
  L4 = L4()
  L4 = L4.dos_firewall
  L3.dos_firewall = L4
  return L3
end
get_dos_firewall_data = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.write_json
  L1 = get_dos_firewall_data
  L1 = L1()
  L0(L1)
end
get_dos_firewall = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L2.code = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "wanping_firewall"
  L4 = L4(L5)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = L1.setWANPingFirewall
  L5 = L3
  L4 = L4(L5)
  L5 = L1.restart
  L5()
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = L2
  L5(L6)
  L5 = L0.check
  L6 = 0
  L7 = L0.KEY_FUNC_FIREWALL
  L8 = 1
  L5(L6, L7, L8)
end
set_wanping_firewall = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.module.XQFirewall"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = L0.FirewallInfo
  L2 = L2()
  L2 = L2.wanping_firewall
  L1.wanping_firewall = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_wanping_firewall = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = L1.getMacfilterInfo
  L2 = L2()
  L2.code = 0
  L3 = tonumber
  L5 = L0
  L4 = L0.get
  L6 = "macfilter"
  L7 = "wan"
  L8 = "maxrulenum"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L2.limit = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
get_macfilter_info = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "filter"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = {}
  L5.code = 0
  L7 = L0
  L6 = L0.get
  L8 = "macfilter"
  L9 = L3
  L10 = "enable"
  L6 = L6(L7, L8, L9, L10)
  L7 = L1.setmacfilterenablemode
  L8 = L2
  L9 = L4
  L10 = L3
  L7 = L7(L8, L9, L10)
  L5.code = L7
  L7 = L5.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L5.code
    L7 = L7(L8)
    L5.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
set_macfilter_enable_mode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
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
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = {}
  L4.code = 0
  L5 = _UPVALUE0_
  L5 = L5.formvalue
  L6 = "mac"
  L7 = nil
  L8 = {}
  L8.name = "regex"
  L8.arg = "^[0-9a-fA-F:;]+$"
  L5 = L5(L6, L7, L8)
  L6 = ""
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "name"
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "option"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = 0
  L10 = 0
  L11 = ""
  if L12 then
    L4.code = 1523
  else
    L15 = ";"
    L15, L16, L20, L21, L22 = L13(L14, L15)
    for L15, L16 in L12, L13, L14 do
      if not L17 then
        if L17 then
          goto lbl_69
        end
      end
      L4.code = 1523
      do break end
      ::lbl_69::
    end
    L15 = ";"
    L15, L16, L20, L21, L22 = L13(L14, L15)
    for L15, L16 in L12, L13, L14 do
      L9 = L9 + 1
      L10 = 0
      L11 = ""
      L20 = ";"
      L20, L21, L22 = L18(L19, L20)
      for L20, L21 in L17, L18, L19 do
        L10 = L10 + 1
        if L9 == L10 then
          L11 = L21
          break
        end
      end
      if 0 == L17 then
        L20 = L8
        L21 = L6
        L4.code = L17
        if 0 ~= L17 then
          break
        end
      end
    end
  end
  if L12 ~= 0 then
    L4.msg = L12
  end
  L12(L13)
end
set_macfilter_rules = L4
function L4()
  local L0, L1
  L0 = setMacFilter
  L0()
end
set_macfilter_rule = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = L1.getIpfilterInfo
  L2 = L2()
  L2.code = 0
  L3 = tonumber
  L5 = L0
  L4 = L0.get
  L6 = "ipfilter"
  L7 = "wan"
  L8 = "maxrulenum"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L2.limit = L3
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
get_ipfilter_info = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "enable"
  L2 = L2(L3)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "filter"
  L3 = L3(L4)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "mode"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = {}
  L5.code = 0
  L7 = L0
  L6 = L0.get
  L8 = "ipfilter"
  L9 = L3
  L10 = "enable"
  L6 = L6(L7, L8, L9, L10)
  L7 = L1.setipfilterenablemode
  L8 = L2
  L9 = L4
  L10 = L3
  L7 = L7(L8, L9, L10)
  L5.code = L7
  L7 = L5.code
  if L7 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.getErrorMessage
    L8 = L5.code
    L7 = L7(L8)
    L5.msg = L7
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L5
  L7(L8)
end
set_ipfilter_enable_mode = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQFirewall"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = {}
  L5.code = 0
  L6 = _UPVALUE0_
  L6 = L6.formvalue
  L7 = "ipaddr"
  L8 = nil
  L9 = {}
  L9.name = "regex"
  L9.arg = "^[0-9a-fA-F.;]+$"
  L6 = L6(L7, L8, L9)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.formvalue
  L8 = "ipaddrv6"
  L9 = nil
  L10 = {}
  L10.name = "regex"
  L10.arg = "^[0-9a-fA-F:;]+$"
  L7 = L7(L8, L9, L10)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "name"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "export"
  L9 = L9(L10)
  L9 = L9 or L9
  L10 = string
  L10 = L10.lower
  L11 = _UPVALUE0_
  L11 = L11.formvalue
  L12 = "protocol"
  L13 = nil
  L14 = "?commonstr"
  L11 = L11(L12, L13, L14)
  L11 = L11 or L11
  L10 = L10(L11)
  L12 = L0
  L11 = L0.get
  L13 = "ipfilter"
  L14 = "wan"
  L15 = "mode"
  L11 = L11(L12, L13, L14, L15)
  if L11 == "black" then
    L11 = "0"
    if L11 then
      goto lbl_79
    end
  end
  L11 = "1"
  ::lbl_79::
  L12 = _UPVALUE0_
  L12 = L12.formvalue
  L13 = "option"
  L12 = L12(L13)
  L12 = L12 or L12
  L13 = 0
  L14 = 0
  L15 = ""
  L16 = #L6
  L17 = #L7
  if L18 then
    if L18 then
      L5.code = 1523
  end
  else
    if not L18 then
      if not L18 then
        L5.code = 1523
    end
    else
      if L12 == "0" then
        if L18 == 1 then
          L5.code = 2700
      end
      else
        if 0 < L16 then
          L21 = ";"
          L21, L22, L26, L27, L28, L29 = L19(L20, L21)
          for L21, L22 in L18, L19, L20 do
            L16 = #L22
            if 0 < L16 then
              if not L23 then
                if L23 then
                  goto lbl_148
                end
              end
              L5.code = 1523
              break
            end
            ::lbl_148::
          end
          L13 = 0
          L21 = ";"
          L21, L22, L26, L27, L28, L29 = L19(L20, L21)
          for L21, L22 in L18, L19, L20 do
            L13 = L13 + 1
            L14 = 0
            L15 = ""
            L26 = ";"
            L26, L27, L28, L29 = L24(L25, L26)
            for L26, L27 in L23, L24, L25 do
              L14 = L14 + 1
              if L13 == L14 then
                L15 = L27
                break
              end
            end
            if 0 == L23 then
              L26 = L9
              L27 = L11
              L28 = L15
              L29 = L12
              L23(L24, L25, L26, L27, L28, L29)
            end
          end
        end
        if 0 < L17 then
          L21 = ";"
          L21, L22, L26, L27, L28, L29 = L19(L20, L21)
          for L21, L22 in L18, L19, L20 do
            L17 = #L22
            if 0 < L17 then
              if not L23 then
                if L23 then
                  goto lbl_212
                end
              end
              L5.code = 1523
              break
            end
            ::lbl_212::
          end
          L13 = 0
          L21 = ";"
          L21, L22, L26, L27, L28, L29 = L19(L20, L21)
          for L21, L22 in L18, L19, L20 do
            L13 = L13 + 1
            L14 = 0
            L15 = ""
            L26 = ";"
            L26, L27, L28, L29 = L24(L25, L26)
            for L26, L27 in L23, L24, L25 do
              L14 = L14 + 1
              if L13 == L14 then
                L15 = L27
                break
              end
            end
            if 0 == L23 then
              L26 = L9
              L27 = L11
              L28 = L15
              L29 = L12
              L23(L24, L25, L26, L27, L28, L29)
            end
          end
        end
      end
    end
  end
  if L18 ~= 0 then
    L5.msg = L18
  end
  L18(L19)
end
set_ipfilter_rules = L4
function L4()
  local L0, L1
  L0 = setIpFilter
  L0()
end
set_ipfilter_rule = L4
function L4()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L1.code = 0
  L2 = tonumber
  L3 = L0.get_wifi_split_status
  L3 = L3()
  L2 = L2(L3)
  if L2 == 1 then
    L2 = 1
    if L2 then
      goto lbl_16
    end
  end
  L2 = 0
  ::lbl_16::
  L1.wifi_split = L2
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
getWifiSplit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "wifi_split"
  L3 = L3(L4)
  L4 = 60
  L5 = {}
  L5.code = 0
  L6 = L1.isStrNil
  L7 = L3
  L6 = L6(L7)
  if L6 then
    L5.code = 2540
    L6 = _UPVALUE1_
    L6 = L6.getErrorMessage
    L7 = L5.code
    L6 = L6(L7)
    L5.msg = L6
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L7 = L5
    L6(L7)
  else
    L5.code = 0
    L6 = tonumber
    L7 = L3
    L6 = L6(L7)
    if L6 == 1 then
      L6 = 1
      if L6 then
        goto lbl_43
        L3 = L6 or L3
      end
    end
    L3 = 0
    ::lbl_43::
    L6 = tonumber
    L7 = L2.get_wifi_split_status
    L7, L8, L9 = L7()
    L6 = L6(L7, L8, L9)
    if L3 ~= L6 then
      L4 = 60
    else
      L4 = 0
    end
    L5.time = L4
    L7 = _UPVALUE0_
    L7 = L7.write_json
    L8 = L5
    L7(L8)
    if L3 ~= L6 then
      L7 = string
      L7 = L7.format
      L8 = "/usr/sbin/set_5g_split %d"
      L9 = L3
      L7 = L7(L8, L9)
      L8 = L1.forkExec
      L9 = L7
      L8(L9)
    end
  end
end
setWifiSplit = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.sys"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQNetUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "uid"
  L5 = nil
  L6 = "?numberstr"
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "key"
  L6 = nil
  L7 = "?engXnumstr"
  L4 = L4(L5, L6, L7)
  L4 = L4 or L4
  L5 = string
  L5 = L5.format
  L6 = "/usr/bin/miio_bind.sh -u '%s' -b '%s'"
  L7 = L3
  L8 = L4
  L5 = L5(L6, L7, L8)
  L6 = {}
  L6.code = 0
  if L3 == "" or L4 == "" then
    L6.code = 1523
  else
    L7 = L0.call
    L8 = L5
    L7 = L7(L8)
    if L7 ~= 0 then
      L6.code = 1541
    end
  end
  L7 = L6.code
  if L7 == 0 then
    L7 = _UPVALUE1_
    L7 = L7.getHardware
    L7 = L7()
    L6.hw = L7
    L7 = L1.trim
    L8 = L1.exec
    L9 = "get_miot_did.sh"
    L8, L9 = L8(L9)
    L7 = L7(L8, L9)
    L6.did = L7
    L7 = L2.getDeviceId
    L7 = L7()
    L6.rtid = L7
    L6.sync = false
  end
  L7 = _UPVALUE0_
  L7 = L7.write_json
  L8 = L6
  L7(L8)
end
startBinding = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = "0"
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L3.code = 0
  L3.msg = "succces"
  L4 = {}
  L4.off_gw = 0
  L4.all_gw = 0
  L4.off_risk = 0
  L4.all_risk = 0
  L4.off_log = 1
  L4.all_log = 1
  L4.ipmaccheck = 0
  L3.info = L4
  L4 = L0.apps
  L4 = L4.local_gw_security
  if L4 == "1" then
    L4 = L3.info
    L5 = L3.info
    L5 = L5.all_gw
    L5 = L5 + 1
    L4.all_gw = L5
    L5 = L2
    L4 = L2.get
    L6 = "local_gw_security"
    L7 = "settings"
    L8 = "enabled"
    L4 = L4(L5, L6, L7, L8)
    L1 = L4 or L1
    if not L4 then
      L1 = "0"
    end
    if L1 ~= "1" then
      L4 = L3.info
      L5 = L3.info
      L5 = L5.off_gw
      L5 = L5 + 1
      L4.off_gw = L5
    end
  end
  L4 = L3.info
  L5 = L3.info
  L5 = L5.all_gw
  L5 = L5 + 1
  L4.all_gw = L5
  L4 = get_dos_firewall_data
  L4 = L4()
  L4 = L4.dos_firewall
  if L4 ~= "1" then
    L4 = L3.info
    L5 = L3.info
    L5 = L5.off_gw
    L5 = L5 + 1
    L4.off_gw = L5
  end
  L4 = pcall
  L5 = require
  L6 = "luci.controller.anti_attack.index"
  L4, L5 = L4(L5, L6)
  if L4 then
    L6 = L3.info
    L7 = L3.info
    L7 = L7.all_gw
    L7 = L7 + 1
    L6.all_gw = L7
    L6 = L5.get_status
    L6 = L6()
    L7 = L6.scan
    if L7 ~= 1 then
      L7 = L3.info
      L8 = L3.info
      L8 = L8.off_gw
      L8 = L8 + 1
      L7.off_gw = L8
    end
  end
  L6 = pcall
  L7 = require
  L8 = "luci.controller.url_fw.index"
  L6, L7 = L6(L7, L8)
  if L6 then
    L8 = L3.info
    L9 = L3.info
    L9 = L9.all_risk
    L9 = L9 + 1
    L8.all_risk = L9
    L9 = L2
    L8 = L2.get
    L10 = "antiy_url_policy"
    L11 = "meta"
    L12 = "enable"
    L8 = L8(L9, L10, L11, L12)
    L1 = L8 or L1
    if not L8 then
      L1 = "0"
    end
    if L1 ~= "1" then
      L8 = L3.info
      L9 = L3.info
      L9 = L9.off_risk
      L9 = L9 + 1
      L8.off_risk = L9
    end
  end
  L9 = L2
  L8 = L2.get
  L10 = "milog"
  L11 = "global"
  L12 = "enable"
  L8 = L8(L9, L10, L11, L12)
  L1 = L8 or L1
  if not L8 then
    L1 = "0"
  end
  if L1 == "1" then
    L8 = L3.info
    L9 = L3.info
    L9 = L9.off_log
    L9 = L9 - 1
    L8.off_log = L9
  end
  L8 = L0.system
  L8 = L8.ipmaccheck
  if L8 ~= nil then
    L8 = L0.system
    L8 = L8.ipmaccheck
    if L8 == "1" then
      L8 = L3.info
      L9 = L3.info
      L9 = L9.all_gw
      L9 = L9 + 1
      L8.all_gw = L9
      L9 = L2
      L8 = L2.get
      L10 = "firewall"
      L11 = "ipmacBind"
      L12 = "status"
      L8 = L8(L9, L10, L11, L12)
      L1 = L8 or L1
      if not L8 then
        L1 = "off"
      end
      if L1 == "on" then
        L8 = L3.info
        L8.ipmaccheck = 1
      else
        L8 = L3.info
        L9 = L3.info
        L9 = L9.off_gw
        L9 = L9 + 1
        L8.off_gw = L9
      end
    end
  end
  L8 = _UPVALUE0_
  L8 = L8.write_json
  L9 = L3
  L8(L9)
end
secCenterStatus = L4
