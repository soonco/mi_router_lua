-- ============================================================================
-- 小米路由器系统 API 控制器模块
-- 提供路由器系统管理的各种 API 接口
-- 包括：设备管理、网络配置、QoS、磁盘管理、系统设置等
-- ============================================================================

module("luci.controller.api.misystem", package.seeall)

-- ============================================================================
-- 依赖模块加载
-- ============================================================================
local http = require("luci.http")
local XQLog = require("xiaoqiang.XQLog")
local datatypes = require("luci.cbi.datatypes")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")
local uci = require("luci.model.uci").cursor()

-- ============================================================================
-- 路由索引函数
-- 定义所有 API 路由入口点
-- ============================================================================
function index()
    -- 获取路由器特性配置
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES
    
    -- 创建 /api/xqsystem 节点
    local apiNode = node("api", "xqsystem")
    apiNode.target = firstchild()
    apiNode.title = ""
    apiNode.order = 100
    apiNode.sysauth = "admin"                    -- 需要管理员认证
    apiNode.sysauth_authenticator = "jsonauth"   -- 使用 JSON 认证方式
    apiNode.index = true
    
    -- 创建 /api/misystem 节点
    entry({"api", "misystem"}, firstchild(), "", 100)
    
    -- ========================================================================
    -- 系统状态相关 API
    -- ========================================================================
    
    -- 获取主状态信息
    entry({"api", "misystem", "status"}, call("mainStatus"), "", 101)
    
    -- 获取设备列表
    entry({"api", "misystem", "devicelist"}, call("getDeviceList"), "", 102)
    
    -- 获取设备服务列表
    entry({"api", "misystem", "device_list"}, call("getDeviceSrvList"), "", 102)
    
    -- 获取消息列表
    entry({"api", "misystem", "messages"}, call("getMessages"), "", 103)
    
    -- 获取路由器基本信息（公开接口，权限级别9）
    entry({"api", "misystem", "router_info"}, call("getRouterBaseInfo"), "", 104, 9)
    
    -- 获取路由器特性信息
    entry({"api", "misystem", "feature_info"}, call("getRouterFeatureInfo"), "", 104, 9)
    
    -- ========================================================================
    -- 路由器配置相关 API
    -- ========================================================================
    
    -- 设置配置日志
    entry({"api", "misystem", "set_log"}, call("setConfigLog"), "", 104, 9)
    
    -- 检查 IP 冲突
    entry({"api", "misystem", "check_ip_conflict"}, call("checkIpConflict"), "", 104, 8)
    
    -- 获取配置结果
    entry({"api", "misystem", "get_config_result"}, call("getConfigResult"), "", 104, 8)
    
    -- 获取路由器名称
    entry({"api", "misystem", "router_name"}, call("getRouterName"), "", 104, 8)
    
    -- 设置路由器名称
    entry({"api", "misystem", "set_router_name"}, call("setRouterName"), "", 105, 8)
    
    -- ========================================================================
    -- 路由器模式设置 API
    -- ========================================================================
    
    -- 设置 WiFi AP 模式
    entry({"api", "misystem", "set_router_wifiap"}, call("setWifiApMode"), "", 106, 8)
    
    -- 设置有线 AP 模式
    entry({"api", "misystem", "set_router_lanap"}, call("setLanApMode"), "", 106, 8)
    
    -- 设置普通路由模式
    entry({"api", "misystem", "set_router_normal"}, call("setRouterInfo"), "", 107, 8)
    
    -- 初始化 WiFi AP 模式
    entry({"api", "misystem", "set_router_wifiap_init"}, call("setWifiApMode_Init"), "", 106, 8)
    
    -- 初始化有线 AP 模式
    entry({"api", "misystem", "set_router_lanap_init"}, call("setLanApMode_Init"), "", 106, 8)
    
    -- ========================================================================
    -- WAN 口设置 API
    -- ========================================================================
    
    -- 设置 WAN 口
    entry({"api", "misystem", "set_wan"}, call("setWan"), "", 107, 8)
    
    -- 获取 PPPoE 状态
    entry({"api", "misystem", "pppoe_status"}, call("getPPPoEStatus"), "", 107, 8)
    
    -- 停止 PPPoE
    entry({"api", "misystem", "pppoe_stop"}, call("pppoeStop"), "", 107, 8)
    
    -- ========================================================================
    -- OTA 升级相关 API
    -- ========================================================================
    
    -- 获取 OTA 信息
    entry({"api", "misystem", "ota"}, call("getOTAInfo"), "", 108, 8)
    
    -- 设置 OTA 信息
    entry({"api", "misystem", "set_ota"}, call("setOTAInfo"), "", 109, 8)
    
    -- ========================================================================
    -- 设备信息相关 API
    -- ========================================================================
    
    -- 获取设备详情
    entry({"api", "misystem", "device_detail"}, call("getDeviceDetail"), "", 110)
    
    -- 获取设备信息
    entry({"api", "misystem", "device_info"}, call("getDeviceInfo"), "", 111, 8)
    
    -- ========================================================================
    -- WiFi 信道扫描 API
    -- ========================================================================
    
    -- 开始信道扫描
    entry({"api", "misystem", "channel_scan_start"}, call("channelScanStart"), "", 111)
    
    -- 获取扫描结果
    entry({"api", "misystem", "channel_scan_result"}, call("getScanResult"), "", 112)
    
    -- 设置信道
    entry({"api", "misystem", "set_channel"}, call("setChannel"), "", 113)
    
    -- ========================================================================
    -- Mesh 网络相关 API
    -- ========================================================================
    
    -- 获取拓扑图
    entry({"api", "misystem", "topo_graph"}, call("getTopoGraph"), "", 114, 13)
    
    -- 获取子 Mesh 信息
    entry({"api", "misystem", "child_mesh_infos"}, call("getChildMeshInfos"), "", 114, 8)
    
    -- ========================================================================
    -- 带宽测试 API
    -- ========================================================================
    
    -- 带宽测试
    entry({"api", "misystem", "bandwidth_test"}, call("bandwidthTest"), "", 115)
    
    -- 获取路由器通用状态
    entry({"api", "misystem", "router_common_status"}, call("getRouterStatus"), "", 116)
    
    -- ========================================================================
    -- QoS 服务质量相关 API
    -- ========================================================================
    
    -- 获取 QoS 信息
    entry({"api", "misystem", "qos_info"}, call("getQosInfo"), "", 117)
    
    -- 获取设备 QoS 信息
    entry({"api", "misystem", "qos_dev_info"}, call("getMACQoSInfo"), "", 117)
    
    -- 设置设备 QoS 信息
    entry({"api", "misystem", "qos_set_dev_info"}, call("setMACQoSInfo"), "", 117)
    
    -- QoS 开关
    entry({"api", "misystem", "qos_switch"}, call("qosSwitch"), "", 118)
    
    -- QoS 模式
    entry({"api", "misystem", "qos_mode"}, call("qosMode"), "", 119)
    
    -- QoS 限速
    entry({"api", "misystem", "qos_limit"}, call("qosLimit"), "", 120)
    
    -- QoS 限速标志
    entry({"api", "misystem", "qos_limit_flag"}, call("qosLimitFlag"), "", 120)
    
    -- QoS 批量限速
    entry({"api", "misystem", "qos_limits"}, call("qosLimits"), "", 121)
    
    -- 取消 QoS 限速
    entry({"api", "misystem", "qos_offlimit"}, call("qosOffLimit"), "", 122)
    
    -- 设置带宽
    entry({"api", "misystem", "set_band"}, call("setBand"), "", 123)
    
    -- 获取新版 QoS 信息
    entry({"api", "misystem", "qos_info_new"}, call("getQos"), "", 124)
    
    -- 访客 QoS
    entry({"api", "misystem", "qos_guest"}, call("qosGuest"), "", 124)
    
    -- 小米 QoS
    entry({"api", "misystem", "qos_xq"}, call("qosXQ"), "", 124)
    
    -- ========================================================================
    -- 激活和磁盘管理 API
    -- ========================================================================
    
    -- 激活
    entry({"api", "misystem", "active"}, call("active"), "", 125)
    
    -- 获取磁盘信息
    entry({"api", "misystem", "disk_info"}, call("getDiskinfo"), "", 126)
    
    -- 获取 IO 数据
    entry({"api", "misystem", "io_data"}, call("getIOData"), "", 127)
    
    -- 磁盘检查
    entry({"api", "misystem", "disk_check"}, call("diskCheck"), "", 128)
    
    -- 检查状态
    entry({"api", "misystem", "check_status"}, call("diskCheckStatus"), "", 129)
    
    -- 磁盘修复
    entry({"api", "misystem", "disk_repair"}, call("diskRepair"), "", 130)
    
    -- 修复状态
    entry({"api", "misystem", "repair_status"}, call("diskRepairStatus"), "", 131)
    
    -- 磁盘初始化
    entry({"api", "misystem", "disk_init"}, call("diskInit"), "", 131)
    
    -- 磁盘格式化
    entry({"api", "misystem", "disk_format"}, call("diskFormat"), "", 131)
    
    -- 异步磁盘格式化
    entry({"api", "misystem", "disk_format_async"}, call("diskFormatAsync"), "", 132)
    
    -- 格式化状态
    entry({"api", "misystem", "disk_format_status"}, call("diskFormatStatus"), "", 133)
    
    -- 磁盘状态
    entry({"api", "misystem", "disk_status"}, call("diskStatus"), "", 133)
    
    -- 磁盘 SMART 信息
    entry({"api", "misystem", "disk_smartctl"}, call("diskSmartCtl"), "", 133)
    
    -- ========================================================================
    -- 系统日志 API
    -- ========================================================================
    
    -- 备份系统日志
    entry({"api", "misystem", "sys_log"}, call("backupSysLog"), "", 132)
    
    -- 上传日志
    entry({"api", "misystem", "log_upload"}, call("syslogUpload"), "", 133)
    
    -- ========================================================================
    -- 注册和测速 API
    -- ========================================================================
    
    -- 注册
    entry({"api", "misystem", "register"}, call("register"), "", 134)
    
    -- 测速
    entry({"api", "misystem", "speed_test"}, call("speedTest"), "", 135)
    
    -- 测速结果
    entry({"api", "misystem", "speed_test_result"}, call("speedTestResult"), "", 136)
    
    -- ========================================================================
    -- 防蹭网相关 API
    -- ========================================================================
    
    -- 获取防蹭网状态
    entry({"api", "misystem", "arn_status"}, call("getAntiRubNetworkStatus"), "", 137)
    
    -- 设置防蹭网
    entry({"api", "misystem", "arn_switch"}, call("setAntiRubNetwork"), "", 138)
    
    -- 获取防蹭网记录
    entry({"api", "misystem", "arn_records"}, call("getAntiRubNetworkRecords"), "", 139)
    
    -- 设置防蹭网忽略
    entry({"api", "misystem", "arn_ignore"}, call("setAntiRubNetworkIgnore"), "", 140)
    
    -- ========================================================================
    -- 调试和密码 API
    -- ========================================================================
    
    -- 调试
    entry({"api", "misystem", "debug"}, call("debug"), "", 141)
    
    -- 修改密码
    entry({"api", "misystem", "password"}, call("changePassword"), "", 142)
    
    -- ========================================================================
    -- 生态系统相关 API
    -- ========================================================================
    
    -- 获取生态系统信息
    entry({"api", "misystem", "ecos_info"}, call("getEcosInfo"), "", 143)
    
    -- 生态系统开关
    entry({"api", "misystem", "ecos_switch"}, call("ecosSwitch"), "", 144)
    
    -- 生态系统升级
    entry({"api", "misystem", "ecos_upgrade"}, call("ecosUpgrade"), "", 145)
    
    -- 获取生态系统升级状态
    entry({"api", "misystem", "ecos_upgrade_status"}, call("getEcosUpgradeStatus"), "", 146)
    
    -- ========================================================================
    -- 硬件 NAT 相关 API
    -- ========================================================================
    
    -- 获取硬件 NAT 状态
    entry({"api", "misystem", "hwnat_status"}, call("hwnatStatus"), "", 147)
    
    -- 硬件 NAT 开关
    entry({"api", "misystem", "hwnat_switch"}, call("hwnatSwitch"), "", 148)
    
    -- ========================================================================
    -- HTTP 服务相关 API
    -- ========================================================================
    
    -- 获取 HTTP 状态
    entry({"api", "misystem", "http_status"}, call("httpStatus"), "", 149)
    
    -- HTTP 开关
    entry({"api", "misystem", "http_switch"}, call("httpSwitch"), "", 150)
    
    -- ========================================================================
    -- USB 相关 API
    -- ========================================================================
    
    -- 列出 USB 设备
    entry({"api", "misystem", "lsusb"}, call("lsusb"), "", 150, 9)
    
    -- ========================================================================
    -- 配置备份恢复 API
    -- ========================================================================
    
    -- 配置备份
    entry({"api", "misystem", "c_backup"}, call("cBackup"), "", 152)
    
    -- 配置下载
    local downloadEntry = entry({"api", "misystem", "c_download"}, call("cDownload"), "", 152)
    downloadEntry.leaf = true
    
    -- 配置上传
    entry({"api", "misystem", "c_upload"}, call("cUpload"), "", 153)
    
    -- 配置恢复
    entry({"api", "misystem", "c_restore"}, call("cRestore"), "", 154)
    
    -- ========================================================================
    -- 其他系统 API
    -- ========================================================================
    
    -- IP 冲突解决
    entry({"api", "misystem", "r_ip_conflict"}, call("rIpConflict"), "", 155, 9)
    
    -- 工具栏信息
    entry({"api", "misystem", "tb_info"}, call("toolbarInfo"), "", 156, 9)
    
    -- 增值服务信息
    entry({"api", "misystem", "vas_info"}, call("getVasInfo"), "", 157, 8)
    
    -- 增值服务开关
    entry({"api", "misystem", "vas_switch"}, call("setVasInfo"), "", 158, 8)
    
    -- 网络访问控制状态
    entry({"api", "misystem", "netacctl_status"}, call("networkAccessControlStatus"), "", 159)
    
    -- ========================================================================
    -- 系统时间 API
    -- ========================================================================
    
    -- 获取系统时间
    entry({"api", "misystem", "sys_time"}, call("getSysTime"), "", 172)
    
    -- 设置系统时间
    entry({"api", "misystem", "set_sys_time"}, call("setSysTime"), "", 173)
    
    -- ========================================================================
    -- MiWiFi 和 QoS 应用 API
    -- ========================================================================
    
    -- 是否为 MiWiFi
    entry({"api", "misystem", "miwifi"}, call("isMiWiFi"), "", 175, 8)
    
    -- QoS 应用入口
    entry({"api", "misystem", "qos_app_entry"}, call("qosApp"), "", 176)
    
    -- ========================================================================
    -- 安全相关 API
    -- ========================================================================
    
    -- 防蹭网安全
    entry({"api", "misystem", "arn_security"}, call("arnSecurity"), "", 177)
    
    -- 防蹭网安全开关
    entry({"api", "misystem", "arn_security_switch"}, call("arnSecuritySwitch"), "", 178)
    
    -- ========================================================================
    -- BSD（频段引导）相关 API
    -- ========================================================================
    
    -- 获取设备 BSD 信息
    entry({"api", "misystem", "get_dev_bsd"}, call("getDevBsdInfo"), "", 179)
    
    -- 设置设备 BSD 信息
    entry({"api", "misystem", "set_dev_bsd"}, call("setDevBsdInfo"), "", 180)
    
    -- ========================================================================
    -- 配置上传和 USB 模式 API
    -- ========================================================================
    
    -- 配置上传启用
    entry({"api", "misystem", "conf_upload_enable"}, call("confUploadEnable"), "", 181)
    
    -- 新版增值服务信息
    entry({"api", "misystem", "vas_info_new"}, call("getVasInfoNew"), "", 182, 9)
    
    -- 新版增值服务开关
    entry({"api", "misystem", "vas_switch_new"}, call("setVasInfoNew"), "", 183, 9)
    
    -- 设置 USB 3.0 模式
    entry({"api", "misystem", "usb_u3"}, call("setUsbMode3"), "", 184)
    
    -- 获取 USB 3.0 模式
    entry({"api", "misystem", "get_usb_u3"}, call("getUsbMode3"), "", 185)
    
    -- 设置 USB 2.0 模式
    entry({"api", "misystem", "usb_u2"}, call("setUsbMode2"), "", 186)
    
    -- 获取 USB 2.0 模式
    entry({"api", "misystem", "get_usb_u2"}, call("getUsbMode2"), "", 187)
    
    -- ========================================================================
    -- Elink 相关 API
    -- ========================================================================
    
    -- 设置 Elink
    entry({"api", "misystem", "set_elink"}, call("setElink"), "", 192, 8)
    
    -- 获取 Elink
    entry({"api", "misystem", "get_elink"}, call("getElink"), "", 193, 8)
    
    -- ========================================================================
    -- 网络诊断和 IoT 设备 API
    -- ========================================================================
    
    -- 获取端口扫描结果
    entry({"api", "misystem", "get_portscan_result"}, call("getPortScanResult"), "", 219, 8)
    
    -- 获取弱检测结果
    entry({"api", "misystem", "get_weakdetect_result"}, call("getWeakDetectResult"), "", 220, 8)
    
    -- 设置 IoT 设备配置
    entry({"api", "misystem", "set_config_iotdev"}, call("setConfigIotDev"), "", 221)
    
    -- 获取未配置的 IoT 设备
    entry({"api", "misystem", "get_unconfig_iotdev"}, call("getunConfigIotDev"), "", 222)
    
    -- 开始网络诊断
    entry({"api", "misystem", "net_diagnose_start"}, call("netDiagnoseStart"), "", 223)
    
    -- 获取网络诊断结果
    entry({"api", "misystem", "net_diagnose_result"}, call("netDiagnoseResult"), "", 224)
    
    -- 获取网络 WAN 模式
    entry({"api", "misystem", "get_netwan_mode"}, call("getNetWanMode"), "", 225)
    
    -- 获取 IoT 设备状态
    entry({"api", "misystem", "get_iotdev_status"}, call("getIotDevStatus"), "", 226)
    
    -- ========================================================================
    -- 语言和位置 API
    -- ========================================================================
    
    -- 获取位置
    entry({"api", "misystem", "get_location"}, call("getLocation"), "", 227, 9)
    
    -- 设置位置
    entry({"api", "misystem", "set_location"}, call("setLocation"), "", 228, 8)
    
    -- 获取语言列表（公开接口，权限级别1）
    entry({"api", "misystem", "get_languages"}, call("getLangList"), "", 229, 1)
    
    -- 获取主语言
    entry({"api", "misystem", "get_main_language"}, call("getMainLang"), "", 230, 1)
    
    -- 设置语言
    entry({"api", "misystem", "set_language"}, call("setLang"), "", 231, 8)
    
    -- ========================================================================
    -- IPTV/VLAN 相关 API
    -- ========================================================================
    
    -- 设置 IPTV
    entry({"api", "misystem", "set_iptv"}, call("setVlanService"), "", 320, 8)
    
    -- 获取 IPTV
    entry({"api", "misystem", "get_iptv"}, call("getVlanInternet"), "", 321)
    
    -- ... 更多 API 入口 ...
