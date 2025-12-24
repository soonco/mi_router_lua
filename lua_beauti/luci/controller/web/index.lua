---
--- 小米路由器Web管理界面模块
--- 模块路径: luci.controller.web.index
---
--- 功能概述:
---   提供路由器Web管理界面的所有页面路由配置
---   根据不同的网络模式(路由器/中继/Mesh)显示不同的界面
---
--- 页面分类:
---   - 首页: /web/home - 路由器状态概览
---   - 初始化: /web/init/* - 首次设置向导
---   - 设置: /web/setting/* - 路由器设置页面
---   - 高级设置: /web/prosetting/* - 高级功能设置
---   - 中继设置: /web/apsetting/* - AP/中继模式设置
---   - 存储: /web/store/* - 存储管理(可选)
---   - 系统: /web/syslock, /web/upgrading - 系统锁定/升级页面
---
--- 依赖模块:
---   - luci.util: 工具函数
---   - luci.template: 模板渲染
---   - luci.dispatcher: 路由调度
---   - luci.sauth: 会话认证
---   - xiaoqiang.util.XQSysUtil: 系统工具
---   - xiaoqiang.common.XQFunction: 通用函数
---   - xiaoqiang.XQFeatures: 功能特性配置
---

module("luci.controller.web.index", package.seeall)

--- 模块路由注册入口
--- 根据设备状态和网络模式配置不同的页面路由
function index()
    --- 配置根节点
    local rootNode = node()
    if not rootNode.target then
        rootNode.target = alias("web")
        rootNode.index = true
    end

    --- 创建Web管理节点
    local webNode = node("web")
    webNode.target = firstchild()
    webNode.title = _("")
    webNode.order = 10
    webNode.sysauth = "admin"
    webNode.mediaurlbase = "/xiaoqiang/web"
    webNode.sysauth_authenticator = "htmlauth"
    webNode.index = true

    local LuciUtil = require("luci.util")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local hardwareInfo = XQSysUtil.getMiscHardwareInfo()

    local XQFunction = require("xiaoqiang.common.XQFunction")
    local netModeType = XQFunction.getNetModeType()

    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES

    --- 首页路由
    entry({"web"}, alias("web", "home"), _("路由器状态"), 10, 8)
    entry({"web", "logout"}, call("action_logout"), 11, 9)

    --- 根据设备状态选择首页模板
    --- recovery=1: 恢复模式
    --- netModeType=0: 路由器模式
    --- netModeType=1: 中继模式
    --- netModeType=3: Mesh模式
    if hardwareInfo.recovery == 1 then
        entry({"web", "home"}, template("web/recovery"), _("路由器状态"), 12)
    elseif netModeType == 0 then
        entry({"web", "home"}, template("web/index"), _("路由器状态"), 12)
    elseif netModeType == 1 then
        entry({"web", "home"}, template("web/apindex"), _("路由器状态"), 12)
    elseif netModeType == 3 then
        entry({"web", "home"}, template("web/apindex"), _("路由器状态"), 12)
    else
        entry({"web", "home"}, template("web/apindex"), _("路由器状态"), 12)
    end

    --- 初始化向导页面
    entry({"web", "init"}, alias("web", "init", "guidetoapp"), _("初始化向导"), 13)
    entry({"web", "init", "hello"}, call("action_hello"), _("欢迎页面"), 14, 9)
    entry({"web", "init", "agreement"}, template("web/init/agreement"), _("用户协议"), 14, 9)
    entry({"web", "init", "privacy"}, template("web/init/privacy"), _("用户体验改进计划"), 14, 9)
    entry({"web", "init", "guide"}, template("web/init/guide"), _("向导模式"), 15, 8)
    entry({"web", "init", "guidetoapp"}, template("web/init/guidetoapp"), _("引导app"), 15, 9)
    entry({"web", "init", "guideuninit"}, template("web/init/guidetoapp_uninit"), _("引导app"), 15, 9)
    entry({"web", "init", "bind"}, template("web/init/bind"), _("引导app"), 15, 9)

    --- 基础设置页面
    entry({"web", "setting"}, alias("web", "setting", "upgrade"), _("路由设置"), 20)
    entry({"web", "setting", "upgrade"}, template("web/setting/upgrade"), _("路由手动升级"), 21)
    entry({"web", "setting", "wifi"}, template("web/setting/wifi"), _("Wi-Fi设置"), 22)
    entry({"web", "setting", "wan"}, template("web/setting/wan"), _("外网设置"), 23)
    entry({"web", "setting", "proset"}, template("web/setting/proset"), _("高级设置"), 24)
    entry({"web", "setting", "lannetset"}, template("web/setting/lannetset"), _("局域网设置"), 25)
    entry({"web", "setting", "safe"}, template("web/setting/safe"), _("安全中心"), 26)

    --- 高级设置页面
    entry({"web", "prosetting"}, alias("web", "prosetting", "qos"), _("路由设置"), 40)
    entry({"web", "prosetting", "dhcpipmacband"}, template("web/setting/dhcp_ip_mac"), _("DHCP静态IP分配"), 41)
    entry({"web", "prosetting", "dmz"}, template("web/setting/dmz"), _("DMZ"), 42)
    entry({"web", "prosetting", "nat"}, template("web/setting/nat_dmz"), _("端口转发"), 43)
    entry({"web", "prosetting", "upnp"}, template("web/setting/upnp"), _("upnp"), 44)
    entry({"web", "prosetting", "ddns"}, template("web/setting/ddns"), _("DDNS"), 45)
    entry({"web", "prosetting", "vpn"}, template("web/setting/vpn"), _("VPN"), 46)
    entry({"web", "prosetting", "qos"}, call("action_qos"), _("智能限速QoS"), 47)
    entry({"web", "prosetting", "iptv"}, template("web/setting/iptv"), _("iptv"), 48)

    --- 网口自定义功能(可选)
    if FEATURES.apps and FEATURES.apps.ports_custom == "1" then
        entry({"web", "prosetting", "networkportcustom"}, template("web/setting/network_port_custom"), _("网口自定义"), 49)
    end

    --- 中继/AP模式设置页面
    entry({"web", "apsetting"}, alias("web", "apsetting", "upgrade"), _("中继设置"), 60)
    entry({"web", "apsetting", "upgrade"}, template("web/apsetting/upgrade"), _("中继系统信息"), 61)
    entry({"web", "apsetting", "wan"}, template("web/apsetting/wan"), _("中继模式切换"), 62)
    entry({"web", "apsetting", "safe"}, template("web/apsetting/safe"), _("中继密码设置"), 63)
    entry({"web", "apsetting", "wifi"}, call("action_apwifi"), _("中继Wi-Fi设置"), 64)
    entry({"web", "apsetting", "roam"}, template("web/apsetting/roam"), _("roam"), 65)
    entry({"web", "apsetting", "lannetset"}, template("web/apsetting/lannetset"), _("lannetset"), 65)

    --- 存储管理页面(可选)
    if FEATURES.apps and FEATURES.apps.storage == "1" then
        entry({"web", "store"}, alias("web", "store", "storesetting"), _("存储状态"), 90)
        entry({"web", "store", "storesetting"}, template("web/inc/store"), _("存储设置"), 90)
    end

    --- Docker管理页面(可选)
    if FEATURES.apps and FEATURES.apps.docker == "1" then
        entry({"web", "store", "docker"}, template("web/inc/docker"), _("docker"), 90)
    end

    --- 系统页面
    entry({"web", "syslock"}, template("web/syslock"), _("路由升级"), 100)
    entry({"web", "upgrading"}, template("web/syslock"), _("路由升级"), 101, 13)
    entry({"web", "webinitrdr"}, call("action_webinitrdr"), _(""), 110, 9)
    entry({"web", "login"}, template("web/sysauth"), _(""), 111)
    entry({"web", "ieblock"}, template("web/ieblock"), _(""), 120, 9)
    entry({"web", "topo"}, template("web/topograph"), _(""), 130, 13)
end

--- 中继模式WiFi设置页面
--- 根据网络模式选择不同的模板
function action_apwifi()
    local template = require("luci.template")
    local XQFunction = require("xiaoqiang.common.XQFunction")

    local netModeType = XQFunction.getNetModeType()

    if netModeType == 1 then
        template.render("web/apsetting/wifi", {})
    else
        template.render("web/setting/wifi", {})
    end
end

--- QoS设置页面
--- 根据功能配置选择完整版或精简版QoS页面
function action_qos()
    local template = require("luci.template")
    local XQFeatures = require("xiaoqiang.XQFeatures")
    local FEATURES = XQFeatures.FEATURES

    if FEATURES.apps.qos == "1" then
        template.render("web/setting/qos", {})
    else
        template.render("web/setting/qos_lite", {})
    end
end

--- 登出操作
--- 销毁当前会话并重定向到首页
function action_logout()
    local dispatcher = require("luci.dispatcher")
    local sauth = require("luci.sauth")

    --- 销毁会话
    if dispatcher.context.authsession then
        sauth.kill(dispatcher.context.authsession)
        dispatcher.context.urltoken.stok = nil
    end

    --- 重定向到首页
    luci.http.redirect(luci.dispatcher.build_url())
end

--- 欢迎页面(初始化检查)
--- 检查路由器是否已初始化，未初始化则显示欢迎页面
function action_hello()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

    local initInfo = XQSysUtil.getInitInfo()

    if initInfo then
        --- 已初始化，重定向到首页
        luci.http.redirect(luci.dispatcher.build_url())
    else
        --- 未初始化，设置默认密码并显示欢迎页面
        XQSysUtil.setSysPasswordDefault()
    end

    local template = require("luci.template")
    template.render("web/init/hello")
end

--- Web初始化重定向
--- 返回初始化提示信息
function action_webinitrdr()
    local result = {code = 0}
    local data = {
        s1 = _("你连接的路由器还未初始化"),
        s2 = _("请稍候，会自动为你跳转到向导页面..."),
        s3 = _("如果未能跳转，请直接访问"),
        s4 = _("欢迎使用小米路由器")
    }
    result.data = data

    luci.http.write_json(result)
end
