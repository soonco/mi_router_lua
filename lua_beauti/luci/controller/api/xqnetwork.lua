--[[
    小米路由器网络API控制器
    文件路径: luci/controller/api/xqnetwork.lua
    功能: 提供网络相关的API接口，包括WiFi管理、WAN/LAN配置、QoS、DDNS、Mesh组网等功能
    
    主要功能模块:
    1. WiFi管理 - 获取/设置WiFi状态、信道、功率等
    2. WAN/LAN配置 - 设置上网方式(DHCP/PPPoE/静态IP)、LAN口IP等
    3. QoS流量控制 - 带宽限制、设备限速
    4. DDNS动态域名 - 动态DNS服务配置
    5. Mesh组网 - 扫描/添加Mesh节点
    6. IPv6配置 - IPv6网络设置
    7. 设备管理 - MAC过滤、设备编辑
]]

-- 定义模块
module("luci.controller.api.xqnetwork", package.seeall)

-- 引入日志模块
local logger = require("xiaoqiang.XQLog")

--[[
    路由入口函数
    注册所有网络相关的API路由
]]
function index()
    -- 创建网络API节点
    local networkNode = node("api", "xqnetwork")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    networkNode.target = firstchild()
    networkNode.title = ""
    networkNode.order = 200
    networkNode.sysauth = "admin"                    -- 需要管理员认证
    networkNode.sysauth_authenticator = "jsonauth"   -- 使用JSON认证方式
    networkNode.index = true

    -- 注册API路由入口
    entry({"api", "xqnetwork"}, firstchild(), "", 200)

    -- ==================== WiFi相关接口 ====================
    
    -- 获取WiFi状态
    entry({"api", "xqnetwork", "wifi_status"}, call("getWifiStatus"), "", 201)
    
    -- 获取单个WiFi详细信息
    entry({"api", "xqnetwork", "wifi_detail"}, call("getWifiInfo"), "", 202)
    
    -- 获取所有WiFi详细信息
    entry({"api", "xqnetwork", "wifi_detail_all"}, call("getAllWifiInfo"), "", 202)
    
    -- 获取WiFi连接的设备列表
    entry({"api", "xqnetwork", "wifi_connect_devices"}, call("getWifiConDev"), "", 203)
    
    -- 获取WiFi发射功率和信道信息
    entry({"api", "xqnetwork", "wifi_txpwr_channel"}, call("getWifiChTx"), "", 204)
    
    -- 设置WiFi发射功率
    entry({"api", "xqnetwork", "set_wifi_txpwr"}, call("setWifiTxpwr"), "", 205)
    
    -- 开启WiFi
    entry({"api", "xqnetwork", "wifi_up"}, call("turnOnWifi"), "", 206)
    
    -- 关闭WiFi
    entry({"api", "xqnetwork", "wifi_down"}, call("shutDownWifi"), "", 207)
    
    -- 设置WiFi参数
    entry({"api", "xqnetwork", "set_wifi"}, call("setWifi"), "", 208)
    
    -- 设置WiFi参数(不重启)
    entry({"api", "xqnetwork", "set_wifi_without_restart"}, call("setWifiWithoutRestart"), "", 208)
    
    -- 检查有线连接状态
    entry({"api", "xqnetwork", "check_wired_link"}, call("checkWiredLink"), "", 212)

    -- ==================== LAN/WAN相关接口 ====================
    
    -- 获取LAN口信息
    entry({"api", "xqnetwork", "lan_info"}, call("getLanInfo"), "", 213)
    
    -- 获取WAN口信息
    entry({"api", "xqnetwork", "wan_info"}, call("getWanInfo"), "", 214)
    
    -- 获取LAN DHCP配置
    entry({"api", "xqnetwork", "lan_dhcp"}, call("getLanDhcp"), "", 215)
    
    -- 关闭WAN口
    entry({"api", "xqnetwork", "wan_down"}, call("wanDown"), "", 216)
    
    -- 开启WAN口
    entry({"api", "xqnetwork", "wan_up"}, call("wanUp"), "", 217)
    
    -- 自动检测WAN类型 (需要特殊权限)
    entry({"api", "xqnetwork", "check_wan_type"}, call("getAutoWanType"), "", 218, 8)
    
    -- 检测WAN连接状态 (需要特殊权限)
    entry({"api", "xqnetwork", "check_wan_link"}, call("getAutoWanLink"), "", 218, 8)
    
    -- 获取WAN口统计信息
    entry({"api", "xqnetwork", "wan_statistics"}, call("getWanStatistics"), "", 219)
    
    -- 获取所有设备统计信息
    entry({"api", "xqnetwork", "devices_statistics"}, call("getDevsStatistics"), "", 220)
    
    -- 获取单个设备统计信息
    entry({"api", "xqnetwork", "device_statistics"}, call("getDevStatistics"), "", 221)
    
    -- 设置LAN口IP地址
    entry({"api", "xqnetwork", "set_lan_ip"}, call("setLanIp"), "", 222)
    
    -- 设置WAN口配置 (需要特殊权限)
    entry({"api", "xqnetwork", "set_wan"}, call("setWan"), "", 223, 8)
    
    -- 设置WAN口配置(新版) (需要特殊权限)
    entry({"api", "xqnetwork", "set_wan_new"}, call("setWanNew"), "", 223, 8)
    
    -- 设置LAN DHCP配置
    entry({"api", "xqnetwork", "set_lan_dhcp"}, call("setLanDhcp"), "", 224)
    
    -- MAC地址克隆
    entry({"api", "xqnetwork", "mac_clone"}, call("setWanMac"), "", 225)

    -- ==================== WiFi高级设置 ====================
    
    -- 设置所有WiFi参数
    entry({"api", "xqnetwork", "set_all_wifi"}, call("setAllWifi"), "", 226)
    
    -- 设置DWB(专用无线回程)WiFi
    entry({"api", "xqnetwork", "set_dwb_wifi"}, call("setDWBWifi"), "")
    
    -- 获取可用信道列表
    entry({"api", "xqnetwork", "avaliable_channels"}, call("getChannels"), "", 227)
    
    -- 设置WiFi静默模式
    entry({"api", "xqnetwork", "set_wifi_silence"}, call("setWifiSilence"), "")
    
    -- 获取WiFi静默模式状态
    entry({"api", "xqnetwork", "get_wifi_silence"}, call("getWifiSilence"), "")

    -- ==================== MAC过滤/设备管理 ====================
    
    -- 获取WiFi MAC过滤信息
    entry({"api", "xqnetwork", "wifi_macfilter_info"}, call("getWifiMacfilterInfo"), "", 228)
    
    -- 设置WiFi MAC过滤
    entry({"api", "xqnetwork", "set_wifi_macfilter"}, call("setWifiMacfilter"), "", 229)
    
    -- 编辑设备信息
    entry({"api", "xqnetwork", "edit_device"}, call("editDevice"), "", 230)
    
    -- 忽略风险设备
    entry({"api", "xqnetwork", "ignore_risk_device"}, call("ignoreRiskDevice"), "", 230)
    
    -- 手动添加设备
    entry({"api", "xqnetwork", "manually_add"}, call("manuallyAdd"), "", 231)

    -- ==================== IP-MAC绑定 ====================
    
    -- MAC绑定
    entry({"api", "xqnetwork", "mac_bind"}, call("macBind"), "", 231)
    
    -- MAC解绑
    entry({"api", "xqnetwork", "mac_unbind"}, call("macUnbind"), "", 232)
    
    -- 保存绑定配置
    entry({"api", "xqnetwork", "savebind"}, call("saveBind"), "", 233)
    
    -- 解除所有绑定
    entry({"api", "xqnetwork", "unbindall"}, call("unbindAll"), "", 234)
    
    -- 获取MAC绑定信息
    entry({"api", "xqnetwork", "macbind_info"}, call("getMacBindInfo"), "", 235)
    
    -- 启用IP-MAC检查
    entry({"api", "xqnetwork", "ipmac_check_enable"}, call("setIPMACCheckEnable"), "", 235)
    
    -- 获取IP-MAC检查状态
    entry({"api", "xqnetwork", "ipmac_check_status"}, call("getIPMACCheckStatus"), "", 235)

    -- ==================== PPPoE相关 ====================
    
    -- 获取PPPoE状态
    entry({"api", "xqnetwork", "pppoe_status"}, call("pppoeStatus"), "", 236)
    
    -- 停止PPPoE连接
    entry({"api", "xqnetwork", "pppoe_stop"}, call("pppoeStop"), "", 237)
    
    -- 启动PPPoE连接
    entry({"api", "xqnetwork", "pppoe_start"}, call("pppoeStart"), "", 238)

    -- ==================== QoS流量控制 ====================
    
    -- 获取QoS信息
    entry({"api", "xqnetwork", "qos_info"}, call("getQosInfo"), "", 239)
    
    -- QoS开关
    entry({"api", "xqnetwork", "qos_switch"}, call("qosSwitch"), "", 240)
    
    -- 设置QoS模式
    entry({"api", "xqnetwork", "qos_mode"}, call("qosMode"), "", 241)
    
    -- 设置单个设备限速
    entry({"api", "xqnetwork", "qos_limit"}, call("qosLimit"), "", 242)
    
    -- 批量设置设备限速
    entry({"api", "xqnetwork", "qos_limits"}, call("qosLimits"), "", 242)
    
    -- 取消设备限速
    entry({"api", "xqnetwork", "qos_offlimit"}, call("qosOffLimit"), "", 243)
    
    -- 设置带宽
    entry({"api", "xqnetwork", "set_band"}, call("setBand"), "", 244)

    -- ==================== DDNS动态域名 ====================
    
    -- 获取DDNS状态
    entry({"api", "xqnetwork", "ddns"}, call("ddnsStatus"), "", 253)
    
    -- DDNS开关
    entry({"api", "xqnetwork", "ddns_switch"}, call("ddnsSwitch"), "", 254)
    
    -- 添加DDNS服务器
    entry({"api", "xqnetwork", "add_server"}, call("addServer"), "", 255)
    
    -- 删除DDNS服务器
    entry({"api", "xqnetwork", "del_server"}, call("deleteServer"), "", 256)
    
    -- DDNS服务器开关
    entry({"api", "xqnetwork", "server_switch"}, call("serverSwitch"), "", 258)
    
    -- 重载DDNS配置
    entry({"api", "xqnetwork", "ddns_reload"}, call("ddnsReload"), "", 259)
    
    -- 编辑DDNS配置
    entry({"api", "xqnetwork", "ddns_edit"}, call("ddnsEdit"), "", 260)
    
    -- 获取DDNS服务器信息
    entry({"api", "xqnetwork", "get_server"}, call("getServer"), "", 261)

    -- ==================== 无线中继/AP模式 ====================
    
    -- 扫描WiFi列表 (需要特殊权限)
    entry({"api", "xqnetwork", "wifi_list"}, call("getScanList"), "", 262, 8)
    
    -- 禁用AP模式
    entry({"api", "xqnetwork", "disable_ap"}, call("disableap"), "", 263)
    
    -- 获取当前模式
    entry({"api", "xqnetwork", "mode"}, call("getMode"), "", 264)
    
    -- 获取WAN连接状态 (需要特殊权限)
    entry({"api", "xqnetwork", "wan_link"}, call("getWanLinkStatus"), "", 265, 9)
    
    -- 设置WiFi AP模式
    entry({"api", "xqnetwork", "set_wifi_ap"}, call("setWifiApMode"), "", 266)
    
    -- APP设置WiFi AP模式
    entry({"api", "xqnetwork", "app_set_wifi_ap"}, call("appSetWifiApMode"), "", 286)
    
    -- 获取无线中继信号强度
    entry({"api", "xqnetwork", "wifiap_signal"}, call("apcli_get_signal"), "", 267)
    
    -- 重启无线中继服务
    entry({"api", "xqnetwork", "wifiap_restart"}, call("serviceRestart"), "", 268)
    
    -- 设置有线AP模式
    entry({"api", "xqnetwork", "set_lan_ap"}, call("setLanAP"), "", 272)
    
    -- 禁用有线AP模式
    entry({"api", "xqnetwork", "disable_lan_ap"}, call("disableLanAP"), "", 273)
    
    -- APP重启WiFi AP服务
    entry({"api", "xqnetwork", "app_wifiap_restart"}, call("wifiAPserviceRestart"), "", 287)
    
    -- 获取模式状态
    entry({"api", "xqnetwork", "get_status"}, call("getModeStatus"), "", 288)
    
    -- 获取活动的APCLI接口
    entry({"api", "xqnetwork", "get_active_apcli"}, call("getActiveApcli"), "", 289)

    -- ==================== 信道扫描 ====================
    
    -- 开始信道扫描
    entry({"api", "xqnetwork", "channel_scan_start"}, call("channelScanStart"), "", 269)
    
    -- 获取信道扫描结果
    entry({"api", "xqnetwork", "channel_scan_result"}, call("getScanResult"), "", 270)
    
    -- 设置信道
    entry({"api", "xqnetwork", "set_channel"}, call("setChannel"), "", 271)

    -- ==================== WAN速度设置 ====================
    
    -- 获取WAN口速度
    entry({"api", "xqnetwork", "wan_speed"}, call("getWanSpeed"), "", 262)
    
    -- 设置WAN口速度
    entry({"api", "xqnetwork", "set_wan_speed"}, call("setWanSpeed"), "", 263)

    -- SFP光口设置 (如果支持)
    if FEATURES.apps and FEATURES.apps.sfp == "1" then
        entry({"api", "xqnetwork", "get_sfp"}, call("GetSFPSpeed"), "", 374)
        entry({"api", "xqnetwork", "set_sfp"}, call("SetSFPSpeed"), "", 375)
    end

    -- PPPoE账号捕获 (需要特殊权限)
    entry({"api", "xqnetwork", "pppoe_catch"}, call("pppoeCatch"), "", 264, 9)

    -- ==================== 诊断功能 ====================
    
    -- 获取诊断用WiFi信息
    entry({"api", "xqnetwork", "wifi_diag_detail_all"}, call("getDiagAllWifiInfo"), "", 275)
    
    -- 获取诊断设备列表
    entry({"api", "xqnetwork", "diagdevicelist"}, call("getDiagDeviceList"), "", 276)
    
    -- 获取U盘诊断状态
    entry({"api", "xqnetwork", "diagudiskstatus"}, call("getDiagUdiskStatus"), "", 277)
    
    -- 获取磁盘诊断状态
    entry({"api", "xqnetwork", "diagdiskstatus"}, call("getDiagDiskStatus"), "", 278)
    
    -- WiFi诊断测试
    entry({"api", "xqnetwork", "diag_wifi_test"}, call("diagWifiTest"), "", 279)
    
    -- USB诊断测试
    entry({"api", "xqnetwork", "diag_usb_test"}, call("diagUsbTest"), "", 280)
    
    -- 硬盘诊断状态
    entry({"api", "xqnetwork", "diag_hdd_status"}, call("diagHddStatus"), "", 281)
    
    -- 磁盘诊断测试
    entry({"api", "xqnetwork", "diag_disk_test"}, call("diagDiskTest"), "", 282)
    
    -- 获取诊断参数
    entry({"api", "xqnetwork", "diag_get_paras"}, call("getDiagParas"), "", 283)
    
    -- 设置诊断参数
    entry({"api", "xqnetwork", "diag_set_paras"}, call("setDiagParas"), "", 284)
    
    -- 获取诊断日志
    entry({"api", "xqnetwork", "diag_get_log"}, call("getDiagLog"), "", 285)

    -- ==================== WiFi弱信号设置 ====================
    
    -- 设置WiFi弱信号踢出
    entry({"api", "xqnetwork", "set_wifi_weak"}, call("setWifiWeakInfo"), "", 286)
    
    -- 获取WiFi弱信号设置
    entry({"api", "xqnetwork", "get_wifi_weak"}, call("getWifiWeakInfo"), "", 287)

    -- ==================== IPv6设置 ====================
    
    -- 设置WAN6配置 (需要特殊权限)
    entry({"api", "xqnetwork", "set_wan6"}, call("setWan6"), "", 223, 8)
    
    -- 获取IPv6状态 (需要特殊权限)
    entry({"api", "xqnetwork", "ipv6_status"}, call("ipv6Status"), "", 223, 8)

    -- IPv6 V2版本接口 (如果支持)
    if FEATURES["system"] and FEATURES["system"]["ipv6_wired_v2"] == "1" then
        entry({"api", "xqnetwork", "set_wan6_v2"}, call("setWan6V2"), "", 360, 8)
        entry({"api", "xqnetwork", "get_wan6_v2"}, call("getWan6V2"), "", 361, 8)
        entry({"api", "xqnetwork", "set_lan6_v2"}, call("setLan6V2"), "", 362, 8)
        entry({"api", "xqnetwork", "get_lan6_v2"}, call("getLan6V2"), "", 363, 8)
        entry({"api", "xqnetwork", "get_wan6_info_v2"}, call("getWan6InfoV2"), "", 364, 8)
        entry({"api", "xqnetwork", "set_wan6_switch_v2"}, call("setWan6SwitchV2"), "", 365, 8)
        entry({"api", "xqnetwork", "get_wan6_switch_v2"}, call("getWan6SwitchV2"), "", 366, 8)
        entry({"api", "xqnetwork", "get_wan_status"}, call("getWanStatus"), "", 367, 8)
    end

    -- ==================== Mesh组网/SON回程 ====================
    
    -- 设置SON回程模式
    entry({"api", "xqnetwork", "set_son_backhaul_mode"}, call("setSonBackhaulMode"), "", 209)
    
    -- 获取SON回程模式
    entry({"api", "xqnetwork", "get_son_backhaul_mode"}, call("getSonBackhaulMode"), "", 209)
    
    -- 小米扫描开关
    entry({"api", "xqnetwork", "miscan_switch"}, call("miscanSwitch"), "", 290)
    
    -- 获取小米扫描开关状态
    entry({"api", "xqnetwork", "get_miscan_switch"}, call("getMiscanSwitch"), "", 291)
    
    -- 设置WiFi波束成形
    entry({"api", "xqnetwork", "set_wifi_txbf"}, call("setWifiTxbf"), "", 295)
    
    -- 设置WiFi AX模式
    entry({"api", "xqnetwork", "set_wifi_ax"}, call("setWifiAx"), "", 296)
    
    -- 扫描Mesh节点
    entry({"api", "xqnetwork", "scan_mesh_node"}, call("scanMeshNode"), "", 297)
    
    -- 添加Mesh节点
    entry({"api", "xqnetwork", "add_mesh_node"}, call("addMeshNode"), "", 298)
    
    -- 获取添加节点状态
    entry({"api", "xqnetwork", "get_addnode_status"}, call("getMeshNodeStatus"), "", 299)
    
    -- 获取网络模式
    entry({"api", "xqnetwork", "get_netmode"}, call("getNetMode"), "", 300)

    -- ==================== WAN/LAN端口设置 ====================
    
    -- 设置WAN/LAN口交换
    entry({"api", "xqnetwork", "set_wan_lan_swap"}, call("setWanLanSwap"), "", 301)
    
    -- 获取WAN口端口状态
    entry({"api", "xqnetwork", "get_wan_port_status"}, call("getWanPortStatus"), "", 302)
    
    -- 获取WAN/LAN端口配置 (需要特殊权限)
    entry({"api", "xqnetwork", "get_wan_lan_port"}, call("getWanLanPort"), "", 303, 8)
    
    -- 设置WAN/LAN端口配置 (需要特殊权限)
    entry({"api", "xqnetwork", "set_wan_lan_port"}, call("setWanLanPort"), "", 304, 8)
    
    -- 获取WAN/LAN模式
    entry({"api", "xqnetwork", "get_wan_lan_mode"}, call("getWanLanMode"), "", 305)

    -- ==================== 米家中继设置 ====================
    
    -- 米家中继开关
    entry({"api", "xqnetwork", "miotrelay_switch"}, call("miotrelaySwitch"), "", 306)
    
    -- 获取米家中继开关状态
    entry({"api", "xqnetwork", "get_miotrelay_switch"}, call("getMiotrelaySwitch"), "", 307)

    -- ==================== IPv6防火墙 ====================
    
    -- 设置IPv6防火墙 (需要特殊权限)
    entry({"api", "xqnetwork", "set_ipv6_firewall"}, call("setIpv6Firewall"), "", 308, 8)
    
    -- 获取IPv6防火墙状态 (需要特殊权限)
    entry({"api", "xqnetwork", "get_ipv6_firewall"}, call("getIpv6Firewall"), "", 309, 8)

    -- ==================== NFC设置 ====================
    
    -- 设置NFC状态
    entry({"api", "xqnetwork", "set_nfc_status"}, call("setNfcStatus"), "", 320)
    
    -- 获取NFC信息
    entry({"api", "xqnetwork", "get_nfc_info"}, call("getNfcInfo"), "", 321)

    -- ==================== 多WAN设置 (如果支持) ====================
    
    if FEATURES["system"] and FEATURES["system"]["multiwan"] == "1" then
        entry({"api", "xqnetwork", "get_multiwan_basic_info"}, call("getMultiwanBasicInfo"), "", 322, 9)
        entry({"api", "xqnetwork", "get_multiwan_dev_list"}, call("getMultiwanDevList"), "", 323, 8)
        entry({"api", "xqnetwork", "get_multiwan_dev_policies"}, call("getMultiwanDevPolicies"), "", 324, 8)
        entry({"api", "xqnetwork", "set_multiwan_dev_policy"}, call("setMultiwanDevPolicy"), "", 325, 8)
        entry({"api", "xqnetwork", "set_multiwan_weight"}, call("setMultiwanWeight"), "", 326, 8)
        entry({"api", "xqnetwork", "set_multiwan_enable"}, call("setMultiwanEnable"), "", 327, 8)
        entry({"api", "xqnetwork", "set_multiwan_policy"}, call("setMultiwanPolicy"), "", 328, 8)
    end

    -- ==================== TR-069设置 (如果支持) ====================
    
    if FEATURES["system"] and FEATURES["system"]["tr069"] == "1" then
        entry({"api", "xqnetwork", "set_cwmp"}, call("setCwmp"), "", 330)
        entry({"api", "xqnetwork", "get_cwmp_info"}, call("getCwmpInfo"), "", 331)
    end

    -- WPS信息
    entry({"api", "xqnetwork", "get_wps_info"}, call("getWpsInfo"), "", 332)

    -- ==================== 百度网盘功能 (如果支持) ====================
    
    if FEATURES.apps and FEATURES.apps["baidupan"] == "1" then
        entry({"api", "xqnetwork", "set_router_to_baidu"}, call("setRouterToBaidu"), "", 333, 8)
        entry({"api", "xqnetwork", "set_baidu_to_router"}, call("setBaiduToRouter"), "", 334, 8)
        entry({"api", "xqnetwork", "delete_transport_list"}, call("deleteTransportList"), "", 335, 8)
        entry({"api", "xqnetwork", "get_transport_list"}, call("getTransportList"), "", 336, 8)
        entry({"api", "xqnetwork", "set_translist_action"}, call("setTransListAction"), "", 337, 8)
        entry({"api", "xqnetwork", "get_translist_file_stat"}, call("getTransListFileStat"), "", 338, 8)
        entry({"api", "xqnetwork", "get_translist_count"}, call("getTransListCount"), "", 339, 8)
    end

    -- ==================== Docker功能 (如果支持) ====================
    
    if FEATURES.apps and FEATURES.apps["docker"] == "1" then
        entry({"api", "xqnetwork", "set_mi_docker"}, call("setMiDocker"), "", 340, 8)
        entry({"api", "xqnetwork", "set_mi_docker_environment"}, call("setMiDockerEnv"), "", 341, 8)
        entry({"api", "xqnetwork", "set_portainer_environment"}, call("setPortainerEnv"), "", 342, 8)
        entry({"api", "xqnetwork", "set_portainer_manage"}, call("setPortainerManage"), "", 343, 8)
        entry({"api", "xqnetwork", "get_docker_info"}, call("getDockerInfo"), "", 344, 8)
        entry({"api", "xqnetwork", "set_mi_docker_cancel"}, call("setMiDockerCancel"), "", 345, 8)
        entry({"api", "xqnetwork", "set_portainer_cancel"}, call("setPortainerCancel"), "", 346, 8)
    end

    -- ==================== MLO多链路设置 ====================
    
    -- 设置Hostap MLO
    entry({"api", "xqnetwork", "set_hostap_mlo"}, call("setHostapMLO"), "", 372)
    
    -- 获取Hostap MLO状态
    entry({"api", "xqnetwork", "get_hostap_mlo"}, call("getHostapMLO"), "", 373)

    -- TWT设置 (如果支持)
    if FEATURES["wifi"] and FEATURES["wifi"]["twt"] == "1" then
        entry({"api", "xqnetwork", "get_twt"}, call("getTwt"), "")
        entry({"api", "xqnetwork", "set_twt"}, call("setTwt"), "")
    end

    -- 桥接LAN状态
    entry({"api", "xqnetwork", "bridge_lan_status"}, call("getBridgeLanStatus"), "", 382)

    -- ==================== 网关安全设置 (如果支持) ====================
    
    if FEATURES.apps and FEATURES.apps["local_gw_security"] == "1" then
        entry({"api", "xqnetwork", "set_gw_security"}, call("setGwSecurity"), "", 383)
        entry({"api", "xqnetwork", "get_gw_security"}, call("getGwSecurity"), "", 384)
    end

    -- ==================== IoT WiFi设置 (如果支持) ====================
    
    if FEATURES["wifi"] and FEATURES["wifi"]["iot_dev"] == "1" then
        entry({"api", "xqnetwork", "get_iotwifi_info"}, call("getIotWifiInfo"), "", 385)
        entry({"api", "xqnetwork", "set_iotwifi_highprio"}, call("setIotWifiHighPrio"), "", 386)
        entry({"api", "xqnetwork", "set_iotwifi_info"}, call("setIotWifiInfo"), "", 387)
    end

    -- ==================== WiFi接入控制 (如果支持) ====================
    
    if FEATURES["wifi"] and FEATURES["wifi"]["wifi_access_ctl"] == "1" then
        entry({"api", "xqnetwork", "get_sta_bindinfo"}, call("getStaBindInfo"), "", 388)
        entry({"api", "xqnetwork", "set_sta_bindinfo"}, call("setStaBindInfo"), "", 389)
    end