end

-- ============================================================================
-- Minet 设备管理相关函数
-- ============================================================================

-- 列出 Minet 设备
function minetListDevice()
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    local result = XQMinetUtil.listDevice()
    http.write_json(result)
end

-- 获取 Minet 状态
function minetGetState()
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    local result = XQMinetUtil.listFsm()
    http.write_json(result)
end

-- 控制 Minet 状态
function minetCtrlState()
    local result = { code = 0 }
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    local ctrl = http.formvalue("ctrl")
    local response = XQMinetUtil.ctrlState(ctrl)
    result.code = response.code
    http.write_json(response)
end

-- 授权 Minet 设备
function minetGrantDevice()
    local result = { code = 0 }
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    local devid = http.formvalue("devid")
    local ctrl = http.formvalue("ctrl")
    
    if devid == nil or ctrl == nil then
        result.code = 1
    else
        local response = XQMinetUtil.grantDevice(devid, ctrl)
        result.code = response.code
    end
    
    http.write_json(result)
end

-- 获取 Minet 配置
function minetGetConfig()
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    local result = XQMinetUtil.getConfig()
    http.write_json(result)
end

-- 设置 Minet 配置
function minetSetConfig()
    local result = { code = 0 }
    local config = {}
    local enable = http.formvalue("enable")
    local express = http.formvalue("express")
    
    if enable == "0" or enable == "1" then
        config.enable = enable
    end
    if express == "0" or express == "1" then
        config.express = express
    end
    
    local XQMinetUtil = require("xiaoqiang.util.XQMinetUtil")
    XQMinetUtil.setConfig(enable, express)
    http.write_json(result)
