--[[
    小米路由器网络管理 API 控制器
    文件路径: luci/controller/api/xqnetwork.lua
    
    功能模块:
    1. WiFi管理 - WiFi状态查询、设置、开关控制
    2. WAN/LAN配置 - 网络接口配置、DHCP设置
    3. QoS流量控制 - 带宽限制、设备限速
    4. DDNS动态域名 - 域名服务配置
    5. 无线中继/AP模式 - 中继器、AP模式设置
    6. IPv6配置 - IPv6网络设置
    7. Mesh组网 - Mesh节点管理
    8. 设备管理 - MAC过滤、设备绑定
    9. 诊断功能 - 网络诊断测试
    10. 其他功能 - NFC、WPS、Docker等
    
    API基础路径: /api/xqnetwork/
--]]

module("luci.controller.api.xqnetwork", package.seeall)

-- 日志模块
local logger = require("xiaoqiang.XQLog")

-- HTTP请求处理模块 (延迟加载)
local http = require("luci.http")

-- 错误处理模块 (延迟加载)
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

-- UCI配置模块 (延迟加载)
local uci = require("luci.model.uci").cursor()

--============================================================================--
--                              路由注册函数                                    --
--============================================================================--

--[[
    路由入口函数
    注册所有 API 路由到 LuCI 框架
    所有接口需要管理员认证 (sysauth = "admin")
--]]
function index()
    local root = node("api", "xqnetwork")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    root.target = firstchild()
    root.title = ""
    root.order = 200
    root.sysauth = "admin"
    root.sysauth_authenticator = "jsonauth"
    root.index = true
    
    -- 基础入口
    entry({"api", "xqnetwork"}, firstchild(), "", 200)
    
    --========== WiFi 管理接口 ==========--
    -- 获取WiFi状态
    entry({"api", "xqnetwork", "wifi_status"}, call("getWifiStatus"), "", 201)
    -- 获取单个WiFi详情
    entry({"api", "xqnetwork", "wifi_detail"}, call("getWifiInfo"), "", 202)
    -- 获取所有WiFi详情
    entry({"api", "xqnetwork", "wifi_detail_all"}, call("getAllWifiInfo"), "", 202)
    -- 获取WiFi连接设备列表
    entry({"api", "xqnetwork", "wifi_connect_devices"}, call("getWifiConDev"), "", 203)
    -- 获取WiFi信道和发射功率
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
    -- 设置所有WiFi
    entry({"api", "xqnetwork", "set_all_wifi"}, call("setAllWifi"), "", 226)
    -- 设置专用无线回程WiFi
    entry({"api", "xqnetwork", "set_dwb_wifi"}, call("setDWBWifi"), "")
    -- 获取可用信道列表
    entry({"api", "xqnetwork", "avaliable_channels"}, call("getChannels"), "", 227)
    -- 设置WiFi静默模式
    entry({"api", "xqnetwork", "set_wifi_silence"}, call("setWifiSilence"), "")
    -- 获取WiFi静默模式状态
    entry({"api", "xqnetwork", "get_wifi_silence"}, call("getWifiSilence"), "")
    -- 设置WiFi波束成形
    entry({"api", "xqnetwork", "set_wifi_txbf"}, call("setWifiTxbf"), "", 295)
    -- 设置WiFi 6 (802.11ax)
    entry({"api", "xqnetwork", "set_wifi_ax"}, call("setWifiAx"), "", 296)
    
    --========== WAN/LAN 配置接口 ==========--
    -- 检查有线连接
    entry({"api", "xqnetwork", "check_wired_link"}, call("checkWiredLink"), "", 212)
    -- 获取LAN信息
    entry({"api", "xqnetwork", "lan_info"}, call("getLanInfo"), "", 213)
    -- 获取WAN信息
    entry({"api", "xqnetwork", "wan_info"}, call("getWanInfo"), "", 214)
    -- 获取LAN DHCP配置
    entry({"api", "xqnetwork", "lan_dhcp"}, call("getLanDhcp"), "", 215)
    -- WAN断开
    entry({"api", "xqnetwork", "wan_down"}, call("wanDown"), "", 216)
    -- WAN连接
    entry({"api", "xqnetwork", "wan_up"}, call("wanUp"), "", 217)
    -- 自动检测WAN类型
    entry({"api", "xqnetwork", "check_wan_type"}, call("getAutoWanType"), "", 218, 8)
    -- 检测WAN链路
    entry({"api", "xqnetwork", "check_wan_link"}, call("getAutoWanLink"), "", 218, 8)
    -- 获取WAN统计信息
    entry({"api", "xqnetwork", "wan_statistics"}, call("getWanStatistics"), "", 219)
    -- 获取所有设备统计信息
    entry({"api", "xqnetwork", "devices_statistics"}, call("getDevsStatistics"), "", 220)
    -- 获取单个设备统计信息
    entry({"api", "xqnetwork", "device_statistics"}, call("getDevStatistics"), "", 221)
    -- 设置LAN IP
    entry({"api", "xqnetwork", "set_lan_ip"}, call("setLanIp"), "", 222)
    -- 设置WAN
    entry({"api", "xqnetwork", "set_wan"}, call("setWan"), "", 223, 8)
    -- 设置WAN (新版)
    entry({"api", "xqnetwork", "set_wan_new"}, call("setWanNew"), "", 223, 8)
    -- 设置LAN DHCP
    entry({"api", "xqnetwork", "set_lan_dhcp"}, call("setLanDhcp"), "", 224)
    -- MAC克隆
    entry({"api", "xqnetwork", "mac_clone"}, call("setWanMac"), "", 225)
    -- 获取WAN速度
    entry({"api", "xqnetwork", "wan_speed"}, call("getWanSpeed"), "", 262)
    -- 设置WAN速度
    entry({"api", "xqnetwork", "set_wan_speed"}, call("setWanSpeed"), "", 263)
    -- WAN链路状态
    entry({"api", "xqnetwork", "wan_link"}, call("getWanLinkStatus"), "", 265, 9)
    -- WAN/LAN交换
    entry({"api", "xqnetwork", "set_wan_lan_swap"}, call("setWanLanSwap"), "", 301)
    -- 获取WAN端口状态
    entry({"api", "xqnetwork", "get_wan_port_status"}, call("getWanPortStatus"), "", 302)
    -- 获取WAN/LAN端口配置
    entry({"api", "xqnetwork", "get_wan_lan_port"}, call("getWanLanPort"), "", 303, 8)
    -- 设置WAN/LAN端口配置
    entry({"api", "xqnetwork", "set_wan_lan_port"}, call("setWanLanPort"), "", 304, 8)
    -- 获取WAN/LAN模式
    entry({"api", "xqnetwork", "get_wan_lan_mode"}, call("getWanLanMode"), "", 305)
    
    --========== MAC过滤和设备管理 ==========--
    -- 获取WiFi MAC过滤信息
    entry({"api", "xqnetwork", "wifi_macfilter_info"}, call("getWifiMacfilterInfo"), "", 228)
    -- 设置WiFi MAC过滤
    entry({"api", "xqnetwork", "set_wifi_macfilter"}, call("setWifiMacfilter"), "", 229)
    -- 编辑设备
    entry({"api", "xqnetwork", "edit_device"}, call("editDevice"), "", 230)
    -- 忽略风险设备
    entry({"api", "xqnetwork", "ignore_risk_device"}, call("ignoreRiskDevice"), "", 230)
    -- 手动添加设备
    entry({"api", "xqnetwork", "manually_add"}, call("manuallyAdd"), "", 231)
    -- MAC绑定
    entry({"api", "xqnetwork", "mac_bind"}, call("macBind"), "", 231)
    -- MAC解绑
    entry({"api", "xqnetwork", "mac_unbind"}, call("macUnbind"), "", 232)
    -- 保存绑定
    entry({"api", "xqnetwork", "savebind"}, call("saveBind"), "", 233)
    -- 解绑所有
    entry({"api", "xqnetwork", "unbindall"}, call("unbindAll"), "", 234)
    -- 获取MAC绑定信息
    entry({"api", "xqnetwork", "macbind_info"}, call("getMacBindInfo"), "", 235)
    -- 设置IP-MAC检查
    entry({"api", "xqnetwork", "ipmac_check_enable"}, call("setIPMACCheckEnable"), "", 235)
    -- 获取IP-MAC检查状态
    entry({"api", "xqnetwork", "ipmac_check_status"}, call("getIPMACCheckStatus"), "", 235)
    
    --========== PPPoE 相关接口 ==========--
    -- PPPoE状态
    entry({"api", "xqnetwork", "pppoe_status"}, call("pppoeStatus"), "", 236)
    -- PPPoE停止
    entry({"api", "xqnetwork", "pppoe_stop"}, call("pppoeStop"), "", 237)
    -- PPPoE启动
    entry({"api", "xqnetwork", "pppoe_start"}, call("pppoeStart"), "", 238)
    -- PPPoE账号捕获
    entry({"api", "xqnetwork", "pppoe_catch"}, call("pppoeCatch"), "", 264, 9)
    
    --========== QoS 流量控制接口 ==========--
    -- 获取QoS信息
    entry({"api", "xqnetwork", "qos_info"}, call("getQosInfo"), "", 239)
    -- QoS开关
    entry({"api", "xqnetwork", "qos_switch"}, call("qosSwitch"), "", 240)
    -- QoS模式
    entry({"api", "xqnetwork", "qos_mode"}, call("qosMode"), "", 241)
    -- 单设备限速
    entry({"api", "xqnetwork", "qos_limit"}, call("qosLimit"), "", 242)
    -- 批量设备限速
    entry({"api", "xqnetwork", "qos_limits"}, call("qosLimits"), "", 242)
    -- 取消限速
    entry({"api", "xqnetwork", "qos_offlimit"}, call("qosOffLimit"), "", 243)
    -- 设置带宽
    entry({"api", "xqnetwork", "set_band"}, call("setBand"), "", 244)
    
    --========== DDNS 动态域名接口 ==========--
    -- DDNS状态
    entry({"api", "xqnetwork", "ddns"}, call("ddnsStatus"), "", 253)
    -- DDNS开关
    entry({"api", "xqnetwork", "ddns_switch"}, call("ddnsSwitch"), "", 254)
    -- 添加DDNS服务器
    entry({"api", "xqnetwork", "add_server"}, call("addServer"), "", 255)
    -- 删除DDNS服务器
    entry({"api", "xqnetwork", "del_server"}, call("deleteServer"), "", 256)
    -- DDNS服务器开关
    entry({"api", "xqnetwork", "server_switch"}, call("serverSwitch"), "", 258)
    -- 重载DDNS
    entry({"api", "xqnetwork", "ddns_reload"}, call("ddnsReload"), "", 259)
    -- 编辑DDNS
    entry({"api", "xqnetwork", "ddns_edit"}, call("ddnsEdit"), "", 260)
    -- 获取DDNS服务器
    entry({"api", "xqnetwork", "get_server"}, call("getServer"), "", 261)
    
    --========== 无线中继/AP模式接口 ==========--
    -- 扫描WiFi列表
    entry({"api", "xqnetwork", "wifi_list"}, call("getScanList"), "", 262, 8)
    -- 禁用AP模式
    entry({"api", "xqnetwork", "disable_ap"}, call("disableap"), "", 263)
    -- 获取当前模式
    entry({"api", "xqnetwork", "mode"}, call("getMode"), "", 264)
    -- 设置WiFi AP模式
    entry({"api", "xqnetwork", "set_wifi_ap"}, call("setWifiApMode"), "", 266)
    -- APP设置WiFi AP模式
    entry({"api", "xqnetwork", "app_set_wifi_ap"}, call("appSetWifiApMode"), "", 286)
    -- 获取AP客户端信号
    entry({"api", "xqnetwork", "wifiap_signal"}, call("apcli_get_signal"), "", 267)
    -- 服务重启
    entry({"api", "xqnetwork", "wifiap_restart"}, call("serviceRestart"), "", 268)
    -- 设置有线AP
    entry({"api", "xqnetwork", "set_lan_ap"}, call("setLanAP"), "", 272)
    -- 禁用有线AP
    entry({"api", "xqnetwork", "disable_lan_ap"}, call("disableLanAP"), "", 273)
    -- APP WiFi AP服务重启
    entry({"api", "xqnetwork", "app_wifiap_restart"}, call("wifiAPserviceRestart"), "", 287)
    -- 获取模式状态
    entry({"api", "xqnetwork", "get_status"}, call("getModeStatus"), "", 288)
    -- 获取活动AP客户端
    entry({"api", "xqnetwork", "get_active_apcli"}, call("getActiveApcli"), "", 289)
    
    --========== 信道扫描接口 ==========--
    -- 开始信道扫描
    entry({"api", "xqnetwork", "channel_scan_start"}, call("channelScanStart"), "", 269)
    -- 获取扫描结果
    entry({"api", "xqnetwork", "channel_scan_result"}, call("getScanResult"), "", 270)
    -- 设置信道
    entry({"api", "xqnetwork", "set_channel"}, call("setChannel"), "", 271)
    
    --========== Mesh 组网接口 ==========--
    -- 扫描Mesh节点
    entry({"api", "xqnetwork", "scan_mesh_node"}, call("scanMeshNode"), "", 297)
    -- 添加Mesh节点
    entry({"api", "xqnetwork", "add_mesh_node"}, call("addMeshNode"), "", 298)
    -- 获取添加节点状态
    entry({"api", "xqnetwork", "get_addnode_status"}, call("getMeshNodeStatus"), "", 299)
    -- 获取网络模式
    entry({"api", "xqnetwork", "get_netmode"}, call("getNetMode"), "", 300)
    -- 设置SON回程模式
    entry({"api", "xqnetwork", "set_son_backhaul_mode"}, call("setSonBackhaulMode"), "", 209)
    -- 获取SON回程模式
    entry({"api", "xqnetwork", "get_son_backhaul_mode"}, call("getSonBackhaulMode"), "", 209)
    
    --========== 诊断功能接口 ==========--
    -- 获取诊断WiFi信息
    entry({"api", "xqnetwork", "wifi_diag_detail_all"}, call("getDiagAllWifiInfo"), "", 275)
    -- 获取诊断设备列表
    entry({"api", "xqnetwork", "diagdevicelist"}, call("getDiagDeviceList"), "", 276)
    -- 获取U盘状态
    entry({"api", "xqnetwork", "diagudiskstatus"}, call("getDiagUdiskStatus"), "", 277)
    -- 获取磁盘状态
    entry({"api", "xqnetwork", "diagdiskstatus"}, call("getDiagDiskStatus"), "", 278)
    -- WiFi诊断测试
    entry({"api", "xqnetwork", "diag_wifi_test"}, call("diagWifiTest"), "", 279)
    -- USB诊断测试
    entry({"api", "xqnetwork", "diag_usb_test"}, call("diagUsbTest"), "", 280)
    -- 硬盘状态
    entry({"api", "xqnetwork", "diag_hdd_status"}, call("diagHddStatus"), "", 281)
    -- 磁盘诊断测试
    entry({"api", "xqnetwork", "diag_disk_test"}, call("diagDiskTest"), "", 282)
    -- 获取诊断参数
    entry({"api", "xqnetwork", "diag_get_paras"}, call("getDiagParas"), "", 283)
    -- 设置诊断参数
    entry({"api", "xqnetwork", "diag_set_paras"}, call("setDiagParas"), "", 284)
    -- 获取诊断日志
    entry({"api", "xqnetwork", "diag_get_log"}, call("getDiagLog"), "", 285)
    
    --========== WiFi弱信号踢除接口 ==========--
    -- 设置WiFi弱信号信息
    entry({"api", "xqnetwork", "set_wifi_weak"}, call("setWifiWeakInfo"), "", 286)
    -- 获取WiFi弱信号信息
    entry({"api", "xqnetwork", "get_wifi_weak"}, call("getWifiWeakInfo"), "", 287)
    
    --========== IPv6 配置接口 ==========--
    -- 设置WAN6
    entry({"api", "xqnetwork", "set_wan6"}, call("setWan6"), "", 223, 8)
    -- IPv6状态
    entry({"api", "xqnetwork", "ipv6_status"}, call("ipv6Status"), "", 223, 8)
    
    -- IPv6 V2版本接口 (需要功能支持)
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
    
    -- IPv6防火墙
    entry({"api", "xqnetwork", "set_ipv6_firewall"}, call("setIpv6Firewall"), "", 308, 8)
    entry({"api", "xqnetwork", "get_ipv6_firewall"}, call("getIpv6Firewall"), "", 309, 8)
    
    --========== 米家扫描接口 ==========--
    -- 米家扫描开关
    entry({"api", "xqnetwork", "miscan_switch"}, call("miscanSwitch"), "", 290)
    -- 获取米家扫描开关状态
    entry({"api", "xqnetwork", "get_miscan_switch"}, call("getMiscanSwitch"), "", 291)
    
    --========== 米家中继接口 ==========--
    -- 米家中继开关
    entry({"api", "xqnetwork", "miotrelay_switch"}, call("miotrelaySwitch"), "", 306)
    -- 获取米家中继开关状态
    entry({"api", "xqnetwork", "get_miotrelay_switch"}, call("getMiotrelaySwitch"), "", 307)
    
    --========== NFC 接口 ==========--
    -- 设置NFC状态
    entry({"api", "xqnetwork", "set_nfc_status"}, call("setNfcStatus"), "", 320)
    -- 获取NFC信息
    entry({"api", "xqnetwork", "get_nfc_info"}, call("getNfcInfo"), "", 321)
    
    --========== 多WAN接口 (需要功能支持) ==========--
    if FEATURES["system"] and FEATURES["system"]["multiwan"] == "1" then
        entry({"api", "xqnetwork", "get_multiwan_basic_info"}, call("getMultiwanBasicInfo"), "", 322, 9)
        entry({"api", "xqnetwork", "get_multiwan_dev_list"}, call("getMultiwanDevList"), "", 323, 8)
        entry({"api", "xqnetwork", "get_multiwan_dev_policies"}, call("getMultiwanDevPolicies"), "", 324, 8)
        entry({"api", "xqnetwork", "set_multiwan_dev_policy"}, call("setMultiwanDevPolicy"), "", 325, 8)
        entry({"api", "xqnetwork", "set_multiwan_weight"}, call("setMultiwanWeight"), "", 326, 8)
        entry({"api", "xqnetwork", "set_multiwan_enable"}, call("setMultiwanEnable"), "", 327, 8)
        entry({"api", "xqnetwork", "set_multiwan_policy"}, call("setMultiwanPolicy"), "", 328, 8)
    end
    
    --========== TR-069 接口 (需要功能支持) ==========--
    if FEATURES["system"] and FEATURES["system"]["tr069"] == "1" then
        entry({"api", "xqnetwork", "set_cwmp"}, call("setCwmp"), "", 330)
        entry({"api", "xqnetwork", "get_cwmp_info"}, call("getCwmpInfo"), "", 331)
    end
    
    --========== WPS 接口 ==========--
    -- 获取WPS信息
    entry({"api", "xqnetwork", "get_wps_info"}, call("getWpsInfo"), "", 332)
    
    --========== 百度网盘接口 (需要功能支持) ==========--
    if FEATURES.apps and FEATURES.apps["baidupan"] == "1" then
        entry({"api", "xqnetwork", "set_router_to_baidu"}, call("setRouterToBaidu"), "", 333, 8)
        entry({"api", "xqnetwork", "set_baidu_to_router"}, call("setBaiduToRouter"), "", 334, 8)
        entry({"api", "xqnetwork", "delete_transport_list"}, call("deleteTransportList"), "", 335, 8)
        entry({"api", "xqnetwork", "get_transport_list"}, call("getTransportList"), "", 336, 8)
        entry({"api", "xqnetwork", "set_translist_action"}, call("setTransListAction"), "", 337, 8)
        entry({"api", "xqnetwork", "get_translist_file_stat"}, call("getTransListFileStat"), "", 338, 8)
        entry({"api", "xqnetwork", "get_translist_count"}, call("getTransListCount"), "", 339, 8)
    end
    
    --========== Docker 接口 (需要功能支持) ==========--
    if FEATURES.apps and FEATURES.apps["docker"] == "1" then
        entry({"api", "xqnetwork", "set_mi_docker"}, call("setMiDocker"), "", 340, 8)
        entry({"api", "xqnetwork", "set_mi_docker_environment"}, call("setMiDockerEnv"), "", 341, 8)
        entry({"api", "xqnetwork", "set_portainer_environment"}, call("setPortainerEnv"), "", 342, 8)
        entry({"api", "xqnetwork", "set_portainer_manage"}, call("setPortainerManage"), "", 343, 8)
        entry({"api", "xqnetwork", "get_docker_info"}, call("getDockerInfo"), "", 344, 8)
        entry({"api", "xqnetwork", "set_mi_docker_cancel"}, call("setMiDockerCancel"), "", 345, 8)
        entry({"api", "xqnetwork", "set_portainer_cancel"}, call("setPortainerCancel"), "", 346, 8)
    end
    
    --========== MLO (多链路操作) 接口 ==========--
    -- 设置Hostap MLO
    entry({"api", "xqnetwork", "set_hostap_mlo"}, call("setHostapMLO"), "", 372)
    -- 获取Hostap MLO
    entry({"api", "xqnetwork", "get_hostap_mlo"}, call("getHostapMLO"), "", 373)
    
    --========== TWT (目标唤醒时间) 接口 (需要功能支持) ==========--
    if FEATURES["wifi"] and FEATURES["wifi"]["twt"] == "1" then
        entry({"api", "xqnetwork", "get_twt"}, call("getTwt"), "")
        entry({"api", "xqnetwork", "set_twt"}, call("setTwt"), "")
    end
    
    --========== SFP 接口 (需要功能支持) ==========--
    if FEATURES.apps and FEATURES.apps["sfp"] == "1" then
        entry({"api", "xqnetwork", "get_sfp"}, call("GetSFPSpeed"), "", 374)
        entry({"api", "xqnetwork", "set_sfp"}, call("SetSFPSpeed"), "", 375)
    end
    
    --========== 桥接LAN状态 ==========--
    entry({"api", "xqnetwork", "bridge_lan_status"}, call("getBridgeLanStatus"), "", 382)
    
    --========== 网关安全接口 (需要功能支持) ==========--
    if FEATURES.apps and FEATURES.apps["local_gw_security"] == "1" then
        entry({"api", "xqnetwork", "set_gw_security"}, call("setGwSecurity"), "", 383)
        entry({"api", "xqnetwork", "get_gw_security"}, call("getGwSecurity"), "", 384)
    end
    
    --========== IoT WiFi 接口 (需要功能支持) ==========--
    if FEATURES["wifi"] and FEATURES["wifi"]["iot_dev"] == "1" then
        entry({"api", "xqnetwork", "get_iotwifi_info"}, call("getIotWifiInfo"), "", 385)
        entry({"api", "xqnetwork", "set_iotwifi_highprio"}, call("setIotWifiHighPrio"), "", 386)
        entry({"api", "xqnetwork", "set_iotwifi_info"}, call("setIotWifiInfo"), "", 387)
    end
    
    --========== WiFi接入控制接口 (需要功能支持) ==========--
    if FEATURES["wifi"] and FEATURES["wifi"]["wifi_access_ctl"] == "1" then
        entry({"api", "xqnetwork", "get_sta_bindinfo"}, call("getStaBindInfo"), "", 388)
        entry({"api", "xqnetwork", "set_sta_bindinfo"}, call("setStaBindInfo"), "", 389)
    end