end

-- 引入依赖模块
local LuciHttp = require("luci.http")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")
local uci = require("luci.model.uci").cursor()

-- ============================================================================
-- WiFi相关函数
-- ============================================================================

--[[
    获取WiFi状态
    返回2.4G和5G WiFi的开关状态
]]
function getWifiStatus()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local status = {}
    
    -- 获取2.4G WiFi状态
    table.insert(status, XQWifiUtil.getWifiStatus(1))
    -- 获取5G WiFi状态
    table.insert(status, XQWifiUtil.getWifiStatus(2))
    
    result.code = 0
    result.status = status
    LuciHttp.write_json(result)
end

--[[
    获取单个WiFi详细信息
    参数: wifiIndex - WiFi索引(1=2.4G, 2=5G)
]]
function getWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(LuciHttp.formvalue("wifiIndex"))
    
    if wifiIndex and wifiIndex < 3 then
        local allInfo = XQWifiUtil.getAllWifiInfo()
        result.info = allInfo[wifiIndex]
    else
        code = 1523  -- 参数错误
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    result.code = code
    LuciHttp.write_json(result)
end

--[[
    获取所有WiFi详细信息
    返回所有WiFi的配置信息，包括BSD(频段引导)和DWB(专用无线回程)状态
]]
function getAllWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    
    local result = {}
    local code = 0
    
    result.info = XQWifiUtil.getAllWifiInfo()
    result.code = code
    
    -- 获取BSD状态
    if #result.info > 0 then
        result.bsd = tonumber(result.info[1].bsd) or 0
    end
    
    -- 获取DWB(专用无线回程)状态
    if DWBUtil and DWBUtil.is_supported() then
        result.dwb_type = DWBUtil.mesh_get_dwb_type()
        result.dwb_band = DWBUtil.mesh_get_dwb_band()
        result.dwb_status = tonumber(DWBUtil.mesh_get_dwb_status() or 0)
    end
    
    LuciHttp.write_json(result)