end

-- ============================================================================
-- Elink 相关函数
-- ============================================================================

-- 检测 Elink 是否启用（内部函数）
local function testElink()
    local enable = tonumber(luci.util.exec("ps | grep -v grep | grep elink > /dev/NULL 2>&1 ; echo $?"))
    XQLog.log(1, "test_elink, enbale type:" .. type(enable) .. " ,enable:" .. enable)
    
    if enable == 0 then
        return 1
    else
        return 0
    end
end

-- 获取 Elink 状态
function getElink()
    local result = {
        code = 0,
        enable = 0
    }
    result.enable = testElink()
    http.write_json(result)
end

-- 设置 Elink 状态
function setElink()
    local enable = http.formvalue("enable")
    
    -- 停止 Elink 的命令
    local stopCmd = [[
        timeout -t 10 -s 9
        /etc/init.d/elink stop;
        nvram set elink_en=0;
        nvram commit;
    ]]
    
    -- 启动 Elink 的命令
    local startCmd = [[
        time -t 10 -s 9
        nvram set elink_en=1;
        /etc/init.d/elink start;
        nvram commit;
   ]]
    
    local result = { code = 0 }
    
    -- 参数验证
    if enable == nil or enable == "" then
        result.code = 1612
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    end
    
    if enable ~= "0" and enable ~= "1" then
        result.code = 1537
        result.msg = XQErrorUtil.getErrorMessage(result.code)
        http.write_json(result)
        return
    end
    
    XQLog.log(1, "elink_enable:" .. enable)
    
    -- 启用 Elink
    if enable == "1" then
        if testElink() == 0 then
            XQFunction.forkExec(startCmd)
            XQLog.log(1, "enable elink")
        end
    end
    
    -- 禁用 Elink
    if enable == "0" then
        if testElink() == 1 then
            XQFunction.forkExec(stopCmd)
            XQLog.log(1, "kill all elink")
        end
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 激活和带宽测试相关函数
-- ============================================================================