end

--============================================================================--
--                              WiFi 管理函数                                   --
--============================================================================--

--[[
    获取WiFi状态
    返回2.4G和5G WiFi的开关状态
    @return JSON {code: 0, status: [{...}, {...}]}
--]]
function getWifiStatus()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local statusList = {}
    
    table.insert(statusList, XQWifiUtil.getWifiStatus(1))
    table.insert(statusList, XQWifiUtil.getWifiStatus(2))
    
    result.code = 0
    result.status = statusList
    http.write_json(result)
end

--[[
    获取单个WiFi详细信息
    @param wifiIndex WiFi索引 (1=2.4G, 2=5G)
    @return JSON {code: 0, info: {...}}
--]]
function getWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    
    if wifiIndex and wifiIndex < 3 then
        local allInfo = XQWifiUtil.getAllWifiInfo()
        result.info = allInfo[wifiIndex]
    else
        code = 1523
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取所有WiFi详细信息
    包括BSD(频段导航)状态和DWB(专用无线回程)状态
    @return JSON {code: 0, info: [...], bsd: 0/1, dwb_type: ..., dwb_band: ..., dwb_status: ...}
--]]
function getAllWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    local result = {}
    local code = 0
    
    local allInfo = XQWifiUtil.getAllWifiInfo()
    result.info = allInfo
    result.code = code
    
    if #result.info > 0 then
        local bsd = tonumber(result.info[1].bsd)
        result.bsd = bsd or 0
    end
    
    if DWBUtil then
        local isSupported = DWBUtil.is_supported()
        if isSupported then
            result.dwb_type = DWBUtil.mesh_get_dwb_type()
            result.dwb_band = DWBUtil.mesh_get_dwb_band()
            local dwbStatus = DWBUtil.mesh_get_dwb_status() or "0"
            result.dwb_status = tonumber(dwbStatus)
        end
    end
    
    http.write_json(result)
end

--[[
    获取WiFi连接设备列表
    @return JSON {code: 0, list: [...]}
--]]
function getWifiConDev()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.list = XQWifiUtil.getAllWifiConnetDeviceList()
    http.write_json(result)
end

--[[
    获取WiFi信道和发射功率列表
    @return JSON {code: 0, list: [...]}
--]]
function getWifiChTx()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.list = XQWifiUtil.getWifiChannelTxpwrList()
    http.write_json(result)
end

--[[
    设置WiFi发射功率
    @param txpwr 发射功率值
--]]
function setWifiTxpwr()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local txpwr = http.formvalue("txpwr")
    
    if XQFunction.isStrNil(txpwr) then
        code = 1502
    else
        XQWifiUtil.setWifiTxpwr(txpwr)
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    开启WiFi
    @param wifiIndex WiFi索引 (可选)
--]]
function turnOnWifi()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local success = XQWifiUtil.turnOnWifi(wifiIndex)
    
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    关闭WiFi
    @param wifiIndex WiFi索引 (可选)
--]]
function shutDownWifi()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local success = XQWifiUtil.shutDownWifi(wifiIndex)
    
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    设置WiFi波束成形(TxBF)
    @param txbf 波束成形开关
    @param user_confirm 用户确认标志