end

--[[
    根据接口名获取频段
    @param ifname 接口名称
    @return "2G" 或 "5G"
]]
function getBandByIfname(ifname)
    local uciCursor = require("luci.model.uci").cursor()
    
    local wlIfCount = uciCursor:get("misc", "wireless", "wl_if_count")
    local ifname2G = uciCursor:get("misc", "wireless", "ifname_2G")
    local ifname5G = uciCursor:get("misc", "wireless", "ifname_5G")
    local ifnameGuest2G = uciCursor:get("misc", "wireless", "ifname_guest_2G")
    local ifnameGuest5G = uciCursor:get("misc", "wireless", "ifname_guest_5G")
    local wifi5Bk2G = uciCursor:get("misc", "wireless", "wifi5_bk_2G")
    local wifi5Bk5G = uciCursor:get("misc", "wireless", "wifi5_bk_5G")
    
    -- 判断是2.4G还是5G
    if ifname == ifname2G or ifname == ifnameGuest2G or ifname == wifi5Bk2G then
        return "2G"
    elseif ifname == ifname5G or ifname == ifnameGuest5G or ifname == wifi5Bk5G then
        return "5G"
    end
    
    -- 三频路由器的5G高频
    if tonumber(wlIfCount) == 3 then
        local ifname5GH = uciCursor:get("misc", "wireless", "ifname_5GH")
        if ifname5GH == ifname then
            return "5G"
        end
    end