-- 激活路由器（首次使用时进行带宽测试）
function active()
    local XQPreference = require("xiaoqiang.XQPreference")
    local XQNetworkSpeedTest = require("xiaoqiang.module.XQNetworkSpeedTest")
    local result = { code = 0 }
    
    -- 检查是否已经测试过带宽
    local bandwidth = XQPreference.get("BANDWIDTH")
    if bandwidth and tonumber(bandwidth) ~= 0 then
        http.write_json(result)
        return
    end
    
    -- 停止 QoS 服务
    os.execute("/etc/init.d/miqos stop")
    
    local XQQoSUtil = require("xiaoqiang.util.XQQoSUtil")
    
    -- 执行同步测速
    local upload, download = XQNetworkSpeedTest.syncSpeedTest()
    
    if upload and download then
        -- 转换为 Kbps
        local downloadKbps = tonumber(string.format("%.2f", 8 * download / 1024))
        local uploadKbps = tonumber(string.format("%.2f", 8 * upload / 1024))
        
        -- 保存带宽信息
        XQPreference.set("BANDWIDTH", string.format("%.2f", 8 * download / 1024), "xiaoqiang")
        XQPreference.set("BANDWIDTH2", string.format("%.2f", 8 * upload / 1024), "xiaoqiang")
        
        -- 设置 QoS 带宽
        XQQoSUtil.setQosBand(uploadKbps, downloadKbps)
    end
    
    -- 启动 QoS 服务
    os.execute("/etc/init.d/miqos start")
    
    http.write_json(result)
