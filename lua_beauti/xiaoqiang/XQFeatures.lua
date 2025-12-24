--[[
  小米路由器功能特性配置模块
  
  功能说明:
  - 定义路由器支持的功能特性
  - 用于功能开关控制
  - 不同型号路由器可能有不同的特性配置
  
  特性值说明:
  - "0": 功能禁用
  - "1": 功能启用
  - 其他数值: 特殊配置值
  
  特性分类:
  - system: 系统级功能
  - wifi: WiFi相关功能
  - apmode: AP模式功能
  - netmode: 网络模式功能
  - apps: 应用功能
  - hardware: 硬件功能
]]

module("xiaoqiang.XQFeatures")

FEATURES = {}

-- ==================== 系统级功能 ====================
FEATURES.system = {
    shutdown = "0",              -- 关机功能 (0=禁用)
    downloadlogs = "0",          -- 下载日志功能 (0=禁用)
    i18n = "0",                  -- 国际化支持 (0=禁用)
    infileupload = "1",          -- 文件上传功能 (1=启用)
    task = "0",                  -- 任务管理功能 (0=禁用)
    upnp = "1",                  -- UPnP功能 (1=启用)
    new_update = "1",            -- 新版本更新检测 (1=启用)
    multiwan = "1",              -- 多WAN支持 (1=启用)
    support_1000_dhcp = "1",     -- 支持1000个DHCP客户端 (1=启用)
    ipv6_wired = "0",            -- IPv6有线支持 (0=禁用)
    ipv6_wired_v2 = "1",         -- IPv6有线支持v2 (1=启用)
    ipv6_passthrough_relay = "1", -- IPv6透传/中继 (1=启用)
    mesh_bhtype_mode = "1",      -- Mesh回程类型模式 (1=启用)
    ipmaccheck = "1"             -- IP/MAC绑定检查 (1=启用)
}

-- ==================== WiFi相关功能 ====================
FEATURES.wifi = {
    wifi24 = "1",                -- 2.4GHz WiFi (1=启用)
    wifi50 = "1",                -- 5GHz WiFi (1=启用)
    wifiguest = "1",             -- 访客WiFi (1=启用)
    wifimerge = "1",             -- WiFi双频合一 (1=启用)
    wifi_mu_mimo = "1",          -- MU-MIMO支持 (1=启用)
    twt = "1",                   -- Target Wake Time (WiFi 6) (1=启用)
    mlo = "1",                   -- Multi-Link Operation (WiFi 7) (1=启用)
    iot_dev = "1",               -- IoT设备专用网络 (1=启用)
    silence_switch = "1",        -- 静音开关 (1=启用)
    wifi_access_ctl = "1"        -- WiFi访问控制 (1=启用)
}

-- ==================== AP模式功能 ====================
FEATURES.apmode = {
    wifiapmode = "1",            -- WiFi AP模式 (1=启用)
    lanapmode = "1"              -- 有线AP模式 (1=启用)
}

-- ==================== 网络模式功能 ====================
FEATURES.netmode = {
    elink = "0",                 -- eLink功能 (0=禁用)
    ["net2.5G"] = "1",           -- 2.5G网口支持 (1=启用)
    net10G = "1"                 -- 10G网口支持 (1=启用)
}

-- ==================== 应用功能 ====================
FEATURES.apps = {
    apptc = "0",                 -- 应用流量控制 (0=禁用)
    qos = "1",                   -- QoS功能 (1=启用)
    dhcpMsg = "1",               -- DHCP消息 (1=启用)
    upnp = "1",                  -- UPnP功能 (1=启用)
    nfc = "1",                   -- NFC功能 (1=启用)
    wanLan = "1",                -- WAN/LAN切换 (1=启用)
    mipctlv2 = "1",              -- MIPCTL v2 (1=启用)
    lanPort = "1",               -- LAN端口管理 (1=启用)
    xqdatacenter = "1",          -- 小米数据中心 (1=启用)
    baidupan = "1",              -- 百度网盘 (1=启用)
    timemachine = "1",           -- Time Machine备份 (1=启用)
    storage = "1",               -- 存储功能 (1=启用)
    samba = "1",                 -- Samba文件共享 (1=启用)
    docker = "1",                -- Docker支持 (1=启用)
    swapmask = "7",              -- 交换掩码配置
    ports_custom = "1",          -- 端口自定义 (1=启用)
    LED_control = "7",           -- LED控制模式
    download = "0",              -- 下载功能 (0=禁用)
    temp_control = "1",          -- 温度控制 (1=启用)
    sfp = "1",                   -- SFP光口支持 (1=启用)
    game_port = "1",             -- 游戏端口优化 (1=启用)
    lan_lag = "1",               -- LAN端口聚合 (1=启用)
    local_gw_security = "1",     -- 本地网关安全 (1=启用)
    sec_center = "2",            -- 安全中心版本
    firewall = "1"               -- 防火墙功能 (1=启用)
}

-- ==================== 硬件功能 ====================
FEATURES.hardware = {
    usb = "1",                   -- USB接口 (1=启用)
    usb_deploy = "0",            -- USB部署功能 (0=禁用)
    disk = "0"                   -- 内置硬盘 (0=无)
}