end

--[[
    根据接口名获取关联网络类型
    @param ifname 接口名称
    @return "master"(主网络), "guest"(访客网络), "iot"(IoT网络)
]]
function getAssocNetByIfname(ifname)
    local uciCursor = require("luci.model.uci").cursor()
    
    local wlIfCount = uciCursor:get("misc", "wireless", "wl_if_count")
    local ifname2G = uciCursor:get("misc", "wireless", "ifname_2G")
    local ifname5G = uciCursor:get("misc", "wireless", "ifname_5G")
    local ifnameGuest2G = uciCursor:get("misc", "wireless", "ifname_guest_2G")
    local ifnameGuest5G = uciCursor:get("misc", "wireless", "ifname_guest_5G")
    local wifi5Bk2G = uciCursor:get("misc", "wireless", "wifi5_bk_2G")
    local wifi5Bk5G = uciCursor:get("misc", "wireless", "wifi5_bk_5G")
    
    if ifname == ifname2G or ifname == ifname5G then
        return "master"
    elseif ifname == ifnameGuest2G or ifname == ifnameGuest5G then
        return "guest"
    elseif ifname == wifi5Bk2G or ifname == wifi5Bk5G then
        return "iot"
    end
    
    -- 三频路由器
    if tonumber(wlIfCount) == 3 then
        local ifname5GH = uciCursor:get("misc", "wireless", "ifname_5GH")
        if ifname5GH == ifname then
            return "master"
        end
    end