end

-- ============================================================================
-- 设备列表相关函数
-- ============================================================================

-- 获取新版主状态
function newmainStatus()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    
    -- 获取 2.4G 和 5G 设备数量
    local deviceCount2g, deviceCount5g = XQDeviceUtil.get2g5gDeviceCount()
    
    -- 获取 Mesh 设备数量
    local capCount, reCount = XQDeviceUtil.getMeshDeviceCount()
    
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    
    -- 获取无线网卡数量
    local wlanCount = XQWifiUtil.get_wlan_count()
    
    local result = {}
    local bsd = 0
    local wifiList = {}
    
    -- 遍历所有无线网卡
    for i = 1, wlanCount do
        local wifiInfo = XQWifiUtil.getWifiBasicInfo(i)
        if wifiInfo then
            local wifi = {}
            wifi.ssid = XQFunction.encode4HtmlValue(wifiInfo.ssid)
            wifi.passwd = wifiInfo.password or ""
            wifi.ssidHtmlEncode = (wifiInfo.ssidHtmlEncode and wifiInfo.ssidHtmlEncode == 1) and 1 or 0
            wifi.online_sta_count = deviceCount2g[i]
            wifiList[i] = wifi
        end
        if i == 1 then
            bsd = wifiInfo.bsd
        end
    end
    
    -- 构建硬件信息
    local hardware = {
        platform = "",
        version = "",
        channel = "",
        sn = "",
        mac = "",
        imei = "",
        hw_version = ""
    }
    
    result.code = 0
    result.hardware = hardware
    result["2g"] = wifiList[1]
    result["5g"] = wifiList[2]
    if wlanCount == 3 then
        result["5gh"] = wifiList[3]
    end
    result.count = deviceCount2g or 0
    result.cap_count = capCount or 0
    result.re_count = reCount or 0
    result.bsd = bsd
    
    http.write_json(result)
