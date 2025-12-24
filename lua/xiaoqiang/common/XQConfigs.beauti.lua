--[[
  小米路由器配置常量模块
  
  功能说明:
  - 定义系统级配置常量
  - 定义文件路径常量
  - 定义命令行常量
  - 定义API服务器地址
  - 定义SIM卡/CPE相关配置
  
  配置分类:
  - 服务器配置: API服务器、Passport服务器地址
  - 文件路径: 日志、缓存、配置文件路径
  - 系统命令: WiFi重启、系统重置、网络检测等
  - 设备信息: 版本号、MAC地址获取命令
  - QoS/VPN: 流量控制、VPN相关命令
  - SIM/CPE: 移动网络相关配置
]]

module("xiaoqiang.common.XQConfigs", package.seeall)

-- ==================== 服务器配置 ====================

-- 服务器配置标志 (0=在线, 1=测试, 2=预览)
SERVER_CONFIG = 0

-- API服务器地址
SERVER_CONFIG_ONLINE_URL = "uci get /etc/config/miwifi.server.API"
SERVER_CONFIG_STAGING_URL = "http://api.staging.miwifi.com"
SERVER_CONFIG_PREVIEW_URL = "http://api.preview.miwifi.com"

-- Passport认证服务器
PASSPORT_CONFIG_ONLINE_URL = "https://account.xiaomi.com/pass/serviceLogin"
PASSPORT_CONFIG_PREVIEW_URL = "http://account.preview.n.xiaomi.net/pass/serviceLogin"

-- 小米WiFi服务器
XQ_SERVER_ONLINE_STS_URL = "https://www.miwifi.com/sts"
XQ_SERVER_STAGING_STS_URL = "https://www.staging.miwifi.com/sts"

-- Passport登出地址
PASSPORT_LOGOUT_ONLINE_URL = "https://account.xiaomi.com/pass/logout"
PASSPORT_LOGOUT_PREVIEW_URL = "http://account.preview.n.xiaomi.net/pass/logout"

-- 小米WiFi API服务器
XQ_SERVER_ONLINE_API_URL = "https://www.miwifi.com"
XQ_SERVER_STAGING_API_URL = "https://www.staging.miwifi.com"

-- ==================== 文件路径配置 ====================

-- 临时文件路径
ARP_LIST_UI_FILEPATH = "/tmp/activate.arp.list.ui"      -- ARP列表UI文件
NIC_LIST_UI_FILEPATH = "/tmp/activate.nic.list.ui"      -- 网卡列表UI文件
LOG_ZIP_FILEPATH = "/tmp/log.tar.gz"                    -- 日志压缩包
PPP_LOG_FILEPATH = "/var/log/ppp.log"                   -- PPP日志

-- 偏好设置键名
PREF_IS_CONFIGURED = "CONFIGURED"                       -- 是否已配置
PREF_IS_INITED = "INITTED"                             -- 是否已初始化
PREF_IS_PASSPORT_BOUND = "PASSPORT_BOUND"              -- 是否绑定Passport
PREF_ROUTER_NAME = "ROUTER_NAME"                       -- 路由器名称
PREF_WAN_SPEED_HISTORY = "WAN_SPEED_HISTORY"           -- WAN测速历史
PREF_PASSPORT_BOUND_UUID = "PASSPORT_UUID"             -- 绑定的Passport UUID
PREF_UPGRADE_INFO = "UPGRADE_INFO"                     -- 升级信息
PREF_WPS_TIMESTAMP = "WPS_TIMESTAMP"                   -- WPS时间戳
PREF_ROUTER_NAME_PENDING = "ROUTER_NAME_PENDING"       -- 待设置的路由器名称
PREF_BOUND_USERINFO = "BOUND_USER_INFO"                -- 绑定用户信息
PREF_ROM_FULLSIZE = "ROM_FULLSIZE"                     -- ROM完整大小
PREF_PPPOE_NAME = "PPPOE_NAME"                         -- PPPoE用户名
PREF_PPPOE_PASSWORD = "PPPOE_PASSWORD"                 -- PPPoE密码
PREF_ROM_DOWNLOAD_URL = "ROM_DOWNLOAD_URL"             -- ROM下载地址
PREF_ROM_UPLOAD_URL = "ROM_UPLOAD_URL"                 -- ROM上传地址
PREF_PAUSED_IDS = "PAUSED_IDS"                         -- 暂停的ID列表
PREF_TIMESTAMP = "TIMESTAMP"                           -- 时间戳
PREF_ROM_DOWNLOAD_ID = "ROM_DOWNLOAD_ID"               -- ROM下载ID