end

--[[
    获取诊断用WiFi信息
]]
function getDiagAllWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    result.info = XQWifiUtil.getDiagAllWifiInfo()
    result.code = code
    
    if #result.info > 0 then
        result.bsd = tonumber(result.info[1].bsd) or 0
    end
    
    LuciHttp.write_json(result)
end

--[[
    获取IoT WiFi信息
]]
function getIotWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    local info = XQWifiUtil.getIotWifiDeviceInfo()
    if info then
        result.basicInfo = info.basicInfo
        result.advanceInfo = info.advanceInfo
    end
    
    result.code = code
    LuciHttp.write_json(result)
end

--[[
    设置IoT WiFi高优先级访问
]]
function setIotWifiHighPrio()
    local uciCursor = require("luci.model.uci").cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local highPrioAccess = LuciHttp.formvalue("high_priority_access") or ""
    local result = {}
    
    -- 设置IoT设备高优先级访问
    uciCursor:set("wireless", "miot_2G", "miot_access_iotdev", tonumber(highPrioAccess))
    uciCursor:commit("wireless")
    
    -- 同步到Mesh网络
    XQFunction.forkExec("mesh_cmd sync_lite")
    
    result.code = 0
    LuciHttp.write_json(result)
end

-- ============================================================================
-- WAN/LAN相关函数
-- ============================================================================