end

-- 获取设备列表
function getDeviceList()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = { code = 0 }
    
    -- 获取参数
    local online = tonumber(http.formvalue("online")) or 0
    local withbrlan = tonumber(http.formvalue("withbrlan")) or 0
    local mlo = tonumber(http.formvalue("mlo")) or 0
    
    -- 获取远程 MAC 地址
    result.mac = luci.dispatcher.getremotemac()
    
    -- 获取设备列表
    result.list = XQDeviceUtil.getDeviceListV2(
        online == 1,
        withbrlan == 1,
        mlo == 1
    )
    
    http.write_json(result)
end

-- 获取设备服务列表
function getDeviceSrvList()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = {
        code = 0,
        wanTX = 0,
        wanRX = 0
    }
    
    result.devices = XQDeviceUtil.getDeviceListV3("")
    http.write_json(result)
end

-- 获取设备详情
function getDeviceDetail()
    local XQDeviceUtil = require("xiaoqiang.util.XQDeviceUtil")
    local result = { code = 0 }
    
    local mac = http.formvalue("mac")
    
    -- 验证 MAC 地址
    if mac and datatypes.macaddr(mac) then
        result.info = XQDeviceUtil.getDeviceInfo(mac, true)
    else
        result.code = 1523
    end
    
    -- 添加错误信息
    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 消息和 IP 冲突检测函数
-- ============================================================================

-- 获取消息列表
function getMessages()
    local XQMessageBox = require("xiaoqiang.module.XQMessageBox")
    local messages = XQMessageBox.getMessages()
    
    local result = {
        code = 0,
        count = #messages,
        messages = messages
    }
    
    http.write_json(result)
end

-- 检查 IP 冲突
function checkIpConflict()
    local XQIPConflict = require("xiaoqiang.module.XQIPConflict")
    local result = {}
    
    local conflict = XQIPConflict.ip_conflict_detection() or false
    result.ip_conflict = conflict
    
    http.write_json(result)
end

-- ============================================================================
-- 路由器信息相关函数
-- ============================================================================

-- 获取路由器基本信息
function getRouterBaseInfo()
    local XQCountryCode = require("xiaoqiang.XQCountryCode")
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    local result = {}
    
    -- 路由器名称
    result.name = XQSysUtil.getRouterName()
    
    -- 硬件型号
    result.hardware = XQSysUtil.getHardware()
    
    -- 网络模式
    result.mode = XQLanWanUtil.getNetModeType()
    
    -- 颜色
    result.color = XQSysUtil.getColor()
    
    -- 区域设置
    result.locale = XQSysUtil.getRouterLocale()
    
    -- 语言
    result.lang = XQSysUtil.getLang() or ""
    
    -- 国家代码
    result.ccode = XQCountryCode.getBDataCountryCode()
    
    -- MAC 地址
    result.mac = XQLanWanUtil.getDefaultMacAddress() or ""
    
    -- 杂项特性
    result.features = XQSysUtil.getMiscFeaturesInfo() or {}
    
    -- 品牌信息
    result.brand = XQSysUtil.getBrandInfo() or {}
    
    http.write_json(result)
end

-- 设置配置日志
function setConfigLog()
    local result = { code = 0 }
    
    local logType = http.formvalue("type")
    local step = http.formvalue("step")
    
    XQLog.log(5, "stat_points_none luci_config=type:" .. logType .. ",step:" .. step)
    
    http.write_json(result)
end

-- ============================================================================
-- 文件检查辅助函数
-- ============================================================================

