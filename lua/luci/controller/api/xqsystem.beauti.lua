--[[
  小米路由器系统API控制器 (XQSystem API Controller)
  
  功能模块:
  - 用户登录与认证 (Login & Authentication)
  - 系统初始化与配置 (System Initialization)
  - 固件升级管理 (Firmware Upgrade)
  - 设备管理 (Device Management)
  - 系统信息获取 (System Information)
  - 安全与防火墙 (Security & Firewall)
  - VPN配置 (VPN Configuration)
  - UPnP管理 (UPnP Management)
  - 隐私设置 (Privacy Settings)
  - 多语言支持 (Multi-language Support)
  - DMZ配置 (DMZ Configuration)
  - 端口转发 (Port Forwarding)
  
  LuCI框架路由: /api/xqsystem/*
]]

module("luci.controller.api.xqsystem", package.seeall)

local http = require("luci.http")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

--[[
  路由注册入口函数
  注册所有系统API路由到LuCI框架
]]
function index()
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    -- 创建API节点 /api/xqsystem
    local page = node("api", "xqsystem")
    page.target = firstchild()
    page.title = ""
    page.order = 100
    page.sysauth = "admin"
    page.sysauth_authenticator = "jsonauth"
    page.index = true
    
    -- ==================== 认证相关API ====================
    -- 用户登录接口
    entry({"api", "xqsystem", "login"}, call("actionLogin"), "", 109, 8)
    -- 获取Token
    entry({"api", "xqsystem", "token"}, call("getToken"), "", 103, 8)
    -- 刷新Token
    entry({"api", "xqsystem", "renew_token"}, call("renewToken"), "", 136)
    -- 获取客户端IP
    entry({"api", "xqsystem", "get_ip"}, call("getIp"), "", 136, 9)
    
    -- ==================== 系统初始化API ====================
    -- 获取初始化信息
    entry({"api", "xqsystem", "init_info"}, call("getInitInfo"), "", 101, 9)
    -- 获取工厂信息
    entry({"api", "xqsystem", "fac_info"}, call("getFacInfo"), "", 101, 9)
    -- 设置初始化完成
    entry({"api", "xqsystem", "set_inited"}, call("setInited"), "", 103, 8)
    -- 路由器初始化配置
    entry({"api", "xqsystem", "router_init"}, call("setRouter"), "", 126, 8)
    -- 告别/退出接口
    entry({"api", "xqsystem", "farewell"}, call("farewell"), "", 102, 9)
    
    -- ==================== 密码管理API ====================
    -- 设置管理员密码
    entry({"api", "xqsystem", "set_name_password"}, call("setPassword"), "", 105)
    
    -- ==================== 固件升级API ====================
    -- 检查ROM更新
    entry({"api", "xqsystem", "check_rom_update"}, call("checkRomUpdate"), "", 106)
    -- 刷写ROM
    entry({"api", "xqsystem", "flash_rom"}, call("flashRom"), "", 108)
    -- 上传ROM文件
    entry({"api", "xqsystem", "upload_rom"}, call("uploadRom"), "", 115)
    -- 分片上传ROM
    entry({"api", "xqsystem", "upload_rom_split"}, call("uploadRomSplit"), "", 121)
    -- 升级ROM
    entry({"api", "xqsystem", "upgrade_rom"}, call("upgradeRom"), "", 138)
    -- 获取刷写状态
    entry({"api", "xqsystem", "flash_status"}, call("flashStatus"), "", 147, 1)
    -- 获取升级状态
    entry({"api", "xqsystem", "upgrade_status"}, call("upgradeStatus"), "", 148, 13)
    -- 取消升级
    entry({"api", "xqsystem", "cancel"}, call("cancelUpgrade"), "", 160, 13)
    -- 清除升级结果
    entry({"api", "xqsystem", "clear_upgrade_result"}, call("clearUpgradeResult"), "", 229, 9)
    -- 刷写权限检查
    entry({"api", "xqsystem", "flash_permission"}, call("flashPermission"), "", 200, 13)
    
    -- ==================== 插件管理API ====================
    -- 上传插件
    entry({"api", "xqsystem", "upload_plug"}, call("uploadPlug"), "", 116)
    -- 已安装插件列表
    entry({"api", "xqsystem", "installed_plug"}, call("installedPlug"), "", 117)
    
    -- ==================== 路由器信息API ====================
    -- 获取路由器名称
    entry({"api", "xqsystem", "router_name"}, call("getRouterName"), "", 110)
    -- 设置路由器名称
    entry({"api", "xqsystem", "set_router_name"}, call("setRouterName"), "", 109)
    -- 获取LAN/WAN状态
    entry({"api", "xqsystem", "lan_wan"}, call("getLanWanSta"), "", 106)
    -- 获取系统信息
    entry({"api", "xqsystem", "information"}, call("getAllInfo"), "", 127)
    -- 获取系统状态
    entry({"api", "xqsystem", "status"}, call("getStatusInfo"), "", 128)
    -- 获取连接设备数量
    entry({"api", "xqsystem", "count"}, call("getConDevCount"), "", 129)
    
    -- ==================== 设备管理API ====================
    -- 获取设备列表
    entry({"api", "xqsystem", "device_list"}, call("getDeviceList"), "", 112)
    -- 设置设备昵称
    entry({"api", "xqsystem", "set_device_nickname"}, call("setDeviceNickName"), "", 113)
    -- 获取设备MAC地址
    entry({"api", "xqsystem", "device_mac"}, call("getDeviceMacaddr"), "", 173, 1)
    -- 获取Zigbee设备列表
    entry({"api", "xqsystem", "device_list_zigbee"}, call("getDeviceListZigbee"), "", 179)
    -- 特殊设备计数
    entry({"api", "xqsystem", "sdev"}, call("specialDevCount"), "", 198)
    -- MAgent设备列表
    entry({"api", "xqsystem", "devicelist"}, call("devicelistForMAgent"), "", 199)
    
    -- ==================== 网络连接API ====================
    -- 检查互联网连接
    entry({"api", "xqsystem", "internet_connect"}, call("isInternetConnect"), "", 114)
    
    -- ==================== 系统操作API ====================
    -- 重启路由器
    entry({"api", "xqsystem", "reboot"}, call("reboot"), "", 130)
    -- 恢复出厂设置
    entry({"api", "xqsystem", "reset"}, call("reset"), "", 131)
    -- 关机
    entry({"api", "xqsystem", "shutdown"}, call("shutdown"), "", 161)
    -- 系统恢复
    entry({"api", "xqsystem", "sys_recovery"}, call("sysRecovery"), "", 177)
    -- 智能关机
    entry({"api", "xqsystem", "smart_shutdown"}, call("smartShutdown"), "", 178)
    
    -- ==================== 绑定相关API ====================
    -- 路由器绑定确认
    entry({"api", "xqsystem", "router_bind_ok"}, call("routerBindOk"), "", 107, 9)
    -- 新路由器绑定确认
    entry({"api", "xqsystem", "new_router_bind_ok"}, call("newrouterBindOk"), "", 107, 9)
    -- 解绑
    entry({"api", "xqsystem", "unbind"}, call("unbind"), "")
    -- 获取Passport绑定信息
    entry({"api", "xqsystem", "passport_bind_info"}, call("getPassportBindInfo"), "", 132, 1)
    -- 设置Passport绑定
    entry({"api", "xqsystem", "set_passport_bound"}, call("setPassportBound"), "", 133, 8)
    -- 移除Passport绑定信息
    entry({"api", "xqsystem", "remove_passport_info"}, call("removePassportBindInfo"), "", 137)
    -- 开始绑定
    entry({"api", "xqsystem", "start_binding"}, call("startBinding"), "", 332)
    
    -- ==================== 语言设置API ====================
    -- 获取语言列表
    entry({"api", "xqsystem", "get_languages"}, call("getLangList"), "", 118, 9)
    -- 获取主语言
    entry({"api", "xqsystem", "get_main_language"}, call("getMainLang"), "", 119, 1)
    -- 设置语言
    entry({"api", "xqsystem", "set_language"}, call("setLang"), "", 120)
    
    -- ==================== 日志相关API ====================
    -- 上传日志
    entry({"api", "xqsystem", "upload_log"}, call("uploadLogFile"), "", 124)
    -- 获取WiFi日志
    entry({"api", "xqsystem", "wifi_log"}, call("getWifiLog"), "", 176)
    
    -- ==================== 系统负载API ====================
    -- 获取系统平均负载
    entry({"api", "xqsystem", "get_sys_avg_load"}, call("getSysAvgLoad"), "", 134)
    
    -- ==================== MAC过滤API ====================
    -- 设置MAC过滤
    entry({"api", "xqsystem", "set_mac_filter"}, call("setMacFilter"), "", 135)
    -- 获取MAC过滤模式
    entry({"api", "xqsystem", "mode"}, call("getMacfilterMode"), "", 158)
    -- 设置MAC过滤模式
    entry({"api", "xqsystem", "set_mode"}, call("setMacfilterMode"), "", 159)
    
    -- ==================== WPS相关API ====================
    -- 开启WPS
    entry({"api", "xqsystem", "wps"}, call("openWps"), "", 139, 8)
    -- 获取WPS状态
    entry({"api", "xqsystem", "wps_status"}, call("getWpsStatus"), "", 140)
    -- 取消WPS
    entry({"api", "xqsystem", "wps_cancel"}, call("stopWps"), "", 174)
    -- 设置WPS开关
    entry({"api", "xqsystem", "set_wps_enable"}, call("setWpsEnabled"), "", 232)
    
    -- ==================== Nginx相关API ====================
    -- 停止Nginx
    entry({"api", "xqsystem", "stop_nginx"}, call("stopNginx"), "", 141)
    -- 启动Nginx
    entry({"api", "xqsystem", "start_nginx"}, call("startNginx"), "", 145)
    -- Nginx缓存状态
    entry({"api", "xqsystem", "nginx"}, call("nginxCacheStatus"), "", 146)
    
    -- ==================== 路由器名称待处理API ====================
    -- 检查路由器名称待处理
    entry({"api", "xqsystem", "check_router_name_pending"}, call("checkRouterNamePending"), "", 142)
    -- 清除路由器名称待处理
    entry({"api", "xqsystem", "clear_router_name_pending"}, call("clearRouterNamePending"), "", 143)
    
    -- ==================== Web URL API ====================
    -- 重定向URL
    entry({"api", "xqsystem", "web_url"}, call("redirectUrl"), "", 144)
    
    -- ==================== 沙盒相关API ====================
    -- 创建沙盒
    entry({"api", "xqsystem", "create_sandbox"}, call("createSandbox"), "", 149)
    -- 检查沙盒是否创建
    entry({"api", "xqsystem", "is_sandbox_created"}, call("isSandboxCreated"), "", 150)
    
    -- ==================== 挂载相关API ====================
    -- 挂载
    entry({"api", "xqsystem", "mount_things"}, call("mountThings"), "", 151)
    -- 卸载
    entry({"api", "xqsystem", "umount_things"}, call("umountThings"), "", 152)
    -- 检查是否已挂载
    entry({"api", "xqsystem", "are_things_mounted"}, call("areThingsMounted"), "", 153)
    
    -- ==================== Dropbear SSH API ====================
    -- 启动Dropbear
    entry({"api", "xqsystem", "start_dropbear"}, call("startDropbear"), "", 154)
    -- 停止Dropbear
    entry({"api", "xqsystem", "stop_dropbear"}, call("stopDropbear"), "", 155)
    -- 检查Dropbear是否启动
    entry({"api", "xqsystem", "is_dropbear_started"}, call("isDropbearStarted"), "", 156)
    
    -- ==================== APP状态API ====================
    -- APP主状态
    entry({"api", "xqsystem", "main_status_for_app"}, call("mainStatusForApp"), "", 157)
    
    -- ==================== UPnP API ====================
    -- UPnP列表
    entry({"api", "xqsystem", "upnp"}, call("upnpList"), "", 162)
    -- UPnP开关
    entry({"api", "xqsystem", "upnp_switch"}, call("upnpSwitch"), "", 163)
    
    -- ==================== 应用限制API ====================
    -- 应用限制
    entry({"api", "xqsystem", "app_limit"}, call("appLimit"), "", 164)
    -- 应用限制开关
    entry({"api", "xqsystem", "app_limit_switch"}, call("appLimitSwitch"), "", 165)
    -- 设置应用限制
    entry({"api", "xqsystem", "set_app_limit"}, call("setAppLimit"), "", 166)
    
    -- ==================== 迅雷API ====================
    -- 迅雷API接口
    entry({"api", "xqsystem", "xunlei_api"}, call("xunlei_api"), "", 164)
    
    -- ==================== VPN API ====================
    -- VPN信息
    entry({"api", "xqsystem", "vpn"}, call("vpnInfo"), "", 167)
    -- VPN状态
    entry({"api", "xqsystem", "vpn_status"}, call("vpnStatus"), "", 168)
    -- VPN开关
    entry({"api", "xqsystem", "vpn_switch"}, call("vpnSwitch"), "", 169)
    -- 设置VPN
    entry({"api", "xqsystem", "set_vpn"}, call("setVpn"), "", 170)
    -- 删除VPN
    entry({"api", "xqsystem", "del_vpn"}, call("delVpn"), "", 171)
    -- 设置VPN自动连接
    entry({"api", "xqsystem", "set_vpnauto"}, call("setVpnAuto"), "", 172)
    
    -- ==================== 检测时间戳API ====================
    -- 获取检测时间戳
    entry({"api", "xqsystem", "detection_ts"}, call("getDetectionTimestamp"), "", 175)
    
    -- ==================== Noflushd API ====================
    -- 获取Noflushd状态
    entry({"api", "xqsystem", "noflushd"}, call("getNofStatus"), "", 180)
    -- Noflushd开关
    entry({"api", "xqsystem", "nof_switch"}, call("nofSwitch"), "", 181)
    
    -- ==================== 预下载API ====================
    -- 预下载状态
    entry({"api", "xqsystem", "pred_status"}, call("predownloadInfo"), "", 182)
    -- 预下载开关
    entry({"api", "xqsystem", "pred_switch"}, call("predownloadSwitch"), "", 183)
    
    -- ==================== 隐私设置API ====================
    -- 获取隐私设置
    entry({"api", "xqsystem", "privacy"}, call("privacy"), "", 184, 8)
    -- 设置隐私
    entry({"api", "xqsystem", "set_privacy"}, call("setPrivacy"), "", 185, 8)
    -- 设置隐私(新版)
    entry({"api", "xqsystem", "set_privacy_new"}, call("setPrivacy_new"), "", 185, 9)
    
    -- ==================== 磁盘管理API ====================
    -- 获取磁盘信息
    entry({"api", "xqsystem", "disk_info"}, call("getDiskInfo"), "", 186)
    -- 获取IO数据
    entry({"api", "xqsystem", "io_data"}, call("getIOData"), "", 187)
    -- 磁盘扫描
    entry({"api", "xqsystem", "disk_scan"}, call("diskScan"), "", 188)
    -- 磁盘检查
    entry({"api", "xqsystem", "disk_check"}, call("diskCheck"), "", 189)
    -- 磁盘检查状态
    entry({"api", "xqsystem", "disk_check_status"}, call("diskCheckStatus"), "", 190)
    -- 用户磁盘数据
    entry({"api", "xqsystem", "userdisk_data"}, call("getUserdiskDataInfo"), "", 201)
    
    -- ==================== 备份相关API ====================
    -- 备份数据
    entry({"api", "xqsystem", "backup_data"}, call("backupData"), "", 202)
    -- 备份状态
    entry({"api", "xqsystem", "backup_status"}, call("backupStatus"), "", 203)
    -- 取消备份
    entry({"api", "xqsystem", "backup_cancel"}, call("backupCancel"), "", 204)
    
    -- ==================== USB服务API ====================
    -- USB服务开关
    entry({"api", "xqsystem", "usbservice"}, call("usbServiceSwitch"), "", 205)
    -- USB模式
    entry({"api", "xqsystem", "usbmode"}, call("usbmode"), "", 206)
    
    -- ==================== 国家代码API ====================
    -- 获取国家代码
    entry({"api", "xqsystem", "country_code"}, call("getCountryCode"), "", 191, 9)
    -- 设置国家代码
    entry({"api", "xqsystem", "set_country_code"}, call("setCountryCode"), "", 192)
    
    -- ==================== 推送设置API ====================
    -- 获取推送设置
    entry({"api", "xqsystem", "push_settings"}, call("getPushSettings"), "", 193)
    -- 推送开关
    entry({"api", "xqsystem", "push_switch"}, call("pushSwitch"), "", 194)
    -- 设备通知
    entry({"api", "xqsystem", "dev_notify"}, call("setDevNotify"), "", 195)
    
    -- ==================== OTA API ====================
    -- 获取OTA信息
    entry({"api", "xqsystem", "ota"}, call("getOTAInfo"), "", 196)
    -- 设置OTA信息
    entry({"api", "xqsystem", "set_ota"}, call("setOTAInfo"), "", 197)
    
    -- ==================== 支付相关API ====================
    -- 设置支付信息
    entry({"api", "xqsystem", "set_payment_info"}, call("setPaymentInfo"), "", 207, 9)
    -- 签名订单
    entry({"api", "xqsystem", "sign_order"}, call("signOrder"), "", 208, 9)
    
    -- ==================== 扩展WiFi API ====================
    -- 一键获取远程Token
    entry({"api", "xqsystem", "oneclick_get_remote_token"}, call("oneClickGetRemoteToken"), "", 209, 8)
    -- 扩展WiFi请求远程API
    entry({"api", "xqsystem", "extendwifi_request_remote_api"}, call("ExtendWifiRequestRemoteAPI"), "", 210, 8)
    -- 获取根目录信息
    entry({"api", "xqsystem", "extendwifi_get_root_dir_info"}, call("ExtendWifiGetRootDirInfo"), "", 211, 8)
    -- 获取根目录使用情况
    entry({"api", "xqsystem", "extendwifi_get_root_dir_useage"}, call("ExtendWifiGetRootDirUseage"), "", 212, 8)
    -- 连接已初始化路由器
    entry({"api", "xqsystem", "extendwifi_connect_inited_router"}, call("ExtendWifiConnectInitedRouter"), "", 214, 8)
    -- 自动频段签名
    entry({"api", "xqsystem", "extendwifi_sign_for_auto_band"}, call("ExtendWifiSignForAutoBand"), "", 215, 9)
    
    -- ==================== 网络诊断API ====================
    -- 开始网络诊断
    entry({"api", "xqsystem", "net_diagnose_start"}, call("netDiagnoseStart"), "", 223)
    -- 网络诊断结果
    entry({"api", "xqsystem", "net_diagnose_result"}, call("netDiagnoseResult"), "", 224)
    
    -- ==================== 位置设置API ====================
    -- 获取位置
    entry({"api", "xqsystem", "get_location"}, call("getLocation"), "", 225)
    -- 设置位置
    entry({"api", "xqsystem", "set_location"}, call("setLocation"), "", 226)
    
    -- ==================== HTTPS强制API ====================
    -- 获取强制HTTPS设置
    entry({"api", "xqsystem", "get_access_force_https"}, call("getForceHttps"), "", 227)
    -- 设置强制HTTPS
    entry({"api", "xqsystem", "set_access_force_https"}, call("setForceHttps"), "", 228)
    
    -- ==================== 注册状态API ====================
    -- 获取注册状态
    entry({"api", "xqsystem", "get_register_status"}, call("getRegisterStatus"), "", 230, 9)
    
    -- ==================== SIM卡API ====================
    -- 获取SIM卡状态
    entry({"api", "xqsystem", "get_sim_status"}, call("getSimStatus"), "", 231, 9)
    
    -- ==================== Modem日志API ====================
    -- 启动Modem日志
    entry({"api", "xqsystem", "modem_logd_start"}, call("modemLogdStart"), "", 233, 8)
    -- 停止Modem日志
    entry({"api", "xqsystem", "modem_logd_stop"}, call("modemLogdStop"), "", 234, 8)
    
    -- ==================== 移动加速API ====================
    -- 设置移动加速
    entry({"api", "xqsystem", "maccel"}, call("setMobileAccel"), "", 101, 9)
    -- 检查移动加速
    entry({"api", "xqsystem", "ma_check"}, call("checkMobileAccel"), "", 101, 9)
    
    -- ==================== DMZ API ====================
    -- 获取DMZ信息
    entry({"api", "xqsystem", "dmz"}, call("getDMZInfo"), "", 250)
    -- 设置DMZ
    entry({"api", "xqsystem", "set_dmz"}, call("setDMZ"), "", 251)
    -- 关闭DMZ
    entry({"api", "xqsystem", "dmz_off"}, call("closeDMZ"), "", 252)
    -- 重载DMZ
    entry({"api", "xqsystem", "dmz_reload"}, call("reloadDMZ"), "", 252)
    
    -- ==================== WiFi分离API ====================
    -- 获取WiFi分离设置
    entry({"api", "xqsystem", "get_wifi_split"}, call("getWifiSplit"), "", 330, 8)
    -- 设置WiFi分离
    entry({"api", "xqsystem", "set_wifi_split"}, call("setWifiSplit"), "", 331, 8)
    
    -- ==================== 条件性API (基于功能特性) ====================
    
    -- NAT Pro功能 (端口转发高级版)
    if FEATURES.apps and FEATURES.apps.natpro == "1" then
        -- 获取虚拟服务器规则
        entry({"api", "xqsystem", "get_vs_rules"}, call("get_vs_rules"), "", 300)
        -- 设置虚拟服务器规则
        entry({"api", "xqsystem", "set_vs_rules"}, call("set_vs_rules"), "", 301)
        -- 设置虚拟服务器范围规则
        entry({"api", "xqsystem", "set_vs_range_rules"}, call("set_vs_range_rules"), "", 302)
        -- 删除虚拟服务器规则
        entry({"api", "xqsystem", "del_vs_rules"}, call("del_vs_rules"), "", 303)
        -- 应用虚拟服务器规则
        entry({"api", "xqsystem", "apply_vs_rules"}, call("apply_vs_rules"), "", 304)
        -- 获取端口触发规则
        entry({"api", "xqsystem", "get_pt_rules"}, call("get_pt_rules"), "", 305)
        -- 设置端口触发规则
        entry({"api", "xqsystem", "set_pt_rules"}, call("set_pt_rules"), "", 306)
        -- 删除端口触发规则
        entry({"api", "xqsystem", "del_pt_rules"}, call("del_pt_rules"), "", 307)
        -- 应用端口触发规则
        entry({"api", "xqsystem", "apply_pt_rules"}, call("apply_pt_rules"), "", 308)
        -- 设置ALG规则
        entry({"api", "xqsystem", "set_alg_rules"}, call("set_alg_rules"), "", 309)
        -- 获取ALG规则
        entry({"api", "xqsystem", "get_alg_rules"}, call("get_alg_rules"), "", 310)
    else
        -- 基础端口转发
        entry({"api", "xqsystem", "portforward"}, call("portForward"), "", 311)
        -- 添加重定向
        entry({"api", "xqsystem", "add_redirect"}, call("addRedirect"), "", 312)
        -- 添加范围重定向
        entry({"api", "xqsystem", "add_range_redirect"}, call("addRangeRedirect"), "", 313)
        -- 删除重定向
        entry({"api", "xqsystem", "delete_redirect"}, call("deleteRedirect"), "", 314)
        -- 应用重定向
        entry({"api", "xqsystem", "redirect_apply"}, call("redirectApply"), "", 315)
    end
    
    -- 防火墙功能
    if FEATURES.apps and FEATURES.apps.firewall == "1" then
        -- 设置防火墙开关
        entry({"api", "xqsystem", "set_firewall_enable"}, call("set_firewall_enable"), "", 316)
        -- 获取防火墙开关状态
        entry({"api", "xqsystem", "get_firewall_enable"}, call("get_firewall_enable"), "", 317)
        -- 设置SPI防火墙
        entry({"api", "xqsystem", "set_spi_firewall"}, call("set_spi_firewall"), "", 318)
        -- 获取SPI防火墙状态
        entry({"api", "xqsystem", "get_spi_firewall"}, call("get_spi_firewall"), "", 319)
        -- 设置DoS防火墙
        entry({"api", "xqsystem", "set_dos_firewall"}, call("set_dos_firewall"), "", 320)
        -- 获取DoS防火墙状态
        entry({"api", "xqsystem", "get_dos_firewall"}, call("get_dos_firewall"), "", 321)
        -- 设置WAN Ping防火墙
        entry({"api", "xqsystem", "set_wanping_firewall"}, call("set_wanping_firewall"), "", 322)
        -- 获取WAN Ping防火墙状态
        entry({"api", "xqsystem", "get_wanping_firewall"}, call("get_wanping_firewall"), "", 323)
        -- 获取MAC过滤信息
        entry({"api", "xqsystem", "get_macfilter_info"}, call("get_macfilter_info"), "", 324)
        -- 设置MAC过滤开关和模式
        entry({"api", "xqsystem", "set_macfilter_enable_mode"}, call("set_macfilter_enable_mode"), "", 325)
        -- 设置MAC过滤规则(批量)
        entry({"api", "xqsystem", "set_macfilter_rules"}, call("set_macfilter_rules"), "", 326)
        -- 设置MAC过滤规则(单条)
        entry({"api", "xqsystem", "set_macfilter_rule"}, call("set_macfilter_rule"), "", 327)
        -- 获取IP过滤信息
        entry({"api", "xqsystem", "get_ipfilter_info"}, call("get_ipfilter_info"), "", 328)
        -- 设置IP过滤开关和模式
        entry({"api", "xqsystem", "set_ipfilter_enable_mode"}, call("set_ipfilter_enable_mode"), "", 329)
        -- 设置IP过滤规则(批量)
        entry({"api", "xqsystem", "set_ipfilter_rules"}, call("set_ipfilter_rules"), "", 430)
        -- 设置IP过滤规则(单条)
        entry({"api", "xqsystem", "set_ipfilter_rule"}, call("set_ipfilter_rule"), "", 431)
    end
    
    -- 安全中心功能
    if FEATURES.apps and FEATURES.apps.sec_center == "1" then
        entry({"api", "xqsystem", "sec_center_status"}, call("secCenterStatus"), "", 999)
    end
    
    -- Web访问日志功能
    if FEATURES.system and FEATURES.system.web_acc_log == "1" then
        -- 获取登录记录
        entry({"api", "xqsystem", "get_login_record"}, call("getLoginRecord"), "", 229)
        -- 清除登录记录
        entry({"api", "xqsystem", "clear_login_record"}, call("clearLoginRecord"), "", 230)
    end
end

-- ============================================================================
-- 移动加速相关函数
-- ============================================================================

--[[
  设置移动加速
  参数:
    type: 1=开启, 2=续期, 3=关闭
    mode: 加速模式 (1-4)
]]
function setMobileAccel()
    local XQLog = require("xiaoqiang.XQLog")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local remoteIp = luci.http.getenv("REMOTE_ADDR") or ""
    local remoteMac = luci.sys.net.ip4mac(remoteIp) or ""
    local result = {code = 0}
    
    local accelType = http.formvalue("type")
    local mode = http.formvalue("mode")
    local action = nil
    
    if XQFunction.isStrNil(remoteIp) then
        result.code = -1
        XQLog.log(6, "setMobileAccel: remote_ip is null")
        http.write_json(result)
        return
    end
    
    if XQFunction.isStrNil(remoteMac) then
        result.code = -2
        XQLog.log(6, "setMobileAccel: remote_mac is null")
        http.write_json(result)
        return
    end
    
    if accelType == "1" or accelType == "3" then
        if not XQFunction.isStrNil(mode) then
            local modeNum = tonumber(mode)
            if modeNum < 1 or modeNum > 4 then
                result.code = -4
                XQLog.log(6, "setMobileAccel: invalid mode(" .. mode .. ")")
                http.write_json(result)
                return
            end
        end
        action = (accelType == "1") and "on" or "off"
    elseif accelType == "2" then
        action = "renew"
    else
        result.code = -3
        XQLog.log(6, "setMobileAccel: invalid type(" .. tostring(accelType) .. ")")
        http.write_json(result)
        return
    end
    
    action = XQFunction._strformat(action)
    mode = XQFunction._strformat(mode)
    XQFunction.forkExec("/usr/sbin/mobile_accel.sh '" .. action .. "' '" .. remoteIp .. "' '" .. remoteMac .. "' '" .. mode .. "'")
    http.write_json(result)
end

--[[
  检查移动加速状态
]]
function checkMobileAccel()
    local XQLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local remoteIp = luci.http.getenv("REMOTE_ADDR") or ""
    local remoteMac = luci.sys.net.ip4mac(remoteIp) or ""
    local mode = http.formvalue("mode")
    local result = {code = 0}
    
    if XQFunction.isStrNil(remoteMac) then
        result.code = -2
        XQLog.log(6, "checkMobileAccel: remote_mac is null")
        http.write_json(result)
        return
    end
    
    remoteMac = string.lower(string.gsub(remoteMac, "[:-]", ""))
    local curMode = uci:get("mobile_accel", remoteMac, "mode")
    
    if not curMode then
        result.code = -1
    else
        result.mode = curMode
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 扩展WiFi相关函数
-- ============================================================================

--[[
  扩展WiFi自动频段签名
]]
function ExtendWifiSignForAutoBand()
    local uci = require("luci.model.uci").cursor()
    local XQLog = require("xiaoqiang.XQLog")
    local result = {code = 0}
    
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local signStr = http.formvalue("sign_str") or ""
    signStr = XQSecureUtil.xssCheck(signStr)
    
    if signStr == nil then
        result.code = 1612
        result.msg = "Warning: Blocked by XSS Check"
        http.write_json(result)
        return
    elseif signStr == "" then
        result.code = 1612
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    end
    
    XQLog.log(1, "sign_str:" .. signStr)
    result.signed_str = signStr
    result.deviceid = uci:get("messaging", "deviceInfo", "DEVICE_ID")
    http.write_json(result)
end

--[[
  扩展WiFi连接已初始化的路由器
]]
function ExtendWifiConnectInitedRouter()
    local XQAPModule = require("xiaoqiang.module.XQAPModule")
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    local result = {code = 0, msg = ""}
    
    local ssid = http.formvalue("ssid")
    local encryption = http.formvalue("encryption")
    local enctype = http.formvalue("enctype")
    local password = http.formvalue("password")
    local channel = http.formvalue("channel")
    local band = http.formvalue("band")
    local adminUsername = http.formvalue("admin_username")
    local adminPassword = http.formvalue("admin_password")
    local adminNonce = http.formvalue("admin_nonce")
    
    local connectResult = XQAPModule.extendwifi_set_connect(ssid, password, enctype, encryption, band, channel)
    
    if connectResult.ip ~= "" then
        result.code = 0
        result.msg = "connect succces!"
    elseif connectResult.connected then
        local dhcpcode = connectResult.dhcpcode
        if dhcpcode == 100 then
            result.code = 1646
        elseif dhcpcode == 2 then
            result.code = 1647
        elseif dhcpcode == 102 then
            result.code = 1648
        elseif dhcpcode == 105 or dhcpcode == 106 then
            result.code = 1649
        elseif dhcpcode == 107 then
            result.code = 1650
        elseif dhcpcode == 110 or dhcpcode == 111 then
            result.code = 1651
        elseif dhcpcode == 115 or dhcpcode == 116 then
            result.code = 1652
        else
            result.code = 1619
            result.msg = "dhcp failed!"
        end
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    else
        result.code = 1616
        result.msg = "wifi connect faild!"
        http.write_json(result)
        return
    end
    
    local tokenResult = XQExtendWifi.oneClickGetRemoteTokenForLua(adminUsername, adminPassword, adminNonce)
    if tokenResult.code ~= 0 then
        tokenResult.msg = XQErrorUtil.getErrorMessage(tokenResult.code)
        http.write_json(tokenResult)
        return
    end
    
    http.write_json(tokenResult)
end

-- ============================================================================
-- 隐私设置相关函数
-- ============================================================================

--[[
  获取隐私设置状态
]]
function privacy()
    local result = {code = 0}
    result.privacy = XQSysUtil.getPrivacy() and 1 or 0
    http.write_json(result)
end

--[[
  设置隐私选项
]]
function setPrivacy()
    local privacyValue = tonumber(http.formvalue("privacy"))
    local result = {code = 0}
    XQSysUtil.setPrivacy(privacyValue == 1)
    http.write_json(result)
end

--[[
  设置隐私选项(新版)
]]
function setPrivacy_new()
    local privacyValue = tonumber(http.formvalue("privacy"))
    local result = {code = 0}
    XQSysUtil.setPrivacy(privacyValue == 1)
    http.write_json(result)
end

-- ============================================================================
-- 系统初始化信息函数
-- ============================================================================

--[[
  获取路由器初始化信息
  返回路由器的基本状态和配置信息
]]
function getInitInfo()
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    local wanStat = XQLanWanUtil.getWanMonitorStat()
    local countryCode = XQCountryCode.getCurrentCountryCode()
    local connect = (wanStat.WANLINKSTAT == "UP") and 1 or 0
    
    local result = {
        code = 0,
        connect = connect,
        inited = XQSysUtil.getInitInfo() and 1 or 0,
        bound = XQSysUtil.getPassportBindInfo() and 1 or 0,
        id = XQNetUtil.getSN(),
        routerId = XQNetUtil.getDeviceId(),
        hardware = XQSysUtil.getHardware(),
        model = XQConfigs.XQ_MODEL_PREFIX .. string.lower(XQSysUtil.getHardware() or ""),
        romversion = XQSysUtil.getRomVersion(),
        modules = XQSysUtil.getModulesList(),
        language = XQSysUtil.getLang(),
        countrycode = countryCode,
        routername = XQSysUtil.getRouterName(),
        maccel = XQSysUtil.getMobileAccel(),
        isRedmi = XQSysUtil.isRedmi(),
        displayName = XQSysUtil.getDisplayName(),
        isSupportMesh = XQSysUtil.isSupportMesh(),
        secAcc = XQSysUtil.getSecAcc(),
        showPrivacy = XQSysUtil.getGdprPrivacy(),
        newEncryptMode = XQSysUtil.getEncryptMode(),
        wifi_ap = XQSysUtil.isWifiApSupport(),
        support160M = XQFunction.isSupport160Mhz(),
        imei = XQSysUtil.getIMEI(),
        moduleVersion = XQSysUtil.getModuleSoftwareVersion(),
        features = FEATURES
    }
    
    if countryCode ~= "CN" then
        result.server = XQSysUtil.getServer()
    end
    
    if FEATURES.system and FEATURES.system.dt_spec == "1" then
        result.displayNameLstStr = XQSysUtil.getDisplayNameListStr()
    end
    
    if FEATURES.system and FEATURES.system.international == "1" then
        result.ipv6 = 0
    elseif FEATURES.system and FEATURES.system.ipv6_wired_v2 == "1" then
        result.ipv6 = 1
    end
    
    result.vpn_init = (FEATURES.system and FEATURES.system.vpn_init == "1") and 1 or 0
    
    http.write_json(result)
end

--[[
  获取工厂信息
]]
function getFacInfo()
    http.write_json(XQSysUtil.facInfo())
end

--[[
  获取Bdata信息
]]
function getBdataInfo()
    http.write_json(XQSysUtil.bdataInfo())
end

--[[
  告别/退出接口
]]
function farewell()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    XQFunction.forkExec("sleep 1; /sbin/farewell")
    http.write_json({code = 0})
end

-- ============================================================================
-- 登录认证相关函数
-- ============================================================================

--[[
  用户登录处理
]]
function actionLogin()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    
    local init = tonumber(http.formvalue("init"))
    local privacy = tonumber(http.formvalue("privacy"))
    local callback = http.formvalue("callback")
    
    result.code = 0
    
    if init and init == 1 then
        XQSysUtil.setPrivacy(privacy == 1)
        result.url = luci.dispatcher.build_url("web", "init", "guide")
    else
        result.url = luci.dispatcher.build_url("web", "home")
    end
    
    local remoteIp = luci.http.getenv("REMOTE_ADDR") or ""
    local remoteMac = luci.sys.net.ip4mac(remoteIp) or ""
    XQSysUtil.writeLoginRecord(remoteIp, remoteMac)
    
    if XQFunction.getFeature("1", "system", "sp_lib") == "1" then
        local XQStatPoints = require("xiaoqiang.XQStatPoints")
        XQStatPoints.Log("sys.ctrl", "web:1")
    end
    
    result.token = luci.dispatcher.context.urltoken.stok
    
    if XQFunction.isStrNil(callback) then
        http.write_json(result)
    else
        http.write_jsonp(result, callback)
    end
end

--[[
  获取登录记录
]]
function getLoginRecord()
    local result = {code = 0}
    result.login_records = XQSysUtil.readLoginRecord()
    http.write_json(result)
end

--[[
  清除登录记录
]]
function clearLoginRecord()
    local result = {code = 0}
    XQSysUtil.clearLoginRecord()
    http.write_json(result)
end

--[[
  获取Token
]]
function getToken()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local sid = http.formvalue("sid")
    local result = {
        code = 0,
        token = luci.dispatcher.context.urltoken.stok,
        id = XQNetUtil.getSN(),
        name = XQSysUtil.getRouterName()
    }
    http.write_json(result)
end

--[[
  刷新Token
]]
function renewToken()
    local datatypes = require("luci.cbi.datatypes")
    local sauth = require("luci.sauth")
    local result = {}
    
    local ip = http.formvalue("ip")
    if ip and not datatypes.ipaddr(ip) then
        ip = nil
    end
    
    local session = sauth.available(ip)
    if session and session.token then
        result.token = session.token
    else
        local token = luci.sys.uniqueid(16)
        sauth.write(token, {
            user = "admin",
            token = token,
            ltype = "2",
            ip = ip,
            secret = luci.sys.uniqueid(16)
        })
        result.token = token
    end
    
    local XQFunction = require("xiaoqiang.common.XQFunction")
    if XQFunction.getFeature("1", "system", "sp_lib") == "1" then
        local XQStatPoints = require("xiaoqiang.XQStatPoints")
        XQStatPoints.Log("sys.ctrl", "app:1")
    end
    
    result.code = 0
    http.write_json(result)
end

--[[
  获取客户端IP
]]
function getIp()
    local result = {
        code = 0,
        ip = http.getenv("REMOTE_ADDR") or ""
    }
    http.write_json(result)
end

-- ============================================================================
-- 密码管理相关函数
-- ============================================================================

--[[
  内部函数: 保存密码
]]
local function _savePassword(nonce, oldPwd, newPwd, newPwd256)
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local code = 0
    local remoteMac = luci.dispatcher.getremotemac()
    
    if not XQSecureUtil.checkNonce(nonce, remoteMac) then
        return 1582
    end
    
    if not XQSecureUtil.checkUser("admin", nonce, oldPwd) then
        return 1552
    end
    
    local encryptMode = XQSysUtil.getEncryptMode()
    if encryptMode == 1 then
        if not XQSecureUtil.saveCiphertextLegacyPwd("admin", newPwd) then
            return 1553
        end
        if not XQSecureUtil.saveCiphertextPwd("admin", newPwd256) then
            return 1553
        end
    else
        if not XQSecureUtil.saveCiphertextPwd("admin", newPwd) then
            return 1553
        end
    end
    
    XQFunction.forkExec("/sbin/whc_to_re_common_api.sh webpasswd_update")
    return 0
end

--[[
  设置管理员密码
]]
function setPassword()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local result = {}
    local code = nil
    
    local nonce = http.formvalue("nonce")
    local oldPwd = http.formvalue("oldPwd")
    local newPwd = http.formvalue("newPwd")
    local newPwd256 = http.formvalue("newPwd256")
    
    if XQFunction.isStrNil(oldPwd) or XQFunction.isStrNil(newPwd) then
        code = 1502
    elseif nonce then
        code = _savePassword(nonce, oldPwd, newPwd, newPwd256)
    else
        code = 1523
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- 系统信息相关函数
-- ============================================================================

--[[
  获取系统信息
]]
function getSysInfo()
    local result = {
        code = 0,
        upTime = XQSysUtil.getSysUptime(),
        routerName = XQSysUtil.getRouterName(),
        romVersion = XQSysUtil.getRomVersion(),
        romChannel = XQSysUtil.getChannel(),
        hardware = XQSysUtil.getHardware()
    }
    http.write_json(result)
end

--[[
  获取所有系统信息
]]
function getAllInfo()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local wanStat = XQLanWanUtil.getWanMonitorStat()
    local connect = (wanStat.WANLINKSTAT == "UP") and 1 or 0
    
    local result = {
        code = 0,
        connect = connect,
        wifi = XQWifiUtil.getAllWifiInfo(),
        wan = XQLanWanUtil.getLanWanInfo("wan"),
        lan = XQLanWanUtil.getLanWanInfo("lan")
    }
    
    result.wifi[1].channel = XQWifiUtil.getWifiWorkChannel(1)
    result.wifi[2].channel = XQWifiUtil.getWifiWorkChannel(2)
    
    http.write_json(result)
end

--[[
  获取连接设备数量
]]
function getConDevCount()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {
        code = 0,
        count = XQDeviceUtil.getConnectDeviceCount()
    }
    http.write_json(result)
end

--[[
  获取LAN/WAN统计信息
]]
function getLanWanSta()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {
        code = 0,
        lan = XQDeviceUtil.getWanLanNetworkStatistics("lan"),
        wan = XQDeviceUtil.getWanLanNetworkStatistics("wan")
    }
    http.write_json(result)
end

-- ============================================================================
-- 设备管理相关函数
-- ============================================================================

--[[
  获取设备列表
]]
function getDeviceList()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local all = tonumber(http.formvalue("all")) == 1
    
    local result = {
        code = 0,
        mac = luci.dispatcher.getremotemac(),
        list = XQDeviceUtil.getDeviceList(not all, true)
    }
    http.write_json(result)
end

--[[
  获取Zigbee设备列表
]]
function getDeviceListZigbee()
    local XQZigbeeUtil = require("xiaoqiang.util.XQZigbeeUtil")
    local result = {
        code = 0,
        mac = luci.dispatcher.getremotemac(),
        list = {}
    }
    XQZigbeeUtil.append_yeelink_list(result.list)
    http.write_json(result)
end

--[[
  设置设备昵称
]]
function setDeviceNickName()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local name = http.formvalue("name")
    local owner = http.formvalue("owner")
    local device = http.formvalue("device")
    
    if XQFunction.isStrNil(mac) or XQFunction.isStrNil(name) then
        code = 1502
    else
        XQDeviceUtil.saveDeviceName(mac, name, owner, device)
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
  检查互联网连接
]]
function isInternetConnect()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local wanStat = XQLanWanUtil.getWanMonitorStat()
    local connect = (wanStat.WANLINKSTAT == "UP") and 1 or 0
    
    local result = {
        code = 0,
        connect = connect
    }
    http.write_json(result)
end

-- ============================================================================
-- 绑定相关函数
-- ============================================================================

--[[
  获取Passport绑定信息
]]
function getPassportBindInfo()
    local uuid = XQSysUtil.getPassportBindInfo()
    local result = {code = 0}
    
    if uuid then
        result.bound = 1
        result.uuid = uuid
    else
        result.bound = 0
    end
    
    http.write_json(result)
end

--[[
  设置Passport绑定
]]
function setPassportBound()
    local uuid = http.formvalue("uuid")
    local result = {}
    
    if not XQSysUtil.setPassportBound(true, uuid) then
        result.code = 1501
        result.msg = XQErrorUtil.getErrorMessage(1501)
    else
        result.code = 0
    end
    
    http.write_json(result)
end

--[[
  移除Passport绑定信息
]]
function removePassportBindInfo()
    local uuid = http.formvalue("uuid")
    XQSysUtil.setPassportBound(false, uuid)
    http.write_json({code = 0})
end

-- ============================================================================
-- 路由器名称相关函数
-- ============================================================================

--[[
  获取路由器名称
]]
function getRouterName()
    local result = {
        code = 0,
        routerName = XQSysUtil.getRouterName()
    }
    http.write_json(result)
end

--[[
  设置路由器名称
]]
function setRouterName()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local routerName = http.xqformvalue("routerName")
    local result = {}
    local code = 0
    
    if XQFunction.isStrNil(routerName) then
        code = 1502
    else
        local newName = XQSysUtil.setRouterName(routerName)
        if newName == false then
            code = 1503
        else
            result.routerName = newName
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- 固件升级相关函数
-- ============================================================================

--[[
  检查ROM更新
]]
function checkRomUpdate()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local result = {}
    local status = {status = 0, percent = 0}
    local code = 0
    
    local updateInfo = XQNetUtil.checkUpgrade()
    if updateInfo == false then
        code = 1504
    else
        code = 0
        result = updateInfo
    end
    
    result.status = status
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

--[[
  升级ROM
]]
function upgradeRom()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")
    
    local url = http.formvalue("url")
    local filesize = tostring(http.formvalue("filesize") or "")
    local hash = tostring(http.formvalue("hash") or "")
    local needpermission = tonumber(http.formvalue("needpermission"))
    
    if needpermission and needpermission == 1 then
        XQSysUtil.setFlashPermission(false)
    else
        XQSysUtil.setFlashPermission(true)
    end
    
    local result = {}
    local code = 0
    
    if XQSysUtil.checkBeenUpgraded() then
        code = 1577
    elseif XQSysUtil.isUpgrading() then
        code = 1568
    elseif not XQSecureUtil.cmdSafeCheck(url) or 
           not XQSecureUtil.cmdSafeCheck(filesize) or 
           not XQSecureUtil.cmdSafeCheck(hash) then
        code = 1523
    end
    
    result.code = code
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    http.write_json(result)
    
    if code == 0 then
        XQFunction.sysLock()
        if url and filesize ~= "" and hash ~= "" then
            XQFunction.forkExec(string.format(
                "/usr/sbin/crontab_rom.sh '%s' '%s' '%s'",
                XQSecureUtil.parseCmdline(url),
                XQSecureUtil.parseCmdline(hash),
                XQSecureUtil.parseCmdline(filesize)
            ))
        else
            XQFunction.forkExec("/usr/sbin/crontab_rom.sh")
        end
    end
end

--[[
  取消升级
]]
function cancelUpgrade()
    local code = 0
    local result = {}
    
    if not XQSysUtil.cancelUpgrade() then
        code = 1579
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    result.code = code
    http.write_json(result)
end

--[[
  刷写ROM
]]
function flashRom()
    local fs = require("luci.fs")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQPreference = require("xiaoqiang.XQPreference")
    
    local custom = tonumber(http.formvalue("custom") or "0")
    local recovery = tonumber(http.formvalue("recovery") or "0")
    local result = {}
    local code = 0
    local romPath = XQConfigs.ROM_CACHE_FILEPATH
    
    if custom == 1 then
        romPath = XQSysUtil.getUploadRomFilePath()
    end
    
    local flashStatus = XQSysUtil.getFlashStatus()
    if flashStatus == 1 then
        code = 1560
    elseif flashStatus == 2 then
        code = 1577
    elseif not fs.access(romPath) then
        code = 1507
    end
    
    XQFunction.ledFlashAlert(false)
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
    
    if code == 0 then
        http.close()
        XQFunction.sysLock()
        XQFunction.forkExec("flash.sh " .. romPath .. ((recovery == 1) and " 1" or ""))
    else
        fs.unlink(romPath)
    end
end

--[[
  获取刷写状态
]]
function flashStatus()
    local result = {
        code = 0,
        status = XQSysUtil.getFlashStatus()
    }
    http.write_json(result)
end

--[[
  获取升级状态
]]
function upgradeStatus()
    local result = {
        code = 0,
        status = XQSysUtil.checkUpgradeStatus()
    }
    
    if result.status == 3 then
        local XQPreference = require("xiaoqiang.XQPreference")
        local XQDownloadUtil = require("xiaoqiang.util.XQDownloadUtil")
        local downloadId = XQPreference.get(XQConfigs.PREF_ROM_DOWNLOAD_ID, nil)
        result.percent = XQDownloadUtil.downloadPercent(downloadId)
    elseif result.status == 5 then
        result.percent = XQSysUtil.getFlashProgress()
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 系统操作相关函数
-- ============================================================================

--[[
  重启路由器
]]
function reboot()
    local XQLog = require("xiaoqiang.XQLog")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local client = http.formvalue("client")
    local lanIp = XQLanWanUtil.getLanWanIp("lan")
    local result = {}
    
    if client == "web" then
        XQLog.check(0, XQLog.KEY_REBOOT, 1)
    end
    
    result.code = 0
    result.lanIp = lanIp
    http.write_json(result)
    http.close()
    XQFunction.forkReboot()
end

--[[
  恢复出厂设置
]]
function reset()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local uci = require("luci.model.uci").cursor()
    
    local format = tonumber(http.formvalue("format") or "0")
    local code = 0
    local result = {}
    local resetCmd = XQConfigs.FORK_RESET_ALL
    
    if format == 1 then
        resetCmd = "/usr/sbin/format_userdisk fs >/dev/null 2>/dev/null ;" .. resetCmd
    end
    
    if XQFunction.isMeshCap() then
        resetCmd = "ubus call xq_info_sync_mqtt restore >/dev/null 2>/dev/null ;" .. resetCmd
    end
    
    result.code = code
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    http.write_json(result)
    http.close()
    
    if result.code == 0 then
        XQFunction.thrift_tunnel_to_smarthome_controller("{\"command\":\"reset_scenes\"}")
        XQFunction.forkExec(resetCmd)
    end
end

--[[
  解绑设备
]]
function unbind()
    local XQLog = require("xiaoqiang.XQLog")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    XQLog.log(6, "deivce unbind from server")
    XQFunction.forkExec("/etc/messagingagent/unbind.sh")
    
    http.write_json({code = 0})
    http.close()
end

--[[
  获取系统平均负载
]]
function getSysAvgLoad()
    local util = require("luci.util")
    
    XQSysUtil.setDetectionTimestamp()
    
    local result = {
        code = 0,
        loadavg = tonumber(util.exec("/usr/sbin/sysapi system_info get cpuload")),
        processCount = tonumber(util.exec("cat /proc/cpuinfo | grep -c 'processor'"))
    }
    
    http.write_json(result)
    http.close()
end

-- ============================================================================
-- 语言设置相关函数
-- ============================================================================

--[[
  获取语言列表
]]
function getLangList()
    local result = {
        code = 0,
        list = XQSysUtil.getLangList(),
        lang = XQSysUtil.getLang()
    }
    http.write_json(result)
end

--[[
  获取主语言
]]
function getMainLang()
    local result = {
        code = 0,
        lang = XQSysUtil.getLang()
    }
    http.write_json(result)
end

--[[
  设置语言
]]
function setLang()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local code = 0
    local result = {}
    local language = http.formvalue("language")
    
    if XQFunction.isStrNil(language) then
        code = 1502
    elseif not XQSysUtil.setLang(language) then
        code = 1511
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- 位置设置相关函数
-- ============================================================================

--[[
  获取位置
]]
function getLocation()
    local result = {code = 0}
    local location, name = XQSysUtil.getLocation()
    
    if location == "" then
        result.code = 1502
    else
        result.location = location
        result.name = name
    end
    
    http.write_json(result)
end

--[[
  设置位置
]]
function setLocation()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local code = 0
    local result = {}
    
    local location = http.formvalue("location")
    local server = http.formvalue("server")
    
    if XQFunction.isStrNil(location) then
        code = 1502
    elseif not XQSysUtil.setLocation(location, true, server) then
        code = 1511
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- HTTPS强制设置相关函数
-- ============================================================================

--[[
  获取强制HTTPS设置
]]
function getForceHttps()
    local uci = require("luci.model.uci").cursor()
    local forceHttps = uci:get("nginx", "main", "force_https") or "0"
    
    local result = {
        code = 0,
        on = tonumber(forceHttps)
    }
    http.write_json(result)
end

--[[
  设置强制HTTPS
]]
function setForceHttps()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local uci = require("luci.model.uci").cursor()
    
    local on = tonumber(http.formvalue("on"))
    local value = (on == 1) and "1" or "0"
    
    local result = {
        code = 0,
        on = tonumber(value)
    }
    
    uci:set("nginx", "main", "force_https", value)
    uci:commit("nginx")
    XQFunction.forkExec("/etc/init.d/nginx restart")
    
    http.write_json(result)
end

-- ============================================================================
-- 日志上传相关函数
-- ============================================================================

--[[
  上传日志文件
]]
function uploadLogFile()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQLog = require("xiaoqiang.XQLog")
    local util = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    
    local code = 0
    local result = {}
    
    if XQFunction.isMeshCap() then
        local logKey = XQNetUtil.generateLogKeyV2()
        XQLog.log(6, "CAP call RE upload log, CAP key:" .. logKey)
        XQFunction.forkExec("/sbin/whc_to_re_common_api.sh log_upload " .. logKey)
    end
    
    util.exec("/usr/sbin/log_collection.sh")
    
    if not XQNetUtil.uploadLogV2() then
        code = 1512
    end
    
    result.code = code
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    
    util.exec("rm " .. XQConfigs.LOG_ZIP_FILEPATH)
    http.write_json(result)
end

-- ============================================================================
-- MAC过滤相关函数
-- ============================================================================

--[[
  检查是否可以添加MAC过滤规则
]]
local function checkAddMaxMACNumItem()
    local uci = require("luci.model.uci").cursor()
    local mode = uci:get("macfilter", "wan", "mode")
    local maxrulenum = tonumber(uci:get("macfilter", "wan", "maxrulenum")) or 0
    
    if mode == "black" then
        local blacknum = tonumber(uci:get("macfilter", "wan", "blacknum"))
        if maxrulenum < blacknum then
            return 2700
        end
    elseif mode == "white" then
        local whitenum = tonumber(uci:get("macfilter", "wan", "whitenum"))
        if maxrulenum < whitenum then
            return 2700
        end
    end
    
    return 0
end

--[[
  内部函数: 设置MAC过滤
]]
local function _setMacFilter(mac, name, option, wan)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQFirewall = require("xiaoqiang.module.XQFirewall")
    local XQController = require("xiaoqiang.util.XQController")
    local XQSynchrodata = require("xiaoqiang.util.XQSynchrodata")
    local XQParentControl = require("xiaoqiang.module.XQParentControl")
    
    local syncInfo = {mac = XQFunction.macFormat(mac)}
    local code = checkAddMaxMACNumItem()
    
    if code ~= 0 then
        return code
    end
    
    if wan ~= "" then
        wan = (tonumber(wan) == 1) and "1" or "0"
        syncInfo.wan = (wan == "1") and 1 or 0
        XQParentControl.macfilter_wan_changed(mac, wan == "1")
    end
    
    if name then
        syncInfo.name = name
    else
        name = mac
    end
    
    if option then
        option = (tonumber(option) == 1) and "1" or "0"
        syncInfo.option = (option == "1") and 1 or 0
    end
    
    XQFirewall.setMacFilter(string.upper(mac), name, option, wan)
    XQController.permission(mac, lan, wan, admin, pridisk)
    XQSynchrodata.syncDeviceInfo(syncInfo)
    
    return code
end

--[[
  设置MAC过滤
]]
function setMacFilter()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local datatypes = require("luci.cbi.datatypes")
    local result = {}
    local code = 0
    
    local mac = http.formvalue("mac")
    local wan = http.formvalue("wan") or ""
    local lan = http.formvalue("lan") or ""
    local admin = http.formvalue("admin") or ""
    local pridisk = http.formvalue("pridisk") or ""
    local name = http.formvalue("name", nil, "?commonstr") or ""
    local option = http.formvalue("option") or ""
    
    if not XQFunction.isStrNil(mac) and datatypes.macaddr(mac) then
        code = _setMacFilter(mac, name, option, wan)
    else
        code = 1508
    end
    
    result.code = code
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
    end
    http.write_json(result)
end

-- ============================================================================
-- 路由器初始化配置函数
-- ============================================================================

--[[
  路由器初始化配置
  设置WiFi、密码、WAN等初始配置
]]
function setRouter()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    local result = {}
    local code = 0
    local errors = {}
    local needRestart = false
    
    local nonce = http.formvalue("nonce")
    local newPwd = http.formvalue("newPwd")
    local oldPwd = http.formvalue("oldPwd")
    local newPwd256 = http.formvalue("newPwd256")
    local wifiPwd = http.formvalue("wifiPwd")
    local wifi24Ssid = http.formvalue("wifi24Ssid")
    local wifi50Ssid = http.formvalue("wifi50Ssid")
    local wanType = http.formvalue("wanType")
    local pppoeName = http.formvalue("pppoeName")
    local pppoePwd = http.formvalue("pppoePwd")
    
    XQFunction.nvramSet("Router_unconfigured", "0")
    XQFunction.nvramCommit()
    
    local ssidCheck = XQWifiUtil.checkSSID(wifi24Ssid, 28)
    
    if not XQFunction.isStrNil(wifi24Ssid) and ssidCheck == 0 then
        XQSysUtil.setRouterName(wifi24Ssid)
    end
    
    if not XQFunction.isStrNil(newPwd) and not XQFunction.isStrNil(oldPwd) then
        if nonce then
            code = _savePassword(nonce, oldPwd, newPwd, newPwd256)
        else
            code = 1523
        end
        if code ~= 0 then
            table.insert(errors, XQErrorUtil.getErrorMessage(code))
        end
    end
    
    if not XQFunction.isStrNil(wanType) then
        local wanResult = nil
        if wanType == "pppoe" then
            if not XQFunction.isStrNil(pppoeName) and not XQFunction.isStrNil(pppoePwd) then
                wanResult = XQLanWanUtil.setWanPPPoE(pppoeName, pppoePwd)
            end
        elseif wanType == "dhcp" then
            wanResult = XQLanWanUtil.setWanStaticOrDHCP(wanType)
        end
        if not wanResult then
            code = 1518
            table.insert(errors, XQErrorUtil.getErrorMessage(code))
        else
            needRestart = true
        end
    end
    
    if not XQFunction.isStrNil(wifiPwd) and ssidCheck == 0 then
        local wifi24Result = XQWifiUtil.setWifiBasicInfo(1, wifi24Ssid, wifiPwd, "psk2", nil, nil, 0)
        local wifi50Result = XQWifiUtil.setWifiBasicInfo(2, wifi50Ssid, wifiPwd, "psk2", nil, nil, 0)
        if wifi24Result or wifi50Result then
            needRestart = true
        end
        if not wifi24Result or not wifi50Result then
            code = XQWifiUtil.checkWifiPasswd(wifiPwd, "psk2")
            table.insert(errors, XQErrorUtil.getErrorMessage(code))
        end
    end
    
    if ssidCheck ~= 0 then
        code = ssidCheck
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(1519)
        result.errorDetails = errors
    end
    
    XQSysUtil.setSPwd()
    XQSysUtil.setInited()
    result.code = code
    http.write_json(result)
    
    if needRestart then
        http.close()
        XQFunction.forkRestartWifi()
    end
end

--[[
  设置初始化完成状态
]]
function setInited()
    local XQLog = require("xiaoqiang.XQLog")
    local client = http.formvalue("client")
    local result = {}
    
    if client == "ios" then
        XQLog.check(0, XQLog.KEY_GEL_INIT_IOS, 1)
    elseif client == "android" then
        XQLog.check(0, XQLog.KEY_GEL_INIT_ANDROID, 1)
    elseif client == "other" then
        XQLog.check(0, XQLog.KEY_GEL_INIT_OTHER, 1)
    end
    
    if not XQSysUtil.setInited() then
        result.code = 1501
        result.msg = XQErrorUtil.getErrorMessage(1501)
    else
        result.code = 0
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 路由器绑定相关函数
-- ============================================================================

--[[
  路由器绑定确认
]]
function routerBindOk()
    local XQLog = require("xiaoqiang.XQLog")
    local util = require("luci.util")
    local uci = require("luci.model.uci").cursor()
    local json = require("cjson")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local code = 0
    local result = {}
    
    local bindstatus = uci:get("wireless", "miot_2G", "bindstatus") or ""
    local userswitch = uci:get("wireless", "miot_2G", "userswitch") or ""
    local if_2G = uci:get("misc", "wireless", "if_2G") or ""
    
    if XQFunction.isMeshCap() then
        local bindFlag = uci:get("messaging", "deviceInfo", "BINDING") or ""
        local bindResultStr = util.trim(util.exec("matool --method api_call --params '/device/minet_get_bindinfo'"))
        local bindResult = json.decode(bindResultStr)
        
        XQLog.log(1, "bind_flag:" .. bindFlag)
        XQLog.log(1, "bind_result:" .. bindResultStr)
        
        if tostring(bindFlag) == "1" then
            if bindResult.code == 0 and bindResult.data and bindResult.data.bind == 1 then
                util.exec("ubus call xq_info_sync_mqtt bind")
                XQLog.log(6, "luci call bind ok... ")
                uci:set("messaging", "deviceInfo", "BINDING", "0")
                uci:commit("messaging")
            end
        else
            code = 1661
        end
    else
        uci:set("bind", "info", "status", "1")
        uci:set("bind", "info", "record", "1")
        uci:commit("bind")
        XQLog.log(6, "luci call bind ok... ")
    end
    
    if bindstatus == "0" then
        XQLog.log(6, "change bindstatus success")
        uci:set("wireless", "miot_2G", "bindstatus", "1")
        uci:commit("wireless")
        if userswitch == "1" then
            if if_2G == "wifi0" then
                util.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi0 enable")
            elseif if_2G == "wifi1" then
                util.exec("hostapd_cli -i wl13 -p /var/run/hostapd-wifi1 enable")
            else
                util.exec("ifconfig wl13 up")
            end
            util.exec("/usr/sbin/sysapi miot")
            util.exec("ubus call network reload")
        end
    end
    
    local miioOt = uci:get("misc", "features", "miio_ot") or ""
    if tonumber(miioOt) == 1 then
        util.exec("/usr/bin/miio_bind.sh")
        local deviceId = uci:get("messaging", "deviceInfo", "DEVICE_ID")
        local partnerId = uci:get("miio_ot", "ot", "partner_id")
        if deviceId == nil or partnerId == nil or deviceId ~= partnerId then
            XQLog.log(6, "miio_bind fail set code to 1661")
            code = 1661
        end
    end
    
    result.code = code
    http.write_json(result)
end

--[[
  新路由器绑定确认
]]
function newrouterBindOk()
    local XQLog = require("xiaoqiang.XQLog")
    local uci = require("luci.model.uci").cursor()
    
    local code = 0
    local result = {}
    
    local status = uci:get("bind", "info", "status") or ""
    if tostring(status) == "0" then
        uci:set("bind", "info", "status", "1")
        uci:set("bind", "info", "record", "1")
        uci:commit("bind")
        XQLog.log(6, "new luci call bind ok... ")
    end
    
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- ROM上传相关函数
-- ============================================================================

--[[
  上传ROM文件
]]
function uploadRom()
    local XQLog = require("xiaoqiang.XQLog")
    local fs = require("luci.fs")
    local sys = require("luci.sys")
    local util = require("luci.util")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local code = 0
    local sane = true
    local uploadDir = XQSysUtil.getUploadDir()
    local romPath = XQSysUtil.getUploadRomFilePath()
    local tmpPath = uploadDir .. sys.uniqueid(16)
    local contentLength = tonumber(http.getenv("CONTENT_LENGTH"))
    local uploadFile = http.getenv("UPLOADFILE")
    local nginxUpload = uploadFile and true or false
    
    util.exec("/usr/sbin/kill_plugin_process.sh > /dev/null")
    
    if nginxUpload then
        if romPath and fs.access(uploadFile) then
            fs.rename(uploadFile, romPath)
            XQLog.log(6, "nginx upload file ok, file rename " .. tostring(uploadFile) .. "=>" .. tostring(romPath))
            if not XQSysUtil.cutImage(romPath) then
                code = 1554
                XQLog.log(6, "-----cutImage failed----")
                fs.unlink(romPath)
            end
        else
            XQLog.log(6, "nginx upload file fail, file not exits!" .. tostring(uploadFile) .. "=>" .. tostring(romPath))
        end
    else
        local fp = nil
        sane = XQSysUtil.checkSpace(uploadDir, contentLength)
        
        http.setfilehandler(function(meta, chunk, eof)
            if sane then
                if not fp and meta and meta.name == "image" then
                    fp = io.open(tmpPath, "w")
                end
                if chunk then
                    fp:write(chunk)
                end
                if eof then
                    fp:close()
                    if fs.access(romPath) then
                        fs.unlink(romPath)
                    end
                    fs.rename(tmpPath, romPath)
                end
            else
                code = 1578
            end
        end)
        
        local image = http.formvalue("image")
        if image and fp then
            code = 0
        end
    end
    
    local result = {}
    if code == 0 and romPath then
        if not XQSysUtil.verifyImage(romPath) then
            code = 1554
            XQLog.log(6, "----uploadFile sucess but failed to verifyimage----")
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
        fs.unlink(romPath)
    else
        result.downgrade = XQSysUtil.checkRomVersion(romPath)
        if result.downgrade then
            fs.unlink(romPath)
        end
    end
    
    result.code = code
    http.write_json(result)
end

--[[
  分片上传ROM
]]
function uploadRomSplit()
    local XQLog = require("xiaoqiang.XQLog")
    local fs = require("luci.fs")
    local sys = require("luci.sys")
    local util = require("luci.util")
    
    local presentSlice = tonumber(http.formvalue("present_slice") or "0")
    local totalSlice = tonumber(http.formvalue("total_slice") or "0")
    local code = 0
    local sane = true
    local romPath = XQSysUtil.getUploadRomFilePath()
    local uploadFile = http.getenv("UPLOADFILE")
    local nginxUpload = uploadFile and true or false
    
    util.exec("echo 3 > /proc/sys/vm/drop_caches ")
    
    if fs.access(romPath) then
        fs.unlink(romPath)
    end
    
    local cpeHeaderPath = XQSysUtil.getUploadRomCPEHeaderFilePath()
    local cpeModemPath = XQSysUtil.getUploadRomCPEModemFilePath()
    local cpeSignPath = XQSysUtil.getUploadRomCPESignFilePath()
    
    if nginxUpload and presentSlice and totalSlice and presentSlice <= totalSlice then
        if fs.access(uploadFile) then
            if not XQSysUtil.cutImage(uploadFile) then
                code = 1554
                XQLog.log(6, "-----cutImage failed----")
                fs.unlink(uploadFile)
            else
                if not XQSysUtil.saveSliceImage(presentSlice, totalSlice, uploadFile) then
                    code = 1554
                    XQLog.log(6, "saveSliceImage failed !")
                end
            end
        else
            code = 1554
            XQLog.log(6, "nginx upload file fail, file not exits!" .. tostring(uploadFile))
        end
    else
        code = 1554
        XQLog.log(6, "-----uploadRomSplit failed ----")
    end
    
    local result = {}
    if presentSlice == totalSlice then
        if code == 0 and romPath then
            if not XQSysUtil.verifyImage(romPath) then
                code = 1554
                XQLog.log(6, "----uploadFile sucess but failed to verifyimage----")
            end
        end
        if code == 0 then
            result.downgrade = XQSysUtil.checkRomVersion(romPath)
            if result.downgrade then
                fs.unlink(romPath)
                fs.unlink(cpeHeaderPath)
                fs.unlink(cpeSignPath)
            end
        end
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
        fs.unlink(romPath)
        fs.unlink(cpeHeaderPath)
        fs.unlink(cpeSignPath)
    end
    
    result.code = code
    http.write_json(result)
end

-- ============================================================================
-- 插件管理相关函数
-- ============================================================================

--[[
  本地安装插件
]]
local function pluginLocalInstall()
    local json = require("json")
    local util = require("luci.util")
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    local payload = XQCryptoUtil.binaryBase64Enc("{\"api\":602,\"pluginPath\":\"/tmp/unified_plug.mpk\"}")
    local cmd = XQConfigs.THRIFT_TUNNEL_TO_DATACENTER % payload
    local result = util.exec(cmd)
    local decoded = json.decode(result)
    
    return decoded.code
end

--[[
  上传插件
]]
function uploadPlug()
    local XQLog = require("xiaoqiang.XQLog")
    local fs = require("luci.fs")
    local sys = require("luci.sys")
    local util = require("luci.util")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local code = 0
    local sane = true
    local uploadDir = XQSysUtil.getUploadDir()
    local plugPath = XQSysUtil.getUploadPlugFilePath()
    local tmpPath = uploadDir .. sys.uniqueid(16)
    local contentLength = tonumber(http.getenv("CONTENT_LENGTH"))
    local uploadFile = http.getenv("UPLOADFILE")
    local nginxUpload = uploadFile and true or false
    
    if nginxUpload then
        if plugPath and fs.access(uploadFile) then
            fs.rename(uploadFile, plugPath)
            XQLog.log(6, "nginx upload file ok, file rename " .. tostring(uploadFile) .. "=>" .. tostring(plugPath))
            if not XQSysUtil.cutImage(plugPath) then
                code = 1554
                fs.unlink(plugPath)
            end
        else
            XQLog.log(6, "nginx upload file fail, file not exits!" .. tostring(uploadFile) .. "=>" .. tostring(plugPath))
        end
    else
        local fp = nil
        sane = XQSysUtil.checkSpace(uploadDir, contentLength)
        
        http.setfilehandler(function(meta, chunk, eof)
            if sane then
                if not fp and meta and meta.name == "image" then
                    fp = io.open(tmpPath, "w")
                end
                if chunk then
                    fp:write(chunk)
                end
                if eof then
                    fp:close()
                    if fs.access(plugPath) then
                        fs.unlink(plugPath)
                    end
                    fs.rename(tmpPath, plugPath)
                end
            else
                code = 1578
            end
        end)
        
        local image = http.formvalue("image")
        if image and fp then
            code = 0
        end
    end
    
    local result = {}
    if code == 0 and plugPath then
        if not XQSysUtil.extractPlug(plugPath) then
            code = 1554
        end
    end
    
    if code == 0 then
        code = pluginLocalInstall()
    end
    
    if code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(code)
        fs.unlink(plugPath)
    end
    
    result.code = code
    http.write_json(result)
end

--[[
  获取已安装插件列表
]]
function installedPlug()
    local util = require("luci.util")
    local json = require("json")
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    local output = util.exec("pluginmanager -j '{\"api\":601}'")
    local result = {code = 0}
    
    if output then
        output = util.trim(output)
        if not XQFunction.isStrNil(output) then
            local decoded = json.decode(output)
            result.code = decoded.code
            result.msg = decoded.msg
            result.data = {list = decoded.data}
        end
    end
    
    http.write_json(result)
end

--[[
  一键获取远程Token
]]
function oneClickGetRemoteToken()
    local XQLog = require("xiaoqiang.XQLog")
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    
    local username = http.formvalue("username")
    local password = http.formvalue("password")
    local nonce = http.formvalue("nonce")
    
    local result = XQExtendWifi.oneClickGetRemoteTokenForLua(username, password, nonce)
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    
    http.write_json(result)
end

--[[
  扩展WiFi获取根目录信息
]]
function ExtendWifiGetRootDirInfo()
    local XQLog = require("xiaoqiang.XQLog")
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    local json = require("cjson")
    
    local result = {code = 0}
    local extendwifiAct = http.formvalue("extendwifi_act")
    local primaryDisk = http.formvalue("PrimaryDisk")
    
    if primaryDisk == nil or primaryDisk == "" then
        result.code = 1612
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    end
    
    local payload = {
        api = 3,
        path = primaryDisk,
        sharedOnly = 0,
        needSambaPath = 0
    }
    
    local ret = XQExtendWifi.ExtendWifiCallOldRouterDataCenterAPI(extendwifiAct, json.encode(payload))
    if ret.code ~= 0 then
        ret.msg = XQErrorUtil.getErrorMessage(ret.code)
        http.write_json(ret)
    else
        http.write(ret.msg)
    end
end

--[[
  扩展WiFi获取根目录使用情况
]]
function ExtendWifiGetRootDirUseage()
    local XQLog = require("xiaoqiang.XQLog")
    local XQExtendWifi = require("xiaoqiang.module.XQExtendWifi")
    local json = require("cjson")
    
    local result = {code = 0}
    local extendwifiAct = http.formvalue("extendwifi_act")
    local payload = {api = 116}
    local payloadStr = json.encode(payload)
    
    local retOld = XQExtendWifi.ExtendWifiCallOldRouterDataCenterAPI(extendwifiAct, payloadStr)
    XQLog.log(1, "ret_old.code" .. retOld.code)
    
    if retOld.code == 0 then
        local decoded = json.decode(retOld.msg)
        if decoded.code ~= 0 then
            result.code = 1644
            result.msg = XQErrorUtil.getErrorMessage(result.code)
            http.write_json(result)
            return
        end
    end
    
    if retOld.code == 1643 then
        result.code = 1644
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    end
    
    local retNew = XQExtendWifi.ExtendWifiCallNewRouterDataCenterAPI(extendwifiAct, payloadStr)
    XQLog.log(1, "ret_new:" .. retNew.code)
    
    if retNew.code == 0 then
        local decoded = json.decode(retNew.msg)
        if decoded.code ~= 0 then
            result.code = 1645
            result.msg = XQErrorUtil.getErrorMessage(result.code)
            http.write_json(result)
            return
        end
    end
    
    if retNew.code == 1643 then
        local diskCheck = XQExtendWifi.ExtendWifiRequestRemoteAPIForLua("/service/datacenter/is_has_disk", "1")
        if diskCheck.code == 0 then
            local decoded = json.decode(diskCheck.msg)
            if decoded.code == 0 and decoded.isHasDisk == true then
                retNew.code = 0
            else
                result.code = 1645
                result.msg = XQErrorUtil.getErrorMessage(result.code)
                http.write_json(result)
                return
            end
        else
            result.code = 1645
            result.msg = XQErrorUtil.getErrorMessage(result.code)
            http.write_json(result)
            return
        end
    end
    
    if retNew.code == 0 and retOld.code == 0 then
        http.write(retOld.msg)
    else
        if retOld.code == 0 then
            result.code = retNew.code
        else
            result.code = retOld.code
        end
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
    end
end