--]]
function setWifiTxbf()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    local cacTime = 0
    
    local requireCac = XQWifiUtil.get_require_cac()
    local txbf = http.formvalue("txbf")
    local userConfirm = http.formvalue("user_confirm")
    
    logger.log(6, "======================== txbf " .. txbf)
    
    if requireCac == true then
        cacTime = XQFunction.get_cac_time("cfg_file", "wl0", "0", "0")
    else
        cacTime = 0
    end
    
    if userConfirm == nil then
        userConfirm = "1"
    end
    
    if cacTime == 600 and userConfirm == "0" then
        result.need_confirm = 1
        result.cac_time = cacTime
        result.code = 0
        http.write_json(result)
        return true
    end
    
    if XQFunction.isStrNil(txbf) then
        code = 1502
    else
        XQWifiUtil.setWifiTxbf(txbf)
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.cac_time = cacTime
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    设置WiFi 6 (802.11ax)
    @param ax WiFi 6开关
    @param user_confirm 用户确认标志
--]]
function setWifiAx()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    local cacTime = 0
    
    local requireCac = XQWifiUtil.get_require_cac()
    local ax = http.formvalue("ax")
    local userConfirm = http.formvalue("user_confirm")
    
    if requireCac == true then
        cacTime = XQFunction.get_cac_time("cfg_file", "wl0", "0", "0")
    else
        cacTime = 0
    end
    
    if userConfirm == nil then
        userConfirm = "1"
    end
    
    if cacTime == 600 and userConfirm == "0" then
        result.need_confirm = 1
        result.cac_time = cacTime
        result.code = 0
        http.write_json(result)
        return true
    end
    
    if XQFunction.isStrNil(ax) then
        code = 1502
    else
        XQWifiUtil.setWifiAx(ax)
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.cac_time = cacTime
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    获取可用WiFi信道列表
    @param wifiIndex WiFi索引
    @return JSON {code: 0, list: [...]}
--]]
function getChannels()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local result = {}
    result.code = 0
    result.list = XQWifiUtil.getDefaultWifiChannels(wifiIndex)
    http.write_json(result)
end

--============================================================================--
--                           WAN/LAN 配置函数                                   --
--============================================================================--

--[[
    检查有线连接状态
    @return JSON {code: 0, link: true/false}
--]]
function checkWiredLink()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local link = XQLanWanUtil.checkWiredLink()
    local result = {}
    result.code = 0
    result.link = link
    http.write_json(result)
end

--[[
    获取LAN信息
    @return JSON {code: 0, info: {...}, linkList: [...]}
--]]
function getLanInfo()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local lanInfo = XQLanWanUtil.getLanWanInfo("lan")
    local linkList = XQLanWanUtil.getLanLinkList()
    local result = {}
    result.code = 0
    result.info = lanInfo
    result.linkList = linkList
    http.write_json(result)
end

--[[
    获取WAN信息
    @param wan_name WAN名称 (可选, 默认"wan")
    @return JSON {code: 0, info: {...}}
--]]
function getWanInfo()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    
    local wanName = http.formvalue("wan_name") or "WAN1"
    local mappedName = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName]
    wanName = mappedName or wanName
    if not mappedName then
        wanName = "wan"
    end
    
    local wanInfo = XQLanWanUtil.getLanWanInfo(wanName)
    local result = {}
    result.code = 0
    result.info = wanInfo
    http.write_json(result)
end

--[[
    获取WAN统计信息
    @return JSON {code: 0, statistics: {...}}
--]]
function getWanStatistics()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local stats = XQDeviceUtil.getWanLanNetworkStatistics("wan")
    local result = {}
    result.code = 0
    result.statistics = stats
    http.write_json(result)
end

--[[
    获取所有设备统计信息
    @return JSON {code: 0, statistics: [...]}
--]]
function getDevsStatistics()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local stats = XQDeviceUtil.getDevNetStatisticsList()
    local result = {}
    result.code = 0
    result.statistics = stats
    http.write_json(result)
end

--[[
    获取单个设备统计信息
    @param mac 设备MAC地址
    @return JSON {code: 0, statistics: {...}}
--]]
function getDevStatistics()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    
    local mac = http.formvalue("mac")
    local statsDict = XQDeviceUtil.getDevNetStatisticsDict()
    local formattedMac = XQFunction.macFormat(mac)
    local stats = statsDict[formattedMac]
    
    result.code = 0
    result.statistics = stats
    http.write_json(result)
end

--[[
    获取LAN DHCP配置
    @return JSON {code: 0, info: {...}}
--]]
function getLanDhcp()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local dhcpInfo = XQLanWanUtil.getLanDHCPService()
    result.code = 0
    result.info = dhcpInfo
    http.write_json(result)
end

--[[
    自动检测WAN类型
    @return JSON {code: 0, wanType: "dhcp"/"pppoe"/"static", ...}
--]]
function getAutoWanType()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQConfigs = require("xiaoqiang.common.XQConfigs")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local cursor = require("luci.model.uci").cursor()
    
    local result = {}
    local code = 0
    local wanType = XQLanWanUtil.getAutoWanType()
    
    if wanType == false then
        code = 1524
    else
        result.wanType = wanType
        result.pppoeName = cursor:get("network", "wan", "username")
        result.pppoePassword = cursor:get("network", "wan", "password")
        result.support160Mhz = XQFunction.isSupport160Mhz()
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    检测WAN链路状态
    @return JSON {code: 0/1}
--]]
function getAutoWanLink()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local LuciUtil = require("luci.util")
    local result = {}
    local code = 0
    
    os.execute("/etc/init.d/autowan off")
    os.execute("/etc/init.d/network reload_warm 2 eth0; sleep 1")
    
    local linkStatus = LuciUtil.exec("ssdk_sh port linkstatus get 2 | grep ENABLE | wc -l")
    logger.log(6, "==== getAutoWanLink() get eth0 link: " .. LuciUtil.trim(linkStatus))
    
    result.code = LuciUtil.trim(linkStatus)
    http.write_json(result)
end

--[[
    WAN断开
--]]
function wanDown()
    luci.sys.call("ifdown wan")
    local result = {}
    result.code = 0
    http.write_json(result)
end

--[[
    WAN连接
--]]
function wanUp()
    luci.sys.call("ifup wan")
    local result = {}
    result.code = 0
    http.write_json(result)
end

--============================================================================--
--                              QoS 流量控制函数                                 --
--============================================================================--

--[[
    获取QoS信息
    @return JSON {code: 0, status: {...}, band: {...}, list: [...], guest: {...}}
--]]
function getQosInfo()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local XQPreference = require("xiaoqiang.XQPreference")
    local result = {}
    result.code = 0
    
    local status = XQQoSUtil.qosStatus()
    result.status = status
    
    if status.on == 1 then
        result.band = XQQoSUtil.qosBand()
        result.list = XQQoSUtil.qosList()
        result.guest = XQQoSUtil.guestQoSInfo()
    else
        result.band = XQQoSUtil.qosBandinConf()
    end
    
    http.write_json(result)
end

--[[
    QoS开关
    @param on 开关状态 (1=开, 0=关)
--]]
function qosSwitch()
    local XQLog = require("xiaoqiang.XQLog")
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local result = {}
    result.code = 0
    
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    XQLog.check(0, XQLog.KEY_FUNC_QOS, enable and 0 or 1)
    
    local success = XQQoSUtil.qosSwitch(enable)
    if not success then
        result.code = 1606
    end
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--[[
    设置QoS模式
    @param mode QoS模式
--]]
function qosMode()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local result = {}
    result.code = 0
    
    local mode = tonumber(http.formvalue("mode"))
    local status = XQQoSUtil.qosStatus()
    
    if status and status.on == 1 then
        local success = XQQoSUtil.setQoSMode(mode)
        if not success then
            result.code = 1606
        end
    else
        result.code = 1606
    end
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--[[
    设置带宽
    @param upload 上传带宽
    @param download 下载带宽
--]]
function setBand()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local result = {}
    result.code = 0
    
    local upload = tonumber(http.formvalue("upload"))
    local download = tonumber(http.formvalue("download"))
    
    local success = XQQoSUtil.setQosBand(upload, download)
    if not success then
        result.code = 1606
    end
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--============================================================================--
--                              PPPoE 相关函数                                  --
--============================================================================--

--[[
    PPPoE状态处理函数
    @param wanName WAN名称
    @return 状态信息表
--]]
function pppoeStatusHandle(wanName)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    
    if XQFunction.isStrNil(wanName) then
        wanName = "WAN1"
    end
    
    local mappedName = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName]
    wanName = mappedName or wanName
    if not mappedName then
        wanName = "wan"
    end
    
    local code = 0
    local status = XQLanWanUtil.getPPPoEStatus(wanName)
    
    if status then
        if status.errtype == 1 then
            code = 1603
        elseif status.errtype == 2 then
            code = 1604
        elseif status.errtype == 3 then
            code = 1605
        end
    else
        code = 1602
    end
    
    if code ~= 0 then
        if code ~= 1602 then
            status.msg = string.format("%s(%s)", XQErrorUtil.getErrorMessage(code), tostring(status.errcode))
        else
            status.msg = XQErrorUtil.getErrorMessage(code)
        end
    end
    status.code = code
    return status
end

--[[
    获取PPPoE状态
    @param wan_name WAN名称 (可选)
--]]
function pppoeStatus()
    local wanName = http.formvalue("wan_name") or "WAN1"
    local status = pppoeStatusHandle(wanName)
    http.write_json(status)
end

--[[
    停止PPPoE连接
    @param wan_name WAN名称 (可选)
--]]
function pppoeStop()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    
    local wanName = http.formvalue("wan_name") or "WAN1"
    local result = {}
    result.code = 0
    
    local mappedName = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName]
    wanName = mappedName or wanName
    if not mappedName then
        wanName = "wan"
    end
    
    XQLanWanUtil.pppoeStop(wanName)
    http.write_json(result)
end

--[[
    启动PPPoE连接
    @param wan_name WAN名称 (可选)
--]]
function pppoeStart()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    
    local wanName = http.formvalue("wan_name") or "WAN1"
    local result = {}
    result.code = 0
    
    local mappedName = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName]
    wanName = mappedName or wanName
    if not mappedName then
        wanName = "wan"
    end
    
    XQLanWanUtil.pppoeStart(wanName)
    http.write_json(result)
end

--============================================================================--
--                              MAC绑定管理函数                                  --
--============================================================================--

--[[
    获取IP-MAC检查状态
    @return JSON {code: 0, enable: 0/1}
--]]
function getIPMACCheckStatus()
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local result = {}
    result.enable = XQMacBind.getIPMACCheckEnable()
    result.code = 0
    http.write_json(result)
end

--[[
    设置IP-MAC检查开关
    @param enable 开关状态
--]]
function setIPMACCheckEnable()
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local enable = http.formvalue("enable")
    local enableNum = XQFunction.checkStrToBool(enable)
    
    if enableNum ~= nil then
        code = XQMacBind.setIPMACCheckEnable(enableNum)
    else
        code = 1523
    end
    
    result.code = code
    http.write_json(result)
end

--[[
    MAC解绑
    @param mac MAC地址 (支持多个,用分号分隔)
--]]
function macUnbind()
    local LuciUtil = require("luci.util")
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local code = 0
    local result = {}
    
    local mac = http.formvalue("mac", nil, "string")
    local success = nil
    
    if mac then
        local macList = LuciUtil.split(mac, ";")
        if #macList > 1 then
            success = XQMacBind.removeBinds(macList)
        else
            success = XQMacBind.removeBind(mac)
        end
    end
    
    if not success then
        code = 1594
    end
    
    result.code = code
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    else
        XQMacBind.reload()
    end
    http.write_json(result)
end

--[[
    保存绑定配置
--]]
function saveBind()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local result = {}
    result.code = 0
    XQMacBind.saveBindInfo()
    XQMacBind.reload()
    http.write_json(result)
end

--[[
    解绑所有设备
--]]
function unbindAll()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local result = {}
    result.code = 0
    XQMacBind.unbindAll()
    XQMacBind.reload()
    http.write_json(result)
end

--[[
    获取MAC绑定信息
    @param mac 指定MAC地址 (可选)
    @return JSON {code: 0, list: [...], devicelist: [...], lanmask: "..."}
--]]
function getMacBindInfo()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local result = {}
    result.code = 0
    
    local bindList = {}
    local bindInfo = XQMacBind.macBindInfo()
    local deviceList = XQDeviceUtil.getDeviceList(true, true) or {}
    local filteredDevices = {}
    local mac = http.formvalue("mac")
    local found = 0
    
    for _, device in ipairs(deviceList) do
        local lowerMac = string.lower(device.mac)
        local info = bindInfo[lowerMac]
        if info then
            device.tag = info.tag
        else
            device.tag = 0
        end
        
        if device.port and device.port ~= 3 and device.isap == 0 then
            table.insert(filteredDevices, device)
        end
    end
    
    if mac ~= nil then
        found = 1
        if found == true then
            local upperMac = string.upper(mac)
            -- 处理指定MAC的情况
        end
    else
        for _, device in ipairs(filteredDevices) do
            table.insert(bindList, {
                name = device.name,
                mac = string.upper(device.mac),
                ip = device.ip,
                tag = device.tag,
                instance = device.instance
            })
        end
    end
    
    result.list = bindList
    if mac == nil then
        result.devicelist = filteredDevices
        result.lanmask = XQLanWanUtil.getLanWanInfo("lan").mask
    end
    http.write_json(result)
end

--============================================================================--
--                              WAN状态函数                                     --
--============================================================================--

--[[
    获取WAN状态 (IPv4 + IPv6)
    @return JSON {code: 0, ipv4: {...}, ipv6: {...}}
--]]
function getWanStatus()
    local result = {}
    result.ipv4 = pppoeStatusHandle()
    result.ipv6 = wan6InfoV2Handle()
    result.code = 0
    http.write_json(result)
end

--============================================================================--
--                              辅助函数                                        --
--============================================================================--