-- 检查文件是否存在
-- @param path string - 文件路径
-- @return boolean - 文件是否存在
function isFileExist(path)
    local file = io.open(path, "r")
    if file == nil then
        return false
    end
    file:close()
    return true
end

-- ============================================================================
-- 路由器初始化设置函数
-- ============================================================================

-- 设置路由器信息（初始化向导）
function setRouterInfo()
    local XQWifiUtil = require("xiaoqiang.util.XQWifiUtil")
    local XQIPConflict = require("xiaoqiang.module.XQIPConflict")
    local luciUtil = require("luci.util")
    
    local result = { code = 0 }
    
    -- 获取表单参数
    local name = http.formvalue("name")           -- 路由器名称
    local locale = http.formvalue("locale")       -- 区域设置
    local nonce = http.formvalue("nonce")         -- 随机数
    local newPwd = http.formvalue("newPwd")       -- 新密码
    local oldPwd = http.formvalue("oldPwd")       -- 旧密码
    local newPwd256 = http.formvalue("newPwd256") -- SHA256 密码
    local bsd = tonumber(http.formvalue("bsd")) or 0  -- 频段引导开关
    local ssid = http.formvalue("ssid")           -- 2.4G SSID
    local password = http.formvalue("password")   -- 2.4G 密码
    local ssid5g = http.formvalue("ssid5g") or "" -- 5G SSID
    local password5g = http.formvalue("password5g") or ""  -- 5G 密码
    local ssid5g2 = http.formvalue("ssid5g2") or ""        -- 5G-2 SSID
    local password5g2 = http.formvalue("password5g2") or "" -- 5G-2 密码
    local txpwr = tonumber(http.formvalue("txpwr")) or 0   -- 发射功率
    local bw160 = tonumber(http.formvalue("bw160")) or 0   -- 160MHz 带宽
    
    -- 设置 NVRAM 标志：路由器已配置
    XQFunction.nvramSet("Router_unconfigured", "0")
    XQFunction.nvramCommit()
    
    -- 检测用户代理类型
    local userAgent = string.lower(luci.http.getenv("HTTP_USER_AGENT") or "")
    local isBrowser = userAgent:match("mozilla")
    
    -- 记录统计点
    local XQStatPoints = require("xiaoqiang.XQStatPoints")
    if isBrowser then
        XQStatPoints.check(0, XQStatPoints.KEY_GEL_INIT_OTHER, 1)
    else
        XQStatPoints.check(0, XQStatPoints.KEY_GEL_INIT_APP, 1)
    end
    
    -- 检测 IP 冲突
    local ipConflict = XQIPConflict.ip_conflict_detection()
    if ipConflict then
        luciUtil.exec("/etc/init.d/cab_meshd stop")
    end
    
    -- 参数验证
    if XQFunction.isStrNil(name) or XQFunction.isStrNil(locale) or
       XQFunction.isStrNil(nonce) or XQFunction.isStrNil(newPwd) or
       XQFunction.isStrNil(oldPwd) or XQFunction.isStrNil(ssid) or
       XQFunction.isStrNil(password) then
        result.code = 1523
        http.write_json(result)
        return
    end
    
    -- 验证名称和区域长度
    if #name > 28 or #locale > 28 then
        result.code = 1523
        http.write_json(result)
        return
    end
    
    -- 保存密码
    if result.code == 0 then
        result.code = _savePassword(nonce, oldPwd, newPwd, newPwd256)
    end
    
    -- 设置 WiFi
    if result.code == 0 then
        local ssidCheck = XQWifiUtil.checkSSID(ssid, 28)
        if ssidCheck == 0 then
            -- 初始化 Mesh 连接
            luciUtil.exec("/usr/sbin/mesh_connect.sh init_cap 2")
            
            if bsd == 1 or bsd == true then
                -- BSD 模式：统一 SSID
                setInitBsdWifiInfo(bw160, ssid, password)
            else
                -- 非 BSD 模式：独立 SSID
                setInitWifiInfo(bw160, ssid, password, ssid5g, password5g, ssid5g2, password5g2)
            end
            
            -- 设置发射功率
            if txpwr == 1 then
                XQWifiUtil.setWifiTxpwr("max")
            else
                XQWifiUtil.setWifiTxpwr("mid")
            end
        end
    end
    
    http.write_json(result)
end

-- ============================================================================
-- 注意：由于原始文件有 16000+ 行，这里只展示了主要的结构和核心函数
-- 完整的函数实现请参考原始的 decode 文件
-- 以下是更多 API 函数的声明（实现类似上述模式）
-- ============================================================================

-- 主状态函数
function mainStatus()
    -- 实现获取路由器主状态信息
    -- 包括：CPU、内存、网络流量、在线设备数等
end

-- 获取路由器特性信息
function getRouterFeatureInfo()
    -- 返回路由器支持的特性列表
end

-- 获取配置结果
function getConfigResult()
    -- 返回配置操作的结果
end

-- 获取路由器名称
function getRouterName()
    -- 返回路由器名称
end