-- ==================== WiFi相关命令 ====================

-- 获取WiFi CAC时间
GET_WIFI_CAC_TIME = "/sbin/wifi get_cac_time 2>/dev/null"

-- 重启WiFi命令（立即执行）
FORK_RESTART_WIFI_NOW = "/sbin/wifi update >/dev/null 2>/dev/null; /etc/init.d/minidlna restart; /etc/init.d/samba restart; /etc/init.d/minet restart; ubus call trafficd reload;/usr/bin/gettraffic flush_wl_dev >/dev/null 2>/dev/null"
FORK_RESTART_WIFI = FORK_RESTART_WIFI_NOW

-- 重启WiFi并通知设备
FORK_RESTART_WIFI_NOTIFY = "timeout -t 5 /usr/bin/miio_notify -u;/sbin/notice_tbus_device.sh; " .. FORK_RESTART_WIFI_NOW
FORK_RESTART_WIFI_NOTIFY_BUT_MIIO = "/sbin/notice_tbus_device.sh; " .. FORK_RESTART_WIFI_NOW

-- ==================== 系统控制命令 ====================

-- 恢复出厂设置
FORK_RESET_ALL = "sleep 4; /usr/sbin/restore_defaults.sh & >/dev/null 2>/dev/null"

-- 重启路由器
FORK_RESTART_ROUTER = "sleep 4; reboot"

-- 关机
FORK_SHUTDOWN_ROUTER = "sleep 4; /usr/sbin/uhbn 3"

-- 重启DNS服务
FORK_RESTART_DNSMASQ = "sleep 2; /etc/init.d/dnsmasq restart"

-- 重启MAC过滤
RESTART_MAC_FILTER = "/bin/sh /etc/firewall.macfilter"

-- ==================== 设备信息配置 ====================

-- 小米路由器型号前缀
XQ_MODEL_PREFIX = "xiaomi.router."

-- DHCP租约文件
DHCP_LEASE_FILEPATH = "/var/dhcp.leases"
DHCP_DENYLIST_FILEPATH = "/etc/config/firewall.mac.list"

-- WAN监控状态文件
WAN_MONITOR_STAT_FILEPATH = "/tmp/wan.monitor.stat"

-- 版本信息文件
XQ_ROM_VERSION_FILEPATH = "/usr/share/xiaoqiang/xiaoqiang_version"
XQ_LOG_JSON_FILEPATH = "/tmp/log.json"
XQ_CONFIG_JSON_FILEPATH = "/tmp/config.json"
XQ_WIFIPWDERROR_FILEPATH = "/tmp/wifi_error_xxxx"
XQ_CHANGELOG_FILEPATH = "/usr/share/xiaoqiang/changelog"

-- ROM缓存文件
ROM_CACHE_FILEPATH = "/tmp/rom.bin"
CROM_CACHE_FILEPATH = "/tmp/customrom.bin"
CPlug_CACHE_FILEPATH = "/tmp/uploadplug.mpk"
UBOOT_CACHE_FILEPATH = "/tmp/uboot.bin"

-- CPE相关文件
CPE_HEADER_CACHE_FILEPATH = "/tmp/modemHeader.bin"
CPE_MODEM_CACHE_FILEPATH = "/dev/mtd21"
CPE_SIGN_CACHE_FILEPATH = "/tmp/modemSign.bin"
CPE_HEADER_LENGTH = 192
CPE_SIGN_LENGTH = 272
CPE_UPLOAD_CPE_ROM_SLICE_SIZE = 31457280
CPE_MODEM_LENGTH_FILE = "/tmp/modemLength"
GET_CPE_MODEM_LENGTH_FILE = "cat " .. CPE_MODEM_LENGTH_FILE

-- OUI数据库
OUI_ZIP_FILEPATH = "/usr/share/xiaoqiang/oui.tar.gz"
OUI_FILEPATH = "/tmp/oui"

-- ==================== 版本信息获取命令 ====================