--[[
    根据接口名获取频段
    @param ifname 接口名称
    @return "2G" / "5G" / nil
--]]
function getBandByIfname(ifname)
    local cursor = require("luci.model.uci").cursor()
    
    local wlIfCount = cursor:get("misc", "wireless", "wl_if_count")
    local ifname2G = cursor:get("misc", "wireless", "ifname_2G")
    local ifname5G = cursor:get("misc", "wireless", "ifname_5G")
    local ifnameGuest2G = cursor:get("misc", "wireless", "ifname_guest_2G")
    local ifnameGuest5G = cursor:get("misc", "wireless", "ifname_guest_5G")
    local wifi5Bk2G = cursor:get("misc", "wireless", "wifi5_bk_2G")
    local wifi5Bk5G = cursor:get("misc", "wireless", "wifi5_bk_5G")
    
    if ifname == ifname2G or ifname == ifnameGuest2G or ifname == wifi5Bk2G then
        return "2G"
    elseif ifname == ifname5G or ifname == ifnameGuest5G or ifname == wifi5Bk5G then
        return "5G"
    end
    
    if tonumber(wlIfCount) == 3 then
        local ifname5GH = cursor:get("misc", "wireless", "ifname_5GH")
        if ifname5GH == ifname then
            return "5G"
        end
    end
    
    return nil
end

--[[
    根据接口名获取关联网络类型
    @param ifname 接口名称
    @return "master" / "guest" / "iot" / nil
--]]
function getAssocNetByIfname(ifname)
    local cursor = require("luci.model.uci").cursor()
    
    local wlIfCount = cursor:get("misc", "wireless", "wl_if_count")
    local ifname2G = cursor:get("misc", "wireless", "ifname_2G")
    local ifname5G = cursor:get("misc", "wireless", "ifname_5G")
    local ifnameGuest2G = cursor:get("misc", "wireless", "ifname_guest_2G")
    local ifnameGuest5G = cursor:get("misc", "wireless", "ifname_guest_5G")
    local wifi5Bk2G = cursor:get("misc", "wireless", "wifi5_bk_2G")
    local wifi5Bk5G = cursor:get("misc", "wireless", "wifi5_bk_5G")
    
    if ifname == ifname2G or ifname == ifname5G then
        return "master"
    elseif ifname == ifnameGuest2G or ifname == ifnameGuest5G then
        return "guest"
    elseif ifname == wifi5Bk2G or ifname == wifi5Bk5G then
        return "iot"
    end
    
    if tonumber(wlIfCount) == 3 then
        local ifname5GH = cursor:get("misc", "wireless", "ifname_5GH")
        if ifname5GH == ifname then
            return "master"
        end
    end
    
    return nil
end

--[[
    获取关联Mesh节点名称
    @param meshNodes Mesh节点列表
    @param mac MAC地址
    @return 节点名称
--]]
function getAssocMeshNodeName(meshNodes, mac)
    local nodeName = nil
    for _, node in pairs(meshNodes) do
        local found = false
        for key, value in pairs(node) do
            if key == "mac" and value == mac then
                found = true
            end
        end
        if found == true then
            for key, value in pairs(node) do
                if key == "router_name" then
                    nodeName = value
                end
            end
        end
    end
    return nodeName
end

--[[
    获取关联Mesh节点位置
    @param meshNodes Mesh节点列表
    @param mac MAC地址
    @return 节点位置
--]]
function getAssocMeshNodeLocation(meshNodes, mac)
    local location = nil
    for _, node in pairs(meshNodes) do
        local found = false
        for key, value in pairs(node) do
            if key == "mac" and value == mac then
                found = true
            end
        end
        if found == true then
            for key, value in pairs(node) do
                if key == "location" then
                    location = value
                end
            end
        end
    end
    return location
end

--[[
    获取Mesh节点列表
    @return 节点列表
--]]
function getMeshNodes()
    local cursor = require("luci.model.uci").cursor()
    local cjson = require("cjson")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    local LuciUtil = require("luci.util")
    
    local nodes = {}
    local capNode = {}
    
    local ssid = LuciUtil.exec("bdata get wl0_ssid")
    local model = LuciUtil.exec("bdata get model")
    local mac = LuciUtil.exec("getmac lan")
    
    capNode.location = cursor:get("xiaoqiang", "common", "ROUTER_LOCALE")
    capNode.router_name = LuciUtil.trim(ssid)
    capNode.model = LuciUtil.trim(model)
    capNode.mac = string.upper(LuciUtil.trim(mac))
    capNode.support_accessCtl = tonumber(cursor:get("xiaoqiang", "common", "supportWifiAccessCtl")) or 0
    capNode.cap = 1
    
    table.insert(nodes, capNode)
    
    local topoData = LuciUtil.exec("ubus -t5 call xq_info_sync_mqtt topo_dump")
    if topoData ~= nil and topoData ~= "" then
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
            
            node.cap = 0
            if hasAccessCtl == false then
                node.support_accessCtl = 0
            end
            if supportWifi == true then
                table.insert(nodes, node)
            end
        end
    end
    
    return nodes
end

--[[
    获取WiFi接入绑定信息
    @param stamac 终端MAC地址
    @return 绑定信息
--]]
function getWifiAccessBindInfo(stamac)
    local cursor = require("luci.model.uci").cursor()
    local found = false
    local bindInfo = {}
    
    cursor:foreach("wifiaccess", "wifi-sta", function(s)
        if s.stamac == stamac then
            found = true
            bindInfo.bind_node = s.bindNode
            bindInfo.bind_band = s.bindBand
            bindInfo.bind_mac = s.bindMac
        end
    end)
    
    if false == found then
        bindInfo.bind_node = "none"
        bindInfo.bind_band = "none"
        bindInfo.bind_mac = "none"
    end
    
    return bindInfo
end

--[[
    应用CAP控制条目
    @param stamac 终端MAC
    @param bindNode 绑定节点
    @param bindMac 绑定MAC
    @param bindBand 绑定频段
    @return 0=成功, 负数=失败
--]]
function applyCAPCtlEntry(stamac, bindNode, bindMac, bindBand)
    local cursor = require("luci.model.uci").cursor()
    local LuciUtil = require("luci.util")
    
    if stamac == nil or bindNode == nil or bindMac == nil or bindBand == nil then
        return -1
    end
    
    local found = false
    local sectionName = nil
    local count = 0
    
    cursor:foreach("wifiaccess", "wifi-sta", function(s)
        if string.upper(s.stamac) == string.upper(stamac) then
            sectionName = s[".name"]
            found = true
        end
        count = count + 1
    end)
    
    if sectionName == nil and bindNode == "none" and bindMac == "none" and bindBand == "none" then
        return 0
    end
    
    if found == true and sectionName ~= nil then
        if bindNode == "none" and bindMac == "none" and bindBand == "none" then
            cursor:delete("wifiaccess", sectionName)
        else
            cursor:set("wifiaccess", sectionName, "bindNode", bindNode)
            cursor:set("wifiaccess", sectionName, "bindMac", bindMac)
            cursor:set("wifiaccess", sectionName, "bindBand", bindBand)
        end
    else
        if tonumber(count) == 128 then
            return -2
        else
            local newSection = cursor:add("wifiaccess", "wifi-sta")
            cursor:set("wifiaccess", newSection, "stamac", stamac)
            cursor:set("wifiaccess", newSection, "bindNode", bindNode)
            cursor:set("wifiaccess", newSection, "bindMac", bindMac)
            cursor:set("wifiaccess", newSection, "bindBand", bindBand)
        end
    end
    
    cursor:commit("wifiaccess")
    LuciUtil.exec(string.format("ubus call xq_info_sync_mqtt sync_wifictl_config;/sbin/applyWifiAccessPolicy.sh applyItem %s %s %s", stamac, bindMac, bindBand))
    
    return 0
end

--============================================================================--
--                              诊断功能函数                                    --
--============================================================================--

--[[
    获取诊断WiFi信息
    @return JSON {code: 0, info: [...], bsd: 0/1}
--]]
function getDiagAllWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    local info = XQWifiUtil.getDiagAllWifiInfo()
    result.info = info
    result.code = code
    
    if #result.info > 0 then
        local bsd = tonumber(result.info[1].bsd)
        result.bsd = bsd or 0
    end
    
    http.write_json(result)
end

--[[
    获取IoT WiFi信息
    @return JSON {code: 0, basicInfo: {...}, advanceInfo: {...}}
--]]
function getIotWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    local info = XQWifiUtil.getIotWifiDeviceInfo()
    if info ~= nil then
        result.basicInfo = info.basicInfo
        result.advanceInfo = info.advanceInfo
    end
    
    result.code = code
    http.write_json(result)
end

--[[
    设置IoT WiFi高优先级
    @param high_priority_access 高优先级开关
--]]
function setIotWifiHighPrio()
    local cursor = require("luci.model.uci").cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    
    local highPrio = http.formvalue("high_priority_access") or "0"
    
    cursor:set("wireless", "miot_2G", "miot_access_iotdev", tonumber(highPrio))
    cursor:commit("wireless")
    
    XQFunction.forkExec("mesh_cmd sync_lite")
    
    result.code = 0
    http.write_json(result)
end

--[[
    设置IoT WiFi信息
    @param enable 启用状态
    @param ssid2g 2.4G SSID
    @param ssid5g 5G SSID
    @param encryption2g 2.4G加密方式
    @param encryption5g 5G加密方式
    @param password2g 2.4G密码
    @param password5g 5G密码
    @param wifi5mode WiFi5模式
--]]
function setIotWifiInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local cursor = require("luci.model.uci").cursor()
    local result = {}
    local code = 0
    
    local enable = http.formvalue("enable")
    local ssid2g = http.formvalue("ssid2g")
    local ssid5g = http.formvalue("ssid5g")
    local encryption2g = http.formvalue("encryption2g")
    local encryption5g = http.formvalue("encryption5g")
    local password2g = http.formvalue("password2g") or ""
    local password5g = http.formvalue("password5g") or ""
    local wifi5mode = http.formvalue("wifi5mode")
    
    cursor:set("wireless", "iot_2g", "ssid", ssid2g)
    cursor:set("wireless", "iot_2g", "iotwifi5mode", wifi5mode)
    cursor:set("wireless", "iot_2g", "encryption", encryption2g)
    cursor:set("wireless", "iot_5g", "ssid", ssid5g)
    cursor:set("wireless", "iot_5g", "iotwifi5mode", wifi5mode)
    cursor:set("wireless", "iot_5g", "encryption", encryption5g)
    
    -- 处理2.4G加密
    if encryption2g == "none" then
        cursor:set("wireless", "iot_2g", "sae", "")
        cursor:set("wireless", "iot_2g", "ieee80211w", "")
    elseif encryption2g == "ccmp" then
        cursor:set("wireless", "iot_2g", "sae", "1")
        cursor:set("wireless", "iot_2g", "key", "")
        cursor:set("wireless", "iot_2g", "sae_password", password2g)
        cursor:set("wireless", "iot_2g", "ieee80211w", "2")
    elseif encryption2g == "psk2+ccmp" then
        cursor:set("wireless", "iot_2g", "sae", "1")
        cursor:set("wireless", "iot_2g", "key", password2g)
        cursor:set("wireless", "iot_2g", "sae_password", password2g)
        cursor:set("wireless", "iot_2g", "ieee80211w", "1")
    elseif encryption2g == "psk2" or encryption2g == "mixed-psk" or encryption2g == "psk" then
        cursor:set("wireless", "iot_2g", "sae", "")
        cursor:set("wireless", "iot_2g", "sae_password", "")
        cursor:set("wireless", "iot_2g", "ieee80211w", "")
        cursor:set("wireless", "iot_2g", "key", password2g)
    end
    
    -- 处理5G加密
    if encryption5g == "none" then
        cursor:set("wireless", "iot_5g", "sae", "")
        cursor:set("wireless", "iot_5g", "ieee80211w", "")
    elseif encryption5g == "ccmp" then
        cursor:set("wireless", "iot_5g", "sae", "1")
        cursor:set("wireless", "iot_5g", "key", "")
        cursor:set("wireless", "iot_5g", "sae_password", password5g)
        cursor:set("wireless", "iot_5g", "ieee80211w", "2")
    elseif encryption5g == "psk2+ccmp" then
        cursor:set("wireless", "iot_5g", "sae", "1")
        cursor:set("wireless", "iot_5g", "key", password5g)
        cursor:set("wireless", "iot_5g", "sae_password", password5g)
        cursor:set("wireless", "iot_5g", "ieee80211w", "")
    elseif encryption5g == "psk2" or encryption5g == "mixed-psk" or encryption5g == "psk" then
        cursor:set("wireless", "iot_5g", "sae", "")
        cursor:set("wireless", "iot_5g", "sae_password", "")
        cursor:set("wireless", "iot_5g", "ieee80211w", "")
        cursor:set("wireless", "iot_5g", "key", password5g)
    end
    
    -- 处理启用/禁用
    if tonumber(enable) == 0 then
        cursor:set("wireless", "iot_2g", "disabled", 1)
        cursor:set("wireless", "iot_5g", "disabled", 1)
    else
        cursor:set("wireless", "iot_2g", "disabled", 0)
        cursor:set("wireless", "iot_5g", "disabled", 0)
    end
    
    cursor:commit("wireless")
    XQFunction.forkExec("/sbin/wifi update >/dev/null 2>/dev/null")
    
    result.code = code
    http.write_json(result)
end