-- 设置路由器名称
function setRouterName()
    -- 设置路由器名称
end

-- 设置 WiFi AP 模式
function setWifiApMode()
    -- 将路由器设置为 WiFi AP 模式（无线中继）
end

-- 设置有线 AP 模式
function setLanApMode()
    -- 将路由器设置为有线 AP 模式
end

-- 设置 WAN 口
function setWan()
    -- 配置 WAN 口参数（DHCP/PPPoE/静态IP）
end

-- 获取 PPPoE 状态
function getPPPoEStatus()
    -- 返回 PPPoE 连接状态
end

-- 停止 PPPoE
function pppoeStop()
    -- 停止 PPPoE 连接
end

-- 获取 OTA 信息
function getOTAInfo()
    -- 获取固件更新信息
end

-- 设置 OTA 信息
function setOTAInfo()
    -- 设置固件更新配置
end

-- 获取设备信息
function getDeviceInfo()
    -- 获取指定设备的详细信息
end

-- 开始信道扫描
function channelScanStart()
    -- 开始 WiFi 信道扫描
end

-- 获取扫描结果
function getScanResult()
    -- 获取信道扫描结果
end

-- 设置信道
function setChannel()
    -- 设置 WiFi 信道
end

-- 获取拓扑图
function getTopoGraph()
    -- 获取 Mesh 网络拓扑图
end

-- 获取子 Mesh 信息
function getChildMeshInfos()
    -- 获取子 Mesh 节点信息
end

-- 带宽测试
function bandwidthTest()
    -- 执行带宽测试
end

-- 获取路由器状态
function getRouterStatus()
    -- 获取路由器通用状态
end

-- QoS 相关函数
function getQosInfo() end
function getMACQoSInfo() end
function setMACQoSInfo() end
function qosSwitch() end
function qosMode() end
function qosLimit() end
function qosLimitFlag() end
function qosLimits() end
function qosOffLimit() end
function setBand() end
function getQos() end
function qosGuest() end
function qosXQ() end
function qosApp() end

-- 磁盘管理函数
function getDiskinfo() end
function getIOData() end
function diskCheck() end
function diskCheckStatus() end
function diskRepair() end
function diskRepairStatus() end
function diskInit() end
function diskFormat() end
function diskFormatAsync() end
function diskFormatStatus() end
function diskStatus() end
function diskSmartCtl() end

-- 系统日志函数
function backupSysLog() end
function syslogUpload() end

-- 注册和测速函数
function register() end
function speedTest() end
function speedTestResult() end

-- 防蹭网函数
function getAntiRubNetworkStatus() end
function setAntiRubNetwork() end
function getAntiRubNetworkRecords() end
function setAntiRubNetworkIgnore() end
function arnSecurity() end
function arnSecuritySwitch() end

-- 调试和密码函数
function debug() end
function changePassword() end

-- 生态系统函数
function getEcosInfo() end
function ecosSwitch() end
function ecosUpgrade() end
function getEcosUpgradeStatus() end

-- 硬件 NAT 函数
function hwnatStatus() end
function hwnatSwitch() end

-- HTTP 服务函数
function httpStatus() end
function httpSwitch() end

-- USB 函数
function lsusb() end
function setUsbMode3() end
function getUsbMode3() end
function setUsbMode2() end
function getUsbMode2() end

-- 配置备份恢复函数
function cBackup() end
function cDownload() end
function cUpload() end
function cRestore() end

-- 其他系统函数
function rIpConflict() end
function toolbarInfo() end
function getVasInfo() end
function setVasInfo() end
function getVasInfoNew() end
function setVasInfoNew() end
function networkAccessControlStatus() end
function confUploadEnable() end

-- 系统时间函数
function getSysTime() end
function setSysTime() end

-- MiWiFi 函数
function isMiWiFi() end

-- BSD 函数
function getDevBsdInfo() end
function setDevBsdInfo() end

-- 网络诊断函数
function getPortScanResult() end
function getWeakDetectResult() end
function netDiagnoseStart() end
function netDiagnoseResult() end
function getNetWanMode() end

-- IoT 设备函数
function setConfigIotDev() end
function getunConfigIotDev() end
function getIotDevStatus() end
function setConfigIotDevHidessid() end
function getunConfigIotDevHidessid() end
function getIotDevStatusHidessid() end

-- 位置和语言函数
function getLocation() end
function setLocation() end
function getLangList() end
function getMainLang() end
function setLang() end

-- IPTV/VLAN 函数
function setVlanService() end
function getVlanInternet() end

-- WiFi 初始化辅助函数
function setInitWifiInfo(bw160, ssid, password, ssid5g, password5g, ssid5g2, password5g2)
    -- 设置初始 WiFi 信息（非 BSD 模式）
end

function setInitBsdWifiInfo(bw160, ssid, password)
    -- 设置初始 WiFi 信息（BSD 模式，统一 SSID）
end

-- 密码保存辅助函数
function _savePassword(nonce, oldPwd, newPwd, newPwd256)
    -- 保存管理员密码
    return 0
end
