local L0, L1, L2, L3, L4, L5
L0 = module
L1 = "luci.controller.service.datacenter"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = node
  L1 = "service"
  L2 = "datacenter"
  L0 = L0(L1, L2)
  L1 = firstchild
  L1 = L1()
  L0.target = L1
  L0.title = ""
  L0.order = nil
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "request"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "tunnelRequest"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "download_file"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "downloadFile"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "device_id"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getDeviceID"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "download_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getDownloadInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "upload_file"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "uploadFile"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "batch_download_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getBatchDownloadInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "config_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getConfigInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "set_config"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "setConfigInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "plugin_enable"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "enablePlugin"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "plugin_download_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "pluginDownloadInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "plugin_disable"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "disablePlugin"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "plugin_control"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "controlPlugin"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "feature_plugin_control"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "controlFeaturePlugin"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "download_delete"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "deleteDownload"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_plugin_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "pluginStatus"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_connected_device"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "connectedDevice"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_router_mac"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getMac"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "set_wan_access"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "setWanAccess"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_router_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getRouterInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "xunlei_notify"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "xunleiNotify"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_routerIP"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getRouterIP"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "multi_create"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "MultiCreate"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "run_command"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "RunCommand"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "idforvendor"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "idforvendor"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 17
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "media_delta"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "mediaDelta"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "media_metadata"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "mediaMetadata"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "share_miui_dir"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "shareMiuiBackupDir"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_file_list"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getFileList"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_storage_info"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getStorageInfo"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_youku_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getYoukuStatus"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "get_camera_smbpath"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getCameraSmbPath"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "bind_youku_appid"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "bindYoukuAppid"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "is_has_disk"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "isHasDisk"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 8
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "datacenter"
  L5 = "set_sync_router_file"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "setSyncRouterFile"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = nil
  L6 = 8
  L1(L2, L3, L4, L5, L6)
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "service.util.ServiceErrorUtil"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = "2882303761517280984"
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "sources"
  L1 = L1(L2)
  L2 = L0.decode
  L3 = L1
  L2 = L2(L3)
  L3 = {}
  L3.api = 118
  L3.sources = L2
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "remote_router_id"
  L4 = L4(L5)
  L3.remote_router_id = L4
  L4 = tunnelRequestDatacenter
  L5 = L3
  L4(L5)
end
setSyncRouterFile = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = L1.binaryBase64Enc
  L3 = _UPVALUE0_
  L3 = L3.formvalue_unsafe
  L4 = "payload"
  L3, L4, L5, L6, L7, L8, L9 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L3 = _UPVALUE1_
  L3 = L3.THRIFT_TUNNEL_TO_DATACENTER
  L3 = L3 % L2
  L4 = L0.exec
  L5 = L3
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.write
  L6 = L4
  L7 = nil
  L8 = false
  L9 = true
  L5(L6, L7, L8, L9)
end
tunnelRequest = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 122
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
isHasDisk = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 115
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L0.mac = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getCameraSmbPath = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 17
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getStorageInfo = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 3
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "path"
  L1 = L1(L2)
  L0.path = L1
  L0.sharedOnly = true
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getFileList = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 629
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
idforvendor = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1202
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "path"
  L1 = L1(L2)
  L0.path = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "thumb_size"
  L1 = L1(L2)
  L0.thumb_size = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
mediaMetadata = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1201
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "cursor"
  L1 = L1(L2)
  L0.cursor = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "len"
  L1 = L1(L2)
  L0.len = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
mediaDelta = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1112
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getRouterIP = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 100
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L0.mac = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
shareMiuiBackupDir = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 519
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "tasks"
  L1 = L1(L2)
  L0.info = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
xunleiNotify = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 625
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "command"
  L1 = L1(L2)
  L0.command = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
RunCommand = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 520
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "urls"
  L1 = L1(L2)
  L0.urls = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "pathForUserData"
  L1 = L1(L2)
  L0.pathForUserData = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
MultiCreate = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = L1.encode
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = L3.binaryBase64Enc
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = _UPVALUE0_
  L4 = L4.THRIFT_TUNNEL_TO_DATACENTER
  L4 = L4 % A0
  L5 = _UPVALUE1_
  L5 = L5.write
  L6 = L2.exec
  L7 = L4
  L6, L7 = L6(L7)
  L5(L6, L7)
end
tunnelRequestDatacenter = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "cjson"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = L1.encode
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = L3.binaryBase64Enc
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  L4 = _UPVALUE0_
  L4 = L4.THRIFT_TUNNEL_TO_DATACENTER
  L4 = L4 % A0
  L5 = L2.exec
  L6 = L4
  return L5(L6)