--[[
    获取终端绑定信息
    @param sta_mac 终端MAC地址
--]]
function getStaBindInfo()
    local cjson = require("cjson")
    local LuciUtil = require("luci.util")
    local meshNodes = getMeshNodes()
    local XQLog = require("xiaoqiang.XQLog")
    local result = {}
    local code = 0
    
    local staMac = http.formvalue("sta_mac")
    local stationInfo = getStationInfo(staMac, meshNodes)
    
    if stationInfo ~= nil then
        result.associnfo = stationInfo
        result.meshnode = meshNodes
        local bindInfo = getWifiAccessBindInfo(staMac)
        result.bindinfo = bindInfo
    else
        code = -1
    end
    
    result.code = code
    http.write_json(result)
end

--[[
    设置终端绑定信息
    @param stamac 终端MAC
    @param bindNode 绑定节点
    @param bindMac 绑定MAC
    @param bindBand 绑定频段
--]]
function setStaBindInfo()
    local LuciUtil = require("luci.util")
    
    local stamac = http.formvalue("stamac") or ""
    local bindNode = http.formvalue("bindNode") or ""
    local bindMac = http.formvalue("bindMac") or ""
    local bindBand = http.formvalue("bindBand") or ""
    
    local result = {}
    local code = 0
    
    code = applyCAPCtlEntry(stamac, bindNode, bindMac, bindBand)
    
    result.code = code
    http.write_json(result)
end

--[[
    获取WiFi弱信号信息
    @return JSON {code: 0, info: {...}}
--]]
function getWifiWeakInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    result.info = XQWifiUtil.getWifiWeakInfo()
    result.code = code
    http.write_json(result)
end

--[[
    设置WiFi弱信号信息
    @param wifiIndex WiFi索引
    @param weakenable 弱信号踢除开关
    @param weakthreshold 弱信号阈值
    @param kickthreshold 踢除阈值
--]]
function setWifiWeakInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local weakEnable = http.formvalue("weakenable")
    local weakThreshold = http.formvalue("weakthreshold")
    local kickThreshold = http.formvalue("kickthreshold")
    
    local success = XQWifiUtil.setWifiWeakInfo(wifiIndex, weakEnable, weakThreshold, kickThreshold)
    if success == false then
        code = 1502
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    米家扫描开关
    @param on 开关状态 (1=开, 0=关)
--]]
function miscanSwitch()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    local success = XQWifiUtil.miscanSwitch(enable)
    if not success then
        result.code = 1606
    end
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--[[
    获取米家扫描开关状态
    @return JSON {code: 0, enabled: 0/1}
--]]
function getMiscanSwitch()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.enabled = tonumber(XQWifiUtil.getMiscanSwitch())
    http.write_json(result)
end

--[[
    米家中继开关
    @param on 开关状态 (1=开, 0=关)
--]]
function miotrelaySwitch()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local LuciUtil = require("luci.util")
    local cursor = require("luci.model.uci").cursor()
    
    local bindStatus = cursor:get("wireless", "miot_2G", "bindstatus") or "0"
    local userSwitch = cursor:get("wireless", "miot_2G", "userswitch") or "0"
    local if2G = cursor:get("misc", "wireless", "if_2G") or ""
    local result = {}
    result.code = 0
    
    local on = tonumber(http.formvalue("on"))
    local newSwitch = (on == 1) and "1" or "0"
    
    if bindStatus == "1" then
        if userSwitch == "0" and newSwitch == "1" then
            if "wifi0" == if2G then
                LuciUtil.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 enable")
            elseif "wifi1" == if2G then
                LuciUtil.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 enable")
            else
                LuciUtil.exec("ifconfig wl13 up")
            end
            LuciUtil.exec("/usr/sbin/sysapi miot")
        elseif userSwitch == "1" and newSwitch == "0" then
            if "wifi0" == if2G then
                LuciUtil.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 disable")
            elseif "wifi1" == if2G then
                LuciUtil.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 disable")
            else
                LuciUtil.exec("ifconfig wl13 down")
            end
        end
    end
    
    cursor:set("wireless", "miot_2G", "userswitch", newSwitch)
    cursor:commit("wireless")
    
    XQFunction.forkExec([[
        [ -f "/etc/init.d/miot" ] && /etc/init.d/miot restart;
        /sbin/whc_to_re_common_api.sh whc_sync;
    ]])
    
    http.write_json(result)
end

--[[
    获取米家中继开关状态
    @return JSON {code: 0, enabled: 0/1}
--]]
function getMiotrelaySwitch()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local LuciUtil = require("luci.util")
    local cursor = require("luci.model.uci").cursor()
    
    local userSwitch = cursor:get("wireless", "miot_2G", "userswitch") or "0"
    local result = {}
    result.code = 0
    result.enabled = tonumber(userSwitch)
    http.write_json(result)
end

--[[
    添加内容到文件
    @param srcFile 源文件路径
    @param destFile 目标文件路径
    @return true=成功, false=失败
--]]
function addtofile(srcFile, destFile)
    local content
    local srcHandle = io.open(srcFile, "r")
    if srcHandle then
        content = srcHandle:read("*a")
        srcHandle:close()
        if content == nil then
            return false
        end
    else
        return false
    end
    
    local destHandle = io.open(destFile, "a")
    if destHandle then
        local success = destHandle:write(content)
        if success == nil then
            destHandle:close()
            return false
        end
        destHandle:write(string.format("\n"))
        destHandle:close()
        return true
    else
        return false
    end
end

--[[
    获取诊断日志
    @return JSON {code: 0, logUrl: "..."}
--]]
function getDiagLog()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local LuciUtil = require("luci.util")
    local cursor = require("luci.model.uci").cursor()
    local nixioFs = require("nixio.fs")
    local luciSys = require("luci.sys")
    
    local backupPath = "/tmp/syslogbackup/"
    local lanIp = cursor:get("network", "lan", "ipaddr") or "192.168.31.1"
    local result = {}
    result.code = 0
    
    local logFile = "/tmp/diag_test.log"
    
    addtofile("/tmp/diag_net_spd", logFile)
    addtofile("/tmp/diag_sta_sig", logFile)
    addtofile("/tmp/diag_sta_iperf", logFile)
    addtofile("/tmp/diag_usb_test", logFile)
    addtofile("/tmp/diag_disk_smart", logFile)
    addtofile("/tmp/diag_disk_rd_test", logFile)
    
    local function sane()
        return luciSys.process.info("uid") == nixioFs.stat(backupPath, "uid")
    end
    
    local function prepare()
        nixioFs.mkdir(backupPath, 700)
    end
    
    if not sane() then
        prepare()
    else
        os.execute("rm " .. backupPath .. "*.diag.log")
    end
    
    if nixioFs.access(logFile) then
        local sn = XQNetUtil.getSN()
        local slashPos = string.find(sn, "/")
        local snPart1 = string.sub(sn, 1, slashPos - 1)
        local snPart2 = string.sub(sn, slashPos + 1, string.len(sn))
        local filename = snPart1 .. "-" .. snPart2 .. "--" .. os.date("%Y-%m-%d--%X", os.time()) .. ".diag.log"
        
        LuciUtil.exec("cp " .. logFile .. " " .. backupPath .. filename)
        LuciUtil.exec("rm " .. logFile)
        
        result.logUrl = lanIp .. "/backup/log/" .. filename
    else
        result.code = 1
        result.msg = "There is no diag test log, not test yet?"
    end
    
    http.write_json(result)
end

--============================================================================--
--                              WiFi 设置函数                                    --
--============================================================================--

--[[
    设置WiFi参数
    @param wifiIndex WiFi索引 (1=2.4G, 2=5G, 3=访客)
    @param ssid WiFi名称
    @param pwd WiFi密码
    @param encryption 加密方式
    @param channel 信道
    @param bandwidth 带宽
    @param txpwr 发射功率
    @param hidden 隐藏SSID
    @param on 开关状态
    @param txbf 波束成形
    @param weakenable 弱信号踢除开关
    @param weakthreshold 弱信号阈值
    @param kickthreshold 踢除阈值
    @param ax WiFi6开关
--]]
function setWifi()
    local XQLog = require("xiaoqiang.XQLog")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local ssid = http.formvalue("ssid")
    local pwd = http.formvalue("pwd")
    local encryption = http.formvalue("encryption")
    local channel = http.formvalue("channel")
    local bandwidth = http.formvalue("bandwidth")
    local txpwr = http.formvalue("txpwr")
    local hidden = http.formvalue("hidden")
    local on = http.formvalue("on")
    local txbf = http.formvalue("txbf")
    local weakEnable = http.formvalue("weakenable")
    local weakThreshold = http.formvalue("weakthreshold")
    local kickThreshold = http.formvalue("kickthreshold")
    local ax = http.formvalue("ax")
    
    if on ~= nil then
        on = tonumber(on)
    end
    
    if wifiIndex == 1 then
        if channel then
            XQLog.check(0, XQLog.KEY_FUNC_2G_CHANNEL, channel)
        end
        if txpwr then
            XQLog.check(0, XQLog.KEY_FUNC_2G_SIGNAL, txpwr)
        end
    elseif wifiIndex == 2 then
        if channel then
            XQLog.check(0, XQLog.KEY_FUNC_5G_CHANNEL, channel)
        end
        if txpwr then
            XQLog.check(0, XQLog.KEY_FUNC_5G_SIGNAL, txpwr)
        end
    end
    
    local needRestart = true
    local notifyMiio = false
    
    if wifiIndex == 1 then
        local basicInfo = XQWifiUtil.getWifiBasicInfo(wifiIndex)
        if basicInfo.password == nil then
            basicInfo.password = ""
        end
        if basicInfo.ssid ~= ssid or basicInfo.password ~= pwd or basicInfo.encryption ~= encryption then
            notifyMiio = true
        end
    end
    
    code = XQWifiUtil.checkSSID(ssid, 31)
    
    if code == 0 then
        if wifiIndex == 1 or wifiIndex == 2 then
            local success = XQWifiUtil.setWifiBasicInfo(wifiIndex, ssid, pwd, encryption, channel, txpwr, hidden, on, bandwidth, nil, txbf, weakEnable, weakThreshold, kickThreshold, ax)
            if success == false then
                code = XQWifiUtil.checkWifiPasswd(pwd, encryption)
            end
        elseif wifiIndex == 3 then
            needRestart = true
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        if needRestart then
            if notifyMiio then
                XQFunction.forkRestartWifiNotify()
            else
                XQFunction.forkRestartWifiNotifyButMiio()
            end
        end
    end
end

--[[
    设置WiFi参数(不重启WiFi)
    参数同setWifi
--]]
function setWifiWithoutRestart()
    local XQLog = require("xiaoqiang.XQLog")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local ssid = http.formvalue("ssid")
    local pwd = http.formvalue("pwd")
    local encryption = http.formvalue("encryption")
    local channel = http.formvalue("channel")
    local bandwidth = http.formvalue("bandwidth")
    local txpwr = http.formvalue("txpwr")
    local hidden = http.formvalue("hidden")
    local on = http.formvalue("on")
    local txbf = http.formvalue("txbf")
    local ax = http.formvalue("ax")
    
    if on ~= nil then
        on = tonumber(on)
    end
    
    if channel == "0" then
        bandwidth = "0"
    end
    
    if wifiIndex == 1 then
        if channel then
            XQLog.check(0, XQLog.KEY_FUNC_2G_CHANNEL, channel)
        end
        if txpwr then
            XQLog.check(0, XQLog.KEY_FUNC_2G_SIGNAL, txpwr)
        end
    elseif wifiIndex == 2 then
        if channel then
            XQLog.check(0, XQLog.KEY_FUNC_5G_CHANNEL, channel)
        end
        if txpwr then
            XQLog.check(0, XQLog.KEY_FUNC_5G_SIGNAL, txpwr)
        end
    end
    
    code = XQWifiUtil.checkSSID(ssid, 31)
    
    if code == 0 then
        if wifiIndex == 1 or wifiIndex == 2 then
            local success = XQWifiUtil.setWifiBasicInfo(wifiIndex, ssid, pwd, encryption, channel, txpwr, hidden, on, bandwidth, nil, txbf, nil, nil, nil, ax)
            if success == false then
                code = XQWifiUtil.checkWifiPasswd(pwd, encryption)
            end
        elseif wifiIndex == 3 then
            local XQGuestWifi = require("xiaoqiang.module.XQGuestWifi")
            local XQWifiShare = require("xiaoqiang.module.XQWifiShare")
            local success = XQGuestWifi.setGuestWifi(1, ssid, encryption, pwd, 1, on)
            if success == false then
                code = 1615
            else
                if encryption ~= "none" and on == 1 then
                    XQWifiShare.wifi_share_switch(0)
                end
            end
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WiFi参数(用于setAllWifi的辅助函数)
    @param wifiIndex WiFi索引
    @return 参数表
--]]
local function getWifiParams(wifiIndex)
    local params = {}
    params.on = http.formvalue("on" .. wifiIndex)
    params.ssid = http.formvalue("ssid" .. wifiIndex)
    params.passwd = http.formvalue("pwd" .. wifiIndex) or ""
    params.encryption = http.formvalue("encryption" .. wifiIndex)
    params.channel = http.formvalue("channel" .. wifiIndex)
    params.txpwr = http.formvalue("txpwr" .. wifiIndex)
    params.hidden = http.formvalue("hidden" .. wifiIndex)
    params.bw = http.formvalue("bandwidth" .. wifiIndex)
    params.txbf = http.formvalue("txbf" .. wifiIndex)
    params.ax = http.formvalue("ax" .. wifiIndex)
    return params
end