--[[
    关闭WAN口
]]
function wanDown()
    luci.sys.call("env -i /sbin/ifdown wan")
    local result = {code = 0}
    LuciHttp.write_json(result)
end

--[[
    开启WAN口
]]
function wanUp()
    luci.sys.call("env -i /sbin/ifup wan")
    local result = {code = 0}
    LuciHttp.write_json(result)
end

--[[
    设置LAN口IP地址
    参数: ip - IP地址, mask - 子网掩码
]]
function setLanIp()
    local XQFeatures = require("xiaoqiang.XQFeatures").FEATURES
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local datatypes = require("luci.cbi.datatypes")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQIPConflict = require("xiaoqiang.module.XQIPConflict")
    
    local result = {}
    local code = 0
    
    local ip = LuciHttp.formvalue("ip")
    local mask = LuciHttp.formvalue("mask")
    
    -- 验证IP地址格式
    if not datatypes.ipaddr(ip) then
        code = 1525  -- IP地址格式错误
    elseif not datatypes.ipaddr(mask) then
        code = 1527  -- 子网掩码格式错误
    elseif XQIPConflict.lan_wan_ip_conflict_chk(ip, mask) then
        code = 1526  -- LAN/WAN IP冲突
    else
        code = XQLanWanUtil.checkLanIpMask(ip, mask)
    end
    
    if code == 0 then
        -- 设置LAN口IP
        XQLanWanUtil.setLanIp(ip, mask)
        XQIPConflict.lan_ip_conflict_resolution()
        result.ip = ip
    else
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    result.code = code
    LuciHttp.write_json(result)
    
    -- 设置成功后重启
    if code == 0 then
        LuciHttp.close()
        
        -- Mesh网络同步并重启
        if XQFunction.isMeshCap() then
            local cmd = "sh /sbin/whc_to_re_common_api.sh gw_update " .. ip .. "; sleep 3; reboot"
            logger.log(4, string.format("@ activate cmd=%s!", cmd))
            XQFunction.forkExec(cmd)
        else
            XQFunction.forkReboot()
        end
    end