XQ_ROM_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.ROM"
XQ_ROM_HWVERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.HARDWARE_VERSION"
XQ_CHANNEL = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.CHANNEL"
XQ_HARDWARE = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.HARDWARE"
XQ_CFE_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.UBOOT"
XQ_KERNEL_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.LINUX"
XQ_RAMFS_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.RAMFS"
XQ_SQAFS_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.SQAFS"
XQ_ROOTFS_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.ROOTFS"
XQ_ISP_VERSION = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.ISPVER"
XQ_ISP_CODE = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.ISPCODE"
XQ_HW_VERSION = "/sbin/hwversion 2>/dev/null"
XQ_ROM_BUILDTIME = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.BUILDTS"
XQ_BETA = "uci -q get /usr/share/xiaoqiang/xiaoqiang_version.version.BETA"
XQ_DEVICE_ID = "uci -q get /etc/config/messaging.deviceInfo.DEVICE_ID"

-- 固件处理命令
XQ_CUT_IMAGE = "cd /tmp;multipartcutter -R -f "
XQ_VERIFY_IMAGE = "cd /tmp;mkxqimage -x "

-- ==================== WPS相关命令 ====================

OPEN_WPS = "wps pbc"
GET_WPS_STATUS = "wps status"
GET_WPS_CONMAC = "wps stamac"
CLOSE_WPS = "wps stop"

-- ==================== MAC地址获取命令 ====================

GET_DEFAULT_MACADDRESS = "getmac"
GET_DEFAULT_LAN_MACADDRESS = "getmac lan"
GET_DEFAULT_WAN_MACADDRESS = "getmac wan"
GET_DEFAULT_WAN2_MACADDRESS = "getmac wan2"

-- ==================== NVRAM/BDATA命令 ====================

GET_NVRAM_SN = "nvram get SN"
GET_BDATA_SN = "bdata get SN"
NVRAM_SET_UPGRADED = "nvram set flag_upgrade_push=1; nvram commit"

-- ==================== Nginx缓存控制 ====================

NGINX_CACHE_START = "/usr/sbin/sysapi TRAFFIC_CTL set NGINX_CACHE=on"
NGINX_CACHE_STOP = "/usr/sbin/sysapi TRAFFIC_CTL set NGINX_CACHE=off"
NGINX_CACHE_STATUS = "/usr/sbin/sysapi TRAFFIC_CTL get NGINX_CACHE"

-- ==================== MAC过滤控制 ====================

SET_LAN_BLACKLIST = "/usr/sbin/sysapi macfilter set lanmode=blacklist"
SET_LAN_WHITELIST = "/usr/sbin/sysapi macfilter set lanmode=whitelist"
SET_WAN_BLACKLIST = "/usr/sbin/sysapi macfilter set wanmode=blacklist"
SET_WAN_WHITELIST = "/usr/sbin/sysapi macfilter set wanmode=whitelist"
SET_ADMIN_BLACKLIST = "/usr/sbin/sysapi macfilter set admin=blacklist"
SET_ADMIN_WHITELIST = "/usr/sbin/sysapi macfilter set admin=whitelist"
GET_LAN_MODE = "/usr/sbin/sysapi macfilter get lanmode"
GET_WAN_MODE = "/usr/sbin/sysapi macfilter get wanmode"
GET_ADMIN_MODE = "/usr/sbin/sysapi macfilter get adminmode"
SET_WAN_ENABLE = "/usr/sbin/sysapi macfilter set wanenable=1"
SET_WAN_DISABLE = "/usr/sbin/sysapi macfilter set wanenable=0"

-- ==================== LAMP沙盒相关 ====================

LAMP_CREATE_SANDBOX = "/opt/lampmanager/create_sandbox.sh"
LAMP_IS_SANDBOX_CREATED = "/opt/lampmanager/is_sandbox_created.sh"
LAMP_MOUNT_THINGS = "/opt/lampmanager/mount_things.sh"
LAMP_UMOUNT_THINGS = "/opt/lampmanager/unmount_things.sh"
LAMP_ARE_THINGS_MOUNTED = "/opt/lampmanager/are_things_mounted.sh"
LAMP_START_DROPBEAR = "/opt/lampmanager/start_dropbear.sh"
LAMP_STOP_DROPBEAR = "/opt/lampmanager/stop_dropbear.sh"
LAMP_IS_DROPBEAR_STARTED = "/opt/lampmanager/is_dropbear_started.sh"