--[[
    设置所有WiFi
    同时设置2.4G和5G WiFi参数
--]]
function setAllWifi()
    local XQLog = require("xiaoqiang.XQLog")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local bsd = http.formvalue("bsd")
    local params1 = getWifiParams(1)
    local params2 = getWifiParams(2)
    
    if params1.channel then
        XQLog.check(0, XQLog.KEY_FUNC_2G_CHANNEL, params1.channel)
    end
    if params1.txpwr then
        XQLog.check(0, XQLog.KEY_FUNC_2G_SIGNAL, params1.txpwr)
    end
    if params2.channel then
        XQLog.check(0, XQLog.KEY_FUNC_5G_CHANNEL, params2.channel)
    end
    if params2.txpwr then
        XQLog.check(0, XQLog.KEY_FUNC_5G_SIGNAL, params2.txpwr)
    end
    
    local wifiList = {params1, params2}
    code = XQWifiUtil.setAllWifiInfo(wifiList, bsd)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    设置专用无线回程(DWB)WiFi
    @param dwb_status DWB状态
--]]
function setDWBWifi()
    local DWBUtil = require("xiaoqiang.util.DedicatedWirelessBackhaulUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local dwbStatus = http.formvalue("dwb_status")
    
    if DWBUtil then
        local isSupported = DWBUtil.is_supported()
        if isSupported then
            DWBUtil.mesh_set_dwb_status(dwbStatus)
        else
            code = 1502
        end
    else
        code = 1502
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    设置WiFi静默模式
    @param status 静默状态
    @param start_time 开始时间
    @param end_time 结束时间
--]]
function setWifiSilence()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    local code = 0
    
    local status = http.formvalue("status")
    local startTime = http.formvalue("start_time")
    local endTime = http.formvalue("end_time")
    
    local success = XQWifiUtil.setWifiSilence(status, startTime, endTime)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WiFi静默模式状态
    @return JSON {code: 0, status: ..., start_time: ..., end_time: ...}
--]]
function getWifiSilence()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    
    local silenceInfo = XQWifiUtil.getWifiSilence()
    if silenceInfo then
        result.status = silenceInfo.status
        result.start_time = silenceInfo.start_time
        result.end_time = silenceInfo.end_time
    end
    
    http.write_json(result)
end

--============================================================================--
--                              LAN/WAN 设置函数                                 --
--============================================================================--

--[[
    设置LAN IP地址
    @param ip IP地址
    @param mask 子网掩码
--]]
function setLanIp()
    local XQLog = require("xiaoqiang.XQLog")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    local datatypes = require("luci.cbi.datatypes")
    local result = {}
    local code = 0
    
    local ip = http.formvalue("ip")
    local mask = http.formvalue("mask")
    
    if not datatypes.ipaddr(ip) then
        code = 1525
    elseif not datatypes.ipaddr(mask) then
        code = 1527
    elseif XQFunction.lan_wan_ip_conflict_chk(ip, mask) then
        code = 1526
    else
        code = XQLanWanUtil.checkLanIpMask(ip, mask)
    end
    
    if code == 0 then
        XQLanWanUtil.setLanIp(ip, mask)
        XQFunction.lan_ip_conflict_resolution()
        result.ip = ip
    else
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        if FEATURES.system and FEATURES.system.tr069 == "1" then
            local cmd = nil
            if XQFunction.isMeshCap() then
                cmd = "sh /sbin/whc_to_re_common_api.sh gw_update " .. ip .. "; sleep 3;"
                logger.log(4, string.format("@ activate cmd=%s!", cmd))
            end
            local isTr069 = http.formvalue("is_tr069")
            if not isTr069 then
                if cmd then
                    cmd = cmd .. "reboot"
                else
                    cmd = "reboot"
                end
            end
            if cmd then
                XQFunction.forkExec(cmd)
            end
        else
            if XQFunction.isMeshCap() then
                local cmd = "sh /sbin/whc_to_re_common_api.sh gw_update " .. ip .. "; sleep 3; reboot"
                logger.log(4, string.format("@ activate cmd=%s!", cmd))
                XQFunction.forkExec(cmd)
            else
                XQFunction.forkReboot()
            end
        end
    end
end

--[[
    内部WAN设置函数
    @param params WAN参数表
    @return 错误码
--]]
local function _setWan(params)
    local XQLog = require("xiaoqiang.XQLog")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    local code = 0
    
    if XQFunction.isStrNil(params.wanType) and XQFunction.isStrNil(params.username) and 
       XQFunction.isStrNil(params.password) and XQFunction.isStrNil(params.ip) and 
       XQFunction.isStrNil(params.mask) and XQFunction.isStrNil(params.gw) and 
       XQFunction.isStrNil(params.dns1) and XQFunction.isStrNil(params.dns2) and 
       XQFunction.isStrNil(params.autoset) and XQFunction.isStrNil(params.special) then
        return 1502
    end
    
    if XQFunction.isStrNil(params.dns1) and XQFunction.isStrNil(params.dns2) then
        params.autoset = "1"
    else
        params.autoset = "0"
    end
    
    local wanDevCfg = XQLanWanUtil.get_wanDevCfg(params.wanConn, "Router", params.wanType, 4)
    params.wanDevCfg = wanDevCfg
    
    if not wanDevCfg then
        XQLog.log(3, "_setWan: get wanDevCfg failed!")
        return 1529
    end
    
    if FEATURES.system and FEATURES.system.international == "1" then
        if params.wanType == "l2tp" or params.wanType == "pptp" then
            if params.client == "web" then
                XQLog.check(0, XQLog.KEY_VALUE_NETWORK_VPN, 1)
            end
            code = XQLanWanUtil.chkWan4VPN(params.wanType, params.vpnServer, params.vpnUsername, params.vpnPassword)
            if code == 0 then
                if params.baseWanType then
                    if params.baseWanType == "dhcp" then
                        code = XQLanWanUtil.chkWan4Dhcp(params.autoset, params.dns1, params.dns2)
                    elseif params.baseWanType == "static" then
                        code = XQLanWanUtil.chkWan4StaticIP(params.ipChk, params.ip, params.mask, params.gw, params.dns1, params.dns2)
                    elseif params.baseWanType == "pppoe" then
                        code = XQLanWanUtil.chkWan4PPPoE(params.autoset, params.username, params.password, params.mtu, params.dns1, params.dns2, params.service)
                    else
                        code = 1537
                    end
                else
                    code = 1537
                end
                if code ~= 0 then
                    return code
                end
            else
                return code
            end
            code = XQLanWanUtil.setWan4VPN(params)
            if code ~= 0 then
                return code
            end
            if params.baseWanType == "dhcp" then
                code = XQLanWanUtil.setWan4Dhcp(params)
            elseif params.baseWanType == "static" then
                code = XQLanWanUtil.setWan4StaticIP(params)
            elseif params.baseWanType == "pppoe" then
                if XQFunction.isStrNil(params.dns1) and XQFunction.isStrNil(params.dns2) then
                    if params.autoset == "0" then
                        params.autoset = "1"
                    end
                end
                code = XQLanWanUtil.setWan4PPPoE(params)
            end
            return code
        else
            code = XQLanWanUtil.stopWan4VPN(params)
            if code ~= 0 then
                return code
            end
        end
    end
    
    if params.wanType == "pppoe" then
        if params.client == "web" then
            XQLog.check(0, XQLog.KEY_VALUE_NETWORK_PPPOE, 1)
        end
        code = XQLanWanUtil.chkWan4PPPoE(params.autoset, params.username, params.password, params.mtu, params.dns1, params.dns2, params.service)
        if code == 0 then
            if XQFunction.isStrNil(params.dns1) and XQFunction.isStrNil(params.dns2) then
                if params.autoset == "0" then
                    params.autoset = "1"
                end
            end
            code = XQLanWanUtil.setWan4PPPoE(params)
        end
    elseif params.wanType == "dhcp" then
        if params.client == "web" then
            XQLog.check(0, XQLog.KEY_VALUE_NETWORK_DHCP, 1)
        end
        code = XQLanWanUtil.chkWan4Dhcp(params.autoset, params.dns1, params.dns2)
        if code == 0 then
            code = XQLanWanUtil.setWan4Dhcp(params)
        end
    elseif params.wanType == "static" then
        if params.client == "web" then
            XQLog.check(0, XQLog.KEY_VALUE_NETWORK_STATIC, 1)
        end
        code = XQLanWanUtil.chkWan4StaticIP(params.ipChk, params.ip, params.mask, params.gw, params.dns1, params.dns2)
        if code == 0 then
            code = XQLanWanUtil.setWan4StaticIP(params)
        end
    end
    
    return code
end

--[[
    设置WAN配置
    @param wanType WAN类型 (dhcp/pppoe/static)
    @param pppoeName PPPoE用户名
    @param pppoePwd PPPoE密码
    @param staticIp 静态IP
    @param staticMask 静态子网掩码
    @param staticGateway 静态网关
    @param dns1 DNS1
    @param dns2 DNS2
--]]
function setWan()
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    local result = {}
    local params = {}
    
    local wanName = http.formvalue("wan_name") or "WAN1"
    params.client = http.formvalue("client")
    params.wanType = http.formvalue("wanType")
    params.username = http.formvalue("pppoeName")
    params.password = http.formvalue("pppoePwd")
    params.ip = http.formvalue("staticIp")
    params.mask = http.formvalue("staticMask")
    params.gw = http.formvalue("staticGateway")
    params.dns1 = http.formvalue("dns1")
    params.dns2 = http.formvalue("dns2")
    params.special = http.formvalue("special") or ""
    params.mtu = http.formvalue("mtu")
    params.service = http.formvalue("service")
    params.autoset = http.formvalue("autoset") or ""
    params.wanConn = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName] or "wan"
    params.ipChk = "1"
    params.baseWanType = http.formvalue("baseWanType")
    params.vpnServer = http.formvalue("vpnServer")
    params.vpnUsername = http.formvalue("vpnUsername")
    params.vpnPassword = http.formvalue("vpnPassword")
    
    result.code = _setWan(params)
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--[[
    设置WAN配置(新版，不检查IP冲突)
--]]
function setWanNew()
    local XQPortServiceUtil = require("xiaoqiang.util.XQPortServiceUtil")
    local result = {}
    local params = {}
    
    local wanName = http.formvalue("wan_name") or "WAN1"
    params.client = http.formvalue("client")
    params.wanType = http.formvalue("wanType")
    params.username = http.formvalue("pppoeName")
    params.password = http.formvalue("pppoePwd")
    params.ip = http.formvalue("staticIp")
    params.mask = http.formvalue("staticMask")
    params.gw = http.formvalue("staticGateway")
    params.dns1 = http.formvalue("dns1")
    params.dns2 = http.formvalue("dns2")
    params.special = http.formvalue("special") or ""
    params.mtu = http.formvalue("mtu")
    params.service = http.formvalue("service")
    params.autoset = http.formvalue("autoset") or ""
    params.wanConn = XQPortServiceUtil.PS_WAN_SERVICE_NAME_MAP[wanName] or "wan"
    params.ipChk = "0"
    params.baseWanType = http.formvalue("baseWanType")
    params.vpnServer = http.formvalue("vpnServer")
    params.vpnUsername = http.formvalue("vpnUsername")
    params.vpnPassword = http.formvalue("vpnPassword")
    
    result.code = _setWan(params)
    
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
end

--[[
    设置LAN DHCP配置
    @param start DHCP起始地址
    @param limit DHCP地址数量
    @param leasetime 租约时间
--]]
function setLanDhcp()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local result = {}
    local code = 0
    
    local start = XQSecureUtil.parseCmdline(http.formvalue("start"))
    local limit = XQSecureUtil.parseCmdline(http.formvalue("limit"))
    local leasetime = XQSecureUtil.parseCmdline(http.formvalue("leasetime"))
    
    code = XQLanWanUtil.setLanDHCPService(start, limit, leasetime)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    MAC克隆
    @param mac 要克隆的MAC地址
--]]
function setWanMac()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    
    if XQFunction.isStrNil(mac) then
        code = 1502
    else
        local success = XQLanWanUtil.setWanMac(mac)
        if not success then
            code = 1606
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WAN速度
    @return JSON {code: 0, speed: ...}
--]]
function getWanSpeed()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.speed = XQLanWanUtil.getWanSpeed()
    http.write_json(result)
end

--[[
    设置WAN速度
    @param speed WAN速度
--]]
function setWanSpeed()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local code = 0
    
    local speed = http.formvalue("speed")
    local success = XQLanWanUtil.setWanSpeed(speed)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WAN链路状态
    @return JSON {code: 0, link: true/false}
--]]
function getWanLinkStatus()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.link = XQLanWanUtil.getWanLinkStatus()
    http.write_json(result)
end

--[[
    WAN/LAN端口交换
    @param swap 交换状态
--]]
function setWanLanSwap()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local swap = http.formvalue("swap")
    local success = XQLanWanUtil.setWanLanSwap(swap)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkReboot()
    end
end

--[[
    获取WAN端口状态
    @return JSON {code: 0, status: {...}}
--]]
function getWanPortStatus()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.status = XQLanWanUtil.getWanPortStatus()
    http.write_json(result)
end

--[[
    获取WAN/LAN端口配置
    @return JSON {code: 0, config: {...}}
--]]
function getWanLanPort()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.config = XQLanWanUtil.getWanLanPort()
    http.write_json(result)
end

--[[
    设置WAN/LAN端口配置
    @param config 端口配置
--]]
function setWanLanPort()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local config = http.formvalue("config")
    local success = XQLanWanUtil.setWanLanPort(config)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WAN/LAN模式
    @return JSON {code: 0, mode: ...}
--]]
function getWanLanMode()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.mode = XQLanWanUtil.getWanLanMode()
    http.write_json(result)
end

--============================================================================--
--                              MAC过滤函数                                     --
--============================================================================--