end
requestDatacenter = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1101
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "path"
  L1 = L1(L2)
  L0.path = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "url"
  L1 = L1(L2)
  L0.url = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "downloadName"
  L1 = L1(L2)
  L0.name = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "tag"
  L1 = L1(L2)
  L0.tag = L1
  L0.hidden = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "hidden"
  L1 = L1(L2)
  if L1 == "true" then
    L0.hidden = true
  end
  L0.redownload = 0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "redownload"
  L1 = L1(L2)
  if L1 == "1" then
    L0.redownload = 1
  end
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "dupId"
  L1 = L1(L2)
  L0.dupId = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "pathForUserData"
  L1 = L1(L2)
  L0.pathForUserData = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
downloadFile = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 618
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "mac"
  L1 = L1(L2)
  L0.mac = L1
  L0.enable = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "enable"
  L1 = L1(L2)
  if L1 == "true" then
    L0.enable = true
  end
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
setWanAccess = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1103
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getDeviceID = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 617
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getMac = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 622
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getRouterInfo = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L0.api = 1103
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = requestDatacenter
  L2 = L0
  L1 = L1(L2)
  if L1 then
    L2 = require
    L3 = "cjson"
    L2 = L2(L3)
    L3 = L2.decode
    L4 = L1
    L3 = L3(L4)
    L1 = L3
    if L1 then
      L3 = L1.code
      if L3 == 0 then
        L3 = L1.deviceid
        if L3 then
          L4 = 0
          L5 = L3
          return L4, L5
        end
      else
        L3 = L1.code
        if L3 == 5 then
          L3 = 5
          L4 = nil
          return L3, L4
        end
      end
    end
  end
  L2 = 1559
  L3 = nil
  return L2, L3