-- ==================== 系统监控命令 ====================

CPU_TEMPERATURE = "/usr/sbin/readtmp"
SIMPLE_NETWORK_DETECT = "/usr/sbin/networkdt -s "
SIMPLE_NETWORK_NOLOG_DETECT = "/usr/sbin/networkdt -s -n "
FULL_NETWORK_DETECT = "/usr/sbin/networkdt "

-- WiFi信道
WIFI_CHANNEL_24 = "wl -i wl1 chanspecs"
WIFI_CHANNEL_50 = "wl -i wl0 chanspecs"
WIFI24_WORK_CHANNEL = "wl -i wl1 chanspec | awk '{print $1}'"
WIFI50_WORK_CHANNEL = "wl -i wl0 chanspec | awk '{print $1}'"

-- WAN接口
GET_WAN_DEV = "ip route list 0/0 | grep -v tap | grep -v metric | awk '{print $5}'"

-- ==================== 升级相关 ====================

FLASH_EXECUTION_CHECK = "/bin/flash_check.sh"
FLASH_PID_TMP = "/tmp/pid_xxxx"
CRONTAB_PID_TMP = "/tmp/crontab_pid_xxxx"
CRONTAB_ROM_CHECK = "ps w | grep crontab_rom.sh | grep -v \"grep\" | wc -l"
CROM_FLASH_CHECK = "ps w | grep flash | grep customrom.bin | grep -v \"grep\" | wc -l"
DROM_FLASH_CHECK = "ps w | grep flash | grep rom.bin | grep -v \"grep\" | wc -l"
REBOOT_CHECK = "ps w | grep reboot | grep -v \"grep\" | wc -l"

-- 升级锁
UPGRADE_LOCK_FILE = "/tmp/upgrade_lock"
UPGRADE_STATUS = "cat " .. UPGRADE_LOCK_FILE
UPGRADE_LOCK = "/bin/touch " .. UPGRADE_LOCK_FILE
UPGRADE_UNLOCK = "/bin/rm " .. UPGRADE_LOCK_FILE
UPGRADE_LOCK_CHECK = "/bin/ls -l " .. UPGRADE_LOCK_FILE
UPGRADE_PID = "cat " .. CRONTAB_PID_TMP
UPGRADE_LUA_PID = "ps w | grep checkupgrade.lua | grep -v \"grep\" | awk '{print $1}'"

-- CPU信息
GET_CPU_CHIPPKG = "cat /proc/cpuinfo | grep b_chippkg | awk '{print $3}'"

-- 资源检查
DOWNLOAD_RESOURCE_CHECK = "wget -t3 -T10 --spider "
AVAILABLE_MEMERY = "df -k | grep \\ /tmp$ | awk '{print $4}' | sed -n '1p'"
AVAILABLE_DISK = "df -k | grep \\ /userdisk$ | awk '{print $4}' | sed -n '1p'"
DISK_SPACE = "df -k | grep \\ /userdisk$ | awk '{print $2}' | sed -n '1p'"

-- 设备统计
DEVICE_STATISTICS_LIST_LIMIT = 10

-- 系统负载
CPU_LOAD_AVG = "/usr/sbin/getstat.lua|cut -d'%' -f1"
MEMERY_USAGE = "free 2>/dev/null|awk '/Mem/{print substr($3/$2,0,4)}'"
WAN_LINK = "et robord 0x01 0x00 2>/dev/null|awk -F':' '/port 4/{print$2}'"
WAN_UP = "cat /tmp/wan.monitor.stat | grep WANLINKSTAT=UP | wc -l"

-- LED控制
UPDATE_LED_FLASH_ALERT_ENABLE = "updateledfliker"
UPDATE_LED_FLASH_ALERT_DISABLE = "killupdateled"

-- ==================== VPN相关 ====================

VPN_ENABLE = "/usr/sbin/vpn.lua up"
VPN_DISABLE = "/usr/sbin/vpn.lua down"
VPN_STATUS = "/usr/sbin/vpn.lua status"
RM_VPNSTATUS_FILE = "/bin/rm /tmp/vpn.stat.msg.last >/dev/null 2>/dev/null"
SET_VPN_USER_OPTION = "uci -q -P /var/state set network.vpn.user_option="