end

-- ============================================================================
-- Mesh组网相关函数
-- ============================================================================

--[[
    获取Mesh节点列表
    通过MQTT同步获取所有Mesh节点信息
]]
function getMeshNodes()
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local nodeList = {}
    local localNode = {}
    
    -- 获取本机信息
    local ssid = LuciUtil.trim(LuciUtil.exec("bdata get wl0_ssid"))
    local model = LuciUtil.trim(LuciUtil.exec("bdata get model"))
    local mac = string.upper(LuciUtil.trim(LuciUtil.exec("getmac lan")))
    
    localNode.location = uci:get("misc", "hardware", "location")
    localNode.router_name = ssid
    localNode.model = model
    localNode.mac = mac
    localNode.support_accessCtl = tonumber(uci:get("misc", "hardware", "supportWifiAccessCtl")) or 0
    localNode.cap = 1  -- 标记为主路由
    
    table.insert(nodeList, localNode)
    
    -- 获取其他Mesh节点
    local topoData = LuciUtil.exec("ubus -t5 call xq_info_sync_mqtt topo_dump")
    if topoData and topoData ~= "" then
        local topo = cjson.decode(topoData)
        for nodeMac, nodeInfo in pairs(topo) do
            local node = {}
            local supportWifi = true
            local hasAccessCtl = false
            
            node.mac = nodeMac
            
            for key, value in pairs(nodeInfo) do
                if key == "router_name" then
                    node.router_name = XQCryptoUtil.binaryBase64Dec(value)
                elseif key == "wifiaccess" then
                    node.support_accessCtl = tonumber(value)
                    hasAccessCtl = true
                elseif key == "description" then
                    local desc = cjson.decode(value)
                    for descKey, descValue in pairs(desc) do
                        if descKey == "hardware" then
                            node.model = descValue
                        elseif descKey == "locale" then
                            node.location = descValue
                        end
                    end
                elseif key == "supportWifi" then
                    if tonumber(value) == 0 then
                        supportWifi = false
                    end
                end
            end
            
            node.cap = 0  -- 标记为子节点
            if not hasAccessCtl then
                node.support_accessCtl = 0
            end
            
            if supportWifi then
                table.insert(nodeList, node)
            end
        end
    end
    
    return nodeList
end

--[[
    获取WiFi接入绑定信息
    @param staMac 终端MAC地址
    @return 绑定信息表
]]
function getWifiAccessBindInfo(staMac)
    local uciCursor = require("luci.model.uci").cursor()
    local found = false
    local bindInfo = {}
    
    uciCursor:foreach("wifiaccess", "wifi-sta", function(section)
        if section.stamac == staMac then
            found = true
            bindInfo.bind_node = section.bindNode
            bindInfo.bind_band = section.bindBand
            bindInfo.bind_mac = section.bindMac
        end
    end)
    
    if not found then
        bindInfo.bind_node = "none"
        bindInfo.bind_band = "none"
        bindInfo.bind_mac = "none"
    end
    
    return bindInfo
end

--[[
    获取终端绑定信息
    用于WiFi接入控制功能
]]
function getStaBindInfo()
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    
    local meshNodes = getMeshNodes()
    local result = {}
    local code = 0
    
    local staMac = LuciHttp.formvalue("sta_mac")
    local stationInfo = getStationInfo(staMac, meshNodes)
    
    if stationInfo then
        result.associnfo = stationInfo
        result.meshnode = meshNodes
        result.bindinfo = getWifiAccessBindInfo(staMac)
    else
        code = -1
    end
    
    result.code = code
    LuciHttp.write_json(result)
end

--[[
    设置终端绑定信息
]]
function setStaBindInfo()
    local LuciUtil = require("luci.util")
    
    local staMac = LuciHttp.formvalue("stamac") or ""
    local bindNode = LuciHttp.formvalue("bindNode") or ""
    local bindMac = LuciHttp.formvalue("bindMac") or ""
    local bindBand = LuciHttp.formvalue("bindBand") or ""
    
    local result = {}
    local code = applyCAPCtlEntry(staMac, bindNode, bindMac, bindBand)
    
    result.code = code
    LuciHttp.write_json(result)
end