--[[
    获取WiFi MAC过滤信息
    @return JSON {code: 0, info: {...}}
--]]
function getWifiMacfilterInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.info = XQWifiUtil.getWifiMacfilterInfo()
    http.write_json(result)
end

--[[
    设置WiFi MAC过滤
    @param model 过滤模式
    @param mac MAC地址列表
--]]
function setWifiMacfilter()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local model = http.formvalue("model")
    local mac = http.formvalue("mac")
    
    local success = XQWifiUtil.setWifiMacfilter(model, mac)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    编辑设备信息
    @param mac 设备MAC
    @param name 设备名称
--]]
function editDevice()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local name = http.formvalue("name")
    
    local success = XQDeviceUtil.editDevice(mac, name)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    忽略风险设备
    @param mac 设备MAC
--]]
function ignoreRiskDevice()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    
    local success = XQDeviceUtil.ignoreRiskDevice(mac)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    手动添加设备
    @param mac 设备MAC
    @param name 设备名称
--]]
function manuallyAdd()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local name = http.formvalue("name")
    
    local success = XQDeviceUtil.manuallyAdd(mac, name)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    MAC绑定
    @param mac MAC地址
    @param ip IP地址
--]]
function macBind()
    local XQMacBind = require("xiaoqiang.module.XQMacBind")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local ip = http.formvalue("ip")
    
    local success = XQMacBind.addBind(mac, ip)
    if not success then
        code = 1594
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    else
        XQMacBind.reload()
    end
    result.code = code
    http.write_json(result)
end

--============================================================================--
--                              QoS 限速函数                                    --
--============================================================================--

--[[
    单设备限速
    @param mac 设备MAC
    @param upload 上传限速
    @param download 下载限速
--]]
function qosLimit()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local upload = tonumber(http.formvalue("upload"))
    local download = tonumber(http.formvalue("download"))
    
    local success = XQQoSUtil.qosOnLimit(mac, upload, download)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    批量设备限速
    @param data JSON格式的限速数据
--]]
function qosLimits()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local cjson = require("cjson")
    local result = {}
    local code = 0
    
    local data = http.formvalue("data")
    if data then
        local limitData = cjson.decode(data)
        local success = XQQoSUtil.qosOnLimits(limitData)
        if not success then
            code = 1606
        end
    else
        code = 1502
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    取消设备限速
    @param mac 设备MAC
--]]
function qosOffLimit()
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    
    local success = XQQoSUtil.qosOffLimit(mac)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--============================================================================--
--                              DDNS 动态域名函数                                --
--============================================================================--

--[[
    获取DDNS状态
    @return JSON {code: 0, on: 0/1, list: [...]}
--]]
function ddnsStatus()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    result.code = 0
    
    local ddnsInfo = XQDDNSUtil.ddnsStatus()
    result.on = ddnsInfo.on
    result.list = ddnsInfo.list
    
    http.write_json(result)
end

--[[
    DDNS开关
    @param on 开关状态
--]]
function ddnsSwitch()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    local code = 0
    
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    local success = XQDDNSUtil.ddnsSwitch(enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    添加DDNS服务器
    @param provider 服务提供商
    @param domain 域名
    @param username 用户名
    @param password 密码
--]]
function addServer()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    local code = 0
    
    local provider = http.formvalue("provider")
    local domain = http.formvalue("domain")
    local username = http.formvalue("username")
    local password = http.formvalue("password")
    
    local success = XQDDNSUtil.addServer(provider, domain, username, password)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    删除DDNS服务器
    @param id 服务器ID
--]]
function deleteServer()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    local code = 0
    
    local id = http.formvalue("id")
    
    local success = XQDDNSUtil.deleteServer(id)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    DDNS服务器开关
    @param id 服务器ID
    @param on 开关状态
--]]
function serverSwitch()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    local code = 0
    
    local id = http.formvalue("id")
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    local success = XQDDNSUtil.serverSwitch(id, enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    重载DDNS配置
--]]
function ddnsReload()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    result.code = 0
    XQDDNSUtil.ddnsReload()
    http.write_json(result)
end

--[[
    编辑DDNS配置
    @param id 服务器ID
    @param provider 服务提供商
    @param domain 域名
    @param username 用户名
    @param password 密码
--]]
function ddnsEdit()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    local code = 0
    
    local id = http.formvalue("id")
    local provider = http.formvalue("provider")
    local domain = http.formvalue("domain")
    local username = http.formvalue("username")
    local password = http.formvalue("password")
    
    local success = XQDDNSUtil.ddnsEdit(id, provider, domain, username, password)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取DDNS服务器信息
    @param id 服务器ID
    @return JSON {code: 0, info: {...}}
--]]
function getServer()
    local XQDDNSUtil = require("xiaoqiang.util.XQDDNSUtil")
    local result = {}
    result.code = 0
    
    local id = http.formvalue("id")
    result.info = XQDDNSUtil.getServer(id)
    
    http.write_json(result)
end

--============================================================================--
--                              无线中继/AP模式函数                               --
--============================================================================--

--[[
    扫描WiFi列表
    @return JSON {code: 0, list: [...]}
--]]
function getScanList()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.list = XQWifiUtil.getScanList()
    http.write_json(result)
end

--[[
    禁用AP模式
--]]
function disableap()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    result.code = 0
    
    XQWifiUtil.disableap()
    
    http.write_json(result)
    http.close()
    XQFunction.forkReboot()
end

--[[
    获取当前模式
    @return JSON {code: 0, mode: ...}
--]]
function getMode()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.mode = XQWifiUtil.getMode()
    http.write_json(result)
end

--[[
    设置WiFi AP模式
    @param ssid 上级WiFi SSID
    @param password 上级WiFi密码
    @param encryption 加密方式
    @param channel 信道
    @param band 频段
--]]
function setWifiApMode()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local ssid = http.formvalue("ssid")
    local password = http.formvalue("password")
    local encryption = http.formvalue("encryption")
    local channel = http.formvalue("channel")
    local band = http.formvalue("band")
    
    code = XQWifiUtil.setWifiApMode(ssid, password, encryption, channel, band)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkReboot()
    end
end

--[[
    APP设置WiFi AP模式
--]]
function appSetWifiApMode()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local ssid = http.formvalue("ssid")
    local password = http.formvalue("password")
    local encryption = http.formvalue("encryption")
    local channel = http.formvalue("channel")
    local band = http.formvalue("band")
    
    code = XQWifiUtil.appSetWifiApMode(ssid, password, encryption, channel, band)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkReboot()
    end
end

--[[
    获取AP客户端信号强度
    @return JSON {code: 0, signal: ...}
--]]
function apcli_get_signal()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.signal = XQWifiUtil.apcli_get_signal()
    http.write_json(result)
end

--[[
    服务重启
--]]
function serviceRestart()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    result.code = 0
    http.write_json(result)
    http.close()
    XQFunction.forkReboot()
end

--[[
    设置有线AP模式
    @param ip LAN IP
    @param mask 子网掩码
--]]
function setLanAP()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local ip = http.formvalue("ip")
    local mask = http.formvalue("mask")
    
    code = XQWifiUtil.setLanAP(ip, mask)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkReboot()
    end
end

--[[
    禁用有线AP模式
--]]
function disableLanAP()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    result.code = 0
    
    XQWifiUtil.disableLanAP()
    
    http.write_json(result)
    http.close()
    XQFunction.forkReboot()
end

--[[
    WiFi AP服务重启
--]]
function wifiAPserviceRestart()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    result.code = 0
    http.write_json(result)
    http.close()
    XQFunction.forkRestartWifi()
end

--[[
    获取模式状态
    @return JSON {code: 0, status: {...}}
--]]
function getModeStatus()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.status = XQWifiUtil.getModeStatus()
    http.write_json(result)
end

--[[
    获取活动AP客户端
    @return JSON {code: 0, apcli: {...}}
--]]
function getActiveApcli()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.apcli = XQWifiUtil.getActiveApcli()
    http.write_json(result)
end

--============================================================================--
--                              信道扫描函数                                     --
--============================================================================--

--[[
    开始信道扫描
    @param wifiIndex WiFi索引
--]]
function channelScanStart()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    XQWifiUtil.channelScanStart(wifiIndex)
    
    http.write_json(result)
end

--[[
    获取信道扫描结果
    @param wifiIndex WiFi索引
    @return JSON {code: 0, result: {...}}
--]]
function getScanResult()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    result.result = XQWifiUtil.getScanResult(wifiIndex)
    
    http.write_json(result)
end

--[[
    设置WiFi信道
    @param wifiIndex WiFi索引
    @param channel 信道
--]]
function setChannel()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local wifiIndex = tonumber(http.formvalue("wifiIndex"))
    local channel = http.formvalue("channel")
    
    local success = XQWifiUtil.setChannel(wifiIndex, channel)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    PPPoE账号捕获
    @return JSON {code: 0, username: ..., password: ...}
--]]
function pppoeCatch()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    
    local catchInfo = XQLanWanUtil.pppoeCatch()
    if catchInfo then
        result.username = catchInfo.username
        result.password = catchInfo.password
    end
    
    http.write_json(result)
end

--============================================================================--
--                              Mesh 组网函数                                   --
--============================================================================--

--[[
    扫描Mesh节点
    @return JSON {code: 0, list: [...]}
--]]
function scanMeshNode()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local result = {}
    result.code = 0
    result.list = XQMeshUtil.scanMeshNode()
    http.write_json(result)
end

--[[
    添加Mesh节点
    @param mac 节点MAC
--]]
function addMeshNode()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    
    code = XQMeshUtil.addMeshNode(mac)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取添加Mesh节点状态
    @return JSON {code: 0, status: ...}
--]]
function getMeshNodeStatus()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local result = {}
    result.code = 0
    result.status = XQMeshUtil.getMeshNodeStatus()
    http.write_json(result)
end

--[[
    获取网络模式
    @return JSON {code: 0, mode: ...}
--]]
function getNetMode()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local result = {}
    result.code = 0
    result.mode = XQMeshUtil.getNetMode()
    http.write_json(result)
end

--[[
    设置SON回程模式
    @param mode 回程模式
--]]
function setSonBackhaulMode()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local mode = http.formvalue("mode")
    
    local success = XQMeshUtil.setSonBackhaulMode(mode)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取SON回程模式
    @return JSON {code: 0, mode: ...}
--]]
function getSonBackhaulMode()
    local XQMeshUtil = require("xiaoqiang.util.XQMeshUtil")
    local result = {}
    result.code = 0
    result.mode = XQMeshUtil.getSonBackhaulMode()
    http.write_json(result)
end

--============================================================================--
--                              诊断测试函数                                     --
--============================================================================--

--[[
    获取诊断设备列表
    @return JSON {code: 0, list: [...]}
--]]
function getDiagDeviceList()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {}
    result.code = 0
    result.list = XQDeviceUtil.getDiagDeviceList()
    http.write_json(result)
end

--[[
    获取U盘诊断状态
    @return JSON {code: 0, status: {...}}
--]]
function getDiagUdiskStatus()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.status = XQDiagUtil.getDiagUdiskStatus()
    http.write_json(result)
end

--[[
    获取磁盘诊断状态
    @return JSON {code: 0, status: {...}}
--]]
function getDiagDiskStatus()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.status = XQDiagUtil.getDiagDiskStatus()
    http.write_json(result)
end

--[[
    WiFi诊断测试
    @param mac 测试设备MAC
    @return JSON {code: 0, result: {...}}
--]]
function diagWifiTest()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    
    local mac = http.formvalue("mac")
    result.result = XQDiagUtil.diagWifiTest(mac)
    
    http.write_json(result)
end

--[[
    USB诊断测试
    @return JSON {code: 0, result: {...}}
--]]
function diagUsbTest()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.result = XQDiagUtil.diagUsbTest()
    http.write_json(result)
end

--[[
    硬盘诊断状态
    @return JSON {code: 0, status: {...}}
--]]
function diagHddStatus()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.status = XQDiagUtil.diagHddStatus()
    http.write_json(result)
end

--[[
    磁盘诊断测试
    @return JSON {code: 0, result: {...}}
--]]
function diagDiskTest()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.result = XQDiagUtil.diagDiskTest()
    http.write_json(result)
end

--[[
    获取诊断参数
    @return JSON {code: 0, params: {...}}
--]]
function getDiagParas()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    result.code = 0
    result.params = XQDiagUtil.getDiagParas()
    http.write_json(result)
end

--[[
    设置诊断参数
    @param params 诊断参数
--]]
function setDiagParas()
    local XQDiagUtil = require("xiaoqiang.util.XQDiagUtil")
    local result = {}
    local code = 0
    
    local params = http.formvalue("params")
    
    local success = XQDiagUtil.setDiagParas(params)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--============================================================================--
--                              IPv6 配置函数                                   --
--============================================================================--

--[[
    设置WAN6 IPv6配置
    @param wanType IPv6类型
    @param ip IPv6地址
    @param prefix 前缀长度
    @param gw 网关
    @param dns1 DNS1
    @param dns2 DNS2
--]]
function setWan6()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local result = {}
    local code = 0
    
    local wanType = http.formvalue("wanType")
    local ip = XQSecureUtil.parseCmdline(http.formvalue("ipaddr"))
    local gw = XQSecureUtil.parseCmdline(http.formvalue("gw"))
    local prefix = XQSecureUtil.parseCmdline(http.formvalue("prefix"))
    local assign = XQSecureUtil.parseCmdline(http.formvalue("assign"))
    local dns1 = XQSecureUtil.parseCmdline(http.formvalue("dns1"))
    local dns2 = XQSecureUtil.parseCmdline(http.formvalue("dns2"))
    
    code = XQLanWanUtil.setWan6(wanType, ip, prefix, gw, dns1, dns2, assign)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取IPv6状态
    @return JSON {code: 0, status: {...}}