end
getOperateDeviceID = L5
function L5(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = "\n"
    L4 = "\r\n"
    L1 = L1(L2, L3, L4)
    A0 = L1
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = "([^0-9a-zA-Z/])"
    function L4(A0)
      local L1, L2, L3, L4
      L1 = string
      L1 = L1.format
      L2 = "%%%02X"
      L3 = string
      L3 = L3.byte
      L4 = A0
      L3, L4 = L3(L4)
      return L1(L2, L3, L4)
    end
    L1 = L1(L2, L3, L4)
    A0 = L1
  end
  return A0
end
urlEncode = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6
  if A0 then
    L1 = urlEncode
    L2 = A0
    L1 = L1(L2)
    A0 = L1
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = "^/userdisk/data/"
    L4 = "http://miwifi.com/api-third-party/download/public/"
    L1, L2 = L1(L2, L3, L4)
    if L2 == 1 then
      return L1
    end
    L3 = string
    L3 = L3.gsub
    L4 = A0
    L5 = "^/userdisk/appdata/"
    L6 = "http://miwifi.com/api-third-party/download/private/"
    L3, L4 = L3(L4, L5, L6)
    L2 = L4
    L1 = L3
    if L2 == 1 then
      return L1
    end
    L3 = string
    L3 = L3.gsub
    L4 = A0
    L5 = "^/extdisks/"
    L6 = "http://miwifi.com/api-third-party/download/extdisks/"
    L3, L4 = L3(L4, L5, L6)
    L2 = L4
    L1 = L3
    if L2 == 1 then
      return L1
    end
  end
  L1 = nil
  return L1
end
generateUrlFromPath = L5
function L5(A0)
  local L1, L2, L3
  L1 = {}
  L1.code = A0
  L2 = _UPVALUE0_
  L2 = L2.getErrorMessage
  L3 = A0
  L2 = L2(L3)
  L1.msg = L2
  return L1
end
generateResponseFromCode = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = {}
  L1.api = 1102
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appId"
  L2 = L2(L3)
  L1.appid = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "deviceId"
  L2 = L2(L3)
  L1.deviceId = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "downloadId"
  L2 = L2(L3)
  L1.downloadId = L2
  L1.hidden = false
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "hidden"
  L2 = L2(L3)
  if L2 == "true" then
    L1.hidden = true
  end
  L2 = {}
  L3 = requestDatacenter
  L4 = L1
  L3 = L3(L4)
  if L3 then
    L4 = L0.decode
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    if L3 then
      L4 = L3.code
      if L4 == 0 then
        L4 = generateUrlFromPath
        L5 = L3.path
        L4 = L4(L5)
        if L4 then
          L5 = L3.code
          L2.code = L5
          L5 = L3.msg
          L2.msg = L5
          L2.url = L4
        else
          L5 = generateResponseFromCode
          L6 = 1559
          L5 = L5(L6)
          L2 = L5
        end
    end
    else
      L2 = L3
    end
  else
    L4 = generateResponseFromCode
    L5 = 1559
    L4 = L4(L5)
    L2 = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L2
  L4(L5)
  L4 = _UPVALUE0_
  L4 = L4.close
  L4()
end
getDownloadInfo = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.fs"
  L2 = L2(L3)
  L3 = "/userdisk/data/upload.tmp"
  L4 = L2.isfile
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = L2.unlink
    L5 = L3
    L4(L5)
  end
  L4 = nil
  L5 = _UPVALUE0_
  L5 = L5.setfilehandler
  function L6(A0, A1, A2)
    local L3, L4, L5, L6
    L3 = _UPVALUE0_
    if not L3 and A0 then
      L3 = A0.name
      if L3 == "file" then
        L3 = io
        L3 = L3.open
        L4 = _UPVALUE1_
        L5 = "w"
        L3 = L3(L4, L5)
        _UPVALUE0_ = L3
        L3 = A0.file
        _UPVALUE2_ = L3
        L3 = string
        L3 = L3.gsub
        L4 = _UPVALUE2_
        L5 = "+"
        L6 = " "
        L3 = L3(L4, L5, L6)
        _UPVALUE2_ = L3
        L3 = string
        L3 = L3.gsub
        L4 = _UPVALUE2_
        L5 = "%%(%x%x)"
        function L6(A0)
          local L1, L2, L3, L4
          L1 = string
          L1 = L1.char
          L2 = tonumber
          L3 = A0
          L4 = 16
          L2, L3, L4 = L2(L3, L4)
          return L1(L2, L3, L4)
        end
        L3 = L3(L4, L5, L6)
        _UPVALUE2_ = L3
        L3 = _UPVALUE2_
        L3 = L3.gsub
        L4 = _UPVALUE2_
        L5 = "\r\n"
        L6 = "\n"
        L3 = L3(L4, L5, L6)
        _UPVALUE2_ = L3
      end
    end
    if A1 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.write
      L5 = A1
      L3(L4, L5)
    end
    if A2 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.close
      L3(L4)
    end
  end
  L5(L6)
  L5 = getOperateDeviceID
  L5, L6 = L5()
  if L5 ~= 0 then
    L7 = _UPVALUE0_
    L7 = L7.write_json
    L8 = generateResponseFromCode
    L9 = L5
    L8, L9, L10, L11, L12, L13, L17, L18, L19, L20, L21 = L8(L9)
    return L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21)
  end
  L7 = nil
  L8 = _UPVALUE0_
  L8 = L8.formvalue
  L9 = "appId"
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.formvalue
  L10 = "saveType"
  L9 = L9(L10)
  if L9 == "public" then
    L7 = "/userdisk/data/\228\184\138\228\188\160/"
  elseif L9 == "private" then
    L10 = string
    L10 = L10.find
    L11 = L8
    L12 = "/"
    L10 = L10(L11, L12)
    if L10 then
      L11 = _UPVALUE0_
      L11 = L11.write_json
      L12 = generateResponseFromCode
      L13 = 3
      L12, L13, L17, L18, L19, L20, L21 = L12(L13)
      return L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21)
    end
    L11 = "/userdisk/appdata/"
    L12 = L8
    L13 = "/"
    L7 = L11 .. L12 .. L13
  else
    L10 = _UPVALUE0_
    L10 = L10.write_json
    L11 = generateResponseFromCode
    L12 = 3
    L11, L12, L13, L17, L18, L19, L20, L21 = L11(L12)
    return L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21)
  end
  L10 = L2.mkdir
  L11 = L7
  L12 = true
  L10(L11, L12)
  L10 = L2.basename
  L11 = L4
  L10 = L10(L11)
  L11 = L2.isfile
  L12 = L7
  L13 = L10
  L12 = L12 .. L13
  L11 = L11(L12)
  if L11 then
    L11 = L10
    L13 = L11
    L12 = L11.match
    L12 = L12(L13, L14)
    if L12 then
      L13 = L11.sub
      L13 = L13(L14, L15, L16)
      L11 = L13
    end
    L13 = L10.match
    L13 = L13(L14, L15)
    for L17 = L14, L15, L16 do
      L18 = L11
      L19 = "("
      L20 = L17
      L21 = ")"
      L18 = L18 .. L19 .. L20 .. L21
      if L13 then
        L19 = L18
        L20 = "."
        L21 = L13
        L18 = L19 .. L20 .. L21
      end
      L19 = L2.isfile
      L20 = L7
      L21 = L18
      L20 = L20 .. L21
      L19 = L19(L20)
      if not L19 then
        L10 = L18
        break
      end
    end
  end
  L11 = L7
  L12 = L10
  L11 = L11 .. L12
  L12 = L1.log
  L13 = "dest="
  L13 = L13 .. L14
  L12(L13)
  L12 = L2.rename
  L13 = L3
  L12(L13, L14)
  L12 = {}
  L12.code = 0
  L13 = generateUrlFromPath
  L13 = L13(L14)
  L12.url = L13
  L12.deviceId = L6
  L12.msg = ""
  L13 = _UPVALUE0_
  L13 = L13.write_json
  L13(L14)
  L13 = _UPVALUE0_
  L13 = L13.close
  L13()