-- GPIO
GPIO_VALUE = "gpio %s | awk -F': <' '{print$2}'| awk -F'>' '{print$1}'"

-- ==================== UPnP相关 ====================

UPNP_STATUS = "/etc/init.d/miniupnpd enabled"
UPNP_ENABLE = "/etc/init.d/miniupnpd enable ; /etc/init.d/miniupnpd start ;"
UPNP_DISABLE = "/etc/init.d/miniupnpd stop ; /etc/init.d/miniupnpd disable ;"
UPNP_LEASE_FILE = "uci get upnpd.config.upnp_lease_file"

-- ==================== QoS相关 ====================

QOS_APPSL_ENABLE = "/etc/init.d/app-tc.d on"
QOS_APPSL_DISABLE = "/etc/init.d/app-tc.d off"
QOS_APPSL_RELOAD = "/etc/init.d/app-tc.d restart"

-- 升级信息缓存
UPGRADE_INFO_CACHE = "upgrade_info_cache"
UPGRADE_INFO_EXPIRE = 600

-- ==================== Thrift隧道 ====================

THRIFT_TUNNEL_TO_DATACENTER = "thrifttunnel 0 '%s'"
THRIFT_TUNNEL_TO_SMARTHOME = "thrifttunnel 1 '%s'"
THRIFT_TUNNEL_TO_SMARTHOME_CONTROLLER = "thrifttunnel 2 '%s'"
THRIFT_TO_MQTT_IDENTIFY_DEVICE = "thrifttunnel 3 ''"
THRIFT_TO_MQTT_GET_SN = "thrifttunnel 4 ''"
THRIFT_TO_MQTT_GET_DEVICEID = "thrifttunnel 5 ''"
THRIFT_TUNNEL_TO_MIIO = "thrifttunnel 6 '%s'"
THRIFT_TUNNEL_TO_YEELINK = "thrifttunnel 7 '%s'"
THRIFT_TUNNEL_TO_CACHECENTER = "thrifttunnel 8 '%s'"
TUNNEL_TOOL = "/opt/filetunnel/tunneltool --payload '%s'"

-- Flash权限
SET_FLASH_PERMISSION = "nvram set flag_flash_permission="
GET_FLASH_PERMISSION = "nvram get flag_flash_permission"

-- WiFi日志
WIIF_LOG_TMP_FILEPATH = "/tmp/wifi.log"
WIFI_LOG_COLLECTION = "/sbin/wifi_analyze.sh >> " .. WIIF_LOG_TMP_FILEPATH

-- ==================== SIM卡/CPE配置 ====================

XQ_SIM_CONFIG_NAME = "mobile"
XQ_SIM_MANAGE_TYPE = "management"
XQ_SIM_MANAGE_SECTION = "common"
XQ_SIM_APNFILE_TYPE = "apnfile"

-- SIM网络配置键
SIM_NET_DATA = "networkdata"
SIM_NET_ROAM = "networkroam"
SIM_NET_AUTO = "networkauto"
SIM_NET_TYPE = "networktype"

-- APN配置键
SIM_APN_TOTAL = "apntotal"
SIM_APN_MAX = "apnmaxnum"
SIM_APN_EFFECTIVE = "apncurid"
SIM_AUTO_PIN = "autopin"
SIM_PIN_TMP = "pin"
SIM_PIN_CORRECT = "ispincorrect"
SIM_APN_FILEID = "id"
SIM_APN_FILENAME = "file"
SIM_APN_PDPTYPE = "pdp"
SIM_APN_APNTYPE = "apn"
SIM_APN_USERNAME = "user"
SIM_APN_PASSWORD = "passwd"
SIM_APN_ENCRYPTION = "encryption"
SIM_APN_INDEX = "index"

-- SIM限制
SIM_PIN_MAX_RETRY = 3
SIM_PUK_MAX_RETRY = 10
SIM_APN_MAX_NUMBER = 8

-- CPE初始化配置
CPE_INIT_CONFIG = "xiaoqiang"
CPE_INIT_SECTION = "common"
CPE_INIT_STEP = "INITSTEP"
CPE_QUICK_STEP = "QUICKSTEP"
CPE_INIT_STATUS = "INITTED"