--]]
function ipv6Status()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.status = XQLanWanUtil.ipv6Status()
    http.write_json(result)
end

--[[
    设置WAN6 V2版本
--]]
function setWan6V2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local code = 0
    
    local wanType = http.formvalue("wanType")
    local ip = http.formvalue("ipaddr")
    local prefix = http.formvalue("prefix")
    local gw = http.formvalue("gw")
    local dns1 = http.formvalue("dns1")
    local dns2 = http.formvalue("dns2")
    
    code = XQLanWanUtil.setWan6V2(wanType, ip, prefix, gw, dns1, dns2)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WAN6 V2版本信息
    @return JSON {code: 0, info: {...}}
--]]
function getWan6V2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.info = XQLanWanUtil.getWan6V2()
    http.write_json(result)
end

--[[
    设置LAN6 V2版本
--]]
function setLan6V2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local code = 0
    
    local assign = http.formvalue("assign")
    
    code = XQLanWanUtil.setLan6V2(assign)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取LAN6 V2版本信息
    @return JSON {code: 0, info: {...}}
--]]
function getLan6V2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.info = XQLanWanUtil.getLan6V2()
    http.write_json(result)
end

--[[
    获取WAN6信息V2版本
    @return JSON {code: 0, info: {...}}
--]]
function getWan6InfoV2()
    local result = {}
    result.code = 0
    result.info = wan6InfoV2Handle()
    http.write_json(result)
end

--[[
    设置WAN6开关V2版本
    @param on 开关状态
--]]
function setWan6SwitchV2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local code = 0
    
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    local success = XQLanWanUtil.setWan6SwitchV2(enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取WAN6开关V2版本状态
    @return JSON {code: 0, on: 0/1}
--]]
function getWan6SwitchV2()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.on = XQLanWanUtil.getWan6SwitchV2()
    http.write_json(result)
end

--[[
    WAN6信息V2处理函数
    @return 状态信息
--]]
function wan6InfoV2Handle()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    return XQLanWanUtil.wan6InfoV2Handle()
end

--[[
    设置IPv6防火墙
    @param on 开关状态
--]]
function setIpv6Firewall()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    local code = 0
    
    local on = tonumber(http.formvalue("on"))
    local enable = (on == 1)
    
    local success = XQLanWanUtil.setIpv6Firewall(enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取IPv6防火墙状态
    @return JSON {code: 0, on: 0/1}
--]]
function getIpv6Firewall()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.on = XQLanWanUtil.getIpv6Firewall()
    http.write_json(result)
end

--============================================================================--
--                              NFC 功能函数                                    --
--============================================================================--

--[[
    设置NFC状态
    @param status NFC状态
--]]
function setNfcStatus()
    local XQNfcUtil = require("xiaoqiang.util.XQNfcUtil")
    local result = {}
    local code = 0
    
    local status = http.formvalue("status")
    
    local success = XQNfcUtil.setNfcStatus(status)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取NFC信息
    @return JSON {code: 0, info: {...}}
--]]
function getNfcInfo()
    local XQNfcUtil = require("xiaoqiang.util.XQNfcUtil")
    local result = {}
    result.code = 0
    result.info = XQNfcUtil.getNfcInfo()
    http.write_json(result)
end

--============================================================================--
--                              多WAN功能函数                                   --
--============================================================================--

--[[
    获取多WAN基本信息
    @return JSON {code: 0, info: {...}}
--]]
function getMultiwanBasicInfo()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    result.code = 0
    result.info = XQMultiwanUtil.getMultiwanBasicInfo()
    http.write_json(result)
end

--[[
    获取多WAN设备列表
    @return JSON {code: 0, list: [...]}
--]]
function getMultiwanDevList()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    result.code = 0
    result.list = XQMultiwanUtil.getMultiwanDevList()
    http.write_json(result)
end

--[[
    获取多WAN设备策略
    @return JSON {code: 0, policies: {...}}
--]]
function getMultiwanDevPolicies()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    result.code = 0
    result.policies = XQMultiwanUtil.getMultiwanDevPolicies()
    http.write_json(result)
end

--[[
    设置多WAN设备策略
    @param mac 设备MAC
    @param policy 策略
--]]
function setMultiwanDevPolicy()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local policy = http.formvalue("policy")
    
    local success = XQMultiwanUtil.setMultiwanDevPolicy(mac, policy)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置多WAN权重
    @param weight 权重配置
--]]
function setMultiwanWeight()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    local code = 0
    
    local weight = http.formvalue("weight")
    
    local success = XQMultiwanUtil.setMultiwanWeight(weight)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置多WAN启用状态
    @param enable 启用状态
--]]
function setMultiwanEnable()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    local code = 0
    
    local enable = http.formvalue("enable")
    
    local success = XQMultiwanUtil.setMultiwanEnable(enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置多WAN策略
    @param policy 策略配置
--]]
function setMultiwanPolicy()
    local XQMultiwanUtil = require("xiaoqiang.util.XQMultiwanUtil")
    local result = {}
    local code = 0
    
    local policy = http.formvalue("policy")
    
    local success = XQMultiwanUtil.setMultiwanPolicy(policy)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--============================================================================--
--                              TR-069 功能函数                                 --
--============================================================================--

--[[
    设置CWMP配置
    @param url ACS URL
    @param username 用户名
    @param password 密码
--]]
function setCwmp()
    local XQCwmpUtil = require("xiaoqiang.util.XQCwmpUtil")
    local result = {}
    local code = 0
    
    local url = http.formvalue("url")
    local username = http.formvalue("username")
    local password = http.formvalue("password")
    
    local success = XQCwmpUtil.setCwmp(url, username, password)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取CWMP配置信息
    @return JSON {code: 0, info: {...}}
--]]
function getCwmpInfo()
    local XQCwmpUtil = require("xiaoqiang.util.XQCwmpUtil")
    local result = {}
    result.code = 0
    result.info = XQCwmpUtil.getCwmpInfo()
    http.write_json(result)
end

--============================================================================--
--                              WPS 功能函数                                    --
--============================================================================--

--[[
    获取WPS信息
    @return JSON {code: 0, info: {...}}
--]]
function getWpsInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.info = XQWifiUtil.getWpsInfo()
    http.write_json(result)
end

--============================================================================--
--                              百度网盘功能函数                                  --
--============================================================================--

--[[
    设置路由器到百度网盘传输
--]]
function setRouterToBaidu()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    local code = 0
    
    local path = http.formvalue("path")
    local remotePath = http.formvalue("remote_path")
    
    local success = XQBaiduUtil.setRouterToBaidu(path, remotePath)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置百度网盘到路由器传输
--]]
function setBaiduToRouter()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    local code = 0
    
    local path = http.formvalue("path")
    local remotePath = http.formvalue("remote_path")
    
    local success = XQBaiduUtil.setBaiduToRouter(path, remotePath)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    删除传输列表
--]]
function deleteTransportList()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    local code = 0
    
    local ids = http.formvalue("ids")
    
    local success = XQBaiduUtil.deleteTransportList(ids)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取传输列表
    @return JSON {code: 0, list: [...]}
--]]
function getTransportList()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    result.code = 0
    result.list = XQBaiduUtil.getTransportList()
    http.write_json(result)
end

--[[
    设置传输列表操作
--]]
function setTransListAction()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    local code = 0
    
    local action = http.formvalue("action")
    local ids = http.formvalue("ids")
    
    local success = XQBaiduUtil.setTransListAction(action, ids)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取传输列表文件状态
    @return JSON {code: 0, stat: {...}}
--]]
function getTransListFileStat()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    result.code = 0
    result.stat = XQBaiduUtil.getTransListFileStat()
    http.write_json(result)
end

--[[
    获取传输列表计数
    @return JSON {code: 0, count: ...}
--]]
function getTransListCount()
    local XQBaiduUtil = require("xiaoqiang.util.XQBaiduUtil")
    local result = {}
    result.code = 0
    result.count = XQBaiduUtil.getTransListCount()
    http.write_json(result)
end

--============================================================================--
--                              Docker 功能函数                                 --
--============================================================================--

--[[
    设置小米Docker
--]]
function setMiDocker()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    local code = 0
    
    local action = http.formvalue("action")
    
    local success = XQDockerUtil.setMiDocker(action)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置小米Docker环境
--]]
function setMiDockerEnv()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    local code = 0
    
    local env = http.formvalue("env")
    
    local success = XQDockerUtil.setMiDockerEnv(env)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置Portainer环境
--]]
function setPortainerEnv()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    local code = 0
    
    local env = http.formvalue("env")
    
    local success = XQDockerUtil.setPortainerEnv(env)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    设置Portainer管理
--]]
function setPortainerManage()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    local code = 0
    
    local action = http.formvalue("action")
    
    local success = XQDockerUtil.setPortainerManage(action)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取Docker信息
    @return JSON {code: 0, info: {...}}
--]]
function getDockerInfo()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    result.code = 0
    result.info = XQDockerUtil.getDockerInfo()
    http.write_json(result)
end

--[[
    取消小米Docker操作
--]]
function setMiDockerCancel()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    result.code = 0
    XQDockerUtil.setMiDockerCancel()
    http.write_json(result)
end

--[[
    取消Portainer操作
--]]
function setPortainerCancel()
    local XQDockerUtil = require("xiaoqiang.util.XQDockerUtil")
    local result = {}
    result.code = 0
    XQDockerUtil.setPortainerCancel()
    http.write_json(result)
end

--============================================================================--
--                              MLO 多链路操作函数                               --
--============================================================================--

--[[
    设置Hostap MLO
    @param mlo MLO配置
--]]
function setHostapMLO()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local mlo = http.formvalue("mlo")
    
    local success = XQWifiUtil.setHostapMLO(mlo)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
    获取Hostap MLO配置
    @return JSON {code: 0, mlo: ...}
--]]
function getHostapMLO()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.mlo = XQWifiUtil.getHostapMLO()
    http.write_json(result)
end

--============================================================================--
--                              TWT 目标唤醒时间函数                              --
--============================================================================--

--[[
    获取TWT配置
    @return JSON {code: 0, twt: {...}}
--]]
function getTwt()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local result = {}
    result.code = 0
    result.twt = XQWifiUtil.getTwt()
    http.write_json(result)
end

--[[
    设置TWT配置
    @param twt TWT配置
--]]
function setTwt()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = 0
    
    local twt = http.formvalue("twt")
    
    local success = XQWifiUtil.setTwt(twt)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--============================================================================--
--                              SFP 光模块函数                                   --
--============================================================================--

--[[
    获取SFP速度
    @return JSON {code: 0, speed: ...}
--]]
function GetSFPSpeed()
    local XQSfpUtil = require("xiaoqiang.util.XQSfpUtil")
    local result = {}
    result.code = 0
    result.speed = XQSfpUtil.GetSFPSpeed()
    http.write_json(result)
end

--[[
    设置SFP速度
    @param speed SFP速度
--]]
function SetSFPSpeed()
    local XQSfpUtil = require("xiaoqiang.util.XQSfpUtil")
    local result = {}
    local code = 0
    
    local speed = http.formvalue("speed")
    
    local success = XQSfpUtil.SetSFPSpeed(speed)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--============================================================================--
--                              桥接LAN状态函数                                  --
--============================================================================--

--[[
    获取桥接LAN状态
    @return JSON {code: 0, status: {...}}
--]]
function getBridgeLanStatus()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local result = {}
    result.code = 0
    result.status = XQLanWanUtil.getBridgeLanStatus()
    http.write_json(result)
end

--============================================================================--
--                              网关安全函数                                     --
--============================================================================--

--[[
    设置网关安全
    @param enable 启用状态
--]]
function setGwSecurity()
    local XQSecurityUtil = require("xiaoqiang.util.XQSecurityUtil")
    local result = {}
    local code = 0
    
    local enable = http.formvalue("enable")
    
    local success = XQSecurityUtil.setGwSecurity(enable)
    if not success then
        code = 1606
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
    获取网关安全状态
    @return JSON {code: 0, enable: 0/1}
--]]
function getGwSecurity()
    local XQSecurityUtil = require("xiaoqiang.util.XQSecurityUtil")
    local result = {}
    result.code = 0
    result.enable = XQSecurityUtil.getGwSecurity()
    http.write_json(result)
end

--============================================================================--
--                              终端信息函数                                     --
--============================================================================--

--[[
    获取终端信息
    @param staMac 终端MAC地址
    @param meshNodes Mesh节点列表
    @return 终端信息
--]]
function getStationInfo(staMac, meshNodes)
    local LuciUtil = require("luci.util")
    local cjson = require("cjson")
    local cursor = require("luci.model.uci").cursor()
    
    if staMac == nil then
        return nil
    end
    
    local stationInfo = {}
    local upperMac = string.upper(staMac)
    
    local assocData = LuciUtil.exec("ubus call trafficd hw '{\"hw\": \"" .. upperMac .. "\"}'")
    if assocData and assocData ~= "" then
        local assoc = cjson.decode(assocData)
        if assoc and assoc.ifname then
            stationInfo.ifname = assoc.ifname
            stationInfo.band = getBandByIfname(assoc.ifname)
            stationInfo.assoc_net = getAssocNetByIfname(assoc.ifname)
            stationInfo.assoc_node_name = getAssocMeshNodeName(meshNodes, upperMac)
            stationInfo.assoc_node_location = getAssocMeshNodeLocation(meshNodes, upperMac)
        end
    end
    
    return stationInfo
end