end
uploadFile = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1105
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "ids"
  L1 = L1(L2)
  L0.ids = L1
  L0.hidden = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "hidden"
  L1 = L1(L2)
  if L1 == "true" then
    L0.hidden = true
  end
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getBatchDownloadInfo = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1106
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "key"
  L1 = L1(L2)
  L0.key = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
getConfigInfo = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 616
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
connectedDevice = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1107
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "key"
  L1 = L1(L2)
  L0.key = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "value"
  L1 = L1(L2)
  L0.value = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
setConfigInfo = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.api = 1108
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appId"
  L2 = L2(L3)
  L1.appid = L2
  L1.status = 5
  L2 = L1.appid
  L3 = _UPVALUE1_
  if L2 == L3 then
    L2 = {}
    L2.code = 0
    L2.msg = ""
    L3 = L0.setSambaStatus
    L4 = "1"
    L3(L4)
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4 = L2
    L3(L4)
  else
    L2 = tunnelRequestDatacenter
    L3 = L1
    L2(L3)
  end
end
enablePlugin = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.api = 1108
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appId"
  L2 = L2(L3)
  L1.appid = L2
  L1.status = 6
  L2 = L1.appid
  L3 = _UPVALUE1_
  if L2 == L3 then
    L2 = {}
    L2.code = 0
    L2.msg = ""
    L3 = L0.setSambaStatus
    L4 = "0"
    L3(L4)
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4 = L2
    L3(L4)
  else
    L2 = tunnelRequestDatacenter
    L3 = L1
    L2(L3)
  end
end
disablePlugin = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 600
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.pluginID = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "info"
  L1 = L1(L2)
  L0.info = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
controlPlugin = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 634
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.pluginID = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "info"
  L1 = L1(L2)
  L0.info = L1
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
controlFeaturePlugin = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1110
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "idList"
  L1 = L1(L2)
  L0.idList = L1
  L0.deletefile = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "deletefile"
  L1 = L1(L2)
  if L1 == "true" then
    L0.deletefile = true
  end
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
deleteDownload = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.module.XQStorage"
  L0 = L0(L1)
  L1 = {}
  L1.api = 1111
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appId"
  L2 = L2(L3)
  L1.appid = L2
  L2 = L1.appid
  L3 = _UPVALUE1_
  if L2 == L3 then
    L2 = {}
    L2.code = 0
    L3 = L0.getSambaStatus
    L3 = L3()
    if L3 == "1" then
      L2.isEnable = true
    else
      L2.isEnable = false
    end
    L4 = _UPVALUE0_
    L4 = L4.write_json
    L5 = L2
    L4(L5)
  else
    L2 = tunnelRequestDatacenter
    L3 = L1
    L2(L3)
  end
end
pluginStatus = L5
function L5()
  local L0, L1, L2
  L0 = {}
  L0.api = 1109
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "appId"
  L1 = L1(L2)
  L0.appid = L1
  L0.hidden = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "hidden"
  L1 = L1(L2)
  if L1 == "true" then
    L0.hidden = true
  end
  L0.lite = false
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "lite"
  L1 = L1(L2)
  if L1 == "true" then
    L0.lite = true
  end
  L1 = tunnelRequestDatacenter
  L2 = L0
  L1(L2)
end
pluginDownloadInfo = L5
function L5()
  local L0, L1, L2, L3
  L0 = {}
  L0.api = 634
  L0.pluginID = "2882303761517440411"
  L1 = {}
  L1.api = 4
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appid"
  L2 = L2(L3)
  L1.appid = L2
  L0.info = L1
  L2 = tunnelRequestDatacenter
  L3 = L0
  L2(L3)
end
getYoukuStatus = L5
function L5()
  local L0, L1, L2, L3
  L0 = {}
  L0.api = 634
  L0.pluginID = "2882303761517440411"
  L1 = {}
  L1.api = 5
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "appid"
  L2 = L2(L3)
  L1.appid = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "ip"
  L2 = L2(L3)
  L1.ip = L2
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "token"
  L2 = L2(L3)
  L1.token = L2
  L0.info = L1
  L2 = tunnelRequestDatacenter
  L3 = L0
  L2(L3)
end
bindYoukuAppid = L5