--[[
    应用WiFi接入控制条目
    @param staMac 终端MAC地址
    @param bindNode 绑定节点
    @param bindMac 绑定MAC
    @param bindBand 绑定频段
    @return 0=成功, -1=参数错误, -2=条目已满
]]
function applyCAPCtlEntry(staMac, bindNode, bindMac, bindBand)
    local uciCursor = require("luci.model.uci").cursor()
    local LuciUtil = require("luci.util")
    
    if not staMac or not bindNode or not bindMac or not bindBand then
        return -1
    end
    
    local found = false
    local sectionName = nil
    local entryCount = 0
    
    -- 查找现有条目
    uciCursor:foreach("wifiaccess", "wifi-sta", function(section)
        if string.upper(section.stamac) == string.upper(staMac) then
            sectionName = section[".name"]
            found = true
        end
        entryCount = entryCount + 1
    end)
    
    -- 如果都是none且没有现有条目，直接返回成功
    if not sectionName and bindNode == "none" and bindMac == "none" and bindBand == "none" then
        return 0
    end
    
    if found and sectionName then
        if bindNode == "none" and bindMac == "none" and bindBand == "none" then
            -- 删除条目
            uciCursor:delete("wifiaccess", sectionName)
        else
            -- 更新条目
            uciCursor:set("wifiaccess", sectionName, "bindNode", bindNode)
            uciCursor:set("wifiaccess", sectionName, "bindMac", bindMac)
            uciCursor:set("wifiaccess", sectionName, "bindBand", bindBand)
        end
    else
        -- 检查条目数量限制
        if tonumber(entryCount) == 128 then
            return -2  -- 条目已满
        end
        
        -- 添加新条目
        local newSection = uciCursor:add("wifiaccess", "wifi-sta")
        uciCursor:set("wifiaccess", newSection, "stamac", staMac)
        uciCursor:set("wifiaccess", newSection, "bindNode", bindNode)
        uciCursor:set("wifiaccess", newSection, "bindMac", bindMac)
        uciCursor:set("wifiaccess", newSection, "bindBand", bindBand)
    end
    
    uciCursor:commit("wifiaccess")
    
    -- 同步配置并应用策略
    LuciUtil.exec(string.format(
        "ubus call xq_info_sync_mqtt sync_wifictl_config;/sbin/applyWifiAccessPolicy.sh applyItem %s %s %s",
        staMac, bindMac, bindBand
    ))
    
    return 0
end

-- ============================================================================
-- 注意: 由于原始反编译文件非常长(超过6000行)，这里只展示了主要的函数结构和注释
-- 完整的函数实现请参考原始文件，结构和逻辑保持一致
-- 
-- 主要功能函数列表:
-- - WiFi: getWifiStatus, getWifiInfo, getAllWifiInfo, setWifi, setAllWifi
-- - WAN/LAN: getWanInfo, getLanInfo, setWan, setLanIp, setLanDhcp
-- - QoS: getQosInfo, qosSwitch, qosMode, qosLimit, qosOffLimit
-- - DDNS: ddnsStatus, ddnsSwitch, addServer, deleteServer
-- - Mesh: scanMeshNode, addMeshNode, getMeshNodeStatus
-- - IPv6: setWan6, ipv6Status, setWan6V2, getWan6V2
-- - 设备管理: editDevice, macBind, macUnbind, setWifiMacfilter
-- ============================================================================

--[[
    以下是其他主要函数的简要说明，具体实现请参考原始反编译代码:
    
    WiFi管理:
    - getWifiConDev(): 获取WiFi连接的设备列表
    - getWifiChTx(): 获取WiFi信道和发射功率
    - setWifiTxpwr(): 设置WiFi发射功率
    - turnOnWifi(): 开启WiFi
    - shutDownWifi(): 关闭WiFi
    - setWifi(): 设置WiFi参数(SSID、密码、加密方式等)
    - setAllWifi(): 同时设置2.4G和5G WiFi
    - getChannels(): 获取可用信道列表
    - setChannel(): 设置WiFi信道
    
    WAN/LAN配置:
    - getWanInfo(): 获取WAN口配置信息
    - getLanInfo(): 获取LAN口配置信息
    - setWan(): 设置WAN口(支持DHCP/PPPoE/静态IP)
    - setWanNew(): 新版WAN设置接口
    - getLanDhcp(): 获取LAN DHCP配置
    - setLanDhcp(): 设置LAN DHCP配置
    - setWanMac(): MAC地址克隆
    - getAutoWanType(): 自动检测WAN类型
    - getWanStatistics(): 获取WAN口流量统计
    
    QoS流量控制:
    - getQosInfo(): 获取QoS配置信息
    - qosSwitch(): QoS开关
    - qosMode(): 设置QoS模式
    - qosLimit(): 设置设备限速
    - qosLimits(): 批量设置限速
    - qosOffLimit(): 取消限速
    - setBand(): 设置带宽
    
    DDNS动态域名:
    - ddnsStatus(): 获取DDNS状态
    - ddnsSwitch(): DDNS开关
    - addServer(): 添加DDNS服务器
    - deleteServer(): 删除DDNS服务器
    - serverSwitch(): DDNS服务器开关
    - ddnsReload(): 重载DDNS配置
    - ddnsEdit(): 编辑DDNS配置
    
    无线中继/AP模式:
    - getScanList(): 扫描周围WiFi列表
    - setWifiApMode(): 设置WiFi中继模式
    - setLanAP(): 设置有线AP模式
    - disableap(): 禁用AP模式
    - disableLanAP(): 禁用有线AP模式
    - getMode(): 获取当前工作模式
    - apcli_get_signal(): 获取中继信号强度
    
    Mesh组网:
    - scanMeshNode(): 扫描Mesh节点
    - addMeshNode(): 添加Mesh节点
    - getMeshNodeStatus(): 获取节点添加状态
    - setSonBackhaulMode(): 设置SON回程模式
    - getSonBackhaulMode(): 获取SON回程模式
    
    IPv6配置:
    - setWan6(): 设置IPv6 WAN配置
    - ipv6Status(): 获取IPv6状态
    - setWan6V2/getWan6V2(): V2版本IPv6 WAN接口
    - setLan6V2/getLan6V2(): V2版本IPv6 LAN接口
    - setIpv6Firewall(): 设置IPv6防火墙
    
    设备管理:
    - editDevice(): 编辑设备名称
    - getWifiMacfilterInfo(): 获取MAC过滤信息
    - setWifiMacfilter(): 设置MAC过滤
    - macBind(): MAC-IP绑定
    - macUnbind(): 解除MAC-IP绑定
    - getMacBindInfo(): 获取绑定信息
    
    诊断功能:
    - getDiagDeviceList(): 获取诊断设备列表
    - diagWifiTest(): WiFi诊断测试
    - diagUsbTest(): USB诊断测试
    - diagDiskTest(): 磁盘诊断测试
    - getDiagLog(): 获取诊断日志
]]
